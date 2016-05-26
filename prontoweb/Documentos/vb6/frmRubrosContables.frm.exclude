VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmRubrosContables 
   Caption         =   "Rubros contables"
   ClientHeight    =   3300
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5955
   Icon            =   "frmRubrosContables.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3300
   ScaleWidth      =   5955
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtCodigoCuenta 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   585
      TabIndex        =   13
      Top             =   2070
      Width           =   1050
   End
   Begin VB.Frame Frame1 
      Caption         =   "Tipo de rubro : "
      Height          =   645
      Left            =   315
      TabIndex        =   7
      Top             =   1080
      Width           =   2130
      Begin VB.OptionButton Option2 
         Caption         =   "Egreso"
         Height          =   195
         Left            =   1170
         TabIndex        =   9
         Top             =   270
         Width           =   825
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Ingreso"
         Height          =   195
         Left            =   90
         TabIndex        =   8
         Top             =   270
         Width           =   870
      End
   End
   Begin VB.TextBox txtCodigo 
      DataField       =   "Codigo"
      Height          =   285
      Left            =   2400
      TabIndex        =   0
      Top             =   270
      Width           =   945
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   285
      Left            =   2400
      TabIndex        =   1
      Top             =   675
      Width           =   3150
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   2235
      TabIndex        =   3
      Top             =   2685
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   3945
      TabIndex        =   4
      Top             =   2685
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   525
      TabIndex        =   2
      Top             =   2685
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   0
      Left            =   2565
      TabIndex        =   10
      Tag             =   "Obras"
      Top             =   1395
      Width           =   3030
      _ExtentX        =   5345
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   1
      Left            =   1710
      TabIndex        =   14
      Tag             =   "Cuentas"
      Top             =   2070
      Width           =   3855
      _ExtentX        =   6800
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin VB.CheckBox Check1 
      Height          =   285
      Left            =   315
      TabIndex        =   12
      Top             =   2070
      Width           =   195
   End
   Begin VB.Label lblData 
      Caption         =   "Cuenta contable (opcional) :"
      Height          =   195
      Index           =   1
      Left            =   315
      TabIndex        =   15
      Top             =   1845
      Width           =   1995
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Obra :"
      Height          =   240
      Index           =   0
      Left            =   2610
      TabIndex        =   11
      Top             =   1095
      Width           =   540
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo :"
      Height          =   255
      Index           =   0
      Left            =   360
      TabIndex        =   6
      Top             =   285
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripcion :"
      Height          =   255
      Index           =   1
      Left            =   360
      TabIndex        =   5
      Top             =   690
      Width           =   1815
   End
End
Attribute VB_Name = "frmRubrosContables"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.RubroContable
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long
Private mTipo As Integer
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

Private Sub Check1_Click()

   If Check1.Value = 1 Then
      txtCodigoCuenta.Enabled = True
      DataCombo1(1).Enabled = True
   Else
      origen.Registro.Fields("IdCuenta").Value = Null
      txtCodigoCuenta.Text = ""
      txtCodigoCuenta.Enabled = False
      DataCombo1(1).Enabled = False
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
   
         Dim est As EnumAcciones
         Dim oControl As Control
   
         With origen.Registro
            For Each oControl In Me.Controls
               If TypeOf oControl Is DataCombo And _
                     oControl.Visible And oControl.Enabled Then
                  If Len(oControl.BoundText) <> 0 Then
                     origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
                  Else
                     MsgBox "Falta completar el campo " & lblData(oControl.Index), vbCritical
                     Exit Sub
                  End If
               ElseIf TypeOf oControl Is DTPicker Then
                  .Fields(oControl.DataField).Value = oControl.Value
               End If
            Next
            If Me.Tipo = 1 Then
               .Fields("Financiero").Value = "NO"
               .Fields("IngresoEgreso").Value = Null
               .Fields("IdObra").Value = Null
            Else
               If Option1.Value Then
                  .Fields("IngresoEgreso").Value = "I"
               Else
                  .Fields("IngresoEgreso").Value = "E"
               End If
               .Fields("Financiero").Value = "SI"
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
            .ListaEditada = "RubrosContablesGastosPorObra,RubrosContablesFinancieros"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
      Case 1
   
         origen.Eliminar
         
         est = baja
            
         With actL2
            .ListaEditada = "RubrosContablesGastosPorObra,RubrosContablesFinancieros"
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
   
   Set oAp = Aplicacion
   Set origen = oAp.RubrosContables.Item(vnewvalue)
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
   
   If Me.Tipo = 1 Then
      lblData(0).Visible = False
      DataCombo1(0).Visible = False
      lblData(1).Visible = False
      Check1.Visible = False
      txtCodigoCuenta.Visible = False
      DataCombo1(1).Visible = False
      Frame1.Visible = False
      cmd(0).Top = txtDescripcion.Top + txtDescripcion.Height + 200
      cmd(1).Top = cmd(0).Top
      cmd(2).Top = cmd(0).Top
      Me.Height = Me.Height * 0.6
   Else
      With origen.Registro
         If IsNull(.Fields("IngresoEgreso").Value) Or _
               .Fields("IngresoEgreso").Value = "E" Then
            Option2.Value = True
         Else
            Option1.Value = True
         End If
         If Not IsNull(.Fields("IdCuenta").Value) Then
            DataCombo1(1).Enabled = True
            txtCodigoCuenta.Enabled = True
            Check1.Value = 1
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorIdConDatos", .Fields("IdCuenta").Value)
            If oRs.RecordCount > 0 Then
               txtCodigoCuenta.Text = oRs.Fields("Codigo").Value
            End If
            oRs.Close
         Else
            txtCodigoCuenta.Text = ""
            txtCodigoCuenta.Enabled = False
            DataCombo1(1).Enabled = False
            Check1.Value = 0
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
   
   Set oRs = Nothing
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub DataCombo1_Change(Index As Integer)

   If Index = 1 Then
      If IsNumeric(DataCombo1(Index).BoundText) And _
            DataCombo1(Index).Text <> DataCombo1(Index).BoundText Then
         Dim oRs As ADOR.Recordset
         Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorIdConDatos", DataCombo1(Index).BoundText)
         If oRs.RecordCount > 0 Then
            txtCodigoCuenta.Text = oRs.Fields("Codigo").Value
         End If
         oRs.Close
         Set oRs = Nothing
      End If
   End If

End Sub

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

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoCuenta_Change()

   If IsNumeric(txtCodigoCuenta.Text) Then
      On Error GoTo SalidaConError
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("Cod", txtCodigoCuenta.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdCuenta").Value = oRs.Fields(0).Value
      Else
         origen.Registro.Fields("IdCuenta").Value = Null
      End If
      oRs.Close
      Set oRs = Nothing
      Exit Sub
SalidaConError:
      Set oRs = Nothing
      origen.Registro.Fields(DataCombo1(0).DataField).Value = Null
   End If

End Sub

Private Sub txtCodigoCuenta_GotFocus()

   With txtCodigoCuenta
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoCuenta_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

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

Public Property Get Tipo() As Integer

   Tipo = mTipo

End Property

Public Property Let Tipo(ByVal vnewvalue As Integer)

   mTipo = vnewvalue

End Property
