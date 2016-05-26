VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmPedidosSAT 
   Caption         =   "Nota de pedido en PRONTO SAT"
   ClientHeight    =   7680
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11850
   LinkTopic       =   "Form1"
   ScaleHeight     =   7680
   ScaleWidth      =   11850
   StartUpPosition =   3  'Windows Default
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
      Left            =   2655
      TabIndex        =   35
      Top             =   90
      Width           =   1050
   End
   Begin VB.TextBox txtCondicionIva 
      Enabled         =   0   'False
      Height          =   285
      Left            =   7740
      TabIndex        =   34
      Top             =   1620
      Width           =   1995
   End
   Begin VB.TextBox txtCuit 
      Enabled         =   0   'False
      Height          =   285
      Left            =   10305
      TabIndex        =   33
      Top             =   1620
      Width           =   1410
   End
   Begin VB.TextBox txtEmail 
      Enabled         =   0   'False
      Height          =   285
      Left            =   7740
      TabIndex        =   32
      Top             =   1305
      Width           =   3975
   End
   Begin VB.TextBox txtTelefono 
      Enabled         =   0   'False
      Height          =   285
      Left            =   7740
      TabIndex        =   31
      Top             =   990
      Width           =   3975
   End
   Begin VB.TextBox txtProvincia 
      Enabled         =   0   'False
      Height          =   285
      Left            =   7740
      TabIndex        =   30
      Top             =   675
      Width           =   3975
   End
   Begin VB.TextBox txtLocalidad 
      Enabled         =   0   'False
      Height          =   285
      Left            =   7740
      TabIndex        =   29
      Top             =   360
      Width           =   3975
   End
   Begin VB.TextBox txtDireccion 
      Enabled         =   0   'False
      Height          =   285
      Left            =   7740
      TabIndex        =   28
      Top             =   45
      Width           =   3975
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0FF&
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
      Height          =   360
      Index           =   0
      Left            =   10350
      Locked          =   -1  'True
      TabIndex        =   27
      Top             =   7245
      Width           =   1410
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   510
      Index           =   0
      Left            =   90
      TabIndex        =   26
      Top             =   7020
      Width           =   795
   End
   Begin VB.TextBox txtSubtotal 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   300
      Left            =   10350
      TabIndex        =   25
      Top             =   5355
      Width           =   1410
   End
   Begin VB.TextBox txtBonificacion 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   10350
      TabIndex        =   24
      Top             =   5985
      Width           =   1410
   End
   Begin VB.TextBox txtNeto 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   10350
      TabIndex        =   23
      Top             =   6300
      Width           =   1410
   End
   Begin VB.TextBox txtTotalIva1 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   10350
      TabIndex        =   22
      Top             =   6615
      Width           =   1410
   End
   Begin VB.TextBox txtTelefonoComprador 
      Enabled         =   0   'False
      Height          =   330
      Left            =   4635
      TabIndex        =   19
      Top             =   1755
      Width           =   1500
   End
   Begin VB.TextBox txtEmailComprador 
      Enabled         =   0   'False
      Height          =   330
      Left            =   1440
      TabIndex        =   18
      Top             =   1755
      Width           =   2760
   End
   Begin VB.TextBox txtPorcentajeBonificacion 
      Alignment       =   1  'Right Justify
      DataField       =   "PorcentajeBonificacion"
      Height          =   255
      Left            =   9720
      TabIndex        =   17
      Top             =   5985
      Width           =   510
   End
   Begin VB.TextBox txtContacto 
      DataField       =   "Contacto"
      Height          =   330
      Left            =   1755
      TabIndex        =   16
      Top             =   855
      Width           =   2310
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   6
      Left            =   8865
      TabIndex        =   15
      Top             =   2880
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   5
      Left            =   8640
      TabIndex        =   14
      Top             =   2880
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   4
      Left            =   8415
      TabIndex        =   13
      Top             =   2880
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   3
      Left            =   8190
      TabIndex        =   12
      Top             =   2880
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   2
      Left            =   7965
      TabIndex        =   11
      Top             =   2880
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   1
      Left            =   7740
      TabIndex        =   10
      Top             =   2880
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   0
      Left            =   7515
      TabIndex        =   9
      Top             =   2880
      Visible         =   0   'False
      Width           =   150
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
      Left            =   4140
      TabIndex        =   8
      Top             =   1005
      Width           =   1995
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
      Left            =   7515
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   7
      Top             =   2025
      Width           =   4200
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
      Left            =   3870
      TabIndex        =   6
      Top             =   90
      Width           =   330
   End
   Begin VB.TextBox txtBonificacionPorItem 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   10350
      TabIndex        =   5
      Top             =   5670
      Width           =   1410
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
      Left            =   6615
      TabIndex        =   4
      Top             =   5355
      Width           =   1050
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
      Left            =   4095
      TabIndex        =   3
      Top             =   5355
      Width           =   1050
   End
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Exterior"
      Height          =   285
      Left            =   1800
      TabIndex        =   2
      Top             =   90
      Width           =   825
   End
   Begin VB.CheckBox Check3 
      Alignment       =   1  'Right Justify
      Caption         =   "Subcontrato"
      Height          =   285
      Left            =   4905
      TabIndex        =   1
      Top             =   1395
      Width           =   1230
   End
   Begin VB.TextBox txtImpuestosInternos 
      Alignment       =   1  'Right Justify
      DataField       =   "ImpuestosInternos"
      Height          =   285
      Left            =   10350
      TabIndex        =   0
      Top             =   6930
      Width           =   1410
   End
   Begin RichTextLib.RichTextBox rchObservacionesItem 
      Height          =   285
      Left            =   8100
      TabIndex        =   20
      Top             =   5400
      Visible         =   0   'False
      Width           =   195
      _ExtentX        =   344
      _ExtentY        =   503
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmPedidosSAT.frx":0000
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1005
      Left            =   45
      TabIndex        =   21
      Top             =   5940
      Width           =   4470
      _ExtentX        =   7885
      _ExtentY        =   1773
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmPedidosSAT.frx":0082
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaPedido"
      Height          =   330
      Index           =   0
      Left            =   4905
      TabIndex        =   36
      Top             =   90
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   64618497
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   0
      Left            =   1770
      TabIndex        =   37
      Tag             =   "Proveedores"
      Top             =   465
      Width           =   4380
      _ExtentX        =   7726
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   2175
      Left            =   0
      TabIndex        =   38
      Top             =   3150
      Width           =   11805
      _ExtentX        =   20823
      _ExtentY        =   3836
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmPedidosSAT.frx":0104
      OLEDragMode     =   1
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdComprador"
      Height          =   315
      Index           =   1
      Left            =   1440
      TabIndex        =   39
      Tag             =   "Empleados"
      Top             =   1395
      Width           =   3345
      _ExtentX        =   5900
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
      Left            =   1440
      TabIndex        =   40
      Tag             =   "Empleados"
      Top             =   2115
      Width           =   4695
      _ExtentX        =   8281
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   4
      Left            =   855
      TabIndex        =   41
      Tag             =   "Monedas"
      Top             =   5355
      Width           =   1545
      _ExtentX        =   2725
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   3240
      Top             =   5670
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
            Picture         =   "frmPedidosSAT.frx":0120
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPedidosSAT.frx":0232
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPedidosSAT.frx":0684
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPedidosSAT.frx":0AD6
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin RichTextLib.RichTextBox rchMotivoAnulacion 
      Height          =   285
      Left            =   7920
      TabIndex        =   42
      Top             =   5400
      Visible         =   0   'False
      Width           =   195
      _ExtentX        =   344
      _ExtentY        =   503
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmPedidosSAT.frx":0F28
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
      Height          =   1005
      Left            =   4590
      TabIndex        =   43
      Top             =   5940
      Width           =   3750
      _ExtentX        =   6615
      _ExtentY        =   1773
      _Version        =   393217
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmPedidosSAT.frx":0FAC
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCondicionCompra"
      Height          =   315
      Index           =   7
      Left            =   1440
      TabIndex        =   44
      Tag             =   "CondicionesCompra"
      Top             =   2475
      Width           =   4695
      _ExtentX        =   8281
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCondicionCompra"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Pedido numero :"
      Height          =   285
      Index           =   14
      Left            =   135
      TabIndex        =   77
      Top             =   90
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      Caption         =   "Condicion Iva :"
      Height          =   195
      Index           =   13
      Left            =   6615
      TabIndex        =   76
      Top             =   1665
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "CUIT :"
      Height          =   195
      Index           =   12
      Left            =   9810
      TabIndex        =   75
      Top             =   1665
      Width           =   450
   End
   Begin VB.Label lblLabels 
      Caption         =   "Email :"
      Height          =   195
      Index           =   11
      Left            =   6615
      TabIndex        =   74
      Top             =   1350
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Telefono :"
      Height          =   195
      Index           =   10
      Left            =   6615
      TabIndex        =   73
      Top             =   1035
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Provincia :"
      Height          =   195
      Index           =   9
      Left            =   6615
      TabIndex        =   72
      Top             =   720
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Localidad :"
      Height          =   195
      Index           =   8
      Left            =   6615
      TabIndex        =   71
      Top             =   405
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Direccion :"
      Height          =   195
      Index           =   7
      Left            =   6615
      TabIndex        =   70
      Top             =   90
      Width           =   1080
   End
   Begin VB.Label lblData 
      Caption         =   "Proveedor :"
      Height          =   285
      Index           =   0
      Left            =   135
      TabIndex        =   69
      Top             =   495
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   285
      Index           =   4
      Left            =   4275
      TabIndex        =   68
      Top             =   120
      Width           =   585
   End
   Begin VB.Label Label1 
      Caption         =   "Subtotal :"
      Height          =   195
      Index           =   0
      Left            =   8460
      TabIndex        =   67
      Top             =   5400
      Width           =   1770
   End
   Begin VB.Label Label1 
      Caption         =   "Bonificacion :"
      Height          =   240
      Index           =   1
      Left            =   8460
      TabIndex        =   66
      Top             =   5985
      Width           =   1185
   End
   Begin VB.Label Label1 
      Caption         =   "Subtotal gravado :"
      Height          =   240
      Index           =   2
      Left            =   8460
      TabIndex        =   65
      Top             =   6300
      Width           =   1770
   End
   Begin VB.Label lblIVA1 
      Caption         =   "IVA"
      Height          =   240
      Left            =   8460
      TabIndex        =   64
      Top             =   6615
      Width           =   1770
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
      TabIndex        =   63
      Top             =   7245
      Width           =   1770
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
      Left            =   45
      TabIndex        =   62
      Top             =   5760
      Width           =   2355
   End
   Begin VB.Label lblLabels 
      Caption         =   "TE :"
      Height          =   285
      Index           =   1
      Left            =   4275
      TabIndex        =   61
      Top             =   1755
      Width           =   300
   End
   Begin VB.Label lblLabels 
      Caption         =   "Email comprador :"
      Height          =   285
      Index           =   19
      Left            =   90
      TabIndex        =   60
      Top             =   1755
      Width           =   1305
   End
   Begin VB.Label lblData 
      Caption         =   "Comprador :"
      Height          =   285
      Index           =   1
      Left            =   90
      TabIndex        =   59
      Top             =   1395
      Width           =   1305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Contacto : "
      Height          =   285
      Index           =   15
      Left            =   135
      TabIndex        =   58
      Top             =   900
      Width           =   1575
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      X1              =   6300
      X2              =   6300
      Y1              =   45
      Y2              =   1890
   End
   Begin VB.Line Line2 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      X1              =   6570
      X2              =   6300
      Y1              =   45
      Y2              =   45
   End
   Begin VB.Line Line3 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      X1              =   6615
      X2              =   6300
      Y1              =   1890
      Y2              =   1890
   End
   Begin VB.Line Line4 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      Index           =   0
      X1              =   6165
      X2              =   6300
      Y1              =   585
      Y2              =   585
   End
   Begin VB.Line Line4 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      Index           =   1
      X1              =   90
      X2              =   6120
      Y1              =   1305
      Y2              =   1305
   End
   Begin VB.Label lblData 
      Caption         =   "Liberado por :"
      Height          =   285
      Index           =   2
      Left            =   90
      TabIndex        =   57
      Top             =   2115
      Width           =   1305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Autorizaciones : "
      Height          =   240
      Index           =   6
      Left            =   6255
      TabIndex        =   56
      Top             =   2835
      Width           =   1215
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
      Left            =   4140
      TabIndex        =   55
      Top             =   810
      Width           =   1680
   End
   Begin VB.Label lblData 
      Caption         =   "Aclaracion sobre las condiciones compra :"
      Height          =   645
      Index           =   5
      Left            =   6255
      TabIndex        =   54
      Top             =   2070
      Width           =   1215
      WordWrap        =   -1  'True
   End
   Begin VB.Line Line5 
      BorderColor     =   &H80000005&
      BorderWidth     =   3
      X1              =   3825
      X2              =   3735
      Y1              =   90
      Y2              =   405
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
      Left            =   9315
      TabIndex        =   53
      Top             =   2835
      Visible         =   0   'False
      Width           =   2385
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Moneda :"
      Height          =   240
      Index           =   4
      Left            =   45
      TabIndex        =   52
      Top             =   5400
      Width           =   765
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
      Left            =   45
      TabIndex        =   51
      Top             =   2925
      Width           =   1545
   End
   Begin VB.Label Label1 
      Caption         =   "Bonificaciones por item : "
      Height          =   240
      Index           =   3
      Left            =   8460
      TabIndex        =   50
      Top             =   5670
      Width           =   1770
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cotizacion dolar :"
      Height          =   240
      Index           =   18
      Left            =   5265
      TabIndex        =   49
      Top             =   5400
      Width           =   1305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Conversion a Pesos :"
      Height          =   240
      Index           =   17
      Left            =   2520
      TabIndex        =   48
      Top             =   5400
      Width           =   1530
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
      Left            =   4590
      TabIndex        =   47
      Top             =   5715
      Width           =   3345
   End
   Begin VB.Label lblData 
      Caption         =   "Cond. compra :"
      Height          =   285
      Index           =   7
      Left            =   90
      TabIndex        =   46
      Top             =   2475
      Width           =   1305
   End
   Begin VB.Label Label2 
      Caption         =   "Impuestos internos :"
      Height          =   240
      Left            =   8460
      TabIndex        =   45
      Top             =   6930
      Width           =   1770
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Ver item"
         Index           =   0
      End
   End
