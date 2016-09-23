VERSION 5.00
Begin VB.Form frmExportarDocumentos 
   Caption         =   "Exportar documentos"
   ClientHeight    =   1695
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6705
   Icon            =   "frmExportarDocumentos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1695
   ScaleWidth      =   6705
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text1 
      Height          =   330
      Left            =   5715
      TabIndex        =   8
      Text            =   "Text1"
      Top             =   1350
      Visible         =   0   'False
      Width           =   870
   End
   Begin VB.CheckBox Check3 
      Alignment       =   1  'Right Justify
      Height          =   240
      Left            =   3150
      TabIndex        =   6
      Top             =   1080
      Visible         =   0   'False
      Width           =   3435
   End
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Agrupar items x articulo :"
      Height          =   285
      Left            =   135
      TabIndex        =   5
      Top             =   720
      Visible         =   0   'False
      Width           =   2040
   End
   Begin VB.TextBox txtCarpeta 
      Height          =   330
      Left            =   1845
      TabIndex        =   0
      Top             =   225
      Width           =   4740
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancelar"
      Height          =   360
      Left            =   1395
      TabIndex        =   2
      Tag             =   "Cancelar"
      Top             =   1170
      Width           =   1140
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "Aceptar"
      Height          =   360
      Left            =   135
      TabIndex        =   1
      Tag             =   "Aceptar"
      Top             =   1170
      Width           =   1140
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Imprimir simultaneamente a la exportacion :"
      Height          =   285
      Left            =   3150
      TabIndex        =   4
      Top             =   720
      Width           =   3435
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   240
      Left            =   3150
      TabIndex        =   7
      Top             =   1395
      Visible         =   0   'False
      Width           =   2490
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Exportar a carpeta : "
      Height          =   345
      Index           =   0
      Left            =   135
      TabIndex        =   3
      Top             =   225
      Width           =   1590
   End
End
Attribute VB_Name = "frmExportarDocumentos"
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
   
'   If Len(Trim(txtCarpeta.Text)) = 0 Then
'      MsgBox "Debe indicar una carpeta!", vbExclamation
'      Exit Sub
'   End If
   
   Ok = True
   Me.Hide

End Sub

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

