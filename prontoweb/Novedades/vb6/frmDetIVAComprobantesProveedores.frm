VERSION 5.00
Begin VB.Form frmDetIVAComprobantesProveedores 
   Caption         =   "Detalle de cuentas de IVA"
   ClientHeight    =   5280
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7845
   LinkTopic       =   "Form1"
   ScaleHeight     =   5280
   ScaleWidth      =   7845
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check1 
      Caption         =   "Check1"
      Height          =   285
      Index           =   9
      Left            =   90
      TabIndex        =   63
      Top             =   4365
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Check1"
      Height          =   285
      Index           =   8
      Left            =   90
      TabIndex        =   62
      Top             =   4005
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Check1"
      Height          =   285
      Index           =   7
      Left            =   90
      TabIndex        =   61
      Top             =   3645
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Check1"
      Height          =   285
      Index           =   6
      Left            =   90
      TabIndex        =   60
      Top             =   3285
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Check1"
      Height          =   285
      Index           =   5
      Left            =   90
      TabIndex        =   59
      Top             =   2925
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Check1"
      Height          =   285
      Index           =   4
      Left            =   90
      TabIndex        =   58
      Top             =   2565
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Check1"
      Height          =   285
      Index           =   3
      Left            =   90
      TabIndex        =   57
      Top             =   2205
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Check1"
      Height          =   285
      Index           =   2
      Left            =   90
      TabIndex        =   56
      Top             =   1845
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Check1"
      Height          =   285
      Index           =   1
      Left            =   90
      TabIndex        =   55
      Top             =   1485
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Check1"
      Height          =   285
      Index           =   0
      Left            =   90
      TabIndex        =   54
      Top             =   1125
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "Recalcular"
      Height          =   405
      Index           =   2
      Left            =   2565
      TabIndex        =   53
      Top             =   4770
      Width           =   990
   End
   Begin VB.TextBox txtTotalComprobante 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   2070
      Locked          =   -1  'True
      TabIndex        =   51
      Top             =   270
      Width           =   1365
   End
   Begin VB.TextBox txtExento 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   6300
      TabIndex        =   0
      Top             =   90
      Width           =   1365
   End
   Begin VB.TextBox txtGravado 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   6300
      TabIndex        =   1
      Top             =   450
      Width           =   1365
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   6300
      Locked          =   -1  'True
      TabIndex        =   47
      Top             =   4770
      Width           =   1365
   End
   Begin VB.TextBox txtId 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   9
      Left            =   5355
      TabIndex        =   46
      Top             =   4365
      Visible         =   0   'False
      Width           =   105
   End
   Begin VB.TextBox txtId 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   8
      Left            =   5355
      TabIndex        =   45
      Top             =   4005
      Visible         =   0   'False
      Width           =   105
   End
   Begin VB.TextBox txtId 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   7
      Left            =   5355
      TabIndex        =   44
      Top             =   3645
      Visible         =   0   'False
      Width           =   105
   End
   Begin VB.TextBox txtId 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   6
      Left            =   5355
      TabIndex        =   43
      Top             =   3285
      Visible         =   0   'False
      Width           =   105
   End
   Begin VB.TextBox txtId 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   5
      Left            =   5355
      TabIndex        =   42
      Top             =   2925
      Visible         =   0   'False
      Width           =   105
   End
   Begin VB.TextBox txtId 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   4
      Left            =   5355
      TabIndex        =   41
      Top             =   2565
      Visible         =   0   'False
      Width           =   105
   End
   Begin VB.TextBox txtId 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   3
      Left            =   5355
      TabIndex        =   40
      Top             =   2205
      Visible         =   0   'False
      Width           =   105
   End
   Begin VB.TextBox txtId 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   2
      Left            =   5355
      TabIndex        =   39
      Top             =   1845
      Visible         =   0   'False
      Width           =   105
   End
   Begin VB.TextBox txtId 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   1
      Left            =   5355
      TabIndex        =   38
      Top             =   1485
      Visible         =   0   'False
      Width           =   105
   End
   Begin VB.TextBox txtId 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   0
      Left            =   5355
      TabIndex        =   37
      Top             =   1125
      Visible         =   0   'False
      Width           =   105
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1440
      TabIndex        =   23
      Top             =   4770
      Width           =   990
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   315
      TabIndex        =   22
      Top             =   4770
      Width           =   990
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   9
      Left            =   6300
      TabIndex        =   21
      Top             =   4365
      Visible         =   0   'False
      Width           =   1365
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   9
      Left            =   5445
      TabIndex        =   20
      Top             =   4365
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.TextBox txtCuenta 
      Height          =   285
      Index           =   9
      Left            =   315
      TabIndex        =   36
      Top             =   4365
      Visible         =   0   'False
      Width           =   5010
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   8
      Left            =   6300
      TabIndex        =   19
      Top             =   4005
      Visible         =   0   'False
      Width           =   1365
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   8
      Left            =   5445
      TabIndex        =   18
      Top             =   4005
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.TextBox txtCuenta 
      Height          =   285
      Index           =   8
      Left            =   315
      TabIndex        =   35
      Top             =   4005
      Visible         =   0   'False
      Width           =   5010
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   7
      Left            =   6300
      TabIndex        =   17
      Top             =   3645
      Visible         =   0   'False
      Width           =   1365
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   7
      Left            =   5445
      TabIndex        =   16
      Top             =   3645
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.TextBox txtCuenta 
      Height          =   285
      Index           =   7
      Left            =   315
      TabIndex        =   34
      Top             =   3645
      Visible         =   0   'False
      Width           =   5010
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   6
      Left            =   6300
      TabIndex        =   15
      Top             =   3285
      Visible         =   0   'False
      Width           =   1365
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   6
      Left            =   5445
      TabIndex        =   14
      Top             =   3285
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.TextBox txtCuenta 
      Height          =   285
      Index           =   6
      Left            =   315
      TabIndex        =   33
      Top             =   3285
      Visible         =   0   'False
      Width           =   5010
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   5
      Left            =   6300
      TabIndex        =   13
      Top             =   2925
      Visible         =   0   'False
      Width           =   1365
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   5
      Left            =   5445
      TabIndex        =   12
      Top             =   2925
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.TextBox txtCuenta 
      Height          =   285
      Index           =   5
      Left            =   315
      TabIndex        =   32
      Top             =   2925
      Visible         =   0   'False
      Width           =   5010
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   4
      Left            =   6300
      TabIndex        =   11
      Top             =   2565
      Visible         =   0   'False
      Width           =   1365
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   4
      Left            =   5445
      TabIndex        =   10
      Top             =   2565
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.TextBox txtCuenta 
      Height          =   285
      Index           =   4
      Left            =   315
      TabIndex        =   31
      Top             =   2565
      Visible         =   0   'False
      Width           =   5010
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   3
      Left            =   6300
      TabIndex        =   9
      Top             =   2205
      Visible         =   0   'False
      Width           =   1365
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   3
      Left            =   5445
      TabIndex        =   8
      Top             =   2205
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.TextBox txtCuenta 
      Height          =   285
      Index           =   3
      Left            =   315
      TabIndex        =   30
      Top             =   2205
      Visible         =   0   'False
      Width           =   5010
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   2
      Left            =   6300
      TabIndex        =   7
      Top             =   1845
      Visible         =   0   'False
      Width           =   1365
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   2
      Left            =   5445
      TabIndex        =   6
      Top             =   1845
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.TextBox txtCuenta 
      Height          =   285
      Index           =   2
      Left            =   315
      TabIndex        =   29
      Top             =   1845
      Visible         =   0   'False
      Width           =   5010
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   1
      Left            =   6300
      TabIndex        =   5
      Top             =   1485
      Visible         =   0   'False
      Width           =   1365
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   1
      Left            =   5445
      TabIndex        =   4
      Top             =   1485
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.TextBox txtCuenta 
      Height          =   285
      Index           =   1
      Left            =   315
      TabIndex        =   28
      Top             =   1485
      Visible         =   0   'False
      Width           =   5010
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   0
      Left            =   6300
      TabIndex        =   3
      Top             =   1125
      Visible         =   0   'False
      Width           =   1365
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   0
      Left            =   5445
      TabIndex        =   2
      Top             =   1125
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.TextBox txtCuenta 
      Height          =   285
      Index           =   0
      Left            =   315
      TabIndex        =   24
      Top             =   1125
      Visible         =   0   'False
      Width           =   5010
   End
   Begin VB.Label Label5 
      Caption         =   "Total suma del comprobante :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   465
      Left            =   315
      TabIndex        =   52
      Top             =   180
      Width           =   1590
   End
   Begin VB.Label Label4 
      Caption         =   "Subtotal exento :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   4590
      TabIndex        =   50
      Top             =   90
      Width           =   1590
   End
   Begin VB.Label Label3 
      Caption         =   "Subtotal gravado :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   4590
      TabIndex        =   49
      Top             =   450
      Width           =   1590
   End
   Begin VB.Label Label2 
      Caption         =   "Total IVA:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   5355
      TabIndex        =   48
      Top             =   4815
      Width           =   870
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H00400040&
      Caption         =   "Importe"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   240
      Index           =   2
      Left            =   6300
      TabIndex        =   27
      Top             =   810
      Width           =   1365
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H00400040&
      Caption         =   "%"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   240
      Index           =   1
      Left            =   5445
      TabIndex        =   26
      Top             =   810
      Width           =   735
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H00400040&
      Caption         =   "Cuenta"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   240
      Index           =   0
      Left            =   315
      TabIndex        =   25
      Top             =   810
      Width           =   5010
   End
