VERSION 5.00
Begin VB.Form FrmFamilia 
   Caption         =   "Familias"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5250
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   5250
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   1830
      TabIndex        =   4
      Top             =   2400
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   3540
      TabIndex        =   3
      Top             =   2400
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   120
      TabIndex        =   2
      Top             =   2400
      Width           =   1485
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      DataMember      =   "Command1"
      DataSource      =   "DataEnvironment2"
      Height          =   285
      Left            =   1200
      MaxLength       =   50
      TabIndex        =   0
      Top             =   360
      Width           =   3735
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      Caption         =   "Descripcion:"
      Height          =   255
      Index           =   1
      Left            =   120
      TabIndex        =   1
      Top             =   360
      Width           =   975
   End
End
Attribute VB_Name = "FrmFamilia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents Origen As ComAesa.Familia
Attribute Origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long
Dim actL2 As ControlForm

Private Sub cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
   
         Dim oControl As Control
         Dim est As EnumAcciones
      
         For Each oControl In Me.Controls
            If TypeOf oControl Is DataCombo Then
               Origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
            ElseIf TypeOf oControl Is DTPicker Then
               Origen.Registro.Fields(oControl.DataField).Value = oControl.Value
            End If
         Next
      
         Select Case Origen.Guardar
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
            mvarId = Origen.Registro.Fields(0).Value
         Else
            est = Modificacion
         End If
            
         With actL2
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
      Case 1
   
         Origen.Eliminar
         
         est = Baja
            
         With actL2
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
   End Select
   
   Unload Me

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oap As ComAesa.Aplicacion
   
   mvarId = vNewValue
   
   Set oap = Aplicacion
   Set Origen = oap.Familias.Item(vNewValue)
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = Origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = Origen
            If Len(oControl.Tag) Then
               Set oControl.RowSource = oap.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
   
   End With
   
   Set oap = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   
End Sub

Private Sub txtDescripcion_LostFocus()
    If txtDescripcion.Text = "" Then
      If MsgBox("No puede dejar el campo como Nulo, Ingrese Algo.", vbInformation + vbOKOnly, "ERROR.!!!") = vbOK Then
        txtDescripcion.SetFocus
      End If
    End If
End Sub
