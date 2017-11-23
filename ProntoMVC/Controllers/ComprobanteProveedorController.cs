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
using ProntoMVC.ViewModels;
//using ClassLibrary3;
using Repo;
using Servicio;
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
//using ClosedXML.Excel;
using System.IO;
using System.Transactions;

namespace ProntoMVC.Controllers
{

    // [Authorize(Roles = "Administrador,SuperAdmin,Compras,FondosFijos")] //ojo que el web.config tambien te puede bochar hacia el login

    public partial class ComprobanteProveedorController2 : ProntoBaseController2 // ProntoBaseController2 // ProntoBaseController
    {
        private Servicio.FondoFijoService fondoFijoService;

        protected override void Initialize(System.Web.Routing.RequestContext rc)
        {

            base.Initialize(rc); // recien recupero a qué base se está conectando cuando tengo acceso a la sesión
            base.unitOfWork = new UnitOfWork(SC);
            fondoFijoService = new FondoFijoService(unitOfWork);
            //base.db = unitOfWork.ComprobantesproveedorRepositorio.HACKEADOcontext;
        }

        public void FakeInitialize(string SC)
        {
            // para usar la inicializacion en testing
            //base.Initialize(rc); // recien recupero a qué base se está conectando cuando tengo acceso a la sesión
            base.unitOfWork = new UnitOfWork(SC);
            fondoFijoService = new FondoFijoService(unitOfWork);
            //base.db = unitOfWork.ComprobantesproveedorRepositorio.HACKEADOcontext;
        }
    }

    public partial class ComprobanteProveedorController : ProntoBaseController // ProntoBaseController2 // ProntoBaseController
    {
        //public DemoProntoEntities db2; //= new DemoProntoEntities(sCadenaConex());
        //string SC2;

        private UnitOfWork unitOfWork;

        private Servicio.FondoFijoService fondoFijoService;

        public ComprobanteProveedorController()
        {
            // paso estas cosas al Initialize, porque no tengo la cadena de conexion
        }

        protected override void Initialize(System.Web.Routing.RequestContext rc)
        {
            base.Initialize(rc); // recien recupero a qué base se está conectando cuando tengo acceso a la sesión
            unitOfWork = new UnitOfWork(SC);
            fondoFijoService = new FondoFijoService(unitOfWork);
            //base.db = unitOfWork.ComprobantesproveedorRepositorio.HACKEADOcontext;
        }

        public void FakeInitialize(string nombreEmpresa)
        {
            base.FakeInitialize(nombreEmpresa); // recien recupero a qué base se está conectando cuando tengo acceso a la sesión
        }

        public virtual ActionResult JsonearModelo() // para usarlo en javascript
        {
            ViewModelComprobanteProveedor vm = new ViewModelComprobanteProveedor();
            //AutoMapper.Mapper.CreateMap<ComprobanteProveedor, ViewModelComprobanteProveedor>();
            //AutoMapper.Mapper.Map(ComprobanteProveedor, vm);
            //ppEFContext.Configuration.ProxyCreationEnabled = false;

            return Json(vm, JsonRequestBehavior.AllowGet);
        }

        public virtual ViewResult IndexFF()
        {
            return Index();
        }

        public virtual ViewResult Index()
        {
            if (!System.Diagnostics.Debugger.IsAttached && (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras") &&
                     !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "FondosFijos")
                )) throw new Exception("No tenés permisos");
            //var ComprobantesProveedores = fondoFijoService.ObtenerTodos().Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }

        public virtual ViewResult IndexExterno()
        {
            // if (!PuedeLeer(enumNodos)) throw new Exception("No tenés permisos");
            //var ComprobantesProveedores = fondoFijoService.ObtenerTodos().Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }

        public virtual FileResult Imprimir(int id, bool bAgruparItems = false) //(int id)
        {
            // string sBasePronto = (string)rc.HttpContext.Session["BasePronto"];
            // db = new DemoProntoEntities(Funciones.Generales.sCadenaConex(sBasePronto));

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            //  string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString);
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.docx"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            //string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Requerimiento1_ESUCO_PUNTONET.docx";
            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "ComprobanteProveedor_Autotrol_PUNTONET.docx";
            //string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "ComprobanteProveedor_ESUCO_PUNTONET.docx";

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

            var c = ComprobanteProveedorXMLplantilla_DOCX_MVC_ConTags(output, SC, id, bAgruparItems);
            //Pronto.ERP.BO.ComprobanteProveedor req = ComprobanteProveedor ComprobanteProveedorManager.GetItem(SC, id, true);
            //OpenXML_Pronto.ComprobanteProveedorXML_DOCX(output, req, SC);


            //byte[] contents = ;
            //return File(contents, "application/octet-stream");

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "ComprobanteProveedor.docx");
        }


        public virtual FileResult ExportarExcelCSV(int id, bool bAgruparItems = false) //(int id)
        {
            // string sBasePronto = (string)rc.HttpContext.Session["BasePronto"];
            // db = new DemoProntoEntities(Funciones.Generales.sCadenaConex(sBasePronto));

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            //  string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString);
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.docx"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            //string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Requerimiento1_ESUCO_PUNTONET.docx";
            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "ComprobanteProveedor_Autotrol_PUNTONET.docx";
            //string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "ComprobanteProveedor_ESUCO_PUNTONET.docx";

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

            var c = ComprobanteProveedorXMLplantilla_DOCX_MVC_ConTags(output, SC, id, bAgruparItems);
            //Pronto.ERP.BO.ComprobanteProveedor req = ComprobanteProveedor ComprobanteProveedorManager.GetItem(SC, id, true);
            //OpenXML_Pronto.ComprobanteProveedorXML_DOCX(output, req, SC);

            //byte[] contents = ;
            //return File(contents, "application/octet-stream");

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "Listado resumen de FF.csv");
        }

        void MarcaDeAgua(ref string cadena)
        {
            regexReplace(ref cadena, "#Empresa#", "BORRADOR");
        }

