VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmPresupuesto 
   Caption         =   "Solicitud de cotizacion"
   ClientHeight    =   8130
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11400
   Icon            =   "frmPresupuesto.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8130
   ScaleWidth      =   11400
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "B"
      Height          =   315
      Index           =   3
      Left            =   6300
      TabIndex        =   92
      ToolTipText     =   "Buscar proveedores por consuta de articulos"
      Top             =   450
      Width           =   165
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Ver RM's"
      Height          =   240
      Index           =   7
      Left            =   6075
      TabIndex        =   91
      Top             =   7740
      Width           =   885
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
      Left            =   4410
      TabIndex        =   89
      Top             =   6930
      Width           =   1050
   End
   Begin VB.TextBox txtSubtotalGravado 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   9900
      TabIndex        =   86
      Top             =   7155
      Width           =   1275
   End
   Begin VB.TextBox txtBonificacionPorItem 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   9900
      TabIndex        =   84
      Top             =   6525
      Width           =   1275
   End
   Begin VB.CommandButton cmd 
      Height          =   510
      Index           =   4
      Left            =   4365
      Picture         =   "frmPresupuesto.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   83
      Top             =   7470
      Width           =   795
   End
   Begin VB.CommandButton cmd 
      BackColor       =   &H00C0C0FF&
      Caption         =   "Adjuntos"
      Height          =   240
      Index           =   5
      Left            =   6075
      Style           =   1  'Graphical
      TabIndex        =   82
      Top             =   7470
      Width           =   885
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
      Height          =   585
      Left            =   1755
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   79
      Top             =   1530
      Width           =   4695
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
      Left            =   4950
      TabIndex        =   76
      Top             =   450
      Width           =   1320
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   510
      Index           =   1
      Left            =   3510
      Picture         =   "frmPresupuesto.frx":0CF4
      Style           =   1  'Graphical
      TabIndex        =   75
      Top             =   7470
      Width           =   795
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   0
      Left            =   8235
      TabIndex        =   70
      Top             =   4095
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   1
      Left            =   8460
      TabIndex        =   69
      Top             =   4095
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   2
      Left            =   8685
      TabIndex        =   68
      Top             =   4095
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   3
      Left            =   8910
      TabIndex        =   67
      Top             =   4095
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   4
      Left            =   9135
      TabIndex        =   66
      Top             =   4095
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   5
      Left            =   9360
      TabIndex        =   65
      Top             =   4095
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   6
      Left            =   9585
      TabIndex        =   64
      Top             =   4095
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CommandButton cmd 
      Caption         =   "C&opiar items"
      Height          =   510
      Index           =   2
      Left            =   5220
      TabIndex        =   61
      Top             =   7470
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
      Left            =   3015
      TabIndex        =   0
      Top             =   45
      Width           =   330
   End
   Begin VB.TextBox txtTelefonoComprador 
      Enabled         =   0   'False
      Height          =   330
      Left            =   8235
      TabIndex        =   58
      Top             =   3645
      Width           =   3075
   End
   Begin VB.TextBox txtPorcentajeBonificacion 
      Alignment       =   1  'Right Justify
      DataField       =   "Bonificacion"
      Height          =   240
      Left            =   9000
      TabIndex        =   14
      Top             =   6885
      Width           =   465
   End
   Begin VB.TextBox txtSubtotal 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   9900
      TabIndex        =   53
      Top             =   6210
      Width           =   1275
   End
   Begin VB.TextBox txtBonificacion 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   9900
      TabIndex        =   52
      Top             =   6840
      Width           =   1275
   End
   Begin VB.TextBox txtTotalIva1 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   9900
      TabIndex        =   51
      Top             =   7470
      Width           =   1275
   End
   Begin VB.TextBox txtContacto 
      DataField       =   "Contacto"
      Height          =   330
      Left            =   1755
      TabIndex        =   8
      Top             =   2565
      Width           =   1950
   End
   Begin VB.TextBox txtDetalle 
      DataField       =   "Detalle"
      Height          =   315
      Left            =   990
      TabIndex        =   13
      Text            =   "LA OFERTA DEBERA OBRAR EN NUESTRO PODER ANTES DEL : "
      Top             =   6570
      Width           =   7170
   End
   Begin VB.TextBox txtEmailComprador 
      Enabled         =   0   'False
      Height          =   330
      Left            =   8235
      TabIndex        =   47
      Top             =   3285
      Width           =   3075
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1005
      Left            =   1755
      TabIndex        =   6
      Top             =   3285
      Width           =   4695
      _ExtentX        =   8281
      _ExtentY        =   1773
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      OLEDropMode     =   0
      TextRTF         =   $"frmPresupuesto.frx":127E
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
   Begin VB.CommandButton cmdPegar 
      Height          =   510
      Left            =   1800
      Picture         =   "frmPresupuesto.frx":1300
      Style           =   1  'Graphical
      TabIndex        =   18
      Top             =   7470
      UseMaskColor    =   -1  'True
      Width           =   795
   End
   Begin VB.TextBox txtReferencia 
      DataField       =   "Referencia"
      Height          =   330
      Left            =   4725
      TabIndex        =   9
      Top             =   2520
      Width           =   1725
   End
   Begin VB.TextBox txtValidez 
      DataField       =   "Validez"
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
      Left            =   1755
      TabIndex        =   3
      Top             =   810
      Width           =   4695
   End
   Begin VB.TextBox txtLugarEntrega 
      DataField       =   "LugarEntrega"
      Height          =   330
      Left            =   8235
      TabIndex        =   10
      Top             =   2565
      Width           =   3075
   End
   Begin VB.TextBox txtGarantia 
      DataField       =   "Garantia"
      Height          =   330
      Left            =   4725
      TabIndex        =   7
      Top             =   2160
      Width           =   1725
   End
   Begin VB.TextBox txtNumero 
      Alignment       =   1  'Right Justify
      DataField       =   "Numero"
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
      Left            =   1755
      TabIndex        =   72
      Top             =   45
      Width           =   1095
   End
   Begin VB.TextBox txtCondicionIva 
      Enabled         =   0   'False
      Height          =   330
      Left            =   8235
      TabIndex        =   40
      Top             =   2205
      Width           =   3075
   End
   Begin VB.TextBox txtCuit 
      Enabled         =   0   'False
      Height          =   330
      Left            =   8235
      TabIndex        =   38
      Top             =   1845
      Width           =   3075
   End
   Begin VB.TextBox txtEmail 
      Enabled         =   0   'False
      Height          =   330
      Left            =   8235
      TabIndex        =   36
      Top             =   1485
      Width           =   3075
   End
   Begin VB.TextBox txtTelefono 
      Enabled         =   0   'False
      Height          =   330
      Left            =   8235
      TabIndex        =   34
      Top             =   1125
      Width           =   3075
   End
   Begin VB.TextBox txtProvincia 
      Enabled         =   0   'False
      Height          =   330
      Left            =   8235
      TabIndex        =   32
      Top             =   765
      Width           =   3075
   End
   Begin VB.TextBox txtLocalidad 
      Enabled         =   0   'False
      Height          =   330
      Left            =   8235
      TabIndex        =   30
      Top             =   405
      Width           =   3075
   End
   Begin VB.TextBox txtDireccion 
      Enabled         =   0   'False
      Height          =   330
      Left            =   8235
      TabIndex        =   28
      Top             =   45
      Width           =   3075
   End
   Begin VB.TextBox txtPlazo 
      DataField       =   "Plazo"
      Height          =   330
      Left            =   6210
      TabIndex        =   5
      Top             =   7065
      Visible         =   0   'False
      Width           =   1950
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   1
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
      Index           =   1
      Left            =   9900
      TabIndex        =   20
      Top             =   7785
      Width           =   1275
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   1
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
      Index           =   0
      Left            =   7335
      TabIndex        =   19
      Top             =   6225
      Width           =   840
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   510
      Index           =   0
      Left            =   90
      TabIndex        =   15
      Top             =   7470
      Width           =   795
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   510
      Index           =   1
      Left            =   945
      TabIndex        =   16
      Top             =   7470
      Width           =   795
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   510
      Index           =   0
      Left            =   2655
      Picture         =   "frmPresupuesto.frx":1742
      Style           =   1  'Graphical
      TabIndex        =   17
      Top             =   7470
      UseMaskColor    =   -1  'True
      Width           =   795
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCondicionCompra"
      Height          =   315
      Index           =   1
      Left            =   1755
      TabIndex        =   4
      Tag             =   "CondicionesCompra"
      Top             =   1170
      Width           =   4695
      _ExtentX        =   8281
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCondicionCompra"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaIngreso"
      Height          =   330
      Index           =   0
      Left            =   4050
      TabIndex        =   1
      Top             =   45
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   66650113
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   0
      Left            =   1755
      TabIndex        =   2
      Tag             =   "Proveedores"
      Top             =   450
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservacionesItem 
      Height          =   330
      Left            =   7740
      TabIndex        =   46
      Top             =   7515
      Visible         =   0   'False
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   582
      _Version        =   393217
      TextRTF         =   $"frmPresupuesto.frx":1DAC
   End
   Begin Controles1013.DbListView Lista 
      Height          =   1815
      Left            =   45
      TabIndex        =   12
      Top             =   4365
      Width           =   11310
      _ExtentX        =   19950
      _ExtentY        =   3201
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmPresupuesto.frx":1E2E
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdComprador"
      Height          =   315
      Index           =   2
      Left            =   8235
      TabIndex        =   11
      Tag             =   "Empleados"
      Top             =   2925
      Width           =   3075
      _ExtentX        =   5424
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Aprobo"
      Height          =   315
      Index           =   3
      Left            =   1755
      TabIndex        =   62
      Tag             =   "Empleados"
      Top             =   2925
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
      Left            =   990
      TabIndex        =   73
      Tag             =   "Monedas"
      Top             =   6930
      Width           =   1725
      _ExtentX        =   3043
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdPlazoEntrega"
      Height          =   315
      Index           =   5
      Left            =   1755
      TabIndex        =   88
      Tag             =   "PlazosEntrega"
      Top             =   2205
      Width           =   1950
      _ExtentX        =   3440
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPlazoEntrega"
      Text            =   ""
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   0
      Top             =   5760
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
            Picture         =   "frmPresupuesto.frx":1E4A
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuesto.frx":1F5C
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuesto.frx":23AE
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuesto.frx":2800
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin VB.Label lblLabels 
      Caption         =   "Conversion a Pesos :"
      Height          =   240
      Index           =   17
      Left            =   2835
      TabIndex        =   90
      Top             =   6975
      Width           =   1530
   End
   Begin VB.Label Label4 
      Caption         =   "Subtotal gravado :"
      Height          =   240
      Left            =   8415
      TabIndex        =   87
      Top             =   7200
      Width           =   1365
   End
   Begin VB.Label Label1 
      Caption         =   "Bonif. por item : "
      Height          =   240
      Index           =   3
      Left            =   8415
      TabIndex        =   85
      Top             =   6570
      Width           =   1365
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
      Index           =   24
      Left            =   90
      TabIndex        =   81
      Top             =   4140
      Width           =   1545
   End
   Begin VB.Label lblLabels 
      Caption         =   "Aclaracion sobre las condiciones compra :"
      Height          =   510
      Index           =   25
      Left            =   135
      TabIndex        =   80
      Top             =   1575
      Width           =   1575
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label1 
      Caption         =   "%"
      Height          =   240
      Index           =   2
      Left            =   9495
      TabIndex        =   78
      Top             =   6885
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
      Height          =   210
      Index           =   2
      Left            =   5490
      TabIndex        =   77
      Top             =   225
      Width           =   735
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Moneda :"
      Height          =   240
      Index           =   4
      Left            =   135
      TabIndex        =   74
      Top             =   6975
      Width           =   810
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Autorizaciones : "
      Height          =   240
      Index           =   23
      Left            =   6615
      TabIndex        =   71
      Top             =   4005
      Width           =   1575
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Aprobo : "
      Height          =   285
      Index           =   3
      Left            =   135
      TabIndex        =   63
      Top             =   2940
      Width           =   1575
   End
   Begin VB.Line Line1 
      BorderWidth     =   3
      X1              =   2970
      X2              =   2880
      Y1              =   45
      Y2              =   360
   End
   Begin VB.Label Label3 
      Caption         =   "Total cantidad :"
      Height          =   240
      Left            =   6120
      TabIndex        =   60
      Top             =   6255
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Telefono comprador :"
      Height          =   285
      Index           =   1
      Left            =   6615
      TabIndex        =   59
      Top             =   3645
      Width           =   1575
   End
   Begin VB.Label Label2 
      Caption         =   "TOTAL :"
      Height          =   240
      Left            =   8415
      TabIndex        =   57
      Top             =   7830
      Width           =   1365
   End
   Begin VB.Label Label1 
      Caption         =   "Subtotal :"
      Height          =   240
      Index           =   0
      Left            =   8415
      TabIndex        =   56
      Top             =   6255
      Width           =   1365
   End
   Begin VB.Label Label1 
      Caption         =   "Bonif. :"
      Height          =   240
      Index           =   1
      Left            =   8415
      TabIndex        =   55
      Top             =   6885
      Width           =   555
   End
   Begin VB.Label lblIVA1 
      Caption         =   "IVA"
      Height          =   195
      Left            =   8415
      TabIndex        =   54
      Top             =   7515
      Width           =   1365
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Contacto :"
      Height          =   285
      Index           =   21
      Left            =   135
      TabIndex        =   50
      Top             =   2595
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Detalle :"
      Height          =   240
      Index           =   20
      Left            =   135
      TabIndex        =   49
      Top             =   6615
      Width           =   810
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Email comprador :"
      Height          =   285
      Index           =   19
      Left            =   6615
      TabIndex        =   48
      Top             =   3285
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Referencia :"
      Height          =   285
      Index           =   18
      Left            =   3780
      TabIndex        =   45
      Top             =   2565
      Width           =   900
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Comprador :"
      Height          =   285
      Index           =   2
      Left            =   6615
      TabIndex        =   44
      Top             =   2925
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Lugar de entrega :"
      Height          =   285
      Index           =   16
      Left            =   6615
      TabIndex        =   43
      Top             =   2565
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Garantia :"
      Height          =   285
      Index           =   15
      Left            =   3780
      TabIndex        =   42
      Top             =   2205
      Width           =   900
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Numero :"
      Height          =   285
      Index           =   14
      Left            =   135
      TabIndex        =   41
      Top             =   90
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Condicion Iva :"
      Height          =   285
      Index           =   13
      Left            =   6615
      TabIndex        =   39
      Top             =   2205
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "CUIT :"
      Height          =   285
      Index           =   12
      Left            =   6615
      TabIndex        =   37
      Top             =   1845
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Email :"
      Height          =   285
      Index           =   11
      Left            =   6615
      TabIndex        =   35
      Top             =   1485
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Telefono(s) :"
      Height          =   285
      Index           =   10
      Left            =   6615
      TabIndex        =   33
      Top             =   1125
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Provincia :"
      Height          =   285
      Index           =   9
      Left            =   6615
      TabIndex        =   31
      Top             =   765
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Localidad :"
      Height          =   285
      Index           =   8
      Left            =   6615
      TabIndex        =   29
      Top             =   405
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Direccion :"
      Height          =   285
      Index           =   7
      Left            =   6615
      TabIndex        =   27
      Top             =   45
      Width           =   1575
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Proveedor :"
      Height          =   240
      Index           =   0
      Left            =   135
      TabIndex        =   26
      Top             =   495
      Width           =   1575
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Plazo de entrega :"
      Height          =   285
      Index           =   5
      Left            =   135
      TabIndex        =   25
      Top             =   2205
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Validez de la oferta :"
      Height          =   285
      Index           =   0
      Left            =   135
      TabIndex        =   24
      Top             =   810
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   3420
      TabIndex        =   23
      Top             =   90
      Width           =   585
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Observaciones :"
      Height          =   285
      Index           =   6
      Left            =   135
      TabIndex        =   22
      Top             =   3330
      Width           =   1575
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Condiciones compra :"
      Height          =   285
      Index           =   1
      Left            =   135
      TabIndex        =   21
      Top             =   1170
      Width           =   1575
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalles"
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
         Caption         =   "Asignar % Bonificacion a items seleccionados"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar % Bonificacion a todos los items"
         Index           =   4
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar % IVA a items seleccionados"
         Index           =   5
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar % IVA a todos los items"
         Index           =   6
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Renumerar items"
         Index           =   7
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar marca de descripciones"
         Index           =   8
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
         Caption         =   "Asignar precio unitario a items seleccionados"
         Index           =   9
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar precio unitario a todos los items"
         Index           =   10
      End
   End
