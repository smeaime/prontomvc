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

        /// //////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////

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
            // para usar la inicializacion en testing

            base.FakeInitialize(nombreEmpresa); // recien recupero a qué base se está conectando cuando tengo acceso a la sesión
            //unitOfWork = new UnitOfWork(SC);
            //fondoFijoService = new FondoFijoService(unitOfWork);

            //base.db = unitOfWork.ComprobantesproveedorRepositorio.HACKEADOcontext;

        }

        /// //////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////


        public virtual ActionResult JsonearModelo() // para usarlo en javascript
        {
            //  http://stackoverflow.com/questions/5588143/ef-4-1-code-first-json-circular-reference-serialization-error


            ViewModelComprobanteProveedor vm = new ViewModelComprobanteProveedor();
            //AutoMapper.Mapper.CreateMap<ComprobanteProveedor, ViewModelComprobanteProveedor>();
            //AutoMapper.Mapper.Map(ComprobanteProveedor, vm);

            //ppEFContext.Configuration.ProxyCreationEnabled = false;

            return Json(vm,
                        JsonRequestBehavior.AllowGet);
            //return Json(ppEFContext.Orders
            //                       .Include(o => o.Patient)
            //                       .Include(o => o.Patient.PatientAddress)
            //                       .Include(o => o.CertificationPeriod)
            //                       .Include(o => o.Agency)
            //                       .Include(o => o.Agency.Address)
            //                       .Include(o => o.PrimaryDiagnosis)
            //                       .Include(o => o.ApprovalStatus)
            //                       .Include(o => o.Approver)
            //                       .Include(o => o.Submitter),
            //    JsonRequestBehavior.AllowGet);
        }




        public virtual ViewResult IndexFF()
        {
            //if (!PuedeLeer(enumNodos)) throw new Exception("No tenés permisos");


            return Index();
        }

        public virtual ViewResult Index()
        {
            //if (!PuedeLeer(enumNodos)) throw new Exception("No tenés permisos");

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

        //public virtual ViewResult Details(int id)
        //{
        //    //ComprobanteProveedor ComprobanteProveedor = fondoFijoService.ObtenerTodos().Find(id);
        //    //return View(ComprobanteProveedor);
        //}









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

                //regexReplace(ref docText, "#Comprador#", (oFac.Comprador ?? new Empleado()).Nombre.NullSafeToString());
                //regexReplace(ref docText, "#EmailComprador#", (oFac.Comprador ?? new Empleado()).Email.NullSafeToString());
                //regexReplace(ref docText, "#TelefonoComprador#", (oFac.Comprador ?? new Empleado()).Interno.NullSafeToString());
                //regexReplace(ref docText, "#FaxComprador#", "");


                ///////////////////////////////
                ///////////////////////////////
                ///////////////////////////////
                ///////////////////////////////
                ///////////////////////////////
                ///////////////////////////////

                //regexReplace(ref docText, "#Proveedor#", oFac.Proveedor.RazonSocial);
                //regexReplace(ref docText, "#CodigoCliente#", oFac.Proveedor.CodigoProveedor.NullSafeToString());
                //regexReplace(ref docText, "#Direccion#", oFac.Proveedor.Direccion); // 'oFac.Domicilio)
                //regexReplace(ref docText, "#Localidad#", (oFac.Proveedor.Localidad ?? new Localidad()).Nombre.NullSafeToString()); // 'oFac.Domicilio)

                //regexReplace(ref docText, "#Telefono#", oFac.Proveedor.Telefono1); // 'oFac.Domicilio)
                //regexReplace(ref docText, "#Contacto#", oFac.Proveedor.Contacto); // 'oFac.Domicilio)
                //regexReplace(ref docText, "#EmailProveedor#", oFac.Proveedor.Email); // 'oFac.Domicilio)
                //regexReplace(ref docText, "#Fax#", oFac.Proveedor.Fax); // 'oFac.Domicilio)




                //regexReplace(ref docText, "#CuitProveedor#", oFac.Proveedor.Cuit);

                //regexReplace(ref docText, "#Numero#", oFac.NumeroComprobanteProveedor.ToString() + " / " + oFac.SubNumero.NullSafeToString());
                //regexReplace(ref docText, "#Fecha#", (oFac.FechaComprobanteProveedor ?? new DateTime()).ToShortDateString());

                //regexReplace(ref docText, "#CondicionIVA#", oFac.Proveedor.DescripcionIva.Descripcion.NullSafeToString());
                ////regexReplace(ref docText, "#CondicionVenta#", oFac.CondicionVentaDescripcion.NullSafeToString());
                ////regexReplace(ref docText, "#CAE#", oFac.CAE.NullSafeToString())

                //regexReplace(ref docText, "#Observaciones#", oFac.Observaciones);

                //regexReplace(ref docText, "#AclaracionCondicion#", oFac.DetalleCondicionCompra);


                //regexReplace(ref docText, "#Detalle#", oFac.Detalle.NullSafeToString());


                //regexReplace(ref docText, "#Solicito#", oFac.Solicito.NullSafeToString());
                //regexReplace(ref docText, "#Sector#", oFac.Sector.NullSafeToString());

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
                        List<Tablas.Tree> Tree = TablasDAL.ArbolRegenerar(this.Session["BasePronto"].ToString(), oStaticMembershipService );

                    }
                    catch (Exception ex)
                    {
                        ErrHandler.WriteError(ex);
                        //                        throw;
                    }
                    // TODO: acá se regenera el arbol???


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



                    //try
                    //{
                    //    //  ActivarUsuarioYContacto(ComprobanteProveedor.IdComprobanteProveedor);
                    //}
                    //catch (Exception)
                    //{

                    //    //throw;
                    //}



                    /*
                 // http://stackoverflow.com/questions/10668946/stored-procedures-in-entity-framework-and-savechanges
                 //  http://stackoverflow.com/questions/6219643/how-to-call-stored-procedure-in-mvc-by-ef
                 // http://social.msdn.microsoft.com/Forums/en-US/78e5f472-9d14-494c-b8c7-e80f7ccc3894/how-to-fire-a-savechanges-and-stored-procedure-in-a-single-transaction?forum=adodotnetentityframework
                 //  http://stackoverflow.com/questions/19248523/call-stored-procedure-inside-transaction-using-entity-framework

                 // combinar el unitOfWork con la llamada al store
                 
                 using (TransactionScope scope = new  TransactionScope())
                 {

                     //do stuff with context

                     fondoFijoService.SaveChanges(false); // i.e. try to save changes... but remember the changes in case the transaction aborts



                     //call your stored proc either via the Context or via the StoreConnection of the Context directly
                     fondoFijoService.wActualizacionesVariasPorComprobante(104, ComprobanteProveedor.IdComprobanteProveedor, tipomovimiento);

                     //if everything goes okay

                     scope.Complete();

                     fondoFijoService.AcceptAllChanges();

                 }
                  * */





                    //try
                    //{
                    //    List<Tablas.Tree> Tree = TablasDAL.ArbolRegenerar(this.Session["BasePronto"].ToString());

                    //}
                    //catch (Exception ex)
                    //{
                    //    ErrHandler.WriteError(ex);
                    //    //                        throw;
                    //}
                    //// TODO: acá se regenera el arbol???


                    return Json(new { Success = 1, Errors = "", IdComprobanteProveedor = o.IdComprobanteProveedor, ex = "" });

                    // return RedirectToAction(MVC.Cuenta.Index());
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
        public virtual JsonResult BatchUpdate(ViewModelComprobanteProveedor ComprobanteProveedor)
        //public virtual JsonResult BatchUpdate(ComprobanteProveedor ComprobanteProveedor)
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


            AutoMapper.Mapper.CreateMap<ViewModelComprobanteProveedor, Data.Models.ComprobanteProveedor>();
            ComprobanteProveedor o = new ComprobanteProveedor();
            AutoMapper.Mapper.Map(ComprobanteProveedor, o);


            if (!Validar(o, ref errs, ref warnings))
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




            if ((o.IdProveedor ?? 0) <= 0 && (o.IdProveedorEventual ?? 0) <= 0
                && (o.Proveedor ?? new Proveedor()).RazonSocial != "")
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

                    // db.Tree_TX_Actualizar("ComprobantesPrvPorMes", o.IdComprobanteProveedor, "ComprobanteProveedor");


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



                    //try
                    //{
                    //    //  ActivarUsuarioYContacto(ComprobanteProveedor.IdComprobanteProveedor);
                    //}
                    //catch (Exception)
                    //{

                    //    //throw;
                    //}



                    /*
                 // http://stackoverflow.com/questions/10668946/stored-procedures-in-entity-framework-and-savechanges
                 //  http://stackoverflow.com/questions/6219643/how-to-call-stored-procedure-in-mvc-by-ef
                 // http://social.msdn.microsoft.com/Forums/en-US/78e5f472-9d14-494c-b8c7-e80f7ccc3894/how-to-fire-a-savechanges-and-stored-procedure-in-a-single-transaction?forum=adodotnetentityframework
                 //  http://stackoverflow.com/questions/19248523/call-stored-procedure-inside-transaction-using-entity-framework

                 // combinar el unitOfWork con la llamada al store
                 
                 using (TransactionScope scope = new  TransactionScope())
                 {

                     //do stuff with context

                     fondoFijoService.SaveChanges(false); // i.e. try to save changes... but remember the changes in case the transaction aborts



                     //call your stored proc either via the Context or via the StoreConnection of the Context directly
                     fondoFijoService.wActualizacionesVariasPorComprobante(104, ComprobanteProveedor.IdComprobanteProveedor, tipomovimiento);

                     //if everything goes okay

                     scope.Complete();

                     fondoFijoService.AcceptAllChanges();

                 }
                  * */





                    //try
                    //{
                    //    List<Tablas.Tree> Tree = TablasDAL.ArbolRegenerar(this.Session["BasePronto"].ToString());

                    //}
                    //catch (Exception ex)
                    //{
                    //    ErrHandler.WriteError(ex);
                    //    //                        throw;
                    //}
                    //// TODO: acá se regenera el arbol???


                    return Json(new { Success = 1, Errors = "", IdComprobanteProveedor = o.IdComprobanteProveedor, ex = "" });

                    // return RedirectToAction(MVC.Cuenta.Index());
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





            ViewModelComprobanteProveedor vm = new ViewModelComprobanteProveedor();
            AutoMapper.Mapper.CreateMap<Data.Models.ComprobanteProveedor, ViewModelComprobanteProveedor>();
            AutoMapper.Mapper.Map(ComprobanteProveedor, vm);



            CargarViewBag(vm);



            if (id == -1)
            {
                return View(vm);
            }
            else if (ComprobanteProveedor.IdCuenta != null && ComprobanteProveedor.IdProveedor == null && ComprobanteProveedor.IdCuentaOtros == null)
            {
                // return View("EditFF", (ViewModelComprobanteProveedor)ComprobanteProveedor);
                return View("EditFF", vm);
            }
            else if (ComprobanteProveedor.IdCuentaOtros != null)
            {
                // return View("EditFF", (ViewModelComprobanteProveedor)ComprobanteProveedor);
                return View("EditOtros", vm);
            }
            else
            {
                // return View("Edit", (ViewModelComprobanteProveedor)ComprobanteProveedor);
                return View("Edit", vm);
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



        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        /// <summary>
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="o"></param>





        public void Logica_VB6_Guardar(ref object ComprobanteProveedor, object Detalles, object RegistroContable, object DetallesProvincias)
        {
            //if ((!IsNull(ComprobanteProveedor.Fields("Confirmado").Value)
            //            && (ComprobanteProveedor.Fields("Confirmado").Value == "NO")))
            //{
            //    return GuardarNoConfirmados(ComprobanteProveedor, Detalles);

            //}
            //ObjectContext oCont;
            //iCompMTS oDet;
            //InterFazMTS.MisEstados Resp;
            //object Datos;
            //object DatosCtaCte;
            //object DatosCtaCteNv;
            //object DatosProveedor;
            //object DetRem;
            //object DatosAnt;
            //object DatosAsiento;
            //object DatosAsientoNv;
            //object oRsParametros;
            //object DatosDetAsiento;
            //object DatosDetAsientoNv;
            //object oRsValores;
            //object oRsAux;
            //ADOR.Field oFld;
            //long lErr;
            //string sSource;
            //string sDesc;
            //int i;
            //int mvarCoeficiente;
            //int mvarCoeficienteAnt;
            //long mvarNumeroAsiento;
            //long mvarIdAsiento;
            //long mvarIdentificador;
            //long mvarIdCuenta;
            //long mIdValor;
            //long mvarIdProveedorAnterior;
            //long mvarIdTipoComprobanteAnterior;
            //long mvarIdBanco;
            //long mvarIdCaja;
            //long mvarIdOrdenPagoActual;
            //long mvarIdOrdenPagoAnterior;
            //long mvarAuxL1;
            //long mvarIdDetalleComprobanteProveedor;
            //long mvarIdDetalleComprobanteProveedorAnt;
            //long mvarNumeroReferencia;
            //long mvarIdTipoCuentaGrupoIVA;
            //double mTotalAnterior;
            //double mvarCotizacionAnt;
            //double mvarCotizacionDolar;
            //double mvarCotizacionMoneda;
            //double mTotalAnteriorDolar;
            //double mvarDebe;
            //double mvarHaber;
            //double mvarCotizacionEuro;
            //double mTotalAnteriorEuro;
            //double Tot;
            //double TotDol;
            //double TotEu;
            //double Sdo;
            //double SdoDol;
            //double SdoEu;
            //bool mvarBorrarEnValores;
            //bool mvarSubdiarios_ResumirRegistros;
            //bool mvarOk;
            //bool mvarProcesar;
            //bool mvarGrabarRegistrosEnCuentaCorriente;


            //// TODO: On Error GoTo Warning!!!: The statement is not translatable 
            //oCont = GetObjectContext;
            //if ((oCont == null))
            //{
            //    oDet = CreateObject("MTSPronto.General");
            //}
            //else
            //{
            //    oDet = oCont.CreateInstance("MTSPronto.General");
            //}


            //mvarIdentificador = ComprobanteProveedor.Fields(0).Value;
            //mvarCotizacionMoneda = (IsNull(ComprobanteProveedor.Fields("CotizacionMoneda").Value) ? 0 : ComprobanteProveedor.Fields("CotizacionMoneda").Value);
            //mvarCotizacionDolar = (IsNull(ComprobanteProveedor.Fields("CotizacionDolar").Value) ? 0 : ComprobanteProveedor.Fields("CotizacionDolar").Value);
            //mvarCotizacionEuro = (IsNull(ComprobanteProveedor.Fields("CotizacionEuro").Value) ? 0 : ComprobanteProveedor.Fields("CotizacionEuro").Value);
            //mvarIdOrdenPagoActual = (IsNull(ComprobanteProveedor.Fields("IdOrdenPago").Value) ? 0 : ComprobanteProveedor.Fields("IdOrdenPago").Value);
            //mvarNumeroReferencia = (IsNull(ComprobanteProveedor.Fields("NumeroReferencia").Value) ? 0 : ComprobanteProveedor.Fields("NumeroReferencia").Value);
            //Datos = oDet.LeerUno("Parametros", 1);
            //if ((IsNull(Datos.Fields("Subdiarios_ResumirRegistros").Value)
            //            || (Datos.Fields("Subdiarios_ResumirRegistros").Value == "SI")))
            //{
            //    mvarSubdiarios_ResumirRegistros = true;
            //}
            //else
            //{
            //    mvarSubdiarios_ResumirRegistros = false;
            //}
            //mvarIdTipoCuentaGrupoIVA = (IsNull(Datos.Fields("IdTipoCuentaGrupoIVA").Value) ? 0 : Datos.Fields("IdTipoCuentaGrupoIVA").Value);
            //Datos.Close();
            //mvarCoeficiente = 1;
            //Datos = oDet.LeerUno("TiposComprobante", ComprobanteProveedor.Fields("IdTipoComprobante").Value);
            //if ((Datos.RecordCount > 0))
            //{
            //    mvarCoeficiente = Datos.Fields("Coeficiente").Value;
            //}
            //Datos.Close();
            //Datos = null;
            //mvarCoeficienteAnt = mvarCoeficiente;
            //if (!IsNull(ComprobanteProveedor.Fields("IdDiferenciaCambio").Value))
            //{
            //    oDet.Tarea("DiferenciasCambio_MarcarComoGenerada", Array(ComprobanteProveedor.Fields("IdDiferenciaCambio").Value, ComprobanteProveedor.Fields("IdTipoComprobante").Value, ComprobanteProveedor.Fields(0).Value));
            //}
            //mTotalAnterior = 0;
            //mvarIdProveedorAnterior = 0;
            //mvarIdTipoComprobanteAnterior = 0;
            //mvarIdOrdenPagoAnterior = 0;
            //mvarGrabarRegistrosEnCuentaCorriente = true;






            //if ((mvarIdentificador > 0))
            //{
            //    DatosAnt = oDet.LeerUno("ComprobantesProveedores", mvarIdentificador);
            //    if ((DatosAnt.RecordCount > 0))
            //    {
            //        mvarCotizacionAnt = (IsNull(DatosAnt.Fields("CotizacionMoneda").Value) ? 1 : DatosAnt.Fields("CotizacionMoneda").Value);
            //        mTotalAnterior = (DatosAnt.Fields("TotalComprobante").Value * mvarCotizacionAnt);
            //        if (!IsNull(DatosAnt.Fields("IdProveedor").Value))
            //        {
            //            mvarIdProveedorAnterior = DatosAnt.Fields("IdProveedor").Value;
            //        }
            //        if (!IsNull(DatosAnt.Fields("IdTipoComprobante").Value))
            //        {
            //            mvarIdTipoComprobanteAnterior = DatosAnt.Fields("IdTipoComprobante").Value;
            //        }
            //        Datos = oDet.LeerUno("TiposComprobante", DatosAnt.Fields("IdTipoComprobante").Value);
            //        if ((Datos.RecordCount > 0))
            //        {
            //            mvarCoeficienteAnt = Datos.Fields("Coeficiente").Value;
            //        }
            //        mvarIdOrdenPagoAnterior = (IsNull(DatosAnt.Fields("IdOrdenPago").Value) ? 0 : DatosAnt.Fields("IdOrdenPago").Value);
            //        Datos.Close();
            //        Datos = null;
            //        if (!IsNull(DatosAnt.Fields("IdComprobanteImputado").Value))
            //        {
            //            mvarAuxL1 = 11;
            //            oRsAux = oDet.LeerUno("ComprobantesProveedores", DatosAnt.Fields("IdComprobanteImputado").Value);
            //            if ((oRsAux.RecordCount > 0))
            //            {
            //                mvarAuxL1 = oRsAux.Fields("IdTipoComprobante").Value;
            //            }
            //            oRsAux.Close();
            //            DatosCtaCteNv = oDet.TraerFiltrado("CtasCtesA", "_BuscarComprobante", Array(mvarIdentificador, DatosAnt.Fields("IdTipoComprobante").Value));
            //            if ((DatosCtaCteNv.RecordCount > 0))
            //            {
            //                Tot = (DatosCtaCteNv.Fields("ImporteTotal").Value - DatosCtaCteNv.Fields("Saldo").Value);
            //                TotDol = (DatosCtaCteNv.Fields("ImporteTotalDolar").Value - DatosCtaCteNv.Fields("SaldoDolar").Value);
            //                TotEu = ((IsNull(DatosCtaCteNv.Fields("ImporteTotalEuro").Value) ? 0 : DatosCtaCteNv.Fields("ImporteTotalEuro").Value) - (IsNull(DatosCtaCteNv.Fields("SaldoEuro").Value) ? 0 : DatosCtaCteNv.Fields("SaldoEuro").Value));
            //                DatosCtaCte = oDet.TraerFiltrado("CtasCtesA", "_BuscarComprobante", Array(DatosAnt.Fields("IdComprobanteImputado").Value, mvarAuxL1));
            //                if ((DatosCtaCte.RecordCount > 0))
            //                {
            //                    DatosCtaCte.Fields("Saldo").Value = (DatosCtaCte.Fields("Saldo").Value + Tot);
            //                    DatosCtaCte.Fields("SaldoDolar").Value = (DatosCtaCte.Fields("SaldoDolar").Value + TotDol);
            //                    DatosCtaCte.Fields("SaldoEuro").Value = ((IsNull(DatosCtaCte.Fields("SaldoEuro").Value) ? 0 : DatosCtaCte.Fields("SaldoEuro").Value) + TotEu);
            //                    Resp = oDet.Guardar("CtasCtesA", DatosCtaCte);
            //                }
            //                DatosCtaCte.Close();
            //                DatosCtaCte = null;
            //                oDet.Eliminar("CtasCtesA", DatosCtaCteNv.Fields(0).Value);
            //            }
            //            DatosCtaCteNv.Close();
            //            DatosCtaCteNv = null;
            //        }
            //    }
            //    DatosAnt.Close();
            //    DatosAnt = null;
            //}
            //Resp = iCompMTS_GuardarPorRef("ComprobantesProveedores", ComprobanteProveedor);
            //Datos = oDet.LeerUno("ComprobantesProveedores", ComprobanteProveedor.Fields(0).Value);
            //if ((Datos.RecordCount > 0))
            //{
            //    mvarNumeroReferencia = (IsNull(Datos.Fields("NumeroReferencia").Value) ? 0 : Datos.Fields("NumeroReferencia").Value);
            //}
            //Datos.Close();
            //if (((mvarIdOrdenPagoActual != 0)
            //            || (mvarIdOrdenPagoAnterior != 0)))
            //{
            //    oDet.Tarea("OrdenesPago_ActualizarDiferenciaBalanceo", Array(mvarIdOrdenPagoActual, mvarIdOrdenPagoAnterior));
            //}
            //if ((mvarIdProveedorAnterior != 0))
            //{
            //    DatosProveedor = oDet.LeerUno("Proveedores", mvarIdProveedorAnterior);
            //    if (IsNull(DatosProveedor.Fields("Saldo").Value))
            //    {
            //        DatosProveedor.Fields("Saldo").Value = 0;
            //    }
            //    DatosProveedor.Fields("Saldo").Value = (DatosProveedor.Fields("Saldo").Value
            //                + (mTotalAnterior * mvarCoeficienteAnt));
            //    Resp = oDet.Guardar("Proveedores", DatosProveedor);
            //    DatosProveedor.Close();
            //    DatosProveedor = null;
            //}
            //if (!IsNull(ComprobanteProveedor.Fields("IdProveedor").Value))
            //{
            //    DatosProveedor = oDet.LeerUno("Proveedores", ComprobanteProveedor.Fields("IdProveedor").Value);
            //    if (IsNull(DatosProveedor.Fields("Saldo").Value))
            //    {
            //        DatosProveedor.Fields("Saldo").Value = 0;
            //    }
            //    DatosProveedor.Fields("Saldo").Value = (DatosProveedor.Fields("Saldo").Value
            //                - (ComprobanteProveedor.Fields("TotalComprobante").Value
            //                * (mvarCoeficiente * mvarCotizacionMoneda)));
            //    if (((IsNull(DatosProveedor.Fields("RegistrarMovimientosEnCuentaCorriente").Value) ? "" : DatosProveedor.Fields("RegistrarMovimientosEnCuentaCorriente").Value) == "NO"))
            //    {
            //        mvarGrabarRegistrosEnCuentaCorriente = false;
            //    }
            //    Resp = oDet.Guardar("Proveedores", DatosProveedor);
            //    DatosProveedor.Close();
            //    DatosProveedor = null;
            //}



            //// Borra la registracion contable anterior si el comprobante fue modificado
            //if ((mvarIdentificador > 0))
            //{
            //    DatosAnt = oDet.TraerFiltrado("Subdiarios", "_PorIdComprobante", Array(mvarIdentificador, mvarIdTipoComprobanteAnterior));
            //    // With...
            //    if ((DatosAnt.RecordCount > 0))
            //    {
            //        DatosAnt.MoveFirst;
            //        while (!DatosAnt.EOF)
            //        {
            //            oDet.Eliminar("Subdiarios", DatosAnt.Fields, 0.Value).MoveNext();
            //        }
            //        DatosAnt.Close;
            //        // With...
            //        // With...









            //        if ((Detalles.State != adStateClosed))
            //        {
            //            if (!Detalles.EOF)
            //            {
            //                Detalles.Update;
            //                MoveFirst();
            //            }
            //            while (!Detalles.EOF.Fields)
            //            {
            //                "IdComprobanteProveedor".Value = ComprobanteProveedor.Fields(0).Value.Update();
            //                if (Detalles.Fields)
            //                {
            //                    "Eliminado".Value;
            //                    oDet.Eliminar("DetComprobantesProveedores", Detalles.Fields, 0.Value);
            //                    oDet.Tarea("Valores_BorrarPorIdDetalleComprobanteProveedor", Detalles.Fields, 0.Value);
            //                }
            //                else
            //                {
            //                    Datos = CreateObject("object");
            //                    for (i = 0; (i
            //                                <= (Detalles.Fields.Count - 2)); i++)
            //                    {
            //                        // With...
            //                        i;
            //                        Datos.Fields.Append.Name;
            //                        Detalles.Fields.Type;
            //                        Detalles.Fields.DefinedSize;
            //                        Detalles.Fields.Attributes;
            //                        Datos.Fields(Detalles.Fields.Name).Precision = Detalles.Fields.Precision;
            //                        Datos.Fields(Detalles.Fields.Name).NumericScale = Detalles.Fields.NumericScale;
            //                    }
            //                    Datos.Open();
            //                    Datos.AddNew();
            //                    for (i = 0; (i
            //                                <= (Detalles.Fields.Count - 2)); i++)
            //                    {
            //                        // With...
            //                        i;
            //                        Datos.Fields(i).Value = Detalles.Fields.Value;
            //                    }
            //                    Datos.Update();
            //                    mvarIdDetalleComprobanteProveedorAnt = Datos.Fields(0).Value;
            //                    Resp = oDet.Guardar("DetComprobantesProveedores", Datos);
            //                    mvarIdDetalleComprobanteProveedor = Datos.Fields(0).Value;
            //                    Datos.Close();
            //                    Datos = null;
            //                    if ((!mvarSubdiarios_ResumirRegistros
            //                                && (RegistroContable.RecordCount > 0)))
            //                    {
            //                        RegistroContable.MoveFirst();
            //                        while (!RegistroContable.EOF)
            //                        {
            //                            if (((RegistroContable.Fields("IdDetalleComprobante").Value == mvarIdDetalleComprobanteProveedorAnt)
            //                                        && (mvarIdDetalleComprobanteProveedorAnt != mvarIdDetalleComprobanteProveedor)))
            //                            {
            //                                RegistroContable.Fields("IdDetalleComprobante").Value = mvarIdDetalleComprobanteProveedor;
            //                                RegistroContable.Update();
            //                            }
            //                            RegistroContable.MoveNext();
            //                        }
            //                        RegistroContable.MoveFirst();
            //                    }
            //                    mvarBorrarEnValores = true;
            //                    oRsAux = oDet.TraerFiltrado("Cuentas", "_CuentaCajaBanco", Detalles.Fields, "IdCuenta".Value);
            //                    if ((oRsAux.RecordCount > 0))
            //                    {
            //                        if ((!IsNull(oRsAux.Fields("EsCajaBanco").Value)
            //                                    && ((oRsAux.Fields("EsCajaBanco").Value == "BA")
            //                                    || (oRsAux.Fields("EsCajaBanco").Value == "CA"))))
            //                        {
            //                            mvarIdCaja = (IsNull(oRsAux.Fields("IdCaja").Value) ? 0 : oRsAux.Fields("IdCaja").Value);
            //                            oRsAux.Close();
            //                            mIdValor = -1;
            //                            oRsValores = oDet.TraerFiltrado("Valores", "_PorIdDetalleComprobanteProveedor", mvarIdDetalleComprobanteProveedor);
            //                            if ((oRsValores.RecordCount > 0))
            //                            {
            //                                mIdValor = oRsValores.Fields(0).Value;
            //                            }
            //                            oRsValores.Close();
            //                            oRsValores = null;
            //                            mvarIdBanco = 0;
            //                            if (!IsNull(Detalles.Fields, "IdCuentaBancaria".Value))
            //                            {
            //                                oRsAux = oDet.TraerFiltrado("CuentasBancarias", "_PorId", Detalles.Fields, "IdCuentaBancaria".Value);
            //                                if ((oRsAux.RecordCount > 0))
            //                                {
            //                                    mvarIdBanco = oRsAux.Fields("IdBanco").Value;
            //                                }
            //                                oRsAux.Close();
            //                            }
            //                            if (((mvarIdBanco != 0)
            //                                        || (mvarIdCaja != 0)))
            //                            {
            //                                oRsValores = CopiarRs(oDet.TraerFiltrado("Valores", "_Struc"));
            //                                // With...
            //                                if ((mvarIdBanco != 0))
            //                                {

            //                                }
            //                                0.Fields("FechaValor").Value = Detalles.Fields("IdCuentaBancaria").Value;
            //                                0.Fields("NumeroInterno").Value = Detalles.Fields("IdCuentaBancaria").Value;
            //                                32.Fields("NumeroValor").Value = Detalles.Fields("IdCuentaBancaria").Value;
            //                                oRsValores.Fields("IdTipoValor").Value = Detalles.Fields("IdCuentaBancaria").Value;
            //                                Fields("IdBanco").Value = mvarIdBanco;
            //                                if ((mvarIdCaja != 0))
            //                                {

            //                                }
            //                                mvarNumeroReferencia.Fields("FechaComprobante").Value = ComprobanteProveedor.Fields("FechaComprobante").Value;
            //                                Detalles.Fields("Importe").Value.Fields("NumeroComprobante").Value = ComprobanteProveedor.Fields("FechaComprobante").Value;
            //                                mvarIdCaja.Fields("Importe").Value = ComprobanteProveedor.Fields("FechaComprobante").Value;
            //                                Fields("IdCaja").Value = ComprobanteProveedor.Fields("FechaComprobante").Value;
            //                                if (!IsNull(ComprobanteProveedor.Fields("IdProveedor").Value))
            //                                {
            //                                    Fields("IdProveedor").Value = ComprobanteProveedor.Fields("IdProveedor").Value;
            //                                }
            //                                ComprobanteProveedor.Fields("CotizacionMoneda").Value.Fields(0).Value = mIdValor;
            //                                ComprobanteProveedor.Fields("IdMoneda").Value.Fields("CotizacionMoneda").Value = mIdValor;
            //                                mvarIdDetalleComprobanteProveedor.Fields("IdMoneda").Value = mIdValor;
            //                                ComprobanteProveedor.Fields("IdTipoComprobante").Value.Fields("IdDetalleComprobanteProveedor").Value = mIdValor;
            //                                Fields("IdTipoComprobante").Value = mIdValor;
            //                                Resp = oDet.Guardar("Valores", oRsValores);
            //                                oRsValores.Close();
            //                                oRsValores = null;
            //                                mvarBorrarEnValores = false;
            //                            }
            //                        }
            //                    }
            //                    else
            //                    {
            //                        oRsAux.Close();
            //                    }
            //                    oRsAux = null;
            //                    if (((mvarIdentificador > 0)
            //                                && mvarBorrarEnValores))
            //                    {
            //                        oDet.Tarea("Valores_BorrarPorIdDetalleComprobanteProveedor", Detalles.Fields, 0.Value);
            //                    }
            //                }
            //                if (!IsNull(Detalles.Fields, "IdArticulo".Value))
            //                {
            //                    oDet.Tarea("Conjuntos_CalcularCostoConjuntoDesdeComponente", Detalles.Fields, "IdArticulo".Value);
            //                }
            //                Detalles.MoveNext;
            //                // With...
            //                if ((!IsNull(ComprobanteProveedor.Fields("IdProveedor").Value)
            //                            && mvarGrabarRegistrosEnCuentaCorriente))
            //                {
            //                    mTotalAnterior = 0;
            //                    mTotalAnteriorDolar = 0;
            //                    mTotalAnteriorEuro = 0;
            //                    if ((mvarIdentificador > 0))
            //                    {
            //                        DatosCtaCteNv = oDet.TraerFiltrado("CtasCtesA", "_BuscarComprobante", Array(ComprobanteProveedor.Fields(0).Value, mvarIdTipoComprobanteAnterior));
            //                        if ((DatosCtaCteNv.RecordCount > 0))
            //                        {
            //                            mTotalAnterior = (DatosCtaCteNv.Fields("ImporteTotal").Value - DatosCtaCteNv.Fields("Saldo").Value);
            //                            mTotalAnteriorDolar = (DatosCtaCteNv.Fields("ImporteTotalDolar").Value - DatosCtaCteNv.Fields("SaldoDolar").Value);
            //                            mTotalAnteriorEuro = ((IsNull(DatosCtaCteNv.Fields("ImporteTotalEuro").Value) ? 0 : DatosCtaCteNv.Fields("ImporteTotalEuro").Value) - (IsNull(DatosCtaCteNv.Fields("SaldoEuro").Value) ? 0 : DatosCtaCteNv.Fields("SaldoEuro").Value));
            //                        }
            //                        else
            //                        {
            //                            DatosCtaCteNv.Close();
            //                            DatosCtaCte = oDet.TraerFiltrado("CtasCtesA", "_Struc");
            //                            DatosCtaCteNv = CopiarRs(DatosCtaCte);
            //                            DatosCtaCteNv.Fields(0).Value = -1;
            //                        }
            //                    }
            //                    else
            //                    {
            //                        DatosCtaCte = oDet.TraerFiltrado("CtasCtesA", "_Struc");
            //                        DatosCtaCteNv = CopiarRs(DatosCtaCte);
            //                        DatosCtaCteNv.Fields(0).Value = -1;
            //                    }
            //                    // With...
            //                    Tot = Round((ComprobanteProveedor.Fields("TotalComprobante").Value * mvarCotizacionMoneda), 2);
            //                    TotDol = 0;
            //                    if ((mvarCotizacionDolar != 0))
            //                    {
            //                        TotDol = Round((ComprobanteProveedor.Fields("TotalComprobante").Value
            //                                        * (((mvarCotizacionMoneda == 0) ? 1 : mvarCotizacionMoneda) / mvarCotizacionDolar)), 2);
            //                    }
            //                    TotEu = 0;
            //                    if ((mvarCotizacionEuro != 0))
            //                    {
            //                        TotEu = Round((ComprobanteProveedor.Fields("TotalComprobante").Value
            //                                        * (((mvarCotizacionMoneda == 0) ? 1 : mvarCotizacionMoneda) / mvarCotizacionEuro)), 2);
            //                    }
            //                    DatosCtaCteNv.Fields;
            //                    ComprobanteProveedor.Fields("IdMoneda").Value.Fields("CotizacionMoneda").Value = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    (TotEu - mTotalAnteriorEuro.Fields("IdMoneda").Value) = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    TotEu.Fields("SaldoEuro").Value = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    mvarCotizacionEuro.Fields("ImporteTotalEuro").Value = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    (TotDol - mTotalAnteriorDolar.Fields("CotizacionEuro").Value) = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    TotDol.Fields("SaldoDolar").Value = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    mvarCotizacionDolar.Fields("ImporteTotalDolar").Value = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    (Tot - mTotalAnterior.Fields("CotizacionDolar").Value) = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    Tot.Fields("Saldo").Value = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    ComprobanteProveedor.Fields("FechaVencimiento").Value.Fields("ImporteTotal").Value = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    ComprobanteProveedor.Fields(0).Value.Fields("FechaVencimiento").Value = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    ComprobanteProveedor.Fields("IdTipoComprobante").Value.Fields("IdComprobante").Value = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    ComprobanteProveedor.Fields("FechaRecepcion").Value.Fields("IdTipoComp").Value = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    mvarNumeroReferencia.Fields("Fecha").Value = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    ComprobanteProveedor.Fields("IdProveedor").Value.Fields("NumeroComprobante").Value = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    "IdProveedor".Value = ComprobanteProveedor.Fields("CotizacionMoneda").Value;
            //                    if (!IsNull(ComprobanteProveedor.Fields("IdComprobanteImputado").Value))
            //                    {
            //                        Sdo = 0;
            //                        SdoDol = 0;
            //                        SdoEu = 0;
            //                        mvarAuxL1 = 11;
            //                        oRsAux = oDet.LeerUno("ComprobantesProveedores", ComprobanteProveedor.Fields("IdComprobanteImputado").Value);
            //                        if ((oRsAux.RecordCount > 0))
            //                        {
            //                            mvarAuxL1 = oRsAux.Fields("IdTipoComprobante").Value;
            //                        }
            //                        oRsAux.Close();
            //                        oRsAux = oDet.TraerFiltrado("CtasCtesA", "_BuscarComprobante", Array(ComprobanteProveedor.Fields("IdComprobanteImputado").Value, mvarAuxL1));
            //                        if ((oRsAux.RecordCount > 0))
            //                        {
            //                            Sdo = oRsAux.Fields("Saldo").Value;
            //                            SdoDol = (IsNull(oRsAux.Fields("SaldoDolar").Value) ? 0 : oRsAux.Fields("SaldoDolar").Value);
            //                            SdoEu = (IsNull(oRsAux.Fields("SaldoEuro").Value) ? 0 : oRsAux.Fields("SaldoEuro").Value);
            //                            if ((IsNull(ComprobanteProveedor.Fields("Dolarizada").Value)
            //                                        || (ComprobanteProveedor.Fields("Dolarizada").Value == "NO")))
            //                            {
            //                                TotDol = 0;
            //                                if (((IsNull(oRsAux.Fields("CotizacionDolar").Value) ? 0 : oRsAux.Fields("CotizacionDolar").Value) != 0))
            //                                {
            //                                    TotDol = Round((Abs((Tot * ((mvarCotizacionMoneda == 0) ? 1 : mvarCotizacionMoneda))) / oRsAux.Fields("CotizacionDolar").Value), 2);
            //                                }
            //                                DatosCtaCteNv.Fields;
            //                                TotDol.Fields("SaldoDolar").Value = TotDol;
            //                                oRsAux.Fields("CotizacionDolar").Value.Fields("ImporteTotalDolar").Value = TotDol;
            //                                "CotizacionDolar".Value = TotDol;
            //                            }
            //                            TotEu = 0;
            //                            if (((IsNull(oRsAux.Fields("CotizacionEuro").Value) ? 0 : oRsAux.Fields("CotizacionEuro").Value) != 0))
            //                            {
            //                                TotEu = Round((Abs((Tot * ((mvarCotizacionMoneda == 0) ? 1 : mvarCotizacionMoneda))) / oRsAux.Fields("CotizacionEuro").Value), 2);
            //                            }
            //                            DatosCtaCteNv.Fields;
            //                            TotEu.Fields("SaldoEuro").Value = TotEu;
            //                            oRsAux.Fields("CotizacionEuro").Value.Fields("ImporteTotalEuro").Value = TotEu;
            //                            "CotizacionEuro".Value = TotEu;
            //                            if ((Tot > Sdo))
            //                            {
            //                                Tot = Round((Tot - Sdo), 2);
            //                                0.Fields("Saldo").Value = Tot;
            //                                oRsAux.Fields("Saldo").Value = Tot;
            //                            }
            //                            else
            //                            {
            //                                Sdo = Round((Sdo - Tot), 2);
            //                                Sdo.Fields("Saldo").Value = 0;
            //                                oRsAux.Fields("Saldo").Value = 0;
            //                            }
            //                            if ((TotDol > SdoDol))
            //                            {
            //                                TotDol = Round((TotDol - SdoDol), 2);
            //                                0.Fields("SaldoDolar").Value = TotDol;
            //                                oRsAux.Fields("SaldoDolar").Value = TotDol;
            //                            }
            //                            else
            //                            {
            //                                SdoDol = Round((SdoDol - TotDol), 2);
            //                                SdoDol.Fields("SaldoDolar").Value = 0;
            //                                oRsAux.Fields("SaldoDolar").Value = 0;
            //                            }
            //                            if ((TotEu > SdoEu))
            //                            {
            //                                TotEu = Round((TotEu - SdoEu), 2);
            //                                0.Fields("SaldoEuro").Value = TotEu;
            //                                oRsAux.Fields("SaldoEuro").Value = TotEu;
            //                            }
            //                            else
            //                            {
            //                                SdoEu = Round((SdoEu - TotEu), 2);
            //                                SdoEu.Fields("SaldoEuro").Value = 0;
            //                                oRsAux.Fields("SaldoEuro").Value = 0;
            //                            }
            //                            DatosCtaCteNv.Fields;
            //                            "IdImputacion".Value = oRsAux.Fields("IdImputacion").Value;
            //                            Resp = oDet.Guardar("CtasCtesA", oRsAux);
            //                        }
            //                        oRsAux.Close();
            //                    }
            //                    Resp = oDet.Guardar("CtasCtesA", DatosCtaCteNv);
            //                    if (IsNull(DatosCtaCteNv.Fields("IdImputacion").Value))
            //                    {
            //                        DatosCtaCteNv.Fields("IdImputacion").Value = DatosCtaCteNv.Fields(0).Value;
            //                        Resp = oDet.Guardar("CtasCtesA", DatosCtaCteNv);
            //                    }
            //                    DatosCtaCteNv.Close();
            //                    DatosCtaCteNv = null;
            //                    DatosCtaCte = null;
            //                }
            //                else if ((mvarIdentificador > 0))
            //                {
            //                    DatosCtaCte = oDet.TraerFiltrado("CtasCtesA", "_BuscarComprobante", Array(ComprobanteProveedor.Fields(0).Value, mvarIdTipoComprobanteAnterior));
            //                    if ((DatosCtaCte.RecordCount > 0))
            //                    {
            //                        oDet.Eliminar("CtasCtesA", DatosCtaCte.Fields(0).Value);
            //                    }
            //                    DatosCtaCte.Close();
            //                    DatosCtaCte = null;
            //                }





            //                mvarDebe = 0;
            //                mvarHaber = 0;
            //                // With...
            //                if ((RegistroContable.State != adStateClosed))
            //                {
            //                    if ((RegistroContable.RecordCount > 0))
            //                    {
            //                        RegistroContable.Update;
            //                        MoveFirst();
            //                    }
            //                    while (!RegistroContable.EOF)
            //                    {
            //                        if (!IsNull(RegistroContable.Fields, "Debe".Value))
            //                        {
            //                            RegistroContable.Fields;
            //                            "Debe".Value = Round(RegistroContable.Fields, ("Debe".Value * mvarCotizacionMoneda), 2).Update();
            //                            mvarDebe = (mvarDebe + RegistroContable.Fields);
            //                            "Debe".Value;
            //                        }
            //                        if (!IsNull(RegistroContable.Fields, "Haber".Value))
            //                        {
            //                            RegistroContable.Fields;
            //                            "Haber".Value = Round(RegistroContable.Fields, ("Haber".Value * mvarCotizacionMoneda), 2).Update();
            //                            mvarHaber = (mvarHaber + RegistroContable.Fields);
            //                            "Haber".Value;
            //                        }
            //                        RegistroContable.MoveNext;
            //                        if ((RegistroContable.RecordCount > 0))
            //                        {
            //                            if (((mvarDebe - mvarHaber)
            //                                        != 0))
            //                            {
            //                                mvarOk = false.MoveFirst();
            //                                while (!RegistroContable.EOF)
            //                                {
            //                                    if (!IsNull(RegistroContable.Fields, "Debe".Value))
            //                                    {
            //                                        mvarProcesar = true;
            //                                        oRsAux = oDet.TraerFiltrado("Cuentas", "_CuentaParaAjusteSubdiario", RegistroContable.Fields, "IdCuenta".Value);
            //                                        if ((oRsAux.Fields(0).Value == 0))
            //                                        {
            //                                            mvarProcesar = false;
            //                                        }
            //                                        oRsAux.Close();
            //                                        Datos = null;
            //                                        if (mvarProcesar)
            //                                        {
            //                                            RegistroContable.Fields;
            //                                            "Debe".Value = RegistroContable.Fields;
            //                                            ("Debe".Value - Round((mvarDebe - mvarHaber), 2));
            //                                            mvarOk = true;
            //                                            break; //Warning!!! Review that break works as 'Exit Do' as it could be in a nested instruction like switch
            //                                        }
            //                                    }
            //                                    RegistroContable.MoveNext;
            //                                    if (!mvarOk)
            //                                    {
            //                                        RegistroContable.MoveLast;
            //                                        !IsNull(RegistroContable.Fields, "Debe".Value);
            //                                        RegistroContable.Fields;
            //                                        "Debe".Value = RegistroContable.Fields;
            //                                        ("Debe".Value - Round((mvarDebe - mvarHaber), 2));
            //                                    }
            //                                    else
            //                                    {
            //                                        RegistroContable.Fields;
            //                                        "Haber".Value = RegistroContable.Fields;
            //                                        ("Haber".Value + Round((mvarDebe - mvarHaber), 2));
            //                                    }
            //                                    if (RegistroContable.MoveFirst)
            //                                    {
            //                                        while (!RegistroContable.EOF)
            //                                        {
            //                                            Datos = CreateObject("object");
            //                                            for (i = 0; (i
            //                                                        <= (RegistroContable.Fields.Count - 1)); i++)
            //                                            {
            //                                                // With...
            //                                                i;
            //                                                Datos.Fields.Append.Name;
            //                                                RegistroContable.Fields.Type;
            //                                                RegistroContable.Fields.DefinedSize;
            //                                                RegistroContable.Fields.Attributes;
            //                                                Datos.Fields(RegistroContable.Fields.Name).Precision = RegistroContable.Fields.Precision;
            //                                                Datos.Fields(RegistroContable.Fields.Name).NumericScale = RegistroContable.Fields.NumericScale;
            //                                            }
            //                                            Datos.Open();
            //                                            Datos.AddNew();
            //                                            for (i = 0; (i
            //                                                        <= (RegistroContable.Fields.Count - 1)); i++)
            //                                            {
            //                                                // With...
            //                                                i;
            //                                                Datos.Fields(i).Value = RegistroContable.Fields.Value;
            //                                            }
            //                                            Datos.Fields("IdComprobante").Value = ComprobanteProveedor.Fields(0).Value;
            //                                            Datos.Fields("NumeroComprobante").Value = mvarNumeroReferencia;
            //                                            Datos.Update();
            //                                            Resp = oDet.Guardar("Subdiarios", Datos);
            //                                            Datos.Close();
            //                                            Datos = null.MoveNext();
            //                                        }
            //                                    }
            //                                    // With...
            //                                    if ((DetallesProvincias.State != adStateClosed))
            //                                    {
            //                                        if (!DetallesProvincias.EOF)
            //                                        {
            //                                            DetallesProvincias.Update;
            //                                            MoveFirst();
            //                                        }
            //                                        while (!DetallesProvincias.EOF.Fields)
            //                                        {
            //                                            "IdComprobanteProveedor".Value = ComprobanteProveedor.Fields(0).Value.Update();
            //                                            if (DetallesProvincias.Fields)
            //                                            {
            //                                                "Eliminado".Value;
            //                                                oDet.Eliminar("DetComprobantesProveedoresPrv", DetallesProvincias.Fields, 0.Value);
            //                                            }
            //                                            else
            //                                            {
            //                                                Datos = CreateObject("object");
            //                                                for (i = 0; (i
            //                                                            <= (DetallesProvincias.Fields.Count - 2)); i++)
            //                                                {
            //                                                    // With...
            //                                                    i;
            //                                                    Datos.Fields.Append.Name;
            //                                                    DetallesProvincias.Fields.Type;
            //                                                    DetallesProvincias.Fields.DefinedSize;
            //                                                    DetallesProvincias.Fields.Attributes;
            //                                                    Datos.Fields(DetallesProvincias.Fields.Name).Precision = DetallesProvincias.Fields.Precision;
            //                                                    Datos.Fields(DetallesProvincias.Fields.Name).NumericScale = DetallesProvincias.Fields.NumericScale;
            //                                                }
            //                                                Datos.Open();
            //                                                Datos.AddNew();
            //                                                for (i = 0; (i
            //                                                            <= (DetallesProvincias.Fields.Count - 2)); i++)
            //                                                {
            //                                                    // With...
            //                                                    i;
            //                                                    Datos.Fields(i).Value = DetallesProvincias.Fields.Value;
            //                                                }
            //                                                Datos.Update();
            //                                                Resp = oDet.Guardar("DetComprobantesProveedoresPrv", Datos);
            //                                                Datos.Close();
            //                                                Datos = null;
            //                                            }
            //                                            DetallesProvincias.MoveNext;
            //                                            // With...
            //                                            if (!(oCont == null))
            //                                            {
            //                                                // With...
            //                                                if (oCont.IsInTransaction)
            //                                                {
            //                                                    oCont.SetComplete;
            //                                                }
            //                                            // With...
            //                                            Salir:
            //                                                Guardar = Resp;
            //                                                oDet = null;
            //                                                oCont = null;
            //                                                oRsAux = null;
            //                                                // TODO: On Error GoTo 0 Warning!!!: The statement is not translatable 
            //                                                if (lErr)
            //                                                {
            //                                                    Err.Raise(lErr, sSource, sDesc);
            //                                                }
            //                                                // TODO: Exit Function: Warning!!! Need to return the value
            //                                                return;
            //                                            Mal:
            //                                                if (!(oCont == null))
            //                                                {
            //                                                    // With...
            //                                                    if (oCont.IsInTransaction)
            //                                                    {
            //                                                        oCont.SetAbort;
            //                                                    }
            //                                                    // With...
            //                                                    // With...
            //                                                    lErr = Err.Number;
            //                                                    sSource = Err.Source;
            //                                                    sDesc = Err.Description;
            //                                                    oDet.Tarea("Log_InsertarRegistro", Array("MTSCP", ComprobanteProveedor.Fields(0).Value, 0, Now, 0, ("Error "
            //                                                                        + (Err.Number
            //                                                                        + (Err.Description + (", " + Err.Source)))), ("MTSPronto "
            //                                                                        + (App.Major + (" "
            //                                                                        + (App.Minor + (" " + App.Revision)))))));
            //                                                    Salir;
            //                                                }
            //                                            }
            //                                        }
            //                                    }
            //                                }
            //                            }
            //                        }
            //                    }
            //                }
            //            }
            //        }
            //    }
            //}
        }


        /*
        public void Logica_Actualizaciones(ComprobanteProveedor o)
        {
            //if (!IsNull(ComprobanteProveedor.Fields("IdDiferenciaCambio").Value))
            //{
            //    oDet.Tarea("DiferenciasCambio_MarcarComoGenerada", Array(ComprobanteProveedor.Fields("IdDiferenciaCambio").Value, ComprobanteProveedor.Fields("IdTipoComprobante").Value, ComprobanteProveedor.Fields(0).Value));
            //}

            int mvarIdOrdenPagoActual = 0, mvarIdOrdenPagoAnterior = 0;
            string SC = "";

            if (mvarIdOrdenPagoActual != 0 || mvarIdOrdenPagoAnterior != 0)
            {
                EntidadManager.Tarea(SC, "OrdenesPago_ActualizarDiferenciaBalanceo", mvarIdOrdenPagoActual, mvarIdOrdenPagoAnterior);
            }


            // log
        }

        */

        public void Logica_EliminarRegistroAnterior(ComprobanteProveedor o) { }




        public void Logica_VB6_RegistroContable()
        {
            //object oSrv;
            //object oRs;
            //object oRsCont;
            //object oRsDet;
            //object oRsDetBD;
            //object oFld;
            //long mvarEjercicio;
            //long mvarCuentaCompras;
            //long mvarCuentaProveedor;
            //long mvarCuentaBonificaciones;
            //long mvarCuentaIvaInscripto;
            //long mvarCuentaIvaNoInscripto;
            //long mvarCuentaIvaSinDiscriminar;
            //long mvarCuentaComprasTitulo;
            //long mvarIdCuenta;
            //long mvarCuentaReintegros;
            //double mvarTotalCompra;
            //double mvarImporte;
            //double mvarDecimales;
            //double mvarPorcentajeIVA;
            //double mvarIVA1;
            //double mvarAjusteIVA;
            //double mvarTotalIVANoDiscriminado;
            //double mvarDebe;
            //double mvarHaber;
            //int mIdTipoComprobante;
            //int mCoef;
            //int i;
            //bool mvarEsta;
            //bool mvarSubdiarios_ResumirRegistros;




            //    oSrv = CreateObject("MTSPronto.General");
            //mIdTipoComprobante = Registro.Fields("IdTipoComprobante").Value;
            //oRs = oSrv.LeerUno("TiposComprobante", mIdTipoComprobante);
            //mCoef = oRs.Fields("Coeficiente").Value;
            //oRs.Close();
            //oRs = oSrv.LeerUno("Parametros", 1);
            //mvarEjercicio = oRs.Fields("EjercicioActual").Value;
            //mvarCuentaCompras = oRs.Fields("IdCuentaCompras").Value;
            //mvarCuentaComprasTitulo = oRs.Fields("IdCuentaComprasTitulo").Value;
            //mvarCuentaBonificaciones = oRs.Fields("IdCuentaBonificaciones").Value;
            //mvarCuentaIvaInscripto = oRs.Fields("IdCuentaIvaCompras").Value;
            //mvarCuentaIvaNoInscripto = oRs.Fields("IdCuentaIvaCompras").Value;
            //mvarCuentaIvaSinDiscriminar = oRs.Fields("IdCuentaIvaSinDiscriminar").Value;
            //mvarDecimales = oRs.Fields("Decimales").Value;
            //mvarCuentaProveedor = ( IsNull(oRs.Fields("IdCuentaAcreedoresVarios").Value) ? 0 : oRs.Fields("IdCuentaAcreedoresVarios").Value );


            //if ((IsNull(oRs.Fields("Subdiarios_ResumirRegistros").Value) 
            //            || (oRs.Fields("Subdiarios_ResumirRegistros").Value == "SI"))) {
            //    mvarSubdiarios_ResumirRegistros = true;
            //}
            //else {
            //    mvarSubdiarios_ResumirRegistros = false;
            //}
            //mvarCuentaReintegros = ( IsNull(oRs.Fields("IdCuentaReintegros").Value) ? 0 : oRs.Fields("IdCuentaReintegros").Value );
            //oRs.Close();
            //if (!IsNull(Registro.Fields("IdProveedor").Value)) {
            //    oRs = oSrv.LeerUno("Proveedores", Registro.Fields("IdProveedor").Value);
            //    if (!IsNull(oRs.Fields("IdCuenta").Value)) {
            //        mvarCuentaProveedor = oRs.Fields("IdCuenta").Value;
            //    }
            //    oRs.Close();
            //}
            //else if (!IsNull(Registro.Fields("IdCuenta").Value)) {
            //    mvarCuentaProveedor = Registro.Fields("IdCuenta").Value;
            //}
            //else if (!IsNull(Registro.Fields("IdCuentaOtros").Value)) {
            //    mvarCuentaProveedor = Registro.Fields("IdCuentaOtros").Value;
            //}
            //mvarAjusteIVA = ( IsNull(Registro.Fields("AjusteIVA").Value) ? 0 : Registro.Fields("AjusteIVA").Value );
            //oRsCont = CreateObject("ADOR.Recordset");
            //oRs = oSrv.TraerFiltrado("Subdiarios", "_Estructura");



            //// With...
            //foreach (oFld in oRs.Fields) {
            //    // With...
            //    oRsCont.Fields.Append.Name;
            //    oFld.Type;
            //    oFld.DefinedSize;
            //    oFld.Attributes;
            //    oRsCont.Fields.Item[oFld.Name].Precision = oFld.Precision;
            //    oRsCont.Fields.Item[oFld.Name].NumericScale = oFld.NumericScale;
            //}
            //oRsCont.Open();
            //oRs.Close();
            //if ((!IsNull(Registro.Fields("Confirmado").Value) 
            //            && (Registro.Fields("Confirmado").Value == "NO"))) {
            //    goto Salida;
            //}
            //// With...
            //if ((mCoef == 1)) {
            //    Fields("Haber").Value = Registro.Fields("TotalComprobante").Value;
            //    Registro.Fields("NumeroReferencia").Value.Fields("FechaComprobante").Value = Registro.Fields(0).Value;
            //    mIdTipoComprobante.Fields("NumeroComprobante").Value = Registro.Fields(0).Value;
            //    mvarCuentaProveedor.Fields("IdTipoComprobante").Value = Registro.Fields(0).Value;
            //    mvarCuentaComprasTitulo.Fields("IdCuenta").Value = Registro.Fields(0).Value;
            //    mvarEjercicio.Fields("IdCuentaSubdiario").Value = Registro.Fields(0).Value;
            //    oRsCont.AddNew().Fields("Ejercicio").Value = Registro.Fields(0).Value;
            //}
            //else {
            //    Fields("Debe").Value = Registro.Fields("TotalComprobante").Value;
            //}
            //Update();
            //if (!IsNull(Registro.Fields("TotalBonificacion").Value)) {
            //    if ((Registro.Fields("TotalBonificacion").Value != 0)) {
            //        // With...
            //        if ((mCoef == 1)) {
            //            Fields("Haber").Value = Registro.Fields("TotalBonificacion").Value;
            //            Registro.Fields("NumeroReferencia").Value.Fields("FechaComprobante").Value = Registro.Fields(0).Value;
            //            mIdTipoComprobante.Fields("NumeroComprobante").Value = Registro.Fields(0).Value;
            //            mvarCuentaBonificaciones.Fields("IdTipoComprobante").Value = Registro.Fields(0).Value;
            //            mvarCuentaComprasTitulo.Fields("IdCuenta").Value = Registro.Fields(0).Value;
            //            mvarEjercicio.Fields("IdCuentaSubdiario").Value = Registro.Fields(0).Value;
            //            oRsCont.AddNew().Fields("Ejercicio").Value = Registro.Fields(0).Value;
            //        }
            //        else {
            //            Fields("Debe").Value = Registro.Fields("TotalBonificacion").Value;
            //        }
            //        Update();
            //    }
            //}





            //oRsDet = this.DetComprobantesProveedores.Registros;
            //// With...
            //if ((oRsDet.Fields.Count > 0)) {
            //    if ((oRsDet.RecordCount > 0)) {
            //        oRsDet.MoveFirst;
            //        while (!oRsDet.EOF) {
            //            if (!oRsDet.Fields) {
            //                "Eliminado".Value;
            //                // With...
            //                mvarTotalIVANoDiscriminado = 0;
            //                for (i = 1; (i <= 10); i++) {
            //                    if ((oRsDet.Fields(("AplicarIVA" + i)).Value == "SI")) {
            //                        mvarImporte = oRsDet.Fields("Importe").Value;
            //                        mvarPorcentajeIVA = ( IsNull(oRsDet.Fields(("IVAComprasPorcentaje" + i)).Value) ? 0 : oRsDet.Fields(("IVAComprasPorcentaje" + i)).Value );
            //                        if (((Registro.Fields("Letra").Value == "A") 
            //                                    || (Registro.Fields("Letra").Value == "M"))) {
            //                            mvarIVA1 = Round((mvarImporte 
            //                                            * (mvarPorcentajeIVA / 100)), mvarDecimales);
            //                        }
            //                        else {
            //                            mvarIVA1 = Round(((mvarImporte / (1 
            //                                            + (mvarPorcentajeIVA / 100))) 
            //                                            * (mvarPorcentajeIVA / 100)), mvarDecimales);
            //                            mvarTotalIVANoDiscriminado = (mvarTotalIVANoDiscriminado + mvarIVA1);
            //                        }
            //                        if ((mvarAjusteIVA != 0)) {
            //                            mvarIVA1 = (mvarIVA1 + mvarAjusteIVA);
            //                            mvarAjusteIVA = 0;
            //                            Registro.Fields("PorcentajeIVAAplicacionAjuste").Value = mvarPorcentajeIVA;
            //                            Registro.Update();
            //                        }
            //                        mvarDebe = 0;
            //                        mvarHaber = 0;
            //                        if ((mCoef == 1)) {
            //                            if ((mvarIVA1 >= 0)) {
            //                                mvarDebe = mvarIVA1;
            //                            }
            //                            else {
            //                                mvarHaber = (mvarIVA1 * -1);
            //                            }
            //                        }
            //                        else if ((mvarIVA1 >= 0)) {
            //                            mvarHaber = mvarIVA1;
            //                        }
            //                        else {
            //                            mvarDebe = (mvarIVA1 * -1);
            //                        }
            //                        mvarEsta = false;
            //                        if ((oRsCont.RecordCount > 0)) {
            //                            oRsCont.MoveFirst;
            //                            while (!oRsCont.EOF) {
            //                                if (oRsCont.Fields) {
            //                                    "IdCuenta".Value = (oRsDet.Fields(("IdCuentaIvaCompras" + i)).Value 
            //                                                & (((mvarDebe != 0) 
            //                                                && !IsNull(oRsCont.Fields, "Debe".Value)) 
            //                                                || ((mvarHaber != 0) 
            //                                                && !IsNull(oRsCont.Fields, "Haber".Value))));
            //                                    mvarEsta = true;
            //                                    break; //Warning!!! Review that break works as 'Exit Do' as it could be in a nested instruction like switch
            //                                }
            //                                oRsCont.MoveNext;
            //                            }
            //                            if ((!mvarEsta 
            //                                        || !mvarSubdiarios_ResumirRegistros)) {
            //                                oRsCont.AddNew;
            //                            }
            //                            Registro.Fields("FechaRecepcion").Value.Fields("IdComprobante").Value = Registro.Fields(0).Value;
            //                            Registro.Fields("NumeroReferencia").Value.Fields("FechaComprobante").Value = Registro.Fields(0).Value;
            //                            mIdTipoComprobante.Fields("NumeroComprobante").Value = Registro.Fields(0).Value;
            //                            oRsDet.Fields(("IdCuentaIvaCompras" + i)).Value.Fields("IdTipoComprobante").Value = Registro.Fields(0).Value;
            //                            mvarCuentaComprasTitulo.Fields("IdCuenta").Value = Registro.Fields(0).Value;
            //                            mvarEjercicio.Fields("IdCuentaSubdiario").Value = Registro.Fields(0).Value;
            //                            Fields("Ejercicio").Value = Registro.Fields(0).Value;
            //                            if ((mvarDebe != 0)) {
            //                                oRsCont.Fields;
            //                                "Debe".Value = (IIf(IsNull(oRsCont.Fields, "Debe".Value), 0, oRsCont.Fields, "Debe".Value) + mvarDebe);
            //                            }
            //                            else {
            //                                oRsCont.Fields;
            //                                "Haber".Value = (IIf(IsNull(oRsCont.Fields, "Haber".Value), 0, oRsCont.Fields, "Haber".Value) + mvarHaber);
            //                            }
            //                            if (!mvarSubdiarios_ResumirRegistros) {
            //                                oRsCont.Fields;
            //                                "IdDetalleComprobante".Value = oRsDet.Fields(0).Value;
            //                            }
            //                            oRsCont.Update;
            //                            mvarDebe = 0;
            //                            mvarHaber = 0;
            //                            if ((mCoef == 1)) {
            //                                mvarDebe = (oRsDet.Fields("Importe").Value - mvarTotalIVANoDiscriminado);
            //                            }
            //                            else {
            //                                mvarHaber = (oRsDet.Fields("Importe").Value - mvarTotalIVANoDiscriminado);
            //                            }
            //                            mvarIdCuenta = mvarCuentaCompras;
            //                            if (!IsNull(oRsDet.Fields("IdCuenta").Value)) {
            //                                mvarIdCuenta = oRsDet.Fields("IdCuenta").Value;
            //                            }
            //                            mvarEsta = false;
            //                            if ((oRsCont.RecordCount > 0)) {
            //                                oRsCont.MoveFirst;
            //                                while (!oRsCont.EOF) {
            //                                    if (oRsCont.Fields) {
            //                                        "IdCuenta".Value = (mvarIdCuenta 
            //                                                    & (((mvarDebe != 0) 
            //                                                    && !IsNull(oRsCont.Fields, "Debe".Value)) 
            //                                                    || ((mvarHaber != 0) 
            //                                                    && !IsNull(oRsCont.Fields, "Haber".Value))));
            //                                        mvarEsta = true;
            //                                        break; //Warning!!! Review that break works as 'Exit Do' as it could be in a nested instruction like switch
            //                                    }
            //                                    oRsCont.MoveNext;
            //                                }
            //                                if ((!mvarEsta 
            //                                            || !mvarSubdiarios_ResumirRegistros)) {
            //                                    oRsCont.AddNew;
            //                                }
            //                                Registro.Fields("FechaRecepcion").Value.Fields("IdComprobante").Value = Registro.Fields(0).Value;
            //                                Registro.Fields("NumeroReferencia").Value.Fields("FechaComprobante").Value = Registro.Fields(0).Value;
            //                                mIdTipoComprobante.Fields("NumeroComprobante").Value = Registro.Fields(0).Value;
            //                                mvarIdCuenta.Fields("IdTipoComprobante").Value = Registro.Fields(0).Value;
            //                                mvarCuentaComprasTitulo.Fields("IdCuenta").Value = Registro.Fields(0).Value;
            //                                mvarEjercicio.Fields("IdCuentaSubdiario").Value = Registro.Fields(0).Value;
            //                                Fields("Ejercicio").Value = Registro.Fields(0).Value;
            //                                if ((mvarDebe != 0)) {
            //                                    if ((mvarDebe > 0)) {
            //                                        oRsCont.Fields;
            //                                        "Debe".Value = (IIf(IsNull(oRsCont.Fields, "Debe".Value), 0, oRsCont.Fields, "Debe".Value) + mvarDebe);
            //                                    }
            //                                    else {
            //                                        oRsCont.Fields;
            //                                        "Haber".Value = (IIf(IsNull(oRsCont.Fields, "Haber".Value), 0, oRsCont.Fields, "Haber".Value) 
            //                                                    + (mvarDebe * -1));
            //                                    }
            //                                }
            //                                else if ((mvarHaber > 0)) {
            //                                    oRsCont.Fields;
            //                                    "Haber".Value = (IIf(IsNull(oRsCont.Fields, "Haber".Value), 0, oRsCont.Fields, "Haber".Value) + mvarHaber);
            //                                }
            //                                else {
            //                                    oRsCont.Fields;
            //                                    "Debe".Value = (IIf(IsNull(oRsCont.Fields, "Debe".Value), 0, oRsCont.Fields, "Debe".Value) 
            //                                                + (mvarHaber * -1));
            //                                }
            //                                if (!mvarSubdiarios_ResumirRegistros) {
            //                                    oRsCont.Fields;
            //                                    "IdDetalleComprobante".Value = oRsDet.Fields(0).Value;
            //                                }
            //                                oRsCont.Update;
            //                                // With...
            //                                oRsCont.MoveNext;
            //                            }
            //                        }
            //                    }
            //                    oRsDetBD = oSrv.TraerFiltrado("DetComprobantesProveedores", "_PorIdCabecera", Registro.Fields(0).Value);
            //                    // With...
            //                    if ((oRsDetBD.RecordCount > 0)) {
            //                        oRsDetBD.MoveFirst;
            //                        while (!oRsDetBD.EOF) {
            //                            mvarEsta = false;
            //                            if ((oRsDet.Fields.Count > 0)) {
            //                                if ((oRsDet.RecordCount > 0)) {
            //                                    oRsDet.MoveFirst();
            //                                    while (!oRsDet.EOF) {
            //                                        if (oRsDetBD.Fields) {
            //                                            0.Value = oRsDet.Fields(0).Value;
            //                                            mvarEsta = true;
            //                                            break; //Warning!!! Review that break works as 'Exit Do' as it could be in a nested instruction like switch
            //                                        }
            //                                        oRsDet.MoveNext();
            //                                    }
            //                                }
            //                            }
            //                            if (!mvarEsta) {
            //                                // With...
            //                                if (!IsNull(oRsDetBD.Fields("IdCuenta").Value)) {
            //                                    Fields("IdCuenta").Value = oRsDetBD.Fields("IdCuenta").Value;
            //                                    oRsCont.AddNew().Fields("Ejercicio").Value = mvarCuentaComprasTitulo;
            //                                }
            //                                else {
            //                                    Fields("IdCuenta").Value = mvarCuentaCompras;
            //                                }
            //                                Registro.Fields("FechaRecepcion").Value.Fields("IdComprobante").Value = Registro.Fields(0).Value;
            //                                Registro.Fields("NumeroReferencia").Value.Fields("FechaComprobante").Value = Registro.Fields(0).Value;
            //                                mIdTipoComprobante.Fields("NumeroComprobante").Value = Registro.Fields(0).Value;
            //                                Fields("IdTipoComprobante").Value = Registro.Fields(0).Value;
            //                                if ((mCoef == 1)) {
            //                                    Fields("Debe").Value = (oRsDetBD.Fields("Importe").Value - mvarTotalIVANoDiscriminado);
            //                                }
            //                                else {
            //                                    Fields("Haber").Value = (oRsDetBD.Fields("Importe").Value - mvarTotalIVANoDiscriminado);
            //                                }
            //                                if (!mvarSubdiarios_ResumirRegistros) {
            //                                    Fields("IdDetalleComprobante").Value = oRsDetBD.Fields(0).Value;
            //                                }
            //                                Update();
            //                                mvarTotalIVANoDiscriminado = 0;
            //                                for (i = 1; (i <= 10); i++) {
            //                                    if ((oRsDetBD.Fields(("AplicarIVA" + i)).Value == "SI")) {
            //                                        mvarImporte = oRsDetBD.Fields("Importe").Value;
            //                                        mvarPorcentajeIVA = ( IsNull(oRsDetBD.Fields(("IVAComprasPorcentaje" + i)).Value) ? 0 : oRsDetBD.Fields(("IVAComprasPorcentaje" + i)).Value );
            //                                        if (((Registro.Fields("Letra").Value == "A") 
            //                                                    || (Registro.Fields("Letra").Value == "M"))) {
            //                                            mvarIVA1 = Round((mvarImporte 
            //                                                            * (mvarPorcentajeIVA / 100)), mvarDecimales);
            //                                        }
            //                                        else {
            //                                            mvarIVA1 = Round(((mvarImporte / (1 
            //                                                            + (mvarPorcentajeIVA / 100))) 
            //                                                            * (mvarPorcentajeIVA / 100)), mvarDecimales);
            //                                            mvarTotalIVANoDiscriminado = (mvarTotalIVANoDiscriminado + mvarIVA1);
            //                                        }
            //                                        if ((mvarAjusteIVA != 0)) {
            //                                            mvarIVA1 = (mvarIVA1 + mvarAjusteIVA);
            //                                            mvarAjusteIVA = 0;
            //                                            Registro.Fields("PorcentajeIVAAplicacionAjuste").Value = mvarPorcentajeIVA;
            //                                            Registro.Update();
            //                                        }
            //                                        Registro.Fields("FechaRecepcion").Value.Fields("IdComprobante").Value = Registro.Fields(0).Value;
            //                                        Registro.Fields("NumeroReferencia").Value.Fields("FechaComprobante").Value = Registro.Fields(0).Value;
            //                                        mIdTipoComprobante.Fields("NumeroComprobante").Value = Registro.Fields(0).Value;
            //                                        oRsDetBD.Fields(("IdCuentaIvaCompras" + i)).Value.Fields("IdTipoComprobante").Value = Registro.Fields(0).Value;
            //                                        mvarCuentaComprasTitulo.Fields("IdCuenta").Value = Registro.Fields(0).Value;
            //                                        mvarEjercicio.Fields("IdCuentaSubdiario").Value = Registro.Fields(0).Value;
            //                                        AddNew().Fields("Ejercicio").Value = Registro.Fields(0).Value;
            //                                        if ((mCoef == 1)) {
            //                                            if ((mvarIVA1 >= 0)) {
            //                                                Fields("Debe").Value = mvarIVA1;
            //                                            }
            //                                            else {
            //                                                Fields("Haber").Value = (mvarIVA1 * -1);
            //                                            }
            //                                        }
            //                                        else if ((mvarIVA1 >= 0)) {
            //                                            Fields("Haber").Value = mvarIVA1;
            //                                        }
            //                                        else {
            //                                            Fields("Debe").Value = (mvarIVA1 * -1);
            //                                        }
            //                                        if (!mvarSubdiarios_ResumirRegistros) {
            //                                            Fields("IdDetalleComprobante").Value = oRsDetBD.Fields(0).Value;
            //                                        }
            //                                        Update();
            //                                    }
            //                                }
            //                            }
            //                            oRsDetBD.MoveNext;
            //                        }
            //                        oRsDetBD.Close;
            //                        // With...
            //                        if ((oRsDet.Fields.Count > 0)) {
            //                            oRsDet.Close();
            //                        }
            //                        if (!IsNull(Registro.Fields("ReintegroIdCuenta").Value)) {
            //                            if ((Registro.Fields("ReintegroImporte").Value != 0)) {
            //                                // With...
            //                                if ((mCoef == 1)) {
            //                                    Fields("Haber").Value = Registro.Fields("ReintegroImporte").Value;
            //                                    Registro.Fields("NumeroReferencia").Value.Fields("FechaComprobante").Value = Registro.Fields(0).Value;
            //                                    mIdTipoComprobante.Fields("NumeroComprobante").Value = Registro.Fields(0).Value;
            //                                    mvarCuentaReintegros.Fields("IdTipoComprobante").Value = Registro.Fields(0).Value;
            //                                    mvarCuentaComprasTitulo.Fields("IdCuenta").Value = Registro.Fields(0).Value;
            //                                    mvarEjercicio.Fields("IdCuentaSubdiario").Value = Registro.Fields(0).Value;
            //                                    oRsCont.AddNew().Fields("Ejercicio").Value = Registro.Fields(0).Value;
            //                                }
            //                                else {
            //                                    Fields("Debe").Value = Registro.Fields("ReintegroImporte").Value;
            //                                }
            //                                Registro.Fields("FechaRecepcion").Value.Fields("IdComprobante").Value = Registro.Fields(0).Value;
            //                                Registro.Fields("NumeroReferencia").Value.Fields("FechaComprobante").Value = Registro.Fields(0).Value;
            //                                mIdTipoComprobante.Fields("NumeroComprobante").Value = Registro.Fields(0).Value;
            //                                Registro.Fields("ReintegroIdCuenta").Value.Fields("IdTipoComprobante").Value = Registro.Fields(0).Value;
            //                                mvarCuentaComprasTitulo.Fields("IdCuenta").Value = Registro.Fields(0).Value;
            //                                mvarEjercicio.Fields("IdCuentaSubdiario").Value = Registro.Fields(0).Value;
            //                                Update().AddNew().Fields("Ejercicio").Value = Registro.Fields(0).Value;
            //                                if ((mCoef == 1)) {
            //                                    Fields("Debe").Value = Registro.Fields("ReintegroImporte").Value;
            //                                }
            //                                else {
            //                                    Fields("Haber").Value = Registro.Fields("ReintegroImporte").Value;
            //                                }
            //                                Update();
            //                            }
            //                        }

            //                    Salida:
            //                        RegistroContable = oRsCont;
            //                        oRsDet = null;
            //                        oRs = null;
            //                        oRsCont = null;
            //                        oSrv = null;
            //                    }
            //                }
            //            }
            //        }
            //    }
            //}
        }
        /*
        public void Logica_AsientoRegistroContable(ComprobanteProveedor o)
        {

            if ((o.Confirmado ?? "NO") != "SI") return;


            if (true)
            {
                Logica_EliminarRegistroAnterior(o);
            }


            //        Public Function RegistroContable() As ador.Recordset

            //   Dim oSrv As InterFazMTS.iCompMTS
            //   Dim oRs As ador.Recordset
            //   Dim oRsAux As ador.Recordset
            //   Dim oRsCont As ador.Recordset
            //   Dim oRsDet As ador.Recordset
            //   Dim oRsDetBD As ador.Recordset
            //   Dim oFld As ador.Field
            //   Dim mvarEjercicio As Long, mvarCuentaVentas As Long, mvarCuentaCliente As Long, mvarCuentaBonificaciones As Long
            //   Dim mvarCuentaIvaInscripto As Long, mvarCuentaIvaNoInscripto As Long, mvarCuentaIvaSinDiscriminar As Long
            //   Dim mvarCuentaRetencionIBrutosBsAs As Long, mvarCuentaRetencionIBrutosCap As Long, mvarCuentaVentasTitulo As Long
            long mvarCuentaReventas, mvarCuentaIvaInscripto1 = 0, mvarCuentaPercepcionIIBB;
            int mIdTipoComprobante, mCoef = 0;
            decimal mvarAjusteIVA = 0;
            decimal mvarIVA1 = 0;
            //   Dim mvarCuentaOtrasPercepciones1 As Long, mvarCuentaOtrasPercepciones2 As Long, mvarCuentaOtrasPercepciones3 As Long
            //   Dim mvarCuentaPercepcionesIVA As Long
            //   Dim mvarCuentaIvaVenta(4, 2) As Long
            int mvarDecimales;
            //   Dim i As Integer, mvarIdMonedaPesos As Integer
            decimal mvarTotalIVANoDiscriminado;
            decimal mvarDebe = 0, mvarHaber;
            decimal mvarIvaNoDiscriminado, mvarSubtotal, mvarNetoGravadoItem, mvarAjusteIva;
            decimal mvarPorcentajeIVA; // , mvarIVA1 , mvarAjusteIVA ;

            //   Dim mvarNetoGravadoItemSuma As Double


            bool mvarEsta;
            bool mvarSubdiarios_ResumirRegistros = false;
            DateTime mvarFecha;

            //   Set oSrv = CreateObject("MTSPronto.General")

            Parametros parametros = fondoFijoService.Parametros();
            var mvarEjercicio = parametros.EjercicioActual ?? 0;
            var mvarCuentaVentas = parametros.IdCuentaVentas ?? 0;
            var mvarCuentaVentasTitulo = parametros.IdCuentaVentasTitulo ?? 0;
            var mvarCuentaBonificaciones = parametros.IdCuentaBonificaciones ?? 0;
            var mvarCuentaIvaInscripto = parametros.IdCuentaIvaInscripto ?? 0;
            var mvarCuentaIvaNoInscripto = parametros.IdCuentaIvaNoInscripto ?? 0;
            var mvarCuentaIvaSinDiscriminar = parametros.IdCuentaIvaSinDiscriminar ?? 0;
            var mvarCuentaRetencionIBrutosBsAs = parametros.IdCuentaRetencionIBrutosBsAs ?? 0;
            var mvarCuentaRetencionIBrutosCap = parametros.IdCuentaRetencionIBrutosCap ?? 0;
            mvarCuentaReventas = parametros.IdCuentaReventas ?? 0;
            var mvarCuentaOtrasPercepciones1 = parametros.IdCuentaOtrasPercepciones1 ?? 0;
            var mvarCuentaOtrasPercepciones2 = parametros.IdCuentaOtrasPercepciones2 ?? 0;
            var mvarCuentaOtrasPercepciones3 = parametros.IdCuentaOtrasPercepciones3 ?? 0;
            var mvarCuentaPercepcionesIVA = parametros.IdCuentaPercepcionesIVA ?? 0;
            var mvarCuentaCliente = parametros.IdCuentaDeudoresVarios ?? 0;
            var mvarIdMonedaPesos = parametros.IdMoneda ?? 1;

            var mvarCuentaReintegros = parametros.IdCuentaReintegros ?? 0;
            var mvarCuentaComprasTitulo = parametros.IdCuentaComprasTitulo ?? 0;
            var mvarCuentaProveedor = parametros.IdCuentaAcreedoresVarios ?? 0;


            ProntoMVC.Data.Models.Subdiario oRs = new Subdiario();



            if (o.IdProveedor != null)          // cta cte
            {
                var aa = fondoFijoService.Proveedores.Find(o.IdProveedor);
                mvarCuentaProveedor = aa.IdCuenta ?? 0;
            }
            else if (o.IdCuenta != null)        // fondo fijo
            {
                mvarCuentaProveedor = o.IdCuenta ?? 0;
            }
            else if (o.IdCuentaOtros != null)   // otros
            {
                mvarCuentaProveedor = o.IdCuentaOtros ?? 0;
            }
            else
            {
                throw new Exception("asdasd");
            }




            //var mvarFecha = o.ContabilizarAFechaVencimiento == "SI" ? o.FechaVencimiento : o.FechaFactura;

            //mvarSubtotal = (double)(o.ImporteTotal ?? 0 - o.ImporteIva1 ?? 0 -
            //                   o.ImporteIva2 ?? 0 - o.RetencionIBrutos1 -
            //                   o.RetencionIBrutos2 ?? 0 - o.RetencionIBrutos3 ?? 0 -
            //                   o.OtrasPercepciones1 ?? 0 -
            //                    o.OtrasPercepciones2 ?? 0 -
            //                    o.OtrasPercepciones3 ?? 0 -
            //                   o.PercepcionIVA ?? 0 -
            //                   o.AjusteIva ?? 0 +
            //                   o.ImporteBonificacion ?? 0);
            var mvarNetoGravadoItemSuma = 0;


            List<Subdiario> asiento = new List<Subdiario>();




            string detalle = (fondoFijoService.TiposComprobantes.Find(o.IdTipoComprobante) ?? new TiposComprobante()).DescripcionAb;
            detalle += o.Letra + '-' + o.NumeroComprobante1.NullSafeToString().PadLeft(4, '0') + '-' + o.NumeroComprobante2.NullSafeToString().PadLeft(8, '0');




            // cómo se forma el asiento????
            // el fondo fijo quedaría así:
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //                          DEBE                                    //               HABER                  //
            //                                                                  //                                      //
            //                                                                  //     total a cuenta de fondo fijo     //
            // subtotal item1 cuenta gasto                                      //                                      //
            // subtotal item2 cuenta gasto                                      //                                      //
            // ivas de esos items (un movimiento por tipo                       //                                      //
            //                                iva y por item)                   //                                      //
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////



            // cuenta del proveedor o del fondo fijo?
            // -este movimiento se hace por el total, así que debe ser el de fondo fijo, no?   -Sí. mvarCuentaProveedor depende del tipo de comprobante
            //el totalcomprobante no esta incluyendo el iva 
            asiento.Add(movimient(mvarEjercicio,
                                mvarCuentaComprasTitulo,
                                mvarCuentaProveedor,
                                o.IdTipoComprobante, o.NumeroReferencia, o.FechaRecepcion, o.IdComprobanteProveedor,
                                o.TotalComprobante, o.IdMoneda, o.CotizacionMoneda, detalle));




            if (o.TotalBonificacion > 0)
            {
                asiento.Add(movimient(mvarEjercicio, mvarCuentaComprasTitulo,
                                mvarCuentaBonificaciones,
                                o.IdTipoComprobante, o.NumeroReferencia, o.FechaRecepcion, o.IdComprobanteProveedor,
                                o.TotalComprobante, o.IdMoneda, o.CotizacionMoneda, detalle));
            }




            foreach (DetalleComprobantesProveedore i in o.DetalleComprobantesProveedores)
            {

                mvarTotalIVANoDiscriminado = 0;



                for (int n = 1; n <= 10; n++)
                {


                    //            mvarImporte = oRsDet.Fields("Importe").Value
                    //mvarPorcentajeIVA = IIf(IsNull(oRsDet.Fields("IVAComprasPorcentaje" & i).Value), 0, oRsDet.Fields("IVAComprasPorcentaje" & i).Value)

                    var pAplicarIVA = i.GetType().GetProperty("AplicarIVA" + n);
                    string AplicarIVAval = (string)pAplicarIVA.GetValue(i, null);

                    var pIVAComprasPorcentaje = i.GetType().GetProperty("IVAComprasPorcentaje" + n);
                    decimal IVAComprasPorcentajeval = (decimal)(pIVAComprasPorcentaje.GetValue(i, null) ?? 0M);

                    var pIdCuentaIVACompras = i.GetType().GetProperty("IdCuentaIvaCompras" + n);
                    int IdCuentaIVACompras = (int)(pIdCuentaIVACompras.GetValue(i, null) ?? 0);

                    if (IdCuentaIVACompras == 0)
                    {
                        IdCuentaIVACompras = Busca_IdCuentaIVACompras_segun_Porcentaje(IVAComprasPorcentajeval);
                        pIdCuentaIVACompras.SetValue(i, IdCuentaIVACompras, null);
                    }





                    //prop.SetValue(


                    if (AplicarIVAval != "SI") continue;


                    mvarDecimales = 2;
                    decimal mvarImporte = i.Importe ?? 0;
                    mvarPorcentajeIVA = IVAComprasPorcentajeval;


                    if (o.Letra == "A" || o.Letra == "M")
                    {
                        mvarIVA1 = Math.Round(mvarImporte * mvarPorcentajeIVA / 100, mvarDecimales);
                    }
                    else
                    {
                        mvarIVA1 = Math.Round((mvarImporte / (1 + (mvarPorcentajeIVA / 100))) * (mvarPorcentajeIVA / 100), mvarDecimales);
                        mvarTotalIVANoDiscriminado = mvarTotalIVANoDiscriminado + mvarIVA1;
                    }

                    if (mvarAjusteIVA != 0)
                    {
                        mvarIVA1 = mvarIVA1 + mvarAjusteIVA;
                        mvarAjusteIVA = 0;
                        o.PorcentajeIVAAplicacionAjuste = mvarPorcentajeIVA;
                    }


                    mvarDebe = 0;
                    mvarHaber = 0;

                    if (mCoef == 1)
                    {
                        if (mvarIVA1 >= 0)
                        {
                            mvarDebe = mvarIVA1;
                        }
                        else
                        {
                            mvarHaber = mvarIVA1 * -1;
                        }
                    }
                    else
                    {
                        if (mvarIVA1 >= 0)
                        {
                            mvarHaber = mvarIVA1;
                        }
                        else
                        {
                            mvarDebe = mvarIVA1 * -1;
                        }
                    }



                    ////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////
                    //acá podría usar una funcion que se llame BuscarMovimiento:
                    ////////////////////////////////////////

                    mvarEsta = false;
                    if (asiento.Count > 0)
                    {
                        //    // acá qué está revisando? en que registros se está paseando???? -se está paseando por los movimientos del asiento
                        //foreach(m as Subdiario in asiento)  {

                        //    if ( m.idcuenta== oRsDet.Fields("IdCuentaIvaCompras" & i).Value && 
                        //        ((mvarDebe <> 0 And Not IsNull(.Fields("Debe").Value)) || 
                        //            (mvarHaber <> 0 And Not IsNull(.Fields("Haber").Value))) ) {
                        //    mvarEsta = True 
                        // break;
                        //}

                        //}
                    }

                    Subdiario mov = null;

                    if (!mvarEsta || !mvarSubdiarios_ResumirRegistros) mov = new Subdiario();

                    ////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////





                    if (mvarDebe != 0)
                    {
                        mov.Debe += mvarDebe;
                    }
                    else
                    {
                        mov.Haber += mvarHaber;
                    }
                    //If Not mvarSubdiarios_ResumirRegistros Then
                    //    .Fields("IdDetalleComprobante").Value = oRsDet.Fields(0).Value
                    //End If






                    // se agrega movimiento de cada IVA distinto del item???? -exacto. un movimiento por cada tipo de 
                    // impuesto del item, y afuera este "for" tenes un movimiento del item por el subtotal


                    mov = movimient(mvarEjercicio,
                                    mvarCuentaComprasTitulo,
                                    IdCuentaIVACompras,
                                    o.IdTipoComprobante, o.NumeroReferencia,
                                    o.FechaRecepcion, o.IdComprobanteProveedor,
                                 -mvarIVA1, o.IdMoneda, o.CotizacionMoneda, detalle);


                    asiento.Add(mov);

                }








                mvarDebe = 0;
                mvarHaber = 0;

                if (mCoef == 1)
                {

                    mvarDebe = i.Importe ?? 0 - mvarTotalIVANoDiscriminado;


                }
                else
                {
                    mvarHaber = i.Importe ?? 0 - mvarTotalIVANoDiscriminado;

                }


                // mvarIdCuenta = mvarCuentaCompras;
                // If Not IsNull(oRsDet.Fields("IdCuenta").Value) Then
                //    mvarIdCuenta = oRsDet.Fields("IdCuenta").Value
                // End If




                //mvarEsta = False
                // If .RecordCount > 0 Then
                //    .MoveFirst
                //    Do While Not .EOF
                //       If .Fields("IdCuenta").Value = mvarIdCuenta And _
                //             ((mvarDebe <> 0 And Not IsNull(.Fields("Debe").Value)) Or _
                //                (mvarHaber <> 0 And Not IsNull(.Fields("Haber").Value))) Then
                //          mvarEsta = True
                //          Exit Do
                //       End If
                //       .MoveNext
                //    Loop
                // End If
                // If Not mvarEsta Or Not mvarSubdiarios_ResumirRegistros Then .AddNew



                // .Fields("Ejercicio").Value = mvarEjercicio
                // .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
                // .Fields("IdCuenta").Value = mvarIdCuenta
                // .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                // .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
                // .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
                // .Fields("IdComprobante").Value = Registro.Fields(0).Value




                //If mvarDebe <> 0 Then
                //    If mvarDebe > 0 Then
                //       .Fields("Debe").Value = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value) + mvarDebe
                //    Else
                //       .Fields("Haber").Value = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value) + (mvarDebe * -1)
                //    End If
                // Else
                //    If mvarHaber > 0 Then
                //       .Fields("Haber").Value = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value) + mvarHaber
                //    Else
                //       .Fields("Debe").Value = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value) + (mvarHaber * -1)
                //    End If
                // End If
                // If Not mvarSubdiarios_ResumirRegistros Then
                //    .Fields("IdDetalleComprobante").Value = oRsDet.Fields(0).Value
                // End If
                // .Update



                /////////////////////////////////////////////////////////////////////////////
                // acá se agrega otro asiento??????? -claro, los asientos del 
                // bucle de 1 a 10 de IVAs era para los impuestos del item; esto es para el subtotal del item

                mvarTotalIVANoDiscriminado = 0; // corregir. lo dejo así para debug

                asiento.Add(movimient(mvarEjercicio,
                    mvarCuentaComprasTitulo, i.IdCuenta,
                     o.IdTipoComprobante, o.NumeroReferencia,
                     o.FechaRecepcion, o.IdComprobanteProveedor,
                   -i.Importe + mvarTotalIVANoDiscriminado, o.IdMoneda, o.CotizacionMoneda, detalle));




            }



            // qué revisa acá??????? -supongo que es por los que se grabaron antes, si es una edicion
            //Set oRsDetBD = oSrv.TraerFiltrado("DetComprobantesProveedores", "_PorIdCabecera", Registro.Fields(0).Value)

            //            asiento .Add ( movimient(mvarEjercicio, 
            //               o.mvarCuentaComprasTitulo , i.IdCuenta ?? mvarCuentaCompras, 
            //               o.IdTipoComprobante, o.NumeroReferencia, 
            //               o.FechaRecepcion, o.IdComprobanteProveedor,
            //               o.mvarTotalIVANoDiscriminado));





            ////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////
            //reintegro
            ////////////////////////////////////////////////////////
            asiento.Add(movimient(mvarEjercicio,
                            mvarCuentaComprasTitulo, mvarCuentaReintegros,
                            o.IdTipoComprobante, o.NumeroReferencia,
                            o.FechaRecepcion, o.IdComprobanteProveedor,
                            o.ReintegroImporte, o.IdMoneda, o.CotizacionMoneda, detalle));







            if (ValidarAsiento(asiento))
            {
                if (o.IdComprobanteProveedor > 0)
                {
                    var q = fondoFijoService.Subdiarios.Where(x =>
                                                         x.NumeroComprobante == o.NumeroReferencia &&
                                                        (x.IdTipoComprobante == o.IdTipoComprobante)
                                                    ).ToList();
                    q.ForEach(x => fondoFijoService.Subdiarios.Remove(x));
                }


                foreach (var m in asiento)
                {
                    fondoFijoService.Subdiarios.Add(m);
                }
            }



            // verificar que el asiento da 0
            // verificar que el asiento da 0
            // verificar que el asiento da 0
            // verificar que el asiento da 0
            // verificar que el asiento da 0
            // http://stackoverflow.com/questions/3627801/is-it-possible-to-see-added-entities-from-an-unsaved-ef4-context
            //var addedCustomers = from se in fondoFijoService.ObjectContext.get fondoFijoService.ObjectStateManager.GetObjectStateEntries(System.Data.Entity.EntityState.Added)
            //     where se.Entity is Subdiario
            //     select se.Entity;

        }
        */



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

            // if distinct o[0].IdCuenta  throw new Exception("Solo puede haber un movimiento por cuenta"); ; // lo agrupo automaticamente yo???


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
            //ObjectContext oCont;
            //iCompMTS oDet;
            //InterFazMTS.MisEstados Resp;
            //ADOR.Recordset oRsComprobante;
            //ADOR.Recordset Datos;
            //ADOR.Recordset DatosAsiento;
            //ADOR.Recordset DatosAsientoNv;
            //ADOR.Recordset oRsParametros;
            //ADOR.Recordset DatosDetAsiento;
            //ADOR.Recordset DatosDetAsientoNv;
            //ADOR.Field oFld;
            //long lErr;
            //string sSource;
            //string sDesc;
            //int i;
            //long mvarNumeroAsiento;
            //long mvarIdAsiento;
            //long mvarIdCuenta;
            //double mvarCotizacionMoneda;
            //double mvarDebe;
            //double mvarHaber;
            //// TODO: On Error GoTo Warning!!!: The statement is not translatable 
            //oCont = GetObjectContext;
            //if ((oCont == null))
            //{
            //    oDet = CreateObject("MTSPronto.General");
            //}
            //else
            //{
            //    oDet = oCont.CreateInstance("MTSPronto.General");
            //}
            //mvarCotizacionMoneda = 0;
            //mvarDebe = 0;
            //mvarHaber = 0;
            //// With...
            //if ((RegistroContable.State != adStateClosed))
            //{
            //    if ((RegistroContable.RecordCount > 0))
            //    {
            //        RegistroContable.Update;
            //        MoveFirst();
            //        oRsComprobante = oDet.LeerUno("ComprobantesProveedores", RegistroContable.Fields("IdComprobante").Value);
            //        mvarCotizacionMoneda = oRsComprobante.Fields("CotizacionMoneda").Value;
            //        oRsComprobante.Close();
            //        oRsComprobante = null;
            //    }
            //    while (!RegistroContable.EOF)
            //    {
            //        if (!IsNull(RegistroContable.Fields, "Debe".Value))
            //        {
            //            RegistroContable.Fields;
            //            "Debe".Value = RegistroContable.Fields;
            //            ("Debe".Value * mvarCotizacionMoneda.Update());
            //            mvarDebe = (mvarDebe + RegistroContable.Fields);
            //            "Debe".Value;
            //        }
            //        if (!IsNull(RegistroContable.Fields, "Haber".Value))
            //        {
            //            RegistroContable.Fields;
            //            "Haber".Value = RegistroContable.Fields;
            //            ("Haber".Value * mvarCotizacionMoneda.Update());
            //            mvarHaber = (mvarHaber + RegistroContable.Fields);
            //            "Haber".Value;
            //        }
            //        RegistroContable.MoveNext;
            //        if ((RegistroContable.RecordCount > 0))
            //        {
            //            RegistroContable.MoveLast;
            //            ((mvarDebe - mvarHaber)
            //                        != 0);
            //            if (!IsNull(RegistroContable.Fields, "Debe".Value))
            //            {
            //                RegistroContable.Fields;
            //                "Debe".Value = RegistroContable.Fields;
            //                ("Debe".Value
            //                            - (mvarDebe - mvarHaber));
            //            }
            //            else
            //            {
            //                RegistroContable.Fields;
            //                "Haber".Value = RegistroContable.Fields;
            //                ("Haber".Value
            //                            + (mvarDebe - mvarHaber));
            //            }
            //        }
            //        RegistroContable.MoveFirst;
            //        while (!RegistroContable.EOF)
            //        {
            //            Datos = CreateObject("ADOR.Recordset");
            //            for (i = 0; (i
            //                        <= (RegistroContable.Fields.Count - 1)); i++)
            //            {
            //                // With...
            //                i;
            //                Datos.Fields.Append.Name;
            //                RegistroContable.Fields.Type;
            //                RegistroContable.Fields.DefinedSize;
            //                RegistroContable.Fields.Attributes;
            //                Datos.Fields(RegistroContable.Fields.Name).Precision = RegistroContable.Fields.Precision;
            //                Datos.Fields(RegistroContable.Fields.Name).NumericScale = RegistroContable.Fields.NumericScale;
            //            }
            //            Datos.Open();
            //            Datos.AddNew();
            //            for (i = 0; (i
            //                        <= (RegistroContable.Fields.Count - 1)); i++)
            //            {
            //                // With...
            //                i;
            //                Datos.Fields(i).Value = RegistroContable.Fields.Value;
            //            }
            //            Datos.Update();
            //            Resp = oDet.Guardar("Subdiarios", Datos);
            //            Datos.Close();
            //            Datos = null.MoveNext();
            //        }
            //        // With...
            //        if (!(oCont == null))
            //        {
            //            // With...
            //            if (oCont.IsInTransaction)
            //            {
            //                oCont.SetComplete;
            //            }
            //        // With...
            //        Salir:
            //            GuardarRegistroContable = Resp;
            //            oDet = null;
            //            oCont = null;
            //            // TODO: On Error GoTo 0 Warning!!!: The statement is not translatable 
            //            if (lErr)
            //            {
            //                Err.Raise(lErr, sSource, sDesc);
            //            }
            //            // TODO: Exit Function: Warning!!! Need to return the value
            //            return;
            //        Mal:
            //            if (!(oCont == null))
            //            {
            //                // With...
            //                if (oCont.IsInTransaction)
            //                {
            //                    oCont.SetAbort;
            //                }
            //                // With...
            //                // With...
            //                lErr = Err.Number;
            //                sSource = Err.Source;
            //                sDesc = Err.Description;
            //                Salir;
            //            }
            //        }
            //    }
            //}
        }



        /*
        public void Logica_ActualizarCuentaCorriente(ComprobanteProveedor o)
        {

            var mImporteAnterior = 0;
            var mTotalAnteriorDolar = 0;


            ProntoMVC.Data.Models.CuentasCorrientesDeudor a = new CuentasCorrientesDeudor();





            //if (o.IdFactura <= 0)
            //{
            //    //            mImporteAnterior = iisNull(.Item("ImporteTotal"), 0)
            //    //            mTotalAnteriorDolar = iisNull(.Item("ImporteTotalDolar"), 0)
            //}
            //a.IdCliente = o.IdCliente;
            //a.NumeroComprobante = o.NumeroFactura;
            //a.Fecha = o.FechaFactura; // mvarFecha;
            //a.IdTipoComp = 1;
            //a.FechaVencimiento = o.FechaVencimiento;
            //a.IdComprobante = o.IdFactura;
            //a.Cotizacion = o.CotizacionDolar;
            //a.IdMoneda = o.IdMoneda;
            //a.CotizacionMoneda = o.CotizacionMoneda;

            //if (o.Anulada == "SI")
            //{
            //    a.ImporteTotal = 0;
            //    a.Saldo = 0;
            //    a.ImporteTotalDolar = 0;
            //    a.SaldoDolar = 0;
            //}
            //else
            //{
            //    a.ImporteTotal = Math.Round(o.ImporteTotal * o.CotizacionMoneda ?? 0, 2);
            //    a.Saldo = Math.Round(o.ImporteTotal * o.CotizacionMoneda ?? 0, 2) - mImporteAnterior;
            //    a.ImporteTotalDolar = o.ImporteTotal * o.CotizacionMoneda / o.CotizacionDolar;
            //    a.SaldoDolar = (o.ImporteTotal * o.CotizacionMoneda / o.CotizacionDolar) - mTotalAnteriorDolar;
            //}

            //fondoFijoService.CuentasCorrientesDeudores.Add(a);


            // ?????  a.IdImputacion=


            //    '////////////////////////////
            //    'cambio el saldo en la entidad cliente
            ////    '////////////////////////////
            //if (o.IdCliente > 0)
            //{
            //    var c = fondoFijoService.Clientes.Find(o.IdCliente);

            //    if (o.Anulada == "SI")
            //    {
            //        c.Saldo += -mImporteAnterior;
            //    }
            //    else
            //    {
            //        c.Saldo += -mImporteAnterior + Math.Round((o.ImporteTotal ?? 0) * (o.CotizacionMoneda ?? 0), 2);
            //    }


            //}






        }



        */








        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


















        void inic(ref ComprobanteProveedor o)
        {


            Parametros parametros =  db.Parametros.Find(1); //fondoFijoService.Parametros();
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
            var mvarCotizacion = db.Cotizaciones. OrderByDescending(x => x.IdCotizacion).FirstOrDefault().Cotizacion; //  mo  Cotizacion(Date, glbIdMonedaDolar);
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

        void CargarViewBag(ViewModelComprobanteProveedor o)
        {



            ViewBag.PorcentajesIVA = ListaPorcentajesIVA();

            ViewBag.IdTipoComprobante = new SelectList(db.TiposComprobantes, "IdTipoComprobante", "Descripcion", o.IdTipoComprobante);

            ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras.OrderBy(x => x.Descripcion), "IdCondicionCompra", "Descripcion", o.IdCondicionCompra);
            ViewBag.IdMoneda = new SelectList(db.Monedas.OrderBy(x => x.Nombre), "IdMoneda", "Nombre", o.IdMoneda);
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

                // verificar tambien si el  item ya se usa enum otro peddido
                //sss

                // return false;
            }

            //  if (!PuedeEditar(enumNodos.Facturas")) sErrorMsg += "\n" + "No tiene permisos de edición";





            if ((o.IdTipoComprobante ?? 0) <= 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta el tipo de comprobante";
                // return false;
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

            if (o.FechaComprobante == null) sErrorMsg += "\n" + "FechaComprobante";
            if (o.FechaVencimiento == null) sErrorMsg += "\n" + "FechaVencimiento";
            if (o.TotalBruto == null) sErrorMsg += "\n" + "TotalBruto";
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







            if ((o.IdProveedorEventual ?? 0) <= 0)
            {

                //         Case 	When cp.IdProveedor is not null Then 'Cta. cte.' 
                //When cp.IdCuenta is not null Then 'F.fijo' 
                //When cp.IdCuentaOtros is not null Then 'Otros' 


                //    // se pone el proveedor de ff en el idproveedoreventual???????
            }


            if (o.IdComprobanteProveedor <= 0)
            {
                //  string connectionString = Generales.sCadenaConexSQL(this.Session["BasePronto"].ToString());
                //  o.NumeroFactura = (int)Pronto.ERP.Bll.FacturaManager.ProximoNumeroFacturaPorIdCodigoIvaYNumeroDePuntoVenta(connectionString,o.IdCodigoIva ?? 0,o.PuntoVenta ?? 0);
            }



            if ((o.IdProveedor ?? 0) <= 0 && (o.IdProveedorEventual ?? 0) <= 0
             && (o.Proveedor ?? new Proveedor()).RazonSocial != "")
            {

                // verifico si está haciendo un alta al vuelo de proveedor


                //   verifico el nombre del proveedor , alta al vuelo y cuit


                //if (ComprobanteProveedor.Proveedor.RazonSocial != "")

                if (false)
                {

                    if ((o.Proveedor ?? new Proveedor()).RazonSocial == "")
                    {
                        // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                        sErrorMsg += "\n" + "Falta el proveedor";
                        // return false;
                    }


                    if ((o.Cuit ?? "") == "")
                    {
                        // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                        sErrorMsg += "\n" + "Falta el CUIT del nuevo proveedor";
                        // return false;
                    }
                }
                // verifico que NoAsyncTimeoutAttribute exista





                try
                {
                    sErrorMsg += crearProveedor(o);
                }
                catch (Exception e)
                {

                    sErrorMsg += e.ToString();
                }

            }
            else
            {
                // vino el id del proveedor
            }



            if ((o.IdCondicionCompra ?? 0) <= 0) o.IdCondicionCompra = 247;





            if ((o.IdCuenta ?? 0) <= 0) // && o.IdTipoComprobante == 1) // agregar al modelo de la vista (porque es un dato que no está en el modelo sql) si es ctacte/fondofijo/otros
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta la cuenta de fondo fijo";

            }

            if ((o.NumeroRendicionFF ?? 0) <= 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta el número de rendición";
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
                sErrorMsg += "\n" + "Falta la obra";
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

            //string OrigenDescripcionDefault = BuscaINI("OrigenDescripcion en 3 cuando hay observaciones");


            //         Dim mvarImprime As Integer, mvarNumero As Integer, i As Integer
            //         Dim mvarErr As String, mvarControlFechaNecesidad As String, mAuxS5 As String, mAuxS6 As String
            //         Dim PorObra As Boolean, mTrasabilidad_RM_LA As Boolean, mConAdjuntos As Boolean

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
                //x.Adjunto = x.Adjunto ?? "NO";
                //if (x.FechaEntrega < o.FechaRequerimiento) sErrorMsg +="\n"+ "\n" + "La fecha de entrega de " + fondoFijoService.Articulos.Find(x.IdArticulo).Descripcion + " es anterior a la del requerimiento";

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
                    sErrorMsg += "\n " + nombre + " no tiene una cuenta válida";

                }

                x.TomarEnCalculoDeImpuestos = "SI";
                x.IdProvinciaDestino1 = 2; //16
                x.PorcentajeProvinciaDestino1 = 100;


                if (x.CodigoCuenta == null) sErrorMsg += "\n " + nombre + " no CodigoCuenta";
                if (x.IdCuentaGasto == null) sErrorMsg += "\n " + nombre + " no tiene cuenta de gasto asociada";
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



                // if ((x.Cantidad ?? 0) <= 0) sErrorMsg += "\n" + nombre + " no tiene una cantidad válida";

                //if (OrigenDescripcionDefault == "SI" && (x.Observaciones ?? "") != "") x.OrigenDescripcion = 3;
                //      if (x.ArchivoAdjunto == null && x.ArchivoAdjunto1 == null) x.Adjunto = "NO";


                //if ((x.Precio ?? 0) <= 0 && o.IdComprobanteProveedorAbierto == null)
                //{
                //    if (o.Aprobo != null)
                //    {
                //        sErrorMsg += "\n " + nombre + " no tiene precio unitario";
                //    }
                //    else
                //    {
                //        // solo un aviso
                //        sWarningMsg += "\n " + nombre + " no tiene precio unitario. Cuando libere el ComprobanteProveedor deberá ingresarse.";
                //    }
                //    //break;
                //}

                //if (x.IdControlCalidad == null)
                //{
                //    // sErrorMsg +="\n"+ "Hay items de ComprobanteProveedor que no tienen indicado control de calidad";
                //    //break;
                //}

                //if (x.FechaEntrega < o.FechaComprobanteProveedor)
                //{
                //    sErrorMsg += "\n " + nombre + " tiene una fecha de entrega anterior a la del ComprobanteProveedor";
                //    //break;
                //}

                //if (x.FechaNecesidad != null && x.FechaNecesidad < o.FechaComprobanteProveedor && mvarControlFechaNecesidad != "SI")
                //{
                //    sErrorMsg += "\n " + nombre + " tiene una fecha de necesidad anterior a la del ComprobanteProveedor";
                //    //break;
                //}

                //if (x.IdCentroCosto == null)
                //{
                //    PorObra = false;
                //    mTrasabilidad_RM_LA = false;

                //    if (x.IdDetalleAcopios != null || x.IdDetalleLMateriales != null)
                //    {
                //        PorObra = true;
                //    }

                //    if (x.IdDetalleRequerimiento != null)
                //    {

                //        var oRsx = Pronto.ERP.Bll.EntidadManager.TraerFiltrado(SCsql(), ProntoFuncionesGenerales.enumSPs.Requerimientos_TX_DatosObra, x.IdDetalleRequerimiento);

                //        if (oRsx.Rows.Count > 0)
                //        {
                //            if (oRsx.Rows[0]["Obra"] != null) PorObra = true;
                //            mIdObra = (int)oRsx.Rows[0]["IdObra"];
                //        }

                //    }


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



                //if (mExigirTrasabilidad_RMLA_PE && x.IdDetalleAcopios == null && x.IdDetalleRequerimiento == null)
                //{
                //    sErrorMsg += "\n" + nombre + " no tiene trazabilidad a RM o LA";
                //    //break;
                //}



                tot += (x.Importe ?? 0) + (x.ImporteIVA1 ?? 0);
            }



            if (tot != o.TotalComprobante)
            {
                // ojo q puede estar chillando porque está en blanco una cuenta

                string s = "\n Hay problemas en el recálculo del total. renglon con importe pero sin cuenta de gasto elegida? Por favor, [pagina de error, metodos de error] total calculado " + tot + "      total en el comprobante" + (o.TotalComprobante ?? 0);
                sWarningMsg += s;
                sErrorMsg += s;
                o.TotalComprobante = tot;

            }


            //if ((o.Aprobo ?? 0) > 0 && o.FechaAprobacion == null) o.FechaAprobacion = DateTime.Now;


            //if (fondoFijoService.ObtenerTodos().Any(p => p.NumeroComprobanteProveedor == o.NumeroComprobanteProveedor && p.SubNumero == o.SubNumero && p.IdComprobanteProveedor != o.IdComprobanteProveedor))
            //{

            //    sErrorMsg += "\n" + "Numero/Subnumero de ComprobanteProveedor ya existente";
            //}





            //         if Len(mvarErr) {
            //            if mIdAprobo = 0 {
            //               mvarErr = mvarErr & vbCrLf & "Cuando libere el ComprobanteProveedor estos errores deberan estar corregidos"
            //               MsgBox "Errores encontrados :" & vbCrLf & mvarErr, vbExclamation
            //            Else
            //               MsgBox "Errores encontrados :" & vbCrLf & mvarErr, vbExclamation
            //               GoTo Salida
            //            }
            //         }


            //if Not mNumeracionPorPuntoVenta {
            //            if mvarId = -1 And mNumeracionAutomatica <> "SI" And txtNumeroComprobanteProveedor.Text = mNumeroComprobanteProveedorOriginal {
            //               Set oPar = oAp.Parametros.Item(1)
            //               if Check2.Value = 0 {
            //                  mNum = oPar.Registrox.ProximoNumeroComprobanteProveedor").Value
            //               Else
            //                  mNum = oPar.Registrox.ProximoNumeroComprobanteProveedorExterior").Value
            //               }
            //               origen.Registrox.NumeroComprobanteProveedor").Value = mNum
            //               mNumeroComprobanteProveedorOriginal = mNum
            //               Set oPar = Nothing
            //            }

            //            Set oRs = oAp.ObtenerTodos().TraerFiltrado("_PorNumero", Array(Val(txtNumeroComprobanteProveedor.Text), Val(txtSubnumero.Text), -1, Check2.Value))
            //            if oRs.RecordCount > 0 {
            //               if mvarId < 0 Or (mvarId > 0 And oRs.Fields(0).Value <> mvarId) {
            //                  oRs.Close
            //                  Set oRs = Nothing
            //                  mvarNumero = MsgBox("Numero/Subnumero de ComprobanteProveedor ya existente" & vbCrLf & "Desea actualizar el numero ?", vbYesNo, "Numero de ComprobanteProveedor")
            //                  if mvarNumero = vbYes {
            //                     Set oPar = oAp.Parametros.Item(1)
            //                     if Check2.Value = 0 {
            //                        mNum = oPar.Registrox.ProximoNumeroComprobanteProveedor").Value
            //                     Else
            //                        mNum = oPar.Registrox.ProximoNumeroComprobanteProveedorExterior").Value
            //                     }
            //                     origen.Registrox.NumeroComprobanteProveedor").Value = mNum
            //                     Set oPar = Nothing
            //                  }
            //                  GoTo Salida
            //               }
            //            }
            //            oRs.Close
            //            Set oRs = Nothing
            //         Else
            //            Set oRs = oAp.ObtenerTodos().TraerFiltrado("_PorNwemero", Array(Val(txtNumeroComprobanteProveedor.Text), Val(txtSubnumero.Text), dcfields(10).BoundText))
            //            if oRs.RecordCount > 0 {
            //               if mvarId < 0 Or (mvarId > 0 And oRs.Fields(0).Value <> mvarId) {
            //                  oRs.Close
            //                  Set oRs = Nothing
            //                  MsgBox "Numero/Subnumero de ComprobanteProveedor ya existente", vbExclamation
            //                  GoTo Salida
            //               }
            //            }
            //            oRs.Close
            //         }

            //         mAuxS6 = fondoFijoService.BuscarClaveINI("Exigir adjunto en ComprobantesProveedores con subcontrato")

            //            if mAuxS6 = "SI" And Iif(IsNull(x.NumeroSubcontrato").Value), 0, x.NumeroSubcontrato").Value) > 0 {
            //               mConAdjuntos = False
            //               For i = 1 To 10
            //                  if Len(Iif(IsNull(x.ArchivoAdjunto" & i).Value), "", x.ArchivoAdjunto" & i).Value)) > 0 {
            //                     mConAdjuntos = True
            //                     Exit For
            //                  }
            //               Next
            //               if Not mConAdjuntos {
            //                  MsgBox "Para un ComprobanteProveedor - subcontrato es necesario ingresar como adjunto las condiciones generales", vbExclamation
            //                  GoTo Salida
            //               }
            //            }

            //            if Not IsNull(x.IdComprobanteProveedorAbierto").Value) {
            //               mTotalComprobanteProveedorAbierto = 0
            //               mvarTotalComprobanteProveedors = 0
            //               mFechaLimite = 0
            //               Set oRs1 = Aplicacion.ComprobanteProveedorsAbiertos.TraerFiltrado("_Control", x.IdComprobanteProveedorAbierto").Value)
            //               if oRs1.RecordCount > 0 {
            //                  mTotalComprobanteProveedorAbierto = Iif(IsNull(oRs1x.ImporteLimite").Value), 0, oRs1x.ImporteLimite").Value)
            //                  mvarTotalComprobanteProveedors = Iif(IsNull(oRs1x.SumaComprobanteProveedors").Value), 0, oRs1x.SumaComprobanteProveedors").Value)
            //                  mFechaLimite = Iif(IsNull(oRs1x.FechaLimite").Value), 0, oRs1x.FechaLimite").Value)
            //               }
            //               oRs1.Close
            //               if mvarId > 0 {
            //                  Set oRs1 = Aplicacion.ObtenerTodos().TraerFiltrado("_PorId", mvarId)
            //                  if oRs1.RecordCount > 0 {
            //                     mvarTotalComprobanteProveedors = mvarTotalComprobanteProveedors - Iif(IsNull(oRs1x.TotalComprobanteProveedor").Value), 0, oRs1x.TotalComprobanteProveedor").Value)
            //                  }
            //                  oRs1.Close
            //               }
            //               mvarTotalComprobanteProveedors = mvarTotalComprobanteProveedors + mvarTotalComprobanteProveedor
            //               if mTotalComprobanteProveedorAbierto > 0 And mTotalComprobanteProveedorAbierto < mvarTotalComprobanteProveedors {
            //                  MsgBox "Se supero el importe limite del ComprobanteProveedor abierto : " & mTotalComprobanteProveedorAbierto, vbCritical
            //                  GoTo Salida
            //               }
            //               if mFechaLimite > 0 And mFechaLimite < DTFields(0).Value {
            //                  MsgBox "Se supero la fecha limite del ComprobanteProveedor abierto : " & mFechaLimite, vbCritical
            //                  GoTo Salida
            //               }
            //            }
            //            if mNumeracionPorPuntoVenta {
            //               x.PuntoVenta").Value = Val(dcfields(10).Text)
            //            Else
            //               if mvarId = -1 And mNumeracionAutomatica <> "SI" And txtNumeroComprobanteProveedor.Text = mNumeroComprobanteProveedorOriginal {
            //                  Set oPar = oAp.Parametros.Item(1)
            //                  if Check2.Value = 0 {
            //                     mNum = oPar.Registrox.ProximoNumeroComprobanteProveedor").Value
            //                     x.NumeroComprobanteProveedor").Value = mNum
            //                     oPar.Registrox.ProximoNumeroComprobanteProveedor").Value = mNum + 1
            //                  Else
            //                     mNum = oPar.Registrox.ProximoNumeroComprobanteProveedorExterior").Value
            //                     x.NumeroComprobanteProveedor").Value = mNum
            //                     oPar.Registrox.ProximoNumeroComprobanteProveedorExterior").Value = mNum + 1
            //                  }
            //                  oPar.Guardar
            //                  Set oPar = Nothing
            //               }
            //            }
            //            x.Bonificacion").Value = mvarBonificacion
            //            if IsNumeric(txtPorcentajeBonificacion.Text) { x.PorcentajeBonificacion").Value = Val(txtPorcentajeBonificacion.Text)
            //            x.TotalIva1").Value = mvarIVA1
            //            'x.TotalIva2").Value = mvarIVA2
            //            x.TotalComprobanteProveedor").Value = mvarTotalComprobanteProveedor
            //            x.PorcentajeIva1").Value = mvarP_IVA1
            //            x.PorcentajeIva2").Value = mvarP_IVA2
            //            x.TipoCompra").Value = Combo1(0).ListIndex + 1
            //            x.CotizacionMoneda").Value = txtCotizacionMoneda.Text
            //            x.CotizacionDolar").Value = txtCotizacionDolar.Text
            //            if Check2.Value = 1 {
            //               x.ComprobanteProveedorExterior").Value = "SI"
            //            Else
            //               x.ComprobanteProveedorExterior").Value = "NO"
            //            }
            //            if Not IsNull(x.NumeroSubcontrato").Value) {
            //               x.Subcontrato").Value = "SI"
            //            Else
            //               x.Subcontrato").Value = "NO"
            //            }
            //            if Check4.Value = 1 {
            //               x.Transmitir_a_SAT").Value = "SI"
            //            Else
            //               x.Transmitir_a_SAT").Value = "NO"
            //            }
            //            x.EnviarEmail").Value = 1
            //            if mvarId <= 0 { x.NumeracionAutomatica").Value = mNumeracionAutomatica
            //            x.Observaciones").Value = rchObservaciones.Text
            //            x.IdTipoCompraRM").Value = origen.IdTipoCompraRM






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

                // verificar tambien si el  item ya se usa enum otro peddido
                //sss

                // return false;
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



            //if ((o.IdProveedor ?? 0) <= 0 && (o.IdProveedorEventual ?? 0) <= 0
            // && (o.Proveedor ?? new Proveedor()).RazonSocial != "")
            //{

            //    // verifico si está haciendo un alta al vuelo de proveedor


            //    //   verifico el nombre del proveedor , alta al vuelo y cuit


            //    //if (ComprobanteProveedor.Proveedor.RazonSocial != "")

            //    if (false)
            //    {

            //        if ((o.Proveedor ?? new Proveedor()).RazonSocial == "")
            //        {
            //            // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
            //            sErrorMsg += "\n" + "Falta el proveedor";
            //            // return false;
            //        }


            //        if ((o.Cuit ?? "") == "")
            //        {
            //            // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
            //            sErrorMsg += "\n" + "Falta el CUIT del nuevo proveedor";
            //            // return false;
            //        }
            //    }
            //    // verifico que NoAsyncTimeoutAttribute exista





            //    try
            //    {
            //        sErrorMsg += crearProveedor(o);
            //    }
            //    catch (Exception e)
            //    {

            //        sErrorMsg += e.ToString();
            //    }

            //}
            //else
            //{
            //    // vino el id del proveedor
            //}



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

            //string OrigenDescripcionDefault = BuscaINI("OrigenDescripcion en 3 cuando hay observaciones");


            //         Dim mvarImprime As Integer, mvarNumero As Integer, i As Integer
            //         Dim mvarErr As String, mvarControlFechaNecesidad As String, mAuxS5 As String, mAuxS6 As String
            //         Dim PorObra As Boolean, mTrasabilidad_RM_LA As Boolean, mConAdjuntos As Boolean

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
                //x.Adjunto = x.Adjunto ?? "NO";
                //if (x.FechaEntrega < o.FechaRequerimiento) sErrorMsg +="\n"+ "\n" + "La fecha de entrega de " + fondoFijoService.Articulos.Find(x.IdArticulo).Descripcion + " es anterior a la del requerimiento";

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



                // if ((x.Cantidad ?? 0) <= 0) sErrorMsg += "\n" + nombre + " no tiene una cantidad válida";

                //if (OrigenDescripcionDefault == "SI" && (x.Observaciones ?? "") != "") x.OrigenDescripcion = 3;
                //      if (x.ArchivoAdjunto == null && x.ArchivoAdjunto1 == null) x.Adjunto = "NO";


                //if ((x.Precio ?? 0) <= 0 && o.IdComprobanteProveedorAbierto == null)
                //{
                //    if (o.Aprobo != null)
                //    {
                //        sErrorMsg += "\n " + nombre + " no tiene precio unitario";
                //    }
                //    else
                //    {
                //        // solo un aviso
                //        sWarningMsg += "\n " + nombre + " no tiene precio unitario. Cuando libere el ComprobanteProveedor deberá ingresarse.";
                //    }
                //    //break;
                //}

                //if (x.IdControlCalidad == null)
                //{
                //    // sErrorMsg +="\n"+ "Hay items de ComprobanteProveedor que no tienen indicado control de calidad";
                //    //break;
                //}

                //if (x.FechaEntrega < o.FechaComprobanteProveedor)
                //{
                //    sErrorMsg += "\n " + nombre + " tiene una fecha de entrega anterior a la del ComprobanteProveedor";
                //    //break;
                //}

                //if (x.FechaNecesidad != null && x.FechaNecesidad < o.FechaComprobanteProveedor && mvarControlFechaNecesidad != "SI")
                //{
                //    sErrorMsg += "\n " + nombre + " tiene una fecha de necesidad anterior a la del ComprobanteProveedor";
                //    //break;
                //}

                //if (x.IdCentroCosto == null)
                //{
                //    PorObra = false;
                //    mTrasabilidad_RM_LA = false;

                //    if (x.IdDetalleAcopios != null || x.IdDetalleLMateriales != null)
                //    {
                //        PorObra = true;
                //    }

                //    if (x.IdDetalleRequerimiento != null)
                //    {

                //        var oRsx = Pronto.ERP.Bll.EntidadManager.TraerFiltrado(SCsql(), ProntoFuncionesGenerales.enumSPs.Requerimientos_TX_DatosObra, x.IdDetalleRequerimiento);

                //        if (oRsx.Rows.Count > 0)
                //        {
                //            if (oRsx.Rows[0]["Obra"] != null) PorObra = true;
                //            mIdObra = (int)oRsx.Rows[0]["IdObra"];
                //        }

                //    }


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



                //if (mExigirTrasabilidad_RMLA_PE && x.IdDetalleAcopios == null && x.IdDetalleRequerimiento == null)
                //{
                //    sErrorMsg += "\n" + nombre + " no tiene trazabilidad a RM o LA";
                //    //break;
                //}



                tot += (x.Importe ?? 0) + (x.ImporteIVA1 ?? 0);
            }



            if (tot != o.TotalComprobante && false)
            {
                // ojo q puede estar chillando porque está en blanco una cuenta

                string s = "\n Hay problemas en el recálculo del total. renglon con importe pero sin cuenta de gasto elegida? Por favor, [pagina de error, metodos de error] total calculado " + tot + "      total en el comprobante" + (o.TotalComprobante ?? 0);
                sWarningMsg += s;
                sErrorMsg += s;
                o.TotalComprobante = tot;

            }


            //if ((o.Aprobo ?? 0) > 0 && o.FechaAprobacion == null) o.FechaAprobacion = DateTime.Now;


            //if (fondoFijoService.ObtenerTodos().Any(p => p.NumeroComprobanteProveedor == o.NumeroComprobanteProveedor && p.SubNumero == o.SubNumero && p.IdComprobanteProveedor != o.IdComprobanteProveedor))
            //{

            //    sErrorMsg += "\n" + "Numero/Subnumero de ComprobanteProveedor ya existente";
            //}





            //         if Len(mvarErr) {
            //            if mIdAprobo = 0 {
            //               mvarErr = mvarErr & vbCrLf & "Cuando libere el ComprobanteProveedor estos errores deberan estar corregidos"
            //               MsgBox "Errores encontrados :" & vbCrLf & mvarErr, vbExclamation
            //            Else
            //               MsgBox "Errores encontrados :" & vbCrLf & mvarErr, vbExclamation
            //               GoTo Salida
            //            }
            //         }


            //if Not mNumeracionPorPuntoVenta {
            //            if mvarId = -1 And mNumeracionAutomatica <> "SI" And txtNumeroComprobanteProveedor.Text = mNumeroComprobanteProveedorOriginal {
            //               Set oPar = oAp.Parametros.Item(1)
            //               if Check2.Value = 0 {
            //                  mNum = oPar.Registrox.ProximoNumeroComprobanteProveedor").Value
            //               Else
            //                  mNum = oPar.Registrox.ProximoNumeroComprobanteProveedorExterior").Value
            //               }
            //               origen.Registrox.NumeroComprobanteProveedor").Value = mNum
            //               mNumeroComprobanteProveedorOriginal = mNum
            //               Set oPar = Nothing
            //            }

            //            Set oRs = oAp.ObtenerTodos().TraerFiltrado("_PorNumero", Array(Val(txtNumeroComprobanteProveedor.Text), Val(txtSubnumero.Text), -1, Check2.Value))
            //            if oRs.RecordCount > 0 {
            //               if mvarId < 0 Or (mvarId > 0 And oRs.Fields(0).Value <> mvarId) {
            //                  oRs.Close
            //                  Set oRs = Nothing
            //                  mvarNumero = MsgBox("Numero/Subnumero de ComprobanteProveedor ya existente" & vbCrLf & "Desea actualizar el numero ?", vbYesNo, "Numero de ComprobanteProveedor")
            //                  if mvarNumero = vbYes {
            //                     Set oPar = oAp.Parametros.Item(1)
            //                     if Check2.Value = 0 {
            //                        mNum = oPar.Registrox.ProximoNumeroComprobanteProveedor").Value
            //                     Else
            //                        mNum = oPar.Registrox.ProximoNumeroComprobanteProveedorExterior").Value
            //                     }
            //                     origen.Registrox.NumeroComprobanteProveedor").Value = mNum
            //                     Set oPar = Nothing
            //                  }
            //                  GoTo Salida
            //               }
            //            }
            //            oRs.Close
            //            Set oRs = Nothing
            //         Else
            //            Set oRs = oAp.ObtenerTodos().TraerFiltrado("_PorNwemero", Array(Val(txtNumeroComprobanteProveedor.Text), Val(txtSubnumero.Text), dcfields(10).BoundText))
            //            if oRs.RecordCount > 0 {
            //               if mvarId < 0 Or (mvarId > 0 And oRs.Fields(0).Value <> mvarId) {
            //                  oRs.Close
            //                  Set oRs = Nothing
            //                  MsgBox "Numero/Subnumero de ComprobanteProveedor ya existente", vbExclamation
            //                  GoTo Salida
            //               }
            //            }
            //            oRs.Close
            //         }

            //         mAuxS6 = fondoFijoService.BuscarClaveINI("Exigir adjunto en ComprobantesProveedores con subcontrato")

            //            if mAuxS6 = "SI" And Iif(IsNull(x.NumeroSubcontrato").Value), 0, x.NumeroSubcontrato").Value) > 0 {
            //               mConAdjuntos = False
            //               For i = 1 To 10
            //                  if Len(Iif(IsNull(x.ArchivoAdjunto" & i).Value), "", x.ArchivoAdjunto" & i).Value)) > 0 {
            //                     mConAdjuntos = True
            //                     Exit For
            //                  }
            //               Next
            //               if Not mConAdjuntos {
            //                  MsgBox "Para un ComprobanteProveedor - subcontrato es necesario ingresar como adjunto las condiciones generales", vbExclamation
            //                  GoTo Salida
            //               }
            //            }

            //            if Not IsNull(x.IdComprobanteProveedorAbierto").Value) {
            //               mTotalComprobanteProveedorAbierto = 0
            //               mvarTotalComprobanteProveedors = 0
            //               mFechaLimite = 0
            //               Set oRs1 = Aplicacion.ComprobanteProveedorsAbiertos.TraerFiltrado("_Control", x.IdComprobanteProveedorAbierto").Value)
            //               if oRs1.RecordCount > 0 {
            //                  mTotalComprobanteProveedorAbierto = Iif(IsNull(oRs1x.ImporteLimite").Value), 0, oRs1x.ImporteLimite").Value)
            //                  mvarTotalComprobanteProveedors = Iif(IsNull(oRs1x.SumaComprobanteProveedors").Value), 0, oRs1x.SumaComprobanteProveedors").Value)
            //                  mFechaLimite = Iif(IsNull(oRs1x.FechaLimite").Value), 0, oRs1x.FechaLimite").Value)
            //               }
            //               oRs1.Close
            //               if mvarId > 0 {
            //                  Set oRs1 = Aplicacion.ObtenerTodos().TraerFiltrado("_PorId", mvarId)
            //                  if oRs1.RecordCount > 0 {
            //                     mvarTotalComprobanteProveedors = mvarTotalComprobanteProveedors - Iif(IsNull(oRs1x.TotalComprobanteProveedor").Value), 0, oRs1x.TotalComprobanteProveedor").Value)
            //                  }
            //                  oRs1.Close
            //               }
            //               mvarTotalComprobanteProveedors = mvarTotalComprobanteProveedors + mvarTotalComprobanteProveedor
            //               if mTotalComprobanteProveedorAbierto > 0 And mTotalComprobanteProveedorAbierto < mvarTotalComprobanteProveedors {
            //                  MsgBox "Se supero el importe limite del ComprobanteProveedor abierto : " & mTotalComprobanteProveedorAbierto, vbCritical
            //                  GoTo Salida
            //               }
            //               if mFechaLimite > 0 And mFechaLimite < DTFields(0).Value {
            //                  MsgBox "Se supero la fecha limite del ComprobanteProveedor abierto : " & mFechaLimite, vbCritical
            //                  GoTo Salida
            //               }
            //            }
            //            if mNumeracionPorPuntoVenta {
            //               x.PuntoVenta").Value = Val(dcfields(10).Text)
            //            Else
            //               if mvarId = -1 And mNumeracionAutomatica <> "SI" And txtNumeroComprobanteProveedor.Text = mNumeroComprobanteProveedorOriginal {
            //                  Set oPar = oAp.Parametros.Item(1)
            //                  if Check2.Value = 0 {
            //                     mNum = oPar.Registrox.ProximoNumeroComprobanteProveedor").Value
            //                     x.NumeroComprobanteProveedor").Value = mNum
            //                     oPar.Registrox.ProximoNumeroComprobanteProveedor").Value = mNum + 1
            //                  Else
            //                     mNum = oPar.Registrox.ProximoNumeroComprobanteProveedorExterior").Value
            //                     x.NumeroComprobanteProveedor").Value = mNum
            //                     oPar.Registrox.ProximoNumeroComprobanteProveedorExterior").Value = mNum + 1
            //                  }
            //                  oPar.Guardar
            //                  Set oPar = Nothing
            //               }
            //            }
            //            x.Bonificacion").Value = mvarBonificacion
            //            if IsNumeric(txtPorcentajeBonificacion.Text) { x.PorcentajeBonificacion").Value = Val(txtPorcentajeBonificacion.Text)
            //            x.TotalIva1").Value = mvarIVA1
            //            'x.TotalIva2").Value = mvarIVA2
            //            x.TotalComprobanteProveedor").Value = mvarTotalComprobanteProveedor
            //            x.PorcentajeIva1").Value = mvarP_IVA1
            //            x.PorcentajeIva2").Value = mvarP_IVA2
            //            x.TipoCompra").Value = Combo1(0).ListIndex + 1
            //            x.CotizacionMoneda").Value = txtCotizacionMoneda.Text
            //            x.CotizacionDolar").Value = txtCotizacionDolar.Text
            //            if Check2.Value = 1 {
            //               x.ComprobanteProveedorExterior").Value = "SI"
            //            Else
            //               x.ComprobanteProveedorExterior").Value = "NO"
            //            }
            //            if Not IsNull(x.NumeroSubcontrato").Value) {
            //               x.Subcontrato").Value = "SI"
            //            Else
            //               x.Subcontrato").Value = "NO"
            //            }
            //            if Check4.Value = 1 {
            //               x.Transmitir_a_SAT").Value = "SI"
            //            Else
            //               x.Transmitir_a_SAT").Value = "NO"
            //            }
            //            x.EnviarEmail").Value = 1
            //            if mvarId <= 0 { x.NumeracionAutomatica").Value = mNumeracionAutomatica
            //            x.Observaciones").Value = rchObservaciones.Text
            //            x.IdTipoCompraRM").Value = origen.IdTipoCompraRM






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

            //Set oF = New frm_Aux
            //With oF
            //   .Caption = "Cerrar rendicion de FF"
            //   .Label1.Caption = "Prox.Rend. :"
            //   With .Text1
            //      .Text = Val(Columnas(3)) + 1
            //      .Enabled = False
            //   End With
            //   .Id = 14
            //   .Show vbModal, Me
            //   mOk = .Ok
            //   mProximaRendicion = .Text1.Text
            //End With
            //Unload oF
            //Set oF = Nothing

            //If mOk Then
            //   Aplicacion.Tarea "Cuentas_IncrementarRendicionFF", Array(Columnas(2), mProximaRendicion)
            //End If

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



            //                UPDATE Cuentas
            //SET NumeroAuxiliar=@NumeroAuxiliar
            //WHERE IdCuenta=@IdCuentaFF
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
                //http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json
                //  nonono esta claro que en el res.Errors debo agregar la lista de errores que genera el Validar, y lo
                //que eso devuelva lo procesará javascript



                // return  new JsonResult(new { Comprobante = ComprobanteProveedor, Errores = ms });
                // return Json (  new { Comprobante = ComprobanteProveedor, Errores = ms }) ;

            }
            catch (Exception ex)
            {

                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);
                res.Message = "El ComprobanteProveedor es inválido. " + ex.ToString();
                //                throw;
            }


            // res.Status = Status.Error;
            // res.Errors = GetModelStateErrorsAsString(this.ModelState);
            //// res.Message = "El ComprobanteProveedor es inválido. " + ex.ToString();

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


        //public virtual ActionResult Delete(int id)
        //{
        ////    ComprobanteProveedor ComprobanteProveedor = fondoFijoService.ObtenerTodos().Find(id);
        //  //  return View(ComprobanteProveedor);
        //}

        //[HttpPost, ActionName("Delete")]
        //public virtual ActionResult DeleteConfirmed(int id)
        //{
        //    ComprobanteProveedor ComprobanteProveedor = fondoFijoService.ObtenerTodos().Find(id);

        //    //fondoFijoService.ObtenerTodos().Remove(ComprobanteProveedor);
        //    //fondoFijoService.SaveChanges();
        //    return RedirectToAction("Index");
        //}






        public virtual ActionResult ComprobantesProveedor_DynamicGridData
              (string sidx, string sord, int page, int rows, bool _search, string filters,
                     string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows; // ?? 20;
            int currentPage = page; // ?? 1;

            //if (sidx == "Numero") sidx = "NumeroComprobanteProveedor"; // como estoy haciendo "select a" (el renglon entero) en la linq antes de llamar jqGridJson, no pude ponerle el nombre explicito
            //if (searchField == "Numero") searchField = "NumeroComprobanteProveedor"; 

            //var Entidad = fondoFijoService.ObtenerTodos()
            //    // .Include(x => x.DetalleComprobantesProveedores.Select(y => y.Unidad))
            //    // .Include(x => x.DetalleComprobantesProveedores.Select(y => y.Moneda))
            //    //.Include(x => x.DetalleComprobantesProveedores. .moneda)
            //    //   .Include("DetalleComprobantesProveedores.Unidad") // funciona tambien
            //    // .Include(x => x.Moneda)
            //    //.Include(x => x.Proveedor)
            //    //  .Include("DetalleComprobantesProveedores.IdDetalleRequerimiento") // funciona tambien
            //    //.Include(x => x.DetalleComprobantesProveedores.Select(y => y. y.IdDetalleRequerimiento))
            //    // .Include(x => x.Aprobo)
            //    //.Include(x => x.Comprador)
            //    //.Include(x => x.DetalleComprobantesProveedores.Select(y => y. y.IdDetalleRequerimiento))
            //    // .Include(x => x.Aprobo)
            //    //.Include(x => x.Comprador)
            //    .Include(x => x.DetalleComprobantesProveedores)
            //    .Include(x => x.DescripcionIva)
            //    .Include(x => x.Cuenta)
            //    .Include(x => x.Proveedor)
            //    .Include(x => x.Proveedore)
            //    .Include(x => x.Obra)
            //    //.Where(x => (x.Confirmado ?? "SI") != "NO") // verificar si lo de "confirmado" solo se debe revisar para fondos fijos
            //              .AsQueryable();



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

  


                                //a.SubNumero.NullSafeToString(), 
                                //a.FechaComprobanteProveedor.NullSafeToString(), 
                                ////GetCustomDateFormat(a.FechaComprobanteProveedor).NullSafeToString(), 
                                //a.FechaSalida.NullSafeToString(), 
                                //a.Cumplido.NullSafeToString(), 
                                //"", //a.DetalleComprobantesProveedores..Select (requerimientos),
                                //"", //a.DetalleComprobantesProveedores.select (obras,
                                //a.Proveedor==null ? "" :  a.Proveedor.RazonSocial.NullSafeToString(), 
                                //(a.TotalComprobanteProveedor- a.TotalIva1+a.Bonificacion- (a.ImpuestosInternos ?? 0)- (a.OtrosConceptos1 ?? 0) - (a.OtrosConceptos2 ?? 0)-    (a.OtrosConceptos3 ?? 0) -( a.OtrosConceptos4 ?? 0) - (a.OtrosConceptos5 ?? 0)).ToString(),  
                                //a.Bonificacion.NullSafeToString(), 
                                //a.TotalIva1.NullSafeToString(), 
                                //a.Moneda==null ? "" :   a.Moneda.Abreviatura.NullSafeToString(),  
                                //a.Comprador==null ? "" :    a.Comprador.Nombre.NullSafeToString(),  
                                //a.Empleado==null ? "" :  a.Empleado.Nombre.NullSafeToString(),  
                                //a.DetalleComprobantesProveedores.Count().NullSafeToString(),  
                                //a.IdComprobanteProveedor.NullSafeToString(), 
                                //a.NumeroComparativa.NullSafeToString(),  
                                //a.IdTipoCompraRM.NullSafeToString(), 
                                //a.Observaciones.NullSafeToString(),   
                                //a.DetalleCondicionCompra.NullSafeToString(),   
                                //a.ComprobanteProveedorExterior.NullSafeToString(),  
                                //a.IdComprobanteProveedorAbierto.NullSafeToString(), 
                                //a.NumeroLicitacion .NullSafeToString(), 
                                //a.Impresa.NullSafeToString(), 
                                //a.UsuarioAnulacion.NullSafeToString(), 
                                //a.FechaAnulacion.NullSafeToString(),  
                                //a.MotivoAnulacion.NullSafeToString(),  
                                //a.ImpuestosInternos.NullSafeToString(), 
                                //"", // #Auxiliar1.Equipos , 
                                //a.CircuitoFirmasCompleto.NullSafeToString(), 
                                //a.Proveedor==null ? "" : a.Proveedor.IdCodigoIva.NullSafeToString() 

                                
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

            //if (sidx == "Numero") sidx = "NumeroComprobanteProveedor"; // como estoy haciendo "select a" (el renglon entero) en la linq antes de llamar jqGridJson, no pude ponerle el nombre explicito
            //if (searchField == "Numero") searchField = "NumeroComprobanteProveedor"; 

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
                //.Include(x => x.DetalleComprobantesProveedores.Select(y => y. y.IdDetalleRequerimiento))
                // .Include(x => x.Aprobo)
                //.Include(x => x.Comprador)
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
                /*   new         
                {
                                    IdComprobanteProveedor = a.IdComprobanteProveedor,

                                    Numero = a.NumeroComprobante1
                                    //fecha
                                    //fechasalida
                                    //cumpli
                                    //rms
                                    //obras
                                    //proveedor
                                    //neto gravado
                                    //bonif
                                    //total iva


                                    // IsNull(ComprobantesProveedores.TotalComprobanteProveedor,0)-IsNull(ComprobantesProveedores.TotalIva1,0)+IsNull(ComprobantesProveedores.Bonificacion,0)-  
                                    // IsNull(ComprobantesProveedores.ImpuestosInternos,0)-IsNull(ComprobantesProveedores.OtrosConceptos1,0)-IsNull(ComprobantesProveedores.OtrosConceptos2,0)-  
                                    // IsNull(ComprobantesProveedores.OtrosConceptos3,0)-IsNull(ComprobantesProveedores.OtrosConceptos4,0)-IsNull(ComprobantesProveedores.OtrosConceptos5,0)as [Neto gravado],  
                                    // Case When Bonificacion=0 Then Null Else Bonificacion End as [Bonificacion],  

                                    // Case When TotalIva1=0 Then Null Else TotalIva1 End as [Total Iva],  

                                    // IsNull(ComprobantesProveedores.ImpuestosInternos,0)+IsNull(ComprobantesProveedores.OtrosConceptos1,0)+IsNull(ComprobantesProveedores.OtrosConceptos2,0)+  
                                    // IsNull(ComprobantesProveedores.OtrosConceptos3,0)+IsNull(ComprobantesProveedores.OtrosConceptos4,0)+IsNull(ComprobantesProveedores.OtrosConceptos5,0)as [Otros Conceptos],  
                                    // TotalComprobanteProveedor as [Total ComprobanteProveedor],  





                                } */


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

  


                                //a.SubNumero.NullSafeToString(), 
                                //a.FechaComprobanteProveedor.NullSafeToString(), 
                                ////GetCustomDateFormat(a.FechaComprobanteProveedor).NullSafeToString(), 
                                //a.FechaSalida.NullSafeToString(), 
                                //a.Cumplido.NullSafeToString(), 
                                //"", //a.DetalleComprobantesProveedores..Select (requerimientos),
                                //"", //a.DetalleComprobantesProveedores.select (obras,
                                //a.Proveedor==null ? "" :  a.Proveedor.RazonSocial.NullSafeToString(), 
                                //(a.TotalComprobanteProveedor- a.TotalIva1+a.Bonificacion- (a.ImpuestosInternos ?? 0)- (a.OtrosConceptos1 ?? 0) - (a.OtrosConceptos2 ?? 0)-    (a.OtrosConceptos3 ?? 0) -( a.OtrosConceptos4 ?? 0) - (a.OtrosConceptos5 ?? 0)).ToString(),  
                                //a.Bonificacion.NullSafeToString(), 
                                //a.TotalIva1.NullSafeToString(), 
                                //a.Moneda==null ? "" :   a.Moneda.Abreviatura.NullSafeToString(),  
                                //a.Comprador==null ? "" :    a.Comprador.Nombre.NullSafeToString(),  
                                //a.Empleado==null ? "" :  a.Empleado.Nombre.NullSafeToString(),  
                                //a.DetalleComprobantesProveedores.Count().NullSafeToString(),  
                                //a.IdComprobanteProveedor.NullSafeToString(), 
                                //a.NumeroComparativa.NullSafeToString(),  
                                //a.IdTipoCompraRM.NullSafeToString(), 
                                //a.Observaciones.NullSafeToString(),   
                                //a.DetalleCondicionCompra.NullSafeToString(),   
                                //a.ComprobanteProveedorExterior.NullSafeToString(),  
                                //a.IdComprobanteProveedorAbierto.NullSafeToString(), 
                                //a.NumeroLicitacion .NullSafeToString(), 
                                //a.Impresa.NullSafeToString(), 
                                //a.UsuarioAnulacion.NullSafeToString(), 
                                //a.FechaAnulacion.NullSafeToString(),  
                                //a.MotivoAnulacion.NullSafeToString(),  
                                //a.ImpuestosInternos.NullSafeToString(), 
                                //"", // #Auxiliar1.Equipos , 
                                //a.CircuitoFirmasCompleto.NullSafeToString(), 
                                //a.Proveedor==null ? "" : a.Proveedor.IdCodigoIva.NullSafeToString() 

                                
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

            //if (sidx == "Numero") sidx = "NumeroComprobanteProveedor"; // como estoy haciendo "select a" (el renglon entero) en la linq antes de llamar jqGridJson, no pude ponerle el nombre explicito
            //if (searchField == "Numero") searchField = "NumeroComprobanteProveedor"; 


            //var Entidad1 = fondoFijoService.ObtenerTodos(sidx, sord, page, rows, _search, searchField, searchOper, searchString,
            //                                FechaInicial, FechaFinal, rendicion, idcuenta);


            var Entidad = db.ComprobantesProveedor.AsQueryable();
            

            //int totalRecords = Entidad1.Count();






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
                    (sidx, sord, page, rows, _search, filters, db, ref totalRecords,
                             Entidad);


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
                            // Contacto = a.Contacto,
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
                                //a.Contacto,
                                a.Observaciones
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        public virtual ActionResult DetComprobantesProveedor(string sidx, string sord, int? page, int? rows, int? IdComprobanteProveedor)
        {
            int IdComprobanteProveedor1 = IdComprobanteProveedor ?? 0;
            var DetEntidad = fondoFijoService.ObtenerTodosDetalle().Include("Cuenta").Where(p => p.IdComprobanteProveedor == IdComprobanteProveedor1).AsQueryable();

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




            //if (IdComprobanteProveedor <= 0)
            //{
            //    // le agrego un renglon vacío para pasarle los ivas para el encabezado
            //    var item = new DetalleComprobantesProveedore();
            //    item.IdDetalleComprobanteProveedor = -1;
            //    data.Add(item);
            //}




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
                             


                 




                                //a.PorcentajeBonificacion.ToString(), 
                                //(a.PorcentajeBonificacion * a.Precio * a.Cantidad).ToString()  ,  // a.ImporteBonificacion.ToString(), 
                                //a.PorcentajeIVA.ToString(), 
                                //a.ImporteIva.ToString(), 
                                //a.ImporteTotalItem.ToString(), 
                                //a.FechaEntrega.ToString(),a.FechaNecesidad.ToString(),
                                //a.Observaciones,
                                //a.NumeroRequerimiento.ToString(),
                                //a.NumeroItemRM.ToString(),

                                //a.ArchivoAdjunto1,
                                //a.IdDetalleRequerimiento.NullSafeToString(),
                                //a.IdDetalleAcopios.NullSafeToString(),
                                //a.OrigenDescripcion.NullSafeToString(),
                                //a.IdCentroCosto.NullSafeToString()

                            
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



            /*
            if (IdComprobanteProveedor <= 0)
            {
                // le agrego un renglon vacío para pasarle los ivas para el encabezado
                var item = new DetalleComprobantesProveedore();
                item.IdDetalleComprobanteProveedor = -1;
                data.Add(item);
            }

            */


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
                                
                                
                                //a.NumeroRequerimiento.ToString(),
                                //a.NumeroItemRM.ToString(),

                                //a.ArchivoAdjunto1,
                                //a.IdDetalleRequerimiento.NullSafeToString(),
                                //a.IdDetalleAcopios.NullSafeToString(),
                                //a.OrigenDescripcion.NullSafeToString(),
                                //a.IdCentroCosto.NullSafeToString()

                            
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
                            //a.IdUnidad,
                            //a.IdDetalleRequerimiento,
                            //a.NumeroItem,
                            ////a.DetalleRequerimiento.Requerimientos.Obra.NumeroObra,
                            //a.Cantidad,
                            //a.Unidad.Abreviatura,
                            //a.Articulo.Codigo,
                            //a.Articulo.Descripcion,
                            //a.FechaEntrega,
                            //a.Observaciones,
                            ////a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            ////NumeroItemRM = a.DetalleRequerimiento.NumeroItem,
                            //a.Adjunto,
                            //a.ArchivoAdjunto1,
                            //a.ArchivoAdjunto2,
                            //a.ArchivoAdjunto3
                        })
                //.OrderBy(p => p.NumeroItem)
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


            //o.MotivoAnulacion = "SI";
            //o.FechaAnulacion = DateTime.Now;
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



            //var f = fondoFijoService.Subdiarios.Where(x => x.IdComprobante == o.IdFactura);
            //foreach (Subdiario reg in f)
            //{
            //    fondoFijoService.Subdiarios.Remove(reg);
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
            //   Set oCP = Aplicacion.ObtenerTodos().Item(oRs.Fields("IdComprobanteProveedor").Value)
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




            //unitOfWork.SaveChanges();
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
            //if ((ComprobanteProveedor.Contacto ?? "") != "")
            //{

            //    usuarioNuevo2.UserName = ComprobanteProveedor.Contacto;
            //    if (false)
            //    {
            //        usuarioNuevo2.UserName = ComprobanteProveedor.Contacto.Replace("Sr.", "").Replace("Sra.", "").Replace(".", "").Replace(" ", "");
            //        System.Text.RegularExpressions.Regex rgx = new System.Text.RegularExpressions.Regex("[^a-zA-Z0-9 -]");
            //        usuarioNuevo2.UserName = rgx.Replace(usuarioNuevo2.UserName, "");
            //    }
            //    usuarioNuevo2.Password = Membership.GeneratePassword(20, 0);
            //    usuarioNuevo2.ConfirmPassword = usuarioNuevo2.Password;
            //    usuarioNuevo2.Email = ComprobanteProveedor.Contacto; // usuarioNuevo2.UserName + Proveedor.Email ?? "mscalella911@hotmail.com";
            //    usuarioNuevo2.Grupo = Proveedor.Cuit;
            //    cAcc.Register(usuarioNuevo2);

            //    cAcc.Verificar(Membership.GetUser(usuarioNuevo2.UserName).ProviderUserKey.ToString());

            //    Generales.MailAlUsuarioConLaPasswordYElDominio(usuarioNuevo2.UserName, usuarioNuevo2.Password, usuarioNuevo2.Email);
            //}

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






        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        /// <summary>
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="sheetName"></param>
        /// <returns></returns>




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













        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




        // This action handles the form POST and the upload
        [HttpPost]
        public virtual ActionResult Importar(System.Web.HttpPostedFileBase file)
        {

            // http://stackoverflow.com/questions/8159725/mvc-httppostedfilebase-is-always-null

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



                    // if (mComprobante.Contains("-"))
                    //{
                    //mNumeroComprobante1 = CLng(mId(mComprobante, 1, InStr(1, mComprobante, "-") - 1))

                    //If mNumeroComprobante1 > 9999 Then
                    //    MsgBox "El punto de venta no puede tener mas de 4 digitos. (Fila " & fl & ")", vbExclamation
                    //    GoTo Salida
                    //End If

                    //mNumeroComprobante2 = CLng(mId(mComprobante, InStr(1, mComprobante, "-") + 1, 100))

                    //If mNumeroComprobante2 > 99999999 Then
                    //    MsgBox "El numero de comprobante no puede tener mas de 8 digitos. (Fila " & fl & ")", vbExclamation
                    //    GoTo Salida
                    //End If
                    // }

                    var mRazonSocial = r[5].NullSafeToString();
                    var mCuit = r[9].NullSafeToString();
                    var mFechaFactura = r[3].NullSafeToString();
                    var mNumeroCAI = r[16].NullSafeToString();


                    var mFechaVencimientoCAI = r[18].NullSafeToString();


                    var mInformacionAuxiliar = r[19].NullSafeToString();

                    // if (mFecha1 == "SI") mFechaRecepcion = mFechaFactura;


                    //mFechaRecepcion = .DTFields(0).Value

                    //                                      .Fields("FechaComprobante").Value = mFechaFactura
                    //     If mFechaFactura > mFechaRecepcion Then
                    //        .Fields("FechaRecepcion").Value = mFechaFactura
                    //     Else
                    //        .Fields("FechaRecepcion").Value = mFechaRecepcion
                    //     End If
                    //     .Fields("FechaVencimiento").Value = mFechaFactura



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




                    //If Len(mCuit) > 0 Then
                    //   Set oRsAux1 = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)
                    //Else
                    //   Set oRsAux1 = oAp.Proveedores.TraerFiltrado("_PorNombre", mRazonSocial)
                    //End If

                    ///////////////////////////////////////////
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
                    ///////////////////////////////////////////
                    ///////////////////////////////////////////
                    ///////////////////////////////////////////
                    ///////////////////////////////////////////
                    // bucle de detalle

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
                                    /*
                                   //oRsAux1.Close;
                                    oRsAux1 = EntidadManager.TraerFiltrado                                       (SC, "_PorCodigo", mCodigoCuentaGasto);
                                   if( oRsAux1.RecordCount > 0 ){
                                      mIdCuenta = oRsAux1.Fields("IdCuenta").Value;
                                      mCodigoCuenta = oRsAux1.Fields("Codigo").Value;
                                      mIdRubroContable = IIf(IsNull(oRsAux1.Fields("IdRubroFinanciero").Value), 0, oRsAux1.Fields("IdRubroFinanciero").Value);
                                   }else{
                                      if( ! mTomarCuentaDePresupuesto ){
                                         mError = mError + "\r\n" + mTipo + " " + mLetra + "-" + System.String.Format(mNumeroComprobante1, "0000") + "-" + System.String.Format(mNumeroComprobante2, "00000000") + ", fila " + fl + "  - Cuenta contable inexistente";
                                         fl = fl + 1;
                                         GoTo FinLoop;
                                      }
                                   }
                                     * */
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


                        ////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////

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






                    ///////////////////////////////////////////
                    ///////////////////////////////////////////
                    ///////////////////////////////////////////
                    ///////////////////////////////////////////
                    ///////////////////////////////////////////
                    ///////////////////////////////////////////
                    ///////////////////////////////////////////
                    ///////////////////////////////////////////
                    ///////////////////////////////////////////

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
            /*
       Dim oAp As ComPronto.Aplicacion
       Dim oCP As ComPronto.ComprobanteProveedor
       Dim oPr As ComPronto.Proveedor
       Dim oPar As ComPronto.Parametro
       Dim oOP As ComPronto.OrdenPago
       Dim oRsAux1 As ADOR.Recordset
       Dim oRsAux2 As ADOR.Recordset
       Dim oF As Form
       Dim oEx As Excel.Application
   
       Dim mOk As Boolean, mConProblemas As Boolean, mTomarCuentaDePresupuesto As Boolean
       Dim mArchivo As String, mComprobante As String, mCuit As String, mLetra As String, mBienesOServicios As String, mObservaciones As String, mRazonSocial As String
       Dim mIncrementarReferencia As String, mCondicionCompra As String, mCodProv As String, mNumeroCAI As String, mFecha1 As String, mError As String, mCodObra As String
       Dim mInformacionAuxiliar As String, mCuitDefault As String, mCodigoCuentaGasto As String, mTipo As String, mItemPresupuestoObrasNodo As String
       Dim mFechaFactura As Date, mFechaVencimientoCAI As Date, mFechaRecepcion As Date
       Dim mIdMonedaPesos As Integer, mIdTipoComprobanteFacturaCompra As Integer, mIdUnidadPorUnidad As Integer, fl As Integer, mContador As Integer, mIdCuentaIvaCompras1 As Integer
       Dim i As Integer, mIdUO As Integer, mvarProvincia As Integer, mIdTipoComprobante As Integer, mIdCodigoIva As Integer, mvarIBCondicion As Integer, mvarIdIBCondicion As Integer
       Dim mvarIGCondicion As Integer, mvarIdTipoRetencionGanancia As Integer, mvarPosicionCuentaIva As Integer
       Dim mIdProveedor As Long, mNumeroComprobante1 As Long, mNumeroComprobante2 As Long, mCodigoCuenta As Long, mNumeroReferencia As Long, mCodigoCuentaFF As Long, mNumeroOP As Long
       Dim mIdOrdenPago As Long, mAux1 As Long, mAux2 As Long, mNumeroRendicion As Long, mIdCuenta As Long, mIdCuenta1 As Long, mIdObra As Long, mCodigoCuenta1 As Long, mIdCuentaFF As Long
       Dim mIdCuentaGasto As Long, mIdPresupuestoObrasNodo As Long, mIdRubroContable As Long
       Dim mvarCotizacionDolar As Single, mPorcentajeIVA As Single
       Dim mTotalItem As Double, mIva1 As Double, mGravado As Double, mNoGravado As Double, mTotalBruto As Double, mTotalIva1 As Double, mTotalComprobante As Double, mTotalPercepcion As Double
       Dim mTotalAjusteIVA As Double, mAjusteIVA As Double, mBruto As Double, mPercepcion As Double
       Dim mIdCuentaIvaCompras(10) As Long
       Dim mIVAComprasPorcentaje(10) As Single
       Dim mAux

       On Error GoTo Mal

       Set oF = New frmPathPresto
       With oF
          .Id = 14
          .Show vbModal
          mOk = .Ok
          If mOk Then
             mArchivo = .FileBrowser1(0).Text
             mFechaRecepcion = .DTFields(0).Value
             mNumeroReferencia = Val(.Text1.Text)
          End If
       End With
       Unload oF
       Set oF = Nothing

       If Not mOk Then Exit Sub

       Set oAp = Aplicacion

       mIncrementarReferencia = fondoFijoService.BuscarClaveINI("IncrementarReferenciaEnImportacionDeComprobantes")
       mCondicionCompra = fondoFijoService.BuscarClaveINI("Condicion de compra default para fondos fijos")
       mFecha1 = fondoFijoService.BuscarClaveINI("Fecha recepcion igual fecha comprobante en fondo fijo")
       mCuitDefault = fondoFijoService.BuscarClaveINI("Cuit por defecto en la importacion de fondos fijos")
   
       Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
       mIdMonedaPesos = oRsAux1.Fields("IdMoneda").Value
       mIdTipoComprobanteFacturaCompra = oRsAux1.Fields("IdTipoComprobanteFacturaCompra").Value
       mIdUnidadPorUnidad = IIf(IsNull(oRsAux1.Fields("IdUnidadPorUnidad").Value), 0, oRsAux1.Fields("IdUnidadPorUnidad").Value)
       gblFechaUltimoCierre = IIf(IsNull(oRsAux1.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), oRsAux1.Fields("FechaUltimoCierre").Value)
       For i = 1 To 10
          If Not IsNull(oRsAux1.Fields("IdCuentaIvaCompras" & i).Value) Then
             mIdCuentaIvaCompras(i) = oRsAux1.Fields("IdCuentaIvaCompras" & i).Value
             mIVAComprasPorcentaje(i) = oRsAux1.Fields("IVAComprasPorcentaje" & i).Value
          Else
             mIdCuentaIvaCompras(i) = 0
             mIVAComprasPorcentaje(i) = 0
          End If
       Next
       oRsAux1.Close
   
       mTomarCuentaDePresupuesto = False
       mAux = TraerValorParametro2("TomarCuentaDePresupuestoEnComprobantesProveedores")
       If Not IsNull(mAux) And mAux = "SI" Then mTomarCuentaDePresupuesto = True
   
       Set oF = New frmAviso
       With oF
          .Label1 = "Iniciando EXCEL ..."
          .Show
          .Refresh
          DoEvents
       End With

       oF.Label1 = oF.Label1 & vbCrLf & "Procesando fondo fijo ..."
       oF.Label2 = ""
       oF.Label3 = ""
       DoEvents

       fl = 7
       mContador = 0
       mNumeroRendicion = 0
       mIdCuentaFF = 0
   
       Set oEx = CreateObject("Excel.Application")
       With oEx
          .Visible = True
          .WindowState = xlMinimized
          Me.Refresh
      
          With .Workbooks.Open(mArchivo)
             .Sheets("FF").Select
             With .ActiveSheet
                Do While True
                   If Len(Trim(.Cells(fl, 2))) > 0 Or Len(Trim(.Cells(fl, 3))) > 0 Or Len(Trim(.Cells(fl, 4))) > 0 Or _
                         Len(Trim(.Cells(fl, 5))) > 0 Or Len(Trim(.Cells(fl, 9))) > 0 Or Len(Trim(.Cells(fl, 10))) > 0 Then
                      mConProblemas = False
                  
                      If mNumeroRendicion = 0 And IsNumeric(.Cells(2, 16)) Then mNumeroRendicion = .Cells(2, 16)
                      mContador = mContador + 1
                      oF.Label2 = "Comprobante : " & .Cells(fl, 8)
                      oF.Label3 = "" & mContador
                      DoEvents
               
                      mTipo = .Cells(fl, 4)
                      If Len(.Cells(fl, 5)) > 0 Then
                         mIdTipoComprobante = .Cells(fl, 5)
                      Else
                         mIdTipoComprobante = mIdTipoComprobanteFacturaCompra
                      End If
                      mLetra = Trim(.Cells(fl, 6))
                      mNumeroComprobante1 = .Cells(fl, 7)
                      mNumeroComprobante2 = .Cells(fl, 8)
                      mRazonSocial = Mid(.Cells(fl, 9), 1, 50)
                      mCuit = .Cells(fl, 10)
                      If Len(mCuit) <> 13 Then
                         If Len(mCuit) = 11 Then
                            mCuit = VBA.Mid(mCuit, 1, 2) & "-" & VBA.Mid(mCuit, 3, 8) & "-" & VBA.Mid(mCuit, 11, 1)
                         Else
                            mCuit = ""
                         End If
                      End If
                      mFechaFactura = CDate(.Cells(fl, 3))
                      mNumeroCAI = .Cells(fl, 18)
                      If IsDate(.Cells(fl, 19)) Then
                         mFechaVencimientoCAI = CDate(.Cells(fl, 19))
                      Else
                         mFechaVencimientoCAI = 0
                      End If
                      If mFecha1 = "SI" Then mFechaRecepcion = mFechaFactura
                      mCodObra = Trim(.Cells(fl, 2))
                  
                      If mIdCuentaFF = 0 Then
                         If Len(.Cells(2, 10)) = 0 Then
                            MsgBox "Debe definir la cuenta del fondo fijo", vbExclamation
                            Exit Do
                         End If
                         mCodigoCuentaFF = .Cells(2, 10)
                         Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuentaFF)
                         If oRsAux1.RecordCount > 0 Then
                            mIdCuentaFF = oRsAux1.Fields(0).Value
                         Else
                            mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & Format(mNumeroComprobante1, "0000") & _
                                  "-" & Format(mNumeroComprobante2, "00000000") & ", cuenta de fondo fijo inexistente"
                            fl = fl + 1
                            GoTo FinLoop
                         End If
                         oRsAux1.Close
                      End If
                                    
                      mIdObra = 0
                      Set oRsAux1 = oAp.Obras.TraerFiltrado("_PorNumero", mCodObra)
                      If oRsAux1.RecordCount > 0 Then
                         mIdObra = oRsAux1.Fields("IdObra").Value
                      Else
                         mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & Format(mNumeroComprobante1, "0000") & _
                                  "-" & Format(mNumeroComprobante2, "00000000") & ", fila " & fl & "  - Obra " & mCodObra & " inexistente"
                         fl = fl + 1
                         GoTo FinLoop
                      End If
                      oRsAux1.Close
                  
                      If mFechaRecepcion > gblFechaUltimoCierre Then
                         If Len(mCuit) = 0 Then mCuit = mCuitDefault
                         If Len(mCuit) = 0 Then
    '                        mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & Format(mNumeroComprobante1, "0000") & _
    '                              "-" & Format(mNumeroComprobante2, "00000000") & ", fila " & fl & "  - Cuit inexistente"
    '                        fl = fl + 1
    '                        GoTo FinLoop
                         Else
                            If Not VerificarCuit(mCuit) Then
                               mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & Format(mNumeroComprobante1, "0000") & _
                                  "-" & Format(mNumeroComprobante2, "00000000") & ", fila " & fl & "  - Cuit invalido : " & mCuit
                               fl = fl + 1
                               GoTo FinLoop
                            End If
                         End If
                     
                         mIdProveedor = 0
                         If Len(mCuit) > 0 Then
                            Set oRsAux1 = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)
                         Else
                            Set oRsAux1 = oAp.Proveedores.TraerFiltrado("_PorNombre", mRazonSocial)
                         End If
                         If oRsAux1.RecordCount > 0 Then
                            mIdProveedor = oRsAux1.Fields(0).Value
                            mvarProvincia = IIf(IsNull(oRsAux1.Fields("IdProvincia").Value), 0, oRsAux1.Fields("IdProvincia").Value)
                            mvarIBCondicion = IIf(IsNull(oRsAux1.Fields("IBCondicion").Value), 0, oRsAux1.Fields("IBCondicion").Value)
                            mvarIdIBCondicion = IIf(IsNull(oRsAux1.Fields("IdIBCondicionPorDefecto").Value), 0, oRsAux1.Fields("IdIBCondicionPorDefecto").Value)
                            mvarIGCondicion = IIf(IsNull(oRsAux1.Fields("IGCondicion").Value), 0, oRsAux1.Fields("IGCondicion").Value)
                            mvarIdTipoRetencionGanancia = IIf(IsNull(oRsAux1.Fields("IdTipoRetencionGanancia").Value), 0, oRsAux1.Fields("IdTipoRetencionGanancia").Value)
                            mBienesOServicios = IIf(IsNull(oRsAux1.Fields("BienesOServicios").Value), "B", oRsAux1.Fields("BienesOServicios").Value)
                            mIdCodigoIva = IIf(IsNull(oRsAux1.Fields("IdCodigoIva").Value), 0, oRsAux1.Fields("IdCodigoIva").Value)
                         Else
                            If Len(mCuit) > 0 Then
                               If mLetra = "C" Then
                                  mIdCodigoIva = 6
                               Else
                                  mIdCodigoIva = 1
                               End If
                            Else
                               mIdCodigoIva = 5
                            End If
                            Set oPr = oAp.Proveedores.Item(-1)
                            With oPr.Registro
                               .Fields("Confirmado").Value = "NO"
                               .Fields("RazonSocial").Value = Mid(mRazonSocial, 1, 50)
                               .Fields("CUIT").Value = mCuit
                               .Fields("EnviarEmail").Value = 1
                               If mIdCodigoIva <> 0 Then .Fields("IdCodigoIva").Value = mIdCodigoIva
                               If IsNumeric(mCondicionCompra) Then .Fields("IdCondicionCompra").Value = CInt(mCondicionCompra)
                            End With
                            oPr.Guardar
                            mIdProveedor = oPr.Registro.Fields(0).Value
                            Set oPr = Nothing
                            mvarProvincia = 0
                            mvarIBCondicion = 0
                            mvarIdIBCondicion = 0
                            mvarIGCondicion = 0
                            mvarIdTipoRetencionGanancia = 0
                            mBienesOServicios = "B"
                         End If
                         oRsAux1.Close
                     
                         Set oRsAux1 = oAp.ComprobantesProveedores.TraerFiltrado("_PorNumeroComprobante", _
                                        Array(mIdProveedor, mLetra, mNumeroComprobante1, mNumeroComprobante2, -1, mIdTipoComprobante))
                         If oRsAux1.RecordCount = 0 Then
                            mvarCotizacionDolar = Cotizacion(mFechaFactura, glbIdMonedaDolar)
                            If mvarCotizacionDolar = 0 Then mConProblemas = True
                            Set oCP = oAp.ComprobantesProveedores.Item(-1)
                            With oCP
                               With .Registro
                                  .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                                  .Fields("IdObra").Value = mIdObra
                                  .Fields("FechaComprobante").Value = mFechaFactura
                                  If mFechaFactura > mFechaRecepcion Then
                                     .Fields("FechaRecepcion").Value = mFechaFactura
                                  Else
                                     .Fields("FechaRecepcion").Value = mFechaRecepcion
                                  End If
                                  .Fields("FechaVencimiento").Value = mFechaFactura
                                  .Fields("FechaAsignacionPresupuesto").Value = mFechaFactura
                                  .Fields("IdMoneda").Value = mIdMonedaPesos
                                  .Fields("CotizacionMoneda").Value = 1
                                  .Fields("CotizacionDolar").Value = mvarCotizacionDolar
                                  .Fields("IdProveedorEventual").Value = mIdProveedor
                                  .Fields("IdProveedor").Value = Null
                                  .Fields("IdCuenta").Value = mIdCuentaFF
                                  .Fields("IdOrdenPago").Value = Null
                                  .Fields("Letra").Value = mLetra
                                  .Fields("NumeroComprobante1").Value = mNumeroComprobante1
                                  .Fields("NumeroComprobante2").Value = mNumeroComprobante2
                                  .Fields("NumeroRendicionFF").Value = mNumeroRendicion
                                  If (mvarIBCondicion = 2 Or mvarIBCondicion = 3) And mvarIdIBCondicion <> 0 Then
                                     .Fields("IdIBCondicion").Value = mvarIdIBCondicion
                                  Else
                                     .Fields("IdIBCondicion").Value = Null
                                  End If
                                  If (mvarIGCondicion = 2 Or mvarIGCondicion = 3) And mvarIdTipoRetencionGanancia <> 0 Then
                                     .Fields("IdTipoRetencionGanancia").Value = mvarIdTipoRetencionGanancia
                                  Else
                                     .Fields("IdTipoRetencionGanancia").Value = Null
                                  End If
                                  .Fields("IdProvinciaDestino").Value = mvarProvincia
                                  .Fields("BienesOServicios").Value = Null
                                  .Fields("NumeroCAI").Value = mNumeroCAI
                                  If mFechaVencimientoCAI <> 0 Then
                                     .Fields("FechaVencimientoCAI").Value = mFechaVencimientoCAI
                                  Else
                                     .Fields("FechaVencimientoCAI").Value = Null
                                  End If
                                  .Fields("DestinoPago").Value = "O"
                                  .Fields("InformacionAuxiliar").Value = mInformacionAuxiliar
                                  If mIdCodigoIva <> 0 Then .Fields("IdCodigoIva").Value = mIdCodigoIva
                                  .Fields("CircuitoFirmasCompleto").Value = "SI"
                               End With
                            End With
                        
                            mTotalBruto = 0
                            mTotalIva1 = 0
                            mTotalPercepcion = 0
                            mTotalComprobante = 0
                            mTotalAjusteIVA = 0
                            mAjusteIVA = 0
                        
                            Do While Len(Trim(.Cells(fl, 2))) > 0 And mLetra = Trim(.Cells(fl, 6)) And _
                                  mNumeroComprobante1 = .Cells(fl, 7) And mNumeroComprobante2 = .Cells(fl, 8) And (mCuit = .Cells(fl, 10) Or mCuit = mCuitDefault)
                               mCodigoCuentaGasto = .Cells(fl, 22)
                               mItemPresupuestoObrasNodo = Trim(.Cells(fl, 24))
                           
                               mIdCuentaGasto = 0
                               mIdCuenta = 0
                               mCodigoCuenta = 0
                               mIdRubroContable = 0
                               If Len(mCodigoCuentaGasto) > 0 Then
                                  Set oRsAux1 = oAp.CuentasGastos.TraerFiltrado("_PorCodigo2", mCodigoCuentaGasto)
                                  If oRsAux1.RecordCount > 0 Then
                                     mIdCuentaGasto = oRsAux1.Fields("IdCuentaGasto").Value
                                     oRsAux1.Close
                                     Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorObraCuentaGasto", Array(mIdObra, mIdCuentaGasto))
                                     If oRsAux1.RecordCount > 0 Then
                                        mIdCuenta = oRsAux1.Fields("IdCuenta").Value
                                        mCodigoCuenta = oRsAux1.Fields("Codigo").Value
                                        mIdRubroContable = IIf(IsNull(oRsAux1.Fields("IdRubroFinanciero").Value), 0, oRsAux1.Fields("IdRubroFinanciero").Value)
                                     Else
                                        If Not mTomarCuentaDePresupuesto Then
                                           mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & Format(mNumeroComprobante1, "0000") & _
                                              "-" & Format(mNumeroComprobante2, "00000000") & ", fila " & fl & "  - Cuenta de gasto codigo :" & mCodigoCuentaGasto & " inexistente"
                                           fl = fl + 1
                                           GoTo FinLoop
                                        End If
                                     End If
                                  Else
                                     oRsAux1.Close
                                     Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuentaGasto)
                                     If oRsAux1.RecordCount > 0 Then
                                        mIdCuenta = oRsAux1.Fields("IdCuenta").Value
                                        mCodigoCuenta = oRsAux1.Fields("Codigo").Value
                                        mIdRubroContable = IIf(IsNull(oRsAux1.Fields("IdRubroFinanciero").Value), 0, oRsAux1.Fields("IdRubroFinanciero").Value)
                                     Else
                                        If Not mTomarCuentaDePresupuesto Then
                                           mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & Format(mNumeroComprobante1, "0000") & _
                                              "-" & Format(mNumeroComprobante2, "00000000") & ", fila " & fl & "  - Cuenta contable inexistente"
                                           fl = fl + 1
                                           GoTo FinLoop
                                        End If
                                     End If
                                  End If
                                  oRsAux1.Close
                               End If
                           
                               mIdPresupuestoObrasNodo = 0
                               If Len(mItemPresupuestoObrasNodo) > 0 Then
                                  Set oRsAux1 = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_PorItem", Array(mItemPresupuestoObrasNodo, mIdObra))
                                  If oRsAux1.RecordCount = 1 Then
                                     mIdPresupuestoObrasNodo = oRsAux1.Fields("IdPresupuestoObrasNodo").Value
                                     mIdCuenta = IIf(IsNull(oRsAux1.Fields("IdCuenta").Value), 0, oRsAux1.Fields("IdCuenta").Value)
                                  End If
                                  oRsAux1.Close
                               End If
                           
                               Set oRsAux1 = Aplicacion.Cuentas.TraerFiltrado("_PorId", mIdCuenta)
                               If oRsAux1.RecordCount > 0 Then
                                  If IIf(IsNull(oRsAux1.Fields("ImputarAPresupuestoDeObra").Value), "NO", oRsAux1.Fields("ImputarAPresupuestoDeObra").Value) = "NO" And Not mTomarCuentaDePresupuesto Then
                                     mIdPresupuestoObrasNodo = 0
                                  End If
                                  mCodigoCuenta = oRsAux1.Fields("Codigo").Value
                                  mIdRubroContable = IIf(IsNull(oRsAux1.Fields("IdRubroFinanciero").Value), 0, oRsAux1.Fields("IdRubroFinanciero").Value)
                               Else
                                  mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & Format(mNumeroComprobante1, "0000") & _
                                     "-" & Format(mNumeroComprobante2, "00000000") & ", fila " & fl & "  - Cuenta contable inexistente"
                                  fl = fl + 1
                                  GoTo FinLoop
                               End If
                               oRsAux1.Close
                           
                               mBruto = Abs(CDbl(.Cells(fl, 13)))
                               mIva1 = Round(Abs(CDbl(.Cells(fl, 14))), 4)
                               mPercepcion = Abs(CDbl(.Cells(fl, 15)))
                               mTotalItem = Round(Abs(CDbl(.Cells(fl, 16))), 2)
                               mObservaciones = "Rendicion : " & mNumeroRendicion & vbCrLf & .Cells(fl, 20) & vbCrLf
                           
                               mTotalBruto = mTotalBruto + mBruto
                               mTotalIva1 = mTotalIva1 + mIva1
                               mTotalPercepcion = mTotalPercepcion + mPercepcion
                               mTotalComprobante = mTotalComprobante + mTotalItem
                               mTotalAjusteIVA = mTotalAjusteIVA + mAjusteIVA
                               mPorcentajeIVA = 0
                               If mIva1 <> 0 And mBruto <> 0 Then mPorcentajeIVA = .Cells(fl, 11)
                           
                               mIdCuentaIvaCompras1 = 0
                               mvarPosicionCuentaIva = 1
                               If mPorcentajeIVA <> 0 Then
                                  For i = 1 To 10
                                     If mIVAComprasPorcentaje(i) = mPorcentajeIVA Then
                                        mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(i)
                                        mvarPosicionCuentaIva = i
                                        Exit For
                                     End If
                                  Next
                               End If
                               If mIva1 <> 0 And mIdCuentaIvaCompras1 = 0 Then
                                  mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & Format(mNumeroComprobante1, "0000") & _
                                  "-" & Format(mNumeroComprobante2, "00000000") & ", fila " & fl & "  - No se encontro el porcentaje de iva " & mPorcentajeIVA
                                  fl = fl + 1
                                  GoTo FinLoop
                               End If
                           
                               With oCP.DetComprobantesProveedores.Item(-1)
                                  With .Registro
                                     .Fields("IdObra").Value = mIdObra
                                     .Fields("IdCuentaGasto").Value = mIdCuentaGasto
                                     .Fields("IdCuenta").Value = mIdCuenta
                                     .Fields("CodigoCuenta").Value = mCodigoCuenta
                                     .Fields("Importe").Value = mBruto
                                     .Fields("IdCuentaIvaCompras1").Value = Null
                                     .Fields("IVAComprasPorcentaje1").Value = 0
                                     .Fields("ImporteIVA1").Value = 0
                                     .Fields("AplicarIVA1").Value = "NO"
                                     .Fields("IdCuentaIvaCompras2").Value = Null
                                     .Fields("IVAComprasPorcentaje2").Value = 0
                                     .Fields("ImporteIVA2").Value = 0
                                     .Fields("AplicarIVA2").Value = "NO"
                                     .Fields("IdCuentaIvaCompras3").Value = Null
                                     .Fields("IVAComprasPorcentaje3").Value = 0
                                     .Fields("ImporteIVA3").Value = 0
                                     .Fields("AplicarIVA3").Value = "NO"
                                     .Fields("IdCuentaIvaCompras4").Value = Null
                                     .Fields("IVAComprasPorcentaje4").Value = 0
                                     .Fields("ImporteIVA4").Value = 0
                                     .Fields("AplicarIVA4").Value = "NO"
                                     .Fields("IdCuentaIvaCompras5").Value = Null
                                     .Fields("IVAComprasPorcentaje5").Value = 0
                                     .Fields("ImporteIVA5").Value = 0
                                     .Fields("AplicarIVA5").Value = "NO"
                                     .Fields("IdCuentaIvaCompras6").Value = Null
                                     .Fields("IVAComprasPorcentaje6").Value = 0
                                     .Fields("ImporteIVA6").Value = 0
                                     .Fields("AplicarIVA6").Value = "NO"
                                     .Fields("IdCuentaIvaCompras7").Value = Null
                                     .Fields("IVAComprasPorcentaje7").Value = 0
                                     .Fields("ImporteIVA7").Value = 0
                                     .Fields("AplicarIVA7").Value = "NO"
                                     .Fields("IdCuentaIvaCompras8").Value = Null
                                     .Fields("IVAComprasPorcentaje8").Value = 0
                                     .Fields("ImporteIVA8").Value = 0
                                     .Fields("AplicarIVA8").Value = "NO"
                                     .Fields("IdCuentaIvaCompras9").Value = Null
                                     .Fields("IVAComprasPorcentaje9").Value = 0
                                     .Fields("ImporteIVA9").Value = 0
                                     .Fields("AplicarIVA9").Value = "NO"
                                     .Fields("IdCuentaIvaCompras10").Value = Null
                                     .Fields("IVAComprasPorcentaje10").Value = 0
                                     If mIdCuentaIvaCompras1 <> 0 Then
                                        .Fields("IdCuentaIvaCompras" & mvarPosicionCuentaIva).Value = mIdCuentaIvaCompras1
                                        .Fields("IVAComprasPorcentaje" & mvarPosicionCuentaIva).Value = mPorcentajeIVA
                                        .Fields("ImporteIVA" & mvarPosicionCuentaIva).Value = Round(mIva1, 2)
                                        .Fields("AplicarIVA" & mvarPosicionCuentaIva).Value = "SI"
                                     End If
                                     .Fields("ImporteIVA10").Value = 0
                                     .Fields("AplicarIVA10").Value = "NO"
                                     If mIdPresupuestoObrasNodo <> 0 Then .Fields("IdPresupuestoObrasNodo").Value = mIdPresupuestoObrasNodo
                                     If mIdRubroContable > 0 Then .Fields("IdRubroContable").Value = mIdRubroContable
                                  End With
                                  .Modificado = True
                               End With
                        
                               fl = fl + 1
                            Loop
                        
                            With oCP
                               With .Registro
                                  .Fields("NumeroReferencia").Value = mNumeroReferencia
                                  .Fields("Confirmado").Value = "NO"
                                  .Fields("TotalBruto").Value = mTotalBruto
                                  .Fields("TotalIva1").Value = mTotalIva1
                                  .Fields("TotalIva2").Value = 0
                                  .Fields("TotalBonificacion").Value = 0
                                  .Fields("TotalComprobante").Value = mTotalComprobante
                                  .Fields("PorcentajeBonificacion").Value = 0
                                  .Fields("TotalIVANoDiscriminado").Value = 0
                                  .Fields("AjusteIVA").Value = mTotalAjusteIVA
                                  .Fields("Observaciones").Value = mObservaciones
                                  If mIncrementarReferencia <> "SI" Then .Fields("AutoincrementarNumeroReferencia").Value = "NO"
                               End With
                               .Guardar
                            End With
                            Set oCP = Nothing
                     
                            mNumeroReferencia = mNumeroReferencia + 1
                         Else
                            fl = fl + 1
                         End If
                      Else
                         mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & Format(mNumeroComprobante1, "0000") & _
                                  "-" & Format(mNumeroComprobante2, "00000000") & ", fila " & fl & "  - Fecha es anterior al ultimo cierre contable : " & mComprobante
                         fl = fl + 1
                      End If
                   Else
                      Exit Do
                   End If
    FinLoop:
                Loop
             End With
             .Close False
          End With
          .Quit
       End With
   
       If Len(mError) > 0 Then
          MsgBox "Los siguientes comprobantes no se importaron :" & vbCrLf & mError, vbExclamation
       End If

    Salida:

       Unload oF
       Set oF = Nothing

       Set oRsAux1 = Nothing
       Set oRsAux2 = Nothing
       Set oAp = Nothing
       Set oEx = Nothing
       Set oCP = Nothing
       Set oOP = Nothing

       Exit Sub

    Mal:

       MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
       Resume Salida
            */
        }






        void ImportacionComprobantesFondoFijo()
        {
            /*
            Dim oAp As ComPronto.Aplicacion
            Dim oCP As ComPronto.ComprobanteProveedor
            Dim oPr As ComPronto.Proveedor
            Dim oPar As ComPronto.Parametro
            Dim oOP As ComPronto.OrdenPago
            Dim oRsAux1 As ADOR.Recordset
            Dim oRsAux2 As ADOR.Recordset
            Dim oF As Form
            Dim oEx As Excel.Application
            Dim mOk As Boolean, mConProblemas As Boolean
            Dim mArchivo As String, mComprobante As String, mCuit As String, mLetra As String
            Dim mBienesOServicios As String, mObservaciones As String, mRazonSocial As String
            Dim mIncrementarReferencia As String, mCondicionCompra As String
            Dim mNumeroCAI As String, mFecha1 As String, mError As String
            Dim mInformacionAuxiliar As String, mCuitDefault As String
            Dim mFechaFactura As Date, mFechaVencimientoCAI As Date, mFechaRecepcion As Date
            Dim mIdMonedaPesos As Integer, mIdTipoComprobanteFacturaCompra As Integer
            Dim mIdUnidadPorUnidad As Integer, fl As Integer, mContador As Integer
            Dim mIdCuentaIvaCompras1 As Integer, mIdCuenta As Long, mIdObra As Integer
            Dim mIdCuentaGasto As Integer, i As Integer, mvarProvincia As Integer
            Dim mvarIBCondicion As Integer, mvarIdIBCondicion As Integer, mIdEtapa As Integer
            Dim mvarIGCondicion As Integer, mvarIdTipoRetencionGanancia As Integer
            Dim mIdTipoComprobante As Integer, mIdCuentaFF As Integer, mIdUO As Integer
            Dim mIdCodigoIva As Integer
            Dim mIdProveedor As Long, mNumeroComprobante1 As Long, mNumeroComprobante2 As Long
            Dim mCodigoCuenta As Long, mNumeroReferencia As Long, mCodigoCuentaFF As Long
            Dim mNumeroOP As Long, mIdOrdenPago As Long, mAux1 As Long, mAux2 As Long
            Dim mNumeroRendicion As Long
            Dim mvarCotizacionDolar As Single, mPorcentajeIVA As Single
            Dim mBruto As Double, mIva1 As Double, mTotalItem As Double, mPercepcion As Double
            Dim mTotalBruto As Double, mTotalIva1 As Double, mTotalComprobante As Double
            Dim mTotalPercepcion As Double, mValores As Double, mAjusteIVA As Double
            Dim mTotalAjusteIVA As Double
            Dim mIdCuentaIvaCompras(10) As Long
            Dim mIVAComprasPorcentaje(10) As Single

            On Error GoTo Mal

            'Set oF = New frmPathPresto
            With oF
                .Id = 2
                .Show vbModal
                mOk = .Ok

                If mOk Then
                    mArchivo = .FileBrowser1(0).Text
                    mIdObra = .dcfields(0).BoundText
                    mFechaRecepcion = .DTFields(0).Value
                    mNumeroReferencia = Val(.text1.Text)
                End If

            End With

            Unload oF
            Set oF = Nothing

            If Not mOk Then Exit Sub

            Set oAp = Aplicacion

            mIncrementarReferencia = fondoFijoService.BuscarClaveINI("IncrementarReferenciaEnImportacionDeComprobantes")
            mCondicionCompra = fondoFijoService.BuscarClaveINI("Condicion de compra default para fondos fijos")
            mFecha1 = fondoFijoService.BuscarClaveINI("Fecha recepcion igual fecha comprobante en fondo fijo")
            mCuitDefault = fondoFijoService.BuscarClaveINI("Cuit por defecto en la importacion de fondos fijos")
   
            Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
            mIdMonedaPesos = oRsAux1.Fields("IdMoneda").Value
            mIdTipoComprobanteFacturaCompra = oRsAux1.Fields("IdTipoComprobanteFacturaCompra").Value
            mIdUnidadPorUnidad = IIf(IsNull(oRsAux1.Fields("IdUnidadPorUnidad").Value), 0, oRsAux1.Fields("IdUnidadPorUnidad").Value)
            gblFechaUltimoCierre = IIf(IsNull(oRsAux1.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), oRsAux1.Fields("FechaUltimoCierre").Value)

            For i = 1 To 10

                If Not IsNull(oRsAux1.Fields("IdCuentaIvaCompras" & i).Value) Then
                    mIdCuentaIvaCompras(i) = oRsAux1.Fields("IdCuentaIvaCompras" & i).Value
                    mIVAComprasPorcentaje(i) = oRsAux1.Fields("IVAComprasPorcentaje" & i).Value
                Else
                    mIdCuentaIvaCompras(i) = 0
                    mIVAComprasPorcentaje(i) = 0
                End If

            Next

            oRsAux1.Close
   
            mIdUO = 0
            Set oRsAux1 = oAp.Obras.TraerFiltrado("_PorId", mIdObra)

            If oRsAux1.RecordCount > 0 Then
                mIdUO = IIf(IsNull(oRsAux1.Fields("IdUnidadOperativa").Value), 0, oRsAux1.Fields("IdUnidadOperativa").Value)
            End If

            oRsAux1.Close
   
            'Set oF = New frmAviso
            With oF
                .Label1 = "Iniciando EXCEL ..."
                .Show
                .Refresh

                DoEvents
            End With

            oF.Label1 = oF.Label1 & vbCrLf & "Procesando fondo fijo ..."
            oF.Label2 = ""
            oF.Label3 = ""

            DoEvents

            fl = 7
            mContador = 0
            mNumeroRendicion = 0
   
            Set oEx = CreateObject("Excel.Application")

            With oEx
      
                .Visible = True
                .WindowState = xlMinimized
                Me.Refresh
      
                With .Workbooks.Open(mArchivo)
                    .Sheets("FF").Select

                    With .ActiveSheet

                        Do While True

                            If Len(Trim(.Cells(fl, 2))) > 0 Then
                                mConProblemas = False
                  
                                If mNumeroRendicion = 0 And IsNumeric(.Cells(2, 13)) Then
                                    mNumeroRendicion = .Cells(2, 13)
                                End If
                  
                                mContador = mContador + 1
                                oF.Label2 = "Comprobante : " & .Cells(fl, 5)
                                oF.Label3 = "" & mContador

                                DoEvents
               
                                If Len(.Cells(fl, 3)) > 0 Then
                                    mIdTipoComprobante = .Cells(fl, 3)
                                Else
                                    mIdTipoComprobante = mIdTipoComprobanteFacturaCompra
                                End If

                                mLetra = Trim(.Cells(fl, 4))
                                mComprobante = .Cells(fl, 5)
                                mNumeroComprobante1 = 0
                                mNumeroComprobante2 = 0

                                If InStr(1, mComprobante, "-") <> 0 Then
                                    mNumeroComprobante1 = CLng(mId(mComprobante, 1, InStr(1, mComprobante, "-") - 1))

                                    If mNumeroComprobante1 > 9999 Then
                                        MsgBox "El punto de venta no puede tener mas de 4 digitos. (Fila " & fl & ")", vbExclamation
                                        GoTo Salida
                                    End If

                                    mNumeroComprobante2 = CLng(mId(mComprobante, InStr(1, mComprobante, "-") + 1, 100))

                                    If mNumeroComprobante2 > 99999999 Then
                                        MsgBox "El numero de comprobante no puede tener mas de 8 digitos. (Fila " & fl & ")", vbExclamation
                                        GoTo Salida
                                    End If
                                End If

                                mRazonSocial = .Cells(fl, 6)
                                mCuit = .Cells(fl, 7)
                                mFechaFactura = CDate(.Cells(fl, 2))
                                mNumeroCAI = .Cells(fl, 15)

                                If IsDate(.Cells(fl, 17)) Then
                                    mFechaVencimientoCAI = CDate(.Cells(fl, 17))
                                Else
                                    mFechaVencimientoCAI = 0
                                End If

                                mInformacionAuxiliar = .Cells(fl, 18)
                  
                                If mFecha1 = "SI" Then mFechaRecepcion = mFechaFactura
                  
                                If mFechaRecepcion > gblFechaUltimoCierre Then
                                    If Len(mCuit) = 0 Then mCuit = mCuitDefault
                                    If Len(mCuit) = 0 Then
                                        mError = mError & vbCrLf & "Fila " & fl & "  - Cuit inexistente"
                                        fl = fl + 1
                                        GoTo FinLoop
                                    Else

                                        If Not VerificarCuit(mCuit) Then
                                            mError = mError & vbCrLf & "Fila " & fl & "  - Cuit invalido : " & mCuit
                                            fl = fl + 1
                                            GoTo FinLoop
                                        End If
                                    End If

                                    mIdProveedor = 0
                                    Set oRsAux1 = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)

                                    If oRsAux1.RecordCount > 0 Then
                                        mIdProveedor = oRsAux1.Fields(0).Value
                                        mvarProvincia = IIf(IsNull(oRsAux1.Fields("IdProvincia").Value), 0, oRsAux1.Fields("IdProvincia").Value)
                                        mvarIBCondicion = IIf(IsNull(oRsAux1.Fields("IBCondicion").Value), 0, oRsAux1.Fields("IBCondicion").Value)
                                        mvarIdIBCondicion = IIf(IsNull(oRsAux1.Fields("IdIBCondicionPorDefecto").Value), 0, oRsAux1.Fields("IdIBCondicionPorDefecto").Value)
                                        mvarIGCondicion = IIf(IsNull(oRsAux1.Fields("IGCondicion").Value), 0, oRsAux1.Fields("IGCondicion").Value)
                                        mvarIdTipoRetencionGanancia = IIf(IsNull(oRsAux1.Fields("IdTipoRetencionGanancia").Value), 0, oRsAux1.Fields("IdTipoRetencionGanancia").Value)
                                        mBienesOServicios = IIf(IsNull(oRsAux1.Fields("BienesOServicios").Value), "B", oRsAux1.Fields("BienesOServicios").Value)
                                        mIdCodigoIva = IIf(IsNull(oRsAux1.Fields("IdCodigoIva").Value), 0, oRsAux1.Fields("IdCodigoIva").Value)
                                    Else

                                        If mLetra = "B" Or mLetra = "C" Then
                                            mIdCodigoIva = 0
                                        Else
                                            mIdCodigoIva = 1
                                        End If

                                        Set oPr = oAp.Proveedores.Item(-1)

                                        With oPr.Registro
                                            .Fields("Confirmado").Value = "NO"
                                            .Fields("RazonSocial").Value = mId(mRazonSocial, 1, 50)
                                            .Fields("CUIT").Value = mCuit
                                            .Fields("EnviarEmail").Value = 1

                                            If mIdCodigoIva <> 0 Then .Fields("IdCodigoIva").Value = mIdCodigoIva
                                            If IsNumeric(mCondicionCompra) Then
                                                .Fields("IdCondicionCompra").Value = CInt(mCondicionCompra)
                                            End If

                                        End With

                                        oPr.Guardar
                                        mIdProveedor = oPr.Registro.Fields(0).Value
                                        Set oPr = Nothing
                                        mvarProvincia = 0
                                        mvarIBCondicion = 0
                                        mvarIdIBCondicion = 0
                                        mvarIGCondicion = 0
                                        mvarIdTipoRetencionGanancia = 0
                                        mBienesOServicios = "B"
                                    End If

                                    oRsAux1.Close
                     
                                    mCodigoCuentaFF = .Cells(fl, 20)
                                    mIdCuentaFF = 0
                                    Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuentaFF)

                                    If oRsAux1.RecordCount > 0 Then
                                        mIdCuentaFF = oRsAux1.Fields(0).Value
                                    End If
                  
                                    Set oRsAux1 = oAp.ComprobantesProveedores.TraerFiltrado("_PorNumeroComprobante", Array(mIdProveedor, mLetra, mNumeroComprobante1, mNumeroComprobante2, -1, mIdTipoComprobante))

                                    If oRsAux1.RecordCount = 0 Then
                                        mvarCotizacionDolar = Cotizacion(mFechaFactura, glbIdMonedaDolar)

                                        If mvarCotizacionDolar = 0 Then
                                            mConProblemas = True
                                        End If

                                        Set oCP = oAp.ComprobantesProveedores.Item(-1)

                                        With oCP
                                            With .Registro
                                                .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                                                .Fields("IdObra").Value = mIdObra
                                                .Fields("FechaComprobante").Value = mFechaFactura
                                                .Fields("FechaRecepcion").Value = mFechaRecepcion
                                                .Fields("FechaVencimiento").Value = mFechaFactura
                                                .Fields("IdMoneda").Value = mIdMonedaPesos
                                                .Fields("CotizacionMoneda").Value = 1
                                                .Fields("CotizacionDolar").Value = mvarCotizacionDolar
                                                .Fields("IdProveedorEventual").Value = mIdProveedor
                                                .Fields("IdProveedor").Value = Null
                                                .Fields("IdCuenta").Value = mIdCuentaFF
                                                .Fields("IdOrdenPago").Value = Null ' -9
                                                .Fields("Letra").Value = mLetra
                                                .Fields("NumeroComprobante1").Value = mNumeroComprobante1
                                                .Fields("NumeroComprobante2").Value = mNumeroComprobante2
                                                .Fields("NumeroRendicionFF").Value = mNumeroRendicion

                                                If (mvarIBCondicion = 2 Or mvarIBCondicion = 3) And mvarIdIBCondicion <> 0 Then
                                                    .Fields("IdIBCondicion").Value = mvarIdIBCondicion
                                                Else
                                                    .Fields("IdIBCondicion").Value = Null
                                                End If

                                                If (mvarIGCondicion = 2 Or mvarIGCondicion = 3) And mvarIdTipoRetencionGanancia <> 0 Then
                                                    .Fields("IdTipoRetencionGanancia").Value = mvarIdTipoRetencionGanancia
                                                Else
                                                    .Fields("IdTipoRetencionGanancia").Value = Null
                                                End If

                                                .Fields("IdProvinciaDestino").Value = mvarProvincia
                                                .Fields("BienesOServicios").Value = Null
                                                .Fields("NumeroCAI").Value = mNumeroCAI

                                                If mFechaVencimientoCAI <> 0 Then
                                                    .Fields("FechaVencimientoCAI").Value = mFechaVencimientoCAI
                                                Else
                                                    .Fields("FechaVencimientoCAI").Value = Null
                                                End If

                                                .Fields("DestinoPago").Value = "O"
                                                .Fields("InformacionAuxiliar").Value = mInformacionAuxiliar

                                                If mIdCodigoIva <> 0 Then .Fields("IdCodigoIva").Value = mIdCodigoIva
                                            End With
                                        End With
                        
                                        mTotalBruto = 0
                                        mTotalIva1 = 0
                                        mTotalPercepcion = 0
                                        mTotalComprobante = 0
                                        mTotalAjusteIVA = 0
                                        mObservaciones = ""

                                        Do While Len(Trim(.Cells(fl, 2))) > 0 And mComprobante = .Cells(fl, 5) And (mCuit = .Cells(fl, 7) Or mCuit = mCuitDefault)
   
                                            mCodigoCuenta = CLng(.Cells(fl, 9))
                                            mBruto = Abs(CDbl(.Cells(fl, 10)))
                                            mIva1 = Round(Abs(CDbl(.Cells(fl, 11))), 4)
                                            mPercepcion = Abs(CDbl(.Cells(fl, 12)))
                                            mTotalItem = Round(Abs(CDbl(.Cells(fl, 13))), 2)
                                            mObservaciones = mObservaciones & .Cells(fl, 19) & vbCrLf
                                            mAjusteIVA = 0

                                            If Len(.Cells(5, 24)) > 0 Then
                                                mAjusteIVA = CDbl(.Cells(fl, 24))
                                            End If

                                            mAux1 = 0

                                            If Len(.Cells(fl, 25)) > 0 And IsNumeric(.Cells(fl, 25)) Then
                                                mAux1 = CLng(.Cells(fl, 25))
                                            End If
                           
                                            mTotalBruto = mTotalBruto + mBruto
                                            mTotalIva1 = mTotalIva1 + mIva1
                                            mTotalPercepcion = mTotalPercepcion + mPercepcion
                                            mTotalComprobante = mTotalComprobante + mTotalItem
                                            mTotalAjusteIVA = mTotalAjusteIVA + mAjusteIVA
                           
                                            mPorcentajeIVA = 0

                                            If mIva1 <> 0 And mBruto <> 0 Then
                                                mPorcentajeIVA = Round(mIva1 / mBruto * 100, 1)
                                            End If
                           
                                            mIdCuentaIvaCompras1 = 0

                                            If mPorcentajeIVA <> 0 Then

                                                For i = 1 To 10

                                                    If mIVAComprasPorcentaje(i) = mPorcentajeIVA Then
                                                        mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(i)
                                                        Exit For
                                                    End If

                                                Next

                                            End If

                                            If mTotalIva1 <> 0 And mIdCuentaIvaCompras1 = 0 Then
                                                mConProblemas = True
                                            End If
                           
                                            mIdCuenta = 0
                                            mIdCuentaGasto = 0

                                            If mCodigoCuenta > 1000 Then
                                                Set oRsAux2 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuenta)

                                                If oRsAux2.RecordCount > 0 Then
                                                    mIdCuenta = oRsAux2.Fields(0).Value

                                                    If IsNumeric(.Cells(fl, 23)) And Not IsNull(oRsAux2.Fields("IdObra").Value) Then
                                                        mIdObra = oRsAux2.Fields("IdObra").Value
                                                    End If
                                                End If

                                            Else
                                                Set oRsAux2 = oAp.CuentasGastos.TraerFiltrado("_PorId", mCodigoCuenta)

                                                If oRsAux2.RecordCount > 0 Then
                                                    mIdCuentaGasto = oRsAux2.Fields(0).Value
                                                End If
                                            End If

                                            oRsAux2.Close

                                            If mIdCuentaGasto = 0 And mIdCuenta = 0 Then
                                                mConProblemas = True
                                            End If

                                            If mIdCuenta = 0 Then
                                                Set oRsAux2 = oAp.Cuentas.TraerFiltrado("_PorObraCuentaGasto", Array(mIdObra, mIdCuentaGasto))

                                                If oRsAux2.RecordCount > 0 Then
                                                    mIdCuenta = oRsAux2.Fields(0).Value
                                                    mCodigoCuenta = oRsAux2.Fields("Codigo").Value
                                                End If

                                                oRsAux2.Close

                                                If mIdCuentaGasto = 0 Then
                                                    mConProblemas = True
                                                End If
                                            End If
                           
                                            mAux2 = 0

                                            If mAux1 <> 0 Then
                                                Set oRsAux2 = oAp.RubrosContables.TraerFiltrado("_PorCodigo", mAux1)

                                                If oRsAux2.RecordCount > 0 Then
                                                    mAux2 = oRsAux2.Fields(0).Value
                                                End If

                                                oRsAux2.Close
                                            End If
                           
                                            With oCP.DetComprobantesProveedores.Item(-1)
                                                With .Registro
                                                    .Fields("IdObra").Value = mIdObra
                                                    .Fields("IdCuentaGasto").Value = mIdCuentaGasto
                                                    .Fields("IdCuenta").Value = mIdCuenta
                                                    .Fields("CodigoCuenta").Value = mCodigoCuenta
                                                    .Fields("Importe").Value = mBruto

                                                    If mIdCuentaIvaCompras1 <> 0 Then
                                                        .Fields("IdCuentaIvaCompras1").Value = mIdCuentaIvaCompras1
                                                        .Fields("IVAComprasPorcentaje1").Value = mPorcentajeIVA
                                                        .Fields("ImporteIVA1").Value = Round(mIva1, 2)
                                                        .Fields("AplicarIVA1").Value = "SI"
                                                    Else
                                                        .Fields("IdCuentaIvaCompras1").Value = Null
                                                        .Fields("IVAComprasPorcentaje1").Value = 0
                                                        .Fields("ImporteIVA1").Value = 0
                                                        .Fields("AplicarIVA1").Value = "NO"
                                                    End If

                                                    .Fields("IdCuentaIvaCompras2").Value = Null
                                                    .Fields("IVAComprasPorcentaje2").Value = 0
                                                    .Fields("ImporteIVA2").Value = 0
                                                    .Fields("AplicarIVA2").Value = "NO"
                                                    .Fields("IdCuentaIvaCompras3").Value = Null
                                                    .Fields("IVAComprasPorcentaje3").Value = 0
                                                    .Fields("ImporteIVA3").Value = 0
                                                    .Fields("AplicarIVA3").Value = "NO"
                                                    .Fields("IdCuentaIvaCompras4").Value = Null
                                                    .Fields("IVAComprasPorcentaje4").Value = 0
                                                    .Fields("ImporteIVA4").Value = 0
                                                    .Fields("AplicarIVA4").Value = "NO"
                                                    .Fields("IdCuentaIvaCompras5").Value = Null
                                                    .Fields("IVAComprasPorcentaje5").Value = 0
                                                    .Fields("ImporteIVA5").Value = 0
                                                    .Fields("AplicarIVA5").Value = "NO"
                                                    .Fields("IdCuentaIvaCompras6").Value = Null
                                                    .Fields("IVAComprasPorcentaje6").Value = 0
                                                    .Fields("ImporteIVA6").Value = 0
                                                    .Fields("AplicarIVA6").Value = "NO"
                                                    .Fields("IdCuentaIvaCompras7").Value = Null
                                                    .Fields("IVAComprasPorcentaje7").Value = 0
                                                    .Fields("ImporteIVA7").Value = 0
                                                    .Fields("AplicarIVA7").Value = "NO"
                                                    .Fields("IdCuentaIvaCompras8").Value = Null
                                                    .Fields("IVAComprasPorcentaje8").Value = 0
                                                    .Fields("ImporteIVA8").Value = 0
                                                    .Fields("AplicarIVA8").Value = "NO"
                                                    .Fields("IdCuentaIvaCompras9").Value = Null
                                                    .Fields("IVAComprasPorcentaje9").Value = 0
                                                    .Fields("ImporteIVA9").Value = 0
                                                    .Fields("AplicarIVA9").Value = "NO"
                                                    .Fields("IdCuentaIvaCompras10").Value = Null
                                                    .Fields("IVAComprasPorcentaje10").Value = 0
                                                    .Fields("ImporteIVA10").Value = 0
                                                    .Fields("AplicarIVA10").Value = "NO"

                                                    If mAux2 <> 0 Then
                                                        .Fields("IdRubroContable").Value = mAux2
                                                    End If

                                                End With

                                                .Modificado = True
                                            End With
                        
                                            fl = fl + 1
                                        Loop
                        
                                        With oCP
                                            With .Registro
                                                .Fields("NumeroReferencia").Value = mNumeroReferencia
                                                '                           If mConProblemas Then
                                                .Fields("Confirmado").Value = "NO"
                                                '                           Else
                                                '                              .Fields("Confirmado").Value = "SI"
                                                '                           End If
                                                .Fields("TotalBruto").Value = mTotalBruto
                                                .Fields("TotalIva1").Value = mTotalIva1
                                                .Fields("TotalIva2").Value = 0
                                                .Fields("TotalBonificacion").Value = 0
                                                .Fields("TotalComprobante").Value = mTotalComprobante
                                                .Fields("PorcentajeBonificacion").Value = 0
                                                .Fields("TotalIVANoDiscriminado").Value = 0
                                                .Fields("AjusteIVA").Value = mTotalAjusteIVA

                                                If Len(mObservaciones) > 2 Then .Fields("Observaciones").Value = mObservaciones
                                                If mIncrementarReferencia <> "SI" Then
                                                    .Fields("AutoincrementarNumeroReferencia").Value = "NO"
                                                End If

                                            End With

                                            .Guardar
                                        End With

                                        Set oCP = Nothing
                     
                                        '                     If fondoFijoService.BuscarClaveINI("IncrementarReferenciaEnImportacionDeComprobantes") = "SI" Then
                                        '                        Set oPar = oAp.Parametros.Item(1)
                                        '                        oPar.Registro.Fields("ProximoComprobanteProveedorReferencia").Value = mNumeroReferencia + 1
                                        ''                        oPar.Registro.Fields("ProximaOrdenPago").Value = mNumeroOP + 1
                                        '                        oPar.Guardar
                                        '                        Set oPar = Nothing
                                        '                     End If
                        
                                        mNumeroReferencia = mNumeroReferencia + 1
                                    Else
                                        fl = fl + 1
                                    End If

                                    oRsAux1.Close
                                Else
                                    mError = mError & vbCrLf & "Fila " & fl & "  - Fecha es anterior al ultimo cierre contable : " & mComprobante
                                    fl = fl + 1
                                End If

                            Else
                                Exit Do
                            End If

        FinLoop:
                        Loop
         
                        '            'REGISTRAR OP CONTRA COMPROBANTES DE FONDO FIJO
                        '            Set oPar = oAp.Parametros.Item(1)
                        '            mNumeroOP = oPar.Registro.Fields("ProximaOrdenPago").Value
                        '
                        '            Set oOP = oAp.OrdenesPago.Item(-1)
                        '            With oOP
                        '               With .Registro
                        '                  .Fields("NumeroOrdenPago").Value = mNumeroOP
                        '                  .Fields("FechaOrdenPago").Value = mFechaRecepcion
                        '                  .Fields("IdProveedor").Value = Null
                        '                  .Fields("IdCuenta").Value = mIdCuentaFF
                        '                  .Fields("IdMoneda").Value = mIdMonedaPesos
                        '                  .Fields("CotizacionMoneda").Value = 1
                        '                  .Fields("CotizacionDolar").Value = mvarCotizacionDolar
                        '                  .Fields("IdObraOrigen").Value = mIdObra
                        '                  .Fields("Tipo").Value = "FF"
                        '                  .Fields("Dolarizada").Value = "NO"
                        '                  .Fields("Exterior").Value = "NO"
                        '                  .Fields("AsientoManual").Value = "NO"
                        '                  .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                        '                  .Fields("FechaIngreso").Value = Now
                        '                  .Fields("Observaciones").Value = mObservaciones
                        '                  .Fields("BaseGanancias").Value = Null
                        '                  .Fields("RetencionIVA").Value = Null
                        '                  .Fields("RetencionGanancias").Value = Null
                        '                  .Fields("RetencionIBrutos").Value = Null
                        '                  .Fields("RetencionSUSS").Value = Null
                        '               End With
                        '            End With
                        '
                        '            mValores = 0
                        '            Set oRsAux1 = oAp.ComprobantesProveedores.TraerFiltrado("_PorIdOrdenPago", -9)
                        '            With oRsAux1
                        '               If .RecordCount > 0 Then
                        '                  Do While Not .EOF
                        '                     mValores = mValores + .Fields("TotalComprobante").Value
                        '                     .MoveNext
                        '                  Loop
                        '               End If
                        '            End With
                        '
                        '            'VALORES
                        '            With oOP.DetOrdenesPagoValores.Item(-1)
                        '               With .Registro
                        '                  .Fields("IdTipoValor").Value = 33
                        '                  .Fields("Importe").Value = mValores
                        '                  .Fields("IdCaja").Value = mIdCuentaFF
                        '               End With
                        '               .Modificado = True
                        '            End With
                        '
                        '            With oOP
                        '               With .Registro
                        '                  .Fields("Confirmado").Value = "NO"
                        '                  .Fields("Valores").Value = mValores
                        '                  .Fields("Acreedores").Value = 0
                        '               End With
                        '               .Guardar
                        '               mIdOrdenPago = .Registro.Fields(0).Value
                        '            End With
                        '            Set oOP = Nothing
                        '
                        '            With oPar.Registro
                        '               .Fields("ProximaOrdenPago").Value = mNumeroOP + 1
                        '            End With
                        '            oPar.Guardar
                        '            Set oPar = Nothing
                        '
                        '            With oRsAux1
                        '               If .RecordCount > 0 Then
                        '                  Do While Not .EOF
                        '                     Set oCP = oAp.ComprobantesProveedores.Item(.Fields(0).Value)
                        '                     oCP.Registro.Fields("IdOrdenPago").Value = mIdOrdenPago
                        '                     oCP.Guardar
                        '                     .MoveNext
                        '                  Loop
                        '               End If
                        '               .Close
                        '            End With
                        '            Set oRsAux1 = Nothing
         
                    End With

                    .Close False
                End With

                .Quit
            End With
   
            If Len(mError) > 0 Then
                MsgBox "Los siguientes comprobantes no se importaron porque" & vbCrLf & mError, vbExclamation
            End If

        Salida:

            Unload oF
            Set oF = Nothing

            Set oRsAux1 = Nothing
            Set oRsAux2 = Nothing
            Set oAp = Nothing
            Set oEx = Nothing
            Set oCP = Nothing
            Set oOP = Nothing

            Exit Sub

        Mal:

            MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
            Resume Salida
            */
        }

        void ImportacionComprobantesFondoFijo1()
        {
            /*
            Dim oAp As ComPronto.Aplicacion
            Dim oCP As ComPronto.ComprobanteProveedor
            Dim oPr As ComPronto.Proveedor
            Dim oPar As ComPronto.Parametro
            Dim oOP As ComPronto.OrdenPago
            Dim oRsAux1 As ADOR.Recordset
            Dim oRsAux2 As ADOR.Recordset
            Dim oF As Form
            Dim oEx As Excel.Application
            Dim mOk As Boolean, mConProblemas As Boolean
            Dim mArchivo As String, mComprobante As String, mCuit As String, mLetra As String
            Dim mBienesOServicios As String, mObservaciones As String, mRazonSocial As String
            Dim mIncrementarReferencia As String, mCondicionCompra As String, mCodProv As String
            Dim mNumeroCAI As String, mFecha1 As String, mError As String, mCodObra As String
            Dim mInformacionAuxiliar As String, mCuitDefault As String
            Dim mFechaFactura As Date, mFechaVencimientoCAI As Date, mFechaRecepcion As Date
            Dim mIdMonedaPesos As Integer, mIdTipoComprobanteFacturaCompra As Integer
            Dim mIdUnidadPorUnidad As Integer, fl As Integer, mContador As Integer
            Dim mIdCuentaIvaCompras1 As Integer, mIdCuentaGasto As Integer, i As Integer
            Dim mvarProvincia As Integer, mIdTipoComprobante As Integer, mIdCuentaFF As Integer
            Dim mIdUO As Integer, mIdCodigoIva As Integer
            Dim mIdProveedor As Long, mNumeroComprobante1 As Long, mNumeroComprobante2 As Long
            Dim mCodigoCuenta As Long, mNumeroReferencia As Long, mCodigoCuentaFF As Long
            Dim mNumeroOP As Long, mIdOrdenPago As Long, mAux1 As Long, mAux2 As Long
            Dim mNumeroRendicion As Long, mIdCuenta As Long, mIdCuenta1 As Long, mIdObra As Long
            Dim mCodigoCuenta1 As Long
            Dim mvarCotizacionDolar As Single, mPorcentajeIVA As Single
            Dim mTotalItem As Double, mIva1 As Double, mGravado As Double, mNoGravado As Double
            Dim mTotalBruto As Double, mTotalIva1 As Double, mTotalComprobante As Double
            Dim mIdCuentaIvaCompras(10) As Long
            Dim mIVAComprasPorcentaje(10) As Single

            On Error GoTo Mal

            'Set oF = New frmPathPresto
            With oF
                .Id = 14
                .Show vbModal
                mOk = .Ok

                If mOk Then
                    mArchivo = .FileBrowser1(0).Text
                    mFechaRecepcion = .DTFields(0).Value
                    mNumeroReferencia = Val(.text1.Text)
                End If

            End With

            Unload oF
            Set oF = Nothing

            If Not mOk Then Exit Sub

            Set oAp = Aplicacion

            mIncrementarReferencia = fondoFijoService.BuscarClaveINI("IncrementarReferenciaEnImportacionDeComprobantes")
            mCondicionCompra = fondoFijoService.BuscarClaveINI("Condicion de compra default para fondos fijos")
            mFecha1 = fondoFijoService.BuscarClaveINI("Fecha recepcion igual fecha comprobante en fondo fijo")
            mCuitDefault = fondoFijoService.BuscarClaveINI("Cuit por defecto en la importacion de fondos fijos")
   
            Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
            mIdMonedaPesos = oRsAux1.Fields("IdMoneda").Value
            mIdTipoComprobanteFacturaCompra = oRsAux1.Fields("IdTipoComprobanteFacturaCompra").Value
            mIdUnidadPorUnidad = IIf(IsNull(oRsAux1.Fields("IdUnidadPorUnidad").Value), 0, oRsAux1.Fields("IdUnidadPorUnidad").Value)
            gblFechaUltimoCierre = IIf(IsNull(oRsAux1.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), oRsAux1.Fields("FechaUltimoCierre").Value)

            For i = 1 To 10

                If Not IsNull(oRsAux1.Fields("IdCuentaIvaCompras" & i).Value) Then
                    mIdCuentaIvaCompras(i) = oRsAux1.Fields("IdCuentaIvaCompras" & i).Value
                    mIVAComprasPorcentaje(i) = oRsAux1.Fields("IVAComprasPorcentaje" & i).Value
                Else
                    mIdCuentaIvaCompras(i) = 0
                    mIVAComprasPorcentaje(i) = 0
                End If

            Next

            oRsAux1.Close
   
            mIdUO = 0
            Set oRsAux1 = oAp.Obras.TraerFiltrado("_PorId", mIdObra)

            If oRsAux1.RecordCount > 0 Then
                mIdUO = IIf(IsNull(oRsAux1.Fields("IdUnidadOperativa").Value), 0, oRsAux1.Fields("IdUnidadOperativa").Value)
            End If

            oRsAux1.Close
   
            'Set oF = New frmAviso
            With oF
                .Label1 = "Iniciando EXCEL ..."
                .Show
                .Refresh

                DoEvents
            End With

            oF.Label1 = oF.Label1 & vbCrLf & "Procesando fondo fijo ..."
            oF.Label2 = ""
            oF.Label3 = ""

            DoEvents

            fl = 11
            mContador = 0
            mNumeroRendicion = 0
            mTotalBruto = 0
            mTotalIva1 = 0
            mTotalComprobante = 0
   
            Set oEx = CreateObject("Excel.Application")

            With oEx
                .Visible = True
                .WindowState = xlMinimized
                Me.Refresh
      
                With .Workbooks.Open(mArchivo)

                    '.Sheets("FF").Select
                    With .ActiveSheet
                        mFechaFactura = CDate(.Cells(2, 13))
                        mObservaciones = .Cells(6, 12)
                        mCodProv = .Cells(4, 10)
                        mCodObra = .Cells(4, 14)
                        mNumeroComprobante2 = CLng(Year(mFechaFactura) & Format(Month(mFechaFactura), "00") & Format(Day(mFechaFactura), "00"))
            
                        mIdProveedor = 0
                        Set oRsAux1 = oAp.Proveedores.TraerFiltrado("_PorCodigoEmpresa", mCodProv)

                        If oRsAux1.RecordCount > 0 Then
                            mIdProveedor = IIf(IsNull(oRsAux1.Fields("IdProveedor").Value), 0, oRsAux1.Fields("IdProveedor").Value)
                            mIdCodigoIva = IIf(IsNull(oRsAux1.Fields("IdCodigoIva").Value), 0, oRsAux1.Fields("IdCodigoIva").Value)
                        End If

                        oRsAux1.Close

                        If mIdProveedor = 0 Then
                            MsgBox "Proveedor inexistente (Codigo " & mCodProv & ")", vbExclamation
                            GoTo Salida
                        End If
            
                        mIdObra = 0
                        mIdCuentaFF = 0
                        Set oRsAux1 = oAp.Obras.TraerFiltrado("_PorNumero", mCodObra)

                        If oRsAux1.RecordCount > 0 Then
                            mIdObra = IIf(IsNull(oRsAux1.Fields("IdObra").Value), 0, oRsAux1.Fields("IdObra").Value)
                            mIdCuentaFF = IIf(IsNull(oRsAux1.Fields("IdCuentaContableFF").Value), 0, oRsAux1.Fields("IdCuentaContableFF").Value)
                        End If

                        oRsAux1.Close

                        If mIdObra = 0 Then
                            MsgBox "Obra inexistente (Codigo " & mCodObra & ")", vbExclamation
                            GoTo Salida
                        End If

                        If mIdCuentaFF = 0 Then
                            MsgBox "Cuenta de fondo fijo obra " & mCodObra & ", inexistente", vbExclamation
                            GoTo Salida
                        End If
            
                        If mFechaFactura <= gblFechaUltimoCierre Then
                            MsgBox "La fecha del fondo fijo es anterior a la fecha de cierre contable", vbExclamation
                            GoTo Salida
                        End If
            
                        Set oCP = oAp.ComprobantesProveedores.Item(-1)

                        With oCP
                            With .Registro
                                .Fields("NumeroReferencia").Value = mNumeroReferencia
                                .Fields("Confirmado").Value = "NO"
                                .Fields("IdTipoComprobante").Value = mIdTipoComprobanteFacturaCompra
                                .Fields("IdObra").Value = mIdObra
                                .Fields("FechaComprobante").Value = mFechaFactura
                                .Fields("FechaRecepcion").Value = mFechaFactura
                                .Fields("FechaVencimiento").Value = mFechaFactura
                                .Fields("IdMoneda").Value = mIdMonedaPesos
                                .Fields("CotizacionMoneda").Value = 1
                                .Fields("CotizacionDolar").Value = mvarCotizacionDolar
                                .Fields("IdProveedorEventual").Value = mIdProveedor
                                .Fields("IdProveedor").Value = Null
                                .Fields("IdCuenta").Value = mIdCuentaFF
                                .Fields("IdOrdenPago").Value = Null
                                .Fields("Letra").Value = "A"
                                .Fields("NumeroComprobante1").Value = 1
                                .Fields("NumeroComprobante2").Value = mNumeroComprobante2
                                .Fields("NumeroRendicionFF").Value = mNumeroComprobante2
                                .Fields("IdIBCondicion").Value = Null
                                .Fields("IdTipoRetencionGanancia").Value = Null
                                .Fields("BienesOServicios").Value = Null
                                .Fields("NumeroCAI").Value = mNumeroComprobante2
                                .Fields("FechaVencimientoCAI").Value = mFechaFactura
                                .Fields("DestinoPago").Value = "O"

                                If mIdCodigoIva <> 0 Then .Fields("IdCodigoIva").Value = mIdCodigoIva
                            End With
                        End With
            
                        Do While True

                            If Len(Trim(.Cells(fl, 2))) > 0 Then
                                mConProblemas = False
                  
                                mContador = mContador + 1
                                oF.Label2 = "Comprobante : " & .Cells(fl, 5)
                                oF.Label3 = "" & mContador

                                DoEvents
               
                                mCodigoCuenta = CLng(.Cells(fl, 13))
                                mTotalItem = Round(CDbl(.Cells(fl, 6)), 2)
                                mIva1 = Round(CDbl(.Cells(fl, 8)), 2)
                                mGravado = Round(CDbl(.Cells(fl, 9)), 2)
                                mNoGravado = Round(CDbl(.Cells(fl, 10)), 2)
                                mTotalBruto = mTotalBruto + (mGravado + mNoGravado)
                                mTotalIva1 = mTotalIva1 + mIva1
                                mTotalComprobante = mTotalComprobante + mTotalItem
                  
                                If fl = 11 And mGravado <> 0 Then
                                    mPorcentajeIVA = Round(mIva1 / mGravado * 100, 1)
                                Else
                                    mPorcentajeIVA = Val(.Cells(fl, 7))
                                End If
                  
                                mIdCuentaIvaCompras1 = 0

                                If mPorcentajeIVA <> 0 Then

                                    For i = 1 To 10

                                        If mIVAComprasPorcentaje(i) = mPorcentajeIVA Then
                                            mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(i)
                                            Exit For
                                        End If

                                    Next

                                End If

                                If mIva1 <> 0 And mIdCuentaIvaCompras1 = 0 Then
                                    MsgBox "No se encontro la cuenta de iva para el porcentaje " & mPorcentajeIVA, vbExclamation
                                    GoTo Salida
                                End If
                     
                                mIdCuenta = 0
                                mIdCuenta1 = 0
                                mIdCuentaGasto = 0
                                mCodigoCuenta1 = 0
                                Set oRsAux2 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuenta)

                                If oRsAux2.RecordCount > 0 Then
                                    mIdCuenta = oRsAux2.Fields(0).Value
                                End If

                                oRsAux2.Close
                                Set oRsAux2 = oAp.Cuentas.TraerFiltrado("_PorObraCuentaMadre", Array(mIdObra, mIdCuenta))

                                If oRsAux2.RecordCount > 0 Then
                                    mIdCuenta1 = oRsAux2.Fields(0).Value
                                    mIdCuentaGasto = IIf(IsNull(oRsAux2.Fields("IdCuentaGasto").Value), 0, oRsAux2.Fields("IdCuentaGasto").Value)
                                    mCodigoCuenta1 = IIf(IsNull(oRsAux2.Fields("Codigo").Value), 0, oRsAux2.Fields("Codigo").Value)
                                End If

                                oRsAux2.Close

                                If mIdCuentaGasto = 0 And mIdCuenta1 = 0 Then
                                    MsgBox "No se encontro la cuenta contable " & mCodigoCuenta, vbExclamation
                                    GoTo Salida
                                End If
                  
                                If mGravado <> 0 Or mIva1 <> 0 Then

                                    With oCP.DetComprobantesProveedores.Item(-1)
                                        With .Registro
                                            .Fields("IdObra").Value = mIdObra
                                            .Fields("IdCuentaGasto").Value = mIdCuentaGasto
                                            .Fields("IdCuenta").Value = mIdCuenta1
                                            .Fields("CodigoCuenta").Value = mCodigoCuenta1
                                            .Fields("Importe").Value = mGravado

                                            If mIdCuentaIvaCompras1 <> 0 Then
                                                .Fields("IdCuentaIvaCompras1").Value = mIdCuentaIvaCompras1
                                                .Fields("IVAComprasPorcentaje1").Value = mPorcentajeIVA
                                                .Fields("ImporteIVA1").Value = mIva1
                                                .Fields("AplicarIVA1").Value = "SI"
                                            Else
                                                .Fields("IdCuentaIvaCompras1").Value = Null
                                                .Fields("IVAComprasPorcentaje1").Value = 0
                                                .Fields("ImporteIVA1").Value = 0
                                                .Fields("AplicarIVA1").Value = "NO"
                                            End If

                                            .Fields("IdCuentaIvaCompras2").Value = Null
                                            .Fields("IVAComprasPorcentaje2").Value = 0
                                            .Fields("ImporteIVA2").Value = 0
                                            .Fields("AplicarIVA2").Value = "NO"
                                            .Fields("IdCuentaIvaCompras3").Value = Null
                                            .Fields("IVAComprasPorcentaje3").Value = 0
                                            .Fields("ImporteIVA3").Value = 0
                                            .Fields("AplicarIVA3").Value = "NO"
                                            .Fields("IdCuentaIvaCompras4").Value = Null
                                            .Fields("IVAComprasPorcentaje4").Value = 0
                                            .Fields("ImporteIVA4").Value = 0
                                            .Fields("AplicarIVA4").Value = "NO"
                                            .Fields("IdCuentaIvaCompras5").Value = Null
                                            .Fields("IVAComprasPorcentaje5").Value = 0
                                            .Fields("ImporteIVA5").Value = 0
                                            .Fields("AplicarIVA5").Value = "NO"
                                            .Fields("IdCuentaIvaCompras6").Value = Null
                                            .Fields("IVAComprasPorcentaje6").Value = 0
                                            .Fields("ImporteIVA6").Value = 0
                                            .Fields("AplicarIVA6").Value = "NO"
                                            .Fields("IdCuentaIvaCompras7").Value = Null
                                            .Fields("IVAComprasPorcentaje7").Value = 0
                                            .Fields("ImporteIVA7").Value = 0
                                            .Fields("AplicarIVA7").Value = "NO"
                                            .Fields("IdCuentaIvaCompras8").Value = Null
                                            .Fields("IVAComprasPorcentaje8").Value = 0
                                            .Fields("ImporteIVA8").Value = 0
                                            .Fields("AplicarIVA8").Value = "NO"
                                            .Fields("IdCuentaIvaCompras9").Value = Null
                                            .Fields("IVAComprasPorcentaje9").Value = 0
                                            .Fields("ImporteIVA9").Value = 0
                                            .Fields("AplicarIVA9").Value = "NO"
                                            .Fields("IdCuentaIvaCompras10").Value = Null
                                            .Fields("IVAComprasPorcentaje10").Value = 0
                                            .Fields("ImporteIVA10").Value = 0
                                            .Fields("AplicarIVA10").Value = "NO"
                                        End With

                                        .Modificado = True
                                    End With

                                End If

                                If mNoGravado <> 0 Then

                                    With oCP.DetComprobantesProveedores.Item(-1)
                                        With .Registro
                                            .Fields("IdObra").Value = mIdObra
                                            .Fields("IdCuentaGasto").Value = mIdCuentaGasto
                                            .Fields("IdCuenta").Value = mIdCuenta1
                                            .Fields("CodigoCuenta").Value = mCodigoCuenta1
                                            .Fields("Importe").Value = mNoGravado
                                            .Fields("IdCuentaIvaCompras1").Value = Null
                                            .Fields("IVAComprasPorcentaje1").Value = 0
                                            .Fields("ImporteIVA1").Value = 0
                                            .Fields("AplicarIVA1").Value = "NO"
                                            .Fields("IdCuentaIvaCompras2").Value = Null
                                            .Fields("IVAComprasPorcentaje2").Value = 0
                                            .Fields("ImporteIVA2").Value = 0
                                            .Fields("AplicarIVA2").Value = "NO"
                                            .Fields("IdCuentaIvaCompras3").Value = Null
                                            .Fields("IVAComprasPorcentaje3").Value = 0
                                            .Fields("ImporteIVA3").Value = 0
                                            .Fields("AplicarIVA3").Value = "NO"
                                            .Fields("IdCuentaIvaCompras4").Value = Null
                                            .Fields("IVAComprasPorcentaje4").Value = 0
                                            .Fields("ImporteIVA4").Value = 0
                                            .Fields("AplicarIVA4").Value = "NO"
                                            .Fields("IdCuentaIvaCompras5").Value = Null
                                            .Fields("IVAComprasPorcentaje5").Value = 0
                                            .Fields("ImporteIVA5").Value = 0
                                            .Fields("AplicarIVA5").Value = "NO"
                                            .Fields("IdCuentaIvaCompras6").Value = Null
                                            .Fields("IVAComprasPorcentaje6").Value = 0
                                            .Fields("ImporteIVA6").Value = 0
                                            .Fields("AplicarIVA6").Value = "NO"
                                            .Fields("IdCuentaIvaCompras7").Value = Null
                                            .Fields("IVAComprasPorcentaje7").Value = 0
                                            .Fields("ImporteIVA7").Value = 0
                                            .Fields("AplicarIVA7").Value = "NO"
                                            .Fields("IdCuentaIvaCompras8").Value = Null
                                            .Fields("IVAComprasPorcentaje8").Value = 0
                                            .Fields("ImporteIVA8").Value = 0
                                            .Fields("AplicarIVA8").Value = "NO"
                                            .Fields("IdCuentaIvaCompras9").Value = Null
                                            .Fields("IVAComprasPorcentaje9").Value = 0
                                            .Fields("ImporteIVA9").Value = 0
                                            .Fields("AplicarIVA9").Value = "NO"
                                            .Fields("IdCuentaIvaCompras10").Value = Null
                                            .Fields("IVAComprasPorcentaje10").Value = 0
                                            .Fields("ImporteIVA10").Value = 0
                                            .Fields("AplicarIVA10").Value = "NO"
                                        End With

                                        .Modificado = True
                                    End With

                                End If

                                fl = fl + 1
                            Else
                                Exit Do
                            End If

                        Loop

                        With oCP
                            With .Registro
                                .Fields("TotalBruto").Value = mTotalBruto
                                .Fields("TotalIva1").Value = mTotalIva1
                                .Fields("TotalIva2").Value = 0
                                .Fields("TotalBonificacion").Value = 0
                                .Fields("TotalComprobante").Value = mTotalComprobante
                                .Fields("PorcentajeBonificacion").Value = 0
                                .Fields("TotalIVANoDiscriminado").Value = 0
                                .Fields("AjusteIVA").Value = 0

                                If Len(mObservaciones) > 2 Then .Fields("Observaciones").Value = mObservaciones
                            End With

                            .Guardar
                        End With

                        Set oCP = Nothing
                    End With

                    .Close False
                End With

                .Quit
            End With
   
        Salida:

            Unload oF
            Set oF = Nothing

            Set oRsAux1 = Nothing
            Set oRsAux2 = Nothing
            Set oAp = Nothing
            Set oEx = Nothing
            Set oCP = Nothing
            Set oOP = Nothing

            Exit Sub

        Mal:

            MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
            Resume Salida

             */

        }




    }





}
















//Sub Emision(ByVal StringConexion As String, ByVal mIdComprobanteProveedor As Long, ByVal Info As String)

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
//   Dim mvarFecha As String, mAdjuntos As String, mNumero As String, mPieComprobanteProveedor As String
//   Dim mResp As String, mvarTag As String, mCarpeta As String, mImprime As String
//   Dim mvarObra As String, mvarMoneda As String, mFormulario As String
//   Dim mConSinAviso As String, mCC As String, mvarCantidad As String, espacios As String
//   Dim mvarUnidadPeso As String, mCodigo As String, mvarDireccion As String
//   Dim mvarOrigen1 As String, mvarOrigen2 As String, mvarDescripcionIva As String
//   Dim mvarNumLet As String, mvarDocumento As String, mvarBorrador As String
//   Dim mvarEmpresa As String, mvarDescBonif As String
//   Dim mPrecio As Double, mTotalItem As Double, mvarSubTotal As Double
//   Dim mvarSubtotalGravado As Double, mvarIVA1 As Double, mvarIVA2 As Double
//   Dim mvarTotalComprobanteProveedor As Double, mvarBonificacionPorItem As Double
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

//   Set oRs = oAp.ObtenerTodos().TraerFiltrado("_PorId", mIdComprobanteProveedor)
//   If mItemsAgrupados Then
//      Set oRsDet = oAp.ObtenerTodos().TraerFiltrado("_DetallesPorIdComprobanteProveedorAgrupados", mIdComprobanteProveedor)
//   Else
//      Set oRsDet = oAp.ObtenerTodos().TraerFiltrado("_DetallesPorIdComprobanteProveedor", mIdComprobanteProveedor)
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
//                  Not IIf(IsNull(oRs.Fields("ComprobanteProveedorExterior").Value), "NO", oRs.Fields("ComprobanteProveedorExterior").Value) = "SI" Then
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
//      mvarTotalComprobanteProveedor = 0
//      mvarBonificacionPorItem = 0
//      mvarBonificacion = 0
//      Set oRsAux = oAp.ObtenerTodos().TraerFiltrado("_DetallesPorId", mIdComprobanteProveedor)
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
//      If IIf(IsNull(oRs.Fields("ComprobanteProveedorExterior").Value), "NO", oRs.Fields("ComprobanteProveedorExterior").Value) = "SI" Then
//         mvarIVA1 = 0
//      End If
//      mvarTotalComprobanteProveedor = mvarSubtotalGravado + mvarIVA1 + mvarIVA2

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
//      If mvarTotalComprobanteProveedor <> 0 Then
//         Selection.TypeText Text:="" & Format(mvarTotalComprobanteProveedor, "#,##0.00")
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
//   mNumero = oRs.Fields("NumeroComprobanteProveedor").Value
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
//   Selection.TypeText Text:="" & oRs.Fields("FechaComprobanteProveedor").Value

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
//   Set oRsAux = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(4, mvarTotalComprobanteProveedor))
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

//   Set oRsAux = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(4, mIdComprobanteProveedor))
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
//'         UserForm1.RichTextBox1.TextRTF = "" & GeneraImputacionesBis(mIdComprobanteProveedor)
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
//'         UserForm1.RichTextBox1.TextRTF = "" & GeneraInspeccionesBis(mIdComprobanteProveedor)
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
//      mNumero = oRs.Fields("NumeroComprobanteProveedor").Value
//      If Not IsNull(oRs.Fields("Subnumero").Value) Then
//         mNumero = mNumero & " / " & oRs.Fields("Subnumero").Value
//      End If
//      Selection.TypeText Text:="" & mNumero
//      Selection.MoveRight Unit:=wdCell, Count:=2
//      Selection.TypeText Text:="" & oRs.Fields("FechaComprobanteProveedor").Value

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
//      Set oRsAux = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(4, mvarTotalComprobanteProveedor))
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

//      Set oRsAux = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(4, mIdComprobanteProveedor))
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



