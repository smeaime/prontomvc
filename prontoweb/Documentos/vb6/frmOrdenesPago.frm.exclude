VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.4#0"; "Controles1013.ocx"
Begin VB.Form frmOrdenesPago 
   Caption         =   "Ordenes de pago"
   ClientHeight    =   8160
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11925
   Icon            =   "frmOrdenesPago.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   8160
   ScaleWidth      =   11925
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdGuardarRubros 
      Caption         =   "Guardar"
      Enabled         =   0   'False
      Height          =   240
      Left            =   3060
      TabIndex        =   119
      Top             =   5760
      Width           =   750
   End
   Begin VB.TextBox txtTextoAuxiliar3 
      DataField       =   "TextoAuxiliar3"
      Height          =   240
      Left            =   8910
      Locked          =   -1  'True
      TabIndex        =   118
      Top             =   7875
      Visible         =   0   'False
      Width           =   2940
   End
   Begin VB.TextBox txtTextoAuxiliar2 
      DataField       =   "TextoAuxiliar2"
      Height          =   240
      Left            =   4905
      Locked          =   -1  'True
      TabIndex        =   116
      Top             =   7875
      Visible         =   0   'False
      Width           =   2850
   End
   Begin VB.TextBox txtTextoAuxiliar1 
      DataField       =   "TextoAuxiliar1"
      Height          =   240
      Left            =   1035
      Locked          =   -1  'True
      TabIndex        =   114
      Top             =   7875
      Visible         =   0   'False
      Width           =   2715
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   0
      ItemData        =   "frmOrdenesPago.frx":076A
      Left            =   4770
      List            =   "frmOrdenesPago.frx":0774
      TabIndex        =   80
      Top             =   7515
      Visible         =   0   'False
      Width           =   1770
   End
   Begin VB.Frame Frame2 
      Height          =   330
      Left            =   6660
      TabIndex        =   108
      Top             =   765
      Visible         =   0   'False
      Width           =   2580
      Begin VB.OptionButton Option5 
         Caption         =   "Otras operac."
         Height          =   150
         Left            =   1260
         TabIndex        =   110
         Top             =   135
         Width           =   1275
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Trasf.e/Ctas."
         Height          =   150
         Left            =   45
         TabIndex        =   109
         Top             =   135
         Width           =   1275
      End
   End
   Begin VB.CommandButton cmdBuscarPorCuit 
      Appearance      =   0  'Flat
      BackColor       =   &H00E0E0E0&
      Caption         =   "Buscar x CUIT (F11)"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   9990
      MaskColor       =   &H00000000&
      Style           =   1  'Graphical
      TabIndex        =   107
      Top             =   45
      Width           =   870
   End
   Begin VB.TextBox txtDetalle 
      DataField       =   "Detalle"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   3150
      TabIndex        =   105
      Top             =   5895
      Visible         =   0   'False
      Width           =   660
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdConcepto2"
      Height          =   315
      Index           =   4
      Left            =   9765
      TabIndex        =   103
      Tag             =   "Clasificacion"
      Top             =   7470
      Visible         =   0   'False
      Width           =   2130
      _ExtentX        =   3757
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdConcepto"
      Text            =   ""
   End
   Begin VB.CheckBox Check8 
      Alignment       =   1  'Right Justify
      Caption         =   "Inic.?"
      Height          =   240
      Left            =   10260
      TabIndex        =   100
      Top             =   1170
      Visible         =   0   'False
      Width           =   690
   End
   Begin VB.TextBox txtNumeroRendicionFF 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   9765
      TabIndex        =   97
      Top             =   1125
      Visible         =   0   'False
      Width           =   660
   End
   Begin VB.CheckBox Check7 
      Alignment       =   1  'Right Justify
      Caption         =   "Carga automatica de rubros ( x imputaciones ) :"
      Height          =   150
      Left            =   135
      TabIndex        =   96
      Top             =   7560
      Width           =   3660
   End
   Begin VB.CheckBox Check6 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0FFFF&
      Caption         =   "Recalcular retenciones"
      Height          =   375
      Left            =   10710
      TabIndex        =   95
      Top             =   6840
      Width           =   1140
   End
   Begin VB.CheckBox Check5 
      Enabled         =   0   'False
      Height          =   240
      Left            =   10485
      TabIndex        =   94
      Top             =   5760
      Width           =   195
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
      Left            =   2610
      TabIndex        =   89
      Top             =   450
      Width           =   645
   End
   Begin VB.TextBox txtCotizacionEuro 
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
      Height          =   315
      Left            =   2610
      TabIndex        =   88
      Top             =   765
      Width           =   645
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Height          =   285
      Index           =   5
      Left            =   2385
      Locked          =   -1  'True
      TabIndex        =   86
      Top             =   7245
      Width           =   1410
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Mostrar anticipos al personal"
      Height          =   285
      Index           =   12
      Left            =   90
      TabIndex        =   85
      Top             =   3240
      Visible         =   0   'False
      Width           =   2415
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Asignar rubros contables"
      CausesValidation=   0   'False
      Height          =   420
      Index           =   6
      Left            =   10440
      TabIndex        =   81
      Top             =   3600
      Width           =   1290
   End
   Begin VB.TextBox txtRetencionSUSS 
      Alignment       =   1  'Right Justify
      DataField       =   "RetencionSUSS"
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
      Left            =   10710
      TabIndex        =   76
      Top             =   5715
      Width           =   990
   End
   Begin VB.CommandButton cmd 
      Caption         =   "C"
      CausesValidation=   0   'False
      Height          =   285
      Index           =   11
      Left            =   11700
      TabIndex        =   75
      ToolTipText     =   "Emitir certificado de retencion SUSS"
      Top             =   5715
      Width           =   210
   End
   Begin VB.CommandButton cmd 
      Caption         =   "C"
      CausesValidation=   0   'False
      Height          =   285
      Index           =   10
      Left            =   11700
      TabIndex        =   73
      ToolTipText     =   "Emitir certificado de retencion ingresos brutos"
      Top             =   5400
      Width           =   210
   End
   Begin VB.CommandButton cmd 
      Caption         =   "C"
      CausesValidation=   0   'False
      Height          =   285
      Index           =   9
      Left            =   11700
      TabIndex        =   72
      ToolTipText     =   "Emitir certificado de retencion IVA"
      Top             =   4770
      Width           =   210
   End
   Begin VB.TextBox txtCotizacionMoneda 
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
      Height          =   285
      Left            =   855
      TabIndex        =   69
      Top             =   765
      Width           =   915
   End
   Begin VB.TextBox txtTotalOPComplementariaFF 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0FFC0&
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
      Left            =   10710
      TabIndex        =   65
      Top             =   4455
      Visible         =   0   'False
      Width           =   990
   End
   Begin VB.TextBox txtNumeroOPComplementariaFF 
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
      Height          =   285
      Left            =   10710
      TabIndex        =   64
      Top             =   4140
      Visible         =   0   'False
      Width           =   990
   End
   Begin VB.CheckBox Check4 
      Caption         =   "Check4"
      Height          =   195
      Left            =   6975
      TabIndex        =   59
      Top             =   450
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check3 
      Alignment       =   1  'Right Justify
      Caption         =   "Manual :"
      Height          =   150
      Left            =   10890
      TabIndex        =   56
      Top             =   1125
      Width           =   960
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Incorporar dif."
      Height          =   285
      Index           =   8
      Left            =   1350
      TabIndex        =   55
      Top             =   3825
      Width           =   1155
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Height          =   285
      Index           =   4
      Left            =   4950
      Locked          =   -1  'True
      TabIndex        =   54
      Top             =   3870
      Width           =   1230
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   1
      Left            =   9000
      Picture         =   "frmOrdenesPago.frx":07A3
      Style           =   1  'Graphical
      TabIndex        =   50
      Top             =   3600
      Width           =   615
   End
   Begin VB.CommandButton cmd 
      Caption         =   "C"
      CausesValidation=   0   'False
      Height          =   285
      Index           =   7
      Left            =   11700
      TabIndex        =   49
      ToolTipText     =   "Emitir certificado de retencion ganancias"
      Top             =   5085
      Width           =   210
   End
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Exterior"
      Height          =   195
      Left            =   4770
      TabIndex        =   48
      Top             =   1035
      Width           =   1815
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Calcular dif. cambio :"
      Height          =   195
      Left            =   4770
      TabIndex        =   47
      Top             =   765
      Width           =   1815
   End
   Begin VB.TextBox txtCotizacion 
      Alignment       =   1  'Right Justify
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
      Height          =   285
      Left            =   10980
      TabIndex        =   45
      Top             =   405
      Width           =   900
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Anular"
      CausesValidation=   0   'False
      Height          =   420
      Index           =   5
      Left            =   9675
      TabIndex        =   44
      Top             =   3600
      Width           =   705
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Buscar gastos pendientes"
      Height          =   285
      Index           =   4
      Left            =   90
      TabIndex        =   41
      ToolTipText     =   $"frmOrdenesPago.frx":0D2D
      Top             =   3555
      Visible         =   0   'False
      Width           =   2415
   End
   Begin VB.Frame Frame1 
      Height          =   870
      Left            =   3330
      TabIndex        =   38
      Top             =   405
      Width           =   1320
      Begin VB.OptionButton Option3 
         Caption         =   "Otros"
         Height          =   195
         Left            =   90
         TabIndex        =   42
         Top             =   630
         Width           =   735
      End
      Begin VB.OptionButton Option2 
         Caption         =   "A fondo fijo"
         Height          =   195
         Left            =   90
         TabIndex        =   40
         Top             =   405
         Width           =   1140
      End
      Begin VB.OptionButton Option1 
         Caption         =   "A proveedor"
         Height          =   195
         Left            =   90
         TabIndex        =   39
         Top             =   180
         Width           =   1185
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Calcular asiento contable"
      Height          =   330
      Index           =   3
      Left            =   6435
      TabIndex        =   37
      Top             =   3150
      Width           =   2145
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Buscar en cartera de valores"
      Height          =   285
      Index           =   2
      Left            =   90
      TabIndex        =   36
      Top             =   5490
      Width           =   2235
   End
   Begin VB.TextBox txtNumeroOrdenPago 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroOrdenPago"
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
      Left            =   1350
      TabIndex        =   0
      Top             =   45
      Width           =   1215
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   0
      Left            =   8325
      Picture         =   "frmOrdenesPago.frx":0DBB
      Style           =   1  'Graphical
      TabIndex        =   16
      Top             =   3600
      UseMaskColor    =   -1  'True
      Width           =   615
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   420
      Index           =   1
      Left            =   7380
      TabIndex        =   15
      Top             =   3600
      Width           =   885
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   6435
      TabIndex        =   14
      Top             =   3600
      Width           =   885
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
         LCID            =   1034
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
      Height          =   285
      Index           =   2
      Left            =   10755
      Locked          =   -1  'True
      TabIndex        =   13
      Top             =   3150
      Width           =   960
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Height          =   285
      Index           =   0
      Left            =   4950
      Locked          =   -1  'True
      TabIndex        =   12
      Top             =   3555
      Width           =   1230
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Height          =   285
      Index           =   1
      Left            =   9720
      Locked          =   -1  'True
      TabIndex        =   11
      Top             =   3150
      Width           =   960
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
         LCID            =   1034
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
      Height          =   285
      Index           =   3
      Left            =   7065
      Locked          =   -1  'True
      TabIndex        =   10
      Top             =   5490
      Width           =   1275
   End
   Begin VB.TextBox txtEfectivo 
      Alignment       =   1  'Right Justify
      DataField       =   "Efectivo"
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
      Left            =   3645
      TabIndex        =   9
      Top             =   5490
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.TextBox txtRetIva 
      Alignment       =   1  'Right Justify
      DataField       =   "RetencionIVA"
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
      Left            =   10710
      TabIndex        =   8
      Top             =   4770
      Width           =   990
   End
   Begin VB.TextBox txtRetGan 
      Alignment       =   1  'Right Justify
      DataField       =   "RetencionGanancias"
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
      Left            =   10710
      Locked          =   -1  'True
      TabIndex        =   7
      Top             =   5085
      Width           =   990
   End
   Begin VB.TextBox txtIngBru 
      Alignment       =   1  'Right Justify
      DataField       =   "RetencionIBrutos"
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
      Left            =   10710
      TabIndex        =   6
      Top             =   5400
      Width           =   990
   End
   Begin VB.TextBox txtGasGen 
      Alignment       =   1  'Right Justify
      DataField       =   "GastosGenerales"
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
      Left            =   5265
      TabIndex        =   5
      Top             =   5490
      Visible         =   0   'False
      Width           =   180
   End
   Begin VB.TextBox txtDto 
      Alignment       =   1  'Right Justify
      DataField       =   "Descuentos"
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
      Left            =   10710
      TabIndex        =   4
      Top             =   6030
      Width           =   990
   End
   Begin VB.TextBox txtDif 
      Alignment       =   1  'Right Justify
      DataField       =   "DiferenciaBalanceo"
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
      Height          =   330
      Left            =   10710
      TabIndex        =   3
      Top             =   6435
      Width           =   990
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   17
      Top             =   7875
      Width           =   11925
      _ExtentX        =   21034
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaOrdenPago"
      Height          =   330
      Index           =   0
      Left            =   3375
      TabIndex        =   1
      Top             =   45
      Width           =   1305
      _ExtentX        =   2302
      _ExtentY        =   582
      _Version        =   393216
      Format          =   57081857
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   5670
      TabIndex        =   2
      Top             =   45
      Width           =   4245
      _ExtentX        =   7488
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   2220
      Left            =   45
      TabIndex        =   18
      Top             =   1305
      Width           =   6315
      _ExtentX        =   11139
      _ExtentY        =   3916
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmOrdenesPago.frx":1425
      MultiSelect     =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaCta 
      Height          =   1815
      Left            =   6390
      TabIndex        =   19
      Top             =   1305
      Width           =   5505
      _ExtentX        =   9710
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
      MouseIcon       =   "frmOrdenesPago.frx":1441
      MultiSelect     =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaVal 
      Height          =   1320
      Left            =   45
      TabIndex        =   20
      Top             =   4140
      Width           =   8610
      _ExtentX        =   15187
      _ExtentY        =   2328
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmOrdenesPago.frx":145D
      MultiSelect     =   0   'False
      OLEDropMode     =   1
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   3
      Left            =   855
      TabIndex        =   51
      Tag             =   "Monedas"
      Top             =   450
      Width           =   930
      _ExtentX        =   1640
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
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
   Begin Controles1013.DbListView ListaGastos 
      Height          =   555
      Left            =   8010
      TabIndex        =   98
      Top             =   5490
      Visible         =   0   'False
      Width           =   645
      _ExtentX        =   1138
      _ExtentY        =   979
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmOrdenesPago.frx":1479
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   555
      Left            =   4410
      TabIndex        =   57
      Top             =   7245
      Width           =   7485
      _ExtentX        =   13203
      _ExtentY        =   979
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmOrdenesPago.frx":1495
   End
   Begin MSDataListLib.DataCombo dcfields1 
      DataField       =   "IdCuentaGasto"
      Height          =   315
      Index           =   1
      Left            =   7155
      TabIndex        =   60
      Tag             =   "CuentasGastos"
      Top             =   405
      Visible         =   0   'False
      Width           =   1770
      _ExtentX        =   3122
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaGasto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields1 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   0
      Left            =   5670
      TabIndex        =   61
      Tag             =   "Obras"
      Top             =   405
      Visible         =   0   'False
      Width           =   1275
      _ExtentX        =   2249
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields1 
      Height          =   315
      Index           =   2
      Left            =   8955
      TabIndex        =   62
      Tag             =   "TiposCuentaGrupos"
      Top             =   405
      Visible         =   0   'False
      Width           =   1905
      _ExtentX        =   3360
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoCuentaGrupo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdEmpleadoFF"
      Height          =   315
      Index           =   1
      Left            =   4725
      TabIndex        =   67
      Tag             =   "Empleados"
      Top             =   5490
      Visible         =   0   'False
      Width           =   495
      _ExtentX        =   873
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
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
   Begin MSComctlLib.ImageList Img16 
      Left            =   6255
      Top             =   3600
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
            Picture         =   "frmOrdenesPago.frx":1517
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmOrdenesPago.frx":1629
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmOrdenesPago.frx":1A7B
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmOrdenesPago.frx":1ECD
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView ListaAnticipos 
      Height          =   555
      Left            =   8010
      TabIndex        =   74
      Top             =   6030
      Visible         =   0   'False
      Width           =   645
      _ExtentX        =   1138
      _ExtentY        =   979
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmOrdenesPago.frx":231F
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaImpuestos 
      Height          =   1230
      Left            =   3870
      TabIndex        =   78
      Top             =   5985
      Width           =   4785
      _ExtentX        =   8440
      _ExtentY        =   2170
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmOrdenesPago.frx":233B
      MultiSelect     =   0   'False
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaRubrosContables 
      Height          =   1230
      Left            =   90
      TabIndex        =   82
      Top             =   5985
      Width           =   3750
      _ExtentX        =   6615
      _ExtentY        =   2170
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmOrdenesPago.frx":2357
      MultiSelect     =   0   'False
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProvinciaDestino"
      Height          =   315
      Index           =   5
      Left            =   10215
      TabIndex        =   93
      Tag             =   "Provincias"
      Top             =   765
      Width           =   1680
      _ExtentX        =   2963
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProvincia"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdConcepto"
      Height          =   315
      Index           =   2
      Left            =   9630
      TabIndex        =   101
      Tag             =   "ConceptosOP"
      Top             =   3375
      Visible         =   0   'False
      Width           =   2130
      _ExtentX        =   3757
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdConcepto"
      Text            =   ""
   End
   Begin VB.CommandButton cmdVerOtrasOp 
      Caption         =   "Ver Op's"
      Height          =   285
      Left            =   8010
      TabIndex        =   111
      Top             =   1125
      Visible         =   0   'False
      Width           =   840
   End
   Begin VB.TextBox txtCodigoCuenta 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   300
      Left            =   9675
      TabIndex        =   112
      Top             =   90
      Visible         =   0   'False
      Width           =   780
   End
   Begin VB.Label lblAuxiliares 
      Caption         =   "Auxiliar :"
      Height          =   240
      Index           =   2
      Left            =   8010
      TabIndex        =   117
      Top             =   7875
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Label lblAuxiliares 
      Caption         =   "Enviar a :"
      Height          =   240
      Index           =   1
      Left            =   4005
      TabIndex        =   115
      Top             =   7875
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Label lblAuxiliares 
      Caption         =   "Modalidad :"
      Height          =   240
      Index           =   0
      Left            =   135
      TabIndex        =   113
      Top             =   7875
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Label lblTipoOperacion 
      Caption         =   "Tipo ope. :"
      Height          =   240
      Left            =   3915
      TabIndex        =   79
      Top             =   7560
      Visible         =   0   'False
      Width           =   795
   End
   Begin VB.Label Label6 
      Caption         =   "Detalle : "
      Height          =   195
      Left            =   3195
      TabIndex        =   106
      Top             =   5715
      Visible         =   0   'False
      Width           =   675
   End
   Begin VB.Label Label5 
      Caption         =   "Clasificacion :"
      Height          =   240
      Left            =   9765
      TabIndex        =   104
      Top             =   7245
      Visible         =   0   'False
      Width           =   1155
   End
   Begin VB.Label Label4 
      Caption         =   "Concepto :"
      Height          =   285
      Left            =   8775
      TabIndex        =   102
      Top             =   3420
      Visible         =   0   'False
      Width           =   795
   End
   Begin VB.Label lblNumeroRendicionFF 
      Caption         =   "Nro. Rend.FF :"
      Height          =   240
      Left            =   8685
      TabIndex        =   99
      Top             =   1170
      Visible         =   0   'False
      Width           =   1035
   End
   Begin VB.Label Label3 
      Caption         =   "Prov.dest.:"
      Height          =   240
      Left            =   9360
      TabIndex        =   92
      Top             =   810
      Width           =   795
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cot.U$S :"
      Height          =   240
      Index           =   18
      Left            =   1845
      TabIndex        =   91
      Top             =   495
      Width           =   705
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cot.Euro :"
      Height          =   240
      Index           =   24
      Left            =   1845
      TabIndex        =   90
      Top             =   810
      Width           =   705
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      Caption         =   "Total asignaciones :"
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
      Index           =   15
      Left            =   135
      TabIndex        =   87
      Top             =   7245
      Width           =   2175
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Asignacion por rubros contables :"
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
      Index           =   14
      Left            =   135
      TabIndex        =   84
      Top             =   5805
      Width           =   2865
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Detalle impuestos calculados :"
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
      Index           =   13
      Left            =   3915
      TabIndex        =   83
      Top             =   5805
      Width           =   2610
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Retencion SUSS :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   10
      Left            =   8730
      TabIndex        =   77
      Top             =   5760
      Width           =   1710
   End
   Begin VB.Label Label2 
      Height          =   195
      Left            =   2655
      TabIndex        =   71
      Top             =   5535
      Visible         =   0   'False
      Width           =   945
   End
   Begin VB.Label lblLabels 
      Caption         =   "Conv.a $:"
      Height          =   195
      Index           =   2
      Left            =   90
      TabIndex        =   70
      Top             =   810
      Width           =   705
   End
   Begin VB.Label Label1 
      Height          =   195
      Left            =   2385
      TabIndex        =   68
      Top             =   5535
      Visible         =   0   'False
      Width           =   180
   End
   Begin VB.Label lblOPComplementaria 
      BackColor       =   &H00C0FFC0&
      Caption         =   "Total O.P. complem. :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   1
      Left            =   8730
      TabIndex        =   66
      Top             =   4500
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Label lblObra 
      Caption         =   "Obra/Gr."
      Height          =   240
      Left            =   4770
      TabIndex        =   63
      Top             =   450
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Obs.:"
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
      Index           =   17
      Left            =   3915
      TabIndex        =   58
      Top             =   7290
      Width           =   465
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Diferencia :"
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
      Index           =   12
      Left            =   8730
      TabIndex        =   21
      Top             =   6480
      Width           =   1935
   End
   Begin VB.Label lblRetencion 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Dif. cambio calculada :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   1
      Left            =   2700
      TabIndex        =   53
      Top             =   3870
      Width           =   2100
   End
   Begin VB.Label lblLabels 
      Caption         =   "Moneda :"
      Height          =   240
      Index           =   23
      Left            =   90
      TabIndex        =   52
      Top             =   495
      Width           =   720
   End
   Begin VB.Line Line4 
      BorderWidth     =   2
      X1              =   10935
      X2              =   10935
      Y1              =   -45
      Y2              =   720
   End
   Begin VB.Label lblLabels 
      Alignment       =   2  'Center
      Caption         =   "Cotizacion u$s del dia"
      Height          =   375
      Index           =   16
      Left            =   10980
      TabIndex        =   46
      Top             =   0
      Width           =   915
   End
   Begin VB.Line Line3 
      BorderWidth     =   2
      X1              =   11880
      X2              =   10935
      Y1              =   720
      Y2              =   720
   End
   Begin VB.Label lblEstado 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   8730
      TabIndex        =   43
      Top             =   6840
      Visible         =   0   'False
      Width           =   1905
   End
   Begin VB.Label lblDestino 
      Caption         =   "Proveedor :"
      Height          =   240
      Left            =   4770
      TabIndex        =   35
      Top             =   90
      Width           =   855
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   22
      Left            =   2655
      TabIndex        =   34
      Top             =   90
      Width           =   675
   End
   Begin VB.Label lblLabels 
      Caption         =   "O.Pago numero:"
      Height          =   240
      Index           =   21
      Left            =   90
      TabIndex        =   33
      Top             =   90
      Width           =   1215
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Valores :"
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
      TabIndex        =   32
      Top             =   3915
      Width           =   765
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle de imputaciones :"
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
      Index           =   1
      Left            =   90
      TabIndex        =   31
      Top             =   1125
      Width           =   2175
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Registro contable :"
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
      Index           =   3
      Left            =   6660
      TabIndex        =   30
      Top             =   1125
      Width           =   1635
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      Caption         =   "Total valores :"
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
      Index           =   4
      Left            =   5490
      TabIndex        =   29
      Top             =   5490
      Width           =   1515
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      Caption         =   "Totales :"
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
      Left            =   8685
      TabIndex        =   28
      Top             =   3150
      Width           =   930
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      Caption         =   "Total imputaciones :"
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
      Index           =   6
      Left            =   2700
      TabIndex        =   27
      Top             =   3555
      Width           =   2115
   End
   Begin VB.Label lblOPComplementaria 
      BackColor       =   &H00C0FFC0&
      Caption         =   "O.P. complementaria :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   0
      Left            =   8730
      TabIndex        =   26
      Top             =   4185
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Retencion IVA :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   7
      Left            =   8730
      TabIndex        =   25
      Top             =   4815
      Width           =   1935
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Retencion ganancias :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   8
      Left            =   8730
      TabIndex        =   24
      Top             =   5130
      Width           =   1935
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Retencion ing. brutos :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   9
      Left            =   8730
      TabIndex        =   23
      Top             =   5445
      Width           =   1935
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Descuentos :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   11
      Left            =   8730
      TabIndex        =   22
      Top             =   6075
      Width           =   1935
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000009&
      BorderWidth     =   2
      X1              =   8730
      X2              =   11700
      Y1              =   6390
      Y2              =   6390
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar imputacion"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Modificar imputacion"
         Index           =   1
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar imputacion"
         Index           =   2
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Modificar importe"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Aplicacion automatica"
         Index           =   4
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar anticipo"
         Index           =   5
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Visualizar comprobante"
         Index           =   6
      End
   End
   Begin VB.Menu MnuDetVal 
      Caption         =   "DetalleVal"
      Visible         =   0   'False
      Begin VB.Menu MnuDetB 
         Caption         =   "Agregar caja"
         Index           =   0
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Agregar valor"
         Index           =   1
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Modificar valor"
         Index           =   2
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Eliminar valor"
         Index           =   3
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Anular valor"
         Index           =   4
      End
   End
   Begin VB.Menu MnuDetCta 
      Caption         =   "DetalleCta"
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
   Begin VB.Menu MnuDetAnticipo 
      Caption         =   "DetalleAnticipo"
      Visible         =   0   'False
      Begin VB.Menu MnuDetD 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetD 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetD 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
   Begin VB.Menu MnuDetRubroContable 
      Caption         =   "DetalleRubroContable"
      Visible         =   0   'False
      Begin VB.Menu MnuDetE 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetE 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetE 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
   Begin VB.Menu MnuDetGastos 
      Caption         =   "DetalleGastos"
      Visible         =   0   'False
      Begin VB.Menu MnuDetG 
         Caption         =   "Marcar registros seleccionados"
         Index           =   0
      End
      Begin VB.Menu MnuDetG 
         Caption         =   "Desmarcar registros seleccionados"
         Index           =   1
      End
   End
