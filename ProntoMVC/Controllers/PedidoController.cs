using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;


using System.Data.Entity.Core.Objects;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Text;
using System.Reflection;
using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Web.Security;

using Pronto.ERP.Bll;

using System.Linq;
using System.Linq.Dynamic;
using System.Web.Mvc;
//using jqGridWeb.Models;
using ProntoMVC.Data.Models;
using ClassLibrary2;
using ProntoMVC.Models;
using System.Data.Entity.Core.Objects; // using System.Data.Entity.Core.Objects;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Text;
using System;
using System.Reflection;


using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;//using DocumentFormat.OpenXml.Spreadsheet;
//using OpenXmlPowerTools;
using System.Diagnostics;
using ClosedXML.Excel;
using System.IO;
using System.Configuration;

namespace ProntoMVC.Controllers
{

    // [Authorize(Roles = "Administrador,SuperAdmin,Compras")] //ojo que el web.config tambien te puede bochar hacia el login

    public partial class PedidoController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.Pedidos)) throw new Exception("No tenés permisos");


            if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
                ) throw new Exception("No tenés permisos");

            //var Pedidos = db.Pedidos.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }
        public virtual ViewResult IndexExterno()
        {
            if (!PuedeLeer(enumNodos.Pedidos)) throw new Exception("No tenés permisos");

            //var Pedidos = db.Pedidos.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }
        public virtual ViewResult Details(int id)
        {
            Pedido Pedido = db.Pedidos.Find(id);
            return View(Pedido);
        }

        public virtual FileResult ImprimirConPlantillaEXE_PDF(int id)
        {
            string DirApp = AppDomain.CurrentDomain.BaseDirectory;
            string output = DirApp + "Documentos\\" + "archivo.pdf";
            string plantilla = DirApp + "Documentos\\" + "Pedido_" + this.HttpContext.Session["BasePronto"].ToString() + ".dotm";

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var s = new ServicioMVC.servi();
            string mensajeError;
            s.ImprimirConPlantillaEXE(id, SC, DirApp, plantilla, output, out mensajeError);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            string nombrearchivo = "pedido.pdf";
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, nombrearchivo);
        }

        public virtual FileResult ImprimirConPlantillaEXE(int id)
        {
            string DirApp = AppDomain.CurrentDomain.BaseDirectory;
            string output = DirApp + "Documentos\\" + "archivo.doc";
            string plantilla = DirApp + "Documentos\\" + "Pedido_" + this.HttpContext.Session["BasePronto"].ToString() + ".dotm";

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var s = new ServicioMVC.servi();
            string mensajeError;
            s.ImprimirConPlantillaEXE(id, SC, DirApp, plantilla, output, out mensajeError);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            string nombrearchivo = "pedido.doc";
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, nombrearchivo);
        }

        public virtual FileResult Imprimir(int id, bool bAgruparItems = false) //(int id)
        {
            // string sBasePronto = (string)rc.HttpContext.Session["BasePronto"];
            // db = new DemoProntoEntities(Funciones.Generales.sCadenaConex(sBasePronto));

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            //  string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString);
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.docx"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';

            //string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Requerimiento1_ESUCO_PUNTONET.docx";
            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Pedido_" + this.HttpContext.Session["BasePronto"].ToString() + "_PUNTONET.docx";
            //string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Pedido_ESUCO_PUNTONET.docx";

            ErrHandler.WriteError(plantilla);
            CartaDePorteManager.MandarMailDeError(plantilla);

            System.IO.FileInfo MyFile2 = new System.IO.FileInfo(plantilla);//busca si ya existe el archivo a generar y en ese caso lo borra

            if (!MyFile2.Exists)
            {
                //usar la de sql
                try
                {
                    plantilla = Pronto.ERP.Bll.OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.FacturaA, SC);

                }
                catch (Exception e)
                {
                    ErrHandler.WriteError(e);
                }
            }

            ErrHandler.WriteError(plantilla);
            CartaDePorteManager.MandarMailDeError(plantilla);

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            System.IO.File.Copy(plantilla, output); // 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 
            //Pronto.ERP.BO.Factura fac = FacturaManager.GetItem(SC, id, true);
            //OpenXML_Pronto.FacturaXML_DOCX(output, fac, SC);

            var c = PedidoXMLplantilla_DOCX_MVC_ConTags(output, SC, id, bAgruparItems);
            //Pronto.ERP.BO.Pedido req = pedido PedidoManager.GetItem(SC, id, true);
            //OpenXML_Pronto.PedidoXML_DOCX(output, req, SC);


            //byte[] contents = ;
            //return File(contents, "application/octet-stream");

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "pedido.docx");
        }

        public virtual FileResult ImprimirPDF(int id, String output2 = "") //(int id)
        {
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            string output = "";
            if (output2.Length > 0)
            {
                output = output2;
            }
            else
            {
                output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.pdf"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            }

            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Pedido_" + this.HttpContext.Session["BasePronto"].ToString() + ".dotm";

            System.IO.FileInfo MyFile2 = new System.IO.FileInfo(plantilla);//busca si ya existe el archivo a generar y en ese caso lo borra

            if (!MyFile2.Exists)
            {
                plantilla = Pronto.ERP.Bll.OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.FacturaA, SC);
            }

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            object nulo = null;
            EntidadManager.ImprimirWordDOT_VersionDLL_PDF(plantilla, ref nulo, SC, nulo, ref nulo, id, nulo, nulo, nulo, output, nulo, nulo);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "pedido.pdf");
        }

        void MarcaDeAgua(ref string cadena)
        {
            regexReplace(ref cadena, "#Empresa#", "BORRADOR");
        }

        public WordprocessingDocument PedidoXMLplantilla_DOCX_MVC_ConTags(string document, string SC, int id, bool bAgruparItems = false)
        {
            Pedido oFac = db.Pedidos
                    .Include(x => x.DetallePedidos.Select(y => y.Unidad))
                    .Include(x => x.DetallePedidos.Select(y => y.Articulo))
                // .Include(x => x.DetallePedidos.Select(y => y.Moneda))
                //.Include(x => x.DetallePedidos. .moneda)
                // .Include("DetallePedidos.Unidad") // funciona tambien
                    .Include(x => x.Proveedor)
                    .Include(x => x.Proveedor.DescripcionIva)
                    .Include(x => x.Comprador)

                  .SingleOrDefault(x => x.IdPedido == id);


            List<DetallePedido> det = db.DetallePedidos
                        .Where(x => x.IdPedido == id)
                        .Include(x => x.Unidad)
                        .Include(x => x.ControlesCalidad)
                        .Include(x => x.DetalleRequerimiento.Requerimientos)
                        .Include(x => x.DetalleRequerimiento.Requerimientos.Obra)
                        .ToList()
                        ;

            //using (doc = WordprocessingDocument.Open(xlt, true))
            //{
            //}

            WordprocessingDocument wordDoc = WordprocessingDocument.Open(document, true);

            OpenXmlPowerTools.SimplifyMarkupSettings settings = new OpenXmlPowerTools.SimplifyMarkupSettings();
            var _with1 = settings;
            _with1.RemoveComments = true;
            _with1.RemoveContentControls = true;
            _with1.RemoveEndAndFootNotes = true;
            _with1.RemoveFieldCodes = false;
            _with1.RemoveLastRenderedPageBreak = true;
            _with1.RemovePermissions = true;
            _with1.RemoveProof = true;
            _with1.RemoveRsidInfo = true;
            _with1.RemoveSmartTags = true;
            _with1.RemoveSoftHyphens = true;
            _with1.ReplaceTabsWithSpaces = true;
            OpenXmlPowerTools.MarkupSimplifier.SimplifyMarkup(wordDoc, settings);

            if (bAgruparItems)
            {
                det = (from i in det
                       group i by new { i.Articulo, i.Unidad, i.Observaciones }
                           into grp
                           select new DetallePedido
                           {
                               Articulo = grp.Key.Articulo,
                               Unidad = grp.Key.Unidad,
                               Observaciones = grp.Key.Observaciones,

                               Cantidad = grp.Sum(t => t.Cantidad),
                               Precio = grp.Sum(t => t.Precio),
                               ImporteTotalItem = grp.Sum(t => t.ImporteTotalItem),
                               ImporteIva = grp.Sum(t => t.ImporteIva),

                               PorcentajeIVA = grp.First().PorcentajeIVA,
                               PorcentajeBonificacion = grp.First().PorcentajeBonificacion,


                               OrigenDescripcion = grp.First().OrigenDescripcion,
                               FechaEntrega = grp.First().FechaEntrega,
                               FechaNecesidad = grp.First().FechaNecesidad,
                               Adjunto = grp.First().Adjunto,
                               IdControlCalidad = grp.First().IdControlCalidad,
                               DetalleRequerimiento = grp.First().DetalleRequerimiento
                           }
                       ).ToList();
            }

            //            cómo me traigo las obras en las que esta?...
            //                puedo usar un store de detalle, o llamar a la coleccion de navegacion...

            using ((wordDoc))
            {
                string docText = null;
                StreamReader sr = new StreamReader(wordDoc.MainDocumentPart.GetStream());

                using ((sr))
                {
                    docText = sr.ReadToEnd();
                }

                if ((oFac.Aprobo ?? 0) > 0) MarcaDeAgua(ref docText);

                ///////////////////////////////
                ///////////////////////////////
                //ENCABEZADO
                //Hace el reemplazo
                ///////////////////////////////
                var _with2 = oFac;


                ///////////////////////////////
                ///////////////////////////////
                ///////////////////////////////

                DataRow x = EntidadManager.GetStoreProcedureTop1(SC, ProntoFuncionesGenerales.enumSPs.Empresa_TX_Datos);

                regexReplace(ref docText, "#Empresa#", x["Nombre"].NullSafeToString());
                regexReplace(ref docText, "#DetalleEmpresa#", x["DetalleNombre"].NullSafeToString());
                regexReplace(ref docText, "#DireccionCentral#", x["Direccion"].NullSafeToString()
                                                            + x["Localidad"].NullSafeToString() + x["CodigoPostal"].NullSafeToString() + x["Provincia"].NullSafeToString()
                                                        );

                regexReplace(ref docText, "#DireccionPlanta#", x["DatosAdicionales1"].NullSafeToString() + "CUIT: " + x["Cuit"].NullSafeToString());
                regexReplace(ref docText, "#TelefonosEmpresa#", x["Telefono1"].NullSafeToString() + " FAX: " + x["Telefono2"].NullSafeToString());

                /// datos del comprador

                regexReplace(ref docText, "#Comprador#", (oFac.Comprador ?? new Empleado()).Nombre.NullSafeToString());
                regexReplace(ref docText, "#EmailComprador#", (oFac.Comprador ?? new Empleado()).Email.NullSafeToString());
                regexReplace(ref docText, "#TelefonoComprador#", (oFac.Comprador ?? new Empleado()).Interno.NullSafeToString());
                regexReplace(ref docText, "#FaxComprador#", "");

                regexReplace(ref docText, "#Proveedor#", oFac.Proveedor.RazonSocial);
                regexReplace(ref docText, "#CodigoCliente#", oFac.Proveedor.CodigoProveedor.NullSafeToString());
                regexReplace(ref docText, "#Direccion#", oFac.Proveedor.Direccion); // 'oFac.Domicilio)
                regexReplace(ref docText, "#Localidad#", (oFac.Proveedor.Localidad ?? new Localidad()).Nombre.NullSafeToString()); // 'oFac.Domicilio)

                regexReplace(ref docText, "#Telefono#", oFac.Proveedor.Telefono1); // 'oFac.Domicilio)
                regexReplace(ref docText, "#Contacto#", oFac.Proveedor.Contacto); // 'oFac.Domicilio)
                regexReplace(ref docText, "#EmailProveedor#", oFac.Proveedor.Email); // 'oFac.Domicilio)
                regexReplace(ref docText, "#Fax#", oFac.Proveedor.Fax); // 'oFac.Domicilio)

                regexReplace(ref docText, "#CuitProveedor#", oFac.Proveedor.Cuit);

                regexReplace(ref docText, "#Numero#", oFac.NumeroPedido.ToString() + " / " + oFac.SubNumero.NullSafeToString());
                regexReplace(ref docText, "#Fecha#", (oFac.FechaPedido ?? new DateTime()).ToShortDateString());

                regexReplace(ref docText, "#CondicionIVA#", oFac.Proveedor.DescripcionIva.Descripcion.NullSafeToString());
                //regexReplace(ref docText, "#CondicionVenta#", oFac.CondicionVentaDescripcion.NullSafeToString());
                //regexReplace(ref docText, "#CAE#", oFac.CAE.NullSafeToString())

                regexReplace(ref docText, "#Observaciones#", oFac.Observaciones);

                regexReplace(ref docText, "#AclaracionCondicion#", oFac.DetalleCondicionCompra);

                //regexReplace(ref docText, "#Detalle#", oFac.Detalle.NullSafeToString());

                //regexReplace(ref docText, "#Solicito#", oFac.Solicito.NullSafeToString());
                //regexReplace(ref docText, "#Sector#", oFac.Sector.NullSafeToString());

                regexReplace(ref docText, "#Tipo#", "Obra");
                // oFac.tipo) obra
                //regexReplace(ref docText, "#TipoDes#", NombreObra(SC, _with2.IdObra));
                // oFac.TipoDes) codigo obra
                regexReplace(ref docText, "#TipoDes1#", "");
                // NombreObr(SC, .IdObra)) 'oFac.TipoDes1) nombre obra

                regexReplace(ref docText, "#NumeroComparativa#", oFac.NumeroComparativa.NullSafeToString());
                regexReplace(ref docText, "#Subtotal#", ProntoFuncionesGenerales.FF2((double)((oFac.TotalPedido ?? 0) - (oFac.TotalIva1 ?? 0))));
                regexReplace(ref docText, "#IVA#", ProntoFuncionesGenerales.FF2((double)(oFac.TotalIva1 ?? 0)));
                //regexReplace(ref docText, "#IIBB#", ProntoFuncionesGenerales.FF2((double)oFac.));
                regexReplace(ref docText, "#boniftot#", ProntoFuncionesGenerales.FF2((double)(oFac.Bonificacion ?? 0)));
                regexReplace(ref docText, "#subtotalgrav#", ProntoFuncionesGenerales.FF2((double)((oFac.TotalPedido ?? 0) - (oFac.TotalIva1 ?? 0) - (oFac.Bonificacion ?? 0))));
                regexReplace(ref docText, "#Total#", ProntoFuncionesGenerales.FF2((double)(oFac.TotalPedido ?? 0)));

                regexReplace(ref docText, "#moneda#", (oFac.Moneda ?? new Moneda()).Nombre.NullSafeToString());

                regexReplace(ref docText, "#Importante#", oFac.ImprimeImportante == "NO" ? "" : "00 - Importante: " + oFac.Importante.NullSafeToString());
                regexReplace(ref docText, "#PlazoEntrega#", oFac.ImprimePlazoEntrega == "NO" ? "" : "01 - Plazo de Entrega: " + oFac.PlazoEntrega.NullSafeToString());
                regexReplace(ref docText, "#LugarEntrega#", oFac.ImprimeLugarEntrega == "NO" ? "" : "02 - Lugar de Entrega: " + oFac.LugarEntrega.NullSafeToString());
                regexReplace(ref docText, "#FormaPago#", oFac.ImprimeFormaPago == "NO" ? "" : "03 - Forma de Pago: " + oFac.FormaPago.NullSafeToString());
                regexReplace(ref docText, "#Garantia#", oFac.ImprimeGarantia == "NO" ? "" : "06 - Garantia: " + oFac.Garantia.NullSafeToString());
                regexReplace(ref docText, "#Documentacion#", oFac.ImprimeDocumentacion == "NO" ? "" : "07 - Documentacion: " + oFac.Documentacion.NullSafeToString());


                StreamWriter sw = new StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create));
                using ((sw))
                {
                    sw.Write(docText);
                }

                //CUERPO  (repetir renglones)
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //http://msdn.microsoft.com/en-us/library/cc850835(office.14).aspx
                /////////////////////////////////////////////////////////////////////////////////////
                //   http://stackoverflow.com/a/3783607/1054200
                //@Matt S: I've put in a few extra links that should also help you get started. There are a number of ways 
                //to do repeaters with Content Controls - one is what you mentioned. The other way is to use Building Blocks. 
                //Another way is to kind of do the opposite of what you mentioned - put a table with just a header row and then 
                //create rows populated with CCs in the cells (creo que esto es lo que hago yo). Do take a look 
                //at the Word Content Control Kit as well - that will save your life in working with CCs until you 
                //become much more familiar. – Otaku Sep 25 '10 at 15:46
                ///////////////////////////////////////////////////////////////////////////////////////
                //  'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                ////////////////////////////////////////////////////
                //en VBA, Edu busca el sector así:     Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
                //http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                ////////////////////////////////////////////////////////////

                ////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////
                //busco el primer renglon de la tabla de detalle
                ////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////
                dynamic tempParent = null;

                //busco el bookmark Detalles
                dynamic bookmarkDetalles = (from bookmark in wordDoc.MainDocumentPart.Document.Body.Descendants<BookmarkStart>()
                                            where (bookmark.Name == "Detalles" || bookmark.Name == "Detalle")
                                            select bookmark).FirstOrDefault();

                //... o tambien el tag Descripcion
                dynamic placeholderCANT = (from bookmark in wordDoc.MainDocumentPart.Document.Body.Descendants<Text>() where bookmark.Text == "#Descripcion#" select bookmark).FirstOrDefault();


                if ((placeholderCANT != null))
                {
                    tempParent = placeholderCANT.Parent;
                }
                else
                {
                    tempParent = bookmarkDetalles.Parent;
                }

                //qué tabla contiene al bookmark "Detalles"? (es el que usa Edu en VBA)
                Table table = default(Table);

                // Find the second row in the table.
                TableRow row1 = default(TableRow);
                //= table.Elements(Of TableRow)().ElementAt(0)
                TableRow row2 = default(TableRow);
                //= table.Elements(Of TableRow)().ElementAt(1)

                //http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                // loop till we get the containing element in case bookmark is inside a table etc.
                // keep checking the element's parent and update it till we reach the Body
                //Dim tempParent = bookmarkDetalles.Parent
                bool isInTable = false;

                //,) <> mainPart.Document.Body
                while (!(tempParent.Parent is Body))
                {
                    tempParent = tempParent.Parent;
                    if (((tempParent) is TableRow & !isInTable))
                    {
                        isInTable = true;
                        break; // TODO: might not be correct. Was : Exit While
                    }
                }

                if (isInTable)
                {
                    //table = tempParent
                    //no basta con saber la tabla. necesito saber la posicion del bookmark en la tabla
                    //table.ChildElements(
                    //bookmarkDetalles.
                    row1 = tempParent;
                    table = (Table)row1.Parent;
                }
                else
                {
                    // Err().Raise(5454, "asdasdasa");
                }

                //////////////////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////////////////
                //hago los reemplazos
                //////////////////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////////////////

                //'Make a copy of the 2nd row (assumed that the 1st row is header) http://patrickyong.net/tags/openxml/
                //Dim rows = table.Elements(Of TableRow)()
                foreach (DetallePedido i in det)
                {
                    DocumentFormat.OpenXml.OpenXmlElement dupRow = row1.CloneNode(true);
                    //Dim dupRow2 = row2.CloneNode(True)

                    //CeldaReemplazos(dupRow, -1, i)


                    for (long CeldaColumna = 0; CeldaColumna <= row1.Elements<TableCell>().Count() - 1; CeldaColumna++)
                    {

                        try
                        {
                            /////////////////////////////
                            //renglon 1
                            /////////////////////////////


                            string texto = dupRow.InnerXml;
                            var _with3 = i;
                            regexReplace(ref texto, "#item#", i.NumeroItem.NullSafeToString());

                            try
                            {
                                //string.Join(" ",  a.DetallePedidos.Select(x=>(x.DetalleRequerimiento==null) ? "" : x.DetalleRequerimiento.Requerimientos.NumeroRequerimiento.NullSafeToString() ).Distinct()),
                                //string.Join(" ",  a.DetallePedidos.Select(x=>(x.DetalleRequerimiento==null) ? "" : x.DetalleRequerimiento.Requerimientos.Obra.Descripcion).Distinct()),

                                string obras = "", numeros = "";

                                if (!bAgruparItems)
                                {
                                    numeros = i.DetalleRequerimiento.Requerimientos.NumeroRequerimiento.NullSafeToString();
                                    obras = i.DetalleRequerimiento.Requerimientos.Obra.NumeroObra; //   .Descripcion;
                                }



                                regexReplace(ref texto, "#obraitem#", obras);
                                regexReplace(ref texto, "#RMsitem#", numeros);
                            }
                            catch (Exception e)
                            {

                                ErrHandler.WriteError(e);
                            }

                            regexReplace(ref texto, "#Cant#", ProntoFuncionesGenerales.FF2((double)i.Cantidad).NullSafeToString());

                            regexReplace(ref texto, "#ctrl#", (i.ControlesCalidad ?? new ControlCalidad()).Abreviatura.NullSafeToString());
                            regexReplace(ref texto, "#mon#", (oFac.Moneda ?? new Moneda()).Nombre.NullSafeToString());


                            regexReplace(ref texto, "#Unidad#", (i.Unidad ?? new Unidad()).Descripcion.NullSafeToString());
                            regexReplace(ref texto, "#medida#", "");
                            regexReplace(ref texto, "#en#", (i.Unidad ?? new Unidad()).Abreviatura.NullSafeToString());
                            regexReplace(ref texto, "#Codigo#", (i.Articulo ?? new Articulo()).Codigo.NullSafeToString());
                            regexReplace(ref texto, "#PrecioUnitario#", i.Precio.NullSafeToString());
                            // regexReplace(ref texto, "#TotalItem#", i.ImporteTotalItem.NullSafeToString());
                            regexReplace(ref texto, "#TotalItem#", ProntoFuncionesGenerales.FF2((double)(i.ImporteTotalItem - i.ImporteIva)).NullSafeToString());
                            regexReplace(ref texto, "#bonitem#", i.PorcentajeBonificacion.NullSafeToString());
                            //regexReplace(ref texto, "#ivaitem#", i.ImporteIva.NullSafeToString());
                            regexReplace(ref texto, "#ivaitem#", ProntoFuncionesGenerales.FF2((double)i.PorcentajeIVA).NullSafeToString());
                            // 
                            string desc = ((i.OrigenDescripcion != 2) ? (i.Articulo ?? new Articulo()).Descripcion.NullSafeToString() : "") + " " + (i.OrigenDescripcion != 1 ? i.Observaciones : "");
                            regexReplace(ref texto, "#Descripcion#", desc);


                            regexReplace(ref texto, "#FechaEntrega#", (i.FechaEntrega ?? new DateTime()).ToShortDateString());
                            regexReplace(ref texto, "#FechaRecepcion#", "");


                            regexReplace(ref texto, "#FechaNecesidad#", (i.FechaNecesidad ?? new DateTime()).ToShortDateString());
                            //regexReplace(ref texto, "#ListaMat#", i.ListaMateriales.NullSafeToString());
                            //regexReplace(ref texto, "#itLM#", i.ItemListaMaterial.NullSafeToString());
                            //regexReplace(ref texto, "#Equipo#", i.Equipo.NullSafeToString());
                            //regexReplace(ref texto, "#CentrocostoCuenta#", i.centrocosto);
                            // regexReplace(ref texto, "#BienUso#", (iisNull(i.bien_o_uso, false) == true ? "SI" : "NO"));
                            //regexReplace(ref texto, "#controlcalidad#", i.ControlDeCalidad);
                            regexReplace(ref texto, "#adj#", i.Adjunto);
                            //regexReplace(ref texto, "#Proveedor#", i.proveedor);
                            //regexReplace(ref texto, "#nroFactPedido#", i.NumeroFacturaCompra1);
                            regexReplace(ref texto, "#FechaFact#", "");
                            //iisNull(.FechaFacturaCompra))

                            dupRow.InnerXml = texto;

                            /////////////////////////////
                            //renglon 2
                            /////////////////////////////

                            //    CeldaReemplazos(dupRow2, CeldaColumna, i)
                            //    table.AppendChild(dupRow2)
                        }
                        catch (Exception ex)
                        {
                            ErrHandler.WriteError(ex);
                        }

                    }

                    table.AppendChild(dupRow);


                }

                table.RemoveChild(row1);
                //row2.Parent.RemoveChild(row2)

                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //PIE
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                foreach (FooterPart pie in wordDoc.MainDocumentPart.FooterParts)
                {
                    //Dim pie = wordDoc.MainDocumentPart.FooterParts.First
                    pie.GetStream();

                    docText = null;
                    sr = new StreamReader(pie.GetStream());

                    using ((sr))
                    {
                        docText = sr.ReadToEnd();
                    }

                    regexReplace(ref docText, "#Observaciones#", oFac.Observaciones);
                    regexReplace(ref docText, "#LugarEntrega#", oFac.LugarEntrega);
                    regexReplace(ref docText, "#Liberado#", ((oFac.Aprobo ?? 0) > 0 ? EntidadManager.GetInitialsFromString(db.Empleados.Find(oFac.Aprobo).Nombre) + " " + oFac.FechaAprobacion : ""));
                    //iniciales + fecha + hora


                    var sAut = new List<string>();

                    var Autorizaciones = db.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.NotaPedido, oFac.IdPedido);
                    foreach (AutorizacionesPorComprobante i in Autorizaciones)
                    {

                        if ((i.IdAutorizo ?? 0) > 0)
                        {
                            sAut.Add(EntidadManager.GetInitialsFromString(db.Empleados.Find(i.IdAutorizo).Nombre) + " " + i.FechaAutorizacion.ToString());
                        }
                    }

                    try
                    {

                        regexReplace(ref docText, "#JefeSector#", sAut.Count > 0 ? sAut[0] : "");
                        regexReplace(ref docText, "#Calidad#", sAut.Count > 1 ? sAut[1] : "");
                        // regexReplace(ref docText, "#Planeamiento#", sAut.Count > 2 ? sAut[2] : "");
                        regexReplace(ref docText, "#GerenciaSector#", sAut.Count > 2 ? sAut[2] : "");
                        regexReplace(ref docText, "#DireccionPie#", sAut.Count > 3 ? sAut[3] : "");
                    }
                    catch (Exception e)
                    {
                        ErrHandler.WriteError(e); //throw;
                    }


                    ////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////




                    ////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////
                    regexReplace(ref  docText, "#Total#", ProntoFuncionesGenerales.FF2(0));
                    regexReplace(ref docText, "#Total2#", ProntoFuncionesGenerales.FF2(0));

                    regexReplace(ref docText, "#Subtotal#", ProntoFuncionesGenerales.FF2((double)(oFac.TotalIva1 ?? 0)));
                    regexReplace(ref docText, "#IVA#", ProntoFuncionesGenerales.FF2((double)(oFac.TotalIva1 ?? 0)));
                    //regexReplace(ref docText, "#IIBB#", ProntoFuncionesGenerales.FF2((double)oFac.));
                    regexReplace(ref docText, "#Total#", ProntoFuncionesGenerales.FF2((double)(oFac.TotalPedido ?? 0)));


                    sw = new StreamWriter(pie.GetStream(FileMode.Create));
                    using ((sw))
                    {
                        sw.Write(docText);
                    }
                }


                //buscar bookmark http://openxmldeveloper.org/discussions/formats/f/13/p/2539/8302.aspx
                //Dim mainPart As MainDocumentPart = wordDoc.MainDocumentPart()
                //Dim bookmarkStart = mainPart.Document.Body.Descendants().Where(bms >= bms.Name = "testBookmark").SingleOrDefault()
                //Dim bookmarkEnd = mainPart.Document.Body.Descendants().Where(bme >= bme.Id.Value = bookmarkStart.Id.Value).SingleOrDefault()
                //BookmarkStart.Remove()
                //BookmarkEnd.Remove()
            }
            return null;
        }

        public int ProximoNumero(bool bEsExterior)
        {
            Parametros parametros = db.Parametros.Find(1);
            if (bEsExterior) return parametros.ProximoNumeroPedidoExterior ?? 1;
            else return parametros.ProximoNumeroPedido ?? 1;
        }

        void regexReplace(ref string cadena, string buscar, string reemplazo)
        {
            // 'buscar = "\[" & buscar & "\]" 'agrego los corchetes
            // buscar = buscar
            var regexText = new System.Text.RegularExpressions.Regex(buscar, System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            cadena = regexText.Replace(cadena, reemplazo ?? "");
        }

        void UpdateColeccion(Pedido Pedido)
        {
            var EntidadOriginal = db.Pedidos.Where(p => p.IdPedido == Pedido.IdPedido).Include(p => p.DetallePedidos).SingleOrDefault();
            var EntidadEntry = db.Entry(EntidadOriginal);
            EntidadEntry.CurrentValues.SetValues(Pedido);

            foreach (var dr in Pedido.DetallePedidos)
            {
                var DetalleEntidadOriginal = EntidadOriginal.DetallePedidos.Where(c => c.IdDetallePedido == dr.IdDetallePedido && dr.IdDetallePedido > 0).SingleOrDefault();
                if (DetalleEntidadOriginal != null)
                {
                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                    DetalleEntidadEntry.CurrentValues.SetValues(dr);
                }
                else
                {
                    EntidadOriginal.DetallePedidos.Add(dr);
                }
            }

            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetallePedidos.Where(c => c.IdDetallePedido != 0).ToList())
            {
                if (!Pedido.DetallePedidos.Any(c => c.IdDetallePedido == DetalleEntidadOriginal.IdDetallePedido))
                    EntidadOriginal.DetallePedidos.Remove(DetalleEntidadOriginal);
            }
            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
        }

        [HttpPost]
        public virtual JsonResult AnularFirmas(Pedido Pedido)
        {
            //         Set oRs = Aplicacion.Pedidos.TraerFiltrado("_RecepcionesPorIdPedido", mvarId)
            //If oRs.RecordCount > 0 Then
            //   mError = mError & "Hay recepciones ya registradas contra este pedido, no puede eliminar las firmas"
            //End If

            //With origen.Registro
            //   .Fields("Aprobo").Value = Null
            //   .Fields("CircuitoFirmasCompleto").Value = Null
            //   .Fields("Subnumero").Value = IIf(IsNull(.Fields("Subnumero").Value), 1, .Fields("Subnumero").Value + 1)
            //End With
            int glbIdUsuario = Pedido.Aprobo ?? -1;
            if (glbIdUsuario <= 0) glbIdUsuario = -1;
            string nSC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            Pronto.ERP.Bll.EntidadManager.Tarea(nSC, "AutorizacionesPorComprobante_EliminarFirmas", (int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.NotaPedido,
                                                    Pedido.IdPedido, -1, glbIdUsuario);  // idformulario,idcomprobante, orden autorizacion, idusuarioelimino

            //mError = ""
            //Set oRs = Aplicacion.Pedidos.TraerFiltrado("_RecepcionesPorIdPedido", mvarId)
            //If oRs.RecordCount > 0 Then
            //   mError = mError & "Hay recepciones ya registradas contra este pedido, no puede eliminar las firmas"
            //End If
            //oRs.Close

            Pedido.Aprobo = null;
            Pedido.CircuitoFirmasCompleto = null;
            Pedido.SubNumero += 1;

            return BatchUpdate(Pedido);
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(Pedido Pedido)
        {

            if (false)
            {
                // mientras no encuentre una manera de esquivar el Membership en los tests, no usar esto
                // -sí. lo que deberías usar es el wrapper (IStaticsarasa), que despues es reemplazado en el test por un mock
                if (!PuedeEditar(enumNodos.Pedidos)) throw new Exception("No tenés permisos");

                if (!System.Diagnostics.Debugger.IsAttached)
                {
                    if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
                        !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
                        !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
                        )
                    {

                        int idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));

                        if (Pedido.IdProveedor != idproveedor) throw new Exception("Sólo podes acceder a Pedidos tuyos");
                        //throw new Exception("No tenés permisos");
                    }
                }
                //Pedido.mail
            }


            try
            {
                //var mailcomp = db.Empleados.Where(e => e.IdEmpleado == Pedido.IdComprador).Select(e => e.Email).FirstOrDefault();
                //Generales.enviarmailAlComprador(mailcomp   ,Pedido.IdPedido );

            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }

            string errs = "";
            string warnings = "";

            if (!Validar(Pedido, ref errs, ref warnings))
            {
                try
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;
                }
                catch (Exception)
                {
                    //    throw;
                }

                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;

                //List<string> errors = new List<string>();
                //errors.Add(errs);
                string[] words = errs.Split('\n');
                res.Errors = words.ToList(); // GetModelStateErrorsAsString(this.ModelState);
                res.Message = "El Pedido es inválido";

                return Json(res);
            }

            try
            {
                if (ModelState.IsValid)
                {
                    Pedido.ConfirmadoPorWeb_1 = "SI";

                    foreach (var d in Pedido.DetallePedidos)
                    {
                        int IdDetalleRequerimiento = d.IdDetalleRequerimiento ?? 0;
                        if (IdDetalleRequerimiento > 0)
                        {
                            ProntoMVC.Data.Models.DetalleRequerimiento data = db.DetalleRequerimientos.Where(p => p.IdDetalleRequerimiento == IdDetalleRequerimiento).FirstOrDefault();
                            if (data != null)
                            {
                                int IdTipoCompra = data.Requerimientos.IdTipoCompra ?? 0;
                                if (IdTipoCompra > 0)
                                {
                                    Pedido.IdTipoCompraRM = IdTipoCompra;
                                    break;
                                }
                            }
                        }
                    }

                    string tipomovimiento = "";
                    if (Pedido.IdPedido > 0)
                    {
                        UpdateColeccion(Pedido);
                    }
                    else
                    {
                        if (Pedido.SubNumero == 0)
                        {
                            tipomovimiento = "N";

                            Parametros parametros = db.Parametros.Find(1);
                            if (Pedido.PedidoExterior == "SI")
                            {
                                Pedido.NumeroPedido = parametros.ProximoNumeroPedidoExterior;
                                parametros.ProximoNumeroPedidoExterior += 1;
                            }
                            else
                            {
                                Pedido.NumeroPedido = parametros.ProximoNumeroPedido;
                                parametros.ProximoNumeroPedido += 1;
                            }
                        }
                        db.Pedidos.Add(Pedido);
                    }

                    try
                    {
                        //  ActivarUsuarioYContacto(Pedido.IdPedido);
                    }
                    catch (Exception e)
                    {
                        ErrHandler.WriteError(e); //throw;
                    }

                    db.wActualizacionesVariasPorComprobante(104, Pedido.IdPedido, tipomovimiento);

                    ActualizacionesVariasPorComprobante(Pedido);
                    db.SaveChanges();

                    db.Tree_TX_Actualizar("PedidosAgrupados", Pedido.IdPedido, "Pedido");

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdPedido = Pedido.IdPedido, ex = "" });
                }
                else
                {

                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "El Pedido es inválido";
                    //return Json(res);
                    //return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });

                    return Json(res);
                }

            }
            catch (System.Data.Entity.Validation.DbEntityValidationException ex)
            {
                //http://stackoverflow.com/questions/10219864/ef-code-first-how-do-i-see-entityvalidationerrors-property-from-the-nuget-pac
                StringBuilder sb = new StringBuilder();

                foreach (var failure in ex.EntityValidationErrors)
                {
                    sb.AppendFormat("{0} failed validation\n", failure.Entry.Entity.GetType());
                    foreach (var error in failure.ValidationErrors)
                    {
                        sb.AppendFormat("- {0} : {1}", error.PropertyName, error.ErrorMessage);
                        sb.AppendLine();
                    }
                }

                //throw new System.Data.Entity.Validation.DbEntityValidationException(
                //    "Entity Validation Failed - errors follow:\n" +
                //    sb.ToString(), ex
                //); // Add the original exception as the innerException

                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;

                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);

                res.Errors.Add(sb.ToString());
                res.Errors.Add(ex.ToString());
                res.Message = "El Pedido es inválido. " + ex.ToString();
                //return Json(res);
                //return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });

                return Json(res);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;

                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);
                res.Errors.Add(ex.ToString());
                res.Message = "El Pedido es inválido. " + ex.ToString();
                //return Json(res);
                //return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });

                return Json(res);

                // return Json(new { Success = 0, ex = ex.Message.ToString() });
            }
            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }

        private void ActualizacionesVariasPorComprobante(Pedido o)
        {
            // http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11061

            foreach (DetallePedido i in o.DetallePedidos)
            {
                var a = db.DetalleRequerimientos.Where(r => r.IdDetalleRequerimiento == i.IdDetalleRequerimiento).FirstOrDefault();

                if (a != null) // el item del pedido está imputado a un rm?
                {

                    decimal requerida = a.Cantidad ?? 0;

                    decimal pedidoaca = i.Cantidad ?? 0; // o.DetallePedidos.Where(x => x.IdDetalleRequerimiento == i.IdDetalleRequerimiento).Sum(z => z.Cantidad) ?? 0;

                    decimal pedidoafuera = db.DetallePedidos.Where(x => x.IdDetalleRequerimiento == i.IdDetalleRequerimiento
                                                              && ((x.Cumplido ?? "NO") != "AN") && x.IdPedido != i.IdPedido)
                                                      .Sum(z => z.Cantidad) ?? 0;

                    if (requerida - pedidoafuera == pedidoaca)
                    {
                        a.Cumplido = "SI"; // 
                    }
                    else
                    {
                        a.Cumplido = "PA";  // no llega a comprar completo el item de requerimiento
                    }


                    // http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11061

                    var cab = db.Requerimientos.Include(x => x.DetalleRequerimientos).Where(x => x.IdRequerimiento == a.IdRequerimiento).FirstOrDefault();
                    if (!cab.DetalleRequerimientos.Where(r => r.Cumplido != "SI" && r.Cumplido != "AN").Any())
                    {
                        cab.Cumplido = "SI";
                    }
                    else if (cab.DetalleRequerimientos.Where(r => r.Cumplido == "SI" || r.Cumplido == "PA").Any())
                    {
                        cab.Cumplido = "PA";
                    }
                }
            }
        }

        //public string GetExceptionDetails(this Exception exception)
        //{
        //    var properties = exception.GetType()
        //                            .GetProperties();
        //    var fields = properties
        //                     .Select(property => new
        //                     {
        //                         Name = property.Name,
        //                         Value = property.GetValue(exception, null)
        //                     })
        //                     .Select(x => String.Format(
        //                         "{0} = {1}",
        //                         x.Name,
        //                         x.Value != null ? x.Value.ToString() : String.Empty
        //                     ));
        //    return String.Join("\n", fields);
        //}

        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer(enumNodos.Pedidos)) throw new Exception("No tenés permisos");
            if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
             !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
             !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
             ) throw new Exception("No tenés permisos");

            if (id == -1)
            {
                Pedido Pedido = new Pedido();

                inic(ref Pedido);

                CargarViewBag(Pedido);

                return View(Pedido);
            }
            else
            {
                Pedido Pedido = db.Pedidos.Find(id);
                CargarViewBag(Pedido);
                Session.Add("Pedido", Pedido);
                return View(Pedido);
            }
        }

        void inic(ref Pedido o)
        {
            Parametros parametros = db.Parametros.Find(1);
            o.NumeroPedido = parametros.ProximoNumeroPedido;
            o.SubNumero = 0;
            o.FechaPedido = DateTime.Today;
            o.IdMoneda = 1;
            o.CotizacionMoneda = 1;
            ViewBag.Proveedor = "";

            o.Importante = parametros.PedidosImportante;
            o.Garantia = parametros.PedidosGarantia;
            o.Documentacion = parametros.PedidosDocumentacion;
            o.FormaPago = parametros.PedidosFormaPago;
            //o.ImprimeInspecciones = parametros.PedidosInspecciones;
            o.LugarEntrega = parametros.PedidosLugarEntrega;
            o.PlazoEntrega = parametros.PedidosPlazoEntrega;

            //o.PorcentajeIva1 = 21;                  //  mvarP_IVA1_Tomado
            //o.FechaFactura = DateTime.Now;

            //Parametros parametros = db.Parametros.Find(1);
            //o.OtrasPercepciones1 = 0;
            //o.OtrasPercepciones1Desc = ((parametros.OtrasPercepciones1 ?? "NO") == "SI") ? parametros.OtrasPercepciones1Desc : "";
            //o.OtrasPercepciones2 = 0;
            //o.OtrasPercepciones2Desc = ((parametros.OtrasPercepciones2 ?? "NO") == "SI") ? parametros.OtrasPercepciones2Desc : "";
            //o.OtrasPercepciones3 = 0;
            //o.OtrasPercepciones3Desc = ((parametros.OtrasPercepciones3 ?? "NO") == "SI") ? parametros.OtrasPercepciones3Desc : "";

            //o.IdMoneda = 1;

            // db.Cotizaciones_TX_PorFechaMoneda(fecha,IdMoneda)
            var mvarCotizacion = funcMoneda_Cotizacion(DateTime.Today, 2);
            //var mvarCotizacion = db.Cotizaciones.OrderByDescending(x => x.IdCotizacion).FirstOrDefault().Cotizacion; //  mo  Cotizacion(Date, glbIdMonedaDolar);
            o.CotizacionMoneda = 1;
            //  o.CotizacionADolarFijo=
            o.CotizacionDolar = (decimal)(mvarCotizacion ?? 0);

            //o.DetalleFacturas.Add(new DetalleFactura());
            //o.DetalleFacturas.Add(new DetalleFactura());
            //o.DetalleFacturas.Add(new DetalleFactura());
        }

        public virtual JsonResult Autorizaciones(int IdPedido)
        {
            var Autorizaciones = db.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.NotaPedido, IdPedido);
            return Json(Autorizaciones, JsonRequestBehavior.AllowGet);
        }

        void CargarViewBag(Pedido o)
        {
            ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras.OrderBy(x => x.Descripcion), "IdCondicionCompra", "Descripcion", o.IdCondicionCompra);
            ViewBag.IdMoneda = new SelectList(db.Monedas.OrderBy(x => x.Nombre), "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas.OrderBy(x => x.Descripcion), "IdPlazoEntrega", "Descripcion", o.PlazoEntrega);

            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            string nSC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            DataTable dt = EntidadManager.GetStoreProcedure(nSC, "Empleados_TX_PorSector", "Compras");
            IEnumerable<DataRow> rows = dt.AsEnumerable();
            var sq = (from r in rows orderby r[1]  select new { IdEmpleado = r[0], Nombre = r[1] }).ToList();
            // ViewBag.Aprobo = new SelectList(db.Empleados.Where(x => (x.Activo ?? "SI") == "SI"  ).OrderBy(x => x.Nombre), "IdEmpleado", "Nombre", o.Aprobo);

            ViewBag.Aprobo = new SelectList(sq, "IdEmpleado", "Nombre", o.Aprobo);
            ViewBag.IdComprador = new SelectList(sq, "IdEmpleado", "Nombre", o.IdComprador);

            ViewBag.Proveedor = (db.Proveedores.Find(o.IdProveedor) ?? new Proveedor()).RazonSocial;

            ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", (o.Proveedor ?? new Proveedor()).IdCodigoIva);
            try
            {
                ViewBag.CantidadAutorizaciones = db.Autorizaciones_TX_CantidadAutorizaciones((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.NotaPedido, o.TotalPedido * o.CotizacionMoneda, -1).Count();
            }
            catch (Exception e)
            {

                ErrHandler.WriteError(e);
            }

            //ViewBag.TotalBonificacionGlobal = o.Bonificacion;
            //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            //ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion");
            //ViewBag.PuntoVenta = new SelectList((from i in db.PuntosVentas
            //                                     where i.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Factura
            //                                     select new { PuntoVenta = i.PuntoVenta })
            //    // http://stackoverflow.com/questions/2135666/databinding-system-string-does-not-contain-a-property-with-the-name-dbmake
            //                                     .Distinct(), "PuntoVenta", "PuntoVenta"); //traer solo el Numero de PuntoVenta, no el Id
            //ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", o.IdObra);
            //ViewBag.IdCliente = new SelectList(db.Clientes, "IdCliente", "RazonSocial", o.IdCliente);
            //ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion", o.IdCodigoIva);
            //ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", o.IdCodigoIva);
            //ViewBag.IdListaPrecios = new SelectList(db.ListasPrecios, "IdListaPrecios", "Descripcion", o.IdListaPrecios);
            //ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            //ViewBag.IdCondicionVenta = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", o.IdCondicionVenta);

            ////http://stackoverflow.com/questions/942262/add-empty-value-to-a-dropdownlist-in-asp-net-mvc
            //// http://stackoverflow.com/questions/7659612/mvc3-dropdownlist-and-viewbag-how-add-new-items-to-collection
            ////List<SelectListItem>  l = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);
            ////l.ad
            ////l.Add((new SelectListItem { IdIBCondicion = " ", Descripcion = "-1" }));
            //ViewBag.IdIBCondicionPorDefecto = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);
            //ViewBag.IdIBCondicionPorDefecto2 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion2);
            //ViewBag.IdIBCondicionPorDefecto3 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion3);
            //Parametros parametros = db.Parametros.Find(1);
            //ViewBag.PercepcionIIBB = parametros.PercepcionIIBB;
        }

        private bool HayCotizacionDolarDeHoy()
        {
            return true;

            DateTime hasta = DateTime.Today.AddDays(1);
            var mvarCotizacion = db.Cotizaciones.Where(x => x.Fecha >= DateTime.Today && x.Fecha <= hasta && x.IdMoneda == 2).FirstOrDefault();
            if (mvarCotizacion == null) return false;
            return true;
        }


        private bool Validar(ProntoMVC.Data.Models.Pedido o, ref string sErrorMsg, ref string sWarningMsg)
        {
            // una opcion es extender el modelo autogenerado, para ensoquetar ahí las validaciones
            // si no, podemos usar una funcion como esta, y devolver los  errores de dos maneras:
            // con ModelState.AddModelError si los devolvemos en una ViewResult,
            // o con un array de strings si es una JsonResult.
            //
            // if you are returning JSON, you cannot use ModelState.
            // http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json

            //res.Errors = GetModelStateErrorsAsString(this.ModelState);




            List<int?> duplicates = o.DetallePedidos.Where(s => (s.IdDetalleRequerimiento ?? 0) > 0).GroupBy(s => s.IdDetalleRequerimiento)
                         .Where(g => g.Count() > 1)
                         .Select(g => g.Key)
                         .ToList();


            if (!HayCotizacionDolarDeHoy())
            {

                sErrorMsg += "\n" + " No hay cotización de dólar de hoy";
            }

            if (duplicates.Count > 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");

                foreach (int? i in duplicates)
                {
                    List<DetallePedido> q = o.DetallePedidos.Where(x => x.IdDetalleRequerimiento == i).Select(x => x).Skip(1).ToList();
                    foreach (DetallePedido x in q)
                    {
                        // tacharlo de la grilla, no eliminarlo de pantalla
                        // tacharlo de la grilla, no eliminarlo de pantalla
                        string nombre = x.NumeroItem + " El item " + x.NumeroItem + "  (" + db.Articulos.Find(x.IdArticulo).Descripcion + ") ";
                        sErrorMsg += "\n" + nombre + " usa un item de requerimiento que ya se está usando ";  // tacharlo de la grilla, no eliminarlo de pantalla
                        // tacharlo de la grilla, no eliminarlo de pantalla
                    }

                }

                // verificar tambien si el  item ya se usa enum otro peddido
                //sss
                // return false;
            }

            if (!PuedeEditar(enumNodos.Facturas)) sErrorMsg += "\n" + "No tiene permisos de edición";
            if (o.IdPedido <= 0)
            {
                //  string connectionString = Generales.sCadenaConexSQL(this.Session["BasePronto"].ToString());
                //  o.NumeroFactura = (int)Pronto.ERP.Bll.FacturaManager.ProximoNumeroFacturaPorIdCodigoIvaYNumeroDePuntoVenta(connectionString,o.IdCodigoIva ?? 0,o.PuntoVenta ?? 0);
            }

            if ((o.IdProveedor ?? 0) <= 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta el proveedor";
                // return false;
            }
            else if (((db.Proveedores.Find(o.IdProveedor) ?? new Proveedor()).Confirmado ?? "NO") == "NO")
            {

                sErrorMsg += "\n" + "El proveedor no está confirmado";
            }



            if ((o.IdComprador ?? 0) <= 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta el comprador";
                // return false;
            }

            if ((o.CotizacionDolar ?? 0) <= 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta la cotización";
                // return false;
            }

            if ((o.IdMoneda ?? 0) <= 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta la moneda";
                // return false;
            }
            //if (o.NumeroFactura == null) sErrorMsg +="\n"+ "\n" + "Falta el número de factura";
            //// if (o.IdPuntoVenta== null) sErrorMsg +="\n"+ "\n" + "Falta el punto de venta";
            //if (o.IdCodigoIva == null) sErrorMsg +="\n"+ "\n" + "Falta el codigo de IVA";
            //if (o.IdCondicionVenta == null) sErrorMsg +="\n"+ "\n" + "Falta la condicion venta";
            //if (o.IdListaPrecios == null) sErrorMsg +="\n"+ "\n" + "Falta la lista de precios";
            if (o.DetallePedidos.Count <= 0) sErrorMsg += "\n" + "El Pedido no tiene items";

            //string OrigenDescripcionDefault = BuscaINI("OrigenDescripcion en 3 cuando hay observaciones");
            //         Dim mvarImprime As Integer, mvarNumero As Integer, i As Integer
            //         Dim mvarErr As String, mvarControlFechaNecesidad As String, mAuxS5 As String, mAuxS6 As String
            //         Dim PorObra As Boolean, mTrasabilidad_RM_LA As Boolean, mConAdjuntos As Boolean

            bool mExigirTrasabilidad_RMLA_PE = false, PorObra, mTrasabilidad_RM_LA = false;
            string mvarControlFechaNecesidad = "";
            string mAuxS5 = "";
            int mIdObra = 0;
            int mIdTipoCuenta = 0;

            var mvarMontoMinimo = BuscarClaveINI("Monto minimo para registrar pedido");

            //if (mvarTotalPedido * Val(txtCotizacionMoneda.Text) < Val(mvarMontoMinimo)) {
            //    sErrorMsg +="\n"+ "El importe total del pedido debe ser mayor a " & Format(Val(mvarMontoMinimo), "#,##0.00");
            //    return;
            //   }

            mvarControlFechaNecesidad = BuscarClaveINI("Quitar control fecha necesidad en pedidos");
            mAuxS5 = BuscarClaveINI("Deshabilitar control de cuentas de obras");


            var reqsToDelete = o.DetallePedidos.Where(x => (x.IdArticulo ?? 0) <= 0).ToList();
            foreach (var deleteReq in reqsToDelete)
            {
                o.DetallePedidos.Remove(deleteReq);
            }


            try
            {


                foreach (DetallePedido i in o.DetallePedidos)
                {

                    decimal requerida = db.DetalleRequerimientos.Find(i.IdDetalleRequerimiento).Cantidad ?? 0;

                    decimal pedidoaca = o.DetallePedidos.Where(x => x.IdDetalleRequerimiento == i.IdDetalleRequerimiento).Sum(z => z.Cantidad) ?? 0;

                    decimal pedidoafuera = db.DetallePedidos.Where(x => x.IdDetalleRequerimiento == i.IdDetalleRequerimiento
                                                              && ((x.Cumplido ?? "NO") != "AN") && x.IdPedido != i.IdPedido)
                                                      .Sum(z => z.Cantidad) ?? 0;

                    if (requerida - pedidoaca - pedidoafuera < 0)
                    {
                        var nombre = i.NumeroItem + " El item " + i.NumeroItem + "  (" + db.Articulos.Find(i.IdArticulo).Descripcion.SafeSubstring(0, 15) + ") ";

                        sErrorMsg += "\n   " + nombre + " solo tiene  " + (requerida - pedidoafuera).NullSafeToString()
                                    + " pendiente  ( Requerido: " + requerida.NullSafeToString()
                                    + ". En otros pedidos:" + pedidoafuera.NullSafeToString()
                                    + ". En este pedido: " + pedidoaca.NullSafeToString()
                                    + ")";
                    }


                }

            }
            catch (Exception)
            {

                //throw;
            }






            foreach (ProntoMVC.Data.Models.DetallePedido x in o.DetallePedidos)
            {


                //x.Adjunto = x.Adjunto ?? "NO";
                //if (x.FechaEntrega < o.FechaRequerimiento) sErrorMsg +="\n"+ "\n" + "La fecha de entrega de " + db.Articulos.Find(x.IdArticulo).Descripcion + " es anterior a la del requerimiento";

                string nombre = "";
                try
                {

                    nombre = x.NumeroItem + " El item " + x.NumeroItem + "  (" + db.Articulos.Find(x.IdArticulo).Descripcion.SafeSubstring(0, 15) + ") ";

                }
                catch (Exception ex)
                {
                    ErrHandler.WriteError(ex);
                    nombre = x.NumeroItem + " El item " + x.NumeroItem;
                    sErrorMsg += "\n " + nombre + " no tiene un artículo válido";

                }

                if ((x.Cantidad ?? 0) <= 0) sErrorMsg += "\n" + nombre + " no tiene una cantidad válida";

                //if (OrigenDescripcionDefault == "SI" && (x.Observaciones ?? "") != "") x.OrigenDescripcion = 3;
                if (x.ArchivoAdjunto == null && x.ArchivoAdjunto1 == null) x.Adjunto = "NO";
                if ((x.Precio ?? 0) <= 0 && o.IdPedidoAbierto == null)
                {
                    if (o.Aprobo != null)
                    {
                        sErrorMsg += "\n " + nombre + " no tiene precio unitario";
                    }
                    else
                    {
                        // solo un aviso
                        sWarningMsg += "\n " + nombre + " no tiene precio unitario. Cuando libere el pedido deberá ingresarse.";
                    }
                    //break;
                }

                if (x.IdControlCalidad == null)
                {
                    // sErrorMsg +="\n"+ "Hay items de pedido que no tienen indicado control de calidad";
                    //break;
                }

                if (x.FechaEntrega == new DateTime(2001, 1, 1)) x.FechaEntrega = null;
                if (x.FechaEntrega < o.FechaPedido && x.FechaEntrega != null)
                {
                    sErrorMsg += "\n " + nombre + " tiene una fecha de entrega anterior a la del pedido";
                    //break;
                }

                if (x.FechaNecesidad == new DateTime(2001, 1, 1)) x.FechaNecesidad = null;
                if (x.FechaNecesidad != null && x.FechaNecesidad < o.FechaPedido && mvarControlFechaNecesidad != "SI")
                {
                    sErrorMsg += "\n " + nombre + " tiene una fecha de necesidad anterior a la del pedido";
                    //break;
                }

                if (x.IdCentroCosto == null)
                {
                    PorObra = false;
                    mTrasabilidad_RM_LA = false;

                    if (x.IdDetalleAcopios != null || x.IdDetalleLMateriales != null)
                    {
                        PorObra = true;
                    }

                    if (x.IdDetalleRequerimiento != null)
                    {
                        var oRsx = Pronto.ERP.Bll.EntidadManager.TraerFiltrado(SCsql(), ProntoFuncionesGenerales.enumSPs.Requerimientos_TX_DatosObra, x.IdDetalleRequerimiento);

                        if (oRsx.Rows.Count > 0)
                        {
                            if (oRsx.Rows[0]["Obra"] != null) PorObra = true;
                            mIdObra = (int)oRsx.Rows[0]["IdObra"];
                        }

                    }

                    if (mIdObra > 0 && mAuxS5 != "SI")
                    {
                        var oRsx = Pronto.ERP.Bll.EntidadManager.TraerFiltrado(SCsql(), ProntoFuncionesGenerales.enumSPs.Articulos_TX_DatosConCuenta, x.IdArticulo);

                        mIdTipoCuenta = 0;
                        //no anda, arreglar    if (oRsx.Rows.Count > 0) mIdTipoCuenta = (int)oRsx.Rows[0]["IdTipoCuentaCompras"];

                        if (mIdTipoCuenta == 4)
                        {
                            var oRs = Pronto.ERP.Bll.EntidadManager.TraerFiltrado(SCsql(), ProntoFuncionesGenerales.enumSPs.Cuentas_TX_PorObraCuentaMadre, mIdObra, 0, x.IdArticulo, o.FechaPedido);
                            if (oRs.Rows.Count == 0)
                            {
                                sErrorMsg += "\n" + nombre + " no tiene una cuenta contable para la obra-cuenta de compras";
                                //break;
                            }
                        }
                    }

                    if (false && !PorObra)
                    {
                        sErrorMsg += "\n" + nombre + " no tiene indicado centro de costo";
                        //break;
                    }

                    if (x.IdControlCalidad == 0) x.IdControlCalidad = null;
                    if (x.IdControlCalidad == null)
                    {
                        sErrorMsg += "\n" + nombre + " no tiene indicado el control de calidad";

                    }

                    if (mExigirTrasabilidad_RMLA_PE && x.IdDetalleAcopios == null && x.IdDetalleRequerimiento == null)
                    {
                        sErrorMsg += "\n" + nombre + " no tiene trazabilidad a RM o LA";
                        //break;
                    }

                }

            }

            if ((o.Aprobo ?? 0) > 0 && o.FechaAprobacion == null) o.FechaAprobacion = DateTime.Now;



            o.PedidoExterior = (o.PedidoExterior ?? "NO");
            if (db.Pedidos.Any(p => p.NumeroPedido == o.NumeroPedido && p.SubNumero == o.SubNumero && p.IdPedido != o.IdPedido && (p.PedidoExterior ?? "NO") == o.PedidoExterior))
            {

                sErrorMsg += "\n" + "Numero/Subnumero de pedido ya existente";
            }

            sErrorMsg = sErrorMsg.Replace("\n", "<br/>"); //     ,"&#13;&#10;"); // "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }


        // es GET, no POST, porque el Validar no hace modificaciones (idempotencia) // [HttpPost]
        // -peeeeero surge un problema:
        //  Why you didn't add type: "POST" in $.ajax? Other way, i think it does GET request, and data has to be given in one string like this: var=val&var2=val2
        // y queda muy larga la url, así que vuelvo a ponerlo como POST
        [HttpPost]
        public virtual JsonResult ValidarJson(Pedido Pedido)
        {
            string ms = "";
            string ws = "";
            JsonResponse res = new JsonResponse();

            try
            {
                Validar(Pedido, ref ms, ref ws);

                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;

                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);


                string[] errs = ms.Replace("<br/>", "\n").Split('\n');

                foreach (string s in errs)
                {
                    if (s == "") continue;
                    res.Errors.Add(s);
                }

                res.Message = String.Join("<br/>", errs); // "Errores";
                //http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json
                //  nonono esta claro que en el res.Errors debo agregar la lista de errores que genera el Validar, y lo
                //que eso devuelva lo procesará javascript
                // return  new JsonResult(new { Comprobante = Pedido, Errores = ms });
                // return Json (  new { Comprobante = Pedido, Errores = ms }) ;
            }
            catch (Exception ex)
            {

                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;

                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);
                res.Message = "El Pedido es inválido. " + ex.ToString();
                //                throw;
            }
            // res.Status = Status.Error;
            // res.Errors = GetModelStateErrorsAsString(this.ModelState);
            //// res.Message = "El Pedido es inválido. " + ex.ToString();

            return Json(res);
        }

        public virtual ActionResult EditExterno(int id)
        {
            if (!PuedeLeer(enumNodos.Pedidos)) throw new Exception("No tenés permisos");

            if (id == -1)
            {
                Pedido Pedido = new Pedido();
                Parametros parametros = db.Parametros.Find(1);
                //Pedido.Numero = parametros.ProximoPedido;
                //Pedido.SubNumero = 1;
                //Pedido.FechaIngreso = DateTime.Today;
                Pedido.IdMoneda = 1;
                Pedido.CotizacionMoneda = 1;
                ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion");
                ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", Pedido.IdMoneda);
                ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion");
                ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
                ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
                ViewBag.Proveedor = "";
                return View(Pedido);
            }
            else
            {
                Pedido Pedido = db.Pedidos.Find(id);

                int idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));
                if (idproveedor > 0 && Pedido.IdProveedor != idproveedor) throw new Exception("Sólo podes acceder a Pedidos tuyos");

                ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", Pedido.IdCondicionCompra);
                ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", Pedido.IdMoneda);
                ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion", Pedido.PlazoEntrega);
                ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Pedido.IdComprador);
                ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Pedido.Aprobo);
                ViewBag.Proveedor = db.Proveedores.Find(Pedido.IdProveedor).RazonSocial;
                Session.Add("Pedido", Pedido);
                return View(Pedido);
            }
        }


        public virtual ActionResult Delete(int id)
        {
            Pedido Pedido = db.Pedidos.Find(id);
            return View(Pedido);
        }

        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            Pedido Pedido = db.Pedidos.Find(id);
            db.Pedidos.Remove(Pedido);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public class Pedidos2
        {
            public int IdPedido { get; set; }
            public int? IdProveedor { get; set; }
            public int? IdCondicionCompra { get; set; }
            public int? PuntoVenta { get; set; }
            public int? NumeroPedido { get; set; }
            public int? SubNumero { get; set; }
            public DateTime? FechaPedido { get; set; }
            public DateTime? FechaSalida { get; set; }
            public string Cumplido { get; set; }
            public string Requerimientos { get; set; }
            public string Obras { get; set; }
            public string ProveedoresCodigo { get; set; }
            public string ProveedoresNombre { get; set; }
            public decimal? TotalGravado { get; set; }
            public decimal? ImporteBonificacion { get; set; }
            public decimal? ImporteIva1 { get; set; }
            public decimal? OtrosConceptos { get; set; }
            public decimal? ImpuestosInternos { get; set; }
            public decimal? ImporteTotal { get; set; }
            public string Moneda { get; set; }
            public string Comprador { get; set; }
            public string LiberadoPor { get; set; }
            public int? CantidadItems { get; set; }
            public int? NumeroComparativa { get; set; }
            public string TiposCompra { get; set; }
            public string Observaciones { get; set; }
            public string CondicionCompra { get; set; }
            public string DetalleCondicionCompra { get; set; }
            public string PedidoExterior { get; set; }
            public string NumeroLicitacion { get; set; }
            public string Impresa { get; set; }
            public string UsuarioAnulo { get; set; }
            public DateTime? FechaAnulacion { get; set; }
            public string MotivoAnulacion { get; set; }
            public string EquipoDestino { get; set; }
            public string CircuitoFirmasCompleto { get; set; }
            public string DescripcionIva { get; set; }
            public DateTime? FechaEnvioProveedor { get; set; }
            public string Detalle { get; set; }
        }

        public class DetallePedidos2
        {
            public int IdDetallePedido { get; set; }
            public int? IdPedido { get; set; }
            public int? IdArticulo { get; set; }
            public int? IdUnidad { get; set; }
            public int? IdControlCalidad { get; set; }
            public int? OrigenDescripcion { get; set; }
            public int? IdDetalleRequerimiento { get; set; }
            public int? IdDetalleAcopios { get; set; }
            public int? NumeroPedido { get; set; }
            public DateTime? FechaPedido { get; set; }
            public int? NumeroItem { get; set; }
            public decimal? Cantidad { get; set; }
            public string Unidad { get; set; }
            public string Codigo { get; set; }
            public string Articulo { get; set; }
            public decimal? Precio { get; set; }
            public decimal? PorcentajeBonificacion { get; set; }
            public decimal? Importebonificacion { get; set; }
            public decimal? PorcentajeIVA { get; set; }
            public decimal? ImporteIva { get; set; }
            public decimal? ImporteTotalItem { get; set; }
            public string Obra { get; set; }
            public string Observaciones { get; set; }
            public string TiposDeDescripcion { get; set; }
            public DateTime? FechaEntrega { get; set; }
            public DateTime? FechaNecesidad { get; set; }
            public int? NumeroRequerimiento { get; set; }
            public int? NumeroItemRM { get; set; }
            public string Cumplido { get; set; }
            public string DescripcionControlCalidad { get; set; }
            public string ArchivoAdjunto1 { get; set; }
            public string ArchivoAdjunto2 { get; set; }
            public string ArchivoAdjunto3 { get; set; }
            public string ArchivoAdjunto4 { get; set; }
            public string ArchivoAdjunto5 { get; set; }
            public string ArchivoAdjunto6 { get; set; }
            public string ArchivoAdjunto7 { get; set; }
            public string ArchivoAdjunto8 { get; set; }
            public string ArchivoAdjunto9 { get; set; }
            public string ArchivoAdjunto10 { get; set; }
            public int? Aprobo { get; set; }
            public string CircuitoFirmasCompleto { get; set; }
        }

        private class DetallePedidos3
        {
            public DateTime? FechaAsignacionCosto { get; set; }
            public DateTime? FechaDadoPorCumplido { get; set; }
            public DateTime? FechaEntrega { get; set; }
            public DateTime? FechaModificacionCosto { get; set; }
            public DateTime? FechaNecesidad { get; set; }
            public int? IdArticulo { get; set; }
            public int? IdAsignacionCosto { get; set; }
            public int? IdAutorizoCumplido { get; set; }
            public int? IdCentroCosto { get; set; }
            public int? IdControlCalidad { get; set; }
            public int? IdCuenta { get; set; }
            public int? IdProveedor { get; set; }
            public int? IdObra { get; set; }
            public int? IdDetalleAcopios { get; set; }
            public int? IdDetalleComparativa { get; set; }
            public int? IdDetalleLMateriales { get; set; }
            public int IdDetallePedido { get; set; }
            public int? IdDetallePedidoOriginal { get; set; }
            public int? IdDetalleRequerimiento { get; set; }
            public int? IdDetalleRequerimientoOriginal { get; set; }
            public int? IdDioPorCumplido { get; set; }
            public int? IdOrigenTransmision { get; set; }
            public int? IdPedido { get; set; }
            public int? IdPedidoOriginal { get; set; }
            public int? IdUnidad { get; set; }
            public int? IdUsuarioAsignoCosto { get; set; }
            public int? IdUsuarioModificoCosto { get; set; }
            public decimal? PorcentajeBonificacion { get; set; }
            public decimal? PorcentajeIVA { get; set; }
            public decimal? Precio { get; set; }
            public int? NumeroPedido { get; set; }
            public int? SubNumero { get; set; }
            public int? ItemPE { get; set; }
            public DateTime? FechaPedido { get; set; }
            public string Proveedor { get; set; }
            public string Obra { get; set; }
            public string Comprador { get; set; }
            public string SolicitoRM { get; set; }
            public string ArticuloCodigo { get; set; }
            public string ArticuloDescripcion { get; set; }
            public string ObservacionesRM { get; set; }
            public string ObservacionesPE { get; set; }
            public decimal? Cantidad { get; set; }
            public string Unidad { get; set; }
            public int? NumeroRequerimiento { get; set; }
            public int? ItemRM { get; set; }
            public string Cumplido { get; set; }
            public string TipoCompra { get; set; }
            public string CircuitoFirmasCompleto { get; set; }
            public string ControlCalidad { get; set; }

        }

        public virtual ActionResult Pedidos_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal)
        {
            DateTime FechaDesde, FechaHasta;
            try
            {
                if (FechaInicial == "") FechaDesde = DateTime.MinValue;
                else FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            }
            catch (Exception)
            {
                FechaDesde = DateTime.MinValue;
            }

            try
            {
                if (FechaFinal == "") FechaHasta = DateTime.MaxValue;
                else FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
            }
            catch (Exception)
            {
                FechaHasta = DateTime.MaxValue;
            }

            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.Pedidos
                        from b in db.Empleados.Where(o => o.IdEmpleado == a.IdComprador).DefaultIfEmpty()
                        from c in db.Empleados.Where(o => o.IdEmpleado == a.Aprobo).DefaultIfEmpty()
                        from d in db.TiposCompras.Where(o => o.IdTipoCompra == a.IdTipoCompraRM).DefaultIfEmpty()
                        from e in db.Condiciones_Compras.Where(o => o.IdCondicionCompra == a.IdCondicionCompra).DefaultIfEmpty()
                        from f in db.DescripcionIvas.Where(o => o.IdCodigoIva == a.Proveedor.IdCodigoIva).DefaultIfEmpty()
                        select new Pedidos2
                        {
                            IdPedido = a.IdPedido,
                            IdProveedor = a.IdProveedor,
                            IdCondicionCompra = a.IdCondicionCompra,
                            PuntoVenta = a.PuntoVenta,
                            NumeroPedido = a.NumeroPedido,
                            SubNumero = a.SubNumero,
                            FechaPedido = a.FechaPedido,
                            FechaSalida = a.FechaSalida,
                            Cumplido = a.Cumplido,
                            Requerimientos = ModelDefinedFunctions.Pedidos_Requerimientos(a.IdPedido).ToString(),
                            Obras = ModelDefinedFunctions.Pedidos_Obras(a.IdPedido).ToString(),
                            ProveedoresCodigo = a.Proveedor.CodigoEmpresa != null ? a.Proveedor.CodigoEmpresa : "",
                            ProveedoresNombre = a.Proveedor.RazonSocial != null ? a.Proveedor.RazonSocial : "",
                            TotalGravado = (a.TotalPedido ?? 0) - (a.TotalIva1 ?? 0) + (a.Bonificacion ?? 0) - (a.ImpuestosInternos ?? 0) - (a.OtrosConceptos1 ?? 0) - (a.OtrosConceptos2 ?? 0) - (a.OtrosConceptos3 ?? 0) - (a.OtrosConceptos4 ?? 0) - (a.OtrosConceptos5 ?? 0),
                            ImporteBonificacion = a.Bonificacion ?? 0,
                            ImporteIva1 = a.TotalIva1 ?? 0,
                            OtrosConceptos = (a.OtrosConceptos1 ?? 0) + (a.OtrosConceptos2 ?? 0) + (a.OtrosConceptos3 ?? 0) + (a.OtrosConceptos4 ?? 0) + (a.OtrosConceptos5 ?? 0),
                            ImpuestosInternos = (a.ImpuestosInternos ?? 0),
                            ImporteTotal = a.TotalPedido,
                            Moneda = a.Moneda == null ? "" : a.Moneda.Abreviatura,
                            Comprador = b != null ? b.Nombre : "",
                            LiberadoPor = c != null ? c.Nombre : "",
                            CantidadItems = a.DetallePedidos.Count(),
                            NumeroComparativa = a.NumeroComparativa ?? 0,
                            TiposCompra = d != null ? d.Descripcion : "",
                            Observaciones = a.Observaciones ?? "",
                            CondicionCompra = e != null ? e.Descripcion : "",
                            DetalleCondicionCompra = a.DetalleCondicionCompra ?? "",
                            PedidoExterior = a.PedidoExterior ?? "",
                            NumeroLicitacion = a.NumeroLicitacion ?? "",
                            Impresa = a.Impresa ?? "",
                            UsuarioAnulo = a.UsuarioAnulacion ?? "",
                            FechaAnulacion = a.FechaAnulacion,
                            MotivoAnulacion = a.MotivoAnulacion ?? "",
                            EquipoDestino = ModelDefinedFunctions.Pedidos_EquiposDestino(a.IdPedido).ToString(),
                            CircuitoFirmasCompleto = a.CircuitoFirmasCompleto ?? "",
                            DescripcionIva = f != null ? f.Descripcion : "",
                            FechaEnvioProveedor = a.FechaEnvioProveedor,
                            Detalle = a.Detalle ?? "",
                        }).Where(a => a.FechaPedido >= FechaDesde && a.FechaPedido <= FechaHasta).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<Pedidos2>
                                     (sidx, sord, page, rows, _search, filters, db, ref totalRecords, data);

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in pagedQuery
                        select new jqGridRowJson
                        {
                            id = a.IdPedido.ToString(),
                            cell = new string[] {
                                "<a href="+ Url.Action("Edit",new {id = a.IdPedido} ) + "  >Editar</>" ,
                                "<a href="+ Url.Action("ImprimirConPlantillaEXE",new {id = a.IdPedido} )  +">Emitir</>" ,
                                a.IdPedido.ToString(), 
                                a.IdProveedor.NullSafeToString(), 
                                a.IdCondicionCompra.NullSafeToString(), 
                                a.NumeroPedido.NullSafeToString(), 
                                a.SubNumero.NullSafeToString(), 
                                a.FechaPedido==null ? "" :  a.FechaPedido.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaSalida==null ? "" :  a.FechaSalida.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Cumplido.NullSafeToString(), 
                                a.Requerimientos.NullSafeToString(), 
                                a.Obras.NullSafeToString(), 
                                a.ProveedoresCodigo.NullSafeToString(), 
                                a.ProveedoresNombre.NullSafeToString(), 
                                a.TotalGravado.NullSafeToString(), 
                                a.ImporteBonificacion.NullSafeToString(), 
                                a.ImporteIva1.NullSafeToString(), 
                                a.OtrosConceptos.NullSafeToString(), 
                                a.ImpuestosInternos.NullSafeToString(), 
                                a.ImporteTotal.NullSafeToString(), 
                                a.Moneda.NullSafeToString(), 
                                a.Comprador.NullSafeToString(), 
                                a.LiberadoPor.NullSafeToString(), 
                                a.CantidadItems.NullSafeToString(), 
                                a.NumeroComparativa.NullSafeToString(), 
                                a.TiposCompra.NullSafeToString(), 
                                a.Observaciones.NullSafeToString(), 
                                a.CondicionCompra.NullSafeToString(), 
                                a.DetalleCondicionCompra.NullSafeToString(), 
                                a.PedidoExterior.NullSafeToString(), 
                                a.NumeroLicitacion.NullSafeToString(), 
                                a.Impresa.NullSafeToString(), 
                                a.UsuarioAnulo.NullSafeToString(), 
                                a.FechaAnulacion.NullSafeToString(), 
                                a.MotivoAnulacion.NullSafeToString(), 
                                a.EquipoDestino.NullSafeToString(), 
                                a.CircuitoFirmasCompleto.NullSafeToString(), 
                                a.DescripcionIva.NullSafeToString(), 
                                a.FechaEnvioProveedor.NullSafeToString(), 
                                a.Detalle.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Pedidos(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //if (sidx == "Numero") sidx = "NumeroPedido"; // como estoy haciendo "select a" (el renglon entero) en la linq antes de llamar jqGridJson, no pude ponerle el nombre explicito
            //if (searchField == "Numero") searchField = "NumeroPedido"; 

            var Entidad = db.Pedidos
                // .Include(x => x.DetallePedidos.Select(y => y.Unidad))
                // .Include(x => x.DetallePedidos.Select(y => y.Moneda))
                //.Include(x => x.DetallePedidos. .moneda)
                //   .Include("DetallePedidos.Unidad") // funciona tambien
                            .Include(x => x.Moneda)
                           .Include(x => x.Proveedor)
                //  .Include("DetallePedidos.IdDetalleRequerimiento") // funciona tambien
                        .Include(x => x.DetallePedidos
                                    .Select(y => y.DetalleRequerimiento
                                        )
                                )
                  .Include("DetallePedidos.DetalleRequerimiento.Requerimientos.Obra") // funciona tambien
                // .Include(x => x.Aprobo)
                           .Include(x => x.Comprador)
                          .AsQueryable();

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                Entidad = (from a in Entidad where a.FechaPedido >= FechaDesde && a.FechaPedido <= FechaHasta select a).AsQueryable();
            }
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numero":
                        //campo = String.Format("{0} = {1}", searchField, searchString);
                        campo = String.Format("Proveedor.RazonSocial.Contains(\"{0}\") OR NumeroPedido = {1} ", searchString, Generales.Val(searchString));
                        break;
                    case "fechaingreso":
                        //No anda
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                    default:
                        campo = String.Format("Proveedor.RazonSocial.Contains(\"{0}\") OR NumeroPedido = {1} ", searchString, Generales.Val(searchString));
                        //if (searchOper == "eq")
                        //{
                        //    campo = String.Format("{0} = {1}", searchField, searchString);
                        //}
                        //else
                        //{
                        //    campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        //}
                        break;
                }
            }
            else
            {
                campo = "true";
            }

            var Entidad1 = (from a in Entidad.Where(campo) select new { IdPedido = a.IdPedido });

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad.Include(x => x.Proveedor)
                        //  .Include("DetallePedidos.IdDetalleRequerimiento") // funciona tambien
                        //.Include(x => x.DetallePedidos.Select(y => y. y.IdDetalleRequerimiento))
                        // .Include(x => x.Aprobo)
                        select a
                        ).Where(campo).OrderBy(sidx + " " + sord)
                        .Skip((currentPage - 1) * pageSize).Take(pageSize)
                        .ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdPedido.ToString(),
                            cell = new string[] { 
                                // "<a href="+ Url.Action("Edit",new {id = a.IdPedido} ) + " target='' >Editar</>" ,
                                "<a href="+ Url.Action("Edit",new {id = a.IdPedido}  ) + "  >Editar</>" ,
                                a.IdPedido.ToString(), 
                                a.NumeroPedido.NullSafeToString(), 
                                a.SubNumero.NullSafeToString(), 
                                a.FechaPedido.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                //GetCustomDateFormat(a.FechaPedido).NullSafeToString(), 
                                a.FechaSalida.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Cumplido.NullSafeToString(), 

                                string.Join(" ",  a.DetallePedidos.Select(x=>(x.DetalleRequerimiento==null) ? "" : x.DetalleRequerimiento.Requerimientos.NumeroRequerimiento.NullSafeToString() ).Distinct()),
                                string.Join(" ",  a.DetallePedidos.Select(x=>(x.DetalleRequerimiento==null) ? "" : x.DetalleRequerimiento.Requerimientos.Obra.NumeroObra).Distinct()),
                                //(i.DetalleRequerimiento == null ? "" : i.DetalleRequerimiento.Requerimientos.NumeroRequerimiento.NullSafeToString()));
                                //"", //a.detallepedidos.select (obras,
                                
                                a.Proveedor==null ? "" :  a.Proveedor.RazonSocial.NullSafeToString(), 
                                (a.TotalPedido- a.TotalIva1+a.Bonificacion- (a.ImpuestosInternos ?? 0)- (a.OtrosConceptos1 ?? 0) - (a.OtrosConceptos2 ?? 0)-    (a.OtrosConceptos3 ?? 0) -( a.OtrosConceptos4 ?? 0) - (a.OtrosConceptos5 ?? 0)).ToString(),  
                                a.Bonificacion.NullSafeToString(), 
                                a.TotalIva1.NullSafeToString(), 
                                a.Moneda==null ? "" :   a.Moneda.Abreviatura.NullSafeToString(),  
                                a.Comprador==null ? "" :    a.Comprador.Nombre.NullSafeToString(),  
                                a.Empleado==null ? "" :  a.Empleado.Nombre.NullSafeToString(),  
                                a.DetallePedidos.Count().NullSafeToString(),  
                                a.IdPedido.NullSafeToString(), 
                                a.NumeroComparativa.NullSafeToString(),  
                                a.IdTipoCompraRM.NullSafeToString(), 
                                a.Observaciones.NullSafeToString(),   
                                a.DetalleCondicionCompra.NullSafeToString(),   
                                a.PedidoExterior.NullSafeToString(),  
                                a.IdPedidoAbierto.NullSafeToString(), 
                                a.NumeroLicitacion .NullSafeToString(), 
                                a.Impresa.NullSafeToString(), 
                                a.UsuarioAnulacion.NullSafeToString(), 
                                a.FechaAnulacion.NullSafeToString(),  
                                a.MotivoAnulacion.NullSafeToString(),  
                                a.ImpuestosInternos.NullSafeToString(), 
                                "", // #Auxiliar1.Equipos , 
                                a.CircuitoFirmasCompleto.NullSafeToString(), 
                                a.Proveedor==null ? "" : a.Proveedor.IdCodigoIva.NullSafeToString() ,
                                a.IdComprador.NullSafeToString(),
                                a.IdProveedor.NullSafeToString(),
                                a.ConfirmadoPorWeb_1.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        protected string GetCustomDateFormat(object dateTimeObj)
        {
            //http://stackoverflow.com/questions/12349673/display-datetime-like-gmail
            //http://stackoverflow.com/questions/6909134/gmail-style-date-formating-in-python

            DateTime dateTime = (DateTime)dateTimeObj;

            if (dateTime.Date == DateTime.Today)
            {
                return dateTime.ToString("hh:mm tt", CultureInfo.InvariantCulture);
                //This Gives the Time in the Format (ex: 8:30 PM)

                //return dateTime.ToShortTimeString();
                // or you can specify format: dateTime.ToString("t")
            }
            else
            {
                return dateTime.ToShortDateString();
                // or you can specify format: dateTime.ToString("m")
            }
        }

        public virtual ActionResult PedidosExterno(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Pedidos.AsQueryable();


            int idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));

            if (idproveedor > 0) Entidad = Entidad.Where(p => p.IdProveedor == idproveedor).AsQueryable();


            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                // Entidad = (from a in Entidad where a.FechaIngreso >= FechaDesde && a.FechaIngreso <= FechaHasta select a).AsQueryable();
            }
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numero":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaingreso":
                        //No anda
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                    default:
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                }
            }
            else
            {
                campo = "true";
            }

            var Entidad1 = (from a in Entidad select new { IdPedido = a.IdPedido }).Where(campo);

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdPedido = a.IdPedido,
                            //Numero = a.Numero,
                            //Orden = a.SubNumero,
                            //FechaIngreso = a.FechaIngreso,
                            //Proveedor = a.Proveedor.RazonSocial,
                            //Validez = a.Validez,
                            //Bonificacion = a.Bonificacion,
                            //PorcentajeIva1 = a.PorcentajeIva1,
                            //Moneda = a.Moneda.Abreviatura,
                            //Subtotal = (a.ImporteTotal - a.ImporteIva1 + a.ImporteBonificacion),
                            //ImporteBonificacion = a.ImporteBonificacion,
                            //ImporteIva1 = a.ImporteIva1,
                            //ImporteTotal = a.ImporteTotal,
                            //PlazoEntrega = a.PlazosEntrega.Descripcion,
                            //CondicionCompra = a.Condiciones_Compra.Descripcion,
                            //Garantia = a.Garantia,
                            //LugarEntrega = a.LugarEntrega,
                            //Comprador = a.Empleado.Nombre,
                            //Aprobo = a.Empleado2.Nombre,
                            //Referencia = a.Referencia,
                            //Detalle = a.Detalle,
                            Contacto = a.Contacto,
                            Observaciones = a.Observaciones
                        }).Where(campo).OrderBy(sidx + " " + sord)
                        //.Skip((currentPage - 1) * pageSize).Take(pageSize)
                        .ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdPedido.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("EditExterno",new {id = a.IdPedido} ) + " target='' >Editar</>" 
								 +"|"+"<a href=../Pedido/EditExterno/" + a.IdPedido + "?code=1" + ">Detalles</a> ",
                                a.IdPedido.ToString(), 
                                //a.Numero.ToString(), 
                                //a.Orden.ToString(), 
                                //a.FechaIngreso.ToString(),
                                //a.Proveedor,
                                //a.Validez,
                                //a.Bonificacion.ToString(),
                                //a.PorcentajeIva1.ToString(),
                                //a.Moneda,
                                //a.Subtotal.ToString(),
                                //a.ImporteBonificacion.ToString(),
                                //a.ImporteIva1.ToString(),
                                //a.ImporteTotal.ToString(),
                                //a.PlazoEntrega,
                                //a.CondicionCompra,
                                //a.Garantia,
                                //a.LugarEntrega,
                                //a.Comprador,
                                //a.Aprobo,
                                //a.Referencia,
                                //a.Detalle,
                                a.Contacto,
                                a.Observaciones
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Pedidos_Pendientes2_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, int? IdProveedor, string Destino)
        {
            int IdProveedor1 = IdProveedor ?? 0;

            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.Pedidos
                        from b in db.Empleados.Where(o => o.IdEmpleado == a.IdComprador).DefaultIfEmpty()
                        from c in db.Empleados.Where(o => o.IdEmpleado == a.Aprobo).DefaultIfEmpty()
                        from d in db.TiposCompras.Where(o => o.IdTipoCompra == a.IdTipoCompraRM).DefaultIfEmpty()
                        from e in db.Condiciones_Compras.Where(o => o.IdCondicionCompra == a.IdCondicionCompra).DefaultIfEmpty()
                        from f in db.DescripcionIvas.Where(o => o.IdCodigoIva == a.Proveedor.IdCodigoIva).DefaultIfEmpty()
                        select new Pedidos2
                        {
                            IdPedido = a.IdPedido,
                            IdProveedor = a.IdProveedor,
                            IdCondicionCompra = a.IdCondicionCompra,
                            PuntoVenta = a.PuntoVenta,
                            NumeroPedido = a.NumeroPedido,
                            SubNumero = a.SubNumero,
                            FechaPedido = a.FechaPedido,
                            FechaSalida = a.FechaSalida,
                            Cumplido = a.Cumplido,
                            Requerimientos = ModelDefinedFunctions.Pedidos_Requerimientos(a.IdPedido).ToString(),
                            Obras = ModelDefinedFunctions.Pedidos_Obras(a.IdPedido).ToString(),
                            ProveedoresCodigo = a.Proveedor.CodigoEmpresa != null ? a.Proveedor.CodigoEmpresa : "",
                            ProveedoresNombre = a.Proveedor.RazonSocial != null ? a.Proveedor.RazonSocial : "",
                            TotalGravado = (a.TotalPedido ?? 0) - (a.TotalIva1 ?? 0) + (a.Bonificacion ?? 0) - (a.ImpuestosInternos ?? 0) - (a.OtrosConceptos1 ?? 0) - (a.OtrosConceptos2 ?? 0) - (a.OtrosConceptos3 ?? 0) - (a.OtrosConceptos4 ?? 0) - (a.OtrosConceptos5 ?? 0),
                            ImporteBonificacion = a.Bonificacion ?? 0,
                            ImporteIva1 = a.TotalIva1 ?? 0,
                            OtrosConceptos = (a.OtrosConceptos1 ?? 0) + (a.OtrosConceptos2 ?? 0) + (a.OtrosConceptos3 ?? 0) + (a.OtrosConceptos4 ?? 0) + (a.OtrosConceptos5 ?? 0),
                            ImpuestosInternos = (a.ImpuestosInternos ?? 0),
                            ImporteTotal = a.TotalPedido,
                            Moneda = a.Moneda == null ? "" : a.Moneda.Abreviatura,
                            Comprador = b != null ? b.Nombre : "",
                            LiberadoPor = c != null ? c.Nombre : "",
                            CantidadItems = a.DetallePedidos.Count(),
                            NumeroComparativa = a.NumeroComparativa ?? 0,
                            TiposCompra = d != null ? d.Descripcion : "",
                            Observaciones = a.Observaciones ?? "",
                            CondicionCompra = e != null ? e.Descripcion : "",
                            DetalleCondicionCompra = a.DetalleCondicionCompra ?? "",
                            PedidoExterior = a.PedidoExterior ?? "",
                            NumeroLicitacion = a.NumeroLicitacion ?? "",
                            Impresa = a.Impresa ?? "",
                            UsuarioAnulo = a.UsuarioAnulacion ?? "",
                            FechaAnulacion = a.FechaAnulacion,
                            MotivoAnulacion = a.MotivoAnulacion ?? "",
                            EquipoDestino = ModelDefinedFunctions.Pedidos_EquiposDestino(a.IdPedido).ToString(),
                            CircuitoFirmasCompleto = a.CircuitoFirmasCompleto ?? "",
                            DescripcionIva = f != null ? f.Descripcion : "",
                            FechaEnvioProveedor = a.FechaEnvioProveedor,
                            Detalle = a.Detalle ?? "",
                        }).Where(p => (p.Cumplido ?? "") != "SI" && (p.Cumplido ?? "") != "AN" && (p.CircuitoFirmasCompleto ?? "") == "SI" && (IdProveedor1 <= 0 || p.IdProveedor == IdProveedor1) && (Destino != "ComprobanteProveedor" || db.DetallePedidos.Where(q => q.IdPedido == p.IdPedido && (db.DetalleComprobantesProveedores.Where(r => r.IdDetallePedido == q.IdDetallePedido).Count() > 0)).Count() == 0)).OrderBy(sidx + " " + sord).AsQueryable();
            
            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<Pedidos2>
                                     (sidx, sord, page, rows, _search, filters, db, ref totalRecords, data);

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in pagedQuery
                        select new jqGridRowJson
                        {
                            id = a.IdPedido.ToString(),
                            cell = new string[] { 
                                //"<a href="+ Url.Action("Edit",new {id = a.IdPedido} ) + " target='' >Editar</>" ,
                                "<a href="+ Url.Action("Edit",new {id = a.IdPedido} ) + "  >Editar</>" ,
                                a.IdPedido.ToString(), 
                                a.IdProveedor.NullSafeToString(), 
                                a.IdCondicionCompra.NullSafeToString(), 
                                a.NumeroPedido.NullSafeToString(), 
                                a.SubNumero.NullSafeToString(), 
                                a.FechaPedido==null ? "" :  a.FechaPedido.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaSalida==null ? "" :  a.FechaSalida.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Cumplido.NullSafeToString(), 
                                a.Requerimientos.NullSafeToString(), 
                                a.Obras.NullSafeToString(), 
                                a.ProveedoresCodigo.NullSafeToString(), 
                                a.ProveedoresNombre.NullSafeToString(), 
                                a.TotalGravado.NullSafeToString(), 
                                a.ImporteBonificacion.NullSafeToString(), 
                                a.ImporteIva1.NullSafeToString(), 
                                a.OtrosConceptos.NullSafeToString(), 
                                a.ImpuestosInternos.NullSafeToString(), 
                                a.ImporteTotal.NullSafeToString(), 
                                a.Moneda.NullSafeToString(), 
                                a.Comprador.NullSafeToString(), 
                                a.LiberadoPor.NullSafeToString(), 
                                a.CantidadItems.NullSafeToString(), 
                                a.NumeroComparativa.NullSafeToString(), 
                                a.TiposCompra.NullSafeToString(), 
                                a.Observaciones.NullSafeToString(), 
                                a.CondicionCompra.NullSafeToString(), 
                                a.DetalleCondicionCompra.NullSafeToString(), 
                                a.PedidoExterior.NullSafeToString(), 
                                a.NumeroLicitacion.NullSafeToString(), 
                                a.Impresa.NullSafeToString(), 
                                a.UsuarioAnulo.NullSafeToString(), 
                                a.FechaAnulacion.NullSafeToString(), 
                                a.MotivoAnulacion.NullSafeToString(), 
                                a.EquipoDestino.NullSafeToString(), 
                                a.CircuitoFirmasCompleto.NullSafeToString(), 
                                a.DescripcionIva.NullSafeToString(), 
                                a.FechaEnvioProveedor.NullSafeToString(), 
                                a.Detalle.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetPedidos(string sidx, string sord, int page, int rows, bool _search, string filters, int? IdPedido)
        {
            int IdPedido1 = IdPedido ?? 0;

            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.DetallePedidos
                        from b in db.ControlesCalidads.Where(o => o.IdControlCalidad == a.IdControlCalidad).DefaultIfEmpty()
                        select new DetallePedidos2
                        {
                            IdDetallePedido = a.IdDetallePedido,
                            IdPedido = a.IdPedido,
                            IdArticulo = a.IdArticulo,
                            IdUnidad = a.IdUnidad,
                            IdControlCalidad = a.IdControlCalidad,
                            OrigenDescripcion = a.OrigenDescripcion,
                            IdDetalleRequerimiento = a.IdDetalleRequerimiento,
                            IdDetalleAcopios = a.IdDetalleAcopios,
                            NumeroPedido = a.Pedido.NumeroPedido,
                            FechaPedido = a.Pedido.FechaPedido,
                            NumeroItem = a.NumeroItem,
                            Cantidad = a.Cantidad,
                            Unidad = a.Unidad.Abreviatura,
                            Codigo = a.Articulo.Codigo,
                            Articulo = a.Articulo.Descripcion,
                            Precio = a.Precio,
                            PorcentajeBonificacion = a.PorcentajeBonificacion,
                            Importebonificacion = a.Importebonificacion,
                            PorcentajeIVA = a.PorcentajeIVA,
                            ImporteIva = a.ImporteIva,
                            ImporteTotalItem = a.ImporteTotalItem,
                            Obra = a.DetalleRequerimiento.Requerimientos.Obra.Descripcion,
                            Observaciones = a.Observaciones,
                            TiposDeDescripcion = (a.OrigenDescripcion ?? 1) == 1 ? "Solo material" : ((a.OrigenDescripcion ?? 1) == 2 ? "Solo observaciones" : ((a.OrigenDescripcion ?? 1) == 3 ? "Material + observaciones" : "")),
                            FechaEntrega = a.FechaEntrega,
                            FechaNecesidad = a.FechaNecesidad,
                            NumeroRequerimiento = a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            NumeroItemRM = a.DetalleRequerimiento.NumeroItem,
                            Cumplido = a.Cumplido,
                            DescripcionControlCalidad = b != null ? b.Descripcion : "",
                            ArchivoAdjunto1 = a.ArchivoAdjunto1,
                            ArchivoAdjunto2 = a.ArchivoAdjunto2,
                            ArchivoAdjunto3 = a.ArchivoAdjunto3,
                            ArchivoAdjunto4 = a.ArchivoAdjunto4,
                            ArchivoAdjunto5 = a.ArchivoAdjunto5,
                            ArchivoAdjunto6 = a.ArchivoAdjunto6,
                            ArchivoAdjunto7 = a.ArchivoAdjunto7,
                            ArchivoAdjunto8 = a.ArchivoAdjunto8,
                            ArchivoAdjunto9 = a.ArchivoAdjunto9,
                            ArchivoAdjunto10 = a.ArchivoAdjunto10,
                            Aprobo = a.Pedido.Aprobo,
                            CircuitoFirmasCompleto = a.Pedido.CircuitoFirmasCompleto
                        }).Where(a => a.IdPedido == IdPedido1).OrderBy(sidx + " " + sord).AsQueryable();  //.Where(a => (IdPedido1 <= 0 || a.IdPedido == IdPedido1)).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<DetallePedidos2>(sidx, sord, page, rows, _search, filters, db, ref totalRecords, data);

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in pagedQuery
                        select new jqGridRowJson
                        {
                            id = a.IdDetallePedido.ToString(),
                            cell = new string[] { 
                                a.IdDetallePedido.ToString(), 
                                a.IdPedido.NullSafeToString(), 
                                a.IdArticulo.NullSafeToString(), 
                                a.IdUnidad.NullSafeToString(), 
                                a.IdControlCalidad.NullSafeToString(), 
                                a.OrigenDescripcion.NullSafeToString(), 
                                a.IdDetalleRequerimiento.NullSafeToString(), 
                                a.IdDetalleAcopios.NullSafeToString(), 
                                a.NumeroPedido.NullSafeToString(), 
                                a.FechaPedido.NullSafeToString(), 
                                a.NumeroItem.NullSafeToString(), 
                                a.Cantidad.NullSafeToString(), 
                                a.Unidad.NullSafeToString(), 
                                a.Codigo.NullSafeToString(), 
                                a.Articulo.NullSafeToString(), 
                                a.Precio.NullSafeToString(), 
                                a.PorcentajeBonificacion.NullSafeToString(), 
                                a.Importebonificacion.NullSafeToString(), 
                                a.PorcentajeIVA.NullSafeToString(), 
                                a.ImporteIva.NullSafeToString(), 
                                a.ImporteTotalItem.NullSafeToString(), 
                                a.Obra.NullSafeToString(), 
                                a.Observaciones.NullSafeToString(), 
                                a.TiposDeDescripcion.NullSafeToString(), 
                                a.FechaEntrega.NullSafeToString(), 
                                a.FechaNecesidad.NullSafeToString(), 
                                a.NumeroRequerimiento.NullSafeToString(), 
                                a.NumeroItemRM.NullSafeToString(), 
                                a.Cumplido.NullSafeToString(), 
                                a.DescripcionControlCalidad.NullSafeToString(), 
                                a.ArchivoAdjunto1.NullSafeToString(), 
                                a.ArchivoAdjunto2.NullSafeToString(), 
                                a.ArchivoAdjunto3.NullSafeToString(), 
                                a.ArchivoAdjunto4.NullSafeToString(), 
                                a.ArchivoAdjunto5.NullSafeToString(), 
                                a.ArchivoAdjunto6.NullSafeToString(), 
                                a.ArchivoAdjunto7.NullSafeToString(), 
                                a.ArchivoAdjunto8.NullSafeToString(), 
                                a.ArchivoAdjunto9.NullSafeToString(), 
                                a.ArchivoAdjunto10.NullSafeToString(), 
                                a.Aprobo.NullSafeToString(), 
                                a.CircuitoFirmasCompleto.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Pedidos_Pendientes_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            var DetEntidad = db.DetallePedidos.Where(p => (p.Cumplido ?? "") != "SI" && (p.Cumplido ?? "") != "AN" && (p.Pedido.CircuitoFirmasCompleto ?? "") == "SI" && p.Pedido.Aprobo != null).AsQueryable();

            int pageSize = rows;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page;

            var data = (from a in DetEntidad
                        from b in db.Empleados.Where(y => y.IdEmpleado == a.Pedido.IdComprador).DefaultIfEmpty()
                        from c in db.Empleados.Where(y => y.IdEmpleado == a.DetalleRequerimiento.Requerimientos.IdSolicito).DefaultIfEmpty()
                        from d in db.TiposCompras.Where(y => y.IdTipoCompra == a.DetalleRequerimiento.Requerimientos.IdTipoCompra).DefaultIfEmpty()
                        from f in db.ControlesCalidads.Where(o => o.IdControlCalidad == a.DetalleRequerimiento.IdControlCalidad).DefaultIfEmpty()
                        select new DetallePedidos3
                        {
                            IdDetallePedido = a.IdDetallePedido,
                            IdPedido = a.IdPedido,
                            IdProveedor = a.Pedido.IdProveedor,
                            IdObra = a.DetalleRequerimiento.Requerimientos.IdObra,
                            IdArticulo = a.IdArticulo,
                            IdUnidad = a.IdUnidad,
                            NumeroPedido = a.Pedido.NumeroPedido,
                            SubNumero = a.Pedido.SubNumero,
                            ItemPE = a.NumeroItem,
                            FechaPedido = a.Pedido.FechaPedido,
                            Proveedor = a.Pedido.Proveedor.RazonSocial,
                            Obra = a.DetalleRequerimiento.Requerimientos.Obra.NumeroObra,
                            Comprador = b != null ? b.Nombre : "",
                            SolicitoRM = c != null ? c.Nombre : "",
                            FechaEntrega = a.FechaEntrega,
                            ArticuloCodigo = a.Articulo.Codigo,
                            ArticuloDescripcion = a.Articulo.Descripcion,
                            ObservacionesRM = a.DetalleRequerimiento.Observaciones,
                            ObservacionesPE = a.Observaciones,
                            Cantidad = a.Cantidad,
                            Unidad = a.Unidad.Abreviatura,
                            NumeroRequerimiento = a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            ItemRM = a.DetalleRequerimiento.NumeroItem,
                            Cumplido = a.Cumplido,
                            TipoCompra = d != null ? d.Descripcion : "",
                            CircuitoFirmasCompleto = a.Pedido.CircuitoFirmasCompleto,
                            ControlCalidad = f != null ? f.Descripcion : ""
                        }).OrderBy(p => p.NumeroPedido).OrderBy(p => p.ItemPE)
                        //.Skip((currentPage - 1) * pageSize).Take(pageSize)
                        ;

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<DetallePedidos3>
                                     (sidx, sord, page, rows, _search, filters, db, ref totalRecords, data);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in pagedQuery
                        select new jqGridRowJson
                        {
                            id = a.IdDetallePedido.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetallePedido.ToString(), 
                            a.IdPedido.ToString(), 
                            a.IdProveedor.ToString(), 
                            a.IdObra.ToString(), 
                            a.IdArticulo.ToString(), 
                            a.IdUnidad.ToString(),
                            a.NumeroPedido.NullSafeToString(), 
                            a.SubNumero.NullSafeToString(),
                            a.ItemPE.NullSafeToString(),
                            a.FechaPedido == null ? "" : a.FechaPedido.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.Proveedor.NullSafeToString(),
                            a.Obra.NullSafeToString(),
                            a.Comprador.NullSafeToString(),
                            a.SolicitoRM.NullSafeToString(),
                            a.FechaEntrega == null ? "" : a.FechaEntrega.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.ArticuloCodigo.NullSafeToString(),
                            a.ArticuloDescripcion.NullSafeToString(),
                            a.ObservacionesRM.NullSafeToString(),
                            a.ObservacionesPE.NullSafeToString(),
                            a.Cantidad.NullSafeToString(),
                            a.Unidad.NullSafeToString(),
                            db.DetalleRecepciones.Where(x=>x.IdDetallePedido==a.IdDetallePedido && (x.Recepcione.Anulada ?? "") != "SI").Select(x=>x.Cantidad).Sum().ToString(),
                            (a.Cantidad - (db.DetalleRecepciones.Where(x=>x.IdDetallePedido==a.IdDetallePedido && (x.Recepcione.Anulada ?? "") != "SI").Select(x=>x.Cantidad).Sum() ?? 0)).NullSafeToString(),
                            a.NumeroRequerimiento.ToString(), 
                            a.ItemRM.NullSafeToString(), 
                            a.Cumplido.NullSafeToString(), 
                            a.TipoCompra.NullSafeToString(), 
                            a.CircuitoFirmasCompleto.NullSafeToString(),
                            a.ControlCalidad.NullSafeToString()
                        }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult DetPedidosSinFormato(int? IdPedido, int? IdDetallePedido)
        {
            int IdPedido1 = IdPedido ?? 0;
            int IdDetallePedido1 = IdDetallePedido ?? 0;
            var Det = db.DetallePedidos.Where(p => (IdPedido1 <= 0 || p.IdPedido == IdPedido1) && (IdDetallePedido1 <= 0 || p.IdDetallePedido == IdDetallePedido1)).AsQueryable();

            var data = (from a in Det
                        from b in db.Empleados.Where(y => y.IdEmpleado == a.Pedido.IdComprador).DefaultIfEmpty()
                        from c in db.Empleados.Where(y => y.IdEmpleado == a.DetalleRequerimiento.Requerimientos.IdSolicito).DefaultIfEmpty()
                        from d in db.TiposCompras.Where(y => y.IdTipoCompra == a.DetalleRequerimiento.Requerimientos.IdTipoCompra).DefaultIfEmpty()
                        from f in db.ControlesCalidads.Where(o => o.IdControlCalidad == a.DetalleRequerimiento.IdControlCalidad).DefaultIfEmpty()
                        select new
                        {
                            IdDetallePedido = a.IdDetallePedido,
                            IdPedido = a.IdPedido,
                            IdProveedor = a.Pedido.IdProveedor,
                            IdObra = a.DetalleRequerimiento.Requerimientos.IdObra,
                            IdArticulo = a.IdArticulo,
                            IdUnidad = a.IdUnidad,
                            IdControlCalidad = a.DetalleRequerimiento.IdControlCalidad,
                            IdDetalleRequerimiento = a.IdDetalleRequerimiento,
                            IdDetalleAcopios = a.IdDetalleAcopios,
                            OrigenDescripcion = a.OrigenDescripcion,
                            TiposDeDescripcion = (a.OrigenDescripcion ?? 1) == 1 ? "Solo material" : ((a.OrigenDescripcion ?? 1) == 2 ? "Solo observaciones" : ((a.OrigenDescripcion ?? 1) == 3 ? "Material + observaciones" : "")),
                            NumeroPedido = a.Pedido.NumeroPedido,
                            SubNumero = a.Pedido.SubNumero,
                            ItemPE = a.NumeroItem,
                            FechaPedido = a.Pedido.FechaPedido,
                            Proveedor = a.Pedido.Proveedor.RazonSocial,
                            Obra = a.DetalleRequerimiento.Requerimientos.Obra.NumeroObra,
                            Comprador = b != null ? b.Nombre : "",
                            SolicitoRM = c != null ? c.Nombre : "",
                            FechaEntrega = a.FechaEntrega,
                            ArticuloCodigo = a.Articulo.Codigo,
                            ArticuloDescripcion = a.Articulo.Descripcion,
                            ObservacionesRM = a.DetalleRequerimiento.Observaciones,
                            ObservacionesPE = a.Observaciones,
                            Cantidad = a.Cantidad,
                            Unidad = a.Unidad.Abreviatura,
                            Entregado = db.DetalleRecepciones.Where(x => x.IdDetallePedido == a.IdDetallePedido && (x.Recepcione.Anulada ?? "") != "SI").Select(x => x.Cantidad).Sum() ?? 0,
                            Pendiente = (a.Cantidad - (db.DetalleRecepciones.Where(x => x.IdDetallePedido == a.IdDetallePedido && (x.Recepcione.Anulada ?? "") != "SI").Select(x => x.Cantidad).Sum() ?? 0)),
                            Precio = a.Precio,
                            PorcentajeBonificacion = a.PorcentajeBonificacion,
                            Importebonificacion = a.Importebonificacion,
                            PorcentajeIVA = a.PorcentajeIVA,
                            ImporteIva = a.ImporteIva,
                            ImporteTotalItem = a.ImporteTotalItem,
                            NumeroRequerimiento = a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            ItemRM = a.DetalleRequerimiento.NumeroItem,
                            Cumplido = a.Cumplido,
                            TipoCompra = d != null ? d.Descripcion : "",
                            CircuitoFirmasCompleto = a.Pedido.CircuitoFirmasCompleto,
                            ControlCalidad = f != null ? f.Descripcion : "",
                            ArchivoAdjunto1 = a.ArchivoAdjunto1,
                            ArchivoAdjunto2 = a.ArchivoAdjunto2,
                            ArchivoAdjunto3 = a.ArchivoAdjunto3,
                            ArchivoAdjunto4 = a.ArchivoAdjunto4,
                            ArchivoAdjunto5 = a.ArchivoAdjunto5,
                            ArchivoAdjunto6 = a.ArchivoAdjunto6,
                            ArchivoAdjunto7 = a.ArchivoAdjunto7,
                            ArchivoAdjunto8 = a.ArchivoAdjunto8,
                            ArchivoAdjunto9 = a.ArchivoAdjunto9,
                            ArchivoAdjunto10 = a.ArchivoAdjunto10
                        }).OrderBy(p => p.ItemPE).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult DetPedidosParaComprobanteProveedor(int? IdPedido, int? IdDetallePedido)
        {
            int IdPedido1 = IdPedido ?? 0;
            int IdDetallePedido1 = IdDetallePedido ?? 0;

            string nSC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            DataTable dt = EntidadManager.GetStoreProcedure(nSC, "Pedidos_TX_DetallesParaComprobantesProveedores", IdPedido1, IdDetallePedido1, "RESUMEN");
            IEnumerable<DataRow> rows = dt.AsEnumerable();
            var Det = (from r in rows orderby r[2] 
                       select new {
                           IdDetallePedido = r[0],
                           IdArticulo = r[1],
                           NumeroItem = r[2],
                           Cantidad = r[3],
                           ArticuloCodigo = r[4],
                           ArticuloDescripcion = r[5],
                           AlicuotaIVA = r[6],
                           IdCuentaContable = r[7],
                           CuentaCodigo = r[8],
                           CuentaDescripcion = r[9],
                           Importe = r[10],
                           IdObra = r[11],
                           Obra = r[12],
                           IdRubroFinanciero = r[13]
                       }).ToList();

            var data = (from a in Det
                        select new
                        {
                            a.IdDetallePedido,
                            a.IdArticulo,
                            a.NumeroItem,
                            a.Cantidad,
                            a.ArticuloCodigo,
                            a.ArticuloDescripcion,
                            a.AlicuotaIVA,
                            a.IdCuentaContable,
                            a.CuentaCodigo,
                            a.CuentaDescripcion,
                            a.Importe,
                            a.IdObra,
                            a.Obra,
                            a.IdRubroFinanciero
                        }).OrderBy(p => p.NumeroItem).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdRequerimiento, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
        {
            switch (oper)
            {
                case "add": //Validate Input ; Add Method
                    break;
                case "edit":  //Validate Input ; Edit Method
                    break;
                case "del": //Validate Input ; Delete Method
                    break;
                default: break;
            }
        }

        // [HttpPost]
        public virtual ActionResult Anular(int id) //(int id)
        {
            Pedido o = db.Pedidos
                    .Include(x => x.DetallePedidos)
                  .Include(x => x.Proveedor)
                  .SingleOrDefault(x => x.IdPedido == id);
            o.Cumplido = "AN";
            o.MotivoAnulacion = "";
            o.FechaAnulacion = DateTime.Now;
            //  o.UsuarioAnulacion = iniciales( glbIdUsuario);

            db.SaveChanges();

            //            return RedirectToAction("Index");
            return RedirectToAction("Edit", new { id = id });
        }

        public virtual ViewResult ActivarUsuarioYContacto(int idPedido)
        {
            var Pedido = db.Pedidos.Where(x => x.IdPedido == idPedido).FirstOrDefault();
            var Proveedor = db.Proveedores.Where(x => x.IdProveedor == Pedido.IdProveedor).FirstOrDefault();

            var cAcc = new ProntoMVC.Controllers.AccountController();

            var usuarioNuevo = new RegisterModel();
            usuarioNuevo.UserName = Proveedor.Cuit;
            usuarioNuevo.Password = Membership.GeneratePassword(20, 0);  // Proveedor.Cuit + "!";  Membership.GeneratePassword(
            usuarioNuevo.ConfirmPassword = usuarioNuevo.Password;
            usuarioNuevo.Email = Proveedor.Email ?? (usuarioNuevo.UserName + "mscalella911@gmail.com");
            usuarioNuevo.Grupo = Proveedor.Cuit;

            try
            {

                if (Membership.GetUser(usuarioNuevo.UserName) == null)
                {
                    cAcc.Register(usuarioNuevo);
                    cAcc.Verificar(Membership.GetUser(usuarioNuevo.UserName).ProviderUserKey.ToString());

                    Generales.MailAlUsuarioConLaPasswordYElDominio(usuarioNuevo.UserName, usuarioNuevo.Password, usuarioNuevo.Email);
                }
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }

            try
            {
                Roles.AddUserToRole(usuarioNuevo.UserName, "AdminExterno");
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }

            try
            {
                Roles.AddUserToRole(usuarioNuevo.UserName, "Externo");
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }

            try
            {
                Roles.AddUserToRole(usuarioNuevo.UserName, "ExternoCuentaCorrienteProveedor");
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }


            try
            {
                Roles.AddUserToRole(usuarioNuevo.UserName, "ExternoOrdenesPagoListas");
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }

            // tendria que usar createuser y ahi tendria que mandar en el mail la contraseña...

            var usuarioNuevo2 = new RegisterModel();
            if ((Pedido.Contacto ?? "") != "")
            {

                usuarioNuevo2.UserName = Pedido.Contacto;
                if (false)
                {
                    usuarioNuevo2.UserName = Pedido.Contacto.Replace("Sr.", "").Replace("Sra.", "").Replace(".", "").Replace(" ", "");
                    System.Text.RegularExpressions.Regex rgx = new System.Text.RegularExpressions.Regex("[^a-zA-Z0-9 -]");
                    usuarioNuevo2.UserName = rgx.Replace(usuarioNuevo2.UserName, "");
                }
                usuarioNuevo2.Password = Membership.GeneratePassword(20, 0);
                usuarioNuevo2.ConfirmPassword = usuarioNuevo2.Password;
                usuarioNuevo2.Email = Pedido.Contacto; // usuarioNuevo2.UserName + Proveedor.Email ?? "mscalella911@hotmail.com";
                usuarioNuevo2.Grupo = Proveedor.Cuit;
                cAcc.Register(usuarioNuevo2);

                cAcc.Verificar(Membership.GetUser(usuarioNuevo2.UserName).ProviderUserKey.ToString());

                Generales.MailAlUsuarioConLaPasswordYElDominio(usuarioNuevo2.UserName, usuarioNuevo2.Password, usuarioNuevo2.Email);
            }

            try
            {
                Roles.AddUserToRole(usuarioNuevo2.UserName, "Externo");
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }

            try
            {
                Roles.AddUserToRole(usuarioNuevo2.UserName, "ExternoCuentaCorrienteProveedor");
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }


            try
            {
                Roles.AddUserToRole(usuarioNuevo2.UserName, "ExternoOrdenesPagoListas");
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }

            TempData["Alerta"] = "Alta automática de usuarios: " + usuarioNuevo.UserName + " " + usuarioNuevo2.UserName;
            return View("Index");
        }

        public string BuscarOrden(int Numero)
        {
            var Pedidos = db.Pedidos
                //.Where(x => x.Numero == Numero)
                        .AsQueryable();
            var data = (from x in Pedidos select new { x.SubNumero }).OrderByDescending(p => p.SubNumero).FirstOrDefault();
            if (data != null)
                return data.SubNumero.ToString();
            else
                return "1";

        }

        protected override void Dispose(bool disposing)
        {
            if (db != null) db.Dispose();
            base.Dispose(disposing);
        }

        public virtual JsonResult MarcarPE_Impresa(int IdPedido, string Marca)
        {
            string nSC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            EntidadManager.Tarea(nSC, "Pedidos_RegistrarImpresion", IdPedido, Marca, "", DateTime.Today, 0, "");
            return Json(new { Success = 1, IdPedido = IdPedido, ex = "" });
        }

        public string EnviarEmail(int IdPedido, int IdProveedor)
        {
            string NumeroPedido = "";
            string output = "";
            string destinatario = "";
            string asunto = "PE";
            string cuerpo = "";
            string De = "";
            string resul = "";

            var Empresa = db.Empresas.Where(p => p.IdEmpresa == 1).FirstOrDefault();
            if (Empresa != null) { De = Empresa.Email.ToString(); }

            var Pedidos = db.Pedidos.Where(p => p.IdPedido == IdPedido).FirstOrDefault();
            if (Pedidos != null)
            {
                NumeroPedido = Pedidos.NumeroPedido.ToString();
                output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Pedido_" + NumeroPedido + ".pdf"; ;
            }
            ImprimirPDF(IdPedido, output).ToString();

            var Proveedor = db.Proveedores.Where(p => p.IdProveedor == IdProveedor).FirstOrDefault();
            if (Proveedor != null) { destinatario = Proveedor.Email ?? ""; }

            if (destinatario.Length > 0 && output.Length > 0 && De.Length > 0)
            {
                if (EntidadManager.MandaEmail_Nuevo(destinatario,
                                                    asunto,
                                                    cuerpo,
                                                    De,
                                                    ConfigurationManager.AppSettings["SmtpServer"],
                                                    ConfigurationManager.AppSettings["SmtpUser"],
                                                    ConfigurationManager.AppSettings["SmtpPass"],
                                                    output,
                                                    Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]))
                    )
                {
                    resul = "Ok";
                }
                else
                {
                    resul = "Error";
                }
            }
            else
            {
                resul = "Error";
            }

            FileInfo MyFile1 = new FileInfo(output);
            if (MyFile1.Exists)
            {
                System.GC.Collect();
                System.GC.WaitForPendingFinalizers();
                System.IO.File.Delete(output);
                //MyFile1.Delete();
            }

            return resul;
        }
    
    }
}

