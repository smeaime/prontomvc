VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetOrdenesPagoValores 
   Caption         =   "Item de ingreso de valores [ Ordenes de pago ]"
   ClientHeight    =   2520
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11325
   Icon            =   "frmDetOrdenesPagoValores.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2520
   ScaleWidth      =   11325
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "No a la orden :"
      Height          =   240
      Left            =   9540
      TabIndex        =   18
      Top             =   1935
      Width           =   1410
   End
   Begin VB.TextBox txtChequesALaOrdenDe 
      DataField       =   "ChequesALaOrdenDe"
      Height          =   285
      Left            =   1575
      TabIndex        =   7
      Top             =   1575
      Width           =   9405
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   90
      TabIndex        =   8
      Top             =   2025
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1800
      TabIndex        =   9
      Top             =   2025
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
      Left            =   9495
      TabIndex        =   6
      Top             =   1080
      Width           =   1455
   End
   Begin VB.TextBox txtNumeroValor 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroValor"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   360
      Left            =   9495
      TabIndex        =   4
      Top             =   270
      Width           =   1455
   End
   Begin VB.TextBox txtNumeroInterno 
      DataField       =   "NumeroInterno"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   1575
      TabIndex        =   0
      Top             =   315
      Width           =   1005
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdTipoValor"
      Height          =   315
      Index           =   0
      Left            =   1575
      TabIndex        =   1
      Tag             =   "TiposValor"
      Top             =   735
      Width           =   3120
      _ExtentX        =   5503
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoComprobante"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaBancaria"
      Height          =   315
      Index           =   1
      Left            =   1575
      TabIndex        =   2
      Tag             =   "Bancos"
      Top             =   1125
      Width           =   3120
      _ExtentX        =   5503
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaBancaria"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaVencimiento"
      Height          =   330
      Index           =   0
      Left            =   9495
      TabIndex        =   5
      Top             =   675
      Width           =   1470
      _ExtentX        =   2593
      _ExtentY        =   582
      _Version        =   393216
      Format          =   59506689
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdBancoChequera"
      Height          =   1350
      Index           =   2
      Left            =   4725
      TabIndex        =   3
      Top             =   135
      Width           =   2760
      _ExtentX        =   4868
      _ExtentY        =   2381
      _Version        =   393216
      Style           =   1
      ListField       =   "Titulo"
      BoundColumn     =   "IdBancoChequera"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdTarjetaCredito"
      Height          =   315
      Index           =   3
      Left            =   7155
      TabIndex        =   20
      Tag             =   "TarjetasCredito"
      Top             =   2205
      Visible         =   0   'False
      Width           =   3120
      _ExtentX        =   5503
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTarjetaCredito"
      Text            =   ""
   End
   Begin VB.Label lblEstado 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   4770
      TabIndex        =   19
      Top             =   2070
      Visible         =   0   'False
      Width           =   1905
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "A la orden de :"
      Height          =   255
      Index           =   0
      Left            =   135
      TabIndex        =   17
      Top             =   1605
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Chequeras :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Index           =   4
      Left            =   3555
      TabIndex        =   16
      Top             =   180
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe :"
      Height          =   300
      Index           =   5
      Left            =   7605
      TabIndex        =   15
      Top             =   1125
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tipo de valor :"
      Height          =   300
      Index           =   2
      Left            =   135
      TabIndex        =   14
      Top             =   735
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero :"
      Height          =   300
      Index           =   0
      Left            =   7605
      TabIndex        =   13
      Top             =   315
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero interno :"
      Height          =   345
      Index           =   3
      Left            =   135
      TabIndex        =   12
      Top             =   315
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Banco / Cuenta :"
      Height          =   300
      Index           =   1
      Left            =   135
      TabIndex        =   11
      Top             =   1125
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha de vencimiento :"
      Height          =   300
      Index           =   22
      Left            =   7605
      TabIndex        =   10
      Top             =   720
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetOrdenesPagoValores"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetOrdenPagoValores
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oOrdenPago As ComPronto.OrdenPago
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mvarChequeraDesde As Long, mvarChequeraHasta As Long
Private mvarIdTipoComprobanteTarjetaCredito As Long
Private mImporteDefault As Double
Private mvarChequeraPagoDiferido As String
Private mFechaOP As Date
Private mExterior As Boolean

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Dim oRs As ADOR.Recordset
         Dim mDiasCheque As Integer
         
         If Len(DataCombo1(0).BoundText) = 0 Then
            MsgBox "No definio el tipo de valor", vbExclamation
            Exit Sub
         End If
         
         If DataCombo1(1).Visible And Len(DataCombo1(1).BoundText) = 0 Then
            MsgBox "No definio la cuenta bancaria", vbExclamation
            Exit Sub
         End If
         
         If DataCombo1(0).BoundText = 6 And Len(DataCombo1(2).BoundText) = 0 Then
            MsgBox "No definio la chequera", vbExclamation
            Exit Sub
         End If
         
         If DataCombo1(3).Visible And Len(DataCombo1(3).BoundText) = 0 Then
            MsgBox "No definio la tarjeta de credito", vbExclamation
            Exit Sub
         End If
         
         If Not origen.NumeroValorValido Then
            MsgBox "Numero de valor existente", vbExclamation
            Exit Sub
         End If
         
         If mvarChequeraDesde <> 0 And mvarChequeraHasta <> 0 And _
               (Val(txtNumeroValor.Text) < mvarChequeraDesde Or Val(txtNumeroValor.Text) > mvarChequeraHasta) Then
            MsgBox "El numero de valor debe estar entre " & mvarChequeraDesde & " y el " & mvarChequeraHasta, vbExclamation
         End If
         
         mDiasCheque = 1
         If BuscarClaveINI("No controlar fecha de cheques de pago diferido en op") = "SI" Then mDiasCheque = 0
         If Not Me.Exterior And mvarChequeraPagoDiferido = "SI" And DateDiff("d", Me.FechaOP, DTFields(0).Value) < mDiasCheque Then
            MsgBox "La fecha del cheque no puede ser anterior al " & DateAdd("d", mDiasCheque, Me.FechaOP), vbExclamation
            Exit Sub
         End If
         
         If mvarId = -1 Then
            Dim oPar As ComPronto.Parametro
            Dim mNum As Long
            Set oPar = Aplicacion.Parametros.Item(1)
            With oPar.Registro
               mNum = .Fields("ProximoNumeroInternoChequeEmitido").Value
               origen.Registro.Fields("NumeroInterno").Value = mNum
               .Fields("ProximoNumeroInternoChequeEmitido").Value = mNum + 1
            End With
            oPar.Guardar
            Set oPar = Nothing
         End If
         
         With origen.Registro
            .Fields("FechaVencimiento").Value = DTFields(0).Value
            .Fields("IdTipoValor").Value = DataCombo1(0).BoundText
            If DataCombo1(1).Visible And IsNumeric(DataCombo1(1).BoundText) Then
               .Fields("IdCuentaBancaria").Value = DataCombo1(1).BoundText
               Set oRs = Aplicacion.CuentasBancarias.TraerFiltrado("_PorId", DataCombo1(1).BoundText)
               If oRs.RecordCount > 0 Then .Fields("IdBanco").Value = oRs.Fields("IdBanco").Value
               oRs.Close
            Else
               .Fields("IdCuentaBancaria").Value = Null
               .Fields("IdBanco").Value = Null
            End If
            If DataCombo1(3).Visible And IsNumeric(DataCombo1(3).BoundText) Then
               .Fields("IdTarjetaCredito").Value = DataCombo1(3).BoundText
            Else
               .Fields("IdTarjetaCredito").Value = Null
            End If
            If Check1.Value = 0 Then
               .Fields("NoALaOrden").Value = "NO"
            Else
               .Fields("NoALaOrden").Value = "SI"
            End If
         End With
         origen.Modificado = True
         Aceptado = True
   End Select
   
   Me.Hide

   Set oRs = Nothing

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   Dim mIdMoneda As Long, mIdCuentaBancaria As Long

   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oOrdenPago.DetOrdenesPagoValores.Item(vNewValue)
   
   Me.IdNuevo = origen.Id
   Aceptado = False
   mIdMoneda = IIf(IsNull(oOrdenPago.Registro.Fields("IdMoneda").Value), 0, oOrdenPago.Registro.Fields("IdMoneda").Value)
   mIdCuentaBancaria = 0
   mvarChequeraPagoDiferido = "NO"
   
   Set oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
   If oRs.RecordCount > 0 Then
      mvarIdTipoComprobanteTarjetaCredito = IIf(IsNull(oRs.Fields("IdTipoComprobanteTarjetaCredito").Value), 0, oRs.Fields("IdTipoComprobanteTarjetaCredito").Value)
   End If
   oRs.Close
   
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
                  Set oRs = oAp.Bancos.TraerFiltrado("_PorCuentasBancariasIdMoneda", mIdMoneda)
                  If oRs.RecordCount = 1 Then mIdCuentaBancaria = oRs.Fields(0).Value
                  Set oControl.RowSource = oRs
                  Set oRs = Nothing
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
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      Dim mvarNumeroInterno
      Set oRs = oAp.Parametros.Item(1).Registro
      mvarNumeroInterno = oRs.Fields("ProximoNumeroInternoChequeEmitido").Value
      oRs.Close
      Set oRs = Nothing
      With origen.Registro
         .Fields("NumeroInterno").Value = mvarNumeroInterno
         .Fields("IdTipoValor").Value = 6
         If mIdCuentaBancaria > 0 Then .Fields("IdCuentaBancaria").Value = mIdCuentaBancaria
         If Not IsNull(oOrdenPago.Registro.Fields("IdProveedor").Value) Then
            Set oRs = oAp.Proveedores.Item(oOrdenPago.Registro.Fields("IdProveedor").Value).Registro
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("ChequesALaOrdenDe").Value) Then
                  .Fields("ChequesALaOrdenDe").Value = oRs.Fields("ChequesALaOrdenDe").Value
               Else
                  .Fields("ChequesALaOrdenDe").Value = oRs.Fields("RazonSocial").Value
               End If
            End If
            oRs.Close
            Set oRs = Nothing
         End If
         .Fields("Importe").Value = IIf(Me.ImporteDefault > 0, Me.ImporteDefault, 0)
      End With
      Check1.Value = 0
   Else
      With origen.Registro
         If IsNull(.Fields("NoALaOrden").Value) Or .Fields("NoALaOrden").Value = "NO" Then
            Check1.Value = 0
         Else
            Check1.Value = 1
         End If
      End With
      Set oRs = Aplicacion.Valores.TraerFiltrado("_PorIdDetalleOrdenPagoValores", mvarId)
      If oRs.RecordCount > 0 Then
         If IIf(IsNull(oRs.Fields("Anulado").Value), "NO", oRs.Fields("Anulado").Value) = "SI" Then
            With lblEstado
               .Caption = "ANULADO"
               .Visible = True
            End With
            cmd(0).Enabled = False
         End If
      End If
      oRs.Close
   End If
   
   With DataCombo1(3)
      .Top = DataCombo1(1).Top
      .Left = DataCombo1(1).Left
      .Width = DataCombo1(1).Width
   End With

   Set oRs = Nothing
   Set oAp = Nothing

