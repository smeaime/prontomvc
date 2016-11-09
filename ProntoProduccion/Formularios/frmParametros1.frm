VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "msdatlst.ocx"
Begin VB.Form frmParametros1 
   Caption         =   "Parametros"
   ClientHeight    =   3765
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7650
   Icon            =   "frmParametros1.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3765
   ScaleWidth      =   7650
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox ListaCausasDeParo 
      Alignment       =   1  'Right Justify
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   555
      Left            =   3720
      TabIndex        =   480
      Top             =   1920
      Width           =   3645
   End
   Begin VB.Frame Frame27 
      Caption         =   "Directorios : "
      Height          =   780
      Left            =   120
      TabIndex        =   475
      Top             =   1080
      Width           =   7305
      Begin VB.TextBox txtPathPlantillas 
         DataField       =   "PathPlantillas"
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
         Left            =   3600
         TabIndex        =   476
         Top             =   240
         Width           =   3540
      End
      Begin VB.Label Label97 
         Caption         =   "Dir. p/plantillas (sin \ final) :"
         Height          =   240
         Left            =   120
         TabIndex        =   477
         Top             =   360
         Width           =   3120
      End
   End
   Begin VB.TextBox Text3 
      Alignment       =   1  'Right Justify
      DataField       =   "ProximaNotaCreditoInterna"
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
      Left            =   3720
      TabIndex        =   473
      Top             =   240
      Width           =   1605
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Mas parametros"
      Height          =   315
      Index           =   2
      Left            =   9630
      TabIndex        =   447
      Top             =   8010
      Visible         =   0   'False
      Width           =   1530
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   435
      Index           =   1
      Left            =   6240
      TabIndex        =   2
      Top             =   3120
      Width           =   1170
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   435
      Index           =   0
      Left            =   4920
      TabIndex        =   1
      Top             =   3120
      Width           =   1170
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   7935
      Left            =   10320
      TabIndex        =   0
      Top             =   3720
      Visible         =   0   'False
      Width           =   11085
      _ExtentX        =   19553
      _ExtentY        =   13996
      _Version        =   393216
      Tabs            =   8
      TabsPerRow      =   8
      TabHeight       =   970
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Numeradores"
      TabPicture(0)   =   "frmParametros1.frx":076A
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Label24"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Label20"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "Label19"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "Label18"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "Label16"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).Control(5)=   "Label15"
      Tab(0).Control(5).Enabled=   0   'False
      Tab(0).Control(6)=   "Label13"
      Tab(0).Control(6).Enabled=   0   'False
      Tab(0).Control(7)=   "Label12"
      Tab(0).Control(7).Enabled=   0   'False
      Tab(0).Control(8)=   "Label11"
      Tab(0).Control(8).Enabled=   0   'False
      Tab(0).Control(9)=   "Label10"
      Tab(0).Control(9).Enabled=   0   'False
      Tab(0).Control(10)=   "Label9"
      Tab(0).Control(10).Enabled=   0   'False
      Tab(0).Control(11)=   "Label25"
      Tab(0).Control(11).Enabled=   0   'False
      Tab(0).Control(12)=   "Label44"
      Tab(0).Control(12).Enabled=   0   'False
      Tab(0).Control(13)=   "Label46"
      Tab(0).Control(13).Enabled=   0   'False
      Tab(0).Control(14)=   "Label26"
      Tab(0).Control(14).Enabled=   0   'False
      Tab(0).Control(15)=   "Label43"
      Tab(0).Control(15).Enabled=   0   'False
      Tab(0).Control(16)=   "Label50"
      Tab(0).Control(16).Enabled=   0   'False
      Tab(0).Control(17)=   "Label51"
      Tab(0).Control(17).Enabled=   0   'False
      Tab(0).Control(18)=   "Label77"
      Tab(0).Control(18).Enabled=   0   'False
      Tab(0).Control(19)=   "Label78"
      Tab(0).Control(19).Enabled=   0   'False
      Tab(0).Control(20)=   "Label82"
      Tab(0).Control(20).Enabled=   0   'False
      Tab(0).Control(21)=   "Label92"
      Tab(0).Control(21).Enabled=   0   'False
      Tab(0).Control(22)=   "Label32"
      Tab(0).Control(22).Enabled=   0   'False
      Tab(0).Control(23)=   "Label96"
      Tab(0).Control(23).Enabled=   0   'False
      Tab(0).Control(24)=   "Label99"
      Tab(0).Control(24).Enabled=   0   'False
      Tab(0).Control(25)=   "Label52"
      Tab(0).Control(25).Enabled=   0   'False
      Tab(0).Control(26)=   "Label49"
      Tab(0).Control(26).Enabled=   0   'False
      Tab(0).Control(27)=   "Label36"
      Tab(0).Control(27).Enabled=   0   'False
      Tab(0).Control(28)=   "Label40"
      Tab(0).Control(28).Enabled=   0   'False
      Tab(0).Control(29)=   "DataCombo1(4)"
      Tab(0).Control(29).Enabled=   0   'False
      Tab(0).Control(30)=   "txtProximoNumeroAjusteStock"
      Tab(0).Control(30).Enabled=   0   'False
      Tab(0).Control(31)=   "txtProximoNumeroSalidaMaterialesParaFacturar"
      Tab(0).Control(31).Enabled=   0   'False
      Tab(0).Control(32)=   "txtProximoNumeroSalidaMaterialesAObra"
      Tab(0).Control(32).Enabled=   0   'False
      Tab(0).Control(33)=   "txtProximoNumeroSalidaMateriales"
      Tab(0).Control(33).Enabled=   0   'False
      Tab(0).Control(34)=   "txtProximoNumeroSalidaMaterialesParaFacturar2"
      Tab(0).Control(34).Enabled=   0   'False
      Tab(0).Control(35)=   "txtProximoNumeroSalidaMaterialesAObra2"
      Tab(0).Control(35).Enabled=   0   'False
      Tab(0).Control(36)=   "txtProximoNumeroSalidaMateriales2"
      Tab(0).Control(36).Enabled=   0   'False
      Tab(0).Control(37)=   "txtIva1"
      Tab(0).Control(37).Enabled=   0   'False
      Tab(0).Control(38)=   "txtProximoNumeroValeSalida"
      Tab(0).Control(38).Enabled=   0   'False
      Tab(0).Control(39)=   "txtProximoNumeroPedido"
      Tab(0).Control(39).Enabled=   0   'False
      Tab(0).Control(40)=   "txtProximaComparativa"
      Tab(0).Control(40).Enabled=   0   'False
      Tab(0).Control(41)=   "txtProximoPresupuesto"
      Tab(0).Control(41).Enabled=   0   'False
      Tab(0).Control(42)=   "txtProximoNumeroRequerimiento"
      Tab(0).Control(42).Enabled=   0   'False
      Tab(0).Control(43)=   "txtProximaListaMateriales"
      Tab(0).Control(43).Enabled=   0   'False
      Tab(0).Control(44)=   "txtProximoAsiento"
      Tab(0).Control(44).Enabled=   0   'False
      Tab(0).Control(45)=   "txtProximoNumeroInternoChequeEmitido"
      Tab(0).Control(45).Enabled=   0   'False
      Tab(0).Control(46)=   "txtProximoNumeroInterno"
      Tab(0).Control(46).Enabled=   0   'False
      Tab(0).Control(47)=   "Text1"
      Tab(0).Control(47).Enabled=   0   'False
      Tab(0).Control(48)=   "Text2"
      Tab(0).Control(48).Enabled=   0   'False
      Tab(0).Control(49)=   "txtProximoNumeroOrdenCompra"
      Tab(0).Control(49).Enabled=   0   'False
      Tab(0).Control(50)=   "txtProximoNumeroRemito"
      Tab(0).Control(50).Enabled=   0   'False
      Tab(0).Control(51)=   "txtProximaNotaDebitoInterna"
      Tab(0).Control(51).Enabled=   0   'False
      Tab(0).Control(52)=   "txtProximaNotaCreditoInterna"
      Tab(0).Control(52).Enabled=   0   'False
      Tab(0).Control(53)=   "txtProximoNumeroOtroIngresoAlmacen"
      Tab(0).Control(53).Enabled=   0   'False
      Tab(0).Control(54)=   "txtProximoNumeroPedidoExterior"
      Tab(0).Control(54).Enabled=   0   'False
      Tab(0).Control(55)=   "txtProximoNumeroInternoRecepcion"
      Tab(0).Control(55).Enabled=   0   'False
      Tab(0).Control(56)=   "txtProximoNumeroGastoBancario"
      Tab(0).Control(56).Enabled=   0   'False
      Tab(0).Control(57)=   "txtProximoCodigoArticulo"
      Tab(0).Control(57).Enabled=   0   'False
      Tab(0).Control(58)=   "txtProximoNumeroOrdenTrabajo"
      Tab(0).Control(58).Enabled=   0   'False
      Tab(0).Control(59)=   "Frame40"
      Tab(0).Control(59).Enabled=   0   'False
      Tab(0).Control(60)=   "Frame41"
      Tab(0).Control(60).Enabled=   0   'False
      Tab(0).Control(61)=   "txtProximoNumeroCertificadoRetencionGanancias"
      Tab(0).Control(61).Enabled=   0   'False
      Tab(0).Control(62)=   "txtDecimales"
      Tab(0).Control(62).Enabled=   0   'False
      Tab(0).ControlCount=   63
      TabCaption(1)   =   "Textos fijos (Pedidos)"
      TabPicture(1)   =   "frmParametros1.frx":0786
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "RichTextBox7"
      Tab(1).Control(1)=   "RichTextBox6"
      Tab(1).Control(2)=   "RichTextBox5"
      Tab(1).Control(3)=   "RichTextBox4"
      Tab(1).Control(4)=   "RichTextBox3"
      Tab(1).Control(5)=   "RichTextBox2"
      Tab(1).Control(6)=   "RichTextBox1"
      Tab(1).Control(7)=   "Label1"
      Tab(1).Control(8)=   "Label2"
      Tab(1).Control(9)=   "Label3"
      Tab(1).Control(10)=   "Label4"
      Tab(1).Control(11)=   "Label5"
      Tab(1).Control(12)=   "Label6"
      Tab(1).Control(13)=   "Label7"
      Tab(1).ControlCount=   14
      TabCaption(2)   =   "Cuentas contables"
      TabPicture(2)   =   "frmParametros1.frx":07A2
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "Frame1"
      Tab(2).Control(1)=   "Frame3"
      Tab(2).Control(2)=   "Frame5"
      Tab(2).Control(3)=   "Frame6"
      Tab(2).Control(4)=   "Frame24"
      Tab(2).Control(5)=   "Frame25"
      Tab(2).Control(6)=   "Frame33"
      Tab(2).Control(7)=   "Frame35"
      Tab(2).ControlCount=   8
      TabCaption(3)   =   "Plantillas de ventas"
      TabPicture(3)   =   "frmParametros1.frx":07BE
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "Frame18"
      Tab(3).ControlCount=   1
      TabCaption(4)   =   "Retenciones y percepciones"
      TabPicture(4)   =   "frmParametros1.frx":07DA
      Tab(4).ControlEnabled=   0   'False
      Tab(4).Control(0)=   "Frame8"
      Tab(4).Control(1)=   "Frame9"
      Tab(4).Control(2)=   "Frame12"
      Tab(4).Control(3)=   "Frame7"
      Tab(4).Control(4)=   "Frame16"
      Tab(4).Control(5)=   "Frame28"
      Tab(4).Control(6)=   "Frame31"
      Tab(4).ControlCount=   7
      TabCaption(5)   =   "Tipos de comprobante"
      TabPicture(5)   =   "frmParametros1.frx":07F6
      Tab(5).ControlEnabled=   0   'False
      Tab(5).Control(0)=   "Frame4"
      Tab(5).Control(1)=   "Frame11"
      Tab(5).Control(2)=   "Frame10"
      Tab(5).Control(3)=   "Frame19"
      Tab(5).Control(4)=   "Frame21"
      Tab(5).Control(5)=   "Frame29"
      Tab(5).Control(6)=   "Frame20"
      Tab(5).Control(7)=   "Frame15"
      Tab(5).Control(8)=   "Frame37"
      Tab(5).Control(9)=   "Frame43"
      Tab(5).ControlCount=   10
      TabCaption(6)   =   "Datos Generales 1"
      TabPicture(6)   =   "frmParametros1.frx":0812
      Tab(6).ControlEnabled=   0   'False
      Tab(6).Control(0)=   "Label34"
      Tab(6).Control(1)=   "Label80"
      Tab(6).Control(2)=   "Label37"
      Tab(6).Control(3)=   "Label100"
      Tab(6).Control(4)=   "DTFields(3)"
      Tab(6).Control(5)=   "DTFields(2)"
      Tab(6).Control(6)=   "Frame22"
      Tab(6).Control(7)=   "DTFields(1)"
      Tab(6).Control(8)=   "DTFields(0)"
      Tab(6).Control(9)=   "Frame14"
      Tab(6).Control(10)=   "Frame13"
      Tab(6).Control(11)=   "Frame23"
      Tab(6).Control(12)=   "Frame26"
      Tab(6).Control(13)=   "Frame2"
      Tab(6).Control(14)=   "Frame32"
      Tab(6).Control(15)=   "Frame30"
      Tab(6).Control(16)=   "Frame42"
      Tab(6).Control(17)=   "Frame44"
      Tab(6).Control(18)=   "Frame45"
      Tab(6).Control(19)=   "Frame46"
      Tab(6).ControlCount=   20
      TabCaption(7)   =   "Datos Generales 2"
      TabPicture(7)   =   "frmParametros1.frx":082E
      Tab(7).ControlEnabled=   0   'False
      Tab(7).Control(0)=   "Frame34"
      Tab(7).Control(1)=   "Frame36"
      Tab(7).Control(2)=   "Frame38"
      Tab(7).Control(3)=   "Frame39"
      Tab(7).ControlCount=   4
      Begin VB.TextBox txtDecimales 
         Alignment       =   2  'Center
         DataField       =   "Decimales"
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
         Left            =   9585
         TabIndex        =   471
         Top             =   5445
         Width           =   420
      End
      Begin VB.Frame Frame39 
         Caption         =   "Idioma : "
         Height          =   645
         Left            =   -68340
         TabIndex        =   468
         Top             =   2340
         Width           =   4290
         Begin VB.ComboBox Combo1 
            Height          =   315
            Index           =   0
            ItemData        =   "frmParametros1.frx":084A
            Left            =   1305
            List            =   "frmParametros1.frx":0857
            TabIndex        =   470
            Top             =   225
            Width           =   2850
         End
         Begin VB.Label Label39 
            Caption         =   "Idioma actual :"
            Height          =   195
            Left            =   135
            TabIndex        =   469
            Top             =   270
            Width           =   1770
         End
      End
      Begin VB.Frame Frame38 
         Caption         =   "Depositos :"
         Height          =   645
         Left            =   -68340
         TabIndex        =   461
         Top             =   1620
         Width           =   4290
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "_IdDepositoCentral"
            Height          =   315
            Index           =   3
            Left            =   2025
            TabIndex        =   462
            Tag             =   "Depositos"
            Top             =   225
            Width           =   2175
            _ExtentX        =   3836
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdDeposito"
            Text            =   ""
         End
         Begin VB.Label Label35 
            Caption         =   "Deposito central "
            Height          =   195
            Left            =   135
            TabIndex        =   463
            Top             =   270
            Width           =   1770
         End
      End
      Begin VB.Frame Frame36 
         Height          =   4155
         Left            =   -74865
         TabIndex        =   451
         Top             =   630
         Width           =   6405
         Begin VB.CheckBox Check18 
            Alignment       =   1  'Right Justify
            Caption         =   $"frmParametros1.frx":0877
            Height          =   375
            Left            =   315
            TabIndex        =   467
            Top             =   3510
            Width           =   5865
         End
         Begin VB.CheckBox Check17 
            Alignment       =   1  'Right Justify
            Caption         =   "Desactivar el control para dar por cumplido los pedidos sin recepcion al arrastrarlo a un comprobante de proveedor"
            Height          =   375
            Left            =   315
            TabIndex        =   466
            Top             =   3015
            Width           =   5865
         End
         Begin VB.CheckBox Check14 
            Alignment       =   1  'Right Justify
            Caption         =   "Resumir cuentas en la generacion de subdiarios (Ctes.proveedores) :"
            Height          =   195
            Left            =   315
            TabIndex        =   460
            Top             =   525
            Width           =   5865
         End
         Begin VB.CheckBox Check6 
            Alignment       =   1  'Right Justify
            Caption         =   "Pedir confirmacion p/impresion de clausula dolar en comprobantes de venta :"
            Height          =   195
            Left            =   315
            TabIndex        =   459
            Top             =   270
            Width           =   5865
         End
         Begin VB.CheckBox Check26 
            Alignment       =   1  'Right Justify
            Caption         =   "Solo ver usuario conectado en el arbol autorizacion de documentos :"
            Height          =   195
            Left            =   315
            TabIndex        =   458
            Top             =   1815
            Width           =   5865
         End
         Begin VB.CheckBox Check21 
            Alignment       =   1  'Right Justify
            Caption         =   "Activar circuito stock desde solicitud de materiales :"
            Height          =   195
            Left            =   315
            TabIndex        =   457
            Top             =   1560
            Width           =   5865
         End
         Begin VB.CheckBox Check16 
            Alignment       =   1  'Right Justify
            Caption         =   "Activar circuito contable para cheques de pago diferido :"
            Height          =   195
            Left            =   315
            TabIndex        =   456
            Top             =   1305
            Width           =   5865
         End
         Begin VB.CheckBox Check12 
            Alignment       =   1  'Right Justify
            Caption         =   "Emitir asiento contable en emision de ordenes de pago :"
            Height          =   195
            Left            =   315
            TabIndex        =   455
            Top             =   1050
            Width           =   5865
         End
         Begin VB.CheckBox Check7 
            Alignment       =   1  'Right Justify
            Caption         =   "Exigir trasabilidad con RM o LA en las notas de pedido :"
            Height          =   195
            Left            =   315
            TabIndex        =   454
            Top             =   780
            Width           =   5865
         End
         Begin VB.CheckBox Check10 
            Alignment       =   1  'Right Justify
            Caption         =   "Controlar y avisar la falta de carga de rubros contables en RE y OP :"
            Height          =   195
            Left            =   315
            TabIndex        =   453
            Top             =   2355
            Width           =   5865
         End
         Begin VB.CheckBox Check29 
            Alignment       =   1  'Right Justify
            Caption         =   "Controlar y avisar la falta de carga de rubros contables en CP :"
            Height          =   195
            Left            =   315
            TabIndex        =   452
            Top             =   2625
            Width           =   5865
         End
      End
      Begin VB.Frame Frame34 
         Caption         =   "Sectores :"
         Height          =   915
         Left            =   -68340
         TabIndex        =   448
         Top             =   630
         Width           =   4290
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "_IdSectorReasignador"
            Height          =   315
            Index           =   2
            Left            =   2025
            TabIndex        =   449
            Tag             =   "Sectores"
            Top             =   495
            Width           =   2175
            _ExtentX        =   3836
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdSector"
            Text            =   ""
         End
         Begin VB.Label Label23 
            Caption         =   "Sector correspondiente a usuarios que pueden asignar RM's :"
            Height          =   600
            Left            =   135
            TabIndex        =   450
            Top             =   225
            Width           =   1770
         End
      End
      Begin VB.Frame Frame46 
         Caption         =   "Compras : Anticipos y devolucion de anticipos : "
         Height          =   1050
         Left            =   -69015
         TabIndex        =   442
         Top             =   2235
         Width           =   4965
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "_IdCuentaAnticipoAProveedores"
            Height          =   315
            Index           =   59
            Left            =   1890
            TabIndex        =   443
            Tag             =   "Cuentas"
            Top             =   270
            Width           =   2985
            _ExtentX        =   5265
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "_IdCuentaDevolucionAnticipoAProveedores"
            Height          =   315
            Index           =   60
            Left            =   1890
            TabIndex        =   444
            Tag             =   "Cuentas"
            Top             =   630
            Width           =   2985
            _ExtentX        =   5265
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label Label47 
            Caption         =   "Cta.dev.anticipo a prov. :"
            Height          =   240
            Left            =   90
            TabIndex        =   446
            Top             =   630
            Width           =   1770
         End
         Begin VB.Label Label17 
            Caption         =   "Cuenta anticipo a prov. :"
            Height          =   240
            Left            =   90
            TabIndex        =   445
            Top             =   315
            Width           =   1770
         End
      End
      Begin VB.TextBox txtProximoNumeroCertificadoRetencionGanancias 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroCertificadoRetencionGanancias"
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
         Left            =   9585
         TabIndex        =   438
         Top             =   705
         Width           =   1365
      End
      Begin VB.Frame Frame45 
         Height          =   600
         Left            =   -74910
         TabIndex        =   433
         Top             =   660
         Width           =   5865
         Begin VB.CheckBox Check28 
            Height          =   195
            Left            =   2700
            TabIndex        =   434
            Top             =   225
            Width           =   195
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "_IdObraParaOTOP"
            Height          =   315
            Index           =   28
            Left            =   2970
            TabIndex        =   435
            Tag             =   "Obras"
            Top             =   180
            Width           =   2835
            _ExtentX        =   5001
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdObra"
            Text            =   ""
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Obra para informe de OT's / OP's :"
            Height          =   285
            Index           =   10
            Left            =   0
            TabIndex        =   436
            Top             =   225
            Width           =   2520
         End
      End
      Begin VB.Frame Frame44 
         Caption         =   "Autorizacion de comprobantes : "
         Height          =   420
         Left            =   -74910
         TabIndex        =   429
         Top             =   4395
         Width           =   5865
         Begin VB.OptionButton Option3 
            Alignment       =   1  'Right Justify
            Caption         =   "Tomar sector de la RM :"
            Height          =   150
            Index           =   1
            Left            =   3780
            TabIndex        =   431
            Top             =   225
            Width           =   2040
         End
         Begin VB.OptionButton Option3 
            Alignment       =   1  'Right Justify
            Caption         =   "Tomar sector emisor en pedidos del que libera :"
            Height          =   150
            Index           =   0
            Left            =   90
            TabIndex        =   430
            Top             =   225
            Width           =   3660
         End
      End
      Begin VB.Frame Frame43 
         Caption         =   "Requerimientos :"
         Height          =   1185
         Left            =   -69735
         TabIndex        =   423
         Top             =   6645
         Width           =   5685
         Begin VB.CheckBox Check27 
            Alignment       =   1  'Right Justify
            Caption         =   "Asignar liberador como comprador :"
            Height          =   195
            Left            =   90
            TabIndex        =   432
            Top             =   855
            Width           =   2850
         End
         Begin VB.OptionButton Option5 
            Alignment       =   1  'Right Justify
            Caption         =   "Completa el circuito de firmas"
            Height          =   195
            Left            =   2385
            TabIndex        =   426
            Top             =   495
            Width           =   2355
         End
         Begin VB.OptionButton Option4 
            Alignment       =   1  'Right Justify
            Caption         =   "Se libera la RM"
            Height          =   150
            Left            =   2385
            TabIndex        =   425
            Top             =   270
            Width           =   1500
         End
         Begin VB.Line Line3 
            X1              =   0
            X2              =   5670
            Y1              =   765
            Y2              =   765
         End
         Begin VB.Label Label54 
            Caption         =   "Liberar para compras cuando :"
            Height          =   195
            Left            =   135
            TabIndex        =   424
            Top             =   270
            Width           =   2220
         End
      End
      Begin VB.Frame Frame42 
         Caption         =   "Ventas : Anticipo y devolucion de anticipos : "
         Height          =   915
         Left            =   -74910
         TabIndex        =   418
         Top             =   4800
         Width           =   5865
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "_IdRubroAnticipos"
            Height          =   315
            Index           =   21
            Left            =   2655
            TabIndex        =   419
            Tag             =   "Rubros"
            Top             =   225
            Width           =   3120
            _ExtentX        =   5503
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdRubro"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "_IdRubroDevolucionAnticipos"
            Height          =   315
            Index           =   23
            Left            =   2655
            TabIndex        =   421
            Tag             =   "Rubros"
            Top             =   540
            Width           =   3120
            _ExtentX        =   5503
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdRubro"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Rubro de devolucion de anticipos :"
            Height          =   240
            Index           =   110
            Left            =   90
            TabIndex        =   422
            Top             =   585
            Width           =   2490
         End
         Begin VB.Label lblLabels 
            Caption         =   "Rubro de anticipos :"
            Height          =   240
            Index           =   109
            Left            =   90
            TabIndex        =   420
            Top             =   270
            Width           =   2490
         End
      End
      Begin VB.Frame Frame41 
         Caption         =   "Ordenes de pago : "
         Height          =   2130
         Left            =   135
         TabIndex        =   410
         Top             =   5430
         Width           =   3885
         Begin VB.TextBox txtProximaOrdenPagoFF 
            Alignment       =   1  'Right Justify
            DataField       =   "ProximaOrdenPagoFF"
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
            Left            =   2385
            TabIndex        =   440
            Top             =   1215
            Width           =   1365
         End
         Begin VB.CheckBox Check30 
            Alignment       =   1  'Right Justify
            Caption         =   "Numeracion independiente OP de FF y Cta.Cte."
            Height          =   195
            Left            =   90
            TabIndex        =   437
            Top             =   1845
            Width           =   3660
         End
         Begin VB.CheckBox Check25 
            Alignment       =   1  'Right Justify
            Caption         =   "Numeracion automatica de ordenes de pago :"
            Height          =   195
            Left            =   90
            TabIndex        =   417
            Top             =   1575
            Width           =   3660
         End
         Begin VB.TextBox txtProximaOrdenPago 
            Alignment       =   1  'Right Justify
            DataField       =   "ProximaOrdenPago"
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
            Left            =   2385
            TabIndex        =   413
            Top             =   225
            Width           =   1365
         End
         Begin VB.TextBox txtProximaOrdenPagoExterior 
            Alignment       =   1  'Right Justify
            DataField       =   "ProximaOrdenPagoExterior"
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
            Left            =   2385
            TabIndex        =   412
            Top             =   555
            Width           =   1365
         End
         Begin VB.TextBox txtProximaOrdenPagoOtros 
            Alignment       =   1  'Right Justify
            DataField       =   "ProximaOrdenPagoOtros"
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
            Left            =   2385
            TabIndex        =   411
            Top             =   870
            Width           =   1365
         End
         Begin VB.Label Label14 
            Caption         =   "Proxima orden pago (FF) :"
            Height          =   240
            Left            =   90
            TabIndex        =   441
            Top             =   1260
            Width           =   2265
         End
         Begin VB.Label Label45 
            Caption         =   "Proxima orden pago (LOCAL) :"
            Height          =   240
            Left            =   90
            TabIndex        =   416
            Top             =   270
            Width           =   2265
         End
         Begin VB.Label Label48 
            Caption         =   "Proxima orden pago (EXTER) :"
            Height          =   240
            Left            =   90
            TabIndex        =   415
            Top             =   600
            Width           =   2220
         End
         Begin VB.Label Label76 
            Caption         =   "Proxima orden pago (OTROS) :"
            Height          =   240
            Left            =   90
            TabIndex        =   414
            Top             =   930
            Width           =   2265
         End
      End
      Begin VB.Frame Frame40 
         Caption         =   "Recibos : "
         Height          =   510
         Left            =   135
         TabIndex        =   408
         Top             =   4845
         Width           =   3885
         Begin VB.CheckBox Check5 
            Alignment       =   1  'Right Justify
            Caption         =   "Numeracion automatica de recibos de pago :"
            Height          =   195
            Left            =   90
            TabIndex        =   409
            Top             =   225
            Width           =   3660
         End
      End
      Begin VB.TextBox txtProximoNumeroOrdenTrabajo 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroOrdenTrabajo"
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
         Left            =   9585
         TabIndex        =   406
         Top             =   4170
         Width           =   1365
      End
      Begin VB.Frame Frame37 
         Caption         =   "Recupero de gastos : "
         Height          =   555
         Left            =   -69735
         TabIndex        =   396
         Top             =   6060
         Width           =   5685
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdConceptoRecuperoGastos"
            Height          =   315
            Index           =   5
            Left            =   2025
            TabIndex        =   397
            Tag             =   "Conceptos"
            Top             =   180
            Width           =   3570
            _ExtentX        =   6297
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdConcepto"
            Text            =   ""
         End
         Begin VB.Label Label27 
            Caption         =   "Concepto para NC y ND :"
            Height          =   240
            Left            =   135
            TabIndex        =   398
            Top             =   225
            Width           =   1860
         End
      End
      Begin VB.Frame Frame35 
         Caption         =   "Cuentas para ajuste por inflacion :"
         Height          =   870
         Left            =   -74865
         TabIndex        =   391
         Top             =   6375
         Width           =   5280
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaREI_Perdida"
            Height          =   315
            Index           =   54
            Left            =   1440
            TabIndex        =   392
            Tag             =   "Cuentas"
            Top             =   540
            Width           =   3750
            _ExtentX        =   6615
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaREI_Ganancia"
            Height          =   315
            Index           =   55
            Left            =   1440
            TabIndex        =   393
            Tag             =   "Cuentas"
            Top             =   180
            Width           =   3750
            _ExtentX        =   6615
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "REI (Perdidas) :"
            Height          =   240
            Index           =   105
            Left            =   90
            TabIndex        =   395
            Top             =   540
            Width           =   1230
         End
         Begin VB.Label lblLabels 
            Caption         =   "REI (Ganancias) :"
            Height          =   285
            Index           =   104
            Left            =   90
            TabIndex        =   394
            Top             =   270
            Width           =   1320
         End
      End
      Begin VB.Frame Frame30 
         Caption         =   "Emision de diario contable : "
         Height          =   825
         Left            =   -69015
         TabIndex        =   386
         Top             =   3315
         Width           =   4965
         Begin VB.TextBox txtLineasDiarioResumido 
            Alignment       =   1  'Right Justify
            DataField       =   "LineasDiarioResumido"
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
            Left            =   4455
            TabIndex        =   388
            Top             =   495
            Width           =   420
         End
         Begin VB.TextBox txtLineasDiarioDetallado 
            Alignment       =   1  'Right Justify
            DataField       =   "LineasDiarioDetallado"
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
            Left            =   4455
            TabIndex        =   387
            Top             =   180
            Width           =   420
         End
         Begin VB.Label Label38 
            Caption         =   "Cantidad de lineas por pagina para diario resumido (Excel) :"
            Height          =   240
            Index           =   1
            Left            =   90
            TabIndex        =   390
            Top             =   540
            Width           =   4515
         End
         Begin VB.Label Label38 
            Caption         =   "Cant lineas por pagina p/diario detallado e I.C. (Excel) :"
            Height          =   240
            Index           =   0
            Left            =   90
            TabIndex        =   389
            Top             =   225
            Width           =   3930
         End
      End
      Begin VB.Frame Frame15 
         Caption         =   "Controles de calidad : "
         Height          =   735
         Left            =   -74820
         TabIndex        =   375
         Top             =   7095
         Width           =   4920
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdControlCalidadStandar"
            Height          =   315
            Index           =   29
            Left            =   2070
            TabIndex        =   376
            Tag             =   "ControlesCalidad"
            Top             =   270
            Width           =   2715
            _ExtentX        =   4789
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdControlCalidad"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Control de calidad standar : "
            Height          =   240
            Index           =   60
            Left            =   135
            TabIndex        =   377
            Top             =   360
            Width           =   1950
         End
      End
      Begin VB.TextBox txtProximoCodigoArticulo 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoCodigoArticulo"
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
         Left            =   9585
         TabIndex        =   368
         Top             =   5115
         Width           =   1365
      End
      Begin VB.Frame Frame33 
         Caption         =   "Reintegros : "
         Height          =   600
         Left            =   -74865
         TabIndex        =   365
         Top             =   7230
         Width           =   5280
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaReintegros"
            Height          =   315
            Index           =   51
            Left            =   945
            TabIndex        =   366
            Tag             =   "Cuentas"
            Top             =   225
            Width           =   4245
            _ExtentX        =   7488
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta :"
            Height          =   285
            Index           =   99
            Left            =   90
            TabIndex        =   367
            Top             =   270
            Width           =   690
         End
      End
      Begin VB.TextBox txtProximoNumeroGastoBancario 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroGastoBancario"
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
         Left            =   9585
         TabIndex        =   363
         Top             =   3855
         Width           =   1365
      End
      Begin VB.Frame Frame32 
         Caption         =   "Caja : "
         Height          =   510
         Left            =   -67980
         TabIndex        =   360
         Top             =   7275
         Width           =   3930
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCajaEnPesosDefault"
            Height          =   315
            Index           =   49
            Left            =   1305
            TabIndex        =   361
            Tag             =   "Cajas"
            Top             =   135
            Width           =   2535
            _ExtentX        =   4471
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCaja"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Caja pesos (std) :"
            Height          =   240
            Index           =   98
            Left            =   90
            TabIndex        =   362
            Top             =   180
            Width           =   1185
         End
      End
      Begin VB.Frame Frame31 
         Caption         =   "Datos generales para calculo de retencion impuesto ganancias (comprobantes M) : "
         Height          =   780
         Left            =   -74820
         TabIndex        =   350
         Top             =   3855
         Width           =   6315
         Begin VB.TextBox txtImporteComprobantesMParaRetencionGanancias 
            Alignment       =   1  'Right Justify
            DataField       =   "ImporteComprobantesMParaRetencionGanancias"
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
            Left            =   5040
            TabIndex        =   352
            Top             =   180
            Width           =   1140
         End
         Begin VB.TextBox txtPorcentajeRetencionGananciasComprobantesM 
            Alignment       =   1  'Right Justify
            DataField       =   "PorcentajeRetencionGananciasComprobantesM"
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
            Left            =   5400
            TabIndex        =   351
            Top             =   450
            Width           =   780
         End
         Begin VB.Label Label95 
            Caption         =   "Facturas M : Importe neto minimo para aplicar retencion ganancias :"
            Height          =   240
            Left            =   90
            TabIndex        =   354
            Top             =   225
            Width           =   4875
         End
         Begin VB.Label Label88 
            Caption         =   "Facturas M : Porcentaje de retencion a aplicar sobre neto gravado :"
            Height          =   240
            Left            =   90
            TabIndex        =   353
            Top             =   495
            Width           =   5235
         End
      End
      Begin VB.Frame Frame20 
         Caption         =   "Monedas :"
         Height          =   960
         Left            =   -69735
         TabIndex        =   339
         Top             =   5070
         Width           =   5685
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdMonedaDolar"
            Height          =   315
            Index           =   7
            Left            =   540
            TabIndex        =   340
            Tag             =   "Monedas"
            Top             =   585
            Width           =   1410
            _ExtentX        =   2487
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdMoneda"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdMoneda"
            Height          =   315
            Index           =   8
            Left            =   2250
            TabIndex        =   341
            Tag             =   "Monedas"
            Top             =   585
            Width           =   1410
            _ExtentX        =   2487
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdMoneda"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdMonedaEuro"
            Height          =   315
            Index           =   14
            Left            =   4230
            TabIndex        =   344
            Tag             =   "Monedas"
            Top             =   585
            Width           =   1410
            _ExtentX        =   2487
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdMoneda"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdMonedaPrincipal"
            Height          =   315
            Index           =   19
            Left            =   2880
            TabIndex        =   402
            Tag             =   "Monedas"
            Top             =   225
            Width           =   1410
            _ExtentX        =   2487
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdMoneda"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Moneda en la que opera la empresa :"
            Height          =   240
            Index           =   107
            Left            =   135
            TabIndex        =   403
            Top             =   270
            Width           =   2715
         End
         Begin VB.Label lblLabels 
            Caption         =   "Euros :"
            Height          =   240
            Index           =   95
            Left            =   3690
            TabIndex        =   345
            Top             =   630
            Width           =   510
         End
         Begin VB.Label lblLabels 
            Caption         =   "$ :"
            Height          =   240
            Index           =   23
            Left            =   2025
            TabIndex        =   343
            Top             =   630
            Width           =   195
         End
         Begin VB.Label lblLabels 
            Caption         =   "u$s :"
            Height          =   240
            Index           =   24
            Left            =   135
            TabIndex        =   342
            Top             =   630
            Width           =   375
         End
      End
      Begin VB.Frame Frame29 
         Caption         =   "Columnas adicionales para libro de iva compras :"
         Height          =   2355
         Left            =   -69735
         TabIndex        =   321
         Top             =   2685
         Width           =   5685
         Begin VB.CheckBox Check13 
            Alignment       =   1  'Right Justify
            Caption         =   "Desglosar en el libro de iva compras la columna NO GRAVADO :"
            Height          =   240
            Left            =   45
            TabIndex        =   357
            Top             =   2070
            Width           =   4920
         End
         Begin VB.CheckBox Check11 
            Height          =   240
            Index           =   4
            Left            =   1080
            TabIndex        =   336
            Top             =   1800
            Width           =   195
         End
         Begin VB.CheckBox Check11 
            Height          =   240
            Index           =   3
            Left            =   1080
            TabIndex        =   333
            Top             =   1440
            Width           =   195
         End
         Begin VB.CheckBox Check11 
            Height          =   240
            Index           =   2
            Left            =   1080
            TabIndex        =   330
            Top             =   1080
            Width           =   195
         End
         Begin VB.CheckBox Check11 
            Height          =   240
            Index           =   1
            Left            =   1080
            TabIndex        =   327
            Top             =   720
            Width           =   195
         End
         Begin VB.CheckBox Check11 
            Height          =   240
            Index           =   0
            Left            =   1080
            TabIndex        =   324
            Top             =   360
            Width           =   195
         End
         Begin MSDataListLib.DataCombo dcfields1 
            DataField       =   "IdCuentaAdicionalIVACompras1"
            Height          =   315
            Index           =   0
            Left            =   1305
            TabIndex        =   322
            Tag             =   "Cuentas"
            Top             =   315
            Width           =   4245
            _ExtentX        =   7488
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
            TabIndex        =   325
            Tag             =   "Cuentas"
            Top             =   675
            Width           =   4245
            _ExtentX        =   7488
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
            TabIndex        =   328
            Tag             =   "Cuentas"
            Top             =   1035
            Width           =   4245
            _ExtentX        =   7488
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
            TabIndex        =   331
            Tag             =   "Cuentas"
            Top             =   1395
            Width           =   4245
            _ExtentX        =   7488
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
            TabIndex        =   334
            Tag             =   "Cuentas"
            Top             =   1755
            Width           =   4245
            _ExtentX        =   7488
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Col. adic. 5 : "
            Height          =   195
            Index           =   94
            Left            =   90
            TabIndex        =   335
            Top             =   1800
            Width           =   1005
         End
         Begin VB.Label lblLabels 
            Caption         =   "Col. adic. 4 : "
            Height          =   195
            Index           =   93
            Left            =   90
            TabIndex        =   332
            Top             =   1440
            Width           =   1005
         End
         Begin VB.Label lblLabels 
            Caption         =   "Col. adic. 3 : "
            Height          =   195
            Index           =   92
            Left            =   90
            TabIndex        =   329
            Top             =   1080
            Width           =   1005
         End
         Begin VB.Label lblLabels 
            Caption         =   "Col. adic. 2 : "
            Height          =   195
            Index           =   91
            Left            =   90
            TabIndex        =   326
            Top             =   720
            Width           =   1005
         End
         Begin VB.Label lblLabels 
            Caption         =   "Col. adic. 1 : "
            Height          =   195
            Index           =   90
            Left            =   90
            TabIndex        =   323
            Top             =   360
            Width           =   1005
         End
      End
      Begin VB.Frame Frame28 
         Caption         =   "Otras percepciones  ( Compras ) :"
         Height          =   1275
         Left            =   -68430
         TabIndex        =   318
         Top             =   3360
         Width           =   4380
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaPercepcionIVACompras"
            Height          =   315
            Index           =   37
            Left            =   135
            TabIndex        =   319
            Tag             =   "Cuentas"
            Top             =   810
            Width           =   4110
            _ExtentX        =   7250
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta contable para percepciones de IVA en comprobante de acreedores : "
            Height          =   420
            Index           =   68
            Left            =   135
            TabIndex        =   320
            Top             =   315
            Width           =   3615
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Titulos para subdiarios : "
         Height          =   1545
         Left            =   -67980
         TabIndex        =   305
         Top             =   5745
         Width           =   3930
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaVentasTitulo"
            Height          =   315
            Index           =   0
            Left            =   1305
            TabIndex        =   306
            Tag             =   "Titulos"
            Top             =   225
            Width           =   2535
            _ExtentX        =   4471
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTitulo"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaCajaTitulo"
            Height          =   315
            Index           =   18
            Left            =   1305
            TabIndex        =   307
            Tag             =   "Titulos"
            Top             =   540
            Width           =   2535
            _ExtentX        =   4471
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTitulo"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaValoresTitulo"
            Height          =   315
            Index           =   28
            Left            =   1305
            TabIndex        =   308
            Tag             =   "Titulos"
            Top             =   855
            Width           =   2535
            _ExtentX        =   4471
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTitulo"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaComprasTitulo"
            Height          =   315
            Index           =   19
            Left            =   1305
            TabIndex        =   309
            Tag             =   "Titulos"
            Top             =   1170
            Width           =   2535
            _ExtentX        =   4471
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTitulo"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Ventas :"
            Height          =   240
            Index           =   16
            Left            =   90
            TabIndex        =   313
            Top             =   270
            Width           =   1185
         End
         Begin VB.Label lblLabels 
            Caption         =   "Caja - Bancos :"
            Height          =   240
            Index           =   18
            Left            =   90
            TabIndex        =   312
            Top             =   585
            Width           =   1185
         End
         Begin VB.Label lblLabels 
            Caption         =   "Valores :"
            Height          =   240
            Index           =   35
            Left            =   90
            TabIndex        =   311
            Top             =   900
            Width           =   1185
         End
         Begin VB.Label lblLabels 
            Caption         =   "Compras :"
            Height          =   240
            Index           =   19
            Left            =   90
            TabIndex        =   310
            Top             =   1215
            Width           =   1185
         End
      End
      Begin VB.Frame Frame26 
         Caption         =   "PRESTO : "
         Height          =   915
         Left            =   -74910
         TabIndex        =   300
         Top             =   3450
         Width           =   5865
         Begin VB.TextBox txtPathObra 
            DataField       =   "PathObra"
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
            Left            =   1890
            TabIndex        =   302
            Top             =   225
            Width           =   3885
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdArticuloVariosParaPRESTO"
            Height          =   315
            Index           =   13
            Left            =   1890
            TabIndex        =   303
            Tag             =   "Articulos"
            Top             =   540
            Width           =   3885
            _ExtentX        =   6853
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdArticulo"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Codigo material varios :"
            Height          =   240
            Index           =   87
            Left            =   90
            TabIndex        =   304
            Top             =   585
            Width           =   1680
         End
         Begin VB.Label Label81 
            Caption         =   "Path archivo Presto :"
            Height          =   240
            Left            =   90
            TabIndex        =   301
            Top             =   270
            Width           =   1680
         End
      End
      Begin VB.Frame Frame25 
         Caption         =   "Cuentas para cierre de ejercicio : "
         Height          =   1500
         Left            =   -69375
         TabIndex        =   287
         Top             =   6375
         Width           =   5280
         Begin VB.TextBox txtCuentasPatrimonialesDesde 
            DataField       =   "CuentasPatrimonialesDesde"
            Height          =   285
            Left            =   2205
            TabIndex        =   297
            Top             =   855
            Width           =   1005
         End
         Begin VB.TextBox txtCuentasPatrimonialesHasta 
            DataField       =   "CuentasPatrimonialesHasta"
            Height          =   285
            Left            =   4185
            TabIndex        =   296
            Top             =   855
            Width           =   1005
         End
         Begin VB.TextBox txtCuentasResultadoHasta 
            DataField       =   "CuentasResultadoHasta"
            Height          =   285
            Left            =   4185
            TabIndex        =   295
            Top             =   1170
            Width           =   1005
         End
         Begin VB.TextBox txtCuentasResultadoDesde 
            DataField       =   "CuentasResultadoDesde"
            Height          =   285
            Left            =   2205
            TabIndex        =   292
            Top             =   1125
            Width           =   1005
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaResultadosEjercicio"
            Height          =   315
            Index           =   44
            Left            =   2205
            TabIndex        =   288
            Tag             =   "Cuentas"
            Top             =   225
            Width           =   2985
            _ExtentX        =   5265
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaResultadosAcumulados"
            Height          =   315
            Index           =   42
            Left            =   2205
            TabIndex        =   290
            Tag             =   "Cuentas"
            Top             =   540
            Width           =   2985
            _ExtentX        =   5265
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Rango cuentas patrimon. :"
            Height          =   240
            Index           =   86
            Left            =   90
            TabIndex        =   299
            Top             =   930
            Width           =   2040
         End
         Begin VB.Label lblLabels 
            Caption         =   "al codigo :"
            Height          =   240
            Index           =   85
            Left            =   3375
            TabIndex        =   298
            Top             =   945
            Width           =   780
         End
         Begin VB.Label lblLabels 
            Caption         =   "al codigo :"
            Height          =   240
            Index           =   84
            Left            =   3375
            TabIndex        =   294
            Top             =   1170
            Width           =   780
         End
         Begin VB.Label lblLabels 
            Caption         =   "Rango cuentas de resultado"
            Height          =   240
            Index           =   82
            Left            =   90
            TabIndex        =   293
            Top             =   1215
            Width           =   2040
         End
         Begin VB.Label lblLabels 
            Caption         =   "Resultados acumulados :"
            Height          =   285
            Index           =   81
            Left            =   90
            TabIndex        =   291
            Top             =   600
            Width           =   2040
         End
         Begin VB.Label lblLabels 
            Caption         =   "Resultados del ejercicio : "
            Height          =   285
            Index           =   83
            Left            =   90
            TabIndex        =   289
            Top             =   270
            Width           =   2040
         End
      End
      Begin VB.Frame Frame24 
         Caption         =   "Cuentas para plazos fijos : "
         Height          =   915
         Left            =   -74865
         TabIndex        =   276
         Top             =   5475
         Width           =   5280
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaInteresesPlazosFijos"
            Height          =   315
            Index           =   41
            Left            =   2205
            TabIndex        =   277
            Tag             =   "Cuentas"
            Top             =   540
            Width           =   2985
            _ExtentX        =   5265
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaPlazosFijos"
            Height          =   315
            Index           =   43
            Left            =   2205
            TabIndex        =   278
            Tag             =   "Cuentas"
            Top             =   180
            Width           =   2985
            _ExtentX        =   5265
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Plazos fijos :"
            Height          =   285
            Index           =   78
            Left            =   90
            TabIndex        =   280
            Top             =   270
            Width           =   870
         End
         Begin VB.Label lblLabels 
            Caption         =   "Intereses plazos fijos : "
            Height          =   285
            Index           =   77
            Left            =   90
            TabIndex        =   279
            Top             =   585
            Width           =   1590
         End
      End
      Begin VB.Frame Frame6 
         Caption         =   "Grupos de cuentas :"
         Height          =   1815
         Left            =   -69375
         TabIndex        =   267
         Top             =   4530
         Width           =   5280
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoCuentaGrupoIVA"
            Height          =   315
            Index           =   24
            Left            =   2250
            TabIndex        =   268
            Tag             =   "TiposCuentaGrupos"
            Top             =   495
            Width           =   2940
            _ExtentX        =   5186
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoCuentaGrupo"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IGCondicionExcepcion"
            Height          =   315
            Index           =   7
            Left            =   2250
            TabIndex        =   269
            Tag             =   "IGCondiciones"
            Top             =   810
            Width           =   2940
            _ExtentX        =   5186
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdIGCondicion"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoCuentaGrupoFF"
            Height          =   315
            Index           =   16
            Left            =   2250
            TabIndex        =   270
            Tag             =   "TiposCuentaGrupos"
            Top             =   180
            Width           =   2940
            _ExtentX        =   5186
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoCuentaGrupo"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoCuentaGrupoAnticiposAlPersonal"
            Height          =   315
            Index           =   30
            Left            =   2250
            TabIndex        =   271
            Tag             =   "TiposCuentaGrupos"
            Top             =   1125
            Width           =   2940
            _ExtentX        =   5186
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoCuentaGrupo"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "_IdTipoCuentaGrupoPercepciones"
            Height          =   315
            Index           =   58
            Left            =   2250
            TabIndex        =   427
            Tag             =   "TiposCuentaGrupos"
            Top             =   1440
            Width           =   2940
            _ExtentX        =   5186
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoCuentaGrupo"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Grupo percepciones :"
            Height          =   195
            Index           =   111
            Left            =   90
            TabIndex        =   428
            Top             =   1485
            Width           =   2040
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cond. excepcion ganacias : "
            Height          =   285
            Index           =   6
            Left            =   90
            TabIndex        =   275
            Top             =   885
            Width           =   2040
         End
         Begin VB.Label lblLabels 
            Caption         =   "Grupo de cuentas de IVA :"
            Height          =   285
            Index           =   47
            Left            =   90
            TabIndex        =   274
            Top             =   555
            Width           =   2040
         End
         Begin VB.Label lblLabels 
            Caption         =   "Grupo de cuentas de F.Fijo :"
            Height          =   240
            Index           =   53
            Left            =   90
            TabIndex        =   273
            Top             =   270
            Width           =   2040
         End
         Begin VB.Label lblLabels 
            Caption         =   "Grupo anticipos al personal :"
            Height          =   195
            Index           =   61
            Left            =   90
            TabIndex        =   272
            Top             =   1170
            Width           =   2040
         End
      End
      Begin VB.Frame Frame23 
         Caption         =   "Cargos :"
         Height          =   555
         Left            =   -69015
         TabIndex        =   260
         Top             =   4170
         Width           =   4965
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdJefeCompras"
            Height          =   315
            Index           =   6
            Left            =   2565
            TabIndex        =   263
            Tag             =   "Empleados"
            Top             =   180
            Width           =   2310
            _ExtentX        =   4075
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdEmpleado"
            Text            =   ""
         End
         Begin VB.Label Label30 
            Caption         =   "Actual jefe de compras :"
            Height          =   240
            Left            =   135
            TabIndex        =   264
            Top             =   225
            Width           =   2400
         End
      End
      Begin VB.Frame Frame21 
         Caption         =   "Numeracion de comprobantes de ventas :"
         Height          =   1320
         Left            =   -69735
         TabIndex        =   250
         Top             =   1335
         Width           =   5685
         Begin VB.Frame Frame17 
            Height          =   375
            Left            =   3690
            TabIndex        =   253
            Top             =   540
            Width           =   1815
            Begin VB.OptionButton Option2 
               Caption         =   "SI"
               Height          =   195
               Left            =   1170
               TabIndex        =   255
               Top             =   135
               Width           =   510
            End
            Begin VB.OptionButton Option1 
               Caption         =   "NO"
               Height          =   195
               Left            =   225
               TabIndex        =   254
               Top             =   135
               Width           =   555
            End
         End
         Begin MSDataListLib.DataCombo DataCombo2 
            DataField       =   "NumeracionUnica"
            Height          =   315
            Index           =   0
            Left            =   3690
            TabIndex        =   251
            Tag             =   "SiNo"
            Top             =   225
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
            DataField       =   "IdPuntoVentaNumeracionUnica"
            Height          =   315
            Index           =   9
            Left            =   2925
            TabIndex        =   256
            Tag             =   "PuntosVenta"
            Top             =   945
            Width           =   2580
            _ExtentX        =   4551
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdPuntoVenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Comprobante para numeracion unica : "
            Height          =   240
            Index           =   69
            Left            =   135
            TabIndex        =   258
            Top             =   990
            Width           =   2805
         End
         Begin VB.Label lblLabels 
            Caption         =   "Numeracion unica de comprobantes de venta ? :"
            Height          =   240
            Index           =   70
            Left            =   135
            TabIndex        =   257
            Top             =   630
            Width           =   3480
         End
         Begin VB.Label lblLabels 
            Caption         =   "Numeracion correlativa de comprob. deudores :"
            Height          =   240
            Index           =   8
            Left            =   135
            TabIndex        =   252
            Top             =   270
            Width           =   3480
         End
      End
      Begin VB.Frame Frame19 
         Caption         =   "Stock :"
         Height          =   600
         Left            =   -69735
         TabIndex        =   247
         Top             =   705
         Width           =   5685
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdObraStockDisponible"
            Height          =   315
            Index           =   38
            Left            =   2970
            TabIndex        =   248
            Tag             =   "Obras"
            Top             =   225
            Width           =   2580
            _ExtentX        =   4551
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdObra"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Centro de costo para stock disponible :"
            Height          =   195
            Index           =   71
            Left            =   90
            TabIndex        =   249
            Top             =   270
            Width           =   2850
         End
      End
      Begin VB.Frame Frame10 
         Caption         =   "Tipos de comprobante (Ventas) :"
         Height          =   2085
         Left            =   -74820
         TabIndex        =   232
         Top             =   705
         Width           =   4920
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoComprobanteFacturaVenta"
            Height          =   315
            Index           =   21
            Left            =   1980
            TabIndex        =   233
            Tag             =   "TiposComprobante"
            Top             =   225
            Width           =   2850
            _ExtentX        =   5027
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoComprobante"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoComprobanteDevoluciones"
            Height          =   315
            Index           =   22
            Left            =   1980
            TabIndex        =   234
            Tag             =   "TiposComprobante"
            Top             =   585
            Width           =   2850
            _ExtentX        =   5027
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoComprobante"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoComprobanteNotaDebito"
            Height          =   315
            Index           =   25
            Left            =   1980
            TabIndex        =   235
            Tag             =   "TiposComprobante"
            Top             =   945
            Width           =   2850
            _ExtentX        =   5027
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoComprobante"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoComprobanteNotaCredito"
            Height          =   315
            Index           =   26
            Left            =   1980
            TabIndex        =   236
            Tag             =   "TiposComprobante"
            Top             =   1305
            Width           =   2850
            _ExtentX        =   5027
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoComprobante"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoComprobanteRecibo"
            Height          =   315
            Index           =   27
            Left            =   1980
            TabIndex        =   237
            Tag             =   "TiposComprobante"
            Top             =   1665
            Width           =   2850
            _ExtentX        =   5027
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoComprobante"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Factura de venta :"
            Height          =   195
            Index           =   55
            Left            =   90
            TabIndex        =   242
            Top             =   270
            Width           =   1815
         End
         Begin VB.Label lblLabels 
            Caption         =   "Devoluciones ventas :"
            Height          =   195
            Index           =   56
            Left            =   90
            TabIndex        =   241
            Top             =   630
            Width           =   1815
         End
         Begin VB.Label lblLabels 
            Caption         =   "Nota debito (deudores) :"
            Height          =   195
            Index           =   57
            Left            =   90
            TabIndex        =   240
            Top             =   990
            Width           =   1815
         End
         Begin VB.Label lblLabels 
            Caption         =   "Nota credito (deudores) :"
            Height          =   195
            Index           =   58
            Left            =   90
            TabIndex        =   239
            Top             =   1350
            Width           =   1815
         End
         Begin VB.Label lblLabels 
            Caption         =   "Recibos cobranza : "
            Height          =   195
            Index           =   59
            Left            =   90
            TabIndex        =   238
            Top             =   1710
            Width           =   1815
         End
      End
      Begin VB.Frame Frame11 
         Caption         =   "Tipos de comprobante (Compras) :"
         Height          =   2130
         Left            =   -74820
         TabIndex        =   223
         Top             =   2820
         Width           =   4920
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoComprobanteFacturaCompra"
            Height          =   315
            Index           =   31
            Left            =   1980
            TabIndex        =   224
            Tag             =   "TiposComprobante"
            Top             =   270
            Width           =   2850
            _ExtentX        =   5027
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoComprobante"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoComprobanteNDInternaAcreedores"
            Height          =   315
            Index           =   32
            Left            =   1980
            TabIndex        =   225
            Tag             =   "TiposComprobante"
            Top             =   990
            Width           =   2850
            _ExtentX        =   5027
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoComprobante"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoComprobanteNCInternaAcreedores"
            Height          =   315
            Index           =   33
            Left            =   1980
            TabIndex        =   226
            Tag             =   "TiposComprobante"
            Top             =   1350
            Width           =   2850
            _ExtentX        =   5027
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoComprobante"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoComprobanteOrdenPago"
            Height          =   315
            Index           =   39
            Left            =   1980
            TabIndex        =   227
            Tag             =   "TiposComprobante"
            Top             =   1710
            Width           =   2850
            _ExtentX        =   5027
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoComprobante"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoComprobanteFacturaCompraExportacion"
            Height          =   315
            Index           =   47
            Left            =   1980
            TabIndex        =   355
            Tag             =   "TiposComprobante"
            Top             =   630
            Width           =   2850
            _ExtentX        =   5027
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoComprobante"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Factura de compra (Exp):"
            Height          =   195
            Index           =   96
            Left            =   90
            TabIndex        =   356
            Top             =   675
            Width           =   1815
         End
         Begin VB.Label lblLabels 
            Caption         =   "Orden de pago :"
            Height          =   195
            Index           =   72
            Left            =   90
            TabIndex        =   231
            Top             =   1755
            Width           =   1815
         End
         Begin VB.Label lblLabels 
            Caption         =   "Nota de credito interna :"
            Height          =   195
            Index           =   65
            Left            =   90
            TabIndex        =   230
            Top             =   1395
            Width           =   1815
         End
         Begin VB.Label lblLabels 
            Caption         =   "Nota de debito interna :"
            Height          =   195
            Index           =   66
            Left            =   90
            TabIndex        =   229
            Top             =   1035
            Width           =   1815
         End
         Begin VB.Label lblLabels 
            Caption         =   "Factura de compra :"
            Height          =   195
            Index           =   67
            Left            =   90
            TabIndex        =   228
            Top             =   315
            Width           =   1815
         End
      End
      Begin VB.Frame Frame4 
         Caption         =   "Tipos de comprobante (Caja y banco) :"
         Height          =   2085
         Left            =   -74820
         TabIndex        =   214
         Top             =   4980
         Width           =   4920
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoComprobanteCajaIngresos"
            Height          =   315
            Index           =   5
            Left            =   2205
            TabIndex        =   215
            Tag             =   "TiposComprobante"
            Top             =   225
            Width           =   2625
            _ExtentX        =   4630
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoComprobante"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoComprobanteCajaEgresos"
            Height          =   315
            Index           =   6
            Left            =   2205
            TabIndex        =   216
            Tag             =   "TiposComprobante"
            Top             =   585
            Width           =   2625
            _ExtentX        =   4630
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoComprobante"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoComprobanteEfectivo"
            Height          =   315
            Index           =   2
            Left            =   2205
            TabIndex        =   217
            Tag             =   "TiposComprobante"
            Top             =   945
            Width           =   2625
            _ExtentX        =   4630
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoComprobante"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoComprobanteDeposito"
            Height          =   315
            Index           =   3
            Left            =   2205
            TabIndex        =   218
            Tag             =   "TiposComprobante"
            Top             =   1305
            Width           =   2625
            _ExtentX        =   4630
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoComprobante"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdTipoComprobanteTarjetaCredito"
            Height          =   315
            Index           =   57
            Left            =   2205
            TabIndex        =   404
            Tag             =   "TiposComprobante"
            Top             =   1665
            Width           =   2625
            _ExtentX        =   4630
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoComprobante"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Tipo comprobante tarjeta :"
            Height          =   240
            Index           =   108
            Left            =   90
            TabIndex        =   405
            Top             =   1665
            Width           =   2040
         End
         Begin VB.Label lblLabels 
            Caption         =   "Comprob. p/caja egresos :"
            Height          =   240
            Index           =   15
            Left            =   90
            TabIndex        =   222
            Top             =   645
            Width           =   2040
         End
         Begin VB.Label lblLabels 
            Caption         =   "Comprob. p/caja ingresos :"
            Height          =   240
            Index           =   51
            Left            =   90
            TabIndex        =   221
            Top             =   315
            Width           =   2040
         End
         Begin VB.Label lblLabels 
            Caption         =   "Tipo comprobante efectivo :"
            Height          =   240
            Index           =   4
            Left            =   90
            TabIndex        =   220
            Top             =   975
            Width           =   2040
         End
         Begin VB.Label lblLabels 
            Caption         =   "Tipo comprobante deposito :"
            Height          =   240
            Index           =   5
            Left            =   90
            TabIndex        =   219
            Top             =   1305
            Width           =   2040
         End
      End
      Begin VB.Frame Frame13 
         Caption         =   "Diferencias de cambio : "
         Height          =   960
         Left            =   -69015
         TabIndex        =   209
         Top             =   4755
         Width           =   4965
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdConceptoDiferenciaCambio"
            Height          =   315
            Index           =   8
            Left            =   2925
            TabIndex        =   210
            Tag             =   "Conceptos"
            Top             =   225
            Width           =   1905
            _ExtentX        =   3360
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdConcepto"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaDiferenciaCambio"
            Height          =   315
            Index           =   20
            Left            =   2925
            TabIndex        =   211
            Tag             =   "Cuentas"
            Top             =   585
            Width           =   1905
            _ExtentX        =   3360
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta contable :"
            Height          =   240
            Index           =   54
            Left            =   90
            TabIndex        =   213
            Top             =   630
            Width           =   2805
         End
         Begin VB.Label lblLabels 
            Caption         =   "Concepto para diferencias de cambio :"
            Height          =   240
            Index           =   7
            Left            =   90
            TabIndex        =   212
            Top             =   315
            Width           =   2805
         End
      End
      Begin VB.Frame Frame14 
         Caption         =   "Unidades de medida : "
         Height          =   600
         Left            =   -74910
         TabIndex        =   202
         Top             =   2820
         Width           =   5865
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdUnidadPorKilo"
            Height          =   315
            Index           =   1
            Left            =   4500
            TabIndex        =   203
            Tag             =   "Unidades"
            Top             =   225
            Width           =   1275
            _ExtentX        =   2249
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdUnidad"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdUnidadPorUnidad"
            Height          =   315
            Index           =   0
            Left            =   2610
            TabIndex        =   204
            Tag             =   "Unidades"
            Top             =   225
            Width           =   1230
            _ExtentX        =   2170
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdUnidad"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdUnidad"
            Height          =   315
            Index           =   17
            Left            =   720
            TabIndex        =   205
            Tag             =   "Unidades"
            Top             =   225
            Width           =   1230
            _ExtentX        =   2170
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdUnidad"
            Text            =   ""
         End
         Begin VB.Label Label22 
            Caption         =   "Un.Kg.:"
            Height          =   240
            Left            =   3915
            TabIndex        =   208
            Top             =   270
            Width           =   600
         End
         Begin VB.Label Label21 
            Caption         =   "Un.Uni.:"
            Height          =   240
            Left            =   1980
            TabIndex        =   207
            Top             =   270
            Width           =   600
         End
         Begin VB.Label lblLabels 
            Caption         =   "Un.Std. :"
            Height          =   240
            Index           =   17
            Left            =   45
            TabIndex        =   206
            Top             =   270
            Width           =   690
         End
      End
      Begin VB.Frame Frame18 
         Caption         =   "Plantillas de impresion de formularios (comercial) : "
         Height          =   2220
         Left            =   -74775
         TabIndex        =   182
         Top             =   765
         Width           =   10635
         Begin VB.TextBox txtPlantillas 
            DataField       =   "Plantilla_NotasCredito_E"
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
            Index           =   11
            Left            =   7695
            TabIndex        =   201
            Top             =   1755
            Width           =   2715
         End
         Begin VB.TextBox txtPlantillas 
            DataField       =   "Plantilla_NotasCredito_B"
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
            Index           =   10
            Left            =   4905
            TabIndex        =   200
            Top             =   1755
            Width           =   2715
         End
         Begin VB.TextBox txtPlantillas 
            DataField       =   "Plantilla_NotasCredito_A"
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
            Index           =   9
            Left            =   2115
            TabIndex        =   199
            Top             =   1755
            Width           =   2715
         End
         Begin VB.TextBox txtPlantillas 
            DataField       =   "Plantilla_NotasDebito_E"
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
            Index           =   8
            Left            =   7695
            TabIndex        =   198
            Top             =   1350
            Width           =   2715
         End
         Begin VB.TextBox txtPlantillas 
            DataField       =   "Plantilla_NotasDebito_B"
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
            Index           =   7
            Left            =   4905
            TabIndex        =   197
            Top             =   1350
            Width           =   2715
         End
         Begin VB.TextBox txtPlantillas 
            DataField       =   "Plantilla_NotasDebito_A"
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
            Index           =   6
            Left            =   2115
            TabIndex        =   196
            Top             =   1350
            Width           =   2715
         End
         Begin VB.TextBox txtPlantillas 
            DataField       =   "Plantilla_Devoluciones_E"
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
            Index           =   5
            Left            =   7695
            TabIndex        =   195
            Top             =   945
            Width           =   2715
         End
         Begin VB.TextBox txtPlantillas 
            DataField       =   "Plantilla_Devoluciones_B"
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
            TabIndex        =   194
            Top             =   945
            Width           =   2715
         End
         Begin VB.TextBox txtPlantillas 
            DataField       =   "Plantilla_Devoluciones_A"
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
            Left            =   2115
            TabIndex        =   193
            Top             =   945
            Width           =   2715
         End
         Begin VB.TextBox txtPlantillas 
            DataField       =   "Plantilla_Factura_E"
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
            Left            =   7695
            TabIndex        =   192
            Top             =   540
            Width           =   2715
         End
         Begin VB.TextBox txtPlantillas 
            DataField       =   "Plantilla_Factura_B"
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
            Left            =   4905
            TabIndex        =   189
            Top             =   540
            Width           =   2715
         End
         Begin VB.TextBox txtPlantillas 
            DataField       =   "Plantilla_Factura_A"
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
            Left            =   2115
            TabIndex        =   188
            Top             =   540
            Width           =   2715
         End
         Begin VB.Label Label33 
            Alignment       =   2  'Center
            BackColor       =   &H00C0C0FF&
            Caption         =   "Tipo 'E'"
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
            Index           =   2
            Left            =   7695
            TabIndex        =   191
            Top             =   270
            Width           =   2715
         End
         Begin VB.Label Label33 
            Alignment       =   2  'Center
            BackColor       =   &H00C0C0FF&
            Caption         =   "Tipo 'B'"
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
            Index           =   1
            Left            =   4905
            TabIndex        =   190
            Top             =   270
            Width           =   2715
         End
         Begin VB.Label lblComprobantes 
            Caption         =   "Notas de credito : "
            Height          =   300
            Index           =   3
            Left            =   90
            TabIndex        =   187
            Top             =   1800
            Width           =   1950
         End
         Begin VB.Label lblComprobantes 
            Caption         =   "Notas de debito : "
            Height          =   300
            Index           =   2
            Left            =   90
            TabIndex        =   186
            Top             =   1395
            Width           =   1950
         End
         Begin VB.Label lblComprobantes 
            Caption         =   "Devoluciones :"
            Height          =   300
            Index           =   1
            Left            =   90
            TabIndex        =   185
            Top             =   945
            Width           =   1950
         End
         Begin VB.Label Label33 
            Alignment       =   2  'Center
            BackColor       =   &H00C0C0FF&
            Caption         =   "Tipo 'A'"
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
            Index           =   0
            Left            =   2115
            TabIndex        =   184
            Top             =   270
            Width           =   2715
         End
         Begin VB.Label lblComprobantes 
            Caption         =   "Facturas de venta : "
            Height          =   300
            Index           =   0
            Left            =   90
            TabIndex        =   183
            Top             =   540
            Width           =   1950
         End
      End
      Begin VB.TextBox txtProximoNumeroInternoRecepcion 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroInternoRecepcion"
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
         Left            =   4275
         TabIndex        =   178
         Text            =   "Text6"
         Top             =   3270
         Width           =   1140
      End
      Begin VB.Frame Frame16 
         Caption         =   "Datos para calculo de SUSS : "
         Height          =   1320
         Left            =   -74820
         TabIndex        =   169
         Top             =   6510
         Width           =   10815
         Begin VB.TextBox txtPorcentajeRetencionSUSS 
            Alignment       =   1  'Right Justify
            DataField       =   "PorcentajeRetencionSUSS"
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
            Left            =   7245
            TabIndex        =   175
            Top             =   180
            Width           =   825
         End
         Begin VB.CheckBox Check8 
            Alignment       =   1  'Right Justify
            Caption         =   "La empresa es agente de retencion SUSS ? :"
            Height          =   195
            Left            =   90
            TabIndex        =   172
            Top             =   270
            Width           =   3570
         End
         Begin VB.TextBox txtProximoNumeroCertificadoRetencionSUSS 
            Alignment       =   1  'Right Justify
            DataField       =   "ProximoNumeroCertificadoRetencionSUSS"
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
            TabIndex        =   170
            Top             =   540
            Width           =   1185
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaRetencionSUSS"
            Height          =   315
            Index           =   34
            Left            =   6705
            TabIndex        =   173
            Tag             =   "Cuentas"
            Top             =   495
            Width           =   3930
            _ExtentX        =   6932
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
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
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaRetencionSUSS_Recibida"
            Height          =   315
            Index           =   40
            Left            =   4590
            TabIndex        =   180
            Tag             =   "Cuentas"
            Top             =   945
            Width           =   4650
            _ExtentX        =   8202
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
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
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta contable para retenciones SUSS recibidas (clientes) : "
            Height          =   195
            Index           =   73
            Left            =   90
            TabIndex        =   181
            Top             =   1035
            Width           =   4425
         End
         Begin VB.Line Line1 
            Index           =   0
            X1              =   0
            X2              =   10800
            Y1              =   900
            Y2              =   900
         End
         Begin VB.Label Label94 
            Caption         =   "Porcentaje de retencion por default :"
            Height          =   195
            Left            =   4500
            TabIndex        =   176
            Top             =   225
            Width           =   2670
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta contable por default : "
            Height          =   195
            Index           =   62
            Left            =   4545
            TabIndex        =   174
            Top             =   585
            Width           =   2175
         End
         Begin VB.Label Label93 
            Caption         =   "Proximo certificado de retencion SUSS : "
            Height          =   195
            Left            =   90
            TabIndex        =   171
            Top             =   585
            Width           =   2985
         End
      End
      Begin VB.Frame Frame7 
         Caption         =   "Cuentas contables retenciones :"
         Height          =   1905
         Left            =   -68430
         TabIndex        =   162
         Top             =   1425
         Width           =   4380
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaRetencionGanancias"
            Height          =   315
            Index           =   13
            Left            =   135
            TabIndex        =   163
            Tag             =   "Cuentas"
            Top             =   945
            Width           =   4110
            _ExtentX        =   7250
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaRetencionIBrutos"
            Height          =   315
            Index           =   14
            Left            =   135
            TabIndex        =   164
            Tag             =   "Cuentas"
            Top             =   405
            Width           =   4110
            _ExtentX        =   7250
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaRetencionGananciasCobros"
            Height          =   315
            Index           =   23
            Left            =   135
            TabIndex        =   165
            Tag             =   "Cuentas"
            Top             =   1485
            Width           =   4110
            _ExtentX        =   7250
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Retencion impuesto a las ganancias (Cobranzas):"
            Height          =   195
            Index           =   46
            Left            =   135
            TabIndex        =   168
            Top             =   1305
            Width           =   3660
         End
         Begin VB.Label lblLabels 
            Caption         =   "Retencion impuesto a las ganancias (Pagos) :"
            Height          =   195
            Index           =   11
            Left            =   135
            TabIndex        =   167
            Top             =   765
            Width           =   3435
         End
         Begin VB.Label lblLabels 
            Caption         =   "Retencion ingresos brutos (Pagos) :"
            Height          =   195
            Index           =   10
            Left            =   135
            TabIndex        =   166
            Top             =   225
            Width           =   2580
         End
      End
      Begin VB.TextBox txtProximoNumeroPedidoExterior 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroPedidoExterior"
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
         Left            =   4275
         TabIndex        =   160
         Text            =   "Text6"
         Top             =   2325
         Width           =   1140
      End
      Begin VB.Frame Frame12 
         Caption         =   "Otras percepciones  ( Ventas ) : "
         Height          =   1815
         Left            =   -74820
         TabIndex        =   148
         Top             =   4665
         Width           =   10815
         Begin VB.CheckBox Check15 
            Alignment       =   1  'Right Justify
            Caption         =   "Activar otras percepciones 3 :"
            Height          =   195
            Left            =   90
            TabIndex        =   371
            Top             =   1170
            Width           =   2535
         End
         Begin VB.TextBox txtOtrasPercepciones3Desc 
            DataField       =   "OtrasPercepciones3Desc"
            Height          =   240
            Left            =   3915
            TabIndex        =   370
            Top             =   1170
            Width           =   1680
         End
         Begin VB.TextBox txtOtrasPercepciones2Desc 
            DataField       =   "OtrasPercepciones2Desc"
            Height          =   240
            Left            =   3915
            TabIndex        =   155
            Top             =   855
            Width           =   1680
         End
         Begin VB.TextBox txtOtrasPercepciones1Desc 
            DataField       =   "OtrasPercepciones1Desc"
            Height          =   240
            Left            =   3915
            TabIndex        =   154
            Top             =   540
            Width           =   1680
         End
         Begin VB.CheckBox Check4 
            Alignment       =   1  'Right Justify
            Caption         =   "Activar otras percepciones 2 :"
            Height          =   195
            Left            =   90
            TabIndex        =   151
            Top             =   855
            Width           =   2535
         End
         Begin VB.CheckBox Check3 
            Alignment       =   1  'Right Justify
            Caption         =   "Activar otras percepciones 1 :"
            Height          =   195
            Left            =   90
            TabIndex        =   150
            Top             =   540
            Width           =   2535
         End
         Begin VB.CheckBox Check2 
            Alignment       =   1  'Right Justify
            Caption         =   "La empresa percibe ingresos brutos en comprobantes de venta ? : "
            Height          =   195
            Left            =   90
            TabIndex        =   149
            Top             =   270
            Width           =   5505
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaOtrasPercepciones1"
            Height          =   315
            Index           =   35
            Left            =   7200
            TabIndex        =   156
            Tag             =   "Cuentas"
            Top             =   495
            Width           =   3525
            _ExtentX        =   6218
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaOtrasPercepciones2"
            Height          =   315
            Index           =   36
            Left            =   7200
            TabIndex        =   158
            Tag             =   "Cuentas"
            Top             =   810
            Width           =   3525
            _ExtentX        =   6218
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaOtrasPercepciones3"
            Height          =   315
            Index           =   50
            Left            =   7200
            TabIndex        =   372
            Tag             =   "Cuentas"
            Top             =   1125
            Width           =   3525
            _ExtentX        =   6218
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaPercepcionesIVA"
            Height          =   315
            Index           =   53
            Left            =   2925
            TabIndex        =   384
            Tag             =   "Cuentas"
            Top             =   1440
            Width           =   4335
            _ExtentX        =   7646
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta contable para percepcion IVA :"
            Height          =   240
            Index           =   103
            Left            =   45
            TabIndex        =   385
            Top             =   1530
            Width           =   2895
         End
         Begin VB.Line Line1 
            Index           =   1
            X1              =   0
            X2              =   10800
            Y1              =   1440
            Y2              =   1440
         End
         Begin VB.Label Label98 
            Caption         =   "Descripcion :"
            Height          =   195
            Left            =   2790
            TabIndex        =   374
            Top             =   1170
            Width           =   1050
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta contable :"
            Height          =   240
            Index           =   101
            Left            =   5805
            TabIndex        =   373
            Top             =   1170
            Width           =   1320
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta contable :"
            Height          =   240
            Index           =   64
            Left            =   5805
            TabIndex        =   159
            Top             =   855
            Width           =   1320
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta contable :"
            Height          =   240
            Index           =   63
            Left            =   5805
            TabIndex        =   157
            Top             =   540
            Width           =   1320
         End
         Begin VB.Label Label90 
            Caption         =   "Descripcion :"
            Height          =   195
            Left            =   2790
            TabIndex        =   153
            Top             =   855
            Width           =   1050
         End
         Begin VB.Label Label89 
            Caption         =   "Descripcion :"
            Height          =   195
            Left            =   2790
            TabIndex        =   152
            Top             =   540
            Width           =   1050
         End
      End
      Begin VB.Frame Frame9 
         Caption         =   "Datos para calculo de retencion Ingresos Brutos :"
         Height          =   780
         Left            =   -68430
         TabIndex        =   147
         Top             =   615
         Width           =   4380
         Begin VB.CheckBox Check9 
            Alignment       =   1  'Right Justify
            Caption         =   "La empresa es agente de retencion IIBB ? :"
            Height          =   195
            Left            =   90
            TabIndex        =   177
            Top             =   405
            Width           =   3975
         End
      End
      Begin VB.Frame Frame8 
         Caption         =   "Datos para calculo de retencion IVA :"
         Height          =   3165
         Left            =   -74820
         TabIndex        =   133
         Top             =   615
         Width           =   6315
         Begin VB.TextBox txtTopeMinimoRetencionIVAServicios 
            Alignment       =   1  'Right Justify
            DataField       =   "TopeMinimoRetencionIVAServicios"
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
            TabIndex        =   401
            Top             =   2160
            Width           =   915
         End
         Begin VB.TextBox txtTopeMinimoRetencionIVA 
            Alignment       =   1  'Right Justify
            DataField       =   "TopeMinimoRetencionIVA"
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
            TabIndex        =   399
            Top             =   1845
            Width           =   915
         End
         Begin VB.TextBox txtImporteMinimoRetencionIVAServicios 
            Alignment       =   1  'Right Justify
            DataField       =   "ImporteMinimoRetencionIVAServicios"
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
            Left            =   4680
            TabIndex        =   383
            Top             =   2160
            Width           =   915
         End
         Begin VB.TextBox txtPorcentajeRetencionIVAComprobantesM 
            Alignment       =   1  'Right Justify
            DataField       =   "PorcentajeRetencionIVAComprobantesM"
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
            Left            =   5400
            TabIndex        =   348
            Top             =   2835
            Width           =   780
         End
         Begin VB.TextBox txtImporteComprobantesMParaRetencionIVA 
            Alignment       =   1  'Right Justify
            DataField       =   "ImporteComprobantesMParaRetencionIVA"
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
            Left            =   5040
            TabIndex        =   346
            Top             =   2565
            Width           =   1140
         End
         Begin VB.TextBox txtProximoNumeroCertificadoRetencionIVA 
            Alignment       =   1  'Right Justify
            DataField       =   "ProximoNumeroCertificadoRetencionIVA"
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
            Left            =   2205
            TabIndex        =   145
            Top             =   1575
            Width           =   1185
         End
         Begin VB.CheckBox Check1 
            Alignment       =   1  'Right Justify
            Caption         =   "La empresa es agente de retencion IVA ? :"
            Height          =   195
            Left            =   90
            TabIndex        =   144
            Top             =   315
            Width           =   3480
         End
         Begin VB.TextBox txtImporteMinimoRetencionIVA 
            Alignment       =   1  'Right Justify
            DataField       =   "ImporteMinimoRetencionIVA"
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
            Left            =   4680
            TabIndex        =   142
            Top             =   1845
            Width           =   915
         End
         Begin VB.TextBox txtImporteTotalMinimoAplicacionRetencionIVA 
            Alignment       =   1  'Right Justify
            DataField       =   "ImporteTotalMinimoAplicacionRetencionIVA"
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
            Left            =   4995
            TabIndex        =   140
            Top             =   1260
            Width           =   1185
         End
         Begin VB.TextBox txtPorcentajeBaseRetencionIVAServicios 
            Alignment       =   2  'Center
            DataField       =   "PorcentajeBaseRetencionIVAServicios"
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
            Left            =   5625
            TabIndex        =   138
            Top             =   2160
            Width           =   555
         End
         Begin VB.TextBox txtPorcentajeBaseRetencionIVABienes 
            Alignment       =   2  'Center
            DataField       =   "PorcentajeBaseRetencionIVABienes"
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
            Left            =   5625
            TabIndex        =   136
            Top             =   1845
            Width           =   555
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaRetencionIva"
            Height          =   315
            Index           =   12
            Left            =   1755
            TabIndex        =   134
            Tag             =   "Cuentas"
            Top             =   585
            Width           =   4425
            _ExtentX        =   7805
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaRetencionIvaComprobantesM"
            Height          =   315
            Index           =   52
            Left            =   2385
            TabIndex        =   380
            Tag             =   "Cuentas"
            Top             =   900
            Width           =   3795
            _ExtentX        =   6694
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label Label29 
            Alignment       =   2  'Center
            Caption         =   "Tope min"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            Height          =   240
            Left            =   3735
            TabIndex        =   400
            Top             =   1620
            Width           =   915
         End
         Begin VB.Label Label8 
            Alignment       =   2  'Center
            Caption         =   "Porc."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            Height          =   240
            Left            =   5670
            TabIndex        =   382
            Top             =   1620
            Width           =   465
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta retencion Iva comp.M :"
            Height          =   195
            Index           =   102
            Left            =   90
            TabIndex        =   381
            Top             =   945
            Width           =   2265
         End
         Begin VB.Label Label42 
            Caption         =   "Facturas M : Porcentaje de retencion a aplicar sobre el total IVA :"
            Height          =   240
            Left            =   90
            TabIndex        =   349
            Top             =   2880
            Width           =   5235
         End
         Begin VB.Label Label41 
            Caption         =   "Facturas M : Importe neto minimo para aplicar retencion  :"
            Height          =   240
            Left            =   90
            TabIndex        =   347
            Top             =   2610
            Width           =   4875
         End
         Begin VB.Line Line2 
            X1              =   0
            X2              =   6300
            Y1              =   2520
            Y2              =   2520
         End
         Begin VB.Label Label87 
            Caption         =   "Prox. certif. retencion IVA :"
            Height          =   195
            Left            =   90
            TabIndex        =   146
            Top             =   1620
            Width           =   2040
         End
         Begin VB.Label Label86 
            Alignment       =   2  'Center
            Caption         =   "min.a ret."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            Height          =   240
            Left            =   4680
            TabIndex        =   143
            Top             =   1620
            Width           =   915
         End
         Begin VB.Label Label85 
            Caption         =   "Importe total por comprobante minimo para aplicar retencion :"
            Height          =   240
            Left            =   90
            TabIndex        =   141
            Top             =   1305
            Width           =   4830
         End
         Begin VB.Label Label84 
            Caption         =   "Datos para calculo de retencion (servicios) :"
            Height          =   240
            Left            =   585
            TabIndex        =   139
            Top             =   2160
            Width           =   3075
         End
         Begin VB.Label Label83 
            Caption         =   "Datos para calculo de retencion (bienes) :"
            Height          =   240
            Left            =   585
            TabIndex        =   137
            Top             =   1890
            Width           =   3075
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta retencion Iva :"
            Height          =   195
            Index           =   12
            Left            =   90
            TabIndex        =   135
            Top             =   630
            Width           =   1680
         End
      End
      Begin VB.TextBox txtProximoNumeroOtroIngresoAlmacen 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroOtroIngresoAlmacen"
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
         Left            =   9585
         TabIndex        =   131
         Text            =   "Text7"
         Top             =   2280
         Width           =   1365
      End
      Begin VB.Frame Frame5 
         Caption         =   "Cuentas contables (Otros) : "
         Height          =   2400
         Left            =   -74865
         TabIndex        =   120
         Top             =   3045
         Width           =   5280
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaBonificaciones"
            Height          =   315
            Index           =   1
            Left            =   2205
            TabIndex        =   121
            Tag             =   "Cuentas"
            Top             =   585
            Width           =   2985
            _ExtentX        =   5265
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaCaja"
            Height          =   315
            Index           =   10
            Left            =   540
            TabIndex        =   122
            Tag             =   "Cuentas"
            Top             =   225
            Width           =   1995
            _ExtentX        =   3519
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaValores"
            Height          =   315
            Index           =   11
            Left            =   3195
            TabIndex        =   123
            Tag             =   "Cuentas"
            Top             =   225
            Width           =   1995
            _ExtentX        =   3519
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaDescuentos"
            Height          =   315
            Index           =   15
            Left            =   2205
            TabIndex        =   124
            Tag             =   "Cuentas"
            Top             =   945
            Width           =   2985
            _ExtentX        =   5265
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaDeudoresVarios"
            Height          =   315
            Index           =   45
            Left            =   2205
            TabIndex        =   314
            Tag             =   "Cuentas"
            Top             =   1305
            Width           =   2985
            _ExtentX        =   5265
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaAcreedoresVarios"
            Height          =   315
            Index           =   46
            Left            =   2205
            TabIndex        =   316
            Tag             =   "Cuentas"
            Top             =   1665
            Width           =   2985
            _ExtentX        =   5265
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaImpuestosInternos"
            Height          =   315
            Index           =   48
            Left            =   2205
            TabIndex        =   358
            Tag             =   "Cuentas"
            Top             =   2025
            Width           =   2985
            _ExtentX        =   5265
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Impuestos internos :"
            Height          =   285
            Index           =   97
            Left            =   90
            TabIndex        =   359
            Top             =   2025
            Width           =   2040
         End
         Begin VB.Label lblLabels 
            Caption         =   "Acreedores varios :"
            Height          =   285
            Index           =   89
            Left            =   90
            TabIndex        =   317
            Top             =   1665
            Width           =   2040
         End
         Begin VB.Label lblLabels 
            Caption         =   "Deudores varios :"
            Height          =   285
            Index           =   88
            Left            =   90
            TabIndex        =   315
            Top             =   1305
            Width           =   2040
         End
         Begin VB.Label lblLabels 
            Caption         =   "Bonificaciones recibidas :"
            Height          =   285
            Index           =   0
            Left            =   90
            TabIndex        =   128
            Top             =   945
            Width           =   2040
         End
         Begin VB.Label lblLabels 
            Caption         =   "Valores :"
            Height          =   285
            Index           =   13
            Left            =   2565
            TabIndex        =   127
            Top             =   225
            Width           =   645
         End
         Begin VB.Label lblLabels 
            Caption         =   "Caja :"
            Height          =   285
            Index           =   14
            Left            =   90
            TabIndex        =   126
            Top             =   225
            Width           =   465
         End
         Begin VB.Label lblLabels 
            AutoSize        =   -1  'True
            Caption         =   "Descuentos otorgados :"
            Height          =   285
            Index           =   9
            Left            =   90
            TabIndex        =   125
            Top             =   585
            Width           =   2040
         End
      End
      Begin VB.TextBox txtProximaNotaCreditoInterna 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximaNotaCreditoInterna"
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
         Left            =   9585
         TabIndex        =   118
         Top             =   4800
         Width           =   1365
      End
      Begin VB.TextBox txtProximaNotaDebitoInterna 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximaNotaDebitoInterna"
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
         Left            =   9585
         TabIndex        =   116
         Top             =   4485
         Width           =   1365
      End
      Begin VB.Frame Frame3 
         Caption         =   "Cuentas para IVA ventas : "
         Height          =   2445
         Left            =   -74865
         TabIndex        =   97
         Top             =   570
         Width           =   5280
         Begin VB.TextBox txtIVAVentasPorcentaje 
            Alignment       =   1  'Right Justify
            DataField       =   "IVAVentasPorcentaje3"
            Height          =   285
            Index           =   2
            Left            =   4635
            TabIndex        =   111
            Top             =   1665
            Width           =   555
         End
         Begin VB.TextBox txtIVAVentasPorcentaje 
            Alignment       =   1  'Right Justify
            DataField       =   "IVAVentasPorcentaje2"
            Height          =   285
            Index           =   1
            Left            =   4635
            TabIndex        =   107
            Top             =   1305
            Width           =   555
         End
         Begin VB.TextBox txtIVAVentasPorcentaje 
            Alignment       =   1  'Right Justify
            DataField       =   "IVAVentasPorcentaje1"
            Height          =   285
            Index           =   0
            Left            =   4635
            TabIndex        =   103
            Top             =   945
            Width           =   555
         End
         Begin MSDataListLib.DataCombo dcfieldsIVAVentas 
            DataField       =   "IdCuentaIvaVentas1"
            Height          =   315
            Index           =   0
            Left            =   855
            TabIndex        =   98
            Tag             =   "Cuentas"
            Top             =   945
            Width           =   3255
            _ExtentX        =   5741
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaIvaSinDiscriminar"
            Height          =   315
            Index           =   4
            Left            =   1800
            TabIndex        =   99
            Tag             =   "Cuentas"
            Top             =   225
            Width           =   3390
            _ExtentX        =   5980
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfieldsIVAVentas 
            DataField       =   "IdCuentaIvaVentas2"
            Height          =   315
            Index           =   1
            Left            =   855
            TabIndex        =   104
            Tag             =   "Cuentas"
            Top             =   1305
            Width           =   3255
            _ExtentX        =   5741
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfieldsIVAVentas 
            DataField       =   "IdCuentaIvaVentas3"
            Height          =   315
            Index           =   2
            Left            =   855
            TabIndex        =   108
            Tag             =   "Cuentas"
            Top             =   1665
            Width           =   3255
            _ExtentX        =   5741
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfieldsIVAVentas 
            DataField       =   "IdCuentaIvaVentas4"
            Height          =   315
            Index           =   3
            Left            =   855
            TabIndex        =   112
            Tag             =   "Cuentas"
            Top             =   2025
            Width           =   3255
            _ExtentX        =   5741
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.TextBox txtIVAVentasPorcentaje 
            Alignment       =   1  'Right Justify
            DataField       =   "IVAVentasPorcentaje4"
            Height          =   285
            Index           =   3
            Left            =   4635
            TabIndex        =   115
            Top             =   2025
            Width           =   555
         End
         Begin MSDataListLib.DataCombo dcfields 
            DataField       =   "IdCuentaIvaInscripto"
            Height          =   315
            Index           =   9
            Left            =   1800
            TabIndex        =   130
            Tag             =   "Cuentas"
            Top             =   585
            Width           =   3390
            _ExtentX        =   5980
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Iva debito (generico) :"
            Height          =   285
            Index           =   52
            Left            =   90
            TabIndex        =   129
            Top             =   585
            Width           =   1680
         End
         Begin VB.Label lblLabels 
            Caption         =   "Porc.:"
            Height          =   240
            Index           =   50
            Left            =   4140
            TabIndex        =   114
            Top             =   2070
            Width           =   465
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta 4:"
            Height          =   285
            Index           =   49
            Left            =   90
            TabIndex        =   113
            Top             =   2025
            Width           =   735
         End
         Begin VB.Label lblLabels 
            Caption         =   "Porc.:"
            Height          =   240
            Index           =   48
            Left            =   4140
            TabIndex        =   110
            Top             =   1710
            Width           =   465
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta 3:"
            Height          =   285
            Index           =   22
            Left            =   90
            TabIndex        =   109
            Top             =   1665
            Width           =   735
         End
         Begin VB.Label lblLabels 
            Caption         =   "Porc.:"
            Height          =   240
            Index           =   21
            Left            =   4140
            TabIndex        =   106
            Top             =   1350
            Width           =   465
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta 2:"
            Height          =   285
            Index           =   20
            Left            =   90
            TabIndex        =   105
            Top             =   1305
            Width           =   735
         End
         Begin VB.Label lblLabels 
            Caption         =   "Porc.:"
            Height          =   240
            Index           =   2
            Left            =   4140
            TabIndex        =   102
            Top             =   990
            Width           =   465
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta 1:"
            Height          =   285
            Index           =   1
            Left            =   90
            TabIndex        =   101
            Top             =   945
            Width           =   735
         End
         Begin VB.Label lblLabels 
            Caption         =   "Iva debito (cons.final) :"
            Height          =   285
            Index           =   3
            Left            =   90
            TabIndex        =   100
            Top             =   270
            Width           =   1680
         End
      End
      Begin VB.TextBox txtProximoNumeroRemito 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroRemito"
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
         Left            =   9585
         TabIndex        =   95
         Top             =   1335
         Width           =   1365
      End
      Begin VB.TextBox txtProximoNumeroOrdenCompra 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroOrdenCompra"
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
         Left            =   9585
         TabIndex        =   93
         Top             =   1650
         Width           =   1365
      End
      Begin VB.Frame Frame1 
         Caption         =   "Cuentas para IVA compras : "
         Height          =   3885
         Left            =   -69375
         TabIndex        =   52
         Top             =   570
         Width           =   5280
         Begin VB.TextBox txtIVAComprasPorcentaje 
            Alignment       =   1  'Right Justify
            DataField       =   "IVAComprasPorcentaje10"
            Height          =   285
            Index           =   9
            Left            =   4545
            TabIndex        =   89
            Top             =   3510
            Width           =   555
         End
         Begin VB.TextBox txtIVAComprasPorcentaje 
            Alignment       =   1  'Right Justify
            DataField       =   "IVAComprasPorcentaje9"
            Height          =   285
            Index           =   8
            Left            =   4545
            TabIndex        =   85
            Top             =   3150
            Width           =   555
         End
         Begin VB.TextBox txtIVAComprasPorcentaje 
            Alignment       =   1  'Right Justify
            DataField       =   "IVAComprasPorcentaje8"
            Height          =   285
            Index           =   7
            Left            =   4545
            TabIndex        =   81
            Top             =   2790
            Width           =   555
         End
         Begin VB.TextBox txtIVAComprasPorcentaje 
            Alignment       =   1  'Right Justify
            DataField       =   "IVAComprasPorcentaje7"
            Height          =   285
            Index           =   6
            Left            =   4545
            TabIndex        =   77
            Top             =   2430
            Width           =   555
         End
         Begin VB.TextBox txtIVAComprasPorcentaje 
            Alignment       =   1  'Right Justify
            DataField       =   "IVAComprasPorcentaje6"
            Height          =   285
            Index           =   5
            Left            =   4545
            TabIndex        =   73
            Top             =   2070
            Width           =   555
         End
         Begin VB.TextBox txtIVAComprasPorcentaje 
            Alignment       =   1  'Right Justify
            DataField       =   "IVAComprasPorcentaje5"
            Height          =   285
            Index           =   4
            Left            =   4545
            TabIndex        =   70
            Top             =   1710
            Width           =   555
         End
         Begin VB.TextBox txtIVAComprasPorcentaje 
            Alignment       =   1  'Right Justify
            DataField       =   "IVAComprasPorcentaje4"
            Height          =   285
            Index           =   3
            Left            =   4545
            TabIndex        =   66
            Top             =   1350
            Width           =   555
         End
         Begin VB.TextBox txtIVAComprasPorcentaje 
            Alignment       =   1  'Right Justify
            DataField       =   "IVAComprasPorcentaje3"
            Height          =   285
            Index           =   2
            Left            =   4545
            TabIndex        =   62
            Top             =   990
            Width           =   555
         End
         Begin VB.TextBox txtIVAComprasPorcentaje 
            Alignment       =   1  'Right Justify
            DataField       =   "IVAComprasPorcentaje2"
            Height          =   285
            Index           =   1
            Left            =   4545
            TabIndex        =   58
            Top             =   630
            Width           =   555
         End
         Begin VB.TextBox txtIVAComprasPorcentaje 
            Alignment       =   1  'Right Justify
            DataField       =   "IVAComprasPorcentaje1"
            Height          =   285
            Index           =   0
            Left            =   4545
            TabIndex        =   54
            Top             =   270
            Width           =   555
         End
         Begin MSDataListLib.DataCombo dcfieldsIVA 
            DataField       =   "IdCuentaIvaCompras1"
            Height          =   315
            Index           =   0
            Left            =   945
            TabIndex        =   55
            Tag             =   "Cuentas"
            Top             =   270
            Width           =   2445
            _ExtentX        =   4313
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfieldsIVA 
            DataField       =   "IdCuentaIvaCompras2"
            Height          =   315
            Index           =   1
            Left            =   945
            TabIndex        =   59
            Tag             =   "Cuentas"
            Top             =   630
            Width           =   2445
            _ExtentX        =   4313
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfieldsIVA 
            DataField       =   "IdCuentaIvaCompras3"
            Height          =   315
            Index           =   2
            Left            =   945
            TabIndex        =   63
            Tag             =   "Cuentas"
            Top             =   990
            Width           =   2445
            _ExtentX        =   4313
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfieldsIVA 
            DataField       =   "IdCuentaIvaCompras4"
            Height          =   315
            Index           =   3
            Left            =   945
            TabIndex        =   67
            Tag             =   "Cuentas"
            Top             =   1350
            Width           =   2445
            _ExtentX        =   4313
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfieldsIVA 
            DataField       =   "IdCuentaIvaCompras5"
            Height          =   315
            Index           =   4
            Left            =   945
            TabIndex        =   71
            Tag             =   "Cuentas"
            Top             =   1710
            Width           =   2445
            _ExtentX        =   4313
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfieldsIVA 
            DataField       =   "IdCuentaIvaCompras6"
            Height          =   315
            Index           =   5
            Left            =   945
            TabIndex        =   74
            Tag             =   "Cuentas"
            Top             =   2070
            Width           =   2445
            _ExtentX        =   4313
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfieldsIVA 
            DataField       =   "IdCuentaIvaCompras7"
            Height          =   315
            Index           =   6
            Left            =   945
            TabIndex        =   78
            Tag             =   "Cuentas"
            Top             =   2430
            Width           =   2445
            _ExtentX        =   4313
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfieldsIVA 
            DataField       =   "IdCuentaIvaCompras8"
            Height          =   315
            Index           =   7
            Left            =   945
            TabIndex        =   82
            Tag             =   "Cuentas"
            Top             =   2790
            Width           =   2445
            _ExtentX        =   4313
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfieldsIVA 
            DataField       =   "IdCuentaIvaCompras9"
            Height          =   315
            Index           =   8
            Left            =   945
            TabIndex        =   86
            Tag             =   "Cuentas"
            Top             =   3150
            Width           =   2445
            _ExtentX        =   4313
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo dcfieldsIVA 
            DataField       =   "IdCuentaIvaCompras10"
            Height          =   315
            Index           =   9
            Left            =   945
            TabIndex        =   90
            Tag             =   "Cuentas"
            Top             =   3510
            Width           =   2445
            _ExtentX        =   4313
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdCuenta"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta 10:"
            Height          =   240
            Index           =   45
            Left            =   90
            TabIndex        =   92
            Top             =   3555
            Width           =   780
         End
         Begin VB.Label lblLabels 
            Caption         =   "Porcentaje :"
            Height          =   240
            Index           =   44
            Left            =   3510
            TabIndex        =   91
            Top             =   3555
            Width           =   915
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta 9:"
            Height          =   240
            Index           =   43
            Left            =   90
            TabIndex        =   88
            Top             =   3195
            Width           =   780
         End
         Begin VB.Label lblLabels 
            Caption         =   "Porcentaje :"
            Height          =   240
            Index           =   42
            Left            =   3510
            TabIndex        =   87
            Top             =   3195
            Width           =   915
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta 8:"
            Height          =   240
            Index           =   41
            Left            =   90
            TabIndex        =   84
            Top             =   2835
            Width           =   780
         End
         Begin VB.Label lblLabels 
            Caption         =   "Porcentaje :"
            Height          =   240
            Index           =   40
            Left            =   3510
            TabIndex        =   83
            Top             =   2835
            Width           =   915
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta 7:"
            Height          =   240
            Index           =   39
            Left            =   90
            TabIndex        =   80
            Top             =   2475
            Width           =   780
         End
         Begin VB.Label lblLabels 
            Caption         =   "Porcentaje :"
            Height          =   240
            Index           =   38
            Left            =   3510
            TabIndex        =   79
            Top             =   2475
            Width           =   915
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta 6:"
            Height          =   240
            Index           =   37
            Left            =   90
            TabIndex        =   76
            Top             =   2115
            Width           =   780
         End
         Begin VB.Label lblLabels 
            Caption         =   "Porcentaje :"
            Height          =   240
            Index           =   36
            Left            =   3510
            TabIndex        =   75
            Top             =   2115
            Width           =   915
         End
         Begin VB.Label lblLabels 
            Caption         =   "Porcentaje :"
            Height          =   240
            Index           =   34
            Left            =   3510
            TabIndex        =   72
            Top             =   1755
            Width           =   915
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta 5:"
            Height          =   240
            Index           =   33
            Left            =   90
            TabIndex        =   69
            Top             =   1755
            Width           =   780
         End
         Begin VB.Label lblLabels 
            Caption         =   "Porcentaje :"
            Height          =   240
            Index           =   32
            Left            =   3510
            TabIndex        =   68
            Top             =   1395
            Width           =   915
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta 4:"
            Height          =   240
            Index           =   31
            Left            =   90
            TabIndex        =   65
            Top             =   1395
            Width           =   780
         End
         Begin VB.Label lblLabels 
            Caption         =   "Porcentaje :"
            Height          =   240
            Index           =   30
            Left            =   3510
            TabIndex        =   64
            Top             =   1035
            Width           =   915
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta 3:"
            Height          =   240
            Index           =   29
            Left            =   90
            TabIndex        =   61
            Top             =   1035
            Width           =   780
         End
         Begin VB.Label lblLabels 
            Caption         =   "Porcentaje :"
            Height          =   240
            Index           =   28
            Left            =   3510
            TabIndex        =   60
            Top             =   675
            Width           =   915
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta 2:"
            Height          =   240
            Index           =   27
            Left            =   90
            TabIndex        =   57
            Top             =   675
            Width           =   780
         End
         Begin VB.Label lblLabels 
            Caption         =   "Porcentaje :"
            Height          =   240
            Index           =   26
            Left            =   3510
            TabIndex        =   56
            Top             =   315
            Width           =   915
         End
         Begin VB.Label lblLabels 
            Caption         =   "Cuenta 1:"
            Height          =   240
            Index           =   25
            Left            =   90
            TabIndex        =   53
            Top             =   315
            Width           =   780
         End
      End
      Begin VB.TextBox Text2 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroCuentaContable"
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
         Left            =   9585
         TabIndex        =   50
         Top             =   3540
         Width           =   1365
      End
      Begin VB.TextBox Text1 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoComprobanteProveedorReferencia"
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
         Left            =   9585
         TabIndex        =   48
         Top             =   3225
         Width           =   1365
      End
      Begin VB.TextBox txtProximoNumeroInterno 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroInterno"
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
         Left            =   9585
         TabIndex        =   46
         Top             =   2910
         Width           =   1365
      End
      Begin VB.TextBox txtProximoNumeroInternoChequeEmitido 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroInternoChequeEmitido"
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
         Left            =   9585
         TabIndex        =   44
         Top             =   2610
         Width           =   1365
      End
      Begin VB.TextBox txtProximoAsiento 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoAsiento"
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
         Left            =   9585
         TabIndex        =   42
         Top             =   1965
         Width           =   1365
      End
      Begin VB.TextBox txtProximaListaMateriales 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximaListaMateriales"
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
         Left            =   4275
         TabIndex        =   16
         Text            =   "Text2"
         Top             =   750
         Width           =   1140
      End
      Begin VB.TextBox txtProximoNumeroRequerimiento 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroRequerimiento"
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
         Left            =   4275
         TabIndex        =   15
         Text            =   "Text3"
         Top             =   1065
         Width           =   1140
      End
      Begin VB.TextBox txtProximoPresupuesto 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoPresupuesto"
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
         Left            =   4275
         TabIndex        =   14
         Text            =   "Text4"
         Top             =   1380
         Width           =   1140
      End
      Begin VB.TextBox txtProximaComparativa 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximaComparativa"
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
         Left            =   4275
         TabIndex        =   13
         Text            =   "Text5"
         Top             =   1695
         Width           =   1140
      End
      Begin VB.TextBox txtProximoNumeroPedido 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroPedido"
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
         Left            =   4275
         TabIndex        =   12
         Text            =   "Text6"
         Top             =   2010
         Width           =   1140
      End
      Begin VB.TextBox txtProximoNumeroValeSalida 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroValeSalida"
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
         Left            =   4275
         TabIndex        =   11
         Text            =   "Text8"
         Top             =   2640
         Width           =   1140
      End
      Begin VB.TextBox txtIva1 
         Alignment       =   1  'Right Justify
         DataField       =   "Iva1"
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
         Left            =   4275
         TabIndex        =   10
         Text            =   "Text9"
         Top             =   2955
         Width           =   1140
      End
      Begin VB.TextBox txtProximoNumeroSalidaMateriales2 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroSalidaMateriales2"
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
         Left            =   4275
         TabIndex        =   9
         Text            =   "Text11"
         Top             =   3585
         Width           =   735
      End
      Begin VB.TextBox txtProximoNumeroSalidaMaterialesAObra2 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroSalidaMaterialesAObra2"
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
         Left            =   4275
         TabIndex        =   8
         Text            =   "Text12"
         Top             =   3900
         Width           =   735
      End
      Begin VB.TextBox txtProximoNumeroSalidaMaterialesParaFacturar2 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroSalidaMaterialesParaFacturar2"
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
         Left            =   4275
         TabIndex        =   7
         Text            =   "Text13"
         Top             =   4215
         Width           =   735
      End
      Begin VB.TextBox txtProximoNumeroSalidaMateriales 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroSalidaMateriales"
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
         Left            =   5040
         TabIndex        =   6
         Text            =   "Text14"
         Top             =   3585
         Width           =   1005
      End
      Begin VB.TextBox txtProximoNumeroSalidaMaterialesAObra 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroSalidaMaterialesAObra"
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
         Left            =   5040
         TabIndex        =   5
         Text            =   "Text15"
         Top             =   3900
         Width           =   1005
      End
      Begin VB.TextBox txtProximoNumeroSalidaMaterialesParaFacturar 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroSalidaMaterialesParaFacturar"
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
         Left            =   5040
         TabIndex        =   4
         Text            =   "Text16"
         Top             =   4215
         Width           =   1005
      End
      Begin VB.TextBox txtProximoNumeroAjusteStock 
         Alignment       =   1  'Right Justify
         DataField       =   "ProximoNumeroAjusteStock"
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
         Left            =   9585
         TabIndex        =   3
         Text            =   "Text1"
         Top             =   1005
         Width           =   1365
      End
      Begin RichTextLib.RichTextBox RichTextBox7 
         Height          =   825
         Left            =   -72255
         TabIndex        =   28
         Top             =   5970
         Width           =   8115
         _ExtentX        =   14314
         _ExtentY        =   1455
         _Version        =   393217
         Enabled         =   -1  'True
         ScrollBars      =   2
         TextRTF         =   $"frmParametros1.frx":08FE
      End
      Begin RichTextLib.RichTextBox RichTextBox6 
         Height          =   825
         Left            =   -72255
         TabIndex        =   29
         Top             =   5145
         Width           =   8115
         _ExtentX        =   14314
         _ExtentY        =   1455
         _Version        =   393217
         Enabled         =   -1  'True
         ScrollBars      =   2
         TextRTF         =   $"frmParametros1.frx":0978
      End
      Begin RichTextLib.RichTextBox RichTextBox5 
         Height          =   825
         Left            =   -72255
         TabIndex        =   30
         Top             =   4350
         Width           =   8115
         _ExtentX        =   14314
         _ExtentY        =   1455
         _Version        =   393217
         Enabled         =   -1  'True
         ScrollBars      =   2
         TextRTF         =   $"frmParametros1.frx":09F2
      End
      Begin RichTextLib.RichTextBox RichTextBox4 
         Height          =   825
         Left            =   -72255
         TabIndex        =   31
         Top             =   3495
         Width           =   8115
         _ExtentX        =   14314
         _ExtentY        =   1455
         _Version        =   393217
         Enabled         =   -1  'True
         ScrollBars      =   2
         TextRTF         =   $"frmParametros1.frx":0A6C
      End
      Begin RichTextLib.RichTextBox RichTextBox3 
         Height          =   825
         Left            =   -72255
         TabIndex        =   32
         Top             =   2670
         Width           =   8115
         _ExtentX        =   14314
         _ExtentY        =   1455
         _Version        =   393217
         Enabled         =   -1  'True
         ScrollBars      =   2
         TextRTF         =   $"frmParametros1.frx":0AE6
      End
      Begin RichTextLib.RichTextBox RichTextBox2 
         Height          =   825
         Left            =   -72255
         TabIndex        =   33
         Top             =   1845
         Width           =   8115
         _ExtentX        =   14314
         _ExtentY        =   1455
         _Version        =   393217
         Enabled         =   -1  'True
         ScrollBars      =   2
         TextRTF         =   $"frmParametros1.frx":0B60
      End
      Begin RichTextLib.RichTextBox RichTextBox1 
         Height          =   825
         Left            =   -72255
         TabIndex        =   34
         Top             =   1020
         Width           =   8115
         _ExtentX        =   14314
         _ExtentY        =   1455
         _Version        =   393217
         Enabled         =   -1  'True
         ScrollBars      =   2
         TextRTF         =   $"frmParametros1.frx":0BDA
      End
      Begin MSComCtl2.DTPicker DTFields 
         DataField       =   "FechaUltimoCierre"
         Height          =   330
         Index           =   0
         Left            =   -65460
         TabIndex        =   243
         Top             =   660
         Width           =   1290
         _ExtentX        =   2275
         _ExtentY        =   582
         _Version        =   393216
         Format          =   16711681
         CurrentDate     =   36377
      End
      Begin MSComCtl2.DTPicker DTFields 
         DataField       =   "FechaArranqueCajaYBancos"
         Height          =   330
         Index           =   1
         Left            =   -65460
         TabIndex        =   244
         Top             =   1290
         Width           =   1290
         _ExtentX        =   2275
         _ExtentY        =   582
         _Version        =   393216
         Format          =   16711681
         CurrentDate     =   36377
      End
      Begin VB.Frame Frame22 
         Caption         =   "Ventas en cuotas :"
         Height          =   2040
         Left            =   -74910
         TabIndex        =   259
         Top             =   5745
         Width           =   6900
         Begin VB.TextBox txtPathArchivoCobranzaCuotas 
            DataField       =   "PathArchivoCobranzaCuotas"
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
            TabIndex        =   285
            Top             =   1620
            Width           =   3525
         End
         Begin VB.TextBox txtNumeroGeneracionVentaEnCuotas 
            Alignment       =   1  'Right Justify
            DataField       =   "NumeroGeneracionVentaEnCuotas"
            Height          =   285
            Left            =   3285
            TabIndex        =   282
            Top             =   945
            Width           =   1140
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdRubroVentasEnCuotas"
            Height          =   315
            Index           =   10
            Left            =   3285
            TabIndex        =   261
            Tag             =   "Rubros"
            Top             =   225
            Width           =   3570
            _ExtentX        =   6297
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdRubro"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdConceptoVentasEnCuotas"
            Height          =   315
            Index           =   11
            Left            =   3285
            TabIndex        =   265
            Tag             =   "Conceptos"
            Top             =   585
            Width           =   3570
            _ExtentX        =   6297
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdConcepto"
            Text            =   ""
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdBancoGestionCobroCuotas"
            Height          =   315
            Index           =   12
            Left            =   3285
            TabIndex        =   284
            Tag             =   "BancosParaCobros"
            Top             =   1260
            Width           =   3570
            _ExtentX        =   6297
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdBanco"
            Text            =   ""
         End
         Begin VB.Label lblLabels 
            Caption         =   "Path de arch. p/importacion de cobros :"
            Height          =   240
            Index           =   80
            Left            =   90
            TabIndex        =   286
            Top             =   1620
            Width           =   3075
         End
         Begin VB.Label lblLabels 
            Caption         =   "Ente recaudador standar :"
            Height          =   240
            Index           =   79
            Left            =   90
            TabIndex        =   283
            Top             =   1281
            Width           =   3075
         End
         Begin VB.Label lblLabels 
            Caption         =   "Proximo numero de generacion de cuotas :"
            Height          =   240
            Index           =   76
            Left            =   90
            TabIndex        =   281
            Top             =   944
            Width           =   3075
         End
         Begin VB.Label lblLabels 
            Caption         =   "Concepto de nota debito p/vta. en cuotas :"
            Height          =   240
            Index           =   75
            Left            =   90
            TabIndex        =   266
            Top             =   607
            Width           =   3075
         End
         Begin VB.Label lblLabels 
            Caption         =   "Rubro de productos para venta en cuotas :"
            Height          =   240
            Index           =   74
            Left            =   90
            TabIndex        =   262
            Top             =   270
            Width           =   3075
         End
      End
      Begin MSComCtl2.DTPicker DTFields 
         DataField       =   "FechaUltimoCierreEjercicio"
         Height          =   330
         Index           =   2
         Left            =   -65460
         TabIndex        =   337
         Top             =   975
         Width           =   1290
         _ExtentX        =   2275
         _ExtentY        =   582
         _Version        =   393216
         Format          =   16711681
         CurrentDate     =   36377
      End
      Begin MSComCtl2.DTPicker DTFields 
         DataField       =   "FechaArranqueMovimientosStock"
         Height          =   330
         Index           =   3
         Left            =   -65460
         TabIndex        =   378
         Top             =   1605
         Width           =   1290
         _ExtentX        =   2275
         _ExtentY        =   582
         _Version        =   393216
         Format          =   16711681
         CurrentDate     =   36377
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "_IdEjercicioContableControlNumeracion"
         Height          =   315
         Index           =   4
         Left            =   4275
         TabIndex        =   464
         Tag             =   "EjerciciosContables"
         Top             =   4545
         Width           =   1770
         _ExtentX        =   3122
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdEjercicioContable"
         Text            =   ""
      End
      Begin VB.Label Label40 
         Caption         =   "Cantidad de decimales para calculos :"
         Height          =   240
         Left            =   6165
         TabIndex        =   472
         Top             =   5490
         Width           =   3210
      End
      Begin VB.Label Label36 
         Caption         =   "Ejercicio inicial para  control de numeracion de comprob."
         Height          =   240
         Left            =   135
         TabIndex        =   465
         Top             =   4545
         Width           =   4065
      End
      Begin VB.Label Label49 
         Caption         =   "Proximo certificado retencion ganancias : "
         Height          =   240
         Left            =   6165
         TabIndex        =   439
         Top             =   750
         Width           =   3255
      End
      Begin VB.Label Label52 
         Caption         =   "Proximo numero de orden de trabajo :"
         Height          =   240
         Left            =   6165
         TabIndex        =   407
         Top             =   4215
         Width           =   3255
      End
      Begin VB.Label Label100 
         Alignment       =   1  'Right Justify
         Caption         =   "Fecha arranque p/movimientos de stock :"
         Height          =   240
         Left            =   -68925
         TabIndex        =   379
         Top             =   1650
         Width           =   3390
      End
      Begin VB.Label Label99 
         Caption         =   "Proximo codigo de articulo :"
         Height          =   240
         Left            =   6165
         TabIndex        =   369
         Top             =   5160
         Width           =   2580
      End
      Begin VB.Label Label96 
         Caption         =   "Proximo numero gasto bancario :"
         Height          =   240
         Left            =   6165
         TabIndex        =   364
         Top             =   3900
         Width           =   3255
      End
      Begin VB.Label Label37 
         Alignment       =   1  'Right Justify
         Caption         =   "Fecha de ultimo cierre de ejercicio :"
         Height          =   240
         Left            =   -68115
         TabIndex        =   338
         Top             =   1050
         Width           =   2580
      End
      Begin VB.Label Label80 
         Alignment       =   1  'Right Justify
         Caption         =   "Fecha de cierre contable actual :"
         Height          =   240
         Left            =   -68115
         TabIndex        =   246
         Top             =   750
         Width           =   2580
      End
      Begin VB.Label Label34 
         Alignment       =   1  'Right Justify
         Caption         =   "Fecha arranque p/conciliaciones caja/bancos :"
         Height          =   240
         Left            =   -68925
         TabIndex        =   245
         Top             =   1350
         Width           =   3390
      End
      Begin VB.Label Label32 
         Caption         =   "Proximo numero interno de recepcion : "
         Height          =   240
         Left            =   135
         TabIndex        =   179
         Top             =   3315
         Width           =   4065
      End
      Begin VB.Label Label92 
         Caption         =   "Proximo numero de nota de pedido exterior :"
         Height          =   240
         Left            =   135
         TabIndex        =   161
         Top             =   2370
         Width           =   4065
      End
      Begin VB.Label Label82 
         Caption         =   "Proximo numero otros ingresos a almacen :"
         Height          =   240
         Left            =   6165
         TabIndex        =   132
         Top             =   2325
         Width           =   3255
      End
      Begin VB.Label Label78 
         Caption         =   "Proximo numero de nota de credito interna :"
         Height          =   240
         Left            =   6165
         TabIndex        =   119
         Top             =   4845
         Width           =   3165
      End
      Begin VB.Label Label77 
         Caption         =   "Proximo numero de nota de debito interna :"
         Height          =   240
         Left            =   6165
         TabIndex        =   117
         Top             =   4530
         Width           =   3165
      End
      Begin VB.Label Label51 
         Caption         =   "Proxima remito :"
         Height          =   195
         Left            =   6165
         TabIndex        =   96
         Top             =   1380
         Width           =   3255
      End
      Begin VB.Label Label50 
         Caption         =   "Proxima orden de compra :"
         Height          =   240
         Left            =   6165
         TabIndex        =   94
         Top             =   1695
         Width           =   3255
      End
      Begin VB.Label Label43 
         Caption         =   "Proximo codigo cuenta contable :"
         Height          =   240
         Left            =   6165
         TabIndex        =   51
         Top             =   3585
         Width           =   3255
      End
      Begin VB.Label Label26 
         Caption         =   "Proximo numero referencia comp.proveedores :"
         Height          =   240
         Left            =   6165
         TabIndex        =   49
         Top             =   3270
         Width           =   3255
      End
      Begin VB.Label Label46 
         Caption         =   "Proximo numero interno (valores) :"
         Height          =   240
         Left            =   6165
         TabIndex        =   47
         Top             =   2955
         Width           =   3255
      End
      Begin VB.Label Label44 
         Caption         =   "Proximo numero interno cheque emitido :"
         Height          =   240
         Left            =   6165
         TabIndex        =   45
         Top             =   2655
         Width           =   3255
      End
      Begin VB.Label Label25 
         Caption         =   "Proximo asiento contable :"
         Height          =   240
         Left            =   6165
         TabIndex        =   43
         Top             =   2010
         Width           =   3255
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
         Height          =   645
         Left            =   -74820
         TabIndex        =   41
         Top             =   1125
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
         Height          =   645
         Left            =   -74820
         TabIndex        =   40
         Top             =   1935
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
         Height          =   645
         Left            =   -74820
         TabIndex        =   39
         Top             =   2760
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
         Height          =   645
         Left            =   -74820
         TabIndex        =   38
         Top             =   3585
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
         Height          =   645
         Left            =   -74820
         TabIndex        =   37
         Top             =   4410
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
         Height          =   645
         Left            =   -74820
         TabIndex        =   36
         Top             =   5235
         Width           =   2460
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
         Height          =   645
         Left            =   -74820
         TabIndex        =   35
         Top             =   6060
         Width           =   2460
      End
      Begin VB.Label Label9 
         Caption         =   "Proximo numero de lista de materiales :"
         Height          =   240
         Left            =   -480
         TabIndex        =   27
         Top             =   720
         Width           =   4065
      End
      Begin VB.Label Label10 
         Caption         =   "Proximo numero de requerimiento de materiales :"
         Height          =   240
         Left            =   135
         TabIndex        =   26
         Top             =   1110
         Width           =   4065
      End
      Begin VB.Label Label11 
         Caption         =   "Proximo numero de solicitud de cotizacion :"
         Height          =   240
         Left            =   135
         TabIndex        =   25
         Top             =   1425
         Width           =   4065
      End
      Begin VB.Label Label12 
         Caption         =   "Proximo numero de comparativa :"
         Height          =   240
         Left            =   135
         TabIndex        =   24
         Top             =   1740
         Width           =   4065
      End
      Begin VB.Label Label13 
         Caption         =   "Proximo numero de nota de pedido :"
         Height          =   240
         Left            =   135
         TabIndex        =   23
         Top             =   2055
         Width           =   4065
      End
      Begin VB.Label Label15 
         Caption         =   "Proximo numero de solicitud de materiales a almacen :"
         Height          =   240
         Left            =   135
         TabIndex        =   22
         Top             =   2640
         Width           =   4065
      End
      Begin VB.Label Label16 
         Caption         =   "Porcentaje de IVA ventas :"
         Height          =   240
         Left            =   135
         TabIndex        =   21
         Top             =   3000
         Width           =   4065
      End
      Begin VB.Label Label18 
         Caption         =   "Proximo numero de salida de materiales a fabrica :"
         Height          =   240
         Left            =   135
         TabIndex        =   20
         Top             =   3630
         Width           =   4065
      End
      Begin VB.Label Label19 
         Caption         =   "Proximo numero de salida de materiales a obra : "
         Height          =   240
         Left            =   135
         TabIndex        =   19
         Top             =   3945
         Width           =   4065
      End
      Begin VB.Label Label20 
         Caption         =   "Proximo numero de salida de materiales a facturar :"
         Height          =   240
         Left            =   135
         TabIndex        =   18
         Top             =   4260
         Width           =   4065
      End
      Begin VB.Label Label24 
         Caption         =   "Proximo numero de ajuste de stock :"
         Height          =   240
         Left            =   6165
         TabIndex        =   17
         Top             =   1035
         Width           =   3255
      End
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUbicacion"
      Height          =   315
      Index           =   15
      Left            =   3720
      TabIndex        =   478
      Tag             =   "Ubicaciones"
      Top             =   600
      Visible         =   0   'False
      Width           =   3645
      _ExtentX        =   6429
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUbicacion"
      Text            =   ""
   End
   Begin VB.Label lblListaDe 
      Caption         =   "Lista de Causas de Paro:"
      Height          =   240
      Left            =   120
      TabIndex        =   481
      Top             =   2280
      Width           =   3165
   End
   Begin VB.Label lblUbicaciónDe 
      Caption         =   "Ubicación genérica de destino de Producción:"
      Height          =   255
      Index           =   0
      Left            =   120
      TabIndex        =   479
      Top             =   720
      Visible         =   0   'False
      Width           =   3435
   End
   Begin VB.Label lblProximoNumero 
      Caption         =   "Proximo numero de orden de Producción :"
      Height          =   240
      Left            =   120
      TabIndex        =   474
      Top             =   360
      Width           =   3165
   End
End
Attribute VB_Name = "frmParametros1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Parametro
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mFechaTimeStamp1 As Long
Private SelectedTab As Integer

Private Sub Check1_Click()

   If Check1.Value = 1 Then
      txtImporteTotalMinimoAplicacionRetencionIVA.Enabled = True
      txtPorcentajeBaseRetencionIVABienes.Enabled = True
      txtPorcentajeBaseRetencionIVAServicios.Enabled = True
      txtImporteMinimoRetencionIVA.Enabled = True
      txtProximoNumeroCertificadoRetencionIVA.Enabled = True
   Else
      With origen.Registro
         .Fields("ImporteTotalMinimoAplicacionRetencionIVA").Value = 0
         .Fields("PorcentajeBaseRetencionIVABienes").Value = 0
         .Fields("PorcentajeBaseRetencionIVAServicios").Value = 0
         .Fields("ImporteMinimoRetencionIVA").Value = 0
      End With
      txtImporteTotalMinimoAplicacionRetencionIVA.Enabled = False
      txtPorcentajeBaseRetencionIVABienes.Enabled = False
      txtPorcentajeBaseRetencionIVAServicios.Enabled = False
      txtImporteMinimoRetencionIVA.Enabled = False
      txtProximoNumeroCertificadoRetencionIVA.Enabled = False
   End If
   
