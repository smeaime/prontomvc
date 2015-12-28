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
                if ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || c == '.' || c == '_' || c == ' ' || c == '-' || c == '&')
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
    }
}