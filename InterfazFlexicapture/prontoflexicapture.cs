using System;
using System.Collections;
using System.IO;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Drawing;
using System.Drawing.Imaging;

using System.ServiceProcess;

using FCEngine;

using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


using ProntoMVC.Data.Models;
using ProntoMVC.Data;

using ExtensionMethods;

using Pronto.ERP.Bll;

using Microsoft.VisualBasic;

using Excel = Microsoft.Office.Interop.Excel;

using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;


using System.Drawing;

using BitMiracle.LibTiff.Classic;

using System.Configuration;

using System.Text;
using System.Reflection;

using System.Data.Objects;


namespace Fenton.Example
{
    public static class IQueryableExtensions
    {

        public static string ToTraceQuery_SinUsarExtension<T>(IQueryable<T> query)
        {
            System.Data.Entity.Core.Objects.ObjectQuery<T> objectQuery = GetQueryFromQueryable(query);

            var result = objectQuery.ToTraceString();
            foreach (var parameter in objectQuery.Parameters)
            {
                var name = "@" + parameter.Name;
                var value = "'" + parameter.Value.ToString() + "'";
                result = result.Replace(name, value);
            }

            return result;
        }


        /// <summary>
        /// For an Entity Framework IQueryable, returns the SQL with inlined Parameters.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="query"></param>
        /// <returns></returns>
        public static string ToTraceQuery<T>(this IQueryable<T> query)
        {
            System.Data.Entity.Core.Objects.ObjectQuery<T> objectQuery = GetQueryFromQueryable(query);

            var result = objectQuery.ToTraceString();
            foreach (var parameter in objectQuery.Parameters)
            {
                var name = "@" + parameter.Name;
                var value = "'" + parameter.Value.ToString() + "'";
                result = result.Replace(name, value);
            }

            return result;
        }

        /// <summary>
        /// For an Entity Framework IQueryable, returns the SQL and Parameters.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="query"></param>
        /// <returns></returns>
        public static string ToTraceString<T>(this IQueryable<T> query)
        {
            System.Data.Entity.Core.Objects.ObjectQuery<T> objectQuery = GetQueryFromQueryable(query);

            var traceString = new StringBuilder();

            traceString.AppendLine(objectQuery.ToTraceString());
            traceString.AppendLine();

            foreach (var parameter in objectQuery.Parameters)
            {
                traceString.AppendLine(parameter.Name + " [" + parameter.ParameterType.FullName + "] = " + parameter.Value);
            }

            return traceString.ToString();
        }

        private static System.Data.Entity.Core.Objects.ObjectQuery<T> GetQueryFromQueryable<T>(IQueryable<T> query)
        {
            var internalQueryField = query.GetType().GetFields(System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance).Where(f => f.Name.Equals("_internalQuery")).FirstOrDefault();
            var internalQuery = internalQueryField.GetValue(query);
            var objectQueryField = internalQuery.GetType().GetFields(System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance).Where(f => f.Name.Equals("_objectQuery")).FirstOrDefault();
            return objectQueryField.GetValue(internalQuery) as System.Data.Entity.Core.Objects.ObjectQuery<T>;
        }
    }
}



public class LinqProvider<T>
{
    static readonly FieldInfo INTERNAL_QUERY_FIELD;
    static readonly FieldInfo QUERYSTATE_FIELD;

    static LinqProvider()
    {
        INTERNAL_QUERY_FIELD = typeof(System.Data.Entity.Infrastructure.DbQuery<T>).GetFields(BindingFlags.NonPublic | BindingFlags.Instance).FirstOrDefault(f => f.Name.Equals("_internalQuery"));
        QUERYSTATE_FIELD = typeof(System.Data.Entity.Core.Objects.ObjectQuery<>).BaseType.GetFields(BindingFlags.NonPublic | BindingFlags.Instance).FirstOrDefault(x => x.Name == "_state");
    }

    public IQueryable<T> QueryContext { get; set; }

    InternalQuery _InternalQueryContext;
    public InternalQuery InternalQueryContext
    {
        get
        {
            if (_InternalQueryContext == null)
            {
                _InternalQueryContext = new InternalQuery();

                if (QueryContext is System.Data.Entity.Infrastructure.DbQuery<T>)
                {
                    var internalQuery = INTERNAL_QUERY_FIELD.GetValue(QueryContext);

                    var objectQueryField = internalQuery.GetType().GetProperties().FirstOrDefault(f => f.Name.Equals("ObjectQuery"));

                    _InternalQueryContext.ObjectQueryContext = objectQueryField.GetValue(internalQuery, null) as System.Data.Entity.Core.Objects.ObjectQuery<T>;
                }
                else if (QueryContext is System.Data.Entity.Core.Objects.ObjectQuery<T>)
                {
                    _InternalQueryContext.ObjectQueryContext = (QueryContext as System.Data.Entity.Core.Objects.ObjectQuery<T>);
                }
            }

            return _InternalQueryContext;
        }
    }

    public LinqProvider(IQueryable<T> queryContext)
    {
        QueryContext = queryContext;
    }

    public class InternalQuery
    {
        public System.Data.Entity.Core.Objects.ObjectQuery<T> ObjectQueryContext { get; set; }

        public string ToTraceString(IDictionary<string, object> Parameters = null)
        {
            var state = QUERYSTATE_FIELD.GetValue(ObjectQueryContext);

            var mi = state.GetType().GetMethods(BindingFlags.NonPublic | BindingFlags.Instance).FirstOrDefault(x => x.Name == "GetExecutionPlan");

            mi.Invoke(state, new object[] { null });

            var paramState = state.GetType().BaseType.GetFields(BindingFlags.NonPublic | BindingFlags.Instance).FirstOrDefault(x => x.Name == "_parameters");

            if (paramState != null)
            {
                System.Data.Entity.Core.Objects.ObjectParameterCollection col = paramState.GetValue(state) as System.Data.Entity.Core.Objects.ObjectParameterCollection;

                if (col != null && Parameters != null)
                {
                    foreach (var item in col)
                    {
                        Parameters.Add(item.Name, item.Value);
                    }
                }
            }

            return ObjectQueryContext.ToTraceString();
        }
    }
}





namespace ProntoFlexicapture
{
    public class ClassFlexicapture  // :  Sample.FlexiCaptureEngineSnippets
    {
        /*
        
        public static void ProcesarUnaCartaConFlexicapture(IEngine engine, string plantilla, string imagen, string SC, string DirApp)
        {


            //trace("Create an instance of FlexiCapture processor...");
            IFlexiCaptureProcessor processor = engine.CreateFlexiCaptureProcessor();

            IDocumentDefinition newDocumentDefinition = engine.CreateDocumentDefinitionFromAFL(plantilla, "Spanish");

            processor.AddDocumentDefinition(newDocumentDefinition);



            SampleImageSource imageSource = new SampleImageSource();

            imageSource.AddImageFileByRef(imagen);

            // Configure the processor to use the new image source
            processor.SetCustomImageSource(imageSource);

            //traceBegin("Run processing loop...");
            //trace("Recognize next document...");

            IDocument document = processor.RecognizeNextDocument();


            if (false)
            {
                //    processor.ExportDocumentEx(document, SamplesFolder + "\\FCEExport", "NextDocument_" + count, null);
            }

            else
            {

                try
                {
                    ProcesaCarta(document, SC, imagen, DirApp);
                    processor.ExportDocumentEx(document, Path.GetDirectoryName(imagen), imagen + ".xml", null);
                }
                catch (Exception x)
                {
                    Debug.Print(x.ToString());
                    // throw;
                }



            }


        }


        */



        public static List<FuncionesGenericasCSharp.Resultados> ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(
                                        ref IEngine engine, ref IFlexiCaptureProcessor processor, string plantilla,
                                        int cuantasImagenes, string SC, string DirApp, bool bProcesar, ref string sError)
        {


            var Lista = ExtraerListaDeImagenesQueNoHanSidoProcesadas(cuantasImagenes, DirApp);


            //guardar en Log los resultados


            //Try
            //    EntidadManager.Tarea(SC, "Log_InsertarRegistro", IIf(myCartaDePorte.Id <= 0, "ALTA", "MODIF"), _
            //                              CartaDePorteId, 0, Now, 0, "Tabla : CartaPorte", "", NombreUsuario, _
            //                            DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, _
            //                            DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, _
            //                            DBNull.Value, DBNull.Value, DBNull.Value)
            //    'GetStoreProcedure(SC, enumSPs.Log_InsertarRegistro, IIf(myCartaDePorte.Id <= 0, "ALTA", "MODIF"), _
            //    '                          CartaDePorteId, 0, Now, 0, "Tabla : CartaPorte", "", NombreUsuario)

            //Catch ex As Exception
            //    ErrHandler2.WriteError(ex)
            //End Try

            //Console.WriteLine("Imagenes encoladas " + Lista.Count);

            return ProcesarCartasBatchConFlexicapture(ref engine, ref processor, plantilla, Lista, SC, DirApp, bProcesar, ref sError);
            //si no esta la licencia, recibe la excepcion 

        }




        // USE CASE: Using a custom image source with FlexiCapture processor
        public static List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> ProcesarCartasBatchConFlexicapture(ref IEngine engine,
                                                    ref IFlexiCaptureProcessor processor,
                                                    string plantilla,
                                                   List<string> imagenes, string SC, string DirApp, bool bProcesar, ref string sError)
        {

            if (imagenes == null) return null;
            if (imagenes.Count <= 0) return null;

            //engine.CurrentLicense
            if (!bEstaLaLicenciadelFlexicapture()) // no está la licencia del Flexicapture
            {

                var listasinpath = new List<string>();
                foreach (string i in imagenes)
                {
                    listasinpath.Add(Path.GetFileName(i));
                }
                return CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, listasinpath, -1, ref sError, DirApp);

            }




            // string SamplesFolder = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos";


            List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> r = new List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados>();



            bool conTK = imagenes[0].Contains("_unido");


            //processor.AddDocumentDefinitionFile(SamplesFolder + "\\cartaporte.fcdot");

            //trace("Set up a custom image source...");
            // Create and configure sample image source (see SampleImageSource class for details)
            SampleImageSource imageSource = new SampleImageSource();
            // The sample image source will use these files by reference:
            foreach (string s in imagenes)
            {
                imageSource.AddImageFileByRef(s);
                MarcarArchivoComoProcesandose(s);
            }
            //imageSource.AddImageFileByRef(SamplesFolder + "\\SampleImages\\ZXING BIEN 545459461 (300dpi).jpg");
            //imageSource.AddImageFileByRef(SamplesFolder + "\\SampleImages\\Invoices_2.tif");
            //imageSource.AddImageFileByRef(SamplesFolder + "\\SampleImages\\Invoices_3.tif");
            //// ... these files by value (files in memory):
            //imageSource.AddImageFileByValue(SamplesFolder + "\\SampleImages\\Invoices_1.tif");
            //imageSource.AddImageFileByValue(SamplesFolder + "\\SampleImages\\Invoices_2.tif");
            //imageSource.AddImageFileByValue(SamplesFolder + "\\SampleImages\\Invoices_3.tif");
            // Configure the processor to use the new image source
            try
            {
                // processor.ResetProcessing();
                processor.SetCustomImageSource(imageSource);
            }
            catch (Exception xxx)
            {




                //System.Runtime.InteropServices.COMException (0x8000FFFF): Error interno del programa:
                //FCESupport\FCESupportImpl.h, 42.
                //   at FCEngine.IFlexiCaptureProcessor.SetCustomImageSource(IImageSource ImageSource)
                //   at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, List`1 imagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 206
                //   at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, Int32 cuantasImagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 129
                //   at ProntoWindowsService.Service1.Tanda(String SC, String DirApp) in c:\Users\Administrador\Documents\bdl\pronto\ProntoWindowsService\Service1.cs:line 322

                Log(xxx.ToString());

                //tirar la Lista de imagenes sospechosas
                foreach (string s in imagenes)
                {
                    DesmarcarArchivoComoProcesandose(s);
                }

                CartaDePorteManager.MandarMailDeError(xxx);
                throw;
            }


