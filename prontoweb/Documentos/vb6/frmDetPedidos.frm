VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{126E538A-EE41-4B22-A045-F8D5538F5D2B}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmDetPedidos 
   Caption         =   "Item de Pedido"
   ClientHeight    =   7545
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10800
   Icon            =   "frmDetPedidos.frx":0000
   LinkTopic       =   "Form1"
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   7545
   ScaleWidth      =   10800
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtImpuestosInternos 
      Alignment       =   1  'Right Justify
      DataField       =   "ImpuestosInternos"
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
      Left            =   7065
      TabIndex        =   79
      Top             =   2295
      Width           =   1050
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
      Left            =   7065
      TabIndex        =   8
      Top             =   1935
      Width           =   1050
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
      Left            =   4230
      TabIndex        =   74
      Top             =   450
      Width           =   2490
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
      Left            =   2070
      TabIndex        =   0
      Top             =   855
      Width           =   1410
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
      Left            =   8910
      TabIndex        =   72
      Top             =   2295
      Width           =   1050
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
      Left            =   5670
      TabIndex        =   11
      Top             =   2295
      Width           =   600
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
      Left            =   4275
      TabIndex        =   10
      Top             =   2295
      Width           =   600
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Desactivar"
      Height          =   360
      Index           =   3
      Left            =   3375
      TabIndex        =   69
      Top             =   2655
      Width           =   990
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Activar"
      Height          =   360
      Index           =   4
      Left            =   7155
      TabIndex        =   68
      Top             =   2655
      Width           =   990
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
      Left            =   2070
      TabIndex        =   45
      Top             =   450
      Width           =   1410
   End
   Begin VB.Frame Frame1 
      Caption         =   "Tomar la descripcion de : "
      Height          =   1005
      Left            =   8190
      TabIndex        =   41
      Top             =   1215
      Width           =   2490
      Begin VB.OptionButton Option2 
         Caption         =   "Solo las observaciones"
         Height          =   195
         Left            =   135
         TabIndex        =   44
         Top             =   472
         Width           =   2040
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Solo el material"
         Height          =   195
         Left            =   135
         TabIndex        =   43
         Top             =   225
         Width           =   1410
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Material mas observaciones"
         Height          =   195
         Left            =   135
         TabIndex        =   42
         Top             =   720
         Width           =   2265
      End
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1320
      Left            =   2070
      TabIndex        =   15
      Top             =   3780
      Width           =   8655
      _ExtentX        =   15266
      _ExtentY        =   2328
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmDetPedidos.frx":076A
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
      Left            =   2070
      TabIndex        =   9
      Top             =   2295
      Width           =   1230
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
      Left            =   7695
      Locked          =   -1  'True
      TabIndex        =   33
      Top             =   45
      Width           =   1140
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
      Left            =   8910
      Locked          =   -1  'True
      TabIndex        =   32
      Top             =   45
      Width           =   465
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   525
      Index           =   0
      Left            =   45
      TabIndex        =   16
      Top             =   4185
      Width           =   945
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   525
      Index           =   1
      Left            =   1035
      TabIndex        =   17
      Top             =   4185
      Width           =   885
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
      Left            =   2070
      TabIndex        =   24
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
      Left            =   7695
      TabIndex        =   23
      Top             =   450
      Width           =   2985
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
      Left            =   5670
      TabIndex        =   6
      Top             =   1590
      Width           =   735
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
      Left            =   2070
      TabIndex        =   3
      Top             =   1590
      Width           =   870
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
      Left            =   4680
      TabIndex        =   5
      Top             =   1590
      Width           =   735
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Buscar RM / LA"
      Height          =   300
      Index           =   2
      Left            =   45
      TabIndex        =   18
      Top             =   4770
      Width           =   1890
   End
   Begin VB.TextBox txtNumeroAcopio 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroAcopio"
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
      Left            =   4590
      Locked          =   -1  'True
      TabIndex        =   22
      Top             =   45
      Visible         =   0   'False
      Width           =   915
   End
   Begin VB.TextBox txtNumeroItemAcopio 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroItemAcopio"
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
      Left            =   5580
      Locked          =   -1  'True
      TabIndex        =   21
      Top             =   45
      Visible         =   0   'False
      Width           =   465
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
      Left            =   6435
      TabIndex        =   20
      Top             =   1590
      Width           =   1680
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   3510
      TabIndex        =   1
      Tag             =   "Articulos"
      Top             =   855
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
      Left            =   2970
      TabIndex        =   4
      Tag             =   "Unidades"
      Top             =   1590
      Width           =   1680
      _ExtentX        =   2963
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
      Left            =   2070
      TabIndex        =   7
      Tag             =   "ControlesCalidad"
      Top             =   1950
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
      Left            =   2070
      TabIndex        =   12
      Top             =   2655
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   635
      _Version        =   393216
      Format          =   59965441
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "Adjunto"
      Height          =   315
      Index           =   5
      Left            =   2070
      TabIndex        =   13
      Tag             =   "SiNo"
      Top             =   3060
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
      Left            =   5895
      TabIndex        =   19
      Top             =   2655
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
      Format          =   59965441
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   2
      Left            =   2070
      TabIndex        =   2
      Tag             =   "Cuentas"
      Top             =   1215
      Visible         =   0   'False
      Width           =   6045
      _ExtentX        =   10663
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
      TabIndex        =   47
      Top             =   5445
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
      TabIndex        =   48
      Top             =   5850
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
      TabIndex        =   49
      Top             =   6255
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
      TabIndex        =   50
      Top             =   6660
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
      TabIndex        =   51
      Top             =   7065
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
      TabIndex        =   52
      Top             =   5445
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
      TabIndex        =   53
      Top             =   5850
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
      TabIndex        =   54
      Top             =   6255
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
      TabIndex        =   55
      Top             =   6660
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
      TabIndex        =   56
      Top             =   7065
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
      DataField       =   "IdCentroCosto"
      Height          =   315
      Index           =   3
      Left            =   4410
      TabIndex        =   14
      Tag             =   "CentrosCosto"
      Top             =   3060
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
      Left            =   2070
      TabIndex        =   78
      Tag             =   "PlazosEntrega"
      Top             =   3420
      Width           =   8655
      _ExtentX        =   15266
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPlazoEntrega"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Imp.Int. :"
      Height          =   255
      Index           =   21
      Left            =   6345
      TabIndex        =   80
      Top             =   2325
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "Plazo de entrega :"
      Height          =   300
      Index           =   20
      Left            =   90
      TabIndex        =   77
      Top             =   3420
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Costo :"
      Height          =   255
      Index           =   19
      Left            =   6345
      TabIndex        =   76
      Top             =   1965
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cliente :"
      Height          =   300
      Index           =   18
      Left            =   3555
      TabIndex        =   75
      Top             =   495
      Width           =   600
   End
   Begin VB.Label lblLabels 
      Caption         =   "TOTAL :"
      Height          =   255
      Index           =   17
      Left            =   8190
      TabIndex        =   73
      Top             =   2325
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "IVA [%] :"
      Height          =   255
      Index           =   16
      Left            =   4950
      TabIndex        =   71
      Top             =   2325
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "Bonif. [%] :"
      Height          =   255
      Index           =   15
      Left            =   3375
      TabIndex        =   70
      Top             =   2325
      Width           =   825
   End
   Begin VB.Label lblLabels 
      Caption         =   "Centro de costo :"
      Height          =   300
      Index           =   13
      Left            =   3015
      TabIndex        =   67
      Top             =   3075
      Visible         =   0   'False
      Width           =   1320
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000005&
      BorderWidth     =   3
      X1              =   0
      X2              =   10755
      Y1              =   5265
      Y2              =   5265
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 1 :"
      Height          =   300
      Index           =   0
      Left            =   90
      TabIndex        =   66
      Top             =   5445
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 2 :"
      Height          =   300
      Index           =   1
      Left            =   90
      TabIndex        =   65
      Top             =   5850
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 3 :"
      Height          =   300
      Index           =   2
      Left            =   90
      TabIndex        =   64
      Top             =   6255
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 4 :"
      Height          =   300
      Index           =   3
      Left            =   90
      TabIndex        =   63
      Top             =   6660
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 5 :"
      Height          =   300
      Index           =   4
      Left            =   90
      TabIndex        =   62
      Top             =   7065
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 6 :"
      Height          =   300
      Index           =   5
      Left            =   5670
      TabIndex        =   61
      Top             =   5490
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 7 :"
      Height          =   300
      Index           =   6
      Left            =   5670
      TabIndex        =   60
      Top             =   5895
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 8 :"
      Height          =   300
      Index           =   7
      Left            =   5670
      TabIndex        =   59
      Top             =   6300
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 9 :"
      Height          =   300
      Index           =   8
      Left            =   5670
      TabIndex        =   58
      Top             =   6705
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 10 :"
      Height          =   300
      Index           =   9
      Left            =   5670
      TabIndex        =   57
      Top             =   7110
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de obra :"
      Height          =   300
      Index           =   10
      Left            =   90
      TabIndex        =   46
      Top             =   495
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta contable :"
      Height          =   255
      Index           =   9
      Left            =   90
      TabIndex        =   40
      Top             =   1260
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha necesidad :"
      Height          =   300
      Index           =   8
      Left            =   4500
      TabIndex        =   39
      Top             =   2700
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Adjunto ? :"
      Height          =   300
      Index           =   12
      Left            =   90
      TabIndex        =   38
      Top             =   3060
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de entrega :"
      Height          =   300
      Index           =   6
      Left            =   90
      TabIndex        =   37
      Top             =   2700
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   255
      Index           =   5
      Left            =   90
      TabIndex        =   36
      Top             =   3825
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Precio unitario :"
      Height          =   300
      Index           =   4
      Left            =   90
      TabIndex        =   35
      Top             =   2325
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero RM - item :"
      Height          =   300
      Index           =   1
      Left            =   6210
      TabIndex        =   34
      Top             =   90
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Control de calidad :"
      Height          =   300
      Index           =   11
      Left            =   90
      TabIndex        =   31
      Top             =   1965
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   2
      Left            =   90
      TabIndex        =   30
      Top             =   870
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   90
      TabIndex        =   29
      Top             =   1590
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de item :"
      Height          =   300
      Index           =   3
      Left            =   90
      TabIndex        =   28
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
      Height          =   300
      Index           =   14
      Left            =   6795
      TabIndex        =   27
      Top             =   495
      Width           =   825
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
      Left            =   5445
      TabIndex        =   26
      Top             =   1635
      Width           =   195
   End
   Begin VB.Label lblLabels 
      Caption         =   "Lista de acopio - item :"
      Height          =   300
      Index           =   0
      Left            =   2880
      TabIndex        =   25
      Top             =   90
      Visible         =   0   'False
      Width           =   1590
   End
End
Attribute VB_Name = "frmDetPedidos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetPedido
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oPedido As ComPronto.Pedido
Public Aceptado As Boolean
Private mvarIdUnidadCU As Integer, mTipoIva As Integer, mCondicionIva As Integer
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long, mvarIdControlCalidadStandar As Long
Private mvarCantidadAdicional As Double, mvarCantidadUnidades As Double, mvarP_IVA1 As Double, mvarP_IVA2 As Double
Private mPorcentajeIVA As Double
Private mvarPathAdjuntos As String, mExterior As String, mTipoCosto As String

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim i As Integer
         Dim mvarControlFechaNecesidad As String
      
         For Each dtp In DTFields
            If dtp.Enabled Then
               origen.Registro.Fields(dtp.DataField).Value = dtp.Value
            Else
               origen.Registro.Fields(dtp.DataField).Value = Null
            End If
         Next
         
         For Each dc In DataCombo1
            If (dc.Enabled And dc.Visible And Len(dc.DataField) <> 0) Or dc.Index = 0 Then
               If Len(Trim(dc.BoundText)) = 0 Then
                  If dc.Index <> 4 And Not _
                     (dc.Index = 3 And Len(txtNumeroObra.Text) <> 0) Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
               End If
               If Len(Trim(dc.BoundText)) <> 0 Then
                  origen.Registro.Fields(dc.DataField).Value = dc.BoundText
               End If
            End If
         Next
         
         mvarCantidadAdicional = 0
         
         If IsNull(origen.Registro.Fields("Cantidad").Value) Or origen.Registro.Fields("Cantidad").Value = 0 Then
            MsgBox "Falta ingresar la cantidad (unidades)", vbCritical
            Exit Sub
         End If
         
         If txtCantidad1.Visible Then
            If IsNull(origen.Registro.Fields("Cantidad1").Value) Or origen.Registro.Fields("Cantidad1").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 1)", vbCritical
               Exit Sub
            End If
            mvarCantidadAdicional = Val(txtCantidad1.Text)
         End If
         
         If txtCantidad2.Visible Then
            If IsNull(origen.Registro.Fields("Cantidad2").Value) Or origen.Registro.Fields("Cantidad2").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 2)", vbCritical
               Exit Sub
            End If
            mvarCantidadAdicional = Val(txtCantidad1.Text) * Val(txtCantidad2.Text)
         End If
         
         If (IsNull(origen.Registro.Fields("Precio").Value) Or origen.Registro.Fields("Precio").Value = 0) And IsNull(Pedido.Registro.Fields("IdPedidoAbierto").Value) Then
            MsgBox "Falta ingresar el precio unitario", vbCritical
            Exit Sub
         End If
         
         If DTFields(0).Enabled And DTFields(0).Value < oPedido.Registro.Fields("FechaPedido").Value Then
            MsgBox "La fecha de entrega no puede ser menor a la del pedido", vbCritical
            Exit Sub
         End If
         
         mvarControlFechaNecesidad = BuscarClaveINI("Quitar control fecha necesidad en pedidos")
         If mvarControlFechaNecesidad <> "SI" And _
               DTFields(1).Value < oPedido.Registro.Fields("FechaPedido").Value Then
            MsgBox "La fecha de necesidad no puede ser menor a la del pedido", vbCritical
            Exit Sub
         End If
         
         With origen.Registro
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
            If .Fields("IdUnidad").Value = mvarIdUnidadCU Then
               mvarCantidadUnidades = .Fields("Cantidad").Value
               .Fields("CantidadAdicional").Value = mvarCantidadAdicional * mvarCantidadUnidades
            End If
            .Fields("EnviarEmail").Value = 1
            .Fields("PlazoEntrega").Value = DataCombo1(6).Text
         End With
         
         origen.Modificado = True
         Aceptado = True
   
         Me.Hide

      Case 1
         If mvarId = -1 Then origen.Eliminado = True
         Me.Hide
   
      Case 2
         Dim oF As frmConsultaRMPendientes
         
         Set oF = New frmConsultaRMPendientes
         With oF
            .Show vbModal, Me
         End With
         Unload oF
         Set oF = Nothing
      
      Case 3
         If DTFields(0).Enabled Then
            DTFields(0).Enabled = False
            cmd(3).Caption = "Activar"
            origen.Registro.Fields("FechaEntrega").Value = Null
         Else
            DTFields(0).Enabled = True
            DTFields(0).Value = Date
            cmd(3).Caption = "Desactivar"
            origen.Registro.Fields("FechaEntrega").Value = Date
         End If
      
      Case 4
         If DTFields(1).Enabled Then
            DTFields(1).Enabled = False
            cmd(4).Caption = "Activar"
            origen.Registro.Fields("FechaNecesidad").Value = Null
         Else
            Dim mvarOK As Boolean
            Dim of1 As frmAutorizacion
            
            Set of1 = New frmAutorizacion
            With of1
               .Administradores = True
               .Show vbModal, Me
               mvarOK = .Ok
            End With
            Unload of1
            Set of1 = Nothing
            If Not mvarOK Then Exit Sub
            
            DTFields(1).Enabled = True
            DTFields(1).Value = Date
            cmd(4).Caption = "Desactivar"
            origen.Registro.Fields("FechaNecesidad").Value = Date
         End If
   
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim dtp As DTPicker
   Dim oControl As Control
   Dim i As Integer
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim oRsObra As ADOR.Recordset

   mvarId = vNewValue
   
   Set oAp = Aplicacion
   
   Set origen = oPedido.DetPedidos.Item(vNewValue)
   Me.IdNuevo = origen.Id
   
   If glbParametrizacionNivel1 Then
      lblLabels(11).Visible = False
      DataCombo1(4).Visible = False
'      cmd(2).Visible = False
   End If
   
   Set oBind = New BindingCollection
   
   mTipoCosto = BuscarClaveINI("CostoStandarParaPedidos")
   If mTipoCosto = "" Then mTipoCosto = "CostoPPP"
   
   If BuscarClaveINI("Habilitar impuestos internos en items de pedido") = "SI" Then txtImpuestosInternos.Enabled = True
   
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
      For Each dtp In DTFields
         If dtp.Enabled Then
            dtp.Value = Date
         End If
      Next
      With origen.Registro
         .Fields("NumeroItem").Value = oPedido.DetPedidos.UltimoItemDetalle
         .Fields("Adjunto").Value = "NO"
         .Fields("OrigenDescripcion").Value = 1
         mPorcentajeIVA = 0
         If mTipoIva = 0 And mExterior <> "SI" Then
            Select Case mCondicionIva
               Case 1
                  mPorcentajeIVA = mvarP_IVA1
               Case 2
                  mPorcentajeIVA = mvarP_IVA1 + mvarP_IVA2
            End Select
         End If
         .Fields("PorcentajeIVA").Value = mPorcentajeIVA
         .Fields("IdControlCalidad").Value = mvarIdControlCalidadStandar
      End With
      Option1.Value = True
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
         For i = 0 To 9
            FileBrowser1(i).Text = .Fields("ArchivoAdjunto" & i + 1).Value
         Next
         If IsNull(.Fields("PorcentajeIVA").Value) And mExterior <> "SI" Then
            .Fields("PorcentajeIVA").Value = mPorcentajeIVA
         End If
         If Not IsNull(.Fields("PlazoEntrega").Value) Then
            DataCombo1(6).Text = .Fields("PlazoEntrega").Value
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
   End If
   
   If mvarId > 0 And Not IsNull(oPedido.Registro.Fields("Aprobo").Value) Then
'      cmd(0).Enabled = False
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
      
      If Not IsNull(.Fields("IdDetalleAcopios").Value) Then
         Set oRs = oAp.TablasGenerales.TraerFiltrado("DetAcopios", "_UnItem", .Fields("IdDetalleAcopios").Value)
         If oRs.RecordCount > 0 Then
            txtNumeroItemAcopio.Text = oRs.Fields("NumeroItem").Value
            txtNumeroAcopio.Text = oRs.Fields("NumeroAcopio").Value
            If Not IsNull(oRs.Fields("Obra").Value) Then
               txtNumeroObra.Text = oRs.Fields("Obra").Value
            End If
            If Not IsNull(oRs.Fields("Cliente").Value) Then
               txtCliente.Text = oRs.Fields("Cliente").Value
            End If
         End If
         oRs.Close
      End If
      
      If mvarId = -1 Then
         .Fields("FechaEntrega").Value = Date
         DTFields(0).Value = Date
      Else
         If IsNull(.Fields("FechaEntrega").Value) Then
            DTFields(0).Enabled = False
            cmd(3).Caption = "Activar"
         Else
            DTFields(0).Enabled = True
            DTFields(0).Value = .Fields("FechaEntrega").Value
            cmd(3).Caption = "Desactivar"
         End If
         cmd(0).TabIndex = 0
         txtPrecio.TabIndex = 0
      End If
         
      If IsNull(.Fields("FechaNecesidad").Value) Then
         .Fields("FechaNecesidad").Value = Date
         DTFields(1).Value = Date
         cmd(4).Caption = "Activar"
      Else
         DTFields(1).Enabled = True
         DTFields(1).Value = .Fields("FechaNecesidad").Value
         cmd(4).Caption = "Desactivar"
      End If
   End With
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   MuestraAdjuntos
   CalcularItem
   
   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then
      DataCombo1(0).Enabled = False
   End If
   
End Property

Public Property Get Pedido() As ComPronto.Pedido

   Set Pedido = oPedido

End Property

Public Property Set Pedido(ByVal vNewValue As ComPronto.Pedido)

   Set oPedido = vNewValue

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
      
      Case 2
      
         If IsNumeric(DataCombo1(Index).BoundText) Then
            origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
         End If
      
      Case 3
      
         If IsNumeric(DataCombo1(Index).BoundText) Then
            origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
         End If
      
      Case 5
   
         origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
         MuestraAdjuntos
      
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

   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String, mExiste As String
   Dim iFilas As Long, iColumnas As Long, mvarNumeroRequerimiento As Long
   Dim i As Integer
   Dim oAp As ComPronto.Aplicacion
   Dim oRsDet As ADOR.Recordset
   Dim oRsObra As ADOR.Recordset
   Dim Filas, Columnas

   On Error GoTo Mal
   
   If Data.GetFormat(ccCFText) Then
      
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      Set oAp = Aplicacion
      
      Columnas = Split(Filas(1), vbTab)
      
      If InStr(1, Columnas(8), "RM") <> 0 Then
      
         Set oRsDet = oAp.Requerimientos.TraerFiltrado("_DatosRequerimiento", Columnas(0))
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
         oRsDet.Close
         
         Set oRsDet = oAp.Requerimientos.TraerFiltrado("_DatosRequerimiento", Columnas(0))
         
         mvarNumeroRequerimiento = oRsDet.Fields("NumeroRequerimiento").Value
         
         If Not IsNull(oRsDet.Fields("IdDetalleRequerimiento").Value) Then
            Set oRsObra = oAp.Requerimientos.TraerFiltrado("_DatosObra", oRsDet.Fields("IdDetalleRequerimiento").Value)
            If Not IsNull(oRsObra.Fields("Obra").Value) Then
               txtNumeroObra.Text = oRsObra.Fields("Obra").Value
            End If
            If Not IsNull(oRsObra.Fields("Cliente").Value) Then
               txtCliente.Text = oRsObra.Fields("Cliente").Value
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
            .Fields("IdControlCalidad").Value = IIf(IsNull(oRsDet.Fields("IdControlCalidad").Value), mvarIdControlCalidadStandar, oRsDet.Fields("IdControlCalidad").Value)
            .Fields("Adjunto").Value = oRsDet.Fields("Adjunto").Value
            .Fields("IdDetalleRequerimiento").Value = oRsDet.Fields(0).Value
            .Fields("IdDetalleLMateriales").Value = oRsDet.Fields("IdDetalleLMateriales").Value
            .Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
            .Fields("IdCuenta").Value = oRsDet.Fields("IdCuenta").Value
            .Fields("IdCentroCosto").Value = oRsDet.Fields("IdCentroCosto").Value
            .Fields("Cumplido").Value = "NO"
            .Fields("IdDetalleAcopios").Value = Null
            For i = 0 To 9
               .Fields("ArchivoAdjunto" & i + 1).Value = oRsDet.Fields("ArchivoAdjunto" & i + 1).Value
               FileBrowser1(i).Text = IIf(IsNull(oRsDet.Fields("ArchivoAdjunto" & i + 1).Value), "", oRsDet.Fields("ArchivoAdjunto" & i + 1).Value)
            Next
            .Fields("OrigenDescripcion").Value = IIf(IsNull(oRsDet.Fields("OrigenDescripcion").Value), 1, oRsDet.Fields("OrigenDescripcion").Value)
            
            txtNumeroItemRequerimiento.Text = oRsDet.Fields("NumeroItem").Value
            txtNumeroRequerimiento.Text = mvarNumeroRequerimiento
            If .Fields("OrigenDescripcion").Value = 1 Then
               Option1.Value = True
            ElseIf .Fields("OrigenDescripcion").Value = 2 Then
               Option2.Value = True
            ElseIf .Fields("OrigenDescripcion").Value = 3 Then
               Option3.Value = True
            End If
         
            mExiste = oPedido.ItemEnOtrosPedidos(oRsDet.Fields(0).Value, "RM")
            If Len(mExiste) Then
               MsgBox "Cuidado, el item de la RM ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
            End If
         End With
         
         oRsDet.Close
      
      ElseIf InStr(1, Columnas(8), "LA") <> 0 Then
      
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
            .Fields("IdControlCalidad").Value = mvarIdControlCalidadStandar
            .Fields("Cumplido").Value = "NO"
            For i = 0 To 9
               .Fields("ArchivoAdjunto" & i + 1).Value = oRsDet.Fields("ArchivoAdjunto" & i + 1).Value
               FileBrowser1(i).Text = IIf(IsNull(oRsDet.Fields("ArchivoAdjunto" & i + 1).Value), "", oRsDet.Fields("ArchivoAdjunto" & i + 1).Value)
            Next
            
            txtNumeroItemAcopio.Text = oRsDet.Fields("NumeroItem").Value
            txtNumeroAcopio.Text = oRsDet.Fields("NumeroAcopio").Value
            If Not IsNull(oRsDet.Fields("Obra").Value) Then
               txtNumeroObra.Text = oRsDet.Fields("Obra").Value
            End If
            If Not IsNull(oRsDet.Fields("Cliente").Value) Then
               txtCliente.Text = oRsDet.Fields("Cliente").Value
            End If
            txtNumeroItemRequerimiento.Text = ""
            txtNumeroRequerimiento.Text = ""
            
            mExiste = oPedido.ItemEnOtrosPedidos(oRsDet.Fields(0).Value, "LA")
            If Len(mExiste) Then
               MsgBox "Cuidado, el item de la LA ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
            End If
         
         End With
         
         oRsDet.Close
      
      Else
      
         MsgBox "Objeto invalido!" & vbCrLf & "Solo puede copiar items de requermientos", vbCritical
         Exit Sub
   
      End If
      
   End If
   
Salida:
   
   Set oRsDet = Nothing
   Set oRsObra = Nothing
   Set oAp = Nothing
   
   Clipboard.Clear

   Exit Sub
   
Mal:

   MsgBox "Se ha producido un problema al tratar de generar la solicitud" & vbCrLf & Err.Description, vbCritical
   Resume Salida
   
End Sub

Private Sub Form_OLEDragOver(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

   Dim s As String
   Dim Filas, Columnas
   Dim iFilas As Long
   Dim iColumnas As Long
   Dim oL As ListItem

   If State = vbEnter Then
      If Data.GetFormat(ccCFText) Then
         s = Data.GetData(ccCFText)
         Filas = Split(s, vbCrLf)
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

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
      KeyAscii = 0
   End If

End Sub

Private Sub txtCantidad1_GotFocus()

   With txtCantidad1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
      KeyAscii = 0
   End If

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

Private Sub txtItem_GotFocus()
   
   With txtItem
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtItem_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
      KeyAscii = 0
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

   Dim mImporte As Double, mBonificacion As Double, mIVA As Double, mImpuestosInternos As Double
   
   With origen.Registro
      mImporte = 0
      mBonificacion = 0
      mIVA = 0
      mImpuestosInternos = 0
      
      If IsNumeric(txtPrecio.Text) And IsNumeric(txtCantidad.Text) Then
         mImporte = Val(txtPrecio.Text) * Val(txtCantidad.Text)
      End If
      If IsNumeric(txtPorcentajeBonificacion.Text) Then
         mBonificacion = Round(mImporte * Val(txtPorcentajeBonificacion.Text) / 100, 4)
      End If
      If IsNumeric(txtPorcentajeIVA.Text) Then
         mIVA = Round((mImporte - mBonificacion) * Val(txtPorcentajeIVA.Text) / 100, 4)
      End If
      If IsNumeric(txtImpuestosInternos.Text) Then
         mImpuestosInternos = Val(txtImpuestosInternos.Text)
      End If
      mImporte = mImporte - mBonificacion + mIVA + mImpuestosInternos
      
      .Fields("ImporteTotalItem").Value = mImporte
      .Fields("ImporteBonificacion").Value = mBonificacion
      .Fields("ImporteIVA").Value = mIVA
   End With

End Sub

Public Property Let TipoIVA(ByVal vNewValue As Integer)

   mTipoIva = vNewValue
   
End Property

Public Property Let CondicionIva(ByVal vNewValue As Integer)

   mCondicionIva = vNewValue
   
End Property

Public Property Let Exterior(ByVal vNewValue As String)

   mExterior = vNewValue
   
End Property

