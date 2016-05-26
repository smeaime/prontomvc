VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{126E538A-EE41-4B22-A045-F8D5538F5D2B}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmDetLMateriales 
   Caption         =   "Item de lista de materiales :"
   ClientHeight    =   7545
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10800
   Icon            =   "frmDetLMateriales.frx":0000
   LinkTopic       =   "Form1"
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   7545
   ScaleWidth      =   10800
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtCodigoArticulo 
      Alignment       =   1  'Right Justify
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
      Left            =   2160
      TabIndex        =   0
      Top             =   1035
      Width           =   1455
   End
   Begin VB.TextBox txtCostoReposicion 
      Alignment       =   1  'Right Justify
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
      Left            =   9720
      TabIndex        =   63
      Top             =   1755
      Width           =   915
   End
   Begin VB.TextBox txtCostoPPP 
      Alignment       =   1  'Right Justify
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
      Left            =   7695
      TabIndex        =   61
      Top             =   1755
      Width           =   915
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Registrar material"
      Height          =   405
      Index           =   4
      Left            =   9180
      TabIndex        =   60
      Top             =   4545
      Width           =   1485
   End
   Begin VB.TextBox txtDescripcionManual 
      DataField       =   "DescripcionManual"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   9945
      TabIndex        =   59
      Top             =   2115
      Visible         =   0   'False
      Width           =   870
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Activar"
      Height          =   315
      Index           =   3
      Left            =   6705
      TabIndex        =   38
      Top             =   2115
      Width           =   765
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
      Left            =   7380
      TabIndex        =   6
      Top             =   1395
      Width           =   3255
   End
   Begin VB.TextBox txtNumeroItemAcopio 
      Alignment       =   1  'Right Justify
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
      Left            =   4995
      Locked          =   -1  'True
      TabIndex        =   32
      Top             =   630
      Visible         =   0   'False
      Width           =   690
   End
   Begin VB.TextBox txtNumeroAcopio 
      Alignment       =   1  'Right Justify
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
      Left            =   2160
      Locked          =   -1  'True
      TabIndex        =   30
      Top             =   630
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Buscar en acopios"
      Height          =   405
      Index           =   2
      Left            =   9180
      TabIndex        =   16
      Top             =   4095
      Visible         =   0   'False
      Width           =   1485
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
      Left            =   5175
      TabIndex        =   4
      Top             =   1395
      Width           =   870
   End
   Begin VB.TextBox txtPeso 
      Alignment       =   1  'Right Justify
      DataField       =   "Peso"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   1
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   2160
      TabIndex        =   7
      Top             =   1755
      Width           =   1320
   End
   Begin VB.TextBox txtCantidad 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
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
      Left            =   2160
      TabIndex        =   2
      Top             =   1395
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
      Left            =   6480
      TabIndex        =   5
      Top             =   1395
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
      Left            =   8775
      TabIndex        =   27
      Top             =   630
      Width           =   1860
   End
   Begin VB.TextBox txtNumeroOrden 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroOrden"
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
      Left            =   4995
      TabIndex        =   18
      Top             =   180
      Width           =   690
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
      Left            =   2160
      TabIndex        =   17
      Top             =   180
      Width           =   645
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   9180
      TabIndex        =   15
      Top             =   3645
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   9180
      TabIndex        =   14
      Top             =   3195
      Width           =   1485
   End
   Begin VB.TextBox txtRevision 
      DataField       =   "Revision"
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
      Left            =   7785
      TabIndex        =   19
      Top             =   165
      Width           =   1365
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   3645
      TabIndex        =   1
      Tag             =   "Articulos"
      Top             =   1020
      Width           =   6990
      _ExtentX        =   12330
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
      Left            =   3060
      TabIndex        =   3
      Tag             =   "Unidades"
      Top             =   1395
      Width           =   2040
      _ExtentX        =   3598
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUnidadPeso"
      Height          =   315
      Index           =   3
      Left            =   3510
      TabIndex        =   8
      Tag             =   "Unidades"
      Top             =   1755
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdControlCalidad"
      Height          =   315
      Index           =   4
      Left            =   2160
      TabIndex        =   9
      Tag             =   "ControlesCalidad"
      Top             =   2115
      Width           =   4515
      _ExtentX        =   7964
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdControlCalidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdPlano"
      Height          =   315
      Index           =   2
      Left            =   2160
      TabIndex        =   10
      Tag             =   "DefExe1"
      Top             =   2475
      Width           =   4515
      _ExtentX        =   7964
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdPlano"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "Adjunto"
      Height          =   315
      Index           =   5
      Left            =   2160
      TabIndex        =   11
      Tag             =   "SiNo"
      Top             =   2835
      Width           =   780
      _ExtentX        =   1376
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "SiNo"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1770
      Left            =   2160
      TabIndex        =   12
      Top             =   3195
      Width           =   6855
      _ExtentX        =   12091
      _ExtentY        =   3122
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmDetLMateriales.frx":076A
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "Despacha"
      Height          =   315
      Index           =   6
      Left            =   5895
      TabIndex        =   13
      Tag             =   "SiNo"
      Top             =   2835
      Width           =   780
      _ExtentX        =   1376
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "SiNo"
      Text            =   ""
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   1440
      TabIndex        =   39
      Top             =   5310
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   1
      Left            =   1440
      TabIndex        =   40
      Top             =   5715
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   2
      Left            =   1440
      TabIndex        =   41
      Top             =   6120
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   3
      Left            =   1440
      TabIndex        =   42
      Top             =   6525
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   4
      Left            =   1440
      TabIndex        =   43
      Top             =   6930
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   5
      Left            =   7020
      TabIndex        =   44
      Top             =   5310
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   6
      Left            =   7020
      TabIndex        =   45
      Top             =   5715
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   7
      Left            =   7020
      TabIndex        =   46
      Top             =   6120
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   8
      Left            =   7020
      TabIndex        =   47
      Top             =   6525
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   9
      Left            =   7020
      TabIndex        =   48
      Top             =   6930
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdDetalleObraDestino"
      Height          =   315
      Index           =   7
      Left            =   7875
      TabIndex        =   65
      Tag             =   "ObraDestinos"
      Top             =   2475
      Width           =   2760
      _ExtentX        =   4868
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdDetalleObraDestino"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Destino (opc) :"
      Height          =   300
      Index           =   16
      Left            =   6750
      TabIndex        =   66
      Top             =   2460
      Width           =   1050
   End
   Begin VB.Label lblLabels 
      Caption         =   "Costo Rep. :"
      Height          =   300
      Index           =   15
      Left            =   8730
      TabIndex        =   64
      Top             =   1770
      Width           =   915
   End
   Begin VB.Label lblLabels 
      Caption         =   "Costo PPP :"
      Height          =   300
      Index           =   10
      Left            =   6705
      TabIndex        =   62
      Top             =   1770
      Width           =   915
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 10 :"
      Height          =   300
      Index           =   9
      Left            =   5670
      TabIndex        =   58
      Top             =   6975
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 9 :"
      Height          =   300
      Index           =   8
      Left            =   5670
      TabIndex        =   57
      Top             =   6570
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 8 :"
      Height          =   300
      Index           =   7
      Left            =   5670
      TabIndex        =   56
      Top             =   6165
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 7 :"
      Height          =   300
      Index           =   6
      Left            =   5670
      TabIndex        =   55
      Top             =   5760
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 6 :"
      Height          =   300
      Index           =   5
      Left            =   5670
      TabIndex        =   54
      Top             =   5355
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 5 :"
      Height          =   300
      Index           =   4
      Left            =   90
      TabIndex        =   53
      Top             =   6930
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 4 :"
      Height          =   300
      Index           =   3
      Left            =   90
      TabIndex        =   52
      Top             =   6525
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 3 :"
      Height          =   300
      Index           =   2
      Left            =   90
      TabIndex        =   51
      Top             =   6120
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 2 :"
      Height          =   300
      Index           =   1
      Left            =   90
      TabIndex        =   50
      Top             =   5715
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 1 :"
      Height          =   300
      Index           =   0
      Left            =   90
      TabIndex        =   49
      Top             =   5310
      Width           =   1230
   End
   Begin VB.Line Line1 
      BorderWidth     =   3
      X1              =   0
      X2              =   10755
      Y1              =   5130
      Y2              =   5130
   End
   Begin VB.Label lblLabels 
      Caption         =   "Despacha ? :"
      Height          =   300
      Index           =   8
      Left            =   4680
      TabIndex        =   37
      Top             =   2835
      Width           =   1050
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   1
      Left            =   180
      TabIndex        =   36
      Top             =   3240
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Adjunto ? :"
      Height          =   300
      Index           =   12
      Left            =   180
      TabIndex        =   35
      Top             =   2871
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Plano :"
      Height          =   300
      Index           =   6
      Left            =   180
      TabIndex        =   34
      Top             =   2505
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item de acopio :"
      Height          =   300
      Index           =   4
      Left            =   3510
      TabIndex        =   33
      Top             =   675
      Visible         =   0   'False
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero lista de acopio :"
      Height          =   300
      Index           =   0
      Left            =   180
      TabIndex        =   31
      Top             =   675
      Visible         =   0   'False
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
      Left            =   6120
      TabIndex        =   29
      Top             =   1440
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
      Left            =   7830
      TabIndex        =   28
      Top             =   675
      Width           =   825
   End
   Begin VB.Label lblLabels 
      Caption         =   "Posicion :"
      Height          =   300
      Index           =   13
      Left            =   3510
      TabIndex        =   26
      Top             =   195
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Conjunto :"
      Height          =   300
      Index           =   3
      Left            =   180
      TabIndex        =   25
      Top             =   225
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   180
      TabIndex        =   24
      Top             =   1407
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   2
      Left            =   180
      TabIndex        =   23
      Top             =   1041
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Revision :"
      Height          =   255
      Index           =   5
      Left            =   6480
      TabIndex        =   22
      Top             =   225
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "Peso :"
      Height          =   300
      Index           =   9
      Left            =   180
      TabIndex        =   21
      Top             =   1773
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Control de calidad :"
      Height          =   300
      Index           =   11
      Left            =   180
      TabIndex        =   20
      Top             =   2139
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetLMateriales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetLMaterial
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oLMaterial As ComPronto.LMaterial
Private mvarIdUnidadCU As Integer
Private mvarPathAdjuntos As String
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long, mConjuntoApuntado As Long

Private Sub cmd_Click(Index As Integer)

   Dim of1 As frmAutorizacion2
   Dim oRs As ADOR.Recordset
   Dim mvarOK As Boolean
   Dim i As Integer
         
   Select Case Index
      
      Case 0
      
         Dim dc As DataCombo
         
         For Each dc In DataCombo1
            If (dc.Enabled And dc.Visible) Or dc.Index = 0 Then
               If ((dc.Index = 5 Or dc.Index = 6) And Len(Trim(dc.BoundText)) = 0) Or (dc.Index <> 5 And dc.Index <> 6 And Not IsNumeric(dc.BoundText)) Then
                  If dc.Index <> 2 And dc.Index <> 4 And dc.Index <> 7 Then
                     If dc.Tag = "SiNo" Then
                        MsgBox "Falta completar el campo " & dc.DataField, vbCritical
                     Else
                        MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     End If
                     Exit Sub
                  End If
               End If
               If Len(Trim(dc.BoundText)) <> 0 Then
                  origen.Registro.Fields(dc.DataField).Value = dc.BoundText
               End If
            End If
         Next
         
         If IsNull(origen.Registro.Fields("Cantidad").Value) Or origen.Registro.Fields("Cantidad").Value = 0 Then
            MsgBox "Falta ingresar la cantidad (unidades)", vbCritical
            Exit Sub
         End If
         
         If Not DataCombo1(1).Visible Then
            If Len(Trim(txtDescripcionManual.Text)) = 0 Then
               MsgBox "No ingreso la descripcion del material", vbCritical
               Exit Sub
            End If
         End If
         
         If txtCantidad1.Visible And DataCombo1(1).Visible Then
            If IsNull(origen.Registro.Fields("Cantidad1").Value) Or origen.Registro.Fields("Cantidad1").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 1)", vbCritical
               Exit Sub
            End If
         Else
            origen.Registro.Fields("Cantidad1").Value = Null
         End If
         
         If txtCantidad2.Visible And DataCombo1(1).Visible Then
            If IsNull(origen.Registro.Fields("Cantidad2").Value) Or origen.Registro.Fields("Cantidad2").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 2)", vbCritical
               Exit Sub
            End If
         Else
            origen.Registro.Fields("Cantidad2").Value = Null
         End If
         
         With origen.Registro
            For i = 0 To 9
               If FileBrowser1(i).Text <> mvarPathAdjuntos Then
                  .Fields("ArchivoAdjunto" & i + 1).Value = FileBrowser1(i).Text
               Else
                  .Fields("ArchivoAdjunto" & i + 1).Value = Null
               End If
            Next
            If Len(rchObservaciones.Text) > 1 Then
               Do While Asc(Right(rchObservaciones.Text, 1)) = 13 Or Asc(Right(rchObservaciones.Text, 1)) = 10
                  If Len(rchObservaciones.Text) = 1 Then
                     rchObservaciones.Text = ""
                     Exit Do
                  Else
                     rchObservaciones.Text = mId(rchObservaciones.Text, 1, Len(rchObservaciones.Text) - 1)
                  End If
               Loop
               .Fields("Observaciones").Value = rchObservaciones.Text
            End If
         End With
         
         origen.Modificado = True
         Aceptado = True
         
         unHookForm
         Me.Hide

      Case 1
      
         If mvarId = -1 Then
            origen.Eliminado = True
         End If
         
         unHookForm
         Me.Hide
   
      Case 2
      
         If IsNull(LMaterial.Registro.Fields("IdObra").Value) Then
            MsgBox "No definio la obra!", vbCritical
            Exit Sub
         End If
         
         Dim oF As frmArticulosAcopios
         
         Set oF = New frmArticulosAcopios
         
         With oF
            .Obra = LMaterial.Registro.Fields("IdObra").Value
            .Show vbModal, Me
         End With
         
         Unload oF
   
         Set oF = Nothing
      
      Case 3
      
         Set of1 = New frmAutorizacion2
         
         With of1
            .Sector = "Control de Calidad"
            .Show vbModal, Me
         End With
         
         mvarOK = of1.Ok
         
         Unload of1
         
         Set of1 = Nothing
         
         If Not mvarOK Then
            MsgBox "Solo personal de Control de Calidad puede asignar los controles", vbExclamation
            Exit Sub
         End If
         
         DataCombo1(4).Enabled = True
         
      Case 4
   
         DataCombo1(1).Text = txtDescripcionManual.Text
         Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorDescripcion", txtDescripcionManual.Text)
         If oRs.RecordCount = 0 Then
            MsgBox "No existe un articulo con la descripcion manual, busquelo antes de registrar!", vbExclamation
         End If
         oRs.Close
         Set oRs = Nothing
         txtDescripcionManual.Visible = False
         DataCombo1(1).Visible = True
         cmd(4).Enabled = False
   
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim i As Integer
   
   Set oAp = Aplicacion
   mvarId = vNewValue
   Set origen = oLMaterial.DetLMateriales.Item(vNewValue)
   Me.IdNuevo = origen.Id
   Set oBind = New BindingCollection
   
   Set oPar = oAp.Parametros.Item(1)
   With oPar.Registro
      mvarIdUnidadCU = .Fields("IdUnidadPorUnidad").Value
      mvarPathAdjuntos = .Fields("PathAdjuntos").Value
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
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "DefExe1" Then
                  If Not IsNull(LMaterial.Registro.Fields("IdEquipo").Value) Then
                     Set oControl.RowSource = oAp.Equipos.TraerFiltrado("Planos", LMaterial.Registro.Fields("IdEquipo").Value)
                  End If
               ElseIf oControl.Tag = "Unidades" Then
               ElseIf oControl.Tag = "ObraDestinos" Then
                  Set oRs = Aplicacion.Obras.TraerFiltrado("_DestinosParaComboPorIdObra", _
                                                            oLMaterial.Registro.Fields("IdObra").Value)
                  If oRs.RecordCount = 0 Then
                     origen.Registro.Fields(DataCombo1(7).DataField).Value = Null
                     DataCombo1(7).Enabled = False
                     oRs.Close
                  ElseIf oRs.RecordCount = 1 Then
                     DataCombo1(7).Enabled = True
                     Set DataCombo1(7).RowSource = oRs
                     origen.Registro.Fields(DataCombo1(7).DataField).Value = oRs.Fields(0).Value
                  Else
                     DataCombo1(7).Enabled = True
                     Set DataCombo1(7).RowSource = oRs
                  End If
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
   
   If mvarId = -1 Then
      With origen.Registro
         If mConjuntoApuntado = 0 Then
            .Fields("NumeroItem").Value = oLMaterial.DetLMateriales.ProximoConjunto - 1
         Else
            .Fields("NumeroItem").Value = mConjuntoApuntado
         End If
         .Fields("NumeroOrden").Value = oLMaterial.DetLMateriales.ProximoItemDetalle(.Fields("NumeroItem").Value)
