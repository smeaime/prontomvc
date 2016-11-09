VERSION 5.00
Begin VB.Form Splash 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   5  'Sizable ToolWindow
   ClientHeight    =   3300
   ClientLeft      =   1380
   ClientTop       =   2085
   ClientWidth     =   7500
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   Icon            =   "Splash.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3300
   ScaleWidth      =   7500
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   WhatsThisHelp   =   -1  'True
   Begin VB.Label lblProducción 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      Caption         =   "Producción"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   20.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   615
      Left            =   2520
      TabIndex        =   4
      Top             =   1800
      Width           =   3855
   End
   Begin VB.Label lblPronto 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      Caption         =   "Pronto"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   48
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   1215
      Left            =   2520
      TabIndex        =   3
      Top             =   720
      Width           =   3855
   End
   Begin VB.Image Image1 
      Height          =   1335
      Left            =   720
      Picture         =   "Splash.frx":076A
      Stretch         =   -1  'True
      Top             =   840
      Width           =   1530
   End
   Begin VB.Shape rctStatusBar 
      BackColor       =   &H00800000&
      BackStyle       =   1  'Opaque
      BorderStyle     =   0  'Transparent
      FillStyle       =   0  'Solid
      Height          =   345
      Left            =   495
      Top             =   2655
      Width           =   15
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "100%"
      ForeColor       =   &H80000008&
      Height          =   225
      Index           =   1
      Left            =   6435
      TabIndex        =   2
      Top             =   3060
      Width           =   465
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "0%"
      ForeColor       =   &H80000008&
      Height          =   225
      Index           =   0
      Left            =   405
      TabIndex        =   1
      Top             =   3105
      Width           =   345
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Cargando..."
      ForeColor       =   &H80000008&
      Height          =   240
      Left            =   3150
      TabIndex        =   0
      Top             =   3060
      Width           =   1215
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   1
      X1              =   6885
      X2              =   495
      Y1              =   3015
      Y2              =   3015
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00808080&
      BorderWidth     =   2
      Index           =   0
      X1              =   495
      X2              =   495
      Y1              =   2700
      Y2              =   3015
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00808080&
      BorderWidth     =   2
      Index           =   0
      X1              =   5160
      X2              =   495
      Y1              =   3015
      Y2              =   3015
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   1
      X1              =   6885
      X2              =   6885
      Y1              =   2610
      Y2              =   3000
   End
End
Attribute VB_Name = "Splash"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim iStatusBarWidth As Integer

Private Sub Form_Activate()

   Me.Refresh
   
End Sub

Private Sub Form_Click()
    
   Unload Me

End Sub

Private Sub Form_Load()

   On Error Resume Next
   Dim mLogo As String
   mLogo = "" & glbPathPlantillas & "\..\Imagenes\" & glbEmpresaSegunString & ".jpg"
   If False Then
    'esta tardando muchísimo en acceder al archivo (es porque va a buscar a la red?)
      If Len(Trim(Dir(mLogo))) <> 0 Then Me.Picture = LoadPicture(mLogo)
   End If
   'If Len(Trim(Dir(mLogo))) <> 0 Then Me.Image1 = LoadPicture(mLogo)
   
End Sub

Private Sub Image2_Click()

End Sub

