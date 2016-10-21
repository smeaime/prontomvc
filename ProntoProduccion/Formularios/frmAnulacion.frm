VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Begin VB.Form frmAnulacion 
   ClientHeight    =   2280
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6480
   Icon            =   "frmAnulacion.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2280
   ScaleWidth      =   6480
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "Modo anulacion de cheques :"
      Height          =   420
      Left            =   3240
      TabIndex        =   4
      Top             =   1800
      Visible         =   0   'False
      Width           =   3075
      Begin VB.OptionButton Option2 
         Caption         =   "Eliminacion"
         Height          =   195
         Left            =   1575
         TabIndex        =   6
         Top             =   180
         Width           =   1365
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Anulacion"
         Height          =   195
         Left            =   90
         TabIndex        =   5
         Top             =   180
         Width           =   1095
      End
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Left            =   1710
      TabIndex        =   3
      Top             =   1800
      Width           =   1485
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "&Aceptar"
      Height          =   405
      Left            =   135
      TabIndex        =   2
      Top             =   1800
      Width           =   1485
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   180
      TabIndex        =   1
      Top             =   90
      Width           =   6090
   End
   Begin RichTextLib.RichTextBox rchAnulacion 
      Height          =   1230
      Left            =   135
      TabIndex        =   0
      Top             =   495
      Width           =   6180
      _ExtentX        =   10901
      _ExtentY        =   2170
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmAnulacion.frx":076A
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
End
Attribute VB_Name = "frmAnulacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Ok As Boolean

Private Sub cmdCancel_Click()
   
   Ok = False
   Me.Hide

End Sub

Private Sub cmdOk_Click()
   
   If Len(Trim(rchAnulacion.Text)) = 0 Then
      MsgBox "Debe indicar el motivo de la anulacion", vbExclamation
      Exit Sub
   End If
   
   If Frame1.Visible Then
      If Not Option1.Value And Not Option2.Value Then
         MsgBox "Indique la forma de anular los cheques", vbExclamation
         Exit Sub
      End If
   End If
   
   Ok = True
   Me.Hide

End Sub

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   'Degradado Me
   
End Sub