'         .Fields("Revision").Value = 0
         .Fields("Adjunto").Value = "NO"
         .Fields("Despacha").Value = "NO"
         If IsNull(origen.Registro("IdPlano").Value) Then
            .Fields("IdPlano").Value = LMaterial.Registro("IdPlano").Value
         End If
      End With
      Set oPar = oAp.Parametros.Item(1)
      origen.Registro.Fields("IdUnidadPeso").Value = oPar.Registro.Fields("IdUnidadPorKilo").Value
      Set oPar = Nothing
   Else
      With origen.Registro
         For i = 0 To 9
            FileBrowser1(i).Text = .Fields("ArchivoAdjunto" & i + 1).Value
         Next
         If Not IsNull(.Fields("IdDetalleAcopios").Value) Then
            Set oRs = oAp.Acopios.Item(0).DetAcopios.Item(.Fields("IdDetalleAcopios").Value).Registro
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("NumeroItem").Value) Then
                  txtNumeroItemAcopio.Text = oRs.Fields("NumeroItem").Value
               End If
               If Not IsNull(oRs.Fields("IdAcopio").Value) Then
               txtNumeroAcopio.Text = oAp.Acopios.Item(oRs.Fields("IdAcopio").Value).Registro.Fields("NumeroAcopio").Value
               End If
            End If
            oRs.Close
         End If
         If IsNull(.Fields("IdArticulo").Value) Then
            With txtDescripcionManual
               .Top = DataCombo1(1).Top
               .Left = DataCombo1(1).Left
               .Width = DataCombo1(1).Width
               DataCombo1(1).Visible = False
               .Visible = True
               .SetFocus
            End With
         Else
            cmd(4).Enabled = False
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   MuestraAdjuntos
   
   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then
      DataCombo1(0).Enabled = False
   End If
   
End Property

Public Property Get LMaterial() As ComPronto.LMaterial

   Set LMaterial = oLMaterial

End Property

Public Property Set LMaterial(ByVal vNewValue As ComPronto.LMaterial)

   Set oLMaterial = vNewValue

End Property

Private Sub FileBrowser1_Change(Index As Integer)

   If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
      FileBrowser1(Index).InitDir = FileBrowser1(Index).Text
   End If
   
End Sub

Private Sub FileBrowser1_DblClick(Index As Integer)

   If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
      If Not Len(Trim(Dir(FileBrowser1(Index).Text))) <> 0 Then
         MsgBox "El archivo indicado no existe!", vbExclamation
         Exit Sub
      End If
      Call ShellExecute(Me.hwnd, "open", FileBrowser1(Index).Text, vbNullString, vbNullString, SW_SHOWNORMAL)
   End If

End Sub

Private Sub DataCombo1_Change(Index As Integer)

   Dim oRs As ADOR.Recordset
            
   Me.MousePointer = vbHourglass
            
   Select Case Index
      Case 1
         If IsNumeric(DataCombo1(Index).BoundText) Then
            Set DataCombo1(0).RowSource = UnidadesHabilitadas(DataCombo1(1).BoundText)
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                     .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                  Else
                     .Fields("IdUnidad").Value = mvarIdUnidadCU
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
                     Case 3
                        txtCantidad1.Visible = True
                        txtCantidad2.Visible = True
                        Label1(0).Visible = True
                        txtUnidad.Visible = True
                  End Select
               End If
               
               'Determinar si va y calcular el peso
               txtPeso.Enabled = True
               If Not IsNull(oRs.Fields("Peso").Value) Then
                  If Not IsNull(oRs.Fields("Unidad6").Value) Then
                     origen.Registro.Fields("IdUnidadPeso").Value = oRs.Fields("Unidad6").Value
                  End If
               Else
                  origen.Registro.Fields("Peso").Value = Null
