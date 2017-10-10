<%@ WebHandler Language="C#" Class="JQGridHandler" %>


/*
Imports System
Imports System.Web

Public Class Handler : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        context.Response.ContentType = "text/plain"
        context.Response.Write("Hello World")
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class
*/



using System;
using System.Web;
//using jqGrid.Models;
using System.Web.Script.Serialization;
using System.Linq;

using ProntoMVC.Data.Models;
using ProntoMVC.Data;

using System.Web.Security;

using System.Linq.Dynamic;

using System.Configuration;

using Pronto.ERP.Bll;

public class JQGridHandler : IHttpHandler
{




    //Public ReadOnly Property scLocal() As String
    //    Get
    //        Return ConfigurationManager.AppSettings("scLocal")
    //    End Get
    //End Property
    //Public ReadOnly Property scWilliamsRelease() As String
    //    Get
    //        Return ConfigurationManager.AppSettings("scWilliamsRelease")
    //    End Get
    //End Property

    //Public ReadOnly Property scWilliamsDebug() As String
    //    Get
    //        Return ConfigurationManager.AppSettings("scWilliamsDebug")
    //    End Get
    //End Property


    //Public ReadOnly Property scConexBDLmaster() As String
    //    Get
    //        Return ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
    //    End Get
    //End Property



    //Public ReadOnly Property AplicacionConImagenes() As String 'si lo uso desde prontoclientes, debo apuntar hacia el de pronto a secas
    //    Get
    //        Return ConfigurationManager.AppSettings("AplicacionConImagenes")
    //    End Get
    //End Property





    public void ProcessRequestOriginal(HttpContext context)
    {

        // http://stackoverflow.com/questions/8392413/asp-net-returning-json-with-ashx
        // http://stackoverflow.com/questions/3275863/does-net-4-have-a-built-in-json-serializer-deserializer

        //http://stackoverflow.com/questions/9784033/how-to-get-searchstring-in-asp-net-with-jqgrid

        JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();

        context.Response.ContentType = "application/json";

        //    context.Response.Write(
        //jsonSerializer.Serialize(
        //    new
        //    {
        //        query = "Li",
        //        suggestions = new[] { "Liberia", "Libyan Arab Jamahiriya", "Liechtenstein", "Lithuania" },
        //        data = new[] { "LR", "LY", "LI", "LT" }
        //    }





        //    var data = (from a in Articulos
        //                select new
        //                {
        //                    IdArticulo = a.IdArticulo,
        //                    Codigo = a.Codigo,
        //                    Descripcion = a.Descripcion,
        //                    IdUnidad = a.IdUnidad,
        //                    Unidad = a.Unidad.Abreviatura,
        //                    Iva = a.AlicuotaIVA
        //                }).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

        var data = new[] { "11", "22", "33", "44" };

        var jsonData = new jqGridJson()
        {
            total = 1,
            page = 1,
            records = 100,
            rows = (from a in data
                    select new jqGridRowJson
                    {
                        id = a.ToString(),
                        cell = new string[] {
                                        "sadfasf"
                                    }
                    }).ToArray()
        };



        context.Response.Write(jsonSerializer.Serialize(jsonData));

        context.Response.Write("");
        //System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
        //string strOperation = forms.Get("oper");
        //MONGOConnect objMC = new MONGOConnect();//Helper Class
        //var collectionEmployee = 
        //  objMC.GetMongoCollection("EMPLOYEE");//Gets Employee Collection
        //string strResponse = string.Empty;
        //if (strOperation == null)
        //{
        //    //oper = null which means its first load.
        //    var jsonSerializer = new JavaScriptSerializer();
        //    context.Response.Write(jsonSerializer.Serialize(
        //      collectionEmployee.AsQueryable<Employee>().ToList<Employee>()));
        //}
        //else if (strOperation == "del")
        //{
        //    var query = Query.EQ("_id", forms.Get("EmpId").ToString());
        //    collectionEmployee.Remove(query);
        //    strResponse = "Employee record successfully removed";
        //    context.Response.Write(strResponse);
        //}
        //else
        //{
        //     string strOut=string.Empty;
        //     AddEdit(forms, collectionEmployee, out strOut);
        //     context.Response.Write(strOut);
        //}

    }