End
Attribute VB_Name = "frmOrdenesPago"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.OrdenPago
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim WithEvents ActL3 As ControlForm
Attribute ActL3.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private oF_BuscarPorCuit As frm_Aux
Private cALetra As New clsNum2Let
Private mvarId As Long, mvarIdProveedor As Long, mIGCondicionExcepcion As Long
Private mvarTipoIVA As Integer, mvarIdTipoCuentaGrupoAnticiposAlPersonal As Integer, mvarIdTipoComprobanteNDInternaAcreedores As Integer
Private mvarIdTipoComprobanteNCInternaAcreedores As Integer, mvarCodigoSituacionRetencionIVA As Integer
Private mvarIdImpuestoDirectoSUSS As Integer, mvarIdMonedaPesos As Integer, mvarIdMonedaDolar As Integer, mvarIdMonedaEuro As Integer
Private mvarTotalImputaciones As Double, mvarTotalDebe As Double, mvarTotalHaber As Double, mvarTotalValores As Double
Private mvarTotalGastos As Double, mvarCotizacion As Double, mvarCotizacionEuro As Double, mvarTotalPagoSinRetencion As Double
Private mvarTotalBaseGanancias As Double, mvarDiferenciaBalanceo As Double, mvarExceptuadoRetencionIVA As Double
Private mvarImporteTotalMinimoAplicacionRetencionIVA As Double, mvarImporteMinimoRetencionIVA As Double, mvarTopeAnualSUSS As Double
Private mvarTotalAnticipos As Double, mvarImporteMinimoRetencionIVAServicios As Double, mvarBaseCalculoSUSS As Double
Private mvarTotalRubrosContables As Double, mvarImporteComprobantesMParaRetencionIVA As Double
Private mvarImporteMinimoBaseRetencionSUSS As Double, mvarTopeMinimoRetencionIVA As Double, mvarTopeMinimoRetencionIVAServicios As Double
Private mvarPorcentajeBaseRetencionIVABienes As Single, mvarPorcentajeBaseRetencionIVAServicios As Single
Private mvarPorcentajeRetencionSUSS As Single, mvarPorcentajeRetencionSUSS1 As Single, mvarPorcentajeRetencionIVAComprobantesM As Single
Private mvarPorcentajeRetencionIVAMonotributistas As Single
Private mControlLoop As Boolean, mvarGrabado As Boolean, mvarRetenerGanancias As Boolean, mvarAnuloValor As Boolean
Private mvarOP_AnticiposAlPersonal As Boolean, mvarRetenerIIBB As Boolean, mvarControlCheck As Boolean, mvarPrimeraVez As Boolean
Private mvarControlarCircuitoFirmasEnOP As Boolean
Private mvarAgenteRetencionIVA As String, mvarAgenteRetencionSUSS As String, mvarAnulada As String, mvarRetenerSUSSAProveedor As String
Private mPrinterSeleccionada As String, mvarControlarRubrosContablesEnOP As String, mvarAgenteRetencionIIBB As String
Private mRegimenEspecialConstruccionIIBB As String, mRendicionesFF As String
Private mvarSUSSFechaCaducidadExencion As Date
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

Private Sub Editar(ByVal Cual As Long)

'   If mvarId > 0 Then
'      MsgBox "No puede modificar una Orden de Pago ya registrada!", vbCritical
'      Exit Sub
'   End If
   
   If Not IsNumeric(dcfields(0).BoundText) Then
      MsgBox "Falta completar el campo Proveedor", vbCritical
      Exit Sub
   End If
   
   If Len(Trim(txtNumeroOrdenPago.Text)) = 0 Then
      MsgBox "Falta completar el campo numero de OrdenPago", vbCritical
      Exit Sub
   End If
   
   Dim oF As frmImputaciones
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim mSaldo As Double
   Dim mIdComprobanteProveedor As Long
   Dim mError As String
   Dim Esta As Boolean
   
   Set oF = New frmImputaciones
   With oF
      .TipoCuenta = "Acreedores"
      If origen.Registro.Fields("IdMoneda").Value = mvarIdMonedaDolar Then
         .Moneda = "Dolares"
      ElseIf origen.Registro.Fields("IdMoneda").Value = mvarIdMonedaEuro Then
         .Moneda = "Euros"
      Else
         .Moneda = "Pesos"
      End If
      .Id = dcfields(0).BoundText
      .Show vbModal, Me
   End With
   
   mError = ""
   For Each oL In oF.Lista.ListItems
      If oL.ListSubItems(7) = "*" Then
         Set oRs = origen.DetOrdenesPago.TodosLosRegistros
         Esta = False
         If oRs.Fields.Count > 0 Then
            If oRs.RecordCount > 0 Then
               oRs.MoveFirst
               Do While Not oRs.EOF
                  If oRs.Fields("IdImputacion").Value = oL.Tag Then
                     Esta = True
                     Exit Do
                  End If
                  oRs.MoveNext
               Loop
            End If
            oRs.Close
         End If
         Set oRs = Nothing
         If Not Esta Then
            mSaldo = oL.ListSubItems(6)
            If mvarControlarCircuitoFirmasEnOP Then
               Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_DatosDeLaImputacion", oL.Tag)
               If oRs.RecordCount > 0 Then
                  If IIf(IsNull(oRs.Fields("CircuitoFirmasCompleto").Value), "", oRs.Fields("CircuitoFirmasCompleto").Value) <> "SI" Then
                     mError = mError & vbCrLf & "El comprobante " & oRs.Fields("NumeroReferencia").Value & " del " & _
                                    oRs.Fields("FechaComprobante").Value & " no tiene completo el circuito de firmas y no fue tomado."
                     oRs.Close
                     GoTo Proximo
                  End If
               End If
               oRs.Close
            End If
            If dcfields(3).BoundText <> mvarIdMonedaPesos And dcfields(3).BoundText <> mvarIdMonedaDolar And _
                  dcfields(3).BoundText <> mvarIdMonedaEuro Then
               mIdComprobanteProveedor = 0
               Set oRs = Aplicacion.CtasCtesA.TraerFiltrado("_Imputacion", oL.Tag)
               If oRs.RecordCount > 0 Then
                  mSaldo = IIf(IsNull(oRs.Fields("Saldo").Value), 0, oRs.Fields("Saldo").Value)
                  mIdComprobanteProveedor = oRs.Fields("IdComprobante").Value
               End If
               oRs.Close
               Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorId", mIdComprobanteProveedor)
               If oRs.RecordCount > 0 Then
                  If oRs.Fields("IdMoneda").Value = dcfields(3).BoundText Then
                     mSaldo = Round(mSaldo / IIf(IsNull(oRs.Fields("CotizacionMoneda").Value), 1, oRs.Fields("CotizacionMoneda").Value), 2)
                  End If
               End If
               oRs.Close
            End If
            With origen.DetOrdenesPago.Item(-1)
               .Registro.Fields("IdImputacion").Value = oL.Tag
               .Registro.Fields("Importe").Value = mSaldo
               .Modificado = True
            End With
         End If
      End If
Proximo:
   Next
   
   If Len(mError) > 0 Then MsgBox "Se registraron los siguientes errores : " & mError, vbExclamation
   
   Set Lista.DataSource = origen.DetOrdenesPago.RegistrosConFormato
   DoEvents
   
   Unload oF
   Set oF = Nothing
   
   Set oRs = Nothing
   
   On Error GoTo Salida:
   
   CalcularRetencionGanancias
   CalcularRetencionIVA
   CalcularRetencionIngresosBrutos
   CalcularRetencionSUSS
   CalculaTotales
   MostrarDiferenciaCambio
Salida:

End Sub

Private Sub ImputacionAutomatica()

'   If mvarId > 0 Then
'      MsgBox "No puede modificar una Orden de Pago ya registrada!", vbCritical
'      Exit Sub
'   End If
   
   If Len(Trim(dcfields(0).BoundText)) = 0 Then
      MsgBox "Falta completar el campo Proveedor", vbCritical
      Exit Sub
   End If
   
   If Len(Trim(txtNumeroOrdenPago.Text)) = 0 Then
      MsgBox "Falta completar el campo numero de Orden de Pago", vbCritical
      Exit Sub
   End If
   
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim mvarDif As Double
   Dim oL As ListItem
   Dim Esta As Boolean
   
   mvarDif = Val(txtDif.Text) * -1
   
   Set oRs = Aplicacion.CtasCtesA.TraerFiltrado("_ACancelar", dcfields(0).BoundText)
   Set oRs1 = origen.DetOrdenesPago.TodosLosRegistros
   
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF And mvarDif > 0
            Esta = False
            If oRs1.Fields.Count > 0 Then
               If oRs1.RecordCount > 0 Then
                  oRs1.MoveFirst
                  Do While Not oRs1.EOF
                     If oRs.Fields(0).Value = oRs1.Fields("IdImputacion").Value Then
                        Esta = True
                        Exit Do
                     End If
                     oRs1.MoveNext
                  Loop
               End If
            End If
            If Not Esta Then
               With origen.DetOrdenesPago.Item(-1)
                  .Registro.Fields("IdImputacion").Value = oRs.Fields(0).Value
                  If mvarDif >= oRs.Fields("Saldo").Value Then
                     mvarDif = mvarDif - oRs.Fields("Saldo").Value
                     .Registro.Fields("Importe").Value = oRs.Fields("Saldo").Value
                  Else
                     .Registro.Fields("Importe").Value = mvarDif
                     mvarDif = 0
                  End If
                  .Modificado = True
               End With
            End If
            oRs.MoveNext
         Loop
      End If
      oRs.Close
   End If
   Set oRs = Nothing
            
   If oRs1.Fields.Count > 0 Then oRs1.Close
   Set oRs1 = Nothing
   
   If mvarDif > 0 Then
      With origen.DetOrdenesPago.Item(-1)
         .Registro.Fields("IdImputacion").Value = -1
         .Registro.Fields("Importe").Value = mvarDif
         mvarDif = 0
         .Modificado = True
      End With
   End If

   Set Lista.DataSource = origen.DetOrdenesPago.RegistrosConFormato
   
   CalcularRetencionGanancias
   CalcularRetencionIVA
   CalcularRetencionIngresosBrutos
   CalcularRetencionSUSS
   CalculaTotales
   MostrarDiferenciaCambio

End Sub

Private Sub PagoAnticipado()

'   If mvarId > 0 Then
'      MsgBox "No puede modificar una Orden de Pago ya registrada!", vbCritical
'      Exit Sub
'   End If
   
   If Len(Trim(dcfields(0).BoundText)) = 0 Then
      MsgBox "Falta completar el campo Proveedor", vbCritical
      Exit Sub
   End If
   
   If Len(Trim(txtNumeroOrdenPago.Text)) = 0 Then
      MsgBox "Falta completar el campo numero de Orden de Pago", vbCritical
      Exit Sub
   End If
   
   Dim mvarDif As Double
   
   mvarDif = Val(txtDif.Text) * -1
   If mvarDif <= 0 Then mvarDif = 0

'   If mvarDif <= 0 Then
'      Exit Sub
'   End If
      
   Dim oF As frmDetOrdenesPagoPA
   Dim mOk As Boolean
   Set oF = New frmDetOrdenesPagoPA
   With oF
      .IdProveedor = dcfields(0).BoundText
      .RetenerGanancias = mvarRetenerGanancias
      .RetenerIIBB = mvarRetenerIIBB
      .Anticipo = mvarDif
      .Show vbModal, Me
      mOk = .Aceptado
      If .Aceptado Then
         With origen.DetOrdenesPago.Item(-1)
            .Registro.Fields("IdImputacion").Value = -1
            .Registro.Fields("Importe").Value = Val(oF.txtAnticipo.Text)
            .Registro.Fields("ImportePagadoSinImpuestos").Value = Val(oF.txtAnticipoSinImpuestos.Text)
            If IsNumeric(oF.dcfields(0).BoundText) Then
               .Registro.Fields("IdTipoRetencionGanancia").Value = oF.dcfields(0).BoundText
            End If
            If IsNumeric(oF.dcfields(1).BoundText) Then
               .Registro.Fields("IdIBCondicion").Value = oF.dcfields(1).BoundText
            End If
            mvarDif = 0
            .Modificado = True
         End With
      End If
   End With
   Unload oF
   Set oF = Nothing
   
   If Not mOk Then Exit Sub

   Set Lista.DataSource = origen.DetOrdenesPago.RegistrosConFormato
   
   CalcularRetencionGanancias
   CalcularRetencionIVA
   CalcularRetencionIngresosBrutos
   CalcularRetencionSUSS
   CalculaTotales

End Sub

Sub EditarImporte(ByVal Cual As Long)

'   If mvarId > 0 Then
'      MsgBox "No puede modificar una Orden de Pago ya registrada!", vbCritical
'      Exit Sub
'   End If
   
   Dim oF As frmDetOrdenesPago
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim mImportePagadoSinImpuestos As Double
   Dim mOk As Boolean
   
   Set oF = New frmDetOrdenesPago
   
   With oF
      .TipoComprobante = Lista.SelectedItem.Text
'      .ACancelar = Origen.DetOrdenesPago.Item(Cual).Registro.Fields("Importe").Value
      .ACancelar = Lista.SelectedItem.ListSubItems(5)
      If Lista.SelectedItem.Text <> "PA" Then
         .Saldo = IIf(Len(Trim(Lista.SelectedItem.ListSubItems(4))) = 0, 0, Lista.SelectedItem.ListSubItems(4))
      Else
         .Saldo = 0
         .AnticipoSinImpuestos = Lista.SelectedItem.ListSubItems(6)
      End If
      If Cual > 0 Then
         .Cancelado = Lista.SelectedItem.ListSubItems(5)
      Else
         .Cancelado = 0
      End If
      .Show vbModal, Me
      mOk = .Aceptado
   End With
   
   If Not mOk Then Exit Sub
   
   With origen.DetOrdenesPago.Item(Cual)
      .Registro.Fields("Importe").Value = Val(oF.txtACancelar.Text)
      If oF.TipoComprobante <> "PA" Then
         .Registro.Fields("ImportePagadoSinImpuestos").Value = Val(oF.txtACancelar.Text)
      Else
         .Registro.Fields("ImportePagadoSinImpuestos").Value = Val(oF.txtAnticipoSinImpuestos.Text)
      End If
      .Modificado = True
'      mImportePagadoSinImpuestos = Val(of.txtACancelar.Text)
'      If Not IsNull(.Registro.Fields("IdImputacion").Value) And .Registro.Fields("IdImputacion").Value > 0 Then
'         Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_DatosDeLaImputacion", .Registro.Fields("IdImputacion").Value)
'         If oRs.RecordCount > 0 Then
'            If Not IsNull(oRs.Fields("TotalBruto").Value) Then
'               mImportePagadoSinImpuestos = Round((Abs(Val(of.txtACancelar.Text)) * oRs.Fields("TotalBruto").Value) / _
'                     oRs.Fields("ImporteTotal").Value, 2)
'               .Registro.Fields("ImportePagadoSinImpuestos").Value = mImportePagadoSinImpuestos
'               Lista.SelectedItem.ListSubItems(6) = mImportePagadoSinImpuestos
'            End If
'         End If
'         oRs.Close
'         Set oRs = Nothing
'      End If
   End With
   
   Set Lista.DataSource = origen.DetOrdenesPago.RegistrosConFormato
   
'   Lista.SelectedItem.ListSubItems(5) = Format(Val(of.txtACancelar.Text), "Fixed")
'   If of.TipoComprobante <> "PA" Then
'      Lista.SelectedItem.ListSubItems(6) = Format(mImportePagadoSinImpuestos, "Fixed")
'   Else
'      Lista.SelectedItem.ListSubItems(6) = Format(Val(of.txtAnticipoSinImpuestos.Text), "Fixed")
'   End If
   
   Unload oF
   Set oF = Nothing
   
   CalcularRetencionGanancias
   CalcularRetencionIVA
   CalcularRetencionIngresosBrutos
   CalcularRetencionSUSS
   CalculaTotales
   MostrarDiferenciaCambio

End Sub

Sub EditarVal(ByVal Cual As Long)

'   If mvarId > 0 Then
'      MsgBox "No puede modificar una Orden de Pago ya registrada!", vbCritical
'      Exit Sub
'   End If
   
   If Option1.Value And IsNull(origen.Registro.Fields("IdProveedor").Value) Then
      MsgBox "Antes de ingresar un valor, indique el proveedor", vbCritical
      Exit Sub
   End If
   
   Dim oF As Form
   Dim oL As ListItem
   Dim oDet As DetOrdenPagoValores
   Dim mItem As String
   Dim mIdItem As Long
   
   mIdItem = Cual
   
   If Cual = -1 Then
      mItem = "Caja"
   ElseIf Cual = -2 Then
      mItem = "Valor"
      mIdItem = -1
   Else
      Set oDet = origen.DetOrdenesPagoValores.Item(Cual)
      If Not IsNull(oDet.Registro.Fields("IdCaja").Value) Then
         mItem = "Caja"
      Else
         mItem = "Valor"
         If Not IsNull(oDet.Registro.Fields("Anulado").Value) And oDet.Registro.Fields("Anulado").Value = "SI" Then
            Set oDet = Nothing
            MsgBox "El valor esta anulado, no puede modificarlo", vbCritical
            Exit Sub
         End If
         If oDet.ChequeDiferidoCaido Then
            Set oDet = Nothing
            MsgBox "No puede modificar el valor porque ya fue hecho el" & vbCrLf & _
                  "asiento de ajuste a bancos", vbCritical
            Exit Sub
         End If
      End If
      Set oDet = Nothing
   End If
   
   If mItem = "Valor" Then
      Set oF = New frmDetOrdenesPagoValores
      oF.Exterior = (Check2.Value = 1)
   Else
      Set oF = New frmDetOrdenesPagoCaja
   End If
   
   With oF
      Set .OrdenPago = origen
      If mIdItem < 0 Then .ImporteDefault = Val(txtDif.Text)
      .FechaOP = DTFields(0).Value
      .Id = mIdItem
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Or Cual = -2 Then
            Set oL = ListaVal.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaVal.SelectedItem
         End If
         With oL
            If Cual = -1 Or Cual = -2 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            If mItem = "Valor" Then
               .Text = oF.DataCombo1(0).Text
               .SubItems(1) = "" & .Tag
               .SubItems(2) = "" & oF.txtNumeroInterno
               .SubItems(3) = "" & oF.txtNumeroValor
               .SubItems(4) = "" & oF.DTFields(0).Value
               If IsNumeric(oF.DataCombo1(3).BoundText) Then
                  .SubItems(5) = "" & oF.DataCombo1(3).Text
               Else
                  .SubItems(5) = "" & oF.DataCombo1(1).Text
               End If
            Else
               .Text = "Caja"
               .SubItems(5) = "" & oF.DataCombo1(1).Text
            End If
            If Val(oF.txtImporte.Text) = 0 Then
               .SubItems(6) = " "
            Else
               .SubItems(6) = "" & Format(oF.txtImporte.Text, "#,##0.00")
            End If
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
   CalculaTotales
   
   If mvarId > 0 And Option3.Value Then
      MsgBox "Recuerde que al modificar algun dato de una op de otros" & vbCrLf & _
               "debe hacer los ajustes manualmente o recalcular el registro" & vbCrLf & _
               "contable segun tenga o no el tilde en manual y si los cambios" & vbCrLf & _
               "afectan dicho registro contable.", vbInformation
   End If
   
'   ActualizaListaContable
   
End Sub

Sub EditarCta(ByVal Cual As Long)

'   If mvarId > 0 Then
'      MsgBox "No puede modificar una Orden de Pago ya registrada!", vbCritical
'      Exit Sub
'   End If
   
   If Not IsNumeric(dcfields(3).BoundText) Then
      MsgBox "Debe primero definir la moneda", vbCritical
      Exit Sub
   End If
   
   Dim oF As frmDetOrdenesPagoCuentas
   Dim oL As ListItem
   
   Set oF = New frmDetOrdenesPagoCuentas
   
   With oF
      Set .OrdenPago = origen
      .IdMoneda = dcfields(3).BoundText
      .FechaOrdenPago = DTFields(0).Value
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaCta.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaCta.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtCodigoCuenta
            .SubItems(1) = "" & oF.DataCombo1(0).Text
            If Val(oF.txtDebe.Text) = 0 Then
               .SubItems(2) = " "
            Else
               .SubItems(2) = "" & Format(oF.txtDebe.Text, "Fixed")
            End If
            If Val(oF.txtHaber.Text) = 0 Then
               .SubItems(3) = " "
            Else
               .SubItems(3) = "" & Format(oF.txtHaber.Text, "Fixed")
            End If
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
   CalculaTotales
'   ActualizaListaContable
   
End Sub

Public Sub EditarAnticipo(ByVal Cual As Long)

   Dim oF As frmDetOrdenesPagoAnticipo
   Dim oL As ListItem
   
   Set oF = New frmDetOrdenesPagoAnticipo
   
   With oF
      Set .OrdenPago = origen
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaAnticipos.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaAnticipos.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtLegajo.Text
            .SubItems(1) = "" & oF.DataCombo1(1).Text
            .SubItems(2) = "" & Format(oF.txtImporte.Text, "Fixed")
            .SubItems(3) = "" & Format(oF.txtCuotas.Text, "Fixed")
            .SubItems(4) = "" & oF.txtDetalle.Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
   CalculaTotales

End Sub

Public Sub EditarRubroContable(ByVal Cual As Long)

   Dim oF As frmDetOrdenesPagoRubrosContables
   Dim oL As ListItem
   
   Set oF = New frmDetOrdenesPagoRubrosContables
   With oF
      Set .OrdenPago = origen
      If IsNumeric(dcfields1(0).BoundText) Then .IdObra = dcfields1(0).BoundText
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaRubrosContables.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaRubrosContables.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.DataCombo1(1).Text
            .SubItems(1) = "" & Format(oF.txtImporte.Text, "Fixed")
         End With
      End If
   End With
   Unload oF
   Set oF = Nothing
   
   CalculaTotales
   
End Sub

Private Sub ActL3_ActLista(ByVal IdRegistro As Long, ByVal TipoAccion As EnumAcciones, ByVal NombreListaEditada As String, ByVal mvarIdRegistroOriginal As Long)

   dcfields(0).BoundText = IdRegistro

End Sub

Private Sub Check1_Click()

   MostrarDiferenciaCambio

End Sub

Private Sub Check2_Click()

   If mvarId = -1 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Parametros.Item(1).Registro
      With origen.Registro
         If Check2.Value = 0 Then
            If Option3.Value Then
               .Fields("NumeroOrdenPago").Value = oRs.Fields("ProximaOrdenPagoOtros").Value
            Else
               If TraerValorParametro2("NumeracionIndependienteDeOrdenesDePagoFFyCTACTE") = "SI" Then
                  .Fields("NumeroOrdenPago").Value = oRs.Fields("ProximaOrdenPagoFF").Value
               Else
                  .Fields("NumeroOrdenPago").Value = oRs.Fields("ProximaOrdenPago").Value
               End If
            End If
'            cmd(6).Visible = True
            cmd(7).Visible = True
            cmd(9).Visible = True
'            lblRetencion(0).Visible = True
'            txtBaseGanancias.Visible = True
         Else
            .Fields("NumeroOrdenPago").Value = oRs.Fields("ProximaOrdenPagoExterior").Value
            .Fields("BaseGanancias").Value = Null
            .Fields("RetencionGanancias").Value = 0
'            cmd(6).Visible = False
            cmd(7).Visible = False
            cmd(9).Visible = False
'            lblRetencion(0).Visible = False
'            txtBaseGanancias.Visible = False
         End If
      End With
      oRs.Close
      Set oRs = Nothing
      CalcularRetencionGanancias
      CalculaTotales
   End If

End Sub

Private Sub Check3_Click()

   With origen.Registro
      If Check3.Value = 1 Then
         .Fields("AsientoManual").Value = "SI"
      Else
         .Fields("AsientoManual").Value = "NO"
      End If
   End With

End Sub

Private Sub Check4_Click()

   If Check4.Value = 0 Then
      Dim mIdCuenta As Long
      origen.Registro.Fields(dcfields1(1).DataField).Value = Null
      mIdCuenta = 0
      With dcfields(0)
         If IsNumeric(.BoundText) Then mIdCuenta = .BoundText
         Set .RowSource = Aplicacion.Cuentas.TraerLista
         origen.Registro.Fields(.DataField).Value = mIdCuenta
         .Enabled = True
      End With
      With dcfields1(2)
         .BoundText = 0
         .Enabled = True
      End With
   End If
   
End Sub

Private Sub Check5_Click()

   CalcularRetencionSUSS
   CalculaTotales
   
End Sub

Private Sub Check6_Click()

   If Check6.Value = 1 Then
      Check6.Enabled = False
      CalcularRetencionGanancias
      CalcularRetencionIVA
      CalcularRetencionIngresosBrutos
      CalcularRetencionSUSS
      CalculaTotales
      MostrarDiferenciaCambio
   End If

End Sub

Private Sub Check7_Click()

   If Check7.Value = 1 Then CalculaTotales

End Sub

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal1
   
   Select Case Index
      Case 0
         If DTFields(0).Value <= gblFechaUltimoCierre And _
               Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
            MsgBox "La fecha no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation
            Exit Sub
         End If

         If Option3.Value And Not Option4.Value And Not Option5.Value Then
            MsgBox "Debe indicar el tipo de operacion", vbInformation
            Exit Sub
         End If
         
         Dim oRs As ADOR.Recordset
         Dim oRsAux As ADOR.Recordset
         Dim mTipo As String, mOrdenPagoExterior As String, mAux1 As String
         Dim mvarSeguro As Integer, mAux2 As Integer
         
         If Len(txtNumeroOrdenPago.Text) = 0 Or Not IsNumeric(txtNumeroOrdenPago.Text) Then
            MsgBox "Debe ingresar el numero de orden de pago", vbInformation
            Exit Sub
         End If
         
         If Val(txtDif.Text) <> 0 And _
               Not (Option2.Value And ItemsDeGastosMarcados = 0) And _
               Not (Option3.Value And ListaAnticipos.ListItems.Count = 0) Then
            MsgBox "La Orden de Pago no cierra, ajuste los valores e intente nuevamente", vbCritical
            Exit Sub
         End If
         
         If Len(txtCotizacionMoneda.Text) = 0 Then
            MsgBox "No ingreso la conversion a pesos", vbInformation
            Exit Sub
         End If
         
         If Len(txtCotizacionDolar.Text) = 0 Then
            MsgBox "No ingreso la cotizacion dolar", vbInformation
            Exit Sub
         End If
         
         If Len(txtCotizacionEuro.Text) = 0 Then
            MsgBox "No ingreso la cotizacion euro", vbInformation
            Exit Sub
         End If
         
         If mvarCotizacion = 0 Then
            MsgBox "No hay cotizacion dolar al " & DTFields(0).Value, vbInformation
            Exit Sub
         End If
         
         If Not CambioDeMonedaValido(dcfields(3).BoundText) Then
            MsgBox "Existen valores con moneda diferente a la de la orden de pago, revise los datos"
            Exit Sub
         End If
         
         If Option1.Value Then
            mTipo = "CC"
            If mvarCodigoSituacionRetencionIVA = 3 And mvarTipoIVA = 1 Then
               MsgBox "El codigo de situacion del proveedor para retencion IVA es 3," & vbCrLf & _
                      "en consecuencia no puede ser registrado este comprobante", vbExclamation
               Exit Sub
            End If
            If EstadoEntidad("Proveedores", origen.Registro.Fields("IdProveedor").Value) = "INACTIVO" Then
               MsgBox "Proveedor inhabilitado", vbExclamation
               Exit Sub
            End If
         ElseIf Option2.Value Then
            mTipo = "FF"
         ElseIf Option3.Value Then
            mTipo = "OT"
         Else
            mTipo = ""
         End If
         If Check2.Value = 1 Then
            mOrdenPagoExterior = "SI"
         Else
            mOrdenPagoExterior = "NO"
         End If
         
         If mTipo <> "CC" And Len(rchObservaciones.Text) < 2 Then
            MsgBox "Cuando se ingresa una OP de fondo fijo u otros es necesaria detallar una observacion", vbInformation
            Exit Sub
         End If
         
         If mTipo = "CC" Then
            Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", origen.Registro.Fields("IdProveedor").Value)
            If oRs.RecordCount > 0 Then
               If IIf(IsNull(oRs.Fields("SujetoEmbargado").Value), "NO", oRs.Fields("SujetoEmbargado").Value) = "SI" Then
                  MsgBox "Proveedor embargado, revise su situacion en el maestro y proceda en consecuencia", vbCritical
               End If
            End If
            oRs.Close
         End If
         
         If mvarId > 0 Then
            Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_ValidarNumero", Array(origen.Registro.Fields("NumeroOrdenPago").Value, mvarId, mTipo, mOrdenPagoExterior))
            If oRs.RecordCount > 0 Then
               MsgBox "El numero de orden de pago ya fue utilizado por una OP del dia " & _
                     oRs.Fields("FechaOrdenPago").Value & ", Reingrese", vbExclamation
               oRs.Close
               Set oRs = Nothing
               Exit Sub
            End If
            oRs.Close
            
            If ExistenAnticiposAplicados() Then
               MsgBox "Hay anticipos que en cuenta corriente tienen aplicado el saldo" & vbCrLf & _
                     "No puede modificar esta orden de pago", vbInformation
               Exit Sub
            End If
         
            Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_ValoresEnConciliacionesPorIdOrdenPago", mvarId)
            If oRs.RecordCount > 0 Then
               mAux1 = ""
               oRs.MoveFirst
               Do While Not oRs.EOF
                  mAux1 = mAux1 & IIf(IsNull(oRs.Fields("Numero").Value), 0, oRs.Fields("Numero").Value) & " "
                  oRs.MoveNext
               Loop
               MsgBox "Cuidado, hay valores en esta orden que estan en" & vbCrLf & _
                     "la(s) conciliacion(es) : " & mAux1 & vbCrLf & _
                     "tome las precauciones del caso." & vbCrLf & _
                     "El mensaje es solo informativo.", vbExclamation
            End If
            oRs.Close
         
            If Check6.Value = 0 And Option1.Value And (Val(txtRetGan.Text) <> 0 Or Val(txtIngBru.Text) <> 0) Then
               origen.Registro.Fields("RecalculoRetencionesUltimaModificacion").Value = "NO"
               MsgBox "Cuidado, modifico esta orden de pago que tiene retenciones" & vbCrLf & _
                     "y no recalculo los importes correspondientes (check amarillo)" & vbCrLf & _
                     "el sistema dejara los calculos anteriores, sin importar los cambios", vbInformation
            End If
            If Check6.Value = 1 And Option1.Value Then
               origen.Registro.Fields("RecalculoRetencionesUltimaModificacion").Value = "SI"
            End If
         End If
         Set oRs = Nothing
         
         If mvarControlarRubrosContablesEnOP = "SI" Then
'         And ListaRubrosContables.ListItems.Count = 0 Then
'            mvarSeguro = MsgBox("No ha ingresado las imputaciones por rubro contable," & vbCrLf & _
'                                 "Desea continuar ?", vbYesNo, "Rubros contables")
'            If mvarSeguro = vbNo Then
'               Exit Sub
'            End If
            If mvarTotalValores <> mvarTotalRubrosContables And (Not Frame2.Visible Or (Frame2.Visible And Option5.Value)) Then
                  '(Not Combo1(0).Visible Or (Combo1(0).Visible And Combo1(0).ListIndex = 1)) Then
               MsgBox "El total de rubros contables asignados debe ser igual al total de valores", vbExclamation
               Exit Sub
            End If
         End If
         
         If BuscarClaveINI("Requerir obra en OP") = "SI" And dcfields1(0).Visible And Not IsNumeric(dcfields1(0).BoundText) Then
            MsgBox "Debe ingresar la obra", vbExclamation
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim oPar As ComPronto.Parametro
         Dim oGan As ComPronto.TipoRetencionGanancia
         Dim oID As ComPronto.ImpuestoDirecto
         Dim oPrv As ComPronto.Provincia
         Dim mNum As Long
         Dim i As Integer
         Dim mNumerador As String, mError As String
      
         If Lista.ListItems.Count = 0 And Option1.Value Then
            MsgBox "No se puede almacenar una Orden de Pago sin detalles"
            Exit Sub
         End If
         
         ActualizaListaContable
         
         If Val(txtTotal(1).Text) <> Val(txtTotal(2).Text) Then
            MsgBox "No balancea el registro contable", vbInformation
            Exit Sub
         End If
         
         If ListaCta.ListItems.Count = 0 Then
            MsgBox "No hay registro contable, revise la definicion de cuentas utilizadas en este pago.", vbExclamation
            Exit Sub
         End If
         
         Set oRs = origen.DetOrdenesPagoCuentas.TodosLosRegistros
         If oRs.Fields.Count > 0 Then
            If oRs.RecordCount > 0 Then
               oRs.MoveFirst
               Do While Not oRs.EOF
                  If Not oRs.Fields("Eliminado").Value Then
                     If IIf(IsNull(oRs.Fields("IdCuenta").Value), 0, oRs.Fields("IdCuenta").Value) = 0 Then
                        Set oRs = Nothing
                        MsgBox "Hay cuentas contables no definidas, no puede registrar el pago", vbExclamation
                        Exit Sub
                     End If
                  End If
                  oRs.MoveNext
               Loop
            End If
         End If
         Set oRs = Nothing
         
         With origen.Registro
            For Each dc In dcfields
               If dc.Enabled And dc.Visible Then
                  If Len(Trim(dc.BoundText)) = 0 And _
                        dc.Index <> 1 And dc.Index <> 2 And dc.Index <> 5 Then
                     MsgBox "Falta completar el campo " & IIf(Len(dc.Tag) = 0, lblDestino.Caption, dc.Tag), vbCritical
                     Exit Sub
                  End If
                  If IsNumeric(dc.BoundText) Then .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
            
            Set oRs = origen.DetOrdenesPagoValores.Registros
            mError = ""
            If oRs.Fields.Count > 0 Then
               If oRs.RecordCount > 0 Then
                  oRs.MoveFirst
                  Do While Not oRs.EOF
                     If Not oRs.Fields("Eliminado").Value Then
                        If IsNull(oRs.Fields("IdValor").Value) Then
                           If Not IsNull(oRs.Fields("IdCaja").Value) Then
                              If oRs.Fields("IdCaja").Value = 0 Then
                                 mError = mError & vbCrLf & "Caja no definida en valores"
                              End If
                           ElseIf Not IsNull(oRs.Fields("IdTarjetaCredito").Value) Then
                              If oRs.Fields("IdTarjetaCredito").Value = 0 Then
                                 mError = mError & vbCrLf & "Tarjeta de credito no definida en valores"
                              End If
                           Else
                              If IsNull(oRs.Fields("IdCuentaBancaria").Value) Or oRs.Fields("IdCuentaBancaria").Value = 0 Then
                                 mError = mError & vbCrLf & "Cuenta bancaria no definida en valores"
                              End If
                              If Not IsNull(oRs.Fields("IdBancoChequera").Value) Then
                                 Set oRsAux = Aplicacion.TablasGenerales.TraerFiltrado("DetOrdenesPagoValores", "_Control", _
                                          Array(mvarId, oRs.Fields("IdBancoChequera").Value, oRs.Fields("NumeroValor").Value))
                                 If oRsAux.RecordCount > 0 Then
                                    MsgBox "El cheque " & oRs.Fields("NumeroValor").Value & " ya existe " & _
                                          " en la OP " & oRsAux.Fields("Numero").Value, vbExclamation
                                    oRsAux.Close
                                    Set oRsAux = Nothing
                                    Exit Sub
                                 End If
                                 oRsAux.Close
                                 Set oRsAux = Nothing
                              End If
'                              If IsNull(oRs.Fields("IdBancoChequera").Value) Or _
'                                    oRs.Fields("IdBancoChequera").Value = 0 Then
'                                 mError = mError & vbCrLf & "Chequera bancaria no definida en valores"
'                              End If
                           End If
                        End If
                     End If
                     oRs.MoveNext
                  Loop
               End If
            End If
            Set oRs = Nothing
            If Len(mError) > 0 Then
               MsgBox "Se han encontrado los siguientes errores en los valores :" & mError
               Exit Sub
            End If
            
            If mTipo <> "" Then
               .Fields("Tipo").Value = mTipo
            Else
               .Fields("Tipo").Value = Null
            End If
            .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text
            .Fields("CotizacionDolar").Value = txtCotizacionDolar.Text
            .Fields("CotizacionEuro").Value = txtCotizacionEuro.Text
            .Fields("Exterior").Value = mOrdenPagoExterior
            
            If Check1.Value = 1 Then
               .Fields("Dolarizada").Value = "SI"
            Else
               .Fields("Dolarizada").Value = "NO"
            End If
            
            If Check3.Value = 1 Then
               .Fields("AsientoManual").Value = "SI"
            Else
               .Fields("AsientoManual").Value = "NO"
            End If
            
            If Check5.Value = 1 Then
               .Fields("CalculaSUSS").Value = "SI"
               If mvarId <= 0 Then .Fields("IdImpuestoDirecto").Value = mvarIdImpuestoDirectoSUSS
            Else
               .Fields("CalculaSUSS").Value = "NO"
            End If
            
            If Option3.Value Then
               If Option4.Value Then
                  .Fields("TipoOperacionOtros").Value = 0
               ElseIf Option5.Value Then
                  .Fields("TipoOperacionOtros").Value = 1
               End If
            Else
               .Fields("TipoOperacionOtros").Value = Null
            End If
         
            If Val(txtRetGan.Text) > 0 Then
               Set oRs = origen.DetOrdenesPagoImpuestos.TodosLosRegistros
               If oRs.Fields.Count > 0 Then
                  If oRs.RecordCount > 0 Then
                     oRs.MoveFirst
                     Do While Not oRs.EOF
                        If oRs.Fields("TipoImpuesto").Value = "Ganancias" And _
                              Not IsNull(oRs.Fields("ImpuestoRetenido").Value) And _
                              oRs.Fields("ImpuestoRetenido").Value > 0 And _
                              IsNull(oRs.Fields("NumeroCertificadoRetencionGanancias").Value) Then
                           If BuscarClaveINI("Numerar certificados de ganancias por categoria") = "SI" Then
                              If Not IsNull(oRs.Fields("IdTipoRetencionGanancia").Value) Then
                                 Set oGan = Aplicacion.TiposRetencionGanancia.Item(oRs.Fields("IdTipoRetencionGanancia").Value)
                                 With oGan.Registro
                                    mNum = IIf(IsNull(.Fields("ProximoNumeroCertificadoRetencionGanancias").Value), 1, .Fields("ProximoNumeroCertificadoRetencionGanancias").Value)
                                    origen.DetOrdenesPagoImpuestos.Item(oRs.Fields(0).Value).Registro.Fields("NumeroCertificadoRetencionGanancias").Value = mNum
                                    .Fields("ProximoNumeroCertificadoRetencionGanancias").Value = mNum + 1
                                 End With
                                 oGan.Guardar
                                 Set oGan = Nothing
                              End If
                           Else
                              Set oPar = Aplicacion.Parametros.Item(1)
                              With oPar.Registro
                                 mNum = IIf(IsNull(.Fields("ProximoNumeroCertificadoRetencionGanancias").Value), 1, .Fields("ProximoNumeroCertificadoRetencionGanancias").Value)
                                 origen.DetOrdenesPagoImpuestos.Item(oRs.Fields(0).Value).Registro.Fields("NumeroCertificadoRetencionGanancias").Value = mNum
                                 .Fields("ProximoNumeroCertificadoRetencionGanancias").Value = mNum + 1
                              End With
                              oPar.Guardar
                              Set oPar = Nothing
                           End If
                        End If
                        oRs.MoveNext
                     Loop
                  End If
               End If
               Set oRs = Nothing
            End If
         
            If Val(txtRetIva.Text) > 0 And _
                  IsNull(origen.Registro.Fields("NumeroCertificadoRetencionIVA").Value) Then
               Set oPar = Aplicacion.Parametros.Item(1)
               With oPar.Registro
                  mNum = IIf(IsNull(.Fields("ProximoNumeroCertificadoRetencionIVA").Value), 1, .Fields("ProximoNumeroCertificadoRetencionIVA").Value)
                  origen.Registro.Fields("NumeroCertificadoRetencionIVA").Value = mNum
                  .Fields("ProximoNumeroCertificadoRetencionIVA").Value = mNum + 1
               End With
               oPar.Guardar
               Set oPar = Nothing
            End If
         
            If Val(txtIngBru.Text) > 0 Then
               Set oRs = origen.DetOrdenesPagoImpuestos.TodosLosRegistros
               If oRs.Fields.Count > 0 Then
                  If oRs.RecordCount > 0 Then
                     oRs.MoveFirst
                     Do While Not oRs.EOF
                        If oRs.Fields("TipoImpuesto").Value = "I.Brutos" And _
                              Not IsNull(oRs.Fields("ImpuestoRetenido").Value) And _
                              oRs.Fields("ImpuestoRetenido").Value > 0 And _
                              Not IsNull(oRs.Fields("IdIBCondicion").Value) And _
                              IsNull(oRs.Fields("NumeroCertificadoRetencionIIBB").Value) Then
                           Set oRsAux = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", oRs.Fields("IdIBCondicion").Value)
                           If oRsAux.RecordCount > 0 Then
                              If Not IsNull(oRsAux.Fields("IdProvincia").Value) Then
                                 Set oPrv = Aplicacion.Provincias.Item(oRsAux.Fields("IdProvincia").Value)
                                 With oPrv.Registro
                                    mNum = IIf(IsNull(.Fields("ProximoNumeroCertificadoRetencionIIBB").Value), 1, .Fields("ProximoNumeroCertificadoRetencionIIBB").Value)
                                    origen.DetOrdenesPagoImpuestos.Item(oRs.Fields(0).Value).Registro.Fields("NumeroCertificadoRetencionIIBB").Value = mNum
                                    .Fields("ProximoNumeroCertificadoRetencionIIBB").Value = mNum + 1
                                 End With
                                 oPrv.Guardar
                                 Set oPrv = Nothing
                              End If
                           End If
                           oRsAux.Close
                        End If
                        oRs.MoveNext
                     Loop
                  End If
               End If
               Set oRsAux = Nothing
               Set oRs = Nothing
            End If
         
            If Val(txtRetencionSUSS.Text) > 0 And _
                  IsNull(origen.Registro.Fields("NumeroCertificadoRetencionSUSS").Value) Then
               If BuscarClaveINI("Numerar certificados de impuestos directos por categoria") = "SI" Then
                  Set oRsAux = Aplicacion.ImpuestosDirectos.TraerFiltrado("_PorId", mvarIdImpuestoDirectoSUSS)
                  If oRsAux.RecordCount > 0 Then
                     If IsNull(oRsAux.Fields("Grupo").Value) Then
                        Set oID = Aplicacion.ImpuestosDirectos.Item(mvarIdImpuestoDirectoSUSS)
                        With oID.Registro
                           mNum = IIf(IsNull(.Fields("ProximoNumeroCertificado").Value), 1, .Fields("ProximoNumeroCertificado").Value)
                           origen.Registro.Fields("NumeroCertificadoRetencionSUSS").Value = mNum
                           .Fields("ProximoNumeroCertificado").Value = mNum + 1
                        End With
                        oID.Guardar
                        Set oID = Nothing
                     Else
                        mAux2 = oRsAux.Fields("Grupo").Value
                        oRsAux.Close
                        Set oRsAux = Aplicacion.ImpuestosDirectos.TraerFiltrado("_PorGrupoConCertificado", mAux2)
                        If oRsAux.RecordCount > 0 Then
                           Set oID = Aplicacion.ImpuestosDirectos.Item(oRsAux.Fields(0).Value)
                           With oID.Registro
                              mNum = IIf(IsNull(.Fields("ProximoNumeroCertificado").Value), 1, .Fields("ProximoNumeroCertificado").Value)
                              origen.Registro.Fields("NumeroCertificadoRetencionSUSS").Value = mNum
                              .Fields("ProximoNumeroCertificado").Value = mNum + 1
                           End With
                           oID.Guardar
                           Set oID = Nothing
                        End If
                     End If
                  End If
                  oRsAux.Close
                  Set oRsAux = Nothing
               Else
                  Set oPar = Aplicacion.Parametros.Item(1)
                  With oPar.Registro
                     mNum = IIf(IsNull(.Fields("ProximoNumeroCertificadoRetencionSUSS").Value), 1, .Fields("ProximoNumeroCertificadoRetencionSUSS").Value)
                     origen.Registro.Fields("NumeroCertificadoRetencionSUSS").Value = mNum
                     .Fields("ProximoNumeroCertificadoRetencionSUSS").Value = mNum + 1
                  End With
                  oPar.Guardar
                  Set oPar = Nothing
               End If
            End If
         
            If mvarId < 0 Then
               .Fields("IdUsuarioIngreso").Value = glbIdUsuario
               .Fields("FechaIngreso").Value = Now
            Else
               .Fields("IdUsuarioModifico").Value = glbIdUsuario
               .Fields("FechaModifico").Value = Now
            End If
         
            .Fields("Confirmado").Value = "SI"
            .Fields("Observaciones").Value = rchObservaciones.Text
            .Fields("NumeroRendicionFF").Value = Val(txtNumeroRendicionFF.Text)
            If Check8.Visible And Check8.Value = 1 Then
               .Fields("OPInicialFF").Value = "SI"
            Else
               .Fields("OPInicialFF").Value = Null
            End If
         End With
         
'         If mvarId < 0 Then
'            If Check2.Value = 0 Then
'               If Option3.Value Then
'                  mNumerador = "ProximaOrdenPagoOtros"
'               Else
'                  mNumerador = "ProximaOrdenPago"
'               End If
'            Else
'               mNumerador = "ProximaOrdenPagoExterior"
'            End If
'            Set oPar = Aplicacion.Parametros.Item(1)
'            mNum = oPar.Registro.Fields(mNumerador).Value
'            For i = 1 To 1000
'               Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_ValidarNumero", Array(origen.Registro.Fields("NumeroOrdenPago").Value, mvarId, mTipo, mOrdenPagoExterior))
'               If oRs.RecordCount > 0 Then
'                  oRs.Close
'                  If i = 1 Then MsgBox "El numero de orden de pago ya fue utilizado," & vbCrLf & _
'                                       "el sistema buscara el siguiente numero disponible", vbExclamation, _
'                                       "Numero de orden de pago"
'                  origen.Registro.Fields("NumeroOrdenPago").Value = mNum
'                  mNum = mNum + 1
'               Else
'                  oRs.Close
'                  If i > 1 Or origen.Registro.Fields("NumeroOrdenPago").Value = mNum Then
'                     With oPar
'                        .Registro.Fields(mNumerador).Value = IIf(i > 1, mNum, mNum + 1)
'                        .Guardar
'                     End With
'                  End If
'                  Exit For
'               End If
'            Next
'            Set oRs = Nothing
'            Set oPar = Nothing
'            If i > 1 Then MsgBox "El numero asignado a esta orden de pago es el " & origen.Registro.Fields("NumeroOrdenPago").Value, vbInformation
'         End If

         On Error GoTo Mal2
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
            origen.Id = mvarId
            mvarGrabado = True
         Else
            est = Modificacion
         End If
            
         If Option2.Value Then
            Dim mIdOPComplementaria As Long
            If Not IsNull(origen.Registro.Fields("IdOPComplementariaFF").Value) Then
               mIdOPComplementaria = origen.Registro.Fields("IdOPComplementariaFF").Value
            Else
               mIdOPComplementaria = -1
            End If
            Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_TraerGastosPorOrdenPagoParaAnular", Array(mvarId, mIdOPComplementaria))
            If oRs.RecordCount > 0 Then
               Do While Not oRs.EOF
                  Aplicacion.Tarea "ComprobantesProveedores_AnularVale", oRs.Fields("IdComprobanteProveedor").Value
                  oRs.MoveNext
               Loop
            End If
            oRs.Close
            Set oRs = Nothing
            Dim Filas
            Dim Columnas
            Filas = VBA.Split(ListaGastos.GetStringCheck, vbCrLf)
            For i = LBound(Filas) + 1 To UBound(Filas)
               Columnas = VBA.Split(Filas(i), vbTab)
               Aplicacion.Tarea "ComprobantesProveedores_GrabarVale", Array(Columnas(15), mvarId)
            Next
         End If
         
         With actL2
            .ListaEditada = "OPagoTodas,OPagoALaFirma,OPagoEnCaja,+SubOp2"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
         Dim mvarImprime As Integer
         mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de Orden de Pago")
         If mvarImprime = vbYes Then
            Me.Refresh
            cmdImpre_Click 0
'            If Val(txtRetGan.Text) > 0 Then
'               Me.Refresh
'               mvarImprime = MsgBox("Desea imprimir el certificado de retencion ganancias ?", vbYesNo, "Impresion de certificado de retencion")
'               If mvarImprime = vbYes Then
'                  EmisionCertificadoRetencionGanancias mvarId, "Printer", mPrinterSeleccionada
'               End If
'            End If
'            If Val(txtRetIva.Text) > 0 Then
'               Me.Refresh
'               mvarImprime = MsgBox("Desea imprimir el certificado de retencion de IVA ?", vbYesNo, "Impresion de certificado de IVA")
'               If mvarImprime = vbYes Then
'                  EmisionCertificadoRetencionIVA mvarId, "Printer", mPrinterSeleccionada
'               End If
'            End If
'            If Val(txtIngBru.Text) > 0 Then
'               Me.Refresh
'               mvarImprime = MsgBox("Desea imprimir el certificado de retencion de IIBB ?", vbYesNo, "Impresion de certificado de IIBB")
'               If mvarImprime = vbYes Then
'                  EmisionCertificadoRetencionIIBB mvarId, "Printer", mPrinterSeleccionada
'               End If
'            End If
'            If Val(txtRetencionSUSS.Text) > 0 Then
'               Me.Refresh
'               mvarImprime = MsgBox("Desea imprimir el certificado de retencion de SUSS ?", vbYesNo, "Impresion de certificado de SUSS")
'               If mvarImprime = vbYes Then
'                  EmisionCertificadoRetencionSUSS mvarId, "Printer", mPrinterSeleccionada
'               End If
'            End If
         End If
         
         mvarAnuloValor = False
         
         Unload Me

      Case 1
         Unload Me

      Case 2
         Dim oF As frmConsultaValores
         
         Set oF = New frmConsultaValores
         With oF
            .Show , Me
         End With
         Set oF = Nothing
         
      Case 3
         cmd(3).Enabled = False
         ActualizaListaContable
         cmd(3).Enabled = True
   
      Case 4
         CargarGastosPendientes
      
      Case 5
         AnularOrdenPago
      
      Case 6
         AsignarRubrosContables
      
      Case 7
         If Len(txtRetGan.Text) = 0 Then
            MsgBox "No ha ingresado el monto de retencion", vbExclamation
            Exit Sub
         End If
         
         If Not mvarGrabado Then
            MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
            Exit Sub
         End If
         
         EmisionCertificadoRetencionGanancias mvarId, "Word", mPrinterSeleccionada
   
      Case 8
         AgregarDiferenciaCambio
         
      Case 9
         If Len(txtRetIva.Text) = 0 Then
            MsgBox "No ha ingresado el monto de retencion", vbExclamation
            Exit Sub
         End If
         
         If Not mvarGrabado Then
            MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
            Exit Sub
         End If
         
         EmisionCertificadoRetencionIVA mvarId, "Word", mPrinterSeleccionada
   
      Case 10
         If Len(txtIngBru.Text) = 0 Then
            MsgBox "No ha ingresado el monto de retencion", vbExclamation
            Exit Sub
         End If
         
         If Not mvarGrabado Then
            MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
            Exit Sub
         End If
         
         EmisionCertificadoRetencionIIBB mvarId, "Word", mPrinterSeleccionada
   
      Case 11
         If Len(txtRetencionSUSS.Text) = 0 Then
            MsgBox "No ha ingresado el monto de retencion", vbExclamation
            Exit Sub
         End If
         
         If Not mvarGrabado Then
            MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
            Exit Sub
         End If
         
         EmisionCertificadoRetencionSUSS mvarId, "Word", mPrinterSeleccionada
   
      Case 12
         Lista.Visible = False
         ListaGastos.Visible = False
         With ListaAnticipos
            .Top = Lista.Top
            .Left = Lista.Left
            .Width = Lista.Width
            .Height = Lista.Height
            .Visible = True
         End With
         mvarOP_AnticiposAlPersonal = True
         cmd(12).Enabled = False
   
   End Select
   
Salida:

   Exit Sub

Mal1:
   
   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select
   Resume Salida

Mal2:
   
   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select
   Unload Me

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim dtf As DTPicker
   Dim dc As DataCombo
   Dim oRs As ADOR.Recordset
   Dim oDet As ComPronto.DetOrdenPago
   Dim oDetVal As ComPronto.DetOrdenPagoValores
   Dim oDetCta As ComPronto.DetOrdenPagoCuentas
   Dim oDetAnt As ComPronto.DetOrdenPagoAnticipos
   Dim oDetImp As ComPronto.DetOrdenPagoImpuestos
   Dim oDetRubCon As ComPronto.DetOrdenPagoRubrosContables
   Dim ListaVacia1 As Boolean, ListaVacia2 As Boolean, ListaVacia3 As Boolean, ListaVacia4 As Boolean, ListaVacia5 As Boolean
   Dim ListaVacia6 As Boolean
   Dim mAux1
   
   mvarId = vnewvalue
   ListaVacia1 = False
   ListaVacia2 = False
   ListaVacia3 = False
   ListaVacia4 = False
   ListaVacia5 = False
   ListaVacia6 = False
   mRegimenEspecialConstruccionIIBB = ""

   Set oAp = Aplicacion
   Set origen = oAp.OrdenesPago.Item(vnewvalue)
   
   mvarRetenerSUSSAProveedor = "NO"
   mvarPorcentajeRetencionSUSS1 = 0
   mvarImporteMinimoBaseRetencionSUSS = 0
   mvarRetenerGanancias = False
   mvarRetenerIIBB = False
   mIGCondicionExcepcion = 1
   mvarOP_AnticiposAlPersonal = False
   mvarAnulada = "NO"
   mPrinterSeleccionada = ""
   mvarControlCheck = True
   mvarCodigoSituacionRetencionIVA = 0
   mvarPrimeraVez = True
   mvarAnuloValor = False
   
   If BuscarClaveINI("Habilitar conceptos 2 para OP de otros") = "SI" Then
      Label5.Visible = True
      dcfields(4).Visible = True
      rchObservaciones.Width = rchObservaciones.Width * 0.7
   End If
   If BuscarClaveINI("Habilitar campo detalle en OP de proveedores") = "SI" Then
      With Label6
         .Top = lblOPComplementaria(0).Top
         .Left = lblOPComplementaria(0).Left
         .Visible = True
      End With
      With txtDetalle
         .Top = Label6.Top + Label6.Height
         .Left = Label6.Left
         .Width = cmd(0).Width * 3
         .Visible = True
      End With
   End If
   If BuscarClaveINI("Datos adicionales para OP", -1) = "SI" Then
      lblAuxiliares(0).Visible = True
      lblAuxiliares(1).Visible = True
      lblAuxiliares(2).Visible = True
      txtTextoAuxiliar1.Visible = True
      txtTextoAuxiliar2.Visible = True
      txtTextoAuxiliar3.Visible = True
      Me.Height = Me.Height * 1.04
   End If
   If BuscarClaveINI("Habilitar carga automatica de rubros financieros") = "SI" And mvarId <= 0 Then Check7.Value = 1

   mAux1 = TraerValorParametro2("ControlarCircuitoFirmasEnOP")
   mvarControlarCircuitoFirmasEnOP = False
   If Not IsNull(mAux1) And mAux1 = "SI" Then mvarControlarCircuitoFirmasEnOP = True
   
   mAux1 = TraerValorParametro2("PorcentajeRetencionIVAMonotributistas")
   mvarPorcentajeRetencionIVAMonotributistas = 0
   If Not IsNull(mAux1) Then mvarPorcentajeRetencionIVAMonotributistas = Val(mAux1)
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      mvarIdMonedaPesos = IIf(IsNull(.Fields("IdMoneda").Value), 1, .Fields("IdMoneda").Value)
      mvarIdMonedaDolar = IIf(IsNull(.Fields("IdMonedaDolar").Value), 2, .Fields("IdMonedaDolar").Value)
      mvarIdMonedaEuro = IIf(IsNull(.Fields("IdMonedaEuro").Value), 6, .Fields("IdMonedaEuro").Value)
      mvarImporteTotalMinimoAplicacionRetencionIVA = IIf(IsNull(.Fields("ImporteTotalMinimoAplicacionRetencionIVA").Value), 0, .Fields("ImporteTotalMinimoAplicacionRetencionIVA").Value)
      mvarPorcentajeBaseRetencionIVABienes = IIf(IsNull(.Fields("PorcentajeBaseRetencionIVABienes").Value), 0, .Fields("PorcentajeBaseRetencionIVABienes").Value)
      mvarPorcentajeBaseRetencionIVAServicios = IIf(IsNull(.Fields("PorcentajeBaseRetencionIVAServicios").Value), 0, .Fields("PorcentajeBaseRetencionIVAServicios").Value)
      mvarImporteMinimoRetencionIVA = IIf(IsNull(.Fields("ImporteMinimoRetencionIVA").Value), 0, .Fields("ImporteMinimoRetencionIVA").Value)
      mvarImporteMinimoRetencionIVAServicios = IIf(IsNull(.Fields("ImporteMinimoRetencionIVAServicios").Value), 0, .Fields("ImporteMinimoRetencionIVAServicios").Value)
      mvarAgenteRetencionIVA = IIf(IsNull(.Fields("AgenteRetencionIVA").Value), "NO", .Fields("AgenteRetencionIVA").Value)
      mvarIdTipoCuentaGrupoAnticiposAlPersonal = IIf(IsNull(.Fields("IdTipoCuentaGrupoAnticiposAlPersonal").Value), 0, .Fields("IdTipoCuentaGrupoAnticiposAlPersonal").Value)
      mvarIdTipoComprobanteNDInternaAcreedores = IIf(IsNull(.Fields("IdTipoComprobanteNDInternaAcreedores").Value), 0, .Fields("IdTipoComprobanteNDInternaAcreedores").Value)
      mvarIdTipoComprobanteNCInternaAcreedores = IIf(IsNull(.Fields("IdTipoComprobanteNCInternaAcreedores").Value), 0, .Fields("IdTipoComprobanteNCInternaAcreedores").Value)
      mvarAgenteRetencionSUSS = IIf(IsNull(.Fields("AgenteRetencionSUSS").Value), "NO", .Fields("AgenteRetencionSUSS").Value)
      mvarPorcentajeRetencionSUSS = IIf(IsNull(.Fields("PorcentajeRetencionSUSS").Value), 0, .Fields("PorcentajeRetencionSUSS").Value)
      mvarControlarRubrosContablesEnOP = IIf(IsNull(.Fields("ControlarRubrosContablesEnOP").Value), "SI", .Fields("ControlarRubrosContablesEnOP").Value)
      mvarImporteComprobantesMParaRetencionIVA = IIf(IsNull(.Fields("ImporteComprobantesMParaRetencionIVA").Value), 0, .Fields("ImporteComprobantesMParaRetencionIVA").Value)
      mvarPorcentajeRetencionIVAComprobantesM = IIf(IsNull(.Fields("PorcentajeRetencionIVAComprobantesM").Value), 0, .Fields("PorcentajeRetencionIVAComprobantesM").Value)
      mvarTopeMinimoRetencionIVA = IIf(IsNull(.Fields("TopeMinimoRetencionIVA").Value), 0, .Fields("TopeMinimoRetencionIVA").Value)
      mvarTopeMinimoRetencionIVAServicios = IIf(IsNull(.Fields("TopeMinimoRetencionIVAServicios").Value), 0, .Fields("TopeMinimoRetencionIVAServicios").Value)
      mvarAgenteRetencionIIBB = IIf(IsNull(.Fields("AgenteRetencionIIBB").Value), "NO", .Fields("AgenteRetencionIIBB").Value)
      gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)
   End With
   oRs.Close
   
   If vnewvalue < 0 Then
      origen.Registro.Fields("FechaOrdenPago").Value = 1
      mvarIdProveedor = 0
   Else
      If Not IsNull(origen.Registro.Fields("IdProveedor").Value) Then
         mvarIdProveedor = origen.Registro.Fields("IdProveedor").Value
      Else
         mvarIdProveedor = 0
      End If
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
                     Set oControl.DataSource = origen.DetOrdenesPago.TraerMascara
                     ListaVacia1 = True
                  Else
                     Set oRs = origen.DetOrdenesPago.TraerFiltrado("_PorIdOrdenPago", mvarId)
                     If oRs.RecordCount <> 0 Then
                        oRs.MoveFirst
                        While Not oRs.EOF
                           Set oDet = origen.DetOrdenesPago.Item(oRs.Fields(0).Value)
                           oDet.Modificado = True
                           Set oDet = Nothing
                           oRs.MoveNext
                        Wend
                        Set oControl.DataSource = origen.DetOrdenesPago.RegistrosConFormato
                     Else
                        Set oControl.DataSource = origen.DetOrdenesPago.TraerMascara
                        ListaVacia1 = True
                     End If
                     oRs.Close
                  End If
               Case "ListaVal"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetOrdenesPagoValores.TraerMascara
                     ListaVacia2 = True
                  Else
                     Set oRs = origen.DetOrdenesPagoValores.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                     Else
                        Set oControl.DataSource = origen.DetOrdenesPagoValores.TraerMascara
                        ListaVacia2 = True
                     End If
                     While Not oRs.EOF
                        Set oDetVal = origen.DetOrdenesPagoValores.Item(oRs.Fields(0).Value)
                        oDetVal.Modificado = True
                        Set oDetVal = Nothing
                        oRs.MoveNext
                     Wend
                     oRs.Close
                  End If
               Case "ListaCta"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetOrdenesPagoCuentas.TraerMascara
                     ListaVacia3 = True
                  Else
                     Set oRs = origen.DetOrdenesPagoCuentas.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                     Else
                        Set oControl.DataSource = origen.DetOrdenesPagoCuentas.TraerMascara
                        ListaVacia3 = True
                     End If
                     While Not oRs.EOF
                        Set oDetCta = origen.DetOrdenesPagoCuentas.Item(oRs.Fields(0).Value)
                        oDetCta.Modificado = True
                        Set oDetCta = Nothing
                        oRs.MoveNext
                     Wend
                     oRs.Close
                  End If
               Case "ListaAnticipos"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetOrdenesPagoAnticipos.TraerMascara
                     ListaVacia4 = True
                  Else
                     Set oRs = origen.DetOrdenesPagoAnticipos.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                     Else
                        Set oControl.DataSource = origen.DetOrdenesPagoAnticipos.TraerMascara
                        ListaVacia4 = True
                     End If
                     While Not oRs.EOF
                        Set oDetAnt = origen.DetOrdenesPagoAnticipos.Item(oRs.Fields(0).Value)
                        oDetAnt.Modificado = True
                        Set oDetAnt = Nothing
                        oRs.MoveNext
                     Wend
                     oRs.Close
                  End If
               Case "ListaImpuestos"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetOrdenesPagoImpuestos.TraerMascara
                     ListaVacia5 = True
                  Else
                     Set oRs = origen.DetOrdenesPagoImpuestos.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                     Else
                        Set oControl.DataSource = origen.DetOrdenesPagoImpuestos.TraerMascara
                        ListaVacia5 = True
                     End If
                     While Not oRs.EOF
                        Set oDetImp = origen.DetOrdenesPagoImpuestos.Item(oRs.Fields(0).Value)
                        oDetImp.Modificado = True
                        Set oDetImp = Nothing
                        oRs.MoveNext
                     Wend
                     oRs.Close
                  End If
               Case "ListaRubrosContables"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetOrdenesPagoRubrosContables.TraerMascara
                     ListaVacia6 = True
                  Else
                     Set oRs = origen.DetOrdenesPagoRubrosContables.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                     Else
                        Set oControl.DataSource = origen.DetOrdenesPagoRubrosContables.TraerMascara
                        ListaVacia6 = True
                     End If
                     If oRs.Fields.Count <> 0 Then
                        While Not oRs.EOF
                           Set oDetRubCon = origen.DetOrdenesPagoRubrosContables.Item(oRs.Fields(0).Value)
                           oDetRubCon.Modificado = True
                           Set oDetRubCon = Nothing
                           oRs.MoveNext
                        Wend
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
               ElseIf oControl.Tag = "ConceptosOP" Then
                  Set oControl.RowSource = oAp.Conceptos.TraerFiltrado("_PorGrupoParaCombo", 1)
               ElseIf oControl.Tag = "Clasificacion" Then
                  Set oControl.RowSource = oAp.Conceptos.TraerFiltrado("_PorGrupoParaCombo", 2)
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
   
   If ListaVacia1 Then Lista.ListItems.Clear
   If ListaVacia2 Then ListaVal.ListItems.Clear
   If ListaVacia3 Then
      ListaCta.ListItems.Clear
      ListaCta.Refresh
   End If
   If ListaVacia4 Then
      ListaAnticipos.ListItems.Clear
      ListaAnticipos.Refresh
   Else
      cmd_Click 12
   End If
   If ListaVacia5 Then
      ListaImpuestos.ListItems.Clear
      ListaImpuestos.Refresh
   End If
   If ListaVacia6 Then
      ListaRubrosContables.ListItems.Clear
      ListaRubrosContables.Refresh
   End If

   If mvarId = -1 Then
      Set oRs = oAp.Parametros.Item(1).Registro
      With origen.Registro
         .Fields("NumeroOrdenPago").Value = oRs.Fields("ProximaOrdenPago").Value
         .Fields("Estado").Value = "FI"
         .Fields("IdMoneda").Value = mvarIdMonedaPesos
         .Fields("FechaOrdenPago").Value = Date
      End With
      oRs.Close
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      txtCotizacionMoneda.Text = 1
      Option1.Value = True
      If BuscarClaveINI("Calcular diferencia de cambio en acreedores") = "SI" Then
         Check1.Value = 1
      End If
      Lista.ListItems.Clear
      ListaVal.ListItems.Clear
      ListaCta.ListItems.Clear
      ListaAnticipos.ListItems.Clear
      ListaImpuestos.ListItems.Clear
      Check6.Visible = False
      mvarCotizacion = Cotizacion(Date, glbIdMonedaDolar)
      txtCotizacionDolar.Text = mvarCotizacion
      mvarCotizacionEuro = Cotizacion(Date, glbIdMonedaEuro)
      txtCotizacionEuro.Text = mvarCotizacionEuro
      mvarGrabado = False
   Else
'      For Each dtf In DTFields
'         dtf.Enabled = False
'      Next
'      For Each dc In dcfields
'         If dc.Index <> 0 And dc.Index <> 3 Then dc.Enabled = False
'      Next
      With origen.Registro
         If Not IsNull(.Fields("Tipo").Value) Then
            If .Fields("Tipo").Value = "CC" Then
               Option1.Value = True
            ElseIf .Fields("Tipo").Value = "FF" Then
               Option2.Value = True
               txtNumeroRendicionFF.Text = IIf(IsNull(.Fields("NumeroRendicionFF").Value), "", .Fields("NumeroRendicionFF").Value)
            ElseIf .Fields("Tipo").Value = "OT" Then
               Option3.Value = True
               If Not IsNull(.Fields("TipoOperacionOtros").Value) Then
                  If .Fields("TipoOperacionOtros").Value = 0 Then Option4.Value = True
                  If .Fields("TipoOperacionOtros").Value = 1 Then Option5.Value = True
                  'Combo1(0).ListIndex = .Fields("TipoOperacionOtros").Value
               End If
            End If
         Else
            Option1.Value = True
         End If
         If .Fields("Tipo").Value = "CC" Then
            lblEstado.Visible = True
            If .Fields("Estado").Value = "CA" Then
               lblEstado.Caption = "En caja"
            ElseIf .Fields("Estado").Value = "FI" Then
               lblEstado.Caption = "A la firma"
            ElseIf .Fields("Estado").Value = "EN" Then
               lblEstado.Caption = "Entregado"
            Else
               lblEstado.Visible = False
            End If
         End If
         If .Fields("Anulada").Value = "SI" Then
            mvarAnulada = "SI"
            lblEstado.Visible = True
            lblEstado.Caption = "ANULADA"
         End If
         mvarCotizacion = IIf(IsNull(.Fields("CotizacionDolar").Value), 0, .Fields("CotizacionDolar").Value)
         txtCotizacionDolar.Text = mvarCotizacion
         mvarCotizacionEuro = IIf(IsNull(.Fields("CotizacionEuro").Value), 0, .Fields("CotizacionEuro").Value)
         txtCotizacionEuro.Text = mvarCotizacionEuro
         txtCotizacionMoneda.Text = IIf(IsNull(.Fields("CotizacionMoneda").Value), 0, .Fields("CotizacionMoneda").Value)
         If Not IsNull(.Fields("Dolarizada").Value) And .Fields("Dolarizada").Value = "SI" Then
            Check1.Value = 1
          Else
            Check1.Value = 0
         End If
         If Not IsNull(.Fields("Exterior").Value) And .Fields("Exterior").Value = "SI" Then
            Check2.Value = 1
         Else
            Check2.Value = 0
         End If
         If Not IsNull(.Fields("AsientoManual").Value) And .Fields("AsientoManual").Value = "SI" Then
            Check3.Value = 1
          Else
            Check3.Value = 0
         End If
         If Not IsNull(.Fields("Efectivo").Value) And .Fields("Efectivo").Value <> 0 Then
            With Label2
               .Caption = "Efectivo:"
               .Visible = True
            End With
            txtEfectivo.Visible = True
         End If
         If Not IsNull(.Fields("IdOPComplementariaFF").Value) Then
            Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PorId", .Fields("IdOPComplementariaFF").Value)
            If oRs.RecordCount > 0 Then
               txtNumeroOPComplementariaFF.Text = oRs.Fields("NumeroOrdenPago").Value
               txtTotalOPComplementariaFF.Text = oRs.Fields("Valores").Value
            End If
            oRs.Close
         End If
         If IsNull(.Fields("CalculaSUSS").Value) Or .Fields("CalculaSUSS").Value = "SI" Then
            Check5.Value = 1
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
         If Not IsNull(.Fields("OPInicialFF").Value) And .Fields("OPInicialFF").Value = "SI" Then
            Check8.Value = 1
         End If
      End With
      Frame1.Enabled = False
      Check6.Visible = True
'      txtEfectivo.Enabled = False
'      txtRetIva.Enabled = False
      txtRetGan.Enabled = False
'      txtGasGen.Enabled = False
'      txtIngBru.Enabled = False
'      txtDto.Enabled = False
'      txtBaseGanancias.Enabled = False
'      cmd(0).Enabled = False
'      cmd(6).Visible = False
      CalcularRetencionGanancias
      CalcularRetencionSUSS
      CalculaTotales
'      ActualizaListaContable
      MostrarDiferenciaCambio
      mvarGrabado = True
      cmdGuardarRubros.Enabled = True
   End If
   
   txtCotizacion.Text = mvarCotizacion
   
   Set oRs = Nothing
   Set oAp = Nothing

   cmd(0).Enabled = False
   cmd(5).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      cmd(5).Enabled = True
   End If
   
   If mvarAnulada = "SI" Then
      cmd(0).Enabled = False
      cmd(5).Enabled = False
   Else
      If DTFields(0).Value <= gblFechaUltimoCierre And _
            Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
         cmd(0).Enabled = False
         cmd(5).Enabled = False
      End If
   End If

End Property

Private Sub cmdBuscarPorCuit_Click()

   If oF_BuscarPorCuit Is Nothing Then Set oF_BuscarPorCuit = New frm_Aux
   With oF_BuscarPorCuit
      .Id = 18
      .Disparar = ActL3
      .Show , Me
   End With

End Sub

Private Sub cmdGuardarRubros_Click()

   Dim oRs As ADOR.Recordset
   Dim mEliminado As String
   
   If mvarTotalValores <> mvarTotalRubrosContables And (Not Frame2.Visible Or (Frame2.Visible And Option5.Value)) Then
      MsgBox "El total de rubros contables asignados debe ser igual al total de valores", vbExclamation
      Exit Sub
   End If
   
   Set oRs = origen.DetOrdenesPagoRubrosContables.Registros
   With oRs
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               mEliminado = ""
               If .Fields("Eliminado").Value Then mEliminado = "SI"
               Aplicacion.Tarea "DetOrdenesPagoRubrosContables_Actualizar", Array(.Fields(0).Value, mvarId, .Fields("IdRubroContable").Value, .Fields("Importe").Value, mEliminado)
               oRs.MoveNext
            Loop
         End If
      End If
   End With
   Set oRs = Nothing

End Sub

Private Sub cmdImpre_Click(Index As Integer)

   DoEvents
   
   If Not mvarGrabado Then
      MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
      Exit Sub
   End If
   
   On Error GoTo Mal
   
   Dim mvarConCotizacion As Boolean
   mvarConCotizacion = False
   Dim oF1 As frm_Aux
   Set oF1 = New frm_Aux
   With oF1
      .Caption = "Emision de Orden de Pago"
      .Label1.Visible = False
      .Text1.Visible = False
      With .Frame1
         .Caption = "Emite cotizacion dolar ? : "
         .Top = oF1.Label1.Top
         .Visible = True
      End With
      .Option1.Caption = "SI"
      .Option1.Value = True
      .Option2.Caption = "NO"
      .Show vbModal, Me
      mvarConCotizacion = .Option1.Value
   End With
   Unload oF1
   Set oF1 = Nothing
   Me.Refresh
   
   Dim mvarOK As Boolean
   Dim mCopias As Integer
   Dim mPrinter As String, mPrinterAnt As String
   
   mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
   If Index = 0 Then
      mCopias = Val(BuscarClaveINI("CopiasOrdenesPago"))
      If mCopias = 0 Then mCopias = 2
      
      Dim oF As frmCopiasImpresion
      Set oF = New frmCopiasImpresion
      With oF
         .txtCopias.Text = mCopias
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

