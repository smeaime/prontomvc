VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmConciliacion 
   Caption         =   "Ingreso de resumenes de conciliacion"
   ClientHeight    =   8310
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11565
   Icon            =   "frmConciliacion.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8310
   ScaleWidth      =   11565
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdImportar 
      Height          =   285
      Left            =   11070
      MaskColor       =   &H00FFFFFF&
      Picture         =   "frmConciliacion.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   53
      ToolTipText     =   "Importar resumen bancario (Excel)"
      Top             =   765
      Width           =   405
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   375
      Index           =   2
      Left            =   1035
      Picture         =   "frmConciliacion.frx":1034
      Style           =   1  'Graphical
      TabIndex        =   51
      Top             =   7650
      Width           =   450
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   375
      Index           =   0
      Left            =   45
      Picture         =   "frmConciliacion.frx":15BE
      Style           =   1  'Graphical
      TabIndex        =   50
      Top             =   7650
      UseMaskColor    =   -1  'True
      Width           =   450
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   375
      Index           =   1
      Left            =   540
      Picture         =   "frmConciliacion.frx":1C28
      Style           =   1  'Graphical
      TabIndex        =   49
      Top             =   7650
      Width           =   450
   End
   Begin VB.TextBox txtSaldoFueraDeContabilidad 
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
      Left            =   9915
      Locked          =   -1  'True
      TabIndex        =   47
      Top             =   6435
      Width           =   1485
   End
   Begin VB.TextBox txtDiferencia3 
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
      Left            =   9915
      Locked          =   -1  'True
      TabIndex        =   43
      Top             =   7695
      Width           =   1485
   End
   Begin VB.CommandButton cmdPegar 
      Caption         =   "Pegar items"
      Height          =   255
      Index           =   1
      Left            =   3960
      Style           =   1  'Graphical
      TabIndex        =   40
      Top             =   5175
      UseMaskColor    =   -1  'True
      Width           =   1470
   End
   Begin VB.TextBox txtDiferencia1 
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
      Left            =   9915
      Locked          =   -1  'True
      TabIndex        =   36
      Top             =   5805
      Width           =   1485
   End
   Begin VB.TextBox txtSaldoContable 
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
      Left            =   9915
      Locked          =   -1  'True
      TabIndex        =   34
      Top             =   5490
      Width           =   1485
   End
   Begin VB.TextBox txtSumatoriaMovimientosFueraExtracto 
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
      Left            =   9915
      Locked          =   -1  'True
      TabIndex        =   32
      Top             =   5175
      Width           =   1485
   End
   Begin VB.TextBox txtSaldoFinalCalculado 
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
      Left            =   9915
      Locked          =   -1  'True
      TabIndex        =   29
      Top             =   6750
      Width           =   1485
   End
   Begin VB.CommandButton cmdPegar 
      Caption         =   "Pegar items"
      Height          =   255
      Index           =   0
      Left            =   3960
      Style           =   1  'Graphical
      TabIndex        =   27
      Top             =   2970
      UseMaskColor    =   -1  'True
      Width           =   1470
   End
   Begin VB.TextBox txtDiferencia2 
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
      Left            =   9915
      Locked          =   -1  'True
      TabIndex        =   30
      Top             =   7380
      Width           =   1485
   End
   Begin VB.TextBox txtSumatoriaMovimientos 
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
      Left            =   9915
      Locked          =   -1  'True
      TabIndex        =   28
      Top             =   2970
      Width           =   1485
   End
   Begin VB.TextBox txtImporteAjuste 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteAjuste"
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
      Left            =   9915
      TabIndex        =   8
      Top             =   6120
      Width           =   1485
   End
   Begin VB.TextBox txtSaldoFinalResumen 
      Alignment       =   1  'Right Justify
      DataField       =   "SaldoFinalResumen"
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
      Left            =   9915
      TabIndex        =   9
      Top             =   7065
      Width           =   1485
   End
   Begin VB.TextBox txtNumero 
      Alignment       =   2  'Center
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
      Left            =   1575
      TabIndex        =   0
      Top             =   90
      Width           =   1275
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   375
      Index           =   0
      Left            =   45
      TabIndex        =   10
      Top             =   6930
      Width           =   1425
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   285
      Index           =   1
      Left            =   45
      TabIndex        =   11
      Top             =   7335
      Width           =   1425
   End
   Begin VB.TextBox txtSaldoInicialResumen 
      Alignment       =   1  'Right Justify
      DataField       =   "SaldoInicialResumen"
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
      Left            =   7170
      TabIndex        =   7
      Top             =   7065
      Width           =   1125
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   915
      Left            =   1575
      TabIndex        =   12
      Top             =   7110
      Width           =   3885
      _ExtentX        =   6853
      _ExtentY        =   1614
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmConciliacion.frx":21B2
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   13
      Top             =   8025
      Width           =   11565
      _ExtentX        =   20399
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   2
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   10583
            MinWidth        =   10583
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaIngreso"
      Height          =   330
      Index           =   0
      Left            =   4590
      TabIndex        =   2
      Top             =   90
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   57475073
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdRealizo"
      Height          =   315
      Index           =   0
      Left            =   9630
      TabIndex        =   5
      Tag             =   "Empleados"
      Top             =   90
      Width           =   1860
      _ExtentX        =   3281
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdAprobo"
      Height          =   315
      Index           =   1
      Left            =   9630
      TabIndex        =   6
      Tag             =   "Empleados"
      Top             =   450
      Width           =   1860
      _ExtentX        =   3281
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaInicial"
      Height          =   330
      Index           =   1
      Left            =   7470
      TabIndex        =   4
      Top             =   45
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   57475073
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaFinal"
      Height          =   330
      Index           =   2
      Left            =   7470
      TabIndex        =   3
      Top             =   450
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   57475073
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCuentaBancaria"
      Height          =   315
      Index           =   2
      Left            =   900
      TabIndex        =   1
      Tag             =   "Bancos"
      Top             =   450
      Width           =   4965
      _ExtentX        =   8758
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaBancaria"
      Text            =   ""
   End
   Begin Controles1013.DbListView ListaFueraExtracto 
      Height          =   1725
      Left            =   0
      TabIndex        =   31
      Top             =   3420
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   3043
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Checkboxes      =   -1  'True
      MouseIcon       =   "frmConciliacion.frx":2234
      OLEDragMode     =   1
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaNoContable 
      Height          =   1365
      Left            =   0
      TabIndex        =   45
      Top             =   5490
      Width           =   5460
      _ExtentX        =   9631
      _ExtentY        =   2408
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConciliacion.frx":2250
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   4410
      Top             =   6525
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
            Picture         =   "frmConciliacion.frx":226C
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConciliacion.frx":237E
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConciliacion.frx":27D0
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConciliacion.frx":2C22
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   1905
      Left            =   0
      TabIndex        =   14
      Top             =   1035
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   3360
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Checkboxes      =   -1  'True
      MouseIcon       =   "frmConciliacion.frx":3074
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Label lblRegistros 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
      Height          =   240
      Left            =   45
      TabIndex        =   52
      Top             =   2925
      Width           =   690
   End
   Begin VB.Label lblLabels 
      Caption         =   "Suma movimientos pendientes de contabilizar y en extracto :"
      Height          =   240
      Index           =   20
      Left            =   5535
      TabIndex        =   48
      Top             =   6480
      Width           =   4305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Movimientos pendientes en contabilidad : "
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
      Index           =   19
      Left            =   45
      TabIndex        =   46
      Top             =   5310
      Width           =   3540
   End
   Begin VB.Label lblLabels 
      Caption         =   "Saldo inicial extracto + Movimientos - Saldo final extracto :"
      Height          =   240
      Index           =   18
      Left            =   5535
      TabIndex        =   44
      Top             =   7740
      Width           =   4305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Movimientos inexistentes en el extracto :"
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
      Left            =   45
      TabIndex        =   42
      Top             =   3195
      Width           =   3495
   End
   Begin VB.Label lblLabels 
      Caption         =   "Movimientos existentes en el extracto :"
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
      Index           =   16
      Left            =   45
      TabIndex        =   41
      Top             =   855
      Width           =   3405
   End
   Begin VB.Label lblLabels 
      Caption         =   "Saldo final a controlar contra saldo final del extracto :"
      Height          =   240
      Index           =   11
      Left            =   5535
      TabIndex        =   39
      Top             =   6795
      Width           =   4305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ajustes por movimientos en extracto no contabilizables : "
      Height          =   240
      Index           =   8
      Left            =   5535
      TabIndex        =   38
      Top             =   6165
      Width           =   4305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Saldo sin tomar movimientos fuera de extracto ( [2] - [1] ) :"
      Height          =   240
      Index           =   15
      Left            =   5535
      TabIndex        =   37
      Top             =   5850
      Width           =   4305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Saldo contable de la cuenta a la fecha final del extracto [2] :"
      Height          =   240
      Index           =   13
      Left            =   5535
      TabIndex        =   35
      Top             =   5535
      Width           =   4305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Sumatoria movimientos en contabilidad (no en extracto) [1] :"
      Height          =   240
      Index           =   12
      Left            =   5535
      TabIndex        =   33
      Top             =   5220
      Width           =   4305
   End
   Begin VB.Label lblData 
      Caption         =   "Bco./Cta.:"
      Height          =   255
      Index           =   0
      Left            =   45
      TabIndex        =   26
      Top             =   495
      Width           =   780
   End
   Begin VB.Label lblLabels 
      Caption         =   "Diferencia (debe ser igual a cero para grabar el extracto) :"
      Height          =   240
      Index           =   10
      Left            =   5535
      TabIndex        =   25
      Top             =   7425
      Width           =   4305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Sumatoria movimientos en extracto :"
      Height          =   240
      Index           =   9
      Left            =   7245
      TabIndex        =   24
      Top             =   3015
      Width           =   2595
   End
   Begin VB.Label lblLabels 
      Caption         =   "Saldo final extracto :"
      Height          =   240
      Index           =   7
      Left            =   8370
      TabIndex        =   23
      Top             =   7110
      Width           =   1470
   End
   Begin VB.Label lblLabels 
      Caption         =   "Saldo inicial extracto :"
      Height          =   240
      Index           =   6
      Left            =   5535
      TabIndex        =   22
      Top             =   7110
      Width           =   1560
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha final res. :"
      Height          =   240
      Index           =   3
      Left            =   5985
      TabIndex        =   21
      Top             =   495
      Width           =   1425
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha inicial res. :"
      Height          =   240
      Index           =   2
      Left            =   5985
      TabIndex        =   20
      Top             =   90
      Width           =   1425
   End
   Begin VB.Label lblLabels 
      Caption         =   "Resumen numero :"
      Height          =   240
      Index           =   14
      Left            =   45
      TabIndex        =   19
      Top             =   135
      Width           =   1470
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de ingreso :"
      Height          =   240
      Index           =   4
      Left            =   3105
      TabIndex        =   18
      Top             =   135
      Width           =   1425
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Observaciones :"
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
      Left            =   1620
      TabIndex        =   17
      Top             =   6930
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Realizo : "
      Height          =   240
      Index           =   5
      Left            =   8865
      TabIndex        =   16
      Top             =   135
      Width           =   705
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Aprobo :"
      Height          =   240
      Index           =   1
      Left            =   8865
      TabIndex        =   15
      Top             =   495
      Width           =   705
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
   Begin VB.Menu MnuDetEx 
      Caption         =   "DetalleExtracto"
      Visible         =   0   'False
      Begin VB.Menu MnuDetExA 
         Caption         =   "Quitar"
         Index           =   0
      End
   End
   Begin VB.Menu MnuDetFueraEx 
      Caption         =   "DetalleFueraExtracto"
      Visible         =   0   'False
      Begin VB.Menu MnuDetFueraExA 
         Caption         =   "Quitar"
         Index           =   0
      End
   End
End
Attribute VB_Name = "frmConciliacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Conciliacion
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mIdAprobo As Long, mIdCuentaBancaria As Long
Private mvarIdMonedaPesos As Long, mvarIdMonedaDolar As Long
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

Sub Editar(ByVal Cual As Long)

   Dim oF As frmDetConciliacionesNoContables
   Dim oL As ListItem
   
   Set oF = New frmDetConciliacionesNoContables
   
   With oF
      Set .Conciliacion = origen
      .FechaInicialResumen = DTFields(1).Value
      .FechaFinalResumen = DTFields(2).Value
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaNoContable.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaNoContable.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtDetalle.Text
            .SubItems(1) = "" & Format(Val(oF.txtIngresos.Text), "Fixed")
            .SubItems(2) = "" & Format(Val(oF.txtEgresos.Text), "Fixed")
            .SubItems(3) = "" & IIf(IsNull(oF.DTFields(0).Value), "", oF.DTFields(0).Value)
            .SubItems(4) = "" & IIf(IsNull(oF.DTFields(1).Value), "", oF.DTFields(1).Value)
'            .SubItems(5) = "" & IIf(IsNull(oF.DTFields(2).Value), "", oF.DTFields(2).Value)
            .SubItems(6) = "" & Val(oF.txtIngresos.Text)
            .SubItems(7) = "" & Val(oF.txtEgresos.Text)
         End With
      End If
   End With
   
   Unload oF
   Set oF = Nothing
   
   CalcularTotales
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         If Val(txtDiferencia2.Text) <> 0 And mIdAprobo > 0 Then
            MsgBox "La diferencia debe ser cero para grabar el resumen", vbExclamation
            Exit Sub
         End If
         
         If Len(txtNumero.Text) = 0 Then
            MsgBox "Debe ingresar el numero de resumen", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(dcfields(2).BoundText) Then
            MsgBox "No ha definido la cuenta bancaria", vbExclamation
            Exit Sub
         End If
      
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar un comprobante sin detalles"
            Exit Sub
         End If
         
         If mvarId < 0 Then
            Dim oRs As ADOR.Recordset
            Set oRs = Aplicacion.Conciliaciones.TraerFiltrado("_ValidarNumeroResumen", Array(txtNumero.Text, dcfields(2).BoundText))
            If oRs.RecordCount > 0 Then
               oRs.Close
               Set oRs = Nothing
               MsgBox "Numero de resumen ya ingresado", vbCritical
               Exit Sub
            End If
            oRs.Close
            Set oRs = Nothing
         End If
         
         Dim dtp As DTPicker
         Dim dc As DataCombo
         Dim est As EnumAcciones
         Dim i As Integer
         Dim oL As ListItem, oL1 As ListItem
         Dim Filas, Columnas
         
         With origen.Registro
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
         
            For Each dc In dcfields
               If dc.Enabled Then
                  If Not IsNumeric(dc.BoundText) And dc.Index <> 1 Then
                     MsgBox "Falta completar el campo " & IIf(mId(dc.DataField, 1, 2) = "Id", mId(dc.DataField, 3, 20), dc.DataField), vbCritical
                     Exit Sub
                  End If
                  If IsNumeric(dc.BoundText) Then
                     .Fields(dc.DataField).Value = dc.BoundText
                  End If
               End If
            Next
         
            .Fields("Observaciones").Value = rchObservaciones.Text
         End With
         
         For Each oL In Lista.ListItems
            For Each oL1 In ListaFueraExtracto.ListItems
               If IsNumeric(oL.SubItems(1)) And IsNumeric(oL1.SubItems(1)) And _
                     oL.SubItems(1) = oL1.SubItems(1) Then
                  If Val(oL.SubItems(1)) <> 0 Then
                     MsgBox "El valor " & oL.SubItems(3) & " esta en la lista " & _
                              "dentro y fuera de extracto", vbExclamation
                     Exit Sub
                  End If
               End If
            Next
         Next
         
         For Each oL In Lista.ListItems
            With origen.DetConciliaciones.Item(oL.SubItems(19))
               .Registro.Fields("Controlado").Value = "NO"
               .Modificado = True
            End With
         Next
         
         Filas = VBA.Split(Lista.GetStringCheck, vbCrLf)
         For i = LBound(Filas) + 1 To UBound(Filas)
            Columnas = VBA.Split(Filas(i), vbTab)
            With origen.DetConciliaciones.Item(Columnas(20))
               .Registro.Fields("Controlado").Value = "SI"
               .Modificado = True
            End With
         Next
         
         For Each oL In ListaFueraExtracto.ListItems
            With origen.DetConciliaciones.Item(oL.SubItems(19))
               .Registro.Fields("ControladoNoConciliado").Value = "NO"
               .Modificado = True
            End With
         Next
         
         Filas = VBA.Split(ListaFueraExtracto.GetStringCheck, vbCrLf)
         For i = LBound(Filas) + 1 To UBound(Filas)
            Columnas = VBA.Split(Filas(i), vbTab)
            With origen.DetConciliaciones.Item(Columnas(20))
               .Registro.Fields("ControladoNoConciliado").Value = "SI"
               .Modificado = True
            End With
         Next
         
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
         Else
            est = Modificacion
         End If
            
         If Not actL2 Is Nothing Then
            With actL2
               .ListaEditada = "ResumenesParaConciliacionTodos,+SubRC2"
               .AccionRegistro = est
               .Disparador = mvarId
            End With
         End If
         
         If IsNumeric(dcfields(1).BoundText) Then
            Dim mvarImprime As Integer
            mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de resumen")
            If mvarImprime = vbYes Then
               cmdImpre_Click 0
            End If
         End If
      
         Unload Me

      Case 1
         Unload Me

   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oDet As ComPronto.DetConciliacion
   Dim oDetNC As ComPronto.DetConciliacionNoContable
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   Dim oL As ListItem
   Dim oF As frmAviso
   Dim ListaVacia1 As Boolean, ListaVacia2 As Boolean, ListaVacia3 As Boolean
   Dim i As Integer
   
   Set oF = New frmAviso
   With oF
      .Caption = ""
      .Label1 = "Abriendo conciliacion ..."
      .Show
      .Refresh
      DoEvents
   End With

   mvarId = vNewValue
   ListaVacia1 = False
   ListaVacia2 = False
   ListaVacia3 = False
   
   Set oAp = Aplicacion
   Set origen = oAp.Conciliaciones.Item(vNewValue)
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      mvarIdMonedaPesos = .Fields("IdMoneda").Value
      mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
   End With
   oRs.Close
   
   oF.Label1 = vbCrLf & vbCrLf & "Abriendo conciliacion ..." & vbCrLf & vbCrLf & "Procesando registros ..."
   DoEvents
   
   Set oBind = New BindingCollection
   
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetConciliaciones.TraerMascara
                     ListaVacia1 = True
                  Else
                     Set oRs = origen.DetConciliaciones.TraerFiltrado("_Conciliados", mvarId)
                     If oRs.RecordCount > 0 Then
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           oF.Label2 = "Registro : " & oRs.AbsolutePosition & " de " & oRs.RecordCount
                           DoEvents
                           Set oDet = origen.DetConciliaciones.Item(oRs.Fields(0).Value)
                           oDet.Modificado = True
                           Set oDet = Nothing
                           oRs.MoveNext
                        Loop
                        oRs.MoveFirst
                        Set oControl.DataSource = oRs
                        
                        For Each oL In Lista.ListItems
                           oRs.MoveFirst
                           oRs.Find "IdDetalleConciliacion = " & oL.Tag
                           If Not oRs.EOF Then
                              If Not IsNull(oRs.Fields("Controlado").Value) And _
                                    oRs.Fields("Controlado").Value = "SI" Then
                                 oL.Checked = True
                              End If
                           End If
                        Next
                        ListaVacia1 = False
                     Else
                        Set oControl.DataSource = origen.DetConciliaciones.TraerMascara
                        ListaVacia1 = True
                     End If
                     Set oRs = Nothing
                  End If
               Case "ListaFueraExtracto"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetConciliaciones.TraerMascara
                     ListaVacia2 = True
                  Else
                     Set oRs = origen.DetConciliaciones.TraerFiltrado("_NoConciliados", mvarId)
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           If Not IsNull(oRs.Fields("ControladoNoConciliado").Value) And oRs.Fields("ControladoNoConciliado").Value = "SI" Then
                              For Each oL In ListaFueraExtracto.ListItems
                                 If oL.Tag = oRs.Fields(0).Value Then
                                    oL.Checked = True
                                    Exit For
                                 End If
                              Next
                           End If
                           Set oDet = origen.DetConciliaciones.Item(oRs.Fields(0).Value)
                           oDet.Modificado = True
                           Set oDet = Nothing
                           oRs.MoveNext
                        Loop
                        ListaVacia2 = False
                     Else
                        Set oControl.DataSource = origen.DetConciliaciones.TraerMascara
                        ListaVacia2 = True
                     End If
                     Set oRs = Nothing
                  End If
               Case "ListaNoContable"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetConciliacionesNoContables.TraerMascara
                     ListaVacia3 = True
                  Else
                     Set oRs = origen.DetConciliacionesNoContables.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           Set oDetNC = origen.DetConciliacionesNoContables.Item(oRs.Fields(0).Value)
                           oDetNC.Modificado = True
                           Set oDetNC = Nothing
                           oRs.MoveNext
                        Loop
                        ListaVacia3 = False
                     Else
                        Set oControl.DataSource = origen.DetConciliacionesNoContables.TraerMascara
                        ListaVacia3 = True
                     End If
                     oRs.Close
                  End If

'                  If vNewValue < 0 Then
'                     Set oRs = origen.DetConciliacionesNoContables.TraerFiltrado("_NoCaducados", Array(Me.IdCuentaBancaria, Date))
'                  Else
'                     Set oRs = origen.DetConciliacionesNoContables.TraerFiltrado("_NoCaducados", _
'                           Array(origen.Registro.Fields("IdCuentaBancaria").Value, origen.Registro.Fields("FechaFinal").Value))
'                  End If
'                  If oRs.RecordCount > 0 Then
'                     Set oControl.DataSource = oRs
'                     oRs.MoveFirst
'                     Do While Not oRs.EOF
'                        Set oDetNC = origen.DetConciliacionesNoContables.Item(oRs.Fields(0).Value)
'                        oDetNC.Modificado = True
'                        Set oDetNC = Nothing
'                        oRs.MoveNext
'                     Loop
'                     ListaVacia3 = False
'                  Else
'                     Set oControl.DataSource = origen.DetConciliacionesNoContables.TraerMascara
'                     ListaVacia3 = True
'                  End If
'                  oRs.Close
            End Select
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Bancos" Then
                  Set oControl.RowSource = oAp.Bancos.TraerFiltrado("_PorCuentasBancarias")
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
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      With origen.Registro
         .Fields("FechaRegistro").Value = Date
         .Fields("IdRealizo").Value = glbIdUsuario
         .Fields("IdCuentaBancaria").Value = Me.IdCuentaBancaria
      End With
      mIdAprobo = 0
   Else
      With origen.Registro
         mIdAprobo = IIf(IsNull(.Fields("IdAprobo").Value), 0, .Fields("IdAprobo").Value)
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
      If mIdAprobo > 0 Then
         DTFields(0).Enabled = False
         DTFields(1).Enabled = False
         DTFields(2).Enabled = False
         dcfields(0).Enabled = False
         dcfields(1).Enabled = False
         dcfields(2).Enabled = False
         txtNumero.Enabled = False
         txtSaldoInicialResumen.Locked = True
         txtImporteAjuste.Locked = True
         txtSaldoFinalResumen.Locked = True
         MnuDetExA(0).Enabled = False
      End If
   End If
   
   If ListaVacia1 Then Lista.ListItems.Clear
   If ListaVacia2 Then ListaFueraExtracto.ListItems.Clear
   If ListaVacia3 Then ListaNoContable.ListItems.Clear
   
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
   End If
   If mIdAprobo <> 0 Then cmd(0).Enabled = False

   Set oRs = Nothing
   Set oAp = Nothing
   
   Unload oF
   Set oF = Nothing
   
   CalcularTotales
   
