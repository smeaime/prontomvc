VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.4#0"; "Controles1013.ocx"
Begin VB.Form frmCuentas 
   Caption         =   "Cuentas contables"
   ClientHeight    =   9045
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10380
   Icon            =   "frmCuentas.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   9045
   ScaleWidth      =   10380
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtTextoAuxiliar1 
      DataField       =   "TextoAuxiliar1"
      Height          =   285
      Left            =   2385
      TabIndex        =   82
      Top             =   7335
      Width           =   5310
   End
   Begin VB.TextBox txtTextoAuxiliar2 
      DataField       =   "TextoAuxiliar2"
      Height          =   285
      Left            =   2385
      TabIndex        =   81
      Top             =   7710
      Width           =   5310
   End
   Begin VB.TextBox txtTextoAuxiliar3 
      DataField       =   "TextoAuxiliar3"
      Height          =   285
      Left            =   2385
      TabIndex        =   80
      Top             =   8100
      Width           =   5310
   End
   Begin VB.TextBox txtOrdenamientoAuxiliar 
      DataField       =   "OrdenamientoAuxiliar"
      Height          =   285
      Left            =   8910
      TabIndex        =   78
      Top             =   5760
      Width           =   585
   End
   Begin VB.Frame Frame10 
      Caption         =   "Rubros p/presup.de obra : "
      Height          =   645
      Left            =   3960
      TabIndex        =   73
      Top             =   8280
      Visible         =   0   'False
      Width           =   2130
      Begin VB.OptionButton Option15 
         Caption         =   "Activar"
         Height          =   195
         Left            =   90
         TabIndex        =   75
         Top             =   270
         Width           =   870
      End
      Begin VB.OptionButton Option16 
         Caption         =   "Desactivar"
         Height          =   195
         Left            =   990
         TabIndex        =   74
         Top             =   270
         Width           =   1095
      End
   End
   Begin VB.Frame Frame9 
      Caption         =   "Rubros financieros : "
      Height          =   645
      Left            =   135
      TabIndex        =   68
      Top             =   4365
      Width           =   2130
      Begin VB.OptionButton Option14 
         Caption         =   "Desactivar"
         Height          =   195
         Left            =   990
         TabIndex        =   70
         Top             =   270
         Width           =   1095
      End
      Begin VB.OptionButton Option13 
         Caption         =   "Activar"
         Height          =   195
         Left            =   90
         TabIndex        =   69
         Top             =   270
         Width           =   870
      End
   End
   Begin VB.Frame Frame8 
      Caption         =   "Cuentas de consolidacion por empresas madres : "
      Height          =   1410
      Left            =   5175
      TabIndex        =   56
      Top             =   4320
      Width           =   5100
      Begin VB.TextBox txtCodigoCuentaConsolidacion3 
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
         Left            =   1710
         TabIndex        =   63
         Top             =   990
         Width           =   825
      End
      Begin VB.TextBox txtCodigoCuentaConsolidacion2 
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
         Left            =   1710
         TabIndex        =   60
         Top             =   630
         Width           =   825
      End
      Begin VB.TextBox txtCodigoCuentaConsolidacion 
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
         Left            =   1710
         TabIndex        =   57
         Top             =   270
         Width           =   825
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdCuentaConsolidacion"
         Height          =   315
         Index           =   7
         Left            =   2565
         TabIndex        =   58
         Tag             =   "CuentasConsolidacion"
         Top             =   270
         Width           =   2460
         _ExtentX        =   4339
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdCuenta"
         Text            =   ""
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdCuentaConsolidacion2"
         Height          =   315
         Index           =   8
         Left            =   2565
         TabIndex        =   61
         Tag             =   "CuentasConsolidacion2"
         Top             =   630
         Width           =   2460
         _ExtentX        =   4339
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdCuenta"
         Text            =   ""
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdCuentaConsolidacion3"
         Height          =   315
         Index           =   9
         Left            =   2565
         TabIndex        =   64
         Tag             =   "CuentasConsolidacion3"
         Top             =   990
         Width           =   2460
         _ExtentX        =   4339
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdCuenta"
         Text            =   ""
      End
      Begin VB.Label lblBaseMadre 
         Height          =   300
         Index           =   2
         Left            =   45
         TabIndex        =   65
         Top             =   990
         Width           =   1635
      End
      Begin VB.Label lblBaseMadre 
         Height          =   300
         Index           =   1
         Left            =   45
         TabIndex        =   62
         Top             =   630
         Width           =   1635
      End
      Begin VB.Label lblBaseMadre 
         Height          =   300
         Index           =   0
         Left            =   45
         TabIndex        =   59
         Top             =   225
         Width           =   1635
      End
   End
   Begin VB.TextBox txtCodigoSecundario 
      DataField       =   "CodigoSecundario"
      Height          =   285
      Left            =   2355
      TabIndex        =   54
      Top             =   630
      Width           =   2430
   End
   Begin VB.Frame Frame7 
      Height          =   465
      Left            =   6885
      TabIndex        =   50
      Top             =   2070
      Width           =   3345
      Begin VB.OptionButton Option11 
         Caption         =   "NO"
         Height          =   195
         Left            =   1980
         TabIndex        =   52
         Top             =   180
         Width           =   555
      End
      Begin VB.OptionButton Option12 
         Caption         =   "SI"
         Height          =   195
         Left            =   2700
         TabIndex        =   51
         Top             =   180
         Width           =   510
      End
      Begin VB.Label Label4 
         Caption         =   "Ajusta por inflacion ? :"
         Height          =   195
         Left            =   90
         TabIndex        =   53
         Top             =   180
         Width           =   1725
      End
   End
   Begin VB.CheckBox Check2 
      Height          =   195
      Left            =   2385
      TabIndex        =   49
      Top             =   5490
      Width           =   195
   End
   Begin VB.Frame Frame6 
      Caption         =   "Agrupacion auxiliar : "
      Height          =   1590
      Left            =   6885
      TabIndex        =   41
      Top             =   2610
      Width           =   3345
      Begin VB.TextBox txtCodigoAgrupacionAuxiliar 
         Alignment       =   2  'Center
         DataField       =   "CodigoAgrupacionAuxiliar"
         Enabled         =   0   'False
         Height          =   285
         Left            =   1890
         TabIndex        =   44
         Top             =   585
         Width           =   690
      End
      Begin VB.CheckBox Check1 
         Alignment       =   1  'Right Justify
         Caption         =   "Activar agrupacion auxiliar de ctas. :"
         Height          =   240
         Left            =   90
         TabIndex        =   42
         Top             =   270
         Width           =   2940
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdObraAgrupacionAuxiliar"
         Height          =   315
         Index           =   5
         Left            =   90
         TabIndex        =   46
         Tag             =   "Obras"
         Top             =   1170
         Width           =   3150
         _ExtentX        =   5556
         _ExtentY        =   556
         _Version        =   393216
         Enabled         =   0   'False
         Style           =   2
         ListField       =   "Titulo"
         BoundColumn     =   "IdObra"
         Text            =   ""
      End
      Begin VB.Label Label3 
         Caption         =   "Obra / CC :"
         Height          =   195
         Index           =   1
         Left            =   90
         TabIndex        =   45
         Top             =   945
         Width           =   870
      End
      Begin VB.Label Label3 
         Caption         =   "Codigo de agrupacion : "
         Height          =   195
         Index           =   0
         Left            =   90
         TabIndex        =   43
         Top             =   630
         Width           =   1770
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Grupo de gasto :"
      Height          =   645
      Left            =   135
      TabIndex        =   38
      Top             =   3645
      Width           =   2130
      Begin VB.OptionButton Option9 
         Caption         =   "Activar"
         Height          =   195
         Left            =   90
         TabIndex        =   40
         Top             =   270
         Width           =   870
      End
      Begin VB.OptionButton Option10 
         Caption         =   "Desactivar"
         Height          =   195
         Left            =   990
         TabIndex        =   39
         Top             =   270
         Width           =   1095
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "Obra / C.Costo :"
      Height          =   645
      Left            =   135
      TabIndex        =   33
      Top             =   2925
      Width           =   2130
      Begin VB.OptionButton Option8 
         Caption         =   "Desactivar"
         Height          =   195
         Left            =   990
         TabIndex        =   35
         Top             =   270
         Width           =   1095
      End
      Begin VB.OptionButton Option7 
         Caption         =   "Activar"
         Height          =   195
         Left            =   90
         TabIndex        =   34
         Top             =   270
         Width           =   870
      End
   End
   Begin VB.Frame Frame3 
      Height          =   465
      Left            =   6885
      TabIndex        =   29
      Top             =   1530
      Width           =   3345
      Begin VB.OptionButton Option6 
         Caption         =   "SI"
         Height          =   195
         Left            =   2700
         TabIndex        =   31
         Top             =   180
         Width           =   510
      End
      Begin VB.OptionButton Option5 
         Caption         =   "NO"
         Height          =   195
         Left            =   1980
         TabIndex        =   30
         Top             =   180
         Width           =   555
      End
      Begin VB.Label Label2 
         Caption         =   "Va al CITI ? (p/cta. IVA) :"
         Height          =   195
         Left            =   90
         TabIndex        =   32
         Top             =   180
         Width           =   1725
      End
   End
   Begin VB.CommandButton cmdCodigo 
      Caption         =   "Buscar codigo nuevo"
      Height          =   285
      Left            =   4905
      TabIndex        =   24
      Top             =   225
      Width           =   1860
   End
   Begin VB.Frame Frame2 
      Height          =   465
      Left            =   6885
      TabIndex        =   20
      Top             =   990
      Width           =   3345
      Begin VB.OptionButton Option4 
         Caption         =   "Haber"
         Height          =   195
         Left            =   2475
         TabIndex        =   22
         Top             =   180
         Width           =   780
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Debe"
         Height          =   195
         Left            =   1575
         TabIndex        =   21
         Top             =   180
         Width           =   870
      End
      Begin VB.Label Label1 
         Caption         =   "Tipo de cuenta :"
         Height          =   240
         Left            =   180
         TabIndex        =   23
         Top             =   180
         Width           =   1455
      End
   End
   Begin VB.TextBox txtJerarquia 
      Height          =   285
      Index           =   4
      Left            =   4275
      TabIndex        =   8
      Top             =   5085
      Width           =   495
   End
   Begin VB.TextBox txtJerarquia 
      Height          =   285
      Index           =   3
      Left            =   3735
      TabIndex        =   7
      Top             =   5085
      Width           =   495
   End
   Begin VB.TextBox txtJerarquia 
      Height          =   285
      Index           =   2
      Left            =   3195
      TabIndex        =   6
      Top             =   5085
      Width           =   495
   End
   Begin VB.TextBox txtJerarquia 
      Height          =   285
      Index           =   1
      Left            =   2790
      TabIndex        =   5
      Top             =   5085
      Width           =   360
   End
   Begin VB.TextBox txtJerarquia 
      Height          =   285
      Index           =   0
      Left            =   2355
      TabIndex        =   4
      Top             =   5085
      Width           =   360
   End
   Begin VB.Frame Frame1 
      Caption         =   "Rubros contables :"
      Height          =   645
      Left            =   135
      TabIndex        =   15
      Top             =   2205
      Width           =   2130
      Begin VB.OptionButton Option1 
         Caption         =   "Activar"
         Height          =   195
         Left            =   90
         TabIndex        =   17
         Top             =   270
         Width           =   870
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Desactivar"
         Height          =   195
         Left            =   990
         TabIndex        =   16
         Top             =   270
         Width           =   1095
      End
   End
   Begin VB.TextBox txtCodigo 
      DataField       =   "Codigo"
      Height          =   285
      Left            =   2355
      TabIndex        =   0
      Top             =   225
      Width           =   2430
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   9
      Top             =   8550
      Width           =   1080
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   2385
      TabIndex        =   11
      Top             =   8550
      Width           =   1080
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   1260
      TabIndex        =   10
      Top             =   8550
      Width           =   1080
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   285
      Left            =   2355
      TabIndex        =   1
      Top             =   1005
      Width           =   4410
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdTipoCuenta"
      Height          =   315
      Index           =   0
      Left            =   2355
      TabIndex        =   2
      Tag             =   "TiposCuenta"
      Top             =   1395
      Width           =   4410
      _ExtentX        =   7779
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdRubroContable"
      Height          =   315
      Index           =   1
      Left            =   2340
      TabIndex        =   3
      Tag             =   "RubrosContables"
      Top             =   2520
      Width           =   4410
      _ExtentX        =   7779
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdRubroContable"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdTipoCuentaGrupo"
      Height          =   315
      Index           =   2
      Left            =   2355
      TabIndex        =   25
      Tag             =   "TiposCuentaGrupos"
      Top             =   1800
      Width           =   4410
      _ExtentX        =   7779
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoCuentaGrupo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaGasto"
      Height          =   315
      Index           =   3
      Left            =   2340
      TabIndex        =   27
      Tag             =   "CuentasGastos"
      Top             =   3960
      Width           =   4410
      _ExtentX        =   7779
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaGasto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   4
      Left            =   2340
      TabIndex        =   36
      Tag             =   "Obras"
      Top             =   3240
      Width           =   4410
      _ExtentX        =   7779
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProvincia"
      Height          =   315
      Index           =   6
      Left            =   2625
      TabIndex        =   47
      Tag             =   "Provincias"
      Top             =   5445
      Width           =   2475
      _ExtentX        =   4366
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdProvincia"
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   1005
      Left            =   135
      TabIndex        =   66
      Top             =   6030
      Width           =   10140
      _ExtentX        =   17886
      _ExtentY        =   1773
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmCuentas.frx":076A
      MultiSelect     =   0   'False
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   9765
      Top             =   0
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
            Picture         =   "frmCuentas.frx":0786
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCuentas.frx":0898
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCuentas.frx":0CEA
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCuentas.frx":113C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdRubroFinanciero"
      Height          =   315
      Index           =   10
      Left            =   2355
      TabIndex        =   71
      Tag             =   "RubrosFinancieros"
      Top             =   4725
      Width           =   2745
      _ExtentX        =   4842
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdRubroContable"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdPresupuestoObraRubro"
      Height          =   315
      Index           =   11
      Left            =   6210
      TabIndex        =   76
      Tag             =   "PresupuestoObrasRubros"
      Top             =   8595
      Visible         =   0   'False
      Width           =   4410
      _ExtentX        =   7779
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPresupuestoObraRubro"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      Height          =   315
      Index           =   0
      Left            =   7785
      TabIndex        =   83
      Top             =   7335
      Visible         =   0   'False
      Width           =   2520
      _ExtentX        =   4445
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdConcepto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      Height          =   315
      Index           =   1
      Left            =   7785
      TabIndex        =   84
      Top             =   7695
      Visible         =   0   'False
      Width           =   2520
      _ExtentX        =   4445
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdConcepto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      Height          =   315
      Index           =   2
      Left            =   7785
      TabIndex        =   85
      Top             =   8055
      Visible         =   0   'False
      Width           =   2520
      _ExtentX        =   4445
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdConcepto"
      Text            =   ""
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Datos adicionales 1 :"
      Height          =   255
      Index           =   43
      Left            =   135
      TabIndex        =   89
      Top             =   7335
      Width           =   2160
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Datos adicionales 2 :"
      Height          =   255
      Index           =   44
      Left            =   135
      TabIndex        =   88
      Top             =   7710
      Width           =   2160
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Datos adicionales 3 :"
      Height          =   255
      Index           =   45
      Left            =   135
      TabIndex        =   87
      Top             =   8100
      Width           =   2160
   End
   Begin VB.Label lblAuxiliares 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Mascaras"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   0
      Left            =   7830
      TabIndex        =   86
      Top             =   7065
      Visible         =   0   'False
      Width           =   2400
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Ordenamiento para informe de posicion financiera :"
      Height          =   195
      Index           =   13
      Left            =   5175
      TabIndex        =   79
      Top             =   5805
      Width           =   3690
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Rubro para presupuesto de obra :"
      Height          =   240
      Index           =   12
      Left            =   6210
      TabIndex        =   77
      Top             =   8280
      Visible         =   0   'False
      Width           =   2475
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Rubro financiero :"
      Height          =   240
      Index           =   11
      Left            =   2385
      TabIndex        =   72
      Top             =   4410
      Width           =   1305
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Detalle de cambios en la denominacion de la cuenta :"
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
      Index           =   10
      Left            =   135
      TabIndex        =   67
      Top             =   5850
      Width           =   4680
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo secundario :"
      Height          =   240
      Index           =   9
      Left            =   135
      TabIndex        =   55
      Top             =   630
      Width           =   2160
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Provincia (opcional p/IIBB) :"
      Height          =   240
      Index           =   8
      Left            =   135
      TabIndex        =   48
      Top             =   5490
      Width           =   2160
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Obra / Centro de costo :"
      Height          =   255
      Index           =   7
      Left            =   2370
      TabIndex        =   37
      Top             =   2925
      Width           =   1800
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Grupo de gasto  :"
      Height          =   240
      Index           =   6
      Left            =   2385
      TabIndex        =   28
      Top             =   3645
      Width           =   1305
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Agrupacion de cuenta :"
      Height          =   240
      Index           =   5
      Left            =   135
      TabIndex        =   26
      Top             =   1845
      Width           =   2160
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Jerarquia :"
      Height          =   240
      Index           =   4
      Left            =   135
      TabIndex        =   19
      Top             =   5130
      Width           =   2160
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Rubro contable :"
      Height          =   255
      Index           =   2
      Left            =   2385
      TabIndex        =   18
      Top             =   2205
      Width           =   1275
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Tipo de cuenta :"
      Height          =   240
      Index           =   3
      Left            =   135
      TabIndex        =   14
      Top             =   1440
      Width           =   2160
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo :"
      Height          =   240
      Index           =   0
      Left            =   135
      TabIndex        =   13
      Top             =   225
      Width           =   2160
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripcion :"
      Height          =   285
      Index           =   1
      Left            =   135
      TabIndex        =   12
      Top             =   1020
      Width           =   2160
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
End
Attribute VB_Name = "frmCuentas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Cuenta
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long
Private mvarBasePRONTOConsolidacion As String, mvarBasePRONTOConsolidacion2 As String, mvarBasePRONTOConsolidacion3 As String
Private mvarControlCuenta As Boolean
Private mFechaParaPlanCuentas1 As Date
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

