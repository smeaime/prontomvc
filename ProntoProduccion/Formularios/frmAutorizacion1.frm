VERSION 5.00
Begin VB.Form frmAutorizacion1 
   Caption         =   "Control de autorizaciones"
   ClientHeight    =   1500
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4515
   Icon            =   "frmAutorizacion1.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1500
   ScaleWidth      =   4515
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtUsuario 
      Enabled         =   0   'False
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
      IMEMode         =   3  'DISABLE
      Left            =   1380
      TabIndex        =   5
      Top             =   135
      Width           =   2985
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancelar"
      Height          =   360
      Left            =   2265
      TabIndex        =   2
      Tag             =   "Cancelar"
      Top             =   1020
      Width           =   1140
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "Aceptar"
      Height          =   360
      Left            =   1035
      TabIndex        =   1
      Tag             =   "Aceptar"
      Top             =   1020
      Width           =   1140
   End
   Begin VB.TextBox txtPassword 
      Height          =   330
      IMEMode         =   3  'DISABLE
      Left            =   1380
      PasswordChar    =   "*"
      TabIndex        =   0
      Top             =   525
      Width           =   2985
   End
   Begin VB.Label lblLabels 
      Caption         =   "&Contrase�a:"
      Height          =   300
      Index           =   1
      Left            =   180
      TabIndex        =   4
      Tag             =   "&Contrase�a:"
      Top             =   540
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Usuari&o:"
      Height          =   300
      Index           =   0
      Left            =   180
      TabIndex        =   3
      Tag             =   "Usuari&o:"
      Top             =   150
      Width           =   1080
   End
End
Attribute VB_Name = "frmAutorizacion1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Ok As Boolean
Private mvarId As Integer

Private Sub cmdCancel_Click()
   
   Ok = False
   Me.Hide

End Sub

Private Sub cmdOk_Click()
   
   Dim mvarPass As String
   
   If Not IsNull(Aplicacion.Empleados.Item(mvarId).Registro.Fields("Password").Value) Then
      mvarPass = Aplicacion.Empleados.Item(mvarId).Registro.Fields("Password").Value
   Else
      mvarPass = ""
   End If
   
   If txtPassword.Text = mvarPass Then
      Ok = True
      Me.Hide
   Else
      MsgBox "La contrase�a no es v�lida; vuelva a intentarlo", vbCritical
      txtPassword.SetFocus
      txtPassword.SelStart = 0
      txtPassword.SelLength = Len(txtPassword.Text)
   End If

End Sub

Public Property Let IdUsuario(ByVal vnewvalue As Integer)

   mvarId = vnewvalue

End Property

Private Sub Form_Activate()

   Me.Refresh
   
End Sub

Private Sub Form_Load()

   txtUsuario.Text = Aplicacion.Empleados.Item(mvarId).Registro.Fields("Nombre").Value
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   'Degradado Me
   
End Sub

Private Sub txtPassword_GotFocus()

   With txtPassword
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPassword_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtUsuario_GotFocus()

   With txtUsuario
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtUsuario_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Get Password() As String

   Password = txtPassword.Text

End Property

