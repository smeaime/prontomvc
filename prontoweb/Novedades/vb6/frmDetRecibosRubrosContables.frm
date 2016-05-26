VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetRecibosRubrosContables 
   Caption         =   "Item de rubro contable [ Recibos ]"
   ClientHeight    =   1680
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5325
   Icon            =   "frmDetRecibosRubrosContables.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1680
   ScaleWidth      =   5325
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   945
      TabIndex        =   2
      Top             =   1140
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   2970
      TabIndex        =   3
      Top             =   1140
      Width           =   1485
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "Importe"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   300
      Left            =   1575
      TabIndex        =   1
      Top             =   615
      Width           =   1365
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdRubroContable"
      Height          =   315
      Index           =   1
      Left            =   1575
      TabIndex        =   0
      Tag             =   "RubrosContables"
      Top             =   135
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdRubroContable"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe :"
      Height          =   300
      Index           =   5
      Left            =   135
      TabIndex        =   5
      Top             =   600
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Rubro :"
      Height          =   300
      Index           =   1
      Left            =   135
      TabIndex        =   4
      Top             =   150
      Width           =   1320
   End
End
Attribute VB_Name = "frmDetRecibosRubrosContables"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetReciboRubrosContables
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oRecibo As ComPronto.Recibo
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
         
         If Len(DataCombo1(1).BoundText) = 0 Then
            MsgBox "No definio el rubro", vbExclamation
            Exit Sub
         End If
         
         If Len(txtImporte.Text) = 0 Or Not IsNumeric(txtImporte.Text) Then
            MsgBox "Debe ingresar un importe", vbExclamation
            Exit Sub
         End If
         
         With origen.Registro
            .Fields("IdRubroContable").Value = DataCombo1(1).BoundText
         End With
         origen.Modificado = True
         Aceptado = True
      
      Case 1
         
         If mvarId = -1 Then
            origen.Eliminado = True
         End If
   
   End Select
   
   Me.Hide

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker

   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oRecibo.DetRecibosRubrosContables.Item(vNewValue)
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
            If Len(oControl.DataField) Then .Add oControl, "value", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "RubrosContables" Then
                  Set oControl.RowSource = oAp.RubrosContables.TraerFiltrado("_ParaComboFinancierosIngresos")
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   If mvarId = -1 Then
      With origen.Registro
      
      End With
   End If

   Set oAp = Nothing

End Property

Public Property Get Recibo() As ComPronto.Recibo

   Set Recibo = oRecibo

End Property

Public Property Set Recibo(ByVal vNewValue As ComPronto.Recibo)

   Set oRecibo = vNewValue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      Dim oRs As ADOR.Recordset
      Select Case Index
         Case 1
      
      
      End Select
      Set oRs = Nothing
   End If
      
End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub Form_Unload(Cancel As Integer)

   Set oRecibo = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub txtImporte_GotFocus()

   With txtImporte
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImporte_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub


