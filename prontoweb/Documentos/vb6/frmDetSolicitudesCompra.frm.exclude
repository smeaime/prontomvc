VERSION 5.00
Begin VB.Form frmDetSolicitudesCompra 
   Caption         =   "Item de solicitud de compra"
   ClientHeight    =   1125
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3630
   Icon            =   "frmDetSolicitudesCompra.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1125
   ScaleWidth      =   3630
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   315
      Index           =   0
      Left            =   180
      TabIndex        =   1
      Top             =   720
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   315
      Index           =   1
      Left            =   1890
      TabIndex        =   2
      Top             =   720
      Width           =   1485
   End
   Begin VB.TextBox txtCantidad 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   2205
      TabIndex        =   0
      Top             =   180
      Width           =   1185
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad a solicitar :"
      Height          =   300
      Index           =   0
      Left            =   225
      TabIndex        =   3
      Top             =   210
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetSolicitudesCompra"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetSolicitudCompra
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oSolicitudCompra As ComPronto.SolicitudCompra
Public Aceptado As Boolean
Private mCantidadPendiente As Double
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         If Val(txtCantidad.Text) > mCantidadPendiente Then
            MsgBox "La cantidad debe ser menor o igual a " & Me.CantidadPendiente, vbExclamation
            Exit Sub
         End If
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

   mvarId = vNewValue
   
   Set oAp = Aplicacion
   
   Set origen = oSolicitudCompra.DetSolicitudesCompra.Item(vNewValue)
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
         ElseIf TypeOf oControl Is DTPicker Then
            If Len(oControl.DataField) Then .Add oControl, "Value", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   Set oAp = Nothing
   
End Property

Public Property Get SolicitudCompra() As ComPronto.SolicitudCompra

   Set SolicitudCompra = oSolicitudCompra

End Property

Public Property Set SolicitudCompra(ByVal vNewValue As ComPronto.SolicitudCompra)

   Set oSolicitudCompra = vNewValue

End Property

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub Form_Load()

   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oSolicitudCompra = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub txtCantidad_GotFocus()
   
   With txtCantidad
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Get CantidadPendiente() As Double

   CantidadPendiente = mCantidadPendiente

End Property

Public Property Let CantidadPendiente(ByVal vNewValue As Double)

   mCantidadPendiente = vNewValue

End Property