End
Attribute VB_Name = "frmDetIVAComprobantesProveedores"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public OK As Boolean
Private mSubtotalComprobante As Double
Dim oComprobanteProveedor As ComAuto.ComprobanteProveedor

Public Property Get Comprobante() As ComAuto.ComprobanteProveedor

   Set ComprobanteProveedor = oComprobanteProveedor

End Property

Public Property Set Comprobante(ByVal vNewValue As ComAuto.ComprobanteProveedor)

   Set oComprobanteProveedor = vNewValue

End Property

Private Sub Check1_Click(Index As Integer)

   If Check1(Index).Value = 1 Then
      txtImporte(Index).Text = Round(Val(txtGravado.Text) * Val(txtPorcentaje(Index).Text) / 100, 2)
   Else
      txtImporte(Index).Text = 0
   End If
   CalcularTotal
   
End Sub

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then
      If Val(txtExento.Text) + Val(txtGravado.Text) <> Val(txtTotalComprobante.Text) Then
         MsgBox "No coincide el total del comprobante y la suma" & vbCrLf & _
                  "del gravado mas el exento, verifique los valores", vbExclamation
         Exit Sub
      End If
      OK = True
      Me.Hide
   ElseIf Index = 1 Then
      OK = False
      Me.Hide
   ElseIf Index = 2 Then
      Dim i As Integer
      For i = 1 To 10
         If Check1(i - 1).Value = 1 Then
            txtImporte(i - 1).Text = Round(Val(txtGravado.Text) * Val(txtPorcentaje(i - 1).Text) / 100, 2)
         End If
      Next
      CalcularTotal
   End If
   
