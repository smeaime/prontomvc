VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmProduccionParte 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Parte de Producción"
   ClientHeight    =   6255
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   10050
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   6255
   ScaleWidth      =   10050
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "Cerrar proceso"
      Height          =   435
      Index           =   6
      Left            =   1680
      TabIndex        =   78
      Top             =   5520
      Width           =   1230
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Cerrar parte"
      Height          =   420
      Index           =   5
      Left            =   3240
      TabIndex        =   76
      Top             =   5520
      Visible         =   0   'False
      Width           =   1230
   End
   Begin VB.CommandButton cmdVerOP 
      Caption         =   "Ver"
      Height          =   315
      Left            =   8880
      TabIndex        =   75
      Top             =   240
      Width           =   495
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Anular parte"
      Height          =   420
      Index           =   4
      Left            =   120
      TabIndex        =   70
      Top             =   5520
      Width           =   1230
   End
   Begin VB.TextBox txtNumero 
      DataField       =   "IdProduccionParte"
      Enabled         =   0   'False
      Height          =   315
      Left            =   1200
      TabIndex        =   47
      Text            =   "NUEVO"
      Top             =   240
      Width           =   1335
   End
   Begin VB.TextBox txtCantidadPrevista 
      Height          =   375
      Left            =   1200
      TabIndex        =   8
      Top             =   7200
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   420
      Index           =   1
      Left            =   8520
      TabIndex        =   5
      Top             =   5520
      Width           =   1230
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   6960
      TabIndex        =   4
      Top             =   5520
      Width           =   1230
   End
   Begin MSComCtl2.DTPicker Fecha 
      DataField       =   "FechaDia"
      Height          =   315
      Left            =   1200
      TabIndex        =   0
      Top             =   600
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   556
      _Version        =   393216
      Format          =   101187585
      CurrentDate     =   39785
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProduccionOrden"
      Height          =   315
      Index           =   11
      Left            =   6480
      TabIndex        =   1
      Tag             =   "ProduccionOrdenes"
      Top             =   240
      Width           =   2370
      _ExtentX        =   4180
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdProduccionOrden"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMaquina"
      Height          =   315
      Index           =   8
      Left            =   6480
      TabIndex        =   10
      Tag             =   "Maquinas"
      Top             =   960
      Width           =   2370
      _ExtentX        =   4180
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdEmpleado"
      Height          =   315
      Index           =   2
      Left            =   1200
      TabIndex        =   11
      Tag             =   "Empleados"
      Top             =   960
      Width           =   2370
      _ExtentX        =   4180
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProduccionProceso"
      Height          =   315
      Index           =   1
      Left            =   6480
      TabIndex        =   12
      Tag             =   "Procesos"
      Top             =   600
      Width           =   2370
      _ExtentX        =   4180
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdProduccionProceso"
      Text            =   ""
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   3135
      Left            =   120
      TabIndex        =   14
      Top             =   2040
      Width           =   9720
      _ExtentX        =   17145
      _ExtentY        =   5530
      _Version        =   393216
      Tabs            =   5
      Tab             =   4
      TabsPerRow      =   5
      TabHeight       =   520
      TabCaption(0)   =   "Paro"
      TabPicture(0)   =   "frmMiniParte.frx":0000
      Tab(0).ControlEnabled=   0   'False
      Tab(0).Control(0)=   "txtCausaParo"
      Tab(0).Control(1)=   "ParoInicio"
      Tab(0).Control(2)=   "ParoFinal"
      Tab(0).Control(3)=   "lblPeso(0)"
      Tab(0).Control(4)=   "lblHoraInicio(1)"
      Tab(0).Control(5)=   "lblHoraFinal(0)"
      Tab(0).ControlCount=   6
      TabCaption(1)   =   "Consumo"
      TabPicture(1)   =   "frmMiniParte.frx":001C
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "lblPeso(5)"
      Tab(1).Control(1)=   "lblPeso(3)"
      Tab(1).Control(2)=   "lblLabels(0)"
      Tab(1).Control(3)=   "lblLabels(16)"
      Tab(1).Control(4)=   "lblColor(2)"
      Tab(1).Control(5)=   "lblPeso(4)"
      Tab(1).Control(6)=   "lblStock(2)"
      Tab(1).Control(7)=   "lblLabels(6)"
      Tab(1).Control(8)=   "lblMensaje"
      Tab(1).Control(9)=   "lblLabels(1)"
      Tab(1).Control(10)=   "lbl(2)"
      Tab(1).Control(11)=   "lblUnid"
      Tab(1).Control(12)=   "lblLabels(3)"
      Tab(1).Control(13)=   "dcfields(30)"
      Tab(1).Control(14)=   "dcfields(20)"
      Tab(1).Control(15)=   "txtPendiente"
      Tab(1).Control(16)=   "DataCombo1(13)"
      Tab(1).Control(17)=   "DataCombo1(2)"
      Tab(1).Control(18)=   "dcfields(0)"
      Tab(1).Control(19)=   "txtPeso"
      Tab(1).Control(20)=   "txtPartida"
      Tab(1).Control(21)=   "txtTolerancia"
      Tab(1).Control(22)=   "cmd(2)"
      Tab(1).Control(23)=   "cmd(3)"
      Tab(1).Control(24)=   "txtStockActual"
      Tab(1).Control(25)=   "txtMaximoEsperado"
      Tab(1).Control(26)=   "txtToleranciaCopia"
      Tab(1).Control(27)=   "cmdVerStock"
      Tab(1).ControlCount=   28
      TabCaption(2)   =   "Control de Calidad"
      TabPicture(2)   =   "frmMiniParte.frx":0038
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "lblTipoDe(0)"
      Tab(2).Control(1)=   "lblTipoDe(1)"
      Tab(2).Control(2)=   "lblTipoDe(2)"
      Tab(2).Control(3)=   "lblTipoDe(3)"
      Tab(2).Control(4)=   "lblTipoDe(4)"
      Tab(2).Control(5)=   "lblTipoDe(5)"
      Tab(2).Control(6)=   "txtMaximo(0)"
      Tab(2).Control(7)=   "txtMaximo(1)"
      Tab(2).Control(8)=   "txtMaximo(2)"
      Tab(2).Control(9)=   "txtMaximo(3)"
      Tab(2).Control(10)=   "txtMaximo(4)"
      Tab(2).Control(11)=   "dcfields(3)"
      Tab(2).ControlCount=   12
      TabCaption(3)   =   "Turno"
      TabPicture(3)   =   "frmMiniParte.frx":0054
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "lblHoraInicio(0)"
      Tab(3).Control(1)=   "lblHoraFinal(1)"
      Tab(3).Control(2)=   "TurnoFinal"
      Tab(3).Control(3)=   "TurnoInicio"
      Tab(3).ControlCount=   4
      TabCaption(4)   =   "Terminado/Subprod."
      TabPicture(4)   =   "frmMiniParte.frx":0070
      Tab(4).ControlEnabled=   -1  'True
      Tab(4).Control(0)=   "lblPeso(2)"
      Tab(4).Control(0).Enabled=   0   'False
      Tab(4).Control(1)=   "lblPeso(6)"
      Tab(4).Control(1).Enabled=   0   'False
      Tab(4).Control(2)=   "lblPeso(7)"
      Tab(4).Control(2).Enabled=   0   'False
      Tab(4).Control(3)=   "Line1"
      Tab(4).Control(3).Enabled=   0   'False
      Tab(4).Control(4)=   "lblArtículo(0)"
      Tab(4).Control(4).Enabled=   0   'False
      Tab(4).Control(5)=   "lblArticuloProducido"
      Tab(4).Control(5).Enabled=   0   'False
      Tab(4).Control(6)=   "lblInfoProduccion"
      Tab(4).Control(6).Enabled=   0   'False
      Tab(4).Control(7)=   "dcfields(4)"
      Tab(4).Control(7).Enabled=   0   'False
      Tab(4).Control(8)=   "txtCantidadProducida"
      Tab(4).Control(8).Enabled=   0   'False
      Tab(4).Control(9)=   "txtCantidadDeshecho"
      Tab(4).Control(9).Enabled=   0   'False
      Tab(4).ControlCount=   10
      Begin VB.CommandButton cmdVerStock 
         Caption         =   "Asignar partida"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   885
         Left            =   -71160
         TabIndex        =   79
         Top             =   1680
         Width           =   1605
      End
      Begin VB.TextBox txtToleranciaCopia 
         Enabled         =   0   'False
         Height          =   315
         Left            =   -70200
         TabIndex        =   71
         Top             =   1440
         Visible         =   0   'False
         Width           =   855
      End
      Begin VB.TextBox txtMaximoEsperado 
         Enabled         =   0   'False
         Height          =   315
         Left            =   -70200
         TabIndex        =   66
         Top             =   1800
         Visible         =   0   'False
         Width           =   855
      End
      Begin VB.TextBox txtStockActual 
         Alignment       =   1  'Right Justify
         BackColor       =   &H8000000F&
         BorderStyle     =   0  'None
         DataField       =   "Aux_txtStockActual"
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "0.00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   3082
            SubFormatType   =   0
         EndProperty
         Enabled         =   0   'False
         Height          =   315
         Left            =   -68160
         TabIndex        =   64
         Text            =   "000"
         Top             =   1440
         Width           =   1095
      End
      Begin VB.CommandButton cmd 
         Caption         =   "&Asignar partida viejo"
         Height          =   405
         Index           =   3
         Left            =   -74760
         TabIndex        =   63
         Top             =   2280
         Visible         =   0   'False
         Width           =   1455
      End
      Begin VB.CommandButton cmd 
         Caption         =   "Ver stock"
         Height          =   405
         Index           =   2
         Left            =   -74760
         TabIndex        =   62
         Top             =   2280
         Visible         =   0   'False
         Width           =   1485
      End
      Begin VB.TextBox txtCantidadDeshecho 
         DataField       =   "CantidadDeshecho"
         Height          =   315
         Left            =   1920
         TabIndex        =   56
         Top             =   2280
         Width           =   1335
      End
      Begin VB.TextBox txtTolerancia 
         Appearance      =   0  'Flat
         BackColor       =   &H8000000F&
         BorderStyle     =   0  'None
         DataField       =   "Aux_txtTolerancia"
         Enabled         =   0   'False
         Height          =   315
         Left            =   -66600
         TabIndex        =   51
         Text            =   "00"
         Top             =   1800
         Width           =   495
      End
      Begin VB.TextBox txtCantidadProducida 
         DataField       =   "CantidadGenerado"
         Height          =   315
         Left            =   1920
         TabIndex        =   49
         Top             =   1080
         Width           =   1335
      End
      Begin MSDataListLib.DataCombo dcfields 
         DataField       =   "IdPROD_TiposControlCalidad"
         Height          =   315
         Index           =   3
         Left            =   -73800
         TabIndex        =   20
         Tag             =   "TiposControlCalidad"
         Top             =   960
         Width           =   2535
         _ExtentX        =   4471
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdPROD_TiposControlCalidad"
         Text            =   ""
      End
      Begin VB.ComboBox txtCausaParo 
         DataField       =   "ParoObservacion"
         Height          =   315
         ItemData        =   "frmMiniParte.frx":008C
         Left            =   -73800
         List            =   "frmMiniParte.frx":009F
         TabIndex        =   34
         Top             =   960
         Width           =   3135
      End
      Begin VB.TextBox txtPartida 
         Alignment       =   1  'Right Justify
         DataField       =   "Partida"
         BeginProperty DataFormat 
            Type            =   1
            Format          =   "0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   11274
            SubFormatType   =   1
         EndProperty
         Height          =   315
         Left            =   -74040
         TabIndex        =   29
         Top             =   3480
         Visible         =   0   'False
         Width           =   1185
      End
      Begin VB.TextBox txtPeso 
         DataField       =   "Cantidad"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   435
         Left            =   -68160
         TabIndex        =   26
         Top             =   2160
         Width           =   1575
      End
      Begin VB.TextBox txtMaximo 
         Alignment       =   1  'Right Justify
         DataField       =   "Control5"
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "0.00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   11274
            SubFormatType   =   0
         EndProperty
         Height          =   315
         Index           =   4
         Left            =   -68160
         TabIndex        =   19
         Top             =   2340
         Visible         =   0   'False
         Width           =   975
      End
      Begin VB.TextBox txtMaximo 
         Alignment       =   1  'Right Justify
         DataField       =   "Control4"
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "0.00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   11274
            SubFormatType   =   0
         EndProperty
         Height          =   315
         Index           =   3
         Left            =   -68160
         TabIndex        =   18
         Top             =   1980
         Visible         =   0   'False
         Width           =   975
      End
      Begin VB.TextBox txtMaximo 
         Alignment       =   1  'Right Justify
         DataField       =   "Control3"
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "0.00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   11274
            SubFormatType   =   0
         EndProperty
         Height          =   315
         Index           =   2
         Left            =   -68160
         TabIndex        =   17
         Top             =   1620
         Visible         =   0   'False
         Width           =   975
      End
      Begin VB.TextBox txtMaximo 
         Alignment       =   1  'Right Justify
         DataField       =   "Control2"
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "0.00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   11274
            SubFormatType   =   0
         EndProperty
         Height          =   315
         Index           =   1
         Left            =   -68160
         TabIndex        =   16
         Top             =   1260
         Visible         =   0   'False
         Width           =   975
      End
      Begin VB.TextBox txtMaximo 
         Alignment       =   1  'Right Justify
         DataField       =   "Control1"
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "0.00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   11274
            SubFormatType   =   0
         EndProperty
         Height          =   315
         Index           =   0
         Left            =   -68160
         TabIndex        =   15
         Top             =   900
         Visible         =   0   'False
         Width           =   975
      End
      Begin MSDataListLib.DataCombo dcfields 
         DataField       =   "IdStock"
         Height          =   315
         Index           =   0
         Left            =   -71880
         TabIndex        =   30
         Top             =   2040
         Visible         =   0   'False
         Width           =   2415
         _ExtentX        =   4260
         _ExtentY        =   556
         _Version        =   393216
         Enabled         =   0   'False
         ListField       =   "Titulo"
         BoundColumn     =   "IdStock"
         Text            =   ""
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdUbicacion"
         Height          =   315
         Index           =   2
         Left            =   -74040
         TabIndex        =   31
         Tag             =   "Ubicaciones"
         Top             =   3120
         Visible         =   0   'False
         Width           =   3285
         _ExtentX        =   5794
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdUbicacion"
         Text            =   ""
      End
      Begin MSComCtl2.DTPicker ParoInicio 
         DataField       =   "ParoInicio"
         Height          =   375
         Left            =   -73800
         TabIndex        =   35
         Top             =   1440
         Width           =   2175
         _ExtentX        =   3836
         _ExtentY        =   661
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
         CheckBox        =   -1  'True
         CustomFormat    =   "ddd d/MM  HH:mm"
         DateIsNull      =   -1  'True
         Format          =   101187587
         CurrentDate     =   39785
      End
      Begin MSComCtl2.DTPicker ParoFinal 
         DataField       =   "ParoFinal"
         Height          =   375
         Left            =   -73800
         TabIndex        =   36
         Top             =   1920
         Width           =   2175
         _ExtentX        =   3836
         _ExtentY        =   661
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
         CheckBox        =   -1  'True
         CustomFormat    =   "ddd d/MM  HH:mm"
         DateIsNull      =   -1  'True
         Format          =   101187587
         CurrentDate     =   39785
      End
      Begin MSComCtl2.DTPicker TurnoInicio 
         DataField       =   "FechaInicio"
         Height          =   495
         Left            =   -73200
         TabIndex        =   40
         Top             =   900
         Width           =   3975
         _ExtentX        =   7011
         _ExtentY        =   873
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         CheckBox        =   -1  'True
         CustomFormat    =   "ddd d/MM  HH:mm"
         DateIsNull      =   -1  'True
         Format          =   101187587
         CurrentDate     =   39785
      End
      Begin MSComCtl2.DTPicker TurnoFinal 
         DataField       =   "FechaFinal"
         Height          =   495
         Left            =   -73200
         TabIndex        =   41
         Top             =   1620
         Width           =   3975
         _ExtentX        =   7011
         _ExtentY        =   873
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         CheckBox        =   -1  'True
         CustomFormat    =   "ddd d/MM  HH:mm"
         DateIsNull      =   -1  'True
         Format          =   101187587
         CurrentDate     =   39785
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "idColor"
         Height          =   315
         Index           =   13
         Left            =   -71280
         TabIndex        =   45
         Tag             =   "Colores"
         Top             =   2280
         Visible         =   0   'False
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   556
         _Version        =   393216
         Enabled         =   0   'False
         ListField       =   "Titulo"
         BoundColumn     =   "IdColor"
         Text            =   ""
      End
      Begin MSDataListLib.DataCombo dcfields 
         DataField       =   "IdArticuloDeshecho"
         Height          =   315
         Index           =   4
         Left            =   1920
         TabIndex        =   55
         Top             =   1920
         Width           =   5775
         _ExtentX        =   10186
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdArticulo"
         Text            =   ""
      End
      Begin VB.TextBox txtPendiente 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H8000000F&
         BorderStyle     =   0  'None
         DataField       =   "Aux_txtPendiente"
         Enabled         =   0   'False
         Height          =   315
         Left            =   -68160
         TabIndex        =   53
         Text            =   "000"
         Top             =   1800
         Width           =   1095
      End
      Begin MSDataListLib.DataCombo dcfields 
         DataField       =   "Partida"
         Height          =   315
         Index           =   20
         Left            =   -68160
         TabIndex        =   68
         Top             =   960
         Width           =   2295
         _ExtentX        =   4048
         _ExtentY        =   556
         _Version        =   393216
         Enabled         =   0   'False
         ListField       =   "Titulo"
         BoundColumn     =   "Titulo"
         Text            =   ""
      End
      Begin MSDataListLib.DataCombo dcfields 
         DataField       =   "IdUbicacion"
         Height          =   315
         Index           =   30
         Left            =   -73920
         TabIndex        =   73
         Tag             =   "Ubicaciones"
         Top             =   960
         Width           =   4365
         _ExtentX        =   7699
         _ExtentY        =   556
         _Version        =   393216
         Enabled         =   0   'False
         ListField       =   "Titulo"
         BoundColumn     =   "IdUbicacion"
         Text            =   ""
      End
      Begin VB.Label lblInfoProduccion 
         Caption         =   "La OP produce un terminado. Solo se modifica su stock a traves del etiquetado"
         ForeColor       =   &H000000FF&
         Height          =   225
         Left            =   3480
         TabIndex        =   77
         Top             =   1200
         Visible         =   0   'False
         Width           =   5760
      End
      Begin VB.Label lblLabels 
         Caption         =   "Ubicación"
         Height          =   255
         Index           =   3
         Left            =   -74760
         TabIndex        =   74
         Top             =   1080
         Width           =   915
      End
      Begin VB.Label lblUnid 
         Caption         =   "Unid."
         Height          =   255
         Left            =   -66120
         TabIndex        =   72
         Top             =   1800
         Width           =   495
      End
      Begin VB.Label lbl 
         Caption         =   "+/-"
         Height          =   225
         Index           =   2
         Left            =   -66960
         TabIndex        =   69
         Top             =   1800
         Width           =   240
      End
      Begin VB.Label lblLabels 
         Caption         =   "Partida:"
         Height          =   255
         Index           =   1
         Left            =   -69240
         TabIndex        =   67
         Top             =   1080
         Width           =   915
      End
      Begin VB.Label lblMensaje 
         ForeColor       =   &H000000FF&
         Height          =   375
         Left            =   -74760
         TabIndex        =   44
         Top             =   480
         Width           =   6855
      End
      Begin VB.Label lblLabels 
         Caption         =   "Stock actual "
         Height          =   300
         Index           =   6
         Left            =   -69240
         TabIndex        =   65
         Top             =   1440
         Width           =   1140
      End
      Begin VB.Label lblStock 
         Caption         =   "Stock"
         Height          =   225
         Index           =   2
         Left            =   -72120
         TabIndex        =   61
         Top             =   2160
         Visible         =   0   'False
         Width           =   600
      End
      Begin VB.Label lblArticuloProducido 
         Height          =   255
         Left            =   1920
         TabIndex        =   60
         Top             =   840
         Width           =   5895
      End
      Begin VB.Label lblArtículo 
         Caption         =   "Producto"
         Height          =   225
         Index           =   0
         Left            =   360
         TabIndex        =   59
         Top             =   840
         Width           =   1560
      End
      Begin VB.Line Line1 
         X1              =   360
         X2              =   9480
         Y1              =   1680
         Y2              =   1680
      End
      Begin VB.Label lblPeso 
         Caption         =   "Subproducto"
         Height          =   225
         Index           =   7
         Left            =   360
         TabIndex        =   58
         Top             =   2040
         Width           =   1080
      End
      Begin VB.Label lblPeso 
         Caption         =   "Cantidad"
         Height          =   225
         Index           =   6
         Left            =   360
         TabIndex        =   57
         Top             =   2400
         Width           =   1080
      End
      Begin VB.Label lblPeso 
         Caption         =   "Tolerancia"
         Height          =   225
         Index           =   4
         Left            =   -70680
         TabIndex        =   52
         Top             =   1560
         Visible         =   0   'False
         Width           =   1080
      End
      Begin VB.Label lblPeso 
         Caption         =   "Cantidad Producida"
         Height          =   225
         Index           =   2
         Left            =   360
         TabIndex        =   50
         Top             =   1200
         Width           =   1560
      End
      Begin VB.Label lblColor 
         Caption         =   "Color"
         Height          =   255
         Index           =   2
         Left            =   -71760
         TabIndex        =   46
         Top             =   2400
         Visible         =   0   'False
         Width           =   615
      End
      Begin VB.Label lblHoraFinal 
         Caption         =   "Hora Final"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Index           =   1
         Left            =   -74760
         TabIndex        =   43
         Top             =   1740
         Width           =   1560
      End
      Begin VB.Label lblHoraInicio 
         Caption         =   "Hora Inicio"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Index           =   0
         Left            =   -74760
         TabIndex        =   42
         Top             =   1020
         Width           =   1560
      End
      Begin VB.Label lblPeso 
         Caption         =   "Causa"
         Height          =   225
         Index           =   0
         Left            =   -74760
         TabIndex        =   39
         Top             =   1080
         Width           =   720
      End
      Begin VB.Label lblHoraInicio 
         Caption         =   "Hora Inicio"
         Height          =   255
         Index           =   1
         Left            =   -74760
         TabIndex        =   38
         Top             =   1560
         Width           =   840
      End
      Begin VB.Label lblHoraFinal 
         Caption         =   "Hora Final"
         Height          =   225
         Index           =   0
         Left            =   -74760
         TabIndex        =   37
         Top             =   2040
         Width           =   840
      End
      Begin VB.Label lblLabels 
         Caption         =   "Ubicacion :"
         Height          =   255
         Index           =   16
         Left            =   -75000
         TabIndex        =   33
         Top             =   3240
         Visible         =   0   'False
         Width           =   915
      End
      Begin VB.Label lblLabels 
         Caption         =   "Partida :"
         Height          =   300
         Index           =   0
         Left            =   -75000
         TabIndex        =   32
         Top             =   3600
         Visible         =   0   'False
         Width           =   1815
      End
      Begin VB.Label lblTipoDe 
         Caption         =   "Tipo"
         Height          =   255
         Index           =   5
         Left            =   -74760
         TabIndex        =   28
         Top             =   1080
         Width           =   495
      End
      Begin VB.Label lblPeso 
         Caption         =   "Peso"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Index           =   3
         Left            =   -69240
         TabIndex        =   27
         Top             =   2280
         Width           =   1080
      End
      Begin VB.Label lblTipoDe 
         Caption         =   "Parámetro 5"
         Height          =   255
         Index           =   4
         Left            =   -70320
         TabIndex        =   25
         Top             =   2460
         Visible         =   0   'False
         Width           =   2055
      End
      Begin VB.Label lblTipoDe 
         Caption         =   "Parámetro 4"
         Height          =   255
         Index           =   3
         Left            =   -70320
         TabIndex        =   24
         Top             =   2100
         Visible         =   0   'False
         Width           =   2055
      End
      Begin VB.Label lblTipoDe 
         Caption         =   "Parámetro 3"
         Height          =   255
         Index           =   2
         Left            =   -70320
         TabIndex        =   23
         Top             =   1740
         Visible         =   0   'False
         Width           =   2055
      End
      Begin VB.Label lblTipoDe 
         Caption         =   "Parámetro 2"
         Height          =   255
         Index           =   1
         Left            =   -70320
         TabIndex        =   22
         Top             =   1380
         Visible         =   0   'False
         Width           =   2055
      End
      Begin VB.Label lblTipoDe 
         Caption         =   "Parámetro 1"
         Height          =   255
         Index           =   0
         Left            =   -70320
         TabIndex        =   21
         Top             =   1020
         Visible         =   0   'False
         Width           =   2055
      End
      Begin VB.Label lblPeso 
         Caption         =   "Pendiente"
         Height          =   225
         Index           =   5
         Left            =   -69240
         TabIndex        =   54
         Top             =   1800
         Width           =   1080
      End
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   5
      Left            =   1200
      TabIndex        =   80
      Top             =   1440
      Width           =   4125
      _ExtentX        =   7276
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin VB.Label lblArtículo 
      Caption         =   "Artículo consumido"
      Height          =   465
      Index           =   1
      Left            =   120
      TabIndex        =   83
      Top             =   1440
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Color "
      Height          =   255
      Index           =   10
      Left            =   5520
      TabIndex        =   82
      Top             =   1560
      Width           =   615
   End
   Begin VB.Label lblColorConsumido 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "_______"
      ForeColor       =   &H80000008&
      Height          =   300
      Left            =   6480
      TabIndex        =   81
      Top             =   1440
      Width           =   2595
   End
   Begin VB.Label lblPeso 
      Caption         =   "Parte N°"
      Height          =   225
      Index           =   1
      Left            =   120
      TabIndex        =   48
      Top             =   360
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Proceso"
      Height          =   300
      Index           =   2
      Left            =   5520
      TabIndex        =   13
      Top             =   720
      Width           =   1815
   End
   Begin VB.Label lblEmpleado 
      Caption         =   "Cant. Prevista"
      Height          =   465
      Index           =   2
      Left            =   240
      TabIndex        =   9
      Top             =   7200
      Visible         =   0   'False
      Width           =   960
   End
   Begin VB.Label lblEmpleado 
      Caption         =   "Máquina"
      Height          =   225
      Index           =   1
      Left            =   5520
      TabIndex        =   7
      Top             =   1080
      Width           =   1080
   End
   Begin VB.Label lblEmpleado 
      Caption         =   "Emitido por:"
      Height          =   225
      Index           =   0
      Left            =   120
      TabIndex        =   6
      Top             =   1080
      Width           =   1080
   End
   Begin VB.Label lblFecha 
      Caption         =   "Fecha"
      Height          =   225
      Index           =   1
      Left            =   120
      TabIndex        =   3
      Top             =   720
      Width           =   1080
   End
   Begin VB.Label lblOrdenDe 
      Caption         =   "OP"
      Height          =   225
      Index           =   0
      Left            =   5520
      TabIndex        =   2
      Top             =   360
      Width           =   480
   End
