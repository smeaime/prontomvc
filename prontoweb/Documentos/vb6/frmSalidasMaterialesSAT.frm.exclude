VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmSalidasMaterialesSAT 
   Caption         =   "Salida de material en PRONTO SAT"
   ClientHeight    =   6975
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11550
   LinkTopic       =   "Form1"
   ScaleHeight     =   6975
   ScaleWidth      =   11550
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   420
      Index           =   1
      Left            =   135
      TabIndex        =   32
      Top             =   6345
      Width           =   1110
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
      Left            =   3825
      TabIndex        =   31
      Top             =   45
      Width           =   1050
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   6
      Left            =   1485
      TabIndex        =   30
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   5
      Left            =   1260
      TabIndex        =   29
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   4
      Left            =   1035
      TabIndex        =   28
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   3
      Left            =   810
      TabIndex        =   27
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   2
      Left            =   585
      TabIndex        =   26
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   1
      Left            =   360
      TabIndex        =   25
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   0
      Left            =   135
      TabIndex        =   24
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   0
      ItemData        =   "frmSalidasMaterialesSAT.frx":0000
      Left            =   675
      List            =   "frmSalidasMaterialesSAT.frx":000D
      TabIndex        =   23
      Top             =   45
      Width           =   1860
   End
   Begin VB.TextBox txtCliente 
      Enabled         =   0   'False
      Height          =   330
      Left            =   1800
      TabIndex        =   22
      Top             =   2700
      Width           =   3930
   End
   Begin VB.TextBox txtDireccion 
      Enabled         =   0   'False
      Height          =   330
      Left            =   7515
      TabIndex        =   21
      Top             =   2700
      Width           =   3930
   End
   Begin VB.TextBox txtCodigoPostal 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   330
      Left            =   1800
      TabIndex        =   20
      Top             =   3060
      Width           =   1005
   End
   Begin VB.TextBox txtLocalidad 
      Enabled         =   0   'False
      Height          =   330
      Left            =   2835
      TabIndex        =   19
      Top             =   3060
      Width           =   2895
   End
   Begin VB.TextBox txtCondicionIva 
      Enabled         =   0   'False
      Height          =   330
      Left            =   7515
      TabIndex        =   18
      Top             =   3060
      Width           =   1950
   End
   Begin VB.TextBox txtCuit 
      Enabled         =   0   'False
      Height          =   330
      Left            =   9495
      TabIndex        =   17
      Top             =   3060
      Width           =   1950
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
      Left            =   3060
      TabIndex        =   16
      Top             =   45
      Width           =   690
   End
   Begin VB.Frame Frame1 
      Caption         =   "Costo del flete : "
      Enabled         =   0   'False
      Height          =   420
      Left            =   3105
      TabIndex        =   13
      Top             =   450
      Visible         =   0   'False
      Width           =   3705
      Begin VB.OptionButton Option1 
         Caption         =   "A cargo empresa"
         Height          =   195
         Left            =   135
         TabIndex        =   15
         Top             =   180
         Width           =   1590
      End
      Begin VB.OptionButton Option2 
         Caption         =   "A cargo proveedor"
         Height          =   195
         Left            =   1845
         TabIndex        =   14
         Top             =   180
         Width           =   1635
      End
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
      Left            =   5940
      TabIndex        =   12
      Top             =   945
      Width           =   915
   End
   Begin VB.TextBox txtPatente1 
      DataField       =   "Patente1"
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
      Left            =   8370
      TabIndex        =   11
      Top             =   1755
      Width           =   1500
   End
   Begin VB.TextBox txtPatente2 
      DataField       =   "Patente2"
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
      Left            =   9945
      TabIndex        =   10
      Top             =   1755
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
      Left            =   8370
      TabIndex        =   9
      Top             =   2070
      Width           =   1500
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
      Left            =   9945
      TabIndex        =   8
      Top             =   2070
      Width           =   1500
   End
   Begin VB.TextBox txtNumeroDocumento 
      DataField       =   "NumeroDocumento"
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
      Left            =   9945
      TabIndex        =   7
      Top             =   2385
      Width           =   1500
   End
   Begin VB.TextBox txtReferencia 
      DataField       =   "Referencia"
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
      Left            =   10440
      TabIndex        =   6
      Top             =   6210
      Width           =   1005
   End
   Begin VB.TextBox txtChofer 
      DataField       =   "Chofer"
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
      Left            =   8370
      TabIndex        =   5
      Top             =   2385
      Width           =   1500
   End
   Begin VB.CheckBox Check2 
      Caption         =   "Check2"
      Enabled         =   0   'False
      Height          =   240
      Left            =   8370
      TabIndex        =   4
      Top             =   90
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.CheckBox Check3 
      Caption         =   "Check2"
      Enabled         =   0   'False
      Height          =   240
      Left            =   8370
      TabIndex        =   3
      Top             =   405
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.TextBox txtValorDeclarado 
      DataField       =   "ValorDeclarado"
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
      Left            =   10440
      TabIndex        =   2
      Top             =   6570
      Width           =   1005
   End
   Begin VB.TextBox txtBultos 
      DataField       =   "Bultos"
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
      Left            =   8055
      TabIndex        =   1
      Top             =   6210
      Width           =   1005
   End
   Begin VB.TextBox txtEmbalo 
      DataField       =   "Embalo"
      Height          =   285
      Left            =   7515
      TabIndex        =   0
      Top             =   3420
      Width           =   3930
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1050
      Left            =   1800
      TabIndex        =   33
      Top             =   1620
      Width           =   5055
      _ExtentX        =   8916
      _ExtentY        =   1852
      _Version        =   393217
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmSalidasMaterialesSAT.frx":004A
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaSalidaMateriales"
      Height          =   330
      Index           =   0
      Left            =   5625
      TabIndex        =   34
      Top             =   45
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Enabled         =   0   'False
      Format          =   64356353
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   0
      Left            =   8640
      TabIndex        =   35
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
      TabIndex        =   36
      Top             =   3690
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
      MouseIcon       =   "frmSalidasMaterialesSAT.frx":00CC
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Aprobo"
      Height          =   315
      Index           =   1
      Left            =   1800
      TabIndex        =   37
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
      Left            =   8370
      TabIndex        =   38
      Tag             =   "Transportistas"
      Top             =   1050
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
      Left            =   8370
      TabIndex        =   39
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
      Left            =   1800
      TabIndex        =   40
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
      Left            =   8370
      TabIndex        =   41
      Tag             =   "Proveedores"
      Top             =   720
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
      Left            =   6615
      TabIndex        =   42
      Top             =   1485
      Visible         =   0   'False
      Width           =   420
      _ExtentX        =   741
      _ExtentY        =   344
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmSalidasMaterialesSAT.frx":00E8
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCentroCosto"
      Height          =   315
      Index           =   6
      Left            =   8640
      TabIndex        =   43
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
      Left            =   855
      TabIndex        =   44
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
      Left            =   5175
      Top             =   3465
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
            Picture         =   "frmSalidasMaterialesSAT.frx":016A
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSalidasMaterialesSAT.frx":027C
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSalidasMaterialesSAT.frx":06CE
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSalidasMaterialesSAT.frx":0B20
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdColor"
      Height          =   315
      Index           =   7
      Left            =   7605
      TabIndex        =   45
      Tag             =   "Colores"
      Top             =   6570
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdColor"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdPuntoVenta"
      Height          =   315
      Index           =   10
      Left            =   3060
      TabIndex        =   46
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
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   240
      Index           =   0
      Left            =   135
      TabIndex        =   74
      Top             =   1665
      Width           =   1620
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   4995
      TabIndex        =   73
      Top             =   90
      Width           =   570
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Nro. :"
      Height          =   240
      Index           =   14
      Left            =   2655
      TabIndex        =   72
      Top             =   90
      Width           =   360
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Obra :"
      Height          =   240
      Index           =   0
      Left            =   7065
      TabIndex        =   71
      Top             =   90
      Width           =   1260
   End
   Begin VB.Label lblData 
      Caption         =   "Liberado por :"
      Height          =   240
      Index           =   1
      Left            =   135
      TabIndex        =   70
      Top             =   1305
      Width           =   1620
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Autorizaciones : "
      Height          =   285
      Index           =   1
      Left            =   135
      TabIndex        =   69
      Top             =   2070
      Width           =   1200
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Tipo : "
      Height          =   240
      Index           =   2
      Left            =   180
      TabIndex        =   68
      Top             =   90
      Width           =   450
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Transportista 1 :"
      Height          =   285
      Index           =   2
      Left            =   7065
      TabIndex        =   67
      Top             =   1080
      Width           =   1260
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Transportista 2 :"
      Height          =   285
      Index           =   3
      Left            =   7065
      TabIndex        =   66
      Top             =   1440
      Width           =   1260
   End
   Begin VB.Label lblcliente 
      Caption         =   "Cliente :"
      Height          =   240
      Left            =   135
      TabIndex        =   65
      Top             =   2745
      Width           =   1620
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Direccion :"
      Height          =   240
      Index           =   5
      Left            =   5895
      TabIndex        =   64
      Top             =   2745
      Width           =   1575
   End
   Begin VB.Label lblData 
      Caption         =   "Localidad :"
      Height          =   240
      Index           =   6
      Left            =   135
      TabIndex        =   63
      Top             =   3105
      Width           =   1620
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Condicion Iva / CUIT :"
      Height          =   240
      Index           =   7
      Left            =   5895
      TabIndex        =   62
      Top             =   3105
      Width           =   1560
   End
   Begin VB.Label lblData 
      Caption         =   "Emitido por : "
      Height          =   240
      Index           =   4
      Left            =   135
      TabIndex        =   61
      Top             =   945
      Width           =   1620
   End
   Begin VB.Label lblData 
      Caption         =   "Nro. vale preimpreso :"
      Height          =   240
      Index           =   9
      Left            =   4320
      TabIndex        =   60
      Top             =   945
      Width           =   1560
   End
   Begin VB.Label lblData 
      Caption         =   "Patente(s) :"
      Height          =   285
      Index           =   8
      Left            =   7065
      TabIndex        =   59
      Top             =   1800
      Width           =   1260
   End
   Begin VB.Label lblData 
      Caption         =   "Chofer/Docum. :"
      Height          =   285
      Index           =   10
      Left            =   7065
      TabIndex        =   58
      Top             =   2385
      Width           =   1260
   End
   Begin VB.Label lblData 
      Caption         =   "Referencia :"
      Height          =   285
      Index           =   11
      Left            =   9135
      TabIndex        =   57
      Top             =   6210
      Width           =   1260
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Proveedor :"
      Height          =   285
      Index           =   12
      Left            =   7065
      TabIndex        =   56
      Top             =   720
      Width           =   1260
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Centro de costo :"
      Height          =   240
      Index           =   13
      Left            =   7065
      TabIndex        =   55
      Top             =   405
      Visible         =   0   'False
      Width           =   1260
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
      Left            =   135
      TabIndex        =   54
      Top             =   3465
      Width           =   1545
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
      Left            =   2115
      TabIndex        =   53
      Top             =   3465
      Visible         =   0   'False
      Width           =   3075
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
      Left            =   4320
      TabIndex        =   52
      Top             =   1305
      Visible         =   0   'False
      Width           =   1950
   End
   Begin VB.Label lblData 
      Caption         =   "Origen :"
      Height          =   240
      Index           =   14
      Left            =   180
      TabIndex        =   51
      Top             =   450
      Visible         =   0   'False
      Width           =   630
   End
   Begin VB.Label lblData 
      Caption         =   "Valor declarado :"
      Height          =   285
      Index           =   15
      Left            =   9135
      TabIndex        =   50
      Top             =   6570
      Width           =   1260
   End
   Begin VB.Label lblData 
      Caption         =   "Cantidad bultos :"
      Height          =   240
      Index           =   16
      Left            =   6750
      TabIndex        =   49
      Top             =   6255
      Width           =   1260
   End
   Begin VB.Label lblData 
      Caption         =   "Color ident.:"
      Height          =   285
      Index           =   17
      Left            =   6750
      TabIndex        =   48
      Top             =   6570
      Width           =   855
   End
   Begin VB.Label lblLabels 
      Caption         =   "Embalo :"
      Height          =   240
      Index           =   3
      Left            =   5895
      TabIndex        =   47
      Top             =   3465
      Width           =   1560
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
Attribute VB_Name = "frmSalidasMaterialesSAT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.SalidaMaterialesSAT
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mTipoSalida As Integer, mOk As Integer, mvarIdMonedaPesos As Integer
Private mvarId As Long, mIdAprobo As Long, mvarIdUnidadCU As Long
Private mvarGrabado As Boolean, mvarModoCodigoBarra As Boolean, mvarSoloStockObra As Boolean
Private mvarImpresionHabilitada As Boolean, mvarNumerarPorPuntoVenta As Boolean
Private mvarAnulada As String, mOpcionesAcceso As String, mCadena As String
Private mvarExigirEquipoDestino As String, mDescargaPorKit As String
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

   Dim oF As frmDetSalidasMaterialesSAT
   Set oF = New frmDetSalidasMaterialesSAT
   With oF
      Set .SalidaMaterialesSAT = origen
      .Id = Cual
      .TipoSalida = mTipoSalida
      .Show vbModal, Me
   End With
   Unload oF
   Set oF = Nothing
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 1
         Unload Me
   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oDet As DetSalidaMaterialesSAT
   Dim oRs As ADOR.Recordset
   Dim oRsAut As ADOR.Recordset
   Dim dtf As DTPicker
   Dim ListaVacia As Boolean
   Dim i As Integer, mCantidadFirmas As Integer
   Dim mAuxS1 As String
   Dim mVector
   
   mvarId = vnewvalue
   
   ListaVacia = False
   mCadena = ""
   mvarModoCodigoBarra = False
   mvarAnulada = "NO"
   mvarImpresionHabilitada = True
   mvarSoloStockObra = False
   
   Set oAp = Aplicacion
   
   Set origen = oAp.SalidasMaterialesSAT.Item(vnewvalue)
   
   If glbParametrizacionNivel1 Then
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
   
   mvarNumerarPorPuntoVenta = False
   txtNumeroSalidaMateriales2.Visible = True
   dcfields(10).Visible = False
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetSalidasMaterialesSAT.TraerMascara
                     ListaVacia = True
                  Else
                     If mvarSoloStockObra And Not IsNull(origen.Registro.Fields("IdObra").Value) Then
                        Set oRs = oAp.TablasGenerales.TraerFiltrado("DetSalidasMaterialesSAT", "Sal", Array(mvarId, origen.Registro.Fields("IdObra").Value))
                     Else
                        Set oRs = origen.DetSalidasMaterialesSAT.TraerTodos
                     End If
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           Set oDet = origen.DetSalidasMaterialesSAT.Item(oRs.Fields(0).Value)
                           oDet.Modificado = True
                           Set oDet = Nothing
                           oRs.MoveNext
                        Loop
                        ListaVacia = False
                     Else
                        Set oControl.DataSource = origen.DetSalidasMaterialesSAT.TraerMascara
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
      End With
      mvarGrabado = False
      mIdAprobo = 0
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
         End If
         If Not IsNull(.Fields("Acargo").Value) Then
            If .Fields("Acargo").Value = "A" Then
               Option1.Value = True
            Else
               Option2.Value = True
            End If
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
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
   End If
   
   If ListaVacia Then Lista.ListItems.Clear
   
   Set oRs = Nothing
   Set oDet = Nothing
   Set oAp = Nothing
   
End Property

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Lista_DblClick()

   If Lista.ListItems.Count = 0 Then
   Else
      Editar Lista.SelectedItem.Tag
   End If

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeySpace Then
      MnuDetA_Click 0
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
         Editar Lista.SelectedItem.Tag
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
