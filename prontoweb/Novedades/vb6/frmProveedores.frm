VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{F09A78C8-7814-11D2-8355-4854E82A9183}#1.1#0"; "CUIT32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmProveedores 
   Caption         =   "Proveedores"
   ClientHeight    =   6960
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   Icon            =   "frmProveedores.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   6960
   ScaleWidth      =   11880
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   23
      Top             =   6480
      Width           =   1080
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   6360
      Left            =   90
      TabIndex        =   26
      Top             =   45
      Width           =   11670
      _ExtentX        =   20585
      _ExtentY        =   11218
      _Version        =   393216
      Tabs            =   5
      TabsPerRow      =   5
      TabHeight       =   794
      TabCaption(0)   =   "Datos generales"
      TabPicture(0)   =   "frmProveedores.frx":076A
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "lblData(7)"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "lblFieldLabel(36)"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "lblFieldLabel(35)"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "lblFieldLabel(17)"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "lblFieldLabel(11)"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).Control(5)=   "lblFieldLabel(10)"
      Tab(0).Control(5).Enabled=   0   'False
      Tab(0).Control(6)=   "lblFieldLabel(9)"
      Tab(0).Control(6).Enabled=   0   'False
      Tab(0).Control(7)=   "lblFieldLabel(5)"
      Tab(0).Control(7).Enabled=   0   'False
      Tab(0).Control(8)=   "lblData(0)"
      Tab(0).Control(8).Enabled=   0   'False
      Tab(0).Control(9)=   "lblFieldLabel(3)"
      Tab(0).Control(9).Enabled=   0   'False
      Tab(0).Control(10)=   "lblFieldLabel(2)"
      Tab(0).Control(10).Enabled=   0   'False
      Tab(0).Control(11)=   "lblData(9)"
      Tab(0).Control(11).Enabled=   0   'False
      Tab(0).Control(12)=   "lblFieldLabel(21)"
      Tab(0).Control(12).Enabled=   0   'False
      Tab(0).Control(13)=   "lblFieldLabel(14)"
      Tab(0).Control(13).Enabled=   0   'False
      Tab(0).Control(14)=   "lblData(6)"
      Tab(0).Control(14).Enabled=   0   'False
      Tab(0).Control(15)=   "lblFieldLabel(15)"
      Tab(0).Control(15).Enabled=   0   'False
      Tab(0).Control(16)=   "lblData(4)"
      Tab(0).Control(16).Enabled=   0   'False
      Tab(0).Control(17)=   "lblData(3)"
      Tab(0).Control(17).Enabled=   0   'False
      Tab(0).Control(18)=   "lblData(2)"
      Tab(0).Control(18).Enabled=   0   'False
      Tab(0).Control(19)=   "lblFieldLabel(22)"
      Tab(0).Control(19).Enabled=   0   'False
      Tab(0).Control(20)=   "lblData(11)"
      Tab(0).Control(20).Enabled=   0   'False
      Tab(0).Control(21)=   "lblLabels(0)"
      Tab(0).Control(21).Enabled=   0   'False
      Tab(0).Control(22)=   "lblData(1)"
      Tab(0).Control(22).Enabled=   0   'False
      Tab(0).Control(23)=   "lblFieldLabel(12)"
      Tab(0).Control(23).Enabled=   0   'False
      Tab(0).Control(24)=   "lblFieldLabel(0)"
      Tab(0).Control(24).Enabled=   0   'False
      Tab(0).Control(25)=   "lblFieldLabel(1)"
      Tab(0).Control(25).Enabled=   0   'False
      Tab(0).Control(26)=   "lblFieldLabel(18)"
      Tab(0).Control(26).Enabled=   0   'False
      Tab(0).Control(27)=   "lblData(15)"
      Tab(0).Control(27).Enabled=   0   'False
      Tab(0).Control(28)=   "lblFieldLabel(27)"
      Tab(0).Control(28).Enabled=   0   'False
      Tab(0).Control(29)=   "lblData(13)"
      Tab(0).Control(29).Enabled=   0   'False
      Tab(0).Control(30)=   "DataCombo1(13)"
      Tab(0).Control(30).Enabled=   0   'False
      Tab(0).Control(31)=   "DTPicker2(2)"
      Tab(0).Control(31).Enabled=   0   'False
      Tab(0).Control(32)=   "Frame3"
      Tab(0).Control(32).Enabled=   0   'False
      Tab(0).Control(33)=   "DataCombo1(11)"
      Tab(0).Control(33).Enabled=   0   'False
      Tab(0).Control(34)=   "rchObservaciones"
      Tab(0).Control(34).Enabled=   0   'False
      Tab(0).Control(35)=   "DataCombo1(1)"
      Tab(0).Control(35).Enabled=   0   'False
      Tab(0).Control(36)=   "CUIT1"
      Tab(0).Control(36).Enabled=   0   'False
      Tab(0).Control(37)=   "DataCombo1(3)"
      Tab(0).Control(37).Enabled=   0   'False
      Tab(0).Control(38)=   "DataCombo1(2)"
      Tab(0).Control(38).Enabled=   0   'False
      Tab(0).Control(39)=   "DTPicker1(1)"
      Tab(0).Control(39).Enabled=   0   'False
      Tab(0).Control(40)=   "DataCombo1(6)"
      Tab(0).Control(40).Enabled=   0   'False
      Tab(0).Control(41)=   "DataCombo1(4)"
      Tab(0).Control(41).Enabled=   0   'False
      Tab(0).Control(42)=   "DTPicker1(0)"
      Tab(0).Control(42).Enabled=   0   'False
      Tab(0).Control(43)=   "DataCombo1(7)"
      Tab(0).Control(43).Enabled=   0   'False
      Tab(0).Control(44)=   "DataCombo1(9)"
      Tab(0).Control(44).Enabled=   0   'False
      Tab(0).Control(45)=   "DataCombo1(0)"
      Tab(0).Control(45).Enabled=   0   'False
      Tab(0).Control(46)=   "txtPaginaWeb"
      Tab(0).Control(46).Enabled=   0   'False
      Tab(0).Control(47)=   "txtTelefono2"
      Tab(0).Control(47).Enabled=   0   'False
      Tab(0).Control(48)=   "txtNombreFantasia"
      Tab(0).Control(48).Enabled=   0   'False
      Tab(0).Control(49)=   "txtEmail"
      Tab(0).Control(49).Enabled=   0   'False
      Tab(0).Control(50)=   "txtFax"
      Tab(0).Control(50).Enabled=   0   'False
      Tab(0).Control(51)=   "txtTelefono"
      Tab(0).Control(51).Enabled=   0   'False
      Tab(0).Control(52)=   "txtCodigoPostal"
      Tab(0).Control(52).Enabled=   0   'False
      Tab(0).Control(53)=   "txtDireccion"
      Tab(0).Control(53).Enabled=   0   'False
      Tab(0).Control(54)=   "txtRazonSocial"
      Tab(0).Control(54).Enabled=   0   'False
      Tab(0).Control(55)=   "txtLimiteCredito"
      Tab(0).Control(55).Enabled=   0   'False
      Tab(0).Control(56)=   "Frame1"
      Tab(0).Control(56).Enabled=   0   'False
      Tab(0).Control(57)=   "txtCodigoProveedor"
      Tab(0).Control(57).Enabled=   0   'False
      Tab(0).Control(58)=   "txtChequesALaOrdenDe"
      Tab(0).Control(58).Enabled=   0   'False
      Tab(0).Control(59)=   "txtCodigoPresto"
      Tab(0).Control(59).Enabled=   0   'False
      Tab(0).Control(60)=   "txtInformacionAuxiliar"
      Tab(0).Control(60).Enabled=   0   'False
      Tab(0).Control(61)=   "txtCalificacion"
      Tab(0).Control(61).Enabled=   0   'False
      Tab(0).Control(62)=   "Check2"
      Tab(0).Control(62).Enabled=   0   'False
      Tab(0).ControlCount=   63
      TabCaption(1)   =   "Contactos"
      TabPicture(1)   =   "frmProveedores.frx":0786
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "lblFieldLabel(19)"
      Tab(1).Control(1)=   "lblLabels(1)"
      Tab(1).Control(2)=   "Lista"
      Tab(1).Control(3)=   "txtContacto"
      Tab(1).ControlCount=   4
      TabCaption(2)   =   "Informacion para retenciones"
      TabPicture(2)   =   "frmProveedores.frx":07A2
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "Frame7"
      Tab(2).Control(1)=   "Frame6"
      Tab(2).Control(2)=   "Frame5"
      Tab(2).Control(3)=   "Frame4"
      Tab(2).Control(4)=   "Frame2"
      Tab(2).ControlCount=   5
      TabCaption(3)   =   "Rubros provistos"
      TabPicture(3)   =   "frmProveedores.frx":07BE
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "ListaRubros"
      Tab(3).ControlCount=   1
      TabCaption(4)   =   "Datos adicionales"
      TabPicture(4)   =   "frmProveedores.frx":07DA
      Tab(4).ControlEnabled=   0   'False
      Tab(4).Control(0)=   "Frame8"
      Tab(4).Control(1)=   "Frame9"
      Tab(4).Control(2)=   "Frame10"
      Tab(4).ControlCount=   3
      Begin VB.Frame Frame10 
         Caption         =   "Transportista relacionado : "
         Height          =   690
         Left            =   -74865
         TabIndex        =   147
         Top             =   2205
         Visible         =   0   'False
         Width           =   5640
         Begin VB.CheckBox Check4 
            Height          =   330
            Left            =   180
            TabIndex        =   149
            Top             =   270
            Width           =   150
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdTransportista"
            Height          =   315
            Index           =   8
            Left            =   405
            TabIndex        =   148
            Tag             =   "Transportistas"
            Top             =   270
            Width           =   5085
            _ExtentX        =   8969
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdTransportista"
            Text            =   ""
         End
      End
      Begin VB.CheckBox Check2 
         Alignment       =   1  'Right Justify
         Caption         =   "Exterior"
         Height          =   195
         Left            =   10440
         TabIndex        =   131
         Top             =   1665
         Width           =   825
      End
      Begin VB.TextBox txtCalificacion 
         Alignment       =   2  'Center
         DataField       =   "Calificacion"
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   3082
            SubFormatType   =   0
         EndProperty
         Height          =   285
         Left            =   10890
         TabIndex        =   129
         Top             =   4455
         Width           =   420
      End
      Begin VB.Frame Frame9 
         Caption         =   "Datos adicionales : "
         Height          =   1590
         Left            =   -74910
         TabIndex        =   119
         Top             =   2970
         Width           =   9195
         Begin VB.TextBox txtNombre1 
            DataField       =   "Nombre1"
            Height          =   285
            Left            =   1890
            TabIndex        =   121
            Top             =   495
            Width           =   6750
         End
         Begin VB.TextBox txtNombre2 
            DataField       =   "Nombre2"
            Height          =   285
            Left            =   1890
            TabIndex        =   120
            Top             =   900
            Width           =   6750
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Datos adicionales 1 :"
            Height          =   255
            Index           =   13
            Left            =   135
            TabIndex        =   123
            Top             =   540
            Width           =   1545
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Datos adicionales 2 :"
            Height          =   255
            Index           =   16
            Left            =   135
            TabIndex        =   122
            Top             =   945
            Width           =   1500
         End
      End
      Begin VB.Frame Frame8 
         Caption         =   "Datos para importaciones : "
         Height          =   1365
         Left            =   -74865
         TabIndex        =   114
         Top             =   765
         Width           =   5640
         Begin VB.TextBox txtImportaciones_NumeroInscripcion 
            DataField       =   "Importaciones_NumeroInscripcion"
            Height          =   285
            Left            =   2115
            TabIndex        =   116
            Top             =   405
            Width           =   3345
         End
         Begin VB.TextBox txtImportaciones_DenominacionInscripcion 
            DataField       =   "Importaciones_DenominacionInscripcion"
            Height          =   285
            Left            =   2115
            TabIndex        =   115
            Top             =   810
            Width           =   3345
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Numero de inscripcion :"
            Height          =   255
            Index           =   6
            Left            =   180
            TabIndex        =   118
            Top             =   435
            Width           =   1860
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Denominacion inscripcion :"
            Height          =   255
            Index           =   4
            Left            =   180
            TabIndex        =   117
            Top             =   840
            Width           =   1860
         End
      End
      Begin VB.Frame Frame7 
         Caption         =   "Informacion sobre presentacion de documentacion impositiva : "
         Height          =   2220
         Left            =   -74775
         TabIndex        =   107
         Top             =   4050
         Width           =   6090
         Begin MSComCtl2.DTPicker DTPicker1 
            DataField       =   "FechaUltimaPresentacionDocumentacion"
            Height          =   285
            Index           =   3
            Left            =   4545
            TabIndex        =   108
            Top             =   225
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   503
            _Version        =   393216
            CheckBox        =   -1  'True
            Format          =   60227585
            CurrentDate     =   36432
         End
         Begin RichTextLib.RichTextBox rchObservacionesPresentacionDocumentacion 
            Height          =   1455
            Left            =   135
            TabIndex        =   110
            Top             =   720
            Width           =   5820
            _ExtentX        =   10266
            _ExtentY        =   2566
            _Version        =   393217
            Enabled         =   -1  'True
            ScrollBars      =   2
            TextRTF         =   $"frmProveedores.frx":07F6
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Observaciones de la presentacion :"
            Height          =   195
            Index           =   23
            Left            =   135
            TabIndex        =   111
            Top             =   540
            Width           =   2580
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Fecha de ultima presentacion de documentos del proveedor :"
            Height          =   195
            Index           =   24
            Left            =   135
            TabIndex        =   109
            Top             =   270
            Width           =   4470
         End
      End
      Begin VB.TextBox txtInformacionAuxiliar 
         DataField       =   "InformacionAuxiliar"
         Height          =   285
         Left            =   7695
         TabIndex        =   103
         Top             =   4455
         Width           =   1980
      End
      Begin VB.TextBox txtCodigoPresto 
         DataField       =   "CodigoPresto"
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   3082
            SubFormatType   =   0
         EndProperty
         Height          =   285
         Left            =   10350
         TabIndex        =   88
         Top             =   1305
         Width           =   915
      End
      Begin VB.TextBox txtChequesALaOrdenDe 
         DataField       =   "ChequesALaOrdenDe"
         Height          =   285
         Left            =   2115
         TabIndex        =   86
         Top             =   4815
         Width           =   9180
      End
      Begin VB.Frame Frame6 
         Caption         =   "Condicion impuesto a las ganancias : "
         Height          =   1185
         Left            =   -74775
         TabIndex        =   81
         Top             =   630
         Width           =   6090
         Begin VB.OptionButton Option14 
            Caption         =   "Exento"
            Height          =   195
            Left            =   90
            TabIndex        =   83
            Top             =   270
            Width           =   1005
         End
         Begin VB.OptionButton Option15 
            Caption         =   "Inscripto"
            Height          =   195
            Left            =   90
            TabIndex        =   82
            Top             =   540
            Width           =   1095
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdTipoRetencionGanancia"
            Height          =   315
            Index           =   10
            Left            =   2070
            TabIndex        =   85
            Tag             =   "TiposRetencionGanancia"
            Top             =   450
            Width           =   3915
            _ExtentX        =   6906
            _ExtentY        =   556
            _Version        =   393216
            Style           =   2
            ListField       =   "Titulo"
            BoundColumn     =   "IdTipoRetencionGanancia"
            Text            =   ""
         End
         Begin MSComCtl2.DTPicker DTPicker2 
            DataField       =   "FechaLimiteExentoGanancias"
            Height          =   285
            Index           =   0
            Left            =   4455
            TabIndex        =   90
            Top             =   810
            Width           =   1500
            _ExtentX        =   2646
            _ExtentY        =   503
            _Version        =   393216
            CheckBox        =   -1  'True
            Format          =   60227585
            CurrentDate     =   29221
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Fecha limite para la condicion de exento :"
            Height          =   240
            Index           =   39
            Left            =   1440
            TabIndex        =   91
            Top             =   855
            Width           =   3000
         End
         Begin VB.Label lblData 
            Caption         =   "Tipo de retencion ganancias :"
            Height          =   240
            Index           =   10
            Left            =   2070
            TabIndex        =   84
            Top             =   225
            Width           =   2145
         End
      End
      Begin VB.Frame Frame5 
         Caption         =   "Informacion para retencion SUSS : "
         Height          =   960
         Left            =   -74775
         TabIndex        =   77
         Top             =   3060
         Width           =   6090
         Begin VB.OptionButton Option16 
            Caption         =   "NO"
            Height          =   195
            Left            =   5445
            TabIndex        =   128
            Top             =   270
            Width           =   555
         End
         Begin VB.OptionButton Option13 
            Caption         =   "EXENTO"
            Height          =   195
            Left            =   4365
            TabIndex        =   79
            Top             =   270
            Width           =   960
         End
         Begin VB.OptionButton Option12 
            Caption         =   "SI"
            Height          =   195
            Left            =   3735
            TabIndex        =   78
            Top             =   270
            Width           =   555
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdImpuestoDirectoSUSS"
            Height          =   315
            Index           =   5
            Left            =   1080
            TabIndex        =   100
            Tag             =   "ImpuestosDirectosSUSS"
            Top             =   540
            Width           =   2670
            _ExtentX        =   4710
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdImpuestoDirecto"
            Text            =   ""
         End
         Begin MSComCtl2.DTPicker DTPicker1 
            DataField       =   "SUSSFechaCaducidadExencion"
            Height          =   285
            Index           =   4
            Left            =   4725
            TabIndex        =   126
            Top             =   540
            Width           =   1275
            _ExtentX        =   2249
            _ExtentY        =   503
            _Version        =   393216
            Format          =   60227585
            CurrentDate     =   36432
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Fecha vto. : "
            Height          =   195
            Index           =   26
            Left            =   3825
            TabIndex        =   127
            Top             =   585
            Width           =   870
         End
         Begin VB.Label lblData 
            Caption         =   "Categoria :"
            Height          =   240
            Index           =   5
            Left            =   135
            TabIndex        =   101
            Top             =   585
            Width           =   900
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "El proveedor esta alcanzado por la retencion ? :"
            Height          =   240
            Index           =   37
            Left            =   135
            TabIndex        =   80
            Top             =   270
            Width           =   3945
         End
      End
      Begin VB.Frame Frame4 
         Caption         =   "Condicion ingresos brutos : "
         Height          =   5640
         Left            =   -68520
         TabIndex        =   72
         Top             =   675
         Width           =   5010
         Begin VB.CheckBox Check5 
            Alignment       =   1  'Right Justify
            Caption         =   "Regimen especial de construccion : "
            Height          =   240
            Left            =   135
            TabIndex        =   154
            Top             =   2340
            Width           =   3345
         End
         Begin VB.TextBox txtGrupoIIBB 
            Alignment       =   2  'Center
            DataField       =   "GrupoIIBB"
            Height          =   285
            Left            =   4410
            TabIndex        =   143
            Top             =   5265
            Width           =   465
         End
         Begin VB.TextBox txtPorcentajeIBDirecto 
            Alignment       =   2  'Center
            DataField       =   "PorcentajeIBDirecto"
            Height          =   285
            Left            =   90
            TabIndex        =   137
            Top             =   5265
            Width           =   960
         End
         Begin VB.TextBox txtDetalleEmbargo 
            DataField       =   "DetalleEmbargo"
            Height          =   285
            Left            =   765
            TabIndex        =   135
            Top             =   4635
            Width           =   4155
         End
         Begin VB.TextBox txtSaldoEmbargo 
            Alignment       =   1  'Right Justify
            DataField       =   "SaldoEmbargo"
            Height          =   285
            Left            =   3600
            TabIndex        =   133
            Top             =   4320
            Width           =   1320
         End
         Begin VB.CheckBox Check3 
            Alignment       =   1  'Right Justify
            Caption         =   "Sujeto embargado :"
            Height          =   240
            Left            =   135
            TabIndex        =   132
            Top             =   4365
            Width           =   1725
         End
         Begin VB.TextBox txtCoeficienteIIBBUnificado 
            Alignment       =   1  'Right Justify
            DataField       =   "CoeficienteIIBBUnificado"
            Height          =   285
            Left            =   2700
            TabIndex        =   105
            Top             =   2025
            Width           =   780
         End
         Begin VB.TextBox txtIBNumeroInscripcion 
            DataField       =   "IBNumeroInscripcion"
            Height          =   285
            Left            =   2745
            TabIndex        =   92
            Top             =   1260
            Width           =   2130
         End
         Begin VB.OptionButton Option11 
            Caption         =   "No Alcanzado"
            Height          =   195
            Left            =   2385
            TabIndex        =   76
            Top             =   585
            Width           =   2445
         End
         Begin VB.OptionButton Option10 
            Caption         =   "Inscripto Jurisdicción Local "
            Height          =   195
            Left            =   90
            TabIndex        =   75
            Top             =   585
            Width           =   2310
         End
         Begin VB.OptionButton Option9 
            Caption         =   "Inscripto Convenio Multilateral "
            Height          =   195
            Left            =   2385
            TabIndex        =   74
            Top             =   315
            Width           =   2490
         End
         Begin VB.OptionButton Option8 
            Caption         =   "Exento"
            Height          =   195
            Left            =   90
            TabIndex        =   73
            Top             =   315
            Width           =   1005
         End
         Begin Controles1013.DbListView ListaConvenioMultilateral 
            Height          =   1500
            Left            =   90
            TabIndex        =   93
            Top             =   2790
            Width           =   4830
            _ExtentX        =   8520
            _ExtentY        =   2646
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MouseIcon       =   "frmProveedores.frx":0878
            OLEDragMode     =   1
            OLEDropMode     =   1
            ColumnHeaderIcons=   "ImgColumnas"
         End
         Begin MSDataListLib.DataCombo DataCombo1 
            DataField       =   "IdIBCondicionPorDefecto"
            Height          =   315
            Index           =   12
            Left            =   1845
            TabIndex        =   94
            Tag             =   "IBCondiciones"
            Top             =   1620
            Width           =   3030
            _ExtentX        =   5345
            _ExtentY        =   556
            _Version        =   393216
            ListField       =   "Titulo"
            BoundColumn     =   "IdIBCondicion"
            Text            =   ""
         End
         Begin MSComCtl2.DTPicker DTPicker2 
            DataField       =   "FechaLimiteExentoIIBB"
            Height          =   285
            Index           =   1
            Left            =   3375
            TabIndex        =   98
            Top             =   900
            Width           =   1500
            _ExtentX        =   2646
            _ExtentY        =   503
            _Version        =   393216
            CheckBox        =   -1  'True
            Format          =   60227585
            CurrentDate     =   29221
         End
         Begin MSComCtl2.DTPicker DTPicker1 
            DataField       =   "FechaInicioVigenciaIBDirecto"
            Height          =   285
            Index           =   5
            Left            =   1395
            TabIndex        =   138
            Top             =   5265
            Width           =   1230
            _ExtentX        =   2170
            _ExtentY        =   503
            _Version        =   393216
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Format          =   60227585
            CurrentDate     =   36432
         End
         Begin MSComCtl2.DTPicker DTPicker1 
            DataField       =   "FechaFinVigenciaIBDirecto"
            Height          =   285
            Index           =   6
            Left            =   2925
            TabIndex        =   141
            Top             =   5265
            Width           =   1230
            _ExtentX        =   2170
            _ExtentY        =   503
            _Version        =   393216
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Format          =   60227585
            CurrentDate     =   36432
         End
         Begin VB.Label lblData 
            Caption         =   "Grupo"
            Height          =   255
            Index           =   16
            Left            =   4410
            TabIndex        =   144
            Top             =   5040
            Width           =   435
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Fecha fin vigencia"
            Height          =   210
            Index           =   31
            Left            =   2880
            TabIndex        =   142
            Top             =   5040
            Width           =   1455
         End
         Begin VB.Label lblData 
            Caption         =   "% IB Directo"
            Height          =   255
            Index           =   18
            Left            =   90
            TabIndex        =   140
            Top             =   5040
            Width           =   975
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Fecha inicio vigencia"
            Height          =   210
            Index           =   30
            Left            =   1215
            TabIndex        =   139
            Top             =   5040
            Width           =   1545
         End
         Begin VB.Line Line1 
            BorderColor     =   &H00FFFFFF&
            X1              =   90
            X2              =   4905
            Y1              =   4995
            Y2              =   4995
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Detalle :"
            Height          =   195
            Index           =   29
            Left            =   135
            TabIndex        =   136
            Top             =   4680
            Width           =   645
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Saldo embargo :"
            Height          =   240
            Index           =   28
            Left            =   2295
            TabIndex        =   134
            Top             =   4365
            Width           =   1230
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Coeficiente unificado % (opcional) :"
            Height          =   240
            Index           =   20
            Left            =   135
            TabIndex        =   106
            Top             =   2070
            Width           =   2520
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Fecha limite para la condicion de exento :"
            Height          =   240
            Index           =   38
            Left            =   135
            TabIndex        =   99
            Top             =   945
            Width           =   3000
         End
         Begin VB.Label lblFieldLabel 
            Alignment       =   1  'Right Justify
            Caption         =   "Ing. brutos numero de inscripcion :"
            Height          =   240
            Index           =   34
            Left            =   135
            TabIndex        =   97
            Top             =   1320
            Width           =   2430
         End
         Begin VB.Label lblLabels 
            AutoSize        =   -1  'True
            Caption         =   "Detalle de retencion para convenio multilateral : "
            Height          =   195
            Index           =   2
            Left            =   135
            TabIndex        =   96
            Top             =   2610
            Width           =   3405
         End
         Begin VB.Label lblData 
            Caption         =   "Categoria por defecto : "
            Height          =   240
            Index           =   12
            Left            =   135
            TabIndex        =   95
            Top             =   1695
            Width           =   1665
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Datos para retencion IVA : "
         Height          =   1185
         Left            =   -74775
         TabIndex        =   66
         Top             =   1845
         Width           =   6090
         Begin VB.TextBox txtCodigoRetencionIVA 
            Alignment       =   2  'Center
            DataField       =   "CodigoRetencionIVA"
            Height          =   285
            Left            =   3150
            TabIndex        =   151
            Top             =   855
            Width           =   600
         End
         Begin VB.TextBox txtCodigoSituacionRetencionIVA 
            Alignment       =   2  'Center
            DataField       =   "CodigoSituacionRetencionIVA"
            Height          =   285
            Left            =   3150
            TabIndex        =   124
            Top             =   540
            Width           =   330
         End
         Begin VB.CheckBox Check1 
            Alignment       =   1  'Right Justify
            Caption         =   "Exceptuado 100 % :"
            Height          =   195
            Left            =   90
            TabIndex        =   68
            Top             =   270
            Width           =   1725
         End
         Begin VB.TextBox txtIvaPorcentajeExencion 
            Alignment       =   1  'Right Justify
            DataField       =   "IvaPorcentajeExencion"
            Height          =   285
            Left            =   3150
            TabIndex        =   67
            Top             =   225
            Width           =   600
         End
         Begin MSComCtl2.DTPicker DTPicker1 
            DataField       =   "IvaFechaCaducidadExencion"
            Height          =   285
            Index           =   2
            Left            =   4725
            TabIndex        =   69
            Top             =   495
            Width           =   1275
            _ExtentX        =   2249
            _ExtentY        =   503
            _Version        =   393216
            Format          =   60227585
            CurrentDate     =   36432
         End
         Begin MSComCtl2.DTPicker DTPicker1 
            DataField       =   "IvaFechaInicioExencion"
            Height          =   285
            Index           =   7
            Left            =   4725
            TabIndex        =   145
            Top             =   180
            Width           =   1275
            _ExtentX        =   2249
            _ExtentY        =   503
            _Version        =   393216
            Format          =   60227585
            CurrentDate     =   36432
         End
         Begin VB.Label lblData 
            Caption         =   "Codigo retencion IVA (opcional) :"
            Height          =   240
            Index           =   8
            Left            =   90
            TabIndex        =   150
            Top             =   855
            Width           =   2430
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Fecha ini. : "
            Height          =   195
            Index           =   32
            Left            =   3825
            TabIndex        =   146
            Top             =   225
            Width           =   870
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Codigo de situacion retencion IVA :"
            Height          =   195
            Index           =   25
            Left            =   90
            TabIndex        =   125
            Top             =   585
            Width           =   2850
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "% de excepcion : "
            Height          =   195
            Index           =   7
            Left            =   1890
            TabIndex        =   71
            Top             =   270
            Width           =   1230
         End
         Begin VB.Label lblFieldLabel 
            Caption         =   "Fecha vto. : "
            Height          =   195
            Index           =   8
            Left            =   3825
            TabIndex        =   70
            Top             =   540
            Width           =   870
         End
      End
      Begin VB.TextBox txtCodigoProveedor 
         DataField       =   "CodigoEmpresa"
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   3082
            SubFormatType   =   0
         EndProperty
         Height          =   285
         Left            =   7695
         TabIndex        =   12
         Top             =   990
         Width           =   825
      End
      Begin VB.Frame Frame1 
         Height          =   330
         Left            =   8595
         TabIndex        =   43
         Top             =   945
         Width           =   2670
         Begin VB.OptionButton Option2 
            Caption         =   "PB"
            Height          =   150
            Left            =   585
            TabIndex        =   48
            Top             =   135
            Width           =   510
         End
         Begin VB.OptionButton Option1 
            Caption         =   "PC"
            Height          =   150
            Left            =   45
            TabIndex        =   47
            Top             =   135
            Width           =   510
         End
         Begin VB.OptionButton Option3 
            Caption         =   "PE"
            Height          =   150
            Left            =   1080
            TabIndex        =   46
            Top             =   135
            Width           =   510
         End
         Begin VB.OptionButton Option4 
            Caption         =   "PV"
            Height          =   150
            Left            =   1575
            TabIndex        =   45
            Top             =   135
            Width           =   510
         End
         Begin VB.OptionButton Option5 
            Caption         =   "PS"
            Height          =   150
            Left            =   2070
            TabIndex        =   44
            Top             =   135
            Width           =   510
         End
      End
      Begin VB.TextBox txtLimiteCredito 
         Alignment       =   1  'Right Justify
         DataField       =   "LimiteCredito"
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   3082
            SubFormatType   =   0
         EndProperty
         Height          =   285
         Left            =   10110
         TabIndex        =   20
         Top             =   3015
         Width           =   1185
      End
      Begin VB.TextBox txtContacto 
         DataField       =   "Contacto"
         Height          =   285
         Left            =   -73275
         TabIndex        =   39
         Top             =   675
         Width           =   4410
      End
      Begin VB.TextBox txtRazonSocial 
         DataField       =   "RazonSocial"
         Height          =   285
         Left            =   2115
         TabIndex        =   0
         Top             =   630
         Width           =   9180
      End
      Begin VB.TextBox txtDireccion 
         DataField       =   "Direccion"
         Height          =   285
         Left            =   2115
         TabIndex        =   2
         Top             =   1305
         Width           =   3465
      End
      Begin VB.TextBox txtCodigoPostal 
         DataField       =   "CodigoPostal"
         Height          =   285
         Left            =   2115
         TabIndex        =   4
         Top             =   2010
         Width           =   3465
      End
      Begin VB.TextBox txtTelefono 
         DataField       =   "Telefono1"
         Height          =   285
         Left            =   2115
         TabIndex        =   7
         Top             =   3075
         Width           =   3465
      End
      Begin VB.TextBox txtFax 
         DataField       =   "Fax"
         Height          =   285
         Left            =   2115
         TabIndex        =   9
         Top             =   3750
         Width           =   3465
      End
      Begin VB.TextBox txtEmail 
         DataField       =   "Email"
         Height          =   285
         Left            =   2115
         TabIndex        =   10
         Top             =   4095
         Width           =   3465
      End
      Begin VB.TextBox txtNombreFantasia 
         DataField       =   "NombreFantasia"
         Height          =   285
         Left            =   2115
         TabIndex        =   1
         Top             =   975
         Width           =   3465
      End
      Begin VB.TextBox txtTelefono2 
         DataField       =   "Telefono2"
         Height          =   285
         Left            =   2115
         TabIndex        =   8
         Top             =   3420
         Width           =   3465
      End
      Begin VB.TextBox txtPaginaWeb 
         DataField       =   "PaginaWeb"
         Height          =   285
         Left            =   2115
         TabIndex        =   11
         Top             =   4455
         Width           =   3465
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdLocalidad"
         Height          =   315
         Index           =   0
         Left            =   2115
         TabIndex        =   3
         Tag             =   "Localidades"
         Top             =   1650
         Width           =   3465
         _ExtentX        =   6112
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdLocalidad"
         Text            =   ""
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdProvincia"
         Height          =   315
         Index           =   9
         Left            =   2115
         TabIndex        =   5
         Tag             =   "Provincias"
         Top             =   2355
         Width           =   1620
         _ExtentX        =   2858
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdProvincia"
         Text            =   ""
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdPais"
         Height          =   315
         Index           =   7
         Left            =   4230
         TabIndex        =   6
         Tag             =   "Paises"
         Top             =   2340
         Width           =   1350
         _ExtentX        =   2381
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdPais"
         Text            =   ""
      End
      Begin Controles1013.DbListView Lista 
         Height          =   4650
         Left            =   -74865
         TabIndex        =   40
         Top             =   1395
         Width           =   11400
         _ExtentX        =   20108
         _ExtentY        =   8202
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MouseIcon       =   "frmProveedores.frx":0894
         OLEDragMode     =   1
         OLEDropMode     =   1
         ColumnHeaderIcons=   "ImgColumnas"
      End
      Begin MSComCtl2.DTPicker DTPicker1 
         DataField       =   "FechaAlta"
         Height          =   285
         Index           =   0
         Left            =   10020
         TabIndex        =   17
         Top             =   2655
         Width           =   1275
         _ExtentX        =   2249
         _ExtentY        =   503
         _Version        =   393216
         Enabled         =   0   'False
         Format          =   60227585
         CurrentDate     =   29221
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdCondicionCompra"
         Height          =   315
         Index           =   4
         Left            =   7695
         TabIndex        =   15
         Tag             =   "CondicionesCompra"
         Top             =   2295
         Width           =   3600
         _ExtentX        =   6350
         _ExtentY        =   556
         _Version        =   393216
         Style           =   2
         ListField       =   "Titulo"
         BoundColumn     =   "IdCondicionCompra"
         Text            =   ""
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdMoneda"
         Height          =   315
         Index           =   6
         Left            =   7695
         TabIndex        =   19
         Tag             =   "Monedas"
         Top             =   3015
         Width           =   1170
         _ExtentX        =   2064
         _ExtentY        =   556
         _Version        =   393216
         Style           =   2
         ListField       =   "Titulo"
         BoundColumn     =   "IdMoneda"
         Text            =   ""
      End
      Begin MSComCtl2.DTPicker DTPicker1 
         DataField       =   "FechaUltimaCompra"
         Height          =   285
         Index           =   1
         Left            =   7710
         TabIndex        =   16
         Top             =   2655
         Width           =   1230
         _ExtentX        =   2170
         _ExtentY        =   503
         _Version        =   393216
         Enabled         =   0   'False
         Format          =   60227585
         CurrentDate     =   29221
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdEstado"
         Height          =   315
         Index           =   2
         Left            =   7695
         TabIndex        =   21
         Tag             =   "EstadosP"
         Top             =   3375
         Width           =   1890
         _ExtentX        =   3334
         _ExtentY        =   556
         _Version        =   393216
         Style           =   2
         ListField       =   "Titulo"
         BoundColumn     =   "IdEstado"
         Text            =   ""
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdActividad"
         Height          =   315
         Index           =   3
         Left            =   7695
         TabIndex        =   22
         Tag             =   "ActividadesP"
         Top             =   3735
         Width           =   3600
         _ExtentX        =   6350
         _ExtentY        =   556
         _Version        =   393216
         Style           =   2
         ListField       =   "Titulo"
         BoundColumn     =   "IdActividad"
         Text            =   ""
      End
      Begin Control_CUIT.CUIT CUIT1 
         Height          =   285
         Left            =   7695
         TabIndex        =   13
         Top             =   1305
         Width           =   1545
         _ExtentX        =   2725
         _ExtentY        =   503
         Text            =   ""
         MensajeErr      =   "CUIT incorrecto"
         otrosP          =   -1  'True
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdCodigoIva"
         Height          =   315
         Index           =   1
         Left            =   7695
         TabIndex        =   14
         Tag             =   "DescripcionIva"
         Top             =   1620
         Width           =   2655
         _ExtentX        =   4683
         _ExtentY        =   556
         _Version        =   393216
         Style           =   2
         ListField       =   "Titulo"
         BoundColumn     =   "IdCodigoIva"
         Text            =   ""
      End
      Begin RichTextLib.RichTextBox rchObservaciones 
         Height          =   1050
         Left            =   2115
         TabIndex        =   61
         Top             =   5175
         Width           =   9195
         _ExtentX        =   16219
         _ExtentY        =   1852
         _Version        =   393217
         Enabled         =   -1  'True
         ScrollBars      =   2
         TextRTF         =   $"frmProveedores.frx":08B0
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdCuenta"
         Height          =   315
         Index           =   11
         Left            =   2115
         TabIndex        =   18
         Tag             =   "Cuentas"
         Top             =   2700
         Width           =   3465
         _ExtentX        =   6112
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdCuenta"
         Text            =   ""
      End
      Begin Controles1013.DbListView ListaRubros 
         Height          =   5640
         Left            =   -74865
         TabIndex        =   102
         Top             =   585
         Width           =   11355
         _ExtentX        =   20029
         _ExtentY        =   9948
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MouseIcon       =   "frmProveedores.frx":0932
         OLEDragMode     =   1
         OLEDropMode     =   1
         ColumnHeaderIcons=   "ImgColumnas"
      End
      Begin VB.Frame Frame3 
         Height          =   420
         Left            =   5760
         TabIndex        =   57
         Top             =   4005
         Width           =   5505
         Begin VB.OptionButton Option6 
            Caption         =   "Bienes"
            Height          =   150
            Left            =   2790
            TabIndex        =   59
            Top             =   180
            Width           =   1095
         End
         Begin VB.OptionButton Option7 
            Caption         =   "Servicios"
            Height          =   150
            Left            =   4095
            TabIndex        =   58
            Top             =   180
            Width           =   1230
         End
         Begin VB.Label Label1 
            Caption         =   "Tipo de materiales que provee :"
            Height          =   195
            Left            =   90
            TabIndex        =   60
            Top             =   135
            Width           =   2265
         End
      End
      Begin MSComCtl2.DTPicker DTPicker2 
         DataField       =   "FechaLimiteCondicionIVA"
         Height          =   285
         Index           =   2
         Left            =   9795
         TabIndex        =   112
         Top             =   1980
         Width           =   1500
         _ExtentX        =   2646
         _ExtentY        =   503
         _Version        =   393216
         CheckBox        =   -1  'True
         Format          =   60227585
         CurrentDate     =   29221
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdListaPrecios"
         Height          =   315
         Index           =   13
         Left            =   10170
         TabIndex        =   152
         Tag             =   "ListasPrecios"
         Top             =   3375
         Visible         =   0   'False
         Width           =   1125
         _ExtentX        =   1984
         _ExtentY        =   556
         _Version        =   393216
         Style           =   2
         ListField       =   "Titulo"
         BoundColumn     =   "IdListaPrecios"
         Text            =   ""
      End
      Begin VB.Label lblData 
         Alignment       =   1  'Right Justify
         Caption         =   "Lista :"
         Height          =   255
         Index           =   13
         Left            =   9585
         TabIndex        =   153
         Top             =   3420
         Visible         =   0   'False
         Width           =   510
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Calificacion :"
         Height          =   255
         Index           =   27
         Left            =   9810
         TabIndex        =   130
         Top             =   4500
         Width           =   960
      End
      Begin VB.Label lblData 
         Alignment       =   1  'Right Justify
         Caption         =   "Fecha limite para la condicion de iva (opcional)  :"
         Height          =   240
         Index           =   15
         Left            =   5715
         TabIndex        =   113
         Top             =   2025
         Width           =   4035
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Informacion auxiliar :"
         Height          =   210
         Index           =   18
         Left            =   5760
         TabIndex        =   104
         Top             =   4500
         Width           =   1815
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Cod. Presto : "
         Height          =   255
         Index           =   1
         Left            =   9360
         TabIndex        =   89
         Top             =   1350
         Width           =   960
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Cheques a la orden de :"
         Height          =   255
         Index           =   0
         Left            =   180
         TabIndex        =   87
         Top             =   4860
         Width           =   1815
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Cuit :"
         Height          =   255
         Index           =   12
         Left            =   5760
         TabIndex        =   65
         Top             =   1335
         Width           =   1815
      End
      Begin VB.Label lblData 
         Alignment       =   1  'Right Justify
         Caption         =   "Condicion de IVA :"
         Height          =   255
         Index           =   1
         Left            =   5760
         TabIndex        =   64
         Top             =   1635
         Width           =   1815
      End
      Begin VB.Label lblLabels 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         Caption         =   "Observaciones :"
         Height          =   255
         Index           =   0
         Left            =   180
         TabIndex        =   63
         Top             =   5175
         Width           =   1815
      End
      Begin VB.Label lblData 
         Alignment       =   1  'Right Justify
         Caption         =   "Cuenta contable :"
         Height          =   255
         Index           =   11
         Left            =   180
         TabIndex        =   62
         Top             =   2745
         Width           =   1815
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Fecha de ultima compra :"
         Height          =   255
         Index           =   22
         Left            =   5760
         TabIndex        =   56
         Top             =   2700
         Width           =   1815
      End
      Begin VB.Label lblData 
         Alignment       =   1  'Right Justify
         Caption         =   "Estado actual :"
         Height          =   255
         Index           =   2
         Left            =   5760
         TabIndex        =   55
         Top             =   3420
         Width           =   1815
      End
      Begin VB.Label lblData 
         Alignment       =   1  'Right Justify
         Caption         =   "Actividad principal :"
         Height          =   255
         Index           =   3
         Left            =   5760
         TabIndex        =   54
         Top             =   3780
         Width           =   1815
      End
      Begin VB.Label lblData 
         Alignment       =   1  'Right Justify
         Caption         =   "Condicion de compra :"
         Height          =   255
         Index           =   4
         Left            =   5760
         TabIndex        =   53
         Top             =   2355
         Width           =   1815
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Codigo de proveedor :"
         Height          =   255
         Index           =   15
         Left            =   5760
         TabIndex        =   52
         Top             =   1035
         Width           =   1815
      End
      Begin VB.Label lblData 
         Alignment       =   1  'Right Justify
         Caption         =   "Moneda corriente :"
         Height          =   255
         Index           =   6
         Left            =   5760
         TabIndex        =   51
         Top             =   3030
         Width           =   1815
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Limite credito :"
         Height          =   255
         Index           =   14
         Left            =   9000
         TabIndex        =   50
         Top             =   3060
         Width           =   1050
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Fec.alta :"
         Height          =   255
         Index           =   21
         Left            =   9045
         TabIndex        =   49
         Top             =   2700
         Width           =   780
      End
      Begin VB.Label lblLabels 
         AutoSize        =   -1  'True
         Caption         =   "Contactos :"
         Height          =   195
         Index           =   1
         Left            =   -74820
         TabIndex        =   42
         Top             =   1170
         Width           =   900
      End
      Begin VB.Label lblFieldLabel 
         Caption         =   "Contacto principal :"
         Height          =   240
         Index           =   19
         Left            =   -74820
         TabIndex        =   41
         Top             =   720
         Width           =   1470
      End
      Begin VB.Label lblData 
         Alignment       =   1  'Right Justify
         Caption         =   "Provincia :"
         Height          =   255
         Index           =   9
         Left            =   180
         TabIndex        =   38
         Top             =   2400
         Width           =   1815
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Razon social :"
         Height          =   255
         Index           =   2
         Left            =   180
         TabIndex        =   37
         Top             =   660
         Width           =   1815
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Direccion :"
         Height          =   255
         Index           =   3
         Left            =   180
         TabIndex        =   36
         Top             =   1350
         Width           =   1815
      End
      Begin VB.Label lblData 
         Alignment       =   1  'Right Justify
         Caption         =   "Localidad :"
         Height          =   255
         Index           =   0
         Left            =   180
         TabIndex        =   35
         Top             =   1695
         Width           =   1815
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Codigo postal :"
         Height          =   255
         Index           =   5
         Left            =   180
         TabIndex        =   34
         Top             =   2055
         Width           =   1815
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Telefono :"
         Height          =   255
         Index           =   9
         Left            =   180
         TabIndex        =   33
         Top             =   3105
         Width           =   1815
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Fax :"
         Height          =   255
         Index           =   10
         Left            =   180
         TabIndex        =   32
         Top             =   3795
         Width           =   1815
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Email :"
         Height          =   255
         Index           =   11
         Left            =   180
         TabIndex        =   31
         Top             =   4140
         Width           =   1815
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Nombre comercial :"
         Height          =   255
         Index           =   17
         Left            =   180
         TabIndex        =   30
         Top             =   1005
         Width           =   1815
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Telefono adicional :"
         Height          =   255
         Index           =   35
         Left            =   180
         TabIndex        =   29
         Top             =   3450
         Width           =   1815
      End
      Begin VB.Label lblFieldLabel 
         Alignment       =   1  'Right Justify
         Caption         =   "Pagina Web :"
         Height          =   255
         Index           =   36
         Left            =   180
         TabIndex        =   28
         Top             =   4500
         Width           =   1815
      End
      Begin VB.Label lblData 
         Alignment       =   1  'Right Justify
         Caption         =   "Pais :"
         Height          =   255
         Index           =   7
         Left            =   3780
         TabIndex        =   27
         Top             =   2385
         Width           =   375
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   1350
      TabIndex        =   24
      Top             =   6480
      Width           =   1080
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   2565
      TabIndex        =   25
      Top             =   6480
      Width           =   1080
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   4230
      Top             =   6480
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
            Picture         =   "frmProveedores.frx":094E
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProveedores.frx":0A60
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProveedores.frx":0EB2
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProveedores.frx":1304
            Key             =   "Original"
         EndProperty
      EndProperty
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
   End
   Begin VB.Menu MnuDet1 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetB 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
   Begin VB.Menu MnuDet2 
      Caption         =   "Detalle"
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
End
Attribute VB_Name = "frmProveedores"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Proveedor
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long, mIGCondicionExcepcion As Long
Private mNivelAcceso As Integer, mOpcionesAcceso As String
Private mvarNumerarProveedores As Boolean, mEventual As Boolean

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

   Dim oF As frmDetProveedores
   Dim oL As ListItem
   
   Set oF = New frmDetProveedores
   
   With oF
      Set .Proveedor = origen
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
            .Text = oF.txtContacto.Text
            .SubItems(1) = "" & oF.txtPuesto.Text
            .SubItems(2) = "" & oF.txtTelefono.Text
            .SubItems(3) = "" & oF.txtEmail.Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Sub EditarConvenioMultilateral(ByVal Cual As Long)

   Dim oF As frmDetProveedoresIB
   Dim oL As ListItem
   
   Set oF = New frmDetProveedoresIB
   
   With oF
      Set .Proveedor = origen
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaConvenioMultilateral.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaConvenioMultilateral.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.DataCombo1(0).Text
            .SubItems(1) = "" & oF.txtAlicuota.Text
            .SubItems(2) = "" & oF.DTFields(0).Value
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Sub EditarRubros(ByVal Cual As Long)

   Dim oF As frmDetProveedoresRubros
   Dim oL As ListItem
   
   Set oF = New frmDetProveedoresRubros
   
   With oF
      Set .Proveedor = origen
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaRubros.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaRubros.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.DataCombo1(0).Text
            .SubItems(1) = "" & oF.DataCombo1(1).Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Private Sub Check1_Click()

   If Check1.Value = 1 Then
      DTPicker1(2).Enabled = False
      DTPicker1(7).Enabled = False
      txtIvaPorcentajeExencion.Enabled = False
      If Not origen Is Nothing Then origen.Registro.Fields("IvaPorcentajeExencion").Value = 0
   Else
      With DTPicker1(7)
         .Value = Date
         .Enabled = True
      End With
      With DTPicker1(2)
         .Value = Date
         .Enabled = True
      End With
      txtIvaPorcentajeExencion.Enabled = True
   End If
   