End Sub

Private Sub Check11_Click(Index As Integer)

   If Check11(Index).Value = 1 Then
      dcfields1(Index).Enabled = True
   Else
      origen.Registro.Fields(dcfields1(Index).DataField).Value = Null
      dcfields1(Index).Enabled = False
   End If
   
End Sub

Private Sub Check15_Click()

   If Check15.Value = 1 Then
      txtOtrasPercepciones3Desc.Enabled = True
      dcfields(50).Enabled = True
   Else
      With txtOtrasPercepciones3Desc
         .Text = ""
         .Enabled = False
      End With
      dcfields(50).Enabled = False
      With origen.Registro
         .Fields("OtrasPercepciones3Desc").Value = ""
         .Fields("IdCuentaOtrasPercepciones3").Value = Null
      End With
   End If
   
End Sub

Private Sub Check28_Click()

   If Check28.Value = 1 Then
      DataCombo1(28).Enabled = True
   Else
      With DataCombo1(28)
         .BoundText = ""
         .Text = ""
         .Enabled = False
      End With
   End If

End Sub

Private Sub Check3_Click()

   If Check3.Value = 1 Then
      txtOtrasPercepciones1Desc.Enabled = True
      dcfields(35).Enabled = True
   Else
      With txtOtrasPercepciones1Desc
         .Text = ""
         .Enabled = False
      End With
      dcfields(35).Enabled = False
      With origen.Registro
         .Fields("OtrasPercepciones1Desc").Value = ""
         .Fields("IdCuentaOtrasPercepciones1").Value = Null
      End With
   End If
   
