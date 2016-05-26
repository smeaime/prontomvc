VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmParametros2 
   Caption         =   "Parametros adicionales"
   ClientHeight    =   8340
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11265
   LinkTopic       =   "Form1"
   ScaleHeight     =   8340
   ScaleWidth      =   11265
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   315
      Index           =   0
      Left            =   90
      TabIndex        =   51
      Top             =   8010
      Width           =   1170
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   315
      Index           =   1
      Left            =   1350
      TabIndex        =   50
      Top             =   8010
      Width           =   1170
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   7935
      Left            =   90
      TabIndex        =   0
      Top             =   45
      Width           =   11085
      _ExtentX        =   19553
      _ExtentY        =   13996
      _Version        =   393216
      Tabs            =   6
      TabsPerRow      =   9
      TabHeight       =   1076
      TabCaption(0)   =   "Modulos PRONTO"
      TabPicture(0)   =   "frmParametros2.frx":0000
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Frame34"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Frame36"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "Frame38"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "Frame39"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).ControlCount=   4
      TabCaption(1)   =   "Pedidos"
      TabPicture(1)   =   "frmParametros2.frx":001C
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "Label1(5)"
      Tab(1).Control(1)=   "Label2"
      Tab(1).Control(2)=   "Label3"
      Tab(1).Control(3)=   "Label4"
      Tab(1).Control(4)=   "Label5"
      Tab(1).Control(5)=   "Label6"
      Tab(1).Control(6)=   "Label7"
      Tab(1).Control(7)=   "RichTextBox7"
      Tab(1).Control(8)=   "RichTextBox5"
      Tab(1).Control(9)=   "RichTextBox6"
      Tab(1).Control(10)=   "RichTextBox1"
      Tab(1).Control(11)=   "RichTextBox2"
      Tab(1).Control(12)=   "RichTextBox3"
      Tab(1).Control(13)=   "RichTextBox4"
      Tab(1).Control(14)=   "Frame1"
      Tab(1).ControlCount=   15
      TabCaption(2)   =   "Articulos"
      TabPicture(2)   =   "frmParametros2.frx":0038
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "Frame2"
      Tab(2).Control(1)=   "Frame4"
      Tab(2).ControlCount=   2
      TabCaption(3)   =   "Ordenes de compra"
      TabPicture(3)   =   "frmParametros2.frx":0054
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "Label56"
      Tab(3).Control(1)=   "Label8"
      Tab(3).Control(2)=   "txtPorcentajeToleranciaOrdenesCompra"
      Tab(3).Control(3)=   "txtCantidadToleranciaOrdenesCompra"
      Tab(3).ControlCount=   4
      TabCaption(4)   =   "Libros de IVA Ventas y Compras"
      TabPicture(4)   =   "frmParametros2.frx":0070
      Tab(4).ControlEnabled=   0   'False
      Tab(4).Control(0)=   "Frame29"
      Tab(4).Control(1)=   "Frame3"
      Tab(4).ControlCount=   2
      TabCaption(5)   =   "PRONTO WEB"
      TabPicture(5)   =   "frmParametros2.frx":008C
      Tab(5).ControlEnabled=   0   'False
      Tab(5).Control(0)=   "Frame5"
      Tab(5).ControlCount=   1
      Begin VB.Frame Frame5 
         Height          =   6855
         Left            =   -74820
         TabIndex        =   128
         Top             =   810
         Width           =   10725
         Begin VB.CheckBox Check1 
            Alignment       =   1  'Right Justify
            Caption         =   "Activar modulos WEB"
            Height          =   195
            Left            =   90
            TabIndex        =   131
            Top             =   225
            Width           =   2130
         End
         Begin VB.TextBox txtPagina1 
            DataField       =   "_PaginaSolicitudesCotizacion"
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
            Left            =   3735
            TabIndex        =   129
            Top             =   585
            Width           =   6810
         End
         Begin VB.Label Label9 
            Caption         =   "Pagina para direccionar solicitudes de cotizacion :"
            Height          =   240
            Left            =   90
            TabIndex        =   130
            Top             =   585
            Width           =   3705
         End
      End
      Begin VB.Frame Frame4 
         Caption         =   "Articulos estandar :"
         Height          =   1545
         Left            =   -69915
         TabIndex        =   123
         Top             =   765
         Width           =   5415
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "_IdArticuloParaImportacionFacturas"
            Height          =   315
            Index           =   6
            Left            =   90
            TabIndex        =   124
            Tag             =   "Articulos"
            Top             =   495
            Width           =   5235
            _ExtentX        =   9234
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdArticulo"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "_IdConceptoParaImportacionNDNC"
            Height          =   315
            Index           =   7
            Left            =   90
            TabIndex        =   126
            Tag             =   "Conceptos"
            Top             =   1080
            Width           =   5235
            _ExtentX        =   9234
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdConcepto"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Para notas de debito y credito importadas :"
            Height          =   240
            Index           =   10
            Left            =   90
            TabIndex        =   127
            Top             =   900
            Width           =   3120
         End
         Begin VB.Label lblLabels 
            Caption         =   "Para facturas importadas :"
            Height          =   240
            Index           =   9
            Left            =   90
            TabIndex        =   125
            Top             =   315
            Width           =   1815
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Columnas adicionales para libro de iva ventas :"
         Height          =   2805
         Left            =   -74820
         TabIndex        =   107
         Top             =   765
         Width           =   5055
         Begin VB.CheckBox Check11 
            Height          =   240
            Index           =   9
            Left            =   1080
            TabIndex        =   112
            Top             =   1800
            Width           =   195
         End
         Begin VB.CheckBox Check11 
            Height          =   240
            Index           =   8
            Left            =   1080
            TabIndex        =   111
            Top             =   1440
            Width           =   195
         End
         Begin VB.CheckBox Check11 
            Height          =   240
            Index           =   7
            Left            =   1080
            TabIndex        =   110
            Top             =   1080
            Width           =   195
         End
         Begin VB.CheckBox Check11 
            Height          =   240
            Index           =   6
            Left            =   1080
            TabIndex        =   109
            Top             =   720
            Width           =   195
         End
         Begin VB.CheckBox Check11 
            Height          =   240
            Index           =   5
            Left            =   1080
            TabIndex        =   108
            Top             =   360
            Width           =   195
         End
         Begin MSDataListLib.DataCombo dcfields1 
            DataField       =   "_IdCuentaAdicionalIVAVentas1"
            Height          =   315
            Index           =   5
            Left            =   1305
            TabIndex        =   113
            Tag             =   "Cuentas"
            Top             =   315
            Width           =   3615
            _ExtentX        =   6376
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields1 
            DataField       =   "_IdCuentaAdicionalIVAVentas2"
            Height          =   315
            Index           =   6
            Left            =   1305
            TabIndex        =   114
            Tag             =   "Cuentas"
            Top             =   675
            Width           =   3615
            _ExtentX        =   6376
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields1 
            DataField       =   "_IdCuentaAdicionalIVAVentas3"
            Height          =   315
            Index           =   7
            Left            =   1305
            TabIndex        =   115
            Tag             =   "Cuentas"
            Top             =   1035
            Width           =   3615
            _ExtentX        =   6376
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields1 
            DataField       =   "_IdCuentaAdicionalIVAVentas4"
            Height          =   315
            Index           =   8
            Left            =   1305
            TabIndex        =   116
            Tag             =   "Cuentas"
            Top             =   1395
            Width           =   3615
            _ExtentX        =   6376
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields1 
            DataField       =   "_IdCuentaAdicionalIVAVentas5"
            Height          =   315
            Index           =   9
            Left            =   1305
            TabIndex        =   117
            Tag             =   "Cuentas"
            Top             =   1755
            Width           =   3615
            _ExtentX        =   6376
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Col. adic. 5 : "
            Height          =   195
            Index           =   8
            Left            =   90
            TabIndex        =   122
            Top             =   1800
            Width           =   1005
         End
         Begin VB.Label lblLabels 
            Caption         =   "Col. adic. 4 : "
            Height          =   195
            Index           =   7
            Left            =   90
            TabIndex        =   121
            Top             =   1440
            Width           =   1005
         End
         Begin VB.Label lblLabels 
            Caption         =   "Col. adic. 3 : "
            Height          =   195
            Index           =   6
            Left            =   90
            TabIndex        =   120
            Top             =   1080
            Width           =   1005
         End
         Begin VB.Label lblLabels 
            Caption         =   "Col. adic. 2 : "
            Height          =   195
            Index           =   5
            Left            =   90
            TabIndex        =   119
            Top             =   720
            Width           =   1005
         End
         Begin VB.Label lblLabels 
            Caption         =   "Col. adic. 1 : "
            Height          =   195
            Index           =   4
            Left            =   90
            TabIndex        =   118
            Top             =   360
            Width           =   1005
         End
      End
      Begin VB.Frame Frame29 
         Caption         =   "Columnas adicionales para libro de iva compras :"
         Height          =   2805
         Left            =   -69150
         TabIndex        =   90
         Top             =   765
         Width           =   5055
         Begin VB.CheckBox Check11 
            Height          =   240
            Index           =   0
            Left            =   1080
            TabIndex        =   96
            Top             =   360
            Width           =   195
         End
         Begin VB.CheckBox Check11 
            Height          =   240
            Index           =   1
            Left            =   1080
            TabIndex        =   95
            Top             =   720
            Width           =   195
         End
         Begin VB.CheckBox Check11 
            Height          =   240
            Index           =   2
            Left            =   1080
            TabIndex        =   94
            Top             =   1080
            Width           =   195
         End
         Begin VB.CheckBox Check11 
            Height          =   240
            Index           =   3
            Left            =   1080
            TabIndex        =   93
            Top             =   1440
            Width           =   195
         End
         Begin VB.CheckBox Check11 
            Height          =   240
            Index           =   4
            Left            =   1080
            TabIndex        =   92
            Top             =   1800
            Width           =   195
         End
         Begin VB.CheckBox Check13 
            Alignment       =   1  'Right Justify
            Caption         =   "Desglosar en libro de iva compras la columna NO GRAVADO :"
            Height          =   330
            Left            =   90
            TabIndex        =   91
            Top             =   2160
            Width           =   4785
         End
         Begin MSDataListLib.DataCombo dcfields1 
            DataField       =   "IdCuentaAdicionalIVACompras1"
            Height          =   315
            Index           =   0
            Left            =   1305
            TabIndex        =   97
            Tag             =   "Cuentas"
            Top             =   315
            Width           =   3615
            _ExtentX        =   6376
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields1 
            DataField       =   "IdCuentaAdicionalIVACompras2"
            Height          =   315
            Index           =   1
            Left            =   1305
            TabIndex        =   98
            Tag             =   "Cuentas"
            Top             =   675
            Width           =   3615
            _ExtentX        =   6376
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields1 
            DataField       =   "IdCuentaAdicionalIVACompras3"
            Height          =   315
            Index           =   2
            Left            =   1305
            TabIndex        =   99
            Tag             =   "Cuentas"
            Top             =   1035
            Width           =   3615
            _ExtentX        =   6376
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields1 
            DataField       =   "IdCuentaAdicionalIVACompras4"
            Height          =   315
            Index           =   3
            Left            =   1305
            TabIndex        =   100
            Tag             =   "Cuentas"
            Top             =   1395
            Width           =   3615
            _ExtentX        =   6376
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields1 
            DataField       =   "IdCuentaAdicionalIVACompras5"
            Height          =   315
            Index           =   4
            Left            =   1305
            TabIndex        =   101
            Tag             =   "Cuentas"
            Top             =   1755
            Width           =   3615
            _ExtentX        =   6376
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Col. adic. 1 : "
            Height          =   195
            Index           =   90
            Left            =   90
            TabIndex        =   106
            Top             =   360
            Width           =   1005
         End
         Begin VB.Label lblLabels 
            Caption         =   "Col. adic. 2 : "
            Height          =   195
            Index           =   91
            Left            =   90
            TabIndex        =   105
            Top             =   720
            Width           =   1005
         End
         Begin VB.Label lblLabels 
            Caption         =   "Col. adic. 3 : "
            Height          =   195
            Index           =   92
            Left            =   90
            TabIndex        =   104
            Top             =   1080
            Width           =   1005
         End
         Begin VB.Label lblLabels 
            Caption         =   "Col. adic. 4 : "
            Height          =   195
            Index           =   93
            Left            =   90
            TabIndex        =   103
            Top             =   1440
            Width           =   1005
         End
         Begin VB.Label lblLabels 
            Caption         =   "Col. adic. 5 : "
            Height          =   195
            Index           =   94
            Left            =   90
            TabIndex        =   102
            Top             =   1800
            Width           =   1005
         End
      End
      Begin VB.TextBox txtCantidadToleranciaOrdenesCompra 
         Alignment       =   2  'Center
         DataField       =   "_CantidadToleranciaOrdenesCompra"
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
         Left            =   -70635
         TabIndex        =   88
         Top             =   1440
         Width           =   825
      End
      Begin VB.TextBox txtPorcentajeToleranciaOrdenesCompra 
         Alignment       =   2  'Center
         DataField       =   "_PorcentajeToleranciaOrdenesCompra"
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
         Left            =   -70635
         TabIndex        =   86
         Top             =   945
         Width           =   825
      End
      Begin VB.Frame Frame2 
         Caption         =   "Grupos : "
         Height          =   2040
         Left            =   -74775
         TabIndex        =   63
         Top             =   765
         Width           =   4785
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "_IdTipoArticuloMateriales"
            Height          =   315
            Index           =   0
            Left            =   1575
            TabIndex        =   64
            Tag             =   "TiposArticulos"
            Top             =   315
            Width           =   3075
            _ExtentX        =   5424
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipo"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "_IdTipoArticuloEquipos"
            Height          =   315
            Index           =   1
            Left            =   1575
            TabIndex        =   66
            Tag             =   "TiposArticulos"
            Top             =   735
            Width           =   3075
            _ExtentX        =   5424
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipo"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "_IdTipoArticuloManoObra"
            Height          =   315
            Index           =   2
            Left            =   1575
            TabIndex        =   68
            Tag             =   "TiposArticulos"
            Top             =   1155
            Width           =   3075
            _ExtentX        =   5424
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipo"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "_IdTipoArticuloSubcontratos"
            Height          =   315
            Index           =   5
            Left            =   1575
            TabIndex        =   70
            Tag             =   "TiposArticulos"
            Top             =   1575
            Width           =   3075
            _ExtentX        =   5424
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipo"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Subcontratos :"
            Height          =   240
            Index           =   3
            Left            =   135
            TabIndex        =   71
            Top             =   1620
            Width           =   1320
         End
         Begin VB.Label lblLabels 
            Caption         =   "Mano de obra :"
            Height          =   240
            Index           =   2
            Left            =   135
            TabIndex        =   69
            Top             =   1170
            Width           =   1320
         End
         Begin VB.Label lblLabels 
            Caption         =   "Equipos :"
            Height          =   240
            Index           =   1
            Left            =   135
            TabIndex        =   67
            Top             =   765
            Width           =   1320
         End
         Begin VB.Label lblLabels 
            Caption         =   "Materiales :"
            Height          =   240
            Index           =   0
            Left            =   135
            TabIndex        =   65
            Top             =   360
            Width           =   1320
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "Textos para otros conceptos :"
         Height          =   1995
         Left            =   -74820
         TabIndex        =   52
         Top             =   855
         Width           =   6450
         Begin VB.TextBox Text1 
            Height          =   285
            Index           =   4
            Left            =   2430
            TabIndex        =   62
            Top             =   1545
            Width           =   3795
         End
         Begin VB.TextBox Text1 
            Height          =   285
            Index           =   3
            Left            =   2430
            TabIndex        =   61
            Top             =   1215
            Width           =   3795
         End
         Begin VB.TextBox Text1 
            Height          =   285
            Index           =   2
            Left            =   2430
            TabIndex        =   60
            Top             =   885
            Width           =   3795
         End
         Begin VB.TextBox Text1 
            Height          =   285
            Index           =   1
            Left            =   2430
            TabIndex        =   59
            Top             =   555
            Width           =   3795
         End
         Begin VB.TextBox Text1 
            Height          =   285
            Index           =   0
            Left            =   2430
            TabIndex        =   54
            Top             =   225
            Width           =   3795
         End
         Begin VB.Label Label1 
            Caption         =   "Descripcion otros conceptos 5 :"
            Height          =   240
            Index           =   4
            Left            =   135
            TabIndex        =   58
            Top             =   1590
            Width           =   2175
         End
         Begin VB.Label Label1 
            Caption         =   "Descripcion otros conceptos 4 :"
            Height          =   240
            Index           =   3
            Left            =   135
            TabIndex        =   57
            Top             =   1260
            Width           =   2175
         End
         Begin VB.Label Label1 
            Caption         =   "Descripcion otros conceptos 3 :"
            Height          =   240
            Index           =   2
            Left            =   135
            TabIndex        =   56
            Top             =   930
            Width           =   2175
         End
         Begin VB.Label Label1 
            Caption         =   "Descripcion otros conceptos 2 :"
            Height          =   240
            Index           =   1
            Left            =   135
            TabIndex        =   55
            Top             =   600
            Width           =   2175
         End
         Begin VB.Label Label1 
            Caption         =   "Descripcion otros conceptos 1 :"
            Height          =   240
            Index           =   0
            Left            =   135
            TabIndex        =   53
            Top             =   270
            Width           =   2175
         End
      End
      Begin VB.Frame Frame39 
         Caption         =   "PRONTO SAT :"
         Height          =   1365
         Left            =   180
         TabIndex        =   40
         Top             =   6435
         Width           =   10725
         Begin VB.CheckBox Check24 
            Height          =   195
            Left            =   7110
            TabIndex        =   44
            Top             =   990
            Width           =   195
         End
         Begin VB.CheckBox Check23 
            Height          =   195
            Left            =   4995
            TabIndex        =   43
            Top             =   990
            Width           =   195
         End
         Begin VB.TextBox txtPathEnvioEmails 
            DataField       =   "PathEnvioEmails"
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
            Left            =   3195
            TabIndex        =   42
            Top             =   315
            Width           =   7395
         End
         Begin VB.TextBox txtPathRecepcionEmails 
            DataField       =   "PathRecepcionEmails"
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
            Left            =   3195
            TabIndex        =   41
            Top             =   630
            Width           =   7395
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "_IdUbicacionStockEnTransito"
            Height          =   315
            Index           =   20
            Left            =   7380
            TabIndex        =   45
            Tag             =   "Ubicaciones"
            Top             =   945
            Width           =   3195
            _ExtentX        =   5636
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdUbicacion"
            Text            =   ""
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Mercaderia en transito :"
            Height          =   240
            Index           =   9
            Left            =   5400
            TabIndex        =   49
            Top             =   990
            Width           =   1695
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Crear un ajuste por cada recepcion recibida desde PRONTOSAT :"
            Height          =   195
            Index           =   8
            Left            =   90
            TabIndex        =   48
            Top             =   990
            Width           =   4815
         End
         Begin VB.Label Label35 
            Caption         =   "Dir. p/envio de mensajes a SAT :"
            Height          =   195
            Left            =   90
            TabIndex        =   47
            Top             =   360
            Width           =   2895
         End
         Begin VB.Label Label36 
            Caption         =   "Dir. p/recepcion de mensajes desde SAT :"
            Height          =   240
            Left            =   90
            TabIndex        =   46
            Top             =   630
            Width           =   3075
         End
      End
      Begin VB.Frame Frame38 
         Caption         =   "Consolida con : "
         Height          =   1950
         Left            =   180
         TabIndex        =   22
         Top             =   4410
         Width           =   10725
         Begin VB.CheckBox Check20 
            Height          =   195
            Left            =   5670
            TabIndex        =   28
            Top             =   1125
            Width           =   195
         End
         Begin VB.TextBox txtPorcentajeConsolidacion3 
            Alignment       =   2  'Center
            DataField       =   "PorcentajeConsolidacion3"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   9945
            TabIndex        =   27
            Top             =   1080
            Width           =   645
         End
         Begin VB.CheckBox Check19 
            Height          =   195
            Left            =   5670
            TabIndex        =   26
            Top             =   720
            Width           =   195
         End
         Begin VB.TextBox txtPorcentajeConsolidacion2 
            Alignment       =   2  'Center
            DataField       =   "PorcentajeConsolidacion2"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   9945
            TabIndex        =   25
            Top             =   675
            Width           =   645
         End
         Begin VB.TextBox txtPorcentajeConsolidacion 
            Alignment       =   2  'Center
            DataField       =   "PorcentajeConsolidacion"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   9945
            TabIndex        =   24
            Top             =   270
            Width           =   645
         End
         Begin VB.CheckBox Check18 
            Height          =   195
            Left            =   5670
            TabIndex        =   23
            Top             =   315
            Width           =   195
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            Height          =   315
            Index           =   16
            Left            =   5940
            TabIndex        =   29
            Tag             =   "Bases"
            Top             =   270
            Width           =   3645
            _ExtentX        =   6429
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   ""
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            Height          =   315
            Index           =   17
            Left            =   5940
            TabIndex        =   30
            Tag             =   "Bases"
            Top             =   675
            Width           =   3645
            _ExtentX        =   6429
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   ""
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            Height          =   315
            Index           =   18
            Left            =   5940
            TabIndex        =   31
            Tag             =   "Bases"
            Top             =   1080
            Width           =   3645
            _ExtentX        =   6429
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   ""
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaAjusteConsolidacion"
            Height          =   315
            Index           =   56
            Left            =   5940
            TabIndex        =   32
            Tag             =   "Cuentas"
            Top             =   1485
            Width           =   4650
            _ExtentX        =   8202
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta contable para ajustar diferencias en la consolidacion (en esta BD) :"
            Height          =   285
            Index           =   106
            Left            =   90
            TabIndex        =   39
            Top             =   1530
            Width           =   5490
         End
         Begin VB.Label lblFieldLabel 
            Alignment       =   2  'Center
            Caption         =   "% :"
            Height          =   240
            Index           =   6
            Left            =   9630
            TabIndex        =   38
            Top             =   1125
            Width           =   315
         End
         Begin VB.Label lblFieldLabel 
            Alignment       =   2  'Center
            Caption         =   "% :"
            Height          =   240
            Index           =   5
            Left            =   9630
            TabIndex        =   37
            Top             =   720
            Width           =   315
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Nombre de la base de datos PRONTO contra la que consolida (opcional) [3] :"
            Height          =   285
            Index           =   4
            Left            =   90
            TabIndex        =   36
            Top             =   1125
            Width           =   5490
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Nombre de la base de datos PRONTO contra la que consolida (opcional) [2] :"
            Height          =   285
            Index           =   3
            Left            =   90
            TabIndex        =   35
            Top             =   720
            Width           =   5490
         End
         Begin VB.Label lblFieldLabel 
            Alignment       =   2  'Center
            Caption         =   "% :"
            Height          =   240
            Index           =   1
            Left            =   9630
            TabIndex        =   34
            Top             =   315
            Width           =   315
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Nombre de la base de datos PRONTO contra la que consolida (opcional) [1] :"
            Height          =   285
            Index           =   2
            Left            =   90
            TabIndex        =   33
            Top             =   315
            Width           =   5490
         End
      End
      Begin VB.Frame Frame36 
         Caption         =   "PRONTO SyJ :"
         Height          =   1050
         Left            =   180
         TabIndex        =   17
         Top             =   3240
         Width           =   10725
         Begin VB.CheckBox Check17 
            Alignment       =   1  'Right Justify
            Caption         =   "Nombre de la base de datos PRONTO SyJ (opcional) :"
            Height          =   195
            Left            =   45
            TabIndex        =   18
            Top             =   315
            Width           =   4290
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            Height          =   315
            Index           =   3
            Left            =   4410
            TabIndex        =   19
            Tag             =   "Bases"
            Top             =   270
            Width           =   6165
            _ExtentX        =   10874
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   ""
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdConceptoAnticiposSyJ"
            Height          =   315
            Index           =   4
            Left            =   4410
            TabIndex        =   20
            Tag             =   "ConceptosSyJ"
            Top             =   675
            Width           =   6165
            _ExtentX        =   10874
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdConcepto"
            Text            =   ""
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Concepto destino de la deduccion por anticipos :"
            Height          =   240
            Index           =   0
            Left            =   90
            TabIndex        =   21
            Top             =   720
            Width           =   4005
         End
      End
      Begin VB.Frame Frame34 
         Caption         =   "PRONTO Mantenimiento :"
         Height          =   2535
         Left            =   180
         TabIndex        =   1
         Top             =   630
         Width           =   10725
         Begin VB.CheckBox Check31 
            Alignment       =   1  'Right Justify
            Caption         =   "Facturar a obra los consumos generados desde las salidas de materiales en PRONTO Mantenimiento :"
            Height          =   195
            Left            =   45
            TabIndex        =   5
            Top             =   2205
            Width           =   7530
         End
         Begin VB.CheckBox Check22 
            Height          =   195
            Left            =   4860
            TabIndex        =   4
            Top             =   1125
            Width           =   195
         End
         Begin VB.TextBox Text4 
            DataField       =   "PathEnvioEmailsMANTENIMIENTO"
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
            Left            =   3240
            TabIndex        =   3
            Top             =   405
            Width           =   7305
         End
         Begin VB.TextBox Text3 
            DataField       =   "PathRecepcionEmailsMANTENIMIENTO"
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
            Left            =   3240
            TabIndex        =   2
            Top             =   720
            Width           =   7305
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdArticuloPRONTO_MANTENIMIENTO"
            Height          =   315
            Index           =   15
            Left            =   4455
            TabIndex        =   6
            Tag             =   "ArticulosMantenimiento"
            Top             =   1440
            Width           =   6135
            _ExtentX        =   10821
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdArticulo"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            Height          =   315
            Index           =   22
            Left            =   5085
            TabIndex        =   7
            Tag             =   "Bases"
            Top             =   1080
            Width           =   5490
            _ExtentX        =   9684
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   ""
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "_IdRubroEquiposTerceros"
            Height          =   315
            Index           =   24
            Left            =   2520
            TabIndex        =   8
            Tag             =   "Rubros"
            Top             =   1800
            Width           =   4110
            _ExtentX        =   7250
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdRubro"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "_IdSubrubroEquiposTerceros"
            Height          =   315
            Index           =   25
            Left            =   7515
            TabIndex        =   9
            Tag             =   "Subrubros"
            Top             =   1800
            Width           =   3075
            _ExtentX        =   5424
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdSubrubro"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Articulo de Pronto Mantenimiento para repuestos en general :"
            Height          =   240
            Index           =   100
            Left            =   90
            TabIndex        =   16
            Top             =   1485
            Width           =   4425
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Nombre de la base de datos PRONTO Mantenimiento (opcional) :"
            Height          =   285
            Index           =   7
            Left            =   90
            TabIndex        =   15
            Top             =   1080
            Width           =   4995
         End
         Begin VB.Label Label40 
            Caption         =   "Dir. p/envio de mensajes a MANT.:"
            Height          =   240
            Left            =   90
            TabIndex        =   14
            Top             =   405
            Width           =   2895
         End
         Begin VB.Label Label39 
            Caption         =   "Dir. p/recepcion de mensajes desde MANT. :"
            Height          =   240
            Left            =   90
            TabIndex        =   13
            Top             =   720
            Width           =   3120
         End
         Begin VB.Label lblLabels 
            Caption         =   "Equipos de terceros :"
            Height          =   240
            Index           =   112
            Left            =   90
            TabIndex        =   12
            Top             =   1845
            Width           =   1545
         End
         Begin VB.Label lblLabels 
            Caption         =   "Rubro :"
            Height          =   240
            Index           =   113
            Left            =   1800
            TabIndex        =   11
            Top             =   1845
            Width           =   645
         End
         Begin VB.Label lblLabels 
            Caption         =   "Subrubro :"
            Height          =   240
            Index           =   114
            Left            =   6750
            TabIndex        =   10
            Top             =   1845
            Width           =   780
         End
      End
      Begin RichTextLib.RichTextBox RichTextBox4 
         Height          =   690
         Left            =   -72300
         TabIndex        =   72
         Top             =   4950
         Width           =   8115
         _ExtentX        =   14314
         _ExtentY        =   1217
         _Version        =   393217
         ScrollBars      =   2
         TextRTF         =   $"frmParametros2.frx":00A8
      End
      Begin RichTextLib.RichTextBox RichTextBox3 
         Height          =   690
         Left            =   -72300
         TabIndex        =   73
         Top             =   4260
         Width           =   8115
         _ExtentX        =   14314
         _ExtentY        =   1217
         _Version        =   393217
         ScrollBars      =   2
         TextRTF         =   $"frmParametros2.frx":0122
      End
      Begin RichTextLib.RichTextBox RichTextBox2 
         Height          =   690
         Left            =   -72300
         TabIndex        =   74
         Top             =   3570
         Width           =   8115
         _ExtentX        =   14314
         _ExtentY        =   1217
         _Version        =   393217
         ScrollBars      =   2
         TextRTF         =   $"frmParametros2.frx":019C
      End
      Begin RichTextLib.RichTextBox RichTextBox1 
         Height          =   690
         Left            =   -72300
         TabIndex        =   75
         Top             =   2880
         Width           =   8115
         _ExtentX        =   14314
         _ExtentY        =   1217
         _Version        =   393217
         ScrollBars      =   2
         TextRTF         =   $"frmParametros2.frx":0216
      End
      Begin RichTextLib.RichTextBox RichTextBox6 
         Height          =   690
         Left            =   -72300
         TabIndex        =   80
         Top             =   6330
         Width           =   8115
         _ExtentX        =   14314
         _ExtentY        =   1217
         _Version        =   393217
         ScrollBars      =   2
         TextRTF         =   $"frmParametros2.frx":0290
      End
      Begin RichTextLib.RichTextBox RichTextBox5 
         Height          =   690
         Left            =   -72300
         TabIndex        =   81
         Top             =   5640
         Width           =   8115
         _ExtentX        =   14314
         _ExtentY        =   1217
         _Version        =   393217
         ScrollBars      =   2
         TextRTF         =   $"frmParametros2.frx":030A
      End
      Begin RichTextLib.RichTextBox RichTextBox7 
         Height          =   690
         Left            =   -72300
         TabIndex        =   84
         Top             =   7020
         Width           =   8115
         _ExtentX        =   14314
         _ExtentY        =   1217
         _Version        =   393217
         ScrollBars      =   2
         TextRTF         =   $"frmParametros2.frx":0384
      End
      Begin VB.Label Label8 
         Caption         =   "Cantidad control como tope luego de aplicar el porcentaje de tolerancia. "
         Height          =   420
         Left            =   -74820
         TabIndex        =   89
         Top             =   1305
         Width           =   3975
      End
      Begin VB.Label Label56 
         Caption         =   "Porcentaje de tolerancia para considerar los items de orden de compra como cumplidos (por facturacion) :"
         Height          =   420
         Left            =   -74820
         TabIndex        =   87
         Top             =   810
         Width           =   3975
      End
      Begin VB.Label Label7 
         Caption         =   "Texto fijo para importante en pedidos :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   465
         Left            =   -74865
         TabIndex        =   85
         Top             =   7110
         Width           =   2460
      End
      Begin VB.Label Label6 
         Caption         =   "Texto fijo para inspecciones en pedidos :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   465
         Left            =   -74865
         TabIndex        =   83
         Top             =   6435
         Width           =   2460
      End
      Begin VB.Label Label5 
         Caption         =   "Texto fijo para garantias en pedidos :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   465
         Left            =   -74865
         TabIndex        =   82
         Top             =   5745
         Width           =   2460
      End
      Begin VB.Label Label4 
         Caption         =   "Texto fijo para documentacion en pedidos :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   465
         Left            =   -74865
         TabIndex        =   79
         Top             =   5055
         Width           =   2460
      End
      Begin VB.Label Label3 
         Caption         =   "Texto fijo para forma de pago en pedidos :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   465
         Left            =   -74865
         TabIndex        =   78
         Top             =   4365
         Width           =   2460
      End
      Begin VB.Label Label2 
         Caption         =   "Texto fijo para lugar de entrega en pedidos :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   465
         Left            =   -74865
         TabIndex        =   77
         Top             =   3675
         Width           =   2460
      End
      Begin VB.Label Label1 
         Caption         =   "Texto fijo para plazo de entrega en pedidos :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   465
         Index           =   5
         Left            =   -74865
         TabIndex        =   76
         Top             =   2985
         Width           =   2460
      End
   End