End
Attribute VB_Name = "frmProduccionParte"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim WithEvents origen As ComPronto.ProduccionParte
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm

Public habilitado As Boolean

Private mvarId As Long

Private mNivelAcceso As Integer, mOpcionesAcceso As String
Dim WithEvents ActL As ControlForm
Attribute ActL.VB_VarHelpID = -1

Const dcf_OP = 11
Const dcf_PROCESO = 1
Const dcf_MAQUINA = 8
Const dcf_ARTICULO = 5
Const dcf_UBICACION = 30
Const dcf_CALIDAD = 3
Const dcf_PARTIDA = 20
Const dcf_ARTICULODESHECHO = 4


Dim SinLimite As Boolean
Dim IdMaquinaOriginal As Long

Public Property Let NivelAcceso(ByVal mNivelA As EnumAccesos)
   
    mNivelAcceso = mNivelA
   
End Property

Public Property Get NivelAcceso() As EnumAccesos

    NivelAcceso = mNivelAcceso
   
End Property

Public Property Get mhabilitado() As Boolean

    mhabilitado = habilitado
   
End Property

Public Property Let OpcionesAcceso(ByVal mOpcionesA As String)
   
    mOpcionesAcceso = mOpcionesA
   
End Property

Public Property Get OpcionesAcceso() As String

    OpcionesAcceso = mOpcionesAcceso
   
End Property

Public Sub cmd_Click(Index As Integer)
    'On Error Resume Next
    On Error GoTo Mal
   
    Select Case Index
   
        Case 0
            Me.MousePointer = vbHourglass

            If Not IsValid() Then
                Me.MousePointer = vbDefault
                Exit Sub
            End If
         
            If Not IsNull(TurnoFinal) Then origen.Registro!IdUsuarioCerro = glbIdUsuario
         
            Select Case GuardarParteDesdeGUI(origen) ' origen.Guardar

                Case ComPronto.MisEstados.Correcto

                Case ComPronto.MisEstados.ModificadoPorOtro
                    Me.MousePointer = vbDefault

                    MsgBox "El Registro ha sido modificado"

                Case ComPronto.MisEstados.NoExiste
                    Me.MousePointer = vbDefault

                    MsgBox "El registro ha sido eliminado"

                Case ComPronto.MisEstados.ErrorDeDatos
                    Me.MousePointer = vbDefault

                    MsgBox "Error de ingreso de datos"
            End Select
      
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            'si el Inicio del parte es menor que el agendado al proceso, modificarlo
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            VerificarAgenda
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            
            
            
            
            
            
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            
            'me traigo este codigo que estaba en CerrarParteYProceso
            'reetiqueto siempre que sobre material (solo al cerrar    parte)
                                                                  
    
    'acá Hector quizas prefiera que se etiquete siempre
    '-pero pinta que se pasa por acá siempre...
    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9626
    
    'si cerré el proceso y hice un consumo del que sobró material, lo debo etiqutar
    If origen.Registro!IdUsuarioCerro > 0 And _
        Val(txtPeso) < Val(txtStockActual) And SSTab1.TabEnabled(1) _
        And IsNumeric(dcfields(dcf_ARTICULO).BoundText) And _
        IsNumeric(dcfields(dcf_UBICACION).BoundText) Then
        
        If ReetiquetarElSobranteCreandoUnaNuevaPartida(dcfields(dcf_ARTICULO).BoundText, ProduccionModulo.BuscaIdColor(lblColorConsumido), origen.Registro!IdUnidad, dcfields(dcf_UBICACION).BoundText, Val(txtStockActual) - Val(txtPeso), TraerValorParametro2("IdObraDefault"), 99999, dcfields(dcf_PARTIDA).Text) Then
            PonerEnCeroElStockOriginalSobrante dcfields(dcf_ARTICULO).BoundText, dcfields(dcf_PARTIDA).Text, ProduccionModulo.BuscaIdColor(lblColorConsumido), Val(txtStockActual) - Val(txtPeso), origen.Registro!IdUnidad, dcfields(dcf_UBICACION).BoundText, Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", origen.Registro!IdStock).Fields("IdObra"), origen.Registro!IdStock, origen '  TraerValorParametro2("IdObraDefault")

        End If
    End If
     
     
            
            
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            
            
            
            
            
            
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
      
            CerrarParteYProceso
      
            '            If Not SSTab1.TabEnabled(1) Or EnTolerancia Then
            '                Dim mvarResp
            '                mvarResp = MsgBox("Dar proceso por cerrado?", vbYesNo)
            '
            '                estantodoslistos
            '
            '                If mvarResp = vbYes Then
            '                End If
            '
            '            End If
      
            Dim est As EnumAcciones

            If mvarId < 0 Then
                est = alta
                mvarId = origen.Registro.Fields(0).Value
                'mvarGrabado = True
            Else
                est = Modificacion
            End If

            Dim esteparte As ComPronto.ProduccionParte
            Set esteparte = AplicacionProd.ProduccionPartes.Item(mvarId)
            
            
            
               '      por qué hace falta que sea un alta? si fuese una edicion, tambien
               'deberias mostrar el etiquetador... solo una vez. Cuando tienen el idstock asociado por primera
               'vez, ahi lo mostras. si no, no
                     
            If est = alta _
                And (iisNull(esteparte.Registro!CantidadGenerado, 0) <> 0 _
                Or iisNull(esteparte.Registro!Cantidaddeshecho, 0) <> 0) Then
            'And (esteparte.Registro!idoiproducto > 0 Or esteparte.Registro!idoisubproducto > 0) Then
                'llama tanto si es semielaborado como si es terminado????
                '-llama si hubo un ingreso....
                'pero en el terminado no hay ingreso! y encima, pinta que no lo llama en el semielaborado tampoco!
                '-hagamos asì entonces: si hay cantidad, que haga la etiqueta
                '-pero entonces va a haber que aumentar el stock en el caso que sea un terminado!!!!!!!
                '-còmo? LlamarEtiquetadoDeMaterialCreado() no hace el alta de stock?
                '-obvio que no!! o mejor dicho, no deberìa
                '-verificalo pues
                                '-(despues) verificado. claro que da un alta en UnidadesEmpaque
                                
                                
                 LlamarEtiquetadoDeMaterialCreado
            End If







            Me.MousePointer = vbDefault

            With actL2
        
                .ListaEditada = "PartedeProduccion"
                .AccionRegistro = est
                .Disparador = mvarId
            End With
          
            Unload Me
        
        Case 4
   
            AnularParte

        Case 5

            If SSTab1.TabEnabled(1) And Not EnTolerancia Then 'está habilitada la ficha de consumo y el pesaje está en rango
                CerrarParteYProceso
            Else
                CerrarParte
            End If
        
            If mvarId < 0 Then
                est = alta
                mvarId = origen.Registro.Fields(0).Value
                'mvarGrabado = True
            Else
                est = Modificacion
            End If
            
            With actL2
        
                .ListaEditada = "PartedeProduccion"
                .AccionRegistro = est
                .Disparador = mvarId
            End With
        
            Unload Me
    
        Case 6
            
            origen.Registro.Fields("IdUsuarioCerro").Value = dcfields(2).BoundText
            Dim oOF As ComPronto.ProduccionOrden
            Set oOF = AplicacionProd.ProduccionOrdenes.Item(origen.Registro.Fields("IdProduccionOrden").Value)

            If PedirPermisosDeSupervisorCapen(mNivelAcceso) Then
                CierroElProceso oOF, origen.Registro.Fields("IdProduccionProceso").Value, origen.Registro.Fields("IdProduccionParte").Value
            Else
                Exit Sub
            End If

            'GuardarOrdenDesdeGUI oOF
            Select Case oOF.Guardar

                Case ComPronto.MisEstados.Correcto

                Case ComPronto.MisEstados.ModificadoPorOtro
                    MsgBox "El Regsitro ha sido modificado"

                Case ComPronto.MisEstados.NoExiste
                    MsgBox "El registro ha sido eliminado"

                Case ComPronto.MisEstados.ErrorDeDatos
                    MsgBox "Error de ingreso de datos"
            End Select

            CerrarParteYProceso (False)
        
            If mvarId < 0 Then
                est = alta
                mvarId = origen.Registro.Fields(0).Value
                'mvarGrabado = True
            Else
                est = Modificacion
            End If
            
            With actL2
        
                .ListaEditada = "PartedeProduccion"
                .AccionRegistro = est
                .Disparador = mvarId
            End With
       
            Unload Me
    
        Case 1
       
            Unload Me
    
            '    Case verstock
            '
            '    Set oF = New frmConsulta1
            '    With oF
            '       .Id = 1
            '       .Show vbModal, Me
            '    End With
            '    Unload oF
            '    Set oF = Nothing
            '
            '    Case asignarpartida
            '
            '       If IsNull(origen.Registro.Fields("IdArticulo").Value) Then
            '          MsgBox "No ha definido el material", vbExclamation
            '          Exit Sub
            '       Else
            '          Dim of2 As frmConsultaStockPorPartidas
            '          Set of2 = New frmConsultaStockPorPartidas
            '          With of2
            '             .Articulo = origen.Registro.Fields("IdArticulo").Value
            '             .Show vbModal, Me
            '          End With
            '          Unload of2
            '          Set of2 = Nothing
            '       End If
            '

        Case 2
            Dim oF As frmConsulta1
            Set oF = New frmConsulta1

            With oF
                .Id = 1
                .Show vbModal, Me
            End With

            Unload oF
            Set oF = Nothing
      
        Case 3
            Dim art As ComPronto.Articulo

            If IsNull(origen.Registro.Fields("IdArticulo").Value) Then
                MsgBox "No ha definido el material", vbExclamation
                Exit Sub
            Else
                Dim of2 As frmConsultaStockPorPartidas
                Set of2 = New frmConsultaStockPorPartidas

                With of2
                    .mvarIdUbicacion = IIf(dcfields(dcf_UBICACION).BoundText = "", -1, dcfields(dcf_UBICACION).BoundText)
                    .Articulo = origen.Registro.Fields("IdArticulo").Value
                    .Show vbModal, Me
                End With
            
                Dim oL As ListItem
                Set oL = of2.Lista.SelectedItem

                If Not oL Is Nothing Then
            
                    Debug.Print oL.SubItems(4), oL.SubItems(5) 'ubic,partida
            
                    dcfields(dcf_UBICACION).BoundText = oL.SubItems(10) 'ubic
            
                    'refrescar combo de partidas?
                    Dim rs As Recordset
                    Set rs = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionParte", "_PartidasDisponiblesPorOrdenProcesoParaCombo", Array(dcfields(dcf_OP).BoundText, BuscaIdProceso(dcfields(dcf_PROCESO).Text), BuscaIdArticulo(dcfields(dcf_ARTICULO).Text)))
                    Set dcfields(dcf_PARTIDA).RowSource = rs
                    Debug.Print "exec ProduccionParte_TX_PartidasDisponiblesPorOrdenProcesoParaCombo " & dcfields(dcf_OP).BoundText & "," & dcfields(dcf_PROCESO).BoundText & "," & dcfields(dcf_ARTICULO).BoundText
            
                    Do While Not rs.EOF

                        If InStr(rs.Fields("Titulo"), oL.SubItems(5)) Then
                            dcfields(dcf_PARTIDA).Text = rs.Fields("Titulo")
                    
                            '////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////
                            'copio el codigo de dcfields_click
                            '////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////
                    
                            origen.Registro!IdStock = BuscaIdStock(dcfields(dcf_ARTICULO).Text, dcfields(dcf_UBICACION).Text, left$(dcfields(dcf_PARTIDA).Text, InStr(1, dcfields(dcf_PARTIDA), "Stock:") - 2))
                    
                            Dim rs2 As ADOR.Recordset
                            Set rs2 = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionParte", "_ArticulosPorOrdenPorProcesoParaComboSinFiltrarStock", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText))
                    
                            Debug.Print "exec ProduccionParte_TX_ArticulosPorOrdenPorProcesoParaComboSinFiltrarStock " & dcfields(dcf_OP).BoundText & "," & dcfields(dcf_PROCESO).BoundText
                            Debug.Print "select * from stock where idstock=" & origen.Registro!IdStock
        
                            rs2.Find "IdArticulo=" & BuscaIdArticulo(dcfields(dcf_ARTICULO).Text)
        
                            If rs2.EOF Then Exit Do
                    
                            origen.Registro!Cantidad = Val(txtPeso)
        
                            Dim X As ComPronto.proceso
                            Set X = AplicacionProd.Procesos.Item(dcfields(dcf_PROCESO).BoundText)
        
                            txtStockActual.Text = mId$(dcfields(dcf_PARTIDA), InStr(1, dcfields(dcf_PARTIDA), "Stock:") + 6)
        
                            If Val(txtStockActual) <= 0 Then
                                txtPeso.Enabled = False
                                lblMensaje = "No hay stock disponible de la partida seleccionada"
                            Else
                                txtPeso.Enabled = True

                                If lblMensaje = "No hay stock disponible de la partida seleccionada" Then lblMensaje = ""
                            End If
                    
                            'dcfields(13) = iisNull(rs2!Color, "") 'color
                            SinLimite = IsNull(rs2!Tolerancia)

                            txtTolerancia = iisNull(rs2!Tolerancia * rs2!TotalEsperado / 100, "0")
                            txtToleranciaCopia = rs2!Tolerancia
                    
                            Dim A
                            A = iisNull(rs2!TotalEsperado, 0) - iisNull(rs2!avanzado, 0)
                            txtPendiente = IIf(A < 0, 0, A)
                    
                            'txtMaximoEsperado = Val(txtTolerancia) / 100 * iisNull(rs2!TotalEsperado, 0) + Val(txtPendiente)
                            txtMaximoEsperado = Val(txtTolerancia) + Val(txtPendiente)
                    
                            If Val(txtPendiente) = 0 Then
                                txtPeso.Enabled = False
                                lblMensaje = "Se alcanzó la cantidad requerida por el proceso"
                            Else
                                txtPeso.Enabled = True

                                If lblMensaje = "Se alcanzó la cantidad requerida por el proceso" Then lblMensaje = ""
                            End If

                            Dim rsunidad As ADOR.Recordset
                            Set art = Aplicacion.Articulos.Item(dcfields(dcf_ARTICULO).BoundText)
                            Set rsunidad = Aplicacion.Unidades.Item(TraerIdUnidadDelIdStockElegido(origen.Registro!IdStock)).Registro
                            origen.Registro!IdUnidad = TraerIdUnidadDelIdStockElegido(origen.Registro!IdStock)
                            lblUnid = iisNull(rsunidad!Abreviatura, rsunidad!descripcion)
                            
                            'origen.Registro!IdColor=
                            'origen.Registro!IdDetalleProduccionOrden=
                            
                            Set art = Nothing
                            Set rsunidad = Nothing
                            '////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////

                            Exit Do
                        End If

                        rs.MoveNext
                    Loop
            
                    'buscar en el combo de partida la correspondiente
                    'dcfields(dcf_PARTIDA).Text =  'part
                End If
            
                Unload of2
                Set of2 = Nothing
            End If

    End Select

    Exit Sub

Mal:

    Select Case Err.Number

        Case -2147217900
            Dim mvarResp
            mvarResp = MsgBox("No puede borrar este registro porque se esta" & vbCrLf & "utilizando en otros archivos. Desea ver detalles?", vbYesNo + vbCritical)

            If mvarResp = vbYes Then
                MsgBox "Detalle del error : " & vbCrLf & Err.Number & " -> " & Err.Description
            End If

        Case Else
            MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    End Select

End Sub

Public Sub CerrarParteYProceso(Optional validar As Boolean = True)

    If validar Then
        If Not IsValid Then Exit Sub
    
        'PASO 1 : Está listo este articulo asociado a este proceso?
        
        If SSTab1.TabEnabled(1) And Not EnTolerancia Then 'está habilitada la ficha de consumo y el pesaje está en rango
            
            Exit Sub
            'Dim mvarResp
            'mvarResp = MsgBox("El pesaje no está dentro de lo tolerable. Forzar cierre de proceso?", vbYesNo + vbCritical)
    
            'If mvarResp = vbNo Then
            '    Exit Sub
            'End If
        End If
        
        If (Not SSTab1.TabEnabled(1) Or dcfields(dcf_ARTICULO).Text = "") And IsNull(origen.Registro.Fields("IdUsuarioCerro").Value) Then
            'no es de consumo y el parte no se cerró explicitamente
            Exit Sub
        End If
    End If
    
    '////////////////////////
    '////////////////////////
    'Cierro el parte
    '////////////////////////
    '////////////////////////
    'CerrarParte

    With origen
        .Registro.Fields("IdUsuarioCerro").Value = dcfields(2).BoundText  ' "SI"
        '.Registro.Fields("IdUsuarioAnulo").Value = mIdAutorizaAnulacion
        '.Registro.Fields("FechaAnulacion").Value = Now
        '.Registro.Fields("MotivoAnulacion").Value = mMotivoAnulacion
        GuardarParteDesdeGUI origen

        '.Guardar
    End With
    
    '////////////////////////
    '////////////////////////
    'Cierro el articulo/proceso
    '////////////////////////
    '////////////////////////
    
    Dim oOF As ComPronto.ProduccionOrden
    Set oOF = AplicacionProd.ProduccionOrdenes.Item(origen.Registro.Fields("IdProduccionOrden").Value)

    With oOF.Registro
        '!Codigo = "02OAS"
        '!idArticuloAsociado=
        '!Cantidad = 520
        '!IdUnidad = K_UN1
        '!Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
    End With

    Dim rs As ADOR.Recordset
    
    '//////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////
    'cierro el articulo (si el parte informó  consumo)
    '//////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////
    Dim bFlagInsumoCerrado As Boolean
    bFlagInsumoCerrado = False

    If SSTab1.TabEnabled(1) Then
    
        Set rs = oOF.DetProduccionOrdenes.TraerTodos
        
        Do While Not rs.EOF
                         
            Dim oOFarticulo As ComPronto.DetProduccionOrden
            Set oOFarticulo = oOF.DetProduccionOrdenes.Item(rs!IdDetalleProduccionOrden)
    
            With oOFarticulo.Registro
    
                If !IdArticulo = origen.Registro.Fields("IdArticulo").Value And !IdColor = ProduccionModulo.BuscaIdColor(lblColorConsumido) Then
                    
                    !IdProduccionParteQueCerroEsteInsumo = origen.Registro.Fields("IdProduccionParte").Value
                    oOFarticulo.Modificado = True
                    bFlagInsumoCerrado = True
                    Exit Do
                End If
    
            End With
            
            rs.MoveNext
        Loop

    End If
    
    '//////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////
    'si los demas articulos estan tambien cerrado, pregunto si cierra el proceso
    '//////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////
    
    If EstanListosLosDemasArticulosAsociadosAesteProceso(oOF, origen.Registro.Fields("IdProduccionProceso").Value) And validar Then
        Dim mvarResp
        
        mvarResp = MsgBox("Cerrar el proceso de " & NombreProceso(origen.Registro.Fields("IdProduccionProceso").Value) & "?", vbYesNo + vbQuestion)
        
        If mvarResp = vbYes Then
    
            'Consulta 8087
            'If PedirPermisosDeSupervisor(mNivelAcceso) Then
            'If PedirPermisosDeSupervisorCapen(mNivelAcceso) Then
            If True Then
                CierroElProceso oOF, origen.Registro.Fields("IdProduccionProceso").Value, origen.Registro.Fields("IdProduccionParte").Value
            Else

                If bFlagInsumoCerrado Then oOFarticulo.Registro!IdProduccionParteQueCerroEsteInsumo = Null   'si no cierro el proceso, no debo cerrar el insumo
            End If

        Else

            If bFlagInsumoCerrado Then oOFarticulo.Registro!IdProduccionParteQueCerroEsteInsumo = Null  'si no cierro el proceso, no debo cerrar el insumo
            '        oOFarticulo.Modificado = True
        End If
        
    End If
    
    '//////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////
    
    Select Case oOF.Guardar

        Case ComPronto.MisEstados.Correcto

        Case ComPronto.MisEstados.ModificadoPorOtro
            Me.MousePointer = vbDefault
            MsgBox "El Regsitro ha sido modificado"

        Case ComPronto.MisEstados.NoExiste
            Me.MousePointer = vbDefault
            MsgBox "El registro ha sido eliminado"

        Case ComPronto.MisEstados.ErrorDeDatos
            Me.MousePointer = vbDefault
            MsgBox "Error de ingreso de datos"
    End Select
    
    
    