End Sub

Private Sub Check4_Click()

   If Check4.Value = 1 Then
      txtOtrasPercepciones2Desc.Enabled = True
      dcfields(36).Enabled = True
   Else
      With txtOtrasPercepciones2Desc
         .Text = ""
         .Enabled = False
      End With
      dcfields(36).Enabled = False
      With origen.Registro
         .Fields("OtrasPercepciones2Desc").Value = ""
         .Fields("IdCuentaOtrasPercepciones2").Value = Null
      End With
   End If
   
End Sub

Private Sub Check8_Click()

   If Check8.Value = 1 Then
      txtPorcentajeRetencionSUSS.Enabled = True
      txtProximoNumeroCertificadoRetencionSUSS.Enabled = True
      dcfields(34).Enabled = True
   Else
      With origen.Registro
         .Fields("PorcentajeRetencionSUSS").Value = 0
         .Fields("ProximoNumeroCertificadoRetencionSUSS").Value = 0
         .Fields("IdCuentaRetencionSUSS").Value = Null
      End With
      txtPorcentajeRetencionSUSS.Enabled = False
      txtProximoNumeroCertificadoRetencionSUSS.Enabled = False
      dcfields(34).Enabled = False
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
      
         With origen.Registro
            
            .Fields("ControlCalidadDefault").Value = .Fields("IdControlCalidadStandar").Value
            
            Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorIdConTimeStamp", 1)
            If oRs.Fields("FechaTimeStamp1").Value <> mFechaTimeStamp1 Then
               MsgBox "No se grabaron los datos porque otro usuario ha modificado algun" & vbCrLf & _
                        "parametro antes que usted, intentelo de nuevo", vbCritical
               oRs.Close
               GoTo Salida
            End If
            oRs.Close
            
            For Each oControl In Me.Controls
               If TypeOf oControl Is CommandButton Then
               ElseIf TypeOf oControl Is RichTextBox Then
                  If Len(oControl.DataField) Then
                     If oControl.DataField = "PedidosImportante" Then
                        .Fields(oControl.DataField).Value = oControl.TextRTF
                     Else
                        .Fields(oControl.DataField).Value = oControl.Text
                     End If
                  End If
               ElseIf TypeOf oControl Is TextBox Then
                  If Len(oControl.DataField) Then
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
         
            For Each dc In DataCombo2
               If dc.Enabled Then
                  If Len(dc.BoundText) <> 0 And mId(dc.DataField, 1, 1) <> "_" Then
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
            
            For Each dc In dcfieldsIVA
               If dc.Enabled Then
                  If IsNumeric(dc.BoundText) And mId(dc.DataField, 1, 1) <> "_" Then
                     .Fields(dc.DataField).Value = dc.BoundText
                  End If
               End If
            Next
            
            For Each dc In dcfieldsIVAVentas
               If dc.Enabled Then
                  If IsNumeric(dc.BoundText) And mId(dc.DataField, 1, 1) <> "_" Then
                     .Fields(dc.DataField).Value = dc.BoundText
                  End If
               End If
            Next
         
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
            
            gblFechaUltimoCierre = .Fields("FechaUltimoCierre").Value
            
            If Check1.Value = 1 Then
               .Fields("AgenteRetencionIVA").Value = "SI"
            Else
               .Fields("AgenteRetencionIVA").Value = "NO"
            End If
         
            If Check2.Value = 1 Then
               .Fields("PercepcionIIBB").Value = "SI"
            Else
               .Fields("PercepcionIIBB").Value = "NO"
            End If
         
            If Check3.Value = 1 Then
               .Fields("OtrasPercepciones1").Value = "SI"
            Else
               .Fields("OtrasPercepciones1").Value = "NO"
            End If
         
            If Check4.Value = 1 Then
               .Fields("OtrasPercepciones2").Value = "SI"
            Else
               .Fields("OtrasPercepciones2").Value = "NO"
            End If
         
            If Check15.Value = 1 Then
               .Fields("OtrasPercepciones3").Value = "SI"
            Else
               .Fields("OtrasPercepciones3").Value = "NO"
            End If
         
            If Check5.Value = 1 Then
               .Fields("NumeroReciboPagoAutomatico").Value = "SI"
            Else
               .Fields("NumeroReciboPagoAutomatico").Value = "NO"
            End If
         
            If Check6.Value = 1 Then
               .Fields("ConfirmarClausulaDolar").Value = "SI"
            Else
               .Fields("ConfirmarClausulaDolar").Value = "NO"
            End If
         
            If Check7.Value = 1 Then
               .Fields("ExigirTrasabilidad_RMLA_PE").Value = "SI"
            Else
               .Fields("ExigirTrasabilidad_RMLA_PE").Value = "NO"
            End If
         
            If Check8.Value = 1 Then
               .Fields("AgenteRetencionSUSS").Value = "SI"
            Else
               .Fields("AgenteRetencionSUSS").Value = "NO"
            End If
         
            If Check9.Value = 1 Then
               .Fields("AgenteRetencionIIBB").Value = "SI"
            Else
               .Fields("AgenteRetencionIIBB").Value = "NO"
            End If
         
            If Check10.Value = 1 Then
               .Fields("ControlarRubrosContablesEnOP").Value = "SI"
            Else
               .Fields("ControlarRubrosContablesEnOP").Value = "NO"
            End If
            If Check29.Value = 1 Then
               GuardarValorParametro2 "ControlarRubrosContablesEnCP", "SI"
            Else
               GuardarValorParametro2 "ControlarRubrosContablesEnCP", "NO"
            End If
         
            If Option1.Value Then
               .Fields("NumeracionUnica").Value = "NO"
            Else
               .Fields("NumeracionUnica").Value = "SI"
            End If
         
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
         
            If Check12.Value = 1 Then
               .Fields("EmiteAsientoEnOP").Value = "SI"
            Else
               .Fields("EmiteAsientoEnOP").Value = "NO"
            End If
         
            If Check13.Value = 1 Then
               .Fields("IvaCompras_DesglosarNOGRAVADOS").Value = "SI"
            Else
               .Fields("IvaCompras_DesglosarNOGRAVADOS").Value = "NO"
            End If
         
            If Check14.Value = 1 Then
               .Fields("Subdiarios_ResumirRegistros").Value = "SI"
            Else
               .Fields("Subdiarios_ResumirRegistros").Value = "NO"
            End If
            
            If Check16.Value = 1 Then
               .Fields("ActivarCircuitoChequesDiferidos").Value = "SI"
               glbActivarCircuitoChequesDiferidos = "SI"
            Else
               .Fields("ActivarCircuitoChequesDiferidos").Value = "NO"
               glbActivarCircuitoChequesDiferidos = "NO"
            End If
            
            If Len(txtPathPlantillas.Text) > 0 Then
               glbPathPlantillas = txtPathPlantillas.Text
            Else
               glbPathPlantillas = App.Path & "\Plantillas"
            End If
         
            .Fields("PedidosPlazoEntrega").Value = RichTextBox1.Text
            .Fields("PedidosLugarEntrega").Value = RichTextBox2.Text
            .Fields("PedidosFormaPago").Value = RichTextBox3.Text
            .Fields("PedidosDocumentacion").Value = RichTextBox4.Text
            .Fields("PedidosGarantia").Value = RichTextBox5.Text
            .Fields("PedidosInspecciones").Value = RichTextBox6.Text
            .Fields("PedidosImportante").Value = RichTextBox7.Text
      
            If Check21.Value = 1 Then
               .Fields("ActivarSolicitudMateriales").Value = "SI"
               glbActivarSolicitudMateriales = "SI"
            Else
               .Fields("ActivarSolicitudMateriales").Value = Null
               glbActivarSolicitudMateriales = "NO"
            End If
         
            If Check25.Value = 1 Then
               GuardarValorParametro2 "NumeracionAutomaticaDeOrdenesDePago", "SI"
            Else
               GuardarValorParametro2 "NumeracionAutomaticaDeOrdenesDePago", "NO"
            End If
            If Check30.Value = 1 Then
               GuardarValorParametro2 "NumeracionIndependienteDeOrdenesDePagoFFyCTACTE", "SI"
            Else
               GuardarValorParametro2 "NumeracionIndependienteDeOrdenesDePagoFFyCTACTE", "NO"
            End If