'                     .Fields("IdUnidadPeso").Value = mvarIdUnidadCU
'                  If Not IsNull(oRs.Fields("Densidad").Value) Then
                     txtPeso.Enabled = False
'                  End If
               End If
            
               If Not IsNull(oRs.Fields("CostoPPP").Value) Then
                  txtCostoPPP.Text = oRs.Fields("CostoPPP").Value
               Else
                  txtCostoPPP.Text = ""
               End If
               
               If Not IsNull(oRs.Fields("CostoReposicion").Value) Then
                  txtCostoReposicion.Text = oRs.Fields("CostoReposicion").Value
               Else
                  txtCostoReposicion.Text = ""
               End If
            
               txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
            
            End If
            oRs.Close
         End If
      
      Case 5
   
         origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
         MuestraAdjuntos
   End Select
      
   Set oRs = Nothing
   
   Me.MousePointer = vbDefault

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DataCombo1_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Index = 1 Then
      If Button = vbRightButton Then
         If glbMenuPopUpCargado Then
            Dim cursorpos As POINTAPI
            GetCursorPos cursorpos
            TrackPopupMenu POP_hMenu, TPM_HORNEGANIMATION, cursorpos.X, cursorpos.Y, 0, Me.hwnd, ByVal 0&
            DoEvents
            If POP_Key > 0 Then
               DataCombo1(1).BoundText = POP_Key
            End If
         Else
            MsgBox "No se ha cargado el menu de materiales", vbInformation
         End If
      End If
   End If

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub Form_Activate()

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   Set oAp = Aplicacion
   
   If mvarId <> -1 Then
      If Not IsNull(origen.Registro.Fields("IdArticulo").Value) Then
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
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing

End Sub

Private Sub Form_Load()

   If glbMenuPopUpCargado Then ActivarPopUp Me
   
   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long
   Dim i As Integer
   Dim oAp As ComPronto.Aplicacion
   Dim oRsDetAco As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then ' si el dato es texto
      
      s = Data.GetData(ccCFText) ' tomo el dato
      
      Filas = Split(s, vbCrLf) ' armo un vector por filas
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
'      If InStr(1, Columnas(LBound(Columnas) + 1), "Acopio") <> 0 Then
      
         Set oAp = Aplicacion
         
         Columnas = Split(Filas(1), vbTab) ' armo un vector con las columnas
         
         Set oRsDetAco = oAp.Acopios.Item(0).DetAcopios.Item(Columnas(12)).Registro
         
         Do While Not oRsDetAco.EOF
            With origen.Registro
               .Fields("Cantidad").Value = 0
               .Fields("Cantidad1").Value = 0
               .Fields("Cantidad2").Value = 0
               .Fields("IdUnidad").Value = oRsDetAco.Fields("IdUnidad").Value
               .Fields("IdArticulo").Value = oRsDetAco.Fields("IdArticulo").Value
               .Fields("Peso").Value = oRsDetAco.Fields("Peso").Value
               .Fields("IdUnidadPeso").Value = oRsDetAco.Fields("IdUnidadPeso").Value
               .Fields("IdControlCalidad").Value = oRsDetAco.Fields("IdControlCalidad").Value
               .Fields("IdDetalleAcopios").Value = oRsDetAco.Fields(0).Value
               .Fields("Adjunto").Value = oRsDetAco.Fields("Adjunto").Value
               For i = 0 To 9
                  .Fields("ArchivoAdjunto" & i + 1).Value = oRsDetAco.Fields("ArchivoAdjunto" & i + 1).Value
                  FileBrowser1(i).Text = IIf(IsNull(oRsDetAco.Fields("ArchivoAdjunto" & i + 1).Value), "", oRsDetAco.Fields("ArchivoAdjunto" & i + 1).Value)
               Next
               .Fields("Despacha").Value = "NO"
               .Fields("Observaciones").Value = oRsDetAco.Fields("Observaciones").Value
               txtNumeroItemAcopio.Text = oRsDetAco.Fields("NumeroItem").Value
               txtNumeroAcopio.Text = Columnas(1)
            End With
            oRsDetAco.MoveNext
         Loop
         
         oRsDetAco.Close
         Set oRsDetAco = Nothing
         Set oAp = Nothing
         
         Clipboard.Clear
      
