// © 2015 ABBYY Production LLC. 
// ABBYY, FLEXICAPTURE and FLEXILAYOUT are either registered trademarks or trademarks of ABBYY Software Ltd.
// SAMPLES code is property of ABBYY, exclusive rights are reserved. 
// DEVELOPER is allowed to incorporate SAMPLES into his own APPLICATION and modify it 
// under the terms of License Agreement between ABBYY and DEVELOPER.

// Product: ABBYY FlexiCapture Engine 11
// Description: Using FlexiCapture technology API

using System;
using System.Collections;
using System.IO;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Drawing;
using System.Drawing.Imaging;

using FCEngine;

namespace Sample
{
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Using FlexiCapture technology API
	
	class UsingFlexiCaptureTechnologyAPI : FlexiCaptureEngineSnippets
	{
		// USE CASE: Recognizing a sequence of image files using FlexiCapture processor
		public static void Recognizing_a_sequence_of_image_files_using_FlexiCapture_processor( IEngine engine )
		{	
			trace( "Create an instance of FlexiCapture processor..." );
			IFlexiCaptureProcessor processor = engine.CreateFlexiCaptureProcessor();

			trace( "Add required Document Definitions..." );
			processor.AddDocumentDefinitionFile( SamplesFolder + "\\SampleProject\\Templates\\Invoice_eng.fcdot" );
			
			trace( "Add the image files to recognize..." );
			processor.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_1.tif" );
			processor.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_2.tif" );
			processor.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_3.tif" );

			traceBegin( "Run processing loop..." );
			int count = 0;
			while( true ) {
				trace( "Recognize next document..." );
				IDocument document = processor.RecognizeNextDocument();
				
				if( document == null ) {
					IProcessingError error = processor.GetLastProcessingError();
					if( error != null ) {
						processError( error, processor, ErrorHandlingStrategy.LogAndContinue );
						continue;
					} else {
                        trace( "No more images" );
						break;
					}
				} else if( document.DocumentDefinition == null ) {			
					processNotMatched( document );
				}
				
				trace( "Export recognized document..." );
				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "NextDocument_" + count, null ); 
				count++;
			}
			traceEnd( "OK" );
			
			trace( "Check the results..." );
			assert( count == 2 );
		}

		// USE CASE: Using a custom image source with FlexiCapture processor
		public static void Using_a_custom_image_source_with_FlexiCapture_processor( IEngine engine )
		{	
			trace( "Create an instance of FlexiCapture processor..." );
			IFlexiCaptureProcessor processor = engine.CreateFlexiCaptureProcessor();
			
			trace( "Add required Document Definitions..." );
			processor.AddDocumentDefinitionFile( SamplesFolder + "\\SampleProject\\Templates\\Invoice_eng.fcdot" );
			
			trace( "Set up a custom image source..." );
			// Create and configure sample image source (see SampleImageSource class for details)
			SampleImageSource imageSource = new SampleImageSource();
			// The sample image source will use these files by reference:
			imageSource.AddImageFileByRef( SamplesFolder + "\\SampleImages\\Invoices_1.tif" );
			imageSource.AddImageFileByRef( SamplesFolder + "\\SampleImages\\Invoices_2.tif" );
			imageSource.AddImageFileByRef( SamplesFolder + "\\SampleImages\\Invoices_3.tif" );
			// ... these files by value (files in memory):
			imageSource.AddImageFileByValue( SamplesFolder + "\\SampleImages\\Invoices_1.tif" );
			imageSource.AddImageFileByValue( SamplesFolder + "\\SampleImages\\Invoices_2.tif" );
			imageSource.AddImageFileByValue( SamplesFolder + "\\SampleImages\\Invoices_3.tif" );
			// Configure the processor to use the new image source
			processor.SetCustomImageSource( imageSource );
					
			traceBegin( "Run processing loop..." );
			int count = 0;
			while( true ) {
				trace( "Recognize next document..." );
				IDocument document = processor.RecognizeNextDocument();
				if( document == null ) {
					IProcessingError error = processor.GetLastProcessingError();
					if( error != null ) {
						processError( error, processor, ErrorHandlingStrategy.LogAndContinue );
						continue;
					} else {
                        trace( "No more images" );
						break;
					}
				} else if( document.DocumentDefinition == null ) {
					processNotMatched( document );
				}
				trace( "Export recognized document..." );
				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "NextDocument_" + count, null ); 
				count++;
			}
			traceEnd( "OK" );