'            If Option3(0).Value Then
'               GuardarValorParametro2 "AprobacionesRM", 1
'            Else
'               GuardarValorParametro2 "AprobacionesRM", 2
'            End If

            If Check26.Value = 1 Then
               GuardarValorParametro2 "SoloUsuarioConectadoEnArbolAutorizaciones", "SI"
            Else
               GuardarValorParametro2 "SoloUsuarioConectadoEnArbolAutorizaciones", "NO"
            End If
            
            
            
            If Option4.Value Then
               GuardarValorParametro2 "LiberarRMCircuito", "NO"
            Else
               GuardarValorParametro2 "LiberarRMCircuito", "SI"
            End If
         
            If Option3(0).Value Then
               GuardarValorParametro2 "SectorEmisorEnPedidos", "LIB"
            Else
               GuardarValorParametro2 "SectorEmisorEnPedidos", "RM"
            End If
         
            If Check27.Value = 1 Then
               GuardarValorParametro2 "AsignarLiberadorComoCompradorEnRM", "SI"
            Else
               GuardarValorParametro2 "AsignarLiberadorComoCompradorEnRM", "NO"
            End If
            
            If Check17.Value = 1 Then
               GuardarValorParametro2 "DesactivarDarPorCumplidoPedidoSinRecepcionEnCP", "SI"
            Else
               GuardarValorParametro2 "DesactivarDarPorCumplidoPedidoSinRecepcionEnCP", "NO"
            End If
            
            If Check18.Value = 1 Then
               GuardarValorParametro2 "LimitarEquiposDestinoSegunEtapasDeObra", "SI"
            Else
               GuardarValorParametro2 "LimitarEquiposDestinoSegunEtapasDeObra", "NO"
            End If
         
            glbIdiomaActual = "esp"
            If Combo1(0).ListIndex >= 0 Then
               Select Case Combo1(0).ListIndex
                  Case 1
                     glbIdiomaActual = "ing"
                  Case 2
                     glbIdiomaActual = "por"
               End Select
            End If
            GuardarValorParametro2 "Lenguaje", glbIdiomaActual
            '////////////////////////////////////////////////////////////////////////
         
         
         
         
         
            GuardarValorParametro2 "ProximoNumeroProduccionOrden", Text3
            GuardarValorParametro2 "IdUbicacionDestinoProduccionGenerico", DataCombo1(1).BoundText
            GuardarValorParametro2 "ListaCausasDeParo", ListaCausasDeParo
         
         
         
         
         
         
         
         
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
      
      Case 2
   
         'Dim oF As frmParametros2
         'Set oF = New frmParametros2
         'With oF
         '   Set .Parametros = origen
         '   .Id = 1
         '   .Show vbModal, Me
         'End With
         'Set origen = oF.Parametros
         'Unload oF
         'Set oF = Nothing
         'Exit Sub
   
   End Select
   
