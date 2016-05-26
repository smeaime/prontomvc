VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F09A78C8-7814-11D2-8355-4854E82A9183}#1.1#0"; "CUIT32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetRecibosValores 
   Caption         =   "Item de ingreso de valores [ Recibos de pago ]"
   ClientHeight    =   5775
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6120
   Icon            =   "frmDetRecibosValores.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5775
   ScaleWidth      =   6120
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtCodigoCuenta 
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
      Height          =   300
      Left            =   2070
      TabIndex        =   19
      Top             =   3645
      Width           =   1185
   End
   Begin VB.TextBox txtNumeroTransferencia 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroTransferencia"
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
      TabIndex        =   17
      Top             =   2745
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
      Height          =   315
      Left            =   2070
      TabIndex        =   0
      Top             =   630
      Width           =   1095
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
      Height          =   315
      Left            =   2070
      TabIndex        =   3
      Top             =   1440
      Width           =   1455
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
      Left            =   2070
      TabIndex        =   6
      Top             =   4545
      Width           =   1455
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1710
      TabIndex        =   8
      Top             =   5175
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   7
      Top             =   5175
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdTipoValor"
      Height          =   315
      Index           =   0
      Left            =   2070
      TabIndex        =   1
      Tag             =   "TiposValor"
      Top             =   135
      Width           =   3930
      _ExtentX        =   6932
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoComprobante"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdBanco"
      Height          =   315
      Index           =   1
      Left            =   2070
      TabIndex        =   2
      Tag             =   "Bancos"
      Top             =   1035
      Width           =   3930
      _ExtentX        =   6932
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdBanco"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaVencimiento"
      Height          =   330
      Index           =   0
      Left            =   4725
      TabIndex        =   4
      Top             =   1440
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   59965441
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaBancariaTransferencia"
      Height          =   315
      Index           =   2
      Left            =   2070
      TabIndex        =   15
      Tag             =   "BancosCuentas"
      Top             =   2340
      Width           =   3930
      _ExtentX        =   6932
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaBancaria"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   3
      Left            =   2070
      TabIndex        =   20
      Tag             =   "Cuentas"
      Top             =   4005
      Width           =   3945
      _ExtentX        =   6959
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdTipoCuentaGrupo"
      Height          =   315
      Index           =   4
      Left            =   2070
      TabIndex        =   21
      Tag             =   "TiposCuentaGrupos"
      Top             =   3240
      Width           =   3930
      _ExtentX        =   6932
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoCuentaGrupo"
      Text            =   ""
   End
   Begin Control_CUIT.CUIT CUIT1 
      Height          =   285
      Left            =   2070
      TabIndex        =   5
      Top             =   1845
      Width           =   1545
      _ExtentX        =   2725
      _ExtentY        =   503
      Text            =   ""
      MensajeErr      =   "CUIT incorrecto"
      otrosP          =   -1  'True
   End
   Begin VB.Label lblLabels 
      Caption         =   "CUIT del librador : "
      Height          =   300
      Index           =   1
      Left            =   180
      TabIndex        =   24
      Top             =   1845
      Width           =   1815
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   3
      X1              =   135
      X2              =   5985
      Y1              =   4410
      Y2              =   4410
   End
   Begin VB.Label lblData 
      Caption         =   "Cuenta contable :"
      Height          =   255
      Index           =   3
      Left            =   180
      TabIndex        =   23
      Top             =   3690
      Width           =   1815
   End
   Begin VB.Label lblData 
      Caption         =   "Grupo cuenta contable :"
      Height          =   255
      Index           =   4
      Left            =   180
      TabIndex        =   22
      Top             =   3285
      Width           =   1815
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   2
      X1              =   135
      X2              =   5985
      Y1              =   3150
      Y2              =   3150
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de transferencia:"
      Height          =   300
      Index           =   6
      Left            =   180
      TabIndex        =   18
      Top             =   2745
      Width           =   1815
   End
   Begin VB.Label lblData 
      Caption         =   "Banco / Cuenta :"
      Height          =   300
      Index           =   2
      Left            =   180
      TabIndex        =   16
      Top             =   2355
      Width           =   1815
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   1
      X1              =   135
      X2              =   5985
      Y1              =   2250
      Y2              =   2250
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   0
      X1              =   135
      X2              =   5985
      Y1              =   540
      Y2              =   540
   End
   Begin VB.Label lblLabels 
      Caption         =   "Vencimiento :"
      Height          =   285
      Index           =   22
      Left            =   3690
      TabIndex        =   14
      Top             =   1440
      Width           =   960
   End
   Begin VB.Label lblData 
      Caption         =   "Banco origen :"
      Height          =   255
      Index           =   1
      Left            =   180
      TabIndex        =   13
      Top             =   1080
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero interno :"
      Height          =   300
      Index           =   3
      Left            =   180
      TabIndex        =   12
      Top             =   675
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de cheque :"
      Height          =   300
      Index           =   0
      Left            =   180
      TabIndex        =   11
      Top             =   1440
      Width           =   1815
   End
   Begin VB.Label lblData 
      Caption         =   "Tipo de valor :"
      Height          =   300
      Index           =   0
      Left            =   180
      TabIndex        =   10
      Top             =   150
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe :"
      Height          =   255
      Index           =   5
      Left            =   180
      TabIndex        =   9
      Top             =   4590
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetRecibosValores"
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
Private mvarIdNuevo As Long, mvarId As Long, mvarIdTarjetaCredito As Integer

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
            If Not IsNumeric(dc.BoundText) And dc.Enabled And dc.Index <> 4 Then
               MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
               Exit Sub
            End If
            If IsNumeric(dc.BoundText) Then
               origen.Registro.Fields(dc.DataField).Value = dc.BoundText
            End If
         Next
         
         If txtNumeroValor.Enabled And Len(txtNumeroValor.Text) = 0 Then
            MsgBox "Debe ingresar el numero de valor", vbExclamation
            Exit Sub
         End If
         
         If txtNumeroTransferencia.Enabled And Len(txtNumeroTransferencia.Text) = 0 Then
            MsgBox "Debe ingresar el numero de transferencia", vbExclamation
            Exit Sub
         End If
         
         If Len(txtImporte.Text) = 0 Or Not IsNumeric(txtImporte.Text) Then
            MsgBox "Debe ingresar el importe", vbExclamation
            Exit Sub
         End If
         
         If DataCombo1(0).BoundText = 6 Then
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetRecibosValores", _
                        "_ValidarCheque", Array(mvarId, DataCombo1(1).BoundText, txtNumeroValor.Text))
            If oRs.RecordCount > 0 Then
               MsgBox "Un cheque con el mismo numero fue ingresado en el recibo " & _
                        oRs.Fields("NumeroRecibo").Value & " del " & _
                        oRs.Fields("FechaRecibo").Value & ", reingrese", vbExclamation
               oRs.Close
               Set oRs = Nothing
               Exit Sub
            End If
            oRs.Close
            Set oRs = Nothing
         End If
         
         origen.Registro.Fields("CuitLibrador").Value = CUIT1.Text

         If mvarId = -1 And Not IsNull(origen.Registro.Fields("NumeroInterno").Value) Then
            Dim oPar As ComPronto.Parametro
            Dim mNum As Long
            Set oPar = Aplicacion.Parametros.Item(1)
            With oPar.Registro
               mNum = .Fields("ProximoNumeroInterno").Value
               origen.Registro.Fields("NumeroInterno").Value = mNum
               .Fields("ProximoNumeroInterno").Value = mNum + 1
            End With
            oPar.Guardar
            Set oPar = Nothing
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
   
   Set oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
   With oRs
      mvarIdTarjetaCredito = IIf(IsNull(.Fields("IdTipoComprobanteTarjetaCredito").Value), 0, .Fields("IdTipoComprobanteTarjetaCredito").Value)
   End With
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
               If oControl.Tag = "BancosCuentas" Then
                  Set oControl.RowSource = oAp.Bancos.TraerFiltrado("_PorCuentasBancarias")
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
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
      Dim mvarNumeroInterno
      Set oRs = oAp.Parametros.Item(1).Registro
      mvarNumeroInterno = oRs.Fields("ProximoNumeroInterno").Value
      oRs.Close
      With origen.Registro
         .Fields("NumeroInterno").Value = mvarNumeroInterno
         .Fields("IdTipoValor").Value = 6
         .Fields("FechaVencimiento").Value = Date
      End With
   Else
      With origen.Registro
         CUIT1.Text = IIf(IsNull(.Fields("CuitLibrador").Value), "", .Fields("CuitLibrador").Value)
      End With
   End If

   If mvarId > 0 Then DataCombo1(0).Enabled = False
   
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
      Dim oRs As ADOR.Recordset
      Dim oRs1 As ADOR.Recordset
      Select Case Index
         Case 0
            Set oRs = Aplicacion.TiposComprobante.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
            If Not IsNull(oRs.Fields("PideBancoCuenta").Value) And oRs.Fields("PideBancoCuenta").Value = "SI" Then
               txtNumeroInterno.Enabled = False
               DataCombo1(1).Enabled = False
               txtNumeroValor.Enabled = False
               CUIT1.Enabled = False
               DataCombo1(2).Enabled = True
               txtNumeroTransferencia.Enabled = True
               DataCombo1(4).Enabled = False
               txtCodigoCuenta.Enabled = False
               DataCombo1(3).Enabled = False
               With lblLabels(22)
                  .Top = lblLabels(6).Top
                  .Caption = "Fecha :"
               End With
               With DTFields(0)
                  .Top = txtNumeroTransferencia.Top
                  .Enabled = True
               End With
               With origen.Registro
                  .Fields("NumeroInterno").Value = Null
                  .Fields("IdBanco").Value = Null
                  .Fields("NumeroValor").Value = Null
                  If mvarId <= 0 Then .Fields("FechaVencimiento").Value = Date
                  .Fields("IdTipoCuentaGrupo").Value = Null
                  .Fields("IdBancoTransferencia").Value = Null
                  .Fields("IdCuenta").Value = Null
               End With
            ElseIf Not IsNull(oRs.Fields("PideCuenta").Value) And oRs.Fields("PideCuenta").Value = "SI" Then
               txtNumeroInterno.Enabled = False
               DataCombo1(1).Enabled = False
               txtNumeroValor.Enabled = False
               CUIT1.Enabled = False
               DataCombo1(2).Enabled = False
               txtNumeroTransferencia.Enabled = False
               DataCombo1(4).Enabled = True
               txtCodigoCuenta.Enabled = True
               DataCombo1(3).Enabled = True
               With lblLabels(22)
                  .Top = lblLabels(0).Top
                  .Caption = "Vencimiento :"
               End With
               With DTFields(0)
                  .Top = txtNumeroValor.Top
                  .Enabled = False
               End With
               With origen.Registro
                  .Fields("NumeroInterno").Value = Null
                  .Fields("IdBanco").Value = Null
                  .Fields("NumeroValor").Value = Null
                  .Fields("FechaVencimiento").Value = Date
                  .Fields("IdCuentaBancariaTransferencia").Value = Null
                  .Fields("NumeroTransferencia").Value = Null
                  If IsNull(.Fields("IdCuenta").Value) Then
                     .Fields("IdCuenta").Value = oRs.Fields("IdCuentaDefault").Value
                     If Not IsNull(oRs.Fields("IdCuentaDefault").Value) Then
                        Set oRs1 = Aplicacion.Cuentas.TraerFiltrado("_PorId", oRs.Fields("IdCuentaDefault").Value)
                        If oRs1.RecordCount > 0 Then
                           .Fields("IdTipoCuentaGrupo").Value = oRs1.Fields("IdTipoCuentaGrupo").Value
                           txtCodigoCuenta.Text = oRs1.Fields("Codigo").Value
                        End If
                        oRs1.Close
                        Set oRs1 = Nothing
                     End If
                  End If
               End With
            Else
               txtNumeroInterno.Enabled = True
               DataCombo1(1).Enabled = True
               txtNumeroValor.Enabled = True
               CUIT1.Enabled = True
               DataCombo1(2).Enabled = False
               txtNumeroTransferencia.Enabled = False
               DataCombo1(4).Enabled = False
               txtCodigoCuenta.Enabled = False
               DataCombo1(3).Enabled = False
               With lblLabels(22)
                  .Top = lblLabels(0).Top
                  .Caption = "Vencimiento :"
               End With
               With DTFields(0)
                  .Top = txtNumeroValor.Top
                  .Enabled = True
               End With
               With origen.Registro
                  .Fields("IdCuentaBancariaTransferencia").Value = Null
                  .Fields("NumeroTransferencia").Value = Null
                  .Fields("IdTipoCuentaGrupo").Value = Null
                  .Fields("IdBancoTransferencia").Value = Null
                  .Fields("IdCuenta").Value = Null
               End With
            End If
            oRs.Close
            Set oRs = Nothing
            
            If DataCombo1(Index).BoundText = mvarIdTarjetaCredito Then txtNumeroValor.Enabled = False
         
         Case 2
            Set oRs = Aplicacion.CuentasBancarias.TraerFiltrado("_PorIdConCuenta", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  .Fields("IdBancoTransferencia").Value = oRs.Fields("IdBanco").Value
                  .Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
               End With
            End If
            oRs.Close
            Set oRs = Nothing
         
         Case 3
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then txtCodigoCuenta.Text = oRs.Fields("Codigo").Value
            oRs.Close
            Set oRs = Nothing
         
         Case 4
            Dim mIdCuenta As Long
            If IsNumeric(DataCombo1(3).BoundText) Then
               mIdCuenta = DataCombo1(3).BoundText
            Else
               mIdCuenta = 0
            End If
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorGrupoParaCombo", DataCombo1(Index).BoundText)
            Set DataCombo1(3).RowSource = oRs
            origen.Registro.Fields(DataCombo1(3).DataField).Value = mIdCuenta
            Set oRs = Nothing
      End Select
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

Private Sub txtCodigoCuenta_GotFocus()

   With txtCodigoCuenta
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoCuenta_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoCuenta_Validate(Cancel As Boolean)

   If IsNumeric(txtCodigoCuenta.Text) Then
      On Error GoTo SalidaConError
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("Cod", txtCodigoCuenta.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdCuenta").Value = oRs.Fields(0).Value
      Else
         origen.Registro.Fields("IdCuenta").Value = Null
      End If
      oRs.Close
      Set oRs = Nothing
      Exit Sub
SalidaConError:
      Set oRs = Nothing
      origen.Registro.Fields(DataCombo1(0).DataField).Value = Null
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
