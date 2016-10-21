VERSION 5.00
Begin VB.Form frmAutorizacion 
   Caption         =   "Autorizaciones"
   ClientHeight    =   1425
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4530
   Icon            =   "frmAutorizacion.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1425
   ScaleWidth      =   4530
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "frmAutorizacion.frx":076A
      Left            =   1440
      List            =   "frmAutorizacion.frx":076C
      TabIndex        =   5
      Top             =   90
      Width           =   2985
   End
   Begin VB.TextBox txtPassword 
      Height          =   330
      IMEMode         =   3  'DISABLE
      Left            =   1425
      PasswordChar    =   "*"
      TabIndex        =   0
      Top             =   480
      Width           =   2985
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "Aceptar"
      Height          =   360
      Left            =   1080
      TabIndex        =   1
      Tag             =   "Aceptar"
      Top             =   975
      Width           =   1140
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancelar"
      Height          =   360
      Left            =   2310
      TabIndex        =   2
      Tag             =   "Cancelar"
      Top             =   975
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Usuari&o:"
      Height          =   300
      Index           =   0
      Left            =   225
      TabIndex        =   4
      Tag             =   "Usuari&o:"
      Top             =   105
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "&Contraseña:"
      Height          =   300
      Index           =   1
      Left            =   225
      TabIndex        =   3
      Tag             =   "&Contraseña:"
      Top             =   495
      Width           =   1080
   End
End
Attribute VB_Name = "frmAutorizacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private oRsAutoriza As ADOR.Recordset
Public Ok As Boolean
Private mvarFormulario As Integer, mvarOrden As Integer, mvarSectorRM As Integer
Private mvarIdAutorizo As Integer, mvarId As Integer, mvarIdObra As Integer
Private mvarIdFormulario As Integer
Private mvarImporte As Double
Private mvarAutorizo As String, mvarEmpleado As String, mvarSector As String
Private mvarIdEmpleados As String
Public mvarSupervisores As Boolean
Private mvarAdministradores As Boolean, mvarSuperAdministrador As Boolean
Private mvarActivarEmpleadosPorNombre As Boolean, mvarJefeCompras As Boolean

Private Sub cmdCancel_Click()
   
   Ok = False
   Me.Hide

End Sub

Private Sub cmdOk_Click()
   
   If mvarSuperAdministrador Then
   
      If UCase(txtPassword.Text) = "PRONTO" Then
         Ok = True
         Me.Hide
      Else
         MsgBox "La contraseña no es válida; vuelva a intentarlo", vbCritical
         txtPassword.SetFocus
         txtPassword.SelStart = 0
         txtPassword.SelLength = Len(txtPassword.Text)
      End If
   
   Else
   
      Dim mvarPass As String
      
      If Combo1.ListIndex < 0 Then
         MsgBox "No hay usuarios para firma", vbExclamation
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
      
   End If

End Sub

Public Property Let Id(ByVal vNewValue As Integer)

   mvarId = vNewValue

End Property

Public Property Let Empleado(ByVal vNewValue As String)

   mvarEmpleado = vNewValue

End Property

Public Property Let Formulario(ByVal vNewValue As Integer)

   mvarFormulario = vNewValue

End Property

Public Property Let Orden(ByVal vNewValue As Integer)

   mvarOrden = vNewValue

End Property

