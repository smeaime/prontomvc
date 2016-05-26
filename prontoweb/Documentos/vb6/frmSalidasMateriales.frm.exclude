VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.4#0"; "Controles1013.ocx"
Begin VB.Form frmSalidasMateriales 
   Caption         =   "Salida de materiales"
   ClientHeight    =   7575
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11505
   Icon            =   "frmSalidasMateriales.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   7575
   ScaleWidth      =   11505
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtNumeroOP 
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
      Left            =   8325
      TabIndex        =   92
      Top             =   3690
      Width           =   1005
   End
   Begin VB.TextBox txtDetalle 
      DataField       =   "Detalle"
      Height          =   285
      Left            =   1755
      TabIndex        =   90
      Top             =   3465
      Width           =   5055
   End
   Begin VB.CommandButton cmd 
      Height          =   420
      Index           =   4
      Left            =   6030
      Picture         =   "frmSalidasMateriales.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   89
      ToolTipText     =   "Importacion de items desde Excel"
      Top             =   6705
      UseMaskColor    =   -1  'True
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.TextBox txtDestinoDeObra 
      DataField       =   "DestinoDeObra"
      Height          =   285
      Left            =   8325
      TabIndex        =   87
      Top             =   3375
      Width           =   3075
   End
   Begin VB.TextBox txtCodigoEquipo 
      Alignment       =   2  'Center
      Height          =   315
      Left            =   10530
      TabIndex        =   82
      Top             =   1440
      Visible         =   0   'False
      Width           =   1005
   End
   Begin VB.TextBox txtNumeroRemitoTransporte 
      Alignment       =   2  'Center
      DataField       =   "NumeroRemitoTransporte"
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
      Left            =   8325
      TabIndex        =   80
      Top             =   2700
      Width           =   1500
   End
   Begin VB.TextBox txtEmbalo 
      DataField       =   "Embalo"
      Height          =   285
      Left            =   10440
      TabIndex        =   77
      Top             =   2700
      Width           =   960
   End
   Begin VB.TextBox txtBultos 
      DataField       =   "Bultos"
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
      Left            =   8010
      TabIndex        =   73
      Top             =   6570
      Width           =   1005
   End
   Begin VB.TextBox txtValorDeclarado 
      DataField       =   "ValorDeclarado"
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
      Left            =   10395
      TabIndex        =   71
      Top             =   6930
      Width           =   1005
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Anular"
      Height          =   420
      Index           =   3
      Left            =   3285
      TabIndex        =   67
      Top             =   6705
      Width           =   975
   End
   Begin VB.CheckBox Check3 
      Caption         =   "Check2"
      Enabled         =   0   'False
      Height          =   240
      Left            =   8325
      TabIndex        =   64
      Top             =   405
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.CheckBox Check2 
      Caption         =   "Check2"
      Enabled         =   0   'False
      Height          =   240
      Left            =   8325
      TabIndex        =   63
      Top             =   90
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.TextBox txtChofer 
      DataField       =   "Chofer"
      Enabled         =   0   'False
      Height          =   285
      Left            =   8325
      TabIndex        =   59
      Top             =   2385
      Width           =   1500
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   1
      Left            =   2700
      Picture         =   "frmSalidasMateriales.frx":0CF4
      Style           =   1  'Graphical
      TabIndex        =   56
      Top             =   6705
      Width           =   525
   End
   Begin VB.TextBox txtReferencia 
      DataField       =   "Referencia"
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
      Left            =   10395
      TabIndex        =   54
      Top             =   6570
      Width           =   1005
   End
   Begin VB.TextBox txtNumeroDocumento 
      DataField       =   "NumeroDocumento"
      Enabled         =   0   'False
      Height          =   285
      Left            =   9855
      TabIndex        =   52
      Top             =   2385
      Width           =   1545
   End
   Begin VB.TextBox txtPatente4 
      DataField       =   "Patente4"
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
      Left            =   4860
      TabIndex        =   51
      Top             =   7155
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox txtPatente3 
      DataField       =   "Patente3"
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
      Left            =   3285
      TabIndex        =   50
      Top             =   7155
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox txtPatente2 
      Alignment       =   2  'Center
      DataField       =   "Patente2"
      Enabled         =   0   'False
      Height          =   285
      Left            =   10665
      TabIndex        =   49
      Top             =   1755
      Width           =   735
   End
   Begin VB.TextBox txtPatente1 
      DataField       =   "Patente1"
      Enabled         =   0   'False
      Height          =   285
      Left            =   9945
      TabIndex        =   47
      Top             =   1755
      Width           =   735
   End
   Begin VB.TextBox txtValePreimpreso 
      Alignment       =   1  'Right Justify
      DataField       =   "ValePreimpreso"
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
      Left            =   5895
      TabIndex        =   46
      Top             =   945
      Width           =   915
   End
   Begin VB.Frame Frame1 
      Caption         =   "Costo del flete : "
      Enabled         =   0   'False
      Height          =   420
      Left            =   3060
      TabIndex        =   40
      Top             =   450
      Visible         =   0   'False
      Width           =   3705
      Begin VB.OptionButton Option2 
         Caption         =   "A cargo proveedor"
         Height          =   195
         Left            =   1845
         TabIndex        =   42
         Top             =   180
         Width           =   1635
      End
      Begin VB.OptionButton Option1 
         Caption         =   "A cargo empresa"
         Height          =   195
         Left            =   135
         TabIndex        =   41
         Top             =   180
         Width           =   1590
      End
   End
   Begin VB.TextBox txtNumeroSalidaMateriales2 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroSalidaMateriales2"
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
      Left            =   3015
      TabIndex        =   1
      Top             =   45
      Width           =   690
   End
   Begin VB.TextBox txtCuit 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      Height          =   330
      Left            =   10125
      TabIndex        =   15
      Top             =   3015
      Width           =   1275
   End
   Begin VB.TextBox txtCondicionIva 
      Enabled         =   0   'False
      Height          =   330
      Left            =   8325
      TabIndex        =   14
      Top             =   3015
      Width           =   1770
   End
   Begin VB.TextBox txtLocalidad 
      Enabled         =   0   'False
      Height          =   330
      Left            =   4905
      TabIndex        =   13
      Top             =   3060
      Width           =   1905
   End
   Begin VB.TextBox txtCodigoPostal 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      Height          =   330
      Left            =   1755
      TabIndex        =   12
      Top             =   3060
      Width           =   600
   End
   Begin VB.TextBox txtDireccion 
      Enabled         =   0   'False
      Height          =   330
      Left            =   2385
      TabIndex        =   11
      Top             =   3060
      Width           =   2490
   End
   Begin VB.TextBox txtCliente 
      Enabled         =   0   'False
      Height          =   330
      Left            =   1755
      TabIndex        =   10
      Top             =   2700
      Width           =   5055
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   0
      ItemData        =   "frmSalidasMateriales.frx":127E
      Left            =   630
      List            =   "frmSalidasMateriales.frx":128B
      TabIndex        =   0
      Top             =   45
      Width           =   1860
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   0
      Left            =   90
      TabIndex        =   32
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   1
      Left            =   315
      TabIndex        =   31
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   2
      Left            =   540
      TabIndex        =   30
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   3
      Left            =   765
      TabIndex        =   29
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   4
      Left            =   990
      TabIndex        =   28
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   5
      Left            =   1215
      TabIndex        =   27
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   6
      Left            =   1440
      TabIndex        =   26
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Ver vales pendientes"
      Height          =   420
      Index           =   2
      Left            =   4320
      TabIndex        =   19
      Top             =   6705
      Width           =   1650
   End
   Begin VB.TextBox txtNumeroSalidaMateriales 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroSalidaMateriales"
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
      Left            =   3780
      TabIndex        =   3
      Top             =   45
      Width           =   1050
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   45
      TabIndex        =   16
      Top             =   6705
      Width           =   975
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   420
      Index           =   1
      Left            =   1080
      TabIndex        =   17
      Top             =   6705
      Width           =   975
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   0
      Left            =   2115
      Picture         =   "frmSalidasMateriales.frx":12C8
      Style           =   1  'Graphical
      TabIndex        =   18
      Top             =   6705
      UseMaskColor    =   -1  'True
      Width           =   525
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1050
      Left            =   1755
      TabIndex        =   9
      Top             =   1620
      Width           =   5055
      _ExtentX        =   8916
      _ExtentY        =   1852
      _Version        =   393217
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmSalidasMateriales.frx":1932
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   20
      Top             =   7290
      Width           =   11505
      _ExtentX        =   20294
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaSalidaMateriales"
      Height          =   330
      Index           =   0
      Left            =   5580
      TabIndex        =   4
      Top             =   45
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Enabled         =   0   'False
      Format          =   57212929
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   0
      Left            =   8595
      TabIndex        =   5
      Tag             =   "Obras"
      Top             =   45
      Width           =   2850
      _ExtentX        =   5027
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   2535
      Left            =   90
      TabIndex        =   2
      Top             =   4050
      Width           =   11400
      _ExtentX        =   20108
      _ExtentY        =   4471
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmSalidasMateriales.frx":19B4
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Aprobo"
      Height          =   315
      Index           =   1
      Left            =   1755
      TabIndex        =   8
      Tag             =   "Empleados"
      Top             =   1260
      Width           =   2445
      _ExtentX        =   4313
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdTransportista1"
      Height          =   315
      Index           =   2
      Left            =   8325
      TabIndex        =   6
      Tag             =   "Transportistas"
      Top             =   1035
      Width           =   3120
      _ExtentX        =   5503
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdTransportista"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdTransportista2"
      Height          =   315
      Index           =   3
      Left            =   8325
      TabIndex        =   7
      Tag             =   "Transportistas"
      Top             =   1395
      Width           =   3120
      _ExtentX        =   5503
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdTransportista"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Emitio"
      Height          =   315
      Index           =   4
      Left            =   1755
      TabIndex        =   44
      Tag             =   "Empleados"
      Top             =   900
      Width           =   2445
      _ExtentX        =   4313
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   5
      Left            =   8325
      TabIndex        =   57
      Tag             =   "Proveedores"
      Top             =   719
      Width           =   3120
      _ExtentX        =   5503
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservacionesItem 
      Height          =   195
      Left            =   6570
      TabIndex        =   60
      Top             =   1485
      Visible         =   0   'False
      Width           =   420
      _ExtentX        =   741
      _ExtentY        =   344
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmSalidasMateriales.frx":19D0
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCentroCosto"
      Height          =   315
      Index           =   6
      Left            =   8595
      TabIndex        =   61
      Tag             =   "CentrosCosto"
      Top             =   375
      Visible         =   0   'False
      Width           =   2850
      _ExtentX        =   5027
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdCentroCosto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdDepositoOrigen"
      Height          =   315
      Index           =   14
      Left            =   810
      TabIndex        =   69
      Tag             =   "Depositos"
      Top             =   405
      Visible         =   0   'False
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdDeposito"
      Text            =   ""
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   5130
      Top             =   3825
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
            Picture         =   "frmSalidasMateriales.frx":1A52
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSalidasMateriales.frx":1B64
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSalidasMateriales.frx":1FB6
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSalidasMateriales.frx":2408
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdColor"
      Height          =   315
      Index           =   7
      Left            =   7560
      TabIndex        =   76
      Tag             =   "Colores"
      Top             =   6930
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdColor"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdPuntoVenta"
      Height          =   315
      Index           =   10
      Left            =   3015
      TabIndex        =   79
      Tag             =   "PuntosVenta"
      Top             =   45
      Width           =   780
      _ExtentX        =   1376
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPuntoVenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdEquipo"
      Height          =   315
      Index           =   8
      Left            =   1215
      TabIndex        =   83
      Tag             =   "ArticulosEquipos"
      Top             =   1935
      Visible         =   0   'False
      Width           =   3120
      _ExtentX        =   5503
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdFlete"
      Height          =   315
      Index           =   9
      Left            =   8325
      TabIndex        =   85
      Tag             =   "Fletes"
      Top             =   1755
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdFlete"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdChofer"
      Height          =   315
      Index           =   11
      Left            =   8325
      TabIndex        =   86
      Tag             =   "Choferes"
      Top             =   2070
      Width           =   3075
      _ExtentX        =   5424
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdChofer"
      Text            =   ""
   End
   Begin VB.Label lblop 
      Caption         =   "Numero OP :"
      Height          =   240
      Left            =   7020
      TabIndex        =   93
      Top             =   3735
      Width           =   1260
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle :"
      Height          =   240
      Index           =   7
      Left            =   90
      TabIndex        =   91
      Top             =   3465
      Width           =   1620
   End
   Begin VB.Label lblLabels 
      Caption         =   "Destino de obra :"
      Height          =   240
      Index           =   6
      Left            =   7020
      TabIndex        =   88
      Top             =   3420
      Width           =   1275
   End
   Begin VB.Label lblData 
      Caption         =   "Nro.Remito Trans"
      Height          =   240
      Index           =   18
      Left            =   7020
      TabIndex        =   81
      Top             =   2700
      Width           =   1260
   End
   Begin VB.Label lblLabels 
      Caption         =   "Embalo :"
      Height          =   240
      Index           =   3
      Left            =   9900
      TabIndex        =   78
      Top             =   2745
      Width           =   525
   End
   Begin VB.Label lblData 
      Caption         =   "Color ident.:"
      Height          =   285
      Index           =   17
      Left            =   6705
      TabIndex        =   75
      Top             =   6930
      Width           =   855
   End
   Begin VB.Label lblData 
      Caption         =   "Cantidad bultos :"
      Height          =   240
      Index           =   16
      Left            =   6705
      TabIndex        =   74
      Top             =   6615
      Width           =   1260
   End
   Begin VB.Label lblData 
      Caption         =   "Valor declarado :"
      Height          =   285
      Index           =   15
      Left            =   9090
      TabIndex        =   72
      Top             =   6930
      Width           =   1260
   End
   Begin VB.Label lblData 
      Caption         =   "Origen :"
      Height          =   240
      Index           =   14
      Left            =   135
      TabIndex        =   70
      Top             =   450
      Visible         =   0   'False
      Width           =   630
   End
   Begin VB.Label lblEstado1 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "Label1"
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
      Left            =   4275
      TabIndex        =   68
      Top             =   1305
      Visible         =   0   'False
      Width           =   1950
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
      Left            =   2070
      TabIndex        =   66
      Top             =   3825
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle de items :"
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
      Index           =   16
      Left            =   90
      TabIndex        =   65
      Top             =   3825
      Width           =   1545
   End
   Begin VB.Label lblData 
      Caption         =   "Centro de costo :"
      Height          =   240
      Index           =   13
      Left            =   7020
      TabIndex        =   62
      Top             =   405
      Visible         =   0   'False
      Width           =   1260
   End
   Begin VB.Label lblData 
      Caption         =   "Proveedor :"
      Height          =   285
      Index           =   12
      Left            =   7020
      TabIndex        =   58
      Top             =   720
      Width           =   1260
   End
   Begin VB.Label lblData 
      Caption         =   "Referencia :"
      Height          =   285
      Index           =   11
      Left            =   9090
      TabIndex        =   55
      Top             =   6570
      Width           =   1260
   End
   Begin VB.Label lblData 
      Caption         =   "Chofer/Docum. :"
      Height          =   240
      Index           =   10
      Left            =   7020
      TabIndex        =   53
      Top             =   2115
      Width           =   1260
   End
   Begin VB.Label lblLabels 
      Caption         =   "Unidad/Camion :"
      Height          =   240
      Index           =   5
      Left            =   7020
      TabIndex        =   48
      Top             =   1800
      Width           =   1260
   End
   Begin VB.Label lblData 
      Caption         =   "Nro. vale preimpreso :"
      Height          =   240
      Index           =   9
      Left            =   4275
      TabIndex        =   45
      Top             =   945
      Width           =   1560
   End
   Begin VB.Label lblData 
      Caption         =   "Emitido por : "
      Height          =   240
      Index           =   4
      Left            =   90
      TabIndex        =   43
      Top             =   945
      Width           =   1620
   End
   Begin VB.Label lblData 
      Caption         =   "Cond.Iva / CUIT :"
      Height          =   240
      Index           =   7
      Left            =   7020
      TabIndex        =   39
      Top             =   3060
      Width           =   1275
   End
   Begin VB.Label lblData 
      Caption         =   "Direccion / localidad :"
      Height          =   240
      Index           =   6
      Left            =   90
      TabIndex        =   38
      Top             =   3105
      Width           =   1620
   End
   Begin VB.Label lblcliente 
      Caption         =   "Cliente :"
      Height          =   240
      Left            =   90
      TabIndex        =   37
      Top             =   2745
      Width           =   1620
   End
   Begin VB.Label lblData 
      Caption         =   "Transportista 2 :"
      Height          =   285
      Index           =   3
      Left            =   7020
      TabIndex        =   36
      Top             =   1440
      Width           =   1260
   End
   Begin VB.Label lblData 
      Caption         =   "Transportista 1 :"
      Height          =   285
      Index           =   2
      Left            =   7020
      TabIndex        =   35
      Top             =   1080
      Width           =   1260
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Tipo : "
      Height          =   240
      Index           =   2
      Left            =   135
      TabIndex        =   34
      Top             =   90
      Width           =   450
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Autorizaciones : "
      Height          =   285
      Index           =   1
      Left            =   90
      TabIndex        =   33
      Top             =   2070
      Width           =   1200
   End
   Begin VB.Label lblData 
      Caption         =   "Liberado por :"
      Height          =   240
      Index           =   1
      Left            =   90
      TabIndex        =   25
      Top             =   1305
      Width           =   1620
   End
   Begin VB.Label lblData 
      Caption         =   "Obra :"
      Height          =   240
      Index           =   0
      Left            =   7020
      TabIndex        =   24
      Top             =   90
      Width           =   1260
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Nro. :"
      Height          =   240
      Index           =   14
      Left            =   2610
      TabIndex        =   23
      Top             =   90
      Width           =   360
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   4950
      TabIndex        =   22
      Top             =   90
      Width           =   570
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   240
      Index           =   0
      Left            =   90
      TabIndex        =   21
      Top             =   1665
      Width           =   1620
   End
   Begin VB.Label lblData 
      Caption         =   "Equipo :"
      Height          =   240
      Index           =   8
      Left            =   6795
      TabIndex        =   84
      Top             =   1665
      Visible         =   0   'False
      Width           =   1260
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
         Caption         =   "Asignar Equipo destino, OT y ubicacion"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Ingreso manual de cajas"
         Index           =   4
      End
   End
End
Attribute VB_Name = "frmSalidasMateriales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.SalidaMateriales
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mTipoSalida As Integer, mOk As Integer, mvarIdMonedaPesos As Integer, mvarFormatCodBar As Integer
Private mvarId As Long, mIdAprobo As Long, mvarIdUnidadCU As Long, mvarIdDepositoCentral As Long, mIdObraDefault As Long
Private mvarGrabado As Boolean, mvarModoCodigoBarra As Boolean, mvarSoloStockObra As Boolean, mvarImpresionHabilitada As Boolean
Private mvarNumerarPorPuntoVenta As Boolean, mvarTransportistaConEquipos As Boolean, mvarNoAnular As Boolean
Private mvarAnulada As String, mOpcionesAcceso As String, mCadena As String, mvarExigirEquipoDestino As String
Private mDescargaPorKit As String, mvarRegistroContableComprasAlActivo As String
Private mNivelAcceso As Integer

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

'   If Cual = -1 And mTipoSalida = 0 Then
'      MsgBox "Solo puede agregar items por arrastre desde los vales pendientes!", vbCritical
'      Exit Sub
'   End If
   
'   If Cual > 0 Then
'      MsgBox "No puede modificar una SalidaMateriales ya registrada, eliminela.", vbCritical
'      Exit Sub
'   End If
   
   If IsNull(origen.Registro.Fields("IdObra").Value) And Combo1(0).ListIndex <> 2 Then
      MsgBox "Antes de ingresar los detalles debe definir la obra", vbCritical
      Exit Sub
   End If
   
   Dim oF As frmDetSalidasMateriales
   Dim oL As ListItem
   
   Set oF = New frmDetSalidasMateriales
   
   With oF
      Set .SalidaMateriales = origen
      If dcfields(14).Visible And IsNumeric(dcfields(14).BoundText) Then
         .IdDepositoOrigen = dcfields(14).BoundText
      Else
         .IdDepositoOrigen = 0
      End If
      .FechaSalida = DTFields(0).Value
      .TipoSalida = mTipoSalida
      .Id = Cual
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
            .SubItems(1) = oF.txtCodigoArticulo.Text
            .SubItems(2) = oF.DataCombo1(1).Text
            .SubItems(3) = "" & oF.txtPartida.Text
            .SubItems(4) = "" & oF.txtCantidad.Text
            If mvarSoloStockObra And IsNumeric(dcfields(0).BoundText) Then
               .SubItems(5) = "" & Aplicacion.StockPorIdArticuloIdObra(oF.DataCombo1(1).BoundText, dcfields(0).BoundText)
            Else
               .SubItems(5) = "" & Aplicacion.StockPorIdArticulo(oF.DataCombo1(1).BoundText)
            End If
            If oF.mvarCantidadAdicional <> 0 Then
               .SubItems(6) = "" & oF.txtCantidad1.Text
               .SubItems(7) = "" & oF.txtCantidad2.Text
            End If
            .SubItems(8) = "" & oF.DataCombo1(0).Text
            .SubItems(9) = "" & oF.DataCombo1(2).Text
            .SubItems(10) = "" & oF.DataCombo1(3).Text
         End With
      End If
   End With
   
   Unload oF
   Set oF = Nothing
   
   mvarNoAnular = True
   
End Sub

Private Sub Check2_Click()

   If Check2.Value = 1 And mvarId = -1 Then
      origen.Registro.Fields("IdCentroCosto").Value = Null
'      dcfields(0).Enabled = True
'      Check3.Value = 0
'      dcfields(6).Enabled = False
   End If
   
End Sub

Private Sub Check3_Click()

   If Check3.Value = 1 And mvarId = -1 Then
'      origen.Registro.Fields("IdObra").Value = Null
'      dcfields(6).Enabled = True
'      Check2.Value = 0
'      dcfields(0).Enabled = False
   End If
   
End Sub

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal

   Select Case Index
      Case 0
         If Len(Combo1(0).Text) = 0 Then
            MsgBox "No determino el tipo de salida"
            Exit Sub
         End If
         
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar una salida de materiales de stock sin detalles"
            Exit Sub
         End If
         
         If Len(txtNumeroSalidaMateriales.Text) > 8 Then
            MsgBox "El numero de salida no puede superar los 8 digitos"
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim oRsDet As ADOR.Recordset
         Dim oRsStk As ADOR.Recordset
         Dim oRsAux As ADOR.Recordset
         Dim oRsAux1 As ADOR.Recordset
         Dim mvarCantidad As Double, mvarCantidadAdicional As Double
         Dim mvarCantidadUnidades As Double, mvarStock As Double, mvarStock1 As Double, mvarStock2 As Double
         Dim mvarCantConj As Double, mvarCantidad1 As Double, mvarCantidad2 As Double
         Dim mvarIdStock As Long, mNum As Long, mvarIdEquipoDestino As Long, mvarIdTipoRosca As Long
         Dim mvarNumero As Long, mvarNumeroAnt As Long, mvarIdCuentaComprasActivo As Long, mvarIdUnidad As Long
         Dim mvarIdUbicacion As Long, mvarIdObra As Long
         Dim mvarImprime As Integer
         Dim mvarAux1 As String, mvarAux2 As String, mvarAux3 As String, mvarAux4 As String, mvarAux5 As String
         Dim mvarParaMantenimiento As String, mvarBasePRONTOMantenimiento As String, mvarError As String
         Dim mvarArticulo1 As String, mvarArticulo As String, mvarDestino As String, mvarFamilia As String
         Dim mvarADistribuirEnPresupuestoDeObra As String, mvarPartida As String, mvarTomarObraCabecera As String
         Dim mvarRegistrarStock As Boolean
         Dim mAux1
         Dim oPar As ComPronto.Parametro
         
         mvarNumeroAnt = Val(txtNumeroSalidaMateriales.Text)
         
         For Each dtp In DTFields
            origen.Registro.Fields(dtp.DataField).Value = dtp.Value
         Next
         
         For Each dc In dcfields
            If dc.Enabled And dc.Visible Then
               If Not IsNumeric(dc.BoundText) And _
                     dc.Index <> 1 And dc.Index <> 2 And dc.Index <> 3 And dc.Index <> 7 And dc.Index <> 8 And dc.Index <> 9 And dc.Index <> 11 Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
               If IsNumeric(dc.BoundText) Then origen.Registro.Fields(dc.DataField).Value = dc.BoundText
            End If
         Next
         
         If Not IsNumeric(dcfields(8).BoundText) And dcfields(8).Visible And dcfields(8).Enabled And mvarTransportistaConEquipos Then
            MsgBox "Debe ingresar el equipo de transporte", vbExclamation
            Exit Sub
         End If

         mvarBasePRONTOMantenimiento = ""
         Set oRsStk = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
         If oRsStk.RecordCount > 0 Then
            mvarBasePRONTOMantenimiento = IIf(IsNull(oRsStk.Fields("BasePRONTOMantenimiento").Value), "", oRsStk.Fields("BasePRONTOMantenimiento").Value)
         End If
         oRsStk.Close
         
         mvarAux1 = BuscarClaveINI("Inhabilitar ubicaciones en movimientos de stock")
         mvarAux2 = BuscarClaveINI("Inhabilitar stock negativo")
         mvarAux3 = BuscarClaveINI("Controlar existencia de parte diario en salida de materiales")
         mvarAux4 = BuscarClaveINI("Controlar salidas contra lista de materiales")
         mvarAux5 = BuscarClaveINI("Inhabilitar stock global negativo")
         mvarTomarObraCabecera = BuscarClaveINI("Descontar stock tomando obra cabecera en salida de materiales", -1)
         mvarError = ""
