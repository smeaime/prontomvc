VERSION 5.00
Begin VB.Form frmInicial 
   Caption         =   "Definir parametros iniciales del sistema"
   ClientHeight    =   2580
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6090
   Icon            =   "frmInicial.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2580
   ScaleWidth      =   6090
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtBD 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2700
      TabIndex        =   8
      Top             =   1485
      Width           =   3210
   End
   Begin VB.TextBox txtServidor 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2700
      TabIndex        =   6
      Top             =   1080
      Width           =   3210
   End
   Begin VB.TextBox txtPassword 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2700
      TabIndex        =   4
      Top             =   675
      Width           =   3210
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1890
      TabIndex        =   3
      Top             =   2025
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   2
      Top             =   2025
      Width           =   1485
   End
   Begin VB.TextBox txtUsuario 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2700
      TabIndex        =   0
      Top             =   270
      Width           =   3210
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nombre de la base de datos : "
      Height          =   300
      Index           =   2
      Left            =   180
      TabIndex        =   9
      Top             =   1515
      Width           =   2310
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nombre del servidor :"
      Height          =   300
      Index           =   1
      Left            =   180
      TabIndex        =   7
      Top             =   1110
      Width           =   2310
   End
   Begin VB.Label lblLabels 
      Caption         =   "Password :"
      Height          =   300
      Index           =   0
      Left            =   180
      TabIndex        =   5
      Top             =   705
      Width           =   2310
   End
   Begin VB.Label lblLabels 
      Caption         =   "Usuario base de datos :"
      Height          =   300
      Index           =   7
      Left            =   180
      TabIndex        =   1
      Top             =   300
      Width           =   2310
   End
End
Attribute VB_Name = "frmInicial"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Ok As Boolean

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then
   
      If Len(txtUsuario.Text) = 0 Then
         MsgBox "Debe ingresar un usuario de la base de datos!", vbExclamation
         Exit Sub
      End If
      
      If Len(txtServidor.Text) = 0 Then
         MsgBox "Debe ingresar el nombre del servidor!", vbExclamation
         Exit Sub
      End If
      
      Dim oAp As ComPronto.Aplicacion
      Dim MydsEncrypt As dsEncrypt
      Dim oRs As ADOR.Recordset
      Dim mConexion As String, mUsuarioSistema As String
      
      On Error GoTo Mal
      
      Set MydsEncrypt = New dsEncrypt
      MydsEncrypt.KeyString = ("EDS")
      
      mConexion = "Provider=SQLOLEDB.1;Persist Security Info=False" & _
                  ";User ID=" & txtUsuario.Text & _
                  ";Password=" & txtPassword.Text & _
                  ";Initial Catalog=" & txtBD.Text & _
                  ";Data Source=" & txtServidor.Text & _
                  ";Connect Timeout=45"
      mConexion = MydsEncrypt.Encrypt(mConexion)
      GuardarArchivoSecuencial GetWinDir & "\" & App.Title, mConexion

      Set oAp = CreateObject("ComPronto.Aplicacion")
      
      Dim oEmp As ComPronto.Empleado
      Dim mIdEmpleado As Long
      
      mUsuarioSistema = GetCurrentUserName()
      mUsuarioSistema = mId(mUsuarioSistema, 1, Len(mUsuarioSistema) - 1)
      Set oRs = oAp.Empleados.TraerFiltrado("_UsuarioNT", mUsuarioSistema)
      If oRs.RecordCount > 0 Then
         mIdEmpleado = oRs.Fields(0).Value
      Else
         mIdEmpleado = -1
      End If
      oRs.Close
      
      Set oEmp = oAp.Empleados.Item(mIdEmpleado)
      With oEmp
         If mIdEmpleado = -1 Then
            .Registro.Fields("Nombre").Value = "INSTALADOR"
            .Registro.Fields("UsuarioNT").Value = mUsuarioSistema
         End If
         .Registro.Fields("Administrador").Value = "SI"
         .Guardar
      End With
      
      Set oRs = Nothing
      Set oEmp = Nothing
      Set oPar = Nothing
      Set MydsEncrypt = Nothing
      Set oAp = Nothing
   
      Ok = True
      
   End If

Salida:

   Unload Me
   Exit Sub

Mal:

   Kill GetWinDir & "\" & App.Title
   MsgBox "No se puede establecer una conexion con la base de datos ..." & vbCrLf & _
         "revise los datos ingresados e intente nuevamente." & vbCrLf & _
         "Descripcion del error : " & vbCrLf & Err.Number & " " & Err.Description
   GoTo Salida

End Sub

Private Sub Form_Load()

   Ok = False

   txtUsuario.Text = "sa"
   txtPassword.Text = ""
   txtServidor.Text = GetCompName()
   txtBD.Text = App.Title

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

