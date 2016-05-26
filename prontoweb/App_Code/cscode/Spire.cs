using Spire.Barcode;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Media.Imaging;
using System.IO;


// https://www.daniweb.com/software-development/csharp/code/481719/barcode-recognition-spire-barcode

namespace JRD.Imaging
{

//Miscellaneous Stuff

//The code snippet is self-contained barring the reference to Spire.Barcode, a 
// supported barcode type enumeration, and a support method that converts BitmapSource to Bitmap. 
// Even though Spire.Barcode uses a flags enumeration for its barcode types, I found that combining 
// types with the bitwise OR operator does not work as well as I'd prefer. When combining all of the types, I received 
// a "not supported" exception, which is silly. Further, the flags are set up in such a way that you might 
//accidentally read unexpected barcodes (matching Codabar when looking for 3 of 9 or 128, for example). 
// As such, I pared down the supported types to common ones I work with using another enumeration. All it does is limit the Spire enumeration:

[Flags]
public enum SupportedBarcodeType : long
{
    Code39Extended = BarCodeType.Code39Extended,
    Code93Extended = BarCodeType.Code93Extended,
    Code128 = BarCodeType.Code128,
    DataMatrix = BarCodeType.DataMatrix,
    QRCode = BarCodeType.QRCode,
    Pdf417 = BarCodeType.Pdf417,
}