Private Sub Check1_Click()

   If Check1.Value = 1 Then
      txtCodigoAgrupacionAuxiliar.Enabled = True
      DataCombo1(5).Enabled = True
   Else
      With origen.Registro
         .Fields("CodigoAgrupacionAuxiliar").Value = Null
         .Fields("IdObraAgrupacionAuxiliar").Value = Null
      End With
      txtCodigoAgrupacionAuxiliar.Enabled = False
      DataCombo1(5).Enabled = False
   End If

End Sub

Private Sub Check2_Click()

   If Check2.Value = 1 Then
      DataCombo1(6).Enabled = True
   Else
      origen.Registro.Fields("IdProvincia").Value = Null
      DataCombo1(6).Enabled = False
   End If

End Sub

Sub Editar(ByVal Cual As Long)

   Dim oF As frmDetCuentas
   Dim oL As ListItem
   
   Set oF = New frmDetCuentas
   
   With oF
      Set .Cuenta = origen
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
            .Text = oF.txtCodigoAnterior.Text
            .SubItems(1) = "" & oF.txtNombreAnterior.Text
            .SubItems(2) = "" & oF.DTFields(0).Value
            .SubItems(3) = "" & oF.txtJerarquia(0).Text & "." & oF.txtJerarquia(1).Text & "." & oF.txtJerarquia(2).Text & "." & oF.txtJerarquia(3).Text & "." & oF.txtJerarquia(4).Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
      Case 0
         If Not Option3.Value And Not Option4.Value Then
            MsgBox "Indique si la cuenta es del debe o el haber", vbInformation
            Exit Sub
         End If
         
         If Len(txtCodigo.Text) = 0 Then
            MsgBox "Debe ingresar un codigo de cuenta", vbInformation
            Exit Sub
         End If
         
         If Len(txtDescripcion.Text) = 0 Then
            MsgBox "Debe ingresar una descripcion de la cuenta", vbInformation
            Exit Sub
         End If
         
         If txtCodigoAgrupacionAuxiliar.Enabled And Len(txtCodigoAgrupacionAuxiliar.Text) = 0 Then
            MsgBox "Debe ingresar el codigo de agrupacion auxiliar", vbInformation
            Exit Sub
         End If
         
         If Len(txtJerarquia(0).Text) <> 1 Or Len(txtJerarquia(1).Text) <> 1 Or Len(txtJerarquia(2).Text) <> 2 Or _
            Len(txtJerarquia(3).Text) <> 2 Or Len(txtJerarquia(4).Text) <> 3 Then
            MsgBox "Verifique la jerarquia, no fue ingresada o el formato no es el correcto", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe ingresar el tipo de cuenta", vbExclamation
            Exit Sub
         End If
         
         Dim est As EnumAcciones
         Dim dc As DataCombo
         Dim i As Integer
         Dim mJerarquias As String
         Dim oRs As ADOR.Recordset
         
         mJerarquias = ""
         For i = 0 To 4
            If Len(txtJerarquia(i).Text) > 0 Then mJerarquias = mJerarquias & txtJerarquia(i).Text & "."
         Next
         If Len(mJerarquias) > 0 Then
            mJerarquias = mId(mJerarquias, 1, Len(mJerarquias) - 1)
            If BuscarClaveINI("Permitir jerarquias contables duplicadas") <> "SI" Then
               If Me.FechaParaPlanCuentas > 0 Then
                  Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorCodigoJerarquia", Array(mJerarquias, mvarId, Me.FechaParaPlanCuentas))
               Else
                  Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorCodigoJerarquia", Array(mJerarquias, mvarId))
               End If
               If oRs.RecordCount > 0 Then
                  MsgBox "La jerarquia ya esta asignada a la cuenta " & oRs.Fields("Codigo").Value, vbExclamation
                  oRs.Close
                  Set oRs = Nothing
                  Exit Sub
               End If
               oRs.Close
            End If
         End If
         
         With origen.Registro
            If DataCombo1(0).BoundText = 1 And mvarControlCuenta Then
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_ConMovimientos", mvarId)
               If oRs.RecordCount > 0 Then
                  MsgBox "La cuenta no puede ser titulo porque tiene movimientos asignados (ver mayor)", vbExclamation
                  oRs.Close
                  Set oRs = Nothing
                  Exit Sub
               End If
               oRs.Close
            End If
            For Each dc In DataCombo1
               If dc.Enabled Then
                  If (Len(Trim(dc.BoundText)) = 0 Or Not IsNumeric(dc.BoundText)) And _
                        dc.Index <> 2 And dc.Index <> 3 And dc.Enabled Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
                  If Len(Trim(dc.BoundText)) <> 0 And IsNumeric(dc.BoundText) Then .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
            .Fields("Jerarquia").Value = mJerarquias
            If Option3.Value Then
               .Fields("DebeHaber").Value = "D"
            Else
               .Fields("DebeHaber").Value = "H"
            End If
            If Option5.Value Then
               .Fields("VaAlCiti").Value = "NO"
            Else
               .Fields("VaAlCiti").Value = "SI"
            End If
            .Fields("EnviarEmail").Value = 1
            If Option11.Value Then
               .Fields("AjustaPorInflacion").Value = "NO"
            Else
               .Fields("AjustaPorInflacion").Value = "SI"
            End If
         End With
         
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
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("ALTA", mvarId, 0, Now, 0, "Tabla : Cuentas", GetCompName(), glbNombreUsuario)
         Else
            est = Modificacion
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("MODIF", mvarId, 0, Now, 0, "Tabla : Cuentas", GetCompName(), glbNombreUsuario)
         End If
            
         With actL2
            .ListaEditada = "CuentasTodas,Cuentas12345,+SubCTa"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
      Case 1
         Dim mBorra As Integer
         mBorra = MsgBox("Esta seguro de eliminar los datos definitivamente ?", vbYesNo, "Eliminar")
         If mBorra = vbNo Then Exit Sub
         
         origen.Eliminar
         
         est = baja
         Aplicacion.Tarea "Log_InsertarRegistro", Array("ELIM", mvarId, 0, Now, 0, "Tabla : Cuentas", GetCompName(), glbNombreUsuario)
            
         With actL2
            .ListaEditada = "CuentasTodas,Cuentas12345,+SubCTa"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   End Select
   
