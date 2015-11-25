// © 2015 ABBYY Production LLC. 
// ABBYY, FLEXICAPTURE and FLEXILAYOUT are either registered trademarks or trademarks of ABBYY Software Ltd.
// SAMPLES code is property of ABBYY, exclusive rights are reserved. 
// DEVELOPER is allowed to incorporate SAMPLES into his own APPLICATION and modify it 
// under the terms of License Agreement between ABBYY and DEVELOPER.

// Product: ABBYY FlexiCapture Engine 11
// Description: Advanced techniques

using System;
using System.Collections;
using System.Drawing;
using System.Runtime.InteropServices;

using FCEngine;

namespace Sample
{
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Advanced techniques

	class AdvancedTechniques : FlexiCaptureEngineSnippets
	{
        // USE CASE: Creating a Document Definition by training on a set of images
		public static void Creating_a_Document_Definition_by_training_on_a_set_of_images( IEngine engine )
		{
            string rootFolder = SamplesFolder + "\\SampleImages\\Training\\ISBN";
			string batchFolder = rootFolder + "\\_TrainingBatch";
            if( System.IO.Directory.Exists( batchFolder ) ) {
				// Delete the existing training batch
                System.IO.Directory.Delete( batchFolder, true );
            }

            trace( "Create training batch and populate it with images..." );
            ITrainingBatch trainingBatch = engine.CreateTrainingBatch( batchFolder, "English" );
            try {
				ITrainingDefinition newDefinition = trainingBatch.Definitions.AddNew( "ISBN" );

                trainingBatch.AddImageFile( rootFolder + "\\00.jpg" );
                trainingBatch.AddImageFile( rootFolder + "\\01.jpg" );

                trace( "Use the first page to define document structure..." );
				ITrainingPage firstPage = trainingBatch.Pages[0];
				// Each page must be prepared before trying to work with its layout. At this stage the page is analyzed
				// and primitive image objects are extracted (which can be used as helpers in user imterface). 
				// Than an attempt is made to predict the page layout based on the layout of verified pages if any.
				firstPage.PrepareLayout();
                // At this point the user must draw boxes for fields and references. In this sample we try to emulate this 
				// behavior by 'looking' for known text strings and 'drawing' fields around them.
                foreach( ITrainingImageObject obj in firstPage.ImageObjects ) {
                    string text = obj.RecognizedText;
					if( text != null ) {
						if( text == "978-1-4095-3439-6" ) {
							// We want to extact this field. Create a data field and define its geometry on the current page.
							ITrainingField isbnField = newDefinition.Fields.AddNew( "ISBN", TrainingFieldTypeEnum.TFT_Field );
							firstPage.SetFieldBlock( isbnField, obj.Region );
							break;
						}
					}
				}
				foreach( ITrainingImageObject obj in firstPage.ImageObjects ) {
                    string text = obj.RecognizedText;
                    if( text == "ISBN" ) {
						// We want to use this text for reference. Create a reference element and define its geometry on the current page.
						ITrainingField isbnTag = newDefinition.Fields.AddNew( "ISBNTag", TrainingFieldTypeEnum.TFT_ReferenceText );
                        firstPage.SetFieldBlock( isbnTag, obj.Region );
						break;
                    }
                }               
				assert( newDefinition.Fields.Count == 2 );
				// Now that we are done with this page, mark it as verified and ready for training.
				trainingBatch.SubmitPageForTraining( firstPage );

                traceBegin( "Verify the computed layout on the remaining pages..." );
                for( int i = 1; i < trainingBatch.Pages.Count; i++ ) {
                    traceBegin( i.ToString() + "..." );
                    ITrainingPage page = trainingBatch.Pages[i];
                    page.PrepareLayout();
                    // At this point the user must verify and correct the computed layout. In this sample we assume that 
					// the computed layout is correct, so we just mark the page as verified and ready for training.
                    trainingBatch.SubmitPageForTraining( page );
                    traceEnd( "OK" );
                }
                traceEnd( "OK" );

                trace( "Export to AFL..." );
                newDefinition.ExportToAFL( batchFolder + "\\NewTemplate.afl" );
            } finally {
                trainingBatch.Close();
            }

            trace( "Create document definition." );
            IDocumentDefinition newDocumentDefinition = engine.CreateDocumentDefinitionFromAFL( batchFolder + "\\NewTemplate.afl", "English" );
			
			trace( "Use the new document definition with FlexiCapture Processor." );
			CheckTrainedDocumentDefinition( engine, newDocumentDefinition, rootFolder );
        }

