VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{126E538A-EE41-4B22-A045-F8D5538F5D2B}#1.0#0"; "FileBrowser1.ocx"
Object = "{BE38695A-739A-4A6C-BF54-931FC1415984}#1.0#0"; "VividThumbNails.ocx"
Begin VB.Form frmDetSalidasMateriales 
   Caption         =   "Item de salida de materiales de almacenes"
   ClientHeight    =   7995
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10785
   LinkTopic       =   "Form1"
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   7995
   ScaleWidth      =   10785
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtNumeroCaja 
      DataField       =   "NumeroCaja"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   4095
      TabIndex        =   86
      Top             =   1080
      Visible         =   0   'False
      Width           =   780
   End
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
      Left            =   4725
      TabIndex        =   77
      Top             =   5220
      Visible         =   0   'False
      Width           =   1050
   End
   Begin VB.CheckBox Check2 
      Height          =   195
      Left            =   7995
      TabIndex        =   76
      Top             =   4875
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   4950
      TabIndex        =   72
      Top             =   4140
      Visible         =   0   'False
      Width           =   1005
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
      Height          =   315
      Left            =   2070
      TabIndex        =   71
      Top             =   1485
      Width           =   870
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Left            =   2070
      TabIndex        =   70
      Top             =   4185
      Width           =   195
   End
   Begin VB.Frame Frame1 
      Caption         =   "Forma de baja de stock : "
      Height          =   1005
      Left            =   7875
      TabIndex        =   61
      Top             =   2655
      Width           =   2760
      Begin VB.OptionButton Option1 
         Caption         =   "Descarga por articulo"
         Height          =   195
         Left            =   90
         TabIndex        =   63
         Top             =   315
         Width           =   1860
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Descarga por componentes (Kit)"
         Height          =   195
         Left            =   90
         TabIndex        =   62
         Top             =   630
         Width           =   2625
      End
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
      Height          =   315
      Left            =   2070
      TabIndex        =   15
      Top             =   3735
      Width           =   1725
   End
   Begin VB.TextBox txtBusca1 
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
      Left            =   8415
      TabIndex        =   59
      Top             =   4095
      Width           =   2220
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
      Height          =   315
      Left            =   2070
      TabIndex        =   10
      Top             =   2250
      Width           =   1095
   End
   Begin VB.TextBox txtCotizacionDolar 
      Alignment       =   1  'Right Justify
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
      TabIndex        =   13
      Top             =   2250
      Width           =   915
   End
   Begin VB.TextBox txtCotizacionMoneda 
      Alignment       =   1  'Right Justify
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
      TabIndex        =   12
      Top             =   2250
      Width           =   870
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
      TabIndex        =   52
      Top             =   270
      Width           =   1005
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
      Left            =   2070
      TabIndex        =   0
      Top             =   270
      Width           =   1545
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Asignar partida"
      Height          =   405
      Index           =   3
      Left            =   1620
      TabIndex        =   20
      Top             =   5085
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Ver stock"
      Height          =   405
      Index           =   2
      Left            =   45
      TabIndex        =   19
      Top             =   5085
      Width           =   1485
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
      TabIndex        =   8
      Top             =   1470
      Width           =   1455
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
      Height          =   315
      Left            =   5850
      TabIndex        =   7
      Top             =   1470
      Width           =   870
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
      Height          =   315
      Left            =   4545
      TabIndex        =   6
      Top             =   1470
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
      Height          =   315
      Left            =   8370
      TabIndex        =   21
      Top             =   315
      Width           =   2265
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   45
      TabIndex        =   17
      Top             =   4590
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1620
      TabIndex        =   18
      Top             =   4590
      Width           =   1485
   End
   Begin VB.TextBox txtPartida 
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
      Height          =   315
      Left            =   2070
      TabIndex        =   2
      Top             =   1080
      Width           =   1185
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   2070
      TabIndex        =   1
      Tag             =   "Articulos"
      Top             =   675
      Width           =   8610
      _ExtentX        =   15187
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
      Left            =   2970
      TabIndex        =   5
      Tag             =   "Unidades"
      Top             =   1470
      Width           =   1545
      _ExtentX        =   2725
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   1440
      TabIndex        =   26
      Top             =   5895
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
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1050
      Left            =   2070
      TabIndex        =   14
      Top             =   2610
      Width           =   5730
      _ExtentX        =   10107
      _ExtentY        =   1852
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmDetSalidasMateriales.frx":0000
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   1
      Left            =   1440
      TabIndex        =   27
      Top             =   6300
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
      TabIndex        =   28
      Top             =   6705
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
      TabIndex        =   29
      Top             =   7110
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
      TabIndex        =   30
      Top             =   7515
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
      TabIndex        =   31
      Top             =   5895
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
      TabIndex        =   32
      Top             =   6300
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
      TabIndex        =   33
      Top             =   6705
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
      TabIndex        =   34
      Top             =   7110
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
      TabIndex        =   35
      Top             =   7515
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
      DataField       =   "Adjunto"
      Height          =   315
      Index           =   5
      Left            =   2070
      TabIndex        =   9
      Tag             =   "SiNo"
      Top             =   1890
      Width           =   780
      _ExtentX        =   1376
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "SiNo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUbicacion"
      Height          =   315
      Index           =   2
      Left            =   5940
      TabIndex        =   3
      Tag             =   "Ubicaciones"
      Top             =   1080
      Width           =   2310
      _ExtentX        =   4075
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUbicacion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   3
      Left            =   8955
      TabIndex        =   4
      Tag             =   "Obras"
      Top             =   1080
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
      TabIndex        =   11
      Tag             =   "Monedas"
      Top             =   2250
      Width           =   1590
      _ExtentX        =   2805
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdEquipoDestino"
      Height          =   315
      Index           =   4
      Left            =   3825
      TabIndex        =   16
      Tag             =   "Articulos1"
      Top             =   3735
      Width           =   6810
      _ExtentX        =   12012
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaImputacion"
      Height          =   330
      Index           =   0
      Left            =   4455
      TabIndex        =   64
      Top             =   1845
      Visible         =   0   'False
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   34799617
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdOrdenTrabajo"
      Height          =   315
      Index           =   7
      Left            =   2295
      TabIndex        =   66
      Tag             =   "OrdenesTrabajo"
      Top             =   4140
      Width           =   2535
      _ExtentX        =   4471
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdOrdenTrabajo"
      Text            =   ""
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
      Index           =   6
      Left            =   8955
      TabIndex        =   68
      Tag             =   "ObraDestinos"
      Top             =   1440
      Visible         =   0   'False
      Width           =   1725
      _ExtentX        =   3043
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdDetalleObraDestino"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdPresupuestoObraRubro"
      Height          =   315
      Index           =   11
      Left            =   8955
      TabIndex        =   73
      Tag             =   "PresupuestoObrasRubros"
      Top             =   1800
      Visible         =   0   'False
      Width           =   1725
      _ExtentX        =   3043
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPresupuestoObraRubro"
      Text            =   ""
   End
   Begin VividThumbNails.VividThumbs VividThumbs1 
      Height          =   4785
      Left            =   10845
      TabIndex        =   75
      Top             =   270
      Width           =   1995
      _ExtentX        =   3519
      _ExtentY        =   8440
      tWidth          =   40
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   0
      Left            =   5805
      TabIndex        =   78
      Tag             =   "Cuentas"
      Top             =   5220
      Visible         =   0   'False
      Width           =   4845
      _ExtentX        =   8546
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      DataField       =   "IdCuentaGasto"
      Height          =   315
      Index           =   1
      Left            =   8280
      TabIndex        =   79
      Tag             =   "CuentasGastos"
      Top             =   4830
      Visible         =   0   'False
      Width           =   2370
      _ExtentX        =   4180
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaGasto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      Height          =   315
      Index           =   3
      Left            =   4725
      TabIndex        =   80
      Tag             =   "TiposCuentaGrupos"
      Top             =   4860
      Visible         =   0   'False
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoCuentaGrupo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdPresupuestoObrasNodo"
      Height          =   315
      Index           =   7
      Left            =   5535
      TabIndex        =   84
      Tag             =   "PresupuestoObrasNodos"
      Top             =   4140
      Visible         =   0   'False
      Width           =   960
      _ExtentX        =   1693
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPresupuestoObrasNodo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   8
      Left            =   6075
      TabIndex        =   85
      Top             =   4140
      Visible         =   0   'False
      Width           =   1140
      _ExtentX        =   2011
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "Partida"
      Text            =   ""
   End
   Begin VB.Label lblColor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   300
      Left            =   4770
      TabIndex        =   89
      Top             =   4500
      Visible         =   0   'False
      Width           =   5865
   End
   Begin VB.Label lblLabels 
      Caption         =   "Color :"
      Height          =   210
      Index           =   10
      Left            =   3330
      TabIndex        =   88
      Top             =   4545
      Visible         =   0   'False
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro.Caja:"
      Height          =   255
      Index           =   9
      Left            =   3330
      TabIndex        =   87
      Top             =   1125
      Visible         =   0   'False
      Width           =   645
   End
   Begin VB.Label lblCuentas 
      Caption         =   "Grupos cuentas :"
      Height          =   300
      Index           =   0
      Left            =   3330
      TabIndex        =   83
      Top             =   4860
      Visible         =   0   'False
      Width           =   1320
   End
   Begin VB.Label lblCuentas 
      Caption         =   "Cuenta contable :"
      Height          =   300
      Index           =   2
      Left            =   3330
      TabIndex        =   82
      Top             =   5220
      Visible         =   0   'False
      Width           =   1320
   End
   Begin VB.Label lblCuentas 
      Caption         =   "Cuenta de gasto :"
      Height          =   330
      Index           =   1
      Left            =   6600
      TabIndex        =   81
      Top             =   4830
      Visible         =   0   'False
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Rubro p/presup. :"
      Height          =   255
      Index           =   27
      Left            =   7605
      TabIndex        =   74
      Top             =   1845
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.Label lblLabels 
      Caption         =   "Etapa :"
      Height          =   255
      Index           =   22
      Left            =   8325
      TabIndex        =   69
      Top             =   1485
      Visible         =   0   'False
      Width           =   555
   End
   Begin VB.Label lblLabels 
      Caption         =   "Orden de trabajo (opc.) :"
      Height          =   300
      Index           =   8
      Left            =   135
      TabIndex        =   67
      Top             =   4140
      Width           =   1815
   End
   Begin VB.Label lblFechaImputacion 
      AutoSize        =   -1  'True
      Caption         =   "Fecha imputacion :"
      Height          =   285
      Left            =   3015
      TabIndex        =   65
      Top             =   1890
      Visible         =   0   'False
      Width           =   1395
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
      Index           =   3
      Left            =   7470
      TabIndex        =   60
      Top             =   4140
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Equipo destino (opc.) :"
      Height          =   300
      Index           =   1
      Left            =   135
      TabIndex        =   58
      Top             =   3735
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Costo unitario :"
      Height          =   300
      Index           =   18
      Left            =   135
      TabIndex        =   57
      Top             =   2265
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Moneda :"
      Height          =   240
      Index           =   19
      Left            =   3285
      TabIndex        =   56
      Top             =   2295
      Width           =   735
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cotizacion dolar :"
      Height          =   240
      Index           =   20
      Left            =   8415
      TabIndex        =   55
      Top             =   2295
      Width           =   1260
   End
   Begin VB.Label lblLabels 
      Caption         =   "Conversion a Pesos :"
      Height          =   240
      Index           =   21
      Left            =   5805
      TabIndex        =   54
      Top             =   2295
      Width           =   1530
   End
   Begin VB.Label lblLabels 
      Caption         =   "Stock actual :"
      Height          =   300
      Index           =   6
      Left            =   4275
      TabIndex        =   53
      Top             =   270
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de articulo :"
      Height          =   300
      Index           =   4
      Left            =   135
      TabIndex        =   51
      Top             =   270
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obra :"
      Height          =   255
      Index           =   15
      Left            =   8325
      TabIndex        =   50
      Top             =   1125
      Width           =   555
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ubicacion :"
      Height          =   255
      Index           =   16
      Left            =   4995
      TabIndex        =   49
      Top             =   1125
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Adjuntos ? :"
      Height          =   300
      Index           =   12
      Left            =   135
      TabIndex        =   48
      Top             =   1890
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
      TabIndex        =   47
      Top             =   360
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   5
      Left            =   135
      TabIndex        =   46
      Top             =   2655
      Width           =   1815
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   3
      X1              =   45
      X2              =   10800
      Y1              =   5625
      Y2              =   5625
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 1 :"
      Height          =   300
      Index           =   0
      Left            =   90
      TabIndex        =   45
      Top             =   5895
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 2 :"
      Height          =   300
      Index           =   1
      Left            =   90
      TabIndex        =   44
      Top             =   6300
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 3 :"
      Height          =   300
      Index           =   2
      Left            =   90
      TabIndex        =   43
      Top             =   6705
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 4 :"
      Height          =   300
      Index           =   3
      Left            =   90
      TabIndex        =   42
      Top             =   7110
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 5 :"
      Height          =   300
      Index           =   4
      Left            =   90
      TabIndex        =   41
      Top             =   7515
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 6 :"
      Height          =   300
      Index           =   5
      Left            =   5670
      TabIndex        =   40
      Top             =   5940
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 7 :"
      Height          =   300
      Index           =   6
      Left            =   5670
      TabIndex        =   39
      Top             =   6345
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 8 :"
      Height          =   300
      Index           =   7
      Left            =   5670
      TabIndex        =   38
      Top             =   6750
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 9 :"
      Height          =   300
      Index           =   8
      Left            =   5670
      TabIndex        =   37
      Top             =   7155
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 10 :"
      Height          =   300
      Index           =   9
      Left            =   5670
      TabIndex        =   36
      Top             =   7560
      Width           =   1230
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
      TabIndex        =   25
      Top             =   1515
      Width           =   285
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   2
      Left            =   135
      TabIndex        =   24
      Top             =   675
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   135
      TabIndex        =   23
      Top             =   1485
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Partida :"
      Height          =   300
      Index           =   0
      Left            =   135
      TabIndex        =   22
      Top             =   1080
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetSalidasMateriales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetSalidaMateriales
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oSalidaMateriales As ComPronto.SalidaMateriales
Public Aceptado As Boolean, mOTsMantenimiento As Boolean, mExigirOT As Boolean
Public mvarCantidadAdicional As Double
Private mvarIdUnidad As Integer, mOk As Integer, mTipoSalida As Integer, mvarIdUnidadCU As Integer
Private mvarCantidadUnidades As Double
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long, mvarIdMonedaPesos As Long, mvarIdMonedaDolar As Long
Private mvarIdControlCalidadStandar As Long, mvarIdObra As Long, mvarIdDepositoOrigen As Long, mvarAnchoForm As Long
Private mvarIdDepositoOrigenParametro As Long
Private mvarPathAdjuntos As String, mDescargaPorKit As String, mCostoATomar As String, mvarFechaImputacionActiva As String
Private mvarExigirEquipoDestino As String, mvarParaMantenimiento As String, mvarBasePRONTOMantenimiento As String
Private mvarRegistroContableComprasAlActivo As String, mvarADistribuirEnPresupuestoDeObra As String
Private mvarFechaSalida As Date
Private mvarImagenes As Boolean, mvarRegistrarStock As Boolean, mvarLimitarEquiposDestinoSegunEtapasDeObra As Boolean
Private mDescargaPorKitHabilitada As Boolean, mvarPresupuestadorObraNuevo As Boolean

