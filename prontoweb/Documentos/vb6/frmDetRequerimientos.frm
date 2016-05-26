VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{126E538A-EE41-4B22-A045-F8D5538F5D2B}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmDetRequerimientos 
   Caption         =   "Item de requerimiento de materiales"
   ClientHeight    =   8025
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10800
   Icon            =   "frmDetRequerimientos.frx":0000
   LinkTopic       =   "Form1"
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   8025
   ScaleWidth      =   10800
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtMoP 
      Alignment       =   2  'Center
      DataField       =   "MoP"
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
      Left            =   9225
      TabIndex        =   80
      Top             =   5040
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.TextBox txtCodigoDistribucion 
      Alignment       =   2  'Center
      DataField       =   "CodigoDistribucion"
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
      Left            =   7785
      TabIndex        =   78
      Top             =   5040
      Visible         =   0   'False
      Width           =   600
   End
   Begin VB.TextBox txtFigura 
      Alignment       =   2  'Center
      DataField       =   "Figura"
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
      Left            =   5085
      TabIndex        =   76
      Top             =   5040
      Visible         =   0   'False
      Width           =   600
   End
   Begin VB.TextBox txtItem1 
      Alignment       =   2  'Center
      DataField       =   "Item"
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
      Left            =   3600
      TabIndex        =   74
      Top             =   5040
      Visible         =   0   'False
      Width           =   600
   End
   Begin VB.TextBox txtPagina 
      Alignment       =   2  'Center
      DataField       =   "Pagina"
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
      Left            =   2025
      TabIndex        =   72
      Top             =   5040
      Visible         =   0   'False
      Width           =   870
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
      Left            =   2025
      TabIndex        =   69
      Top             =   4680
      Visible         =   0   'False
      Width           =   2445
   End
   Begin VB.Frame Frame2 
      Caption         =   "Tomar la descripcion de : "
      Height          =   1050
      Left            =   8235
      TabIndex        =   65
      Top             =   2385
      Width           =   2490
      Begin VB.OptionButton Option2 
         Caption         =   "Solo las observaciones"
         Height          =   195
         Left            =   90
         TabIndex        =   68
         Top             =   495
         Width           =   2040
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Solo el material"
         Height          =   195
         Left            =   90
         TabIndex        =   67
         Top             =   225
         Width           =   1410
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Material mas observaciones"
         Height          =   195
         Left            =   90
         TabIndex        =   66
         Top             =   765
         Width           =   2265
      End
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
      Height          =   315
      Left            =   4500
      TabIndex        =   62
      Top             =   3105
      Visible         =   0   'False
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
      Left            =   2025
      TabIndex        =   4
      Top             =   900
      Width           =   1725
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
      Left            =   6210
      TabIndex        =   60
      Top             =   3105
      Visible         =   0   'False
      Width           =   330
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Registrar material"
      Height          =   360
      Index           =   5
      Left            =   5040
      TabIndex        =   59
      Top             =   5445
      Width           =   1485
   End
   Begin VB.Frame Frame1 
      Height          =   375
      Left            =   7695
      TabIndex        =   36
      Top             =   1215
      Visible         =   0   'False
      Width           =   2985
      Begin VB.OptionButton Option4 
         Caption         =   "No"
         Height          =   195
         Left            =   1710
         TabIndex        =   38
         Top             =   135
         Width           =   510
      End
      Begin VB.OptionButton Option5 
         Caption         =   "Si"
         Height          =   195
         Left            =   2385
         TabIndex        =   37
         Top             =   135
         Width           =   465
      End
      Begin VB.Label lblLabels 
         Caption         =   "Es un bien de uso ?"
         Height          =   165
         Index           =   10
         Left            =   90
         TabIndex        =   64
         Top             =   135
         Width           =   1455
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Activar"
      Height          =   315
      Index           =   4
      Left            =   6525
      TabIndex        =   34
      Top             =   45
      Width           =   765
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Activar"
      Height          =   315
      Index           =   3
      Left            =   6615
      TabIndex        =   33
      Top             =   2745
      Width           =   765
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   1395
      TabIndex        =   12
      Top             =   6030
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
      Height          =   1140
      Left            =   2025
      TabIndex        =   35
      Top             =   3465
      Width           =   8700
      _ExtentX        =   15346
      _ExtentY        =   2011
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmDetRequerimientos.frx":076A
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   360
      Index           =   0
      Left            =   45
      TabIndex        =   13
      Top             =   5445
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   360
      Index           =   1
      Left            =   1710
      TabIndex        =   14
      Top             =   5445
      Width           =   1485
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
      Left            =   2025
      TabIndex        =   16
      Top             =   60
      Width           =   645
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
      Left            =   7650
      TabIndex        =   20
      Top             =   510
      Width           =   3075
   End
   Begin VB.TextBox txtCantidad2 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad2"
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
      Left            =   5220
      TabIndex        =   8
      Top             =   1995
      Width           =   645
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
      Left            =   2025
      TabIndex        =   5
      Top             =   1995
      Width           =   870
   End
   Begin VB.TextBox txtCantidad1 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad1"
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
      Left            =   4140
      TabIndex        =   7
      Top             =   1995
      Width           =   645
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Buscar en L.M."
      Height          =   360
      Index           =   2
      Left            =   3375
      TabIndex        =   15
      Top             =   5445
      Width           =   1485
   End
   Begin VB.TextBox txtNumeroLMateriales 
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
      Height          =   315
      Left            =   2025
      Locked          =   -1  'True
      TabIndex        =   17
      Top             =   555
      Width           =   1185
   End
   Begin VB.TextBox txtNumeroItemLMateriales 
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
      Height          =   315
      Left            =   5175
      Locked          =   -1  'True
      TabIndex        =   18
      Top             =   540
      Width           =   690
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
      Left            =   5940
      TabIndex        =   19
      Top             =   1995
      Width           =   1635
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   3825
      TabIndex        =   1
      Tag             =   "Articulos"
      Top             =   900
      Width           =   6900
      _ExtentX        =   12171
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
      Left            =   2925
      TabIndex        =   6
      Tag             =   "Unidades"
      Top             =   1995
      Width           =   1140
      _ExtentX        =   2011
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
      Left            =   2025
      TabIndex        =   10
      Tag             =   "ControlesCalidad"
      Top             =   2745
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
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaEntrega"
      Height          =   360
      Index           =   0
      Left            =   5175
      TabIndex        =   0
      Top             =   45
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   635
      _Version        =   393216
      Enabled         =   0   'False
      Format          =   61014017
      CurrentDate     =   36526
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "Adjunto"
      Height          =   315
      Index           =   5
      Left            =   2025
      TabIndex        =   11
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
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCentroCosto"
      Height          =   315
      Index           =   2
      Left            =   2025
      TabIndex        =   9
      Tag             =   "CentrosCosto"
      Top             =   2385
      Visible         =   0   'False
      Width           =   4515
      _ExtentX        =   7964
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCentroCosto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   3
      Left            =   2025
      TabIndex        =   3
      Tag             =   "Cuentas"
      Top             =   1620
      Visible         =   0   'False
      Width           =   5595
      _ExtentX        =   9869
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   1
      Left            =   1395
      TabIndex        =   40
      Top             =   6435
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
      Left            =   1395
      TabIndex        =   41
      Top             =   6840
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
      Left            =   1395
      TabIndex        =   42
      Top             =   7245
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
      Left            =   1395
      TabIndex        =   43
      Top             =   7650
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
      Left            =   6975
      TabIndex        =   44
      Top             =   6030
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
      Left            =   6975
      TabIndex        =   45
      Top             =   6435
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
      Left            =   6975
      TabIndex        =   46
      Top             =   6840
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
      Left            =   6975
      TabIndex        =   47
      Top             =   7245
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
      Left            =   6975
      TabIndex        =   48
      Top             =   7650
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
      DataField       =   "IdEquipo"
      Height          =   315
      Index           =   6
      Left            =   2025
      TabIndex        =   2
      Tag             =   "Equipos"
      Top             =   1260
      Visible         =   0   'False
      Width           =   5595
      _ExtentX        =   9869
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEquipo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdEquipoDestino"
      Height          =   315
      Index           =   7
      Left            =   4500
      TabIndex        =   70
      Tag             =   "Articulos1"
      Top             =   4680
      Visible         =   0   'False
      Width           =   6225
      _ExtentX        =   10980
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdDetalleObraDestino"
      Height          =   315
      Index           =   8
      Left            =   8820
      TabIndex        =   83
      Tag             =   "ObrasDestinos"
      Top             =   1575
      Visible         =   0   'False
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
      DataField       =   "IdPresupuestoObraRubro"
      Height          =   315
      Index           =   11
      Left            =   8820
      TabIndex        =   84
      Tag             =   "PresupuestoObrasRubros"
      Top             =   1935
      Visible         =   0   'False
      Width           =   1860
      _ExtentX        =   3281
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPresupuestoObraRubro"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Rubro p/pres.:"
      Height          =   255
      Index           =   27
      Left            =   7695
      TabIndex        =   85
      Top             =   1980
      Visible         =   0   'False
      Width           =   1050
   End
   Begin VB.Label lblLabels 
      Caption         =   "Etapa obra :"
      Height          =   255
      Index           =   19
      Left            =   7695
      TabIndex        =   82
      Top             =   1620
      Visible         =   0   'False
      Width           =   1050
   End
   Begin VB.Label lblLabels 
      Caption         =   "M/P :"
      Height          =   255
      Index           =   18
      Left            =   8685
      TabIndex        =   81
      Top             =   5085
      Visible         =   0   'False
      Width           =   465
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de distribucion :"
      Height          =   255
      Index           =   17
      Left            =   5940
      TabIndex        =   79
      Top             =   5085
      Visible         =   0   'False
      Width           =   1770
   End
   Begin VB.Label lblLabels 
      Caption         =   "Figura :"
      Height          =   255
      Index           =   16
      Left            =   4410
      TabIndex        =   77
      Top             =   5070
      Visible         =   0   'False
      Width           =   600
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item :"
      Height          =   255
      Index           =   15
      Left            =   3060
      TabIndex        =   75
      Top             =   5070
      Visible         =   0   'False
      Width           =   465
   End
   Begin VB.Label lblLabels 
      Caption         =   "Pagina :"
      Height          =   255
      Index           =   13
      Left            =   45
      TabIndex        =   73
      Top             =   5070
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Equipo destino :"
      Height          =   300
      Index           =   11
      Left            =   45
      TabIndex        =   71
      Top             =   4680
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Costo unitario :"
      Height          =   255
      Index           =   8
      Left            =   3240
      TabIndex        =   63
      Top             =   3135
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Equipo :"
      Height          =   270
      Index           =   6
      Left            =   45
      TabIndex        =   61
      Top             =   1305
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 10 :"
      Height          =   300
      Index           =   9
      Left            =   5625
      TabIndex        =   58
      Top             =   7695
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 9 :"
      Height          =   300
      Index           =   8
      Left            =   5625
      TabIndex        =   57
      Top             =   7290
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 8 :"
      Height          =   300
      Index           =   7
      Left            =   5625
      TabIndex        =   56
      Top             =   6885
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 7 :"
      Height          =   300
      Index           =   6
      Left            =   5625
      TabIndex        =   55
      Top             =   6480
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 6 :"
      Height          =   300
      Index           =   5
      Left            =   5625
      TabIndex        =   54
      Top             =   6075
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 5 :"
      Height          =   300
      Index           =   4
      Left            =   45
      TabIndex        =   53
      Top             =   7650
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 4 :"
      Height          =   300
      Index           =   3
      Left            =   45
      TabIndex        =   52
      Top             =   7245
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 3 :"
      Height          =   300
      Index           =   2
      Left            =   45
      TabIndex        =   51
      Top             =   6840
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 2 :"
      Height          =   300
      Index           =   1
      Left            =   45
      TabIndex        =   50
      Top             =   6435
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 1 :"
      Height          =   300
      Index           =   0
      Left            =   45
      TabIndex        =   49
      Top             =   6030
      Width           =   1230
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000005&
      BorderWidth     =   3
      X1              =   -45
      X2              =   10710
      Y1              =   5940
      Y2              =   5940
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta contable :"
      Height          =   255
      Index           =   9
      Left            =   45
      TabIndex        =   39
      Top             =   1665
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Centro de costo :"
      Height          =   300
      Index           =   6
      Left            =   45
      TabIndex        =   32
      Top             =   2400
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Adjuntos ? :"
      Height          =   255
      Index           =   12
      Left            =   45
      TabIndex        =   31
      Top             =   3150
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   5
      Left            =   45
      TabIndex        =   30
      Top             =   3510
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de necesidad :"
      Height          =   300
      Index           =   1
      Left            =   3330
      TabIndex        =   29
      Top             =   90
      Width           =   1770
   End
   Begin VB.Label lblData 
      Caption         =   "Control de calidad :"
      Height          =   255
      Index           =   4
      Left            =   45
      TabIndex        =   28
      Top             =   2775
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   255
      Index           =   2
      Left            =   45
      TabIndex        =   27
      Top             =   945
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   45
      TabIndex        =   26
      Top             =   2025
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de item :"
      Height          =   300
      Index           =   3
      Left            =   45
      TabIndex        =   25
      Top             =   105
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
      Height          =   210
      Index           =   14
      Left            =   7650
      TabIndex        =   24
      Top             =   285
      Width           =   870
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
      Left            =   4860
      TabIndex        =   23
      Top             =   2040
      Width           =   285
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro. lista de materiales :"
      Height          =   300
      Index           =   0
      Left            =   45
      TabIndex        =   22
      Top             =   585
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item lista de materiales :"
      Height          =   300
      Index           =   4
      Left            =   3375
      TabIndex        =   21
      Top             =   555
      Width           =   1725
   End
   Begin VB.Menu falseado 
      Caption         =   "falseado"
      Enabled         =   0   'False
      Visible         =   0   'False
   End
End
Attribute VB_Name = "frmDetRequerimientos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetRequerimiento
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oRequerimiento As ComPronto.Requerimiento
Private mvarIdUnidadCU As Integer
Public Aceptado As Boolean
Private mEstadoFechaNecesidad As Boolean, mHabilitadaParaModificar As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long
Private mvarIdEquipoDestino As Long
Private mvarPathAdjuntos As String, mvarTipoRequerimiento As String
Private mvarFechaRequerimiento As Date
Private WithEvents cP As cPopupMenu
Attribute cP.VB_VarHelpID = -1

Private Sub cmd_Click(Index As Integer)

   Dim oF1 As frmAutorizacion2
   Dim oRs As ADOr.Recordset
   Dim mvarOK As Boolean, mvarCancelo As Boolean
   Dim i As Integer
         
   On Error GoTo Mal
   
   Select Case Index
      Case 0
         If BuscarClaveINI("Exigir fecha necesidad mayor a fecha de RM") = "SI" Then
            If DTFields(0).Value <= Me.FechaRequerimiento Then
               MsgBox "La fecha de necesidad no puede ser anterior a la fecha del requerimiento", vbExclamation
               Exit Sub
            End If
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
      
         For Each dtp In DTFields
            If dtp.Enabled Then origen.Registro.Fields(dtp.DataField).Value = dtp.Value
         Next
      
         If DataCombo1(7).Visible And Not IsNumeric(DataCombo1(7).BoundText) Then
            If Me.TipoRequerimiento = "OP" Then
               MsgBox "Para una RM OP debe indicar el equipo destino", vbExclamation
               Exit Sub
            End If
            If Len(DataCombo1(7).Text) > 0 Then
               MsgBox "El equipo destino no existe", vbExclamation
               Exit Sub
            End If
         End If
         
         If BuscarClaveINI("Exigir etapa de obra en circuito de compras para requerimientos") = "SI" Then
            If DataCombo1(8).Visible And Not IsNumeric(DataCombo1(8).BoundText) Then
               MsgBox "Debe ingresar la etapa de la obra", vbExclamation
               Exit Sub
            End If
            If DataCombo1(11).Visible And Not IsNumeric(DataCombo1(11).BoundText) Then
               MsgBox "Debe ingresar el rubro para presupuesto de obra", vbExclamation
               Exit Sub
            End If
         End If
         
         For Each dc In DataCombo1
            If (dc.Enabled And dc.Visible) Or dc.Index = 0 Then
               If ((Not IsNumeric(dc.BoundText) And dc.Index <> 5) Or _
                   (Len(Trim(dc.BoundText)) = 0 And dc.Index = 5)) And _
                   dc.Index <> 4 And dc.Index <> 6 And dc.Index <> 7 And dc.Index <> 8 Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
