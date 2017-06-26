<%@ WebHandler Language="C#" Class="JQGridHandler" %>


using System;
using System.Web;
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




    public void ProcessRequest(HttpContext context)
    {


        string SC;

        if (System.Diagnostics.Debugger.IsAttached)
            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["scLocal"]);
        else
            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["scWilliamsDebug"]);
        


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


        if (sortColumnName == null) return;


        var a = new ServicioCartaPorte.servi();
        ServicioCartaPorte.jqGridJson jsonData = a.NormasCalidad_DynamicGridData(SC, sortColumnName, sortOrderBy, Convert.ToInt32(pageIndex), Convert.ToInt32(numberOfRows), isSearch == "true", filters);

        System.Web.Script.Serialization.JavaScriptSerializer jsonSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        string output = jsonSerializer.Serialize(jsonData);



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




}