VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmCuentasGastos 
   Caption         =   "Cuentas para obras"
   ClientHeight    =   2940
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6990
   Icon            =   "frmCuentasGastos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2940
   ScaleWidth      =   6990
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "Tipo de cuenta :"
      Height          =   420
      Left            =   3960
      TabIndex        =   13
      Top             =   45
      Width           =   1635
      Begin VB.TextBox txtNivel 
         Alignment       =   2  'Center
         DataField       =   "Nivel"
         Enabled         =   0   'False
         Height          =   240
         Left            =   2520
         TabIndex        =   16
         Top             =   180
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.CheckBox Check1 
         Alignment       =   1  'Right Justify
         Caption         =   "Cuenta titulo :"
         Height          =   195
         Left            =   90
         TabIndex        =   14
         Top             =   180
         Width           =   1320
      End
      Begin VB.Label Label1 
         Caption         =   "Nivel (1 o 2) :"
         Height          =   195
         Left            =   1485
         TabIndex        =   15
         Top             =   180
         Visible         =   0   'False
         Width           =   870
      End
   End
   Begin VB.TextBox txtCodigoDestino 
      Alignment       =   2  'Center
      DataField       =   "CodigoDestino"
      Height          =   285
      Left            =   2430
      TabIndex        =   4
      Top             =   1800
      Width           =   1350
   End
   Begin VB.TextBox txtCodigo 
      Alignment       =   2  'Center
      DataField       =   "Codigo"
      Height          =   285
      Left            =   2430
      TabIndex        =   0
      Top             =   135
      Width           =   1350
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   2790
      TabIndex        =   6
      Top             =   2385
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   4500
      TabIndex        =   7
      Top             =   2385
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1080
      TabIndex        =   5
      Top             =   2385
      Width           =   1485
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   285
      Left            =   2430
      TabIndex        =   1
      Top             =   555
      Width           =   4410
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdRubroContable"
      Height          =   315
      Index           =   1
      Left            =   2430
      TabIndex        =   2
      Tag             =   "RubrosContables"
      Top             =   945
      Width           =   4410
      _ExtentX        =   7779
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdRubroContable"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaMadre"
      Height          =   315
      Index           =   0
      Left            =   2430
      TabIndex        =   3
      Tag             =   "Cuentas"
      Top             =   1350
      Width           =   4410
      _ExtentX        =   7779
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo destino (opcional) :"
      Height          =   285
      Index           =   4
      Left            =   180
      TabIndex        =   12
      Top             =   1815
      Width           =   2160
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo :"
      Height          =   285
      Index           =   3
      Left            =   180
      TabIndex        =   11
      Top             =   150
      Width           =   2160
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuenta madre :"
      Height          =   240
      Index           =   0
      Left            =   180
      TabIndex        =   10
      Top             =   1395
      Width           =   2160
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Rubro contable :"
      Height          =   240
      Index           =   2
      Left            =   180
      TabIndex        =   9
      Top             =   990
      Width           =   2160
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripcion :"
      Height          =   285
      Index           =   1
      Left            =   180
      TabIndex        =   8
      Top             =   570
      Width           =   2160
   End
End
Attribute VB_Name = "frmCuentasGastos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.CuentaGasto
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long
Dim actL2 As ControlForm
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
      With origen.Registro
         .Fields(DataCombo1(0).DataField).Value = Null
         .Fields(DataCombo1(1).DataField).Value = Null
         .Fields("Nivel").Value = 1
      End With
      DataCombo1(0).Enabled = False
      DataCombo1(1).Enabled = False
      'txtNivel.Enabled = True
   Else
      With origen.Registro
         .Fields("Nivel").Value = Null
      End With
      DataCombo1(0).Enabled = True
      DataCombo1(1).Enabled = True
      txtNivel.Enabled = False
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
      Case 0
         Dim est As EnumAcciones
         Dim dc As DataCombo
         
         If Len(Trim(txtDescripcion.Text)) = 0 Then
            MsgBox "Debe ingresar la descripcion de la cuenta de gastos", vbExclamation
            Exit Sub
         End If
         
         With origen.Registro
            For Each dc In DataCombo1
               If dc.Enabled Then
                  If Len(Trim(dc.BoundText)) = 0 Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
                  .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
            If Check1.Value = 1 Then
               .Fields("Titulo").Value = "SI"
            Else
               .Fields("Titulo").Value = Null
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
            .ListaEditada = "CuentasGastos"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
      Case 1
   
         If mvarId > 0 Then
            origen.Eliminar
            est = baja
            With actL2
               .ListaEditada = "CuentasGastos"
               .AccionRegistro = est
               .Disparador = mvarId
            End With
         End If
         
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

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   
   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oAp.CuentasGastos.Item(vNewValue)
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
               If oControl.Tag = "Cuentas" Then
                  Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_SinCuentasGastosObras")
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   If mvarId <= 0 Then
   
   Else
      With origen.Registro
         If IIf(IsNull(.Fields("Titulo").Value), "NO", .Fields("Titulo").Value) = "SI" Then Check1.Value = 1
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

Private Sub DataCombo1_GotFocus(Index As Integer)

   SendKeys "%{DOWN}"

End Sub

Private Sub Form_Load()

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

Private Sub txtCodigoDestino_GotFocus()

   With txtCodigoDestino
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoDestino_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtDescripcion_GotFocus()

   With txtDescripcion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNivel_GotFocus()

   With txtNivel
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNivel_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNivel_Validate(Cancel As Boolean)

   If txtNivel.Text <> 1 And txtNivel.Text <> 2 Then
      MsgBox "El nivel debe ser 1 o 2", vbExclamation
      Cancel = True
   End If

End Sub