'               If (Not IsNumeric(dc.BoundText) And dc.Index <> 5) Or (Len(Trim(dc.BoundText)) = 0 And (dc.Index = 5 Or dc.Index = 6)) Then
               If Len(dc.BoundText) > 0 And IsNumeric(dc.BoundText) Then origen.Registro.Fields(dc.DataField).Value = dc.BoundText
            End If
         Next
         
         If IsNull(origen.Registro.Fields("Cantidad").Value) Or origen.Registro.Fields("Cantidad").Value = 0 Then
            MsgBox "Falta ingresar la cantidad (unidades)", vbCritical
            Exit Sub
         End If
         
         If txtCantidad1.Visible And DataCombo1(1).Visible Then
            If IsNull(origen.Registro.Fields("Cantidad1").Value) Or origen.Registro.Fields("Cantidad1").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 1)", vbCritical
               Exit Sub
            End If
         End If
         
         If txtCantidad2.Visible And DataCombo1(1).Visible Then
            If IsNull(origen.Registro.Fields("Cantidad2").Value) Or origen.Registro.Fields("Cantidad2").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 2)", vbCritical
               Exit Sub
            End If
         End If
         
         If DTFields(0).Enabled Then
            If DTFields(0).Value < oRequerimiento.Registro.Fields("FechaRequerimiento").Value Then
               MsgBox "La fecha de necesidad no puede ser inferior a la fecha del requerimiento", vbExclamation
               Exit Sub
            End If
         End If
         
         If txtCosto.Visible And (Len(txtCosto.Text) = 0 Or Not IsNumeric(txtCosto.Text)) Then
            MsgBox "Falta ingresar el costo", vbCritical
            Exit Sub
         End If
         
         If txtMoP.Visible And Len(txtMoP.Text) = 0 Then
            MsgBox "Falta ingresar el codigo M/P", vbCritical
            Exit Sub
         End If
         
         With origen.Registro
            For i = 0 To 9
               .Fields("ArchivoAdjunto" & i + 1).Value = FileBrowser1(i).Text
            Next
'            If Len(rchObservaciones.Text) > 1 Then
'               Do While Asc(Right(rchObservaciones.Text, 1)) = 13 Or Asc(Right(rchObservaciones.Text, 1)) = 10
'                  If Len(rchObservaciones.Text) = 1 Then
'                     rchObservaciones.Text = ""
'                     Exit Do
'                  Else
'                     rchObservaciones.Text = mId(rchObservaciones.Text, 1, Len(rchObservaciones.Text) - 1)
'                  End If
'               Loop
'               .Fields("Observaciones").Value = rchObservaciones.Text
'            End If
            .Fields("Observaciones").Value = Replace(rchObservaciones.Text, Chr(13) + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Chr(10), " ")
            .Fields("Observaciones").Value = Replace(rchObservaciones.Text, Chr(9), "   ")
         End With
         
         origen.Modificado = True
         Aceptado = True
         
         Me.Hide

      Case 1
         If mvarId = -1 Then origen.Eliminado = True
         Me.Hide
   
      Case 2
         Dim oF As frmArticulosRequerimientos
         
         Set oF = New frmArticulosRequerimientos
         With oF
            .Obra = Requerimiento.Registro.Fields("IdObra").Value
            .dcfields(0).Visible = False
            .CalcularFaltante
            .Show vbModal, Me
         End With
         Unload oF
         Set oF = Nothing
      
      Case 3
         Set oF1 = New frmAutorizacion2
         With oF1
            .Sector = "Control de Calidad"
            .Show vbModal, Me
            mvarOK = .Ok
            mvarCancelo = .Cancelo
         End With
         Unload oF1
         Set oF1 = Nothing
         
         If mvarCancelo Then Exit Sub
         
         If Not mvarOK Then
            MsgBox "Solo personal de Control de Calidad puede asignar los controles", vbExclamation
            Exit Sub
         End If
         
         DataCombo1(4).Enabled = True
         
      Case 4
         Set oF1 = New frmAutorizacion2
         With oF1
            .Sector = "Planeamiento"
            .Show vbModal, Me
            mvarOK = .Ok
         End With
         Unload oF1
         Set oF1 = Nothing
         
         If Not mvarOK Then
'            MsgBox "Solo personal de PLANEAMIENTO puede asignar fechas de necesidad", vbExclamation
            Exit Sub
         End If
         
         DTFields(0).Enabled = True
   
      Case 5
         DataCombo1(1).Text = txtDescripcionManual.Text
         Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorDescripcion", txtDescripcionManual.Text)
         If oRs.RecordCount = 0 Then
            MsgBox "No existe un articulo con la descripcion manual, busquelo antes de registrar!", vbExclamation
         End If
         oRs.Close
         Set oRs = Nothing
         txtDescripcionManual.Visible = False
         DataCombo1(1).Visible = True
         cmd(5).Enabled = False
   End Select
   
Salida:
   Exit Sub
   
Mal:
   MsgBox "Se ha producido un problema al tratar de registrar los datos" & vbCrLf & Err.Description, vbCritical
   Resume Salida
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOr.Recordset
   Dim dtf As DTPicker
   Dim i As Integer
   Dim mMostrarCosto As String, mvarActivarSolicitudMateriales As String
   Dim mvarAux As String
   Dim mExistePedido As Boolean

   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   
   Set origen = oRequerimiento.DetRequerimientos.Item(vnewvalue)
   Me.IdNuevo = origen.Id
   
   mMostrarCosto = BuscarClaveINI("Mostrar costo en RM")
   
   If glbParametrizacionNivel1 Then
      cmd(2).Visible = False
      cmd(3).Visible = False
      cmd(5).Visible = False
      lblData(4).Visible = False
      DataCombo1(4).Visible = False
      lblLabels(0).Visible = False
      txtNumeroLMateriales.Visible = False
      lblLabels(4).Visible = False
      txtNumeroItemLMateriales.Visible = False
   End If
   
   If mMostrarCosto = "SI" Then
      With lblLabels(8)
         .Top = lblLabels(6).Top
         .Left = lblLabels(6).Left
         .Visible = True
      End With
      With txtCosto
         .Top = DataCombo1(2).Top
         .Left = DataCombo1(2).Left
         .Visible = True
      End With
   End If
   
   Set oBind = New BindingCollection
   
   Set oPar = oAp.Parametros.Item(1)
   With oPar.Registro
      mvarIdUnidadCU = IIf(IsNull(.Fields("IdUnidadPorUnidad").Value), 0, .Fields("IdUnidadPorUnidad").Value)
      mvarPathAdjuntos = IIf(IsNull(.Fields("PathAdjuntos").Value), "", .Fields("PathAdjuntos").Value)
      mvarActivarSolicitudMateriales = IIf(IsNull(.Fields("ActivarSolicitudMateriales").Value), "NO", .Fields("ActivarSolicitudMateriales").Value)
   End With
   Set oPar = Nothing
   
   If mvarActivarSolicitudMateriales = "SI" Then
      lblLabels(11).Visible = True
      lblLabels(13).Visible = True
      lblLabels(15).Visible = True
      lblLabels(16).Visible = True
      lblLabels(17).Visible = True
      lblLabels(18).Visible = True
      txtCodigoArticulo1.Visible = True
      With DataCombo1(7)
         If Me.IdEquipoDestino <> 0 And _
               Not IsNumeric(origen.Registro.Fields("IdEquipoDestino").Value) Then
            origen.Registro.Fields("IdEquipoDestino").Value = Me.IdEquipoDestino
         End If
         .Visible = True
      End With
      txtPagina.Visible = True
      txtItem1.Visible = True
      txtFigura.Visible = True
      txtCodigoDistribucion.Visible = True
      txtMoP.Visible = True
   Else
      rchObservaciones.Height = rchObservaciones.Height * 1.33
   End If
   
   If BuscarClaveINI("Desactivar MoP") = "SI" Then
      lblLabels(18).Visible = False
      txtMoP.Visible = False
   End If
   
   If BuscarClaveINI("Exigir etapa de obra en circuito de compras para requerimientos") = "SI" Then
      lblLabels(19).Visible = True
      DataCombo1(8).Visible = True
      lblLabels(27).Visible = True
      DataCombo1(11).Visible = True
   End If
   
   mExistePedido = False
   If mvarId > 0 Then mExistePedido = ExistePedido(mvarId)
   
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DTPicker Then
            If Len(oControl.DataField) Then .Add oControl, "Value", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "DefExe1" Then
                  If Not IsNull(Requerimiento.Registro.Fields("IdEquipo").Value) Then
                     Set oControl.RowSource = oAp.Equipos.TraerFiltrado("Planos", Requerimiento.Registro.Fields("IdEquipo").Value)
                  End If
               ElseIf oControl.Tag = "Equipos" Then
                  If Not IsNull(Requerimiento.Registro.Fields("IdObra").Value) Then
                     Set oControl.RowSource = oAp.Equipos.TraerFiltrado("_PorObraParaCombo", Requerimiento.Registro.Fields("IdObra").Value)
                  End If
               ElseIf oControl.Tag = "Articulos1" Then
                  Set oControl.RowSource = oAp.Articulos.TraerFiltrado("_ParaMantenimiento_ParaCombo")
               ElseIf oControl.Tag = "ObrasDestinos" Then
                  If Not IsNull(Requerimiento.Registro.Fields("IdObra").Value) Then
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_DestinosParaComboPorIdObra", Requerimiento.Registro.Fields("IdObra").Value)
                  End If
               ElseIf oControl.Tag = "PresupuestoObrasRubros" Then
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      
         If mvarId > 0 And mExistePedido And _
               (TypeOf oControl Is DataCombo Or TypeOf oControl Is TextBox) Then
            oControl.Locked = True
         End If
      Next
   End With
   
   If IsNull(oRequerimiento.Registro.Fields("IdObra").Value) Then
      cmd(2).Enabled = False
      DTFields(0).Enabled = True
      cmd(4).Enabled = False
   Else
      Set oRs = oAp.Obras.Item(oRequerimiento.Registro.Fields("IdObra").Value).Registro
      If Not mId(oRs.Fields("NumeroObra").Value, 1, 3) = "OBT" Then
         DTFields(0).Enabled = True
         cmd(4).Enabled = False
      End If
   End If
   
   mEstadoFechaNecesidad = DTFields(0).Enabled
   
   If mvarId = -1 Then
'      For Each dtf In DTFields
'         If dtf.Enabled Then
'            dtf.Value = Date
'         End If
'      Next
      mvarAux = BuscarClaveINI("Dias default para fecha necesidad en RM")
      If Len(mvarAux) > 0 Then
         DTFields(0).Value = DateAdd("d", Val(mvarAux), Me.FechaRequerimiento)
      Else
         DTFields(0).Value = Date
      End If
      With origen.Registro
         .Fields("Adjunto").Value = "NO"
         .Fields("EsBienDeUso").Value = "NO"
         If Not IsNull(oRequerimiento.Registro.Fields("IdCentroCosto").Value) Then
            .Fields("IdCentroCosto").Value = oRequerimiento.Registro.Fields("IdCentroCosto").Value
            DataCombo1(6).Enabled = False
         Else
            .Fields("IdCentroCosto").Value = Null
            DataCombo1(2).Enabled = False
         End If
         .Fields("Observaciones").Value = " "
      End With
      Option1.Value = True
      Option4.Value = True
      mvarAux = BuscarClaveINI("Inicializar origen de descripcion en item de RM")
      Select Case mvarAux
         Case "01"
            Option1.Value = True
         Case "02"
            Option2.Value = True
         Case "03"
            Option3.Value = True
      End Select
   Else
      With origen.Registro
         If Not IsNull(.Fields("EsBienDeUso").Value) Then
            If .Fields("EsBienDeUso").Value = "NO" Then
               Option4.Value = True
            Else
               Option5.Value = True
            End If
         Else
            Option4.Value = True
         End If
         For i = 0 To 9
            FileBrowser1(i).Text = .Fields("ArchivoAdjunto" & i + 1).Value
         Next
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
         If Not IsNull(.Fields("IdDetalleLMateriales").Value) Then
            Set oRs = oAp.LMateriales.Item(0).DetLMateriales.Item(.Fields("IdDetalleLMateriales").Value).Registro
            If oRs.RecordCount > 0 Then
               txtNumeroItemLMateriales.Text = oRs.Fields("NumeroOrden").Value
               txtNumeroLMateriales.Text = oAp.LMateriales.Item(oRs.Fields("IdLMateriales").Value).Registro.Fields("NumeroLMateriales").Value
            End If
            oRs.Close
         End If
         rchObservaciones.Text = .Fields("Observaciones").Value
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
            cmd(5).Enabled = False
         End If
         If IsNull(oRequerimiento.Registro.Fields("IdCentroCosto").Value) Then
            .Fields("IdCentroCosto").Value = Null
            DataCombo1(2).Enabled = False
         Else
            .Fields("IdEquipo").Value = Null
            DataCombo1(6).Enabled = False
         End If
      End With
      If Not mHabilitadaParaModificar Then
         cmd(0).Enabled = False
         cmd(2).Enabled = False
         Frame1.Enabled = False
      End If
   End If
   
   If BuscarClaveINI("Inhibir unidades en RM") = "SI" Then
      DataCombo1(0).Enabled = False
   End If
   If BuscarClaveINI("Bloqueo de campos RM") = "SI" Then
      lblLabels(0).Visible = False
      lblLabels(4).Visible = False
      txtNumeroLMateriales.Visible = False
      txtNumeroItemLMateriales.Visible = False
      cmd(2).Visible = False
      cmd(3).Visible = False
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   MuestraAdjuntos
   
   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then
      DataCombo1(0).Enabled = False
   End If
   
End Property

Public Property Get Requerimiento() As ComPronto.Requerimiento

   Set Requerimiento = oRequerimiento

End Property

Public Property Set Requerimiento(ByVal vnewvalue As ComPronto.Requerimiento)

   Set oRequerimiento = vnewvalue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   Dim oRs As ADOr.Recordset
            
   Select Case Index
      
      Case 1
         If IsNumeric(DataCombo1(Index).BoundText) Then
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  If (IsNull(.Fields("IdArticulo").Value) Or _
                         .Fields("IdArticulo").Value <> DataCombo1(1).BoundText) Then
                     If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                        .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     Else
                        .Fields("IdUnidad").Value = mvarIdUnidadCU
                     End If
                     If Not IsNull(oRs.Fields("CostoReposicion").Value) Then
                        .Fields("Costo").Value = oRs.Fields("CostoReposicion").Value
                     End If
                  End If
                  .Fields("IdArticulo").Value = DataCombo1(1).BoundText
                  If Not IsNull(oRs.Fields("IdControlCalidad").Value) Then
                     .Fields("IdControlCalidad").Value = oRs.Fields("IdControlCalidad").Value
                  End If
                  If mvarId = -1 Then
'                     If IsNull(.Fields("Observaciones").Value) Then
'                        .Fields("Observaciones").Value = oArt.CadenaSubitems
'                     Else
'                        .Fields("Observaciones").Value = .Fields("Observaciones").Value & vbCrLf & oArt.CadenaSubitems
'                     End If
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
               DTFields(0).Enabled = mEstadoFechaNecesidad
               If Not DTFields(0).Enabled And Not IsNull(oRs.Fields("Productivo").Value) Then
                  If oRs.Fields("Productivo").Value = "NO" Then
                     DTFields(0).Enabled = True
                  End If
               End If
               If Not IsNull(oRs.Fields("IdCuenta").Value) And mvarId = -1 Then
                  origen.Registro.Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
               End If
               If Not IsNull(oRs.Fields("IdPresupuestoObraRubro").Value) Then
                  origen.Registro.Fields("IdPresupuestoObraRubro").Value = oRs.Fields("IdPresupuestoObraRubro").Value
               End If
               txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
            End If
            
            oRs.Close
            Set oRs = Nothing
         End If
      
      Case 5
         origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
         MuestraAdjuntos
      
      Case 6
         If Len(DataCombo1(Index).Text) = 0 Then
            origen.Registro.Fields(DataCombo1(Index).DataField).Value = Null
         End If
   
      Case 7
         If IsNumeric(DataCombo1(Index).BoundText) Then
            origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
            txtCodigoArticulo1.Text = TraerCodigoArticulo(DataCombo1(Index).BoundText)
         End If
      
      Case 8
         If IsNumeric(DataCombo1(Index).BoundText) Then
            Dim mIdPresupuestoObraRubro As Long, mTipoConsumo As Integer
            If Not IsNull(origen.Registro.Fields(DataCombo1(11).DataField).Value) Then
               mIdPresupuestoObraRubro = origen.Registro.Fields(DataCombo1(11).DataField).Value
            Else
               mIdPresupuestoObraRubro = 0
            End If
            Set oRs = Aplicacion.TablasGenerales.TraerUno("DetObrasDestinos", DataCombo1(Index).BoundText)
            mTipoConsumo = 3
            If oRs.RecordCount > 0 Then
               mTipoConsumo = IIf(IsNull(oRs.Fields("TipoConsumo").Value), 3, oRs.Fields("TipoConsumo").Value)
            End If
            oRs.Close
            Set oRs = Aplicacion.PresupuestoObrasRubros.TraerFiltrado("_ParaComboPorTipoConsumo", mTipoConsumo)
            Set DataCombo1(11).RowSource = oRs
            'origen.Registro.Fields(DataCombo1(11).DataField).Value = mIdPresupuestoObraRubro
            Set oRs = Nothing
         End If
      
      Case Else
         If IsNumeric(DataCombo1(Index).BoundText) Then
            origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
         End If
   
   End Select
      
   Set oRs = Nothing
   
End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DataCombo1_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Index = 1 Then
      If Button = vbRightButton Then
'         If glbMenuPopUpCargado Then
'            Dim cursorpos As POINTAPI
'            GetCursorPos cursorpos
'            TrackPopupMenu POP_hMenu, TPM_HORNEGANIMATION, cursorpos.x, cursorpos.y, 0, Me.hwnd, ByVal 0&
'            DoEvents
'            If POP_Key > 0 Then
'               DataCombo1(1).BoundText = POP_Key
'            End If
'         Else
'            MsgBox "No se ha cargado el menu de materiales", vbInformation
'         End If
         If glbMenuPopUpCargado1 Then
            Dim iIndex As Long
            cPMenu.Restore "Materiales"
            iIndex = cPMenu.ShowPopupMenu(Me.Left, Me.Top)
            If (iIndex > 0) Then
               origen.Registro.Fields("IdArticulo").Value = cPMenu.ItemKey(iIndex)
            End If
         End If
      End If
   End If

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vnewvalue As Variant)

   mvarIdNuevo = vnewvalue

End Property

Private Sub FileBrowser1_Change(Index As Integer)

   If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
      If Len(Trim(FileBrowser1(Index).Text)) > gblMaximaLongitudAdjuntos Then
         MsgBox "La longitud maxima para un archivo adjunto es de " & gblMaximaLongitudAdjuntos & " caracteres", vbInformation
         FileBrowser1(Index).Text = ""
      Else
         FileBrowser1(Index).InitDir = FileBrowser1(Index).Text
      End If
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

Private Sub Form_Activate()

   If Len(Trim(txtItem.Text)) = 0 Or mvarId = -1 Then
      origen.Registro.Fields("NumeroItem").Value = oRequerimiento.DetRequerimientos.UltimoItemDetalle
   End If
   
   If mvarId <> -1 Then
      If Not IsNull(origen.Registro.Fields("IdArticulo").Value) Then
         Dim oRs As ADOr.Recordset
         Set oRs = Aplicacion.Articulos.Item(origen.Registro.Fields("IdArticulo").Value).Registro
         If oRs.RecordCount > 0 Then
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
                     txtCantidad2.Visible = False
                     Label1(0).Visible = False
               End Select
            End If
         End If
         oRs.Close
         Set oRs = Nothing
      End If
   End If
   
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
   Dim iFilas As Long, iColumnas As Long, mvarNumeroLMateriales As Long
   Dim i As Integer
   Dim oAp As ComPronto.Aplicacion
   Dim oRsLMat As ADOr.Recordset
   Dim oRsDetLMat As ADOr.Recordset
   Dim oRsArt As ADOr.Recordset

   If Data.GetFormat(ccCFText) Then ' si el dato es texto
      
      s = Data.GetData(ccCFText) ' tomo el dato
      
      Filas = Split(s, vbCrLf) ' armo un vector por filas
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      Set oAp = Aplicacion
      
      Columnas = Split(Filas(1), vbTab) ' armo un vector con las columnas
      
      Set oRsDetLMat = oAp.LMateriales.Item(0).DetLMateriales.Item(Columnas(0)).Registro
      Set oRsLMat = oAp.LMateriales.Item(oRsDetLMat.Fields("IdLMateriales").Value).Registro
      mvarNumeroLMateriales = oRsLMat.Fields("NumeroLMateriales").Value
      
      Do While Not oRsDetLMat.EOF
         Set oRsArt = oAp.Articulos.Item(oRsDetLMat.Fields("IdArticulo").Value).Registro
         With origen.Registro
            .Fields("Cantidad").Value = 0
            .Fields("Cantidad1").Value = oRsDetLMat.Fields("Cantidad1").Value
            .Fields("Cantidad2").Value = oRsDetLMat.Fields("Cantidad2").Value
            .Fields("IdUnidad").Value = oRsDetLMat.Fields("IdUnidad").Value
            .Fields("IdArticulo").Value = oRsDetLMat.Fields("IdArticulo").Value
            If Not IsNull(oRsDetLMat.Fields("IdControlCalidad").Value) Then
               .Fields("IdControlCalidad").Value = oRsDetLMat.Fields("IdControlCalidad").Value
            ElseIf Not IsNull(oRsArt.Fields("IdControlCalidad").Value) Then
               .Fields("IdControlCalidad").Value = oRsArt.Fields("IdControlCalidad").Value
            End If
            .Fields("Adjunto").Value = oRsDetLMat.Fields("Adjunto").Value
            .Fields("IdDetalleLMateriales").Value = oRsDetLMat.Fields(0).Value
            .Fields("Observaciones").Value = oRsDetLMat.Fields("Observaciones").Value
            For i = 0 To 9
               .Fields("ArchivoAdjunto" & i + 1).Value = oRsDetLMat.Fields("ArchivoAdjunto" & i + 1).Value
               FileBrowser1(i).Text = IIf(IsNull(oRsDetLMat.Fields("ArchivoAdjunto" & i + 1).Value), "", oRsDetLMat.Fields("ArchivoAdjunto" & i + 1).Value)
            Next
            If Not IsNull(oRsArt.Fields("IdCuenta").Value) Then
               .Fields("IdCuenta").Value = oRsArt.Fields("IdCuenta").Value
            End If
            .Fields("IdEquipo").Value = oRsLMat.Fields("IdEquipo").Value
            txtNumeroItemLMateriales.Text = oRsDetLMat.Fields("NumeroOrden").Value
            txtNumeroLMateriales.Text = mvarNumeroLMateriales
         End With
         oRsArt.Close
         Set oRsArt = Nothing
         oRsDetLMat.MoveNext
      Loop
      
      oRsDetLMat.Close
      Set oRsDetLMat = Nothing
      oRsLMat.Close
      Set oRsLMat = Nothing
      
      Set oAp = Nothing
      
      Clipboard.Clear
      
      MuestraAdjuntos
   
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

   Set oRequerimiento = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
   If glbMenuPopUpCargado Then DesactivarPopUp Me
'   xMenu1.DesInstalar
   
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

Private Sub Option4_Click()

   If Option4.Value Then
      origen.Registro.Fields("EsBienDeUso").Value = "NO"
   End If
   
End Sub

Private Sub Option5_Click()

   If Option5.Value Then
      origen.Registro.Fields("EsBienDeUso").Value = "SI"
   End If
   
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
         Dim oRs As ADOr.Recordset
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set oRs = Aplicacion.Articulos.TraerLista
         End If
         Set DataCombo1(1).RowSource = oRs
         If oRs.RecordCount > 0 Then
            DataCombo1(1).BoundText = oRs.Fields(0).Value
         End If
         Set oRs = Nothing
      End If
      If DataCombo1(1).Visible Then
         DataCombo1(1).SetFocus
         SendKeys "%{DOWN}"
      End If
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

Private Sub txtCantidad1_GotFocus()

   With txtCantidad1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad1_KeyPress(KeyAscii As Integer)

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
      Dim oRs As ADOr.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo.Text)
      If oRs.RecordCount > 0 Then
         With origen.Registro
            .Fields("IdArticulo").Value = oRs.Fields(0).Value
            If Not IsNull(oRs.Fields("IdUnidad").Value) Then
               .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
            Else
               .Fields("IdUnidad").Value = mvarIdUnidadCU
            End If
            If Not IsNull(oRs.Fields("CostoReposicion").Value) Then
               .Fields("Costo").Value = oRs.Fields("CostoReposicion").Value
            End If
         End With
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
      Dim oRs As ADOr.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorNumeroInventario", txtCodigoArticulo1.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdEquipoDestino").Value = oRs.Fields(0).Value
      Else
         MsgBox "Numero de inventario del material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo1.Text = ""
         origen.Registro.Fields("IdEquipoDestino").Value = Null
      End If
      oRs.Close
      Set oRs = Nothing
   Else
      origen.Registro.Fields("IdEquipoDestino").Value = Null
   End If
   
End Sub

Private Sub txtCodigoDistribucion_GotFocus()

   With txtCodigoDistribucion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoDistribucion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCodigoDistribucion
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
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

Private Sub txtFigura_GotFocus()

   With txtFigura
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtFigura_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

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
   
'   If mvarId = -1 Then
'      origen.Registro.Fields("NumeroOrden").Value = SiguienteOrdenRequerimientos(Requerimiento.DetRequerimientos.TodosLosRegistros, txtItem.Text)
'   End If

End Sub

Public Property Let HabilitadaParaModificar(ByVal vnewvalue As Boolean)

   mHabilitadaParaModificar = vnewvalue

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
      Me.Height = 6500
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
      Me.Height = 8700
   End If
      
End Sub

'Private Sub xMenu1_xMenuClick(lId As Long)
'
'   origen.Registro.Fields("IdArticulo").Value = xMenu1.Llave(lId)
'
'End Sub

'Private Sub Command1_Click()
'
'   CON CMAT.OCX
'
'   Me.MousePointer = vbHourglass
'   DoEvents
'
'   Dim oRs As ADOR.Recordset
'   Dim mIdRubro As Long, mIdSubrubro As Long
'   Dim mRubro As String, mSubrubro As String, mArticulo As String
'
'   xMenu1.Instalar Me.Caption
'   xMenu1.AgregaItem "Materiales", "m00", "", , True
'
'   Set oRs = Aplicacion.Articulos.TraerFiltrado("_ParaMenu1")
'   With oRs
'      If .RecordCount > 0 Then
'         .MoveFirst
'         mIdRubro = 0
'         mIdSubrubro = 0
'         Do While Not .EOF
'            If Len(Trim(.Fields("Rubro").Value)) <> 0 Then
'               mRubro = .Fields("Rubro").Value
'            Else
'               mRubro = "S/D"
'            End If
'            If Len(Trim(.Fields("Subrubro").Value)) <> 0 Then
'               mSubrubro = .Fields("Subrubro").Value
'            Else
'               mSubrubro = "S/D"
'            End If
'            If Len(Trim(.Fields("Descripcion").Value)) <> 0 Then
'               mArticulo = .Fields("Descripcion").Value
'            Else
'               mArticulo = "S/D"
'            End If
'            If mIdRubro <> .Fields("IdRubro").Value Then
'               xMenu1.AgregaItem "" & mRubro, _
'                                    "R" & .Fields("IdRubro").Value, "m00", , True
'            End If
'            If mIdRubro <> .Fields("IdRubro").Value Or _
'                  mIdSubrubro <> .Fields("IdSubrubro").Value Then
'               xMenu1.AgregaItem "" & mSubrubro, _
'                                    "R" & .Fields("IdRubro").Value & " " & _
'                                    "S" & .Fields("IdSubrubro").Value, _
'                                    "R" & .Fields("IdRubro").Value, , True
'               mIdRubro = .Fields("IdRubro").Value
'               mIdSubrubro = .Fields("IdSubrubro").Value
'            End If
'            xMenu1.AgregaItem "" & mArticulo, _
'                                 "" & .Fields("IdArticulo").Value, _
'                                 "R" & .Fields("IdRubro").Value & " " & _
'                                 "S" & .Fields("IdSubrubro").Value
'            .MoveNext
'         Loop
'      End If
'      .Close
'   End With
'
'   Set oRs = Nothing
'
'   Command1.Enabled = False
'
'   Me.MousePointer = vbDefault
'   DoEvents


'   CON cNewMenu6.dll
'
'   Me.MousePointer = vbHourglass
'   DoEvents
'
'   Set cP = New cPopupMenu
'   cP.hWndOwner = Me.hwnd
'   'cP.ImageList = ilsIcons16
'   cP.HeaderStyle = ecnmHeaderSeparator
'   'cP.MenuBackgroundColor = &H99CCCC
'   cP.MenuBackgroundColor = &HC0C0FF
'   cP.InActiveMenuForeColor = &H333333
'   cP.ActiveMenuBackgroundColor = &H336666
'   cP.ActiveMenuForeColor = &HFFFFFF
'
'   Dim oRs As ADOR.Recordset
'   Dim mIdRubro As Long, mIdSubrubro As Long
'   Dim Key1 As Long, Key2 As Long, Key3 As Long
'   Dim mRubro As String, mSubrubro As String, mArticulo As String
'
'   cP.Clear
'   Key1 = cP.AddItem("Materiales", , 0, , , , , "Root")
'
'   Set oRs = Aplicacion.Articulos.TraerFiltrado("_ParaMenu1")
'   With oRs
'      If .RecordCount > 0 Then
'         .MoveFirst
'         mIdRubro = -1
'         mIdSubrubro = -1
'         Do While Not .EOF
'            If Len(Trim(.Fields("Rubro").Value)) <> 0 Then
'               mRubro = .Fields("Rubro").Value
'            Else
'               mRubro = "S/D"
'            End If
'            If Len(Trim(.Fields("Subrubro").Value)) <> 0 Then
'               mSubrubro = .Fields("Subrubro").Value
'            Else
'               mSubrubro = "S/D"
'            End If
'            If Len(Trim(.Fields("Descripcion").Value)) <> 0 Then
'               mArticulo = .Fields("Descripcion").Value
'            Else
'               mArticulo = "S/D"
'            End If
'
'            If mIdRubro <> .Fields("IdRubro").Value Then
'               If mIdRubro = -1 Then cP.AddItem "-Rubros", , , Key1
'               Key2 = cP.AddItem(mRubro, , , Key1, , , , "R" & .Fields("IdRubro").Value)
'            End If
'            If mIdRubro <> .Fields("IdRubro").Value Or _
'                  mIdSubrubro <> .Fields("IdSubrubro").Value Then
'               If mIdRubro <> .Fields("IdRubro").Value Then
'                  cP.AddItem "-Subrubros", , , Key2
'               End If
'               Key3 = cP.AddItem(mSubrubro, , , Key2, , , , "S" & .Fields("IdSubrubro").Value)
'               mIdRubro = .Fields("IdRubro").Value
'               mIdSubrubro = .Fields("IdSubrubro").Value
'            End If
'            cP.AddItem mArticulo, , , Key3, , , , .Fields("IdArticulo").Value
'
'            .MoveNext
'         Loop
'      End If
'      .Close
'   End With
'
'   Set oRs = Nothing
'
'   Command1.Enabled = False
'
'   Me.MousePointer = vbDefault
'   DoEvents
'
'End Sub

Public Property Get TipoRequerimiento() As String

   TipoRequerimiento = mvarTipoRequerimiento

End Property

Public Property Let TipoRequerimiento(ByVal vnewvalue As String)

   mvarTipoRequerimiento = vnewvalue

End Property

Public Property Get IdEquipoDestino() As Long

   IdEquipoDestino = mvarIdEquipoDestino

End Property

Public Property Let IdEquipoDestino(ByVal vnewvalue As Long)

   mvarIdEquipoDestino = vnewvalue

End Property

Public Property Get FechaRequerimiento() As Date

   FechaRequerimiento = mvarFechaRequerimiento

End Property

Public Property Let FechaRequerimiento(ByVal vnewvalue As Date)

   mvarFechaRequerimiento = vnewvalue

End Property

Private Sub txtItem1_GotFocus()

   With txtItem1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtItem1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtMoP_GotFocus()

   With txtMoP
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtMoP_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      If InStr(1, "M P m p", Chr(KeyAscii)) = 0 And KeyAscii <> vbKeyBack Then
         KeyAscii = 0
      Else
         If KeyAscii >= 97 And KeyAscii <= 122 Then
            KeyAscii = KeyAscii - 32
         End If
         If Len(txtMoP.Text) >= 1 Then origen.Registro.Fields("MoP").Value = ""
      End If
   End If

End Sub

Private Sub txtPagina_GotFocus()

   With txtPagina
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPagina_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Function ExistePedido(IdDetalleRequerimiento As Long) As Boolean

   Dim oRs As ADOr.Recordset
   ExistePedido = False
   Set oRs = Aplicacion.Pedidos.TraerFiltrado("_PorItemRequerimiento", IdDetalleRequerimiento)
   If oRs.RecordCount > 0 Then ExistePedido = True
   oRs.Close
   Set oRs = Nothing

End Function