End
Attribute VB_Name = "frmPedidosSAT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.PedidoSAT
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mCantidadFirmas As Integer, mvarTipoIVA As Integer, mvarIdMonedaPesos As Integer
Private mvarIdMonedaDolar As Integer, mvarIdControlCalidadStandar As Integer
Private mvarGrabado As Boolean, mvarAnulada As Boolean, mAccesoParaMail As Boolean
Private mExigirTrasabilidad_RMLA_PE As Boolean, mvarLiberada As Boolean
Private mvarImpresionHabilitada As Boolean, mvarEnProceso As Boolean
Private mvarId As Long, mIdAprobo As Long, mNumeroPedidoOriginal As Long
Private mvarIdObraStockDisponible As Long
Private mvarCondicionIva As Double, mvarP_IVA1 As Double, mvarP_IVA2 As Double
Private mvarTotalPedido As Double, mvarSubTotal As Double, mvarSubtotalGravado As Double
Private mvarBonificacion As Double, mvarIVA1 As Double, mvarIVA2 As Double
Private mvarBonificacionPorItem As Double, mvarCotizacion As Double
Private mvarPlazoEntrega As String, mNumeracionAutomatica As String
Private mDatosExportacion As String
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

Sub Editar(ByVal Cual As Long)

   Dim oF As frmDetPedidosSAT
   Dim oL As ListItem
   Dim dtp As DTPicker

   For Each dtp In DTFields
      origen.Registro.Fields(dtp.DataField).Value = dtp.Value
   Next
   
   Set oF = New frmDetPedidosSAT
   With oF
      Set .PedidoSAT = origen
      .TipoIVA = mvarTipoIVA
      .CondicionIva = mvarCondicionIva
      If Check2.Value = 1 Then
         .Exterior = "SI"
      Else
         .Exterior = "NO"
      End If
      .Id = Cual
      .Show vbModal, Me
   End With
   Unload oF
   Set oF = Nothing
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Unload Me

   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRsAut As ADOR.Recordset
   Dim dtf As DTPicker
   Dim ListaVacia As Boolean
   Dim oDet As DetPedido
   Dim oPar As ComPronto.Parametro
   Dim i As Integer
   Dim mNum As Long
   Dim mImporte As Double
   Dim mTextoAnulacion As String
   
   mvarId = vnewvalue
   ListaVacia = False
   mvarAnulada = False
   mTextoAnulacion = ""
   mNumeroPedidoOriginal = 0
   mvarPlazoEntrega = ""
   mImporte = 0
   mvarImpresionHabilitada = True
   mvarEnProceso = False
   
   mNumeracionAutomatica = BuscarClaveINI("Numeracion automatica de pedidos")
   If mNumeracionAutomatica <> "SI" Then mNumeracionAutomatica = "NO"
   
   Set oAp = Aplicacion
   Set origen = oAp.PedidosSAT.Item(vnewvalue)
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      mvarIdMonedaPesos = IIf(IsNull(.Fields("IdMoneda").Value), 1, .Fields("IdMoneda").Value)
      mvarIdMonedaDolar = IIf(IsNull(.Fields("IdMonedaDolar").Value), 0, .Fields("IdMonedaDolar").Value)
      mvarIdControlCalidadStandar = IIf(IsNull(.Fields("IdControlCalidadStandar").Value), 0, .Fields("IdControlCalidadStandar").Value)
      If IsNull(.Fields("ExigirTrasabilidad_RMLA_PE").Value) Or _
            .Fields("ExigirTrasabilidad_RMLA_PE").Value = "SI" Then
         mExigirTrasabilidad_RMLA_PE = True
      Else
         mExigirTrasabilidad_RMLA_PE = False
      End If
      mvarIdObraStockDisponible = IIf(IsNull(.Fields("IdObraStockDisponible").Value), 0, .Fields("IdObraStockDisponible").Value)
   End With
   oRs.Close
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetPedidosSAT.TraerMascara
                     ListaVacia = True
                  Else
                     Set oRs = origen.DetPedidosSAT.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           Set oDet = origen.DetPedidosSAT.Item(oRs.Fields(0).Value)
                           oDet.Modificado = True
                           Set oDet = Nothing
                           oRs.MoveNext
                        Loop
                        ListaVacia = False
                     Else
                        Set oControl.DataSource = origen.DetPedidosSAT.TraerMascara
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
      
   Else
      With origen.Registro
         mvarP_IVA1 = .Fields("PorcentajeIva1").Value
         mvarP_IVA2 = .Fields("PorcentajeIva2").Value
         mImporte = .Fields("TotalPedido").Value
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
            txtNumeroPedido.Enabled = False
            txtSubnumero.Enabled = False
            mIdAprobo = .Fields("Aprobo").Value
            mvarLiberada = True
         Else
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
         If IsNull(.Fields("PedidoExterior").Value) Or _
               .Fields("PedidoExterior").Value = "NO" Then
            Check2.Value = 0
         Else
            Check2.Value = 1
         End If
         If IsNull(.Fields("Subcontrato").Value) Or _
               .Fields("Subcontrato").Value = "NO" Then
            Check3.Value = 0
         Else
            Check3.Value = 1
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
   
   If ListaVacia Then Lista.ListItems.Clear
   
   Lista.Sorted = False
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   If Not IsNull(origen.Registro.Fields("Cumplido").Value) And _
         origen.Registro.Fields("Cumplido").Value = "AN" Then
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
   
   CalculaPedido