		// USE CASE: Creating a Document Definition by training on a set of images
		public static void Creating_a_Document_Definition_by_training_on_a_set_of_images_LPAREN2RPAREN( IEngine engine )
		{
            string rootFolder = SamplesFolder + "\\SampleImages\\Training\\ISBN";
			string batchFolder = rootFolder + "\\_TrainingBatch";
            if( System.IO.Directory.Exists( batchFolder ) ) {
				// Delete the existing training batch
                System.IO.Directory.Delete( batchFolder, true );
            }

            trace( "Create training batch and populate it with images..." );
            ITrainingBatch trainingBatch = engine.CreateTrainingBatch( batchFolder, "English" );
            try {
				ITrainingDefinition newDefinition = trainingBatch.Definitions.AddNew( "ISBN" );

                trainingBatch.AddImageFile( rootFolder + "\\00.jpg" );
                trainingBatch.AddImageFile( rootFolder + "\\01.jpg" );
                
                traceBegin( "The user iterates through the added images until all the pages have been submitted for training..." );
				ITrainingPage page = trainingBatch.PrepareNextPageNotSubmittedForTraining();
                while( page != null ) {
				    traceBegin( page.ID.ToString() + "..." );
					// The user can 'draw' fields and references on any page while inside this loop. Any modification in the document definition will reset
					// the 'verified' flag for all pages and the loop will automatically reiterate through all pages. In this sample we try to emulate the 
					// user 'drawing' fields on the first page.
					if( page == trainingBatch.Pages[0] ) {
						// On the fist page we 'look' for known text strings and 'draw' fields around them
						foreach( ITrainingImageObject obj in page.ImageObjects ) {
							string text = obj.RecognizedText;
							if( text == "978-1-4095-3439-6" ) {
								// We want to extact this field. Create a data field and define its geometry on the current page.
								ITrainingField isbnField = newDefinition.Fields.AddNew( "ISBN", TrainingFieldTypeEnum.TFT_Field );
								page.SetFieldBlock( isbnField, obj.Region );
								break;
							}
						}
						foreach( ITrainingImageObject obj in page.ImageObjects ) {
							string text = obj.RecognizedText;
							if( text == "ISBN" ) {
								// We want to use this text for reference. Create a reference element and define its geometry on the current page.
								ITrainingField isbnTag = newDefinition.Fields.AddNew( "ISBNTag", TrainingFieldTypeEnum.TFT_ReferenceText );
								page.SetFieldBlock( isbnTag, obj.Region );
								break;
							}
						}
						// We assume that we have succeeded in defining two items
						assert( newDefinition.Fields.Count == 2 );
					}
					
					// After the user has defined the layout (or verified the automatically computed layout for subsequent pages), he must submit
					// the result for training. In this sample we assume that the computed layout is always correct, so just mark the page as verified 
					// and ready for training.
                    trainingBatch.SubmitPageForTraining( page );
					
					// Fetch the next page that requires attention. The method will return null when all the pages have been verified and submitted for training.
					page = trainingBatch.PrepareNextPageNotSubmittedForTraining();
                    traceEnd( "OK" );
                }
                traceEnd( "OK" );

                trace( "Export to AFL..." );
                newDefinition.ExportToAFL( batchFolder + "\\NewTemplate.afl" );
            } finally {
                trainingBatch.Close();
            }

            trace( "Create document definition." );
            IDocumentDefinition newDocumentDefinition = engine.CreateDocumentDefinitionFromAFL( batchFolder + "\\NewTemplate.afl", "English" );

            trace( "Use the new document definition with FlexiCapture Processor." );
			CheckTrainedDocumentDefinition( engine, newDocumentDefinition, rootFolder );
        }
		