'      Else
'
'         MsgBox "Objeto invalido!"
'         Exit Sub
'
'      End If

   End If

End Sub

Private Sub Form_OLEDragOver(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long
   Dim iColumnas As Long
   Dim oL As ListItem

   If State = vbEnter Then
      If Data.GetFormat(ccCFText) Then ' si el dato es texto
         s = Data.GetData(ccCFText) ' tomo el dato
         Filas = Split(s, vbCrLf) ' armo un vector por filas
         Columnas = Split(Filas(LBound(Filas)), vbTab)
         Effect = vbDropEffectCopy
      End If
   End If

End Sub

Private Sub Form_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oBind = Nothing
   Set origen = Nothing
   Set oLMaterial = Nothing
   
   If glbMenuPopUpCargado Then DesactivarPopUp Me

End Sub

Private Sub txtBusca_GotFocus()

   With txtBusca
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBusca_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      If KeyAscii = 13 Then
         Dim oAp As ComPronto.Aplicacion
         Set oAp = Aplicacion
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set DataCombo1(1).RowSource = oAp.Articulos.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set DataCombo1(1).RowSource = oAp.Articulos.TraerLista
         End If
         Set oAp = Nothing
      End If
      DataCombo1(1).SetFocus
      SendKeys "%{DOWN}"
   End If

End Sub

Private Sub txtCantidad_LostFocus()

   If txtPeso.Enabled Then
      If IsNumeric(DataCombo1(1).BoundText) Then
         If txtCantidad1.Visible And txtCantidad2.Visible Then
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text), Val(txtCantidad1.Text), Val(txtCantidad2.Text))
         ElseIf txtCantidad1.Visible Then
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text), Val(txtCantidad1.Text))
         Else
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text))
         End If
      End If
   End If