End
Attribute VB_Name = "frmPresupuesto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Presupuesto
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mvarTipoIVA As Long, mIdAprobo As Long, mvarIdObraStockDisponible As Long, mvarIdControlCalidadStandar As Long
Private mvarGrabado As Boolean, mvarModificado As Boolean, mAccesoParaMail As Boolean, mvarEnProceso As Boolean
Private mvarCondicionIva As Double, mvarP_IVA1 As Double, mvarP_IVA2 As Double, mvarTotalPresupuesto As Double, mvarSubTotal As Double
Private mvarNeto As Double, mvarBonificacion As Double, mvarIVA1 As Double, mvarIVA2 As Double, mvarBonificacionPorItem As Double
Private mvarTotalCantidad As Double, mvarSubtotalGravado As Double
Private mCantidadDiasCondicionCompra As Integer, mvarIdMonedaPesos As Integer
Dim actL2 As ControlForm
Dim DragItem As Integer
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

   Dim oF As frmDetPresupuestos
   Dim oL As ListItem
   
   Set oF = New frmDetPresupuestos
   
   With oF
      Set .Presupuesto = origen
      .TipoIVA = mvarTipoIVA
      .CondicionIva = mvarCondicionIva
      .FechaEntrega = DateAdd("d", mCantidadDiasCondicionCompra, DTFields(0).Value)
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         mvarModificado = True
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
            .Text = oF.txtItem
            .SubItems(1) = .Tag
            .SubItems(2) = "" & oF.txtCodigoArticulo.Text
            .SubItems(3) = "" & oF.DataCombo1(1).Text
            If Val(oF.txtCantidad.Text) = 0 Then
               .SubItems(4) = " "
            Else
               .SubItems(4) = "" & Format(oF.txtCantidad.Text, "Fixed")
            End If
            .SubItems(5) = "" & oF.DataCombo1(0).Text
            If Val(oF.txtCantidad1.Text) = 0 Then
               .SubItems(6) = " "
            Else
               .SubItems(6) = "" & Format(oF.txtCantidad1.Text, "Fixed")
            End If
            If Val(oF.txtCantidad2.Text) = 0 Then
               .SubItems(7) = " "
            Else
               .SubItems(7) = "" & Format(oF.txtCantidad2.Text, "Fixed")
            End If
            With origen.DetPresupuestos.Item(.Tag).Registro
               If Not IsNull(.Fields("Precio").Value) Then
                  oL.SubItems(8) = "" & Format(.Fields("Precio").Value, "#0.0000")
                  oL.SubItems(9) = "" & Format(.Fields("Precio").Value * Val(oF.txtCantidad.Text), "#0.0000")
               Else
                  oL.SubItems(8) = ""
                  oL.SubItems(9) = ""
               End If
               If Not IsNull(.Fields("PorcentajeBonificacion").Value) Then
                  oL.SubItems(10) = "" & Format(.Fields("PorcentajeBonificacion").Value, "Fixed")
                  oL.SubItems(11) = "" & Format(.Fields("ImporteBonificacion").Value, "#0.0000")
                  oL.SubItems(12) = "" & Format((.Fields("Precio").Value * Val(oF.txtCantidad.Text)) - .Fields("ImporteBonificacion").Value, "#0.0000")
               Else
                  oL.SubItems(10) = ""
                  oL.SubItems(11) = ""
                  oL.SubItems(12) = "" & Format(.Fields("Precio").Value * Val(oF.txtCantidad.Text), "#0.0000")
               End If
               If Not IsNull(.Fields("PorcentajeIVA").Value) Then
                  oL.SubItems(13) = "" & Format(.Fields("PorcentajeIVA").Value, "Fixed")
                  oL.SubItems(14) = "" & Format(.Fields("ImporteIVA").Value, "#0.0000")
               Else
                  oL.SubItems(13) = ""
                  oL.SubItems(14) = ""
               End If
               If Not IsNull(.Fields("ImporteTotalItem").Value) Then
                  oL.SubItems(15) = "" & Format(.Fields("ImporteTotalItem").Value, "#0.0000")
               Else
                  oL.SubItems(15) = ""
               End If
            End With
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
   CalculaPresupuesto

End Sub