End Sub

Private Sub Check3_Click()

   If Check3.Value = 1 Then
      txtSaldoEmbargo.Enabled = True
      txtDetalleEmbargo.Enabled = True
   Else
      With origen.Registro
         .Fields("SaldoEmbargo").Value = Null
         .Fields("DetalleEmbargo").Value = Null
      End With
      txtSaldoEmbargo.Enabled = False
      txtDetalleEmbargo.Enabled = False
   End If

End Sub

Private Sub Check4_Click()

   If Check4.Value = 1 Then
      DataCombo1(8).Enabled = True
   Else
      origen.Registro.Fields("IdTransportista").Value = Null
      DataCombo1(8).Enabled = False
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
   
         Dim est As EnumAcciones
         Dim oControl As Control
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim oRs As ADOR.Recordset
         Dim mNumeroProveedor As Long
         Dim mAux1
         
         If Len(txtCodigoProveedor.Text) = 0 Then
            MsgBox "Debe completar el codigo del proveedor", vbExclamation
            Exit Sub
         End If
         
         If Len(txtRazonSocial.Text) = 0 Then
            MsgBox "Debe completar la razon social", vbExclamation
            Exit Sub
         End If
         
         If Len(txtDireccion.Text) = 0 Then
            MsgBox "Debe completar el domicilio", vbExclamation
            Exit Sub
         End If
         
