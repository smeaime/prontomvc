// © 2015 ABBYY Production LLC. 
// ABBYY, FLEXICAPTURE and FLEXILAYOUT are either registered trademarks or trademarks of ABBYY Software Ltd.
// SAMPLES code is property of ABBYY, exclusive rights are reserved. 
// DEVELOPER is allowed to incorporate SAMPLES into his own APPLICATION and modify it 
// under the terms of License Agreement between ABBYY and DEVELOPER.

// Product: ABBYY FlexiCapture Engine 11
// Description: Support classes for snippets implementation

using System;
//using System.Windows.Forms;
using System.Diagnostics;
using System.Reflection;
using System.Runtime.InteropServices;

using FCEngine;

namespace Sample
{
	// SNIPPETS FRAMEWORK ////////////////////////////////////////////////

	delegate void Snippet( IEngine engine );

	enum EngineLoadingMode {
		LoadDirectlyUseNakedInterfaces,
		LoadAsInprocServer,
		LoadAsWorkprocess
	}

	abstract class FlexiCaptureEngineSnippets : TracingSupport
	{
		
		public static Snippet[] GetSnippets( Type type ) 
		{ 
			MethodInfo[] methods = type.GetMethods();

			System.Collections.ArrayList selected = new System.Collections.ArrayList();
			foreach( MethodInfo method in methods ) {
				if( method.IsPublic && method.IsStatic && 
					method.ReturnType == typeof( void ) )
				{
					ParameterInfo[] parameters = method.GetParameters();
					if( parameters.Length == 1 && parameters[0].ParameterType == typeof( IEngine ) ) {
						selected.Add( method );
					}
				}
			}

			Snippet[] delegates = new Snippet[selected.Count];
			for( int i = 0; i < selected.Count; i++ ) {
				delegates[i] = (Snippet)Delegate.CreateDelegate( typeof( Snippet ), (MethodInfo) selected[i] );
			}
			return delegates; 
		}

		static IEngine engine;
		static IEngineLoader engineLoader;
		static EngineLoadingMode engineLoadingMode;
		static System.Diagnostics.PerformanceCounter performanceCounter;
		
		public static void Run( Snippet snippet, int count, bool interactive, EngineLoadingMode engineLoadingMode, bool reuseLoadedEngine )
		{
			isInteractive = interactive;
			
			int totalTimeForAllIterationsExceptFirst = 0;
			int totalMemoryIncrementForAllIterationsExceptFirst = 0;
			int prevIterationMemory = 0;
			for( int i = 1; i <= count; i++ ) {
				try {
					DateTime started = DateTime.Now;
					if( engine == null  ) {	
						engine = loadEngine( engineLoadingMode, out engineLoader );
					}
					if( count > 1 ) {
						initPerformanceCounters();
						tracePerformanceBegin( "Iteration " + i.ToString() + "..." );
					}
					try {
						snippet( engine );
					} finally {
						if( !reuseLoadedEngine ) {
							unloadEngine( ref engine, ref engineLoader );
						} else {
							// If a scenario is run repeatedly (Ctrl-P) without the engine being recycled, 
							// a lot of native objects may be created in each cycle consuming a lot 
							// of native memory of which the garbage collector is unaware. This eventually
							// might lead to memory problems. To prevent the build-up of not collected
							// large memory objects we force the GC to collect here. This is NOT REQUIRED 
							// in most real-life scenarios.
							GC.Collect();
						}
					}
					if( count > 1 ) {
						int elapsedTime = (int)(DateTime.Now - started).TotalMilliseconds;

						int memory = 0;
						try {
							memory = (int) performanceCounter.NextValue();
						} catch( Exception ) {
							// Ignore. Zero memory will indicate that something went wrong
						}

						if( i >= 2 ) {
							totalTimeForAllIterationsExceptFirst += elapsedTime;
							totalMemoryIncrementForAllIterationsExceptFirst += memory - prevIterationMemory;
						}
						prevIterationMemory = memory;
						traceMemory( memory );
						tracePerformanceEnd( "OK (" + elapsedTime.ToString() + " ms, " + memory.ToString() + " bytes)" );
					}
				} catch( AssertionFailedException e ) {
					traceException( e.Message, e.Frame.GetFileName(), e.Frame.GetFileLineNumber() );
				} catch( Exception e ) {
					traceExceptionEx( e.Message, 1 );
				}
			}
			if( count > 1 ) {
				tracePerformance( "Average time per iteration: " + ( totalTimeForAllIterationsExceptFirst / ( count - 1 ) ).ToString() + " ms" );
			}
		}