End Property

Private Sub cmdImportar_Click()

   ImportarResumen

End Sub

Private Sub cmdImpre_Click(Index As Integer)

   If mvarId <= 0 Then
      MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
      Exit Sub
   End If
   
'   If mIdAprobo = 0 Then
'      MsgBox "Para imprimir el resumen debe primero aprobarlo", vbCritical
'      Exit Sub
'   End If
   
   Dim mvarOK As Boolean
   Dim mCopias As Integer
   Dim mPrinter As String, mPrinterAnt As String
   
   mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
   If Index = 0 Then
      Dim oF As frmCopiasImpresion
      Set oF = New frmCopiasImpresion
      With oF
         .txtCopias.Text = 2
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

   On Error GoTo Mal
   
   Dim oW As Word.Application
   Dim oEx As Excel.Application
   Dim mTotales(10) As String
   Dim oL As ListItem
   
   For Each oL In Lista.ListItems
      oL.Selected = True
   Next
   For Each oL In ListaFueraExtracto.ListItems
      oL.Selected = True
   Next
   For Each oL In ListaNoContable.ListItems
      oL.Selected = True
   Next
   
   mTotales(0) = txtSumatoriaMovimientos.Text
   mTotales(1) = txtSumatoriaMovimientosFueraExtracto.Text
   mTotales(2) = txtSaldoContable.Text
   mTotales(3) = txtDiferencia1.Text
   mTotales(4) = Format(Val(txtImporteAjuste.Text), "#,##0.00")
   mTotales(5) = txtSaldoFueraDeContabilidad.Text
   mTotales(6) = txtSaldoFinalCalculado.Text
   mTotales(7) = Format(Val(txtSaldoInicialResumen.Text), "#,##0.00")
   mTotales(8) = Format(Val(txtSaldoFinalResumen.Text), "#,##0.00")
   mTotales(9) = txtDiferencia2.Text
   mTotales(10) = txtDiferencia3.Text
   
   If Index = 2 Then
   
      Set oEx = CreateObject("Excel.Application")
      With oEx
         .Visible = True
         With .Workbooks.Add(glbPathPlantillas & "\ComprasTerceros.xlt")
            oEx.Run "Conciliacion", glbStringConexion, mvarId, Lista.GetString, _
                                    ListaFueraExtracto.GetString, _
                                    ListaNoContable.GetString, _
                                    mTotales
         End With
      End With
   
   Else
   
      Set oW = CreateObject("Word.Application")
      With oW
         .Visible = True
         .Documents.Add (glbPathPlantillas & "\Conciliacion.dot")
         .Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId, _
               varg3:=mPrinter, varg4:=mCopias, varg5:=Lista.GetString, _
               varg6:=ListaFueraExtracto.GetString, varg7:=ListaNoContable.GetString, _
               varg8:=mTotales, varg9:=glbEmpresaSegunString, varg10:=glbPathPlantillas
         If Index = 0 Then
            oW.Documents(1).Close False
            oW.Quit
         End If
      End With
   
   End If
   
   For Each oL In Lista.ListItems
      oL.Selected = False
   Next
   For Each oL In ListaFueraExtracto.ListItems
      oL.Selected = False
   Next
   For Each oL In ListaNoContable.ListItems
      oL.Selected = False
   Next
   
   GoTo Salida
   
Mal:
   Me.MousePointer = vbDefault
   MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical

Salida:
   Set oL = Nothing
   Set oW = Nothing
   Set oEx = Nothing
   Me.MousePointer = vbDefault
   
End Sub

Private Sub cmdPegar_Click(Index As Integer)

   Dim s As String, mErrores As String
   Dim iFilas As Long, iColumnas As Long
   Dim mError As Boolean
   Dim Filas
   Dim Columnas

   If Not Clipboard.GetFormat(vbCFText) Then
      MsgBox "No hay informacion en el portapapeles", vbCritical
      Exit Sub
   End If
   
   On Error GoTo Mal
   
   s = Clipboard.GetText(vbCFText)
   
   Filas = Split(s, vbCrLf)
   Columnas = Split(Filas(LBound(Filas)), vbTab)
   
   If Not IsNumeric(dcfields(2).BoundText) Then
      MsgBox "Sólo puede arrastrar aqui elementos de la conciliacion si ha definido la cuenta bancaria", vbExclamation
      Exit Sub
   End If
   
   If Not InStr(1, Columnas(LBound(Columnas) + 2), "IdVal") <> 0 Then
      MsgBox "Sólo puede arrastrar aqui elementos de la conciliacion", vbExclamation
      Exit Sub
   End If
   
   mErrores = ""
   For iFilas = LBound(Filas) + 1 To UBound(Filas)
      Columnas = Split(Filas(iFilas), vbTab)
      mError = False
      If Columnas(3) <> dcfields(2).BoundText Then
         mErrores = mErrores & "El valor " & Columnas(4) & " no corresponde a la cuenta bancaria" & vbCrLf
         mError = True
      End If
      If Columnas(9) = "SI" Then
         mErrores = mErrores & "El valor " & Columnas(4) & " ya esta conciliado" & vbCrLf
         mError = True
      End If
      If origen.ValorExistenteEnResumen(Columnas(2)) Then
         mErrores = mErrores & "El valor " & Columnas(4) & " ya esta en este resumen" & vbCrLf
         mError = True
      End If
      If Not mError Then
         With origen.DetConciliaciones.Item(-1)
            .Registro.Fields("IdValor").Value = Columnas(2)
            If Index = 0 Then
               .Registro.Fields("Conciliado").Value = "SI"
            Else
               .Registro.Fields("Conciliado").Value = "NO"
            End If
            .Modificado = True
         End With
      End If
   Next

   If Index = 0 Then
      Set Lista.DataSource = origen.DetConciliaciones.RegistrosConFormatoConciliados
      Lista.Refresh
   Else
      Set ListaFueraExtracto.DataSource = origen.DetConciliaciones.RegistrosConFormatoNoConciliados
      ListaFueraExtracto.Refresh
   End If
   
   If Len(mErrores) > 0 Then
      MsgBox "Se han producido los siguientes errores :" & vbCrLf & mErrores & "Estos valores fueron descartados.", vbExclamation
   End If

   Clipboard.Clear
   
   CalcularTotales
   
   Exit Sub
   
