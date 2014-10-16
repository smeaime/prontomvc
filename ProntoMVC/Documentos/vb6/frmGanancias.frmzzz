VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmGanancias 
   Caption         =   "Item de tabla de impuesto a las ganancias"
   ClientHeight    =   2520
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7500
   Icon            =   "frmGanancias.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2520
   ScaleWidth      =   7500
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtMinimoARetener 
      Alignment       =   1  'Right Justify
      DataField       =   "MinimoARetener"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   5850
      TabIndex        =   6
      Top             =   1080
      Width           =   1545
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   6255
      TabIndex        =   9
      Top             =   1800
      Width           =   1125
   End
   Begin VB.TextBox txtMinimoNoImponible 
      Alignment       =   1  'Right Justify
      DataField       =   "MinimoNoImponible"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   5850
      TabIndex        =   5
      Top             =   675
      Width           =   1545
   End
   Begin VB.TextBox txtPorcentajeAdicional 
      Alignment       =   1  'Right Justify
      DataField       =   "PorcentajeAdicional"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   2115
      TabIndex        =   4
      Top             =   1890
      Width           =   1545
   End
   Begin VB.TextBox txtSumaFija 
      Alignment       =   1  'Right Justify
      DataField       =   "SumaFija"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   2115
      TabIndex        =   3
      Top             =   1485
      Width           =   1545
   End
   Begin VB.TextBox txtHasta 
      Alignment       =   1  'Right Justify
      DataField       =   "Hasta"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   2115
      TabIndex        =   2
      Top             =   1080
      Width           =   1545
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   5040
      TabIndex        =   8
      Top             =   1800
      Width           =   1125
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   3870
      TabIndex        =   7
      Top             =   1800
      Width           =   1125
   End
   Begin VB.TextBox txtDesde 
      Alignment       =   1  'Right Justify
      DataField       =   "Desde"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   2115
      TabIndex        =   1
      Top             =   675
      Width           =   1545
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdTipoRetencionGanancia"
      Height          =   315
      Index           =   0
      Left            =   2115
      TabIndex        =   0
      Tag             =   "TiposRetencionGanancia"
      Top             =   315
      Width           =   3195
      _ExtentX        =   5636
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoRetencionGanancia"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Minimo a retener :"
      Height          =   300
      Index           =   6
      Left            =   3870
      TabIndex        =   16
      Top             =   1125
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tipo de retencion :"
      Height          =   300
      Index           =   5
      Left            =   135
      TabIndex        =   15
      Top             =   315
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Minimo no imponible :"
      Height          =   300
      Index           =   4
      Left            =   3870
      TabIndex        =   14
      Top             =   720
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Porcentaje adicional :"
      Height          =   300
      Index           =   3
      Left            =   135
      TabIndex        =   13
      Top             =   1935
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Suma fija :"
      Height          =   300
      Index           =   2
      Left            =   135
      TabIndex        =   12
      Top             =   1530
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Desde :"
      Height          =   300
      Index           =   0
      Left            =   135
      TabIndex        =   11
      Top             =   720
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Hasta :"
      Height          =   300
      Index           =   1
      Left            =   135
      TabIndex        =   10
      Top             =   1125
      Width           =   1815
   End
End
Attribute VB_Name = "frmGanancias"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Ganancia
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
         Dim oRs As ADOR.Recordset
         Dim oAp As ComPronto.Aplicacion
         Dim oPar As ComPronto.Parametro
   
         For Each oControl In Me.Controls
            If TypeOf oControl Is DataCombo Then
               If Len(oControl.BoundText) <> 0 Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
               End If
            ElseIf TypeOf oControl Is DTPicker Then
               origen.Registro.Fields(oControl.DataField).Value = oControl.Value
            End If
         Next
      
'         Set oAp = Aplicacion
'         Set oPar = oAp.Parametros.Item(1)
'         With oPar
'            .Registro.Fields("MinimoNoImponible").Value = txtMinimoNoImponible.Text
''            .Registro.Fields("DeduccionEspecial").Value = txtDeduccionEspecial.Text
'            .Guardar
'         End With
'         Set oPar = Nothing
'         Set oAp = Nothing
         
         With origen.Registro
         
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
      
         Aplicacion.Tarea "Ganacias_AsignarMinimos", _
               Array(origen.Registro.Fields("IdTipoRetencionGanancia").Value, _
                     Val(txtMinimoNoImponible.Text), Val(txtMinimoARetener.Text))
         
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "Ganancias"
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
            .ListaEditada = "Ganancias"
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
   Dim oPar As ComPronto.Parametro
   Dim oControl As Control
   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oAp.Ganancias.Item(vnewvalue)
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
   
'   Set oPar = oAp.Parametros.Item(1)
'   With oPar.Registro
'      txtMinimoNoImponible.Text = .Fields("MinimoNoImponible").Value
''      txtDeduccionEspecial.Text = .Fields("DeduccionEspecial").Value
'   End With
'   Set oPar = Nothing
         
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

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

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

Private Sub txtDesde_GotFocus()

   With txtDesde
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDesde_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtHasta_GotFocus()

   With txtHasta
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtHasta_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtMinimoARetener_GotFocus()

   With txtMinimoARetener
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtMinimoARetener_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtMinimoNoImponible_GotFocus()

   With txtMinimoNoImponible
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtMinimoNoImponible_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPorcentajeAdicional_GotFocus()

   With txtPorcentajeAdicional
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcentajeAdicional_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtSumaFija_GotFocus()

   With txtSumaFija
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtSumaFija_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
