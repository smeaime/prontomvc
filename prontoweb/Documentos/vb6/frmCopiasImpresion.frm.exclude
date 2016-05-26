VERSION 5.00
Begin VB.Form frmCopiasImpresion 
   Caption         =   "Impresion"
   ClientHeight    =   2115
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5700
   Icon            =   "frmCopiasImpresion.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2115
   ScaleWidth      =   5700
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Height          =   195
      Left            =   135
      TabIndex        =   9
      Top             =   1260
      Visible         =   0   'False
      Width           =   3390
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   1080
      TabIndex        =   7
      Top             =   855
      Width           =   4515
   End
   Begin VB.Frame Frame1 
      Height          =   555
      Left            =   2565
      TabIndex        =   4
      Top             =   180
      Width           =   3030
      Begin VB.OptionButton Option1 
         Caption         =   "Legal"
         Height          =   195
         Left            =   135
         TabIndex        =   6
         Top             =   225
         Width           =   1320
      End
      Begin VB.OptionButton Option2 
         Caption         =   "A4"
         Height          =   195
         Left            =   1530
         TabIndex        =   5
         Top             =   225
         Width           =   1410
      End
   End
   Begin VB.TextBox txtCopias 
      Alignment       =   1  'Right Justify
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   1755
      TabIndex        =   0
      Top             =   315
      Width           =   585
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "Aceptar"
      Height          =   360
      Left            =   1395
      TabIndex        =   1
      Tag             =   "Aceptar"
      Top             =   1575
      Width           =   1140
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancelar"
      Height          =   360
      Left            =   3105
      TabIndex        =   2
      Tag             =   "Cancelar"
      Top             =   1575
      Width           =   1140
   End
   Begin VB.Label lblImpresora 
      AutoSize        =   -1  'True
      Caption         =   "Impresora : "
      Height          =   240
      Left            =   135
      TabIndex        =   8
      Top             =   900
      Width           =   870
   End
   Begin VB.Label lblCopias 
      AutoSize        =   -1  'True
      Caption         =   "Cantidad de copias : "
      Height          =   285
      Left            =   135
      TabIndex        =   3
      Top             =   330
      Width           =   1545
   End
End
Attribute VB_Name = "frmCopiasImpresion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Ok As Boolean
Public Formulario As String

Private Sub cmdCancel_Click()
   
   Ok = False
   Me.Hide

End Sub

Private Sub cmdOk_Click()
   
   Ok = True
   Me.Hide

End Sub

Private Sub Form_Load()

   Dim tPrinter As Printer
   Dim i As Integer
   i = 0
   For Each tPrinter In Printers
      Combo1.AddItem tPrinter.DeviceName & " on " & tPrinter.Port
      If tPrinter.DeviceName = Printer.DeviceName Then i = Combo1.ListCount
   Next
   Set tPrinter = Nothing
   Combo1.ListIndex = IIf(i = 0, 0, i - 1)
   
   txtCopias.Text = 1
'   If Me.Frame1.Visible Then
      Option2.Value = True
'   End If
   Formulario = "A4"
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      Formulario = "Legal"
   End If

End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      Formulario = "A4"
   End If

End Sub

Private Sub txtCopias_GotFocus()

   With txtCopias
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCopias_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