        public WordprocessingDocument ComprobanteProveedorXMLplantilla_DOCX_MVC_ConTags(string document, string SC, int id, bool bAgruparItems = false)
        {
            ComprobanteProveedor oFac = fondoFijoService.ObtenerPorId(id);
            //fondoFijoService.ComprobantesProveedor
            // .Include(x => x.DetalleComprobantesProveedores.Select(y => y.Unidad))
            // .Include(x => x.DetalleComprobantesProveedores.Select(y => y.Articulo))
            // .Include(x => x.DetalleComprobantesProveedores.Select(y => y.Moneda))
            //.Include(x => x.DetalleComprobantesProveedores. .moneda)
            // .Include("DetalleComprobantesProveedores.Unidad") // funciona tambien
            // .Include(x => x.Proveedor)
            // .Include(x => x.Proveedor.DescripcionIva)
            // .Include(x => x.Comprador)

            //.SingleOrDefault(x => x.IdComprobanteProveedor == id);

            List<DetalleComprobantesProveedore> det = oFac.DetalleComprobantesProveedores.ToList();
            //        fondoFijoService.DetalleComprobantesProveedores
            //        .Where(x => x.IdComprobanteProveedor == id)
            ////.Include(x => x.Unidad)
            ////.Include(x => x.ControlesCalidad)
            ////.Include(x => x.DetalleRequerimiento.Requerimientos)
            ////.Include(x => x.DetalleRequerimiento.Requerimientos.Obra)
            //        .ToList()
            //        ;

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
                //det = (from i in det
                //       group i by new { i.Articulo, i.Unidad, i.Observaciones }
                //           into grp
                //           select new DetalleComprobantesProveedore
                //           {
                //               Articulo = grp.Key.Articulo,
                //               Unidad = grp.Key.Unidad,
                //               Observaciones = grp.Key.Observaciones,

                //               Cantidad = grp.Sum(t => t.Cantidad),
                //               Precio = grp.Sum(t => t.Precio),
                //               ImporteTotalItem = grp.Sum(t => t.ImporteTotalItem),
                //               ImporteIva = grp.Sum(t => t.ImporteIva),

                //               PorcentajeIVA = grp.First().PorcentajeIVA,
                //               PorcentajeBonificacion = grp.First().PorcentajeBonificacion,


                //               OrigenDescripcion = grp.First().OrigenDescripcion,
                //               FechaEntrega = grp.First().FechaEntrega,
                //               FechaNecesidad = grp.First().FechaNecesidad,
                //               Adjunto = grp.First().Adjunto,
                //               IdControlCalidad = grp.First().IdControlCalidad,
                //               DetalleRequerimiento = grp.First().DetalleRequerimiento

                //           }
                //       ).ToList()
                //     ;


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

                //if ((oFac.Aprobo ?? 0) > 0) MarcaDeAgua(ref docText);
                ///////////////////////////////
                //ENCABEZADO
                //Hace el reemplazo
                ///////////////////////////////
                var _with2 = oFac;
                ///////////////////////////////

                DataRow x = EntidadManager.GetStoreProcedureTop1(SC, ProntoFuncionesGenerales.enumSPs.Empresa_TX_Datos);

                regexReplace(ref docText, "#Empresa#", x["Nombre"].NullSafeToString());
                regexReplace(ref docText, "#DetalleEmpresa#", x["DetalleNombre"].NullSafeToString());
                regexReplace(ref docText, "#DireccionCentral#", x["Direccion"].NullSafeToString()
                                                            + x["Localidad"].NullSafeToString() + x["CodigoPostal"].NullSafeToString() + x["Provincia"].NullSafeToString()
                                                        );
                regexReplace(ref docText, "#DireccionPlanta#", x["DatosAdicionales1"].NullSafeToString() + "CUIT: " + x["Cuit"].NullSafeToString());
                regexReplace(ref docText, "#TelefonosEmpresa#", x["Telefono1"].NullSafeToString() + " FAX: " + x["Telefono2"].NullSafeToString());

                regexReplace(ref docText, "#Tipo#", "Obra");
                // oFac.tipo) obra
                //regexReplace(ref docText, "#TipoDes#", NombreObra(SC, _with2.IdObra));
                // oFac.TipoDes) codigo obra
                regexReplace(ref docText, "#TipoDes1#", "");
                // NombreObr(SC, .IdObra)) 'oFac.TipoDes1) nombre obra
                //   regexReplace(ref docText, "#NumeroComparativa#", oFac.NumeroComparativa.NullSafeToString());
                //regexReplace(ref docText, "#Subtotal#", ProntoFuncionesGenerales.FF2((double)((oFac.TotalComprobanteProveedor ?? 0) - (oFac.TotalIva1 ?? 0))));
                //regexReplace(ref docText, "#IVA#", ProntoFuncionesGenerales.FF2((double)(oFac.TotalIva1 ?? 0)));
                ////regexReplace(ref docText, "#IIBB#", ProntoFuncionesGenerales.FF2((double)oFac.));
                //regexReplace(ref docText, "#boniftot#", ProntoFuncionesGenerales.FF2((double)(oFac.Bonificacion ?? 0)));
                //regexReplace(ref docText, "#subtotalgrav#", ProntoFuncionesGenerales.FF2((double)((oFac.TotalComprobanteProveedor ?? 0) - (oFac.TotalIva1 ?? 0) - (oFac.Bonificacion ?? 0))));
                //regexReplace(ref docText, "#Total#", ProntoFuncionesGenerales.FF2((double)(oFac.TotalComprobanteProveedor ?? 0)));
                //regexReplace(ref docText, "#moneda#", (oFac.Moneda ?? new Moneda()).Nombre.NullSafeToString());
                //regexReplace(ref docText, "#Importante#", oFac.ImprimeImportante == "NO" ? "" : "00 - Importante: " + oFac.Importante.NullSafeToString());
                //regexReplace(ref docText, "#PlazoEntrega#", oFac.ImprimePlazoEntrega == "NO" ? "" : "01 - Plazo de Entrega: " + oFac.PlazoEntrega.NullSafeToString());
                //regexReplace(ref docText, "#LugarEntrega#", oFac.ImprimeLugarEntrega == "NO" ? "" : "02 - Lugar de Entrega: " + oFac.LugarEntrega.NullSafeToString());
                //regexReplace(ref docText, "#FormaPago#", oFac.ImprimeFormaPago == "NO" ? "" : "03 - Forma de Pago: " + oFac.FormaPago.NullSafeToString());
                //regexReplace(ref docText, "#Garantia#", oFac.ImprimeGarantia == "NO" ? "" : "06 - Garantia: " + oFac.Garantia.NullSafeToString());
                //regexReplace(ref docText, "#Documentacion#", oFac.ImprimeDocumentacion == "NO" ? "" : "07 - Documentacion: " + oFac.Documentacion.NullSafeToString());

                StreamWriter sw = new StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create));
                using ((sw))
                {
                    sw.Write(docText);
                }
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
                //hago los reemplazos
                //////////////////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////////////////

                //'Make a copy of the 2nd row (assumed that the 1st row is header) http://patrickyong.net/tags/openxml/
                //Dim rows = table.Elements(Of TableRow)()
                foreach (DetalleComprobantesProveedore i in det)
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
                            //regexReplace(ref texto, "#item#", i.NumeroItem.NullSafeToString());

                            //try
                            //{

                            //    //regexReplace(ref texto, "#obraitem#", (i.DetalleRequerimiento == null ? "" : i.DetalleRequerimiento.Requerimientos.Obra.Descripcion.NullSafeToString()));
                            //    //regexReplace(ref texto, "#RMsitem#", (i.DetalleRequerimiento == null ? "" : i.DetalleRequerimiento.Requerimientos.NumeroRequerimiento.NullSafeToString()));
                            //    regexReplace(ref texto, "#obraitem#", "");
                            //    regexReplace(ref texto, "#RMsitem#", "");
                            //}
                            //catch (Exception e)
                            //{

                            //    ErrHandler.WriteError(e);
                            //}

                            //regexReplace(ref texto, "#Cant#", ProntoFuncionesGenerales.FF2((double)i.Cantidad).NullSafeToString());

                            //regexReplace(ref texto, "#ctrl#", (i.ControlesCalidad ?? new ControlCalidad()).Abreviatura.NullSafeToString());
                            //regexReplace(ref texto, "#mon#", (oFac.Moneda ?? new Moneda()).Nombre.NullSafeToString());


                            //regexReplace(ref texto, "#Unidad#", (i.Unidad ?? new Unidad()).Descripcion.NullSafeToString());
                            //regexReplace(ref texto, "#medida#", "");
                            //regexReplace(ref texto, "#en#", (i.Unidad ?? new Unidad()).Abreviatura.NullSafeToString());
                            //regexReplace(ref texto, "#Codigo#", (i.Articulo ?? new Articulo()).Codigo.NullSafeToString());
                            //regexReplace(ref texto, "#PrecioUnitario#", i.Precio.NullSafeToString());
                            //// regexReplace(ref texto, "#TotalItem#", i.ImporteTotalItem.NullSafeToString());
                            //regexReplace(ref texto, "#TotalItem#", ProntoFuncionesGenerales.FF2((double)(i.ImporteTotalItem - i.ImporteIva)).NullSafeToString());
                            //regexReplace(ref texto, "#bonitem#", i.PorcentajeBonificacion.NullSafeToString());
                            ////regexReplace(ref texto, "#ivaitem#", i.ImporteIva.NullSafeToString());
                            //regexReplace(ref texto, "#ivaitem#", ProntoFuncionesGenerales.FF2((double)i.PorcentajeIVA).NullSafeToString());
                            //// 
                            //string desc = ((i.OrigenDescripcion != 2) ? (i.Articulo ?? new Articulo()).Descripcion.NullSafeToString() : "") + " " + (i.OrigenDescripcion != 1 ? i.Observaciones : "");
                            //regexReplace(ref texto, "#Descripcion#", desc);


                            //regexReplace(ref texto, "#FechaEntrega#", (i.FechaEntrega ?? new DateTime()).ToShortDateString());
                            //regexReplace(ref texto, "#FechaRecepcion#", "");


                            //regexReplace(ref texto, "#FechaNecesidad#", (i.FechaNecesidad ?? new DateTime()).ToShortDateString());
                            //regexReplace(ref texto, "#ListaMat#", i.ListaMateriales.NullSafeToString());
                            //regexReplace(ref texto, "#itLM#", i.ItemListaMaterial.NullSafeToString());
                            //regexReplace(ref texto, "#Equipo#", i.Equipo.NullSafeToString());
                            //regexReplace(ref texto, "#CentrocostoCuenta#", i.centrocosto);
                            // regexReplace(ref texto, "#BienUso#", (iisNull(i.bien_o_uso, false) == true ? "SI" : "NO"));
                            //regexReplace(ref texto, "#controlcalidad#", i.ControlDeCalidad);
                            //regexReplace(ref texto, "#adj#", i.Adjunto);
                            //regexReplace(ref texto, "#Proveedor#", i.proveedor);
                            //regexReplace(ref texto, "#nroFactComprobanteProveedor#", i.NumeroFacturaCompra1);
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
                //PIE
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
                    //regexReplace(ref docText, "#LugarEntrega#", oFac.LugarEntrega);
                    //regexReplace(ref docText, "#Liberado#", ((oFac.Aprobo ?? 0) > 0 ? EntidadManager.GetInitialsFromString(fondoFijoService.Empleados.Find(oFac.Aprobo).Nombre) + " " + oFac.FechaAprobacion : ""));
                    ////iniciales + fecha + hora

                    var sAut = new List<string>();

                    var Autorizaciones = fondoFijoService.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.ComprobantesProveedores, oFac.IdComprobanteProveedor);
                    foreach (AutorizacionesPorComprobante i in Autorizaciones)
                    {
                        if ((i.IdAutorizo ?? 0) > 0)
                        {
                            sAut.Add(EntidadManager.GetInitialsFromString(fondoFijoService.EmpleadoById(i.IdAutorizo).Nombre) + " " + i.FechaAutorizacion.ToString());
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

                        //throw;
                    }

                    regexReplace(ref  docText, "#Total#", ProntoFuncionesGenerales.FF2(0));
                    regexReplace(ref docText, "#Total2#", ProntoFuncionesGenerales.FF2(0));
                    regexReplace(ref docText, "#Subtotal#", ProntoFuncionesGenerales.FF2((double)(oFac.TotalIva1 ?? 0)));
                    regexReplace(ref docText, "#IVA#", ProntoFuncionesGenerales.FF2((double)(oFac.TotalIva1 ?? 0)));
                    //regexReplace(ref docText, "#IIBB#", ProntoFuncionesGenerales.FF2((double)oFac.));
                    //     regexReplace(ref docText, "#Total#", ProntoFuncionesGenerales.FF2((double)(oFac.TotalComprobanteProveedor ?? 0)));


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

        void regexReplace(ref string cadena, string buscar, string reemplazo)
        {
            // 'buscar = "\[" & buscar & "\]" 'agrego los corchetes
            // buscar = buscar
            var regexText = new System.Text.RegularExpressions.Regex(buscar, System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            cadena = regexText.Replace(cadena, reemplazo ?? "");
        }

        public virtual JsonResult GetObrasAutocomplete2(string term)
        {
            var q = fondoFijoService.GetObrasAutocomplete2(term);
            if (q.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);
            return Json(q, JsonRequestBehavior.AllowGet);
        }

        string crearProveedor(ComprobanteProveedor ComprobanteProveedor)
        {
            //si el Proveedor no existe, lo creo
            Proveedor ProveedorNuevo = new Proveedor();
            ProveedorNuevo.Cuit = ComprobanteProveedor.Cuit;
            ProveedorNuevo.RazonSocial = ComprobanteProveedor.Proveedore.RazonSocial;
            ProveedorNuevo.IdEstado = 1;
            //ProveedorNuevo.IdCondicionCompra =;247
            //ProveedorNuevo.IdCondicionCompra = Generales.Val(fondoFijoService.BuscarClaveINI("Condicion de compra default para fondos fijos"));

            ProveedorNuevo.Confirmado = "NO";

            var contrProv = new ProveedorController();
            string ms = "";

            // contrProv.db = db;
            contrProv.Validar(ProveedorNuevo, ref ms);
            // contrProv.Response. = Response // hay que usar mock
            //act     
            try
            {
                var result = contrProv.BatchUpdate(ProveedorNuevo) as JsonResult;

                //assert     
                dynamic data = result.Data;

                ComprobanteProveedor.IdProveedorEventual = data.IdProveedor;
                ComprobanteProveedor.IdCondicionCompra = ProveedorNuevo.IdCondicionCompra;
            }
            catch (Exception e)
            {
                ms = e.ToString();
                //throw;
            }
            return ms;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate_ORIGINALSINREPO(ComprobanteProveedor ComprobanteProveedor)
        {
            if (!PuedeEditar(enumNodos.ComprobantesPrv)) throw new Exception("No tenés permisos");

            if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "FondosFijos") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
                )
            {
                int idproveedor = fondoFijoService.buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));

                if (ComprobanteProveedor.IdProveedor != idproveedor) throw new Exception("Sólo podes acceder a ComprobantesProveedores tuyos");
                //throw new Exception("No tenés permisos");
            }

            //ComprobanteProveedor.mail
            try
            {
                //var mailcomp = fondoFijoService.Empleados.Where(e => e.IdEmpleado == ComprobanteProveedor.IdComprador).Select(e => e.Email).FirstOrDefault();
                //Generales.enviarmailAlComprador(mailcomp   ,ComprobanteProveedor.IdComprobanteProveedor );
            }
            catch (Exception)
            {
                //throw;
            }

            string errs = "";
            string warnings = "";

            if (!Validar(ComprobanteProveedor, ref errs, ref warnings))
            {
                try
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
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
                res.Message = "El ComprobanteProveedor es inválido";

                return Json(res);
            }

            if ((ComprobanteProveedor.IdProveedor ?? 0) <= 0 && (ComprobanteProveedor.IdProveedorEventual ?? 0) <= 0
                && (ComprobanteProveedor.Proveedor ?? new Proveedor()).RazonSocial != "")
            {
                crearProveedor(ComprobanteProveedor);
            }

            try
            {
                if (ModelState.IsValid)
                {
                    string tipomovimiento = "";
                    if (ComprobanteProveedor.IdComprobanteProveedor > 0)
                    {
                        /*
                        var EntidadOriginal = fondoFijoService.ObtenerTodos().Where(p => p.IdComprobanteProveedor == ComprobanteProveedor.IdComprobanteProveedor).Include(p => p.DetalleComprobantesProveedores).SingleOrDefault();
                        var EntidadEntry = fondoFijoService.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(ComprobanteProveedor);

                        foreach (var dr in ComprobanteProveedor.DetalleComprobantesProveedores)
                        {
                            var DetalleEntidadOriginal = EntidadOriginal.DetalleComprobantesProveedores.Where(c => c.IdDetalleComprobanteProveedor == dr.IdDetalleComprobanteProveedor && dr.IdDetalleComprobanteProveedor > 0).SingleOrDefault();
                            if (DetalleEntidadOriginal != null)
                            {
                                var DetalleEntidadEntry = fondoFijoService.Entry(DetalleEntidadOriginal);
                                DetalleEntidadEntry.CurrentValues.SetValues(dr);
                            }
                            else
                            {
                                EntidadOriginal.DetalleComprobantesProveedores.Add(dr);
                            }
                        }

                        foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleComprobantesProveedores.Where(c => c.IdDetalleComprobanteProveedor != 0).ToList())
                        {
                            if (!ComprobanteProveedor.DetalleComprobantesProveedores.Any(c => c.IdDetalleComprobanteProveedor == DetalleEntidadOriginal.IdDetalleComprobanteProveedor))
                                EntidadOriginal.DetalleComprobantesProveedores.Remove(DetalleEntidadOriginal);
                        }
                        fondoFijoService.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                          */
                    }
                    else
                    {
                        //if (ComprobanteProveedor.SubNumero == 1)
                        //{
                        //tipomovimiento = "N";
                        //se debe permitir hacerlo así?, accediendo directo al repositorio?
                        //unitOfWork.ParametrosRepositorio.ObtenerPorId(1);
                        //ComprobanteProveedor.NumeroReferencia = parametros.ProximoComprobanteProveedorReferencia;
                        //unitOfWork.ParametrosRepositorio.ProximoComprobanteProveedorReferencia += 1;

                        // Parametros parametros = fondoFijoService.Parametros();
                        //ComprobanteProveedor.NumeroReferencia = parametros.ProximoComprobanteProveedorReferencia;
                        // parametros.ProximoComprobanteProveedorReferencia += 1;
                        //}
                        //fondoFijoService.ObtenerTodos().Add(ComprobanteProveedor);
                    }

                    // Logica_RecalcularTotales(ref ComprobanteProveedor);
                    /*Logica_ActualizarCuentaCorriente(ComprobanteProveedor);
                    Logica_AsientoRegistroContable(ComprobanteProveedor);
                    Logica_Actualizaciones(ComprobanteProveedor);
                    */

                    try
                    {
                        //  ActivarUsuarioYContacto(ComprobanteProveedor.IdComprobanteProveedor);
                    }
                    catch (Exception)
                    {
                        //throw;
                    }

                    // http://stackoverflow.com/questions/10668946/stored-procedures-in-entity-framework-and-savechanges
                    //  http://stackoverflow.com/questions/6219643/how-to-call-stored-procedure-in-mvc-by-ef
                    // http://social.msdn.microsoft.com/Forums/en-US/78e5f472-9d14-494c-b8c7-e80f7ccc3894/how-to-fire-a-savechanges-and-stored-procedure-in-a-single-transaction?forum=adodotnetentityframework
                    //  http://stackoverflow.com/questions/19248523/call-stored-procedure-inside-transaction-using-entity-framework
                    // fondoFijoService.wActualizacionesVariasPorComprobante(104, ComprobanteProveedor.IdComprobanteProveedor, tipomovimiento);
                    //fondoFijoService.SaveChanges();

                    TempData["Alerta"] = "<a href='" + Url.Action("EditFF", new { id = ComprobanteProveedor.IdComprobanteProveedor }) + "' target='' >" +
                                         " Grabado " + DateTime.Now.ToShortTimeString() +
                                         " Comprobante " +
                                         ComprobanteProveedor.Letra + '-' + ComprobanteProveedor.NumeroComprobante1.NullSafeToString().PadLeft(4, '0') + '-' + ComprobanteProveedor.NumeroComprobante2.NullSafeToString().PadLeft(8, '0') +
                                         "</a>";
                    try
                    {
                        List<Tablas.Tree> Tree = TablasDAL.ArbolRegenerar(this.Session["BasePronto"].ToString(), oStaticMembershipService);

                    }
                    catch (Exception ex)
                    {
                        ErrHandler.WriteError(ex);
                        //                        throw;
                    }

                    return Json(new { Success = 1, IdComprobanteProveedor = ComprobanteProveedor.IdComprobanteProveedor, ex = "" });
                }
                else
                {

                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "El ComprobanteProveedor es inválido";
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
                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);

                res.Errors.Add(sb.ToString());
                res.Errors.Add(ex.ToString());
                res.Message = "El ComprobanteProveedor es inválido. " + ex.ToString();
                //return Json(res);
                //return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });

                return Json(res);
            }
            catch (Exception ex)
            {

                try
                {
                    System.Data.Entity.Validation.DbEntityValidationException exxx = (System.Data.Entity.Validation.DbEntityValidationException)ex;
                    StringBuilder sb = new StringBuilder();

                    foreach (var failure in exxx.EntityValidationErrors)
                    {
                        sb.AppendFormat("{0} failed validation\n", failure.Entry.Entity.GetType());
                        foreach (var error in failure.ValidationErrors)
                        {
                            sb.AppendFormat("- {0} : {1}", error.PropertyName, error.ErrorMessage);
                            sb.AppendLine();
                        }
                    }
                }
                catch (Exception)
                {

                    //throw;
                }



                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);
                res.Errors.Add(ex.ToString());
                res.Message = "El ComprobanteProveedor es inválido. " + ex.ToString();
                //return Json(res);
                //return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });

                return Json(res);

                // return Json(new { Success = 0, ex = ex.Message.ToString() });
            }
            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }


        [HttpPost]
        public virtual JsonResult BatchUpdate_CuentaCorriente(ViewModelComprobanteProveedor ComprobanteProveedor)
        {
            if (!PuedeEditar(enumNodos.ComprobantesPrv)) throw new Exception("No tenés permisos");


            if (!System.Diagnostics.Debugger.IsAttached && (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "FondosFijos") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
                ))
            {

                int idproveedor = fondoFijoService.buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));

                if (ComprobanteProveedor.IdProveedor != idproveedor) throw new Exception("Sólo podes acceder a ComprobantesProveedores tuyos");
                //throw new Exception("No tenés permisos");
            }

            //ComprobanteProveedor.mail
            try
            {
                //var mailcomp = fondoFijoService.Empleados.Where(e => e.IdEmpleado == ComprobanteProveedor.IdComprador).Select(e => e.Email).FirstOrDefault();
                //Generales.enviarmailAlComprador(mailcomp   ,ComprobanteProveedor.IdComprobanteProveedor );
            }
            catch (Exception)
            {
                //throw;
            }

            string errs = "";
            string warnings = "";

            if (!Validar_CuentaCorriente(ComprobanteProveedor, ref errs, ref warnings))
            {
                try
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;

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
                res.Message = "El ComprobanteProveedor es inválido";

                return Json(res);
            }

            AutoMapper.Mapper.CreateMap<ViewModelComprobanteProveedor, Data.Models.ComprobanteProveedor>();
            ComprobanteProveedor o = new ComprobanteProveedor();
            AutoMapper.Mapper.Map(ComprobanteProveedor, o);

            if ((o.IdProveedor ?? 0) <= 0 && (o.IdProveedorEventual ?? 0) <= 0
                && (o.Proveedor ?? new Proveedor()).RazonSocial.NullSafeToString() != "")
            {
                crearProveedor(o);
            }

            try
            {
                if (ModelState.IsValid)
                {
                    // var usuario = fondoFijoService.ObtenerUsuarioLogueado();
                    // Acá iría el mapeo entre el viewmodel y el modelo de la base. por ahora uso directo el modelo
                    //meow.Fecha = DateTime.Now;
                    //meow.Texto = vm.Meow;
                    //meow.CodigoUsuario = usuario.Codigo;
                    //meow.Usuario = usuario;

                    fondoFijoService.Guardar(o);
                    //fondoFijoService.Guardar((ComprobanteProveedor)ComprobanteProveedor);

                    //unitOfWork.Save();
                    db.SaveChanges();


                    if (!System.Diagnostics.Debugger.IsAttached)
                    {
                        try
                        {
                            TempData["Alerta"] = "<a href='" + Url.Action("EditFF", new { id = o.IdComprobanteProveedor }) + "' target='' >" +
                                             " Grabado " + DateTime.Now.ToShortTimeString() +
                                             " Comprobante " +
                                             o.Letra + '-' + o.NumeroComprobante1.NullSafeToString().PadLeft(4, '0')
                                             + '-' + o.NumeroComprobante2.NullSafeToString().PadLeft(8, '0') +
                                             "</a>";
                        }
                        catch (Exception e)
                        {

                            ErrHandler.WriteError(e);
                        }

                    }

                    return Json(new { Success = 1, Errors = "", IdComprobanteProveedor = o.IdComprobanteProveedor, ex = "" });
                }
                else
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "El ComprobanteProveedor es inválido";
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
                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);

                res.Errors.Add(sb.ToString());
                res.Errors.Add(ex.ToString());
                res.Message = "El ComprobanteProveedor es inválido. " + ex.ToString();
                //return Json(res);
                //return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });

                return Json(res);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);
                res.Errors.Add(ex.ToString());
                res.Message = "El ComprobanteProveedor es inválido. " + ex.ToString();
                //return Json(res);
                //return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });

                return Json(res);

                // return Json(new { Success = 0, ex = ex.Message.ToString() });
            }
            return Json(new { Success = 0, Errors = "", ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.ComprobanteProveedor ComprobanteProveedor)
        {
            if (!PuedeEditar(enumNodos.Facturas)) throw new Exception("No tenés permisos");

            try
            {
                decimal mCotizacionMoneda = 0;
                decimal mCotizacionDolar = 0;
                decimal mCotizacionEuro = 0;
                decimal mCotizacionMonedaAnterior = 0;
                decimal mTotalComprobante = 0;
                decimal mTotalIvaNoDiscriminado = 0;
                decimal mIvaNoDiscriminadoItem = 0;
                decimal mTotalAnterior = 0;
                decimal mTotalAnteriorDolar = 0;
                decimal mTotalAnteriorEuro = 0;
                decimal mTotal = 0;
                decimal mTotalDolar = 0;
                decimal mTotalEuro = 0;
                decimal mCoef = 1;
                decimal mImporte = 0;
                decimal mImporteIva = 0;
                decimal mAjusteIVA = 0;

                Int32 mIdComprobanteProveedor = 0;
                Int32 mIdTipoComprobante = 0;
                Int32 mIdTipoComprobanteAnterior = 0;
                Int32 mIdProveedor = 0;
                Int32 mNumero = 0;
                Int32 mIdCtaCte = 0;
                Int32 mIdCuentaProveedor = 0;
                Int32 mIdCuentaComprasTitulo = 0;
                Int32 mIdMonedaPesos = 0;
                Int32 mIdCuentaBonificaciones = 0;
                Int32 mIdCuenta = 0;
                Int32 mIdCuentaReintegros = 0;

                string errs = "";
                string warnings = "";
                string mWebService = "";
                string mSubdiarios_ResumirRegistros = "";

                bool mGrabarRegistrosEnCuentaCorriente = true;

                Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
                mIdCuentaProveedor = parametros.IdCuentaAcreedoresVarios ?? 0;
                mIdCuentaComprasTitulo = parametros.IdCuentaComprasTitulo ?? 0;
                mIdMonedaPesos = parametros.IdMoneda ?? 0;
                mIdCuentaBonificaciones = parametros.IdCuentaBonificaciones ?? 0;
                mSubdiarios_ResumirRegistros = parametros.Subdiarios_ResumirRegistros ?? "";
                mIdCuentaReintegros = parametros.IdCuentaReintegros ?? 0;

                string usuario = ViewBag.NombreUsuario;
                int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

                if (!Validar(ComprobanteProveedor, ref errs, ref warnings))
                {
                    try
                    {
                        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    }
                    catch (Exception)
                    {
                    }

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;

                    string[] words = errs.Split('\n');
                    res.Errors = words.ToList();
                    res.Message = "Hay datos invalidos";

                    return Json(res);
                }

                if (ModelState.IsValid)
                {
                    using (TransactionScope scope = new TransactionScope())
                    {
                        mIdComprobanteProveedor = ComprobanteProveedor.IdComprobanteProveedor;
                        mIdTipoComprobante = ComprobanteProveedor.IdTipoComprobante ?? 0;
                        mIdTipoComprobanteAnterior = mIdTipoComprobante;
                        mIdProveedor = ComprobanteProveedor.IdProveedor ?? 0;
                        mCotizacionMoneda = ComprobanteProveedor.CotizacionMoneda ?? 1;
                        mCotizacionDolar = ComprobanteProveedor.CotizacionDolar ?? 0;
                        mCotizacionEuro = ComprobanteProveedor.CotizacionEuro ?? 0;
                        mTotalComprobante = (ComprobanteProveedor.TotalComprobante ?? 0) * mCotizacionMoneda;
                        mTotalIvaNoDiscriminado = (ComprobanteProveedor.TotalIvaNoDiscriminado ?? 0) * mCotizacionMoneda;
                        mAjusteIVA = (ComprobanteProveedor.AjusteIVA ?? 0) * mCotizacionMoneda;

                        mTotal = decimal.Round((ComprobanteProveedor.TotalComprobante ?? 0) * mCotizacionMoneda, 2);
                        if (mCotizacionDolar != 0) { mTotalDolar = decimal.Round((ComprobanteProveedor.TotalComprobante ?? 0) * mCotizacionMoneda / mCotizacionDolar, 2); }
                        if (mCotizacionEuro != 0) { mTotalEuro = decimal.Round((ComprobanteProveedor.TotalComprobante ?? 0) * mCotizacionMoneda / mCotizacionEuro, 2); }

                        var TiposComprobantes = db.TiposComprobantes.Where(c => c.IdTipoComprobante == mIdTipoComprobante).SingleOrDefault();
                        if (TiposComprobantes != null)
                        {
                            mCoef = TiposComprobantes.Coeficiente ?? mCoef;
                        }

                        if (mIdComprobanteProveedor <= 0)
                        {
                            ComprobanteProveedor.IdUsuarioIngreso = IdUsuario;
                            ComprobanteProveedor.FechaIngreso = DateTime.Now;
                            ComprobanteProveedor.TotalIva1 = ComprobanteProveedor.TotalIva1 ?? 0;
                        }
                        else
                        {
                            ComprobanteProveedor.IdUsuarioIngreso = IdUsuario;
                            ComprobanteProveedor.FechaIngreso = DateTime.Now;

                            ComprobanteProveedor ComprobanteProveedorAnterior = db.ComprobantesProveedor.Where(c => c.IdComprobanteProveedor == mIdComprobanteProveedor).SingleOrDefault();
                            if (ComprobanteProveedorAnterior != null)
                            {
                                mIdTipoComprobanteAnterior = ComprobanteProveedorAnterior.IdTipoComprobante ?? mIdTipoComprobante;
                            }
                        }

                        if (mIdProveedor > 0)
                        {
                            var Proveedores = db.Proveedores.Where(p => p.IdProveedor == mIdProveedor).FirstOrDefault();
                            if (Proveedores != null)
                            {
                                if ((Proveedores.RegistrarMovimientosEnCuentaCorriente ?? "SI") == "NO") { mGrabarRegistrosEnCuentaCorriente = false; }
                            }
                        }

                        if (mIdComprobanteProveedor > 0)
                        {
                            var EntidadOriginal = db.ComprobantesProveedor.Where(p => p.IdComprobanteProveedor == mIdComprobanteProveedor).SingleOrDefault();

                            var EntidadoEntry = db.Entry(EntidadOriginal);
                            EntidadoEntry.CurrentValues.SetValues(ComprobanteProveedor);

                            //////////////////////////////////////////////// ITEMS ////////////////////////////////////////////////
                            foreach (var d in ComprobanteProveedor.DetalleComprobantesProveedores)
                            {
                                var DetalleEntidadOriginal = EntidadOriginal.DetalleComprobantesProveedores.Where(c => c.IdDetalleComprobanteProveedor == d.IdDetalleComprobanteProveedor && d.IdDetalleComprobanteProveedor > 0).SingleOrDefault();
                                if (DetalleEntidadOriginal != null)
                                {
                                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                    DetalleEntidadEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    EntidadOriginal.DetalleComprobantesProveedores.Add(d);
                                }
                            }
                            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleComprobantesProveedores.Where(c => c.IdDetalleComprobanteProveedor != 0).ToList())
                            {
                                if (!ComprobanteProveedor.DetalleComprobantesProveedores.Any(c => c.IdDetalleComprobanteProveedor == DetalleEntidadOriginal.IdDetalleComprobanteProveedor))
                                {
                                    EntidadOriginal.DetalleComprobantesProveedores.Remove(DetalleEntidadOriginal);
                                    db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// FIN MODIFICACION //////////////////////////////////////////////
                            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                        else
                        {
                            ProntoMVC.Data.Models.PuntosVenta PuntoVenta = db.PuntosVentas.Where(c => c.IdPuntoVenta == ComprobanteProveedor.IdPuntoVenta).SingleOrDefault();
                            if (PuntoVenta != null)
                            {
                                mNumero = PuntoVenta.ProximoNumero ?? 1;
                                ComprobanteProveedor.NumeroReferencia = mNumero;

                                PuntoVenta.ProximoNumero = mNumero + 1;
                                db.Entry(PuntoVenta).State = System.Data.Entity.EntityState.Modified;
                            }

                            db.ComprobantesProveedor.Add(ComprobanteProveedor);
                            db.SaveChanges();
                        }

                        ////////////////////////////////////////////// IMPUTACION //////////////////////////////////////////////
                        // si es modificacion y tenia imputado algo
                        //If mvarIdentificador > 0 Then
                        //   Set DatosAnt = oDet.LeerUno("ComprobantesProveedores", mvarIdentificador)
                        //   If DatosAnt.RecordCount > 0 Then
                        //      mvarCotizacionAnt = IIf(IsNull(DatosAnt.Fields("CotizacionMoneda").Value), 1, DatosAnt.Fields("CotizacionMoneda").Value)
                        //      mTotalAnterior = DatosAnt.Fields("TotalComprobante").Value * mvarCotizacionAnt
                        //      If Not IsNull(DatosAnt.Fields("IdProveedor").Value) Then
                        //         mvarIdProveedorAnterior = DatosAnt.Fields("IdProveedor").Value
                        //      End If
                        //      If Not IsNull(DatosAnt.Fields("IdTipoComprobante").Value) Then
                        //         mvarIdTipoComprobanteAnterior = DatosAnt.Fields("IdTipoComprobante").Value
                        //      End If
                        //      Set Datos = oDet.LeerUno("TiposComprobante", DatosAnt.Fields("IdTipoComprobante").Value)
                        //      If Datos.RecordCount > 0 Then
                        //         mvarCoeficienteAnt = Datos.Fields("Coeficiente").Value
                        //      End If
                        //      mvarIdOrdenPagoAnterior = IIf(IsNull(DatosAnt.Fields("IdOrdenPago").Value), 0, DatosAnt.Fields("IdOrdenPago").Value)
                        //      Datos.Close
                        //      Set Datos = Nothing

                        //      If Not IsNull(DatosAnt.Fields("IdComprobanteImputado").Value) Then
                        //         mvarAuxL1 = 11
                        //         Set oRsAux = oDet.LeerUno("ComprobantesProveedores", DatosAnt.Fields("IdComprobanteImputado").Value)
                        //         If oRsAux.RecordCount > 0 Then
                        //            mvarAuxL1 = oRsAux.Fields("IdTipoComprobante").Value
                        //         End If
                        //         oRsAux.Close

                        //         Set DatosCtaCteNv = oDet.TraerFiltrado("CtasCtesA", "_BuscarComprobante", Array(mvarIdentificador, DatosAnt.Fields("IdTipoComprobante").Value))
                        //         If DatosCtaCteNv.RecordCount > 0 Then
                        //            Tot = DatosCtaCteNv.Fields("ImporteTotal").Value - DatosCtaCteNv.Fields("Saldo").Value
                        //            TotDol = DatosCtaCteNv.Fields("ImporteTotalDolar").Value - DatosCtaCteNv.Fields("SaldoDolar").Value
                        //            TotEu = IIf(IsNull(DatosCtaCteNv.Fields("ImporteTotalEuro").Value), 0, DatosCtaCteNv.Fields("ImporteTotalEuro").Value) - _
                        //                     IIf(IsNull(DatosCtaCteNv.Fields("SaldoEuro").Value), 0, DatosCtaCteNv.Fields("SaldoEuro").Value)

                        //            Set DatosCtaCte = oDet.TraerFiltrado("CtasCtesA", "_BuscarComprobante", Array(DatosAnt.Fields("IdComprobanteImputado").Value, mvarAuxL1))
                        //            If DatosCtaCte.RecordCount > 0 Then
                        //                  DatosCtaCte.Fields("Saldo").Value = DatosCtaCte.Fields("Saldo").Value + Tot
                        //                  DatosCtaCte.Fields("SaldoDolar").Value = DatosCtaCte.Fields("SaldoDolar").Value + TotDol
                        //                  DatosCtaCte.Fields("SaldoEuro").Value = IIf(IsNull(DatosCtaCte.Fields("SaldoEuro").Value), 0, DatosCtaCte.Fields("SaldoEuro").Value) + TotEu
                        //                  Resp = oDet.Guardar("CtasCtesA", DatosCtaCte)
                        //            End If
                        //            DatosCtaCte.Close
                        //            Set DatosCtaCte = Nothing

                        //            oDet.Eliminar "CtasCtesA", DatosCtaCteNv.Fields(0).Value
                        //         End If
                        //         DatosCtaCteNv.Close
                        //         Set DatosCtaCteNv = Nothing
                        //      End If
                        //   End If
                        //   DatosAnt.Close
                        //   Set DatosAnt = Nothing
                        //End If


                        if (mIdProveedor > 0 && mGrabarRegistrosEnCuentaCorriente)
                        {
                            if (mIdComprobanteProveedor > 0)
                            {
                                CuentasCorrientesAcreedor CtaCteAnterior = db.CuentasCorrientesAcreedores.Where(c => c.IdComprobante == mIdComprobanteProveedor && c.IdTipoComp == mIdTipoComprobanteAnterior).FirstOrDefault();
                                if (CtaCteAnterior != null)
                                {
                                    mTotalAnterior = (CtaCteAnterior.ImporteTotal ?? 0) - (CtaCteAnterior.Saldo ?? 0);
                                    mTotalAnteriorDolar = (CtaCteAnterior.ImporteTotalDolar ?? 0) - (CtaCteAnterior.SaldoDolar ?? 0);
                                    mTotalAnteriorEuro = (CtaCteAnterior.ImporteTotalEuro ?? 0) - (CtaCteAnterior.SaldoEuro ?? 0);
                                }
                            }

                            CuentasCorrientesAcreedor CtaCte = db.CuentasCorrientesAcreedores.Where(c => c.IdComprobante == mIdComprobanteProveedor && c.IdTipoComp == mIdTipoComprobante).FirstOrDefault();
                            if (CtaCte == null)
                            {
                                CtaCte = new CuentasCorrientesAcreedor();
                                mIdCtaCte = 0;
                            }
                            else
                            {
                                mIdCtaCte = CtaCte.IdCtaCte;
                            }

                            CtaCte.IdTipoComp = mIdTipoComprobante;
                            CtaCte.IdProveedor = ComprobanteProveedor.IdProveedor;
                            CtaCte.NumeroComprobante = ComprobanteProveedor.NumeroReferencia;
                            CtaCte.Fecha = ComprobanteProveedor.FechaRecepcion;
                            CtaCte.FechaVencimiento = ComprobanteProveedor.FechaVencimiento;
                            CtaCte.CotizacionDolar = ComprobanteProveedor.CotizacionDolar;
                            CtaCte.CotizacionEuro = ComprobanteProveedor.CotizacionEuro;
                            CtaCte.CotizacionMoneda = ComprobanteProveedor.CotizacionMoneda;
                            CtaCte.IdComprobante = ComprobanteProveedor.IdOrdenPago;
                            CtaCte.ImporteTotal = mTotal;
                            CtaCte.Saldo = mTotal - mTotalAnterior;
                            CtaCte.ImporteTotalDolar = mTotalDolar;
                            CtaCte.SaldoDolar = mTotalDolar - mTotalAnteriorDolar;
                            CtaCte.ImporteTotalEuro = mTotalEuro;
                            CtaCte.SaldoEuro = mTotalEuro - mTotalAnteriorEuro;
                            CtaCte.IdMoneda = ComprobanteProveedor.IdMoneda;

                            if (mIdCtaCte <= 0) { db.CuentasCorrientesAcreedores.Add(CtaCte); }
                            else { db.Entry(CtaCte).State = System.Data.Entity.EntityState.Modified; }

                            db.SaveChanges();
                            mIdCtaCte = CtaCte.IdCtaCte;
                        }

                        ////////////////////////////////////////////// ASIENTO //////////////////////////////////////////////
                        if (mIdComprobanteProveedor > 0)
                        {
                            var Subdiarios = db.Subdiarios.Where(c => c.IdTipoComprobante == mIdTipoComprobante && c.IdComprobante == mIdComprobanteProveedor).ToList();
                            if (Subdiarios != null) { foreach (Subdiario s1 in Subdiarios) { db.Entry(s1).State = System.Data.Entity.EntityState.Deleted; } }
                            db.SaveChanges();
                        }

                        Subdiario s;

                        Proveedor Proveedor = db.Proveedores.Where(c => c.IdProveedor == mIdProveedor).SingleOrDefault();
                        if (Proveedor != null) { mIdCuentaProveedor = Proveedor.IdCuenta ?? mIdCuentaProveedor; }
                        else { mIdCuentaProveedor = ComprobanteProveedor.IdCuenta ?? (ComprobanteProveedor.IdCuentaOtros ?? 0); }

                        if (mIdCuentaProveedor > 0)
                        {
                            s = new Subdiario();
                            s.IdCuentaSubdiario = mIdCuentaComprasTitulo;
                            s.IdCuenta = mIdCuentaProveedor;
                            s.IdTipoComprobante = mIdTipoComprobante;
                            s.NumeroComprobante = ComprobanteProveedor.NumeroReferencia;
                            s.FechaComprobante = ComprobanteProveedor.FechaRecepcion;
                            s.IdComprobante = ComprobanteProveedor.IdComprobanteProveedor;
                            if (mCoef == 1) { s.Haber = mTotalComprobante; }
                            else { s.Debe = mTotalComprobante; }
                            s.IdMoneda = mIdMonedaPesos;
                            s.CotizacionMoneda = 1;

                            db.Subdiarios.Add(s);
                        }

                        mImporte = (ComprobanteProveedor.TotalBonificacion ?? 0) * mCotizacionMoneda;
                        if (mImporte != 0 && mIdCuentaBonificaciones > 0)
                        {
                            s = new Subdiario();
                            s.IdCuentaSubdiario = mIdCuentaComprasTitulo;
                            s.IdCuenta = mIdCuentaBonificaciones;
                            s.IdTipoComprobante = mIdTipoComprobante;
                            s.NumeroComprobante = ComprobanteProveedor.NumeroReferencia;
                            s.FechaComprobante = ComprobanteProveedor.FechaRecepcion;
                            s.IdComprobante = ComprobanteProveedor.IdComprobanteProveedor;
                            if (mCoef == 1) { s.Haber = mImporte; }
                            else { s.Debe = mImporte; }
                            s.IdMoneda = mIdMonedaPesos;
                            s.CotizacionMoneda = 1;

                            db.Subdiarios.Add(s);
                        }

                        foreach (var d in ComprobanteProveedor.DetalleComprobantesProveedores)
                        {
                            mImporte = (d.Importe ?? 0) * mCotizacionMoneda;
                            mImporteIva = (d.ImporteIVA1 ?? 0) * mCotizacionMoneda;

                            if ((ComprobanteProveedor.Letra ?? "") == "A" || (ComprobanteProveedor.Letra ?? "") == "M") { }
                            else { mIvaNoDiscriminadoItem = mIvaNoDiscriminadoItem + mImporteIva; }

                            if (mAjusteIVA != 0)
                            {
                                mImporteIva = mImporteIva + mAjusteIVA;
                                mAjusteIVA = 0;
                            }

                            mIdCuenta = d.IdCuentaIvaCompras1 ?? 0;
                            if (mIdCuenta > 0 && mImporteIva != 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaComprasTitulo;
                                s.IdCuenta = mIdCuenta;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = ComprobanteProveedor.NumeroReferencia;
                                s.FechaComprobante = ComprobanteProveedor.FechaRecepcion;
                                s.IdComprobante = ComprobanteProveedor.IdComprobanteProveedor;
                                if (mCoef == 1)
                                {
                                    if (mImporteIva >= 0) { s.Debe = mImporteIva; } else { s.Haber = mImporteIva * -1; };
                                }
                                else
                                {
                                    if (mImporteIva >= 0) { s.Haber = mImporteIva; } else { s.Debe = mImporteIva * -1; };
                                }
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;
                                if (mSubdiarios_ResumirRegistros != "SI") { s.IdDetalleComprobante = d.IdDetalleComprobanteProveedor; }

                                db.Subdiarios.Add(s);
                            }

                            mIdCuenta = d.IdCuenta ?? 0;
                            mImporte = mImporte - mIvaNoDiscriminadoItem;
                            if (mIdCuenta > 0 && mImporte != 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaComprasTitulo;
                                s.IdCuenta = mIdCuenta;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = ComprobanteProveedor.NumeroReferencia;
                                s.FechaComprobante = ComprobanteProveedor.FechaRecepcion;
                                s.IdComprobante = ComprobanteProveedor.IdComprobanteProveedor;
                                if (mCoef == 1)
                                {
                                    if (mImporte >= 0) { s.Debe = mImporte; } else { s.Haber = mImporte * -1; };
                                }
                                else
                                {
                                    if (mImporte >= 0) { s.Haber = mImporte; } else { s.Debe = mImporte * -1; };
                                }
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;
                                if (mSubdiarios_ResumirRegistros != "SI") { s.IdDetalleComprobante = d.IdDetalleComprobanteProveedor; }

                                db.Subdiarios.Add(s);
                            }
                        }

                        mIdCuenta = ComprobanteProveedor.ReintegroIdCuenta ?? 0;
                        mImporte = (ComprobanteProveedor.ReintegroImporte ?? 0) * mCotizacionMoneda;
                        if (mIdCuentaReintegros > 0 && mIdCuenta > 0 && mImporte != 0)
                        {
                            s = new Subdiario();
                            s.IdCuentaSubdiario = mIdCuentaComprasTitulo;
                            s.IdCuenta = mIdCuentaReintegros;
                            s.IdTipoComprobante = mIdTipoComprobante;
                            s.NumeroComprobante = ComprobanteProveedor.NumeroReferencia;
                            s.FechaComprobante = ComprobanteProveedor.FechaRecepcion;
                            s.IdComprobante = ComprobanteProveedor.IdComprobanteProveedor;
                            if (mCoef == 1) { s.Haber = mImporte; }
                            else { s.Debe = mImporte; }
                            s.IdMoneda = mIdMonedaPesos;
                            s.CotizacionMoneda = 1;

                            db.Subdiarios.Add(s);

                            s = new Subdiario();
                            s.IdCuentaSubdiario = mIdCuentaComprasTitulo;
                            s.IdCuenta = mIdCuenta;
                            s.IdTipoComprobante = mIdTipoComprobante;
                            s.NumeroComprobante = ComprobanteProveedor.NumeroReferencia;
                            s.FechaComprobante = ComprobanteProveedor.FechaRecepcion;
                            s.IdComprobante = ComprobanteProveedor.IdComprobanteProveedor;
                            if (mCoef == 1) { s.Debe = mImporte; }
                            else { s.Haber = mImporte; }
                            s.IdMoneda = mIdMonedaPesos;
                            s.CotizacionMoneda = 1;

                            db.Subdiarios.Add(s);
                        }

                        db.SaveChanges();

                        //////////////////////////////////////////////////////////
                        db.Tree_TX_Actualizar("ComprobantesPrvPorMes", ComprobanteProveedor.IdComprobanteProveedor, "ComprobanteProveedor");

                        //////////////////////////////////////////////////////////
                        scope.Complete();
                        scope.Dispose();
                        //////////////////////////////////////////////////////////
                    }

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdComprobanteProveedor = ComprobanteProveedor.IdComprobanteProveedor, ex = "" });
                }
                else
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "El comprobante tiene datos invalidos";

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
                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);

                res.Errors.Add(sb.ToString());
                res.Errors.Add(ex.ToString());
                res.Message = "El ComprobanteProveedor es inválido. " + ex.ToString();
                //return Json(res);
                //return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });

                return Json(res);
            }

            catch (TransactionAbortedException ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;
                return Json("TransactionAbortedException Message: {0}", ex.Message);
            }

            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;

                List<string> errors = new List<string>();
                errors.Add(ex.Message);
                return Json(errors);
            }
        }

        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer(enumNodos.ComprobantesPrv)) throw new Exception("No tenés permisos");

            if (!System.Diagnostics.Debugger.IsAttached && (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
             !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
             !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras") &&
                                     !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "FondosFijos")
                                     )
             ) throw new Exception("No tenés permisos");

            //verificar que sea FF o CTACTE

            ComprobanteProveedor ComprobanteProveedor;
            //ViewModelComprobanteProveedor ComprobanteProveedor;

            if (id == -1)
            {
                ComprobanteProveedor = new ComprobanteProveedor();
                inic(ref ComprobanteProveedor);
            }
            else
            {
                ComprobanteProveedor = fondoFijoService.ObtenerPorId(id);

                //ComprobanteProveedor = fondoFijoService.ComprobantesProveedor
                //           .Include(x => x.Proveedor)
                //           .Include(x => x.Proveedore)
                //           .Include(x => x.Obra)
                //           .Include(x => x.Cuenta)
                //           .SingleOrDefault(x => x.IdComprobanteProveedor == id);

                // Session.Add("ComprobanteProveedor", ComprobanteProveedor);
            }

            //ViewModelComprobanteProveedor vm = new ViewModelComprobanteProveedor();
            //AutoMapper.Mapper.CreateMap<Data.Models.ComprobanteProveedor, ViewModelComprobanteProveedor>();
            //AutoMapper.Mapper.Map(ComprobanteProveedor, vm);
            //CargarViewBag(vm);

            CargarViewBag(ComprobanteProveedor);

            if (id == -1)
            {
                return View(ComprobanteProveedor);
            }
            else if (ComprobanteProveedor.IdCuenta != null && ComprobanteProveedor.IdProveedor == null && ComprobanteProveedor.IdCuentaOtros == null)
            {
                // return View("EditFF", (ViewModelComprobanteProveedor)ComprobanteProveedor);
                return View("EditFF", ComprobanteProveedor);
            }
            else if (ComprobanteProveedor.IdCuentaOtros != null)
            {
                // return View("EditFF", (ViewModelComprobanteProveedor)ComprobanteProveedor);
                return View("EditOtros", ComprobanteProveedor);
            }
            else
            {
                // return View("Edit", (ViewModelComprobanteProveedor)ComprobanteProveedor);
                return View("Edit", ComprobanteProveedor);
            }
        }


        public virtual ActionResult EditFF(int id)
        {
            if (!PuedeLeer(enumNodos.ComprobantesPrv)) throw new Exception("No tenés permisos");
            return Edit(id);
        }

        public virtual ActionResult EditOtros(int id)
        {
            if (!PuedeLeer(enumNodos.ComprobantesPrv)) throw new Exception("No tenés permisos");
            return Edit(id);
        }

        public void Logica_VB6_Guardar(ref object ComprobanteProveedor, object Detalles, object RegistroContable, object DetallesProvincias)
        {
        }

        public void Logica_EliminarRegistroAnterior(ComprobanteProveedor o) { }

        public void Logica_VB6_RegistroContable() { }

        public virtual JsonResult PorcentajesIVA()
        {
            //Dictionary<int, string> unidades = new Dictionary<int, string>();
            //foreach (Unidad u in fondoFijoService.Unidades.ToList())
            //    unidades.Add(u.IdUnidad, u.Abreviatura);
            var unidades = (from u in fondoFijoService.Unidades_Listado()
                            select new { u.Abreviatura, u.Descripcion }).ToList();

            return Json("<select> <select> ", JsonRequestBehavior.AllowGet);
            return Json(unidades, JsonRequestBehavior.AllowGet);
            //return PartialView("Select", unidades);
        }

        public string ListaPorcentajesIVA()
        {
            List<string> combo2 = new List<string>();
            Dictionary<int, string> combo = new Dictionary<int, string>();
            //Dictionary<string, string> combo = new Dictionary<string, string>();
            //foreach (ControlCalidad u in fondoFijoService.ControlesCalidads.OrderBy(x => x.Descripcion).ToList())
            //                combo.Add(u.IdControlCalidad, u.Descripcion);

            string s = " 0:0 ";

            Parametros parametros = db.Parametros.Find(1); // fondoFijoService.Parametros();

            combo.Add(0, "0");
            //combo.Add("0", "0");

            for (int n = 1; n <= 10; n++)
            {
                var pIVAComprasPorcentaje = parametros.GetType().GetProperty("IVAComprasPorcentaje" + n);
                decimal IVAComprasPorcentajeval = (decimal)(pIVAComprasPorcentaje.GetValue(parametros, null) ?? 0M);

                var pIdCuentaIVACompras = parametros.GetType().GetProperty("IdCuentaIvaCompras" + n);
                int? IdCuentaIVACompras = (int?)pIdCuentaIVACompras.GetValue(parametros, null);

                if (IdCuentaIVACompras == null)
                {
                    continue;
                }

                //  combo.Add(IdCuentaIVACompras ?? 0, IVAComprasPorcentajeval.ToString());
                // combo.Add(IVAComprasPorcentajeval.ToString(), IVAComprasPorcentajeval.ToString());
                combo.Add(n, IVAComprasPorcentajeval.ToString());
                combo2.Add(IVAComprasPorcentajeval.ToString());

                s += "; " + IVAComprasPorcentajeval.ToString() + ":" + IVAComprasPorcentajeval.ToString() + " ";
            }
            //return " 21:21 ; 10.5:10.5 ; 27:27; 0:0; 18.5:18.5 ; 9.5:9.5 ";
            return s;
        }

        class ss
        {
            public int aa;
            public string s;
        }

        public virtual JsonResult ListaPorcentajesIVA2()
        {
            List<ss> combo2 = new List<ss>();
            Dictionary<int, string> combo = new Dictionary<int, string>();
            //Dictionary<string, string> combo = new Dictionary<string, string>();
            //foreach (ControlCalidad u in fondoFijoService.ControlesCalidads.OrderBy(x => x.Descripcion).ToList())
            //                combo.Add(u.IdControlCalidad, u.Descripcion);

            string s = " 0:0 ";

            Parametros parametros = fondoFijoService.Parametros();

            combo.Add(0, "0");
            //combo.Add("0", "0");

            for (int n = 1; n <= 10; n++)
            {
                var pIVAComprasPorcentaje = parametros.GetType().GetProperty("IVAComprasPorcentaje" + n);
                decimal IVAComprasPorcentajeval = (decimal)(pIVAComprasPorcentaje.GetValue(parametros, null) ?? 0M);

                var pIdCuentaIVACompras = parametros.GetType().GetProperty("IdCuentaIvaCompras" + n);
                int? IdCuentaIVACompras = (int?)pIdCuentaIVACompras.GetValue(parametros, null);


                if (IdCuentaIVACompras == null)
                {
                    continue;
                }

                //  combo.Add(IdCuentaIVACompras ?? 0, IVAComprasPorcentajeval.ToString());
                // combo.Add(IVAComprasPorcentajeval.ToString(), IVAComprasPorcentajeval.ToString());
                combo.Add(n, IVAComprasPorcentajeval.ToString());

                ss sd = new ss();
                sd.aa = n;
                sd.s = IVAComprasPorcentajeval.ToString();

                combo2.Add(sd);

                s += "; " + n + ":" + IVAComprasPorcentajeval.ToString() + " ";
            }


            //return " 21:21 ; 10.5:10.5 ; 27:27; 0:0; 18.5:18.5 ; 9.5:9.5 ";


            return Json(combo2, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult PorcentajesIVAaaa()
        {
            List<string> combo2 = new List<string>();
            Dictionary<int, string> combo = new Dictionary<int, string>();
            //Dictionary<string, string> combo = new Dictionary<string, string>();
            //foreach (ControlCalidad u in fondoFijoService.ControlesCalidads.OrderBy(x => x.Descripcion).ToList())
            //                combo.Add(u.IdControlCalidad, u.Descripcion);

            Parametros parametros = fondoFijoService.Parametros();

            combo.Add(0, "0");
            //combo.Add("0", "0");

            for (int n = 1; n <= 10; n++)
            {
                var pIVAComprasPorcentaje = parametros.GetType().GetProperty("IVAComprasPorcentaje" + n);
                decimal IVAComprasPorcentajeval = (decimal)(pIVAComprasPorcentaje.GetValue(parametros, null) ?? 0M);

                var pIdCuentaIVACompras = parametros.GetType().GetProperty("IdCuentaIvaCompras" + n);
                int? IdCuentaIVACompras = (int?)pIdCuentaIVACompras.GetValue(parametros, null);


                if (IdCuentaIVACompras == null)
                {
                    continue;
                }

                //  combo.Add(IdCuentaIVACompras ?? 0, IVAComprasPorcentajeval.ToString());
                // combo.Add(IVAComprasPorcentajeval.ToString(), IVAComprasPorcentajeval.ToString());
                combo.Add(n, IVAComprasPorcentajeval.ToString());
                combo2.Add(IVAComprasPorcentajeval.ToString());
            }

            return PartialView("Select", combo);
        }

        private int Busca_IdCuentaIVACompras_segun_Porcentaje(decimal porcentaje)
        {
            Parametros parametros = fondoFijoService.Parametros();

            for (int n = 1; n <= 10; n++)
            {
                var pIVAComprasPorcentaje = parametros.GetType().GetProperty("IVAComprasPorcentaje" + n);
                decimal IVAComprasPorcentajeval = (decimal)(pIVAComprasPorcentaje.GetValue(parametros, null) ?? 0M);

                var pIdCuentaIVACompras = parametros.GetType().GetProperty("IdCuentaIvaCompras" + n);
                int IdCuentaIVACompras = (int)(pIdCuentaIVACompras.GetValue(parametros, null) ?? 0);

                if (IVAComprasPorcentajeval == porcentaje)
                {
                    return IdCuentaIVACompras;
                }
            }

            throw new Exception("No se encontró porcentaje equivalente");
            return 0;
        }

        private bool ValidarAsiento(List<Subdiario> o)
        {
            decimal debe = 0;
            decimal haber = 0;

            List<Subdiario> copia = new List<Subdiario>(o);

            for (int n = o.Count - 1; n >= 0; n--)
            {
                Subdiario mov = o[n];

                if (mov == null)
                {
                    // throw new 
                    o.RemoveAt(n);
                    continue;
                }

                if (mov.FechaComprobante == null)
                {
                    throw new Exception("Falta la fecha");
                }

                debe += mov.Debe ?? 0;
                haber += mov.Haber ?? 0;
            }

            if (debe != haber)
            {
                // throw new Exception("Asiento no da cero"); ; //throw
            }

            return true;
        }

        private Subdiario movimient(int? Ejercicio, int? IdCuentaSubdiario, int? IdCuenta, int? TipoComprobante, int? NumeroComprobante, DateTime? FechaComprobante,
                                        int? IdComprobante, decimal? ImporteIva2,
                                        int? IdMoneda = 0, decimal? CotizacionMoneda = 1, string Detalle = "")
        {
            // Los IdCuentaSubdiario: 7 compras, 1 ventas, 4 caja y bancos

            //if (deber && haber =0) return;
            if ((ImporteIva2 ?? 0) == 0) return null;
            var s = new Subdiario();
            s.Ejercicio = Ejercicio;
            s.IdCuentaSubdiario = IdCuentaSubdiario;  // cómo funcionan estas dos cuentas (IdCuentaSubdiario y IdCuenta) ??
            s.IdCuenta = IdCuenta;
            s.IdTipoComprobante = TipoComprobante;
            s.NumeroComprobante = NumeroComprobante;
            s.FechaComprobante = FechaComprobante;
            s.IdComprobante = IdComprobante;

            s.Detalle = Detalle;

            if (ImporteIva2 > 0)
            {
                s.Haber = ImporteIva2 * CotizacionMoneda;
            }
            else if (ImporteIva2 < 0)
            {
                s.Debe = ImporteIva2 * CotizacionMoneda * -1;

            }
            else
            {

            }

            s.IdMoneda = IdMoneda;
            s.CotizacionMoneda = CotizacionMoneda;
            return s;
        }


        public void Logica_VB6_GuardarRegistroContable(object RegistroContable)
        {
        }

        void inic(ref ComprobanteProveedor o)
        {
            Parametros parametros = db.Parametros.Find(1); //fondoFijoService.Parametros();
            o.NumeroReferencia = parametros.ProximoComprobanteProveedorReferencia;
            //o.SubNumero = 1;
            o.FechaComprobante = DateTime.Today;

            o.FechaIngreso = DateTime.Today;
            o.FechaRecepcion = DateTime.Today;
            o.FechaVencimiento = DateTime.Today;
            o.FechaVencimientoCAI = DateTime.Today;

            o.IdTipoComprobante = 11; //factura de compra;

            ViewBag.MetaTipo = "Fondo Fijo";

            o.Letra = "A";
            o.NumeroComprobante1 = 1;
            o.NumeroComprobante2 = null;


            o.IdMoneda = 1;
            o.CotizacionMoneda = 1;
            ViewBag.Proveedor = "";

            //o.PorcentajeIva1 = 21;                  //  mvarP_IVA1_Tomado
            //o.FechaFactura = DateTime.Now;

            //Parametros parametros = fondoFijoService.Parametros();
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


            // fondoFijoService.Cotizaciones_TX_PorFechaMoneda(fecha,IdMoneda)
            var mvarCotizacion = db.Cotizaciones.OrderByDescending(x => x.IdCotizacion).FirstOrDefault().Cotizacion; //  mo  Cotizacion(Date, glbIdMonedaDolar);
            o.CotizacionMoneda = 1;
            //  o.CotizacionADolarFijo=
            o.CotizacionDolar = (decimal)(mvarCotizacion ?? 0);

            //o.DetalleFacturas.Add(new DetalleFactura());
            //o.DetalleFacturas.Add(new DetalleFactura());
            //o.DetalleFacturas.Add(new DetalleFactura());
        }

        public virtual ActionResult Create()
        {
            ViewBag.IdCondicionCompra = new SelectList(fondoFijoService.Condiciones_Compras_Listado(), "IdCondicionCompra", "Descripcion");
            ViewBag.IdMoneda = new SelectList(fondoFijoService.Monedas_Listado(), "IdMoneda", "Nombre");
            ViewBag.IdPlazoEntrega = new SelectList(fondoFijoService.PlazosEntregas_Listado(), "IdPlazoEntrega", "Descripcion");
            ViewBag.IdComprador = new SelectList(fondoFijoService.Empleados_Listado(), "IdEmpleado", "Nombre");
            ViewBag.Aprobo = new SelectList(fondoFijoService.Empleados_Listado(), "IdEmpleado", "Nombre");
            ViewBag.Proveedor = "";
            return View();
        }

        public virtual JsonResult Autorizaciones(int IdComprobanteProveedor)
        {
            var Autorizaciones = db.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante
                    ((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.ComprobantesProveedores, IdComprobanteProveedor);
            return Json(Autorizaciones, JsonRequestBehavior.AllowGet);
        }

        void CargarViewBag(ComprobanteProveedor o)
        {
            ViewBag.PorcentajesIVA = ListaPorcentajesIVA();
            //ViewBag.IdTipoComprobante = new SelectList(db.TiposComprobantes, "IdTipoComprobante", "Descripcion", o.IdTipoComprobante);
            ViewBag.IdTipoComprobante = new SelectList(db.TiposComprobantes.Where(x => (x.Agrupacion1 ?? "") == "PROVEEDORES"), "IdTipoComprobante", "Descripcion", o.IdTipoComprobante);
            ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras.OrderBy(x => x.Descripcion), "IdCondicionCompra", "Descripcion", o.IdCondicionCompra);
            ViewBag.IdMoneda = new SelectList(db.Monedas.OrderBy(x => x.Nombre), "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdPuntoVenta = new SelectList(db.PuntosVentas.Where(x => x.IdTipoComprobante == 11), "IdPuntoVenta", "PuntoVenta", o.IdPuntoVenta);
            ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", o.IdObra);
            ViewBag.IdIBCondicion = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);
            //ViewBag.IdPlazoEntrega = new SelectList(fondoFijoService.PlazosEntregas.OrderBy(x => x.Descripcion), "IdPlazoEntrega", "Descripcion", o.PlazoEntrega);
            //ViewBag.IdComprador = new SelectList(fondoFijoService.Empleados.OrderBy(x => x.Nombre), "IdEmpleado", "Nombre", o.IdComprador);
            //ViewBag.Aprobo = new SelectList(fondoFijoService.Empleados.OrderBy(x => x.Nombre), "IdEmpleado", "Nombre", o.Aprobo);
            ViewBag.Proveedor = (db.Proveedores.Find(o.IdProveedor) ?? new Proveedor()).RazonSocial;
            ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", (o.Proveedor ?? new Proveedor()).IdCodigoIva);
            ViewBag.CantidadAutorizaciones = db.Autorizaciones_TX_CantidadAutorizaciones((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.ComprobantesProveedores, 0, -1).Count();
            ViewBag.Letras = new SelectList(new List<string> { "A", "B", "C", "M" }, o.Letra);
        }

        void CargarViewBagViejo(ViewModelComprobanteProveedor o)
        {
            ViewBag.PorcentajesIVA = ListaPorcentajesIVA();

            ViewBag.IdTipoComprobante = new SelectList(db.TiposComprobantes, "IdTipoComprobante", "Descripcion", o.IdTipoComprobante);

            ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras.OrderBy(x => x.Descripcion), "IdCondicionCompra", "Descripcion", o.IdCondicionCompra);
            ViewBag.IdMoneda = new SelectList(db.Monedas.OrderBy(x => x.Nombre), "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdPuntoVenta = new SelectList(db.PuntosVentas.Where(x => x.IdTipoComprobante == 11), "IdPuntoVenta", "PuntoVenta", o.IdPuntoVenta);
            ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", o.IdObra);
            ViewBag.IdIBCondicion = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);
            //ViewBag.IdPlazoEntrega = new SelectList(fondoFijoService.PlazosEntregas.OrderBy(x => x.Descripcion), "IdPlazoEntrega", "Descripcion", o.PlazoEntrega);
            //ViewBag.IdComprador = new SelectList(fondoFijoService.Empleados.OrderBy(x => x.Nombre), "IdEmpleado", "Nombre", o.IdComprador);
            //ViewBag.Aprobo = new SelectList(fondoFijoService.Empleados.OrderBy(x => x.Nombre), "IdEmpleado", "Nombre", o.Aprobo);
            ViewBag.Proveedor = (db.Proveedores.Find(o.IdProveedor) ?? new Proveedor()).RazonSocial;

            ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", (o.Proveedor ?? new Proveedor()).IdCodigoIva);
            ViewBag.CantidadAutorizaciones = db.Autorizaciones_TX_CantidadAutorizaciones((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.ComprobantesProveedores, 0, -1).Count();

            ViewBag.Letra = new SelectList(new List<string> { "A", "B", "C", "M" }, o.Letra);


            //ViewBag.TotalBonificacionGlobal = o.Bonificacion;


            //ViewBag.Aprobo = new SelectList(fondoFijoService.Empleados, "IdEmpleado", "Nombre");
            //ViewBag.IdSolicito = new SelectList(fondoFijoService.Empleados, "IdEmpleado", "Nombre");
            //ViewBag.IdSector = new SelectList(fondoFijoService.Sectores, "IdSector", "Descripcion");
            //ViewBag.PuntoVenta = new SelectList((from i in fondoFijoService.PuntosVentas
            //                                     where i.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Factura
            //                                     select new { PuntoVenta = i.PuntoVenta })
            //    // http://stackoverflow.com/questions/2135666/databinding-system-string-does-not-contain-a-property-with-the-name-dbmake
            //                                     .Distinct(), "PuntoVenta", "PuntoVenta"); //traer solo el Numero de PuntoVenta, no el Id


            //ViewBag.IdObra = new SelectList(fondoFijoService.Obras, "IdObra", "NumeroObra", o.IdObra);
            //ViewBag.IdCliente = new SelectList(fondoFijoService.Clientes, "IdCliente", "RazonSocial", o.IdCliente);
            //ViewBag.IdTipoRetencionGanancia = new SelectList(fondoFijoService.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion", o.IdCodigoIva);
            ///ViewBag.IdCodigoIVA = new SelectList(fondoFijoService.DescripcionIvas, "IdCodigoIVA", "Descripcion", o.IdCodigoIva);
            //ViewBag.IdListaPrecios = new SelectList(fondoFijoService.ListasPrecios, "IdListaPrecios", "Descripcion", o.IdListaPrecios);
            //ViewBag.IdMoneda = new SelectList(fondoFijoService.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            //ViewBag.IdCondicionVenta = new SelectList(fondoFijoService.Condiciones_Compras, "IdCondicionCompra", "Descripcion", o.IdCondicionVenta);

            ////http://stackoverflow.com/questions/942262/add-empty-value-to-a-dropdownlist-in-asp-net-mvc
            //// http://stackoverflow.com/questions/7659612/mvc3-dropdownlist-and-viewbag-how-add-new-items-to-collection
            ////List<SelectListItem>  l = new SelectList(fondoFijoService.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);
            ////l.ad
            ////l.Add((new SelectListItem { IdIBCondicion = " ", Descripcion = "-1" }));
            //ViewBag.IdIBCondicionPorDefecto = new SelectList(fondoFijoService.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);

            //ViewBag.IdIBCondicionPorDefecto2 = new SelectList(fondoFijoService.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion2);
            //ViewBag.IdIBCondicionPorDefecto3 = new SelectList(fondoFijoService.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion3);

            //Parametros parametros = fondoFijoService.Parametros();
            //ViewBag.PercepcionIIBB = parametros.PercepcionIIBB;
        }

        private bool Validar(ProntoMVC.Data.Models.ComprobanteProveedor o, ref string sErrorMsg, ref string sWarningMsg)
        {
            decimal mTotalBruto = 0;
            decimal mTotalComprobante = 0;

            Int32 mIdObra = 0;

            string mTipoComprobante = "";
            string mvarControlFechaNecesidad = "";
            string mAuxS5 = "";
            string usuarionombre;
            string nombre = "";

            List<int> duplicates = o.DetalleComprobantesProveedores.Where(s => (s.IdDetalleComprobanteProveedor) > 0).GroupBy(s => s.IdDetalleComprobanteProveedor)
                         .Where(g => g.Count() > 1)
                         .Select(g => g.Key)
                         .ToList();

            if (duplicates.Count > 0)
            {
                foreach (int? i in duplicates)
                {
                    List<DetalleComprobantesProveedore> q = o.DetalleComprobantesProveedores.Where(x => x.IdDetalleComprobanteProveedor == i).Select(x => x).Skip(1).ToList();
                    foreach (DetalleComprobantesProveedore x in q)
                    {

                        // tacharlo de la grilla, no eliminarlo de pantalla
                        //string nombre = x.NumeroItem + " El item " + x.NumeroItem + "  (" + fondoFijoService.Articulos.Find(x.IdArticulo).Descripcion + ") ";
                        //sErrorMsg += "\n" + nombre + " usa un item de requerimiento que ya se está usando ";  // tacharlo de la grilla, no eliminarlo de pantalla
                    }
                }
            }

            o.Observaciones = o.Observaciones ?? "";
            o.TotalIva2 = 0;

            mTipoComprobante = "CC";
            if (o.IdProveedorEventual != null) { mTipoComprobante = "FF"; }
            if (o.IdCuentaOtros != null) { mTipoComprobante = "OT"; }

            if ((o.IdTipoComprobante ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el tipo de comprobante"; }
            if (mTipoComprobante == "CC" && (o.IdProveedor ?? 0) == 0) { sErrorMsg += "\n" + "Falta el proveedor"; }
            if (mTipoComprobante == "FF" && (o.IdProveedorEventual ?? 0) == 0) { sErrorMsg += "\n" + "Falta el proveedor"; }
            if (mTipoComprobante == "OT" && (o.IdCuentaOtros ?? 0) == 0) { sErrorMsg += "\n" + "Falta la cuenta de otros"; }
            if (o.FechaComprobante == null) sErrorMsg += "\n" + "Fecha del comprobante";
            if (o.FechaVencimiento == null) sErrorMsg += "\n" + "Fecha de cencimiento";
            if ((o.IdCodigoIva ?? 0) == 0) sErrorMsg += "\n" + "Error en codigo de iva";
            if ((o.Letra ?? "") == "") { sErrorMsg += "\n" + "Falta la Letra"; }
            if ((o.NumeroComprobante1 ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número de punto de venta"; }
            if ((o.NumeroComprobante2 ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número de comprobante"; }
            if ((o.IdCondicionCompra ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la condición de compra"; }
            if ((o.NumeroCAI ?? "") == "" && (o.NumeroCAE ?? "") == "") { sErrorMsg += "\n" + "Falta el número de CAI o CAE"; }
            if (o.FechaRecepcion == null) { sErrorMsg += "\n" + "Falta la fecha de recepción"; }
            if (o.FechaVencimientoCAI < DateTime.Today) { sErrorMsg += "\n" + "La fecha de CAI está vencida"; }
            if ((o.IdObra ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la obra"; }
            if ((o.CotizacionDolar ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la cotización"; }
            if ((o.IdMoneda ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la moneda"; }
            if (o.TotalComprobante <= 0) { sErrorMsg += "\n" + "El importe total debe ser mayor a 0"; }
            if ((o.BienesOServicios ?? "") == "") { sErrorMsg += "\n" + "Falta indicar si es un bien o un servicio"; }

            usuarionombre = oStaticMembershipService.GetUser().UserName;
            var mvarMontoMinimo = fondoFijoService.BuscarClaveINI("Monto minimo para registrar ComprobanteProveedor", usuarionombre);
            mvarControlFechaNecesidad = fondoFijoService.BuscarClaveINI("Quitar control fecha necesidad en ComprobantesProveedores", usuarionombre);
            mAuxS5 = fondoFijoService.BuscarClaveINI("Deshabilitar control de cuentas de obras", usuarionombre);

            var reqsToDelete = o.DetalleComprobantesProveedores.Where(x => (x.IdCuenta ?? 0) <= 0).ToList();
            foreach (var deleteReq in reqsToDelete)
            {
                o.DetalleComprobantesProveedores.Remove(deleteReq);
                sWarningMsg += "\n" + "El item no tiene cuenta. Se borra";
            }
            if (o.DetalleComprobantesProveedores.Count <= 0) sErrorMsg += "\n" + "El comprobante no tiene items";

            Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();

            foreach (ProntoMVC.Data.Models.DetalleComprobantesProveedore x in o.DetalleComprobantesProveedores)
            {
                mIdObra = x.IdObra ?? 0;
                if ((x.IdCuenta ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la cuenta contable del item"; }
                //if (x.CodigoCuenta == null) sErrorMsg += "\n " + nombre + " no CodigoCuenta";
                //if (x.IdCuentaGasto == null) sErrorMsg += "\n " + nombre + " no tiene cuenta de gasto asociada";
                //if (x.AplicarIVA1 == null) sErrorMsg += "\n " + nombre + " no AplicarIVA1";
                //if (x.TomarEnCalculoDeImpuestos == null) sErrorMsg += "\n " + nombre + " no TomarEnCalculoDeImpuestos";
                //if (x.IdProvinciaDestino1 == null) sErrorMsg += "\n " + nombre + " no IdProvinciaDestino1";
                //if (x.PorcentajeProvinciaDestino1 == null) sErrorMsg += "\n " + nombre + " no PorcentajeProvinciaDestino1";

                x.CodigoArticulo = "";

                x.IVAComprasPorcentaje1 = x.IVAComprasPorcentaje1 ?? 0;
                x.ImporteIVA1 = x.ImporteIVA1 ?? 0;
                x.AplicarIVA1 = x.AplicarIVA1 ?? "NO";
                x.IdCuentaIvaCompras1 = (x.IdCuentaIvaCompras1 <= 0) ? null : x.IdCuentaIvaCompras1;
                if (x.ImporteIVA1 != 0)
                {
                    if ((parametros.IVAComprasPorcentaje1 ?? -1) == x.IVAComprasPorcentaje1) { x.IdCuentaIvaCompras1 = parametros.IdCuentaIvaCompras1 ?? 0; }
                    if ((parametros.IVAComprasPorcentaje2 ?? -1) == x.IVAComprasPorcentaje1) { x.IdCuentaIvaCompras1 = parametros.IdCuentaIvaCompras2 ?? 0; }
                    if ((parametros.IVAComprasPorcentaje3 ?? -1) == x.IVAComprasPorcentaje1) { x.IdCuentaIvaCompras1 = parametros.IdCuentaIvaCompras3 ?? 0; }
                    if ((parametros.IVAComprasPorcentaje4 ?? -1) == x.IVAComprasPorcentaje1) { x.IdCuentaIvaCompras1 = parametros.IdCuentaIvaCompras4 ?? 0; }
                    if ((parametros.IVAComprasPorcentaje5 ?? -1) == x.IVAComprasPorcentaje1) { x.IdCuentaIvaCompras1 = parametros.IdCuentaIvaCompras5 ?? 0; }
                    if ((parametros.IVAComprasPorcentaje6 ?? -1) == x.IVAComprasPorcentaje1) { x.IdCuentaIvaCompras1 = parametros.IdCuentaIvaCompras6 ?? 0; }
                    if ((parametros.IVAComprasPorcentaje7 ?? -1) == x.IVAComprasPorcentaje1) { x.IdCuentaIvaCompras1 = parametros.IdCuentaIvaCompras7 ?? 0; }
                    if ((parametros.IVAComprasPorcentaje8 ?? -1) == x.IVAComprasPorcentaje1) { x.IdCuentaIvaCompras1 = parametros.IdCuentaIvaCompras8 ?? 0; }
                    if ((parametros.IVAComprasPorcentaje9 ?? -1) == x.IVAComprasPorcentaje1) { x.IdCuentaIvaCompras1 = parametros.IdCuentaIvaCompras9 ?? 0; }
                    if ((parametros.IVAComprasPorcentaje10 ?? -1) == x.IVAComprasPorcentaje1) { x.IdCuentaIvaCompras1 = parametros.IdCuentaIvaCompras10 ?? 0; }

                    if ((x.IdCuentaIvaCompras1 ?? -1) > 0) { x.AplicarIVA1 = "SI"; }
                }

                x.IVAComprasPorcentaje2 = x.IVAComprasPorcentaje2 ?? 0;
                x.ImporteIVA2 = x.ImporteIVA2 ?? 0;
                x.AplicarIVA2 = x.AplicarIVA2 ?? "NO";
                x.IdCuentaIvaCompras2 = (x.IdCuentaIvaCompras2 <= 0) ? null : x.IdCuentaIvaCompras2;

                x.IVAComprasPorcentaje3 = x.IVAComprasPorcentaje3 ?? 0;
                x.ImporteIVA3 = x.ImporteIVA3 ?? 0;
                x.AplicarIVA3 = x.AplicarIVA3 ?? "NO";
                x.IdCuentaIvaCompras3 = (x.IdCuentaIvaCompras3 <= 0) ? null : x.IdCuentaIvaCompras3;

                x.IVAComprasPorcentaje4 = x.IVAComprasPorcentaje4 ?? 0;
                x.ImporteIVA4 = x.ImporteIVA4 ?? 0;
                x.AplicarIVA4 = x.AplicarIVA4 ?? "NO";
                x.IdCuentaIvaCompras4 = (x.IdCuentaIvaCompras4 <= 0) ? null : x.IdCuentaIvaCompras4;

                x.IVAComprasPorcentaje5 = x.IVAComprasPorcentaje5 ?? 0;
                x.ImporteIVA5 = x.ImporteIVA5 ?? 0;
                x.AplicarIVA5 = x.AplicarIVA5 ?? "NO";
                x.IdCuentaIvaCompras5 = (x.IdCuentaIvaCompras5 <= 0) ? null : x.IdCuentaIvaCompras5;

                x.IVAComprasPorcentaje6 = x.IVAComprasPorcentaje6 ?? 0;
                x.ImporteIVA6 = x.ImporteIVA6 ?? 0;
                x.AplicarIVA6 = x.AplicarIVA6 ?? "NO";
                x.IdCuentaIvaCompras6 = (x.IdCuentaIvaCompras6 <= 0) ? null : x.IdCuentaIvaCompras6;

                x.IVAComprasPorcentaje7 = x.IVAComprasPorcentaje7 ?? 0;
                x.ImporteIVA7 = x.ImporteIVA7 ?? 0;
                x.AplicarIVA7 = x.AplicarIVA7 ?? "NO";
                x.IdCuentaIvaCompras7 = (x.IdCuentaIvaCompras7 <= 0) ? null : x.IdCuentaIvaCompras7;

                x.IVAComprasPorcentaje8 = x.IVAComprasPorcentaje8 ?? 0;
                x.ImporteIVA8 = x.ImporteIVA8 ?? 0;
                x.AplicarIVA8 = x.AplicarIVA8 ?? "NO";
                x.IdCuentaIvaCompras8 = (x.IdCuentaIvaCompras8 <= 0) ? null : x.IdCuentaIvaCompras8;

                x.IVAComprasPorcentaje9 = x.IVAComprasPorcentaje9 ?? 0;
                x.ImporteIVA9 = x.ImporteIVA9 ?? 0;
                x.AplicarIVA9 = x.AplicarIVA9 ?? "NO";
                x.IdCuentaIvaCompras9 = (x.IdCuentaIvaCompras9 <= 0) ? null : x.IdCuentaIvaCompras9;

                x.IVAComprasPorcentaje10 = x.IVAComprasPorcentaje10 ?? 0;
                x.ImporteIVA10 = x.ImporteIVA10 ?? 0;
                x.AplicarIVA10 = x.AplicarIVA10 ?? "NO";
                x.IdCuentaIvaCompras10 = (x.IdCuentaIvaCompras10 <= 0) ? null : x.IdCuentaIvaCompras10;

                mTotalBruto += (x.Importe ?? 0);
                mTotalComprobante += (x.Importe ?? 0) + (x.ImporteIVA1 ?? 0);
            }

            o.TotalBruto = mTotalBruto;

            if (mTotalComprobante != (o.TotalComprobante ?? 0)) { sErrorMsg += "\n" + "El total del comprobante no coincide con la suma de los items"; }

            sErrorMsg = sErrorMsg.Replace("\n", "<br/>"); //     ,"&#13;&#10;"); // "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        private bool Validar_CuentaCorriente(ViewModelComprobanteProveedor o, ref string sErrorMsg, ref string sWarningMsg)
        {
            // una opcion es extender el modelo autogenerado, para ensoquetar ahí las validaciones
            // si no, podemos usar una funcion como esta, y devolver los  errores de dos maneras:
            // con ModelState.AddModelError si los devolvemos en una ViewResult,
            // o con un array de strings si es una JsonResult.
            //
            // if you are returning JSON, you cannot use ModelState.
            // http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json
            //res.Errors = GetModelStateErrorsAsString(this.ModelState);

            List<int> duplicates = o.DetalleComprobantesProveedores.Where(s => (s.IdDetalleComprobanteProveedor) > 0).GroupBy(s => s.IdDetalleComprobanteProveedor)
                         .Where(g => g.Count() > 1)
                         .Select(g => g.Key)
                         .ToList();

            if (duplicates.Count > 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");

                foreach (int? i in duplicates)
                {
                    List<DetalleComprobantesProveedore> q = o.DetalleComprobantesProveedores.Where(x => x.IdDetalleComprobanteProveedor == i).Select(x => x).Skip(1).ToList();
                    foreach (DetalleComprobantesProveedore x in q)
                    {
                        // tacharlo de la grilla, no eliminarlo de pantalla
                        // tacharlo de la grilla, no eliminarlo de pantalla
                        //string nombre = x.NumeroItem + " El item " + x.NumeroItem + "  (" + fondoFijoService.Articulos.Find(x.IdArticulo).Descripcion + ") ";
                        //sErrorMsg += "\n" + nombre + " usa un item de requerimiento que ya se está usando ";  // tacharlo de la grilla, no eliminarlo de pantalla
                        //// tacharlo de la grilla, no eliminarlo de pantalla
                        // tacharlo de la grilla, no eliminarlo de pantalla
                    }
                }
            }

            //  if (!PuedeEditar(enumNodos.Facturas")) sErrorMsg += "\n" + "No tiene permisos de edición";

            if ((o.IdTipoComprobante ?? 0) <= 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta el tipo de comprobante";
                // return false;
            }

            //acá tengo que ver  el tipo del viewmodel

            if (o.MetaTipo == "Cta Cte")
            {
                //if ((o.Proveedor.RazonSocial ?? 0) <= 0)
                //{
                //    // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                //    sErrorMsg += "\n" + "Falta el tipo de comprobante";
                //    // return false;
                //}
            }

            if (o.IdProveedor == null && o.MetaTipo == "Cta Cte")
            {
                sErrorMsg += "\n" + "Falta el proveedor";
            }

            if ((o.IdCuentaOtros ?? 0) <= 0 && o.MetaTipo == "Otros") // && o.IdTipoComprobante == 1) // agregar al modelo de la vista (porque es un dato que no está en el modelo sql) si es ctacte/fondofijo/otros
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                //     sErrorMsg += "\n" + "Falta la cuenta de fondo fijo";
                sErrorMsg += "\n" + "Falta la cuenta";
            }

            if ((o.IdCuenta ?? 0) <= 0 && o.MetaTipo == "Fondo fijo")
            {
                //         Case 	When cp.IdProveedor is not null Then 'Cta. cte.' 
                //When cp.IdCuenta is not null Then 'F.fijo' 
                //When cp.IdCuentaOtros is not null Then 'Otros' 
                //    // se pone el proveedor de ff en el idproveedoreventual???????
            }

            if (o.IdProveedor != null)          // cta cte
            {
                //var aa = fondoFijoService.Proveedores.Find(o.IdProveedor);
                //mvarCuentaProveedor = aa.IdCuenta ?? 0;
            }
            else if (o.IdCuenta != null)        // fondo fijo
            {
                //mvarCuentaProveedor = o.IdCuenta ?? 0;
            }
            else if (o.IdCuentaOtros != null)   // otros
            {
                //mvarCuentaProveedor = o.IdCuentaOtros ?? 0;
            }
            else
            {
                //  throw new Exception("asdasd");
            }

            o.Observaciones = o.Observaciones ?? "";

            string usuario = ViewBag.NombreUsuario;
            if (Debugger.IsAttached) usuario = "Mariano";

            int IdUsuario = fondoFijoService.Empleados_Listado().Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
            if (o.IdComprobanteProveedor > 0)
            {
                o.IdUsuarioModifico = IdUsuario;
                o.FechaModifico = DateTime.Now;
            }
            else
            {
                o.IdUsuarioIngreso = IdUsuario;
                o.FechaIngreso = DateTime.Now;

            }

            o.TotalIva2 = 0;
            o.IdCodigoIva = 1; // o.Proveedore.IdCodigoIva;
            o.Dolarizada = "NO";
            o.PorcentajeIVAParaMonotributistas = 0;
            o.CircuitoFirmasCompleto = "SI";
            o.TotalIvaNoDiscriminado = 0;
            o.DestinoPago = "A"; // adm y obra
            o.FechaAsignacionPresupuesto = DateTime.Now;

            // if (o.FechaComprobante == null) sErrorMsg += "\n" + "FechaComprobante";
            if (o.FechaVencimiento == null) sErrorMsg += "\n" + "FechaVencimiento";
            //if (o.TotalBruto == null) sErrorMsg += "\n" + "TotalBruto";
            if (o.TotalIva2 == null) sErrorMsg += "\n" + "TotalIva2";
            if (o.Observaciones == null) sErrorMsg += "\n" + "Observaciones";
            if (o.TotalIvaNoDiscriminado == null) sErrorMsg += "\n" + "TotalIvaNoDiscriminado";
            //if (o.IdUsuarioModifico == null) sErrorMsg += "\n" + "IdUsuarioModifico";
            //if (o.FechaModifico == null) sErrorMsg += "\n" + "FechaModifico";
            if (o.IdCodigoIva == null) sErrorMsg += "\n" + "IdCodigoIva";
            //if (o.CotizacionEuro == null) sErrorMsg += "\n" + "";
            if (o.DestinoPago == null) sErrorMsg += "\n" + "DestinoPago";
            if (o.Dolarizada == null) sErrorMsg += "\n" + "Dolarizada";
            if (o.PorcentajeIVAParaMonotributistas == null) sErrorMsg += "\n" + "PorcentajeIVAParaMonotributistas";
            if (o.CircuitoFirmasCompleto == null) sErrorMsg += "\n" + "CircuitoFirmasCompleto";

            if (o.IdComprobanteProveedor <= 0)
            {
                //  string connectionString = Generales.sCadenaConexSQL(this.Session["BasePronto"].ToString());
                //  o.NumeroFactura = (int)Pronto.ERP.Bll.FacturaManager.ProximoNumeroFacturaPorIdCodigoIvaYNumeroDePuntoVenta(connectionString,o.IdCodigoIva ?? 0,o.PuntoVenta ?? 0);
            }

            if ((o.IdCondicionCompra ?? 0) <= 0) o.IdCondicionCompra = 247;

            if ((o.NumeroRendicionFF ?? 0) <= 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                //    sErrorMsg += "\n" + "Falta el número de rendición";
                // return false;
            }

            if ((o.Letra ?? "") == "")
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta la Letra";
                // return false;
            }

            if ((o.NumeroComprobante1 ?? 0) <= 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta el número de punto de venta";
                // return false;
            }

            if ((o.NumeroComprobante2 ?? 0) <= 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta el número de comprobante";
                // return false;
            }

            if ((o.IdCondicionCompra ?? 0) <= 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta la condición de compra";
                // return false;
            }

            // if (Generales.Val(o.NumeroCAI) <= 0) // no puedo usar Val con el CAI, es muy grande
            if (o.NumeroCAI == "") // no puedo usar Val con el CAI, es muy grande
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta el número de CAI";
                // return false;
            }

            if (o.FechaRecepcion == null)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta la fecha de recepción";
                // return false;
            }

            if (o.FechaVencimientoCAI < DateTime.Today)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "La fecha de CAI está vencida";
                // return false;
            }

            if ((o.IdObra ?? 0) <= 0)
            {
                // sErrorMsg += "\n" + "Falta la obra";
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

            bool mExigirTrasabilidad_RMLA_PE = false, PorObra, mTrasabilidad_RM_LA = false;
            string mvarControlFechaNecesidad = "";
            string mAuxS5 = "";
            int mIdObra = 0;
            int mIdTipoCuenta = 0;

            string usuarionombre;

            if (Debugger.IsAttached) usuarionombre = "Mariano";
            else usuarionombre = oStaticMembershipService.GetUser().UserName;

            var mvarMontoMinimo = fondoFijoService.BuscarClaveINI("Monto minimo para registrar ComprobanteProveedor", usuarionombre);

            if (o.TotalComprobante <= 0)
            {
                sErrorMsg += "\n" + "El importe total debe ser mayor a 0";
            }

            mvarControlFechaNecesidad = fondoFijoService.BuscarClaveINI("Quitar control fecha necesidad en ComprobantesProveedores", usuarionombre);
            mAuxS5 = fondoFijoService.BuscarClaveINI("Deshabilitar control de cuentas de obras", usuarionombre);

            var reqsToDelete = o.DetalleComprobantesProveedores.Where(x => (x.IdCuenta ?? 0) <= 0).ToList();
            foreach (var deleteReq in reqsToDelete)
            {
                o.DetalleComprobantesProveedores.Remove(deleteReq);
                sWarningMsg += "\n" + "El item no tiene cuenta. Se borra";
            }

            if (o.DetalleComprobantesProveedores.Count <= 0) sErrorMsg += "\n" + "El comprobante no tiene items";

            decimal tot = 0;

            foreach (ProntoMVC.Data.Models.DetalleComprobantesProveedore x in o.DetalleComprobantesProveedores)
            {
                string nombre = "";

                if ((o.IdObra ?? 0) > 0) x.IdObra = o.IdObra;

                Cuenta cuenta;

                try
                {
                    cuenta = fondoFijoService.CuentasById(x.IdCuenta);
                    nombre = " El item  (" + cuenta.Descripcion + ") ";
                    x.CodigoCuenta = cuenta.Codigo.ToString();
                    x.IdCuentaGasto = cuenta.IdCuentaGasto;

                }
                catch (Exception ex)
                {
                    ErrHandler.WriteError(ex);
                    nombre = " El item ";
                    sErrorMsg += "\n " + nombre + " (importe " + x.Importe.NullSafeToString() + ")  no tiene una cuenta válida";
                }

                x.TomarEnCalculoDeImpuestos = "SI";
                x.IdProvinciaDestino1 = 2; //16
                x.PorcentajeProvinciaDestino1 = 100;

                if (x.CodigoCuenta == null) sErrorMsg += "\n " + nombre + " no CodigoCuenta";
                // if (x.IdCuentaGasto == null) sErrorMsg += "\n " + nombre + " no tiene cuenta de gasto asociada";
                // if (x.IdCuentaIvaCompras1 == null) sErrorMsg += "\n " + nombre + " no IdCuentaIvaCompras1";
                if (x.AplicarIVA1 == null) sErrorMsg += "\n " + nombre + " no AplicarIVA1";
                if (x.TomarEnCalculoDeImpuestos == null) sErrorMsg += "\n " + nombre + " no TomarEnCalculoDeImpuestos";
                if (x.IdProvinciaDestino1 == null) sErrorMsg += "\n " + nombre + " no IdProvinciaDestino1";
                if (x.PorcentajeProvinciaDestino1 == null) sErrorMsg += "\n " + nombre + " no PorcentajeProvinciaDestino1";



                x.IVAComprasPorcentaje1 = x.IVAComprasPorcentaje1 ?? 0;
                x.ImporteIVA1 = x.ImporteIVA1 ?? 0;
                x.AplicarIVA1 = x.AplicarIVA1 ?? "NO";
                x.IdCuentaIvaCompras1 = (x.IdCuentaIvaCompras1 <= 0) ? null : x.IdCuentaIvaCompras1;

                x.IVAComprasPorcentaje2 = x.IVAComprasPorcentaje2 ?? 0;
                x.ImporteIVA2 = x.ImporteIVA2 ?? 0;
                x.AplicarIVA2 = x.AplicarIVA2 ?? "NO";
                x.IdCuentaIvaCompras2 = (x.IdCuentaIvaCompras2 <= 0) ? null : x.IdCuentaIvaCompras2;

                x.IVAComprasPorcentaje3 = x.IVAComprasPorcentaje3 ?? 0;
                x.ImporteIVA3 = x.ImporteIVA3 ?? 0;
                x.AplicarIVA3 = x.AplicarIVA3 ?? "NO";
                x.IdCuentaIvaCompras3 = (x.IdCuentaIvaCompras3 <= 0) ? null : x.IdCuentaIvaCompras3;

                x.IVAComprasPorcentaje4 = x.IVAComprasPorcentaje4 ?? 0;
                x.ImporteIVA4 = x.ImporteIVA4 ?? 0;
                x.AplicarIVA4 = x.AplicarIVA4 ?? "NO";
                x.IdCuentaIvaCompras4 = (x.IdCuentaIvaCompras4 <= 0) ? null : x.IdCuentaIvaCompras4;

                x.IVAComprasPorcentaje5 = x.IVAComprasPorcentaje5 ?? 0;
                x.ImporteIVA5 = x.ImporteIVA5 ?? 0;
                x.AplicarIVA5 = x.AplicarIVA5 ?? "NO";
                x.IdCuentaIvaCompras5 = (x.IdCuentaIvaCompras5 <= 0) ? null : x.IdCuentaIvaCompras5;

                x.IVAComprasPorcentaje6 = x.IVAComprasPorcentaje6 ?? 0;
                x.ImporteIVA6 = x.ImporteIVA6 ?? 0;
                x.AplicarIVA6 = x.AplicarIVA6 ?? "NO";
                x.IdCuentaIvaCompras6 = (x.IdCuentaIvaCompras6 <= 0) ? null : x.IdCuentaIvaCompras6;

                x.IVAComprasPorcentaje7 = x.IVAComprasPorcentaje7 ?? 0;
                x.ImporteIVA7 = x.ImporteIVA7 ?? 0;
                x.AplicarIVA7 = x.AplicarIVA7 ?? "NO";
                x.IdCuentaIvaCompras7 = (x.IdCuentaIvaCompras7 <= 0) ? null : x.IdCuentaIvaCompras7;

                x.IVAComprasPorcentaje8 = x.IVAComprasPorcentaje8 ?? 0;
                x.ImporteIVA8 = x.ImporteIVA8 ?? 0;
                x.AplicarIVA8 = x.AplicarIVA8 ?? "NO";
                x.IdCuentaIvaCompras8 = (x.IdCuentaIvaCompras8 <= 0) ? null : x.IdCuentaIvaCompras8;

                x.IVAComprasPorcentaje9 = x.IVAComprasPorcentaje9 ?? 0;
                x.ImporteIVA9 = x.ImporteIVA9 ?? 0;
                x.AplicarIVA9 = x.AplicarIVA9 ?? "NO";
                x.IdCuentaIvaCompras9 = (x.IdCuentaIvaCompras9 <= 0) ? null : x.IdCuentaIvaCompras9;

                x.IVAComprasPorcentaje10 = x.IVAComprasPorcentaje10 ?? 0;
                x.ImporteIVA10 = x.ImporteIVA10 ?? 0;
                x.AplicarIVA10 = x.AplicarIVA10 ?? "NO";
                x.IdCuentaIvaCompras10 = (x.IdCuentaIvaCompras10 <= 0) ? null : x.IdCuentaIvaCompras10;

                if (mIdObra > 0 && mAuxS5 != "SI")
                {
                    var oRsx = Pronto.ERP.Bll.EntidadManager.TraerFiltrado(SCsql(), ProntoFuncionesGenerales.enumSPs.Articulos_TX_DatosConCuenta, x.IdArticulo);

                    mIdTipoCuenta = 0;
                    //no anda, arreglar    if (oRsx.Rows.Count > 0) mIdTipoCuenta = (int)oRsx.Rows[0]["IdTipoCuentaCompras"];

                    if (mIdTipoCuenta == 4)
                    {
                        var oRs = Pronto.ERP.Bll.EntidadManager.TraerFiltrado(SCsql(), ProntoFuncionesGenerales.enumSPs.Cuentas_TX_PorObraCuentaMadre,
                                    mIdObra, 0, x.IdArticulo, o.FechaComprobante);
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

                tot += (x.Importe ?? 0) + (x.ImporteIVA1 ?? 0);
            }

            if (tot != o.TotalComprobante && false)
            {
                string s = "\n Hay problemas en el recálculo del total. renglon con importe pero sin cuenta de gasto elegida? Por favor, [pagina de error, metodos de error] total calculado " + tot + "      total en el comprobante" + (o.TotalComprobante ?? 0);
                sWarningMsg += s;
                sErrorMsg += s;
                o.TotalComprobante = tot;
            }

            sErrorMsg = sErrorMsg.Replace("\n", "<br/>"); //     ,"&#13;&#10;"); // "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        public virtual ActionResult IncrementarRendicionFF(int idcuentaFF)
        {
            IncrementarRendicionFForiginal(idcuentaFF);
            return RedirectToAction("IndexFF", "Cuenta");
        }

        //[HttpPost]
        public virtual JsonResult IncrementarRendicionFForiginal(int idcuentaFF)
        {
            int mProximaRendicion = -1;
            try
            {
                if (mProximaRendicion == -1)
                {
                    mProximaRendicion = (fondoFijoService.CuentasById(idcuentaFF).NumeroAuxiliar ?? 0) + 1;
                }
                string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
                EntidadManager.Tarea(SC, "Cuentas_IncrementarRendicionFF", idcuentaFF, mProximaRendicion);

                return Json("Hecho  nueva rendicion:" + mProximaRendicion + " " + fondoFijoService.CuentasById(idcuentaFF).Descripcion, JsonRequestBehavior.AllowGet);

            }
            catch (Exception)
            {
                return Json("Error", JsonRequestBehavior.AllowGet);
                //throw;
            }
        }

        // es GET, no POST, porque el Validar no hace modificaciones (idempotencia) // [HttpPost]
        // -peeeeero surge un problema:
        //  Why you didn't add type: "POST" in $.ajax? Other way, i think it does GET request, and data has to be given in one string like this: var=val&var2=val2
        // y queda muy larga la url, así que vuelvo a ponerlo como POST
        [HttpPost]
        public virtual JsonResult ValidarJson(ComprobanteProveedor ComprobanteProveedor)
        {
            string ms = "";
            string ws = "";
            JsonResponse res = new JsonResponse();

            try
            {
                Validar(ComprobanteProveedor, ref ms, ref ws);

                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);


                string[] errs = ms.Replace("<br/>", "\n").Split('\n');

                foreach (string s in errs)
                {
                    if (s == "") continue;
                    res.Errors.Add(s);
                }

                res.Message = String.Join("<br/>", errs); // "Errores";
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);
                res.Message = "El ComprobanteProveedor es inválido. " + ex.ToString();
                //                throw;
            }

            return Json(res);
        }

        public virtual ActionResult EditExterno(int id)
        {
            if (!PuedeLeer(enumNodos.ComprobantesPrv)) throw new Exception("No tenés permisos");

            if (id == -1)
            {
                ComprobanteProveedor ComprobanteProveedor = new ComprobanteProveedor();
                Parametros parametros = fondoFijoService.Parametros();
                //ComprobanteProveedor.Numero = parametros.ProximoComprobanteProveedor;
                //ComprobanteProveedor.SubNumero = 1;
                //ComprobanteProveedor.FechaIngreso = DateTime.Today;
                ComprobanteProveedor.IdMoneda = 1;
                ComprobanteProveedor.CotizacionMoneda = 1;
                ViewBag.IdCondicionCompra = new SelectList(fondoFijoService.Condiciones_Compras_Listado(), "IdCondicionCompra", "Descripcion");
                ViewBag.IdMoneda = new SelectList(fondoFijoService.Monedas_Listado(), "IdMoneda", "Nombre", ComprobanteProveedor.IdMoneda);
                ViewBag.IdPlazoEntrega = new SelectList(fondoFijoService.PlazosEntregas_Listado(), "IdPlazoEntrega", "Descripcion");
                ViewBag.IdComprador = new SelectList(fondoFijoService.Empleados_Listado(), "IdEmpleado", "Nombre");
                ViewBag.Aprobo = new SelectList(fondoFijoService.Empleados_Listado(), "IdEmpleado", "Nombre");
                ViewBag.Proveedor = "";
                return View(ComprobanteProveedor);
            }
            else
            {
                ComprobanteProveedor ComprobanteProveedor = fondoFijoService.ObtenerPorId(id);

                int idproveedor = fondoFijoService.buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));
                if (idproveedor > 0 && ComprobanteProveedor.IdProveedor != idproveedor) throw new Exception("Sólo podes acceder a ComprobantesProveedores tuyos");

                ViewBag.IdCondicionCompra = new SelectList(fondoFijoService.Condiciones_Compras_Listado(), "IdCondicionCompra", "Descripcion", ComprobanteProveedor.IdCondicionCompra);
                ViewBag.IdMoneda = new SelectList(fondoFijoService.Monedas_Listado(), "IdMoneda", "Nombre", ComprobanteProveedor.IdMoneda);
                //ViewBag.IdPlazoEntrega = new SelectList(fondoFijoService.PlazosEntregas, "IdPlazoEntrega", "Descripcion", ComprobanteProveedor.PlazoEntrega);
                //ViewBag.IdComprador = new SelectList(fondoFijoService.Empleados, "IdEmpleado", "Nombre", ComprobanteProveedor.IdComprador);
                //ViewBag.Aprobo = new SelectList(fondoFijoService.Empleados, "IdEmpleado", "Nombre", ComprobanteProveedor.Aprobo);
                ViewBag.Proveedor = fondoFijoService.ProveedoresById(ComprobanteProveedor.IdProveedor).RazonSocial;
                Session.Add("ComprobanteProveedor", ComprobanteProveedor);
                return View(ComprobanteProveedor);
            }
        }

        public class ComprobantesProveedores2
        {
            public int IdComprobanteProveedor { get; set; }
            public string TipoComprobante { get; set; }
            public string Letra { get; set; }
            public string NumeroComprobante1 { get; set; }
            public string NumeroComprobante2 { get; set; }
            public int? PuntoVenta { get; set; }
            public int? NumeroReferencia { get; set; }
            public string Tipo { get; set; }
            public DateTime? FechaComprobante { get; set; }
            public DateTime? FechaRecepcion { get; set; }
            public DateTime? FechaVencimiento { get; set; }
            public string ProveedorCodigo { get; set; }
            public string Proveedor { get; set; }
            public string Cuenta { get; set; }
            public int? NumeroOrdenPago_Vale { get; set; }
            public string CondicionIva { get; set; }
            public string Obra { get; set; }
            public string CuentaContable { get; set; }
            public decimal? TotalBruto { get; set; }
            public decimal? NetoGravado { get; set; }
            public decimal? TotalIva { get; set; }
            public decimal? AjusteIVA { get; set; }
            public decimal? TotalBonificacion { get; set; }
            public decimal? TotalComprobante { get; set; }
            public string Moneda { get; set; }
            public decimal? CotizacionDolar { get; set; }
            public string ProvinciaDestino { get; set; }
            public string Observaciones { get; set; }
            public string Ingreso { get; set; }
            public DateTime? FechaIngreso { get; set; }
            public string Modifico { get; set; }
            public DateTime? FechaModifico { get; set; }
            public int? NumeroRendicionFF { get; set; }
            public string Etapa { get; set; }
            public string Rubro { get; set; }
            public string CircuitoFirmasCompleto { get; set; }
            public string Pedidos { get; set; }
            public string Recepciones { get; set; }
            public string Subcontratos { get; set; }
            public string NumeroCAI { get; set; }
            public string NumeroCAE { get; set; }
            public string ControlAFIP_Resultado { get; set; }
            public string ControlAFIP_Mensaje { get; set; }
            public DateTime? ControlAFIP_Fecha { get; set; }
            public string Confirmado { get; set; }
            public int? Items { get; set; }
        }

        public virtual JsonResult ComprobantesProveedor_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal)
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

            var data = (from a in db.ComprobantesProveedor
                        from b in db.TiposComprobantes.Where(o => o.IdTipoComprobante == a.IdTipoComprobante).DefaultIfEmpty()
                        from c in db.OrdenesPago.Where(o => o.IdOrdenPago == a.IdOrdenPago).DefaultIfEmpty()
                        from d in db.Provincias.Where(o => o.IdProvincia == a.IdProvinciaDestino).DefaultIfEmpty()
                        from e in db.Empleados.Where(o => o.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from f in db.Empleados.Where(o => o.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        select new ComprobantesProveedores2
                        {
                            IdComprobanteProveedor = a.IdComprobanteProveedor,
                            TipoComprobante = b != null ? b.Descripcion : "",
                            Letra = a.Letra,
                            NumeroComprobante1 = SqlFunctions.Replicate("0", 4 - a.NumeroComprobante1.ToString().Length) + a.NumeroComprobante1.ToString(),
                            NumeroComprobante2 = SqlFunctions.Replicate("0", 8 - a.NumeroComprobante2.ToString().Length) + a.NumeroComprobante2.ToString(),
                            PuntoVenta = a.PuntoVenta,
                            NumeroReferencia = a.NumeroReferencia,
                            Tipo = (a.IdProveedor != null ? "Cta. cte." : (a.IdCuenta != null ? "F.fijo" : (a.IdCuentaOtros != null ? "Otros" : ""))),
                            FechaComprobante = a.FechaComprobante,
                            FechaRecepcion = a.FechaRecepcion,
                            FechaVencimiento = a.FechaVencimiento,
                            ProveedorCodigo = a.Proveedor != null ? a.Proveedor.CodigoEmpresa : "",
                            Proveedor = a.Proveedor != null ? a.Proveedor.RazonSocial : "",
                            Cuenta = a.Cuenta.Descripcion,
                            NumeroOrdenPago_Vale = c != null ? c.NumeroOrdenPago : 0,
                            CondicionIva = a.DescripcionIva.Descripcion,
                            Obra = a.Obra != null ? a.Obra.NumeroObra : "",
                            CuentaContable = db.Cuentas.Where(x => x.IdCuenta == (a.DetalleComprobantesProveedores.Select(y => y.IdCuenta).FirstOrDefault())).Select(x => x.Descripcion).FirstOrDefault(),
                            TotalBruto = a.TotalBruto,
                            NetoGravado = (a.DetalleComprobantesProveedores.Where(x => (x.ImporteIVA1 ?? 0) != 0 || (x.ImporteIVA2 ?? 0) != 0 || (x.ImporteIVA3 ?? 0) != 0 || (x.ImporteIVA4 ?? 0) != 0 || (x.ImporteIVA5 ?? 0) != 0 || (x.ImporteIVA6 ?? 0) != 0 || (x.ImporteIVA7 ?? 0) != 0 || (x.ImporteIVA8 ?? 0) != 0 || (x.ImporteIVA9 ?? 0) != 0 || (x.ImporteIVA10 ?? 0) != 0).Sum(y => y.Importe)) ?? 0,
                            TotalIva = a.TotalIva1,
                            AjusteIVA = a.AjusteIVA,
                            TotalBonificacion = a.TotalBonificacion,
                            TotalComprobante = a.TotalComprobante,
                            Moneda = a.Moneda == null ? "" : a.Moneda.Abreviatura,
                            CotizacionDolar = a.CotizacionDolar,
                            ProvinciaDestino = d != null ? d.Nombre : "",
                            Observaciones = a.Observaciones,
                            Ingreso = e != null ? e.Nombre : "",
                            FechaIngreso = a.FechaIngreso,
                            Modifico = f != null ? f.Nombre : "",
                            FechaModifico = a.FechaModifico,
                            NumeroRendicionFF = a.NumeroRendicionFF,
                            Etapa = "",
                            Rubro = "",
                            CircuitoFirmasCompleto = a.CircuitoFirmasCompleto,
                            Pedidos = ModelDefinedFunctions.ComprobantesProveedores_Pedidos(a.IdComprobanteProveedor).ToString(),
                            Recepciones = ModelDefinedFunctions.ComprobantesProveedores_Recepciones(a.IdComprobanteProveedor).ToString(),
                            Subcontratos = ModelDefinedFunctions.ComprobantesProveedores_Subcontratos(a.IdComprobanteProveedor).ToString(),
                            NumeroCAI = a.NumeroCAI,
                            NumeroCAE = a.NumeroCAE,
                            ControlAFIP_Resultado = a.ControlAFIP_Resultado,
                            ControlAFIP_Mensaje = a.ControlAFIP_Mensaje,
                            ControlAFIP_Fecha = a.ControlAFIP_Fecha,
                            Confirmado = a.Confirmado,
                            Items = a.DetalleComprobantesProveedores.Distinct().Count(),
                        }).Where(a => a.FechaRecepcion >= FechaDesde && a.FechaRecepcion <= FechaHasta && (a.Confirmado ?? "") != "NO").OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<ComprobantesProveedores2>
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
                            id = a.IdComprobanteProveedor.ToString(),
                            cell = new string[] {
                                "<a href="+ Url.Action("Edit",new {id = a.IdComprobanteProveedor} ) + ">Editar</>",
                                a.IdComprobanteProveedor.ToString(),
                                a.TipoComprobante.NullSafeToString(),
                                a.Letra.NullSafeToString(),
                                a.NumeroComprobante1.NullSafeToString(),
                                a.NumeroComprobante2.NullSafeToString(),
                                a.PuntoVenta.NullSafeToString(),
                                a.NumeroReferencia.NullSafeToString(),
                                a.Tipo.NullSafeToString(),
                                a.FechaComprobante == null ? "" : a.FechaComprobante.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaRecepcion == null ? "" : a.FechaRecepcion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaVencimiento == null ? "" : a.FechaVencimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.ProveedorCodigo.NullSafeToString(),
                                a.Proveedor.NullSafeToString(),
                                a.Cuenta.NullSafeToString(),
                                a.NumeroOrdenPago_Vale.NullSafeToString(),
                                a.CondicionIva.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.CuentaContable.NullSafeToString(),
                                a.TotalBruto.NullSafeToString(),
                                a.NetoGravado.NullSafeToString(),
                                a.TotalIva.NullSafeToString(),
                                a.AjusteIVA.NullSafeToString(),
                                a.TotalBonificacion.NullSafeToString(),
                                a.TotalComprobante.NullSafeToString(),
                                a.Moneda.NullSafeToString(),
                                a.CotizacionDolar.NullSafeToString(),
                                a.ProvinciaDestino.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.Ingreso.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Modifico.NullSafeToString(),
                                a.FechaModifico == null ? "" : a.FechaModifico.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.NumeroRendicionFF.NullSafeToString(),
                                a.Etapa.NullSafeToString(),
                                a.Rubro.NullSafeToString(),
                                a.CircuitoFirmasCompleto.NullSafeToString(),
                                a.Pedidos.NullSafeToString(),
                                a.Recepciones.NullSafeToString(),
                                a.Subcontratos.NullSafeToString(),
                                a.NumeroCAI.NullSafeToString(),
                                a.NumeroCAE.NullSafeToString(),
                                a.ControlAFIP_Resultado.NullSafeToString(),
                                a.ControlAFIP_Mensaje.NullSafeToString(),
                                a.ControlAFIP_Fecha == null ? "" : a.ControlAFIP_Fecha.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Confirmado.NullSafeToString(),
                                a.Items.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult ComprobantesProveedor_DynamicGridDataViejo(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows; // ?? 20;
            int currentPage = page; // ?? 1;

            int totalRecords = 0;
            var Entidad = Filters.FiltroGenerico_UsandoIQueryable<Data.Models.ComprobanteProveedor>
                    (sidx, sord, page, rows, _search, filters, db, ref totalRecords,
                    db.ComprobantesProveedor.Include("DetalleComprobantesProveedores"));

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in Entidad
                        select new jqGridRowJson
                        {
                            id = a.IdComprobanteProveedor.ToString(),
                            cell = new string[] { 
                                                              
                                "<a href="+ Url.Action("EditFF",new {id = a.IdComprobanteProveedor} ) +  " target='' >Editar</>"   +  " | " +
                                //"<a href="+ Url.Action("Edit","Subdiario",new {id =    
                                //                fondoFijoService.Subdiarios.Where(x=>x.IdTipoComprobante==11 && x.IdComprobante==a.IdComprobanteProveedor).Select(x=>x.IdSubdiario).FirstOrDefault()  
                                //                    } )   +  " target='' >Subdiario</>"  +  " | " +
                                
                                #if false 

                                "<a href="+  Url.Content("~/Reporte.aspx?ReportName=Subdiario&idProveedor=" +
                                                fondoFijoService.Subdiarios_Listado().Where(x=>x.IdTipoComprobante==11 && x.IdComprobante==a.IdComprobanteProveedor).Select(x=>x.IdCuentaSubdiario).FirstOrDefault().NullSafeToString()  )
                                                +  " target='' >Subdiario</>"  +  " | " +
                                 #else
                                    "" + 
                                #endif

                                "<a href="+ Url.Content("~/Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&idProveedor=" + ((a.IdProveedorEventual ?? 0)>0 ? a.IdProveedorEventual :  a.IdProveedor))  +  " target='' >CtaCte</>"    +  " | " + 
                                "<a href="+ Url.Action("IncrementarRendicionFF", new {idcuentaFF = a.IdCuenta } ) +  " target='' >Cerrar rendición</>"  ,
                                ///////
                                
                                "<a href="+ Url.Action("EditFF",new {id = a.IdComprobanteProveedor} ) +  " target='' >Editar</>" ,

                                //"<a href="+ Url.Content("~/Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&idProveedor=" + a.IdProveedor +  "&busq=" + a.Letra  +'-' + a.NumeroComprobante1.NullSafeToString().PadLeft(4,'0') + '-'+a.NumeroComprobante1.NullSafeToString().PadLeft(8,'0')  )  +  " target='' >CtaCte</>" ,
                                //"<a href="+ Url.Action("Edit","Asiento",new {id = a.IdComprobanteProveedor}) +  " target='' >Asiento</>" ,
                                
                                
                                "<a href="+ Url.Action("Edit","Subdiario",new {id = a.IdComprobanteProveedor}) +  " target='' >Subdiario</>" ,
                                
                                

                                a.IdComprobanteProveedor.ToString(), 
                  

                                #if false 

                                (fondoFijoService.TiposComprobantesById(a.IdTipoComprobante) ?? new  Data.Models.TiposComprobante()).Descripcion, // as [Tipo comp.],  
                                
                              #else
                                "",
                                #endif

                                a.NumeroReferencia.NullSafeToString() , // as [Nro.interno],  
                                a.Letra  +'-' + a.NumeroComprobante1.NullSafeToString().PadLeft(4,'0') + '-'+a.NumeroComprobante2.NullSafeToString().PadLeft(8,'0') , //  Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+   Convert(varchar,cp.NumeroComprobante1)+'-'+Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),1,20) as [Numero],  
                                 
                                
                                
                                (a.IdProveedor!=null ?    "Cta. cte." : ( a.IdCuenta!=null ? "F.fijo" :    (a.IdCuentaOtros!=null ?  "Otros" :""  ))  )   , 



                                 a.FechaComprobante.GetValueOrDefault().ToString("dd/MM/yyyy"),  //  as [Fecha comp.],   
                                 a.FechaRecepcion.GetValueOrDefault().ToString("dd/MM/yyyy"), //  as [Fecha recep.],  
                                 a.FechaVencimiento.GetValueOrDefault().ToString("dd/MM/yyyy"), // as [Fecha vto.],  
                                                            (a.Proveedore ==null ) ? "" :   a.Proveedore.CodigoEmpresa, //  IsNull(P1.CodigoEmpresa,P2.CodigoEmpresa) as [Cod.Prov.],   

  
      
 
                                (a.Proveedor ==null ) ?  ((a.Cuenta==null) ? "" :   a.Cuenta.Descripcion.NullSafeToString()) :    "<a href="+ Url.Action("Edit","Proveedor",new {id = a.Proveedor.IdProveedor} ) +  " target='' >" + a.Proveedor.RazonSocial + "</>" ,  //  as [Proveedor / Cuenta],   
                                (a.Proveedore ==null ) ?  "" :    "<a href="+ Url.Action("Edit","Proveedor",new {id = a.Proveedore.IdProveedor} ) +  " target='' >" + a.Proveedore.RazonSocial + "</>" ,  //  as [Proveedor / Cuenta],   

                            
                                "", // as [Vale],  

                                #if false 
                                 // ineficientes 
                                                                      (a.DescripcionIva==null) ? "" :   a.DescripcionIva.Descripcion.NullSafeToString(), //  as [Condicion IVA],   

                                                                (a.Obra ==null ) ?  (( fondoFijoService.ObrasById(  (a.DetalleComprobantesProveedores.FirstOrDefault() ?? new DetalleComprobantesProveedore() ).IdObra) ??  new Obra()).NumeroObra  )  :   a.Obra.NumeroObra, // si no está la obra en el encabezado, la tre del primer item, //  as [Obra],  
                              
                                                                (a.Cuenta ==null || true ) ? (( fondoFijoService.CuentasById(  (a.DetalleComprobantesProveedores.FirstOrDefault() ?? new DetalleComprobantesProveedore() ).IdCuenta) ??  new Cuenta()).Descripcion  )  :   a.Cuenta.Descripcion, // si no está la obra en el encabezado, la tre del primer item, //  as [Obra],  

                                #else
                                                                "" , "" ,"",
                                #endif

                                 a.TotalBruto.NullSafeToString(),// as [Subtotal],  
                                 0 .NullSafeToString() , //  [Neto gravado],  
                                 a.TotalIva1.NullSafeToString(), //  as [IVA 1],  
                                 a.TotalIva2.NullSafeToString(), //  as [IVA 2],  
                                 a.AjusteIVA.NullSafeToString(), // as [Aj.IVA],  
                                 a.TotalBonificacion.NullSafeToString(), //  as [Imp.bonif.],  
                                 a.TotalComprobante .NullSafeToString(), // as [Total],  
                                "" , // as [Mon.],  
                                 a.CotizacionDolar .NullSafeToString(), //  as [Cotiz. dolar],  
                                 "" , //  as [Provincia destino],  
                                 a.Observaciones, // ,  

                          
#if false 
                                 a.IdUsuarioIngreso>0 ?    fondoFijoService.EmpleadoById( a.IdUsuarioIngreso).Nombre : "" , //  as [Ingreso],  
                                 a.FechaIngreso==null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy") , // as [Fecha ingreso],  
                           a.IdUsuarioModifico>0 ?    fondoFijoService.EmpleadoById( a.IdUsuarioModifico).Nombre : "", //   as [Modifico],  
                          a.FechaModifico==null ? "" : a.FechaModifico.GetValueOrDefault().ToString("dd/MM/yyyy")    ,  

#else
                                "" , "" ,"","" , 
#endif
                               
                                 a.DestinoPago=="A" ? "ADM" : "OBRA", // as [Dest.Pago],  
                                 a.NumeroRendicionFF.NullSafeToString() , // as [Nro.Rend.FF],  
                                "", // as [Etapa],  
                                "", //  as [Rubro],  
                                 a.CircuitoFirmasCompleto, //  as [Circuito de firmas completo],  
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult ComprobantesProveedor(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = fondoFijoService.ObtenerTodos()
                .Include(x => x.DetalleComprobantesProveedores)
                .Include(x => x.DescripcionIva)
                .Include(x => x.Cuenta)
                .Include(x => x.Proveedor)
                .Include(x => x.Proveedore)
                .Include(x => x.Obra)
                //.Where(x => (x.Confirmado ?? "SI") != "NO") // verificar si lo de "confirmado" solo se debe revisar para fondos fijos
                          .AsQueryable();

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                Entidad = (from a in Entidad where a.FechaRecepcion >= FechaDesde && a.FechaRecepcion <= FechaHasta select a).AsQueryable();
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

            var Entidad1 = (from a in Entidad.Where(campo) select new { IdComprobanteProveedor = a.IdComprobanteProveedor });

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad.Include("Proveedor")
                        select a
                ).Where(campo)
                // .OrderBy((sidx == "Numero" ? "NumeroReferencia" : sidx) + " " + sord)
                .OrderBy("IdComprobanteProveedor desc")
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
                            id = a.IdComprobanteProveedor.ToString(),
                            cell = new string[] { 
                                                              
                                "<a href="+ Url.Action("EditFF",new {id = a.IdComprobanteProveedor} ) +  " target='' >Editar</>"   +  " | " +
                                //"<a href="+ Url.Action("Edit","Subdiario",new {id =    
                                //                fondoFijoService.Subdiarios.Where(x=>x.IdTipoComprobante==11 && x.IdComprobante==a.IdComprobanteProveedor).Select(x=>x.IdSubdiario).FirstOrDefault()  
                                //                    } )   +  " target='' >Subdiario</>"  +  " | " +
                                
                                #if false 

                                "<a href="+  Url.Content("~/Reporte.aspx?ReportName=Subdiario&idProveedor=" +
                                                fondoFijoService.Subdiarios_Listado().Where(x=>x.IdTipoComprobante==11 && x.IdComprobante==a.IdComprobanteProveedor).Select(x=>x.IdCuentaSubdiario).FirstOrDefault().NullSafeToString()  )
                                                +  " target='' >Subdiario</>"  +  " | " +
                                 #else
                                    "" + 
                                #endif

                                "<a href="+ Url.Content("~/Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&idProveedor=" + ((a.IdProveedorEventual ?? 0)>0 ? a.IdProveedorEventual :  a.IdProveedor))  +  " target='' >CtaCte</>"    +  " | " + 
                                "<a href="+ Url.Action("IncrementarRendicionFF", new {idcuentaFF = a.IdCuenta } ) +  " target='' >Cerrar rendición</>"  ,
                                ///////
                                
                                "<a href="+ Url.Action("EditFF",new {id = a.IdComprobanteProveedor} ) +  " target='' >Editar</>" ,

                                //"<a href="+ Url.Content("~/Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&idProveedor=" + a.IdProveedor +  "&busq=" + a.Letra  +'-' + a.NumeroComprobante1.NullSafeToString().PadLeft(4,'0') + '-'+a.NumeroComprobante1.NullSafeToString().PadLeft(8,'0')  )  +  " target='' >CtaCte</>" ,
                                //"<a href="+ Url.Action("Edit","Asiento",new {id = a.IdComprobanteProveedor}) +  " target='' >Asiento</>" ,
                                
                                
                                "<a href="+ Url.Action("Edit","Subdiario",new {id = a.IdComprobanteProveedor}) +  " target='' >Subdiario</>" ,
                                
                                

                                a.IdComprobanteProveedor.ToString(), 
                  

                                #if false 

                                (fondoFijoService.TiposComprobantesById(a.IdTipoComprobante) ?? new  Data.Models.TiposComprobante()).Descripcion, // as [Tipo comp.],  
                                
                              #else
                                "",
                                #endif

                                a.NumeroReferencia.NullSafeToString() , // as [Nro.interno],  
                                a.Letra  +'-' + a.NumeroComprobante1.NullSafeToString().PadLeft(4,'0') + '-'+a.NumeroComprobante2.NullSafeToString().PadLeft(8,'0') , //  Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+   Convert(varchar,cp.NumeroComprobante1)+'-'+Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),1,20) as [Numero],  
                                 
                                
                                
                                (a.IdProveedor!=null ?    "Cta. cte." : ( a.IdCuenta!=null ? "F.fijo" :    (a.IdCuentaOtros!=null ?  "Otros" :""  ))  )   , 



                                 a.FechaComprobante.GetValueOrDefault().ToString("dd/MM/yyyy"),  //  as [Fecha comp.],   
                                 a.FechaRecepcion.GetValueOrDefault().ToString("dd/MM/yyyy"), //  as [Fecha recep.],  
                                 a.FechaVencimiento.GetValueOrDefault().ToString("dd/MM/yyyy"), // as [Fecha vto.],  
                                                            (a.Proveedore ==null ) ? "" :   a.Proveedore.CodigoEmpresa, //  IsNull(P1.CodigoEmpresa,P2.CodigoEmpresa) as [Cod.Prov.],   

  
      
 
                                (a.Proveedor ==null ) ?  ((a.Cuenta==null) ? "" :   a.Cuenta.Descripcion.NullSafeToString()) :    "<a href="+ Url.Action("Edit","Proveedor",new {id = a.Proveedor.IdProveedor} ) +  " target='' >" + a.Proveedor.RazonSocial + "</>" ,  //  as [Proveedor / Cuenta],   
                                (a.Proveedore ==null ) ?  "" :    "<a href="+ Url.Action("Edit","Proveedor",new {id = a.Proveedore.IdProveedor} ) +  " target='' >" + a.Proveedore.RazonSocial + "</>" ,  //  as [Proveedor / Cuenta],   

                            
                                "", // as [Vale],  

                                
#if false 
 // ineficientes 
                                      (a.DescripcionIva==null) ? "" :   a.DescripcionIva.Descripcion.NullSafeToString(), //  as [Condicion IVA],   

                                (a.Obra ==null ) ?  (( fondoFijoService.ObrasById(  (a.DetalleComprobantesProveedores.FirstOrDefault() ?? new DetalleComprobantesProveedore() ).IdObra) ??  new Obra()).NumeroObra  )  :   a.Obra.NumeroObra, // si no está la obra en el encabezado, la tre del primer item, //  as [Obra],  
                              
                                (a.Cuenta ==null || true ) ? (( fondoFijoService.CuentasById(  (a.DetalleComprobantesProveedores.FirstOrDefault() ?? new DetalleComprobantesProveedore() ).IdCuenta) ??  new Cuenta()).Descripcion  )  :   a.Cuenta.Descripcion, // si no está la obra en el encabezado, la tre del primer item, //  as [Obra],  

#else
                                "" , "" ,"",
#endif

                                 a.TotalBruto.NullSafeToString(),// as [Subtotal],  
                                 0 .NullSafeToString() , //  [Neto gravado],  
                                 a.TotalIva1.NullSafeToString(), //  as [IVA 1],  
                                 a.TotalIva2.NullSafeToString(), //  as [IVA 2],  
                                 a.AjusteIVA.NullSafeToString(), // as [Aj.IVA],  
                                 a.TotalBonificacion.NullSafeToString(), //  as [Imp.bonif.],  
                                 a.TotalComprobante .NullSafeToString(), // as [Total],  
                                "" , // as [Mon.],  
                                 a.CotizacionDolar .NullSafeToString(), //  as [Cotiz. dolar],  
                                 "" , //  as [Provincia destino],  
                                 a.Observaciones, // ,  

#if false 
                                 a.IdUsuarioIngreso>0 ?    fondoFijoService.EmpleadoById( a.IdUsuarioIngreso).Nombre : "" , //  as [Ingreso],  
                                 a.FechaIngreso==null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy") , // as [Fecha ingreso],  
                           a.IdUsuarioModifico>0 ?    fondoFijoService.EmpleadoById( a.IdUsuarioModifico).Nombre : "", //   as [Modifico],  
                          a.FechaModifico==null ? "" : a.FechaModifico.GetValueOrDefault().ToString("dd/MM/yyyy")    ,  

#else
                                "" , "" ,"","" , 
#endif


                                 a.DestinoPago=="A" ? "ADM" : "OBRA", // as [Dest.Pago],  
                                 a.NumeroRendicionFF.NullSafeToString() , // as [Nro.Rend.FF],  
                                "", // as [Etapa],  
                                "", //  as [Rubro],  
                                 a.CircuitoFirmasCompleto, //  as [Circuito de firmas completo],  
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        public virtual ActionResult ComprobantesProveedorFF_DynamicGridData
             (string sidx, string sord, int page, int rows, bool _search, string filters,
                                         string FechaInicial, string FechaFinal, string rendicion, string idcuenta)
        {
            string campo = String.Empty;
            int pageSize = rows;  // ?? 20;
            int currentPage = page; // ?? 1;

            var Entidad = db.ComprobantesProveedor.AsQueryable();

            if (idcuenta != string.Empty)
            {
                int idcuentaff = Generales.Val(idcuenta);
                Entidad = (from a in Entidad where a.IdCuenta == idcuentaff select a).AsQueryable();
            }

            var usuario = glbUsuario;

            int ffasociado = usuario.IdCuentaFondoFijo ?? 0;

            if (ffasociado > 0)
            {
                Entidad = (from a in Entidad where a.IdCuenta == ffasociado select a).AsQueryable();
            }

            int obraasociada = usuario.IdObraAsignada ?? 0;
            if (obraasociada > 0)
            {
                Entidad = (from a in Entidad where a.IdObra == obraasociada select a).AsQueryable();
            }

            int totalRecords = 0;
            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<Data.Models.ComprobanteProveedor>
                    (sidx, sord, page, rows, _search, filters, db, ref totalRecords, Entidad);

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new // jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                userdata = new
                {
                    // combinado con la opcion de la jqgrid "userDataOnFooter: true" lo manda al pie
                    neto = Entidad.Sum(x => x.TotalBruto),
                    Total = Entidad.Sum(x => x.TotalComprobante),
                    IVA1 = Entidad.Sum(x => x.TotalIva1),
                    IVA2 = Entidad.Sum(x => x.TotalIva2),
                    Subtotal = Entidad.Sum(x => x.TotalBruto)
                    //TotalBonificacion
                },
                rows = (from a in pagedQuery
                        select new jqGridRowJson
                        {
                            id = a.IdComprobanteProveedor.ToString(),
                            cell = new string[] { 
                                
                                "<a href="+ Url.Action("EditFF",new {id = a.IdComprobanteProveedor} ) +  " target='' >Editar</>"   +  " | " +
                                //"<a href="+ Url.Action("Edit","Subdiario",new {id =    
                                //                fondoFijoService.Subdiarios.Where(x=>x.IdTipoComprobante==11 && x.IdComprobante==a.IdComprobanteProveedor).Select(x=>x.IdSubdiario).FirstOrDefault()  
                                //                    } )   +  " target='' >Subdiario</>"  +  " | " +
//                               "<a href="+  
                                        //Url.Content("~/Reporte.aspx?ReportName=Subdiario&idProveedor="
                                        // + fondoFijoService.Subdiarios.Where(x=>x.IdTipoComprobante==11 && x.IdComprobante==a.IdComprobanteProveedor).Select(x=>x.IdCuentaSubdiario).FirstOrDefault().NullSafeToString()  )
                                 //       +  " target='' >Subdiario</>"  +  " | " +
                                "<a href="+ Url.Content("~/Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&idProveedor=" + ((a.IdProveedorEventual ?? 0)>0 ? a.IdProveedorEventual :  a.IdProveedor))  +  " target='' >CtaCte</>"    +  " | " + 
                                "<a href="+ Url.Action("IncrementarRendicionFF", new {idcuentaFF = a.IdCuenta } ) +  " target='' >Cerrar rendición</>"  ,
                                ///////
                                
                                "<a href="+ Url.Action("EditFF",new {id = a.IdComprobanteProveedor} ) +  " target='' >Editar</>" ,

                                //"<a href="+ Url.Content("~/Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&idProveedor=" + a.IdProveedor +  "&busq=" + a.Letra  +'-' + a.NumeroComprobante1.NullSafeToString().PadLeft(4,'0') + '-'+a.NumeroComprobante1.NullSafeToString().PadLeft(8,'0')  )  +  " target='' >CtaCte</>" ,
                                //"<a href="+ Url.Action("Edit","Asiento",new {id = a.IdComprobanteProveedor}) +  " target='' >Asiento</>" ,
                                
                                
                                "<a href="+ Url.Action("Edit","Subdiario",new {id = a.IdComprobanteProveedor}) +  " target='' >Subdiario</>" ,
                                
                                a.IdComprobanteProveedor.ToString(), 

                                (  db.TiposComprobantes.Find(a.IdTipoComprobante) ?? new  Data.Models.TiposComprobante()).Descripcion, // as [Tipo comp.],  
                                
                                a.NumeroReferencia.NullSafeToString() , // as [Nro.interno],  
                                a.Letra  +'-' + a.NumeroComprobante1.NullSafeToString().PadLeft(4,'0') + '-'+a.NumeroComprobante2.NullSafeToString().PadLeft(8,'0') , //  Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+   Convert(varchar,cp.NumeroComprobante1)+'-'+Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),1,20) as [Numero],  
                                
                                (a.IdProveedor!=null ?    "Cta. cte." : ( a.IdCuenta!=null ? "F.fijo" :    (a.IdCuentaOtros!=null ?  "Otros" :""  ))  )   , 

                                (a.Proveedore ==null ) ?  "" :    "<a href="+ Url.Action("Edit","Proveedor",new {id = a.Proveedore.IdProveedor} ) +  " target='' >" + a.Proveedore.RazonSocial + "</>" ,  //  as [Proveedor / Cuenta],   


                                 a.TotalBruto.NullSafeToString().Replace(",",".") ,// as [Subtotal],  
                                 0 .NullSafeToString().Replace(",",".") , //  [Neto gravado],  
                                 a.TotalIva1.NullSafeToString().Replace(",","."), //  as [IVA 1],  
                                 a.TotalIva2.NullSafeToString().Replace(",","."), //  as [IVA 2],  
                                 a.AjusteIVA.NullSafeToString().Replace(",","."), // as [Aj.IVA],  
                                 a.TotalBonificacion.NullSafeToString().Replace(",","."), //  as [Imp.bonif.],  
                                 a.TotalComprobante .NullSafeToString().Replace(",","."), // as [Total],  


                                 a.FechaComprobante.GetValueOrDefault().ToString("dd/MM/yyyy"),  //  as [Fecha comp.],   
                                 a.FechaRecepcion.GetValueOrDefault().ToString("dd/MM/yyyy"), //  as [Fecha recep.],  
                                 a.FechaVencimiento.GetValueOrDefault().ToString("dd/MM/yyyy"), // as [Fecha vto.],  
                                                            (a.Proveedore ==null ) ? "" :   a.Proveedore.CodigoEmpresa, //  IsNull(P1.CodigoEmpresa,P2.CodigoEmpresa) as [Cod.Prov.],   
 
                                (a.Proveedor ==null ) ?  ((a.Cuenta==null) ? "" :   a.Cuenta.Descripcion.NullSafeToString()) :    "<a href="+ Url.Action("Edit","Proveedor",new {id = a.Proveedor.IdProveedor} ) +  " target='' >" + a.Proveedor.RazonSocial + "</>" ,  //  as [Proveedor / Cuenta],   

                                "", // as [Vale],  
                               (a.DescripcionIva==null) ? "" :   a.DescripcionIva.Descripcion.NullSafeToString(), //  as [Condicion IVA],   

                                (a.Obra ==null ) ?  (( db.Obras.Find(  (a.DetalleComprobantesProveedores.FirstOrDefault() ?? new DetalleComprobantesProveedore() ).IdObra) ??  new Obra()).NumeroObra  )  :   a.Obra.NumeroObra, // si no está la obra en el encabezado, la tre del primer item, //  as [Obra],  

                                
                                (a.Cuenta ==null || true ) ? (( db.Cuentas.Find(  (a.DetalleComprobantesProveedores.FirstOrDefault() ?? new DetalleComprobantesProveedore() ).IdCuenta) ??  new Cuenta()).Descripcion  )  :   a.Cuenta.Descripcion, // si no está la obra en el encabezado, la tre del primer item, //  as [Obra],  

                                "" , // as [Mon.],  
                                 a.CotizacionDolar .NullSafeToString(), //  as [Cotiz. dolar],  
                                 "" , //  as [Provincia destino],  
                                 a.Observaciones, // ,  
                           a.IdUsuarioIngreso>0 ?    db.Empleados.Find( a.IdUsuarioIngreso).Nombre : "" , //  as [Ingreso],  
                                 a.FechaIngreso==null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy") , // as [Fecha ingreso],  
                           a.IdUsuarioModifico>0 ?    db.Empleados.Find( a.IdUsuarioModifico).Nombre : "", //   as [Modifico],  
                          a.FechaModifico==null ? "" : a.FechaModifico.GetValueOrDefault().ToString("dd/MM/yyyy")    ,  
                                 a.DestinoPago=="A" ? "ADM" : "OBRA", // as [Dest.Pago],  
                                 a.NumeroRendicionFF.NullSafeToString() , // as [Nro.Rend.FF],  
                                "", // as [Etapa],  
                                "", //  as [Rubro],  
                                 a.CircuitoFirmasCompleto //  as [Circuito de firmas completo],  

                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult ComprobantesProveedorFF(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString,
                                            string FechaInicial, string FechaFinal, string rendicion, string idcuenta)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //if (sidx == "Numero") sidx = "NumeroComprobanteProveedor"; // como estoy haciendo "select a" (el renglon entero) en la linq antes de llamar jqGridJson, no pude ponerle el nombre explicito
            //if (searchField == "Numero") searchField = "NumeroComprobanteProveedor"; 


            var Entidad1 = fondoFijoService.ObtenerTodos(sidx, sord, page, rows, _search, searchField, searchOper, searchString,
                                            FechaInicial, FechaFinal, rendicion, idcuenta);

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = Entidad1;

            if (false)
            {

                var Entidad = fondoFijoService.ObtenerTodos()
                    // .Include(x => x.DetalleComprobantesProveedores.Select(y => y.Unidad))
                    // .Include(x => x.DetalleComprobantesProveedores.Select(y => y.Moneda))
                    //.Include(x => x.DetalleComprobantesProveedores. .moneda)
                    //   .Include("DetalleComprobantesProveedores.Unidad") // funciona tambien
                    // .Include(x => x.Moneda)
                    //.Include(x => x.Proveedor)
                    //  .Include("DetalleComprobantesProveedores.IdDetalleRequerimiento") // funciona tambien
                    //.Include(x => x.DetalleComprobantesProveedores.Select(y => y. y.IdDetalleRequerimiento))
                    // .Include(x => x.Aprobo)
                    //.Include(x => x.Comprador)
                    .Include(x => x.DetalleComprobantesProveedores)
                    .Include(x => x.DescripcionIva)
                    .Include(x => x.Cuenta)
                    .Include(x => x.Proveedor)
                    .Include(x => x.Proveedore)
                    .Include(x => x.Obra)
                        .Where(x => x.IdCuenta != null)
                              .AsQueryable();


                if (FechaInicial != string.Empty)
                {
                    DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                    DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                    Entidad = (from a in Entidad where a.FechaComprobante >= FechaDesde && a.FechaComprobante <= FechaHasta select a).AsQueryable();
                }
                if (rendicion != string.Empty)
                {
                    int rend = Generales.Val(rendicion);
                    Entidad = (from a in Entidad where a.NumeroRendicionFF == rend select a).AsQueryable();
                }



                if (idcuenta != string.Empty)
                {
                    int idcuentaff = Generales.Val(idcuenta);
                    Entidad = (from a in Entidad where a.IdCuenta == idcuentaff select a).AsQueryable();
                }

                var usuario = glbUsuario;

                int ffasociado = usuario.IdCuentaFondoFijo ?? 0;

                if (ffasociado > 0)
                {
                    Entidad = (from a in Entidad where a.IdCuenta == ffasociado select a).AsQueryable();
                }

                int obraasociada = usuario.IdObraAsignada ?? 0;
                if (obraasociada > 0)
                {
                    Entidad = (from a in Entidad where a.IdObra == obraasociada select a).AsQueryable();
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

                            campo = String.Format("Proveedor.RazonSocial.Contains(\"{0}\") OR NumeroReferencia = {1} ", searchString, Generales.Val(searchString));

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

                var Entidad3 = (from a in Entidad.Where(campo) select a);

                totalRecords = Entidad3.Count();
                totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

                data = (from a in Entidad.Include("Proveedor")
                        select a


                    ).Where(campo)
                    // .OrderBy((sidx == "Numero" ? "NumeroReferencia" : sidx) + " " + sord)
                    .OrderBy("IdComprobanteProveedor desc")
                    .Skip((currentPage - 1) * pageSize).Take(pageSize)
                    .ToList();
            }

            var jsonData = new // jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                userdata = new
                {
                    // combinado con la opcion de la jqgrid "userDataOnFooter: true" lo manda al pie
                    neto = Entidad1.Sum(x => x.TotalBruto),
                    Total = Entidad1.Sum(x => x.TotalComprobante),
                    IVA1 = Entidad1.Sum(x => x.TotalIva1),
                    IVA2 = Entidad1.Sum(x => x.TotalIva2),
                    Subtotal = Entidad1.Sum(x => x.TotalBruto)
                    //TotalBonificacion
                },
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdComprobanteProveedor.ToString(),
                            cell = new string[] { 
                                
                                "<a href="+ Url.Action("EditFF",new {id = a.IdComprobanteProveedor} ) +  " target='' >Editar</>"   +  " | " +
                                //"<a href="+ Url.Action("Edit","Subdiario",new {id =    
                                //                fondoFijoService.Subdiarios.Where(x=>x.IdTipoComprobante==11 && x.IdComprobante==a.IdComprobanteProveedor).Select(x=>x.IdSubdiario).FirstOrDefault()  
                                //                    } )   +  " target='' >Subdiario</>"  +  " | " +
//                               "<a href="+  
                                        //Url.Content("~/Reporte.aspx?ReportName=Subdiario&idProveedor="
                                        // + fondoFijoService.Subdiarios.Where(x=>x.IdTipoComprobante==11 && x.IdComprobante==a.IdComprobanteProveedor).Select(x=>x.IdCuentaSubdiario).FirstOrDefault().NullSafeToString()  )
                                 //       +  " target='' >Subdiario</>"  +  " | " +
                                "<a href="+ Url.Content("~/Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&idProveedor=" + ((a.IdProveedorEventual ?? 0)>0 ? a.IdProveedorEventual :  a.IdProveedor))  +  " target='' >CtaCte</>"    +  " | " + 
                                "<a href="+ Url.Action("IncrementarRendicionFF", new {idcuentaFF = a.IdCuenta } ) +  " target='' >Cerrar rendición</>"  ,
                                ///////
                                
                                "<a href="+ Url.Action("EditFF",new {id = a.IdComprobanteProveedor} ) +  " target='' >Editar</>" ,

                                //"<a href="+ Url.Content("~/Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&idProveedor=" + a.IdProveedor +  "&busq=" + a.Letra  +'-' + a.NumeroComprobante1.NullSafeToString().PadLeft(4,'0') + '-'+a.NumeroComprobante1.NullSafeToString().PadLeft(8,'0')  )  +  " target='' >CtaCte</>" ,
                                //"<a href="+ Url.Action("Edit","Asiento",new {id = a.IdComprobanteProveedor}) +  " target='' >Asiento</>" ,
                                
                                
                                "<a href="+ Url.Action("Edit","Subdiario",new {id = a.IdComprobanteProveedor}) +  " target='' >Subdiario</>" ,
                                
                                

                                a.IdComprobanteProveedor.ToString(), 
                  

                                (fondoFijoService.TiposComprobantesById(a.IdTipoComprobante) ?? new  Data.Models.TiposComprobante()).Descripcion, // as [Tipo comp.],  
                                
                              
                                a.NumeroReferencia.NullSafeToString() , // as [Nro.interno],  
                                a.Letra  +'-' + a.NumeroComprobante1.NullSafeToString().PadLeft(4,'0') + '-'+a.NumeroComprobante2.NullSafeToString().PadLeft(8,'0') , //  Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+   Convert(varchar,cp.NumeroComprobante1)+'-'+Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),1,20) as [Numero],  
                                 
                                
                                
                                (a.IdProveedor!=null ?    "Cta. cte." : ( a.IdCuenta!=null ? "F.fijo" :    (a.IdCuentaOtros!=null ?  "Otros" :""  ))  )   , 


                                (a.Proveedore ==null ) ?  "" :    "<a href="+ Url.Action("Edit","Proveedor",new {id = a.Proveedore.IdProveedor} ) +  " target='' >" + a.Proveedore.RazonSocial + "</>" ,  //  as [Proveedor / Cuenta],   


                                 a.TotalBruto.NullSafeToString().Replace(",",".") ,// as [Subtotal],  
                                 0 .NullSafeToString().Replace(",",".") , //  [Neto gravado],  
                                 a.TotalIva1.NullSafeToString().Replace(",","."), //  as [IVA 1],  
                                 a.TotalIva2.NullSafeToString().Replace(",","."), //  as [IVA 2],  
                                 a.AjusteIVA.NullSafeToString().Replace(",","."), // as [Aj.IVA],  
                                 a.TotalBonificacion.NullSafeToString().Replace(",","."), //  as [Imp.bonif.],  
                                 a.TotalComprobante .NullSafeToString().Replace(",","."), // as [Total],  


                                 a.FechaComprobante.GetValueOrDefault().ToString("dd/MM/yyyy"),  //  as [Fecha comp.],   
                                 a.FechaRecepcion.GetValueOrDefault().ToString("dd/MM/yyyy"), //  as [Fecha recep.],  
                                 a.FechaVencimiento.GetValueOrDefault().ToString("dd/MM/yyyy"), // as [Fecha vto.],  
                                                            (a.Proveedore ==null ) ? "" :   a.Proveedore.CodigoEmpresa, //  IsNull(P1.CodigoEmpresa,P2.CodigoEmpresa) as [Cod.Prov.],   

  
      
 
                                (a.Proveedor ==null ) ?  ((a.Cuenta==null) ? "" :   a.Cuenta.Descripcion.NullSafeToString()) :    "<a href="+ Url.Action("Edit","Proveedor",new {id = a.Proveedor.IdProveedor} ) +  " target='' >" + a.Proveedor.RazonSocial + "</>" ,  //  as [Proveedor / Cuenta],   

                            
                                      



                                "", // as [Vale],  
                               (a.DescripcionIva==null) ? "" :   a.DescripcionIva.Descripcion.NullSafeToString(), //  as [Condicion IVA],   

                                (a.Obra ==null ) ?  (( fondoFijoService.ObrasById(  (a.DetalleComprobantesProveedores.FirstOrDefault() ?? new DetalleComprobantesProveedore() ).IdObra) ??  new Obra()).NumeroObra  )  :   a.Obra.NumeroObra, // si no está la obra en el encabezado, la tre del primer item, //  as [Obra],  

                                
                                (a.Cuenta ==null || true ) ? (( fondoFijoService.CuentasById(  (a.DetalleComprobantesProveedores.FirstOrDefault() ?? new DetalleComprobantesProveedore() ).IdCuenta) ??  new Cuenta()).Descripcion  )  :   a.Cuenta.Descripcion, // si no está la obra en el encabezado, la tre del primer item, //  as [Obra],  

                        


                                "" , // as [Mon.],  
                                 a.CotizacionDolar .NullSafeToString(), //  as [Cotiz. dolar],  
                                 "" , //  as [Provincia destino],  
                                 a.Observaciones, // ,  
                           a.IdUsuarioIngreso>0 ?    fondoFijoService.EmpleadoById( a.IdUsuarioIngreso).Nombre : "" , //  as [Ingreso],  
                                 a.FechaIngreso==null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy") , // as [Fecha ingreso],  
                           a.IdUsuarioModifico>0 ?    fondoFijoService.EmpleadoById( a.IdUsuarioModifico).Nombre : "", //   as [Modifico],  
                          a.FechaModifico==null ? "" : a.FechaModifico.GetValueOrDefault().ToString("dd/MM/yyyy")    ,  
                                 a.DestinoPago=="A" ? "ADM" : "OBRA", // as [Dest.Pago],  
                                 a.NumeroRendicionFF.NullSafeToString() , // as [Nro.Rend.FF],  
                                "", // as [Etapa],  
                                "", //  as [Rubro],  
                                 a.CircuitoFirmasCompleto //  as [Circuito de firmas completo],  

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

        public virtual ActionResult ComprobanteProveedorsExterno(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = fondoFijoService.ObtenerTodos().AsQueryable();


            int idproveedor = fondoFijoService.buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));

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

            var Entidad1 = (from a in Entidad select new { IdComprobanteProveedor = a.IdComprobanteProveedor }).Where(campo);

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdComprobanteProveedor = a.IdComprobanteProveedor,
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
                            id = a.IdComprobanteProveedor.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("EditExterno",new {id = a.IdComprobanteProveedor} ) + " target='' >Editar</>" 
								 +"|"+"<a href=../ComprobanteProveedor/EditExterno/" + a.IdComprobanteProveedor + "?code=1" + ">Detalles</a> ",
                                a.IdComprobanteProveedor.ToString(), 
                                a.Observaciones
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetComprobantesProveedor(string sidx, string sord, int? page, int? rows, int? IdComprobanteProveedor)
        {
            int IdComprobanteProveedor1 = IdComprobanteProveedor ?? 0;
            var Det = db.DetalleComprobantesProveedores.Where(p => p.IdComprobanteProveedor == IdComprobanteProveedor1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Articulos.Where(o => o.IdArticulo == a.IdArticulo).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleComprobanteProveedor,
                            a.IdCuenta,
                            a.IdObra,
                            a.IdCuentaGasto,
                            a.IdCuentaBancaria,
                            a.IdRubroContable,
                            a.IdEquipoDestino,
                            a.IdArticulo,
                            CodigoCuenta = a.Cuenta.Codigo,
                            CuentaContable = a.Cuenta.Descripcion,
                            CodigoArticulo = (b != null ? " " + b.Codigo : ""),
                            Articulo = (b != null ? " " + b.Descripcion : ""),
                            a.Cantidad,
                            Importe = Math.Round((double)a.Importe, 2),
                            PorcentajeIva = ((a.AplicarIVA1 ?? "NO") == "SI") ? (a.IVAComprasPorcentaje1 ?? 0) : (((a.AplicarIVA2 ?? "NO") == "SI") ? (a.IVAComprasPorcentaje2 ?? 0) : (((a.AplicarIVA3 ?? "NO") == "SI") ? (a.IVAComprasPorcentaje3 ?? 0) : (((a.AplicarIVA4 ?? "NO") == "SI") ? (a.IVAComprasPorcentaje4 ?? 0) : (((a.AplicarIVA5 ?? "NO") == "SI") ? (a.IVAComprasPorcentaje5 ?? 0) : (((a.AplicarIVA6 ?? "NO") == "SI") ? (a.IVAComprasPorcentaje6 ?? 0) : (((a.AplicarIVA7 ?? "NO") == "SI") ? (a.IVAComprasPorcentaje7 ?? 0) : (((a.AplicarIVA8 ?? "NO") == "SI") ? (a.IVAComprasPorcentaje8 ?? 0) : (((a.AplicarIVA9 ?? "NO") == "SI") ? (a.IVAComprasPorcentaje9 ?? 0) : (((a.AplicarIVA10 ?? "NO") == "SI") ? (a.IVAComprasPorcentaje10 ?? 0) : 0))))))))),
                            ImporteIva = ((a.AplicarIVA1 ?? "NO") == "SI") ? (a.ImporteIVA1 ?? 0) : (((a.AplicarIVA2 ?? "NO") == "SI") ? (a.ImporteIVA2 ?? 0) : (((a.AplicarIVA3 ?? "NO") == "SI") ? (a.ImporteIVA3 ?? 0) : (((a.AplicarIVA4 ?? "NO") == "SI") ? (a.ImporteIVA4 ?? 0) : (((a.AplicarIVA5 ?? "NO") == "SI") ? (a.ImporteIVA5 ?? 0) : (((a.AplicarIVA6 ?? "NO") == "SI") ? (a.ImporteIVA6 ?? 0) : (((a.AplicarIVA7 ?? "NO") == "SI") ? (a.ImporteIVA7 ?? 0) : (((a.AplicarIVA8 ?? "NO") == "SI") ? (a.ImporteIVA8 ?? 0) : (((a.AplicarIVA9 ?? "NO") == "SI") ? (a.ImporteIVA9 ?? 0) : (((a.AplicarIVA10 ?? "NO") == "SI") ? (a.ImporteIVA10 ?? 0) : 0))))))))),
                            a.TomarEnCalculoDeImpuestos,
                            a.IdProvinciaDestino1,
                            a.PorcentajeProvinciaDestino1,
                            a.IdProvinciaDestino2,
                            a.PorcentajeProvinciaDestino2
                        }).OrderBy(x => x.IdDetalleComprobanteProveedor)
                        .ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleComprobanteProveedor.ToString(),
                            cell = new string[] {
                            string.Empty,
                            a.IdDetalleComprobanteProveedor.ToString(),
                            a.IdCuenta.NullSafeToString(),
                            a.IdObra.NullSafeToString(),
                            a.IdCuentaGasto.NullSafeToString(),
                            a.IdCuentaBancaria.NullSafeToString(),
                            a.IdRubroContable.NullSafeToString(),
                            a.IdEquipoDestino.NullSafeToString(),
                            a.IdArticulo.NullSafeToString(),
                            a.CodigoCuenta.NullSafeToString(),
                            a.CuentaContable.NullSafeToString(),
                            a.CodigoArticulo.NullSafeToString(),
                            a.Articulo.NullSafeToString(),
                            a.Cantidad.NullSafeToString(),
                            a.Importe.NullSafeToString(),
                            a.PorcentajeIva.NullSafeToString(),
                            a.ImporteIva.NullSafeToString(),
                            a.TomarEnCalculoDeImpuestos.NullSafeToString(),
                            a.IdProvinciaDestino1.NullSafeToString(),
                            a.PorcentajeProvinciaDestino1.NullSafeToString(),
                            a.IdProvinciaDestino2.NullSafeToString(),
                            a.PorcentajeProvinciaDestino2.NullSafeToString(),
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetComprobantesProveedorViejo(string sidx, string sord, int? page, int? rows, int? IdComprobanteProveedor)
        {
            int IdComprobanteProveedor1 = IdComprobanteProveedor ?? 0;
            var DetEntidad = fondoFijoService.ObtenerTodosDetalle().Include("Cuenta").Where(p => p.IdComprobanteProveedor == IdComprobanteProveedor1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetEntidad
                        select a)
               .OrderBy(p => p.Item)
                //.Skip((currentPage - 1) * pageSize).Take(pageSize)
                .ToList();

            Parametros parametros = fondoFijoService.Parametros();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleComprobanteProveedor.ToString(),
                            cell = new string[] { 
                                string.Empty, 
                                a.IdDetalleComprobanteProveedor.ToString(), 
                                a.IdCuenta.NullSafeToString(), 
                                "0", // a.IdUnidad.ToString(),
                                a.Item.NullSafeToString() , // a.NumeroItem.ToString(), 
                                "", //obra
                                a.Cantidad.NullSafeToString(),
                                 "", // a.Cuenta..Abreviatura.NullSafeToString(),
                                (a.Cuenta==null) ? "" :   a.Cuenta.Codigo.NullSafeToString(),
                                "", // descripcionfalsa
                                (a.Cuenta==null) ? "" : a.Cuenta.Descripcion.NullSafeToString(),
                                a.Importe.NullSafeToString(),


                                ((a.IdDetalleComprobanteProveedor==-1 ?  false : a.AplicarIVA1!="SI" ) ) ? "false" : "true", // tambien podría usa AplicarIVA1
                                (parametros.IdCuentaIvaCompras1==null) ? "" : fondoFijoService.CuentasById(parametros.IdCuentaIvaCompras1 ).Descripcion,
                                (a.IdCuentaIvaCompras1 ?? parametros.IdCuentaIvaCompras1).NullSafeToString(),
                                (a.IVAComprasPorcentaje1 ?? parametros.IVAComprasPorcentaje1).NullSafeToString(),
                 
                               ((a.IdDetalleComprobanteProveedor==-1 ?  false : a.AplicarIVA2!="SI" ) ) ? "false" : "true", // tambien podría usa AplicarIVA1
                                (parametros.IdCuentaIvaCompras2==null) ? "" : fondoFijoService.CuentasById(parametros.IdCuentaIvaCompras2 ).Descripcion,
                                (a.IdCuentaIvaCompras2 ?? parametros.IdCuentaIvaCompras2).NullSafeToString(),
                                (a.IVAComprasPorcentaje2 ?? parametros.IVAComprasPorcentaje2).NullSafeToString(),
                 
                                    ((a.IdDetalleComprobanteProveedor==-1 ?  false : a.AplicarIVA3!="SI" ) ) ? "false" : "true", // tambien podría usa AplicarIVA1
                                (parametros.IdCuentaIvaCompras3==null) ? "" : fondoFijoService.CuentasById(parametros.IdCuentaIvaCompras3 ).Descripcion,
                                (a.IdCuentaIvaCompras3 ?? parametros.IdCuentaIvaCompras3).NullSafeToString(),
                                (a.IVAComprasPorcentaje3 ?? parametros.IVAComprasPorcentaje3).NullSafeToString(),
                 
                                 ((a.IdDetalleComprobanteProveedor==-1 ?  false : a.AplicarIVA4!="SI" ) ) ? "false" : "true", // tambien podría usa AplicarIVA1
                                (parametros.IdCuentaIvaCompras4==null) ? "" : fondoFijoService.CuentasById(parametros.IdCuentaIvaCompras4 ).Descripcion,
                                (a.IdCuentaIvaCompras4 ?? parametros.IdCuentaIvaCompras4).NullSafeToString(),
                                (a.IVAComprasPorcentaje4 ?? parametros.IVAComprasPorcentaje4).NullSafeToString(),
                 
                              ((a.IdDetalleComprobanteProveedor==-1 ?  false : a.AplicarIVA5!="SI" ) ) ? "false" : "true", // tambien podría usa AplicarIVA1
                                (parametros.IdCuentaIvaCompras5==null) ? "" : fondoFijoService.CuentasById(parametros.IdCuentaIvaCompras5 ).Descripcion,
                                (a.IdCuentaIvaCompras5 ?? parametros.IdCuentaIvaCompras5).NullSafeToString(),
                                (a.IVAComprasPorcentaje5 ?? parametros.IVAComprasPorcentaje5).NullSafeToString(),
                 
                                 ((a.IdDetalleComprobanteProveedor==-1 ?  false : a.AplicarIVA6!="SI" ) ) ? "false" : "true", // tambien podría usa AplicarIVA1
                                (parametros.IdCuentaIvaCompras6==null) ? "" : fondoFijoService.CuentasById(parametros.IdCuentaIvaCompras6 ).Descripcion,
                                (a.IdCuentaIvaCompras6 ?? parametros.IdCuentaIvaCompras6).NullSafeToString(),
                                (a.IVAComprasPorcentaje6 ?? parametros.IVAComprasPorcentaje6).NullSafeToString(),
                 
                                  ((a.IdDetalleComprobanteProveedor==-1 ?  false : a.AplicarIVA7!="SI" ) ) ? "false" : "true", // tambien podría usa AplicarIVA1
                                (parametros.IdCuentaIvaCompras7==null) ? "" : fondoFijoService.CuentasById(parametros.IdCuentaIvaCompras7 ).Descripcion,
                                (a.IdCuentaIvaCompras7 ?? parametros.IdCuentaIvaCompras7).NullSafeToString(),
                                (a.IVAComprasPorcentaje7 ?? parametros.IVAComprasPorcentaje7).NullSafeToString(),
                 
                                   ((a.IdDetalleComprobanteProveedor==-1 ?  false : a.AplicarIVA8!="SI" ) ) ? "false" : "true", // tambien podría usa AplicarIVA1
                                (parametros.IdCuentaIvaCompras8==null) ? "" : fondoFijoService.CuentasById(parametros.IdCuentaIvaCompras8 ).Descripcion,
                                (a.IdCuentaIvaCompras8 ?? parametros.IdCuentaIvaCompras8).NullSafeToString(),
                                (a.IVAComprasPorcentaje8 ?? parametros.IVAComprasPorcentaje8).NullSafeToString(),
                 
                                  ((a.IdDetalleComprobanteProveedor==-1 ?  false : a.AplicarIVA9!="SI" ) ) ? "false" : "true", // tambien podría usa AplicarIVA1
                                (parametros.IdCuentaIvaCompras9==null) ? "" : fondoFijoService.CuentasById(parametros.IdCuentaIvaCompras9 ).Descripcion,
                                (a.IdCuentaIvaCompras9 ?? parametros.IdCuentaIvaCompras9).NullSafeToString(),
                                (a.IVAComprasPorcentaje9 ?? parametros.IVAComprasPorcentaje9).NullSafeToString(),

                                 ((a.IdDetalleComprobanteProveedor==-1 ?  false : a.AplicarIVA10!="SI" ) ) ? "false" : "true", // tambien podría usa AplicarIVA1
                                (parametros.IdCuentaIvaCompras10==null) ? "" : fondoFijoService.CuentasById(parametros.IdCuentaIvaCompras10 ).Descripcion,
                                (a.IdCuentaIvaCompras10 ?? parametros.IdCuentaIvaCompras10).NullSafeToString(),
                                (a.IVAComprasPorcentaje10 ?? parametros.IVAComprasPorcentaje10).NullSafeToString(),


                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetComprobantesProveedorFF(string sidx, string sord, int? page, int? rows, int? IdComprobanteProveedor)
        {
            int IdComprobanteProveedor1 = IdComprobanteProveedor ?? 0;
            var DetEntidad = db.DetalleComprobantesProveedores.Where(p => p.IdComprobanteProveedor == IdComprobanteProveedor1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetEntidad
                        select
                      a)
               .OrderBy(p => p.Item)
                //.Skip((currentPage - 1) * pageSize).Take(pageSize)
                .ToList();

            Parametros parametros = fondoFijoService.Parametros();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleComprobanteProveedor.ToString(),
                            cell = new string[] { 
                                string.Empty, 
                                a.IdDetalleComprobanteProveedor.ToString(), 
                                a.IdCuenta.NullSafeToString(), 
                                "0", // a.IdUnidad.ToString(),
                                a.Item.NullSafeToString() , // a.NumeroItem.ToString(), 
                                "", //obra
                                a.Cantidad.NullSafeToString(),
                                 "", // a.Cuenta..Abreviatura.NullSafeToString(),
                                (a.Cuenta==null) ? "" :   a.Cuenta.Codigo.NullSafeToString(),
                                "", // descripcionfalsa
                                (a.Cuenta==null) ? "" : a.Cuenta.Descripcion.NullSafeToString(),
                                (a.Cuenta==null) ? "" : a.Cuenta.Descripcion.NullSafeToString(), // IdCuentaGasto apunta a Cuentas o a CuentasGasto?
                                a.Importe.NullSafeToString(),
                                "0", 
                                "0"  ,  // a.ImporteBonificacion.ToString(), 
                                a.IVAComprasPorcentaje1.ToString(), 
                                a.ImporteIVA1.ToString(), 
                                (a.Importe + a.ImporteIVA1).ToString(), 
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult DetComprobanteProveedorsSinFormato(int IdComprobanteProveedor)
        {
            var Det = fondoFijoService.ObtenerTodosDetalle().Where(p => p.IdComprobanteProveedor == IdComprobanteProveedor).AsQueryable();

            var data = (from a in Det
                        select new
                        {
                            a.IdDetalleComprobanteProveedor,
                            a.IdArticulo,
                        })
                        .ToList();
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

        public virtual ActionResult Anular(int id) //(int id)
        {
            ComprobanteProveedor o = fondoFijoService.ObtenerTodos()
                //.Include(x => x.DetalleComprobantesProveedores)
                // .Include(x => x.Proveedor)
                  .SingleOrDefault(x => x.IdComprobanteProveedor == id);
            db.SaveChanges();

            return RedirectToAction("Index");
        }

        public virtual ViewResult ActivarUsuarioYContacto(int idComprobanteProveedor)
        {

            var ComprobanteProveedor = fondoFijoService.ObtenerTodos().Where(x => x.IdComprobanteProveedor == idComprobanteProveedor).FirstOrDefault();
            var Proveedor = fondoFijoService.ProveedoresById(ComprobanteProveedor.IdProveedor);

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
            catch (Exception)
            {

                //throw;
            }

            try
            {
                Roles.AddUserToRole(usuarioNuevo.UserName, "AdminExterno");
            }
            catch (Exception)
            {

                //throw;
            }
            try
            {
                Roles.AddUserToRole(usuarioNuevo.UserName, "Externo");
            }
            catch (Exception)
            {

                //throw;
            }
            try
            {
                Roles.AddUserToRole(usuarioNuevo.UserName, "ExternoCuentaCorrienteProveedor");
            }
            catch (Exception)
            {

                //throw;
            }

            try
            {
                Roles.AddUserToRole(usuarioNuevo.UserName, "ExternoOrdenesPagoListas");
            }
            catch (Exception)
            {

                //throw;
            }
            // tendria que usar createuser y ahi tendria que mandar en el mail la contraseña...

            var usuarioNuevo2 = new RegisterModel();
            try
            {
                Roles.AddUserToRole(usuarioNuevo2.UserName, "Externo");
            }
            catch (Exception)
            {

                //throw;
            }
            try
            {
                Roles.AddUserToRole(usuarioNuevo2.UserName, "ExternoCuentaCorrienteProveedor");
            }
            catch (Exception)
            {

                //throw;
            }

            try
            {
                Roles.AddUserToRole(usuarioNuevo2.UserName, "ExternoOrdenesPagoListas");
            }
            catch (Exception)
            {

                //throw;
            }

            TempData["Alerta"] = "Alta automática de usuarios: " + usuarioNuevo.UserName + " " + usuarioNuevo2.UserName;
            return View("Index");
        }

        public string BuscarOrden(int Numero)
        {
            var ComprobantesProveedores = fondoFijoService.ObtenerTodos()
                //.Where(x => x.Numero == Numero)
                        .AsQueryable();
            var data = (from x in ComprobantesProveedores select new { x.NumeroComprobante2 }).OrderByDescending(p => p.NumeroComprobante2).FirstOrDefault();
            if (data != null)
                return data.NumeroComprobante2.ToString();
            else
                return "1";
        }

        protected override void Dispose(bool disposing)
        {
            //if (db != null) fondoFijoService.Dispose();
            //base.Dispose(disposing);
        }

        private static DataTable makeDataTableFromSheetName(string filename, string sheetName)
        {

            System.Data.OleDb.OleDbConnection myConnection = new System.Data.OleDb.OleDbConnection(
                            "Provider=Microsoft.ACE.OLEfondoFijoService.12.0; " +
                             "data source='" + filename + "';" +
                                "Extended Properties=\"Excel 12.0;HDR=YES;IMEX=1\" ");


            DataTable dtImport = new DataTable();
            //System.Data.OlefondoFijoService.OleDbDataAdapter myImportCommand = new System.Data.OlefondoFijoService.OleDbDataAdapter("select * from [" + sheetName + "$]", myConnection);
            System.Data.OleDb.OleDbDataAdapter myImportCommand = new System.Data.OleDb.OleDbDataAdapter("select * from [" + sheetName + "]", myConnection);
            myImportCommand.Fill(dtImport);
            return dtImport;
        }

        [HttpPost]
        public virtual ActionResult Importar(System.Web.HttpPostedFileBase file)
        {
            string SC;
            string nombre;
            string path;

            if (file != null)
            {
                // Verify that the user selected a file
                if (file == null || file.ContentLength == 0)
                {
                    return View();
                }

                // extract only the fielname
                nombre = System.IO.Path.GetFileName(file.FileName);
                // store the file inside ~/App_Data/uploads folder
                SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
                path = System.IO.Path.Combine(Server.MapPath("~/App_Data"), nombre); // "~/App_Data/uploads"
                file.SaveAs(path);
            }
            else
            {
                nombre = "F.F.- Omar Breton.xls";
                SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL("Autotrol", oStaticMembershipService));
                path = System.IO.Path.Combine(Server.MapPath("~/App_Data"), nombre); // "~/App_Data/uploads"
            }

            TempData["Alerta"] = ImportarExcel(path, SC);
            return View("Index");
        }

        public virtual ActionResult Test()
        {
            string nombre = "F.F.- Omar Breton.xls";
            // SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL("Autotrol"));
            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            string path = System.IO.Path.Combine(Server.MapPath("~/App_Data"), nombre); // "~/App_Data/uploads"
            ImportarExcel(path, SC);

            TempData["Alerta"] = ImportarExcel(path, SC);
            return View("Index");
        }

        int DarloDeAltaComoEventual(string sRazonSocial, string sCuit)
        {
            var p = new Proveedor();
            p.Cuit = sCuit;
            p.RazonSocial = sRazonSocial;
            p.Eventual = "SI";
            //fondoFijoService.Proveedores.Add(p);
            //fondoFijoService.SaveChanges();

            return p.IdProveedor;
        }

        string ImportarExcel(string path, string SC)
        {
            System.Data.OleDb.OleDbConnection myConnection = new System.Data.OleDb.OleDbConnection(
                            "Provider=Microsoft.ACE.OLEfondoFijoService.12.0; " +
                             "data source='" + path + "';" +
                                "Extended Properties=\"Excel 12.0;HDR=YES;IMEX=1\" ");
            myConnection.Open();

            DataTable mySheets = myConnection.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });

            DataSet ds = new DataSet();
            DataTable dt;

            int mNumeroReferencia = fondoFijoService.Parametros().ProximoComprobanteProveedorReferencia ?? 1;
            // int mNumeroReferencia = fondoFijoService.ObtenerTodos().Max(x => x.NumeroReferencia) ?? 1;

            for (int i = 0; i < mySheets.Rows.Count; i++)
            {
                try
                {
                    dt = makeDataTableFromSheetName(path, mySheets.Rows[i]["TABLE_NAME"].ToString());
                    ds.Tables.Add(dt);
                }
                catch (Exception)
                {
                    // http://stackoverflow.com/questions/7441062/how-to-use-elmah-to-manually-log-errors
                    //http://stackoverflow.com/questions/3812538/elmah-add-message-to-error-logged-through-call-to-raisee
                    //http://stackoverflow.com/questions/18115891/elmah-error-logging-can-i-just-log-a-message
                    var customEx = new Exception("No pudo importar la hoja de excel", new NotSupportedException());
                    Elmah.ErrorSignal.FromCurrentContext().Raise(customEx);
                    // throw;
                }

            }

            string mTipo = "";
            string mError = "";
            var nTablaFF = 6;
            for (int fl = 0; fl < ds.Tables[nTablaFF].Rows.Count; fl++)
            {
                try
                {
                    DataRow r = ds.Tables[nTablaFF].Rows[fl];

                    mNumeroReferencia++;

                    var o = new ComprobanteProveedor();
                    ///////////////////////////////////////////
                    //If Len(.Cells(fl, 3)) > 0 Then
                    int mIdTipoComprobante = Generales.Val(r[4].NullSafeToString());
                    //Else
                    //    mIdTipoComprobante = mIdTipoComprobanteFacturaCompra
                    //End If

                    string mLetra = r[5].NullSafeToString();
                    // var mComprobante = r[6].NullSafeToString();
                    var mNumeroComprobante1 = r[6].NullSafeToString();
                    var mNumeroComprobante2 = r[7].NullSafeToString();

                    String mObservaciones = "", mCuitDefault = "";

                    var mRazonSocial = r[5].NullSafeToString();
                    var mCuit = r[9].NullSafeToString();
                    var mFechaFactura = r[3].NullSafeToString();
                    var mNumeroCAI = r[16].NullSafeToString();
                    var mFechaVencimientoCAI = r[18].NullSafeToString();
                    var mInformacionAuxiliar = r[19].NullSafeToString();

                    if (mCuit == "") continue;

                    DataRow oRsAux1;
                    int mIdProveedor;
                    try
                    {
                        oRsAux1 = EntidadManager.GetStoreProcedureTop1(SC, "Proveedores_TX_PorCuit", mCuit);
                        mIdProveedor = (int)oRsAux1[0];
                    }
                    catch (Exception)
                    {

                        mError = mError + "\r\n" + "fila " + fl + "  - proveedor inexistente :" + mCuit + " ";
                        mError += "   Se dará de alta como eventual";

                        mIdProveedor = DarloDeAltaComoEventual(mRazonSocial, mCuit);
                        oRsAux1 = EntidadManager.GetStoreProcedureTop1(SC, "Proveedores_TX_PorCuit", mCuit);
                        //continue;
                    }

                    o.Letra = mLetra;
                    o.IdTipoComprobante = mIdTipoComprobante;
                    o.IdProveedor = mIdProveedor;
                    o.CotizacionMoneda = 1;
                    o.CotizacionDolar = 1;
                    o.IdMoneda = 1;
                    o.FechaComprobante = DateTime.Now;
                    o.NumeroReferencia = mNumeroReferencia;
                    // o.NumeroRendicionFF = 99999                    ;
                    o.NumeroComprobante1 = Generales.Val(mNumeroComprobante1);
                    o.NumeroComprobante2 = Generales.Val(mNumeroComprobante2);
                    r = ds.Tables[nTablaFF].Rows[fl];

                    do
                    {
                        var mCodigoCuentaGasto = r[21].NullSafeToString();
                        var mItemPresupuestoObrasNodo = 0; // r[23].NullSafeToString();

                        var mCodigoCuenta = r[10].NullSafeToString();
                        var mBruto = r[12].NullSafeToString();  // r[11].NullSafeToString();
                        var mIva1 = r[12].NullSafeToString();
                        var mPercepcion = r[13].NullSafeToString();
                        var mTotalItem = r[14].NullSafeToString();
                        mObservaciones = mObservaciones + r[20].NullSafeToString();
                        var mAjusteIVA = 0;
                        var mIdObra = 0;
                        var mIdCuentaGasto = 0;
                        var mIdCuenta = 100;
                        var mIdRubroContable = 0;
                        var mIdPresupuestoObrasNodo = 0;
                        var mCodObra = r[1].NullSafeToString();

                        try
                        {
                            oRsAux1 = EntidadManager.GetStoreProcedureTop1(SC, "Obras_TX_PorNumero", mCodObra);
                        }
                        catch (Exception)
                        {
                            mError = mError + "\r\n" + mTipo + " " + mLetra + "-" + System.String.Format(mNumeroComprobante1, "0000") + "-" + System.String.Format(mNumeroComprobante2, "00000000") + ", fila " + fl + "  - Obra " + mCodObra + " inexistente";
                        }

                        if (oRsAux1 != null)
                        {
                            mIdObra = (int)oRsAux1["IdObra"];
                        }
                        else
                        {
                            mError = mError + "\r\n" + mTipo + " " + mLetra + "-" + System.String.Format(mNumeroComprobante1, "0000") + "-" + System.String.Format(mNumeroComprobante2, "00000000") + ", fila " + fl + "  - Obra " + mCodObra + " inexistente";
                            // fl = fl + 1
                            // GoTo FinLoop
                        }

                        try
                        {
                            if (mCodigoCuentaGasto.Length > 0)
                            {
                                oRsAux1 = EntidadManager.GetStoreProcedureTop1(SC, "CuentasGastos_TX_PorCodigo2", mCodigoCuentaGasto);
                                if (oRsAux1 != null)
                                {
                                    mIdCuentaGasto = (int)oRsAux1["IdCuentaGasto"];
                                    // oRsAux1.Close;
                                    oRsAux1 = EntidadManager.GetStoreProcedureTop1(SC, "Cuentas_TX_PorObraCuentaGasto", mIdObra, mIdCuentaGasto);

                                    if (oRsAux1 != null)
                                    {
                                        mIdCuenta = (int)oRsAux1["IdCuenta"];
                                        mCodigoCuenta = oRsAux1["Codigo"].ToString();
                                        //mIdRubroContable = IIf(IsNull(oRsAux1.Fields("IdRubroFinanciero").Value), 0, oRsAux1.Fields("IdRubroFinanciero").Value);
                                    }
                                    else
                                    {
                                        //if( ! mTomarCuentaDePresupuesto ){
                                        mError = mError + "\r\n" + mTipo + " " + mLetra + "-" + System.String.Format(mNumeroComprobante1, "0000") + "-" + System.String.Format(mNumeroComprobante2, "00000000") + ", fila " + fl + "  - Cuenta de gasto codigo :" + mCodigoCuentaGasto + " inexistente";
                                        //   fl = fl + 1;
                                        //GoTo FinLoop;
                                        //}
                                    }
                                }
                                else
                                {
                                }
                                //oRsAux1.Close;
                            }
                            mIdPresupuestoObrasNodo = 0;
                        }
                        catch (Exception ex)
                        {
                            Elmah.ErrorSignal.FromCurrentContext().Raise(ex);
                            mError = mError + "\r\n" + mTipo + " " + mLetra + "-" + System.String.Format(mNumeroComprobante1, "0000") + "-" + System.String.Format(mNumeroComprobante2, "00000000") + ", fila " + fl + "  - Cuenta de gasto codigo :" + mCodigoCuentaGasto + " inexistente";

                        }

                        /*
                                   if( Len(mItemPresupuestoObrasNodo) > 0 ){
                                      Set oRsAux1 = EntidadManager.TraerFiltrado("_PorItem", Array(mItemPresupuestoObrasNodo, mIdObra));
                                      if( oRsAux1.RecordCount == 1 ){
                                         mIdPresupuestoObrasNodo = oRsAux1.Fields("IdPresupuestoObrasNodo").Value;
                                         mIdCuenta = IIf(IsNull(oRsAux1.Fields("IdCuenta").Value), 0, oRsAux1.Fields("IdCuenta").Value);
                                      }
                                      oRsAux1.Close;
                                   }
                               */
                        oRsAux1 = EntidadManager.GetStoreProcedureTop1(SC, "Cuentas_TX_PorId", mIdCuenta);
                        /*
                                   if( oRsAux1.RecordCount > 0 ){
                                      if( IIf(IsNull(oRsAux1.Fields("ImputarAPresupuestoDeObra").Value), "NO", oRsAux1.Fields("ImputarAPresupuestoDeObra").Value) == "NO" & ! mTomarCuentaDePresupuesto ){
                                         mIdPresupuestoObrasNodo = 0;
                                      }
                                      mCodigoCuenta = oRsAux1.Fields("Codigo").Value;
                                      mIdRubroContable = IIf(IsNull(oRsAux1.Fields("IdRubroFinanciero").Value), 0, oRsAux1.Fields("IdRubroFinanciero").Value);
                                   }else{
                                      mError = mError + "\r\n" + mTipo + " " + mLetra + "-" + System.String.Format(mNumeroComprobante1, "0000") + "-" + System.String.Format(mNumeroComprobante2, "00000000") + ", fila " + fl + "  - Cuenta contable inexistente";
                                      fl = fl + 1;
                                      GoTo FinLoop;
                                   }
                          */
                        //oRsAux1.Close;

                        var det = new DetalleComprobantesProveedore();
                        decimal d;
                        decimal.TryParse(mBruto, out d);
                        det.Importe = d;
                        det.IdObra = mIdObra;
                        det.IdCuentaGasto = mIdCuentaGasto;
                        det.IdCuenta = mIdCuenta;
                        det.CodigoCuenta = mCodigoCuenta;
                        det.IdCuentaIvaCompras1 = null;
                        det.IVAComprasPorcentaje1 = 0;

                        o.DetalleComprobantesProveedores.Add(det);

                        fl = fl + 1;
                        r = ds.Tables[nTablaFF].Rows[fl];

                    }
                    while (r[1].NullSafeToString().Length > 0 && mLetra == r[5].NullSafeToString() &&
                                      mNumeroComprobante1 == r[6].NullSafeToString() && mNumeroComprobante2 == r[7].NullSafeToString()
                                   && (mCuit == r[9].NullSafeToString() || mCuit == mCuitDefault));

                    if (o.DetalleComprobantesProveedores.Count > 0)
                    {
                        //JsonResult res =   // BatchUpdate(o);
                        // mError += new JavaScriptSerializer().Serialize( res.Data) + "\n ";
                    }
                }
                catch (Exception ex)
                {
                    Elmah.ErrorSignal.FromCurrentContext().Raise(ex);
                    //throw;
                }
            }

            return mError;
        }

        void ImportacionComprobantesFondoFijo2()
        {
        }

        void ImportacionComprobantesFondoFijo()
        {
        }

        void ImportacionComprobantesFondoFijo1()
        {
        }

    }

}

