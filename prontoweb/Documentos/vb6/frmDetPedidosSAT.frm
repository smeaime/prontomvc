VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetPedidosSAT 
   Caption         =   "Item de Pedido SAT"
   ClientHeight    =   5250
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10920
   LinkTopic       =   "Form1"
   ScaleHeight     =   5250
   ScaleWidth      =   10920
   StartUpPosition =   2  'CenterScreen
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
      Left            =   7335
      TabIndex        =   23
      Top             =   1635
      Width           =   2085
   End
   Begin VB.TextBox txtCantidad1 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad1"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   1
      EndProperty
      Height          =   315
      Left            =   5130
      TabIndex        =   22
      Top             =   1635
      Width           =   870
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
      Left            =   2115
      TabIndex        =   21
      Top             =   1635
      Width           =   870
   End
   Begin VB.TextBox txtCantidad2 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad2"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   1
      EndProperty
      Height          =   315
      Left            =   6435
      TabIndex        =   20
      Top             =   1635
      Width           =   870
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
      Left            =   7740
      TabIndex        =   19
      Top             =   495
      Width           =   2985
   End
   Begin VB.TextBox txtItem 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroItem"
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
      Height          =   360
      Left            =   2115
      TabIndex        =   18
      Top             =   105
      Width           =   645
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   525
      Index           =   0
      Left            =   135
      TabIndex        =   17
      Top             =   4545
      Width           =   945
   End
   Begin VB.TextBox txtNumeroItemRequerimiento 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroItemRequerimiento"
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
      Height          =   360
      Left            =   8955
      Locked          =   -1  'True
      TabIndex        =   16
      Top             =   90
      Width           =   465
   End
   Begin VB.TextBox txtNumeroRequerimiento 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroRequerimiento"
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
      Height          =   360
      Left            =   7740
      Locked          =   -1  'True
      TabIndex        =   15
      Top             =   90
      Width           =   1140
   End
   Begin VB.TextBox txtPrecio 
      Alignment       =   1  'Right Justify
      DataField       =   "Precio"
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
      Left            =   2115
      TabIndex        =   14
      Top             =   2340
      Width           =   1230
   End
   Begin VB.Frame Frame1 
      Caption         =   "Tomar la descripcion de : "
      Height          =   1320
      Left            =   8235
      TabIndex        =   9
      Top             =   2025
      Width           =   2490
      Begin VB.OptionButton Option3 
         Caption         =   "Material mas observaciones"
         Height          =   195
         Left            =   135
         TabIndex        =   12
         Top             =   990
         Width           =   2265
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Solo el material"
         Height          =   195
         Left            =   135
         TabIndex        =   11
         Top             =   360
         Width           =   1410
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Solo las observaciones"
         Height          =   195
         Left            =   135
         TabIndex        =   10
         Top             =   675
         Width           =   2040
      End
   End
   Begin VB.TextBox txtNumeroObra 
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
      Height          =   360
      Left            =   2115
      TabIndex        =   8
      Top             =   495
      Width           =   1410
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Activar"
      Height          =   360
      Index           =   4
      Left            =   7200
      TabIndex        =   7
      Top             =   2700
      Width           =   990
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Desactivar"
      Height          =   360
      Index           =   3
      Left            =   3420
      TabIndex        =   6
      Top             =   2700
      Width           =   990
   End
   Begin VB.TextBox txtPorcentajeBonificacion 
      Alignment       =   1  'Right Justify
      DataField       =   "PorcentajeBonificacion"
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
      Left            =   4320
      TabIndex        =   5
      Top             =   2340
      Width           =   600
   End
   Begin VB.TextBox txtPorcentajeIVA 
      Alignment       =   1  'Right Justify
      DataField       =   "PorcentajeIVA"
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
      Left            =   5715
      TabIndex        =   4
      Top             =   2340
      Width           =   600
   End
   Begin VB.TextBox txtImporteTotalItem 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteTotalItem"
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
      Left            =   7110
      TabIndex        =   3
      Top             =   2340
      Width           =   1050
   End
   Begin VB.TextBox txtCodigoArticulo 
      Alignment       =   1  'Right Justify
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
      Left            =   2115
      TabIndex        =   2
      Top             =   900
      Width           =   1410
   End
   Begin VB.TextBox txtCliente 
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
      Height          =   360
      Left            =   4275
      TabIndex        =   1
      Top             =   495
      Width           =   2490
   End
   Begin VB.TextBox txtCosto 
      Alignment       =   1  'Right Justify
      DataField       =   "Costo"
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
      Left            =   7110
      TabIndex        =   0
      Top             =   1980
      Width           =   1050
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1320
      Left            =   2115
      TabIndex        =   13
      Top             =   3825
      Width           =   8655
      _ExtentX        =   15266
      _ExtentY        =   2328
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmDetPedidosSAT.frx":0000
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   3555
      TabIndex        =   24
      Tag             =   "Articulos"
      Top             =   900
      Width           =   7215
      _ExtentX        =   12726
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   0
      Left            =   3015
      TabIndex        =   25
      Tag             =   "Unidades"
      Top             =   1635
      Width           =   2040
      _ExtentX        =   3598
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdControlCalidad"
      Height          =   315
      Index           =   4
      Left            =   2115
      TabIndex        =   26
      Tag             =   "ControlesCalidad"
      Top             =   1995
      Width           =   4200
      _ExtentX        =   7408
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdControlCalidad"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaEntrega"
      Height          =   360
      Index           =   0
      Left            =   2115
      TabIndex        =   27
      Top             =   2700
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   635
      _Version        =   393216
      Format          =   63897601
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "Adjunto"
      Height          =   315
      Index           =   5
      Left            =   2115
      TabIndex        =   28
      Tag             =   "SiNo"
      Top             =   3105
      Width           =   780
      _ExtentX        =   1376
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "SiNo"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaNecesidad"
      Height          =   360
      Index           =   1
      Left            =   5940
      TabIndex        =   29
      Top             =   2700
      Width           =   1260
      _ExtentX        =   2223
      _ExtentY        =   635
      _Version        =   393216
      Enabled         =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   63897601
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   2
      Left            =   2115
      TabIndex        =   30
      Tag             =   "Cuentas"
      Top             =   1260
      Visible         =   0   'False
      Width           =   8655
      _ExtentX        =   15266
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCentroCosto"
      Height          =   315
      Index           =   3
      Left            =   4455
      TabIndex        =   31
      Tag             =   "CentrosCosto"
      Top             =   3105
      Visible         =   0   'False
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCentroCosto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   6
      Left            =   2115
      TabIndex        =   32
      Tag             =   "PlazosEntrega"
      Top             =   3465
      Width           =   8655
      _ExtentX        =   15266
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPlazoEntrega"
      Text            =   ""
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
      Left            =   6075
      TabIndex        =   53
      Top             =   1680
      Width           =   285
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
      Height          =   300
      Index           =   14
      Left            =   6840
      TabIndex        =   52
      Top             =   540
      Width           =   825
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de item :"
      Height          =   300
      Index           =   3
      Left            =   135
      TabIndex        =   51
      Top             =   150
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   135
      TabIndex        =   50
      Top             =   1635
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   2
      Left            =   135
      TabIndex        =   49
      Top             =   915
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Control de calidad :"
      Height          =   300
      Index           =   11
      Left            =   135
      TabIndex        =   48
      Top             =   2010
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero RM - item :"
      Height          =   300
      Index           =   1
      Left            =   6255
      TabIndex        =   47
      Top             =   135
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Precio unitario :"
      Height          =   300
      Index           =   4
      Left            =   135
      TabIndex        =   46
      Top             =   2370
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   255
      Index           =   5
      Left            =   135
      TabIndex        =   45
      Top             =   3870
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de entrega :"
      Height          =   300
      Index           =   6
      Left            =   135
      TabIndex        =   44
      Top             =   2745
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Adjunto ? :"
      Height          =   300
      Index           =   12
      Left            =   135
      TabIndex        =   43
      Top             =   3105
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha necesidad :"
      Height          =   300
      Index           =   8
      Left            =   4545
      TabIndex        =   42
      Top             =   2745
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta contable :"
      Height          =   255
      Index           =   9
      Left            =   135
      TabIndex        =   41
      Top             =   1305
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de obra :"
      Height          =   300
      Index           =   10
      Left            =   135
      TabIndex        =   40
      Top             =   540
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Centro de costo :"
      Height          =   300
      Index           =   13
      Left            =   3060
      TabIndex        =   39
      Top             =   3120
      Visible         =   0   'False
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Bonif. [%] :"
      Height          =   255
      Index           =   15
      Left            =   3420
      TabIndex        =   38
      Top             =   2370
      Width           =   825
   End
   Begin VB.Label lblLabels 
      Caption         =   "IVA [%] :"
      Height          =   255
      Index           =   16
      Left            =   4995
      TabIndex        =   37
      Top             =   2370
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "TOTAL :"
      Height          =   255
      Index           =   17
      Left            =   6390
      TabIndex        =   36
      Top             =   2370
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cliente :"
      Height          =   300
      Index           =   18
      Left            =   3600
      TabIndex        =   35
      Top             =   540
      Width           =   600
   End
   Begin VB.Label lblLabels 
      Caption         =   "Costo :"
      Height          =   255
      Index           =   19
      Left            =   6390
      TabIndex        =   34
      Top             =   2010
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "Plazo de entrega :"
      Height          =   300
      Index           =   20
      Left            =   135
      TabIndex        =   33
      Top             =   3465
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetPedidosSAT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetPedidoSAT
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oPedido As ComPronto.PedidoSAT
Public Aceptado As Boolean
Private mvarIdUnidadCU As Integer, mTipoIva As Integer, mCondicionIva As Integer
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long
Private mvarIdControlCalidadStandar As Long
Private mvarCantidadAdicional As Double, mvarCantidadUnidades As Double
Private mPorcentajeIVA As Double, mvarP_IVA1 As Double, mvarP_IVA2 As Double
Private mvarPathAdjuntos As String, mExterior As String, mTipoCosto As String

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Me.Hide
   
   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim dtp As DTPicker
   Dim oControl As Control
   Dim i As Integer
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim oRsObra As ADOR.Recordset

   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   
   Set origen = oPedido.DetPedidosSAT.Item(vnewvalue)
   Me.IdNuevo = origen.Id
   
   Set oBind = New BindingCollection
   
   mTipoCosto = BuscarClaveINI("CostoStandarParaPedidos")
   If mTipoCosto = "" Then mTipoCosto = "CostoPPP"
   
   Set oPar = oAp.Parametros.Item(1)
   With oPar.Registro
      mvarIdUnidadCU = .Fields("IdUnidadPorUnidad").Value
      mvarPathAdjuntos = .Fields("PathAdjuntos").Value
      mvarP_IVA1 = .Fields("Iva1").Value
      mvarP_IVA2 = .Fields("Iva2").Value
      mvarIdControlCalidadStandar = .Fields("IdControlCalidadStandar").Value
   End With
   Set oPar = Nothing
   
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DTPicker Then
            If Len(oControl.DataField) Then .Add oControl, "value", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   If mvarId = -1 Then
   Else
      With origen.Registro
         If mvarId <= 0 And Not IsNull(.Fields("Observaciones").Value) And _
               Len(.Fields("Observaciones").Value) > 5 And _
               BuscarClaveINI("OrigenDescripcion en 3 cuando hay observaciones") = "SI" Then
            .Fields("OrigenDescripcion").Value = 3
         End If
         If Not IsNull(.Fields("OrigenDescripcion").Value) Then
            Select Case .Fields("OrigenDescripcion").Value
               Case 1
                  Option1.Value = True
               Case 2
                  Option2.Value = True
               Case 3
                  Option3.Value = True
            End Select
         Else
            Option1.Value = True
         End If
         If IsNull(.Fields("PorcentajeIVA").Value) And mExterior <> "SI" Then
            .Fields("PorcentajeIVA").Value = mPorcentajeIVA
         End If
         If Not IsNull(.Fields("PlazoEntrega").Value) Then
            DataCombo1(6).Text = .Fields("PlazoEntrega").Value
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
   End If
   
   With origen.Registro
      If Not IsNull(.Fields("IdDetalleRequerimiento").Value) Then
         Set oRs = oAp.TablasGenerales.TraerFiltrado("DetRequerimientos", "_UnItem", .Fields("IdDetalleRequerimiento").Value)
         If oRs.RecordCount > 0 Then
            txtNumeroItemRequerimiento.Text = oRs.Fields("NumeroItem").Value
            txtNumeroRequerimiento.Text = oAp.Requerimientos.Item(oRs.Fields("IdRequerimiento").Value).Registro.Fields("NumeroRequerimiento").Value
         End If
         oRs.Close
         Set oRsObra = oAp.Requerimientos.TraerFiltrado("_DatosObra", .Fields("IdDetalleRequerimiento").Value)
         If Not IsNull(oRsObra.Fields("Obra").Value) Then
            txtNumeroObra.Text = oRsObra.Fields("Obra").Value
         End If
         If Not IsNull(oRsObra.Fields("Cliente").Value) Then
            txtCliente.Text = oRsObra.Fields("Cliente").Value
         End If
         oRsObra.Close
      Else
         If Not IsNull(.Fields("IdDetalleLMateriales").Value) Then
            Set oRsObra = oAp.TablasGenerales.TraerFiltrado("LMateriales", "_DatosObra", .Fields("IdDetalleLMateriales").Value)
            If Not IsNull(oRsObra.Fields("Obra").Value) Then
               txtNumeroObra.Text = oRsObra.Fields("Obra").Value
            End If
            oRsObra.Close
         End If
      End If
   End With
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   CalcularItem
   
   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then
      DataCombo1(0).Enabled = False
   End If
   
End Property

Public Property Get PedidoSAT() As ComPronto.PedidoSAT

   Set PedidoSAT = oPedido

End Property

Public Property Set PedidoSAT(ByVal vnewvalue As ComPronto.PedidoSAT)

   Set oPedido = vnewvalue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   Select Case Index
      
      Case 1
      
         If IsNumeric(DataCombo1(1).BoundText) Then
         
            Dim oRs As ADOR.Recordset
            Dim oRs1 As ADOR.Recordset
            Dim oArt As ComPronto.Articulo
            
            Me.MousePointer = vbHourglass
            
            If mvarId < 0 And BuscarClaveINI("IdArticuloVarios") = DataCombo1(1).BoundText Then
               Option2.Value = True
            End If
            
            Set oArt = Aplicacion.Articulos.Item(DataCombo1(1).BoundText)
            Set oRs = oArt.Registro
         
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  If mvarId = -1 Or IsNull(.Fields("IdUnidad").Value) Then
                     If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                        .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     Else
                        .Fields("IdUnidad").Value = mvarIdUnidadCU
                     End If
                  End If
                  If mvarId = -1 Then
                     If IsNull(.Fields("Observaciones").Value) Then
                        .Fields("Observaciones").Value = oArt.CadenaSubitems
                     Else
                        .Fields("Observaciones").Value = .Fields("Observaciones").Value & vbCrLf & oArt.CadenaSubitems
                     End If
                  End If
                  If mTipoCosto = "CostoPPP" Then
                     .Fields("Costo").Value = oRs.Fields("CostoPPP").Value
                  Else
                     .Fields("Costo").Value = oRs.Fields("CostoReposicion").Value
                  End If
               End With
               If Not IsNull(oRs.Fields("IdCuantificacion").Value) Then
                  If Not IsNull(oRs.Fields("Unidad11").Value) Then
                     txtUnidad.Text = Aplicacion.Unidades.Item(oRs.Fields("Unidad11").Value).Registro.Fields("Descripcion").Value
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
                           origen.Registro.Fields("Cantidad1").Value = oRs.Fields("Largo").Value
                        End If
                     Case 3
                        If mvarId = -1 Then
                           txtCantidad1.Visible = True
                           txtCantidad2.Visible = True
                           Label1(0).Visible = True
                           txtUnidad.Visible = True
                           origen.Registro.Fields("Cantidad1").Value = oRs.Fields("Ancho").Value
                           origen.Registro.Fields("Cantidad2").Value = oRs.Fields("Largo").Value
                        End If
                  End Select
               End If
               If Not IsNull(oRs.Fields("IdCuenta").Value) And mvarId = -1 Then
                  origen.Registro.Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
               End If
               If (mvarId = -1 Or IsNull(origen.Registro.Fields("PorcentajeIVA").Value)) And _
                     Not IsNull(oRs.Fields("AlicuotaIVA").Value) And mExterior <> "SI" Then
                  origen.Registro.Fields("PorcentajeIVA").Value = oRs.Fields("AlicuotaIVA").Value
               End If
               txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
            End If
            
            oRs.Close
            Set oRs = Nothing
            Set oRs1 = Nothing
            Set oArt = Nothing
            
            Me.MousePointer = vbDefault
            
         End If
      
   End Select
      
