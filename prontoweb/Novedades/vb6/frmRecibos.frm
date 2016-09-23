VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F09A78C8-7814-11D2-8355-4854E82A9183}#1.1#0"; "CUIT32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.4#0"; "Controles1013.ocx"
Begin VB.Form frmRecibos 
   Caption         =   "Recibos de pago"
   ClientHeight    =   6930
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   Icon            =   "frmRecibos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6930
   ScaleWidth      =   11880
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Activar anticipos al personal"
      Height          =   240
      Left            =   0
      TabIndex        =   86
      Top             =   3555
      Visible         =   0   'False
      Width           =   2310
   End
   Begin VB.CommandButton cmd 
      BackColor       =   &H00C0C0FF&
      Caption         =   "Otros conceptos"
      CausesValidation=   0   'False
      Height          =   375
      Index           =   2
      Left            =   4050
      Style           =   1  'Graphical
      TabIndex        =   85
      Top             =   6480
      Width           =   1470
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdVendedor"
      Height          =   315
      Index           =   1
      Left            =   10350
      TabIndex        =   72
      Tag             =   "Vendedores"
      Top             =   5760
      Visible         =   0   'False
      Width           =   1410
      _ExtentX        =   2487
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdVendedor"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCobrador"
      Height          =   315
      Index           =   2
      Left            =   10350
      TabIndex        =   73
      Tag             =   "Vendedores"
      Top             =   6120
      Visible         =   0   'False
      Width           =   1410
      _ExtentX        =   2487
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdVendedor"
      Text            =   ""
   End
   Begin Control_CUIT.CUIT CUIT1 
      Height          =   285
      Left            =   9405
      TabIndex        =   81
      Top             =   5400
      Visible         =   0   'False
      Width           =   1545
      _ExtentX        =   2725
      _ExtentY        =   503
      Text            =   ""
      MensajeErr      =   "CUIT incorrecto"
      otrosP          =   -1  'True
   End
   Begin VB.TextBox txtComprobanteProveedor 
      Alignment       =   1  'Right Justify
      Height          =   270
      Left            =   8280
      TabIndex        =   83
      Top             =   1350
      Visible         =   0   'False
      Width           =   1245
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   0
      ItemData        =   "frmRecibos.frx":076A
      Left            =   990
      List            =   "frmRecibos.frx":0774
      TabIndex        =   79
      Top             =   3375
      Visible         =   0   'False
      Width           =   1770
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
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   9000
      TabIndex        =   75
      Top             =   1530
      Visible         =   0   'False
      Width           =   2490
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   375
      Index           =   0
      Left            =   1845
      Picture         =   "frmRecibos.frx":07A3
      Style           =   1  'Graphical
      TabIndex        =   68
      Top             =   6480
      UseMaskColor    =   -1  'True
      Width           =   570
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   375
      Index           =   1
      Left            =   2475
      Picture         =   "frmRecibos.frx":0E0D
      Style           =   1  'Graphical
      TabIndex        =   67
      Top             =   6480
      Width           =   570
   End
   Begin VB.TextBox txtNumeroRecibo 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroRecibo"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   1530
      TabIndex        =   2
      Top             =   90
      Width           =   1020
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Anular"
      CausesValidation=   0   'False
      Height          =   375
      Index           =   5
      Left            =   3105
      TabIndex        =   28
      Top             =   6480
      Width           =   885
   End
   Begin VB.TextBox txtNumeroCertificadoRetencionIngresosBrutos 
      DataField       =   "NumeroCertificadoRetencionIngresosBrutos"
      Height          =   270
      Left            =   9585
      TabIndex        =   22
      Top             =   855
      Visible         =   0   'False
      Width           =   1245
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "Incorporar dif."
      Height          =   285
      Index           =   8
      Left            =   1080
      TabIndex        =   27
      Top             =   3720
      Width           =   1155
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
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
      Index           =   4
      Left            =   4905
      Locked          =   -1  'True
      TabIndex        =   60
      Top             =   3690
      Width           =   1230
   End
   Begin VB.TextBox txtCotizacionMoneda 
      Alignment       =   1  'Right Justify
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
      Height          =   285
      Left            =   10935
      TabIndex        =   58
      Top             =   1080
      Width           =   870
   End
   Begin VB.TextBox txtNumeroCertificadoRetencionGanancias 
      DataField       =   "NumeroCertificadoRetencionGanancias"
      Height          =   270
      Left            =   4860
      TabIndex        =   18
      Top             =   1170
      Width           =   1245
   End
   Begin VB.TextBox txtNumeroCertificadoSUSS 
      DataField       =   "NumeroCertificadoSUSS"
      Height          =   270
      Left            =   9585
      TabIndex        =   23
      Top             =   1125
      Visible         =   0   'False
      Width           =   1245
   End
   Begin VB.TextBox txtNumeroCertificadoRetencionIVA 
      DataField       =   "NumeroCertificadoRetencionIVA"
      Height          =   270
      Left            =   4860
      TabIndex        =   20
      Top             =   1440
      Width           =   1245
   End
   Begin VB.CheckBox Check4 
      Caption         =   "Check4"
      Height          =   195
      Left            =   7200
      TabIndex        =   10
      Top             =   540
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Calcular asiento contable"
      Height          =   330
      Index           =   3
      Left            =   6345
      TabIndex        =   14
      Top             =   3375
      Width           =   2145
   End
   Begin VB.CheckBox Check3 
      Alignment       =   1  'Right Justify
      Caption         =   "Manual :"
      Height          =   240
      Left            =   10890
      TabIndex        =   15
      Top             =   1485
      Width           =   915
   End
   Begin VB.Frame Frame1 
      Caption         =   "Tipo de recibo : "
      Height          =   735
      Left            =   2610
      TabIndex        =   52
      Top             =   45
      Width           =   1365
      Begin VB.OptionButton Option1 
         Caption         =   "De cliente"
         Height          =   195
         Left            =   90
         TabIndex        =   63
         Top             =   225
         Width           =   1095
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Otros"
         Height          =   195
         Left            =   90
         TabIndex        =   0
         Top             =   495
         Width           =   735
      End
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Calcular diferencia de cambio :"
      Height          =   240
      Left            =   45
      TabIndex        =   8
      Top             =   1170
      Width           =   2490
   End
   Begin VB.TextBox txtCotizacion 
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
      Height          =   285
      Left            =   10935
      TabIndex        =   7
      Top             =   450
      Width           =   900
   End
   Begin VB.TextBox txtDif 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0FF&
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
      Height          =   285
      Left            =   10485
      TabIndex        =   45
      Top             =   5130
      Width           =   1215
   End
   Begin VB.TextBox txtGasGen 
      Alignment       =   1  'Right Justify
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
      Height          =   285
      Left            =   10485
      TabIndex        =   44
      Top             =   4725
      Width           =   1215
   End
   Begin VB.TextBox txtRetGan 
      Alignment       =   1  'Right Justify
      DataField       =   "RetencionGanancias"
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
      Left            =   10485
      TabIndex        =   19
      Top             =   4410
      Width           =   1215
   End
   Begin VB.TextBox txtRetIva 
      Alignment       =   1  'Right Justify
      DataField       =   "RetencionIVA"
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
      Left            =   10485
      TabIndex        =   21
      Top             =   4095
      Width           =   1215
   End
   Begin VB.TextBox txtEfectivo 
      Alignment       =   1  'Right Justify
      DataField       =   "Efectivo"
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
      Left            =   10485
      TabIndex        =   43
      Top             =   3780
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
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
      Index           =   3
      Left            =   7065
      Locked          =   -1  'True
      TabIndex        =   39
      Top             =   5130
      Width           =   1275
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
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
      Index           =   1
      Left            =   9540
      Locked          =   -1  'True
      TabIndex        =   33
      Top             =   3375
      Width           =   1095
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
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
      Index           =   0
      Left            =   4905
      Locked          =   -1  'True
      TabIndex        =   32
      Top             =   3375
      Width           =   1230
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
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
      Index           =   2
      Left            =   10710
      Locked          =   -1  'True
      TabIndex        =   31
      Top             =   3375
      Width           =   1095
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   375
      Index           =   0
      Left            =   45
      TabIndex        =   25
      Top             =   6480
      Width           =   840
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   375
      Index           =   1
      Left            =   945
      TabIndex        =   26
      Top             =   6480
      Width           =   840
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaRecibo"
      Height          =   330
      Index           =   0
      Left            =   1305
      TabIndex        =   3
      Top             =   450
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   16973825
      CurrentDate     =   36377
   End
   Begin Controles1013.DbListView Lista 
      Height          =   1635
      Left            =   0
      TabIndex        =   12
      Top             =   1710
      Width           =   6315
      _ExtentX        =   11139
      _ExtentY        =   2884
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmRecibos.frx":1397
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaCta 
      Height          =   1635
      Left            =   6345
      TabIndex        =   16
      Top             =   1710
      Width           =   5505
      _ExtentX        =   9710
      _ExtentY        =   2884
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmRecibos.frx":13B3
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaVal 
      Height          =   1140
      Left            =   0
      TabIndex        =   13
      Top             =   3960
      Width           =   8475
      _ExtentX        =   14949
      _ExtentY        =   2011
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmRecibos.frx":13CF
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   3
      Left            =   900
      TabIndex        =   6
      Tag             =   "Monedas"
      Top             =   810
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields1 
      DataField       =   "IdCuentaGasto"
      Height          =   315
      Index           =   1
      Left            =   7380
      TabIndex        =   11
      Tag             =   "CuentasGastos"
      Top             =   495
      Visible         =   0   'False
      Width           =   1770
      _ExtentX        =   3122
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaGasto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields1 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   0
      Left            =   4860
      TabIndex        =   9
      Tag             =   "Obras"
      Top             =   495
      Visible         =   0   'False
      Width           =   2310
      _ExtentX        =   4075
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields1 
      Height          =   315
      Index           =   2
      Left            =   9180
      TabIndex        =   4
      Tag             =   "TiposCuentaGrupos"
      Top             =   495
      Visible         =   0   'False
      Width           =   1680
      _ExtentX        =   2963
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoCuentaGrupo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields1 
      DataField       =   "IdTipoRetencionGanancia"
      Height          =   315
      Index           =   3
      Left            =   4860
      TabIndex        =   17
      Tag             =   "TiposRetencionGanancia"
      Top             =   855
      Visible         =   0   'False
      Width           =   2310
      _ExtentX        =   4075
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoRetencionGanancia"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdPuntoVenta"
      Height          =   315
      Index           =   10
      Left            =   765
      TabIndex        =   1
      Tag             =   "PuntosVenta"
      Top             =   90
      Width           =   735
      _ExtentX        =   1296
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPuntoVenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCliente"
      Height          =   315
      Index           =   0
      Left            =   5670
      TabIndex        =   5
      Tag             =   "Clientes"
      Top             =   120
      Width           =   5190
      _ExtentX        =   9155
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCliente"
      Text            =   ""
   End
   Begin VB.TextBox txtCodigo 
      Alignment       =   1  'Right Justify
      Height          =   315
      Left            =   4860
      TabIndex        =   62
      Top             =   120
      Width           =   750
   End
   Begin Controles1013.DbListView ListaRubrosContables 
      Height          =   1005
      Left            =   0
      TabIndex        =   69
      Top             =   5445
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   1773
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmRecibos.frx":13EB
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCodigoIvaOpcional"
      Height          =   315
      Index           =   8
      Left            =   6930
      TabIndex        =   77
      Tag             =   "DescripcionIva"
      Top             =   3780
      Visible         =   0   'False
      Width           =   2490
      _ExtentX        =   4392
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCodigoIva"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1005
      Left            =   3195
      TabIndex        =   24
      Top             =   5445
      Width           =   8520
      _ExtentX        =   15028
      _ExtentY        =   1773
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmRecibos.frx":1407
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   4950
      Top             =   5175
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRecibos.frx":1489
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRecibos.frx":159B
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRecibos.frx":19ED
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRecibos.frx":1E3F
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView ListaAnticipos 
      Height          =   555
      Left            =   2025
      TabIndex        =   87
      Top             =   5040
      Visible         =   0   'False
      Width           =   645
      _ExtentX        =   1138
      _ExtentY        =   979
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmRecibos.frx":2291
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProvinciaDestino"
      Height          =   315
      Index           =   5
      Left            =   10080
      TabIndex        =   88
      Tag             =   "Provincias"
      Top             =   6480
      Width           =   1680
      _ExtentX        =   2963
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProvincia"
      Text            =   ""
   End
   Begin VB.Label Label3 
      Caption         =   "Prov.dest.:"
      Height          =   240
      Left            =   9225
      TabIndex        =   89
      Top             =   6525
      Width           =   795
   End
   Begin VB.Label lblCuit 
      Caption         =   "Cuit :"
      Height          =   255
      Left            =   8865
      TabIndex        =   82
      Top             =   5445
      Visible         =   0   'False
      Width           =   465
   End
   Begin VB.Label Label2 
      Caption         =   "Cob.:"
      Height          =   240
      Left            =   9900
      TabIndex        =   74
      Top             =   6165
      Visible         =   0   'False
      Width           =   435
   End
   Begin VB.Label Label1 
      Caption         =   "Vend.:"
      Height          =   240
      Left            =   9900
      TabIndex        =   71
      Top             =   5805
      Visible         =   0   'False
      Width           =   435
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Observaciones :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   15
      Left            =   3240
      TabIndex        =   50
      Top             =   5265
      Width           =   1395
   End
   Begin VB.Label lblComprobanteProveedor 
      Caption         =   "Nro. comprob.prov. p/reintegro :"
      Height          =   195
      Left            =   5895
      TabIndex        =   84
      Top             =   1395
      Visible         =   0   'False
      Width           =   2325
   End
   Begin VB.Label lblTipoOperacion 
      Caption         =   "Tipo ope. :"
      Height          =   240
      Left            =   135
      TabIndex        =   80
      Top             =   3420
      Visible         =   0   'False
      Width           =   795
   End
   Begin VB.Label lblCondicionIva 
      Caption         =   "Cond.IVA (opcional) :"
      Height          =   285
      Left            =   5310
      TabIndex        =   78
      Top             =   3825
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Label lblBusca 
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
      Left            =   8100
      TabIndex        =   76
      Top             =   1575
      Visible         =   0   'False
      Width           =   825
   End
   Begin VB.Label lblLabels 
      Caption         =   "rubros contables:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   25
      Left            =   45
      TabIndex        =   70
      Top             =   5220
      Width           =   1545
   End
   Begin VB.Label lblDestino 
      Caption         =   "Cliente:"
      Height          =   285
      Left            =   4095
      TabIndex        =   34
      Top             =   135
      Width           =   720
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero :"
      Height          =   285
      Index           =   21
      Left            =   45
      TabIndex        =   66
      Top             =   135
      Width           =   645
   End
   Begin VB.Label lblEstado 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   6570
      TabIndex        =   65
      Top             =   6525
      Visible         =   0   'False
      Width           =   2085
   End
   Begin VB.Label lblRet 
      Caption         =   "Nro. certific. ret. ing. brutos :"
      Height          =   195
      Index           =   4
      Left            =   7200
      TabIndex        =   64
      Top             =   900
      Visible         =   0   'False
      Width           =   2325
   End
   Begin VB.Label lblDifCam 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Dif. cambio calculada :"
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
      Left            =   2340
      TabIndex        =   61
      Top             =   3690
      Width           =   2505
   End
   Begin VB.Line Line3 
      BorderWidth     =   2
      Index           =   1
      X1              =   11880
      X2              =   10890
      Y1              =   1395
      Y2              =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Conv. a $ :"
      Height          =   240
      Index           =   2
      Left            =   10980
      TabIndex        =   59
      Top             =   855
      Width           =   855
   End
   Begin VB.Label lblRet 
      Caption         =   "Nro. certific. ret. ganancias :"
      Height          =   195
      Index           =   1
      Left            =   2655
      TabIndex        =   57
      Top             =   1215
      Width           =   2145
   End
   Begin VB.Label lblRet 
      Caption         =   "Nro. certificado SUSS :"
      Height          =   195
      Index           =   3
      Left            =   7200
      TabIndex        =   56
      Top             =   1170
      Visible         =   0   'False
      Width           =   2325
   End
   Begin VB.Label lblRet 
      Caption         =   "Nro. certificado retencion IVA :"
      Height          =   195
      Index           =   2
      Left            =   2655
      TabIndex        =   55
      Top             =   1485
      Width           =   2145
   End
   Begin VB.Label lblRet 
      Caption         =   "Tipo de retencion ganancias :"
      Height          =   240
      Index           =   0
      Left            =   2655
      TabIndex        =   54
      Top             =   900
      Width           =   2160
   End
   Begin VB.Label lblObra 
      Caption         =   "Obra/Gr."
      Height          =   285
      Left            =   4095
      TabIndex        =   53
      Top             =   495
      Visible         =   0   'False
      Width           =   720
   End
   Begin VB.Line Line4 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      Index           =   1
      X1              =   8595
      X2              =   11655
      Y1              =   3735
      Y2              =   3735
   End
   Begin VB.Label lblLabels 
      Caption         =   "Moneda :"
      Height          =   285
      Index           =   17
      Left            =   45
      TabIndex        =   51
      Top             =   810
      Width           =   780
   End
   Begin VB.Line Line2 
      BorderWidth     =   2
      X1              =   10890
      X2              =   10890
      Y1              =   -45
      Y2              =   1395
   End
   Begin VB.Label lblLabels 
      Alignment       =   2  'Center
      Caption         =   "Cotizacion u$s a tomar"
      Height          =   420
      Index           =   14
      Left            =   10935
      TabIndex        =   49
      Top             =   0
      Width           =   915
   End
   Begin VB.Line Line3 
      BorderWidth     =   2
      Index           =   0
      X1              =   11880
      X2              =   10890
      Y1              =   810
      Y2              =   810
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Diferencia :"
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
      Index           =   12
      Left            =   8685
      TabIndex        =   29
      Top             =   5175
      Width           =   1740
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000009&
      BorderWidth     =   2
      X1              =   8685
      X2              =   11700
      Y1              =   5085
      Y2              =   5085
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Otros conceptos"
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
      Index           =   10
      Left            =   8685
      TabIndex        =   30
      Top             =   4770
      Width           =   1740
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Retenc. ganancias :"
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
      Index           =   8
      Left            =   8685
      TabIndex        =   48
      Top             =   4455
      Width           =   1740
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Retencion IVA :"
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
      Index           =   7
      Left            =   8685
      TabIndex        =   47
      Top             =   4140
      Width           =   1740
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Efectivo :"
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
      Index           =   13
      Left            =   8685
      TabIndex        =   46
      Top             =   3825
      Visible         =   0   'False
      Width           =   1740
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Total imputaciones :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   6
      Left            =   2340
      TabIndex        =   42
      Top             =   3375
      Width           =   2520
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      Caption         =   "Totales :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   5
      Left            =   8550
      TabIndex        =   41
      Top             =   3375
      Width           =   930
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      Caption         =   "Total valores :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   4
      Left            =   5400
      TabIndex        =   40
      Top             =   5130
      Width           =   1515
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Registro contable :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   3
      Left            =   6390
      TabIndex        =   38
      Top             =   1530
      Width           =   1635
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Detalle de imputaciones :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   1
      Left            =   45
      TabIndex        =   37
      Top             =   1530
      Width           =   2175
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Valores :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   0
      Left            =   45
      TabIndex        =   36
      Top             =   3780
      Width           =   765
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   22
      Left            =   45
      TabIndex        =   35
      Top             =   495
      Width           =   1215
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar imputacion"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Modificar imputacion"
         Index           =   1
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar imputacion"
         Index           =   2
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Modificar importe"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Aplicacion automatica"
         Index           =   4
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar pago anticipado"
         Index           =   5
      End
   End
   Begin VB.Menu MnuDetVal 
      Caption         =   "DetalleVal"
      Visible         =   0   'False
      Begin VB.Menu MnuDetB 
         Caption         =   "Agregar caja"
         Index           =   0
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Agregar valor"
         Index           =   1
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Modificar"
         Index           =   2
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Eliminar"
         Index           =   3
      End
   End
   Begin VB.Menu MnuDetCta 
      Caption         =   "DetalleCta"
      Visible         =   0   'False
      Begin VB.Menu MnuDetC 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetC 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetC 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
   Begin VB.Menu MnuDetRubroContable 
      Caption         =   "DetalleRubroContable"
      Visible         =   0   'False
      Begin VB.Menu MnuDetE 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetE 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetE 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
   Begin VB.Menu MnuDetAnticipo 
      Caption         =   "DetalleAnticipo"
      Visible         =   0   'False
      Begin VB.Menu MnuDetD 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetD 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetD 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
End
Attribute VB_Name = "frmRecibos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Recibo
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mvarIdCliente As Long, mvarIdMonedaPesos As Long, mvarIdMonedaDolar As Long
Private mvarTotalImputaciones As Double, mvarTotalDebe As Double, mvarTotalHaber As Double, mvarCotizacion As Double
Private mvarTotalValores As Double, mvarTotalRubrosContables As Double, mvarTotalOtrosConceptos As Double
Private mvarTotalAnticipos As Double
Private mvarPuntoVenta As Integer
Private mvarAnulada As String, mvarControlarRubrosContablesEnOP As String, mvarActivarReintegros As String
Private mvarGrabado As Boolean
Dim actL2 As ControlForm
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

Sub Editar(ByVal Cual As Long)

'   If mvarId > 0 Then
'      MsgBox "No puede modificar un recibo ya registrado!", vbCritical
'      Exit Sub
'   End If
   
   If Len(Trim(dcfields(0).BoundText)) = 0 Then
      MsgBox "Falta completar el campo cliente", vbCritical
      Exit Sub
   End If
   
   If Len(Trim(txtNumeroRecibo.Text)) = 0 Then
      MsgBox "Falta completar el campo numero de recibo", vbCritical
      Exit Sub
   End If
   
   Dim oF As frmImputaciones
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim Esta As Boolean
   Dim Saldos As String
   Dim vSaldos
   
   DoEvents
   
   Set oF = New frmImputaciones
   
   With oF
      .TipoCuenta = "Deudores"
      If origen.Registro.Fields("IdMoneda").Value = mvarIdMonedaDolar Then
         .Moneda = "Dolares"
      Else
         .Moneda = "Pesos"
      End If
      .Id = dcfields(0).BoundText
      .Show vbModal, Me
   End With
   
   For Each oL In oF.Lista.ListItems
      If oL.ListSubItems(7) = "*" Then
         Set oRs = origen.DetRecibos.TodosLosRegistros
         Esta = False
         If oRs.Fields.Count > 0 Then
            If oRs.RecordCount > 0 Then
               oRs.MoveFirst
               Do While Not oRs.EOF
                  If oRs.Fields("IdImputacion").Value = oL.Tag Then
                     Esta = True
                     Exit Do
                  End If
                  oRs.MoveNext
               Loop
               oRs.Close
               Set oRs = Nothing
            End If
         End If
         If Not Esta Then
            With origen.DetRecibos.Item(-1)
               .Registro.Fields("IdImputacion").Value = oL.Tag
               .Registro.Fields("Importe").Value = oL.ListSubItems(5)
               Saldos = RecalcularSaldosImputacion(oL.Tag, oL.ListSubItems(5))
               If Len(Saldos) > 0 Then
                  vSaldos = VBA.Split(Saldos, "|")
                  .Registro.Fields("SaldoParteEnDolaresAnterior").Value = vSaldos(0)
                  .Registro.Fields("PagadoParteEnDolares").Value = vSaldos(1)
                  .Registro.Fields("NuevoSaldoParteEnDolares").Value = vSaldos(2)
                  .Registro.Fields("SaldoParteEnPesosAnterior").Value = vSaldos(3)
                  .Registro.Fields("PagadoParteEnPesos").Value = vSaldos(4)
                  .Registro.Fields("NuevoSaldoParteEnPesos").Value = vSaldos(5)
               End If
               .Modificado = True
            End With
         End If
      End If
   Next
   
   Set oRs = origen.DetRecibos.RegistrosConFormato
   Set Lista.DataSource = oRs
   
   oRs.Close
   Set oRs = Nothing
   
   Unload oF
   
   Set oF = Nothing
   
   CalculaTotales
   MostrarDiferenciaCambio
   
End Sub

Sub ImputacionAutomatica()

'   If mvarId > 0 Then
'      MsgBox "No puede modificar un recibo ya registrado!", vbCritical
'      Exit Sub
'   End If
   
   If Len(Trim(dcfields(0).BoundText)) = 0 Then
      MsgBox "Falta completar el campo cliente", vbCritical
      Exit Sub
   End If
   
   If Len(Trim(txtNumeroRecibo.Text)) = 0 Then
      MsgBox "Falta completar el campo numero de recibo", vbCritical
      Exit Sub
   End If
   
   Dim oRs As ADOR.Recordset, oRs1 As ADOR.Recordset
   Dim mvarDif As Double
   Dim oL As ListItem
   Dim Esta As Boolean
   Dim Saldos As String
   Dim vSaldos
   
   DoEvents
   
   mvarDif = Val(txtDif.Text) * -1
   
   Set oRs = Aplicacion.CtasCtesD.TraerFiltrado("_ACancelar", dcfields(0).BoundText)
   Set oRs1 = origen.DetRecibos.TodosLosRegistros
   
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF And mvarDif > 0
            Esta = False
            If oRs1.Fields.Count > 0 Then
               If oRs1.RecordCount > 0 Then
                  oRs1.MoveFirst
                  Do While Not oRs1.EOF
                     If oRs.Fields(0).Value = oRs1.Fields("IdImputacion").Value Then
                        Esta = True
                        Exit Do
                     End If
                     oRs1.MoveNext
                  Loop
               End If
            End If
            If Not Esta Then
               With origen.DetRecibos.Item(-1)
                  .Registro.Fields("IdImputacion").Value = oRs.Fields(0).Value
                  If mvarDif >= oRs.Fields("Saldo").Value Then
                     mvarDif = mvarDif - oRs.Fields("Saldo").Value
                     .Registro.Fields("Importe").Value = oRs.Fields("Saldo").Value
                  Else
                     .Registro.Fields("Importe").Value = mvarDif
                     mvarDif = 0
                  End If
                  Saldos = RecalcularSaldosImputacion(oRs.Fields(0).Value, .Registro.Fields("Importe").Value)
                  If Len(Saldos) > 0 Then
                     vSaldos = VBA.Split(Saldos, "|")
                     .Registro.Fields("SaldoParteEnDolaresAnterior").Value = vSaldos(0)
                     .Registro.Fields("PagadoParteEnDolares").Value = vSaldos(1)
                     .Registro.Fields("NuevoSaldoParteEnDolares").Value = vSaldos(2)
                     .Registro.Fields("SaldoParteEnPesosAnterior").Value = vSaldos(3)
                     .Registro.Fields("PagadoParteEnPesos").Value = vSaldos(4)
                     .Registro.Fields("NuevoSaldoParteEnPesos").Value = vSaldos(5)
                  End If
                  .Modificado = True
               End With
            End If
            oRs.MoveNext
         Loop
      End If
      oRs.Close
   End If
            
   If oRs1.Fields.Count > 0 Then
      oRs1.Close
   End If
   
   Set oRs = Nothing
   Set oRs1 = Nothing
   
   If mvarDif > 0 Then
      With origen.DetRecibos.Item(-1)
         .Registro.Fields("IdImputacion").Value = -1
         .Registro.Fields("Importe").Value = mvarDif
         mvarDif = 0
         .Modificado = True
      End With
   End If

   Set oRs = origen.DetRecibos.RegistrosConFormato
   Set Lista.DataSource = oRs
   
   oRs.Close
   Set oRs = Nothing
   
   CalculaTotales
   MostrarDiferenciaCambio

End Sub

Sub PagoAnticipado()

'   If mvarId > 0 Then
'      MsgBox "No puede modificar un recibo ya registrado!", vbCritical
'      Exit Sub
'   End If
   
   If Len(Trim(dcfields(0).BoundText)) = 0 Then
      MsgBox "Falta completar el campo cliente", vbCritical
      Exit Sub
   End If
   
   If Len(Trim(txtNumeroRecibo.Text)) = 0 Then
      MsgBox "Falta completar el campo numero de recibo", vbCritical
      Exit Sub
   End If
   
   DoEvents
   
   Dim oRs As ADOR.Recordset
   Dim mvarDif As Double
   
   mvarDif = Val(txtDif.Text) * -1

   If mvarDif > 0 Then
      With origen.DetRecibos.Item(-1)
         .Registro.Fields("IdImputacion").Value = -1
         .Registro.Fields("Importe").Value = mvarDif
         mvarDif = 0
         .Modificado = True
      End With
   End If

   Set oRs = origen.DetRecibos.RegistrosConFormato
   Set Lista.DataSource = oRs
   
   oRs.Close
   Set oRs = Nothing
   
   CalculaTotales

End Sub

Sub EditarImporte(ByVal Cual As Long)

'   If mvarId > 0 Then
'      MsgBox "No puede modificar un recibo ya registrado!", vbCritical
'      Exit Sub
'   End If
   
   Dim oF As frmDetRecibos
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim Saldos As String
   Dim vSaldos
   
   DoEvents
   
   Set oF = New frmDetRecibos
   
   With oF
'      .ACancelar = Origen.DetRecibos.Item(Cual).Registro.Fields("Importe").Value
      .ACancelar = Lista.SelectedItem.ListSubItems(5)
      .Saldo = Lista.SelectedItem.ListSubItems(4)
      .Show vbModal, Me
   End With
   
   With origen.DetRecibos.Item(Cual)
      .Modificado = True
      With .Registro
         .Fields("Importe").Value = Val(oF.txtACancelar.Text)
         Saldos = RecalcularSaldosImputacion(.Fields("IdImputacion").Value, .Fields("Importe").Value)
         If Len(Saldos) > 0 Then
            vSaldos = VBA.Split(Saldos, "|")
            .Fields("SaldoParteEnDolaresAnterior").Value = vSaldos(0)
            .Fields("PagadoParteEnDolares").Value = vSaldos(1)
            .Fields("NuevoSaldoParteEnDolares").Value = vSaldos(2)
            .Fields("SaldoParteEnPesosAnterior").Value = vSaldos(3)
            .Fields("PagadoParteEnPesos").Value = vSaldos(4)
            .Fields("NuevoSaldoParteEnPesos").Value = vSaldos(5)
'            Lista.SelectedItem.ListSubItems(6) = vSaldos(0)
'            Lista.SelectedItem.ListSubItems(7) = vSaldos(1)
'            Lista.SelectedItem.ListSubItems(8) = vSaldos(2)
'            Lista.SelectedItem.ListSubItems(9) = vSaldos(3)
'            Lista.SelectedItem.ListSubItems(10) = vSaldos(4)
'            Lista.SelectedItem.ListSubItems(11) = vSaldos(5)
         End If
      End With
   End With
   Lista.SelectedItem.ListSubItems(5) = Format(Val(oF.txtACancelar.Text), "$ #,##0.00")
   
   Unload oF
   
   Set oF = Nothing
   
   CalculaTotales
   MostrarDiferenciaCambio

End Sub

Sub EditarVal(ByVal Cual As Long)

'   If mvarId > 0 Then
'      MsgBox "No puede modificar un recibo ya registrado!", vbCritical
'      Exit Sub
'   End If
   
   Dim oF As Form
   Dim oL As ListItem
   Dim oDet As DetReciboValores
   Dim mItem As String
   Dim mIdItem As Long
   
   mIdItem = Cual
   
   If Cual = -1 Then
      mItem = "Caja"
   ElseIf Cual = -2 Then
      mItem = "Valor"
      mIdItem = -1
   Else
      Set oDet = origen.DetRecibosValores.Item(Cual)
      If Not IsNull(oDet.Registro.Fields("IdCaja").Value) Then
         mItem = "Caja"
      Else
         If mvarId > 0 Then
            If Not ValorModificable(0, Cual) Then
               MsgBox "El valor ha sido depositado y no puede ser editado.", vbExclamation
               Exit Sub
            End If
         End If
         mItem = "Valor"
      End If
      Set oDet = Nothing
   End If
   
   If mItem = "Valor" Then
      Set oF = New frmDetRecibosValores
   Else
      Set oF = New frmDetRecibosCaja
   End If
   
   DoEvents
   
   With oF
      Set .Recibo = origen
      .Id = mIdItem
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Or Cual = -2 Then
            Set oL = ListaVal.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaVal.SelectedItem
         End If
         With oL
            If Cual = -1 Or Cual = -2 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            If mItem = "Valor" Then
               .Text = oF.DataCombo1(0).Text
               .SubItems(1) = "" & oF.txtNumeroInterno
               .SubItems(2) = "" & oF.txtNumeroValor
               If oF.DTFields(0).Enabled Then
                  .SubItems(3) = "" & oF.DTFields(0).Value
               Else
                  .SubItems(3) = ""
               End If
               .SubItems(4) = "" & oF.DataCombo1(1).Text
            Else
               .Text = "Caja"
               .SubItems(4) = "" & oF.DataCombo1(1).Text
            End If
            If Val(oF.txtImporte.Text) = 0 Then
               .SubItems(5) = " "
            Else
               .SubItems(5) = "" & Format(oF.txtImporte.Text, "Fixed")
            End If
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
   CalculaTotales
   MostrarDiferenciaCambio
'   ActualizaListaContable
   
   If mvarId > 0 And Check3.Value = 1 Then
      DoEvents
      MsgBox "Recuerde que si modifica el importe de los valores debe" & vbCrLf & _
            "controlar el asiento que esta marcado como manual y no" & vbCrLf & _
            "se recalcula automaticamente.", vbInformation
   End If
   
End Sub

Sub EditarCta(ByVal Cual As Long)

'   If mvarId > 0 Then
'      MsgBox "No puede modificar un recibo ya registrado!", vbCritical
'      Exit Sub
'   End If
   
   Dim oF As frmDetRecibosCuentas
   Dim oL As ListItem
   
   Set oF = New frmDetRecibosCuentas
   
   With oF
      Set .Recibo = origen
      .IdMoneda = dcfields(3).BoundText
      .FechaComprobante = DTFields(0).Value
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaCta.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaCta.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtCodigoCuenta
            .SubItems(1) = "" & oF.DataCombo1(0).Text
            If Val(oF.txtDebe.Text) = 0 Then
               .SubItems(2) = " "
            Else
               .SubItems(2) = "" & Format(oF.txtDebe.Text, "Fixed")
            End If
            If Val(oF.txtHaber.Text) = 0 Then
               .SubItems(3) = " "
            Else
               .SubItems(3) = "" & Format(oF.txtHaber.Text, "Fixed")
            End If
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
   CalculaTotales
'   ActualizaListaContable
   
   If mvarId > 0 And Check3.Value = 1 Then
      DoEvents
      MsgBox "Recuerde que si modifica el importe de los pases contables" & vbCrLf & _
            "debe controlar la consistencia de los datos (valores y asiento)" & vbCrLf & _
            "manualmente debido a que el asiento esta marcado como manual" & vbCrLf & _
            "y no se recalcula automaticamente.", vbInformation
   End If
   
End Sub

Public Sub EditarRubroContable(ByVal Cual As Long)

   Dim oF As frmDetRecibosRubrosContables
   Dim oL As ListItem
   
   Set oF = New frmDetRecibosRubrosContables
   
   With oF
      Set .Recibo = origen
      If IsNumeric(dcfields1(0).BoundText) Then .IdObra = dcfields1(0).BoundText
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaRubrosContables.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaRubrosContables.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.DataCombo1(1).Text
            .SubItems(1) = "" & Format(oF.txtImporte.Text, "Fixed")
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
   CalculaTotales
   
End Sub

Public Sub EditarAnticipo(ByVal Cual As Long)

   Dim oF As frmDetRecibosAnticipo
   Dim oL As ListItem
   
   Set oF = New frmDetRecibosAnticipo
   
   With oF
      Set .Recibo = origen
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaAnticipos.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaAnticipos.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtLegajo.Text
            .SubItems(1) = "" & oF.DataCombo1(1).Text
            .SubItems(2) = "" & Format(oF.txtImporte.Text, "Fixed")
            .SubItems(3) = "" & Format(oF.txtCuotas.Text, "Fixed")
            .SubItems(4) = "" & oF.txtDetalle.Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
   CalculaTotales

End Sub

Private Sub Check1_Click()

   MostrarDiferenciaCambio

End Sub

Private Sub Check2_Click()

   If Check2.Value = 1 Then
      Lista.Visible = False
      With ListaAnticipos
         .Top = Lista.Top
         .Left = Lista.Left
         .Width = Lista.Width
         .Height = Lista.Height
         .Visible = True
      End With
      Check2.Enabled = False
   Else
      ListaAnticipos.Visible = False
      Lista.Visible = True
   End If

End Sub

Private Sub Check3_Click()

   With origen.Registro
      If Check3.Value = 1 Then
         .Fields("AsientoManual").Value = "SI"
      Else
         .Fields("AsientoManual").Value = "NO"
      End If
   End With

End Sub

Private Sub Check4_Click()

   If Check4.Value = 0 Then
      Dim mIdCuenta As Long
      origen.Registro.Fields(dcfields1(1).DataField).Value = Null
      mIdCuenta = 0
      With dcfields(0)
         If IsNumeric(.BoundText) Then mIdCuenta = .BoundText
         Set .RowSource = Aplicacion.Cuentas.TraerLista
         origen.Registro.Fields(.DataField).Value = mIdCuenta
         .Enabled = True
      End With
      With dcfields1(2)
         .BoundText = 0
         .Enabled = True
      End With
   End If
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Dim oRs As ADOR.Recordset
         Dim mNumeroReciboPagoAutomatico As String
         
         Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
         mNumeroReciboPagoAutomatico = ""
         If oRs.RecordCount > 0 Then
            mNumeroReciboPagoAutomatico = IIf(IsNull(oRs.Fields("NumeroReciboPagoAutomatico").Value), "", oRs.Fields("NumeroReciboPagoAutomatico").Value)
         End If
         oRs.Close
         
         ActualizaListaContable
         
         If DTFields(0).Value <= gblFechaUltimoCierre And _
               Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
            MsgBox "La fecha no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation
            Exit Sub
         End If

         If Not IsNumeric(txtNumeroRecibo.Text) Or Len(txtNumeroRecibo.Text) = 0 Then
            MsgBox "No ingreso el numero de recibo", vbCritical
            Exit Sub
         End If
         
         If Not IsNumeric(dcfields(10).BoundText) Or Len(dcfields(10).Text) = 0 Then
            MsgBox "No ha ingresado el punto de venta", vbCritical
            Exit Sub
         End If
         
         If Val(txtDif.Text) <> 0 And Not Option2.Value Then
            MsgBox "El recibo no cierra, ajuste los valores e intente nuevamente", vbCritical
            Exit Sub
         End If
         
         If Val(Replace(txtTotal(1).Text, ",", "")) <> Val(Replace(txtTotal(2).Text, ",", "")) Then
            MsgBox "No balancea el registro contable", vbInformation
            Exit Sub
         End If
            
         If Lista.ListItems.Count = 0 And Not Option2.Value Then
            MsgBox "No se puede almacenar un Recibo sin detalles"
            Exit Sub
         End If
         
         If Len(txtCotizacionMoneda.Text) = 0 Then
            MsgBox "No ingreso el valor de conversion a pesos", vbInformation
            Exit Sub
         End If
         
         If Val(txtCotizacionMoneda.Text) <= 0 Then
            MsgBox "La cotizacion debe ser mayor a cero", vbInformation
            Exit Sub
         End If
         
         If mvarCotizacion = 0 Then
            MsgBox "No hay cotizacion dolar al " & DTFields(0).Value, vbInformation
            Exit Sub
         End If
         
         If txtNumeroCertificadoRetencionGanancias.Visible Then
            If Len(txtNumeroCertificadoRetencionGanancias.Text) > 0 And Not IsNumeric(dcfields1(3).BoundText) Then
               MsgBox "Debe indicar el tipo de retencion ganancias"
               Exit Sub
            End If
         End If
         
         If Option2.Value And Len(Combo1(0).Text) = 0 Then
            MsgBox "Debe indicar el tipo de operacion", vbInformation
            Exit Sub
         End If
         
         If mvarId > 0 Then
            If ExistenAnticiposAplicados() Then
               MsgBox "Hay anticipos que en cuenta corriente tienen aplicado el saldo" & vbCrLf & _
                     "No puede modificar este recibo", vbInformation
               Exit Sub
            End If
         End If
         
         If mvarControlarRubrosContablesEnOP = "SI" Then
            If mvarTotalValores <> mvarTotalRubrosContables And _
                  (Not Combo1(0).Visible Or (Combo1(0).Visible And Combo1(0).ListIndex = 1)) Then
               MsgBox "El total de rubros contables asignados debe ser igual al total de valores", vbExclamation
               Exit Sub
            End If
         End If
         
         If Option1.Value Then
            If EstadoEntidad("Clientes", origen.Registro.Fields("IdCliente").Value) = "INACTIVO" Then
               MsgBox "Cliente inhabilitado", vbExclamation
               Exit Sub
            End If
         End If
            
         If ListaCta.ListItems.Count = 0 Then
            MsgBox "No hay registro contable, revise la definicion de cuentas utilizadas en este recibo.", vbExclamation
            Exit Sub
         End If
         
         If Not (mvarId <= 0 And mNumeroReciboPagoAutomatico = "SI") Then
            Set oRs = Aplicacion.Recibos.TraerFiltrado("Cod", Array(dcfields(10).Text, Val(txtNumeroRecibo.Text)))
            If oRs.RecordCount > 0 Then
               If oRs.Fields("IdRecibo").Value <> mvarId Then
                  MsgBox "Numero de recibo existente ( " & oRs.Fields("FechaRecibo").Value & " )", vbCritical
                  oRs.Close
                  Set oRs = Nothing
                  Exit Sub
               End If
            End If
            oRs.Close
         End If
         
         If Not ControlImputacionCliente Then
            MsgBox "Hay imputaciones que corresponden a otro cliente, eliminelas", vbExclamation
            Exit Sub
         End If
         
         Set oRs = origen.DetRecibosCuentas.TodosLosRegistros
         If oRs.Fields.Count > 0 Then
            If oRs.RecordCount > 0 Then
               oRs.MoveFirst
               Do While Not oRs.EOF
                  If Not oRs.Fields("Eliminado").Value Then
                     If IIf(IsNull(oRs.Fields("IdCuenta").Value), 0, oRs.Fields("IdCuenta").Value) = 0 Then
                        Set oRs = Nothing
                        MsgBox "Hay cuentas contables no definidas, no puede registrar el recibo", vbExclamation
                        Exit Sub
                     End If
                  End If
                  oRs.MoveNext
               Loop
            End If
         End If
         Set oRs = Nothing
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim i As Integer
         Dim mAux1 As String
         
         If mvarId > 0 Then
            Set oRs = Aplicacion.Recibos.TraerFiltrado("_ValoresEnConciliacionesPorIdRecibo", mvarId)
            If oRs.RecordCount > 0 Then
               mAux1 = ""
               oRs.MoveFirst
               Do While Not oRs.EOF
                  mAux1 = mAux1 & IIf(IsNull(oRs.Fields("Numero").Value), 0, oRs.Fields("Numero").Value) & " "
                  oRs.MoveNext
               Loop
               MsgBox "Cuidado, hay valores en este recibo que estan en" & vbCrLf & _
                     "la(s) conciliacion(es) : " & mAux1 & vbCrLf & _
                     "tome las precauciones del caso." & vbCrLf & _
                     "El mensaje es solo informativo.", vbExclamation
            End If
            oRs.Close
         End If
         
         Set oRs = Nothing
         
         With origen.Registro
            .Fields("NumeroRecibo").Value = Val(txtNumeroRecibo.Text)
            .Fields("PuntoVenta").Value = IIf(Len(dcfields(10).Text) > 0, Val(dcfields(10).Text), 1)
            .Fields("Cotizacion").Value = mvarCotizacion
            If IsNull(.Fields("Efectivo").Value) Then
               .Fields("Efectivo").Value = 0
            End If
            If IsNull(.Fields("Valores").Value) Then
               .Fields("Valores").Value = 0
            End If
            If IsNull(.Fields("Documentos").Value) Then
               .Fields("Documentos").Value = 0
            End If
            If IsNull(.Fields("RetencionGanancias").Value) Then
               .Fields("RetencionGanancias").Value = 0
            End If
            If IsNull(.Fields("RetencionIBrutos").Value) Then
               .Fields("RetencionIBrutos").Value = 0
            End If
            If IsNull(.Fields("RetencionIVA").Value) Then
               .Fields("RetencionIVA").Value = 0
            End If
            If IsNull(.Fields("GastosGenerales").Value) Then
               .Fields("GastosGenerales").Value = 0
            End If
            
            If Check1.Value = 1 Then
               .Fields("Dolarizada").Value = "SI"
            Else
               .Fields("Dolarizada").Value = "NO"
            End If
            
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
         
            For Each dc In dcfields
               If Len(Trim(dc.BoundText)) = 0 And dc.Index <> 3 And _
                     dc.Index <> 4 And dc.Index <> 5 And dc.Index <> 8 And dc.Index <> 10 And _
                     dc.Visible Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
               If IsNumeric(dc.BoundText) Then .Fields(dc.DataField).Value = dc.BoundText
            Next
         
            If Option1.Value Then
               .Fields("Tipo").Value = "CC"
            Else
               .Fields("Tipo").Value = "OT"
            End If
         
            If Check3.Value = 1 Then
               .Fields("AsientoManual").Value = "SI"
            Else
               .Fields("AsientoManual").Value = "NO"
            End If
         
            .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text
         
            If mvarId < 0 Then
               .Fields("IdUsuarioIngreso").Value = glbIdUsuario
               .Fields("FechaIngreso").Value = Now
            Else
               .Fields("IdUsuarioModifico").Value = glbIdUsuario
               .Fields("FechaModifico").Value = Now
            End If
            
            .Fields("Observaciones").Value = rchObservaciones.Text
         
            If Option2.Value Then
               .Fields("TipoOperacionOtros").Value = Combo1(0).ListIndex
            Else
               .Fields("TipoOperacionOtros").Value = Null
            End If
         
            .Fields("CuitOpcional").Value = Null
            If CUIT1.Visible Then .Fields("CuitOpcional").Value = CUIT1.Text
         End With
         
         If mvarId < 0 Then
            Dim mvarNumero As Long
            Dim oPar As ComPronto.Parametro
            
            mvarNumero = origen.Registro.Fields("NumeroRecibo").Value
            
            Set oPar = Aplicacion.Parametros.Item(1)
            With oPar.Registro
               If IsNull(.Fields("NumeroReciboPagoAutomatico").Value) Or .Fields("NumeroReciboPagoAutomatico").Value = "SI" Then
'                  Dim oPto As ComPronto.PuntoVenta
'                  Set oPto = Aplicacion.PuntosVenta.Item(dcfields(10).BoundText)
'                  For i = 1 To 1000
'                     Set oRs = Aplicacion.Recibos.TraerFiltrado("_PorIdPuntoVenta_Numero", Array(dcfields(10).BoundText, mvarNumero))
'                     If oRs.RecordCount > 0 Then
'                        oRs.Close
'                        If i = 1 Then MsgBox "El numero de recibo ya fue utilizado," & vbCrLf & _
'                                             "el sistema buscara el siguiente numero disponible", vbExclamation, "Numero de recibo"
'                        mvarNumero = mvarNumero + 1
'                     Else
'                        oRs.Close
'                        If i > 1 Or origen.Registro.Fields("NumeroRecibo").Value = mvarNumero Then
'                           oPto.Registro.Fields("ProximoNumero").Value = mvarNumero + 1
'                           oPto.Guardar
'                        End If
'                        Exit For
'                     End If
'                  Next
'                  Set oRs = Nothing
'                  Set oPto = Nothing
'                  origen.Registro.Fields("NumeroRecibo").Value = mvarNumero
'                  If i > 1 Then MsgBox "El numero asignado a este recibo es el " & origen.Registro.Fields("NumeroRecibo").Value, vbInformation
               Else
                  Set oPar = Nothing
                  Set oRs = Aplicacion.Recibos.TraerFiltrado("_PorIdPuntoVenta_Numero", Array(dcfields(10).BoundText, mvarNumero))
                  If oRs.RecordCount > 0 Then
                     oRs.Close
                     MsgBox "El recibo ya existe, verifique el numero"
                     Exit Sub
                  End If
                  oRs.Close
               End If
            End With
            Set oPar = Nothing
         End If
         
         Select Case origen.Guardar
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El registro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
            mvarGrabado = True
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "RecibosTodos, RecibosAgrupados, +SubRE2"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
         Dim mvarImprime As Integer
         mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de Recibo")
         If mvarImprime = vbYes Then
            Me.Refresh
            cmdImpre_Click 0
         End If
         
         Unload Me
      
      Case 1
         Unload Me
      
      Case 2
         OtrosConceptosContables
   
      Case 3
         ActualizaListaContable
   
      Case 5
         AnularRecibo
      
      Case 8
         AgregarDiferenciaCambio
   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim dtf As DTPicker
   Dim dc As DataCombo
   Dim oRs As ADOR.Recordset
   Dim oDet As ComPronto.DetRecibo
   Dim oDetVal As ComPronto.DetReciboValores
   Dim oDetCta As ComPronto.DetReciboCuentas
   Dim oDetRubCon As ComPronto.DetReciboRubrosContables
   Dim oDetAnt As ComPronto.DetReciboAnticiposAlPersonal
   Dim ListaVacia1 As Boolean, ListaVacia2 As Boolean, ListaVacia3 As Boolean
   Dim ListaVacia4 As Boolean, ListaVacia5 As Boolean
   Dim mNumeroRecibo As Long
   Dim mNumeroReciboPagoAutomatico As String
   
   mvarId = vnewvalue
   ListaVacia1 = False
   ListaVacia2 = False
   ListaVacia3 = False
   ListaVacia4 = False
   ListaVacia5 = False
   mvarAnulada = "NO"
   
   Set oAp = Aplicacion
   Set origen = oAp.Recibos.Item(vnewvalue)
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      mvarIdMonedaPesos = .Fields("IdMoneda").Value
      mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
      mNumeroRecibo = .Fields("ProximoNumeroReciboPago").Value
      mNumeroReciboPagoAutomatico = IIf(IsNull(.Fields("NumeroReciboPagoAutomatico").Value), "NO", .Fields("NumeroReciboPagoAutomatico").Value)
      mvarControlarRubrosContablesEnOP = IIf(IsNull(.Fields("ControlarRubrosContablesEnOP").Value), "SI", .Fields("ControlarRubrosContablesEnOP").Value)
      gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)
   End With
   oRs.Close
   
   If BuscarClaveINI("Mostrar vendedor/cobrador en recibo") = "SI" Then
      rchObservaciones.Width = rchObservaciones.Width * 0.65
      Label1.Visible = True
      Label2.Visible = True
      dcfields(1).Visible = True
      dcfields(2).Visible = True
   End If
   
   mvarActivarReintegros = BuscarClaveINI("Activar reintegros")
   
   If vnewvalue < 0 Then
      origen.Registro.Fields("FechaRecibo").Value = 1
      mvarIdCliente = 0
   Else
      mvarIdCliente = IIf(IsNull(origen.Registro.Fields("IdCliente").Value), 0, origen.Registro.Fields("IdCliente").Value)
   End If
   
   If mNumeroReciboPagoAutomatico = "SI" Then
      txtNumeroRecibo.Enabled = False
      If vnewvalue > 0 Then dcfields(10).Enabled = False
   End If
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetRecibos.TraerMascara
                     ListaVacia1 = True
                  Else
                     Set oRs = origen.DetRecibos.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                     Else
                        Set oControl.DataSource = origen.DetRecibos.TraerMascara
                        ListaVacia1 = True
                     End If
                     While Not oRs.EOF
                        Set oDet = origen.DetRecibos.Item(oRs.Fields(0).Value)
                        oDet.Modificado = True
                        Set oDet = Nothing
                        oRs.MoveNext
                     Wend
                     oRs.Close
                  End If
               Case "ListaVal"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetRecibosValores.TraerMascara
                     ListaVacia2 = True
                  Else
                     Set oRs = origen.DetRecibosValores.TraerTodos
                     If oRs.Fields.Count > 0 Then
                        If oRs.RecordCount <> 0 Then
                           Set oControl.DataSource = oRs
                           oRs.MoveFirst
                        Else
                           Set oControl.DataSource = origen.DetRecibosValores.TraerMascara
                           ListaVacia2 = True
                        End If
                        While Not oRs.EOF
                           Set oDetVal = origen.DetRecibosValores.Item(oRs.Fields(0).Value)
                           oDetVal.Modificado = True
                           Set oDetVal = Nothing
                           oRs.MoveNext
                        Wend
                     End If
                     oRs.Close
                  End If
               Case "ListaCta"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetRecibosCuentas.TraerMascara
                     ListaVacia3 = True
                  Else
                     Set oRs = origen.DetRecibosCuentas.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                     Else
                        Set oControl.DataSource = origen.DetRecibosCuentas.TraerMascara
                        ListaVacia3 = True
                     End If
                     While Not oRs.EOF
                        Set oDetCta = origen.DetRecibosCuentas.Item(oRs.Fields(0).Value)
                        Set oDetCta = Nothing
                        oRs.MoveNext
                     Wend
                     oRs.Close
                  End If
               Case "ListaRubrosContables"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetRecibosRubrosContables.TraerMascara
                     ListaVacia4 = True
                  Else
                     Set oRs = origen.DetRecibosRubrosContables.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                     Else
                        Set oControl.DataSource = origen.DetRecibosRubrosContables.TraerMascara
                        ListaVacia4 = True
                     End If
                     If oRs.Fields.Count <> 0 Then
                        While Not oRs.EOF
                           Set oDetRubCon = origen.DetRecibosRubrosContables.Item(oRs.Fields(0).Value)
                           oDetRubCon.Modificado = True
                           Set oDetRubCon = Nothing
                           oRs.MoveNext
                        Wend
                     End If
                     oRs.Close
                  End If
               Case "ListaAnticipos"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetRecibosAnticiposAlPersonal.TraerMascara
                     ListaVacia5 = True
                  Else
                     Set oRs = origen.DetRecibosAnticiposAlPersonal.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                     Else
                        Set oControl.DataSource = origen.DetRecibosAnticiposAlPersonal.TraerMascara
                        ListaVacia5 = True
                     End If
                     If oRs.Fields.Count > 0 Then
                        While Not oRs.EOF
                           Set oDetAnt = origen.DetRecibosAnticiposAlPersonal.Item(oRs.Fields(0).Value)
                           oDetAnt.Modificado = True
                           Set oDetAnt = Nothing
                           oRs.MoveNext
                        Wend
                        oRs.Close
                     End If
                  End If
            End Select
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Monedas" Then
'                  Set oControl.RowSource = oAp.Monedas.TraerFiltrado("_MonedasStandarParaCombo")
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               ElseIf oControl.Tag = "PuntosVenta" Then
                  Set oControl.RowSource = oAp.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(2, "X"))
               ElseIf oControl.Tag = "Obras" Then
                  If glbSeñal1 Then
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", Date))
                  Else
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo")
                  End If
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
   
   If mvarId <= 0 Then
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      With origen.Registro
         .Fields("IdMoneda").Value = mvarIdMonedaPesos
         If mNumeroReciboPagoAutomatico = "SI" Then
            .Fields("NumeroRecibo").Value = mNumeroRecibo
         End If
      End With
      Lista.ListItems.Clear
      ListaVal.ListItems.Clear
      ListaCta.ListItems.Clear
      ListaAnticipos.ListItems.Clear
      mvarCotizacion = Cotizacion(Date, glbIdMonedaDolar)
      txtCotizacion.Text = mvarCotizacion
      Option1.Value = True
      If BuscarClaveINI("Calcular diferencia de cambio en deudores") = "SI" Then
         Check1.Value = 1
      End If
      mvarGrabado = False
   Else
'      For Each dtf In DTFields
'         dtf.Enabled = False
'      Next
'      For Each dc In dcfields
'         dc.Enabled = False
'      Next
'      txtNumeroRecibo.Enabled = False
      
      With origen.Registro
'         If .Fields("FechaRecibo").Value < DateSerial(2002, 8, 16) Or Not glbAdministrador Then
'            txtEfectivo.Enabled = False
'            txtRetIva.Enabled = False
'            txtRetGan.Enabled = False
'            txtGasGen.Enabled = False
'            cmd(0).Enabled = False
'         End If
         
         txtCotizacion.Text = .Fields("Cotizacion").Value
         txtCotizacionMoneda.Text = IIf(IsNull(.Fields("CotizacionMoneda").Value), 0, .Fields("CotizacionMoneda").Value)
         mvarCotizacion = .Fields("Cotizacion").Value
         
         If Not IsNull(.Fields("Tipo").Value) Then
            If .Fields("Tipo").Value = "CC" Then
               Option1.Value = True
            ElseIf .Fields("Tipo").Value = "OT" Then
               Option2.Value = True
               If Not IsNull(.Fields("TipoOperacionOtros").Value) Then
                  Combo1(0).ListIndex = .Fields("TipoOperacionOtros").Value
               End If
            End If
         Else
            Option1.Value = True
         End If
         
         If Not IsNull(.Fields("AsientoManual").Value) And .Fields("AsientoManual").Value = "SI" Then
            Check3.Value = 1
         Else
            Check3.Value = 0
         End If
         
         If Not IsNull(.Fields("Dolarizada").Value) And .Fields("Dolarizada").Value = "SI" Then
            Check1.Value = 1
          Else
            Check1.Value = 0
         End If
         
         If Not IsNull(.Fields("Anulado").Value) And _
               .Fields("Anulado").Value = "SI" Then
            mvarAnulada = "SI"
            lblEstado.Visible = True
            lblEstado.Caption = "ANULADO"
         End If
         
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
         CUIT1.Text = IIf(IsNull(.Fields("CuitOpcional").Value), "", .Fields("CuitOpcional").Value)
      
         If Not IsNull(.Fields("IdComprobanteProveedorReintegro").Value) Then
            Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorId", .Fields("IdComprobanteProveedorReintegro").Value)
            If oRs.RecordCount > 0 Then
               txtComprobanteProveedor.Text = oRs.Fields("NumeroReferencia").Value
            End If
            oRs.Close
         End If
      End With
      
      Frame1.Enabled = False
      
      CalculaTotales
      MostrarDiferenciaCambio

'      ActualizaListaContable
      mvarGrabado = True
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing

   If mvarTotalOtrosConceptos <> 0 Then
      cmd(2).BackColor = &HC0FFC0
   Else
      cmd(2).BackColor = &HC0C0FF
   End If
   
   If ListaVacia1 Then Lista.ListItems.Clear
   If ListaVacia2 Then ListaVal.ListItems.Clear
   If ListaVacia3 Then
      ListaCta.ListItems.Clear
   Else
      ListaCta.Refresh
   End If
   If ListaVacia4 Then
      ListaRubrosContables.ListItems.Clear
   Else
      ListaRubrosContables.Refresh
   End If
   If ListaVacia5 Then
      ListaAnticipos.ListItems.Clear
   Else
      Check2.Value = 1
      ListaAnticipos.Refresh
   End If

   cmd(0).Enabled = False
   cmd(5).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      cmd(5).Enabled = True
   End If
   
   If mvarId <= 0 Then
      cmd(5).Enabled = False
   End If
   
   If mvarAnulada = "SI" Then
      cmd(0).Enabled = False
      cmd(5).Enabled = False
   Else
      If DTFields(0).Value <= gblFechaUltimoCierre And _
            Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
         cmd(0).Enabled = False
         cmd(5).Enabled = False
      End If
   End If

End Property

Private Sub cmdImpre_Click(Index As Integer)

   If Not mvarGrabado Then
      MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
      Exit Sub
   End If
   
   Dim mvarEmiteCotizacion As Boolean
   mvarEmiteCotizacion = False
   Dim oF1 As frm_Aux
   Set oF1 = New frm_Aux
   With oF1
      .Caption = "Emision de recibo"
      .Label1.Visible = False
      .Text1.Visible = False
      With .Frame1
         .Caption = "Emite cotizacion dolar ? : "
         .Top = oF1.Label1.Top
         .Visible = True
      End With
      .Option1.Caption = "SI"
      .Option1.Value = True
      .Option2.Caption = "NO"
      .Show vbModal, Me
      mvarEmiteCotizacion = .Option1.Value
   End With
   Unload oF1
   Set oF1 = Nothing
   Me.Refresh
   
   Dim mvarOK As Boolean
   Dim mCopias As Integer
   Dim mPrinter As String, mPrinterAnt As String
   
   mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
   If Index = 0 Then
      mCopias = Val(BuscarClaveINI("CopiasRecibosCobro"))
      If mCopias = 0 Then mCopias = 2
      
      Dim oF As frmCopiasImpresion
      Set oF = New frmCopiasImpresion
      With oF
         .txtCopias.Text = mCopias
         .Frame1.Visible = False
         .Show vbModal, Me
      End With
      mvarOK = oF.Ok
      mCopias = Val(oF.txtCopias.Text)
      mPrinter = oF.Combo1.Text
      Unload oF
      Set oF = Nothing
      If Not mvarOK Then
         Exit Sub
      End If
   Else
      mCopias = 1
   End If

'Dim SrvDoc As InterfazDoc.ISrvDoc
'Dim Resp As Index, mParametros As String
'Set SrvDoc = CreateObject("SrvDocumentos.Documento", "Servidor1")
'mParametros = "" &  glbEmpresaSegunString & "|0|" & mPrinter & "|1"
'SrvDoc.Recibo mvarId, glbStringConexion, mParametros
'Set SrvDoc = Nothing
'Exit Sub
   
   Dim oW As Word.Application
   Dim mPID As String
      
   On Error GoTo Mal
   
   If Index = 0 Then CargaProcesosEnEjecucion
   Set oW = CreateObject("Word.Application")
   If Index = 0 Then mPID = ObtenerPIDProcesosLanzados
   
   With oW
      .Visible = True
      .Documents.Add (glbPathPlantillas & "\Recibo_" & glbEmpresaSegunString & ".dot")
      .Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId, _
            varg3:=mvarEmiteCotizacion, varg4:=mPrinter, varg5:=mCopias, _
            varg6:=glbEmpresaSegunString, varg7:=glbPathPlantillas
      If Index = 0 Then
         oW.Documents(1).Close False
         If glbTerminarProcesosOffice Then
            TerminarProceso mPID
         Else
            oW.Quit
         End If
      End If
   End With
   
   GoTo Salida
   
Mal:
   Me.MousePointer = vbDefault
   MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical

Salida:
   Set oW = Nothing
   Me.MousePointer = vbDefault
   
End Sub

Private Sub dcfields_Change(Index As Integer)

   If IsNumeric(dcfields(Index).BoundText) Then
      If Len(dcfields(Index).DataField) > 0 Then origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
      Dim oRs As ADOR.Recordset
'      Dim mTipoRetencionGanancia As Long
      Select Case Index
         Case 0
            If Option1.Value Then
               Set oRs = Aplicacion.Clientes.TraerFiltrado("_PorIdConDatos", dcfields(Index).BoundText)
               If oRs.RecordCount > 0 Then
                  txtCodigo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
                  If mvarId < 0 And Not IsNull(oRs.Fields("Vendedor1").Value) Then
                     dcfields(1).BoundText = oRs.Fields("Vendedor1").Value
                  End If
                  If mvarId < 0 And Not IsNull(oRs.Fields("Cobrador").Value) Then
                     dcfields(2).BoundText = oRs.Fields("Cobrador").Value
                  End If
'                  mTipoRetencionGanancia = IIf(IsNull(oRs.Fields("TipoRetencionGanancia").Value), 0, oRs.Fields("TipoRetencionGanancia").Value)
               End If
               oRs.Close
               Set oRs = Nothing
               If Not ControlImputacionCliente Then MsgBox "Hay imputaciones que corresponden a otro cliente, eliminelas", vbExclamation
            End If
         Case 3
            If dcfields(Index).BoundText = mvarIdMonedaPesos Then
               cmd(8).Enabled = True
               txtCotizacionMoneda.Text = 1
            Else
               cmd(8).Enabled = False
               Set oRs = Aplicacion.Cotizaciones.TraerFiltrado("_PorFechaMoneda", Array(DTFields(0).Value, dcfields(Index).BoundText))
               If oRs.RecordCount > 0 Then
                  txtCotizacionMoneda.Text = oRs.Fields("CotizacionLibre").Value
                  If dcfields(Index).BoundText = mvarIdMonedaDolar Then
                     txtCotizacion.Text = oRs.Fields("CotizacionLibre").Value
                  End If
               Else
                  MsgBox "No hay cotizacion, ingresela manualmente"
                  txtCotizacionMoneda.Text = ""
               End If
               oRs.Close
               Set oRs = Nothing
            End If
         Case 10
            If mvarId <= 0 Then
               Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(Index).BoundText)
               If oRs.RecordCount > 0 Then
                  origen.Registro.Fields("NumeroRecibo").Value = oRs.Fields("ProximoNumero").Value
                  txtNumeroRecibo.Text = oRs.Fields("ProximoNumero").Value
               End If
               oRs.Close
            End If
      End Select
   End If
   
End Sub

Private Sub dcfields_GotFocus(Index As Integer)

   With dcfields(0)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   If Index <> 10 Then SendKeys "%{DOWN}"

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub dcfields1_Click(Index As Integer, Area As Integer)

   If IsNumeric(dcfields1(Index).BoundText) Then
      If Len(dcfields1(Index).DataField) > 0 Then origen.Registro.Fields(dcfields1(Index).DataField).Value = dcfields1(Index).BoundText
      Dim oRs As ADOR.Recordset
      Select Case Index
         Case 0
            If Not dcfields1(1).Enabled Then
               dcfields1(1).Enabled = True
            End If
         Case 1
            If dcfields1(Index).Enabled Then
               If Not IsNumeric(dcfields1(0).BoundText) Then
                  MsgBox "Debe definir la obra", vbExclamation
                  origen.Registro.Fields(dcfields1(Index).DataField).Value = Null
                  Exit Sub
               End If
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorObraCuentaGasto", _
                     Array(dcfields1(0).BoundText, dcfields1(1).BoundText))
               If oRs.RecordCount > 0 Then
                  If Len(dcfields1(2).Text) > 0 Then
                     dcfields1(2).BoundText = 0
                     Set dcfields(0).RowSource = Aplicacion.Cuentas.TraerLista
                  End If
                  With origen.Registro
                     .Fields(dcfields1(Index).DataField).Value = oRs.Fields("IdCuentaGasto").Value
                     .Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
                  End With
               End If
               oRs.Close
               Set oRs = Nothing
            Else
               origen.Registro.Fields(dcfields1(Index).DataField).Value = Null
            End If
            dcfields(0).Enabled = False
            dcfields1(2).Enabled = False
            Check4.Value = 1
         Case 2
            Dim mIdCuenta As Long
            If IsNumeric(dcfields(0).BoundText) Then
               mIdCuenta = dcfields(0).BoundText
            Else
               mIdCuenta = 0
            End If
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorGrupoParaCombo", dcfields1(Index).BoundText)
            Set dcfields(0).RowSource = oRs
            origen.Registro.Fields(dcfields(0).DataField).Value = mIdCuenta
            Set oRs = Nothing
      End Select
   End If
   
End Sub

Private Sub DTFields_Change(Index As Integer)

   If Index = 0 Then
      mvarCotizacion = Cotizacion(DTFields(Index).Value, glbIdMonedaDolar)
      txtCotizacion.Text = mvarCotizacion
   End If

End Sub

Private Sub DTFields_Click(Index As Integer)

   If Index = 0 Then
      mvarCotizacion = Cotizacion(DTFields(Index).Value, glbIdMonedaDolar)
      txtCotizacion.Text = mvarCotizacion
   End If

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub DTFields_Validate(Index As Integer, Cancel As Boolean)

   If glbSeñal1 And Index = 0 Then
      Dim mIdAux As Long
      mIdAux = 0
      If IsNumeric(dcfields1(0).BoundText) Then mIdAux = dcfields1(0).BoundText
      Set dcfields1(0).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", DTFields(0).Value))
      dcfields1(0).BoundText = mIdAux
      If Option2.Value Then
         mIdAux = 0
         If IsNumeric(dcfields(0).BoundText) Then mIdAux = dcfields(0).BoundText
         Set dcfields(0).RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorFechaParaCombo", DTFields(0).Value)
         dcfields(0).BoundText = mIdAux
      End If
   End If

End Sub

Private Sub Form_Activate()

   If mvarCotizacion = 0 Then
      Me.Refresh
      MsgBox "No hay cotizacion, ingresela primero", vbExclamation
      If mvarId <= 0 Then Unload Me
   End If
   
End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaVal
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaCta
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaRubrosContables
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With

   With ListaAnticipos
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With

'   For Each oI In Img16.ListImages
'      With Estado.Panels.Add(, , oI.Key)
'         .Picture = oI.Picture
'      End With
'   Next

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Lista_DblClick()

   If Lista.ListItems.Count = 0 Then
      Editar -1
   Else
      Editar Lista.SelectedItem.Tag
   End If

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyDelete Then
      MnuDetA_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetA_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetA_Click 1
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count = 0 Then
         MnuDetA(1).Enabled = False
         MnuDetA(2).Enabled = False
         PopupMenu MnuDet, , , , MnuDetA(0)
      Else
         MnuDetA(1).Enabled = True
         MnuDetA(2).Enabled = True
         PopupMenu MnuDet, , , , MnuDetA(1)
      End If
   End If

End Sub

Private Sub ListaAnticipos_DblClick()

   If Not ListaAnticipos.SelectedItem Is Nothing Then
      If IsNumeric(ListaAnticipos.SelectedItem.Tag) And Option2.Value Then
         If ListaAnticipos.ListItems.Count = 0 Then
            EditarAnticipo -1
         Else
            EditarAnticipo ListaAnticipos.SelectedItem.Tag
         End If
      End If
   End If

End Sub

Private Sub ListaAnticipos_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaAnticipos_KeyUp(KeyCode As Integer, Shift As Integer)

   If Option2.Value Then
      If KeyCode = vbKeyDelete Then
         MnuDetD_Click 2
      ElseIf KeyCode = vbKeyInsert Then
         MnuDetD_Click 0
      ElseIf KeyCode = vbKeySpace Then
         MnuDetD_Click 1
      End If
   End If

End Sub

Private Sub ListaAnticipos_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   
   If Button = vbRightButton And Option2.Value Then
      If ListaAnticipos.ListItems.Count = 0 Then
         MnuDetD(1).Enabled = False
         MnuDetD(2).Enabled = False
         PopupMenu MnuDetAnticipo, , , , MnuDetD(0)
      Else
         MnuDetD(1).Enabled = True
         MnuDetD(2).Enabled = True
         PopupMenu MnuDetAnticipo, , , , MnuDetD(1)
      End If
   End If

End Sub

Private Sub ListaCta_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaRubrosContables_DblClick()

   If Not ListaRubrosContables.SelectedItem Is Nothing Then
      If IsNumeric(ListaRubrosContables.SelectedItem.Tag) Then
         If ListaRubrosContables.ListItems.Count = 0 Then
            EditarRubroContable -1
         Else
            EditarRubroContable ListaRubrosContables.SelectedItem.Tag
         End If
      End If
   End If

End Sub

Private Sub ListaRubrosContables_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaRubrosContables_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetE_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetE_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetE_Click 1
   End If

End Sub

Private Sub ListaRubrosContables_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)

   If Button = vbRightButton Then
      If ListaRubrosContables.ListItems.Count = 0 Then
         MnuDetE(1).Enabled = False
         MnuDetE(2).Enabled = False
         PopupMenu MnuDetRubroContable, , , , MnuDetE(0)
      Else
         MnuDetE(1).Enabled = True
         MnuDetE(2).Enabled = True
         PopupMenu MnuDetRubroContable, , , , MnuDetE(1)
      End If
   End If

End Sub

Private Sub ListaRubrosContables_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single)

   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long, NroItem As Long, idDet As Long
   Dim s As String, mExiste As String

   If Data.GetFormat(ccCFText) Then
      
      Dim oRs As ADOR.Recordset
      Dim oL As ListItem
      
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 2), "Rubro") <> 0 Then
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            Set oRs = Aplicacion.RubrosContables.TraerFiltrado("_PorId", Columnas(0))
            If oRs.RecordCount > 0 Then
               If IsNull(oRs.Fields("Financiero").Value) Or oRs.Fields("Financiero").Value <> "SI" Then
                  oRs.Close
                  Set oRs = Nothing
                  MsgBox "Solo puede incluir rubros financieros", vbExclamation
                  Exit Sub
               End If
               If Not IsNull(oRs.Fields("IngresoEgreso").Value) And oRs.Fields("IngresoEgreso").Value <> "I" Then
                  oRs.Close
                  Set oRs = Nothing
                  MsgBox "Solo puede incluir rubros de ingresos", vbExclamation
                  Exit Sub
               End If
               With origen.DetRecibosRubrosContables.Item(-1)
                  .Registro.Fields("IdRubroContable").Value = oRs.Fields("IdRubroContable").Value
                  .Registro.Fields("Importe").Value = 0
                  .Modificado = True
                  idDet = .Id
               End With
               Set oL = ListaRubrosContables.ListItems.Add
               oL.Tag = idDet
               With oL
                  .SmallIcon = "Nuevo"
                  .Text = "" & oRs.Fields("Descripcion").Value
               End With
            End If
            oRs.Close
            Set oRs = Nothing
         Next

         Clipboard.Clear

      Else
         
         MsgBox "Objeto invalido!"
         Exit Sub
      
      End If

   End If
   
End Sub

Private Sub ListaRubrosContables_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single, State As Integer)

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
         If Columnas(LBound(Columnas) + 1) <> "Descripcion" Then
            Effect = vbDropEffectNone
         Else
            Effect = vbDropEffectCopy
         End If
      End If
   End If

End Sub

Private Sub ListaRubrosContables_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub ListaVal_DblClick()
   
   If Lista.ListItems.Count = 0 Then Exit Sub
   If IsNumeric(ListaVal.SelectedItem.Tag) Then
      If ListaVal.ListItems.Count = 0 Then
         EditarVal -1
      Else
         EditarVal ListaVal.SelectedItem.Tag
      End If
   End If

End Sub

Private Sub ListaVal_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaVal_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetB_Click 3
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetB_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetB_Click 2
   End If

End Sub

Private Sub ListaVal_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   
   If Button = vbRightButton Then
      If ListaVal.ListItems.Count = 0 Then
         MnuDetB(2).Enabled = False
         MnuDetB(3).Enabled = False
         PopupMenu MnuDetVal, , , , MnuDetB(0)
      Else
         MnuDetB(0).Enabled = True
         MnuDetB(1).Enabled = True
         MnuDetB(2).Enabled = True
         MnuDetB(3).Enabled = True
         PopupMenu MnuDetVal, , , , MnuDetB(1)
      End If
   End If

End Sub

Private Sub ListaCta_DblClick()
   
   If ListaCta.ListItems.Count = 0 Then Exit Sub
   If IsNumeric(ListaCta.SelectedItem.Tag) Then
      If ListaCta.ListItems.Count = 0 Then
         EditarCta -1
      Else
         EditarCta ListaCta.SelectedItem.Tag
      End If
   End If

End Sub

Private Sub ListaCta_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetC_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetC_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetC_Click 1
   End If

End Sub

Private Sub ListaCta_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   
   If Button = vbRightButton Then
      If ListaCta.ListItems.Count = 0 Then
         MnuDetC(1).Enabled = False
         MnuDetC(2).Enabled = False
         PopupMenu MnuDetCta, , , , MnuDetC(0)
      Else
         MnuDetC(1).Enabled = True
         MnuDetC(2).Enabled = True
         PopupMenu MnuDetCta, , , , MnuDetC(1)
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         Editar Lista.SelectedItem.Tag
      Case 2
         With Lista.SelectedItem
            origen.DetRecibos.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         CalculaTotales
         MostrarDiferenciaCambio
      Case 3
         If Not Lista.SelectedItem Is Nothing Then EditarImporte Lista.SelectedItem.Tag
      Case 4
         ImputacionAutomatica
      Case 5
         PagoAnticipado
   End Select

End Sub

Private Sub MnuDetB_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarVal -1
      Case 1
         EditarVal -2
      Case 2
         EditarVal ListaVal.SelectedItem.Tag
      Case 3
         With ListaVal.SelectedItem
            If mvarId > 0 Then
               If Not ValorModificable(0, .Tag) Then
                  MsgBox "El valor ha sido depositado y no puede ser editado.", vbExclamation
                  Exit Sub
               End If
               If origen.DetRecibosValores.Item(.Tag).Registro.Fields("IdTipoValor").Value = 6 Then
                  Dim oRs As ADOR.Recordset
                  Dim mError As String
                  mError = ""
                  Set oRs = Aplicacion.Valores.TraerFiltrado("_PorIdDetalleReciboValores", .Tag)
                  If oRs.RecordCount > 0 Then
                     If Not IsNull(oRs.Fields("Estado").Value) Then
                        mError = "No puede eliminar el valor porque fue "
                        If oRs.Fields("Estado").Value = "D" Then
                           mError = mError & "depositado"
                        ElseIf oRs.Fields("Estado").Value = "E" Then
                           mError = mError & "endosado"
                        Else
                           mError = mError & "utilizado"
                        End If
                     End If
                  End If
                  oRs.Close
                  Set oRs = Nothing
                  If Len(mError) > 0 Then
                     MsgBox mError, vbCritical
                     Exit Sub
                  End If
               End If
            End If
            origen.DetRecibosValores.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         CalculaTotales
         MostrarDiferenciaCambio
   End Select

End Sub

Private Sub MnuDetC_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarCta -1
      Case 1
         EditarCta ListaCta.SelectedItem.Tag
      Case 2
         If mvarId > 0 Then
            MsgBox "No puede modificar un recibo ya registrado!", vbCritical
            Exit Sub
         End If
         With ListaCta.SelectedItem
            origen.DetRecibosCuentas.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub MnuDetD_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarAnticipo -1
      Case 1
         EditarAnticipo ListaAnticipos.SelectedItem.Tag
      Case 2
'         If mvarId > 0 Then
'            MsgBox "No puede modificar un OrdenPago ya registrado!", vbCritical
'            Exit Sub
'         End If
         With ListaAnticipos.SelectedItem
            origen.DetRecibosAnticiposAlPersonal.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         CalculaTotales
   End Select

End Sub

Private Sub MnuDetE_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarRubroContable -1
      Case 1
         EditarRubroContable ListaRubrosContables.SelectedItem.Tag
      Case 2
         With ListaRubrosContables.SelectedItem
            origen.DetRecibosRubrosContables.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub Option1_Click()

   Dim oL As ListItem
   If Option1.Value Then
      With dcfields(0)
         .Left = txtCodigo.Left + txtCodigo.Width + 5
         Set .RowSource = Nothing
         .Text = ""
         .DataField = "IdCliente"
         .BoundColumn = "IdCliente"
         Set .RowSource = Aplicacion.Clientes.TraerLista
         If Not IsNull(origen.Registro.Fields("IdCliente").Value) Then .BoundText = origen.Registro.Fields("IdCliente").Value
         origen.Registro.Fields("IdCuenta").Value = Null
         origen.Registro.Fields("IdObra").Value = Null
         origen.Registro.Fields("IdCuentaGasto").Value = Null
      End With
      With txtBusca
         .Top = lblLabels(22).Top
         .Left = dcfields(0).Left + dcfields(0).Width - .Width
         .Visible = True
      End With
      With lblBusca
         .Top = txtBusca.Top
         .Left = txtBusca.Left - .Width - 30
         .Visible = True
      End With
      Check2.Visible = False
      Check4.Visible = False
      dcfields1(0).Visible = False
      dcfields1(1).Visible = False
      dcfields1(2).Visible = False
      lblObra.Visible = False
      With lblDestino
         .Left = txtCodigo.Left - .Width - 5
         .Caption = "Cliente :"
      End With
      txtCodigo.Visible = True
      With Lista
         .BackColor = &H80000005
         .Visible = True
      End With
      With Check3
         .Value = 0
         .Enabled = False
      End With
      lblRet(0).Visible = True
      lblRet(1).Visible = True
      lblRet(2).Visible = True
      dcfields1(3).Visible = True
      txtNumeroCertificadoRetencionGanancias.Visible = True
      txtNumeroCertificadoRetencionIVA.Visible = True
      If Not IsNull(origen.Registro.Fields("NumeroCertificadoSUSS").Value) Then
         txtNumeroCertificadoSUSS.Visible = True
         lblRet(3).Visible = True
      End If
      txtNumeroCertificadoRetencionIngresosBrutos.Visible = True
      lblRet(4).Visible = True
'      If Not IsNull(origen.Registro.Fields("NumeroCertificadoRetencionIngresosBrutos").Value) Then
'         txtNumeroCertificadoRetencionIngresosBrutos.Visible = True
'         lblRet(4).Visible = True
'      End If
      dcfields(8).Visible = False
      lblCondicionIva.Visible = False
      lblTipoOperacion.Visible = False
      Combo1(0).Visible = False
      lblCuit.Visible = False
      CUIT1.Visible = False
      lblComprobanteProveedor.Visible = False
      txtComprobanteProveedor.Visible = False
      With ListaAnticipos
         If .ListItems.Count > 0 And Me.Visible Then
            For Each oL In .ListItems
               origen.DetRecibosAnticiposAlPersonal.Item(oL.Tag).Eliminado = True
            Next
         End If
         .ListItems.Clear
         .Visible = False
      End With
      Check2.Value = 0
      lblLabels(6).Caption = "Total imputaciones :"
      CalculaTotales
   End If
      
End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      With dcfields(0)
         .Left = txtCodigo.Left
         Set .RowSource = Nothing
         .Text = ""
         .DataField = "IdCuenta"
         .BoundColumn = "IdCuenta"
         If glbSeñal1 Then
            Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorFechaParaCombo", DTFields(0).Value)
         Else
            Set .RowSource = Aplicacion.Cuentas.TraerLista
         End If
         If Not IsNull(origen.Registro.Fields("IdCuenta").Value) Then .BoundText = origen.Registro.Fields("IdCuenta").Value
         origen.Registro.Fields("IdCliente").Value = Null
      End With
      If glbModeloContableSinApertura = "SI" Then
         With dcfields1(2)
            .Left = Check4.Left
            .Width = DTFields(0).Width * 3
         End With
      Else
         Check4.Visible = True
         dcfields1(1).Visible = True
      End If
      dcfields1(0).Visible = True
      dcfields1(2).Visible = True
      lblObra.Visible = True
      lblDestino.Caption = "Cuenta :"
      txtCodigo.Visible = False
      txtBusca.Visible = False
      lblBusca.Visible = False
      With Lista
         .ListItems.Clear
         .BackColor = &HC0C0C0
         .Enabled = False
         .Visible = True
      End With
      With Check3
         .Value = 0
         .Enabled = True
      End With
      With lblCondicionIva
         .Top = lblRet(0).Top
         .Left = lblObra.Left
         .Visible = True
      End With
      With dcfields(8)
         .Top = lblCondicionIva.Top
         .Left = lblCondicionIva.Left + lblCondicionIva.Width
         .Visible = True
      End With
      With lblTipoOperacion
         .Top = dcfields(8).Top
         .Left = dcfields(8).Left + dcfields(8).Width + 8
         .Visible = True
      End With
      With Combo1(0)
         .Top = lblTipoOperacion.Top
         .Left = lblTipoOperacion.Left + lblTipoOperacion.Width
         .Visible = True
      End With
      With lblCuit
         .Top = lblCondicionIva.Top + lblCondicionIva.Height + (lblCondicionIva.Height / 3)
         .Left = lblCondicionIva.Left
         .Visible = True
      End With
      With CUIT1
         .Top = lblCuit.Top
         .Left = lblCuit.Left + lblCuit.Width
         .Visible = True
      End With
      If mvarActivarReintegros = "SI" Then
         With lblComprobanteProveedor
            .Top = CUIT1.Top
            .Left = lblRet(3).Left
            .Visible = True
         End With
         With txtComprobanteProveedor
            .Top = CUIT1.Top
            .Left = txtNumeroCertificadoSUSS.Left
            .Visible = True
         End With
      End If
      With Check2
         .Top = txtTotal(0).Top
         .Left = Lista.Left
         .Visible = True
      End With
      lblRet(0).Visible = False
      lblRet(1).Visible = False
      lblRet(2).Visible = False
      'lblRet(3).Visible = False
      'lblRet(4).Visible = False
      dcfields1(3).Visible = False
      txtNumeroCertificadoRetencionGanancias.Visible = False
      txtNumeroCertificadoRetencionIVA.Visible = False
      'txtNumeroCertificadoSUSS.Visible = False
      'txtNumeroCertificadoRetencionIngresosBrutos.Visible = False
      txtNumeroCertificadoRetencionIngresosBrutos.Visible = False
      lblRet(4).Visible = False
      lblLabels(6).Caption = "Total anticipos :"
      CalculaTotales
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
         Dim oRs As ADOR.Recordset
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set oRs = Aplicacion.Clientes.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set oRs = Aplicacion.Clientes.TraerLista
         End If
         Set dcfields(0).RowSource = oRs
         If oRs.RecordCount > 0 Then
            dcfields(0).BoundText = oRs.Fields(0).Value
         End If
         Set oRs = Nothing
      End If
      dcfields(0).SetFocus
      SendKeys "%{DOWN}"
   End If

End Sub

Private Sub txtCodigo_Change()

'   If Len(txtCodigo.Text) > 0 Then
'      Dim oRs As ADOR.Recordset
'      Set oRs = Aplicacion.Clientes.TraerFiltrado("_PorCodigo", txtCodigo.Text)
'      If oRs.RecordCount > 0 Then
'         origen.Registro.Fields("IdCliente").Value = oRs.Fields(0).Value
'      Else
'         origen.Registro.Fields("IdCliente").Value = Null
'      End If
'      oRs.Close
'      Set oRs = Nothing
'   End If

End Sub

Private Sub txtCodigo_GotFocus()

   With txtCodigo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigo_Validate(Cancel As Boolean)

   If Len(txtCodigo.Text) > 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Clientes.TraerFiltrado("_PorCodigo", txtCodigo.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdCliente").Value = oRs.Fields(0).Value
      Else
         MsgBox "Codigo de cliente inexistente", vbExclamation
         Cancel = True
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

Private Sub txtComprobanteProveedor_GotFocus()

   With txtComprobanteProveedor
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtComprobanteProveedor_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtComprobanteProveedor_Validate(Cancel As Boolean)

   If Len(txtComprobanteProveedor.Text) > 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorNumeroReferencia", txtComprobanteProveedor.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdComprobanteProveedorReintegro").Value = oRs.Fields(0).Value
      Else
         MsgBox "No existe el comprobante", vbExclamation
         Cancel = True
      End If
      oRs.Close
      Set oRs = Nothing
   Else
      origen.Registro.Fields("IdComprobanteProveedorReintegro").Value = Null
   End If

End Sub

Private Sub txtCotizacion_GotFocus()

   With txtCotizacion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCotizacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCotizacion_Validate(Cancel As Boolean)

   If Len(txtCotizacion.Text) = 0 Or Not IsNumeric(txtCotizacion.Text) Then
      MsgBox "Debe ingresar una cotizacion", vbExclamation
      Cancel = True
   Else
      mvarCotizacion = txtCotizacion.Text
      If origen.Registro.Fields("IdMoneda").Value = mvarIdMonedaDolar Then
         txtCotizacionMoneda.Text = txtCotizacion.Text
      End If
      MostrarDiferenciaCambio
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
      txtCotizacion.Text = txtCotizacionMoneda.Text
   End If

End Sub

Private Sub txtEfectivo_Change()

   CalculaTotales

End Sub

Private Sub txtEfectivo_GotFocus()

   With txtEfectivo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtEfectivo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtEfectivo_LostFocus()

'   ActualizaListaContable
   
End Sub

Private Sub txtGasGen_Change()

   CalculaTotales
   
End Sub

Private Sub txtGasGen_GotFocus()

   With txtGasGen
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtGasGen_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtGasGen_LostFocus()

'   ActualizaListaContable

End Sub

Private Sub txtNumeroCertificadoRetencionGanancias_GotFocus()

   With txtNumeroCertificadoRetencionGanancias
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroCertificadoRetencionGanancias_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroCertificadoRetencionGanancias_Validate(Cancel As Boolean)

   If Len(txtNumeroCertificadoRetencionGanancias.Text) > 0 Then
      If Not IsNumeric(txtNumeroCertificadoRetencionGanancias.Text) Then
         MsgBox "El certificado debe ser numerico", vbExclamation
         Cancel = True
      End If
   End If

End Sub

Private Sub txtNumeroCertificadoRetencionIngresosBrutos_GotFocus()

   With txtNumeroCertificadoRetencionIngresosBrutos
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroCertificadoRetencionIngresosBrutos_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroCertificadoRetencionIngresosBrutos_Validate(Cancel As Boolean)

   If Len(txtNumeroCertificadoRetencionIngresosBrutos.Text) > 0 Then
      If Not IsNumeric(txtNumeroCertificadoRetencionIngresosBrutos.Text) Then
         MsgBox "El certificado debe ser numerico", vbExclamation
         Cancel = True
      End If
   End If

End Sub

Private Sub txtNumeroCertificadoRetencionIVA_GotFocus()

   With txtNumeroCertificadoRetencionIVA
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroCertificadoRetencionIVA_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroCertificadoRetencionIVA_Validate(Cancel As Boolean)

   If Len(txtNumeroCertificadoRetencionIVA.Text) > 0 Then
      If Not IsNumeric(txtNumeroCertificadoRetencionIVA.Text) Then
         MsgBox "El certificado debe ser numerico", vbExclamation
         Cancel = True
      End If
   End If

End Sub

Private Sub txtNumeroCertificadoSUSS_GotFocus()

   With txtNumeroCertificadoSUSS
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroCertificadoSUSS_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroCertificadoSUSS_Validate(Cancel As Boolean)

   If Len(txtNumeroCertificadoSUSS.Text) > 0 Then
      If Not IsNumeric(txtNumeroCertificadoSUSS.Text) Then
         MsgBox "El certificado debe ser numerico", vbExclamation
         Cancel = True
      End If
   End If

End Sub

Private Sub txtNumeroRecibo_GotFocus()
   
   With txtNumeroRecibo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroRecibo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtNumeroRecibo
         If Len(Trim(.Text)) > 7 And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtNumeroRecibo_Validate(Cancel As Boolean)
   
   If mvarId < 0 And Len(txtNumeroRecibo.Text) > 0 Then
      If Not IsNumeric(dcfields(10).BoundText) Then
         MsgBox "Debe definir antes el grupo numerador"
         Cancel = True
         Exit Sub
      End If
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Recibos.TraerFiltrado("Cod", Array(dcfields(10).Text, Val(txtNumeroRecibo.Text)))
      If oRs.RecordCount > 0 Then
         MsgBox "Recibo ya ingresado el " & oRs.Fields("FechaRecibo").Value & ". Reingrese.", vbCritical
         Cancel = True
      End If
      oRs.Close
      Set oRs = Nothing
      If Len(txtNumeroRecibo.Text) > 8 Then
         Cancel = True
      End If
   End If

End Sub

Public Sub CalculaTotales()

   Dim i As Integer
   Dim oRs As ADOR.Recordset
   
   mvarTotalImputaciones = 0
   mvarTotalDebe = 0
   mvarTotalHaber = 0
   mvarTotalValores = 0
   mvarTotalRubrosContables = 0
   mvarTotalOtrosConceptos = 0
   mvarTotalAnticipos = 0
   
   If Option1.Value Then
      Set oRs = origen.DetRecibos.TodosLosRegistros
      If oRs.State <> 0 Then
         If oRs.RecordCount > 0 Then
            oRs.MoveFirst
            Do While Not oRs.EOF
               mvarTotalImputaciones = mvarTotalImputaciones + oRs.Fields("Importe").Value
               oRs.MoveNext
            Loop
            oRs.Close
         End If
      End If
      Set oRs = Nothing
   ElseIf Option2.Value And ListaAnticipos.ListItems.Count > 0 Then
      Set oRs = origen.DetRecibosAnticiposAlPersonal.TodosLosRegistros
      If oRs.State <> 0 Then
         If oRs.RecordCount > 0 Then
            oRs.MoveFirst
            Do While Not oRs.EOF
               mvarTotalAnticipos = mvarTotalAnticipos + oRs.Fields("Importe").Value
               oRs.MoveNext
            Loop
            oRs.Close
         End If
      End If
      Set oRs = Nothing
   End If
   
   Set oRs = origen.DetRecibosValores.TodosLosRegistros
   If oRs.State <> 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            mvarTotalValores = mvarTotalValores + IIf(IsNull(oRs.Fields("Importe").Value), 0, oRs.Fields("Importe").Value)
            oRs.MoveNext
         Loop
      End If
      oRs.Close
   End If
   Set oRs = Nothing
   
   Set oRs = origen.DetRecibosCuentas.TodosLosRegistros
   If oRs.State <> 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If Not IsNull(oRs.Fields("Debe").Value) Then
               mvarTotalDebe = mvarTotalDebe + oRs.Fields("Debe").Value
            End If
            If Not IsNull(oRs.Fields("Haber").Value) Then
               mvarTotalHaber = mvarTotalHaber + oRs.Fields("Haber").Value
            End If
            oRs.MoveNext
         Loop
      End If
      oRs.Close
   End If
   Set oRs = Nothing
   
   Set oRs = origen.DetRecibosRubrosContables.TodosLosRegistros
   If oRs.State <> 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            mvarTotalRubrosContables = mvarTotalRubrosContables + IIf(IsNull(oRs.Fields("Importe").Value), 0, oRs.Fields("Importe").Value)
            oRs.MoveNext
         Loop
      End If
      oRs.Close
   End If
   Set oRs = Nothing
   
   txtTotal(0).Text = Format(mvarTotalImputaciones + mvarTotalAnticipos, "#,##0.00")
   txtTotal(1).Text = Format(mvarTotalDebe, "#,##0.00")
   txtTotal(2).Text = Format(mvarTotalHaber, "#,##0.00")
   txtTotal(3).Text = Format(mvarTotalValores, "#,##0.00")
   
   With origen.Registro
      For i = 1 To 10
         mvarTotalOtrosConceptos = mvarTotalOtrosConceptos + _
               IIf(IsNull(.Fields("Otros" & i).Value), 0, .Fields("Otros" & i).Value)
      Next
   End With
   txtGasGen.Text = Format(mvarTotalOtrosConceptos, "#,##0.00")
   txtDif.Text = Round(mvarTotalImputaciones - (mvarTotalValores + Val(txtEfectivo.Text) + Val(txtRetIva.Text) + Val(txtRetGan.Text) + mvarTotalOtrosConceptos), 2)
   
   With origen.Registro
      .Fields("Deudores").Value = mvarTotalImputaciones
      .Fields("Valores").Value = mvarTotalValores
   End With
   
   If mvarId <= 0 Then
      mvarPuntoVenta = 0
      If IsNumeric(dcfields(10).BoundText) Then
         mvarPuntoVenta = dcfields(10).BoundText
      End If
      Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(2, "X"))
      If oRs.RecordCount = 1 Then
         oRs.MoveFirst
         mvarPuntoVenta = oRs.Fields(0).Value
         If mvarId <= 0 And Len(txtNumeroRecibo.Text) = 0 Then
            origen.Registro.Fields("NumeroRecibo").Value = oRs.Fields("ProximoNumero").Value
            txtNumeroRecibo.Text = oRs.Fields("ProximoNumero").Value
         End If
      End If
      Set dcfields(10).RowSource = oRs
      dcfields(10).BoundText = mvarPuntoVenta
      If Len(dcfields(10).Text) = 0 Then
         origen.Registro.Fields("NumeroRecibo").Value = Null
         txtNumeroRecibo.Text = ""
      End If
      Set oRs = Nothing
   End If

End Sub

Private Sub txtRetGan_Change()

   CalculaTotales
   
End Sub

Private Sub txtRetGan_GotFocus()

   With txtRetGan
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtRetGan_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtRetGan_LostFocus()

'   ActualizaListaContable

End Sub

Private Sub txtRetIva_Change()

   CalculaTotales
   
End Sub

Private Sub txtRetIva_GotFocus()

   With txtRetIva
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtRetIva_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Sub ActualizaListaContable()

   If Check3.Value = 0 Then
      On Error Resume Next
      ListaCta.ListItems.Clear
      Set ListaCta.DataSource = origen.RegistroContableForm
      DoEvents
      ListaCta.Refresh
      txtTotal(1).Text = Format(origen.TotalDebe, "#,##0.00")
      txtTotal(2).Text = Format(origen.TotalHaber, "#,##0.00")
      DoEvents
   End If

End Sub

Private Sub txtRetIva_LostFocus()

'   ActualizaListaContable

End Sub

Public Function RecalcularSaldosImputacion(ByVal mIdImputacion As Long, mPagado As Double) As String

   Dim oRs As ADOR.Recordset
   Dim Resul As String
   Dim mSaldoDolarEnPesos As Double, mSaldoParteEnDolares As Double
   Dim mSaldoParteEnPesos As Double
   
   Set oRs = Aplicacion.CtasCtesD.TraerFiltrado("_Imputacion", mIdImputacion)

   Resul = ""
   If oRs.RecordCount > 0 Then
      If oRs.Fields("IdTipoComp") = 1 Then
         If Not IsNull(oRs.Fields("SaldoImporteParteEnDolares").Value) Then
            mSaldoParteEnDolares = oRs.Fields("SaldoImporteParteEnDolares").Value
         Else
            mSaldoParteEnDolares = 0
         End If
         mSaldoDolarEnPesos = mSaldoParteEnDolares * mvarCotizacion
         Resul = Resul & mSaldoParteEnDolares & "|"
         If mPagado > mSaldoDolarEnPesos Then
            Resul = Resul & mSaldoParteEnDolares & "|"
            Resul = Resul & "0|"
            mPagado = mPagado - mSaldoDolarEnPesos
         Else
            Resul = Resul & Round(mPagado / mvarCotizacion, 2) & "|"
            Resul = Resul & mSaldoParteEnDolares - Round(mPagado / mvarCotizacion, 2) & "|"
            mPagado = 0
         End If
         
         If Not IsNull(oRs.Fields("SaldoImporteParteEnPesos").Value) Then
            mSaldoParteEnPesos = oRs.Fields("SaldoImporteParteEnPesos").Value
         Else
            mSaldoParteEnPesos = 0
         End If
         Resul = Resul & mSaldoParteEnPesos & "|"
         If mPagado > mSaldoParteEnPesos Then
            Resul = Resul & mSaldoParteEnPesos & "|"
            Resul = Resul & "0|"
            mPagado = mPagado - mSaldoParteEnPesos
         Else
            Resul = Resul & mPagado & "|"
            Resul = Resul & Round(mSaldoParteEnPesos - mPagado, 2) & "|"
            mPagado = 0
         End If
      End If
   End If
   oRs.Close
   Set oRs = Nothing
   
   RecalcularSaldosImputacion = Resul

End Function

Public Sub MostrarDiferenciaCambio()

   If Check1.Value = 0 Then
      txtTotal(4).Text = 0
      Exit Sub
   End If
   
   txtTotal(4).Text = Format(ValorDiferenciaCambio(), "#,##0.00")

End Sub

Private Sub AgregarDiferenciaCambio()

'   If mvarId > 0 Then
'      MsgBox "No puede modificar un recibo ya registrado!", vbCritical
'      Exit Sub
'   End If
   
   If Len(Trim(dcfields(0).BoundText)) = 0 Then
      MsgBox "Falta completar el campo cliente", vbCritical
      Exit Sub
   End If
   
   If Len(Trim(txtNumeroRecibo.Text)) = 0 Then
      MsgBox "Falta completar el campo numero de recibo", vbCritical
      Exit Sub
   End If
   
   If Val(txtTotal(4).Text) < 0 Then
      MsgBox "La diferencia de cambio debe ser mayor a cero", vbCritical
      Exit Sub
   End If
   
   Dim oRs As ADOR.Recordset
   Dim mvarDifCam As Double
   
   mvarDifCam = ValorDiferenciaCambio()

   If mvarDifCam > 0 Then
      With origen.DetRecibos.Item(-1)
         .Registro.Fields("IdImputacion").Value = -1
         .Registro.Fields("Importe").Value = mvarDifCam
         .Modificado = True
      End With
   End If

   Set oRs = origen.DetRecibos.RegistrosConFormato
   Set Lista.DataSource = oRs
   
   oRs.Close
   Set oRs = Nothing
   
   CalculaTotales

End Sub

Public Function ValorDiferenciaCambio() As Double

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim mDifer As Double
   
   Set oRs = origen.DetRecibos.TodosLosRegistros
   
   mDifer = 0
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If Not oRs.Fields("Eliminado").Value Then
               If Not IsNull(oRs.Fields("IdImputacion").Value) And _
                  Not IsNull(oRs.Fields("Importe").Value) And mvarCotizacion <> 0 Then
                  Set oRs1 = Aplicacion.DiferenciasCambio.TraerFiltrado("_ParaCalculoIndividualCobranzas", _
                        Array(oRs.Fields("IdImputacion").Value, mvarCotizacion, _
                              oRs.Fields("Importe").Value, dcfields(3).BoundText, _
                              txtCotizacionMoneda.Text))
                  If oRs1.RecordCount > 0 Then
                     If dcfields(3).BoundText = glbIdMonedaDolar Then
                        mDifer = mDifer + IIf(IsNull(oRs1.Fields("Dif.cambio u$s").Value), 0, oRs1.Fields("Dif.cambio u$s").Value)
                        lblDifCam.Caption = "Dif. cambio calculada (u$s):"
                     Else
                        mDifer = mDifer + IIf(IsNull(oRs1.Fields("Dif.cambio $").Value), 0, oRs1.Fields("Dif.cambio $").Value)
                        lblDifCam.Caption = "Dif. cambio calculada ($):"
                     End If
                  End If
                  oRs1.Close
                  Set oRs1 = Nothing
               End If
            End If
            oRs.MoveNext
         Loop
      End If
   End If
   
   Set oRs = Nothing

   ValorDiferenciaCambio = Round(mDifer, 2)

End Function

Public Sub AnularRecibo()

   If ExistenAnticiposAplicados() Then
      MsgBox "El recibo contiene anticipos que en cuenta corriente han sido aplicados." & vbCrLf & _
            "No puede anular este recibo", vbInformation
      Exit Sub
   End If
   
   Dim oRs As ADOR.Recordset
   Dim mError As String
   Set oRs = Aplicacion.Recibos.TraerFiltrado("_PorEstadoValores", mvarId)
   mError = ""
   If oRs.RecordCount > 0 Then
      mError = "El recibo no puede anularse porque tiene valores ingresados "
      Do While Not oRs.EOF
         If oRs.Fields("Estado").Value = "E" Then
            mError = mError & "endosados "
         ElseIf oRs.Fields("Estado").Value = "D" Then
            mError = mError & "depositados "
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   Set oRs = Nothing
   If Len(mError) > 0 Then
      MsgBox mError, vbInformation
      Exit Sub
   End If
   
   Dim oF As frmAutorizacion
   Dim mOk As Boolean
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.Recibos
      '.Administradores = True
      .Show vbModal, Me
      mOk = .Ok
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then
      Exit Sub
   End If
   
   Me.Refresh
   
   Dim mSeguro As Integer
   mSeguro = MsgBox("Esta seguro de anular el recibo ?", vbYesNo, "Anulacion de recibo de pago")
   If mSeguro = vbNo Then
      Exit Sub
   End If

   With origen
      .Registro.Fields("Anulado").Value = "OK"
      .Guardar
   End With

   Unload Me

End Sub

Public Function ExistenAnticiposAplicados()

   Dim oRs As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim mCambioAnticipo As Boolean
   
   mCambioAnticipo = False
   Set oRs = origen.DetRecibos.Registros
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If oRs.Fields(0).Value > 0 And oRs.Fields("IdImputacion").Value = -1 Then
               Set oRsAux = Aplicacion.CtasCtesD.TraerFiltrado("_PorDetalleRecibo", oRs.Fields(0).Value)
               If oRsAux.RecordCount > 0 Then
                  If oRsAux.Fields("ImporteTotal").Value <> oRsAux.Fields("Saldo").Value Then
                     mCambioAnticipo = True
                  End If
               Else
                  mCambioAnticipo = True
               End If
               oRsAux.Close
               If mCambioAnticipo Then Exit Do
            End If
            oRs.MoveNext
         Loop
      End If
   End If
   Set oRs = Nothing
   
   ExistenAnticiposAplicados = mCambioAnticipo

End Function

Private Function ValorModificable(Optional ByVal IdValor As Long, _
                                 Optional ByVal IdDetalleReciboValores As Long)

   Dim oRs As ADOR.Recordset
   Dim mValorModificable As Boolean
   
   mValorModificable = True
   
   If IdValor <> 0 Then
      Set oRs = Aplicacion.DepositosBancarios.TraerFiltrado("_DetallesPorIdValor", IdValor)
      If oRs.RecordCount > 0 Then
         mValorModificable = False
      End If
      oRs.Close
   ElseIf IdDetalleReciboValores <> 0 Then
      Set oRs = Aplicacion.Valores.TraerFiltrado("_DepositoDelValorPorIdDetalleReciboValores", IdDetalleReciboValores)
      If oRs.RecordCount > 0 Then
         mValorModificable = False
      End If
      oRs.Close
   End If
   Set oRs = Nothing
   
   ValorModificable = mValorModificable
   
End Function

Public Sub OtrosConceptosContables()

   Dim oF As frmRecibosOtrosConceptos
   
   Set oF = New frmRecibosOtrosConceptos
   With oF
      Set .Recibo = origen
      .Id = mvarId
      .Show vbModal, Me
   End With
   Unload oF
   Set oF = Nothing
   
   CalculaTotales
   
   If mvarTotalOtrosConceptos <> 0 Then
      cmd(2).BackColor = &HC0FFC0
   Else
      cmd(2).BackColor = &HC0C0FF
   End If

End Sub

Public Function ControlImputacionCliente() As Boolean

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim mIdImputacion As Long, mIdCliente As Long
   Dim mResul As Boolean
   
   mResul = True
   If Not Option1.Value Or Not IsNumeric(dcfields(0).BoundText) Then GoTo Salida
   mIdCliente = dcfields(0).BoundText
   
   Set oRs = origen.DetRecibos.Registros
   With oRs
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               If Not .Fields("Eliminado").Value Then
                  mIdImputacion = IIf(IsNull(.Fields("IdImputacion").Value), 0, .Fields("IdImputacion").Value)
                  If mIdImputacion > 0 Then
                     Set oRs1 = Aplicacion.CtasCtesD.TraerFiltrado("_PorId", mIdImputacion)
                     If oRs1.RecordCount > 0 Then
                        If oRs1.Fields("IdCliente").Value <> mIdCliente Then mResul = False
                     End If
                     oRs1.Close
                  End If
               End If
               .MoveNext
            Loop
         End If
      End If
   End With
   
   Set oRs = Nothing
   Set oRs1 = Nothing

Salida:
   ControlImputacionCliente = mResul

End Function