'         If Not IsNull(origen.Registro.Fields("Aprobo").Value) Then
            Set oRsDet = origen.DetSalidasMateriales.Registros
            Set oRsAux1 = oRsDet.Clone
            If oRsDet.RecordCount > 0 Then
               With oRsDet
                  .MoveFirst
                  Do While Not .EOF
                     If Not .Fields("Eliminado").Value Then
                        If IsNull(.Fields("IdArticulo").Value) Then
                           Set oRsDet = Nothing
                           MsgBox "Articulo no definido!", vbExclamation
                           Exit Sub
                        End If
                        If IsNull(.Fields("IdUnidad").Value) Then
                           Set oRsDet = Nothing
                           MsgBox "Unidad de medida no definida!", vbExclamation
                           Exit Sub
                        End If
                        If IsNull(.Fields("IdUbicacion").Value) And mvarAux1 <> "SI" Then
                           Set oRsDet = Nothing
                           MsgBox "Ubicacion no definida en detalle!", vbExclamation
                           Exit Sub
                        End If
                        If IsNull(.Fields("Partida").Value) Then
                           Set oRsDet = Nothing
                           MsgBox "Partida no definida!", vbExclamation
                           Exit Sub
                        End If
                        
                        mvarPartida = IIf(IsNull(.Fields("Partida").Value), "", .Fields("Partida").Value)
                        mvarIdUnidad = IIf(IsNull(.Fields("IdUnidad").Value), 0, .Fields("IdUnidad").Value)
                        mvarIdUbicacion = IIf(IsNull(.Fields("IdUbicacion").Value), 0, .Fields("IdUbicacion").Value)
                        If mvarTomarObraCabecera = "SI" And Not IsNull(origen.Registro.Fields("IdObra").Value) Then
                           mvarIdObra = origen.Registro.Fields("IdObra").Value
                        Else
                           mvarIdObra = IIf(IsNull(.Fields("IdObra").Value), 0, .Fields("IdObra").Value)
                        End If
                        
                        mvarParaMantenimiento = "NO"
                        mvarArticulo = ""
                        mvarIdTipoRosca = 0
                        mvarRegistrarStock = True
                        Set oRsStk = Aplicacion.Articulos.TraerFiltrado("_PorIdConDatos", .Fields("IdArticulo").Value)
                        If oRsStk.RecordCount > 0 Then
                           mvarParaMantenimiento = IIf(IsNull(oRsStk.Fields("ParaMantenimiento").Value), "NO", oRsStk.Fields("ParaMantenimiento").Value)
                           mvarArticulo = IIf(IsNull(oRsStk.Fields("Codigo").Value), "", oRsStk.Fields("Codigo").Value)
                           mvarIdTipoRosca = IIf(IsNull(oRsStk.Fields("IdTipoRosca").Value), 0, oRsStk.Fields("IdTipoRosca").Value)
                           If Not IsNull(oRsStk.Fields("RegistrarStock").Value) And oRsStk.Fields("RegistrarStock").Value = "NO" Then
                              mvarRegistrarStock = False
                           End If
                           mvarADistribuirEnPresupuestoDeObra = IIf(IsNull(oRsStk.Fields("ADistribuirEnPresupuestoDeObra").Value), "NO", oRsStk.Fields("ADistribuirEnPresupuestoDeObra").Value)
                           mvarIdCuentaComprasActivo = IIf(IsNull(oRsStk.Fields("IdCuentaComprasActivo").Value), 0, oRsStk.Fields("IdCuentaComprasActivo").Value)
                        End If
                        oRsStk.Close
                        Set oRsStk = Nothing
                        'If (mvarExigirEquipoDestino = "SI" Or mvarParaMantenimiento = "SI") Then
                        If Not IsNull(.Fields("IdEquipoDestino").Value) Then
                           mvarIdEquipoDestino = IIf(IsNull(.Fields("IdEquipoDestino").Value), 0, .Fields("IdEquipoDestino").Value)
                           Set oRsStk = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorId", _
                                          Array(mvarIdEquipoDestino, origen.Registro.Fields("IdObra").Value))
                           If oRsStk.RecordCount = 0 Then
                              oRsStk.Close
                              Set oRsStk = Nothing
                              Set oRsDet = Nothing
                              MsgBox "Equipo destino inexistente en la obra " & dcfields(0).Text, vbExclamation
                              Exit Sub
                           End If
                           oRsStk.Close
                           Set oRsStk = Nothing
                        End If
                        
                        If Len(mvarBasePRONTOMantenimiento) > 0 And mvarIdTipoRosca = 0 And _
                              IIf(IsNull(.Fields("IdEquipoDestino").Value), 0, .Fields("IdEquipoDestino").Value) <> 0 Then
                           MsgBox "El articulo " & mvarArticulo & " tiene asignado un equipo destino y no tiene familia" & vbCrLf & _
                                 "(La familia contiene los articulos equivalentes en Pronto Mantenimiento" & vbCrLf & _
                                 " para que el sistema genere automaticamente un consumo directo)", vbExclamation
                           Exit Sub
                        End If
                        
                        If mvarRegistrarStock And (mvarAux2 = "SI" Or mvarAux5 = "SI") Then
                           mvarCantidadUnidades = IIf(IsNull(.Fields("Cantidad").Value), 0, .Fields("Cantidad").Value)
                           mvarStock1 = 0
                           mvarStock2 = 0
                           If IIf(IsNull(.Fields("DescargaPorKit").Value), "NO", .Fields("DescargaPorKit").Value) = "NO" Then
                              Set oRsStk = Aplicacion.Articulos.TraerFiltrado("_StockPorArticuloPartidaUnidadUbicacionObra", _
                                           Array(.Fields("IdArticulo").Value, mvarPartida, mvarIdUnidad, mvarIdUbicacion, mvarIdObra))
                              If oRsStk.RecordCount > 0 Then
                                 mvarStock1 = IIf(IsNull(oRsStk.Fields("Stock").Value), 0, oRsStk.Fields("Stock").Value)
                                 mvarArticulo = IIf(IsNull(oRsStk.Fields("Articulo").Value), "", oRsStk.Fields("Articulo").Value)
                              End If
                              oRsStk.Close
                              Set oRsStk = Aplicacion.Articulos.TraerFiltrado("_StockTotalPorArticulo", .Fields("IdArticulo").Value)
                              If oRsStk.RecordCount > 0 Then
                                 mvarStock2 = IIf(IsNull(oRsStk.Fields("Stock").Value), 0, oRsStk.Fields("Stock").Value)
                              End If
                              oRsStk.Close
                              Set oRsStk = Nothing
                              If mvarId < 0 Then
                                 mvarCantidad1 = 0
                                 mvarCantidad2 = 0
                                 ' Verificar si en la misma salida hay articulos repetidos y sumarlos
                                 oRsAux1.MoveFirst
                                 Do While Not oRsAux1.EOF
                                    If oRsAux1.Fields("IdArticulo").Value = .Fields("IdArticulo").Value And _
                                          oRsAux1.Fields(0).Value <> .Fields(0).Value Then
                                       If mvarPartida = IIf(IsNull(oRsAux1.Fields("Partida").Value), "", oRsAux1.Fields("Partida").Value) And _
                                             mvarIdUnidad = IIf(IsNull(oRsAux1.Fields("IdUnidad").Value), 0, oRsAux1.Fields("IdUnidad").Value) And _
                                             mvarIdUbicacion = IIf(IsNull(oRsAux1.Fields("IdUbicacion").Value), 0, oRsAux1.Fields("IdUbicacion").Value) And _
                                             mvarIdObra = IIf(IsNull(oRsAux1.Fields("IdObra").Value), 0, oRsAux1.Fields("IdObra").Value) Then
                                          mvarCantidad1 = mvarCantidad1 + IIf(IsNull(oRsAux1.Fields("Cantidad").Value), 0, oRsAux1.Fields("Cantidad").Value)
                                       End If
                                       mvarCantidad2 = mvarCantidad2 + IIf(IsNull(oRsAux1.Fields("Cantidad").Value), 0, oRsAux1.Fields("Cantidad").Value)
                                    End If
                                    oRsAux1.MoveNext
                                 Loop
                                 If mvarAux2 = "SI" And mvarStock1 < Round(mvarCantidadUnidades + mvarCantidad1, 2) Then
                                    Set oRsDet = Nothing
                                    MsgBox "El articulo " & mvarArticulo & ", tiene" & vbCrLf & _
                                             "stock insuficiente segun datos ingresados :" & vbCrLf & _
                                             "cantidad actual en stock para la partida, unidad, ubicacion y obra : " & mvarStock1 & vbCrLf & _
                                             "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
                                    Exit Sub
                                 End If
                                 If mvarStock2 < Round(mvarCantidadUnidades + mvarCantidad2, 2) Then
                                    Set oRsDet = Nothing
                                    MsgBox "El articulo " & mvarArticulo & ", tiene stock total insuficiente" & vbCrLf & _
                                             "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
                                    Exit Sub
                                 End If
                              Else
                                 Set oRsStk = Aplicacion.TablasGenerales.TraerUno("DetSalidasMateriales", .Fields(0).Value)
                                 mvarStock = 0
                                 If oRsStk.RecordCount > 0 Then
                                    mvarStock = IIf(IsNull(oRsStk.Fields("Cantidad").Value), 0, oRsStk.Fields("Cantidad").Value)
                                 End If
                                 oRsStk.Close
                                 Set oRsStk = Nothing
                                 If mvarAux2 = "SI" And mvarStock1 < Round(mvarCantidadUnidades - mvarStock, 2) Then
                                    Set oRsDet = Nothing
                                    MsgBox "El articulo " & mvarArticulo & ", tiene" & vbCrLf & _
                                             "stock insuficiente segun datos ingresados :" & vbCrLf & _
                                             "cantidad actual en stock para la partida, unidad, ubicacion y obra : " & mvarStock1 & vbCrLf & _
                                             "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
                                    Exit Sub
                                 End If
                                 If mvarStock2 < Round(mvarCantidadUnidades - mvarStock, 2) Then
                                    Set oRsDet = Nothing
                                    MsgBox "El articulo " & mvarArticulo & ", tiene stock total insuficiente" & vbCrLf & _
                                             "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
                                    Exit Sub
                                 End If
                              End If
                           Else
                              Set oRsAux = Aplicacion.Conjuntos.TraerFiltrado("_DetallesPorIdArticulo", .Fields("IdArticulo").Value)
                              If oRsAux.RecordCount > 0 Then
                                 oRsAux.MoveFirst
                                 Do While Not oRsAux.EOF
                                    mvarCantConj = IIf(IsNull(oRsAux.Fields("Cantidad").Value), 0, oRsAux.Fields("Cantidad").Value)
                                    mvarIdUnidad = IIf(IsNull(oRsAux.Fields("IdUnidad").Value), 0, oRsAux.Fields("IdUnidad").Value)
                                    
                                    mvarStock1 = 0
                                    mvarArticulo1 = ""
                                    Set oRsStk = Aplicacion.Articulos.TraerFiltrado("_StockPorArticuloPartidaUnidadUbicacionObra", _
                                                 Array(oRsAux.Fields("IdArticulo").Value, mvarPartida, mvarIdUnidad, mvarIdUbicacion, mvarIdObra))
                                    If oRsStk.RecordCount > 0 Then
                                       mvarStock1 = IIf(IsNull(oRsStk.Fields("Stock").Value), 0, oRsStk.Fields("Stock").Value)
                                       mvarArticulo1 = IIf(IsNull(oRsStk.Fields("Articulo").Value), "", oRsStk.Fields("Articulo").Value)
                                    End If
                                    oRsStk.Close
                                    Set oRsStk = Aplicacion.Articulos.TraerFiltrado("_StockTotalPorArticulo", oRsAux.Fields("IdArticulo").Value)
                                    If oRsStk.RecordCount > 0 Then
                                       mvarStock2 = IIf(IsNull(oRsStk.Fields("Stock").Value), 0, oRsStk.Fields("Stock").Value)
                                    End If
                                    oRsStk.Close
                                    Set oRsStk = Nothing
                                    
                                    If mvarId < 0 Then
                                       If mvarAux5 <> "SI" And mvarStock1 < mvarCantidadUnidades * mvarCantConj Then
                                          Set oRsDet = Nothing
                                          Set oRsAux = Nothing
                                          MsgBox "El articulo " & mvarArticulo1 & vbCrLf & _
                                                   "que es parte del kit " & mvarArticulo & vbCrLf & _
                                                   ", tiene stock insuficiente segun datos ingresados :" & vbCrLf & _
                                                   "cantidad actual en stock para la partida, unidad, ubicacion y obra : " & mvarStock1 & vbCrLf & _
                                                   "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
                                          Exit Sub
                                       End If
                                       If mvarStock2 < mvarCantidadUnidades * mvarCantConj Then
                                          Set oRsDet = Nothing
                                          Set oRsAux = Nothing
                                          MsgBox "El articulo " & mvarArticulo1 & _
                                                   "que es parte del kit " & mvarArticulo & vbCrLf & _
                                                   ", tiene stock insuficiente" & vbCrLf & _
                                                   "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
                                          Exit Sub
                                       End If
                                    Else
                                       Set oRsStk = Aplicacion.TablasGenerales.TraerUno("DetSalidasMateriales", .Fields(0).Value)
                                       mvarStock = 0
                                       If oRsStk.RecordCount > 0 Then
                                          mvarStock = IIf(IsNull(oRsStk.Fields("Cantidad").Value), 0, oRsStk.Fields("Cantidad").Value)
                                       End If
                                       oRsStk.Close
                                       Set oRsStk = Nothing
                                       If mvarAux5 <> "SI" And mvarStock1 < (mvarCantidadUnidades * mvarCantConj) - (mvarStock * mvarCantConj) Then
                                          Set oRsDet = Nothing
                                          Set oRsAux = Nothing
                                          MsgBox "El articulo " & mvarArticulo1 & vbCrLf & _
                                                   "que es parte del kit " & mvarArticulo & vbCrLf & _
                                                   "stock insuficiente segun datos ingresados :" & vbCrLf & _
                                                   "tiene cantidad actual en stock para la partida, unidad, ubicacion y obra : " & mvarStock1 & vbCrLf & _
                                                   "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
                                          Exit Sub
                                       End If
                                       If mvarStock2 < (mvarCantidadUnidades * mvarCantConj) - (mvarStock * mvarCantConj) Then
                                          Set oRsDet = Nothing
                                          Set oRsAux = Nothing
                                          MsgBox "El articulo " & mvarArticulo1 & vbCrLf & _
                                                   "que es parte del kit " & mvarArticulo & vbCrLf & _
                                                   "tiene stock insuficiente, cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
                                          Exit Sub
                                       End If
                                    End If
                                    oRsAux.MoveNext
                                 Loop
                              End If
                              oRsAux.Close
                           End If
                        End If
                        
                        If mvarAux3 = "SI" And Not IsNull(.Fields("IdEquipoDestino").Value) Then
                           Set oRsStk = Aplicacion.SalidasMateriales.TraerFiltrado("_ControlarParteDiarioEquipoDestino", Array(.Fields("IdEquipoDestino").Value, DTFields(0).Value))
                           If oRsStk.RecordCount = 0 Then
                              oRsStk.Close
                              Set oRsStk = Nothing
                              Set oRsDet = Nothing
                              MsgBox "Hay equipo(s) destino que no tienen parte del dia " & DTFields(0).Value - 1 & vbCrLf & "en el Pronto Mantenimiento", vbExclamation
                              Exit Sub
                           End If
                           oRsStk.Close
                        End If
                     
                        If mvarAux4 = "SI" And mTipoSalida = 1 And Not IsNull(.Fields("IdDetalleObraDestino").Value) Then
                           mvarCantidadUnidades = IIf(IsNull(.Fields("Cantidad").Value), 0, .Fields("Cantidad").Value)
                           mvarStock1 = 0
                           mvarStock2 = 0
                           mvarDestino = ""
                           mvarFamilia = ""
                           Set oRsStk = Aplicacion.LMateriales.TraerFiltrado("_CantidadPorDestinoArticulo", _
                                          Array(.Fields("IdDetalleObraDestino").Value, .Fields("IdArticulo").Value, .Fields(0).Value))
                           If oRsStk.RecordCount > 0 Then
                              mvarStock1 = IIf(IsNull(oRsStk.Fields("CantidadLM").Value), 0, oRsStk.Fields("CantidadLM").Value)
                              mvarStock2 = IIf(IsNull(oRsStk.Fields("CantidadSM").Value), 0, oRsStk.Fields("CantidadSM").Value)
                              mvarDestino = IIf(IsNull(oRsStk.Fields("Destino").Value), "", oRsStk.Fields("Destino").Value)
                              mvarFamilia = IIf(IsNull(oRsStk.Fields("Familia").Value), "", oRsStk.Fields("Familia").Value)
                           End If
                           oRsStk.Close
                           Set oRsStk = Nothing
                           If mvarCantidadUnidades + mvarStock2 > mvarStock1 And mvarStock1 <> 0 Then
                              mvarError = mvarError & vbCrLf & "Articulo " & mvarArticulo & " Destino " & mvarDestino & ", " & _
                                          "Lista de materiales : " & mvarStock1 & ", " & _
                                          "Salidas : " & mvarStock2 & ", " & _
                                          "Disponible : " & mvarStock1 - mvarStock2
                              If Len(mvarFamilia) > 0 Then mvarError = mvarError & ", " & "Familia : " & mvarFamilia
                           End If
                        End If
                     
                        'Controlar que la suma de los salido no sea mayor a la cantidad en el item de la orden de produccion apuntada
                        If Not IsNull(.Fields("IdDetalleProduccionOrden").Value) Then
                           Set oRsStk = Aplicacion.TablasGenerales.TraerFiltrado("DetProduccionOrdenes", "_ControlSalidas", Array(.Fields("IdDetalleProduccionOrden").Value, .Fields("IdDetalleSalidaMateriales").Value))
                           If oRsStk.RecordCount > 0 Then
                              If oRsStk.Fields("Cantidad").Value < oRsStk.Fields("Salidas").Value + .Fields("Cantidad").Value Then
                                 mvarError = mvarError & vbCrLf & "Articulo " & mvarArticulo & ", cantidad OP " & oRsStk.Fields("Cantidad").Value & ", salidas " & oRsStk.Fields("Salidas").Value + .Fields("Cantidad").Value
                              End If
                           End If
                           oRsStk.Close
                        End If
                     
                        'Controlar que la suma de los salido no sea mayor a la cantidad en el item del vale de salida produccion apuntado
                        If Not IsNull(.Fields("IdDetalleValeSalida").Value) Then
                           Set oRsStk = Aplicacion.TablasGenerales.TraerFiltrado("DetValesSalida", "_ControlSalidas", Array(.Fields("IdDetalleValeSalida").Value, .Fields("IdDetalleSalidaMateriales").Value))
                           If oRsStk.RecordCount > 0 Then
                              If oRsStk.Fields("Cantidad").Value < oRsStk.Fields("Salidas").Value + .Fields("Cantidad").Value Then
                                 mvarError = mvarError & vbCrLf & "Articulo " & mvarArticulo & ", cantidad vale salida " & oRsStk.Fields("Cantidad").Value & ", salidas " & oRsStk.Fields("Salidas").Value + .Fields("Cantidad").Value
                              End If
                           End If
                           oRsStk.Close
                        End If
                     
                        If mvarRegistroContableComprasAlActivo = "SI" And mvarADistribuirEnPresupuestoDeObra = "SI" And _
                              mvarIdCuentaComprasActivo <> 0 And IsNull(.Fields("IdCuenta").Value) Then
                           mvarError = mvarError & vbCrLf & "Articulo sin cuenta contable : " & mvarArticulo
                        End If
                     
                        If Not IsNull(.Fields("IdDetalleValeSalida").Value) Then
                           Set oRsAux = Aplicacion.TablasGenerales.TraerFiltrado("DetValesSalida", "_TodoMasPendientePorIdDetalle", .Fields("IdDetalleValeSalida").Value)
                           If oRsAux.RecordCount > 0 Then
                              If Not IsNull(oRsAux.Fields("IdOrdenTrabajo").Value) Then
                                 If IsNull(oRsAux.Fields("FechaFinalizacion").Value) Or oRsAux.Fields("FechaFinalizacion").Value > DTFields(0).Value Or _
                                    oRsAux.Fields("IdOrdenTrabajo").Value <> .Fields("IdOrdenTrabajo").Value Then
                                 Else
                                    If Not (Combo1(0).ListIndex = 3 Or Combo1(0).ListIndex = 4) Then
                                       mvarError = mvarError & vbCrLf & "Articulo sin OT : " & mvarArticulo & " (OT original " & oRsAux.Fields("NumeroOrdenTrabajo").Value & ")"
                                    End If
                                 End If
                              End If
                           End If
                           oRsAux.Close
                        End If
                     End If
                     .MoveNext
                  Loop
               End With
            End If
            Set oRsDet = Nothing
            Set oRsAux = Nothing
            Set oRsAux1 = Nothing
            Set oRsStk = Nothing
'         End If
         
         If Len(mvarError) > 0 Then
            MsgBox "Se han detectado los siguientes errores : " & mvarError, vbExclamation
            Exit Sub
         End If
         
         With origen.Registro
            If mTipoSalida > 0 Then
               If Option1.Value Then
                  .Fields("ACargo").Value = "A"
               Else
                  .Fields("ACargo").Value = "P"
               End If
            End If
            .Fields("TipoSalida").Value = Combo1(0).ListIndex
            If Not IsNull(.Fields("IdObra").Value) Then
               .Fields("Cliente").Value = txtCliente.Text
               .Fields("Direccion").Value = txtDireccion.Text
               .Fields("Localidad").Value = txtLocalidad.Text
               .Fields("CodigoPostal").Value = txtCodigoPostal.Text
               .Fields("CondicionIva").Value = txtCondicionIva.Text
               .Fields("Cuit").Value = txtCuit.Text
            ElseIf Not IsNull(.Fields("IdProveedor").Value) Then
               .Fields("Cliente").Value = Null
               .Fields("Direccion").Value = txtDireccion.Text
               .Fields("Localidad").Value = txtLocalidad.Text
               .Fields("CodigoPostal").Value = txtCodigoPostal.Text
               .Fields("CondicionIva").Value = txtCondicionIva.Text
               .Fields("Cuit").Value = txtCuit.Text
            End If
            .Fields("Observaciones").Value = rchObservaciones.Text
            If mvarId < 0 Then
               .Fields("IdUsuarioIngreso").Value = glbIdUsuario
               .Fields("FechaIngreso").Value = Now
            Else
               .Fields("IdUsuarioModifico").Value = glbIdUsuario
               .Fields("FechaModifico").Value = Now
            End If
            .Fields("ClaveTipoSalida").Value = Combo1(0).Text
            If BuscarClaveINI("Activar stock en transito PRONTOSAT") = "SI" Then
               .Fields("SalidaADepositoEnTransito").Value = "SI"
            End If
            If mvarNumerarPorPuntoVenta Then
               .Fields("NumeroSalidaMateriales2").Value = Val(dcfields(10).Text)
            Else
               .Fields("IdPuntoVenta").Value = 0
            End If

         End With
         
         If mvarId < 0 Then