'   mPrinterSeleccionada = mPrinter
'   EmisionOrdenPago "OrdenesPago", mvarId, "||" & Index & "|||" & mCopias & "|||" & _
                     IIf(mvarConCotizacion, "SI", "NO") & "|" & _
                     mPrinterAnt & "|" & mPrinter

   Dim mAuxS1 As String, mAuxS2 As String, mDestino As String
   
   mAuxS2 = BuscarClaveINI("No mostrar imputaciones en OP fondo fijo")
   If Index = 0 Then
      mDestino = "Printer"
   Else
      mDestino = "Word"
   End If
   mAuxS1 = "||" & Index & "|||" & mCopias & "|||" & IIf(mvarConCotizacion, "SI", "NO") & "|" & _
                     mPrinterAnt & "|" & mPrinter & "|" & mAuxS2
   
   Dim oW As Word.Application
   Dim mPID As String
   
   If Index = 0 Then CargaProcesosEnEjecucion
   Set oW = CreateObject("Word.Application")
   If Index = 0 Then mPID = ObtenerPIDProcesosLanzados
   
   With oW
      .Visible = True
      With .Documents.Add(glbPathPlantillas & "\OrdenPago_" & glbEmpresaSegunString & ".dot")
         oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId, varg3:=mAuxS1
         oW.Application.Run MacroName:="DatosDelPie"
         oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
         If Index = 0 Then
            If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
            oW.Documents(1).PrintOut False, , , , , , , mCopias
            If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
            oW.Documents(1).Close False
            If glbTerminarProcesosOffice Then
               TerminarProceso mPID
            Else
               oW.Quit
            End If
         End If
      End With
   End With
   
   'ConvertToPDF oW
   
   If Not IsNull(origen.Registro.Fields("RetencionGanancias").Value) And origen.Registro.Fields("RetencionGanancias").Value <> 0 Then
      EmisionCertificadoRetencionGanancias mvarId, mDestino, mPrinter
   End If
   
   If Not IsNull(origen.Registro.Fields("RetencionIVA").Value) And origen.Registro.Fields("RetencionIVA").Value <> 0 Then
      EmisionCertificadoRetencionIVA mvarId, mDestino, mPrinter
   End If
   
   If Not IsNull(origen.Registro.Fields("RetencionIBrutos").Value) And origen.Registro.Fields("RetencionIBrutos").Value <> 0 Then
      EmisionCertificadoRetencionIIBB mvarId, mDestino, mPrinter
   End If
   
   If Not IsNull(origen.Registro.Fields("RetencionSUSS").Value) And origen.Registro.Fields("RetencionSUSS").Value <> 0 Then
      EmisionCertificadoRetencionSUSS mvarId, mDestino, mPrinter
   End If

Salida:
   Set oW = Nothing
   Exit Sub

Mal:
   MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical
   Resume Salida

End Sub

Private Sub cmdVerOtrasOp_Click()

   Dim oF As frm_Aux
   Set oF = New frm_Aux
   With oF
      .Caption = "Op's con rendicion " & txtNumeroRendicionFF.Text
      With .RichTextBox1
         .Top = 0
         .Left = 0
         .Width = oF.Width
         .Height = oF.Height - (oF.cmd(0).Height * 2.5)
         .TextRTF = mRendicionesFF
         .Visible = True
      End With
      .cmd(0).Visible = False
      With .cmd(1)
         .Left = oF.cmd(0).Left
         .Caption = "Salir"
      End With
      .Show vbModal, Me
   End With
   Unload oF
   Set oF = Nothing

End Sub

Private Sub dcfields_Change(Index As Integer)

   If IsNumeric(dcfields(Index).BoundText) Then
      origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
      
      Dim oRs As ADOR.Recordset
      Dim oRsAux As ADOR.Recordset
      
      Select Case Index
         Case 0
            mvarExceptuadoRetencionIVA = 0
            mvarTipoIVA = 0
            mvarCodigoSituacionRetencionIVA = 0
'            mvarOP_AnticiposAlPersonal = False
            
            If Option1.Value Then
               Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", dcfields(Index).BoundText)
               
               If Not IsNull(oRs.Fields("IdCodigoIva").Value) Then
                  mvarTipoIVA = oRs.Fields("IdCodigoIva").Value
               End If
               If Not IsNull(oRs.Fields("IvaExencionRetencion").Value) And oRs.Fields("IvaExencionRetencion").Value = "SI" Then
                  mvarExceptuadoRetencionIVA = 100
               Else
                  If IsNull(oRs.Fields("IvaFechaInicioExencion").Value) Or _
                        oRs.Fields("IvaFechaInicioExencion").Value <= DTFields(0).Value Then
                     If Not IsNull(oRs.Fields("IvaFechaCaducidadExencion").Value) And _
                           oRs.Fields("IvaFechaCaducidadExencion").Value >= DTFields(0).Value Then
                        If Not IsNull(oRs.Fields("IvaPorcentajeExencion").Value) Then
                           mvarExceptuadoRetencionIVA = oRs.Fields("IvaPorcentajeExencion").Value
                        End If
                     End If
                  End If
               End If
               
               If Not IsNull(oRs.Fields("CodigoSituacionRetencionIVA").Value) Then
                  mvarCodigoSituacionRetencionIVA = Val(oRs.Fields("CodigoSituacionRetencionIVA").Value)
               End If
               
               mRegimenEspecialConstruccionIIBB = ""
               If Not IsNull(oRs.Fields("RegimenEspecialConstruccionIIBB").Value) Then
                  mRegimenEspecialConstruccionIIBB = oRs.Fields("RegimenEspecialConstruccionIIBB").Value
               End If

               If IsNull(oRs.Fields("IBCondicion").Value) Or oRs.Fields("IBCondicion").Value = 4 Then
                  mvarRetenerIIBB = False
               ElseIf oRs.Fields("IBCondicion").Value = 1 And _
                     (IsNull(oRs.Fields("FechaLimiteExentoIIBB").Value) Or oRs.Fields("FechaLimiteExentoIIBB").Value >= DTFields(0).Value) Then
                  mvarRetenerIIBB = False
               Else
                  mvarRetenerIIBB = True
               End If
               
               mvarSUSSFechaCaducidadExencion = IIf(IsNull(oRs.Fields("SUSSFechaCaducidadExencion").Value), Date, oRs.Fields("SUSSFechaCaducidadExencion").Value)
               If Me.Visible Then
                  With origen.Registro
                     .Fields("TextoAuxiliar1").Value = IIf(IsNull(oRs.Fields("TextoAuxiliar1").Value), "", oRs.Fields("TextoAuxiliar1").Value)
                     .Fields("TextoAuxiliar2").Value = IIf(IsNull(oRs.Fields("TextoAuxiliar2").Value), "", oRs.Fields("TextoAuxiliar2").Value)
                     .Fields("TextoAuxiliar3").Value = IIf(IsNull(oRs.Fields("TextoAuxiliar3").Value), "", oRs.Fields("TextoAuxiliar3").Value)
                  End With
               End If
               
               mvarIdImpuestoDirectoSUSS = 0
               mvarTopeAnualSUSS = 0
               If Not IsNull(oRs.Fields("RetenerSUSS").Value) Then
                  mvarRetenerSUSSAProveedor = IIf(IsNull(oRs.Fields("RetenerSUSS").Value), "NO", oRs.Fields("RetenerSUSS").Value)
                  If mvarRetenerSUSSAProveedor = "SI" And Not Check5.Enabled Then
                     With Check5
                        .Enabled = True
                        .Value = 1
                     End With
                  End If
                  mvarPorcentajeRetencionSUSS1 = 0
                  mvarImporteMinimoBaseRetencionSUSS = 0
                  If Not IsNull(oRs.Fields("IdImpuestoDirectoSUSS").Value) Then
                     mvarIdImpuestoDirectoSUSS = oRs.Fields("IdImpuestoDirectoSUSS").Value
                     Set oRsAux = Aplicacion.ImpuestosDirectos.TraerFiltrado("_PorId", oRs.Fields("IdImpuestoDirectoSUSS").Value)
                     If oRsAux.RecordCount > 0 Then
                        mvarPorcentajeRetencionSUSS1 = IIf(IsNull(oRsAux.Fields("Tasa").Value), 0, oRsAux.Fields("Tasa").Value)
                        mvarImporteMinimoBaseRetencionSUSS = IIf(IsNull(oRsAux.Fields("BaseMinima").Value), 0, oRsAux.Fields("BaseMinima").Value)
                        mvarTopeAnualSUSS = IIf(IsNull(oRsAux.Fields("TopeAnual").Value), 0, oRsAux.Fields("TopeAnual").Value)
                     End If
                     oRsAux.Close
                     Set oRsAux = Nothing
                  Else
                     mvarPorcentajeRetencionSUSS1 = -1
                  End If
               Else
                  mvarRetenerSUSSAProveedor = "NO"
               End If
               
               If Not IsNull(oRs.Fields("IGCondicion").Value) Then
                  If oRs.Fields("IGCondicion").Value = mIGCondicionExcepcion And _
                        (IsNull(oRs.Fields("FechaLimiteExentoGanancias").Value) Or _
                         oRs.Fields("FechaLimiteExentoGanancias").Value >= DTFields(0).Value) Then
'                     cmd(6).Visible = False
                     cmd(7).Visible = False
'                     lblRetencion(0).Visible = False
'                     txtBaseGanancias.Visible = False
                     origen.Registro.Fields("BaseGanancias").Value = Null
                     mvarRetenerGanancias = False
                  Else
                     If IsNull(oRs.Fields("IdTipoRetencionGanancia").Value) Then
                        MsgBox "El proveedor no tiene definido el tipo de retencion para ganancias!", vbExclamation
                        origen.Registro.Fields(dcfields(Index).DataField).Value = Null
                        dcfields(Index).BoundText = ""
                     Else
'                        cmd(6).Visible = True
                        cmd(7).Visible = True
'                        lblRetencion(0).Visible = True
'                        txtBaseGanancias.Visible = True
                        If mvarId > 0 Then
                           oRs.Close
                           Set oRs = origen.DetOrdenesPago.TodosLosRegistros
                           If oRs.Fields.Count > 0 Then
                              If oRs.RecordCount > 0 Then
                                 oRs.MoveFirst
                                 Do While Not oRs.EOF
                                    origen.DetOrdenesPago.Item(oRs.Fields(0).Value).Modificado = True
                                    oRs.MoveNext
                                 Loop
                              End If
                           End If
                        End If
                        mvarRetenerGanancias = True
                     End If
                  End If
               Else
                  MsgBox "El proveedor no tiene definida la categoria de retencion para ganancias!", vbExclamation
                  origen.Registro.Fields(dcfields(Index).DataField).Value = Null
                  dcfields(Index).BoundText = ""
               End If
               
               If oRs.State <> 0 Then oRs.Close
               Set oRs = Nothing
            
               If IsNumeric(dcfields(Index).BoundText) Then
                  If EstadoEntidad("Proveedores", dcfields(Index).BoundText) = "INACTIVO" Then
                     MsgBox "Proveedor inhabilitado, no podra registrar este comprobante", vbExclamation
                  End If
               End If
            
            ElseIf Option2.Value Then
               txtNumeroRendicionFF.ToolTipText = MostrarRendicionesFF
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorIdConDatos", dcfields(Index).BoundText)
               If oRs.RecordCount > 0 Then
                  txtCodigoCuenta.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
                  If Me.Visible Then
                     With origen.Registro
                        .Fields("TextoAuxiliar1").Value = IIf(IsNull(oRs.Fields("TextoAuxiliar1").Value), "", oRs.Fields("TextoAuxiliar1").Value)
                        .Fields("TextoAuxiliar2").Value = IIf(IsNull(oRs.Fields("TextoAuxiliar2").Value), "", oRs.Fields("TextoAuxiliar2").Value)
                        .Fields("TextoAuxiliar3").Value = IIf(IsNull(oRs.Fields("TextoAuxiliar3").Value), "", oRs.Fields("TextoAuxiliar3").Value)
                     End With
                  End If
               End If
               oRs.Close
               Set oRs = Nothing

            ElseIf Option3.Value Then
               If mvarId <= 0 Then
                  Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorIdConDatos", dcfields(Index).BoundText)
                  If oRs.RecordCount > 0 Then
                     If IIf(IsNull(oRs.Fields("EsCajaBanco").Value), "", oRs.Fields("EsCajaBanco").Value) = "BA" Then
                        Option4.Value = True
                     Else
                        Option5.Value = True
                     End If
                     txtCodigoCuenta.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
                     If Me.Visible Then
                        With origen.Registro
                           .Fields("TextoAuxiliar1").Value = IIf(IsNull(oRs.Fields("TextoAuxiliar1").Value), "", oRs.Fields("TextoAuxiliar1").Value)
                           .Fields("TextoAuxiliar2").Value = IIf(IsNull(oRs.Fields("TextoAuxiliar2").Value), "", oRs.Fields("TextoAuxiliar2").Value)
                           .Fields("TextoAuxiliar3").Value = IIf(IsNull(oRs.Fields("TextoAuxiliar3").Value), "", oRs.Fields("TextoAuxiliar3").Value)
                        End With
                     End If
                  End If
                  oRs.Close
               End If
               Set oRs = Nothing
'               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorId", dcfields(Index).BoundText)
'               If oRs.RecordCount > 0 Then
'                  If Not IsNull(oRs.Fields("IdTipoCuentaGrupo").Value) Then
'                     If oRs.Fields("IdTipoCuentaGrupo").Value = mvarIdTipoCuentaGrupoAnticiposAlPersonal Then
'                        Lista.Visible = False
'                        ListaGastos.Visible = False
'                        With ListaAnticipos
'                           .Top = Lista.Top
'                           .Left = Lista.Left
'                           .Width = Lista.Width
'                           .Height = Lista.Height
'                           .Visible = True
'                        End With
'                        mvarOP_AnticiposAlPersonal = True
'                     Else
'                        Dim oL As ListItem
'                        With ListaAnticipos
'                           If .ListItems.Count > 0 Then
'                              For Each oL In .ListItems
'                                 origen.DetOrdenesPagoAnticipos.Item(oL.Tag).Eliminado = True
'                              Next
'                           End If
'                           .ListItems.Clear
'                           .Visible = False
'                        End With
'                        ListaGastos.Visible = False
'                        Lista.Visible = True
'                     End If
'                  End If
'               End If
'               oRs.Close
'               Set oRs = Nothing
            End If
      End Select
   End If
   
End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   SetDataComboDropdownListWidth 400

End Sub

Private Sub dcfields_GotFocus(Index As Integer)

   With dcfields(0)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   If Not IsNumeric(dcfields(Index).BoundText) Then SendKeys "%{DOWN}"

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub dcfields_Validate(Index As Integer, Cancel As Boolean)

   Dim oRs As ADOR.Recordset
   
   Select Case Index
      Case 3
         If CambioDeMonedaValido(dcfields(Index).BoundText) Then
            If dcfields(Index).BoundText = mvarIdMonedaPesos Then
               cmd(8).Enabled = True
               txtCotizacionMoneda.Text = 1
            Else
               cmd(8).Enabled = False
               Set oRs = Aplicacion.Cotizaciones.TraerFiltrado("_PorFechaMoneda", Array(DTFields(0).Value, dcfields(Index).BoundText))
               If oRs.RecordCount > 0 Then
                  txtCotizacionMoneda.Text = oRs.Fields("CotizacionLibre").Value
                  If dcfields(Index).BoundText = mvarIdMonedaDolar Then
                     txtCotizacionDolar.Text = oRs.Fields("CotizacionLibre").Value
                  ElseIf dcfields(Index).BoundText = glbIdMonedaEuro Then
                     txtCotizacionEuro.Text = oRs.Fields("CotizacionLibre").Value
                  End If
               Else
                  MsgBox "No hay cotizacion, ingresela manualmente"
                  txtCotizacionMoneda.Text = ""
               End If
               oRs.Close
               Set oRs = Nothing
            End If
            CalcularRetencionGanancias
            CalcularRetencionIngresosBrutos
            CalcularRetencionSUSS
            CalculaTotales
            MostrarDiferenciaCambio
         Else
            MsgBox "Existen valores en la moneda original, no puede cambiar a otra moneda"
            Cancel = True
         End If
   End Select
      
End Sub

Private Sub dcfields1_Change(Index As Integer)

   If IsNumeric(dcfields1(Index).BoundText) Then
      Dim oRs As ADOR.Recordset
      Select Case Index
         Case 0
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_CuentasGastoPorObraParaCombo", dcfields1(Index).BoundText)
            Set dcfields1(1).RowSource = oRs
            Set oRs = Nothing
            With origen.Registro
               If Not IsNull(.Fields(dcfields1(1).DataField).Value) Then
                  dcfields1(1).BoundText = .Fields(dcfields1(1).DataField).Value
               End If
               If Len(dcfields1(1).Text) = 0 Then dcfields(0).Enabled = True
            End With
      End Select
   End If

End Sub

Private Sub dcfields1_Click(Index As Integer, Area As Integer)

   SetDataComboDropdownListWidth 400
   
   If IsNumeric(dcfields1(Index).BoundText) Then
      If Len(dcfields1(Index).DataField) > 0 Then origen.Registro.Fields(dcfields1(Index).DataField).Value = dcfields1(Index).BoundText
      Dim oRs As ADOR.Recordset
      Select Case Index
         Case 0
            If Not dcfields1(1).Enabled Then
               dcfields1(1).Enabled = True
            End If
         Case 1
            If dcfields1(Index).Enabled Then
               If Not IsNumeric(dcfields1(0).BoundText) Then
                  MsgBox "Debe definir la obra", vbExclamation
                  origen.Registro.Fields(dcfields1(Index).DataField).Value = Null
                  Exit Sub
               End If
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorObraCuentaGasto", _
                     Array(dcfields1(0).BoundText, dcfields1(1).BoundText))
               If oRs.RecordCount > 0 Then
                  If Len(dcfields1(2).Text) > 0 Then
                     dcfields1(2).BoundText = 0
                     Set dcfields(0).RowSource = Aplicacion.Cuentas.TraerLista
                  End If
                  With origen.Registro
                     .Fields(dcfields1(Index).DataField).Value = oRs.Fields("IdCuentaGasto").Value
                     .Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
                     dcfields(0).BoundText = oRs.Fields("IdCuenta").Value
                  End With
               End If
               oRs.Close
               Set oRs = Nothing
            Else
               origen.Registro.Fields(dcfields1(Index).DataField).Value = Null
            End If
            dcfields(0).Enabled = False
            dcfields1(2).Enabled = False
            Check4.Value = 1
         Case 2
            Dim mIdCuenta As Long
            If IsNumeric(dcfields(0).BoundText) Then
               mIdCuenta = dcfields(0).BoundText
            Else
               mIdCuenta = 0
            End If
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorGrupoParaCombo", dcfields1(Index).BoundText)
            Set dcfields(0).RowSource = oRs
            origen.Registro.Fields(dcfields(0).DataField).Value = mIdCuenta
            dcfields(0).BoundText = mIdCuenta
            Set oRs = Nothing
      End Select
   End If
   
End Sub

Private Sub dcfields1_Validate(Index As Integer, Cancel As Boolean)

   If IsNumeric(dcfields1(Index).BoundText) Then
      Dim oRs As ADOR.Recordset
      Select Case Index
         Case 0
            Option3_Click
      End Select
   End If

End Sub

Private Sub DTFields_Change(Index As Integer)

   If Index = 0 Then
      mvarCotizacion = Cotizacion(DTFields(Index).Value, glbIdMonedaDolar)
      txtCotizacion.Text = mvarCotizacion
      If mvarId <= 0 Then
         txtCotizacionDolar.Text = mvarCotizacion
         mvarCotizacionEuro = Cotizacion(DTFields(Index).Value, glbIdMonedaEuro)
         txtCotizacionEuro.Text = mvarCotizacionEuro
      End If
   End If
   If Len(DTFields(Index).DataField) > 0 Then
      origen.Registro.Fields(DTFields(Index).DataField).Value = DTFields(Index).Value
   End If

End Sub

Private Sub DTFields_Click(Index As Integer)

   If Index = 0 Then
      mvarCotizacion = Cotizacion(DTFields(Index).Value, glbIdMonedaDolar)
      txtCotizacion.Text = mvarCotizacion
      If mvarId <= 0 Then
         txtCotizacionDolar.Text = mvarCotizacion
         mvarCotizacionEuro = Cotizacion(DTFields(Index).Value, glbIdMonedaEuro)
         txtCotizacionEuro.Text = mvarCotizacionEuro
      End If
   End If

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub DTFields_Validate(Index As Integer, Cancel As Boolean)

   If glbSeñal1 And Index = 0 Then
      Dim mIdAux As Long
      mIdAux = 0
      If IsNumeric(dcfields1(0).BoundText) Then mIdAux = dcfields1(0).BoundText
      Set dcfields1(0).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", DTFields(0).Value))
      dcfields1(0).BoundText = mIdAux
      If Option3.Value Then
         mIdAux = 0
         If IsNumeric(dcfields(0).BoundText) Then mIdAux = dcfields(0).BoundText
         Set dcfields(0).RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorFechaParaCombo", DTFields(0).Value)
         dcfields(0).BoundText = mIdAux
      End If
   End If

End Sub

Private Sub Form_Activate()

   Dim mCual As String
   
   mCual = ""
   If mvarCotizacion = 0 And mvarCotizacionEuro = 0 Then
      mCual = "dolar y euro"
   ElseIf mvarCotizacion = 0 Then
      mCual = "dolar"
   ElseIf mvarCotizacionEuro = 0 Then
      mCual = "euro"
   End If
   If Len(mCual) > 0 Then
      Me.Refresh
      If mvarId <= 0 Then
         MsgBox "No hay cotizacion " & mCual & ", ingresela primero", vbExclamation
         Unload Me
      Else
'         MsgBox "No hay cotizacion", vbExclamation
      End If
   End If

End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)

   'F11 para llamar el formulario de busqueda de proveedores por cuit
   If KeyCode = 122 Then
      cmdBuscarPorCuit_Click
   End If

End Sub

Private Sub Form_Load()

   Set ActL3 = New ControlForm
   
   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaVal
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaCta
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaGastos
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaAnticipos
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaImpuestos
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With

   With ListaRubrosContables
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With

   For Each oI In Img16.ListImages
      With Estado.Panels.Add(, , oI.Key)
         .Picture = oI.Picture
      End With
   Next

   mControlLoop = False
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   If mvarAnuloValor Then
      MsgBox "Ha anulado uno o varios valores, debe grabar la op para salir", vbExclamation
      Cancel = 1
   End If

   If Not oF_BuscarPorCuit Is Nothing Then
      Unload oF_BuscarPorCuit
      Set oF_BuscarPorCuit = Nothing
   End If

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set ActL3 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   Set cALetra = Nothing
   
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

Private Sub ListaAnticipos_DblClick()
   
   If Not ListaAnticipos.SelectedItem Is Nothing Then
      If IsNumeric(ListaAnticipos.SelectedItem.Tag) And Option3.Value Then
         If ListaAnticipos.ListItems.Count = 0 Then
            EditarAnticipo -1
         Else
            EditarAnticipo ListaAnticipos.SelectedItem.Tag
         End If
      End If
   End If

End Sub

Private Sub ListaAnticipos_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaAnticipos_KeyUp(KeyCode As Integer, Shift As Integer)

   If Option3.Value Then
      If KeyCode = vbKeyDelete Then
         MnuDetD_Click 2
      ElseIf KeyCode = vbKeyInsert Then
         MnuDetD_Click 0
      ElseIf KeyCode = vbKeySpace Then
         MnuDetD_Click 1
      End If
   End If

End Sub

Private Sub ListaAnticipos_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   
   If Button = vbRightButton And Option3.Value Then
      If ListaAnticipos.ListItems.Count = 0 Then
         MnuDetD(1).Enabled = False
         MnuDetD(2).Enabled = False
         PopupMenu MnuDetAnticipo, , , , MnuDetD(0)
      Else
         MnuDetD(1).Enabled = True
         MnuDetD(2).Enabled = True
         PopupMenu MnuDetAnticipo, , , , MnuDetD(1)
      End If
   End If

End Sub

Private Sub ListaCta_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaGastos_Click()

   Dim oL As ListItem
   Dim mTotalGtos As Double
   
   mTotalGtos = 0
   For Each oL In ListaGastos.ListItems
      If oL.Selected And IsNumeric(oL.SubItems(11)) Then
         mTotalGtos = mTotalGtos + Val(oL.SubItems(11))
      End If
   Next
   ListaGastos.ToolTipText = "Total seleccionado :" & Format(mTotalGtos, "#,##0.00")

End Sub

Private Sub ListaGastos_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaGastos_ItemCheck(ByVal Item As MSComctlLib.IListItem)

   If Not mvarControlCheck Then Exit Sub
   If Item.Checked Then
      Dim oRs As ADOR.Recordset
      Dim mvarIdMonedaCP_FF As Integer, mvarIdTipoComprobanteCP_FF As Integer
      Dim i As Integer
      Dim mvarMonedaCP_FF As String
      Dim Filas
      Dim Columnas
      
      Filas = VBA.Split(ListaGastos.GetStringCheck, vbCrLf)
      For i = LBound(Filas) + 1 To UBound(Filas)
         Columnas = VBA.Split(Filas(i), vbTab)
         Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorId", Columnas(15))
         If oRs.RecordCount > 0 Then
            mvarIdMonedaCP_FF = oRs.Fields("IdMoneda").Value
            mvarIdTipoComprobanteCP_FF = oRs.Fields("IdTipoComprobante").Value
            oRs.Close
            mvarMonedaCP_FF = ""
'            Set oRs = Aplicacion.Monedas.TraerFiltrado("_PorId", mvarIdMonedaCP_FF)
'            If oRs.RecordCount > 0 Then
'               mvarMonedaCP_FF = oRs.Fields("Nombre").Value
'            End If
'            oRs.Close
            Set oRs = Nothing
            If origen.Registro.Fields("IdMoneda").Value <> mvarIdMonedaCP_FF And _
                  Not (mvarIdTipoComprobanteCP_FF = mvarIdTipoComprobanteNDInternaAcreedores Or _
                        mvarIdTipoComprobanteCP_FF = mvarIdTipoComprobanteNCInternaAcreedores) Then
               MsgBox "La orden de pago y el comprobante deben tener la misma moneda", vbExclamation
                      '"El comprobante esta en " & mvarMonedaCP_FF, vbExclamation
               Item.Checked = False
               Exit Sub
            End If
         Else
            oRs.Close
         End If
      Next
      Set oRs = Nothing
   End If
   
   CalculaTotales
   
End Sub

Private Sub ListaGastos_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)

   If Button = vbRightButton Then
      PopupMenu MnuDetGastos, , , , MnuDetG(0)
   End If

End Sub

