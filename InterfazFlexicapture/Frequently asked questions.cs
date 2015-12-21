// © 2015 ABBYY Production LLC. 
// ABBYY, FLEXICAPTURE and FLEXILAYOUT are either registered trademarks or trademarks of ABBYY Software Ltd.
// SAMPLES code is property of ABBYY, exclusive rights are reserved. 
// DEVELOPER is allowed to incorporate SAMPLES into his own APPLICATION and modify it 
// under the terms of License Agreement between ABBYY and DEVELOPER.

// Product: ABBYY FlexiCapture Engine 11
// Description: Frequently asked questions and how-to's

using System;
using System.Drawing;
using System.Runtime.InteropServices;

using FCEngine;

namespace Sample
{
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Frequently asked questions

	class FrequentlyAskedQuestions : FlexiCaptureEngineSnippets
	{
		// HOW-TO: Explicitly release a COM object from managed code
		public static void How_to_explicitly_release_a_COM_object_from_managed_code( IEngine engine )
		{	
			// When using COM objects from managed code, it is sometimes
			// required to ensure that a COM object is released at a specific point
			// and not left to the garbage collector (which might not
			// release the object for a long time). This might be needed to release
			// memory or other resources taken by the object if there is no other
			// way to release them. This is effectively "DISPOSAL" of the COM object and
            // the same rules should be followed as those used when deciding if
			// Dispose method should be called on a disposable .NET Framework object.
			
			// Releasing resources in timely manner is especially important in
			// server applications. Garbage collector does not "know" the real
			// amount of memory and resources used by COM objects and will
			// not "know" that they should be garbage-collected. As the result, your server
			// application might run low on non-managed memory while managed heap
			// will be still almost empty and garbage-collection will not run.
			
			// For example, the FlexiCapture processor object has some internal state,
			// which consumes resources. If we just leave the object to the garbage
			// collector, we cannot be sure when these resources are released.
			// It might not be a problem in most cases, but if our application
			// is to be used in high-performance scenarios we'd be better off
            // explicitly releasing the object. The downside of this scenario is 
            // the complexity of the resulting code.
						
			trace( "Create a COM object..." );
			IFlexiCaptureProcessor processor = engine.CreateFlexiCaptureProcessor();
			try {
				// Some processing here
				// ...
			} finally {
				trace( "To explicitly release the COM object, call Marshal.ReleaseComObject." );
				// We are sure that this instance of the processor will never be used again,
				// so we are safe to release it here
				Marshal.ReleaseComObject( processor );
			}

            // NB. Nulling the object WILL NOT do the trick as it did in Visual Basic 6.0.
			// Calling GC.Collect might SEEM to work under some conditions but does not
			// guarantee that a particular object will be freed (a stray reference).
			// Moreover, GC.Collect might be a very lengthy operation (if your managed heap
			// contains many objects) and calling it often might significantly degrade performance.
		}

		// HOW-TO: Use Dispose Pattern with FlexiCapture Engine objects
		public static void How_to_use_Dispose_Pattern_with_FlexiCapture_Engine_objects( IEngine engine )
		{
            // The .NET languages extensively use "Dispose Pattern" to allow deterministically 
			// manage unmanaged resources. Objects which support "disposal" implement IDispose
			// interface, which allows using these objects in "using" statements or correctly aggregate
			// them in other disposable objects.

			// Many ABBYY FlexiCapture Engine objects require disposal. 
            // For example, an open project, batch or document requires closing.
			// One way to guarantee that these objects are always closed properly is to use try...finally
			// block and remember to call Close for these objects in Dispose method if aggregated (in a view).
            // The other way is to write wrappers around critical FlexiCapture Engine objects to better
            // integrate them with the language:
			
			trace( "Using a wrapper implementing IDisposable for IProject..." );

			using( DisposableProject project = new DisposableProject( engine, SamplesFolder + "\\SampleProject\\Invoices_eng.fcproj" ) ) {
				// Do some processing. The project is guaranteed to be closed on leaving this block of code
				// (both normally or due to an exeption being thrown).
				// ...
				project.Close();
			}
		}

