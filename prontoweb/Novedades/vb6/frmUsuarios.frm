VERSION 5.00
Begin VB.Form frmUsuarios 
   Caption         =   "Usuarios"
   ClientHeight    =   2280
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6750
   LinkTopic       =   "Form1"
   ScaleHeight     =   2280
   ScaleWidth      =   6750
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Usuario administrador :"
      Enabled         =   0   'False
      Height          =   285
      Left            =   270
      TabIndex        =   2
      Top             =   1125
      Width           =   2220
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   855
      TabIndex        =   3
      Top             =   1620
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   4275
      TabIndex        =   5
      Top             =   1620
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   2565
      TabIndex        =   4
      Top             =   1620
      Width           =   1485
   End
   Begin VB.TextBox txtNombre 
      DataField       =   "Nombre"
      Height          =   285
      Left            =   2310
      TabIndex        =   0
      Top             =   405
      Width           =   4140
   End
   Begin VB.TextBox txtUsuarioNT 
      DataField       =   "UsuarioNT"
      Height          =   285
      Left            =   2310
      TabIndex        =   1
      Top             =   750
      Width           =   4140
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Nombre : "
      Height          =   255
      Index           =   1
      Left            =   270
      TabIndex        =   7
      Top             =   420
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Usuario NT :"
      Height          =   255
      Index           =   2
      Left            =   270
      TabIndex        =   6
      Top             =   765
      Width           =   1815
   End
End
Attribute VB_Name = "frmUsuarios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComAesa.Usuario
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
   
         Dim est As EnumAcciones
         Dim oControl As Control
   
         For Each oControl In Me.Controls
            If TypeOf oControl Is DataCombo Then
               If Len(oControl.BoundText) <> 0 Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
               End If
            ElseIf TypeOf oControl Is DTPicker Then
               origen.Registro.Fields(oControl.DataField).Value = oControl.Value
            End If
         Next
      
         If glbAdministrador Then
            If Check1.Value = 1 Then
               origen.Registro.Fields("Administrador").Value = "SI"
            Else
               origen.Registro.Fields("Administrador").Value = "NO"
            End If
         End If
      
         Select Case origen.Guardar
            Case ComAesa.MisEstados.Correcto
            Case ComAesa.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComAesa.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComAesa.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "Usuarios"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
      Case 1
   
         origen.Eliminar
         
         est = baja
            
         With actL2
            .ListaEditada = "Usuarios"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
   End Select
   
   Unload Me

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oAp As ComAesa.Aplicacion
   Dim oControl As Control
   
   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oAp.Usuarios.Item(vNewValue)
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
   
   Set oAp = Nothing

   If mvarId < 0 Then
      origen.Registro.Fields("Administrador").Value = "NO"
      Check1.Value = 0
   Else
      If origen.Registro.Fields("Administrador").Value = "SI" Then
         Check1.Value = 1
      Else
         Check1.Value = 0
      End If
   End If
      
   If glbAdministrador Then
      Check1.Enabled = True
   End If

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Form_Load()

   If mvarId < 0 Then
      cmd(1).Enabled = False
   End If
   
End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   
End Sub

Private Sub txtNombre_GotFocus()

   With txtNombre
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}"
   Else
      With txtNombre
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtUsuarioNT_GotFocus()

   With txtUsuarioNT
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtUsuarioNT_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}"
   Else
      With txtUsuarioNT
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