Private Sub ListaImpuestos_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaRubrosContables_DblClick()

   If Not ListaRubrosContables.SelectedItem Is Nothing Then
      If IsNumeric(ListaRubrosContables.SelectedItem.Tag) Then
         If ListaRubrosContables.ListItems.Count = 0 Then
            EditarRubroContable -1
         Else
            EditarRubroContable ListaRubrosContables.SelectedItem.Tag
         End If
      End If
   End If

End Sub

Private Sub ListaRubrosContables_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaRubrosContables_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetE_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetE_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetE_Click 1
   End If

End Sub

Private Sub ListaRubrosContables_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)

   If Button = vbRightButton Then
      If ListaRubrosContables.ListItems.Count = 0 Then
         MnuDetE(1).Enabled = False
         MnuDetE(2).Enabled = False
         PopupMenu MnuDetRubroContable, , , , MnuDetE(0)
      Else
         MnuDetE(1).Enabled = True
         MnuDetE(2).Enabled = True
         PopupMenu MnuDetRubroContable, , , , MnuDetE(1)
      End If
   End If

End Sub

Private Sub ListaRubrosContables_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single)

   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long, NroItem As Long, idDet As Long
   Dim s As String, mExiste As String

   If Data.GetFormat(ccCFText) Then
      
      Dim oRs As ADOR.Recordset
      Dim oL As ListItem
      
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 2), "Rubro") <> 0 Then
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            Set oRs = Aplicacion.RubrosContables.TraerFiltrado("_PorId", Columnas(0))
            If oRs.RecordCount > 0 Then
               If IsNull(oRs.Fields("Financiero").Value) Or oRs.Fields("Financiero").Value <> "SI" Then
                  oRs.Close
                  Set oRs = Nothing
                  MsgBox "Solo puede incluir rubros financieros", vbExclamation
                  Exit Sub
               End If
               If Not (IsNull(oRs.Fields("IngresoEgreso").Value) Or oRs.Fields("IngresoEgreso").Value = "E") Then
                  oRs.Close
                  Set oRs = Nothing
                  MsgBox "Solo puede incluir rubros de egresos", vbExclamation
                  Exit Sub
               End If
               With origen.DetOrdenesPagoRubrosContables.Item(-1)
                  .Registro.Fields("IdRubroContable").Value = oRs.Fields("IdRubroContable").Value
                  .Registro.Fields("Importe").Value = 0
                  .Modificado = True
                  idDet = .Id
               End With
               Set oL = ListaRubrosContables.ListItems.Add
               oL.Tag = idDet
               With oL
                  .SmallIcon = "Nuevo"
                  .Text = "" & oRs.Fields("Descripcion").Value
               End With
            End If
            oRs.Close
            Set oRs = Nothing
         Next

         Clipboard.Clear

      Else
         
         MsgBox "Objeto invalido!"
         Exit Sub
      
      End If

   End If
   
End Sub

Private Sub ListaRubrosContables_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single, State As Integer)

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

Private Sub ListaRubrosContables_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub ListaVal_DblClick()
   
   If Not ListaVal.SelectedItem Is Nothing Then
      If IsNumeric(ListaVal.SelectedItem.Tag) Then
         If ListaVal.ListItems.Count = 0 Then
            EditarVal -1
         Else
            EditarVal ListaVal.SelectedItem.Tag
         End If
      End If
   End If

End Sub

Private Sub ListaVal_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaVal_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetB_Click 3
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetB_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetB_Click 2
   End If

End Sub

Private Sub ListaVal_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   
   If Button = vbRightButton Then
      If ListaVal.ListItems.Count = 0 Then
         MnuDetB(2).Enabled = False
         MnuDetB(3).Enabled = False
         PopupMenu MnuDetVal, , , , MnuDetB(0)
      Else
         MnuDetB(0).Enabled = True
         MnuDetB(1).Enabled = True
         MnuDetB(2).Enabled = True
         MnuDetB(3).Enabled = True
         PopupMenu MnuDetVal, , , , MnuDetB(2)
      End If
   End If

End Sub

Private Sub ListaVal_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single)

   If Not IsNumeric(dcfields(3).BoundText) Then
      MsgBox "Defina la moneda primero", vbExclamation
      Exit Sub
   End If
   
   Dim Filas, Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long, NroItem As Long, idDet As Long
   Dim s As String, mExiste As String, mError As String

   If Data.GetFormat(ccCFText) Then
      Dim oAp As ComPronto.Aplicacion
      Dim oRsDet As ADOR.Recordset
      Dim oL As ListItem
      
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 1), "valor") <> 0 Then
         Set oAp = Aplicacion
         mError = ""
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            Set oRsDet = oAp.Valores.Item(Columnas(2)).Registro
            If oRsDet.RecordCount > 0 Then
               If oRsDet.Fields("IdMoneda").Value <> dcfields(3).BoundText Then
                  mError = mError & vbCrLf & "El valor " & IIf(IsNull(oRsDet.Fields("NumeroValor").Value), "", oRsDet.Fields("NumeroValor").Value) & _
                                 " no tiene la misma moneda de la OP y no fue tomado"
               Else
                  With origen.DetOrdenesPagoValores.Item(-1)
                     .Registro.Fields("IdValor").Value = oRsDet.Fields("IdValor").Value
                     .Registro.Fields("IdTipoValor").Value = oRsDet.Fields("IdTipoValor").Value
                     .Registro.Fields("NumeroValor").Value = oRsDet.Fields("NumeroValor").Value
                     .Registro.Fields("FechaVencimiento").Value = oRsDet.Fields("FechaValor").Value
                     .Registro.Fields("NumeroInterno").Value = oRsDet.Fields("NumeroInterno").Value
                     .Registro.Fields("IdBanco").Value = oRsDet.Fields("IdBanco").Value
                     .Registro.Fields("Importe").Value = oRsDet.Fields("Importe").Value
                     .Modificado = True
                     idDet = .Id
                  End With
                  Set oL = ListaVal.ListItems.Add
                  oL.Tag = idDet
                  With oL
                     .SmallIcon = "Nuevo"
                     .Text = "" & oAp.TiposComprobante.Item(oRsDet.Fields("IdTipoValor").Value).Registro.Fields("Descripcion").Value & " (Terc.)"
                     .SubItems(1) = "" & .Tag
                     .SubItems(2) = "" & oRsDet.Fields("NumeroInterno").Value
                     .SubItems(3) = "" & oRsDet.Fields("NumeroValor").Value
                     .SubItems(4) = "" & oRsDet.Fields("FechaValor").Value
                     .SubItems(5) = "" & oAp.Bancos.Item(oRsDet.Fields("IdBanco").Value).Registro.Fields("Nombre").Value
                     .SubItems(6) = "" & oRsDet.Fields("Importe").Value
                  End With
               End If
            End If
            oRsDet.Close
            Set oRsDet = Nothing
         Next

         Set oAp = Nothing
         
         Clipboard.Clear

         CalculaTotales
      
         If Len(mError) > 0 Then MsgBox mError, vbInformation
      Else
         MsgBox "Objeto invalido!"
         Exit Sub
      End If
   End If
   
End Sub

Private Sub ListaVal_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single, State As Integer)

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

Private Sub ListaVal_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub ListaCta_DblClick()
   
   If Not ListaCta.SelectedItem Is Nothing Then
      If IsNumeric(ListaCta.SelectedItem.Tag) And Option3.Value Then
         If ListaCta.ListItems.Count = 0 Then
            EditarCta -1
         Else
            EditarCta ListaCta.SelectedItem.Tag
         End If
      End If
   End If

End Sub

Private Sub ListaCta_KeyUp(KeyCode As Integer, Shift As Integer)

   If Option3.Value Then
      If KeyCode = vbKeyDelete Then
         MnuDetC_Click 2
      ElseIf KeyCode = vbKeyInsert Then
         MnuDetC_Click 0
      ElseIf KeyCode = vbKeySpace Then
         MnuDetC_Click 1
      End If
   End If

End Sub

Private Sub ListaCta_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   
   If Button = vbRightButton And Option3.Value Then
      If ListaCta.ListItems.Count = 0 Then
         MnuDetC(1).Enabled = False
         MnuDetC(2).Enabled = False
         PopupMenu MnuDetCta, , , , MnuDetC(0)
      Else
         MnuDetC(1).Enabled = True
         MnuDetC(2).Enabled = True
         PopupMenu MnuDetCta, , , , MnuDetC(1)
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
'         If mvarId > 0 Then
'            MsgBox "No puede modificar un OrdenPago ya registrado!", vbCritical
'            Exit Sub
'         End If
         With Lista.SelectedItem
            origen.DetOrdenesPago.Item(.Tag).Eliminado = True
            .SubItems(5) = 0
            .SubItems(6) = 0
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         CalcularRetencionGanancias
         CalcularRetencionIVA
         CalcularRetencionIngresosBrutos
         CalcularRetencionSUSS
         CalculaTotales
         MostrarDiferenciaCambio
      Case 3
         If Not Lista.SelectedItem Is Nothing Then EditarImporte Lista.SelectedItem.Tag
      Case 4
         ImputacionAutomatica
      Case 5
         PagoAnticipado
      Case 6
         If Not Lista.SelectedItem Is Nothing Then
            If IsNumeric(Lista.SelectedItem.SubItems(20)) And IsNumeric(Lista.SelectedItem.SubItems(21)) Then
               EditarComprobante Lista.SelectedItem.SubItems(20), Lista.SelectedItem.SubItems(21)
            End If
         End If
   End Select

End Sub

Private Sub MnuDetB_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarVal -1
      Case 1
         EditarVal -2
      Case 2
         EditarVal ListaVal.SelectedItem.Tag
      Case 3
'         If mvarId > 0 Then
'            MsgBox "No puede modificar un OrdenPago ya registrado!", vbCritical
'            Exit Sub
'         End If
         With ListaVal.SelectedItem
            If origen.DetOrdenesPagoValores.Item(.Tag).ChequeDiferidoCaido Then
               MsgBox "No puede modificar el valor porque ya fue hecho el" & vbCrLf & _
                     "asiento de ajuste a bancos", vbCritical
               Exit Sub
            End If
            origen.DetOrdenesPagoValores.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         CalculaTotales
         MostrarDiferenciaCambio
      Case 4
         If Not ListaVal.SelectedItem Is Nothing Then AnularValor ListaVal.SelectedItem.Tag
   End Select

End Sub

Private Sub MnuDetC_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarCta -1
      Case 1
         EditarCta ListaCta.SelectedItem.Tag
      Case 2
'         If mvarId > 0 Then
'            MsgBox "No puede modificar un OrdenPago ya registrado!", vbCritical
'            Exit Sub
'         End If
         With ListaCta.SelectedItem
            origen.DetOrdenesPagoCuentas.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         CalculaTotales
         MostrarDiferenciaCambio
   End Select

End Sub

Private Sub MnuDetD_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarAnticipo -1
      Case 1
         EditarAnticipo ListaAnticipos.SelectedItem.Tag
      Case 2
'         If mvarId > 0 Then
'            MsgBox "No puede modificar un OrdenPago ya registrado!", vbCritical
'            Exit Sub
'         End If
         With ListaAnticipos.SelectedItem
            origen.DetOrdenesPagoAnticipos.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         CalculaTotales
   End Select

End Sub

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub MnuDetE_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarRubroContable -1
      Case 1
         EditarRubroContable ListaRubrosContables.SelectedItem.Tag
      Case 2
         With ListaRubrosContables.SelectedItem
            origen.DetOrdenesPagoRubrosContables.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         CalculaTotales
   End Select

End Sub

Private Sub MnuDetG_Click(Index As Integer)

   mvarControlCheck = False
   
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim mvarIdMonedaCP_FF As Integer, mvarIdTipoComprobanteCP_FF As Integer
   Dim mError As Boolean
   
   mError = False
   
   For Each oL In ListaGastos.ListItems
      If oL.Selected Then
         If Index = 0 Then
            If Not oL.Checked Then
               Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorId", oL.Tag)
               If oRs.RecordCount > 0 Then
                  mvarIdMonedaCP_FF = oRs.Fields("IdMoneda").Value
                  mvarIdTipoComprobanteCP_FF = oRs.Fields("IdTipoComprobante").Value
                  If origen.Registro.Fields("IdMoneda").Value <> mvarIdMonedaCP_FF And _
                        Not (mvarIdTipoComprobanteCP_FF = mvarIdTipoComprobanteNDInternaAcreedores Or _
                              mvarIdTipoComprobanteCP_FF = mvarIdTipoComprobanteNCInternaAcreedores) Then
                     mError = True
                  Else
                     oL.Checked = True
                  End If
               End If
               oRs.Close
            End If
         Else
            oL.Checked = False
         End If
      End If
   Next
   Set oRs = Nothing
   
   If mError Then
      MsgBox "Algun item no fue tomado debido a no corresponder la moneda con esta OP", vbExclamation
   End If
   
   mvarControlCheck = True
   
   CalculaTotales

End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      Dim oL As ListItem
'      cmd(6).Visible = True
      cmd(7).Visible = True
      cmd(8).Enabled = True
      cmd(9).Visible = True
      cmd(10).Visible = True
'      lblRetencion(0).Visible = True
'      txtBaseGanancias.Visible = True
      With dcfields(0)
         Set .RowSource = Nothing
         .Text = ""
         .DataField = "IdProveedor"
         .BoundColumn = "IdProveedor"
         Set .RowSource = Aplicacion.Proveedores.TraerLista
         If Not IsNull(origen.Registro.Fields("IdProveedor").Value) Then .BoundText = origen.Registro.Fields("IdProveedor").Value
         origen.Registro.Fields("IdCuenta").Value = Null
         'origen.Registro.Fields("IdObra").Value = Null
         origen.Registro.Fields("IdCuentaGasto").Value = Null
         origen.Registro.Fields("IdOPComplementariaFF").Value = Null
         origen.Registro.Fields("IdEmpleadoFF").Value = Null
      End With
      lblDestino.Caption = "Proveedor :"
      lblLabels(1).Caption = "Detalle de imputaciones :"
      lblLabels(6).Caption = "Total imputaciones :"
      cmd(4).Visible = False
      ListaGastos.Visible = False
      Check4.Visible = False
      dcfields1(0).Visible = True
      cmdBuscarPorCuit.Visible = True
      dcfields1(1).Visible = False
      dcfields1(2).Visible = False
      lblObra.Visible = True
      lblNumeroRendicionFF.Visible = False
      txtNumeroRendicionFF.Visible = False
      Check8.Visible = False
      cmdVerOtrasOp.Visible = False
      With Lista
         .BackColor = &H80000005
         .Enabled = True
         .Visible = True
      End With
      cmd(12).Visible = False
      With ListaAnticipos
         If .ListItems.Count > 0 Then
            For Each oL In .ListItems
               origen.DetOrdenesPagoAnticipos.Item(oL.Tag).Eliminado = True
            Next
         End If
         .ListItems.Clear
         .Visible = False
      End With
      txtGasGen.Enabled = False
      With Check3
         .Value = 0
         .Enabled = False
      End With
      lblOPComplementaria(0).Visible = False
      lblOPComplementaria(1).Visible = False
      With txtNumeroOPComplementariaFF
         .Text = ""
         .Visible = False
      End With
      With txtTotalOPComplementariaFF
         .Text = ""
         .Visible = False
      End With
      Label1.Visible = False
      dcfields(1).Visible = False
      Label4.Visible = False
      dcfields(2).Visible = False
      txtCodigoCuenta.Visible = False
      If mvarId = -1 Then
         Dim oRs As ADOR.Recordset
         Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
         With origen.Registro
            If Check2.Value = 0 Then
               .Fields("NumeroOrdenPago").Value = oRs.Fields("ProximaOrdenPago").Value
            Else
               .Fields("NumeroOrdenPago").Value = oRs.Fields("ProximaOrdenPagoExterior").Value
               .Fields("BaseGanancias").Value = Null
               .Fields("RetencionGanancias").Value = 0
            End If
         End With
         oRs.Close
         Set oRs = Nothing
         origen.TipoOP = "CC"
         CalcularRetencionGanancias
         CalculaTotales
      End If
      'lblTipoOperacion.Visible = False
      'Combo1(0).Visible = False
      Frame2.Visible = False
      If BuscarClaveINI("Habilitar campo detalle en OP de proveedores") = "SI" Then
         Label6.Visible = True
         txtDetalle.Visible = True
      End If
   End If
      
End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      Dim oL As ListItem
'      cmd(6).Visible = False
      cmd(7).Visible = False
      cmd(8).Enabled = False
      cmd(9).Visible = False
      cmd(10).Visible = False
'      lblRetencion(0).Visible = False
'      txtBaseGanancias.Visible = False
      With origen.Registro
         .Fields("BaseGanancias").Value = Null
         .Fields("RetencionIVA").Value = Null
         .Fields("RetencionGanancias").Value = Null
         .Fields("RetencionIBrutos").Value = Null
      End With
      With dcfields(0)
         Set .RowSource = Nothing
         .Text = ""
         .DataField = "IdCuenta"
         .BoundColumn = "IdCuenta"
         Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_FondosFijos")
         If Not IsNull(origen.Registro.Fields("IdCuenta").Value) Then .BoundText = origen.Registro.Fields("IdCuenta").Value
         origen.Registro.Fields("IdProveedor").Value = Null
      End With
      lblDestino.Caption = "Cuenta :"
      lblLabels(1).Caption = "Detalle de gastos :"
      lblLabels(6).Caption = "Total gastos :"
      cmd(4).Visible = True
      Check4.Visible = False
      dcfields1(0).Visible = True
      cmdBuscarPorCuit.Visible = False
      dcfields1(1).Visible = False
      dcfields1(2).Visible = False
      lblObra.Visible = True
      With Lista
         If .ListItems.Count > 0 Then
            For Each oL In .ListItems
               origen.DetOrdenesPago.Item(oL.Tag).Eliminado = True
            Next
         End If
         .ListItems.Clear
         .Visible = False
      End With
      With ListaGastos
         .Top = Lista.Top
         .Left = Lista.Left
         .Width = Lista.Width
         .Height = Lista.Height
         .Visible = True
      End With
      cmd(12).Visible = False
      With ListaAnticipos
         If .ListItems.Count > 0 Then
            For Each oL In .ListItems
               origen.DetOrdenesPagoAnticipos.Item(oL.Tag).Eliminado = True
            Next
         End If
         .ListItems.Clear
         .Visible = False
      End With
      txtGasGen.Enabled = True
      With Check3
         .Value = 0
         .Enabled = False
      End With
      lblOPComplementaria(0).Visible = True
      lblOPComplementaria(1).Visible = True
      txtNumeroOPComplementariaFF.Visible = True
      txtTotalOPComplementariaFF.Visible = True
      With Label1
         .AutoSize = False
         .Caption = "Destinatario:"
         .Top = lblObra.Top
         .Left = Check4.Left
         .Width = lblObra.Width
         .Visible = True
      End With
      With dcfields(1)
         .Top = dcfields1(0).Top
         .Left = Label1.Left + Label1.Width + 5
         .Width = dcfields(0).Width * 0.57
         .Visible = True
      End With
      With lblNumeroRendicionFF
         .Top = Frame2.Top
         .Left = Frame2.Left
         .Visible = True
      End With
      With txtNumeroRendicionFF
         .Top = lblNumeroRendicionFF.Top
         .Left = lblNumeroRendicionFF.Left + lblNumeroRendicionFF.Width
         .Visible = True
      End With
      With Check8
         .Top = txtNumeroRendicionFF.Top + txtNumeroRendicionFF.Height
         .Left = txtNumeroRendicionFF.Left + txtNumeroRendicionFF.Width + 5
         .Visible = True
      End With
      With cmdVerOtrasOp
         .Top = txtNumeroRendicionFF.Top
         .Left = txtNumeroRendicionFF.Left + txtNumeroRendicionFF.Width + 5
         .Visible = True
      End With
      Label4.Visible = False
      dcfields(2).Visible = False
      BorrarImputaciones
      CargarGastos
      If mvarId = -1 Then
         Dim oRs As ADOR.Recordset
         Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
         With origen.Registro
            If Check2.Value = 0 Then
               If TraerValorParametro2("NumeracionIndependienteDeOrdenesDePagoFFyCTACTE") = "SI" Then
                  .Fields("NumeroOrdenPago").Value = oRs.Fields("ProximaOrdenPagoFF").Value
               Else
                  .Fields("NumeroOrdenPago").Value = oRs.Fields("ProximaOrdenPago").Value
               End If
            Else
               .Fields("NumeroOrdenPago").Value = oRs.Fields("ProximaOrdenPagoExterior").Value
               .Fields("BaseGanancias").Value = Null
               .Fields("RetencionGanancias").Value = 0
            End If
         End With
         oRs.Close
         Set oRs = Nothing
         origen.TipoOP = "FF"
         CalcularRetencionGanancias
         CalculaTotales
      End If
      'lblTipoOperacion.Visible = False
      'Combo1(0).Visible = False
      Frame2.Visible = False
      Label6.Visible = False
      txtDetalle.Visible = False
      With txtCodigoCuenta
         .Left = dcfields(0).Left + dcfields(0).Width + 10
         .Top = dcfields(0).Top
         .Visible = True
      End With
   End If
      
End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      Me.MousePointer = vbHourglass
      DoEvents
      Dim oL As ListItem
'      cmd(6).Visible = False
      cmd(7).Visible = False
      cmd(8).Enabled = False
      cmd(9).Visible = False
      cmd(10).Visible = False
'      lblRetencion(0).Visible = False
'      txtBaseGanancias.Visible = False
      With origen.Registro
         .Fields("BaseGanancias").Value = Null
         .Fields("RetencionIVA").Value = Null
         .Fields("RetencionGanancias").Value = Null
         .Fields("RetencionIBrutos").Value = Null
      End With
      With dcfields(0)
         Set .RowSource = Nothing
         .Text = ""
         .DataField = "IdCuenta"
         .BoundColumn = "IdCuenta"
         If glbSeñal1 Then
            If IsNumeric(dcfields1(0).BoundText) Then
               Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorFechaParaCombo", Array(DTFields(0).Value, dcfields1(0).BoundText, "SI"))
            Else
               Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorFechaParaCombo", Array(DTFields(0).Value, -1, "SI"))
            End If
         Else
            If IsNumeric(dcfields1(2).BoundText) Then
               Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorGrupoParaCombo", dcfields1(2).BoundText)
            ElseIf IsNumeric(dcfields1(0).BoundText) Then
               Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorFechaParaCombo", Array(DTFields(0).Value, dcfields1(0).BoundText, "SI"))
            Else
               Set .RowSource = Aplicacion.Cuentas.TraerLista
            End If
         End If
         If Not IsNull(origen.Registro.Fields("IdCuenta").Value) Then .BoundText = origen.Registro.Fields("IdCuenta").Value
         origen.Registro.Fields("IdProveedor").Value = Null
         origen.Registro.Fields("IdOPComplementariaFF").Value = Null
         origen.Registro.Fields("IdEmpleadoFF").Value = Null
      End With
      lblDestino.Caption = "Cuenta :"
      lblLabels(1).Caption = "Detalle de imputaciones :"
      lblLabels(6).Caption = "Total imputaciones :"
      cmd(4).Visible = False
      dcfields1(0).Visible = True
      cmdBuscarPorCuit.Visible = False
      If glbModeloContableSinApertura = "SI" Then
         With dcfields1(2)
            .Left = Check4.Left
            .Width = DTFields(0).Width * 3
         End With
      Else
         Check4.Visible = True
         dcfields1(1).Visible = True
      End If
      dcfields1(2).Visible = True
      lblObra.Visible = True
      lblNumeroRendicionFF.Visible = False
      txtNumeroRendicionFF.Visible = False
      Check8.Visible = False
      cmdVerOtrasOp.Visible = False
      ListaGastos.Visible = False
      With Lista
         If .ListItems.Count > 0 Then
            For Each oL In .ListItems
               origen.DetOrdenesPago.Item(oL.Tag).Eliminado = True
            Next
         End If
         .ListItems.Clear
         .BackColor = &HC0C0C0
         .Enabled = False
         If Not .Visible And Not mvarOP_AnticiposAlPersonal Then .Visible = True
      End With
      With cmd(12)
         .Left = cmd(4).Left
         .Top = cmd(4).Top
         .Visible = True
      End With
      txtGasGen.Enabled = False
      With Check3
         .Value = 0
         .Enabled = True
      End With
      lblOPComplementaria(0).Visible = False
      lblOPComplementaria(1).Visible = False
      With txtNumeroOPComplementariaFF
         .Text = ""
         .Visible = False
      End With
      With txtTotalOPComplementariaFF
         .Text = ""
         .Visible = False
      End With
      Label1.Visible = False
      dcfields(1).Visible = False
      If BuscarClaveINI("Habilitar conceptos para OP de otros") = "SI" Then
         With Label4
            .Top = ListaVal.Top
            .Left = lblOPComplementaria(0).Left
            .Visible = True
         End With
         With dcfields(2)
            .Top = Label4.Top
            .Left = Label4.Left + Label4.Width + 5
            .Visible = True
         End With
      End If
      If mvarId = -1 Then
         Dim oRs As ADOR.Recordset
         Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
         With origen.Registro
            If Check2.Value = 0 Then
               .Fields("NumeroOrdenPago").Value = oRs.Fields("ProximaOrdenPagoOtros").Value
            Else
               .Fields("NumeroOrdenPago").Value = oRs.Fields("ProximaOrdenPagoExterior").Value
               .Fields("BaseGanancias").Value = Null
               .Fields("RetencionGanancias").Value = 0
            End If
         End With
         oRs.Close
         Set oRs = Nothing
         origen.TipoOP = "OT"
         CalcularRetencionGanancias
         CalculaTotales
      End If
      'lblTipoOperacion.Visible = True
      'Combo1(0).Visible = True
      Frame2.Visible = True
      Label6.Visible = False
      txtDetalle.Visible = False
      With txtCodigoCuenta
         .Left = dcfields(0).Left + dcfields(0).Width + 10
         .Top = dcfields(0).Top
         .Visible = True
      End With
      
      Me.MousePointer = vbDefault
      DoEvents
   End If
      