		// HOW-TO: Request a COM interface
		public static void How_to_request_a_COM_interface( IEngine engine )
		{	
			// If a COM object supports multiple interfaces, you can query
			// the required interface by casting the object to this interface.
			
			// For example, FlexiCapture documents support undo/redo operations.
			// This feature is available through an auxiliary interface IUndoable:
			trace( "Cast the object to the required interface." );
			IDocument document = PrepareNewRecognizedDocument( engine ); 
			IUndoable undoable = document as IUndoable;
		}

		// HOW-TO: Connect to an event source (IConnectionPoint)
		public static void How_to_connect_to_an_event_source( IEngine engine )
		{
			// COM objects implement IConnectionPoint interface to make events
			// they support available to clients. Working directly with this interface
			// is possible but rather tedious. To facilitate working with events,
			// the .NET Framework generates a set of helper classes when importing
			// types information from a type library.

			// For example, to subscribe to ICollectionEvents from an object, you use
			// ICollectionEvents_Event helper class. Casting an object to this class
			// will automatically check if the object implements IConnectionPoint interface 
			// and connect to ICollectionEvents if found. If the connection point is not available,
			// the cast will result in a null:

			trace( "Cast the object to the helper class for the required event source." );
			ICollectionEvents_Event collectionEvents = engine as ICollectionEvents_Event;
			if( collectionEvents != null ) {
				// IEngine does not support this kind of events, but if it did, we could
				// assign a method to handle the events:

				trace( "Assign a method to be called when a particular event occurs." );
				// collectionEvents.OnCollectionChanged += 
				//		new ICollectionEvents_OnCollectionChangedEventHandler( ... );
			}
		}

		// HOW-TO: Use HBITMAPs returned by FlexiCapture Engine objects
		public static void How_to_use_HBITMAPs_returned_by_FlexiCapture_Engine_objects( IEngine engine )
		{
			trace( "Prepare an image in FlexiCapture Engine format..." );
			IDocument document = PrepareNewRecognizedDocument( engine );
			IImageDocument pageImageDocument = document.Pages[0].ReadOnlyImage;
			IImage pageBWImage = pageImageDocument.BlackWhiteImage;

			trace( "Request the bitmap for a region in the image..." );
			// The method returns HBITMAP handle to a GDI bitmap object. You take ownership of 
			// the object which means that you MUST free the object when it is no longer needed
			// (see DeleteObject below). It is recommended that the bitmap is freed
			// as soon as possible.
			IHandle hBitmap = pageBWImage.GetPicture( null, 0 );
			
			trace( "Create an Image from the bitmap..." );
			// The FromHbitmap method makes a COPY of the GDI bitmap. It does not take ownership of
			// the original GDI bitmap and you are still responsible for freeing it!
			using( System.Drawing.Image image = System.Drawing.Image.FromHbitmap( hBitmap.Handle ) ) {
				trace( "Explicitly DELETE the bitmap or there will be a resource leak!" );
				hBitmap.CloseHandle();
				
				// It is highly recommended that you correctly manage the image disposal and not leave
				// it to garbage collector. If the image is used in a visual control, it should be
				// disposed of in the Dispose method of the control. If the image is used in some
				// procedure, you should enclose its usage in "using" statement as in this example.

				// ...
			}
		}

