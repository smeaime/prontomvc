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

namespace ProntoFlexicapture
{
    public class ClassFlexicapture  // :  Sample.FlexiCaptureEngineSnippets
    {

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




        public static List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(IEngine engine, string plantilla,
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
            //    ErrHandler.WriteError(ex)
            //End Try

            return ProcesarCartasBatchConFlexicapture(engine, plantilla, Lista, SC, DirApp, bProcesar, ref sError);

        }




        // USE CASE: Using a custom image source with FlexiCapture processor
        public static List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> ProcesarCartasBatchConFlexicapture(IEngine engine, string plantilla,
                                                   List<string> imagenes, string SC, string DirApp, bool bProcesar, ref string sError)
        {



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



            ErrHandler.WriteError("Cargo la plantilla");

            // string SamplesFolder = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos";

            List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> r = new List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados>();

            //trace("Create an instance of FlexiCapture processor...");
            IFlexiCaptureProcessor processor = engine.CreateFlexiCaptureProcessor();

            //trace("Add required Document Definitions...");

            //como hago para usar la exportacion del flexilayout .afl

            //IDocumentDefinition newDocumentDefinition = engine.CreateDocumentDefinitionFromAFL(SamplesFolder + "\\cartaporte.afl", "Spanish");
            IDocumentDefinition newDocumentDefinition = engine.CreateDocumentDefinitionFromAFL(plantilla, "Spanish");

            processor.AddDocumentDefinition(newDocumentDefinition);
            //processor.AddDocumentDefinitionFile(SamplesFolder + "\\cartaporte.fcdot");

            //trace("Set up a custom image source...");
            // Create and configure sample image source (see SampleImageSource class for details)
            SampleImageSource imageSource = new SampleImageSource();
            // The sample image source will use these files by reference:
            foreach (string s in imagenes)
            {
                imageSource.AddImageFileByRef(s);
            }
            //imageSource.AddImageFileByRef(SamplesFolder + "\\SampleImages\\ZXING BIEN 545459461 (300dpi).jpg");
            //imageSource.AddImageFileByRef(SamplesFolder + "\\SampleImages\\Invoices_2.tif");
            //imageSource.AddImageFileByRef(SamplesFolder + "\\SampleImages\\Invoices_3.tif");
            //// ... these files by value (files in memory):
            //imageSource.AddImageFileByValue(SamplesFolder + "\\SampleImages\\Invoices_1.tif");
            //imageSource.AddImageFileByValue(SamplesFolder + "\\SampleImages\\Invoices_2.tif");
            //imageSource.AddImageFileByValue(SamplesFolder + "\\SampleImages\\Invoices_3.tif");
            // Configure the processor to use the new image source
            processor.SetCustomImageSource(imageSource);

            //traceBegin("Run processing loop...");
            int count = 0;
            while (true)
            {
                Pronto.ERP.Bll.ErrHandler2.WriteError("reconocer imagen");

                //trace("Recognize next document...");
                IDocument document = processor.RecognizeNextDocument();
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


                if (false)
                {
                    //    processor.ExportDocumentEx(document, SamplesFolder + "\\FCEExport", "NextDocument_" + count, null);
                }

                else if (bProcesar)
                {
                    try
                    {
                        r.Add(ProcesaCarta(document, SC, imagenes[count], DirApp));

                    }
                    catch (Exception x)
                    {
                        Debug.Print(x.ToString());
                        // throw;
                    }


                }

                count++;
            }
            //traceEnd("OK");

            //trace("Check the results...");
            //assert(count == 4);
            return r;
        }





        public static string GenerarHtmlConResultado(List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> l, string err)
        {
            if (err != "") return err;

            string stodo = "";

            foreach (ProntoMVC.Data.FuncionesGenericasCSharp.Resultados x in l)
            {
                string sError = "";

                sError = "<a href=\"CartaDePorte.aspx?Id=" + x.IdCarta + "\" target=\"_blank\">" + "Carta " + x.numerocarta + "   " + x.errores + "   " + x.advertencias + "</a>;  <br/> ";  // & oCarta.NumeroCartaDePorte & "/" & oCarta.SubnumeroVagon & "</a>;  <br/> "

                stodo += sError;
            }
            return stodo;
        }


