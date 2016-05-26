VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetRecibosCaja 
   Caption         =   "Item de ingreso de caja [ Recibos ]"
   ClientHeight    =   1710
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5025
   Icon            =   "frmDetRecibosCaja.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1710
   ScaleWidth      =   5025
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   900
      TabIndex        =   2
      Top             =   1185
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   2700
      TabIndex        =   3
      Top             =   1185
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
      Height          =   360
      Left            =   1710
      TabIndex        =   1
      Top             =   600
      Width           =   1455
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCaja"
      Height          =   315
      Index           =   1
      Left            =   1710
      TabIndex        =   0
      Tag             =   "Cajas"
      Top             =   180
      Width           =   3120
      _ExtentX        =   5503
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCaja"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe :"
      Height          =   300
      Index           =   5
      Left            =   270
      TabIndex        =   5
      Top             =   645
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Caja :"
      Height          =   300
      Index           =   1
      Left            =   270
      TabIndex        =   4
      Top             =   195
      Width           =   1320
   End
End
Attribute VB_Name = "frmDetRecibosCaja"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetReciboValores
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
            MsgBox "No definio la caja", vbExclamation
            Exit Sub
         End If
         
         If Len(txtImporte.Text) = 0 Or Not IsNumeric(txtImporte.Text) Then
            MsgBox "Debe ingresar un importe", vbExclamation
            Exit Sub
         End If
         
         With origen.Registro
            .Fields("IdCaja").Value = DataCombo1(1).BoundText
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
   Set origen = oRecibo.DetRecibosValores.Item(vNewValue)
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
               If oControl.Tag = "Bancos" Then
                  Set oControl.RowSource = oAp.Bancos.TraerFiltrado("_PorCuentasBancarias")
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
      Set oRs = oAp.Parametros.Item(1).Registro
      With origen.Registro
         .Fields("IdTipoValor").Value = oRs.Fields("IdTipoComprobanteCajaIngresos").Value
      End With
      oRs.Close
      Set oRs = Nothing
   End If

   Set oAp = Nothing
   
End Property

Public Property Get Recibo() As ComPronto.Recibo

   Set Recibo = oRecibo

End Property

Public Property Set Recibo(ByVal vNewValue As ComPronto.Recibo)

   Set oRecibo = vNewValue

End Property

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


