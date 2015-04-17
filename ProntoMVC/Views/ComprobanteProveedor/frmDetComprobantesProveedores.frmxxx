VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetComprobantesProveedores 
   Caption         =   "Item de comprobante de proveedores"
   ClientHeight    =   8160
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8760
   Icon            =   "frmDetComprobantesProveedores.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8160
   ScaleWidth      =   8760
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   1935
      TabIndex        =   86
      Top             =   3555
      Visible         =   0   'False
      Width           =   1005
   End
   Begin VB.TextBox txtCodigoArticulo1 
      Alignment       =   2  'Center
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1620
      TabIndex        =   83
      Top             =   2700
      Width           =   1725
   End
   Begin VB.CommandButton cmd 
      BackColor       =   &H00C0C0FF&
      Caption         =   "Subcontratos"
      CausesValidation=   0   'False
      Height          =   285
      Index           =   2
      Left            =   90
      Style           =   1  'Graphical
      TabIndex        =   82
      Top             =   3735
      Visible         =   0   'False
      Width           =   1470
   End
   Begin VB.CheckBox Check4 
      Alignment       =   1  'Right Justify
      Caption         =   "Ampliacion de subcontrato origen"
      Height          =   195
      Left            =   6705
      TabIndex        =   81
      Top             =   7740
      Visible         =   0   'False
      Width           =   2760
   End
   Begin VB.TextBox txtPorcentajeAnticipo 
      Alignment       =   2  'Center
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
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
      Height          =   315
      Left            =   8055
      TabIndex        =   74
      Top             =   2295
      Visible         =   0   'False
      Width           =   600
   End
   Begin VB.TextBox txtCantidad 
      Alignment       =   2  'Center
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1620
      TabIndex        =   68
      Top             =   2295
      Visible         =   0   'False
      Width           =   600
   End
   Begin VB.TextBox txtCodigoArticulo 
      Alignment       =   2  'Center
      DataField       =   "CodigoArticulo"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1620
      TabIndex        =   65
      Top             =   1935
      Visible         =   0   'False
      Width           =   1725
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
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
      Height          =   255
      Left            =   7920
      TabIndex        =   63
      Top             =   3825
      Width           =   600
   End
   Begin VB.TextBox txtPorcentajeProvinciaDestino2 
      Alignment       =   1  'Right Justify
      DataField       =   "PorcentajeProvinciaDestino2"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Left            =   7920
      TabIndex        =   62
      Top             =   3495
      Width           =   600
   End
   Begin VB.TextBox txtImportacion_FOB 
      Alignment       =   1  'Right Justify
      DataField       =   "Importacion_FOB"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Left            =   1800
      TabIndex        =   44
      Top             =   6300
      Width           =   1590
   End
   Begin VB.TextBox txtImportacion_PosicionAduana 
      DataField       =   "Importacion_PosicionAduana"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Left            =   5445
      TabIndex        =   43
      Top             =   6300
      Width           =   3210
   End
   Begin VB.TextBox txtImportacion_Despacho 
      DataField       =   "Importacion_Despacho"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Left            =   1800
      TabIndex        =   42
      Top             =   6705
      Width           =   3570
   End
   Begin VB.TextBox txtImportacion_Guia 
      DataField       =   "Importacion_Guia"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Left            =   6030
      TabIndex        =   41
      Top             =   6705
      Width           =   2625
   End
   Begin VB.TextBox txtNumeroPedido 
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
      Left            =   6120
      TabIndex        =   39
      Top             =   45
      Width           =   825
   End
   Begin VB.TextBox txtSubNumeroPedido 
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
      Left            =   7110
      TabIndex        =   40
      Top             =   45
      Width           =   330
   End
   Begin VB.CheckBox Check3 
      Alignment       =   1  'Right Justify
      Caption         =   "NO tomar este item en el calculo de imp. a las ganancias e IIBB : "
      Height          =   375
      Left            =   105
      TabIndex        =   36
      Top             =   3105
      Width           =   2760
   End
   Begin VB.TextBox txtNumeroRequerimiento 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
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
      Left            =   3330
      TabIndex        =   34
      Top             =   45
      Width           =   915
   End
   Begin VB.TextBox txtItemRequerimiento 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
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
      Height          =   300
      Left            =   4860
      TabIndex        =   33
      Top             =   45
      Width           =   420
   End
   Begin VB.TextBox txtItemPedido 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
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
      Height          =   300
      Left            =   8190
      TabIndex        =   30
      Top             =   45
      Width           =   510
   End
   Begin VB.TextBox txtNumeroRecepcion 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
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
      Height          =   315
      Left            =   1125
      TabIndex        =   27
      Top             =   45
      Width           =   870
   End
   Begin VB.TextBox txtPorcentajeIVADirecto 
      Alignment       =   1  'Right Justify
      DataField       =   "IVAComprasPorcentajeDirecto"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Left            =   975
      TabIndex        =   23
      Top             =   4185
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.CheckBox Check2 
      Height          =   195
      Left            =   5895
      TabIndex        =   22
      Top             =   945
      Width           =   195
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   9
      Left            =   5580
      TabIndex        =   20
      Top             =   5805
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   8
      Left            =   5580
      TabIndex        =   19
      Top             =   5400
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   7
      Left            =   5580
      TabIndex        =   18
      Top             =   4995
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   6
      Left            =   5580
      TabIndex        =   17
      Top             =   4590
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   5
      Left            =   5580
      TabIndex        =   16
      Top             =   4185
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   4
      Left            =   2400
      TabIndex        =   14
      Top             =   5805
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   3
      Left            =   2400
      TabIndex        =   13
      Top             =   5400
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   2
      Left            =   2400
      TabIndex        =   12
      Top             =   4995
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   1
      Left            =   2400
      TabIndex        =   11
      Top             =   4590
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   0
      Left            =   2400
      TabIndex        =   10
      Top             =   4185
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "Importe"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Left            =   945
      TabIndex        =   4
      Top             =   4635
      Width           =   1275
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   90
      TabIndex        =   5
      Top             =   5175
      Width           =   2160
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   390
      Index           =   1
      Left            =   90
      TabIndex        =   6
      Top             =   5670
      Width           =   2160
   End
   Begin VB.TextBox txtCodigoCuenta 
      DataField       =   "CodigoCuenta"
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
      Left            =   3645
      TabIndex        =   1
      Top             =   495
      Width           =   960
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   0
      Left            =   4635
      TabIndex        =   2
      Tag             =   "Cuentas"
      Top             =   495
      Width           =   4080
      _ExtentX        =   7197
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaGasto"
      Height          =   315
      Index           =   1
      Left            =   6165
      TabIndex        =   3
      Tag             =   "CuentasGastos"
      Top             =   900
      Width           =   2550
      _ExtentX        =   4498
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaGasto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   2
      Left            =   1620
      TabIndex        =   0
      Tag             =   "Obras"
      Top             =   855
      Width           =   2805
      _ExtentX        =   4948
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   3
      Left            =   1620
      TabIndex        =   21
      Tag             =   "TiposCuentaGrupos"
      Top             =   495
      Width           =   1995
      _ExtentX        =   3519
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoCuentaGrupo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaBancaria"
      Height          =   315
      Index           =   4
      Left            =   5895
      TabIndex        =   25
      Tag             =   "CuentasBancarias"
      Top             =   1215
      Width           =   2820
      _ExtentX        =   4974
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaBancaria"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdRubroContable"
      Height          =   315
      Index           =   5
      Left            =   5910
      TabIndex        =   37
      Tag             =   "RubrosContables"
      Top             =   1575
      Width           =   2805
      _ExtentX        =   4948
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdRubroContable"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "Importacion_IdPaisOrigen"
      Height          =   315
      Index           =   6
      Left            =   1800
      TabIndex        =   45
      Tag             =   "Paises"
      Top             =   7110
      Width           =   3225
      _ExtentX        =   5689
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPais"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Importacion_FechaEmbarque"
      Height          =   330
      Index           =   0
      Left            =   1800
      TabIndex        =   46
      Top             =   7515
      Width           =   1500
      _ExtentX        =   2646
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      DateIsNull      =   -1  'True
      Format          =   57671681
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Importacion_FechaOficializacion"
      Height          =   330
      Index           =   1
      Left            =   5355
      TabIndex        =   47
      Top             =   7515
      Width           =   1500
      _ExtentX        =   2646
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      DateIsNull      =   -1  'True
      Format          =   57671681
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProvinciaDestino1"
      Height          =   315
      Index           =   7
      Left            =   4230
      TabIndex        =   55
      Tag             =   "Provincias"
      Top             =   3150
      Width           =   2505
      _ExtentX        =   4419
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProvincia"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProvinciaDestino2"
      Height          =   315
      Index           =   8
      Left            =   4230
      TabIndex        =   59
      Tag             =   "Provincias"
      Top             =   3465
      Width           =   2505
      _ExtentX        =   4419
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProvincia"
      Text            =   ""
   End
   Begin VB.TextBox txtPorcentajeProvinciaDestino1 
      Alignment       =   1  'Right Justify
      DataField       =   "PorcentajeProvinciaDestino1"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Left            =   7920
      TabIndex        =   58
      Top             =   3150
      Width           =   600
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   9
      Left            =   3375
      TabIndex        =   66
      Tag             =   "Articulos"
      Top             =   1935
      Visible         =   0   'False
      Width           =   5325
      _ExtentX        =   9393
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdDetalleObraDestino"
      Height          =   315
      Index           =   10
      Left            =   1620
      TabIndex        =   70
      Tag             =   "ObrasDestinos"
      Top             =   1215
      Visible         =   0   'False
      Width           =   2805
      _ExtentX        =   4948
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdDetalleObraDestino"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdPresupuestoObraRubro"
      Height          =   315
      Index           =   11
      Left            =   1620
      TabIndex        =   72
      Tag             =   "PresupuestoObrasRubros"
      Top             =   1575
      Visible         =   0   'False
      Width           =   2805
      _ExtentX        =   4948
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPresupuestoObraRubro"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdPresupuestoObrasNodo"
      Height          =   315
      Index           =   12
      Left            =   1665
      TabIndex        =   76
      Tag             =   "PresupuestoObrasNodos"
      Top             =   3690
      Visible         =   0   'False
      Width           =   960
      _ExtentX        =   1693
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPresupuestoObrasNodo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "NumeroSubcontrato"
      Height          =   315
      Index           =   13
      Left            =   8235
      TabIndex        =   77
      Tag             =   "SubcontratosDatos"
      Top             =   7065
      Visible         =   0   'False
      Width           =   1275
      _ExtentX        =   2249
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "NumeroSubcontrato"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSubcontrato"
      Height          =   315
      Index           =   14
      Left            =   8235
      TabIndex        =   79
      Tag             =   "Subcontratos"
      Top             =   7380
      Visible         =   0   'False
      Width           =   1275
      _ExtentX        =   2249
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdSubcontrato"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdEquipoDestino"
      Height          =   315
      Index           =   15
      Left            =   3420
      TabIndex        =   84
      Tag             =   "Articulos1"
      Top             =   2700
      Width           =   5235
      _ExtentX        =   9234
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Equipo destino :"
      Height          =   300
      Index           =   31
      Left            =   90
      TabIndex        =   85
      Top             =   2700
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      Caption         =   "Etapa subcontrato :"
      Height          =   210
      Index           =   30
      Left            =   6720
      TabIndex        =   80
      Top             =   7425
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      Caption         =   "Subcontrato :"
      Height          =   255
      Index           =   29
      Left            =   6720
      TabIndex        =   78
      Top             =   7110
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      Caption         =   "Porcentaje anticipo :"
      Height          =   255
      Index           =   28
      Left            =   6525
      TabIndex        =   75
      Top             =   2340
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      Caption         =   "Rubro p/presup. :"
      Height          =   255
      Index           =   27
      Left            =   105
      TabIndex        =   73
      Top             =   1620
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      Caption         =   "Etapa de la obra : "
      Height          =   255
      Index           =   26
      Left            =   105
      TabIndex        =   71
      Top             =   1260
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   255
      Index           =   25
      Left            =   90
      TabIndex        =   69
      Top             =   2340
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   255
      Index           =   24
      Left            =   105
      TabIndex        =   67
      Top             =   1980
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      Caption         =   "Total (100%) :"
      Height          =   210
      Index           =   23
      Left            =   6795
      TabIndex        =   64
      Top             =   3870
      Width           =   1050
   End
   Begin VB.Label lblLabels 
      Caption         =   "Porcentaje 2 :"
      Height          =   255
      Index           =   21
      Left            =   6795
      TabIndex        =   61
      Top             =   3510
      Width           =   1050
   End
   Begin VB.Label lblLabels 
      Caption         =   "Prov.destino 2 :"
      Height          =   255
      Index           =   20
      Left            =   3015
      TabIndex        =   60
      Top             =   3510
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Porcentaje 1 :"
      Height          =   255
      Index           =   19
      Left            =   6795
      TabIndex        =   57
      Top             =   3150
      Width           =   1050
   End
   Begin VB.Label lblLabels 
      Caption         =   "Prov.destino 1 :"
      Height          =   255
      Index           =   18
      Left            =   3015
      TabIndex        =   56
      Top             =   3150
      Width           =   1140
   End
   Begin VB.Line Line5 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      X1              =   2925
      X2              =   8640
      Y1              =   3105
      Y2              =   3105
   End
   Begin VB.Line Line4 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      X1              =   8685
      X2              =   8685
      Y1              =   4095
      Y2              =   3105
   End
   Begin VB.Line Line3 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      X1              =   2925
      X2              =   2925
      Y1              =   4095
      Y2              =   3105
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      Index           =   1
      X1              =   45
      X2              =   8640
      Y1              =   6210
      Y2              =   6210
   End
   Begin VB.Label lblLabels 
      Caption         =   "Valor FOB :"
      Height          =   285
      Index           =   17
      Left            =   45
      TabIndex        =   54
      Top             =   6345
      Width           =   1650
   End
   Begin VB.Label lblLabels 
      Caption         =   "Pais de origen :"
      Height          =   285
      Index           =   16
      Left            =   45
      TabIndex        =   53
      Top             =   7155
      Width           =   1650
   End
   Begin VB.Label lblLabels 
      Caption         =   "Posicion aduana :"
      Height          =   285
      Index           =   15
      Left            =   3690
      TabIndex        =   52
      Top             =   6345
      Width           =   1650
   End
   Begin VB.Label lblLabels 
      Caption         =   "Despacho : "
      Height          =   285
      Index           =   14
      Left            =   45
      TabIndex        =   51
      Top             =   6750
      Width           =   1650
   End
   Begin VB.Label lblLabels 
      Caption         =   "Guia :"
      Height          =   285
      Index           =   13
      Left            =   5445
      TabIndex        =   50
      Top             =   6750
      Width           =   525
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de embarque :"
      Height          =   285
      Index           =   22
      Left            =   45
      TabIndex        =   49
      Top             =   7560
      Width           =   1650
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de oficializacion :"
      Height          =   285
      Index           =   12
      Left            =   3510
      TabIndex        =   48
      Top             =   7560
      Width           =   1740
   End
   Begin VB.Line Line2 
      BorderColor     =   &H80000005&
      BorderWidth     =   3
      X1              =   7065
      X2              =   6975
      Y1              =   90
      Y2              =   315
   End
   Begin VB.Label lblLabels 
      Caption         =   "Rubro financiero :"
      Height          =   255
      Index           =   11
      Left            =   4500
      TabIndex        =   38
      Top             =   1620
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Requerimiento :"
      Height          =   255
      Index           =   10
      Left            =   2115
      TabIndex        =   35
      Top             =   75
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item :"
      Height          =   255
      Index           =   9
      Left            =   4320
      TabIndex        =   32
      Top             =   90
      Width           =   465
   End
   Begin VB.Label lblLabels 
      Caption         =   "Pedido : "
      Height          =   255
      Index           =   8
      Left            =   5400
      TabIndex        =   31
      Top             =   75
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item :"
      Height          =   255
      Index           =   7
      Left            =   7560
      TabIndex        =   29
      Top             =   75
      Width           =   555
   End
   Begin VB.Label lblLabels 
      Caption         =   "Recepcion :"
      Height          =   255
      Index           =   6
      Left            =   135
      TabIndex        =   28
      Top             =   75
      Width           =   915
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta banco :"
      Height          =   255
      Index           =   5
      Left            =   4515
      TabIndex        =   26
      Top             =   1260
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "% Iva :"
      Height          =   300
      Index           =   1
      Left            =   135
      TabIndex        =   24
      Top             =   4230
      Visible         =   0   'False
      Width           =   780
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obra : "
      Height          =   255
      Index           =   0
      Left            =   105
      TabIndex        =   15
      Top             =   900
      Width           =   1455
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      Index           =   0
      X1              =   45
      X2              =   8640
      Y1              =   4095
      Y2              =   4095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta de gasto :"
      Height          =   255
      Index           =   4
      Left            =   4500
      TabIndex        =   9
      Top             =   900
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe :"
      Height          =   300
      Index           =   3
      Left            =   105
      TabIndex        =   8
      Top             =   4680
      Width           =   780
   End
   Begin VB.Label lblLabels 
      Caption         =   "Todas las cuentas :"
      Height          =   300
      Index           =   2
      Left            =   105
      TabIndex        =   7
      Top             =   480
      Width           =   1455
   End
End
Attribute VB_Name = "frmDetComprobantesProveedores"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetComprobanteProveedor
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oComprobanteProveedor As ComPronto.ComprobanteProveedor
Public Aceptado As Boolean, mActivarCamposParaFF As Boolean, mArticuloVisible As Boolean
Public TotalIva As Double
Private mvarIdNuevo As Long, mvarId As Long, mvarIdObra As Long, mvarIdPedido As Long, mvarIdCuentaContable As Long
Private mvarDecimales As Integer, mvarIdProvinciaDestino As Integer, mvarIdTipoCuentaGrupoIVA As Integer
Private mvarIdTipoCuentaGrupoPercepciones As Integer
Private mLetra As String, mvarControlarRubrosContablesEnCP As String, mvarAnticipo_O_Devolucion As String, mIVAs As String
Private mvarADistribuir As String, mvarADistribuirEnPresupuestoDeObra As String, mvarRegistroContableComprasAlActivo As String
Private mvarBasePRONTOMantenimiento As String
Private mvarFechaComprobante As Date
Private mvarPorcentajeAnticipo As Single
Private mvarPresupuestadorObraNuevo As Boolean

Private Sub Check2_Click()

   If Check2.Value = 0 Then
      Dim mIdCuenta As Long
      Dim mAuxS1 As String
      origen.Registro.Fields(DataCombo1(1).DataField).Value = Null
      If Not glbIdCuentaFFUsuario <> -1 Then txtCodigoCuenta.Enabled = True
      mIdCuenta = 0
      With DataCombo1(0)
         If IsNumeric(.BoundText) Then mIdCuenta = .BoundText
         If glbIdCuentaFFUsuario <> -1 Then
            Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorGrupoParaCombo", mvarIdTipoCuentaGrupoIVA)
            If mActivarCamposParaFF Then
               mAuxS1 = BuscarClaveINI("Grupos de cuenta para ingreso por FF")
               If Len(mAuxS1) > 0 Then
                  Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorGruposParaCombo", mAuxS1)
               End If
            Else
               mAuxS1 = BuscarClaveINI("Grupos de cuenta para ingreso por obra")
               If Len(mAuxS1) > 0 Then
                  Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorGruposParaCombo", mAuxS1)
               End If
            End If
         Else
            mAuxS1 = BuscarClaveINI("Grupos de cuenta para ingreso por obra")
            If Len(mAuxS1) > 0 Then
               Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorGruposParaCombo", mAuxS1)
            Else
               Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_ParaComprobantesProveedores")
            End If
         End If
         origen.Registro.Fields(.DataField).Value = mIdCuenta
         .Enabled = True
      End With
      With DataCombo1(3)
         .BoundText = 0
         .Enabled = True
      End With
   End If
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Dim oF As frm_Aux
   Dim mOk As Boolean
   
   Select Case Index
      Case 0
'         If Not IsNumeric(DataCombo1(0).BoundText) Then
         If Len(txtCodigoCuenta.Text) = 0 Then
            MsgBox "Debe definir una cuenta contable a imputar", vbExclamation
            Exit Sub
         End If
         
         If txtPorcentajeIVADirecto.Visible And _
            (Len(txtPorcentajeIVADirecto.Text) = 0 Or Not IsNumeric(txtPorcentajeIVADirecto.Text)) Then
            MsgBox "El porcentaje de IVA del item no es valido!", vbInformation
            Exit Sub
         End If
      
         If DataCombo1(4).Enabled And Not IsNumeric(DataCombo1(4).BoundText) Then
            MsgBox "Debe indicar la cuenta banco", vbExclamation
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         
         With origen.Registro
            For Each dc In DataCombo1
               If IsNumeric(dc.BoundText) And Len(dc.DataField) > 0 Then .Fields(dc.DataField).Value = dc.BoundText
            Next
            For Each dtp In DTFields
               If dtp.Enabled Then
                  .Fields(dtp.DataField).Value = dtp.Value
               Else
                  .Fields(dtp.DataField).Value = Null
               End If
            Next
         End With
         
         If Val(txtTotal.Text) <> 100 Then
            MsgBox "El total porcentaje a distribuir por provincias debe ser 100%", vbInformation
            Exit Sub
         End If
      
         If Val(txtPorcentajeProvinciaDestino2.Text) <> 0 And Not IsNumeric(origen.Registro.Fields("IdProvinciaDestino2").Value) Then
            MsgBox "No definio la provincia destino 2", vbInformation
            Exit Sub
         End If
      
         If mvarControlarRubrosContablesEnCP = "SI" And Not IsNumeric(DataCombo1(5).BoundText) Then
            MsgBox "Debe ingresar el rubro financiero", vbExclamation
            Exit Sub
         End If
         
         If BuscarClaveINI("Exigir etapa de obra en circuito de compras para comprobante de proveedores") = "SI" Then
            If DataCombo1(10).Visible And DataCombo1(10).Enabled And Len(DataCombo1(10).Text) = 0 Then
               MsgBox "Debe ingresar la etapa de la obra", vbExclamation
               Exit Sub
            End If
            If DataCombo1(11).Visible And DataCombo1(11).Enabled And Not IsNumeric(DataCombo1(11).BoundText) Then
               MsgBox "Debe ingresar el rubro para presupuesto de obra", vbExclamation
               Exit Sub
            End If
         End If
         
         Dim i As Integer
         Dim mIdPedido As Long, mIdProveedor As Long
         Dim mError As Boolean
         Dim s As String, mJerarquia As String
         Dim oRs As ADOR.Recordset
         Dim mVector, mVector1
         
         If glbModeloContableSinApertura = "SI" And DataCombo1(2).Visible And Not IsNumeric(DataCombo1(2).BoundText) Then
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorId", origen.Registro.Fields("IdCuenta").Value)
            If oRs.RecordCount > 0 Then
               mJerarquia = IIf(IsNull(oRs.Fields("Jerarquia").Value), "", oRs.Fields("Jerarquia").Value)
            End If
            oRs.Close
            If mId(mJerarquia, 1, 1) = "5" Then
               MsgBox "Debe ingresar la obra / centro de costos", vbExclamation
               Exit Sub
            End If
         End If
         
         If Len(Trim(txtNumeroPedido.Text)) <> 0 Then
            If Not Len(Trim(txtSubNumeroPedido.Text)) = 0 And IsNumeric(txtSubNumeroPedido.Text) Then
               mIdProveedor = IIf(IsNull(oComprobanteProveedor.Registro.Fields("IdProveedor").Value), -1, oComprobanteProveedor.Registro.Fields("IdProveedor").Value)
               Set oRs = Aplicacion.Pedidos.TraerFiltrado("_PorNumero", Array(Val(txtNumeroPedido.Text), Val(txtSubNumeroPedido.Text)))  ', -1, -1, mIdProveedor))
               mError = False
               If oRs.RecordCount = 1 Then
                  origen.Registro.Fields("IdPedido").Value = oRs.Fields("IdPedido").Value
                  mIdPedido = oRs.Fields("IdPedido").Value
               ElseIf oRs.RecordCount > 1 Then
                  Set oF = New frm_Aux
                  With oF
                     .Caption = "Elegir pedido"
                     .Id = 22
                     .Label1.Visible = False
                     .text1.Visible = False
                     .Width = .Width * 2
                     .Height = .Height * 2
                     With .Lista
                        .CheckBoxes = True
                        Set .DataSource = oRs
                        .Visible = True
                     End With
                     .cmd(0).Top = .Height - .cmd(0).Height * 2.5
                     .cmd(1).Top = .cmd(0).Top
                     .Show vbModal, Me
                     mOk = .Ok
                     s = .Lista.GetStringCheck
                     mVector = VBA.Split(s, vbCrLf)
                     If UBound(mVector) = 0 Then
                        MsgBox "Debe elegir un pedido", vbExclamation
                        mIdPedido = 0
                     ElseIf UBound(mVector) > 1 Then
                        MsgBox "Debe elegir solo un pedido", vbExclamation
                        mIdPedido = 0
                     Else
                        mVector1 = VBA.Split(mVector(1), vbTab)
                        mIdPedido = mVector1(2)
                     End If
                  End With
                  Unload oF
                  Set oF = Nothing
                  If Not mOk Or mIdPedido = 0 Then Exit Sub
                  origen.Registro.Fields("IdPedido").Value = mIdPedido
               Else
                  origen.Registro.Fields("IdPedido").Value = Null
                  mError = True
               End If
               oRs.Close
               Set oRs = Nothing
               If mError Then
                  MsgBox "El pedido no existe, corrijalo o borrelo", vbExclamation
                  Exit Sub
               End If
            Else
               MsgBox "Debe ingresar el subnumero de pedido o borrar el numero de pedido", vbExclamation
               Exit Sub
            End If
         End If
         
         If Len(Trim(txtItemPedido.Text)) <> 0 Then
            If mIdPedido > 0 Then
               Set oRs = Aplicacion.Pedidos.TraerFiltrado("_DetallesPorId", Array(mIdPedido, Val(txtItemPedido.Text)))
               If oRs.RecordCount > 0 Then
                  origen.Registro.Fields("IdDetallePedido").Value = oRs.Fields("IdDetallePedido").Value
               Else
                  oRs.Close
                  Set oRs = Nothing
                  MsgBox "No se encontro el item " & txtItemPedido.Text & " del pedido " & txtNumeroPedido.Text, vbExclamation
                  Exit Sub
               End If
               oRs.Close
               Set oRs = Nothing
            Else
               MsgBox "Ingreso un item de pedido pero no el numero del pedido", vbExclamation
               Exit Sub
            End If
         Else
            origen.Registro.Fields("IdDetallePedido").Value = Null
         End If
         
         Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
         
         With origen.Registro
            TotalIva = 0
            mIVAs = ""
            For i = 1 To 10
               If Check1(i - 1).Value = 1 Then
                  .Fields("AplicarIVA" & i).Value = "SI"
                  .Fields("IdCuentaIvaCompras" & i).Value = oRs.Fields("IdCuentaIvaCompras" & i).Value
                  .Fields("IVAComprasPorcentaje" & i).Value = oRs.Fields("IVAComprasPorcentaje" & i).Value
                  If Me.Letra = "A" Or Me.Letra = "M" Then
                     .Fields("ImporteIVA" & i).Value = Round(CDbl(.Fields("Importe").Value) * CDbl(oRs.Fields("IVAComprasPorcentaje" & i).Value) / 100, mvarDecimales)
                  Else
                     .Fields("ImporteIVA" & i).Value = Round(CDbl(.Fields("Importe").Value) - (CDbl(.Fields("Importe").Value) / (1 + (CDbl(oRs.Fields("IVAComprasPorcentaje" & i).Value) / 100))), mvarDecimales)
                  End If
                  TotalIva = TotalIva + .Fields("ImporteIVA" & i).Value
                  mIVAs = mIVAs & Format(.Fields("IVAComprasPorcentaje" & i).Value, "##0.00") & "%  "
               Else
                  .Fields("AplicarIVA" & i).Value = "NO"
                  .Fields("ImporteIVA" & i).Value = 0
                  .Fields("IVAComprasPorcentaje" & i).Value = 0
               End If
            Next
            If Check3.Value = 1 Then
               .Fields("TomarEnCalculoDeImpuestos").Value = "NO"
            Else
               .Fields("TomarEnCalculoDeImpuestos").Value = "SI"
            End If
'            If Check4.Value = 1 And DataCombo1(13).Visible And IsNumeric(DataCombo1(13).BoundText) Then
'               .Fields("AmpliacionSubcontrato").Value = "SI"
'            Else
'               .Fields("AmpliacionSubcontrato").Value = Null
'            End If
         End With
         origen.Modificado = True
         Aceptado = True
         
         oRs.Close
         Set oRs = Nothing
         
         If DataCombo1(9).Visible And DataCombo1(10).Visible And mvarADistribuirEnPresupuestoDeObra = "SI" Then
            MsgBox "Este item solo saldra en el presupuesto de obra cuando" & vbCrLf & "se produzca la salida.", vbInformation
         End If
         
         Me.Hide
      
      Case 1
         Me.Hide
   
      Case 2
         Dim mNumeroSubcontrato As Long, mIdSubcontrato As Long, mIdDetalleSubcontratoDatos As Long
         Dim mAmpliacionSubcontrato As String
         
         With origen.Registro
            mNumeroSubcontrato = IIf(IsNull(.Fields("NumeroSubcontrato").Value), 0, .Fields("NumeroSubcontrato").Value)
            mIdSubcontrato = IIf(IsNull(.Fields("IdSubcontrato").Value), 0, .Fields("IdSubcontrato").Value)
            mIdDetalleSubcontratoDatos = IIf(IsNull(.Fields("IdDetalleSubcontratoDatos").Value), 0, .Fields("IdDetalleSubcontratoDatos").Value)
            mAmpliacionSubcontrato = IIf(IsNull(.Fields("AmpliacionSubcontrato").Value), "", .Fields("AmpliacionSubcontrato").Value)
         End With
         
         Set oF = New frm_Aux
         With oF
            .Id = 19
            .text1.Visible = False
            .Label1.Caption = "Etapa :"
            With .Label2(0)
               .Caption = "Subcontrato :"
               .Visible = True
            End With
            With .Label2(1)
               .Caption = "Nro.Certificado :"
               .Visible = True
            End With
            With .dcfields(0)
               .Top = oF.DTFields(0).Top
               .Left = oF.DTFields(0).Left
               .Width = oF.DTFields(0).Width * 3
               .BoundColumn = "NumeroSubcontrato"
               If Not IsNull(oComprobanteProveedor.Registro.Fields("IdProveedor").Value) Then
                  Set .RowSource = Aplicacion.Subcontratos.TraerFiltrado("_DatosParaCombo", oComprobanteProveedor.Registro.Fields("IdProveedor").Value)
               Else
                  Set .RowSource = Aplicacion.Subcontratos.TraerFiltrado("_DatosParaCombo")
               End If
               .BoundText = mNumeroSubcontrato
               .Visible = True
            End With
            If Me.Anticipo_O_Devolucion = "A" Then
               .Label1.Visible = False
               .Label2(1).Visible = False
            Else
               With .dcfields(1)
                  .Top = oF.text1.Top
                  .Left = oF.text1.Left
                  .Width = oF.dcfields(0).Width
                  .BoundColumn = "IdSubcontrato"
                  If mNumeroSubcontrato <> 0 Then
                     Set .RowSource = Aplicacion.Subcontratos.TraerFiltrado("_EtapasParaCombo", mNumeroSubcontrato)
                     .BoundText = mIdSubcontrato
                  End If
                  .Visible = True
               End With
               With .dcfields(2)
                  .Top = oF.DTFields(1).Top
                  .Left = oF.DTFields(1).Left
                  .Width = oF.DTFields(1).Width * 3
                  .BoundColumn = "IdDetalleSubcontratoDatos"
                  If mNumeroSubcontrato <> 0 Then
                     Set .RowSource = Aplicacion.TablasGenerales.TraerFiltrado("DetSubcontratosDatos", "_ParaComboPorNumeroSubcontrato", mNumeroSubcontrato)
                     .BoundText = mIdDetalleSubcontratoDatos
                  End If
                  .Visible = True
               End With
            End If
            With .Check1
               .Top = oF.Label2(1).Top + oF.Label2(1).Height + 100
               .Left = oF.Label2(1).Left
               .Width = oF.DTFields(0).Width * 3
               .Caption = "Ampliacion de subcontrato origen"
               If mAmpliacionSubcontrato = "SI" Then .Value = 1
               .Visible = True
            End With
            .Width = .Width * 2
            .Show vbModal, Me
            mOk = .Ok
            mNumeroSubcontrato = 0
            If IsNumeric(.dcfields(0).BoundText) Then mNumeroSubcontrato = .dcfields(0).BoundText
            mIdSubcontrato = 0
            If IsNumeric(.dcfields(1).BoundText) Then mIdSubcontrato = .dcfields(1).BoundText
            mIdDetalleSubcontratoDatos = 0
            If IsNumeric(.dcfields(2).BoundText) Then mIdDetalleSubcontratoDatos = .dcfields(2).BoundText
            mAmpliacionSubcontrato = ""
            If .Check1.Value = 1 Then mAmpliacionSubcontrato = "SI"
         End With
         Unload oF
         Set oF = Nothing
         If Not mOk Then Exit Sub
         
         With origen.Registro
            If Me.Anticipo_O_Devolucion = "A" Then
               If mNumeroSubcontrato = 0 Then
                  MsgBox "No se ingreso el numero de subcontrato, los datos de subcontrato no fueron registrados", vbInformation
                  .Fields("NumeroSubcontrato").Value = Null
                  .Fields("IdSubcontrato").Value = Null
                  .Fields("IdDetalleSubcontratoDatos").Value = Null
                  .Fields("AmpliacionSubcontrato").Value = Null
               Else
                  .Fields("NumeroSubcontrato").Value = mNumeroSubcontrato
                  .Fields("IdSubcontrato").Value = Null
                  .Fields("IdDetalleSubcontratoDatos").Value = Null
                  If mAmpliacionSubcontrato = "SI" Then
                     .Fields("AmpliacionSubcontrato").Value = mAmpliacionSubcontrato
                  Else
                     .Fields("AmpliacionSubcontrato").Value = Null
                  End If
               End If
            Else
               If mNumeroSubcontrato = 0 Or mIdSubcontrato = 0 Or mIdDetalleSubcontratoDatos = 0 Then
                  DoEvents
                  If mNumeroSubcontrato = 0 Then MsgBox "No se ingreso el numero de subcontrato, los datos de subcontrato no fueron registrados", vbInformation
                  If mIdSubcontrato = 0 Then MsgBox "No se ingreso la etapa del subcontrato, los datos de subcontrato no fueron registrados", vbInformation
                  If mIdDetalleSubcontratoDatos = 0 Then MsgBox "No se ingreso el numero de certificado, los datos de subcontrato no fueron registrados", vbInformation
                  .Fields("NumeroSubcontrato").Value = Null
                  .Fields("IdSubcontrato").Value = Null
                  .Fields("IdDetalleSubcontratoDatos").Value = Null
                  .Fields("AmpliacionSubcontrato").Value = Null
               Else
                  .Fields("NumeroSubcontrato").Value = mNumeroSubcontrato
                  If mIdSubcontrato = 0 Then
                     .Fields("IdSubcontrato").Value = Null
                  Else
                     .Fields("IdSubcontrato").Value = mIdSubcontrato
                  End If
                  If mIdDetalleSubcontratoDatos = 0 Then
                     .Fields("IdDetalleSubcontratoDatos").Value = Null
                  Else
                     .Fields("IdDetalleSubcontratoDatos").Value = mIdDetalleSubcontratoDatos
                  End If
                  If mAmpliacionSubcontrato = "SI" Then
                     .Fields("AmpliacionSubcontrato").Value = mAmpliacionSubcontrato
                  Else
                     .Fields("AmpliacionSubcontrato").Value = Null
                  End If
               End If
            End If
            If Not IsNull(.Fields("NumeroSubcontrato").Value) Then
               cmd(2).BackColor = &HC0FFC0
            Else
               cmd(2).BackColor = &HC0C0FF
            End If
         End With
   
   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim oRsPar As ADOR.Recordset
   Dim i As Integer, mvarIdMonedaPesos As Integer, mvarIdMonedaDolar As Integer
   Dim mAuxS1 As String
   Dim mTotalPedido As Double, mTotalAnticipos As Double
   Dim mAux1

   mvarId = vnewvalue
   
   mvarADistribuir = ""
   mvarADistribuirEnPresupuestoDeObra = ""
   
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   With oRs
      mvarIdMonedaPesos = .Fields("IdMoneda").Value
      mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
      mvarBasePRONTOMantenimiento = IIf(IsNull(.Fields("BasePRONTOMantenimiento").Value), "", .Fields("BasePRONTOMantenimiento").Value)
      .Close
   End With
   
   mActivarCamposParaFF = False
   If BuscarClaveINI("Activar campos para FF") = "SI" And glbIdCuentaFFUsuario <> -1 Then mActivarCamposParaFF = True
   
   mArticuloVisible = False
   If BuscarClaveINI("Requerir articulo en comprobantes de proveedores") = "SI" Then
      mArticuloVisible = True
      DataCombo1(9).Visible = True
      lblLabels(24).Visible = True
      txtCodigoArticulo.Visible = True
      lblLabels(25).Visible = True
      txtCantidad.Visible = True
   End If
   
   mvarPresupuestadorObraNuevo = False
   If BuscarClaveINI("Presupuestador de obra nuevo") = "SI" Then mvarPresupuestadorObraNuevo = True
   
   If BuscarClaveINI("Exigir etapa de obra en circuito de compras para comprobante de proveedores") = "SI" Then
      If mvarPresupuestadorObraNuevo Then
         With DataCombo1(12)
            .Top = DataCombo1(10).Top
            .Left = DataCombo1(10).Left
            .Width = DataCombo1(10).Width
            .Visible = True
         End With
         DataCombo1(10).Visible = False
      Else
         DataCombo1(10).Visible = True
         lblLabels(27).Visible = True
         DataCombo1(11).Visible = True
      End If
      lblLabels(26).Visible = True
   End If
   
   If BuscarClaveINI("Activar subcontratos") = "SI" Then
      cmd(2).Visible = True
