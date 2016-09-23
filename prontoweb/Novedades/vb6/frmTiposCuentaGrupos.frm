VERSION 5.00
Begin VB.Form frmTiposCuentaGrupos 
   Caption         =   "Grupos de cuentas"
   ClientHeight    =   1920
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7500
   Icon            =   "frmTiposCuentaGrupos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1920
   ScaleWidth      =   7500
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Height          =   420
      Left            =   315
      TabIndex        =   5
      Top             =   675
      Width           =   6810
      Begin VB.OptionButton Option4 
         Caption         =   "TARJ.CREDITO"
         Height          =   150
         Left            =   3735
         TabIndex        =   10
         Top             =   180
         Width           =   1545
      End
      Begin VB.OptionButton Option3 
         Caption         =   "OTRAS CTAS."
         Height          =   150
         Left            =   5355
         TabIndex        =   9
         Top             =   180
         Width           =   1365
      End
      Begin VB.OptionButton Option2 
         Caption         =   "BANCOS"
         Height          =   150
         Left            =   2520
         TabIndex        =   7
         Top             =   180
         Width           =   1050
      End
      Begin VB.OptionButton Option1 
         Caption         =   "CAJA"
         Height          =   150
         Left            =   1530
         TabIndex        =   6
         Top             =   180
         Width           =   825
      End
      Begin VB.Label Label1 
         Caption         =   "Tipo de grupo :"
         Height          =   195
         Left            =   90
         TabIndex        =   8
         Top             =   135
         Width           =   1185
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1290
      TabIndex        =   1
      Top             =   1335
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   4710
      TabIndex        =   3
      Top             =   1335
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   3000
      TabIndex        =   2
      Top             =   1335
      Width           =   1485
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   285
      Left            =   2355
      TabIndex        =   0
      Top             =   225
      Width           =   4770
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripcion : "
      Height          =   240
      Index           =   1
      Left            =   315
      TabIndex        =   4
      Top             =   240
      Width           =   1935
   End
End
Attribute VB_Name = "frmTiposCuentaGrupos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.TipoCuentaGrupos
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long
Private mNivelAcceso As Integer, mOpcionesAcceso As String

Public Property Let NivelAcceso(ByVal mNivelA As EnumAccesos)
   
   mNivelAcceso = mNivelA
   
End Property

Public Property Get NivelAcceso() As EnumAccesos

   NivelAcceso = mNivelAcceso
   
End Property

Public Property Let OpcionesAcceso(ByVal mOpcionesA As String)
   
   mOpcionesAcceso = mOpcionesA
   
End Property

Public Property Get OpcionesAcceso() As String

   OpcionesAcceso = mOpcionesAcceso
   
End Property

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
      Case 0
         Dim est As EnumAcciones
         Dim oControl As Control
   
         With origen.Registro
            For Each oControl In Me.Controls
               If TypeOf oControl Is DataCombo Then
                  If Len(oControl.BoundText) <> 0 Then
                     .Fields(oControl.DataField).Value = oControl.BoundText
                  End If
               ElseIf TypeOf oControl Is DTPicker Then
                  .Fields(oControl.DataField).Value = oControl.Value
               End If
            Next
            If Option1.Value Then
               .Fields("EsCajaBanco").Value = "CA"
            ElseIf Option2.Value Then
               .Fields("EsCajaBanco").Value = "BA"
            ElseIf Option4.Value Then
               .Fields("EsCajaBanco").Value = "TC"
            Else
               .Fields("EsCajaBanco").Value = Null
            End If
         End With
         
         Select Case origen.Guardar
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "TiposCuentaGrupos"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
      Case 1
         Dim mBorra As Integer
         mBorra = MsgBox("Esta seguro de eliminar los datos definitivamente ?", vbYesNo, "Eliminar")
         If mBorra = vbNo Then
            Exit Sub
         End If
         
         origen.Eliminar
         
         est = baja
            
         With actL2
            .ListaEditada = "TiposCuentaGrupos"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   End Select
   
   Unload Me

   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case -2147217900
         mvarResp = MsgBox("No puede borrar este registro porque se esta" & vbCrLf & "utilizando en otros archivos. Desea ver detalles?", vbYesNo + vbCritical)
         If mvarResp = vbYes Then
            MsgBox "Detalle del error : " & vbCrLf & Err.Number & " -> " & Err.Description
         End If
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   
   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oAp.TiposCuentaGrupos.Item(vNewValue)
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
   
   If mvarId <= 0 Then
      Option3.Value = True
   Else
      With origen.Registro
         If Not IsNull(.Fields("EsCajaBanco").Value) Then
            If .Fields("EsCajaBanco").Value = "CA" Then
               Option1.Value = True
            ElseIf .Fields("EsCajaBanco").Value = "BA" Then
               Option2.Value = True
            ElseIf .Fields("EsCajaBanco").Value = "TC" Then
               Option4.Value = True
            Else
               Option3.Value = True
            End If
         Else
            Option3.Value = True
         End If
      End With
   End If
   
   cmd(1).Enabled = False
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      If mvarId > 0 Then cmd(1).Enabled = True
   End If
   
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Form_Load()

   If mvarId < 0 Then cmd(1).Enabled = False
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub txtDescripcion_GotFocus()

   With txtDescripcion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDescripcion
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

