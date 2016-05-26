VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetSalidasMaterialesSAT 
   Caption         =   "Item de salida de materiales de almacenes PRONTO SAT"
   ClientHeight    =   4530
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10740
   LinkTopic       =   "Form1"
   ScaleHeight     =   4530
   ScaleWidth      =   10740
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   285
      Left            =   9630
      TabIndex        =   44
      Top             =   4095
      Visible         =   0   'False
      Width           =   1005
   End
   Begin VB.TextBox txtPartida 
      Alignment       =   1  'Right Justify
      DataField       =   "Partida"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   1
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   2070
      TabIndex        =   15
      Top             =   945
      Width           =   1185
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   14
      Top             =   4050
      Width           =   1485
   End
   Begin VB.TextBox txtBusca 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
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
      Left            =   8370
      TabIndex        =   13
      Top             =   180
      Width           =   2265
   End
   Begin VB.TextBox txtCantidad1 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad1"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   1
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   4545
      TabIndex        =   12
      Top             =   1335
      Width           =   870
   End
   Begin VB.TextBox txtCantidad2 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad2"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   1
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   5850
      TabIndex        =   11
      Top             =   1335
      Width           =   870
   End
   Begin VB.TextBox txtUnidad 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   6795
      TabIndex        =   10
      Top             =   1335
      Width           =   1455
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
      Enabled         =   0   'False
      Height          =   315
      Left            =   2070
      TabIndex        =   9
      Top             =   135
      Width           =   1545
   End
   Begin VB.TextBox txtStockActual 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   5535
      TabIndex        =   8
      Top             =   135
      Width           =   1005
   End
   Begin VB.TextBox txtCotizacionMoneda 
      Alignment       =   1  'Right Justify
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
      Height          =   300
      Left            =   7380
      TabIndex        =   7
      Top             =   2115
      Width           =   870
   End
   Begin VB.TextBox txtCotizacionDolar 
      Alignment       =   1  'Right Justify
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
      Height          =   300
      Left            =   9720
      TabIndex        =   6
      Top             =   2115
      Width           =   915
   End
   Begin VB.TextBox txtCostoUnitario 
      Alignment       =   1  'Right Justify
      DataField       =   "CostoUnitario"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   2070
      TabIndex        =   5
      Top             =   2115
      Width           =   1095
   End
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
      Left            =   2070
      TabIndex        =   4
      Top             =   3600
      Width           =   1725
   End
   Begin VB.Frame Frame1 
      Caption         =   "Forma de baja de stock : "
      Height          =   420
      Left            =   5760
      TabIndex        =   1
      Top             =   1665
      Visible         =   0   'False
      Width           =   4875
      Begin VB.OptionButton Option2 
         Caption         =   "Descarga por componentes (Kit)"
         Height          =   195
         Left            =   2160
         TabIndex        =   3
         Top             =   180
         Width           =   2625
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Descarga por articulo"
         Height          =   195
         Left            =   90
         TabIndex        =   2
         Top             =   180
         Width           =   1860
      End
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
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   2070
      TabIndex        =   0
      Top             =   1350
      Width           =   870
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   2070
      TabIndex        =   16
      Tag             =   "Articulos"
      Top             =   540
      Width           =   8610
      _ExtentX        =   15187
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   0
      Left            =   2970
      TabIndex        =   17
      Tag             =   "Unidades"
      Top             =   1335
      Width           =   1545
      _ExtentX        =   2725
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1050
      Left            =   2070
      TabIndex        =   18
      Top             =   2475
      Width           =   8565
      _ExtentX        =   15108
      _ExtentY        =   1852
      _Version        =   393217
      Enabled         =   0   'False
      ScrollBars      =   2
      TextRTF         =   $"frmDetSalidasMaterialesSAT.frx":0000
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "Adjunto"
      Height          =   315
      Index           =   5
      Left            =   2070
      TabIndex        =   19
      Tag             =   "SiNo"
      Top             =   1755
      Width           =   780
      _ExtentX        =   1376
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "SiNo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUbicacion"
      Height          =   315
      Index           =   2
      Left            =   4365
      TabIndex        =   20
      Tag             =   "Ubicaciones"
      Top             =   945
      Width           =   3885
      _ExtentX        =   6853
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdUbicacion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   3
      Left            =   8955
      TabIndex        =   21
      Tag             =   "Obras"
      Top             =   945
      Width           =   1725
      _ExtentX        =   3043
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   3
      Left            =   4095
      TabIndex        =   22
      Tag             =   "Monedas"
      Top             =   2115
      Width           =   1590
      _ExtentX        =   2805
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdEquipoDestino"
      Height          =   315
      Index           =   4
      Left            =   3870
      TabIndex        =   23
      Tag             =   "Articulos1"
      Top             =   3600
      Width           =   6765
      _ExtentX        =   11933
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaImputacion"
      Height          =   330
      Index           =   0
      Left            =   4455
      TabIndex        =   24
      Top             =   1755
      Visible         =   0   'False
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Enabled         =   0   'False
      Format          =   64552961
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdDetalleObraDestino"
      Height          =   315
      Index           =   6
      Left            =   8955
      TabIndex        =   25
      Tag             =   "ObraDestinos"
      Top             =   1305
      Width           =   1725
      _ExtentX        =   3043
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdDetalleObraDestino"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Partida :"
      Height          =   300
      Index           =   0
      Left            =   135
      TabIndex        =   43
      Top             =   945
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   135
      TabIndex        =   42
      Top             =   1350
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   2
      Left            =   135
      TabIndex        =   41
      Top             =   540
      Width           =   1815
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "X"
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
      Index           =   0
      Left            =   5490
      TabIndex        =   40
      Top             =   1380
      Width           =   285
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   5
      Left            =   135
      TabIndex        =   39
      Top             =   2520
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Buscar :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   14
      Left            =   7425
      TabIndex        =   38
      Top             =   225
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Adjuntos ? :"
      Height          =   300
      Index           =   12
      Left            =   135
      TabIndex        =   37
      Top             =   1755
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ubicacion :"
      Height          =   255
      Index           =   16
      Left            =   3375
      TabIndex        =   36
      Top             =   990
      Width           =   915
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obra :"
      Height          =   255
      Index           =   15
      Left            =   8325
      TabIndex        =   35
      Top             =   990
      Width           =   555
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de articulo :"
      Height          =   300
      Index           =   4
      Left            =   135
      TabIndex        =   34
      Top             =   135
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Stock actual :"
      Height          =   300
      Index           =   6
      Left            =   4275
      TabIndex        =   33
      Top             =   135
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Conversion a Pesos :"
      Height          =   240
      Index           =   21
      Left            =   5805
      TabIndex        =   32
      Top             =   2160
      Width           =   1530
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cotizacion dolar :"
      Height          =   240
      Index           =   20
      Left            =   8415
      TabIndex        =   31
      Top             =   2160
      Width           =   1260
   End
   Begin VB.Label lblLabels 
      Caption         =   "Moneda :"
      Height          =   240
      Index           =   19
      Left            =   3285
      TabIndex        =   30
      Top             =   2160
      Width           =   735
   End
   Begin VB.Label lblLabels 
      Caption         =   "Costo unitario :"
      Height          =   300
      Index           =   18
      Left            =   135
      TabIndex        =   29
      Top             =   2130
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Equipo destino (opc.) :"
      Height          =   300
      Index           =   1
      Left            =   135
      TabIndex        =   28
      Top             =   3600
      Width           =   1815
   End
   Begin VB.Label lblFechaImputacion 
      AutoSize        =   -1  'True
      Caption         =   "Fecha imputacion :"
      Height          =   240
      Left            =   3015
      TabIndex        =   27
      Top             =   1800
      Visible         =   0   'False
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Destino :"
      Height          =   255
      Index           =   22
      Left            =   8325
      TabIndex        =   26
      Top             =   1350
      Width           =   555
   End
End
Attribute VB_Name = "frmDetSalidasMaterialesSAT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetSalidaMaterialesSAT
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oSalidaMateriales As ComPronto.SalidaMaterialesSAT
Private mvarIdUnidad As Integer, mOk As Integer, mTipoSalida As Integer
Private mvarIdUnidadCU As Integer
Private mvarCantidadUnidades As Double
Public mvarCantidadAdicional As Double
Public Aceptado As Boolean, mOTsMantenimiento As Boolean, mExigirOT As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long, mvarIdMonedaPesos As Long
Private mvarIdMonedaDolar As Long, mvarIdControlCalidadStandar As Long, mvarIdObra As Long
Private mvarPathAdjuntos As String, mDescargaPorKit As String, mCostoATomar As String
Private mvarFechaImputacionActiva As String, mvarExigirEquipoDestino As String
Private mvarParaMantenimiento As String, mvarBasePRONTOMantenimiento As String

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Me.Hide
   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim dtp As DTPicker
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim i As Integer
   Dim mLimitarUbicaciones As Boolean

   Set oAp = Aplicacion
   
   mvarId = vnewvalue
   mExigirOT = False
   
   Set origen = oSalidaMateriales.DetSalidasMaterialesSAT.Item(vnewvalue)
   Me.IdNuevo = origen.Id
   
   If glbParametrizacionNivel1 Or BuscarClaveINI("Ocultar costo en salida de materiales") = "SI" Then
      lblLabels(18).Visible = False
      txtCostoUnitario.Visible = False
      lblLabels(19).Visible = False
      dcfields(3).Visible = False
      lblLabels(21).Visible = False
      txtCotizacionMoneda.Visible = False
      lblLabels(20).Visible = False
      txtCotizacionDolar.Visible = False
      lblLabels(1).Visible = False
      If glbParametrizacionNivel1 Then
         txtCodigoArticulo1.Visible = False
         DataCombo1(4).Visible = False
      End If
   End If
   
   mDescargaPorKit = BuscarClaveINI("Mover stock por kit")
   If mDescargaPorKit = "" Then mDescargaPorKit = "NO"
   
   mCostoATomar = BuscarClaveINI("Costo para salida de materiales")
   If mCostoATomar = "" Then mCostoATomar = "CostoReposicion"
   
   mvarFechaImputacionActiva = BuscarClaveINI("Activar fecha de imputacion en salida de materiales")
   If mvarFechaImputacionActiva = "" Then mvarFechaImputacionActiva = "NO"
   If mvarFechaImputacionActiva = "SI" Then
      DTFields(0).Visible = True
      lblFechaImputacion.Visible = True
   End If
   
   mvarExigirEquipoDestino = BuscarClaveINI("Exigir equipo destino en salida de materiales")
   If mvarExigirEquipoDestino = "" Then mvarExigirEquipoDestino = "NO"
   
   mOTsMantenimiento = False
   If BuscarClaveINI("OTs desde Mantenimiento") = "SI" Then mOTsMantenimiento = True
   
   If BuscarClaveINI("Inhabilitar ubicaciones en movimientos de stock") = "SI" Then
      lblLabels(16).Visible = False
      DataCombo1(2).Visible = False
   End If
   
   mLimitarUbicaciones = False
   If BuscarClaveINI("Limitar ubicaciones en movimientos de stock") = "SI" Then
      mLimitarUbicaciones = True
   End If
   
   Set oPar = oAp.Parametros.Item(1)
   With oPar.Registro
      mvarIdUnidadCU = IIf(IsNull(.Fields("IdUnidadPorUnidad").Value), 0, .Fields("IdUnidadPorUnidad").Value)
      mvarIdMonedaPesos = IIf(IsNull(.Fields("IdMoneda").Value), 1, .Fields("IdMoneda").Value)
      mvarIdMonedaDolar = IIf(IsNull(.Fields("IdMonedaDolar").Value), 2, .Fields("IdMonedaDolar").Value)
      mvarBasePRONTOMantenimiento = IIf(IsNull(.Fields("BasePRONTOMantenimiento").Value), "", .Fields("BasePRONTOMantenimiento").Value)
   End With
   Set oPar = Nothing
   
   mvarIdUnidad = mvarIdUnidadCU
   mvarCantidadAdicional = 0
   
   If glbIdObraAsignadaUsuario > 0 Then
      mvarIdObra = glbIdObraAsignadaUsuario
   ElseIf Not IsNull(oSalidaMateriales.Registro.Fields("IdObra").Value) Then
      mvarIdObra = oSalidaMateriales.Registro.Fields("IdObra").Value
   Else
      mvarIdObra = 0
   End If
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Ubicaciones" And mLimitarUbicaciones And _
                     glbIdObraAsignadaUsuario > 0 Then
                  Set oControl.RowSource = oAp.Ubicaciones.TraerFiltrado("_PorObra", glbIdObraAsignadaUsuario)
               ElseIf oControl.Tag = "Articulos1" Then
                  If mvarIdObra > 0 Then
                     Set oControl.RowSource = oAp.Articulos.TraerFiltrado("_BD_ProntoMantenimientoTodos", mvarIdObra)
                  Else
                     Set oControl.RowSource = oAp.CargarLista("Articulos")
                  End If
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
         
         If mvarId > 0 And Not glbAdministrador And _
               (TypeOf oControl Is DataCombo Or TypeOf oControl Is TextBox) Then
            oControl.Locked = True
         End If
      Next
   End With
   
   If mvarId = -1 Then
      With origen.Registro
         .Fields("Adjunto").Value = "NO"
         .Fields("Observaciones").Value = " "
         .Fields("IdObra").Value = oSalidaMateriales.Registro.Fields("IdObra").Value
         .Fields("IdMoneda").Value = mvarIdMonedaPesos
      End With
      txtCotizacionDolar.Text = Cotizacion(Date, glbIdMonedaDolar)
      If mDescargaPorKit = "SI" Then Option1.Value = True
      If mvarFechaImputacionActiva = "SI" Then DTFields(0).Value = Date
   Else
      With origen.Registro
         If Not IsNull(.Fields("IdUnidad").Value) Then
            DataCombo1(0).Locked = False
         End If
         txtCotizacionDolar.Text = IIf(IsNull(.Fields("CotizacionDolar").Value), 0, .Fields("CotizacionDolar").Value)
         txtCotizacionMoneda.Text = IIf(IsNull(.Fields("CotizacionMoneda").Value), 1, .Fields("CotizacionMoneda").Value)
         If mDescargaPorKit = "SI" Then
            If IIf(IsNull(.Fields("DescargaPorKit").Value), "NO", .Fields("DescargaPorKit").Value) = "NO" Then
               Option1.Value = True
            Else
               Option2.Value = True
            End If
         End If
         If IsNull(.Fields("FechaImputacion").Value) Then
            DTFields(0).Value = Date
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
         If mvarIdObra > 0 And Not IsNull(.Fields("IdEquipoDestino").Value) And _
               Len(mvarBasePRONTOMantenimiento) > 0 Then
            Set oRs = oAp.Articulos.TraerFiltrado("_PorId", .Fields("IdEquipoDestino").Value)
            If oRs.RecordCount > 0 Then
               With Text1
                  .Top = DataCombo1(4).Top
                  .Left = DataCombo1(4).Left
                  .Width = DataCombo1(4).Width
                  .Text = oRs.Fields("Descripcion").Value
                  .Enabled = False
                  .Visible = True
               End With
               With txtCodigoArticulo1
                  .Text = oRs.Fields("NumeroInventario").Value
                  .Enabled = False
               End With
               DataCombo1(4).Visible = False
            End If
            oRs.Close
         End If
      End With
   End If

   Set oRs = Nothing
   Set oAp = Nothing
   
   MuestraAdjuntos
   
   If mDescargaPorKit = "NO" Then Frame1.Visible = False
   
   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then
      DataCombo1(0).Enabled = False
   End If
   
End Property

Public Property Get SalidaMaterialesSAT() As ComPronto.SalidaMaterialesSAT

   Set SalidaMaterialesSAT = oSalidaMateriales

End Property

Public Property Set SalidaMaterialesSAT(ByVal vnewvalue As ComPronto.SalidaMaterialesSAT)

   Set oSalidaMateriales = vnewvalue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   Dim oRs As ADOR.Recordset
            
   Select Case Index
      Case 1
         If IsNumeric(DataCombo1(Index).BoundText) Then
            mvarParaMantenimiento = "NO"
            mExigirOT = False
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(1).BoundText)
            With origen.Registro
               .Fields("IdArticulo").Value = DataCombo1(1).BoundText
               If oRs.RecordCount > 0 Then
                  If Not IsNull(oRs.Fields("IdCuantificacion").Value) Then
                     If Not IsNull(oRs.Fields("Unidad11").Value) Then
                        txtUnidad.Text = Aplicacion.Unidades.Item(oRs.Fields("Unidad11").Value).Registro.Fields("Descripcion").Value
                        mvarIdUnidad = oRs.Fields("Unidad11").Value
                     End If
                     Select Case oRs.Fields("IdCuantificacion").Value
                        Case 1
                           txtCantidad1.Visible = False
                           txtCantidad2.Visible = False
                           Label1(0).Visible = False
                           txtUnidad.Visible = False
                        Case 2
                           txtCantidad1.Visible = True
                           txtCantidad2.Visible = False
                           Label1(0).Visible = False
                           txtUnidad.Visible = True
                           If mvarId = -1 Then
                              .Fields("Cantidad1").Value = oRs.Fields("Largo").Value
                           End If
                        Case 3
                           If mvarId = -1 Then
                              txtCantidad1.Visible = True
                              txtCantidad2.Visible = True
                              Label1(0).Visible = True
                              txtUnidad.Visible = True
                              .Fields("Cantidad1").Value = oRs.Fields("Ancho").Value
                              .Fields("Cantidad2").Value = oRs.Fields("Largo").Value
                           End If
                     End Select
                  End If
                  txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
                  txtStockActual.Text = Aplicacion.StockPorIdArticulo(DataCombo1(1).BoundText)
               End If
            End With
            oRs.Close
            
            If mDescargaPorKit = "SI" Then
               Set oRs = Aplicacion.Conjuntos.TraerFiltrado("_DetallesPorIdArticulo", DataCombo1(1).BoundText)
               If oRs.RecordCount > 0 Then
                  Frame1.Enabled = True
               Else
                  Option1.Value = True
                  Frame1.Enabled = False
               End If
               oRs.Close
            End If
         End If
   End Select
      
   Set oRs = Nothing

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub dcfields_Change(Index As Integer)

   If Len(dcfields(Index).BoundText) = 0 Or Not IsNumeric(dcfields(Index).BoundText) Then Exit Sub
   origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
   Select Case Index
      Case 3
         If dcfields(Index).BoundText = mvarIdMonedaPesos Then
            txtCotizacionMoneda.Text = 1
         Else
            Dim oRs As ADOR.Recordset
            Set oRs = Aplicacion.Cotizaciones.TraerFiltrado("_PorFechaMoneda", Array(Date, dcfields(Index).BoundText))
            If oRs.RecordCount > 0 Then
               txtCotizacionMoneda.Text = oRs.Fields("CotizacionLibre").Value
            Else
               MsgBox "No hay cotizacion, ingresela manualmente"
               txtCotizacionMoneda.Text = ""
            End If
            oRs.Close
            Set oRs = Nothing
         End If
   End Select
   