Salida:
   Set oRs = Nothing
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
   Resume Salida

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim mJerarquias
   Dim i As Integer
   Dim ListaVacia As Boolean
   
   mvarId = vnewvalue
   
   ListaVacia = False
   mvarControlCuenta = False
   
   Set oAp = Aplicacion
   
   Set origen = oAp.Cuentas.Item(vnewvalue)
   
   If BuscarClaveINI("Datos adicionales para OP", -1) = "SI" Then
      lblAuxiliares(0).Visible = True
      DataCombo2(0).Visible = True
      DataCombo2(1).Visible = True
      DataCombo2(2).Visible = True
      txtTextoAuxiliar1.Locked = True
      txtTextoAuxiliar2.Locked = True
      txtTextoAuxiliar3.Locked = True
   End If
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetCuentas.TraerMascara
                     ListaVacia = True
                  Else
                     Set oRs = origen.DetCuentas.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia = False
                     Else
                        Set oControl.DataSource = origen.DetCuentas.TraerMascara
                        ListaVacia = True
                     End If
                     oRs.Close
                  End If
            End Select
         ElseIf TypeOf oControl Is DbListView Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "CuentasConsolidacion" Then
                  Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_CuentasConsolidacionParaCombo", 1)
               ElseIf oControl.Tag = "CuentasConsolidacion2" Then
                  Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_CuentasConsolidacionParaCombo", 2)
               ElseIf oControl.Tag = "CuentasConsolidacion3" Then
                  Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_CuentasConsolidacionParaCombo", 3)
               ElseIf oControl.Tag = "RubrosFinancieros" Then
                  Set oControl.RowSource = oAp.RubrosContables.TraerFiltrado("_ParaComboFinancierosTodos")
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   Set oRs = oAp.Conceptos.TraerFiltrado("_PorGrupoParaCombo", 3)
   Set DataCombo2(0).RowSource = oRs
   Set oRs = oAp.Conceptos.TraerFiltrado("_PorGrupoParaCombo", 4)
   Set DataCombo2(1).RowSource = oRs
   Set oRs = oAp.Conceptos.TraerFiltrado("_PorGrupoParaCombo", 5)
   Set DataCombo2(2).RowSource = oRs
   
   If mvarId < 0 Then
      Option2.Value = True
      Option3.Value = True
      Option5.Value = True
      Option8.Value = True
      Option11.Value = True
      Option14.Value = True
      Option16.Value = True
      cmd(1).Enabled = False
   Else
      With origen.Registro
         If Not IsNull(.Fields("IdRubroContable").Value) Then
            Option1.Value = True
         Else
            Option2.Value = True
         End If
         If Not IsNull(.Fields("IdObra").Value) Then
            Option7.Value = True
         Else
            Option8.Value = True
         End If
         If IsNull(.Fields("DebeHaber").Value) Or _
               .Fields("DebeHaber").Value = "D" Then
            Option3.Value = True
         ElseIf .Fields("DebeHaber").Value = "H" Then
            Option4.Value = True
         End If
         If IsNull(.Fields("VaAlCiti").Value) Or _
               .Fields("VaAlCiti").Value = "NO" Then
            Option5.Value = True
         ElseIf .Fields("VaAlCiti").Value = "SI" Then
            Option6.Value = True
         End If
         If Not IsNull(.Fields("IdCuentaGasto").Value) Then
            Option9.Value = True
         Else
            Option10.Value = True
         End If
         mJerarquias = VBA.Split(.Fields("Jerarquia").Value, ".")
         For i = 0 To 4
            txtJerarquia(i).Text = mJerarquias(i)
         Next
         If Not IsNull(.Fields("IdObraAgrupacionAuxiliar").Value) Then
            Check1.Value = 1
         End If
         If Not IsNull(.Fields("IdProvincia").Value) Then
            Check2.Value = 1
         Else
            Check2.Value = 0
            DataCombo1(6).Enabled = False
         End If
         If IsNull(.Fields("AjustaPorInflacion").Value) Or _
               .Fields("AjustaPorInflacion").Value = "NO" Then
            Option11.Value = True
         Else
            Option12.Value = True
         End If
         If Not IsNull(.Fields("IdRubroFinanciero").Value) Then
            Option13.Value = True
         Else
            Option14.Value = True
         End If
         If Not IsNull(.Fields("IdPresupuestoObraRubro").Value) Then
            Option15.Value = True
         Else
            Option16.Value = True
         End If
         If .Fields("IdTipoCuenta").Value = 2 Then mvarControlCuenta = True
      End With
   End If
   
   Set oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
   mvarBasePRONTOConsolidacion = ""
   mvarBasePRONTOConsolidacion2 = ""
   mvarBasePRONTOConsolidacion3 = ""
   If oRs.RecordCount > 0 Then
      If IsNull(oRs.Fields("BasePRONTOConsolidacion").Value) Then
         txtCodigoCuentaConsolidacion.Enabled = False
         DataCombo1(7).Enabled = False
         lblBaseMadre(0).Caption = "S/D :"
      Else
         mvarBasePRONTOConsolidacion = oRs.Fields("BasePRONTOConsolidacion").Value
         lblBaseMadre(0).Caption = mvarBasePRONTOConsolidacion
         If mvarId > 0 Then
            If IsNull(origen.Registro.Fields("IdTipoCuenta").Value) Or origen.Registro.Fields("IdTipoCuenta").Value <> 2 Then
               txtCodigoCuentaConsolidacion.Enabled = False
               DataCombo1(7).Enabled = False
            End If
         End If
      End If
      If IsNull(oRs.Fields("BasePRONTOConsolidacion2").Value) Then
         txtCodigoCuentaConsolidacion2.Enabled = False
         DataCombo1(8).Enabled = False
         lblBaseMadre(1).Caption = "S/D :"
      Else
         mvarBasePRONTOConsolidacion2 = oRs.Fields("BasePRONTOConsolidacion2").Value
         lblBaseMadre(1).Caption = mvarBasePRONTOConsolidacion2
         If mvarId > 0 Then
            If IsNull(origen.Registro.Fields("IdTipoCuenta").Value) Or origen.Registro.Fields("IdTipoCuenta").Value <> 2 Then
               txtCodigoCuentaConsolidacion2.Enabled = False
               DataCombo1(8).Enabled = False
            End If
         End If
      End If
      If IsNull(oRs.Fields("BasePRONTOConsolidacion3").Value) Then
         txtCodigoCuentaConsolidacion3.Enabled = False
         DataCombo1(9).Enabled = False
         lblBaseMadre(2).Caption = "S/D :"
      Else
         mvarBasePRONTOConsolidacion3 = oRs.Fields("BasePRONTOConsolidacion3").Value
         lblBaseMadre(2).Caption = mvarBasePRONTOConsolidacion3
         If mvarId > 0 Then
            If IsNull(origen.Registro.Fields("IdTipoCuenta").Value) Or origen.Registro.Fields("IdTipoCuenta").Value <> 2 Then
               txtCodigoCuentaConsolidacion3.Enabled = False
               DataCombo1(9).Enabled = False
            End If
         End If
      End If
   End If
   oRs.Close
   
   If mvarId > 0 Then
      Set oRs = oAp.CuentasGastos.TraerFiltrado("_PorIdCuentaMadre", mvarId)
      If oRs.RecordCount > 0 Then
         txtCodigoCuentaConsolidacion.Enabled = False
         DataCombo1(7).Enabled = False
         txtCodigoCuentaConsolidacion2.Enabled = False
         DataCombo1(8).Enabled = False
         txtCodigoCuentaConsolidacion3.Enabled = False
         DataCombo1(9).Enabled = False
         With origen.Registro
            .Fields(DataCombo1(7).DataField).Value = Null
            .Fields(DataCombo1(8).DataField).Value = Null
            .Fields(DataCombo1(9).DataField).Value = Null
         End With
      End If
      oRs.Close
   End If
   
   If ListaVacia Then
      Lista.ListItems.Clear
   End If
   
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

