VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmImpuestosDirectos 
   Caption         =   "Otros impuestos directos"
   ClientHeight    =   3570
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6735
   Icon            =   "frmImpuestosDirectos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3570
   ScaleWidth      =   6735
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtCodigo 
      Alignment       =   2  'Center
      DataField       =   "Codigo"
      Height          =   285
      Left            =   2070
      TabIndex        =   2
      Top             =   990
      Width           =   945
   End
   Begin VB.Frame Frame1 
      Caption         =   "Numeracion por grupo : "
      Height          =   780
      Left            =   4275
      TabIndex        =   16
      Top             =   2115
      Width           =   2175
      Begin VB.TextBox txtGrupo 
         Alignment       =   2  'Center
         DataField       =   "Grupo"
         Enabled         =   0   'False
         Height          =   240
         Left            =   1080
         TabIndex        =   20
         Top             =   495
         Width           =   720
      End
      Begin VB.OptionButton Option2 
         Caption         =   "NO"
         Height          =   195
         Left            =   180
         TabIndex        =   18
         Top             =   540
         Width           =   555
      End
      Begin VB.OptionButton Option1 
         Caption         =   "SI"
         Height          =   195
         Left            =   180
         TabIndex        =   17
         Top             =   270
         Width           =   465
      End
      Begin VB.Label lblFieldLabel 
         Caption         =   "Codigo de grupo:"
         Height          =   195
         Index           =   5
         Left            =   810
         TabIndex        =   19
         Top             =   270
         Width           =   1245
      End
   End
   Begin VB.TextBox txtProximoNumeroCertificado 
      Alignment       =   1  'Right Justify
      DataField       =   "ProximoNumeroCertificado"
      Height          =   285
      Left            =   2790
      TabIndex        =   6
      Top             =   2520
      Visible         =   0   'False
      Width           =   1080
   End
   Begin VB.TextBox txtBaseMinima 
      Alignment       =   1  'Right Justify
      DataField       =   "BaseMinima"
      Height          =   285
      Left            =   2070
      TabIndex        =   5
      Top             =   2115
      Width           =   1260
   End
   Begin VB.TextBox txtTasa 
      Alignment       =   1  'Right Justify
      DataField       =   "Tasa"
      Height          =   285
      Left            =   2070
      TabIndex        =   3
      Top             =   1350
      Width           =   945
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   285
      Left            =   2070
      TabIndex        =   0
      Top             =   225
      Width           =   4365
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   345
      Index           =   1
      Left            =   2880
      TabIndex        =   8
      Top             =   3105
      Width           =   1215
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   345
      Index           =   2
      Left            =   4185
      TabIndex        =   9
      Top             =   3105
      Width           =   1215
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   345
      Index           =   0
      Left            =   1575
      TabIndex        =   7
      Top             =   3105
      Width           =   1215
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdTipoImpuesto"
      Height          =   315
      Index           =   0
      Left            =   2070
      TabIndex        =   1
      Tag             =   "TiposImpuesto"
      Top             =   585
      Width           =   4365
      _ExtentX        =   7699
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoImpuesto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   1
      Left            =   2070
      TabIndex        =   4
      Tag             =   "Cuentas"
      Top             =   1710
      Width           =   4365
      _ExtentX        =   7699
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo :"
      Height          =   240
      Index           =   6
      Left            =   270
      TabIndex        =   21
      Top             =   990
      Width           =   1695
   End
   Begin VB.Label lblNumerador 
      Caption         =   "Proximo numero de certificado :"
      Height          =   255
      Left            =   270
      TabIndex        =   15
      Top             =   2535
      Visible         =   0   'False
      Width           =   2310
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Base minima p/aplicar :"
      Height          =   240
      Index           =   4
      Left            =   270
      TabIndex        =   14
      Top             =   2160
      Width           =   1695
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuenta contable :"
      Height          =   240
      Index           =   3
      Left            =   270
      TabIndex        =   13
      Top             =   1755
      Width           =   1695
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Tasa :"
      Height          =   240
      Index           =   2
      Left            =   270
      TabIndex        =   12
      Top             =   1395
      Width           =   1695
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripcion :"
      Height          =   240
      Index           =   1
      Left            =   270
      TabIndex        =   11
      Top             =   225
      Width           =   1695
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Tipo impuesto :"
      Height          =   240
      Index           =   0
      Left            =   270
      TabIndex        =   10
      Top             =   630
      Width           =   1695
   End
End
Attribute VB_Name = "frmImpuestosDirectos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.ImpuestoDirecto
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
   
         If Len(txtDescripcion.Text) = 0 Then
            MsgBox "No ingreso la descripcion", vbExclamation
            Exit Sub
         End If
         
         If txtGrupo.Enabled And Len(txtGrupo.Text) = 0 Then
            MsgBox "No ingreso el grupo de numeracion de certificados", vbExclamation
            Exit Sub
         End If
         
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
               .Fields("ActivaNumeracionPorGrupo").Value = "SI"
            Else
               .Fields("ActivaNumeracionPorGrupo").Value = "NO"
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
            .ListaEditada = "ImpuestosDirectos"
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
            .ListaEditada = "ImpuestosDirectos"
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

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oControl As Control
   
   mvarId = vnewvalue
   
   If BuscarClaveINI("Numerar certificados de impuestos directos por categoria") = "SI" Then
      lblNumerador.Visible = True
      txtProximoNumeroCertificado.Visible = True
   End If
   
   Set oAp = Aplicacion
   Set origen = oAp.ImpuestosDirectos.Item(vnewvalue)
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
      Option2.Value = True
      With origen.Registro
         Set oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
         .Fields("Tasa").Value = oRs.Fields("PorcentajeRetencionSUSS").Value
         .Fields("IdCuenta").Value = oRs.Fields("IdCuentaRetencionSUSS").Value
         oRs.Close
      End With
   Else
      With origen.Registro
         If Not IsNull(.Fields("ActivaNumeracionPorGrupo").Value) And _
               .Fields("ActivaNumeracionPorGrupo").Value = "SI" Then
            Option1.Value = True
         Else
            Option2.Value = True
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
   Set oRs = Nothing

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

Private Sub Option1_Click()

   If Option1.Value Then
      txtGrupo.Enabled = True
   End If

End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      origen.Registro.Fields("Grupo").Value = Null
      txtGrupo.Enabled = False
   End If

End Sub

Private Sub txtBaseMinima_GotFocus()

   With txtBaseMinima
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBaseMinima_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCodigo_GotFocus()

   With txtCodigo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCodigo
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If
   
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

Private Sub txtProximoNumeroCertificado_GotFocus()

   With txtProximoNumeroCertificado
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximoNumeroCertificado_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtTasa_GotFocus()

   With txtTasa
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTasa_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub
