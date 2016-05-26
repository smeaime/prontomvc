VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F09A78C8-7814-11D2-8355-4854E82A9183}#1.1#0"; "CUIT32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.4#0"; "Controles1013.ocx"
Begin VB.Form frmComprobantesPrv 
   Caption         =   "Comprobantes de proveedores"
   ClientHeight    =   8520
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11610
   Icon            =   "frmComprobantesPrv.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   8520
   ScaleWidth      =   11610
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtNumeroCAE 
      Alignment       =   2  'Center
      DataField       =   "NumeroCAE"
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
      Left            =   540
      TabIndex        =   160
      Top             =   7335
      Width           =   2460
   End
   Begin VB.CheckBox Check5 
      Height          =   195
      Left            =   9090
      TabIndex        =   159
      Top             =   8010
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox CheckAut 
      Enabled         =   0   'False
      Height          =   195
      Index           =   6
      Left            =   11295
      TabIndex        =   155
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox CheckAut 
      Enabled         =   0   'False
      Height          =   195
      Index           =   5
      Left            =   11070
      TabIndex        =   154
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox CheckAut 
      Enabled         =   0   'False
      Height          =   195
      Index           =   4
      Left            =   10845
      TabIndex        =   153
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox CheckAut 
      Enabled         =   0   'False
      Height          =   195
      Index           =   3
      Left            =   10620
      TabIndex        =   152
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox CheckAut 
      Enabled         =   0   'False
      Height          =   195
      Index           =   2
      Left            =   10395
      TabIndex        =   151
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox CheckAut 
      Enabled         =   0   'False
      Height          =   195
      Index           =   1
      Left            =   10170
      TabIndex        =   150
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CommandButton cmdImpre 
      Caption         =   "Informe Excel del comprobante"
      Height          =   285
      Left            =   810
      Style           =   1  'Graphical
      TabIndex        =   149
      Top             =   5805
      UseMaskColor    =   -1  'True
      Visible         =   0   'False
      Width           =   2355
   End
   Begin VB.CheckBox Check4 
      Alignment       =   1  'Right Justify
      Caption         =   "NO tomar este comprobante en cubo gastos"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   90
      TabIndex        =   148
      Top             =   5760
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.CommandButton cmdBuscarPorCuit 
      Appearance      =   0  'Flat
      BackColor       =   &H00E0E0E0&
      Caption         =   "Buscar x CUIT (F11)"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   5580
      MaskColor       =   &H00000000&
      Style           =   1  'Graphical
      TabIndex        =   147
      Top             =   1305
      Width           =   870
   End
   Begin VB.CheckBox Check3 
      Alignment       =   1  'Right Justify
      Caption         =   "Calcular dif. cambio :"
      Height          =   195
      Left            =   9810
      TabIndex        =   144
      Top             =   1755
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Anticipos"
      Height          =   240
      Index           =   6
      Left            =   4320
      Style           =   1  'Graphical
      TabIndex        =   143
      Top             =   7920
      Width           =   885
   End
   Begin VB.TextBox txtNumeroRendicionFF 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroRendicionFF"
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
      Left            =   5715
      TabIndex        =   137
      Top             =   1665
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Frame Frame4 
      Caption         =   "Dest.Pago"
      Height          =   870
      Left            =   4275
      TabIndex        =   134
      Top             =   6120
      Width           =   960
      Begin VB.OptionButton Option7 
         Caption         =   "Obra"
         Height          =   330
         Left            =   45
         TabIndex        =   136
         Top             =   450
         Width           =   825
      End
      Begin VB.OptionButton Option6 
         Caption         =   "Adm."
         Height          =   195
         Left            =   45
         TabIndex        =   135
         Top             =   225
         Width           =   690
      End
   End
   Begin VB.TextBox txtImputaComprobante 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   5490
      TabIndex        =   129
      Top             =   2385
      Visible         =   0   'False
      Width           =   915
   End
   Begin VB.CommandButton cmdImportaciones 
      Caption         =   "Ver datos de importacion"
      Height          =   285
      Left            =   1530
      TabIndex        =   128
      Top             =   2430
      Width           =   2040
   End
   Begin VB.CommandButton cmd 
      BackColor       =   &H00C0C0FF&
      Caption         =   "Reintegros"
      Height          =   240
      Index           =   5
      Left            =   4320
      Style           =   1  'Graphical
      TabIndex        =   126
      Top             =   7650
      Width           =   885
   End
   Begin VB.CommandButton cmdProvinciasDestino 
      Caption         =   "Distribuir IIBB x provincias"
      Height          =   285
      Left            =   1665
      TabIndex        =   124
      Top             =   2430
      Visible         =   0   'False
      Width           =   2040
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Eliminar comprobante"
      Height          =   510
      Index           =   4
      Left            =   3195
      TabIndex        =   123
      Top             =   7650
      Width           =   1080
   End
   Begin VB.TextBox txtFondoReparo 
      Alignment       =   1  'Right Justify
      DataField       =   "FondoReparo"
      Height          =   315
      Left            =   6570
      TabIndex        =   121
      Top             =   7605
      Visible         =   0   'False
      Width           =   1155
   End
   Begin VB.TextBox txtInformacionAuxiliar 
      DataField       =   "InformacionAuxiliar"
      Height          =   315
      Left            =   6570
      TabIndex        =   120
      Top             =   7245
      Visible         =   0   'False
      Width           =   1155
   End
   Begin VB.TextBox txtCondicionIva 
      Enabled         =   0   'False
      Height          =   330
      Left            =   7875
      TabIndex        =   112
      Top             =   1305
      Width           =   1800
   End
   Begin VB.TextBox txtCotizacionEuro 
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
      Height          =   315
      Left            =   6705
      TabIndex        =   109
      Top             =   6840
      Width           =   915
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Ver recepciones pendientes"
      Height          =   510
      Index           =   3
      Left            =   1800
      TabIndex        =   107
      Top             =   7650
      Width           =   1335
   End
   Begin VB.TextBox txtNumeroCAI 
      Alignment       =   2  'Center
      DataField       =   "NumeroCAI"
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
      Left            =   540
      TabIndex        =   85
      Top             =   7020
      Width           =   2460
   End
   Begin VB.Frame Frame3 
      Height          =   555
      Left            =   9720
      TabIndex        =   97
      Top             =   360
      Width           =   870
      Begin VB.OptionButton Option4 
         Caption         =   "Serv."
         Height          =   150
         Left            =   45
         TabIndex        =   99
         Top             =   360
         Width           =   690
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Bienes"
         Height          =   150
         Left            =   45
         TabIndex        =   98
         Top             =   135
         Width           =   780
      End
   End
   Begin VB.TextBox txtPorcentajeIVADirecto 
      Alignment       =   1  'Right Justify
      Height          =   315
      Left            =   9045
      TabIndex        =   81
      Top             =   5310
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.CheckBox Check2 
      Height          =   195
      Left            =   855
      TabIndex        =   93
      Top             =   5355
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CommandButton cmdIngresarItem 
      Caption         =   "FIN"
      Height          =   330
      Index           =   1
      Left            =   11160
      TabIndex        =   139
      Top             =   5310
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Ingreso rapido"
      Height          =   285
      Index           =   2
      Left            =   3285
      TabIndex        =   14
      Top             =   5805
      Width           =   1965
   End
   Begin VB.CommandButton cmdIngresarItem 
      Caption         =   "OK"
      Height          =   330
      Index           =   0
      Left            =   11160
      TabIndex        =   83
      Top             =   4950
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.TextBox txtImporteItem 
      Alignment       =   1  'Right Justify
      Height          =   315
      Left            =   10125
      TabIndex        =   82
      Top             =   5310
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.TextBox txtCuentaItem 
      Height          =   315
      Left            =   3060
      TabIndex        =   77
      Top             =   5310
      Visible         =   0   'False
      Width           =   615
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
      Left            =   6705
      TabIndex        =   64
      Top             =   6525
      Width           =   915
   End
   Begin VB.TextBox txtCotizacion 
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
      Height          =   285
      Left            =   10665
      TabIndex        =   62
      Top             =   450
      Width           =   900
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
      Left            =   6705
      TabIndex        =   60
      Top             =   6210
      Width           =   915
   End
   Begin VB.TextBox txtOrdenPago 
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
      Height          =   330
      Left            =   5535
      TabIndex        =   12
      Top             =   945
      Width           =   915
   End
   Begin VB.Frame Frame1 
      Height          =   285
      Left            =   1620
      TabIndex        =   52
      Top             =   945
      Width           =   2985
      Begin VB.OptionButton Option5 
         Caption         =   "Otros"
         Height          =   195
         Left            =   2205
         TabIndex        =   131
         Top             =   90
         Width           =   735
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Cta.Cte."
         Height          =   195
         Left            =   90
         TabIndex        =   54
         Top             =   90
         Width           =   960
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Fondo fijo"
         Height          =   195
         Left            =   1125
         TabIndex        =   53
         Top             =   90
         Width           =   1050
      End
   End
   Begin VB.TextBox txtDiasVencimiento 
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
      Left            =   10170
      TabIndex        =   6
      Top             =   45
      Width           =   420
   End
   Begin VB.TextBox txtNumeroComprobante2 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroComprobante2"
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
      Left            =   2640
      TabIndex        =   3
      Top             =   450
      Width           =   1200
   End
   Begin VB.TextBox txtNumeroComprobante1 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroComprobante1"
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
      Left            =   1950
      TabIndex        =   2
      Top             =   450
      Width           =   630
   End
   Begin VB.TextBox txtLetra 
      Alignment       =   2  'Center
      DataField       =   "Letra"
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
      Left            =   1590
      TabIndex        =   1
      Top             =   450
      Width           =   300
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
      Index           =   0
      Left            =   9705
      TabIndex        =   28
      Top             =   5895
      Width           =   1635
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   510
      Index           =   0
      Left            =   45
      TabIndex        =   86
      Top             =   7650
      Width           =   840
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   510
      Index           =   1
      Left            =   945
      TabIndex        =   15
      Top             =   7650
      Width           =   795
   End
   Begin VB.TextBox txtTelefono 
      Enabled         =   0   'False
      Height          =   330
      Left            =   7875
      TabIndex        =   27
      Top             =   1665
      Width           =   1800
   End
   Begin VB.TextBox txtEmail 
      Enabled         =   0   'False
      Height          =   330
      Left            =   9675
      TabIndex        =   26
      Top             =   1665
      Width           =   1800
   End
   Begin VB.TextBox txtCuit 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      Height          =   315
      Left            =   10080
      TabIndex        =   25
      Top             =   945
      Width           =   1350
   End
   Begin VB.TextBox txtLocalidad 
      Enabled         =   0   'False
      Height          =   315
      Left            =   2205
      TabIndex        =   23
      Top             =   2025
      Width           =   2820
   End
   Begin VB.TextBox txtProvincia 
      Enabled         =   0   'False
      Height          =   315
      Left            =   5070
      TabIndex        =   22
      Top             =   2025
      Width           =   1380
   End
   Begin VB.TextBox txtCodigoPostal 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   315
      Left            =   1140
      TabIndex        =   21
      Top             =   2025
      Width           =   990
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
      Index           =   1
      Left            =   9705
      TabIndex        =   20
      Top             =   6210
      Width           =   1635
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
      Index           =   2
      Left            =   9705
      TabIndex        =   19
      Top             =   6540
      Width           =   1635
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
      Left            =   9705
      TabIndex        =   18
      Top             =   6870
      Width           =   1635
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
      Index           =   4
      Left            =   9705
      TabIndex        =   17
      Top             =   7200
      Width           =   1635
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
      Index           =   5
      Left            =   9705
      TabIndex        =   16
      Top             =   7605
      Width           =   1635
   End
   Begin VB.TextBox txtCodigoProveedor 
      Height          =   315
      Left            =   1140
      TabIndex        =   13
      Top             =   1305
      Width           =   930
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   29
      Top             =   8235
      Width           =   11610
      _ExtentX        =   20479
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaComprobante"
      Height          =   285
      Index           =   0
      Left            =   8460
      TabIndex        =   0
      Top             =   0
      Width           =   1230
      _ExtentX        =   2170
      _ExtentY        =   503
      _Version        =   393216
      Format          =   52101121
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   0
      Left            =   2115
      TabIndex        =   7
      Tag             =   "Proveedores"
      Top             =   1305
      Width           =   3390
      _ExtentX        =   5980
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   855
      Left            =   45
      TabIndex        =   9
      Top             =   6120
      Width           =   4200
      _ExtentX        =   7408
      _ExtentY        =   1508
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmComprobantesPrv.frx":076A
   End
   Begin Controles1013.DbListView Lista 
      Height          =   2130
      Left            =   45
      TabIndex        =   30
      Top             =   2760
      Width           =   11505
      _ExtentX        =   20294
      _ExtentY        =   3757
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmComprobantesPrv.frx":07EC
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaRecepcion"
      Height          =   285
      Index           =   1
      Left            =   8460
      TabIndex        =   4
      Top             =   315
      Width           =   1230
      _ExtentX        =   2170
      _ExtentY        =   503
      _Version        =   393216
      Format          =   52101121
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaVencimiento"
      Height          =   285
      Index           =   2
      Left            =   8460
      TabIndex        =   5
      Top             =   630
      Width           =   1230
      _ExtentX        =   2170
      _ExtentY        =   503
      _Version        =   393216
      Format          =   52101121
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   2
      Left            =   7875
      TabIndex        =   8
      Tag             =   "Obras"
      Top             =   945
      Width           =   1680
      _ExtentX        =   2963
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   3
      Left            =   6255
      TabIndex        =   58
      Tag             =   "Monedas"
      Top             =   5850
      Width           =   1365
      _ExtentX        =   2408
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   3330
      Top             =   7830
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
            Picture         =   "frmComprobantesPrv.frx":0808
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmComprobantesPrv.frx":091A
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmComprobantesPrv.frx":0D6C
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmComprobantesPrv.frx":11BE
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   3690
      TabIndex        =   78
      Tag             =   "Cuentas"
      Top             =   5310
      Visible         =   0   'False
      Width           =   2490
      _ExtentX        =   4392
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   2
      Left            =   855
      TabIndex        =   74
      Tag             =   "Obras"
      Top             =   4950
      Visible         =   0   'False
      Width           =   2130
      _ExtentX        =   3757
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   1
      Left            =   1080
      TabIndex        =   75
      Tag             =   "CuentasGastos"
      Top             =   5310
      Visible         =   0   'False
      Width           =   1905
      _ExtentX        =   3360
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaGasto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   3
      Left            =   4230
      TabIndex        =   76
      Tag             =   "TiposCuentaGrupos"
      Top             =   4950
      Visible         =   0   'False
      Width           =   1950
      _ExtentX        =   3440
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoCuentaGrupo"
      Text            =   ""
   End
   Begin VB.Frame Frame2 
      Caption         =   "IVA :"
      Height          =   690
      Left            =   6210
      TabIndex        =   79
      Top             =   4950
      Visible         =   0   'False
      Width           =   3840
      Begin VB.CheckBox Check1 
         Height          =   195
         Index           =   9
         Left            =   3015
         TabIndex        =   73
         Top             =   450
         Width           =   735
      End
      Begin VB.CheckBox Check1 
         Height          =   195
         Index           =   8
         Left            =   2295
         TabIndex        =   72
         Top             =   450
         Width           =   735
      End
      Begin VB.CheckBox Check1 
         Height          =   195
         Index           =   7
         Left            =   1575
         TabIndex        =   71
         Top             =   450
         Width           =   735
      End
      Begin VB.CheckBox Check1 
         Height          =   195
         Index           =   6
         Left            =   810
         TabIndex        =   70
         Top             =   450
         Width           =   735
      End
      Begin VB.CheckBox Check1 
         Height          =   195
         Index           =   5
         Left            =   45
         TabIndex        =   69
         Top             =   450
         Width           =   735
      End
      Begin VB.CheckBox Check1 
         Height          =   195
         Index           =   4
         Left            =   3015
         TabIndex        =   68
         Top             =   225
         Width           =   735
      End
      Begin VB.CheckBox Check1 
         Height          =   195
         Index           =   3
         Left            =   2295
         TabIndex        =   67
         Top             =   225
         Width           =   735
      End
      Begin VB.CheckBox Check1 
         Height          =   195
         Index           =   2
         Left            =   1575
         TabIndex        =   66
         Top             =   225
         Width           =   735
      End
      Begin VB.CheckBox Check1 
         Height          =   195
         Index           =   1
         Left            =   810
         TabIndex        =   65
         Top             =   225
         Width           =   735
      End
      Begin VB.CheckBox Check1 
         Height          =   195
         Index           =   0
         Left            =   45
         TabIndex        =   80
         Top             =   225
         Width           =   735
      End
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaBancaria"
      Height          =   315
      Index           =   4
      Left            =   4545
      TabIndex        =   95
      Tag             =   "CuentasBancarias"
      Top             =   2385
      Visible         =   0   'False
      Width           =   1875
      _ExtentX        =   3307
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaBancaria"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdIBCondicion"
      Height          =   315
      Index           =   4
      Left            =   7875
      TabIndex        =   100
      Tag             =   "IBCondiciones"
      Top             =   2385
      Width           =   2085
      _ExtentX        =   3678
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdIBCondicion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdTipoRetencionGanancia"
      Height          =   315
      Index           =   6
      Left            =   7875
      TabIndex        =   102
      Tag             =   "TiposRetencionGanancia"
      Top             =   2025
      Width           =   2085
      _ExtentX        =   3678
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoRetencionGanancia"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaVencimientoCAI"
      Height          =   330
      Index           =   3
      Left            =   3735
      TabIndex        =   88
      Top             =   7020
      Width           =   1500
      _ExtentX        =   2646
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   52101121
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdTipoComprobante"
      Height          =   315
      Index           =   1
      Left            =   4680
      TabIndex        =   11
      Tag             =   "TiposComprobante"
      Top             =   90
      Width           =   2250
      _ExtentX        =   3969
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoComprobante"
      Text            =   ""
   End
   Begin VB.TextBox txtNumeroReferencia 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroReferencia"
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
      Height          =   330
      Left            =   1590
      TabIndex        =   10
      Top             =   45
      Width           =   1455
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCondicionCompra"
      Height          =   315
      Index           =   7
      Left            =   3915
      TabIndex        =   111
      Tag             =   "CondicionesCompra"
      Top             =   585
      Width           =   2985
      _ExtentX        =   5265
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCondicionCompra"
      Text            =   ""
   End
   Begin VB.TextBox txtGravadoParaSUSS 
      Alignment       =   1  'Right Justify
      DataField       =   "GravadoParaSUSS"
      Height          =   270
      Left            =   6930
      TabIndex        =   118
      Top             =   8055
      Visible         =   0   'False
      Width           =   1155
   End
   Begin VB.TextBox txtPorcentajeParaSUSS 
      Alignment       =   1  'Right Justify
      DataField       =   "PorcentajeParaSUSS"
      Height          =   270
      Left            =   4050
      TabIndex        =   119
      Top             =   7425
      Visible         =   0   'False
      Width           =   1155
   End
   Begin VB.TextBox txtProveedorEventual 
      Height          =   315
      Left            =   4365
      Locked          =   -1  'True
      TabIndex        =   56
      Top             =   7740
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.TextBox txtCuenta 
      Height          =   315
      Left            =   4815
      Locked          =   -1  'True
      TabIndex        =   92
      Top             =   7740
      Visible         =   0   'False
      Width           =   390
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCodigoIva"
      Height          =   315
      Index           =   8
      Left            =   9705
      TabIndex        =   122
      Tag             =   "DescripcionIva"
      Top             =   1305
      Width           =   1770
      _ExtentX        =   3122
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCodigoIva"
      Text            =   ""
   End
   Begin VB.TextBox txtCuentaOtros 
      Height          =   315
      Left            =   1125
      TabIndex        =   132
      Top             =   2385
      Visible         =   0   'False
      Width           =   930
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCuentaOtros"
      Height          =   315
      Index           =   5
      Left            =   2295
      TabIndex        =   133
      Tag             =   "Cuentas"
      Top             =   2385
      Width           =   4335
      _ExtentX        =   7646
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin VB.TextBox txtDireccion 
      Enabled         =   0   'False
      Height          =   315
      Left            =   1155
      TabIndex        =   24
      Top             =   1665
      Width           =   5295
   End
   Begin Control_CUIT.CUIT CUIT1 
      Height          =   285
      Left            =   10080
      TabIndex        =   140
      Top             =   1080
      Visible         =   0   'False
      Width           =   1545
      _ExtentX        =   2725
      _ExtentY        =   503
      Text            =   ""
      MensajeErr      =   "CUIT incorrecto"
      otrosP          =   -1  'True
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaAsignacionPresupuesto"
      Height          =   285
      Index           =   4
      Left            =   6570
      TabIndex        =   141
      Top             =   7740
      Visible         =   0   'False
      Width           =   1230
      _ExtentX        =   2170
      _ExtentY        =   503
      _Version        =   393216
      Format          =   52101121
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdListaPrecios"
      Height          =   315
      Index           =   9
      Left            =   2520
      TabIndex        =   145
      Tag             =   "ListasPrecios"
      Top             =   720
      Visible         =   0   'False
      Width           =   1230
      _ExtentX        =   2170
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdListaPrecios"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdLiquidacionFlete"
      Height          =   315
      Index           =   10
      Left            =   9270
      TabIndex        =   157
      Tag             =   "LiquidacionesFletes"
      Top             =   8010
      Visible         =   0   'False
      Width           =   1230
      _ExtentX        =   2170
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdLiquidacionFlete"
      Text            =   ""
   End
   Begin VB.Label lblCAE1 
      Caption         =   "CAE :"
      Height          =   195
      Left            =   90
      TabIndex        =   161
      Top             =   7380
      Width           =   405
   End
   Begin VB.Label lblFleteros 
      Caption         =   "Nro.Liq.Fletes :"
      Height          =   240
      Left            =   8010
      TabIndex        =   158
      Top             =   8010
      Visible         =   0   'False
      Width           =   1080
   End
   Begin VB.Label lblAutorizaciones 
      Caption         =   "Autorizaciones : "
      Height          =   240
      Left            =   10215
      TabIndex        =   156
      Top             =   2115
      Width           =   1260
   End
   Begin VB.Label lblData 
      Caption         =   "Lista :"
      Height          =   285
      Index           =   9
      Left            =   2025
      TabIndex        =   146
      Top             =   720
      Visible         =   0   'False
      Width           =   450
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha asig.presup."
      Height          =   240
      Index           =   20
      Left            =   5130
      TabIndex        =   142
      Top             =   7830
      Visible         =   0   'False
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro. Rend.:"
      Height          =   240
      Index           =   19
      Left            =   4750
      TabIndex        =   138
      Top             =   1710
      Visible         =   0   'False
      Width           =   900
   End
   Begin VB.Label lblLabels 
      Caption         =   "Imputa comp.:"
      Height          =   195
      Index           =   12
      Left            =   4365
      TabIndex        =   130
      Top             =   2430
      Visible         =   0   'False
      Width           =   1035
   End
   Begin VB.Label lblEstado 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "MODO CODIGO DE BARRA"
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
      Left            =   90
      TabIndex        =   127
      Top             =   5760
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuentas :"
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
      Index           =   7
      Left            =   90
      TabIndex        =   125
      Top             =   2565
      Width           =   825
   End
   Begin VB.Label Label2 
      Caption         =   "Fondo reparo :"
      Height          =   240
      Left            =   5310
      TabIndex        =   117
      Top             =   7650
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.Label lblAuxiliar2 
      Caption         =   "Gravado SUSS:"
      Height          =   240
      Left            =   5670
      TabIndex        =   115
      Top             =   8100
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.Label lblAuxiliar1 
      Caption         =   "Codigo comp. :"
      Height          =   240
      Left            =   5310
      TabIndex        =   114
      Top             =   7290
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.Label lblData 
      Caption         =   "Condicion de compra :"
      Height          =   195
      Index           =   3
      Left            =   3915
      TabIndex        =   113
      Top             =   405
      Width           =   1605
   End
   Begin VB.Line Line6 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   3
      X1              =   7695
      X2              =   7695
      Y1              =   5805
      Y2              =   7200
   End
   Begin VB.Line Line6 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   2
      X1              =   5310
      X2              =   5310
      Y1              =   5805
      Y2              =   7200
   End
   Begin VB.Line Line6 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   1
      X1              =   5310
      X2              =   7695
      Y1              =   7200
      Y2              =   7200
   End
   Begin VB.Line Line6 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   0
      X1              =   5310
      X2              =   7695
      Y1              =   5805
      Y2              =   5805
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cotizacion euro :"
      Height          =   240
      Index           =   24
      Left            =   5400
      TabIndex        =   110
      Top             =   6885
      Width           =   1245
   End
   Begin VB.Label lblTabIndex 
      BackColor       =   &H00C0C0FF&
      Height          =   150
      Left            =   0
      TabIndex        =   108
      Top             =   0
      Width           =   105
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha recepcion :"
      Height          =   240
      Index           =   3
      Left            =   7020
      TabIndex        =   48
      Top             =   360
      Width           =   1395
   End
   Begin VB.Label lblComprobante 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      Caption         =   "Label2"
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
      Left            =   3150
      TabIndex        =   106
      Top             =   315
      Visible         =   0   'False
      Width           =   3750
   End
   Begin VB.Label lblCAI2 
      Caption         =   "Vto.CAI : "
      Height          =   240
      Left            =   3060
      TabIndex        =   105
      Top             =   7065
      Width           =   675
   End
   Begin VB.Label lblCAI1 
      Caption         =   "CAI :"
      Height          =   240
      Left            =   90
      TabIndex        =   104
      Top             =   7065
      Width           =   405
   End
   Begin VB.Label lblData 
      Caption         =   "Categ. Ganan. :"
      Height          =   240
      Index           =   2
      Left            =   6615
      TabIndex        =   103
      Top             =   2070
      Width           =   1170
   End
   Begin VB.Label lblData 
      Caption         =   "Categ. IIBB :"
      Height          =   240
      Index           =   1
      Left            =   6630
      TabIndex        =   101
      Top             =   2430
      Width           =   1170
   End
   Begin VB.Label lblCuentaBanco 
      Caption         =   "Cta.Bco.:"
      Height          =   255
      Left            =   3780
      TabIndex        =   96
      Top             =   2430
      Visible         =   0   'False
      Width           =   690
   End
   Begin VB.Label lblItem 
      AutoSize        =   -1  'True
      Caption         =   "% Iva :"
      Height          =   195
      Index           =   4
      Left            =   9090
      TabIndex        =   94
      Top             =   5040
      Width           =   480
   End
   Begin VB.Label lblItem 
      AutoSize        =   -1  'True
      Caption         =   "Cta.gasto : "
      Height          =   240
      Index           =   3
      Left            =   45
      TabIndex        =   91
      Top             =   5355
      Width           =   750
   End
   Begin VB.Label lblItem 
      AutoSize        =   -1  'True
      Caption         =   "Obra : "
      Height          =   240
      Index           =   0
      Left            =   45
      TabIndex        =   90
      Top             =   4995
      Width           =   750
   End
   Begin VB.Label lblItem 
      AutoSize        =   -1  'True
      Caption         =   "Importe : "
      Height          =   240
      Index           =   2
      Left            =   10170
      TabIndex        =   89
      Top             =   5040
      Width           =   615
   End
   Begin VB.Label lblItem 
      Caption         =   "Cta cont./Filtro:"
      Height          =   240
      Index           =   1
      Left            =   3060
      TabIndex        =   87
      Top             =   4995
      Width           =   1095
   End
   Begin VB.Line Line5 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Visible         =   0   'False
      X1              =   0
      X2              =   11610
      Y1              =   5715
      Y2              =   5715
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cotizacion dolar :"
      Height          =   240
      Index           =   18
      Left            =   5400
      TabIndex        =   84
      Top             =   6570
      Width           =   1245
   End
   Begin VB.Line Line3 
      BorderWidth     =   2
      X1              =   11610
      X2              =   10620
      Y1              =   810
      Y2              =   810
   End
   Begin VB.Label lblLabels 
      Alignment       =   2  'Center
      Caption         =   "Cotizacion u$s tomada"
      Height          =   420
      Index           =   16
      Left            =   10665
      TabIndex        =   63
      Top             =   0
      Width           =   915
   End
   Begin VB.Line Line4 
      BorderWidth     =   2
      X1              =   10620
      X2              =   10620
      Y1              =   -45
      Y2              =   810
   End
   Begin VB.Label lblLabels 
      Caption         =   "Conversion a $ :"
      Height          =   240
      Index           =   15
      Left            =   5400
      TabIndex        =   61
      Top             =   6255
      Width           =   1245
   End
   Begin VB.Label lblLabels 
      Caption         =   "Moneda :"
      Height          =   240
      Index           =   23
      Left            =   5400
      TabIndex        =   59
      Top             =   5895
      Width           =   735
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro. Vale:"
      Height          =   240
      Index           =   14
      Left            =   4725
      TabIndex        =   57
      Top             =   990
      Width           =   765
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tipo comprobante :"
      Height          =   285
      Index           =   13
      Left            =   105
      TabIndex        =   55
      Top             =   945
      Width           =   1395
   End
   Begin VB.Label lblData 
      Caption         =   "Obra :"
      Height          =   240
      Index           =   0
      Left            =   6630
      TabIndex        =   51
      Top             =   990
      Width           =   1170
   End
   Begin VB.Label lblLabels 
      Caption         =   "Dias :"
      Height          =   240
      Index           =   9
      Left            =   9720
      TabIndex        =   50
      Top             =   45
      Width           =   390
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha vencimiento:"
      Height          =   240
      Index           =   8
      Left            =   7020
      TabIndex        =   49
      Top             =   675
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro. comprobante :"
      Height          =   330
      Index           =   5
      Left            =   105
      TabIndex        =   47
      Top             =   480
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tipo comprobante :"
      Height          =   240
      Index           =   1
      Left            =   3195
      TabIndex        =   46
      Top             =   135
      Width           =   1395
   End
   Begin VB.Line Line1 
      BorderWidth     =   3
      X1              =   7800
      X2              =   11280
      Y1              =   5820
      Y2              =   5820
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tel. / Email :"
      Height          =   285
      Index           =   0
      Left            =   6630
      TabIndex        =   45
      Top             =   1695
      Width           =   1170
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero referencia :"
      Height          =   285
      Index           =   21
      Left            =   105
      TabIndex        =   44
      Top             =   90
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha comprob. :"
      Height          =   240
      Index           =   22
      Left            =   7005
      TabIndex        =   43
      Top             =   45
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Cuit :"
      Height          =   240
      Index           =   6
      Left            =   9630
      TabIndex        =   42
      Top             =   990
      Width           =   390
   End
   Begin VB.Label lblLabels 
      Caption         =   "Proveedor :"
      Height          =   240
      Index           =   2
      Left            =   105
      TabIndex        =   41
      Top             =   1350
      Width           =   945
   End
   Begin VB.Label lblLabels 
      Caption         =   "Dirección :"
      Height          =   285
      Index           =   10
      Left            =   105
      TabIndex        =   40
      Top             =   1695
      Width           =   945
   End
   Begin VB.Label lblLabels 
      Caption         =   "Loc./Prov. :"
      Height          =   240
      Index           =   11
      Left            =   105
      TabIndex        =   39
      Top             =   2070
      Width           =   945
   End
   Begin VB.Label Label1 
      Caption         =   "Subtotal :"
      Height          =   285
      Left            =   7815
      TabIndex        =   38
      Top             =   5895
      Width           =   1860
   End
   Begin VB.Label lblIVA1 
      Caption         =   "Total IVA :"
      Height          =   285
      Left            =   7815
      TabIndex        =   37
      Top             =   6225
      Width           =   1860
   End
   Begin VB.Label lblIVA2 
      Height          =   285
      Left            =   7815
      TabIndex        =   36
      Top             =   6555
      Width           =   1860
   End
   Begin VB.Label Label4 
      Caption         =   "Ajuste IVA :"
      Height          =   285
      Left            =   7815
      TabIndex        =   35
      Top             =   6885
      Width           =   1860
   End
   Begin VB.Label Label5 
      Height          =   285
      Left            =   7815
      TabIndex        =   34
      Top             =   7215
      Width           =   1860
   End
   Begin VB.Label Label6 
      BackColor       =   &H00FFFFFF&
      Caption         =   "TOTAL COMPR.:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000010&
      Height          =   330
      Left            =   7815
      TabIndex        =   33
      Top             =   7605
      Width           =   1860
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   3
      X1              =   9705
      X2              =   11295
      Y1              =   7560
      Y2              =   7560
   End
   Begin VB.Label lblLabels 
      Caption         =   "Condicion IVA :"
      Height          =   285
      Index           =   4
      Left            =   6630
      TabIndex        =   32
      Top             =   1305
      Width           =   1170
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Obs.:"
      Height          =   195
      Index           =   17
      Left            =   90
      TabIndex        =   31
      Top             =   5940
      Width           =   375
   End
   Begin VB.Label lblAuxiliar3 
      Caption         =   "Porc. SUSS :"
      Height          =   240
      Left            =   2790
      TabIndex        =   116
      Top             =   7470
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   2
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar rubro financiero"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Distribuir gastos por obra (matriz)"
         Index           =   4
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Duplicar item"
         Index           =   5
      End
   End