'      DataCombo1(13).Visible = True
'      lblLabels(29).Visible = True
'      DataCombo1(14).Visible = True
'      lblLabels(30).Visible = True
   End If
   
   If BuscarClaveINI("Ocultar equipo destino y OT") = "SI" Then
      lblLabels(31).Visible = False
      txtCodigoArticulo1.Visible = False
      DataCombo1(15).Visible = False
   End If
   
   mAux1 = TraerValorParametro2("RegistroContableComprasAlActivo")
   mvarRegistroContableComprasAlActivo = IIf(IsNull(mAux1), "NO", mAux1)
   
   mAux1 = TraerValorParametro2("IdTipoCuentaGrupoPercepciones")
   mvarIdTipoCuentaGrupoPercepciones = IIf(IsNull(mAux1), 0, mAux1)
   
   Set oAp = Aplicacion
   Set origen = oComprobanteProveedor.DetComprobantesProveedores.Item(vnewvalue)
   Me.IdNuevo = origen.Id
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DTPicker Then
            If Len(oControl.DataField) Then .Add oControl, "value", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "CuentasBancarias" Then
                  Set oControl.RowSource = oAp.CuentasBancarias.TraerFiltrado("_TodasParaCombo")
               ElseIf oControl.Tag = "RubrosContables" Then
                  Set oControl.RowSource = oAp.RubrosContables.TraerFiltrado("_ParaComboFinancierosEgresos")
               ElseIf oControl.Tag = "Obras" Then
                  If glbSeñal1 Then
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", Me.FechaComprobante))
                  Else
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo")
                  End If
               ElseIf oControl.Tag = "Cuentas" Then
                  If glbSeñal1 Then
                     Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_PorFechaParaCombo", Me.FechaComprobante)
                  Else
                     If mActivarCamposParaFF Then
                        mAuxS1 = BuscarClaveINI("Grupos de cuenta para ingreso por FF")
                        If Len(mAuxS1) > 0 Then
                           Set DataCombo1(0).RowSource = oAp.Cuentas.TraerFiltrado("_PorGruposParaCombo", mAuxS1)
                        End If
                     Else
                        mAuxS1 = BuscarClaveINI("Grupos de cuenta para ingreso por obra")
                        If Len(mAuxS1) > 0 And glbModeloContableSinApertura <> "SI" Then
                           Set DataCombo1(0).RowSource = oAp.Cuentas.TraerFiltrado("_PorGruposParaCombo", mAuxS1)
                        Else
                           Set oControl.RowSource = oAp.Cuentas.TraerLista
                        End If
                     End If
                  End If
               ElseIf oControl.Tag = "ObrasDestinos" Then
                  If Not IsNull(origen.Registro.Fields("IdObra").Value) Then
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_DestinosParaComboPorIdObra", origen.Registro.Fields("IdObra").Value)
                  End If
               ElseIf oControl.Tag = "SubcontratosDatos" Then
                  Set oControl.RowSource = oAp.Subcontratos.TraerFiltrado("_DatosParaCombo")
               ElseIf oControl.Tag = "PresupuestoObrasRubros" And Not mvarPresupuestadorObraNuevo Then
               ElseIf oControl.Tag = "PresupuestoObrasNodos" Then
               ElseIf oControl.Tag = "Subcontratos" Then
               ElseIf oControl.Tag = "Articulos1" Then
                  If mvarIdObra > 0 Then
                     Set oControl.RowSource = oAp.Articulos.TraerFiltrado("_BD_ProntoMantenimientoTodos", mvarIdObra)
                  Else
                     Set oControl.RowSource = oAp.Articulos.TraerFiltrado("_ParaMantenimiento_ParaCombo")
                  End If
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
   
