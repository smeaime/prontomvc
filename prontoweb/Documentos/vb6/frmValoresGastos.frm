VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.4#0"; "Controles1013.ocx"
Begin VB.Form frmValoresGastos 
   Caption         =   "Gastos bancarios"
   ClientHeight    =   8400
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8700
   Icon            =   "frmValoresGastos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8400
   ScaleWidth      =   8700
   StartUpPosition =   2  'CenterScreen
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
      Left            =   6480
      Locked          =   -1  'True
      TabIndex        =   49
      Top             =   7965
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
      Index           =   2
      Left            =   7515
      Locked          =   -1  'True
      TabIndex        =   48
      Top             =   7965
      Width           =   960
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Calcular asiento contable"
      Height          =   285
      Index           =   3
      Left            =   2025
      TabIndex        =   47
      Top             =   7965
      Width           =   2145
   End
   Begin VB.CheckBox Check3 
      Alignment       =   1  'Right Justify
      Caption         =   "Manual :"
      Height          =   150
      Left            =   7650
      TabIndex        =   46
      Top             =   6300
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
      Left            =   7560
      Locked          =   -1  'True
      TabIndex        =   44
      Top             =   5895
      Width           =   735
   End
   Begin VB.TextBox txtCertificadoRetencion 
      Alignment       =   2  'Center
      DataField       =   "CertificadoRetencion"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   7020
      TabIndex        =   40
      Top             =   3015
      Width           =   1455
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   0
      Left            =   180
      Picture         =   "frmValoresGastos.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   39
      Top             =   7875
      UseMaskColor    =   -1  'True
      Width           =   705
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   1
      Left            =   945
      Picture         =   "frmValoresGastos.frx":0DD4
      Style           =   1  'Graphical
      TabIndex        =   38
      Top             =   7875
      Width           =   705
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
      Left            =   3510
      Locked          =   -1  'True
      TabIndex        =   34
      Top             =   5895
      Width           =   1410
   End
   Begin VB.TextBox txtDetalle 
      DataField       =   "Detalle"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1800
      TabIndex        =   6
      Top             =   3780
      Width           =   6675
   End
   Begin VB.TextBox txtCotizacionMoneda 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   7650
      TabIndex        =   29
      Top             =   3420
      Width           =   825
   End
   Begin VB.TextBox txtPorcentajeIVA 
      Alignment       =   1  'Right Justify
      DataField       =   "PorcentajeIVA"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   4500
      TabIndex        =   25
      Top             =   3015
      Width           =   735
   End
   Begin VB.TextBox txtCodigoCuenta 
      Alignment       =   2  'Center
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
      Height          =   285
      Left            =   1800
      TabIndex        =   16
      Top             =   1830
      Width           =   1095
   End
   Begin VB.TextBox txtIVA 
      Alignment       =   1  'Right Justify
      DataField       =   "IVA"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1800
      TabIndex        =   4
      Top             =   2610
      Width           =   1455
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "Eliminar"
      Height          =   420
      Index           =   1
      Left            =   180
      TabIndex        =   8
      Top             =   6885
      Width           =   1485
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "Importe"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1800
      TabIndex        =   5
      Top             =   3375
      Width           =   1455
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   420
      Index           =   2
      Left            =   180
      TabIndex        =   9
      Top             =   7380
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   180
      TabIndex        =   7
      Top             =   6390
      Width           =   1485
   End
   Begin VB.TextBox txtNumeroComprobante 
      Alignment       =   2  'Center
      DataField       =   "NumeroComprobante"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
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
      Height          =   315
      Left            =   1800
      TabIndex        =   2
      Top             =   2205
      Width           =   1455
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaBancaria"
      Height          =   315
      Index           =   0
      Left            =   1800
      TabIndex        =   0
      Tag             =   "Bancos"
      Top             =   270
      Width           =   6675
      _ExtentX        =   11774
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaBancaria"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaGasto"
      Height          =   330
      Index           =   0
      Left            =   4500
      TabIndex        =   3
      Top             =   2205
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   58064897
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdTipoComprobante"
      Height          =   315
      Index           =   1
      Left            =   1800
      TabIndex        =   1
      Tag             =   "TiposComprobante"
      Top             =   675
      Width           =   6675
      _ExtentX        =   11774
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoComprobante"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaContable"
      Height          =   315
      Index           =   2
      Left            =   2925
      TabIndex        =   17
      Tag             =   "Cuentas"
      Top             =   1800
      Width           =   5565
      _ExtentX        =   9816
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaGasto"
      Height          =   315
      Index           =   3
      Left            =   1800
      TabIndex        =   18
      Tag             =   "CuentasGastos"
      Top             =   1425
      Width           =   6675
      _ExtentX        =   11774
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
      Left            =   1800
      TabIndex        =   19
      Tag             =   "Obras"
      Top             =   1035
      Width           =   6675
      _ExtentX        =   11774
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaIVA"
      Height          =   315
      Index           =   5
      Left            =   4500
      TabIndex        =   23
      Tag             =   "CuentasIVA"
      Top             =   2655
      Width           =   3990
      _ExtentX        =   7038
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   6
      Left            =   4500
      TabIndex        =   27
      Tag             =   "Monedas"
      Top             =   3420
      Width           =   1785
      _ExtentX        =   3149
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaComprobante"
      Height          =   330
      Index           =   1
      Left            =   7245
      TabIndex        =   31
      Top             =   2205
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   58064897
      CurrentDate     =   36377
   End
   Begin Controles1013.DbListView ListaRubrosContables 
      Height          =   1455
      Left            =   180
      TabIndex        =   35
      Top             =   4410
      Width           =   5055
      _ExtentX        =   8916
      _ExtentY        =   2566
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmValoresGastos.frx":135E
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   8100
      Top             =   4185
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
            Picture         =   "frmValoresGastos.frx":137A
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmValoresGastos.frx":148C
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmValoresGastos.frx":18DE
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmValoresGastos.frx":1D30
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView ListaProvincias 
      Height          =   1455
      Left            =   5310
      TabIndex        =   42
      Top             =   4410
      Width           =   3345
      _ExtentX        =   5900
      _ExtentY        =   2566
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmValoresGastos.frx":2182
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaCta 
      Height          =   1455
      Left            =   1980
      TabIndex        =   50
      Top             =   6480
      Width           =   6675
      _ExtentX        =   11774
      _ExtentY        =   2566
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmValoresGastos.frx":219E
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      Caption         =   "Totales contables :"
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
      Left            =   4410
      TabIndex        =   52
      Top             =   7965
      Width           =   2010
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
      Index           =   11
      Left            =   2070
      TabIndex        =   51
      Top             =   6300
      Width           =   1635
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      Caption         =   "Total control:"
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
      Index           =   10
      Left            =   6165
      TabIndex        =   45
      Top             =   5940
      Width           =   1380
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Distrib.p/SIRCREB :"
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
      Index           =   8
      Left            =   5355
      TabIndex        =   43
      Top             =   4230
      Width           =   1740
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro. certif. retencion :"
      Height          =   255
      Index           =   7
      Left            =   5355
      TabIndex        =   41
      Top             =   3060
      Width           =   1590
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
      Left            =   225
      TabIndex        =   37
      Top             =   4230
      Width           =   2865
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
      Left            =   1305
      TabIndex        =   36
      Top             =   5940
      Width           =   2175
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle :"
      Height          =   255
      Index           =   6
      Left            =   180
      TabIndex        =   33
      Top             =   3825
      Width           =   1500
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha contable :"
      Height          =   300
      Index           =   4
      Left            =   5895
      TabIndex        =   32
      Top             =   2205
      Width           =   1275
   End
   Begin VB.Label lblLabels 
      Caption         =   "Conversion a $ :"
      Height          =   255
      Index           =   2
      Left            =   6345
      TabIndex        =   30
      Top             =   3465
      Width           =   1230
   End
   Begin VB.Label lblData 
      Caption         =   "Moneda :"
      Height          =   300
      Index           =   6
      Left            =   3420
      TabIndex        =   28
      Top             =   3420
      Width           =   1005
   End
   Begin VB.Label lblLabels 
      Caption         =   "Porc. IVA :"
      Height          =   255
      Index           =   1
      Left            =   3420
      TabIndex        =   26
      Top             =   3060
      Width           =   1005
   End
   Begin VB.Label lblData 
      Caption         =   "Cuenta IVA :"
      Height          =   300
      Index           =   5
      Left            =   3420
      TabIndex        =   24
      Top             =   2655
      Width           =   1005
   End
   Begin VB.Label lblData 
      Caption         =   "Todas las cuentas :"
      Height          =   300
      Index           =   2
      Left            =   180
      TabIndex        =   22
      Top             =   1815
      Width           =   1500
   End
   Begin VB.Label lblData 
      Caption         =   "Cuenta de gasto :"
      Height          =   300
      Index           =   3
      Left            =   180
      TabIndex        =   21
      Top             =   1425
      Width           =   1500
   End
   Begin VB.Label lblData 
      Caption         =   "Obra : "
      Height          =   255
      Index           =   4
      Left            =   180
      TabIndex        =   20
      Top             =   1065
      Width           =   1500
   End
   Begin VB.Label lblLabels 
      Caption         =   "IVA :"
      Height          =   300
      Index           =   3
      Left            =   180
      TabIndex        =   15
      Top             =   2610
      Width           =   1500
   End
   Begin VB.Label lblData 
      Caption         =   "Tipo movimiento :"
      Height          =   300
      Index           =   1
      Left            =   180
      TabIndex        =   14
      Top             =   675
      Width           =   1500
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe total :"
      Height          =   300
      Index           =   0
      Left            =   180
      TabIndex        =   13
      Top             =   3375
      Width           =   1500
   End
   Begin VB.Label lblData 
      Caption         =   "Banco / Cuenta :"
      Height          =   300
      Index           =   0
      Left            =   180
      TabIndex        =   12
      Top             =   270
      Width           =   1500
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha :"
      Height          =   300
      Index           =   5
      Left            =   3420
      TabIndex        =   11
      Top             =   2205
      Width           =   1005
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro. comprobante :"
      Height          =   300
      Index           =   9
      Left            =   180
      TabIndex        =   10
      Top             =   2205
      Width           =   1500
   End
   Begin VB.Menu MnuDetRubroContable 
      Caption         =   "Detalle"
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
   Begin VB.Menu MnuDetProvincia 
      Caption         =   "DetalleProvincias"
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
   Begin VB.Menu MnuDetCta 
      Caption         =   "DetalleCuentas"
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
Attribute VB_Name = "frmValoresGastos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Valor
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long, mIdCuentaBancaria As Long, mvarIdMonedaPesos As Long, mvarIdMonedaDolar As Long
Private mvarNumeroProximoGasto As Long
Private mObjetoOrigen As String, mvarControlarRubrosContablesEnOP As String
Private mvarCotizacion As Double, mvarTotalRubrosContables As Double
Private mvarGrabado As Boolean, mvarNumeracionAutomatica As Boolean, mvarAccesoContable As Boolean
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

Public Sub EditarRubroContable(ByVal Cual As Long)

   Dim oF As frmDetValoresRubrosContables
   Dim oL As ListItem
   
   Set oF = New frmDetValoresRubrosContables
   With oF
      Set .Valor = origen
      If IsNumeric(DataCombo1(4).BoundText) Then .IdObra = DataCombo1(4).BoundText
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

Public Sub EditarProvincia(ByVal Cual As Long)

   Dim oF As frmDetValoresProvincias
   Dim oL As ListItem
   
   Set oF = New frmDetValoresProvincias
   With oF
      Set .Valor = origen
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaProvincias.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaProvincias.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.DataCombo1(1).Text
            .SubItems(1) = "" & Format(oF.txtPorcentaje.Text, "Fixed")
         End With
      End If
   End With
   Unload oF
   Set oF = Nothing
   
   CalculaTotales
   
End Sub

Sub EditarCta(ByVal Cual As Long)

   If Not IsNumeric(DataCombo1(6).BoundText) Then
      MsgBox "Debe primero definir la moneda", vbCritical
      Exit Sub
   End If
   
   Dim oF As frmDetValoresCuentas
   Dim oL As ListItem
   
   Set oF = New frmDetValoresCuentas
   With oF
      Set .Valor = origen
      .IdMoneda = DataCombo1(6).BoundText
      .FechaComprobante = DTFields(0).Value
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

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         If DTFields(1).Value <= gblFechaUltimoCierre And _
               Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(1).Value) Then
            MsgBox "La fecha no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation
            Exit Sub
         End If

         Dim oPar As ComPronto.Parametro
         Dim oRs As ADOR.Recordset
         Dim est As EnumAcciones
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim mNum As Long
         Dim mvarSeguro As Integer
         Dim mJerarquia As String
         Dim mvarOK As Boolean
         
         If Val(txtIVA.Text) <> 0 And Not IsNumeric(DataCombo1(5).BoundText) Then
            MsgBox "Debe ingresar la cuenta contable de iva", vbExclamation
            Exit Sub
         End If
         
         If Val(txtIVA.Text) <> 0 And Val(txtPorcentajeIVA.Text) = 0 Then
            MsgBox "Debe ingresar el porcentaje de iva", vbExclamation
            Exit Sub
         End If
         
         If Val(txtIVA.Text) > 10000 Then
            mvarSeguro = MsgBox("El importe de iva es un valor muy grande, esta correcto?", vbYesNo, "Gastos bancarios")
            If mvarSeguro = vbNo Then Exit Sub
         End If
         
         If Len(txtNumeroComprobante.Text) = 0 Then
            MsgBox "Debe ingresar un numero de comprobante", vbExclamation
            Exit Sub
         End If
         
         If Val(txtTotal(0).Text) <> 0 And Val(txtTotal(0).Text) <> 100 Then
            MsgBox "Los porcentajes por provincia deben sumar 0 o 100", vbExclamation
            Exit Sub
         End If
         
         For Each dc In DataCombo1
            If dc.Enabled Then
               If Not IsNumeric(dc.BoundText) And _
                  Not (dc.Index = 3 Or dc.Index = 4) And _
                  Not (dc.Index = 5 And Val(txtIVA.Text) = 0) Then
                  MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
                  Exit Sub
               End If
               If IsNumeric(dc.BoundText) Then
                  origen.Registro.Fields(dc.DataField).Value = dc.BoundText
               End If
            End If
         Next
         
         If mvarControlarRubrosContablesEnOP = "SI" Then
            If Val(txtImporte.Text) <> mvarTotalRubrosContables Then
               MsgBox "El total de rubros contables asignados debe ser igual al total del gasto", vbExclamation
               Exit Sub
            End If
         End If
         
         ActualizaListaContable
         
         If Val(txtTotal(1).Text) <> Val(txtTotal(2).Text) Then
            MsgBox "No balancea el registro contable", vbInformation
            Exit Sub
         End If
         
         With origen.Registro
            If glbModeloContableSinApertura = "SI" And IIf(IsNull(.Fields("IdObra").Value), 0, .Fields("IdObra").Value) = 0 Then
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorId", .Fields("IdCuenta").Value)
               If oRs.RecordCount > 0 Then
                  mJerarquia = IIf(IsNull(oRs.Fields("Jerarquia").Value), "", oRs.Fields("Jerarquia").Value)
               End If
               oRs.Close
               Set oRs = Nothing
               If mId(mJerarquia, 1, 1) = "5" Then
                  MsgBox "Debe ingresar la obra / centro de costos", vbExclamation
                  Exit Sub
               End If
            End If
            If mvarId <= 0 Then
               If mvarNumeracionAutomatica Then
                  mvarOK = True
                  If mvarNumeroProximoGasto <> .Fields("NumeroComprobante").Value Then
                     mvarSeguro = MsgBox("Ha cambiado el numero interno de gasto, desea mantener el cambio?", vbYesNo)
                     If mvarSeguro = vbYes Then mvarOK = False
                  End If
                  If mvarOK Then
                     Set oRs = Aplicacion.TiposComprobante.TraerFiltrado("_PorId", .Fields("IdTipoComprobante").Value)
                     mNum = IIf(IsNull(oRs.Fields("NumeradorAuxiliar").Value), 1, oRs.Fields("NumeradorAuxiliar").Value)
                     origen.Registro.Fields("NumeroComprobante").Value = mNum
                     Aplicacion.Tarea "TiposComprobante_ModificarNumerador", Array(.Fields("IdTipoComprobante").Value, mNum + 1)
                  End If
               End If
            End If
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
            .Fields("Estado").Value = "G"
            .Fields("Conciliado").Value = "NO"
            .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text
            Set oRs = Aplicacion.CuentasBancarias.TraerFiltrado("_PorId", DataCombo1(0).BoundText)
            If oRs.RecordCount > 0 Then
               .Fields("IdBanco").Value = oRs.Fields("IdBanco").Value
            End If
            oRs.Close
            Set oRs = Nothing
            If mvarId < 0 Then
               .Fields("IdUsuarioIngreso").Value = glbIdUsuario
               .Fields("FechaIngreso").Value = Now
            Else
               .Fields("IdUsuarioModifico").Value = glbIdUsuario
               .Fields("FechaModifico").Value = Now
            End If
            If Check3.Value = 1 Then
               .Fields("AsientoManual").Value = "SI"
            Else
               .Fields("AsientoManual").Value = "NO"
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
            mvarGrabado = True
         Else
            est = Modificacion
         End If
            
         If Not actL2 Is Nothing Then
            With actL2
               .ListaEditada = "+SubVl1"
               .AccionRegistro = est
               .Disparador = mvarId
            End With
         End If
         
      Case 1
         Dim mBorra As Integer
         mBorra = MsgBox("Esta seguro de eliminar los datos definitivamente ?", vbYesNo, "Eliminar")
         If mBorra = vbNo Then Exit Sub
         
         With origen
            .Registro.Fields("Estado").Value = "X"
            .Guardar
         End With

         est = baja

         With actL2
            .ListaEditada = Me.ObjetoOrigen
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
      Case 3
         ActualizaListaContable
         Exit Sub
   End Select
   
   Unload Me

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   Dim oRs As ADOR.Recordset
   Dim mIdTipoCuentaGrupoIVA As Long
   Dim oDetRubCon As ComPronto.DetValorRubrosContables
   Dim oDetProv As ComPronto.DetValorProvincias
   Dim oDetCta As ComPronto.DetValorCuentas
   Dim ListaVacia1 As Boolean, ListaVacia2 As Boolean, ListaVacia3 As Boolean
   
   mvarId = vnewvalue
   ListaVacia1 = False
   ListaVacia2 = False
   ListaVacia3 = False
   
   Set oAp = Aplicacion
   Set origen = oAp.Valores.Item(vnewvalue)
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      mIdTipoCuentaGrupoIVA = IIf(IsNull(.Fields("IdTipoCuentaGrupoIVA").Value), 0, .Fields("IdTipoCuentaGrupoIVA").Value)
      mvarIdMonedaPesos = .Fields("IdMoneda").Value
      mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
      mvarControlarRubrosContablesEnOP = IIf(IsNull(.Fields("ControlarRubrosContablesEnOP").Value), "SI", _
                                          .Fields("ControlarRubrosContablesEnOP").Value)
      gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)
   End With
   oRs.Close
   
   mvarNumeroProximoGasto = 0
   
   mvarNumeracionAutomatica = False
   If BuscarClaveINI("Numerar automaticamente gastos bancarios") = "SI" Then mvarNumeracionAutomatica = True
   
   mvarAccesoContable = False
   If BuscarClaveINI("Permitir acceso contable en gastos bancarios") = "SI" Then
      mvarAccesoContable = True
   Else
      Check3.Enabled = False
   End If
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "ListaRubrosContables"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetValoresRubrosContables.TraerMascara
                     ListaVacia1 = True
                  Else
                     Set oRs = origen.DetValoresRubrosContables.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                     Else
                        Set oControl.DataSource = origen.DetValoresRubrosContables.TraerMascara
                        ListaVacia1 = True
                     End If
                     If oRs.Fields.Count <> 0 Then
                        While Not oRs.EOF
                           Set oDetRubCon = origen.DetValoresRubrosContables.Item(oRs.Fields(0).Value)
                           oDetRubCon.Modificado = True
                           Set oDetRubCon = Nothing
                           oRs.MoveNext
                        Wend
                     End If
                     oRs.Close
                  End If
               Case "ListaProvincias"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetValoresProvincias.TraerMascara
                     ListaVacia2 = True
                  Else
                     Set oRs = origen.DetValoresProvincias.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                     Else
                        Set oControl.DataSource = origen.DetValoresProvincias.TraerMascara
                        ListaVacia2 = True
                     End If
                     If oRs.Fields.Count <> 0 Then
                        While Not oRs.EOF
                           Set oDetProv = origen.DetValoresProvincias.Item(oRs.Fields(0).Value)
                           oDetProv.Modificado = True
                           Set oDetProv = Nothing
                           oRs.MoveNext
                        Wend
                     End If
                     oRs.Close
                  End If
               Case "ListaCta"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetValoresCuentas.TraerMascara
                     ListaVacia3 = True
                  Else
                     Set oRs = origen.DetValoresCuentas.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                     Else
                        Set oControl.DataSource = origen.DetValoresCuentas.TraerMascara
                        ListaVacia3 = True
                     End If
                     While Not oRs.EOF
                        Set oDetCta = origen.DetValoresCuentas.Item(oRs.Fields(0).Value)
                        oDetCta.Modificado = True
                        Set oDetCta = Nothing
                        oRs.MoveNext
                     Wend
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
               If oControl.Tag = "Bancos" Then
                  Set oControl.RowSource = oAp.Bancos.TraerFiltrado("_PorCuentasBancarias", glbIdUsuario)
               ElseIf oControl.Tag = "TiposComprobante" Then
                  Set oControl.RowSource = oAp.TiposComprobante.TraerFiltrado("_ParaComboGastosBancarios")
               ElseIf oControl.Tag = "CuentasIVA" Then
                  Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_PorGrupoParaCombo", mIdTipoCuentaGrupoIVA)
               ElseIf oControl.Tag = "Obras" Then
                  If glbSeñal1 Then
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", Date))
                  Else
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo")
                  End If
               ElseIf oControl.Tag = "Cuentas" Then
                  If glbSeñal1 Then
                     If mvarId > 0 Then
                        Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_PorFechaParaCombo", origen.Registro.Fields("FechaComprobante").Value)
                     Else
                        Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_PorFechaParaCombo", Date)
                     End If
                  Else
                     Set oControl.RowSource = oAp.Cuentas.TraerLista
                  End If
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
   
   If ListaVacia1 Then
      ListaRubrosContables.ListItems.Clear
      ListaRubrosContables.Refresh
   End If
   If ListaVacia2 Then
      ListaProvincias.ListItems.Clear
      ListaProvincias.Refresh
   End If
   If ListaVacia3 Then
      ListaCta.ListItems.Clear
      ListaCta.Refresh
   End If

   If mvarId <= 0 Then
      DTFields(0).Value = Date
      DTFields(1).Value = Date
      With origen.Registro
         .Fields("FechaComprobante").Value = Date
         .Fields("Importe").Value = 0
         .Fields("IVA").Value = 0
         .Fields("IdCuentaBancaria").Value = Me.IdCuentaBancaria
         .Fields("IdMoneda").Value = mvarIdMonedaPesos
         .Fields("FechaGasto").Value = Date
         .Fields("FechaComprobante").Value = Date
      End With
      mvarGrabado = False
   Else
      With origen.Registro
         txtCotizacionMoneda.Text = IIf(IsNull(.Fields("CotizacionMoneda").Value), 0, .Fields("CotizacionMoneda").Value)
         If Not IsNull(.Fields("AsientoManual").Value) And .Fields("AsientoManual").Value = "SI" Then
            Check3.Value = 1
          Else
            Check3.Value = 0
         End If
      End With
      DataCombo1(1).Enabled = False
      mvarGrabado = True
   End If
   
   CalculaTotales
   
   cmd(1).Enabled = False
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      If mvarId > 0 Then cmd(1).Enabled = True
   End If
   
   If DTFields(1).Value <= gblFechaUltimoCierre And Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(1).Value) Then
      cmd(0).Enabled = False
      cmd(1).Enabled = False
   End If

   If glbModeloContableSinApertura = "SI" Then
      lblData(3).Visible = False
      DataCombo1(3).Visible = False
      lblData(2).Top = lblData(3).Top
      DataCombo1(2).Top = DataCombo1(3).Top
      With txtCodigoCuenta
         .Top = DataCombo1(3).Top
         .Height = DataCombo1(2).Height
      End With
   End If
   
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub cmdImpre_Click(Index As Integer)

   DoEvents

   If Not mvarGrabado Then
      MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
      Exit Sub
   End If

   Dim mvarOK As Boolean
   Dim mCopias As Integer
   Dim mPrinter As String, mPrinterAnt As String

   mCopias = Val(BuscarClaveINI("CopiasConciliacion"))
   If mCopias = 0 Then mCopias = 2
   
   mPrinterAnt = Printer.DeviceName & " on " & Printer.Port

   If Index = 0 Then
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
      If Not mvarOK Then Exit Sub
   Else
      mCopias = 1
   End If

   Me.MousePointer = vbHourglass

   On Error GoTo Mal

   Dim oW As Word.Application
   
   Set oW = CreateObject("Word.Application")
   
   oW.Visible = True
   oW.Documents.Add (glbPathPlantillas & "\GastosBancarios.dot")
   oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId
   oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
   oW.Application.Run MacroName:="DatosDelPie"
   If Index = 0 Then
      If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
      oW.Documents(1).PrintOut False, , , , , , , mCopias
      If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
      oW.Documents(1).Close False
   End If
   If Index = 0 Then oW.Quit

Salida:
   Me.MousePointer = vbDefault
   Set oW = Nothing
   Exit Sub

Mal:
   If Index = 0 Then oW.Quit
   Me.MousePointer = vbDefault
   MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical
   Resume Salida

End Sub

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
      
      Dim oRs As ADOR.Recordset
      Dim mIdAux As Long
      
      Select Case Index
         Case 1
            If mvarNumeracionAutomatica And mvarId <= 0 Then
               Set oRs = Aplicacion.TiposComprobante.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
               origen.Registro.Fields("NumeroComprobante").Value = IIf(IsNull(oRs.Fields("NumeradorAuxiliar").Value), 1, oRs.Fields("NumeradorAuxiliar").Value)
               mvarNumeroProximoGasto = origen.Registro.Fields("NumeroComprobante").Value
               oRs.Close
            End If
         Case 2
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorIdConDatos", Array(DataCombo1(Index).BoundText, origen.Registro.Fields("FechaComprobante").Value))
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  txtCodigoCuenta.Text = oRs.Fields("Codigo1").Value
                  If Not IsNull(oRs.Fields("IdObra").Value) Then
                     .Fields("IdObra").Value = oRs.Fields("IdObra").Value
                  Else
'                     .Fields("IdObra").Value = Null
                  End If
               End With
            End If
            oRs.Close
         Case 3
            If DataCombo1(Index).Enabled And _
                  Len(DataCombo1(3).BoundText) <> 0 And _
                  Len(DataCombo1(4).BoundText) <> 0 Then
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorObraCuentaGasto", _
                           Array(DataCombo1(4).BoundText, DataCombo1(3).BoundText, DTFields(1).Value))
               If oRs.RecordCount > 0 Then
                  With origen.Registro
                     .Fields(DataCombo1(Index).DataField).Value = oRs.Fields("IdCuentaGasto").Value
                     .Fields("IdCuentaContable").Value = oRs.Fields("IdCuenta").Value
                     txtCodigoCuenta.Text = oRs.Fields("Codigo").Value
                  End With
               End If
               oRs.Close
            Else
               With origen.Registro
                  .Fields(DataCombo1(Index).DataField).Value = Null
               End With
            End If
         Case 4
            If Not DataCombo1(3).Enabled Then
               DataCombo1(3).Enabled = True
            End If
            If DataCombo1(Index).Text <> DataCombo1(Index).BoundText Then
               With origen.Registro
                  mIdAux = 0
                  If IsNumeric(DataCombo1(3).BoundText) Then mIdAux = DataCombo1(3).BoundText
                  Set oRs = Aplicacion.Cuentas.TraerFiltrado("_CuentasGastoPorObraParaCombo", _
                              DataCombo1(Index).BoundText)
                  Set DataCombo1(3).RowSource = oRs
                  Set oRs = Nothing
                  DataCombo1(3).BoundText = mIdAux
               End With
               If IsNumeric(DataCombo1(2).BoundText) Then
                  Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorId", DataCombo1(2).BoundText)
                  If oRs.RecordCount > 0 Then
                     If Not IsNull(oRs.Fields("IdObra").Value) Then
                        If oRs.Fields("IdObra").Value <> DataCombo1(Index).BoundText Then
                           DataCombo1(2).BoundText = 0
                           DataCombo1(2).Text = ""
                           txtCodigoCuenta.Text = ""
                           DataCombo1(3).BoundText = 0
                           DataCombo1(3).Text = ""
                        End If
                     End If
                  End If
                  oRs.Close
               End If
            End If
         Case 6
            If DataCombo1(Index).BoundText = mvarIdMonedaPesos Then
               txtCotizacionMoneda.Text = 1
            Else
               Set oRs = Aplicacion.Cotizaciones.TraerFiltrado("_PorFechaMoneda", Array(DTFields(0).Value, DataCombo1(Index).BoundText))
               If oRs.RecordCount > 0 Then
                  txtCotizacionMoneda.Text = oRs.Fields("CotizacionLibre").Value
               Else
                  MsgBox "No hay cotizacion, ingresela manualmente"
                  txtCotizacionMoneda.Text = ""
               End If
               oRs.Close
               Set oRs = Nothing
            End If
      End Select
      Set oRs = Nothing
   End If

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub DTFields_Validate(Index As Integer, Cancel As Boolean)

   If Len(DTFields(Index).DataField) > 0 Then
      origen.Registro.Fields(DTFields(Index).DataField).Value = DTFields(Index).Value
   End If
   If glbSeñal1 And Index = 1 Then
      Dim mIdAux As Long
      mIdAux = 0
      If IsNumeric(DataCombo1(4).BoundText) Then mIdAux = DataCombo1(4).BoundText
      Set DataCombo1(4).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", DTFields(0).Value))
      DataCombo1(4).BoundText = mIdAux
   
      mIdAux = 0
      If IsNumeric(DataCombo1(2).BoundText) Then mIdAux = DataCombo1(2).BoundText
      Set DataCombo1(2).RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorFechaParaCombo", DTFields(1).Value)
      DataCombo1(2).BoundText = mIdAux
   End If

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With ListaRubrosContables
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaProvincias
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaCta
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

Private Sub ListaCta_DblClick()

   If Not ListaCta.SelectedItem Is Nothing And mvarAccesoContable Then
      If IsNumeric(ListaCta.SelectedItem.Tag) Then
         If ListaCta.ListItems.Count = 0 Then
            EditarCta -1
         Else
            EditarCta ListaCta.SelectedItem.Tag
         End If
      End If
   End If

End Sub

Private Sub ListaCta_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaCta_KeyUp(KeyCode As Integer, Shift As Integer)

   If mvarAccesoContable Then
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

   If Button = vbRightButton And mvarAccesoContable Then
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

Private Sub ListaProvincias_DblClick()

   If Not ListaProvincias.SelectedItem Is Nothing Then
      If IsNumeric(ListaProvincias.SelectedItem.Tag) Then
         If ListaProvincias.ListItems.Count = 0 Then
            EditarProvincia -1
         Else
            EditarProvincia ListaProvincias.SelectedItem.Tag
         End If
      End If
   End If

End Sub

Private Sub ListaProvincias_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaProvincias_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetA_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetA_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetA_Click 1
   End If

End Sub

Private Sub ListaProvincias_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)

   If Button = vbRightButton Then
      If ListaProvincias.ListItems.Count = 0 Then
         MnuDetA(1).Enabled = False
         MnuDetA(2).Enabled = False
         PopupMenu MnuDetProvincia, , , , MnuDetA(0)
      Else
         MnuDetA(1).Enabled = True
         MnuDetA(2).Enabled = True
         PopupMenu MnuDetProvincia, , , , MnuDetA(1)
      End If
   End If

End Sub

Private Sub ListaProvincias_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single)

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
      
      If InStr(1, Columnas(LBound(Columnas) + 1), "Tipo Comp.") <> 0 Then
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetValoresProvincias", "_PorIdValor", Columnas(2))
            If oRs.RecordCount > 0 Then
               oRs.MoveFirst
               Do While Not oRs.EOF
                  With origen.DetValoresProvincias.Item(-1)
                     .Registro.Fields("IdProvincia").Value = oRs.Fields("IdProvincia").Value
                     .Registro.Fields("Porcentaje").Value = oRs.Fields("Porcentaje").Value
                     .Modificado = True
                     idDet = .Id
                  End With
                  Set oL = ListaProvincias.ListItems.Add
                  oL.Tag = idDet
                  With oL
                     .SmallIcon = "Nuevo"
                     .Text = "" & oRs.Fields("Provincia").Value
                     .SubItems(1) = "" & oRs.Fields("Porcentaje").Value
                  End With
                  oRs.MoveNext
               Loop
            End If
            oRs.Close
            Set oRs = Nothing
         Next
         CalculaTotales

         Clipboard.Clear

      Else
         
         MsgBox "Objeto invalido!"
         Exit Sub
      
      End If

   End If
   
End Sub

Private Sub ListaProvincias_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single, State As Integer)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long
   Dim iColumnas As Long
   Dim oL As ListItem

   If State = vbEnter Then
      If Data.GetFormat(ccCFText) Then
         s = Data.GetData(ccCFText)
         Filas = Split(s, vbCrLf)
         Columnas = Split(Filas(LBound(Filas)), vbTab)
         Effect = vbDropEffectCopy
      End If
   End If

End Sub

Private Sub ListaProvincias_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

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
'               If Not (IsNull(oRs.Fields("IngresoEgreso").Value) Or oRs.Fields("IngresoEgreso").Value = "E") Then
'                  oRs.Close
'                  Set oRs = Nothing
'                  MsgBox "Solo puede incluir rubros de egresos", vbExclamation
'                  Exit Sub
'               End If
               With origen.DetValoresRubrosContables.Item(-1)
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
      If Data.GetFormat(ccCFText) Then
         s = Data.GetData(ccCFText)
         Filas = Split(s, vbCrLf)
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

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarProvincia -1
      Case 1
         EditarProvincia ListaProvincias.SelectedItem.Tag
      Case 2
         With ListaProvincias.SelectedItem
            origen.DetValoresProvincias.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub MnuDetC_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarCta -1
      Case 1
         EditarCta ListaCta.SelectedItem.Tag
      Case 2
         With ListaCta.SelectedItem
            origen.DetValoresCuentas.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub MnuDetE_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarRubroContable -1
      Case 1
         EditarRubroContable ListaRubrosContables.SelectedItem.Tag
      Case 2
         With ListaRubrosContables.SelectedItem
            origen.DetValoresRubrosContables.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub txtCertificadoRetencion_GotFocus()

   With txtCertificadoRetencion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCertificadoRetencion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCertificadoRetencion
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtCodigoCuenta_Change()

   If IsNumeric(txtCodigoCuenta.Text) Then
      On Error GoTo SalidaConError
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorCodigo", Array(txtCodigoCuenta.Text, origen.Registro.Fields("FechaComprobante").Value))
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdCuentaContable").Value = oRs.Fields(0).Value
      Else
         origen.Registro.Fields("IdCuentaContable").Value = Null
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