Private Sub cmd_Click(Index As Integer)

   Dim oF As Form
   
   Select Case Index
      Case 0
         If Val(txtCotizacionMoneda.Text) <= 0 Then
            MsgBox "No ingreso la cotizacion", vbInformation
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim mvarImprime As Integer
         Dim mvarErr As String
         Dim mNum As Long
         Dim oRs As ADOR.Recordset
         Dim oPar As ComPronto.Parametro
      
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar una solicitud de cotizacion sin detalles"
            Exit Sub
         End If
         
         For Each dtp In DTFields
            origen.Registro.Fields(dtp.DataField).Value = dtp.Value
         Next
         
         For Each dc In dcfields
            If dc.Enabled And dc.Visible Then
               If Not IsNumeric(dc.BoundText) And dc.Index <> 3 Then
                  MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
                  Exit Sub
               End If
               If IsNumeric(dc.BoundText) Then
                  origen.Registro.Fields(dc.DataField).Value = dc.BoundText
               End If
            End If
         Next
         
         mvarErr = ""
'         With origen.DetPresupuestos.Registros
'            If .Fields.Count > 0 Then
'               If .RecordCount > 0 Then
'                  .MoveFirst
'                  Do While Not .EOF
'                     If Not .Fields("Eliminado").Value Then
'                        If IsNull(.Fields("Precio").Value) Or .Fields("Precio").Value = 0 Then
'                           mvarErr = mvarErr + "Hay items que no tienen precio unitario" & vbCrLf
'                           Exit Do
'                        End If
'                     End If
'                     .MoveNext
'                  Loop
'               End If
'            End If
'         End With
         
         If Len(mvarErr) Then
            MsgBox "Errores encontrados :" & vbCrLf & mvarErr, vbExclamation
            Exit Sub
         End If
         
         If Len(Trim(txtNumero.Text)) = 0 Or Not IsNumeric(txtNumero.Text) Then
            MsgBox "Debe ingresar un numero de presupuesto valido", vbExclamation
            Exit Sub
         End If
         
         If Len(Trim(txtSubnumero.Text)) = 0 Or Not IsNumeric(txtSubnumero.Text) Then
            MsgBox "Debe ingresar un numero en el sub numero del presupuesto", vbExclamation
            Exit Sub
         End If
         
'         If Len(Trim(txtDetalleCondicionCompra.Text)) = 0 Then
'            MsgBox "Debe ingresar el detalle de la condicion de compra", vbExclamation
'            Exit Sub
'         End If
         
         If mvarId < 0 And Val(txtSubnumero.Text) = 1 Then
            Set oPar = Aplicacion.Parametros.Item(1)
            origen.Registro.Fields("Numero").Value = oPar.Registro.Fields("ProximoPresupuesto").Value
            Set oPar = Nothing
         End If
         
         Set oRs = Aplicacion.Presupuestos.TraerFiltrado("_PorNumero", Array(txtNumero.Text, txtSubnumero.Text))
         If oRs.RecordCount > 0 Then
            If mvarId < 0 Or (mvarId > 0 And oRs.Fields(0).Value <> mvarId) Then
               oRs.Close
               Set oRs = Nothing
               MsgBox "Numero/Subnumero de presupuesto ya existente!", vbExclamation
               Exit Sub
            End If
         End If
         oRs.Close
         Set oRs = Nothing
         
         Me.MousePointer = vbHourglass
         
         With origen.Registro
            .Fields("PorcentajeIva1").Value = mvarP_IVA1
            .Fields("PorcentajeIva2").Value = mvarP_IVA2
            .Fields("ImporteBonificacion").Value = mvarBonificacion
            .Fields("ImporteIva1").Value = mvarIVA1
            .Fields("ImporteTotal").Value = mvarTotalPresupuesto
            .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text
            .Fields("Observaciones").Value = rchObservaciones.Text
            If mvarId < 0 And Val(txtSubnumero.Text) = 1 Then
               Set oPar = Aplicacion.Parametros.Item(1)
               mNum = oPar.Registro.Fields("ProximoPresupuesto").Value
               .Fields("Numero").Value = mNum
               oPar.Registro.Fields("ProximoPresupuesto").Value = mNum + 1
               oPar.Guardar
               Set oPar = Nothing
            End If
         End With
         
         Select Case origen.Guardar
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
         If mvarId = -1 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
            mvarGrabado = True
         Else
            est = Modificacion
         End If
            
         mvarModificado = False
         
         With actL2
            .ListaEditada = "PresupuestosTodos,+SubPr2"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
         Me.MousePointer = vbDefault
         
         mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de solicitud de cotizacion")
         If mvarImprime = vbYes Then
            cmdImpre_Click 0
         End If
      
         Unload Me
   
      Case 1
         If mvarModificado Then
            Dim mvarSale As Integer
            mvarSale = MsgBox("Hay datos no grabados, desea salir igual ?", vbYesNo, "Salir")
            If mvarSale = vbNo Then Exit Sub
            mvarModificado = False
         End If
   
         Unload Me

      Case 2
         Dim Cadena As String
         Cadena = Lista.GetString
         If Len(Trim(Cadena)) > 0 Then
            Cadena = Replace(Cadena, "Id" & vbTab, "Presupuesto" & vbTab)
            With Clipboard
               .Clear
               .SetText Cadena
            End With
            MsgBox "Items copiados correctamente", vbInformation
         Else
            MsgBox "No hay informacion a copiar", vbExclamation
         End If
   
      Case 3
         BuscarProveedor
   
      Case 4
         If Not mvarId > 0 Then
            MsgBox "Debe grabar el pedido antes de enviar por email", vbExclamation
            Exit Sub
         End If
         
         mvarSale = MsgBox("Esta seguro de generar email ?", vbYesNo, "Enviar email")
         If mvarSale = vbNo Then Exit Sub
         
         EnviarPresupuestoPorEmail
   
      Case 5
         Set oF = New frmAdjuntos
         With oF
            Set .Presupuesto = origen
            .Show vbModal, Me
         End With
         If HayAdjuntos Then
            cmd(5).BackColor = &HC0FFC0
         Else
            cmd(5).BackColor = &HC0C0FF
         End If
         Unload oF
         Set oF = Nothing
   
      Case 7
         Set oF = New frmConsultaRMPendientes
         With oF
            .Id = "Compras"
            .Show , Me
         End With
         Set oF = Nothing
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRsAut As ADOR.Recordset
   Dim dtf As DTPicker
   Dim oDet As DetPresupuesto
   Dim ListaVacia As Boolean
   Dim i As Integer, mCantidadFirmas As Integer
   Dim mNum As Long
   Dim oPar As ComPronto.Parametro

   mvarId = vNewValue
   
   ListaVacia = False
   mvarModificado = False
   mvarEnProceso = False
   
   Set oAp = Aplicacion
   
   Set origen = oAp.Presupuestos.Item(vNewValue)
   
   If glbParametrizacionNivel1 Then
      origen.NivelParametrizacion = 1
   End If
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      mvarIdMonedaPesos = IIf(IsNull(.Fields("IdMoneda").Value), 1, .Fields("IdMoneda").Value)
      mvarIdControlCalidadStandar = IIf(IsNull(.Fields("IdControlCalidadStandar").Value), 0, .Fields("IdControlCalidadStandar").Value)
      mvarIdObraStockDisponible = IIf(IsNull(.Fields("IdObraStockDisponible").Value), 0, .Fields("IdObraStockDisponible").Value)
   End With
   oRs.Close
   
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            If oControl.Name = "Lista" Then
               If vNewValue < 0 Then
                  Set oControl.DataSource = origen.DetPresupuestos.TraerMascara
                  ListaVacia = True
               Else
                  Set oRs = origen.DetPresupuestos.TraerTodos
                  If oRs.RecordCount <> 0 Then
                     Set oControl.DataSource = oRs
                     oRs.MoveFirst
                     Do While Not oRs.EOF
                        Set oDet = origen.DetPresupuestos.Item(oRs.Fields(0).Value)
                        oDet.Modificado = True
                        Set oDet = Nothing
                        oRs.MoveNext
                     Loop
                     ListaVacia = False
                  Else
                     Set oControl.DataSource = origen.DetPresupuestos.TraerMascara
                     ListaVacia = True
                  End If
               End If
            End If
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Empleados" Then
                  Set oControl.RowSource = oAp.Empleados.TraerFiltrado("_PorSector", "Compras")
               ElseIf oControl.Tag = "Proveedores" Then
                  Set oControl.RowSource = oAp.Proveedores.TraerFiltrado("_NormalesYEventualesParaCombo")
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
      Set oPar = oAp.Parametros.Item(1)
      With oPar.Registro
         mNum = .Fields("ProximoPresupuesto").Value
         mvarP_IVA1 = .Fields("Iva1").Value
         mvarP_IVA2 = .Fields("Iva2").Value
      End With
      Set oPar = Nothing
      With origen.Registro
         .Fields("Numero").Value = mNum
         .Fields("IdComprador").Value = glbIdUsuario
         .Fields("Detalle").Value = "LA OFERTA DEBERA OBRAR EN NUESTRO PODER ANTES DEL : "
         .Fields("SubNumero").Value = 1
         .Fields("IdMoneda").Value = mvarIdMonedaPesos
      End With
      Lista.ListItems.Clear
      mvarGrabado = False
      mIdAprobo = 0
      mCantidadDiasCondicionCompra = 0
   Else
      With origen.Registro
         mvarP_IVA1 = .Fields("PorcentajeIva1").Value
         mvarP_IVA2 = .Fields("PorcentajeIva2").Value
         If Not IsNull(.Fields("Aprobo").Value) Then
            Check1(0).Value = 1
            mIdAprobo = .Fields("Aprobo").Value
         End If
         If Not IsNull(.Fields("Plazo").Value) Then
            With txtPlazo
               .Left = dcfields(5).Left
               .Width = dcfields(5).Width
               .Top = dcfields(5).Top
               .Visible = True
            End With
            dcfields(5).Visible = False
         End If
         txtCotizacionMoneda.Text = IIf(IsNull(.Fields("CotizacionMoneda").Value), 0, .Fields("CotizacionMoneda").Value)
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
      mCantidadFirmas = 0
      Set oRsAut = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(EnumFormularios.Presupuesto, 0))
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
      Set oRsAut = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(EnumFormularios.Presupuesto, mvarId))
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
   End If
   
   If ListaVacia Then
      Lista.ListItems.Clear
   End If
   
   Lista.Sorted = False
   
   Set oRs = Nothing
   Set oAp = Nothing

   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
   End If
   
   If HayAdjuntos Then
      cmd(5).BackColor = &HC0FFC0
   Else
      cmd(5).BackColor = &HC0C0FF
   End If

End Property

Private Sub cmdImpre_Click(Index As Integer)