'   mvarControlarRubrosContablesEnCP = ""
'   Set oRs = oAp.Parametros.TraerFiltrado("_Parametros2BuscarClave", "ControlarRubrosContablesEnCP")
'   If oRs.RecordCount > 0 Then
'      mvarControlarRubrosContablesEnCP = IIf(IsNull(oRs.Fields("Valor").Value), "NO", oRs.Fields("Valor").Value)
'   End If
'   oRs.Close
   mvarControlarRubrosContablesEnCP = TraerValorParametro2("ControlarRubrosContablesEnCP")
   
   Set oRsPar = oAp.Parametros.TraerFiltrado("_PorId", 1)
   mvarDecimales = oRsPar.Fields("Decimales").Value
   
   If mvarId = -1 Then
      With origen.Registro
         If Me.Obra = -1 Then
            DataCombo1(1).Enabled = False
         Else
            If IsNull(.Fields("IdObra").Value) Then
               DataCombo1(2).BoundText = Me.Obra
            Else
               DataCombo1(2).BoundText = .Fields("IdObra").Value
            End If
            DataCombo1(1).Enabled = True
         End If
         If oRsPar.RecordCount > 0 Then
            For i = 1 To 10
               If Not IsNull(oRsPar.Fields("IdCuentaIvaCompras" & i).Value) Then
                  Set oRs1 = oAp.Cuentas.Item(oRsPar.Fields("IdCuentaIvaCompras" & i).Value).Registro
                  With Check1(i - 1)
                     .Visible = True
                     If oRs1.RecordCount > 0 Then
                        .Caption = oRs1.Fields("Descripcion").Value
                     Else
                        .Caption = "N/A !! "
                     End If
                     .Caption = .Caption & " (" & oRsPar.Fields("IVAComprasPorcentaje" & i).Value & "%)"
                     .Value = 0
                     origen.Registro.Fields("IdCuentaIvaCompras" & i).Value = oRsPar.Fields("IdCuentaIvaCompras" & i).Value
                     origen.Registro.Fields("IVAComprasPorcentaje" & i).Value = oRsPar.Fields("IVAComprasPorcentaje" & i).Value
                  End With
                  oRs1.Close
               End If
            Next
         End If
         .Fields("IdProvinciaDestino1").Value = Me.IdProvinciaDestino
         .Fields("PorcentajeProvinciaDestino1").Value = 100
         If glbIdObraAsignadaUsuario <> -1 Then
            Set DataCombo1(0).RowSource = oAp.Cuentas.TraerFiltrado("_PorGrupoParaCombo", Array(mvarIdTipoCuentaGrupoIVA, Me.FechaComprobante))
            If mActivarCamposParaFF Then
               mAuxS1 = BuscarClaveINI("Grupos de cuenta para ingreso por FF")
               If Len(mAuxS1) > 0 Then
                  Set DataCombo1(0).RowSource = oAp.Cuentas.TraerFiltrado("_PorGruposParaCombo", mAuxS1)
               End If
            Else
               mAuxS1 = BuscarClaveINI("Grupos de cuenta para ingreso por obra")
               If Len(mAuxS1) > 0 Then
                  Set DataCombo1(0).RowSource = oAp.Cuentas.TraerFiltrado("_PorGruposParaCombo", mAuxS1)
               End If
            End If
         Else
            mAuxS1 = BuscarClaveINI("Grupos de cuenta para ingreso por obra")
            If Len(mAuxS1) > 0 Then
               Set DataCombo1(0).RowSource = oAp.Cuentas.TraerFiltrado("_PorGruposParaCombo", mAuxS1)
            End If
         End If
         
         If Me.IdPedidoAnticipo > 0 Then
            .Fields("IdPedidoAnticipo").Value = Me.IdPedidoAnticipo
            .Fields("IdPedido").Value = Me.IdPedidoAnticipo
            Set oRs1 = Aplicacion.Pedidos.TraerFiltrado("_PorId", Me.IdPedidoAnticipo)
            If oRs1.RecordCount > 0 Then
               txtNumeroPedido.Text = IIf(IsNull(oRs1.Fields("NumeroPedido").Value), "", oRs1.Fields("NumeroPedido").Value)
               txtSubNumeroPedido.Text = IIf(IsNull(oRs1.Fields("SubNumero").Value), "", oRs1.Fields("SubNumero").Value)
               .Fields("NumeroSubcontrato").Value = oRs1.Fields("NumeroSubcontrato").Value
               If IIf(IsNull(oRs1.Fields("TotalIva1").Value), 0, oRs1.Fields("TotalIva1").Value) <> 0 Then
                  If oRsPar.RecordCount > 0 Then
                     For i = 1 To 10
                        If Not IsNull(oRsPar.Fields("IdCuentaIvaCompras" & i).Value) Then
                           If oRsPar.Fields("IVAComprasPorcentaje" & i).Value = IIf(IsNull(oRs1.Fields("PorcentajeIva1").Value), 0, oRs1.Fields("PorcentajeIva1").Value) Then
                              Check1(i - 1).Value = 1
                              Exit For
                           End If
                        End If
                     Next
                  End If
               End If
               mTotalPedido = IIf(IsNull(oRs1.Fields("TotalPedido").Value), 0, oRs1.Fields("TotalPedido").Value) - _
                              IIf(IsNull(oRs1.Fields("TotalIva1").Value), 0, oRs1.Fields("TotalIva1").Value)
               If oComprobanteProveedor.Registro.Fields("IdMoneda").Value = mvarIdMonedaPesos Then
                  mTotalPedido = mTotalPedido * IIf(IsNull(oRs1.Fields("CotizacionMoneda").Value), 1, oRs1.Fields("CotizacionMoneda").Value)
               End If
            End If
            oRs1.Close
            If Me.IdCuentaContable <> 0 Then .Fields("IdCuenta").Value = Me.IdCuentaContable
            If Me.Anticipo_O_Devolucion = "A" Then
               .Fields("IdCuenta").Value = Val(TraerValorParametro2("IdCuentaAnticipoAProveedores"))
               .Fields("PorcentajeAnticipo").Value = Me.PorcentajeAnticipo
               .Fields("PorcentajeCertificacion").Value = Null
               .Fields("Importe").Value = Round(mTotalPedido * Me.PorcentajeAnticipo / 100, 2)
            ElseIf Me.Anticipo_O_Devolucion = "C1" Then
               .Fields("PorcentajeAnticipo").Value = Null
               .Fields("PorcentajeCertificacion").Value = Me.PorcentajeAnticipo
               .Fields("Importe").Value = Round(mTotalPedido * Me.PorcentajeAnticipo / 100, 2)
            Else
               Set oRs1 = Aplicacion.ComprobantesProveedores.TraerFiltrado("_AnticiposPorIdPedido", Me.IdPedidoAnticipo)
               If oRs1.RecordCount > 0 Then
                  mTotalAnticipos = IIf(IsNull(oRs1.Fields("Importe").Value), 0, oRs1.Fields("Importe").Value)
               End If
               oRs1.Close
               .Fields("IdCuenta").Value = Val(TraerValorParametro2("IdCuentaDevolucionAnticipoAProveedores"))
               .Fields("PorcentajeAnticipo").Value = Null
               .Fields("PorcentajeCertificacion").Value = Null
               .Fields("Importe").Value = Round(mTotalAnticipos * Me.PorcentajeAnticipo / 100 * -1, 2)
            End If
         End If
      End With
   Else
      Set oRs = origen.Registro
      For i = 1 To 10
         If Not IsNull(oRs.Fields("IVAComprasPorcentajeDirecto").Value) Then
            With Check1(i - 1)
               .Value = 0
               .Visible = False
            End With
         Else
            If Not IsNull(oRs.Fields("IdCuentaIvaCompras" & i).Value) And _
                  oRs.Fields("IVAComprasPorcentaje" & i).Value <> 0 Then
               Set oRs1 = oAp.Cuentas.Item(oRs.Fields("IdCuentaIvaCompras" & i).Value).Registro
               With Check1(i - 1)
                  .Visible = True
                  If oRs1.RecordCount > 0 Then
                     .Caption = oRs1.Fields("Descripcion").Value
                  Else
                     .Caption = "N/A !! "
                  End If
                  .Caption = .Caption & " (" & oRs.Fields("IVAComprasPorcentaje" & i).Value & "%)"
                  .Value = 0
                  If oRs.Fields("AplicarIVA" & i).Value = "SI" Then
                     .Value = 1
                  End If
               End With
               oRs1.Close
            Else
               If Not IsNull(oRsPar.Fields("IdCuentaIvaCompras" & i).Value) Then
                  Set oRs1 = oAp.Cuentas.Item(oRsPar.Fields("IdCuentaIvaCompras" & i).Value).Registro
                  With Check1(i - 1)
                     .Visible = True
                     If oRs1.RecordCount > 0 Then
                        .Caption = oRs1.Fields("Descripcion").Value
                     Else
                        .Caption = "N/A !! "
                     End If
                     .Caption = .Caption & " (" & oRsPar.Fields("IVAComprasPorcentaje" & i).Value & "%)"
                     .Value = 0
                  End With
                  oRs1.Close
               End If
            End If
         End If
      Next
      With origen.Registro
         If Not IsNull(.Fields("IdDetalleRecepcion").Value) Then
            Set oRs1 = oAp.Recepciones.TraerFiltrado("_DatosPorIdDetalleRecepcion", .Fields("IdDetalleRecepcion").Value)
            If oRs1.RecordCount > 0 Then
               txtNumeroRecepcion.Text = IIf(IsNull(oRs1.Fields("NumeroRecepcionAlmacen").Value), "", oRs1.Fields("NumeroRecepcionAlmacen").Value)
               txtNumeroRequerimiento.Text = IIf(IsNull(oRs1.Fields("NumeroRequerimiento").Value), "", oRs1.Fields("NumeroRequerimiento").Value)
               txtItemRequerimiento.Text = IIf(IsNull(oRs1.Fields("ItemRM").Value), "", oRs1.Fields("ItemRM").Value)
               txtNumeroPedido.Text = IIf(IsNull(oRs1.Fields("NumeroPedido").Value), "", oRs1.Fields("NumeroPedido").Value)
               txtSubNumeroPedido.Text = IIf(IsNull(oRs1.Fields("SubNumero").Value), "", oRs1.Fields("SubNumero").Value)
               txtItemPedido.Text = IIf(IsNull(oRs1.Fields("ItemPedido").Value), "", oRs1.Fields("ItemPedido").Value)
            End If
            oRs1.Close
         ElseIf Not IsNull(.Fields("IdDetallePedido").Value) Then
            Set oRs1 = oAp.Pedidos.TraerFiltrado("_DatosPorIdDetalle", .Fields("IdDetallePedido").Value)
            If oRs1.RecordCount > 0 Then
               txtNumeroPedido.Text = IIf(IsNull(oRs1.Fields("NumeroPedido").Value), "", oRs1.Fields("NumeroPedido").Value)
               txtSubNumeroPedido.Text = IIf(IsNull(oRs1.Fields("SubNumero").Value), "", oRs1.Fields("SubNumero").Value)
               txtItemPedido.Text = IIf(IsNull(oRs1.Fields("IP").Value), "", oRs1.Fields("IP").Value)
            End If
            oRs1.Close
         ElseIf Not IsNull(.Fields("IdPedido").Value) Then
            Set oRs1 = Aplicacion.Pedidos.TraerFiltrado("_PorId", .Fields("IdPedido").Value)
            If oRs1.RecordCount > 0 Then
               txtNumeroPedido.Text = IIf(IsNull(oRs1.Fields("NumeroPedido").Value), "", oRs1.Fields("NumeroPedido").Value)
               txtSubNumeroPedido.Text = IIf(IsNull(oRs1.Fields("SubNumero").Value), "", oRs1.Fields("SubNumero").Value)
            End If
            oRs1.Close
         End If
         If Not IsNull(.Fields("TomarEnCalculoDeImpuestos").Value) And .Fields("TomarEnCalculoDeImpuestos").Value = "NO" Then
            Check3.Value = 1
         End If
         If IsNull(.Fields("IdProvinciaDestino1").Value) Then
            .Fields("IdProvinciaDestino1").Value = Me.IdProvinciaDestino
            .Fields("PorcentajeProvinciaDestino1").Value = 100
         End If
         If IIf(IsNull(.Fields("AmpliacionSubcontrato").Value), "", .Fields("AmpliacionSubcontrato").Value) = "SI" Then
            Check4.Value = 1
         End If
         If Not IsNull(.Fields("NumeroSubcontrato").Value) Then
            cmd(2).BackColor = &HC0FFC0
         Else
            cmd(2).BackColor = &HC0C0FF
         End If
         If IIf(IsNull(.Fields("IdObra").Value), 0, .Fields("IdObra").Value) > 0 And Not IsNull(.Fields("IdEquipoDestino").Value) And Len(mvarBasePRONTOMantenimiento) > 0 Then
            Set oRs1 = oAp.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorId", .Fields("IdEquipoDestino").Value)
            If oRs1.RecordCount > 0 Then
               With text1
                  .Top = DataCombo1(15).Top
                  .Left = DataCombo1(15).Left
                  .Width = DataCombo1(15).Width
                  .Text = oRs1.Fields("Material").Value
                  .Enabled = False
                  .Visible = True
               End With
               With txtCodigoArticulo1
                  .Text = oRs1.Fields("NumeroInventario").Value
                  .Enabled = False
               End With
               DataCombo1(15).Visible = False
            End If
            oRs1.Close
         End If
      End With
   End If
   
   If Me.IdPedidoAnticipo > 0 Then
      txtPorcentajeAnticipo.Visible = True
      With origen.Registro
         txtPorcentajeAnticipo.Text = IIf(IsNull(.Fields("PorcentajeAnticipo").Value), .Fields("PorcentajeCertificacion").Value, .Fields("PorcentajeAnticipo").Value)
      End With
      lblLabels(28).Visible = True
   End If
   
   If Me.Letra = "C" Or Me.Letra = "E" Then
      For i = 1 To 10
         With Check1(i - 1)
            .Value = 0
            .Enabled = False
         End With
      Next
   End If
   
   If glbModeloContableSinApertura = "SI" Then
      lblLabels(4).Visible = False
      Check2.Visible = False
      DataCombo1(1).Visible = False
   End If
   
   CalcularTotales
   
   oRsPar.Close
   Set oRsPar = Nothing
   
   Set oRs = Nothing
   Set oRs1 = Nothing
   Set oAp = Nothing
   
   If Me.Letra <> "E" Then Me.Height = Me.Height * 0.78

End Property

Public Property Get ComprobanteProveedor() As ComPronto.ComprobanteProveedor

   Set ComprobanteProveedor = oComprobanteProveedor

End Property

Public Property Set ComprobanteProveedor(ByVal vnewvalue As ComPronto.ComprobanteProveedor)

   Set oComprobanteProveedor = vnewvalue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      Dim oRs As ADOR.Recordset
      Dim i As Integer, mIdAux As Long
      Dim mAuxS1 As String
      
      Select Case Index
         Case 0
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorIdConDatos", Array(DataCombo1(Index).BoundText, Me.FechaComprobante))
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  .Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
                  .Fields("CodigoCuenta").Value = oRs.Fields("Codigo1").Value
                  If Not IsNull(oRs.Fields("IdObra").Value) Then
                     .Fields("IdObra").Value = oRs.Fields("IdObra").Value
                  End If
                  If Not IsNull(oRs.Fields("IdRubroFinanciero").Value) Then
                     .Fields("IdRubroContable").Value = oRs.Fields("IdRubroFinanciero").Value
                  End If