    /// <summary>
    /// Represents an extracted barcode from an image.
    /// </summary>
    public class Barcode
    {
        #region Properties
        /// <summary>
        /// Gets the page index of the detected barcode.
        /// </summary>
        public int Frame { get; private set; }
        /// <summary>
        /// Gets the type of the detected barcode.
        /// </summary>
        public SupportedBarcodeType Type { get; private set; }
        /// <summary>
        /// Gets the value of the selected barcode.
        /// </summary>
        public string Value { get; private set; }
        #endregion
        #region Static Scan Interface
        /// <summary>
        /// Extracts barcodes from the provided image.
        /// </summary>
        /// <param name="image">The source image.</param>
        /// <param name="types">A list of barcode types to look for. All types will be checked if not provided.</param>
        /// <param name="zone">A search zone for barcodes. The whole page will be searched if not provided.</param>
        /// <returns>A collection of selected barcodes.</returns>
        public static IEnumerable<Barcode> Scan(Bitmap image, List<SupportedBarcodeType> types = null, Rectangle? zone = null)
        {
            return ExtractSingleFrame(image, NormalizeBarcodeTypes(types), 0, zone);
        }
        /// <summary>
        /// Extracts barcodes from the provided images.
        /// </summary>
        /// <param name="frames">A list of pages representing the image.</param>
        /// <param name="types">A list of barcode types to look for. All types will be checked if not provided.</param>
        /// <param name="zone">A search zone for barcodes. The whole page will be searched if not provided.</param>
        /// <param name="frame">The desired page to search. All pages will be searched if not provided.</param>
        /// <returns>A collection of selected barcodes.</returns>
        public static IEnumerable<Barcode> Scan(List<Bitmap> frames, List<SupportedBarcodeType> types = null, Rectangle? zone = null, int frame = -1)
        {
            var result = new List<Barcode>();
            if (frames.Count == 0)
            {
                throw new IndexOutOfRangeException("Barcode.Scan - Image contains no frames");
            }
            types = NormalizeBarcodeTypes(types);
            if (frame == -1)
            {
                for (int i = 0; i < frames.Count; i++)
                {
                    result.AddRange(ExtractSingleFrame(frames[i], types, i, zone));
                }
            }
            else
            {
                if (frame < 0 || frame >= frames.Count)
                {
                    throw new IndexOutOfRangeException("Barcode.Scan - Invalid frame index [0-" + (frames.Count - 1) + "]");
                }
                result.AddRange(ExtractSingleFrame(frames[frame], types, frame, zone));
            }
            return result;
        }
        /// <summary>
        /// Extracts barcodes from the provided image.
        /// </summary>
        /// <param name="image">The source image.</param>
        /// <param name="types">A list of barcode types to look for. All types will be checked if not provided.</param>
        /// <param name="zone">A search zone for barcodes. The whole page will be searched if not provided.</param>
        /// <returns>A collection of selected barcodes.</returns>
        public static IEnumerable<Barcode> Scan(BitmapSource image, List<SupportedBarcodeType> types = null, Rectangle? zone = null)
        {
            return Scan(Imaging.Barcode.GetBitmap(image), types, zone);
        }
        /// <summary>
        /// Extracts barcodes from the provided images.
        /// </summary>
        /// <param name="frames">A list of pages representing the image.</param>
        /// <param name="types">A list of barcode types to look for. All types will be checked if not provided.</param>
        /// <param name="zone">A search zone for barcodes. The whole page will be searched if not provided.</param>
        /// <param name="frame">The desired page to search. All pages will be searched if not provided.</param>
        /// <returns>A collection of selected barcodes.</returns>
        public static IEnumerable<Barcode> Scan(List<BitmapSource> frames, List<SupportedBarcodeType> types = null, Rectangle? zone = null, int frame = -1)
        {
            return Scan(frames.ConvertAll(x => Imaging.Barcode.GetBitmap(x)), types, zone, frame);
        }
        #endregion
        #region Static Helpers
        /// <summary>
        /// Extracts barcodes from the provided image frame.
        /// </summary>
        /// <param name="image">The provided image frame.</param>
        /// <param name="types">A list of barcode types to extract.</param>
        /// <param name="frame">The index of the provided frame. Set to 0 if not provided.</param>
        /// <param name="zone">A search zone for barcodes. The whole image is searched if not provided.</param>
        /// <returns>A collection of detected barcodes.</returns>
        private static IEnumerable<Barcode> ExtractSingleFrame(Bitmap image, List<SupportedBarcodeType> types, int frame = 0, Rectangle? zone = null)
        {
            Func<BarCodeType, string[]> scan = type => zone.HasValue ? BarcodeScanner.Scan(image , zone.Value, type) : BarcodeScanner.Scan(image, type);
            // Scan all supported types from the frame and flatten the result into a collection of Barcode objects
            return from x in types
                   from y in scan((BarCodeType)x)
                   select new Barcode() { Frame = frame, Type = x, Value = y };
        }
        /// <summary>
        /// Creates and populates a list of supported barcode types if necessary.
        /// </summary>
        /// <param name="types">The source list of supported barcode types from the caller.</param>
        /// <returns>A non-null list of supported types.</returns>
        /// <remarks>
        /// A null or empty source list denotes all supported types. The result list
        /// will be populated with all supported barcode types in the enumeration.
        /// </remarks>
        private static List<SupportedBarcodeType> NormalizeBarcodeTypes(List<SupportedBarcodeType> types = null)
        {
            if (types == null)
            {
                types = new List<SupportedBarcodeType>();
            }
            if (types.Count == 0)
            {
                // Add all supported types if none are selected
                foreach (SupportedBarcodeType item in Enum.GetValues(typeof(SupportedBarcodeType)))
                {
                    types.Add(item);
                }
            }
            return types;
        }
        #endregion





        /// <summary>
        /// Loads a Bitmap from a BitmapSource.
        /// </summary>
        public static Bitmap GetBitmap(BitmapSource image)
        {
            using (var stream = new MemoryStream())
            {
                var encoder = new BmpBitmapEncoder();
                encoder.Frames.Add(BitmapFrame.Create(image));
                encoder.Save(stream);
                // Bitmap objects created from a stream expect the stream
                // to stay open for the lifetime of the bitmap. We don't
                // want to manage the stream too, so copy the bitmap to
                // eliminate that dependency.
                using (var bitmap = new Bitmap(stream))
                {
                    return new Bitmap(bitmap);
                }
            }
        }


    }
}