Salida:

   Set oRs = Nothing
   
   Unload Me

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim i As Integer
   Dim mAux1 As Variant
   
   mvarId = vnewvalue
   
   If BuscarClaveINI("Numerar certificados de ganancias por categoria") = "SI" Then
      Label49.Visible = False
      txtProximoNumeroCertificadoRetencionGanancias.Visible = False
   End If
   
   If BuscarClaveINI("Numerar certificados de impuestos directos por categoria") = "SI" Then
      Label93.Visible = False
      txtProximoNumeroCertificadoRetencionSUSS.Visible = False
   End If
   
   Set oAp = Aplicacion
   
   Set origen = oAp.Parametros.Item(1)
  
   Set oBind = New BindingCollection
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
         ElseIf TypeOf oControl Is label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then
               If mId(oControl.DataField, 1, 1) <> "_" Then
                  Set oControl.DataSource = origen
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
               ElseIf oControl.Tag = "EjerciciosContables" Then
                  Set oControl.RowSource = oAp.EjerciciosContables.TraerLista
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
   
   With origen.Registro
      If IsNull(.Fields("AgenteRetencionIVA").Value) Or _
            .Fields("AgenteRetencionIVA").Value = "SI" Then
         Check1.Value = 1
      Else
         Check1.Value = 0
      End If
      If IsNull(.Fields("PercepcionIIBB").Value) Or _
            .Fields("PercepcionIIBB").Value = "SI" Then
         Check2.Value = 1
      Else
         Check2.Value = 0
      End If
      If IsNull(.Fields("OtrasPercepciones1").Value) Or _
            .Fields("OtrasPercepciones1").Value = "SI" Then
         Check3.Value = 1
      Else
         Check3.Value = 0
         txtOtrasPercepciones1Desc.Enabled = False
         dcfields(35).Enabled = False
      End If
      If IsNull(.Fields("OtrasPercepciones2").Value) Or _
            .Fields("OtrasPercepciones2").Value = "SI" Then
         Check4.Value = 1
      Else
         Check4.Value = 0
         txtOtrasPercepciones2Desc.Enabled = False
         dcfields(36).Enabled = False
      End If
      If IsNull(.Fields("OtrasPercepciones3").Value) Or _
            .Fields("OtrasPercepciones3").Value = "SI" Then
         Check15.Value = 1
      Else
         Check15.Value = 0
         txtOtrasPercepciones3Desc.Enabled = False
         dcfields(50).Enabled = False
      End If
      If IsNull(.Fields("NumeroReciboPagoAutomatico").Value) Or _
            .Fields("NumeroReciboPagoAutomatico").Value = "SI" Then
         Check5.Value = 1
      Else
         Check5.Value = 0
      End If
      If IsNull(.Fields("ConfirmarClausulaDolar").Value) Or _
            .Fields("ConfirmarClausulaDolar").Value = "SI" Then
         Check6.Value = 1
      Else
         Check6.Value = 0
      End If
      If IsNull(.Fields("ExigirTrasabilidad_RMLA_PE").Value) Or _
            .Fields("ExigirTrasabilidad_RMLA_PE").Value = "SI" Then
         Check7.Value = 1
      Else
         Check7.Value = 0
      End If
      If IsNull(.Fields("AgenteRetencionSUSS").Value) Or _
            .Fields("AgenteRetencionSUSS").Value = "SI" Then
         Check8.Value = 1
      Else
         Check8.Value = 0
      End If
      If IsNull(.Fields("AgenteRetencionIIBB").Value) Or _
            .Fields("AgenteRetencionIIBB").Value = "SI" Then
         Check9.Value = 1
      Else
         Check9.Value = 0
      End If
      If IsNull(.Fields("ControlarRubrosContablesEnOP").Value) Or _
            .Fields("ControlarRubrosContablesEnOP").Value = "SI" Then
         Check10.Value = 1
      Else
         Check10.Value = 0
      End If
      If IsNull(.Fields("NumeracionUnica").Value) Or _
            .Fields("NumeracionUnica").Value = "NO" Then
         Option1.Value = True
      Else
         Option2.Value = True
      End If
      For i = 1 To 5
         If Not IsNull(.Fields("IdCuentaAdicionalIVACompras" & i).Value) Then
            Check11(i - 1).Value = 1
            dcfields1(i - 1).Enabled = True
         Else
            Check11(i - 1).Value = 0
            dcfields1(i - 1).Enabled = False
         End If
      Next
      If IsNull(.Fields("EmiteAsientoEnOP").Value) Or _
            .Fields("EmiteAsientoEnOP").Value = "NO" Then
         Check12.Value = 0
      Else
         Check12.Value = 1
      End If
      If Not IsNull(.Fields("IvaCompras_DesglosarNOGRAVADOS").Value) And _
            .Fields("IvaCompras_DesglosarNOGRAVADOS").Value = "SI" Then
         Check13.Value = 1
      Else
         Check13.Value = 0
      End If
      If IsNull(.Fields("Subdiarios_ResumirRegistros").Value) Or _
            .Fields("Subdiarios_ResumirRegistros").Value = "SI" Then
         Check14.Value = 1
      Else
         Check14.Value = 0
      End If
      If Not IsNull(.Fields("ActivarCircuitoChequesDiferidos").Value) And _
            .Fields("ActivarCircuitoChequesDiferidos").Value = "SI" Then
         Check16.Value = 1
      Else
         Check16.Value = 0
      End If
      RichTextBox1.TextRTF = IIf(IsNull(.Fields("PedidosPlazoEntrega").Value), "", .Fields("PedidosPlazoEntrega").Value)
      RichTextBox2.TextRTF = IIf(IsNull(.Fields("PedidosLugarEntrega").Value), "", .Fields("PedidosLugarEntrega").Value)
      RichTextBox3.TextRTF = IIf(IsNull(.Fields("PedidosFormaPago").Value), "", .Fields("PedidosFormaPago").Value)
      RichTextBox4.TextRTF = IIf(IsNull(.Fields("PedidosDocumentacion").Value), "", .Fields("PedidosDocumentacion").Value)
      RichTextBox5.TextRTF = IIf(IsNull(.Fields("PedidosGarantia").Value), "", .Fields("PedidosGarantia").Value)
      RichTextBox6.TextRTF = IIf(IsNull(.Fields("PedidosInspecciones").Value), "", .Fields("PedidosInspecciones").Value)
      RichTextBox7.TextRTF = IIf(IsNull(.Fields("PedidosImportante").Value), "", .Fields("PedidosImportante").Value)
   
      If Not IsNull(.Fields("ActivarSolicitudMateriales").Value) And _
            .Fields("ActivarSolicitudMateriales").Value = "SI" Then
         Check21.Value = 1
      End If

      mAux1 = TraerValorParametro2("NumeracionAutomaticaDeOrdenesDePago")
      If Not IsNull(mAux1) And mAux1 = "SI" Then
         Check25.Value = 1
      Else
         Check25.Value = 0
      End If
      mAux1 = TraerValorParametro2("NumeracionIndependienteDeOrdenesDePagoFFyCTACTE")
      If Not IsNull(mAux1) And mAux1 = "SI" Then
         Check30.Value = 1
      Else
         Check30.Value = 0
      End If

