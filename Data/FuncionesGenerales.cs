using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

using ProntoMVC.Data.Models;



/*
 * Created by SharpDevelop.
 * Date: 06/09/2005
 * Time: 08:38 a.m.
 * 
 * Desarrollador: Gustavo Alberto Rodriguez
 */

using System;


using System.Data;

using OfficeOpenXml; //EPPLUS, no confundir con el OOXML



using HtmlAgilityPack;


namespace ProntoMVC.Data
{
    public class FuncionesGenericasCSharp
    {


        public static DataTable GetExcel5_HTML_AgilityPack(string filePath)
        {


            HtmlDocument doc = new HtmlDocument();
            string texto = System.IO.File.ReadAllText(filePath);
            doc.LoadHtml(texto);



            DataTable dt = new DataTable();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();
            dt.Columns.Add();



            foreach (HtmlNode table in doc.DocumentNode.SelectNodes("//table"))
            {

                foreach (HtmlNode row in table.SelectNodes("tr"))
                {

                    DataRow dr = dt.NewRow();
                    int count = 0;

                    foreach (var cell in row.SelectNodes("td"))
                    {
                        dr[count] = cell.InnerText.Replace("&nbsp;", " ");
                        count++;
                    }

                    dt.Rows.Add(dr);

                }
            }



            return dt;
        }









        //// http://stackoverflow.com/questions/13396604/excel-to-datatable-using-epplus-excel-locked-for-editing
        //public static DataTable GetExcel4_ExcelDataReader(string filePath)
        //{

        //    FileStream stream = File.Open(filePath, FileMode.Open, FileAccess.Read);

        //    //1. Reading from a binary Excel file ('97-2003 format; *.xls)
        //    //ExcelDataReader.IExcelDataReader excelReader = ExcelDataReader.ExcelReaderFactory.CreateBinaryReader(stream);

        //    ExcelDataReader.IExcelDataReader excelReader = ExcelDataReader.ExcelReaderFactory.CreateReader(stream);


        //    //...
        //    ////2. Reading from a OpenXml Excel file (2007 format; *.xlsx)
        //    //IExcelDataReader excelReader = ExcelReaderFactory.CreateOpenXmlReader(stream);
        //    ////...
        //    //3. DataSet - The result of each spreadsheet will be created in the result.Tables
        //    DataSet result = excelReader.AsDataSet();
        //    //...
        //    ////4. DataSet - Create column names from first row
        //    //excelReader.IsFirstRowAsColumnNames = true;
        //    //DataSet result = excelReader.AsDataSet();

        //    ////5. Data Reader methods
        //    //while (excelReader.Read())
        //    //{
        //    //    //excelReader.GetInt32(0);
        //    //}

        //    //6. Free resources (IExcelDataReader is IDisposable)
        //    excelReader.Close();

        //    return result.Tables[0];

        //}







        // http://stackoverflow.com/questions/13396604/excel-to-datatable-using-epplus-excel-locked-for-editing
        public static DataTable GetExcel3_XLSX_EEPLUS(string path, bool hasHeader = true)
        {


            using (var pck = new OfficeOpenXml.ExcelPackage())
            {
                using (var stream = File.OpenRead(path))
                {
                    pck.Load(stream);
                }
                var ws = pck.Workbook.Worksheets.First();
                DataTable tbl = new DataTable();
                foreach (var firstRowCell in ws.Cells[1, 1, 1, ws.Dimension.End.Column])
                {
                    tbl.Columns.Add(hasHeader ? firstRowCell.Text : string.Format("column{0}", firstRowCell.Start.Column));
                }
                var startRow = hasHeader ? 2 : 1;
                for (int rowNum = startRow; rowNum <= ws.Dimension.End.Row; rowNum++)
                {
                    var wsRow = ws.Cells[rowNum, 1, rowNum, ws.Dimension.End.Column];
                    DataRow row = tbl.Rows.Add();
                    foreach (var cell in wsRow)
                    {
                        row[cell.Start.Column - 1] = cell.Text;
                    }
                }
                return tbl;
            }
        }



        public static string CSV_To_Excel(string csvFileName, string excelFileName, bool firstRowIsHeader = false, char delimiter= ',')
        {

            //string csvFileName = @"FL_insurance_sample.csv";
            //string excelFileName = @"FL_insurance_sample.xls";

            string worksheetsName = "Hoja1";


            var format = new ExcelTextFormat();
            format.Delimiter = delimiter;
            format.EOL = "\r";              // DEFAULT IS "\r\n";
                                            // format.TextQualifier = '"';

            using (ExcelPackage package = new ExcelPackage(new FileInfo(excelFileName)))
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add(worksheetsName);
                worksheet.Cells["A1"].LoadFromText(new FileInfo(csvFileName), format, OfficeOpenXml.Table.TableStyles.Medium27, firstRowIsHeader);
                package.Save();
            }

          
            return excelFileName;


        }








        // funciones C# usadas por businesslogic (hecha en VB.net). Migrar del .Data a una dll aparte

        public static Int32 levenshtein(String a, String b)
        {

            if (string.IsNullOrEmpty(a))
            {
                if (!string.IsNullOrEmpty(b))
                {
                    return b.Length;
                }
                return 0;
            }

            if (string.IsNullOrEmpty(b))
            {
                if (!string.IsNullOrEmpty(a))
                {
                    return a.Length;
                }
                return 0;
            }

            Int32 cost;
            Int32[,] d = new int[a.Length + 1, b.Length + 1];
            Int32 min1;
            Int32 min2;
            Int32 min3;

            for (Int32 i = 0; i <= d.GetUpperBound(0); i += 1)
            {
                d[i, 0] = i;
            }

            for (Int32 i = 0; i <= d.GetUpperBound(1); i += 1)
            {
                d[0, i] = i;
            }

            for (Int32 i = 1; i <= d.GetUpperBound(0); i += 1)
            {
                for (Int32 j = 1; j <= d.GetUpperBound(1); j += 1)
                {
                    cost = Convert.ToInt32(!(a[i - 1] == b[j - 1]));

                    min1 = d[i - 1, j] + 1;
                    min2 = d[i, j - 1] + 1;
                    min3 = d[i - 1, j - 1] + cost;
                    d[i, j] = Math.Min(Math.Min(min1, min2), min3);
                }
            }

            return d[d.GetUpperBound(0), d.GetUpperBound(1)];

        }



        public class Resultados
        {
            public int IdCarta;
            public long numerocarta;
            public string errores;
            public string advertencias;
        }