Private Sub cmdCodigo_Click()

   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.Cuentas.TraerFiltrado("_ProximoCodigoLibre")
   If oRs.RecordCount > 0 Then
      origen.Registro.Fields("Codigo").Value = oRs.Fields(0).Value
   End If
   oRs.Close
   Set oRs = Nothing

End Sub

Private Sub DataCombo1_Click(Index As Integer, Area As Integer)

   If Index = 10 Then
      SetDataComboDropdownListWidth 400
   End If

End Sub

Private Sub DataCombo2_Change(Index As Integer)

   If Me.Visible Then
      With origen.Registro
         .Fields("TextoAuxiliar" & Index + 1).Value = DataCombo2(Index).Text
      End With
   End If

End Sub

Private Sub Form_Load()

   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
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
         Editar Lista.SelectedItem.Tag
      Case 2
         With Lista.SelectedItem
            origen.DetCuentas.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      DataCombo1(1).Enabled = True
   End If
   
End Sub

Private Sub Option10_Click()

   If Option10.Value Then
      origen.Registro.Fields("IdCuentaGasto").Value = Null
      DataCombo1(3).Enabled = False
   End If
   
End Sub

Private Sub Option13_Click()

   If Option13.Value Then
      DataCombo1(10).Enabled = True
   End If
   
