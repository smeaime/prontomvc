VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetPresupuestoObrasConsumosTeoricos 
   Caption         =   "Detalle de consumos teoricos"
   ClientHeight    =   2070
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10005
   LinkTopic       =   "Form1"
   ScaleHeight     =   2070
   ScaleWidth      =   10005
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1260
      TabIndex        =   4
      Top             =   945
      Width           =   870
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   390
      Index           =   1
      Left            =   1440
      TabIndex        =   6
      Top             =   1530
      Width           =   1125
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   390
      Index           =   0
      Left            =   135
      TabIndex        =   5
      Top             =   1530
      Width           =   1125
   End
   Begin VB.TextBox txtCantidad 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1260
      TabIndex        =   2
      Top             =   585
      Width           =   870
   End
   Begin VB.TextBox txtCodigoArticulo 
      Alignment       =   2  'Center
      DataField       =   "CodigoArticulo"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1260
      TabIndex        =   0
      Top             =   225
      Width           =   1410
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   1
      Left            =   2700
      TabIndex        =   1
      Tag             =   "Articulos"
      Top             =   225
      Width           =   7215
      _ExtentX        =   12726
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   2160
      TabIndex        =   3
      Tag             =   "Unidades"
      Top             =   585
      Width           =   2040
      _ExtentX        =   3598
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Costo Unit. :"
      Height          =   300
      Index           =   0
      Left            =   135
      TabIndex        =   9
      Top             =   945
      Width           =   1005
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   135
      TabIndex        =   8
      Top             =   585
      Width           =   1005
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   2
      Left            =   135
      TabIndex        =   7
      Top             =   240
      Width           =   1005
   End
End
Attribute VB_Name = "frmDetPresupuestoObrasConsumosTeoricos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mvarIdPresupuestoObraConsumoTeorico As Long, mvarIdDetalleObraDestino As Long
Private mvarIdPresupuestoObraRubro As Long, mvarCodigoPresupuesto As Long
Public Aceptado As Boolean

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Dim i As Integer
         
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe ingresar una unidad", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(DataCombo1(1).BoundText) Then
            MsgBox "Debe ingresar un material", vbExclamation
            Exit Sub
         End If
         
         Aplicacion.Tarea "PresupuestoObras_ActualizarTeoricos", _
                  Array(Me.IdPresupuestoObraConsumoTeorico, Me.IdDetalleObraDestino, Me.IdPresupuestoObraRubro, Me.CodigoPresupuesto, _
                        DataCombo1(1).BoundText, Val(txtCantidad.Text), Val(txtImporte.Text), DataCombo1(0).BoundText)
         
         Aceptado = True
      
      Case 1
      
   End Select
   
   Me.Hide

End Sub

Private Sub DataCombo1_Change(Index As Integer)

   Select Case Index
      Case 1
         If IsNumeric(DataCombo1(1).BoundText) Then
            Dim oRs As ADOR.Recordset
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(1).BoundText)
            If oRs.RecordCount > 0 Then
               DataCombo1(0).BoundText = IIf(IsNull(oRs.Fields("IdUnidad").Value), 0, oRs.Fields("IdUnidad").Value)
            End If
            txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
            oRs.Close
            Set oRs = Nothing
         End If
   End Select
      
End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   Dim oRs As ADOR.Recordset
   
   Set DataCombo1(0).RowSource = Aplicacion.Unidades.TraerLista
   Set DataCombo1(1).RowSource = Aplicacion.Articulos.TraerLista
   
   If Me.IdPresupuestoObraConsumoTeorico > 0 Then
      Set oRs = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObraConsumosTeoricos_Detalles_T", Me.IdPresupuestoObraConsumoTeorico)
      If oRs.RecordCount > 0 Then
         DataCombo1(0).BoundText = IIf(IsNull(oRs.Fields("IdUnidad").Value), 0, oRs.Fields("IdUnidad").Value)
         DataCombo1(1).BoundText = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
         txtCantidad.Text = IIf(IsNull(oRs.Fields("Cantidad").Value), 0, oRs.Fields("Cantidad").Value)
         txtImporte.Text = IIf(IsNull(oRs.Fields("Importe").Value), 0, oRs.Fields("Importe").Value)
      End If
      oRs.Close
   End If
   
   Set oRs = Nothing

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub txtCantidad_GotFocus()

   With txtCantidad
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCodigoArticulo_GotFocus()

   With txtCodigoArticulo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoArticulo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCodigoArticulo_Validate(Cancel As Boolean)

   If Len(txtCodigoArticulo.Text) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo.Text)
      If oRs.RecordCount > 0 Then
         DataCombo1(1).BoundText = oRs.Fields(0).Value
      Else
         MsgBox "Codigo de material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo.Text = ""
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

Private Sub txtImporte_GotFocus()

   With txtImporte
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImporte_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Public Property Get IdPresupuestoObraConsumoTeorico() As Long

   IdPresupuestoObraConsumoTeorico = mvarIdPresupuestoObraConsumoTeorico

End Property

Public Property Let IdPresupuestoObraConsumoTeorico(ByVal vnewvalue As Long)

   mvarIdPresupuestoObraConsumoTeorico = vnewvalue

End Property

Public Property Get IdDetalleObraDestino() As Long

   IdDetalleObraDestino = mvarIdDetalleObraDestino

End Property

Public Property Let IdDetalleObraDestino(ByVal vnewvalue As Long)

   mvarIdDetalleObraDestino = vnewvalue

End Property

Public Property Get IdPresupuestoObraRubro() As Long

   IdPresupuestoObraRubro = mvarIdPresupuestoObraRubro

End Property

Public Property Let IdPresupuestoObraRubro(ByVal vnewvalue As Long)

   mvarIdPresupuestoObraRubro = vnewvalue

End Property

Public Property Get CodigoPresupuesto() As Long

   CodigoPresupuesto = mvarCodigoPresupuesto

End Property

Public Property Let CodigoPresupuesto(ByVal vnewvalue As Long)

   mvarCodigoPresupuesto = vnewvalue

End Property