		// HOW-TO: Save images for document fields
		public static void How_to_save_images_for_document_fields( IEngine engine )
		{
			trace( "Prepare a sample document..." );
			IDocument document = PrepareNewRecognizedDocument( engine );
			
			trace( "Select an arbitrary field..." );
			IField field = document.Sections[0].Children[0];
			assert( field.Name == "InvoiceNumber" );

			trace( "Get the region and the page index for the field..." );
			// Generally a field might correspond to several regions (blocks) on the same page or on
			// different pages. Simple fields (simple picture or single line text)usually have one region
			assert( field.Blocks.Count == 1 );
			IBlock firstBlock = field.Blocks.Item( 0 );
			int pageIndex = firstBlock.Page.Index;
			IRegion region = firstBlock.Region;

			// Knowing the field's page index and geometry we can "scroll" to the field image
			// in a custom document view, or extract the region from the page image and use it
			// as required. In this example we will use this information to save the field image
            // to a file

			trace( "Get the page image..." );
			IPage page = document.Pages[pageIndex];
			// Get the page image in .NET Framework format
			IImageDocument pageImageDocument = page.ReadOnlyImage;
			IImage bwImage = pageImageDocument.BlackWhiteImage;
            IHandle hBitmap = bwImage.GetPicture(null, 1); // (int) GetPictureFlags.GP_ScaleToGray);
			using( System.Drawing.Image pageImage = System.Drawing.Image.FromHbitmap( hBitmap.Handle ) ) {
				hBitmap.CloseHandle();
				
				trace( "Extract the field image..." );
				// Extract a region from the page image using standard .NET Framework tools
				assert( region.Count == 1 ); // The region contains one rectangle
				
				int left = region.get_Left( 0 );
				int right = region.get_Right( 0 );
				int top = region.get_Top( 0 );
				int bottom = region.get_Bottom( 0 );
				int width = right - left;
				int height = bottom - top;

				using( Bitmap bmp = new Bitmap( width, height ) ) {
					using( Graphics canvas = Graphics.FromImage( bmp ) ) {
						canvas.DrawImage( pageImage, 
							new Rectangle( 0, 0, width, height ),
							new Rectangle( left, top, width, height),
							GraphicsUnit.Pixel );
					}
					bmp.Save( SamplesFolder + "\\FCEExport\\InvoiceNumber.bmp" );
				}
			}
		}

		// HOW-TO: Save images for document fields
		public static void How_to_save_images_for_document_fields_LPAREN2RPAREN( IEngine engine )
		{
			// If your development tool does not have rich functionality for working with
			// images you can try using WriteToFile method of Image object as follows
						
			trace( "Prepare a sample document..." );
			IDocument document = PrepareNewRecognizedDocument( engine );
			
			trace( "Select an arbitrary field..." );
			IField field = document.Sections[0].Children[0];
			assert( field.Name == "InvoiceNumber" );

			trace( "Get the region and the page index for the field..." );
			// Generally a field might correspond to several regions (blocks) on the same page or on
			// different pages. Simple fields (simple picture or single line text)usually have one region
			assert( field.Blocks.Count == 1 );
			IBlock firstBlock = field.Blocks.Item( 0 );
			int pageIndex = firstBlock.Page.Index;
			IRegion region = firstBlock.Region;

			// Knowing the field's page index and geometry we can "scroll" to the field image
			// in a custom document view, or extract the region from the page image and use it
			// as required. In this example we will use this information to save the field image
            // to a file

			trace( "Get the page image..." );
			IPage page = document.Pages[pageIndex];
			// Get the page image in .NET Framework format
			IImageDocument pageImageDocument = page.ReadOnlyImage;
			IImage bwImage = pageImageDocument.BlackWhiteImage;
				
			trace( "Extract the field image..." );
			IImageModification modification = engine.CreateImageModification();
			modification.ClipRegion = region;

			bwImage.WriteToFile( SamplesFolder + "\\FCEExport\\InvoiceNumber.tif", 
				ImageFileFormatEnum.IFF_Tif, modification, ImageCompressionTypeEnum.ICT_CcittGroup4, null );
		}

		// HOW-TO: How to pass images between processes or to and from FineReader Engine
		public static void How_to_pass_images_between_processes_or_to_and_from_FineReader_Engine( IEngine engine )
		{
			trace( "Prepare an image in FlexiCapture Engine format..." );
			IDocument document = PrepareNewRecognizedDocument( engine );
			IImageDocument pageImageDocument = document.Pages[0].ReadOnlyImage;
			
			trace( "Serialize the image document in memory..." );
			// You are responsible for freeing the allocated memory when it is no longer needed
			IHandle hGlobal = pageImageDocument.SaveToMemory();
			try {
				// The handle to the serialized image can be used in the same process (for example for 
				// interoperability with FineReader Engine) or passed (marshalled) to a different process if required

				trace( "Deserialize the image document from memory..." );
				// To deserialize the image in the target context use LoadImageDocFromMemory method.
				// An identical method is present in FineReader Engine which can be used to convert
				// images to FREngine format
				IImageDocument documentCopy = engine.LoadImageDocFromMemory( hGlobal.HandleAsInt64 );
                System.Runtime.InteropServices.Marshal.FinalReleaseComObject( documentCopy );

			} finally {
				// Do not forget to free the memory. The memory can be freed either in the same process where
				// it was allocated or in the process where the image is consumed
				trace( "Free the memory..." );
                hGlobal.CloseHandle();
			}
		}