If False Then
    'acá Hector quizas prefiera que se etiquete siempre
    '-pero pinta que se pasa por acá siempre...
    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9626
    
    'si cerré el proceso y hice un consumo del que sobró material, lo debo etiqutar
    If origen.Registro!IdUsuarioCerro > 0 And _
        Val(txtPeso) < Val(txtStockActual) And SSTab1.TabEnabled(1) _
        And IsNumeric(dcfields(dcf_ARTICULO).BoundText) And _
        IsNumeric(dcfields(dcf_UBICACION).BoundText) And validar Then
        
        If ReetiquetarElSobranteCreandoUnaNuevaPartida(dcfields(dcf_ARTICULO).BoundText, ProduccionModulo.BuscaIdColor(lblColorConsumido), origen.Registro!IdUnidad, dcfields(dcf_UBICACION).BoundText, Val(txtStockActual) - Val(txtPeso), TraerValorParametro2("IdObraDefault"), 99999, dcfields(dcf_PARTIDA).Text) Then
            PonerEnCeroElStockOriginalSobrante dcfields(dcf_ARTICULO).BoundText, dcfields(dcf_PARTIDA).Text, ProduccionModulo.BuscaIdColor(lblColorConsumido), Val(txtStockActual) - Val(txtPeso), origen.Registro!IdUnidad, dcfields(dcf_UBICACION).BoundText, Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", origen.Registro!IdStock).Fields("IdObra"), origen.Registro!IdStock, origen '  TraerValorParametro2("IdObraDefault")

        End If
    End If
    End If
    
End Sub

Sub LlamarEtiquetadoDeMaterialCreado()

     
    'tambien  etiqueto los subproductos y los terminados, es decir, todo material creado por el parte
    '-pero al etiquetar No Se va a crear una salida automaticamente?
    
    Dim op As ComPronto.ProduccionOrden
    Set op = AplicacionProd.ProduccionOrdenes.Item(dcfields(dcf_OP).BoundText)
    Dim idUbicacion, IdUnidad As Long
    idUbicacion = BuscaIdProceso(dcfields(dcf_PROCESO).Text)
    'IdUnidad = dcfields(dcf_).BoundText
    
    If Val(txtCantidadProducida) > 0 Then
        EtiquetarMaterialCreado op.Registro!idArticuloGenerado, op.Registro!IdColor, _
                        op.Registro!IdUnidad, idUbicacion, _
                        Val(txtCantidadProducida), TraerValorParametro2("IdObraDefault"), _
                        99999, op.Registro!NumeroOrdenProduccion
    End If
    
    If Val(txtCantidadDeshecho) > 0 Then
        Dim IdColorConsumido As Long
        IdColorConsumido = ProduccionModulo.BuscaIdColor(lblColorConsumido)
        If IdColorConsumido = -1 Then
            'quizas es un proceso donde no se consume, y no tenes el color
            '-pero en ese caso, deberìa dejar producir un deshecho?
            IdColorConsumido = op.Registro!IdColor
        End If
        
        EtiquetarMaterialCreado dcfields(dcf_ARTICULODESHECHO).BoundText, IdColorConsumido, origen.Registro!IdUnidad, dcfields(dcf_UBICACION).BoundText, Val(txtStockActual) - Val(txtPeso), TraerValorParametro2("IdObraDefault"), 99999, op.Registro!NumeroOrdenProduccion
    End If
End Sub


Public Sub CerrarParte()
    Dim mvarSale As Integer
    Dim mIdAutorizo As Long

    Dim mBorra As Integer
        
    '     'solo se puede anular el PP si la OP no está anulada -Pero la OP no anula el PP?
    '
    '     mBorra = MsgBox("Esta seguro de anular los datos definitivamente ?", vbYesNo, "Eliminar")
    '     If mBorra = vbNo Then
    '        Exit Sub
    '     End If
    
    'mvarSale = MsgBox("Esta seguro de anular la OP ?", vbYesNo, "Anulacion")
    'If mvarSale = vbNo Then
    '   Exit Sub
    'End If
    
    '    Dim oF As Form
    '    Set oF = New frmAutorizacion
    '    With oF
    '         .Empleado = 0
    '         .Administradores = True
    '         '.SuperAdministrador = True
    '         '.IdFormulario = 70
    '        .IdFormulario = 0 'EnumFormularios.Remitos '.OrdenesCompra
    '
    '       .Show vbModal, Me
    '    End With
    '    If Not oF.Ok Then
    '       MsgBox "No puede cerrar el Parte!", vbExclamation
    '       'Unload oF
    '       Set oF = Nothing
    '       Exit Sub
    '    End If
    '    mIdAutorizo = oF.IdAutorizo
    '    Unload oF
    '    Set oF = Nothing
  
    With origen
        .Registro.Fields("IdUsuarioCerro").Value = glbIdUsuario ' mIdAutorizo ' "SI"
       
        If IsNull(TurnoFinal) Then TurnoFinal = Now
       
        '.Registro.Fields("IdUsuarioAnulo").Value = mIdAutorizaAnulacion
        '.Registro.Fields("FechaAnulacion").Value = Now
        '.Registro.Fields("MotivoAnulacion").Value = mMotivoAnulacion
        If Not IsValid Then Exit Sub

        GuardarParteDesdeGUI (origen)

        '.Guardar
    End With
         
    'est = baja
    Aplicacion.Tarea "Log_InsertarRegistro", Array("ANUL", mvarId, 0, Now, 0, "Tabla : PartesProduccion", GetCompName(), glbNombreUsuario)
        
    ' With actL2
    
    '    .AccionRegistro = baja
    '    .Disparador = mvarId
    ' End With
    
    'Unload Me

End Sub

Private Sub cmdVerOP_Click()
    Dim oF As frmProduccionOrden
    Set oF = New frmProduccionOrden

    With oF
        .NivelAcceso = frmPrincipal.ControlAccesoNivel("OrdendeProduccion")
        .OpcionesAcceso = frmPrincipal.ControlAccesoOpciones("OrdendeProduccion")

        If IsNumeric(dcfields(dcf_OP).BoundText) Then
            .Id = dcfields(dcf_OP).BoundText
                        
            'Muestro la OP del proceso sobre el que se hizo doble click
            .Disparar = ActL
            ReemplazarEtiquetas oF
            Me.MousePointer = vbDefault
            '.Enabled = False
            .Show , frmPrincipal
            .ZOrder

        End If
                   
    End With

End Sub

Private Sub cmdVerStock_Click()
    
    If Not IsNumeric(dcfields(dcf_ARTICULO).BoundText) Then
        MsgBox ("Indique el artículo")
        Exit Sub
    End If
    If Not IsNumeric(dcfields(dcf_UBICACION).BoundText) Then
        MsgBox ("Indique la ubicación")
        Exit Sub
    End If
    
    Dim rs As Recordset
    'Set rs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_CompletoPorArticulo", dcfields(dcf_ARTICULO).BoundText)
    
    
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_StockPorPartidaParaProduccion", Array(dcfields(dcf_ARTICULO).BoundText, dcfields(dcf_UBICACION).BoundText))
    rs.Filter = "Color='" & lblColorConsumido.Caption & "'" '& " OR Color=null"
    
    Dim oL As ListItem
    Dim IdStock As Long
    IdStock = ConsultaSimple(rs, oL)

    If oL Is Nothing Then Exit Sub
     
    origen.Registro!IdStock = oL.SubItems(11)
   
    dcfields(dcf_PARTIDA) = oL.SubItems(5) 'queda enlazado?
    txtStockActual = oL.SubItems(6)
    'dcfields(dcf_ubicacion)=
     
    'If dcfields(dcf_PARTIDA) = "" Then Stop
     
    ValidarPeso
    
    'If dcfields(dcf_PARTIDA) = "" Then Stop
    
    DoEvents
    SSTab1.Tab = 1
    
End Sub

Public Sub dcfields_Change(Index As Integer)
    On Error Resume Next
    Debug.Print "change", Index
       
    If Index = 1 And IsNumeric(dcfields(dcf_PROCESO).BoundText) Then 'proceso
        Dim X As ComPronto.proceso
        Set X = AplicacionProd.Procesos.Item(dcfields(dcf_PROCESO).BoundText)
            
        'Cuando en PROCESOS no está tildado "Incorpora Material", bloquear en PARTES DE PROD. la ficha "Consumo".
            
        If X.Registro!incorpora <> "SI" Then
            SSTab1.TabEnabled(1) = False
            dcfields(0).Enabled = False
            dcfields(dcf_PARTIDA).Enabled = False
            dcfields(dcf_UBICACION).Enabled = False
            dcfields(dcf_ARTICULO).Enabled = False
        Else
            SSTab1.TabEnabled(1) = True
            dcfields(0).Enabled = True
            'dcfields(dcf_PARTIDA).Enabled = True
            dcfields(dcf_UBICACION).Enabled = True
            dcfields(dcf_ARTICULO).Enabled = True
        End If
            
        'EstaHabilitadoEsteProceso

    End If
       
       
       
       
    If Index = 5 And IsNumeric(dcfields(dcf_ARTICULO).BoundText) Then 'articulo
        'Parte de Producción/Pesaje: Cuando en el Parte un ítem/artículo ya está totalmente ingresado, debe desaparecer de lo pendiente. Hoy aparece cero o negativo –si ingresé demás-
        'Dim restan As Double
        'restan = Val(mId$(dcfields(0).Text, InStr(1, dcfields(0), "Restan:") + 7, 15))
            
        'If Val(txtPendiente) = 0 Then
        '    txtPeso.Enabled = False
        '    lblMensaje = "Se alcanzó la cantidad requerida por el proceso"
        'Else
        '    txtPeso.Enabled = True
        '    If lblMensaje = "Se alcanzó la cantidad requerida por el proceso" Then lblMensaje = ""
        'End If
    End If
        
    VerificaParte
End Sub

Sub rebindProceso()
    dcfields(dcf_PROCESO).Text = ""
    Set dcfields(dcf_PROCESO).RowSource = Nothing
    Dim rs As ADOR.Recordset
    Set rs = Aplicacion.TablasGenerales.TraerFiltrado("DetProduccionOrdenProcesos", "_PorIdOrdenParaCombo", dcfields(dcf_OP).BoundText)
    Set dcfields(dcf_PROCESO).RowSource = rs
    dcfields(dcf_PROCESO).BoundColumn = "IdProduccionProceso"
    dcfields(dcf_PROCESO).Text = dcfields(dcf_PROCESO).Text
End Sub

Sub rebindArticulos()

    dcfields(dcf_ARTICULO).Text = ""
    Set dcfields(dcf_ARTICULO).RowSource = Nothing
        
    Dim rs As ADOR.Recordset
    Set rs = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionParte", "_ArticulosPorOrdenPorProcesoParaComboSinFiltrarStock", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText, mvarId))
    Set dcfields(dcf_ARTICULO).RowSource = rs
    dcfields(dcf_ARTICULO).BoundColumn = "IdArticulo"
    dcfields(dcf_ARTICULO).Text = dcfields(dcf_ARTICULO).Text
End Sub