            //traceBegin("Run processing loop...");
            int count = 0;
            while (true)
            {

                FuncionesGenericasCSharp.Resultados output = null;

                if (count > imagenes.Count - 1) break;


                Pronto.ERP.Bll.ErrHandler2.WriteError("reconocer imagen");
                Console.WriteLine("reconocer imagen " + imagenes[count]);



                //ojo , porque incrementas el count de archivosimagenes, pero un archivo puede tener 2 paginas con cp+tk
                // ademas, el GrabarImagen (en el importador2) solo esta recibiendo el tiff de pagina simple exportado por el flexicapture.
                // el primer tema lo resolvería haciendo un +2 en lugar de ++
                // y el segundo tema... ¿no puedo pasar como parametro el nombre original del archivo?




                IDocument document;

                //trace("Recognize next document...");
                try
                {

                    if (conTK && count > 0) processor.RecognizeNextDocument(); // saltar la pagina con el tiket, y así pasar al siguiente archivo

                    document = processor.RecognizeNextDocument(); // si no esta la licencia, acá explota



                }

                catch (Exception xx)
                {
                    // si no esta la licencia, acá explota


                    // puede ser por falta de memoria tambien
                    //                 System.OutOfMemoryException: Insufficient memory to continue the execution of the program.
                    //at FCEngine.IFlexiCaptureProcessor.RecognizeNextDocument()
                    //at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, List`1 imagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 252
                    //at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, Int32 cuantasImagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 129
                    //at ProntoWindowsService.Service1.Tanda(String SC, String DirApp) in c:\Users\Administrador\Documents\bdl\pronto\ProntoWindowsService\Service1.cs:line 359
                    //at ProntoWindowsService.Service1.DoWork() in c:\Users\Administrador\Documents\bdl\pronto\ProntoWindowsService\Service1.cs:line 211

                    Log(xx.ToString());

                    foreach (string s in imagenes)
                    {
                        DesmarcarArchivoComoProcesandose(s);
                    }

                    CartaDePorteManager.MandarMailDeError(xx);

                    throw;
                }



                if (document == null)
                {
                    IProcessingError error = processor.GetLastProcessingError();
                    if (error != null)
                    {
                        //processError(error, processor, ErrorHandlingStrategy.LogAndContinue);
                        continue;
                    }
                    else
                    {
                        //trace("No more images");
                        break;
                    }
                }
                else if (document.DocumentDefinition == null)
                {
                    //processNotMatched(document);
                }
                //trace("Export recognized document...");



                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                // exportacion
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                string dirtemp = DirApp + @"\Temp\";

                Random rnd = new Random();

                IFileExportParams exportParams = engine.CreateFileExportParams();
                exportParams.FileFormat = FileExportFormatEnum.FEF_XLS;
                exportParams.ExportOriginalImages = true;
                exportParams.ImageExportParams.Prefix = "ExportToXLS_" + rnd.Next(100000, 999999).ToString(); // en realidad las imagenes exportadas deberían ir a parar todas al raiz, porque no hay manera de saber a qué imagen corresponden. Entonces las dejo todas en el mismo lugar, y genero un random al prefijo para asegurarme de que ese nombre es exclusivo
                //IExcelExportParams excelParametros;
                //exportParams.ExcelParams = excelParametros;


                var w = imagenes[count].IndexOf(@"\Temp\");
                var sd = imagenes[count].Substring(w + 6).IndexOf(@"\");
                var dirExport = imagenes[count].Substring(0, sd + w + 6) + @"\";


                processor.ExportDocumentEx(document, dirExport, "ExportToXLS", exportParams);




                if (false)
                {
                    processor.ExportDocumentEx(document, Path.GetDirectoryName(imagenes[count]), imagenes[count] + ".xml", null);

                    exportParams.FileFormat = FileExportFormatEnum.FEF_CSV;
                    // processor.ExportDocumentEx(document, Path.GetPathRoot(imagenes[count])   dir + "\\FCEExport", "ExportToCSV", exportParams);
                }



                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////


                if (bProcesar)
                {
                    try
                    {
                        output = ProcesaCarta(document, SC, dirExport + exportParams.ImageExportParams.Prefix + ".tif", DirApp);
                        r.Add(output);

                        // en este momento yo se que en el excel está escrito en la ultima posicion la info de este documento
                        //explota aca con la carta invalida
                        ManotearExcel(dirExport + @"ExportToXLS.xls", "numero " + output.numerocarta + "  archivo: " + exportParams.ImageExportParams.Prefix + ".tif" + " id" + output.IdCarta, "#" + output.numerocarta.ToString());



                        if (conTK)
                        {
                            string archivoOriginal = imagenes[count];

                            string nombrenuevo = rnd.Next(1, 99999).ToString().Replace(".", "") + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + "_" + Path.GetFileName(archivoOriginal);

                            nombrenuevo = CartaDePorteManager.CreaDirectorioParaImagenCartaPorte(nombrenuevo, DirApp);


                            string DIRFTP = DirApp + @"\DataBackupear\";
                            string destino = DIRFTP + nombrenuevo;


                            try
                            {
                                FileInfo MyFile1 = new FileInfo(destino);
                                if (MyFile1.Exists) MyFile1.Delete();

                                File.Copy(archivoOriginal, destino);
                            }
                            catch (Exception x)
                            {
                                Log(x.ToString());
                                ErrHandler2.WriteError(x);
                            }


                            //el nombre de la imagen lo logeo en algun lado????
                            var cc = CartaDePorteManager.GrabarImagen(output.IdCarta, SC, 0, 0, nombrenuevo, ref sError, DirApp, true);
                        }


                    }
                    catch (Exception x)
                    {
                        Log(x.ToString());
                        Debug.Print(x.ToString());
                        ErrHandler2.WriteError(x);
                        // throw;
                    }


                }




                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////




                count++;


            }
            //traceEnd("OK");

            //trace("Check the results...");
            //assert(count == 4);bul


            //esta bien esto?
            processor.ResetProcessing();

            return r;
        }


        static void ManotearExcel(string nombreexcel, string dato, string numerocarta)
        {


            //OpenXMLWindowsApp.UpdateCell(nombreexcel, dato, 2, "BB");
            //return;



            Excel.Application excel = new Excel.Application();
            Microsoft.Office.Interop.Excel.Workbook workBook = excel.Workbooks.Open(nombreexcel);
            Microsoft.Office.Interop.Excel.Worksheet sheet = workBook.ActiveSheet;
            Microsoft.Office.Interop.Excel.Range range = sheet.UsedRange;

            excel.Visible = false;
            excel.DisplayAlerts = false;


            //string address = range.get_Address();
            //string[] cells = address.Split(new char[] { ':' });
            //string beginCell = cells[0].Replace("$", "");
            //string endCell = cells[1].Replace("$", "");

            //int lastColumn = range.Columns.Count;
            //int lastRow = range.Rows.Count;

            var r = workBook.ActiveSheet.UsedRange.Rows.Count;
            var c = workBook.ActiveSheet.UsedRange.Columns.Count;

            Excel.Range row2, row1;

            //row1 = sheet.Rows.Cells[r, 52]; // pinta que no le gusta si se la quiero pasar en una columna fuera de las que usa
            //row1.Value = numerocarta;

            row2 = sheet.Rows.Cells[r, 52];
            row2.Value = dato;


            excel.Application.ActiveWorkbook.SaveAs(nombreexcel);
            excel.Application.Quit();
            excel.Quit();



        }


        public static string GenerarHtmlConResultado(List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> l, string err)
        {
            if (err != "") return err;
            if (l == null) return null;

            string stodo = "";

            foreach (ProntoMVC.Data.FuncionesGenericasCSharp.Resultados x in l)
            {
                string sError = "";

                sError = "<a href=\"CartaDePorte.aspx?Id=" + x.IdCarta + "\" target=\"_blank\">" + "Carta " + x.numerocarta + "   " + x.errores + "   " + x.advertencias + "</a>;  <br/> ";  // & oCarta.NumeroCartaDePorte & "/" & oCarta.SubnumeroVagon & "</a>;  <br/> "

                stodo += sError;
            }
            return stodo;
        }





        public static IQueryable<ProntoMVC.Data.Models.CartasDePorteLogDeOCR> ExtraerListaDeImagenesIrreconocibles(string DirApp, string SC)
        {
            string dir = DirApp + @"\Temp\";


            ProntoMVC.Data.Models.DemoProntoEntities db =
                    new DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)));

            IQueryable<ProntoMVC.Data.Models.CartasDePorteLogDeOCR> q2 = (from ProntoMVC.Data.Models.CartasDePorteLogDeOCR i in db.CartasDePorteLogDeOCRs
                                                                          where i.NumeroCarta >= 900000000 || i.Observaciones != ""
                                                                          orderby i.Fecha descending
                                                                          select i).AsQueryable();

            if (false)
            {
                DirectoryInfo d = new DirectoryInfo(dir);//Assuming Test is your Folder

                FileInfo[] files = d.GetFiles("*.*", SearchOption.AllDirectories); //Getting Text files
                IQueryable<procesGrilla> q = (from f in files
                                              where (EsArchivoDeImagen(f.Name) && !f.FullName.Contains("_IMPORT1")
                                                     &&
                                                     (files.Where(x => x.Name == (f.Name + ".bdl")).FirstOrDefault() ?? f).LastWriteTime <= f.LastWriteTime
                                              )
                                              orderby f.LastWriteTime descending
                                              select new procesGrilla() { nombreImagen = "" }).AsQueryable();
            }


