VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetPresupuestoObrasConsumos 
   Caption         =   "Item de consumo para presupuesto de obra"
   ClientHeight    =   3450
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8655
   LinkTopic       =   "Form1"
   ScaleHeight     =   3450
   ScaleWidth      =   8655
   StartUpPosition =   2  'CenterScreen
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
      Left            =   990
      TabIndex        =   9
      Top             =   2520
      Width           =   1410
   End
   Begin VB.TextBox txtDetalle 
      Height          =   330
      Left            =   990
      TabIndex        =   8
      Top             =   2025
      Width           =   7530
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      Height          =   330
      Left            =   4005
      TabIndex        =   7
      Top             =   1530
      Width           =   1140
   End
   Begin VB.TextBox txtCantidad 
      Alignment       =   1  'Right Justify
      Height          =   330
      Left            =   990
      TabIndex        =   5
      Top             =   1530
      Width           =   735
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      ItemData        =   "frmDetPresupuestoObrasConsumos.frx":0000
      Left            =   3780
      List            =   "frmDetPresupuestoObrasConsumos.frx":004C
      TabIndex        =   4
      Text            =   "Combo2"
      Top             =   1035
      Width           =   1410
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "frmDetPresupuestoObrasConsumos.frx":0098
      Left            =   990
      List            =   "frmDetPresupuestoObrasConsumos.frx":00C3
      TabIndex        =   3
      Text            =   "Combo1"
      Top             =   1035
      Width           =   1815
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   330
      Index           =   0
      Left            =   45
      TabIndex        =   11
      Top             =   3015
      Width           =   1140
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   330
      Index           =   1
      Left            =   1305
      TabIndex        =   12
      Top             =   3015
      Width           =   1140
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   990
      TabIndex        =   0
      Tag             =   "Obras"
      Top             =   495
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   1
      Left            =   3780
      TabIndex        =   1
      Tag             =   "ObrasDestinos"
      Top             =   495
      Width           =   1860
      _ExtentX        =   3281
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdDetalleObraDestino"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   2
      Left            =   6660
      TabIndex        =   2
      Tag             =   "PresupuestoObrasRubros"
      Top             =   495
      Width           =   1860
      _ExtentX        =   3281
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdPresupuestoObraRubro"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   3
      Left            =   2430
      TabIndex        =   10
      Tag             =   "Articulos"
      Top             =   2520
      Width           =   6135
      _ExtentX        =   10821
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   4
      Left            =   1800
      TabIndex        =   6
      Tag             =   "Unidades"
      Top             =   1530
      Width           =   1005
      _ExtentX        =   1773
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   3
      Left            =   90
      TabIndex        =   22
      Top             =   2580
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "Detalle :"
      Height          =   240
      Index           =   4
      Left            =   90
      TabIndex        =   21
      Top             =   2115
      Width           =   735
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H00C0E0FF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   90
      TabIndex        =   20
      Top             =   90
      Width           =   8430
   End
   Begin VB.Label Label1 
      Caption         =   "Importe :"
      Height          =   240
      Index           =   3
      Left            =   3105
      TabIndex        =   19
      Top             =   1620
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "Cantidad :"
      Height          =   240
      Index           =   2
      Left            =   90
      TabIndex        =   18
      Top             =   1620
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "Año :"
      Height          =   240
      Index           =   1
      Left            =   3105
      TabIndex        =   17
      Top             =   1080
      Width           =   465
   End
   Begin VB.Label Label1 
      Caption         =   "Mes :"
      Height          =   240
      Index           =   0
      Left            =   90
      TabIndex        =   16
      Top             =   1080
      Width           =   735
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obra :"
      Height          =   255
      Index           =   11
      Left            =   90
      TabIndex        =   15
      Top             =   540
      Width           =   825
   End
   Begin VB.Label lblLabels 
      Caption         =   "Etapa :"
      Height          =   255
      Index           =   0
      Left            =   3150
      TabIndex        =   14
      Top             =   540
      Width           =   555
   End
   Begin VB.Label lblLabels 
      Caption         =   "Rubro :"
      Height          =   255
      Index           =   1
      Left            =   6030
      TabIndex        =   13
      Top             =   540
      Width           =   555
   End