Public Sub dcfields_Click(Index As Integer, _
                          Area As Integer)
    On Error Resume Next
    Debug.Print "click", Index
    
    Dim rs As ADOR.Recordset
    
    'numero de op index=11
    
    If dcfields(Index).Tag = "ProduccionOrdenes" Then
        If IsNumeric(dcfields(Index).BoundText) Then
            
            rebindProceso
            
            Dim art As ComPronto.Articulo
            Dim op As ComPronto.ProduccionOrden
            Set op = AplicacionProd.ProduccionOrdenes.Item(dcfields(dcf_OP).BoundText)
            
            Dim s As String
            s = op.GetEstado

            Select Case s

                Case "NUEVA", "CERRADA", "ANULADA"
                    MsgBox "El estado de la OP es " & s & ". No se puede usar en un nuevo parte"
                    dcfields(dcf_OP) = ""
                    Exit Sub

                Case "ABIERTA", "PROGRAMADA", "EN EJECUCION"
                    
                Case Else
                
            End Select
            
            Set art = Aplicacion.Articulos.Item(op.Registro!idArticuloGenerado)
            
            lblArticuloProducido = art.Registro!descripcion & "    Color:" & Aplicacion.Colores.Item(iisNull(op.Registro!IdColor, 0)).Registro!descripcion
            'En la PARTE DE PROD., en la ficha de "Terminado/Subproducto", visualizar el Artículo+Color.
            
            Dim oRsTipo As ADOR.Recordset
            Set oRsTipo = Aplicacion.Tipos.TraerTodos
            oRsTipo.Filter = "Descripcion='Terminado'"
            
            lblInfoProduccion.Visible = False

            If oRsTipo.RecordCount > 0 Then
                If art.Registro!Idtipo = oRsTipo!Idtipo Then
                    txtCantidadProducida.Enabled = False
                    
                    'sfsdfEstado.Panels(1).Text = "La OP produce un terminado. Solo se modifica su avance a traves del etiquetado"
                    lblInfoProduccion.Visible = True
                
                Else
                    txtCantidadProducida.Enabled = True
                    
                End If

            Else
                txtCantidadProducida.Enabled = True
            End If
            
            Set op = Nothing
            Set art = Nothing
            
            'Set dcfields(0).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("DetProduccionOrdenes", "_PorIdOrdenParaCombo", dcfields(Index).BoundText)
            'dcfields(0).BoundColumn = "IdStock"
            'dcfields(0).Text = dcfields(0).Text 'http://support.microsoft.com/?scid=kb%3Ben-us%3B238406&x=1&y=8
        
            'AutoTurno
        End If
    End If
    
    'proceso
    If Index = 1 And IsNumeric(dcfields(dcf_PROCESO).BoundText) Then
        'cambiar articulo
        
        'Cuando se ha consumido todo lo permitido en una OP, el artículo
        ' debe desaparecer del combo de lo pendiente de consumir (si el Parte es nuevo,
        ' porque si es una edicion sí deben aparecer TODOS los articulos)
        
        rebindArticulos
        
        'Set rs = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionParte", "_ArticulosPorOrdenPorProcesoParaCombo", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText, iisEmpty(dcfields(dcf_ARTICULO).BoundText)))
        'If rs.RecordCount > 0 Then
        '    dcfields(0).Enabled = True
        '    Set dcfields(0).RowSource = rs
        '    dcfields(0).BoundColumn = "IdStock"
        '    dcfields(0).Text = dcfields(0).Text 'http://support.microsoft.com/?scid=kb%3Ben-us%3B238406&x=1&y=8
        '    If lblMensaje = "No hay stock disponible del material o partida especificados" Then lblMensaje = ""
        'Else
        '    dcfields(0).Enabled = False
        '    lblMensaje = "No hay stock disponible del material o partida especificados"
        'End If
        'Set rs = Nothing
                
        'asigno la ubicacion de consumo automatica del proceso, si es que tiene
        If Not IsNull(Aplicacion.Procesos.Item(dcfields(dcf_PROCESO).BoundText).Registro!idUbicacion) Then
            dcfields(dcf_UBICACION).BoundText = Aplicacion.Procesos.Item(dcfields(dcf_PROCESO).BoundText).Registro!idUbicacion
            dcfields(dcf_UBICACION).Enabled = False
        Else
            dcfields(dcf_UBICACION).Enabled = True
        End If
                
        'cambiar la maquina, trayendo la op que figura en dcfields(dcf_OP)
        ' -Pero con cual me quedo, con la asociada al proceso o al articulo???
        If IsNumeric(dcfields(dcf_OP).BoundText) Then
            'Dim op As ProduccionOrden
            Dim detordenproc As DetProdOrdenProceso
            Dim xrs As ADOR.Recordset
            Set op = AplicacionProd.ProduccionOrdenes.Item(dcfields(dcf_OP).BoundText)
            'Set detordenproc = op.DetProduccionOrdenesProcesos.Item(dcfields(dcf_PROCESO).BoundText)
            'dcfields(8).BoundText = iisNull(detordenproc.Registro!IdMaquina, "")
            
            'Set xrs = op.DetProduccionOrdenes.TraerTodos
            'xrs.Filter = "idArticulo=" & dcfields(dcf_ARTICULO).BoundText

            'como no sé todavía si el indice es el ID del renglon o del proceso,
            ' lo filtro con ADO
            Set xrs = op.DetProduccionOrdenesProcesos.TraerTodos
            xrs.Filter = "idProduccionProceso=" & dcfields(dcf_PROCESO).BoundText
            
            dcfields(8).BoundText = iisNull(xrs!IdMaquina, "")
            
            If dcfields(8) = "" Then
                'si no hay maquina asociada, tomo por default la primera que encuentro
                'Set xrs = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorDescripcionTipoParaCombo", Array(0, "Equipo"))
                'dcfields(8).BoundText = iisNull(xrs!IdArticulo, "")
                
                dcfields(8).Enabled = True
            End If
            
            Set op = Nothing
            Set detordenproc = Nothing
        End If
        
    End If
    
    If Index = 3 Then  'control calidad
        If IsNumeric(dcfields(Index).BoundText) Then
            Dim TipoCC As ControlCalidadTipo
            Set TipoCC = AplicacionProd.ControlCalidadTipos.Item(dcfields(Index).BoundText)

            With TipoCC
                With .Registro
                    lblTipoDe(0) = !P1Descripcion
                    lblTipoDe(1) = !P2Descripcion
                    lblTipoDe(2) = !P3Descripcion
                    lblTipoDe(3) = !P4Descripcion
                    lblTipoDe(4) = !P5Descripcion
                End With

                Dim n

                For n = 0 To 4

                    If lblTipoDe(n) = "" Then
                        lblTipoDe(n).Visible = False
                        txtMaximo(n).Visible = False
                    Else
                        lblTipoDe(n).Visible = True
                        txtMaximo(n).Visible = True
                    End If

                Next

            End With

            Set TipoCC = Nothing
        End If
    End If
    
    'articulo y partida
    ' en las SM de Pronto, para las partidas se usa tambien un combo!!!!! así que mi interfaz
    ' termina siendo la misma que la original del Pronto
    If (Index = 5 Or Index = 20) And IsNumeric(dcfields(dcf_ARTICULO).BoundText) And IsNumeric(dcfields(dcf_OP).BoundText) Then
        
        Dim rsStock As ADOR.Recordset
        Set rsStock = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionParte", "_ArticulosPorOrdenPorProcesoParaComboSinFiltrarStock", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText))
        '("ProduccionParte", "_ArticulosPorOrdenPorProcesoParaComboSinFiltrar", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText, iisEmpty(dcfields(dcf_ARTICULO).BoundText)))
        rsStock.Find "IdArticulo=" & dcfields(dcf_ARTICULO).BoundText
        
        origen.Registro!Cantidad = txtPeso
        'If IsNumeric(rsStock!Partida) Then origen.Registro!Partida = rsStock!Partida
        'If IsNumeric(rsStock!IdUbicacion) Then origen.Registro!IdUbicacion = rsStock!IdUbicacion
        
        Dim X As ComPronto.proceso
        Set X = AplicacionProd.Procesos.Item(dcfields(dcf_PROCESO).BoundText)
        'origen.Registro!IdUbicacion = X.Registro!IdUbicacion

        '        Set op = AplicacionProd.ProduccionOrdenes.Item(dcfields(dcf_OP).BoundText)
        '
        '        Dim rsficha As ADOR.Recordset
        '        Set rsficha = AplicacionProd.ProduccionFichas.TraerTodos
        '        rsficha.Filter = "IdArticuloAsociado='" & Left$(dcfields(0).Text, InStr(1, dcfields(0), "Restan:") - 2) & "'"
        '        Dim ficha As compronto.ProduccionFicha
        '        Set ficha = AplicacionProddetProduccionOrdenes.Item(rsficha!idProduccionFicha)
        '        Dim detficha As compronto.DetProduccionFicha
        '        Set detficha = ficha.DetProduccionFichas.Item()
        '
        '        Dim detorden As DetProduccionOrden
        '        Set detorden = op.detProduccionOrdenes.Item(dcfields(dcf_OP).BoundText)
        '
        '        Set xrs = op.detProduccionOrdenes.TraerTodos()  'como no sé todavía si el indice es el ID del renglon o del proceso, lo filtro con ADO
        '        xrs.Filter = "Articulo='" & Left$(dcfields(0).Text, InStr(1, dcfields(0), "Restan:") - 2) & "'"
        '
        '        'Val(left$(dcfields(0).Text, InStr(1, dcfields(0), "Restan:"),)
        
        txtStockActual.Text = mId$(dcfields(dcf_PARTIDA), InStr(1, dcfields(dcf_PARTIDA), "Stock:") + 6)
        
        '        If IsNumeric(X.Registro!IdUbicacion) Then
        '            'si hay ubicacion la traigo de ahí
        '            Dim oRs As ADOR.Recordset
        '            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorIdArticuloUbicacion", Array(rsStock!IdArticulo, X.Registro!IdUbicacion, dcfields(dcf_PARTIDA)))
        '            txtStockActual.Text = iisNull(oRs.Fields("Stock actual"), 0)
        '            Set oRs = Nothing
        '
        '        Else
        '
        '            txtStockActual.Text = Aplicacion.StockPorIdArticulo(rsStock!IdArticulo)
        '        End If
        
        '·         Cuando se muestra la Partida en combo, junto al número de partida exhibir la cantidad en stock para el depósito definido
        Set dcfields(dcf_PARTIDA).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionParte", "_PartidasDisponiblesPorOrdenProcesoParaCombo", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText, dcfields(dcf_ARTICULO).BoundText))
        Debug.Print "exec ProduccionParte_TX_PartidasDisponiblesPorOrdenProcesoParaCombo " & dcfields(dcf_OP).BoundText & "," & dcfields(dcf_PROCESO).BoundText & "," & dcfields(dcf_ARTICULO).BoundText

        'If Index = 5 Then
        '    dcfields(dcf_PARTIDA) = ""
        '    dcfields(dcf_PARTIDA).SelectedItem = 1 'fuerzo eleccion de alguna partida
        'End If

        'dcfields(dcf_PARTIDA).BoundColumn = "IdProduccionProceso"
        'dcfields(dcf_PARTIDA).Text = dcfields(dcf_PARTIDA).Text
        
        origen.Registro!IdStock = rsStock!IdStock
        
        If Val(txtStockActual) <= 0 Then
            txtPeso.Enabled = False
            lblMensaje = "No hay stock disponible de la partida seleccionada"
        Else
            txtPeso.Enabled = True

            If lblMensaje = "No hay stock disponible de la partida seleccionada" Then lblMensaje = ""
        End If
        
        dcfields(13) = iisNull(rsStock!Color, "") 'color
        SinLimite = IsNull(rsStock!Tolerancia)

        txtTolerancia = iisNull(rsStock!Tolerancia * rsStock!TotalEsperado / 100, "0")
        txtToleranciaCopia = rsStock!Tolerancia
        
        Dim A
        A = iisNull(rsStock!TotalEsperado, 0) - iisNull(rsStock!avanzado, 0)
        txtPendiente = IIf(A < 0, 0, A)
        
        'txtMaximoEsperado = Val(txtTolerancia) / 100 * iisNull(rsStock!TotalEsperado, 0) + Val(txtPendiente)
        txtMaximoEsperado = Val(txtTolerancia) + Val(txtPendiente)
        
        If Val(txtPendiente) = 0 And Not IsNull(rsStock!Tolerancia) Then
            txtPeso.Enabled = False
            lblMensaje = "Se alcanzó la cantidad requerida por el proceso"
        Else
            txtPeso.Enabled = True

            If lblMensaje = "Se alcanzó la cantidad requerida por el proceso" Then lblMensaje = ""
        End If
        
        Dim rsunidad As ADOR.Recordset
        Set art = Aplicacion.Articulos.Item(dcfields(dcf_ARTICULO).BoundText)
        Set rsunidad = Aplicacion.Unidades.Item(TraerIdUnidadDelIdStockElegido(origen.Registro!IdStock)).Registro
        origen.Registro!IdUnidad = TraerIdUnidadDelIdStockElegido(origen.Registro!IdStock)
        lblUnid = iisNull(rsunidad!Abreviatura, rsunidad!descripcion)
        Set art = Nothing
        Set rsunidad = Nothing
        
        'no trae el color/tolerancia en la pestaña consumo
        'Stop
        
        'cambiar la maquina, trayendo la op que figura en dcfields(dcf_OP)
        ' -Pero con cual me quedo, con la asociada al proceso o al articulo???
        If IsNumeric(dcfields(dcf_ARTICULO).BoundText) Then
            '            Dim detordenproc As DetProdOrdenProceso
            '            Dim xrs As ADOR.Recordset
            '            Set op = AplicacionProd.ProduccionOrdenes.Item(dcfields(dcf_OP).BoundText)
            '
            '            Set xrs = op.DetProduccionOrdenes.TraerTodos
            '            xrs.Filter = "idArticulo=" & dcfields(dcf_ARTICULO).BoundText
            '
            '
            '            dcfields(8).BoundText = iisNull(xrs!IdMaquina, "")
            '
            '            If dcfields(8) = "" Then dcfields(8).SelectedItem = 1 'estoy forzando una maquina
            '
            '
            '            Set op = Nothing
            '            Set detordenproc = Nothing
        End If
        
        'traer las ubicaciones correspondientes a la partida
        If dcfields(dcf_PARTIDA).Text <> "" Then
            Dim oRs As ADODB.Recordset
            
            'Set oRs = Aplicacion.Ubicaciones.TraerFiltrado("_PorObra", Array(-1, Me.IdDepositoOrigen))
            'If oRs.RecordCount = 1 Then .Fields("IdUbicacion").Value = oRsAux.Fields(0).Value
            'oRsAux.Close
            'Set dcfields(dcf_UBICACION).RowSource = oRs
        End If
        
        Set op = Nothing
        Set detordenproc = Nothing
    End If

    'empleado
    If Index = 2 And dcfields(2) <> glbNombreUsuario And Me.Visible Then   'empleado/usuario
        'If dcfields(2).BoundText <> mIdAprobo Then
        PideAutorizacionEmitio
        'End If
    End If

    'maquina
    If Index = dcf_MAQUINA Then
        Dim IdParteActivo As Long
        IdParteActivo = TraerParteActivoQueEstaUsandoEstaMaquina(dcfields(dcf_MAQUINA).BoundText)
         
        If IdParteActivo > 0 Then
            Dim oParte As ProduccionParte
            Set oParte = Aplicacion.ProduccionPartes.Item(IdParteActivo)
                       
            If oParte.Registro!IdEmpleado = glbIdUsuario Then
                'el empleado que tiene ocupada la maquina es el mismo que esta dando de alta
                'otro parte. dejarlo, y cerrar el parte
                CerrarPartePorId (IdParteActivo)
            Else
                'el empleado que la tiene ocupada es otro
                
                If MsgBox("La máquina " & dcfields(dcf_MAQUINA).Text & " está ocupada por " & NombreEmpleado(oParte.Registro!IdEmpleado) & " en el parte " & IdParteActivo & ". Desea ver el Parte?", vbYesNo) = vbYes Then
                    EditarParte IdParteActivo, Me.left + 500, Me.top + 500
                End If

                dcfields(dcf_MAQUINA).BoundText = ""
                dcfields(dcf_MAQUINA).Text = ""
            End If
        End If
    End If

    If IsNull(TraerValorParametro2("IdObraDefault")) Then 'si la obra no controla stock, no se pueden hacer consumos ni ingresos
        dcfields(dcf_ARTICULO).Enabled = False
        dcfields(dcf_PARTIDA).Enabled = False
        dcfields(dcf_UBICACION).Enabled = False
    
        txtPeso.Enabled = False
        
        SSTab1.TabEnabled(1) = False
        SSTab1.TabEnabled(4) = False
    
        'Estado.Panels(1).Text = "La obra no controla stock. No se permiten ingresos ni egresos."
        'Estado.Panels(1).AutoSize = sbrContents
    End If

End Sub
    
Sub VerificarAgenda()

    Dim oOF As ComPronto.ProduccionOrden
    Set oOF = AplicacionProd.ProduccionOrdenes.Item(origen.Registro.Fields("IdProduccionOrden").Value)
       
    'If TurnoInicio > opproceso!FechaInicio Then Exit Sub
   
    ReasignoFechasDelProceso oOF, origen.Registro.Fields("IdProduccionProceso").Value, TurnoInicio
    
    'GuardarOrdenDesdeGUI oOF
    Select Case oOF.Guardar

        Case ComPronto.MisEstados.Correcto

        Case ComPronto.MisEstados.ModificadoPorOtro
            Me.MousePointer = vbDefault
            MsgBox "El Regsitro ha sido modificado"

        Case ComPronto.MisEstados.NoExiste
            Me.MousePointer = vbDefault
            MsgBox "El registro ha sido eliminado"

        Case ComPronto.MisEstados.ErrorDeDatos
            Me.MousePointer = vbDefault
            MsgBox "Error de ingreso de datos"
    End Select

End Sub

Private Sub PideAutorizacionEmitio()

    Dim oF As frmAutorizacion1
    Set oF = New frmAutorizacion1

    With oF
        .IdUsuario = dcfields(2).BoundText
        .Show vbModal, Me
    End With
   
    If Not oF.Ok Then

        With origen.Registro
            .Fields(dcfields(2).DataField).Value = Null
        End With

    Else
        'With origen.Registro
        '   mIdAprobo = IIf(IsNull(.Fields("Emitio").Value), 0, .Fields("Emitio").Value)
        'End With
    End If

    Unload oF
    Set oF = Nothing

End Sub

Public Sub dcfields_Validate(Index As Integer, _
                             Cancel As Boolean)
    Debug.Print "validate", Index

    Dim oRsObra As ADOR.Recordset
    Dim oRsCliente As ADOR.Recordset
    Dim oRsProv As ADOR.Recordset
   
    If Index = 20 Then Exit Sub
   
   Dim temp
   temp = dcfields(Index).BoundText
   
    If IsNumeric(dcfields(Index).BoundText) Then
        origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText

        Select Case Index

            Case 0
  
            Case 5

            Case 6

                'txtCliente.Text = ""
            Case 14
            
            Case dcf_MAQUINA
            
                
                If dcfields(dcf_MAQUINA).BoundText <> IdMaquinaOriginal Then
                    
                    
                    'Cancel = Not PedirPermisosDeSupervisor(9)
                    Cancel = Not PedirPermisosDeSupervisorCapen(9) '(mNivelAcceso) 'pedirla de todos modos
                    If Cancel Then dcfields(dcf_MAQUINA).BoundText = IdMaquinaOriginal
                End If
                
            End Select

    Else
        dcfields(Index).Text = ""
    End If

End Sub

Private Sub Form_GotFocus()
    Me.WindowState = vbNormal
    Me.ZOrder 0
End Sub

Private Sub Form_Paint()

    ''Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

    Set actL2 = Nothing
    Set origen = Nothing
    Set oBind = Nothing

End Sub

Private Sub ActL_ActLista(ByVal IdRegistro As Long, _
                          ByVal TipoAccion As EnumAcciones, _
                          ByVal NombreListaEditada As String, _
                          ByVal IdRegistroOriginal As Long)

    '   ActualizarLista IdRegistro, TipoAccion, NombreListaEditada, IdRegistroOriginal

End Sub

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
    Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
    Set actL2 = actl1
   
End Property

Public Property Let Id(ByVal vNewValue As Long)

    Dim oAp As ComPronto.Aplicacion
    Dim oApProd As ComPronto.Aplicacion
    Dim oControl As Control
   
    mvarId = vNewValue
   
    Set oAp = Aplicacion
    Set oApProd = AplicacionProd
    Set origen = oApProd.ProduccionPartes.Item(vNewValue)
    Set oBind = New BindingCollection
   
    origen.IdMonedaDolar = glbIdMonedaDolar
    'origen.IdMoneda = glbIdMoneda
    
    SinLimite = False
    
    With oBind
      
        Set .DataSource = origen
      
        For Each oControl In Me.Controls

            If TypeOf oControl Is CommandButton Then
   
            ElseIf TypeOf oControl Is DbListView Then
            ElseIf TypeOf oControl Is Label Then

                If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
            ElseIf TypeOf oControl Is RichTextBox Then

                If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
            ElseIf TypeOf oControl Is DataCombo Then

                If Len(oControl.DataField) Then Set oControl.DataSource = origen
                If oControl.Tag = "Maquinas" Then
                    Set oControl.RowSource = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorDescripcionTipoParaCombo", Array(0, "Equipo"))
                ElseIf oControl.Tag = "Procesos" Then

                    If mvarId = -1 Then
                        If origen.Registro!IdProduccionOrden Is Null Then
                        'todavia no eligió la orden. -esto pasa cuando tiene que aparecer el formulario con los partes pendientes
                        'pero todavía no se mostró. -y por qué se pasa por esta inicializacion si antes tiene que mostrar ese formulario
                        'modal? -Es suficiente con que solo depures los errores no controlados....
                        Set oControl.RowSource = Aplicacion.TablasGenerales.TraerLista("ProduccionProcesos")
                        Else
                        
                        Set oControl.RowSource = Aplicacion.TablasGenerales.TraerFiltrado("DetProduccionOrdenProcesos", "_PorIdOrdenParaCombo", origen.Registro!IdProduccionOrden)
                        End If
                    Else
                        Set oControl.RowSource = Aplicacion.TablasGenerales.TraerLista("ProduccionProcesos")
                        'Set oControl.RowSource = TraerDirecto("ProduccionProcesos_TL")
                    End If
                
                ElseIf oControl.Tag = "ProduccionOrdenes" Then

                    If mvarId = -1 Then
                        'si es un alta, filtro
                        Dim rs As ADOR.Recordset
                        Set rs = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionOrdenes", "_AbiertasParaCombo")
                        'rs.Filter = "[Aprobo]<>null AND [Cerro]=null AND Anulada<>'SI'"
                        Set oControl.RowSource = rs 'no le está pasando los filtros del recordset al rowsource!!!
                        'dcfields(dcf_OP).da
                        Set rs = Nothing
                    Else
                        'si es edicio, no filtro
                        Set oControl.RowSource = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionOrdenes", "_SinCerrarParaCombo")
                    End If

                ElseIf oControl.Tag = "Articulos" Then
                    Set oControl.RowSource = Aplicacion.TablasGenerales.TraerFiltrado("DetProduccionOrdenes", "_PorIdOrdenParaCombo", origen.Registro!IdProduccionOrden)
                    'ElseIf oControl.Tag = "TiposControlCalidad" Then
                    '    Set oControl.RowSource = Aplicacion.TablasGenerales.TraerFiltrado("TiposControlCalidad", "_ParaCombo", origen.Registro!IdProduccionOrden)
                ElseIf Len(oControl.Tag) Then
                    Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
                End If

            Else
                On Error Resume Next
                Set oControl.DataSource = origen
            End If

        Next
   
    End With
   
    'Set DataCombo1.RowSource = Aplicacion.TablasGenerales.TraerLista("ProduccionAreas")
    'Set dcfields(2).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionParte", "_OrdenesPorEmpleado")
    'Set dcfields(dcf_PROCESO).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("DetProduccionOrdenProcesos", "_PorIdOrdenParaCombo", ors!idproduccionorden)
    
    Set dcfields(dcf_CALIDAD).RowSource = Aplicacion.TablasGenerales.TraerLista("PROD_TiposControlCalidad")
   
    '·         están apareciendo todos, incluye los NO ACTIVOS – Ejemplo: Lana mecanica 85/15 21mic 25mm
    '·         Cuando se ha consumido todo lo permitido en una OP, el artículo debe desaparecer del combo de lo pendiente de consumir (si el Parte es nuevo, porque si es una edicion sí deben aparecer TODOS los articulos)
    Set dcfields(dcf_ARTICULO).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionParte", "_ArticulosPorOrdenPorProcesoParaComboSinFiltrarStock", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText, mvarId))
   
    
    'Set dcfields(0).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionParte", "_ArticulosPorOrdenPorProcesoParaCombo", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText, iisEmpty(dcfields(dcf_ARTICULO).BoundText)))
   
    '·         Cuando se muestra la Partida en combo, junto al número de partida exhibir la cantidad en stock para el depósito definido
    Set dcfields(4).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorDescripcionTipoParaCombo", Array(0, "Subproducto"))
   
    Set dcfields(dcf_PARTIDA).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionParte", "_PartidasDisponiblesPorOrdenProcesoParaCombo", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText, dcfields(4).BoundText))
   
    If Not IsNull(origen.Registro!IdStock) Then dcfields(0).BoundText = origen.Registro!IdStock
    
    Dim strArray() As String
    Dim i As Integer
    txtCausaParo.Clear
    strArray = Split(TraerValorParametro2("ListaCausasDeParo"), ";")

    For i = 0 To UBound(strArray)
        txtCausaParo.AddItem (strArray(i))
    Next

    txtCausaParo = origen.Registro!paroObservacion
    
    If mvarId = -1 Then
        Fecha = Now
        dcfields(2).Text = glbNombreUsuario
        TurnoInicio = Now
        
        TurnoFinal = Now 'para que quede apagado el día de hoy?
        TurnoFinal = Null 'para que quede apagado el día de hoy?
        
        Dim oRs As ADOR.Recordset
        Set oRs = AplicacionProd.ProduccionPartes.TraerFiltrado("_UltimoPartePorEmpleado", (dcfields(2).BoundText))
        
        origen.Registro!IdProduccionOrden = oRs!IdProduccionOrden
        Set dcfields(dcf_PROCESO).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("DetProduccionOrdenProcesos", "_PorIdOrdenParaCombo", oRs!IdProduccionOrden)
        dcfields(dcf_PROCESO).BoundColumn = "IdProduccionProceso"
        dcfields(dcf_PROCESO).Text = dcfields(dcf_PROCESO).Text
        '·         Cuando se ha consumido todo lo permitido en una OP, el artículo debe desaparecer del combo de lo pendiente de consumir (si el Parte es nuevo, porque si es una edicion sí deben aparecer TODOS los articulos)
        Set dcfields(dcf_ARTICULO).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionParte", "_ArticulosPorOrdenPorProcesoParaComboSinFiltrarStock", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText, mvarId))
        
        Set dcfields(0).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionParte", "_ArticulosPorOrdenPorProcesoParaCombo", Array(oRs!IdProduccionOrden, oRs!IdProduccionProceso, iisEmpty(dcfields(dcf_ARTICULO).BoundText)))

        'si en las fichas hay distintas tolerancias del mismo articulo, en el consumo te aparece dos veces
        
        'Por ahora voy a sacar estas lineas de carga automatica, para que no haya conflictos
        ' con si es el mismo parte o es otro:
        'dcfields(dcf_PROCESO).BoundText = oRs!idproduccionproceso
        'origen.Registro!IdMaquina = oRs!IdMaquina
        
        Set oRs = Nothing
    
        Set oRs = AplicacionProd.ProduccionPartes.TraerFiltrado("_ProximoNumeroEsperado")
        txtNumero = oRs!ProximoNumeroEsperado
        Set oRs = Nothing
    
        If IsNumeric(dcfields(dcf_OP).BoundText) Then
            Dim art As ComPronto.Articulo
            Dim op As ComPronto.ProduccionOrden
            Set op = AplicacionProd.ProduccionOrdenes.Item(dcfields(dcf_OP).BoundText)
            Set art = Aplicacion.Articulos.Item(op.Registro!idArticuloGenerado)
            lblArticuloProducido = art.Registro!descripcion & "    Color:" & Aplicacion.Colores.Item(iisNull(op.Registro!IdColor, 0)).Registro!descripcion

            'En la PARTE DE PROD., en la ficha de "Terminado/Subproducto", visualizar el Artículo+Color.

            
            
'/////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////
'    los semielaborados tambien se etiquetan?
'-por lo menos avisà si es semielaborado o terminado
            Dim oRsTipo As ADOR.Recordset
            Set oRsTipo = Aplicacion.Tipos.TraerTodos
            oRsTipo.Filter = "Descripcion='Terminado'"
            
            lblInfoProduccion.Visible = True
            If oRsTipo.RecordCount > 0 Then
                If art.Registro!Idtipo = oRsTipo!Idtipo Then
                    txtCantidadProducida.Enabled = False
                    
                    
                    lblInfoProduccion.Caption = " ( ) semielaborado         (x) terminado"
            
                Else
                    lblInfoProduccion.Caption = " (x) semielaborado         ( ) terminado"
                    'txtCantidadProducida.Enabled = True
                End If
            Else
                    lblInfoProduccion.Caption = " (x) semielaborado         ( ) terminado"
                'txtCantidadProducida.Enabled = True
            End If
            
'/////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////
            
            
            
            
            Set op = Nothing
            Set art = Nothing
        End If
        
        
            
        
    
    Else

        If ParoInicio <> 0 And IsNull(ParoFinal) Then ParoFinal = Now
        TurnoInicio.Enabled = False
    End If

    cmd(1).Enabled = True
    cmd(0).Enabled = True
   
    If mvarId <> -1 Then 'es edicion
        Dim X As ComPronto.proceso
        Set X = AplicacionProd.Procesos.Item(origen.Registro!IdProduccionProceso)
        
        'Cuando en PROCESOS no está tildado "Incorpora Material", bloquear en PARTES DE PROD. la ficha "Consumo".
        
        If X.Registro!incorpora <> "SI" Then
            SSTab1.TabEnabled(1) = False
            dcfields(dcf_ARTICULO).Enabled = False
            dcfields(dcf_PARTIDA).Enabled = False
            dcfields(dcf_UBICACION).Enabled = False
            lblMensaje = "El proceso elegido no incorpora material"
        Else
            SSTab1.TabEnabled(1) = True
            dcfields(dcf_ARTICULO).Enabled = True
            'dcfields(dcf_PARTIDA).Enabled = True
            dcfields(dcf_UBICACION).Enabled = True

            If lblMensaje = "El proceso elegido no incorpora material" Then lblMensaje = ""
        End If
    
        'no permitir editar uno de paro o control de calidad
        'If Not IsNull(origen.Registro!paroObservacion) Or Not IsNull(origen.Registro!idprod_tiposControlCalidad) Then
        '    cmd(0).Enabled = False
        'End If
        
        Set op = AplicacionProd.ProduccionOrdenes.Item(dcfields(dcf_OP).BoundText)
        Set art = Aplicacion.Articulos.Item(op.Registro!idArticuloGenerado)
        lblArticuloProducido = art.Registro!descripcion & "    Color:" & Aplicacion.Colores.Item(iisNull(op.Registro!IdColor, 0)).Registro!descripcion
    
        'si el parte es de Paro, que al entrar para cerralo vaya directo a esa solapa
    
        txtStockActual = origen.Registro!Aux_txtStockActual
        SinLimite = IsNull(origen.Registro!Aux_txtTolerancia)

        txtTolerancia = origen.Registro!Aux_txtTolerancia
        txtPendiente = origen.Registro!Aux_txtPendiente
        
        dcfields(dcf_OP).Enabled = False
        dcfields(dcf_PROCESO).Enabled = False
        
        lblColorConsumido = ProduccionModulo.NombreColor(origen.Registro!IdColor)
        'que pasa si es null? es decir, si asignaron una partida generica?
        
        'si la op está cerrada o anulada, el parte es intocable
        Dim s As String
        s = op.GetEstado

        If (s = "ANULADA" Or s = "CERRADA") Then
            cmd(0).Enabled = False
            cmd(4).Enabled = False
        End If
        
        If Not IsNull(origen.Registro.Fields("IdUsuarioCerro").Value) Then
            'el parte está cerrado
            cmd(0).Visible = False
            cmd(5).Visible = False
        End If
    
        If Not IsNull(origen.Registro!IdUsuarioCerro) Then
            'el parte esta cerrado
                
            'DisableControls
            
            'Dim oControl As Control
            For Each oControl In Me.Controls
                oControl.Enabled = False
            Next
        
            SSTab1.Enabled = True
            SSTab1.TabEnabled(0) = True
            SSTab1.TabEnabled(1) = True
            SSTab1.TabEnabled(2) = True
            SSTab1.TabEnabled(3) = True
            SSTab1.TabEnabled(4) = True
            
            cmdVerOP.Enabled = True
            cmd(0).Enabled = True
           
            cmd(4).Enabled = True
        End If

        If EstaProcesoCerrado() Then
            'el proceso esta cerrado
            cmd(6).Visible = False
        End If
    
        'Lo mismo si el PP está anulado
        If origen.Registro!Anulada = "SI" Then
            cmd(0).Enabled = False
            cmd(4).Enabled = False
                
        End If
    
    End If
    
    SinLimite = IsNull(origen.Registro.Fields("Tolerancia").Value)
   
    'Cuando el Parte ya está cerrado y se abre para Consulta, debe quedar bloqueado.
    'Tener ya hora de Inicio y Final. Depende del permiso del usuario del sistema.
    'En el caso de un Operario no puede editar, en el caso de un Supervisor sí lo puede hacer,
    'para las OP Cerradas el Parte ya no es editable.
    
    If IsNull(TraerValorParametro2("IdObraDefault")) Then 'si la obra no controla stock, no se pueden hacer consumos ni ingresos
        dcfields(dcf_ARTICULO).Enabled = False
        dcfields(dcf_PARTIDA).Enabled = False
        dcfields(dcf_UBICACION).Enabled = False
    
        txtPeso.Enabled = False
        
        SSTab1.TabEnabled(1) = False
        SSTab1.TabEnabled(4) = False
    End If
    
    If IsNumeric(dcfields(dcf_ARTICULO).BoundText) Then 'el articulo no se puede modificar
        dcfields(dcf_ARTICULO).Enabled = False
        dcfields(dcf_PARTIDA).Enabled = False
        dcfields(dcf_UBICACION).Enabled = False
    
        txtPeso.Enabled = False
    End If
    
    If (Not IsNull(TurnoFinal) And NivelAcceso > Medio) Then
        cmd(0).Enabled = False
    End If

    dcfields_Click 3, 0
   
    'If IsNumeric(dcfields(dcf_ARTICULO).BoundText) Then
    '     SSTab1.Tab = 1
    'End If

    habilitado = True

    If mvarId = -1 Then
        habilitado = MostrarListadoDeProcesosyArticulosPendientes
    End If
   
    '///////////////////////////////////////////
    '///////////////////////////////////////////
    '///////////////////////////////////////////
    'qué ficha muestro de entrada?
    
    If IsNumeric(dcfields(dcf_ARTICULO).BoundText) Then
        SSTab1.Tab = 1 'Muestro el Tab de consumo
    Else
        SSTab1.Tab = 3 'Muestro el Tab del turno
        'dcfields(dcf_ARTICULO).Visible = False
        'lblcolorproducido.Visible
    End If

    If (mvarId <> -1) Then
        If origen.Registro.Fields("ParoObservacion") <> "" Then
            SSTab1.Tab = 0
        End If
    End If
  
    '///////////////////////////////////////////
    '///////////////////////////////////////////
    '///////////////////////////////////////////
    
    cmd(1).Enabled = True
    
    Set oAp = Nothing

End Property

Function MostrarListadoDeProcesosyArticulosPendientes() As Boolean
    'Exit Function
    
    Dim oFOP As frmConsultaProcesosPendientes
    Set oFOP = New frmConsultaProcesosPendientes

    With oFOP
        .Id = "Compras"
        '.FiltroArticulo = dcfields(dcf_OP).BoundText
        .Show vbModal, Me
    End With
    
    If IsEmpty(oFOP.IdProduccionOrdenElegida) Then
        Unload oFOP
        Set oFOP = Nothing
        MostrarListadoDeProcesosyArticulosPendientes = False
        Exit Function
    End If
    
    If oFOP.IdProduccionOrdenElegida = -1 Then
        Unload oFOP
        Set oFOP = Nothing
        MostrarListadoDeProcesosyArticulosPendientes = False
        Exit Function
    End If
    
    If Not EstaHabilitadoEsteProcesoEnOP(oFOP.IdProcesoElegido, oFOP.IdProduccionOrdenElegida) Then
        Unload oFOP
        Set oFOP = Nothing
        MostrarListadoDeProcesosyArticulosPendientes = False
        Exit Function
    End If

    MostrarListadoDeProcesosyArticulosPendientes = PostmodalProcesosPendientes(oFOP)
    ValidarPeso
    Unload oFOP
    Set oFOP = Nothing
End Function

Function PostmodalProcesosPendientes(oF As frmConsultaProcesosPendientes) As Boolean
    PostmodalProcesosPendientes = True
    
    Dim oL As ListItem

    With oF
    
        origen.Registro!IdProduccionOrden = oF.IdProduccionOrdenElegida
        dcfields(dcf_OP).BoundText = oF.IdProduccionOrdenElegida
        dcfields(dcf_OP).Text = dcfields(dcf_OP).Text
        
        origen.Registro!IdProduccionProceso = oF.IdProcesoElegido
        rebindProceso
        dcfields(dcf_PROCESO).BoundText = oF.IdProcesoElegido
        dcfields(dcf_PROCESO).Text = dcfields(dcf_PROCESO).Text
        'CambiaDcfields Me, dcf_PROCESO, oF.IdProcesoElegido
        'dcfields(dcf_PROCESO).Text = NombreProceso(oF.IdProcesoElegido)
        
        If Not EstaHabilitadoEsteProceso Then
            PostmodalProcesosPendientes = False
            Exit Function
        End If
        
        If oF.IdArticuloElegido <> "" Then
            origen.Registro!IdArticulo = oF.IdArticuloElegido
            rebindArticulos
            dcfields(dcf_ARTICULO).BoundText = oF.IdArticuloElegido
            dcfields(dcf_ARTICULO).Text = dcfields(dcf_ARTICULO).Text
    
    
    
            '//////////////////
            'TODO!!!!! TAREA
            '-faltaba la actualizacion de la base (el altertable donde se agrega el campo IdColor a ProduccionPartes...)
    
            origen.Registro!IdColor = oF.IdColor
            origen.Registro!IdDetalleProduccionOrdenImputado = oF.IdDetalleProduccionOrden
            
            lblColorConsumido = ProduccionModulo.NombreColor(oF.IdColor)
        End If
   
        'SinLimite = IsNull(oF.Tolerancia)
   
        'asigno la ubicacion de consumo automatica del proceso, si es que tiene
        If Not IsNull(Aplicacion.Procesos.Item(dcfields(dcf_PROCESO).BoundText).Registro!idUbicacion) Then
            dcfields(dcf_UBICACION).BoundText = Aplicacion.Procesos.Item(dcfields(dcf_PROCESO).BoundText).Registro!idUbicacion
            dcfields(dcf_UBICACION).Enabled = False
        Else
            dcfields(dcf_UBICACION).Enabled = True
        End If
        
        'cambiar la maquina, trayendo la op que figura en dcfields(dcf_OP)
        ' -Pero con cual me quedo, con la asociada al proceso o al articulo???
        If IsNumeric(dcfields(dcf_OP).BoundText) Then
            'Dim op As ProduccionOrden
            Dim detordenproc As DetProdOrdenProceso
            Dim xrs As ADOR.Recordset
            Dim op As ComPronto.ProduccionOrden
            Set op = AplicacionProd.ProduccionOrdenes.Item(dcfields(dcf_OP).BoundText)
            'Set detordenproc = op.DetProduccionOrdenesProcesos.Item(dcfields(dcf_PROCESO).BoundText)
            'dcfields(8).BoundText = iisNull(detordenproc.Registro!IdMaquina, "")
            
            'Set xrs = op.DetProduccionOrdenes.TraerTodos
            'xrs.Filter = "idArticulo=" & dcfields(dcf_ARTICULO).BoundText

            'como no sé todavía si el indice es el ID del renglon o del proceso,
            ' lo filtro con ADO
            Set xrs = op.DetProduccionOrdenesProcesos.TraerTodos
            xrs.Filter = "idProduccionProceso=" & dcfields(dcf_PROCESO).BoundText
            
            dcfields(8).BoundText = iisNull(xrs!IdMaquina, "")
            
            IdMaquinaOriginal = iisNull(xrs!IdMaquina, "")
            
            If dcfields(8) = "" Then
                'si no hay maquina asociada, tomo por default la primera que encuentro
                'Set xrs = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorDescripcionTipoParaCombo", Array(0, "Equipo"))
                'dcfields(8).BoundText = iisNull(xrs!IdArticulo, "")
                
                dcfields(8).Enabled = True
            End If
            
            Set op = Nothing
            Set detordenproc = Nothing
        End If

        Set oF = Nothing
    End With

End Function

Private Sub txtDescripcion_GotFocus()
   
    'With txtDescripcion
    '   .SelStart = 0
    '   .SelLength = Len(.Text)
    'End With

End Sub

Private Sub lbMasMenos_Click(Index As Integer)
End Sub

Private Sub ParoFinal_Change()

    If ParoFinal < ParoInicio Then ParoFinal = ParoInicio
    If TurnoFinal < ParoFinal Or IsNull(TurnoFinal) Then TurnoFinal = ParoFinal

End Sub

Private Sub ParoFinal_Validate(Cancel As Boolean)
    'If ParoFinal < ParoInicio Then Cancel = True
End Sub

Private Sub ParoInicio_Change()

    If Not IsNull(ParoInicio) Then
        'AutoTurno
    End If

End Sub

Sub AutoTurno()

    If IsNull(TurnoInicio) Then TurnoInicio = Now
    'If IsNull(TurnoFinal) Then TurnoFinal = Now
End Sub

Private Sub TurnoFinal_Validate(Cancel As Boolean)
    'If TurnoFinal < TurnoInicio Then Cancel = True
End Sub

Private Sub txtCantidadProducida_Change()
    '·          Cuando se trate de la fabricación de un artículo que va empacado por caja,
    'el sistema de PRODUCCION leerá la cantidad neta del pesaje (“Tabla Unidades Empaque”)
    'de las cajas correspondiente a la partida cada vez que se consulte la Orden de Producción.
    
    'Stop
    AutoTurno
End Sub

Private Sub TurnoFinal_Change()

    'If TurnoFinal <> Null Then
    If IsNull(TurnoInicio) Then TurnoFinal = Null
    
    If TurnoFinal < TurnoInicio Then TurnoFinal = TurnoInicio
    'End If
End Sub

Private Sub txtCausaParo_Change()
    ParoInicio = Now
    
End Sub

Private Sub txtPeso_Validate(Cancel As Boolean)
    'articulo
    Cancel = False

    If Not IsNumeric(dcfields(dcf_ARTICULO).BoundText) Then
        MsgBox "Antes debe elegir un artículo"
        Cancel = True
        Exit Sub
    End If

    If SinLimite Then
        Exit Sub
    End If

    If Val(txtPeso) > Val(txtPendiente) Then
        lblMensaje = "El pesaje es superior a lo necesario"
        'Cancel = True
        'Exit Sub
    Else

        If lblMensaje = "El pesaje es superior a lo necesario" Then lblMensaje = ""
    End If

    'No toma en cuenta la “tolerancia” especificada en la Ficha Técnica.
    'Debe bloquear, no permitir que se pueda cargar más allá de lo especificado
    'con más o menos la tolerancia, y a la vez mostrar un mensaje informado que
    '“la diferencia de peso excede la tolerancia permitida”.
    
    Dim Min, Max
    Min = Val(txtPendiente) - Val(txtTolerancia)
    Max = Val(txtPendiente) + Val(txtTolerancia)
    
    If Val(txtPeso) > Max Then
        MsgBox "El pesaje es superior a la tolerancia permitida"
        lblMensaje = "El pesaje es superior a la tolerancia permitida"
        Cancel = True
    ElseIf Val(txtPeso) < Min And Not EstanPermitidosPartesConConsumosParciales Then
        MsgBox "El pesaje es inferior la tolerancia permitida"
        lblMensaje = "El pesaje es inferior a la tolerancia permitida"
        Cancel = True
    Else

        If lblMensaje = "El pesaje es superior a la tolerancia permitida" Then lblMensaje = ""
        If lblMensaje = "El pesaje es inferior a la tolerancia permitida" Then lblMensaje = ""
    End If

End Sub

'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'ESTO TIENE QUE ESTAR EN LA LOGICA
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Function EnTolerancia() As Boolean
    Dim Min, Max

    Min = Val(txtPendiente) - Val(txtTolerancia)
    Max = Val(txtPendiente) + Val(txtTolerancia)
        
    If Val(txtPeso) >= Min And Val(txtPeso) <= Max Then
        EnTolerancia = True
    ElseIf Val(txtPeso) < Min And EstanPermitidosPartesConConsumosParciales Then
        EnTolerancia = False
    Else
        EnTolerancia = False
    End If

End Function

Function SobreLaTolerancia() As Boolean
    Dim Min, Max

    Min = Val(txtPendiente) - Val(txtTolerancia)
    Max = Val(txtPendiente) + Val(txtTolerancia)
        
    If Val(txtPeso) > Max Then
        SobreLaTolerancia = True
    Else
        SobreLaTolerancia = False
    End If

End Function

Public Sub AnularParte()
    Dim mvarSale As Integer
    Dim mIdAutorizo As Long

    Dim mBorra As Integer
        
    '     'solo se puede anular el PP si la OP no está anulada -Pero la OP no anula el PP?
    '
    '     mBorra = MsgBox("Esta seguro de anular los datos definitivamente ?", vbYesNo, "Eliminar")
    '     If mBorra = vbNo Then
    '        Exit Sub
    '     End If
    
    'mvarSale = MsgBox("Esta seguro de anular la OP ?", vbYesNo, "Anulacion")
    'If mvarSale = vbNo Then
    '   Exit Sub
    'End If
    
    Dim oF As Form
    Set oF = New frmAutorizacion

    With oF
        .Empleado = 0
        .Administradores = True
        '.SuperAdministrador = True
        '.IdFormulario = 70
        .IdFormulario = 0 'EnumFormularios.Remitos '.OrdenesCompra

        .Show vbModal, Me
    End With

    If Not oF.Ok Then
        MsgBox "No puede anular el Parte!", vbExclamation
        'Unload oF
        Set oF = Nothing
        Exit Sub
    End If

    mIdAutorizo = oF.IdAutorizo
    Unload oF
    Set oF = Nothing

    With origen
        .Registro.Fields("Anulada").Value = "SI"
        '.Registro.Fields("IdUsuarioAnulo").Value = mIdAutorizaAnulacion
        '.Registro.Fields("FechaAnulacion").Value = Now
        '.Registro.Fields("MotivoAnulacion").Value = mMotivoAnulacion
        GuardarParteDesdeGUI origen
        '.Guardar
        
    End With
         
    'est = baja
    Aplicacion.Tarea "Log_InsertarRegistro", Array("ANUL", mvarId, 0, Now, 0, "Tabla : PartesProduccion", GetCompName(), glbNombreUsuario)
        
    With actL2
    
        .AccionRegistro = baja
        .Disparador = mvarId
    End With
    
    Unload Me

End Sub

Function EstaHabilitadoEsteProcesoEnOP(IdProceso, idop) As Boolean

    Dim xrs As ADOR.Recordset
   
    Dim s As String
    
    Set xrs = AplicacionProd.ProduccionPartes.TraerFiltrado("_ProcesoAnteriorObligatorioSinRendir", Array(idop, IdProceso))

    If xrs.RecordCount > 0 Then
        'listar los procesos
        
        s = ""

        Do While Not xrs.EOF

            If IsNull(xrs!fechafinal) Then
                s = s & " *" & xrs!descripcion
            End If

            xrs.MoveNext
        Loop
        
        MsgBox "Un proceso anterior necesita iniciarse (" & s & ")", vbExclamation
        
        EstaHabilitadoEsteProcesoEnOP = False
        Exit Function
    End If

    Set xrs = Nothing
      
    Dim X As ComPronto.proceso
    Set X = AplicacionProd.Procesos.Item(IdProceso)
        
    ' If X.Registro!validafinal = "SI" Then
    '     EstaProcesoAnteriorCerrado
    ' End If
    
    EstaHabilitadoEsteProcesoEnOP = True

End Function

Function EstaHabilitadoEsteProceso() As Boolean

    Dim xrs As ADOR.Recordset
    
    'Set xrs = AplicacionProd.ProduccionPartes.TraerFiltrado("_ProcesoIdenticoEnMarcha", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText))
    'If xrs.RecordCount > 0 Then
    '    MsgBox "Hay un proceso identico en marcha sin cerrar", vbExclamation
    '    Exit Sub
    'End If
    'Set xrs = Nothing
    
    'Set xrs = AplicacionProd.ProduccionPartes.TraerFiltrado("_ProcesoAnteriorIniciado", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText))
    'If xrs.RecordCount > 0 Then 'And proceso!validaAnterior Then
    '    MsgBox "El proceso anterior necesita iniciarse", vbExclamation
    '    Exit Sub
    'End If
    'Set xrs = Nothing
    
    Dim s As String
    
    Set xrs = AplicacionProd.ProduccionPartes.TraerFiltrado("_ProcesoAnteriorObligatorioSinRendir", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText))

    If xrs.RecordCount > 0 Then
        'listar los procesos
        
        s = ""

        Do While Not xrs.EOF

            If IsNull(xrs!fechafinal) Then
                s = s & " *" & xrs!descripcion
            End If

            xrs.MoveNext
        Loop
        
        MsgBox "Un proceso anterior necesita iniciarse (" & s & ")", vbExclamation
        EstaHabilitadoEsteProceso = False
        Exit Function
    End If

    Set xrs = Nothing
      
    Dim X As ComPronto.proceso
    Set X = AplicacionProd.Procesos.Item(dcfields(dcf_PROCESO).BoundText)
        
    If X.Registro!validafinal = "SI" Then
        EstaHabilitadoEsteProceso = EstaProcesoAnteriorCerrado
        Exit Function
    End If
    
    EstaHabilitadoEsteProceso = True

