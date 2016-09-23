VERSION 5.00
Begin VB.Form frmBusqueda 
   Caption         =   "Buscar"
   ClientHeight    =   1290
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8325
   Icon            =   "frmBusqueda.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1290
   ScaleWidth      =   8325
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox Combo2 
      Height          =   315
      Index           =   2
      ItemData        =   "frmBusqueda.frx":9C92
      Left            =   3510
      List            =   "frmBusqueda.frx":9CA5
      TabIndex        =   11
      Top             =   855
      Width           =   825
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Index           =   1
      ItemData        =   "frmBusqueda.frx":9CD0
      Left            =   3510
      List            =   "frmBusqueda.frx":9CE3
      TabIndex        =   10
      Top             =   495
      Width           =   825
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Index           =   0
      ItemData        =   "frmBusqueda.frx":9D0E
      Left            =   3510
      List            =   "frmBusqueda.frx":9D21
      TabIndex        =   9
      Top             =   135
      Width           =   825
   End
   Begin VB.TextBox txtControl 
      Height          =   285
      Left            =   7380
      TabIndex        =   8
      Top             =   810
      Visible         =   0   'False
      Width           =   825
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Index           =   1
      Left            =   4410
      TabIndex        =   2
      Top             =   495
      Width           =   2535
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Cancelar"
      Height          =   285
      Index           =   1
      Left            =   7155
      TabIndex        =   7
      Top             =   495
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Buscar"
      Height          =   285
      Index           =   0
      Left            =   7155
      TabIndex        =   1
      Top             =   135
      Width           =   1095
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Index           =   2
      Left            =   4410
      TabIndex        =   3
      Top             =   855
      Width           =   2535
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   2
      Left            =   180
      TabIndex        =   6
      Top             =   855
      Width           =   3255
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   1
      ItemData        =   "frmBusqueda.frx":9D4C
      Left            =   180
      List            =   "frmBusqueda.frx":9D4E
      TabIndex        =   5
      Top             =   495
      Width           =   3255
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Index           =   0
      Left            =   4410
      TabIndex        =   0
      Top             =   135
      Width           =   2535
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   0
      ItemData        =   "frmBusqueda.frx":9D50
      Left            =   180
      List            =   "frmBusqueda.frx":9D52
      TabIndex        =   4
      Top             =   135
      Width           =   3255
   End
End
Attribute VB_Name = "frmBusqueda"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mLista As DbListView

Private Sub Combo1_Click(Index As Integer)

   If mLista.TipoDatoColumna(Combo1(Index).ListIndex) <> "S" Then
      Combo2(Index).ListIndex = 0
   Else
      Combo2(Index).ListIndex = 1
   End If

End Sub

Private Sub Command1_Click(Index As Integer)

   txtControl.Text = Index
   Me.Hide
   
End Sub

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()
   
   Degradado Me
   
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   Set mLista = Nothing
   
End Sub

Private Sub Text1_KeyPress(Index As Integer, KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Set Lista(ByVal vnewvalue As DbListView)
   
   Set mLista = vnewvalue

End Property