        static List<string> ExtraerListaDeImagenesQueNoHanSidoProcesadas(int cuantas, string DirApp)
        {

            string dir = DirApp + @"\Temp\";
            var l = new List<string>();

            DirectoryInfo d = new DirectoryInfo(dir);//Assuming Test is your Folder
            FileInfo[] files = d.GetFiles("*.*"); //Getting Text files

            //foreach (FileInfo file in Files)
            //{
            //    l.Add(file.Name);
            //}


            //var files = Directory.EnumerateFiles(dir, "*.*", SearchOption.AllDirectories).OrderByDescending(x=>x.last)
            //                    .Where(s => s.EndsWith(".tif") || s.EndsWith(".tiff")  || s.EndsWith(".jpg"));


            var q = (from f in files
                     where ((f.Name.EndsWith(".tif") || f.Name.EndsWith(".tiff") || f.Name.EndsWith(".jpg"))
                            &&
                            (files.Where(x => x.Name == (f.Name + ".bdl")).FirstOrDefault() ?? f).LastWriteTime <= f.LastWriteTime
                     )
                     orderby f.LastWriteTime descending
                     select f.FullName).Take(cuantas);


            return q.ToList();

        }


        public static bool bEstaLaLicenciadelFlexicapture()
        {
            return true;

        }










        static ProntoMVC.Data.FuncionesGenericasCSharp.Resultados ProcesaCarta(IDocument document, string SC, string archivoOriginal, string DirApp)
        {


            IField BarraCP = Sample.AdvancedTechniques.findField(document, "BarraCP");
            IField BarraCEE = Sample.AdvancedTechniques.findField(document, "BarraCEE");
            IField NCarta = Sample.AdvancedTechniques.findField(document, "NumeroCarta");
            IField CEE = Sample.AdvancedTechniques.findField(document, "CEE");


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


            ErrHandler.WriteError("Procesó carta: titular " + Titular);


            long numeroCarta;
            int vagon = 0;
            string sError = "";



            // if (BarraCP.Value.AsString != ""   )

            if (long.TryParse(BarraCP.Value.AsString, out numeroCarta))
            {
                //Debug.Print(NCarta.Value.AsString + " " + BarraCP.Value.AsString);
                // numeroCarta = Convert.ToInt64(BarraCP.Value.AsString);

                ErrHandler.WriteError("Detectó bien el numero con el Flexicapture: " + numeroCarta.ToString());

            }

            else
            {

                // qué pasa si no esta la licencia?
                // detectar con lectores de codigo de barra

                ErrHandler.WriteError("No detectó el numero. Llamo a LeerNumeroDeCartaPorteUsandoCodigoDeBarra");

                numeroCarta = CartaDePorteManager.LeerNumeroDeCartaPorteUsandoCodigoDeBarra(archivoOriginal, ref sError);

                ErrHandler.WriteError("Salgo de LeerNumeroDeCartaPorteUsandoCodigoDeBarra");


                //Debug.Print("nada documento " + count.ToString() + " " + document.Title);

            }



            var o = new ProntoMVC.Data.FuncionesGenericasCSharp.Resultados();

            if (numeroCarta > 0)
            {
                Pronto.ERP.BO.CartaDePorte cdp = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon, 0);
                if (cdp.Id == -1)
                {
                    cdp.NumeroCartaDePorte = numeroCarta;
                    cdp.SubnumeroVagon = vagon;

                    cdp.SubnumeroDeFacturacion = 0;
                }


                string s;

                cdp.Titular = CartaDePorteManager.BuscarClientePorCUIT(TitularCUIT, SC, Titular);

                //s = IntermediarioCUIT.Value.AsString;
                //FuncionesGenericasCSharp.mkf_validacuit(s);
                cdp.CuentaOrden1 = CartaDePorteManager.BuscarClientePorCUIT(IntermediarioCUIT, SC, Intermediario);

                //s = RemitenteCUIT.Value.AsString;
                //FuncionesGenericasCSharp.mkf_validacuit(s);
                cdp.CuentaOrden2 = CartaDePorteManager.BuscarClientePorCUIT(RemitenteCUIT, SC, Remitente);

                //s = CorredorCUIT.Value.AsString;
                //FuncionesGenericasCSharp.mkf_validacuit(s);
                cdp.Corredor = CartaDePorteManager.BuscarClientePorCUIT(CorredorCUIT, SC, Corredor);

                //s = DestinatarioCUIT.Value.AsString;
                //FuncionesGenericasCSharp.mkf_validacuit(s);
                cdp.Entregador = CartaDePorteManager.BuscarClientePorCUIT(DestinatarioCUIT, SC, Destinatario);



                if (cdp.Titular != 0)
                {
                    Debug.Print(cdp.Titular.ToString());

                }



                // qué pasa si no está la licencia del flexicapture?


                bool bCodigoBarrasDetectado = false;
                string ms = "", warn = "";


                ErrHandler.WriteError("Llamo a IsValid y Save");

                var valid = CartaDePorteManager.IsValid(SC, ref cdp, ref ms, ref warn);
                if (valid)
                {
                    var id = CartaDePorteManager.Save(SC, cdp, 0, "");

                    if (true)
                    {
                        // la imagen tiene que estar ya en el directorio FTP
                        // -se queja porque no encuentra las imagenes del test, usan un directorio distinto que el \databackupear\
                        // - por qué las espera en databackupear en lugar de en el \temp\?
                        // -porque grabarimagen ya sabe a qué carta encajarsela. en temp están las que se tienen que detectar con codigo de barras

                        string nuevodestino = DirApp + @"\databackupear\" + Path.GetFileName(archivoOriginal);

                        try
                        {

                            File.Copy(archivoOriginal, nuevodestino);
                        }
                        catch (Exception)
                        {

                            //throw;
                        }


                        ErrHandler.WriteError("Llamo a GrabarImagen");

                        var x = CartaDePorteManager.GrabarImagen(id, SC, numeroCarta, vagon, Path.GetFileName(nuevodestino)
                                                      , ref sError, DirApp, bCodigoBarrasDetectado);

                    }


                    o.IdCarta = id;
                    o.numerocarta = numeroCarta;
                    o.errores = sError + ms;
                    o.advertencias = warn;
                }


            }