End Sub

Private Sub Option14_Click()

   If Option14.Value Then
      origen.Registro.Fields("IdRubroFinanciero").Value = Null
      DataCombo1(10).Enabled = False
   End If
   
End Sub

Private Sub Option15_Click()

   If Option15.Value Then
      DataCombo1(11).Enabled = True
   End If
   
End Sub

Private Sub Option16_Click()

   If Option16.Value Then
      origen.Registro.Fields("IdPresupuestoObraRubro").Value = Null
      DataCombo1(11).Enabled = False
   End If
   
End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      origen.Registro.Fields("IdRubroContable").Value = Null
      DataCombo1(1).Enabled = False
   End If
   
End Sub

Private Sub Option7_Click()

   If Option7.Value Then
      DataCombo1(4).Enabled = True
   End If
   
End Sub

Private Sub Option8_Click()

   If Option8.Value Then
      origen.Registro.Fields("IdObra").Value = Null
      DataCombo1(4).Enabled = False
   End If
   
End Sub

Private Sub Option9_Click()

   If Option9.Value Then
      DataCombo1(3).Enabled = True
   End If
   
End Sub

Private Sub txtCodigo_GotFocus()

   With txtCodigo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigo_Validate(Cancel As Boolean)

   If mvarId < 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorCodigo", Val(txtCodigo.Text))
      If oRs.RecordCount > 0 Then
         MsgBox "Cuenta ya ingresada. Reingrese.", vbCritical
         Cancel = True
      End If
      oRs.Close
      Set oRs = Nothing
   End If