		// HOW-TO: Load engine from a directory specified at runtime
		public static void How_to_load_Engine_from_a_directory_specified_at_runtime( IEngine engine )
		{	
			trace( "Load Engine from a directory..." );

			// In these samples when the Engine is loaded directly it is loaded from a directory
			// specified at compile time (by explicitly providing the full path to FCEngine.dll
			// in DllImport attribute). It is the easiest way but it is not practical in real-time
			// applications as the application installation directory in not usually known at compile
			// time (it can be changed by the user during installation procedure).

			// The recommended way to address this problem is by manually loading FCEngine.dll
			// using LoadLibraryEx before initializing the Engine in the usual way:

			// internal static uint LOAD_WITH_ALTERED_SEARCH_PATH = 0x00000008;
			// [DllImport( "kernel32.dll", CharSet=CharSet.Unicode ), PreserveSig]
			// internal static extern IntPtr LoadLibraryEx(string lpFileName, IntPtr hFile, uint dwFlags);

			// LoadLibraryEx( engineDllPath, IntPtr.Zero, LOAD_WITH_ALTERED_SEARCH_PATH );
			
			// IEngine engine = null;
			// int hresult = InitializeEngine( serialNumber, out engine );
			// Marshal.ThrowExceptionForHR( hresult );	
		}
		
		// HOW-TO: Test your scenario
		public static void How_to_test_your_scenario( IEngine engine )
		{	
			trace( "Type your code here..." );

			// You can type your code here or create a new method with the same signature
			// (it must be public static void taking a single parameter of type IEngine)
			// If the method follows this pattern, it will be automatically included
			// in the callable scenarios list (all underscores in the name of the method 
            // will be converted to spaces).

			// You can use built-in helper tools for:
			
			// ... tracing:
			traceBegin( "Begin scope..." );
				trace( "Trace message" );
			traceEnd( "End" );

			// ... assertions (to check that some condition is as expected):
			assert( 5 == 5 );

            // ... sample's configuration:
			string myPath = SamplesFolder + "\\MyPath";

			// You can make your scenario run repeatedly for a long period of time to check
			// how robust it is or test it in different engine loading modes. Check out the commands
			// from the Snippet main menu to see all available options
		}

		#region Sample Auxiliary Classes and Methods

		// Auxiliary Tools ///////////////////////////////////////////////////////////

		static IDocument PrepareNewRecognizedDocument( IEngine engine )
		{
			// Prepare a recognized document
			IFlexiCaptureProcessor processor = engine.CreateFlexiCaptureProcessor();
			processor.AddDocumentDefinitionFile( SamplesFolder + "\\SampleProject\\Templates\\Invoice_eng.fcdot" );
			
			// Add images for a single multipage document
			processor.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_2.tif" );
			processor.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_3.tif" );

			// Recognize the document
			IDocument document = processor.RecognizeNextDocument();
			assert( document != null );
			assert( document.DocumentDefinition != null );
			assert( document.Pages.Count == 2 );

			return document;
		}

		sealed class DisposableProject : IDisposable 
		{
			// This sample is limited to using .NET Framework 1.1 by design. If you are working
			// with a newer version, you might consider using generics.

			public DisposableProject( IEngine engine, string path )
			{
				project = engine.OpenProject( path );
				trace( "Opened" );
			}

			public void Close()
			{
				project.Close();
				trace( "Closed" );
			}

			public void Dispose()
			{
				if( project != null ) {
					Marshal.ReleaseComObject( project );
					project = null;
					GC.SuppressFinalize( this );
					trace( "Disposed" );
				}
			}

			IProject project;
		}

		/////////////////////////////////////////////////////////////////////////////////

		#endregion
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