            ErrHandler.WriteError("Archivo " + archivoOriginal + " numcarta " + numeroCarta.ToString());
            Debug.Print("Archivo " + archivoOriginal + " numcarta " + numeroCarta.ToString());

            GuardarLogEnBase(o);


            MarcarImagenComoProcesada(archivoOriginal);

            return o;
        }


        static void GuardarLogEnBase(ProntoMVC.Data.FuncionesGenericasCSharp.Resultados o)
        {

        }

        static int MarcarImagenComoProcesada(string archivo)
        {
            //y si creo un archivo con extension?

            CreateEmptyFile(archivo + ".bdl");

            return 0;

        }

        public static void CreateEmptyFile(string filename)
        {
            File.Create(filename).Dispose();
        }



        public static void BuscarLicenciasDisponibles()
        {


            //    engineLoader = Engine.CreateEngineOutprocLoader();
            //    engine = engineLoader.GetEngineObject(null);
            //    licenses = engine.GetAvailableLicenses( [PROJECT ID], null);


        }





        static public void ActivarMotor(string SC, List<string> archivos, ref string sError, string DirApp)
        {
            IEngine engine;
            IEngineLoader engineLoader;

            ClassFlexicapture.EngineLoadingMode engineLoadingMode = ClassFlexicapture.EngineLoadingMode.LoadAsWorkprocess;

            
                // esto esta mal. tiene que usar el path de la aplicacion
            string plantilla = DirApp  + @"\Documentos\cartaporte.afl";
                         // string plantilla = @"C:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\cartaporte.afl";
            





            string e = "";
            List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> resultado;

            try
            {
                ErrHandler.WriteError("Arranca motor");

                engine = ClassFlexicapture.loadEngine(engineLoadingMode, out engineLoader);

                ErrHandler.WriteError("Reconoció la licencia");

                resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture(engine,
                                                plantilla,
                                                archivos, SC, DirApp, true, ref e);

                ErrHandler.WriteError("Termina motor");

                ClassFlexicapture.unloadEngine(ref engine, ref engineLoader);

                ErrHandler.WriteError("Proceso cerrado");


            }
            catch (Exception ex)
            {
                ErrHandler.WriteError(ex.ToString());

                var listasinpath = new List<string>();
                foreach (string i in archivos)
                {
                    listasinpath.Add(Path.GetFileName(i));
                }
                resultado = CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, listasinpath, -1, ref sError, DirApp);

            }




            sError += ClassFlexicapture.GenerarHtmlConResultado(resultado, e);



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


        public static IEngine loadEngine(EngineLoadingMode _engineLoadingMode, out IEngineLoader engineLoader)
        {
            engineLoadingMode = _engineLoadingMode;
            switch (engineLoadingMode)
            {
                case EngineLoadingMode.LoadDirectlyUseNakedInterfaces:
                    {
                        engineLoader = null; // Not used
                        IEngine engine = null;
                        int hresult = InitializeEngine(FceConfig.GetDeveloperSN(), out engine);
                        Marshal.ThrowExceptionForHR(hresult);
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
            //assert(false);
            engineLoader = null;
            return null;
        }


        [DllImport(FceConfig.DllPath, CharSet = CharSet.Unicode), PreserveSig]
        static extern int InitializeEngine(String devSN, out IEngine engine);

        [DllImport(FceConfig.DllPath, CharSet = CharSet.Unicode), PreserveSig]
        static extern int DeinitializeEngine();

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