End Function

Function EstaProcesoCerrado() As Boolean

    With origen.Registro
                
        Dim oOF As ComPronto.ProduccionOrden
        Set oOF = AplicacionProd.ProduccionOrdenes.Item(origen.Registro.Fields("IdProduccionOrden").Value)
    
        Dim rs As ADOR.Recordset
        Set rs = oOF.DetProduccionOrdenesProcesos.TraerTodos
        
        'edito el primer item
        Do While Not rs.EOF
                         
            Dim oOFproceso As ComPronto.DetProdOrdenProceso
            Set oOFproceso = oOF.DetProduccionOrdenesProcesos.Item(rs!IdDetalleProduccionOrdenProceso)

            With oOFproceso.Registro

                If !IdProduccionProceso = iisNull(origen.Registro.Fields("IdProduccionProceso").Value) Then
                    EstaProcesoCerrado = Not IsNull(!IdProduccionParteQueCerroEsteProceso)
                    Exit Function
                End If

            End With
            
            rs.MoveNext
        Loop
      
        Err.Raise 3434, , "No se encontró el proceso asociado"
                
    End With
      
End Function

Function EstaProcesoAnteriorCerrado() As Boolean
    Dim rs As ADOR.Recordset

    With origen.Registro
        Dim oOF As ComPronto.ProduccionOrden
        Set oOF = AplicacionProd.ProduccionOrdenes.Item(origen.Registro.Fields("IdProduccionOrden").Value)
        Set rs = oOF.DetProduccionOrdenesProcesos.TraerTodos

        'me traigo el id de detalleproceso al que apunta indirectamente el parte
        Dim CualIdDetalleProduccionOrdenProcesoActual As Long

        Do While Not rs.EOF

            If rs!IdProduccionProceso = dcfields(dcf_PROCESO).BoundText Then
                CualIdDetalleProduccionOrdenProcesoActual = rs!IdDetalleProduccionOrdenProceso
                Exit Do
            End If

            rs.MoveNext
        Loop
                
        rs.MoveFirst

        'ahora me fijo si los procesos anteriores estan cumplidos
        Do While Not rs.EOF
                         
            Dim oOFproceso As ComPronto.DetProdOrdenProceso
            Set oOFproceso = oOF.DetProduccionOrdenesProcesos.Item(rs!IdDetalleProduccionOrdenProceso)

            With oOFproceso.Registro

                If !IdDetalleProduccionOrdenProceso < CualIdDetalleProduccionOrdenProcesoActual Then

                    'es anterior
                    If IsNull(!IdProduccionParteQueCerroEsteProceso) Then
                        MsgBox ("El proceso " & NombreProceso(!IdProduccionProceso) & " no está cerrado")
                        EstaProcesoAnteriorCerrado = False
                        Exit Function
                    End If
                End If

            End With
            
            rs.MoveNext
        Loop
      
        EstaProcesoAnteriorCerrado = True
        Exit Function
      
        Err.Raise 3434, , "No se encontró el proceso asociado"
                
    End With
      
    EstaProcesoAnteriorCerrado = True
    Exit Function
    
    'no usar mas esto (codigo obsoleto para verificar que los procesos estuvieran satisfechos)
    Dim xrs As ADOR.Recordset
    Dim s As String
    
    Set xrs = AplicacionProd.ProduccionPartes.TraerFiltrado("_ProcesoAnteriorCerrado", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText))
    Debug.Print "ProduccionPartes_TX_ProcesoAnteriorCerrado " & dcfields(dcf_OP).BoundText & "," & dcfields(dcf_PROCESO).BoundText
    
    If Not xrs Is Nothing Then
        If xrs.RecordCount > 0 Then 'And proceso!ValidaFinal Then
            
            'listar los procesos y los pp que necesitan cerrarse
            Dim FlagTurnoSinCerrar As Boolean
            
            s = vbCrLf

            Do While Not xrs.EOF

                If IsNull(xrs!fechafinal) Then
                    s = s & "PP" & xrs!idProduccionParte & " OP" & xrs!IdProduccionOrden & " " & xrs!proceso & vbCrLf
                End If
                
                xrs.MoveNext
            Loop
            
            If s <> vbCrLf Then
                If MsgBox("Parte(s) del proceso anterior " & s & " necesita(n) cerrarse. Desea continuar?", vbYesNo) = vbYes Then
                Else
                    EstaProcesoAnteriorCerrado = False
                    Exit Function
                End If

            Else
                xrs.MoveFirst

                If MsgBox("El proceso anterior (" & xrs!proceso & ") no alcanza la cantidad esperada (" & xrs!avanzado & " de " & xrs!Cantidad & "). Desea continuar?", vbYesNo) = vbYes Then
                Else
                    EstaProcesoAnteriorCerrado = False
                    Exit Function
                End If
            End If
            
        End If
    
    End If

    Set xrs = Nothing
      
