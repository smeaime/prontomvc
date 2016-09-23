VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmProvincias 
   Caption         =   "Provincias"
   ClientHeight    =   5490
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   12465
   Icon            =   "frmProvincias.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5490
   ScaleWidth      =   12465
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "La empresa es agente de retencion IIBB en esta jurisdiccion :"
      Height          =   240
      Left            =   6255
      TabIndex        =   38
      Top             =   180
      Width           =   5280
   End
   Begin VB.TextBox txtCodigo 
      Alignment       =   2  'Center
      DataField       =   "Codigo"
      Height          =   285
      Left            =   10980
      TabIndex        =   36
      Top             =   585
      Width           =   585
   End
   Begin VB.TextBox txtPlantillaRetencionIIBB 
      DataField       =   "PlantillaRetencionIIBB"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3510
      TabIndex        =   7
      Top             =   2970
      Width           =   2625
   End
   Begin VB.TextBox txtInformacionAuxiliar 
      DataField       =   "InformacionAuxiliar"
      Height          =   285
      Left            =   8280
      TabIndex        =   2
      Top             =   585
      Width           =   1575
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Exportar retenciones con apertura por categoria :"
      Height          =   240
      Left            =   135
      TabIndex        =   6
      Top             =   2610
      Width           =   3975
   End
   Begin VB.TextBox txtTipoRegistroPercepcion 
      Alignment       =   1  'Right Justify
      DataField       =   "TipoRegistroPercepcion"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   11880
      TabIndex        =   13
      Top             =   3690
      Width           =   420
   End
   Begin VB.TextBox txtProximoNumeroCertificadoPercepcionIIBB 
      Alignment       =   1  'Right Justify
      DataField       =   "ProximoNumeroCertificadoPercepcionIIBB"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   11115
      TabIndex        =   10
      Top             =   2970
      Width           =   1185
   End
   Begin VB.TextBox txtTipoRegistro 
      Alignment       =   1  'Right Justify
      DataField       =   "TipoRegistro"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   5715
      TabIndex        =   5
      Top             =   2205
      Width           =   420
   End
   Begin VB.TextBox txtProximoNumeroCertificadoRetencionIIBB 
      Alignment       =   1  'Right Justify
      DataField       =   "ProximoNumeroCertificadoRetencionIIBB"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   4950
      TabIndex        =   3
      Top             =   1440
      Width           =   1185
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Nombre"
      Height          =   285
      Left            =   2175
      TabIndex        =   0
      Top             =   180
      Width           =   3915
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   1875
      TabIndex        =   16
      Top             =   4950
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   3585
      TabIndex        =   17
      Top             =   4950
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   165
      TabIndex        =   15
      Top             =   4950
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdPais"
      Height          =   315
      Index           =   0
      Left            =   2175
      TabIndex        =   1
      Tag             =   "Paises"
      Top             =   585
      Width           =   3960
      _ExtentX        =   6985
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPais"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaRetencionIBrutos"
      Height          =   315
      Index           =   1
      Left            =   2430
      TabIndex        =   4
      Tag             =   "Cuentas"
      Top             =   1800
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaPercepcionIBrutos"
      Height          =   315
      Index           =   2
      Left            =   90
      TabIndex        =   11
      Tag             =   "Cuentas"
      Top             =   3735
      Width           =   6090
      _ExtentX        =   10742
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaRetencionIBrutosCobranzas"
      Height          =   315
      Index           =   3
      Left            =   8955
      TabIndex        =   8
      Tag             =   "Cuentas"
      Top             =   1395
      Width           =   3345
      _ExtentX        =   5900
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaPercepcionIIBBConvenio"
      Height          =   315
      Index           =   4
      Left            =   90
      TabIndex        =   12
      Tag             =   "Cuentas"
      Top             =   4410
      Width           =   6090
      _ExtentX        =   10742
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaPercepcionIIBBCompras"
      Height          =   315
      Index           =   5
      Left            =   8955
      TabIndex        =   9
      Tag             =   "Cuentas"
      Top             =   2160
      Width           =   3345
      _ExtentX        =   5900
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaSIRCREB"
      Height          =   315
      Index           =   6
      Left            =   6300
      TabIndex        =   14
      Tag             =   "Cuentas"
      Top             =   4410
      Width           =   6000
      _ExtentX        =   10583
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   4
      X1              =   90
      X2              =   12330
      Y1              =   3420
      Y2              =   3420
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo :"
      Height          =   225
      Index           =   0
      Left            =   10215
      TabIndex        =   37
      Top             =   630
      Width           =   690
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta SIRCREB :"
      Height          =   195
      Index           =   8
      Left            =   6345
      TabIndex        =   35
      Top             =   4185
      Width           =   1410
   End
   Begin VB.Label Label4 
      Caption         =   "Plantilla para emision de certificado (opcional) :"
      Height          =   255
      Left            =   135
      TabIndex        =   34
      Top             =   2970
      Width           =   3300
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   3
      X1              =   6255
      X2              =   12330
      Y1              =   1845
      Y2              =   1845
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta percepcion IIBB  (compras) :"
      Height          =   240
      Index           =   7
      Left            =   6300
      TabIndex        =   33
      Top             =   2205
      Width           =   2580
   End
   Begin VB.Label lblLabels 
      Caption         =   "Datos para percepcion IIBB (compras) :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   6
      Left            =   6300
      TabIndex        =   32
      Top             =   1890
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo de jurisdiccion :"
      Height          =   255
      Index           =   3
      Left            =   6255
      TabIndex        =   31
      Top             =   600
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Datos para percepcion IIBB (ventas) :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   5
      Left            =   6300
      TabIndex        =   30
      Top             =   2655
      Width           =   3345
   End
   Begin VB.Label lblLabels 
      Caption         =   "Datos para retencion IIBB (cobranzas) :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   4
      Left            =   6300
      TabIndex        =   29
      Top             =   1125
      Width           =   3480
   End
   Begin VB.Label lblLabels 
      Caption         =   "Datos para retencion IIBB (pagos) :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   3
      Left            =   135
      TabIndex        =   28
      Top             =   1125
      Width           =   3165
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta percepcion IIBB (ventas) - (Convenio multilateral) :"
      Height          =   195
      Index           =   2
      Left            =   135
      TabIndex        =   27
      Top             =   4185
      Width           =   4155
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta retencion IIBB (cobranzas) :"
      Height          =   240
      Index           =   1
      Left            =   6300
      TabIndex        =   26
      Top             =   1440
      Width           =   2580
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   2
      X1              =   6210
      X2              =   6210
      Y1              =   3375
      Y2              =   1035
   End
   Begin VB.Label Label3 
      Caption         =   "Tipo de diseño de registro para presentacion del IIBB (opcional) :"
      Height          =   255
      Left            =   6300
      TabIndex        =   25
      Top             =   3735
      Width           =   5505
   End
   Begin VB.Label Label2 
      Caption         =   "Proximo certificado de percepcion de Ingresos Brutos :"
      Height          =   255
      Left            =   6300
      TabIndex        =   24
      Top             =   2970
      Width           =   4740
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta percepcion IIBB (ventas) :"
      Height          =   195
      Index           =   0
      Left            =   135
      TabIndex        =   23
      Top             =   3510
      Width           =   2490
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   1
      X1              =   90
      X2              =   12330
      Y1              =   1035
      Y2              =   1035
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   0
      X1              =   6255
      X2              =   12330
      Y1              =   2610
      Y2              =   2610
   End
   Begin VB.Label Label1 
      Caption         =   "Tipo de diseño de registro para presentacion del IIBB (opcional) :"
      Height          =   255
      Left            =   135
      TabIndex        =   22
      Top             =   2250
      Width           =   5505
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta retencion IIBB (pagos) :"
      Height          =   240
      Index           =   10
      Left            =   135
      TabIndex        =   21
      Top             =   1845
      Width           =   2220
   End
   Begin VB.Label Label88 
      Caption         =   "Proximo certificado de retencion de Ingresos Brutos :"
      Height          =   255
      Left            =   135
      TabIndex        =   20
      Top             =   1440
      Width           =   4740
   End
   Begin VB.Label lblData 
      Caption         =   "Pais :"
      Height          =   255
      Index           =   2
      Left            =   135
      TabIndex        =   19
      Top             =   630
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Nombre : "
      Height          =   255
      Index           =   1
      Left            =   135
      TabIndex        =   18
      Top             =   165
      Width           =   1815
   End