'      mAux1 = TraerValorParametro2("AprobacionesRM")
'      If IsNull(mAux1) Or mAux1 = "1" Then
'         Option3(0).Value = True
'      Else
'         Option3(1).Value = True
'      End If
   
      mAux1 = TraerValorParametro2("LiberarRMCircuito")
      If IsNull(mAux1) Or mAux1 = "NO" Then
         Option4.Value = True
      Else
         Option5.Value = True
      End If
   
      mAux1 = TraerValorParametro2("SoloUsuarioConectadoEnArbolAutorizaciones")
      If Not IsNull(mAux1) And mAux1 = "SI" Then
         Check26.Value = 1
      Else
         Check26.Value = 0
      End If
   
      mAux1 = TraerValorParametro2("SectorEmisorEnPedidos")
      If Not IsNull(mAux1) And mAux1 = "LIB" Then
         Option3(0).Value = True
      Else
         Option3(1).Value = True
      End If
   
      mAux1 = TraerValorParametro2("AsignarLiberadorComoCompradorEnRM")
      If Not IsNull(mAux1) And mAux1 = "SI" Then
         Check27.Value = 1
      Else
         Check27.Value = 0
      End If
   
      Text3 = TraerValorParametro2("ProximoNumeroProduccionOrden")
      

   
      mAux1 = TraerValorParametro2("IdObraParaOTOP")
      If Not IsNull(mAux1) And IsNumeric(mAux1) Then
         Check28.Value = 1
      Else
         Check28.Value = 0
      End If
   
      mAux1 = TraerValorParametro2("ControlarRubrosContablesEnCP")
      If Not IsNull(mAux1) And mAux1 = "SI" Then
         Check29.Value = 1
      Else
         Check29.Value = 0
      End If
   
      mAux1 = TraerValorParametro2("DesactivarDarPorCumplidoPedidoSinRecepcionEnCP")
      If Not IsNull(mAux1) And mAux1 = "SI" Then
         Check17.Value = 1
      Else
         Check17.Value = 0
      End If
   
      mAux1 = TraerValorParametro2("LimitarEquiposDestinoSegunEtapasDeObra")
      If Not IsNull(mAux1) And mAux1 = "SI" Then
         Check18.Value = 1
      Else
         Check18.Value = 0
      End If

      mAux1 = TraerValorParametro2("Lenguaje")
      If Not IsNull(mAux1) Then
         Select Case mAux1
            Case "esp"
               Combo1(0).ListIndex = 0
            Case "ing"
               Combo1(0).ListIndex = 1
            Case "por"
               Combo1(0).ListIndex = 2
         End Select
      End If
   End With
   
   Set DataCombo1(15).RowSource = Aplicacion.CargarLista("Ubicaciones")
   DataCombo1(1) = TraerValorParametro2("IdUbicacionDestinoProduccionGenerico")
   ListaCausasDeParo = TraerValorParametro2("ListaCausasDeParo")
   
   
   Set oRs = oAp.Parametros.TraerFiltrado("_PorIdConTimeStamp", 1)
   mFechaTimeStamp1 = oRs.Fields("FechaTimeStamp1").Value
   oRs.Close
   
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

   'Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set origen = Nothing
   Set oBind = Nothing