'         If Len(CUIT1.Text) = 0 And Not Option3.Value Then
'            MsgBox "Debe completar el cuit", vbExclamation
'            Exit Sub
'         End If

         If txtIBNumeroInscripcion.Enabled And Len(txtIBNumeroInscripcion.Text) = 0 And _
               Not (Option8.Value Or Option11.Value) Then
            MsgBox "Debe completar el numero de inscripcion de ingresos brutos", vbExclamation
            Exit Sub
         End If
         
         If Option12.Value And Not IsNumeric(DataCombo1(5).BoundText) Then
            MsgBox "Debe completar la categoria en la retencion SUSS", vbExclamation
            Exit Sub
         End If

         If Len(txtCodigoSituacionRetencionIVA.Text) > 0 And _
               Not IsNumeric(txtCodigoSituacionRetencionIVA.Text) Then
            MsgBox "Debe completar la categoria en la retencion SUSS", vbExclamation
            Exit Sub
         End If

         If (mvarId <= 0 Or BuscarClaveINI("Control estricto del CUIT") = "SI") And _
               Len(Trim(CUIT1.Text)) > 0 And Check2.Value = 0 Then
            Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorCuit", CUIT1.Text)
            If oRs.RecordCount > 0 Then
               Do While Not oRs.EOF
                  If mvarId <> oRs.Fields(0).Value And IsNull(oRs.Fields("Exterior").Value) Then
                     MsgBox "El CUIT ya fue asignado al proveedor " & oRs.Fields("RazonSocial").Value, vbExclamation
                     oRs.Close
                     Set oRs = Nothing
                     Exit Sub
                  End If
                  oRs.MoveNext
               Loop
            End If
            oRs.Close
         End If
         
         With origen.Registro
            For Each dtp In DTPicker1
               If dtp.Enabled Then
                  .Fields(dtp.DataField).Value = dtp.Value
               End If
            Next
            
            For Each dc In DataCombo1
               If IsNumeric(dc.BoundText) Then
                  .Fields(dc.DataField).Value = dc.BoundText
               Else
                  If dc.Enabled And dc.Index <> 2 And dc.Index <> 3 And dc.Index <> 13 Then
                     MsgBox "Debe completar el campo " & lblData(dc.Index), vbExclamation
                     Exit Sub
                  End If
               End If
            Next
            
            For Each oControl In Me.Controls
               If TypeOf oControl Is DataCombo Then
                  If Len(oControl.BoundText) <> 0 And IsNumeric(oControl.BoundText) Then
                     .Fields(oControl.DataField).Value = oControl.BoundText
                  End If
               ElseIf TypeOf oControl Is DTPicker Then
                  If oControl.Enabled Then
                     .Fields(oControl.DataField).Value = oControl.Value
                  Else
                     .Fields(oControl.DataField).Value = Null
                  End If
               ElseIf TypeOf oControl Is TextBox Then
                  If Len(oControl.DataField) > 0 Then
                     If Len(oControl.Text) = 0 Then
                        .Fields(oControl.DataField).Value = Null
                     Else
                        .Fields(oControl.DataField).Value = oControl.Text
                     End If
                  End If
               End If
            Next
            
            Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
            If IsNull(.Fields("IdCuenta").Value) Then
               .Fields("IdCuenta").Value = oRs.Fields("IdCuentaAcreedoresVarios").Value
            End If
            If IsNull(.Fields("IdMoneda").Value) Then
               .Fields("IdMoneda").Value = oRs.Fields("IdMoneda").Value
            End If
            oRs.Close
            
            If Len(Trim(CUIT1.Text)) = 0 Then
               Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DescripcionIva", "_PorId", .Fields("IdCodigoIva").Value)
               If oRs.RecordCount > 0 Then
                  If Not IsNull(oRs.Fields("ExigirCUIT").Value) And _
                        oRs.Fields("ExigirCUIT").Value = "SI" Then
                     MsgBox "Debe ingresar el numero de CUIT para esta condicion", vbCritical
                     oRs.Close
                     Set oRs = Nothing
                     Exit Sub
                  End If
               End If
               oRs.Close
               Set oRs = Nothing
            End If
                     
            If (mvarId <= 0 Or Me.Eventual) And mvarNumerarProveedores Then
               mAux1 = TraerValorParametro2("ProximoNumeroProveedor")
               mNumeroProveedor = IIf(IsNull(mAux1), 1, mAux1)
               .Fields("CodigoProveedor").Value = mNumeroProveedor
               GuardarValorParametro2 "ProximoNumeroProveedor", "" & mNumeroProveedor + 1
            End If
            
            If Option1.Value Then
               .Fields("TipoProveedor").Value = 1
            ElseIf Option2.Value Then
               .Fields("TipoProveedor").Value = 2
            ElseIf Option3.Value Then
               .Fields("TipoProveedor").Value = 3
            ElseIf Option4.Value Then
               .Fields("TipoProveedor").Value = 4
            ElseIf Option5.Value Then
               .Fields("TipoProveedor").Value = 5
            End If
         
            If Option8.Value Then
               .Fields("IBCondicion").Value = 1
            ElseIf Option9.Value Then
               .Fields("IBCondicion").Value = 2
            ElseIf Option10.Value Then
               .Fields("IBCondicion").Value = 3
            ElseIf Option11.Value Then
               .Fields("IBCondicion").Value = 4
            End If
         
            .Fields("Cuit").Value = CUIT1.Text
            .Fields("Confirmado").Value = "SI"
            
            If Check1.Value = 1 Then
               .Fields("IvaExencionRetencion").Value = "SI"
            Else
               .Fields("IvaExencionRetencion").Value = "NO"
               If Len(txtIvaPorcentajeExencion.Text) = 0 Then
                  MsgBox "Debe ingresar el porcentaje de retencion IVA", vbExclamation
                  Exit Sub
               End If
            End If
         
            If Option6.Value Then
               .Fields("BienesOServicios").Value = "B"
            Else
               .Fields("BienesOServicios").Value = "S"
            End If
         
            If Option12.Value Then
               .Fields("RetenerSUSS").Value = "SI"
            ElseIf Option13.Value Then
               .Fields("RetenerSUSS").Value = "EX"
            Else
               .Fields("RetenerSUSS").Value = "NO"
            End If
         
            If Option14.Value Then
               .Fields("IGCondicion").Value = 1
            ElseIf Option15.Value Then
               .Fields("IGCondicion").Value = 2
            End If
         
            If Check2.Value = 1 Then
               .Fields("Exterior").Value = "SI"
            Else
               .Fields("Exterior").Value = Null
            End If
            
            If Check3.Value = 1 Then
               .Fields("SujetoEmbargado").Value = "SI"
            Else
               .Fields("SujetoEmbargado").Value = Null
            End If
            
            If Check5.Value = 1 Then
               .Fields("RegimenEspecialConstruccionIIBB").Value = "SI"
            Else
               .Fields("RegimenEspecialConstruccionIIBB").Value = Null
            End If

            .Fields("Observaciones").Value = rchObservaciones.TextRTF
            .Fields("ObservacionesPresentacionDocumentacion").Value = rchObservacionesPresentacionDocumentacion.TextRTF
            .Fields("EnviarEmail").Value = 1
            .Fields("Eventual").Value = Null
            If mvarId < 0 Then
               .Fields("IdUsuarioIngreso").Value = glbIdUsuario
               .Fields("FechaIngreso").Value = Now
            Else
               .Fields("IdUsuarioModifico").Value = glbIdUsuario
               .Fields("FechaModifico").Value = Now
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
      
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("ALTA", mvarId, 0, Now, 0, "Tabla : Proveedores", GetCompName(), glbNombreUsuario)
         Else
            est = Modificacion
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("MODIF", mvarId, 0, Now, 0, "Tabla : Proveedores", GetCompName(), glbNombreUsuario)
         End If
            
         If Not actL2 Is Nothing Then
            With actL2
               .ListaEditada = "ProveedoresResumen,ProveedoresDetalle"
               .AccionRegistro = est
               .Disparador = mvarId
            End With
         End If
   
      Case 1
   
         Dim mBorra As Integer
         mBorra = MsgBox("Esta seguro de eliminar los datos definitivamente ?", vbYesNo, "Eliminar")
         If mBorra = vbNo Then
            Exit Sub
         End If
         
         Dim oRs1 As ADOR.Recordset
         Set oRs1 = Aplicacion.ComprobantesProveedores.TraerFiltrado("_VerificarProveedor", mvarId)
         If oRs1.RecordCount > 0 Then
            oRs1.Close
            Set oRs1 = Nothing
            MsgBox "Existen comprobantes asignados a este proveedor, eliminacion abortada", vbExclamation
            Exit Sub
         End If
         oRs1.Close
         Set oRs1 = Nothing
         
         origen.Eliminar
         
         est = baja
         Aplicacion.Tarea "Log_InsertarRegistro", _
               Array("ELIM", mvarId, 0, Now, 0, "Tabla : Proveedores", GetCompName(), glbNombreUsuario)
            
         With actL2
            .ListaEditada = "ProveedoresResumen,ProveedoresDetalle"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
   End Select
   
   Unload Me

   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case -2147217900
         mvarResp = MsgBox("No puede borrar este registro porque se esta" & vbCrLf & "utilizando en otros archivos. Desea ver detalles?", vbYesNo + vbCritical)
         If mvarResp = vbYes Then
            MsgBox "Detalle del error : " & vbCrLf & Err.Number & " -> " & Err.Description
         End If
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oControl As Control
   Dim ListaVacia1 As Boolean, ListaVacia2 As Boolean, ListaVacia3 As Boolean
   Dim mAux1
   
   mvarId = vNewValue
   
   ListaVacia1 = False
   ListaVacia2 = False
   ListaVacia3 = False
   
   mvarNumerarProveedores = False
   If BuscarClaveINI("Numeracion automatica de proveedores") = "SI" Then mvarNumerarProveedores = True
   
   If BuscarClaveINI("Lista de precios en comprobante de proveedores") = "SI" Then
      lblData(13).Visible = True
      DataCombo1(13).Visible = True
   Else
      DataCombo1(2).Width = DataCombo1(3).Width
   End If
   
   Set oAp = Aplicacion
   Set origen = oAp.Proveedores.Item(vNewValue)
   Set oBind = New BindingCollection
   
   Set oRs = oAp.Parametros.Item(1).Registro
   mIGCondicionExcepcion = IIf(IsNull(oRs.Fields("IGCondicionExcepcion").Value), 0, oRs.Fields("IGCondicionExcepcion").Value)
   oRs.Close
   
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetProveedores.TraerMascara
                     ListaVacia1 = True
                  Else
                     Set oRs = origen.DetProveedores.TraerTodos
                     If oRs.RecordCount > 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia1 = False
                     Else
                        Set oControl.DataSource = origen.DetProveedores.TraerMascara
                        ListaVacia1 = True
                     End If
                     oRs.Close
                  End If
               Case "ListaConvenioMultilateral"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetProveedoresIB.TraerMascara
                     ListaVacia2 = True
                  Else
                     Set oRs = origen.DetProveedoresIB.TraerTodos
                     If oRs.RecordCount > 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia2 = False
                     Else
                        Set oControl.DataSource = origen.DetProveedoresIB.TraerMascara
                        ListaVacia2 = True
                     End If
                     oRs.Close
                  End If
               Case "ListaRubros"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetProveedoresRubros.TraerMascara
                     ListaVacia3 = True
                  Else
                     Set oRs = origen.DetProveedoresRubros.TraerTodos
                     If oRs.RecordCount > 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia3 = False
                     Else
                        Set oControl.DataSource = origen.DetProveedoresRubros.TraerMascara
                        ListaVacia3 = True
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
               If oControl.Tag = "ImpuestosDirectosSUSS" Then
                  Set oControl.RowSource = oAp.ImpuestosDirectos.TraerFiltrado("_PorTipoParaCombo", "SUSS")
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
   
   If mvarId = -1 Then
      Set oRs = oAp.Parametros.Item(1).Registro
      With origen.Registro
         .Fields("IdCuenta").Value = oRs.Fields("IdCuentaAcreedoresVarios").Value
         .Fields("IdMoneda").Value = oRs.Fields("IdMoneda").Value
         .Fields("IvaFechaCaducidadExencion").Value = CDate("1/1/1980")
         If mvarNumerarProveedores Then
            mAux1 = TraerValorParametro2("ProximoNumeroProveedor")
            .Fields("CodigoProveedor").Value = IIf(IsNull(mAux1), 1, mAux1)
         End If
      End With
      oRs.Close
      DTPicker1(0).Value = Now
      DTPicker1(1).Enabled = False
      Check1.Value = 1
      Option1.Value = True
      Option8.Value = True
      Option6.Value = True
      Option13.Value = True
      Option14.Value = True
      DataCombo1(8).Enabled = False
   Else
      With origen.Registro
         If Me.Eventual And mvarNumerarProveedores Then
            mAux1 = TraerValorParametro2("ProximoNumeroProveedor")
            .Fields("CodigoProveedor").Value = IIf(IsNull(mAux1), 1, mAux1)
            .Fields("TipoProveedor").Value = 1
            .Fields("CodigoEmpresa").Value = "PC" & Format(.Fields("CodigoProveedor").Value, "0000")
         End If
         If IsNull(.Fields("TipoProveedor").Value) Then
            If mId(.Fields("CodigoEmpresa").Value, 1, 2) = "PC" Then
               Option1.Value = True
            ElseIf mId(.Fields("CodigoEmpresa").Value, 1, 2) = "PB" Then
               Option2.Value = True
            ElseIf mId(.Fields("CodigoEmpresa").Value, 1, 2) = "PE" Then
               Option3.Value = True
            ElseIf mId(.Fields("CodigoEmpresa").Value, 1, 2) = "PV" Then
               Option4.Value = True
            ElseIf mId(.Fields("CodigoEmpresa").Value, 1, 2) = "PS" Then
               Option5.Value = True
            End If
         Else
            Select Case .Fields("TipoProveedor").Value
               Case 1
                  Option1.Value = True
               Case 2
                  Option2.Value = True
               Case 3
                  Option3.Value = True
               Case 4
                  Option4.Value = True
               Case 5
                  Option5.Value = True
            End Select
         End If
         If IsNull(.Fields("IBCondicion").Value) Then
            Option8.Value = True
         Else
            Select Case .Fields("IBCondicion").Value
               Case 1
                  Option8.Value = True
               Case 2
                  Option9.Value = True
               Case 3
                  Option10.Value = True
               Case 4
                  Option11.Value = True
            End Select
         End If
         If IsNull(.Fields("IGCondicion").Value) Then
            Option14.Value = True
         Else
            Select Case .Fields("IGCondicion").Value
               Case 1
                  Option14.Value = True
               Case 2
                  Option15.Value = True
            End Select
         End If
         CUIT1.Text = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
         If .Fields("IvaExencionRetencion").Value = "SI" Then
            Check1.Value = 1
         Else
            Check1.Value = 0
         End If
         If IsNull(.Fields("IvaFechaInicioExencion").Value) Then
            .Fields("IvaFechaInicioExencion").Value = CDate("1/1/1980")
            DTPicker1(7).Value = CDate("1/1/1980")
         End If
         If IsNull(.Fields("IvaFechaCaducidadExencion").Value) Then
            .Fields("IvaFechaCaducidadExencion").Value = CDate("1/1/1980")
            DTPicker1(2).Value = CDate("1/1/1980")
         End If
         If IsNull(.Fields("BienesOServicios").Value) Or .Fields("BienesOServicios").Value = "B" Then
            Option6.Value = True
         Else
            Option7.Value = True
         End If
         If IsNull(.Fields("RetenerSUSS").Value) Or .Fields("RetenerSUSS").Value = "EX" Then
            Option13.Value = True
         ElseIf .Fields("RetenerSUSS").Value = "NO" Then
            Option16.Value = True
         Else
            Option12.Value = True
         End If
         If Not IsNull(.Fields("Exterior").Value) And .Fields("Exterior").Value = "SI" Then
            Check2.Value = 1
         End If
         rchObservaciones.TextRTF = .Fields("Observaciones").Value
         rchObservacionesPresentacionDocumentacion.TextRTF = .Fields("ObservacionesPresentacionDocumentacion").Value
         If Not IsNull(.Fields("SujetoEmbargado").Value) And .Fields("SujetoEmbargado").Value = "SI" Then
            Check3.Value = 1
         Else
            txtSaldoEmbargo.Enabled = False
            txtDetalleEmbargo.Enabled = False
         End If
         If Not IsNull(.Fields("IdTransportista").Value) Then
            Check4.Value = 1
         Else
            DataCombo1(8).Enabled = False
         End If
         If Not IsNull(.Fields("RegimenEspecialConstruccionIIBB").Value) And .Fields("RegimenEspecialConstruccionIIBB").Value = "SI" Then
            Check5.Value = 1
         End If
      End With
   End If
   
   If mvarNumerarProveedores Then
      Option1.Value = True
      Frame1.Enabled = False
      txtCodigoProveedor.Enabled = False
   End If
   
   If ListaVacia1 Then
      Lista.ListItems.Clear
   End If
   Lista.Sorted = False
   
   If ListaVacia2 Then
      ListaConvenioMultilateral.ListItems.Clear
   End If
   ListaConvenioMultilateral.Sorted = False
   
   If ListaVacia3 Then
      ListaRubros.ListItems.Clear
   End If
   ListaRubros.Sorted = False
   
   cmd(1).Enabled = False
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      If mvarId > 0 Then cmd(1).Enabled = True
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub CUIT1_Validate(Cancel As Boolean)

   If Len(CUIT1.Text) > 0 Then
      Dim oRs As ADOR.Recordset
      Dim s As String
      Dim mvarSeguro As Integer
      Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ValidarPorCuit", Array(mvarId, CUIT1.Text))
      s = ""
      With oRs
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               s = s & .Fields("RazonSocial").Value & vbCrLf
               .MoveNext
            Loop
         End If
         .Close
      End With
      Set oRs = Nothing
      If Len(s) > 0 Then
         mvarSeguro = MsgBox("El CUIT lo tienen los siguientes proveedores :" & vbCrLf & s & "Desea continuar ?", vbYesNo, "CUIT")
         If mvarSeguro = vbNo Then
            Cancel = True
         End If
      End If
   End If
   