Private Sub Combo1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   Dim mIndex As Integer
   
   If IsEmpty(mvarAdministradores) Then
      mvarAdministradores = False
   End If
   
   If IsEmpty(mvarJefeCompras) Then
      mvarJefeCompras = False
   End If
   
   If IsEmpty(mvarSuperAdministrador) Then
      mvarSuperAdministrador = False
   End If

   If IsEmpty(mvarActivarEmpleadosPorNombre) Then
      mvarActivarEmpleadosPorNombre = False
   End If

   mIndex = 0
   
   If mvarSuperAdministrador Then
      lblLabels(0).Visible = False
      Combo1.Visible = False
      lblLabels(1).TOp = lblLabels(1).TOp - lblLabels(1).Height / 2
      txtPassword.TOp = txtPassword.TOp - txtPassword.Height / 2
   Else
      If mvarIdFormulario <> 0 Then
         Set oRsAutoriza = Aplicacion.Empleados.TraerFiltrado("_ParaAnularPorFormulario", mvarIdFormulario)
      ElseIf mvarSupervisores Then
        Set oRsAutoriza = TraerRsConEmpleadosConCargoDeSupervisor(Aplicacion)
      ElseIf mvarSector <> "" Then
         Set oRsAutoriza = Aplicacion.Empleados.TraerFiltrado("_PorSector", mvarSector)
      ElseIf mvarAdministradores Then
         If mvarJefeCompras Then
            Set oRsAutoriza = Aplicacion.Empleados.TraerFiltrado("_AdministradoresMasJefeCompras")
         Else
            Set oRsAutoriza = Aplicacion.Empleados.TraerFiltrado("_Administradores")
         End If
      ElseIf mvarActivarEmpleadosPorNombre Then
         Set oRsAutoriza = Aplicacion.Empleados.TraerFiltrado("_PorNombre", mvarEmpleado)
      ElseIf mvarIdEmpleados <> "" Then
         Set oRsAutoriza = Aplicacion.Empleados.TraerFiltrado("_PorEnumeracionIds", mvarIdEmpleados)
      Else
         Set oRsAutoriza = Aplicacion.Autorizaciones.TraerFiltrado("_PorFormulario", _
               Array(mvarFormulario, mvarOrden, mvarSectorRM, mvarIdObra, mvarImporte))
      End If
      
      With oRsAutoriza
         If .Fields.Count > 0 Then
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  If mvarSector <> "" Or mvarSupervisores Then
                     Combo1.AddItem .Fields("Titulo").Value
                     If .Fields("Titulo").Value = mvarEmpleado Then
                        mIndex = .AbsolutePosition - 1
                     End If
                  Else
                     If Not IsNull(.Fields("Nombre").Value) Then
                        Combo1.AddItem .Fields("Nombre").Value
                        If .Fields("Nombre").Value = mvarEmpleado Then
                           mIndex = .AbsolutePosition - 1
                        End If
                     End If
                  End If
                  .MoveNext
               Loop
               Combo1.ListIndex = mIndex
            End If
         End If
      End With
   End If
   
   mvarAutorizo = ""
   mvarIdAutorizo = 0
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   'Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   If Not oRsAutoriza Is Nothing Then
      With oRsAutoriza
         If .Fields.Count > 0 Then
            .Close
         End If
      End With
      Set oRsAutoriza = Nothing
   End If
   
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

Public Property Let Sector(ByVal vNewValue As String)

   mvarSector = vNewValue

End Property

Public Property Let SectorRM(ByVal vNewValue As Integer)

   mvarSectorRM = vNewValue

End Property

Public Property Let IdObra(ByVal vNewValue As Integer)

   mvarIdObra = vNewValue

End Property

Public Property Let Administradores(ByVal vNewValue As Boolean)

   mvarAdministradores = vNewValue

End Property

Public Property Let JefeCompras(ByVal vNewValue As Boolean)

   mvarJefeCompras = vNewValue

End Property

Public Property Let SuperAdministrador(ByVal vNewValue As Boolean)

   mvarSuperAdministrador = vNewValue

End Property

Public Property Let ActivarEmpleadosPorNombre(ByVal vNewValue As Boolean)

   mvarActivarEmpleadosPorNombre = vNewValue

End Property

Public Property Let Importe(ByVal vNewValue As Double)

   mvarImporte = vNewValue

End Property

Public Property Let IdFormulario(ByVal vNewValue As Integer)

   mvarIdFormulario = vNewValue

End Property

Public Property Let IdEmpleados(ByVal vNewValue As String)

   mvarIdEmpleados = vNewValue

End Property