    public void ProcessRequest(HttpContext context)
    {


        string SC;
        //string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["scWilliamsRelease"]);
        if (System.Diagnostics.Debugger.IsAttached)
            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["scLocal"]);
        else
            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["scWilliamsRelease"]);
        //SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["scWilliamsRelease"]);

        string scbdlmaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString);

        HttpRequest request = context.Request;
        HttpResponse response = context.Response;

        // get parameters sent from jqGrid
        string numberOfRows = request["rows"];
        string pageIndex = request["page"];
        string sortColumnName = request["sidx"];
        string sortOrderBy = request["sord"];
        string isSearch = request["_search"];
        string searchField = request["searchField"];
        string searchString = request["searchString"];
        string searchOper = request["searchOper"];
        string filters = request["filters"];
        string FechaInicial = request["FechaInicial"];
        string FechaFinal = request["FechaFinal"];

        string puntovent = request["puntovent"];
        string destino = request["destino"];
        string usuario = Membership.GetUser().UserName;

        if (sortColumnName == null) return;

        //string output = ControlesDiarios_DynamicGridData(sortColumnName, sortOrderBy, Convert.ToInt32(pageIndex), Convert.ToInt32(numberOfRows), isSearch == "true", filters, FechaInicial, FechaFinal, Convert.ToInt32(puntovent), SQLdinamico.BuscaIdWilliamsDestinoPreciso(destino, SC));


        var a = new ServicioCartaPorte.servi();
        string output = a.CartasPorte_DynamicGridData(
                                    sortColumnName, sortOrderBy, Convert.ToInt32(pageIndex),
                                    Convert.ToInt32(numberOfRows), isSearch == "true", filters, FechaInicial, FechaFinal, Convert.ToInt32(puntovent),
                                    SQLdinamico.BuscaIdWilliamsDestinoPreciso(destino, SC),
                                    SC, usuario, scbdlmaster );


        response.ContentType = "application/json";
        response.Write(output);



    }





    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


    public class jqGridJson
    {
        public int total { get; set; }
        public int page { get; set; }
        public int records { get; set; }
        public jqGridRowJson[] rows { get; set; }
    }
    public class jqGridRowJson
    {
        public string id { get; set; }
        public string[] cell { get; set; }
    }


    // de la misma manera que estas llamando con jquery para buscar los acopios por cliente


    public virtual string ControlesDiarios_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal, int puntovent, int iddestino)
    {

        // An ASHX is a generic HttpHandler. An ASMX file is a web service. ASHX is a good lean way to provide a response to AJAX calls, but if you want to provide a response which changes based on conditions (such as variable inputs) it can become a bit of a handful - lots of if else etc. ASMX can house mulitple methods which can take parameters.

        string SC;
        //string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["scWilliamsRelease"]);
        if (System.Diagnostics.Debugger.IsAttached)
            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["scLocal"]);
        else
            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["scWilliamsRelease"]);

        //If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
        //     scs = scLocal
        // Else
        //     scs = scWilliamsRelease
        // End If


        var usuario = Membership.GetUser();
        System.Data.DataTable dt = EntidadManager.ExecDinamico(SC, "Empleados_TX_UsuarioNT '" + usuario.UserName + "'");
        int idUsuario = Convert.ToInt32(dt.Rows[0][0]);
        // int puntovent = EmpleadoManager.GetItem(SC, idUsuario).PuntoVentaAsociado;


        DateTime FechaDesde = new DateTime(1980, 1, 1);
        DateTime FechaHasta = new DateTime(2050, 1, 1);

        try
        {

            FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
        }
        catch (Exception)
        {

        }

        try
        {
            FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);

        }
        catch (Exception)
        {

        }





        ProntoMVC.Data.Models.DemoProntoEntities db =
                           new DemoProntoEntities(
                               Auxiliares.FormatearConexParaEntityFramework(
                               ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)));



        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        int totalRecords = 0;


        var pagedQuery = Filtrador.Filters.FiltroGenerico_UsandoIQueryable<CartasDePorteControlDescarga>
                        (sidx, sord, page, rows, _search, filters, db, ref totalRecords,
                                db.CartasDePorteControlDescargas
                                        .Where(x =>
                                                //(x.IdPuntoVenta == puntovent || puntovent == 0)
                                                //&&
                                                (x.Fecha >= FechaDesde && x.Fecha <= FechaHasta)
                                                 &&
                                                (x.WilliamsDestino.PuntoVenta == puntovent || puntovent <= 0)
                                                 &&
                                                (x.WilliamsDestino.IdWilliamsDestino == iddestino || iddestino <= 0)
                                             )
                                        );



        // var pagedQuery = Filtrador.Filters.FiltroGenerico<CartasDePorteControlDescarga>
        //                    ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);



        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        string campo = "true";
        int pageSize = rows;
        int currentPage = page;


        //if (sidx == "Numero") sidx = "NumeroPedido"; // como estoy haciendo "select a" (el renglon entero) en la linq antes de llamar jqGridJson, no pude ponerle el nombre explicito
        //if (searchField == "Numero") searchField = "NumeroPedido"; 

        var Entidad = pagedQuery
                      //.Include(x => x.Moneda)
                      //.Include(x => x.Proveedor)
                      //.Include(x => x.DetallePedidos
                      //            .Select(y => y.DetalleRequerimiento
                      //                )
                      //        )
                      //.Include("DetallePedidos.DetalleRequerimiento.Requerimientos.Obra") // funciona tambien
                      //.Include(x => x.Comprador)
                      .AsQueryable();


        //var Entidad1 = (from a in Entidad.Where(campo) select new { Id = a.IdCartasDePorteControlDescarga });

        int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

        var data = (from a in Entidad
                    select a
                    )//.Where(campo).OrderBy(sidx + " " + sord)
                    .ToList();

        var jsonData = new jqGridJson()
        {
            total = totalPages,
            page = currentPage,
            records = totalRecords,
            rows = (from a in data
                    select new jqGridRowJson
                    {
                        id = a.IdCartasDePorteControlDescarga.ToString(),
                        cell = new string[] {
                                "", //"<a href="+ Url.Action("Edit",new {id = a.IdPedido} ) + "  >Editar</>" ,
                                
                                a.IdCartasDePorteControlDescarga.ToString(),

                                 a.Fecha.ToShortDateString(),

                                a.WilliamsDestino==null ? "" : a.WilliamsDestino.Descripcion,

                                 a.IdDestino.ToString(),

                                 a.TotalDescargaDia.ToString(),

                                 a.IdPuntoVenta.ToString()
                                 
                                 
                                 // a.FechaSalida==null ? "" :  a.FechaSalida.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                //a.Cumplido.NullSafeToString(), 


                                //string.Join(" ",  a.DetallePedidos.Select(x=>(x.DetalleRequerimiento==null) ? "" : 
                                //                     x.DetalleRequerimiento.Requerimientos == null ? "" :   
                                //                         x.DetalleRequerimiento.Requerimientos.NumeroRequerimiento.NullSafeToString() ).Distinct()),
                                //string.Join(" ",  a.DetallePedidos.Select(x=>(x.DetalleRequerimiento==null) ? "" : 
                                //                        x.DetalleRequerimiento.Requerimientos == null ? ""  :
                                //                            x.DetalleRequerimiento.Requerimientos.Obra == null ? ""  :
                                //                             x.DetalleRequerimiento.Requerimientos.Obra.NumeroObra.NullSafeToString()).Distinct()),
                              
                                                             
                                //a.Proveedor==null ? "" :  a.Proveedor.RazonSocial.NullSafeToString(), 
                                //(a.TotalPedido- a.TotalIva1+a.Bonificacion- (a.ImpuestosInternos ?? 0)- (a.OtrosConceptos1 ?? 0) - (a.OtrosConceptos2 ?? 0)-    (a.OtrosConceptos3 ?? 0) -( a.OtrosConceptos4 ?? 0) - (a.OtrosConceptos5 ?? 0)).ToString(),  
                                //a.Bonificacion.NullSafeToString(), 
                                //a.TotalIva1.NullSafeToString(), 
                                //a.Moneda==null ? "" :   a.Moneda.Abreviatura.NullSafeToString(),  
                                //a.Comprador==null ? "" :    a.Comprador.Nombre.NullSafeToString(),  
                                //a.Empleado==null ? "" :  a.Empleado.Nombre.NullSafeToString(),  
                                //a.DetallePedidos.Count().NullSafeToString(),  
                                //a.IdPedido.NullSafeToString(), 
                                //a.NumeroComparativa.NullSafeToString(),  
                                //a.IdTipoCompraRM.NullSafeToString(), 
                                //a.Observaciones.NullSafeToString(),   
                                //a.DetalleCondicionCompra.NullSafeToString(),   
                                //a.PedidoExterior.NullSafeToString(),  
                                //a.IdPedidoAbierto.NullSafeToString(), 
                                //a.NumeroLicitacion .NullSafeToString(), 
                                //a.Impresa.NullSafeToString(), 
                                //a.UsuarioAnulacion.NullSafeToString(), 
                                //a.FechaAnulacion.NullSafeToString(),  
                                //a.MotivoAnulacion.NullSafeToString(),  
                                //a.ImpuestosInternos.NullSafeToString(), 
                                //"", // #Auxiliar1.Equipos , 
                                //a.CircuitoFirmasCompleto.NullSafeToString(), 
                                //a.Proveedor==null ? "" : a.Proveedor.IdCodigoIva.NullSafeToString() ,
                                //a.IdComprador.NullSafeToString(),
                                //a.IdProveedor.NullSafeToString(),
                                //a.ConfirmadoPorWeb_1.NullSafeToString()
                               
                            }
                    }).ToArray()
        };

        //return Json(jsonData, JsonRequestBehavior.AllowGet);
        JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
        return jsonSerializer.Serialize(jsonData);


    }









    //public ActionResult ArticulosGridData2(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
    //{
    //    string campo = String.Empty;
    //    int pageSize = rows ?? 20;
    //    int currentPage = page ?? 1;

    //    var Articulos = db.Articulos.AsQueryable();
    //    if (_search)
    //    {
    //        switch (searchField.ToLower())
    //        {
    //            case "idarticulo":
    //                campo = String.Format("{0} = {1}", searchField, searchString);
    //                break;
    //            default:
    //                campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
    //                break;
    //        }
    //    }
    //    else
    //    {
    //        campo = "true";
    //    }

    //    var Articulos1 = (from a in Articulos select a).Where(campo).Select(a => a.IdArticulo);



    //    int totalRecords = Articulos1.Count();
    //    int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

    //    var data = (from a in Articulos
    //                select new
    //                {
    //                    IdArticulo = a.IdArticulo,
    //                    Codigo = a.Codigo,
    //                    Descripcion = a.Descripcion,
    //                    IdUnidad = a.IdUnidad,
    //                    Unidad = a.Unidad.Abreviatura,
    //                    Iva = a.AlicuotaIVA
    //                }).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

    //    var jsonData = new jqGridJson()
    //    {
    //        total = totalPages,
    //        page = currentPage,
    //        records = totalRecords,
    //        rows = (from a in data
    //                select new jqGridRowJson
    //                {
    //                    id = a.IdArticulo.ToString(),
    //                    cell = new string[] { 
    //                            a.IdArticulo.ToString(), 
    //                            a.Codigo,
    //                            a.Descripcion,
    //                            a.IdUnidad.ToString(),
    //                            a.Unidad,
    //                            a.Iva.ToString()
    //                        }
    //                }).ToArray()
    //    };

    //    return Json(jsonData, JsonRequestBehavior.AllowGet);
    //}



    //private void AddEdit(NameValueCollection forms, 
    //  MongoCollection collectionEmployee,out string strResponse)
    //{
    //    string strOperation = forms.Get("oper");
    //    string strEmpId = string.Empty;
    //    if (strOperation == "add")
    //    {
    //         strEmpId = forms.Get("EmpId").ToString();
    //    }
    //    else if (strOperation == "edit")
    //    {
    //        var result = collectionEmployee.AsQueryable<Employee>().Select(c => c._id).Max();
    //         strEmpId = (Convert.ToInt32(result) + 1).ToString();
    //    }

    //    string strFirstName = forms.Get("FirstName").ToString();
    //    string strLastName = forms.Get("LastName").ToString();
    //    string strLastSSN = forms.Get("LastSSN").ToString();
    //    string strDepartment = forms.Get("Department").ToString();
    //    string strAge = forms.Get("Age").ToString();
    //    string strSalary = forms.Get("Salary").ToString();
    //    string strAddress = forms.Get("Address").ToString();
    //    string strMaritalStatus = forms.Get("MaritalStatus").ToString();
    //    Employee objEmp = new Employee();
    //    objEmp._id = strEmpId;
    //    objEmp.FirstName = strFirstName;
    //    objEmp.LastName = strLastName;
    //    objEmp.LastSSN = strLastSSN;
    //    objEmp.Department = strDepartment;
    //    objEmp.Age = Convert.ToInt32(strAge);
    //    objEmp.Address = strAddress;
    //    objEmp.MaritalStatus = strMaritalStatus;
    //    objEmp.Salary = strSalary;
    //    collectionEmployee.Save(objEmp);
    //    strResponse = "Employee record successfully updated";
    //}
}