            return q2;
            //sacar info del log o de los archivos????
        }



        public static List<string> BuscarExcelsGenerados(string DirApp)
        {

            string dir = DirApp + @"\Temp\";
            var l = new List<string>();

            //DirectoryInfo d = new DirectoryInfo(dir);//Assuming Test is your Folder
            //FileInfo[] files = d.GetFiles("Export*.xls", SearchOption.AllDirectories); //Getting Text files
            // IEnumerable<FileInfo> files = d.EnumerateFiles("Export*.xls", SearchOption. .AllDirectories); //Getting Text files




            var di = new DirectoryInfo(dir);
            List<string> directories = di.EnumerateDirectories()
                    .Where(d => !d.Name.Contains("_IMPORT1"))
                    .OrderByDescending(d => d.CreationTime)
                    .Select(d => d.Name)
                    .ToList();

            return directories;


            //foreach (FileInfo file in Files)
            //{
            //    l.Add(file.Name);
            //}


            //var files = Directory.EnumerateFiles(dir, "*.*", SearchOption.AllDirectories).OrderByDescending(x=>x.last)
            //                    .Where(s => s.EndsWith(".tif") || s.EndsWith(".tiff")  || s.EndsWith(".jpg"));



            // levantá solo los nombres de directorios y agregales EXPORTToXLS
            string[] ld = Directory.GetDirectories(dir);


            //  http://stackoverflow.com/questions/7865159/retrieving-files-from-directory-that-contains-large-amount-of-files
            //http://stackoverflow.com/questions/1199732/directoryinfo-getfiles-slow-when-using-searchoption-alldirectories

            // http://stackoverflow.com/questions/12332451/list-all-files-and-directories-in-a-directory-subdirectories


            List<string> sss = new List<string>();
            foreach (string Dir in ld)
            {
                var dirInfo = new System.IO.DirectoryInfo(Dir);
                sss.Add(dirInfo.Name);
            }

            //  TO DO ordenar por fecha

            return sss;

            //var q = (from f in files
            //         orderby f.LastWriteTime descending
            //         select f.FullName);
            //     return q.ToList();


        }




        static bool EsArchivoDeImagen(string f)
        {


            if (!f.ToLower().Contains("exporttoxls") &&
                (
                    f.ToLower().EndsWith(".tif")
                    || f.ToLower().EndsWith(".tiff")
                    || f.ToLower().EndsWith(".jpg")
                    || f.ToLower().EndsWith(".pdf")
                )
               )
                return true;

            return false;

        }


        private static void MoverDirectoriosViejos()
        {


        }





        public static List<string> ExtraerListaDeExcelsQueNoHanSidoProcesados(int cuantas, string DirApp)
        {

            string dir = DirApp + @"\Temp\Pegatinas\";
            var l = new List<string>();

            //como hacer eficiente esto? -por lo menos borra las imagenes viejas

            MoverDirectoriosViejos();



            DirectoryInfo d = new DirectoryInfo(dir);//Assuming Test is your Folder
            FileInfo[] files = null;


            // qué tal si levanto los directorios, me fijo cuales son nuevos, y sobre esos hago el getfiles?

            var desde = DateTime.Now.AddHours(-4);


            if (true)
            {
                //IEnumerable<DirectoryInfo> dirs = d.GetDirectories("*.*", SearchOption.TopDirectoryOnly).Where(x => x.CreationTime > desde);

                files = d.GetFiles("*.*", SearchOption.TopDirectoryOnly);

                //foreach (DirectoryInfo subd in dirs)
                //{

                //    if (files == null) files = subd.GetFiles("*.*", SearchOption.TopDirectoryOnly);
                //    else files = files.Concat(subd.GetFiles("*.*", SearchOption.TopDirectoryOnly)).ToArray();

                //}


            }
            else
            {
                try
                {

                    //esto es durisimo

                    files = d.GetFiles("*.**", SearchOption.AllDirectories); //Getting Text files
                    // http://stackoverflow.com/questions/12332451/list-all-files-and-directories-in-a-directory-subdirectories

                    //d.EnumerateFiles()
                }
                catch (Exception ex)
                {
                    //             System.OutOfMemoryException: Exception of type 'System.OutOfMemoryException' was thrown.
                    //at System.IO.FileInfoResultHandler.CreateObject(SearchResult result)
                    //at System.IO.FileSystemEnumerableIterator`1.MoveNext()
                    //at System.Collections.Generic.List`1..ctor(IEnumerable`1 collection)
                    //at System.IO.DirectoryInfo.InternalGetFiles(String searchPattern, SearchOption searchOption)
                    //at System.IO.DirectoryInfo.GetFiles(String searchPattern, SearchOption searchOption)
                    //at ProntoFlexicapture.ClassFlexicapture.ExtraerListaDeImagenesQueNoHanSidoProcesadas(Int32 cuantas, String DirApp) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 582
                    //at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, Int32 cuantasImagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 108
                    //at ProntoWindowsService.Service1.Tanda(String SC, String DirApp) in c:\Users\Administrador\Documents\bdl\pronto\ProntoWindowsService\Service1.cs:line 359
                    //at ProntoWindowsService.Service1.DoWork() in c:\Users\Administrador\Documents\bdl\pronto\ProntoWindowsService\Service1.cs:line 211
                    Log("Probablemente explota Getfiles");
                    Log(ex.ToString());
                    return null;
                }

            }



            //foreach (FileInfo file in Files)
            //{
            //    l.Add(file.Name);
            //}


            //var files = Directory.EnumerateFiles(dir, "*.*", SearchOption.AllDirectories).OrderByDescending(x=>x.last)
            //                    .Where(s => s.EndsWith(".tif") || s.EndsWith(".tiff")  || s.EndsWith(".jpg"));

            // (files.Where(x => x.Name == (f.Name + ".bdl")).FirstOrDefault() ?? f).LastWriteTime <= f.LastWriteTime

            // tenes usar el creationtime para las que fueron extraidas del zip

            if (files == null) return null;

            var q = (from f in files
                     where ((f.LastWriteTime > f.CreationTime ? f.LastWriteTime : f.CreationTime) > DateAndTime.DateAdd(DateInterval.Hour, -24, DateTime.Now))
                           && (
                           (f.FullName.ToLower().EndsWith(".xls") || f.FullName.ToLower().EndsWith(".xlsx"))
                            && !files.Any(x => x.FullName == (f.FullName + ".bdl") && x.LastWriteTime > f.LastWriteTime)
                     )
                     orderby f.LastWriteTime ascending
                     select f.FullName).Take(cuantas).ToList();



            return q;

        }


        public static List<string> ExtraerListaDeImagenesQueNoHanSidoProcesadas(int cuantas, string DirApp)
        {

            string dir = DirApp + @"\Temp\";
            var l = new List<string>();

            //como hacer eficiente esto? -por lo menos borra las imagenes viejas

            MoverDirectoriosViejos();



            DirectoryInfo d = new DirectoryInfo(dir);//Assuming Test is your Folder
            FileInfo[] files = null;


            // qué tal si levanto los directorios, me fijo cuales son nuevos, y sobre esos hago el getfiles?

            var desde = DateTime.Now.AddHours(-4);


            if (true)
            {
                //IEnumerable<DirectoryInfo> dirs = d.GetDirectories("*.*", SearchOption.TopDirectoryOnly).Where(x => x.CreationTime > desde); // no tiene sentido usar un IEnumerable porque necesitas chuparlos todos
                List<DirectoryInfo> dirs;

                ErrHandler2.WriteError("Leo listado de dirs");
                try
                {
                    dirs = d.GetDirectories("*.*", SearchOption.TopDirectoryOnly).Where(x => x.CreationTime > desde && !x.Name.Contains("_IMPORT1") && !x.Name.ToLower().Contains("pegatinas")).ToList();
                }
                catch (Exception ex)
                {
                    ErrHandler2.WriteError(ex);
                    return null;
                }

                //files = d.GetFiles("*.*", SearchOption.TopDirectoryOnly); 



                foreach (DirectoryInfo subd in dirs)
                {
                    ErrHandler2.WriteError("Leo " + subd);
                    if (files == null) files = subd.GetFiles("*.*", SearchOption.TopDirectoryOnly);
                    else files = files.Concat(subd.GetFiles("*.*", SearchOption.TopDirectoryOnly)).ToArray();

                    if (files.Count() > 1000) break;
                }


            }
            else
            {
                try
                {

                    //esto es durisimo

                    files = d.GetFiles("*.*", SearchOption.AllDirectories); //Getting Text files
                    // http://stackoverflow.com/questions/12332451/list-all-files-and-directories-in-a-directory-subdirectories

                    //d.EnumerateFiles()
                }
                catch (Exception ex)
                {
                    //             System.OutOfMemoryException: Exception of type 'System.OutOfMemoryException' was thrown.
                    //at System.IO.FileInfoResultHandler.CreateObject(SearchResult result)
                    //at System.IO.FileSystemEnumerableIterator`1.MoveNext()
                    //at System.Collections.Generic.List`1..ctor(IEnumerable`1 collection)
                    //at System.IO.DirectoryInfo.InternalGetFiles(String searchPattern, SearchOption searchOption)
                    //at System.IO.DirectoryInfo.GetFiles(String searchPattern, SearchOption searchOption)
                    //at ProntoFlexicapture.ClassFlexicapture.ExtraerListaDeImagenesQueNoHanSidoProcesadas(Int32 cuantas, String DirApp) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 582
                    //at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, Int32 cuantasImagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 108
                    //at ProntoWindowsService.Service1.Tanda(String SC, String DirApp) in c:\Users\Administrador\Documents\bdl\pronto\ProntoWindowsService\Service1.cs:line 359
                    //at ProntoWindowsService.Service1.DoWork() in c:\Users\Administrador\Documents\bdl\pronto\ProntoWindowsService\Service1.cs:line 211
                    Log("Probablemente explota Getfiles");
                    Log(ex.ToString());
                    return null;
                }

            }



            //foreach (FileInfo file in Files)
            //{
            //    l.Add(file.Name);
            //}


            //var files = Directory.EnumerateFiles(dir, "*.*", SearchOption.AllDirectories).OrderByDescending(x=>x.last)
            //                    .Where(s => s.EndsWith(".tif") || s.EndsWith(".tiff")  || s.EndsWith(".jpg"));

            // (files.Where(x => x.Name == (f.Name + ".bdl")).FirstOrDefault() ?? f).LastWriteTime <= f.LastWriteTime

            // tenes usar el creationtime para las que fueron extraidas del zip

            if (files == null) return null;

            ErrHandler2.WriteError("Filtro los marcados");

            var q = (from f in files
                     where ((f.LastWriteTime > f.CreationTime ? f.LastWriteTime : f.CreationTime) > desde)
                            && (EsArchivoDeImagen(f.Name)
                            && !f.FullName.Contains("_IMPORT1")
                            && !files.Any(x => x.FullName == (f.FullName + ".bdl"))
                     )
                     orderby f.LastWriteTime ascending
                     select f.FullName).Take(cuantas).ToList();


            ErrHandler2.WriteError("Salgo");
            return q;

        }


        public class procesGrilla
        {
            public string nombreImagen { get; set; }
            public DateTime fecha { get; set; }
            public string resultado { get; set; }
            public string usuario { get; set; }
            public int idcartaporte { get; set; }
            public int numerocartaporte { get; set; }
        }



        static int DesmarcarArchivoComoProcesandose(string archivo)
        {
            //y si creo un archivo con extension?

            CartaDePorteManager.BorroArchivo(archivo + ".bdl");

            return 0;

        }

        public static int MarcarArchivoComoProcesandose(string archivo)
        {
            //y si creo un archivo con extension?

            CreateEmptyFile(archivo + ".bdl");

            return 0;

        }


        static int MarcarImagenComoProcesada(string archivo)
        {
            return 0;

        }


        public static void MarcarCartaComoProcesada(ref Pronto.ERP.BO.CartaDePorte cdp, string usu, string SC)
        {
            //pasar id

            //cdp.IdUsuarioAnulo = -1;

            //cdp.

            //cdp.Corredor2
            //  cdp.

            try
            {


                // si la grabas acá, despues va a volver a pisar los datos de la carta
                using (DemoProntoEntities db = new DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC))))
                {


                    CartasDePorteLogDeOCR q = new CartasDePorteLogDeOCR();

                    q.Fecha = DateAndTime.Now;
                    q.NumeroCarta = Convert.ToInt32(cdp.NumeroCartaDePorte);
                    q.IdCartaDePorte = cdp.Id;
                    q.TextoAux1 = usu;
                    q.Observaciones = cdp.MotivoAnulacion;


                    db.CartasDePorteLogDeOCRs.Add(q);
                    db.SaveChanges();
                }

            }

            catch (Exception)
            {
                Log("trate de grabar con id " + cdp.Id);

                throw;
            }

        }


        public static List<CartasDePorteLogDeOCR> ExtraerListaDeImagenesProcesadas(string DirApp, string SC)
        {
            string dir = DirApp + @"\Temp\";
            DirectoryInfo d = new DirectoryInfo(dir);//Assuming Test is your Folder
            FileInfo[] files = d.GetFiles("*.*", SearchOption.AllDirectories); //Getting Text files


            using (DemoProntoEntities db =
                     new DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC))))
            {
                // where (i.PathImagen != "" || i.PathImagen2 != "")

                List<ProntoMVC.Data.Models.CartasDePorteLogDeOCR> q = (from ProntoMVC.Data.Models.CartasDePorteLogDeOCR i in db.CartasDePorteLogDeOCRs
                                                                       orderby i.Fecha descending
                                                                       select i).Take(100).ToList();

                //List<ProntoMVC.Data.Models.CartasDePorte> q = (from ProntoMVC.Data.Models.CartasDePorte i in db.CartasDePortes select i).Take(10).ToList();



                // como me traigo la info de las id, etc?
                return q;
                //sacar info del log o de los archivos????
            }


        }





        public static bool bEstaLaLicenciadelFlexicapture()
        {

            return true;

        }




        private static Bitmap GetBitmapFormTiff(Tiff tif)
        {
            FieldValue[] value = tif.GetField(TiffTag.IMAGEWIDTH);
            int width = value[0].ToInt();

            value = tif.GetField(TiffTag.IMAGELENGTH);
            int height = value[0].ToInt();

            //Read the image into the memory buffer
            var raster = new int[height * width];
            if (!tif.ReadRGBAImage(width, height, raster))
            {
                return null;
            }

            var bmp = new Bitmap(width, height, PixelFormat.Format32bppRgb);

            var rect = new Rectangle(0, 0, bmp.Width, bmp.Height);

            BitmapData bmpdata = bmp.LockBits(rect, ImageLockMode.ReadWrite, PixelFormat.Format32bppRgb);
            var bits = new byte[bmpdata.Stride * bmpdata.Height];

            for (int y = 0; y < bmp.Height; y++)
            {
                int rasterOffset = y * bmp.Width;
                int bitsOffset = (bmp.Height - y - 1) * bmpdata.Stride;

                for (int x = 0; x < bmp.Width; x++)
                {
                    int rgba = raster[rasterOffset++];
                    bits[bitsOffset++] = (byte)((rgba >> 16) & 0xff);
                    bits[bitsOffset++] = (byte)((rgba >> 8) & 0xff);
                    bits[bitsOffset++] = (byte)(rgba & 0xff);
                    bits[bitsOffset++] = (byte)((rgba >> 24) & 0xff);
                }
            }

            System.Runtime.InteropServices.Marshal.Copy(bits, 0, bmpdata.Scan0, bits.Length);
            bmp.UnlockBits(bmpdata);

            return bmp;
        }


        public static List<string> PreprocesarImagenesTiff2(string archivo, bool bEsFormatoCPTK, bool bGirar180grados, bool bProcesarConOCR)
        {

            if (!Path.GetExtension(archivo).ToLower().Contains("tif"))
                return null;

            if (bGirar180grados) MarcarArchivoComoProcesandose(archivo); // me anticipo para que no lo tome el servicio mientras creo los tiff individuales

            //  List<System.Drawing.Image> listapaginas = ProntoMVC.Data.FuncionesGenericasCSharp.GetAllPages(archivo);
            //open tif file
            var tif = Tiff.Open(archivo, "r");
            //get number of pages
            var num = tif.NumberOfDirectories();
            // http://stackoverflow.com/questions/13178185/how-to-split-multipage-tiff-using-libtiff-net


            List<string> l = new List<string>();
            int n = 0;
            if (num > 1)
            {
                //for (n = 0; n <= listapaginas.Count - 1; n++)
                for (short i = 0; i < num; i++)
                {
                    var nombre = archivo + "_pag" + n.ToString() + ".tif";

                    if (bGirar180grados) nombre += ".temp"; // para que no lo tome el servicio


                    //listapaginas[n].Save(nombre, System.Drawing.Imaging.ImageFormat.Tiff);
                    tif.SetDirectory(i);
                    Bitmap bmp = GetBitmapFormTiff(tif);
                    bmp.Save(string.Format(@"newfile{0}.bmp", i));


                    if (bGirar180grados)
                    {
                        var rotado = nombre + "_rotado.tif";
                        OrientarImagen(nombre, rotado);
                        CartaDePorteManager.BorroArchivo(nombre);
                        nombre = rotado;
                    }

                    l.Add(nombre);
                }
            }


            if ((bEsFormatoCPTK))
            {

                for (n = 0; n + 1 <= num - 1; n += 2)
                {
                    var pagina1 = archivo + "_pag" + n.ToString() + ".tif";
                    var pagina2 = archivo + "_pag" + (n + 1).ToString() + ".tif";
                    var final = archivo + "_pag" + (n).ToString() + "_unido.tif";

                    string[] arguments = {
                        pagina1,
                        pagina2,
                        final
                    };

                    BitMiracle.TiffCP.Program.Main(arguments);

                    if (!bProcesarConOCR) MarcarArchivoComoProcesandose(final);

                    //Dim p As System.Diagnostics.Process = New System.Diagnostics.Process()
                    //p.StartInfo.UseShellExecute = False
                    //p.StartInfo.RedirectStandardOutput = True
                    //p.StartInfo.FileName = @"C:\PathToExe\TiffCP.exe"
                    //Dim path1 = @"C:\PathToImage\image.tiff"
                    //dim path2 = @"C:\PathToImage\imagePage1.tiff"
                    //p.StartInfo.Arguments = "\"" + path1 + " \ "" + ",0 \"" + path2 + " \ ""
                    //p.Start()
                    //string t = p.StandardOutput.ReadToEnd()

                    CartaDePorteManager.BorroArchivo(pagina1);
                    CartaDePorteManager.BorroArchivo(pagina2);



                    l.Remove(pagina1);
                    l.Remove(pagina2);
                    l.Add(final);
                }



            }


            // CartaDePorteManager.BorroArchivo(archivo);  //no borrar el original, total ya está marcado como procesado

            return l;

        }




        public static List<string> PreprocesarImagenesTiff(string archivo, bool bEsFormatoCPTK, bool bGirar180grados, bool bProcesarConOCR)
        {

            if (!Path.GetExtension(archivo).ToLower().Contains("tif"))
                return null;

            if (bGirar180grados) MarcarArchivoComoProcesandose(archivo); // me anticipo para que no lo tome el servicio mientras creo los tiff individuales


            List<System.Drawing.Image> listapaginas;

            try
            {
                listapaginas = ProntoMVC.Data.FuncionesGenericasCSharp.GetAllPages(archivo);

            }
            catch (Exception)
            {

                ErrHandler2.WriteError("Nombre archivo: " + archivo);

                throw;
            }


            List<string> l = new List<string>();
            int n = 0;
            if (listapaginas.Count > 1)
            {
                for (n = 0; n <= listapaginas.Count - 1; n++)
                {
                    var nombre = archivo + "_pag" + n.ToString() + ".tif";

                    if (bGirar180grados) nombre += ".temp"; // para que no lo tome el servicio

                    listapaginas[n].Save(nombre, System.Drawing.Imaging.ImageFormat.Tiff);

                    if (bGirar180grados)
                    {
                        var rotado = nombre + "_rotado.tif";
                        OrientarImagen(nombre, rotado);
                        CartaDePorteManager.BorroArchivo(nombre);
                        nombre = rotado;
                    }

                    l.Add(nombre);
                }
            }


            if ((bEsFormatoCPTK))
            {

                for (n = 0; n + 1 <= listapaginas.Count - 1; n += 2)
                {
                    var pagina1 = archivo + "_pag" + n.ToString() + ".tif";
                    var pagina2 = archivo + "_pag" + (n + 1).ToString() + ".tif";
                    var final = archivo + "_pag" + (n).ToString() + "_unido.tif";

                    string[] arguments = {
                        pagina1,
                        pagina2,
                        final
                    };

                    BitMiracle.TiffCP.Program.Main(arguments);

                    if (!bProcesarConOCR) MarcarArchivoComoProcesandose(final);

                    //Dim p As System.Diagnostics.Process = New System.Diagnostics.Process()
                    //p.StartInfo.UseShellExecute = False
                    //p.StartInfo.RedirectStandardOutput = True
                    //p.StartInfo.FileName = @"C:\PathToExe\TiffCP.exe"
                    //Dim path1 = @"C:\PathToImage\image.tiff"
                    //dim path2 = @"C:\PathToImage\imagePage1.tiff"
                    //p.StartInfo.Arguments = "\"" + path1 + " \ "" + ",0 \"" + path2 + " \ ""
                    //p.Start()
                    //string t = p.StandardOutput.ReadToEnd()

                    CartaDePorteManager.BorroArchivo(pagina1);
                    CartaDePorteManager.BorroArchivo(pagina2);



                    l.Remove(pagina1);
                    l.Remove(pagina2);
                    l.Add(final);
                }



            }


            // CartaDePorteManager.BorroArchivo(archivo);  //no borrar el original, total ya está marcado como procesado

            return l;

        }


        public static List<string> PreprocesarArchivoSubido(string zipFile, string nombreusuario, string DirApp, bool bEsFormatoCPTK, bool bGirar180grados, bool bProcesarConOCR, int puntoventa)
        {

            string DIRTEMP = DirApp + @"\Temp\";
            string nuevosubdir = DIRTEMP + CartaDePorteManager.CrearDirectorioParaLoteImagenes(DirApp, nombreusuario, puntoventa);
            string destarchivo = nuevosubdir + Path.GetFileName(zipFile);
            File.Copy(zipFile, destarchivo, true);

            bool esZip = true;
            List<string> l, ext;
            List<string> l2 = new List<string>();

            if (Path.GetExtension(destarchivo).ToLower().Contains("zip"))
            {
                l = CartaDePorteManager.ExtraerZip(destarchivo, nuevosubdir);
            }
            else
            {
                l = new List<string>();
                l.Add(destarchivo);
            }


            foreach (string f in l)
            {
                MarcarArchivoComoProcesandose(f);
            }

            foreach (string f in l)
            {
                ext = PreprocesarImagenesTiff(f, bEsFormatoCPTK, bGirar180grados, bProcesarConOCR);

                if (ext != null && ext.Count > 0)
                {
                    foreach (string ff in ext)
                    {
                        l2.Add(ff);
                    }
                }
                else
                {
                    l2.Add(f);
                    if (bProcesarConOCR) DesmarcarArchivoComoProcesandose(f);
                }
            }



            return l2;
        }





        static void OrientarImagen(string origen, string destino)
        {

            List<Image> images = new List<Image>();
            Bitmap bitmap = (Bitmap)Image.FromFile(origen);
            int count = bitmap.GetFrameCount(FrameDimension.Page);

            // save each frame to a bytestream
            bitmap.SelectActiveFrame(FrameDimension.Page, 0);
            MemoryStream byteStream = new MemoryStream();

            bitmap.RotateFlip(RotateFlipType.Rotate180FlipNone);

            bitmap.Save(byteStream, ImageFormat.Tiff);
            // and then create a new Image from it
            Image.FromStream(byteStream).Save(destino, System.Drawing.Imaging.ImageFormat.Tiff);
            return; // images;




            using (Tiff input = Tiff.Open(origen, "r"))
            {
                int width = input.GetField(TiffTag.IMAGEWIDTH)[0].ToInt();
                int height = input.GetField(TiffTag.IMAGELENGTH)[0].ToInt();
                int samplesPerPixel = input.GetField(TiffTag.SAMPLESPERPIXEL)[0].ToInt();
                int bitsPerSample = input.GetField(TiffTag.BITSPERSAMPLE)[0].ToInt();
                int photo = input.GetField(TiffTag.PHOTOMETRIC)[0].ToInt();

                int scanlineSize = input.ScanlineSize();
                byte[][] buffer = new byte[height][];
                for (int i = 0; i < height; ++i)
                {
                    buffer[i] = new byte[scanlineSize];
                    input.ReadScanline(buffer[i], i);
                }

                using (Tiff output = Tiff.Open(destino, "w"))
                {
                    output.SetField(TiffTag.IMAGEWIDTH, width);
                    output.SetField(TiffTag.IMAGELENGTH, height);
                    output.SetField(TiffTag.SAMPLESPERPIXEL, samplesPerPixel);
                    output.SetField(TiffTag.BITSPERSAMPLE, bitsPerSample);
                    output.SetField(TiffTag.ROWSPERSTRIP, output.DefaultStripSize(0));
                    output.SetField(TiffTag.PHOTOMETRIC, photo);
                    output.SetField(TiffTag.PLANARCONFIG, PlanarConfig.CONTIG);

                    // change orientation of the image
                    output.SetField(TiffTag.ORIENTATION, Orientation.RIGHTBOT);

                    for (int i = 0; i < height; ++i)
                        output.WriteScanline(buffer[i], i);
                }
            }


            /*
            // http://forum.ocrsdk.com/questions/2145/orientation-detection-and-correction-in-flexicapture-sdk

            // get rotation type
            RotationTypeEnum rotationTypeEnum = imageProcessor.DetectOrientationByText(_page, language);

            // rotate image according to rotation type
            if (rotationTypeEnum == RotationTypeEnum.RT_Clockwise)
            {
                _page = imageProcessor.RotateImageByRotationType(_page, RotationTypeEnum.RT_Counterclockwise);
            }
            else
                if (rotationTypeEnum == RotationTypeEnum.RT_Counterclockwise)
                {
                    _page = imageProcessor.RotateImageByRotationType(_page, RotationTypeEnum.RT_Clockwise);
                }
                else
                    if (rotationTypeEnum == RotationTypeEnum.RT_Upsidedown)
                    {
                        _page = imageProcessor.RotateImageByRotationType(_page, RotationTypeEnum.RT_Upsidedown);
                    }

           // If you want to save the rotated image, you could use Image::WriteToFile method.
             */
        }



        static public void SaveAsMultiPageTiff(string sOutFile, string[] archivos)
        {


            System.Drawing.Imaging.Encoder encoder = System.Drawing.Imaging.Encoder.SaveFlag;
            ImageCodecInfo encoderInfo = ImageCodecInfo.GetImageEncoders().First(i => i.MimeType == "image/tiff");
            EncoderParameters encoderParameters = new EncoderParameters(1);
            encoderParameters.Param[0] = new EncoderParameter(encoder, (long)EncoderValue.MultiFrame);

            Bitmap firstImage = null;
            try
            {

                using (MemoryStream ms1 = new MemoryStream())
                {
                    using (MemoryStream ms = new MemoryStream(File.ReadAllBytes(archivos[0])))
                    {
                        Image.FromStream(ms).Save(ms1, ImageFormat.Tiff);
                        firstImage = (Bitmap)Image.FromStream(ms1);
                    }
                    // Save the first frame of the multi page tiff
                    firstImage.Save(sOutFile, encoderInfo, encoderParameters); //throws Generic GDI+ error if the memory streams are not open when this is called
                }


                encoderParameters.Param[0] = new EncoderParameter(encoder, (long)EncoderValue.FrameDimensionPage);

                Bitmap imagePage;
                // Add the remining images to the tiff
                for (int i = 1; i < archivos.Length; i++)
                {

                    using (MemoryStream ms1 = new MemoryStream())
                    {
                        using (MemoryStream ms = new MemoryStream(File.ReadAllBytes(archivos[i])))
                        {
                            Image.FromStream(ms).Save(ms1, ImageFormat.Tiff);
                            imagePage = (Bitmap)Image.FromStream(ms1);
                        }

                        firstImage.SaveAdd(imagePage, encoderParameters); //throws Generic GDI+ error if the memory streams are not open when this is called
                    }
                }

            }
            catch (Exception)
            {
                //ensure the errors are not missed while allowing for flush in finally block so files dont get locked up.
                throw;
            }
            finally
            {
                // Close out the file
                encoderParameters.Param[0] = new EncoderParameter(encoder, (long)EncoderValue.Flush);
                firstImage.SaveAdd(encoderParameters);
            }
        }



        public static string EstadoServicio()
        {
            string SERVICENAME = "ProntoAgente";

            ServiceController sc = new ServiceController(SERVICENAME);

            switch (sc.Status)
            {
                case ServiceControllerStatus.Running:
                    return "Running";
                case ServiceControllerStatus.Stopped:
                    return "Stopped";
                case ServiceControllerStatus.Paused:
                    return "Paused";
                case ServiceControllerStatus.StopPending:
                    return "Stopping";
                case ServiceControllerStatus.StartPending:
                    return "Starting";
                default:
                    return "Status Changing";
            }


        }



        static ProntoMVC.Data.FuncionesGenericasCSharp.Resultados ProcesaCarta(IDocument document, string SC, string archivoOriginal, string DirApp)
        {

            Pronto.ERP.BO.CartaDePorte cdp;

            IField BarraCP = Sample.AdvancedTechniques.findField(document, "BarraCP");

            string BarraCEE = Sample.AdvancedTechniques.findField(document, "BarraCEE").NullStringSafe();
            string NCarta = Sample.AdvancedTechniques.findField(document, "NumeroCarta").NullStringSafe();
            string CEE = Sample.AdvancedTechniques.findField(document, "CEE").NullStringSafe();


            string TitularCUIT = Sample.AdvancedTechniques.findField(document, "TitularCUIT").NullStringSafe();
            string Titular = Sample.AdvancedTechniques.findField(document, "Titular").NullStringSafe();
            string RemitenteCUIT = Sample.AdvancedTechniques.findField(document, "RemitenteCUIT").NullStringSafe();
            string Remitente = Sample.AdvancedTechniques.findField(document, "Remitente").NullStringSafe();
            string IntermediarioCUIT = Sample.AdvancedTechniques.findField(document, "IntermediarioCUIT").NullStringSafe();
            string Intermediario = Sample.AdvancedTechniques.findField(document, "Intermediario").NullStringSafe();
            string DestinatarioCUIT = Sample.AdvancedTechniques.findField(document, "DestinatarioCUIT").NullStringSafe();
            string Destinatario = Sample.AdvancedTechniques.findField(document, "Destinatario").NullStringSafe();
            string CorredorCUIT = Sample.AdvancedTechniques.findField(document, "CorredorCUIT").NullStringSafe();
            string Corredor = Sample.AdvancedTechniques.findField(document, "Corredor").NullStringSafe();

            string CTG = Sample.AdvancedTechniques.findField(document, "CTG").NullStringSafe();
            string FechaCarga = Sample.AdvancedTechniques.findField(document, "FechaCarga").NullStringSafe();
            string FechaVencimiento = Sample.AdvancedTechniques.findField(document, "FechaVencimiento").NullStringSafe();
            string Destino = Sample.AdvancedTechniques.findField(document, "Destino").NullStringSafe();
            string DestinoCUIT = Sample.AdvancedTechniques.findField(document, "DestinoCUIT").NullStringSafe();
            string Chofer = Sample.AdvancedTechniques.findField(document, "Chofer").NullStringSafe();
            string ChoferCUIT = Sample.AdvancedTechniques.findField(document, "ChoferCUIT").NullStringSafe();
            string Transportista = Sample.AdvancedTechniques.findField(document, "Transportista").NullStringSafe();
            string TransportistaCUIT = Sample.AdvancedTechniques.findField(document, "TransportistaCUIT").NullStringSafe();
            string ContratoNro = Sample.AdvancedTechniques.findField(document, "ContratoNro").NullStringSafe();

            string LaCargaSeráPesadaEnDestino = Sample.AdvancedTechniques.findField(document, "LaCargaSeráPesadaEnDestino").NullStringSafe();
            string DeclaraciónDeCalidad = Sample.AdvancedTechniques.findField(document, "DeclaraciónDeCalidad").NullStringSafe();
            string Conforme = Sample.AdvancedTechniques.findField(document, "Conforme").NullStringSafe();
            string Condicional = Sample.AdvancedTechniques.findField(document, "Condicional").NullStringSafe();

            string PesoBruto = Sample.AdvancedTechniques.findField(document, "PesoBruto").NullStringSafe();
            string PesoTara = Sample.AdvancedTechniques.findField(document, "PesoTara").NullStringSafe();
            string PesoNeto = Sample.AdvancedTechniques.findField(document, "PesoNeto").NullStringSafe();

            string PesoBrutoDescarga = Sample.AdvancedTechniques.findField(document, "PesoBrutoDescarga").NullStringSafe();
            string PesoTaraDescarga = Sample.AdvancedTechniques.findField(document, "PesoTaraDescarga").NullStringSafe();
            string PesoNetoDescarga = Sample.AdvancedTechniques.findField(document, "PesoNetoDescarga").NullStringSafe();

            string PesoNetoFinal = Sample.AdvancedTechniques.findField(document, "PesoNetoFinal").NullStringSafe();


            string Observaciones = Sample.AdvancedTechniques.findField(document, "Observaciones").NullStringSafe();
            string Esablecimiento = Sample.AdvancedTechniques.findField(document, "Esablecimiento").NullStringSafe();
            string Direccion1 = Sample.AdvancedTechniques.findField(document, "Direccion1").NullStringSafe();
            string Localidad1 = Sample.AdvancedTechniques.findField(document, "Localidad1").NullStringSafe();
            string Direccion2 = Sample.AdvancedTechniques.findField(document, "Direccion2").NullStringSafe();
            string Localidad2 = Sample.AdvancedTechniques.findField(document, "Localidad2").NullStringSafe();
            string Provincia2 = Sample.AdvancedTechniques.findField(document, "Provincia2").NullStringSafe();
            string Camión = Sample.AdvancedTechniques.findField(document, "Camión").NullStringSafe();
            string Acoplado = Sample.AdvancedTechniques.findField(document, "Acoplado").NullStringSafe();
            string KmARecorrer = Sample.AdvancedTechniques.findField(document, "KmARecorrer").NullStringSafe();
            string Tarifa = Sample.AdvancedTechniques.findField(document, "Tarifa").NullStringSafe();
            string TarifaRef = Sample.AdvancedTechniques.findField(document, "TarifaRef").NullStringSafe();

            string Cosecha = Sample.AdvancedTechniques.findField(document, "Cosecha").NullStringSafe();


            string GranoEspecie = Sample.AdvancedTechniques.findField(document, "GranoEspecie").NullStringSafe();

            string KgsEstimados = Sample.AdvancedTechniques.findField(document, "KgsEstimados").NullStringSafe();

            string PlantillaUsada = Sample.AdvancedTechniques.findField(document, "PlantillaUsada").NullStringSafe();
            //string plantillaUsada = document.Pages[0].SectionDefinition.FlexibleDescription.Name;

            string FechaDescarga = Sample.AdvancedTechniques.findField(document, "FechaDescarga").NullStringSafe();



            string HumedadPorc = Sample.AdvancedTechniques.findField(document, "HumedadPorc").NullStringSafe();
            string HumedadKilos = Sample.AdvancedTechniques.findField(document, "HumedadKilos").NullStringSafe();
            string ZarandeoKilosMerma = Sample.AdvancedTechniques.findField(document, "ZarandeoKilosMerma").NullStringSafe();
            string ZarandeoPorc = Sample.AdvancedTechniques.findField(document, "ZarandeoPorc").NullStringSafe();
            string Recibo = Sample.AdvancedTechniques.findField(document, "Recibo").NullStringSafe();
            string HoraDescarga = Sample.AdvancedTechniques.findField(document, "HoraDescarga").NullStringSafe();





            ErrHandler2.WriteError("Procesó carta: titular " + Titular);


            long numeroCarta = 0;
            int vagon = 0;
            string sError = "";



            bool esTicket = (PlantillaUsada != "");


            //grabarrenglontipado??

            if (!esTicket)
            {
                if (BarraCP != null)
                {
                    if (long.TryParse(BarraCP.Value.AsString, out numeroCarta))
                    {
                        //Debug.Print(NCarta.Value.AsString + " " + BarraCP.Value.AsString);
                        // numeroCarta = Convert.ToInt64(BarraCP.Value.AsString);
                        if (numeroCarta.ToString().Length == 9)
                        {
                            ErrHandler2.WriteError("Detectó bien el numero con el Flexicapture: " + numeroCarta.ToString());

                        }
                        else
                        {

                            numeroCarta = 0;
                        }
                    }
                }



                if (numeroCarta == 0)
                {

                    // qué pasa si no esta la licencia?
                    // detectar con lectores de codigo de barra

                    ErrHandler2.WriteError("No detectó el numero. Llamo a LeerNumeroDeCartaPorteUsandoCodigoDeBarra");

                    numeroCarta = CartaDePorteManager.LeerNumeroDeCartaPorteUsandoCodigoDeBarra(archivoOriginal, ref sError);

                    ErrHandler2.WriteError("Salgo de LeerNumeroDeCartaPorteUsandoCodigoDeBarra");


                    //Debug.Print("nada documento " + count.ToString() + " " + document.Title);


                }
            }



            if (numeroCarta == 0)
            {

                // por qué no te mandas el lance usando el numero de carta leido en numeros?
                if (NCarta != "")
                {
                    long n = 0;
                    long.TryParse(NCarta.Replace("-", "").Replace(" ", ""), out n);
                    if (n.ToString().Length == 9) numeroCarta = n;
                }
            }


            const long numprefijo = 900000000;
            var rnd = new Random();
            if (numeroCarta == 0)
            {
                numeroCarta = numprefijo + rnd.Next(1, 1000000);
            }
            ///////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////
            /////////////////////// tratando de contrabandear, en la exportacion del excel, el nombre del archivo
            //IField campoAdicional = Sample.AdvancedTechniques.findField(document, "CEE");
            //campoAdicional.Value = numeroCarta.ToString() + " " + archivoOriginal;
            //document.Title = "saasafaf";
            ///////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////



            var o = new ProntoMVC.Data.FuncionesGenericasCSharp.Resultados();

            if (numeroCarta > 0)
            {

                cdp = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon, 0);



                if (cdp.Id == -1)
                {
                    cdp.NumeroCartaDePorte = numeroCarta;
                    cdp.SubnumeroVagon = vagon;

                    cdp.SubnumeroDeFacturacion = 0;
                }


                string s;


                int pv = int.Parse(archivoOriginal.Substring(archivoOriginal.IndexOf(" PV") + 3, 1));

                string nombreusuario = archivoOriginal.Substring(archivoOriginal.IndexOf("Lote") + 16, 20);
                nombreusuario = nombreusuario.Substring(0, nombreusuario.IndexOf(" PV") + 4);



                bool bPisar = false;
                if (cdp.NetoFinalIncluyendoMermas == 0) bPisar = true;





                if (!esTicket && bPisar)
                {

                    cdp.PuntoVenta = pv;



                    //marco la imagen como procesada por la OCR

                    cdp.Titular = CartaDePorteManager.BuscarClientePorCUIT(TitularCUIT, SC, Titular);

                    //s = IntermediarioCUIT.Value.AsString;
                    //FuncionesGenericasCSharp.mkf_validacuit(s);
                    cdp.CuentaOrden1 = CartaDePorteManager.BuscarClientePorCUIT(IntermediarioCUIT, SC, Intermediario);

                    //s = RemitenteCUIT.Value.AsString;
                    //FuncionesGenericasCSharp.mkf_validacuit(s);
                    cdp.CuentaOrden2 = CartaDePorteManager.BuscarClientePorCUIT(RemitenteCUIT, SC, Remitente);

                    //s = CorredorCUIT.Value.AsString;
                    //FuncionesGenericasCSharp.mkf_validacuit(s);
                    cdp.Corredor = CartaDePorteManager.BuscarVendedorPorCUIT(CorredorCUIT, SC, Corredor);

                    //s = DestinatarioCUIT.Value.AsString;
                    //FuncionesGenericasCSharp.mkf_validacuit(s);
                    cdp.Entregador = CartaDePorteManager.BuscarClientePorCUIT(DestinatarioCUIT, SC, Destinatario);



                    cdp.Destino = CartaDePorteManager.BuscarDestinoPorCUIT(DestinoCUIT, SC, Destino, Localidad2);






                    try
                    {
                        cdp.IdTransportista = CartaDePorteManager.BuscarTransportistaPorCUIT(TransportistaCUIT, SC, Transportista);
                        cdp.IdChofer = CartaDePorteManager.BuscarChoferPorCUIT(ChoferCUIT, SC, Chofer);

                        cdp.Acoplado = Acoplado.Replace("-", "").Replace(" ", "");
                        cdp.Patente = Camión.Replace("-", "").Replace(" ", "");
                        if (cdp.Acoplado.Length != 6 && cdp.Acoplado.Length != 7) cdp.Acoplado = "";
                        if (cdp.Patente.Length != 6 && cdp.Patente.Length != 6) cdp.Patente = "";

                        cdp.NetoPto = Conversion.Val(PesoNeto.Replace(".", "").Replace(",", ""));
                        cdp.TaraPto = Conversion.Val(PesoTara.Replace(".", "").Replace(",", ""));
                        cdp.BrutoPto = Conversion.Val(PesoBruto.Replace(".", "").Replace(",", ""));

                        cdp.BrutoFinal = Conversion.Val(PesoBrutoDescarga.Replace(".", "").Replace(",", ""));
                        cdp.TaraFinal = Conversion.Val(PesoTaraDescarga.Replace(".", "").Replace(",", ""));
                        cdp.NetoFinalSinMermas = Conversion.Val(PesoNetoDescarga.Replace(".", "").Replace(",", ""));

                        cdp.NetoFinalIncluyendoMermas = Conversion.Val(PesoNetoFinal.Replace(".", "").Replace(",", ""));





                        cdp.Observaciones = Observaciones;


                        cdp.Contrato = ContratoNro;
                        cdp.KmARecorrer = Conversion.Val(KmARecorrer);

                        cdp.CTG = Convert.ToInt32(Conversion.Val(CTG.Replace(".", "")));
                        cdp.CEE = BarraCEE;










                        ///////////////////////////////////////////////////////////////////
                        ///////////////////////////////////////////////////////////////////
                        Cosecha = Cosecha.Replace("20", "").Replace("-", "/").Replace(" ", "");
                        cdp.Cosecha = "20" + Cosecha;

                        cdp.FechaArribo = DateTime.Today;


                        ///////////////////////////////////////////////////////////////////
                        ///////////////////////////////////////////////////////////////////
                        ///////////////////////////////////////////////////////////////////

                        //tanto le cuesta? sera porque tenes  que pasarlo  a mayuscula?
                        cdp.IdArticulo = SQLdinamico.BuscaIdArticuloPreciso(GranoEspecie, SC);
                        if (cdp.IdArticulo == -1)
                        {
                            GranoEspecie = DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, GranoEspecie.ToUpper());
                            cdp.IdArticulo = SQLdinamico.BuscaIdArticuloPreciso(GranoEspecie, SC);
                        }


                        cdp.Procedencia = SQLdinamico.BuscaIdLocalidadPreciso(Localidad1, SC);
                        if (cdp.Procedencia == -1)
                        {
                            cdp.Procedencia = SQLdinamico.BuscaIdLocalidadAproximado(Localidad1, SC, 7);
                        }



                        cdp.IdEstablecimiento = SQLdinamico.BuscaIdEstablecimientoWilliams(Esablecimiento, SC);
                        if (cdp.IdEstablecimiento == -1)
                        {
                            Esablecimiento = DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, Esablecimiento.ToUpper());
                            cdp.IdEstablecimiento = SQLdinamico.BuscaIdEstablecimientoWilliams(Esablecimiento, SC);
                        }






                        DateTime fecha;
                        DateTime.TryParse(FechaVencimiento, out fecha);
                        cdp.FechaVencimiento = fecha;

                        try
                        {
                            cdp.FechaDeCarga = Convert.ToDateTime(FechaCarga);
                        }
                        catch (Exception ex2)
                        {

                            ErrHandler2.WriteError(ex2);
                        }


                        double.TryParse(Tarifa.Replace(".", ","), out cdp.TarifaTransportista);



                    }
                    catch (Exception ex)
                    {
                        ErrHandler2.WriteError(ex);
                    }
                }
                else if (esTicket)
                {

                    cdp.BrutoFinal = Conversion.Val(PesoBrutoDescarga.Replace(".", "").Replace(",", ""));
                    cdp.TaraFinal = Conversion.Val(PesoTaraDescarga.Replace(".", "").Replace(",", ""));
                    cdp.NetoFinalSinMermas = Conversion.Val(PesoNetoDescarga.Replace(".", "").Replace(",", ""));

                    cdp.NetoFinalIncluyendoMermas = Conversion.Val(PesoNetoFinal.Replace(".", "").Replace(",", ""));


                    cdp.NRecibo = Convert.ToInt32(Conversion.Val(Recibo));

                    cdp.Observaciones = Observaciones;
                    cdp.Humedad = Conversion.Val(HumedadPorc.Replace(".", "").Replace(",", ""));
                    cdp.HumedadDesnormalizada = Conversion.Val(HumedadKilos.Replace(".", "").Replace(",", ""));
                    cdp.CalidadMermaZarandeo = Conversion.Val(ZarandeoPorc.Replace(".", "").Replace(",", ""));
                    cdp.CalidadZarandeoRebaja = Conversion.Val(ZarandeoKilosMerma.Replace(".", "").Replace(",", ""));




                    try
                    {
                        cdp.FechaDescarga = Convert.ToDateTime(FechaDescarga);


                        TimeSpan time;
                        TimeSpan.TryParse(HoraDescarga, out time);
                        cdp.Hora = Convert.ToDateTime(HoraDescarga);  // cdp.FechaDescarga.Add(time);


                    }
                    catch (Exception ex2)
                    {

                        ErrHandler2.WriteError(ex2);
                    }

                    if (cdp.FechaDescarga < cdp.FechaArribo) cdp.FechaArribo = cdp.FechaDescarga;

                }



                if (cdp.NetoFinalIncluyendoMermas > 0)
                {
                    if (cdp.FechaDescarga == DateTime.MinValue)
                    {
                        cdp.NetoFinalIncluyendoMermas = 0;
                    }

                }



                if (cdp.Titular != 0)
                {
                    Debug.Print(cdp.Titular.ToString());

                }



                // qué pasa si no está la licencia del flexicapture?


                bool bCodigoBarrasDetectado = false;
                string ms = "", warn = "";


                ErrHandler2.WriteError("Llamo a IsValid y Save");


                // quizas no era valido y no lo dejó grabar

                int id;
                var valid = CartaDePorteManager.IsValid(SC, ref cdp, ref ms, ref warn);
                if (valid && (numeroCarta >= 10000000 && numeroCarta < 999999999))
                {
                    string err = "";
                    id = CartaDePorteManager.Save(SC, cdp, 0, "", true, ref err);
                    if (numeroCarta > numprefijo)
                    {
                        cdp.MotivoAnulacion = "numero de carta porte en codigo de barra no detectado";
                        CartaDePorteManager.Anular(SC, cdp, 1, "");
                    }
                    else if (cdp.Destino <= 0)
                    {
                        // cdp.MotivoAnulacion = "destino no detectado";
                        // CartaDePorteManager.Anular(SC, cdp, 1, "");
                    }
                }
                else
                {
                    id = cdp.Id;

                }

                //  por qué llegó hasta acá con id=-1? -porque es una carta nueva pero inválida que no se intentó grabar 
                if (id == -1 || id <= 0)
                {
                    Log(ms + " " + warn);
                    Debug.Print(ms + " " + warn);
                }

                MarcarCartaComoProcesada(ref cdp, nombreusuario, SC);



                if ((numeroCarta >= 10000000 && numeroCarta < 999999999))
                {
                    // la imagen tiene que estar ya en el directorio FTP
                    // -se queja porque no encuentra las imagenes del test, usan un directorio distinto que el \databackupear\
                    // - por qué las espera en databackupear en lugar de en el \temp\?
                    // -porque grabarimagen ya sabe a qué carta encajarsela. en temp están las que se tienen que detectar con codigo de barras




                    //y el directorio clasificador?

                    //        string nuevodestino = DirApp + @"\databackupear\" + Path.GetFileName(archivoOriginal);

                    //        try
                    //        {

                    //            File.Copy(archivoOriginal, nuevodestino);
                    //        }
                    //        catch (Exception ex)
                    //        {
                    //            ErrHandler2.WriteError(ex);
                    //            //throw;
                    //        }




                    string nombrenuevo = rnd.Next(1, 99999).ToString().Replace(".", "") + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + "_" + Path.GetFileName(archivoOriginal);




                    nombrenuevo = CartaDePorteManager.CreaDirectorioParaImagenCartaPorte(nombrenuevo, DirApp);


                    string DIRFTP = DirApp + @"\DataBackupear\";
                    string destino = DIRFTP + nombrenuevo;


                    try
                    {
                        FileInfo MyFile1 = new FileInfo(destino);
                        if (MyFile1.Exists) MyFile1.Delete();

                        File.Copy(archivoOriginal, destino);
                    }
                    catch (Exception x)
                    {
                        ErrHandler2.WriteError(x);
                    }


                    //'copio el archivo cambiandole el nombre agregandole un sufijo
                    //'-qué pasa si ya tenía una imagen la carta?
                    //'de todas maneras, se esta copiando dos veces con distinto nombre en el mismo segundo
                    if (false)
                    {
                        try
                        {

                            FileInfo MyFile2 = new FileInfo(archivoOriginal);
                            if (MyFile2.Exists) MyFile2.Delete();

                        }
                        catch (Exception e2)
                        {
                            ErrHandler2.WriteError(e2);
                        }

                    }

                    /*'////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////*/





                    string NombreUsuario = "";
                    EntidadManager.Tarea(SC, "Log_InsertarRegistro", "OCR",
                                                      id, 0, DateTime.Now, 0, nombrenuevo, "", NombreUsuario,
                                                     DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value,
                                                    DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value,
                                                    DBNull.Value, DBNull.Value, DBNull.Value);

                    //'EntidadManager.Tarea(SC, "Log_InsertarRegistro", "ALTAINF",
                    //'                 dr.Item(0), 0, Now, 0, Mid(logtexto, 1, 100),
                    //'               Mid(logtexto, 101, 50), Mid(logtexto, 151, 50), Mid(logtexto, 201, 50),
                    //'               Mid(logtexto, 251, 50), Mid(logtexto, 301, 50), DBNull.Value, DBNull.Value,
                    //'                DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value,
                    //'                99990, DBNull.Value, DBNull.Value)



                    ErrHandler2.WriteError("Llamo a GrabarImagen");

                    //se da cuenta si es un ticket? no lo esta poniendo en 2 posicion?

                    //si es un ticket lo tiene que poner en segunda posicion






                    var cc = CartaDePorteManager.GrabarImagen(id, SC, numeroCarta, vagon, nombrenuevo
                                                  , ref sError, DirApp, bCodigoBarrasDetectado, esTicket);



                    o.IdCarta = id;
                    o.numerocarta = numeroCarta;
                    o.errores = sError + ms;
                    o.advertencias = warn;

                }




            }
            else
            {

                ErrHandler2.WriteError("No se detecto por ningun medio el numero de carta");

            }

            ErrHandler2.WriteError("Archivo " + archivoOriginal + " numcarta " + numeroCarta.ToString());
            Debug.Print("Archivo " + archivoOriginal + " numcarta " + numeroCarta.ToString());



            EntidadManager.LogPronto(SC, o.IdCarta, "OCR", "", "", o.errores, "", int.Parse(o.numerocarta.ToString()), 0, 0);

            //exportar al .bdl

            GuardarLogEnBase(o);


            MarcarImagenComoProcesada(archivoOriginal);

            return o;
        }


        static void GuardarLogEnBase(ProntoMVC.Data.FuncionesGenericasCSharp.Resultados o)
        {

        }


        public static void CreateEmptyFile(string filename)
        {
            try
            {
                File.Create(filename).Dispose();
            }
            catch (Exception)
            {

                throw;
            }
        }



        public static void BuscarLicenciasDisponibles()
        {


            //    engineLoader = Engine.CreateEngineOutprocLoader();
            //    engine = engineLoader.GetEngineObject(null);
            //    licenses = engine.GetAvailableLicenses( [PROJECT ID], null);


        }




        static public void IniciaMotor(ref IEngine engine, ref IEngineLoader engineLoader, ref IFlexiCaptureProcessor processor, string plantilla)
        {

            ///////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////

            // ClassFlexicapture.EngineLoadingMode engineLoadingMode = ClassFlexicapture.EngineLoadingMode.LoadAsWorkprocess;
            ClassFlexicapture.EngineLoadingMode engineLoadingMode = ClassFlexicapture.EngineLoadingMode.LoadDirectlyUseNakedInterfaces;


            ErrHandler2.WriteError("Arranca motor");

            if (engine == null)
                engine = ClassFlexicapture.loadEngine(engineLoadingMode, out engineLoader);


            ErrHandler2.WriteError("Reconoció la licencia");


            processor = engine.CreateFlexiCaptureProcessor();

            IDocumentDefinition newDocumentDefinition = engine.CreateDocumentDefinitionFromAFL(plantilla, "Spanish");

            processor.AddDocumentDefinition(newDocumentDefinition);


            ///////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////


        }


        static public void ActivarMotor(string SC, List<string> archivos, ref string sError, string DirApp, string ConfigurationManager_UsarFlexicapture)
        {

            string e = "";
            List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> resultado;


            if (ConfigurationManager_UsarFlexicapture == "SI")
            {



                // esto esta mal. tiene que usar el path de la aplicacion
                string plantilla = DirApp + @"\Documentos\cartaporte.afl";
                IEngine engine = null;
                IEngineLoader engineLoader = null;
                IFlexiCaptureProcessor processor = null;
                // string plantilla = @"C:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\cartaporte.afl";






                try
                {


                    ///////////////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////////////
                    IniciaMotor(ref engine, ref engineLoader, ref processor, plantilla);
                    ///////////////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////////////





                    resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture(ref engine, ref processor,
                                                    plantilla,
                                                    archivos, SC, DirApp, true, ref e);

                    ErrHandler2.WriteError("Termina motor");

                    ClassFlexicapture.unloadEngine(ref engine, ref engineLoader);

                    ErrHandler2.WriteError("Proceso cerrado");


                }
                catch (Exception ex)
                {
                    ErrHandler2.WriteError(ex.ToString());

                    var listasinpath = new List<string>();
                    foreach (string i in archivos)
                    {
                        listasinpath.Add(Path.GetFileName(i));
                    }
                    resultado = CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, listasinpath, -1, ref sError, DirApp);

                }


            }



            else
            {

                var listasinpath = new List<string>();
                foreach (string i in archivos)
                {
                    listasinpath.Add(Path.GetFileName(i));
                }
                resultado = CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, listasinpath, -1, ref sError, DirApp);

            }


            string html = ClassFlexicapture.GenerarHtmlConResultado(resultado, e);
            sError += ClassFlexicapture.GenerarHtmlConResultado(resultado, e);


            using (FileStream fs = new FileStream(DirApp + @"\Temp\log.html", FileMode.Append, FileAccess.Write))
            using (StreamWriter sw = new StreamWriter(fs))
            {
                sw.WriteLine(html);
            }


        }










        public enum EngineLoadingMode
        {
            LoadDirectlyUseNakedInterfaces,
            LoadAsInprocServer,
            LoadAsWorkprocess
        }

        static EngineLoadingMode engineLoadingMode;


        public static void unloadEngine(ref IEngine engine, ref IEngineLoader engineLoader)
        {
            if (engine != null)
            {
                if (engineLoader == null)
                {
                    int hresult = DeinitializeEngine();
                    Marshal.ThrowExceptionForHR(hresult);
                }
                else
                {
                    engineLoader.Unload();
                    engineLoader = null;
                }
                engine = null;
            }
        }


        public static void Log(string s)
        {

            //string nombre = "ProntoAgente";  // para usar un nombre especifico creo que tenes que declarar un eventsource o permisos administrativos
            string nombre = "Application";
            using (EventLog eventLog = new EventLog(nombre))
            {
                eventLog.Source = nombre;
                eventLog.WriteEntry(s, EventLogEntryType.Information, 101, 1);
            }
        }


        public static IEngine loadEngine(EngineLoadingMode _engineLoadingMode, out IEngineLoader engineLoader)
        {


            /*
             * en la documentacion
             * 
            ABBYY FlexiCapture Engine 11 Guided Tour: Advanced Techniques 
Different Ways to Load the Engine Object
There are three ways to load the Engine object in ABBYY FlexiCapture Engine 11. Each of the loading methods has its own specifics affecting the use of the object in different circumstances. The first two methods are most suitable for use in interactive applications which are not intended for simultaneous processing of multiple requests. The third method is most suitable for server solutions.

Loading FCEngine.dll manually and working with “naked” interfaces
This is the standard method to load the Engine object, which was also used in the previous version of ABBYY FlexiCapture Engine. To get a reference to the Engine object, call the InitializeEngine (InitializeEngineEx) method. This object loading method is described in detail in the Tutorial, Step 1: Load FlexiCapture Engine.

Advantages

Results in maximum performance. 

Does not require registration of FCEngine.dll. 
   Limitations

Imposes restriction on working with multi-threaded applications (see Using ABBYY FlexiCapture Engine in Multi-Threaded Server Applications). 

When working with high-level languages (e.g. .Net), low-level means must be used to load dynamic libraries and to call functions published in them. 
 

Loading the Engine object by means of COM into the current process
The Engine is loaded as an in-process server into the same process where the application is running. The Engine object is loaded using the InprocLoader object, which implements the IEngineLoader interface.

Please note that you must keep the reference to the loader object until you finish working with the Engine. You can then call the Unload method of the loader object to deinitialize the Engine, and then destroy the loader object.

Advantages

All ABBYY FlexiCapture Engine objects are completely thread-safe and can be created and used in different threads. 
When working from the Мain STA apartment, performance is the same as when working with the naked interfaces. When accessing from different threads, some marshalling losses may occur, which are negligible in most scenarios. 
   Limitations

Registration of FCEngine.dll is required when installing the final application on an end user's computer. 
 

 C# code 


IEngineLoader engineLoader = new FCEngine.InprocLoader();
IEngine engine = engineLoader.Load(…);
try {
	…
} finally {
	engineLoader.Unload();
}

 Note: To register FCEngine.dll when installing your application on an end-user computer, use the following command line: regsvr32.exe /s /n /i:"<Path to the Inc folder>" "<Path to the FCEngine.dll>"


Loading the Engine object by means of COM into a separate process
The Engine is loaded as an out-of-process server into a separate process. The Engine object is loaded by means of the OutprocLoader object, which implements a IEngineLoader interface.

Please note that you must keep the reference to the loader object until you finish working with the Engine. You can then call the Unload method of the loader object to deinitialize the Engine, and then destroy the loader object.

Advantages

All ABBYY FlexiCapture Engine objects are completely thread-safe. Each instance of the Engine runs in a separate process parallel to the others. 
A pool of processors can be organized to make full use of the computer's CPU power. 
   Limitations

There are some small marshalling losses. 
Registration of FCEngine.dll is required when installing the final application on an end user's computer. 
When working under accounts with limited permissions, the necessary permissions must be granted. 
It is impossible to access a page image as HBITMAP without marshalling. 
Cannot be used with Visual Components, as they do not work with multiple processes. 
 

 C# code 

IEngineLoader engineLoader = new FCEngine.OutprocLoader();
IEngine engine = engineLoader.Load(…);
try {
	…
} finally {
	engineLoader.Unload();
}

 Note:

Account permissions can be set up using the DCOM Config utility (either type DCOMCNFG in the command line, or select Control Panel > Administrative Tools > Component Services). In the console tree, locate the Component Services > Computers > My Computer > DCOM Config folder, right-click ABBYY FlexiCapture 11 Engine Loader (Local Server), and click Properties. A dialog box will open. Click the Security tab. Under Launch Permissions, click Customize, and then click Edit to specify the accounts that can launch the application.
Note that on a 64-bit operating system the registered DCOM-application is available in the 32-bit MMC console, which can be run using the following command line: "mmc comexp.msc /32" 
To register FCEngine.dll when installing your application on the server, use the following command line: regsvr32.exe /s /n /i:"<Path to the Inc folder>" "<Path to the FCEngine.dll>" 
We recommend that you use a Network license both for debugging of your server application and for running it. 
Additionally you can manage the priority of work processes and control whether their parent process is alive and terminate if it is not. Use the IWorkProcessControl interface.

    */


            engineLoadingMode = _engineLoadingMode;
            int hresult = 0;
            try
            {

                switch (engineLoadingMode)
                {
                    case EngineLoadingMode.LoadDirectlyUseNakedInterfaces:
                        {
                            engineLoader = null; // Not used
                            IEngine engine = null;
                            hresult = InitializeEngine(FceConfig.GetDeveloperSN(), out engine);
                            Marshal.ThrowExceptionForHR(hresult); // por qué está esto? antes tambien pasaba y no me daba cuenta porque la capturaba? -no, lo que pasa es que ahora hresult está viniendo con algo.
                            //assert(engine != null);
                            return engine;


                        }
                    case EngineLoadingMode.LoadAsInprocServer:
                        {
                            engineLoader = new FCEngine.InprocLoader();
                            IEngine engine = engineLoader.Load(FceConfig.GetDeveloperSN(), "");
                            //assert(engine != null);
                            return engine;
                        }
                    case EngineLoadingMode.LoadAsWorkprocess:
                        {
                            engineLoader = new FCEngine.OutprocLoader();
                            IEngine engine = engineLoader.Load(FceConfig.GetDeveloperSN(), "");
                            //assert(engine != null);
                            return engine;
                        }
                }
            }
            catch (Exception)
            {
                /*
                CLASS_E_NOTLICENSED	-2147221230 (&H80040112L)	This copy of ABBYY FineReader Engine is not registered.
                era porque la ip cambió
                    probá hacer "telnet 186.18.248.116 3011" o lo que figure en el LicenseSettings.xml
                 * 190.16.100.211
              * */
                Log(" probá hacer \"telnet 186.18.248.116 3011\" usando la ip del licensesettings.xml . El hresult fue: " + hresult.ToString());
                throw;
            }

            //assert(false);
            engineLoader = null;
            return null;
        }


        [DllImport(FceConfig.DllPath, CharSet = CharSet.Unicode), PreserveSig]
        static extern int InitializeEngine(String devSN, out IEngine engine);

        [DllImport(FceConfig.DllPath, CharSet = CharSet.Unicode), PreserveSig]
        static extern int DeinitializeEngine();




    }









    public class FuncionesCSharpBLL
    {


        public class ret
        {
            public int IdCartasDePorteControlDescarga;
            public int? Destino;
            public DateTime? FechaDescarga;
            public decimal? Total;
            public decimal? TotalDescargaDia;
            public decimal? dif;
            public int? Cartas;
            public List<long?> cuales;
        }


        public static List<ret> InformeControlDiario(string SC)
        {

            DemoProntoEntities db = new DemoProntoEntities(SC);
            List<CartasDePorteControlDescarga> control = (from a in db.CartasDePorteControlDescargas select a).ToList();


            // buscar factura de LDC (id2775) y de ACA (id10)
            var xxx = (from d in control
                       from c in db.CartasDePortes.Where(x => x.FechaDescarga == d.Fecha && x.Destino == d.IdDestino && x.SubnumeroDeFacturacion <= 0).DefaultIfEmpty()
                       group c by new { d.IdCartasDePorteControlDescarga, c.Destino, c.FechaDescarga, d.TotalDescargaDia } into g
                       select new ret
                       {
                           IdCartasDePorteControlDescarga = g.Key.IdCartasDePorteControlDescarga,
                           Destino = g.Key.Destino,
                           FechaDescarga = g.Key.FechaDescarga,
                           Total = g.Sum(x => x.NetoFinal),
                           TotalDescargaDia = g.Key.TotalDescargaDia,
                           dif = g.Key.TotalDescargaDia - g.Sum(x => x.NetoFinal),
                           Cartas = g.Count(),
                           cuales = g.Select(x => x.NumeroCartaDePorte).ToList()
                       }
                      );


            return xxx.ToList();
        }



        public static void ExportToExcelEntityCollection<T>(List<T> list, string path)
        {
            int columnCount = 0;

            DateTime StartTime = DateTime.Now;

            StringBuilder rowData = new StringBuilder();

            PropertyInfo[] properties = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);

            rowData.Append("<Row ss:StyleID=\"s62\">");
            foreach (PropertyInfo p in properties)
            {
                if (p.PropertyType.Name != "EntityCollection`1" && p.PropertyType.Name != "EntityReference`1" && p.PropertyType.Name != p.Name)
                {
                    columnCount++;
                    rowData.Append("<Cell><Data ss:Type=\"String\">" + p.Name + "</Data></Cell>");
                }
                else
                    break;

            }
            rowData.Append("</Row>");

            foreach (T item in list)
            {
                rowData.Append("<Row>");
                for (int x = 0; x < columnCount; x++) //each (PropertyInfo p in properties)
                {
                    object o = properties[x].GetValue(item, null);
                    string value = o == null ? "" : o.ToString();
                    rowData.Append("<Cell><Data ss:Type=\"String\">" + value + "</Data></Cell>");

                }
                rowData.Append("</Row>");
            }

            var sheet = @"<?xml version=""1.0""?>
                    <?mso-application progid=""Excel.Sheet""?>
                    <Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet""
                        xmlns:o=""urn:schemas-microsoft-com:office:office""
                        xmlns:x=""urn:schemas-microsoft-com:office:excel""
                        xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet""
                        xmlns:html=""http://www.w3.org/TR/REC-html40"">
                        <DocumentProperties xmlns=""urn:schemas-microsoft-com:office:office"">
                            <Author>MSADMIN</Author>
                            <LastAuthor>MSADMIN</LastAuthor>
                            <Created>2011-07-12T23:40:11Z</Created>
                            <Company>Microsoft</Company>
                            <Version>12.00</Version>
                        </DocumentProperties>
                        <ExcelWorkbook xmlns=""urn:schemas-microsoft-com:office:excel"">
                            <WindowHeight>6600</WindowHeight>
                            <WindowWidth>12255</WindowWidth>
                            <WindowTopX>0</WindowTopX>
                            <WindowTopY>60</WindowTopY>
                            <ProtectStructure>False</ProtectStructure>
                            <ProtectWindows>False</ProtectWindows>
                        </ExcelWorkbook>
                        <Styles>
                            <Style ss:ID=""Default"" ss:Name=""Normal"">
                                <Alignment ss:Vertical=""Bottom""/>
                                <Borders/>
                                <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""11"" ss:Color=""#000000""/>
                                <Interior/>
                                <NumberFormat/>
                                <Protection/>
                            </Style>
                            <Style ss:ID=""s62"">
                                <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""11"" ss:Color=""#000000""
                                    ss:Bold=""1""/>
                            </Style>
                        </Styles>
                        <Worksheet ss:Name=""Sheet1"">
                            <Table ss:ExpandedColumnCount=""" + (properties.Count() + 1) + @""" ss:ExpandedRowCount=""" + (list.Count() + 1) + @""" x:FullColumns=""1""
                                x:FullRows=""1"" ss:DefaultRowHeight=""15"">
                                " + rowData.ToString() + @"
                            </Table>
                            <WorksheetOptions xmlns=""urn:schemas-microsoft-com:office:excel"">
                                <PageSetup>
                                    <Header x:Margin=""0.3""/>
                                    <Footer x:Margin=""0.3""/>
                                    <PageMargins x:Bottom=""0.75"" x:Left=""0.7"" x:Right=""0.7"" x:Top=""0.75""/>
                                </PageSetup>
                                <Print>
                                    <ValidPrinterInfo/>
                                    <HorizontalResolution>300</HorizontalResolution>
                                    <VerticalResolution>300</VerticalResolution>
                                </Print>
                                <Selected/>
                                <Panes>
                                    <Pane>
                                        <Number>3</Number>
                                        <ActiveCol>2</ActiveCol>
                                    </Pane>
                                </Panes>
                                <ProtectObjects>False</ProtectObjects>
                                <ProtectScenarios>False</ProtectScenarios>
                            </WorksheetOptions>
                        </Worksheet>
                        <Worksheet ss:Name=""Sheet2"">
                            <Table ss:ExpandedColumnCount=""1"" ss:ExpandedRowCount=""1"" x:FullColumns=""1""
                                x:FullRows=""1"" ss:DefaultRowHeight=""15"">
                            </Table>
                            <WorksheetOptions xmlns=""urn:schemas-microsoft-com:office:excel"">
                                <PageSetup>
                                    <Header x:Margin=""0.3""/>
                                    <Footer x:Margin=""0.3""/>
                                    <PageMargins x:Bottom=""0.75"" x:Left=""0.7"" x:Right=""0.7"" x:Top=""0.75""/>
                                </PageSetup>
                                <ProtectObjects>False</ProtectObjects>
                                <ProtectScenarios>False</ProtectScenarios>
                            </WorksheetOptions>
                        </Worksheet>
                        <Worksheet ss:Name=""Sheet3"">
                            <Table ss:ExpandedColumnCount=""1"" ss:ExpandedRowCount=""1"" x:FullColumns=""1""
                                x:FullRows=""1"" ss:DefaultRowHeight=""15"">
                            </Table>
                            <WorksheetOptions xmlns=""urn:schemas-microsoft-com:office:excel"">
                                <PageSetup>
                                    <Header x:Margin=""0.3""/>
                                    <Footer x:Margin=""0.3""/>
                                    <PageMargins x:Bottom=""0.75"" x:Left=""0.7"" x:Right=""0.7"" x:Top=""0.75""/>
                                </PageSetup>
                                <ProtectObjects>False</ProtectObjects>
                                <ProtectScenarios>False</ProtectScenarios>
                            </WorksheetOptions>
                        </Worksheet>
                    </Workbook>";

            System.Diagnostics.Debug.Print(StartTime.ToString() + " - " + DateTime.Now);
            System.Diagnostics.Debug.Print((DateTime.Now - StartTime).ToString());

            if (true)
            {
                File.WriteAllText(path, sheet);
            }
            else
            {
                //string attachment = "attachment; filename=Report.xml";
                //HttpContext.Current.Response.ClearContent();
                //HttpContext.Current.Response.AddHeader("content-disposition", attachment);
                //HttpContext.Current.Response.Write(sheet);
                //HttpContext.Current.Response.ContentType = "application/ms-excel";
                //HttpContext.Current.Response.End();
            }
        }


    }





    public class OpenXMLWindowsApp
    {
        public void UpdateSheet()
        {
            UpdateCell("Chart.xlsx", "20", 2, "B");
            UpdateCell("Chart.xlsx", "80", 3, "B");
            UpdateCell("Chart.xlsx", "80", 2, "C");
            UpdateCell("Chart.xlsx", "20", 3, "C");

            ProcessStartInfo startInfo = new ProcessStartInfo("Chart.xlsx");
            startInfo.WindowStyle = ProcessWindowStyle.Normal;
            Process.Start(startInfo);
        }

        public static void UpdateCell(string docName, string text,
            uint rowIndex, string columnName)
        {
            // Open the document for editing.
            using (SpreadsheetDocument spreadSheet =
                     SpreadsheetDocument.Open(docName, true))
            {
                WorksheetPart worksheetPart =
                      GetWorksheetPartByName(spreadSheet, "Sheet1");

                if (worksheetPart != null)
                {
                    Cell cell = GetCell(worksheetPart.Worksheet,
                                             columnName, rowIndex);

                    cell.CellValue = new CellValue(text);
                    cell.DataType =
                        new EnumValue<CellValues>(CellValues.Number);



                    // Save the worksheet.
                    worksheetPart.Worksheet.Save();
                }
            }

        }

        private static WorksheetPart
             GetWorksheetPartByName(SpreadsheetDocument document,
             string sheetName)
        {
            IEnumerable<Sheet> sheets =
               document.WorkbookPart.Workbook.GetFirstChild<Sheets>().
               Elements<Sheet>().Where(s => s.Name == sheetName);

            if (sheets.Count() == 0)
            {
                // The specified worksheet does not exist.

                return null;
            }

            string relationshipId = sheets.First().Id.Value;
            WorksheetPart worksheetPart = (WorksheetPart)
                 document.WorkbookPart.GetPartById(relationshipId);
            return worksheetPart;

        }

        // Given a worksheet, a column name, and a row index, 
        // gets the cell at the specified column and 
        private static Cell GetCell(Worksheet worksheet,
                  string columnName, uint rowIndex)
        {
            Row row = GetRow(worksheet, rowIndex);

            if (row == null)
                return null;

            return row.Elements<Cell>().Where(c => string.Compare
                   (c.CellReference.Value, columnName +
                   rowIndex, true) == 0).First();
        }


        // Given a worksheet and a row index, return the row.
        private static Row GetRow(Worksheet worksheet, uint rowIndex)
        {
            return worksheet.GetFirstChild<SheetData>().
              Elements<Row>().Where(r => r.RowIndex == rowIndex).First();
        }
    }


    // Custom Image Source ///////////////////////////////////////////////////////////



    class SampleImageSource : IImageSource
    {
        public SampleImageSource()
        {
            imageFileAdapters = new Queue();
        }

        public void AddImageFileByRef(string filePath)
        {
            imageFileAdapters.Enqueue(new ImageFileAdapter(filePath, false));
        }

        public void AddImageFileByValue(string filePath)
        {
            imageFileAdapters.Enqueue(new ImageFileAdapter(filePath, true));
        }

        // IImageSource ///////////////////
        public string GetName() { return "Sample Image Source"; }
        public IFileAdapter GetNextImageFile()
        {
            // If the image source is accessed from multiple threads (as in the Processors Pool
            // sample) this method must be thread-safe. In this sample the lock should be uncommented

            // lock( this ) {
            if (imageFileAdapters.Count > 0)
            {
                return (IFileAdapter)imageFileAdapters.Dequeue();
            }
            return null;
            // }
        }
        public IImage GetNextImage() { return null; } // this sample source does not use this feature

        #region IMPLEMENTATION

        class ImageFileAdapter : IFileAdapter
        {
            public ImageFileAdapter(string _filePath, bool _marshalByValue)
            {
                filePath = _filePath;
                marshalByValue = _marshalByValue;
            }

            // IFileAdapter ////////////////////
            public FileMarshallingTypeEnum GetMarshallingType()
            {
                if (marshalByValue)
                {
                    return FileMarshallingTypeEnum.FMT_MarshalByValue;
                }
                return FileMarshallingTypeEnum.FMT_MarshalByReference;
            }
            public string GetFileReference()
            {
                if (marshalByValue)
                {
                    // When marshalling by value, this method is allowed to return any string (empty string included).
                    // If provided, the string is considered to describe the origin of the file and may be used as
                    // a string in error messages and as part of the image origin info in generated pages. 
                    // These samples are also valid:
                    //		return "";
                    //		return "from: smith@mail.com";

                    // Here we just choose to use the path to the original file
                    return filePath;
                }
                else
                {
                    // When marshalling by reference (which is the recommended method), the returned value
                    // must be a reference which can be resolved by the specified reference manager or
                    // a path in the file system (which is considered as the default reference manager if
                    // none is explicitly set)

                    // These samples may be also valid if the reference manager, capable of resolving
                    // such references is provided:
                    //		return @"http://storage/images?id=123";
                    //		return "1&Jh5K(D:";

                    // In this sample we use the path in the file system
                    return filePath;
                }
            }
            public IReadStream GetFileStream()
            {
                if (marshalByValue)
                {
                    return new ReadStream(filePath);
                }
                else
                {
                    // This method is called only if marshalled by value
                    //assert(false);
                    return null;
                }
            }

            #region IMPLEMENTATION

            class ReadStream : IReadStream
            {
                public ReadStream(string fileName)
                {
                    currentPos = 0;

                    using (FileStream stream = File.Open(fileName, FileMode.Open))
                    {
                        int length = (int)stream.Length;
                        bytes = new byte[length];
                        stream.Read(bytes, 0, length);
                    }
                }

                public int Read(out Array data, int count)
                {
                    if (buf == null || buf.Length < count)
                    {
                        buf = new byte[count];
                    }

                    int readBytes = Math.Min(count, bytes.Length - currentPos);
                    if (readBytes > 0)
                    {
                        Buffer.BlockCopy(bytes, currentPos, buf, 0, readBytes);
                        currentPos += readBytes;
                    }

                    /* 
                     * (!) in .NET Framework below 3.5 you can use the following code
                     */
                    /*int readBytes = 0;
                    for( int i = 0; i < count && currentPos < bytes.Length; i++, currentPos++, readBytes++ ) {
                        buf[i] = bytes[currentPos];
                    }*/

                    data = buf;
                    return readBytes;
                }
                public void Close()
                {
                    bytes = null;
                    buf = null;
                }

                int currentPos = 0;
                byte[] bytes = null;
                byte[] buf = null;
            }

            string filePath;
            bool marshalByValue;

            #endregion
        };

        Queue imageFileAdapters;

        #endregion
    };
}



