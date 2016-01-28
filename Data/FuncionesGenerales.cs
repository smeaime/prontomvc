using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

namespace ProntoMVC.Data
{
    public class FuncionesGenericasCSharp
    {

        // funciones C# usadas por businesslogic (hecha en VB.net). Migrar del .Data a una dll aparte

        public class Resultados
        {
            public int IdCarta;
            public long numerocarta;
            public string errores;
            public string advertencias;
        }


        public static string RemoveSpecialCharacters(string str)
        {
            StringBuilder sb = new StringBuilder();
            foreach (char c in str)
            {
                if ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') 
                            || c == '.' || c == '_' || c == ' ' || c == '-' || c == '&' || char.IsLetterOrDigit(c) || c=='/')
                {
                    sb.Append(c);
                }
            }
            return sb.ToString();
        }


        static public List<Image> GetAllPages(string file) // sacar las paginas de un tiff
        {
            List<Image> images = new List<Image>();
            Bitmap bitmap = (Bitmap)Image.FromFile(file);
            int count = bitmap.GetFrameCount(FrameDimension.Page);
            for (int idx = 0; idx < count; idx++)
            {
                // save each frame to a bytestream
                bitmap.SelectActiveFrame(FrameDimension.Page, idx);
                MemoryStream byteStream = new MemoryStream();
                bitmap.Save(byteStream, ImageFormat.Tiff);
                // and then create a new Image from it
                images.Add(Image.FromStream(byteStream));
            } return images;
        }