End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Activate()

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   Set oAp = Aplicacion
   
   If mvarId <> -1 Then
      txtItem.Enabled = False
      Set oRs = oAp.Articulos.Item(origen.Registro.Fields("IdArticulo").Value).Registro
      If oRs.RecordCount > 0 Then
         If Not IsNull(oRs.Fields("IdCuantificacion").Value) Then
            If Not IsNull(oRs.Fields("Unidad11").Value) Then
               txtUnidad.Text = oAp.Unidades.Item(oRs.Fields("Unidad11").Value).Registro.Fields("Descripcion").Value
            End If
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
         End If
      End If
      oRs.Close
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
End Sub

Private Sub Form_Load()

   ReemplazarEtiquetas Me

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oBind = Nothing
   Set origen = Nothing
   Set oPedido = Nothing

End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      origen.Registro.Fields("OrigenDescripcion").Value = 1
   End If
   
End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      origen.Registro.Fields("OrigenDescripcion").Value = 2
   End If
   
End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      origen.Registro.Fields("OrigenDescripcion").Value = 3
   End If
   
End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vnewvalue As Variant)

   mvarIdNuevo = vnewvalue

End Property

Private Sub CalcularItem()

   Dim mImporte As Double, mBonificacion As Double, mIVA As Double
   
   With origen.Registro
      mImporte = 0
      mBonificacion = 0
      mIVA = 0
      If IsNumeric(txtPrecio.Text) And IsNumeric(txtCantidad.Text) Then
         mImporte = Val(txtPrecio.Text) * Val(txtCantidad.Text)
      End If
      If IsNumeric(txtPorcentajeBonificacion.Text) Then
         mBonificacion = Round(mImporte * Val(txtPorcentajeBonificacion.Text) / 100, 4)
      End If
      If IsNumeric(txtPorcentajeIVA.Text) Then
         mIVA = Round((mImporte - mBonificacion) * Val(txtPorcentajeIVA.Text) / 100, 4)
      End If
      mImporte = mImporte - mBonificacion + mIVA
      .Fields("ImporteTotalItem").Value = mImporte
      .Fields("ImporteBonificacion").Value = mBonificacion
      .Fields("ImporteIVA").Value = mIVA
   End With

End Sub

Public Property Let TipoIVA(ByVal vnewvalue As Integer)

   mTipoIva = vnewvalue
   
End Property

Public Property Let CondicionIva(ByVal vnewvalue As Integer)

   mCondicionIva = vnewvalue
   
End Property

Public Property Let Exterior(ByVal vnewvalue As String)

   mExterior = vnewvalue
   
End Property