End
Attribute VB_Name = "frmProvincias"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Provincia
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
   
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe indicar el pais", vbExclamation
            Exit Sub
         End If
         
         If Len(txtDescripcion.Text) = 0 Then
            MsgBox "No ingreso el nombre de la provincia", vbExclamation
            Exit Sub
         End If
         
         Dim est As EnumAcciones
         Dim oControl As Control
   
         With origen.Registro
            For Each oControl In Me.Controls
               If TypeOf oControl Is DataCombo Then
                  If Len(oControl.BoundText) <> 0 And IsNumeric(oControl.BoundText) Then
                     .Fields(oControl.DataField).Value = oControl.BoundText
                  End If
               ElseIf TypeOf oControl Is DTPicker Then
                  .Fields(oControl.DataField).Value = oControl.Value
               End If
            Next
            If Check1.Value = 1 Then
               .Fields("ExportarConApertura").Value = "SI"
            Else
               .Fields("ExportarConApertura").Value = "NO"
            End If
            .Fields("EnviarEmail").Value = 1
            If Check2.Value = 1 Then
               .Fields("EsAgenteRetencionIIBB").Value = "SI"
            Else
               .Fields("EsAgenteRetencionIIBB").Value = "NO"
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
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("ALTA", mvarId, 0, Now, 0, "Tabla : Provincias", GetCompName(), glbNombreUsuario)
         Else
            est = Modificacion
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("MODIF", mvarId, 0, Now, 0, "Tabla : Provincias", GetCompName(), glbNombreUsuario)
         End If
            
         With actL2
            .ListaEditada = "Provincias"
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
         Aplicacion.Tarea "Log_InsertarRegistro", _
               Array("ELIM", mvarId, 0, Now, 0, "Tabla : Provincias", GetCompName(), glbNombreUsuario)
            
         With actL2
            .ListaEditada = "Provincias"
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
   Dim oRs As ADOR.Recordset
   Dim oControl As Control
   
   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oAp.Provincias.Item(vNewValue)
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
      With origen.Registro
         .Fields("ProximoNumeroCertificadoRetencionIIBB").Value = 1
      End With
   Else
      With origen.Registro
         If IsNull(.Fields("ProximoNumeroCertificadoRetencionIIBB").Value) Then
            .Fields("ProximoNumeroCertificadoRetencionIIBB").Value = 1
         End If
         If Not IsNull(.Fields("ExportarConApertura").Value) And .Fields("ExportarConApertura").Value = "SI" Then
            Check1.Value = 1
         End If
         If Not IsNull(.Fields("EsAgenteRetencionIIBB").Value) And .Fields("EsAgenteRetencionIIBB").Value = "SI" Then
            Check2.Value = 1
         End If
      End With
   End If
   
   Set oRs = oAp.Parametros.Item(1).Registro
   If IsNull(oRs.Fields("AgenteRetencionIIBB").Value) Or _
         oRs.Fields("AgenteRetencionIIBB").Value = "NO" Then
      txtProximoNumeroCertificadoRetencionIIBB.Enabled = False
      DataCombo1(1).Enabled = False
   End If
   If IsNull(oRs.Fields("PercepcionIIBB").Value) Or _
         oRs.Fields("PercepcionIIBB").Value = "NO" Then
      DataCombo1(2).Enabled = False
   End If
   oRs.Close
   
   cmd(1).Enabled = False
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      If mvarId > 0 Then cmd(1).Enabled = True
   End If
   
   Set oRs = Nothing
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

Private Sub txtDescripcion_Validate(Cancel As Boolean)

   If mvarId < 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Provincias.TraerFiltrado("_PorNombre", txtDescripcion.Text)
      If oRs.RecordCount > 0 Then
         MsgBox "Provincia ya ingresada. Reingrese.", vbCritical
         Cancel = True
      End If
      oRs.Close
      Set oRs = Nothing
   End If

End Sub

Private Sub txtInformacionAuxiliar_GotFocus()

   With txtInformacionAuxiliar
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtInformacionAuxiliar_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtInformacionAuxiliar
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtPlantillaRetencionIIBB_GotFocus()

   With txtPlantillaRetencionIIBB
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPlantillaRetencionIIBB_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtPlantillaRetencionIIBB
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