		public static void UnloadEngine()
		{
			unloadEngine( ref engine, ref engineLoader );
		}

		public static void FindEntryPoint( Snippet snippet, out string fileName, out int lineNumber )
		{
			FindFirstTraceCallback firstTrace = new FindFirstTraceCallback();
			IProcessCallback _callback = SetCallback( firstTrace );
			try {	
				try {
					snippet( null );
				} catch( FindFirstTraceException ) {
				}
				fileName = firstTrace.FileName;
				lineNumber = firstTrace.LineNumber;
			} finally {
				SetCallback( _callback );
			}
		}

		protected static bool IsInteractive { get { return isInteractive; } }
		static bool isInteractive = false;
		
		protected static string SamplesFolder { get { return FceConfig.GetSamplesFolder(); } }

		static void initPerformanceCounters() 
		{
			if( performanceCounter == null ) {
				performanceCounter = new System.Diagnostics.PerformanceCounter();
				performanceCounter.CategoryName = "Process";
				performanceCounter.CounterName = "Private Bytes";
				if( engineLoadingMode == EngineLoadingMode.LoadAsWorkprocess ) {
					performanceCounter.InstanceName = "FCEngine";
				} else { 
					performanceCounter.InstanceName = System.Diagnostics.Process.GetCurrentProcess().ProcessName;
				}
			}
		}
		
		static IEngine loadEngine( EngineLoadingMode _engineLoadingMode, out IEngineLoader engineLoader )
		{				
			engineLoadingMode = _engineLoadingMode;
			switch( engineLoadingMode ) {
				case EngineLoadingMode.LoadDirectlyUseNakedInterfaces:
				{
					engineLoader = null; // Not used
					IEngine engine = null;
					int hresult = InitializeEngine( FceConfig.GetDeveloperSN(), out engine );
					Marshal.ThrowExceptionForHR( hresult );	
					assert( engine != null );
					return engine;
				}
				case EngineLoadingMode.LoadAsInprocServer:
				{
					engineLoader = new FCEngine.InprocLoader();
					IEngine engine = engineLoader.Load( FceConfig.GetDeveloperSN(), "" );
					assert( engine != null );
					return engine;
				}
				case EngineLoadingMode.LoadAsWorkprocess:
				{
					engineLoader = new FCEngine.OutprocLoader();
					IEngine engine = engineLoader.Load( FceConfig.GetDeveloperSN(), "" );
					assert( engine != null );
					return engine;
				}
			}
			assert( false );
			engineLoader = null;
			return null;
		}

		static void unloadEngine( ref IEngine engine, ref IEngineLoader engineLoader )
		{			
			if( engine != null ) {
				if( engineLoader == null ) {
					int hresult = DeinitializeEngine();
					Marshal.ThrowExceptionForHR( hresult );
				} else {
					engineLoader.Unload();
					engineLoader = null;
				}
				engine = null;	
			}
		}

		[DllImport( FceConfig.DllPath, CharSet=CharSet.Unicode ), PreserveSig]
		static extern int InitializeEngine( String devSN, out IEngine engine );

		[DllImport( FceConfig.DllPath, CharSet=CharSet.Unicode ), PreserveSig]
		static extern int DeinitializeEngine();
	};

	// TRACING SUPPORT ////////////////////////////////////////////////
	
	interface IProcessCallback
	{
		void Trace( string message, string fileName, int lineNumber, bool performenceIndicator );
		void TraceBegin( string message, string fileName, int lineNumber, int level, bool performenceIndicator );
		void TraceEnd( string message, int level, bool performenceIndicator );
		void TraceException( string message, string fileName, int lineNumber, int level );
		void TraceProgress( int percent );
		void TraceMemory( int memoryBytes );
		void TraceDetail( string message );
	}

	class AssertionFailedException : System.Exception 
	{
		public StackFrame Frame;

		public AssertionFailedException( StackFrame sf )
		{
			Frame = sf;
		}

		public override string Message {
			get {
				return "ERROR: Assertion Failed: " + 
					Frame.GetMethod().Name + ", line " + Frame.GetFileLineNumber();
			}
		}
	};

	class FindFirstTraceException : System.Exception 
	{
	};

	class FindFirstTraceCallback : IProcessCallback
	{
		public string FileName;
		public int LineNumber;
		