'   If Not mvarGrabado Or mvarModificado Then
'      MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
'      Exit Sub
'   End If
   
   Dim mvarOK As Boolean
   Dim mCopias As Integer, mvarAgrupar As Integer
   Dim mPrinter As String, mPrinterAnt As String, mInfo As String
   
   Dim of1 As frm_Aux
   
   Set of1 = New frm_Aux
   With of1
      .Caption = "Emision de Solicitud de Cotizacion"
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
   If Not mvarOK Then
      Exit Sub
   End If
   
   mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
   If Index = 0 Then
      Dim oF As frmCopiasImpresion
      Set oF = New frmCopiasImpresion
      With oF
         .txtCopias.Text = 1
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

   mInfo = "" & mvarAgrupar & "|"
   
   Dim oW As Word.Application
   Set oW = CreateObject("Word.Application")
   With oW
      .Visible = True
      With .Documents.Add(glbPathPlantillas & "\Presupuesto_" & glbEmpresaSegunString & ".dot")
         oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId, varg3:=mInfo
         oW.Application.Run MacroName:="DatosDelPie"
         oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
         If Index = 0 Then
            If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
            oW.Documents(1).PrintOut False, , , , , , , mCopias
            If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
            oW.Documents(1).Close False
            oW.Quit
         ElseIf Index = 2 Then
            oW.Documents(1).SaveAs App.Path & "\Solicitud de cotizacion.doc"
            oW.Quit
         End If
      End With
   End With
   
Salida:

   Set oW = Nothing
   Exit Sub

Mal:
   MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical
   Resume Salida
   
End Sub

Private Sub cmdPegar_Click()

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long
   Dim mPorcentajeIVA As Double
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oPr As ComPronto.Presupuesto
   Dim oRsPre As ADOR.Recordset
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset

'   If mvarId > 0 Then
'      MsgBox "Solo puede copiar a una solicitud de cotizacion vacia !", vbCritical
'      Exit Sub
'   End If
   
   If Not Clipboard.GetFormat(vbCFText) Then
      MsgBox "No hay informacion en el portapapeles", vbCritical
      Exit Sub
   End If
   
   On Error GoTo Mal
   
   s = Clipboard.GetText(vbCFText)
   
   Filas = Split(s, vbCrLf)
   Columnas = Split(Filas(LBound(Filas)), vbTab)
   
   If UBound(Columnas) < 2 Then
      MsgBox "No hay solicitud de cotizacion para copiar", vbCritical
      Exit Sub
   End If
   
   If InStr(1, Columnas(LBound(Columnas) + 1), "Presupuesto") <> 0 Then
   
      If UBound(Filas) > 1 Then
         MsgBox "No puede copiar mas de una solicitud de cotizacion!", vbCritical
         GoTo Salida
      End If
   
      Set oAp = Aplicacion
      
      Columnas = Split(Filas(1), vbTab)
      
      Set oPr = oAp.Presupuestos.Item(Columnas(0))
      Set oRsPre = oPr.DetPresupuestos.TraerTodos
      
      Set oRs = oPr.Registro
               
      With origen
         For i = 1 To oRs.Fields.Count - 1
            If oRs.Fields(i).Name <> "Numero" Then
               .Registro.Fields(i).Value = oRs.Fields(i).Value
            End If
         Next
         .Registro.Fields("Subnumero").Value = 1
      End With

      Set oRs = Nothing
      
      Do While Not oRsPre.EOF
         Set oRsDet = oPr.DetPresupuestos.Item(oRsPre.Fields(0).Value).Registro
         With origen.DetPresupuestos.Item(-1)
            For i = 2 To oRsDet.Fields.Count - 1
               .Registro.Fields(i).Value = oRsDet.Fields(i).Value
            Next
            .Modificado = True
         End With
         Set oRsDet = Nothing
         oRsPre.MoveNext
      Loop
      
      Set oRsPre = Nothing
      Set oPr = Nothing
      Set oAp = Nothing
      
      Clipboard.Clear
   
      cmdPegar.Enabled = False
      
      Set Lista.DataSource = origen.DetPresupuestos.RegistrosConFormato
      
      DatosProveedor
      CalculaPresupuesto
   
   ElseIf InStr(1, Columnas(0), "Acopio") <> 0 Then
   
      Set oAp = Aplicacion
      
      For iFilas = LBound(Filas) + 1 To UBound(Filas)
         Columnas = Split(Filas(iFilas), vbTab)
         Set oRs = oAp.TablasGenerales.TraerFiltrado("DetAcopios", "_UnItem", Columnas(0))
         If oRs.RecordCount > 0 Then
            If IsNull(oRs.Fields("IdArticulo").Value) Then
               MsgBox "No se puede pegar uno o mas items porque el articulo no ha sido " & vbCrLf & "procesado, ver al administrador del sistema", vbCritical
               GoTo Salida
            End If
            Set oL = Lista.ListItems.Add()
            With origen.DetPresupuestos.Item(-1)
               .Registro.Fields("NumeroItem").Value = origen.DetPresupuestos.UltimoItemDetalle
               .Registro.Fields("Cantidad").Value = oRs.Fields("Cantidad").Value
               .Registro.Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
               .Registro.Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
               .Registro.Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
               .Registro.Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
               .Registro.Fields("Adjunto").Value = oRs.Fields("Adjunto").Value
               .Registro.Fields("Precio").Value = 0
               .Registro.Fields("IdDetalleAcopios").Value = oRs.Fields("IdDetalleAcopios").Value
               .Registro.Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
               .Registro.Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
               .Registro.Fields("IdDetalleLMateriales").Value = oRs.Fields("IdDetalleLMateriales").Value
               .Registro.Fields("OrigenDescripcion").Value = 1
               For i = 0 To 9
                  .Registro.Fields("ArchivoAdjunto" & i + 1).Value = oRs.Fields("ArchivoAdjunto" & i + 1).Value
               Next
               mPorcentajeIVA = 0
               If mvarTipoIVA = 0 Then
                  Select Case mvarCondicionIva
                     Case 1
                        mPorcentajeIVA = mvarP_IVA1
                     Case 2
                        mPorcentajeIVA = mvarP_IVA1 + mvarP_IVA2
                  End Select
               End If
               .Registro.Fields("PorcentajeIVA").Value = mPorcentajeIVA
               Set oRsAux = oAp.Articulos.Item(oRs.Fields("IdArticulo").Value).Registro
               oL.Tag = .Id
               oL.Text = "" & .Registro.Fields("NumeroItem").Value
               oL.SubItems(1) = .Id
               oL.SubItems(2) = "" & IIf(IsNull(oRsAux.Fields("Codigo").Value), "", oRsAux.Fields("Codigo").Value)
               oL.SubItems(3) = "" & IIf(IsNull(oRsAux.Fields("Descripcion").Value), "", oRsAux.Fields("Descripcion").Value)
               oL.SubItems(4) = "" & oRs.Fields("Cantidad").Value
               oL.SubItems(5) = "" & oAp.Unidades.Item(oRs.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
               oL.SubItems(6) = "" & oRs.Fields("Cantidad1").Value
               oL.SubItems(7) = "" & oRs.Fields("Cantidad2").Value
               oL.SubItems(8) = ""
               oL.SubItems(9) = ""
               oL.SubItems(10) = ""
               oL.SubItems(11) = ""
               oL.SubItems(12) = ""
               oL.SubItems(13) = "" & mPorcentajeIVA
               oL.SubItems(14) = ""
               oL.SubItems(15) = ""
               oL.SmallIcon = "Nuevo"
               oRsAux.Close
               .Modificado = True
            End With
            oRs.Close
         End If
      Next
      
      Clipboard.Clear
   
      Set oRs = Nothing
      Set oAp = Nothing
      
      DatosProveedor
      CalculaPresupuesto
   
   ElseIf InStr(1, Columnas(0), "Requerimiento") <> 0 Then
   
      Set oAp = Aplicacion
      
      For iFilas = LBound(Filas) + 1 To UBound(Filas)
         Columnas = Split(Filas(iFilas), vbTab)
         Set oRs = oAp.Requerimientos.TraerFiltrado("_DatosRequerimiento", Columnas(0))
         If oRs.RecordCount > 0 Then
            If IsNull(oRs.Fields("Aprobo").Value) Then
               MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & " no fue liberado", vbExclamation
               GoTo Salida
            End If
         End If
         oRs.Close
         Set oRs = oAp.TablasGenerales.TraerFiltrado("DetRequerimientos", "_UnItem", Columnas(0))
         If oRs.RecordCount > 0 Then
            If IsNull(oRs.Fields("IdArticulo").Value) Then
               MsgBox "No se puede pegar uno o mas items porque el articulo no ha sido " & vbCrLf & "procesado, ver al administrador del sistema", vbCritical
               GoTo Salida
            End If
            If Not IsNull(oRs.Fields("TipoDesignacion").Value) And _
                  oRs.Fields("TipoDesignacion").Value <> "CMP" Then
               MsgBox "No se puede pegar uno o mas items porque el articulo no ha sido " & vbCrLf & _
                        "liberado para compra, ver al administrador del sistema", vbCritical
               GoTo Salida
            End If
            Set oL = Lista.ListItems.Add()
            With origen.DetPresupuestos.Item(-1)
               .Registro.Fields("NumeroItem").Value = origen.DetPresupuestos.UltimoItemDetalle
               .Registro.Fields("Cantidad").Value = oRs.Fields("Cantidad").Value
               .Registro.Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
               .Registro.Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
               .Registro.Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
               .Registro.Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
               .Registro.Fields("Adjunto").Value = oRs.Fields("Adjunto").Value
               .Registro.Fields("Precio").Value = 0
               .Registro.Fields("IdDetalleRequerimiento").Value = oRs.Fields("IdDetalleRequerimiento").Value
               .Registro.Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
               .Registro.Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
               .Registro.Fields("IdDetalleLMateriales").Value = oRs.Fields("IdDetalleLMateriales").Value
               .Registro.Fields("IdCentroCosto").Value = oRs.Fields("IdCentroCosto").Value
               .Registro.Fields("OrigenDescripcion").Value = IIf(IsNull(oRs.Fields("OrigenDescripcion").Value), 1, oRs.Fields("OrigenDescripcion").Value)
               For i = 0 To 9
                  .Registro.Fields("ArchivoAdjunto" & i + 1).Value = oRs.Fields("ArchivoAdjunto" & i + 1).Value
               Next
               mPorcentajeIVA = 0
               If mvarTipoIVA = 0 Then
                  Select Case mvarCondicionIva
                     Case 1
                        mPorcentajeIVA = mvarP_IVA1
                     Case 2
                        mPorcentajeIVA = mvarP_IVA1 + mvarP_IVA2
                  End Select
               End If
               .Registro.Fields("PorcentajeIVA").Value = mPorcentajeIVA
               Set oRsAux = oAp.Articulos.Item(oRs.Fields("IdArticulo").Value).Registro
               oL.Tag = .Id
               oL.Text = "" & .Registro.Fields("NumeroItem").Value
               oL.SubItems(1) = .Id
               oL.SubItems(2) = "" & IIf(IsNull(oRsAux.Fields("Codigo").Value), "", oRsAux.Fields("Codigo").Value)
               oL.SubItems(3) = "" & IIf(IsNull(oRsAux.Fields("Descripcion").Value), "", oRsAux.Fields("Descripcion").Value)
               oL.SubItems(4) = "" & oRs.Fields("Cantidad").Value
               oL.SubItems(5) = "" & oAp.Unidades.Item(oRs.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
               oL.SubItems(6) = "" & oRs.Fields("Cantidad1").Value
               oL.SubItems(7) = "" & oRs.Fields("Cantidad2").Value
               oL.SubItems(8) = ""
               oL.SubItems(9) = ""
               oL.SubItems(10) = ""
               oL.SubItems(11) = ""
               oL.SubItems(12) = ""
               oL.SubItems(13) = "" & mPorcentajeIVA
               oL.SubItems(14) = ""
               oL.SubItems(15) = ""
               oL.SmallIcon = "Nuevo"
               oRsAux.Close
               .Modificado = True
            End With
            oRs.Close
         End If
      Next
      
      Clipboard.Clear
   
   Else
      
      MsgBox "Objeto invalido!"
   
   End If
   
Salida:
   
   Set oRs = Nothing
   Set oRsAux = Nothing
   Set oAp = Nothing
   
   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select
   Resume Salida

End Sub

Private Sub dcfields_Change(Index As Integer)
      
   If Len(dcfields(Index).BoundText) = 0 Or Not IsNumeric(dcfields(Index).BoundText) Then
      If Index = 3 Then
         origen.Registro.Fields(dcfields(Index).DataField).Value = Null
      End If
      Exit Sub
   End If
   
   If Index <> 1 And (IsNull(origen.Registro.Fields(dcfields(Index).DataField).Value) Or origen.Registro.Fields(dcfields(Index).DataField).Value <> dcfields(Index).BoundText) Then
      If Me.Visible Then mvarModificado = True
      origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
   End If
   
   Dim oRs As ADOR.Recordset
   
   Select Case Index
      Case 0
         Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", dcfields(Index).BoundText)
         If oRs.RecordCount > 0 Then
            If Not IsNull(oRs.Fields("IdCondicionCompra").Value) And Not mvarId > 0 Then
               dcfields(1).BoundText = oRs.Fields("IdCondicionCompra").Value
            End If
            If Len(Trim(txtContacto.Text)) = 0 And Not IsNull(oRs.Fields("Contacto").Value) Then
               origen.Registro.Fields("Contacto").Value = oRs.Fields("Contacto").Value
            Else
               origen.Registro.Fields("Contacto").Value = ""
            End If
         End If
         oRs.Close
         DatosProveedor
      Case 1
         If dcfields(Index).Text <> dcfields(Index).BoundText Then
            Set oRs = Aplicacion.CondicionesCompra.TraerFiltrado("_PorId", dcfields(Index).BoundText)
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("CantidadDias").Value) Then
                  mCantidadDiasCondicionCompra = oRs.Fields("CantidadDias").Value
               Else
                  mCantidadDiasCondicionCompra = 0
               End If
               If Len(txtDetalleCondicionCompra.Text) = 0 And Me.Visible Then
                  origen.Registro.Fields("DetalleCondicionCompra").Value = dcfields(Index).Text
               End If
            End If
            oRs.Close
         End If
      Case 2
         Set oRs = Aplicacion.Empleados.TraerFiltrado("_PorId", dcfields(Index).BoundText)
         txtEmailComprador.Text = ""
         txtTelefonoComprador.Text = ""
         If oRs.RecordCount > 0 Then
            If Not IsNull(oRs.Fields("Email").Value) Then
               txtEmailComprador.Text = oRs.Fields("Email").Value
            End If
            If Not IsNull(oRs.Fields("Interno").Value) Then
               txtTelefonoComprador.Text = oRs.Fields("Interno").Value
            End If
         End If
         oRs.Close
      Case 4
         If dcfields(Index).BoundText = mvarIdMonedaPesos Then
            txtCotizacionMoneda.Text = 1
         Else
            Set oRs = Aplicacion.Cotizaciones.TraerFiltrado("_PorFechaMoneda", Array(DTFields(0).Value, dcfields(Index).BoundText))
            If oRs.RecordCount > 0 Then
               txtCotizacionMoneda.Text = IIf(IsNull(oRs.Fields("CotizacionLibre").Value), "", oRs.Fields("CotizacionLibre").Value)
            Else
               If Me.Visible Then MsgBox "No hay cotizacion, ingresela manualmente"
               txtCotizacionMoneda.Text = ""
            End If
            oRs.Close
         End If
   End Select
   
   Set oRs = Nothing
   
End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   If Index = 3 And Me.Visible And IsNumeric(dcfields(Index).BoundText) Then
      If dcfields(Index).BoundText <> mIdAprobo Then
         PideAutorizacion
      End If
   End If
   
End Sub

Private Sub dcfields_GotFocus(Index As Integer)
   
   With dcfields(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub dcfields_LostFocus(Index As Integer)

   Me.MousePointer = vbHourglass
   
   Select Case Index
      Case 0
         DatosProveedor
   End Select
   
   Me.MousePointer = vbDefault

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Activate()
   
   DragItem = 5000
   
   If mvarId > 0 Then DatosProveedor
'   lblIVA1.Caption = "IVA " & Format(mvarP_IVA1, "##0.00") & " %"
   CalculaPresupuesto

   Dim mvarSale As Integer
   
   If mAccesoParaMail And Not mvarEnProceso Then
      Degradado Me
      Me.Refresh
      mvarEnProceso = True
      mvarSale = MsgBox("Esta seguro de generar email ?", vbYesNo, "Enviar email")
      If mvarSale = vbYes Then EnviarPresupuestoPorEmail
      Unload Me
   End If
   
End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
'   For Each oI In img16.ListImages
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

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   If mvarModificado Then
      Dim mvarSale As Integer
      mvarSale = MsgBox("Hay datos no grabados, desea salir igual ?", vbYesNo, "Salir")
      If mvarSale = vbNo Then
         Cancel = 1
      End If
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

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

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

Private Sub Lista_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim iFilas As Long, iColumnas As Long, i As Long, mSubNumero As Long
   Dim Filas
   Dim Columnas
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oPr As ComPronto.Presupuesto
   Dim oRsPre As ADOR.Recordset
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset

   On Error GoTo Mal

'   If mvarId > 0 Then
'      MsgBox "Solo puede copiar a una solicitud de cotizacion vacia !", vbCritical
'      Exit Sub
'   End If
   
   If Data.GetFormat(ccCFText) Then
      
      s = Data.GetData(ccCFText)
   
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay solicitud de cotizacion para copiar", vbCritical
         Exit Sub
      End If
      
      If UBound(Filas) > 1 Then
         MsgBox "No puede copiar mas de una solicitud de cotizacion!", vbCritical
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 1), "Presupuesto") <> 0 Then
      
         Set oAp = Aplicacion
         
         Columnas = Split(Filas(1), vbTab)
         
         Set oPr = oAp.Presupuestos.Item(Columnas(19))
         Set oRsPre = oPr.DetPresupuestos.TraerTodos
         
         Set oRs = oPr.Registro
                  
         With origen.Registro
            For i = 1 To oRs.Fields.Count - 1
               If (mvarId > 0 And oRs.Fields(i).Name <> "Numero") Or mvarId < 0 Then
                  .Fields(i).Value = oRs.Fields(i).Value
               End If
            Next
         End With
   
         If mvarId < 0 Then
            Set oRs = oAp.Presupuestos.TraerFiltrado("_PorNumeroBis", oRs.Fields("Numero").Value)
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
         End If
         
         Set oRs = Nothing
         
         Do While Not oRsPre.EOF
         
            Set oRsDet = oPr.DetPresupuestos.Item(oRsPre.Fields(0).Value).Registro
                     
            With origen.DetPresupuestos.Item(-1)
               For i = 2 To oRsDet.Fields.Count - 1
                  .Registro.Fields(i).Value = oRsDet.Fields(i).Value
               Next
               .Modificado = True
               DragItem = DragItem + 10
            End With
            
            oRsDet.Close
            Set oRsDet = Nothing
            
            oRsPre.MoveNext
         
         Loop
         
         oRsPre.Close
         
         Set oRsPre = Nothing
         Set oPr = Nothing
            
         Set Lista.DataSource = origen.DetPresupuestos.RegistrosConFormato
         
         DatosProveedor
         CalculaPresupuesto
         
         mvarModificado = True
         
         txtSubnumero.SetFocus
   
      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "Numero Req.") <> 0 Then
         
         Columnas = Split(Filas(1), vbTab)
         
         Set oAp = Aplicacion
         
         Set oRs = oAp.Requerimientos.TraerFiltrado("_PorId", Columnas(2))
         If oRs.RecordCount > 0 Then
            If IsNull(oRs.Fields("Aprobo").Value) Then
               MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & " no fue liberado", vbExclamation
               GoTo Salida
            End If
            If IIf(IsNull(oRs.Fields("Cumplido").Value), "NO", oRs.Fields("Cumplido").Value) = "SI" Or _
                  IIf(IsNull(oRs.Fields("Cumplido").Value), "NO", oRs.Fields("Cumplido").Value) = "AN" Then
               MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & " ya esta cumplido", vbExclamation
               oRs.Close
               GoTo Salida
            End If
         End If
         oRs.Close
         
         Set oRs = oAp.TablasGenerales.TraerFiltrado("DetRequerimientos", "_Todos", Columnas(2))
         If oRs.RecordCount > 0 Then
            oRs.MoveFirst
            Do While Not oRs.EOF
               If IsNull(oRs.Fields("TipoDesignacion").Value) Or _
                     oRs.Fields("TipoDesignacion").Value = "CMP" Then
                  Set oL = Lista.ListItems.Add()
                  With origen.DetPresupuestos.Item(-1)
                     .Registro.Fields("NumeroItem").Value = origen.DetPresupuestos.UltimoItemDetalle
                     .Registro.Fields("Cantidad").Value = oRs.Fields("Cantidad").Value
                     .Registro.Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     .Registro.Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                     .Registro.Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
                     .Registro.Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
                     .Registro.Fields("Adjunto").Value = oRs.Fields("Adjunto").Value
                     .Registro.Fields("Precio").Value = 0
                     .Registro.Fields("IdDetalleRequerimiento").Value = oRs.Fields("IdDetalleRequerimiento").Value
                     .Registro.Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
                     .Registro.Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
                     .Registro.Fields("IdDetalleLMateriales").Value = oRs.Fields("IdDetalleLMateriales").Value
                     .Registro.Fields("IdCentroCosto").Value = oRs.Fields("IdCentroCosto").Value
                     .Registro.Fields("OrigenDescripcion").Value = IIf(IsNull(oRs.Fields("OrigenDescripcion").Value), 1, oRs.Fields("OrigenDescripcion").Value)
                     For i = 0 To 9
                        .Registro.Fields("ArchivoAdjunto" & i + 1).Value = oRs.Fields("ArchivoAdjunto" & i + 1).Value
                     Next
                     Set oRsDet = oAp.Articulos.Item(oRs.Fields("IdArticulo").Value).Registro
                     .Registro.Fields("PorcentajeIVA").Value = IIf(IsNull(oRsDet.Fields("AlicuotaIVA").Value), 0, oRsDet.Fields("AlicuotaIVA").Value)
                     .Registro.Fields("ImporteIVA").Value = .Registro.Fields("Precio").Value * .Registro.Fields("Cantidad").Value * .Registro.Fields("PorcentajeIVA").Value / 100
                     .Registro.Fields("ImporteTotalItem").Value = (.Registro.Fields("Precio").Value * .Registro.Fields("Cantidad").Value) + .Registro.Fields("ImporteIVA").Value
                     
                     oL.Tag = .Id
                     oL.Text = "" & .Registro.Fields("NumeroItem").Value
                     oL.SubItems(1) = .Id
                     oL.SubItems(2) = "" & IIf(IsNull(oRsDet.Fields("Codigo").Value), "", oRsDet.Fields("Codigo").Value)
                     oL.SubItems(3) = "" & IIf(IsNull(oRsDet.Fields("Descripcion").Value), "", oRsDet.Fields("Descripcion").Value)
                     oL.SubItems(4) = "" & oRs.Fields("Cantidad").Value
                     oL.SubItems(5) = "" & oAp.Unidades.Item(oRs.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
                     oL.SubItems(6) = "" & oRs.Fields("Cantidad1").Value
                     oL.SubItems(7) = "" & oRs.Fields("Cantidad2").Value
                     If Not IsNull(.Registro.Fields("Precio").Value) Then
                        oL.SubItems(8) = "" & Format(.Registro.Fields("Precio").Value, "#0.0000")
                        oL.SubItems(9) = "" & Format(.Registro.Fields("Precio").Value * .Registro.Fields("Cantidad").Value, "#0.0000")
                     Else
                        oL.SubItems(8) = ""
                        oL.SubItems(9) = ""
                     End If
                     oL.SubItems(10) = ""
                     oL.SubItems(11) = ""
                     oL.SubItems(12) = "" & Format(.Registro.Fields("Precio").Value * .Registro.Fields("Cantidad").Value, "#0.0000")
                     oL.SubItems(13) = "" & Format(.Registro.Fields("PorcentajeIVA").Value, "Fixed")
                     oL.SubItems(14) = "" & Format(.Registro.Fields("ImporteIVA").Value, "#0.0000")
                     oL.SubItems(15) = "" & Format(.Registro.Fields("ImporteTotalItem").Value, "#0.0000")
                     oL.SmallIcon = "Nuevo"
                     oRsDet.Close
                     .Modificado = True
                  End With
               End If
               oRs.MoveNext
            Loop
         End If
         oRs.Close
         CalculaPresupuesto
      
      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "Req.Nro.") <> 0 And _
            InStr(1, Columnas(LBound(Columnas) + 2), "Item") <> 0 Then
      
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            
            Columnas = Split(Filas(iFilas), vbTab)
            
            Set oRsDet = Aplicacion.Requerimientos.TraerFiltrado("_DatosRequerimiento", Columnas(24))
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
                  If IIf(IsNull(oRsDet.Fields("Cumplido").Value), "NO", oRsDet.Fields("Cumplido").Value) = "SI" Or _
                        IIf(IsNull(oRsDet.Fields("Cumplido").Value), "NO", oRsDet.Fields("Cumplido").Value) = "AN" Then
                     MsgBox "El requerimiento " & oRs.Fields("NumeroRequerimiento").Value & _
                            " item " & oRsDet.Fields("NumeroItem").Value & " ya esta cumplido", vbExclamation
                     .Close
                     GoTo SalidaFor
                  End If
                     
                  If IsNull(oRsDet.Fields("TipoDesignacion").Value) Or _
                        oRsDet.Fields("TipoDesignacion").Value = "CMP" Or _
                        (oRsDet.Fields("TipoDesignacion").Value = "STK" And _
                         oRsDet.Fields("SalidaPorVales").Value < IIf(IsNull(oRsDet.Fields("Cantidad").Value), 0, oRsDet.Fields("Cantidad").Value)) Or _
                        (oRsDet.Fields("TipoDesignacion").Value = "REC" And _
                         oRsDet.Fields("IdObra").Value = mvarIdObraStockDisponible And _
                         oRsDet.Fields("SalidaPorVales").Value < IIf(IsNull(oRsDet.Fields("Cantidad").Value), 0, oRsDet.Fields("Cantidad").Value)) Then
                     Set oL = Lista.ListItems.Add()
                     With origen.DetPresupuestos.Item(-1)
                        .Registro.Fields("NumeroItem").Value = origen.DetPresupuestos.UltimoItemDetalle
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
                        .Registro.Fields("Adjunto").Value = oRsDet.Fields("Adjunto").Value
                        .Registro.Fields("Precio").Value = 0
                        .Registro.Fields("IdDetalleRequerimiento").Value = oRsDet.Fields("IdDetalleRequerimiento").Value
                        .Registro.Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
                        .Registro.Fields("IdDetalleLMateriales").Value = oRsDet.Fields("IdDetalleLMateriales").Value
                        .Registro.Fields("IdCuenta").Value = oRsDet.Fields("IdCuenta").Value
                        .Registro.Fields("IdCentroCosto").Value = oRsDet.Fields("IdCentroCosto").Value
                        .Registro.Fields("OrigenDescripcion").Value = IIf(IsNull(oRsDet.Fields("OrigenDescripcion").Value), 1, oRsDet.Fields("OrigenDescripcion").Value)
                        For i = 0 To 9
                           .Registro.Fields("ArchivoAdjunto" & i + 1).Value = oRsDet.Fields("ArchivoAdjunto" & i + 1).Value
                        Next
                        .Registro.Fields("PorcentajeIVA").Value = oRsDet.Fields("AlicuotaIVA").Value
                        .Registro.Fields("ImporteIVA").Value = .Registro.Fields("Precio").Value * .Registro.Fields("Cantidad").Value * .Registro.Fields("PorcentajeIVA").Value / 100
                        .Registro.Fields("ImporteTotalItem").Value = (.Registro.Fields("Precio").Value * .Registro.Fields("Cantidad").Value) + .Registro.Fields("ImporteIVA").Value
                        
                        oL.Tag = .Id
                        oL.Text = "" & .Registro.Fields("NumeroItem").Value
                        oL.SubItems(1) = .Id
                        oL.SubItems(2) = "" & IIf(IsNull(oRsDet.Fields("Codigo").Value), "", oRsDet.Fields("Codigo").Value)
                        oL.SubItems(3) = "" & IIf(IsNull(oRsDet.Fields("DescripcionArt").Value), "", oRsDet.Fields("DescripcionArt").Value)
                        oL.SubItems(4) = "" & .Registro.Fields("Cantidad").Value
                        oL.SubItems(5) = "" & IIf(IsNull(oRsDet.Fields("Unidad").Value), "", oRsDet.Fields("Unidad").Value)
                        oL.SubItems(6) = "" & .Registro.Fields("Cantidad1").Value
                        oL.SubItems(7) = "" & .Registro.Fields("Cantidad2").Value
                        If Not IsNull(.Registro.Fields("Precio").Value) Then
                           oL.SubItems(8) = "" & Format(.Registro.Fields("Precio").Value, "#0.0000")
                           oL.SubItems(9) = "" & Format(.Registro.Fields("Precio").Value * .Registro.Fields("Cantidad").Value, "#0.0000")
                        Else
                           oL.SubItems(8) = ""
                           oL.SubItems(9) = ""
                        End If
                        oL.SubItems(10) = ""
                        oL.SubItems(11) = ""
                        oL.SubItems(12) = "" & Format(.Registro.Fields("Precio").Value * .Registro.Fields("Cantidad").Value, "#0.0000")
                        oL.SubItems(13) = "" & Format(.Registro.Fields("PorcentajeIVA").Value, "Fixed")
                        oL.SubItems(14) = "" & Format(.Registro.Fields("ImporteIVA").Value, "#0.0000")
                        oL.SubItems(15) = "" & Format(.Registro.Fields("ImporteTotalItem").Value, "#0.0000")
                        oL.SmallIcon = "Nuevo"
                        .Modificado = True
                     End With
                  End If
               End If
            End With
SalidaFor:
         Next
         
         CalculaPresupuesto
      
      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "Proveedor") <> 0 Then
         
         Columnas = Split(Filas(1), vbTab)
         
         Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", Columnas(2))
         If oRs.RecordCount > 0 Then
            origen.Registro.Fields("IdProveedor").Value = oRs.Fields(0).Value
         End If
         oRs.Close
         
      End If
   
   End If

Salida:
         
   Set oRs = Nothing
   Set oRsPre = Nothing
   Set oRsDet = Nothing
   Set oPr = Nothing
   Set oAp = Nothing
   
   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select
   Resume Salida

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
      Case 0 ' Agregar
         Editar -1
      Case 1
         Editar Lista.SelectedItem.Tag
      Case 2
         If Not Lista.SelectedItem Is Nothing Then
            With Lista.SelectedItem
               origen.DetPresupuestos.Item(.Tag).Eliminado = True
               .SmallIcon = "Eliminado"
               .ToolTipText = .SmallIcon
            End With
            mvarModificado = True
            CalculaPresupuesto
         End If
      Case 3
         If Not Lista.SelectedItem Is Nothing Then
            AsignaBonificacion "S"
         End If
      Case 4
         If Not Lista.SelectedItem Is Nothing Then
            AsignaBonificacion "T"
         End If
      Case 5
         If Not Lista.SelectedItem Is Nothing Then
            AsignaIVA "S"
         End If
      Case 6
         If Not Lista.SelectedItem Is Nothing Then
            AsignaIVA "T"
         End If
      Case 7
         origen.DetPresupuestos.RenumerarItems
         Set Lista.DataSource = origen.DetPresupuestos.RegistrosConFormato
      Case 9
         If Not Lista.SelectedItem Is Nothing Then
            AsignaPrecio "S"
         End If
      Case 10
         If Not Lista.SelectedItem Is Nothing Then
            AsignaPrecio "T"
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