End Sub

Private Sub txtCodigoCuenta_Change()

   If IsNumeric(txtCodigoCuenta.Text) Then
      On Error GoTo SalidaConError
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorCodigo", Array(txtCodigoCuenta.Text, DTFields(0).Value))
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdCuenta").Value = oRs.Fields(0).Value
         dcfields(0).BoundText = oRs.Fields(0).Value
      Else
         origen.Registro.Fields("IdCuenta").Value = Null
         dcfields(0).BoundText = 0
      End If
      oRs.Close
      Set oRs = Nothing
      Exit Sub
SalidaConError:
      Set oRs = Nothing
      origen.Registro.Fields(dcfields(0).DataField).Value = Null
   End If

End Sub

Private Sub txtCodigoCuenta_GotFocus()

   With txtCodigoCuenta
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoCuenta_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCotizacion_GotFocus()

   With txtCotizacion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCotizacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

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

   If IsNumeric(txtCotizacionDolar.Text) Then
      If origen.Registro.Fields("IdMoneda").Value = mvarIdMonedaDolar Then
         txtCotizacionMoneda.Text = Val(txtCotizacionDolar.Text)
      End If
      MostrarDiferenciaCambio
   End If

End Sub

Private Sub txtCotizacionEuro_GotFocus()

   With txtCotizacionEuro
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCotizacionEuro_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCotizacionEuro_Validate(Cancel As Boolean)

   If origen.Registro.Fields("IdMoneda").Value = glbIdMonedaEuro Then
      txtCotizacionMoneda.Text = txtCotizacionEuro.Text
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

   With origen.Registro
      If .Fields("IdMoneda").Value = mvarIdMonedaDolar Then
         txtCotizacionDolar.Text = txtCotizacionMoneda.Text
      ElseIf .Fields("IdMoneda").Value = glbIdMonedaEuro Then
         txtCotizacionEuro.Text = txtCotizacionMoneda.Text
      End If
   End With

End Sub

Private Sub txtDetalle_GotFocus()

   With txtDetalle
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDetalle_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
'      SendKeys "{TAB}", True
   Else
      With txtDetalle
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtDto_Change()

   If Len(txtDto.Text) = 0 Then origen.Registro.Fields("Descuentos").Value = 0
   CalculaTotales
   
End Sub

Private Sub txtDto_GotFocus()

   With txtDto
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDto_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtDto_LostFocus()

'   ActualizaListaContable

End Sub

Private Sub txtEfectivo_Change()

   If Len(txtEfectivo.Text) = 0 Then origen.Registro.Fields("Efectivo").Value = 0
   CalculaTotales

End Sub

Private Sub txtEfectivo_GotFocus()

   With txtEfectivo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtEfectivo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtEfectivo_LostFocus()

'   ActualizaListaContable

End Sub

Private Sub txtGasGen_Change()

   If Len(txtGasGen.Text) = 0 Then origen.Registro.Fields("GastosGenerales").Value = 0
   
End Sub

Private Sub txtGasGen_GotFocus()

   With txtGasGen
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtGasGen_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtGasGen_LostFocus()

'   ActualizaListaContable

End Sub

Private Sub txtGasGen_Validate(Cancel As Boolean)

   CalculaTotales

End Sub

Private Sub txtIngBru_Change()

   If Len(txtIngBru.Text) = 0 Then origen.Registro.Fields("RetencionIBrutos").Value = 0
   
End Sub

Private Sub txtIngBru_GotFocus()

   With txtIngBru
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtIngBru_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtIngBru_LostFocus()

'   ActualizaListaContable

End Sub

Private Sub txtIngBru_Validate(Cancel As Boolean)

   CalculaTotales

End Sub

Private Sub txtNumeroOPComplementariaFF_GotFocus()

   With txtNumeroOPComplementariaFF
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroOPComplementariaFF_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroOPComplementariaFF_LostFocus()

   CargarGastos
   CalculaTotales

End Sub

Private Sub txtNumeroOPComplementariaFF_Validate(Cancel As Boolean)

   If Len(txtNumeroOPComplementariaFF.Text) <> 0 Then
      If IsNumeric(txtNumeroOPComplementariaFF.Text) Then
         Dim oRs As ADOR.Recordset
         Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PorNumeroFF", txtNumeroOPComplementariaFF.Text)
         If oRs.RecordCount = 0 Then
            MsgBox "Numero de orden de pago inexistente"
            Cancel = True
         Else
            origen.Registro.Fields("IdOPComplementariaFF").Value = oRs.Fields(0).Value
            txtTotalOPComplementariaFF.Text = oRs.Fields("Valores").Value
            Cancel = False
         End If
         oRs.Close
         Set oRs = Nothing
      Else
         MsgBox "El campo debe ser numerico"
         txtNumeroOPComplementariaFF.Text = ""
         Cancel = True
      End If
   End If
   
End Sub

Private Sub txtNumeroOrdenPago_GotFocus()
   
   With txtNumeroOrdenPago
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroOrdenPago_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroOrdenPago_Validate(Cancel As Boolean)
   
   Dim oRs As ADOR.Recordset
   Dim mTipo As String, mOrdenPagoExterior As String
   If Option1.Value Then
      mTipo = "CC"
   ElseIf Option2.Value Then
      mTipo = "FF"
   ElseIf Option3.Value Then
      mTipo = "OT"
   End If
   If Check2.Value = 1 Then
      mOrdenPagoExterior = "SI"
   Else
      mOrdenPagoExterior = "NO"
   End If
   Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_ValidarNumero", Array(Val(txtNumeroOrdenPago.Text), mvarId, mTipo, mOrdenPagoExterior))
   If oRs.RecordCount > 0 Then
      MsgBox "OrdenPago ya ingresado el " & oRs.Fields("FechaOrdenPago").Value & ". Reingrese.", vbCritical
      Cancel = True
   End If
   oRs.Close
   Set oRs = Nothing

   CargarGastos

End Sub

Public Sub CalculaTotales()

   Dim i As Integer
   Dim oRs As ADOR.Recordset
   Dim Filas
   Dim Columnas
   
   mvarTotalImputaciones = 0
   mvarTotalDebe = 0
   mvarTotalHaber = 0
   mvarTotalValores = 0
   mvarTotalGastos = 0
   mvarTotalAnticipos = 0
   mvarTotalRubrosContables = 0
   mvarDiferenciaBalanceo = 0
   
   If Option1.Value Then
      Set oRs = origen.DetOrdenesPago.TodosLosRegistros
      With oRs
         If .State <> 0 Then
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  mvarTotalImputaciones = mvarTotalImputaciones + .Fields("Importe").Value
                  .MoveNext
               Loop
               .Close
            End If
         End If
      End With
      Set oRs = Nothing
   
      If Lista.ListItems.Count > 0 And IsNumeric(dcfields(0).BoundText) And dcfields(0).Enabled Then
         dcfields(0).Enabled = False
      End If
   
   ElseIf Option2.Value Then
      Filas = VBA.Split(ListaGastos.GetStringCheck, vbCrLf)
      For i = LBound(Filas) + 1 To UBound(Filas)
         Columnas = VBA.Split(Filas(i), vbTab)
         If IsNumeric(Columnas(12)) Then
            mvarTotalGastos = mvarTotalGastos + Val(Columnas(12))
         End If
      Next
   
   ElseIf Option3.Value And ListaAnticipos.ListItems.Count > 0 Then
      Set oRs = origen.DetOrdenesPagoAnticipos.TodosLosRegistros
      With oRs
         If .State <> 0 Then
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  mvarTotalAnticipos = mvarTotalAnticipos + .Fields("Importe").Value
                  .MoveNext
               Loop
               .Close
            End If
         End If
      End With
      Set oRs = Nothing
   End If
   
   Set oRs = origen.DetOrdenesPagoValores.TodosLosRegistros
   With oRs
      If .State <> 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               If IIf(IsNull(.Fields("Anulado").Value), "NO", .Fields("Anulado").Value) <> "SI" Then
                  mvarTotalValores = mvarTotalValores + IIf(IsNull(.Fields("Importe").Value), 0, .Fields("Importe").Value)
               End If
               .MoveNext
            Loop
         End If
         .Close
      End If
   End With
   Set oRs = Nothing
   
   Set oRs = origen.DetOrdenesPagoCuentas.TodosLosRegistros
   With oRs
      If .State <> 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               If Not IsNull(.Fields("Debe").Value) Then
                  mvarTotalDebe = mvarTotalDebe + .Fields("Debe").Value
               End If
               If Not IsNull(.Fields("Haber").Value) Then
                  mvarTotalHaber = mvarTotalHaber + .Fields("Haber").Value
               End If
               .MoveNext
            Loop
         End If
         .Close
      End If
   End With
   Set oRs = Nothing
   
   If Check7.Value = 1 Then CalcularRubrosContables
   
   Set oRs = origen.DetOrdenesPagoRubrosContables.TodosLosRegistros
   With oRs
      If .State <> 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               mvarTotalRubrosContables = mvarTotalRubrosContables + IIf(IsNull(.Fields("Importe").Value), 0, .Fields("Importe").Value)
               .MoveNext
            Loop
         End If
         .Close
      End If
   End With
   Set oRs = Nothing
   
   txtTotal(0).Text = Format(mvarTotalImputaciones + mvarTotalGastos + mvarTotalAnticipos, "#,##0.00")
   txtTotal(1).Text = Format(mvarTotalDebe, "0.00")
   txtTotal(2).Text = Format(mvarTotalHaber, "0.00")
   txtTotal(3).Text = Format(mvarTotalValores, "#,##0.00")
   txtTotal(5).Text = Format(mvarTotalRubrosContables, "#,##0.00")

'   If (mvarTotalImputaciones + mvarTotalGastos + mvarTotalAnticipos) = 0 And _
'         (mvarTotalValores + Val(txtEfectivo.Text) + Val(txtRetIva.Text) + _
'          Val(txtIngBru.Text) + Val(txtDto.Text) + Val(txtGasGen.Text) + _
'          Val(txtTotalOPComplementariaFF.Text) + Val(txtRetencionSUSS.Text)) = 0 And _
'         Val(txtBaseGanancias.Text) > 0 Then
'      mvarDiferenciaBalanceo = Val(txtBaseGanancias.Text) - Val(txtRetGan.Text)
'   Else
      mvarDiferenciaBalanceo = Round(Round(mvarTotalImputaciones + mvarTotalGastos + mvarTotalAnticipos, 2) - _
                                     Round(mvarTotalValores + Val(txtEfectivo.Text) + Val(txtRetIva.Text) + _
                                     Val(txtRetGan.Text) + Val(txtIngBru.Text) + Val(txtDto.Text) - Val(txtGasGen.Text) + _
                                     Val(txtTotalOPComplementariaFF.Text) + Val(txtRetencionSUSS.Text), 2), 2)
'   End If
   txtDif.Text = mvarDiferenciaBalanceo
   
   origen.TotalNeto = Round((mvarTotalImputaciones + mvarTotalGastos + mvarTotalAnticipos) - _
                              (Val(txtRetIva.Text) + Val(txtRetGan.Text) + Val(txtIngBru.Text) + Val(txtDto.Text) - Val(txtGasGen.Text) + _
                               Val(txtTotalOPComplementariaFF.Text) + Val(txtRetencionSUSS.Text)), 2)
   With origen.Registro
      .Fields("Acreedores").Value = mvarTotalImputaciones
      .Fields("Valores").Value = mvarTotalValores
      .Fields("DiferenciaBalanceo").Value = mvarDiferenciaBalanceo
   End With
   
End Sub

Private Sub txtNumeroRendicionFF_Change()

   'txtNumeroRendicionFF.ToolTipText = MostrarRendicionesFF

End Sub

Private Sub txtNumeroRendicionFF_GotFocus()

   With txtNumeroRendicionFF
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroRendicionFF_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroRendicionFF_Validate(Cancel As Boolean)

   Dim oL As ListItem
   Dim mIdCuentaFF As Long
   Dim oRs As ADOR.Recordset
   
   With origen.Registro
      If Len(IIf(IsNull(.Fields("NumeroRendicionFF").Value), "", .Fields("NumeroRendicionFF").Value)) = 0 Then
         With ListaGastos
            .ListItems.Clear
            .Sorted = False
            .CheckBoxes = True
            If IsNumeric(dcfields(0).BoundText) Then
               mIdCuentaFF = dcfields(0).BoundText
            Else
               mIdCuentaFF = -1
            End If
            Set .DataSource = Aplicacion.OrdenesPago.TraerFiltrado("_TraerGastosPendientes", _
                              Array(mvarId, dcfields(3).BoundText, mIdCuentaFF, Val(txtNumeroRendicionFF.Text)))
            If .ListItems.Count > 0 Then
               For Each oL In .ListItems
                  oL.Checked = True
               Next
            End If
         End With
         CalculaTotales
      End If
   End With
   If Val(txtNumeroRendicionFF.Text) <> 0 Then
      With Check8
         .Value = 0
         .Enabled = False
      End With
   Else
      Check8.Enabled = True
   End If
   txtNumeroRendicionFF.ToolTipText = MostrarRendicionesFF

End Sub

Private Sub txtRetencionSUSS_LostFocus()

   CalculaTotales

End Sub

Private Sub txtRetGan_Change()

   If Len(txtRetGan.Text) = 0 Then origen.Registro.Fields("RetencionGanancias").Value = 0
   CalculaTotales
   
End Sub

Private Sub txtRetGan_GotFocus()

   With txtRetGan
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtRetGan_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtRetGan_LostFocus()

'   ActualizaListaContable

End Sub

Private Sub txtRetIva_Change()

   If Len(txtRetIva.Text) = 0 Then origen.Registro.Fields("RetencionIVA").Value = 0
   CalculaTotales
   
End Sub

Private Sub txtRetIva_GotFocus()

   With txtRetIva
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtRetIva_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Sub ActualizaListaContable()

   If Check3.Value = 0 Then
      On Error Resume Next
      If Not (IsNull(origen.Registro.Fields("IdProveedor").Value) And _
               IsNull(origen.Registro.Fields("IdCuenta").Value)) Then
         Set ListaCta.DataSource = origen.RegistroContableForm
         ListaCta.Refresh
         DoEvents: DoEvents
         txtTotal(1).Text = Format(origen.TotalDebe, "0.00")
         txtTotal(2).Text = Format(origen.TotalHaber, "0.00")
      End If
   End If
   
End Sub

Private Sub txtRetIva_LostFocus()

'   ActualizaListaContable

End Sub

Public Sub CargarGastos()

   If Option2.Value Then
      Dim oL As ListItem
      Dim mIdOPComplementaria As Long
      If Not IsNull(origen.Registro.Fields("IdOPComplementariaFF").Value) Then
         mIdOPComplementaria = origen.Registro.Fields("IdOPComplementariaFF").Value
      Else
         mIdOPComplementaria = -1
      End If
      With ListaGastos
         .ListItems.Clear
         .Sorted = False
         .CheckBoxes = True
         Set .DataSource = Aplicacion.OrdenesPago.TraerFiltrado("_TraerGastosPorOrdenPago", _
                           Array(mvarId, mIdOPComplementaria, dcfields(3).BoundText))
         If .ListItems.Count > 0 Then
            For Each oL In .ListItems
               oL.Checked = True
            Next
         End If
      End With
   End If

End Sub

Public Sub CargarGastosPendientes()

   If Option2.Value Then
      Dim oL As ListItem
      Dim mIdCuentaFF As Long
      With ListaGastos
         .ListItems.Clear
         .Sorted = False
         .CheckBoxes = True
         If IsNumeric(dcfields(0).BoundText) Then
            mIdCuentaFF = dcfields(0).BoundText
         Else
            mIdCuentaFF = -1
         End If
         Set .DataSource = Aplicacion.OrdenesPago.TraerFiltrado("_TraerGastosPendientes", _
                           Array(mvarId, dcfields(3).BoundText, mIdCuentaFF))
         If .ListItems.Count > 0 Then
            For Each oL In .ListItems
               If oL.SubItems(13) = "SI" Then
                  oL.Checked = True
               End If
            Next
         End If
      End With
   End If

End Sub

Public Sub AnularOrdenPago()

   If ExistenAnticiposAplicados() Then
      MsgBox "La orden de pago contiene anticipos que en cuenta corriente han sido aplicados." & vbCrLf & _
            "No puede anular esta orden de pago", vbInformation
      Exit Sub
   End If
   
   Dim oF As frmAutorizacion
   Dim mUsuario As String
   Dim mIdAnulo As Long
   Dim mOk As Boolean
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.OrdenesPago
      '.Administradores = True
      .Show vbModal, Me
      mOk = .Ok
      mUsuario = .Autorizo
      mIdAnulo = .IdAutorizo
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then
      Exit Sub
   End If
   
   Me.Refresh
   
   Dim mSeguro As Integer
   mSeguro = MsgBox("Esta seguro de anular la orden de pago ?", vbYesNo, "Anulacion de orden de pago")
   If mSeguro = vbNo Then
      Exit Sub
   End If

   Dim s As String
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   
   s = ""
   Set oRs = origen.DetOrdenesPagoValores.Registros
   With oRs
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               If Not .Fields("Eliminado").Value Then
                  Set oRs1 = Aplicacion.Valores.TraerFiltrado("_PorIdDetalleOrdenPagoValores", .Fields(0).Value)
                  If oRs1.RecordCount > 0 Then
                     If (Not IsNull(oRs1.Fields("Conciliado").Value) And oRs1.Fields("Conciliado").Value = "SI") Or _
                        (Not IsNull(oRs1.Fields("MovimientoConfirmadoBanco").Value) And oRs1.Fields("MovimientoConfirmadoBanco").Value = "SI") Then
                        s = s + "" & oRs1.Fields("NumeroValor").Value & ", " & vbCrLf
                     End If
                  End If
                  oRs1.Close
               End If
               .MoveNext
            Loop
         End If
      End If
   End With
   If Len(s) > 0 Then
      MsgBox "Cuidado, los valores numeros : " & vbCrLf & s & "estan marcados como conciliados/confirmados", vbInformation
   End If
   Set oRs = Nothing
   Set oRs1 = Nothing
   
   Dim oF1 As frmAnulacion
   Dim mMotivoAnulacion As String, mAnulacionCheques As String
   Set oF1 = New frmAnulacion
   With oF1
      .Caption = "Motivo de anulacion de la orden de pago"
      .Text1.Text = "Usuario : " & mUsuario & " - [" & Now & "]"
      .Frame1.Visible = True
      .Show vbModal, Me
      mOk = .Ok
      If .Option1.Value Then
         mAnulacionCheques = "A"
      ElseIf .Option2.Value Then
         mAnulacionCheques = "E"
      Else
         mAnulacionCheques = ""
      End If
      mMotivoAnulacion = .rchAnulacion.Text
   End With
   Unload oF1
   Set oF1 = Nothing
   If Not mOk Then
      MsgBox "Anulacion cancelada!", vbExclamation
      Exit Sub
   End If
   
   If mAnulacionCheques = "A" Then
      Set oRs = origen.DetOrdenesPagoValores.Registros
      With oRs
         If .Fields.Count > 0 Then
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  If Not .Fields("Eliminado").Value Then
                     If .Fields("IdTipoValor").Value = 6 And IIf(IsNull(.Fields("Anulado").Value), "NO", .Fields("Anulado").Value) <> "SI" Then
                        With origen.DetOrdenesPagoValores.Item(oRs.Fields(0).Value)
                           With .Registro
                              .Fields("Anulado").Value = "SI"
                              .Fields("IdUsuarioAnulo").Value = mIdAnulo
                              .Fields("FechaAnulacion").Value = Now
                              .Fields("MotivoAnulacion").Value = mId(mMotivoAnulacion, 1, .Fields("MotivoAnulacion").DefinedSize)
                           End With
                           .Modificado = True
                        End With
                        For Each oL In ListaVal.ListItems
                           If oL.Tag = .Fields(0).Value Then
                              oL.Text = oL.Text & " AN"
                              Exit For
                           End If
                        Next
                     End If
                  End If
                  .MoveNext
               Loop
            End If
         End If
      End With
      Set oRs = Nothing
   End If
   
   With origen
      .Registro.Fields("Anulada").Value = "OK"
      .Registro.Fields("IdUsuarioAnulo").Value = mIdAnulo
      .Registro.Fields("FechaAnulacion").Value = Now
      .Registro.Fields("MotivoAnulacion").Value = mMotivoAnulacion
      .Registro.Fields("FormaAnulacionCheques").Value = mAnulacionCheques
      .Guardar
   End With
   Aplicacion.Tarea "OrdenesPago_LiberarGastosPorAnulacionOP", mvarId

   mvarAnuloValor = False
   
   Unload Me

End Sub

Public Sub MostrarDiferenciaCambio()

   If Check1.Value = 0 Then
      txtTotal(4).Text = 0
      Exit Sub
   End If
   
   txtTotal(4).Text = Format(ValorDiferenciaCambio(), "#,##0.00")

End Sub

Private Sub AgregarDiferenciaCambio()

'   If mvarId > 0 Then
'      MsgBox "No puede modificar una Orden de Pago ya registrada!", vbCritical
'      Exit Sub
'   End If
   
   If Len(Trim(dcfields(0).BoundText)) = 0 Then
      MsgBox "Falta completar el campo Proveedor", vbCritical
      Exit Sub
   End If
   
   If Len(Trim(txtNumeroOrdenPago.Text)) = 0 Then
      MsgBox "Falta completar el campo numero de Orden de Pago", vbCritical
      Exit Sub
   End If
   
'   If Val(txtTotal(4).Text) < 0 Then
'      MsgBox "La diferencia de cambio debe ser mayor a cero", vbCritical
'      Exit Sub
'   End If
   
   Dim oRs As ADOR.Recordset
   Dim mvarDifCam As Double
   
   mvarDifCam = ValorDiferenciaCambio()

   If mvarDifCam > 0 Then
      With origen.DetOrdenesPago.Item(-1)
         .Registro.Fields("IdImputacion").Value = -1
         .Registro.Fields("Importe").Value = mvarDifCam
         .Modificado = True
      End With
   Else
      With origen.DetOrdenesPago.Item(-1)
         .Registro.Fields("IdImputacion").Value = -2
         .Registro.Fields("Importe").Value = mvarDifCam
         .Modificado = True
      End With
   End If

   Set oRs = origen.DetOrdenesPago.RegistrosConFormato
   Set Lista.DataSource = oRs
   
   oRs.Close
   Set oRs = Nothing
   
   CalcularRetencionGanancias
   CalculaTotales

End Sub

Public Function ValorDiferenciaCambio() As Double

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim mDifer As Double
   
   Set oRs = origen.DetOrdenesPago.TodosLosRegistros
   
   mDifer = 0
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If Not oRs.Fields("Eliminado").Value Then
               If Not IsNull(oRs.Fields("IdImputacion").Value) And _
                  Not IsNull(oRs.Fields("Importe").Value) Then
                  Set oRs1 = Aplicacion.DiferenciasCambio.TraerFiltrado("_ParaCalculoIndividual", _
                        Array(oRs.Fields("IdImputacion").Value, Val(txtCotizacionDolar.Text), _
                              oRs.Fields("Importe").Value, dcfields(3).BoundText))
                  If oRs1.RecordCount > 0 Then
                     mDifer = mDifer + IIf(IsNull(oRs1.Fields("Dif.cambio $").Value), 0, oRs1.Fields("Dif.cambio $").Value)
                  End If
                  oRs1.Close
                  Set oRs1 = Nothing
               End If
            End If
            oRs.MoveNext
         Loop
      End If
   End If
   
   Set oRs = Nothing

   ValorDiferenciaCambio = Round(mDifer, 2)

End Function

Public Sub BorrarImputaciones()

   Dim oRs As ADOR.Recordset
   
   Set oRs = origen.DetOrdenesPago.TodosLosRegistros
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            origen.DetOrdenesPago.Item(oRs.Fields(0).Value).Eliminado = True
            oRs.MoveNext
         Loop
      End If
   End If
   
   Set oRs = Nothing

End Sub

Public Sub CalcularRetencionGanancias()

   Dim mvarImpuesto As Double
   Dim i As Integer
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   
   mvarTotalBaseGanancias = 0
   mvarImpuesto = 0
   
   If mvarRetenerGanancias And IsNumeric(origen.Registro.Fields("IdProveedor").Value) And Check2.Value = 0 Then
      Set oRs = origen.DetOrdenesPagoImpuestos.RegistrosConFormato
      If oRs.RecordCount > 0 Then
         Set ListaImpuestos.DataSource = oRs
      Else
         ListaImpuestos.ListItems.Clear
      End If
      Set oRs = Nothing
      ListaImpuestos.Refresh
      
      For Each oL In ListaImpuestos.ListItems
         If oL.Text = "Ganancias" Then
            If Val(oL.SubItems(3)) <> 0 Then
               mvarTotalBaseGanancias = mvarTotalBaseGanancias + Val(oL.SubItems(3))
            End If
            If Val(oL.SubItems(4)) <> 0 Then
               mvarImpuesto = mvarImpuesto + Val(oL.SubItems(4))
            End If
         End If
      Next
      If mvarId <= 0 Or Check6.Value = 1 Then
         origen.Registro.Fields("RetencionGanancias").Value = mvarImpuesto
      End If
   Else
      origen.DetOrdenesPagoImpuestos.BorrarRegistrosPorImpuesto "Ganancias"
      Set oRs = origen.DetOrdenesPagoImpuestos.RegistrosConFormato
      If oRs.RecordCount > 0 Then
         Set ListaImpuestos.DataSource = oRs
      Else
         ListaImpuestos.ListItems.Clear
      End If
      Set oRs = Nothing
      ListaImpuestos.Refresh
   End If
   