End Sub

Private Sub txtCodigoCuentaConsolidacion_GotFocus()

   With txtCodigoCuentaConsolidacion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoCuentaConsolidacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoCuentaConsolidacion_Validate(Cancel As Boolean)

   If Len(txtCodigoCuentaConsolidacion.Text) > 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("_CuentasConsolidacionPorCodigo", _
                     Array(txtCodigoCuentaConsolidacion.Text, 1))
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdCuentaConsolidacion").Value = oRs.Fields(0).Value
      Else
         MsgBox "Cuenta de consolidacion inexistente", vbExclamation
         Cancel = True
      End If
      oRs.Close
      Set oRs = Nothing
   Else
      origen.Registro.Fields("IdCuentaConsolidacion").Value = Null
   End If

End Sub

Private Sub txtCodigoCuentaConsolidacion2_GotFocus()

   With txtCodigoCuentaConsolidacion2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoCuentaConsolidacion2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoCuentaConsolidacion2_Validate(Cancel As Boolean)

   If Len(txtCodigoCuentaConsolidacion2.Text) > 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("_CuentasConsolidacionPorCodigo", _
                     Array(txtCodigoCuentaConsolidacion2.Text, 2))
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdCuentaConsolidacion2").Value = oRs.Fields(0).Value
      Else
         MsgBox "Cuenta de consolidacion 2 inexistente", vbExclamation
         Cancel = True
      End If
      oRs.Close
      Set oRs = Nothing
   Else
      origen.Registro.Fields("IdCuentaConsolidacion2").Value = Null
   End If