Private Sub CalculaPresupuesto()

   Dim oRs As ADOR.Recordset
   Dim oDet As DetPresupuesto
   Dim i As Integer
   Dim mvarPrecio As Double, mvarCantidad As Double
   
   mvarSubTotal = 0
   mvarSubtotalGravado = 0
   mvarIVA1 = 0
   mvarTotalPresupuesto = 0
   mvarTotalCantidad = 0
   mvarBonificacionPorItem = 0
   mvarBonificacion = 0
   
   For i = 1 To origen.DetPresupuestos.Count
      Set oDet = origen.DetPresupuestos.PosItem(i)
      If Not oDet Is Nothing Then
         With oDet.Registro
            If Not IsNull(.Fields("Precio").Value) Then
               mvarPrecio = .Fields("Precio").Value
            Else
               mvarPrecio = 0
            End If
            If Not IsNull(.Fields("Cantidad").Value) Then
               mvarCantidad = .Fields("Cantidad").Value
            Else
               mvarCantidad = 0
            End If
            If Not IsNull(.Fields("ImporteTotalItem").Value) Then
               mvarSubTotal = mvarSubTotal + .Fields("ImporteTotalItem").Value
            Else
               mvarSubTotal = mvarSubTotal + (mvarPrecio * mvarCantidad)
            End If
            If Not IsNull(.Fields("ImporteBonificacion").Value) Then
               mvarBonificacionPorItem = mvarBonificacionPorItem + .Fields("ImporteBonificacion").Value
            End If
            If Not IsNull(.Fields("ImporteIVA").Value) Then
               mvarIVA1 = mvarIVA1 + .Fields("ImporteIVA").Value
            End If
            mvarTotalCantidad = mvarTotalCantidad + mvarCantidad
         End With
      End If
   Next
   Set oDet = Nothing
   
   mvarSubTotal = mvarSubTotal + mvarBonificacionPorItem - mvarIVA1
   
   If IsNumeric(txtPorcentajeBonificacion.Text) Then
      mvarBonificacion = Round((mvarSubTotal - mvarBonificacionPorItem) * Val(txtPorcentajeBonificacion.Text) / 100, 2)
   End If
   mvarSubtotalGravado = mvarSubTotal - mvarBonificacion - mvarBonificacionPorItem

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
   
   mvarTotalPresupuesto = mvarSubtotalGravado + mvarIVA1 + mvarIVA2
   
   txtSubtotal.Text = Format(mvarSubTotal, "#,##0.00")
   txtBonificacion.Text = Format(mvarBonificacion, "#,##0.00")
   txtBonificacionPorItem.Text = Format(mvarBonificacionPorItem, "#,##0.00")
   txtSubtotalGravado.Text = Format(mvarSubtotalGravado, "#,##0.00")
   txtTotalIva1.Text = Format(mvarIVA1, "#,##0.00")
   txtTotal(0).Text = Format(mvarTotalCantidad, "Fixed")
   txtTotal(1).Text = Format(mvarTotalPresupuesto, "#,##0.00")

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
            Set oRs = Aplicacion.Proveedores.TraerFiltrado("_Busca_NormalesYEventualesParaCombo", txtBusca.Text)
         Else
            Set oRs = Aplicacion.Proveedores.TraerLista
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

Private Sub txtContacto_Change()

   If IsNull(origen.Registro.Fields("Contacto").Value) Or txtContacto.Text <> origen.Registro.Fields("Contacto").Value Then
      If Me.Visible Then mvarModificado = True
   End If
   
End Sub

Private Sub txtContacto_GotFocus()

   With txtContacto
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtContacto_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtDetalle_Change()

   If IsNull(origen.Registro.Fields("Detalle").Value) Or txtDetalle.Text <> origen.Registro.Fields("Detalle").Value Then
      If Me.Visible Then mvarModificado = True
   End If
   
End Sub

Private Sub txtDetalle_GotFocus()

   With txtDetalle
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDetalle_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtDetalleCondicionCompra_Change()

   If IsNull(origen.Registro.Fields("DetalleCondicionCompra").Value) Or txtDetalleCondicionCompra.Text <> origen.Registro.Fields("DetalleCondicionCompra").Value Then
      If Me.Visible Then mvarModificado = True
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

Private Sub txtGarantia_Change()

   If IsNull(origen.Registro.Fields("Garantia").Value) Or txtGarantia.Text <> origen.Registro.Fields("Garantia").Value Then
      If Me.Visible Then mvarModificado = True
   End If
   
End Sub

Private Sub txtGarantia_GotFocus()

   With txtGarantia
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtGarantia_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtLugarEntrega_Change()

   If IsNull(origen.Registro.Fields("LugarEntrega").Value) Or txtLugarEntrega.Text <> origen.Registro.Fields("LugarEntrega").Value Then
      If Me.Visible Then mvarModificado = True
   End If
   
End Sub

Private Sub txtLugarEntrega_GotFocus()

   With txtLugarEntrega
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtLugarEntrega_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumero_Change()

   If IsNull(origen.Registro.Fields("Numero").Value) Or txtNumero.Text <> origen.Registro.Fields("Numero").Value Then
      If Me.Visible Then mvarModificado = True
   End If
   
End Sub

Private Sub txtNumero_GotFocus()
   
   With txtNumero
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumero_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPlazo_Change()

   If IsNull(origen.Registro.Fields("Plazo").Value) Or txtPlazo.Text <> origen.Registro.Fields("Plazo").Value Then
      If Me.Visible Then mvarModificado = True
   End If
   
End Sub

Private Sub txtPlazo_GotFocus()

   With txtPlazo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPlazo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Function DatosProveedor()
         
   If IsNumeric(dcfields(0).BoundText) Then
   
      Dim oRs As ADOR.Recordset
      Dim mvarLocalidad As Long, mvarProvincia As Long
      
      Set oRs = Aplicacion.Proveedores.Item(dcfields(0).BoundText).Registro
      
      With oRs
         mvarLocalidad = IIf(IsNull(.Fields("IdLocalidad").Value), 1, .Fields("IdLocalidad").Value)
         mvarProvincia = IIf(IsNull(.Fields("IdProvincia").Value), 1, .Fields("IdProvincia").Value)
         mvarCondicionIva = IIf(IsNull(.Fields("IdCodigoIva").Value), 1, .Fields("IdCodigoIva").Value)
         txtDireccion.Text = IIf(IsNull(.Fields("Direccion").Value), "", .Fields("Direccion").Value)
         txtTelefono.Text = IIf(IsNull(.Fields("Telefono1").Value), "", .Fields("Telefono1").Value)
         txtEmail.Text = IIf(IsNull(.Fields("Email").Value), "", .Fields("Email").Value)
         txtCuit.Text = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
      End With
      
      If Not IsNull(mvarLocalidad) Then
         Aplicacion.TablasGenerales.Tabla = "Localidades"
         Aplicacion.TablasGenerales.Id = mvarLocalidad
         Set oRs = Aplicacion.TablasGenerales.Registro
         txtLocalidad.Text = IIf(IsNull(oRs.Fields("Nombre").Value), "", oRs.Fields("Nombre").Value)
      End If
      
      If Not IsNull(mvarProvincia) Then
         Aplicacion.TablasGenerales.Tabla = "Provincias"
         Aplicacion.TablasGenerales.Id = mvarProvincia
         Set oRs = Aplicacion.TablasGenerales.Registro
         txtProvincia.Text = IIf(IsNull(oRs.Fields("Nombre").Value), "", oRs.Fields("Nombre").Value)
      End If
      
      If Not IsNull(mvarCondicionIva) Then
         Aplicacion.TablasGenerales.Tabla = "DescripcionIva"
         Aplicacion.TablasGenerales.Id = mvarCondicionIva
         Set oRs = Aplicacion.TablasGenerales.Registro
         txtCondicionIva.Text = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
         mvarTipoIVA = IIf(IsNull(oRs.Fields("IvaDiscriminado").Value), 0, oRs.Fields("IvaDiscriminado").Value)
      End If
      
      oRs.Close
      Set oRs = Nothing
   
   End If

End Function

Private Sub txtPorcentajeBonificacion_Change()

   If IsNull(origen.Registro.Fields("Bonificacion").Value) Or txtPorcentajeBonificacion.Text <> origen.Registro.Fields("Bonificacion").Value Then
      If Me.Visible Then mvarModificado = True
   End If
   
   If Not IsNumeric(txtPorcentajeBonificacion.Text) Then
      origen.Registro.Fields("Bonificacion").Value = 0
   End If
   CalculaPresupuesto
   
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

Private Sub txtPorcentajeBonificacion_LostFocus()

'   CalculaPresupuesto
   
End Sub

Private Sub txtPorcentajeBonificacion_Validate(Cancel As Boolean)

   If IsNumeric(txtPorcentajeBonificacion.Text) Then
      If Val(txtPorcentajeBonificacion.Text) <> 0 Then
         MsgBox "El porcentaje de bonificacion no puede modificarse," & vbCrLf & _
               "ingreselo por item", vbExclamation
         origen.Registro.Fields("Bonificacion").Value = 0
         Cancel = True
      End If
   End If
   
End Sub

Private Sub txtReferencia_Change()

   If IsNull(origen.Registro.Fields("Referencia").Value) Or txtReferencia.Text <> origen.Registro.Fields("Referencia").Value Then
      If Me.Visible Then mvarModificado = True
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

Private Sub txtSubnumero_Change()

   If IsNull(origen.Registro.Fields("Subnumero").Value) Or txtSubnumero.Text <> origen.Registro.Fields("Subnumero").Value Then
      If Me.Visible Then mvarModificado = True
   End If
   
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

Private Sub txtValidez_Change()

   If IsNull(origen.Registro.Fields("Validez").Value) Or txtValidez.Text <> origen.Registro.Fields("Validez").Value Then
      If Me.Visible Then mvarModificado = True
   End If
   
End Sub

Private Sub txtValidez_GotFocus()

   With txtValidez
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtValidez_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub PideAutorizacion()

   Dim oF As frmAutorizacion1
   Set oF = New frmAutorizacion1
   With oF
      .IdUsuario = dcfields(3).BoundText
      .Show vbModal, Me
   End With
   If Not oF.Ok Then
      With origen.Registro
         .Fields(dcfields(3).DataField).Value = Null
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