End Sub

Private Sub DataCombo1_Change(Index As Integer)

   Select Case Index
      Case 0
         If IsNumeric(DataCombo1(Index).BoundText) Then
            Dim oRs As ADOR.Recordset
            Set oRs = Aplicacion.Localidades.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  If Not IsNull(oRs.Fields("IdProvincia").Value) Then
                     .Fields("IdProvincia").Value = oRs.Fields("IdProvincia").Value
                  End If
                  If Not IsNull(oRs.Fields("IdPais").Value) Then
                     .Fields("IdPais").Value = oRs.Fields("IdPais").Value
                  End If
               End With
            End If
            oRs.Close
            Set oRs = Nothing
         End If
'      Case 5
'         If IsNumeric(DataCombo1(Index).BoundText) Then
'            If DataCombo1(Index).BoundText = mIGCondicionExcepcion Then
'               origen.Registro.Fields(DataCombo1(10).DataField).Value = Null
'               DataCombo1(10).Enabled = False
'            Else
'               If Not DataCombo1(10).Enabled Then DataCombo1(10).Enabled = True
'            End If
'         End If
   End Select

End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)
   
'   With DataCombo1(Index)
'      .SelStart = 0
'      .SelLength = Len(.Text)
'   End With
   
   SendKeys "%{DOWN}"
   