        public static string RemoveSpecialCharacters(string str)
        {
            if (str == null) return "";

            StringBuilder sb = new StringBuilder();
            foreach (char c in str)
            {
                if ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z')
                            || c == '.' || c == ',' || c == '%' || c == '_' || c == ' ' || c == '-' || c == '&' || char.IsLetterOrDigit(c) || c == '/')
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

                //bitmap.RotateFlip(RotateFlipType.Rotate180FlipNone);
                try
                {
                    bitmap.Save(byteStream, ImageFormat.Tiff);

                }
                catch (Exception)
                {
                    //                A generic error occurred in GDI+.
                    //Stack Trace:	at System.Drawing.Image.Save(Stream stream, ImageCodecInfo encoder, EncoderParameters encoderParams)
                    //at System.Drawing.Image.Save(Stream stream, ImageFormat format)
                    //at ProntoMVC.Data.FuncionesGenericasCSharp.GetAllPages(String file) in c:\Users\Administrador\Documents\bdl\pronto\Data\FuncionesGenerales.cs:line 113

                    //vos devolves la list de <image> habiendo cerrado el MemoryStream
                    //    http://stackoverflow.com/questions/15862810/a-generic-error-occured-in-gdi-in-bitmap-save-method
                    //    http://stackoverflow.com/questions/1053052/a-generic-error-occurred-in-gdi-jpeg-image-to-memorystream?noredirect=1&lq=1


                    //         verificá si no es un tema con el directorio
                    //A generic error occurred in GDI+. May also result from incorrect save path! Took me half a day to notice that. So make sure that you have double checked the path to save the image as well.

                    //A generic error occurred in GDI+. It can occur because of image storing paths issues,I got this error because my storing path is too long, I fixed this by first storing the image in a shortest path and move it to the correct location with long path handling techniques.

                    throw;
                }


                // and then create a new Image from it
                images.Add(Image.FromStream(byteStream));
            }
            return images;
        }



        public static bool IsNumeric(object Expression)
        {
            bool isNum;
            double retNum;
            isNum = Double.TryParse(Convert.ToString(Expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
            return isNum;
        }

        //public static bool mkf_validacuit(string mk_p_nroTemp)
        //{
        //    int mk_suma;
        //    bool mk_valido;
        //    string mk_p_nro = mk_p_nroTemp; // == null ? "" : mk_p_nroTemp;
        //    mk_p_nro = mk_p_nro.Replace("-", "");

        //    try
        //    {


        //        if (IsNumeric(mk_p_nro))
        //        {
        //            if (mk_p_nro.Length != 11)
        //            {
        //                mk_valido = false;
        //            }
        //            else
        //            {

        //                mk_suma = 0;
        //                mk_suma += Convert.ToInt32(mk_p_nro.Substring(0, 1)) * 5;
        //                mk_suma += Convert.ToInt32(mk_p_nro.Substring(1, 1)) * 4;
        //                mk_suma += Convert.ToInt32(mk_p_nro.Substring(2, 1)) * 3;
        //                mk_suma += Convert.ToInt32(mk_p_nro.Substring(3, 1)) * 2;
        //                mk_suma += Convert.ToInt32(mk_p_nro.Substring(4, 1)) * 7;
        //                mk_suma += Convert.ToInt32(mk_p_nro.Substring(5, 1)) * 6;
        //                mk_suma += Convert.ToInt32(mk_p_nro.Substring(6, 1)) * 5;
        //                mk_suma += Convert.ToInt32(mk_p_nro.Substring(7, 1)) * 4;
        //                mk_suma += Convert.ToInt32(mk_p_nro.Substring(8, 1)) * 3;
        //                mk_suma += Convert.ToInt32(mk_p_nro.Substring(9, 1)) * 2;
        //                mk_suma += Convert.ToInt32(mk_p_nro.Substring(10, 1)) * 1;

        //                if (Math.Round((double)mk_suma / 11, 0) == (mk_suma / 11))
        //                {
        //                    mk_valido = true;
        //                }
        //                else
        //                {
        //                    mk_valido = false;
        //                }
        //            }
        //        }
        //        else
        //        {
        //            mk_valido = false;
        //        }

        //    }
        //    catch (Exception)
        //    {

        //        mk_valido = false;
        //    }

        //    return (mk_valido);
        //}







        /// <summary>
        /// Description of CUIT.
        /// </summary>








        public static bool CUITValido(string _CUIT)
        {
            if (_CUIT == null) return false;

            _CUIT = _CUIT.Replace("-", "").Replace(" ", "");

            if (_CUIT.Length != 11) return false;



            string[] prefijos = { "30", "33", "34", "20", "23", "24", "27" };

            if (!prefijos.Contains(_CUIT.Substring(0, 2))) return false;

            string CUITValidado = string.Empty;
            bool Valido = false;
            char Ch;
            for (int i = 0; i < _CUIT.Length; i++)
            {
                Ch = _CUIT[i];
                if ((Ch > 47) && (Ch < 58))
                {
                    CUITValidado = CUITValidado + Ch;
                }
            }

            _CUIT = CUITValidado;
            Valido = (_CUIT.Length == 11);
            if (Valido)
            {
                int Verificador = EncontrarVerificador(_CUIT);
                Valido = (_CUIT[10].ToString() == Verificador.ToString());
            }

            return Valido;
        }

        public static int EncontrarVerificador(string CUIT)
        {
            int Sumador = 0;
            int Producto = 0;
            int Coeficiente = 0;
            int Resta = 5;
            for (int i = 0; i < 10; i++)
            {
                if (i == 4) Resta = 11;
                Producto = CUIT[i];
                Producto -= 48;
                Coeficiente = Resta - i;
                Producto = Producto * Coeficiente;
                Sumador = Sumador + Producto;
            }

            int Resultado = Sumador - (11 * (Sumador / 11));
            Resultado = 11 - Resultado;

            if (Resultado == 11) return 0;
            else return Resultado;
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




namespace CerealNet.WSCartasDePorte
{




    ///// <remarks/>
    //[System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.6.1067.0")]
    //[System.SerializableAttribute()]
    //[System.Diagnostics.DebuggerStepThroughAttribute()]
    //[System.ComponentModel.DesignerCategoryAttribute("code")]
    //[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://wsPosicion/")]
    //public partial class respuestaPosicion : object, System.ComponentModel.INotifyPropertyChanged
    //{

    //    private string codigoResultadoField;

    //    private string descripcionField;

    //    private cPposiafip[] posicionesField;

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 0)]
    //    public string codigoResultado
    //    {
    //        get
    //        {
    //            return this.codigoResultadoField;
    //        }
    //        set
    //        {
    //            this.codigoResultadoField = value;
    //            this.RaisePropertyChanged("codigoResultado");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 1)]
    //    public string descripcion
    //    {
    //        get
    //        {
    //            return this.descripcionField;
    //        }
    //        set
    //        {
    //            this.descripcionField = value;
    //            this.RaisePropertyChanged("descripcion");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute("posiciones", Form = System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable = true, Order = 2)]
    //    public cPposiafip[] posiciones
    //    {
    //        get
    //        {
    //            return this.posicionesField;
    //        }
    //        set
    //        {
    //            this.posicionesField = value;
    //            this.RaisePropertyChanged("posiciones");
    //        }
    //    }

    //    public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;

    //    protected void RaisePropertyChanged(string propertyName)
    //    {
    //        System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
    //        if ((propertyChanged != null))
    //        {
    //            propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
    //        }
    //    }
    //}

    ///// <remarks/>
    //[System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.6.1067.0")]
    //[System.SerializableAttribute()]
    //[System.Diagnostics.DebuggerStepThroughAttribute()]
    //[System.ComponentModel.DesignerCategoryAttribute("code")]
    //[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://wsPosicion/")]
    //public partial class cPposiafip : object, System.ComponentModel.INotifyPropertyChanged
    //{

    //    private string calidadField;

    //    private int codmercaField;

    //    private bool codmercaFieldSpecified;

    //    private int codonccalocdestinoField;

    //    private bool codonccalocdestinoFieldSpecified;

    //    private int codonccaprocedenciaField;

    //    private bool codonccaprocedenciaFieldSpecified;

    //    private int codonccaprovProceField;

    //    private bool codonccaprovProceFieldSpecified;

    //    private int codonccaprovdestinoField;

    //    private bool codonccaprovdestinoFieldSpecified;

    //    private int codonccapuertoField;

    //    private bool codonccapuertoFieldSpecified;

    //    private string cuitcorredorField;

    //    private string cuitentregadorField;

    //    private string cuitexportadorField;

    //    private string cuitintermediarioField;

    //    private string cuitpuertoField;

    //    private string cuitremitenteComercialField;

    //    private string cuittitularField;

    //    private string descripcionmercaField;

    //    private string estadoField;

    //    private System.DateTime fechaposicionField;

    //    private bool fechaposicionFieldSpecified;

    //    private int netodescargaField;

    //    private bool netodescargaFieldSpecified;

    //    private int netoprocedenciaField;

    //    private bool netoprocedenciaFieldSpecified;

    //    private string nombreentregadorField;

    //    private string nombreexportadorField;

    //    private string nombreintermediarioField;

    //    private string nombreremitenteComercialField;

    //    private string nombretitularField;

    //    private int nroVagonField;

    //    private bool nroVagonFieldSpecified;

    //    private int nrocpField;

    //    private string observacionesField;

    //    private int prefijocpField;

    //    private bool prefijocpFieldSpecified;

    //    private string procedenciaField;

    //    private string puertoField;

    //    private int turnoField;

    //    private bool turnoFieldSpecified;

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 0)]
    //    public string calidad
    //    {
    //        get
    //        {
    //            return this.calidadField;
    //        }
    //        set
    //        {
    //            this.calidadField = value;
    //            this.RaisePropertyChanged("calidad");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 1)]
    //    public int codmerca
    //    {
    //        get
    //        {
    //            return this.codmercaField;
    //        }
    //        set
    //        {
    //            this.codmercaField = value;
    //            this.RaisePropertyChanged("codmerca");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlIgnoreAttribute()]
    //    public bool codmercaSpecified
    //    {
    //        get
    //        {
    //            return this.codmercaFieldSpecified;
    //        }
    //        set
    //        {
    //            this.codmercaFieldSpecified = value;
    //            this.RaisePropertyChanged("codmercaSpecified");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 2)]
    //    public int codonccalocdestino
    //    {
    //        get
    //        {
    //            return this.codonccalocdestinoField;
    //        }
    //        set
    //        {
    //            this.codonccalocdestinoField = value;
    //            this.RaisePropertyChanged("codonccalocdestino");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlIgnoreAttribute()]
    //    public bool codonccalocdestinoSpecified
    //    {
    //        get
    //        {
    //            return this.codonccalocdestinoFieldSpecified;
    //        }
    //        set
    //        {
    //            this.codonccalocdestinoFieldSpecified = value;
    //            this.RaisePropertyChanged("codonccalocdestinoSpecified");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 3)]
    //    public int codonccaprocedencia
    //    {
    //        get
    //        {
    //            return this.codonccaprocedenciaField;
    //        }
    //        set
    //        {
    //            this.codonccaprocedenciaField = value;
    //            this.RaisePropertyChanged("codonccaprocedencia");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlIgnoreAttribute()]
    //    public bool codonccaprocedenciaSpecified
    //    {
    //        get
    //        {
    //            return this.codonccaprocedenciaFieldSpecified;
    //        }
    //        set
    //        {
    //            this.codonccaprocedenciaFieldSpecified = value;
    //            this.RaisePropertyChanged("codonccaprocedenciaSpecified");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 4)]
    //    public int codonccaprovProce
    //    {
    //        get
    //        {
    //            return this.codonccaprovProceField;
    //        }
    //        set
    //        {
    //            this.codonccaprovProceField = value;
    //            this.RaisePropertyChanged("codonccaprovProce");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlIgnoreAttribute()]
    //    public bool codonccaprovProceSpecified
    //    {
    //        get
    //        {
    //            return this.codonccaprovProceFieldSpecified;
    //        }
    //        set
    //        {
    //            this.codonccaprovProceFieldSpecified = value;
    //            this.RaisePropertyChanged("codonccaprovProceSpecified");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 5)]
    //    public int codonccaprovdestino
    //    {
    //        get
    //        {
    //            return this.codonccaprovdestinoField;
    //        }
    //        set
    //        {
    //            this.codonccaprovdestinoField = value;
    //            this.RaisePropertyChanged("codonccaprovdestino");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlIgnoreAttribute()]
    //    public bool codonccaprovdestinoSpecified
    //    {
    //        get
    //        {
    //            return this.codonccaprovdestinoFieldSpecified;
    //        }
    //        set
    //        {
    //            this.codonccaprovdestinoFieldSpecified = value;
    //            this.RaisePropertyChanged("codonccaprovdestinoSpecified");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 6)]
    //    public int codonccapuerto
    //    {
    //        get
    //        {
    //            return this.codonccapuertoField;
    //        }
    //        set
    //        {
    //            this.codonccapuertoField = value;
    //            this.RaisePropertyChanged("codonccapuerto");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlIgnoreAttribute()]
    //    public bool codonccapuertoSpecified
    //    {
    //        get
    //        {
    //            return this.codonccapuertoFieldSpecified;
    //        }
    //        set
    //        {
    //            this.codonccapuertoFieldSpecified = value;
    //            this.RaisePropertyChanged("codonccapuertoSpecified");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 7)]
    //    public string cuitcorredor
    //    {
    //        get
    //        {
    //            return this.cuitcorredorField;
    //        }
    //        set
    //        {
    //            this.cuitcorredorField = value;
    //            this.RaisePropertyChanged("cuitcorredor");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 8)]
    //    public string cuitentregador
    //    {
    //        get
    //        {
    //            return this.cuitentregadorField;
    //        }
    //        set
    //        {
    //            this.cuitentregadorField = value;
    //            this.RaisePropertyChanged("cuitentregador");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 9)]
    //    public string cuitexportador
    //    {
    //        get
    //        {
    //            return this.cuitexportadorField;
    //        }
    //        set
    //        {
    //            this.cuitexportadorField = value;
    //            this.RaisePropertyChanged("cuitexportador");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 10)]
    //    public string cuitintermediario
    //    {
    //        get
    //        {
    //            return this.cuitintermediarioField;
    //        }
    //        set
    //        {
    //            this.cuitintermediarioField = value;
    //            this.RaisePropertyChanged("cuitintermediario");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 11)]
    //    public string cuitpuerto
    //    {
    //        get
    //        {
    //            return this.cuitpuertoField;
    //        }
    //        set
    //        {
    //            this.cuitpuertoField = value;
    //            this.RaisePropertyChanged("cuitpuerto");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 12)]
    //    public string cuitremitenteComercial
    //    {
    //        get
    //        {
    //            return this.cuitremitenteComercialField;
    //        }
    //        set
    //        {
    //            this.cuitremitenteComercialField = value;
    //            this.RaisePropertyChanged("cuitremitenteComercial");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 13)]
    //    public string cuittitular
    //    {
    //        get
    //        {
    //            return this.cuittitularField;
    //        }
    //        set
    //        {
    //            this.cuittitularField = value;
    //            this.RaisePropertyChanged("cuittitular");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 14)]
    //    public string descripcionmerca
    //    {
    //        get
    //        {
    //            return this.descripcionmercaField;
    //        }
    //        set
    //        {
    //            this.descripcionmercaField = value;
    //            this.RaisePropertyChanged("descripcionmerca");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 15)]
    //    public string estado
    //    {
    //        get
    //        {
    //            return this.estadoField;
    //        }
    //        set
    //        {
    //            this.estadoField = value;
    //            this.RaisePropertyChanged("estado");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 16)]
    //    public System.DateTime fechaposicion
    //    {
    //        get
    //        {
    //            return this.fechaposicionField;
    //        }
    //        set
    //        {
    //            this.fechaposicionField = value;
    //            this.RaisePropertyChanged("fechaposicion");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlIgnoreAttribute()]
    //    public bool fechaposicionSpecified
    //    {
    //        get
    //        {
    //            return this.fechaposicionFieldSpecified;
    //        }
    //        set
    //        {
    //            this.fechaposicionFieldSpecified = value;
    //            this.RaisePropertyChanged("fechaposicionSpecified");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 17)]
    //    public int netodescarga
    //    {
    //        get
    //        {
    //            return this.netodescargaField;
    //        }
    //        set
    //        {
    //            this.netodescargaField = value;
    //            this.RaisePropertyChanged("netodescarga");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlIgnoreAttribute()]
    //    public bool netodescargaSpecified
    //    {
    //        get
    //        {
    //            return this.netodescargaFieldSpecified;
    //        }
    //        set
    //        {
    //            this.netodescargaFieldSpecified = value;
    //            this.RaisePropertyChanged("netodescargaSpecified");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 18)]
    //    public int netoprocedencia
    //    {
    //        get
    //        {
    //            return this.netoprocedenciaField;
    //        }
    //        set
    //        {
    //            this.netoprocedenciaField = value;
    //            this.RaisePropertyChanged("netoprocedencia");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlIgnoreAttribute()]
    //    public bool netoprocedenciaSpecified
    //    {
    //        get
    //        {
    //            return this.netoprocedenciaFieldSpecified;
    //        }
    //        set
    //        {
    //            this.netoprocedenciaFieldSpecified = value;
    //            this.RaisePropertyChanged("netoprocedenciaSpecified");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 19)]
    //    public string nombreentregador
    //    {
    //        get
    //        {
    //            return this.nombreentregadorField;
    //        }
    //        set
    //        {
    //            this.nombreentregadorField = value;
    //            this.RaisePropertyChanged("nombreentregador");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 20)]
    //    public string nombreexportador
    //    {
    //        get
    //        {
    //            return this.nombreexportadorField;
    //        }
    //        set
    //        {
    //            this.nombreexportadorField = value;
    //            this.RaisePropertyChanged("nombreexportador");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 21)]
    //    public string nombreintermediario
    //    {
    //        get
    //        {
    //            return this.nombreintermediarioField;
    //        }
    //        set
    //        {
    //            this.nombreintermediarioField = value;
    //            this.RaisePropertyChanged("nombreintermediario");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 22)]
    //    public string nombreremitenteComercial
    //    {
    //        get
    //        {
    //            return this.nombreremitenteComercialField;
    //        }
    //        set
    //        {
    //            this.nombreremitenteComercialField = value;
    //            this.RaisePropertyChanged("nombreremitenteComercial");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 23)]
    //    public string nombretitular
    //    {
    //        get
    //        {
    //            return this.nombretitularField;
    //        }
    //        set
    //        {
    //            this.nombretitularField = value;
    //            this.RaisePropertyChanged("nombretitular");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 24)]
    //    public int nroVagon
    //    {
    //        get
    //        {
    //            return this.nroVagonField;
    //        }
    //        set
    //        {
    //            this.nroVagonField = value;
    //            this.RaisePropertyChanged("nroVagon");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlIgnoreAttribute()]
    //    public bool nroVagonSpecified
    //    {
    //        get
    //        {
    //            return this.nroVagonFieldSpecified;
    //        }
    //        set
    //        {
    //            this.nroVagonFieldSpecified = value;
    //            this.RaisePropertyChanged("nroVagonSpecified");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 25)]
    //    public int nrocp
    //    {
    //        get
    //        {
    //            return this.nrocpField;
    //        }
    //        set
    //        {
    //            this.nrocpField = value;
    //            this.RaisePropertyChanged("nrocp");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 26)]
    //    public string observaciones
    //    {
    //        get
    //        {
    //            return this.observacionesField;
    //        }
    //        set
    //        {
    //            this.observacionesField = value;
    //            this.RaisePropertyChanged("observaciones");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 27)]
    //    public int prefijocp
    //    {
    //        get
    //        {
    //            return this.prefijocpField;
    //        }
    //        set
    //        {
    //            this.prefijocpField = value;
    //            this.RaisePropertyChanged("prefijocp");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlIgnoreAttribute()]
    //    public bool prefijocpSpecified
    //    {
    //        get
    //        {
    //            return this.prefijocpFieldSpecified;
    //        }
    //        set
    //        {
    //            this.prefijocpFieldSpecified = value;
    //            this.RaisePropertyChanged("prefijocpSpecified");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 28)]
    //    public string procedencia
    //    {
    //        get
    //        {
    //            return this.procedenciaField;
    //        }
    //        set
    //        {
    //            this.procedenciaField = value;
    //            this.RaisePropertyChanged("procedencia");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 29)]
    //    public string puerto
    //    {
    //        get
    //        {
    //            return this.puertoField;
    //        }
    //        set
    //        {
    //            this.puertoField = value;
    //            this.RaisePropertyChanged("puerto");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 30)]
    //    public int turno
    //    {
    //        get
    //        {
    //            return this.turnoField;
    //        }
    //        set
    //        {
    //            this.turnoField = value;
    //            this.RaisePropertyChanged("turno");
    //        }
    //    }

    //    /// <remarks/>
    //    [System.Xml.Serialization.XmlIgnoreAttribute()]
    //    public bool turnoSpecified
    //    {
    //        get
    //        {
    //            return this.turnoFieldSpecified;
    //        }
    //        set
    //        {
    //            this.turnoFieldSpecified = value;
    //            this.RaisePropertyChanged("turnoSpecified");
    //        }
    //    }

    //    public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;

    //    protected void RaisePropertyChanged(string propertyName)
    //    {
    //        System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
    //        if ((propertyChanged != null))
    //        {
    //            propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
    //        }
    //    }
    //}

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.6.1067.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    //[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://wsPosicion/")]
    public partial class analisis //: object, System.ComponentModel.INotifyPropertyChanged
    {

        public string rubro;
        public int kilosMermas;
        public decimal porcentajeAnalisis;
        public decimal porcentajeMerma;

        //public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;

        //protected void RaisePropertyChanged(string propertyName)
        //{
        //    System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
        //    if ((propertyChanged != null))
        //    {
        //        propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
        //    }
        //}

        /*
        private int kilosMermasField;

        private bool kilosMermasFieldSpecified;

        private decimal porcentajeAnalisisField;

        private bool porcentajeAnalisisFieldSpecified;

        private decimal porcentajeMermaField;

        private bool porcentajeMermaFieldSpecified;

        private string rubroField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 0)]
        public int kilosMermas
        {
            get
            {
                return this.kilosMermasField;
            }
            set
            {
                this.kilosMermasField = value;
                this.RaisePropertyChanged("kilosMermas");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool kilosMermasSpecified
        {
            get
            {
                return this.kilosMermasFieldSpecified;
            }
            set
            {
                this.kilosMermasFieldSpecified = value;
                this.RaisePropertyChanged("kilosMermasSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 1)]
        public decimal porcentajeAnalisis
        {
            get
            {
                return this.porcentajeAnalisisField;
            }
            set
            {
                this.porcentajeAnalisisField = value;
                this.RaisePropertyChanged("porcentajeAnalisis");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool porcentajeAnalisisSpecified
        {
            get
            {
                return this.porcentajeAnalisisFieldSpecified;
            }
            set
            {
                this.porcentajeAnalisisFieldSpecified = value;
                this.RaisePropertyChanged("porcentajeAnalisisSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 2)]
        public decimal porcentajeMerma
        {
            get
            {
                return this.porcentajeMermaField;
            }
            set
            {
                this.porcentajeMermaField = value;
                this.RaisePropertyChanged("porcentajeMerma");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool porcentajeMermaSpecified
        {
            get
            {
                return this.porcentajeMermaFieldSpecified;
            }
            set
            {
                this.porcentajeMermaFieldSpecified = value;
                this.RaisePropertyChanged("porcentajeMermaSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 3)]
        public string rubro
        {
            get
            {
                return this.rubroField;
            }
            set
            {
                this.rubroField = value;
                this.RaisePropertyChanged("rubro");
            }
        }

  
          */
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.6.1067.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    //[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://wsPosicion/")]
    public partial class cartaPorte //: object, System.ComponentModel.INotifyPropertyChanged
    {

        public int brutodest;
        //public bool brutodestSpecified;
        public string CPoriginal;
        public string calidad;
        public int cartaporte;
        public int codmerca;
        //public bool codmercaSpecified;
        public int codonccalocalidadpuerto;
        //public bool codonccalocalidadpuertoSpecified;
        public int codonccalocalproc;
        //public bool codonccalocalprocSpecified;
        public int codonccaprovincialproc;
        //public bool codonccaprovincialprocSpecified;
        public int codonccaprovinciapuerto;
        //public bool codonccaprovinciapuertoSpecified;
        public int codonccapuerto;
        //public bool codonccapuertoSpecified;
        public string codpostalprocedencia;
        public string contrato;
        public string cosecha;
        public string cuitcorredor;
        public string cuitentregador;
        public string cuitexport;
        public string cuitinter;
        public string cuitpuerto;
        public string cuitremic;
        public string cuitremitente;
        public string cuittitu;
        public string entregador;
        public System.DateTime fechadescarga;
        //public bool fechadescargaSpecified;
        public System.DateTime fechaposicion;
        //public bool fechaposicionSpecified;
        public string horadescarga;
        public string intermediario;
        public analisis[] listaAnalisis;
        public string localidaddestino;
        public string mercaderia;
        public int netodest;
        //public bool netodestSpecified;
        public int netoproc;
        //public bool netoprocSpecified;
        public string nomExport;
        public string nomRemic;
        public string nomcorre;
        public string nroRecibo;
        public string observaciones;
        public string observado;
        public string patente;
        public string procedencia;
        public string puerto;
        public string remitente;
        public int taradest;
        //public bool taradestSpecified;
        public string titular;
        public string usuario;
        public int vagon;











        //public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;

        //protected void RaisePropertyChanged(string propertyName)
        //{
        //    System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
        //    if ((propertyChanged != null))
        //    {
        //        propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
        //    }
        //}





        /*
        private int brutodestField;

        private bool brutodestFieldSpecified;

        private string cPoriginalField;

        private string calidadField;

        private int cartaporteField;

        private int codmercaField;

        private bool codmercaFieldSpecified;

        private int codonccalocalidadpuertoField;

        private bool codonccalocalidadpuertoFieldSpecified;

        private int codonccalocalprocField;

        private bool codonccalocalprocFieldSpecified;

        private int codonccaprovincialprocField;

        private bool codonccaprovincialprocFieldSpecified;

        private int codonccaprovinciapuertoField;

        private bool codonccaprovinciapuertoFieldSpecified;

        private int codonccapuertoField;

        private bool codonccapuertoFieldSpecified;

        private string codpostalprocedenciaField;

        private string contratoField;

        private string cosechaField;

        private string cuitcorredorField;

        private string cuitentregadorField;

        private string cuitexportField;

        private string cuitinterField;

        private string cuitpuertoField;

        private string cuitremicField;

        private string cuitremitenteField;

        private string cuittituField;

        private string entregadorField;

        private System.DateTime fechadescargaField;

        private bool fechadescargaFieldSpecified;

        private System.DateTime fechaposicionField;

        private bool fechaposicionFieldSpecified;

        private string horadescargaField;

        private string intermediarioField;

        private analisis[] listaAnalisisField;

        private string localidaddestinoField;

        private string mercaderiaField;

        private int netodestField;

        private bool netodestFieldSpecified;

        private int netoprocField;

        private bool netoprocFieldSpecified;

        private string nomExportField;

        private string nomRemicField;

        private string nomcorreField;

        private string nroReciboField;

        private string observacionesField;

        private string observadoField;

        private string patenteField;

        private string procedenciaField;

        private string puertoField;

        private string remitenteField;

        private int taradestField;

        private bool taradestFieldSpecified;

        private string titularField;

        private string usuarioField;

        private int vagonField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 0)]
        public int brutodest
        {
            get
            {
                return this.brutodestField;
            }
            set
            {
                this.brutodestField = value;
                this.RaisePropertyChanged("brutodest");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool brutodestSpecified
        {
            get
            {
                return this.brutodestFieldSpecified;
            }
            set
            {
                this.brutodestFieldSpecified = value;
                this.RaisePropertyChanged("brutodestSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 1)]
        public string CPoriginal
        {
            get
            {
                return this.cPoriginalField;
            }
            set
            {
                this.cPoriginalField = value;
                this.RaisePropertyChanged("CPoriginal");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 2)]
        public string calidad
        {
            get
            {
                return this.calidadField;
            }
            set
            {
                this.calidadField = value;
                this.RaisePropertyChanged("calidad");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 3)]
        public int cartaporte
        {
            get
            {
                return this.cartaporteField;
            }
            set
            {
                this.cartaporteField = value;
                this.RaisePropertyChanged("cartaporte");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 4)]
        public int codmerca
        {
            get
            {
                return this.codmercaField;
            }
            set
            {
                this.codmercaField = value;
                this.RaisePropertyChanged("codmerca");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool codmercaSpecified
        {
            get
            {
                return this.codmercaFieldSpecified;
            }
            set
            {
                this.codmercaFieldSpecified = value;
                this.RaisePropertyChanged("codmercaSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 5)]
        public int codonccalocalidadpuerto
        {
            get
            {
                return this.codonccalocalidadpuertoField;
            }
            set
            {
                this.codonccalocalidadpuertoField = value;
                this.RaisePropertyChanged("codonccalocalidadpuerto");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool codonccalocalidadpuertoSpecified
        {
            get
            {
                return this.codonccalocalidadpuertoFieldSpecified;
            }
            set
            {
                this.codonccalocalidadpuertoFieldSpecified = value;
                this.RaisePropertyChanged("codonccalocalidadpuertoSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 6)]
        public int codonccalocalproc
        {
            get
            {
                return this.codonccalocalprocField;
            }
            set
            {
                this.codonccalocalprocField = value;
                this.RaisePropertyChanged("codonccalocalproc");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool codonccalocalprocSpecified
        {
            get
            {
                return this.codonccalocalprocFieldSpecified;
            }
            set
            {
                this.codonccalocalprocFieldSpecified = value;
                this.RaisePropertyChanged("codonccalocalprocSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 7)]
        public int codonccaprovincialproc
        {
            get
            {
                return this.codonccaprovincialprocField;
            }
            set
            {
                this.codonccaprovincialprocField = value;
                this.RaisePropertyChanged("codonccaprovincialproc");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool codonccaprovincialprocSpecified
        {
            get
            {
                return this.codonccaprovincialprocFieldSpecified;
            }
            set
            {
                this.codonccaprovincialprocFieldSpecified = value;
                this.RaisePropertyChanged("codonccaprovincialprocSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 8)]
        public int codonccaprovinciapuerto
        {
            get
            {
                return this.codonccaprovinciapuertoField;
            }
            set
            {
                this.codonccaprovinciapuertoField = value;
                this.RaisePropertyChanged("codonccaprovinciapuerto");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool codonccaprovinciapuertoSpecified
        {
            get
            {
                return this.codonccaprovinciapuertoFieldSpecified;
            }
            set
            {
                this.codonccaprovinciapuertoFieldSpecified = value;
                this.RaisePropertyChanged("codonccaprovinciapuertoSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 9)]
        public int codonccapuerto
        {
            get
            {
                return this.codonccapuertoField;
            }
            set
            {
                this.codonccapuertoField = value;
                this.RaisePropertyChanged("codonccapuerto");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool codonccapuertoSpecified
        {
            get
            {
                return this.codonccapuertoFieldSpecified;
            }
            set
            {
                this.codonccapuertoFieldSpecified = value;
                this.RaisePropertyChanged("codonccapuertoSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 10)]
        public string codpostalprocedencia
        {
            get
            {
                return this.codpostalprocedenciaField;
            }
            set
            {
                this.codpostalprocedenciaField = value;
                this.RaisePropertyChanged("codpostalprocedencia");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 11)]
        public string contrato
        {
            get
            {
                return this.contratoField;
            }
            set
            {
                this.contratoField = value;
                this.RaisePropertyChanged("contrato");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 12)]
        public string cosecha
        {
            get
            {
                return this.cosechaField;
            }
            set
            {
                this.cosechaField = value;
                this.RaisePropertyChanged("cosecha");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 13)]
        public string cuitcorredor
        {
            get
            {
                return this.cuitcorredorField;
            }
            set
            {
                this.cuitcorredorField = value;
                this.RaisePropertyChanged("cuitcorredor");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 14)]
        public string cuitentregador
        {
            get
            {
                return this.cuitentregadorField;
            }
            set
            {
                this.cuitentregadorField = value;
                this.RaisePropertyChanged("cuitentregador");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 15)]
        public string cuitexport
        {
            get
            {
                return this.cuitexportField;
            }
            set
            {
                this.cuitexportField = value;
                this.RaisePropertyChanged("cuitexport");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 16)]
        public string cuitinter
        {
            get
            {
                return this.cuitinterField;
            }
            set
            {
                this.cuitinterField = value;
                this.RaisePropertyChanged("cuitinter");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 17)]
        public string cuitpuerto
        {
            get
            {
                return this.cuitpuertoField;
            }
            set
            {
                this.cuitpuertoField = value;
                this.RaisePropertyChanged("cuitpuerto");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 18)]
        public string cuitremic
        {
            get
            {
                return this.cuitremicField;
            }
            set
            {
                this.cuitremicField = value;
                this.RaisePropertyChanged("cuitremic");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 19)]
        public string cuitremitente
        {
            get
            {
                return this.cuitremitenteField;
            }
            set
            {
                this.cuitremitenteField = value;
                this.RaisePropertyChanged("cuitremitente");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 20)]
        public string cuittitu
        {
            get
            {
                return this.cuittituField;
            }
            set
            {
                this.cuittituField = value;
                this.RaisePropertyChanged("cuittitu");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 21)]
        public string entregador
        {
            get
            {
                return this.entregadorField;
            }
            set
            {
                this.entregadorField = value;
                this.RaisePropertyChanged("entregador");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 22)]
        public System.DateTime fechadescarga
        {
            get
            {
                return this.fechadescargaField;
            }
            set
            {
                this.fechadescargaField = value;
                this.RaisePropertyChanged("fechadescarga");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool fechadescargaSpecified
        {
            get
            {
                return this.fechadescargaFieldSpecified;
            }
            set
            {
                this.fechadescargaFieldSpecified = value;
                this.RaisePropertyChanged("fechadescargaSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 23)]
        public System.DateTime fechaposicion
        {
            get
            {
                return this.fechaposicionField;
            }
            set
            {
                this.fechaposicionField = value;
                this.RaisePropertyChanged("fechaposicion");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool fechaposicionSpecified
        {
            get
            {
                return this.fechaposicionFieldSpecified;
            }
            set
            {
                this.fechaposicionFieldSpecified = value;
                this.RaisePropertyChanged("fechaposicionSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 24)]
        public string horadescarga
        {
            get
            {
                return this.horadescargaField;
            }
            set
            {
                this.horadescargaField = value;
                this.RaisePropertyChanged("horadescarga");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 25)]
        public string intermediario
        {
            get
            {
                return this.intermediarioField;
            }
            set
            {
                this.intermediarioField = value;
                this.RaisePropertyChanged("intermediario");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("listaAnalisis", Form = System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable = true, Order = 26)]
        public analisis[] listaAnalisis
        {
            get
            {
                return this.listaAnalisisField;
            }
            set
            {
                this.listaAnalisisField = value;
                this.RaisePropertyChanged("listaAnalisis");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 27)]
        public string localidaddestino
        {
            get
            {
                return this.localidaddestinoField;
            }
            set
            {
                this.localidaddestinoField = value;
                this.RaisePropertyChanged("localidaddestino");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 28)]
        public string mercaderia
        {
            get
            {
                return this.mercaderiaField;
            }
            set
            {
                this.mercaderiaField = value;
                this.RaisePropertyChanged("mercaderia");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 29)]
        public int netodest
        {
            get
            {
                return this.netodestField;
            }
            set
            {
                this.netodestField = value;
                this.RaisePropertyChanged("netodest");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool netodestSpecified
        {
            get
            {
                return this.netodestFieldSpecified;
            }
            set
            {
                this.netodestFieldSpecified = value;
                this.RaisePropertyChanged("netodestSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 30)]
        public int netoproc
        {
            get
            {
                return this.netoprocField;
            }
            set
            {
                this.netoprocField = value;
                this.RaisePropertyChanged("netoproc");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool netoprocSpecified
        {
            get
            {
                return this.netoprocFieldSpecified;
            }
            set
            {
                this.netoprocFieldSpecified = value;
                this.RaisePropertyChanged("netoprocSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 31)]
        public string nomExport
        {
            get
            {
                return this.nomExportField;
            }
            set
            {
                this.nomExportField = value;
                this.RaisePropertyChanged("nomExport");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 32)]
        public string nomRemic
        {
            get
            {
                return this.nomRemicField;
            }
            set
            {
                this.nomRemicField = value;
                this.RaisePropertyChanged("nomRemic");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 33)]
        public string nomcorre
        {
            get
            {
                return this.nomcorreField;
            }
            set
            {
                this.nomcorreField = value;
                this.RaisePropertyChanged("nomcorre");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 34)]
        public string nroRecibo
        {
            get
            {
                return this.nroReciboField;
            }
            set
            {
                this.nroReciboField = value;
                this.RaisePropertyChanged("nroRecibo");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 35)]
        public string observaciones
        {
            get
            {
                return this.observacionesField;
            }
            set
            {
                this.observacionesField = value;
                this.RaisePropertyChanged("observaciones");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 36)]
        public string observado
        {
            get
            {
                return this.observadoField;
            }
            set
            {
                this.observadoField = value;
                this.RaisePropertyChanged("observado");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 37)]
        public string patente
        {
            get
            {
                return this.patenteField;
            }
            set
            {
                this.patenteField = value;
                this.RaisePropertyChanged("patente");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 38)]
        public string procedencia
        {
            get
            {
                return this.procedenciaField;
            }
            set
            {
                this.procedenciaField = value;
                this.RaisePropertyChanged("procedencia");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 39)]
        public string puerto
        {
            get
            {
                return this.puertoField;
            }
            set
            {
                this.puertoField = value;
                this.RaisePropertyChanged("puerto");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 40)]
        public string remitente
        {
            get
            {
                return this.remitenteField;
            }
            set
            {
                this.remitenteField = value;
                this.RaisePropertyChanged("remitente");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 41)]
        public int taradest
        {
            get
            {
                return this.taradestField;
            }
            set
            {
                this.taradestField = value;
                this.RaisePropertyChanged("taradest");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool taradestSpecified
        {
            get
            {
                return this.taradestFieldSpecified;
            }
            set
            {
                this.taradestFieldSpecified = value;
                this.RaisePropertyChanged("taradestSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 42)]
        public string titular
        {
            get
            {
                return this.titularField;
            }
            set
            {
                this.titularField = value;
                this.RaisePropertyChanged("titular");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 43)]
        public string usuario
        {
            get
            {
                return this.usuarioField;
            }
            set
            {
                this.usuarioField = value;
                this.RaisePropertyChanged("usuario");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 44)]
        public int vagon
        {
            get
            {
                return this.vagonField;
            }
            set
            {
                this.vagonField = value;
                this.RaisePropertyChanged("vagon");
            }
        }

        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;

        protected void RaisePropertyChanged(string propertyName)
        {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null))
            {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
         * 
         * */
    }






    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.6.1067.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    //[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://wsPosicion/")]
    public partial class cartaPorte_v4
    {

        public int brutodest;
        //public bool brutodestSpecified;
        public string CPoriginal;
        public string calidad;
        public long cartaporte;
        public int codmerca;
        //public bool codmercaSpecified;
        public int codonccalocalidadpuerto;
        //public bool codonccalocalidadpuertoSpecified;
        public int codonccalocalproc;
        //public bool codonccalocalprocSpecified;
        public int codonccaprovincialproc;
        //public bool codonccaprovincialprocSpecified;
        public int codonccaprovinciapuerto;
        //public bool codonccaprovinciapuertoSpecified;
        public int codonccapuerto;
        //public bool codonccapuertoSpecified;
        public string codpostalprocedencia;
        public string contrato;
        public string cosecha;
        public string cuitcorredor;
        public string cuitentregador;
        public string cuitexport;
        public string cuitinter;
        public string cuitpuerto;
        public string cuitremic;
        public string cuitremitente;
        public string cuittitu;
        public string entregador;
        public System.DateTime fechadescarga;
        //public bool fechadescargaSpecified;
        public System.DateTime fechaposicion;
        //public bool fechaposicionSpecified;
        public string horadescarga;
        public string intermediario;
        public analisis[] listaAnalisis;
        public string localidaddestino;
        public string mercaderia;
        public int netodest;
        //public bool netodestSpecified;
        public int netoproc;
        //public bool netoprocSpecified;
        public string nomExport;
        public string nomRemic;
        public string nomcorre;
        public string nroRecibo;
        public string observaciones;
        public string observado;
        public string patente;
        public string procedencia;
        public string puerto;
        public string remitente;
        public int taradest;
        //public bool taradestSpecified;
        public string titular;
        public string usuario;
        public int vagon;



        public string Cupo;
        public string Turno;


        // version 2
        public long CEE;
        public System.DateTime fechaEmisionCarga;
        public System.DateTime fechavencimiento;
        public int CTG;
      

        public System.DateTime HoraArribo;
        public int brutoproc;
        public int taraproc;
        public decimal Humedad;
        public int MermaHumedad;
        public int OtrasMermas;
        public int NetoFinal;
        public string ClienteObserv;
        public string CorredorObs;
        public string cuitchofer;
        public string Chofer;
        public string cuittransportista;
        public string transportista;
        public string acoplado;
        public int kmarecorrer;
        public decimal tarifa;
        public string Establecimiento;
        public int IdPosicionEstado;
        public string PosicionEstado;



        public string SojaSustentableCodCondicion;
        public string SojaSustentableCondicion;
        public string SojaSustentableNroEstablecimientoDeProduccion;


    }






    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.6.1067.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    //[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://wsPosicion/")]
    public partial class cartaPorte_v3
    {

        public int brutodest;
        //public bool brutodestSpecified;
        public string CPoriginal;
        public string calidad;
        public long cartaporte;
        public int codmerca;
        //public bool codmercaSpecified;
        public int codonccalocalidadpuerto;
        //public bool codonccalocalidadpuertoSpecified;
        public int codonccalocalproc;
        //public bool codonccalocalprocSpecified;
        public int codonccaprovincialproc;
        //public bool codonccaprovincialprocSpecified;
        public int codonccaprovinciapuerto;
        //public bool codonccaprovinciapuertoSpecified;
        public int codonccapuerto;
        //public bool codonccapuertoSpecified;
        public string codpostalprocedencia;
        public string contrato;
        public string cosecha;
        public string cuitcorredor;
        public string cuitentregador;
        public string cuitexport;
        public string cuitinter;
        public string cuitpuerto;
        public string cuitremic;
        public string cuitremitente;
        public string cuittitu;
        public string entregador;
        public System.DateTime fechadescarga;
        //public bool fechadescargaSpecified;
        public System.DateTime fechaposicion;
        //public bool fechaposicionSpecified;
        public string horadescarga;
        public string intermediario;
        public analisis[] listaAnalisis;
        public string localidaddestino;
        public string mercaderia;
        public int netodest;
        //public bool netodestSpecified;
        public int netoproc;
        //public bool netoprocSpecified;
        public string nomExport;
        public string nomRemic;
        public string nomcorre;
        public string nroRecibo;
        public string observaciones;
        public string observado;
        public string patente;
        public string procedencia;
        public string puerto;
        public string remitente;
        public int taradest;
        //public bool taradestSpecified;
        public string titular;
        public string usuario;
        public int vagon;


        // version 2
        public long CEE;
        public System.DateTime fechaEmisionCarga;
        public System.DateTime fechavencimiento;
        public int CTG;
        public string CupoTurno;
        public System.DateTime HoraArribo;
        public int brutoproc;
        public int taraproc;
        public decimal Humedad;
        public int MermaHumedad;
        public int OtrasMermas;
        public int NetoFinal;
        public string ClienteObserv;
        public string CorredorObs;
        public string cuitchofer;
        public string Chofer;
        public string cuittransportista;
        public string transportista;
        public string acoplado;
        public int kmarecorrer;
        public decimal tarifa;
        public string Establecimiento;
        public int IdPosicionEstado;
        public string PosicionEstado;



        public string SojaSustentableCodCondicion;
        public string SojaSustentableCondicion;
        public string SojaSustentableNroEstablecimientoDeProduccion;


    }




    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.6.1067.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    //[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://wsPosicion/")]
    public partial class cartaPorte_v2_00 //: object, System.ComponentModel.INotifyPropertyChanged
    {

        public int brutodest;
        //public bool brutodestSpecified;
        public string CPoriginal;
        public string calidad;
        public long cartaporte;
        public int codmerca;
        //public bool codmercaSpecified;
        public int codonccalocalidadpuerto;
        //public bool codonccalocalidadpuertoSpecified;
        public int codonccalocalproc;
        //public bool codonccalocalprocSpecified;
        public int codonccaprovincialproc;
        //public bool codonccaprovincialprocSpecified;
        public int codonccaprovinciapuerto;
        //public bool codonccaprovinciapuertoSpecified;
        public int codonccapuerto;
        //public bool codonccapuertoSpecified;
        public string codpostalprocedencia;
        public string contrato;
        public string cosecha;
        public string cuitcorredor;
        public string cuitentregador;
        public string cuitexport;
        public string cuitinter;
        public string cuitpuerto;
        public string cuitremic;
        public string cuitremitente;
        public string cuittitu;
        public string entregador;
        public System.DateTime fechadescarga;
        //public bool fechadescargaSpecified;
        public System.DateTime fechaposicion;
        //public bool fechaposicionSpecified;
        public string horadescarga;
        public string intermediario;
        public analisis[] listaAnalisis;
        public string localidaddestino;
        public string mercaderia;
        public int netodest;
        //public bool netodestSpecified;
        public int netoproc;
        //public bool netoprocSpecified;
        public string nomExport;
        public string nomRemic;
        public string nomcorre;
        public string nroRecibo;
        public string observaciones;
        public string observado;
        public string patente;
        public string procedencia;
        public string puerto;
        public string remitente;
        public int taradest;
        //public bool taradestSpecified;
        public string titular;
        public string usuario;
        public int vagon;


        // version 2
        public long CEE;
        public System.DateTime fechaEmisionCarga;
        public System.DateTime fechavencimiento;
        public int CTG;
        public string CupoTurno;
        public System.DateTime HoraArribo;
        public int brutoproc;
        public int taraproc;
        public int Humedad;
        public int MermaHumedad;
        public int OtrasMermas;
        public int NetoFinal;
        public string ClienteObserv;
        public string CorredorObs;
        public string cuitchofer;
        public string Chofer;
        public string cuittransportista;
        public string transportista;
        public string acoplado;
        public int kmarecorrer;
        public decimal tarifa;
        public string Establecimiento;
        public int IdPosicionEstado;
        public string PosicionEstado;






        //public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;

        //protected void RaisePropertyChanged(string propertyName)
        //{
        //    System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
        //    if ((propertyChanged != null))
        //    {
        //        propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
        //    }
        //}





        /*
        private int brutodestField;

        private bool brutodestFieldSpecified;

        private string cPoriginalField;

        private string calidadField;

        private int cartaporteField;

        private int codmercaField;

        private bool codmercaFieldSpecified;

        private int codonccalocalidadpuertoField;

        private bool codonccalocalidadpuertoFieldSpecified;

        private int codonccalocalprocField;

        private bool codonccalocalprocFieldSpecified;

        private int codonccaprovincialprocField;

        private bool codonccaprovincialprocFieldSpecified;

        private int codonccaprovinciapuertoField;

        private bool codonccaprovinciapuertoFieldSpecified;

        private int codonccapuertoField;

        private bool codonccapuertoFieldSpecified;

        private string codpostalprocedenciaField;

        private string contratoField;

        private string cosechaField;

        private string cuitcorredorField;

        private string cuitentregadorField;

        private string cuitexportField;

        private string cuitinterField;

        private string cuitpuertoField;

        private string cuitremicField;

        private string cuitremitenteField;

        private string cuittituField;

        private string entregadorField;

        private System.DateTime fechadescargaField;

        private bool fechadescargaFieldSpecified;

        private System.DateTime fechaposicionField;

        private bool fechaposicionFieldSpecified;

        private string horadescargaField;

        private string intermediarioField;

        private analisis[] listaAnalisisField;

        private string localidaddestinoField;

        private string mercaderiaField;

        private int netodestField;

        private bool netodestFieldSpecified;

        private int netoprocField;

        private bool netoprocFieldSpecified;

        private string nomExportField;

        private string nomRemicField;

        private string nomcorreField;

        private string nroReciboField;

        private string observacionesField;

        private string observadoField;

        private string patenteField;

        private string procedenciaField;

        private string puertoField;

        private string remitenteField;

        private int taradestField;

        private bool taradestFieldSpecified;

        private string titularField;

        private string usuarioField;

        private int vagonField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 0)]
        public int brutodest
        {
            get
            {
                return this.brutodestField;
            }
            set
            {
                this.brutodestField = value;
                this.RaisePropertyChanged("brutodest");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool brutodestSpecified
        {
            get
            {
                return this.brutodestFieldSpecified;
            }
            set
            {
                this.brutodestFieldSpecified = value;
                this.RaisePropertyChanged("brutodestSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 1)]
        public string CPoriginal
        {
            get
            {
                return this.cPoriginalField;
            }
            set
            {
                this.cPoriginalField = value;
                this.RaisePropertyChanged("CPoriginal");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 2)]
        public string calidad
        {
            get
            {
                return this.calidadField;
            }
            set
            {
                this.calidadField = value;
                this.RaisePropertyChanged("calidad");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 3)]
        public int cartaporte
        {
            get
            {
                return this.cartaporteField;
            }
            set
            {
                this.cartaporteField = value;
                this.RaisePropertyChanged("cartaporte");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 4)]
        public int codmerca
        {
            get
            {
                return this.codmercaField;
            }
            set
            {
                this.codmercaField = value;
                this.RaisePropertyChanged("codmerca");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool codmercaSpecified
        {
            get
            {
                return this.codmercaFieldSpecified;
            }
            set
            {
                this.codmercaFieldSpecified = value;
                this.RaisePropertyChanged("codmercaSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 5)]
        public int codonccalocalidadpuerto
        {
            get
            {
                return this.codonccalocalidadpuertoField;
            }
            set
            {
                this.codonccalocalidadpuertoField = value;
                this.RaisePropertyChanged("codonccalocalidadpuerto");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool codonccalocalidadpuertoSpecified
        {
            get
            {
                return this.codonccalocalidadpuertoFieldSpecified;
            }
            set
            {
                this.codonccalocalidadpuertoFieldSpecified = value;
                this.RaisePropertyChanged("codonccalocalidadpuertoSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 6)]
        public int codonccalocalproc
        {
            get
            {
                return this.codonccalocalprocField;
            }
            set
            {
                this.codonccalocalprocField = value;
                this.RaisePropertyChanged("codonccalocalproc");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool codonccalocalprocSpecified
        {
            get
            {
                return this.codonccalocalprocFieldSpecified;
            }
            set
            {
                this.codonccalocalprocFieldSpecified = value;
                this.RaisePropertyChanged("codonccalocalprocSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 7)]
        public int codonccaprovincialproc
        {
            get
            {
                return this.codonccaprovincialprocField;
            }
            set
            {
                this.codonccaprovincialprocField = value;
                this.RaisePropertyChanged("codonccaprovincialproc");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool codonccaprovincialprocSpecified
        {
            get
            {
                return this.codonccaprovincialprocFieldSpecified;
            }
            set
            {
                this.codonccaprovincialprocFieldSpecified = value;
                this.RaisePropertyChanged("codonccaprovincialprocSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 8)]
        public int codonccaprovinciapuerto
        {
            get
            {
                return this.codonccaprovinciapuertoField;
            }
            set
            {
                this.codonccaprovinciapuertoField = value;
                this.RaisePropertyChanged("codonccaprovinciapuerto");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool codonccaprovinciapuertoSpecified
        {
            get
            {
                return this.codonccaprovinciapuertoFieldSpecified;
            }
            set
            {
                this.codonccaprovinciapuertoFieldSpecified = value;
                this.RaisePropertyChanged("codonccaprovinciapuertoSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 9)]
        public int codonccapuerto
        {
            get
            {
                return this.codonccapuertoField;
            }
            set
            {
                this.codonccapuertoField = value;
                this.RaisePropertyChanged("codonccapuerto");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool codonccapuertoSpecified
        {
            get
            {
                return this.codonccapuertoFieldSpecified;
            }
            set
            {
                this.codonccapuertoFieldSpecified = value;
                this.RaisePropertyChanged("codonccapuertoSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 10)]
        public string codpostalprocedencia
        {
            get
            {
                return this.codpostalprocedenciaField;
            }
            set
            {
                this.codpostalprocedenciaField = value;
                this.RaisePropertyChanged("codpostalprocedencia");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 11)]
        public string contrato
        {
            get
            {
                return this.contratoField;
            }
            set
            {
                this.contratoField = value;
                this.RaisePropertyChanged("contrato");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 12)]
        public string cosecha
        {
            get
            {
                return this.cosechaField;
            }
            set
            {
                this.cosechaField = value;
                this.RaisePropertyChanged("cosecha");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 13)]
        public string cuitcorredor
        {
            get
            {
                return this.cuitcorredorField;
            }
            set
            {
                this.cuitcorredorField = value;
                this.RaisePropertyChanged("cuitcorredor");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 14)]
        public string cuitentregador
        {
            get
            {
                return this.cuitentregadorField;
            }
            set
            {
                this.cuitentregadorField = value;
                this.RaisePropertyChanged("cuitentregador");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 15)]
        public string cuitexport
        {
            get
            {
                return this.cuitexportField;
            }
            set
            {
                this.cuitexportField = value;
                this.RaisePropertyChanged("cuitexport");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 16)]
        public string cuitinter
        {
            get
            {
                return this.cuitinterField;
            }
            set
            {
                this.cuitinterField = value;
                this.RaisePropertyChanged("cuitinter");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 17)]
        public string cuitpuerto
        {
            get
            {
                return this.cuitpuertoField;
            }
            set
            {
                this.cuitpuertoField = value;
                this.RaisePropertyChanged("cuitpuerto");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 18)]
        public string cuitremic
        {
            get
            {
                return this.cuitremicField;
            }
            set
            {
                this.cuitremicField = value;
                this.RaisePropertyChanged("cuitremic");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 19)]
        public string cuitremitente
        {
            get
            {
                return this.cuitremitenteField;
            }
            set
            {
                this.cuitremitenteField = value;
                this.RaisePropertyChanged("cuitremitente");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 20)]
        public string cuittitu
        {
            get
            {
                return this.cuittituField;
            }
            set
            {
                this.cuittituField = value;
                this.RaisePropertyChanged("cuittitu");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 21)]
        public string entregador
        {
            get
            {
                return this.entregadorField;
            }
            set
            {
                this.entregadorField = value;
                this.RaisePropertyChanged("entregador");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 22)]
        public System.DateTime fechadescarga
        {
            get
            {
                return this.fechadescargaField;
            }
            set
            {
                this.fechadescargaField = value;
                this.RaisePropertyChanged("fechadescarga");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool fechadescargaSpecified
        {
            get
            {
                return this.fechadescargaFieldSpecified;
            }
            set
            {
                this.fechadescargaFieldSpecified = value;
                this.RaisePropertyChanged("fechadescargaSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 23)]
        public System.DateTime fechaposicion
        {
            get
            {
                return this.fechaposicionField;
            }
            set
            {
                this.fechaposicionField = value;
                this.RaisePropertyChanged("fechaposicion");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool fechaposicionSpecified
        {
            get
            {
                return this.fechaposicionFieldSpecified;
            }
            set
            {
                this.fechaposicionFieldSpecified = value;
                this.RaisePropertyChanged("fechaposicionSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 24)]
        public string horadescarga
        {
            get
            {
                return this.horadescargaField;
            }
            set
            {
                this.horadescargaField = value;
                this.RaisePropertyChanged("horadescarga");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 25)]
        public string intermediario
        {
            get
            {
                return this.intermediarioField;
            }
            set
            {
                this.intermediarioField = value;
                this.RaisePropertyChanged("intermediario");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("listaAnalisis", Form = System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable = true, Order = 26)]
        public analisis[] listaAnalisis
        {
            get
            {
                return this.listaAnalisisField;
            }
            set
            {
                this.listaAnalisisField = value;
                this.RaisePropertyChanged("listaAnalisis");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 27)]
        public string localidaddestino
        {
            get
            {
                return this.localidaddestinoField;
            }
            set
            {
                this.localidaddestinoField = value;
                this.RaisePropertyChanged("localidaddestino");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 28)]
        public string mercaderia
        {
            get
            {
                return this.mercaderiaField;
            }
            set
            {
                this.mercaderiaField = value;
                this.RaisePropertyChanged("mercaderia");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 29)]
        public int netodest
        {
            get
            {
                return this.netodestField;
            }
            set
            {
                this.netodestField = value;
                this.RaisePropertyChanged("netodest");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool netodestSpecified
        {
            get
            {
                return this.netodestFieldSpecified;
            }
            set
            {
                this.netodestFieldSpecified = value;
                this.RaisePropertyChanged("netodestSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 30)]
        public int netoproc
        {
            get
            {
                return this.netoprocField;
            }
            set
            {
                this.netoprocField = value;
                this.RaisePropertyChanged("netoproc");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool netoprocSpecified
        {
            get
            {
                return this.netoprocFieldSpecified;
            }
            set
            {
                this.netoprocFieldSpecified = value;
                this.RaisePropertyChanged("netoprocSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 31)]
        public string nomExport
        {
            get
            {
                return this.nomExportField;
            }
            set
            {
                this.nomExportField = value;
                this.RaisePropertyChanged("nomExport");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 32)]
        public string nomRemic
        {
            get
            {
                return this.nomRemicField;
            }
            set
            {
                this.nomRemicField = value;
                this.RaisePropertyChanged("nomRemic");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 33)]
        public string nomcorre
        {
            get
            {
                return this.nomcorreField;
            }
            set
            {
                this.nomcorreField = value;
                this.RaisePropertyChanged("nomcorre");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 34)]
        public string nroRecibo
        {
            get
            {
                return this.nroReciboField;
            }
            set
            {
                this.nroReciboField = value;
                this.RaisePropertyChanged("nroRecibo");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 35)]
        public string observaciones
        {
            get
            {
                return this.observacionesField;
            }
            set
            {
                this.observacionesField = value;
                this.RaisePropertyChanged("observaciones");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 36)]
        public string observado
        {
            get
            {
                return this.observadoField;
            }
            set
            {
                this.observadoField = value;
                this.RaisePropertyChanged("observado");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 37)]
        public string patente
        {
            get
            {
                return this.patenteField;
            }
            set
            {
                this.patenteField = value;
                this.RaisePropertyChanged("patente");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 38)]
        public string procedencia
        {
            get
            {
                return this.procedenciaField;
            }
            set
            {
                this.procedenciaField = value;
                this.RaisePropertyChanged("procedencia");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 39)]
        public string puerto
        {
            get
            {
                return this.puertoField;
            }
            set
            {
                this.puertoField = value;
                this.RaisePropertyChanged("puerto");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 40)]
        public string remitente
        {
            get
            {
                return this.remitenteField;
            }
            set
            {
                this.remitenteField = value;
                this.RaisePropertyChanged("remitente");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 41)]
        public int taradest
        {
            get
            {
                return this.taradestField;
            }
            set
            {
                this.taradestField = value;
                this.RaisePropertyChanged("taradest");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool taradestSpecified
        {
            get
            {
                return this.taradestFieldSpecified;
            }
            set
            {
                this.taradestFieldSpecified = value;
                this.RaisePropertyChanged("taradestSpecified");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 42)]
        public string titular
        {
            get
            {
                return this.titularField;
            }
            set
            {
                this.titularField = value;
                this.RaisePropertyChanged("titular");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 43)]
        public string usuario
        {
            get
            {
                return this.usuarioField;
            }
            set
            {
                this.usuarioField = value;
                this.RaisePropertyChanged("usuario");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 44)]
        public int vagon
        {
            get
            {
                return this.vagonField;
            }
            set
            {
                this.vagonField = value;
                this.RaisePropertyChanged("vagon");
            }
        }

        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;

        protected void RaisePropertyChanged(string propertyName)
        {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null))
            {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
         * 
         * */
    }










    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.6.1067.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    //[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://wsPosicion/")]
    public partial class respuestaEntrega : object, System.ComponentModel.INotifyPropertyChanged
    {

        private string codigoResultadoField;

        private cartaPorte[] descargasField;

        private string descripcionField;


        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 0)]
        public string codigoResultado
        {
            get
            {
                return this.codigoResultadoField;
            }
            set
            {
                this.codigoResultadoField = value;
                this.RaisePropertyChanged("codigoResultado");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("descargas", Form = System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable = true, Order = 1)]
        public cartaPorte[] descargas
        {
            get
            {
                return this.descargasField;
            }
            set
            {
                this.descargasField = value;
                this.RaisePropertyChanged("descargas");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 2)]
        public string descripcion
        {
            get
            {
                return this.descripcionField;
            }
            set
            {
                this.descripcionField = value;
                this.RaisePropertyChanged("descripcion");
            }
        }

        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;

        protected void RaisePropertyChanged(string propertyName)
        {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null))
            {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }









    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.6.1067.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    //[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://wsPosicion/")]
    public partial class respuestaEntrega_v2_00 : object, System.ComponentModel.INotifyPropertyChanged
    {

        private string codigoResultadoField;

        private cartaPorte_v2_00[] descargasField;

        private string descripcionField;


        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 0)]
        public string codigoResultado
        {
            get
            {
                return this.codigoResultadoField;
            }
            set
            {
                this.codigoResultadoField = value;
                this.RaisePropertyChanged("codigoResultado");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("descargas", Form = System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable = true, Order = 1)]
        public cartaPorte_v2_00[] descargas
        {
            get
            {
                return this.descargasField;
            }
            set
            {
                this.descargasField = value;
                this.RaisePropertyChanged("descargas");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 2)]
        public string descripcion
        {
            get
            {
                return this.descripcionField;
            }
            set
            {
                this.descripcionField = value;
                this.RaisePropertyChanged("descripcion");
            }
        }

        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;

        protected void RaisePropertyChanged(string propertyName)
        {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null))
            {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }







    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.6.1067.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    //[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://wsPosicion/")]
    public partial class respuestaEntrega_v3 : object, System.ComponentModel.INotifyPropertyChanged
    {

        private string codigoResultadoField;

        private cartaPorte_v3[] descargasField;

        private string descripcionField;


        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 0)]
        public string codigoResultado
        {
            get
            {
                return this.codigoResultadoField;
            }
            set
            {
                this.codigoResultadoField = value;
                this.RaisePropertyChanged("codigoResultado");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("descargas", Form = System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable = true, Order = 1)]
        public cartaPorte_v3[] descargas
        {
            get
            {
                return this.descargasField;
            }
            set
            {
                this.descargasField = value;
                this.RaisePropertyChanged("descargas");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 2)]
        public string descripcion
        {
            get
            {
                return this.descripcionField;
            }
            set
            {
                this.descripcionField = value;
                this.RaisePropertyChanged("descripcion");
            }
        }

        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;

        protected void RaisePropertyChanged(string propertyName)
        {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null))
            {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }









    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.6.1067.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    //[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://wsPosicion/")]
    public partial class respuestaEntrega_v4 : object, System.ComponentModel.INotifyPropertyChanged
    {

        private string codigoResultadoField;

        private cartaPorte_v4[] descargasField;

        private string descripcionField;


        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 0)]
        public string codigoResultado
        {
            get
            {
                return this.codigoResultadoField;
            }
            set
            {
                this.codigoResultadoField = value;
                this.RaisePropertyChanged("codigoResultado");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("descargas", Form = System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable = true, Order = 1)]
        public cartaPorte_v4[] descargas
        {
            get
            {
                return this.descargasField;
            }
            set
            {
                this.descargasField = value;
                this.RaisePropertyChanged("descargas");
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, Order = 2)]
        public string descripcion
        {
            get
            {
                return this.descripcionField;
            }
            set
            {
                this.descripcionField = value;
                this.RaisePropertyChanged("descripcion");
            }
        }

        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;

        protected void RaisePropertyChanged(string propertyName)
        {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null))
            {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
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





        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // la conversion de null a string
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // http://stackoverflow.com/questions/550374/checking-for-null-before-tostring?lq=1
        // http://stackoverflow.com/questions/5700015/test-for-null-return-a-string-if-needed-what-are-the-pros-cons?lq=1
        // http://stackoverflow.com/questions/3987618/how-to-do-tostring-for-a-possibly-null-object?lq=1

        public static string NullSafeToString(this object obj)
        {
            return obj != null ? obj.ToString() : String.Empty;
        }





        /// <summary>
        /// Put a string between double quotes.
        /// </summary>
        /// <param name="value">Value to be put between double quotes ex: foo</param>
        /// <returns>double quoted string ex: "foo"</returns>
        public static string AddDoubleQuotes(this string value)
        {
            return "\"" + value + "\"";
        }


        
    }
}