End Sub

Private Sub Form_Load()

   Dim i As Integer
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim oRsPar As ADOR.Recordset
   
   Set oRs = oComprobanteProveedor.Registro
   Set oRsPar = Aplicacion.Parametros.Item(1).Registro
   
   For i = 1 To 10
      If Not IsNull(oRs.Fields("IdCuentaIvaCompras" & i).Value) Then
         Set oRs1 = Aplicacion.Cuentas.Item(oRs.Fields("IdCuentaIvaCompras" & i).Value).Registro
         txtId(i - 1).Text = oRs.Fields("IdCuentaIvaCompras" & i).Value
         Check1(i - 1).Visible = True
         If oRs.Fields("IVAComprasImporte" & i).Value <> 0 Then Check1(i - 1).Value = 1
         txtCuenta(i - 1).Visible = True
         If oRs1.RecordCount > 0 Then
            txtCuenta(i - 1).Text = oRs1.Fields("Descripcion").Value
         Else
            txtCuenta(i - 1).Text = "N/A !! "
         End If
         txtPorcentaje(i - 1).Visible = True
         txtPorcentaje(i - 1).Text = oRs.Fields("IVAComprasPorcentaje" & i).Value
         txtImporte(i - 1).Visible = True
         txtImporte(i - 1).Text = oRs.Fields("IVAComprasImporte" & i).Value
         oRs1.Close
      Else
         If Not IsNull(oRsPar.Fields("IdCuentaIvaCompras" & i).Value) Then
            Set oRs1 = Aplicacion.Cuentas.Item(oRsPar.Fields("IdCuentaIvaCompras" & i).Value).Registro
            txtId(i - 1).Text = oRsPar.Fields("IdCuentaIvaCompras" & i).Value
            Check1(i - 1).Visible = True
            Check1(i - 1).Value = 0
            txtCuenta(i - 1).Visible = True
            If oRs1.RecordCount > 0 Then
               txtCuenta(i - 1).Text = oRs1.Fields("Descripcion").Value
            Else
               txtCuenta(i - 1).Text = "N/A !! "
            End If
            txtPorcentaje(i - 1).Visible = True
            txtPorcentaje(i - 1).Text = oRsPar.Fields("IVAComprasPorcentaje" & i).Value
            txtImporte(i - 1).Visible = True
            txtImporte(i - 1).Text = 0
            oRs1.Close
         End If
      End If
   Next

   If Not IsNull(oRs.Fields("SubtotalGravado").Value) Then
      txtGravado.Text = oRs.Fields("SubtotalGravado").Value
   Else
      txtGravado.Text = mSubtotalComprobante
   End If
   If Not IsNull(oRs.Fields("SubtotalExento").Value) Then
      txtExento.Text = oRs.Fields("SubtotalExento").Value
   End If
   txtTotalComprobante.Text = mSubtotalComprobante
   
   Set oRs = Nothing
   oRsPar.Close
   Set oRsPar = Nothing
   
   CalcularTotal
   