'                  If Not IsNull(oRs.Fields("IdPresupuestoObraRubro").Value) Then
'                     .Fields("IdPresupuestoObraRubro").Value = oRs.Fields("IdPresupuestoObraRubro").Value
'                  End If
               End With
               If Not IsNull(oRs.Fields("EsCajaBanco").Value) And oRs.Fields("EsCajaBanco").Value = "BA" Then
                  DataCombo1(4).Enabled = True
               Else
                  origen.Registro.Fields("IdCuentaBancaria").Value = Null
                  DataCombo1(4).Enabled = False
               End If
               If oRs.Fields("IdTipoCuentaGrupo").Value = mvarIdTipoCuentaGrupoIVA Then
                  For i = 0 To 9
                     Check1(i).Value = 0
                     Check1(i).Visible = False
                  Next
                  lblLabels(1).Visible = True
                  txtPorcentajeIVADirecto.Visible = True
               Else
                  If Not Check1(1).Visible Then
                     lblLabels(1).Visible = False
                     origen.Registro.Fields("IVAComprasPorcentajeDirecto").Value = Null
                     txtPorcentajeIVADirecto.Visible = False
                     For i = 0 To 9
                        If Len(Check1(i).Caption) > 0 Then Check1(i).Visible = True
                     Next
                  End If
               End If
               If oRs.Fields("IdTipoCuentaGrupo").Value = mvarIdTipoCuentaGrupoIVA Or _
                  oRs.Fields("IdTipoCuentaGrupo").Value = mvarIdTipoCuentaGrupoPercepciones Then
                  Check3.Value = 1
               Else
                  If mvarId <= 0 Then Check3.Value = 0
               End If
            Else
               txtCodigoCuenta.Text = ""
            End If
            oRs.Close
         
         Case 1
            If DataCombo1(Index).Enabled Then
               mIdAux = IIf(IsNull(origen.Registro.Fields("IdObra").Value), Me.Obra, origen.Registro.Fields("IdObra").Value)
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorObraCuentaGasto", Array(mIdAux, DataCombo1(1).BoundText, Me.FechaComprobante))
               If oRs.RecordCount > 0 Then
                  If Len(DataCombo1(3).Text) > 0 Then
                     DataCombo1(3).BoundText = 0
                     If glbSeñal1 Then
                        Set DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorFechaParaCombo", Me.FechaComprobante)
                     Else
                        Set DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerLista
                     End If
                  Else
                     If glbIdCuentaFFUsuario <> -1 Then
                        Set DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerFiltrado("_ParaComprobantesProveedores", Me.FechaComprobante)
                     End If
                  End If
                  With origen.Registro
                     .Fields(DataCombo1(Index).DataField).Value = oRs.Fields("IdCuentaGasto").Value
                     .Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
                     .Fields("CodigoCuenta").Value = oRs.Fields("Codigo").Value
                  End With
               End If
               oRs.Close
            Else
               With origen.Registro
                  .Fields(DataCombo1(Index).DataField).Value = Null
               End With
            End If
            txtCodigoCuenta.Enabled = False
            DataCombo1(0).Enabled = False
            DataCombo1(3).Enabled = False
            Check2.Value = 1
         
         Case 2
            If Not DataCombo1(1).Enabled Then DataCombo1(1).Enabled = True
            If DataCombo1(Index).Text <> DataCombo1(Index).BoundText Then
               With origen.Registro
                  .Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
                  Set DataCombo1(1).RowSource = Aplicacion.Cuentas.TraerFiltrado("_CuentasGastoPorObraParaCombo", DataCombo1(Index).BoundText)
                  If Not IsNull(.Fields(DataCombo1(1).DataField).Value) Then
                     DataCombo1(1).BoundText = .Fields(DataCombo1(1).DataField).Value
                  End If
               End With
               If IsNumeric(DataCombo1(0).BoundText) Then
                  Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorId", DataCombo1(0).BoundText)
                  If oRs.RecordCount > 0 Then
                     If Not IsNull(oRs.Fields("IdObra").Value) Then
                        If oRs.Fields("IdObra").Value <> DataCombo1(Index).BoundText Then
                           DataCombo1(0).BoundText = 0
                           DataCombo1(0).Text = ""
                           txtCodigoCuenta.Text = ""
                           DataCombo1(1).BoundText = 0
                           DataCombo1(1).Text = ""
                        End If
                     End If
                  End If
                  oRs.Close
               End If
            End If
            If mvarPresupuestadorObraNuevo Then
               mAuxS1 = "*"
               If Not IsNull(origen.Registro.Fields("NumeroSubcontrato").Value) Then mAuxS1 = "S"
               Set oRs = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_EtapasImputablesPorObraParaCombo", Array(DataCombo1(Index).BoundText, mAuxS1))
               If oRs.RecordCount = 0 Then
                  origen.Registro.Fields(DataCombo1(12).DataField).Value = Null
                  DataCombo1(12).Enabled = False
                  oRs.Close
               ElseIf oRs.RecordCount = 1 Then
                  DataCombo1(12).Enabled = True
                  Set DataCombo1(12).RowSource = oRs
                  origen.Registro.Fields(DataCombo1(12).DataField).Value = oRs.Fields(0).Value
               Else
                  DataCombo1(12).Enabled = True
                  Set DataCombo1(12).RowSource = oRs
               End If
            Else
               mIdAux = IIf(IsNull(origen.Registro.Fields("IdDetalleObraDestino").Value), 0, origen.Registro.Fields("IdDetalleObraDestino").Value)
               Set oRs = Aplicacion.Obras.TraerFiltrado("_DestinosParaComboPorIdObra", DataCombo1(Index).BoundText)
               If oRs.RecordCount > 0 Then
                  DataCombo1(10).Enabled = True
                  DataCombo1(11).Enabled = True
                  Set DataCombo1(10).RowSource = oRs
               Else
                  DataCombo1(10).Enabled = False
                  DataCombo1(11).Enabled = False
               End If
               DataCombo1(10).BoundText = mIdAux
            End If
         
         Case 3
            If IsNumeric(DataCombo1(Index).BoundText) Then
               txtCodigoCuenta.Text = ""
               Dim mIdCuenta As Long
               If IsNumeric(DataCombo1(0).BoundText) Then
                  mIdCuenta = DataCombo1(0).BoundText
               Else
                  mIdCuenta = 0
               End If
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorGrupoParaCombo", Array(DataCombo1(Index).BoundText, Me.FechaComprobante))
               Set DataCombo1(0).RowSource = oRs
               origen.Registro.Fields(DataCombo1(0).DataField).Value = mIdCuenta
               Set oRs = Nothing
            End If
      
         Case 9
            If mArticuloVisible Then
               Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorIdConDatos", DataCombo1(Index).BoundText)
               If oRs.RecordCount > 0 Then
                  txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
                  mvarADistribuirEnPresupuestoDeObra = IIf(IsNull(oRs.Fields("ADistribuirEnPresupuestoDeObra").Value), "NO", oRs.Fields("ADistribuirEnPresupuestoDeObra").Value)
                  If Not IsNull(oRs.Fields("IdCuentaCompras").Value) And _
                        BuscarClaveINI("Desactivar cuenta de articulos para comprobantes proveedores") <> "SI" Then
                     origen.Registro.Fields("IdCuenta").Value = oRs.Fields("IdCuentaCompras").Value
                     DataCombo1(0).Enabled = False
                     DataCombo1(1).Enabled = False
                     DataCombo1(2).Enabled = False
                     DataCombo1(3).Enabled = False
                     txtCodigoCuenta.Enabled = False
                     Check2.Enabled = False
                  ElseIf mvarRegistroContableComprasAlActivo = "SI" And mvarADistribuirEnPresupuestoDeObra = "SI" And _
                        IIf(IsNull(oRs.Fields("IdCuentaComprasActivo").Value), 0, oRs.Fields("IdCuentaComprasActivo").Value) <> 0 Then
                     origen.Registro.Fields("IdCuenta").Value = oRs.Fields("IdCuentaComprasActivo").Value
                     DataCombo1(0).Enabled = False
                     DataCombo1(1).Enabled = False
                     DataCombo1(2).Enabled = False
                     DataCombo1(3).Enabled = False
                     txtCodigoCuenta.Enabled = False
                     Check2.Enabled = False
                  Else
                     DataCombo1(0).Enabled = True
                     DataCombo1(1).Enabled = True
                     DataCombo1(2).Enabled = True
                     DataCombo1(3).Enabled = True
                     txtCodigoCuenta.Enabled = True
                     Check2.Enabled = True
                  End If
                  If Not IsNull(oRs.Fields("IdPresupuestoObraRubro").Value) And Not mvarPresupuestadorObraNuevo Then
                     origen.Registro.Fields("IdPresupuestoObraRubro").Value = oRs.Fields("IdPresupuestoObraRubro").Value
                  End If
                  If mvarADistribuirEnPresupuestoDeObra = "SI" Then
                     If DataCombo1(10).Visible Then DataCombo1(10).Enabled = False
                     If DataCombo1(11).Visible Then DataCombo1(11).Enabled = False
                  Else
                     If DataCombo1(10).Visible Then DataCombo1(10).Enabled = True
                     If DataCombo1(11).Visible Then DataCombo1(11).Enabled = True
                  End If
               End If
               oRs.Close
            End If
      
         Case 10
            If IsNumeric(DataCombo1(Index).BoundText) Then
               Dim mIdPresupuestoObraRubro As Long, mTipoConsumo As Integer
               If Not IsNull(origen.Registro.Fields(DataCombo1(11).DataField).Value) Then
                  mIdPresupuestoObraRubro = origen.Registro.Fields(DataCombo1(11).DataField).Value
               Else
                  mIdPresupuestoObraRubro = 0
               End If
               Set oRs = Aplicacion.TablasGenerales.TraerUno("DetObrasDestinos", DataCombo1(Index).BoundText)
               mTipoConsumo = 3
               If oRs.RecordCount > 0 Then
                  mTipoConsumo = IIf(IsNull(oRs.Fields("TipoConsumo").Value), 3, oRs.Fields("TipoConsumo").Value)
                  mvarADistribuir = IIf(IsNull(oRs.Fields("ADistribuir").Value), "NO", oRs.Fields("ADistribuir").Value)
               End If
               oRs.Close
               Set oRs = Aplicacion.PresupuestoObrasRubros.TraerFiltrado("_ParaComboPorTipoConsumo", mTipoConsumo)
               Set DataCombo1(11).RowSource = oRs
               'origen.Registro.Fields(DataCombo1(11).DataField).Value = mIdPresupuestoObraRubro
               Set oRs = Nothing
            End If
      
'         Case 13
'            If IsNumeric(DataCombo1(Index).BoundText) Then
'               Dim mIdSubcontrato As Long
'               DataCombo1(14).BoundText = ""
'               mIdSubcontrato = 0
'               If Not IsNull(origen.Registro.Fields(DataCombo1(14).DataField).Value) Then
'                  mIdSubcontrato = origen.Registro.Fields(DataCombo1(14).DataField).Value
'               End If
'               Set oRs = Aplicacion.Subcontratos.TraerFiltrado("_EtapasParaCombo", DataCombo1(Index).BoundText)
'               Set DataCombo1(14).RowSource = oRs
'               'origen.Registro.Fields(DataCombo1(11).DataField).Value = mIdPresupuestoObraRubro
'               Set oRs = Nothing
'               If Not Check4.Visible Then Check4.Visible = True
'            End If
      
         Case 15
            If IsNumeric(DataCombo1(Index).BoundText) Then
               origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
               Set oRs = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorId", Array(DataCombo1(Index).BoundText, mvarIdObra))
               If oRs.RecordCount > 0 Then
                  txtCodigoArticulo1.Text = IIf(IsNull(oRs.Fields("NumeroInventario").Value), "", oRs.Fields("NumeroInventario").Value)
               End If
               oRs.Close
            End If
      End Select
      Set oRs = Nothing
   Else
