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

        string puntovent = request["puntovent"] == "null" ? "0" : request["puntovent"] ?? "0";
        puntovent = (puntovent == "undefined") ? "0" : puntovent;




        string destino = request["destino"];
        string usuario = Membership.GetUser().UserName;


        string estado = request["estado"] == "null" ? "0" : request["estado"] ?? "0";
        estado = (estado == "undefined") ? "0" : estado;
        estado = (estado == "") ? "0" : estado;

    
        if (sortColumnName == null) return;


        var a = new ServicioCartaPorte.servi();
        //string output = a.CartasPorte_DynamicGridData(
        //                            sortColumnName, sortOrderBy, Convert.ToInt32(pageIndex),
        //                            Convert.ToInt32(numberOfRows), isSearch == "true", filters, FechaInicial, FechaFinal, Convert.ToInt32(puntovent),
        //                            SQLdinamico.BuscaIdWilliamsDestinoPreciso(destino, SC),
        //                            SC, usuario, scbdlmaster);


        //enumCDPestado estadofiltro;
        //switch (cmbEstado.Text  ')
        //        Case "TodasMenosLasRechazadas"
        //            estadofiltro = enumCDPestado.TodasMenosLasRechazadas
        //        Case "Incompletas"
        //            estadofiltro = enumCDPestado.Incompletas
        //        Case "Posición"
        //            estadofiltro = enumCDPestado.Posicion
        //        Case "Descargas"
        //            estadofiltro = enumCDPestado.DescargasMasFacturadas
        //        Case "Facturadas"
        //            estadofiltro = enumCDPestado.Facturadas
        //        Case "NoFacturadas"
        //            estadofiltro = enumCDPestado.NoFacturadas
        //        Case "Rechazadas"
        //            estadofiltro = enumCDPestado.Rechazadas
        //        Case "EnNotaCredito"
        //            estadofiltro = enumCDPestado.FacturadaPeroEnNotaCredito
        //        Case Else
        //            Return
        //    End Select




        string output = a.CartasPorte_DynamicGridData_Orden3(
                        sortColumnName, sortOrderBy, Convert.ToInt32(pageIndex),
                        Convert.ToInt32(numberOfRows), isSearch == "true", filters, FechaInicial, FechaFinal, Convert.ToInt32(puntovent),
                        SQLdinamico.BuscaIdWilliamsDestinoPreciso(destino, SC),
                        SC, usuario, scbdlmaster,Convert.ToInt32(estado)  );




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




}