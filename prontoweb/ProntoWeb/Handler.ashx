﻿<%@ WebHandler Language="C#" Class="JQGridHandler" %>


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


public class JQGridHandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {

        // http://stackoverflow.com/questions/8392413/asp-net-returning-json-with-ashx
        // http://stackoverflow.com/questions/3275863/does-net-4-have-a-built-in-json-serializer-deserializer


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





    public virtual void Pedidos_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
    {

        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        int totalRecords = 0;

        
        
        var pagedQuery = Filtrador.Filters.FiltroGenerico<ProntoMVC.Data.Models.Pedido>
                            ("DetallePedidos.DetalleRequerimiento.Requerimientos.Obra", sidx, sord, page, rows, _search, filters, db, ref totalRecords);
        //"Moneda,Proveedor,DetallePedidos,Comprador,DetallePedidos.DetalleRequerimiento.Requerimientos.Obra"

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


        var Entidad1 = (from a in Entidad.Where(campo) select new { IdPedido = a.IdPedido });

        int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

        var data = (from a in Entidad


                    //   .Include(x => x.Proveedor)
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
                                "", //"<a href="+ Url.Action("Edit",new {id = a.IdPedido} ) + "  >Editar</>" ,
                                
                                a.IdPedido.ToString(), 
                                a.NumeroPedido.NullSafeToString(), 
                                a.SubNumero.NullSafeToString(), 
                                 a.FechaPedido==null ? "" :  a.FechaPedido.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                 a.FechaSalida==null ? "" :  a.FechaSalida.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Cumplido.NullSafeToString(), 


                                string.Join(" ",  a.DetallePedidos.Select(x=>(x.DetalleRequerimiento==null) ? "" : 
                                                     x.DetalleRequerimiento.Requerimientos == null ? "" :   
                                                         x.DetalleRequerimiento.Requerimientos.NumeroRequerimiento.NullSafeToString() ).Distinct()),
                                string.Join(" ",  a.DetallePedidos.Select(x=>(x.DetalleRequerimiento==null) ? "" : 
                                                        x.DetalleRequerimiento.Requerimientos == null ? ""  :
                                                            x.DetalleRequerimiento.Requerimientos.Obra == null ? ""  :
                                                             x.DetalleRequerimiento.Requerimientos.Obra.NumeroObra.NullSafeToString()).Distinct()),
                              
                                                             
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

        //return Json(jsonData, JsonRequestBehavior.AllowGet);
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