Private Sub Check1_Click()

   If Check1.Value = 0 Then
      origen.Registro.Fields("IdOrdenTrabajo").Value = Null
   End If

End Sub

Private Sub Check2_Click()

   If Check2.Value = 0 Then
      Dim mIdCuenta As Long
      Dim mAuxS1 As String
      origen.Registro.Fields(DataCombo2(1).DataField).Value = Null
      txtCodigoCuenta.Enabled = True
      mIdCuenta = 0
      With DataCombo2(0)
         If IsNumeric(.BoundText) Then mIdCuenta = .BoundText
         Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_ParaComprobantesProveedores")
         origen.Registro.Fields(.DataField).Value = mIdCuenta
         .Enabled = True
      End With
      With DataCombo2(3)
         .BoundText = 0
         .Enabled = True
      End With
   End If
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Dim oF As Form
   
   Select Case Index
      
      Case 0
      
         If Len(txtCostoUnitario.Text) = 0 And txtCostoUnitario.Visible Then
            MsgBox "No ingreso el costo unitario", vbInformation
            Exit Sub
         End If
         
         If Val(txtCostoUnitario.Text) < 0 And txtCostoUnitario.Visible Then
            MsgBox "El costo unitario debe ser mayor o igual a cero", vbInformation
            Exit Sub
         End If
         
         If Len(txtCotizacionMoneda.Text) = 0 And txtCotizacionMoneda.Visible Then
            MsgBox "No ingreso la cotizacion", vbInformation
            Exit Sub
         End If
         
         If Val(txtCotizacionMoneda.Text) <= 0 And txtCotizacionMoneda.Visible Then
            MsgBox "La cotizacion debe ser mayor o igual a cero", vbInformation
            Exit Sub
         End If
         
         If Len(txtCotizacionDolar.Text) = 0 And txtCotizacionDolar.Visible Then
            MsgBox "No ingreso la cotizacion", vbInformation
            Exit Sub
         End If
         
         If Val(txtCotizacionDolar.Text) <= 0 And txtCotizacionDolar.Visible Then
            MsgBox "La cotizacion debe ser mayor o igual a cero", vbInformation
            Exit Sub
         End If
         
         If (mvarExigirEquipoDestino = "SI" Or mvarParaMantenimiento = "SI") And _
               DataCombo1(4).Visible And Not IsNumeric(DataCombo1(4).BoundText) Then
            MsgBox "Debe indicar el equipo destino", vbInformation
            Exit Sub
         End If
         
         If mvarParaMantenimiento = "SI" And _
               DataCombo1(4).Visible And Not IsNumeric(DataCombo1(4).BoundText) Then
            MsgBox "Debe indicar el equipo destino", vbInformation
            Exit Sub
         End If
         
         If mExigirOT And dcfields(7).Visible And Not IsNumeric(dcfields(7).BoundText) Then
            MsgBox "Debe indicar el numero de orden de trabajo", vbInformation
            Exit Sub
         End If
         
         If txtCodigoCuenta.Visible And Len(txtCodigoCuenta.Text) = 0 Then
            MsgBox "Debe definir una cuenta contable a imputar", vbExclamation
            Exit Sub
         End If
         
         If txtNumeroCaja.Visible And Len(txtNumeroCaja.Text) > 0 Then
            If Not oSalidaMateriales.DetSalidasMateriales.ControlCajas(txtNumeroCaja.Text, origen.Id) Then
               MsgBox "Ya existe este numero de caja en la salida", vbExclamation
               Exit Sub
            End If
         End If
         
         Dim dc As DataCombo
         Dim oRs As ADOR.Recordset
         Dim mvarStock As Double, mvarStock1 As Double, mvarStock2 As Double, mvarCantidad As Double
         Dim mvarIdStock As Long
         Dim i As Integer
         Dim mvarUnidad As String, mvarAux1 As String, mvarAux2 As String, mvarAux3 As String
         Dim mDescargaPorKit1 As Boolean
         
         mDescargaPorKit1 = False
         If Frame1.Visible And Option2.Value Then mDescargaPorKit1 = True
         
         For Each dc In DataCombo1
            If (dc.Enabled And dc.Visible) Or dc.Index = 0 Then
               If Len(Trim(dc.BoundText)) = 0 And dc.Index <> 4 Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
               If Len(dc.DataField) > 0 And dc.Enabled And dc.Visible And IsNumeric(dc.BoundText) Then
                  origen.Registro.Fields(dc.DataField).Value = dc.BoundText
               End If
            End If
         Next
      
         If IsNull(origen.Registro.Fields("Cantidad").Value) Or origen.Registro.Fields("Cantidad").Value = 0 Then
            MsgBox "Falta ingresar la cantidad (unidades)", vbCritical
            Exit Sub
         End If
         
         mvarCantidadUnidades = origen.Registro.Fields("Cantidad").Value
         mvarCantidadAdicional = 0
'         origen.Registro.Fields("IdUnidad").Value = mvarIdUnidad
         
         If txtCantidad1.Visible Then
            If IsNull(origen.Registro.Fields("Cantidad1").Value) Or origen.Registro.Fields("Cantidad1").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 1)", vbCritical
               Exit Sub
            End If
            mvarCantidadAdicional = origen.Registro.Fields("Cantidad1").Value
         End If
         
         If txtCantidad2.Visible Then
            If IsNull(origen.Registro.Fields("Cantidad2").Value) Or origen.Registro.Fields("Cantidad2").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 2)", vbCritical
               Exit Sub
            End If
            mvarCantidadAdicional = origen.Registro.Fields("Cantidad1").Value * origen.Registro.Fields("Cantidad2").Value
         End If
         
         If IsNull(origen.Registro.Fields("Partida").Value) Then
            origen.Registro.Fields("Partida").Value = ""
         End If
         
         If IsNull(origen.Registro.Fields("IdObra").Value) Then
            MsgBox "No ha definido la obra", vbCritical
            Exit Sub
         End If
         
         mvarAux2 = BuscarClaveINI("Inhabilitar stock negativo")
         mvarAux3 = BuscarClaveINI("Inhabilitar stock global negativo")
         With origen.Registro
            If DataCombo1(8).Visible Then .Fields("Partida").Value = DataCombo1(8).BoundText
            If IsNull(.Fields("Partida").Value) Then .Fields("Partida").Value = ""
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_StockPorArticuloPartidaUnidadUbicacionObra", _
                     Array(.Fields("IdArticulo").Value, IIf(IsNull(.Fields("Partida").Value), "", .Fields("Partida").Value), _
                           .Fields("IdUnidad").Value, IIf(IsNull(.Fields("IdUbicacion").Value), 0, .Fields("IdUbicacion").Value), _
                           .Fields("IdObra").Value))
            If oRs.RecordCount > 0 Then
               mvarStock1 = IIf(IsNull(oRs.Fields("Stock").Value), 0, oRs.Fields("Stock").Value)
            End If
            oRs.Close
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_StockTotalPorArticulo", .Fields("IdArticulo").Value)
            If oRs.RecordCount > 0 Then
               mvarStock2 = IIf(IsNull(oRs.Fields("Stock").Value), 0, oRs.Fields("Stock").Value)
            End If
            oRs.Close
         End With
         mvarStock = 0
         If mvarId > 0 Then
            Set oRs = Aplicacion.TablasGenerales.TraerUno("DetSalidasMateriales", mvarId)
            If oRs.RecordCount > 0 Then
               mvarStock = IIf(IsNull(oRs.Fields("Cantidad").Value), 0, oRs.Fields("Cantidad").Value)
            End If
            oRs.Close
         End If
         If mvarRegistrarStock And Not mDescargaPorKit1 And mvarAux3 <> "SI" And mvarStock1 < mvarCantidadUnidades - mvarStock Then
            mvarAux1 = "Stock insuficiente segun datos ingresados :" & vbCrLf & _
                         "cantidad actual en stock para la partida, unidad, ubicacion y obra : " & mvarStock1 & vbCrLf & _
                         "cantidad total actual en stock : " & mvarStock2
            If mvarAux2 = "SI" Then
               MsgBox mvarAux1, vbExclamation, "Sin stock"
               Exit Sub
            Else
               mOk = MsgBox(mvarAux1 & vbCrLf & "Desea continuar igual ?", vbYesNo, "Sin Stock")
               If mOk = vbNo Then Exit Sub
            End If
         End If
         If mvarRegistrarStock And Not mDescargaPorKit1 And mvarStock2 < mvarCantidadUnidades - mvarStock Then
            mvarAux1 = "Stock insuficiente :" & vbCrLf & "cantidad total actual en stock : " & mvarStock2
            If mvarAux2 = "SI" Or mvarAux3 = "SI" Then
               MsgBox mvarAux1, vbExclamation, "Sin stock"
               Exit Sub
            Else
               mOk = MsgBox(mvarAux1 & vbCrLf & "Desea continuar igual ?", vbYesNo, "Sin Stock")
               If mOk = vbNo Then Exit Sub
            End If
         End If
         
         If mOTsMantenimiento And IsNumeric(DataCombo1(4).BoundText) Then
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("ProntoMantenimiento", _
                        "_VerificarArticulo", origen.Registro.Fields("IdArticulo").Value)
            If oRs.Fields(0).Value = 0 Then
               oRs.Close
               MsgBox "El articulo no tiene equivalencia a un articulo del " & _
                      "sistema de mantenimiento, definalo y vuelva a intentar", vbExclamation
               Exit Sub
            End If
            oRs.Close
         End If
         
         If Not IsNull(origen.Registro.Fields("IdDetalleValeSalida").Value) Then
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetValesSalida", _
                        "_TodoMasPendientePorIdDetalle", origen.Registro.Fields("IdDetalleValeSalida").Value)
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("IdOrdenTrabajo").Value) And Len(dcfields(7).Text) = 0 Then
                  MsgBox "Debe indicar la OT. (OT original " & oRs.Fields("NumeroOrdenTrabajo").Value & ")", vbExclamation
                  oRs.Close
                  Set oRs = Nothing
                  Exit Sub
               End If
            End If
            oRs.Close
         End If
         
         With origen.Registro
'            .Fields("IdUnidad").Value = mvarIdUnidad
            .Fields("CantidadAdicional").Value = mvarCantidadAdicional * mvarCantidadUnidades
            .Fields("IdStock").Value = mvarIdStock
            For i = 0 To 9
               .Fields("ArchivoAdjunto" & i + 1).Value = FileBrowser1(i).Text
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
            .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text
            .Fields("CotizacionDolar").Value = txtCotizacionDolar.Text
            If Frame1.Visible Then
               If Option1.Value Then
                  .Fields("DescargaPorKit").Value = "NO"
               Else
                  .Fields("DescargaPorKit").Value = "SI"
               End If
            Else
               .Fields("DescargaPorKit").Value = Null
            End If
            If mvarFechaImputacionActiva = "SI" Then
               .Fields("FechaImputacion").Value = DTFields(0).Value
            Else
               .Fields("FechaImputacion").Value = Null
            End If
         End With
         
         origen.Modificado = True
         Aceptado = True
         
         Set oRs = Nothing
   
         Me.Hide

      Case 1
      
         If mvarId = -1 Then
            origen.Eliminado = True
         End If
         Me.Hide

      Case 2
         
         Set oF = New frmConsulta1
         With oF
            .Id = 1
            .Show vbModal, Me
         End With
         Unload oF
         Set oF = Nothing
      
      Case 3
         
         If IsNull(origen.Registro.Fields("IdArticulo").Value) Then
            MsgBox "No ha definido el material", vbExclamation
            Exit Sub
         Else
            Dim of2 As frmConsultaStockPorPartidas
            Set of2 = New frmConsultaStockPorPartidas
            With of2
               .Articulo = origen.Registro.Fields("IdArticulo").Value
               .Show vbModal, Me
            End With
            Unload of2
            Set of2 = Nothing
         End If
      
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim dtp As DTPicker
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim i As Integer
   Dim mLimitarUbicaciones As Boolean
   Dim mAux1

   Set oAp = Aplicacion
   
   mvarId = vNewValue
   mExigirOT = False
   mvarAnchoForm = Me.Width
   mvarRegistrarStock = True
   mDescargaPorKitHabilitada = False
   
   Set origen = oSalidaMateriales.DetSalidasMateriales.Item(vNewValue)
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
   
   If BuscarClaveINI("Ocultar equipo destino y OT") = "SI" Then
      lblLabels(1).Visible = False
      txtCodigoArticulo1.Visible = False
      DataCombo1(4).Visible = False
      lblLabels(3).Visible = False
      txtBusca1.Visible = False
      lblLabels(8).Visible = False
      Check1.Visible = False
      dcfields(7).Visible = False
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
   If BuscarClaveINI("Limitar ubicaciones en movimientos de stock") = "SI" Then mLimitarUbicaciones = True
   
   mvarPresupuestadorObraNuevo = False
   If BuscarClaveINI("Presupuestador de obra nuevo") = "SI" Then mvarPresupuestadorObraNuevo = True
   
   If BuscarClaveINI("Obras_AccesoADestinos") = "SI" Then
      lblLabels(22).Visible = True
      DataCombo1(6).Visible = True
   End If
   
   If BuscarClaveINI("Exigir etapa de obra en circuito de compras para comprobante de proveedores") = "SI" Then
      lblLabels(22).Visible = True
      If mvarPresupuestadorObraNuevo Then
         With DataCombo1(7)
            .TOp = DataCombo1(6).TOp
            .Left = DataCombo1(6).Left
            .Width = DataCombo1(6).Width
            .Visible = True
         End With
         DataCombo1(6).Visible = False
      Else
         DataCombo1(6).Visible = True
         lblLabels(27).Visible = True
         DataCombo1(11).Visible = True
      End If
   End If
   
   If BuscarClaveINI("Tabla de colores ampliada") = "SI" Then
      lblLabels(10).Visible = True
      lblColor.Visible = True
   End If
   
   mvarLimitarEquiposDestinoSegunEtapasDeObra = False
   mAux1 = TraerValorParametro2("LimitarEquiposDestinoSegunEtapasDeObra")
   If Not IsNull(mAux1) And mAux1 = "SI" Then mvarLimitarEquiposDestinoSegunEtapasDeObra = True
   
   mvarImagenes = False
   If BuscarClaveINI("Ver imagenes de articulos en salida de materiales") = "SI" Then
      mvarImagenes = True
      VividThumbs1.Visible = True
   End If
   
   Set oPar = oAp.Parametros.Item(1)
   With oPar.Registro
      mvarIdUnidadCU = IIf(IsNull(.Fields("IdUnidadPorUnidad").Value), 0, .Fields("IdUnidadPorUnidad").Value)
      mvarIdMonedaPesos = IIf(IsNull(.Fields("IdMoneda").Value), 1, .Fields("IdMoneda").Value)
      mvarIdMonedaDolar = IIf(IsNull(.Fields("IdMonedaDolar").Value), 2, .Fields("IdMonedaDolar").Value)
      mvarBasePRONTOMantenimiento = IIf(IsNull(.Fields("BasePRONTOMantenimiento").Value), "", .Fields("BasePRONTOMantenimiento").Value)
   End With
   Set oPar = Nothing
   
   mvarIdDepositoOrigenParametro = 0
   mAux1 = TraerValorParametro2("IdDepositoCentral")
   If Not IsNull(mAux1) And IsNumeric(mAux1) Then mvarIdDepositoOrigenParametro = Val(mAux1)
   
   mAux1 = TraerValorParametro2("RegistroContableComprasAlActivo")
   mvarRegistroContableComprasAlActivo = IIf(IsNull(mAux1), "NO", mAux1)
   
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
         ElseIf TypeOf oControl Is label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Ubicaciones" Then
                  If mLimitarUbicaciones And glbIdObraAsignadaUsuario > 0 Then
                     Set oControl.RowSource = oAp.Ubicaciones.TraerFiltrado("_PorObra", glbIdObraAsignadaUsuario)
                  ElseIf glbUsarPartidasParaStock And mvarId <= 0 Then
                  Else
                     Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
                  End If
               ElseIf oControl.Tag = "Articulos1" Then
                  If mvarIdObra > 0 Then
                     Set oControl.RowSource = oAp.Articulos.TraerFiltrado("_BD_ProntoMantenimientoTodos", mvarIdObra)
                  Else
                     Set oControl.RowSource = oAp.Articulos.TraerFiltrado("_ParaMantenimiento_ParaCombo")
                  End If
               ElseIf oControl.Tag = "ObraDestinos" Then
               ElseIf oControl.Tag = "PresupuestoObrasRubros" Then
               ElseIf oControl.Tag = "PresupuestoObrasNodos" Then
               ElseIf oControl.Tag = "OrdenesTrabajo" Then
                  If Not mOTsMantenimiento Then
                     Set oControl.RowSource = oAp.OrdenesTrabajo.TraerFiltrado("_ParaCombo", Me.FechaSalida)
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
   
   If Not IsNull(origen.Registro.Fields("IdDetalleValeSalida").Value) Then
      cmd(2).Enabled = False
   End If
   
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
      If mvarId > 0 And Not glbAdministrador Then cmd(0).Enabled = False
      With origen.Registro
         If IsNull(.Fields("IdObra").Value) Then
            .Fields("IdObra").Value = oSalidaMateriales.Registro.Fields("IdObra").Value
         End If
         If Not IsNull(.Fields("IdUnidad").Value) Then
            DataCombo1(0).Locked = False
         End If
         For i = 0 To 9
            FileBrowser1(i).Text = .Fields("ArchivoAdjunto" & i + 1).Value
         Next
         txtCotizacionDolar.Text = IIf(IsNull(.Fields("CotizacionDolar").Value), 0, .Fields("CotizacionDolar").Value)
         txtCotizacionMoneda.Text = IIf(IsNull(.Fields("CotizacionMoneda").Value), 1, .Fields("CotizacionMoneda").Value)
         If mDescargaPorKit = "SI" Then
            If IIf(IsNull(.Fields("DescargaPorKit").Value), "NO", .Fields("DescargaPorKit").Value) = "NO" Then
               Option1.Value = True
            Else
               Set oRs = Aplicacion.Conjuntos.TraerFiltrado("_DetallesPorIdArticulo", DataCombo1(1).BoundText)
               If oRs.RecordCount > 0 Then
                  Option2.Value = True
               Else
                  Option1.Value = True
               End If
               oRs.Close
            End If
         End If
         If IsNull(.Fields("FechaImputacion").Value) Then
            DTFields(0).Value = Date
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
         If Not IsNull(.Fields("IdOrdenTrabajo").Value) Then
            Check1.Value = 1
         End If
         If mvarIdObra > 0 And Not IsNull(.Fields("IdEquipoDestino").Value) And Len(mvarBasePRONTOMantenimiento) > 0 Then
            Set oRs = oAp.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorId", .Fields("IdEquipoDestino").Value)
            If oRs.RecordCount > 0 Then
               With Text1
                  .TOp = DataCombo1(4).TOp
                  .Left = DataCombo1(4).Left
                  .Width = DataCombo1(4).Width
                  .Text = oRs.Fields("Material").Value
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
         If IIf(IsNull(.Fields("NumeroCaja").Value), 0, .Fields("NumeroCaja").Value) <> 0 Then
            DataCombo1(0).Enabled = False
            DataCombo1(1).Enabled = False
            DataCombo1(2).Enabled = False
            txtPartida.Enabled = False
            txtCantidad.Enabled = False
            txtCodigoArticulo.Enabled = False
            txtNumeroCaja.Enabled = False
            MostrarColor
         End If
         If mvarId > 0 And Not mDescargaPorKitHabilitada And _
               IIf(IsNull(.Fields("DescargaPorKit").Value), "", .Fields("DescargaPorKit").Value) = "SI" Then
            MsgBox "El articulo fue ingresado con descarga por kit y ahora la opcion esta deshabilitada" & vbCrLf & "No puede modificar el item", vbInformation
            cmd(0).Enabled = False
         End If
      End With
   End If

   If BuscarClaveINI("No usar partidas para stock") = "SI" Then
      lblLabels(0).Visible = False
      txtPartida.Visible = False
   End If
   
   If glbUsarPartidasParaStock Then
      lblLabels(9).Visible = True
      txtNumeroCaja.Visible = True
      If mvarId <= 0 Then
         With DataCombo1(8)
            .Left = txtPartida.Left
            .TOp = txtPartida.TOp
            .Visible = True
         End With
         txtPartida.Visible = False
      End If
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   MuestraAdjuntos
   
   If mDescargaPorKit = "NO" Then Frame1.Visible = False
   
   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then
      DataCombo1(0).Enabled = False
   End If
   
