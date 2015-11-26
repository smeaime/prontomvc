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




namespace ProntoFlexicapture
{
    public class ClassFlexicapture  // :  Sample.FlexiCaptureEngineSnippets
    {

        public static void ProcesarUnaCartaConFlexicapture(IEngine engine, string plantilla, string imagen, string SC)
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

                IField TitularCUIT = Sample.AdvancedTechniques.findField(document, "TitularCUIT");
                IField BarraCP = Sample.AdvancedTechniques.findField(document, "BarraCP");
                IField BarraCEE = Sample.AdvancedTechniques.findField(document, "BarraCEE");
                IField NumeroCarta = Sample.AdvancedTechniques.findField(document, "NumeroCarta");
                IField CEE = Sample.AdvancedTechniques.findField(document, "CEE");

                if (NumeroCarta.Value.AsString != "" || BarraCP.Value.AsString != "")
                {
                    Debug.Print(NumeroCarta.Value.AsString + " " + BarraCP.Value.AsString);


                    long numeroCarta = BarraCP.Value.AsInteger;
                    int vagon = 0;

                    Pronto.ERP.BO.CartaDePorte cdp = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon, -1);
                    if (cdp.Id == -1)
                    {
                        cdp.NumeroCartaDePorte = numeroCarta;
                        cdp.SubnumeroVagon = vagon;

                        cdp.SubnumeroDeFacturacion = -1;
                    }

                    cdp.Titular = BuscarClientePorCUIT(TitularCUIT.Value.AsString, SC);


                    string nombrenuevo = "", sError = "";
                    bool bCodigoBarrasDetectado = false;
                    string ms = "", warn = "";
                    var valid = CartaDePorteManager.IsValid(SC, cdp, ref ms, ref warn);
                    var id = CartaDePorteManager.Save(SC, cdp, 0, "");
                    var s = CartaDePorteManager.GrabarImagen(id, SC, numeroCarta, vagon,
                                                nombrenuevo, ref sError, "", bCodigoBarrasDetectado);



                }

                else
                {
                    Debug.Print("nada documento ");

                }


            }


        }



        // USE CASE: Using a custom image source with FlexiCapture processor
        public static void ProcesarCartasConFlexicapture(IEngine engine, string plantilla, List<string> imagenes, string SC)
        {
            // string SamplesFolder = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos";


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

                else
                {

                    IField TitularCUIT = Sample.AdvancedTechniques.findField(document, "TitularCUIT");
                    IField BarraCP = Sample.AdvancedTechniques.findField(document, "BarraCP");
                    IField BarraCEE = Sample.AdvancedTechniques.findField(document, "BarraCEE");
                    IField NumeroCarta = Sample.AdvancedTechniques.findField(document, "NumeroCarta");
                    IField CEE = Sample.AdvancedTechniques.findField(document, "CEE");




                    long numeroCarta;
                    int vagon = 0;
                    string sError="";

                    if (BarraCP.Value.AsString != "")
                    {
                        Debug.Print(NumeroCarta.Value.AsString + " " + BarraCP.Value.AsString);


                        numeroCarta = BarraCP.Value.AsInteger;



                   }

                    else
                    {

                        // detectar con lectores de codigo de barra


                        numeroCarta = CartaDePorteManager.LeerNumeroDeCartaPorteUsandoCodigoDeBarra(imagenes[count], ref sError);



                        Debug.Print("nada documento " + count.ToString() + " " + document.Title);

                    }







                    Pronto.ERP.BO.CartaDePorte cdp = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon, -1);
                    if (cdp.Id == -1)
                    {
                        cdp.NumeroCartaDePorte = numeroCarta;
                        cdp.SubnumeroVagon = vagon;

                        cdp.SubnumeroDeFacturacion = -1;
                    }


                    cdp.Titular = BuscarClientePorCUIT(TitularCUIT.Value.AsString, SC);

                    string nombrenuevo = "";
                    bool bCodigoBarrasDetectado = false;
                    string ms = "", warn = "";
                    var valid = CartaDePorteManager.IsValid(SC, cdp, ref ms, ref warn);
                    var id = CartaDePorteManager.Save(SC, cdp, 0, "");
                    var s = CartaDePorteManager.GrabarImagen(id, SC, numeroCarta, vagon,
                                                nombrenuevo, ref sError, "", bCodigoBarrasDetectado);



                }


                count++;
            }
            //traceEnd("OK");

            //trace("Check the results...");
            //assert(count == 4);
        }


        static int BuscarClientePorCUIT(string cuit, string SC)
        {
            return -1;
        }


        public enum EngineLoadingMode
        {
            LoadDirectlyUseNakedInterfaces,
            LoadAsInprocServer,
            LoadAsWorkprocess
        }

        static EngineLoadingMode engineLoadingMode;


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



        class FceConfig
        {
            // full path to FCE dll
            public const string DllPath = "C:\\Program Files (x86)\\ABBYY SDK\\11\\FlexiCapture Engine\\Bin\\FCEngine.dll";

            // Return full path to FCE dll
            public static string GetDllPath()
            {
                return "C:\\Program Files (x86)\\ABBYY SDK\\11\\FlexiCapture Engine\\Bin\\FCEngine.dll";
            }

            // Return developer serial number for FCE
            public static string GetDeveloperSN()
            {
                return "SWTT11020005644444371584";
            }

            // Return full path to Samples directory
            public static string GetSamplesFolder()
            {
                return "C:\\ProgramData\\ABBYY\\SDK\\11\\FlexiCapture Engine\\Samples";
            }

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
