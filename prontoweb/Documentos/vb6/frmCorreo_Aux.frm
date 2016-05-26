VERSION 5.00
Object = "{F7D972E3-E925-4183-AB00-B6A253442139}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmCorreo_Aux 
   Caption         =   "Archivo adjunto para email"
   ClientHeight    =   1155
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8160
   Icon            =   "frmCorreo_Aux.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1155
   ScaleWidth      =   8160
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   1
      Top             =   675
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1755
      TabIndex        =   2
      Top             =   675
      Width           =   1485
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   1620
      TabIndex        =   0
      Top             =   180
      Width           =   6405
      _ExtentX        =   11298
      _ExtentY        =   582
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Archivo adjunto :"
      Height          =   255
      Index           =   0
      Left            =   90
      TabIndex        =   3
      Top             =   225
      Width           =   1455
   End
End
Attribute VB_Name = "frmCorreo_Aux"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Ok As Boolean

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         If Len(FileBrowser1(0).Text) = 0 Then
            MsgBox "Debe cargar un archivo adjunto valido", vbExclamation
            Exit Sub
         End If
         Ok = True
      Case 1
         Ok = False
   End Select
   
   Me.Hide

End Sub

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub
