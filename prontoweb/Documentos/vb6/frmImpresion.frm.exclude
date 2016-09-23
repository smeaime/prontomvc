VERSION 5.00
Begin VB.Form frmImpresion 
   Caption         =   "Impresion"
   ClientHeight    =   2145
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6405
   Icon            =   "frmImpresion.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2145
   ScaleWidth      =   6405
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtHojas 
      Alignment       =   1  'Right Justify
      Height          =   255
      Left            =   1665
      TabIndex        =   10
      Top             =   630
      Width           =   270
   End
   Begin VB.Frame Frame1 
      Caption         =   "Distribucion : "
      Height          =   690
      Left            =   3465
      TabIndex        =   6
      Top             =   180
      Width           =   2805
      Begin VB.OptionButton Option2 
         Caption         =   "Vertical"
         Height          =   195
         Left            =   1575
         TabIndex        =   8
         Top             =   360
         Width           =   1140
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Horizontal"
         Height          =   195
         Left            =   90
         TabIndex        =   7
         Top             =   360
         Width           =   1320
      End
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   2160
      TabIndex        =   5
      Top             =   1035
      Width           =   4110
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancelar"
      Height          =   360
      Left            =   1410
      TabIndex        =   2
      Tag             =   "Cancelar"
      Top             =   1575
      Width           =   1140
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "Aceptar"
      Height          =   360
      Left            =   180
      TabIndex        =   1
      Tag             =   "Aceptar"
      Top             =   1575
      Width           =   1140
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
      Height          =   315
      Left            =   2160
      TabIndex        =   0
      Top             =   180
      Width           =   585
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "hojas de ancho"
      Height          =   240
      Left            =   2025
      TabIndex        =   11
      Top             =   630
      Width           =   1095
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Armar el listado con "
      Height          =   240
      Left            =   180
      TabIndex        =   9
      Top             =   630
      Width           =   1425
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Impresora : "
      Height          =   240
      Left            =   180
      TabIndex        =   4
      Top             =   1080
      Width           =   1905
   End
   Begin VB.Label lblCopias 
      AutoSize        =   -1  'True
      Caption         =   "Cantidad de copias : "
      Height          =   285
      Left            =   180
      TabIndex        =   3
      Top             =   195
      Width           =   1905
   End
End
Attribute VB_Name = "frmImpresion"
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
   Dim mImpresoraPredeterminada, i As Integer
   mImpresoraPredeterminada = 0
   i = 0
   For Each tPrinter In Printers
      Combo1.AddItem tPrinter.DeviceName & " on " & tPrinter.Port
      If tPrinter.DeviceName = Printer.DeviceName Then mImpresoraPredeterminada = i
      i = i + 1
   Next
   Set tPrinter = Nothing
   Combo1.ListIndex = mImpresoraPredeterminada
   
   txtCopias.Text = 1
   txtHojas.Text = 1
   
   Option1.Value = True
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
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