'            Set oPar = Aplicacion.Parametros.Item(1)
'            With oPar.Registro
'               Select Case Combo1(0).ListIndex
'                  Case 0, 2
'                     If .Fields("ProximoNumeroSalidaMateriales").Value = origen.Registro.Fields("NumeroSalidaMateriales").Value Then
'                        .Fields("ProximoNumeroSalidaMateriales").Value = origen.Registro.Fields("NumeroSalidaMateriales").Value + 1
'                     End If
'                  Case 1
'                     If .Fields("ProximoNumeroSalidaMaterialesAObra").Value = origen.Registro.Fields("NumeroSalidaMateriales").Value Then
'                        .Fields("ProximoNumeroSalidaMaterialesAObra").Value = origen.Registro.Fields("NumeroSalidaMateriales").Value + 1
'                     End If
''                  Case 2
''                     If .Fields("ProximoNumeroDevolucionDeFabrica").Value = origen.Registro.Fields("NumeroSalidaMateriales").Value Then
''                        .Fields("ProximoNumeroDevolucionDeFabrica").Value = origen.Registro.Fields("NumeroSalidaMateriales").Value + 1
''                     End If
'               End Select
'            End With
'            oPar.Guardar
'            Set oPar = Nothing
            mvarGrabado = True
         End If
         
         If mvarId < 0 And mvarNumerarPorPuntoVenta Then
            Dim oPto As ComPronto.PuntoVenta
            Set oPto = Aplicacion.PuntosVenta.Item(dcfields(10).BoundText)
            With oPto.Registro
               Select Case mTipoSalida
                  Case 0, 2
                     mvarNumero = .Fields("ProximoNumero").Value
                     .Fields("ProximoNumero").Value = mvarNumero + 1
                  Case 1
                     mvarNumero = IIf(IsNull(.Fields("ProximoNumero1").Value), 1, .Fields("ProximoNumero1").Value)
                     .Fields("ProximoNumero1").Value = mvarNumero + 1
                  Case 3, 4, 5
                     mvarNumero = IIf(IsNull(.Fields("ProximoNumero" & mTipoSalida - 1).Value), 1, .Fields("ProximoNumero" & mTipoSalida - 1).Value)
                     .Fields("ProximoNumero" & mTipoSalida - 1).Value = mvarNumero + 1
               End Select
               origen.Registro.Fields("NumeroSalidaMateriales").Value = mvarNumero
            End With
            oPto.Guardar
            Set oPto = Nothing
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
            
            Set oRsAux = Aplicacion.SalidasMateriales.TraerFiltrado("_PorId", mvarId)
            If oRsAux.RecordCount > 0 Then
               oRsAux.MoveFirst
               If oRsAux.Fields("NumeroSalidaMateriales").Value <> mvarNumeroAnt Then
                  MsgBox "El numero de salida a cambiado," & vbCrLf & _
                           "el numero anterior es el " & Format(mvarNumeroAnt, "00000000") & vbCrLf & _
                           "el nuevo numero asignado es el " & Format(oRsAux.Fields("NumeroSalidaMateriales").Value, "00000000") & ".", vbInformation
               End If
            End If
            oRsAux.Close
            Set oRsAux = Nothing
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "SalidaMaterialesTodas,+SubSA2"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
         
         'If Combo1(0).ListIndex <> 0 Then
         If mvarImpresionHabilitada Then
            mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de solicitud de cotizacion")
            If mvarImprime = vbYes Then cmdImpre_Click (0)
         End If
         'End If
         
         Unload Me

      Case 1
         Unload Me

      Case 2
         Dim oF As frmConsultaValesPendientes
         Set oF = New frmConsultaValesPendientes
         With oF
            .Show vbModal, Me
         End With
         Unload oF
         Set oF = Nothing
         Exit Sub
      
      Case 3
         AnularSalida
   
      Case 4
         ImportarItems
         Exit Sub
   End Select
   
Salida:
   On Error Resume Next
   
   Set oRsDet = Nothing
   Set oRsStk = Nothing
   Set oPar = Nothing
   
   Unload Me
   Exit Sub
   
Mal:
   MsgBox "Se ha producido un problema al tratar de registrar los datos" & vbCrLf & Err.Description, vbCritical
   Resume Salida
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oDet As DetSalidaMateriales
   Dim oRs As ADOR.Recordset
   Dim oRsAut As ADOR.Recordset
   Dim dtf As DTPicker
   Dim ListaVacia As Boolean
   Dim i As Integer, mCantidadFirmas As Integer
   Dim mAuxS1 As String
   Dim mAux1 As Variant
   Dim mVector
   
   mvarId = vnewvalue
   
   ListaVacia = False
   mCadena = ""
   mvarModoCodigoBarra = False
   mvarAnulada = "NO"
   mvarImpresionHabilitada = True
   mvarSoloStockObra = False
   mvarTransportistaConEquipos = False
   mvarNoAnular = False
   
   Set oAp = Aplicacion
   
   Set origen = oAp.SalidasMateriales.Item(vnewvalue)
   
   If glbParametrizacionNivel1 Then
      origen.NivelParametrizacion = 1
      lblcliente.Visible = False
      txtCliente.Visible = False
      lblData(6).Visible = False
      txtCodigoPostal.Visible = False
      txtLocalidad.Visible = False
      lblData(5).Visible = False
      txtDireccion.Visible = False
      lblData(7).Visible = False
      txtCondicionIva.Visible = False
      txtCuit.Visible = False
      lblData(11).Visible = False
      txtReferencia.Visible = False
   End If
   
   Set oRs = oAp.Parametros.Item(1).Registro
   mvarIdMonedaPesos = oRs.Fields("IdMoneda").Value
   mvarIdUnidadCU = oRs.Fields("IdUnidadPorUnidad").Value
   oRs.Close
   
   mAux1 = TraerValorParametro2("IdObraDefault")
   mIdObraDefault = IIf(IsNull(mAux1), 0, mAux1)
   
   mvarIdDepositoCentral = 0
   mAux1 = TraerValorParametro2("IdDepositoCentral")
   If Not IsNull(mAux1) And IsNumeric(mAux1) Then mvarIdDepositoCentral = Val(mAux1)
   
   mDescargaPorKit = BuscarClaveINI("Mover stock por kit")
   If mDescargaPorKit = "" Then mDescargaPorKit = "NO"
         
   mvarExigirEquipoDestino = BuscarClaveINI("Exigir equipo destino en salida de materiales")
   If mvarExigirEquipoDestino = "" Then mvarExigirEquipoDestino = "NO"
   
   If BuscarClaveINI("Requerir deposito origen en salida de materiales") = "SI" Then
      lblData(14).Visible = True
      dcfields(14).Visible = True
   End If
   
   mAuxS1 = BuscarClaveINI("Opciones adicionales para salida de materiales")
   If Len(mAuxS1) > 0 Then
      mVector = VBA.Split(mAuxS1, ",")
      For i = 0 To UBound(mVector)
         Combo1(0).AddItem mVector(i), i + 3
      Next
   End If
   
   If BuscarClaveINI("Inhabilitar impresion de SA") = "SI" Then mvarImpresionHabilitada = False
   
   If BuscarClaveINI("Mostrar solo stock de obra en salidas") = "SI" Then mvarSoloStockObra = True
   
   If BuscarClaveINI("Numerar salida de materiales por puntos de venta") = "SI" Then
      mvarNumerarPorPuntoVenta = True
      txtNumeroSalidaMateriales2.Visible = False
      dcfields(10).Visible = True
   Else
      mvarNumerarPorPuntoVenta = False
      txtNumeroSalidaMateriales2.Visible = True
      dcfields(10).Visible = False
   End If
   
   If BuscarClaveINI("Mostrar datos adicionales en recepcion") = "SI" Then
      With lblData(8)
         .Top = lblData(3).Top
         .Left = lblData(3).Left
         .Visible = True
      End With
      lblData(3).Visible = False
      With txtCodigoEquipo
         .Top = dcfields(3).Top
         .Left = dcfields(3).Left
         .Visible = True
      End With
      With dcfields(8)
         .Top = txtCodigoEquipo.Top
         .Left = txtCodigoEquipo.Left + txtCodigoEquipo.Width
         .Width = dcfields(3).Width - txtCodigoEquipo.Width
         .Visible = True
      End With
      dcfields(3).Visible = False
   End If
   
   mvarFormatCodBar = 1
   mAuxS1 = BuscarClaveINI("Modelo de registro de codigo de barras")
   If Len(mAuxS1) > 0 And IsNumeric(mAuxS1) Then mvarFormatCodBar = Val(mAuxS1)
   
   If BuscarClaveINI("Habilitar importacion de items en salida de materiales") = "SI" Then cmd(4).Visible = True
   
   mAux1 = TraerValorParametro2("RegistroContableComprasAlActivo")
   mvarRegistroContableComprasAlActivo = IIf(IsNull(mAux1), "NO", mAux1)

   origen.MostrarSoloStockDeObra = mvarSoloStockObra
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetSalidasMateriales.TraerMascara
                     ListaVacia = True
                  Else
                     If mvarSoloStockObra And Not IsNull(origen.Registro.Fields("IdObra").Value) Then
                        Set oRs = oAp.TablasGenerales.TraerFiltrado("DetSalidasMateriales", "Sal", Array(mvarId, origen.Registro.Fields("IdObra").Value))
                     Else
                        Set oRs = origen.DetSalidasMateriales.TraerTodos
                     End If
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           Set oDet = origen.DetSalidasMateriales.Item(oRs.Fields(0).Value)
                           oDet.Modificado = True
                           Set oDet = Nothing
                           oRs.MoveNext
                        Loop
                        ListaVacia = False
                     Else
                        Set oControl.DataSource = origen.DetSalidasMateriales.TraerMascara
                        ListaVacia = True
                     End If
                     oRs.Close
                  End If
            End Select
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Obras" Then
                  If glbSeñal1 Then
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", Date))
                  Else
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo")
                  End If
               ElseIf oControl.Tag = "PuntosVenta" Then
                  Set oControl.RowSource = oAp.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(50, "X"))
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
   
   Check1(0).Visible = True
   
   If mvarId = -1 Then
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      Option2.Value = True
      With origen.Registro
         .Fields("Emitio").Value = glbIdUsuario
         .Fields("IdObra").Value = mIdObraDefault
         If mIdObraDefault <> 0 And BuscarClaveINI("Usar obra por defecto para salida de materiales") <> "SI" Then
            dcfields(0).Enabled = False
         Else
            dcfields(0).Enabled = True
         End If
      End With
      mvarGrabado = False
      mIdAprobo = 0
      cmd(3).Enabled = False
   Else
      With origen.Registro
         If Not IsNull(.Fields("Anulada").Value) And .Fields("Anulada").Value = "SI" Then
            With lblEstado1
               .Caption = "ANULADA"
               .Visible = True
            End With
            mvarAnulada = "SI"
         End If
         If Not IsNull(.Fields("TipoSalida").Value) Then
            mTipoSalida = .Fields("TipoSalida").Value
            Combo1(0).ListIndex = mTipoSalida
         Else
            mTipoSalida = 0
         End If
         Combo1(0).Enabled = False
         If Not IsNull(.Fields("Aprobo").Value) Then
            Check1(0).Value = 1
            mIdAprobo = .Fields("Aprobo").Value
         Else
            dcfields(1).Enabled = True
         End If
         If Not IsNull(.Fields("Acargo").Value) Then
            If .Fields("Acargo").Value = "A" Then
               Option1.Value = True
            Else
               Option2.Value = True
            End If
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
         txtCliente.Text = IIf(IsNull(.Fields("Cliente").Value), "", .Fields("Cliente").Value)
         txtDireccion.Text = IIf(IsNull(.Fields("Direccion").Value), "", .Fields("Direccion").Value)
         txtLocalidad.Text = IIf(IsNull(.Fields("Localidad").Value), "", .Fields("Localidad").Value)
         txtCodigoPostal.Text = IIf(IsNull(.Fields("CodigoPostal").Value), "", .Fields("CodigoPostal").Value)
         txtCondicionIva.Text = IIf(IsNull(.Fields("CondicionIva").Value), "", .Fields("CondicionIva").Value)
         txtCuit.Text = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
         If Not IsNull(.Fields("IdProduccionOrden").Value) Then
            Set oRs = oAp.TablasGenerales.TraerUno("ProduccionOrdenes", .Fields("IdProduccionOrden").Value)
            If oRs.RecordCount > 0 Then txtNumeroOP.Text = oRs.Fields("NumeroOrdenProduccion").Value
            oRs.Close
         End If
      End With
      mCantidadFirmas = 0
      Set oRsAut = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(EnumFormularios.SalidaMateriales, 0))
      If oRsAut.RecordCount > 0 Then
         oRsAut.MoveFirst
         Do While Not oRsAut.EOF
            mCantidadFirmas = mCantidadFirmas + 1
            Check1(mCantidadFirmas).Visible = True
            Check1(mCantidadFirmas).Tag = oRsAut.Fields(0).Value
            oRsAut.MoveNext
         Loop
      End If
      oRsAut.Close
      Set oRsAut = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(EnumFormularios.SalidaMateriales, mvarId))
      If oRsAut.RecordCount > 0 Then
         oRsAut.MoveFirst
         Do While Not oRsAut.EOF
            For i = 1 To mCantidadFirmas
               If Check1(i).Tag = oRsAut.Fields("OrdenAutorizacion").Value Then
                  Check1(i).Value = 1
                  Exit For
               End If
            Next
            oRsAut.MoveNext
         Loop
      End If
      oRsAut.Close
      Set oRsAut = Nothing
      mvarGrabado = True
      txtNumeroOP.Enabled = False
   End If
   
   If ListaVacia Then Lista.ListItems.Clear
   
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
   End If
   
   If mvarAnulada = "SI" Then
      cmd(0).Enabled = False
      cmd(2).Enabled = False
      cmd(3).Enabled = False
   End If
   
   If mvarId > 0 And mvarRegistroContableComprasAlActivo = "SI" Then
      cmd(0).Enabled = False
      If DTFields(0).Value <= gblFechaUltimoCierre And Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
         cmd(3).Enabled = False
      End If
   End If
   
   If Not mvarImpresionHabilitada Then
      cmdImpre(0).Enabled = False
      cmdImpre(1).Enabled = False
   End If
   
   Set oRs = Nothing
   Set oDet = Nothing
   Set oAp = Nothing
   MostrarTotales
   
End Property

Private Sub cmdImpre_Click(Index As Integer)

   If Not mvarGrabado Then
      MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
      Exit Sub
   End If
   
   Dim mvarOK As Boolean
   Dim mCopias As Integer
   
   If Index = 0 Then
      Dim oF As frmCopiasImpresion
      Set oF = New frmCopiasImpresion
      With oF
         If Index <> 0 Then
            .Frame1.Visible = False
         End If
         .Show vbModal, Me
         mvarOK = .Ok
         mCopias = Val(.txtCopias.Text)
      End With
      Unload oF
      Set oF = Nothing
      If Not mvarOK Then
         Exit Sub
      End If
   Else
      mCopias = 1
   End If

   Dim oW As Word.Application
   Dim mPlanilla As String, mPID As String
   
   If mTipoSalida = 1 Then
      mPlanilla = BuscarClaveINI("Plantilla para salida de materiales a obra")
      If Len(Trim(mPlanilla)) = 0 Then mPlanilla = "SalidaMateriales"
   Else
      mPlanilla = "SalidaMateriales"
   End If
   
   If Index = 0 Then CargaProcesosEnEjecucion
   Set oW = CreateObject("Word.Application")
   If Index = 0 Then mPID = ObtenerPIDProcesosLanzados
   
   oW.Visible = True
   oW.Documents.Add (glbPathPlantillas & "\" & mPlanilla & "_" & glbEmpresaSegunString & ".dot")
   oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId
   oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
   oW.Application.Run MacroName:="DatosDelPie"
   If Index = 0 Then
      oW.ActiveDocument.PrintOut False, , , , , , , mCopias
      oW.ActiveDocument.Close False
      If glbTerminarProcesosOffice Then
         TerminarProceso mPID
      Else
         oW.Quit
      End If
   End If

Salida:
   Set oW = Nothing
   Exit Sub

Mal:
   If Index = 0 Then oW.Quit
   Me.MousePointer = vbDefault
   MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical
   Resume Salida

End Sub

Private Sub Combo1_Click(Index As Integer)

   If Index = 0 Then
      Dim oPar As ComPronto.Parametro
      Dim oRs As ADOR.Recordset
      If mvarId = -1 Then
         If Not mvarNumerarPorPuntoVenta Then
            Set oPar = Aplicacion.Parametros.Item(1)
            With origen.Registro
               Select Case Combo1(0).ListIndex
                  Case 0, 2
                     .Fields("NumeroSalidaMateriales").Value = oPar.Registro.Fields("ProximoNumeroSalidaMateriales").Value
                     .Fields("NumeroSalidaMateriales2").Value = oPar.Registro.Fields("ProximoNumeroSalidaMateriales2").Value
                  Case 1
                     .Fields("NumeroSalidaMateriales").Value = oPar.Registro.Fields("ProximoNumeroSalidaMaterialesAObra").Value
                     .Fields("NumeroSalidaMateriales2").Value = oPar.Registro.Fields("ProximoNumeroSalidaMaterialesAObra2").Value
   '               Case 2
   '                  .Fields("NumeroSalidaMateriales").Value = oPar.Registro.Fields("ProximoNumeroDevolucionDeFabrica").Value
   '                  .Fields("NumeroSalidaMateriales2").Value = oPar.Registro.Fields("ProximoNumeroDevolucionDeFabrica2").Value
                  Case Else
                     Set oRs = Aplicacion.Parametros.TraerFiltrado("_Parametros2BuscarClave", Combo1(0).Text & "_2")
                     If oRs.RecordCount > 0 Then
                        .Fields("NumeroSalidaMateriales").Value = IIf(IsNull(oRs.Fields("Valor").Value), 1, Val(oRs.Fields("Valor").Value))
                     Else
                        .Fields("NumeroSalidaMateriales").Value = 1
                     End If
                     oRs.Close
                     Set oRs = Aplicacion.Parametros.TraerFiltrado("_Parametros2BuscarClave", Combo1(0).Text & "_1")
                     If oRs.RecordCount > 0 Then
                        .Fields("NumeroSalidaMateriales2").Value = IIf(IsNull(oRs.Fields("Valor").Value), 1, Val(oRs.Fields("Valor").Value))
                     Else
                        .Fields("NumeroSalidaMateriales2").Value = 1
                     End If
                     oRs.Close
               End Select
            End With
            Set oRs = Nothing
            Set oPar = Nothing
         End If
'         DTFields(0).Enabled = True
         dcfields(0).Enabled = True
         Check2.Enabled = True
         Check2.Value = 1
         Check3.Enabled = True
         dcfields(1).Enabled = True
         dcfields(4).Enabled = True
         dcfields(14).Enabled = True
         rchObservaciones.Locked = False
'         txtNumeroSalidaMateriales.Enabled = True
'         txtNumeroSalidaMateriales2.Enabled = True
         txtValePreimpreso.Enabled = True
         txtReferencia.Enabled = True
         If Combo1(0).ListIndex <> 0 Then
            dcfields(2).Enabled = True
            dcfields(3).Enabled = True
            If dcfields(8).Visible Then dcfields(8).Enabled = True
            dcfields(9).Enabled = True
            dcfields(11).Enabled = True
            If Combo1(0).ListIndex = 2 Then
               dcfields(5).Enabled = True
'               dcfields(0).Enabled = False
'               Check2.Value = 0
'               Check2.Enabled = False
               Check3.Enabled = False
            End If
            txtPatente1.Enabled = True
            txtPatente2.Enabled = True
            txtPatente3.Enabled = True
            txtPatente4.Enabled = True
            txtChofer.Enabled = True
            txtNumeroDocumento.Enabled = True
            txtCliente.Enabled = True
            txtDireccion.Enabled = True
            txtLocalidad.Enabled = True
            txtCodigoPostal.Enabled = True
            txtCondicionIva.Enabled = True
            txtCuit.Enabled = True
            cmdImpre(0).Enabled = True
            cmdImpre(1).Enabled = True
            Frame1.Enabled = True
         End If
         Combo1(0).Enabled = False
         mTipoSalida = Combo1(0).ListIndex
      Else
         If Combo1(0).ListIndex <> 0 Then
            cmdImpre(0).Enabled = True
            cmdImpre(1).Enabled = True
         End If
         With origen.Registro
            If Not IsNull(.Fields("IdObra").Value) Then
               Check2.Value = 1
            ElseIf Not IsNull(.Fields("IdCentroCosto").Value) Then
               Check3.Value = 1
            End If
         End With
      End If
      If glbIdObraAsignadaUsuario <> -1 Then
         With origen.Registro
            .Fields("IdObra").Value = glbIdObraAsignadaUsuario
            .Fields("Emitio").Value = glbIdUsuario
            .Fields("Aprobo").Value = glbIdUsuario
         End With
         Check2.Value = 1
         Check2.Enabled = False
         dcfields(0).Enabled = False
         dcfields(1).Enabled = False
         dcfields(4).Enabled = False
      End If
      If mIdObraDefault <> 0 Then dcfields(0).Enabled = False
      If Lista.Visible Then Lista.SetFocus
   End If
   
End Sub

Private Sub dcfields_Change(Index As Integer)

   If Not IsNumeric(dcfields(Index).BoundText) Then Exit Sub
   
   Dim oRs As ADOR.Recordset
   
   Select Case Index
      Case 2
         Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorIdTransportista", dcfields(Index).BoundText)
         mvarTransportistaConEquipos = False
         If oRs.RecordCount > 0 Then mvarTransportistaConEquipos = True
         Set dcfields(8).RowSource = oRs
      Case 5
'         Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", dcfields(Index).BoundText)
'         If oRs.RecordCount > 0 Then
'            If Not IsNull(oRs.Fields("IdTransportista").Value) Then
'               origen.Registro.Fields("IdTransportista1").Value = oRs.Fields("IdTransportista").Value
'               dcfields(2).Enabled = False
'               Set dcfields(8).RowSource = Aplicacion.Articulos.TraerFiltrado("_PorIdTransportista", oRs.Fields("IdTransportista").Value)
'            End If
'         End If
'         oRs.Close
      Case 8
         Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", dcfields(Index).BoundText)
         If oRs.RecordCount > 0 Then
            If Not IsNull(oRs.Fields("NumeroPatente").Value) Then
               origen.Registro.Fields("Patente1").Value = oRs.Fields("NumeroPatente").Value
               If Len(txtPatente1.Text) > 0 Then txtPatente1.Enabled = False
            End If
            txtCodigoEquipo.Text = IIf(IsNull(oRs.Fields("NumeroInventario").Value), "", oRs.Fields("NumeroInventario").Value)
         End If
         oRs.Close
      Case 9
         Set oRs = Aplicacion.TablasGenerales.TraerUno("Fletes", dcfields(Index).BoundText)
         If oRs.RecordCount > 0 Then
            If Not IsNull(oRs.Fields("Patente").Value) Then
               origen.Registro.Fields("Patente1").Value = IIf(IsNull(oRs.Fields("Patente").Value), "", oRs.Fields("Patente").Value)
            End If
         End If
         oRs.Close
      Case 10
         If mvarId <= 0 And mvarNumerarPorPuntoVenta Then
            Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(Index).BoundText)
            If oRs.RecordCount > 0 Then
               origen.Registro.Fields("NumeroSalidaMateriales").Value = oRs.Fields("ProximoNumero").Value
               Select Case mTipoSalida
                  Case 0, 2
                     txtNumeroSalidaMateriales.Text = IIf(IsNull(oRs.Fields("ProximoNumero").Value), 1, oRs.Fields("ProximoNumero").Value)
                  Case 1
                     txtNumeroSalidaMateriales.Text = IIf(IsNull(oRs.Fields("ProximoNumero1").Value), 1, oRs.Fields("ProximoNumero1").Value)
                  Case 3, 4, 5
                     txtNumeroSalidaMateriales.Text = IIf(IsNull(oRs.Fields("ProximoNumero" & mTipoSalida - 1).Value), 1, oRs.Fields("ProximoNumero" & mTipoSalida - 1).Value)
               End Select
            End If
            oRs.Close
         End If
      Case 11
         Set oRs = Aplicacion.TablasGenerales.TraerUno("Choferes", dcfields(Index).BoundText)
         If oRs.RecordCount > 0 Then
               With origen.Registro
                  .Fields("Chofer").Value = IIf(IsNull(oRs.Fields("Nombre").Value), "", oRs.Fields("Nombre").Value)
                  .Fields("NumeroDocumento").Value = IIf(IsNull(oRs.Fields("NumeroDocumento").Value), "", oRs.Fields("NumeroDocumento").Value)
               End With
         End If
         oRs.Close
   End Select
   Set oRs = Nothing

End Sub

Private Sub dcfields_GotFocus(Index As Integer)
   
   If Index <> 1 Then
      If dcfields(Index).Enabled Then
         SendKeys "%{DOWN}"
      Else
         SendKeys "{TAB}"
      End If
   End If

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   If Not IsNumeric(dcfields(Index).BoundText) Then Exit Sub
   
   Select Case Index
      Case 0
         origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
      Case 1 And Me.Visible
         If dcfields(Index).BoundText <> mIdAprobo Then PideAutorizacion
   End Select
   
End Sub

Private Sub dcfields_Validate(Index As Integer, Cancel As Boolean)

   Dim oRsObra As ADOR.Recordset
   Dim oRsCliente As ADOR.Recordset
   Dim oRsProv As ADOR.Recordset
   
   If IsNumeric(dcfields(Index).BoundText) Then
      origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
      If Not IsNumeric(dcfields(Index).BoundText) Then Exit Sub
      Select Case Index
         Case 0
            Set oRsObra = Aplicacion.Obras.Item(dcfields(Index).BoundText).Registro
            If oRsObra.RecordCount > 0 Then
               If Not IsNull(oRsObra.Fields("IdCliente").Value) Then
                  Set oRsCliente = Aplicacion.Clientes.TraerFiltrado("_TT", oRsObra.Fields("IdCliente").Value)
                  With oRsCliente
                     If .RecordCount > 0 Then
                        lblcliente.Caption = "Cliente : "
                        If Not IsNull(.Fields("Razon Social").Value) Then
                           txtCliente.Text = .Fields("Razon Social").Value
                        Else
                           txtCliente.Text = ""
                        End If
                        If mvarId <= 0 Then
                           If Not IsNull(.Fields("Direccion de entrega").Value) Then
                              txtDireccion.Text = .Fields("Direccion de entrega").Value
                           ElseIf Not IsNull(.Fields("Direccion").Value) Then
                              txtDireccion.Text = .Fields("Direccion").Value
                           Else
                              txtDireccion.Text = ""
                           End If
                           If Not IsNull(.Fields("Localidad (entrega)").Value) Then
                              txtLocalidad.Text = .Fields("Localidad (entrega)").Value
                              txtCodigoPostal.Text = ""
                           ElseIf Not IsNull(.Fields("Localidad").Value) Then
                              txtLocalidad.Text = .Fields("Localidad").Value
                              If Not IsNull(.Fields("CodigoPostal").Value) Then
                                 txtCodigoPostal.Text = .Fields("CodigoPostal").Value
                              Else
                                 txtCodigoPostal.Text = ""
                              End If
                           Else
                              txtLocalidad.Text = ""
                              txtCodigoPostal.Text = ""
                           End If
                           If Not IsNull(.Fields("Provincia (entrega)").Value) Then
                              txtLocalidad.Text = txtLocalidad.Text & " - " & .Fields("Provincia (entrega)").Value
                           ElseIf Not IsNull(.Fields("Provincia").Value) Then
                              txtLocalidad.Text = txtLocalidad.Text & " - " & .Fields("Provincia").Value
                           End If
                           txtCondicionIva.Text = IIf(IsNull(.Fields("Condicion IVA").Value), "", .Fields("Condicion IVA").Value)
                           txtCuit.Text = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
                        End If
                     End If
                     oRsCliente.Close
                  End With
                  With origen.Registro
                     .Fields("IdProveedor").Value = Null
                  End With
               End If
            End If
            oRsObra.Close
         Case 5
            Set oRsProv = Aplicacion.Proveedores.TraerFiltrado("_TT", dcfields(Index).BoundText)
            With oRsProv
               If oRsProv.RecordCount > 0 Then
                  lblcliente.Caption = "Proveedor : "
                  If Not IsNull(.Fields("Razon social").Value) Then
                     txtCliente.Text = .Fields("Razon social").Value
                  Else
                     txtCliente.Text = ""
                  End If
                  If mvarId <= 0 Then
                     If Not IsNull(.Fields("Direccion").Value) Then
                        txtDireccion.Text = .Fields("Direccion").Value
                     Else
                        txtDireccion.Text = ""
                     End If
                     If Not IsNull(.Fields("Localidad").Value) Then
                        txtLocalidad.Text = .Fields("Localidad").Value
                     Else
                        txtLocalidad.Text = ""
                     End If
                     If Not IsNull(.Fields("Cod.postal").Value) Then
                        txtCodigoPostal.Text = .Fields("Cod.postal").Value
                     Else
                        txtCodigoPostal.Text = ""
                     End If
                     If Not IsNull(.Fields("Provincia").Value) Then
                        txtLocalidad.Text = txtLocalidad.Text & " - " & .Fields("Provincia").Value
                     End If
                     txtCondicionIva.Text = IIf(IsNull(.Fields("Condicion IVA").Value), "", .Fields("Condicion IVA").Value)
                     txtCuit.Text = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
                  End If
               End If
               .Close
            End With
'            With origen.Registro
'               .Fields("IdObra").Value = Null
'               Check2.Value = 0
'            End With
         Case 6
            txtCliente.Text = ""
            txtDireccion.Text = ""
            txtLocalidad.Text = ""
            txtCodigoPostal.Text = ""
            txtCondicionIva.Text = ""
            txtCuit.Text = ""
         Case 14
            dcfields(Index).Enabled = False
      End Select
   Else
      dcfields(Index).Text = ""
   End If
   
   Set oRsObra = Nothing
   Set oRsCliente = Nothing
   Set oRsProv = Nothing

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   If Not mvarModoCodigoBarra Then Exit Sub
   
   If KeyAscii <> 13 Then
      mCadena = mCadena & Chr(KeyAscii)
      KeyAscii = 0
   ElseIf KeyAscii = 13 Then
      ProcesarCodigoBarras mCadena
      mCadena = ""
   ElseIf KeyAscii = 27 Then
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
   ElseIf KeyCode = 27 And mvarModoCodigoBarra Then
      mCadena = ""
      mvarModoCodigoBarra = False
      lblEstado.Visible = False
      Set Lista.DataSource = origen.DetSalidasMateriales.RegistrosConFormato
      MostrarTotales
      DoEvents
   End If

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   For Each oI In Img16.ListImages
      With Estado.Panels.Add(, , oI.Key)
         .Picture = oI.Picture
      End With
   Next

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single)

   If mvarId > 0 Then
      MsgBox "No puede modificar una salida ya registrada!", vbCritical
      Exit Sub
   End If
      
   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long, j As Long, mvarIdDeposito As Long, mvarIdUbicacion As Long
   Dim mCostoATomar As String, mNumeroInventario As String
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oVal As ComPronto.ValeSalida
   Dim oRsVal As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim oRsAux1 As ADOR.Recordset

   mvarIdDeposito = 0
   If dcfields(14).Visible Then
      If Not IsNumeric(dcfields(14).BoundText) Then
         MsgBox "Indique primero el origen!", vbCritical
         Exit Sub
      Else
         mvarIdDeposito = dcfields(14).BoundText
         mvarIdUbicacion = 0
         Set oRsAux = Aplicacion.Ubicaciones.TraerFiltrado("_PorObra", Array(-1, mvarIdDeposito))
         If oRsAux.RecordCount = 1 Then mvarIdUbicacion = oRsAux.Fields(0).Value
         oRsAux.Close
      End If
   End If
   
   If Data.GetFormat(ccCFText) Then
      s = Data.GetData(ccCFText)
      Filas = Split(s, vbCrLf)
      
      Columnas = Split(Filas(0), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      mCostoATomar = BuscarClaveINI("Costo para salida de materiales")
      If mCostoATomar = "" Then mCostoATomar = "CostoReposicion"
      
      If Columnas(1) = "Vale" Then
         For iFilas = 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
         
            Set oRsAux = Aplicacion.ValesSalida.TraerFiltrado("_PorId", Columnas(4))
            Set oRsVal = Aplicacion.TablasGenerales.TraerFiltrado("DetValesSalida", "Res", Columnas(4))
                  
            With origen.Registro
               If mIdObraDefault = 0 Then .Fields("IdObra").Value = oRsAux.Fields("IdObra").Value
               .Fields("ValePreimpreso").Value = oRsAux.Fields("NumeroValePreimpreso").Value
            End With
            
            If oRsVal.RecordCount > 0 Then
               oRsVal.MoveFirst
               Do While Not oRsVal.EOF
                  If (IsNull(oRsVal.Fields("Cumplido").Value) Or oRsVal.Fields("Cumplido").Value <> "SI") And _
                        (IsNull(oRsVal.Fields("Estado").Value) Or oRsVal.Fields("Estado").Value <> "AN") Then
                     Set oRsDet = Aplicacion.TablasGenerales.TraerFiltrado("DetValesSalida", "_TodoMasPendientePorIdDetalle", oRsVal.Fields(0).Value)
                              
                     With origen.DetSalidasMateriales.Item(-1)
                        For i = 2 To oRsDet.Fields.Count - 1
                           For j = 2 To .Registro.Fields.Count - 1
                              If .Registro.Fields(j).Name = oRsDet.Fields(i).Name Then
                                 .Registro.Fields(j).Value = oRsDet.Fields(i).Value
                                 Exit For
                              End If
                           Next
                        Next
                        With .Registro
                           .Fields("IdDetalleValeSalida").Value = oRsDet.Fields("IdDetalleValeSalida").Value
                           .Fields("Partida").Value = ""
                           If mIdObraDefault = 0 Then .Fields("IdObra").Value = oRsAux.Fields("IdObra").Value
                           .Fields("Cantidad").Value = oRsDet.Fields("Pendiente").Value
                           .Fields("Adjunto").Value = "NO"
                           If mvarIdDepositoCentral = mvarIdDeposito Or mvarIdDeposito = 0 Then
                              .Fields("IdUbicacion").Value = oRsDet.Fields("IdUbicacionStandar").Value
                           Else
                              If mvarIdUbicacion <> 0 Then .Fields("IdUbicacion").Value = mvarIdUbicacion
                           End If
                           .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                           .Fields("CotizacionMoneda").Value = 1
                           .Fields("IdMoneda").Value = mvarIdMonedaPesos
                           .Fields("Observaciones").Value = oRsDet.Fields("ObservacionesRequerimiento").Value
                           Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorIdConDatos", oRsDet.Fields("IdArticulo").Value)
                           mNumeroInventario = ""
                           If oRsAux1.RecordCount > 0 Then
                              If Right(IIf(IsNull(oRsAux1.Fields("Codigo").Value), "0000", oRsAux1.Fields("Codigo").Value), 4) = "9999" Then
                                 .Fields("CostoUnitario").Value = oRsDet.Fields("CostoRecepcion").Value
                                 .Fields("IdMoneda").Value = oRsDet.Fields("IdMonedaRecepcion").Value
                                 .Fields("CotizacionMoneda").Value = Cotizacion(Date, oRsDet.Fields("IdMonedaRecepcion").Value)
                              Else
                                 If mCostoATomar = "CostoReposicion" Then
                                    .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoReposicion").Value
                                 Else
                                    .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoPPP").Value
                                 End If
                              End If
                              If oRsAux1.Fields("ConKit").Value = "SI" Then .Fields("DescargaPorKit").Value = "SI"
                              
                              If mvarRegistroContableComprasAlActivo = "SI" And _
                                    IIf(IsNull(oRsAux1.Fields("ADistribuirEnPresupuestoDeObra").Value), "NO", oRsAux1.Fields("ADistribuirEnPresupuestoDeObra").Value) = "SI" And _
                                    IIf(IsNull(oRsAux1.Fields("IdCuentaComprasActivo").Value), 0, oRsAux1.Fields("IdCuentaComprasActivo").Value) <> 0 Then
                                 If Not IsNull(oRsAux1.Fields("IdCuentaCompras").Value) And Not IsNull(origen.Registro.Fields("IdObra").Value) Then
                                    oRsAux1.Close
                                    Set oRsAux1 = Aplicacion.Cuentas.TraerFiltrado("_PorObraCuentaMadre", Array(origen.Registro.Fields("IdObra").Value, 0, oRsDet.Fields("IdArticulo").Value))
                                    If oRsAux1.RecordCount > 0 Then
                                       .Fields("IdCuenta").Value = oRsAux1.Fields("IdCuenta").Value
                                    End If
                                 End If
                              End If
                              
                              If Not IsNull(oRsDet.Fields("IdEquipoDestino").Value) Then
                                 oRsAux1.Close
                                 Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdEquipoDestino").Value)
                                 If oRsAux1.RecordCount > 0 Then
                                    mNumeroInventario = IIf(IsNull(oRsAux1.Fields("NumeroInventario").Value), "", oRsAux1.Fields("NumeroInventario").Value)
                                 End If
                              End If
                           End If
                           oRsAux1.Close
                           If Len(mNumeroInventario) > 0 Then
                              Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorNumeroInventario", mNumeroInventario)
                              If oRsAux1.RecordCount > 0 Then
                                 .Fields("IdEquipoDestino").Value = oRsAux1.Fields(0).Value
                              End If
                              oRsAux1.Close
                           End If
                        End With
                        .Modificado = True
                     End With
                     oRsDet.Close
                  End If
                  oRsVal.MoveNext
               Loop
            End If
            oRsAux.Close
         Next
         Set Lista.DataSource = origen.DetSalidasMateriales.RegistrosConFormato
         
      ElseIf Columnas(1) = "Vale (Det.)" Then
         For iFilas = 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            
            Set oRsAux = Aplicacion.ValesSalida.TraerFiltrado("_PorId", Columnas(8))
            Set oRsVal = Aplicacion.TablasGenerales.TraerUno("DetValesSalida", CLng(Columnas(12)))
            
            With origen.Registro
               If mIdObraDefault = 0 Then .Fields("IdObra").Value = oRsAux.Fields("IdObra").Value
               .Fields("ValePreimpreso").Value = oRsAux.Fields("NumeroValePreimpreso").Value
            End With
            
            Do While Not oRsVal.EOF
               Set oRsDet = Aplicacion.TablasGenerales.TraerFiltrado("DetValesSalida", "_TodoMasPendientePorIdDetalle", oRsVal.Fields(0).Value)
               With origen.DetSalidasMateriales.Item(-1)
                  For i = 2 To oRsDet.Fields.Count - 1
                     For j = 2 To .Registro.Fields.Count - 1
                        If .Registro.Fields(j).Name = oRsDet.Fields(i).Name Then
                           .Registro.Fields(j).Value = oRsDet.Fields(i).Value
                           Exit For
                        End If
                     Next
                  Next
                  With .Registro
                     .Fields("IdDetalleValeSalida").Value = oRsDet.Fields("IdDetalleValeSalida").Value
                     .Fields("Partida").Value = ""
                     If mIdObraDefault = 0 Then .Fields("IdObra").Value = oRsAux.Fields("IdObra").Value
                     .Fields("Cantidad").Value = oRsDet.Fields("Pendiente").Value
                     .Fields("Adjunto").Value = "NO"
                     If mvarIdDepositoCentral = mvarIdDeposito Or mvarIdDeposito = 0 Then
                        .Fields("IdUbicacion").Value = oRsDet.Fields("IdUbicacionStandar").Value
                     Else
                        If mvarIdUbicacion <> 0 Then .Fields("IdUbicacion").Value = mvarIdUbicacion
                     End If
                     .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                     .Fields("CotizacionMoneda").Value = 1
                     .Fields("IdMoneda").Value = mvarIdMonedaPesos
                     .Fields("Observaciones").Value = oRsDet.Fields("ObservacionesRequerimiento").Value
                     Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorIdConDatos", oRsDet.Fields("IdArticulo").Value)
                     mNumeroInventario = ""
                     If oRsAux1.RecordCount > 0 Then
                        If Right(IIf(IsNull(oRsAux1.Fields("Codigo").Value), "0000", oRsAux1.Fields("Codigo").Value), 4) = "9999" Then
                           .Fields("CostoUnitario").Value = oRsDet.Fields("CostoRecepcion").Value
                           .Fields("IdMoneda").Value = oRsDet.Fields("IdMonedaRecepcion").Value
                           .Fields("CotizacionMoneda").Value = Cotizacion(Date, oRsDet.Fields("IdMonedaRecepcion").Value)
                        Else
                           If mCostoATomar = "CostoReposicion" Then
                              .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoReposicion").Value
                           Else
                              .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoPPP").Value
                           End If
                        End If
                        If oRsAux1.Fields("ConKit").Value = "SI" Then .Fields("DescargaPorKit").Value = "SI"
                        
                        If mvarRegistroContableComprasAlActivo = "SI" And _
                              IIf(IsNull(oRsAux1.Fields("ADistribuirEnPresupuestoDeObra").Value), "NO", oRsAux1.Fields("ADistribuirEnPresupuestoDeObra").Value) = "SI" And _
                              IIf(IsNull(oRsAux1.Fields("IdCuentaComprasActivo").Value), 0, oRsAux1.Fields("IdCuentaComprasActivo").Value) <> 0 Then
                           If Not IsNull(oRsAux1.Fields("IdCuentaCompras").Value) And Not IsNull(origen.Registro.Fields("IdObra").Value) Then
                              oRsAux1.Close
                              Set oRsAux1 = Aplicacion.Cuentas.TraerFiltrado("_PorObraCuentaMadre", Array(origen.Registro.Fields("IdObra").Value, 0, oRsDet.Fields("IdArticulo").Value))
                              If oRsAux1.RecordCount > 0 Then
                                 .Fields("IdCuenta").Value = oRsAux1.Fields("IdCuenta").Value
                              End If
                           End If
                        End If
                              
                        If Not IsNull(oRsDet.Fields("IdEquipoDestino").Value) Then
                           oRsAux1.Close
                           Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdEquipoDestino").Value)
                           If oRsAux1.RecordCount > 0 Then
                              mNumeroInventario = IIf(IsNull(oRsAux1.Fields("NumeroInventario").Value), "", oRsAux1.Fields("NumeroInventario").Value)
                           End If
                        End If
                     End If
                     oRsAux1.Close
                     If Len(mNumeroInventario) > 0 Then
                        Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorNumeroInventario", mNumeroInventario)
                        If oRsAux1.RecordCount > 0 Then
                           .Fields("IdEquipoDestino").Value = oRsAux1.Fields(0).Value
                        End If
                        oRsAux1.Close
                     End If
                  End With
                  .Modificado = True
               End With
               oRsDet.Close
               oRsVal.MoveNext
            Loop
            oRsAux.Close
         Next
         Set Lista.DataSource = origen.DetSalidasMateriales.RegistrosConFormato
         
      ElseIf Columnas(1) = "Codigo material" Then
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            Columnas = VBA.Split(Filas(iFilas), vbTab)
            With origen.DetSalidasMateriales.Item(-1)
               With .Registro
                  .Fields("IdArticulo").Value = Columnas(3)
                  .Fields("IdUnidad").Value = mvarIdUnidadCU
                  .Fields("Partida").Value = ""
                  .Fields("IdObra").Value = origen.Registro.Fields("IdObra").Value
                  .Fields("Cantidad").Value = 1
                  .Fields("Adjunto").Value = "NO"
                  .Fields("IdUbicacion").Value = 1
                  .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                  .Fields("CotizacionMoneda").Value = 1
                  .Fields("IdMoneda").Value = mvarIdMonedaPesos
                  Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorIdConDatos", Columnas(3))
                  If oRsAux1.RecordCount > 0 Then
                     If mCostoATomar = "CostoReposicion" Then
                        .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoReposicion").Value
                     Else
                        .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoPPP").Value
                     End If
                     If oRsAux1.Fields("ConKit").Value = "SI" Then .Fields("DescargaPorKit").Value = "SI"
                  End If
                  oRsAux1.Close
               End With
               .Modificado = True
            End With
         Next
         
         Set Lista.DataSource = origen.DetSalidasMateriales.RegistrosConFormato
         
      ElseIf Columnas(1) = "Nro.recep.alm." Then
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            Columnas = VBA.Split(Filas(iFilas), vbTab)
            
            Set oRsAux1 = Aplicacion.Recepciones.TraerFiltrado("_PorId", Columnas(12))
            If oRsAux1.RecordCount > 0 Then
               rchObservaciones.TextRTF = IIf(IsNull(oRsAux1.Fields("Observaciones").Value), "", oRsAux1.Fields("Observaciones").Value)
            End If
            oRsAux1.Close
            
            Set oRsDet = Aplicacion.TablasGenerales.TraerFiltrado("Recepciones", "_DetallesPorIdRecepcion", Columnas(12))
            If oRsDet.RecordCount > 0 Then
               oRsDet.MoveFirst
               Do While Not oRsDet.EOF
                  With origen.DetSalidasMateriales.Item(-1)
                     With .Registro
                        .Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                        .Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                        .Fields("Partida").Value = oRsDet.Fields("Partida").Value
                        .Fields("IdObra").Value = origen.Registro.Fields("IdObra").Value
                        .Fields("Cantidad").Value = oRsDet.Fields("Cantidad").Value
                        .Fields("Adjunto").Value = "NO"
                        .Fields("IdUbicacion").Value = oRsDet.Fields("IdUbicacion").Value
                        .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                        .Fields("CotizacionMoneda").Value = 1
                        .Fields("IdMoneda").Value = mvarIdMonedaPesos
                        .Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
                        Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorIdConDatos", oRsDet.Fields("IdArticulo").Value)
                        If oRsAux1.RecordCount > 0 Then
                           If Right(IIf(IsNull(oRsAux1.Fields("Codigo").Value), "0000", oRsAux1.Fields("Codigo").Value), 4) = "9999" Then
                              .Fields("CostoUnitario").Value = oRsDet.Fields("CostoUnitario").Value
                           Else
                              If mCostoATomar = "CostoReposicion" Then
                                 .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoReposicion").Value
                              Else
                                 .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoPPP").Value
                              End If
                           End If
                           If oRsAux1.Fields("ConKit").Value = "SI" Then .Fields("DescargaPorKit").Value = "SI"
                           If mvarRegistroContableComprasAlActivo = "SI" And _
                                 IIf(IsNull(oRsAux1.Fields("ADistribuirEnPresupuestoDeObra").Value), "NO", oRsAux1.Fields("ADistribuirEnPresupuestoDeObra").Value) = "SI" And _
                                 IIf(IsNull(oRsAux1.Fields("IdCuentaComprasActivo").Value), 0, oRsAux1.Fields("IdCuentaComprasActivo").Value) <> 0 Then
                              If Not IsNull(oRsAux1.Fields("IdCuentaCompras").Value) And Not IsNull(origen.Registro.Fields("IdObra").Value) Then
                                 oRsAux1.Close
                                 Set oRsAux1 = Aplicacion.Cuentas.TraerFiltrado("_PorObraCuentaMadre", Array(origen.Registro.Fields("IdObra").Value, 0, oRsDet.Fields("IdArticulo").Value))
                                 If oRsAux1.RecordCount > 0 Then
                                    .Fields("IdCuenta").Value = oRsAux1.Fields("IdCuenta").Value
                                 End If
                              End If
                           End If
                        End If
                        oRsAux1.Close
                        If Not IsNull(oRsDet.Fields("IdDetalleRequerimiento").Value) Then
                           Set oRsAux1 = Aplicacion.Requerimientos.TraerFiltrado("_DatosRequerimiento", oRsDet.Fields("IdDetalleRequerimiento").Value)
                           If oRsAux1.RecordCount > 0 Then
                              .Fields("IdOrdenTrabajo").Value = oRsAux1.Fields("IdOrdenTrabajo").Value
                           End If
                           oRsAux1.Close
                        End If
                     End With
                     .Modificado = True
                  End With
                  oRsDet.MoveNext
               Loop
            End If
            oRsDet.Close
         Next
         
         Set Lista.DataSource = origen.DetSalidasMateriales.RegistrosConFormato
         
      Else
         MsgBox "Informacion invalida!", vbCritical
      End If
      
      Set oRsDet = Nothing
      Set oRsVal = Nothing
      Set oRsAux = Nothing
      Set oRsAux1 = Nothing
      Set oVal = Nothing
      Set oAp = Nothing
            
      MostrarTotales
   End If

End Sub

Private Sub Form_OLEDragOver(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single, State As Integer)

   Dim s As String
   Dim Filas, Columnas
   Dim iFilas As Long, iColumnas As Long
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
   
   If mvarModoCodigoBarra Then Exit Sub
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

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         If Not Lista.SelectedItem Is Nothing Then Editar Lista.SelectedItem.Tag
      Case 2
         If mvarId > 0 Then
            MsgBox "No puede modificar un vale ya registrado!", vbCritical
            Exit Sub
         End If
         With Lista.SelectedItem
            origen.DetSalidasMateriales.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         mvarNoAnular = True
      Case 3
         AsignarDetalles
      Case 4
         IngresoManualCajas
   End Select
   
   MostrarTotales

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

Private Sub txtChofer_GotFocus()

   With txtChofer
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtChofer_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCliente_GotFocus()

   With txtCliente
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCliente_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCodigoEquipo_GotFocus()

   With txtCodigoEquipo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoEquipo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCodigoEquipo_Validate(Cancel As Boolean)

   If IsNumeric(dcfields(2).BoundText) Then
      If Len(txtCodigoEquipo.Text) <> 0 Then
         Dim oRs As ADOR.Recordset
         Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorNumeroInventarioIdTransportista", _
                     Array(txtCodigoEquipo.Text, dcfields(2).BoundText))
         If oRs.RecordCount > 0 Then
            origen.Registro.Fields("IdEquipo").Value = oRs.Fields(0).Value
         Else
            MsgBox "Codigo de equipo incorrecto", vbExclamation
            Cancel = True
            txtCodigoEquipo.Text = ""
         End If
         oRs.Close
         Set oRs = Nothing
      End If
   Else
      MsgBox "Debe ingresar el transportista", vbExclamation
      Cancel = True
      txtCodigoEquipo.Text = ""
   End If
   
End Sub

Private Sub txtCodigoPostal_GotFocus()

   With txtCodigoPostal
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoPostal_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCondicionIva_GotFocus()

   With txtCondicionIva
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCondicionIva_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCuit_GotFocus()

   With txtCuit
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCuit_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtDestinoDeObra_GotFocus()

   With txtDestinoDeObra
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDestinoDeObra_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDestinoDeObra
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtDireccion_GotFocus()

   With txtDireccion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDireccion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDireccion
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtEmbalo_GotFocus()

   With txtEmbalo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtEmbalo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtEmbalo
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtLocalidad_GotFocus()

   With txtLocalidad
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtLocalidad_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtLocalidad
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtNumeroDocumento_GotFocus()

   With txtNumeroDocumento
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroDocumento_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtNumeroOP_GotFocus()

   With txtNumeroOP
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroOP_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroOP_Validate(Cancel As Boolean)

   If Len(txtNumeroOP.Text) > 0 And IsNumeric(txtNumeroOP.Text) Then
      Dim oF As frm_Aux
      Dim oRs As ADOR.Recordset
      Dim mSeguro As Integer
      Dim mIdProduccionOrden As Long, mIdUbicacionDestino As Long, mIdObra As Long
      Dim mOk As Boolean
      
      mIdProduccionOrden = 0
      Set oRs = Aplicacion.ProduccionOrdenes.TraerFiltrado("_PorNumeroOrdenProduccion", txtNumeroOP.Text)
      If oRs.RecordCount > 0 Then mIdProduccionOrden = oRs.Fields("IdProduccionOrden").Value
      oRs.Close
      
      If mIdProduccionOrden = 0 Then
         MsgBox "No existe esta OP", vbExclamation
         Cancel = True
         Set oRs = Nothing
         Exit Sub
      End If
            
      mSeguro = MsgBox("Desea cargar registros desde la OP?", vbYesNo, "Carga de items de OP")
      If mSeguro = vbNo Then
         txtNumeroOP.Text = ""
         Exit Sub
      End If
      
      Set oF = New frm_Aux
      With oF
         .Caption = "Asignacion de ubicacion destino"
         .Text1.Visible = False
         .Label1.Caption = "Ubicacion :"
         With .dcfields(0)
            .Top = oF.Text1.Top
            .Left = oF.Text1.Left
            .Width = .Width * 2
            .BoundColumn = "IdUbicacion"
            Set .RowSource = Aplicacion.Ubicaciones.TraerFiltrado("_AbreviadoParaCombo")
            .Visible = True
         End With
         .Width = .Width * 1.3
         .Show vbModal, Me
         mOk = .Ok
         mIdUbicacionDestino = 0
         If IsNumeric(.dcfields(0).BoundText) Then mIdUbicacionDestino = .dcfields(0).BoundText
      End With
      Unload oF
      Set oF = Nothing
      If Not mOk Then
         txtNumeroOP.Text = ""
         Exit Sub
      End If
      If mIdUbicacionDestino = 0 Then
         MsgBox "No eligio la ubicacion destino", vbExclamation
         txtNumeroOP.Text = ""
         Exit Sub
      End If
   
      mIdObra = 0
      Set oRs = Aplicacion.Ubicaciones.TraerFiltrado("_PorId", mIdUbicacionDestino)
      If oRs.RecordCount > 0 Then mIdObra = IIf(IsNull(oRs.Fields("IdObra").Value), 0, oRs.Fields("IdObra").Value)
      oRs.Close
      
      Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetProduccionOrdenes", "_PorIdConDatos", mIdProduccionOrden)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdProduccionOrden").Value = mIdProduccionOrden
         Do While Not oRs.EOF
            If oRs.Fields("Cantidad").Value - oRs.Fields("Salidas").Value > 0 Then
               With origen.DetSalidasMateriales.Item(-1)
                  With .Registro
                     .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                     '.Fields("Partida").Value = oRs.Fields("Partida").Value
                     .Fields("Cantidad").Value = oRs.Fields("Cantidad").Value - oRs.Fields("Salidas").Value
                     .Fields("CantidadAdicional").Value = oRs.Fields("CantidadAdicional").Value
                     .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     .Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
                     .Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
                     .Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
                     '.Fields("IdObra").Value = mIdObra
                     .Fields("IdMoneda").Value = glbIdMonedaPesos
                     .Fields("CotizacionMoneda").Value = 1
                     .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                     .Fields("CostoUnitario").Value = oRs.Fields("CostoReposicion").Value
                     .Fields("IdUbicacionDestino").Value = mIdUbicacionDestino
                     .Fields("Adjunto").Value = "NO"
                     .Fields("IdDetalleProduccionOrden").Value = oRs.Fields("IdDetalleProduccionOrden").Value
                  End With
                  .Modificado = True
               End With
            End If
            oRs.MoveNext
         Loop
      End If
      oRs.Close
      Set oRs = Nothing
      
      Set Lista.DataSource = origen.DetSalidasMateriales.RegistrosConFormato
   End If

End Sub

Private Sub txtNumeroRemitoTransporte_GotFocus()

   With txtNumeroRemitoTransporte
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroRemitoTransporte_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtNumeroRemitoTransporte
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtNumeroSalidaMateriales_GotFocus()

   With txtNumeroSalidaMateriales
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroSalidaMateriales_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtNumeroSalidaMateriales2_GotFocus()

   With txtNumeroSalidaMateriales2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroSalidaMateriales2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub PideAutorizacion()

   Dim oF As frmAutorizacion1
   Set oF = New frmAutorizacion1
   With oF
      .IdUsuario = dcfields(1).BoundText
      .Show vbModal, Me
   End With
   If Not oF.Ok Then
      With origen.Registro
         .Fields(dcfields(1).DataField).Value = Null
'         .Fields("FechaAprobacion").Value = Null
      End With
      Check1(0).Value = 0
      mIdAprobo = 0
   Else
      With origen.Registro
'         .Fields("FechaAprobacion").Value = Now
         mIdAprobo = IIf(IsNull(.Fields("Aprobo").Value), 0, .Fields("Aprobo").Value)
      End With
      Check1(0).Value = 1
   End If
   Unload oF
   Set oF = Nothing

End Sub

Private Sub txtPatente1_GotFocus()

   With txtPatente1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPatente1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtPatente1
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtPatente2_GotFocus()

   With txtPatente2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPatente2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtPatente2
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtPatente3_GotFocus()

   With txtPatente3
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPatente3_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtPatente3
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtPatente4_GotFocus()

   With txtPatente4
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPatente4_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtPatente4
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtReferencia_GotFocus()

   With txtReferencia
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtReferencia_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Public Sub AnularSalida()

   If mvarNoAnular Then
      MsgBox "Para anular una salida, no debe realizar ninguna operacion con los items" & vbCrLf & _
            "previamente a la anulacion, vuelva a llamar la salida y anule directamente", vbInformation
      Exit Sub
   End If
   
   Dim oF As frmAutorizacion
   Dim mOk As Boolean
   Dim mUsuario As String
   Dim mIdAutorizaAnulacion As Integer
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.SalidaMateriales
      '.Administradores = True
      .Show vbModal, Me
      mOk = .Ok
      mIdAutorizaAnulacion = .IdAutorizo
      mUsuario = .Autorizo
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then Exit Sub
   Me.Refresh
   
   Dim oRs As ADOR.Recordset
   Dim mError As String
   
   mError = ""
   Set oRs = Aplicacion.SalidasMateriales.TraerFiltrado("_RecepcionesPorIdSalidaMateriales", mvarId)
   With oRs
      If .RecordCount > 0 Then
         Do While Not .EOF
            mError = mError & vbCrLf & .Fields("Recepcion").Value & " del " & .Fields("Fecha").Value
            .MoveNext
         Loop
      End If
      .Close
   End With
   Set oRs = Nothing
   If Len(mError) > 0 Then
      MsgBox "No se puede anular la salida porque las siguientes recepciones hacen referencia a el :" & mError, vbExclamation
      Exit Sub
   End If
   
   Dim mSeguro As Integer
   mSeguro = MsgBox("Esta seguro de anular la salida?", vbYesNo, "Anulacion de salida")
   If mSeguro = vbNo Then Exit Sub

   Dim oF1 As frmAnulacion
   Dim mMotivoAnulacion As String
   Set oF1 = New frmAnulacion
   With oF1
      .Caption = "Motivo de anulacion de la salida"
      .Text1.Text = "Usuario : " & mUsuario & " - [" & Now & "]"
      .Show vbModal, Me
      mOk = .Ok
   End With
   mMotivoAnulacion = oF1.rchAnulacion.Text
   Unload oF1
   Set oF1 = Nothing
   If Not mOk Then
      MsgBox "Anulacion cancelada!", vbExclamation
      Exit Sub
   End If
   Me.Refresh
   
   With origen
      .Registro.Fields("Anulada").Value = "SI"
      .Registro.Fields("IdUsuarioAnulo").Value = mIdAutorizaAnulacion
      .Registro.Fields("FechaAnulacion").Value = Now
      .Registro.Fields("MotivoAnulacion").Value = mMotivoAnulacion
      .Guardar
   End With

   Aplicacion.Tarea "SalidasMateriales_AjustarStockSalidaMaterialesAnulada", mvarId
   
   With actL2
      .ListaEditada = "SalidaMaterialesTodas"
      .AccionRegistro = Modificacion
      .Disparador = origen.Registro.Fields(0).Value
   End With
   
   Unload Me

End Sub

Public Sub AsignarDetalles()

   Dim iFilas As Integer
   Dim mIdUbicacion As Long, mIdEquipoDestino As Long, mIdOrdenTrabajo As Long, mIdDetalleObraDestino As Long
   Dim mOk As Boolean
   Dim Filas, Columnas
   Dim oF As frm_Aux
   Dim oDet As DetSalidaMateriales
   Dim oRs As ADOR.Recordset
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Asignacion de EQ, OT y UB"
      .Text1.Visible = False
      With .Label2(0)
         .Caption = "Ubicacion :"
         .Visible = True
      End With
      With .dcfields(0)
         .Top = oF.DTFields(0).Top
         .Left = oF.DTFields(0).Left
         .Width = oF.DTFields(0).Width * 2
         .BoundColumn = "IdUbicacion"
         Set .RowSource = Aplicacion.Ubicaciones.TraerLista
         .Visible = True
      End With
      With .Label1
         .Caption = "Equipo destino :"
         .Visible = True
      End With
      With .dcfields(1)
         .Top = oF.Text1.Top
         .Left = oF.Text1.Left
         .Width = oF.DTFields(0).Width * 2
         .BoundColumn = "IdArticulo"
         If IsNumeric(dcfields(0).BoundText) Then
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_ParaMantenimiento_ParaCombo", Array(0, dcfields(0).BoundText))
            If oRs.RecordCount = 0 Then
               Set oRs = Aplicacion.Articulos.TraerFiltrado("_ParaMantenimiento_ParaCombo", Array(0, 0))
            End If
         End If
         Set .RowSource = oRs
         Set oRs = Nothing
         .Visible = True
      End With
      With .Label2(1)
         .Caption = "Ord.Trabajo :"
         .Visible = True
      End With
      With .dcfields(2)
         .Top = oF.DTFields(1).Top
         .Left = oF.DTFields(1).Left
         .Width = oF.DTFields(0).Width * 2
         .BoundColumn = "IdOrdenTrabajo"
         Set .RowSource = Aplicacion.OrdenesTrabajo.TraerLista
         .Visible = True
      End With
      .Width = .Width * 1.5
      .Show vbModal, Me
      mOk = .Ok
      mIdUbicacion = 0
      If IsNumeric(.dcfields(0).BoundText) Then mIdUbicacion = .dcfields(0).BoundText
      mIdEquipoDestino = 0
      If IsNumeric(.dcfields(1).BoundText) Then mIdEquipoDestino = .dcfields(1).BoundText
      mIdDetalleObraDestino = 0
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorIdConDatos", mIdEquipoDestino)
      If oRs.RecordCount > 0 Then
         mIdDetalleObraDestino = IIf(IsNull(oRs.Fields("IdDetalleObraDestino").Value), 0, oRs.Fields("IdDetalleObraDestino").Value)
      End If
      oRs.Close
      mIdOrdenTrabajo = 0
      If IsNumeric(.dcfields(2).BoundText) Then mIdOrdenTrabajo = .dcfields(2).BoundText
   End With
   Unload oF
   Set oF = Nothing
   
   If Not mOk Then Exit Sub
   
   Me.MousePointer = vbHourglass
   DoEvents
   
   Filas = VBA.Split(Lista.GetString, vbCrLf)
   For iFilas = LBound(Filas) + 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(iFilas), vbTab)
      Set oDet = origen.DetSalidasMateriales.Item(Columnas(0))
      With oDet
         With .Registro
            If mIdUbicacion > 0 Then .Fields("IdUbicacion").Value = mIdUbicacion
            If mIdEquipoDestino > 0 Then .Fields("IdEquipoDestino").Value = mIdEquipoDestino
            If mIdOrdenTrabajo > 0 Then .Fields("IdOrdenTrabajo").Value = mIdOrdenTrabajo
            If mIdDetalleObraDestino > 0 Then .Fields("IdDetalleObraDestino").Value = mIdDetalleObraDestino
         End With
         .Modificado = True
      End With
      Set oDet = Nothing
   Next
   Set Lista.DataSource = origen.DetSalidasMateriales.RegistrosConFormato

   Me.MousePointer = vbDefault
   DoEvents

End Sub

Public Sub ProcesarCodigoBarras(ByVal mCodigoBarras As String)

   Dim oRs As ADOR.Recordset
   Dim mCodArt As String, mPartida As String, mError As String
   Dim mPeso As Double
   Dim mIdDetalle As Long, mNumeroCaja As Long, mIdUbicacion As Long, mIdArticulo As Long
   Dim oL As ListItem
   
   mError = ""
   
   Select Case mvarFormatCodBar
      Case 1
         If Len(mCodigoBarras) > 0 And Len(mCodigoBarras) <= 20 Then
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", mCodigoBarras)
            If oRs.RecordCount > 0 Then
               With origen.DetSalidasMateriales.Item(-1)
                  With .Registro
                     .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                     .Fields("IdObra").Value = origen.Registro.Fields("IdObra").Value
                     .Fields("Partida").Value = ""
                     .Fields("Cantidad").Value = 1
                     If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                        .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     Else
                        .Fields("IdUnidad").Value = mvarIdUnidadCU
                     End If
                     If IsNumeric(dcfields(0).BoundText) Then
                        .Fields("IdObra").Value = dcfields(0).BoundText
                     End If
                     .Fields("Adjunto").Value = "NO"
                     .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacionStandar").Value
                     .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                     .Fields("CotizacionMoneda").Value = 1
                     .Fields("IdMoneda").Value = mvarIdMonedaPesos
                     .Fields("CostoUnitario").Value = oRs.Fields("CostoPPP").Value
                  End With
                  .Modificado = True
               End With
               Set Lista.DataSource = origen.DetSalidasMateriales.RegistrosConFormato
            End If
            oRs.Close
         End If
      
      Case 2
         If Len(mCodigoBarras) > 0 And Len(mCodigoBarras) <= 35 Then
            mNumeroCaja = 0
            mIdUbicacion = 0
            mIdArticulo = 0
            mPeso = 0
            
            If Len(mCodigoBarras) = 10 Then
               mCodArt = ""
               mPartida = ""
               mNumeroCaja = Val(mCodigoBarras)
               Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorNumeroCaja", mNumeroCaja)
               If oRs.RecordCount > 0 Then
                  mPeso = IIf(IsNull(oRs.Fields("CantidadUnidades").Value), 0, oRs.Fields("CantidadUnidades").Value)
                  mIdUbicacion = IIf(IsNull(oRs.Fields("IdUbicacion").Value), 0, oRs.Fields("IdUbicacion").Value)
                  mIdArticulo = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
                  mPartida = IIf(IsNull(oRs.Fields("Partida").Value), "", oRs.Fields("Partida").Value)
               End If
               oRs.Close
               If glbUsarPartidasParaStock Then
                  If Not origen.DetSalidasMateriales.ControlCajas(mNumeroCaja, -1) Then
                     mError = mError & mNumeroCaja & ","
                     GoTo Salida
                  End If
               End If
            Else
               If mId(mCodigoBarras, 27, 1) = "C" Then
                  mCodArt = Trim(mId(mCodigoBarras, 1, 20))
                  mPartida = Trim(mId(mCodigoBarras, 21, 6))
                  mNumeroCaja = mId(mCodigoBarras, 28, 7)
                  Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorNumeroCaja", mNumeroCaja)
                  If oRs.RecordCount > 0 Then
                     mPeso = IIf(IsNull(oRs.Fields("CantidadUnidades").Value), 0, oRs.Fields("CantidadUnidades").Value)
                     mIdUbicacion = IIf(IsNull(oRs.Fields("IdUbicacion").Value), 0, oRs.Fields("IdUbicacion").Value)
                     mIdArticulo = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
                  End If
                  oRs.Close
                  If glbUsarPartidasParaStock Then
                     If Not origen.DetSalidasMateriales.ControlCajas(mNumeroCaja, -1) Then
                        mError = mError & mNumeroCaja & ","
                        GoTo Salida
                     End If
                  End If
               Else
                  mPeso = CDbl(mId(mCodigoBarras, 28, 7)) / 100
               End If
            End If
            
            If mIdArticulo > 0 Then
               Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", mIdArticulo)
            Else
               Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", mCodArt)
            End If
            If oRs.RecordCount > 0 Then
               With origen.DetSalidasMateriales.Item(-1)
                  With .Registro
                     .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                     .Fields("Partida").Value = mPartida
                     .Fields("Cantidad").Value = mPeso
                     If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                        .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     Else
                        .Fields("IdUnidad").Value = mvarIdUnidadCU
                     End If
                     If IsNumeric(dcfields(0).BoundText) Then
                        .Fields("IdObra").Value = dcfields(0).BoundText
                     Else
                        .Fields("IdObra").Value = origen.Registro.Fields("IdObra").Value
                     End If
                     .Fields("Adjunto").Value = "NO"
                     If mIdUbicacion > 0 Then
                        .Fields("IdUbicacion").Value = mIdUbicacion
                     Else
                        .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacionStandar").Value
                     End If
                     .Fields("NumeroCaja").Value = mNumeroCaja
                     .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                     .Fields("CotizacionMoneda").Value = 1
                     .Fields("IdMoneda").Value = mvarIdMonedaPesos
                     .Fields("CostoUnitario").Value = oRs.Fields("CostoPPP").Value
                  End With
                  .Modificado = True
                  mIdDetalle = .Id
               End With
            
               Set oL = Lista.ListItems.Add
               oL.Tag = mIdDetalle
               With oL
                  .SmallIcon = "Nuevo"
                  .SubItems(1) = mCodArt
                  .SubItems(2) = oRs.Fields("Descripcion").Value
                  .SubItems(3) = "" & mPartida
                  .SubItems(4) = "" & mPeso
                  '.SubItems(5) = "" & Aplicacion.StockPorIdArticulo(oF.DataCombo1(1).BoundText)
                  '.SubItems(8) = "" & oF.DataCombo1(0).Text
                  '.SubItems(9) = "" & oF.DataCombo1(2).Text
                  '.SubItems(10) = "" & oF.DataCombo1(3).Text
               End With
            End If
            oRs.Close
         End If
   
   End Select

Salida:
   
   Set oRs = Nothing
   
   MostrarTotales

End Sub

Public Sub IngresoManualCajas()

   Dim oF As frm_Aux
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim mOk As Boolean
   Dim mCajas As String, mCodArt As String, mPartida As String, mArticulo As String, mUnidad As String
   Dim mUbicacion As String, mObra As String, mColor As String, mError As String
   Dim i As Integer
   Dim mNumeroCaja As Long, mIdUbicacion As Long, mIdDetalle As Long, mIdArticulo As Long, mIdUnidad As Long
   Dim mIdObra As Long
   Dim mPeso As Double
   Dim mVector
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Ingreso manual de cajas"
      .Text1.Visible = False
      .Label1.Caption = "Lista de cajas :"
      With .RichTextBox1
         .Left = oF.Text1.Left
         .Top = oF.Text1.Top
         .Width = oF.Text1.Width
         .Height = oF.Text1.Height * 15
         .Text = ""
         .Visible = True
         .TabIndex = 0
      End With
      .Height = .Height * 2.5
      .Width = .Width * 1
      .cmd(0).Top = .cmd(0).Top * 3.5
      .cmd(1).Top = .cmd(1).Top * 3.5
      .Show vbModal, Me
      mOk = .Ok
      mCajas = .RichTextBox1.Text
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then Exit Sub
   
   mError = ""
   mVector = VBA.Split(mCajas, vbCrLf)
   For i = 0 To UBound(mVector)
      If Len(mVector(i)) > 0 And IsNumeric(mVector(i)) Then
         mNumeroCaja = Val(mVector(i))
         
         If glbUsarPartidasParaStock Then
            If Not origen.DetSalidasMateriales.ControlCajas(mNumeroCaja, -1) Then
               mError = mError & mNumeroCaja & ","
               GoTo Proximo
            End If
         End If
         
         Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorNumeroCaja", mNumeroCaja)
         If oRs.RecordCount > 0 Then
            mPeso = IIf(IsNull(oRs.Fields("CantidadUnidades").Value), 0, oRs.Fields("CantidadUnidades").Value)
            mIdUbicacion = IIf(IsNull(oRs.Fields("IdUbicacion").Value), 0, oRs.Fields("IdUbicacion").Value)
            mCodArt = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
            mPartida = IIf(IsNull(oRs.Fields("Partida").Value), "", oRs.Fields("Partida").Value)
            mIdArticulo = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
            mIdUnidad = IIf(IsNull(oRs.Fields("IdUnidad").Value), 0, oRs.Fields("IdUnidad").Value)
            mIdObra = IIf(IsNull(oRs.Fields("IdObra").Value), 0, oRs.Fields("IdObra").Value)
            mArticulo = IIf(IsNull(oRs.Fields("Articulo").Value), "", oRs.Fields("Articulo").Value)
            mUnidad = IIf(IsNull(oRs.Fields("Un").Value), "", oRs.Fields("Un").Value)
            mUbicacion = IIf(IsNull(oRs.Fields("Ubicacion").Value), "", oRs.Fields("Ubicacion").Value)
            mObra = IIf(IsNull(oRs.Fields("Obra").Value), "", oRs.Fields("Obra").Value)
            mColor = IIf(IsNull(oRs.Fields("Color").Value), "", oRs.Fields("Color").Value)
            
            With origen.DetSalidasMateriales.Item(-1)
               With .Registro
                  .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                  .Fields("Partida").Value = mPartida
                  .Fields("Cantidad").Value = mPeso
                  If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                     .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                  Else
                     .Fields("IdUnidad").Value = mvarIdUnidadCU
                  End If
                  If IsNumeric(dcfields(0).BoundText) Then
                     .Fields("IdObra").Value = dcfields(0).BoundText
                  Else
                     .Fields("IdObra").Value = origen.Registro.Fields("IdObra").Value
                  End If
                  .Fields("Adjunto").Value = "NO"
                  .Fields("IdUbicacion").Value = mIdUbicacion
                  .Fields("NumeroCaja").Value = mNumeroCaja
                  .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                  .Fields("CotizacionMoneda").Value = 1
                  .Fields("IdMoneda").Value = mvarIdMonedaPesos
                  .Fields("CostoUnitario").Value = oRs.Fields("CostoPPP").Value
               End With
               .Modificado = True
               mIdDetalle = .Id
            End With
            
            Set oL = Lista.ListItems.Add
            oL.Tag = mIdDetalle
            With oL
               .SmallIcon = "Nuevo"
               .SubItems(1) = mCodArt
               .SubItems(2) = mArticulo & "  " & mColor
               .SubItems(3) = "" & mPartida
               .SubItems(4) = "" & mPeso
               '.SubItems(5) = "" & Aplicacion.StockPorIdArticulo(oF.DataCombo1(1).BoundText)
               '.SubItems(8) = "" & oF.DataCombo1(0).Text
               '.SubItems(9) = "" & oF.DataCombo1(2).Text
               '.SubItems(10) = "" & oF.DataCombo1(3).Text
            End With
         End If
         oRs.Close
      End If
Proximo:
   Next
   
   If Len(mError) > 0 Then
      mError = mId(mError, 1, Len(mError) - 1)
      MsgBox "Las siguientes cajas ya estaban ingresadas y no fueron tomadas : " & vbCrLf & mError, vbCritical
   End If

Salida:
   Set oRs = Nothing
   MostrarTotales
   
End Sub

Public Sub MostrarTotales()

   Estado.Panels(1).Text = " " & origen.DetSalidasMateriales.CantidadRegistros & " Items"

End Sub

Public Sub ImportarItems()

   If IIf(IsNull(origen.Registro.Fields("IdObra").Value), 0, origen.Registro.Fields("IdObra").Value) = 0 Then
      MsgBox "Debe definir primero la obra", vbExclamation
      Exit Sub
   End If
   
   Dim oEx As Excel.Application
   Dim oRsAux As ADOR.Recordset
   Dim oRsErrores As ADOR.Recordset
   Dim oF As Form
   Dim mArchivo As String, mCodigoMaterial As String, mMaterial As String, mEquipoDestino As String, mOrdenTrabajo As String, mBasePRONTOMantenimiento As String
   Dim fl As Integer, mContador As Integer
   Dim mIdUnidad As Long, mIdArticulo As Long, mIdUbicacion As Long, mIdEquipoDestino As Long, mIdOrdenTrabajo As Long
   Dim mCantidad As Double, mCosto As Double
   Dim mOk As Boolean, mConProblemas As Boolean
   
   On Error GoTo Mal

   Set oF = New frmPathPresto
   With oF
      .Id = 21
      .Show vbModal
      mOk = .Ok
      If mOk Then mArchivo = .FileBrowser1(0).Text
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then Exit Sub

   Set oRsErrores = CreateObject("ADOR.Recordset")
   With oRsErrores
      .Fields.Append "Id", adInteger
      .Fields.Append "Detalle", adVarChar, 200
   End With
   oRsErrores.Open
   
   Set oRsAux = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   With oRsAux
      mBasePRONTOMantenimiento = IIf(IsNull(.Fields("BasePRONTOMantenimiento").Value), "", .Fields("BasePRONTOMantenimiento").Value)
      .Close
   End With
   
   Set oF = New frmAviso
   With oF
      .Label1 = "Abriendo planilla Excel ..."
      .Show
      .Refresh
      DoEvents
   End With

   oF.Label1 = oF.Label1 & vbCrLf & "Procesando items de salida de materiales ..."
   oF.Label2 = ""
   oF.Label3 = ""
   DoEvents

   fl = 2
   mContador = 0
   
   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      .WindowState = xlMinimized
      Me.Refresh
      With .Workbooks.Open(mArchivo)
         '.Sheets("Hoja1").Select
         With .ActiveSheet
            Do While True
               If Len(Trim(.Cells(fl, 1))) = 0 Then Exit Do
               
               mConProblemas = False
               
               mContador = mContador + 1
               oF.Label2 = "Material : " & .Cells(fl, 2)
               oF.Label3 = "" & mContador
               DoEvents
            
               mCodigoMaterial = .Cells(fl, 1)
               mMaterial = .Cells(fl, 2)
               mCantidad = .Cells(fl, 3)
               mEquipoDestino = .Cells(fl, 4)
               mOrdenTrabajo = .Cells(fl, 5)
               
               mIdArticulo = 0
               mIdUnidad = 0
               mIdUbicacion = 0
               mCosto = 0
               Set oRsAux = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", mCodigoMaterial)
               If oRsAux.RecordCount > 0 Then
                  mIdArticulo = oRsAux.Fields(0).Value
                  mIdUnidad = IIf(IsNull(oRsAux.Fields("IdUnidad").Value), 0, oRsAux.Fields("IdUnidad").Value)
                  mIdUbicacion = IIf(IsNull(oRsAux.Fields("IdUbicacionStandar").Value), 0, oRsAux.Fields("IdUbicacionStandar").Value)
                  mCosto = IIf(IsNull(oRsAux.Fields("CostoReposicion").Value), 0, oRsAux.Fields("CostoReposicion").Value)
                  If Len(mBasePRONTOMantenimiento) > 0 And IIf(IsNull(oRsAux.Fields("IdTipoRosca").Value), 0, oRsAux.Fields("IdTipoRosca").Value) = 0 Then
                     AgregarMensajeProcesoPresto oRsErrores, "El material " & mCodigoMaterial & " no tiene definida la familia."
                     mConProblemas = True
                  End If
               Else
                  AgregarMensajeProcesoPresto oRsErrores, "El material " & mCodigoMaterial & " no existe en la base de datos."
                  mConProblemas = True
               End If
               oRsAux.Close
               
               mIdEquipoDestino = 0
               If Len(mEquipoDestino) > 0 Then
                  Set oRsAux = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", mEquipoDestino)
                  If oRsAux.RecordCount > 0 Then
                     mIdEquipoDestino = oRsAux.Fields(0).Value
                  Else
                     AgregarMensajeProcesoPresto oRsErrores, "El equipo destino " & mEquipoDestino & " no existe en la base de datos."
                     mConProblemas = True
                  End If
                  oRsAux.Close
               End If
               
               mIdOrdenTrabajo = 0
               If Len(mOrdenTrabajo) > 0 Then
                  Set oRsAux = Aplicacion.OrdenesTrabajo.TraerFiltrado("_PorNumero", mOrdenTrabajo)
                  If oRsAux.RecordCount > 0 Then
                     mIdOrdenTrabajo = oRsAux.Fields(0).Value
                  Else
                     AgregarMensajeProcesoPresto oRsErrores, "La orden de trabajo " & mOrdenTrabajo & " no existe en la base de datos."
                     mConProblemas = True
                  End If
                  oRsAux.Close
               End If
               
               If Not mConProblemas Then
                  With origen.DetSalidasMateriales.Item(-1)
                     With .Registro
                        .Fields("IdArticulo").Value = mIdArticulo
                        .Fields("IdUnidad").Value = mIdUnidad
                        .Fields("Partida").Value = ""
                        .Fields("IdObra").Value = origen.Registro.Fields("IdObra").Value
                        .Fields("Cantidad").Value = mCantidad
                        .Fields("Adjunto").Value = "NO"
                        .Fields("IdUbicacion").Value = mIdUbicacion
                        .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                        .Fields("CotizacionMoneda").Value = 1
                        .Fields("IdMoneda").Value = mvarIdMonedaPesos
                        .Fields("Observaciones").Value = ""
                        .Fields("CostoUnitario").Value = mCosto
                        If mIdEquipoDestino > 0 Then .Fields("IdEquipoDestino").Value = mIdEquipoDestino
                        If mIdOrdenTrabajo > 0 Then .Fields("IdOrdenTrabajo").Value = mIdOrdenTrabajo
                     End With
                     .Modificado = True
                  End With
               End If
               fl = fl + 1
            Loop
         End With
         .Close False
      End With
      .Quit
   End With
   
   Unload oF
   Set oF = Nothing

   If Not oRsErrores Is Nothing Then
      If oRsErrores.RecordCount > 0 Then
         Set oF = New frmConsulta1
         With oF
            Set .RecordsetFuente = oRsErrores
            .Id = 13
            .Show vbModal, Me
         End With
      Else
         MsgBox "Proceso completo", vbInformation
      End If
      Set oRsErrores = Nothing
   End If

Salida:
   On Error Resume Next
   
   Unload oF
   Set oF = Nothing

   Set oRsErrores = Nothing
   Set oRsAux = Nothing
   Set oEx = Nothing

   Set Lista.DataSource = origen.DetSalidasMateriales.RegistrosConFormato
   
   Exit Sub

Mal:
   MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   Resume Salida

End Sub
