using System;
using System.Collections;
using System.IO;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Drawing;
using System.Drawing.Imaging;

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



        public static List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(
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

            return ProcesarCartasBatchConFlexicapture(ref engine, ref  processor, plantilla, Lista, SC, DirApp, bProcesar, ref sError);
            //si no esta la licencia, recibe la excepcion 

        }




        // USE CASE: Using a custom image source with FlexiCapture processor
        public static List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> ProcesarCartasBatchConFlexicapture(ref IEngine engine,
                                                    ref  IFlexiCaptureProcessor processor,
                                                    string plantilla,
                                                   List<string> imagenes, string SC, string DirApp, bool bProcesar, ref string sError)
        {


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






            //processor.AddDocumentDefinitionFile(SamplesFolder + "\\cartaporte.fcdot");

            //trace("Set up a custom image source...");
            // Create and configure sample image source (see SampleImageSource class for details)
            SampleImageSource imageSource = new SampleImageSource();
            // The sample image source will use these files by reference:
            foreach (string s in imagenes)
            {
                imageSource.AddImageFileByRef(s);
                MarcarImagenComoProcesandose(s);
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
            catch (Exception)
            {
                //tirar la Lista de imagenes sospechosas
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

                //trace("Recognize next document...");
                IDocument document = processor.RecognizeNextDocument(); // si no esta la licencia, acá explota




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





        public static IQueryable<ProntoMVC.Data.Models.CartasDePorte> ExtraerListaDeImagenesIrreconocibles(string DirApp, string SC)
        {
            string dir = DirApp + @"\Temp\";
            DirectoryInfo d = new DirectoryInfo(dir);//Assuming Test is your Folder
            FileInfo[] files = d.GetFiles("*.*", SearchOption.AllDirectories); //Getting Text files


            ProntoMVC.Data.Models.DemoProntoEntities db =
                    new DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)));

            IQueryable<ProntoMVC.Data.Models.CartasDePorte> q2 = (from ProntoMVC.Data.Models.CartasDePorte i in db.CartasDePortes
                                                                  where i.NumeroCartaDePorte >= 900000000
                                                                  orderby i.FechaModificacion descending
                                                                  select i).AsQueryable();

            IQueryable<procesGrilla> q = (from f in files
                                          where (EsArchivoDeImagen(f.Name)
                                                 &&
                                                 (files.Where(x => x.Name == (f.Name + ".bdl")).FirstOrDefault() ?? f).LastWriteTime <= f.LastWriteTime
                                          )
                                          orderby f.LastWriteTime descending
                                          select new procesGrilla() { nombreImagen = "" }).AsQueryable();



            return q2;
            //sacar info del log o de los archivos????
        }



        public static List<string> BuscarExcelsGenerados(string DirApp)
        {

            string dir = DirApp + @"\Temp\";
            var l = new List<string>();

            DirectoryInfo d = new DirectoryInfo(dir);//Assuming Test is your Folder
            FileInfo[] files = d.GetFiles("Export*.xls", SearchOption.AllDirectories); //Getting Text files
            // http://stackoverflow.com/questions/12332451/list-all-files-and-directories-in-a-directory-subdirectories


            //foreach (FileInfo file in Files)
            //{
            //    l.Add(file.Name);
            //}


            //var files = Directory.EnumerateFiles(dir, "*.*", SearchOption.AllDirectories).OrderByDescending(x=>x.last)
            //                    .Where(s => s.EndsWith(".tif") || s.EndsWith(".tiff")  || s.EndsWith(".jpg"));


            var q = (from f in files
                     orderby f.LastWriteTime descending
                     select f.FullName);


            return q.ToList();

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


        public static List<string> ExtraerListaDeImagenesQueNoHanSidoProcesadas(int cuantas, string DirApp)
        {

            string dir = DirApp + @"\Temp\";
            var l = new List<string>();

            DirectoryInfo d = new DirectoryInfo(dir);//Assuming Test is your Folder
            FileInfo[] files = d.GetFiles("*.*", SearchOption.AllDirectories); //Getting Text files
            // http://stackoverflow.com/questions/12332451/list-all-files-and-directories-in-a-directory-subdirectories


            //foreach (FileInfo file in Files)
            //{
            //    l.Add(file.Name);
            //}


            //var files = Directory.EnumerateFiles(dir, "*.*", SearchOption.AllDirectories).OrderByDescending(x=>x.last)
            //                    .Where(s => s.EndsWith(".tif") || s.EndsWith(".tiff")  || s.EndsWith(".jpg"));

            // (files.Where(x => x.Name == (f.Name + ".bdl")).FirstOrDefault() ?? f).LastWriteTime <= f.LastWriteTime

            var q = (from f in files
                     where (EsArchivoDeImagen(f.Name)
                            &&
                            !files.Any(x => x.FullName == (f.FullName + ".bdl"))
                     )
                     orderby f.LastWriteTime ascending
                     select f.FullName).Take(cuantas);



            return q.ToList();

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



        static int DesmarcarImagenComoProcesandose(string archivo)
        {
            //y si creo un archivo con extension?

            CartaDePorteManager.BorroArchivo(archivo + ".bdl");

            return 0;

        }

        static int MarcarImagenComoProcesandose(string archivo)
        {
            //y si creo un archivo con extension?

            CreateEmptyFile(archivo + ".bdl");

            return 0;

        }


        static int MarcarImagenComoProcesada(string archivo)
        {
            return 0;

        }


        public static void MarcarCartaComoProcesada(ref Pronto.ERP.BO.CartaDePorte cdp)
        {

            cdp.CalidadTierra = -1;


            //cdp.Corredor2
            //  cdp.

        }


        public static List<ProntoMVC.Data.Models.CartasDePorte> ExtraerListaDeImagenesProcesadas(string DirApp, string SC)
        {
            string dir = DirApp + @"\Temp\";
            DirectoryInfo d = new DirectoryInfo(dir);//Assuming Test is your Folder
            FileInfo[] files = d.GetFiles("*.*", SearchOption.AllDirectories); //Getting Text files


            ProntoMVC.Data.Models.DemoProntoEntities db =
                    new DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)));


            // where (i.PathImagen != "" || i.PathImagen2 != "")

            List<ProntoMVC.Data.Models.CartasDePorte> q = (from ProntoMVC.Data.Models.CartasDePorte i in db.CartasDePortes
                                                           where (i.CalidadTierra == -1)
                                                           orderby i.FechaModificacion descending
                                                           select i).Take(100).ToList();

            //List<ProntoMVC.Data.Models.CartasDePorte> q = (from ProntoMVC.Data.Models.CartasDePorte i in db.CartasDePortes select i).Take(10).ToList();



            // como me traigo la info de las id, etc?


            return q;
            //sacar info del log o de los archivos????
        }





        public static bool bEstaLaLicenciadelFlexicapture()
        {

            return true;

        }






        public static List<string> PreprocesarImagenesTiff(string archivo, bool bEsFormatoCPTK, bool bGirar180grados)
        {

            if (!Path.GetExtension(archivo).ToLower().Contains("tif"))
                return null;

            if (bGirar180grados) MarcarImagenComoProcesandose(archivo); // me anticipo para que no lo tome el servicio mientras creo los tiff individuales

            List<System.Drawing.Image> listapaginas = ProntoMVC.Data.FuncionesGenericasCSharp.GetAllPages(archivo);


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

                for (n = 0; n <= listapaginas.Count - 1; n += 2)
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


            CartaDePorteManager.BorroArchivo(archivo);

            return l;

        }


        public static List<string> PreprocesarArchivoSubido(string zipFile, string nombreusuario, string DirApp, bool bEsFormatoCPTK, bool bGirar180grados)
        {

            string DIRTEMP = DirApp + @"\Temp\";
            string nuevosubdir = DIRTEMP + CartaDePorteManager.CrearDirectorioParaLoteImagenes(DirApp, nombreusuario);
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
                MarcarImagenComoProcesandose(f);
            }

            foreach (string f in l)
            {
                ext = PreprocesarImagenesTiff(f, bEsFormatoCPTK, bGirar180grados);

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
                    DesmarcarImagenComoProcesandose(f);
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
            string Observaciones = Sample.AdvancedTechniques.findField(document, "Observaciones").NullStringSafe();
            string Esablecimiento = Sample.AdvancedTechniques.findField(document, "Esablecimiento").NullStringSafe();
            string Direccion1 = Sample.AdvancedTechniques.findField(document, "Direccion1").NullStringSafe();
            string Localidad1 = Sample.AdvancedTechniques.findField(document, "Localidad1").NullStringSafe();
            string Direccion2 = Sample.AdvancedTechniques.findField(document, "Direccion2").NullStringSafe();
            string Provincia2 = Sample.AdvancedTechniques.findField(document, "Provincia2").NullStringSafe();
            string Camión = Sample.AdvancedTechniques.findField(document, "Camión").NullStringSafe();
            string Acoplado = Sample.AdvancedTechniques.findField(document, "Acoplado").NullStringSafe();
            string KmARecorrer = Sample.AdvancedTechniques.findField(document, "KmARecorrer").NullStringSafe();
            string Tarifa = Sample.AdvancedTechniques.findField(document, "Tarifa").NullStringSafe();
            string TarifaRef = Sample.AdvancedTechniques.findField(document, "TarifaRef").NullStringSafe();
            string PesoBrutoDescarga = Sample.AdvancedTechniques.findField(document, "PesoBrutoDescarga").NullStringSafe();

            string Cosecha = Sample.AdvancedTechniques.findField(document, "Cosecha").NullStringSafe();


            string GranoEspecie = Sample.AdvancedTechniques.findField(document, "GranoEspecie").NullStringSafe();





            ErrHandler2.WriteError("Procesó carta: titular " + Titular);


            long numeroCarta = 0;
            int vagon = 0;
            string sError = "";



            // if (BarraCP.Value.AsString != ""   )


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


            if (numeroCarta == 0)
            {

                // por qué no te mandas el lance usando el numero de carta leido en numeros?
                if (NCarta != "")
                {
                    long n = 0;
                    long.TryParse(NCarta.Replace(" ", ""), out n);
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

                MarcarCartaComoProcesada(ref cdp);

                bool bPisar = true;

                // if (cdp.Titular > 0) bPisar = false;

                // no pisar si ya esta la info
                if (bPisar)
                {

                    cdp.PuntoVenta = 1;



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


                    cdp.Destino = CartaDePorteManager.BuscarDestinoPorCUIT(DestinoCUIT, SC, Destino);






                    try
                    {
                        cdp.IdTransportista = CartaDePorteManager.BuscarTransportistaPorCUIT(TransportistaCUIT, SC, Transportista);
                        cdp.IdChofer = CartaDePorteManager.BuscarChoferPorCUIT(ChoferCUIT, SC, Chofer);

                        cdp.Acoplado = Acoplado;
                        cdp.Patente = Camión;
                        cdp.NetoPto = Conversion.Val(PesoNeto.Replace(".", "").Replace(",", ""));
                        cdp.TaraPto = Conversion.Val(PesoTara.Replace(".", "").Replace(",", ""));
                        cdp.BrutoPto = Conversion.Val(PesoBruto.Replace(".", "").Replace(",", ""));
                        cdp.BrutoFinal = Conversion.Val(PesoBrutoDescarga.Replace(".", "").Replace(",", ""));
                        cdp.Observaciones = Observaciones;


                        cdp.Contrato = ContratoNro;
                        cdp.KmARecorrer = Conversion.Val(KmARecorrer);

                        cdp.CTG = Convert.ToInt32(Conversion.Val(CTG));
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
                            Localidad1 = DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, Localidad1.ToUpper());
                            cdp.Procedencia = SQLdinamico.BuscaIdLocalidadPreciso(Localidad1, SC);
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

                        double.TryParse(Tarifa, out cdp.TarifaTransportista);



                    }
                    catch (Exception ex)
                    {
                        ErrHandler2.WriteError(ex);
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
                    id = CartaDePorteManager.Save(SC, cdp, 0, "");
                    cdp.MotivoAnulacion = "numero de carta porte en codigo de barra no detectado";
                    if (numeroCarta > numprefijo) CartaDePorteManager.Anular(SC, cdp, 1, "");
                }
                else
                {
                    id = cdp.Id;

                }



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








                    ErrHandler2.WriteError("Llamo a GrabarImagen");

                    //se da cuenta si es un ticket? no lo esta poniendo en 2 posicion?

                    var cc = CartaDePorteManager.GrabarImagen(id, SC, numeroCarta, vagon, nombrenuevo
                                                  , ref sError, DirApp, bCodigoBarrasDetectado);



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




        static public void IniciaMotor(ref IEngine engine, ref  IEngineLoader engineLoader, ref  IFlexiCaptureProcessor processor, string plantilla)
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
                    IniciaMotor(ref engine, ref  engineLoader, ref  processor, plantilla);
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

            using (EventLog eventLog = new EventLog("Application"))
            {
                eventLog.Source = "Application";
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
                Log(" probá hacer \"telnet 186.18.248.116 3011\". El hresult fue: " + hresult.ToString());
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