End
Attribute VB_Name = "frmComprobantesPrv"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.ComprobanteProveedor
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim WithEvents ActL3 As ControlForm
Attribute ActL3.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private oF_BuscarPorCuit As frm_Aux
Private mvarId As Long
Private cALetra As New clsNum2Let
Private mvarGrabado As Boolean, mSenialIVA As Boolean, mCondicionDesdePedido As Boolean, mvarModoCodigoBarra As Boolean
Private mvarLeyoCodigoBarra As Boolean, mvarGrabacionAutomatica As Boolean, mvarPrimeraVez As Boolean
Private mActivarCamposParaFF As Boolean, mActivarCamposParaFF1 As Boolean
Private mvarTipoABC As String, mvarExigirCAI As String, mCadena As String, mvarConfirmado As String, mvarExigirCAIComp As String
Private mvarAnticipo_O_Devolucion As String
Private mvarP_IVA1 As Double, mvarP_IVA2 As Double, mvarIVA1 As Double, mvarIVA2 As Double, mvarIVANoDiscriminado As Double
Private mvarDecimales As Double, mvarCotizacion As Double, mvarTotalComprobanteProveedor As Double, mvarSubTotal As Double
Private mvarCotizacionEuro As Double, mvarAjusteIVA As Double, mvarCotizacionDolar As Double
Private mvarIVAs(10, 1) As Double
Private mvarPorcentajeAnticipo As Single
Private mvarTipoIVA As Integer, mvarIdProveedor As Integer, mvarIdTipoCuentaGrupoIVA As Integer, mvarIdMonedaDolar As Integer
Private mvarIdMonedaPesos As Integer, mvarIdMonedaOP_FF As Integer, mvarIdTipoComprobanteNDInternaAcreedores As Integer
Private mvarIdTipoComprobanteNCInternaAcreedores As Integer, mNivelAcceso As Integer, mvarTipoProveedor As Integer
Private mOpcionesAcceso As String, mvarIdTipoComprobanteFacturaCompraExportacion As Integer, mvarIdProvinciaDestino As Integer
Private mvarIdComprobanteImputado As Long, mvarIdComprobanteAnterior As Long, mvarIdPedido As Long, mvarIdCuentaContable As Long
Private mvarControlarRubrosContablesEnCP As String

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

   On Error GoTo Mal
   
   Dim oF As frmDetComprobantesProveedores
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   
   Set oF = New frmDetComprobantesProveedores
   With oF
      Set .ComprobanteProveedor = origen
      .IdTipoCuentaGrupoIVA = mvarIdTipoCuentaGrupoIVA
      .Obra = IIf(IsNumeric(dcfields(2).BoundText), dcfields(2).BoundText, -1)
      .Letra = txtLetra.Text
      .IdProvinciaDestino = mvarIdProvinciaDestino
      .FechaComprobante = DTFields(1).Value
      .IdPedidoAnticipo = Me.IdPedidoAnticipo
      .PorcentajeAnticipo = Me.PorcentajeAnticipo
      .IdCuentaContable = Me.IdCuentaContable
      If Me.Anticipo_O_Devolucion = "C" Then
         .Anticipo_O_Devolucion = "C1"
      Else
         .Anticipo_O_Devolucion = Me.Anticipo_O_Devolucion
      End If
      .Id = Cual
      If glbIdObraAsignadaUsuario <> -1 Then
         .DataCombo1(2).Enabled = False
         .DataCombo1(3).Enabled = False
         .txtCodigoCuenta.Enabled = False
      End If
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = Lista.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = Lista.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtCodigoCuenta.Text
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorCodigo", Array(oF.txtCodigoCuenta.Text, DTFields(1).Value))
            If oRs.RecordCount > 0 Then
               .SubItems(1) = "" & oRs.Fields("Descripcion").Value
            Else
               .SubItems(1) = ""
            End If
            oRs.Close
            Set oRs = Nothing
            .SubItems(2) = "" & oF.DataCombo1(2).Text
            .SubItems(3) = "" & oF.CadenaIVA
            .SubItems(4) = "" & Format(oF.TotalIva, "#0.00")
            .SubItems(5) = "" & Format(oF.txtImporte.Text, "#0.00")
            .SubItems(9) = "" & oF.DataCombo1(9).Text
            .SubItems(10) = "" & oF.txtCantidad.Text
            .SubItems(11) = "" & oF.txtNumeroPedido.Text
            .SubItems(12) = "" & oF.txtItemPedido.Text
            .SubItems(13) = "" & oF.DataCombo1(5).Text
         End With
         origen.DetComprobantesProveedores.Item(oL.Tag).Registro.Fields("Item").Value = Lista.ListItems.Count
      End If
   
      If Me.Anticipo_O_Devolucion = "C" Then
         Me.Anticipo_O_Devolucion = "C2"
         Editar -1
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing

   CalculaComprobanteProveedor

Salida:

   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

End Sub

Private Sub ActL3_ActLista(ByVal IdRegistro As Long, ByVal TipoAccion As EnumAcciones, ByVal NombreListaEditada As String, ByVal mvarIdRegistroOriginal As Long)

   dcfields(0).BoundText = IdRegistro

End Sub

Private Sub Check1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Check2_Click()

   If Check2.Value = 0 Then
      Dim mIdCuenta As Long
      Dim mAuxS1 As String
      DataCombo1(1).BoundText = 0
      If Not glbIdCuentaFFUsuario <> -1 Then txtCuentaItem.Enabled = True
      mIdCuenta = 0
      With DataCombo1(0)
         If IsNumeric(.BoundText) Then mIdCuenta = .BoundText
         If glbIdCuentaFFUsuario <> -1 Then
            Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorGrupoParaCombo", mvarIdTipoCuentaGrupoIVA)
            If mActivarCamposParaFF Then
               mAuxS1 = BuscarClaveINI("Grupos de cuenta para ingreso por FF")
               If Len(mAuxS1) > 0 Then
                  Set DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorGruposParaCombo", mAuxS1)
               End If
            End If
         Else
            If glbSeñal1 Then
               Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorFechaParaCombo", DTFields(1).Value)
            Else
               Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_ParaComprobantesProveedores")
            End If
         End If
         .BoundText = mIdCuenta
         .Enabled = True
      End With
      With DataCombo1(3)
         .BoundText = 0
         .Enabled = True
      End With
   End If
   
End Sub

Private Sub Check5_Click()

   If Check5.Value = 0 Then origen.Registro.Fields("IdLiquidacionFlete").Value = Null

End Sub

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
      Case 0
         If DTFields(1).Value <= gblFechaUltimoCierre And _
               Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(1).Value) Then
            MsgBox "La fecha no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation
            Exit Sub
         End If

         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim mvarNumero As Long, mvarRegistros As Long, mvarIdOriginal As Long, mIdProv As Long
         Dim mvarConfirma As Integer, mvarSeguro As Integer, i As Integer
         Dim mvarMonedaOP_FF As String, mvarError As String, mAuxS1 As String, mAuxS2 As String, mAuxS3 As String
         Dim mADistribuir As String, mJerarquia As String
         Dim mPorcentajeIVAParaMonotributistas As Double, mImporteItem As Double, mImporte As Double
         Dim mPorcentajeTolerancia As Single, mCotizacionMoneda As Single
         Dim mOk As Boolean
         Dim oRs As ADOR.Recordset
         Dim oRs1 As ADOR.Recordset
         Dim oF As frm_Aux
     
         If Len(txtNumeroReferencia.Text) = 0 And Not mvarId > 0 Then
            MsgBox "No ingreso el numero de referencia del comprobante", vbInformation
            Exit Sub
         End If
         
         If txtLetra.Text <> "C" And _
               Not (dcfields(1).BoundText = mvarIdTipoComprobanteNDInternaAcreedores Or _
                  dcfields(1).BoundText = mvarIdTipoComprobanteNCInternaAcreedores) And mvarTipoProveedor <> 3 Then
            If ((Len(txtNumeroCAI.Text) = 0 Or Trim(txtNumeroCAI.Text) = "0") And Not BuscarClaveINI("Desactivar control de CAI en comprobantes de proveedores") = "SI") And _
                  mvarExigirCAI = "SI" And mvarExigirCAIComp = "SI" And Len(txtNumeroCAE.Text) = 0 Then
               MsgBox "Debe ingresar el numero de CAI del comprobante", vbInformation
               Exit Sub
            ElseIf Len(txtNumeroCAI.Text) > 14 Then
               MsgBox "El numero de CAI del comprobante debe tener 14 digitos o menos", vbInformation
               Exit Sub
            End If
            If mvarExigirCAI = "SI" And mvarExigirCAIComp = "SI" And Len(txtNumeroCAE.Text) = 0 Then
               If origen.Registro.Fields("IdTipoComprobante").Value = 42 Or Val(txtNumeroCAI.Text) = 0 Then
                  If IsNull(DTFields(3).Value) Or DTFields(3).Value < DTFields(0).Value Then DTFields(3).Value = Date
               End If
               If IsNull(DTFields(3).Value) Then
                  MsgBox "Debe ingresar la fecha de vencimiento del CAI", vbInformation
                  Exit Sub
               End If
               If DTFields(3).Value < DTFields(0).Value Then
                  MsgBox "El CAI esta vencido, no puede registrar el comprobante", vbInformation
                  Exit Sub
               End If
            End If
         End If
         
         If mvarCotizacion = 0 Then
            mvarCotizacion = Cotizacion(DTFields(1).Value, glbIdMonedaDolar)
            txtCotizacion.Text = mvarCotizacion
            If (mvarId <= 0 Or origen.Registro.Fields("Confirmado").Value = "NO") And mvarCotizacion <> 0 And Val(txtCotizacionDolar.Text) = 0 Then
               txtCotizacionDolar.Text = mvarCotizacion
            End If
         End If
         
         If Val(txtCotizacionDolar.Text) = 0 Then
            mvarConfirma = MsgBox("La cotizacion dolar esta en cero, si el comprobante es por" & vbCrLf & _
                                 "diferencia de cambio estaria correcto, de lo contrario" & vbCrLf & _
                                 "puede ingresarla sin salir del formulario en cotizaciones." & vbCrLf & _
                                 "Desea grabar el comprobante con cotizacion dolar en cero?", vbYesNo, "Cotizacion dolar")
            If mvarConfirma = vbNo Then Exit Sub
         End If
         
         If mvarCotizacionEuro = 0 Then
            mvarCotizacionEuro = Cotizacion(DTFields(1).Value, glbIdMonedaEuro)
            If (mvarId <= 0 Or origen.Registro.Fields("Confirmado").Value = "NO") And mvarCotizacionEuro <> 0 And Val(txtCotizacionEuro.Text) = 0 Then
               txtCotizacionEuro.Text = mvarCotizacionEuro
            End If
         End If
         
         If Val(txtCotizacionEuro.Text) = 0 Then
            mvarConfirma = MsgBox("La cotizacion euro esta en cero, si el comprobante es por" & vbCrLf & _
                                 "diferencia de cambio estaria correcto, de lo contrario" & vbCrLf & _
                                 "puede ingresarla sin salir del formulario en cotizaciones." & vbCrLf & _
                                 "Desea grabar el comprobante con cotizacion euro en cero?", vbYesNo, "Cotizacion euro")
            If mvarConfirma = vbNo Then Exit Sub
         End If
         
         If Len(txtCotizacionMoneda.Text) = 0 Then
            MsgBox "No ingreso la conversion a pesos", vbInformation
            Exit Sub
         End If
         
         If Len(txtCotizacionDolar.Text) = 0 Then
            MsgBox "No ingreso la cotizacion dolar", vbInformation
            Exit Sub
         End If
         
         If Len(txtCotizacionEuro.Text) = 0 Then
            MsgBox "No ingreso la cotizacion euro", vbInformation
            Exit Sub
         End If
         
         If Len(txtLetra.Text) = 0 Or Len(txtNumeroComprobante1.Text) = 0 Or Not IsNumeric(txtNumeroComprobante1.Text) Or _
                Len(txtNumeroComprobante2.Text) = 0 Or Not IsNumeric(txtNumeroComprobante2.Text) Then
            MsgBox "Falta completar el numero de comprobante original o es invalido", vbInformation
            Exit Sub
         End If
         
         If Len(txtNumeroComprobante1.Text) > 4 Or Len(txtNumeroComprobante2.Text) > 8 Then
            MsgBox "El comprobante original tiene que tener formato X-0000-00000000", vbInformation
            Exit Sub
         End If
         
         If Val(txtNumeroComprobante2.Text) = 0 Then
            MsgBox "El numero de comprobante no puede ser 0", vbInformation
            Exit Sub
         End If
         
         If Frame3.Visible And Option3.Value = False And Option4.Value = False Then
            MsgBox "Debe indicar si la compra es de bienes o servicios", vbInformation
            Exit Sub
         End If
         
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar un comprobante sin detalles"
            Exit Sub
         End If
         
         If Val(txtNumeroComprobante1.Text) = 0 Then
            If BuscarClaveINI("Exigir punto de venta en comprobantes de proveedores") = "SI" Then
               MsgBox "El punto de venta del comprobante no puede ser 0", vbExclamation
               Exit Sub
            Else
               mvarSeguro = MsgBox("El punto de venta del comprobante es 0," & vbCrLf & _
                                    "esta seguro de continuar?", vbYesNo, "Comprobante de proveedores")
               If mvarSeguro = vbNo Then Exit Sub
            End If
         End If
         
         If glbIdCuentaFFUsuario <> -1 And txtNumeroRendicionFF.Visible And Val(txtNumeroRendicionFF.Text) = 0 Then
            MsgBox "Falta indicar el numero de rendicion del fondo fijo", vbInformation
            Exit Sub
         End If
         
         If DTFields(2).Visible And DTFields(0).Value > DTFields(2).Value Then
            MsgBox "La fecha de vencimiento no puede ser anterior a la del comprobante", vbInformation
            Exit Sub
         End If

         With origen.Registro
            For Each dtp In DTFields
               If ExisteCampo(origen.Registro, dtp.DataField) Then
                  .Fields(dtp.DataField).Value = dtp.Value
               End If
            Next
            If Not DTFields(4).Visible Then .Fields("FechaAsignacionPresupuesto").Value = Null
            For Each dc In dcfields
               If dc.Index <> 2 Then
                  If dc.Visible And dc.Enabled And ExisteCampo(origen.Registro, dc.DataField) Then
                     If Len(Trim(dc.BoundText)) = 0 And dc.Index <> 10 Then
                        MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                        Exit Sub
                     End If
                     If Len(Trim(dc.BoundText)) Then .Fields(dc.DataField).Value = dc.BoundText
                  End If
               End If
            Next
            mIdProv = 0
            If Not IsNull(.Fields("IdProveedor").Value) Then mIdProv = .Fields("IdProveedor").Value
            If Not IsNull(.Fields("IdProveedorEventual").Value) Then mIdProv = .Fields("IdProveedorEventual").Value
         End With
         
         If IsNumeric(dcfields(0).BoundText) Then
            Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorNumeroComprobante", _
                        Array(dcfields(0).BoundText, txtLetra.Text, txtNumeroComprobante1.Text, _
                              txtNumeroComprobante2.Text, mvarId, dcfields(1).BoundText))
            If Not oRs Is Nothing Then
               If oRs.RecordCount > 0 Then
                  oRs.Close
                  Set oRs = Nothing
                  MsgBox "Numero de comprobante ya ingresado por cuenta corriente", vbExclamation
                  GoTo Salida
               End If
               oRs.Close
            End If
            
            If BuscarClaveINI("Controlar fecha de comprobantes de proveedores") = "SI" Then
               Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_ComprobanteAnterior", _
                           Array(dcfields(0).BoundText, txtLetra.Text, txtNumeroComprobante1.Text, _
                                 txtNumeroComprobante2.Text, dcfields(1).BoundText))
               If oRs.RecordCount > 0 Then
                  If oRs.Fields("FechaComprobante").Value > DTFields(0).Value Then
                     MsgBox "La fecha del ultimo comprobante es " & oRs.Fields("FechaComprobante").Value & ", " & vbCrLf & _
                              "este comprobante no puede tener una fecha anterior", vbExclamation
                     oRs.Close
                     Set oRs = Nothing
                     GoTo Salida
                  End If
               End If
               oRs.Close
            End If
         End If
         
         If Not IsNull(origen.Registro.Fields("IdProveedorEventual").Value) Then
            Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorNumeroComprobante", _
                        Array(origen.Registro.Fields("IdProveedorEventual").Value, txtLetra.Text, _
                              txtNumeroComprobante1.Text, txtNumeroComprobante2.Text, mvarId, dcfields(1).BoundText))
            If Not oRs Is Nothing Then
               If oRs.RecordCount > 0 Then
                  oRs.Close
                  Set oRs = Nothing
                  MsgBox "Numero de comprobante ya ingresado por fondo fijo", vbExclamation
                  GoTo Salida
               End If
               oRs.Close
            End If
         End If
         
         If txtInformacionAuxiliar.Visible Then
            If BuscarClaveINI("Visualizar informacion auxiliar en comprobante de proveedores") <> "SI" Then
               If Len(txtInformacionAuxiliar.Text) = 0 Then
                  MsgBox "Falta ingresar el codigo de comprobante", vbExclamation
                  Exit Sub
               End If
            End If
         End If
         
         If txtImputaComprobante.Visible And Len(txtImputaComprobante.Text) > 0 Then
            If IsNumeric(txtImputaComprobante.Text) And IsNumeric(dcfields(0).BoundText) Then
               Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorNumeroReferencia", Array(txtImputaComprobante.Text, dcfields(0).BoundText))
               If oRs.RecordCount = 0 Then
                  MsgBox "Numero de comprobante imputado inexistente"
                  oRs.Close
                  Set oRs = Nothing
                  Exit Sub
               Else
                  If IsNumeric(dcfields(0).BoundText) Then
                     If IIf(IsNull(oRs.Fields("IdProveedor").Value), 0, oRs.Fields("IdProveedor").Value) <> dcfields(0).BoundText Then
                        MsgBox "El proveedor correspondiente al comprobante imputado no es igual al actual", vbExclamation
                        oRs.Close
                        Set oRs = Nothing
                        Exit Sub
                     End If
                  End If
               End If
               oRs.Close
            End If
         End If

'         If txtGravadoParaSUSS.Visible And Len(txtGravadoParaSUSS.Text) = 0 Then
'            MsgBox "Falta ingresar el gravado para SUSS", vbExclamation
'            Exit Sub
'         End If
         
'         If txtPorcentajeParaSUSS.Visible And Len(txtPorcentajeParaSUSS.Text) = 0 Then
'            MsgBox "Falta ingresar el porcentaje para SUSS", vbExclamation
'            Exit Sub
'         End If
         
'         If txtFondoReparo.Visible And Len(txtFondoReparo.Text) = 0 Then
'            MsgBox "Falta ingresar el fondo de reparo", vbExclamation
'            Exit Sub
'         End If
         
         If Not IsNull(origen.Registro.Fields("IdProveedor").Value) Then
            Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", origen.Registro.Fields("IdProveedor").Value)
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("CodigoSituacionRetencionIVA").Value) Then
                  If oRs.Fields("CodigoSituacionRetencionIVA").Value = 3 And mvarTipoIVA = 1 Then
                     MsgBox "El codigo de situacion del proveedor para retencion IVA es 3," & vbCrLf & _
                            "en consecuencia no puede ser registrado este comprobante", vbExclamation
                     oRs.Close
                     Set oRs = Nothing
                     Exit Sub
                  End If
               End If
            End If
            oRs.Close
            Set oRs = Nothing
         
            If EstadoEntidad("Proveedores", origen.Registro.Fields("IdProveedor").Value) = "INACTIVO" Then
               MsgBox "Proveedor inhabilitado", vbExclamation
               Exit Sub
            End If
         End If
         
         mAuxS1 = BuscarClaveINI("Exigir etapa de obra en circuito de compras para comprobante de proveedores")
         mAuxS2 = BuscarClaveINI("Presupuestador de obra nuevo")
         mAuxS3 = BuscarClaveINI("Controlar comprobante de proveedor contra pedido")
         mPorcentajeTolerancia = 0
         If IsNumeric(mAuxS3) Then mPorcentajeTolerancia = Val(mAuxS3)
         mCotizacionMoneda = txtCotizacionMoneda.Text
         
         mvarError = ""
         Set oRs = origen.DetComprobantesProveedores.Registros
         With oRs
            If .Fields.Count > 0 Then
               If .RecordCount > 0 Then
                  .MoveFirst
                  Do While Not .EOF
                     If Not .Fields("Eliminado").Value Then
                        If mvarControlarRubrosContablesEnCP = "SI" Then
                           If IsNull(.Fields("IdRubroContable").Value) Or .Fields("IdRubroContable").Value = 0 Then
                              mvarError = mvarError & vbCrLf & _
                                          "El item " & IIf(IsNull(.Fields("Item").Value), "", .Fields("Item").Value) & " " & _
                                          "no tiene ingresado el rubro financiero"
                           End If
                        End If
                        If IsNull(.Fields("IdCuenta").Value) Or .Fields("IdCuenta").Value = 0 Then
                           mvarError = mvarError & vbCrLf & _
                                       "El item " & IIf(IsNull(.Fields("Item").Value), "", .Fields("Item").Value) & " " & _
                                       "no tiene ingresada la cuenta contable"
                        End If
                        If mAuxS1 = "SI" And Not IsNull(.Fields("IdObra").Value) Then
                           If mAuxS2 = "SI" Then
                              If IsNull(.Fields("IdPresupuestoObrasNodo").Value) Then
                                 mADistribuir = "NO"
                                 If Not IsNull(.Fields("IdArticulo").Value) Then
                                    Set oRs1 = Aplicacion.Articulos.TraerFiltrado("_PorId", .Fields("IdArticulo").Value)
                                    If oRs1.RecordCount > 0 Then
                                       mADistribuir = IIf(IsNull(oRs1.Fields("ADistribuirEnPresupuestoDeObra").Value), "NO", oRs1.Fields("ADistribuirEnPresupuestoDeObra").Value)
                                    End If
                                    oRs1.Close
                                 End If
                                 If mADistribuir = "NO" Then
                                    Set oRs1 = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_EtapasImputablesPorObraParaCombo", .Fields("IdObra").Value)
                                    If oRs1.RecordCount > 0 Then
                                       mvarError = mvarError & vbCrLf & _
                                                   "El item " & IIf(IsNull(.Fields("Item").Value), "", .Fields("Item").Value) & " " & _
                                                   "no tiene ingresada la etapa"
                                    End If
                                    oRs1.Close
                                 End If
                              End If
                           Else
                              If IsNull(.Fields("IdDetalleObraDestino").Value) Then
                                 Set oRs1 = Aplicacion.Obras.TraerFiltrado("_DestinosParaComboPorIdObra", .Fields("IdObra").Value)
                                 If oRs1.RecordCount > 0 Then
                                    mvarError = mvarError & vbCrLf & _
                                                "El item " & IIf(IsNull(.Fields("Item").Value), "", .Fields("Item").Value) & " " & _
                                                "no tiene ingresada la etapa"
                                 End If
                                 oRs1.Close
                              End If
                              If IsNull(.Fields("IdPresupuestoObraRubro").Value) Then
                                 Set oRs1 = Aplicacion.Obras.TraerFiltrado("_DestinosParaComboPorIdObra", .Fields("IdObra").Value)
                                 If oRs1.RecordCount > 0 Then
                                    mvarError = mvarError & vbCrLf & _
                                                "El item " & IIf(IsNull(.Fields("Item").Value), "", .Fields("Item").Value) & " " & _
                                                "no tiene ingresado el rubro para presupuesto de obra"
                                 End If
                                 oRs1.Close
                              End If
                           End If
                        End If
                        If mPorcentajeTolerancia > 0 Then
                           mImporteItem = 0
                           If Not IsNull(.Fields("IdDetalleRecepcion").Value) Then
                              Set oRs1 = Aplicacion.Recepciones.TraerFiltrado("_DatosPorIdDetalleRecepcion", .Fields("IdDetalleRecepcion").Value)
                              If oRs1.RecordCount > 0 Then
                                 mImporteItem = IIf(IsNull(oRs1.Fields("ImporteBonificado").Value), 0, oRs1.Fields("ImporteBonificado").Value) * _
                                                IIf(IsNull(oRs1.Fields("CotizacionMoneda").Value), 1, oRs1.Fields("CotizacionMoneda").Value)
                              End If
                              oRs1.Close
                           ElseIf Not IsNull(.Fields("IdDetallePedido").Value) Then
                              Set oRs1 = Aplicacion.Pedidos.TraerFiltrado("_DatosPorIdDetalle", .Fields("IdDetallePedido").Value)
                              If oRs1.RecordCount > 0 Then
                                 mImporteItem = IIf(IsNull(oRs1.Fields("ImporteBonificado").Value), 0, oRs1.Fields("ImporteBonificado").Value) * _
                                                IIf(IsNull(oRs1.Fields("CotizacionMoneda").Value), 1, oRs1.Fields("CotizacionMoneda").Value)
                              End If
                              oRs1.Close
                           End If
                           mImporte = .Fields("Importe").Value * mCotizacionMoneda
                           If mImporteItem <> 0 Then
                              If Abs((mImporte - mImporteItem) / mImporteItem * 100) > mPorcentajeTolerancia Then
                                 mvarError = mvarError & vbCrLf & _
                                             "El item " & IIf(IsNull(.Fields("Item").Value), "", .Fields("Item").Value) & " " & _
                                             "esta asociado a un item de pedido y la diferencia supera la tolerancia de " & mPorcentajeTolerancia & "%"
                              End If
                           End If
                        End If
                        If glbModeloContableSinApertura = "SI" And IsNull(.Fields("IdObra").Value) Then
                           Set oRs1 = Aplicacion.Cuentas.TraerFiltrado("_PorId", IIf(IsNull(.Fields("IdCuenta").Value), 0, .Fields("IdCuenta").Value))
                           mJerarquia = ""
                           If oRs1.RecordCount > 0 Then
                              mJerarquia = IIf(IsNull(oRs1.Fields("Jerarquia").Value), "", oRs1.Fields("Jerarquia").Value)
                           End If
                           oRs1.Close
                           If mId(mJerarquia, 1, 1) = "5" Then
                              mvarError = mvarError & vbCrLf & _
                                          "El item " & IIf(IsNull(.Fields("Item").Value), "", .Fields("Item").Value) & " " & _
                                          "no tiene ingresada la obra/centro de costos"
                           End If
                        End If
                     End If
                     .MoveNext
                  Loop
               End If
            End If
         End With
         Set oRs = Nothing
         Set oRs1 = Nothing
         If Len(mvarError) > 0 Then
            MsgBox "Se encontraron los siguientes errores al grabar : " & mvarError, vbExclamation
            Exit Sub
         End If
         
         If mvarAjusteIVA <> 0 And mvarIVA1 = 0 And mvarIVANoDiscriminado = 0 Then
            MsgBox "No puede ingresar ajuste de iva en un comprobante sin items gravados", vbExclamation
            Exit Sub
         End If
         
         If mvarTipoIVA = 1 Then
            mPorcentajeIVAParaMonotributistas = 0
            If txtLetra.Text = "C" And BuscarClaveINI("Desactivar control letra comprobante proveedor") <> "SI" Then
               MsgBox "La letra del comprobante no puede ser C para un responsable inscripto", vbExclamation
               Exit Sub
            End If
         ElseIf mvarTipoIVA = 6 Then
            If BuscarClaveINI("Activar control por tope de monotributistas") = "SI" Then
               If mvarId <= 0 And glbTopeMonotributoAnual_Bienes > 0 And glbTopeMonotributoAnual_Servicios > 0 Then
                  Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_TotalBSUltimoAño", Array(mIdProv, DTFields(1).Value, -1))
                  If (Option3.Value And oRs.Fields("Importe_Bienes").Value + mvarTotalComprobanteProveedor > glbTopeMonotributoAnual_Bienes) Or _
                        (Option4.Value And oRs.Fields("Importe_Servicios").Value + mvarTotalComprobanteProveedor > glbTopeMonotributoAnual_Servicios) Then
                     oRs.Close
                     Set oRs = Nothing
                     MsgBox "El proveedor supero el tope anual de facturacion, No puede registrar este comprobante", vbExclamation
                     Exit Sub
                  End If
                  oRs.Close
                  Set oRs = Nothing
               End If
            End If
            
            mPorcentajeIVAParaMonotributistas = mvarP_IVA1
            If Not IsNull(origen.Registro.Fields("PorcentajeIVAParaMonotributistas").Value) Then
               mPorcentajeIVAParaMonotributistas = origen.Registro.Fields("PorcentajeIVAParaMonotributistas").Value
            End If
            Set oF = New frm_Aux
            With oF
               .Caption = "Porcentaje IVA aplicable (Monotributistas)"
               With .Label1
                  .Caption = "% IVA aplicable a los bienes/servicios adquiridos :"
                  .Top = oF.Label2(0).Top
                  .Width = .Width * 3
               End With
               With .Text1
                  .Text = mPorcentajeIVAParaMonotributistas
                  .Top = oF.Label1.Top
                  .Left = oF.Label1.Left + oF.Label1.Width + 10
                  .Width = .Width * 0.5
               End With
               .Width = .Width * 1.5
               .Height = .Height * 0.5
               .cmd(0).Top = .Label1.Top + .Label1.Height + 100
               .cmd(0).Left = .Width / 2 - (.cmd(0).Width / 2)
               .cmd(0).Height = .cmd(0).Height * 0.75
               .cmd(1).Visible = False
               .Show vbModal, Me
               If .Ok Then mPorcentajeIVAParaMonotributistas = Val(.Text1.Text)
            End With
            Unload oF
            Set oF = Nothing
         Else
            mPorcentajeIVAParaMonotributistas = 0
         End If

         Me.MousePointer = vbHourglass
      
'         VerificarProvinciasDestino
         
         With origen.Registro
            .Fields("TotalBruto").Value = mvarSubTotal
            .Fields("TotalIva1").Value = mvarIVA1
            .Fields("TotalIva2").Value = mvarIVA2
            .Fields("AjusteIVA").Value = mvarAjusteIVA
            .Fields("TotalIVANoDiscriminado").Value = mvarIVANoDiscriminado
            .Fields("TotalComprobante").Value = mvarTotalComprobanteProveedor
            If Option1.Value Then
               .Fields("IdProveedorEventual").Value = Null
               .Fields("IdOrdenPago").Value = Null
               If Option3.Value Then
                  .Fields("BienesOServicios").Value = "B"
               Else
                  .Fields("BienesOServicios").Value = "S"
               End If
               .Fields("NumeroRendicionFF").Value = Null
               .Fields("Cuit").Value = Null
            ElseIf Option2.Value Then
               .Fields("IdProveedor").Value = Null
               .Fields("BienesOServicios").Value = Null
               .Fields("Cuit").Value = Null
               .Fields("CircuitoFirmasCompleto").Value = "SI"
               If IsNull(.Fields("IdProveedorEventual").Value) Or .Fields("IdProveedorEventual").Value = 0 Then
                  MsgBox "No ingreso el proveedor", vbExclamation
                  GoTo Salida
               End If
               If IsNull(.Fields("IdCuenta").Value) Or .Fields("IdCuenta").Value = 0 Then
                  MsgBox "No ingreso la cuenta de fondo fijo", vbExclamation
                  GoTo Salida
               End If
               If Len(txtOrdenPago.Text) > 0 Then
                  Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PorNumeroFF", txtOrdenPago.Text)
                  If oRs.RecordCount > 0 Then
                     .Fields("IdOrdenPago").Value = oRs.Fields(0).Value
                  Else
                     .Fields("IdOrdenPago").Value = Null
                  End If
                  oRs.Close
                  Set oRs = Aplicacion.Monedas.TraerFiltrado("_PorId", mvarIdMonedaOP_FF)
                  If oRs.RecordCount > 0 Then
                     mvarMonedaOP_FF = oRs.Fields("Nombre").Value
                  End If
                  oRs.Close
                  Set oRs = Nothing
                  If .Fields("IdMoneda").Value <> mvarIdMonedaOP_FF And _
                     Not (.Fields("IdTipoComprobante").Value = mvarIdTipoComprobanteNDInternaAcreedores Or _
                           .Fields("IdTipoComprobante").Value = mvarIdTipoComprobanteNCInternaAcreedores) Then
                     MsgBox "La orden de pago y el comprobante deben tener la misma moneda" & vbCrLf & _
                            "La orden de pago esta en " & mvarMonedaOP_FF, vbExclamation
                     GoTo Salida
                  End If
               End If
            ElseIf Option5.Value Then
               .Fields("IdProveedor").Value = Null
               .Fields("IdProveedorEventual").Value = Null
               .Fields("IdCuenta").Value = Null
               .Fields("IdOrdenPago").Value = Null
               .Fields("BienesOServicios").Value = Null
               .Fields("NumeroRendicionFF").Value = Null
               .Fields("Cuit").Value = CUIT1.Text
            End If
            .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text
            .Fields("CotizacionDolar").Value = txtCotizacionDolar.Text
            .Fields("CotizacionEuro").Value = txtCotizacionEuro.Text
            .Fields("Confirmado").Value = "SI"
            If mvarId < 0 Then
               .Fields("IdUsuarioIngreso").Value = glbIdUsuario
               .Fields("FechaIngreso").Value = Now
            Else
               .Fields("IdUsuarioModifico").Value = glbIdUsuario
               .Fields("FechaModifico").Value = Now
            End If
            .Fields("Observaciones").Value = rchObservaciones.Text
            If Len(Me.Confirmado) > 0 Then
               mAuxS1 = BuscarClaveINI("Modalidad grabacion de comprobantes de proveedores a confirmar")
               If Len(Trim(mAuxS1)) = 0 Then
                  If glbTipoUsuario <> 1 Then
                     .Fields("Confirmado").Value = "NO"
                  End If
               ElseIf mAuxS1 = "01" Then
                  .Fields("Confirmado").Value = "SI"
               ElseIf mAuxS1 = "02" Then
                  .Fields("Confirmado").Value = "NO"
               Else
                  mvarSeguro = MsgBox("Desea confirmar el comprobante ?", vbYesNo, "Comprobante a confirmar")
                  If mvarSeguro = vbYes Then
                     .Fields("Confirmado").Value = "SI"
                  Else
                     .Fields("Confirmado").Value = "NO"
                  End If
               End If
            End If
            If mvarIdComprobanteImputado > 0 Then
               .Fields("IdComprobanteImputado").Value = mvarIdComprobanteImputado
            Else
               .Fields("IdComprobanteImputado").Value = Null
            End If
            If Frame4.Visible Then
               If Option6.Value Then
                  .Fields("DestinoPago").Value = "A"
               Else
                  .Fields("DestinoPago").Value = "O"
               End If
            Else
               .Fields("DestinoPago").Value = Null
            End If
            If Check3.Value = 1 Then
               .Fields("Dolarizada").Value = "SI"
            Else
               .Fields("Dolarizada").Value = "NO"
            End If
            .Fields("PorcentajeIVAParaMonotributistas").Value = mPorcentajeIVAParaMonotributistas
            If Check4.Visible And Check4.Value = 1 Then
               .Fields("TomarEnCuboDeGastos").Value = "NO"
            Else
               .Fields("TomarEnCuboDeGastos").Value = Null
            End If
         End With
         
'         If mvarId < 0 Or IsNull(origen.Registro.Fields("NumeroReferencia").Value) Then
'            Dim oPar As ComPronto.Parametro
'            Dim mNum As Long
'            Set oPar = Aplicacion.Parametros.Item(1)
'            With oPar.Registro
'               mNum = .Fields("ProximoComprobanteProveedorReferencia").Value
'               origen.Registro.Fields("NumeroReferencia").Value = mNum
'               .Fields("ProximoComprobanteProveedorReferencia").Value = mNum + 1
'            End With
'            oPar.Guardar
'            Set oPar = Nothing
'         End If
         
         mvarIdOriginal = mvarId
         
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
            Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorId", mvarId)
            If oRs.RecordCount > 0 Then
               oRs.MoveFirst
               If oRs.Fields("NumeroReferencia").Value <> txtNumeroReferencia.Text Then
                  MsgBox "El numero de referencia del comprobante a cambiado," & vbCrLf & _
                           "el nuevo numero asignado es el " & oRs.Fields("NumeroReferencia").Value & ".", vbInformation
               End If
            End If
            oRs.Close
            Set oRs = Nothing
            mvarGrabado = True
         Else
            est = Modificacion
         End If
            
         If Not actL2 Is Nothing Then
            With actL2
               .ListaEditada = "ComprobantesPrvTodos,+SubCP1,+SubCP2,ComprobantesAConfirmar,ComprobantesPrvPorMes"
               .AccionRegistro = est
               .IdRegistroOriginal = mvarIdOriginal
               .Disparador = mvarId
            End With
         End If
         
         Me.MousePointer = vbDefault
   
         Unload Me

      Case 1
         Unload Me

      Case 2
         Lista.Height = Lista.Height * 0.7
         lblItem(0).Visible = True
         lblItem(1).Visible = True
         lblItem(2).Visible = True
         lblItem(3).Visible = True
         txtCuentaItem.Visible = True
         DataCombo1(0).Visible = True
         DataCombo1(1).Visible = True
         Check2.Visible = True
         With DataCombo1(2)
            .Visible = True
            If Not IsNumeric(.BoundText) And IsNumeric(dcfields(2).BoundText) Then
               .BoundText = dcfields(2).BoundText
            End If
         End With
         DataCombo1(3).Visible = True
         Frame2.Visible = True
         txtImporteItem.Visible = True
         cmdIngresarItem(0).Visible = True
         cmdIngresarItem(1).Visible = True
         Line5.Visible = True
         DataCombo1(2).SetFocus
         cmd(2).Enabled = False
         If glbIdObraAsignadaUsuario <> -1 Then
            DataCombo1(2).Enabled = False
            DataCombo1(3).Enabled = False
            txtCuentaItem.Enabled = False
            Set DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorGrupoParaCombo", mvarIdTipoCuentaGrupoIVA)
         End If
         If mActivarCamposParaFF Then
            mAuxS1 = BuscarClaveINI("Grupos de cuenta para ingreso por FF")
            If Len(mAuxS1) > 0 Then
               Set DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorGruposParaCombo", mAuxS1)
            End If
         End If
         If txtLetra.Text = "C" Then
            For i = 0 To 9
               Check1(i).Value = 0
            Next
            Frame2.Enabled = False
         Else
            Frame2.Enabled = True
         End If
         If glbModeloContableSinApertura = "SI" Then
            lblItem(3).Visible = False
            Check2.Visible = False
            DataCombo1(1).Visible = False
         End If

      Case 3
         MostrarRecepcionesPendientes
      
      Case 4
         EliminarComprobante
      
      Case 5
         DatosReintegro
         If Not IsNull(origen.Registro.Fields("ReintegroIdCuenta").Value) Then
            cmd(5).BackColor = &HC0FFC0
         Else
            cmd(5).BackColor = &HC0C0FF
         End If
      
      Case 6
         AnticipoAProveedores
         If Me.IdPedidoAnticipo > 0 Then
            cmd(6).BackColor = &HC0FFC0
         Else
            cmd(6).BackColor = &HC0C0FF
         End If
   End Select
   
   Set cALetra = Nothing
   
Salida:

   Me.MousePointer = vbDefault
   Exit Sub

Mal:
   
   Me.MousePointer = vbDefault
   Dim mvarResp As Integer
   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRsAut As ADOR.Recordset
   Dim oDet As ComPronto.DetComprobanteProveedor
   Dim oDetPrv As ComPronto.DetComprobanteProveedorPrv
   Dim dtf As DTPicker
   Dim i As Integer, mCantidadFirmas As Integer
   Dim mTotalBruto As Double
   Dim ListaVacia As Boolean
   
   mvarId = vnewvalue
   ListaVacia = False
   mCondicionDesdePedido = False
   mvarIdMonedaOP_FF = 0
   mvarModoCodigoBarra = False
   mvarLeyoCodigoBarra = False
   mTotalBruto = 0
   
   mActivarCamposParaFF = False
   If BuscarClaveINI("Activar campos para FF") = "SI" Then mActivarCamposParaFF = True
   'And glbIdCuentaFFUsuario <> -1
   mActivarCamposParaFF1 = False
   If BuscarClaveINI("Activar numero de rendicion para FF") = "SI" Then mActivarCamposParaFF1 = True
   
   If BuscarClaveINI("Visualizar informacion auxiliar en comprobante de proveedores") = "SI" Then
      rchObservaciones.Height = rchObservaciones.Height * 0.6
      With lblAuxiliar1
         .Top = rchObservaciones.Top + rchObservaciones.Height + 10
         .Left = rchObservaciones.Left
         .Caption = "Inf.Auxiliar :"
         .Visible = True
      End With
      With txtInformacionAuxiliar
         .Top = lblAuxiliar1.Top
         .Left = lblAuxiliar1.Left + lblAuxiliar1.Width + 50
         .Width = rchObservaciones.Width - lblAuxiliar1.Width - 50
         .Visible = True
      End With
   End If
   
   If BuscarClaveINI("Exigir etapa de obra en circuito de compras para comprobante de proveedores") = "SI" Or _
      BuscarClaveINI("Mostrar fecha de asignacion a presupuesto en comprobante de proveedores") = "SI" Then
      rchObservaciones.Height = rchObservaciones.Height * 0.5
      With lblLabels(20)
         .Top = rchObservaciones.Top + rchObservaciones.Height + 10
         .Left = rchObservaciones.Left
         .Visible = True
      End With
      With DTFields(4)
         .Top = lblLabels(20).Top
         .Left = lblLabels(20).Left + lblLabels(20).Width + 50
         .Visible = True
      End With
   End If
   
   If BuscarClaveINI("Confirmar envio a cubo de gastos del comprobante de proveedor") = "SI" Then
      With Check4
         .Visible = True
      End With
   End If

   If BuscarClaveINI("Mostrar salida a Excel de comprobantes de proveedores") = "SI" Then
      cmdImpre.Visible = True
   End If

'   If BuscarClaveINI("Lista de precios en comprobante de proveedores") = "SI" Then
'      dcfields(4).Width = dcfields(4).Width / 2
'      With lblData(9)
'         .Top = dcfields(4).Top
'         .Left = dcfields(4).Left + dcfields(4).Width + 100
'         .Visible = True
'      End With
'      With dcfields(9)
'         .Top = dcfields(4).Top
'         .Left = lblData(9).Left + lblData(9).Width + 10
'         .Visible = True
'      End With
'   End If
   
   If BuscarClaveINI("Activar liquidacion de fleteros en comprobante de proveedores") = "SI" Then
      With lblFleteros
         .Top = cmd(6).Top
         .Left = cmd(6).Left + cmd(6).Width + 100
         .Visible = True
      End With
      With Check5
         .Top = lblFleteros.Top
         .Left = lblFleteros.Left + lblFleteros.Width + 50
         .Visible = True
      End With
      With dcfields(10)
         .Top = Check5.Top
         .Left = Check5.Left + Check5.Width + 50
         .Visible = True
      End With
   End If
   
   Set oAp = Aplicacion
   Set origen = oAp.ComprobantesProveedores.Item(vnewvalue)
   
   Lista.Sorted = False
   
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   With oRs
      mvarP_IVA1 = .Fields("Iva1").Value
      mvarP_IVA2 = .Fields("Iva2").Value
      mvarDecimales = .Fields("Decimales").Value
      mvarCotizacionDolar = .Fields("CotizacionDolar").Value
      mvarIdMonedaPesos = .Fields("IdMoneda").Value
      mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
      mvarIdTipoComprobanteNDInternaAcreedores = .Fields("IdTipoComprobanteNDInternaAcreedores").Value
      mvarIdTipoComprobanteNCInternaAcreedores = .Fields("IdTipoComprobanteNCInternaAcreedores").Value
      mvarIdTipoComprobanteFacturaCompraExportacion = IIf(IsNull(.Fields("IdTipoComprobanteFacturaCompraExportacion").Value), 0, _
                                             .Fields("IdTipoComprobanteFacturaCompraExportacion").Value)
      mvarIdTipoCuentaGrupoIVA = IIf(IsNull(.Fields("IdTipoCuentaGrupoIVA").Value), 0, .Fields("IdTipoCuentaGrupoIVA").Value)
      gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)
   End With
   For i = 1 To 10
      If Not IsNull(oRs.Fields("IdCuentaIvaCompras" & i).Value) Then
         With Check1(i - 1)
            .Caption = oRs.Fields("IVAComprasPorcentaje" & i).Value & "%"
            mvarIVAs(i, 0) = IIf(IsNull(oRs.Fields("IVAComprasPorcentaje" & i).Value), 0, oRs.Fields("IVAComprasPorcentaje" & i).Value)
            mvarIVAs(i, 1) = IIf(IsNull(oRs.Fields("IdCuentaIvaCompras" & i).Value), 0, oRs.Fields("IdCuentaIvaCompras" & i).Value)
            .Value = 0
         End With
      Else
         Check1(i - 1).Visible = False
      End If
   Next
   oRs.Close
   
   mvarControlarRubrosContablesEnCP = ""
   Set oRs = oAp.Parametros.TraerFiltrado("_Parametros2BuscarClave", "ControlarRubrosContablesEnCP")
   If oRs.RecordCount > 0 Then
      mvarControlarRubrosContablesEnCP = IIf(IsNull(oRs.Fields("Valor").Value), "NO", oRs.Fields("Valor").Value)
   End If
   oRs.Close
   
   mvarPrimeraVez = True
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            If oControl.Name = "Lista" Then
               If vnewvalue < 0 Then
                  Set oControl.DataSource = origen.DetComprobantesProveedores.TraerMascara
                  ListaVacia = True
               Else
                  Set oRs = origen.DetComprobantesProveedores.TraerTodos
                  If oRs.RecordCount <> 0 Then
                     Set oControl.DataSource = oRs
                     oRs.MoveFirst
                  Else
                     Set oControl.DataSource = origen.DetComprobantesProveedores.TraerMascara
                     ListaVacia = True
                  End If
                  While Not oRs.EOF
                     Set oDet = origen.DetComprobantesProveedores.Item(oRs.Fields(0).Value)
                     oDet.Modificado = True
                     Set oDet = Nothing
                     oRs.MoveNext
                  Wend
                  oRs.Close
               End If
            End If
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "TiposComprobante" Then
                  Set oControl.RowSource = oAp.TiposComprobante.TraerFiltrado("_ParaComboProveedores")
               ElseIf oControl.Tag = "Cuentas" Then
                  If glbSeñal1 Then
                     Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_PorFechaParaCombo", Date)
                  Else
                     Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_ParaComprobantesProveedores")
                  End If
               ElseIf oControl.Tag = "CuentasBancarias" Then
                  Set oControl.RowSource = oAp.CuentasBancarias.TraerFiltrado("_TodasParaCombo")
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
   
   If mvarId <> -1 Then
      Set oRs = origen.DetComprobantesProveedoresPrv.TraerTodos
      If oRs.Fields.Count > 0 Then
         If oRs.RecordCount > 0 Then
            While Not oRs.EOF
               Set oDetPrv = origen.DetComprobantesProveedoresPrv.Item(oRs.Fields(0).Value)
               oDetPrv.Modificado = True
               Set oDetPrv = Nothing
               oRs.MoveNext
            Wend
         End If
      End If
      oRs.Close
   End If
   
   If mvarId = -1 Then
      Set oRs = oAp.Parametros.Item(1).Registro
      With origen.Registro
         .Fields("NumeroReferencia").Value = oRs.Fields("ProximoComprobanteProveedorReferencia").Value
         .Fields("IdTipoComprobante").Value = 11
         .Fields("Letra").Value = ""
         .Fields("NumeroComprobante1").Value = 0
         .Fields("NumeroComprobante2").Value = 0
         .Fields("IdMoneda").Value = mvarIdMonedaPesos
         If glbIdCuentaFFUsuario <> -1 Then
            .Fields("IdCuenta").Value = glbIdCuentaFFUsuario
            Option2.Value = True
         Else
            Option1.Value = True
         End If
         If glbIdObraAsignadaUsuario <> -1 Then
            .Fields("IdObra").Value = glbIdObraAsignadaUsuario
         End If
      End With
      oRs.Close
      Set oRs = Nothing
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      DTFields(3).Value = Null
      Option6.Value = True
      Lista.ListItems.Clear
      mvarGrabado = False
      mvarCotizacion = Cotizacion(Date, glbIdMonedaDolar)
      txtCotizacionDolar.Text = mvarCotizacion
      mvarCotizacionEuro = Cotizacion(Date, glbIdMonedaEuro)
      txtCotizacionEuro.Text = mvarCotizacionEuro
      txtTotal(3).Text = 0
      mvarIdComprobanteImputado = 0
      If Me.IdComprobanteAnterior > 0 Then
         CargarDatosDesdeComprobanteGrabado
         ListaVacia = False
      End If
      If BuscarClaveINI("Calcular diferencia de cambio en acreedores") = "SI" Then
         Check3.Value = 1
      End If
   Else
      mvarGrabado = True
      With origen.Registro
         If Not IsNull(.Fields("IdProveedor").Value) Then
            Option1.Value = True
            MostrarDatos (0)
         ElseIf Not IsNull(.Fields("IdCuentaOtros").Value) Then
            Option5.Value = True
            CUIT1.Text = .Fields("Cuit").Value
         Else
            Option2.Value = True
            If Not IsNull(.Fields("IdOrdenPago").Value) Then
               Set oRs = oAp.OrdenesPago.Item(.Fields("IdOrdenPago").Value).Registro
               If oRs.RecordCount > 0 Then
                  txtOrdenPago.Text = oRs.Fields("NumeroOrdenPago").Value
               End If
               oRs.Close
               Set oRs = Nothing
            End If
         End If
         mvarCotizacion = IIf(IsNull(.Fields("CotizacionDolar").Value), 0, .Fields("CotizacionDolar").Value)
         If mvarCotizacion = 0 And IsNull(.Fields("IdDiferenciaCambio").Value) And Not (.Fields("IdTipoComprobante").Value = 13 Or .Fields("IdTipoComprobante").Value = 19) Then
            mvarCotizacion = Cotizacion(.Fields("FechaComprobante").Value, glbIdMonedaDolar)
         End If
         txtCotizacionDolar.Text = mvarCotizacion
         mvarCotizacionEuro = IIf(IsNull(.Fields("CotizacionEuro").Value), 0, .Fields("CotizacionEuro").Value)
         If mvarCotizacionEuro = 0 And IsNull(.Fields("IdDiferenciaCambio").Value) And Not (.Fields("IdTipoComprobante").Value = 13 Or .Fields("IdTipoComprobante").Value = 19) Then
            mvarCotizacionEuro = Cotizacion(.Fields("FechaComprobante").Value, glbIdMonedaEuro)
         End If
         txtCotizacionEuro.Text = mvarCotizacionEuro
         txtCotizacionMoneda.Text = IIf(IsNull(.Fields("CotizacionMoneda").Value), 0, .Fields("CotizacionMoneda").Value)
         txtTotal(3).Text = IIf(IsNull(.Fields("AjusteIVA").Value), 0, .Fields("AjusteIVA").Value)
         mTotalBruto = IIf(IsNull(.Fields("TotalBruto").Value), 0, .Fields("TotalBruto").Value) * IIf(IsNull(.Fields("CotizacionMoneda").Value), 0, .Fields("CotizacionMoneda").Value)
         If Not IsNull(.Fields("BienesOServicios").Value) Then
            If .Fields("BienesOServicios").Value = "B" Then
               Option3.Value = True
            Else
               Option4.Value = True
            End If
         End If
         If Not IsNull(.Fields("IdOrdenPago").Value) Then
            Set oRs = oAp.OrdenesPago.TraerFiltrado("_PorId", .Fields("IdOrdenPago").Value)
            If oRs.RecordCount > 0 Then
               mvarIdMonedaOP_FF = oRs.Fields("IdMoneda").Value
            End If
            oRs.Close
            Set oRs = Nothing
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      
         mvarIdComprobanteImputado = 0
         If Not IsNull(.Fields("IdComprobanteImputado").Value) Then
            mvarIdComprobanteImputado = .Fields("IdComprobanteImputado").Value
            Set oRs = oAp.ComprobantesProveedores.TraerFiltrado("_PorId", mvarIdComprobanteImputado)
            If oRs.RecordCount > 0 Then
               txtImputaComprobante.Text = oRs.Fields("NumeroReferencia").Value
            End If
            oRs.Close
         End If
         
         If IsNull(.Fields("DestinoPago").Value) Or .Fields("DestinoPago").Value = "A" Then
            Option6.Value = True
         Else
            Option7.Value = True
         End If
         If Not IsNull(.Fields("Dolarizada").Value) And .Fields("Dolarizada").Value = "SI" Then
            Check3.Value = 1
          Else
            Check3.Value = 0
         End If
         
         Set oRs = oAp.ComprobantesProveedores.TraerFiltrado("_ConAnticipoPorIdComprobanteProveedor", mvarId)
         If oRs.RecordCount > 0 Then
            cmd(6).BackColor = &HC0FFC0
         Else
            cmd(6).BackColor = &HC0C0FF
         End If
         oRs.Close
         
         If Not IsNull(.Fields("TomarEnCuboDeGastos").Value) And .Fields("TomarEnCuboDeGastos").Value = "NO" Then
            Check4.Value = 1
         End If
         
         If Not IsNull(.Fields("IdLiquidacionFlete").Value) Then Check5.Value = 1
      End With
'      dcfields(1).Enabled = False
'      DTFields(0).Enabled = False
   End If
   
   If glbIdCuentaFFUsuario <> -1 Then
      Frame1.Enabled = False
      cmd(3).Enabled = False
   End If
   If glbIdObraAsignadaUsuario <> -1 Then
      dcfields(2).Enabled = False
   End If
   
   If BuscarClaveINI("Activar reintegros") = "SI" Then
      If Not IsNull(origen.Registro.Fields("ReintegroIdCuenta").Value) Then
         cmd(5).BackColor = &HC0FFC0
      Else
         cmd(5).BackColor = &HC0C0FF
      End If
   Else
      cmd(5).Visible = False
   End If
   
   If BuscarClaveINI("Distribuir gastos por obra") = "SI" Then
      MnuDetA(4).Visible = True
   Else
      MnuDetA(4).Visible = False
   End If
   
   txtCotizacion.Text = mvarCotizacion
   
   mSenialIVA = False
   
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
   End If
   
   Set oRsAut = Aplicacion.Autorizaciones.TraerFiltrado("_PorIdFormulario", EnumFormularios.ComprobantesProveedores)
   If oRsAut.RecordCount > 0 Then
      oRsAut.Close
      mCantidadFirmas = 0
      Set oRsAut = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(EnumFormularios.ComprobantesProveedores, mTotalBruto))
      If oRsAut.RecordCount > 0 Then
         oRsAut.MoveFirst
         Do While Not oRsAut.EOF
            mCantidadFirmas = mCantidadFirmas + 1
            CheckAut(mCantidadFirmas).Visible = True
            CheckAut(mCantidadFirmas).Tag = oRsAut.Fields(0).Value
            oRsAut.MoveNext
         Loop
      End If
      oRsAut.Close
      Set oRsAut = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(EnumFormularios.ComprobantesProveedores, mvarId))
      If oRsAut.RecordCount > 0 Then
         oRsAut.MoveFirst
         Do While Not oRsAut.EOF
            For i = 1 To mCantidadFirmas
               If CheckAut(i).Tag = oRsAut.Fields("OrdenAutorizacion").Value Then
                  CheckAut(i).Value = 1
                  Exit For
               End If
            Next
            oRsAut.MoveNext
         Loop
      End If
   Else
      lblAutorizaciones.Visible = False
      For i = 1 To 6: CheckAut(i).Visible = False: Next
      dcfields(4).Width = dcfields(4).Width * 1.73
      dcfields(6).Width = dcfields(6).Width * 1.73
   End If
   oRsAut.Close
   Set oRsAut = Nothing
   
   Set oRs = Nothing
   Set oAp = Nothing

   Lista.Height = 3000
   If ListaVacia Then Lista.ListItems.Clear

   If DTFields(1).Value <= gblFechaUltimoCierre And Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(1).Value) Then
      cmd(0).Enabled = False
   End If
   
   ProcesarINI Me

End Property

Private Sub cmdBuscarPorCuit_Click()

   If oF_BuscarPorCuit Is Nothing Then Set oF_BuscarPorCuit = New frm_Aux
   With oF_BuscarPorCuit
      .Id = 18
      .Disparar = ActL3
      .Show , Me
   End With

End Sub

Private Sub cmdImportaciones_Click()

   MostrarDatosImportacion

End Sub

Private Sub cmdImpre_Click()

   On Error Resume Next
   
   Dim oEx As Excel.Application
   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      With .Workbooks.Add(glbPathPlantillas & "\ComprasTerceros.xlt")
         oEx.Run "ComprobanteProveedor", glbStringConexion, mvarId, "" & glbEmpresaSegunString & "|" & glbPathPlantillas
      End With
   End With
   
Salida:
   Set oEx = Nothing
   Exit Sub
   
Mal:
   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error al procesar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select
   Resume Salida

End Sub

Private Sub cmdIngresarItem_Click(Index As Integer)

   On Error GoTo Mal
   
   If Index = 0 Then
      
      If Len(txtImporteItem.Text) = 0 Or Not IsNumeric(txtImporteItem.Text) Then
         MsgBox "El importe del item no es valido!", vbInformation
         Exit Sub
      End If
      
      If txtPorcentajeIVADirecto.Visible And _
         (Len(txtPorcentajeIVADirecto.Text) = 0 Or Not IsNumeric(txtPorcentajeIVADirecto.Text)) Then
         MsgBox "El porcentaje de IVA del item no es valido!", vbInformation
         Exit Sub
      End If
      
'      If Not IsNumeric(DataCombo1(0).BoundText) Then
      If Len(txtCuentaItem.Text) = 0 Then
         MsgBox "Indique la cuenta contable", vbInformation
         Exit Sub
      End If
      
      If DataCombo1(4).Visible And Not IsNumeric(DataCombo1(4).BoundText) Then
         MsgBox "Debe indicar la cuenta banco", vbExclamation
         Exit Sub
      End If
         
      Dim oL As ListItem
      Dim i As Integer
      Dim mIVAs, mNombreCuenta As String
      Dim mTotalIva As Double
      Dim oRs As ADOR.Recordset
      
      mTotalIva = 0
      mIVAs = ""
      mNombreCuenta = ""
      
      With origen.DetComprobantesProveedores.Item(-1)
         With .Registro
            If IsNumeric(DataCombo1(2).BoundText) Then
               .Fields("IdObra").Value = DataCombo1(2).BoundText
            Else
               .Fields("IdObra").Value = Null
            End If
            If IsNumeric(DataCombo1(1).BoundText) Then
               .Fields("IdCuentaGasto").Value = DataCombo1(1).BoundText
            Else
               .Fields("IdCuentaGasto").Value = Null
            End If
            If Len(txtCuentaItem.Text) > 0 Then
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorCodigo", txtCuentaItem.Text)
               If oRs.RecordCount > 0 Then
                  If oRs.Fields("IdTipoCuenta").Value = 2 Then
                     .Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
                     mNombreCuenta = oRs.Fields("Descripcion").Value
                  Else
                     oRs.Close
                     Set oRs = Nothing
                     MsgBox "Cuenta no imputable", vbExclamation
                     Exit Sub
                  End If
               End If
               oRs.Close
               Set oRs = Nothing
               .Fields("CodigoCuenta").Value = txtCuentaItem.Text
            End If
            .Fields("Importe").Value = Val(txtImporteItem.Text)
            For i = 1 To 10
               If Check1(i - 1).Value = 1 Then
                  .Fields("AplicarIVA" & i).Value = "SI"
                  If txtLetra.Text = "A" Or txtLetra.Text = "M" Then
                     .Fields("ImporteIVA" & i).Value = Round(mvarIVAs(i, 0) * CDbl(.Fields("Importe").Value) / 100, mvarDecimales)
                  Else
                     .Fields("ImporteIVA" & i).Value = Round(CDbl(.Fields("Importe").Value) - (CDbl(.Fields("Importe").Value) / (1 + (mvarIVAs(i, 0) / 100))), mvarDecimales)
                  End If
                  .Fields("IVAComprasPorcentaje" & i).Value = mvarIVAs(i, 0)
                  .Fields("IdCuentaIvaCompras" & i).Value = mvarIVAs(i, 1)
                  mTotalIva = mTotalIva + .Fields("ImporteIVA" & i).Value
                  mIVAs = mIVAs & Format(mvarIVAs(i, 0), "##0.00") & "%  "
               Else
                  .Fields("AplicarIVA" & i).Value = "NO"
                  .Fields("ImporteIVA" & i).Value = 0
                  .Fields("IVAComprasPorcentaje" & i).Value = 0
               End If
            Next
            If txtPorcentajeIVADirecto.Visible Then
               .Fields("IVAComprasPorcentajeDirecto").Value = Val(txtPorcentajeIVADirecto.Text)
            Else
               .Fields("IVAComprasPorcentajeDirecto").Value = Null
            End If
            If DataCombo1(4).Visible Then
               .Fields("IdCuentaBancaria").Value = DataCombo1(4).BoundText
            End If
            .Fields("IdProvinciaDestino1").Value = mvarIdProvinciaDestino
            .Fields("PorcentajeProvinciaDestino1").Value = 100
         End With
         .Modificado = True
         
         Set oL = Lista.ListItems.Add
         oL.Tag = .Id
         oL.SmallIcon = "Nuevo"
         oL.Text = txtCuentaItem.Text
         oL.SubItems(1) = "" & mNombreCuenta
         oL.SubItems(2) = "" & DataCombo1(2).Text
         oL.SubItems(3) = "" & mIVAs
         oL.SubItems(4) = "" & Format(mTotalIva, "#0.00")
         oL.SubItems(5) = "" & Format(txtImporteItem.Text, "#0.00")
         
         .Registro.Fields("Item").Value = Lista.ListItems.Count
      End With
      
      CalculaComprobanteProveedor
      
      If mActivarCamposParaFF And txtNumeroCAI.Enabled Then
         txtNumeroCAI.SetFocus
      Else
         If DataCombo1(2).Enabled Then
            DataCombo1(2).SetFocus
         Else
            DataCombo1(1).SetFocus
         End If
      End If
   
   ElseIf Index = 1 Then
      
      Lista.Height = Lista.Height / 0.7
      lblItem(0).Visible = False
      lblItem(1).Visible = False
      lblItem(2).Visible = False
      lblItem(3).Visible = False
      lblItem(4).Visible = False
      txtCuentaItem.Visible = False
      DataCombo1(0).Visible = False
      DataCombo1(1).Visible = False
      Check2.Visible = False
      DataCombo1(2).Visible = False
      DataCombo1(3).Visible = False
      Frame2.Visible = False
      txtImporteItem.Visible = False
      txtPorcentajeIVADirecto.Visible = False
      cmdIngresarItem(0).Visible = False
      cmdIngresarItem(1).Visible = False
      Line5.Visible = False
      cmd(2).Enabled = True
      lblCuentaBanco.Visible = False
      DataCombo1(4).Visible = False
   
   End If
   
Salida:

   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

End Sub

Private Sub cmdProvinciasDestino_Click()

   Dim oF As frmDetComprobantesProveedoresProvincias

   VerificarProvinciasDestino

   Set oF = New frmDetComprobantesProveedoresProvincias
   With oF
      Set .ComprobanteProveedor = origen
      .Show vbModal, Me
   End With
   Unload oF
   Set oF = Nothing

End Sub

Private Sub DataCombo1_Change(Index As Integer)

   Dim oRs As ADOR.Recordset
   Dim i As Integer
   Dim mIdAux As Long
   
   Select Case Index
      Case 0
         If IsNumeric(DataCombo1(Index).BoundText) And _
               DataCombo1(Index).BoundText <> DataCombo1(Index).Text Then
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
            txtCuentaItem.Text = IIf(IsNull(oRs.Fields("Codigo").Value), 0, oRs.Fields("Codigo").Value)
            If Not IsNull(oRs.Fields("IdObra").Value) Then
               DataCombo1(2).BoundText = oRs.Fields("IdObra").Value
            End If
            If Not IsNull(oRs.Fields("EsCajaBanco").Value) And _
                  oRs.Fields("EsCajaBanco").Value = "BA" Then
               lblCuentaBanco.Visible = True
               DataCombo1(4).Visible = True
            Else
               lblCuentaBanco.Visible = False
               DataCombo1(4).Visible = False
            End If
            If oRs.Fields("IdTipoCuentaGrupo").Value = mvarIdTipoCuentaGrupoIVA Then
               For i = 0 To 9
                  Check1(i).Value = 0
               Next
               Frame2.Visible = False
               lblItem(4).Visible = True
               txtPorcentajeIVADirecto.Visible = True
            Else
               If Not Frame2.Visible Then
                  lblItem(4).Visible = False
                  txtPorcentajeIVADirecto.Text = ""
                  txtPorcentajeIVADirecto.Visible = False
                  Frame2.Visible = True
               End If
            End If
            oRs.Close
         Else
            txtCuentaItem.Text = ""
         End If
      Case 1
         If IsNumeric(DataCombo1(Index).BoundText) Then
            txtCuentaItem.Enabled = False
            DataCombo1(0).Enabled = False
            DataCombo1(3).Enabled = False
            Check2.Value = 1
         End If
      Case 2
         If DataCombo1(Index).Text <> DataCombo1(Index).BoundText Then
            
            mIdAux = 0
            If IsNumeric(DataCombo1(1).BoundText) Then mIdAux = DataCombo1(1).BoundText
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_CuentasGastoPorObraParaCombo", _
                        DataCombo1(Index).BoundText)
            Set DataCombo1(1).RowSource = oRs
            Set oRs = Nothing
            DataCombo1(1).BoundText = mIdAux
            
            If IsNumeric(DataCombo1(0).BoundText) Then
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorId", DataCombo1(0).BoundText)
               If oRs.RecordCount > 0 Then
                  If Not IsNull(oRs.Fields("IdObra").Value) Then
                     If oRs.Fields("IdObra").Value <> DataCombo1(Index).BoundText Then
                        DataCombo1(0).BoundText = 0
                        DataCombo1(0).Text = ""
                        txtCuentaItem.Text = ""
                        DataCombo1(1).BoundText = 0
                        DataCombo1(1).Text = ""
                     End If
                  End If
               End If
               oRs.Close
            End If
         End If
      Case 3
         If IsNumeric(DataCombo1(Index).BoundText) Then
            txtCuentaItem.Text = ""
            Dim mIdCuenta As Long
            If IsNumeric(DataCombo1(0).BoundText) Then
               mIdCuenta = DataCombo1(0).BoundText
            Else
               mIdCuenta = 0
            End If
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorGrupoParaCombo", DataCombo1(Index).BoundText)
            Set DataCombo1(0).RowSource = oRs
            DataCombo1(0).BoundText = mIdCuenta
         End If
   End Select
   
   Set oRs = Nothing

End Sub

Private Sub DataCombo1_Click(Index As Integer, Area As Integer)

   On Error GoTo Mal
   
   If IsNumeric(DataCombo1(Index).BoundText) Then
      Dim oRs As ADOR.Recordset
      Dim i As Integer
      Select Case Index
         Case 1
            If DataCombo1(Index).Enabled And IsNumeric(DataCombo1(2).BoundText) Then
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorObraCuentaGasto", Array(DataCombo1(2).BoundText, DataCombo1(1).BoundText))
               If oRs.RecordCount > 0 Then
                  If Len(DataCombo1(3).Text) > 0 Then
                     DataCombo1(3).BoundText = 0
                     If glbSeñal1 Then
                        Set DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorFechaParaCombo", DTFields(1).Value)
                     Else
                        Set DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerFiltrado("_ParaComprobantesProveedores")
                     End If
                  Else
                     If glbIdCuentaFFUsuario <> -1 Then
                        If glbSeñal1 Then
                           Set DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorFechaParaCombo", DTFields(1).Value)
                        Else
                           Set DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerFiltrado("_ParaComprobantesProveedores")
                        End If
                     End If
                  End If
                  DataCombo1(0).BoundText = oRs.Fields("IdCuenta").Value
                  txtCuentaItem.Text = oRs.Fields("Codigo").Value
               End If
               oRs.Close
            Else
               With origen.Registro
                  DataCombo1(0).BoundText = 0
                  DataCombo1(0).Text = ""
                  txtCuentaItem.Text = ""
               End With
            End If
      End Select
      Set oRs = Nothing
   End If

Salida:

   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error : " & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select
   Set oRs = Nothing

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DataCombo1_Validate(Index As Integer, Cancel As Boolean)

   If Index = 2 Then
      If Len(DataCombo1(Index).Text) = 0 Then
         DataCombo1(Index).BoundText = 0
         DataCombo1(Index).Text = ""
         If IsNumeric(DataCombo1(0).BoundText) Then
            Dim oRs As ADOR.Recordset
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorId", DataCombo1(0).BoundText)
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("IdObra").Value) Then
                  DataCombo1(Index).BoundText = oRs.Fields("IdObra").Value
               End If
            End If
            oRs.Close
            Set oRs = Nothing
         End If
      End If
   End If

End Sub

Private Sub dcfields_Change(Index As Integer)
      
   On Error GoTo Mal
   
   If IsNumeric(dcfields(Index).BoundText) Then
      Dim oRs As ADOR.Recordset
      If Index <> 2 Then origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
      Select Case Index
         Case 0
            MostrarDatos (0)
         Case 1
'            If mvarId = -1 Then
'               Dim oRs As ADOR.Recordset
'               Set oRs = Aplicacion.Parametros.Item(1).Registro
'               origen.Registro.Fields("NumeroReferencia").Value = oRs.Fields("ProximoComprobanteProveedorReferencia").Value
'               oRs.Close
'               Set oRs = Nothing
'            End If
            LabelComprobante
            Set oRs = Aplicacion.TiposComprobante.TraerFiltrado("_PorId", dcfields(Index).BoundText)
            lblLabels(12).Visible = False
            txtImputaComprobante.Visible = False
            Check3.Visible = False
            If oRs.RecordCount > 0 Then
               mvarExigirCAIComp = IIf(IsNull(oRs.Fields("ExigirCAI").Value), "SI", oRs.Fields("ExigirCAI").Value)
               If oRs.Fields("Coeficiente").Value < 0 Then
                  With lblLabels(12)
                     .Top = lblData(3).Top
                     .Left = lblData(3).Left + lblData(3).Width + 10
                     .Visible = True
                  End With
                  dcfields(7).Width = lblData(3).Width
                  With txtImputaComprobante
                     .Top = dcfields(7).Top
                     .Left = lblLabels(12).Left
                     .Visible = True
                  End With
                  With Check3
                     .Top = txtProvincia.Top + txtProvincia.Height + 200
                     .Left = txtProvincia.Left - 500
                     .Visible = True
                  End With
               End If
            End If
            oRs.Close
'            If dcfields(Index).BoundText = mvarIdTipoComprobanteFacturaCompraExportacion Then
'               cmd(4).Visible = True
'            Else
'               cmd(4).Visible = False
'            End If
         Case 3
            Dim mIdDetalleRecepcion As Long
            If dcfields(Index).BoundText = mvarIdMonedaPesos Then
               txtCotizacionMoneda.Text = 1
               txtCotizacionDolar.Text = txtCotizacion.Text
            Else
               Set oRs = Aplicacion.Cotizaciones.TraerFiltrado("_PorFechaMoneda", Array(DTFields(1).Value, dcfields(Index).BoundText))
               If oRs.RecordCount > 0 Then
                  txtCotizacionMoneda.Text = oRs.Fields("CotizacionLibre").Value
                  If dcfields(Index).BoundText = mvarIdMonedaDolar Then
                     txtCotizacionDolar.Text = oRs.Fields("CotizacionLibre").Value
                  ElseIf dcfields(Index).BoundText = glbIdMonedaEuro Then
                     txtCotizacionEuro.Text = oRs.Fields("CotizacionLibre").Value
                  End If
               Else
                  If Me.Visible Then
                     MsgBox "No hay cotizacion, ingresela manualmente"
                  End If
                  txtCotizacionMoneda.Text = ""
               End If
               oRs.Close
            End If
            mIdDetalleRecepcion = origen.IdDetalleRecepcion
            If mIdDetalleRecepcion <> 0 Then
               Set oRs = Aplicacion.Recepciones.TraerFiltrado("_DatosPorIdDetalleRecepcion", mIdDetalleRecepcion)
               If oRs.RecordCount > 0 Then
                  If dcfields(Index).BoundText <> IIf(IsNull(oRs.Fields("IdMonedaPedido").Value), 1, oRs.Fields("IdMonedaPedido").Value) Then
                     MsgBox "Atencion, el pedido original hecho al proveedor era en " & oRs.Fields("MonedaPedido").Value, vbInformation
                  End If
               End If
               oRs.Close
            End If
         Case 5
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorId", dcfields(Index).BoundText)
            If oRs.RecordCount > 0 Then
               txtCuentaOtros.Text = oRs.Fields("Codigo").Value
            End If
            oRs.Close
         Case 7
            If mvarId <= 0 Then
               Set oRs = Aplicacion.CondicionesCompra.TraerFiltrado("_PorId", dcfields(Index).BoundText)
               If oRs.RecordCount > 0 Then
                  txtDiasVencimiento.Text = IIf(IsNull(oRs.Fields("CantidadDias1").Value), 0, oRs.Fields("CantidadDias1").Value)
               End If
               oRs.Close
            End If
         Case 10
            Check5.Value = 1
      End Select
      Set oRs = Nothing
   End If
   
Salida:

   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error : " & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   SetDataComboDropdownListWidth 400
   
End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub dcfields_Validate(Index As Integer, Cancel As Boolean)

   If Index = 1 And IsNumeric(dcfields(Index).BoundText) Then
      Cancel = Not ControlarComprobante
      If dcfields(Index).Visible Then LabelComprobante
   End If
   
   If Index = 2 And IsNumeric(dcfields(Index).BoundText) Then
      origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
   End If

End Sub

Private Sub DTFields_Change(Index As Integer)

   If Index = 1 Then
      mvarCotizacion = Cotizacion(DTFields(1).Value, glbIdMonedaDolar)
      txtCotizacion.Text = mvarCotizacion
      If mvarId <= 0 Then
         If mvarCotizacion <> 0 And Val(txtCotizacionDolar.Text) = 0 Then
            txtCotizacionDolar.Text = mvarCotizacion
         End If
         mvarCotizacionEuro = Cotizacion(DTFields(1).Value, glbIdMonedaEuro)
         If mvarCotizacionEuro <> 0 And Val(txtCotizacionEuro.Text) = 0 Then
            txtCotizacionEuro.Text = mvarCotizacionEuro
         End If
      End If
   End If

End Sub

Private Sub DTFields_Click(Index As Integer)

   If Index = 1 Then
      mvarCotizacion = Cotizacion(DTFields(1).Value, glbIdMonedaDolar)
      txtCotizacion.Text = mvarCotizacion
      If mvarId <= 0 Then
         If mvarCotizacion <> 0 And Val(txtCotizacionDolar.Text) = 0 Then
            txtCotizacionDolar.Text = mvarCotizacion
         End If
         mvarCotizacionEuro = Cotizacion(DTFields(1).Value, glbIdMonedaEuro)
         If mvarCotizacionEuro <> 0 And Val(txtCotizacionEuro.Text) = 0 Then
            txtCotizacionEuro.Text = mvarCotizacionEuro
         End If
      End If
   End If

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub DTFields_Validate(Index As Integer, Cancel As Boolean)

   If glbSeñal1 And Index = 1 Then
      Dim mIdObra As Long
      mIdObra = 0
      If IsNumeric(DataCombo1(2).BoundText) Then mIdObra = DataCombo1(2).BoundText
      Set DataCombo1(2).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", DTFields(1).Value))
      DataCombo1(2).BoundText = mIdObra
   
      mIdObra = 0
      If IsNumeric(dcfields(2).BoundText) Then mIdObra = dcfields(2).BoundText
      Set dcfields(2).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", DTFields(1).Value))
      dcfields(2).BoundText = mIdObra
   End If

End Sub

Private Sub Form_Activate()
   
   If Me.GrabacionAutomatica And Me.Visible Then
      GrabacionAutomaticaComprobante
      Exit Sub
   End If
   
   CalculaComprobanteProveedor
   
   If Not IsNull(origen.Registro.Fields("Confirmado").Value) And _
         origen.Registro.Fields("Confirmado").Value = "NO" Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_VerificarProveedorNoConfirmado", mvarId)
      If oRs.Fields("Confirmado").Value = "NO" Then
         Me.Refresh
         MsgBox "No puede editar este comprobante porque no tiene confirmado el proveedor", vbExclamation
         Unload Me
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
   If mvarId > 0 And Me.NivelAcceso = Alto And mvarTotalComprobanteProveedor = 0 And _
         DTFields(1).Value > gblFechaUltimoCierre Then
      cmd(4).Enabled = True
   Else
      cmd(4).Enabled = False
      If mvarPrimeraVez And glbIdCuentaFFUsuario <> -1 And _
            IsNull(origen.Registro.Fields("IdProveedorEventual").Value) Then
         OtrosProveedores
      End If
   End If
   
   mvarPrimeraVez = False
   
'   lblIVA1.Caption = "IVA " & Format(mvarP_IVA1, "##0.00") & " %"
'   lblIVA2.Caption = "IVA " & Format(mvarP_IVA2, "##0.00") & " %"
   
   LabelComprobante

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   If KeyAscii <> 13 And mvarModoCodigoBarra Then
      mCadena = mCadena & Chr(KeyAscii)
      lblEstado.Caption = mCadena
      KeyAscii = 0
   ElseIf KeyAscii = 13 And mvarModoCodigoBarra Then
      Dim oRs As ADOR.Recordset
      Dim mAux1 As String
      If Len(mCadena) > 0 And Len(mCadena) <= 40 Then
         mAux1 = mId(mCadena, 1, 2) & "-" & mId(mCadena, 3, 8) & "-" & mId(mCadena, 11, 1)
         Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorCuit", mAux1)
         If oRs.RecordCount > 0 Then
            With origen.Registro
               .Fields("IdProveedor").Value = oRs.Fields("IdProveedor").Value
               Select Case mId(mCadena, 12, 2)
                  Case "01"
                     .Fields("IdTipoComprobante").Value = 11
                     .Fields("Letra").Value = "A"
                  Case "06"
                     .Fields("IdTipoComprobante").Value = 11
                     .Fields("Letra").Value = "B"
                  Case "11"
                     .Fields("IdTipoComprobante").Value = 11
                     .Fields("Letra").Value = "C"
                  Case "19"
                     .Fields("IdTipoComprobante").Value = 11
                     .Fields("Letra").Value = "E"
                  Case "02"
                     .Fields("IdTipoComprobante").Value = 18
                     .Fields("Letra").Value = "A"
                  Case "07"
                     .Fields("IdTipoComprobante").Value = 18
                     .Fields("Letra").Value = "B"
                  Case "12"
                     .Fields("IdTipoComprobante").Value = 18
                     .Fields("Letra").Value = "C"
                  Case "20"
                     .Fields("IdTipoComprobante").Value = 18
                     .Fields("Letra").Value = "E"
                  Case "03"
                     .Fields("IdTipoComprobante").Value = 10
                     .Fields("Letra").Value = "A"
                  Case "08"
                     .Fields("IdTipoComprobante").Value = 10
                     .Fields("Letra").Value = "B"
                  Case "13"
                     .Fields("IdTipoComprobante").Value = 10
                     .Fields("Letra").Value = "C"
                  Case "21"
                     .Fields("IdTipoComprobante").Value = 10
                     .Fields("Letra").Value = "E"
               End Select
               .Fields("NumeroComprobante1").Value = CInt(mId(mCadena, 14, 4))
               .Fields("NumeroCAI").Value = mId(mCadena, 18, 14)
               .Fields("FechaVencimientoCAI").Value = _
                  DateSerial(CInt(mId(mCadena, 32, 4)), _
                             CInt(mId(mCadena, 36, 2)), CInt(mId(mCadena, 38, 2)))
               DTFields(3).Value = .Fields("FechaVencimientoCAI").Value
            End With
            mvarLeyoCodigoBarra = True
         End If
         oRs.Close
      End If
      Set oRs = Nothing
      mCadena = ""
   ElseIf KeyAscii = 27 And mvarModoCodigoBarra Then
      mvarModoCodigoBarra = False
      lblEstado.Visible = False
      DoEvents
      mCadena = ""
   End If

End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)

   'F12 para inicializar el modo ingreso por codigo de barras
   If KeyCode = 123 Then
      mvarModoCodigoBarra = True
      lblEstado.Visible = True
      DoEvents
   'F11 para llamar el formulario de busqueda de proveedores por cuit
   ElseIf KeyCode = 122 Then
      cmdBuscarPorCuit_Click
   ElseIf KeyCode = 27 And mvarModoCodigoBarra Then
      mCadena = ""
      mvarModoCodigoBarra = False
      lblEstado.Visible = False
      DoEvents
   End If

End Sub

Private Sub Form_Load()

   Set ActL3 = New ControlForm
   
   Dim oI As ListImage
   Dim i As Integer
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   For Each oI In Img16.ListImages
      With Estado.Panels.Add(, , oI.Key)
         .Picture = oI.Picture
      End With
   Next
   
   AsignarTabulados Me
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   If Not oF_BuscarPorCuit Is Nothing Then
      Unload oF_BuscarPorCuit
      Set oF_BuscarPorCuit = Nothing
   End If

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set ActL3 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub lblComprobante_Click()

   lblComprobante.Visible = False
   lblLabels(1).Visible = True
   With dcfields(1)
      .Visible = True
      .SetFocus
   End With

End Sub

Private Sub lblTabIndex_Click()

   On Error Resume Next
   
   If lblTabIndex.BackColor = &HC0C0FF Then
      lblTabIndex.BackColor = &HC0FFC0
      ControlTabuladosInput Me
   Else
      ControlTabuladosOutput Me
      AsignarTabulados Me
      lblTabIndex.BackColor = &HC0C0FF
   End If
   
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

Private Sub Lista_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single)

   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oPr As ComPronto.ComprobanteProveedor
   Dim oRsPre As ADOR.Recordset
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim iFilas As Long, iColumnas As Long, mSubNumero As Long, mIdCuentaIvaCompras1 As Long, mIdTipoComprobante As Long
   Dim mIdCuentaDiferenciaCambio As Long, i As Long, mCodigoCuentaDiferenciaCambio As Long, mIdMoneda As Long
   Dim mIdTipoComprobanteNDInternaAcreedores As Long, mIdTipoComprobanteNCInternaAcreedores As Long
   Dim mIdCuentaIvaCompras(10) As Long
   Dim mvarSeguro As Integer
   Dim mIVAComprasPorcentaje(10) As Single
   Dim mIVAComprasPorcentaje1 As Single
   Dim mvarImporte As Double
   Dim s As String, mError As String, mvarConIVA As String, mAplicaIVA As String
   Dim mProcesar As Boolean
   Dim Filas, Columnas

   On Error GoTo Mal
   
'   If mvarId > 0 Then
'      MsgBox "Solo puede copiar a un comprobante vacio!", vbCritical
'      Exit Sub
'   End If
   
   If Data.GetFormat(ccCFText) Then
      s = Data.GetData(ccCFText)
   
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay un comprobante para copiar", vbCritical
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 1), "recep.alm.") <> 0 Then
         Option1.Value = True
         mError = ""
         
         Me.MousePointer = vbHourglass
         DoEvents
         
         IncorporarDesdeRecepcion Filas, mError
         
         Me.MousePointer = vbDefault
      
         If Len(mError) > 0 Then
            MsgBox "Se produjeron los siguientes errores : " & vbCrLf & mError
         End If
      
      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "Pedido") <> 0 Then
         If UBound(Filas) > 1 Then
            MsgBox "No puede copiar mas de un comprobante a la vez!", vbCritical
            Exit Sub
         End If
         
         Option1.Value = True
         mError = ""
         
         Me.MousePointer = vbHourglass
         DoEvents
         
         IncorporarDesdePedido Filas, mError
         
         Me.MousePointer = vbDefault
      
         If Len(mError) > 0 Then
            MsgBox "Se produjeron los siguientes errores : " & vbCrLf & mError
         End If
      
      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "Codigo") <> 0 And _
            InStr(1, Columnas(LBound(Columnas) + 3), "Proveedor") <> 0 Then
         If UBound(Filas) > 1 Then
            MsgBox "No puede copiar mas de un comprobante a la vez!", vbCritical
            Exit Sub
         End If
         
         Set oAp = Aplicacion
         
         Set oRs1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
         mIdCuentaDiferenciaCambio = IIf(IsNull(oRs1.Fields("IdCuentaDiferenciaCambio").Value), 0, oRs1.Fields("IdCuentaDiferenciaCambio").Value)
         mIdTipoComprobanteNDInternaAcreedores = IIf(IsNull(oRs1.Fields("IdTipoComprobanteNDInternaAcreedores").Value), 0, oRs1.Fields("IdTipoComprobanteNDInternaAcreedores").Value)
         mIdTipoComprobanteNCInternaAcreedores = IIf(IsNull(oRs1.Fields("IdTipoComprobanteNCInternaAcreedores").Value), 0, oRs1.Fields("IdTipoComprobanteNCInternaAcreedores").Value)
         oRs1.Close
         
         Option1.Value = True
            
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            
            Set oRs1 = oAp.DiferenciasCambio.TraerFiltrado("_PorPagosTodos", Columnas(2))
            
            mvarImporte = CDbl(oRs1.Fields("Dif.cambio $").Value)
            
            mCodigoCuentaDiferenciaCambio = 0
            If mIdCuentaDiferenciaCambio <> 0 Then
               mCodigoCuentaDiferenciaCambio = oAp.Cuentas.Item(mIdCuentaDiferenciaCambio).Registro.Fields("Codigo").Value
            End If
            
            If mvarImporte > 0 Then
               mIdTipoComprobante = mIdTipoComprobanteNCInternaAcreedores
            Else
               mIdTipoComprobante = mIdTipoComprobanteNDInternaAcreedores
               mvarImporte = mvarImporte * -1
            End If
            
            Set oRs = oAp.ComprobantesProveedores.TraerFiltrado("_PorId", oRs1.Fields("IdComprobanteProveedor").Value)
            Set oRsDet = oAp.ComprobantesProveedores.TraerFiltrado("_DetallePorIdCabecera", oRs1.Fields("IdComprobanteProveedor").Value)
            
            With origen.Registro
               .Fields("IdProveedor").Value = oRs1.Fields("IdProveedor").Value
               .Fields("IdObra").Value = oRsDet.Fields("IdObra").Value
               .Fields("IdTipoComprobante").Value = mIdTipoComprobante
               .Fields("NumeroComprobante2").Value = .Fields("NumeroReferencia").Value
               .Fields("IdDiferenciaCambio").Value = Columnas(2)
            End With
            
            With origen.DetComprobantesProveedores.Item(-1)
               With .Registro
                  .Fields("IdDetalleRecepcion").Value = oRsDet.Fields("IdDetalleRecepcion").Value
                  .Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                  .Fields("IdObra").Value = oRsDet.Fields("IdObra").Value
                  .Fields("IdCuenta").Value = mIdCuentaDiferenciaCambio
                  .Fields("CodigoCuenta").Value = mCodigoCuentaDiferenciaCambio
                  .Fields("Importe").Value = mvarImporte
                  .Fields("IdCuentaIvaCompras1").Value = Null
                  .Fields("IVAComprasPorcentaje1").Value = 0
                  .Fields("ImporteIVA1").Value = 0
                  .Fields("AplicarIVA1").Value = "NO"
                  .Fields("IdCuentaIvaCompras2").Value = Null
                  .Fields("IVAComprasPorcentaje2").Value = 0
                  .Fields("ImporteIVA2").Value = 0
                  .Fields("AplicarIVA2").Value = "NO"
                  .Fields("IdCuentaIvaCompras3").Value = Null
                  .Fields("IVAComprasPorcentaje3").Value = 0
                  .Fields("ImporteIVA3").Value = 0
                  .Fields("AplicarIVA3").Value = "NO"
                  .Fields("IdCuentaIvaCompras4").Value = Null
                  .Fields("IVAComprasPorcentaje4").Value = 0
                  .Fields("ImporteIVA4").Value = 0
                  .Fields("AplicarIVA4").Value = "NO"
                  .Fields("IdCuentaIvaCompras5").Value = Null
                  .Fields("IVAComprasPorcentaje5").Value = 0
                  .Fields("ImporteIVA5").Value = 0
                  .Fields("AplicarIVA5").Value = "NO"
                  .Fields("IdCuentaIvaCompras6").Value = Null
                  .Fields("IVAComprasPorcentaje6").Value = 0
                  .Fields("ImporteIVA6").Value = 0
                  .Fields("AplicarIVA6").Value = "NO"
                  .Fields("IdCuentaIvaCompras7").Value = Null
                  .Fields("IVAComprasPorcentaje7").Value = 0
                  .Fields("ImporteIVA7").Value = 0
                  .Fields("AplicarIVA7").Value = "NO"
                  .Fields("IdCuentaIvaCompras8").Value = Null
                  .Fields("IVAComprasPorcentaje8").Value = 0
                  .Fields("ImporteIVA8").Value = 0
                  .Fields("AplicarIVA8").Value = "NO"
                  .Fields("IdCuentaIvaCompras9").Value = Null
                  .Fields("IVAComprasPorcentaje9").Value = 0
                  .Fields("ImporteIVA9").Value = 0
                  .Fields("AplicarIVA9").Value = "NO"
                  .Fields("IdCuentaIvaCompras10").Value = Null
                  .Fields("IVAComprasPorcentaje10").Value = 0
                  .Fields("ImporteIVA10").Value = 0
                  .Fields("AplicarIVA10").Value = "NO"
               End With
               .Modificado = True
            End With
            oRs.Close
            oRs1.Close
            oRsDet.Close
         Next
         
         Set oRs = Nothing
         Set oRs1 = Nothing
         Set oRsDet = Nothing
         Set oAp = Nothing
         
         Set Lista.DataSource = origen.DetComprobantesProveedores.RegistrosConFormato
         
         txtCotizacionDolar.Text = 0
         txtCotizacionEuro.Text = 0

         MostrarDatos 0
         CalculaComprobanteProveedor
         
      ElseIf InStr(1, Columnas(LBound(Columnas) + 10), "Proveedor / Cuenta") <> 0 Then
         If UBound(Filas) > 1 Then
            MsgBox "No puede copiar mas de un comprobante a la vez!", vbCritical
            Exit Sub
         End If
         
         Me.MousePointer = vbHourglass
         DoEvents
         
         Columnas = Split(Filas(1), vbTab)
         
         If Lista.ListItems.Count > 0 Then
            mvarSeguro = MsgBox("Desea distribuir los items por pedidos segun el " & _
                                 "comprobante " & Columnas(4) & " ?" & vbCrLf & _
                                 "(Si contesta NO el comprobante sera copiado)", vbYesNo, _
                                 "Asignacion para costos de importacion")
            If mvarSeguro = vbYes Then
               AsignarParaCostosImportacion Columnas(2)
               GoTo Salida
            End If
         End If
         
         Set oAp = Aplicacion
         
         Set oPr = oAp.ComprobantesProveedores.Item(Columnas(2))
         Set oRsPre = oPr.DetComprobantesProveedores.TraerTodos
         
         Set oRs = oPr.Registro
                  
         With origen.Registro
'            For i = 1 To oRs.Fields.Count - 1
'               If oRs.Fields(i).Name <> "NumeroComprobante2" And _
'                  oRs.Fields(i).Name <> "NumeroReferencia" And _
'                  oRs.Fields(i).Name <> "CotizacionDolar" Then
'                  .Fields(i).Value = oRs.Fields(i).Value
'               End If
'            Next
            .Fields("IdProveedor").Value = oRs.Fields("IdProveedor").Value
            .Fields("IdTipoComprobante").Value = oRs.Fields("IdTipoComprobante").Value
            .Fields("FechaComprobante").Value = oRs.Fields("FechaComprobante").Value
            .Fields("Letra").Value = oRs.Fields("Letra").Value
            .Fields("NumeroComprobante1").Value = oRs.Fields("NumeroComprobante1").Value
            .Fields("FechaRecepcion").Value = oRs.Fields("FechaRecepcion").Value
            .Fields("FechaVencimiento").Value = oRs.Fields("FechaVencimiento").Value
            .Fields("PorcentajeBonificacion").Value = oRs.Fields("PorcentajeBonificacion").Value
            .Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
            .Fields("DiasVencimiento").Value = oRs.Fields("DiasVencimiento").Value
            .Fields("IdObra").Value = oRs.Fields("IdObra").Value
            .Fields("IdProveedorEventual").Value = oRs.Fields("IdProveedorEventual").Value
            .Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
            .Fields("IdMoneda").Value = oRs.Fields("IdMoneda").Value
            .Fields("CotizacionMoneda").Value = oRs.Fields("CotizacionMoneda").Value
            .Fields("AjusteIVA").Value = oRs.Fields("AjusteIVA").Value
            .Fields("PorcentajeIVAAplicacionAjuste").Value = oRs.Fields("PorcentajeIVAAplicacionAjuste").Value
            .Fields("BienesOServicios").Value = oRs.Fields("BienesOServicios").Value
            .Fields("IdIBCondicion").Value = oRs.Fields("IdIBCondicion").Value
            .Fields("IdProvinciaDestino").Value = oRs.Fields("IdProvinciaDestino").Value
            .Fields("IdTipoRetencionGanancia").Value = oRs.Fields("IdTipoRetencionGanancia").Value
            .Fields("NumeroCAI").Value = oRs.Fields("NumeroCAI").Value
            .Fields("FechaVencimientoCAI").Value = oRs.Fields("FechaVencimientoCAI").Value
            .Fields("IdCodigoAduana").Value = oRs.Fields("IdCodigoAduana").Value
            .Fields("IdCodigoDestinacion").Value = oRs.Fields("IdCodigoDestinacion").Value
            .Fields("NumeroDespacho").Value = oRs.Fields("NumeroDespacho").Value
            .Fields("DigitoVerificadorNumeroDespacho").Value = oRs.Fields("DigitoVerificadorNumeroDespacho").Value
            .Fields("FechaDespachoAPlaza").Value = oRs.Fields("FechaDespachoAPlaza").Value
            .Fields("IdCondicionCompra").Value = oRs.Fields("IdCondicionCompra").Value
            .Fields("Importacion_FOB").Value = oRs.Fields("Importacion_FOB").Value
            .Fields("Importacion_PosicionAduana").Value = oRs.Fields("Importacion_PosicionAduana").Value
            .Fields("Importacion_Despacho").Value = oRs.Fields("Importacion_Despacho").Value
            .Fields("Importacion_Guia").Value = oRs.Fields("Importacion_Guia").Value
            .Fields("Importacion_IdPaisOrigen").Value = oRs.Fields("Importacion_IdPaisOrigen").Value
            .Fields("Importacion_FechaEmbarque").Value = oRs.Fields("Importacion_FechaEmbarque").Value
            .Fields("Importacion_FechaOficializacion").Value = oRs.Fields("Importacion_FechaOficializacion").Value
            .Fields("InformacionAuxiliar").Value = oRs.Fields("InformacionAuxiliar").Value
            .Fields("GravadoParaSUSS").Value = oRs.Fields("GravadoParaSUSS").Value
            .Fields("PorcentajeParaSUSS").Value = oRs.Fields("PorcentajeParaSUSS").Value
            .Fields("FondoReparo").Value = oRs.Fields("FondoReparo").Value
            .Fields("ReintegroImporte").Value = oRs.Fields("ReintegroImporte").Value
            .Fields("ReintegroDespacho").Value = oRs.Fields("ReintegroDespacho").Value
            .Fields("ReintegroIdMoneda").Value = oRs.Fields("ReintegroIdMoneda").Value
            .Fields("ReintegroIdCuenta").Value = oRs.Fields("ReintegroIdCuenta").Value
            .Fields("IdCuentaOtros").Value = oRs.Fields("IdCuentaOtros").Value
            If Not IsNull(.Fields("IdProveedor").Value) Then
               Option1.Value = True
            ElseIf Not IsNull(.Fields("IdCuentaOtros").Value) Then
               Option5.Value = True
            Else
               Option2.Value = True
               If Not IsNull(.Fields("IdOrdenPago").Value) Then
                  Set oRs1 = oAp.OrdenesPago.Item(.Fields("IdOrdenPago").Value).Registro
                  If oRs1.RecordCount > 0 Then
                     txtOrdenPago.Text = oRs1.Fields("NumeroOrdenPago").Value
                  End If
                  oRs1.Close
                  Set oRs1 = Nothing
               End If
            End If
            mvarCotizacion = Cotizacion(Date, glbIdMonedaDolar)
            .Fields("CotizacionDolar").Value = mvarCotizacion
            txtCotizacionDolar.Text = mvarCotizacion
            mvarCotizacionEuro = Cotizacion(Date, glbIdMonedaEuro)
            .Fields("CotizacionEuro").Value = mvarCotizacionEuro
            txtCotizacionEuro.Text = mvarCotizacionEuro
            txtCotizacionMoneda.Text = IIf(IsNull(.Fields("CotizacionMoneda").Value), 0, .Fields("CotizacionMoneda").Value)
            txtTotal(3).Text = IIf(IsNull(.Fields("AjusteIVA").Value), 0, .Fields("AjusteIVA").Value)
         End With
   
         Do While Not oRsPre.EOF
            Set oRsDet = oPr.DetComprobantesProveedores.Item(oRsPre.Fields(0).Value).Registro
            With origen.DetComprobantesProveedores.Item(-1)
               For i = 2 To oRsDet.Fields.Count - 1
                  .Registro.Fields(i).Value = oRsDet.Fields(i).Value
               Next
               .Modificado = True
            End With
            oRsDet.Close
            Set oRsDet = Nothing
            oRsPre.MoveNext
         Loop
         oRsPre.Close
         
         Set oRsPre = Nothing
         Set oPr = Nothing
         Set oAp = Nothing
         
         Set Lista.DataSource = origen.DetComprobantesProveedores.RegistrosConFormato
         
         MostrarDatos 0
         CalculaComprobanteProveedor
         
         Me.MousePointer = vbDefault
      End If
   End If

Salida:
   Set oRs = Nothing
   Set oRs1 = Nothing
   Set oRsDet = Nothing
   Set oRsPre = Nothing
   Set oPr = Nothing
   Set oAp = Nothing
         
   Me.MousePointer = vbDefault
   
   Exit Sub
   
Mal:
   MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   Resume Salida

End Sub

Private Sub Lista_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single, State As Integer)

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

Private Sub Lista_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         If Lista.ListItems.Count > 0 Then Editar Lista.SelectedItem.Tag
      Case 2
         With Lista.SelectedItem
            origen.DetComprobantesProveedores.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
            CalculaComprobanteProveedor
         End With
      Case 3
         AsignarRubrosFinancieros
      Case 4
         DistribuirPorObras
      Case 5
         DuplicarItemComprobante
   End Select

End Sub

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub MostrarDatos(Index As Integer)

   On Error GoTo Mal
   
   Dim mvarLocalidad As Integer, mvarProvincia As Integer, mvarIBCondicion As Integer
   Dim mvarIdIBCondicion As Integer, mvarIGCondicion As Integer, mvarIdImpuestoDirectoSUSS As Integer
   Dim mvarIdTipoRetencionGanancia As Integer, mvarIdCondicionCompra As Integer
   Dim mIdProv As Long
   Dim Cambio As Boolean
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   
   ' Cargo los datos del Proveedor
  
   Me.MousePointer = vbHourglass
   
   txtCodigoProveedor.Text = ""
   txtDireccion.Text = ""
   txtCodigoPostal.Text = ""
   txtCuit.Text = ""
   txtTelefono.Text = ""
   txtEmail.Text = ""
   txtLocalidad.Text = ""
   txtProvincia.Text = ""
   txtCondicionIva.Text = ""
   mIdProv = 0
   
   With origen.Registro
      If Not IsNull(.Fields("IdProveedor").Value) And IsNumeric(dcfields(0).BoundText) Then
         mIdProv = .Fields("IdProveedor").Value
         If mvarIdProveedor <> dcfields(0).BoundText Then
            Cambio = True
            mvarIdProveedor = dcfields(0).BoundText
         Else
            Cambio = False
         End If
         Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", dcfields(0).BoundText)
      Else
         If Not IsNull(.Fields("IdProveedorEventual").Value) Then
            mIdProv = .Fields("IdProveedorEventual").Value
            Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", mIdProv)
         Else
            GoTo Salida
         End If
         If Not IsNull(.Fields("IdCuenta").Value) Then
            Set oRs1 = Aplicacion.Cuentas.TraerFiltrado("_PorId", .Fields("IdCuenta").Value)
            If oRs1.RecordCount > 0 Then
               txtCuenta.Text = IIf(IsNull(oRs1.Fields("Descripcion").Value), 0, oRs1.Fields("Descripcion").Value)
               If mvarId <= 0 Then
                  .Fields("NumeroRendicionFF").Value = IIf(IsNull(oRs1.Fields("NumeroAuxiliar").Value), 1, oRs1.Fields("NumeroAuxiliar").Value)
               End If
            End If
            oRs1.Close
         Else
            GoTo Salida
         End If
      End If
   End With
   
   With oRs
      If .RecordCount = 0 Then GoTo Salida
      If mvarId <= 0 And Not IsNull(.Fields("FechaLimiteCondicionIVA").Value) And _
            .Fields("FechaLimiteCondicionIVA").Value <= Date Then
         MsgBox "El proveedor tiene vencido su certificado de condicion IVA", vbExclamation
         origen.Registro.Fields("IdProveedor").Value = Null
         GoTo Salida
      End If
      txtCodigoProveedor.Text = IIf(IsNull(.Fields("CodigoEmpresa").Value), 0, .Fields("CodigoEmpresa").Value)
      txtProveedorEventual.Text = IIf(IsNull(.Fields("RazonSocial").Value), 0, .Fields("RazonSocial").Value)
      txtDireccion.Text = IIf(IsNull(.Fields("Direccion").Value), "", .Fields("Direccion").Value)
      txtCodigoPostal.Text = IIf(IsNull(.Fields("CodigoPostal").Value), "", .Fields("CodigoPostal").Value)
      txtCuit.Text = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
      txtTelefono.Text = IIf(IsNull(.Fields("Telefono1").Value), "", .Fields("Telefono1").Value)
      txtEmail.Text = IIf(IsNull(.Fields("Email").Value), "", .Fields("Email").Value)
      mvarLocalidad = IIf(IsNull(.Fields("IdLocalidad").Value), 0, .Fields("IdLocalidad").Value)
      mvarProvincia = IIf(IsNull(.Fields("IdProvincia").Value), 0, .Fields("IdProvincia").Value)
      mvarIdProvinciaDestino = mvarProvincia
      mvarTipoIVA = IIf(IsNull(.Fields("IdCodigoIva").Value), 1, .Fields("IdCodigoIva").Value)
      mvarIBCondicion = IIf(IsNull(.Fields("IBCondicion").Value), 0, .Fields("IBCondicion").Value)
      mvarIdIBCondicion = IIf(IsNull(.Fields("IdIBCondicionPorDefecto").Value), 0, .Fields("IdIBCondicionPorDefecto").Value)
      mvarIGCondicion = IIf(IsNull(.Fields("IGCondicion").Value), 0, .Fields("IGCondicion").Value)
      mvarIdTipoRetencionGanancia = IIf(IsNull(.Fields("IdTipoRetencionGanancia").Value), 0, .Fields("IdTipoRetencionGanancia").Value)
      mvarTipoProveedor = IIf(IsNull(.Fields("TipoProveedor").Value), 0, .Fields("TipoProveedor").Value)
      mvarIdCondicionCompra = IIf(IsNull(.Fields("IdCondicionCompra").Value), 0, .Fields("IdCondicionCompra").Value)
      mvarIdImpuestoDirectoSUSS = IIf(IsNull(.Fields("IdImpuestoDirectoSUSS").Value), 0, .Fields("IdImpuestoDirectoSUSS").Value)
      If mvarId <= 0 Or IsNull(origen.Registro.Fields("InformacionAuxiliar").Value) Then
         If txtInformacionAuxiliar.Visible Then
            origen.Registro.Fields("InformacionAuxiliar").Value = IIf(IsNull(.Fields("InformacionAuxiliar").Value), "", .Fields("InformacionAuxiliar").Value)
         Else
            origen.Registro.Fields("InformacionAuxiliar").Value = Null
         End If
      End If
      If mvarId <= 0 And Not IsNull(.Fields("IdListaPrecios").Value) Then
         dcfields(9).BoundText = .Fields("IdListaPrecios").Value
      End If
      
      If mvarId <= 0 And txtPorcentajeParaSUSS.Visible Then
         Set oRs = Aplicacion.ImpuestosDirectos.TraerFiltrado("_PorId", mvarIdImpuestoDirectoSUSS)
         If oRs.RecordCount > 0 Then
            origen.Registro.Fields("PorcentajeParaSUSS").Value = IIf(IsNull(oRs.Fields("Tasa").Value), 0, oRs.Fields("Tasa").Value)
         Else
            origen.Registro.Fields("PorcentajeParaSUSS").Value = 0
         End If
         oRs.Close
      End If
      
      If mvarIBCondicion = 2 Or mvarIBCondicion = 3 Then
         If mvarIdIBCondicion <> 0 And _
               (IsNull(origen.Registro.Fields(dcfields(4).DataField).Value) Or mvarId <= 0) Then
            origen.Registro.Fields(dcfields(4).DataField).Value = mvarIdIBCondicion
         End If
         If Not mActivarCamposParaFF Then dcfields(4).Enabled = True
      Else
         origen.Registro.Fields(dcfields(4).DataField).Value = Null
         dcfields(4).Enabled = False
      End If
      
      If mvarIGCondicion = 2 Or mvarIGCondicion = 3 Then
         If mvarIdTipoRetencionGanancia <> 0 And _
               (IsNull(origen.Registro.Fields(dcfields(6).DataField).Value) Or mvarId <= 0) Then
            origen.Registro.Fields(dcfields(6).DataField).Value = mvarIdTipoRetencionGanancia
         End If
         If Not mActivarCamposParaFF Then dcfields(6).Enabled = True
      Else
         origen.Registro.Fields(dcfields(6).DataField).Value = Null
         dcfields(6).Enabled = False
      End If
      
'      If mvarId <= 0 Then
'         origen.Registro.Fields(dcfields(5).DataField).Value = mvarProvincia
'      End If
            
      If mvarId <= 0 Or IIf(IsNull(origen.Registro.Fields("IdCodigoIva").Value), 0, origen.Registro.Fields("IdCodigoIva").Value) = 0 Then
         origen.Registro.Fields("IdCodigoIva").Value = mvarTipoIVA
      End If
      
      If (mvarId <= 0 Or IsNull(origen.Registro.Fields(dcfields(7).DataField).Value)) And _
            Not mCondicionDesdePedido And mvarIdCondicionCompra <> 0 Then
         origen.Registro.Fields(dcfields(7).DataField).Value = mvarIdCondicionCompra
      End If
      
      If Not IsNull(.Fields("BienesOServicios").Value) Then
         If .Fields("BienesOServicios").Value = "B" Then
            Option3.Value = True
         Else
            Option4.Value = True
         End If
      End If
      
      If Not IsNull(.Fields("FechaLimiteExentoGanancias").Value) Then
         If .Fields("FechaLimiteExentoGanancias").Value < DTFields(0).Value Then
            MsgBox "El proveedor tiene vencida su condicion de exento" & vbCrLf & _
                     "al impuesto a las ganancias (" & .Fields("FechaLimiteExentoGanancias").Value & _
                     "), revise la condicion", vbInformation
         End If
      End If
      If Not IsNull(.Fields("FechaLimiteExentoIIBB").Value) Then
         If .Fields("FechaLimiteExentoIIBB").Value < DTFields(0).Value Then
            MsgBox "El proveedor tiene vencida su condicion de exento" & vbCrLf & _
                     "al impuesto a los ingresos brutos (" & .Fields("FechaLimiteExentoGanancias").Value & _
                     "), revise la condicion", vbInformation
         End If
      End If
      
      .Close
   End With
   
   If mvarId <= 0 And mIdProv <> 0 And Not mvarLeyoCodigoBarra Then
      Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_UltimoComprobantePorIdProveedor", mIdProv)
      If oRs.RecordCount > 0 Then
         With origen.Registro
            If IsNull(oRs.Fields("NumeroCAE").Value) And Not IsNull(oRs.Fields("NumeroCAI").Value) And IsNull(.Fields("NumeroCAI").Value) Then
               .Fields("NumeroCAI").Value = oRs.Fields("NumeroCAI").Value
               If Not IsNull(oRs.Fields("FechaVencimientoCAI").Value) And _
                     (IsNull(.Fields("FechaVencimientoCAI").Value) Or .Fields("FechaVencimientoCAI").Value = Date) Then
                  .Fields("FechaVencimientoCAI").Value = oRs.Fields("FechaVencimientoCAI").Value
                  DTFields(3).Value = oRs.Fields("FechaVencimientoCAI").Value
               Else
                  .Fields("FechaVencimientoCAI").Value = Null
                  DTFields(3).Value = Null
               End If
            End If
         End With
      Else
         With origen.Registro
            .Fields("NumeroCAI").Value = Null
            .Fields("FechaVencimientoCAI").Value = Null
            DTFields(3).Value = Null
         End With
      End If
      oRs.Close
   
      If EstadoEntidad("Proveedores", mIdProv) = "INACTIVO" Then
         MsgBox "Proveedor inhabilitado, no podra registrar este comprobante", vbExclamation
      End If
   End If
   
   Set oRs = Aplicacion.Localidades.TraerFiltrado("_PorId", mvarLocalidad)
   If oRs.RecordCount > 0 Then
      txtLocalidad.Text = IIf(IsNull(oRs.Fields("Nombre").Value), "", oRs.Fields("Nombre").Value)
   End If
   oRs.Close
   
   Set oRs = Aplicacion.Provincias.TraerFiltrado("_PorId", mvarProvincia)
   If oRs.RecordCount > 0 Then
      txtProvincia.Text = IIf(IsNull(oRs.Fields("Nombre").Value), "", oRs.Fields("Nombre").Value)
   End If
   oRs.Close
   
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DescripcionIva", "_PorId", mvarTipoIVA)
   If oRs.RecordCount > 0 Then
      txtCondicionIva.Text = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
      mvarExigirCAI = IIf(IsNull(oRs.Fields("ExigirCAI").Value), "SI", oRs.Fields("ExigirCAI").Value)
   End If
   oRs.Close
   
   If Len(txtLetra.Text) = 0 Or mvarId <= 0 Then
      Select Case mvarTipoIVA
         Case 1
            origen.Registro.Fields("Letra").Value = "A"
         Case 2
            origen.Registro.Fields("Letra").Value = "C"
         Case 3
            origen.Registro.Fields("Letra").Value = "E"
         Case Else
            origen.Registro.Fields("Letra").Value = "C"
      End Select
   End If
   
Salida:
   Set oRs = Nothing
   Set oRs1 = Nothing
   
   Me.MousePointer = vbDefault
   
   Exit Sub

Mal:
   Dim mvarResp As Integer
   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error : " & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

End Sub

Private Sub CalculaComprobanteProveedor()

   Dim oRs As ADOR.Recordset
   Dim oL As ListItem
   Dim i As Integer
   Dim mImporte As Double, mPorcentajeIVA As Double
   
   mvarSubTotal = 0
   mvarIVANoDiscriminado = 0
   mvarIVA1 = 0
   If txtLetra.Text <> "A" And txtLetra.Text <> "M" Then mvarIVA1 = 0
   mvarIVA2 = 0
   mvarTotalComprobanteProveedor = 0
   mvarAjusteIVA = 0
   
   For Each oL In Lista.ListItems
      With origen.DetComprobantesProveedores.Item(oL.Tag)
         If Not .Eliminado Then
'            mvarSubTotal = mvarSubTotal + Val(oL.ListSubItems(3))
'            If Val(oL.ListSubItems(2)) <> 0 And (Not mSenialIVA Or Len(txtTotal(1).Text) = 0) Then
'               mvarIVA1 = mvarIVA1 + Round(Val(oL.ListSubItems(3)) * Val(oL.ListSubItems(2)) / 100, mvarDecimales)
'               mSenialIVA = False
'            End If
            With .Registro
               mImporte = IIf(IsNull(.Fields("Importe").Value), 0, .Fields("Importe").Value)
               mvarSubTotal = mvarSubTotal + mImporte
               For i = 1 To 10
                  If .Fields("AplicarIVA" & i).Value = "SI" Then
                     mPorcentajeIVA = IIf(IsNull(.Fields("IVAComprasPorcentaje" & i).Value), 0, .Fields("IVAComprasPorcentaje" & i).Value)
                     If txtLetra.Text = "A" Or txtLetra.Text = "M" Then
                        mvarIVA1 = mvarIVA1 + Round(mImporte * mPorcentajeIVA / 100, mvarDecimales)
                     Else
                        mvarIVANoDiscriminado = mvarIVANoDiscriminado + Round(mImporte - (mImporte / (1 + (mPorcentajeIVA / 100))), mvarDecimales)
                     End If
                  End If
               Next
            End With
         End If
      End With
   Next
   
   mvarAjusteIVA = Val(txtTotal(3).Text)
   mvarTotalComprobanteProveedor = mvarSubTotal + mvarIVA1 + mvarIVA2 + mvarAjusteIVA
   
   txtTotal(0).Text = Format(mvarSubTotal, "#,##0.00")
   txtTotal(1).Text = Format(mvarIVA1, "#,##0.00")
   txtTotal(2).Text = Format(mvarIVA2, "#,##0.00")
   txtTotal(4).Text = Format(0, "#,##0.00")
   txtTotal(5).Text = Format(mvarTotalComprobanteProveedor, "#,##0.00")
   
End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      txtProveedorEventual.Visible = False
      txtCuenta.Visible = False
      dcfields(5).Visible = False
      With txtCuentaOtros
         .Visible = False
         .Text = ""
      End With
      txtCodigoProveedor.Visible = True
      dcfields(0).Visible = True
      cmdBuscarPorCuit.Visible = True
      With txtOrdenPago
         .Text = ""
         .Enabled = False
      End With
      Frame3.Visible = True
      lblData(1).Visible = True
      lblData(2).Visible = True
      lblLabels(0).Visible = True
      lblLabels(10).Visible = True
      lblLabels(11).Visible = True
      lblLabels(19).Visible = False
      With txtDireccion
         If txtNumeroRendicionFF.Visible And mActivarCamposParaFF1 Then .Width = .Width * 1.5
         .Visible = True
      End With
      txtCodigoPostal.Visible = True
      txtLocalidad.Visible = True
      txtProvincia.Visible = True
      txtTelefono.Visible = True
      txtEmail.Visible = True
      txtNumeroRendicionFF.Visible = False
      dcfields(4).Visible = True
      dcfields(6).Visible = True
      With origen.Registro
         .Fields("IdProveedorEventual").Value = Null
         .Fields("IdCuentaOtros").Value = Null
      End With
      Frame4.Visible = True
      lblLabels(2).Caption = "Proveedor :"
      CUIT1.Visible = False
      txtCuit.Visible = True
      cmd(6).Enabled = True
      If mActivarCamposParaFF Then
         dcfields(7).Enabled = True
         DTFields(0).Enabled = True
         DTFields(1).Enabled = True
         DTFields(2).Enabled = True
         txtDiasVencimiento.Enabled = True
         dcfields(3).Enabled = True
         dcfields(4).Enabled = True
         dcfields(6).Enabled = True
         dcfields(8).Enabled = True
         txtCotizacionMoneda.Enabled = True
         txtCotizacionDolar.Enabled = True
         txtCotizacionEuro.Enabled = True
         Frame4.Enabled = True
         txtCuenta.Enabled = True
         cmdIngresarItem(1).Enabled = True
         txtOrdenPago.Enabled = True
         cmdImportaciones.Enabled = True
      End If
   End If
   
End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      Dim mCondicionCompra As Integer
      With txtProveedorEventual
         .Left = txtCodigoProveedor.Left
         .Top = txtCodigoProveedor.Top
         .Width = txtDireccion.Width / 2
         .Visible = True
      End With
      With txtCuenta
         .Left = txtProveedorEventual.Left + txtDireccion.Width / 2
         .Top = txtProveedorEventual.Top
         .Width = txtProveedorEventual.Width
         .Visible = True
      End With
      txtCodigoProveedor.Visible = False
      dcfields(0).Visible = False
      cmdBuscarPorCuit.Visible = False
      dcfields(5).Visible = False
      With txtCuentaOtros
         .Visible = False
         .Text = ""
      End With
      txtOrdenPago.Enabled = True
      Frame3.Visible = False
      lblData(1).Visible = True
      lblData(2).Visible = True
      lblLabels(0).Visible = True
      lblLabels(10).Visible = True
      lblLabels(11).Visible = True
      With txtDireccion
         If mActivarCamposParaFF1 Then .Width = .Width / 1.5
         .Visible = True
      End With
      txtCodigoPostal.Visible = True
      txtLocalidad.Visible = True
      txtProvincia.Visible = True
      txtTelefono.Visible = True
      txtEmail.Visible = True
      If mActivarCamposParaFF1 Then
         lblLabels(19).Visible = True
         With txtNumeroRendicionFF
            .Visible = True
            .Enabled = False
         End With
      End If
      dcfields(4).Visible = True
      dcfields(6).Visible = True
      With origen.Registro
         .Fields("IdProveedor").Value = Null
         .Fields("IdCuentaOtros").Value = Null
      End With
      mCondicionCompra = Val(BuscarClaveINI("Condicion de compra default para fondos fijos"))
      If mCondicionCompra <> 0 Then
         origen.Registro.Fields("IdCondicionCompra").Value = mCondicionCompra
      End If
      If Me.Visible Then
         OtrosProveedores
      Else
         MostrarDatos 0
      End If
      Frame4.Visible = True
      lblLabels(2).Caption = "Proveedor :"
      CUIT1.Visible = False
      txtCuit.Visible = True
      cmd(6).Enabled = False
      If mActivarCamposParaFF Then
         dcfields(7).Enabled = False
         DTFields(0).Enabled = False
         DTFields(1).Enabled = False
         DTFields(2).Enabled = False
         txtDiasVencimiento.Enabled = False
         dcfields(3).Enabled = False
         dcfields(4).Enabled = False
         dcfields(6).Enabled = False
         dcfields(8).Enabled = False
         txtCotizacionMoneda.Enabled = False
         txtCotizacionDolar.Enabled = False
         txtCotizacionEuro.Enabled = False
         Frame4.Enabled = False
         txtCuenta.Enabled = False
         cmdIngresarItem(1).Enabled = False
         txtOrdenPago.Enabled = False
         cmdImportaciones.Enabled = False
      End If
   End If
   
End Sub

Private Sub Option5_Click()

   If Option5.Value Then
      txtProveedorEventual.Visible = False
      txtCuenta.Visible = False
      txtCodigoProveedor.Visible = False
      dcfields(0).Visible = False
      cmdBuscarPorCuit.Visible = False
      With txtOrdenPago
         .Text = ""
         .Enabled = False
      End With
      Frame3.Visible = False
      lblData(1).Visible = False
      lblData(2).Visible = False
      lblLabels(0).Visible = False
      lblLabels(10).Visible = False
      lblLabels(11).Visible = False
      lblLabels(19).Visible = False
      With txtDireccion
         If txtNumeroRendicionFF.Visible And mActivarCamposParaFF1 Then .Width = .Width * 1.5
         .Visible = False
      End With
      txtCodigoPostal.Visible = False
      txtLocalidad.Visible = False
      txtProvincia.Visible = False
      txtTelefono.Visible = False
      txtEmail.Visible = False
      txtNumeroRendicionFF.Visible = False
      dcfields(4).Visible = False
      dcfields(6).Visible = False
      With origen.Registro
         .Fields("IdProveedor").Value = Null
         .Fields("IdProveedorEventual").Value = Null
      End With
      With dcfields(5)
         .Top = dcfields(0).Top
         .Left = dcfields(0).Left
         .Visible = True
      End With
      With txtCuentaOtros
         .Top = txtCodigoProveedor.Top
         .Left = txtCodigoProveedor.Left
         .Visible = True
      End With
      Frame4.Visible = False
      lblLabels(2).Caption = "Cuenta :"
      txtCuit.Visible = False
      With CUIT1
         .Top = txtCuit.Top
         .Left = txtCuit.Left
         .Visible = True
      End With
      cmd(6).Enabled = False
      If mActivarCamposParaFF Then
         dcfields(7).Enabled = True
         DTFields(0).Enabled = True
         DTFields(1).Enabled = True
         DTFields(2).Enabled = True
         txtDiasVencimiento.Enabled = True
         dcfields(3).Enabled = True
         dcfields(4).Enabled = True
         dcfields(6).Enabled = True
         dcfields(8).Enabled = True
         txtCotizacionMoneda.Enabled = True
         txtCotizacionDolar.Enabled = True
         txtCotizacionEuro.Enabled = True
         Frame4.Enabled = True
         txtCuenta.Enabled = True
         cmdIngresarItem(1).Enabled = True
         txtOrdenPago.Enabled = True
         cmdImportaciones.Enabled = True
      End If
   End If
   
End Sub

Private Sub txtCodigoProveedor_Change()

'   If Len(txtCodigoProveedor.Text) > 0 And txtCodigoProveedor.Visible Then
'      Dim oRs As ADOR.Recordset
'      Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorCodigoEmpresa", txtCodigoProveedor.Text)
'      If oRs.RecordCount > 0 Then
'         origen.Registro.Fields("IdProveedor").Value = oRs.Fields(0).Value
'      Else
'         origen.Registro.Fields("IdProveedor").Value = Null
'      End If
'      oRs.Close
'      Set oRs = Nothing
'   End If

End Sub

Private Sub txtCodigoProveedor_GotFocus()

   With txtCodigoProveedor
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoProveedor_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoProveedor_Validate(Cancel As Boolean)

   If Len(txtCodigoProveedor.Text) > 0 And txtCodigoProveedor.Visible Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorCodigoEmpresa", txtCodigoProveedor.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdProveedor").Value = oRs.Fields(0).Value
      Else
         origen.Registro.Fields("IdProveedor").Value = Null
      End If
      oRs.Close
      Set oRs = Nothing
   End If

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

   With origen.Registro
      If .Fields("IdMoneda").Value = mvarIdMonedaDolar Then
         If IsNull(.Fields("IdDiferenciaCambio").Value) Then txtCotizacionMoneda.Text = txtCotizacionDolar.Text
      End If
   End With

End Sub

Private Sub txtCotizacionEuro_GotFocus()

   With txtCotizacionEuro
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCotizacionEuro_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCotizacionEuro_Validate(Cancel As Boolean)

   With origen.Registro
      If .Fields("IdMoneda").Value = glbIdMonedaEuro Then
         If IsNull(.Fields("IdDiferenciaCambio").Value) Then txtCotizacionMoneda.Text = txtCotizacionEuro.Text
      End If
   End With

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

   With origen.Registro
      If .Fields("IdMoneda").Value = mvarIdMonedaDolar Then
         If IsNull(.Fields("IdDiferenciaCambio").Value) Then txtCotizacionDolar.Text = txtCotizacionMoneda.Text
      ElseIf .Fields("IdMoneda").Value = glbIdMonedaEuro Then
         If IsNull(.Fields("IdDiferenciaCambio").Value) Then txtCotizacionEuro.Text = txtCotizacionMoneda.Text
      End If
   End With

End Sub

Private Sub txtCuentaItem_Change()

   If IsNumeric(txtCuentaItem.Text) Then
      On Error GoTo SalidaConError
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorCodigo", Array(txtCuentaItem.Text, DTFields(1).Value))
      If oRs.RecordCount > 0 Then
         If oRs.Fields("IdTipoCuenta").Value = 2 Then
            DataCombo1(0).BoundText = oRs.Fields(0).Value
         Else
            DataCombo1(0).BoundText = 0
         End If
      Else
         DataCombo1(0).BoundText = 0
      End If
      oRs.Close
      Set oRs = Nothing
      Exit Sub
SalidaConError:
      Set oRs = Nothing
      DataCombo1(0).BoundText = 0
   End If

End Sub

Private Sub txtCuentaItem_GotFocus()

   With txtCuentaItem
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCuentaItem_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCuentaOtros_Change()

   If IsNumeric(txtCuentaOtros.Text) Then
      On Error GoTo SalidaConError
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("Cod", txtCuentaOtros.Text)
      If oRs.RecordCount > 0 Then
         dcfields(5).BoundText = oRs.Fields(0).Value
      Else
         dcfields(5).BoundText = 0
      End If
      oRs.Close
      Set oRs = Nothing
      Exit Sub
SalidaConError:
      Set oRs = Nothing
      dcfields(5).BoundText = 0
   End If

End Sub

Private Sub txtCuentaOtros_GotFocus()

   With txtCuentaOtros
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCuentaOtros_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtDiasVencimiento_Change()

   If IsNumeric(txtDiasVencimiento.Text) Then
      Dim mFecha As Date
      With origen.Registro
         mFecha = DateAdd("d", txtDiasVencimiento.Text, IIf(IsNull(.Fields("FechaComprobante").Value), DTFields(0).Value, .Fields("FechaComprobante").Value))
         .Fields("FechaVencimiento").Value = mFecha
         DTFields(2).Value = mFecha
      End With
   End If
   
End Sub

Private Sub txtDiasVencimiento_GotFocus()

   With txtDiasVencimiento
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDiasVencimiento_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtFondoReparo_GotFocus()

   With txtFondoReparo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
End Sub

Private Sub txtFondoReparo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtGravadoParaSUSS_GotFocus()

   With txtGravadoParaSUSS
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
End Sub

Private Sub txtGravadoParaSUSS_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtImporteItem_GotFocus()

   With txtImporteItem
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
End Sub

Private Sub txtImporteItem_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtImputaComprobante_GotFocus()

   With txtImputaComprobante
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
End Sub

Private Sub txtImputaComprobante_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtImputaComprobante_Validate(Cancel As Boolean)

   If Len(txtImputaComprobante.Text) <> 0 Then
      If IsNumeric(txtImputaComprobante.Text) And IsNumeric(dcfields(0).BoundText) Then
         Dim oRs As ADOR.Recordset
         Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorNumeroReferencia", Array(txtImputaComprobante.Text, dcfields(0).BoundText))
         If oRs.RecordCount = 0 Then
            MsgBox "Numero de comprobante inexistente"
            Cancel = True
         Else
            mvarIdComprobanteImputado = oRs.Fields(0).Value
            If IsNumeric(dcfields(0).BoundText) Then
               If IIf(IsNull(oRs.Fields("IdProveedor").Value), 0, oRs.Fields("IdProveedor").Value) <> dcfields(0).BoundText Then
                  MsgBox "El proveedor correspondiente al comprobante imputado no es igual al actual", vbExclamation
                  Cancel = True
               End If
            End If
         End If
         oRs.Close
         Set oRs = Nothing
      Else
         MsgBox "El campo debe ser numerico"
         txtImputaComprobante.Text = ""
         Cancel = True
      End If
   End If

End Sub

Private Sub txtInformacionAuxiliar_GotFocus()

   With txtInformacionAuxiliar
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtInformacionAuxiliar_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtInformacionAuxiliar
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtLetra_Change()

   If Lista.ListItems.Count > 0 Then
      RecalcularItems
      CalculaComprobanteProveedor
   End If
   
End Sub

Private Sub txtLetra_GotFocus()

   If Len(txtLetra.Text) = 0 Then origen.Registro.Fields("Letra").Value = "A"
   With txtLetra
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
End Sub

Private Sub txtLetra_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      If InStr(1, "A B C E M a b c e m", Chr(KeyAscii)) = 0 And KeyAscii <> vbKeyBack Then
         KeyAscii = 0
      Else
         If KeyAscii >= 97 And KeyAscii <= 122 Then
            KeyAscii = KeyAscii - 32
         End If
         If Len(txtLetra.Text) >= 1 Then origen.Registro.Fields("Letra").Value = ""
      End If
   End If

End Sub

Private Sub txtLetra_Validate(Cancel As Boolean)

   If Len(txtLetra.Text) <> 1 Then
      MsgBox "La letra del comprobante es invalida!"
      Cancel = True
   Else
      CalculaComprobanteProveedor
   End If
   
End Sub

Private Sub txtNumeroCAE_Change()

   If Len(txtNumeroCAE.Text) > 0 Then
      With origen.Registro
         .Fields("NumeroCAI").Value = Null
         .Fields("FechaVencimientoCAI").Value = Null
      End With
      txtNumeroCAI.Enabled = False
      DTFields(3).Value = Null
      DTFields(3).Enabled = False
   Else
      txtNumeroCAI.Enabled = True
      DTFields(3).Enabled = True
   End If

End Sub

Private Sub txtNumeroCAE_GotFocus()

   With txtNumeroCAE
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroCAE_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtNumeroCAE
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtNumeroCAI_GotFocus()

   With txtNumeroCAI
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroCAI_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtNumeroCAI
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtNumeroCAI_Validate(Cancel As Boolean)

   If Option2.Value And mActivarCamposParaFF And Len(txtNumeroCAI.Text) = 0 Then
      MsgBox "Debe ingresar el numero de CAI", vbExclamation
      Cancel = True
   End If

End Sub

Private Sub txtNumeroComprobante1_GotFocus()

   With txtNumeroComprobante1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroComprobante1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroComprobante2_GotFocus()

   With txtNumeroComprobante2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroComprobante2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroReferencia_GotFocus()

   With txtNumeroReferencia
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroReferencia_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroReferencia_Validate(Cancel As Boolean)

   If mvarId < 0 And IsNumeric(txtNumeroReferencia.Text) And Len(txtNumeroReferencia.Text) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorNumeroReferencia", txtNumeroReferencia.Text)
      If oRs.RecordCount > 0 Then
         MsgBox "Comprobante existente con fecha " & oRs.Fields("FechaComprobante").Value, vbExclamation
         Cancel = True
      End If
      oRs.Close
      Set oRs = Nothing
   End If

End Sub

Private Sub txtOrdenPago_GotFocus()

   With txtOrdenPago
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtOrdenPago_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtOrdenPago_Validate(Cancel As Boolean)

   If Len(txtOrdenPago.Text) <> 0 Then
      If IsNumeric(txtOrdenPago.Text) Then
         Dim oRs As ADOR.Recordset
         Dim mvarMonedaOP_FF As String
         Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PorNumeroFF", txtOrdenPago.Text)
         If oRs.RecordCount = 0 Then
            MsgBox "Numero de orden de pago inexistente"
            Cancel = True
         Else
            mvarIdMonedaOP_FF = oRs.Fields("IdMoneda").Value
            oRs.Close
            Set oRs = Aplicacion.Monedas.TraerFiltrado("_PorId", mvarIdMonedaOP_FF)
            If oRs.RecordCount > 0 Then
               mvarMonedaOP_FF = oRs.Fields("Nombre").Value
            End If
            If origen.Registro.Fields("IdMoneda").Value <> mvarIdMonedaOP_FF And _
                     Not (origen.Registro.Fields("IdTipoComprobante").Value = mvarIdTipoComprobanteNDInternaAcreedores Or _
                           origen.Registro.Fields("IdTipoComprobante").Value = mvarIdTipoComprobanteNCInternaAcreedores) Then
               MsgBox "La orden de pago y el comprobante deben tener la misma moneda" & vbCrLf & _
                      "La orden de pago esta en " & mvarMonedaOP_FF, vbExclamation
               Cancel = True
            Else
               Cancel = False
            End If
         End If
         oRs.Close
         Set oRs = Nothing
      Else
         MsgBox "El campo debe ser numerico"
         txtOrdenPago.Text = ""
         Cancel = True
      End If
   End If
   
End Sub

Private Sub txtPorcentajeParaSUSS_GotFocus()

   With txtPorcentajeParaSUSS
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcentajeParaSUSS_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtProveedorEventual_DblClick()

   OtrosProveedores

End Sub

Private Sub txtTotal_GotFocus(Index As Integer)

   With txtTotal(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTotal_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtTotal_Validate(Index As Integer, Cancel As Boolean)

   If Index = 3 Then
      If Not IsNumeric(txtTotal(Index).Text) Then
         MsgBox "Ingrese un numero", vbExclamation
         txtTotal(Index).Text = 0
         Cancel = True
         Exit Sub
      End If
      If Val(txtTotal(Index).Text) = 0 Then
         Cancel = False
         CalculaComprobanteProveedor
         Exit Sub
      End If
      If Val(txtTotal(Index).Text) < -0.99 Or Val(txtTotal(Index).Text) > 0.99 Then
         MsgBox "El ajuste debe estar entre -1 y 1", vbExclamation
         txtTotal(Index).Text = 0
         Cancel = True
         Exit Sub
      End If
      If Val(txtTotal(1).Text) = 0 Then
         MsgBox "Para ingresar un ajuste de IVA deben existir items gravados", vbExclamation
         txtTotal(Index).Text = 0
         Cancel = True
         Exit Sub
      End If
      CalculaComprobanteProveedor
   End If

End Sub

Public Sub OtrosProveedores()

   Dim oF As frmOtrosProveedores
   Dim oRs As ADOR.Recordset
   Dim mBorrarItems As Boolean
   
   mBorrarItems = False
   
   Set oF = New frmOtrosProveedores
   With oF
      If Not IsNull(origen.Registro.Fields("IdProveedor").Value) Then
         .IdProveedor = origen.Registro.Fields("IdProveedor").Value
      ElseIf Not IsNull(origen.Registro.Fields("IdProveedorEventual").Value) Then
         .IdProveedor = origen.Registro.Fields("IdProveedorEventual").Value
      Else
         .IdProveedor = 0
      End If
      If Not IsNull(origen.Registro.Fields("IdCuenta").Value) Then
         .IdCuenta = origen.Registro.Fields("IdCuenta").Value
      Else
         .IdCuenta = 0
      End If
      If glbIdCuentaFFUsuario <> -1 Then .DataCombo1(1).Enabled = False
      .Show vbModal, Me
      If .Ok Then
         With origen.Registro
            If glbIdCuentaFFUsuario <> -1 And _
                  Not IsNull(.Fields("IdProveedorEventual").Value) And _
                  .Fields("IdProveedorEventual").Value <> oF.IdProveedor Then
               mBorrarItems = True
            End If
            .Fields("IdProveedorEventual").Value = oF.IdProveedor
            .Fields("IdCuenta").Value = oF.IdCuenta
         End With
      End If
      MostrarDatos 0
   End With
   Unload oF
   Set oF = Nothing
   
   If mActivarCamposParaFF And Not cmdIngresarItem(0).Visible Then
      cmd_Click 2
      If Check1(0).Visible And txtLetra.Text <> "C" Then Check1(0).Value = 1
   End If
   
   If IIf(IsNull(origen.Registro.Fields("IdProveedorEventual").Value), 0, _
            origen.Registro.Fields("IdProveedorEventual").Value) = 0 And _
            glbIdCuentaFFUsuario <> -1 Then
      Unload Me
   End If
   
   If mBorrarItems Then
      Set oRs = origen.DetComprobantesProveedores.Registros
      With oRs
         If .Fields.Count > 0 Then
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  origen.DetComprobantesProveedores.Item(oRs.Fields(0).Value).Eliminado = True
                  .MoveNext
               Loop
            End If
         End If
      End With
      Set oRs = Nothing
      Set Lista.DataSource = origen.DetComprobantesProveedores.RegistrosConFormato
   End If
   
   On Error Resume Next
   txtLetra.SetFocus
   
End Sub

Public Function ControlarComprobante() As Boolean

   Dim mIdTipoComprobante As Integer, mAcceder As Integer
   
   mIdTipoComprobante = dcfields(1).BoundText
   
   If mIdTipoComprobante = mvarIdTipoComprobanteNDInternaAcreedores Or _
         mIdTipoComprobante = mvarIdTipoComprobanteNCInternaAcreedores Then
      If Not glbAdministrador Then
         mAcceder = MsgBox("Para ingresar a este modulo debe tener permiso de ADMINISTRADOR" & vbCrLf & "Desea login de supervisores ?", vbYesNo, "Acceso a supervisores")
         If mAcceder = vbNo Then
            ControlarComprobante = False
            Exit Function
         End If
         If Not DefinirAdministrador Then
            MsgBox "Para registrar este comprobante debe tener permiso de ADMINISTRADOR", vbCritical
            ControlarComprobante = False
            Exit Function
         End If
      End If
   End If

   ControlarComprobante = True

End Function

Public Sub LabelComprobante()

   With lblComprobante
      .Top = txtNumeroReferencia.Top
      .Left = txtNumeroReferencia.Left + txtNumeroReferencia.Width + (txtNumeroReferencia.Width) / 10
      .Caption = dcfields(1).Text
      .Visible = True
      dcfields(1).Visible = False
      lblLabels(1).Visible = False
   End With

End Sub

Public Sub IncorporarDesdeRecepcion(ByVal Filas As Variant, ByRef mError As String)

   Dim oAp As ComPronto.Aplicacion
   Dim oPr As ComPronto.ComprobanteProveedor
   Dim oRsPre As ADOR.Recordset
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oF As frm_Aux
   Dim mIdCodigoIva As Integer
   Dim iFilas As Long, iColumnas As Long, mSubNumero As Long, mIdCuentaIvaCompras1 As Long, mIdTipoComprobante As Long
   Dim mIdCuentaDiferenciaCambio As Long, i As Long, j As Long, mCodigoCuentaDiferenciaCambio As Long, mIdMoneda As Long
   Dim mIdTipoComprobanteNDInternaAcreedores As Long, mIdTipoComprobanteNCInternaAcreedores As Long, mCodBar As Long
   Dim mIdObraDefault As Long, mIdProveedor As Long
   Dim mIdCuentaIvaCompras(10) As Long
   Dim mIVAComprasPorcentaje(10) As Single
   Dim mIVAComprasPorcentaje1 As Single
   Dim mvarImporte As Double, mvarImpuestosInternos As Double
   Dim s As String, mvarConIVA As String, mAplicaIVA As String, mAuxS1 As String, mControl1 As String, mControl2 As String
   Dim mProcesar As Boolean, mOk As Boolean
   Dim Columnas, mAux1
   
   mControl1 = BuscarClaveINI("Control por codigo recepcion a comprobante")
   mControl2 = BuscarClaveINI("Legajos para recepcion a comprobante sin pedido")
   
   Set oAp = Aplicacion
   
   Set oRs = oAp.Parametros.Item(1).Registro
   For i = 1 To 10
      If Not IsNull(oRs.Fields("IdCuentaIvaCompras" & i).Value) Then
         mIdCuentaIvaCompras(i) = oRs.Fields("IdCuentaIvaCompras" & i).Value
         mIVAComprasPorcentaje(i) = oRs.Fields("IVAComprasPorcentaje" & i).Value
      Else
         mIdCuentaIvaCompras(i) = 0
         mIVAComprasPorcentaje(i) = 0
      End If
   Next
   oRs.Close
   
   mAux1 = TraerValorParametro2("IdObraDefault")
   mIdObraDefault = IIf(IsNull(mAux1), 0, mAux1)
   
   mIdProveedor = -1
   s = ""
   For iFilas = 1 To UBound(Filas)
      Columnas = Split(Filas(iFilas), vbTab)
      s = s & "(" & Columnas(12) & ")"
   Next
   Set oRs = oAp.Recepciones.TraerFiltrado("_PorListaId", s)
   If oRs.RecordCount = 1 Then
      mIdProveedor = IIf(IsNull(oRs.Fields("IdProveedor").Value), -1, oRs.Fields("IdProveedor").Value)
   ElseIf oRs.RecordCount > 1 Then
      Dim oL As ListItem
      Set oF = New frm_Aux
      With oF
         .Caption = "Elegir proveedor"
         .Text1.Visible = False
         .Width = .Width * 1.5
         .Height = .Height * 1.5
         With .Label1
            .Left = 50
            .Top = 100
            .Width = 5000
            .Caption = "Seleccione un proveedor y pulse Elegir ..."
         End With
         With .Lista
            .MultiSelect = False
            .Left = 50
            .Top = 500
            .Width = 5000
            .Height = 2000
            Set .DataSource = oRs
            .Visible = True
         End With
         With .cmd(0)
            .Top = 2500
            .Left = oF.Lista.Left
            .Caption = "Elegir"
         End With
         .cmd(1).Top = .cmd(0).Top
         .Show vbModal, Me
         mOk = .Ok
         If mOk Then
            For Each oL In .Lista.ListItems
               If oL.Selected Then mIdProveedor = oL.Tag
            Next
         Else
            MsgBox "Proceso de seleccion de recepcion cancelado", vbInformation
            GoTo Salida
         End If
      End With
      Unload oF
      Set oF = Nothing
   End If
   oRs.Close
   
   For iFilas = 1 To UBound(Filas)
      Columnas = Split(Filas(iFilas), vbTab)
      
      Set oRs = oAp.Recepciones.Item(Columnas(12)).Registro
      Set oRsDet = oAp.Recepciones.TraerFiltrado("_DetallesParaComprobantesProveedores", Columnas(12))
      
      mProcesar = True
      mIdMoneda = 0
      mvarImpuestosInternos = 0
      
      With origen.Registro
         If Not IsNull(oRs.Fields("IdPedido").Value) Then
            Set oRs1 = oAp.Pedidos.TraerFiltrado("_PorId", oRs.Fields("IdPedido").Value)
            If oRs1.RecordCount > 0 Then
               .Fields("IdMoneda").Value = oRs1.Fields("IdMoneda").Value
               mvarImpuestosInternos = IIf(IsNull(oRs1.Fields("ImpuestosInternos").Value), 0, oRs1.Fields("ImpuestosInternos").Value)
               If mControl1 = "SI" And Not IsNull(oRs1.Fields("CodigoControl").Value) Then
                  Set oF = New frm_Aux
                  oF.Label1.Caption = "Codigo de barras :"
                  oF.Show vbModal, Me
                  mCodBar = Val(oF.Text1.Text)
                  mOk = oF.Ok
                  Unload oF
                  Set oF = Nothing
                  If (Not mOk Or oRs1.Fields("CodigoControl").Value <> mCodBar) And _
                        mCodBar <> 0 Then
                     oRs1.Close
                     MsgBox "Codigo de control incorrecto, proceso cancelado", vbExclamation
                     GoTo Salida
                     Exit Sub
                  End If
               End If
            End If
            oRs1.Close
         Else
            If Len(mControl2) > 0 Then
               If InStr(1, mControl2, "(" & glbLegajo & ")") = 0 Then
                  MsgBox "Permiso insuficiente para la tarea seleccionada, proceso cancelado", vbExclamation
                  GoTo Salida
                  Exit Sub
               End If
            End If
            mvarImpuestosInternos = IIf(IsNull(oRs.Fields("ImpuestosInternos").Value), 0, oRs.Fields("ImpuestosInternos").Value)
         End If
         If Not IsNull(.Fields("IdProveedor").Value) And .Fields("IdProveedor").Value <> oRs.Fields("IdProveedor").Value And Lista.ListItems.Count > 0 Then
            mError = mError & "La recepcion " & oRsDet.Fields("Remito").Value & " no se tomo porque no es" & vbCrLf & "del proveedor actual." & vbCrLf
            mProcesar = False
         Else
            If mIdProveedor <= 0 Then
               .Fields("IdProveedor").Value = oRs.Fields("IdProveedor").Value
            Else
               .Fields("IdProveedor").Value = mIdProveedor
            End If
         End If
         If Not IsNull(oRs.Fields("Anulada").Value) And oRs.Fields("Anulada").Value = "SI" Then
            mError = mError & "La recepcion " & oRs.Fields("NumeroRecepcionAlmacen").Value & " ha sido anulada." & vbCrLf
            mProcesar = False
         End If
      End With
   
      If mProcesar Then
         mAplicaIVA = "SI"
         mIdCodigoIva = 0
         If Not IsNull(origen.Registro.Fields("IdProveedor").Value) Then
            Set oRs1 = oAp.Proveedores.TraerFiltrado("_PorId", origen.Registro.Fields("IdProveedor").Value)
            If oRs1.RecordCount > 0 Then
               If Not IsNull(oRs1.Fields("IdCodigoIva").Value) And _
                     (oRs1.Fields("IdCodigoIva").Value = 3 Or oRs1.Fields("IdCodigoIva").Value = 5 Or _
                      oRs1.Fields("IdCodigoIva").Value = 8 Or oRs1.Fields("IdCodigoIva").Value = 9) Then
                  mAplicaIVA = "NO"
               End If
               mIdCodigoIva = IIf(IsNull(oRs1.Fields("IdCodigoIva").Value), 0, oRs1.Fields("IdCodigoIva").Value)
            End If
            oRs1.Close
         End If
         
         Do While Not oRsDet.EOF
            mProcesar = True
            
            If mIdProveedor > 0 And mIdProveedor <> oRsDet.Fields("IdProveedor").Value Then mProcesar = False
            
            If mProcesar Then
               Set oRs1 = oAp.ComprobantesProveedores.TraerFiltrado("_DetallePorIdDetalleRecepcion", oRsDet.Fields("IdDetalleRecepcion").Value)
               If oRs1.RecordCount > 0 Then
                  mError = mError & "El articulo " & oRs1.Fields("CodigoArticulo").Value & " no se tomo porque ya fue incorporado en el comprobante " & _
                           oRs1.Fields("Comprobante").Value & " del " & oRs1.Fields("Fecha").Value & vbCrLf
                  mProcesar = False
               End If
               oRs1.Close
            End If
            
            If mProcesar Then
               Set oRs1 = origen.DetComprobantesProveedores.Registros
               If oRs1.Fields.Count > 0 Then
                  If oRs1.RecordCount > 0 Then
                     oRs1.MoveFirst
                     Do While Not oRs1.EOF
                        If oRs1.Fields("IdDetalleRecepcion").Value = oRsDet.Fields("IdDetalleRecepcion").Value Then
                           mProcesar = False
                           Exit Do
                        End If
                        oRs1.MoveNext
                     Loop
                  End If
               End If
               oRs1.Close
            End If
            Set oRs1 = Nothing
            
            If mProcesar Then
               mIdCuentaIvaCompras1 = 0
               mIVAComprasPorcentaje1 = 0
               If Not IsNull(oRsDet.Fields("PorcentajeIVA").Value) Then
                  If oRsDet.Fields("PorcentajeIVA").Value <> 0 Then
                     For i = 1 To 10
                        If mIVAComprasPorcentaje(i) = oRsDet.Fields("PorcentajeIVA").Value Then
                           mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(i)
                           mIVAComprasPorcentaje1 = mIVAComprasPorcentaje(i)
                           Exit For
                        End If
                     Next
                  End If
               End If
               
               If Not IsNull(oRsDet.Fields("IdCondicionCompra").Value) Then
                  mCondicionDesdePedido = True
                  origen.Registro.Fields("IdCondicionCompra").Value = oRsDet.Fields("IdCondicionCompra").Value
               End If
               If mIdObraDefault = 0 Then
                  If Not IsNull(oRsDet.Fields("IdObra").Value) Then
                     origen.Registro.Fields("IdObra").Value = oRsDet.Fields("IdObra").Value
                  End If
               Else
                  If Not IsNull(oRsDet.Fields("IdObraRM").Value) Then
                     origen.Registro.Fields("IdObra").Value = oRsDet.Fields("IdObraRM").Value
                  End If
               End If
               
               mvarImporte = IIf(IsNull(oRsDet.Fields("Importe").Value), 0, oRsDet.Fields("Importe").Value)
               
               With origen.DetComprobantesProveedores.Item(-1)
                  With .Registro
                     .Fields("IdDetalleRecepcion").Value = oRsDet.Fields("IdDetalleRecepcion").Value
                     .Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                     If mIdObraDefault = 0 Then
                        .Fields("IdObra").Value = oRsDet.Fields("IdObra").Value
                     Else
                        .Fields("IdObra").Value = IIf(IsNull(oRsDet.Fields("IdObraRM").Value), oRsDet.Fields("IdObra").Value, oRsDet.Fields("IdObraRM").Value)
                     End If
                     .Fields("IdCuenta").Value = oRsDet.Fields("IdCuenta").Value
                     .Fields("CodigoCuenta").Value = oRsDet.Fields("CodigoCuenta").Value
                     .Fields("Importe").Value = mvarImporte
                     If mIdCuentaIvaCompras1 <> 0 And mAplicaIVA = "SI" Then
                        .Fields("IdCuentaIvaCompras1").Value = mIdCuentaIvaCompras1
                        .Fields("IVAComprasPorcentaje1").Value = mIVAComprasPorcentaje1
                        If mIdCodigoIva <> 1 Then
                           .Fields("ImporteIVA1").Value = Round(mvarImporte - (mvarImporte / (1 + (mIVAComprasPorcentaje1 / 100))), mvarDecimales)
                        Else
                           .Fields("ImporteIVA1").Value = Round(mvarImporte * mIVAComprasPorcentaje1 / 100, mvarDecimales)
                        End If
                        .Fields("AplicarIVA1").Value = "SI"
                     Else
                        .Fields("IdCuentaIvaCompras1").Value = Null
                        .Fields("IVAComprasPorcentaje1").Value = 0
                        .Fields("ImporteIVA1").Value = 0
                        .Fields("AplicarIVA1").Value = "NO"
                     End If
                     For i = 2 To 10
                        .Fields("IdCuentaIvaCompras" & i).Value = Null
                        .Fields("IVAComprasPorcentaje" & i).Value = 0
                        .Fields("ImporteIVA" & i).Value = 0
                        .Fields("AplicarIVA" & i).Value = "NO"
                     Next
                     .Fields("IdPedido").Value = oRs.Fields("IdPedido").Value
                     .Fields("Cantidad").Value = oRsDet.Fields("Cantidad").Value
                     .Fields("IdDetalleObraDestino").Value = oRsDet.Fields("IdDetalleObraDestino").Value
                     .Fields("IdPresupuestoObraRubro").Value = oRsDet.Fields("IdPresupuestoObraRubro").Value
                     .Fields("NumeroSubcontrato").Value = oRsDet.Fields("NumeroSubcontrato").Value
                     .Fields("IdRubroContable").Value = oRsDet.Fields("IdRubroFinanciero").Value
                  End With
                  .Modificado = True
               End With
            End If
            
            oRsDet.MoveNext
         Loop
      End If
      
      If mvarImpuestosInternos <> 0 Then
         With origen.DetComprobantesProveedores.Item(-1)
            With .Registro
               .Fields("IdDetalleRecepcion").Value = Null
               .Fields("IdArticulo").Value = Null
               .Fields("IdObra").Value = Null
               .Fields("IdCuenta").Value = Null
               .Fields("CodigoCuenta").Value = Null
               .Fields("Importe").Value = mvarImpuestosInternos
               For i = 1 To 10
                  .Fields("IdCuentaIvaCompras" & i).Value = Null
                  .Fields("IVAComprasPorcentaje" & i).Value = 0
                  .Fields("ImporteIVA" & i).Value = 0
                  .Fields("AplicarIVA" & i).Value = "NO"
               Next
               .Fields("IdPedido").Value = oRs.Fields("IdPedido").Value
            End With
            .Modificado = True
         End With
      End If
      
      If Not IsNull(oRs.Fields("PercepcionIIBB").Value) And oRs.Fields("PercepcionIIBB").Value <> 0 Then
         With origen.DetComprobantesProveedores.Item(-1)
            With .Registro
               .Fields("IdDetalleRecepcion").Value = Null
               .Fields("IdArticulo").Value = Null
               .Fields("IdObra").Value = Null
               .Fields("IdCuenta").Value = Null
               .Fields("CodigoCuenta").Value = Null
               .Fields("Importe").Value = IIf(IsNull(oRs.Fields("PercepcionIIBB").Value), 0, oRs.Fields("PercepcionIIBB").Value)
               For i = 1 To 10
                  .Fields("IdCuentaIvaCompras" & i).Value = Null
                  .Fields("IVAComprasPorcentaje" & i).Value = 0
                  .Fields("ImporteIVA" & i).Value = 0
                  .Fields("AplicarIVA" & i).Value = "NO"
               Next
               .Fields("IdPedido").Value = oRs.Fields("IdPedido").Value
            End With
            .Modificado = True
         End With
      End If
      
      If Not IsNull(oRs.Fields("PercepcionIVA").Value) And oRs.Fields("PercepcionIVA").Value <> 0 Then
         With origen.DetComprobantesProveedores.Item(-1)
            With .Registro
               .Fields("IdDetalleRecepcion").Value = Null
               .Fields("IdArticulo").Value = Null
               .Fields("IdObra").Value = Null
               .Fields("IdCuenta").Value = Null
               .Fields("CodigoCuenta").Value = Null
               .Fields("Importe").Value = IIf(IsNull(oRs.Fields("PercepcionIVA").Value), 0, oRs.Fields("PercepcionIVA").Value)
               For i = 1 To 10
                  .Fields("IdCuentaIvaCompras" & i).Value = Null
                  .Fields("IVAComprasPorcentaje" & i).Value = 0
                  .Fields("ImporteIVA" & i).Value = 0
                  .Fields("AplicarIVA" & i).Value = "NO"
               Next
               .Fields("IdPedido").Value = oRs.Fields("IdPedido").Value
            End With
            .Modificado = True
         End With
      End If
      oRs.Close
      oRsDet.Close
   Next
   
Salida:
   Set oRs = Nothing
   Set oRs1 = Nothing
   Set oRsDet = Nothing
   Set oAp = Nothing
   
   Set Lista.DataSource = origen.DetComprobantesProveedores.RegistrosConFormato
   
   MostrarDatos 0
   CalculaComprobanteProveedor

End Sub

Public Sub MostrarRecepcionesPendientes()

   Dim oF As frmConsulta1
   
   Set oF = New frmConsulta1
   With oF
      If IsNumeric(dcfields(0).BoundText) Then
         .IdParametro = dcfields(0).BoundText
      Else
         .IdParametro = -1
      End If
      .Id = 11
      .Show
   End With
   Set oF = Nothing

End Sub

Public Sub MostrarDatosImportacion()

   Dim oF As frmDetComprobantesProveedoresImpo
   Dim oControl As Control
   
   Set oF = New frmDetComprobantesProveedoresImpo
   With oF
      For Each oControl In .Controls
         If TypeOf oControl Is TextBox Then
            If Len(oControl.DataField) > 0 Then
               If Not IsNull(origen.Registro.Fields(oControl.DataField).Value) Then
                  oControl.Text = origen.Registro.Fields(oControl.DataField).Value
               End If
            End If
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.Tag) > 0 Then
               Set oControl.RowSource = Aplicacion.CargarLista(oControl.Tag)
               If Len(oControl.DataField) > 0 Then
                  If Not IsNull(origen.Registro.Fields(oControl.DataField).Value) Then
                     oControl.BoundText = origen.Registro.Fields(oControl.DataField).Value
                  End If
               End If
            End If
         ElseIf TypeOf oControl Is DTPicker Then
            If Len(oControl.DataField) > 0 Then
               If Not IsNull(origen.Registro.Fields(oControl.DataField).Value) Then
                  oControl.Value = origen.Registro.Fields(oControl.DataField).Value
               Else
                  oControl.Value = Date
               End If
            End If
         End If
      Next
      Set .ComprobanteProveedor = origen
      .Show vbModal, Me
      If .Aceptado Then
         On Error Resume Next
         For Each oControl In .Controls
            If TypeOf oControl Is TextBox Then
               If Len(oControl.DataField) > 0 Then
                  origen.Registro.Fields(oControl.DataField) = oControl.Text
               End If
            ElseIf TypeOf oControl Is DataCombo Then
               If Len(oControl.DataField) > 0 And IsNumeric(oControl.BoundText) Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
               End If
            ElseIf TypeOf oControl Is DTPicker Then
               If Len(oControl.DataField) > 0 Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.Value
               End If
            End If
         Next
      End If
   End With
   Unload oF
   Set oF = Nothing

End Sub

Public Sub AsignarRubrosFinancieros()

   Dim oF1 As frmAsignaComprador
   Dim oL As ListItem
   Dim mIdRubroContable As Long
   Dim mRubroContable As String
   Dim mOk As Boolean
   
   Set oF1 = New frmAsignaComprador
   
   With oF1
      .Id = 2
      .Show vbModal, Me
      mOk = .Ok
      If mOk Then
         mIdRubroContable = .DataCombo1(0).BoundText
         mRubroContable = .DataCombo1(0).Text
      End If
   End With
   Unload oF1
   Set oF1 = Nothing
   
   If Not mOk Then
      Exit Sub
   End If
   
   For Each oL In Lista.ListItems
      With oL
         If .Selected Then
            With origen.DetComprobantesProveedores.Item(.Tag)
               .Registro.Fields("IdRubroContable").Value = mIdRubroContable
               .Modificado = True
            End With
            .SubItems(12) = "" & mRubroContable
            .SmallIcon = "Modificado"
         End If
      End With
   Next

End Sub

Public Sub AsignarParaCostosImportacion(ByVal mIdComprobante As Long)

   Dim oDet As ComPronto.DetComprobanteProveedor
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oFld As ADOR.Field
   Dim mPrimerPasada As Boolean
   Dim i As Integer
   
   Set oRsDet = origen.DetComprobantesProveedores.Registros
   If oRsDet.Fields.Count = 0 Then GoTo Salida
   If oRsDet.RecordCount = 0 Then GoTo Salida
   
   mPrimerPasada = True
   
   Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_DistribucionPorIdPedido", mIdComprobante)
   
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If mPrimerPasada Then
               oRsDet.MoveFirst
               Do While Not oRsDet.EOF
                  If Not oRsDet.Fields("Eliminado").Value Then
                     Set oDet = origen.DetComprobantesProveedores.Item(oRsDet.Fields(0).Value)
                     With oDet.Registro
                        .Fields("IdPedido").Value = oRs.Fields("IdPedido").Value
                        .Fields("Importe").Value = .Fields("Importe").Value * oRs.Fields("Porcentaje").Value
                        For i = 1 To 10
                           If Not IsNull(.Fields("AplicarIVA" & i).Value) And _
                                 .Fields("AplicarIVA" & i).Value = "SI" Then
                              .Fields("ImporteIVA" & i).Value = Round(CDbl(.Fields("Importe").Value) * CDbl(.Fields("IVAComprasPorcentaje" & i).Value) / 100, 2)
                           End If
                        Next
                     End With
                     Set oDet = Nothing
                  End If
                  oRsDet.MoveNext
               Loop
               mPrimerPasada = False
            Else
               oRsDet.MoveFirst
               Do While Not oRsDet.EOF
                  If Not oRsDet.Fields("Eliminado").Value Then
                     Set oDet = origen.DetComprobantesProveedores.Item(-1)
                     With oDet
                        With .Registro
                           For Each oFld In oRsDet.Fields
                              For i = 1 To .Fields.Count - 1
                                 If oFld.Name = .Fields(i).Name Then
                                    .Fields(i).Value = oFld.Value
                                    Exit For
                                 End If
                              Next
                           Next
                           .Fields("IdPedido").Value = oRs.Fields("IdPedido").Value
                           .Fields("Importe").Value = .Fields("Importe").Value * oRs.Fields("Porcentaje").Value
                           For i = 1 To 10
                              If Not IsNull(.Fields("AplicarIVA" & i).Value) And _
                                    .Fields("AplicarIVA" & i).Value = "SI" Then
                                 .Fields("ImporteIVA" & i).Value = Round(CDbl(.Fields("Importe").Value) * CDbl(.Fields("IVAComprasPorcentaje" & i).Value) / 100, 2)
                              End If
                           Next
                        End With
                        .Modificado = True
                     End With
                     Set oDet = Nothing
                  End If
                  oRsDet.MoveNext
               Loop
            End If
            .MoveNext
         Loop
      End If
      .Close
   End With
   
   Set Lista.DataSource = origen.DetComprobantesProveedores.RegistrosConFormato
   
   CalculaComprobanteProveedor
   
Salida:

   Set oRs = Nothing
   Set oRsDet = Nothing
   Set oDet = Nothing

End Sub

Public Sub EliminarComprobante()

   If mvarId <= 0 Then
      MsgBox "El comprobante debe estar previamente grabado para podet eliminarlo", vbExclamation
      Exit Sub
   End If
   
   If Not IsNumeric(dcfields(1).BoundText) Then
      MsgBox "No esta definido el tipo de comprobante", vbExclamation
      Exit Sub
   End If
   
   Dim mSeguro As Integer
   mSeguro = MsgBox("Esta seguro de anular el comprobante ?", vbYesNo, "Anulacion de comprobante")
   If mSeguro = vbNo Then Exit Sub

   Dim oRs As ADOR.Recordset
   If Option1.Value Then
      Set oRs = Aplicacion.CtasCtesA.TraerFiltrado("_BuscarComprobante", Array(mvarId, dcfields(1).BoundText))
      If oRs.RecordCount > 0 Then
         If oRs.Fields("ImporteTotal").Value <> oRs.Fields("Saldo").Value Then
            oRs.Close
            Set oRs = Nothing
            MsgBox "El comprobante se encuentra parcial o totalmente cancelado en cta. cte." & vbCrLf & _
                  "Eliminacion abortada", vbExclamation
            Exit Sub
         End If
      Else
         oRs.Close
         Set oRs = Nothing
         MsgBox "No se encontro el comprobante en la cta. cte." & vbCrLf & "Eliminacion abortada", vbExclamation
         Exit Sub
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
   Aplicacion.Tarea "ComprobantesProveedores_EliminarComprobante", mvarId
   
   If Not actL2 Is Nothing Then
      With actL2
         .ListaEditada = "ComprobantesPrvTodos,+SubCP2,ComprobantesAConfirmar"
         .AccionRegistro = EnumAcciones.baja
         .Disparador = mvarId
      End With
   End If
   
   Unload Me

End Sub

Public Sub VerificarProvinciasDestino()

   Dim oRs As ADOR.Recordset
   Dim mVacio As Boolean
   Dim mIdProv As Long
   Dim mIdProvincia As Integer
   
   Set oRs = origen.DetComprobantesProveedoresPrv.Registros
   mVacio = True
   With oRs
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               If Not .Fields("Eliminado").Value Then
                  mVacio = False
                  Exit Do
               End If
               .MoveNext
            Loop
         End If
      End If
   End With
   Set oRs = Nothing
   
   If mVacio Then
      mIdProv = 0
      mIdProvincia = 0
      If Not IsNull(origen.Registro.Fields("IdProveedor").Value) Then
         mIdProv = origen.Registro.Fields("IdProveedor").Value
      Else
         If Not IsNull(origen.Registro.Fields("IdProveedorEventual").Value) Then
            mIdProv = origen.Registro.Fields("IdProveedorEventual").Value
         End If
      End If
      Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", mIdProv)
      If oRs.RecordCount > 0 Then
         mIdProvincia = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
      End If
      oRs.Close
      
      With origen.DetComprobantesProveedoresPrv.Item(-1)
         With .Registro
            .Fields("IdProvinciaDestino").Value = mIdProvincia
            .Fields("Porcentaje").Value = 100
         End With
         .Modificado = True
      End With
   End If

   Set oRs = Nothing

End Sub

Public Sub DatosReintegro()

   Dim mIdCuenta As Long, mIdGrupoCuenta As Long
   Dim mOk As Boolean
   Dim oRs As ADOR.Recordset
   
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   mIdCuenta = 0
   If oRs.RecordCount > 0 Then
      mIdCuenta = IIf(IsNull(oRs.Fields("IdCuentaReintegros").Value), 0, oRs.Fields("IdCuentaReintegros").Value)
   End If
   oRs.Close
   
   Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorId", mIdCuenta)
   mIdGrupoCuenta = 0
   If oRs.RecordCount > 0 Then
      mIdGrupoCuenta = IIf(IsNull(oRs.Fields("IdTipoCuentaGrupo").Value), 0, oRs.Fields("IdTipoCuentaGrupo").Value)
   End If
   oRs.Close
   
   Set oRs = Nothing
   
   If mIdCuenta = 0 Then
      MsgBox "Debe definir la cuenta contable de reintegros en parametros", vbExclamation
      Exit Sub
   End If
   
   Dim oF As frm_Aux
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Datos para reintegros"
      With .Label2(0)
         .Caption = "Despacho :"
         .Visible = True
      End With
      With .Text2
         .Top = DTFields(0).Top
         .Left = oF.Text1.Left
         .Text = IIf(IsNull(origen.Registro.Fields("ReintegroDespacho").Value), "", _
                           origen.Registro.Fields("ReintegroDespacho").Value)
         .Visible = True
      End With
      .Label1.Caption = "Importe :"
      .Text1.Text = IIf(IsNull(origen.Registro.Fields("ReintegroImporte").Value), 0, _
                           origen.Registro.Fields("ReintegroImporte").Value)
      With .Label2(1)
         .Caption = "Moneda :"
         .Visible = True
      End With
      With .dcfields(0)
         .Top = oF.Text1.Top + oF.Text1.Height + 100
         .Left = oF.Text1.Left
         .BoundColumn = "IdMoneda"
         Set .RowSource = Aplicacion.Monedas.TraerLista
         .BoundText = IIf(IsNull(origen.Registro.Fields("ReintegroIdMoneda").Value), glbIdMonedaDolar, _
                           origen.Registro.Fields("ReintegroIdMoneda").Value)
         .Visible = True
      End With
      With .Label2(2)
         .Top = oF.Label2(1).Top + oF.Label2(1).Height + 100
         .Left = oF.Label2(1).Left
         .Caption = "Cuenta :"
         .Visible = True
      End With
      With .dcfields(1)
         .Top = oF.dcfields(0).Top + oF.dcfields(0).Height + 100
         .Left = oF.dcfields(0).Left
         .Width = oF.dcfields(0).Width * 1.8
         .BoundColumn = "IdCuenta"
         Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorGrupoParaCombo", mIdGrupoCuenta)
         .BoundText = IIf(IsNull(origen.Registro.Fields("ReintegroIdCuenta").Value), 0, _
                           origen.Registro.Fields("ReintegroIdCuenta").Value)
         .Visible = True
      End With
      .cmd(0).Top = .dcfields(1).Top + oF.dcfields(1).Height + 100
      .cmd(1).Top = .cmd(0).Top
      .Width = .Width * 1.2
      .Height = .Height * 1.1
      .Show vbModal, Me
      
      mOk = True
      If .Ok Then
         If Val(.Text1) = 0 Then
            mOk = False
            MsgBox "Falta ingresar el importe del reintegro"
         End If
         If Len(.Text2) = 0 Then
            mOk = False
            MsgBox "Falta ingresar el numero de despacho"
         End If
         If Not IsNumeric(.dcfields(1).BoundText) Then
            mOk = False
            MsgBox "Falta ingresar la cuenta"
         End If
         If mOk Then
            With origen.Registro
               .Fields("ReintegroDespacho").Value = oF.Text2.Text
               .Fields("ReintegroImporte").Value = oF.Text1.Text
               .Fields("ReintegroIdMoneda").Value = oF.dcfields(0).BoundText
               .Fields("ReintegroIdCuenta").Value = oF.dcfields(1).BoundText
            End With
         End If
      End If
   End With
   
   Unload oF
   Set oF = Nothing

End Sub

Public Sub DistribuirPorObras()

   On Error GoTo Mal
   
   Dim Filas1, Columnas1
   Dim s As String
   
   s = Lista.GetString
   Filas1 = Split(s, vbCrLf)
   
   If UBound(Filas1) > 2 Then
      MsgBox "Solo puede elegir un registro a distribuir por vez", vbExclamation
      Exit Sub
   End If
   
   Dim oF As frmDistribucionesObras
   Dim s1 As String
   Dim mIdDistribucionObra As Long
   
   s1 = ""
   
   Set oF = New frmDistribucionesObras
   With oF
      .Id = -1
      .Disparar = Nothing
      .txtDescripcion.Visible = False
      .Check1.Visible = False
      With .dcfields(0)
         .Left = oF.txtDescripcion.Left
         .Top = oF.txtDescripcion.Top
         .Visible = True
      End With
      .cmd(0).Visible = False
      With .cmd(2)
         .Left = oF.cmd(0).Left
         .Top = oF.cmd(0).Top
         .Visible = True
      End With
      .Show vbModal, Me
      If .mOk Then
         mIdDistribucionObra = .dcfields(0).BoundText
         s1 = .Lista.GetStringCheck
      End If
   End With
   Unload oF
   Set oF = Nothing
   
   If Len(s1) = 0 Then
      MsgBox "No se pudo hacer la distribucion"
      Exit Sub
   End If
   
   Dim oRs As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim oL As ListItem
   Dim iFilas2 As Integer, i As Integer
   Dim idDet As Long, mIdObra As Long, mIdCuenta As Long
   Dim mPorcentaje As Single
   Dim mTotalIva As Double, mImporte As Double, mImporteOriginal As Double
   Dim mImporteTotal As Double, mIVA(10, 2) As Double
   Dim mDescripcionCuenta As String, mNumeroObra As String
   Dim Filas2, Columnas2
   
   mImporteTotal = 0
   
   Filas2 = Split(s1, vbCrLf)
   Columnas1 = Split(Filas1(1), vbTab)
   
   Set oRs = origen.DetComprobantesProveedores.Item(Columnas1(0)).Registro
   If Not oRs Is Nothing Then
      If IsNull(oRs.Fields("IdDistribucionObra").Value) Then
         For iFilas2 = 1 To UBound(Filas2)
            
            Columnas2 = Split(Filas2(iFilas2), vbTab)
            
            mIdObra = Columnas2(3)
            mPorcentaje = Columnas2(5)
            idDet = -1
            If iFilas2 = 1 Then idDet = Columnas1(0)
            
            With origen.DetComprobantesProveedores.Item(idDet)
               If idDet <> -1 Then .Registro.MoveFirst
               If iFilas2 = 1 Then
                  mImporteOriginal = IIf(IsNull(.Registro.Fields("Importe").Value), 0, .Registro.Fields("Importe").Value)
                  For i = 1 To 10
                     mIVA(i, 1) = IIf(IsNull(.Registro.Fields("ImporteIVA" & i).Value), 0, .Registro.Fields("ImporteIVA" & i).Value)
                  Next
               End If
               For i = 1 To oRs.Fields.Count - 1
                  .Registro.Fields(i).Value = oRs.Fields(i).Value
               Next
               mImporte = Round(mImporteOriginal * mPorcentaje / 100, 2)
               mImporteTotal = mImporteTotal + mImporte
               If iFilas2 = UBound(Filas2) And mImporteTotal <> mImporteOriginal Then
                  mImporte = mImporte + (mImporteOriginal - mImporteTotal)
               End If
               mTotalIva = 0
               For i = 1 To 10
                  .Registro.Fields("ImporteIVA" & i).Value = Round(mIVA(i, 1) * mPorcentaje / 100, 2)
                  mIVA(i, 2) = mIVA(i, 2) + .Registro.Fields("ImporteIVA" & i).Value
                  mTotalIva = mTotalIva + .Registro.Fields("ImporteIVA" & i).Value
               Next
               .Registro.Fields("Importe").Value = mImporte
               .Registro.Fields("IdObra").Value = mIdObra
               .Registro.Fields("IdDistribucionObra").Value = mIdDistribucionObra
               mDescripcionCuenta = Lista.SelectedItem.SubItems(1)
               If Not IsNull(.Registro.Fields("IdCuentaGasto").Value) Then
                  Set oRsAux = Aplicacion.Cuentas.TraerFiltrado("_PorObraCuentaGasto", Array(mIdObra, .Registro.Fields("IdCuentaGasto").Value))
                  If oRsAux.RecordCount > 0 Then
                     .Registro.Fields("IdCuenta").Value = oRsAux.Fields("IdCuenta").Value
                     .Registro.Fields("CodigoCuenta").Value = oRsAux.Fields("Codigo").Value
                     mDescripcionCuenta = oRsAux.Fields("Descripcion").Value
                  End If
                  oRsAux.Close
               End If
               
               mNumeroObra = ""
               Set oRsAux = Aplicacion.Obras.TraerFiltrado("_PorId", mIdObra)
               If oRsAux.RecordCount > 0 Then
                  mNumeroObra = oRsAux.Fields("NumeroObra").Value
               End If
               oRsAux.Close
               
               .Modificado = True
               idDet = .Id
            
               If iFilas2 > 1 Then
                  Set oL = Lista.ListItems.Add
                  oL.Tag = idDet
                  oL.SmallIcon = "Nuevo"
               Else
                  Set oL = Lista.SelectedItem
                  oL.SmallIcon = "Modificado"
               End If
               oL.Text = "" & .Registro.Fields("CodigoCuenta").Value
               oL.SubItems(1) = "" & mDescripcionCuenta
               oL.SubItems(2) = "" & mNumeroObra
               oL.SubItems(3) = "" & Lista.SelectedItem.SubItems(3)
               oL.SubItems(4) = "" & Format(mTotalIva, "#0.00")
               oL.SubItems(5) = "" & Format(mImporte, "#0.00")
            End With
         Next
         mTotalIva = 0
         For i = 1 To 10
            mTotalIva = mTotalIva + Round(mIVA(i, 1) - mIVA(i, 2), 2)
         Next
         txtTotal(3).Text = mTotalIva
      
      End If
   End If
   
Salida:

   Set oRs = Nothing
   Set oRsAux = Nothing
   
   CalculaComprobanteProveedor

   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select
   Resume Salida

End Sub

Public Sub RecalcularItems()

   On Error GoTo Mal
   
   Dim oL As ListItem
   Dim TotalIva As Double
   Dim i As Integer
   Dim mIVAs As String
   
   For Each oL In Lista.ListItems
      With origen.DetComprobantesProveedores.Item(oL.Tag)
         With .Registro
            TotalIva = 0
            mIVAs = ""
            For i = 1 To 10
               If .Fields("AplicarIVA" & i).Value = "SI" Then
                  If txtLetra.Text = "A" Or txtLetra.Text = "M" Then
                     .Fields("ImporteIVA" & i).Value = Round(CDbl(.Fields("IVAComprasPorcentaje" & i).Value) * CDbl(.Fields("Importe").Value) / 100, 2)
                  Else
                     .Fields("ImporteIVA" & i).Value = Round(CDbl(.Fields("Importe").Value) - (CDbl(.Fields("Importe").Value) / (1 + (CDbl(.Fields("IVAComprasPorcentaje" & i).Value) / 100))), 2)
                  End If
                  TotalIva = TotalIva + .Fields("ImporteIVA" & i).Value
                  mIVAs = mIVAs & Format(.Fields("IVAComprasPorcentaje" & i).Value, "##0.00") & "%  "
               End If
            Next
         End With
         .Modificado = True
         oL.SubItems(3) = "" & mIVAs
         oL.SubItems(4) = "" & Format(TotalIva, "#0.00")
      End With
   Next

Salida:
   Exit Sub
   
Mal:
   Dim mvarResp As Integer
   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select
   Resume Salida

End Sub

Public Property Get Confirmado() As String

   Confirmado = mvarConfirmado

End Property

Public Property Let Confirmado(ByVal vnewvalue As String)

   mvarConfirmado = vnewvalue

End Property

Private Sub DuplicarItemComprobante()

   Dim oRs As ADOR.Recordset
   Dim idDet As Long, i As Long
   
   Set oRs = origen.DetComprobantesProveedores.Item(Lista.SelectedItem.Tag).Registro
   
   With origen.DetComprobantesProveedores.Item(-1)
      For i = 2 To oRs.Fields.Count - 1
         .Registro.Fields(i).Value = oRs.Fields(i).Value
      Next
      .Registro.Fields("Item").Value = Lista.ListItems.Count + 1
      .Modificado = True
      idDet = .Id
   End With
   Set oRs = Nothing
   
   Set Lista.DataSource = origen.DetComprobantesProveedores.RegistrosConFormato
   
   CalculaComprobanteProveedor

End Sub

Public Property Get GrabacionAutomatica() As Boolean

   GrabacionAutomatica = mvarGrabacionAutomatica

End Property

Public Property Let GrabacionAutomatica(ByVal vnewvalue As Boolean)

   mvarGrabacionAutomatica = vnewvalue

End Property

Public Sub GrabacionAutomaticaComprobante()

   Me.Refresh
   DoEvents
   
   Dim oL As ListItem
   Dim TotalIva As Double
   Dim i As Integer
   Dim mIVAs As String
   
   For Each oL In Lista.ListItems
      With origen.DetComprobantesProveedores.Item(oL.Tag)
         With .Registro
            TotalIva = 0
            mIVAs = ""
            For i = 1 To 10
               If .Fields("AplicarIVA" & i).Value = "SI" Then
                  If txtLetra.Text = "A" Or txtLetra.Text = "M" Then
                     .Fields("ImporteIVA" & i).Value = Round(CDbl(.Fields("IVAComprasPorcentaje" & i).Value) * CDbl(.Fields("Importe").Value) / 100, 2)
                  Else
                     .Fields("ImporteIVA" & i).Value = Round(CDbl(.Fields("Importe").Value) - (CDbl(.Fields("Importe").Value) / (1 + (CDbl(.Fields("IVAComprasPorcentaje" & i).Value) / 100))), 2)
                  End If
                  TotalIva = TotalIva + .Fields("ImporteIVA" & i).Value
                  mIVAs = mIVAs & Format(.Fields("IVAComprasPorcentaje" & i).Value, "##0.00") & "%  "
               End If
            Next
         End With
         .Modificado = True
         oL.SubItems(3) = "" & mIVAs
         oL.SubItems(4) = "" & Format(TotalIva, "#0.00")
      End With
   Next
   
   CalculaComprobanteProveedor
   
   With origen.Registro
      .Fields("TotalBruto").Value = mvarSubTotal
      .Fields("TotalIva1").Value = mvarIVA1
      .Fields("TotalIva2").Value = mvarIVA2
      .Fields("AjusteIVA").Value = mvarAjusteIVA
      .Fields("TotalIVANoDiscriminado").Value = mvarIVANoDiscriminado
      .Fields("TotalComprobante").Value = mvarTotalComprobanteProveedor
      If Option1.Value Then
         .Fields("IdProveedorEventual").Value = Null
         .Fields("IdOrdenPago").Value = Null
         If Option3.Value Then
            .Fields("BienesOServicios").Value = "B"
         Else
            .Fields("BienesOServicios").Value = "S"
         End If
      ElseIf Option2.Value Then
         .Fields("IdProveedor").Value = Null
         .Fields("BienesOServicios").Value = Null
      ElseIf Option5.Value Then
         .Fields("IdProveedor").Value = Null
         .Fields("IdProveedorEventual").Value = Null
         .Fields("IdCuenta").Value = Null
         .Fields("IdOrdenPago").Value = Null
         .Fields("BienesOServicios").Value = Null
      End If
      .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text
      .Fields("CotizacionDolar").Value = txtCotizacionDolar.Text
      .Fields("CotizacionEuro").Value = txtCotizacionEuro.Text
      .Fields("Confirmado").Value = "SI"
      If mvarId < 0 Then
         .Fields("IdUsuarioIngreso").Value = glbIdUsuario
         .Fields("FechaIngreso").Value = Now
      Else
         .Fields("IdUsuarioModifico").Value = glbIdUsuario
         .Fields("FechaModifico").Value = Now
      End If
      If Frame4.Visible Then
         If Option6.Value Then
            .Fields("DestinoPago").Value = "A"
         Else
            .Fields("DestinoPago").Value = "O"
         End If
      Else
         .Fields("DestinoPago").Value = Null
      End If
   End With
   
   origen.Guardar
   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
   Unload Me
   'Me.Hide

End Sub

Public Property Get IdComprobanteAnterior() As Long

   IdComprobanteAnterior = mvarIdComprobanteAnterior

End Property

Public Property Let IdComprobanteAnterior(ByVal vnewvalue As Long)

   mvarIdComprobanteAnterior = vnewvalue

End Property

Public Sub CargarDatosDesdeComprobanteGrabado()

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim i As Integer
   
   Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorId", Me.IdComprobanteAnterior)
   With origen.Registro
      .Fields("IdProveedor").Value = oRs.Fields("IdProveedor").Value
      .Fields("IdTipoComprobante").Value = oRs.Fields("IdTipoComprobante").Value
      .Fields("FechaComprobante").Value = oRs.Fields("FechaComprobante").Value
      .Fields("Letra").Value = Null
      .Fields("NumeroComprobante1").Value = 0
      .Fields("FechaRecepcion").Value = oRs.Fields("FechaRecepcion").Value
      .Fields("FechaVencimiento").Value = oRs.Fields("FechaVencimiento").Value
      .Fields("PorcentajeBonificacion").Value = oRs.Fields("PorcentajeBonificacion").Value
      .Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
      .Fields("DiasVencimiento").Value = oRs.Fields("DiasVencimiento").Value
      .Fields("IdObra").Value = oRs.Fields("IdObra").Value
      .Fields("IdProveedorEventual").Value = oRs.Fields("IdProveedorEventual").Value
      .Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
      .Fields("IdMoneda").Value = oRs.Fields("IdMoneda").Value
      .Fields("CotizacionMoneda").Value = oRs.Fields("CotizacionMoneda").Value
      .Fields("AjusteIVA").Value = oRs.Fields("AjusteIVA").Value
      .Fields("PorcentajeIVAAplicacionAjuste").Value = oRs.Fields("PorcentajeIVAAplicacionAjuste").Value
      .Fields("BienesOServicios").Value = oRs.Fields("BienesOServicios").Value
      .Fields("IdIBCondicion").Value = oRs.Fields("IdIBCondicion").Value
      .Fields("IdProvinciaDestino").Value = oRs.Fields("IdProvinciaDestino").Value
      .Fields("IdTipoRetencionGanancia").Value = oRs.Fields("IdTipoRetencionGanancia").Value
      .Fields("NumeroCAI").Value = oRs.Fields("NumeroCAI").Value
      .Fields("FechaVencimientoCAI").Value = oRs.Fields("FechaVencimientoCAI").Value
      .Fields("IdCodigoAduana").Value = oRs.Fields("IdCodigoAduana").Value
      .Fields("IdCodigoDestinacion").Value = oRs.Fields("IdCodigoDestinacion").Value
      .Fields("NumeroDespacho").Value = oRs.Fields("NumeroDespacho").Value
      .Fields("DigitoVerificadorNumeroDespacho").Value = oRs.Fields("DigitoVerificadorNumeroDespacho").Value
      .Fields("FechaDespachoAPlaza").Value = oRs.Fields("FechaDespachoAPlaza").Value
      .Fields("IdCondicionCompra").Value = oRs.Fields("IdCondicionCompra").Value
      .Fields("Importacion_FOB").Value = oRs.Fields("Importacion_FOB").Value
      .Fields("Importacion_PosicionAduana").Value = oRs.Fields("Importacion_PosicionAduana").Value
      .Fields("Importacion_Despacho").Value = oRs.Fields("Importacion_Despacho").Value
      .Fields("Importacion_Guia").Value = oRs.Fields("Importacion_Guia").Value
      .Fields("Importacion_IdPaisOrigen").Value = oRs.Fields("Importacion_IdPaisOrigen").Value
      .Fields("Importacion_FechaEmbarque").Value = oRs.Fields("Importacion_FechaEmbarque").Value
      .Fields("Importacion_FechaOficializacion").Value = oRs.Fields("Importacion_FechaOficializacion").Value
      .Fields("InformacionAuxiliar").Value = oRs.Fields("InformacionAuxiliar").Value
      .Fields("GravadoParaSUSS").Value = oRs.Fields("GravadoParaSUSS").Value
      .Fields("PorcentajeParaSUSS").Value = oRs.Fields("PorcentajeParaSUSS").Value
      .Fields("FondoReparo").Value = oRs.Fields("FondoReparo").Value
      .Fields("ReintegroImporte").Value = oRs.Fields("ReintegroImporte").Value
      .Fields("ReintegroDespacho").Value = oRs.Fields("ReintegroDespacho").Value
      .Fields("ReintegroIdMoneda").Value = oRs.Fields("ReintegroIdMoneda").Value
      .Fields("ReintegroIdCuenta").Value = oRs.Fields("ReintegroIdCuenta").Value
      .Fields("IdCuentaOtros").Value = oRs.Fields("IdCuentaOtros").Value
      If Not IsNull(.Fields("IdProveedor").Value) Then
         Option1.Value = True
      ElseIf Not IsNull(.Fields("IdCuentaOtros").Value) Then
         Option5.Value = True
      Else
         Option2.Value = True
         If Not IsNull(.Fields("IdOrdenPago").Value) Then
            Set oRs1 = Aplicacion.OrdenesPago.TraerFiltrado("_PorId", .Fields("IdOrdenPago").Value)
            If oRs1.RecordCount > 0 Then
               txtOrdenPago.Text = oRs1.Fields("NumeroOrdenPago").Value
            End If
            oRs1.Close
            Set oRs1 = Nothing
         End If
      End If
      mvarCotizacion = Cotizacion(Date, glbIdMonedaDolar)
      .Fields("CotizacionDolar").Value = mvarCotizacion
      txtCotizacionDolar.Text = mvarCotizacion
      mvarCotizacionEuro = Cotizacion(Date, glbIdMonedaEuro)
      .Fields("CotizacionEuro").Value = mvarCotizacionEuro
      txtCotizacionEuro.Text = mvarCotizacionEuro
      txtCotizacionMoneda.Text = IIf(IsNull(.Fields("CotizacionMoneda").Value), 0, .Fields("CotizacionMoneda").Value)
      txtTotal(3).Text = IIf(IsNull(.Fields("AjusteIVA").Value), 0, .Fields("AjusteIVA").Value)
   End With
   
   Set oRs1 = Aplicacion.TablasGenerales.TraerFiltrado("DetComprobantesProveedores", _
                                    "_PorIdCabecera", Me.IdComprobanteAnterior)
   If oRs1.RecordCount > 0 Then
      oRs1.MoveFirst
      Do While Not oRs1.EOF
         With origen.DetComprobantesProveedores.Item(-1)
            For i = 2 To oRs1.Fields.Count - 1
               .Registro.Fields(i).Value = oRs1.Fields(i).Value
            Next
            .Modificado = True
         End With
         oRs1.MoveNext
      Loop
   End If
   oRs1.Close
   
   Set oRs = Nothing
   Set oRs1 = Nothing
   
   Set Lista.DataSource = origen.DetComprobantesProveedores.RegistrosConFormato
   
   MostrarDatos 0
   CalculaComprobanteProveedor

End Sub

Public Sub IncorporarDesdePedido(ByVal Filas As Variant, ByRef mError As String)

   Dim oAp As ComPronto.Aplicacion
   Dim oPr As ComPronto.ComprobanteProveedor
   Dim oRsPre As ADOR.Recordset
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oF As frm_Aux
   Dim mIdCodigoIva As Integer
   Dim iFilas As Long, iColumnas As Long, mSubNumero As Long, mIdCuentaIvaCompras1 As Long
   Dim mIdTipoComprobante As Long, mIdCuentaDiferenciaCambio As Long, i As Long, j As Long
   Dim mCodigoCuentaDiferenciaCambio As Long, mIdMoneda As Long, mCodBar As Long
   Dim mIdTipoComprobanteNDInternaAcreedores As Long, mIdTipoComprobanteNCInternaAcreedores As Long
   Dim mIdCuentaIvaCompras(10) As Long
   Dim mIVAComprasPorcentaje(10) As Single
   Dim mIVAComprasPorcentaje1 As Single
   Dim mvarImporte As Double
   Dim s As String, mvarConIVA As String, mAplicaIVA As String, mAuxS1 As String
   Dim mProcesar As Boolean, mOk As Boolean
   Dim Columnas
   
   Set oAp = Aplicacion
   
   Set oRs = oAp.Parametros.Item(1).Registro
   For i = 1 To 10
      If Not IsNull(oRs.Fields("IdCuentaIvaCompras" & i).Value) Then
         mIdCuentaIvaCompras(i) = oRs.Fields("IdCuentaIvaCompras" & i).Value
         mIVAComprasPorcentaje(i) = oRs.Fields("IVAComprasPorcentaje" & i).Value
      Else
         mIdCuentaIvaCompras(i) = 0
         mIVAComprasPorcentaje(i) = 0
      End If
   Next
   oRs.Close
   
   Columnas = Split(Filas(1), vbTab)
   
   Set oRs = oAp.Pedidos.Item(Columnas(17)).Registro
   Set oRsDet = oAp.Pedidos.TraerFiltrado("_DetallesParaComprobantesProveedores", Columnas(17))
   
   mProcesar = True
   mIdMoneda = 0
   
   With origen.Registro
      .Fields("IdMoneda").Value = oRs.Fields("IdMoneda").Value
      If BuscarClaveINI("Control por codigo recepcion a comprobante") = "SI" And _
            Not IsNull(oRs.Fields("CodigoControl").Value) Then
         Set oF = New frm_Aux
         oF.Label1.Caption = "Codigo de barras :"
         oF.Show vbModal, Me
         mCodBar = Val(oF.Text1.Text)
         mOk = oF.Ok
         Unload oF
         Set oF = Nothing
         If (Not mOk Or oRs.Fields("CodigoControl").Value <> mCodBar) And _
               mCodBar <> 0 Then
            MsgBox "Codigo de control incorrecto, proceso cancelado", vbExclamation
            GoTo Salida
         End If
      End If
      If Not IsNull(.Fields("IdProveedor").Value) And _
         .Fields("IdProveedor").Value <> oRs.Fields("IdProveedor").Value And _
         Lista.ListItems.Count > 0 Then
         mError = mError & "El pedido no se tomo porque no es" & vbCrLf & _
                  "del proveedor actual." & vbCrLf
         mProcesar = False
      Else
         .Fields("IdProveedor").Value = oRs.Fields("IdProveedor").Value
      End If
      If Not IsNull(oRs.Fields("Cumplido").Value) And oRs.Fields("Cumplido").Value = "AN" Then
         mError = mError & "El pedido ha sido anulado." & vbCrLf
         mProcesar = False
      End If
   End With

   If mProcesar Then
      mAplicaIVA = "SI"
      mIdCodigoIva = 0
      If Not IsNull(origen.Registro.Fields("IdProveedor").Value) Then
         Set oRs1 = oAp.Proveedores.TraerFiltrado("_PorId", origen.Registro.Fields("IdProveedor").Value)
         If oRs1.RecordCount > 0 Then
            If Not IsNull(oRs1.Fields("IdCodigoIva").Value) And _
                  (oRs1.Fields("IdCodigoIva").Value = 3 Or oRs1.Fields("IdCodigoIva").Value = 5 Or _
                   oRs1.Fields("IdCodigoIva").Value = 8 Or oRs1.Fields("IdCodigoIva").Value = 9) Then
               mAplicaIVA = "NO"
            End If
            mIdCodigoIva = IIf(IsNull(oRs1.Fields("IdCodigoIva").Value), 0, oRs1.Fields("IdCodigoIva").Value)
         End If
         oRs1.Close
      End If
      
      Do While Not oRsDet.EOF
         mProcesar = True
         Set oRs1 = origen.DetComprobantesProveedores.Registros
         If oRs1.Fields.Count > 0 Then
            If oRs1.RecordCount > 0 Then
               oRs1.MoveFirst
               Do While Not oRs1.EOF
                  If oRs1.Fields("IdDetallePedido").Value = oRsDet.Fields("IdDetallePedido").Value Then
                     mProcesar = False
                     Exit Do
                  End If
                  oRs1.MoveNext
               Loop
            End If
         End If
         oRs1.Close
         Set oRs1 = Nothing
         
         If mProcesar Then
            mIdCuentaIvaCompras1 = 0
            mIVAComprasPorcentaje1 = 0
            If Not IsNull(oRsDet.Fields("PorcentajeIVA").Value) Then
               If oRsDet.Fields("PorcentajeIVA").Value <> 0 Then
                  For i = 1 To 10
                     If mIVAComprasPorcentaje(i) = oRsDet.Fields("PorcentajeIVA").Value Then
                        mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(i)
                        mIVAComprasPorcentaje1 = mIVAComprasPorcentaje(i)
                        Exit For
                     End If
                  Next
               End If
            End If
            
            If Not IsNull(oRsDet.Fields("IdCondicionCompra").Value) Then
               mCondicionDesdePedido = True
               origen.Registro.Fields("IdCondicionCompra").Value = oRsDet.Fields("IdCondicionCompra").Value
            End If
            If Not IsNull(oRsDet.Fields("IdObra").Value) Then
               origen.Registro.Fields("IdObra").Value = oRsDet.Fields("IdObra").Value
            End If
            
            mvarImporte = IIf(IsNull(oRsDet.Fields("Importe").Value), 0, oRsDet.Fields("Importe").Value)
            
            With origen.DetComprobantesProveedores.Item(-1)
               With .Registro
                  .Fields("IdDetallePedido").Value = oRsDet.Fields("IdDetallePedido").Value
                  .Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                  .Fields("IdObra").Value = oRsDet.Fields("IdObra").Value
                  .Fields("IdCuenta").Value = oRsDet.Fields("IdCuentaContable").Value
                  .Fields("CodigoCuenta").Value = oRsDet.Fields("CodigoCuenta").Value
                  .Fields("Importe").Value = mvarImporte
                  If mIdCuentaIvaCompras1 <> 0 And mAplicaIVA = "SI" Then
                     .Fields("IdCuentaIvaCompras1").Value = mIdCuentaIvaCompras1
                     .Fields("IVAComprasPorcentaje1").Value = mIVAComprasPorcentaje1
                     If mIdCodigoIva <> 1 Then
                        .Fields("ImporteIVA1").Value = Round(mvarImporte - (mvarImporte / (1 + (mIVAComprasPorcentaje1 / 100))), mvarDecimales)
                     Else
                        .Fields("ImporteIVA1").Value = Round(mvarImporte * mIVAComprasPorcentaje1 / 100, mvarDecimales)
                     End If
                     .Fields("AplicarIVA1").Value = "SI"
                  Else
                     .Fields("IdCuentaIvaCompras1").Value = Null
                     .Fields("IVAComprasPorcentaje1").Value = 0
                     .Fields("ImporteIVA1").Value = 0
                     .Fields("AplicarIVA1").Value = "NO"
                  End If
                  For i = 2 To 10
                     .Fields("IdCuentaIvaCompras" & i).Value = Null
                     .Fields("IVAComprasPorcentaje" & i).Value = 0
                     .Fields("ImporteIVA" & i).Value = 0
                     .Fields("AplicarIVA" & i).Value = "NO"
                  Next
                  .Fields("IdPedido").Value = oRs.Fields("IdPedido").Value
                  .Fields("Cantidad").Value = oRsDet.Fields("Cantidad").Value
                  .Fields("IdDetalleObraDestino").Value = oRsDet.Fields("IdDetalleObraDestino").Value
                  .Fields("IdPresupuestoObraRubro").Value = oRsDet.Fields("IdPresupuestoObraRubro").Value
                  .Fields("NumeroSubcontrato").Value = oRs.Fields("NumeroSubcontrato").Value
                  .Fields("IdRubroContable").Value = oRsDet.Fields("IdRubroFinanciero").Value
               End With
               .Modificado = True
            End With
         End If
         
         oRsDet.MoveNext
      Loop
   End If
   
   If Not IsNull(oRs.Fields("ImpuestosInternos").Value) And oRs.Fields("ImpuestosInternos").Value <> 0 Then
      With origen.DetComprobantesProveedores.Item(-1)
         With .Registro
            .Fields("IdDetalleRecepcion").Value = Null
            .Fields("IdArticulo").Value = Null
            .Fields("IdObra").Value = Null
            .Fields("IdCuenta").Value = Null
            .Fields("CodigoCuenta").Value = Null
            .Fields("Importe").Value = IIf(IsNull(oRs.Fields("ImpuestosInternos").Value), 0, oRs.Fields("ImpuestosInternos").Value)
            For i = 1 To 10
               .Fields("IdCuentaIvaCompras" & i).Value = Null
               .Fields("IVAComprasPorcentaje" & i).Value = 0
               .Fields("ImporteIVA" & i).Value = 0
               .Fields("AplicarIVA" & i).Value = "NO"
            Next
            .Fields("IdPedido").Value = oRs.Fields("IdPedido").Value
         End With
         .Modificado = True
      End With
   End If
   
   For i = 1 To 5
      If Not IsNull(oRs.Fields("OtrosConceptos" & i).Value) And oRs.Fields("OtrosConceptos" & i).Value <> 0 Then
         With origen.DetComprobantesProveedores.Item(-1)
            With .Registro
               .Fields("IdDetalleRecepcion").Value = Null
               .Fields("IdArticulo").Value = Null
               .Fields("IdObra").Value = Null
               .Fields("IdCuenta").Value = Null
               .Fields("CodigoCuenta").Value = Null
               .Fields("Importe").Value = IIf(IsNull(oRs.Fields("OtrosConceptos" & i).Value), 0, oRs.Fields("OtrosConceptos" & i).Value)
               For j = 1 To 10
                  .Fields("IdCuentaIvaCompras" & j).Value = Null
                  .Fields("IVAComprasPorcentaje" & j).Value = 0
                  .Fields("ImporteIVA" & j).Value = 0
                  .Fields("AplicarIVA" & j).Value = "NO"
               Next
               .Fields("IdPedido").Value = oRs.Fields("IdPedido").Value
            End With
            .Modificado = True
         End With
      End If
   Next
   
Salida:
   oRs.Close
   oRsDet.Close
   
   Set oRs = Nothing
   Set oRs1 = Nothing
   Set oRsDet = Nothing
   Set oAp = Nothing
   
   Set Lista.DataSource = origen.DetComprobantesProveedores.RegistrosConFormato
   
   MostrarDatos 0
   CalculaComprobanteProveedor

End Sub

Public Sub AnticipoAProveedores()

   Dim oF As Form
   Dim oRs As ADOR.Recordset
   Dim mIdPedido As Long, mIdProveedor As Long, mIdObra As Long, mIdCuentaContable As Long
   Dim mPorcentaje As Double
   Dim mOk As Boolean
   Dim mTipo As String
   
   Set oF = New frmConsulta3
   With oF
      If IsNumeric(dcfields(0).BoundText) Then
         .IdProveedor = dcfields(0).BoundText
      Else
         .IdProveedor = -1
      End If
      .Id = 111
      .lblInfo.Visible = True
      .Show vbModal, Me
      mIdPedido = .IdPedido
      mIdProveedor = .IdProveedor
   End With
   Unload oF
   Set oF = Nothing
   
   If mIdPedido <= 0 Then Exit Sub
   
   Set oF = New frm_Aux
   With oF
      .Id = 15
      .Show vbModal, Me
      mPorcentaje = Val(.Text1.Text)
      mTipo = "C"
      If .Option1.Value Then mTipo = "A"
      mOk = .Ok
   End With
   Unload oF
   Set oF = Nothing
   
   If Not mOk Then Exit Sub
   
   Set oRs = Aplicacion.Pedidos.TraerFiltrado("_DetallesParaComprobantesProveedores", mIdPedido)
   mIdObra = 0
   mIdCuentaContable = 0
   If oRs.RecordCount > 0 Then
      mIdObra = IIf(IsNull(oRs.Fields("IdObra").Value), 0, oRs.Fields("IdObra").Value)
      mIdCuentaContable = IIf(IsNull(oRs.Fields("IdCuentaContable").Value), 0, oRs.Fields("IdCuentaContable").Value)
   End If
   oRs.Close
   
   Me.IdPedidoAnticipo = mIdPedido
   Me.PorcentajeAnticipo = mPorcentaje
   Me.Anticipo_O_Devolucion = mTipo
   Me.IdCuentaContable = mIdCuentaContable
   With origen.Registro
      If IsNull(.Fields("IdProveedor").Value) Then .Fields("IdProveedor").Value = mIdProveedor
      If mIdObra <> 0 And IsNull(.Fields("IdObra").Value) Then .Fields("IdObra").Value = mIdObra
   End With
   Editar -1

End Sub

Public Property Get IdPedidoAnticipo() As Long

   IdPedidoAnticipo = mvarIdPedido

End Property

Public Property Let IdPedidoAnticipo(ByVal vnewvalue As Long)

   mvarIdPedido = vnewvalue

End Property

Public Property Get PorcentajeAnticipo() As Single

   PorcentajeAnticipo = mvarPorcentajeAnticipo
   
End Property

Public Property Let PorcentajeAnticipo(ByVal vnewvalue As Single)

   mvarPorcentajeAnticipo = vnewvalue

End Property

Public Property Get Anticipo_O_Devolucion() As String

   Anticipo_O_Devolucion = mvarAnticipo_O_Devolucion
   
End Property

Public Property Let Anticipo_O_Devolucion(ByVal vnewvalue As String)

   mvarAnticipo_O_Devolucion = vnewvalue

End Property

Public Property Get IdCuentaContable() As Long

   IdCuentaContable = mvarIdCuentaContable

End Property

Public Property Let IdCuentaContable(ByVal vnewvalue As Long)

   mvarIdCuentaContable = vnewvalue

End Property