End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oComprobanteProveedor = Nothing
   
End Sub

Private Sub txtExento_Change()

   txtGravado.Text = mSubtotalComprobante - Val(txtExento.Text)
   
End Sub

Private Sub txtExento_GotFocus()

   With txtExento
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtExento_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtGravado_Change()

   txtExento.Text = mSubtotalComprobante - Val(txtGravado.Text)
   
End Sub

Private Sub txtGravado_GotFocus()

   With txtGravado
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtGravado_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtImporte_Change(Index As Integer)

   CalcularTotal
   
End Sub

Private Sub txtImporte_GotFocus(Index As Integer)

   With txtImporte(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImporte_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPorcentaje_Change(Index As Integer)

   If Check1(Index).Value = 1 Then
      txtImporte(Index).Text = Round(Val(txtGravado.Text) * txtPorcentaje(Index).Text / 100, 2)
      CalcularTotal
   End If
   
End Sub

Private Sub txtPorcentaje_GotFocus(Index As Integer)

   With txtPorcentaje(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcentaje_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Sub CalcularTotal()

   Dim i As Integer
   Dim mSubtotal As Double
   
   mSubtotal = 0
   For i = 1 To 10
      mSubtotal = mSubtotal + Val(txtImporte(i - 1).Text)
   Next
   txtTotal.Text = Format(mSubtotal, "#,##0.00")
   
End Sub

Public Property Let SubtotalComprobante(ByVal vNewValue As Double)

   mSubtotalComprobante = vNewValue
   
End Property