End
Attribute VB_Name = "frmDetPresupuestoObrasConsumos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mvarIdObra As Long, mvarIdDetalleObraDestino As Long, mvarIdPresupuestoObraRubro As Long
Private mvarIdArticulo As Long, mvarIdPresupuestoObraConsumo As Long
Public Aceptado As Boolean

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Dim i As Integer
         
         If Not IsNumeric(DataCombo1(1).BoundText) Then
            MsgBox "Debe ingresar una etapa", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(DataCombo1(2).BoundText) Then
            MsgBox "Debe ingresar un rubro", vbExclamation
            Exit Sub
         End If
         
         Me.IdDetalleObraDestino = DataCombo1(1).BoundText
         Me.IdPresupuestoObraRubro = DataCombo1(2).BoundText
         
         Aplicacion.Tarea "PresupuestoObrasConsumos_Actualizar", _
                  Array(Me.IdPresupuestoObraConsumo, IIf(IsNumeric(DataCombo1(3).BoundText), DataCombo1(3).BoundText, Me.IdArticulo), _
                        mvarIdObra, Me.IdDetalleObraDestino, Me.IdPresupuestoObraRubro, _
                        Combo2.ListIndex + 2001, Combo1.ListIndex + 1, Val(txtCantidad.Text), Val(txtImporte.Text), txtDetalle.Text, IIf(IsNumeric(DataCombo1(4).BoundText), DataCombo1(4).BoundText, 0))
         
         Aceptado = True
      
      Case 1
      
   End Select
   
   Me.Hide

End Sub

Private Sub Combo1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Combo2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   Set DataCombo1(0).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasParaCombo")
   DataCombo1(0).BoundText = Me.IdObra
   Set DataCombo1(1).RowSource = Aplicacion.Obras.TraerFiltrado("_DestinosParaComboPorIdObra", Me.IdObra)
   DataCombo1(1).BoundText = Me.IdDetalleObraDestino
   Set DataCombo1(2).RowSource = Aplicacion.TablasGenerales.TraerLista("PresupuestoObrasRubros")
   DataCombo1(2).BoundText = Me.IdPresupuestoObraRubro
   Set DataCombo1(4).RowSource = Aplicacion.Unidades.TraerLista
   Set DataCombo1(3).RowSource = Aplicacion.Articulos.TraerLista
   
   Dim oRs As ADOR.Recordset
   
   If Me.IdArticulo = -2 Then
      Label2.Caption = "ASIENTO"
   ElseIf Me.IdArticulo = -3 Then
      Label2.Caption = "CONSUMO DIRECTO"
   Else
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", Me.IdArticulo)
      If oRs.RecordCount > 0 Then
         Label2.Caption = oRs.Fields("Descripcion").Value
      End If
      oRs.Close
   End If
   
   If Me.IdPresupuestoObraConsumo > 0 Then
      Set oRs = Aplicacion.TablasGenerales.TraerUno("PresupuestoObrasConsumos", Me.IdPresupuestoObraConsumo)
      If oRs.RecordCount > 0 Then
         Combo1.ListIndex = oRs.Fields("Mes").Value - 1
         Combo2.ListIndex = oRs.Fields("Año").Value - 2001
         txtCantidad.Text = IIf(IsNull(oRs.Fields("Cantidad").Value), 0, oRs.Fields("Cantidad").Value)
         txtImporte.Text = IIf(IsNull(oRs.Fields("Importe").Value), 0, oRs.Fields("Importe").Value)
         txtDetalle.Text = IIf(IsNull(oRs.Fields("Detalle").Value), "", oRs.Fields("Detalle").Value)
         DataCombo1(4).BoundText = IIf(IsNull(oRs.Fields("IdUnidad").Value), 0, oRs.Fields("IdUnidad").Value)
         DataCombo1(3).BoundText = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
      End If
      oRs.Close
      Set oRs = Nothing
   Else
      Combo1.ListIndex = Month(Date) - 1
      Combo2.ListIndex = Year(Date) - 2001
   End If

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

Private Sub txtDetalle_GotFocus()

   With txtDetalle
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDetalle_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDetalle
         If Len(Trim(.Text)) >= 50 And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
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

Public Property Get IdObra() As Long

   IdObra = mvarIdObra

End Property

Public Property Let IdObra(ByVal vnewvalue As Long)

   mvarIdObra = vnewvalue

End Property

Public Property Get IdArticulo() As Long

   IdArticulo = mvarIdArticulo

End Property

Public Property Let IdArticulo(ByVal vnewvalue As Long)

   mvarIdArticulo = vnewvalue

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

Public Property Get IdPresupuestoObraConsumo() As Long

   IdPresupuestoObraConsumo = mvarIdPresupuestoObraConsumo

End Property

Public Property Let IdPresupuestoObraConsumo(ByVal vnewvalue As Long)

   mvarIdPresupuestoObraConsumo = vnewvalue

End Property

