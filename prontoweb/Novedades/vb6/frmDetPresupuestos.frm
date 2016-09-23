VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{126E538A-EE41-4B22-A045-F8D5538F5D2B}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmDetPresupuestos 
   Caption         =   "Item de presupuesto"
   ClientHeight    =   7425
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10785
   Icon            =   "frmDetPresupuestos.frx":0000
   LinkTopic       =   "Form1"
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   7425
   ScaleWidth      =   10785
   StartUpPosition =   2  'CenterScreen
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
      Left            =   2160
      TabIndex        =   66
      Top             =   1035
      Width           =   1410
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
      Left            =   4185
      TabIndex        =   62
      Top             =   1800
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
      Left            =   5580
      TabIndex        =   61
      Top             =   1800
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
      Left            =   6975
      TabIndex        =   60
      Top             =   1800
      Width           =   1140
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Buscar RM / LA"
      Height          =   405
      Index           =   2
      Left            =   315
      TabIndex        =   35
      Top             =   4410
      Width           =   1485
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
      Left            =   5670
      Locked          =   -1  'True
      TabIndex        =   29
      Top             =   90
      Width           =   465
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
      Left            =   4680
      Locked          =   -1  'True
      TabIndex        =   28
      Top             =   90
      Width           =   915
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
      Left            =   8235
      TabIndex        =   27
      Top             =   630
      Width           =   2490
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
      Left            =   2160
      TabIndex        =   26
      Top             =   105
      Width           =   645
   End
   Begin VB.TextBox txtNumeroItemRequerimiento 
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
      Left            =   9000
      Locked          =   -1  'True
      TabIndex        =   25
      Top             =   90
      Width           =   465
   End
   Begin VB.TextBox txtNumeroRequerimiento 
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
      Left            =   7785
      Locked          =   -1  'True
      TabIndex        =   24
      Top             =   90
      Width           =   1140
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
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   2160
      TabIndex        =   23
      Top             =   495
      Width           =   1410
   End
   Begin VB.Frame Frame1 
      Caption         =   "Tomar la descripcion de : "
      Height          =   1050
      Left            =   8235
      TabIndex        =   18
      Top             =   1800
      Width           =   2490
      Begin VB.OptionButton Option3 
         Caption         =   "Material mas observaciones"
         Height          =   195
         Left            =   90
         TabIndex        =   21
         Top             =   765
         Width           =   2265
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Solo el material"
         Height          =   195
         Left            =   90
         TabIndex        =   20
         Top             =   225
         Width           =   1410
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Solo las observaciones"
         Height          =   195
         Left            =   90
         TabIndex        =   19
         Top             =   495
         Width           =   2040
      End
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
      Top             =   1410
      Width           =   1095
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
      Left            =   5490
      TabIndex        =   4
      Top             =   1425
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
      Left            =   6795
      TabIndex        =   5
      Top             =   1425
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
      Left            =   7740
      TabIndex        =   6
      Top             =   1425
      Width           =   2985
   End
   Begin VB.TextBox txtPrecio 
      Alignment       =   1  'Right Justify
      DataField       =   "Precio"
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
      Top             =   1800
      Width           =   1095
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   315
      TabIndex        =   10
      Top             =   3960
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   315
      TabIndex        =   9
      Top             =   3510
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   3600
      TabIndex        =   1
      Tag             =   "Articulos"
      Top             =   1035
      Width           =   7125
      _ExtentX        =   12568
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
      Left            =   3285
      TabIndex        =   3
      Tag             =   "Unidades"
      Top             =   1425
      Width           =   2040
      _ExtentX        =   3598
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1995
      Left            =   2160
      TabIndex        =   11
      Top             =   2880
      Width           =   8565
      _ExtentX        =   15108
      _ExtentY        =   3519
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmDetPresupuestos.frx":076A
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "Adjunto"
      Height          =   315
      Index           =   5
      Left            =   2160
      TabIndex        =   8
      Tag             =   "SiNo"
      Top             =   2520
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
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   3
      Left            =   2160
      TabIndex        =   7
      Tag             =   "Cuentas"
      Top             =   2160
      Visible         =   0   'False
      Width           =   5955
      _ExtentX        =   10504
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   1440
      TabIndex        =   36
      Top             =   5265
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
      TabIndex        =   37
      Top             =   5670
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
      TabIndex        =   38
      Top             =   6075
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
      TabIndex        =   39
      Top             =   6480
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
      TabIndex        =   40
      Top             =   6885
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
      TabIndex        =   41
      Top             =   5265
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
      TabIndex        =   42
      Top             =   5670
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
      TabIndex        =   43
      Top             =   6075
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
      TabIndex        =   44
      Top             =   6480
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
      TabIndex        =   45
      Top             =   6885
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
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaEntrega"
      Height          =   360
      Index           =   0
      Left            =   5670
      TabIndex        =   56
      Top             =   495
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   635
      _Version        =   393216
      Format          =   59703297
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCentroCosto"
      Height          =   315
      Index           =   2
      Left            =   4455
      TabIndex        =   58
      Tag             =   "CentrosCosto"
      Top             =   2520
      Visible         =   0   'False
      Width           =   3660
      _ExtentX        =   6456
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCentroCosto"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Bonif. [%] :"
      Height          =   255
      Index           =   15
      Left            =   3330
      TabIndex        =   65
      Top             =   1845
      Width           =   825
   End
   Begin VB.Label lblLabels 
      Caption         =   "IVA [%] :"
      Height          =   255
      Index           =   16
      Left            =   4860
      TabIndex        =   64
      Top             =   1830
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "TOTAL :"
      Height          =   255
      Index           =   17
      Left            =   6255
      TabIndex        =   63
      Top             =   1830
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "Centro de costo :"
      Height          =   300
      Index           =   11
      Left            =   3060
      TabIndex        =   59
      Top             =   2520
      Visible         =   0   'False
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de entrega :"
      Height          =   300
      Index           =   8
      Left            =   4185
      TabIndex        =   57
      Top             =   540
      Width           =   1410
   End
   Begin VB.Line Line1 
      BorderWidth     =   3
      X1              =   0
      X2              =   10755
      Y1              =   5085
      Y2              =   5085
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 1 :"
      Height          =   300
      Index           =   0
      Left            =   90
      TabIndex        =   55
      Top             =   5265
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 2 :"
      Height          =   300
      Index           =   1
      Left            =   90
      TabIndex        =   54
      Top             =   5670
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 3 :"
      Height          =   300
      Index           =   2
      Left            =   90
      TabIndex        =   53
      Top             =   6075
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 4 :"
      Height          =   300
      Index           =   3
      Left            =   90
      TabIndex        =   52
      Top             =   6480
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 5 :"
      Height          =   300
      Index           =   4
      Left            =   90
      TabIndex        =   51
      Top             =   6885
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 6 :"
      Height          =   300
      Index           =   5
      Left            =   5670
      TabIndex        =   50
      Top             =   5310
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 7 :"
      Height          =   300
      Index           =   6
      Left            =   5670
      TabIndex        =   49
      Top             =   5715
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 8 :"
      Height          =   300
      Index           =   7
      Left            =   5670
      TabIndex        =   48
      Top             =   6120
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 9 :"
      Height          =   300
      Index           =   8
      Left            =   5670
      TabIndex        =   47
      Top             =   6525
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 10 :"
      Height          =   300
      Index           =   9
      Left            =   5670
      TabIndex        =   46
      Top             =   6930
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "Lista de acopio - item :"
      Height          =   300
      Index           =   6
      Left            =   2970
      TabIndex        =   34
      Top             =   135
      Width           =   1590
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
      Left            =   7335
      TabIndex        =   33
      Top             =   675
      Width           =   825
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de item :"
      Height          =   300
      Index           =   3
      Left            =   180
      TabIndex        =   32
      Top             =   150
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero RM - item :"
      Height          =   300
      Index           =   1
      Left            =   6300
      TabIndex        =   31
      Top             =   135
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de obra :"
      Height          =   300
      Index           =   10
      Left            =   180
      TabIndex        =   30
      Top             =   540
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta contable :"
      Height          =   255
      Index           =   9
      Left            =   180
      TabIndex        =   22
      Top             =   2205
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Adjunto ? :"
      Height          =   255
      Index           =   12
      Left            =   180
      TabIndex        =   17
      Top             =   2550
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   5
      Left            =   180
      TabIndex        =   16
      Top             =   2925
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   180
      TabIndex        =   15
      Top             =   1410
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   2
      Left            =   180
      TabIndex        =   14
      Top             =   1035
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
      Left            =   6435
      TabIndex        =   13
      Top             =   1470
      Width           =   285
   End
   Begin VB.Label lblLabels 
      Caption         =   "Precio unitario"
      Height          =   300
      Index           =   4
      Left            =   180
      TabIndex        =   12
      Top             =   1800
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetPresupuestos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetPresupuesto
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oPresupuesto As ComPronto.Presupuesto
Public Aceptado As Boolean
Private mvarIdUnidadCU As Integer, mTipoIva As Integer, mCondicionIva As Integer
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long
Private mvarCantidadAdicional As Double, mvarCantidadUnidades As Double
Private mPorcentajeIVA As Double, mvarP_IVA1 As Double, mvarP_IVA2 As Double
Private mvarPathAdjuntos As String
Private mFechaEntrega As Date

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim i As Integer
         Dim mObs As String
      
         For Each dtp In DTFields
            origen.Registro.Fields(dtp.DataField).Value = dtp.Value
         Next
         
         For Each dc In DataCombo1
            If (dc.Enabled And dc.Visible And dc.Index <> 4) Or dc.Index = 0 Then
               If (dc.Index = 5 And Len(Trim(dc.BoundText)) = 0) Or (dc.Index <> 5 And Not IsNumeric(dc.BoundText)) Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
               origen.Registro.Fields(dc.DataField).Value = dc.BoundText
            End If
         Next
      
         If IsNull(origen.Registro.Fields("Cantidad").Value) Or origen.Registro.Fields("Cantidad").Value = 0 Then
            MsgBox "Falta ingresar la cantidad (unidades)", vbCritical
            Exit Sub
         End If
         
         If txtCantidad1.Visible Then
            If IsNull(origen.Registro.Fields("Cantidad1").Value) Or origen.Registro.Fields("Cantidad1").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 1)", vbCritical
               Exit Sub
            End If
         End If
         
         If txtCantidad2.Visible Then
            If IsNull(origen.Registro.Fields("Cantidad2").Value) Or origen.Registro.Fields("Cantidad2").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 2)", vbCritical
               Exit Sub
            End If
         End If
         
         If DTFields(0).Value < oPresupuesto.Registro.Fields("FechaIngreso").Value Then
            MsgBox "La fecha de entrega no puede ser menor a la del presupuesto", vbCritical
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
'               mObs = rchObservaciones.Text
'               mObs = Replace(mObs, Chr(9), Chr(32), 1, -1)
'               .Fields("Observaciones").Value = mObs
'            End If
            .Fields("Observaciones").Value = Replace(rchObservaciones.Text, Chr(13) + Chr(10) + Chr(13) + Chr(10), " ")
            .Fields("Observaciones").Value = Replace(rchObservaciones.Text, Chr(9), "   ")
         End With
         
         origen.Modificado = True
         Aceptado = True
   
         Me.Hide

      Case 1
      
         If mvarId = -1 Then
            origen.Eliminado = True
         End If
   
         Me.Hide
         
      Case 2
      
         Dim oF As frmConsultaRMPendientes
         
         Set oF = New frmConsultaRMPendientes
         
         With oF
            .Show vbModal, Me
         End With
         
         Unload oF
   
         Set oF = Nothing
      
   End Select

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim i As Integer
   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim oRsObra As ADOR.Recordset

   mvarId = vNewValue
   
   Set oAp = Aplicacion
   
   Set origen = oPresupuesto.DetPresupuestos.Item(vNewValue)
   Me.IdNuevo = origen.Id
   
   If glbParametrizacionNivel1 Then
      lblLabels(6).Visible = False
      txtNumeroAcopio.Visible = False
      txtNumeroItemAcopio.Visible = False
      lblLabels(9).Visible = False
      DataCombo1(3).Visible = False
      cmd(2).Visible = False
   End If
   
   Set oBind = New BindingCollection
   
   Set oPar = oAp.Parametros.Item(1)
   With oPar.Registro
      mvarIdUnidadCU = .Fields("IdUnidadPorUnidad").Value
      mvarPathAdjuntos = .Fields("PathAdjuntos").Value
      mvarP_IVA1 = .Fields("Iva1").Value
      mvarP_IVA2 = .Fields("Iva2").Value
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
      With origen.Registro
         .Fields("Adjunto").Value = "NO"
         .Fields("OrigenDescripcion").Value = 1
         .Fields("NumeroItem").Value = oPresupuesto.DetPresupuestos.UltimoItemDetalle
         .Fields("FechaEntrega").Value = Me.FechaEntrega
         DTFields(0).Value = .Fields("FechaEntrega").Value
         mPorcentajeIVA = 0
         If mTipoIva = 0 Then
            Select Case mCondicionIva
               Case 1
                  mPorcentajeIVA = mvarP_IVA1
               Case 2
                  mPorcentajeIVA = mvarP_IVA1 + mvarP_IVA2
            End Select
         End If
         .Fields("PorcentajeIVA").Value = mPorcentajeIVA
      End With
      Option1.Value = True
   Else
      With origen.Registro
         If IsNull(.Fields("FechaEntrega").Value) Then
            .Fields("FechaEntrega").Value = Me.FechaEntrega
            DTFields(0).Value = .Fields("FechaEntrega").Value
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
         If Not IsNull(.Fields("IdDetalleAcopios").Value) Then
            Set oRs = oAp.TablasGenerales.TraerFiltrado("DetAcopios", "_UnItem", .Fields("IdDetalleAcopios").Value)
            If oRs.RecordCount > 0 Then
               txtNumeroItemAcopio.Text = oRs.Fields("NumeroItem").Value
               txtNumeroAcopio.Text = oRs.Fields("NumeroAcopio").Value
               txtNumeroObra.Text = oRs.Fields("Obra").Value
            End If
            oRs.Close
         End If
         If IsNull(.Fields("PorcentajeIVA").Value) Then
            .Fields("PorcentajeIVA").Value = mPorcentajeIVA
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
   End If
   
   Set oRs = Nothing
   Set oRsObra = Nothing
   Set oAp = Nothing

   MuestraAdjuntos
   
   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then
      DataCombo1(0).Enabled = False
   End If
   
End Property

Public Property Get Presupuesto() As ComPronto.Presupuesto

   Set Presupuesto = oPresupuesto

End Property

Public Property Set Presupuesto(ByVal vNewValue As ComPronto.Presupuesto)

   Set oPresupuesto = vNewValue

End Property

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

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

Private Sub DataCombo1_Change(Index As Integer)

   Select Case Index
      
      Case 1
      
         If IsNumeric(DataCombo1(Index).BoundText) Then
            
            Dim oRs As ADOR.Recordset
            Dim oArt As ComPronto.Articulo
            
            Me.MousePointer = vbHourglass
            
            Set oArt = Aplicacion.Articulos.Item(DataCombo1(1).BoundText)
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorIdConDatos", DataCombo1(1).BoundText)
         
            If oRs.RecordCount > 0 Then
               
               With origen.Registro
                  If mvarId = -1 Or IsNull(.Fields("IdUnidad").Value) Then
                     If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                        .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     Else
                        .Fields("IdUnidad").Value = mvarIdUnidadCU
                     End If
                  End If
                  If Not IsNull(oRs.Fields("IdCuentaRubro").Value) Then
                     .Fields("IdCuenta").Value = oRs.Fields("IdCuentaRubro").Value
                  End If
                  If mvarId = -1 Then
                     If IsNull(.Fields("Observaciones").Value) Then
                        .Fields("Observaciones").Value = oArt.CadenaSubitems
                     Else
                        .Fields("Observaciones").Value = .Fields("Observaciones").Value & vbCrLf & oArt.CadenaSubitems
                     End If
                  End If
                  .Fields("PorcentajeIVA").Value = IIf(IsNull(oRs.Fields("AlicuotaIVA").Value), 0, oRs.Fields("AlicuotaIVA").Value)
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
               
               txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)

'               If Not IsNull(oRs.Fields("IdCuenta").Value) And mvarId = -1 Then
'                  origen.Registro.Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
'               End If
            
            End If
            
            oRs.Close
            Set oRs = Nothing
            Set oArt = Nothing
            
            Me.MousePointer = vbDefault
            
         End If

      Case 5
   
         origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
         MuestraAdjuntos
      
   End Select
      
End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

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
   
   CalcularItem

End Sub

Private Sub Form_Load()

   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String, mExiste As String, mTipoComprobante As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, mvarNumeroRequerimiento As Long
   Dim i As Integer
   Dim oAp As ComPronto.Aplicacion
   Dim oRsDet As ADOR.Recordset
   Dim oRsObra As ADOR.Recordset

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
      
      mTipoComprobante = ""
      If UBound(Columnas) >= 8 Then
         mTipoComprobante = Columnas(8)
      End If
      
      If InStr(1, Filas(0), "Req") <> 0 Or _
            (InStr(1, Filas(0), "Cpte.") <> 0 And mTipoComprobante = "RM") Then
      
         Set oRsDet = oAp.Requerimientos.TraerFiltrado("_DatosRequerimiento", Columnas(22))
         If oRsDet.RecordCount > 0 Then
            If IsNull(oRsDet.Fields("Aprobo").Value) Then
               MsgBox "El requerimiento " & oRsDet.Fields("NumeroRequerimiento").Value & " no fue liberado", vbExclamation
               oRsDet.Close
               GoTo Salida
            End If
            If IIf(IsNull(oRsDet.Fields("CumplidoReq").Value), "NO", oRsDet.Fields("CumplidoReq").Value) = "SI" Or _
                  IIf(IsNull(oRsDet.Fields("CumplidoReq").Value), "NO", oRsDet.Fields("CumplidoReq").Value) = "AN" Then
               MsgBox "El requerimiento " & oRsDet.Fields("NumeroRequerimiento").Value & " ya esta cumplido", vbExclamation
               oRsDet.Close
               GoTo Salida
            End If
            If IIf(IsNull(oRsDet.Fields("Cumplido").Value), "NO", oRsDet.Fields("Cumplido").Value) = "SI" Or _
                  IIf(IsNull(oRsDet.Fields("Cumplido").Value), "NO", oRsDet.Fields("Cumplido").Value) = "AN" Then
               MsgBox "El requerimiento " & oRsDet.Fields("NumeroRequerimiento").Value & _
                      " item " & oRsDet.Fields("NumeroItem").Value & " ya esta cumplido", vbExclamation
               oRsDet.Close
               GoTo Salida
            End If
         End If
         
         mvarNumeroRequerimiento = oRsDet.Fields("NumeroRequerimiento").Value
         
         txtNumeroObra.Text = ""
         If Not IsNull(oRsDet.Fields("IdDetalleRequerimiento").Value) Then
            Set oRsObra = oAp.Requerimientos.TraerFiltrado("_DatosObra", oRsDet.Fields("IdDetalleRequerimiento").Value)
            If Not IsNull(oRsObra.Fields("Obra").Value) Then
               txtNumeroObra.Text = oRsObra.Fields("Obra").Value
            End If
            oRsObra.Close
         Else
            If Not IsNull(oRsDet.Fields("IdDetalleLMateriales").Value) Then
               Set oRsObra = oAp.TablasGenerales.TraerFiltrado("LMateriales", "_DatosObra", oRsDet.Fields("IdDetalleLMateriales").Value)
               If Not IsNull(oRsObra.Fields("Obra").Value) Then
                  txtNumeroObra.Text = oRsObra.Fields("Obra").Value
               End If
               oRsObra.Close
            End If
         End If
      
         With origen.Registro
            .Fields("Cantidad").Value = IIf(IsNull(oRsDet.Fields("Cantidad").Value), 0, oRsDet.Fields("Cantidad").Value) - IIf(IsNull(oRsDet.Fields("Pedido").Value), 0, oRsDet.Fields("Pedido").Value)
            .Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
            .Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
            .Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
            .Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
            .Fields("Adjunto").Value = oRsDet.Fields("Adjunto").Value
            .Fields("IdDetalleRequerimiento").Value = oRsDet.Fields(0).Value
            .Fields("IdDetalleLMateriales").Value = oRsDet.Fields("IdDetalleLMateriales").Value
            .Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
            .Fields("IdCuenta").Value = oRsDet.Fields("IdCuenta").Value
            .Fields("IdDetalleAcopios").Value = Null
            .Fields("IdCentroCosto").Value = oRsDet.Fields("IdCentroCosto").Value
            For i = 0 To 9
               .Fields("ArchivoAdjunto" & i + 1).Value = oRsDet.Fields("ArchivoAdjunto" & i + 1).Value
               FileBrowser1(i).Text = IIf(IsNull(oRsDet.Fields("ArchivoAdjunto" & i + 1).Value), "", oRsDet.Fields("ArchivoAdjunto" & i + 1).Value)
            Next
            .Fields("OrigenDescripcion").Value = IIf(IsNull(oRsDet.Fields("OrigenDescripcion").Value), 1, oRsDet.Fields("OrigenDescripcion").Value)
            txtNumeroItemRequerimiento.Text = oRsDet.Fields("NumeroItem").Value
            txtNumeroRequerimiento.Text = mvarNumeroRequerimiento
            txtNumeroItemAcopio.Text = ""
            txtNumeroAcopio.Text = ""
            If .Fields("OrigenDescripcion").Value = 1 Then
               Option1.Value = True
            ElseIf .Fields("OrigenDescripcion").Value = 2 Then
               Option2.Value = True
            ElseIf .Fields("OrigenDescripcion").Value = 3 Then
               Option3.Value = True
            End If
         End With
         
         oRsDet.Close
      
      ElseIf InStr(1, Filas(0), "Aco") <> 0 Or _
            (InStr(1, Filas(0), "Cpte.") <> 0 And mTipoComprobante = "LA") Then
      
         Set oRsDet = oAp.TablasGenerales.TraerFiltrado("DetAcopios", "_UnItem", Columnas(0))
         
         With origen.Registro
            .Fields("Cantidad").Value = 0
            .Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
            .Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
            .Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
            .Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
            .Fields("Adjunto").Value = oRsDet.Fields("Adjunto").Value
            .Fields("IdDetalleAcopios").Value = oRsDet.Fields(0).Value
            .Fields("IdDetalleLMateriales").Value = oRsDet.Fields("IdDetalleLMateriales").Value
            .Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
            .Fields("IdCuenta").Value = oRsDet.Fields("IdCuenta").Value
            .Fields("IdDetalleRequerimiento").Value = Null
            For i = 0 To 9
               .Fields("ArchivoAdjunto" & i + 1).Value = oRsDet.Fields("ArchivoAdjunto" & i + 1).Value
               FileBrowser1(i).Text = IIf(IsNull(oRsDet.Fields("ArchivoAdjunto" & i + 1).Value), "", oRsDet.Fields("ArchivoAdjunto" & i + 1).Value)
            Next
            txtNumeroItemAcopio.Text = oRsDet.Fields("NumeroItem").Value
            txtNumeroAcopio.Text = oRsDet.Fields("NumeroAcopio").Value
            txtNumeroObra.Text = oRsDet.Fields("Obra").Value
            txtNumeroItemRequerimiento.Text = ""
            txtNumeroRequerimiento.Text = ""
         End With
         
         oRsDet.Close
      
      Else
      
         MsgBox "Objeto invalido!" & vbCrLf & "Solo puede copiar items de requermientos", vbCritical
         Exit Sub
   
      End If
      
Salida:
      Set oRsDet = Nothing
      Set oRsObra = Nothing
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

Private Sub Form_Unload(Cancel As Integer)

   Set oBind = Nothing
   Set origen = Nothing
   Set oPresupuesto = Nothing

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
         Dim oRs As ADOR.Recordset
         Set oAp = Aplicacion
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set oRs = oAp.Articulos.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set oRs = oAp.Articulos.TraerLista
         End If
         Set DataCombo1(1).RowSource = oRs
         If oRs.RecordCount > 0 Then
            DataCombo1(1).BoundText = oRs.Fields(0).Value
         End If
         Set oRs = Nothing
         Set oAp = Nothing
      End If
      DataCombo1(1).SetFocus
      SendKeys "%{DOWN}"
   End If

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub txtCantidad_Change()

   CalcularItem
   
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

   With txtPrecio
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCantidad2_GotFocus()

   With txtPrecio
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

Private Sub txtItem_Validate(Cancel As Boolean)

   If Len(Trim(txtItem)) <> 0 And mvarId = -1 Then
      If oPresupuesto.DetPresupuestos.ItemExistente(txtItem.Text) Then
         MsgBox "El item ya existe en el presupuesto, ingrese otro numero.", vbCritical
         Cancel = True
      End If
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

Private Sub txtNumeroObra_Change()

   If Len(Trim(txtNumeroObra.Text)) <> 0 Then
      DataCombo1(2).Enabled = False
   Else
      DataCombo1(2).Enabled = True
   End If
   
End Sub

Private Sub txtPorcentajeBonificacion_Change()

   CalcularItem
   
End Sub

Private Sub txtPorcentajeBonificacion_GotFocus()

   With txtPorcentajeBonificacion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcentajeBonificacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
      KeyAscii = 0
   End If

End Sub

Private Sub txtPorcentajeIVA_Change()

   CalcularItem
   
End Sub

Private Sub txtPorcentajeIVA_GotFocus()

   With txtPorcentajeIVA
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcentajeIVA_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
      KeyAscii = 0
   End If

End Sub

Private Sub txtPrecio_Change()

   CalcularItem
   
End Sub

Private Sub txtPrecio_GotFocus()

   With txtPrecio
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPrecio_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
      KeyAscii = 0
   End If

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

Public Property Get FechaEntrega() As Date

   FechaEntrega = mFechaEntrega

End Property

Public Property Let FechaEntrega(ByVal vNewValue As Date)

   mFechaEntrega = vNewValue

End Property

Public Property Let TipoIVA(ByVal vNewValue As Integer)

   mTipoIva = vNewValue
   
End Property

Public Property Let CondicionIva(ByVal vNewValue As Integer)

   mCondicionIva = vNewValue
   
End Property

