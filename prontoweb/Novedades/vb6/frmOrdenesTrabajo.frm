VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmOrdenesTrabajo 
   Caption         =   "Ordenes de Trabajo"
   ClientHeight    =   6180
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9360
   Icon            =   "frmOrdenesTrabajo.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6180
   ScaleWidth      =   9360
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Height          =   825
      Left            =   180
      TabIndex        =   21
      Top             =   4680
      Width           =   8970
      Begin VB.TextBox txtCodigoArticulo1 
         Alignment       =   2  'Center
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "0.000"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   3082
            SubFormatType   =   0
         EndProperty
         Enabled         =   0   'False
         Height          =   315
         Left            =   3960
         TabIndex        =   23
         Top             =   135
         Width           =   2355
      End
      Begin VB.CheckBox Check1 
         Alignment       =   1  'Right Justify
         Caption         =   "Ingresar equipo destino :"
         Height          =   195
         Left            =   90
         TabIndex        =   22
         Top             =   180
         Width           =   2130
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdEquipoDestino"
         Height          =   315
         Index           =   4
         Left            =   135
         TabIndex        =   25
         Tag             =   "Articulos1"
         Top             =   450
         Width           =   8745
         _ExtentX        =   15425
         _ExtentY        =   556
         _Version        =   393216
         Enabled         =   0   'False
         ListField       =   "Titulo"
         BoundColumn     =   "IdArticulo"
         Text            =   ""
      End
      Begin VB.Label lblData 
         Caption         =   "Equipo destino :"
         Height          =   255
         Index           =   1
         Left            =   2565
         TabIndex        =   24
         Top             =   180
         Width           =   1275
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   210
      TabIndex        =   9
      Top             =   5655
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   3630
      TabIndex        =   11
      Top             =   5655
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   1920
      TabIndex        =   10
      Top             =   5655
      Width           =   1485
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   285
      Left            =   2610
      TabIndex        =   1
      Top             =   630
      Width           =   6525
   End
   Begin VB.TextBox txtNumeroOrdenTrabajo 
      Alignment       =   2  'Center
      DataField       =   "NumeroOrdenTrabajo"
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
      Left            =   2610
      TabIndex        =   0
      Top             =   225
      Width           =   1215
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdOrdeno"
      Height          =   315
      Index           =   0
      Left            =   1035
      TabIndex        =   6
      Tag             =   "Empleados"
      Top             =   2880
      Width           =   3465
      _ExtentX        =   6112
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaInicio"
      Height          =   330
      Index           =   0
      Left            =   1575
      TabIndex        =   2
      Top             =   1035
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   59899905
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaEntrega"
      Height          =   330
      Index           =   1
      Left            =   4545
      TabIndex        =   3
      Top             =   1035
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   59899905
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaFinalizacion"
      Height          =   330
      Index           =   2
      Left            =   7650
      TabIndex        =   4
      Top             =   1035
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   59899905
      CurrentDate     =   36377
   End
   Begin RichTextLib.RichTextBox rchTrabajosARealizar 
      Height          =   1050
      Left            =   180
      TabIndex        =   5
      Top             =   1710
      Width           =   8970
      _ExtentX        =   15822
      _ExtentY        =   1852
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmOrdenesTrabajo.frx":076A
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSuperviso"
      Height          =   315
      Index           =   1
      Left            =   5625
      TabIndex        =   7
      Tag             =   "Empleados"
      Top             =   2880
      Width           =   3510
      _ExtentX        =   6191
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1050
      Left            =   180
      TabIndex        =   8
      Top             =   3555
      Width           =   8970
      _ExtentX        =   15822
      _ExtentY        =   1852
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmOrdenesTrabajo.frx":07EC
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   195
      Index           =   3
      Left            =   225
      TabIndex        =   20
      Top             =   3375
      Width           =   1200
   End
   Begin VB.Label lblData 
      Caption         =   "Superviso :"
      Height          =   255
      Index           =   0
      Left            =   4680
      TabIndex        =   19
      Top             =   2910
      Width           =   825
   End
   Begin VB.Label lblLabels 
      Caption         =   "Descripcion de las tareas a realizar :"
      Height          =   195
      Index           =   2
      Left            =   225
      TabIndex        =   18
      Top             =   1530
      Width           =   2595
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de finalizacion :"
      Height          =   240
      Index           =   1
      Left            =   5940
      TabIndex        =   17
      Top             =   1080
      Width           =   1605
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de entrega :"
      Height          =   240
      Index           =   0
      Left            =   3015
      TabIndex        =   16
      Top             =   1080
      Width           =   1425
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de inicio :"
      Height          =   240
      Index           =   4
      Left            =   225
      TabIndex        =   15
      Top             =   1080
      Width           =   1245
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripcion :"
      Height          =   255
      Index           =   1
      Left            =   225
      TabIndex        =   14
      Top             =   645
      Width           =   2175
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Numero de orden de  trabajo :"
      Height          =   255
      Index           =   2
      Left            =   225
      TabIndex        =   13
      Top             =   225
      Width           =   2175
   End
   Begin VB.Label lblData 
      Caption         =   "Ordeno :"
      Height          =   255
      Index           =   2
      Left            =   225
      TabIndex        =   12
      Top             =   2910
      Width           =   690
   End
