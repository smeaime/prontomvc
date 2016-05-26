VERSION 5.00
Begin VB.Form frmDetRecibos 
   Caption         =   "Item de imputacion de recibo de pago"
   ClientHeight    =   1155
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5955
   Icon            =   "frmDetRecibos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1155
   ScaleWidth      =   5955
   StartUpPosition =   2  'CenterScreen
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
      Left            =   2385
      TabIndex        =   3
      Top             =   90
      Width           =   1455
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   4230
      TabIndex        =   2
      Top             =   585
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   4230
      TabIndex        =   1
      Top             =   90
      Width           =   1485
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
      Left            =   2385
      TabIndex        =   0
      Top             =   585
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      Caption         =   "Saldo en cuenta corriente :"
      Height          =   300
      Index           =   5
      Left            =   135
      TabIndex        =   5
      Top             =   135
      Width           =   2175
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe a cancelar :"
      Height          =   300
      Index           =   0
      Left            =   135
      TabIndex        =   4
      Top             =   630
      Width           =   2175
   End
End
Attribute VB_Name = "frmDetRecibos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Property Let Saldo(ByVal vNewValue As Double)

   txtSaldo.Text = vNewValue

End Property

Public Property Let ACancelar(ByVal vNewValue As Double)

   txtACancelar.Text = vNewValue

End Property

Private Sub cmd_Click(Index As Integer)

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
         If Val(txtACancelar.Text) > Val(txtSaldo.Text) Or Val(txtACancelar.Text) < 0 Then
            MsgBox "El monto a cancelar no puede ser mayor al saldo del comprobante.", vbCritical
            Cancel = True
         End If
      Else
         If Abs(Val(txtACancelar.Text)) > Abs(Val(txtSaldo.Text)) Or Val(txtACancelar.Text) > 0 Then
            MsgBox "El monto a cancelar no puede ser mayor al saldo del comprobante.", vbCritical
            Cancel = True
         End If
      End If
   End If
   
End Sub