End Sub

Private Sub txtImporteMinimoRetencionIVAServicios_GotFocus()

   With txtImporteMinimoRetencionIVAServicios
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImporteMinimoRetencionIVAServicios_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtIva1_GotFocus()

   With txtIva1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtIva1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtIVAComprasPorcentaje_Change(Index As Integer)

   If Len(txtIVAComprasPorcentaje(Index).Text) = 0 Or Val(txtIVAComprasPorcentaje(Index).Text) = 0 Then
      origen.Registro.Fields(dcfieldsIVA(Index).DataField).Value = Null
   End If
   
End Sub

Private Sub txtIVAVentasPorcentaje_Change(Index As Integer)

   If Len(txtIVAVentasPorcentaje(Index).Text) = 0 Or Val(txtIVAVentasPorcentaje(Index).Text) = 0 Then
      origen.Registro.Fields(dcfieldsIVAVentas(Index).DataField).Value = Null
   End If
   
End Sub

Private Sub txtOtrasPercepciones1Desc_GotFocus()

   With txtOtrasPercepciones1Desc
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtOtrasPercepciones1Desc_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtOtrasPercepciones1Desc
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtOtrasPercepciones2Desc_GotFocus()

   With txtOtrasPercepciones2Desc
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtOtrasPercepciones2Desc_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtOtrasPercepciones2Desc
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtOtrasPercepciones3Desc_GotFocus()

   With txtOtrasPercepciones3Desc
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtOtrasPercepciones3Desc_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtOtrasPercepciones3Desc
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtPathImportacionDatos_GotFocus()


End Sub

Private Sub txtPathImportacionDatos_KeyPress(KeyAscii As Integer)


End Sub

Private Sub txtProximaComparativa_GotFocus()

   With txtProximaComparativa
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximaComparativa_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

'Private Sub txtProximaListaAcopio_GotFocus()
'
'   With txtProximaListaAcopio
'      .SelStart = 0
'      .SelLength = Len(.Text)
'   End With
'
'End Sub
'
'Private Sub txtProximaListaAcopio_KeyPress(KeyAscii As Integer)
'
'   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
'
'End Sub

Private Sub txtProximaListaMateriales_GotFocus()

   With txtProximaListaMateriales
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximaListaMateriales_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtProximaOrdenPagoFF_GotFocus()

   With txtProximaOrdenPagoFF
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximaOrdenPagoFF_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtProximoNumeroAjusteStock_GotFocus()

   With txtProximoNumeroAjusteStock
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximoNumeroAjusteStock_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtProximoNumeroPedido_GotFocus()

   With txtProximoNumeroPedido
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximoNumeroPedido_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtProximoNumeroRequerimiento_GotFocus()

   With txtProximoNumeroRequerimiento
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximoNumeroRequerimiento_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtProximoNumeroSalidaMateriales_GotFocus()

   With txtProximoNumeroSalidaMateriales
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximoNumeroSalidaMateriales_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtProximoNumeroSalidaMateriales2_GotFocus()

   With txtProximoNumeroSalidaMateriales2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximoNumeroSalidaMateriales2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtProximoNumeroSalidaMaterialesAObra_GotFocus()

   With txtProximoNumeroSalidaMaterialesAObra
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximoNumeroSalidaMaterialesAObra_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtProximoNumeroSalidaMaterialesAObra2_GotFocus()

   With txtProximoNumeroSalidaMaterialesAObra2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximoNumeroSalidaMaterialesAObra2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtProximoNumeroSalidaMaterialesParaFacturar_GotFocus()

   With txtProximoNumeroSalidaMaterialesParaFacturar
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximoNumeroSalidaMaterialesParaFacturar_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtProximoNumeroSalidaMaterialesParaFacturar2_GotFocus()

   With txtProximoNumeroSalidaMaterialesParaFacturar2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximoNumeroSalidaMaterialesParaFacturar2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtProximoNumeroValeSalida_GotFocus()

   With txtProximoNumeroValeSalida
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximoNumeroValeSalida_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtProximoPresupuesto_GotFocus()

   With txtProximoPresupuesto
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximoPresupuesto_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