End Property

Public Property Get SalidaMateriales() As ComPronto.SalidaMateriales

   Set SalidaMateriales = oSalidaMateriales

End Property

Public Property Set SalidaMateriales(ByVal vNewValue As ComPronto.SalidaMateriales)

   Set oSalidaMateriales = vNewValue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   Dim oRs As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim mCosto As Double
   Dim mAuxI1 As Integer
   Dim mPartida As String
            
   Select Case Index
      
      Case 1
         If IsNumeric(DataCombo1(Index).BoundText) Then
            mvarParaMantenimiento = "NO"
            mExigirOT = False
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorIdConDatos", DataCombo1(1).BoundText)
            With origen.Registro
               If oRs.RecordCount > 0 And _
                     (IsNull(.Fields("IdArticulo").Value) Or _
                      .Fields("IdArticulo").Value <> DataCombo1(1).BoundText) Then
                  If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                     .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                  Else
                     .Fields("IdUnidad").Value = mvarIdUnidadCU
                  End If
                  mvarParaMantenimiento = IIf(IsNull(oRs.Fields("ParaMantenimiento").Value), "NO", oRs.Fields("ParaMantenimiento").Value)
                  If Not IsNull(oRs.Fields("ConsumirPorOT").Value) And _
                        oRs.Fields("ConsumirPorOT").Value = "SI" Then
                     mExigirOT = True
                  End If
                  mvarRegistrarStock = True
                  If Not IsNull(oRs.Fields("RegistrarStock").Value) And oRs.Fields("RegistrarStock").Value = "NO" Then
                     mvarRegistrarStock = False
                  End If
               End If
               .Fields("IdArticulo").Value = DataCombo1(1).BoundText
               If oRs.RecordCount > 0 Then
'                  DataCombo1(0).BoundText = mvarIdUnidadCU
                  If IsNull(.Fields("IdUbicacion").Value) Or mvarId = -1 Then
                     If Me.IdDepositoOrigen = 0 Or Me.IdDepositoOrigen = mvarIdDepositoOrigenParametro Then
                        .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacionStandar").Value
                     Else
                        Set oRsAux = Aplicacion.Ubicaciones.TraerFiltrado("_PorObra", Array(-1, Me.IdDepositoOrigen))
                        If oRsAux.RecordCount = 1 Then .Fields("IdUbicacion").Value = oRsAux.Fields(0).Value
                        oRsAux.Close
                     End If
                  End If
                  If mvarId = -1 Then
                     .Fields("IdMoneda").Value = mvarIdMonedaPesos
                     .Fields("CotizacionMoneda").Value = 1
                     .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                  End If
                  If Right(IIf(IsNull(oRs.Fields("Codigo").Value), "0000", oRs.Fields("Codigo").Value), 4) = "9999" And _
                        Not IsNull(.Fields("IdDetalleValeSalida").Value) Then
                     Set oRsAux = Aplicacion.TablasGenerales.TraerFiltrado("DetValesSalida", "_TodoMasPendientePorIdDetalle", .Fields("IdDetalleValeSalida").Value)
                     If oRsAux.RecordCount > 0 Then
                        mCosto = IIf(IsNull(oRsAux.Fields("CostoRecepcion").Value), 0, oRsAux.Fields("CostoRecepcion").Value)
                     End If
                     oRsAux.Close
                  Else
                     If mCostoATomar = "CostoReposicion" Then
                        mCosto = IIf(IsNull(oRs.Fields("CostoReposicion").Value), 0, oRs.Fields("CostoReposicion").Value)
                     Else
                        mCosto = IIf(IsNull(oRs.Fields("CostoPPP").Value), 0, oRs.Fields("CostoPPP").Value)
                     End If
                  End If
                  If mvarId <= 0 Then
                     .Fields("CostoUnitario").Value = mCosto
                  Else
                     If IIf(IsNull(.Fields("CostoUnitario").Value), 0, .Fields("CostoUnitario").Value) <> mCosto And Me.Visible Then
                        mAuxI1 = MsgBox("El costo unitario se ha modificado, desea actualizarlo?", vbYesNo, "Costo unitario")
                        If mAuxI1 = vbYes Then .Fields("CostoUnitario").Value = mCosto
                     End If
                  End If
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
                  MostrarStockActual
               
                  mvarADistribuirEnPresupuestoDeObra = IIf(IsNull(oRs.Fields("ADistribuirEnPresupuestoDeObra").Value), "NO", oRs.Fields("ADistribuirEnPresupuestoDeObra").Value)
                  If mvarRegistroContableComprasAlActivo = "SI" And mvarADistribuirEnPresupuestoDeObra = "SI" And _
                        IIf(IsNull(oRs.Fields("IdCuentaComprasActivo").Value), 0, oRs.Fields("IdCuentaComprasActivo").Value) <> 0 Then
                     lblCuentas(0).Visible = True
                     lblCuentas(1).Visible = True
                     lblCuentas(2).Visible = True
                     DataCombo2(0).Visible = True
                     DataCombo2(1).Visible = True
                     DataCombo2(3).Visible = True
                     txtCodigoCuenta.Visible = True
                     Check2.Visible = True
                     
                     lblCuentas(0).Enabled = False
                     lblCuentas(1).Enabled = False
                     lblCuentas(2).Enabled = False
                     DataCombo2(0).Enabled = False
                     DataCombo2(1).Enabled = False
                     DataCombo2(3).Enabled = False
                     txtCodigoCuenta.Enabled = False
                     Check2.Enabled = False
                     With origen.Registro
                        If Not IsNull(oRs.Fields("IdCuentaCompras").Value) Then
                           .Fields("IdCuenta").Value = oRs.Fields("IdCuentaCompras").Value
                           .Fields("IdCuentaGasto").Value = Null
                        Else
                           .Fields("IdCuenta").Value = Null
                           .Fields("IdCuentaGasto").Value = Null
                        End If
                     End With
                  Else
                     lblCuentas(0).Visible = False
                     lblCuentas(1).Visible = False
                     lblCuentas(2).Visible = False
                     DataCombo2(0).Visible = False
                     DataCombo2(1).Visible = False
                     DataCombo2(3).Visible = False
                     txtCodigoCuenta.Visible = False
                     Check2.Visible = False
                     With origen.Registro
                        .Fields("IdCuenta").Value = Null
                        .Fields("IdCuentaGasto").Value = Null
                     End With
                  End If
               End If
            End With
            oRs.Close
            If mvarImagenes Then
               If CargarImagenesThumbs(DataCombo1(Index).BoundText, Me) = -1 Then
                  Me.Width = mvarAnchoForm * 1.2
               Else
                  Me.Width = mvarAnchoForm
               End If
            End If
            
            mDescargaPorKitHabilitada = False
            If mDescargaPorKit = "SI" Then
               Set oRs = Aplicacion.Conjuntos.TraerFiltrado("_DetallesPorIdArticulo", DataCombo1(1).BoundText)
               If oRs.RecordCount > 0 Then
                  Frame1.Enabled = True
                  mDescargaPorKitHabilitada = True
               Else
                  Option1.Value = True
                  Frame1.Enabled = False
               End If
               oRs.Close
            End If
         
            If glbUsarPartidasParaStock And mvarId <= 0 Then
               Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PartidasDisponibles", DataCombo1(1).BoundText)
               Set DataCombo1(8).RowSource = oRs
               mPartida = ""
               If Not IsNull(origen.Registro.Fields("Partida").Value) Then
                  mPartida = origen.Registro.Fields("Partida").Value
               Else
                  If oRs.RecordCount = 1 Then mPartida = oRs.Fields("Partida").Value
               End If
               DataCombo1(8).BoundText = mPartida
               If oRs.RecordCount = 0 Then Set DataCombo1(2).RowSource = Aplicacion.Ubicaciones.TraerLista
            End If
         End If
         
      Case 3
         If IsNumeric(DataCombo1(Index).BoundText) Then
            If mvarPresupuestadorObraNuevo Then
               Set oRs = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_EtapasImputablesPorObraParaCombo", Array(DataCombo1(Index).BoundText, "M"))
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
               Set oRs = Aplicacion.Obras.TraerFiltrado("_DestinosParaComboPorIdObra", DataCombo1(Index).BoundText)
               If oRs.RecordCount = 0 Then
                  origen.Registro.Fields(DataCombo1(6).DataField).Value = Null
                  DataCombo1(6).Enabled = False
                  oRs.Close
               ElseIf oRs.RecordCount = 1 Then
                  DataCombo1(6).Enabled = True
                  Set DataCombo1(6).RowSource = oRs
                  origen.Registro.Fields(DataCombo1(6).DataField).Value = oRs.Fields(0).Value
               Else
                  DataCombo1(6).Enabled = True
                  Set DataCombo1(6).RowSource = oRs
               End If
            End If
            MostrarStockActual
         End If
   
      Case 4
         If IsNumeric(DataCombo1(Index).BoundText) Then
            origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorId", _
                           Array(DataCombo1(Index).BoundText, mvarIdObra))
'            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then
               txtCodigoArticulo1.Text = IIf(IsNull(oRs.Fields("NumeroInventario").Value), "", oRs.Fields("NumeroInventario").Value)
            End If
            oRs.Close
            
            dcfields(7).Enabled = True
            If mOTsMantenimiento Then
               Set dcfields(7).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("ProntoMantenimiento", "_OTsPorEquipo", DataCombo1(Index).BoundText)
            End If
         Else
            dcfields(7).Enabled = False
         End If
   
      Case 5
         origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
         MuestraAdjuntos
   
      Case 6
         If IsNumeric(DataCombo1(Index).BoundText) Then
            origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
            If mvarLimitarEquiposDestinoSegunEtapasDeObra Then
               If Me.Visible Then origen.Registro.Fields(DataCombo1(4).DataField).Value = Null
               Set oRs = Aplicacion.Articulos.TraerFiltrado("_ParaMantenimiento_ParaCombo", DataCombo1(Index).BoundText)
               If oRs.RecordCount = 1 Then
                  If IsNull(origen.Registro.Fields(DataCombo1(4).DataField).Value) Then
                     origen.Registro.Fields(DataCombo1(4).DataField).Value = oRs.Fields(0).Value
                  End If
               End If
               Set DataCombo1(4).RowSource = oRs
               If Not IsNull(origen.Registro.Fields(DataCombo1(4).DataField).Value) Then
                  DataCombo1(4).BoundText = origen.Registro.Fields(DataCombo1(4).DataField).Value
               End If
               Set oRs = Nothing
            End If
         
            Dim mIdPresupuestoObraRubro As Long, mTipoConsumo As Integer
            If Not IsNull(origen.Registro.Fields(DataCombo1(11).DataField).Value) Then
               mIdPresupuestoObraRubro = origen.Registro.Fields(DataCombo1(11).DataField).Value
            Else
               mIdPresupuestoObraRubro = 0
            End If
            mTipoConsumo = 3
            If IsNumeric(DataCombo1(Index).BoundText) Then
               Set oRs = Aplicacion.TablasGenerales.TraerUno("DetObrasDestinos", DataCombo1(Index).BoundText)
               If oRs.RecordCount > 0 Then
                  mTipoConsumo = IIf(IsNull(oRs.Fields("TipoConsumo").Value), 3, oRs.Fields("TipoConsumo").Value)
               End If
               oRs.Close
            End If
            Set oRs = Aplicacion.PresupuestoObrasRubros.TraerFiltrado("_ParaComboPorTipoConsumo", mTipoConsumo)
            Set DataCombo1(11).RowSource = oRs
            Set oRs = Nothing
         End If
      
      Case 8
         If glbUsarPartidasParaStock And mvarId <= 0 And Len(DataCombo1(Index).BoundText) > 0 Then
            Dim mIdUbicacion As Long
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PartidasDisponibles", Array(DataCombo1(1).BoundText, DataCombo1(Index).BoundText))
            Set DataCombo1(2).RowSource = oRs
            mIdUbicacion = 0
            If Not IsNull(origen.Registro.Fields("IdUbicacion").Value) Then
               mIdUbicacion = origen.Registro.Fields("IdUbicacion").Value
            End If
            If oRs.RecordCount = 1 Then mIdUbicacion = oRs.Fields("IdUbicacion").Value
            DataCombo1(2).BoundText = mIdUbicacion
         End If
      
      Case Else
         If IsNumeric(DataCombo1(Index).BoundText) Then
            origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
         End If
   
   End Select
      
   Set oRs = Nothing
   Set oRsAux = Nothing

End Sub

Private Sub DataCombo1_Click(Index As Integer, Area As Integer)

   If Index <> 1 And Index <> 4 Then SetDataComboDropdownListWidth 400

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DataCombo2_Change(Index As Integer)

   If IsNumeric(DataCombo2(Index).BoundText) Then
      Dim oRs As ADOR.Recordset
      Dim i As Integer, mIdAux As Long
      
      Select Case Index
         Case 0
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorIdConDatos", Array(DataCombo2(0).BoundText, Me.FechaSalida))
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  .Fields(DataCombo2(0).DataField).Value = DataCombo2(0).BoundText
                  txtCodigoCuenta.Text = oRs.Fields("Codigo1").Value
                  If Not IsNull(oRs.Fields("IdObra").Value) Then .Fields("IdObra").Value = oRs.Fields("IdObra").Value
               End With
            Else
               txtCodigoCuenta.Text = ""
            End If
            oRs.Close
         
         Case 1
            If DataCombo2(1).Enabled Then
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorObraCuentaGasto", _
                           Array(DataCombo1(3).BoundText, DataCombo2(1).BoundText, Me.FechaSalida))
               If oRs.RecordCount > 0 Then
                  If Len(DataCombo2(3).Text) > 0 Then
                     DataCombo2(3).BoundText = 0
                     Set DataCombo2(0).RowSource = Aplicacion.Cuentas.TraerLista
                  End If
                  With origen.Registro
                     .Fields(DataCombo2(1).DataField).Value = oRs.Fields("IdCuentaGasto").Value
                     .Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
                     txtCodigoCuenta.Text = oRs.Fields("Codigo").Value
                  End With
               End If
               oRs.Close
            Else
               With origen.Registro
                  .Fields(DataCombo1(1).DataField).Value = Null
               End With
            End If
            txtCodigoCuenta.Enabled = False
            DataCombo2(0).Enabled = False
            DataCombo2(3).Enabled = False
            Check2.Value = 1
         
         Case 3
            If IsNumeric(DataCombo2(3).BoundText) Then
               txtCodigoCuenta.Text = ""
               Dim mIdCuenta As Long
               If IsNumeric(DataCombo2(0).BoundText) Then
                  mIdCuenta = DataCombo2(0).BoundText
               Else
                  mIdCuenta = 0
               End If
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorGrupoParaCombo", Array(DataCombo2(3).BoundText, Me.FechaSalida))
               Set DataCombo2(0).RowSource = oRs
               origen.Registro.Fields(DataCombo2(0).DataField).Value = mIdCuenta
               Set oRs = Nothing
            End If
      End Select
      Set oRs = Nothing
   End If

End Sub

Private Sub DataCombo2_Click(Index As Integer, Area As Integer)

   SetDataComboDropdownListWidth 400

End Sub

Private Sub DataCombo2_KeyPress(Index As Integer, KeyAscii As Integer)

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
      Case 7
         Check1.Value = 1
   End Select
   
End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

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

Private Sub Form_Load()

   'DisableCloseButton Me
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

Private Sub Form_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then ' si el dato es texto
      
      s = Data.GetData(ccCFText) ' tomo el dato
      
      Filas = Split(s, vbCrLf) ' armo un vector por filas
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      Columnas = Split(Filas(0), vbTab)
      
      If Columnas(1) = "Stock" Then
         Columnas = Split(Filas(1), vbTab) ' armo un vector con las columnas
         Set oAp = Aplicacion
         Set oRs = oAp.Articulos.TraerFiltrado("_Stock", Columnas(0))
         If oRs.RecordCount > 0 Then
            With origen.Registro
               .Fields("Cantidad").Value = 0
               .Fields("Cantidad1").Value = 0
               .Fields("Cantidad2").Value = 0
               .Fields("Partida").Value = oRs.Fields("Partida").Value
               .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
               .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
               .Fields("IdStock").Value = oRs.Fields("IdStock").Value
               .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacion").Value
            End With
            DataCombo1(0).BoundText = oRs.Fields("IdUnidad").Value
         End If
         oRs.Close
      ElseIf Columnas(1) = "StockPorPartida" Then
         Columnas = Split(Filas(1), vbTab) ' armo un vector con las columnas
         Set oAp = Aplicacion
         Set oRs = oAp.Articulos.TraerFiltrado("_Stock", Columnas(0))
         If oRs.RecordCount > 0 Then
            With origen.Registro
               .Fields("Partida").Value = oRs.Fields("Partida").Value
               .Fields("IdStock").Value = oRs.Fields("IdStock").Value
            End With
         End If
         oRs.Close
      Else
         MsgBox "Informacion invalida!", vbCritical
         Exit Sub
      End If
      
      Set oRs = Nothing
      Set oAp = Nothing
      
      Clipboard.Clear
      
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

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Public Property Let TipoSalida(ByVal vNewValue As Integer)

   mTipoSalida = vNewValue

End Property

Private Sub txtBusca_GotFocus()

   With txtBusca
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBusca_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      If KeyAscii = 13 Then
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set DataCombo1(1).RowSource = Aplicacion.Articulos.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set DataCombo1(1).RowSource = Aplicacion.Articulos.TraerLista
         End If
      End If
      DataCombo1(1).SetFocus
      SendKeys "%{DOWN}"
   End If

End Sub