End Function

Sub VerificaParte()
    On Error Resume Next
    Dim xrs As ADOR.Recordset

    If Me.Visible = False Or mvarId <> -1 Then Exit Sub 'Si se está cargando el form
    
    If Not (IsNumeric(dcfields(dcf_OP).BoundText) And IsNumeric(dcfields(dcf_PROCESO).BoundText) And IsNumeric(dcfields(2).BoundText)) Then Exit Sub
    Set xrs = AplicacionProd.ProduccionPartes.TraerFiltrado("_ProcesoIdenticoEnMarcha", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText, dcfields(2).BoundText, Fecha))

    If xrs.RecordCount > 0 Then
        
        If xrs!Empleado = dcfields(2).BoundText Then
            'If MsgBox("Usted tiene el mismo proceso en marcha. Desea cargarlo en pantalla?", vbYesNo) = vbYes Then
            '    Id = xrs!idProduccionparte 'llamo al property let
            'Else
            '    dcfields(dcf_OP) = ""
            '    dcfields(dcf_PROCESO) = ""
            'End If
            'eso de cargar el que tenés en marcha...

        Else
            MsgBox "El usuario " & xrs!Empleado & "tiene en marcha el mismo proceso"
        End If
        
        Exit Sub
        
        'horainicio.Enabled = False
    End If

    Set xrs = Nothing
