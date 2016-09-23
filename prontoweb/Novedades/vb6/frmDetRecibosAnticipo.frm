VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetRecibosAnticipo 
   Caption         =   "Item de anticipo al personal [ Recibo ]"
   ClientHeight    =   2685
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5565
   Icon            =   "frmDetRecibosAnticipo.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2685
   ScaleWidth      =   5565
   StartUpPosition =   2  'CenterScreen
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
      Left            =   1710
      TabIndex        =   2
      Top             =   1020
      Width           =   1365
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   3015
      TabIndex        =   6
      Top             =   2130
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1035
      TabIndex        =   5
      Top             =   2130
      Width           =   1485
   End
   Begin VB.TextBox txtLegajo 
      Alignment       =   1  'Right Justify
      DataField       =   "Legajo"
      Height          =   285
      Left            =   1710
      TabIndex        =   0
      Top             =   135
      Width           =   1035
   End
   Begin VB.TextBox txtCuotas 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadCuotas"
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
      Left            =   4140
      TabIndex        =   3
      Top             =   1050
      Width           =   555
   End
   Begin VB.TextBox txtDetalle 
      DataField       =   "Detalle"
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
      Left            =   1710
      TabIndex        =   4
      Top             =   1500
      Width           =   3615
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdEmpleado"
      Height          =   315
      Index           =   1
      Left            =   1710
      TabIndex        =   1
      Tag             =   "Empleados"
      Top             =   540
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Empleado :"
      Height          =   300
      Index           =   1
      Left            =   270
      TabIndex        =   11
      Top             =   555
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe :"
      Height          =   300
      Index           =   5
      Left            =   270
      TabIndex        =   10
      Top             =   1005
      Width           =   1320
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Legajo :"
      Height          =   300
      Index           =   0
      Left            =   270
      TabIndex        =   9
      Top             =   150
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuotas :"
      Height          =   300
      Index           =   0
      Left            =   3375
      TabIndex        =   8
      Top             =   1035
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle : "
      Height          =   300
      Index           =   2
      Left            =   270
      TabIndex        =   7
      Top             =   1485
      Width           =   1320
   End
End
Attribute VB_Name = "frmDetRecibosAnticipo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetReciboAnticiposAlPersonal
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
            MsgBox "No definio el empleado", vbExclamation
            Exit Sub
         End If
         
         If Len(txtImporte.Text) = 0 Or Not IsNumeric(txtImporte.Text) Then
            MsgBox "Debe ingresar un importe", vbExclamation
            Exit Sub
         End If
         
         With origen.Registro
            .Fields("IdEmpleado").Value = DataCombo1(1).BoundText
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
   Set origen = oRecibo.DetRecibosAnticiposAlPersonal.Item(vNewValue)
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
         .Fields("IdTipoValor").Value = oRs.Fields("IdTipoComprobanteCajaEgresos").Value
         .Fields("CantidadCuotas").Value = 1
      End With
      oRs.Close
   End If

   Set oRs = Nothing
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
            Set oRs = Aplicacion.Empleados.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then
               txtLegajo.Text = IIf(IsNull(oRs.Fields("Legajo").Value), "", oRs.Fields("Legajo").Value)
            End If
            oRs.Close
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

Private Sub txtCuotas_GotFocus()

   With txtCuotas
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCuotas_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtDetalle_GotFocus()

   With txtDetalle
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDetalle_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

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

Private Sub txtLegajo_GotFocus()

   With txtLegajo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtLegajo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtLegajo_Validate(Cancel As Boolean)

   If Len(txtLegajo.Text) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Empleados.TraerFiltrado("_PorLegajo", txtLegajo.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdEmpleado").Value = oRs.Fields(0).Value
      Else
         MsgBox "Legajo inexistente", vbExclamation
         Cancel = True
         txtLegajo.Text = ""
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