End Property

Private Sub Combo1_Change(Index As Integer)

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
'            Set dcfields(5).RowSource = Aplicacion.PedidosAbiertos.TraerFiltrado("_PorProveedorParaCombo", dcfields(Index).BoundText)
'            If Not IsNull(origen.Registro.Fields("IdPedidoAbierto").Value) Then
'               dcfields(5).BoundText = origen.Registro.Fields("IdPedidoAbierto").Value
'            End If
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
         Case 7
            If IsNull(origen.Registro.Fields(dcfields(Index).DataField).Value) Or _
                  origen.Registro.Fields(dcfields(Index).DataField).Value <> dcfields(Index).BoundText Then
               origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
            End If
      End Select
   Else
      If Index = 2 Then
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

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
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
      If IsNumeric(Item.SubItems(28)) Then
         If Not IsNull(origen.DetPedidosSAT.Item(Item.SubItems(28)).Registro.Fields("Observaciones").Value) Then
            rchObservacionesItemVisible.TextRTF = origen.DetPedidosSAT.Item(Item.SubItems(28)).Registro.Fields("Observaciones").Value
         End If
      End If
   End If

End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeySpace Then
      MnuDetA_Click 1
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count = 0 Then
      Else
         PopupMenu MnuDet, , , , MnuDetA(0)
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         If Not Lista.SelectedItem Is Nothing Then
            Editar Lista.SelectedItem.Tag
         End If
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
      txtLocalidad.Text = oRs.Fields("Nombre").Value
   End If
   
   If mvarProvincia <> 0 Then
      oAp.TablasGenerales.Tabla = "Provincias"
      oAp.TablasGenerales.Id = mvarProvincia
      Set oRs = oAp.TablasGenerales.Registro
      txtProvincia.Text = oRs.Fields("Nombre").Value
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
   Dim mvarImporteTotalItem As Double, mvarBonificacionDistribuida As Double
   Dim mvarImporteIVAItem As Double
   Dim i As Integer, X As Integer
   
   For i = 1 To 2
      mvarSubTotal = 0
      mvarSubtotalGravado = 0
      mvarIVA1 = 0
      mvarIVA2 = 0
      mvarTotalPedido = 0
      mvarBonificacionPorItem = 0
      mvarBonificacion = 0
      
      Set oRs = origen.DetPedidosSAT.Registros
      With oRs
         If .Fields.Count > 0 Then
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  If Not .Fields("Eliminado").Value Then
                     mvarSubTotal = mvarSubTotal + (.Fields("Precio").Value * .Fields("Cantidad").Value)
                  End If
                  .MoveNext
               Loop
               .MoveFirst
               Do While Not .EOF
                  If Not .Fields("Eliminado").Value Then
                     Set oDet = origen.DetPedidosSAT.Item(.Fields(0).Value)
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

      If IsNumeric(txtPorcentajeBonificacion.Text) And Val(txtPorcentajeBonificacion.Text) <> 0 Then
         mvarBonificacion = Round((mvarSubTotal - mvarBonificacionPorItem) * Val(txtPorcentajeBonificacion.Text) / 100, 2)
      ElseIf IsNumeric(Replace(txtBonificacion.Text, ",", "")) Then
         mvarBonificacion = Val(Replace(txtBonificacion.Text, ",", ""))
      End If
      mvarSubtotalGravado = mvarSubTotal - mvarBonificacion - mvarBonificacionPorItem

      mvarTotalPedido = mvarSubtotalGravado + mvarIVA1 + mvarIVA2 + Val(txtImpuestosInternos.Text)
      
      txtSubtotal.Text = Format(mvarSubTotal, "#,##0.00")
      txtNeto.Text = Format(mvarSubtotalGravado, "#,##0.00")
      txtBonificacionPorItem.Text = Format(mvarBonificacionPorItem, "#,##0.00")
      txtBonificacion.Text = Format(mvarBonificacion, "#,##0.00")
      txtTotalIva1.Text = Format(mvarIVA1, "#,##0.00")
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
   
   If Not Lista.SelectedItem Is Nothing Then X = Lista.SelectedItem.Index
   Set Lista.DataSource = origen.DetPedidosSAT.RegistrosConFormato
   Lista.Refresh
   If Lista.ListItems.Count = 0 Then
      Set Lista.DataSource = origen.DetPedidosSAT.TraerMascara
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