'      If Index = 2 Then
'         origen.Registro.Fields(DataCombo1(Index).DataField).Value = Null
'      End If
   End If

End Sub

Private Sub DataCombo1_Click(Index As Integer, Area As Integer)

   If Index = 12 Then
      SetDataComboDropdownListWidth 600
   Else
      SetDataComboDropdownListWidth 400
   End If

End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)

'   SendKeys "%{DOWN}"

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DataCombo1_Validate(Index As Integer, Cancel As Boolean)

   If Index = 2 Then
      If Len(DataCombo1(Index).Text) = 0 Then
         origen.Registro.Fields(DataCombo1(Index).DataField).Value = Null
         If IsNumeric(DataCombo1(0).BoundText) Then
            Dim oRs As ADOR.Recordset
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorId", DataCombo1(0).BoundText)
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("IdObra").Value) Then
                  origen.Registro.Fields(DataCombo1(Index).DataField).Value = oRs.Fields("IdObra").Value
               End If
            End If
            oRs.Close
            Set oRs = Nothing
         End If
      End If
   End If

End Sub

Private Sub Form_Load()

   DisableCloseButton Me
   ReemplazarEtiquetas Me

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vnewvalue As Variant)

   mvarIdNuevo = vnewvalue

End Property

Private Sub Form_Unload(Cancel As Integer)

   Set oComprobanteProveedor = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub txtCantidad_GotFocus()

   With txtCantidad
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCodigoArticulo_GotFocus()

   With txtCodigoArticulo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoArticulo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCodigoArticulo_Validate(Cancel As Boolean)

   If Len(txtCodigoArticulo.Text) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdArticulo").Value = oRs.Fields(0).Value
      Else
         MsgBox "Codigo de material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo.Text = ""
      End If
      oRs.Close
      Set oRs = Nothing
   Else
      origen.Registro.Fields("IdArticulo").Value = Null
      DataCombo1(0).Enabled = True
      DataCombo1(1).Enabled = True
      DataCombo1(2).Enabled = True
      DataCombo1(3).Enabled = True
      txtCodigoCuenta.Enabled = True
   End If
   
End Sub

Private Sub txtCodigoArticulo1_GotFocus()

   With txtCodigoArticulo1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoArticulo1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoArticulo1_Validate(Cancel As Boolean)

   If Len(txtCodigoArticulo1.Text) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorNumeroInventario", _
                     Array(txtCodigoArticulo1.Text, mvarIdObra))
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdEquipoDestino").Value = oRs.Fields(0).Value
      Else
         MsgBox "Numero de inventario del material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo1.Text = ""
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

Private Sub txtCodigoCuenta_Change()

   If IsNumeric(txtCodigoCuenta.Text) Then
      On Error GoTo SalidaConError
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorCodigo", Array(txtCodigoCuenta.Text, Me.FechaComprobante))
      If oRs.RecordCount > 0 Then
         If oRs.Fields("IdTipoCuenta").Value = 2 Then
            origen.Registro.Fields("IdCuenta").Value = oRs.Fields(0).Value
         Else
            origen.Registro.Fields("IdCuenta").Value = Null
         End If
      Else
         origen.Registro.Fields("IdCuenta").Value = Null
      End If
      oRs.Close
      Set oRs = Nothing
      Exit Sub
SalidaConError:
      Set oRs = Nothing
      origen.Registro.Fields(DataCombo1(0).DataField).Value = Null
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

Private Sub txtImportacion_Despacho_GotFocus()

   With txtImportacion_Despacho
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImportacion_Despacho_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtImportacion_Despacho
         If Len(Trim(.Text)) >= oComprobanteProveedor.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtImportacion_FOB_GotFocus()

   With txtImportacion_FOB
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImportacion_FOB_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtImportacion_Guia_GotFocus()

   With txtImportacion_Guia
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImportacion_Guia_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtImportacion_Guia
         If Len(Trim(.Text)) >= oComprobanteProveedor.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtImportacion_PosicionAduana_GotFocus()

   With txtImportacion_PosicionAduana
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImportacion_PosicionAduana_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtImportacion_PosicionAduana
         If Len(Trim(.Text)) >= oComprobanteProveedor.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtImporte_GotFocus()

   With txtImporte
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImporte_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtItemPedido_GotFocus()

   With txtItemPedido
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtItemPedido_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtNumeroPedido_GotFocus()

   With txtNumeroPedido
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroPedido_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtNumeroPedido_Validate(Cancel As Boolean)

   If Len(Trim(txtNumeroPedido.Text)) <> 0 And txtNumeroPedido.Enabled Then
      If Not Len(Trim(txtSubNumeroPedido.Text)) = 0 And IsNumeric(txtSubNumeroPedido.Text) Then
         Dim oRs As ADOR.Recordset
         Dim mSubNumero As Integer
         mSubNumero = Val(txtSubNumeroPedido.Text)
         Set oRs = Aplicacion.Pedidos.TraerFiltrado("_PorNumero", Array(txtNumeroPedido.Text, mSubNumero))
         If oRs.RecordCount > 0 Then
            origen.Registro.Fields("IdPedido").Value = oRs.Fields("IdPedido").Value
         Else
            origen.Registro.Fields("IdPedido").Value = Null
         End If
         oRs.Close
         Set oRs = Nothing
      End If
   Else
      origen.Registro.Fields("IdPedido").Value = Null
   End If

End Sub

Private Sub txtPorcentajeProvinciaDestino1_Change()

   CalcularTotales

End Sub

Private Sub txtPorcentajeProvinciaDestino1_GotFocus()

   With txtPorcentajeProvinciaDestino1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcentajeProvinciaDestino1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPorcentajeProvinciaDestino2_Change()

   CalcularTotales

End Sub

Private Sub txtPorcentajeProvinciaDestino2_GotFocus()

   With txtPorcentajeProvinciaDestino2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcentajeProvinciaDestino2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtSubNumeroPedido_GotFocus()

   With txtSubNumeroPedido
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtSubNumeroPedido_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtSubNumeroPedido_Validate(Cancel As Boolean)

   If Len(Trim(txtSubNumeroPedido.Text)) > 0 And txtSubNumeroPedido.Enabled Then
      If Not Len(Trim(txtNumeroPedido.Text)) = 0 And IsNumeric(txtNumeroPedido.Text) Then
         Dim oRs As ADOR.Recordset
         Dim mSubNumero As Integer
         mSubNumero = Val(txtSubNumeroPedido.Text)
         Set oRs = Aplicacion.Pedidos.TraerFiltrado("_PorNumero", Array(txtNumeroPedido.Text, mSubNumero))
         If oRs.RecordCount > 0 Then
            origen.Registro.Fields("IdPedido").Value = oRs.Fields("IdPedido").Value
         Else
            origen.Registro.Fields("IdPedido").Value = Null
         End If
         oRs.Close
         Set oRs = Nothing
      End If
   End If

End Sub

Public Sub CalcularTotales()

   txtTotal.Text = Val(txtPorcentajeProvinciaDestino1.Text) + Val(txtPorcentajeProvinciaDestino2.Text)

End Sub

Public Property Get Obra() As Integer

   Obra = mvarIdObra

End Property

Public Property Let Obra(ByVal vnewvalue As Integer)

   mvarIdObra = vnewvalue
   
End Property

Public Property Get CadenaIVA() As String
   
   CadenaIVA = mIVAs
   
End Property

Public Property Get IdTipoCuentaGrupoIVA() As Long

   IdTipoCuentaGrupoIVA = mvarIdTipoCuentaGrupoIVA

End Property

Public Property Let IdTipoCuentaGrupoIVA(ByVal vnewvalue As Long)

   mvarIdTipoCuentaGrupoIVA = vnewvalue
   
End Property

Public Property Get Letra() As String

   Letra = mLetra

End Property

Public Property Let Letra(ByVal vnewvalue As String)

   mLetra = vnewvalue

End Property

Public Property Get IdProvinciaDestino() As Integer

   IdProvinciaDestino = mvarIdProvinciaDestino

End Property

Public Property Let IdProvinciaDestino(ByVal vnewvalue As Integer)

   mvarIdProvinciaDestino = vnewvalue
   
End Property

Public Property Get FechaComprobante() As Date

   FechaComprobante = mvarFechaComprobante

End Property

Public Property Let FechaComprobante(ByVal vnewvalue As Date)

   mvarFechaComprobante = vnewvalue
   
End Property

Public Property Get IdPedidoAnticipo() As Long

   IdPedidoAnticipo = mvarIdPedido

End Property

Public Property Let IdPedidoAnticipo(ByVal vnewvalue As Long)

   mvarIdPedido = vnewvalue

End Property

Public Property Get PorcentajeAnticipo() As Single

   PorcentajeAnticipo = mvarPorcentajeAnticipo
   
End Property

Public Property Let PorcentajeAnticipo(ByVal vnewvalue As Single)

   mvarPorcentajeAnticipo = vnewvalue

End Property

Public Property Get Anticipo_O_Devolucion() As String

   Anticipo_O_Devolucion = mvarAnticipo_O_Devolucion
   
End Property

Public Property Let Anticipo_O_Devolucion(ByVal vnewvalue As String)

   mvarAnticipo_O_Devolucion = vnewvalue

End Property

Public Property Get IdCuentaContable() As Long

   IdCuentaContable = mvarIdCuentaContable

End Property

Public Property Let IdCuentaContable(ByVal vnewvalue As Long)

   mvarIdCuentaContable = vnewvalue

End Property