End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   ReemplazarEtiquetas Me

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oBind = Nothing
   Set origen = Nothing
   Set oSalidaMateriales = Nothing

End Sub

Private Sub Form_Activate()

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   If mvarId <> -1 Then
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", origen.Registro.Fields("IdArticulo").Value)
      If oRs.RecordCount > 0 Then
         If Not IsNull(oRs.Fields("IdCuantificacion").Value) Then
            Select Case oRs.Fields("IdCuantificacion").Value
               Case 1
                  txtCantidad1.Visible = False
                  txtCantidad2.Visible = False
                  Label1(0).Visible = False
                  txtUnidad.Visible = False
               Case 2
                  txtCantidad2.Visible = False
                  Label1(0).Visible = False
            End Select
'            If Not IsNull(oRs.Fields("Unidad11").Value) Then
'               oRs.Close
'               Set oRs = Aplicacion.Unidades.TraerFiltrado("_PorId", oRs.Fields("Unidad11").Value)
'               If oRs.RecordCount > 0 Then
'                  txtUnidad.Text = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
'               End If
'            End If
         End If
      End If
      oRs.Close
   End If
   
   Set oRs = Nothing
   
End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vnewvalue As Variant)

   mvarIdNuevo = vnewvalue

End Property

Public Property Let TipoSalida(ByVal vnewvalue As Integer)

   mTipoSalida = vnewvalue

End Property

Private Sub MuestraAdjuntos()

End Sub
