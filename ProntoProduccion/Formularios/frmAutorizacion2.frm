VERSION 5.00
Begin VB.Form frmAutorizacion2 
   ClientHeight    =   1455
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4425
   Icon            =   "frmAutorizacion2.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1455
   ScaleWidth      =   4425
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancelar"
      Height          =   360
      Left            =   2220
      TabIndex        =   2
      Tag             =   "Cancelar"
      Top             =   975
      Width           =   1140
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "Aceptar"
      Height          =   360
      Left            =   990
      TabIndex        =   1
      Tag             =   "Aceptar"
      Top             =   975
      Width           =   1140
   End
   Begin VB.TextBox txtPassword 
      Height          =   330
      IMEMode         =   3  'DISABLE
      Left            =   1335
      PasswordChar    =   "*"
      TabIndex        =   0
      Top             =   480
      Width           =   2985
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "frmAutorizacion2.frx":076A
      Left            =   1350
      List            =   "frmAutorizacion2.frx":076C
      TabIndex        =   3
      Top             =   90
      Width           =   2985
   End
   Begin VB.Label lblLabels 
      Caption         =   "&Contraseña:"
      Height          =   300
      Index           =   1
      Left            =   135
      TabIndex        =   5
      Tag             =   "&Contraseña:"
      Top             =   495
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Usuari&o:"
      Height          =   300
      Index           =   0
      Left            =   135
      TabIndex        =   4
      Tag             =   "Usuari&o:"
      Top             =   105
      Width           =   1080
   End
End
Attribute VB_Name = "frmAutorizacion2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private oRsAutoriza As ADOR.Recordset
Public Ok As Boolean, Cancelo As Boolean
Private mvarIdAutorizo As Integer, mvarId As Integer
Private mvarAutorizo As String, mvarSector As String

Private Sub cmdCancel_Click()
   
   Ok = False
   Cancelo = True
   Me.Hide

End Sub

Private Sub cmdOk_Click()
   
   Dim mvarPass As String
   
   If Combo1.ListIndex = -1 Then
      MsgBox "Debe ingresar correctamente el usuario que autoriza", vbExclamation
      Exit Sub
   End If
   
   oRsAutoriza.AbsolutePosition = Combo1.ListIndex + 1
   
   If Not IsNull(Aplicacion.Empleados.Item(oRsAutoriza.Fields("IdEmpleado").Value).Registro.Fields("Password").Value) Then
      mvarPass = Aplicacion.Empleados.Item(oRsAutoriza.Fields("IdEmpleado").Value).Registro.Fields("Password").Value
   Else
      mvarPass = ""
   End If
   
   If txtPassword.Text = mvarPass Then
      Ok = True
      Me.IdAutorizo = oRsAutoriza.Fields("IdEmpleado").Value
      Me.Autorizo = Combo1.Text
      Me.Hide
   Else
      MsgBox "La contraseña no es válida; vuelva a intentarlo", vbCritical
      txtPassword.SetFocus
      txtPassword.SelStart = 0
      txtPassword.SelLength = Len(txtPassword.Text)
   End If

End Sub

Public Property Let Sector(ByVal vNewValue As String)

   mvarSector = vNewValue

End Property

Private Sub Combo1_GotFocus()

   SendKeys "%{DOWN}"
   
End Sub

Private Sub Combo1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   Dim oAp As ComPronto.Aplicacion
   Dim mPos As Long
   
   Me.Caption = "Personal de " & mvarSector
   
   Cancelo = False
   
   Set oAp = Aplicacion
   If mvarSector <> "" Then
      Set oRsAutoriza = oAp.Empleados.TraerFiltrado("_PorSector", mvarSector)
   Else
      Set oRsAutoriza = oAp.Empleados.TraerLista
   End If
   
   mPos = 0
   
   With oRsAutoriza
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               Combo1.AddItem .Fields("Titulo").Value
               If .Fields(0).Value = glbIdUsuario Then
                  mPos = Combo1.ListCount - 1
               End If
               .MoveNext
            Loop
            Combo1.ListIndex = mPos
         End If
      End If
   End With
   
   Set oAp = Nothing
   
   mvarAutorizo = ""
   mvarIdAutorizo = 0
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   'Degradado Me
   
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   Cancelo = True
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   With oRsAutoriza
      If .Fields.Count > 0 Then
         .Close
      End If
   End With
   Set oRsAutoriza = Nothing
   
End Sub

Public Property Get Autorizo() As String

   Autorizo = mvarAutorizo
   
End Property

Public Property Let Autorizo(ByVal vNewValue As String)

   mvarAutorizo = vNewValue
   
End Property

Public Property Get IdAutorizo() As Integer

   IdAutorizo = mvarIdAutorizo
   
End Property

Public Property Let IdAutorizo(ByVal vNewValue As Integer)

   mvarIdAutorizo = vNewValue
   
End Property

Private Sub txtPassword_GotFocus()

   With txtPassword
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPassword_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