End
Attribute VB_Name = "frmParametros2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents oParametros As ComPronto.Parametro
Attribute oParametros.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mFechaTimeStamp1 As Long
Private SelectedTab As Integer

Private Sub Check1_Click()

   If Check1.Value = 1 Then
      txtPagina1.Enabled = True
   Else
      With txtPagina1
         .Text = ""
         .Enabled = False
      End With
   End If

End Sub

Private Sub Check11_Click(Index As Integer)

   If Check11(Index).Value = 1 Then
      dcfields1(Index).Enabled = True
   Else
      If mId(dcfields1(Index).DataField, 1, 1) <> "_" Then oParametros.Registro.Fields(dcfields1(Index).DataField).Value = Null
      dcfields1(Index).Enabled = False
   End If
   
End Sub

Private Sub Check17_Click()

   If Check17.Value = 1 Then
      DataCombo1(3).Enabled = True
      DataCombo1(4).Enabled = True
   Else
      oParametros.Registro.Fields("IdConceptoAnticiposSyJ").Value = Null
      DataCombo1(3).Enabled = False
      DataCombo1(4).Enabled = False
   End If

End Sub

Private Sub Check18_Click()

   If Check18.Value = 1 Then
      DataCombo1(16).Enabled = True
      txtPorcentajeConsolidacion.Enabled = True
   Else
      oParametros.Registro.Fields("PorcentajeConsolidacion").Value = Null
      DataCombo1(16).Enabled = False
      txtPorcentajeConsolidacion.Enabled = False
   End If

