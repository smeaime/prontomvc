using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Reflection;
using System.Data;
using System.IO;




using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;

using OpenXmlPowerTools;

using System.Xml.Linq;


using System.Xml;

/// <summary>
/// Summary description for Class1
/// </summary>


using System.Collections.Generic;
using System.Linq;
using System.Text;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;
using A = DocumentFormat.OpenXml.Drawing;
using Pic = DocumentFormat.OpenXml.Drawing.Pictures;



using System;
using System.IO;
using System.Threading;
//using System.Web.Mvc;



// http://stackoverflow.com/questions/247666/how-can-i-programatically-use-c-sharp-to-append-multiple-docx-files-together
namespace OfficeMergeControl
{
    public class CombineDocs
    {
        public byte[] OpenAndCombine(IList<byte[]> documents)
        {
            MemoryStream mainStream = new MemoryStream();

            mainStream.Write(documents[0], 0, documents[0].Length); // pone en mainstream al primer documento
            mainStream.Position = 0;

            int pointer = 1;
            byte[] ret;
            try
            {
                using (WordprocessingDocument mainDocument = WordprocessingDocument.Open(mainStream, true)) // abre maindocument, usando el mainstream que solo tiene el primer documento
                {

                    XElement newBody = XElement.Parse(mainDocument.MainDocumentPart.Document.Body.OuterXml);

                    newBody.Add(XElement.Parse(new Paragraph(new Run(new Break { Type = BreakValues.Page })).OuterXml));
                    //CartaDePorteManager.AppendPageBreak(mainDocument);



                    for (pointer = 1; pointer < documents.Count; pointer++) // itera a partir del SEGUNDO documento, así que el AppendPageBreak hay que ponerlo en algun lugar estrategico
                    {
                        WordprocessingDocument tempDocument = WordprocessingDocument.Open(new MemoryStream(documents[pointer]), true);
                        //WordprocessingDocument tempDocument = WordprocessingDocument.Open(new MemoryStream(), true); //no fijo el tamaño del stream para poder usar el htmlconverter
                        XElement tempBody = XElement.Parse(tempDocument.MainDocumentPart.Document.Body.OuterXml);



                        

                        if (false)
                        {//metodo 1
                            //CartaDePorteManager.AppendPageBreak(mainDocument);
                            // este metodo no me repite el pie, pero hace necesito hacer el salto de pagina sobre maindocument, y necesito hacerlo sobre tempdocument
                        }
                        else
                        {
                            // salto de pagina (salvo la ultima
                            if (pointer < documents.Count - 1)
                            {
                                // http://stackoverflow.com/questions/247666/how-can-i-programatically-use-c-sharp-to-append-multiple-docx-files-together
                                // el mismo flaco de la funcion pone como comentario lo del salto de pagina
                                // yo tuve que hacer cambios porque no andaba. le puse el salto a la primera pagina explicitamente, y despues a todo el resto a traves de tempbody, salvo la ultima pagina

                                tempBody.Add(XElement.Parse(new Paragraph(new Run(new Break { Type = BreakValues.Page })).OuterXml));

                                // http://stackoverflow.com/questions/11176771/openxml-joining-word-documents-with-different-footers
                                //CartaDePorteManager.AppendPageBreak(tempDocument);




                            }

                        }


                       
                        newBody.Add(tempBody);


                        





                        // esta  es la linea que ensarta el nuevo documento en la cola de documentos, así que el AppendPageBreak iría antes...
                        mainDocument.MainDocumentPart.Document.Body = new Body(newBody.ToString());



                        var a = new CopyFooterImage();
                        a.CopyFooter(tempDocument.MainDocumentPart.FooterParts.First());
                        a.CopyFooterHandler(mainDocument);


                        mainDocument.MainDocumentPart.Document.Save();
                        mainDocument.Package.Flush( );
                    }


                    
                    


                          


                }




            }
            catch (OpenXmlPackageException oxmle)
            {
                throw;
                // throw new OfficeMergeControlException(string.Format(CultureInfo.CurrentCulture, "Error while merging files. Document index {0}", pointer), oxmle);
            }
            catch (Exception e)
            {
                throw;
                //throw new OfficeMergeControlException(string.Format(CultureInfo.CurrentCulture, "Error while merging files. Document index {0}", pointer), e);
            }
            finally
            {
                ret = mainStream.ToArray();
                mainStream.Close();
                mainStream.Dispose();
            }
            return (ret);
        }