End Sub

Public Sub RetencionGanancias()

'   Dim of As frmConsulta1
'
'   Set of = New frmConsulta1
'
'   With of
'      .Parametros = "" & origen.Registro.Fields("IdProveedor").Value & "|" & _
'                     DTFields(0).Value & "|" & txtBaseGanancias.Text
'      .Id = 4
'      .Show vbModal, Me
'   End With
'
'   Unload of
'   Set of = Nothing
   
End Sub

Public Sub CalcularRetencionIVA()

   If mvarId < 0 Or Check6.Value = 1 Then
      Dim oL As ListItem
      Dim mvarRetencionIVA As Double, mvarRetencionIVAComprobantesM As Double, mvarRetencionIVAIndividual As Double
      Dim mvarBase As Double, mvarBienesUltimoAño As Double, mvarServiciosUltimoAño As Double
      Dim oRs As ADOR.Recordset
      
      mvarRetencionIVA = 0
      mvarRetencionIVAComprobantesM = 0
      mvarBienesUltimoAño = 0
      mvarServiciosUltimoAño = 0
      
      If mvarTipoIVA = 6 Then
         Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_TotalBSUltimoAño", Array(dcfields(0).BoundText, DTFields(0).Value, 6))
         If oRs.RecordCount > 0 Then
            mvarBienesUltimoAño = IIf(IsNull(oRs.Fields("Importe_Bienes").Value), 0, oRs.Fields("Importe_Bienes").Value)
            mvarServiciosUltimoAño = IIf(IsNull(oRs.Fields("Importe_Servicios").Value), 0, oRs.Fields("Importe_Servicios").Value)
         End If
         oRs.Close
      End If
      
      For Each oL In Lista.ListItems
         If Len(oL.Tag) > 0 And Not origen.DetOrdenesPago.Item(oL.Tag).Eliminado Then
            mvarRetencionIVAIndividual = 0
            If Len(oL.SubItems(11)) = 0 Or oL.SubItems(11) = txtNumeroOrdenPago.Text Then
               mvarBase = Val(oL.SubItems(7))
               If mId(oL.SubItems(1), 1, 1) = "M" Then
                  If (Val(oL.SubItems(8)) - Val(oL.SubItems(7))) >= mvarImporteComprobantesMParaRetencionIVA Then
                     mvarRetencionIVAIndividual = Round(mvarBase * mvarPorcentajeRetencionIVAComprobantesM / 100, 2)
                     mvarRetencionIVAComprobantesM = mvarRetencionIVAComprobantesM + mvarRetencionIVAIndividual
                  End If
               ElseIf mvarAgenteRetencionIVA = "SI" Then
                  If mvarCodigoSituacionRetencionIVA = 2 Then
                     mvarRetencionIVAIndividual = mvarBase
                  Else
                     If Val(oL.SubItems(8)) > mvarImporteTotalMinimoAplicacionRetencionIVA Then
                        If oL.SubItems(9) = "B" Then
                           If mvarBase > mvarTopeMinimoRetencionIVA Then
                              mvarBase = mvarBase * mvarPorcentajeBaseRetencionIVABienes / 100
                              If mvarExceptuadoRetencionIVA <> 0 Then
                                 mvarRetencionIVAIndividual = Round((mvarBase * (100 - mvarExceptuadoRetencionIVA) / 100), 2)
                              Else
                                 mvarRetencionIVAIndividual = mvarBase
                                 If mvarRetencionIVAIndividual < mvarImporteMinimoRetencionIVA Then
                                    mvarRetencionIVAIndividual = 0
                                 End If
                              End If
                              If mvarTipoIVA <> 1 Then mvarRetencionIVAIndividual = 0
                           End If
                        ElseIf oL.SubItems(9) = "S" Then
                           If mvarBase > mvarTopeMinimoRetencionIVAServicios Then
                              mvarBase = mvarBase * mvarPorcentajeBaseRetencionIVAServicios / 100
                              If mvarExceptuadoRetencionIVA <> 0 Then
                                 mvarRetencionIVAIndividual = Round((mvarBase * (100 - mvarExceptuadoRetencionIVA) / 100), 2)
                              Else
                                 mvarRetencionIVAIndividual = mvarBase
                                 If mvarRetencionIVAIndividual < mvarImporteMinimoRetencionIVAServicios Then
                                    mvarRetencionIVAIndividual = 0
                                 End If
                              End If
                              If mvarTipoIVA <> 1 Then mvarRetencionIVAIndividual = 0
                           End If
                        Else
                           mvarBase = 0
                        End If
                     End If
                  End If
               End If
               'Si es monotributista verifico la facturacion del ultimo año y recalculo la retencion
               If mvarTipoIVA = 6 Then
                  If mvarBienesUltimoAño > glbTopeMonotributoAnual_Bienes Or mvarServiciosUltimoAño > glbTopeMonotributoAnual_Servicios Then
                     mvarBase = Val(oL.SubItems(6))
                     'If Val(oL.SubItems(19)) = 21 Then mvarRetencionIVAIndividual = mvarBase * 0.168
                     'If Val(oL.SubItems(19)) = 10.5 Then mvarRetencionIVAIndividual = mvarBase * 0.084
                      mvarRetencionIVAIndividual = Round(mvarBase * mvarPorcentajeRetencionIVAMonotributistas / 100, 2)
                  End If
               End If
               oL.SubItems(10) = mvarRetencionIVAIndividual
               With origen.DetOrdenesPago.Item(oL.Tag)
                  .Registro.Fields("ImporteRetencionIVA").Value = mvarRetencionIVAIndividual
                  .Modificado = True
               End With
            End If
            mvarRetencionIVA = mvarRetencionIVA + mvarRetencionIVAIndividual
         End If
      Next
      
      origen.Registro.Fields("RetencionIVA").Value = mvarRetencionIVA
      origen.Registro.Fields("RetencionIVAComprobantesM").Value = mvarRetencionIVAComprobantesM
      
      Set oRs = Nothing
   End If

End Sub

Public Sub CalcularRetencionIngresosBrutos()

   Dim oL As ListItem
   Dim mvarRetencionIB As Double, mvarRetencionIBIndividual As Double
   Dim oRs As ADOR.Recordset
   
   mvarRetencionIB = 0
      
   If mvarRetenerIIBB And mvarAgenteRetencionIIBB = "SI" And _
         IsNumeric(origen.Registro.Fields("IdProveedor").Value) And _
         Check2.Value = 0 Then
      
      Set oRs = origen.DetOrdenesPagoImpuestos.RegistrosConFormato
      If oRs.RecordCount > 0 Then
         Set ListaImpuestos.DataSource = oRs
      Else
         ListaImpuestos.ListItems.Clear
      End If
      Set oRs = Nothing
      ListaImpuestos.Refresh
      
      For Each oL In ListaImpuestos.ListItems
         If oL.Text = "I.Brutos" And Val(oL.SubItems(4)) <> 0 Then
            mvarRetencionIB = mvarRetencionIB + Val(oL.SubItems(4))
         End If
      Next
      If mvarId <= 0 Or Check6.Value = 1 Then
         origen.Registro.Fields("RetencionIBrutos").Value = mvarRetencionIB
      End If
   
   Else
      
      origen.DetOrdenesPagoImpuestos.BorrarRegistrosPorImpuesto "I.Brutos"
      Set oRs = origen.DetOrdenesPagoImpuestos.RegistrosConFormato
      If oRs.RecordCount > 0 Then
         Set ListaImpuestos.DataSource = oRs
      Else
         ListaImpuestos.ListItems.Clear
      End If
      Set oRs = Nothing
      ListaImpuestos.Refresh
   
   End If

End Sub

Public Sub CalcularRetencionSUSS()

   If mvarAgenteRetencionSUSS = "SI" Then
      Dim mvarRetencionSUSS As Double, mvarRetencionSUSSIndividual As Double, mvarImporteAcumulado As Double
      Dim mvarTotalGravado As Double, mvarBaseOperacion As Double, mvarRetenidoAño As Double
      Dim mvarRetencionSUSSAcumulado As Double
      Dim mProcesarSUSS As Boolean
      Dim oRs As ADOR.Recordset
      
      If mvarSUSSFechaCaducidadExencion < Date And Me.Visible And _
            IsNumeric(dcfields(0).BoundText) Then 'And mvarAgenteRetencionIVA = "SI" Then
         MsgBox "El proveedor tiene la fecha de excencion al SUSS vencida," & vbCrLf & _
                "se requerira la categoria para realizar la retencion", vbExclamation
         
         Dim mIdImpuestoDirecto As Long
         Dim mOk As Boolean
         Dim oF As frm_Aux
         Dim oPrv As ComPronto.Proveedor
         Dim oRsAux As ADOR.Recordset
         
         Set oF = New frm_Aux
         With oF
            .Caption = "Retencion SUSS"
            .Width = .Width * 2
            .Text1.Visible = False
            With .Label1
               .Caption = "Cat.SUSS:"
               .Visible = True
            End With
            With .dcfields(0)
               .Left = oF.Text1.Left
               .Top = oF.Text1.Top
               .Width = oF.DTFields(0).Width * 3
               .BoundColumn = "IdImpuestoDirecto"
               Set .RowSource = Aplicacion.ImpuestosDirectos.TraerFiltrado("_PorTipoParaCombo", "SUSS")
               .Visible = True
            End With
            .Show vbModal, Me
            mOk = .Ok
            If IsNumeric(.dcfields(0).BoundText) Then
               mIdImpuestoDirecto = .dcfields(0).BoundText
            Else
               mIdImpuestoDirecto = 0
            End If
         End With
         Unload oF
         Set oF = Nothing
         
         If Not mOk Then Exit Sub
         
         If mIdImpuestoDirecto = 0 Then
            MsgBox "No ingreso la categoria de SUSS", vbExclamation
            Exit Sub
         End If
         
         Set oPrv = Aplicacion.Proveedores.Item(dcfields(0).BoundText)
         With oPrv
            With .Registro
               .Fields("IdImpuestoDirectoSUSS").Value = mIdImpuestoDirecto
               .Fields("RetenerSUSS").Value = "SI"
               .Fields("SUSSFechaCaducidadExencion").Value = Null
            End With
            .Guardar
         End With
         Set oPrv = Nothing
         
         mvarIdImpuestoDirectoSUSS = mIdImpuestoDirecto
         mvarSUSSFechaCaducidadExencion = Date
         
         mvarPorcentajeRetencionSUSS1 = 0
         mvarImporteMinimoBaseRetencionSUSS = 0
         Set oRsAux = Aplicacion.ImpuestosDirectos.TraerFiltrado("_PorId", mIdImpuestoDirecto)
         If oRsAux.RecordCount > 0 Then
            mvarPorcentajeRetencionSUSS1 = IIf(IsNull(oRsAux.Fields("Tasa").Value), 0, oRsAux.Fields("Tasa").Value)
            mvarImporteMinimoBaseRetencionSUSS = IIf(IsNull(oRsAux.Fields("BaseMinima").Value), 0, oRsAux.Fields("BaseMinima").Value)
         End If
         oRsAux.Close
         Set oRsAux = Nothing
         
         With Check5
            .Enabled = True
            .Value = 1
         End With
         mvarRetenerSUSSAProveedor = "SI"
      End If
      
      If mvarRetenerSUSSAProveedor <> "SI" Then Exit Sub
      
      mvarRetencionSUSS = 0
      mvarBaseCalculoSUSS = 0
      mvarTotalGravado = 0
      mvarImporteAcumulado = 0
      mvarRetenidoAño = 0
      mvarRetencionSUSSAcumulado = 0
      mProcesarSUSS = False
      
      If Check5.Value = 1 Then
         Dim oL As ListItem
         For Each oL In Lista.ListItems
            If Len(oL.Tag) > 0 Then
               CalculaTotales
               If Not origen.DetOrdenesPago.Item(oL.Tag).Eliminado Then
                  If Val(oL.SubItems(6)) <> 0 Then mvarTotalGravado = mvarTotalGravado + Val(oL.SubItems(6))
               End If
            End If
         Next
         
         If mvarTopeAnualSUSS > 0 Then
            Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PagosAcumuladoAnual", Array(dcfields(0).BoundText, DTFields(0).Value, mvarId, mvarIdImpuestoDirectoSUSS))
            With oRs
               If .RecordCount > 0 Then
                  mvarRetenidoAño = IIf(IsNull(.Fields("RetenidoAño").Value), 0, .Fields("RetenidoAño").Value)
                  mvarImporteAcumulado = IIf(IsNull(.Fields("ImporteAcumulado").Value), 0, .Fields("ImporteAcumulado").Value)
               End If
               .Close
            End With
         End If
         
         If mvarTotalGravado >= mvarImporteMinimoBaseRetencionSUSS Then
            For Each oL In Lista.ListItems
               If Len(oL.Tag) > 0 Then
                  mvarRetencionSUSSIndividual = 0
                  If Not origen.DetOrdenesPago.Item(oL.Tag).Eliminado Then
                     mvarBaseOperacion = Val(oL.SubItems(6))
                     If mvarBaseOperacion <> 0 Then
                        mvarBaseCalculoSUSS = mvarBaseCalculoSUSS + mvarBaseOperacion
                        If mvarTopeAnualSUSS > 0 And mvarImporteAcumulado + mvarBaseCalculoSUSS >= mvarTopeAnualSUSS Then mProcesarSUSS = True
                        If mvarPorcentajeRetencionSUSS1 = -1 Then
                           mvarRetencionSUSSIndividual = Round(mvarBaseOperacion * mvarPorcentajeRetencionSUSS / 100, 2)
                        Else
                           mvarRetencionSUSSIndividual = Round(mvarBaseOperacion * mvarPorcentajeRetencionSUSS1 / 100, 2)
                        End If
                     End If
                  End If
                  mvarRetencionSUSS = mvarRetencionSUSS + mvarRetencionSUSSIndividual
               End If
            Next
            If mvarTopeAnualSUSS > 0 Then
               If mProcesarSUSS Then
                  If mvarPorcentajeRetencionSUSS1 = -1 Then
                     mvarRetencionSUSS = mvarRetencionSUSS + Round(mvarImporteAcumulado * mvarPorcentajeRetencionSUSS / 100, 2)
                  Else
                     mvarRetencionSUSS = mvarRetencionSUSS + Round(mvarImporteAcumulado * mvarPorcentajeRetencionSUSS1 / 100, 2)
                  End If
                  mvarRetencionSUSS = mvarRetencionSUSS - mvarRetenidoAño
                  If mvarRetencionSUSS < 0 Then mvarRetencionSUSS = 0
               Else
                  mvarRetencionSUSS = 0
               End If
            End If
         End If
      End If
      Set oRs = Nothing
      
      If mvarId <= 0 Or Check6.Value = 1 Then
         origen.Registro.Fields("RetencionSUSS").Value = mvarRetencionSUSS
         If mvarTopeAnualSUSS > 0 Then
            CalculaTotales
            If Val(txtDif.Text) < 0 Then
               mvarRetencionSUSS = mvarRetencionSUSS + Val(txtDif.Text)
               If mvarRetencionSUSS < 0 Then mvarRetencionSUSS = 0
               origen.Registro.Fields("RetencionSUSS").Value = mvarRetencionSUSS
               txtRetencionSUSS.BackColor = &HC0C0FF
            Else
               txtRetencionSUSS.BackColor = &H80000005
            End If
         End If
         If mvarPrimeraVez And mvarTipoIVA = 6 And mvarRetencionSUSS > 0 Then
            MsgBox "El proveedor es monotributista, el sistema calcula el SUSS por aplicacion directa," & vbCrLf & _
                  "verifique si existen pagos en el mes a este proveedor y ajuste el calculo.", vbInformation
            mvarPrimeraVez = False
         End If
      End If
   Else
      With Check5
         .Value = 0
         .Enabled = False
      End With
   End If

End Sub

Public Function ItemsDeGastosMarcados() As Integer

   Dim Filas
   Filas = VBA.Split(ListaGastos.GetStringCheck, vbCrLf)
   ItemsDeGastosMarcados = UBound(Filas)

End Function

Public Function ExistenAnticiposAplicados()

   Dim oRs As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim mCambioAnticipo As Boolean
   
   mCambioAnticipo = False
   Set oRs = origen.DetOrdenesPago.Registros
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If oRs.Fields(0).Value > 0 And oRs.Fields("IdImputacion").Value = -1 Then
               Set oRsAux = Aplicacion.CtasCtesA.TraerFiltrado("_PorDetalleOrdenPago", oRs.Fields(0).Value)
               If oRsAux.RecordCount > 0 Then
                  If oRsAux.Fields("ImporteTotal").Value <> oRsAux.Fields("Saldo").Value Then
                     mCambioAnticipo = True
                  End If
               End If
               oRsAux.Close
               If mCambioAnticipo Then Exit Do
            End If
            oRs.MoveNext
         Loop
      End If
   End If
   Set oRs = Nothing
   
   ExistenAnticiposAplicados = mCambioAnticipo

End Function

Public Function CambioDeMonedaValido(ByVal IdMoneda As Long) As Boolean

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim mCambioDeMoneda As Boolean
   
   mCambioDeMoneda = True
   
   Set oRs = origen.DetOrdenesPagoValores.Registros
   With oRs
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               If Not .Fields("Eliminado").Value Then
                  If Not IsNull(.Fields("IdCuentaBancaria").Value) Then
                     Set oRs1 = Aplicacion.CuentasBancarias.TraerFiltrado("_PorId", .Fields("IdCuentaBancaria").Value)
                     If oRs1.RecordCount > 0 Then
                        If oRs1.Fields("IdMoneda").Value <> IdMoneda Then
                           mCambioDeMoneda = False
                           Exit Do
                        End If
                     End If
                     oRs1.Close
                  ElseIf Not IsNull(.Fields("IdCaja").Value) Then
                     Set oRs1 = Aplicacion.Cajas.TraerFiltrado("_PorId", .Fields("IdCaja").Value)
                     If oRs1.RecordCount > 0 Then
                        If oRs1.Fields("IdMoneda").Value <> IdMoneda Then
                           mCambioDeMoneda = False
                           Exit Do
                        End If
                     End If
                     oRs1.Close
                  ElseIf Not IsNull(.Fields("IdValor").Value) Then
                     Set oRs1 = Aplicacion.Valores.TraerFiltrado("_PorId", .Fields("IdValor").Value)
                     If oRs1.RecordCount > 0 Then
                        If oRs1.Fields("IdMoneda").Value <> IdMoneda Then
                           mCambioDeMoneda = False
                           Exit Do
                        End If
                     End If
                     oRs1.Close
                  End If
               End If
               .MoveNext
            Loop
         End If
      End If
   End With
   Set oRs = Nothing
   Set oRs1 = Nothing
   
   CambioDeMonedaValido = mCambioDeMoneda

End Function

Public Sub AsignarRubrosContables()

   If mvarTotalValores > 0 And ListaRubrosContables.ListItems.Count > 0 Then
      Dim oL As ListItem
      Dim oDet As DetOrdenPagoRubrosContables
      Dim i As Integer
      i = ListaRubrosContables.ListItems.Count
      For Each oL In ListaRubrosContables.ListItems
         Set oDet = origen.DetOrdenesPagoRubrosContables.Item(oL.Tag)
         With oDet
            .Registro.Fields("Importe").Value = Round(mvarTotalValores / i, 2)
            .Modificado = True
            oL.SubItems(1) = Round(mvarTotalValores / i, 2)
         End With
         Set oDet = Nothing
      Next
   End If
   
End Sub

Public Sub CalcularRubrosContables()

   If Check7.Value = 1 Then
      Set ListaRubrosContables.DataSource = origen.DetOrdenesPagoRubrosContables.RegistrosConFormatoCalculados
   End If

End Sub

Public Sub AnularValor(ByVal mIdDetalleOrdenPagoValores As Long)

   Dim oRs1 As ADOR.Recordset
   Dim oAp As ComPronto.Aplicacion
   Dim oValor As ComPronto.Valor
   Dim oL As ListItem
   Dim mIdValor As Long
   
   If Not cmd(0).Enabled Then
      MsgBox "No puede anular un valor si no esta habilitada la modificacion de la op", vbExclamation
      Exit Sub
   End If
   
   Set oRs1 = Aplicacion.Valores.TraerFiltrado("_PorIdDetalleOrdenPagoValores", mIdDetalleOrdenPagoValores)
   mIdValor = 0
   If oRs1.RecordCount > 0 Then
      mIdValor = IIf(IsNull(oRs1.Fields("IdValor").Value), 0, oRs1.Fields("IdValor").Value)
      If oRs1.Fields("IdTipoValor").Value <> 6 Then
         MsgBox "Solo un valor puede ser anulado", vbExclamation
         GoTo Salir
      End If
      If IIf(IsNull(oRs1.Fields("Anulado").Value), "NO", oRs1.Fields("Anulado").Value) = "SI" Then
         MsgBox "El valor ya ha sido anulado", vbExclamation
         GoTo Salir
      End If
      If (Not IsNull(oRs1.Fields("Conciliado").Value) And oRs1.Fields("Conciliado").Value = "SI") Or _
         (Not IsNull(oRs1.Fields("MovimientoConfirmadoBanco").Value) And oRs1.Fields("MovimientoConfirmadoBanco").Value = "SI") Then
         MsgBox "Cuidado, el valor que desea anular" & vbCrLf & "esta marcado como conciliado/confirmado", vbInformation
         GoTo Salir
      End If
   Else
      MsgBox "El valor no existe, no puede ser anulado", vbExclamation
      GoTo Salir
   End If
   oRs1.Close
   
   Dim oF As frmAutorizacion
   Dim mUsuario As String
   Dim mIdAnulo As Long
   Dim mOk As Boolean
   Set oF = New frmAutorizacion
   
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.OrdenesPago
      '.Administradores = True
      .Show vbModal, Me
      mOk = .Ok
      mUsuario = .Autorizo
      mIdAnulo = .IdAutorizo
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then
      Exit Sub
   End If
   
   Me.Refresh
   
   Dim mSeguro As Integer
   mSeguro = MsgBox("Esta seguro de anular el valor?", vbYesNo, "Anulacion de valores")
   If mSeguro = vbNo Then GoTo Salir

   Dim oF1 As frmAnulacion
   Dim mMotivoAnulacion As String
   Set oF1 = New frmAnulacion
   With oF1
      .Caption = "Motivo de anulacion del valor"
      .Text1.Text = "Usuario : " & mUsuario & " - [" & Now & "]"
      .Show vbModal, Me
      mOk = .Ok
   End With
   mMotivoAnulacion = mId(oF1.rchAnulacion.Text, 1, 30)
   Unload oF1
   Set oF1 = Nothing
   If Not mOk Then
      MsgBox "Anulacion cancelada!", vbExclamation
      Exit Sub
   End If
   
'   Set oAp = Aplicacion
'   Set oValor = oAp.Valores.Item(mIdValor)
'   With oValor
   With origen.DetOrdenesPagoValores.Item(mIdDetalleOrdenPagoValores)
      With .Registro
         .Fields("Anulado").Value = "SI"
         .Fields("IdUsuarioAnulo").Value = mIdAnulo
         .Fields("FechaAnulacion").Value = Now
         .Fields("MotivoAnulacion").Value = mMotivoAnulacion
      End With
      .Modificado = True
'      .Guardar
   End With
   
'   oAp.Tarea "Asientos_EliminarItemChequePagoDiferido", Array("0", 0, mIdValor)
   
   For Each oL In ListaVal.ListItems
      If oL.Tag = mIdDetalleOrdenPagoValores Then
         oL.Text = oL.Text & " AN"
         Exit For
      End If
   Next
   
   CalculaTotales
   
'   mvarAnuloValor = True

Salir:
   
   Set oF = Nothing
   Set oF1 = Nothing
   Set oRs1 = Nothing
   Set oValor = Nothing
   Set oAp = Nothing

End Sub

Private Sub EditarComprobante(ByVal TipoComprobante As Long, ByVal Identificador As Long)

   Dim oF As Form
      
   Select Case TipoComprobante
      Case 10, 11, 13, 18, 19, 31, 34
         Set oF = New frmComprobantesPrv
      Case 17
         Set oF = New frmOrdenesPago
      Case Else
         MsgBox "Comprobante no editable"
         GoTo Salida:
   End Select
   
   With oF
      .Id = Identificador
      .Disparar = ActL3
      .Show vbModal, Me
   End With

Salida:
   Set oF = Nothing

End Sub

Public Function MostrarRendicionesFF() As String

   MostrarRendicionesFF = ""
   If IsNumeric(dcfields(0).BoundText) And Len(txtNumeroRendicionFF.Text) > 0 Then
      Dim s As String
      Dim i As Integer
      Dim oRs As ADOR.Recordset
      
      s = ""
      i = 0
      
      Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PorRendicionFF", Array(dcfields(0).BoundText, txtNumeroRendicionFF.Text))
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            s = s & vbCrLf & "OP " & oRs.Fields(0).Value & "   "
            If oRs.Fields("IdOrdenPago").Value <> mvarId Then i = i + 1
            oRs.MoveNext
         Loop
      End If
      oRs.Close
      Set oRs = Nothing
      
      mRendicionesFF = s
      MostrarRendicionesFF = s
      If Val(txtNumeroRendicionFF.Text) > 0 And Me.Visible And i > 0 Then cmdVerOtrasOp_Click
   End If

End Function