End Sub

Function IsValid() As Boolean
            
    IsValid = False
    'no estas controlando la partida y me dejas pasar stock negativo
            
    If Not IsNumeric(dcfields(dcf_OP).BoundText) Then
        MsgBox "Debe indicar una Orden de Producción", vbExclamation
        Exit Function
    End If
            
    If Not IsNumeric(dcfields(dcf_PROCESO).BoundText) Then
        MsgBox "Debe indicar un proceso", vbExclamation
        Exit Function
    End If

    If Not IsNumeric(dcfields(8).BoundText) Then
        MsgBox "Debe indicar una Máquina", vbExclamation
        Exit Function
    End If
         
    If IsNumeric(dcfields(dcf_ARTICULO).BoundText) And (Not IsNumeric(txtPeso) Or Val(txtPeso) <= 0) Then
        MsgBox "Debe indicar el Peso", vbExclamation
        Exit Function
    End If
    
    If IsNumeric(dcfields(dcf_ARTICULO).BoundText) And IsNull(origen.Registro!IdStock) Then
        MsgBox "Debe indicar la partida", vbExclamation
        Exit Function
    End If
    
    If IsNumeric(dcfields(dcf_ARTICULO).BoundText) And Not SinLimite Then 'es consumo
        If EstanPermitidosPartesConConsumosParciales Then

            'verifico solamente que no se pase
            If SobreLaTolerancia Then
                MsgBox "El peso es mayor de lo tolerable", vbExclamation
                Exit Function
            End If
    
        Else

            'verifico maximo y minimo tambien
            If EnTolerancia Then
                MsgBox "El peso no está en tolerancia", vbExclamation
                Exit Function
            End If
        
        End If
    End If
         
    '* Ojo como actúa el sistema con los artículos que NO CONTROLAN STOCK,
    '  me tiene que dejar tomarlo en el Parte de Consumo
    If IsNumeric(dcfields(dcf_ARTICULO).BoundText) Then
        Dim art As ComPronto.Articulo
        Set art = Aplicacion.Articulos.Item(dcfields(dcf_ARTICULO).BoundText)

        If iisNull(art.Registro!RegistrarStock, "SI") <> "NO" Then
            If Val(txtPeso) < 0 Then
                MsgBox "El peso no puede ser negativo", vbExclamation
                Exit Function
            End If
                    
            If Val(txtStockActual) < Val(txtPeso) Then
                MsgBox "No hay stock suficiente", vbExclamation
                Exit Function
            End If
                
            'If IsNumeric(dcfields(dcf_PARTIDA).BoundText) Then
            'If dcfields(dcf_PARTIDA) = "" And mvarId < 1 Then 'si el parte no es nuevo, quizas se dejó la partida en blanco
            '    MsgBox "Debe indicar la partida", vbExclamation
            '    Exit Function
            'End If
                    
            If dcfields(dcf_UBICACION) = "" Then
                MsgBox "Debe indicar la ubicación", vbExclamation
                Exit Function
            End If
                
        End If

        Set art = Nothing
            
        If IsNull(TurnoFinal) Then TurnoFinal = TurnoInicio 'si el parte de produccion tiene consumo, colocar la misma fecha de inicio y final
            
    End If
            
    If IsNumeric(dcfields(4).BoundText) Xor IsNumeric(txtCantidadDeshecho) Then
        If txtCantidadDeshecho <> 0 Then
            MsgBox "Debe indicar el peso de subproducto con el artículo desechado", vbExclamation
            Exit Function
        End If
    End If

    If Not EstaHabilitadoEsteProceso Then
        Exit Function
    End If

    If Not IsNull(ParoFinal) And IsNull(TurnoFinal) Then TurnoFinal = TurnoInicio '
            
    Dim oControl As Control
   
    For Each oControl In Me.Controls

        If TypeOf oControl Is DataCombo Then
            If Len(oControl.BoundText) <> 0 Then
                origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
            End If

        ElseIf TypeOf oControl Is DTPicker Then
            origen.Registro.Fields(oControl.DataField).Value = oControl.Value
        End If

    Next
        
    'horas reales
    origen.Registro!HorasReales = DateDiff("h", iisNull(TurnoInicio, Now), iisNull(TurnoFinal, Now))
        
    'horas previstas
    origen.Registro!Horas = origen.Registro!HorasReales
        
    'If IsNumeric(CantidadProducida) Then
    '    idArticuloGenerado=
    'End If
        
    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////
    'por qué se usa esto del rsStock? Me está descajetando la partida que pongo explícitamente!
    'puse 20410, y me cambia a la que encuentre primero usando dcfields(0). Qué quise hacer con esto???
    '-esto debe ser codigo de cuando no ponías la partida explicitamente... -Sí, en ningun momento
    'usás lo partida explicita! -Momentito! Sí lo hacías, ahora me acuerdo... Hacías un tejemaneje con
    'el combo explicito, y pasabas la informacion del idStock a otro combo, que debe ser ese dcfields(0)
    '-Bueno, pero evidentemente ahora no hay ninguna informacion en dcfields(0), y entonces agarra la
    'primera linea que encuentra en rsStock!!!
        
    origen.Registro!CantidadGenerado = Val(txtCantidadProducida)
    'If Val(txtCantidadDeshecho) <> 0 Then
    origen.Registro!Cantidaddeshecho = Val(txtCantidadDeshecho)
    'End If
        
    Dim pos As Integer
    Dim sPartida As String
        
    If IsNumeric(dcfields(dcf_ARTICULO).BoundText) Then

        origen.Registro!IdArticulo = dcfields(dcf_ARTICULO).BoundText
        origen.Registro!Cantidad = Val(txtPeso)
    
        origen.Registro!partida = TraerRegistroStock(origen.Registro!IdStock).Fields("Partida").Value
        origen.Registro!idUbicacion = TraerRegistroStock(origen.Registro!IdStock).Fields("IdUbicacion").Value

        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        
        origen.Registro!Aux_txtStockActual = Val(txtStockActual)
        origen.Registro!Aux_txtTolerancia = Val(txtTolerancia)
        origen.Registro!Aux_txtPendiente = Val(txtPendiente)
        
        '////////////////////////////////////////////////////////
    End If

    IsValid = True
End Function

Sub ValidarPeso()
      
    'origen.Registro!IdStock = BuscaIdStock(dcfields(dcf_ARTICULO).Text, dcfields(dcf_UBICACION).Text, Left$(dcfields(dcf_PARTIDA).Text, InStr(1, dcfields(dcf_PARTIDA), "Stock:") - 2))
    'txtStockActual.Text = mId$(dcfields(dcf_PARTIDA), InStr(1, dcfields(dcf_PARTIDA), "Stock:") + 6)
    
    Dim rs2 As ADOR.Recordset
    Set rs2 = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionParte", "_ArticulosPorOrdenPorProcesoParaComboSinFiltrarStock", Array(dcfields(dcf_OP).BoundText, dcfields(dcf_PROCESO).BoundText))
    'rs2.Find "IdArticulo=" & BuscaIdArticulo(dcfields(dcf_ARTICULO).Text) & " AND color='" & lblColorConsumido.Caption & "'"
    rs2.Filter = "IdArticulo=" & BuscaIdArticulo(dcfields(dcf_ARTICULO).Text) & " AND color='" & lblColorConsumido.Caption & "'"

    If rs2.EOF Then Exit Sub
    
    origen.Registro!Cantidad = Val(txtPeso)

    'Dim X As ComPronto.proceso
    'Set X = AplicacionProd.Procesos.Item(dcfields(dcf_PROCESO).BoundText)
        
    If Val(txtStockActual) <= 0 Then
        txtPeso.Enabled = False
        lblMensaje = "No hay stock disponible de la partida seleccionada"
    Else
        txtPeso.Enabled = True

        If lblMensaje = "No hay stock disponible de la partida seleccionada" Then lblMensaje = ""
    End If
                    
    'dcfields(13) = iisNull(rs2!Color, "") 'color
    SinLimite = IsNull(rs2!Tolerancia)
    txtTolerancia = iisNull(rs2!Tolerancia * rs2!TotalEsperado / 100, "0")
    txtToleranciaCopia = iisNull(rs2!Tolerancia, 0)
                    
    Dim A
    A = iisNull(rs2!TotalEsperado, 0) - iisNull(rs2!avanzado, 0)
    txtPendiente = IIf(A < 0, 0, A)
                    
    'txtMaximoEsperado = Val(txtTolerancia) / 100 * iisNull(rs2!TotalEsperado, 0) + Val(txtPendiente)
    txtMaximoEsperado = Val(txtTolerancia) + Val(txtPendiente)
                    
    If Val(txtPendiente) = 0 And Not IsNull(rs2!Tolerancia) Then
        txtPeso.Enabled = False
        lblMensaje = "Se alcanzó la cantidad requerida por el proceso"
    Else
        txtPeso.Enabled = True

        If lblMensaje = "Se alcanzó la cantidad requerida por el proceso" Then lblMensaje = ""
    End If

    If IsNull(origen.Registro!IdStock) Then Exit Sub

    'traigoel nombre de la unidad
    Dim art As ComPronto.Articulo
    Dim rsunidad As ADOR.Recordset
    Set art = Aplicacion.Articulos.Item(dcfields(dcf_ARTICULO).BoundText)
    
    Dim idu As Long
    
    idu = TraerIdUnidadDelIdStockElegido(origen.Registro!IdStock)
    
    Set rsunidad = Aplicacion.Unidades.Item(idu).Registro
    origen.Registro!IdUnidad = TraerIdUnidadDelIdStockElegido(origen.Registro!IdStock) ' art.Registro!IdUnidad 'TraerIdUnidadDelDetalleDeOP(origen.Registro!IdDetalleProduccionOrden)  'art.Registro!IdUnidad
    lblUnid = iisNull(rsunidad!Abreviatura, rsunidad!descripcion)
    Set art = Nothing
    Set rsunidad = Nothing

End Sub
