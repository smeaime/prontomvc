VERSION 5.00
Begin VB.Form frmDetNotasCreditoOC 
   Caption         =   "Item de orden de compra afectado"
   ClientHeight    =   1335
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4200
   Icon            =   "frmDetNotasCreditoOC.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1335
   ScaleWidth      =   4200
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtValor 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   3060
      TabIndex        =   0
      Top             =   225
      Width           =   870
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1350
      TabIndex        =   2
      Top             =   675
      Width           =   1125
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   1
      Top             =   675
      Width           =   1125
   End
   Begin VB.Label lblLabels 
      Height          =   300
      Index           =   0
      Left            =   135
      TabIndex        =   3
      Top             =   240
      Width           =   2805
   End
End
Attribute VB_Name = "frmDetNotasCreditoOC"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Ok As Boolean

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then
      Ok = True
   End If

   Me.Hide
   
End Sub

Private Sub Form_Load()

   Ok = False
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub txtValor_GotFocus()

   With txtValor
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtValor_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
