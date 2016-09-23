VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form frmDetEmpleadosJornadas 
   Caption         =   "Fechas de cambio de jornada"
   ClientHeight    =   1815
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6525
   Icon            =   "frmDetEmpleadosJornadas.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1815
   ScaleWidth      =   6525
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtHorasJornada 
      Alignment       =   1  'Right Justify
      DataField       =   "HorasJornada"
      Height          =   285
      Left            =   3645
      TabIndex        =   1
      Top             =   630
      Width           =   495
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1350
      TabIndex        =   3
      Top             =   1170
      Width           =   1080
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   180
      TabIndex        =   2
      Top             =   1170
      Width           =   1080
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaCambio"
      Height          =   285
      Index           =   0
      Left            =   3645
      TabIndex        =   0
      Top             =   270
      Width           =   1320
      _ExtentX        =   2328
      _ExtentY        =   503
      _Version        =   393216
      Format          =   59965441
      CurrentDate     =   36432
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Horas jornada ( Sistema PRONTO HH ) :"
      Height          =   255
      Index           =   8
      Left            =   180
      TabIndex        =   5
      Top             =   645
      Width           =   3300
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Fecha de ingreso :"
      Height          =   255
      Index           =   3
      Left            =   180
      TabIndex        =   4
      Top             =   270
      Width           =   3300
   End
End
Attribute VB_Name = "frmDetEmpleadosJornadas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetEmpleadoJornada
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oEmpleado As ComPronto.Empleado
Dim mvarIdUnidadCU As Integer
Public Aceptado As Boolean
Private mvarIdNuevo, mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim oControl As Control
         
         With origen.Registro
            For Each oControl In Me.Controls
               If TypeOf oControl Is DataCombo Then
                  If oControl.Enabled And Len(oControl.BoundText) <> 0 Then
                     .Fields(oControl.DataField).Value = oControl.BoundText
                  End If
               ElseIf TypeOf oControl Is DTPicker Then
                  .Fields(oControl.DataField).Value = oControl.Value
               End If
            Next
         End With
         
         origen.Modificado = True
         Aceptado = True
         
         Me.Hide

      Case 1
      
         If mvarId = -1 Then
            origen.Eliminado = True
         End If
         
         Me.Hide
   
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   
   Set oAp = Aplicacion
   mvarId = vNewValue
   Set origen = oEmpleado.DetEmpleadosJornadas.Item(vNewValue)
   Me.IdNuevo = origen.Id
   Set oBind = New BindingCollection
   
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   If mvarId = -1 Then
      DTPicker1(0).Value = Date
      origen.Registro.Fields("HorasJornada").Value = Empleado.Registro.Fields("HorasJornada").Value
   Else
      With origen.Registro
         If Not IsNull(.Fields("FechaCambio").Value) Then
            DTPicker1(0).Value = .Fields("FechaCambio").Value
         End If
      End With
   End If
   
   Set oAp = Nothing
   
End Property

Public Property Get Empleado() As ComPronto.Empleado

   Set Empleado = oEmpleado

End Property

Public Property Set Empleado(ByVal vNewValue As ComPronto.Empleado)

   Set oEmpleado = vNewValue

End Property

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub DTPicker1_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTPicker1(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Load()

   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub txtHorasJornada_GotFocus()

   With txtHorasJornada
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtHorasJornada_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