End Sub

Private Sub txtCodigoCuentaConsolidacion3_GotFocus()

   With txtCodigoCuentaConsolidacion3
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoCuentaConsolidacion3_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoCuentaConsolidacion3_Validate(Cancel As Boolean)

   If Len(txtCodigoCuentaConsolidacion3.Text) > 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("_CuentasConsolidacionPorCodigo", _
                     Array(txtCodigoCuentaConsolidacion3.Text, 3))
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdCuentaConsolidacion3").Value = oRs.Fields(0).Value
      Else
         MsgBox "Cuenta de consolidacion 3 inexistente", vbExclamation
         Cancel = True
      End If
      oRs.Close
      Set oRs = Nothing
   Else
      origen.Registro.Fields("IdCuentaConsolidacion3").Value = Null
   End If

End Sub

Private Sub txtCodigoSecundario_GotFocus()

   With txtCodigoSecundario
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoSecundario_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCodigoSecundario
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtDescripcion_GotFocus()

   With txtDescripcion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDescripcion
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      Dim oRs As ADOR.Recordset
      Select Case Index
         Case 0
            If DataCombo1(Index).BoundText = 2 Then
               DataCombo1(3).Enabled = True
            Else
               DataCombo1(3).Enabled = False
            End If
            If Len(mvarBasePRONTOConsolidacion) > 0 Then
               If DataCombo1(Index).BoundText <> 2 Then
                  txtCodigoCuentaConsolidacion.Enabled = False
                  DataCombo1(7).Enabled = False
               Else
                  txtCodigoCuentaConsolidacion.Enabled = True
                  DataCombo1(7).Enabled = True
               End If
            End If
            If Len(mvarBasePRONTOConsolidacion2) > 0 Then
               If DataCombo1(Index).BoundText <> 2 Then
                  txtCodigoCuentaConsolidacion2.Enabled = False
                  DataCombo1(8).Enabled = False
               Else
                  txtCodigoCuentaConsolidacion2.Enabled = True
                  DataCombo1(8).Enabled = True
               End If
            End If
            If Len(mvarBasePRONTOConsolidacion3) > 0 Then
               If DataCombo1(Index).BoundText <> 2 Then
                  txtCodigoCuentaConsolidacion3.Enabled = False
                  DataCombo1(9).Enabled = False
               Else
                  txtCodigoCuentaConsolidacion3.Enabled = True
                  DataCombo1(9).Enabled = True
               End If
            End If
         Case 7
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_CuentasConsolidacionPorIdCuenta", Array(DataCombo1(Index).BoundText, 1))
            If oRs.RecordCount > 0 Then
               txtCodigoCuentaConsolidacion.Text = oRs.Fields("Codigo").Value
            End If
            oRs.Close
         Case 8
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_CuentasConsolidacionPorIdCuenta", Array(DataCombo1(Index).BoundText, 2))
            If oRs.RecordCount > 0 Then
               txtCodigoCuentaConsolidacion2.Text = oRs.Fields("Codigo").Value
            End If
            oRs.Close
         Case 9
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_CuentasConsolidacionPorIdCuenta", Array(DataCombo1(Index).BoundText, 3))
            If oRs.RecordCount > 0 Then
               txtCodigoCuentaConsolidacion3.Text = oRs.Fields("Codigo").Value
            End If
            oRs.Close
      End Select
      Set oRs = Nothing
   End If

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtJerarquia_GotFocus(Index As Integer)

   With txtJerarquia(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
End Sub

Private Sub txtJerarquia_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      If (KeyAscii < 48 Or KeyAscii > 57) And KeyAscii <> vbKeyBack Then
         KeyAscii = 0
      Else
         If ((Index = 0 Or Index = 1) And Len(txtJerarquia(Index)) = 1) Or _
            ((Index = 2 Or Index = 3) And Len(txtJerarquia(Index)) = 2) Or _
            (Index = 4 And Len(txtJerarquia(Index)) = 3) Then
            txtJerarquia(Index) = ""
         End If
      End If
   End If

End Sub

Private Sub txtJerarquia_Validate(Index As Integer, Cancel As Boolean)

   Dim mDigitos As Integer
   If Index = 0 Or Index = 1 Then
      mDigitos = 1
   ElseIf Index = 2 Or Index = 3 Then
      mDigitos = 2
   Else
      mDigitos = 3
   End If
   If ((Index = 0 Or Index = 1) And Len(txtJerarquia(Index)) <> 1) Or _
      ((Index = 2 Or Index = 3) And Len(txtJerarquia(Index)) <> 2) Or _
      (Index = 4 And Len(txtJerarquia(Index)) <> 3) Then
      MsgBox "El nivel debe tener " & mDigitos & " digitos"
      Cancel = True
   End If
   
End Sub

Public Property Get FechaParaPlanCuentas() As Date

   FechaParaPlanCuentas = mFechaParaPlanCuentas1

End Property

Public Property Let FechaParaPlanCuentas(ByVal vnewvalue As Date)

   mFechaParaPlanCuentas1 = vnewvalue

End Property

Private Sub txtOrdenamientoAuxiliar_GotFocus()

   With txtOrdenamientoAuxiliar
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
End Sub

Private Sub txtOrdenamientoAuxiliar_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtTextoAuxiliar1_GotFocus()

   With txtTextoAuxiliar1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTextoAuxiliar1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtTextoAuxiliar1
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtTextoAuxiliar2_GotFocus()

   With txtTextoAuxiliar2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTextoAuxiliar2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtTextoAuxiliar2
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtTextoAuxiliar3_GotFocus()

   With txtTextoAuxiliar3
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTextoAuxiliar3_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtTextoAuxiliar3
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