        static void GenerateFooterPartContent(FooterPart part)
        {
            Footer footer1 = new Footer() { MCAttributes = new MarkupCompatibilityAttributes() { Ignorable = "w14 wp14" } };
            //footer1.AddNamespaceDeclaration("wpc", "http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas");
            //footer1.AddNamespaceDeclaration("mc", "http://schemas.openxmlformats.org/markup-compatibility/2006");
            //footer1.AddNamespaceDeclaration("o", "urn:schemas-microsoft-com:office:office");
            //footer1.AddNamespaceDeclaration("r", "http://schemas.openxmlformats.org/officeDocument/2006/relationships");
            //footer1.AddNamespaceDeclaration("m", "http://schemas.openxmlformats.org/officeDocument/2006/math");
            //footer1.AddNamespaceDeclaration("v", "urn:schemas-microsoft-com:vml");
            //footer1.AddNamespaceDeclaration("wp14", "http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing");
            //footer1.AddNamespaceDeclaration("wp", "http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing");
            //footer1.AddNamespaceDeclaration("w10", "urn:schemas-microsoft-com:office:word");
            //footer1.AddNamespaceDeclaration("w", "http://schemas.openxmlformats.org/wordprocessingml/2006/main");
            //footer1.AddNamespaceDeclaration("w14", "http://schemas.microsoft.com/office/word/2010/wordml");
            //footer1.AddNamespaceDeclaration("wpg", "http://schemas.microsoft.com/office/word/2010/wordprocessingGroup");
            //footer1.AddNamespaceDeclaration("wpi", "http://schemas.microsoft.com/office/word/2010/wordprocessingInk");
            //footer1.AddNamespaceDeclaration("wne", "http://schemas.microsoft.com/office/word/2006/wordml");
            //footer1.AddNamespaceDeclaration("wps", "http://schemas.microsoft.com/office/word/2010/wordprocessingShape");

            Paragraph paragraph1 = new Paragraph() { RsidParagraphAddition = "00164C17", RsidRunAdditionDefault = "00164C17" };

            ParagraphProperties paragraphProperties1 = new ParagraphProperties();
            ParagraphStyleId paragraphStyleId1 = new ParagraphStyleId() { Val = "Footer" };

            paragraphProperties1.Append(paragraphStyleId1);

            Run run1 = new Run();
            Text text1 = new Text();
            text1.Text = "Footer";

            run1.Append(text1);

            paragraph1.Append(paragraphProperties1);
            paragraph1.Append(run1);

            footer1.Append(paragraph1);

            part.Footer = footer1;
        }







        public byte[] CreateDocument(IList<byte[]> documentsToMerge)
        {
            // http://stackoverflow.com/a/12089639/1054200
            List<Source> documentBuilderSources = new List<Source>();
            foreach (byte[] documentByteArray in documentsToMerge)
            {
                documentBuilderSources.Add(new Source(new WmlDocument(string.Empty, documentByteArray), false));
            }

            WmlDocument mergedDocument = DocumentBuilder.BuildDocument(documentBuilderSources);
            return mergedDocument.DocumentByteArray;
        }

        //public byte[] CreateDocument(IList<System.Windows.do DocumentSection> documentTemplates)
        //{
        //    // http://stackoverflow.com/a/12089639/1054200

        //    List<Source> documentBuilderSources = new List<Source>();
        //    foreach (DocumentSection documentTemplate in documentTemplates.OrderBy(dt => dt.Rank))
        //    {
        //        // Take the template replace the items and then push it into the chunk
        //        using (MemoryStream templateStream = new MemoryStream())
        //        {
        //            templateStream.Write(documentTemplate.Template, 0, documentTemplate.Template.Length);

        //            this.ProcessOpenXMLDocument(templateStream, documentTemplate.Fields);

        //            documentBuilderSources.Add(new Source(new WmlDocument(string.Empty, templateStream.ToArray()), false));
        //        }
        //    }

