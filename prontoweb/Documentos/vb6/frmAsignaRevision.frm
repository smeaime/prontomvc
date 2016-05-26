VERSION 5.00
Begin VB.Form frmAsignaRevision 
   Caption         =   "Asignacion de revisiones"
   ClientHeight    =   1275
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3915
   Icon            =   "frmAsignaRevision.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1275
   ScaleWidth      =   3915
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancelar"
      Height          =   360
      Left            =   1995
      TabIndex        =   2
      Tag             =   "Cancelar"
      Top             =   765
      Width           =   1140
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "Aceptar"
      Default         =   -1  'True
      Height          =   360
      Left            =   765
      TabIndex        =   1
      Tag             =   "Aceptar"
      Top             =   765
      Width           =   1140
   End
   Begin VB.TextBox txtRevision 
      Height          =   330
      IMEMode         =   3  'DISABLE
      Left            =   2280
      TabIndex        =   0
      Top             =   225
      Width           =   1500
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de revision : "
      Height          =   300
      Index           =   1
      Left            =   180
      TabIndex        =   3
      Tag             =   "&Contraseña:"
      Top             =   240
      Width           =   1980
   End
End
Attribute VB_Name = "frmAsignaRevision"
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
   
   If Len(Trim(txtRevision.Text)) = 0 Then
      MsgBox "Debe ingresar un numero de revision", vbExclamation
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

