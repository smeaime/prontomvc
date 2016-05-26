VERSION 5.00
Begin VB.Form frmReservasIngresoManual 
   Caption         =   "Reserva de stock manual"
   ClientHeight    =   2865
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4545
   Icon            =   "frmReservasIngresoManual.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2865
   ScaleWidth      =   4545
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtItems 
      Height          =   2310
      Left            =   135
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   5
      Text            =   "frmReservasIngresoManual.frx":076A
      Top             =   405
      Width           =   3255
   End
   Begin VB.TextBox txtCantidadReservada 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
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
      Height          =   360
      Left            =   3510
      TabIndex        =   0
      Top             =   990
      Width           =   915
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancelar"
      Height          =   360
      Left            =   3525
      TabIndex        =   2
      Tag             =   "Cancelar"
      Top             =   2340
      Width           =   915
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "Aceptar"
      Height          =   360
      Left            =   3510
      TabIndex        =   1
      Tag             =   "Aceptar"
      Top             =   1845
      Width           =   915
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Items a afectar : "
      Height          =   195
      Index           =   0
      Left            =   180
      TabIndex        =   4
      Top             =   90
      Width           =   1185
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Cantidad a reservar :"
      Height          =   465
      Index           =   1
      Left            =   3555
      TabIndex        =   3
      Top             =   405
      Width           =   840
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "frmReservasIngresoManual"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Ok As Boolean
Private mvarItems As String

Private Sub cmdCancel_Click()
   
   Ok = False
   Me.Hide

End Sub

Private Sub cmdOk_Click()
   
   If Len(txtCantidadReservada.Text) = 0 Or Not IsNumeric(txtCantidadReservada.Text) Then
      MsgBox "Debe ingresar una cantidad!", vbCritical
   Else
      Ok = True
      Me.Hide
   End If

End Sub

Public Property Let Items(ByVal vnewvalue As String)

   mvarItems = vnewvalue

End Property

Private Sub Form_Load()

   txtItems.Text = mvarItems
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub txtCantidadReservada_GotFocus()

   With txtCantidadReservada
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidadReservada_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

