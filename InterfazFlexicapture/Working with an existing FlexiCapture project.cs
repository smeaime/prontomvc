// © 2015 ABBYY Production LLC. 
// ABBYY, FLEXICAPTURE and FLEXILAYOUT are either registered trademarks or trademarks of ABBYY Software Ltd.
// SAMPLES code is property of ABBYY, exclusive rights are reserved. 
// DEVELOPER is allowed to incorporate SAMPLES into his own APPLICATION and modify it 
// under the terms of License Agreement between ABBYY and DEVELOPER.

// Product: ABBYY FlexiCapture Engine 11
// Description: Working with an existing FlexiCapture project

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
	// Working with an existing FlexiCapture project

	class WorkingWithFlexiCaptureProject : FlexiCaptureEngineSnippets
	{	
		// USE CASE: Using a configured FlexiCapture project to recognize image files
		public static void Using_a_configured_FlexiCapture_project_to_recognize_image_files( IEngine engine )
		{	
			trace( "Open the sample project..." );
			IProject project = engine.OpenProject( SamplesFolder + "\\SampleProject\\Invoices_eng.fcproj" );

			try {		
				trace( "Add a new batch..." );
				IBatch batch = project.Batches.AddNew( "TestBatch" );

				trace( "Open the batch..." );
				batch.Open();

				try {
					trace( "Add image files to the batch..." );
					batch.AddImage( SamplesFolder + "\\SampleImages\\Invoices_1.tif" );
					batch.AddImage( SamplesFolder + "\\SampleImages\\Invoices_2.tif" );
					batch.AddImage( SamplesFolder + "\\SampleImages\\Invoices_3.tif" );

					trace( "Recognize all images in the batch..." );
					batch.Recognize( null, RecognitionModeEnum.RM_ReRecognizeMinimal, null );
					
					trace( "Export the results..." );
					batch.Export( null, null );

					trace( "Close and delete the batch..." );
				} finally {
					batch.Close(); // Before the batch could be deleted, it has to be closed
					project.Batches.DeleteAll();
				}
				
				trace( "Close the project..." );
			} finally {
				project.Close();
			}
		}

		// USE CASE: Verifying recognized documents
		public static void Verifying_recognized_documents( IEngine engine )
		{
			trace( "Open the sample project..." );
			IProject project = engine.OpenProject( SamplesFolder + "\\SampleProject\\Invoices_eng.fcproj" );

			try {
				trace( "Prepare a new batch for verification..." );
				IBatch batch = PrepareNewRecognizedBatch( engine, project );
				try {
					traceBegin( "Run verification..." );
					
					trace( "Start verification session (all documents in the batch)..." );
					IVerificationSession verificationSession = batch.StartVerification( null );
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
					} finally {
						// Verification consumes considerable system resources (many simultaniously
						// open and loaded documents and images). So it is VERY important that
						// these resources should be released in timely manner and not left for 
						// garbage collector to manage.
						verificationSession.Close();
					}

					trace( "Check that the documents do not need verification now..." );
					foreach( IDocument document in  batch.Documents ) {
						document.Open( false );
						try {
							recursiveCheckVerified( engine, document.Sections );
						} finally {
							document.Close( false );
						}
					}

					traceEnd( "OK" );

				} finally {
					batch.Close();
					project.Batches.DeleteAll();
				}

			} finally {
				project.Close();
			}
			
			traceEnd( "OK" );
		}

		// USE CASE: Using batch processing events
		public static void Using_batch_processing_events( IEngine engine )
		{
			trace( "Open a project..." );
			IProject project = engine.OpenProject( SamplesFolder + "\\SampleProject\\Invoices_eng.fcproj" );

			try {		
				trace( "Add a new batch..." );
				IBatch batch = project.Batches.AddNew( "TestBatch" );

				trace( "Open the new batch..." );
				batch.Open();
				
				// Here we create an events sink which will capture batch processing events and
				// show progress and tracing messages in the status bar. This will also make UI
				// more responsive to user input. See definition of the sink class for details
				trace( "Start listening to batch processing events..." );
				SampleBatchEventsSink eventsSink = new SampleBatchEventsSink( batch );

				try {
					trace( "Add the image files to the batch..." );
					batch.AddImage( SamplesFolder + "\\SampleImages\\Invoices_1.tif" );
					batch.AddImage( SamplesFolder + "\\SampleImages\\Invoices_2.tif" );
					batch.AddImage( SamplesFolder + "\\SampleImages\\Invoices_3.tif" );

					trace( "Recognize the batch..." );
					batch.Recognize( null, RecognitionModeEnum.RM_ReRecognizeMinimal, null );
					
					trace( "Export the results..." );
					batch.Export( null, null );

					trace( "Close and delete the batch..." );
				} finally {
					eventsSink.Dispose();
					batch.Close();
					project.Batches.DeleteAll();
				}
				
				trace( "Close the project..." );
			} finally {
				project.Close();
			}
		}

		// USE CASE: Using collection events
		public static void Using_collection_events( IEngine engine )
		{	
			// Collection events are mainly intended for use in creating UI views for FlexiCapture Engine objects.
			// By listening to collection events listeners can duly react to changes in the model.
						
			trace( "Open the project..." );
			IProject project = engine.OpenProject( SamplesFolder + "\\SampleProject\\Invoices_eng.fcproj" );

			// Start listening to project.Batches events. In a real-life usage scenario the listener
			// would be some kind of a visual control, showing the list of batches and redrawing
			// itself when the collection changes
			SampleCollectionEventsSink batchesEvents = new SampleCollectionEventsSink( project.Batches, "project.Batches" );

			try {		
				trace( "Add a new batch..." );
				IBatch batch = project.Batches.AddNew( "TestBatch" );

				trace( "Open the new batch..." );
				batch.Open();

				// Start listening to batch.Documents events. In a real-life usage scenario the listener
                // would be some kind of a visual control, showing the list of documents and redrawing
				// itself when the collection changes
				SampleCollectionEventsSink documentsEvents = new SampleCollectionEventsSink( batch.Documents, "batch.Documents" );

				try {
					trace( "Add the image files to the batch..." );
					batch.AddImage( SamplesFolder + "\\SampleImages\\Invoices_1.tif" );
					batch.AddImage( SamplesFolder + "\\SampleImages\\Invoices_2.tif" );
					batch.AddImage( SamplesFolder + "\\SampleImages\\Invoices_3.tif" );

					trace( "Recognize the batch..." );
					batch.Recognize( null, RecognitionModeEnum.RM_ReRecognizeMinimal, null );
					
					trace( "Export the results..." );
					batch.Export( null, null );

					trace( "Close and delete the batch..." );
				} finally {
					documentsEvents.Dispose();
					batch.Close();
					project.Batches.DeleteAll();
				}
				
				trace( "Close the project..." );
			} finally {
				batchesEvents.Dispose();
				project.Close();
			}
		}

		#region Sample Auxiliary Classes and Methods

		// Sample Event Sinks   ///////////////////////////////////////////////////////////

		class SampleBatchEventsSink
		{
			public SampleBatchEventsSink( object source )
			{
				// Check that the source object is a IBatchEvents source (projects and batches are).
				// Using the helper class generated by the framework which maps events source methods to delegates
				batchEvents = source as IBatchEvents_Event;
				assert( batchEvents != null );
				
				batchEvents.OnBatchProgress += new IBatchEvents_OnBatchProgressEventHandler( batchEvents_OnBatchProgress );
				batchEvents.OnProcessMessages += new IBatchEvents_OnProcessMessagesEventHandler(batchEvents_OnProcessMessages);
				batchEvents.OnRecognizerTip +=new IBatchEvents_OnRecognizerTipEventHandler(batchEvents_OnRecognizerTip);
			}

			public void Dispose()
			{
				batchEvents.OnBatchProgress -= new IBatchEvents_OnBatchProgressEventHandler( batchEvents_OnBatchProgress );
				batchEvents.OnProcessMessages -= new IBatchEvents_OnProcessMessagesEventHandler(batchEvents_OnProcessMessages);
				batchEvents.OnRecognizerTip -=new IBatchEvents_OnRecognizerTipEventHandler(batchEvents_OnRecognizerTip);
				batchEvents = null;
			}

			#region IMPLEMENTATION

			IBatchEvents_Event batchEvents;
			
			private void batchEvents_OnBatchProgress( IBatch batch, int processedItemsCount, int remainingItemsCount )
			{
				traceProgress( ( processedItemsCount * 100 ) / ( processedItemsCount + remainingItemsCount ) );
			}

			private void batchEvents_OnProcessMessages( ref bool ShouldTerminate )
			{
				//Application.DoEvents();
			}

			private void batchEvents_OnRecognizerTip( IPage Page, string RecognizerTip ) 
			{
				traceDetail( RecognizerTip );
			}

			#endregion
		};

		class SampleCollectionEventsSink
		{
			public SampleCollectionEventsSink( object source, string _name )
			{
				// Check that the source object is a ICollectionEvents source (most collections are).
				// Using the helper class generated by the framework which maps event source methods to delegates
				collectionEvents = source as ICollectionEvents_Event;
				assert( collectionEvents != null );
                
				name = _name;
				collectionEvents.OnCollectionChanged += new ICollectionEvents_OnCollectionChangedEventHandler( collectionEvents_OnCollectionChanged );
			}

			public void Dispose()
			{
				collectionEvents.OnCollectionChanged -= new ICollectionEvents_OnCollectionChangedEventHandler( collectionEvents_OnCollectionChanged );
				collectionEvents = null;
			}

			#region IMPLEMENTATION

			ICollectionEvents_Event collectionEvents;
			string name;
			
			void collectionEvents_OnCollectionChanged( bool reloaded, 
				IIntsCollection added, IIntsCollection deleted, IIntsCollection modified )
			{
				try {
					if( reloaded ) {
						trace( name + ": RESET" );
					} else {
						string addedTxt = added != null ? " ADDED:" + added.Count : "";
						string deletedTxt = deleted != null ? " DELETED:" + deleted.Count : "";
						string modifiedTxt = modified != null ? " MODIFIED:" + modified.Count : "";
						
						trace( name + ":" + addedTxt + deletedTxt + modifiedTxt );
					}
				} catch( Exception e ) {
					trace( e.Message );
				}
			}

			#endregion
		};

		// Auxiliary Tools ///////////////////////////////////////////////////////////

		static IBatch PrepareNewRecognizedBatch( IEngine engine, IProject project )
		{
			IBatch batch = project.Batches.AddNew( "TestBatch" );
			batch.Open();

			batch.AddImage( SamplesFolder + "\\SampleImages\\Invoices_1.tif" );
			batch.AddImage( SamplesFolder + "\\SampleImages\\Invoices_2.tif" );
			batch.AddImage( SamplesFolder + "\\SampleImages\\Invoices_3.tif" );

			batch.Recognize( null, RecognitionModeEnum.RM_ReRecognizeMinimal, null );
			
			return batch;
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
                foreach( IField field in fields ) {
                    recursiveCheckVerified( engine, field );
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
