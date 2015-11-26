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

        static public List<Image> GetAllPages(string file)
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
    }
}