Public Sub EnviarPresupuestoPorEmail()

   Dim mAux1
   mAux1 = TraerValorParametro2("PaginaSolicitudesCotizacion")
   If Len(Trim(IIf(IsNull(mAux1), "", mAux1))) > 0 Then
      EnviarPresupuestoPorEmail1
      Exit Sub
   End If
   
   Dim oAp As ComPronto.Aplicacion
   Dim goMailOL As CEmailOL
   Dim oRs As ADOR.Recordset
   Dim oRsProv As ADOR.Recordset
   Dim mAttachment As String, mLista As String, mSubject As String, mBody As String, mPre As String
   Dim lStatus As Long, mIdProveedor As Long
   Dim i As Integer
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
   
   cmdImpre_Click 2
   
   mPre = App.Path & "\Solicitud de cotizacion.doc"
   mAttachment = ""
   If Len(Trim(Dir(mPre))) <> 0 Then mAttachment = mAttachment & mPre & ","
      
   Set oRs = oAp.Presupuestos.TraerFiltrado("_AdjuntosPorPresupuesto", mvarId)
   
   If oRs.RecordCount > 0 Then
      oRs.MoveFirst
      Do While Not oRs.EOF
         If Len(Trim(Dir(oRs.Fields("Adjunto").Value))) <> 0 Then
            mAttachment = mAttachment & oRs.Fields("Adjunto").Value & ","
         End If
         oRs.MoveNext
      Loop
   End If
   If Len(mAttachment) > 0 Then mAttachment = mId(mAttachment, 1, Len(mAttachment) - 1)
   
   mLista = oRsProv.Fields("Email").Value
   mSubject = glbEmpresaSegunString & " - Solicitud de cotizacion " & txtNumero.Text & "/" & txtSubnumero.Text
   mBody = "" & vbCrLf & vbCrLf & "     " & vbCrLf
   
   Dim oF As frmCorreo
   Set oF = New frmCorreo
   With oF
      .Email = mLista
      .IdProveedor = mIdProveedor
      .CargarDirecciones
      .txtAsunto.Text = mSubject
      .txtBody.Text = mBody
      .Attachment = mAttachment
      .Show vbModal, Me
      If .Ok Then
         mLista = .Email
         mSubject = .txtAsunto.Text
         mBody = .txtBody.Text
         mAttachment = .Attachment
      Else
         Unload oF
         GoTo Salida
      End If
   End With
   Unload oF

   Set goMailOL = New CEmailOL
      
   If InStr(1, mLista, ";") <> 0 Then
      mVector = VBA.Split(mLista, ";")
      For i = 0 To UBound(mVector)
         lStatus = goMailOL.Send(mVector(i), True, mSubject, mBody, mAttachment)
      Next
   Else
      lStatus = goMailOL.Send(mLista, True, mSubject, mBody, mAttachment)
   End If
   
   oRs.Close
   oRsProv.Close
   
Salida:
   If Len(Trim(mPre)) <> 0 Then
      If Len(Trim(Dir(mPre))) <> 0 Then Kill mPre
   End If
   Set oRs = Nothing
   Set oRsProv = Nothing
   Set goMailOL = Nothing
   Set oAp = Nothing
   Set oF = Nothing

End Sub

Public Sub EnviarPresupuestoPorEmail1()

   Dim oF As frm_Aux
   Set oF = New frm_Aux
   With oF
      .Caption = "Enviar solicitud a proveedores"
      .Text1.Visible = False
      .Label1.Visible = False
      .Width = .Width * 3.5
      .Height = .Height * 3.1
      With .Lista
         .Left = oF.Label1.Left
         .Top = 500
         .Width = 12000
         .Height = 5400
         .CheckBoxes = True
         .Visible = True
      End With
      With .cmd(0)
         .Top = 6000
         .Left = oF.Lista.Left
         .Caption = "Generar"
      End With
      .cmd(1).Top = .cmd(0).Top
      .Parametros = "" & mvarId
      .IdProveedor = origen.Registro.Fields("IdProveedor").Value
      .Id = 20
      .Show vbModal, Me
   End With
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

Private Sub AsignaBonificacion(ByVal mAmbito As String)

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
   Dim mIVA As Double
   Dim mIdDet As Long
   Dim oL As ListItem
   
   For Each oL In Lista.ListItems
      If oL.Selected Or mAmbito = "T" Then
         mIdDet = oL.Tag
         With origen.DetPresupuestos.Item(mIdDet)
            .Registro.Fields("PorcentajeBonificacion").Value = mPorcentajeBonificacion
            mImporte = (.Registro.Fields("Precio").Value * .Registro.Fields("Cantidad").Value)
            mBonificacion = Round(mImporte * mPorcentajeBonificacion / 100, 4)
            If Not IsNull(.Registro.Fields("PorcentajeIVA").Value) Then
               mIVA = Round((mImporte - mBonificacion) * .Registro.Fields("PorcentajeIVA").Value / 100, 4)
            End If
            mImporteItem = mImporte - mBonificacion + mIVA
            .Registro.Fields("ImporteBonificacion").Value = mBonificacion
            .Registro.Fields("ImporteIVA").Value = mIVA
            .Registro.Fields("ImporteTotalItem").Value = mImporteItem
            .Modificado = True
            oL.SubItems(10) = "" & Format(.Registro.Fields("PorcentajeBonificacion").Value, "Fixed")
            oL.SubItems(11) = "" & Format(mBonificacion, "#0.0000")
            oL.SubItems(12) = "" & Format(mImporte - mBonificacion, "#0.0000")
            oL.SubItems(13) = "" & Format(.Registro.Fields("PorcentajeIVA").Value, "Fixed")
            oL.SubItems(14) = "" & Format(.Registro.Fields("ImporteIVA").Value, "#0.0000")
            oL.SubItems(15) = "" & Format(mImporteItem, "#0.0000")
         End With
         oL.SmallIcon = "Modificado"
      End If
   Next
   
   CalculaPresupuesto
   
   mvarModificado = True
   
End Sub

Private Sub AsignaIVA(ByVal mAmbito As String)

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
   Dim mIdDet As Long
   Dim oL As ListItem
   
   For Each oL In Lista.ListItems
      If oL.Selected Or mAmbito = "T" Then
         mIdDet = oL.Tag
         With origen.DetPresupuestos.Item(mIdDet)
            .Registro.Fields("PorcentajeIVA").Value = mPorcentajeIVA
            mImporte = (.Registro.Fields("Precio").Value * .Registro.Fields("Cantidad").Value)
            mBonificacion = IIf(IsNull(.Registro.Fields("ImporteBonificacion").Value), 0, .Registro.Fields("ImporteBonificacion").Value)
            mIVA = Round((mImporte - mBonificacion) * .Registro.Fields("PorcentajeIVA").Value / 100, 4)
            mImporteItem = mImporte - mBonificacion + mIVA
            .Registro.Fields("ImporteIVA").Value = mIVA
            .Registro.Fields("ImporteTotalItem").Value = mImporteItem
            .Modificado = True
            oL.SubItems(13) = "" & Format(.Registro.Fields("PorcentajeIVA").Value, "Fixed")
            oL.SubItems(14) = "" & Format(.Registro.Fields("ImporteIVA").Value, "#0.0000")
            oL.SubItems(15) = "" & Format(.Registro.Fields("ImporteTotalItem").Value, "#0.0000")
         End With
         oL.SmallIcon = "Modificado"
      End If
   Next
   
   CalculaPresupuesto
   
   mvarModificado = True
   
End Sub

Public Sub AsignarOrigenDescripcion(ByVal OrigenDescripcion As Integer)

   If mvarId > 0 And Not IsNull(origen.Registro.Fields("Aprobo").Value) Then
      MsgBox "No puede modificar una solicitud ya registrada", vbCritical
      Exit Sub
   End If
   
   Dim mIdDet As Long
   Dim oL As ListItem
   
   For Each oL In Lista.ListItems
      If oL.Selected Then
         mIdDet = oL.Tag
         With origen.DetPresupuestos.Item(mIdDet)
            .Registro.Fields("OrigenDescripcion").Value = OrigenDescripcion
            .Modificado = True
         End With
         oL.SmallIcon = "Modificado"
      End If
   Next
   mvarModificado = True
   
End Sub

Private Sub AsignaPrecio(ByVal mAmbito As String)

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
   If Not mvarOK Then Exit Sub
   
   Dim mImporte As Double, mBonificacion As Double, mImporteItem As Double
   Dim mIVA As Double
   Dim mIdDet As Long
   Dim oL As ListItem
   
   For Each oL In Lista.ListItems
      If oL.Selected Or mAmbito = "T" Then
         mIdDet = oL.Tag
         With origen.DetPresupuestos.Item(mIdDet)
            .Registro.Fields("Precio").Value = mPrecio
            mImporte = (.Registro.Fields("Precio").Value * .Registro.Fields("Cantidad").Value)
            mBonificacion = Round(mImporte * IIf(IsNull(.Registro.Fields("PorcentajeBonificacion").Value), 0, .Registro.Fields("PorcentajeBonificacion").Value), 4)
            mIVA = Round((mImporte - mBonificacion) * .Registro.Fields("PorcentajeIVA").Value / 100, 4)
            mImporteItem = mImporte - mBonificacion + mIVA
            .Registro.Fields("ImporteIVA").Value = mIVA
            .Registro.Fields("ImporteTotalItem").Value = mImporteItem
            .Modificado = True
            oL.SubItems(8) = "" & Format(mPrecio, "#,##0.0000")
            oL.SubItems(9) = "" & Format(mImporte, "#,##0.00")
            oL.SubItems(11) = "" & Format(mBonificacion, "#,##0.00")
            oL.SubItems(12) = "" & Format(mImporte - mBonificacion, "#,##0.00")
            oL.SubItems(13) = "" & Format(.Registro.Fields("PorcentajeIVA").Value, "Fixed")
            oL.SubItems(14) = "" & Format(.Registro.Fields("ImporteIVA").Value, "#0.0000")
            oL.SubItems(15) = "" & Format(.Registro.Fields("ImporteTotalItem").Value, "#0.0000")
         End With
         oL.SmallIcon = "Modificado"
      End If
   Next
   
   CalculaPresupuesto
   
   mvarModificado = True
   
End Sub

Public Sub BuscarProveedor()

   Dim oF As frmConsulta3
   Dim oRs As ADOR.Recordset, oRs1 As ADOR.Recordset
   Dim mIdArticulo As Long, mIdRubro As Long
   
   mIdArticulo = 0
   mIdRubro = 0
   Set oRs = origen.DetPresupuestos.Registros
   With oRs
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            mIdArticulo = .Fields("IdArticulo").Value
            Set oRs1 = Aplicacion.Articulos.TraerFiltrado("_PorId", mIdArticulo)
            If oRs1.RecordCount > 0 Then
               mIdRubro = IIf(IsNull(oRs1.Fields("IdRubro").Value), 0, oRs1.Fields("IdRubro").Value)
            End If
            oRs1.Close
         End If
      End If
   End With
   Set oRs = Nothing
   Set oRs1 = Nothing
   
   Set oF = New frmConsulta3
   With oF
      .Id = 4
      .IdArticulo = mIdArticulo
      .IdRubro = mIdRubro
      .Show , Me
   End With
   Set oF = Nothing

End Sub