namespace ExtensionMethods
{
    public static class MyExtensions
    {
        public static string NullStringSafe(this IField ifield)
        {
            try
            {
                if (ifield == null) return "";
                return ifield.Value.AsString;
            }
            catch (Exception)
            {

                return "";
            }

        }

        public static int WordCount(this String str)
        {
            return str.Split(new char[] { ' ', '.', '?' },
                             StringSplitOptions.RemoveEmptyEntries).Length;
        }
    }
}








namespace ServicioCartaPorte
{
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


    public class servi
    {


        public virtual string InformeSituacion_string(int iddestino, DateTime desde, DateTime hasta, string SC)
        {
            string s = "";

            Dictionary<int, int> q = InformeSituacion(iddestino, desde, hasta, SC);


            foreach (var line in q)
            {
                try
                {

                    s += (line.Key == null ? "SIN ASIGNAR" : ExcelImportadorManager.Situaciones[line.Key]) + " " + line.Value + "\n";
                }
                catch (Exception)
                {

                    //throw;
                }
            }

            return s;

        }




        public virtual string InformeSituacion_html(int iddestino, DateTime desde, DateTime hasta, string SC)
        {
            string html = "";

            Dictionary<int, int> q = InformeSituacion(iddestino, desde, hasta, SC);

            if (q.Count() == 0) return "Sin Datos";


            //Public Shared Situaciones() As String = {"Autorizado", "Demorado", "Posicion", "Descargado", "A Descargar", "Rechazado", "Desviado", "CP p/cambiar", "Sin Cupo"}

            string titulo = " <table cellpadding=15 style=\"text-align: center; font-size: large; width: 1100px;height: 400px;\"> <tr> " +
                        "   <td style=\"color: blue;\"> Posición </td>" +
                        "   <td style=\"color: red\">Demorado</td>" +
                        "    <td style=\"color: green\"> Autorizado</td>" +
                        "  <td style=\"color: yellow\">A Descargar</td>" +
                        "    <td style=\"color: cyan\"> Descargado</td>" +
                        "    <td style=\"color: orange\"> Rechazado</td>" +
                        "    <td style=\"color: pink\">Desviado</td>" +
                        "  <td style=\"color: black\">  CP p/cambiar</td>" +
                        "    <td style=\"color: white\">Sin Cupo</td>" +
                        "    <td style=\"color: white\">Total</td>" +
                        "</tr> ";


            decimal unidad = (decimal)(q.Values.Max()) / 10;
            var uni = new decimal[10];

            for (int n = 0; n < 10; n++)
            {
                int myValue;
                if (q.TryGetValue(n, out myValue))
                {
                    uni[n] = myValue / unidad;
                }
            }

            titulo += " <tr> " +
                    "   <td style=\"color: blue;\">  " + Convert.ToInt16(uni[2] * unidad).ToString() + "</td>" +
                    "   <td style=\"color: red\">  " + Convert.ToInt16(uni[1] * unidad).ToString() + "</td>" +
                    "   <td style=\"color: green\">  " + Convert.ToInt16(uni[0] * unidad).ToString() + "</td>" +
                    "   <td style=\"color: yellow\">  " + Convert.ToInt16(uni[4] * unidad).ToString() + "</td>" +
                    "   <td style=\"color: cyan\"> " + Convert.ToInt16(uni[3] * unidad).ToString() + "</td>" +
                    "   <td style=\"color: orange\"> " + Convert.ToInt16(uni[5] * unidad).ToString() + "</td>" +
                    "   <td style=\"color: pink\"> " + Convert.ToInt16(uni[6] * unidad).ToString() + "</td>" +
                    "   <td style=\"color: black\"> " + Convert.ToInt16(uni[7] * unidad).ToString() + "</td>" +
                    "   <td style=\"color: white\"> " + Convert.ToInt16(uni[8] * unidad).ToString() + "</td>" +
                    "   <td style=\"color: white\"> " + q.Values.Sum().ToString() + "</td>" +
                    "</tr> ";




            html += titulo;


            string icono = @"<span class=""glyphicon glyphicon-bed"" aria-hidden=""true"" style=""font-size: 2em;""></span>";


            for (int n = 1; n < 10; n++)
            {
                string renglon = " <tr> " +
                            "   <td style=\"color: blue;\">  " + ((uni[2] > n) ? icono : "") + "</td>" +
                            "   <td style=\"color: red\">  " + ((uni[1] > n) ? icono : "") + "</td>" +
                            "   <td style=\"color: green\">  " + ((uni[0] > n) ? icono : "") + "</td>" +
                            "   <td style=\"color: yellow\">  " + ((uni[4] > n) ? icono : "") + "</td>" +
                            "   <td style=\"color: cyan\"> " + ((uni[3] > n) ? icono : "") + "</td>" +
                            "   <td style=\"color: orange\"> " + ((uni[5] > n) ? icono : "") + "</td>" +
                            "   <td style=\"color: pink\"> " + ((uni[6] > n) ? icono : "") + "</td>" +
                            "   <td style=\"color: black\"> " + ((uni[7] > n) ? icono : "") + "</td>" +
                            "   <td style=\"color: white\"> " + ((uni[8] > n) ? icono : "") + "</td>" +
                            "</tr> ";

                html += renglon;
            }

            html += "</table>";

            return html;

        }