End Property

Public Property Get OrdenPago() As ComPronto.OrdenPago

   Set OrdenPago = oOrdenPago

End Property

Public Property Set OrdenPago(ByVal vNewValue As ComPronto.OrdenPago)

   Set oOrdenPago = vNewValue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   Dim oRs As ADOR.Recordset
   
   If IsNumeric(DataCombo1(Index).BoundText) Then
      origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
      If Index = 0 Then
         If DataCombo1(Index).BoundText <> 6 Then
            origen.Registro.Fields(DataCombo1(2).DataField).Value = Null
            DataCombo1(2).Enabled = False
         Else
            DataCombo1(2).Enabled = True
         End If
         If DataCombo1(Index).BoundText = mvarIdTipoComprobanteTarjetaCredito Then
            DataCombo1(1).Visible = False
            DataCombo1(3).Visible = True
         Else
            DataCombo1(1).Visible = True
            DataCombo1(3).Visible = False
         End If
      ElseIf Index = 1 Then
         If mvarId < 0 Then
            Set oRs = Aplicacion.BancoChequeras.TraerFiltrado("_ActivasPorIdCuentaBancariaParaCombo", DataCombo1(Index).BoundText)
         Else
            Set oRs = Aplicacion.BancoChequeras.TraerFiltrado("_PorIdCuentaBancaria", DataCombo1(Index).BoundText)
         End If
         Set DataCombo1(2).RowSource = oRs
         If oRs.RecordCount > 0 Then
            If Not IsNull(origen.Registro.Fields("IdBancoChequera").Value) Then
               DataCombo1(2).BoundText = origen.Registro.Fields("IdBancoChequera").Value
            End If
         Else
            If DataCombo1(0).BoundText = 6 Then origen.Registro.Fields(DataCombo1(Index).DataField).Value = Null
         End If
         'oRs.Close
      ElseIf Index = 2 Then
         If Len(txtNumeroValor.Text) = 0 Or mvarId < 0 Then
            origen.Registro.Fields("NumeroValor").Value = origen.ProximoNumeroCheque(DataCombo1(Index).BoundText)
         End If
         mvarChequeraDesde = 0
         mvarChequeraHasta = 0
         Set oRs = Aplicacion.BancoChequeras.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
         If oRs.RecordCount > 0 Then
            mvarChequeraDesde = IIf(IsNull(oRs.Fields("DesdeCheque").Value), 0, oRs.Fields("DesdeCheque").Value)
            mvarChequeraHasta = IIf(IsNull(oRs.Fields("HastaCheque").Value), 0, oRs.Fields("HastaCheque").Value)
            mvarChequeraPagoDiferido = IIf(IsNull(oRs.Fields("ChequeraPagoDiferido").Value), "NO", oRs.Fields("ChequeraPagoDiferido").Value)
         End If
         oRs.Close
      End If
   End If

   Set oRs = Nothing
   
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

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   If mvarId = -1 And Not Aceptado Then origen.Eliminado = True

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oOrdenPago = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub txtChequesALaOrdenDe_GotFocus()

   With txtChequesALaOrdenDe
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtChequesALaOrdenDe_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtChequesALaOrdenDe
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

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

Private Sub txtNumeroInterno_GotFocus()

   With txtNumeroInterno
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroInterno_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroValor_GotFocus()

   With txtNumeroValor
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroValor_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroValor_Validate(Cancel As Boolean)

   If Len(txtNumeroValor.Text) > 0 Then
      If Not IsNumeric(txtNumeroValor.Text) Then
         MsgBox "Numero de valor invalido", vbExclamation
         Cancel = True
         Exit Sub
      End If
      If Len(txtNumeroValor.Text) > 9 Then
         MsgBox "Numero de valor no puede tener mas de 9 digitos", vbExclamation
         Cancel = True
         Exit Sub
      End If
   End If
End Sub

Public Property Get ImporteDefault() As Double

   ImporteDefault = mImporteDefault

End Property

Public Property Let ImporteDefault(ByVal vNewValue As Double)

   mImporteDefault = vNewValue

End Property

Public Property Get FechaOP() As Date

   FechaOP = mFechaOP

End Property

Public Property Let FechaOP(ByVal vNewValue As Date)

   mFechaOP = vNewValue

End Property

Public Property Get Exterior() As Boolean

   Exterior = mExterior

End Property

Public Property Let Exterior(ByVal vNewValue As Boolean)

   mExterior = vNewValue

End Property