		// USE CASE: Creating a Document Definition from a FlexiLayout (*.afl)
		public static void Creating_a_Document_Definition_from_a_FlexiLayout( IEngine engine )
		{
			trace( "Create a Document Definition from an *.afl file..." );
			string flexibleDescriptionFilePath = SamplesFolder + "\\SampleMisc\\Invoice_eng.afl";
			IDocumentDefinition newDefinition = engine.CreateDocumentDefinitionFromAFL(	flexibleDescriptionFilePath, "English"	);

			// You can save the new Document Definition to a file or use it from memory
            traceBegin("Use the Document Definition in FlexiCaptureProcessor...");
				IFlexiCaptureProcessor processor = engine.CreateFlexiCaptureProcessor();
				processor.AddDocumentDefinition( newDefinition );
				
				// Add images for a single document
				processor.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_1.tif" );

				// Recognize the document and check the result
				IDocument document = processor.RecognizeNextDocument();
				assert( document != null );
				assert( document.DocumentDefinition != null );
				assert( document.Pages.Count == 1 );

				// Export the result
				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "Invoice", null );
			traceEnd( "OK" );
		}

		// USE CASE: Creating a Document Definition from an XML Form Definition
		public static void Creating_a_Document_Definition_from_an_XML_Form_Definition( IEngine engine )
		{
            trace("Create a Document Definition from an *.xfd file...");
			string formDescriptionFilePath = SamplesFolder + "\\SampleMisc\\Banking_eng.xfd";
			IDocumentDefinition newDefinition = engine.CreateDocumentDefinitionFromXFD(	formDescriptionFilePath, "English"	);
			
			// Modify the template as required. In this sample we need to loosen some constraints
			IPageAnalysisParams analysisParams = engine.CreatePageAnalysisParams();
			analysisParams.CopyFrom( newDefinition.PageAnalysisParams );
			analysisParams.MaxHorizontalShrinkPercent = 20;
			analysisParams.MaxVerticalShrinkPercent = 20;
			newDefinition.PageAnalysisParams = analysisParams;

			// You can save the new Document Definition to a file or use it from memory
            traceBegin("Use the Document Definition in FlexiCaptureProcessor...");
				IFlexiCaptureProcessor processor = engine.CreateFlexiCaptureProcessor();
				processor.AddDocumentDefinition( newDefinition );
				
				// Add images for a single multipage document
				processor.AddImageFile( SamplesFolder + "\\SampleImages\\Banking_1.tif" );
				processor.AddImageFile( SamplesFolder + "\\SampleImages\\Banking_2.tif" );
				processor.AddImageFile( SamplesFolder + "\\SampleImages\\Banking_3.tif" );

				// Recognize the document and check the result
				IDocument document = processor.RecognizeNextDocument();
				assert( document != null );
				assert( document.DocumentDefinition != null );
				assert( document.Pages.Count == 3 );

				// Export the result
				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "Banking", null );
			traceEnd( "OK" );
		}

		// USE CASE: Creating a compound Document Definition
		public static void Creating_a_compound_Document_Definition( IEngine engine )
		{
			trace( "Create an empty Document Definition in memory..." );
			IDocumentDefinition newDefinition = engine.CreateDocumentDefinition();
			assert( newDefinition != null );
			
			trace( "Set default language..." );
			ILanguage language = engine.PredefinedLanguages.FindLanguage( "English" );
			assert( language != null );
			newDefinition.DefaultLanguage = language;
						
			trace( "Create a new fixed section from an XFD file..." );
			newDefinition.DefaultTextType = TextTypeEnum.TT_Handprinted;
			ISectionDefinition newSection1 = newDefinition.Sections.AddNew( "Banking" );
			newSection1.LoadXFDDescription( SamplesFolder + "\\SampleMisc\\Banking_eng.xfd" );
		
			trace( "Create a new flexible section from an AFL file..." );
			newDefinition.DefaultTextType = TextTypeEnum.TT_Normal;
			ISectionDefinition newSection2 = newDefinition.Sections.AddNew( "Invoice" );
			newSection2.LoadFlexibleDescription( SamplesFolder + "\\SampleMisc\\Invoice_eng.afl" );

			// Modify the template as required. In this sample we need to loosen some constraints
			IPageAnalysisParams analysisParams = engine.CreatePageAnalysisParams();
			analysisParams.CopyFrom( newDefinition.PageAnalysisParams );
			analysisParams.MaxHorizontalShrinkPercent = 20;
			analysisParams.MaxVerticalShrinkPercent = 20;
			newDefinition.PageAnalysisParams = analysisParams;

            trace("Check the Document Definition...");
			assert( newDefinition.Check() == true );

			// You can save the new Document Definition to a file or use it from memory
            traceBegin("Use the Document Definition in FlexiCaptureProcessor...");
				IFlexiCaptureProcessor processor = engine.CreateFlexiCaptureProcessor();
				processor.AddDocumentDefinition( newDefinition );
				
				// Add images for a single multipage document
				processor.AddImageFile( SamplesFolder + "\\SampleImages\\Banking_1.tif" );
				processor.AddImageFile( SamplesFolder + "\\SampleImages\\Banking_2.tif" );
				processor.AddImageFile( SamplesFolder + "\\SampleImages\\Banking_3.tif" );
				processor.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_2.tif" );
				processor.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_3.tif" );
				
				// Recognize the document
				IDocument document = processor.RecognizeNextDocument();
				assert( document != null );
				assert( document.DocumentDefinition != null );
				assert( document.Pages.Count == 5 );

				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "Mixed", null );
			traceEnd( "OK" );
		}

		// USE CASE: Configuring fields for better recognition results
		public static void Configuring_fields_for_better_recognition_results( IEngine engine )
		{
			trace( "Create a Document Definition from a FlexiLayout..." );
			IDocumentDefinition newDefinition = engine.CreateDocumentDefinitionFromAFL( SamplesFolder + "\\SampleMisc\\Invoice_eng.afl", "English" );
			assert( newDefinition != null );

			trace( "Configure data types..." );
			setFieldValueType( newDefinition, "InvoiceDate", FieldValueTypeEnum.FVT_DateTime );
			setFieldValueType( newDefinition, "Quantity", FieldValueTypeEnum.FVT_Number );
			setFieldValueType( newDefinition, "UnitPrice", FieldValueTypeEnum.FVT_Currency );
			setFieldValueType( newDefinition, "Total", FieldValueTypeEnum.FVT_Currency );
			setFieldValueType( newDefinition, "TotalAmount", FieldValueTypeEnum.FVT_Currency );
			
			trace( "Configure recognition languages for text fields ..." );
			IFieldDefinition fieldDef = findFieldDef( newDefinition, "InvoiceNumber" );
			assert( fieldDef != null );
			ITextRecognitionParams textParams = fieldDef.RecognitionParams.AsTextParams();
			ILanguage newLanguage = textParams.CreateEmbeddedLanguageByDataType( FieldValueTypeEnum.FVT_DateTime );
			textParams.Language = newLanguage;

			newLanguage = textParams.CreateEmbeddedLanguage( textParams.Language.Type, textParams.Language );
			assert( newLanguage != textParams.Language );
			assert( newLanguage.LanguageCategory == LanguageCategoryEnum.LC_DataType );
			assert( newLanguage.DatatypeCategory == DatatypeCategoryEnum.TC_DateTime );
			textParams.Language = newLanguage;
						
			newLanguage = textParams.CreateEmbeddedLanguage( LanguageTypeEnum.LT_Group, null );
			newLanguage.AsGroupLanguage().Add( engine.PredefinedLanguages.FindLanguage( "English" ) );
			newLanguage.AsGroupLanguage().Add( engine.PredefinedLanguages.FindLanguage( "Russian" ) );
			textParams.Language = newLanguage;
			assert( textParams.Language.Type == LanguageTypeEnum.LT_Group );
			assert( textParams.Language.AsGroupLanguage().Count == 2 );
			assert( textParams.Language.AsGroupLanguage().Item( 0 ).InternalName == "English" );
			assert( textParams.Language.AsGroupLanguage().Item( 1 ).InternalName == "Russian" );

			newLanguage = textParams.CreateEmbeddedLanguage( LanguageTypeEnum.LT_Simple, null );
			newLanguage.AsSimpleLanguage().set_LetterSet( LanguageLetterSetEnum.LLS_Alphabet, "ABCDEFGHIJKLMNOPQRSTUVWXYZ" );
			newLanguage.AsSimpleLanguage().RegularExpression = "[A-Z]{1-}";
			textParams.Language = newLanguage;
			assert( textParams.Language.AsSimpleLanguage().RegularExpression.Length > 0 );

			newLanguage = textParams.CreateEmbeddedLanguage( LanguageTypeEnum.LT_Simple, engine.PredefinedLanguages.FindLanguage( "English" ) );
			assert( newLanguage.AsSimpleLanguage().UsePredefinedDictionary == true );
			assert( newLanguage.AsSimpleLanguage().UseUserDefinedDictionary == false );
			assert( newLanguage.AsSimpleLanguage().UserDefinedDictionary == null );
			newLanguage.AsSimpleLanguage().UseUserDefinedDictionary = true;
			FCEngine.IDictionary dictionary = newLanguage.AsSimpleLanguage().UserDefinedDictionary;
			assert( dictionary != null );
			assert( dictionary.WordsCount == 0 );
			dictionary.AddWord( "ONE", 1 );
			dictionary.AddWord( "TWO", 1 );
			dictionary.AddWord( "THREE", 1 );
			assert( dictionary.WordsCount == 3 );
			IEnumDictionaryWords enumWords = dictionary.EnumWords();
			for( int i = 0; i < 10; i++ ) {
				int confidence = 0;
				string word = enumWords.Next( out confidence );
				if( confidence == 0 ) {
					break;
				}
				trace( word );
			}
			textParams.Language = newLanguage;
						
			trace( "Check the Document Definition..." );
			assert( newDefinition.Check() == true );

            traceBegin("Use the Document Definition in FlexiCaptureProcessor...");
				IFlexiCaptureProcessor processor = engine.CreateFlexiCaptureProcessor();
				processor.AddDocumentDefinition( newDefinition );
				
				// Add images for a single document
				processor.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_1.tif" );

				// Recognize the document
				IDocument document = processor.RecognizeNextDocument();
				assert( document != null );
				assert( document.DocumentDefinition != null );
				assert( document.Pages.Count == 1 );

				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "Invoice", null );
			traceEnd( "OK" );
		}

		// USE CASE: Loading and saving Document Definitions
		public static void Loading_and_saving_Document_Definitions( IEngine engine )
		{
			trace( "Create an empty Document Definition in memory..." );
			IDocumentDefinition documentDefinition = engine.CreateDocumentDefinition();
			assert( documentDefinition != null );
			
			trace( "Load a Document Definition from file..." );
			ICustomStorage customStorage = documentDefinition as ICustomStorage;
			assert( customStorage != null );
			customStorage.LoadFromFile( SamplesFolder + "\\SampleProject\\Templates\\Invoice_eng.fcdot" );
			
			trace( "Modify if required and check the modified version..." );
			assert( documentDefinition.Check() == true );
			
			trace( "Save the modified copy..." );
			customStorage.SaveToFile( SamplesFolder + "\\SampleProject\\Templates\\Invoice_engCOPY.fcdot" );
		}

		// USE CASE: Using image processing tools in custom preprocessing
		public static void Using_image_processing_tools_in_custom_preprocessing( IEngine engine )
		{
			trace( "Create and configure an instance of FlexiCapture processor..." );
			IFlexiCaptureProcessor processor = engine.CreateFlexiCaptureProcessor();
			
			processor.AddDocumentDefinitionFile( SamplesFolder + "\\SampleProject\\Templates\\Invoice_eng.fcdot" );
			
			trace( "Set up an image source with custom preprocessing..." );
			// Create and configure sample image source. ALL PREPROCESSING IS DONE IN THE IMAGE SOURCE
			// (see SampleImageSource class for details)
			CustomPreprocessingImageSource imageSource = new CustomPreprocessingImageSource( engine );
			imageSource.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_1.tif" );
			imageSource.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_2.tif" );
			imageSource.AddImageFile( SamplesFolder + "\\SampleImages\\Invoices_3.tif" );
			processor.SetCustomImageSource( imageSource );
					
			traceBegin( "Process the images..." );
			int count = 0;
			while( true ) {
				IDocument document = processor.RecognizeNextDocument();
				if( document == null ) {
					IProcessingError error = processor.GetLastProcessingError();
					assert( error == null ); // No errors are expected in this sample
					break;
				} else {
					// We expect that this will never happen in this sample
					assert( document.DocumentDefinition != null );
				}
				processor.ExportDocumentEx( document, SamplesFolder + "\\FCEExport", "NextDocument_" + count, null ); 
				count++;
			}
			traceEnd( "OK" );

			trace( "Check the results..." );
			assert( count == 2 );
		}

		// USE CASE: Using recognition variants and extended character info
		public static void Using_recognition_variants_and_extended_character_info( IEngine engine )
		{
			trace( "Enable recognition variants..." );
			engine.EnableRecognitionVariants( true );
			
			trace( "Prepare a sample document..." );
			IDocument document = PrepareNewRecognizedDocument( engine );
					
			trace( "Find the field of interest..." );
			IField field = findField( document, "InvoiceNumber" );
			assert( field != null );
			
			traceBegin( "Show word variants..." );
			// (1) You might want to use word variants if you know how to choose the correct result
			// and this knowledge cannot be communicated to the engine (in the form of a regular expression 
			// or dictionary) or if you decide that you can do the selection better.
			// EXAMPLES: (1) a field containing some code with a checksum (2) a field that can be looked up 
			// in a database (3) a field that can be crosschecked with another field in the same document
			IText text = field.Value.AsText;
			assert( text.RecognizedWordsCount == 1 );
			IRecognizedWordInfo wordInfo = engine.CreateRecognizedWordInfo();
			// Get the recognition info for the first word. Thus we'll know the number of available variants
			text.GetRecognizedWord( 0, -1, wordInfo );
			for( int i = 0; i < wordInfo.RecognitionVariantsCount; i++ ) {
				// Get the specified recognition variant for the word
				text.GetRecognizedWord( 0, i, wordInfo );
				trace( wordInfo.Text );
			}
			traceEnd( "" );

			traceBegin( "Show char variants for each word variant..." );
			// (2) You can use a more advanced approach and build your own hypotheses from variants
			// for individual characters. This approach can be very computationally intensive, so use it with care.
			// Use word/char variant confidence to limit the number of built hypotheses
			IRecognizedCharacterInfo charInfo = engine.CreateRecognizedCharacterInfo();
			for( int k = 0; k < wordInfo.RecognitionVariantsCount; k ++ ) {
				// For each variant of the first word
				text.GetRecognizedWord( 0, k, wordInfo );
				traceBegin( wordInfo.Text );
				for( int i = 0; i < wordInfo.Text.Length; i++ ) {
					// Get the recognition info for the first character (the number of available variants)
					wordInfo.GetRecognizedCharacter( i, -1, charInfo );
					string charVars = "";
					for( int j = 0; j < charInfo.RecognitionVariantsCount; j++ ) {
						// Get the specified recognition variant for the character. The variant may contain
						// more than one character if the geometry in the specified position can be interpreted
						// as several merged characters. For example, something which looks like poorly printed 'U' 
						// can actually be a pair of merged 'I'-s or 'I' + 'J'
						wordInfo.GetRecognizedCharacter( i, j, charInfo );
						if( charInfo.CharConfidence > 50 ) {
							charVars += charInfo.Character.PadRight( 4, ' ' );
						}
					}
					trace( charVars );
				}
				traceEnd( "" );
			}
			traceEnd( "" );

			traceBegin( "Linking text in the field to recognition variants..." );
			// (3) You can find corresponding recognition word and character variants for each character in the text
			// even if the text has been modified. This can be helpful in building your own advanced verification tools
			// where users can choose variants for words while typing or from a list
			ICharParams charParams = engine.CreateCharParams();
			for( int i = 0; i < text.Length; i++ ) {
				text.GetCharParams( i, charParams );
				trace( string.Format( "'{0}' is char number {1} in word number {2}", text.Text[i], 
					charParams.RecognizedWordCharacterIndex, charParams.RecognizedWordIndex ) );
			}
			traceEnd( "" );

			traceBegin( "Obtaining extended char information for characters in text..." );
			// (4) You can obtain extended char info for a character in the text without getting involved deeply in  
			// the recognition variants API by means of the shortcut method GetCharParamsEx
			for( int i = 0; i < text.Length; i++ ) {
				text.GetCharParamsEx( i, charParams, charInfo );
				trace( string.Format( "'{0}' serif probability is {1}", charInfo.Character, charInfo.SerifProbability ) );
			}
			traceEnd( "" );

			// Restore the initial state of the engine. It is optional and should not be done if you always
			// use recognition variants. Doing so will reset some internal caches and if done repeatedly 
			// might affect performance
			engine.EnableRecognitionVariants( false );
		}

		// USE CASE: Single click field text extraction
		public static void Single_click_field_text_extraction( IEngine engine )
		{
			// We want to implement a feature allowing the user of our application to
			// match fields on the page by simply clicking on the text in the image.
			
			trace( "Create a sample document..." );
			IDocument document = PrepareNewRecognizedDocument( engine );
			
			trace( "Extract all background text regions on a page..." );
			IPage page = document.Pages[0];
			ITextRegions textRegions = page.ExtractTextRegions();
			
			traceBegin( "Create a list of found text regions..." );
			foreach( ITextRegion textRegion in textRegions ) {
				string text = textRegion.Text.Text;
				IRectangle r = textRegion.Region.BoundingRectangle;
				trace( string.Format( "'{0}' - [{1},{2},{3},{4}]", text, r.Left, r.Top, r.Right, r.Bottom ) );
			}
			traceEnd( "" );

			// Now it is quite simple to implement the desired behavior.
			// Suppose the user 'sees' the word 'ENGLAND' and clicks on it.
			// In this sample we find the clicked region by text, in a real 
			// application we would find it as containing the clicked point

			ITextRegion clickedRegion = null;
			foreach( ITextRegion textRegion in textRegions ) {
				if( textRegion.Text.Text == "ENGLAND" ) {
					clickedRegion = textRegion;
					break;
				}
			}
			assert( clickedRegion != null );

			// In our implementation we can either use the prerecognized text for the region (which is
			// fast and usually quite accurate) or set the required field region to enclose the found text
			// region and rerecognize the field to apply field-specific recognition parameters:

			IField theField = document.Sections[0].Children[2];
			assert( theField.Name == "DeliveryAddress" );
			IBlock theBlock = theField.Blocks[0];
			
			IRegion newRegion = engine.CreateRegion();
			IRectangle br = clickedRegion.Region.BoundingRectangle;
			newRegion.AddRect( br.Left, br.Top, br.Right, br.Bottom  );
			theBlock.Region = newRegion;
			
			IBlocksCollection blocksToRerecognize = engine.CreateBlocksCollection();
			blocksToRerecognize.Add( theBlock );
            document.RecognizeBlocks( blocksToRerecognize );
			
			assert( theField.Value.AsString == "ENGLAND" );
		}

		// USE CASE: Scanning with ABBYY FlexiCapture Engine
		public static void Scanning_with_FlexiCapture_Engine( IEngine engine )
		{	
			// Create an instance of ScanManager
			trace( "Create an instance of ScanManager..." );
			IScanManager scanManager = engine.CreateScanManager();
			
			// Enumerate scan sources
			traceBegin( "Enumerate scan sources: " );
			IStringsCollection sources = scanManager.ScanSources;
			string sourcesList = "";
			if( sources.Count > 0 ) {
				foreach( string source in sources ) {
					if( sourcesList.Length > 0 ) {
						sourcesList += ", ";
					}
					sourcesList += '\'' + source + '\'';
				}
			} else {
				sourcesList = "Not Found";
			}
			traceEnd( sourcesList );

			// If at least one scan source found
			if( sources.Count > 0 ) {
				// In this sample we will be using the first found scan source
				string scanSource = sources[0];
				
				// You can optionally change the scan source settings or leave defaults
				// trace( "Configure scan source " + '\'' + scanSource + '\'' );
				// IScanSourceSettings sourceSettings = scanManager.get_ScanSourceSettings( scanSource );
				// sourceSettings.PictureMode = ScanPictureModeEnum.SPM_Grayscale;
				// scanManager.set_ScanSourceSettings( scanSource, sourceSettings );

				// Prepare a directory to store scanned images
				string scanFolder = SamplesFolder + "\\FCEScanning";
				System.IO.Directory.CreateDirectory( scanFolder );

				if( IsInteractive ) {
					// If the scenario is being run in interactive mode you can try scanning by uncommenting the lines below
					trace( "Scanning is disabled." );
					// traceBegin( "Scanning... " );
					// Get a single image from the scan source
					// IStringsCollection imageFiles = scanManager.Scan( scanSource, scanFolder, false );
					// assert( imageFiles.Count == 1 );
					// assert( System.IO.File.Exists( imageFiles[0] ) );
					// System.IO.File.Delete( imageFiles[0] );
					// traceEnd( "OK" );
				} else {
					trace( "Running in non-interactive mode. Scanning skipped." );
				}
			}
		}

		#region Sample Auxiliary Classes and Methods

		// Auxiliary Tools ///////////////////////////////////////////////////////////

		static IFieldDefinition setFieldValueType( IDocumentDefinition documentDefinition, string fieldName, FieldValueTypeEnum valueType )
		{
			IFieldDefinition field = findFieldDef( documentDefinition, fieldName );
			assert( field != null );
			assert( field.ValueType == FieldValueTypeEnum.FVT_Text );
			field.ValueType = valueType;
			assert( field.ValueType == valueType );
			return field;
		}

		static IFieldDefinition findFieldDef( IDocumentDefinition documentDefinition, string name )
		{
			IFieldDefinition root = documentDefinition as IFieldDefinition;
			return recursiveFindFieldDef( root, name );
		}

		static IFieldDefinition recursiveFindFieldDef( IFieldDefinition node, string name )
		{
			IFieldDefinitions children = node.Children;
			if( children != null ) {
				foreach( IFieldDefinition child in children ) {
					if( child.Name == name ) {
						return child;
					} else {
						IFieldDefinition found = recursiveFindFieldDef( child, name );
						if( found != null ) {
							return found;
						}
					}
				}
			}
			return null;
		}

		static IField findField( IDocument document, string name )
		{
			IField root = document as IField;
			return recursiveFindField( root, name );
		}

		static IField recursiveFindField( IField node, string name )
		{
			IFields children = node.Children;
			if( children != null ) {
				foreach( IField child in children ) {
					if( child.Name == name ) {
						return child;
					} else {
						IField found = recursiveFindField( child, name );
						if( found != null ) {
							return found;
						}
					}
				}
			}
			return null;
		}

		class CustomPreprocessingImageSource : IImageSource 
		{
			public CustomPreprocessingImageSource( IEngine engine )
			{
				fileNames = new Queue();
				imageTools = engine.CreateImageProcessingTools();
			}

			public void AddImageFile( string filePath )
			{
				fileNames.Enqueue( filePath );
			}

			// IImageSource ///////////////////
			public string GetName() { return "Custom Preprocessing Image Source"; }
			public IFileAdapter GetNextImageFile() 
			{ 
				// You could apply an external tool to a file and return the reference
				// to the resulting image file. This sample source does not use this feature
				return null; 
			} 
			public IImage GetNextImage() 
			{ 
				while( true ) {
					if( imageFile == null ) {
						if( fileNames.Count > 0 ) {
							imageFile = imageTools.OpenImageFile( (string)fileNames.Dequeue() );
							nextPageIndex = 0;
						} else {
							return null;
						}
					}
					assert( imageFile != null );
					if( nextPageIndex < imageFile.PagesCount ) {
						IImage nextPage = imageFile.OpenImagePage( nextPageIndex++ );
						
						// Here you can apply any required preprocessing to the image in memory
						// using built-in IImageProcessingTools (see description), your own algorithms or
						// third-party components
						// ...
						
						return nextPage;
					} else {
						imageFile = null;
						continue;
					}
				}
			} 
			
			#region IMPLEMENTATION

			IImageProcessingTools imageTools;
			
			Queue fileNames;
			IImageFile imageFile;
			int nextPageIndex;

			#endregion
		};

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

		static void CheckTrainedDocumentDefinition( IEngine engine, IDocumentDefinition newDocumentDefinition, string rootFolder )
		{
            IFlexiCaptureProcessor processor = engine.CreateFlexiCaptureProcessor();
            processor.AddDocumentDefinition( newDocumentDefinition );
            processor.AddImageFile( rootFolder + "\\02.jpg" );
            processor.AddImageFile( rootFolder + "\\03.jpg" );
            
            IDocument document = processor.RecognizeNextDocument();
            assert( document.DocumentDefinition != null );
            assert( document.Pages.Count == 1 );
            assert( document.Sections[0].Children[0].Name == "ISBN" );
            assert( document.Sections[0].Children[0].Value.AsString == "0-517-59939-2" );

            document = processor.RecognizeNextDocument();
            assert( document.DocumentDefinition != null );
            assert( document.Pages.Count == 1 );
            assert( document.Sections[0].Children[0].Name == "ISBN" );
            assert( document.Sections[0].Children[0].Value.AsString == "0-8050-6176-2" );
		}

		/////////////////////////////////////////////////////////////////////////////////

		#endregion
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