Private Sub txtBusca1_GotFocus()

   With txtBusca1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBusca1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      If KeyAscii = 13 Then
         If Len(Trim(txtBusca1.Text)) <> 0 Then
            Set DataCombo1(4).RowSource = Aplicacion.Articulos.TraerFiltrado("_Busca", txtBusca1.Text)
         Else
            Set DataCombo1(4).RowSource = Aplicacion.Articulos.TraerLista
         End If
      End If
      DataCombo1(4).SetFocus
      SendKeys "%{DOWN}"
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

Private Sub txtCantidad1_Validate(Cancel As Boolean)

   origen.Registro.Fields("Cantidad1").Value = Val(txtCantidad1.Text)

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

Private Sub txtCantidad_GotFocus()
   
   With txtCantidad
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCantidad2_Validate(Cancel As Boolean)

   origen.Registro.Fields("Cantidad2").Value = Val(txtCantidad2.Text)

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
      mvarParaMantenimiento = "NO"
      mExigirOT = False
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo.Text)
      If oRs.RecordCount > 0 Then
         With origen.Registro
            .Fields("IdArticulo").Value = oRs.Fields(0).Value
            If Not IsNull(oRs.Fields("IdUnidad").Value) Then
               .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
            Else
               .Fields("IdUnidad").Value = mvarIdUnidadCU
            End If
         End With
         mvarParaMantenimiento = IIf(IsNull(oRs.Fields("ParaMantenimiento").Value), "NO", oRs.Fields("ParaMantenimiento").Value)
         If Not IsNull(oRs.Fields("ConsumirPorOT").Value) And _
               oRs.Fields("ConsumirPorOT").Value = "SI" Then
            mExigirOT = True
         End If
         MostrarStockActual
      Else
         MsgBox "Codigo de material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo.Text = ""
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
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
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorNumeroInventario", _
                     Array(txtCodigoArticulo1.Text, mvarIdObra))
'      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorNumeroInventario", txtCodigoArticulo1.Text)
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

Private Sub txtCodigoCuenta_Change()

   If IsNumeric(txtCodigoCuenta.Text) Then
      On Error GoTo SalidaConError
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorCodigo", Array(txtCodigoCuenta.Text, Me.FechaSalida))
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
      origen.Registro.Fields("IdCuenta").Value = Null
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

Private Sub txtCotizacionDolar_GotFocus()

   With txtCotizacionDolar
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCotizacionDolar_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCotizacionDolar_Validate(Cancel As Boolean)

   If origen.Registro.Fields("IdMoneda").Value = mvarIdMonedaDolar Then
      txtCotizacionMoneda.Text = txtCotizacionDolar.Text
   End If

End Sub

Private Sub txtCotizacionMoneda_GotFocus()

   With txtCotizacionMoneda
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCotizacionMoneda_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCotizacionMoneda_Validate(Cancel As Boolean)

   If origen.Registro.Fields("IdMoneda").Value = mvarIdMonedaDolar Then
      txtCotizacionDolar.Text = txtCotizacionMoneda.Text
   End If

End Sub

Private Sub txtNumeroCaja_GotFocus()

   With txtNumeroCaja
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroCaja_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroCaja_Validate(Cancel As Boolean)

   If Len(txtNumeroCaja.Text) = 0 Then
      origen.Registro.Fields(txtNumeroCaja.DataField).Value = Null
      DataCombo1(1).Enabled = True
      DataCombo1(2).Enabled = True
      If DataCombo1(8).Visible Then DataCombo1(8).Enabled = True
      txtPartida.Enabled = True
      txtCantidad.Enabled = True
      txtCodigoArticulo.Enabled = True
   Else
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorNumeroCaja", txtNumeroCaja.Text)
      If oRs.RecordCount > 0 Then
         With origen.Registro
            .Fields("IdArticulo").Value = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
            .Fields("IdUnidad").Value = IIf(IsNull(oRs.Fields("IdUnidad").Value), 0, oRs.Fields("IdUnidad").Value)
            .Fields("Cantidad").Value = IIf(IsNull(oRs.Fields("CantidadUnidades").Value), 0, oRs.Fields("CantidadUnidades").Value)
            .Fields("IdUbicacion").Value = IIf(IsNull(oRs.Fields("IdUbicacion").Value), 0, oRs.Fields("IdUbicacion").Value)
            .Fields("Partida").Value = IIf(IsNull(oRs.Fields("Partida").Value), "", oRs.Fields("Partida").Value)
            If DataCombo1(8).Visible Then DataCombo1(8).BoundText = IIf(IsNull(oRs.Fields("Partida").Value), "", oRs.Fields("Partida").Value)
            lblColor.Caption = IIf(IsNull(oRs.Fields("Color").Value), "", oRs.Fields("Color").Value)
         End With
         DataCombo1(0).Enabled = False
         DataCombo1(1).Enabled = False
         DataCombo1(2).Enabled = False
         If DataCombo1(8).Visible Then DataCombo1(8).Enabled = False
         txtPartida.Enabled = False
         txtCantidad.Enabled = False
         txtCodigoArticulo.Enabled = False
      Else
         MsgBox "Caja inexistente en stock", vbCritical
         Cancel = True
      End If
      oRs.Close
      Set oRs = Nothing
   End If

End Sub

Private Sub txtPartida_GotFocus()

   With txtPartida
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPartida_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub MuestraAdjuntos()

   Dim i As Integer
   
   If IsNull(origen.Registro.Fields("Adjunto").Value) Or origen.Registro.Fields("Adjunto").Value = "NO" Then
      For i = 0 To 9
         lblAdjuntos(i).Visible = False
         FileBrowser1(i).Visible = False
         FileBrowser1(i).Text = ""
      Next
      Line1.Visible = False
      Me.Height = 6000
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
      Me.Height = 8500
   End If
      
End Sub

Public Sub MostrarStockActual()

   If IsNumeric(DataCombo1(1).BoundText) Then
      If BuscarClaveINI("Mostrar solo stock de obra en salidas") = "SI" And IsNumeric(DataCombo1(3).BoundText) Then
         txtStockActual.Text = Aplicacion.StockPorIdArticuloIdObra(DataCombo1(1).BoundText, DataCombo1(3).BoundText)
      Else
         txtStockActual.Text = Aplicacion.StockPorIdArticulo(DataCombo1(1).BoundText)
      End If
   End If

End Sub

Public Property Get IdDepositoOrigen() As Long

   IdDepositoOrigen = mvarIdDepositoOrigen

End Property

Public Property Let IdDepositoOrigen(ByVal vNewValue As Long)

   mvarIdDepositoOrigen = vNewValue

End Property

Public Property Get FechaSalida() As Date

   FechaSalida = mvarFechaSalida

End Property

Public Property Let FechaSalida(ByVal vNewValue As Date)

   mvarFechaSalida = vNewValue

End Property

Private Sub VividThumbs1_ThumbClick(Filename As String, X As Single, Y As Single)

   If Len(Filename) > 0 Then
      If Not Len(Trim(Dir(Filename))) <> 0 Then
         MsgBox "El archivo indicado no existe!", vbExclamation
         Exit Sub
      End If
      Call ShellExecute(Me.hwnd, "open", Filename, vbNullString, vbNullString, SW_SHOWNORMAL)
   End If

End Sub

Public Sub MostrarColor()

   Dim oRs As ADOR.Recordset
   
   If Len(txtNumeroCaja.Text) > 0 Then
      Set oRs = Aplicacion.UnidadesEmpaque.TraerFiltrado("_PorNumero", txtNumeroCaja.Text)
      If oRs.RecordCount > 0 Then
         lblColor.Caption = IIf(IsNull(oRs.Fields("Color").Value), "", oRs.Fields("Color").Value)
      End If
      oRs.Close
   End If
      
   Set oRs = Nothing

End Sub
