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


// using ProntoMVC.Controllers.Logica;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;//using DocumentFormat.OpenXml.Spreadsheet;
//using OpenXmlPowerTools;
using System.Diagnostics;
using ClosedXML.Excel;
using System.IO;

namespace ProntoMVC.Controllers
{

    //   [Authorize(Roles = "Administrador,SuperAdmin,Compras")] //ojo que el web.config tambien te puede bochar hacia el login
    public partial class AsientoController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.Asientos)) throw new Exception("No tenés permisos");

            //if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
            //    !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
            //    !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
            //    ) throw new Exception("No tenés permisos");

            //var Pedidos = db.Pedidos.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }
        public virtual ViewResult IndexExterno()
        {
            if (!PuedeLeer(enumNodos.Asientos)) throw new Exception("No tenés permisos");

            //var Pedidos = db.Pedidos.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }
        public virtual ViewResult Details(int id)
        {
            Pedido Pedido = db.Pedidos.Find(id);
            return View(Pedido);
        }



        public virtual FileResult Imprimir(int id, bool bAgruparItems = false) //(int id)
        {
            // string sBasePronto = (string)rc.HttpContext.Session["BasePronto"];
            // db = new DemoProntoEntities(Funciones.Generales.sCadenaConex(sBasePronto));



            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            //  string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString);
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.docx"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            //string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Requerimiento1_ESUCO_PUNTONET.docx";
            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Pedido_Autotrol_PUNTONET.docx";
            //string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Pedido_ESUCO_PUNTONET.docx";


            System.IO.FileInfo MyFile2 = new System.IO.FileInfo(plantilla);//busca si ya existe el archivo a generar y en ese caso lo borra

            if (!MyFile2.Exists)
            {
                //usar la de sql
                plantilla = Pronto.ERP.Bll.OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.FacturaA, SC);

            }


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
                       ).ToList()
                     ;


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




                ///////////////////////////////
                ///////////////////////////////
                ///////////////////////////////
                ///////////////////////////////


                /// datos del comprador

                regexReplace(ref docText, "#Comprador#", (oFac.Comprador ?? new Empleado()).Nombre.NullSafeToString());
                regexReplace(ref docText, "#EmailComprador#", (oFac.Comprador ?? new Empleado()).Email.NullSafeToString());
                regexReplace(ref docText, "#TelefonoComprador#", (oFac.Comprador ?? new Empleado()).Interno.NullSafeToString());
                regexReplace(ref docText, "#FaxComprador#", "");


                ///////////////////////////////
                ///////////////////////////////
                ///////////////////////////////
                ///////////////////////////////
                ///////////////////////////////
                ///////////////////////////////

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


                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //CUERPO  (repetir renglones)
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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






        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer(enumNodos.Asientos)) throw new Exception("No tenés permisos");
            if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
             !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
             !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
             ) throw new Exception("No tenés permisos");

            if (id == -1)
            {
                Asiento Asiento = new Asiento();

                inic(ref Asiento);

                CargarViewBag(Asiento);


                return View(Asiento);
            }
            else
            {

                Asiento Asiento = db.Asientos.Find(id);
                //CargarViewBag(Asiento);
                Session.Add("Asiento", Asiento);
                return View(Asiento);
            }


        }




        [HttpPost]
        public virtual JsonResult BatchUpdate(Asiento Asiento) // el Exclude es para las altas, donde el Id viene en 0
        {
            if (!PuedeEditar(enumNodos.Asientos)) throw new Exception("No tenés permisos");

            try
            {
                string erar = "", w = "";


                if (!Validar(Asiento, ref erar, ref w))
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    List<string> errors = new List<string>();
                    errors.Add(erar);
                    return Json(errors);
                }



                if (ModelState.IsValid || true)
                {
                    if (Asiento.IdAsiento > 0)
                    {

                        //if (SeCambioLaCuenta())
                        //{
                        //    GuardarHistoricoDeCambio();
                        //}

                        UpdateColeccion(Asiento);


                        //var EntidadOriginal = db.Asientos.Where(p => p.IdAsiento == Asiento.IdAsiento).SingleOrDefault();
                        //var EntidadEntry = db.Entry(EntidadOriginal);
                        //EntidadEntry.CurrentValues.SetValues(Asiento);

                        //db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;

                        //UpdateColecciones(ref Articulo);
                    }
                    else
                    {
                        Parametros parametros = db.Parametros.Find(1);
                        Asiento.NumeroAsiento = parametros.ProximoAsiento;
                        parametros.ProximoAsiento = parametros.ProximoAsiento + 1;
                        db.Entry(parametros).State = System.Data.Entity.EntityState.Modified;

                        db.Asientos.Add(Asiento);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdAsiento = Asiento.IdAsiento, ex = "" }); //, DetalleArticulos = Articulo.DetalleArticulos
                }
                else
                {
                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "La Cuenta es inválida";
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

                throw new System.Data.Entity.Validation.DbEntityValidationException(
                    "Entity Validation Failed - errors follow:\n" +
                    sb.ToString(), ex
                ); // Add the original exception as the innerException


            }
            catch (Exception ex)
            {
                JsonResponse res = new JsonResponse();

                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);
                res.Message = ex.Message.ToString();
                return Json(res);
            }
            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }





        void UpdateColeccion(Asiento Asiento)
        {
            var EntidadOriginal = db.Asientos.Where(p => p.IdAsiento == Asiento.IdAsiento).Include(p => p.DetalleAsientos).SingleOrDefault();
            var EntidadEntry = db.Entry(EntidadOriginal);
            EntidadEntry.CurrentValues.SetValues(Asiento);

            foreach (var dr in Asiento.DetalleAsientos)
            {
                var DetalleEntidadOriginal = EntidadOriginal.DetalleAsientos.Where(c => c.IdDetalleAsiento == dr.IdDetalleAsiento && dr.IdDetalleAsiento > 0).SingleOrDefault();
                if (DetalleEntidadOriginal != null)
                {
                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                    DetalleEntidadEntry.CurrentValues.SetValues(dr);
                }
                else
                {
                    EntidadOriginal.DetalleAsientos.Add(dr);
                }
            }

            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleAsientos.Where(c => c.IdDetalleAsiento != 0).ToList())
            {
                if (!Asiento.DetalleAsientos.Any(c => c.IdDetalleAsiento == DetalleEntidadOriginal.IdDetalleAsiento))
                    EntidadOriginal.DetalleAsientos.Remove(DetalleEntidadOriginal);
            }
            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
        }







        private void ActualizacionesVariasPorComprobante(Pedido o)
        {
            // http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11061

            foreach (DetallePedido i in o.DetallePedidos)
            {
                var a = db.DetalleRequerimientos.Where(r => r.IdDetalleRequerimiento == i.IdDetalleRequerimiento).FirstOrDefault();
                if (a != null)
                {

                    if (a.Cantidad == i.Cantidad)
                    {
                        a.Cumplido = "SI"; // 
                    }
                    else
                    {
                        a.Cumplido = "PA";  // no llega a comprar completo el item de requerimiento
                    }

                }




                // http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11061

                var cab = db.Requerimientos.Include(x => x.DetalleRequerimientos).Where(x => x.IdRequerimiento == a.IdRequerimiento).FirstOrDefault();
                if (!cab.DetalleRequerimientos.Where(r => r.Cumplido != "SI" && r.Cumplido != "AN").Any())
                {
                    cab.Cumplido = "SI";
                }
                else if (cab.DetalleRequerimientos.Where(r => r.Cumplido != "SI" && r.Cumplido != "PA").Any())
                {
                    cab.Cumplido = "PA";
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


        public virtual ActionResult Asientos_DynamicGridData
    (string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal)
        {

            //            if (FechaInicial != string.Empty)
            //          {

            DateTime FechaDesde, FechaHasta;
            try
            {
                FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            }
            catch (Exception)
            {

                FechaDesde = DateTime.MinValue;
            }
            try
            {
                FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
            }
            catch (Exception)
            {

                FechaHasta = DateTime.MaxValue;
            }

            //        }



            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////

            string campo = String.Empty;
            int pageSize = rows; // ?? 20;
            int currentPage = page; // ?? 1;

            int totalPages = 0;


            // var Req = db.Asientos.AsQueryable();
            //  Req = Req.Where(r => r.Cumplido == null || (r.Cumplido != "AN" && r.Cumplido != "SI")).AsQueryable();
            var q = (from a in db.Asientos where a.FechaAsiento >= FechaDesde && a.FechaAsiento <= FechaHasta select a).AsQueryable();




            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;

            //var pagedQuery = Filters.FiltroGenerico<Data.Models.Asiento>
            //                    ("",
            //                    sidx, sord, page, rows, _search, filters, db, ref totalRecords
            //                     );

            List<Data.Models.Asiento> pagedQuery =
    Filters.FiltroGenerico_UsandoIQueryable<Data.Models.Asiento>(sidx, sord, page, rows, _search, filters, db, ref totalRecords, q);



            //DetalleRequerimientos.DetallePedidos, DetalleRequerimientos.DetallePresupuestos
            //"Obra,DetalleRequerimientos.DetallePedidos.Pedido,DetalleRequerimientos.DetallePresupuestos.Presupuesto"
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






            try
            {

                //var Req1 = from a in Req.Where(campo) select a.IdCuenta;

                // totalRecords = Req1.Count();
                totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            }
            catch (Exception)
            {

                //                throw;
            }

            //switch (sidx.ToLower())
            //{
            //    case "numerorequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //    case "fecharequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.FechaRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.FechaRequerimiento);
            //        break;
            //    case "numeroobra":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Obra.NumeroObra);
            //        else
            //            Req = Req.OrderBy(a => a.Obra.NumeroObra);
            //        break;
            //    case "libero":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados.Nombre);
            //        break;
            //    case "aprobo":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados1.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados1.Nombre);
            //        break;
            //    case "sector":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Sectores.Descripcion);
            //        else
            //            Req = Req.OrderBy(a => a.Sectores.Descripcion);
            //        break;
            //    case "detalle":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Detalle);
            //        else
            //            Req = Req.OrderBy(a => a.Detalle);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //}

            var data = (from a in pagedQuery
                        select a
            )//.Where(campo).OrderBy(sidx + " " + sord)
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
                            id = a.IdAsiento.ToString(),
                            cell = new string[] { 
                            "<a href="+ Url.Action("Edit",new {id = a.IdAsiento} ) + " target='' >Editar</>" ,
							"<a href="+ Url.Action("Imprimir",new {id = a.IdAsiento} )  +">Imprimir</>" ,
                            a.IdAsiento.ToString(), 
                            
                            a.NumeroAsiento.NullSafeToString(),
                            a.FechaAsiento.NullSafeToString(),
                            a.Tipo.NullSafeToString(),
                            a.IdCuentaSubdiario==null ? "" :  a.AsientoApertura .NullSafeToString(),
                            a.AsientoApertura.NullSafeToString(),
                            a.Concepto.NullSafeToString(),
                            a.DetalleAsientos.Select(x=>x.Debe).Sum().NullSafeToString(),
                            a.DetalleAsientos.Select(x=>x.Haber).Sum().NullSafeToString(),
                            (a.DetalleAsientos.Select(x=>x.Debe).Sum()-a.DetalleAsientos.Select(x=>x.Haber).Sum()).NullSafeToString(),
                            a.IdIngreso .NullSafeToString(),
                            a.FechaIngreso .NullSafeToString(),
                            a.IdModifico .NullSafeToString(),
                            a.FechaUltimaModificacion .NullSafeToString(),

                            
                            // (a.TiposCuenta==null) ?  "" :  a.TiposCuenta.Descripcion,
                            
 //Case When Asientos.IdCuentaSubdiario is not null Then Titulos.Titulo Else null End as [Subdiario],
 //Case When Asientos.AsientoApertura='NO' Then Null Else Asientos.AsientoApertura End as [Apertura], 
 //Case When Asientos.IdCuentaSubdiario is not null Then Titulos.Titulo Else Asientos.Concepto End as [Concepto], 
 //(Select Sum(IsNull(DetAsi.Debe,0)) From DetalleAsientos DetAsi Where DetAsi.IdAsiento=Asientos.IdAsiento) as [Total debe],
 //(Select Sum(IsNull(DetAsi.Haber,0)) From DetalleAsientos DetAsi Where DetAsi.IdAsiento=Asientos.IdAsiento) as [Total haber],
 //(IsNull((Select Sum(IsNull(DetAsi.Debe,0)) From DetalleAsientos DetAsi Where DetAsi.IdAsiento=Asientos.IdAsiento),0) - 
 // IsNull((Select Sum(IsNull(DetAsi.Haber,0)) From DetalleAsientos DetAsi Where DetAsi.IdAsiento=Asientos.IdAsiento),0)) as [Diferencia],
 //(Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Asientos.IdIngreso) as [Ingreso],
 //Asientos.FechaIngreso as [Fecha ingreso],
 //(Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Asientos.IdModifico) as [Modifico],
 

                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }










        void inic(ref Asiento o)
        {


            Parametros parametros = db.Parametros.Find(1);
            o.NumeroAsiento = parametros.ProximoAsiento;

            //o.SubNumero = 0;
            o.FechaAsiento = DateTime.Today;
            //o.IdMoneda = 1;
            //o.CotizacionMoneda = 1;
            //ViewBag.Proveedor = "";




            //o.Importante = parametros.PedidosImportante;
            //o.Garantia = parametros.PedidosGarantia;
            //o.Documentacion = parametros.PedidosDocumentacion;
            //o.FormaPago = parametros.PedidosFormaPago;
            ////o.ImprimeInspecciones = parametros.PedidosInspecciones;
            //o.LugarEntrega = parametros.PedidosLugarEntrega;
            //o.PlazoEntrega = parametros.PedidosPlazoEntrega;


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

            //mvarP_IVA1 = .Fields("Iva1").Value
            //mvarP_IVA2 = .Fields("Iva2").Value
            //mvarPorc_IBrutos_Cap = .Fields("Porc_IBrutos_Cap").Value
            //mvarTope_IBrutos_Cap = .Fields("Tope_IBrutos_Cap").Value
            //mvarPorc_IBrutos_BsAs = .Fields("Porc_IBrutos_BsAs").Value
            //mvarTope_IBrutos_BsAs = .Fields("Tope_IBrutos_BsAs").Value
            //mvarPorc_IBrutos_BsAsM = .Fields("Porc_IBrutos_BsAsM").Value
            //mvarTope_IBrutos_BsAsM = .Fields("Tope_IBrutos_BsAsM").Value
            //mvarDecimales = .Fields("Decimales").Value
            //mvarAclaracionAlPie = .Fields("AclaracionAlPieDeFactura").Value
            //mvarIdMonedaPesos = .Fields("IdMoneda").Value
            //mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
            //mvarPercepcionIIBB = IIf(IsNull(.Fields("PercepcionIIBB").Value), "NO", .Fields("PercepcionIIBB").Value)
            //mvarOtrasPercepciones1 = IIf(IsNull(.Fields("OtrasPercepciones1").Value), "NO", .Fields("OtrasPercepciones1").Value)
            //mvarOtrasPercepciones1Desc = IIf(IsNull(.Fields("OtrasPercepciones1Desc").Value), "", .Fields("OtrasPercepciones1Desc").Value)
            //mvarOtrasPercepciones2 = IIf(IsNull(.Fields("OtrasPercepciones2").Value), "NO", .Fields("OtrasPercepciones2").Value)
            //mvarOtrasPercepciones2Desc = IIf(IsNull(.Fields("OtrasPercepciones2Desc").Value), "", .Fields("OtrasPercepciones2Desc").Value)
            //mvarOtrasPercepciones3 = IIf(IsNull(.Fields("OtrasPercepciones3").Value), "NO", .Fields("OtrasPercepciones3").Value)
            //mvarOtrasPercepciones3Desc = IIf(IsNull(.Fields("OtrasPercepciones3Desc").Value), "", .Fields("OtrasPercepciones3Desc").Value)
            //mvarConfirmarClausulaDolar = IIf(IsNull(.Fields("ConfirmarClausulaDolar").Value), "NO", .Fields("ConfirmarClausulaDolar").Value)
            //mvarNumeracionUnica = False
            //If .Fields("NumeracionUnica").Value = "SI" Then mvarNumeracionUnica = True
            //gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)


            // db.Cotizaciones_TX_PorFechaMoneda(fecha,IdMoneda)
            var mvarCotizacion = db.Cotizaciones.OrderByDescending(x => x.IdCotizacion).FirstOrDefault().Cotizacion; //  mo  Cotizacion(Date, glbIdMonedaDolar);
            //o.CotizacionMoneda = 1;
            ////  o.CotizacionADolarFijo=
            //o.CotizacionDolar = (decimal)mvarCotizacion;

            //o.DetalleFacturas.Add(new DetalleFactura());
            //o.DetalleFacturas.Add(new DetalleFactura());
            //o.DetalleFacturas.Add(new DetalleFactura());

        }


        //public ActionResult Create()
        //{
        //    ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion");
        //    ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre");
        //    ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion");
        //    ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
        //    ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
        //    ViewBag.Proveedor = "";
        //    return View();
        //}






        public virtual JsonResult Autorizaciones(int IdPedido)
        {

            var Autorizaciones = db.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.NotaPedido, IdPedido);
            return Json(Autorizaciones, JsonRequestBehavior.AllowGet);
        }

        void CargarViewBag(Asiento o)
        {


            //ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras.OrderBy(x => x.Descripcion), "IdCondicionCompra", "Descripcion", o.IdCondicionCompra);
            //ViewBag.IdMoneda = new SelectList(db.Monedas.OrderBy(x => x.Nombre), "IdMoneda", "Nombre", o.IdMoneda);
            //ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas.OrderBy(x => x.Descripcion), "IdPlazoEntrega", "Descripcion", o.PlazoEntrega);


            /////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////
            //string nSC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            //DataTable dt = EntidadManager.GetStoreProcedure(nSC, "Empleados_TX_PorSector", "Compras");
            //IEnumerable<DataRow> rows = dt.AsEnumerable();
            //var sq = (from r in rows select new { IdEmpleado = r[0], Nombre = r[1] }).ToList();
            //// ViewBag.Aprobo = new SelectList(db.Empleados.Where(x => (x.Activo ?? "SI") == "SI"  ).OrderBy(x => x.Nombre), "IdEmpleado", "Nombre", o.Aprobo);

            //ViewBag.Aprobo = new SelectList(sq, "IdEmpleado", "Nombre", o.Aprobo);
            //ViewBag.IdComprador = new SelectList(sq, "IdEmpleado", "Nombre", o.IdComprador);

            /////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////



            //ViewBag.Proveedor = (db.Proveedores.Find(o.IdProveedor) ?? new Proveedor()).RazonSocial;

            //ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", (o.Proveedor ?? new Proveedor()).IdCodigoIva);
            //try
            //{
            //    ViewBag.CantidadAutorizaciones = db.Autorizaciones_TX_CantidadAutorizaciones((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.NotaPedido, o.TotalPedido * o.CotizacionMoneda, -1).Count();
            //}
            //catch (Exception e)
            //{

            //    ErrHandler.WriteError(e);
            //}




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


        private bool Validar(ProntoMVC.Data.Models.Asiento o, ref string sErrorMsg, ref string sWarningMsg)
        {
            // una opcion es extender el modelo autogenerado, para ensoquetar ahí las validaciones
            // si no, podemos usar una funcion como esta, y devolver los  errores de dos maneras:
            // con ModelState.AddModelError si los devolvemos en una ViewResult,
            // o con un array de strings si es una JsonResult.
            //
            // if you are returning JSON, you cannot use ModelState.
            // http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json



            //res.Errors = GetModelStateErrorsAsString(this.ModelState);


            if (o.FechaAsiento == null)
            {
                sErrorMsg += "\n" + "Falta la fecha del asiento";
            }


            if ((o.Concepto ?? "") == "")
            {
                sErrorMsg += "\n" + "Falta el concepto";
            }



            //string OrigenDescripcionDefault = BuscaINI("OrigenDescripcion en 3 cuando hay observaciones");


            //         Dim mvarImprime As Integer, mvarNumero As Integer, i As Integer
            //         Dim mvarErr As String, mvarControlFechaNecesidad As String, mAuxS5 As String, mAuxS6 As String
            //         Dim PorObra As Boolean, mTrasabilidad_RM_LA As Boolean, mConAdjuntos As Boolean

            bool mExigirTrasabilidad_RMLA_PE = false, PorObra, mTrasabilidad_RM_LA = false;
            string mvarControlFechaNecesidad = "";
            string mAuxS5 = "";
            int mIdObra = 0;
            int mIdTipoCuenta = 0;


            decimal debe = 0, haber = 0;


            var reqsToDelete = o.DetalleAsientos.Where(x => (x.IdCuenta ?? 0) <= 0).ToList();

            for (int i = 0; i < reqsToDelete.Count; i++)
            {
                var deleteReq = reqsToDelete[i];

                if ((deleteReq.Debe ?? 0) != 0 || (deleteReq.Haber ?? 0) != 0) sErrorMsg += "\n" + "El item " + (i+1).ToString() + " no tiene cuenta";
                o.DetalleAsientos.Remove(deleteReq);
            }


            if (o.DetalleAsientos.Count <= 0) sErrorMsg += "\n" + "El asiento no tiene items";


            foreach (ProntoMVC.Data.Models.DetalleAsiento x in o.DetalleAsientos)
            {
                var c = db.Cuentas.Find(x.IdCuenta);
                if (c == null) continue;

                string nombre = x.Item + " El item " + x.Item + "  (" + c.Descripcion + ") ";

                debe += x.Debe ?? 0;
                haber += x.Haber ?? 0;

                if ((x.Item ?? 0) <= 0) x.Item=o.DetalleAsientos.Select(y=>y.Item ?? 0 ).Max()  +1;

                if (false && !PorObra)
                {
                    sErrorMsg += "\n" + nombre + " no tiene indicado centro de costo";
                    //break;
                }

                if (x.Debe > 0 && x.Haber > 0) sErrorMsg += "\n" + nombre + " debe tener indicado el debe o el haber";
                if (x.Debe == 0 && x.Haber == 0) sErrorMsg += "\n" + nombre + " debe tener indicado el debe o el haber";


            }

            if (debe != haber) sErrorMsg += "\n" + "El asiento no suma cero (diferencia: " + (debe - haber).ToString() + ")";



            sErrorMsg = sErrorMsg.Replace("\n", "<br/>"); //     ,"&#13;&#10;"); // "<br/>");
            if (sErrorMsg != "") return false;
            return true;

        }




        public virtual ActionResult EditExterno(int id)
        {




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
            Asiento asiento = db.Asientos.Find(id);
            db.Asientos.Remove(asiento);
            db.SaveChanges();
            return RedirectToAction("Index");
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
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaingreso":
                        //No anda
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                    default:
                        if (searchOper == "eq")
                        {
                            campo = String.Format("{0} = {1}", searchField, searchString);
                        }
                        else
                        {
                            campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        }
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

            var data = (from a in Entidad


                           .Include(x => x.Proveedor)
                        //  .Include("DetallePedidos.IdDetalleRequerimiento") // funciona tambien
                        //.Include(x => x.DetallePedidos.Select(y => y. y.IdDetalleRequerimiento))
                        // .Include(x => x.Aprobo)
                        select

                        a
                //                        new
                //                        {
                //                            IdPedido = a.IdPedido,

//                            Numero = a.NumeroPedido,
                //                            fecha
                //                            fechasalida
                //                            cumpli
                //                            rms
                //                            obras
                //                            proveedor
                //                            neto gravado
                //                            bonif
                //                            total iva


//// IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)-  
                //// IsNull(Pedidos.ImpuestosInternos,0)-IsNull(Pedidos.OtrosConceptos1,0)-IsNull(Pedidos.OtrosConceptos2,0)-  
                //// IsNull(Pedidos.OtrosConceptos3,0)-IsNull(Pedidos.OtrosConceptos4,0)-IsNull(Pedidos.OtrosConceptos5,0)as [Neto gravado],  
                //// Case When Bonificacion=0 Then Null Else Bonificacion End as [Bonificacion],  

//// Case When TotalIva1=0 Then Null Else TotalIva1 End as [Total Iva],  

//// IsNull(Pedidos.ImpuestosInternos,0)+IsNull(Pedidos.OtrosConceptos1,0)+IsNull(Pedidos.OtrosConceptos2,0)+  
                //// IsNull(Pedidos.OtrosConceptos3,0)+IsNull(Pedidos.OtrosConceptos4,0)+IsNull(Pedidos.OtrosConceptos5,0)as [Otros Conceptos],  
                //// TotalPedido as [Total pedido],  





//                        }


                        ).Where(campo).OrderBy(sidx + " " + sord)
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
                                //"<a href="+ Url.Action("Edit",new {id = a.IdPedido} ) + " target='' >Editar</>" ,
                                "<a href="+ Url.Action("Edit",new {id = a.IdPedido} ) + "  >Editar</>" ,
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


        public virtual ActionResult DetAsientos(string sidx, string sord, int? page, int? rows, int? IdAsiento)
        {
            int IdAsiento1 = IdAsiento ?? 0;
            var DetEntidad = db.DetalleAsientos.Where(p => p.IdAsiento == IdAsiento1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;



            var data = DetEntidad.OrderBy(p => p.Item)
                //
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
                            id = a.IdDetalleAsiento.ToString(),
                            cell = new string[] { 
                                string.Empty, 
                                a.IdDetalleAsiento.ToString(), 
                                a.IdCuenta.ToString(), 
                                a.Item.ToString(),
                                a.Cuenta==null ? "" : a.Cuenta.Codigo.NullSafeToString(),
                                a.Cuenta==null ? "" : a.Cuenta.Descripcion.NullSafeToString(),
                                a.Obra==null ? "" : a.Obra.Descripcion.NullSafeToString(),
                                
                                a.Debe.NullSafeToString(),
                                a.Haber.NullSafeToString(),
                                a.RegistrarEnAnalitico.NullSafeToString(),
                                
                                a.Detalle,

                                a.Moneda1==null ? "" : a.Moneda1.Abreviatura.NullSafeToString(),
                                a.CotizacionMoneda.NullSafeToString(),
                                a.ImporteEnMonedaDestino.NullSafeToString(),

                                
                                a.Libro.NullSafeToString(),
              //If Option2.Value Then .Fields("Libro").Value = "V"
            //If Option3.Value Then .Fields("Libro").Value = "C"
                                a.TipoImporte.NullSafeToString(),
            //If Option4.Value Then .Fields("TipoImporte").Value = "I"
            //If Option5.Value Then .Fields("TipoImporte").Value = "G"
            //If Option6.Value Then .Fields("TipoImporte").Value = "N"


                                a.NumeroComprobante.NullSafeToString(),
                                a.PorcentajeIVA.NullSafeToString(),
                                a.IdObra.NullSafeToString(),
                                a.IdCuenta.NullSafeToString(),
                                a.IdMonedaDestino.NullSafeToString(),
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
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


        public virtual ActionResult Anular(int id) //(int id)
        {



            Pedido o = db.Pedidos
                    .Include(x => x.DetallePedidos)
                  .Include(x => x.Proveedor)
                  .SingleOrDefault(x => x.IdPedido == id);


            //         Dim oRs As ADOR.Recordset
            //Dim oRs1 As ADOR.Recordset

            //Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(10).BoundText)
            //If oRs.RecordCount > 0 Then
            //   If Len(IIf(IsNull(oRs.Fields("WebService").Value), "", oRs.Fields("WebService").Value)) > 0 Then
            //      Set oRs = Nothing
            //      MsgBox "No puede anular un comprobante electronico (CAE)", vbExclamation
            //      Exit Sub
            //   End If
            //End If
            //oRs.Close

            //Set oRs = Aplicacion.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(mvarId, 1))
            //If oRs.RecordCount > 0 Then
            //   If oRs.Fields("ImporteTotal").Value <> oRs.Fields("Saldo").Value Then
            //      oRs.Close
            //      Set oRs = Nothing
            //      MsgBox "La factura ha sido cancelada parcial o totalmente y no puede anularse", vbExclamation
            //      Exit Sub
            //   End If
            //End If
            //oRs.Close
            //Set oRs = Nothing


            o.MotivoAnulacion = "SI";
            o.FechaAnulacion = DateTime.Now;
            //  o.IdAutorizaAnulacion = 1;


            //If Check3.Value = 1 Then
            //   Set oRs = Aplicacion.Facturas.TraerFiltrado("_NCs_RecuperoGastos", mvarId)
            //   If oRs.RecordCount > 0 Then
            //      If oRs.Fields("IdNotaCredito").Value <> 0 Then
            //         Dim oNC As ComPronto.NotaCredito
            //         Set oNC = Aplicacion.NotasCredito.Item(oRs.Fields("IdNotaCredito").Value)
            //         With oNC
            //            With .Registro
            //               .Fields("Anulada").Value = "OK"
            //               .Fields("IdUsuarioAnulacion").Value = mIdAutorizaAnulacion
            //               .Fields("FechaAnulacion").Value = Now
            //            End With
            //            .Guardar


            ////////////////////////////////////

            //ProntoMVC.Data.Models.CuentasCorrientesDeudor a = new CuentasCorrientesDeudor();
            //a.ImporteTotal = 0;
            //a.Saldo = 0 - o.ImporteTotal; //  a.Saldo = a.Saldo - mImporteAnterior;
            //a.ImporteTotalDolar = 0;
            //a.SaldoDolar = 0;



            //var f = db.Subdiarios.Where(x => x.IdComprobante == o.IdFactura);
            //foreach (Subdiario reg in f)
            //{
            //    db.Subdiarios.Remove(reg);
            //}


            //             If mvarIdentificador > 0 Or mvarAnulada = "SI" Then
            //   Set DatosAnt = oDet.TraerFiltrado("Subdiarios", "_PorIdComprobante", Array(mvarIdentificador, 1))
            //   With DatosAnt
            //      If .RecordCount > 0 Then
            //         .MoveFirst
            //         Do While Not .EOF
            //            oDet.Eliminar "Subdiarios", .Fields(0).Value
            //            .MoveNext
            //         Loop
            //      End If
            //      .Close
            //   End With
            //   Set DatosAnt = Nothing
            //End If
            ///////////////////////////////////////////


            //If oRs.Fields("IdComprobanteProveedor").Value <> 0 Then
            //   Dim oCP As ComPronto.ComprobanteProveedor
            //   Set oCP = Aplicacion.ComprobantesProveedores.Item(oRs.Fields("IdComprobanteProveedor").Value)
            //   With oCP
            //      With .Registro
            //         .Fields("TotalBruto").Value = 0
            //         .Fields("TotalIva1").Value = 0
            //         .Fields("TotalIva2").Value = 0
            //         .Fields("TotalComprobante").Value = 0
            //      End With
            //      Set oRs1 = .DetComprobantesProveedores.TraerTodos
            //      If oRs1.RecordCount > 0 Then
            //         oRs1.MoveFirst
            //         Do While Not oRs1.EOF
            //            With .DetComprobantesProveedores.Item(oRs1.Fields(0).Value)
            //               With .Registro
            //                  .Fields("Importe").Value = 0
            //                  .Fields("IdCuentaIvaCompras1").Value = Null
            //                  .Fields("IVAComprasPorcentaje1").Value = 0
            //                  .Fields("ImporteIVA1").Value = 0
            //                  .Fields("AplicarIVA1").Value = "NO"
            //               End With
            //               .Modificado = True
            //            End With
            //            oRs1.MoveNext
            //         Loop
            //      End If
            //      .Guardar
            //      Set oRs1 = Nothing
            //   End With
            //   Set oCP = Nothing
            //End If
            db.SaveChanges();

            return RedirectToAction("Index");
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
    }
}
















//Sub Emision(ByVal StringConexion As String, ByVal mIdPedido As Long, ByVal Info As String)

//   Dim oAp As ComPronto.Aplicacion
//   Dim oRs As ADOR.Recordset
//   Dim oRsDet As ADOR.Recordset
//   Dim oRsPrv As ADOR.Recordset
//   Dim oRsArt As ADOR.Recordset
//   Dim oRsAux As ADOR.Recordset
//   Dim oRsAux1 As ADOR.Recordset

//   Dim mInfo
//   Dim mPaginas As Integer, i As Integer, j As Integer, Index As Integer
//   Dim mCantidadFirmas As Integer, mCopias As Integer
//   Dim mvarUnidad As String, mvarMedidas As String, mvarLocalidad As String
//   Dim mvarDescripcion As String, mvarAutorizo As String, mPlantilla As String
//   Dim mvarFecha As String, mAdjuntos As String, mNumero As String, mPiePedido As String
//   Dim mResp As String, mvarTag As String, mCarpeta As String, mImprime As String
//   Dim mvarObra As String, mvarMoneda As String, mFormulario As String
//   Dim mConSinAviso As String, mCC As String, mvarCantidad As String, espacios As String
//   Dim mvarUnidadPeso As String, mCodigo As String, mvarDireccion As String
//   Dim mvarOrigen1 As String, mvarOrigen2 As String, mvarDescripcionIva As String
//   Dim mvarNumLet As String, mvarDocumento As String, mvarBorrador As String
//   Dim mvarEmpresa As String, mvarDescBonif As String
//   Dim mPrecio As Double, mTotalItem As Double, mvarSubTotal As Double
//   Dim mvarSubtotalGravado As Double, mvarIVA1 As Double, mvarIVA2 As Double
//   Dim mvarTotalPedido As Double, mvarBonificacionPorItem As Double
//   Dim mvarBonificacion As Double, mvarTotalPeso As Double, mvarTotalImputaciones As Double
//   Dim mvarTotalOrdenPago As Double, mvarTotalDebe As Double, mvarTotalValores As Double
//   Dim mvarCCostos As Long, mIdOPComplementaria As Long
//   Dim mVectorAutorizaciones(10) As Integer
//   Dim HayVariosCCostos As Boolean, mImprimio As Boolean, mItemsAgrupados As Boolean

//   mInfo = VBA.Split(Info, "|")

//   Index = CInt(mInfo(2))
//   mCarpeta = mInfo(3)
//   mImprime = mInfo(4)
//   mCopias = CInt(mInfo(5))
//   mFormulario = mInfo(6)
//   mConSinAviso = mInfo(7)
//   mResp = mInfo(1)
//   If mResp = "C" Then
//   Else
//   End If
//   For j = 0 To 10
//      mVectorAutorizaciones(j) = -1
//   Next
//   If mInfo(8) = "1" Then
//      mItemsAgrupados = True
//   Else
//      mItemsAgrupados = False
//   End If
//   mvarBorrador = mInfo(9)

//   Set oAp = CreateObject("ComPronto.Aplicacion")
//   oAp.StringConexion = StringConexion

//   Set oRs = oAp.Pedidos.TraerFiltrado("_PorId", mIdPedido)
//   If mItemsAgrupados Then
//      Set oRsDet = oAp.Pedidos.TraerFiltrado("_DetallesPorIdPedidoAgrupados", mIdPedido)
//   Else
//      Set oRsDet = oAp.Pedidos.TraerFiltrado("_DetallesPorIdPedido", mIdPedido)
//   End If
//   Set oRsPrv = oAp.Proveedores.Item(oRs.Fields("IdProveedor").Value).Registro

//   Set oRsAux = oAp.TablasGenerales.TraerFiltrado("Empresa", "_Datos")
//   mvarEmpresa = " " & IIf(IsNull(oRsAux.Fields("Nombre").Value), "", oRsAux.Fields("Nombre").Value)
//   oRsAux.Close

//   Selection.HomeKey Unit:=wdStory
//   Selection.MoveDown Unit:=wdLine, Count:=7
//   Selection.MoveLeft Unit:=wdCell, Count:=1

//   With oRsDet
//      Do Until .EOF
//         If mItemsAgrupados Then
//            Selection.MoveRight Unit:=wdCell
//            Selection.TypeText Text:="" & Format(.AbsolutePosition, "##0")
//            Selection.MoveRight Unit:=wdCell, Count:=2
//         Else
//            Selection.MoveRight Unit:=wdCell
//            Selection.TypeText Text:="" & Format(.Fields("NumeroItem").Value, "##0")
//            Selection.MoveRight Unit:=wdCell
//            If Not IsNull(.Fields("IdObra").Value) Then
//               Selection.TypeText Text:="" & oAp.Obras.Item(.Fields("IdObra").Value).Registro.Fields("NumeroObra").Value
//            End If
//            Selection.MoveRight Unit:=wdCell
//            If Not IsNull(.Fields("NumeroAcopio").Value) Then
//               Selection.TypeText Text:="" & .Fields("NumeroAcopio").Value & " - " & .Fields("NumeroItemLA").Value
//            ElseIf Not IsNull(.Fields("NumeroRequerimiento").Value) Then
//               Selection.TypeText Text:="" & .Fields("NumeroRequerimiento").Value & " - " & .Fields("NumeroItemRM").Value
//            End If
//         End If
//         Set oRsArt = oAp.Articulos.Item(.Fields("IdArticulo").Value).Registro
//         mCodigo = IIf(IsNull(oRsArt.Fields("Codigo").Value), "", oRsArt.Fields("Codigo").Value)
//         mvarDescripcion = ""
//         If Not IsNull(.Fields("OrigenDescripcion").Value) Then
//            If .Fields("OrigenDescripcion").Value = 1 Or .Fields("OrigenDescripcion").Value = 3 Then
//               mvarDescripcion = IIf(IsNull(oRsArt.Fields("Descripcion").Value), "", oRsArt.Fields("Descripcion").Value)
//            End If
//            If .Fields("OrigenDescripcion").Value = 2 Or .Fields("OrigenDescripcion").Value = 3 Then
//               If Not IsNull(.Fields("Observaciones").Value) Then
//                  UserForm1.RichTextBox1.TextRTF = .Fields("Observaciones").Value
//                  mvarDescripcion = mvarDescripcion & " " & UserForm1.RichTextBox1.Text
//               End If
//            End If
//         Else
//            mvarDescripcion = IIf(IsNull(oRsArt.Fields("Descripcion").Value), "", oRsArt.Fields("Descripcion").Value)
//         End If
//         mvarUnidad = ""
//         Set oRsAux = oAp.Unidades.Item(.Fields("IdUnidad").Value).Registro
//         If oRsAux.RecordCount > 0 Then
//            mvarUnidad = IIf(IsNull(oRsAux.Fields("Abreviatura").Value), oRsAux.Fields("Descripcion").Value, oRsAux.Fields("Abreviatura").Value)
//         End If
//         oRsAux.Close
//         Selection.MoveRight Unit:=wdCell
//         Selection.TypeText Text:="" & mCodigo
//         Selection.MoveRight Unit:=wdCell
//         Selection.TypeText Text:="" & mvarDescripcion
//         Selection.MoveRight Unit:=wdCell
//         Selection.TypeText Text:="" & Format(.Fields("Cantidad").Value, "Fixed")
//         Selection.MoveRight Unit:=wdCell
//         Selection.TypeText Text:="" & mvarUnidad
//         mvarMedidas = ""
//         mvarUnidad = ""
//         If Not IsNull(oRsArt.Fields("IdCuantificacion").Value) Then
//            If Not IsNull(oRsArt.Fields("Unidad11").Value) Then
//               mvarUnidad = oAp.Unidades.Item(oRsArt.Fields("Unidad11").Value).Registro.Fields("Abreviatura").Value
//            End If
//            Select Case oRsArt.Fields("IdCuantificacion").Value
//               Case 3
//                  mvarMedidas = "" & .Fields("Cantidad1").Value & " x " & .Fields("Cantidad2").Value & " " & mvarUnidad
//               Case 2
//                  mvarMedidas = "" & .Fields("Cantidad1").Value & " " & mvarUnidad
//            End Select
//         End If
//         oRsArt.Close
//         Selection.MoveRight Unit:=wdCell
//         Selection.TypeText Text:="" & mvarMedidas
//         Selection.MoveRight Unit:=wdCell
//         Selection.TypeText Text:="" & Format(.Fields("FechaEntrega").Value, "Short Date")
//         Selection.MoveRight Unit:=wdCell
//         If Not IsNull(.Fields("IdControlCalidad").Value) Then
//            Selection.TypeText Text:="" & _
//               oAp.ControlesCalidad.Item(.Fields("IdControlCalidad").Value).Registro.Fields("Abreviatura").Value
//         End If
//         Selection.MoveRight Unit:=wdCell
//         Selection.TypeText Text:="" & .Fields("Adjunto").Value
//         Selection.MoveRight Unit:=wdCell
//         If mResp = "C" Then
//            mPrecio = .Fields("Precio").Value
//            Selection.TypeText Text:="" & Format(mPrecio, "#,##0.0000")
//            Selection.MoveRight Unit:=wdCell
//            Selection.TypeText Text:="" & .Fields("Moneda").Value
//            Selection.MoveRight Unit:=wdCell
//            If Not IsNull(.Fields("PorcentajeBonificacion").Value) Then
//               Selection.TypeText Text:="" & Format(.Fields("PorcentajeBonificacion").Value, "#0.00")
//            End If
//            Selection.MoveRight Unit:=wdCell
//            If Not IsNull(.Fields("PorcentajeIVA").Value) And _
//                  Not IIf(IsNull(oRs.Fields("PedidoExterior").Value), "NO", oRs.Fields("PedidoExterior").Value) = "SI" Then
//               Selection.TypeText Text:="" & Format(.Fields("PorcentajeIVA").Value, "#0.00")
//            End If
//            mTotalItem = mPrecio * .Fields("Cantidad").Value
//            If Not IsNull(.Fields("ImporteBonificacion").Value) Then
//               mTotalItem = mTotalItem - .Fields("ImporteBonificacion").Value
//            End If
//            Selection.MoveRight Unit:=wdCell
//            Selection.TypeText Text:="" & Format(mTotalItem, "#,##0.00")
//         Else
//            Selection.MoveLeft Unit:=wdCell
//         End If
//         If Not IsNull(.Fields("Observaciones").Value) And Not IsNull(.Fields("OrigenDescripcion").Value) Then
//            If .Fields("OrigenDescripcion").Value = 1 Then
//               If Len(Trim(.Fields("Observaciones").Value)) > 2 Then
//                  UserForm1.RichTextBox1.TextRTF = .Fields("Observaciones").Value
//                  Selection.MoveRight Unit:=wdCell, Count:=1
//                  .MoveNext
//                  If Not .EOF Then
//                     If mResp = "C" Then
//                        Selection.MoveRight Unit:=wdCell, Count:=16
//                     Else
//                        Selection.MoveRight Unit:=wdCell, Count:=12
//                     End If
//                     Selection.MoveUp Unit:=wdLine, Count:=1
//                  End If
//                  .MovePrevious
//                  If mResp = "C" Then
//                     Selection.MoveRight Unit:=wdCharacter, Count:=16, Extend:=wdExtend
//                  Else
//                     Selection.MoveRight Unit:=wdCharacter, Count:=12, Extend:=wdExtend
//                  End If
//                  Selection.Cells.Merge
//                  Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
//                  Selection.TypeText Text:="" & UserForm1.RichTextBox1.Text
//               End If
//            End If
//         End If
//         .MoveNext
//      Loop
//   End With

//   If mResp = "C" Then
//      mvarSubTotal = 0
//      mvarSubtotalGravado = 0
//      mvarIVA1 = 0
//      mvarIVA2 = 0
//      mvarTotalPedido = 0
//      mvarBonificacionPorItem = 0
//      mvarBonificacion = 0
//      Set oRsAux = oAp.Pedidos.TraerFiltrado("_DetallesPorId", mIdPedido)
//      If oRsAux.RecordCount > 0 Then
//         oRsAux.MoveFirst
//         Do While Not oRsAux.EOF
//            If Not IsNull(oRsAux.Fields("ImporteTotalItem").Value) Then
//               mvarSubTotal = mvarSubTotal + oRsAux.Fields("ImporteTotalItem").Value
//            Else
//               mvarSubTotal = mvarSubTotal + (oRsAux.Fields("Precio").Value * oRsAux.Fields("Cantidad").Value)
//            End If
//            If Not IsNull(oRsAux.Fields("ImporteBonificacion").Value) Then
//               mvarBonificacionPorItem = mvarBonificacionPorItem + oRsAux.Fields("ImporteBonificacion").Value
//            End If
//            If Not IsNull(oRsAux.Fields("ImporteIVA").Value) Then
//               mvarIVA1 = mvarIVA1 + oRsAux.Fields("ImporteIVA").Value
//            End If
//            oRsAux.MoveNext
//         Loop
//      End If
//      oRsAux.Close
//      Set oRsAux = Nothing
//      If Not IsNull(oRs.Fields("Bonificacion").Value) Then
//         ' mvarBonificacion = Round((mvarSubTotal - mvarBonificacionPorItem) * oRs.Fields("PorcentajeBonificacion").Value / 100, 2)
//         mvarBonificacion = oRs.Fields("Bonificacion").Value
//      End If
//      mvarSubTotal = mvarSubTotal + mvarBonificacionPorItem + mvarBonificacion - mvarIVA1
//      mvarSubtotalGravado = mvarSubTotal - mvarBonificacion - mvarBonificacionPorItem
//      If IIf(IsNull(oRs.Fields("PedidoExterior").Value), "NO", oRs.Fields("PedidoExterior").Value) = "SI" Then
//         mvarIVA1 = 0
//      End If
//      mvarTotalPedido = mvarSubtotalGravado + mvarIVA1 + mvarIVA2

//      Selection.GoTo What:=wdGoToBookmark, Name:="Totales"
//      Selection.MoveRight Unit:=wdCell, Count:=2
//      Selection.TypeText Text:="" & Format(mvarSubTotal, "#,##0.00")
//      Selection.MoveDown Unit:=wdLine
//      If mvarBonificacionPorItem <> 0 Then
//         Selection.MoveLeft Unit:=wdCell
//         Selection.TypeText Text:="Bonificacion por item"
//         Selection.MoveRight Unit:=wdCell
//         Selection.TypeText Text:="" & Format(mvarBonificacionPorItem, "#,##0.00")
//      End If
//      Selection.MoveDown Unit:=wdLine
//      If mvarBonificacion <> 0 Then
//         Selection.MoveLeft Unit:=wdCell
//         mvarDescBonif = "Bonificacion "
//         If Not IsNull(oRs.Fields("PorcentajeBonificacion").Value) Then
//             mvarDescBonif = mvarDescBonif & " " & Format(oRs.Fields("PorcentajeBonificacion").Value, "Fixed") & "%"
//         End If
//         Selection.TypeText Text:=mvarDescBonif
//         Selection.MoveRight Unit:=wdCell
//         Selection.TypeText Text:="" & Format(mvarBonificacion, "#,##0.00")
//      End If
//      Selection.MoveDown Unit:=wdLine
//      If mvarSubtotalGravado <> 0 Then
//         Selection.MoveLeft Unit:=wdCell
//         Selection.TypeText Text:="Subtotal gravado"
//         Selection.MoveRight Unit:=wdCell
//         Selection.TypeText Text:="" & Format(mvarSubtotalGravado, "#,##0.00")
//      End If
//      Selection.MoveDown Unit:=wdLine
//      If mvarIVA1 <> 0 Then
//         Selection.MoveLeft Unit:=wdCell
//         Selection.TypeText Text:="IVA " ' & Format(mvarP_IVA1, "#,##0.00") & " %"
//         Selection.MoveRight Unit:=wdCell
//         Selection.TypeText Text:="" & Format(mvarIVA1, "#,##0.00")
//      End If
//      Selection.MoveDown Unit:=wdLine
//      If mvarTotalPedido <> 0 Then
//         Selection.TypeText Text:="" & Format(mvarTotalPedido, "#,##0.00")
//      End If
//      Selection.MoveLeft Unit:=wdCell, Count:=1
//      If Not IsNull(oRs.Fields("IdMoneda").Value) Then
//         Selection.TypeText Text:="" & oAp.Monedas.Item(oRs.Fields("IdMoneda").Value).Registro.Fields("Nombre").Value
//      End If
//   End If

//   'Circuito de firmas
//   If ActiveWindow.View.SplitSpecial <> wdPaneNone Then
//       ActiveWindow.Panes(2).Close
//   End If
//   ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageHeader
//   Selection.MoveRight Unit:=wdCell
//   Selection.TypeText Text:="" & mvarEmpresa
//   Selection.MoveRight Unit:=wdCell, Count:=2
//   mNumero = oRs.Fields("NumeroPedido").Value
//   If Not IsNull(oRs.Fields("Subnumero").Value) Then
//      mNumero = mNumero & " / " & oRs.Fields("Subnumero").Value
//   End If
//   If mvarBorrador = "SI" Then mNumero = mNumero & " [Borrador]"
//   Selection.TypeText Text:="" & mNumero
//   Selection.MoveRight Unit:=wdCell, Count:=1
//   mvarFecha = "FECHA :"
//   If Not IsNull(oRs.Fields("Consorcial").Value) Then
//      If oRs.Fields("Consorcial").Value = "SI" Then
//         mvarFecha = mvarFecha & vbCrLf & "(Consorcial)"
//      End If
//   End If
//   Selection.TypeText Text:="" & mvarFecha
//   Selection.MoveRight Unit:=wdCell, Count:=1
//   Selection.TypeText Text:="" & oRs.Fields("FechaPedido").Value

//   ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageFooter
//   Selection.HomeKey Unit:=wdStory
//   Selection.MoveDown Unit:=wdLine, Count:=2

//   If Not IsNull(oRs.Fields("Aprobo").Value) Then
//      Set oRsAux = oAp.Empleados.Item(oRs.Fields("Aprobo").Value).Registro
//      If Not IsNull(oRsAux.Fields("Iniciales").Value) Then
//         mvarAutorizo = "" & oRsAux.Fields("Iniciales").Value
//         If Not IsNull(oRs.Fields("FechaAprobacion").Value) Then
//            mvarAutorizo = mvarAutorizo & "  " & oRs.Fields("FechaAprobacion").Value
//         End If
//         Selection.TypeText Text:="" & mvarAutorizo
//      End If
//      oRsAux.Close
//   End If

//   mCantidadFirmas = 0
//   Set oRsAux = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(4, mvarTotalPedido))
//   If Not oRsAux Is Nothing Then
//      If oRsAux.RecordCount > 0 Then
//         oRsAux.MoveFirst
//         Do While Not oRsAux.EOF
//            mCantidadFirmas = mCantidadFirmas + 1
//            mVectorAutorizaciones(mCantidadFirmas) = oRsAux.Fields(0).Value
//            oRsAux.MoveNext
//         Loop
//      End If
//      oRsAux.Close
//   End If

//   Set oRsAux = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(4, mIdPedido))
//   If oRsAux.RecordCount > 0 Then
//      For j = 1 To mCantidadFirmas
//         mvarAutorizo = ""
//         oRsAux.MoveFirst
//         Do While Not oRsAux.EOF
//            If mVectorAutorizaciones(j) = oRsAux.Fields("OrdenAutorizacion").Value Then
//               Set oRsAux1 = oAp.Empleados.Item(oRsAux.Fields("IdAutorizo").Value).Registro
//               If Not IsNull(oRsAux1.Fields("Iniciales").Value) Then
//                  mvarAutorizo = mvarAutorizo & "" & oRsAux1.Fields("Iniciales").Value
//               End If
//               If Not IsNull(oRsAux.Fields("FechaAutorizacion").Value) Then
//                  mvarAutorizo = mvarAutorizo & " " & oRsAux.Fields("FechaAutorizacion").Value
//               End If
//               oRsAux1.Close
//               If mvarAutorizo = "" Then mvarAutorizo = "???"
//               Selection.MoveRight Unit:=wdCell
//               Selection.TypeText Text:="" & mvarAutorizo
//               Exit Do
//            End If
//            oRsAux.MoveNext
//         Loop
//         If mvarAutorizo = "" Then
//            Selection.MoveRight Unit:=wdCell
//         End If
//      Next
//   End If
//   oRsAux.Close

//   ActiveWindow.ActivePane.View.SeekView = wdSeekMainDocument
//   ActiveDocument.FormFields("Proveedor").Result = oRsPrv.Fields("RazonSocial").Value
//   ActiveDocument.FormFields("Direccion").Result = IIf(IsNull(oRsPrv.Fields("Direccion").Value), "", oRsPrv.Fields("Direccion").Value)
//   mvarLocalidad = ""
//   If Not IsNull(oRsPrv.Fields("CodigoPostal").Value) Then
//      mvarLocalidad = "(" & oRsPrv.Fields("CodigoPostal").Value & ") "
//   End If
//   If Not IsNull(oRsPrv.Fields("IdLocalidad").Value) Then
//      mvarLocalidad = mvarLocalidad & oAp.Localidades.Item(oRsPrv.Fields("IdLocalidad").Value).Registro.Fields("Nombre").Value
//   End If
//   ActiveDocument.FormFields("Localidad").Result = mvarLocalidad
//   ActiveDocument.FormFields("Contacto").Result = "At. " & IIf(IsNull(oRs.Fields("Contacto").Value), "", oRs.Fields("Contacto").Value)
//   ActiveDocument.FormFields("Telefono").Result = IIf(IsNull(oRsPrv.Fields("Telefono1").Value), "", "Tel.: " & oRsPrv.Fields("Telefono1").Value)
//   ActiveDocument.FormFields("Fax").Result = IIf(IsNull(oRsPrv.Fields("Fax").Value), "", "Fax : " & oRsPrv.Fields("Fax").Value)
//   ActiveDocument.FormFields("CuitProveedor").Result = "" & oRsPrv.Fields("Cuit").Value
//   If Not IsNull(oRsPrv.Fields("IdCodigoIva").Value) Then
//      ActiveDocument.FormFields("CondicionIva").Result = oAp.TablasGenerales.TraerFiltrado("DescripcionIva", "_TT", oRsPrv.Fields("IdCodigoIva").Value).Fields("Descripcion").Value
//   End If
//   If Not IsNull(oRsPrv.Fields("Email").Value) Then
//      ActiveDocument.FormFields("EmailProveedor").Result = oRsPrv.Fields("Email").Value
//   End If
//   If Not IsNull(oRs.Fields("NumeroComparativa").Value) Then
//      ActiveDocument.FormFields("NumeroComparativa").Result = oRs.Fields("NumeroComparativa").Value
//   End If
//   If Not IsNull(oRs.Fields("DetalleCondicionCompra").Value) Then
//      ActiveDocument.FormFields("AclaracionCondicion").Result = oRs.Fields("DetalleCondicionCompra").Value
//   End If

//   Set oRsAux = oAp.TablasGenerales.TraerFiltrado("Empresa", "_Datos")
//   ActiveDocument.FormFields("DetalleEmpresa").Result = IIf(IsNull(oRsAux.Fields("DetalleNombre").Value), "", oRsAux.Fields("DetalleNombre").Value)
//   ActiveDocument.FormFields("DireccionCentral").Result = IIf(IsNull(oRsAux.Fields("Direccion").Value), "", oRsAux.Fields("Direccion").Value) & " " & _
//                     IIf(IsNull(oRsAux.Fields("Localidad").Value), "", oRsAux.Fields("Localidad").Value) & " " & _
//                     "(" & IIf(IsNull(oRsAux.Fields("CodigoPostal").Value), "", oRsAux.Fields("CodigoPostal").Value) & ") " & _
//                     IIf(IsNull(oRsAux.Fields("Provincia").Value), "", oRsAux.Fields("Provincia").Value)
//   ActiveDocument.FormFields("DireccionPlanta").Result = IIf(IsNull(oRsAux.Fields("DatosAdicionales1").Value), "", oRsAux.Fields("DatosAdicionales1").Value) & "  " & _
//                     "CUIT : " & IIf(IsNull(oRsAux.Fields("Cuit").Value), "", oRsAux.Fields("Cuit").Value)
//   ActiveDocument.FormFields("TelefonosEmpresa").Result = IIf(IsNull(oRsAux.Fields("Telefono1").Value), "", oRsAux.Fields("Telefono1").Value) & " " & _
//                     "Fax : " & IIf(IsNull(oRsAux.Fields("Telefono2").Value), "", oRsAux.Fields("Telefono2").Value)
//   oRsAux.Close

//   If Not IsNull(oRs.Fields("IdComprador").Value) Then
//      Set oRsAux = oAp.Empleados.Item(oRs.Fields("IdComprador").Value).Registro
//      If oRsAux.RecordCount > 0 Then
//         If Not IsNull(oRsAux.Fields("Nombre").Value) Then
//            ActiveDocument.FormFields("Comprador").Result = oRsAux.Fields("Nombre").Value
//         End If
//         If Not IsNull(oRsAux.Fields("Email").Value) Then
//            ActiveDocument.FormFields("EmailComprador").Result = oRsAux.Fields("Email").Value
//         End If
//         If Not IsNull(oRsAux.Fields("Interno").Value) Then
//            ActiveDocument.FormFields("TelefonoComprador").Result = oRsAux.Fields("Interno").Value
//         End If
//      End If
//      oRsAux.Close
//      Set oRsAux = Nothing
//   End If

//   oRsDet.Close

//   Selection.GoTo What:=wdGoToBookmark, Name:="Notas"

//   If mvarBorrador <> "SI" Then

//      If Not IsNull(oRs.Fields("Importante").Value) Then
//         If IsNull(oRs.Fields("ImprimeImportante").Value) Or oRs.Fields("ImprimeImportante").Value = "SI" Then
//            UserForm1.RichTextBox1.TextRTF = oRs.Fields("Importante").Value
//            Selection.MoveRight Unit:=wdWord, Count:=2, Extend:=wdExtend
//            With Selection.Borders(wdBorderTop)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderLeft)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderBottom)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderRight)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            Selection.HomeKey Unit:=wdLine
//            Selection.TypeText Text:="00 - Importante :"
//            Selection.MoveRight Unit:=wdCell
//            Selection.TypeText Text:="" & UserForm1.RichTextBox1.Text
//            Selection.MoveRight Unit:=wdCell, Count:=3
//         End If
//      End If

//      If Not IsNull(oRs.Fields("PlazoEntrega").Value) Then
//         If IsNull(oRs.Fields("ImprimePlazoEntrega").Value) Or oRs.Fields("ImprimePlazoEntrega").Value = "SI" Then
//            UserForm1.RichTextBox1.TextRTF = oRs.Fields("PlazoEntrega").Value
//            Selection.MoveRight Unit:=wdWord, Count:=2, Extend:=wdExtend
//            With Selection.Borders(wdBorderTop)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderLeft)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderBottom)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderRight)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            Selection.HomeKey Unit:=wdLine
//            Selection.TypeText Text:="01 - Plazo de entrega :"
//            Selection.MoveRight Unit:=wdCell
//            Selection.TypeText Text:="" & UserForm1.RichTextBox1.Text
//            Selection.MoveRight Unit:=wdCell, Count:=3
//         End If
//      End If

//      If Not IsNull(oRs.Fields("LugarEntrega").Value) Then
//         If IsNull(oRs.Fields("ImprimeLugarEntrega").Value) Or oRs.Fields("ImprimeLugarEntrega").Value = "SI" Then
//            UserForm1.RichTextBox1.TextRTF = oRs.Fields("LugarEntrega").Value
//            Selection.MoveRight Unit:=wdWord, Count:=2, Extend:=wdExtend
//            With Selection.Borders(wdBorderTop)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderLeft)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderBottom)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderRight)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            Selection.HomeKey Unit:=wdLine
//            Selection.TypeText Text:="02 - Lugar de entrega :"
//            Selection.MoveRight Unit:=wdCell
//            Selection.TypeText Text:="" & UserForm1.RichTextBox1.Text
//            Selection.MoveRight Unit:=wdCell, Count:=3
//         End If
//      End If

//      If Not IsNull(oRs.Fields("FormaPago").Value) Then
//         If IsNull(oRs.Fields("ImprimeFormaPago").Value) Or oRs.Fields("ImprimeFormaPago").Value = "SI" Then
//            UserForm1.RichTextBox1.TextRTF = oRs.Fields("FormaPago").Value
//            Selection.MoveRight Unit:=wdWord, Count:=2, Extend:=wdExtend
//            With Selection.Borders(wdBorderTop)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderLeft)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderBottom)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderRight)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            Selection.HomeKey Unit:=wdLine
//            Selection.TypeText Text:="03 - Forma de pago :"
//            Selection.MoveRight Unit:=wdCell
//            Selection.TypeText Text:="" & UserForm1.RichTextBox1.Text
//            Selection.MoveRight Unit:=wdCell, Count:=3
//         End If
//      End If

//      If IsNull(oRs.Fields("ImprimeImputaciones").Value) Or oRs.Fields("ImprimeImputaciones").Value = "SI" Then
//'         UserForm1.RichTextBox1.TextRTF = "" & GeneraImputacionesBis(mIdPedido)
//         Selection.MoveRight Unit:=wdWord, Count:=2, Extend:=wdExtend
//         With Selection.Borders(wdBorderTop)
//            .LineStyle = Options.DefaultBorderLineStyle
//            .LineWidth = Options.DefaultBorderLineWidth
//         End With
//         With Selection.Borders(wdBorderLeft)
//            .LineStyle = Options.DefaultBorderLineStyle
//            .LineWidth = Options.DefaultBorderLineWidth
//         End With
//         With Selection.Borders(wdBorderBottom)
//            .LineStyle = Options.DefaultBorderLineStyle
//            .LineWidth = Options.DefaultBorderLineWidth
//         End With
//         With Selection.Borders(wdBorderRight)
//            .LineStyle = Options.DefaultBorderLineStyle
//            .LineWidth = Options.DefaultBorderLineWidth
//         End With
//         Selection.HomeKey Unit:=wdLine
//         Selection.TypeText Text:="04 - Imputación contable :"
//         Selection.MoveRight Unit:=wdCell
//         Selection.TypeText Text:="" & UserForm1.RichTextBox1.Text
//         Selection.MoveRight Unit:=wdCell, Count:=3
//      End If

//      If IsNull(oRs.Fields("ImprimeInspecciones").Value) Or oRs.Fields("ImprimeInspecciones").Value = "SI" Then
//'         UserForm1.RichTextBox1.TextRTF = "" & GeneraInspeccionesBis(mIdPedido)
//         Selection.MoveRight Unit:=wdWord, Count:=2, Extend:=wdExtend
//         With Selection.Borders(wdBorderTop)
//            .LineStyle = Options.DefaultBorderLineStyle
//            .LineWidth = Options.DefaultBorderLineWidth
//         End With
//         With Selection.Borders(wdBorderLeft)
//            .LineStyle = Options.DefaultBorderLineStyle
//            .LineWidth = Options.DefaultBorderLineWidth
//         End With
//         With Selection.Borders(wdBorderBottom)
//            .LineStyle = Options.DefaultBorderLineStyle
//            .LineWidth = Options.DefaultBorderLineWidth
//         End With
//         With Selection.Borders(wdBorderRight)
//            .LineStyle = Options.DefaultBorderLineStyle
//            .LineWidth = Options.DefaultBorderLineWidth
//         End With
//         Selection.HomeKey Unit:=wdLine
//         Selection.TypeText Text:="05 - Inspecciones :"
//         Selection.MoveRight Unit:=wdCell
//         Selection.TypeText Text:="" & UserForm1.RichTextBox1.Text
//         Selection.MoveRight Unit:=wdCell, Count:=3
//      End If

//      If Not IsNull(oRs.Fields("Garantia").Value) Then
//         If IsNull(oRs.Fields("ImprimeGarantia").Value) Or oRs.Fields("ImprimeGarantia").Value = "SI" Then
//            UserForm1.RichTextBox1.TextRTF = oRs.Fields("Garantia").Value
//            Selection.MoveRight Unit:=wdWord, Count:=2, Extend:=wdExtend
//            With Selection.Borders(wdBorderTop)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderLeft)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderBottom)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderRight)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            Selection.HomeKey Unit:=wdLine
//            Selection.TypeText Text:="06 - Garantia :"
//            Selection.MoveRight Unit:=wdCell
//            Selection.TypeText Text:="" & UserForm1.RichTextBox1.Text
//            Selection.MoveRight Unit:=wdCell, Count:=3
//         End If
//      End If

//      If Not IsNull(oRs.Fields("Documentacion").Value) Then
//         If IsNull(oRs.Fields("ImprimeDocumentacion").Value) Or oRs.Fields("ImprimeDocumentacion").Value = "SI" Then
//            UserForm1.RichTextBox1.TextRTF = oRs.Fields("Documentacion").Value
//            Selection.MoveRight Unit:=wdWord, Count:=2, Extend:=wdExtend
//            With Selection.Borders(wdBorderTop)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderLeft)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderBottom)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            With Selection.Borders(wdBorderRight)
//               .LineStyle = Options.DefaultBorderLineStyle
//               .LineWidth = Options.DefaultBorderLineWidth
//            End With
//            Selection.HomeKey Unit:=wdLine
//            Selection.TypeText Text:="07 - Documentación :"
//            Selection.MoveRight Unit:=wdCell
//            Selection.TypeText Text:="" & UserForm1.RichTextBox1.Text
//            Selection.MoveRight Unit:=wdCell, Count:=3
//         End If
//      End If

//      UserForm1.RichTextBox1.TextRTF = IIf(IsNull(oRs.Fields("Observaciones").Value), "", oRs.Fields("Observaciones").Value)
//      Selection.MoveRight Unit:=wdWord, Count:=2, Extend:=wdExtend
//      With Selection.Borders(wdBorderTop)
//         .LineStyle = Options.DefaultBorderLineStyle
//         .LineWidth = Options.DefaultBorderLineWidth
//      End With
//      With Selection.Borders(wdBorderLeft)
//         .LineStyle = Options.DefaultBorderLineStyle
//         .LineWidth = Options.DefaultBorderLineWidth
//      End With
//      With Selection.Borders(wdBorderBottom)
//         .LineStyle = Options.DefaultBorderLineStyle
//         .LineWidth = Options.DefaultBorderLineWidth
//      End With
//      With Selection.Borders(wdBorderRight)
//         .LineStyle = Options.DefaultBorderLineStyle
//         .LineWidth = Options.DefaultBorderLineWidth
//      End With
//      Selection.HomeKey Unit:=wdLine
//      Selection.TypeText Text:="Observaciones :"
//      Selection.MoveRight Unit:=wdCell
//      Selection.TypeText Text:="" & UserForm1.RichTextBox1.Text
//      oRsPrv.Close

//      ActiveWindow.ActivePane.View.SeekView = wdSeekMainDocument

//      'Circuito de firmas
//      If ActiveWindow.View.SplitSpecial <> wdPaneNone Then
//          ActiveWindow.Panes(2).Close
//      End If
//      ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageHeader
//      Selection.MoveRight Unit:=wdCell
//      Selection.TypeText Text:="" & mvarEmpresa
//      Selection.MoveRight Unit:=wdCell, Count:=2
//      mNumero = oRs.Fields("NumeroPedido").Value
//      If Not IsNull(oRs.Fields("Subnumero").Value) Then
//         mNumero = mNumero & " / " & oRs.Fields("Subnumero").Value
//      End If
//      Selection.TypeText Text:="" & mNumero
//      Selection.MoveRight Unit:=wdCell, Count:=2
//      Selection.TypeText Text:="" & oRs.Fields("FechaPedido").Value

//      ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageFooter
//      Selection.HomeKey Unit:=wdStory
//      Selection.MoveDown Unit:=wdLine, Count:=2

//      If Not IsNull(oRs.Fields("Aprobo").Value) Then
//         Set oRsEmp = oAp.Empleados.Item(oRs.Fields("Aprobo").Value).Registro
//         If Not IsNull(oRsEmp.Fields("Iniciales").Value) Then
//            mvarAutorizo = "" & oRsEmp.Fields("Iniciales").Value
//            If Not IsNull(oRs.Fields("FechaAprobacion").Value) Then
//               mvarAutorizo = mvarAutorizo & "  " & oRs.Fields("FechaAprobacion").Value
//            End If
//            Selection.TypeText Text:="" & mvarAutorizo
//         End If
//         oRsEmp.Close
//      End If

//      mCantidadFirmas = 0
//      Set oRsAux = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(4, mvarTotalPedido))
//      If Not oRsAux Is Nothing Then
//         If oRsAux.RecordCount > 0 Then
//            oRsAux.MoveFirst
//            Do While Not oRsAux.EOF
//               mCantidadFirmas = mCantidadFirmas + 1
//               mVectorAutorizaciones(mCantidadFirmas) = oRsAux.Fields(0).Value
//               oRsAux.MoveNext
//            Loop
//         End If
//         oRsAux.Close
//      End If

//      Set oRsAux = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(4, mIdPedido))
//      If oRsAux.RecordCount > 0 Then
//         For j = 1 To mCantidadFirmas
//            mvarAutorizo = ""
//            oRsAux.MoveFirst
//            Do While Not oRsAux.EOF
//               If mVectorAutorizaciones(j) = oRsAux.Fields("OrdenAutorizacion").Value Then
//                  Set oRsAux1 = oAp.Empleados.Item(oRsAux.Fields("IdAutorizo").Value).Registro
//                  If Not IsNull(oRsAux1.Fields("Iniciales").Value) Then
//                     mvarAutorizo = mvarAutorizo & "" & oRsAux1.Fields("Iniciales").Value
//                  End If
//                  If Not IsNull(oRsAux.Fields("FechaAutorizacion").Value) Then
//                     mvarAutorizo = mvarAutorizo & " " & oRsAux.Fields("FechaAutorizacion").Value
//                  End If
//                  oRsAux1.Close
//                  If mvarAutorizo = "" Then mvarAutorizo = "???"
//                  Selection.MoveRight Unit:=wdCell
//                  Selection.TypeText Text:="" & mvarAutorizo
//                  Exit Do
//               End If
//               oRsAux.MoveNext
//            Loop
//            If mvarAutorizo = "" Then
//               Selection.MoveRight Unit:=wdCell
//            End If
//         Next
//      End If
//      oRsAux.Close

//      ActiveWindow.ActivePane.View.SeekView = wdSeekMainDocument

//   Else

//      Selection.Tables(1).Select
//      Selection.Tables(1).Delete
//      Selection.TypeBackspace

//   End If

//   Set oRs = Nothing
//   Set oRsDet = Nothing
//   Set oRsPrv = Nothing
//   Set oRsArt = Nothing
//   Set oRsAux = Nothing
//   Set oRsAux1 = Nothing

//   Set oAp = Nothing

//End Sub