Mal:
   Clipboard.Clear
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

End Sub

Private Sub dcfields_Change(Index As Integer)

   If IsNumeric(dcfields(Index).BoundText) Then
      If IsNull(origen.Registro.Fields(dcfields(Index).DataField).Value) Or origen.Registro.Fields(dcfields(Index).DataField).Value <> dcfields(Index).BoundText Then
         origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
      End If
   End If
   
End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   If Index = 1 And Me.Visible And IsNumeric(dcfields(Index).BoundText) Then
      If dcfields(Index).BoundText <> mIdAprobo Then PideAutorizacion
   End If

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub dcfields_Validate(Index As Integer, Cancel As Boolean)

   If IsNumeric(dcfields(Index).BoundText) And Index = 2 And mvarId <= 0 Then
      Dim oDet As ComPronto.DetConciliacion
      Dim oDet1 As ComPronto.DetConciliacionNoContable
      Dim oRs As ADOR.Recordset
      
      Set oRs = origen.DetConciliaciones.RegistrosConFormatoNoConciliados
      If Not oRs Is Nothing Then
         If oRs.RecordCount <> 0 Then
            oRs.MoveFirst
            Do While Not oRs.EOF
               Set oDet = origen.DetConciliaciones.Item(oRs.Fields(0).Value)
               oDet.Eliminado = True
               Set oDet = Nothing
               oRs.MoveNext
            Loop
         End If
         oRs.Close
      End If
      
      Set oRs = Aplicacion.Conciliaciones.TraerFiltrado("_NoConciliadosAnterior", dcfields(Index).BoundText)
      If Not oRs Is Nothing Then
         If oRs.RecordCount <> 0 Then
            oRs.MoveFirst
            Do While Not oRs.EOF
               With origen.DetConciliaciones.Item(-1)
                  .Registro.Fields("IdValor").Value = oRs.Fields("IdValor").Value
                  .Registro.Fields("Conciliado").Value = "NO"
                  .Modificado = True
               End With
               oRs.MoveNext
            Loop
         End If
         oRs.Close
         Set ListaFueraExtracto.DataSource = origen.DetConciliaciones.RegistrosConFormatoNoConciliados
      End If
      
      Set oRs = Aplicacion.Conciliaciones.TraerFiltrado("_SaldoFinalResumenAnterior", dcfields(Index).BoundText)
      If Not oRs Is Nothing Then
         If oRs.RecordCount <> 0 Then
            origen.Registro.Fields("SaldoInicialResumen").Value = oRs.Fields("SaldoFinalResumen").Value
         End If
      End If
      oRs.Close
      
      Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetConciliacionesNoContables", "_UltimoResumen", dcfields(Index).BoundText)
      If oRs.RecordCount <> 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            Set oDet1 = origen.DetConciliacionesNoContables.Item(-1)
            With oDet1
               With oDet1.Registro
                  .Fields("Detalle").Value = oRs.Fields("Detalle").Value
                  .Fields("FechaIngreso").Value = oRs.Fields("FechaIngreso").Value
                  .Fields("FechaCaducidad").Value = oRs.Fields("FechaCaducidad").Value
                  .Fields("FechaRegistroContable").Value = oRs.Fields("FechaRegistroContable").Value
                  .Fields("Ingresos").Value = oRs.Fields("Ingresos").Value
                  .Fields("Egresos").Value = oRs.Fields("Egresos").Value
               End With
               .Modificado = True
            End With
            Set oDet1 = Nothing
            oRs.MoveNext
         Loop
         Set ListaNoContable.DataSource = origen.DetConciliacionesNoContables.RegistrosConFormato
      End If
      oRs.Close
      
      Set oRs = Nothing
      
      CalcularTotales
   End If

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub DTFields_LostFocus(Index As Integer)

   If Index = 2 Then CalcularTotales
   
End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With ListaNoContable
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete And mIdAprobo = 0 Then MnuDetExA_Click 0

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton And mIdAprobo = 0 Then
      If Lista.ListItems.Count = 0 Then
      Else
         PopupMenu MnuDetEx, , , , MnuDetExA(0)
      End If
   End If

End Sub

Private Sub Lista_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String, mErrores As String
   Dim iFilas As Long, iColumnas As Long
   Dim mError As Boolean
   Dim oRs As ADOR.Recordset
   Dim Filas, Columnas

   If Data.GetFormat(ccCFText) Then
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If Not IsNumeric(dcfields(2).BoundText) Then
         MsgBox "Sólo puede arrastrar aqui elementos de la conciliacion si ha definido la cuenta bancaria", vbExclamation
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 2), "IdVal") <> 0 And Columnas(LBound(Columnas) + 2) <> "IdValor" Then
         mErrores = ""
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            mError = False
            If Columnas(3) <> dcfields(2).BoundText Then
               mErrores = mErrores & "El valor " & Columnas(4) & " no corresponde a la cuenta bancaria" & vbCrLf
               mError = True
            End If
            If Columnas(13) = "SI" Then
               mErrores = mErrores & "El valor " & Columnas(4) & " ya esta conciliado" & vbCrLf
               mError = True
            End If
            If origen.ValorExistenteEnResumen(Columnas(2)) Then
               mErrores = mErrores & "El valor " & Columnas(4) & " ya esta en este resumen" & vbCrLf
               mError = True
            End If
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetConciliaciones", "_ConfirmadoPorIdValor", Columnas(2))
            If oRs.RecordCount > 0 Then
               If oRs.Fields("IdConciliacion").Value <> mvarId Then
                  mErrores = mErrores & "El valor " & Columnas(4) & " ya esta en el resumen " & oRs.Fields("Numero").Value & vbCrLf
                  mError = True
               End If
            End If
            oRs.Close
            
            If Not mError Then
               With origen.DetConciliaciones.Item(-1)
                  .Registro.Fields("IdValor").Value = Columnas(2)
                  .Registro.Fields("Conciliado").Value = "SI"
                  .Modificado = True
               End With
               Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetConciliaciones", "_PorIdValorConFormato", Columnas(2))
               If oRs.RecordCount > 0 Then Set Lista.RecordSource = oRs
               Set oRs = Nothing
            End If
         Next
         'Set Lista.DataSource = origen.DetConciliaciones.RegistrosConFormatoConciliados
         'Lista.Refresh
         CalcularTotales
         Set oRs = Nothing
      
      ElseIf InStr(1, Columnas(20), "IdAux") <> 0 Then
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            With origen.DetConciliaciones.Item(Columnas(20))
               .Registro.Fields("IdValor").Value = Columnas(2)
               .Registro.Fields("Conciliado").Value = "SI"
               .Modificado = True
            End With
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetConciliaciones", "_PorIdValorConFormato", Columnas(2))
            If oRs.RecordCount > 0 Then Set Lista.RecordSource = oRs
            Set oRs = Nothing
         Next
         'Set Lista.DataSource = origen.DetConciliaciones.RegistrosConFormatoConciliados
         'Lista.Refresh
         Set ListaFueraExtracto.DataSource = origen.DetConciliaciones.RegistrosConFormatoNoConciliados
         ListaFueraExtracto.Refresh
         CalcularTotales
      
      Else
         MsgBox "Elemento invalido", vbExclamation
         Exit Sub
      End If
   
      If Len(mErrores) > 0 Then
         MsgBox "Se han producido los siguientes errores :" & vbCrLf & mErrores & "Estos valores fueron descartados.", vbExclamation
      End If
   
   End If

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

Private Sub PideAutorizacion()

   Dim oF As frmAutorizacion1
   Set oF = New frmAutorizacion1
   With oF
      .IdUsuario = dcfields(1).BoundText
      .Show vbModal, Me
   End With
   If Not oF.Ok Then
      With origen.Registro
         .Fields(dcfields(1).DataField).Value = Null
'         .Fields("FechaAprobacion").Value = Null
      End With
      mIdAprobo = 0
   Else
      With origen.Registro
'         .Fields("FechaAprobacion").Value = Now
         mIdAprobo = .Fields("IdAprobo").Value
      End With
   End If
   Unload oF
   Set oF = Nothing

End Sub

Private Sub ListaFueraExtracto_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaNoContable_DblClick()

   If ListaNoContable.ListItems.Count = 0 Then
      Editar -1
   Else
      Editar ListaNoContable.SelectedItem.Tag
   End If

End Sub

Private Sub ListaNoContable_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaNoContable_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetA_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetA_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetA_Click 1
   End If

End Sub

Private Sub ListaNoContable_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If ListaNoContable.ListItems.Count = 0 Then
         MnuDetA(1).Enabled = False
         MnuDetA(2).Enabled = False
         PopupMenu MnuDet, , , , MnuDetA(0)
      Else
         MnuDetA(1).Enabled = True
         PopupMenu MnuDet, , , , MnuDetA(1)
      End If
   End If

End Sub

Private Sub ListaFueraExtracto_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete And mIdAprobo = 0 Then MnuDetFueraExA_Click 0

End Sub

Private Sub ListaFueraExtracto_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton And mIdAprobo = 0 Then
      If ListaFueraExtracto.ListItems.Count = 0 Then
      Else
         PopupMenu MnuDetFueraEx, , , , MnuDetFueraExA(0)
      End If
   End If

End Sub

Private Sub ListaFueraExtracto_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String, mErrores As String
   Dim iFilas As Long, iColumnas As Long
   Dim mError As Boolean
   Dim Filas
   Dim Columnas

   If Data.GetFormat(ccCFText) Then
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If Not IsNumeric(dcfields(2).BoundText) Then
         MsgBox "Sólo puede arrastrar aqui elementos de la conciliacion si ha definido la cuenta bancaria", vbExclamation
         Exit Sub
      End If
      
      If Not InStr(1, Columnas(LBound(Columnas) + 2), "IdVal") <> 0 Then
         MsgBox "Sólo puede arrastrar aqui elementos de la conciliacion", vbExclamation
         Exit Sub
      End If
      
      mErrores = ""
      For iFilas = LBound(Filas) + 1 To UBound(Filas)
         Columnas = Split(Filas(iFilas), vbTab)
         mError = False
         If Columnas(3) <> dcfields(2).BoundText Then
            mErrores = mErrores & "El valor " & Columnas(4) & " no corresponde a la cuenta bancaria" & vbCrLf
            mError = True
         End If
         If Columnas(13) = "SI" Then
            mErrores = mErrores & "El valor " & Columnas(4) & " ya esta conciliado" & vbCrLf
            mError = True
         End If
         If origen.ValorExistenteEnResumen(Columnas(2)) Then
            mErrores = mErrores & "El valor " & Columnas(4) & " ya esta en este resumen" & vbCrLf
            mError = True
         End If
         If Not mError Then
            With origen.DetConciliaciones.Item(-1)
               .Registro.Fields("IdValor").Value = Columnas(2)
               .Registro.Fields("Conciliado").Value = "NO"
               .Modificado = True
            End With
         End If
      Next
   
      Set ListaFueraExtracto.DataSource = origen.DetConciliaciones.RegistrosConFormatoNoConciliados
      ListaFueraExtracto.Refresh
   
      If Len(mErrores) > 0 Then
         MsgBox "Se han producido los siguientes errores :" & vbCrLf & mErrores & "Estos valores fueron descartados.", vbExclamation
      End If
   
      CalcularTotales
   End If

End Sub

Private Sub ListaFueraExtracto_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

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

Private Sub ListaFueraExtracto_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then DefaultCursors = False

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         Editar ListaNoContable.SelectedItem.Tag
      Case 2
         If Not ListaNoContable.SelectedItem Is Nothing Then
            With ListaNoContable.SelectedItem
               origen.DetConciliacionesNoContables.Item(.Tag).Eliminado = True
               .SmallIcon = "Eliminado"
               .ToolTipText = .SmallIcon
            End With
            ListaNoContable.ListItems.Remove (ListaNoContable.object.SelectedItem.Index)
            CalcularTotales
         End If
   End Select

End Sub

Private Sub MnuDetExA_Click(Index As Integer)

   Select Case Index
      Case 0
'         Dim oL As ListItem
'         For Each oL In Lista.ListItems
'            If oL.Selected Then
'               origen.DetConciliaciones.Item(oL.SubItems(19)).Eliminado = True
'            End If
'         Next
         
         If Not Lista.SelectedItem Is Nothing Then
            Dim Filas, Columnas
            Dim iFilas As Integer
            Filas = VBA.Split(Lista.GetString, vbCrLf)
            For iFilas = LBound(Filas) + 1 To UBound(Filas)
               Columnas = VBA.Split(Filas(iFilas), vbTab)
               origen.DetConciliaciones.Item(Columnas(20)).Eliminado = True
            Next
            Set Lista.DataSource = origen.DetConciliaciones.RegistrosConFormatoConciliados
            Lista.Refresh
            CalcularTotales
         End If
   End Select

End Sub

Private Sub MnuDetFueraExA_Click(Index As Integer)

   Select Case Index
      Case 0
'         Dim oL As ListItem
'         For Each oL In ListaFueraExtracto.ListItems
'            If oL.Selected Then
'               origen.DetConciliaciones.Item(oL.SubItems(19)).Eliminado = True
'            End If
'         Next
         
         If Not ListaFueraExtracto.SelectedItem Is Nothing Then
            Dim Filas, Columnas
            Dim iFilas As Integer
            Filas = VBA.Split(ListaFueraExtracto.GetString, vbCrLf)
            For iFilas = LBound(Filas) + 1 To UBound(Filas)
               Columnas = VBA.Split(Filas(iFilas), vbTab)
               origen.DetConciliaciones.Item(Columnas(20)).Eliminado = True
            Next
            Set ListaFueraExtracto.DataSource = origen.DetConciliaciones.RegistrosConFormatoNoConciliados
            ListaFueraExtracto.Refresh
            CalcularTotales
         End If
   End Select

End Sub

Private Sub txtImporteAjuste_Change()

   CalcularTotales
   
End Sub

Private Sub txtImporteAjuste_GotFocus()

   With txtImporteAjuste
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImporteAjuste_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtNumero_GotFocus()

   With txtNumero
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumero_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtNumero
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If
   
End Sub

Private Sub txtSaldoFinalResumen_Change()

   CalcularTotales
   
End Sub

Private Sub txtSaldoFinalResumen_GotFocus()

   With txtSaldoFinalResumen
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtSaldoFinalResumen_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtSaldoInicialResumen_Change()

   CalcularTotales
   
End Sub

Private Sub txtSaldoInicialResumen_GotFocus()

   With txtSaldoInicialResumen
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtSaldoInicialResumen_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Public Property Get IdCuentaBancaria() As Long

   IdCuentaBancaria = mIdCuentaBancaria
   
End Property

Public Property Let IdCuentaBancaria(ByVal vNewValue As Long)

   mIdCuentaBancaria = vNewValue
   
End Property

Public Sub CalcularTotales()

   Dim oL As ListItem
   Dim mEgresos1 As Double, mIngresos1 As Double, mEgresos2 As Double
   Dim mIngresos2 As Double, mEgresos3 As Double, mIngresos3 As Double
   Dim mEgresos4 As Double, mIngresos4 As Double, mSaldoContable As Double
   Dim mImporteAjuste As Double, mSaldoFinalResumen As Double
   Dim mSaldoFinalCalculado As Double, mSaldoInicialResumen As Double
   Dim mDiferencia1 As Double, mDiferencia2 As Double, mDiferencia3 As Double
   Dim mProcesar As Boolean
   
   mSaldoContable = SaldoMayorContable()
   mImporteAjuste = Val(txtImporteAjuste.Text)
   mSaldoInicialResumen = Val(txtSaldoInicialResumen.Text)
   mSaldoFinalResumen = Val(txtSaldoFinalResumen.Text)
   
   mEgresos1 = 0
   mIngresos1 = 0
   For Each oL In Lista.ListItems
      mIngresos1 = mIngresos1 + Val(oL.ListSubItems(16))
      mEgresos1 = mEgresos1 + Val(oL.ListSubItems(17))
   Next
   
   mEgresos2 = 0
   mIngresos2 = 0
   For Each oL In ListaFueraExtracto.ListItems
      mIngresos2 = mIngresos2 + Val(oL.ListSubItems(16))
      mEgresos2 = mEgresos2 + Val(oL.ListSubItems(17))
   Next
   
   mEgresos3 = 0
   mIngresos3 = 0
   mEgresos4 = 0
   mIngresos4 = 0
   For Each oL In ListaNoContable.ListItems
      mProcesar = True
      If IsDate(oL.ListSubItems(4)) Then
         If CDate(oL.ListSubItems(4)) <= DTFields(2).Value Then
            mProcesar = False
         End If
      End If
      If mProcesar Then
         mIngresos3 = mIngresos3 + Val(oL.ListSubItems(6))
         mEgresos3 = mEgresos3 + Val(oL.ListSubItems(7))
      End If
      mProcesar = False
      If IsDate(oL.ListSubItems(3)) Then
         If Year(CDate(oL.ListSubItems(3))) = Year(DTFields(2).Value) And Month(CDate(oL.ListSubItems(3))) = Month(DTFields(2).Value) Then
            mProcesar = True
         End If
      End If
      If mProcesar Then
         mIngresos4 = mIngresos4 + Val(oL.ListSubItems(6))
         mEgresos4 = mEgresos4 + Val(oL.ListSubItems(7))
      End If
   Next
   
   mDiferencia1 = mSaldoContable - (mIngresos2 - mEgresos2)
   mSaldoFinalCalculado = mDiferencia1 + mImporteAjuste + (mIngresos3 - mEgresos3)
   mDiferencia2 = mSaldoFinalCalculado - mSaldoFinalResumen
   mDiferencia3 = mSaldoInicialResumen + (mIngresos1 - mEgresos1) + (mIngresos4 - mEgresos4) + mImporteAjuste - mSaldoFinalResumen
   
   txtSaldoContable.Text = Format(mSaldoContable, "#,##0.00")
   txtSumatoriaMovimientos.Text = Format(mIngresos1 - mEgresos1, "#,##0.00")
   txtSumatoriaMovimientosFueraExtracto.Text = Format(mIngresos2 - mEgresos2, "#,##0.00")
   txtDiferencia1.Text = Format(mDiferencia1, "#,##0.00")
   txtSaldoFueraDeContabilidad.Text = Format(mIngresos3 - mEgresos3, "#,##0.00")
   txtSaldoFinalCalculado.Text = Format(mSaldoFinalCalculado, "#,##0.00")
   txtDiferencia2.Text = Format(mDiferencia2, "#,##0.00")
   txtDiferencia3.Text = Format(mDiferencia3, "#,##0.00")
   
   lblRegistros.Caption = Lista.ListItems.Count
   
End Sub

Public Function SaldoMayorContable() As Double

   Dim mSaldo As Double
   Dim mvarIdMoneda As Integer
   mSaldo = 0
   
   If IsNumeric(dcfields(2).BoundText) Then
      Dim oRs As ADOR.Recordset
      Dim mIdCuenta As Long
      Set oRs = Aplicacion.CuentasBancarias.TraerFiltrado("_PorIdConCuenta", dcfields(2).BoundText)
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         If Not IsNull(oRs.Fields("IdCuenta").Value) Then
            mIdCuenta = oRs.Fields("IdCuenta").Value
            mvarIdMoneda = oRs.Fields("IdMoneda").Value
            oRs.Close
            If mvarIdMoneda = mvarIdMonedaPesos Then
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_MayorPorIdCuentaEntreFechasSinCIE", _
                           Array(mIdCuenta, CDate("01/01/1900"), DTFields(2).Value))
            Else
               Set oRs = Aplicacion.Bancos.TraerFiltrado("_PosicionFinancieraAFechaPorIdCuentaBancaria", _
                           Array(dcfields(2).BoundText, DTFields(2).Value))
            End If
            If oRs.RecordCount > 0 Then
               mSaldo = IIf(IsNull(oRs.Fields("Saldo").Value), 0, oRs.Fields("Saldo").Value)
            End If
         End If
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
   SaldoMayorContable = mSaldo

End Function

Public Sub ImportarResumen()

   Dim oEx As Excel.Application
   Dim oRs As ADOR.Recordset
   Dim oRsErrores As ADOR.Recordset
   Dim oRsGrupos As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim oF As Form
   Dim mArchivo As String, mTipo As String, mConciliado As String, mError As String
   Dim fl As Integer, mContador As Integer, i As Integer
   Dim mNumero As Long, mIdValor As Long, mIdCuentaBancaria As Long, mIdDetalleConciliacion As Long
   Dim mImporte As Double, mSaldoInicial As Double, mSaldoFinal As Double
   Dim mFecha As Date, mFechaFinal As Date
   Dim mOk As Boolean, mConProblemas As Boolean, mEnResumenSinConciliar As Boolean

   On Error GoTo Mal

   Set oF = New frmPathPresto
   With oF
      .Id = 17
      .Show vbModal
      mOk = .Ok
      If mOk Then mArchivo = .FileBrowser1(0).Text
   End With
   Unload oF
   Set oF = Nothing

   If Not mOk Then Exit Sub

   Set oRsErrores = CreateObject("ADOR.Recordset")
   With oRsErrores
      .Fields.Append "Id", adInteger
      .Fields.Append "Detalle", adVarChar, 200
   End With
   oRsErrores.Open
   
   Set oRsGrupos = CreateObject("ADOR.Recordset")
   With oRsGrupos
      .Fields.Append "Id", adVarChar, 20
      .Fields.Append "Importe", adDouble
      .Fields.Item("Importe").Precision = 18
      .Fields.Item("Importe").NumericScale = 2
   End With
   oRsGrupos.Open
   
   Set oF = New frmAviso
   With oF
      .Label1 = "Abriendo planilla Excel ..."
      .Show
      .Refresh
      DoEvents
   End With

   oF.Label1 = oF.Label1 & vbCrLf & "Procesando registros ..."
   oF.Label2 = ""
   oF.Label3 = ""
   DoEvents

   fl = 13
   mFechaFinal = 0
   mSaldoInicial = 0
   mSaldoFinal = 0
   
   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      .WindowState = xlMinimized
      Me.Refresh
      
      With .Workbooks.Open(mArchivo)
         With .ActiveSheet
            If IsNumeric(.Cells(9, 2)) Then mSaldoInicial = .Cells(9, 2)
            Do While True
               If Len(Trim(.Cells(fl, 1))) = 0 Then Exit Do
               
               mConProblemas = False
               mContador = mContador + 1
               oF.Label2 = "Registro : " & .Cells(fl, 1) & " " & .Cells(fl, 3)
               oF.Label3 = "" & mContador
               DoEvents
               
               mTipo = .Cells(fl, 1)
               mFecha = 0
               If IsDate(.Cells(fl, 2)) Then mFecha = CDate(.Cells(fl, 2))
               If mFecha > mFechaFinal Then mFechaFinal = mFecha
               mNumero = 0
               If IsNumeric(.Cells(fl, 3)) Then mNumero = .Cells(fl, 3)
               mImporte = 0
               If IsNumeric(.Cells(fl, 5)) Then mImporte = .Cells(fl, 5)
               If IsNumeric(.Cells(fl, 6)) Then mSaldoFinal = .Cells(fl, 6)
               
               With oRsGrupos
                  If .RecordCount > 0 Then .MoveFirst
                  .Find "Id = '" & mTipo & "'"
                  If .EOF Then .AddNew
                  .Fields(0).Value = mTipo
                  .Fields(1).Value = IIf(IsNull(.Fields(1).Value), 0, .Fields(1).Value) + mImporte
                  .Update
               End With
               
               .Cells(fl, 1).Select
               If mId(mTipo, 1, 2) <> "CH" And mId(mTipo, 1, 8) <> "CLEARING" Then
                  oEx.Selection.Interior.ColorIndex = 34
                  GoTo Continuar
               End If
               
               Set oRsAux = Aplicacion.Valores.TraerFiltrado("_PorNumero", Array(mNumero, 6))
               If oRsAux.RecordCount = 0 Then
                  AgregarMensajeProcesoPresto oRsErrores, "El registro " & mTipo & " " & mNumero & " no existe."
                  mConProblemas = True
               Else
                  mIdValor = oRsAux.Fields("IdValor").Value
                  If IsNull(oRsAux.Fields("IdCuentaBancaria").Value) And IsNull(oRsAux.Fields("IdCuentaBancariaDeposito").Value) Then
                     AgregarMensajeProcesoPresto oRsErrores, "El registro " & mTipo & " " & mNumero & " no esta asignado a ninguna cuenta bancaria."
                     mConProblemas = True
                  Else
                     mIdCuentaBancaria = IIf(IsNull(oRsAux.Fields("IdCuentaBancaria").Value), oRsAux.Fields("IdCuentaBancariaDeposito").Value, oRsAux.Fields("IdCuentaBancaria").Value)
                     mConciliado = IIf(IsNull(oRsAux.Fields("Conciliado").Value), "", oRsAux.Fields("Conciliado").Value)
                  End If
               End If
               oRsAux.Close
   
               If Not mConProblemas Then
                  If mIdCuentaBancaria <> dcfields(2).BoundText Then
                     AgregarMensajeProcesoPresto oRsErrores, "El registro " & mTipo & " " & mNumero & "  no corresponde a la cuenta bancaria."
                     mConProblemas = True
                  End If
                  If mConciliado = "SI" Then
                     AgregarMensajeProcesoPresto oRsErrores, "El registro " & mTipo & " " & mNumero & " ya esta conciliado."
                     mConProblemas = True
                  End If
                  Set oRsAux = Aplicacion.TablasGenerales.TraerFiltrado("DetConciliaciones", "_ConfirmadoPorIdValor", mIdValor)
                  If oRsAux.RecordCount > 0 Then
                     If oRsAux.Fields("IdConciliacion").Value <> mvarId Then
                        AgregarMensajeProcesoPresto oRsErrores, "El registro " & mTipo & " " & mNumero & " ya esta en el resumen " & oRsAux.Fields("Numero").Value & vbCrLf
                        mConProblemas = True
                     End If
                  End If
                  oRsAux.Close
                  
                  mIdDetalleConciliacion = -1
                  mEnResumenSinConciliar = False
                  If origen.ValorExistenteEnResumen(mIdValor) Then
                     mIdDetalleConciliacion = origen.IdentificadorValorEnResumen(mIdValor)
                     If mIdDetalleConciliacion > 0 Then
                        With origen.DetConciliaciones.Item(mIdDetalleConciliacion)
                           With .Registro
                              If IIf(IsNull(.Fields("Conciliado").Value), "", .Fields("Conciliado").Value) <> "SI" Then
                                 mEnResumenSinConciliar = True
                              End If
                           End With
                        End With
                     End If
                     If Not mEnResumenSinConciliar Then
                        AgregarMensajeProcesoPresto oRsErrores, "El registro " & mTipo & " " & mNumero & " ya esta en este resumen."
                        mConProblemas = True
                     End If
                  End If
                  
                  If Not mConProblemas Then
                     With origen.DetConciliaciones.Item(mIdDetalleConciliacion)
                        .Registro.Fields("IdValor").Value = mIdValor
                        .Registro.Fields("Conciliado").Value = "SI"
                        .Modificado = True
                     End With
                     Set oRsAux = Aplicacion.TablasGenerales.TraerFiltrado("DetConciliaciones", "_PorIdValorConFormato", mIdValor)
                     If oRsAux.RecordCount > 0 Then Set Lista.RecordSource = oRsAux
                     Set oRsAux = Nothing
                  End If
               End If
               
               If Not mConProblemas Then
                  oEx.Selection.Interior.ColorIndex = 35
               Else
                  oEx.Selection.Interior.ColorIndex = 38
               End If
Continuar:
               fl = fl + 1
            Loop
            fl = fl + 2
            With oRsGrupos
               .MoveFirst
               Do While Not .EOF
                  oEx.Cells(fl, 1).Select
                  oEx.ActiveCell.FormulaR1C1 = .Fields(0).Value
                  oEx.Cells(fl, 2).Select
                  oEx.ActiveCell.FormulaR1C1 = .Fields(1).Value
                  fl = fl + 1
                  .MoveNext
               Loop
               .Close
            End With
         End With
         '.Close False
      End With
   End With
   
   Unload oF
   Set oF = Nothing

   Set ListaFueraExtracto.DataSource = origen.DetConciliaciones.RegistrosConFormatoNoConciliados
   ListaFueraExtracto.Refresh
   CalcularTotales
   
   With origen.Registro
      If mFechaFinal > 0 Then
         .Fields("FechaFinal").Value = mFechaFinal
         DTFields(2).Value = mFechaFinal
      End If
      .Fields("SaldoInicialResumen").Value = mSaldoInicial
      .Fields("SaldoFinalResumen").Value = mSaldoFinal
   End With

   If Not oRsErrores Is Nothing Then
      If oRsErrores.RecordCount > 0 Then
         Set oF = New frmConsulta1
         With oF
            Set .RecordsetFuente = oRsErrores
            .Id = 13
            .Show vbModal, Me
         End With
      Else
         MsgBox "Proceso completo", vbInformation
      End If
      Set oRsErrores = Nothing
   End If
   
Salida:
   On Error Resume Next
   
   Unload oF
   Set oF = Nothing

   Set oRs = Nothing
   Set oRsErrores = Nothing
   Set oRsGrupos = Nothing
   Set oRsAux = Nothing
   Set oEx = Nothing

   Exit Sub

Mal:
   MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   Resume Salida

End Sub
