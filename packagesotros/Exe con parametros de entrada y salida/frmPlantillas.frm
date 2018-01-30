VERSION 5.00
Begin VB.Form frmPlantillas 
   ClientHeight    =   3120
   ClientLeft      =   60
   ClientTop       =   420
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3120
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer Timer1 
      Interval        =   30000
      Left            =   3465
      Top             =   585
   End
End
Attribute VB_Name = "frmPlantillas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Sub ExitProcess Lib "kernel32" (ByVal uExitCode As Long)
Private Declare Function GetExitCodeProcess Lib "kernel32" (ByVal hProcess As Long, lpExitCode As Long) As Long
Private Declare Function GetCurrentProcess Lib "kernel32" () As Long
Private Declare Sub Sleep Lib "kernel32.dll" (ByVal dwMilliseconds As Long)

Private CodigoSalida As Long
Private mPID As String

Private oW As Word.Application
Private MydsEncrypt As dsEncrypt

Private Sub Form_Load()

' Codigo VBNET
'   Dim ProcessProperties As New ProcessStartInfo
'   ProcessProperties.FileName = RutaDelPrograma
'   ProcessProperties.Arguments = Parametros
'   ProcessProperties.WindowStyle = ProcessWindowStyle.Maximized
'   Dim myProcess As Process = Process.Start(ProcessProperties)
'   myProcess.WaitForExit()
'   CodigoSalida= myProcess.ExitCode --> En esta línea es en la que capturo el código que meha devuelto el programa de vb.6
   
   On Error GoTo Mal
   
   Dim i As Integer, i2 As Integer
   Dim mvarId As Long
   Dim s As String, mPlantilla As String, mStringConexion As String, mArchivo As String
   Dim mVector, mVector2

   s = Command()
's = "-Plantilla=C:\Pronto\Plantillas\Requerimiento_Servipet.dot -SC=Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa; Password=.SistemaPronto.;Initial catalog=Pronto;Data Source=serversql3\TESTING;Connect Timeout=45 -Id=20 -FileOut=C:\Requerimiento.doc"

   CodigoSalida = 0
   mPlantilla = ""
   mStringConexion = ""
   mvarId = 0
   mArchivo = ""
   
   Timer1.Interval = 30000
   Timer1.Enabled = True

   mVector = VBA.Split(s, "-")
   If UBound(mVector) > 0 Then
      For i = 1 To UBound(mVector)
         mVector2 = VBA.Split(mVector(i), "=")
         If UBound(mVector2) < 1 Then
            CodigoSalida = -102
            GoTo Salida
         End If
         If mVector2(0) = "Plantilla" Then
            mPlantilla = Mid(mVector(i), Len(mVector2(0)) + 2, 1000)
         ElseIf mVector2(0) = "SC" Then
            mStringConexion = Mid(mVector(i), Len(mVector2(0)) + 2, 1000)
         ElseIf mVector2(0) = "Id" Then
            mvarId = Mid(mVector(i), Len(mVector2(0)) + 2, 1000)
         ElseIf mVector2(0) = "FileOut" Then
            mArchivo = Mid(mVector(i), Len(mVector2(0)) + 2, 1000)
         End If
      Next
      
      If mPlantilla = "" Then CodigoSalida = -103
      If mStringConexion = "" Then CodigoSalida = -104
      If mvarId = 0 Then CodigoSalida = -105
      If mArchivo = "" Then CodigoSalida = -106
      
      If CodigoSalida <> 0 Then GoTo Salida

      Set MydsEncrypt = New dsEncrypt
      MydsEncrypt.KeyString = ("EDS")
      mStringConexion = MydsEncrypt.Encrypt(mStringConexion)
      
      Set obj_Wmi = GetObject("winmgmts:")
      
      CargaProcesosEnEjecucion
      
      Set oW = CreateObject("Word.Application")
      mPID = ObtenerPIDProcesosLanzados
      oW.Visible = False
      oW.Documents.Add (mPlantilla)
      oW.Application.Run MacroName:="Emision", varg1:=mStringConexion, varg2:=mvarId
      'oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
      oW.Application.Run MacroName:="DatosDelPie"
      oW.ActiveDocument.SaveAs mArchivo
      
   Else
      CodigoSalida = -101
   End If

Salida:
   On Error Resume Next
   
   oW.ActiveDocument.Close False
   oW.Quit
   TerminarProceso mPID
   Set oW = Nothing
   
   Set MydsEncrypt = Nothing
   
   Set obj_Wmi = Nothing
   
   Call ExitProcess(CodigoSalida)
   
   End

Mal:
   If CodigoSalida = 0 Then CodigoSalida = -199
   Resume Salida

End Sub

Public Sub CargaProcesosEnEjecucion()

   Dim mLosProcesos, mProceso
    
   glbListaProcesos = ""
   glbListaPID = ""
   If Not obj_Wmi Is Nothing Then
      Set mLosProcesos = obj_Wmi.InstancesOf("win32_process")
      
      For Each mProceso In mLosProcesos
         If LCase(mProceso.Name) = "winword.exe" Or LCase(mProceso.Name) = "excel.exe" Then
            glbListaProcesos = glbListaProcesos & "(" & LCase(mProceso.Name) & ")"
            glbListaPID = glbListaPID & "(" & mProceso.ProcessId & ")"
         End If
      Next
      
      Set mLosProcesos = Nothing
      Set mProceso = Nothing
   End If

End Sub

Public Function ObtenerPIDProcesosLanzados() As String

   Dim s As String
   Dim mLosProcesos, mProceso
    
   On Error GoTo Salida
   
   s = ""
   If Not obj_Wmi Is Nothing Then
      Set mLosProcesos = obj_Wmi.InstancesOf("win32_process")
        
      For Each mProceso In mLosProcesos
         If LCase(mProceso.Name) = "winword.exe" Or LCase(mProceso.Name) = "excel.exe" Then
            If InStr(1, glbListaPID, "(" & mProceso.ProcessId & ")") = 0 Then
               s = s & "(" & mProceso.ProcessId & ")"
            End If
         End If
      Next
      
      Set mLosProcesos = Nothing
      Set mProceso = Nothing
   End If

Salida:
   ObtenerPIDProcesosLanzados = s
   
End Function

Public Sub TerminarProceso(ByVal PID As String)

   Dim mLosProcesos, mProceso
    
   If Not obj_Wmi Is Nothing Then
      Set mLosProcesos = obj_Wmi.InstancesOf("win32_process")
      
      For Each mProceso In mLosProcesos
         If LCase(mProceso.Name) = "winword.exe" Or LCase(mProceso.Name) = "excel.exe" Then
            If InStr(1, PID, "(" & mProceso.ProcessId & ")") <> 0 Then
               mProceso.Terminate (0)
            End If
         End If
      Next
      
      Set mLosProcesos = Nothing
      Set mProceso = Nothing
   End If

End Sub

Private Sub Timer1_Timer()

   On Error Resume Next
   
   CodigoSalida = -198
   
   Timer1.Enabled = False
   
   oW.ActiveDocument.Close False
   oW.Quit
   TerminarProceso mPID
   Set oW = Nothing
   
   Set MydsEncrypt = Nothing
   
   Set obj_Wmi = Nothing
   
   Call ExitProcess(CodigoSalida)
   
   End

End Sub