		void IProcessCallback.Trace( string message, string fileName, int lineNumber, bool performenceIndicator )
		{
			FileName = fileName;
			LineNumber = lineNumber;
			throw new FindFirstTraceException();
		}

		void IProcessCallback.TraceBegin( string message, string fileName, int lineNumber, int level, bool performenceIndicator )
		{
			FileName = fileName;
			LineNumber = lineNumber;
			throw new FindFirstTraceException();
		}
		void IProcessCallback.TraceEnd( string message, int level, bool performenceIndicator ) {}
		void IProcessCallback.TraceException( string message, string fileName, int lineNumber, int level ) {}
		void IProcessCallback.TraceProgress( int percent ) {}
		void IProcessCallback.TraceDetail( string message ) {}
		void IProcessCallback.TraceMemory( int memoryBytes ) {}
	}

	class TracingSupport
	{
		public static IProcessCallback SetCallback( IProcessCallback _callback )
		{
			IProcessCallback oldCallback = callback;
			callback = _callback;
			return oldCallback;
		}
		protected static void trace( string message )
		{ 
			if( callback != null ) {
				StackTrace st = new StackTrace( 1, true );
				StackFrame sf = st.GetFrame( 0 );
				callback.Trace( message, sf.GetFileName(), sf.GetFileLineNumber(), false );
			}
		}
		protected static void traceBegin( string message )
		{ 
			if( callback != null ) {
				StackTrace st = new StackTrace( 1, true );
				StackFrame sf = st.GetFrame( 0 );
				callback.TraceBegin( message, sf.GetFileName(), sf.GetFileLineNumber(), st.FrameCount, false );
			}
		}
		protected static void traceEnd( string message )
		{ 
			if( callback != null ) {
				StackTrace st = new StackTrace( 1, true );
				callback.TraceEnd( message, st.FrameCount, false ); 
			}
		}
		protected static void tracePerformance( string message )
		{ 
			if( callback != null ) {
				StackTrace st = new StackTrace( 1, true );
				StackFrame sf = st.GetFrame( 0 );
				callback.Trace( message, sf.GetFileName(), sf.GetFileLineNumber(), true );
			}
		}
		protected static void tracePerformanceBegin( string message )
		{ 
			if( callback != null ) {
				StackTrace st = new StackTrace( 1, true );
				StackFrame sf = st.GetFrame( 0 );
				callback.TraceBegin( message, sf.GetFileName(), sf.GetFileLineNumber(), st.FrameCount, true );
			}
		}
		protected static void tracePerformanceEnd( string message )
		{ 
			if( callback != null ) {
				StackTrace st = new StackTrace( 1, true );
				callback.TraceEnd( message, st.FrameCount, true ); 
			}
		}
		protected static void traceMemory( int memoryBytes )
		{ 
			if( callback != null ) {
				callback.TraceMemory( memoryBytes );
			}
		}
		protected static void traceException( string message, string fileName, int lineNumber )
		{ 
			if( callback != null ) {
				StackTrace st = new StackTrace( 1, true );
				callback.TraceException( message, fileName, lineNumber, st.FrameCount ); 
			} else {
				//MessageBox.Show( message );
			}
		}
		protected static void traceException( string message )
		{ 
			if( callback != null ) {
				StackTrace st = new StackTrace( 1, true );
				StackFrame sf = st.GetFrame( 0 );
				callback.TraceException( message, sf.GetFileName(), sf.GetFileLineNumber(), st.FrameCount ); 
			} else {
				//MessageBox.Show( message );
			}
		}
		protected static void traceExceptionEx( string message, int frameNumber )
		{ 
			if( callback != null ) {
				StackTrace st = new StackTrace( 1, true );
				StackFrame sf = st.GetFrame( frameNumber );
				callback.TraceException( message, sf.GetFileName(), sf.GetFileLineNumber(), st.FrameCount ); 
			} else {
				//MessageBox.Show( message );
			}
		}
		protected static void assert( bool condition )
		{ 			
			if( !condition ) {
				StackTrace st = new StackTrace( 1, true );
				StackFrame sf = st.GetFrame(0);
				throw new AssertionFailedException( sf );
			}
		}
		protected static void traceProgress( int percent )
		{
			if( callback != null ) {
				callback.TraceProgress( percent );
			}
		}
		protected static void traceDetail( string msg )
		{
			if( callback != null ) {
				callback.TraceDetail( msg );
			}
		}

		static IProcessCallback callback;
	}

	///////////////////////////////////////////////////////////////////////
}