End
Attribute VB_Name = "frmOrdenesTrabajo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.OrdenTrabajo
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

Private Sub Check1_Click()

   If Check1.Value = 1 Then
      txtCodigoArticulo1.Enabled = True
      DataCombo1(4).Enabled = True
   Else
      txtCodigoArticulo1.Enabled = False
      DataCombo1(4).Enabled = False
      origen.Registro.Fields("IdEquipoDestino").Value = Null
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
   
         If Len(txtDescripcion.Text) = 0 Then
            MsgBox "Debe ingresar una descripcion", vbExclamation
            Exit Sub
         End If
         
         Dim est As EnumAcciones
         Dim oControl As Control
         Dim oPar As ComPronto.Parametro
         Dim oRs As ADOR.Recordset
         Dim mvarNumero As Long
   
         Set oRs = Aplicacion.OrdenesTrabajo.TraerFiltrado("_PorNumero", Array(txtNumeroOrdenTrabajo.Text, mvarId))
         If oRs.RecordCount > 0 Then
            oRs.Close
            Set oRs = Nothing
            MsgBox "Ya existe una orden de trabajo con este numero", vbExclamation
            Exit Sub
         End If
         oRs.Close
         Set oRs = Nothing
         
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
            .Fields("TrabajosARealizar").Value = rchTrabajosARealizar.Text
            .Fields("Observaciones").Value = rchObservaciones.Text
            If mvarId < 0 Then
               If Len(.Fields("NumeroOrdenTrabajo").Value) > 0 And Not IsNumeric(.Fields("NumeroOrdenTrabajo").Value) Then
               Else
                  Set oPar = Aplicacion.Parametros.Item(1)
                  With oPar.Registro
                     mvarNumero = IIf(IsNull(.Fields("ProximoNumeroOrdenTrabajo").Value), 1, .Fields("ProximoNumeroOrdenTrabajo").Value)
                     .Fields("ProximoNumeroOrdenTrabajo").Value = mvarNumero + 1
                  End With
                  .Fields("NumeroOrdenTrabajo").Value = mvarNumero
                  oPar.Guardar
                  Set oPar = Nothing
               End If
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
            .ListaEditada = "OrdenesTrabajoTodas,+SubOT2"
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
            .ListaEditada = "OrdenesTrabajoTodas,+SubOT2"
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
   Set origen = oAp.OrdenesTrabajo.Item(vnewvalue)
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
               If oControl.Tag = "Articulos1" Then
                  Set oControl.RowSource = oAp.Articulos.TraerFiltrado("_ParaMantenimiento_ParaCombo")
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
   
   If mvarId = -1 Then
      DTFields(0).Value = Date
      DTFields(1).Value = Date
      Set oRs = oAp.Parametros.TraerTodos
      With origen.Registro
         .Fields("IdOrdeno").Value = glbIdUsuario
         .Fields("NumeroOrdenTrabajo").Value = IIf(IsNull(oRs.Fields("ProximoNumeroOrdenTrabajo").Value), 1, oRs.Fields("ProximoNumeroOrdenTrabajo").Value)
      End With
      oRs.Close
   Else
      With origen.Registro
         rchTrabajosARealizar.TextRTF = IIf(IsNull(.Fields("TrabajosARealizar").Value), "", .Fields("TrabajosARealizar").Value)
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
         If Not IsNull(.Fields("IdEquipoDestino").Value) Then Check1.Value = 1
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

   Dim oRs As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
            
   Select Case Index
      Case 4
         If IsNumeric(DataCombo1(Index).BoundText) Then
            origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorId", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then
               txtCodigoArticulo1.Text = IIf(IsNull(oRs.Fields("NumeroInventario").Value), "", oRs.Fields("NumeroInventario").Value)
            End If
            oRs.Close
         End If
   End Select
      
   Set oRs = Nothing
   Set oRsAux = Nothing

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

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

Private Sub txtCodigoArticulo1_GotFocus()

   With txtCodigoArticulo1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoArticulo1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoArticulo1_Validate(Cancel As Boolean)

   If Len(txtCodigoArticulo1.Text) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorNumeroInventario", txtCodigoArticulo1.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdEquipoDestino").Value = oRs.Fields(0).Value
      Else
         MsgBox "Numero de inventario del material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo1.Text = ""
      End If
      oRs.Close
      Set oRs = Nothing
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