End Sub

Private Sub txtCantidad1_GotFocus()

   With txtCantidad1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCantidad1_LostFocus()

   If txtPeso.Enabled Then
      If IsNumeric(DataCombo1(1).BoundText) Then
         If txtCantidad1.Visible And txtCantidad2.Visible Then
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text), Val(txtCantidad1.Text), Val(txtCantidad2.Text))
         ElseIf txtCantidad1.Visible Then
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text), Val(txtCantidad1.Text))
         Else
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text))
         End If
      End If
   End If

End Sub

Private Sub txtCantidad2_LostFocus()

   If txtPeso.Enabled Then
      If IsNumeric(DataCombo1(1).BoundText) Then
         If txtCantidad1.Visible And txtCantidad2.Visible Then
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text), Val(txtCantidad1.Text), Val(txtCantidad2.Text))
         ElseIf txtCantidad1.Visible Then
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text), Val(txtCantidad1.Text))
         Else
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text))
         End If
      End If
   End If

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
         origen.Registro.Fields("IdArticulo").Value = oRs.Fields(0).Value
      Else
         MsgBox "Codigo de material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo.Text = ""
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

Private Sub txtDescripcionManual_GotFocus()

   With txtDescripcionManual
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDescripcionManual_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDescripcionManual
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtItem_GotFocus()
   
   With txtItem
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtItem_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtItem_LostFocus()
   
   If mvarId = -1 Then
      origen.Registro.Fields("NumeroOrden").Value = SiguienteOrdenLMateriales(LMaterial.DetLMateriales.TodosLosRegistros, txtItem.Text)
   End If

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

Private Sub txtCantidad2_GotFocus()
   
   With txtCantidad2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroOrden_GotFocus()

   With txtNumeroOrden
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroOrden_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPeso_GotFocus()

   With txtPeso
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPeso_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtRevision_GotFocus()

   With txtRevision
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtRevision_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Let ConjuntoApuntado(ByVal vNewValue As Long)

   mConjuntoApuntado = vNewValue
   
End Property

Private Sub MuestraAdjuntos()

   Dim i As Integer
   
   If IsNull(origen.Registro.Fields("Adjunto").Value) Or origen.Registro.Fields("Adjunto").Value = "NO" Then
      For i = 0 To 9
         lblAdjuntos(i).Visible = False
         FileBrowser1(i).Visible = False
         FileBrowser1(i).Text = ""
      Next
      Line1.Visible = False
      Me.Height = 5500
   Else
      For i = 0 To 9
         lblAdjuntos(i).Visible = True
         FileBrowser1(i).Visible = True
         If Len(Trim(FileBrowser1(i).Text)) = 0 Then
            FileBrowser1(i).Text = mvarPathAdjuntos
            FileBrowser1(i).InitDir = mvarPathAdjuntos
         End If
      Next
      Line1.Visible = True
      Me.Height = 8000
   End If
      
End Sub

'Public Sub miMSG(ByVal uMSG As Long, ByVal wParam As Long, ByVal lParam As Long)
'
'   If uMSG = WM_MENUSELECT Then
'      Dim oRs As ADOR.Recordset
'      mClave = CLng(wParam And &HFFFF&)
'      If mClave <= 0 Then
'         Exit Sub
'      End If
'
'      If DataCombo1(1).Visible Then
'         DataCombo1(1).BoundText = mClave
'      Else
'         Set oRs = Aplicacion.Articulos.Item(mClave).Registro
'         If oRs.RecordCount > 0 Then
'            If Not IsNull(oRs.Fields("Descripcion").Value) Then
'               txtDescripcionManual.Text = oRs.Fields("Descripcion").Value
'            End If
'         End If
'         oRs.Close
'         Set oRs = Nothing
'      End If
'   End If
'
'End Sub