End Sub

Private Sub Check19_Click()

   If Check19.Value = 1 Then
      DataCombo1(17).Enabled = True
      txtPorcentajeConsolidacion2.Enabled = True
   Else
      oParametros.Registro.Fields("PorcentajeConsolidacion2").Value = Null
      DataCombo1(17).Enabled = False
      txtPorcentajeConsolidacion2.Enabled = False
   End If

End Sub

Private Sub Check20_Click()

   If Check20.Value = 1 Then
      DataCombo1(18).Enabled = True
      txtPorcentajeConsolidacion3.Enabled = True
   Else
      oParametros.Registro.Fields("PorcentajeConsolidacion3").Value = Null
      DataCombo1(18).Enabled = False
      txtPorcentajeConsolidacion3.Enabled = False
   End If

End Sub

Private Sub Check22_Click()

   If Check22.Value = 1 Then
      DataCombo1(22).Enabled = True
   Else
      oParametros.Registro.Fields("BasePRONTOMantenimiento").Value = Null
      DataCombo1(22).Enabled = False
   End If

End Sub

Private Sub Check24_Click()

   If Check24.Value = 1 Then
      DataCombo1(20).Enabled = True
   Else
      With DataCombo1(20)
         .BoundText = ""
         .Text = ""
         .Enabled = False
      End With
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Dim oRs As ADOR.Recordset
         Dim est As EnumAcciones
         Dim oControl As Control
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim i As Integer
      
         With oParametros.Registro
            For Each oControl In Me.Controls
               If TypeOf oControl Is CommandButton Then
               ElseIf TypeOf oControl Is RichTextBox Then
                  If Len(oControl.DataField) Then
                     .Fields(oControl.DataField).Value = oControl.Text
                  End If
               ElseIf TypeOf oControl Is TextBox Then
                  If Len(oControl.DataField) Then
                     If VBA.mId(oControl.DataField, 1, 1) = "_" Then
                        If oControl.Enabled And oControl.Visible Then
                           GuardarValorParametro2 mId(oControl.DataField, 2, Len(oControl.DataField) - 1), oControl.Text
                        Else
                           GuardarValorParametro2 mId(oControl.DataField, 2, Len(oControl.DataField) - 1), ""
                        End If
                     Else
                        If .Fields(oControl.DataField).Type = adInteger Then
                           If Not IsNumeric(.Fields(oControl.DataField).Value) And oControl.Visible Then
                              MsgBox "Hay campos numericos incompletos o invalidos (" & oControl.DataField & ")", vbExclamation
                              Exit Sub
                           Else
                              .Fields(oControl.DataField).Value = Val(oControl.Text)
                           End If
                        Else
                           If Len(oControl.Text) > 0 Then .Fields(oControl.DataField).Value = oControl.Text
                        End If
                     End If
                  End If
               ElseIf TypeOf oControl Is DataCombo Then
                  If mId(oControl.DataField, 1, 1) = "_" Then
                     If oControl.Enabled And IsNumeric(oControl.BoundText) Then
                        GuardarValorParametro2 oControl.DataField, oControl.BoundText
                     Else
                        GuardarValorParametro2 oControl.DataField, ""
                     End If
                  End If
               End If
            Next
         
            For Each dc In DataCombo1
               If dc.Enabled Then
                  If IsNumeric(dc.BoundText) And mId(dc.DataField, 1, 1) <> "_" Then
                     .Fields(dc.DataField).Value = dc.BoundText
                  End If
               End If
            Next
         
            For Each dc In dcfields
               If dc.Enabled Then
                  If IsNumeric(dc.BoundText) And mId(dc.DataField, 1, 1) <> "_" Then
                     .Fields(dc.DataField).Value = dc.BoundText
                  End If
               End If
            Next
            
            For i = 1 To 5
               If Check11(i - 1).Value = 1 Then
                  If IsNumeric(dcfields1(i - 1).BoundText) Then
                     .Fields("IdCuentaAdicionalIVACompras" & i).Value = dcfields1(i - 1).BoundText
                  Else
                     .Fields("IdCuentaAdicionalIVACompras" & i).Value = Null
                  End If
               Else
                  .Fields("IdCuentaAdicionalIVACompras" & i).Value = Null
               End If
            Next
            If Check13.Value = 1 Then
               .Fields("IvaCompras_DesglosarNOGRAVADOS").Value = "SI"
            Else
               .Fields("IvaCompras_DesglosarNOGRAVADOS").Value = "NO"
            End If
            If Check17.Value = 1 Then
               If Len(DataCombo1(3).Text) = 0 Then
                  MsgBox "No definio la base de datos PRONTO SyJ asociada", vbExclamation
                  Exit Sub
               End If
               .Fields("BasePRONTOSyJAsociada").Value = DataCombo1(3).Text
               glbBasePRONTOSyJAsociada = DataCombo1(3).Text
            Else
               .Fields("BasePRONTOSyJAsociada").Value = Null
               glbBasePRONTOSyJAsociada = ""
            End If
            If Check18.Value = 1 Then
               If Len(DataCombo1(16).Text) = 0 Then
                  MsgBox "No definio la base de datos de consolidacion", vbExclamation
                  Exit Sub
               End If
               .Fields("BasePRONTOConsolidacion").Value = DataCombo1(16).Text
            Else
               .Fields("BasePRONTOConsolidacion").Value = Null
            End If
            If Check19.Value = 1 Then
               If Len(DataCombo1(17).Text) = 0 Then
                  MsgBox "No definio la base de datos de consolidacion", vbExclamation
                  Exit Sub
               End If
               .Fields("BasePRONTOConsolidacion2").Value = DataCombo1(17).Text
            Else
               .Fields("BasePRONTOConsolidacion2").Value = Null
            End If
            If Check20.Value = 1 Then
               If Len(DataCombo1(18).Text) = 0 Then
                  MsgBox "No definio la base de datos de consolidacion", vbExclamation
                  Exit Sub
               End If
               .Fields("BasePRONTOConsolidacion3").Value = DataCombo1(18).Text
            Else
               .Fields("BasePRONTOConsolidacion3").Value = Null
            End If
            If Check22.Value = 1 Then
               If Len(DataCombo1(22).Text) = 0 Then
                  MsgBox "No definio la base de datos de mantenimiento", vbExclamation
                  Exit Sub
               End If
               .Fields("BasePRONTOMantenimiento").Value = DataCombo1(22).Text
            Else
               .Fields("BasePRONTOMantenimiento").Value = Null
            End If
            If Check23.Value = 1 Then
               GuardarValorParametro2 "GenerarSalidaDesdeRecepcionSAT", "SI"
            Else
               GuardarValorParametro2 "GenerarSalidaDesdeRecepcionSAT", "NO"
            End If
            If Check31.Value = 1 Then
               GuardarValorParametro2 "FacturarConsumosAObra", "SI"
            Else
               GuardarValorParametro2 "FacturarConsumosAObra", "NO"
            End If
            If Check1.Value = 1 Then
               GuardarValorParametro2 "ModulosWEB", "SI"
            Else
               GuardarValorParametro2 "ModulosWEB", "NO"
            End If
            
            For i = 1 To 5
               GuardarValorParametro2 "Pedidos_DescripcionOtrosConceptos" & i, text1(i - 1).Text
            Next
         
            .Fields("PedidosPlazoEntrega").Value = RichTextBox1.Text
            .Fields("PedidosLugarEntrega").Value = RichTextBox2.Text
            .Fields("PedidosFormaPago").Value = RichTextBox3.Text
            .Fields("PedidosDocumentacion").Value = RichTextBox4.Text
            .Fields("PedidosGarantia").Value = RichTextBox5.Text
            .Fields("PedidosInspecciones").Value = RichTextBox6.Text
            .Fields("PedidosImportante").Value = RichTextBox7.Text
         End With
   End Select
   