			trace( "Check the results..." );
			assert( count == 4 );
		}

		// USE CASE: Handling errors in the image queue
		public static void Handling_errors_in_the_image_queue( IEngine engine )
		{	
			trace( "Create and configure an instance of FlexiCapture processor..." );
			IFlexiCaptureProcessor processor = engine.CreateFlexiCaptureProcessor();
			processor.AddDocumentDefinitionFile( SamplesFolder + "\\SampleProject\\Templates\\Invoice_eng.fcdot" );
			
			trace( "Fill the image queue so that errors should occur..." );
			processor.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_1.tif" );
			// ... this file does not exist:
			processor.AddImageFile( SamplesFolder + "\\SampleImages\\DOESNOTEXIST.tif" );
			processor.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_2.tif" );
			processor.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_3.tif" );
			// ... this file exists but will not be accessible:
			string accessDeniedPath = SamplesFolder + "\\SampleImages\\ACCESSDENIED.tif";
			FileStream accessDeniedStream = File.Open( accessDeniedPath, FileMode.OpenOrCreate, FileAccess.Write );
			processor.AddImageFile( SamplesFolder + "\\SampleImages\\ACCESSDENIED.tif" );
			processor.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_1.tif" );

			traceBegin( "Run processing loop..." );
			int count = 0;
			while( true ) {
				trace( "Recognize next document..." );
				IDocument document = processor.RecognizeNextDocument();
				
				if( document == null ) {
					IProcessingError error = processor.GetLastProcessingError();
					if( error != null ) {
						// Try changing the error handling strategy below (see ErrorHandlingStrategy enum).
						// See processError implementation for details
						processError( error, processor, ErrorHandlingStrategy.LogAndContinue );
						continue;
					} else {
						trace( "No more images" );
						break;
					}
				} else if( document.DocumentDefinition == null ) {			
					processNotMatched( document );
				}

				trace( "Export recognized document..." );
				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "NextDocument_" + count, null ); 
				count++;
			}
			traceEnd( "OK" );

			accessDeniedStream.Close();
			File.Delete( accessDeniedPath );
			
			trace( "Check the results..." );
			assert( count == 3 );
		}

		// USE CASE: Navigating through the document structure
		public static void Navigating_through_the_document_structure( IEngine engine )
		{
			trace( "Prepare a sample document..." );
			IDocument document = PrepareNewRecognizedDocument( engine );
			
			traceBegin( "Build document data tree..." );
			// Document is actually the top-level document node. We will use this fact to
			// uniformly traverse the tree of document data structure (document nodes or fields)
			IField rootNode = document as IField;
			recursiveProcessWithChildren( rootNode );
			traceEnd( "OK" );

			traceBegin( "Build document layout tree..." );
			// Again, pages are top-level layout nodes. We will use this to
			// uniformly traverse the tree of document geometry (layout blocks)
			foreach( IPage page in document.Pages ) {
				IBlock rootLayoutNode = page as IBlock;
				recursiveProcessWithChildren( rootLayoutNode );
			}
			traceEnd( "OK" );		
		}

		// USE CASE: Using built-in export tools
		public static void Exporting_results_using_FlexiCapture_processor( IEngine engine )
		{
			trace( "Prepare a sample document..." );
			IFlexiCaptureProcessor processor;
			IDocument document = PrepareNewRecognizedDocument( engine, out processor );			
			IFileExportParams exportParams = engine.CreateFileExportParams();
			
			if( document.DocumentDefinition != null ) {
				// You can export data only in documents of known types
				trace( "Export the document using the settings from the Document Definition" );
				processor.ExportDocument( document, SamplesFolder + "\\FCEExport" );
				traceBegin( "Export the data to all supported file formats..." );
					
					trace( "XML" );
					exportParams.FileFormat = FileExportFormatEnum.FEF_XML;
					processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "ExportToXML", exportParams ); 
					trace( "XLS" );
					exportParams.FileFormat = FileExportFormatEnum.FEF_XLS;
					processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "ExportToXLS", exportParams ); 
					trace( "CSV" );
					exportParams.FileFormat = FileExportFormatEnum.FEF_CSV;
					processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "ExportToCSV", exportParams );
					trace( "DBF" );
					exportParams.FileFormat = FileExportFormatEnum.FEF_DBF;
					processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "ExportToDBF", exportParams );
					trace( "TXT" );
					exportParams.FileFormat = FileExportFormatEnum.FEF_Text;
					processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "ExportToText", exportParams );
				traceEnd( "OK" );
			} else {
				// You can export unrecognized documents to all image formats or PDF (including searchable PDF)
				trace( "Unknown document type: Export as searchable PDF" );
				IFileExportParams pdfExportParams = engine.CreateFileExportParams();
				pdfExportParams.ImageExportParams.Format = ImageFileFormatEnum.IFF_Pdf;
				pdfExportParams.ImageExportParams.CreateSearchablePDF = true;
				pdfExportParams.ImageExportParams.PDFRecognitionLanguage = "English";
				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "ExportToSearchablePDF", pdfExportParams ); 
			}
			
			traceBegin( "Export the page images to all supported image file formats..." );
				exportParams.FileFormat = FileExportFormatEnum.FEF_XML;
				exportParams.ExportOriginalImages = true;
				exportParams.ImageExportParams.OverwriteFiles = true;
				trace( "TIF" );
				exportParams.ImageExportParams.Format = FCEngine.ImageFileFormatEnum.IFF_Tif;
				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "ExportToTIF", exportParams ); 
				trace( "JPG" );
				exportParams.ImageExportParams.Format = FCEngine.ImageFileFormatEnum.IFF_Jpg;
				exportParams.ImageExportParams.CompressionType = ImageCompressionTypeEnum.ICT_Jpeg;
				exportParams.ImageExportParams.ColorType = ImageColorTypeEnum.ICT_Color; // or ICT_Gray
				exportParams.ImageExportParams.FileAssemblingRule = ImageFileAssemblingRuleEnum.IFAR_FilePerImage;
				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "ExportToJPG", exportParams );
				trace( "PNG" );
				exportParams.ImageExportParams.Format = FCEngine.ImageFileFormatEnum.IFF_Png;
				exportParams.ImageExportParams.CompressionType = ImageCompressionTypeEnum.ICT_Png;
				exportParams.ImageExportParams.FileAssemblingRule = ImageFileAssemblingRuleEnum.IFAR_FilePerImage;
				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "ExportToPNG", exportParams ); 
				trace( "BMP" );
				exportParams.ImageExportParams.Format = FCEngine.ImageFileFormatEnum.IFF_Bmp;
				exportParams.ImageExportParams.CompressionType = ImageCompressionTypeEnum.ICT_Uncompressed;
				exportParams.ImageExportParams.FileAssemblingRule = ImageFileAssemblingRuleEnum.IFAR_FilePerImage;
				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "ExportToBMP", exportParams );
				trace( "PDF" );
				exportParams.ImageExportParams.Format = FCEngine.ImageFileFormatEnum.IFF_Pdf;
				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "ExportToPDF", exportParams ); 
				trace( "DCX" );
				exportParams.ImageExportParams.Format = FCEngine.ImageFileFormatEnum.IFF_Dcx;
				exportParams.ImageExportParams.CompressionType = ImageCompressionTypeEnum.ICT_PackBits;
				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "ExportToDCX", exportParams ); 
				trace( "J2K" );
				exportParams.ImageExportParams.Format = FCEngine.ImageFileFormatEnum.IFF_J2k;
				exportParams.ImageExportParams.CompressionType = ImageCompressionTypeEnum.ICT_Jpeg;
				exportParams.ImageExportParams.ColorType = ImageColorTypeEnum.ICT_Color; // или ICT_Gray
				exportParams.ImageExportParams.FileAssemblingRule = ImageFileAssemblingRuleEnum.IFAR_FilePerImage;
				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "ExportToJ2K", exportParams ); 
				trace( "PCX" );
				exportParams.ImageExportParams.Format = FCEngine.ImageFileFormatEnum.IFF_Pcx;
				exportParams.ImageExportParams.CompressionType = ImageCompressionTypeEnum.ICT_PackBits;
				exportParams.ImageExportParams.FileAssemblingRule = ImageFileAssemblingRuleEnum.IFAR_FilePerImage;
				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "ExportToPCX", exportParams ); 
			traceEnd( "OK" );

			// NB: By default if the file exists the new data is appended to this file. It works fine in simple
			// scenarios but should be avoided if a lot of data is exported or in parallel processing scenarios.
			// A better solution to avoid bottlenecks would be to either use custom export or export every
			// document to a separate file with a unique name and consolidate data later elsewhere
		}

		// USE CASE: Implementing custom export
		public static void Implementing_custom_export( IEngine engine )
		{
			trace( "Prepare a sample document..." );
			IDocument document = PrepareNewRecognizedDocument( engine );
			
			traceBegin( "Run custom export..." );
				// Simple text-based export
				SimpleXMLExporter.Export( document, SamplesFolder + "\\FCEExport\\SampleExport.xml" );
				// A more sophisticated example based on the standard System.Xml tools
				MappedXMLExporter.Export( document, SamplesFolder + "\\FCEExport\\SampleExport.xml" );
				// Next two examples show how to export page images
				ImageExporter.ExportToPng( document, SamplesFolder + "\\FCEExport" );
				ImageExporter.ExportToMultipageTiff( document, SamplesFolder + "\\FCEExport" );
			traceEnd( "OK" );
			
			// Show last results in the browser
			if( IsInteractive ) {
				Process.Start( SamplesFolder + "\\FCEExport\\SampleExport.xml" );
			}
		}

		// USE CASE: Implementing custom storage
		public static void Implementing_custom_storage( IEngine engine )
		{
			trace( "Prepare a sample document..." );
			IDocument document = PrepareNewRecognizedDocument( engine );
			
			// If an object supports custom storage, it implements ICustomStorage interface
			ICustomStorage customStorage = document as ICustomStorage;
			assert( customStorage != null );
			// NB. It is the same object but we see it through a different interface
			assert( customStorage == document );

			trace( "Save the document to a file..." );
			customStorage.SaveToFile( SamplesFolder + "\\FCEExport\\Document.mydoc" );

			trace( "Save the document to a stream..." );
			// The sample write stream is implemented as writing to a file (see SampleWriteStream for details)
			SampleWriteStream writeStream = new SampleWriteStream( SamplesFolder + "\\FCEExport\\Document.mystream" );
			try {
				customStorage.SaveToStream( writeStream );
			} finally {
				writeStream.Close();
			}

			IFlexiCaptureProcessor processor = engine.CreateFlexiCaptureProcessor();
						
			trace( "Load a document from file..." );
			IDocument newDocument = processor.CreateDocument();
			customStorage = newDocument as ICustomStorage;
			assert( customStorage != null );

			customStorage.LoadFromFile( SamplesFolder + "\\FCEExport\\Document.mydoc" );
			processor.ExportDocumentEx( newDocument, SamplesFolder + "\\FCEExport", "LoadedFromFile", null );

            trace( "Load a document from stream..." );
			newDocument = processor.CreateDocument();
			customStorage = newDocument as ICustomStorage;
			assert( customStorage != null );

			// The sample read stream is implemented as reading from a file (see SampleReadStream for details)
			SampleReadStream readStream = new SampleReadStream( SamplesFolder + "\\FCEExport\\Document.mystream" );
			customStorage.LoadFromStream( readStream );
			processor.ExportDocumentEx( newDocument, SamplesFolder + "\\FCEExport", "LoadedFromStream", null );
			
			traceEnd( "OK" );
		}

		// USE CASE: Implementing custom reference manager
		public static void Implementing_custom_reference_manager( IEngine engine )
		{
			trace( "Create an instance of FlexiCapture processor..." );			
			IFlexiCaptureProcessor processor = engine.CreateFlexiCaptureProcessor();

			trace( "Configure the processor to use a custom reference manager..." );
			// The sample reference manager can resolve "protocol:\\" references (see SampleReferenceManager for details)
			processor.SetReferenceManager( new SampleReferenceManager() );
			// Now we can pass references starting with "protocol:\\" and they will be correctly resolved:
			processor.AddDocumentDefinitionFile( "protocol:\\SampleProject\\Templates\\Invoice_eng.fcdot" );
			
			trace( "Add image files..." );
			processor.AddImageFile( "protocol:\\SampleImages\\Invoices_2.tif" );
			processor.AddImageFile( "protocol:\\SampleImages\\Invoices_3.tif" );

			trace( "Recognize and export..." );
			IDocument document = processor.RecognizeNextDocument();
			assert( document != null );
			assert( document.Pages.Count == 2 );
			processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "ReferenceManager", null );
			
			traceEnd( "OK" );
		}

		// USE CASE: Implementing undo and redo operations for a FlexiCapture Engine object
		public static void Implementing_Undo_and_Redo_for_a_document_in_an_editor( IEngine engine )
		{	
			trace( "Prepare a sample document..." );
			IDocument document = PrepareNewRecognizedDocument( engine ); 
			
			// Some FlexiCapture Engine objects (for example IDocument) support undo and redo operations. 
			// To use this feature in your editor:
			
			// Request IUndoable by casting the document to this interface.
			// You should keep the aquired reference as long as you use this
			// feature (for example as a member field in your editor class). 
			// It is important because the internal undo support for the object 
			// might deinitialize if not used (if all references to IUndoable
			// are released)
			trace( "Request undo support interface..." );
			IUndoable undoable = document as IUndoable;

			// Undo support is initially disabled to conserve resources,
			// so we must switch it on
			assert( undoable.IsUndoRedoEnabled == false );
			undoable.EnableUndoRedo( true );

			// Initially the object (the document) is not modified
			// (the Save button on your editor's toolbar is disabled)
			assert( !undoable.IsObjectModified );
			// And there is nothing to undo or redo (the Undo/Redo buttons
			// on your editor's toolbar are also disabled)
			assert( !undoable.CanUndo );
			assert( !undoable.CanRedo );

			// Let the user of your editor modify the document, use undo/redo
			traceBegin( "Modify the document, use Undo Redo..." );
				// Take an arbitrary field
				IField field = document.Sections[0].Children[0];	
				string initialValue = field.Value.AsString;
				trace( "initialValue = " + initialValue );
				
				// Modify it
				trace( "Modify..." );
				field.Value.AsText.Delete( 0, 4 );
				string modifiedValue = field.Value.AsString;
				assert( modifiedValue != initialValue );
				trace( "modifiedValue = " + modifiedValue );

				// Now we can Undo but cannot Redo (Undo/Redo buttons in your
				// editor changed state)
				assert( undoable.CanUndo );
				assert( !undoable.CanRedo );
				// And the object is modified (Save button is enabled)
				assert( undoable.IsObjectModified );

				// Press Undo button
				trace( "Undo..." );
				undoable.Undo();
				
				// The field is reverted to initial value
				assert( field.Value.AsString == initialValue );
				trace( "field.Value = " + field.Value.AsString );
				// The document is no longer modified
				assert( !undoable.IsObjectModified );
				// You cannot Undo, but you can Redo
				assert( !undoable.CanUndo );
				assert( undoable.CanRedo );

				// Press Redo button
				trace( "Redo..." );
				undoable.Redo();
			
				// The field value changed
				assert( field.Value.AsString == modifiedValue );
				trace( "field.Value = " + field.Value.AsString );
				// The document is modified as before
				assert( undoable.IsObjectModified );
				// You can Undo, but you cannot Redo
				assert( undoable.CanUndo );
				assert( !undoable.CanRedo );
				
			traceEnd( "OK" );

			// If you want that the considerable resources consumed by the
			// undo support be released in timely manner, you should explicitly
			// deinitialize undo support as part of your editor's Disposal procedure.
			trace( "Deinitialize undo support explicitly..." );
			undoable.EnableUndoRedo( false );
		}
		
		// USE CASE: Correcting assembly errors
		public static void Correcting_assembly_errors( IEngine engine )
		{
			trace( "Prepare two documents..." );
			IDocument document1 = PrepareNewRecognizedDocument( engine );
			IDocument document2 = PrepareNewRecognizedDocument( engine );
			int totalPagesCount = document1.Pages.Count + document2.Pages.Count;

			trace( "Merge the documents..." );
			while( document2.Pages.Count > 0 ) {
				document1.Pages.Attach( document2.Pages[0], document1.Pages.Count );
			}
			assert( document2.Pages.Count == 0 );
			assert( document1.Pages.Count == totalPagesCount );

			trace( "Delete some documents..." );
			document1.Pages.DeleteByID( document1.Pages[document1.Pages.Count - 1].ID );
			assert( document1.Pages.Count == totalPagesCount - 1 );
			
			traceEnd( "OK" );
		}

		// USE CASE: Verifying recognized documents
		public static void Verifying_recognized_documents( IEngine engine )
		{
			trace( "Prepare documents and add them to a collection..." );
			IDocumentsCollection documentsToVerify = engine.CreateDocumentsCollection();
			documentsToVerify.Add( PrepareNewRecognizedDocument( engine ) );
			documentsToVerify.Add( PrepareNewRecognizedDocument( engine ) );
			
			traceBegin( "Run verification..." );
					
			IVerificationSession verificationSession = engine.CreateVerificationSession( documentsToVerify );
			try {
				trace( "Change verification options if required..." );
				IVerificationOptions verificationOptions = verificationSession.Options;
				verificationOptions.VerifyExtraSymbols = true;
										
				trace( "Open a set of documents (a work set) and collect objects that need to be verified..." );
				IVerificationWorkSet verificationWorkSet = verificationSession.NextWorkSet();            
				while( verificationWorkSet != null ) {
					trace( "For each group of objects show the objects to the verification operator for confirmation..." );
					IVerificationGroup verificationGroup = verificationWorkSet.NextGroup();
					while( verificationGroup != null ) {
						trace( "Verification Group: " + verificationGroup.Description + " (confirm all)" );
						foreach( IVerificationObject verificationObject in verificationGroup ) {
							if( verificationObject.Type == VerificationObjectTypeEnum.VOT_Group ) {
								verificationObject.State = VerificationObjectStateEnum.VOS_Confirmed;
							} else {
								IContextVerificationObject contextVerificationObject = verificationObject.AsContextVerificationObject();
								
								// If field value is modified during verification you should recheck rules for
								// the corresponding field
								contextVerificationObject.CheckRules();
								
								contextVerificationObject.Field.Value.SetVerified();
							}
						}
						
						verificationGroup = verificationWorkSet.NextGroup();
					}
					trace( "Save verification results (all documents in the set)..." );
					verificationWorkSet.Commit();
					
					trace( "Open the next set of documents..." );
					verificationWorkSet = verificationSession.NextWorkSet();
				}
				
				trace( "Close the session..." );
			} 
			finally 
			{
				// Verification consumes considerable system resources (many simultaniously
				// open and loaded documents and images). So it is VERY important that
				// these resources should be released in timely manner and not left for 
				// garbage collector to manage.
				verificationSession.Close();
			}

			trace( "Check that the documents do not need verification now..." );
			foreach( IDocument document in documentsToVerify ) {
				recursiveCheckVerified( engine, document.Sections );
			}

			traceEnd( "OK" );
			
			traceEnd( "OK" );
		}
	
		#region Sample Auxiliary Classes and Methods

		// Custom Image Source ///////////////////////////////////////////////////////////

		class SampleImageSource : IImageSource 
		{
			public SampleImageSource()
			{
				imageFileAdapters = new Queue();
			}

			public void AddImageFileByRef( string filePath )
			{
				imageFileAdapters.Enqueue( new ImageFileAdapter( filePath, false ) );
			}

			public void AddImageFileByValue( string filePath )
			{
				imageFileAdapters.Enqueue( new ImageFileAdapter( filePath, true ) );
			}

			// IImageSource ///////////////////
			public string GetName() { return "Sample Image Source"; }
			public IFileAdapter GetNextImageFile()
			{
				// If the image source is accessed from multiple threads (as in the Processors Pool
				// sample) this method must be thread-safe. In this sample the lock should be uncommented
				
				// lock( this ) {
					if( imageFileAdapters.Count > 0 ) {
						return (IFileAdapter)imageFileAdapters.Dequeue();
					}
					return null;
				// }
			}
			public IImage GetNextImage() { return null; } // this sample source does not use this feature
			
			#region IMPLEMENTATION

			class ImageFileAdapter : IFileAdapter 
			{
				public ImageFileAdapter( string _filePath, bool _marshalByValue )
				{
					filePath = _filePath;
					marshalByValue = _marshalByValue;
				}

				// IFileAdapter ////////////////////
				public FileMarshallingTypeEnum GetMarshallingType() 
				{ 
					if( marshalByValue ) {
						return FileMarshallingTypeEnum.FMT_MarshalByValue;
					}
					return FileMarshallingTypeEnum.FMT_MarshalByReference; 
				}
				public string GetFileReference() 
				{ 
					if( marshalByValue ) {			
						// When marshalling by value, this method is allowed to return any string (empty string included).
						// If provided, the string is considered to describe the origin of the file and may be used as
						// a string in error messages and as part of the image origin info in generated pages. 
						// These samples are also valid:
						//		return "";
						//		return "from: smith@mail.com";
						
						// Here we just choose to use the path to the original file
						return filePath;
					} else {
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
					if( marshalByValue ) {
						return new ReadStream( filePath ); 
					} else {
						// This method is called only if marshalled by value
						assert( false );
						return null;
					}
				}
			
				#region IMPLEMENTATION

				class ReadStream : IReadStream
				{
					public ReadStream( string fileName )
					{
						currentPos = 0;

						using( FileStream stream = File.Open( fileName, FileMode.Open ) )
						{
							int length = (int)stream.Length;
							bytes = new byte[length];
							stream.Read( bytes, 0, length );
						}
					}

					public int Read( out Array data, int count )
					{
						if( buf == null || buf.Length < count ) {
						    buf = new byte[count];
                        }
						
                        int readBytes = Math.Min( count, bytes.Length - currentPos );
                        if( readBytes > 0 ) {
                            Buffer.BlockCopy( bytes, currentPos, buf, 0, readBytes );
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

		// Error Handling ///////////////////////////////////////////////////////////

		enum ErrorHandlingStrategy {
			LogAndContinue,
			LogAndRetry,
			ThrowException
		};

		static void processError( IProcessingError error, IFlexiCaptureProcessor processor, ErrorHandlingStrategy strategy )
		{
			assert( error != null );

			// You can store the problematic image for later analysis
			if( error.ImageFile() != null ) {
				string imageReference = error.ImageFile().GetFileReference();
			}
						
			// And use different strategies to handle the error
			switch( strategy ) {
				// 1) Log the error and continue
				case ErrorHandlingStrategy.LogAndContinue:
					trace( "Processing error: " + error.MessageText() );
					return;
				// 2) Retry
				case ErrorHandlingStrategy.LogAndRetry:
					trace( "Processing error: " + error.MessageText() );
					// Resume processing from the position where error occurred
					processor.ResumeProcessing( true );
					return;
				// 3) Break processing
				case ErrorHandlingStrategy.ThrowException:
					// This will reset the processing state (image queue, error condition, etc.) but keep 
					// the processing configuration (loaded templates and processing params). You can omit this
					// call if you do not plan to reuse the processor instance or reset the processor elsewhere
					processor.ResetProcessing();
					throw new Exception( error.MessageText() );		
			}
		}

		static void processNotMatched( IDocument document )
		{
			assert( document != null );

			// The document contains the page(s) that could not be matched. Normally this is a single page
			// from the image queue. This might not be the case for multipage images with AM_DocumentPerFile
			// assembling mode
			assert( document.Pages.Count > 0 );

			// You can store the problematic image for later analysis, the most straightforward approach being:
			string imageReference = document.Pages[0].OriginalImagePath;

			// In this sample we expect that all images should be matched. In the real world scenario
			// some images will not be matched. This case should be treated according to your requirements
			assert( false );
		}

		// Document Structure ///////////////////////////////////////////////////////////

		static void recursiveProcessWithChildren( IField node )
		{
			traceBegin( node.Name + " [" + node.Type.ToString() + "]" );
			recursiveProcessInstancesAndChildren( node );
			traceEnd( "" );
		}
		static void recursiveProcessWithChildren( IField node, int index  )
		{
			// This is an instance of a repeating node
			traceBegin( "[" + index.ToString() + "]" );
			recursiveProcessInstancesAndChildren( node );
			traceEnd( "" );
		}
		static void recursiveProcessInstancesAndChildren( IField node )
		{
			if( node.Instances != null ) {
				IFieldInstances instances = node.Instances;
                int count = 0;
				foreach( IField field in instances ) {
					recursiveProcessWithChildren( field, count++ );
				}
			} else if( node.Children != null ) {
				foreach( IField field in node.Children ) {
					recursiveProcessWithChildren( field );
				}
			}
		}

		static void recursiveProcessWithChildren( IBlock node )
		{
			traceBegin( node.Type.ToString() );
			if( node.Children != null ) {
				foreach( IBlock block in  node.Children ) {
					recursiveProcessWithChildren( block );
				}
			}
			traceEnd( "" );
		}

		// Custom Export ///////////////////////////////////////////////////////////

		class SimpleXMLExporter
		{
			public static void Export( IDocument document, string filePath )
			{
				// Write XML as a simple text file. This sample can be used as a starting point
				// for implementing custom export to text-based formats

				using( StreamWriter stream = File.CreateText( filePath ) ) {
					stream.WriteLine( "<?xml version='1.0' encoding='UTF-8'?>" );
					exportDocument( stream, document );
				}
			}

			#region IMPLEMENTATION

			static void exportDocument( StreamWriter stream, IDocument document )
			{
				IDocumentDefinition def = document.DocumentDefinition;
				assert( def != null );
				stream.WriteLine( "<" + def.Name + ">" );
				exportChildren( stream, document.Sections );
				stream.WriteLine( "</" + def.Name + ">" );
			}

			static void exportField( StreamWriter stream, IField field )
			{
				assert( field != null );

				string attributes = "";
				if( field.Value != null ) {
					attributes = " Value = '" + field.Value.AsString + "'";
				}

				if( field.Instances != null ) {
					exportInstances( stream, field.Instances );
				} else if ( field.Children != null ) {
					stream.WriteLine( "<" + field.Name + attributes + ">" );
					exportChildren( stream, field.Children );
					stream.WriteLine( "</" + field.Name + ">" );
				} else {
					stream.WriteLine( "<" + field.Name + attributes + "/>" );
				}
			}

			static void exportChildren( StreamWriter stream, IFields children )
			{
				assert( children != null );
			
				foreach( IField field in children ) {
					exportField( stream, field );
				}
			}

			static void exportInstances( StreamWriter stream, IFieldInstances instances )
			{
				assert( instances != null );
			
				foreach( IField field in instances ) {
					exportField( stream, field );
				}
			}

			#endregion
		}

		class MappedXMLExporter
		{
			public static void Export( IDocument document, string filePath )
			{
				// Write XML using standard .NET Framework tools. Maps elements to
				// a customized schema
				
				System.Xml.XmlTextWriter xwriter = new System.Xml.XmlTextWriter( filePath, System.Text.Encoding.UTF8 );
				try {
					xwriter.WriteStartDocument( true );
					exportDocument( xwriter, document );
					xwriter.WriteEndDocument();
				} finally {
					xwriter.Close();
				}
			}

			#region THE MAP

			// We will map documents of the specified type to a customized schema
			static string DocumentType = "Invoice_eng";
			static string XmlSchema = "http://www.mycompany.com/Schemas/MyInvoice.xsd";
			
			static string MapName( string name )
			{
				switch( name ) {
					case "Invoice_eng": return "Invoice";
					case "Invoice": return "Data";
					case "InvoiceNumber": return "Id";
					case "InvoiceDate": return "Date";
					case "InvoiceTable": return "InvoiceEntry";
					default: 
						return name.Replace( ' ', '_' );
				}
			}

			#endregion

			#region IMPLEMENTATION

			static void exportDocument( System.Xml.XmlTextWriter xwriter, IDocument document )
			{
				IDocumentDefinition def = document.DocumentDefinition;
				assert( def != null );
				
				assert( def.Name == DocumentType );
				
				xwriter.WriteStartElement( MapName( def.Name ), XmlSchema );
				exportChildren( xwriter, document.Sections );
				xwriter.WriteEndElement();
			}

			static void exportField( System.Xml.XmlTextWriter xwriter, IField field )
			{
				assert( field != null );

				if( field.Instances != null ) {
					exportInstances( xwriter, field.Instances );
				} else {
					xwriter.WriteStartElement( MapName( field.Name ) );
					if( field.Value != null ) {
						xwriter.WriteAttributeString( "Value", field.Value.AsString );
					}
					if( field.Children != null ) {
						exportChildren( xwriter, field.Children );
					}
					xwriter.WriteEndElement();
				} 				
			}

			static void exportChildren( System.Xml.XmlTextWriter xwriter, IFields children )
			{
				assert( children != null );
			
				foreach( IField field in children ) {
					exportField( xwriter, field );
				}
			}

			static void exportInstances( System.Xml.XmlTextWriter xwriter, IFieldInstances instances )
			{
				assert( instances != null );
			
				foreach( IField field in instances ) {
					exportField( xwriter, field );
				}
			}

			#endregion
		}

		class ImageExporter
		{
			public static void ExportToPng( IDocument document, string folder )
			{
				IDocumentDefinition def = document.DocumentDefinition;
				assert( def != null );

				saveToPng( folder, def.Name, document );
			}

			public static void ExportToMultipageTiff( IDocument document, string folder )
			{
				IDocumentDefinition def = document.DocumentDefinition;
				assert( def != null );

				saveToMultipageTiff( folder, def.Name, document );
			}

			#region IMPLEMENTATION

			static void saveToPng( string folder, string prefix, IDocument document )
			{
				// Extract all document pages as bitmaps
				Bitmap[] pageBitmaps = extractPages( document );
				try {
					// Save each page to a separate file
					for( int i = 0; i < pageBitmaps.Length; i++ ) {
						using( FileStream stream = File.Create( folder + "\\" + prefix + "_" + i.ToString() + ".png" ) ) {
							pageBitmaps[i].Save( stream, ImageFormat.Png );
						}
					}
				} finally {
					// To better manage resources, it is highly recommended that
					// all bitmaps should be disposed of explicitly
					disposePages( pageBitmaps );
				}
			}

			static void saveToMultipageTiff( string folder, string prefix, IDocument document )
			{
				// Extract all document pages as bitmaps
				Bitmap[] pageBitmaps = extractPages( document );
				try {
				
					// BUG_FIX. GDI+ ignores the palette when saving black and white TIFF files which may
					// result in inverted images if the actual palette differs from some default palette
					// (which is the case with the bitmaps generated by FlexiCapture Engine). To cure 
					// this problem we will invert bitmaps before saving:
					foreach( Bitmap page in pageBitmaps ) {
						invertBitmap( page );
					}
					
					using( FileStream stream = File.Create( folder + "\\" + prefix + ".tif" ) ) {
						ImageCodecInfo tiffCodec = getImageEncoder( ImageFormat.Tiff );
						if( pageBitmaps.Length == 1 ) {
							// Single-page document
							pageBitmaps[0].Save( stream, tiffCodec, tiffSinglePageCCITT4() );
						} else {
							// Multipage document
							System.Drawing.Image image = pageBitmaps[0];
							// Save the first page
							image.Save( stream, tiffCodec, tiffFirstPageCCITT4() );
							// Save more pages
							for( int i = 1; i < pageBitmaps.Length; i++ ) {
								image.SaveAdd( pageBitmaps[i], tiffAddPage() );
							}
							// Flush internal buffers
							image.SaveAdd( tiffFlush() );
						}
					}
				} finally {
					// To better manage resources, it is highly recommended that
					// all bitmaps should be disposed of explicitly
					disposePages( pageBitmaps );
				}
			}

			static Bitmap[] extractPages( IDocument document )
			{
				int pageCount = document.Pages.Count;
				if( pageCount > 0 ) {
					Bitmap[] result = new Bitmap[pageCount];
					for( int i = 0; i < pageCount; i++ ) {
						// Load the document page image and convert it to System.Drawing.Bitmap
						IImageDocument pageImageDocument = document.Pages[i].ReadOnlyImage;
						IImage pageBWImage = pageImageDocument.BlackWhiteImage;
						IHandle hBitmap = pageBWImage.GetPicture( null, 0 );
						result[i] = Image.FromHbitmap( hBitmap.Handle );
						hBitmap.CloseHandle();
					}
					return result;
				}
				return null;
			}

			static void disposePages( Bitmap[] pageBitmaps )
			{
				foreach( Bitmap bmp in pageBitmaps ) {
					bmp.Dispose();
				}
			}

			static ImageCodecInfo getImageEncoder( ImageFormat format )
			{
				ImageCodecInfo[] codecs = ImageCodecInfo.GetImageEncoders();
				foreach( ImageCodecInfo codec in codecs ) {
					if( codec.FormatID == format.Guid ) {
						return codec;
					}
				}
				return null;
			}

			static EncoderParameters tiffSinglePageCCITT4()
			{
				EncoderParameters encoderParams = new EncoderParameters( 1 );
				encoderParams.Param[0] = new EncoderParameter( Encoder.Compression, (long)EncoderValue.CompressionCCITT4 );
				return encoderParams;
			}

			static EncoderParameters tiffFirstPageCCITT4()
			{
				EncoderParameters encoderParams = new EncoderParameters( 2 );
				encoderParams.Param[0] = new EncoderParameter( Encoder.Compression, (long)EncoderValue.CompressionCCITT4 );
				encoderParams.Param[1] = new EncoderParameter( Encoder.SaveFlag, (long)EncoderValue.MultiFrame );
				return encoderParams;
			}

			static EncoderParameters tiffAddPage()
			{
				EncoderParameters encoderParams = new EncoderParameters( 1 );
				encoderParams.Param[0] = new EncoderParameter( Encoder.SaveFlag, (long)EncoderValue.FrameDimensionPage );
				return encoderParams;
			}

			static EncoderParameters tiffFlush()
			{
				EncoderParameters encoderParams = new EncoderParameters( 1 );
				encoderParams.Param[0] = new EncoderParameter( Encoder.SaveFlag, (long)EncoderValue.Flush );
				return encoderParams;
			}

			static void invertBitmap( Bitmap bmp )
			{
				BitmapData bitmapData = bmp.LockBits( 
					new Rectangle( 0, 0, bmp.Width, bmp.Height ), 
					ImageLockMode.ReadWrite, PixelFormat.Format1bppIndexed );

				try {
					for( int h = 0; h < bitmapData.Height; h++ ) {
						for( int w = 0; w < Math.Abs( bitmapData.Stride ); w++ ) {
							byte srcByte = Marshal.ReadByte( bitmapData.Scan0, h * bitmapData.Stride + w );
							Marshal.WriteByte( bitmapData.Scan0, h * bitmapData.Stride + w, (byte)~srcByte );
						}
					}
				} finally {
            		bmp.UnlockBits( bitmapData );
				}
			}
            			
			#endregion
		}

		// Sample Streams ///////////////////////////////////////////////////////////

		class SampleReadStream : IReadStream
		{
			public SampleReadStream( string fileName )
			{
				currentPos = 0;

				using( FileStream stream = File.Open( fileName, FileMode.Open, FileAccess.Read ) )
				{
					int length = (int)stream.Length;
					bytes = new byte[length];
					stream.Read( bytes, 0, length );
				}
			}

			public int Read( out Array data, int count )
			{
				// (!) in .NET Framework 3.5 or later you can use Array.BlockCopy to increase performance (!)
				
				if( buf == null || buf.Length < count ) {
					buf = new byte[count];
                }
				
				int readBytes = 0;
				for( int i = 0; i < count && currentPos < bytes.Length; i++, currentPos++, readBytes++ ) {
					buf[i] = bytes[currentPos];
				}

				data = buf;
				return readBytes;
			}
			public void Close()
			{
				bytes = null;
				buf = null;
			}

			uint currentPos = 0;
			byte[] bytes = null;
			byte[] buf = null;
		}

		class SampleWriteStream : IWriteStream
		{
			public SampleWriteStream( string fileName )
			{
				stream = File.Open( fileName, FileMode.OpenOrCreate, FileAccess.Write );
			}

			public void Write( Array data )
			{
				byte[] bytes = data as byte[];
				stream.Write( bytes, 0, bytes.Length );
			}

			public void Close()
			{
				stream.Close();
			}
			
			FileStream stream;
		}

		// Sample Reference Manager ///////////////////////////////////////////////////////////

		class SampleReferenceManager : IReferenceManager
		{
			public IFileAdapter ResolveReference ( string fileReference )
			{
				assert( fileReference.Substring( 0, 10 ) == "protocol:\\" );

				string localPath = SamplesFolder + "\\" + fileReference.Substring( 10 );

				return new FileAdapter( localPath, false );
			}

			#region IMPLEMENTATION

			class FileAdapter : IFileAdapter 
			{
				public FileAdapter( string _filePath, bool _marshalByValue )
				{
					filePath = _filePath;
					marshalByValue = _marshalByValue;
				}

				// IFileAdapter ////////////////////
				public FileMarshallingTypeEnum GetMarshallingType() 
				{ 
					if( marshalByValue ) {
						return FileMarshallingTypeEnum.FMT_MarshalByValue;
					}
					return FileMarshallingTypeEnum.FMT_LocalPath; 
				}
				public string GetFileReference() 
				{ 
					if( marshalByValue ) {			
						// When marshalling by value, this method is allowed to return any string (empty string included).
						// If provided, the string is considered to describe the origin of the file and may be used as
						// a string in error messages and as part of the origine info in generated pages. 
						// These samples are also valid:
						//		return "";
						//		return "from: smith@mail.com";
						
						// Here we just choose to use the path to the original file
						return filePath;
					} else {
						// When marshalling by reference (which is the recommended method), the returned value
						// must be a reference which can be resolved by the specified reference manager or
						// a path in the file system (which is considered as the default reference manager if
						// none is explicitly set)

						// These samples may be also valid if the reference manager, capable of resolving
						// such referenced is provided:
						//		return @"http://storage/images?id=123";
						//		return "1&Jh5K(D:";

						// In this sample we use the path in the file system
						return filePath;
					}
				}
				public IReadStream GetFileStream() 
				{ 
					if( marshalByValue ) {
						return new ReadStream( filePath ); 
					} else {
						// This method is called only if marshalled by value
						assert( false );
						return null;
					}
				}
			
				#region IMPLEMENTATION

				class ReadStream : IReadStream
				{
					public ReadStream( string fileName )
					{
						currentPos = 0;

						using( FileStream stream = File.Open( fileName, FileMode.Open ) )
						{
							int length = (int)stream.Length;
							bytes = new byte[length];
							stream.Read( bytes, 0, length );
						}
					}

					public int Read( out Array data, int count )
					{	
						// (!) in .NET Framework 3.5 or later you can use Array.BlockCopy to increase performance (!)
						
						if( buf == null || buf.Length < count ) {
						    buf = new byte[count];
                        }
				
						int readBytes = 0;
						for( int i = 0; i < count && currentPos < bytes.Length; i++, currentPos++, readBytes++ ) {
							buf[i] = bytes[currentPos];
						}
						
						data = buf;
						return readBytes;
					}
					public void Close()
					{
						bytes = null;
						buf = null;
					}

					uint currentPos = 0;
					byte[] bytes = null;
					byte[] buf = null;
				}
				
				string filePath;
				bool marshalByValue;
				
				#endregion
			};

			#endregion
		};

		// Auxiliary Tools ///////////////////////////////////////////////////////////

		static IDocument PrepareNewRecognizedDocument( IEngine engine )
		{
			IFlexiCaptureProcessor processor;
			return PrepareNewRecognizedDocument( engine, out processor );
		}

		static IDocument PrepareNewRecognizedDocument( IEngine engine, out IFlexiCaptureProcessor processor )
		{
			// Create and configure an instance of FlexiCapture processor
			processor = engine.CreateFlexiCaptureProcessor();
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

		///////////////////////////////////////////////////////////////////////////////

		static void recursiveCheckVerified( IEngine engine, IField field ) 
        {
            if( field.Value != null ) {
                assert( !field.Value.NeedsVerification );
				if( field.Value.Type == FieldValueTypeEnum.FVT_Text ) {
					IText text = field.Value.AsText;
					ICharParams p = engine.CreateCharParams();
					for( int i = 0; i < text.Length; i++ ) {
						text.GetCharParams( i, p );
						assert( !p.NeedsVerification );
					}
				}
            }
            recursiveCheckVerified( engine, field.Instances );
            recursiveCheckVerified( engine, field.Children );
        }

        static void recursiveCheckVerified( IEngine engine, IFields fields )
        {
            if( fields != null ) {
                for( int i = 0; i < fields.Count; i++ ) {
                    recursiveCheckVerified( engine, fields[i] );
                }
            }
        }
        static void recursiveCheckVerified( IEngine engine, IFieldInstances fields ) 
        {
             if( fields != null ) {
                foreach( IField field in fields ) {
                    recursiveCheckVerified( engine, field );
                }
            }
        }

		///////////////////////////////////////////////////////////////////////////////

		#endregion
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