        //    WmlDocument mergedDocument = DocumentBuilder.BuildDocument(documentBuilderSources);
        //    return mergedDocument.DocumentByteArray;
        //}








    }
}





    // http://social.msdn.microsoft.com/Forums/office/en-US/7e34c135-361a-44cb-a9df-e6246f6ca781/copy-header-with-image-from-a-docx-file-to-another-using-open-xml-and-c?forum=oxmlsdk

    public class CopyHeaderImage //: WordprocessingDocumentUtil
    {
        private HeaderPart _Header = null;
        private ImagePart _Image = null;

        public void Action()
        {
            //OpenedDocumentHander(ReadHeaderImage);
        }

        public bool ReadHeaderImage(WordprocessingDocument WPD)
        {
            bool result = false;
            MainDocumentPart MDP = WPD.MainDocumentPart;
            Document D = MDP.Document;
            SectionProperties SPS = D.Descendants<SectionProperties>()
                .FirstOrDefault();
            HeaderReference HR = SPS.Descendants<HeaderReference>()
                .Where(H => H.Type == HeaderFooterValues.Default)
                .FirstOrDefault();
            HeaderPart HP = MDP.GetPartById(HR.Id) as HeaderPart;
            _Image = HP.ImageParts.FirstOrDefault();
            CopyHeader(HP);
            return result;
        }

        private void CopyHeader(HeaderPart HP)
        {
            _Header = HP;
            //OpenedDocumentHander(CopyHeaderHandler, true);
        }

        public bool CopyHeaderHandler(WordprocessingDocument WPD)
        {
            bool result = false;
            MainDocumentPart MDP = WPD.MainDocumentPart;
            Document D = MDP.Document;
            SectionProperties SPS = D.Descendants<SectionProperties>()
                .FirstOrDefault();
            HeaderReference HR = SPS.Descendants<HeaderReference>()
                .Where(H => H.Type == HeaderFooterValues.Default)
                .FirstOrDefault();
            if (HR != null)
            {
                HeaderPart older = MDP.GetPartById(HR.Id) as HeaderPart;
                MDP.DeletePart(older);
                NewHeader(MDP, HR);
            }
            else
            {
                HR = new HeaderReference()
                {
                    Type = HeaderFooterValues.Default,
                    Id = string.Empty
                };
                NewHeader(MDP, HR);
                SPS.Append(HR);
            }
            D.Save();
            return result;
        }

        public void NewHeader(MainDocumentPart MDP, HeaderReference HR)
        {
            HeaderPart newHeader = MDP.AddNewPart<HeaderPart>();
            if (_Header != null && _Image != null)
            {
                newHeader.FeedData(_Header.GetStream());
                ImagePart imagePart = newHeader.AddImagePart(ImagePartType.Png);
                imagePart.FeedData(_Image.GetStream());
                string ImageId = newHeader.GetIdOfPart(imagePart);
                Header H = newHeader.Header;
                Paragraph P = H.Descendants<Paragraph>().FirstOrDefault();
                Run R = P.Descendants<Run>().First();
                Drawing D = R.Descendants<Drawing>().First();
                A.GraphicData GD = D.Inline.Graphic.GraphicData;
                Pic.Picture Pic = GD.Descendants<Pic.Picture>()
                    .FirstOrDefault();
                Pic.BlipFill BF = Pic.Descendants<Pic.BlipFill>()
                    .FirstOrDefault();
                BF.Blip.Embed = ImageId;
                HR.Id = MDP.GetIdOfPart(newHeader);
            }
            else
            {
         //       SetLog("_Header wasn't set", OXULogType.FATAL);
            }
        }
    }


    public class CopyFooterImage //: WordprocessingDocumentUtil
    {
        private FooterPart _Footer = null;
        private ImagePart _Image = null;

        public void Action()
        {
            //OpenedDocumentHander(ReadFooterImage);
        }

        public bool ReadFooterImage(WordprocessingDocument WPD)
        {
            bool result = false;
            MainDocumentPart MDP = WPD.MainDocumentPart;
            Document D = MDP.Document;
            SectionProperties SPS = D.Descendants<SectionProperties>()
                .FirstOrDefault();
            FooterReference HR = SPS.Descendants<FooterReference>()
                .Where(H => H.Type == HeaderFooterValues.Default)
                .FirstOrDefault();
            FooterPart HP = MDP.GetPartById(HR.Id) as FooterPart;
            _Image = HP.ImageParts.FirstOrDefault();
            CopyFooter(HP);
            return result;
        }

        public void  CopyFooter(FooterPart HP)
        {
            _Footer = HP;
            //OpenedDocumentHander(CopyFooterHandler, true);
        }

        public bool CopyFooterHandler(WordprocessingDocument WPD)
        {
            bool result = false;
            MainDocumentPart MDP = WPD.MainDocumentPart;
            Document D = MDP.Document;
            SectionProperties SPS = D.Descendants<SectionProperties>()
                .FirstOrDefault();
            FooterReference HR = SPS.Descendants<FooterReference>()
                .Where(H => H.Type   == HeaderFooterValues.Default)
                .FirstOrDefault();
            if (HR != null)
            {
                FooterPart older = MDP.GetPartById(HR.Id) as FooterPart;
                MDP.DeletePart(older);
                NewFooter(MDP, HR);
            }
            else
            {
                HR = new FooterReference()
                {
                    Type = HeaderFooterValues.Default,
                    Id = string.Empty
                };
                NewFooter(MDP, HR);
                SPS.Append(HR);
            }
            D.Save();
            return result;
        }

        public void NewFooter(MainDocumentPart MDP, FooterReference HR)
        {
            FooterPart newFooter = MDP.AddNewPart<FooterPart>();
            if (_Footer != null) // && _Image != null)
            {
                newFooter.FeedData(_Footer.GetStream());
                
                //ImagePart imagePart = newFooter.AddImagePart(ImagePartType.Png);
                //imagePart.FeedData(_Image.GetStream());
                //string ImageId = newFooter.GetIdOfPart(imagePart);
                                
                Footer H = newFooter.Footer;
                Paragraph P = H.Descendants<Paragraph>().FirstOrDefault();
                Run R = P.Descendants<Run>().First();
                
                //Drawing D = R.Descendants<Drawing>().First();
                //A.GraphicData GD = D.Inline.Graphic.GraphicData;
                //Pic.Picture Pic = GD.Descendants<Pic.Picture>()
                //    .FirstOrDefault();
                //Pic.BlipFill BF = Pic.Descendants<Pic.BlipFill>()
                //    .FirstOrDefault();
                //BF.Blip.Embed = ImageId;
                HR.Id = MDP.GetIdOfPart(newFooter);
            }
            else
            {
                //       SetLog("_Header wasn't set", OXULogType.FATAL);
            }
        }







        // usar DocX ???? http://docx.codeplex.com/SourceControl/list/changesets

        public static void documentsMerge(object fileName, List<string> arrayList)
        {




            //bool varTest = Novacode..deleteFile(fileName.ToString());
            if (true)
            {
                using (Novacode.DocX documentToCreate = Novacode.DocX.Load(arrayList[0]))
                {


                    foreach (var alItem in arrayList.Skip(1))
                    {
                        documentToCreate.InsertParagraph().InsertPageBreakAfterSelf();
                        Novacode.DocX documentToMergeIn = Novacode.DocX.Load(alItem);
                        documentToCreate.InsertDocument(documentToMergeIn);
                    }
                    documentToCreate.SaveAs(fileName.ToString());
                }
            }
        }

    
    }













