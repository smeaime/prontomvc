VERSION 5.00
Begin VB.Form frmAsignaNumero 
   ClientHeight    =   1335
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4155
   Icon            =   "frmAsignaNumero.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1335
   ScaleWidth      =   4155
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtNumero 
      Alignment       =   1  'Right Justify
      Height          =   330
      IMEMode         =   3  'DISABLE
      Left            =   2910
      TabIndex        =   0
      Top             =   225
      Width           =   960
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "Aceptar"
      Default         =   -1  'True
      Height          =   360
      Left            =   855
      TabIndex        =   1
      Tag             =   "Aceptar"
      Top             =   765
      Width           =   1140
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancelar"
      Height          =   360
      Left            =   2085
      TabIndex        =   2
      Tag             =   "Cancelar"
      Top             =   765
      Width           =   1140
   End
   Begin VB.Label lblEti 
      Height          =   300
      Left            =   270
      TabIndex        =   3
      Tag             =   "&Contraseña:"
      Top             =   240
      Width           =   2565
   End
End
Attribute VB_Name = "frmAsignaNumero"
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
   
   If Len(Trim(txtNumero.Text)) = 0 Then
      MsgBox "Debe ingresar un numero", vbExclamation
      Exit Sub
   End If
   
   If Not IsNumeric(txtNumero.Text) Then
      MsgBox "Debe ingresar un numero", vbExclamation
      Exit Sub
   End If
   
   Ok = True
   Me.Hide

End Sub

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub


