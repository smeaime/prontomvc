VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form frmAsignaFechaNecesidad 
   Caption         =   "Asigna una fecha de necesidad"
   ClientHeight    =   1275
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4005
   Icon            =   "frmAsignaFechaNecesidad.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1275
   ScaleWidth      =   4005
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdOK 
      Caption         =   "Aceptar"
      Default         =   -1  'True
      Height          =   360
      Left            =   765
      TabIndex        =   1
      Tag             =   "Aceptar"
      Top             =   720
      Width           =   1140
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancelar"
      Height          =   360
      Left            =   1995
      TabIndex        =   2
      Tag             =   "Cancelar"
      Top             =   720
      Width           =   1140
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   360
      Index           =   0
      Left            =   2250
      TabIndex        =   0
      Top             =   180
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   635
      _Version        =   393216
      Format          =   64421889
      CurrentDate     =   36377
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de necesidad :"
      Height          =   300
      Index           =   0
      Left            =   270
      TabIndex        =   3
      Top             =   225
      Width           =   1815
   End
End
Attribute VB_Name = "frmAsignaFechaNecesidad"
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
   
   Ok = True
   Me.Hide

End Sub

Private Sub Form_Load()

   DTFields(0).Value = Date
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub DTFields_GotFocus(Index As Integer)

   SendKeys "%{DOWN}"

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub


