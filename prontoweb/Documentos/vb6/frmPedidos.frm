VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "Mscomctl.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmPedidos 
   Caption         =   "Nota de pedido"
   ClientHeight    =   8160
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11865
   Icon            =   "frmPedidos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8160
   ScaleWidth      =   11865
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtImpuestosInternos 
      Alignment       =   1  'Right Justify
      DataField       =   "ImpuestosInternos"
      Height          =   285
      Left            =   10350
      TabIndex        =   104
      Top             =   7200
      Width           =   1410
   End
   Begin VB.TextBox txtOtrosConceptos 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   10350
      Locked          =   -1  'True
      TabIndex        =   102
      Top             =   7515
      Width           =   1410
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Ver RM's"
      Height          =   285
      Index           =   7
      Left            =   7470
      TabIndex        =   101
      Top             =   7830
      Width           =   885
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Datos exportacion"
      Height          =   285
      Index           =   6
      Left            =   10170
      TabIndex        =   100
      Top             =   2385
      Visible         =   0   'False
      Width           =   1605
   End
   Begin VB.CheckBox Check4 
      Alignment       =   1  'Right Justify
      Caption         =   "Transmitir a SAT :"
      Height          =   240
      Left            =   10170
      TabIndex        =   99
      Top             =   3105
      Visible         =   0   'False
      Width           =   1590
   End
   Begin VB.TextBox txtNumeroLicitacion 
      Alignment       =   2  'Center
      DataField       =   "NumeroLicitacion"
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
      Left            =   7875
      TabIndex        =   98
      Top             =   2070
      Width           =   1095
   End
   Begin VB.CommandButton cmdAnularLiberacion 
      Caption         =   "Elim.Liberacion"
      Height          =   330
      Left            =   1530
      TabIndex        =   94
      Top             =   2160
      Width           =   1320
   End
   Begin VB.CheckBox Check3 
      Alignment       =   1  'Right Justify
      Caption         =   "Subcontrato"
      Height          =   285
      Left            =   7245
      TabIndex        =   93
      Top             =   -45
      Visible         =   0   'False
      Width           =   1230
   End
   Begin VB.CommandButton cmdImpre 
      Caption         =   "Borrador"
      Height          =   600
      Index           =   4
      Left            =   4005
      Picture         =   "frmPedidos.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   92
      Top             =   7515
      Width           =   705
   End
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Exterior"
      Height          =   285
      Left            =   1845
      TabIndex        =   87
      Top             =   135
      Width           =   825
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
      Left            =   4140
      TabIndex        =   84
      Top             =   5625
      Width           =   1050
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
      Left            =   6660
      TabIndex        =   83
      Top             =   5625
      Width           =   1050
   End
   Begin VB.TextBox txtBonificacionPorItem 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   10350
      TabIndex        =   82
      Top             =   5940
      Width           =   1410
   End
   Begin VB.CommandButton cmd 
      BackColor       =   &H00C0C0FF&
      Caption         =   "Adjuntos"
      Height          =   285
      Index           =   5
      Left            =   7470
      Style           =   1  'Graphical
      TabIndex        =   80
      Top             =   7515
      Width           =   885
   End
   Begin VB.CommandButton cmd 
      Height          =   600
      Index           =   4
      Left            =   4770
      Picture         =   "frmPedidos.frx":0CF4
      Style           =   1  'Graphical
      TabIndex        =   78
      Top             =   7515
      Width           =   705
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Anular Pedido"
      Height          =   600
      Index           =   3
      Left            =   6615
      TabIndex        =   76
      Top             =   7515
      Width           =   795
   End
   Begin VB.TextBox txtSubnumero 
      Alignment       =   1  'Right Justify
      DataField       =   "Subnumero"
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
      Left            =   3915
      TabIndex        =   2
      Top             =   135
      Width           =   330
   End
   Begin VB.TextBox txtDetalleCondicionCompra 
      DataField       =   "DetalleCondicionCompra"
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
      Height          =   765
      Left            =   1800
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   73
      Top             =   2880
      Width           =   4380
   End
   Begin VB.Frame Frame2 
      Caption         =   "Tipo de obra : "
      Height          =   915
      Left            =   10305
      TabIndex        =   70
      Top             =   2430
      Visible         =   0   'False
      Width           =   1455
      Begin VB.OptionButton Option3 
         Caption         =   "No consorcial"
         Height          =   195
         Left            =   90
         TabIndex        =   72
         Top             =   270
         Width           =   1275
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Consorcial"
         Height          =   195
         Left            =   90
         TabIndex        =   71
         Top             =   585
         Width           =   1140
      End
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   0
      ItemData        =   "frmPedidos.frx":127E
      Left            =   7875
      List            =   "frmPedidos.frx":1288
      Style           =   2  'Dropdown List
      TabIndex        =   69
      Top             =   2385
      Width           =   2265
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
      Height          =   240
      Left            =   4185
      TabIndex        =   66
      Top             =   1050
      Width           =   1995
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   600
      Index           =   1
      Left            =   3285
      Picture         =   "frmPedidos.frx":12B6
      Style           =   1  'Graphical
      TabIndex        =   64
      Top             =   7515
      Width           =   705
   End
   Begin VB.TextBox txtPresupuesto 
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
      Left            =   9180
      TabIndex        =   63
      Top             =   3060
      Width           =   915
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   0
      Left            =   7740
      TabIndex        =   59
      Top             =   3420
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   1
      Left            =   7965
      TabIndex        =   58
      Top             =   3420
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   2
      Left            =   8190
      TabIndex        =   57
      Top             =   3420
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   3
      Left            =   8415
      TabIndex        =   56
      Top             =   3420
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   4
      Left            =   8640
      TabIndex        =   55
      Top             =   3420
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   5
      Left            =   8865
      TabIndex        =   54
      Top             =   3420
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   6
      Left            =   9090
      TabIndex        =   53
      Top             =   3420
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Datos adicionales"
      Height          =   600
      Index           =   2
      Left            =   5580
      TabIndex        =   50
      Top             =   7515
      Width           =   990
   End
   Begin VB.TextBox txtContacto 
      DataField       =   "Contacto"
      Height          =   330
      Left            =   1800
      TabIndex        =   48
      Top             =   900
      Width           =   2310
   End
   Begin VB.TextBox txtPorcentajeBonificacion 
      Alignment       =   1  'Right Justify
      DataField       =   "PorcentajeBonificacion"
      Height          =   255
      Left            =   9720
      TabIndex        =   46
      Top             =   6255
      Width           =   510
   End
   Begin VB.TextBox txtEmailComprador 
      Enabled         =   0   'False
      Height          =   330
      Left            =   1485
      TabIndex        =   42
      Top             =   1800
      Width           =   2760
   End
   Begin VB.TextBox txtTelefonoComprador 
      Enabled         =   0   'False
      Height          =   330
      Left            =   4680
      TabIndex        =   41
      Top             =   1800
      Width           =   1500
   End
   Begin VB.CommandButton cmdPegar 
      Height          =   600
      Left            =   1845
      Picture         =   "frmPedidos.frx":1840
      Style           =   1  'Graphical
      TabIndex        =   40
      Top             =   7515
      UseMaskColor    =   -1  'True
      Width           =   705
   End
   Begin RichTextLib.RichTextBox rchObservacionesItem 
      Height          =   285
      Left            =   8145
      TabIndex        =   38
      Top             =   5670
      Visible         =   0   'False
      Width           =   195
      _ExtentX        =   344
      _ExtentY        =   503
      _Version        =   393217
      TextRTF         =   $"frmPedidos.frx":1C82
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   960
      Left            =   90
      TabIndex        =   37
      Top             =   6480
      Width           =   4470
      _ExtentX        =   7885
      _ExtentY        =   1693
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmPedidos.frx":1D04
   End
   Begin VB.TextBox txtTotalIva1 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   10350
      TabIndex        =   30
      Top             =   6885
      Width           =   1410
   End
   Begin VB.TextBox txtNeto 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   10350
      TabIndex        =   29
      Top             =   6570
      Width           =   1410
   End
   Begin VB.TextBox txtBonificacion 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   10350
      TabIndex        =   28
      Top             =   6255
      Width           =   1410
   End
   Begin VB.TextBox txtSubtotal 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   300
      Left            =   10350
      TabIndex        =   27
      Top             =   5625
      Width           =   1410
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   600
      Index           =   0
      Left            =   2565
      Picture         =   "frmPedidos.frx":1D86
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   7515
      UseMaskColor    =   -1  'True
      Width           =   705
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   600
      Index           =   1
      Left            =   900
      TabIndex        =   7
      Top             =   7515
      Width           =   795
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   600
      Index           =   0
      Left            =   45
      TabIndex        =   6
      Top             =   7515
      Width           =   795
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
      Height          =   300
      Index           =   0
      Left            =   10350
      Locked          =   -1  'True
      TabIndex        =   16
      Top             =   7830
      Width           =   1410
   End
   Begin VB.TextBox txtDireccion 
      Enabled         =   0   'False
      Height          =   285
      Left            =   7785
      TabIndex        =   15
      Top             =   90
      Width           =   3975
   End
   Begin VB.TextBox txtLocalidad 
      Enabled         =   0   'False
      Height          =   285
      Left            =   7785
      TabIndex        =   14
      Top             =   405
      Width           =   3975
   End
   Begin VB.TextBox txtProvincia 
      Enabled         =   0   'False
      Height          =   285
      Left            =   7785
      TabIndex        =   13
      Top             =   720
      Width           =   3975
   End
   Begin VB.TextBox txtTelefono 
      Enabled         =   0   'False
      Height          =   285
      Left            =   7785
      TabIndex        =   12
      Top             =   1035
      Width           =   3975
   End
   Begin VB.TextBox txtEmail 
      Enabled         =   0   'False
      Height          =   285
      Left            =   7785
      TabIndex        =   11
      Top             =   1350
      Width           =   3975
   End
   Begin VB.TextBox txtCuit 
      Enabled         =   0   'False
      Height          =   285
      Left            =   10350
      TabIndex        =   10
      Top             =   1665
      Width           =   1410
   End
   Begin VB.TextBox txtCondicionIva 
      Enabled         =   0   'False
      Height          =   285
      Left            =   7785
      TabIndex        =   9
      Top             =   1665
      Width           =   1995
   End
   Begin VB.TextBox txtNumeroPedido 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroPedido"
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
      Left            =   2700
      TabIndex        =   0
      Top             =   135
      Width           =   1050
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaPedido"
      Height          =   330
      Index           =   0
      Left            =   4950
      TabIndex        =   3
      Top             =   135
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   97386497
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   0
      Left            =   1800
      TabIndex        =   1
      Tag             =   "Proveedores"
      Top             =   540
      Width           =   4380
      _ExtentX        =   7726
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin VB.PictureBox Lista 
      Height          =   1905
      Left            =   45
      OLEDragMode     =   1  'Automatic
      OLEDropMode     =   1  'Manual
      ScaleHeight     =   1845
      ScaleWidth      =   11745
      TabIndex        =   39
      Top             =   3735
      Width           =   11805
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdComprador"
      Height          =   315
      Index           =   1
      Left            =   1485
      TabIndex        =   4
      Tag             =   "Empleados"
      Top             =   1440
      Width           =   2760
      _ExtentX        =   4868
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Aprobo"
      Height          =   315
      Index           =   2
      Left            =   2880
      TabIndex        =   51
      Tag             =   "Empleados"
      Top             =   2160
      Width           =   3300
      _ExtentX        =   5821
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "NumeroComparativa"
      Height          =   315
      Index           =   3
      Left            =   7875
      TabIndex        =   61
      Tag             =   "Comparativas"
      Top             =   2700
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "Numero"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   4
      Left            =   1125
      TabIndex        =   5
      Tag             =   "Monedas"
      Top             =   5625
      Width           =   1320
      _ExtentX        =   2328
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   11340
      Top             =   3510
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
            Picture         =   "frmPedidos.frx":23F0
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPedidos.frx":2502
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPedidos.frx":2954
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPedidos.frx":2DA6
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin RichTextLib.RichTextBox rchMotivoAnulacion 
      Height          =   285
      Left            =   7965
      TabIndex        =   77
      Top             =   5670
      Visible         =   0   'False
      Width           =   195
      _ExtentX        =   344
      _ExtentY        =   503
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmPedidos.frx":31F8
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin RichTextLib.RichTextBox rchObservacionesItemVisible 
      Height          =   1230
      Left            =   4635
      TabIndex        =   88
      Top             =   6210
      Width           =   3750
      _ExtentX        =   6615
      _ExtentY        =   2170
      _Version        =   393217
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmPedidos.frx":327C
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCondicionCompra"
      Height          =   315
      Index           =   7
      Left            =   1485
      TabIndex        =   90
      Tag             =   "CondicionesCompra"
      Top             =   2520
      Width           =   4695
      _ExtentX        =   8281
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCondicionCompra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdPedidoAbierto"
      Height          =   315
      Index           =   5
      Left            =   10350
      TabIndex        =   95
      Top             =   2025
      Width           =   1410
      _ExtentX        =   2487
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPedidoAbierto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "NumeroSubcontrato"
      Height          =   315
      Index           =   6
      Left            =   1125
      TabIndex        =   106
      Tag             =   "SubcontratosDatos"
      Top             =   5940
      Width           =   3435
      _ExtentX        =   6059
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "NumeroSubcontrato"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdPuntoVenta"
      Height          =   315
      Index           =   10
      Left            =   1800
      TabIndex        =   108
      Tag             =   "PuntosVenta"
      Top             =   360
      Visible         =   0   'False
      Width           =   825
      _ExtentX        =   1455
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPuntoVenta"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Subcontrato :"
      Height          =   240
      Index           =   21
      Left            =   90
      TabIndex        =   107
      Top             =   5985
      Width           =   975
   End
   Begin VB.Label Label3 
      Caption         =   "Impuestos internos :"
      Height          =   240
      Left            =   8460
      TabIndex        =   105
      Top             =   7200
      Width           =   1770
   End
   Begin VB.Label Label2 
      Caption         =   "Otros conceptos :"
      Height          =   240
      Left            =   8460
      TabIndex        =   103
      Top             =   7515
      Width           =   1770
   End
   Begin VB.Label lblData 
      Caption         =   "Nro. de licitacion :"
      Height          =   240
      Index           =   8
      Left            =   6480
      TabIndex        =   97
      Top             =   2115
      Width           =   1335
   End
   Begin VB.Label lblData 
      Caption         =   "Pedido abierto :"
      Height          =   240
      Index           =   6
      Left            =   9135
      TabIndex        =   96
      Top             =   2070
      Width           =   1170
   End
   Begin VB.Label lblData 
      Caption         =   "Cond. compra :"
      Height          =   285
      Index           =   7
      Left            =   135
      TabIndex        =   91
      Top             =   2520
      Width           =   1305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones del item seleccionado :"
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
      Index           =   20
      Left            =   4635
      TabIndex        =   89
      Top             =   6030
      Width           =   3345
   End
   Begin VB.Label lblLabels 
      Caption         =   "Conversion a Pesos :"
      Height          =   240
      Index           =   17
      Left            =   2565
      TabIndex        =   86
      Top             =   5670
      Width           =   1530
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cotizacion dolar :"
      Height          =   240
      Index           =   18
      Left            =   5310
      TabIndex        =   85
      Top             =   5670
      Width           =   1305
   End
   Begin VB.Label Label1 
      Caption         =   "Bonificaciones por item : "
      Height          =   240
      Index           =   3
      Left            =   8460
      TabIndex        =   81
      Top             =   5940
      Width           =   1770
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
      TabIndex        =   79
      Top             =   3510
      Width           =   1545
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Moneda :"
      Height          =   240
      Index           =   4
      Left            =   90
      TabIndex        =   65
      Top             =   5670
      Width           =   990
   End
   Begin VB.Label lblAnulada 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "PEDIDO ANULADO"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   9360
      TabIndex        =   75
      Top             =   3420
      Visible         =   0   'False
      Width           =   2385
   End
   Begin VB.Line Line5 
      BorderColor     =   &H80000005&
      BorderWidth     =   3
      X1              =   3870
      X2              =   3780
      Y1              =   135
      Y2              =   450
   End
   Begin VB.Label lblData 
      Caption         =   "Aclaracion sobre las condiciones compra :"
      Height          =   465
      Index           =   5
      Left            =   135
      TabIndex        =   74
      Top             =   2925
      Width           =   1575
      WordWrap        =   -1  'True
   End
   Begin VB.Label lblData 
      Caption         =   "Tipo de compra : "
      Height          =   240
      Index           =   3
      Left            =   6480
      TabIndex        =   68
      Top             =   2430
      Width           =   1335
   End
   Begin VB.Label lblLabels 
      Caption         =   "Buscar proveedor :"
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
      Index           =   3
      Left            =   4185
      TabIndex        =   67
      Top             =   855
      Width           =   1680
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro. de presupuesto s/comparativa : "
      Height          =   240
      Index           =   2
      Left            =   6480
      TabIndex        =   62
      Top             =   3060
      Width           =   2640
   End
   Begin VB.Label lblLabels 
      Caption         =   "Autorizaciones : "
      Height          =   240
      Index           =   6
      Left            =   6480
      TabIndex        =   60
      Top             =   3375
      Width           =   1215
   End
   Begin VB.Label lblData 
      Caption         =   "Liberado por :"
      Height          =   285
      Index           =   2
      Left            =   135
      TabIndex        =   52
      Top             =   2160
      Width           =   1305
   End
   Begin VB.Line Line4 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      Index           =   1
      X1              =   135
      X2              =   6165
      Y1              =   1350
      Y2              =   1350
   End
   Begin VB.Line Line4 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      Index           =   0
      X1              =   6210
      X2              =   6345
      Y1              =   675
      Y2              =   675
   End
   Begin VB.Line Line3 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      X1              =   6660
      X2              =   6345
      Y1              =   1935
      Y2              =   1935
   End
   Begin VB.Line Line2 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      X1              =   6615
      X2              =   6345
      Y1              =   90
      Y2              =   90
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      X1              =   6345
      X2              =   6345
      Y1              =   90
      Y2              =   1935
   End
   Begin VB.Label lblLabels 
      Caption         =   "Contacto : "
      Height          =   285
      Index           =   15
      Left            =   180
      TabIndex        =   49
      Top             =   945
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro. comparativa : "
      Height          =   240
      Index           =   5
      Left            =   6480
      TabIndex        =   47
      Top             =   2745
      Width           =   1350
   End
   Begin VB.Label lblData 
      Caption         =   "Comprador :"
      Height          =   285
      Index           =   1
      Left            =   135
      TabIndex        =   45
      Top             =   1440
      Width           =   1305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Email comprador :"
      Height          =   285
      Index           =   19
      Left            =   135
      TabIndex        =   44
      Top             =   1800
      Width           =   1305
   End
   Begin VB.Label lblLabels 
      Caption         =   "TE :"
      Height          =   285
      Index           =   1
      Left            =   4320
      TabIndex        =   43
      Top             =   1800
      Width           =   300
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones del pedido :"
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
      Left            =   90
      TabIndex        =   36
      Top             =   6300
      Width           =   2355
   End
   Begin VB.Label Label1 
      Caption         =   "TOTAL :"
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
      Left            =   8460
      TabIndex        =   35
      Top             =   7830
      Width           =   1770
   End
   Begin VB.Label lblIVA1 
      Caption         =   "IVA"
      Height          =   240
      Left            =   8460
      TabIndex        =   34
      Top             =   6885
      Width           =   1770
   End
   Begin VB.Label Label1 
      Caption         =   "Subtotal gravado :"
      Height          =   240
      Index           =   2
      Left            =   8460
      TabIndex        =   33
      Top             =   6570
      Width           =   1770
   End
   Begin VB.Label Label1 
      Caption         =   "Bonificacion :"
      Height          =   240
      Index           =   1
      Left            =   8460
      TabIndex        =   32
      Top             =   6255
      Width           =   1185
   End
   Begin VB.Label Label1 
      Caption         =   "Subtotal :"
      Height          =   195
      Index           =   0
      Left            =   8460
      TabIndex        =   31
      Top             =   5670
      Width           =   1770
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   285
      Index           =   4
      Left            =   4320
      TabIndex        =   26
      Top             =   165
      Width           =   585
   End
   Begin VB.Label lblData 
      Caption         =   "Proveedor :"
      Height          =   285
      Index           =   0
      Left            =   180
      TabIndex        =   25
      Top             =   540
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      Caption         =   "Direccion :"
      Height          =   195
      Index           =   7
      Left            =   6660
      TabIndex        =   24
      Top             =   135
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Localidad :"
      Height          =   195
      Index           =   8
      Left            =   6660
      TabIndex        =   23
      Top             =   450
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Provincia :"
      Height          =   195
      Index           =   9
      Left            =   6660
      TabIndex        =   22
      Top             =   765
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Telefono :"
      Height          =   195
      Index           =   10
      Left            =   6660
      TabIndex        =   21
      Top             =   1080
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Email :"
      Height          =   195
      Index           =   11
      Left            =   6660
      TabIndex        =   20
      Top             =   1395
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "CUIT :"
      Height          =   195
      Index           =   12
      Left            =   9855
      TabIndex        =   19
      Top             =   1710
      Width           =   450
   End
   Begin VB.Label lblLabels 
      Caption         =   "Condicion Iva :"
      Height          =   195
      Index           =   13
      Left            =   6660
      TabIndex        =   18
      Top             =   1710
      Width           =   1080
   End
   Begin VB.Label lblData 
      Caption         =   "Pedido numero :"
      Height          =   285
      Index           =   10
      Left            =   180
      TabIndex        =   17
      Top             =   135
      Width           =   1575
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
         Caption         =   "Anular"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar fecha de necesidad"
         Index           =   4
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar fecha de entrega"
         Index           =   5
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar % Bonificacion a items seleccionados"
         Index           =   6
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar % Bonificacion a todos los items"
         Index           =   7
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar % IVA a items seleccionados"
         Index           =   8
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar % IVA a todos los items"
         Index           =   9
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Duplicar un item"
         Index           =   10
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar marca de descripciones"
         Index           =   11
         Begin VB.Menu MnuDetA1 
            Caption         =   "Solo descripcion del material"
            Index           =   0
         End
         Begin VB.Menu MnuDetA1 
            Caption         =   "Solo observaciones"
            Index           =   1
         End
         Begin VB.Menu MnuDetA1 
            Caption         =   "Descripcion del material mas observaciones"
            Index           =   2
         End
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar precio a items seleccionados"
         Index           =   12
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar precio a todos los items"
         Index           =   13
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Renumerar items"
         Index           =   14
      End
   End
End
Attribute VB_Name = "frmPedidos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Pedido
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mCantidadFirmas As Integer, mvarTipoIVA As Integer, mvarIdMonedaPesos As Integer, mvarIdMonedaDolar As Integer
Private mvarIdControlCalidadStandar As Integer
Private mvarId As Long, mIdAprobo As Long, mNumeroPedidoOriginal As Long, mvarIdObraStockDisponible As Long
Private mvarCondicionIva As Double, mvarP_IVA1 As Double, mvarP_IVA2 As Double, mvarTotalPedido As Double
Private mvarSubTotal As Double, mvarSubtotalGravado As Double, mvarBonificacion As Double, mvarIVA1 As Double
Private mvarIVA2 As Double, mvarBonificacionPorItem As Double, mvarCotizacion As Double, mvarTotalOtrosConceptos As Double
Private mvarPlazoEntrega As String, mNumeracionAutomatica As String, mDatosExportacion As String
Private mvarGrabado As Boolean, mvarAnulada As Boolean, mAccesoParaMail As Boolean, mExigirTrasabilidad_RMLA_PE As Boolean
Private mvarLiberada As Boolean, mvarImpresionHabilitada As Boolean, mVisualizacionSimplificada As Boolean
Private mvarEnProceso As Boolean, mAccesoParaMailInterno As Boolean, mHabilitarImpuestosInternosItem As Boolean
Private mNumeracionPorPuntoVenta As Boolean
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

Public Property Let AccesoParaMail(ByVal mAcceso As Boolean)
   
   mAccesoParaMail = mAcceso
   
End Property

Public Property Let AccesoParaMailInterno(ByVal mAcceso As Boolean)
   
   mAccesoParaMailInterno = mAcceso
   
End Property

Sub Editar(ByVal Cual As Long)

'   If mvarId > 0 And Cual < 0 Then
'      MsgBox "No puede modificar un pedido ya registrado", vbCritical
'      Exit Sub
'   End If
   
'   If mvarId > 0 And Not IsNull(origen.Registro.Fields("Aprobo").Value) Then
'      MsgBox "No puede modificar un pedido ya registrado", vbCritical
'      Exit Sub
'   End If
   
   If mNivelAcceso > 8 Then
      MsgBox "Nivel de acceso insuficiente!", vbCritical
      Exit Sub
   End If
   
   If mvarAnulada Then
      MsgBox "El pedido ha sido anulado y no puede modificarse!", vbCritical
      Exit Sub
   End If

   Dim oF As frmDetPedidos
   Dim oL As ListItem
   Dim dtp As DTPicker

   For Each dtp In DTFields
      origen.Registro.Fields(dtp.DataField).Value = dtp.Value
   Next
   
   Set oF = New frmDetPedidos
   With oF
      Set .Pedido = origen
      .TipoIVA = mvarTipoIVA
      .CondicionIva = mvarCondicionIva
      If Check2.Value = 1 Then
         .Exterior = "SI"
      Else
         .Exterior = "NO"
      End If
      .Id = Cual
      .Show vbModal, Me
      If Me.VisualizacionSimplificada Then Exit Sub
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = Lista.ListItems.Add
            oL.Tag = .IdNuevo
            oL.SubItems(28) = .IdNuevo
         Else
            Set oL = Lista.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtItem
            .SubItems(1) = "" & oF.txtCantidad.Text
            .SubItems(2) = "" & oF.txtCantidad1.Text
            .SubItems(3) = "" & oF.txtCantidad2.Text
            .SubItems(4) = "" & oF.DataCombo1(0).Text
            .SubItems(5) = "" & oF.DataCombo1(4).Text
            .SubItems(6) = "" & oF.txtCodigoArticulo.Text
            .SubItems(7) = "" & oF.DataCombo1(1).Text
            .SubItems(8) = "" & IIf(oF.DTFields(0).Enabled, oF.DTFields(0).Value, "")
            .SubItems(9) = "" & IIf(oF.DTFields(1).Enabled, oF.DTFields(1).Value, "")
            With origen.DetPedidos.Item(.Tag).Registro
               If Not IsNull(.Fields("Precio").Value) Then
                  oL.SubItems(10) = "" & Format(.Fields("Precio").Value, "#0.0000")
                  oL.SubItems(11) = "" & Format(.Fields("Precio").Value * Val(oF.txtCantidad.Text), "#0.0000")
               Else
                  oL.SubItems(10) = ""
                  oL.SubItems(11) = ""
               End If
               If Not IsNull(.Fields("PorcentajeBonificacion").Value) Then
                  oL.SubItems(12) = "" & Format(.Fields("PorcentajeBonificacion").Value, "Fixed")
                  oL.SubItems(13) = "" & Format(.Fields("ImporteBonificacion").Value, "#0.0000")
                  oL.SubItems(14) = "" & Format((.Fields("Precio").Value * Val(oF.txtCantidad.Text)) - .Fields("ImporteBonificacion").Value, "#0.0000")
               Else
                  oL.SubItems(12) = ""
                  oL.SubItems(13) = ""
                  oL.SubItems(14) = "" & Format(.Fields("Precio").Value * Val(oF.txtCantidad.Text), "#0.0000")
               End If
               If Not IsNull(.Fields("PorcentajeIVA").Value) Then
                  oL.SubItems(15) = "" & Format(.Fields("PorcentajeIVA").Value, "Fixed")
                  oL.SubItems(16) = "" & Format(.Fields("ImporteIVA").Value, "#0.0000")
               Else
                  oL.SubItems(15) = ""
                  oL.SubItems(16) = ""
               End If
               If Not IsNull(.Fields("ImporteTotalItem").Value) Then
                  oL.SubItems(17) = "" & Format(.Fields("ImporteTotalItem").Value, "#0.0000")
               Else
                  oL.SubItems(17) = ""
               End If
            End With
            .SubItems(18) = "NO"
            .SubItems(19) = "" & oF.rchObservaciones.Text
            .SubItems(20) = "" & oF.txtNumeroAcopio.Text
            .SubItems(21) = "" & oF.txtNumeroItemAcopio.Text
            .SubItems(22) = "" & oF.txtNumeroRequerimiento.Text
            .SubItems(23) = "" & oF.txtNumeroItemRequerimiento.Text
            .SubItems(24) = "" & oF.txtNumeroObra.Text
            .SubItems(26) = "" & oF.txtCosto.Text
         End With
         Lista_ItemClick oL
      End If
   End With
   Unload oF
   Set oF = Nothing
   
   CalculaPedido
   
End Sub

Private Sub Check2_Click()

   If mvarId < 1 Then
      Dim oRs As ADOR.Recordset
      Dim mNum As Long
      Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
      If Check2.Value = 1 Then
         mNum = oRs.Fields("ProximoNumeroPedidoExterior").Value
      Else
         mNum = oRs.Fields("ProximoNumeroPedido").Value
      End If
      oRs.Close
      Set oRs = Nothing
      With origen.Registro
         .Fields("NumeroPedido").Value = mNum
         mNumeroPedidoOriginal = mNum
         .Fields("SubNumero").Value = 0
         If Check2.Value = 1 And dcfields(4).BoundText = mvarIdMonedaPesos Then
            .Fields("IdMoneda").Value = glbIdMonedaDolar
         End If
      End With
   End If
   CalculaPedido
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Dim oF As Form
   Dim oL As ListItem
   Dim mvarSale As Integer
   Dim mIdAutorizo As Long, mNum As Long
   Dim mTotalPedidoAbierto As Double, mvarTotalPedidos As Double
   Dim mFechaLimite As Date
   Dim oPar As ComPronto.Parametro
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   
   On Error GoTo Mal
   
   Select Case Index
      Case 0
         If Len(txtCotizacionMoneda.Text) = 0 Then
            MsgBox "No ingreso la cotizacion", vbInformation
            Exit Sub
         End If
         
         If Val(txtCotizacionDolar.Text) = 0 Then
            txtCotizacionDolar.Text = Cotizacion(DTFields(0).Value, glbIdMonedaDolar)
            If Val(txtCotizacionDolar.Text) = 0 Then
               MsgBox "No ingreso la cotizacion", vbInformation
               Exit Sub
            End If
         End If
         
         If Val(txtCotizacionDolar.Text) = 0 Then
            MsgBox "No hay cotizacion dolar", vbInformation
            Exit Sub
         End If
         
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar una Lista de Pedido sin detalles"
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim mvarImprime As Integer, mvarNumero As Integer
         Dim mvarErr As String, mvarControlFechaNecesidad As String
         Dim PorObra As Boolean, mTrasabilidad_RM_LA As Boolean
      
         For Each dtp In DTFields
            origen.Registro.Fields(dtp.DataField).Value = dtp.Value
         Next
         
         For Each dc In dcfields
            If dc.Enabled Then
               If Not IsNumeric(dc.BoundText) And dc.Visible And dc.Index <> 2 And dc.Index <> 3 And dc.Index <> 5 And dc.Index <> 6 Then
                  MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
                  Exit Sub
               End If
               If IsNumeric(dc.BoundText) Then
                  origen.Registro.Fields(dc.DataField).Value = dc.BoundText
               End If
            End If
         Next
         
'         If Not IsNull(origen.Registro.Fields("PorcentajeBonificacion").Value) And _
'               origen.Registro.Fields("PorcentajeBonificacion").Value <> 0 Then
'            MsgBox "El porcentaje global de descuento debe ser distribuido a cada item", vbCritical
'            Exit Sub
'         End If
         
         If Len(Trim(txtNumeroPedido.Text)) = 0 Then
            MsgBox "Debe completar el numero de pedido!", vbExclamation
            Exit Sub
         End If
   
         If mvarId < 0 And Len(Trim(txtSubnumero.Text)) = 0 Then
            MsgBox "Debe ingresar el subnumero del pedido", vbExclamation
            Exit Sub
         End If
         
         mvarControlFechaNecesidad = BuscarClaveINI("Quitar control fecha necesidad en pedidos")

         mvarErr = ""
         With origen.DetPedidos.Registros
            If .Fields.Count > 0 Then
               If .RecordCount > 0 Then
                  .MoveFirst
                  Do While Not .EOF
                     If Not .Fields("Eliminado").Value Then
                        If IsNull(.Fields("Precio").Value) Or .Fields("Precio").Value = 0 And IsNull(origen.Registro.Fields("IdPedidoAbierto").Value) Then
                           mvarErr = mvarErr + "Hay items de pedido que no tienen precio unitario" & vbCrLf
                           Exit Do
                        End If
                        If IsNull(.Fields("IdControlCalidad").Value) Then
                           mvarErr = mvarErr + "Hay items de pedido que no tienen indicado control de calidad" & vbCrLf
                           Exit Do
                        End If
                        If Not IsNull(.Fields("FechaEntrega").Value) And .Fields("FechaEntrega").Value < DTFields(0).Value Then
                           mvarErr = mvarErr + "Hay items de pedido que tienen fecha de entrega inferior a la fecha del pedido" & vbCrLf
                           Exit Do
                        End If
                        If Not IsNull(.Fields("FechaNecesidad").Value) And .Fields("FechaNecesidad").Value < DTFields(0).Value And _
                              mvarControlFechaNecesidad <> "SI" Then
                           mvarErr = mvarErr + "Hay items de pedido que tienen fecha de necesidad inferior a la fecha del pedido" & vbCrLf
                           Exit Do
                        End If
                        If IsNull(.Fields("IdCentroCosto").Value) Then
                           PorObra = False
                           mTrasabilidad_RM_LA = False
                           If Not IsNull(.Fields("IdDetalleAcopios").Value) Or Not IsNull(.Fields("IdDetalleLMateriales").Value) Then
                              PorObra = True
                           End If
                           If Not IsNull(.Fields("IdDetalleRequerimiento").Value) Then
                              Set oRs = Aplicacion.Requerimientos.TraerFiltrado("_DatosObra", .Fields("IdDetalleRequerimiento").Value)
                              If oRs.RecordCount > 0 Then
                                 If Not IsNull(oRs.Fields("Obra").Value) Then
                                    PorObra = True
                                 End If
                              End If
                              oRs.Close
                              Set oRs = Nothing
                           End If
                           If Not PorObra Then
'                              mvarErr = mvarErr + "Hay items de pedido que no tienen indicado centro de costo" & vbCrLf
'                              Exit Do
                           End If
                           If mExigirTrasabilidad_RMLA_PE And IsNull(.Fields("IdDetalleAcopios").Value) And _
                                 IsNull(.Fields("IdDetalleRequerimiento").Value) Then
                              MsgBox "Hay items de pedido que no tienen trazabilidad a RM o LA", vbExclamation
                              Exit Sub
                           End If
                        End If
                     End If
                     .MoveNext
                  Loop
               End If
            End If
         End With
         
         If Len(mvarErr) Then
            If mIdAprobo = 0 Then
               mvarErr = mvarErr & vbCrLf & "Cuando libere el pedido estos errores deberan estar corregidos"
               MsgBox "Errores encontrados :" & vbCrLf & mvarErr, vbExclamation
            Else
               MsgBox "Errores encontrados :" & vbCrLf & mvarErr, vbExclamation
               Exit Sub
            End If
         End If
         
         cmd_Click (2)
         Me.Refresh
         
         Set oAp = Aplicacion
         
         If Not mNumeracionPorPuntoVenta Then
            If mvarId = -1 And mNumeracionAutomatica <> "SI" And txtNumeroPedido.Text = mNumeroPedidoOriginal Then
               Set oPar = oAp.Parametros.Item(1)
               If Check2.Value = 0 Then
                  mNum = oPar.Registro.Fields("ProximoNumeroPedido").Value
               Else
                  mNum = oPar.Registro.Fields("ProximoNumeroPedidoExterior").Value
               End If
               origen.Registro.Fields("NumeroPedido").Value = mNum
               mNumeroPedidoOriginal = mNum
               Set oPar = Nothing
            End If
            
            Set oRs = oAp.Pedidos.TraerFiltrado("_PorNumero", Array(Val(txtNumeroPedido.Text), Val(txtSubnumero.Text)))
            If oRs.RecordCount > 0 Then
               If mvarId < 0 Or (mvarId > 0 And oRs.Fields(0).Value <> mvarId) Then
                  oRs.Close
                  Set oRs = Nothing
                  mvarNumero = MsgBox("Numero/Subnumero de pedido ya existente" & vbCrLf & "Desea actualizar el numero ?", vbYesNo, "Numero de pedido")
                  If mvarNumero = vbYes Then
                     Set oPar = oAp.Parametros.Item(1)
                     If Check2.Value = 0 Then
                        mNum = oPar.Registro.Fields("ProximoNumeroPedido").Value
                     Else
                        mNum = oPar.Registro.Fields("ProximoNumeroPedidoExterior").Value
                     End If
                     origen.Registro.Fields("NumeroPedido").Value = mNum
                     Set oPar = Nothing
                  End If
                  Exit Sub
               End If
            End If
            oRs.Close
            Set oRs = Nothing
         Else
            Set oRs = oAp.Pedidos.TraerFiltrado("_PorNumero", Array(Val(txtNumeroPedido.Text), Val(txtSubnumero.Text), dcfields(10).BoundText))
            If oRs.RecordCount > 0 Then
               If mvarId < 0 Or (mvarId > 0 And oRs.Fields(0).Value <> mvarId) Then
                  oRs.Close
                  Set oRs = Nothing
                  MsgBox "Numero/Subnumero de pedido ya existente", vbExclamation
                  Exit Sub
               End If
            End If
            oRs.Close
         End If
         
         Me.MousePointer = vbHourglass
         
         With origen.Registro
            If Not IsNull(.Fields("IdPedidoAbierto").Value) Then
               mTotalPedidoAbierto = 0
               mvarTotalPedidos = 0
               mFechaLimite = 0
               Set oRs1 = Aplicacion.PedidosAbiertos.TraerFiltrado("_Control", .Fields("IdPedidoAbierto").Value)
               If oRs1.RecordCount > 0 Then
                  mTotalPedidoAbierto = IIf(IsNull(oRs1.Fields("ImporteLimite").Value), 0, oRs1.Fields("ImporteLimite").Value)
                  mvarTotalPedidos = IIf(IsNull(oRs1.Fields("SumaPedidos").Value), 0, oRs1.Fields("SumaPedidos").Value)
                  mFechaLimite = IIf(IsNull(oRs1.Fields("FechaLimite").Value), 0, oRs1.Fields("FechaLimite").Value)
               End If
               oRs1.Close
               If mvarId > 0 Then
                  Set oRs1 = Aplicacion.Pedidos.TraerFiltrado("_PorId", mvarId)
                  If oRs1.RecordCount > 0 Then
                     mvarTotalPedidos = mvarTotalPedidos - IIf(IsNull(oRs1.Fields("TotalPedido").Value), 0, oRs1.Fields("TotalPedido").Value)
                  End If
                  oRs1.Close
               End If
               mvarTotalPedidos = mvarTotalPedidos + mvarTotalPedido
               If mTotalPedidoAbierto > 0 And mTotalPedidoAbierto < mvarTotalPedidos Then
                  MsgBox "Se supero el importe limite del pedido abierto : " & mTotalPedidoAbierto, vbCritical
                  GoTo Salida
               End If
               If mFechaLimite > 0 And mFechaLimite < DTFields(0).Value Then
                  MsgBox "Se supero la fecha limite del pedido abierto : " & mFechaLimite, vbCritical
                  GoTo Salida
               End If
            End If
            If mNumeracionPorPuntoVenta Then
               .Fields("PuntoVenta").Value = Val(dcfields(10).Text)
            Else
               If mvarId = -1 And mNumeracionAutomatica <> "SI" And txtNumeroPedido.Text = mNumeroPedidoOriginal Then
                  Set oPar = oAp.Parametros.Item(1)
                  If Check2.Value = 0 Then
                     mNum = oPar.Registro.Fields("ProximoNumeroPedido").Value
                     .Fields("NumeroPedido").Value = mNum
                     oPar.Registro.Fields("ProximoNumeroPedido").Value = mNum + 1
                  Else
                     mNum = oPar.Registro.Fields("ProximoNumeroPedidoExterior").Value
                     .Fields("NumeroPedido").Value = mNum
                     oPar.Registro.Fields("ProximoNumeroPedidoExterior").Value = mNum + 1
                  End If
                  oPar.Guardar
                  Set oPar = Nothing
               End If
            End If
            .Fields("Bonificacion").Value = mvarBonificacion
            If IsNumeric(txtPorcentajeBonificacion.Text) Then .Fields("PorcentajeBonificacion").Value = Val(txtPorcentajeBonificacion.Text)
            .Fields("TotalIva1").Value = mvarIVA1
            '.Fields("TotalIva2").Value = mvarIVA2
            .Fields("TotalPedido").Value = mvarTotalPedido
            .Fields("PorcentajeIva1").Value = mvarP_IVA1
            .Fields("PorcentajeIva2").Value = mvarP_IVA2
            .Fields("TipoCompra").Value = Combo1(0).ListIndex + 1
            .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text
            .Fields("CotizacionDolar").Value = txtCotizacionDolar.Text
            If Check2.Value = 1 Then
               .Fields("PedidoExterior").Value = "SI"
            Else
               .Fields("PedidoExterior").Value = "NO"
            End If
            If Not IsNull(.Fields("NumeroSubcontrato").Value) Then
               .Fields("Subcontrato").Value = "SI"
            Else
               .Fields("Subcontrato").Value = "NO"
            End If
            If Check4.Value = 1 Then
               .Fields("Transmitir_a_SAT").Value = "SI"
            Else
               .Fields("Transmitir_a_SAT").Value = "NO"
            End If
            .Fields("EnviarEmail").Value = 1
            If mvarId <= 0 Then .Fields("NumeracionAutomatica").Value = mNumeracionAutomatica
            .Fields("Observaciones").Value = rchObservaciones.Text
         End With
      
         Set oAp = Nothing
         
         Select Case origen.Guardar
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
         With origen.Registro
            If Not mvarLiberada And Not IsNull(.Fields("Aprobo").Value) Then
               'Si debe respetar precedencia solo avisa al primer firmante sino a todos
               If BuscarClaveINI("Respetar precedencia en circuito de firmas") = "SI" Then
                  Set oRs = Aplicacion.AutorizacionesPorComprobante.TraerFiltrado("_PorIdPedido", Array(.Fields(0).Value, 1))
                  If oRs.RecordCount > 0 Then
                     oRs.MoveFirst
                     If Not IsNull(oRs.Fields("Autoriza").Value) Then
                        origen.GuardarNovedadUsuario 2, oRs.Fields("Autoriza").Value, "Firmar Pedido: " & .Fields("NumeroPedido").Value & _
                              "/" & .Fields("Subnumero").Value & " del " & .Fields("FechaPedido").Value
                     End If
                  End If
               Else
                  Set oRs = Aplicacion.AutorizacionesPorComprobante.TraerFiltrado("_PorIdPedido", Array(.Fields(0).Value, -1))
                  If oRs.RecordCount > 0 Then
                     oRs.MoveFirst
                     Do While Not oRs.EOF
                        If Not IsNull(oRs.Fields("Autoriza").Value) Then
                           origen.GuardarNovedadUsuario 2, oRs.Fields("Autoriza").Value, "Firmar Pedido: " & .Fields("NumeroPedido").Value & _
                                 "/" & .Fields("Subnumero").Value & " del " & .Fields("FechaPedido").Value
                        End If
                        oRs.MoveNext
                     Loop
                  End If
               End If
               oRs.Close
               Set oRs = Nothing
            End If
         End With
         
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
            mvarGrabado = True
         Else
            est = Modificacion
         End If
         
         With actL2
            .ListaEditada = "PedidosTodos,+SubPo1,+SubPe2"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
         Me.MousePointer = vbDefault
         
         Set oRs = Aplicacion.Pedidos.TraerFiltrado("_PorId", mvarId)
         If oRs.RecordCount > 0 Then
            If oRs.Fields("NumeroPedido").Value <> txtNumeroPedido.Text Then
               MsgBox "El numero de pedido asignado fue el " & oRs.Fields("NumeroPedido").Value, vbInformation
            End If
         End If
         oRs.Close
         
         If mvarImpresionHabilitada Then
            mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de pedido")
            If mvarImprime = vbYes Then
               If AprobadoImpresion And mIdAprobo > 0 Then
                  cmdImpre_Click (0)
               Else
                  cmdImpre_Click (4)
               End If
            End If
         End If
         
         Unload Me

      Case 1
         Unload Me

      Case 2
         If IsNull(origen.Registro.Fields("IdProveedor").Value) Then
            MsgBox "Debe definir el proveedor", vbExclamation
            Exit Sub
         End If
         
         If Lista.ListItems.Count = 0 Then
            MsgBox "Debe tener items ingresados para ir a Datos Adicionales", vbExclamation
            Exit Sub
         End If
         
         Dim mCondicion As String, mCondicion1 As String, mProveedor As String
         Dim mCC As String
         
         mCondicion = ""
         mCondicion1 = ""
         mProveedor = ""
         
         Set oAp = Aplicacion
         
         mCondicion = ""
         If Not IsNull(origen.Registro.Fields("IdCondicionCompra").Value) Then
            Set oRs1 = oAp.CondicionesCompra.TraerFiltrado("_PorId", origen.Registro.Fields("IdCondicionCompra").Value)
            If oRs1.RecordCount > 0 Then
               mCondicion = Trim(IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value))
               mCondicion1 = mCondicion
               If Not IsNull(oRs1.Fields("Observaciones").Value) Then
                  mCondicion = mCondicion & vbCrLf & oRs1.Fields("Observaciones").Value
               End If
            End If
            oRs1.Close
         End If
         
         Set oRs1 = oAp.Proveedores.TraerFiltrado("_PorId", origen.Registro.Fields("IdProveedor").Value)
         If oRs1.RecordCount > 0 Then
            If Not IsNull(origen.Registro.Fields("DetalleCondicionCompra").Value) Then
               If Trim(origen.Registro.Fields("DetalleCondicionCompra").Value) <> mCondicion1 Then
                  mCondicion = mCondicion & vbCrLf & origen.Registro.Fields("DetalleCondicionCompra").Value
               End If
            End If
            If Not IsNull(oRs1.Fields("RazonSocial").Value) Then mProveedor = oRs1.Fields("RazonSocial").Value
         End If
         oRs1.Close
         Set oRs1 = Nothing
         
         Set oPar = oAp.Parametros.Item(1)
         If oPar.Registro.RecordCount > 0 Then
            With origen.Registro
               rchObservacionesItem.TextRTF = IIf(IsNull(.Fields("PlazoEntrega").Value), "", .Fields("PlazoEntrega").Value)
               If Len(Trim(rchObservacionesItem.Text)) <= 5 Then
                  If Len(mvarPlazoEntrega) > 0 Then
                     .Fields("PlazoEntrega").Value = mvarPlazoEntrega
                  Else
                     .Fields("PlazoEntrega").Value = oPar.Registro.Fields("PedidosPlazoEntrega").Value
                  End If
               End If
               
               rchObservacionesItem.TextRTF = IIf(IsNull(.Fields("LugarEntrega").Value), "", .Fields("LugarEntrega").Value)
               If Len(Trim(rchObservacionesItem.Text)) <= 5 Then
                  .Fields("LugarEntrega").Value = oPar.Registro.Fields("PedidosLugarEntrega").Value
               End If
               
               rchObservacionesItem.TextRTF = IIf(IsNull(.Fields("FormaPago").Value), "", .Fields("FormaPago").Value)
               If Len(Trim(rchObservacionesItem.Text)) <= 5 Or mvarId < 0 Then
                  rchObservacionesItem.TextRTF = oPar.Registro.Fields("PedidosFormaPago").Value
                  rchObservacionesItem.Text = mCondicion & vbCrLf & rchObservacionesItem.Text
                  .Fields("FormaPago").Value = rchObservacionesItem.TextRTF
               End If
               
               rchObservacionesItem.TextRTF = IIf(IsNull(.Fields("Garantia").Value), "", .Fields("Garantia").Value)
               If Len(Trim(rchObservacionesItem.Text)) <= 5 Then
                  rchObservacionesItem.TextRTF = oPar.Registro.Fields("PedidosGarantia").Value
                  .Fields("Garantia").Value = "" & mProveedor & " " & rchObservacionesItem.Text
               End If
               
               rchObservacionesItem.TextRTF = IIf(IsNull(.Fields("Documentacion").Value), "", .Fields("Documentacion").Value)
               If Len(Trim(rchObservacionesItem.Text)) <= 5 Then
                  .Fields("Documentacion").Value = oPar.Registro.Fields("PedidosDocumentacion").Value
               End If
         
               rchObservacionesItem.TextRTF = IIf(IsNull(.Fields("Importante").Value), "", .Fields("Importante").Value)
               If Len(Trim(rchObservacionesItem.Text)) <= 5 Then
                  If Not IsNull(oPar.Registro.Fields("PedidosImportante").Value) Then
                     rchObservacionesItem.TextRTF = oPar.Registro.Fields("PedidosImportante").Value
                     .Fields("Importante").Value = "" & rchObservacionesItem.Text
                  End If
               End If
            End With
         End If
         
         Set oPar = Nothing
         Set oAp = Nothing
   
         Set oF = New frmPedidosAdicionales
         With oF
            Set .Pedido = origen
            mCC = origen.ControlesCalidad
            If InStr(1, mCC, "2") <> 0 Or InStr(1, mCC, "3") <> 0 Then
               .Inspecciones = GeneraInspecciones
            Else
               .Inspecciones = ""
            End If
            .Imputaciones = GeneraImputaciones
            .Show vbModal, Me
         End With
         Unload oF
         Set oF = Nothing
   
      Case 3
         Dim mUsuario As String, mError As String
         
         mvarSale = MsgBox("Esta seguro de anular el pedido ?", vbYesNo, "Anulacion")
         If mvarSale = vbNo Then
            Exit Sub
         End If
         
         mError = ""
         Set oRs = Aplicacion.Pedidos.TraerFiltrado("_RecepcionesPorIdPedido", mvarId)
         With oRs
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  mError = mError & vbCrLf & "El item " & IIf(IsNull(.Fields("NumeroItem").Value), "", .Fields("NumeroItem").Value) & " " & _
                              "no puede ser anulado porque esta incluido en la recepcion " & _
                              IIf(IsNull(.Fields("Comprobante").Value), "", .Fields("Comprobante").Value) & " " & _
                              "del " & IIf(IsNull(.Fields("FechaRecepcion").Value), "", .Fields("FechaRecepcion").Value)
                  .MoveNext
               Loop
            End If
            .Close
         End With
         Set oRs = Nothing
         If Len(mError) > 0 Then
            MsgBox "Se encontraron los siguientes errores : " & mError, vbExclamation
            Exit Sub
         End If
         
         Set oF = New frmAutorizacion
         With oF
            .Empleado = 0
            .IdFormulario = EnumFormularios.NotaPedido
            '.Sector = "Compras"
            .Show vbModal, Me
         End With
         If Not oF.Ok Then
            MsgBox "No puede anular el pedido!", vbExclamation
            Unload oF
            Set oF = Nothing
            Exit Sub
         End If
         mIdAutorizo = oF.IdAutorizo
         Unload oF
         Set oF = Nothing

         Set oAp = Aplicacion
         mUsuario = oAp.Empleados.Item(mIdAutorizo).Registro.Fields("Nombre").Value
         Set oAp = Nothing
         
         Set oF = New frmAnulacion
         With oF
            .Caption = "Motivo de anulacion del pedido"
            .Text1.Text = "Usuario : " & mUsuario & " - [" & Now & "]"
            .Show vbModal, Me
         End With
         If Not oF.Ok Then
            MsgBox "Anulacion cancelada!", vbExclamation
            Unload oF
            Set oF = Nothing
            Exit Sub
         End If
         rchMotivoAnulacion.Text = oF.rchAnulacion.Text
         Unload oF
         Set oF = Nothing

'         mvarModificado = False
   
         For Each oL In Lista.ListItems
            With origen.DetPedidos.Item(oL.Tag)
               .Registro.Fields("Cumplido").Value = "AN"
               .Modificado = True
            End With
         Next
         
         Dim oRsUsuario As ADOR.Recordset
         Set oAp = Aplicacion
         Set oRsUsuario = oAp.Empleados.Item(mIdAutorizo).Registro
         Set oAp = Nothing
         
         With origen.Registro
            .Fields("Cumplido").Value = "AN"
            .Fields("FechaAnulacion").Value = Now
            If Not IsNull(oRsUsuario.Fields("Iniciales").Value) Then
               .Fields("UsuarioAnulacion").Value = oRsUsuario.Fields("Iniciales").Value
            End If
            .Fields("MotivoAnulacion").Value = rchMotivoAnulacion.Text
         End With
   
         oRsUsuario.Close
         Set oRsUsuario = Nothing
         
         origen.Guardar
   
         Unload Me

      Case 4
         If Not mvarId > 0 Then
            MsgBox "Debe grabar el pedido antes de enviar por email", vbExclamation
            Exit Sub
         End If
         
         mvarSale = MsgBox("Esta seguro de generar email ?", vbYesNo, "Enviar email")
         If mvarSale = vbNo Then
            Exit Sub
         End If
         
         EnviarPedidoPorEmail
   
      Case 5
         Set oF = New frmAdjuntos
         With oF
            Set .Pedido = origen
            .Show vbModal, Me
         End With
         If HayAdjuntos Then
            cmd(5).BackColor = &HC0FFC0
         Else
            cmd(5).BackColor = &HC0C0FF
         End If
         Unload oF
         Set oF = Nothing
   
      Case 6
         DatosExportacion
   
      Case 7
         Set oF = New frmConsultaRMPendientes
         With oF
            .Id = "Compras"
            .Show , Me
         End With
         Set oF = Nothing
   End Select
   
Salida:
   
   Set oRsUsuario = Nothing
   Set oRs = Nothing
   Set oRs1 = Nothing
   Set oPar = Nothing
   Set oF = Nothing
   Set oAp = Nothing
   
   Me.MousePointer = vbDefault
   
   Exit Sub
   
Mal:

   MsgBox "Se ha producido un problema al tratar de registrar los datos" & vbCrLf & Err.Description, vbCritical
   Resume Salida
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oDet As DetPedido
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim oRsAut As ADOR.Recordset
   Dim dtf As DTPicker
   Dim ListaVacia As Boolean
   Dim i As Integer
   Dim mNum As Long
   Dim mImporte As Double
   Dim mTextoAnulacion As String
   
   mvarId = vNewValue
   ListaVacia = False
   mvarAnulada = False
   mTextoAnulacion = ""
   mNumeroPedidoOriginal = 0
   mvarPlazoEntrega = ""
   mImporte = 0
   mvarImpresionHabilitada = True
   mvarEnProceso = False
   Me.AccesoParaMailInterno = False
   mHabilitarImpuestosInternosItem = False
   mNumeracionPorPuntoVenta = False
   
   mNumeracionAutomatica = BuscarClaveINI("Numeracion automatica de pedidos")
   If mNumeracionAutomatica <> "SI" Then mNumeracionAutomatica = "NO"
   mDatosExportacion = BuscarClaveINI("Agregar datos de exportacion en pedidos")
   If mDatosExportacion <> "SI" Then
      mDatosExportacion = "NO"
   Else
      cmd(6).Visible = True
   End If
   If BuscarClaveINI("No permitir modificar fecha de NP") = "SI" Then
      DTFields(0).Enabled = False
   End If
   If BuscarClaveINI("Inhabilitar impresion de PE") = "SI" Then
      mvarImpresionHabilitada = False
   End If
   If BuscarClaveINI("Habilitar impuestos internos en items de pedido") = "SI" Then
      mHabilitarImpuestosInternosItem = True
      txtImpuestosInternos.Enabled = False
   End If
   If BuscarClaveINI("Activar subcontratos") = "SI" Then
      dcfields(6).Visible = True
      lblLabels(21).Visible = True
   End If
   If BuscarClaveINI("Activar punto de venta en pedidos") = "SI" Then
      mNumeracionPorPuntoVenta = True
      mNumeracionAutomatica = "SI"
      With dcfields(10)
         .Left = Check2.Left
         .Top = Check2.Top
         .Visible = True
      End With
      With Check2
         .Left = dcfields(1).Left + dcfields(1).Width + 100
         .Top = dcfields(1).Top
      End With
   End If
   
   Set oAp = Aplicacion
   Set origen = oAp.Pedidos.Item(vNewValue)
   Set oBind = New BindingCollection
   
   If glbParametrizacionNivel1 Then
      origen.NivelParametrizacion = 1
      cmd(4).Visible = False
   End If
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      mvarIdMonedaPesos = IIf(IsNull(.Fields("IdMoneda").Value), 1, .Fields("IdMoneda").Value)
      mvarIdMonedaDolar = IIf(IsNull(.Fields("IdMonedaDolar").Value), 0, .Fields("IdMonedaDolar").Value)
      mvarIdControlCalidadStandar = IIf(IsNull(.Fields("IdControlCalidadStandar").Value), 0, .Fields("IdControlCalidadStandar").Value)
      If IsNull(.Fields("ExigirTrasabilidad_RMLA_PE").Value) Or .Fields("ExigirTrasabilidad_RMLA_PE").Value = "SI" Then
         mExigirTrasabilidad_RMLA_PE = True
      Else
         mExigirTrasabilidad_RMLA_PE = False
      End If
      mvarIdObraStockDisponible = IIf(IsNull(.Fields("IdObraStockDisponible").Value), 0, .Fields("IdObraStockDisponible").Value)
   End With
   oRs.Close
   
   Set oRs = oAp.ArchivosATransmitirDestinos.TraerTodos
   If oRs.RecordCount > 0 Then Check4.Visible = True
   oRs.Close
   
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetPedidos.TraerMascara
                     ListaVacia = True
                  Else
                     If Me.VisualizacionSimplificada Then
                        Set oRs = origen.DetPedidos.TraerFiltrado("_Simplificados", mvarId)
                     Else
                        If mNivelAcceso <= 8 Then
                           Set oRs = origen.DetPedidos.TraerTodos
                        Else
                           Set oRs = origen.DetPedidos.TraerFiltrado("_TodosSinPrecios", mvarId)
                        End If
                     End If
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           Set oDet = origen.DetPedidos.Item(oRs.Fields(0).Value)
                           oDet.Modificado = True
                           Set oDet = Nothing
                           oRs.MoveNext
                        Loop
                        ListaVacia = False
                     Else
                        Set oControl.DataSource = origen.DetPedidos.TraerMascara
                        ListaVacia = True
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
               If oControl.Tag = "Empleados" Then
                  Set oControl.RowSource = oAp.Empleados.TraerFiltrado("_PorSector", "Compras")
               ElseIf oControl.Tag = "SubcontratosDatos" Then
                  Set oControl.RowSource = oAp.Subcontratos.TraerFiltrado("_DatosParaCombo")
               ElseIf oControl.Tag = "PuntosVenta" Then
                  Set oControl.RowSource = oAp.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", 51)
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
      Set oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
      With oRs
         mvarP_IVA1 = .Fields("Iva1").Value
         mvarP_IVA2 = .Fields("Iva2").Value
         mNum = .Fields("ProximoNumeroPedido").Value
      End With
      oRs.Close
      With origen.Registro
         If Not mNumeracionPorPuntoVenta Then
            .Fields("NumeroPedido").Value = mNum
            mNumeroPedidoOriginal = mNum
         End If
         .Fields("SubNumero").Value = 0
         .Fields("IdMoneda").Value = mvarIdMonedaPesos
      End With
      mvarCotizacion = Cotizacion(Date, glbIdMonedaDolar)
      txtCotizacionDolar.Text = mvarCotizacion
      Combo1(0).ListIndex = 0
      Check4.Value = 1
      ActivarAnulacionLiberacion False
      mvarGrabado = False
      mIdAprobo = 0
      mvarLiberada = False
   Else
      With origen.Registro
         mvarP_IVA1 = .Fields("PorcentajeIva1").Value
         mvarP_IVA2 = .Fields("PorcentajeIva2").Value
         mImporte = .Fields("TotalPedido").Value - .Fields("TotalIva1").Value
         If Not IsNull(.Fields("TipoCompra").Value) Then
            Combo1(0).ListIndex = .Fields("TipoCompra").Value - 1
         Else
            Combo1(0).ListIndex = 0
         End If
         If Not IsNull(.Fields("Consorcial").Value) Then
            If .Fields("Consorcial").Value = "NO" Then
               Option3.Value = True
            Else
               Option4.Value = True
            End If
         End If
         txtPorcentajeBonificacion.Text = IIf(IsNull(.Fields("PorcentajeBonificacion").Value), "", .Fields("PorcentajeBonificacion").Value)
         txtBonificacion.Text = IIf(IsNull(.Fields("Bonificacion").Value), 0, .Fields("Bonificacion").Value)
         If Not IsNull(.Fields("Aprobo").Value) Then
            Check1(0).Value = 1
            dcfields(0).Enabled = False
            txtBusca.Enabled = False
            dcfields(1).Enabled = False
            dcfields(2).Enabled = False
            dcfields(3).Enabled = False
            dcfields(4).Enabled = False
            DTFields(0).Enabled = False
            txtPorcentajeBonificacion.Enabled = False
            txtBonificacion.Enabled = False
            rchObservaciones.Locked = True
            Combo1(0).Enabled = False
            Frame2.Enabled = False
            txtNumeroPedido.Enabled = False
            txtSubnumero.Enabled = False
            mIdAprobo = .Fields("Aprobo").Value
            If CantidadFirmasConfirmadas(NotaPedido, mvarId, mImporte) = 0 And _
                  IIf(IsNull(.Fields("Cumplido").Value), "NO", .Fields("Cumplido").Value) <> "SI" Then
               ActivarAnulacionLiberacion True
            Else
               ActivarAnulacionLiberacion False
            End If
            mvarLiberada = True
         Else
            ActivarAnulacionLiberacion False
            mvarLiberada = False
         End If
         If .Fields("Cumplido").Value = "AN" Then
            If Not IsNull(.Fields("UsuarioAnulacion").Value) Then
               mTextoAnulacion = "Usuario : " & .Fields("UsuarioAnulacion").Value & vbCrLf
            End If
            If Not IsNull(.Fields("FechaAnulacion").Value) Then
               mTextoAnulacion = mTextoAnulacion & "Fecha anulacion : " & .Fields("FechaAnulacion").Value & vbCrLf
            End If
         End If
         mvarCotizacion = IIf(IsNull(.Fields("CotizacionDolar").Value), 0, .Fields("CotizacionDolar").Value)
         txtCotizacionDolar.Text = mvarCotizacion
         txtCotizacionMoneda.Text = IIf(IsNull(.Fields("CotizacionMoneda").Value), 0, .Fields("CotizacionMoneda").Value)
         If IsNull(.Fields("PedidoExterior").Value) Or .Fields("PedidoExterior").Value = "NO" Then
            Check2.Value = 0
         Else
            Check2.Value = 1
         End If
'         If IsNull(.Fields("Subcontrato").Value) Or .Fields("Subcontrato").Value = "NO" Then
'            Check3.Value = 0
'         Else
'            Check3.Value = 1
'         End If
         If Not IsNull(.Fields("Transmitir_a_SAT").Value) And .Fields("Transmitir_a_SAT").Value = "NO" Then
            Check4.Value = 0
         Else
            Check4.Value = 1
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
      
      mCantidadFirmas = 0
      Set oRsAut = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(EnumFormularios.NotaPedido, mImporte))
      If Not oRsAut Is Nothing Then
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
         Set oRsAut = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(EnumFormularios.NotaPedido, mvarId))
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
      End If
      Set oRsAut = Nothing
      mvarGrabado = True
   End If
   
   If mNumeracionAutomatica = "SI" Then
      txtNumeroPedido.Enabled = False
      txtSubnumero.Enabled = False
   End If
   
   If ListaVacia Then Lista.ListItems.Clear
   
   Lista.Sorted = False
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   cmd(0).Enabled = False
   cmd(3).Enabled = False
   If Not Me.VisualizacionSimplificada Then
      If Me.NivelAcceso = Medio Then
         If mvarId <= 0 Then cmd(0).Enabled = True
      ElseIf Me.NivelAcceso = Alto Then
         cmd(0).Enabled = True
         cmd(3).Enabled = True
      End If
   End If
   If Not IsNull(origen.Registro.Fields("Aprobo").Value) Then
      cmd(0).Enabled = False
   End If
   
   If Me.NivelAcceso > Nivel8 Then
      Label1(0).Visible = False
      Label1(1).Visible = False
      Label1(2).Visible = False
      Label1(5).Visible = False
      lblIVA1.Visible = False
      txtPorcentajeBonificacion.Visible = False
      txtSubtotal.Visible = False
      txtBonificacion.Visible = False
      txtNeto.Visible = False
      txtTotalIva1.Visible = False
      txtTotal(0).Visible = False
      rchObservaciones.Width = 9500
   End If

   If Not IsNull(origen.Registro.Fields("Cumplido").Value) And origen.Registro.Fields("Cumplido").Value = "AN" Then
      mvarAnulada = True
      cmd(0).Enabled = False
      cmd(2).Enabled = False
      cmd(3).Enabled = False
      For i = 0 To MnuDetA.Count - 1
         MnuDetA.Item(i).Enabled = False
      Next
      lblAnulada.Visible = True
      rchObservaciones.Height = rchObservaciones.Height / 2
      With rchMotivoAnulacion
         .Top = rchObservaciones.Top + rchObservaciones.Height
         .Left = rchObservaciones.Left
         .Width = rchObservaciones.Width
         .Height = rchObservaciones.Height
         .Visible = True
         .TextRTF = origen.Registro.Fields("MotivoAnulacion").Value
         .Text = mTextoAnulacion & "Motivo de anulacion : " & vbCrLf & .Text
      End With
   End If

   If HayAdjuntos Then
      cmd(5).BackColor = &HC0FFC0
   Else
      cmd(5).BackColor = &HC0C0FF
   End If
   
   If Not mvarImpresionHabilitada Then
      cmdImpre(0).Enabled = False
      cmdImpre(1).Enabled = False
      cmdImpre(4).Enabled = False
   End If
   
   CalculaPedido

End Property

Private Sub cmdAnularLiberacion_Click()

   If Not IsNull(origen.Registro.Fields("Aprobo").Value) Then
      Dim mvarOK As Boolean
      Dim oF As frmAutorizacion1
      Set oF = New frmAutorizacion1
      With oF
         .IdUsuario = mIdAprobo
         .Show vbModal, Me
      End With
      mvarOK = oF.Ok
      Unload oF
      Set oF = Nothing
      If mvarOK Then
         origen.Registro.Fields("Aprobo").Value = Null
         ActivarAnulacionLiberacion False
         cmd(0).Enabled = True
         cmd(3).Enabled = True
      End If
   End If

End Sub

Private Sub cmdImpre_Click(Index As Integer)

   If Not mvarGrabado Then
      MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
      Exit Sub
   End If
   
'   If Not AprobadoImpresion And Index <> 4 Then
'      MsgBox "Para emitir el pedido debe estar completo el circuito de autorizaciones", vbCritical
'      Exit Sub
'   End If
   
   If Index <> 4 And IsNull(origen.Registro.Fields("Aprobo").Value) Then
      If BuscarClaveINI("Permitir emision de pedido sin liberar") <> "SI" Then
         MsgBox "Para emitir el pedido debe estar liberado", vbCritical
         Exit Sub
      End If
   End If
   
   If Index <> 4 And Not CircuitoFirmasCompleto(NotaPedido, mvarId, txtTotal(0).Text) Then
      If BuscarClaveINI("Permitir emision de pedido sin liberar") <> "SI" Then
         MsgBox "Para emitir el pedido debe estar completo el circuito de autorizaciones", vbCritical
         Exit Sub
      End If
   End If
   
   On Error GoTo Mal
   
   Dim mResp As String
   If mNivelAcceso = 9 Then
      mResp = "S"
   ElseIf mNivelAcceso = 8 Then
      Do While True
         mResp = InputBox("Indique [C] para emitir el pedido con precios o [S] para no emitirlo", _
                           "Emision de pedido con o sin precio", "C")
         mResp = UCase(mResp)
         If mResp = "" Then
            Exit Sub
         ElseIf mResp = "C" Or mResp = "S" Then
            Exit Do
         End If
      Loop
   Else
      mResp = "C"
   End If
   
   Dim mvarOK As Boolean, mvarAgrupar As Integer, mvarBorrador As String, mRTF As String
   Dim of1 As frm_Aux
   
   If BuscarClaveINI("No preguntar por agrupacion de items de pedidos") <> "SI" And Not mAccesoParaMail And Not mAccesoParaMailInterno Then
      Set of1 = New frm_Aux
      With of1
         .Caption = "Emision de Nota de Pedido"
         .Label1.Visible = False
         .Text1.Visible = False
         With .Check1
            .Left = of1.Label1.Left
            .Top = of1.Label1.Top
            .Width = of1.Label1.Width * 2
            .Caption = "Agrupar items x articulo :"
            .Value = 1
            .Visible = True
         End With
         .Show vbModal, Me
         mvarOK = .Ok
         mvarAgrupar = .Check1.Value
      End With
      Unload of1
      Set of1 = Nothing
      Me.Refresh
      If Not mvarOK Then Exit Sub
   Else
      mvarAgrupar = 0
   End If
   
   Dim mCopias As Integer, mImprimirAdjuntos As String
   Dim mPrinter As String, mPrinterAnt As String
   mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   mImprimirAdjuntos = "NO"
   If Index = 0 Then
      mCopias = Val(BuscarClaveINI("CopiasPedidos"))
      If mCopias = 0 Then mCopias = 2
      Dim oF As frmCopiasImpresion
      Set oF = New frmCopiasImpresion
      With oF
         With .Check1
            .Caption = "Emitir documentos adjuntos :"
            .Value = 0
            .Visible = True
         End With
         .txtCopias.Text = mCopias
         .Frame1.Visible = False
         .Show vbModal, Me
      End With
      mvarOK = oF.Ok
      mCopias = Val(oF.txtCopias.Text)
      mPrinter = oF.Combo1.Text
      If oF.Check1.Value = 1 Then mImprimirAdjuntos = "SI"
      Unload oF
      Set oF = Nothing
      If Not mvarOK Then Exit Sub
   Else
      mCopias = 1
   End If
   
   mvarBorrador = "NO"
   If Index = 4 Then mvarBorrador = "SI"
   mRTF = ""
   If mAccesoParaMail Or mAccesoParaMailInterno Then mRTF = "RTF"
   
   ExportarDocumentos "Pedidos", mvarId, "|" & mResp & "|" & Index & "|||" & mCopias & "|||" & mvarAgrupar & "|" & _
                        mvarBorrador & "|" & mImprimirAdjuntos & "|" & mRTF & "|" & mPrinter
   Me.Refresh
   DoEvents
   Aplicacion.Tarea "Pedidos_RegistrarImpresion", Array(mvarId, "SI")
   
Salida:
   Exit Sub
   
Mal:
   MsgBox "Se ha producido un problema al tratar de imprimir" & vbCrLf & Err.Description, vbCritical
   Resume Salida

End Sub

Private Sub cmdPegar_Click()

   If mvarId > 0 And Not IsNull(origen.Registro.Fields("Aprobo").Value) Then
      MsgBox "El pedido ha sido cerrado, no puede modificarlo", vbCritical
      Exit Sub
   End If
   
   If Not Clipboard.GetFormat(vbCFText) Then
      MsgBox "No hay informacion en el portapapeles", vbCritical
      Exit Sub
   End If
   
   If mvarId > 0 And Not IsNull(origen.Registro.Fields("Aprobo").Value) Then
      MsgBox "El pedido ha sido cerrado, no puede modificarlo", vbCritical
      Exit Sub
   End If
   
   Dim s As String, mNroAco As String, mNroItmAco As String, mNroReq As String
   Dim mNroItmReq As String, mExiste As String, mCodigo As String, mArticulo As String
   Dim mTipoPrecio As String
   Dim iFilas As Long, iColumnas As Long, i As Long, mvarIdPre As Long, mvarIdReq As Long
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim Filas, Columnas

   On Error GoTo Mal
   
   s = Clipboard.GetText(vbCFText)
   
   Filas = Split(s, vbCrLf)
   Columnas = Split(Filas(LBound(Filas)), vbTab)
   
   If UBound(Columnas) < 2 Then
      MsgBox "No hay informacion para copiar", vbCritical
      Exit Sub
   End If
   
   mTipoPrecio = BuscarClaveINI("PrecioParaPedidos")
   
   If InStr(1, Columnas(0), "Acopio") <> 0 Then
   
      Set oAp = Aplicacion
      
      For iFilas = LBound(Filas) + 1 To UBound(Filas)
         Columnas = Split(Filas(iFilas), vbTab)
         Set oRs = oAp.TablasGenerales.TraerFiltrado("DetAcopios", "_UnItem", Columnas(0))
         If oRs.RecordCount > 0 Then
            Set oL = Lista.ListItems.Add()
            With origen.DetPedidos.Item(-1)
               .Registro.Fields("NumeroItem").Value = origen.DetPedidos.UltimoItemDetalle
               .Registro.Fields("Cantidad").Value = oRs.Fields("Cantidad").Value
               .Registro.Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
               .Registro.Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
               .Registro.Fields("IdControlCalidad").Value = IIf(IsNull(oRs.Fields("IdControlCalidad").Value), mvarIdControlCalidadStandar, oRs.Fields("IdControlCalidad").Value)
               .Registro.Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
               .Registro.Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
               .Registro.Fields("IdDetalleAcopios").Value = oRs.Fields("IdDetalleAcopios").Value
               .Registro.Fields("Cumplido").Value = "NO"
               .Registro.Fields("Adjunto").Value = oRs.Fields("Adjunto").Value
               .Registro.Fields("FechaNecesidad").Value = oRs.Fields("FechaNecesidad").Value
               .Registro.Fields("IdDetalleLMateriales").Value = oRs.Fields("IdDetalleLMateriales").Value
               .Registro.Fields("Precio").Value = 0
               .Registro.Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
               .Registro.Fields("OrigenDescripcion").Value = 1
               For i = 0 To 9
                  .Registro.Fields("ArchivoAdjunto" & i + 1).Value = oRs.Fields("ArchivoAdjunto" & i + 1).Value
               Next
               
               mNroAco = ""
               mNroItmAco = ""
               If Not IsNull(oRs.Fields("IdDetalleAcopios").Value) Then
                  Set oRs1 = oAp.TablasGenerales.TraerFiltrado("Acopios", "_DatosAcopio", oRs.Fields("IdDetalleAcopios").Value)
                  If oRs1.RecordCount > 0 Then
                     mNroAco = oRs1.Fields("NumeroAcopio").Value
                     mNroItmAco = oRs1.Fields("NumeroItem").Value
                  End If
                  oRs1.Close
               End If
               Set oRs1 = oAp.Articulos.TraerFiltrado("_PorId", oRs.Fields("IdArticulo").Value)
               mCodigo = IIf(IsNull(oRs1.Fields("Codigo").Value), "", oRs1.Fields("Codigo").Value)
               mArticulo = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
               .Registro.Fields("PorcentajeIVA").Value = oRs1.Fields("AlicuotaIVA").Value
               oRs1.Close
               oL.Tag = .Id
               oL.Text = "" & .Registro.Fields("NumeroItem").Value
               oL.SubItems(1) = "" & oRs.Fields("Cantidad").Value
               oL.SubItems(2) = "" & oRs.Fields("Cantidad1").Value
               oL.SubItems(3) = "" & oRs.Fields("Cantidad2").Value
               oL.SubItems(4) = "" & oAp.Unidades.Item(oRs.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
               If Not IsNull(.Registro.Fields("IdControlCalidad").Value) Then
                  oL.SubItems(5) = "" & oAp.ControlesCalidad.Item(.Registro.Fields("IdControlCalidad").Value).Registro.Fields("Descripcion").Value
               End If
               oL.SubItems(6) = "" & mCodigo
               oL.SubItems(7) = "" & mArticulo
               oL.SubItems(8) = ""
               oL.SubItems(9) = ""
               oL.SubItems(10) = ""
               oL.SubItems(11) = ""
               oL.SubItems(12) = ""
               oL.SubItems(13) = ""
               oL.SubItems(14) = ""
               oL.SubItems(15) = ""
               oL.SubItems(16) = ""
               oL.SubItems(17) = ""
               oL.SubItems(18) = "NO"
               oL.SubItems(20) = "" & mNroAco
               oL.SubItems(21) = "" & mNroItmAco
               oL.SubItems(22) = ""
               oL.SubItems(23) = ""
               oL.SmallIcon = "Nuevo"
               .Modificado = True
            
               mExiste = origen.ItemEnOtrosPedidos(oRs.Fields("IdDetalleAcopios").Value, "AC")
               If Len(mExiste) Then
                  MsgBox "Cuidado, el item del Acopio ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
               End If
            End With
            oRs.Close
         End If
      Next
      
   ElseIf InStr(1, Columnas(0), "Presupuesto") <> 0 Then
   
      Set oAp = Aplicacion
      
      For iFilas = LBound(Filas) + 1 To UBound(Filas)
         Columnas = Split(Filas(iFilas), vbTab)
         Set oRs = oAp.TablasGenerales.TraerFiltrado("DetPresupuestos", "_UnItem", Columnas(2))
         If oRs.RecordCount > 0 Then
            mvarIdPre = oRs.Fields("IdPresupuesto").Value
            Set oL = Lista.ListItems.Add()
            With origen.DetPedidos.Item(-1)
               .Registro.Fields("NumeroItem").Value = origen.DetPedidos.UltimoItemDetalle
               .Registro.Fields("Cantidad").Value = oRs.Fields("Cantidad").Value
               .Registro.Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
               .Registro.Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
               .Registro.Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
               .Registro.Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
               .Registro.Fields("Cumplido").Value = "NO"
               .Registro.Fields("Adjunto").Value = oRs.Fields("Adjunto").Value
               .Registro.Fields("Precio").Value = 0
               .Registro.Fields("IdDetalleAcopios").Value = oRs.Fields("IdDetalleAcopios").Value
               .Registro.Fields("IdDetalleRequerimiento").Value = oRs.Fields("IdDetalleRequerimiento").Value
               .Registro.Fields("IdDetalleLMateriales").Value = oRs.Fields("IdDetalleLMateriales").Value
               .Registro.Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
               .Registro.Fields("FechaEntrega").Value = oRs.Fields("FechaEntrega").Value
               .Registro.Fields("IdCentroCosto").Value = oRs.Fields("IdCentroCosto").Value
               .Registro.Fields("IdControlCalidad").Value = mvarIdControlCalidadStandar
               .Registro.Fields("OrigenDescripcion").Value = oRs.Fields("OrigenDescripcion").Value
               .Registro.Fields("PorcentajeIVA").Value = oRs.Fields("PorcentajeIVA").Value
               For i = 0 To 9
                  .Registro.Fields("ArchivoAdjunto" & i + 1).Value = oRs.Fields("ArchivoAdjunto" & i + 1).Value
               Next
               
               mNroAco = ""
               mNroItmAco = ""
               If Not IsNull(oRs.Fields("IdDetalleAcopios").Value) Then
                  Set oRs1 = oAp.TablasGenerales.TraerFiltrado("Acopios", "_DatosAcopio", oRs.Fields("IdDetalleAcopios").Value)
                  If oRs1.RecordCount > 0 Then
                     .Registro.Fields("IdControlCalidad").Value = oRs1.Fields("IdControlCalidad").Value
                     mNroAco = oRs1.Fields("NumeroAcopio").Value
                     mNroItmAco = oRs1.Fields("NumeroItem").Value
                  End If
                  oRs1.Close
               End If
               mNroReq = ""
               mNroItmReq = ""
               If Not IsNull(oRs.Fields("IdDetalleRequerimiento").Value) Then
                  Set oRs1 = oAp.Requerimientos.TraerFiltrado("_DatosRequerimiento", oRs.Fields("IdDetalleRequerimiento").Value)
                  If oRs1.RecordCount > 0 Then
                     .Registro.Fields("IdControlCalidad").Value = oRs1.Fields("IdControlCalidad").Value
                     mNroReq = oRs1.Fields("NumeroRequerimiento").Value
                     mNroItmReq = oRs1.Fields("NumeroItem").Value
                  End If
                  oRs1.Close
               End If
               Set oRs1 = oAp.Articulos.TraerFiltrado("_PorId", oRs.Fields("IdArticulo").Value)
               mCodigo = IIf(IsNull(oRs1.Fields("Codigo").Value), "", oRs1.Fields("Codigo").Value)
               mArticulo = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
               oRs1.Close
               oL.Tag = .Id
               oL.Text = "" & .Registro.Fields("NumeroItem").Value
               oL.SubItems(1) = "" & oRs.Fields("Cantidad").Value
               oL.SubItems(2) = "" & oRs.Fields("Cantidad1").Value
               oL.SubItems(3) = "" & oRs.Fields("Cantidad2").Value
               oL.SubItems(4) = "" & oAp.Unidades.Item(oRs.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
               oL.SubItems(5) = ""
               oL.SubItems(6) = "" & mCodigo
               oL.SubItems(7) = "" & mArticulo
               oL.SubItems(8) = "" & oRs.Fields("FechaEntrega").Value
               oL.SubItems(9) = ""
               oL.SubItems(10) = ""
               oL.SubItems(11) = ""
               oL.SubItems(12) = ""
               oL.SubItems(13) = ""
               oL.SubItems(14) = ""
               oL.SubItems(15) = ""
               oL.SubItems(16) = ""
               oL.SubItems(17) = ""
               oL.SubItems(18) = "NO"
               oL.SubItems(20) = "" & mNroAco
               oL.SubItems(21) = "" & mNroItmAco
               oL.SubItems(22) = "" & mNroReq
               oL.SubItems(23) = "" & mNroItmReq
               oL.SmallIcon = "Nuevo"
               .Modificado = True
            
               If Not IsNull(oRs.Fields("IdDetalleAcopios").Value) Then
                  mExiste = origen.ItemEnOtrosPedidos(oRs.Fields("IdDetalleAcopios").Value, "AC")
                  If Len(mExiste) Then
                     MsgBox "Cuidado, el item del Acopio ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
                  End If
               Else
                  If Not IsNull(oRs.Fields("IdDetalleRequerimiento").Value) Then
                     mExiste = origen.ItemEnOtrosPedidos(oRs.Fields("IdDetalleRequerimiento").Value, "RM")
                     If Len(mExiste) Then
                        MsgBox "Cuidado, el item de la RM ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
                     End If
                  End If
               End If
            End With
            oRs.Close
            With origen.Registro
               Set oRs = oAp.Presupuestos.Item(mvarIdPre).Registro
               If oRs.RecordCount > 0 Then
                  If IsNull(.Fields("IdProveedor").Value) Then
                     .Fields("IdProveedor").Value = oRs.Fields("IdProveedor").Value
                  End If
                  If IsNull(.Fields("LugarEntrega").Value) Then
                     .Fields("LugarEntrega").Value = oRs.Fields("LugarEntrega").Value
                  End If
                  If IsNull(.Fields("IdComprador").Value) Then
                     .Fields("IdComprador").Value = oRs.Fields("IdComprador").Value
                  End If
                  If IsNull(.Fields("DetalleCondicionCompra").Value) Then
                     .Fields("DetalleCondicionCompra").Value = oRs.Fields("DetalleCondicionCompra").Value
                  End If
                  For i = 0 To 9
                     .Fields("ArchivoAdjunto" & i + 1).Value = oRs.Fields("ArchivoAdjunto" & i + 1).Value
                  Next
                  If mvarId = -1 And Not IsNull(oRs.Fields("IdPlazoEntrega").Value) Then
                     Set oRs1 = Aplicacion.PlazosEntrega.TraerFiltrado("_PorId", oRs.Fields("IdPlazoEntrega").Value)
                     If oRs1.RecordCount > 0 Then
                        mvarPlazoEntrega = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
                     End If
                     oRs1.Close
                  End If
               End If
               oRs.Close
            End With
         End If
      Next
      
   ElseIf InStr(1, Columnas(0), "Requerimiento") <> 0 Then
   
      Set oAp = Aplicacion
      
      For iFilas = LBound(Filas) + 1 To UBound(Filas)
         Columnas = Split(Filas(iFilas), vbTab)
         Set oRs = oAp.Requerimientos.TraerFiltrado("_DatosRequerimiento", Columnas(0))
         If oRs.RecordCount > 0 Then
            If IsNull(oRs.Fields("Aprobo").Value) Then
               MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & " no fue liberado", vbExclamation
               oRs.Close
               GoTo Salida
            End If
            If IIf(IsNull(oRs.Fields("CumplidoReq").Value), "NO", oRs.Fields("CumplidoReq").Value) = "SI" Or _
                  IIf(IsNull(oRs.Fields("CumplidoReq").Value), "NO", oRs.Fields("CumplidoReq").Value) = "AN" Then
               MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & " ya esta cumplido", vbExclamation
               oRs.Close
               GoTo Salida
            End If
            If IIf(IsNull(oRs.Fields("Cumplido").Value), "NO", oRs.Fields("Cumplido").Value) = "SI" Or _
                  IIf(IsNull(oRs.Fields("Cumplido").Value), "NO", oRs.Fields("Cumplido").Value) = "AN" Then
               MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & _
                      " item " & oRs.Fields("NumeroItem").Value & " ya esta cumplido", vbExclamation
               oRs.Close
               GoTo Salida
            End If
            If IsNull(oRs.Fields("TipoDesignacion").Value) Or _
                  oRs.Fields("TipoDesignacion").Value = "CMP" Or _
                  (oRs.Fields("TipoDesignacion").Value = "STK" And _
                   oRs.Fields("SalidaPorVales").Value < IIf(IsNull(oRs.Fields("Cantidad").Value), 0, oRs.Fields("Cantidad").Value)) Then
               mvarIdReq = oRs.Fields("IdRequerimiento").Value
               Set oL = Lista.ListItems.Add()
               With origen.DetPedidos.Item(-1)
                  .Registro.Fields("NumeroItem").Value = origen.DetPedidos.UltimoItemDetalle
                  .Registro.Fields("Cantidad").Value = IIf(IsNull(oRs.Fields("Cantidad").Value), 0, oRs.Fields("Cantidad").Value) - _
                              IIf(IsNull(oRs.Fields("Pedido").Value), 0, oRs.Fields("Pedido").Value)
                  .Registro.Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                  .Registro.Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                  .Registro.Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
                  .Registro.Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
                  .Registro.Fields("Cumplido").Value = "NO"
                  .Registro.Fields("FechaEntrega").Value = Date
                  .Registro.Fields("FechaNecesidad").Value = oRs.Fields("FechaEntrega").Value
                  .Registro.Fields("Adjunto").Value = oRs.Fields("Adjunto").Value
                  .Registro.Fields("Precio").Value = 0
                  .Registro.Fields("IdDetalleRequerimiento").Value = oRs.Fields("IdDetalleRequerimiento").Value
                  .Registro.Fields("IdControlCalidad").Value = IIf(IsNull(oRs.Fields("IdControlCalidad").Value), mvarIdControlCalidadStandar, oRs.Fields("IdControlCalidad").Value)
                  .Registro.Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
                  .Registro.Fields("IdDetalleLMateriales").Value = oRs.Fields("IdDetalleLMateriales").Value
                  .Registro.Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
                  .Registro.Fields("IdCentroCosto").Value = oRs.Fields("IdCentroCosto").Value
                  .Registro.Fields("OrigenDescripcion").Value = IIf(IsNull(oRs.Fields("OrigenDescripcion").Value), 1, oRs.Fields("OrigenDescripcion").Value)
                  For i = 0 To 9
                     .Registro.Fields("ArchivoAdjunto" & i + 1).Value = oRs.Fields("ArchivoAdjunto" & i + 1).Value
                  Next
                  Set oRs1 = oAp.Articulos.TraerFiltrado("_PorId", oRs.Fields("IdArticulo").Value)
                  If oRs1.RecordCount > 0 Then
                     If mTipoPrecio = "CostoPPP" Then
                        .Registro.Fields("Precio").Value = IIf(IsNull(oRs1.Fields("CostoPPP").Value), 0, oRs1.Fields("CostoPPP").Value)
                     ElseIf mTipoPrecio = "CostoReposicion" Then
                        .Registro.Fields("Precio").Value = IIf(IsNull(oRs1.Fields("CostoReposicion").Value), 0, oRs1.Fields("CostoReposicion").Value)
                     End If
                  End If
                  oRs1.Close
                  
                  mNroReq = ""
                  mNroItmReq = ""
                  If Not IsNull(oRs.Fields("IdDetalleRequerimiento").Value) Then
                     Set oRs1 = oAp.Requerimientos.TraerFiltrado("_DatosRequerimiento", oRs.Fields("IdDetalleRequerimiento").Value)
                     If oRs1.RecordCount > 0 Then
                        mNroReq = oRs1.Fields("NumeroRequerimiento").Value
                        mNroItmReq = oRs1.Fields("NumeroItem").Value
                     End If
                     oRs1.Close
                  End If
                  mCodigo = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
                  mArticulo = IIf(IsNull(oRs.Fields("DescripcionArt").Value), "", oRs.Fields("DescripcionArt").Value)
                  .Registro.Fields("PorcentajeIVA").Value = oRs.Fields("AlicuotaIVA").Value
                  oL.Tag = .Id
                  oL.Text = "" & .Registro.Fields("NumeroItem").Value
                  oL.SubItems(1) = "" & .Registro.Fields("Cantidad").Value
                  oL.SubItems(2) = "" & oRs.Fields("Cantidad1").Value
                  oL.SubItems(3) = "" & oRs.Fields("Cantidad2").Value
                  oL.SubItems(4) = "" & oRs.Fields("Unidad").Value
                  If Not IsNull(oRs.Fields("IdControlCalidad").Value) Then
                     oL.SubItems(5) = "" & oRs.Fields("CC").Value
                  End If
                  oL.SubItems(6) = "" & mCodigo
                  oL.SubItems(7) = "" & mArticulo
                  oL.SubItems(8) = "" & oRs.Fields("FechaEntrega").Value
                  oL.SubItems(9) = "" & oRs.Fields("FechaEntrega").Value
                  oL.SubItems(10) = ""
                  oL.SubItems(11) = ""
                  oL.SubItems(12) = ""
                  oL.SubItems(13) = ""
                  oL.SubItems(14) = ""
                  oL.SubItems(15) = ""
                  oL.SubItems(16) = ""
                  oL.SubItems(17) = ""
                  oL.SubItems(18) = "NO"
                  oL.SubItems(19) = ""
                  oL.SubItems(20) = ""
                  oL.SubItems(21) = ""
                  oL.SubItems(22) = "" & mNroReq
                  oL.SubItems(23) = "" & mNroItmReq
                  oL.SmallIcon = "Nuevo"
                  .Modificado = True
               
                  mExiste = origen.ItemEnOtrosPedidos(oRs.Fields("IdDetalleRequerimiento").Value, "RM")
                  If Len(mExiste) Then
                     MsgBox "Cuidado, el item de la RM ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
                  End If
               End With
            End If
            oRs.Close
            With origen.Registro
               Set oRs = oAp.Requerimientos.Item(mvarIdReq).Registro
               If oRs.RecordCount > 0 Then
                  If IsNull(.Fields("IdComprador").Value) Then
                     .Fields("IdComprador").Value = oRs.Fields("IdComprador").Value
                  End If
               End If
               oRs.Close
            End With
         End If
      Next
      
   Else
      
      MsgBox "Objeto invalido!" & vbCrLf & "Solo puede copiar items de listas de acopio, requermiento y/o presupuestos", vbCritical
   
   End If
   
Salida:

   Clipboard.Clear
   
   Set oRs = Nothing
   Set oRs1 = Nothing
   Set oAp = Nothing
   
   Exit Sub
   
Mal:

   MsgBox "Se ha producido un problema al tratar de generar la solicitud" & vbCrLf & Err.Description, vbCritical
   Resume Salida
   
End Sub

Private Sub dcfields_Change(Index As Integer)
   
   Dim oRs As ADOR.Recordset
   Dim mCargaComparativa As Integer
   
   On Error GoTo Mal
   
   If IsNumeric(dcfields(Index).BoundText) Then
      Select Case Index
         Case 0
            origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
            DatosProveedor
            Set dcfields(5).RowSource = Aplicacion.PedidosAbiertos.TraerFiltrado("_PorProveedorParaCombo", dcfields(Index).BoundText)
            If Not IsNull(origen.Registro.Fields("IdPedidoAbierto").Value) Then
               dcfields(5).BoundText = origen.Registro.Fields("IdPedidoAbierto").Value
            End If
         
         Case 1
            origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
            Set oRs = Aplicacion.Empleados.TraerFiltrado("_PorId", dcfields(Index).BoundText)
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("Email").Value) Then
                  txtEmailComprador.Text = oRs.Fields("Email").Value
               End If
               If Not IsNull(oRs.Fields("Interno").Value) Then
                  txtTelefonoComprador.Text = oRs.Fields("Interno").Value
               End If
            End If
            oRs.Close
         
         Case 2
            origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
         
         Case 3
            If IsNull(origen.Registro.Fields(dcfields(Index).DataField).Value) Or _
                  origen.Registro.Fields(dcfields(Index).DataField).Value <> dcfields(Index).BoundText Then
               If Not IsNumeric(dcfields(Index).BoundText) Then
                  MsgBox "Elija una comparativa", vbExclamation
                  GoTo Salida
               End If
               mCargaComparativa = MsgBox("Desea cargar los datos desde la comparativa ?", vbYesNo)
               If mCargaComparativa = vbYes Then
                  TraerDesdeComparativa
               End If
            End If
         
         Case 4
            origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
            If dcfields(Index).BoundText = mvarIdMonedaPesos Then
               txtCotizacionMoneda.Text = 1
            Else
               Set oRs = Aplicacion.Cotizaciones.TraerFiltrado("_PorFechaMoneda", Array(DTFields(0).Value, dcfields(Index).BoundText))
               If oRs.RecordCount > 0 Then
                  txtCotizacionMoneda.Text = oRs.Fields("CotizacionLibre").Value
                  If dcfields(Index).BoundText = mvarIdMonedaDolar Then
                     txtCotizacionDolar = oRs.Fields("CotizacionLibre").Value
                  End If
               Else
                  If Me.Visible Then MsgBox "No hay cotizacion, ingresela manualmente"
                  txtCotizacionMoneda.Text = ""
               End If
               oRs.Close
               Set oRs = Nothing
            End If
         
         Case 5
            origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
         
         Case 7
            If IsNull(origen.Registro.Fields(dcfields(Index).DataField).Value) Or _
                  origen.Registro.Fields(dcfields(Index).DataField).Value <> dcfields(Index).BoundText Then
               origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
            End If
         
         Case 10
            If mvarId <= 0 Then
               Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(Index).BoundText)
               If oRs.RecordCount > 0 Then origen.Registro.Fields("NumeroPedido").Value = oRs.Fields("ProximoNumero").Value
               oRs.Close
            End If
      End Select
   Else
      If Index = 2 Or Index = 6 Then
         origen.Registro.Fields(dcfields(Index).DataField).Value = Null
      End If
   End If
   
Salida:

   Set oRs = Nothing
   
   Exit Sub
   
Mal:

   MsgBox "Se ha producido un problema, la operacion no se completo" & vbCrLf & Err.Description, vbCritical
   GoTo Salida
   
End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   If Index = 2 And Me.Visible And IsNumeric(dcfields(Index).BoundText) Then
      If dcfields(Index).BoundText <> mIdAprobo Then
         PideAutorizacion
      End If
   End If
   
End Sub

Private Sub dcfields_GotFocus(Index As Integer)
   
   If Index = 0 And mvarId = -1 Then
      With dcfields(Index)
         .SelStart = 0
         .SelLength = Len(.Text)
      End With
      SendKeys "%{DOWN}"
   End If

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Activate()
   
'   If mvarId > 0 Then
'      DatosProveedor
'      CalculaPedido
'   End If

'   lblIVA1.Caption = "IVA " & Format(mvarP_IVA1, "##0.00") & " %"
'   lblIVA2.Caption = "IVA " & Format(mvarP_IVA2, "##0.00") & " %"

   Dim mvarSale As Integer
   
   If mAccesoParaMail And Not mvarEnProceso Then
      Degradado Me
      Me.Refresh
      mvarEnProceso = True
'      mvarSale = MsgBox("Esta seguro de generar email ?", vbYesNo, "Enviar email")
'      If mvarSale = vbYes Then EnviarPedidoPorEmail
      EnviarPedidoPorEmail
      Unload Me
   Else
      If mvarCotizacion = 0 Then
         Me.Refresh
         If Me.Visible Then MsgBox "No hay cotizacion, ingresela primero", vbExclamation
         If mvarId <= 0 Then Unload Me
      End If
   End If
   
End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPeque�o = "Original"
   End With
   
'   For Each oI In Img16.ListImages
'      With Estado.Panels.Add(, , oI.Key)
'         .Picture = oI.Picture
'      End With
'   Next

   mvarTipoIVA = 0
   
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

Private Sub Lista_ItemClick(ByVal Item As MSComctlLib.IListItem)

   rchObservacionesItemVisible.TextRTF = ""
   If Not Item Is Nothing Then
      If Me.VisualizacionSimplificada Then
         If IsNumeric(Item.SubItems(1)) Then
            If Not IsNull(origen.DetPedidos.Item(Item.SubItems(1)).Registro.Fields("Observaciones").Value) Then
               rchObservacionesItemVisible.TextRTF = origen.DetPedidos.Item(Item.SubItems(1)).Registro.Fields("Observaciones").Value
            End If
         End If
      Else
         If IsNumeric(Item.SubItems(28)) Then
            If Not IsNull(origen.DetPedidos.Item(Item.SubItems(28)).Registro.Fields("Observaciones").Value) Then
               rchObservacionesItemVisible.TextRTF = origen.DetPedidos.Item(Item.SubItems(28)).Registro.Fields("Observaciones").Value
            End If
         End If
      End If
   End If

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

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton And Not Me.VisualizacionSimplificada Then
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

Private Sub Lista_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long, NroItem As Long, idDet As Long
   Dim mIdComprador As Long
   Dim mSubNumero As Integer
   Dim s As String, mExiste As String, mCodigo As String, mArticulo As String
   Dim mTipoCosto As String, mTipoPrecio As String
   Dim mImporte As Double, mCosto As Double
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oPre As ComPronto.Presupuesto
   Dim oPed As ComPronto.Pedido
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset

'   On Error GoTo Mal
   
   mTipoPrecio = BuscarClaveINI("PrecioParaPedidos")
   mTipoCosto = BuscarClaveINI("CostoStandarParaPedidos")
   If mTipoCosto = "" Then mTipoCosto = "CostoPPP"
   
   If Data.GetFormat(ccCFText) Then
      
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      If mvarId > 0 And Not IsNull(origen.Registro.Fields("Aprobo").Value) Then
         MsgBox "El pedido ha sido cerrado, no puede modificarlo", vbCritical
         Exit Sub
      End If
   
      If InStr(1, Columnas(LBound(Columnas) + 1), "Presupuesto") <> 0 Then
      
         If UBound(Filas) > 1 Then
            MsgBox "No puede arrastrar mas de un elemento a la vez", vbCritical
            Exit Sub
         End If
         
         Set oAp = Aplicacion
         
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            
            Columnas = Split(Filas(iFilas), vbTab)
            
            Set oPre = oAp.Presupuestos.Item(Columnas(19))
            Set oRs = oPre.Registro
            Set oRsDet = oPre.DetPresupuestos.TraerTodosSinFormato
            
            Do While Not oRsDet.EOF
               With origen.DetPedidos.Item(-1)
                  .Registro.Fields("NumeroItem").Value = oRsDet.Fields("NumeroItem").Value
                  .Registro.Fields("Cantidad").Value = oRsDet.Fields("Cantidad").Value
                  .Registro.Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                  .Registro.Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                  .Registro.Fields("Precio").Value = oRsDet.Fields("Precio").Value
                  .Registro.Fields("Adjunto").Value = oRsDet.Fields("Adjunto").Value
                  .Registro.Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
                  .Registro.Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
                  .Registro.Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
                  .Registro.Fields("IdDetalleAcopios").Value = oRsDet.Fields("IdDetalleAcopios").Value
                  .Registro.Fields("IdDetalleRequerimiento").Value = oRsDet.Fields("IdDetalleRequerimiento").Value
                  .Registro.Fields("IdCuenta").Value = oRsDet.Fields("IdCuenta").Value
                  .Registro.Fields("FechaEntrega").Value = oRsDet.Fields("FechaEntrega").Value
                  .Registro.Fields("IdCentroCosto").Value = oRsDet.Fields("IdCentroCosto").Value
                  .Registro.Fields("PorcentajeBonificacion").Value = oRsDet.Fields("PorcentajeBonificacion").Value
                  .Registro.Fields("ImporteBonificacion").Value = oRsDet.Fields("ImporteBonificacion").Value
                  .Registro.Fields("OrigenDescripcion").Value = oRsDet.Fields("OrigenDescripcion").Value
                  If Check2.Value = 0 Then
                     .Registro.Fields("PorcentajeIVA").Value = oRsDet.Fields("PorcentajeIVA").Value
                     .Registro.Fields("ImporteIVA").Value = oRsDet.Fields("ImporteIVA").Value
                  Else
                     .Registro.Fields("PorcentajeIVA").Value = 0
                     .Registro.Fields("ImporteIVA").Value = 0
                  End If
                  .Registro.Fields("ImporteTotalItem").Value = oRsDet.Fields("ImporteTotalItem").Value
                  .Registro.Fields("IdControlCalidad").Value = mvarIdControlCalidadStandar
                  For i = 0 To 9
                     .Registro.Fields("ArchivoAdjunto" & i + 1).Value = oRsDet.Fields("ArchivoAdjunto" & i + 1).Value
                  Next
                  
                  Set oRs1 = oAp.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdArticulo").Value)
                  mCodigo = IIf(IsNull(oRs1.Fields("Codigo").Value), "", oRs1.Fields("Codigo").Value)
                  mArticulo = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
                  If mTipoCosto = "CostoPPP" Then
                     mCosto = IIf(IsNull(oRs1.Fields("CostoPPP").Value), 0, oRs1.Fields("CostoPPP").Value)
                  Else
                     mCosto = IIf(IsNull(oRs1.Fields("CostoReposicion").Value), 0, oRs1.Fields("CostoReposicion").Value)
                  End If
                  .Registro.Fields("Costo").Value = mCosto
                  oRs1.Close
                  
                  .Modificado = True
                  idDet = .Id
                  If Not IsNull(oRsDet.Fields("IdDetalleAcopios").Value) Then
                     mExiste = origen.ItemEnOtrosPedidos(oRsDet.Fields("IdDetalleAcopios").Value, "AC")
                     If Len(mExiste) Then
                        MsgBox "Cuidado, el item del Acopio ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
                     End If
                     Set oRs1 = oAp.TablasGenerales.TraerFiltrado("Acopios", "_DatosAcopio", oRsDet.Fields("IdDetalleAcopios").Value)
                     If oRs1.RecordCount > 0 Then
                        If Not IsNull(oRs1.Fields("IdControlCalidad").Value) Then
                           .Registro.Fields("IdControlCalidad").Value = oRs1.Fields("IdControlCalidad").Value
                        End If
                     End If
                     oRs1.Close
                  Else
                     If Not IsNull(oRsDet.Fields("IdDetalleRequerimiento").Value) Then
                        mExiste = origen.ItemEnOtrosPedidos(oRsDet.Fields("IdDetalleRequerimiento").Value, "RM")
                        If Len(mExiste) Then
                           MsgBox "Cuidado, el item de la RM ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
                        End If
                        Set oRs1 = oAp.Requerimientos.TraerFiltrado("_DatosRequerimiento", oRsDet.Fields("IdDetalleRequerimiento").Value)
                        If oRs1.RecordCount > 0 Then
                           If Not IsNull(oRs1.Fields("IdControlCalidad").Value) Then
                              .Registro.Fields("IdControlCalidad").Value = oRs1.Fields("IdControlCalidad").Value
                           End If
                        End If
                        oRs1.Close
                     End If
                  End If
               End With
               With origen.Registro
                  .Fields("IdProveedor").Value = oRs.Fields("IdProveedor").Value
                  .Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
                  .Fields("PorcentajeBonificacion").Value = oRs.Fields("Bonificacion").Value
                  .Fields("Garantia").Value = oRs.Fields("Garantia").Value
                  .Fields("LugarEntrega").Value = oRs.Fields("LugarEntrega").Value
                  .Fields("IdComprador").Value = oRs.Fields("IdComprador").Value
                  .Fields("Contacto").Value = oRs.Fields("Contacto").Value
                  .Fields("Bonificacion").Value = oRs.Fields("ImporteBonificacion").Value
                  .Fields("TotalIva1").Value = oRs.Fields("ImporteIva1").Value
                  .Fields("TotalPedido").Value = oRs.Fields("ImporteTotal").Value
                  .Fields("PorcentajeIva1").Value = oRs.Fields("PorcentajeIva1").Value
                  .Fields("PorcentajeIva2").Value = oRs.Fields("PorcentajeIva2").Value
                  .Fields("DetalleCondicionCompra").Value = oRs.Fields("DetalleCondicionCompra").Value
                  For i = 0 To 9
                     .Fields("ArchivoAdjunto" & i + 1).Value = oRs.Fields("ArchivoAdjunto" & i + 1).Value
                  Next
               End With
               If mvarId = -1 And Not IsNull(oRs.Fields("IdPlazoEntrega").Value) Then
                  Set oRs1 = Aplicacion.PlazosEntrega.TraerFiltrado("_PorId", oRs.Fields("IdPlazoEntrega").Value)
                  If oRs1.RecordCount > 0 Then
                     mvarPlazoEntrega = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
                  End If
                  oRs1.Close
               End If
               Set oL = Lista.ListItems.Add
               oL.Tag = idDet
               With oL
                  .SmallIcon = "Nuevo"
                  .Text = oRsDet.Fields("NumeroItem").Value
                  .SubItems(1) = "" & oRsDet.Fields("Cantidad").Value
                  .SubItems(2) = "" & oRsDet.Fields("Cantidad1").Value
                  .SubItems(3) = "" & oRsDet.Fields("Cantidad2").Value
                  If Not IsNull(oRsDet.Fields("IdUnidad").Value) Then
                     .SubItems(4) = "" & oAp.Unidades.Item(oRsDet.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
                  End If
                  .SubItems(6) = "" & mCodigo
                  .SubItems(7) = "" & mArticulo
                  .SubItems(8) = "" & oRsDet.Fields("FechaEntrega").Value
                  .SubItems(9) = ""
                  If Not IsNull(oRsDet.Fields("Precio").Value) Then
                     .SubItems(10) = "" & Format(oRsDet.Fields("Precio").Value, "#0.0000")
                     .SubItems(11) = "" & Format(oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value, "#0.0000")
                  Else
                     .SubItems(10) = ""
                     .SubItems(11) = ""
                  End If
                  If Not IsNull(oRsDet.Fields("PorcentajeBonificacion").Value) Then
                     .SubItems(12) = "" & Format(oRsDet.Fields("PorcentajeBonificacion").Value, "Fixed")
                     .SubItems(13) = "" & Format(oRsDet.Fields("ImporteBonificacion").Value, "#0.0000")
                  Else
                     .SubItems(12) = ""
                     .SubItems(13) = ""
                     .SubItems(14) = "" & Format(oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value, "#0.0000")
                  End If
                  If Not IsNull(oRsDet.Fields("PorcentajeIVA").Value) And Check2.Value = 0 Then
                     .SubItems(15) = "" & Format(oRsDet.Fields("PorcentajeIVA").Value, "Fixed")
                     .SubItems(16) = "" & Format(oRsDet.Fields("ImporteIVA").Value, "#0.0000")
                  Else
                     .SubItems(15) = ""
                     .SubItems(16) = ""
                  End If
                  If Not IsNull(oRsDet.Fields("ImporteTotalItem").Value) Then
                     .SubItems(17) = "" & Format(oRsDet.Fields("ImporteTotalItem").Value, "#0.0000")
                  Else
                     .SubItems(17) = ""
                  End If
                  .SubItems(26) = "" & Format(mCosto, "#0.0000")
               End With
               oRsDet.MoveNext
            Loop
            
            oRs.Close
            oRsDet.Close
            
         Next
         
         CalculaPedido

      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "Pedido") <> 0 And _
            BuscarClaveINI("Inhabilitar arrastrar un pedido sobre otro") <> "SI" Then
      
         If UBound(Filas) > 1 Then
            MsgBox "No puede arrastrar mas de un elemento a la vez", vbCritical
            Exit Sub
         End If
         
         Set oAp = Aplicacion
         
         Columnas = Split(Filas(1), vbTab)
         
         Set oPed = oAp.Pedidos.Item(Columnas(17))
         Set oRs = oPed.Registro
         Set oRsDet = oPed.DetPedidos.TraerTodosSinFormato
                  
         With origen.Registro
            For i = 1 To oRs.Fields.Count - 1
               If (mvarId > 0 And oRs.Fields(i).Name <> "NumeroPedido") Or mvarId < 0 Then
                  .Fields(i).Value = oRs.Fields(i).Value
               End If
            Next
            .Fields("FechaPedido").Value = Date
            .Fields("NumeroComparativa").Value = Null
            .Fields("Aprobo").Value = Null
            .Fields("Cumplido").Value = "NO"
            .Fields("IdAutorizoCumplido").Value = Null
            .Fields("IdDioPorCumplido").Value = Null
            .Fields("FechaDadoPorCumplido").Value = Null
            .Fields("ObservacionesCumplido").Value = Null
            .Fields("UsuarioAnulacion").Value = Null
            .Fields("FechaAnulacion").Value = Null
            .Fields("MotivoAnulacion").Value = Null
            .Fields("CircuitoFirmasCompleto").Value = Null
         End With
   
         If mvarId < 0 Then
            Set oRs = oAp.Pedidos.TraerFiltrado("_PorNumeroBis", oRs.Fields("NumeroPedido").Value)
            If oRs.RecordCount > 0 Then
               mSubNumero = 0
               oRs.MoveFirst
               Do While Not oRs.EOF
                  If Not IsNull(oRs.Fields("SubNumero").Value) Then
                     mSubNumero = Max(mSubNumero, oRs.Fields("SubNumero").Value)
                  End If
                  oRs.MoveNext
               Loop
               oRs.Close
               mSubNumero = mSubNumero + 1
            End If
            origen.Registro.Fields("SubNumero").Value = mSubNumero
            txtNumeroPedido.Enabled = False
            txtSubnumero.Enabled = False
         End If
         
         Do While Not oRsDet.EOF
            With origen.DetPedidos.Item(-1)
               For i = 2 To oRsDet.Fields.Count - 1
                  If oRsDet.Fields(i).Name <> "Cumplido" And _
                        oRsDet.Fields(i).Name <> "IdAutorizoCumplido" And _
                        oRsDet.Fields(i).Name <> "IdDioPorCumplido" And _
                        oRsDet.Fields(i).Name <> "FechaDadoPorCumplido" And _
                        oRsDet.Fields(i).Name <> "ObservacionesCumplido" Then
                     .Registro.Fields(i).Value = oRsDet.Fields(i).Value
                  End If
               Next
               If Check2.Value = 1 Then
                  .Registro.Fields("PorcentajeIVA").Value = 0
                  .Registro.Fields("ImporteIVA").Value = 0
               End If
               .Modificado = True
               idDet = .Id
            End With
            Set oRs1 = oAp.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdArticulo").Value)
            mCodigo = IIf(IsNull(oRs1.Fields("Codigo").Value), "", oRs1.Fields("Codigo").Value)
            mArticulo = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
            oRs1.Close
            Set oL = Lista.ListItems.Add
            oL.Tag = idDet
            With oL
               .Text = oRsDet.Fields("NumeroItem").Value
               .SubItems(1) = "" & oRsDet.Fields("Cantidad").Value
               .SubItems(2) = "" & oRsDet.Fields("Cantidad1").Value
               .SubItems(3) = "" & oRsDet.Fields("Cantidad2").Value
               If Not IsNull(oRsDet.Fields("IdUnidad").Value) Then
                  .SubItems(4) = "" & oAp.Unidades.Item(oRsDet.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
               End If
               .SubItems(6) = "" & mCodigo
               .SubItems(7) = "" & mArticulo
               .SubItems(8) = "" & oRsDet.Fields("FechaEntrega").Value
               .SubItems(9) = "" & oRsDet.Fields("FechaNecesidad").Value
               If Not IsNull(oRsDet.Fields("Precio").Value) Then
                  .SubItems(10) = "" & Format(oRsDet.Fields("Precio").Value, "Fixed")
                  .SubItems(11) = "" & Format(oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value, "#0.0000")
               End If
               .SubItems(12) = "" & Format(oRsDet.Fields("PorcentajeBonificacion").Value, "Fixed")
               .SubItems(13) = "" & Format(oRsDet.Fields("ImporteBonificacion").Value, "#0.0000")
               .SubItems(14) = "" & Format((oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value) - oRsDet.Fields("ImporteBonificacion").Value, "#0.0000")
               If Check2.Value = 0 Then
                  .SubItems(15) = "" & Format(oRsDet.Fields("PorcentajeIVA").Value, "Fixed")
                  .SubItems(16) = "" & Format(oRsDet.Fields("ImporteIVA").Value, "#0.0000")
               End If
               .SubItems(17) = "" & Format(oRsDet.Fields("ImporteTotalItem").Value, "#0.0000")
               .SubItems(26) = "" & Format(oRsDet.Fields("Costo").Value, "#0.0000")
               .SmallIcon = "Nuevo"
            End With
            oRsDet.MoveNext
         Loop
         oRsDet.Close
         
         CalculaPedido

'         txtSubnumero.SetFocus
      
      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "Req.Nro.") <> 0 And _
            InStr(1, Columnas(LBound(Columnas) + 2), "Fecha") <> 0 Then
      
         If UBound(Filas) > 1 Then
            MsgBox "No puede arrastrar mas de un elemento a la vez", vbCritical
            Exit Sub
         End If
         
         Set oAp = Aplicacion
         
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            
            Columnas = Split(Filas(iFilas), vbTab)
            
            Set oRs = oAp.Requerimientos.TraerFiltrado("_PorId", Columnas(6))
            If oRs.RecordCount > 0 Then
               If IsNull(oRs.Fields("Aprobo").Value) Then
                  MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & " no fue liberado", vbExclamation
                  oRs.Close
                  GoTo Salida
               End If
               If IIf(IsNull(oRs.Fields("Cumplido").Value), "NO", oRs.Fields("Cumplido").Value) = "SI" Or _
                     IIf(IsNull(oRs.Fields("Cumplido").Value), "NO", oRs.Fields("Cumplido").Value) = "AN" Then
                  MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & " ya esta cumplido", vbExclamation
                  oRs.Close
                  GoTo Salida
               End If
            End If
            
            If Not CircuitoFirmasCompleto(RequerimientoMateriales, Columnas(6)) Then
               MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & " no tiene completo el circuito de firmas", vbExclamation
               oRs.Close
               GoTo Salida
            End If
            
            Set oRsDet = oAp.TablasGenerales.TraerFiltrado("DetRequerimientos", "_TodosConDatos", Columnas(6))
            
            If oRsDet.RecordCount > 0 Then
               oRsDet.MoveFirst
               Do While Not oRsDet.EOF
                  
                  If IsNull(oRsDet.Fields("Aprobo").Value) Then
                     MsgBox "El requerimiento " & oRsDet.Fields("NumeroRequerimiento").Value & " no fue liberado", vbExclamation
                     GoTo SalidaLoop
                  End If
'                  If IIf(IsNull(oRsDet.Fields("CumplidoReq").Value), "NO", oRsDet.Fields("CumplidoReq").Value) = "SI" Or _
'                        IIf(IsNull(oRsDet.Fields("CumplidoReq").Value), "NO", oRsDet.Fields("CumplidoReq").Value) = "AN" Then
'                     MsgBox "El requerimiento " & oRsDet.Fields("NumeroRequerimiento").Value & " ya esta cumplido", vbExclamation
'                     oRsDet.Close
'                     GoTo SalidaLoop
'                  End If
                  If Not CircuitoFirmasCompleto(RequerimientoMateriales, oRsDet.Fields("IdRequerimiento").Value) Then
                     MsgBox "El requerimiento " & oRsDet.Fields("NumeroRequerimiento").Value & " no tiene completo el circuito de firmas", vbExclamation
                     GoTo SalidaLoop
                  End If
                  If IIf(IsNull(oRsDet.Fields("Cumplido").Value), "NO", oRsDet.Fields("Cumplido").Value) = "SI" Or _
                        IIf(IsNull(oRsDet.Fields("Cumplido").Value), "NO", oRsDet.Fields("Cumplido").Value) = "AN" Then
                     MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & _
                            " item " & oRsDet.Fields("NumeroItem").Value & " ya esta cumplido", vbExclamation
                     GoTo SalidaLoop
                  End If
                  
                  If IsNull(oRsDet.Fields("TipoDesignacion").Value) Or _
                        oRsDet.Fields("TipoDesignacion").Value = "CMP" Or _
                        (oRsDet.Fields("TipoDesignacion").Value = "STK" And _
                         oRsDet.Fields("SalidaPorVales").Value < IIf(IsNull(oRsDet.Fields("Cantidad").Value), 0, oRsDet.Fields("Cantidad").Value)) Or _
                        (oRsDet.Fields("TipoDesignacion").Value = "REC" And _
                         oRs.Fields("IdObra").Value = mvarIdObraStockDisponible And _
                         oRsDet.Fields("SalidaPorVales").Value < IIf(IsNull(oRsDet.Fields("Cantidad").Value), 0, oRsDet.Fields("Cantidad").Value)) Then
                     Set oL = Lista.ListItems.Add()
                     With origen.DetPedidos.Item(-1)
                        .Registro.Fields("NumeroItem").Value = origen.DetPedidos.UltimoItemDetalle
                        If oRsDet.Fields("TipoDesignacion").Value = "STK" Then
                           .Registro.Fields("Cantidad").Value = IIf(IsNull(oRsDet.Fields("Cantidad").Value), 0, oRsDet.Fields("Cantidad").Value) - _
                                       oRsDet.Fields("SalidaPorVales").Value
                        Else
                           .Registro.Fields("Cantidad").Value = IIf(IsNull(oRsDet.Fields("Cantidad").Value), 0, oRsDet.Fields("Cantidad").Value) - _
                                       oRsDet.Fields("Pedido").Value
                        End If
                        .Registro.Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                        .Registro.Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                        .Registro.Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
                        .Registro.Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
                        .Registro.Fields("Cumplido").Value = "NO"
                        .Registro.Fields("FechaEntrega").Value = Date
                        .Registro.Fields("FechaNecesidad").Value = oRsDet.Fields("FechaEntrega").Value
                        .Registro.Fields("Adjunto").Value = oRsDet.Fields("Adjunto").Value
                        .Registro.Fields("Precio").Value = 0
                        .Registro.Fields("IdDetalleRequerimiento").Value = oRsDet.Fields("IdDetalleRequerimiento").Value
                        .Registro.Fields("IdControlCalidad").Value = IIf(IsNull(oRsDet.Fields("IdControlCalidad").Value), mvarIdControlCalidadStandar, oRsDet.Fields("IdControlCalidad").Value)
                        .Registro.Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
                        .Registro.Fields("IdDetalleLMateriales").Value = oRsDet.Fields("IdDetalleLMateriales").Value
                        .Registro.Fields("IdCuenta").Value = oRsDet.Fields("IdCuenta").Value
                        .Registro.Fields("IdCentroCosto").Value = oRsDet.Fields("IdCentroCosto").Value
                        .Registro.Fields("OrigenDescripcion").Value = IIf(IsNull(oRsDet.Fields("OrigenDescripcion").Value), 1, oRsDet.Fields("OrigenDescripcion").Value)
                        For i = 0 To 9
                           .Registro.Fields("ArchivoAdjunto" & i + 1).Value = oRsDet.Fields("ArchivoAdjunto" & i + 1).Value
                        Next
                        
                        Set oRs1 = oAp.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdArticulo").Value)
                        mCodigo = IIf(IsNull(oRs1.Fields("Codigo").Value), "", oRs1.Fields("Codigo").Value)
                        mArticulo = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
                        .Registro.Fields("PorcentajeIVA").Value = oRs1.Fields("AlicuotaIVA").Value
                        If mTipoCosto = "CostoPPP" Then
                           mCosto = IIf(IsNull(oRs1.Fields("CostoPPP").Value), 0, oRs1.Fields("CostoPPP").Value)
                        Else
                           mCosto = IIf(IsNull(oRs1.Fields("CostoReposicion").Value), 0, oRs1.Fields("CostoReposicion").Value)
                        End If
                        .Registro.Fields("Costo").Value = mCosto
                        If mTipoPrecio = "CostoPPP" Then
                           .Registro.Fields("Precio").Value = IIf(IsNull(oRs1.Fields("CostoPPP").Value), 0, oRs1.Fields("CostoPPP").Value)
                        ElseIf mTipoPrecio = "CostoReposicion" Then
                           .Registro.Fields("Precio").Value = IIf(IsNull(oRs1.Fields("CostoReposicion").Value), 0, oRs1.Fields("CostoReposicion").Value)
                        End If
                        If Check2.Value = 1 Then
                           .Registro.Fields("PorcentajeIVA").Value = 0
                           .Registro.Fields("ImporteIVA").Value = 0
                        End If
                        oRs1.Close
                        
                        oL.Tag = .Id
                        oL.Text = "" & .Registro.Fields("NumeroItem").Value
                        oL.SubItems(1) = "" & oRsDet.Fields("Cantidad").Value
                        oL.SubItems(2) = "" & oRsDet.Fields("Cantidad1").Value
                        oL.SubItems(3) = "" & oRsDet.Fields("Cantidad2").Value
                        If Not IsNull(oRsDet.Fields("IdUnidad").Value) Then
                           oL.SubItems(4) = "" & oAp.Unidades.Item(oRsDet.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
                        End If
                        If Not IsNull(oRsDet.Fields("IdControlCalidad").Value) Then
                           oL.SubItems(5) = "" & oAp.ControlesCalidad.Item(oRsDet.Fields("IdControlCalidad").Value).Registro.Fields("Descripcion").Value
                        End If
                        oL.SubItems(6) = "" & mCodigo
                        oL.SubItems(7) = "" & mArticulo
                        oL.SubItems(8) = "" & oRsDet.Fields("FechaEntrega").Value
                        oL.SubItems(9) = "" & oRsDet.Fields("FechaEntrega").Value
                        oL.SubItems(10) = ""
                        oL.SubItems(11) = ""
                        oL.SubItems(12) = ""
                        oL.SubItems(13) = ""
                        oL.SubItems(14) = ""
                        oL.SubItems(15) = ""
                        oL.SubItems(16) = ""
                        oL.SubItems(17) = ""
                        oL.SubItems(18) = "NO"
                        oL.SubItems(19) = ""
                        oL.SubItems(20) = ""
                        oL.SubItems(21) = ""
                        oL.SubItems(22) = "" & oRs.Fields("NumeroRequerimiento").Value
                        oL.SubItems(23) = "" & oRsDet.Fields("NumeroItem").Value
                        oL.SubItems(26) = "" & Format(mCosto, "#0.0000")
                        oL.SmallIcon = "Nuevo"
                        .Modificado = True
                     
                        mExiste = origen.ItemEnOtrosPedidos(oRsDet.Fields("IdDetalleRequerimiento").Value, "RM")
                        If Len(mExiste) Then
                           MsgBox "Cuidado, el item de la RM ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
                        End If
                     End With
                  End If
SalidaLoop:
                  oRsDet.MoveNext
               Loop
               oRsDet.Close
               
               With origen.Registro
                  If IsNull(.Fields("IdComprador").Value) Then
                     .Fields("IdComprador").Value = oRs.Fields("IdComprador").Value
                  End If
                  oRs.Close
               End With
            End If
         Next
         
         CalculaPedido

      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "Numero Req.") <> 0 And _
            InStr(1, Columnas(LBound(Columnas) + 3), "Fecha") <> 0 Then
      
         If UBound(Filas) > 1 Then
            MsgBox "No puede arrastrar mas de un elemento a la vez", vbCritical
            Exit Sub
         End If
         
         Set oAp = Aplicacion
         
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            
            Columnas = Split(Filas(iFilas), vbTab)
            
            Set oRs = oAp.Requerimientos.TraerFiltrado("_PorId", Columnas(2))
            If oRs.RecordCount > 0 Then
               If IsNull(oRs.Fields("Aprobo").Value) Then
                  MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & " no fue liberado", vbExclamation
                  oRs.Close
                  GoTo Salida
               End If
               If IIf(IsNull(oRs.Fields("Cumplido").Value), "NO", oRs.Fields("Cumplido").Value) = "SI" Or _
                     IIf(IsNull(oRs.Fields("Cumplido").Value), "NO", oRs.Fields("Cumplido").Value) = "AN" Then
                  MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & " ya esta cumplido", vbExclamation
                  oRs.Close
                  GoTo Salida
               End If
            End If
            
            If Not CircuitoFirmasCompleto(RequerimientoMateriales, Columnas(2)) Then
               MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & " no tiene completo el circuito de firmas", vbExclamation
               oRs.Close
               GoTo Salida
            End If
            
            Set oRsDet = oAp.TablasGenerales.TraerFiltrado("DetRequerimientos", "_TodosConDatos", Columnas(2))
            
            If oRsDet.RecordCount > 0 Then
               oRsDet.MoveFirst
               Do While Not oRsDet.EOF
                  
                  If IsNull(oRsDet.Fields("Aprobo").Value) Then
                     MsgBox "El requerimiento " & oRsDet.Fields("NumeroRequerimiento").Value & " no fue liberado", vbExclamation
                     GoTo SalidaLoop1
                  End If
'                  If IIf(IsNull(oRsDet.Fields("CumplidoReq").Value), "NO", oRsDet.Fields("CumplidoReq").Value) = "SI" Or _
'                        IIf(IsNull(oRsDet.Fields("CumplidoReq").Value), "NO", oRsDet.Fields("CumplidoReq").Value) = "AN" Then
'                     MsgBox "El requerimiento " & oRsDet.Fields("NumeroRequerimiento").Value & " ya esta cumplido", vbExclamation
'                     oRsDet.Close
'                     GoTo SalidaLoop1
'                  End If
                  If Not CircuitoFirmasCompleto(RequerimientoMateriales, oRsDet.Fields("IdRequerimiento").Value) Then
                     MsgBox "El requerimiento " & oRsDet.Fields("NumeroRequerimiento").Value & " no tiene completo el circuito de firmas", vbExclamation
                     GoTo SalidaLoop1
                  End If
                  If IIf(IsNull(oRsDet.Fields("Cumplido").Value), "NO", oRsDet.Fields("Cumplido").Value) = "SI" Or _
                        IIf(IsNull(oRsDet.Fields("Cumplido").Value), "NO", oRsDet.Fields("Cumplido").Value) = "AN" Then
                     MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & _
                            " item " & oRsDet.Fields("NumeroItem").Value & " ya esta cumplido", vbExclamation
                     GoTo SalidaLoop1
                  End If
                  
                  If IsNull(oRsDet.Fields("TipoDesignacion").Value) Or _
                        oRsDet.Fields("TipoDesignacion").Value = "CMP" Or _
                        (oRsDet.Fields("TipoDesignacion").Value = "STK" And _
                         oRsDet.Fields("SalidaPorVales").Value < IIf(IsNull(oRsDet.Fields("Cantidad").Value), 0, oRsDet.Fields("Cantidad").Value)) Or _
                        (oRsDet.Fields("TipoDesignacion").Value = "REC" And _
                         oRs.Fields("IdObra").Value = mvarIdObraStockDisponible And _
                         oRsDet.Fields("SalidaPorVales").Value < IIf(IsNull(oRsDet.Fields("Cantidad").Value), 0, oRsDet.Fields("Cantidad").Value)) Then
                     Set oL = Lista.ListItems.Add()
                     With origen.DetPedidos.Item(-1)
                        .Registro.Fields("NumeroItem").Value = origen.DetPedidos.UltimoItemDetalle
                        If oRsDet.Fields("TipoDesignacion").Value = "STK" Then
                           .Registro.Fields("Cantidad").Value = IIf(IsNull(oRsDet.Fields("Cantidad").Value), 0, oRsDet.Fields("Cantidad").Value) - _
                                       oRsDet.Fields("SalidaPorVales").Value
                        Else
                           .Registro.Fields("Cantidad").Value = IIf(IsNull(oRsDet.Fields("Cantidad").Value), 0, oRsDet.Fields("Cantidad").Value) - _
                                       oRsDet.Fields("Pedido").Value
                        End If
                        .Registro.Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                        .Registro.Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                        .Registro.Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
                        .Registro.Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
                        .Registro.Fields("Cumplido").Value = "NO"
                        .Registro.Fields("FechaEntrega").Value = Date
                        .Registro.Fields("FechaNecesidad").Value = oRsDet.Fields("FechaEntrega").Value
                        .Registro.Fields("Adjunto").Value = oRsDet.Fields("Adjunto").Value
                        .Registro.Fields("Precio").Value = 0
                        .Registro.Fields("IdDetalleRequerimiento").Value = oRsDet.Fields("IdDetalleRequerimiento").Value
                        .Registro.Fields("IdControlCalidad").Value = IIf(IsNull(oRsDet.Fields("IdControlCalidad").Value), mvarIdControlCalidadStandar, oRsDet.Fields("IdControlCalidad").Value)
                        .Registro.Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
                        .Registro.Fields("IdDetalleLMateriales").Value = oRsDet.Fields("IdDetalleLMateriales").Value
                        .Registro.Fields("IdCuenta").Value = oRsDet.Fields("IdCuenta").Value
                        .Registro.Fields("IdCentroCosto").Value = oRsDet.Fields("IdCentroCosto").Value
                        .Registro.Fields("OrigenDescripcion").Value = IIf(IsNull(oRsDet.Fields("OrigenDescripcion").Value), 1, oRsDet.Fields("OrigenDescripcion").Value)
                        For i = 0 To 9
                           .Registro.Fields("ArchivoAdjunto" & i + 1).Value = oRsDet.Fields("ArchivoAdjunto" & i + 1).Value
                        Next
                        
                        Set oRs1 = oAp.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdArticulo").Value)
                        mCodigo = IIf(IsNull(oRs1.Fields("Codigo").Value), "", oRs1.Fields("Codigo").Value)
                        mArticulo = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
                        .Registro.Fields("PorcentajeIVA").Value = oRs1.Fields("AlicuotaIVA").Value
                        If mTipoCosto = "CostoPPP" Then
                           mCosto = IIf(IsNull(oRs1.Fields("CostoPPP").Value), 0, oRs1.Fields("CostoPPP").Value)
                        Else
                           mCosto = IIf(IsNull(oRs1.Fields("CostoReposicion").Value), 0, oRs1.Fields("CostoReposicion").Value)
                        End If
                        .Registro.Fields("Costo").Value = mCosto
                        If mTipoPrecio = "CostoPPP" Then
                           .Registro.Fields("Precio").Value = IIf(IsNull(oRs1.Fields("CostoPPP").Value), 0, oRs1.Fields("CostoPPP").Value)
                        ElseIf mTipoPrecio = "CostoReposicion" Then
                           .Registro.Fields("Precio").Value = IIf(IsNull(oRs1.Fields("CostoReposicion").Value), 0, oRs1.Fields("CostoReposicion").Value)
                        End If
                        If Check2.Value = 1 Then
                           .Registro.Fields("PorcentajeIVA").Value = 0
                           .Registro.Fields("ImporteIVA").Value = 0
                        End If
                        oRs1.Close
                        
                        oL.Tag = .Id
                        oL.Text = "" & .Registro.Fields("NumeroItem").Value
                        oL.SubItems(1) = "" & oRsDet.Fields("Cantidad").Value
                        oL.SubItems(2) = "" & oRsDet.Fields("Cantidad1").Value
                        oL.SubItems(3) = "" & oRsDet.Fields("Cantidad2").Value
                        If Not IsNull(oRsDet.Fields("IdUnidad").Value) Then
                           oL.SubItems(4) = "" & oAp.Unidades.Item(oRsDet.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
                        End If
                        If Not IsNull(oRsDet.Fields("IdControlCalidad").Value) Then
                           oL.SubItems(5) = "" & oAp.ControlesCalidad.Item(oRsDet.Fields("IdControlCalidad").Value).Registro.Fields("Descripcion").Value
                        End If
                        oL.SubItems(6) = "" & mCodigo
                        oL.SubItems(7) = "" & mArticulo
                        oL.SubItems(8) = "" & oRsDet.Fields("FechaEntrega").Value
                        oL.SubItems(9) = "" & oRsDet.Fields("FechaEntrega").Value
                        oL.SubItems(10) = ""
                        oL.SubItems(11) = ""
                        oL.SubItems(12) = ""
                        oL.SubItems(13) = ""
                        oL.SubItems(14) = ""
                        oL.SubItems(15) = ""
                        oL.SubItems(16) = ""
                        oL.SubItems(17) = ""
                        oL.SubItems(18) = "NO"
                        oL.SubItems(19) = ""
                        oL.SubItems(20) = ""
                        oL.SubItems(21) = ""
                        oL.SubItems(22) = "" & oRs.Fields("NumeroRequerimiento").Value
                        oL.SubItems(23) = "" & oRsDet.Fields("NumeroItem").Value
                        oL.SubItems(26) = "" & Format(mCosto, "#0.0000")
                        oL.SmallIcon = "Nuevo"
                        .Modificado = True
                     
                        mExiste = origen.ItemEnOtrosPedidos(oRsDet.Fields("IdDetalleRequerimiento").Value, "RM")
                        If Len(mExiste) Then
                           MsgBox "Cuidado, el item de la RM ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
                        End If
                     End With
                  End If
SalidaLoop1:
                  oRsDet.MoveNext
               Loop
               oRsDet.Close
               
               With origen.Registro
                  If IsNull(.Fields("IdComprador").Value) Then
                     .Fields("IdComprador").Value = oRs.Fields("IdComprador").Value
                  End If
                  oRs.Close
               End With
            End If
         Next
         
         CalculaPedido

      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "solicitud") <> 0 Then
      
         If UBound(Filas) > 1 Then
            MsgBox "No puede arrastrar mas de un elemento a la vez", vbCritical
            Exit Sub
         End If
         
         Set oAp = Aplicacion
         
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            
            Columnas = Split(Filas(iFilas), vbTab)
            
            mIdComprador = 0

            Set oRsDet = oAp.TablasGenerales.TraerFiltrado("DetSolicitudesCompra", "_Datos", Columnas(2))
            
            If oRsDet.RecordCount > 0 Then
               oRsDet.MoveFirst
               Do While Not oRsDet.EOF
                  Set oL = Lista.ListItems.Add()
                  With origen.DetPedidos.Item(-1)
                     .Registro.Fields("NumeroItem").Value = origen.DetPedidos.UltimoItemDetalle
                     .Registro.Fields("Cantidad").Value = oRsDet.Fields("CantSol").Value
                     .Registro.Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                     .Registro.Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                     .Registro.Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
                     .Registro.Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
                     .Registro.Fields("Cumplido").Value = "NO"
                     .Registro.Fields("FechaEntrega").Value = Date
                     .Registro.Fields("FechaNecesidad").Value = oRsDet.Fields("FechaEntrega").Value
                     .Registro.Fields("Adjunto").Value = oRsDet.Fields("Adjunto").Value
                     .Registro.Fields("Precio").Value = 0
                     .Registro.Fields("IdDetalleRequerimiento").Value = oRsDet.Fields("IdDetalleRequerimiento").Value
                     .Registro.Fields("IdControlCalidad").Value = IIf(IsNull(oRsDet.Fields("IdControlCalidad").Value), mvarIdControlCalidadStandar, oRsDet.Fields("IdControlCalidad").Value)
                     .Registro.Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
                     .Registro.Fields("IdDetalleLMateriales").Value = oRsDet.Fields("IdDetalleLMateriales").Value
                     .Registro.Fields("IdCuenta").Value = oRsDet.Fields("IdCuenta").Value
                     .Registro.Fields("IdCentroCosto").Value = oRsDet.Fields("IdCentroCosto").Value
                     .Registro.Fields("OrigenDescripcion").Value = 1
                     For i = 0 To 9
                        .Registro.Fields("ArchivoAdjunto" & i + 1).Value = oRsDet.Fields("ArchivoAdjunto" & i + 1).Value
                     Next
                     
                     Set oRs1 = oAp.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdArticulo").Value)
                     mCodigo = IIf(IsNull(oRs1.Fields("Codigo").Value), "", oRs1.Fields("Codigo").Value)
                     mArticulo = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
                     .Registro.Fields("PorcentajeIVA").Value = oRs1.Fields("AlicuotaIVA").Value
                     If mTipoCosto = "CostoPPP" Then
                        mCosto = IIf(IsNull(oRs1.Fields("CostoPPP").Value), 0, oRs1.Fields("CostoPPP").Value)
                     Else
                        mCosto = IIf(IsNull(oRs1.Fields("CostoReposicion").Value), 0, oRs1.Fields("CostoReposicion").Value)
                     End If
                     .Registro.Fields("Costo").Value = mCosto
                     If Check2.Value = 1 Then
                        .Registro.Fields("PorcentajeIVA").Value = 0
                        .Registro.Fields("ImporteIVA").Value = 0
                     End If
                     oRs1.Close
                     
                     oL.Tag = .Id
                     oL.Text = "" & .Registro.Fields("NumeroItem").Value
                     oL.SubItems(1) = "" & oRsDet.Fields("Cantidad").Value
                     oL.SubItems(2) = "" & oRsDet.Fields("Cantidad1").Value
                     oL.SubItems(3) = "" & oRsDet.Fields("Cantidad2").Value
                     oL.SubItems(4) = "" & oAp.Unidades.Item(oRsDet.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
                     If Not IsNull(oRsDet.Fields("IdControlCalidad").Value) Then
                        oL.SubItems(5) = "" & oAp.ControlesCalidad.Item(oRsDet.Fields("IdControlCalidad").Value).Registro.Fields("Descripcion").Value
                     End If
                     oL.SubItems(6) = "" & mCodigo
                     oL.SubItems(7) = "" & mArticulo
                     oL.SubItems(8) = "" & oRsDet.Fields("FechaEntrega").Value
                     oL.SubItems(9) = "" & oRsDet.Fields("FechaEntrega").Value
                     oL.SubItems(10) = ""
                     oL.SubItems(11) = ""
                     oL.SubItems(12) = ""
                     oL.SubItems(13) = ""
                     oL.SubItems(14) = ""
                     oL.SubItems(15) = ""
                     oL.SubItems(16) = ""
                     oL.SubItems(17) = ""
                     oL.SubItems(18) = "NO"
                     oL.SubItems(19) = ""
                     oL.SubItems(20) = ""
                     oL.SubItems(21) = ""
                     oL.SubItems(22) = "" & oRsDet.Fields("NumeroRequerimiento").Value
                     oL.SubItems(23) = "" & oRsDet.Fields("NumeroItem").Value
                     oL.SubItems(26) = "" & Format(mCosto, "#0.0000")
                     oL.SmallIcon = "Nuevo"
                     .Modificado = True
                  
                     mExiste = origen.ItemEnOtrosPedidos(oRsDet.Fields("IdDetalleRequerimiento").Value, "RM")
                     If Len(mExiste) Then
                        MsgBox "Cuidado, el item de la RM ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
                     End If
                  End With
                  
                  If mIdComprador = 0 And Not IsNull(oRsDet.Fields("IdComprador").Value) Then
                     mIdComprador = oRsDet.Fields("IdComprador").Value
                  End If
                  
                  oRsDet.MoveNext
               Loop
               
               With origen.Registro
                  If IsNull(.Fields("IdComprador").Value) Then
                     .Fields("IdComprador").Value = mIdComprador
                  End If
               End With
               oRsDet.Close
            End If
         Next
         
         CalculaPedido

      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "Req.Nro.") <> 0 And _
            InStr(1, Columnas(LBound(Columnas) + 2), "Item") <> 0 Then
      
         Set oAp = Aplicacion
         
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            
            Columnas = Split(Filas(iFilas), vbTab)
            
            Set oRsDet = oAp.Requerimientos.TraerFiltrado("_DatosRequerimiento", Columnas(24))
            With oRsDet
               If .RecordCount > 0 Then
                  If IsNull(.Fields("Aprobo").Value) Then
                     MsgBox "El requerimiento " & .Fields("NumeroRequerimiento").Value & " no fue liberado", vbExclamation
                     .Close
                     GoTo SalidaFor
                  End If
                  If IIf(IsNull(.Fields("CumplidoReq").Value), "NO", .Fields("CumplidoReq").Value) = "SI" Or _
                        IIf(IsNull(.Fields("CumplidoReq").Value), "NO", .Fields("CumplidoReq").Value) = "AN" Then
                     MsgBox "El requerimiento " & .Fields("NumeroRequerimiento").Value & " ya esta cumplido", vbExclamation
                     .Close
                     GoTo SalidaFor
                  End If
                  If Not CircuitoFirmasCompleto(RequerimientoMateriales, .Fields("IdRequerimiento").Value) Then
                     MsgBox "El requerimiento " & .Fields("NumeroRequerimiento").Value & " no tiene completo el circuito de firmas", vbExclamation
                     .Close
                     GoTo SalidaFor
                  End If
                  If IIf(IsNull(.Fields("Cumplido").Value), "NO", .Fields("Cumplido").Value) = "SI" Or _
                        IIf(IsNull(.Fields("Cumplido").Value), "NO", .Fields("Cumplido").Value) = "AN" Then
                     MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & _
                            " item " & .Fields("NumeroItem").Value & " ya esta cumplido", vbExclamation
                     .Close
                     GoTo SalidaFor
                  End If
                     
                  With origen.Registro
                     If IsNull(.Fields("IdComprador").Value) Then
                        .Fields("IdComprador").Value = oRsDet.Fields("IdComprador").Value
                     End If
                  End With
                  
                  If IsNull(.Fields("TipoDesignacion").Value) Or _
                        .Fields("TipoDesignacion").Value = "CMP" Or _
                        (.Fields("TipoDesignacion").Value = "STK" And _
                         .Fields("SalidaPorVales").Value < IIf(IsNull(.Fields("Cantidad").Value), 0, .Fields("Cantidad").Value)) Or _
                        (.Fields("TipoDesignacion").Value = "REC" And _
                         .Fields("IdObra").Value = mvarIdObraStockDisponible And _
                         .Fields("SalidaPorVales").Value < IIf(IsNull(.Fields("Cantidad").Value), 0, .Fields("Cantidad").Value)) Then
                     Set oL = Lista.ListItems.Add()
                     With origen.DetPedidos.Item(-1)
                        .Registro.Fields("NumeroItem").Value = origen.DetPedidos.UltimoItemDetalle
                        If oRsDet.Fields("TipoDesignacion").Value = "STK" Then
                           .Registro.Fields("Cantidad").Value = IIf(IsNull(oRsDet.Fields("Cantidad").Value), 0, oRsDet.Fields("Cantidad").Value) - _
                                       oRsDet.Fields("SalidaPorVales").Value
                        Else
                           .Registro.Fields("Cantidad").Value = IIf(IsNull(oRsDet.Fields("Cantidad").Value), 0, oRsDet.Fields("Cantidad").Value) - _
                                       oRsDet.Fields("Pedido").Value
                        End If
                        .Registro.Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                        .Registro.Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                        .Registro.Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
                        .Registro.Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
                        .Registro.Fields("Cumplido").Value = "NO"
                        .Registro.Fields("FechaEntrega").Value = Date
                        .Registro.Fields("FechaNecesidad").Value = oRsDet.Fields("FechaEntrega").Value
                        .Registro.Fields("Adjunto").Value = oRsDet.Fields("Adjunto").Value
                        .Registro.Fields("Precio").Value = 0
                        .Registro.Fields("IdDetalleRequerimiento").Value = oRsDet.Fields("IdDetalleRequerimiento").Value
                        .Registro.Fields("IdControlCalidad").Value = IIf(IsNull(oRsDet.Fields("IdControlCalidad").Value), mvarIdControlCalidadStandar, oRsDet.Fields("IdControlCalidad").Value)
                        .Registro.Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
                        .Registro.Fields("IdDetalleLMateriales").Value = oRsDet.Fields("IdDetalleLMateriales").Value
                        .Registro.Fields("IdCuenta").Value = oRsDet.Fields("IdCuenta").Value
                        .Registro.Fields("IdCentroCosto").Value = oRsDet.Fields("IdCentroCosto").Value
                        .Registro.Fields("OrigenDescripcion").Value = IIf(IsNull(oRsDet.Fields("OrigenDescripcion").Value), 1, oRsDet.Fields("OrigenDescripcion").Value)
                        For i = 0 To 9
                           .Registro.Fields("ArchivoAdjunto" & i + 1).Value = oRsDet.Fields("ArchivoAdjunto" & i + 1).Value
                        Next
                        mCodigo = IIf(IsNull(oRsDet.Fields("Codigo").Value), "", oRsDet.Fields("Codigo").Value)
                        mArticulo = IIf(IsNull(oRsDet.Fields("DescripcionArt").Value), "", oRsDet.Fields("DescripcionArt").Value)
                        .Registro.Fields("PorcentajeIVA").Value = oRsDet.Fields("AlicuotaIVA").Value
                        If mTipoCosto = "CostoPPP" Then
                           mCosto = IIf(IsNull(oRsDet.Fields("CostoPPP").Value), 0, oRsDet.Fields("CostoPPP").Value)
                        Else
                           mCosto = IIf(IsNull(oRsDet.Fields("CostoReposicion").Value), 0, oRsDet.Fields("CostoReposicion").Value)
                        End If
                        .Registro.Fields("Costo").Value = mCosto
                        If mTipoPrecio = "CostoPPP" Then
                           .Registro.Fields("Precio").Value = IIf(IsNull(oRsDet.Fields("CostoPPP").Value), 0, oRsDet.Fields("CostoPPP").Value)
                        ElseIf mTipoPrecio = "CostoReposicion" Then
                           .Registro.Fields("Precio").Value = IIf(IsNull(oRsDet.Fields("CostoReposicion").Value), 0, oRsDet.Fields("CostoReposicion").Value)
                        End If
                        If Check2.Value = 1 Then
                           .Registro.Fields("PorcentajeIVA").Value = 0
                           .Registro.Fields("ImporteIVA").Value = 0
                        End If
                        
                        oL.Tag = .Id
                        oL.Text = "" & .Registro.Fields("NumeroItem").Value
                        oL.SubItems(1) = "" & oRsDet.Fields("Cantidad").Value
                        oL.SubItems(2) = "" & oRsDet.Fields("Cantidad1").Value
                        oL.SubItems(3) = "" & oRsDet.Fields("Cantidad2").Value
                        oL.SubItems(4) = "" & oRsDet.Fields("Unidad").Value
                        oL.SubItems(5) = "" & oRsDet.Fields("CC").Value
                        oL.SubItems(6) = "" & mCodigo
                        oL.SubItems(7) = "" & mArticulo
                        oL.SubItems(8) = "" & oRsDet.Fields("FechaEntrega").Value
                        oL.SubItems(9) = "" & oRsDet.Fields("FechaEntrega").Value
                        oL.SubItems(10) = ""
                        oL.SubItems(11) = ""
                        oL.SubItems(12) = ""
                        oL.SubItems(13) = ""
                        oL.SubItems(14) = ""
                        oL.SubItems(15) = ""
                        oL.SubItems(16) = ""
                        oL.SubItems(17) = ""
                        oL.SubItems(18) = "NO"
                        oL.SubItems(19) = ""
                        oL.SubItems(20) = ""
                        oL.SubItems(21) = ""
                        oL.SubItems(22) = "" & oRsDet.Fields("NumeroRequerimiento").Value
                        oL.SubItems(23) = "" & oRsDet.Fields("NumeroItem").Value
                        oL.SubItems(26) = "" & Format(mCosto, "#0.0000")
                        oL.SmallIcon = "Nuevo"
                        .Modificado = True
                     
                        mExiste = origen.ItemEnOtrosPedidos(oRsDet.Fields("IdDetalleRequerimiento").Value, "RM")
                        If Len(mExiste) Then
                           MsgBox "Cuidado, el requerimiento " & oRsDet.Fields("NumeroRequerimiento").Value & _
                                  " item " & oRsDet.Fields("NumeroItem").Value & _
                                  " existe en el pedido :" & vbCrLf & mExiste & _
                                  "El mensaje es solo informativo", vbInformation
                        End If
                     End With
                  End If
               End If
            End With
SalidaFor:
         Next
         
         CalculaPedido

      Else
         
         MsgBox "Objeto invalido!"
      
      End If

   End If
   
Salida:

   Clipboard.Clear
      
   Set oRs = Nothing
   Set oRs1 = Nothing
   Set oRsDet = Nothing
   Set oPed = Nothing
   Set oPre = Nothing
   Set oAp = Nothing
   
   Exit Sub
   
Mal:

   MsgBox "Se ha producido un problema, la operacion no se completo" & vbCrLf & Err.Description, vbCritical
   GoTo Salida
   
End Sub

Private Sub Lista_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

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
         If Not Lista.SelectedItem Is Nothing Then
            Editar Lista.SelectedItem.Tag
         End If
      Case 2
         If mvarId > 0 And Not IsNull(origen.Registro.Fields("Aprobo").Value) Then
            MsgBox "No puede modificar un pedido ya cerrado", vbCritical
            Exit Sub
         End If
         If mNivelAcceso > 1 Then
            MsgBox "Nivel de acceso insuficiente!", vbCritical
            Exit Sub
         End If
         If mvarAnulada Then
            MsgBox "El pedido ha sido anulado y no puede modificarse!", vbCritical
            Exit Sub
         End If
         If Not Lista.SelectedItem Is Nothing Then
            With Lista.SelectedItem
               If VerificarAnulacionItem(.Tag) Then
                  origen.DetPedidos.Item(.Tag).Eliminado = True
                  .SmallIcon = "Eliminado"
                  .ToolTipText = .SmallIcon
               End If
            End With
            CalculaPedido
         End If
      Case 3
         If mNivelAcceso > 1 Then
            MsgBox "Nivel de acceso insuficiente!", vbCritical
            Exit Sub
         End If
         If Not Lista.SelectedItem Is Nothing Then
            With Lista.SelectedItem
               If VerificarAnulacionItem(.Tag) Then
                  origen.DetPedidos.Item(.Tag).Registro.Fields("Cumplido").Value = "AN"
                  origen.DetPedidos.Item(.Tag).Modificado = True
                  .SubItems(18) = "AN"
                  .SmallIcon = "Eliminado"
                  .ToolTipText = .SmallIcon
               End If
            End With
         End If
      Case 4
         If Not Lista.SelectedItem Is Nothing Then
            AsignaFechaNecesidad
         End If
      Case 5
         If Not Lista.SelectedItem Is Nothing Then
            AsignaFechaEntrega
         End If
      Case 6
         If Not Lista.SelectedItem Is Nothing Then
            AsignaBonificacion "S"
         End If
      Case 7
         If Not Lista.SelectedItem Is Nothing Then
            AsignaBonificacion "T"
         End If
      Case 8
         If Not Lista.SelectedItem Is Nothing Then
            AsignaIVA "S"
         End If
      Case 9
         If Not Lista.SelectedItem Is Nothing Then
            AsignaIVA "T"
         End If
      Case 10
         If Not Lista.SelectedItem Is Nothing Then
            If mNivelAcceso > 8 Then
               MsgBox "Nivel de acceso insuficiente!", vbCritical
               Exit Sub
            End If
            If mvarAnulada Then
               MsgBox "El pedido ha sido anulado y no puede modificarse!", vbCritical
               Exit Sub
            End If
            DuplicarItem
         End If
      Case 12
         If Not Lista.SelectedItem Is Nothing Then
            AsignaPrecio "S"
         End If
      Case 13
         If Not Lista.SelectedItem Is Nothing Then
            AsignaPrecio "T"
         End If
      Case 14
         RenumerarItems
   End Select

End Sub

Private Sub MnuDetA1_Click(Index As Integer)

   Select Case Index
      Case 0
         AsignarOrigenDescripcion 1
      Case 1
         AsignarOrigenDescripcion 2
      Case 2
         AsignarOrigenDescripcion 3
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

Private Sub Option3_Click()

   If Option3.Value Then
      origen.Registro.Fields("Consorcial").Value = "NO"
   End If

End Sub

Private Sub Option4_Click()

   If Option4.Value Then
      origen.Registro.Fields("Consorcial").Value = "SI"
   End If

End Sub

Private Sub txtBonificacion_GotFocus()

   With txtBonificacion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBonificacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtBonificacion_Validate(Cancel As Boolean)

   If IsNumeric(txtBonificacion.Text) Then
      CalculaPedido
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
            Set oRs = oAp.Proveedores.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set oRs = oAp.Proveedores.TraerLista
         End If
         Set dcfields(0).RowSource = oRs
         If oRs.RecordCount > 0 Then
            dcfields(0).BoundText = oRs.Fields(0).Value
         End If
         Set oRs = Nothing
         Set oAp = Nothing
      End If
      dcfields(0).SetFocus
'      SendKeys "%{DOWN}"
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

Private Sub txtDetalleCondicionCompra_GotFocus()

   With txtDetalleCondicionCompra
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDetalleCondicionCompra_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
   Else
      With txtDetalleCondicionCompra
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtImpuestosInternos_GotFocus()

   With txtImpuestosInternos
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImpuestosInternos_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtImpuestosInternos_LostFocus()

   txtImpuestosInternos.Text = Format(Val(txtImpuestosInternos.Text), "#,##0.00")
   CalculaPedido

End Sub

'Private Sub txtNumeroComparativa_GotFocus()
'
'   With txtNumeroComparativa
'      .SelStart = 0
'      .SelLength = Len(.Text)
'   End With
'
'End Sub
'
'Private Sub txtNumeroComparativa_KeyPress(KeyAscii As Integer)
'
'   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}",True
'
'End Sub
'
'Private Sub txtNumeroComparativa_Validate(Cancel As Boolean)
'
'   If Len(Trim(txtNumeroComparativa.Text)) > 0 Then
'      If Not IsNumeric(txtNumeroComparativa.Text) Then
'         MsgBox "Ingrese un numero de comparativa valido", vbExclamation
'         Cancel = True
'      Else
'         If Not Aplicacion.Comparativas.Existe(txtNumeroComparativa.Text) Then
'            MsgBox "Comparativa inexistente", vbExclamation
'            Cancel = True
'         End If
'      End If
'   End If
'
'End Sub

Private Sub txtNumeroPedido_GotFocus()

   With txtNumeroPedido
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroPedido_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Public Function DatosProveedor()
         
   If Not IsNumeric(dcfields(0).BoundText) Then Exit Function
   
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim mvarIdCondicionCompra As Integer
   Dim mvarLocalidad As Long, mvarProvincia As Long
   
   Set oAp = Aplicacion
   Set oRs = oAp.Proveedores.Item(dcfields(0).BoundText).Registro
   
   With oRs
      If IsNull(.Fields("IdCodigoIva").Value) Then
         origen.Registro.Fields(dcfields(0).DataField).Value = Null
         txtDireccion.Text = ""
         txtTelefono.Text = ""
         txtEmail.Text = ""
         txtCuit.Text = ""
         txtContacto.Text = ""
         txtLocalidad.Text = ""
         txtProvincia.Text = ""
         txtCondicionIva.Text = ""
         MsgBox "El proveedor no tienen codigo de IVA, reingrese", vbCritical
         GoTo Salida
      End If
      mvarCondicionIva = .Fields("IdCodigoIva").Value
      mvarLocalidad = IIf(IsNull(.Fields("IdLocalidad").Value), 0, .Fields("IdLocalidad").Value)
      mvarProvincia = IIf(IsNull(.Fields("IdProvincia").Value), 0, .Fields("IdProvincia").Value)
      mvarIdCondicionCompra = IIf(IsNull(.Fields("IdCondicionCompra").Value), 0, .Fields("IdCondicionCompra").Value)
      txtDireccion.Text = IIf(IsNull(.Fields("Direccion").Value), "", .Fields("Direccion").Value)
      txtTelefono.Text = IIf(IsNull(.Fields("Telefono1").Value), "", .Fields("Telefono1").Value)
      txtEmail.Text = IIf(IsNull(.Fields("Email").Value), "", .Fields("Email").Value)
      txtCuit.Text = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
      origen.Registro.Fields("Contacto").Value = IIf(IsNull(.Fields("Contacto").Value), "", .Fields("Contacto").Value)
   End With
   
   If mvarLocalidad <> 0 Then
      oAp.TablasGenerales.Tabla = "Localidades"
      oAp.TablasGenerales.Id = mvarLocalidad
      Set oRs = oAp.TablasGenerales.Registro
      txtLocalidad.Text = IIf(IsNull(oRs.Fields("Nombre").Value), "", oRs.Fields("Nombre").Value)
   End If
   
   If mvarProvincia <> 0 Then
      oAp.TablasGenerales.Tabla = "Provincias"
      oAp.TablasGenerales.Id = mvarProvincia
      Set oRs = oAp.TablasGenerales.Registro
      txtProvincia.Text = IIf(IsNull(oRs.Fields("Nombre").Value), "", oRs.Fields("Nombre").Value)
   End If
   
   If Not IsNull(mvarCondicionIva) Then
      oAp.TablasGenerales.Tabla = "DescripcionIva"
      oAp.TablasGenerales.Id = mvarCondicionIva
      Set oRs = oAp.TablasGenerales.Registro
      txtCondicionIva.Text = oRs.Fields("Descripcion").Value
      mvarTipoIVA = IIf(IsNull(oRs.Fields("IvaDiscriminado").Value), 0, oRs.Fields("IvaDiscriminado").Value)
   End If
   
   If IsNull(origen.Registro.Fields(dcfields(7).DataField).Value) Or mvarId <= 0 Then
      origen.Registro.Fields(dcfields(7).DataField).Value = mvarIdCondicionCompra
   End If
      
Salida:

   oRs.Close
   Set oRs = Nothing
   Set oAp = Nothing

End Function

Private Sub CalculaPedido()

   Dim oRs As ADOR.Recordset
   Dim oDet As DetPedido
   Dim oL As ListItem
   Dim mvarImporteTotalItem As Double, mvarBonificacionDistribuida As Double, mvarImpuestosInternos As Double
   Dim mvarImporteIVAItem As Double
   Dim i As Integer, j As Integer, X As Integer
   
   For i = 1 To 2
      mvarSubTotal = 0
      mvarSubtotalGravado = 0
      mvarIVA1 = 0
      mvarIVA2 = 0
      mvarTotalPedido = 0
      mvarBonificacionPorItem = 0
      mvarBonificacion = 0
      mvarTotalOtrosConceptos = 0
      mvarImpuestosInternos = 0
      
      Set oRs = origen.DetPedidos.Registros
      With oRs
         If .Fields.Count > 0 Then
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  If Not .Fields("Eliminado").Value Then
                     mvarSubTotal = mvarSubTotal + Round((.Fields("Precio").Value * .Fields("Cantidad").Value), 2)
                  End If
                  .MoveNext
               Loop
               .MoveFirst
               Do While Not .EOF
                  If Not .Fields("Eliminado").Value Then
                     Set oDet = origen.DetPedidos.Item(.Fields(0).Value)
                     With oDet.Registro
                        mvarImporteTotalItem = (.Fields("Precio").Value * .Fields("Cantidad").Value)
                        mvarBonificacionDistribuida = 0
                        If Not IsNull(.Fields("ImporteBonificacion").Value) Then
                           If mvarSubTotal <> 0 Then
                              mvarBonificacionDistribuida = Val(Replace(txtBonificacion.Text, ",", "")) * (mvarImporteTotalItem / mvarSubTotal)
                           End If
                           mvarBonificacionPorItem = mvarBonificacionPorItem + .Fields("ImporteBonificacion").Value
                        End If
                        mvarImporteIVAItem = 0
                        If Not IsNull(.Fields("PorcentajeIVA").Value) And Check2.Value = 0 Then
                           mvarImporteIVAItem = ((.Fields("Cantidad").Value * .Fields("Precio").Value) - _
                                                 IIf(IsNull(.Fields("ImporteBonificacion").Value), 0, .Fields("ImporteBonificacion").Value) - mvarBonificacionDistribuida) * _
                                                .Fields("PorcentajeIVA").Value / 100
                        End If
                        .Fields("ImporteIVA").Value = mvarImporteIVAItem
                        If mHabilitarImpuestosInternosItem Then
                           mvarImpuestosInternos = mvarImpuestosInternos + IIf(IsNull(.Fields("ImpuestosInternos").Value), 0, .Fields("ImpuestosInternos").Value)
                        End If
                        .Fields("ImporteTotalItem").Value = mvarImporteTotalItem - IIf(IsNull(.Fields("ImporteBonificacion").Value), 0, .Fields("ImporteBonificacion").Value) - _
                                                            mvarBonificacionDistribuida + mvarImporteIVAItem
                        mvarIVA1 = mvarIVA1 + mvarImporteIVAItem
                     End With
                     Set oDet = Nothing
                  End If
                  .MoveNext
               Loop
            End If
         End If
      End With
      Set oRs = Nothing
      
      mvarIVA1 = Round(mvarIVA1, 2)

      If IsNumeric(txtPorcentajeBonificacion.Text) And Val(txtPorcentajeBonificacion.Text) <> 0 Then
         mvarBonificacion = Round((mvarSubTotal - mvarBonificacionPorItem) * Val(txtPorcentajeBonificacion.Text) / 100, 2)
      ElseIf IsNumeric(Replace(txtBonificacion.Text, ",", "")) Then
         mvarBonificacion = Val(Replace(txtBonificacion.Text, ",", ""))
      End If
      mvarSubtotalGravado = mvarSubTotal - mvarBonificacion - mvarBonificacionPorItem

      With origen.Registro
         For j = 1 To 5
            mvarTotalOtrosConceptos = mvarTotalOtrosConceptos + _
                  IIf(IsNull(.Fields("OtrosConceptos" & j).Value), 0, .Fields("OtrosConceptos" & j).Value)
         Next
         If mHabilitarImpuestosInternosItem Then
            txtImpuestosInternos.Text = Format(mvarImpuestosInternos, "#,##0.00")
            .Fields("ImpuestosInternos").Value = mvarImpuestosInternos
         End If
         mvarImpuestosInternos = Val(Replace(txtImpuestosInternos.Text, ",", ""))
      End With
      
      mvarTotalPedido = mvarSubtotalGravado + mvarIVA1 + mvarIVA2 + mvarImpuestosInternos + mvarTotalOtrosConceptos
      
      txtSubtotal.Text = Format(mvarSubTotal, "#,##0.00")
      txtNeto.Text = Format(mvarSubtotalGravado, "#,##0.00")
      txtBonificacionPorItem.Text = Format(mvarBonificacionPorItem, "#,##0.00")
      txtBonificacion.Text = Format(mvarBonificacion, "#,##0.00")
      txtTotalIva1.Text = Format(mvarIVA1, "#,##0.00")
      txtOtrosConceptos.Text = Format(mvarTotalOtrosConceptos, "#,##0.00")
      txtTotal(0).Text = Format(mvarTotalPedido, "#,##0.00")
   Next

'   If mvarIVA1 = 0 Then
'      If mvarTipoIva = 0 Then
'         Select Case mvarCondicionIva
'            Case 1
'               mvarIVA1 = Round(mvarSubtotalGravado * mvarP_IVA1 / 100, 2)
'            Case 2
'               mvarIVA1 = Round(mvarSubtotalGravado * mvarP_IVA1 / 100, 2)
'               mvarIVA2 = Round(mvarSubtotalGravado * mvarP_IVA2 / 100, 2)
'         End Select
'      End If
'   End If
   
   If mvarTotalOtrosConceptos <> 0 Then
      txtOtrosConceptos.BackColor = &HC0FFC0
   Else
      txtOtrosConceptos.BackColor = &HC0C0FF
   End If
   
   If Me.VisualizacionSimplificada Then Exit Sub
   If Not Lista.SelectedItem Is Nothing Then X = Lista.SelectedItem.Index
   Set Lista.DataSource = origen.DetPedidos.RegistrosConFormato
   Lista.Refresh
   If Lista.ListItems.Count = 0 Then
      Set Lista.DataSource = origen.DetPedidos.TraerMascara
      Lista.ListItems.Clear
   End If
   If X > 0 Then
      For Each oL In Lista.ListItems
         oL.Selected = False
      Next
      For Each oL In Lista.ListItems
         If oL.Index = X Then
            oL.EnsureVisible
            oL.Selected = True
            Exit For
         End If
      Next
      Set oL = Nothing
   End If

End Sub

Private Sub txtOtrosConceptos_Click()

   Dim oF As frmPedidosOtrosConceptos
   
   Set oF = New frmPedidosOtrosConceptos
   With oF
      Set .Pedido = origen
      .Id = mvarId
      .Show vbModal, Me
   End With
   Unload oF
   Set oF = Nothing
   
   txtOtrosConceptos.Text = mvarTotalOtrosConceptos
   CalculaPedido
   
   If mvarTotalOtrosConceptos <> 0 Then
      txtOtrosConceptos.BackColor = &HC0FFC0
   Else
      txtOtrosConceptos.BackColor = &HC0C0FF
   End If

End Sub

Private Sub txtPorcentajeBonificacion_GotFocus()

   With txtPorcentajeBonificacion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcentajeBonificacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPorcentajeBonificacion_Validate(Cancel As Boolean)

   If IsNumeric(txtPorcentajeBonificacion.Text) Then
'      If Val(txtPorcentajeBonificacion.Text) <> 0 Then
'         MsgBox "El porcentaje de bonificacion no puede modificarse," & vbCrLf & _
'               "ingreselo por item", vbExclamation
'         origen.Registro.Fields("PorcentajeBonificacion").Value = 0
'         Cancel = True
'      Else
         CalculaPedido
'      End If
   Else
      origen.Registro.Fields("PorcentajeBonificacion").Value = 0
   End If
   
End Sub

Public Function GeneraInspecciones() As String

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRsCalidad As ADOR.Recordset
   Dim i As Integer, Contador As Integer
   Dim mvarDes As String, mvarVal As String
   Dim cCCalidad As Contenedor
   Dim oPar As ComPronto.Parametro
   
   Set oAp = Aplicacion
   
   Contador = 1
   
   Set cCCalidad = New Contenedor
   
   If mvarId > 0 Then
      Set oRsDet = origen.DetPedidos.TraerFiltrado("Ped", mvarId)
   Else
      Set oRsDet = origen.DetPedidos.RegistrosConFormato
   End If
         
   With oRsDet
      If .RecordCount > 0 Then
         .MoveFirst
         Do Until .EOF
            If Not IsNull(.Fields("IdControlCalidad").Value) Then
               Set oRsCalidad = oAp.ControlesCalidad.Item(.Fields("IdControlCalidad").Value).Registro
               mvarDes = ""
               If Not IsNull(oRsCalidad.Fields("Detalle").Value) Then
                  rchObservacionesItem.TextRTF = oRsCalidad.Fields("Detalle").Value
                  mvarDes = rchObservacionesItem.Text
               End If
               oRsCalidad.Close
               mvarVal = cCCalidad.Valor(mvarDes) & "" & .Fields("Item").Value & ", "
               cCCalidad.NuevaVar mvarDes, .Fields("IdControlCalidad").Value, ""
               cCCalidad.NuevoValor mvarDes, mvarVal
            Else
               mvarDes = "Sin C.C."
               mvarVal = cCCalidad.Valor(mvarDes) & "" & .Fields("Item").Value & ", "
               cCCalidad.NuevaVar mvarDes, 0, ""
               cCCalidad.NuevoValor mvarDes, mvarVal
            End If
            .MoveNext
         Loop
      End If
      .Close
   End With
          
   Set oPar = oAp.Parametros.Item(1)
   mvarDes = "5.1 "
   If Not IsNull(oPar.Registro.Fields("PedidosInspecciones").Value) Then
      rchObservacionesItem.TextRTF = oPar.Registro.Fields("PedidosInspecciones").Value
      mvarDes = mvarDes & rchObservacionesItem.Text & vbCrLf
   End If
   Set oPar = Nothing
   For i = 1 To cCCalidad.CuentaVar
      Contador = Contador + 1
      mvarDes = mvarDes & "5." & Contador & " " & cCCalidad.NombreVar(i) & ", Items : " & IIf(Len(cCCalidad.Valor(i)) = 0, "", mId(cCCalidad.Valor(i), 1, Len(cCCalidad.Valor(i)) - 1)) & vbCrLf
   Next

   Set oRsDet = Nothing
   Set oRsCalidad = Nothing
   Set cCCalidad = Nothing
   Set oAp = Nothing
   
   GeneraInspecciones = mvarDes
   
End Function

Public Function GeneraImputaciones()

   Dim oAp As ComPronto.Aplicacion
   Dim oRsDet As ADOR.Recordset
   Dim i As Integer
   Dim mvarDes As String, mvarVal As String
   Dim cCContable As Contenedor
   
   Set oAp = Aplicacion
   
   Set cCContable = New Contenedor
   
   If mvarId > 0 Then
      Set oRsDet = origen.DetPedidos.TraerFiltrado("Ped", mvarId)
   Else
      Set oRsDet = origen.DetPedidos.RegistrosConFormato
   End If
         
   With oRsDet
      If .RecordCount > 0 Then
         .MoveFirst
         Do Until .EOF
            If Not IsNull(.Fields("IdCuenta").Value) Then
               mvarDes = oAp.Cuentas.Item(.Fields("IdCuenta").Value).Registro.Fields("Codigo").Value
               mvarVal = cCContable.Valor(mvarDes) & "" & .Fields("Item").Value & ", "
               cCContable.NuevaVar mvarDes, .Fields("IdCuenta").Value, ""
               cCContable.NuevoValor mvarDes, mvarVal
            Else
               mvarDes = "Sin Cuenta"
               mvarVal = cCContable.Valor(mvarDes) & "" & .Fields("Item").Value & ", "
               cCContable.NuevaVar mvarDes, 0, ""
               cCContable.NuevoValor mvarDes, mvarVal
            End If
            .MoveNext
         Loop
      End If
      .Close
   End With
          
   mvarDes = ""
'   For i = 1 To cCContable.CuentaVar
'      mvarDes = mvarDes & cCContable.NombreVar(i) & ", Items : " & IIf(Len(cCContable.Valor(i)) = 0, "", mId(cCContable.Valor(i), 1, Len(cCContable.Valor(i)) - 1)) & vbCrLf
'   Next

   Set oRsDet = Nothing
   Set cCContable = Nothing
   Set oAp = Nothing
   
   GeneraImputaciones = mvarDes
   
End Function

Private Function AprobadoImpresion() As Boolean

   Dim mAprob As Boolean
   
   mAprob = False
   If (Check1(0).Visible And Check1(0).Value = 1) And (Check1(1).Visible And Check1(1).Value = 1) Then
      mAprob = True
   End If

   AprobadoImpresion = mAprob
   
End Function

Public Sub TraerDesdeComparativa()

   Dim oAp As ComPronto.Aplicacion
   Dim oPre As ComPronto.Presupuesto
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim oRsPre As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRsComp As ADOR.Recordset
   Dim oL As ListItem
   Dim idDet As Long, IdCCal As Long
   Dim i As Integer
   Dim mExiste As String, mCodigo As String, mArticulo As String, mObs As String
   Dim mImporte As Double, mIVA As Double
   
   On Error GoTo Mal
   
   Set oAp = Aplicacion
   
   Set oRsComp = oAp.Comparativas.TraerFiltrado("_PorNumero", dcfields(3).BoundText)
   
   If oRsComp.RecordCount > 0 Then
   
      If Not IsNull(oRsComp.Fields("PresupuestoSeleccionado").Value) And _
            oRsComp.Fields("PresupuestoSeleccionado").Value = -1 Then
   
         'Multipresupuesto
      
         Dim mvarArticulo1 As String, mvarArticulo2 As String
         Dim mvarArticuloConObs As String, mvarArticuloSinObs As String
         Dim mOrigenDescripcion As Integer
         
         Dim oF As frmConsulta2
         Dim mIdPresupuestoSeleccionado As Long
         Set oF = New frmConsulta2
         With oF
            .IdComparativa = oRsComp.Fields(0).Value
            .IdPresupuestoSeleccionado = 0
            .Id = 3
            .Show vbModal, Me
            mIdPresupuestoSeleccionado = .IdPresupuestoSeleccionado
         End With
         Unload oF
         Set oF = Nothing
         
         If mIdPresupuestoSeleccionado <> 0 Then
         
            Set oRs = oAp.Comparativas.TraerFiltrado("_PorPresupuestoSoloSeleccionados", Array(oRsComp.Fields(0).Value, mIdPresupuestoSeleccionado))
         
            Set oRsPre = oAp.Presupuestos.Item(mIdPresupuestoSeleccionado).Registro
            Set oRsDet = oAp.Presupuestos.TraerFiltrado("_DetallesPorIdPresupuestoIdComparativa", _
                           Array(mIdPresupuestoSeleccionado, oRsComp.Fields("IdComparativa").Value))
            
            txtPresupuesto.Text = oRsPre.Fields("Numero").Value & " / " & oRsPre.Fields("SubNumero").Value
               
            If mvarId = -1 And Not IsNull(oRsPre.Fields("IdPlazoEntrega").Value) Then
               Set oRs1 = Aplicacion.PlazosEntrega.TraerFiltrado("_PorId", oRsPre.Fields("IdPlazoEntrega").Value)
               If oRs1.RecordCount > 0 Then
                  mvarPlazoEntrega = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
               End If
               oRs1.Close
            End If
            
            If oRs.RecordCount > 0 Then
         
               Do While Not oRs.EOF
               
                  mvarArticulo1 = ""
                  mvarArticuloConObs = oRs.Fields("Descripcion").Value & " [Id " & oRs.Fields("IdArticulo").Value & "]"
                  mvarArticuloSinObs = oRs.Fields("Descripcion").Value & " [Id " & oRs.Fields("IdArticulo").Value & "]"
                  If Not IsNull(oRs.Fields("Observaciones").Value) Then
                     mvarArticuloConObs = mvarArticuloConObs & " " & oRs.Fields("Observaciones").Value
                  End If
                  If Not IsNull(oRs.Fields("OrigenDescripcion").Value) Then
                     mOrigenDescripcion = oRs.Fields("OrigenDescripcion").Value
                  Else
                     mOrigenDescripcion = 1
                  End If
                  If (mOrigenDescripcion = 1 Or mOrigenDescripcion = 3) Then
                     mvarArticulo1 = mvarArticuloSinObs
                  End If
                  If mOrigenDescripcion = 2 Or mOrigenDescripcion = 3 Then
                     If Len(Trim(mvarArticulo1)) > 0 Then
                        mvarArticulo1 = mvarArticuloConObs
                     Else
                        mvarArticulo1 = oRs.Fields("Observaciones").Value
                     End If
                  End If
                     
                  oRsDet.MoveFirst
                  Do While Not oRsDet.EOF
                     
                     mvarArticulo2 = ""
                     mvarArticuloConObs = oRsDet.Fields("Descripcion").Value & " [Id " & oRsDet.Fields("IdArticulo").Value & "]"
                     mvarArticuloSinObs = oRsDet.Fields("Descripcion").Value & " [Id " & oRsDet.Fields("IdArticulo").Value & "]"
                     mObs = ""
                     If Not IsNull(oRsDet.Fields("Observaciones").Value) Then
                        mObs = Replace(oRsDet.Fields("Observaciones").Value, ",", " ")
                        mObs = Replace(mObs, ";", " ")
                        mObs = Replace(mObs, Chr(13) + Chr(10) + Chr(13) + Chr(10), " ")
                        mvarArticuloConObs = mvarArticuloConObs & " " & mObs
                     End If
                     If Not IsNull(oRsDet.Fields("OrigenDescripcion").Value) Then
                        mOrigenDescripcion = oRsDet.Fields("OrigenDescripcion").Value
                     Else
                        mOrigenDescripcion = 1
                     End If
                     If (mOrigenDescripcion = 1 Or mOrigenDescripcion = 3) Then
                        mvarArticulo2 = mvarArticuloSinObs
                     End If
                     If mOrigenDescripcion = 2 Or mOrigenDescripcion = 3 Then
                        If Len(Trim(mvarArticulo2)) > 0 Then
                           mvarArticulo2 = mvarArticuloConObs
                        Else
                           mvarArticulo2 = mObs
                        End If
                     End If
                     
                     If mId(mvarArticulo1, 1, 1000) = mId(mvarArticulo2, 1, 1000) Then
                        
                        mExiste = ""
                        If Not IsNull(oRsDet.Fields("IdDetalleRequerimiento").Value) Then
                           mExiste = origen.ItemEnOtrosPedidos(oRsDet.Fields("IdDetalleRequerimiento").Value, "RM")
                        End If
                        If Len(mExiste) > 0 Then
                           Me.Refresh
                           MsgBox "Cuidado, el item de la RM ya existe en el pedido :" & vbCrLf & mExiste & "y no sera incluido en el pedido.", vbInformation
                        Else
                           mIVA = Round((oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value) * mvarP_IVA1 / 100, 4)
                           mImporte = (oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value) + mIVA
                           With origen.DetPedidos.Item(-1)
                              .Registro.Fields("NumeroItem").Value = oRsDet.Fields("NumeroItem").Value
                              .Registro.Fields("Cantidad").Value = oRsDet.Fields("Cantidad").Value
                              .Registro.Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                              .Registro.Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                              .Registro.Fields("Precio").Value = oRsDet.Fields("Precio").Value
                              .Registro.Fields("Adjunto").Value = oRsDet.Fields("Adjunto").Value
                              .Registro.Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
                              .Registro.Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
                              .Registro.Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
                              .Registro.Fields("IdDetalleAcopios").Value = oRsDet.Fields("IdDetalleAcopios").Value
                              .Registro.Fields("IdDetalleRequerimiento").Value = oRsDet.Fields("IdDetalleRequerimiento").Value
                              .Registro.Fields("OrigenDescripcion").Value = oRsDet.Fields("OrigenDescripcion").Value
                              .Registro.Fields("FechaEntrega").Value = oRsDet.Fields("FechaEntrega").Value
                              .Registro.Fields("IdCuenta").Value = oRsDet.Fields("IdCuenta").Value
                              .Registro.Fields("IdCentroCosto").Value = oRsDet.Fields("IdCentroCosto").Value
                              .Registro.Fields("PorcentajeBonificacion").Value = oRsDet.Fields("PorcentajeBonificacion").Value
                              .Registro.Fields("ImporteBonificacion").Value = oRsDet.Fields("ImporteBonificacion").Value
                              If Check2.Value = 0 Then
                                 .Registro.Fields("PorcentajeIVA").Value = oRsDet.Fields("PorcentajeIVA").Value
                                 .Registro.Fields("ImporteIVA").Value = oRsDet.Fields("ImporteIVA").Value
                              End If
                              .Registro.Fields("ImporteTotalItem").Value = oRsDet.Fields("ImporteTotalItem").Value
                              .Registro.Fields("IdControlCalidad").Value = mvarIdControlCalidadStandar
                              If IsNull(oRsDet.Fields("ImporteTotalItem").Value) Then
                                 .Registro.Fields("ImporteTotalItem").Value = mImporte
                              End If
                              For i = 0 To 9
                                 .Registro.Fields("ArchivoAdjunto" & i + 1).Value = oRsDet.Fields("ArchivoAdjunto" & i + 1).Value
                              Next
                              .Registro.Fields("IdDetalleComparativa").Value = oRsDet.Fields("IdDetalleComparativa").Value
                              .Modificado = True
                              idDet = .Id
                              
                              Set oRs1 = oAp.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdArticulo").Value)
                              mCodigo = IIf(IsNull(oRs1.Fields("Codigo").Value), "", oRs1.Fields("Codigo").Value)
                              mArticulo = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
                              oRs1.Close
                              
                              Set oL = Lista.ListItems.Add
                              oL.Tag = idDet
                              oL.SmallIcon = "Nuevo"
                              oL.Text = oRsDet.Fields("NumeroItem").Value
                              oL.SubItems(1) = "" & oRsDet.Fields("Cantidad").Value
                              oL.SubItems(2) = "" & oRsDet.Fields("Cantidad1").Value
                              oL.SubItems(3) = "" & oRsDet.Fields("Cantidad2").Value
                              If Not IsNull(oRsDet.Fields("IdUnidad").Value) Then
                                 oL.SubItems(4) = "" & oAp.Unidades.Item(oRsDet.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
                              End If
                              oL.SubItems(6) = "" & mCodigo
                              oL.SubItems(7) = "" & mArticulo
                              oL.SubItems(8) = "" & oRsDet.Fields("FechaEntrega").Value
                              oL.SubItems(9) = ""
                              If Not IsNull(oRsDet.Fields("Precio").Value) Then
                                 oL.SubItems(10) = "" & Format(oRsDet.Fields("Precio").Value, "#0.0000")
                                 oL.SubItems(11) = "" & Format(oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value, "#0.0000")
                              Else
                                 oL.SubItems(10) = ""
                                 oL.SubItems(11) = ""
                              End If
                              oL.SubItems(12) = "" & Format(.Registro.Fields("PorcentajeBonificacion").Value, "Fixed")
                              oL.SubItems(13) = "" & Format(.Registro.Fields("ImporteBonificacion").Value, "#0.0000")
                              oL.SubItems(14) = "" & Format((oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value) - .Registro.Fields("ImporteBonificacion").Value, "#0.0000")
                              If Check2.Value = 0 Then
                                 oL.SubItems(15) = "" & Format(.Registro.Fields("PorcentajeIVA").Value, "Fixed")
                                 oL.SubItems(16) = "" & Format(.Registro.Fields("ImporteIVA").Value, "#0.0000")
                              End If
                              oL.SubItems(17) = "" & Format(.Registro.Fields("ImporteTotalItem").Value, "#0.0000")
                              
                              If Not IsNull(oRsDet.Fields("IdDetalleAcopios").Value) Then
                                 mExiste = origen.ItemEnOtrosPedidos(oRsDet.Fields("IdDetalleAcopios").Value, "AC")
                                 If Len(mExiste) Then
                                    Me.Refresh
                                    MsgBox "Cuidado, el item del Acopio ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
                                 End If
                                 Set oRs1 = oAp.TablasGenerales.TraerFiltrado("Acopios", "_DatosAcopio", oRsDet.Fields("IdDetalleAcopios").Value)
                                 If oRs1.RecordCount > 0 Then
                                    If Not IsNull(oRs1.Fields("IdControlCalidad").Value) Then
                                       .Registro.Fields("IdControlCalidad").Value = oRs1.Fields("IdControlCalidad").Value
                                    End If
                                    If IsNull(.Registro.Fields("IdCuenta").Value) Then
                                       .Registro.Fields("IdCuenta").Value = oRs1.Fields("IdCuenta").Value
                                    End If
                                 End If
                                 oRs1.Close
                              Else
                                 If Not IsNull(oRsDet.Fields("IdDetalleRequerimiento").Value) Then
'                                    mExiste = origen.ItemEnOtrosPedidos(oRsDet.Fields("IdDetalleRequerimiento").Value, "RM")
'                                    If Len(mExiste) Then
'                                       Me.Refresh
'                                       MsgBox "Cuidado, el item de la RM ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
'                                    End If
                                    Set oRs1 = oAp.Requerimientos.TraerFiltrado("_DatosRequerimiento", oRsDet.Fields("IdDetalleRequerimiento").Value)
                                    If oRs1.RecordCount > 0 Then
                                       If Not IsNull(oRs1.Fields("IdControlCalidad").Value) Then
                                          .Registro.Fields("IdControlCalidad").Value = oRs1.Fields("IdControlCalidad").Value
                                       End If
                                       If IsNull(.Registro.Fields("IdCuenta").Value) Then
                                          .Registro.Fields("IdCuenta").Value = oRs1.Fields("IdCuenta").Value
                                       End If
                                    End If
                                    oRs1.Close
                                 End If
                              End If
                              IdCCal = 0
                              If Not IsNull(.Registro.Fields("IdControlCalidad").Value) Then
                                 IdCCal = .Registro.Fields("IdControlCalidad").Value
                              End If
                           End With
                           With origen.Registro
                              .Fields("IdProveedor").Value = oRsPre.Fields("IdProveedor").Value
                              .Fields("Observaciones").Value = oRsPre.Fields("Observaciones").Value
                              .Fields("PorcentajeBonificacion").Value = oRsPre.Fields("Bonificacion").Value
                              .Fields("Garantia").Value = oRsPre.Fields("Garantia").Value
                              .Fields("LugarEntrega").Value = oRsPre.Fields("LugarEntrega").Value
                              .Fields("IdComprador").Value = oRsPre.Fields("IdComprador").Value
                              .Fields("Contacto").Value = oRsPre.Fields("Contacto").Value
                              .Fields("Bonificacion").Value = oRsPre.Fields("ImporteBonificacion").Value
                              .Fields("TotalIva1").Value = oRsPre.Fields("ImporteIva1").Value
                              .Fields("TotalPedido").Value = oRsPre.Fields("ImporteTotal").Value
                              .Fields("PorcentajeIva1").Value = oRsPre.Fields("PorcentajeIva1").Value
                              .Fields("PorcentajeIva2").Value = oRsPre.Fields("PorcentajeIva2").Value
                              .Fields("IdMoneda").Value = oRsPre.Fields("IdMoneda").Value
                              .Fields("DetalleCondicionCompra").Value = oRsPre.Fields("DetalleCondicionCompra").Value
                              .Fields("IdCondicionCompra").Value = oRsPre.Fields("IdCondicionCompra").Value
                              For i = 0 To 9
                                 .Fields("ArchivoAdjunto" & i + 1).Value = oRsPre.Fields("ArchivoAdjunto" & i + 1).Value
                              Next
                           End With
                        End If
                        
                     End If
                     oRsDet.MoveNext
                  Loop
                        
                  oRs.MoveNext
               Loop
                  
               oRs.Close
               oRsPre.Close
               oRsDet.Close
      
            End If
            
         End If
         
      Else
      
         'Seleccion monopresupuesto
         
         Set oRs = oAp.Comparativas.TraerFiltrado("_PorPresupuesto", dcfields(3).BoundText)
         
         If oRs.RecordCount > 0 Then
         
            Set oPre = oAp.Presupuestos.Item(oRs.Fields("IdPresupuesto").Value)
            Set oRsPre = oPre.Registro
            Set oRsDet = oAp.Presupuestos.TraerFiltrado("_DetallesPorIdPresupuestoIdComparativa", _
                           Array(oPre.Registro.Fields(0).Value, oRs.Fields("IdComparativa").Value))
                  
            txtPresupuesto.Text = oRsPre.Fields("Numero").Value & " / " & oRsPre.Fields("SubNumero").Value
            
            If mvarId = -1 And Not IsNull(oRsPre.Fields("IdPlazoEntrega").Value) Then
               Set oRs1 = Aplicacion.PlazosEntrega.TraerFiltrado("_PorId", oRsPre.Fields("IdPlazoEntrega").Value)
               If oRs1.RecordCount > 0 Then
                  mvarPlazoEntrega = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
               End If
               oRs1.Close
            End If
            
            Do While Not oRsDet.EOF
               mExiste = ""
               If Not IsNull(oRsDet.Fields("IdDetalleRequerimiento").Value) Then
                  mExiste = origen.ItemEnOtrosPedidos(oRsDet.Fields("IdDetalleRequerimiento").Value, "RM")
               End If
               If Len(mExiste) > 0 Then
                  Me.Refresh
                  MsgBox "Cuidado, el item de la RM ya existe en el pedido :" & vbCrLf & mExiste & "y no sera incluido en el pedido.", vbInformation
               Else
                  mIVA = Round((oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value) * mvarP_IVA1 / 100, 4)
                  mImporte = (oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value) + mIVA
                  With origen.DetPedidos.Item(-1)
                     .Registro.Fields("NumeroItem").Value = oRsDet.Fields("NumeroItem").Value
                     .Registro.Fields("Cantidad").Value = oRsDet.Fields("Cantidad").Value
                     .Registro.Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                     .Registro.Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                     .Registro.Fields("Precio").Value = oRsDet.Fields("Precio").Value
                     .Registro.Fields("Adjunto").Value = oRsDet.Fields("Adjunto").Value
                     .Registro.Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
                     .Registro.Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
                     .Registro.Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
                     .Registro.Fields("IdDetalleAcopios").Value = oRsDet.Fields("IdDetalleAcopios").Value
                     .Registro.Fields("IdDetalleRequerimiento").Value = oRsDet.Fields("IdDetalleRequerimiento").Value
                     .Registro.Fields("OrigenDescripcion").Value = oRsDet.Fields("OrigenDescripcion").Value
                     .Registro.Fields("FechaEntrega").Value = oRsDet.Fields("FechaEntrega").Value
                     .Registro.Fields("IdCuenta").Value = oRsDet.Fields("IdCuenta").Value
                     .Registro.Fields("IdCentroCosto").Value = oRsDet.Fields("IdCentroCosto").Value
                     .Registro.Fields("PorcentajeBonificacion").Value = oRsDet.Fields("PorcentajeBonificacion").Value
                     .Registro.Fields("ImporteBonificacion").Value = oRsDet.Fields("ImporteBonificacion").Value
                     If Check2.Value = 0 Then
                        .Registro.Fields("PorcentajeIVA").Value = oRsDet.Fields("PorcentajeIVA").Value
                        .Registro.Fields("ImporteIVA").Value = oRsDet.Fields("ImporteIVA").Value
                     End If
                     .Registro.Fields("ImporteTotalItem").Value = oRsDet.Fields("ImporteTotalItem").Value
                     .Registro.Fields("IdControlCalidad").Value = mvarIdControlCalidadStandar
                     If IsNull(oRsDet.Fields("ImporteTotalItem").Value) Then
                        .Registro.Fields("ImporteTotalItem").Value = mImporte
                     End If
                     For i = 0 To 9
                        .Registro.Fields("ArchivoAdjunto" & i + 1).Value = oRsDet.Fields("ArchivoAdjunto" & i + 1).Value
                     Next
                     .Registro.Fields("IdDetalleComparativa").Value = oRsDet.Fields("IdDetalleComparativa").Value
                     .Modificado = True
                     idDet = .Id
                     
                     Set oRs1 = oAp.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdArticulo").Value)
                     mCodigo = IIf(IsNull(oRs1.Fields("Codigo").Value), "", oRs1.Fields("Codigo").Value)
                     mArticulo = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
                     oRs1.Close
                              
                     Set oL = Lista.ListItems.Add
                     oL.Tag = idDet
                     oL.SmallIcon = "Nuevo"
                     oL.Text = oRsDet.Fields("NumeroItem").Value
                     oL.SubItems(1) = "" & oRsDet.Fields("Cantidad").Value
                     oL.SubItems(2) = "" & oRsDet.Fields("Cantidad1").Value
                     oL.SubItems(3) = "" & oRsDet.Fields("Cantidad2").Value
                     If Not IsNull(oRsDet.Fields("IdUnidad").Value) Then
                        oL.SubItems(4) = "" & oAp.Unidades.Item(oRsDet.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
                     End If
                     oL.SubItems(6) = "" & mCodigo
                     oL.SubItems(7) = "" & mArticulo
                     oL.SubItems(8) = "" & oRsDet.Fields("FechaEntrega").Value
                     oL.SubItems(9) = ""
                     If Not IsNull(oRsDet.Fields("Precio").Value) Then
                        oL.SubItems(10) = "" & Format(oRsDet.Fields("Precio").Value, "#0.0000")
                        oL.SubItems(11) = "" & Format(oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value, "#0.0000")
                     Else
                        oL.SubItems(10) = ""
                        oL.SubItems(11) = ""
                     End If
                     oL.SubItems(12) = "" & Format(.Registro.Fields("PorcentajeBonificacion").Value, "Fixed")
                     oL.SubItems(13) = "" & Format(.Registro.Fields("ImporteBonificacion").Value, "#0.0000")
                     oL.SubItems(14) = "" & Format((oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value) - .Registro.Fields("ImporteBonificacion").Value, "#0.0000")
                     If Check2.Value = 0 Then
                        oL.SubItems(15) = "" & Format(.Registro.Fields("PorcentajeIVA").Value, "Fixed")
                        oL.SubItems(16) = "" & Format(.Registro.Fields("ImporteIVA").Value, "#0.0000")
                     End If
                     oL.SubItems(17) = "" & Format(.Registro.Fields("ImporteTotalItem").Value, "#0.0000")
                     
                     If Not IsNull(oRsDet.Fields("IdDetalleAcopios").Value) Then
                        mExiste = origen.ItemEnOtrosPedidos(oRsDet.Fields("IdDetalleAcopios").Value, "AC")
                        If Len(mExiste) Then
                           Me.Refresh
                           MsgBox "Cuidado, el item del Acopio ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
                        End If
                        Set oRs1 = oAp.TablasGenerales.TraerFiltrado("Acopios", "_DatosAcopio", oRsDet.Fields("IdDetalleAcopios").Value)
                        If oRs1.RecordCount > 0 Then
                           If Not IsNull(oRs1.Fields("IdControlCalidad").Value) Then
                              .Registro.Fields("IdControlCalidad").Value = oRs1.Fields("IdControlCalidad").Value
                           End If
                           If IsNull(.Registro.Fields("IdCuenta").Value) Then
                              .Registro.Fields("IdCuenta").Value = oRs1.Fields("IdCuenta").Value
                           End If
                        End If
                        oRs1.Close
                     Else
                        If Not IsNull(oRsDet.Fields("IdDetalleRequerimiento").Value) Then
'                           mExiste = origen.ItemEnOtrosPedidos(oRsDet.Fields("IdDetalleRequerimiento").Value, "RM")
'                           If Len(mExiste) Then
'                              Me.Refresh
'                              MsgBox "Cuidado, el item de la RM ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
'                           End If
                           Set oRs1 = oAp.Requerimientos.TraerFiltrado("_DatosRequerimiento", oRsDet.Fields("IdDetalleRequerimiento").Value)
                           If oRs1.RecordCount > 0 Then
                              If Not IsNull(oRs1.Fields("IdControlCalidad").Value) Then
                                 .Registro.Fields("IdControlCalidad").Value = oRs1.Fields("IdControlCalidad").Value
                              End If
                              If IsNull(.Registro.Fields("IdCuenta").Value) Then
                                 .Registro.Fields("IdCuenta").Value = oRs1.Fields("IdCuenta").Value
                              End If
                           End If
                           oRs1.Close
                        End If
                     End If
                     IdCCal = 0
                     If Not IsNull(.Registro.Fields("IdControlCalidad").Value) Then
                        IdCCal = .Registro.Fields("IdControlCalidad").Value
                     End If
                  End With
                  With origen.Registro
                     .Fields("IdProveedor").Value = oRsPre.Fields("IdProveedor").Value
                     .Fields("Observaciones").Value = oRsPre.Fields("Observaciones").Value
                     .Fields("PorcentajeBonificacion").Value = oRsPre.Fields("Bonificacion").Value
                     .Fields("Garantia").Value = oRsPre.Fields("Garantia").Value
                     .Fields("LugarEntrega").Value = oRsPre.Fields("LugarEntrega").Value
                     .Fields("IdComprador").Value = oRsPre.Fields("IdComprador").Value
                     .Fields("Contacto").Value = oRsPre.Fields("Contacto").Value
                     .Fields("Bonificacion").Value = oRsPre.Fields("ImporteBonificacion").Value
                     .Fields("TotalIva1").Value = oRsPre.Fields("ImporteIva1").Value
                     .Fields("TotalPedido").Value = oRsPre.Fields("ImporteTotal").Value
                     .Fields("PorcentajeIva1").Value = oRsPre.Fields("PorcentajeIva1").Value
                     .Fields("PorcentajeIva2").Value = oRsPre.Fields("PorcentajeIva2").Value
                     .Fields("IdMoneda").Value = oRsPre.Fields("IdMoneda").Value
                     .Fields("DetalleCondicionCompra").Value = oRsPre.Fields("DetalleCondicionCompra").Value
                     .Fields("IdCondicionCompra").Value = oRsPre.Fields("IdCondicionCompra").Value
                     For i = 0 To 9
                        .Fields("ArchivoAdjunto" & i + 1).Value = oRsPre.Fields("ArchivoAdjunto" & i + 1).Value
                     Next
                  End With
               End If
               oRsDet.MoveNext
            Loop
                  
            oRsPre.Close
            oRsDet.Close
      
         End If
            
      End If
   
   End If
   
   oRsComp.Close
   
Salida:

   Set oRs = Nothing
   Set oRs1 = Nothing
   Set oRsPre = Nothing
   Set oRsDet = Nothing
   Set oPre = Nothing
   Set oRsComp = Nothing
   Set oAp = Nothing
            
   CalculaPedido

   Exit Sub
   
Mal:

   MsgBox "No se ha podido completar la operacion" & vbCrLf & Err.Description, vbCritical
   GoTo Salida
   
End Sub

Private Sub PideAutorizacion()

   Dim oF As frmAutorizacion1
   Set oF = New frmAutorizacion1
   With oF
      .IdUsuario = dcfields(2).BoundText
      .Show vbModal, Me
   End With
   If Not oF.Ok Then
      With origen.Registro
         .Fields(dcfields(2).DataField).Value = Null
         .Fields("FechaAprobacion").Value = Null
      End With
      Check1(0).Value = 0
      mIdAprobo = 0
   Else
      With origen.Registro
         .Fields("FechaAprobacion").Value = Now
         mIdAprobo = .Fields("Aprobo").Value
      End With
      Check1(0).Value = 1
   End If
   Unload oF
   Set oF = Nothing

End Sub

Private Sub txtSubnumero_GotFocus()

   With txtSubnumero
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtSubnumero_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Sub EnviarPedidoPorEmail()

   If Not CircuitoFirmasCompleto(NotaPedido, mvarId, txtTotal(0).Text) Then
      MsgBox "Para enviar el pedido debe estar completo el circuito de autorizaciones", vbCritical
      Exit Sub
   End If
   
   Dim oAp As ComPronto.Aplicacion
   Dim goMailOL As CEmailOL
   Dim oRs As ADOR.Recordset
   Dim oRsProv As ADOR.Recordset
   Dim mAttachment As String, mLista As String, mSubject As String, mBody As String
   Dim mPed As String, mPedAd As String
   Dim lStatus As Long, mIdProveedor As Long
   Dim i As Integer
   Dim mOk As Boolean
   Dim mVector
   
   On Error GoTo Salida
   
   mIdProveedor = dcfields(0).BoundText
   
   Set oAp = Aplicacion
   
   Set oRsProv = oAp.Proveedores.Item(mIdProveedor).Registro
   If Len(oRsProv.Fields("Email").Value) = 0 Or IsNull(oRsProv.Fields("Email").Value) Then
      MsgBox "El proveedor " & oRsProv.Fields("RazonSocial").Value & " no tiene email", vbExclamation
      oRsProv.Close
      GoTo Salida
   End If
   
   Me.AccesoParaMailInterno = True
   cmdImpre_Click 2
   Me.AccesoParaMailInterno = False
   
   mPed = App.Path & "\Pedido.rtf"
   mPedAd = App.Path & "\PedidoAdicional.rtf"
   mAttachment = ""
   If Len(Trim(Dir(mPed))) <> 0 Then
      mAttachment = mAttachment & mPed & ","
   End If
   If Len(Trim(Dir(mPedAd))) <> 0 Then
      mAttachment = mAttachment & mPedAd & ","
   End If
      
   Set oRs = oAp.Pedidos.TraerFiltrado("_AdjuntosPorPedido", mvarId)
   
   If oRs.RecordCount > 0 Then
      oRs.MoveFirst
      Do While Not oRs.EOF
         If Len(Trim(Dir(oRs.Fields("Adjunto").Value))) <> 0 Then
            mAttachment = mAttachment & oRs.Fields("Adjunto").Value & ","
         End If
         oRs.MoveNext
      Loop
   End If

   If Len(mAttachment) > 0 Then
      mAttachment = mId(mAttachment, 1, Len(mAttachment) - 1)
   End If
   
   mLista = oRsProv.Fields("Email").Value
   mSubject = glbEmpresa & " - Pedido " & txtNumeroPedido.Text & "/" & txtSubnumero.Text
   
   mBody = ""
   For i = 1 To 10
      mBody = mBody & BuscarClaveINI("Body de pedido para envio por mail " & i) & vbCrLf
   Next
   
   Dim oF As frmCorreo
   Set oF = New frmCorreo
   With oF
      .Email = mLista
      .IdProveedor = mIdProveedor
      .CargarDirecciones
      .txtAsunto.Text = mSubject
      .txtBody.Text = mBody
      .Attachment = mAttachment
      If BuscarClaveINI("Pedir confirmacion de mail de pedido") = "SI" Then
         .Show vbModal, Me
         mOk = .Ok
      Else
         mOk = True
      End If
      mLista = .Email
      mSubject = .txtAsunto.Text
      mBody = .txtBody.Text
      mAttachment = .Attachment
   End With
   Unload oF

   oRs.Close
   oRsProv.Close
   
   If mOk Then
      Set goMailOL = New CEmailOL
      If InStr(1, mLista, ";") <> 0 Then
         mVector = VBA.Split(mLista, ";")
         For i = 0 To UBound(mVector)
            lStatus = goMailOL.Send(mVector(i), True, mSubject, mBody, mAttachment)
         Next
      Else
         lStatus = goMailOL.Send(mLista, True, mSubject, mBody, mAttachment)
      End If
   End If
   
Salida:
   
   If Len(Trim(mPed)) <> 0 Then
      If Len(Trim(Dir(mPed))) <> 0 Then Kill mPed
   End If
   If Len(Trim(mPedAd)) <> 0 Then
      If Len(Trim(Dir(mPedAd))) <> 0 Then Kill mPedAd
   End If
   Set oRs = Nothing
   Set oRsProv = Nothing
   Set oAp = Nothing
   Set goMailOL = Nothing
   Set oF = Nothing

End Sub

Private Function HayAdjuntos() As Boolean

   Dim i As Integer
   
   HayAdjuntos = False
   
   With origen.Registro
      For i = 0 To 9
         If Not IsNull(.Fields("ArchivoAdjunto" & i + 1).Value) Then
            If Len(.Fields("ArchivoAdjunto" & i + 1).Value) > 0 Then
               HayAdjuntos = True
               Exit For
            End If
         End If
      Next
   End With
   
End Function

Public Sub AsignaFechaNecesidad()

   Dim mvarOK, mvarCancelo As Boolean
   
   Dim oF As frmAutorizacion2
   Set oF = New frmAutorizacion2
   With oF
      .Sector = "Compras"
      .Show vbModal, Me
   End With
   mvarOK = oF.Ok
   mvarCancelo = oF.Cancelo
   Unload oF
   Set oF = Nothing
   If mvarCancelo Then
      Exit Sub
   End If
   If Not mvarOK Then
'      MsgBox "Solo personal de PLANEAMIENTO puede asignar fechas de necesidad", vbExclamation
      Exit Sub
   End If
   
   Dim of1 As frmAsignaFechaNecesidad
   Dim oL As ListItem
   Dim oDet As ComPronto.DetPedido
   Dim mvarFechaNecesidad As Date
   
   Set of1 = New frmAsignaFechaNecesidad
   
   With of1
      .Show vbModal, Me
      mvarOK = .Ok
      mvarFechaNecesidad = .DTFields(0).Value
   End With
   
   Unload of1
   Set of1 = Nothing
   
   If Not mvarOK Then
      Exit Sub
   End If
   
   If mvarFechaNecesidad < DTFields(0).Value Then
      DoEvents
      MsgBox "La fecha de necesidad no puede ser anterior" & vbCrLf & "a la fecha del pedido", vbExclamation
      Exit Sub
   End If
   
   For Each oL In Lista.ListItems
      With oL
         If .Selected Then
            .SubItems(9) = "" & mvarFechaNecesidad
            Set oDet = origen.DetPedidos.Item(.Tag)
            oDet.Registro.Fields("FechaNecesidad").Value = mvarFechaNecesidad
            oDet.Modificado = True
            Set oDet = Nothing
            .SmallIcon = "Modificado"
         End If
      End With
   Next
   
'   mvarModificado = True
   
End Sub

Public Sub AsignaFechaEntrega()

   Dim mvarOK, mvarCancelo As Boolean
   
   Dim oF As frmAutorizacion2
   Set oF = New frmAutorizacion2
   With oF
      .Sector = "Compras"
      .Show vbModal, Me
   End With
   mvarOK = oF.Ok
   mvarCancelo = oF.Cancelo
   Unload oF
   Set oF = Nothing
   If mvarCancelo Then
      Exit Sub
   End If
   If Not mvarOK Then
'      MsgBox "Solo personal de PLANEAMIENTO puede asignar fechas de necesidad", vbExclamation
      Exit Sub
   End If
   
   Dim of1 As frmAsignaFechaNecesidad
   Dim oL As ListItem
   Dim oDet As ComPronto.DetPedido
   Dim mvarFechaEntrega As Date
   
   Set of1 = New frmAsignaFechaNecesidad
   
   With of1
      .Caption = "Asigna una fecha de entrega"
      .lblLabels(0).Caption = "Fecha de entrega :"
      .Show vbModal, Me
      mvarOK = .Ok
      mvarFechaEntrega = .DTFields(0).Value
   End With
   
   Unload of1
   Set of1 = Nothing
   
   If Not mvarOK Then
      Exit Sub
   End If
   
   If mvarFechaEntrega < DTFields(0).Value Then
      DoEvents
      MsgBox "La fecha de entrega no puede ser anterior" & vbCrLf & "a la fecha del pedido", vbExclamation
      Exit Sub
   End If
   
   For Each oL In Lista.ListItems
      With oL
         If .Selected Then
            .SubItems(8) = "" & mvarFechaEntrega
            Set oDet = origen.DetPedidos.Item(.Tag)
            oDet.Registro.Fields("FechaEntrega").Value = mvarFechaEntrega
            oDet.Modificado = True
            Set oDet = Nothing
            .SmallIcon = "Modificado"
         End If
      End With
   Next
   
'   mvarModificado = True
   
End Sub

Private Sub AsignaBonificacion(ByVal mAmbito As String)

   If mvarId > 0 And Not IsNull(origen.Registro.Fields("Aprobo").Value) Then
      MsgBox "No puede modificar un pedido ya registrado", vbCritical
      Exit Sub
   End If
   
   If mvarAnulada Then
      MsgBox "El pedido ha sido anulado y no puede modificarse!", vbCritical
      Exit Sub
   End If

   Dim mvarOK As Boolean
   Dim mPorcentajeBonificacion As Double
   Dim oF As frmAsignaNumero
   Set oF = New frmAsignaNumero
   With oF
      .Caption = "Ingreso de % de bonificacion"
      .lblEti.Caption = "Ingrese % de bonificacion :"
      .Show vbModal, Me
      mvarOK = .Ok
      If mvarOK Then mPorcentajeBonificacion = Val(.txtNumero.Text)
   End With
   Unload oF
   Set oF = Nothing
   If Not mvarOK Then
      Exit Sub
   End If
   
   Dim mImporte As Double, mBonificacion As Double, mImporteItem As Double
   Dim mIVA As Double, mPorcentajeIVA As Double
   Dim mId As Long
   Dim oL As ListItem
   
   For Each oL In Lista.ListItems
      If oL.Selected Or mAmbito = "T" Then
         mId = oL.Tag
         With origen.DetPedidos.Item(mId)
            .Registro.Fields("PorcentajeBonificacion").Value = mPorcentajeBonificacion
            mImporte = (.Registro.Fields("Precio").Value * .Registro.Fields("Cantidad").Value)
            mBonificacion = Round(mImporte * mPorcentajeBonificacion / 100, 4)
            If Not IsNull(.Registro.Fields("PorcentajeIVA").Value) Then
               mPorcentajeIVA = .Registro.Fields("PorcentajeIVA").Value
               mIVA = Round((mImporte - mBonificacion) * .Registro.Fields("PorcentajeIVA").Value / 100, 4)
            Else
               mPorcentajeIVA = 0
               mIVA = 0
            End If
            mImporteItem = mImporte - mBonificacion + mIVA
            .Registro.Fields("ImporteBonificacion").Value = mBonificacion
            .Registro.Fields("ImporteIVA").Value = mIVA
            .Registro.Fields("ImporteTotalItem").Value = mImporteItem
            .Modificado = True
            oL.SubItems(11) = "" & Format(mImporte, "#0.0000")
            oL.SubItems(12) = "" & Format(mPorcentajeBonificacion, "Fixed")
            oL.SubItems(13) = "" & Format(mBonificacion, "#0.0000")
            oL.SubItems(14) = "" & Format(mImporteItem, "#0.0000")
            oL.SubItems(15) = "" & Format(mPorcentajeIVA, "Fixed")
            oL.SubItems(16) = "" & Format(mIVA, "#0.0000")
            oL.SubItems(17) = "" & Format(mImporteItem, "#0.0000")
         End With
         oL.SmallIcon = "Modificado"
      End If
   Next
   
   CalculaPedido
   
'   mvarModificado = True
   
End Sub

Private Sub AsignaIVA(ByVal mAmbito As String)

   If mvarId > 0 And Not IsNull(origen.Registro.Fields("Aprobo").Value) Then
      MsgBox "No puede modificar un pedido ya registrado", vbCritical
      Exit Sub
   End If
   
   If mvarAnulada Then
      MsgBox "El pedido ha sido anulado y no puede modificarse!", vbCritical
      Exit Sub
   End If

   Dim mvarOK As Boolean
   Dim mPorcentajeIVA As Double
   Dim oF As frmAsignaNumero
   Set oF = New frmAsignaNumero
   With oF
      .Caption = "Ingreso de % de IVA"
      .lblEti.Caption = "Ingrese % de IVA :"
      .Show vbModal, Me
      mvarOK = .Ok
      If mvarOK Then mPorcentajeIVA = Val(.txtNumero.Text)
   End With
   Unload oF
   Set oF = Nothing
   If Not mvarOK Then
      Exit Sub
   End If
   
   Dim mImporte As Double, mBonificacion As Double, mImporteItem As Double
   Dim mIVA As Double
   Dim mId As Long
   Dim oL As ListItem
   
   For Each oL In Lista.ListItems
      If oL.Selected Or mAmbito = "T" Then
         mId = oL.Tag
         With origen.DetPedidos.Item(mId)
            .Registro.Fields("PorcentajeIVA").Value = mPorcentajeIVA
            mImporte = (.Registro.Fields("Precio").Value * .Registro.Fields("Cantidad").Value)
            mBonificacion = IIf(IsNull(.Registro.Fields("ImporteBonificacion").Value), 0, .Registro.Fields("ImporteBonificacion").Value)
            mIVA = Round((mImporte - mBonificacion) * .Registro.Fields("PorcentajeIVA").Value / 100, 4)
            mImporteItem = mImporte - mBonificacion + mIVA
            .Registro.Fields("ImporteIVA").Value = mIVA
            .Registro.Fields("ImporteTotalItem").Value = mImporteItem
            .Modificado = True
            oL.SubItems(15) = "" & Format(mPorcentajeIVA, "Fixed")
            oL.SubItems(16) = "" & Format(mIVA, "#0.0000")
            oL.SubItems(17) = "" & Format(mImporteItem, "#0.0000")
         End With
         oL.SmallIcon = "Modificado"
      End If
   Next
   
   CalculaPedido
   
'   mvarModificado = True
   
End Sub

Public Sub DuplicarItem()

   Dim oRs As ADOR.Recordset
   Dim idDet As Long, i As Long, mItem As Long
   
   Set oRs = origen.DetPedidos.Item(Lista.SelectedItem.Tag).Registro
   
   mItem = origen.DetPedidos.UltimoItemDetalle
   
   With origen.DetPedidos.Item(-1)
      For i = 2 To oRs.Fields.Count - 1
         .Registro.Fields(i).Value = oRs.Fields(i).Value
      Next
      .Registro.Fields("NumeroItem").Value = mItem
      .Modificado = True
      idDet = .Id
   End With
   Set oRs = Nothing
   
   Set Lista.DataSource = origen.DetPedidos.RegistrosConFormato
   
   CalculaPedido

End Sub

Public Sub ActivarAnulacionLiberacion(ByVal Activar As Boolean)

   If Activar Then
      
   Else
      cmdAnularLiberacion.Visible = False
      With dcfields(2)
         .Left = dcfields(7).Left
         .Width = dcfields(7).Width
      End With
   End If

End Sub

Public Function VerificarAnulacionItem(ByVal mIdDetallePedido As Long) As Boolean

   Dim oRs As ADOR.Recordset
   Dim mError As String
   
   mError = ""
   Set oRs = Aplicacion.Pedidos.TraerFiltrado("_RecepcionesPorIdDetallePedido", mIdDetallePedido)
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            mError = mError & vbCrLf & "El item " & IIf(IsNull(.Fields("NumeroItem").Value), "", .Fields("NumeroItem").Value) & " " & _
                        "no puede ser anulado porque esta incluido en la recepcion " & _
                        IIf(IsNull(.Fields("Comprobante").Value), "", .Fields("Comprobante").Value) & " " & _
                        "del " & IIf(IsNull(.Fields("FechaRecepcion").Value), "", .Fields("FechaRecepcion").Value)
            .MoveNext
         Loop
      End If
      .Close
   End With
   Set oRs = Nothing
   If Len(mError) > 0 Then
      MsgBox "Se encontraron los siguientes errores : " & mError, vbExclamation
      VerificarAnulacionItem = False
   Else
      VerificarAnulacionItem = True
   End If

End Function

Public Sub AsignarOrigenDescripcion(ByVal OrigenDescripcion As Integer)

   If mvarId > 0 And Not IsNull(origen.Registro.Fields("Aprobo").Value) Then
      MsgBox "No puede modificar un pedido ya registrado", vbCritical
      Exit Sub
   End If
   
   If mvarAnulada Then
      MsgBox "El pedido ha sido anulado y no puede modificarse!", vbCritical
      Exit Sub
   End If

   Dim mId As Long
   Dim oL As ListItem
   
   For Each oL In Lista.ListItems
      If oL.Selected Then
         mId = oL.Tag
         With origen.DetPedidos.Item(mId)
            .Registro.Fields("OrigenDescripcion").Value = OrigenDescripcion
            .Modificado = True
         End With
         oL.SmallIcon = "Modificado"
      End If
   Next
   
End Sub

Private Sub AsignaPrecio(ByVal mAmbito As String)

   If mvarId > 0 And Not IsNull(origen.Registro.Fields("Aprobo").Value) Then
      MsgBox "No puede modificar un pedido ya registrado", vbCritical
      Exit Sub
   End If
   
   If mvarAnulada Then
      MsgBox "El pedido ha sido anulado y no puede modificarse!", vbCritical
      Exit Sub
   End If

   Dim mvarOK As Boolean
   Dim mPrecio As Double
   Dim oF As frmAsignaNumero
   Set oF = New frmAsignaNumero
   With oF
      .Caption = "Ingreso de precios"
      .lblEti.Caption = "Ingrese el precio :"
      .Show vbModal, Me
      mvarOK = .Ok
      If mvarOK Then mPrecio = Val(.txtNumero.Text)
   End With
   Unload oF
   Set oF = Nothing
   If Not mvarOK Then
      Exit Sub
   End If
   
   Dim mImporte As Double, mBonificacion As Double, mImporteItem As Double
   Dim mIVA As Double, mPorcentajeIVA As Double
   Dim mIdDet As Long
   Dim oL As ListItem
   
   For Each oL In Lista.ListItems
      If oL.Selected Or mAmbito = "T" Then
         mIdDet = oL.Tag
         With origen.DetPedidos.Item(mIdDet)
            .Registro.Fields("Precio").Value = mPrecio
            mImporte = (.Registro.Fields("Precio").Value * .Registro.Fields("Cantidad").Value)
            mBonificacion = Round(mImporte * IIf(IsNull(.Registro.Fields("PorcentajeBonificacion").Value), 0, .Registro.Fields("PorcentajeBonificacion").Value), 4)
            If Not IsNull(.Registro.Fields("PorcentajeIVA").Value) Then
               mPorcentajeIVA = .Registro.Fields("PorcentajeIVA").Value
               mIVA = Round((mImporte - mBonificacion) * .Registro.Fields("PorcentajeIVA").Value / 100, 4)
            Else
               mPorcentajeIVA = 0
               mIVA = 0
            End If
            mImporteItem = mImporte - mBonificacion + mIVA
            .Registro.Fields("ImporteBonificacion").Value = mBonificacion
            .Registro.Fields("ImporteIVA").Value = mIVA
            .Registro.Fields("ImporteTotalItem").Value = mImporteItem
            .Modificado = True
            oL.SubItems(10) = "" & Format(mPrecio, "#0.0000")
            oL.SubItems(11) = "" & Format(mImporte, "#0.0000")
            oL.SubItems(13) = "" & Format(mBonificacion, "#0.0000")
            oL.SubItems(14) = "" & Format(mImporteItem, "#0.0000")
            oL.SubItems(15) = "" & Format(mPorcentajeIVA, "Fixed")
            oL.SubItems(16) = "" & Format(mIVA, "#0.0000")
            oL.SubItems(17) = "" & Format(mImporteItem, "#0.0000")
         End With
         oL.SmallIcon = "Modificado"
      End If
   Next
   
   CalculaPedido
   
'   mvarModificado = True
   
End Sub

Public Property Get VisualizacionSimplificada() As Boolean

   VisualizacionSimplificada = mVisualizacionSimplificada

End Property

Public Property Let VisualizacionSimplificada(ByVal vNewValue As Boolean)

   mVisualizacionSimplificada = vNewValue

End Property

Public Sub RenumerarItems()

   Dim oL As ListItem
   Dim i As Integer
   
   i = 1
   For Each oL In Lista.ListItems
      With origen.DetPedidos.Item(oL.Tag)
         If Not .Eliminado Then
            .Registro.Fields("NumeroItem").Value = i
            .Modificado = True
            oL.Text = i
            i = i + 1
         End If
      End With
   Next

End Sub

Public Sub DatosExportacion()

   Dim mOk As Boolean
   
   Dim oF As frm_Aux
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Datos exportacion"
      With .Label2(0)
         .Caption = "Embarcado a :"
         .Visible = True
      End With
      With .Text2
         .Top = oF.DTFields(0).Top
         .Left = oF.Text1.Left
         .Text = IIf(IsNull(origen.Registro.Fields("EmbarcadoA").Value), dcfields(0).Text, _
                           origen.Registro.Fields("EmbarcadoA").Value)
         .Width = .Width * 2
         .Visible = True
      End With
      .Label1.Caption = "Facturar a :"
      With .Text1
         .Text = IIf(IsNull(origen.Registro.Fields("FacturarA").Value), dcfields(0).Text, _
                           origen.Registro.Fields("FacturarA").Value)
         .Width = .Width * 2
      End With
      With .Label2(1)
         .Caption = "Proveedor ext.:"
         .Visible = True
      End With
      With .Text3
         .Top = oF.DTFields(1).Top
         .Left = oF.Text1.Left
         .Text = IIf(IsNull(origen.Registro.Fields("ProveedorExt").Value), dcfields(0).Text, _
                           origen.Registro.Fields("ProveedorExt").Value)
         .Width = .Width * 2
         .Visible = True
      End With
      .cmd(0).Top = .Text3.Top + .Text3.Height + 100
      .cmd(0).Left = .Label2(1).Left
      .cmd(1).Top = .cmd(0).Top
      .Width = .Width * 1.3
      .Height = .Height * 0.9
      .Show vbModal, Me
      
      mOk = True
      If .Ok Then
         With origen.Registro
            .Fields("EmbarcadoA").Value = oF.Text2.Text
            .Fields("FacturarA").Value = oF.Text1.Text
            .Fields("ProveedorExt").Value = oF.Text3.Text
         End With
      End If
   End With
   
   Unload oF
   Set oF = Nothing

End Sub


