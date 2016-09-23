VERSION 5.00
Begin VB.Form frmDetOrdenesPago 
   Caption         =   "Item de imputacion de ordenes de pago"
   ClientHeight    =   1590
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5880
   Icon            =   "frmDetOrdenesPago.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1590
   ScaleWidth      =   5880
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtAnticipoSinImpuestos 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Height          =   360
      Left            =   2700
      TabIndex        =   2
      Top             =   1125
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.TextBox txtCancelado 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Height          =   360
      Left            =   5535
      TabIndex        =   7
      Top             =   1215
      Visible         =   0   'False
      Width           =   285
   End
   Begin VB.TextBox txtACancelar 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Height          =   360
      Left            =   2700
      TabIndex        =   1
      Top             =   630
      Width           =   1455
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   4320
      TabIndex        =   3
      Top             =   180
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   4320
      TabIndex        =   4
      Top             =   675
      Width           =   1485
   End
   Begin VB.TextBox txtSaldo 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Left            =   2700
      TabIndex        =   0
      Top             =   135
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe del anticipo sin impuestos :"
      Height          =   300
      Index           =   2
      Left            =   135
      TabIndex        =   8
      Top             =   1170
      Visible         =   0   'False
      Width           =   2490
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe a cancelar :"
      Height          =   300
      Index           =   1
      Left            =   135
      TabIndex        =   6
      Top             =   675
      Width           =   2490
   End
   Begin VB.Label lblLabels 
      Caption         =   "Saldo en cuenta corriente :"
      Height          =   300
      Index           =   0
      Left            =   135
      TabIndex        =   5
      Top             =   180
      Width           =   2490
   End
End
Attribute VB_Name = "frmDetOrdenesPago"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Aceptado As Boolean
Private mTipoComprobante As String

Public Property Get Saldo() As Double

   Saldo = Val(txtSaldo.Text)

End Property

Public Property Let Saldo(ByVal vNewValue As Double)

   txtSaldo.Text = vNewValue

End Property

Public Property Let Cancelado(ByVal vNewValue As Double)

   txtCancelado.Text = vNewValue

End Property

Public Property Let ACancelar(ByVal vNewValue As Double)

   txtACancelar.Text = vNewValue

End Property

Public Property Let AnticipoSinImpuestos(ByVal vNewValue As Double)

   txtAnticipoSinImpuestos.Text = vNewValue

End Property

Public Property Get TipoComprobante() As String

   TipoComprobante = mTipoComprobante

End Property

Public Property Let TipoComprobante(ByVal vNewValue As String)

   mTipoComprobante = vNewValue
   
   If mTipoComprobante = "PA" Then
      txtAnticipoSinImpuestos.Visible = True
      lblLabels(2).Visible = True
   End If

End Property

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then
      Aceptado = True
   Else
      Aceptado = False
   End If
   Me.Hide
   
End Sub

Private Sub Form_Load()

   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub txtACancelar_GotFocus()

   With txtACancelar
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtACancelar_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtACancelar_Validate(Cancel As Boolean)

   If Len(Trim(txtACancelar.Text)) <> 0 Then
      If Val(txtSaldo.Text) >= 0 Then
         If (Val(txtACancelar.Text) > Val(txtSaldo.Text) + Val(txtCancelado.Text) Or _
               Val(txtACancelar.Text) < 0) And mTipoComprobante <> "PA" Then
            MsgBox "El monto a cancelar no puede ser mayor al saldo del comprobante.", vbCritical
            Cancel = True
         End If
      Else
         If Abs(Val(txtACancelar.Text)) > Abs(Val(txtSaldo.Text)) + Abs(Val(txtCancelado.Text)) Or Val(txtACancelar.Text) > 0 Then
            MsgBox "El monto a cancelar no puede ser mayor al saldo del comprobante.", vbCritical
            Cancel = True
         End If
      End If
   End If
   
End Sub

Private Sub txtAnticipoSinImpuestos_GotFocus()

   With txtAnticipoSinImpuestos
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAnticipoSinImpuestos_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
