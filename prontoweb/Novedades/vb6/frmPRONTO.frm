VERSION 5.00
Begin VB.Form frmPRONTO 
   Caption         =   "PRONTO"
   ClientHeight    =   930
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3585
   LinkTopic       =   "Form1"
   ScaleHeight     =   930
   ScaleWidth      =   3585
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "PRONTO MANTENIMIENTO"
      Height          =   555
      Index           =   1
      Left            =   1935
      TabIndex        =   1
      Top             =   180
      Width           =   1545
   End
   Begin VB.CommandButton Command1 
      Caption         =   "PRONTO"
      Height          =   555
      Index           =   0
      Left            =   135
      TabIndex        =   0
      Top             =   180
      Width           =   1545
   End
End
Attribute VB_Name = "frmPRONTO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click(Index As Integer)

   Select Case Index
      Case 0
         Call ShellExecute(Me.hwnd, "open", App.Path & "\Pronto.exe", vbNullString, vbNullString, SW_SHOWNORMAL)
      Case 1
         Call ShellExecute(Me.hwnd, "open", App.Path & "\ProntoMantenimiento.exe", vbNullString, vbNullString, SW_SHOWNORMAL)
   End Select
   
   Unload Me

End Sub
