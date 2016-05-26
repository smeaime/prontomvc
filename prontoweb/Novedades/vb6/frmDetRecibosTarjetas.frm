VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetRecibosTarjetas 
   Caption         =   "Item de ingreso de tarjeta de credito"
   ClientHeight    =   3495
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5145
   Icon            =   "frmDetRecibosTarjetas.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3495
   ScaleWidth      =   5145
   StartUpPosition =   3  'Windows Default
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
      Left            =   2070
      TabIndex        =   5
      Top             =   2295
      Width           =   1275
   End
   Begin VB.TextBox txtCantidadCuotas 
      Alignment       =   2  'Center
      DataField       =   "CantidadCuotas"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2070
      TabIndex        =   4
      Top             =   1890
      Width           =   465
   End
   Begin VB.TextBox txtNumeroAutorizacionTarjetaCredito 
      Alignment       =   2  'Center
      DataField       =   "NumeroAutorizacionTarjetaCredito"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2070
      TabIndex        =   3
      Top             =   1485
      Width           =   1275
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   945
      TabIndex        =   6
      Top             =   2925
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   2655
      TabIndex        =   7
      Top             =   2925
      Width           =   1485
   End
   Begin VB.TextBox txtNumeroTarjetaCredito 
      Alignment       =   2  'Center
      DataField       =   "NumeroTarjetaCredito"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2070
      TabIndex        =   1
      Top             =   630
      Width           =   2895
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdTarjetaCredito"
      Height          =   315
      Index           =   1
      Left            =   2070
      TabIndex        =   0
      Tag             =   "TarjetasCredito"
      Top             =   210
      Width           =   2940
      _ExtentX        =   5186
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdTarjetaCredito"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaVencimiento"
      Height          =   330
      Index           =   0
      Left            =   2070
      TabIndex        =   2
      Top             =   1035
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   59899905
      CurrentDate     =   36377
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe :"
      Height          =   255
      Index           =   5
      Left            =   180
      TabIndex        =   13
      Top             =   2340
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad de cuotas : "
      Height          =   255
      Index           =   2
      Left            =   180
      TabIndex        =   12
      Top             =   1935
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de autorizacion :"
      Height          =   255
      Index           =   1
      Left            =   180
      TabIndex        =   11
      Top             =   1530
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de tarjeta :"
      Height          =   255
      Index           =   0
      Left            =   180
      TabIndex        =   10
      Top             =   675
      Width           =   1815
   End
   Begin VB.Label lblData 
      Caption         =   "Tarjeta :"
      Height          =   255
      Index           =   1
      Left            =   180
      TabIndex        =   9
      Top             =   270
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Vencimiento :"
      Height          =   255
      Index           =   22
      Left            =   180
      TabIndex        =   8
      Top             =   1080
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetRecibosTarjetas"
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
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim oRs As ADOR.Recordset
   
         For Each dtp In DTFields
            If dtp.Enabled Then
               origen.Registro.Fields(dtp.DataField).Value = dtp.Value
            End If
         Next
         
         For Each dc In DataCombo1
            If Not IsNumeric(dc.BoundText) And dc.Enabled Then
               MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
               Exit Sub
            End If
            If IsNumeric(dc.BoundText) Then
               origen.Registro.Fields(dc.DataField).Value = dc.BoundText
            End If
         Next
         
         If txtCantidadCuotas.Enabled And Len(txtCantidadCuotas.Text) = 0 Then
            MsgBox "Debe ingresar la cantidad de cuotas", vbExclamation
            Exit Sub
         End If
         
         If Len(txtImporte.Text) = 0 Or Not IsNumeric(txtImporte.Text) Then
            MsgBox "Debe ingresar el importe", vbExclamation
            Exit Sub
         End If
         
         If origen.Registro.Fields("IdTipoValor").Value = 0 Then
            MsgBox "Debe definir en parametros el tipo de comprobante tarjeta de credito", vbExclamation
            Exit Sub
         End If
         
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
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
'            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   If mvarId = -1 Then
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      Set oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
      With origen.Registro
         .Fields("IdTipoValor").Value = IIf(IsNull(oRs.Fields("IdTipoComprobanteTarjetaCredito").Value), 0, oRs.Fields("IdTipoComprobanteTarjetaCredito").Value)
         .Fields("FechaVencimiento").Value = Date
         .Fields("CantidadCuotas").Value = 1
      End With
      oRs.Close
   Else
      With origen.Registro
      
      End With
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
      origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
      Dim oRs As ADOR.Recordset, oRs1 As ADOR.Recordset
   End If

End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)

   If Index <> 0 Then SendKeys "%{DOWN}"
   
'   With DataCombo1(Index)
'      .SelStart = 0
'      .SelLength = Len(.Text)
'   End With
   
End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

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

Private Sub txtCantidadCuotas_GotFocus()

   With txtCantidadCuotas
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidadCuotas_KeyPress(KeyAscii As Integer)

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

Private Sub txtNumeroAutorizacionTarjetaCredito_GotFocus()

   With txtNumeroAutorizacionTarjetaCredito
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroAutorizacionTarjetaCredito_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroTarjetaCredito_GotFocus()

   With txtNumeroTarjetaCredito
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroTarjetaCredito_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtNumeroTarjetaCredito
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