        public static bool IsNumeric(object Expression)
        {
            bool isNum;
            double retNum;
            isNum = Double.TryParse(Convert.ToString(Expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
            return isNum;
        }

        public static bool mkf_validacuit(string mk_p_nroTemp)
        {
            int mk_suma;
            bool mk_valido;
            string mk_p_nro = mk_p_nroTemp; // == null ? "" : mk_p_nroTemp;
            mk_p_nro = mk_p_nro.Replace("-", "");

            try
            {


                if (IsNumeric(mk_p_nro))
                {
                    if (mk_p_nro.Length != 11)
                    {
                        mk_valido = false;
                    }
                    else
                    {
                        mk_suma = 0;
                        mk_suma += Convert.ToInt32(mk_p_nro.Substring(0, 1)) * 5;
                        mk_suma += Convert.ToInt32(mk_p_nro.Substring(1, 1)) * 4;
                        mk_suma += Convert.ToInt32(mk_p_nro.Substring(2, 1)) * 3;
                        mk_suma += Convert.ToInt32(mk_p_nro.Substring(3, 1)) * 2;
                        mk_suma += Convert.ToInt32(mk_p_nro.Substring(4, 1)) * 7;
                        mk_suma += Convert.ToInt32(mk_p_nro.Substring(5, 1)) * 6;
                        mk_suma += Convert.ToInt32(mk_p_nro.Substring(6, 1)) * 5;
                        mk_suma += Convert.ToInt32(mk_p_nro.Substring(7, 1)) * 4;
                        mk_suma += Convert.ToInt32(mk_p_nro.Substring(8, 1)) * 3;
                        mk_suma += Convert.ToInt32(mk_p_nro.Substring(9, 1)) * 2;
                        mk_suma += Convert.ToInt32(mk_p_nro.Substring(10, 1)) * 1;

                        if (Math.Round((double)mk_suma / 11, 0) == (mk_suma / 11))
                        {
                            mk_valido = true;
                        }
                        else
                        {
                            mk_valido = false;
                        }
                    }
                }
                else
                {
                    mk_valido = false;
                }

            }
            catch (Exception)
            {

                mk_valido = false;
            }

            return (mk_valido);
        }


















        public static int Fertilizantes_DynamicGridData(ProntoMVC.Data.Models.DemoProntoEntities db, string sidx, string sord, int page, int rows, bool _search, string filters)
        {

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;

            var pagedQuery = Filtrador.Filters.FiltroGenerico<Data.Models.Pedido>
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

            return 11;

            //if (sidx == "Numero") sidx = "NumeroPedido"; // como estoy haciendo "select a" (el renglon entero) en la linq antes de llamar jqGridJson, no pude ponerle el nombre explicito
            //if (searchField == "Numero") searchField = "NumeroPedido"; 

//            var Entidad = pagedQuery
//                //.Include(x => x.Moneda)
//                //.Include(x => x.Proveedor)
//                //.Include(x => x.DetallePedidos
//                //            .Select(y => y.DetalleRequerimiento
//                //                )
//                //        )
//                //.Include("DetallePedidos.DetalleRequerimiento.Requerimientos.Obra") // funciona tambien
//                //.Include(x => x.Comprador)
//                          .AsQueryable();


//            var Entidad1 = (from a in Entidad.Where(campo) select new { IdPedido = a.IdPedido });

//            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

//            var data = (from a in Entidad


//                        //   .Include(x => x.Proveedor)
//                        //  .Include("DetallePedidos.IdDetalleRequerimiento") // funciona tambien
//                        //.Include(x => x.DetallePedidos.Select(y => y. y.IdDetalleRequerimiento))
//                        // .Include(x => x.Aprobo)
//                        select

//                        a
//                //                        new
//                //                        {
//                //                            IdPedido = a.IdPedido,

////                            Numero = a.NumeroPedido,
//                //                            fecha
//                //                            fechasalida
//                //                            cumpli
//                //                            rms
//                //                            obras
//                //                            proveedor
//                //                            neto gravado
//                //                            bonif
//                //                            total iva


////// IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)-  
//                //// IsNull(Pedidos.ImpuestosInternos,0)-IsNull(Pedidos.OtrosConceptos1,0)-IsNull(Pedidos.OtrosConceptos2,0)-  
//                //// IsNull(Pedidos.OtrosConceptos3,0)-IsNull(Pedidos.OtrosConceptos4,0)-IsNull(Pedidos.OtrosConceptos5,0)as [Neto gravado],  
//                //// Case When Bonificacion=0 Then Null Else Bonificacion End as [Bonificacion],  

////// Case When TotalIva1=0 Then Null Else TotalIva1 End as [Total Iva],  

////// IsNull(Pedidos.ImpuestosInternos,0)+IsNull(Pedidos.OtrosConceptos1,0)+IsNull(Pedidos.OtrosConceptos2,0)+  
//                //// IsNull(Pedidos.OtrosConceptos3,0)+IsNull(Pedidos.OtrosConceptos4,0)+IsNull(Pedidos.OtrosConceptos5,0)as [Otros Conceptos],  
//                //// TotalPedido as [Total pedido],  





////                        }


//                        ).Where(campo).OrderBy(sidx + " " + sord)
//                //.Skip((currentPage - 1) * pageSize).Take(pageSize)
//.ToList();

//            var jsonData = new jqGridJson()
//            {
//                total = totalPages,
//                page = currentPage,
//                records = totalRecords,
//                rows = (from a in data
//                        select new jqGridRowJson
//                        {
//                            id = a.IdPedido.ToString(),
//                            cell = new string[] { 
//                                //"<a href="+ Url.Action("Edit",new {id = a.IdPedido} ) + " target='' >Editar</>" ,
//                                "<a href="+ Url.Action("Edit",new {id = a.IdPedido} ) + "  >Editar</>" ,
//                                a.IdPedido.ToString(), 
//                                a.NumeroPedido.NullSafeToString(), 
//                                a.SubNumero.NullSafeToString(), 
//                                 a.FechaPedido==null ? "" :  a.FechaPedido.GetValueOrDefault().ToString("dd/MM/yyyy"),
//                                 a.FechaSalida==null ? "" :  a.FechaSalida.GetValueOrDefault().ToString("dd/MM/yyyy"),
//                                a.Cumplido.NullSafeToString(), 


//                                string.Join(" ",  a.DetallePedidos.Select(x=>(x.DetalleRequerimiento==null) ? "" : 
//                                                     x.DetalleRequerimiento.Requerimientos == null ? "" :   
//                                                         x.DetalleRequerimiento.Requerimientos.NumeroRequerimiento.NullSafeToString() ).Distinct()),
//                                string.Join(" ",  a.DetallePedidos.Select(x=>(x.DetalleRequerimiento==null) ? "" : 
//                                                        x.DetalleRequerimiento.Requerimientos == null ? ""  :
//                                                            x.DetalleRequerimiento.Requerimientos.Obra == null ? ""  :
//                                                             x.DetalleRequerimiento.Requerimientos.Obra.NumeroObra.NullSafeToString()).Distinct()),


//                                a.Proveedor==null ? "" :  a.Proveedor.RazonSocial.NullSafeToString(), 
//                                (a.TotalPedido- a.TotalIva1+a.Bonificacion- (a.ImpuestosInternos ?? 0)- (a.OtrosConceptos1 ?? 0) - (a.OtrosConceptos2 ?? 0)-    (a.OtrosConceptos3 ?? 0) -( a.OtrosConceptos4 ?? 0) - (a.OtrosConceptos5 ?? 0)).ToString(),  
//                                a.Bonificacion.NullSafeToString(), 
//                                a.TotalIva1.NullSafeToString(), 
//                                a.Moneda==null ? "" :   a.Moneda.Abreviatura.NullSafeToString(),  
//                                a.Comprador==null ? "" :    a.Comprador.Nombre.NullSafeToString(),  
//                                a.Empleado==null ? "" :  a.Empleado.Nombre.NullSafeToString(),  
//                                a.DetallePedidos.Count().NullSafeToString(),  
//                                a.IdPedido.NullSafeToString(), 
//                                a.NumeroComparativa.NullSafeToString(),  
//                                a.IdTipoCompraRM.NullSafeToString(), 
//                                a.Observaciones.NullSafeToString(),   
//                                a.DetalleCondicionCompra.NullSafeToString(),   
//                                a.PedidoExterior.NullSafeToString(),  
//                                a.IdPedidoAbierto.NullSafeToString(), 
//                                a.NumeroLicitacion .NullSafeToString(), 
//                                a.Impresa.NullSafeToString(), 
//                                a.UsuarioAnulacion.NullSafeToString(), 
//                                a.FechaAnulacion.NullSafeToString(),  
//                                a.MotivoAnulacion.NullSafeToString(),  
//                                a.ImpuestosInternos.NullSafeToString(), 
//                                "", // #Auxiliar1.Equipos , 
//                                a.CircuitoFirmasCompleto.NullSafeToString(), 
//                                a.Proveedor==null ? "" : a.Proveedor.IdCodigoIva.NullSafeToString() ,
//                                a.IdComprador.NullSafeToString(),
//                                a.IdProveedor.NullSafeToString(),
//                                a.ConfirmadoPorWeb_1.NullSafeToString()

//                            }
//                        }).ToArray()
//            };

//            return Json(jsonData, JsonRequestBehavior.AllowGet);

            // return Json("asasf");


        }




    }
}




namespace ExtensionMethods
{
    public static class MyExtensions
    {
        // https://msdn.microsoft.com/en-us/library/bb383977.aspx
        // tenes que agregar "using ExtensionMethods" donde la quieras usar

    

        public static int WordCount(this String str)
        {
            return str.Split(new char[] { ' ', '.', '?' },
                             StringSplitOptions.RemoveEmptyEntries).Length;
        }


        public static string NullSafeToString(this object obj)
        {
            return obj != null ? obj.ToString() : String.Empty;
        }

    }
}