Salida:
   Set oRs = Nothing
   Me.Hide
'   Unload Me

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim i As Integer
   Dim mAux1 As Variant
   
   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set oBind = New BindingCollection
   
   Set oRs1 = oAp.Cuentas.TraerFiltrado("_PorFechaParaCombo")
   
   With oBind
      Set .DataSource = oParametros
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then
               If mId(oControl.DataField, 1, 1) <> "_" Then
                  Set oControl.DataSource = oParametros
               Else
                  mAux1 = TraerValorParametro2(oControl.DataField)
                  oControl.BoundText = IIf(IsNull(mAux1), 0, mAux1)
               End If
            End If
            If Len(oControl.Tag) Then
               If oControl.Tag = "BancosParaCobros" Then
                  Set oControl.RowSource = oAp.Bancos.TraerFiltrado("_HabilitadosParaCobroCuotas")
               ElseIf oControl.Tag = "CuentasConsolidacion" Then
                  Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_CuentasConsolidacionParaCombo", 1)
               ElseIf oControl.Tag = "ArticulosMantenimiento" Then
                  Set oControl.RowSource = oAp.Articulos.TraerFiltrado("_BD_ProntoMantenimiento")
               ElseIf oControl.Tag = "Bases" Then
                  Set oControl.RowSource = oAp.TablasGenerales.TraerFiltrado("BD", "_BasesInstaladas")
               ElseIf oControl.Tag = "ConceptosSyJ" Then
                  Set oControl.RowSource = oAp.AnticiposAlPersonalSyJ.TraerFiltrado("_Conceptos")
               ElseIf oControl.Tag = "TiposArticulos" Then
                  Set oControl.RowSource = oAp.Tipos.TraerFiltrado("_PorGrupoParaCombo", 1)
               ElseIf oControl.Tag = "Cuentas" Then
                  Set oControl.RowSource = oRs1
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            If mId(oControl.DataField, 1, 1) <> "_" Then
               Set oControl.DataSource = oParametros
            Else
               mAux1 = TraerValorParametro2(oControl.DataField)
               oControl.Text = IIf(IsNull(mAux1), 0, mAux1)
            End If
         End If
      Next
   End With
   
   With oParametros.Registro
      For i = 1 To 5
         If Not IsNull(.Fields("IdCuentaAdicionalIVACompras" & i).Value) Then
            Check11(i - 1).Value = 1
            dcfields1(i - 1).Enabled = True
         Else
            Check11(i - 1).Value = 0
            dcfields1(i - 1).Enabled = False
         End If
      Next
      If Not IsNull(.Fields("IvaCompras_DesglosarNOGRAVADOS").Value) And .Fields("IvaCompras_DesglosarNOGRAVADOS").Value = "SI" Then
         Check13.Value = 1
      Else
         Check13.Value = 0
      End If
      If Not IsNull(.Fields("BasePRONTOSyJAsociada").Value) Then
         Check17.Value = 1
         DataCombo1(3).Text = .Fields("BasePRONTOSyJAsociada").Value
      Else
         Check17.Value = 0
         DataCombo1(3).Enabled = False
      End If
      If Not IsNull(.Fields("BasePRONTOConsolidacion").Value) Then
         Check18.Value = 1
         DataCombo1(16).Text = .Fields("BasePRONTOConsolidacion").Value
      Else
         Check18.Value = 0
         DataCombo1(16).Enabled = False
      End If
      If Not IsNull(.Fields("BasePRONTOConsolidacion2").Value) Then
         Check19.Value = 1
         DataCombo1(17).Text = .Fields("BasePRONTOConsolidacion2").Value
      Else
         Check19.Value = 0
         DataCombo1(17).Enabled = False
      End If
      If Not IsNull(.Fields("BasePRONTOConsolidacion3").Value) Then
         Check20.Value = 1
         DataCombo1(18).Text = .Fields("BasePRONTOConsolidacion3").Value
      Else
         Check20.Value = 0
         DataCombo1(18).Enabled = False
      End If
      If Not IsNull(.Fields("BasePRONTOMantenimiento").Value) Then
         Check22.Value = 1
         DataCombo1(22).Text = .Fields("BasePRONTOMantenimiento").Value
      Else
         Check22.Value = 0
         DataCombo1(22).Enabled = False
      End If

      mAux1 = TraerValorParametro2("GenerarSalidaDesdeRecepcionSAT")
      If Not IsNull(mAux1) And mAux1 = "SI" Then
         Check23.Value = 1
      Else
         Check23.Value = 0
      End If
      If IsNumeric(DataCombo1(20).BoundText) Then
         Check24.Value = 1
      Else
         Check24.Value = 0
         DataCombo1(20).Enabled = False
      End If
      
      mAux1 = TraerValorParametro2("FacturarConsumosAObra")
      If Not IsNull(mAux1) And mAux1 = "SI" Then
         Check31.Value = 1
      Else
         Check31.Value = 0
      End If
   
      mAux1 = TraerValorParametro2("ModulosWEB")
      If Not IsNull(mAux1) And mAux1 = "SI" Then
         Check1.Value = 1
      Else
         Check1.Value = 0
         With txtPagina1
            .Enabled = False
            .Text = ""
         End With
      End If
      
      For i = 1 To 5
         text1(i - 1).Text = TraerValorParametro2("Pedidos_DescripcionOtrosConceptos" & i)
      Next
   
      For i = 1 To 5
         mAux1 = TraerValorParametro2("IdCuentaAdicionalIVAVentas" & i)
         If Not IsNull(mAux1) And IsNumeric(mAux1) Then
            Check11(i + 5 - 1).Value = 1
         Else
            Check11(i + 5 - 1).Value = 0
         End If
      Next
   
      RichTextBox1.TextRTF = IIf(IsNull(.Fields("PedidosPlazoEntrega").Value), "", .Fields("PedidosPlazoEntrega").Value)
      RichTextBox2.TextRTF = IIf(IsNull(.Fields("PedidosLugarEntrega").Value), "", .Fields("PedidosLugarEntrega").Value)
      RichTextBox3.TextRTF = IIf(IsNull(.Fields("PedidosFormaPago").Value), "", .Fields("PedidosFormaPago").Value)
      RichTextBox4.TextRTF = IIf(IsNull(.Fields("PedidosDocumentacion").Value), "", .Fields("PedidosDocumentacion").Value)
      RichTextBox5.TextRTF = IIf(IsNull(.Fields("PedidosGarantia").Value), "", .Fields("PedidosGarantia").Value)
      RichTextBox6.TextRTF = IIf(IsNull(.Fields("PedidosInspecciones").Value), "", .Fields("PedidosInspecciones").Value)
      RichTextBox7.TextRTF = IIf(IsNull(.Fields("PedidosImportante").Value), "", .Fields("PedidosImportante").Value)
   End With
   
   Set oRs1 = Nothing
   Set oRs = Nothing
   Set oAp = Nothing

End Property

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oParametros = Nothing
   Set oBind = Nothing

End Sub

Public Property Get Parametros() As ComPronto.Parametro

   Set Parametros = oParametros

End Property

Public Property Set Parametros(ByVal vNewValue As ComPronto.Parametro)

   Set oParametros = vNewValue

End Property