        public class situacion
        {
            public int sit;
            public int cant;
        }


        public virtual Dictionary<int, int> InformeSituacion(int iddestino, DateTime desde, DateTime hasta, string SC)
        {



            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);


            List<situacion> q2 = db.fSQL_GetDataTableFiltradoYPaginado(
                                                    0, 9999999, 0, "", -1, -1,
                                                    -1, -1, -1, -1, -1,
                                                    iddestino, 0, "Ambas"
                                                    , desde, hasta,
                                                    0, null, false, "", "",
                                                    -1, null, 0, "", "Todos").Select(x => x.Situacion ?? -1).GroupBy(x => x)
                                                    .Select(g => new situacion { sit = g.Key, cant = g.Count() }).ToList();

            Dictionary<int, int> q = q2.ToDictionary(g => g.sit, g => g.cant);




            return q;

        }










        public virtual string CartasPorte_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal, int puntovent, int iddestino, string SC, string nombreusuario)
        {

            // An ASHX is a generic HttpHandler. An ASMX file is a web service. ASHX is a good lean way to provide a response to AJAX calls, but if you want to provide a response which changes based on conditions (such as variable inputs) it can become a bit of a handful - lots of if else etc. ASMX can house mulitple methods which can take parameters.

            //string SC;
            //if (System.Diagnostics.Debugger.IsAttached)
            //    SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["scLocal"]);
            //else
            //    SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["scWilliamsRelease"]);



            //var usuario = Membership.GetUser();
            System.Data.DataTable dt = EntidadManager.ExecDinamico(SC, "Empleados_TX_UsuarioNT '" + nombreusuario + "'");
            int idUsuario = Convert.ToInt32(dt.Rows[0][0]);
            // int puntovent = EmpleadoManager.GetItem(SC, idUsuario).PuntoVentaAsociado;


            DateTime FechaDesde = new DateTime(1980, 1, 1);
            DateTime FechaHasta = new DateTime(2050, 1, 1);

            try
            {

                FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            }
            catch (Exception e)
            {
                //throw;
            }

            try
            {
                FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);

            }
            catch (Exception e)
            {
                //throw;

            }





            ProntoMVC.Data.Models.DemoProntoEntities db =
                               new ProntoMVC.Data.Models.DemoProntoEntities(
                                   Auxiliares.FormatearConexParaEntityFramework(
                                   ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)));


            db.Database.CommandTimeout = 240;

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;


            var pagedQuery = Filtrador.Filters.FiltroGenerico_UsandoIQueryable<ProntoMVC.Data.Models.fSQL_GetDataTableFiltradoYPaginado_Result3>
                            (sidx, sord, page, rows, _search, filters, db, ref totalRecords,
                                         db.fSQL_GetDataTableFiltradoYPaginado(
                                                            0, 9999999, 0, "", -1, -1,
                                                            -1, -1, -1, -1, -1,
                                                            iddestino, 0, "Ambas", FechaDesde,
                                                            FechaHasta, puntovent, null,false, "", "",
                                                            -1, null, 0, "", "Todos")
                             );

            //db.CartasDePortes
            //                              .Where(x =>
            //                                      (x.FechaDescarga >= FechaDesde && x.FechaDescarga <= FechaHasta)
            //                                       &&
            //                                      (x.PuntoVenta == puntovent || puntovent <= 0)
            //                                       &&
            //                                      (x.Destino == iddestino || iddestino <= 0)
            //                                   )






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
                            id = a.IdCartaDePorte.ToString(),
                            cell = new string[] {
                                "", //"<a href="+ Url.Action("Edit",new {id = a.IdPedido} ) + "  >Editar</>" ,
                                
                                a.IdCartaDePorte.ToString(),

                                "<a href=\"CartaDePorte.aspx?Id=" +  a.IdCartaDePorte + "\">" +  a.NumeroCartaEnTextoParaBusqueda.NullSafeToString() + "</>" ,

                                (a.Situacion ?? 0).NullSafeToString(),
                                //((a.Situacion ?? 0) >= 0)  ?  ExcelImportadorManager.Situaciones[a.Situacion ?? 0] : "",

                                a.ObservacionesSituacion,

                                a.FechaArribo==null ? "" :  a.FechaArribo.GetValueOrDefault().ToShortDateString(),


                                a.FechaDescarga==null ? "" :  a.FechaDescarga.GetValueOrDefault().ToShortDateString(),

                                 a.CorredorDesc,
                                 a.DestinatarioDesc,
                                 a.DestinoDesc.ToString(),
                                 a.Destino ==null ? "" : a.Destino.ToString(),
                                 a.ProcedenciaDesc.ToString(),

                                 a.Producto.ToString(),
                                 a.TitularDesc,
                                 a.RComercialDesc,
                                 a.IntermediarioDesc,
                                 a.Patente,

                                 a.NetoProc.ToString(),


                                 a.PuntoVenta.ToString(),

                                 a.FechaActualizacionAutomatica==null ? "" :  a.FechaActualizacionAutomatica.GetValueOrDefault().ToShortDateString()
                                   

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
            System.Web.Script.Serialization.JavaScriptSerializer jsonSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            return jsonSerializer.Serialize(jsonData);


        }



        public virtual string CartasPorte_DynamicGridData_ExcelExportacion_UsandoInternalQuery(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal, int puntovent, int iddestino, string SC, string nombreusuario)
        {
            //asdad

            // la idea seria llamar a la funcion filtrador pero sin paginar, o diciendolo de
            // otro modo, pasandole como maxrows un numero grandisimo
            // http://stackoverflow.com/questions/8227898/export-jqgrid-filtered-data-as-excel-or-csv
            // I would recommend you to implement export of data on the server and just post the current searching filter to the back-end. Full information about the searching parameter defines postData parameter of jqGrid. Another boolean parameter of jqGrid search define whether the searching filter should be applied of not. You should better ignore _search property of postData parameter and use search parameter of jqGrid.

            // http://stackoverflow.com/questions/9339792/jqgrid-ef-mvc-how-to-export-in-excel-which-method-you-suggest?noredirect=1&lq=1







            //var usuario = Membership.GetUser();
            System.Data.DataTable dt = EntidadManager.ExecDinamico(SC, "Empleados_TX_UsuarioNT '" + nombreusuario + "'");
            int idUsuario = Convert.ToInt32(dt.Rows[0][0]);
            // int puntovent = EmpleadoManager.GetItem(SC, idUsuario).PuntoVentaAsociado;


            DateTime FechaDesde = new DateTime(1980, 1, 1);
            DateTime FechaHasta = new DateTime(2050, 1, 1);

            try
            {

                FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            }
            catch (Exception e)
            {
                // throw;
            }

            try
            {
                FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);

            }
            catch (Exception e)
            {
                // throw;

            }





            ProntoMVC.Data.Models.DemoProntoEntities db =
                               new ProntoMVC.Data.Models.DemoProntoEntities(
                                   Auxiliares.FormatearConexParaEntityFramework(
                                   ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)));


            db.Database.CommandTimeout = 240;

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalrecords = 0;


            //var pagedQuery = Filtrador.Filters.FiltroGenerico_UsandoIQueryable<ProntoMVC.Data.Models.fSQL_GetDataTableFiltradoYPaginado_Result3>
            //                (sidx, sord, page, rows, _search, filters, db, ref totalRecords,
            //                             db.fSQL_GetDataTableFiltradoYPaginado(
            //                                                0, 9999999, 0, "", -1, -1,
            //                                                -1, -1, -1, -1, -1,
            //                                                -1, 0, "Ambas", FechaDesde,
            //                                                FechaHasta, puntovent, null, "", "",
            //                                                -1, null, 0, "", "Todos")
            //                 );







            //string result2 = CartasPorte_DynamicGridData(sidx, sord, 1, 200000, _search, filters, FechaInicial, FechaFinal, puntovent, iddestino, SC, nombreusuario);


            string sqlquery4 = Filtrador.Filters.FiltroGenerico_UsandoIQueryable_DevolverInternalQuery<ProntoMVC.Data.Models.fSQL_GetDataTableFiltradoYPaginado_Result3>
                                    (
                                                            "IdCartaDePorte", "desc", 1, 999999, true, filters, db, ref totalrecords,

                                                            db.fSQL_GetDataTableFiltradoYPaginado(
                                                            0, 9999999, 0, "", -1, -1,
                                                            -1, -1, -1, -1, -1,
                                                          iddestino, 0, "Ambas"
                                                           , FechaDesde, FechaHasta,
                                                           0, null, false, "", "",
                                                           -1, null, 0, "", "Todos")
                                    );


            return sqlquery4;

        }


        public virtual string CartasPorte_DynamicGridData_ExcelExportacion(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal, int puntovent, int iddestino, string SC, string nombreusuario)
        {
            //asdad

            // la idea seria llamar a la funcion filtrador pero sin paginar, o diciendolo de
            // otro modo, pasandole como maxrows un numero grandisimo
            // http://stackoverflow.com/questions/8227898/export-jqgrid-filtered-data-as-excel-or-csv
            // I would recommend you to implement export of data on the server and just post the current searching filter to the back-end. Full information about the searching parameter defines postData parameter of jqGrid. Another boolean parameter of jqGrid search define whether the searching filter should be applied of not. You should better ignore _search property of postData parameter and use search parameter of jqGrid.

            // http://stackoverflow.com/questions/9339792/jqgrid-ef-mvc-how-to-export-in-excel-which-method-you-suggest?noredirect=1&lq=1







            //var usuario = Membership.GetUser();
            System.Data.DataTable dt = EntidadManager.ExecDinamico(SC, "Empleados_TX_UsuarioNT '" + nombreusuario + "'");
            int idUsuario = Convert.ToInt32(dt.Rows[0][0]);
            // int puntovent = EmpleadoManager.GetItem(SC, idUsuario).PuntoVentaAsociado;


            DateTime FechaDesde = new DateTime(1980, 1, 1);
            DateTime FechaHasta = new DateTime(2050, 1, 1);

            try
            {

                FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            }
            catch (Exception e)
            {
                throw;
            }

            try
            {
                FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);

            }
            catch (Exception e)
            {
                throw;

            }





            ProntoMVC.Data.Models.DemoProntoEntities db =
                               new ProntoMVC.Data.Models.DemoProntoEntities(
                                   Auxiliares.FormatearConexParaEntityFramework(
                                   ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)));


            db.Database.CommandTimeout = 240;

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;


            //var pagedQuery = Filtrador.Filters.FiltroGenerico_UsandoIQueryable<ProntoMVC.Data.Models.fSQL_GetDataTableFiltradoYPaginado_Result3>
            //                (sidx, sord, page, rows, _search, filters, db, ref totalRecords,
            //                             db.fSQL_GetDataTableFiltradoYPaginado(
            //                                                0, 9999999, 0, "", -1, -1,
            //                                                -1, -1, -1, -1, -1,
            //                                                -1, 0, "Ambas", FechaDesde,
            //                                                FechaHasta, puntovent, null, "", "",
            //                                                -1, null, 0, "", "Todos")
            //                 );







            //System.Web.Mvc.JsonResult result;

            //result = (System.Web.Mvc.JsonResult)CartasPorte_DynamicGridData(sidx, sord, page, rows, _search, filters, "", "", puntovent, iddestino, SC, nombreusuario);
            string result2 = CartasPorte_DynamicGridData(sidx, sord, 1, 200000, _search, filters, FechaInicial, FechaFinal, puntovent, iddestino, SC, nombreusuario);

            System.Web.Script.Serialization.JavaScriptSerializer jsonSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            //result = jsonSerializer.Deserialize<jqGridJson>(result2);


            string output = Path.GetTempPath() + "Listado " + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls";

            List<string[]> lista = new List<string[]>();

            // jqGridJson listado = (jqGridJson) result.Data;
            jqGridJson listado = jsonSerializer.Deserialize<jqGridJson>(result2);

            for (int n = 0; n < listado.rows.Count(); n++)
            {
                string[] renglon = listado.rows[n].cell;
                lista.Add(renglon);
            }



            var excelData = new jqGridWeb.DataForExcel(
                    // column Header
                    new[] { "Col1", "Col2", "Col3" },
                    new[]{jqGridWeb.DataForExcel.DataType.String, jqGridWeb.DataForExcel.DataType.Integer,
                          jqGridWeb.DataForExcel.DataType.String},
                    //      new List<string[]> {
                    //    new[] {"a", "1", "c1"},
                    //    new[] {"a", "2", "c2"}
                    //},
                    lista,

                    "Test Grid");


            Stream stream = new FileStream(output, FileMode.Create);
            excelData.CreateXlsxAndFillData(stream);
            stream.Close();


            //PreFormatear();
            //abrir con eeplus y poner autowidth?

            return output;


            byte[] contents = System.IO.File.ReadAllBytes(output);
            //return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "output.xls");

        }




    }
}