////http://stackoverflow.com/questions/14076855/how-to-limit-bandwidth-and-allow-multiple-downloads-when-downloading-a-file

//namespace Mvc3Test
//{
//    public class FileThrottleResult : FilePathResult
//    {
//        float rate = 0;

//        /// <summary>
//        /// 
//        /// </summary>
//        /// <param name="fileStream"></param>
//        /// <param name="contentType"></param>
//        /// <param name="rate">Kbps</param>
//        public FileThrottleResult(string fileName, string contentType, float rate)
//            : base(fileName, contentType)
//        {
//            if (!File.Exists(fileName))
//            {
//                throw new ArgumentNullException("fileName");
//            }

//            this.rate = rate;
//        }

//        protected override void WriteFile(System.Web.HttpResponseBase response)
//        {
//            int _bufferSize = (int)Math.Round(1024 * this.rate);
//            byte[] buffer = new byte[_bufferSize];

//            Stream outputStream = response.OutputStream;

//            using (var stream = File.OpenRead(FileName))
//            {
//                response.AddHeader("Cache-control", "private");
//                response.AddHeader("Content-Type", "application/octet-stream");
//                response.AddHeader("Content-Length", stream.Length.ToString());
//                response.AddHeader("Content-Disposition", String.Format("filename={0}", new FileInfo(FileName).Name));
//                response.Flush();


//                while (true)
//                {
//                    if (!response.IsClientConnected)
//                        break;

//                    int bytesRead = stream.Read(buffer, 0, _bufferSize);

//                    if (bytesRead == 0)
//                        break;

//                    outputStream.Write(buffer, 0, bytesRead);
//                    response.Flush();
//                    Thread.Sleep(1000);
//                }
//            }
//        }
//    }
//}



