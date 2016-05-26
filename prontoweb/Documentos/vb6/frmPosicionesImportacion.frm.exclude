VERSION 5.00
Begin VB.Form frmPosicionesImportacion 
   Caption         =   "Posiciones para gastos de importacion"
   ClientHeight    =   3120
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7965
   Icon            =   "frmPosicionesImportacion.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3120
   ScaleWidth      =   7965
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtTotalGastos 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
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
      Left            =   6390
      TabIndex        =   15
      Top             =   2025
      Width           =   1335
   End
   Begin VB.TextBox txtOtrosGastos2 
      Alignment       =   1  'Right Justify
      DataField       =   "OtrosGastos2"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   285
      Left            =   2280
      TabIndex        =   5
      Top             =   1980
      Width           =   1335
   End
   Begin VB.TextBox txtOtrosGastos1 
      Alignment       =   1  'Right Justify
      DataField       =   "OtrosGastos1"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   285
      Left            =   2280
      TabIndex        =   4
      Top             =   1620
      Width           =   1335
   End
   Begin VB.TextBox txtGastosEstadisticas 
      Alignment       =   1  'Right Justify
      DataField       =   "GastosEstadisticas"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   285
      Left            =   2280
      TabIndex        =   3
      Top             =   1260
      Width           =   1335
   End
   Begin VB.TextBox txtDerecho 
      Alignment       =   1  'Right Justify
      DataField       =   "Derechos"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   285
      Left            =   2280
      TabIndex        =   2
      Top             =   900
      Width           =   1335
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   285
      Left            =   2280
      TabIndex        =   1
      Top             =   540
      Width           =   5445
   End
   Begin VB.TextBox txtCodigo 
      DataField       =   "CodigoPosicion"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   2280
      TabIndex        =   0
      Top             =   135
      Width           =   2370
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1395
      TabIndex        =   6
      Top             =   2595
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   4815
      TabIndex        =   8
      Top             =   2595
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   3105
      TabIndex        =   7
      Top             =   2595
      Width           =   1485
   End
   Begin VB.Label lblLabels 
      Caption         =   "Total gastos en % :"
      Height          =   255
      Index           =   7
      Left            =   4365
      TabIndex        =   16
      Top             =   2055
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "% Otros gastos (2) :"
      Height          =   255
      Index           =   6
      Left            =   270
      TabIndex        =   14
      Top             =   2025
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "% Otros gastos (1) :"
      Height          =   255
      Index           =   5
      Left            =   270
      TabIndex        =   13
      Top             =   1665
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "% Gastos estadisticas :"
      Height          =   255
      Index           =   2
      Left            =   270
      TabIndex        =   12
      Top             =   1305
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo :"
      Height          =   255
      Index           =   0
      Left            =   270
      TabIndex        =   11
      Top             =   180
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Descripcion :"
      Height          =   255
      Index           =   1
      Left            =   270
      TabIndex        =   10
      Top             =   525
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "% Derechos :"
      Height          =   255
      Index           =   4
      Left            =   270
      TabIndex        =   9
      Top             =   945
      Width           =   1815
   End
End
Attribute VB_Name = "frmPosicionesImportacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.PosicionImportacion
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

   Select Case Index
   
      Case 0
   
         Dim est As EnumAcciones
         Dim oControl As Control
         Dim oRs As ADOR.Recordset
   
         For Each oControl In Me.Controls
            If TypeOf oControl Is DataCombo Then
               If Len(oControl.BoundText) <> 0 Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
               End If
            ElseIf TypeOf oControl Is DTPicker Then
               origen.Registro.Fields(oControl.DataField).Value = oControl.Value
            End If
         Next
      
         If mvarId < 0 Then
            Set oRs = Aplicacion.PosicionesImportacion.TraerFiltrado("_Existente", origen.Registro.Fields("CodigoPosicion").Value)
            If oRs.RecordCount > 0 Then
               oRs.Close
               Set oRs = Nothing
               MsgBox "El codigo y tipo de posicion ya existen, Modifiquelos.", vbExclamation
               Exit Sub
            End If
            oRs.Close
            Set oRs = Nothing
         End If
         
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
            .ListaEditada = "PosicionesImportacion"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
      Case 1
   
         origen.Eliminar
         
         est = baja
            
         With actL2
            .ListaEditada = "PosicionesImportacion"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
   End Select
   
   Unload Me

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oAp.PosicionesImportacion.Item(vnewvalue)
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

Private Sub txtCodigo_GotFocus()

   With txtCodigo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtDerecho_Change()

   CalcularTotalGastos

End Sub

Private Sub txtDerecho_GotFocus()

   With txtDerecho
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDerecho_KeyPress(KeyAscii As Integer)

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

Private Sub txtGastosEstadisticas_Change()

   CalcularTotalGastos

End Sub

Private Sub txtGastosEstadisticas_GotFocus()

   With txtGastosEstadisticas
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtGastosEstadisticas_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtOtrosGastos1_Change()

   CalcularTotalGastos

End Sub

Private Sub txtOtrosGastos1_GotFocus()

   With txtOtrosGastos1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtOtrosGastos1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtOtrosGastos2_Change()

   CalcularTotalGastos

End Sub

Private Sub txtOtrosGastos2_GotFocus()

   With txtOtrosGastos2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtOtrosGastos2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Sub CalcularTotalGastos()

   txtTotalGastos.Text = Val(txtDerecho.Text) + Val(txtGastosEstadisticas.Text) + Val(txtOtrosGastos1.Text) + Val(txtOtrosGastos2.Text)

End Sub