Private Sub txtDetalle_GotFocus()

   With txtDetalle
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDetalle_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDetalle
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
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

Private Sub txtIVA_GotFocus()

   With txtIVA
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtIVA_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroComprobante_GotFocus()

   With txtNumeroComprobante
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroComprobante_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Get ObjetoOrigen() As String

   ObjetoOrigen = mObjetoOrigen
   
End Property

Public Property Let ObjetoOrigen(ByVal vnewvalue As String)

   mObjetoOrigen = vnewvalue

End Property

Public Property Get IdCuentaBancaria() As Long

   IdCuentaBancaria = mIdCuentaBancaria
   
End Property

Public Property Let IdCuentaBancaria(ByVal vnewvalue As Long)

   mIdCuentaBancaria = vnewvalue
   
End Property

Public Sub CalculaTotales()

   Dim oRs As ADOR.Recordset
   Dim mTotalPorcentaje As Double, mvarTotalDebe As Double, mvarTotalHaber As Double
   
   mvarTotalRubrosContables = 0
   Set oRs = origen.DetValoresRubrosContables.TodosLosRegistros
   If oRs.State <> 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            mvarTotalRubrosContables = mvarTotalRubrosContables + IIf(IsNull(oRs.Fields("Importe").Value), 0, oRs.Fields("Importe").Value)
            oRs.MoveNext
         Loop
      End If
      oRs.Close
   End If
   Set oRs = Nothing
   txtTotal(5).Text = Format(mvarTotalRubrosContables, "#,##0.00")
   
   mTotalPorcentaje = 0
   Set oRs = origen.DetValoresProvincias.TodosLosRegistros
   If oRs.State <> 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            mTotalPorcentaje = mTotalPorcentaje + IIf(IsNull(oRs.Fields("Porcentaje").Value), 0, oRs.Fields("Porcentaje").Value)
            oRs.MoveNext
         Loop
      End If
      oRs.Close
   End If
   Set oRs = Nothing
   txtTotal(0).Text = Format(mTotalPorcentaje, "#,##0.00")
   
   mvarTotalDebe = 0
   mvarTotalHaber = 0
   Set oRs = origen.DetValoresCuentas.TodosLosRegistros
   If oRs.State <> 0 Then
      If oRs.RecordCount > 0 Then
      oRs.MoveFirst
      Do While Not oRs.EOF
         If Not IsNull(oRs.Fields("Debe").Value) Then
            mvarTotalDebe = mvarTotalDebe + oRs.Fields("Debe").Value
         End If
         If Not IsNull(oRs.Fields("Haber").Value) Then
            mvarTotalHaber = mvarTotalHaber + oRs.Fields("Haber").Value
         End If
         oRs.MoveNext
      Loop
      End If
      oRs.Close
   End If
   Set oRs = Nothing
   txtTotal(1).Text = Format(mvarTotalDebe, "0.00")
   txtTotal(2).Text = Format(mvarTotalHaber, "0.00")
   
End Sub

Public Sub ActualizaListaContable()

   If Check3.Value = 0 Then
      On Error Resume Next
      Set ListaCta.DataSource = origen.RegistroContableForm
      ListaCta.Refresh
      DoEvents: DoEvents
      txtTotal(1).Text = Format(origen.TotalDebe, "0.00")
      txtTotal(2).Text = Format(origen.TotalHaber, "0.00")
   End If
   
End Sub