End Sub

Private Sub DTPicker1_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTPicker1(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      KeyAscii = 0
      SendKeys "{TAB}", True
   End If

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   With ListaConvenioMultilateral
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   With ListaRubros
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   If mvarId < 0 Then cmd(1).Enabled = False
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
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

Private Sub ListaConvenioMultilateral_DblClick()

   If ListaConvenioMultilateral.ListItems.Count = 0 Then
      EditarConvenioMultilateral -1
   Else
      EditarConvenioMultilateral ListaConvenioMultilateral.SelectedItem.Tag
   End If

End Sub

Private Sub ListaConvenioMultilateral_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaConvenioMultilateral_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetB_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetB_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetB_Click 1
   End If

End Sub

Private Sub ListaConvenioMultilateral_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If ListaConvenioMultilateral.ListItems.Count = 0 Then
         MnuDetB(1).Enabled = False
         MnuDetB(2).Enabled = False
         PopupMenu MnuDet1, , , , MnuDetB(0)
      Else
         MnuDetB(1).Enabled = True
         MnuDetB(2).Enabled = True
         PopupMenu MnuDet1, , , , MnuDetB(1)
      End If
   End If

End Sub

Private Sub ListaRubros_DblClick()

   If ListaRubros.ListItems.Count = 0 Then
      EditarRubros -1
   Else
      EditarRubros ListaRubros.SelectedItem.Tag
   End If

End Sub

Private Sub ListaRubros_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaRubros_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetC_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetC_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetC_Click 1
   End If

End Sub

Private Sub ListaRubros_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If ListaRubros.ListItems.Count = 0 Then
         MnuDetC(1).Enabled = False
         MnuDetC(2).Enabled = False
         PopupMenu MnuDet2, , , , MnuDetC(0)
      Else
         MnuDetC(1).Enabled = True
         MnuDetC(2).Enabled = True
         PopupMenu MnuDet2, , , , MnuDetC(1)
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
            origen.DetProveedores.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub MnuDetB_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarConvenioMultilateral -1
      Case 1
         EditarConvenioMultilateral ListaConvenioMultilateral.SelectedItem.Tag
      Case 2
         With ListaConvenioMultilateral.SelectedItem
            origen.DetProveedoresIB.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub MnuDetC_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarRubros -1
      Case 1
         EditarRubros ListaRubros.SelectedItem.Tag
      Case 2
         With ListaRubros.SelectedItem
            origen.DetProveedoresRubros.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      If Not origen Is Nothing Then
         With origen.Registro
            If Len(txtCodigoProveedor.Text) <= 2 Then
               If mvarNumerarProveedores Then
                  .Fields("CodigoEmpresa").Value = "PC" & Format(IIf(IsNull(.Fields("CodigoProveedor").Value), 0, .Fields("CodigoProveedor").Value), "0000")
               Else
                  If Not IsNumeric(txtCodigoProveedor.Text) Then .Fields("CodigoEmpresa").Value = "PC"
               End If
            End If
         End With
      End If
   End If
   
End Sub

Private Sub Option12_Click()

   If Option12.Value Then
      If Not origen Is Nothing Then origen.Registro.Fields("SUSSFechaCaducidadExencion").Value = Null
      DataCombo1(5).Enabled = True
      DTPicker1(4).Enabled = False
   End If
      
End Sub

Private Sub Option13_Click()

   If Option13.Value Then
      If Not origen Is Nothing Then
         With origen.Registro
            .Fields("IdImpuestoDirectoSUSS").Value = Null
            If IsNull(.Fields("SUSSFechaCaducidadExencion").Value) Then
               .Fields("SUSSFechaCaducidadExencion").Value = Date
               DTPicker1(4).Value = Date
            End If
         End With
      End If
      DataCombo1(5).Enabled = False
      DTPicker1(4).Enabled = True
   End If
      
End Sub

Private Sub Option14_Click()

   If Option14.Value Then
      If Not origen Is Nothing Then
         With origen.Registro
            .Fields("IdTipoRetencionGanancia").Value = Null
         End With
      End If
      DataCombo1(10).Enabled = False
      DTPicker2(0).Enabled = True
   End If
      
End Sub

Private Sub Option15_Click()

   If Option15.Value Then
      DataCombo1(10).Enabled = True
      DTPicker2(0).Enabled = False
   End If
      
End Sub

Private Sub Option16_Click()

   If Option16.Value Then
      If Not origen Is Nothing Then
         With origen.Registro
            .Fields("IdImpuestoDirectoSUSS").Value = Null
            .Fields("SUSSFechaCaducidadExencion").Value = Null
         End With
      End If
      DataCombo1(5).Enabled = False
      DTPicker1(4).Enabled = False
   End If
      
End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      With origen.Registro
         If Len(txtCodigoProveedor.Text) <= 2 Then
            .Fields("CodigoEmpresa").Value = "PB"
         End If
      End With
   End If
   
End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      With origen.Registro
         If Len(txtCodigoProveedor.Text) <= 2 Then
            .Fields("CodigoEmpresa").Value = "PE"
         End If
      End With
   End If
   
End Sub

Private Sub Option4_Click()

   If Option4.Value Then
      With origen.Registro
         If Len(txtCodigoProveedor.Text) <= 2 Then
            .Fields("CodigoEmpresa").Value = "PV"
         End If
      End With
   End If
   
End Sub

Private Sub Option5_Click()

   If Option5.Value Then
      With origen.Registro
         If Len(txtCodigoProveedor.Text) <= 2 Then
            .Fields("CodigoEmpresa").Value = "PS"
         End If
      End With
   End If
   
End Sub

Private Sub Option8_Click()

   If Option8.Value Then
      If Not origen Is Nothing Then
         With origen.Registro
            '.Fields("IBNumeroInscripcion").Value = Null
            .Fields("IdIBCondicionPorDefecto").Value = Null
            .Fields("PorcentajeIBDirecto").Value = Null
            .Fields("FechaInicioVigenciaIBDirecto").Value = Null
            .Fields("FechaFinVigenciaIBDirecto").Value = Null
         End With
      End If
      'txtIBNumeroInscripcion.Enabled = False
      ListaConvenioMultilateral.Enabled = False
      DataCombo1(12).Enabled = False
      DTPicker2(1).Enabled = True
      txtCoeficienteIIBBUnificado.Enabled = False
      txtPorcentajeIBDirecto.Enabled = False
      txtGrupoIIBB.Enabled = False
      DTPicker1(5).Enabled = False
      DTPicker1(6).Enabled = False
   End If
      
End Sub

Private Sub Option9_Click()

   If Option9.Value Then
      'txtIBNumeroInscripcion.Enabled = True
      ListaConvenioMultilateral.Enabled = True
      DataCombo1(12).Enabled = True
      DTPicker2(1).Enabled = False
      txtCoeficienteIIBBUnificado.Enabled = True
      txtPorcentajeIBDirecto.Enabled = True
      txtGrupoIIBB.Enabled = True
      DTPicker1(5).Enabled = True
      DTPicker1(6).Enabled = True
   End If
      
End Sub

Private Sub Option10_Click()

   If Option10.Value Then
      'txtIBNumeroInscripcion.Enabled = True
      ListaConvenioMultilateral.Enabled = False
      DataCombo1(12).Enabled = True
      DTPicker2(1).Enabled = False
      txtCoeficienteIIBBUnificado.Enabled = True
      txtPorcentajeIBDirecto.Enabled = True
      txtGrupoIIBB.Enabled = True
      DTPicker1(5).Enabled = True
      DTPicker1(6).Enabled = True
   End If
      
End Sub

Private Sub Option11_Click()

   If Option11.Value Then
      With origen.Registro
         '.Fields("IBNumeroInscripcion").Value = Null
         .Fields("IdIBCondicionPorDefecto").Value = Null
         .Fields("PorcentajeIBDirecto").Value = Null
         .Fields("FechaInicioVigenciaIBDirecto").Value = Null
         .Fields("FechaFinVigenciaIBDirecto").Value = Null
      End With
      'txtIBNumeroInscripcion.Enabled = False
      ListaConvenioMultilateral.Enabled = False
      DataCombo1(12).Enabled = False
      DTPicker2(1).Enabled = False
      txtCoeficienteIIBBUnificado.Enabled = False
      txtPorcentajeIBDirecto.Enabled = False
      txtGrupoIIBB.Enabled = False
      DTPicker1(5).Enabled = False
      DTPicker1(6).Enabled = False
   End If
      
End Sub

Private Sub txtChequesALaOrdenDe_GotFocus()

   With txtChequesALaOrdenDe
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtChequesALaOrdenDe_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtChequesALaOrdenDe
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtCodigoPostal_GotFocus()

   With txtCodigoPostal
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoPostal_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtCodigoPostal
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtCodigoProveedor_GotFocus()

   With txtCodigoProveedor
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoProveedor_Validate(Cancel As Boolean)

   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ControlPorCodigoEmpresa", Array(txtCodigoProveedor.Text, mvarId))
   If oRs.RecordCount > 0 Then
      MsgBox "Proveedor ya ingresado. Reingrese.", vbCritical
      Cancel = True
   End If
   oRs.Close
   Set oRs = Nothing

End Sub

Private Sub txtCodigoRetencionIVA_GotFocus()

   With txtCodigoRetencionIVA
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoRetencionIVA_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtCodigoRetencionIVA
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtCodigoSituacionRetencionIVA_GotFocus()

   With txtCodigoSituacionRetencionIVA
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoSituacionRetencionIVA_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtCodigoSituacionRetencionIVA
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtContacto_GotFocus()

   With txtContacto
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtContacto_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtContacto
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

'Private Sub txtCuit_GotFocus()
'
'   With txtCuit
'      .SelStart = 0
'      .SelLength = Len(.Text)
'   End With
'
'End Sub
'
'Private Sub txtCuit_KeyPress(KeyAscii As Integer)
'
'   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
'   Else
'      With txtCuit
'         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
'            KeyAscii = 0
'         End If
'      End With
'   End If
'
'End Sub

Private Sub txtDireccion_GotFocus()

   With txtDireccion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDireccion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtDireccion
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtEmail_GotFocus()
   
   With txtEmail
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtEmail_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtEmail
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtFax_GotFocus()

   With txtFax
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtFax_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtFax
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtIBNumeroInscripcion_GotFocus()

   With txtIBNumeroInscripcion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtIBNumeroInscripcion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtIBNumeroInscripcion
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
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
'      SendKeys "{TAB}", True
   Else
      With txtInformacionAuxiliar
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtIvaPorcentajeExencion_GotFocus()

   With txtIvaPorcentajeExencion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtLimiteCredito_GotFocus()

   With txtLimiteCredito
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtLimiteCredito_Validate(Cancel As Boolean)

   If Not IsNumeric(txtLimiteCredito.Text) Then
      MsgBox "Debe ingresar valores numericos", vbExclamation
      Cancel = True
   ElseIf Val(txtLimiteCredito.Text) < 0 Then
      MsgBox "Debe ingresar numeros mayores a cero", vbExclamation
      Cancel = True
   End If

End Sub

Private Sub txtNombre1_GotFocus()

   With txtNombre1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNombre1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtNombre1
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtNombre2_GotFocus()

   With txtNombre2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNombre2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtNombre2
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtNombreFantasia_GotFocus()

   With txtNombreFantasia
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNombreFantasia_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtNombreFantasia
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtPaginaWeb_GotFocus()

   With txtPaginaWeb
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPaginaWeb_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtPaginaWeb
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If
   
End Sub

Private Sub txtRazonSocial_GotFocus()
   
   With txtRazonSocial
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtRazonSocial_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtRazonSocial
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtRazonSocial_LostFocus()

   If Len(txtChequesALaOrdenDe.Text) = 0 Then
      If IsNull(origen.Registro.Fields("ChequesALaOrdenDe").Value) Then
         origen.Registro.Fields("ChequesALaOrdenDe").Value = txtRazonSocial.Text
      End If
   End If
   
End Sub

Private Sub txtTelefono_GotFocus()

   With txtTelefono
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTelefono_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtTelefono
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtTelefono2_GotFocus()

   With txtTelefono2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTelefono2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtTelefono2
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Public Property Get Eventual() As Boolean

   Eventual = mEventual

End Property

Public Property Let Eventual(ByVal vNewValue As Boolean)

   mEventual = vNewValue

End Property
