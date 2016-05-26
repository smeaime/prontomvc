VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmCostosImportacion 
   Caption         =   "Costos de importacion"
   ClientHeight    =   8055
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   Icon            =   "frmCostosImportacion.frx":0000
   LinkTopic       =   "Form1"
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   8055
   ScaleWidth      =   11880
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtPosicion 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00%"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   330
      Left            =   4590
      Locked          =   -1  'True
      TabIndex        =   17
      Top             =   855
      Width           =   1335
   End
   Begin VB.TextBox txtPrecioTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      DataField       =   "PrecioTotal"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.0000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
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
      Left            =   6705
      Locked          =   -1  'True
      TabIndex        =   53
      Top             =   3195
      Width           =   930
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   870
      Left            =   7980
      TabIndex        =   59
      Top             =   900
      Width           =   3795
      _ExtentX        =   6694
      _ExtentY        =   1535
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmCostosImportacion.frx":076A
   End
   Begin VB.TextBox txtOtrosGastos1 
      Alignment       =   1  'Right Justify
      DataField       =   "OtrosGastos1"
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
      Height          =   330
      Left            =   10035
      TabIndex        =   15
      Top             =   2790
      Width           =   795
   End
   Begin VB.TextBox txtOtrosGastos2 
      Alignment       =   1  'Right Justify
      DataField       =   "OtrosGastos2"
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
      Height          =   330
      Left            =   10035
      TabIndex        =   16
      Top             =   3150
      Width           =   795
   End
   Begin VB.TextBox txtGastosEstadisticas 
      Alignment       =   1  'Right Justify
      DataField       =   "GastosEstadisticas"
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
      Height          =   330
      Left            =   10035
      TabIndex        =   14
      Top             =   2430
      Width           =   795
   End
   Begin VB.TextBox txtTotalGastos1 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.0000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   330
      Left            =   6705
      Locked          =   -1  'True
      TabIndex        =   48
      Top             =   2430
      Width           =   930
   End
   Begin VB.TextBox txtTotalGastos 
      Alignment       =   1  'Right Justify
      DataField       =   "TotalGastos"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.0000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   330
      Left            =   5580
      Locked          =   -1  'True
      TabIndex        =   46
      Top             =   2430
      Width           =   930
   End
   Begin VB.TextBox txtPorcTotalGastos 
      Alignment       =   1  'Right Justify
      DataField       =   "PorcTotalGastos"
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
      Height          =   330
      Left            =   4410
      Locked          =   -1  'True
      TabIndex        =   45
      Top             =   2430
      Width           =   930
   End
   Begin VB.TextBox TotalGastosDespacho1 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.0000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   330
      Left            =   6705
      Locked          =   -1  'True
      TabIndex        =   43
      Top             =   2790
      Width           =   930
   End
   Begin VB.TextBox txtTotalGastosDespacho 
      Alignment       =   1  'Right Justify
      DataField       =   "TotalGastosDespacho"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.0000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   330
      Left            =   5580
      Locked          =   -1  'True
      TabIndex        =   41
      Top             =   2790
      Width           =   930
   End
   Begin VB.TextBox txtPorcGastosDespacho 
      Alignment       =   1  'Right Justify
      DataField       =   "PorcGastosDespacho"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   330
      Left            =   4410
      TabIndex        =   12
      Top             =   2790
      Width           =   930
   End
   Begin VB.TextBox txtPrecioCF 
      Alignment       =   1  'Right Justify
      DataField       =   "PrecioCF"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.0000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   330
      Left            =   6705
      Locked          =   -1  'True
      TabIndex        =   40
      Top             =   2070
      Width           =   930
   End
   Begin VB.TextBox txtOtrosFletesDolares 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.0000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   330
      Left            =   5580
      Locked          =   -1  'True
      TabIndex        =   37
      Top             =   2070
      Width           =   930
   End
   Begin VB.TextBox txtConversion3 
      Alignment       =   1  'Right Justify
      DataField       =   "Conversion3"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.0000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   330
      Left            =   4410
      Locked          =   -1  'True
      TabIndex        =   36
      Top             =   2070
      Width           =   930
   End
   Begin VB.TextBox txtOtrosFletes 
      Alignment       =   1  'Right Justify
      DataField       =   "OtrosFletes"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   330
      Left            =   1665
      TabIndex        =   10
      Top             =   2070
      Width           =   930
   End
   Begin VB.TextBox txtFleteMaritimoDolares 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.0000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   330
      Left            =   5580
      Locked          =   -1  'True
      TabIndex        =   33
      Top             =   1710
      Width           =   930
   End
   Begin VB.TextBox txtConversion2 
      Alignment       =   1  'Right Justify
      DataField       =   "Conversion2"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.0000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   330
      Left            =   4410
      Locked          =   -1  'True
      TabIndex        =   32
      Top             =   1710
      Width           =   930
   End
   Begin VB.TextBox txtFleteMaritimo 
      Alignment       =   1  'Right Justify
      DataField       =   "FleteMaritimo"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   330
      Left            =   1665
      TabIndex        =   8
      Top             =   1710
      Width           =   930
   End
   Begin VB.TextBox txtPrecioFOBDolares 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.0000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   330
      Left            =   5580
      Locked          =   -1  'True
      TabIndex        =   29
      Top             =   1350
      Width           =   930
   End
   Begin VB.TextBox txtConversion1 
      Alignment       =   1  'Right Justify
      DataField       =   "Conversion1"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.0000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   330
      Left            =   4410
      Locked          =   -1  'True
      TabIndex        =   28
      Top             =   1350
      Width           =   930
   End
   Begin VB.TextBox txtPrecioFOB 
      Alignment       =   1  'Right Justify
      DataField       =   "PrecioFOB"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   330
      Left            =   1665
      TabIndex        =   6
      Top             =   1350
      Width           =   930
   End
   Begin VB.TextBox txtPosicionNCE 
      DataField       =   "PosicionNCE"
      Height          =   285
      Left            =   10170
      TabIndex        =   5
      Top             =   540
      Width           =   1605
   End
   Begin VB.TextBox txtDerechos 
      Alignment       =   1  'Right Justify
      DataField       =   "Derechos"
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
      Height          =   330
      Left            =   10035
      TabIndex        =   13
      Top             =   2070
      Width           =   795
   End
   Begin VB.TextBox txtCodigoArticulo 
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
      Height          =   330
      Left            =   1665
      TabIndex        =   0
      Top             =   135
      Width           =   1695
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   90
      TabIndex        =   18
      Top             =   7290
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   420
      Index           =   1
      Left            =   1665
      TabIndex        =   19
      Top             =   7290
      Width           =   1470
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   20
      Top             =   7770
      Width           =   11880
      _ExtentX        =   20955
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   5805
      Top             =   7200
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
            Picture         =   "frmCostosImportacion.frx":07EC
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCostosImportacion.frx":08FE
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCostosImportacion.frx":0D50
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCostosImportacion.frx":11A2
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaCostoImportacion"
      Height          =   285
      Index           =   0
      Left            =   7515
      TabIndex        =   4
      Top             =   540
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   503
      _Version        =   393216
      Format          =   67239937
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   0
      Left            =   3375
      TabIndex        =   1
      Tag             =   "Articulos"
      Top             =   135
      Width           =   6315
      _ExtentX        =   11139
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   1
      Left            =   1665
      TabIndex        =   2
      Tag             =   "Proveedores"
      Top             =   495
      Width           =   4245
      _ExtentX        =   7488
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdPosicionImportacion"
      Height          =   315
      Index           =   2
      Left            =   1665
      TabIndex        =   3
      Tag             =   "PosicionesImportacion"
      Top             =   855
      Width           =   2895
      _ExtentX        =   5106
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPosicionImportacion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda1"
      Height          =   315
      Index           =   3
      Left            =   2610
      TabIndex        =   7
      Tag             =   "Monedas"
      Top             =   1350
      Width           =   1770
      _ExtentX        =   3122
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda2"
      Height          =   315
      Index           =   4
      Left            =   2610
      TabIndex        =   9
      Tag             =   "Monedas"
      Top             =   1710
      Width           =   1770
      _ExtentX        =   3122
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda3"
      Height          =   315
      Index           =   5
      Left            =   2610
      TabIndex        =   11
      Tag             =   "Monedas"
      Top             =   2070
      Width           =   1770
      _ExtentX        =   3122
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   1950
      Left            =   45
      TabIndex        =   55
      Top             =   3600
      Width           =   11760
      _ExtentX        =   20743
      _ExtentY        =   3440
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmCostosImportacion.frx":15F4
      MultiSelect     =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaOC 
      Height          =   1320
      Left            =   45
      TabIndex        =   57
      Top             =   5895
      Width           =   11760
      _ExtentX        =   20743
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
      MouseIcon       =   "frmCostosImportacion.frx":1610
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Label lblEstado 
      Alignment       =   2  'Center
      BackColor       =   &H00C0E0FF&
      BorderStyle     =   1  'Fixed Single
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
      Left            =   9990
      TabIndex        =   60
      Top             =   135
      Width           =   1770
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Aplicacion del costo a ordenes de compra efectuadas : "
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
      Left            =   90
      TabIndex        =   58
      Top             =   5670
      Width           =   4770
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Costos desarrollados existentes : "
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
      Left            =   90
      TabIndex        =   56
      Top             =   3375
      Width           =   2865
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Importe total (importacion) :"
      Height          =   240
      Index           =   12
      Left            =   4410
      TabIndex        =   54
      Top             =   3240
      Width           =   2085
   End
   Begin VB.Line Line5 
      BorderWidth     =   2
      X1              =   6615
      X2              =   7650
      Y1              =   3150
      Y2              =   3150
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Observaciones :"
      Height          =   240
      Index           =   11
      Left            =   6705
      TabIndex        =   52
      Top             =   945
      Width           =   1200
   End
   Begin VB.Line Line4 
      X1              =   8010
      X2              =   8280
      Y1              =   3555
      Y2              =   3555
   End
   Begin VB.Line Line3 
      X1              =   8010
      X2              =   8280
      Y1              =   2025
      Y2              =   2025
   End
   Begin VB.Line Line2 
      X1              =   7695
      X2              =   8010
      Y1              =   2610
      Y2              =   2610
   End
   Begin VB.Line Line1 
      X1              =   8010
      X2              =   8010
      Y1              =   2025
      Y2              =   3555
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "% Otros gastos 1 :"
      Height          =   285
      Index           =   10
      Left            =   8280
      TabIndex        =   51
      Top             =   2835
      Width           =   1710
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "% Otros gastos 2 :"
      Height          =   285
      Index           =   8
      Left            =   8280
      TabIndex        =   50
      Top             =   3195
      Width           =   1710
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "% Gastos estadisticas :"
      Height          =   285
      Index           =   3
      Left            =   8280
      TabIndex        =   49
      Top             =   2475
      Width           =   1710
   End
   Begin VB.Label Label5 
      Caption         =   "=>"
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
      Left            =   5355
      TabIndex        =   47
      Top             =   2835
      Width           =   195
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Total gastos :"
      Height          =   240
      Index           =   15
      Left            =   2655
      TabIndex        =   44
      Top             =   2475
      Width           =   1695
   End
   Begin VB.Label Label4 
      Caption         =   "=>"
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
      Left            =   5355
      TabIndex        =   42
      Top             =   2475
      Width           =   195
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Otros gastos :"
      Height          =   240
      Index           =   14
      Left            =   2655
      TabIndex        =   39
      Top             =   2835
      Width           =   1695
   End
   Begin VB.Label Label3 
      Caption         =   "=>"
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
      Left            =   5355
      TabIndex        =   38
      Top             =   2115
      Width           =   195
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Otros Fletes :"
      Height          =   240
      Index           =   13
      Left            =   90
      TabIndex        =   35
      Top             =   2115
      Width           =   1515
   End
   Begin VB.Label Label2 
      Caption         =   "=>"
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
      Left            =   5355
      TabIndex        =   34
      Top             =   1755
      Width           =   195
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fletes maritimos :"
      Height          =   240
      Index           =   9
      Left            =   90
      TabIndex        =   31
      Top             =   1755
      Width           =   1515
   End
   Begin VB.Label Label1 
      Caption         =   "=>"
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
      Left            =   5355
      TabIndex        =   30
      Top             =   1395
      Width           =   195
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Precio compra :"
      Height          =   240
      Index           =   1
      Left            =   90
      TabIndex        =   27
      Top             =   1395
      Width           =   1515
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Posicion arancelaria :"
      Height          =   240
      Index           =   0
      Left            =   90
      TabIndex        =   26
      Top             =   900
      Width           =   1515
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Posicion NCE :"
      Height          =   240
      Index           =   7
      Left            =   9000
      TabIndex        =   25
      Top             =   585
      Width           =   1110
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "% Derechos :"
      Height          =   285
      Index           =   6
      Left            =   8280
      TabIndex        =   24
      Top             =   2115
      Width           =   1710
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Proveedor :"
      Height          =   240
      Index           =   5
      Left            =   90
      TabIndex        =   23
      Top             =   540
      Width           =   1515
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   6705
      TabIndex        =   22
      Top             =   585
      Width           =   660
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Producto :"
      Height          =   240
      Index           =   2
      Left            =   90
      TabIndex        =   21
      Top             =   180
      Width           =   1515
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
End
Attribute VB_Name = "frmCostosImportacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.CostoImportacion
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long
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

   Dim oF As frmAsignacionesCostos
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset

   Set oF = New frmAsignacionesCostos

   With oF
      .IdCostoImportacion = Lista.SelectedItem.Tag
      .IdArticulo = dcfields(0).BoundText
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         Set oRs = Aplicacion.Pedidos.TraerFiltrado("_PorIdDetallePedido", Array(oF.DataCombo1(0).BoundText, Lista.SelectedItem.Tag))
         If Cual = -1 Then
            Set oL = ListaOC.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaOC.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = "" & Now
            If oRs.RecordCount > 0 Then
               .SubItems(1) = "" & oRs.Fields("NumeroPedido").Value
               .SubItems(2) = "" & oRs.Fields("FechaPedido").Value
               .SubItems(3) = "" & oRs.Fields("Proveedor").Value
               .SubItems(4) = "" & oRs.Fields("Cantidad").Value
               .SubItems(5) = "" & oRs.Fields("Costo").Value
            End If
            oRs.Close
         End With
      End If
   End With

   Unload oF

   Set oF = Nothing
   Set oRs = Nothing
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
      
         With origen.Registro
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
            For Each dc In dcfields
               If Not IsNumeric(dc.BoundText) Then
                  If dc.Index < 4 Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
               Else
                  .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
            .Fields("Observaciones").Value = rchObservaciones.Text
         End With
         
         Me.MousePointer = vbHourglass
   
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
            
         With actL2
            .ListaEditada = "CostosImportacion"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
         Set Lista.DataSource = Aplicacion.CostosImportacion.TraerFiltrado("Cos", dcfields(0).BoundText)
         Lista.ListItems(Lista.ListItems.Count).EnsureVisible
         Lista.ListItems(Lista.ListItems.Count).Selected = True
         Lista.Refresh
         
         Me.MousePointer = vbDefault
         
         cmd(0).Enabled = False
         
         Exit Sub

      Case 1
      
         Unload Me
         
   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   Dim dtp As DTPicker
   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oAp.CostosImportacion.Item(vnewvalue)
   Set oBind = New BindingCollection
   
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
            If Len(oControl.Tag) Then
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
   
   If mvarId = -1 Then
      For Each dtp In DTFields
         dtp.Value = Date
      Next
      lblEstado.Caption = "NUEVO"
   Else
      With origen.Registro
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
      lblEstado.Caption = "MODIFICACION"
      cmd(0).Enabled = False
   End If
   
   Set oAp = Nothing

End Property

Private Sub dcfields_Change(Index As Integer)
      
   If Not IsNumeric(dcfields(Index).BoundText) Then Exit Sub
   
   Dim oRs As ADOR.Recordset
   Dim oAp As ComPronto.Aplicacion
   
   Set oAp = Aplicacion
   
   Select Case Index
      Case 0
         txtCodigoArticulo.Text = oAp.Articulos.Item(dcfields(0).BoundText).Registro.Fields("Codigo").Value
         Set Lista.DataSource = oAp.CostosImportacion.TraerFiltrado("Cos", dcfields(0).BoundText)
      Case 2
         If mvarId = -1 Then
            Set oRs = oAp.PosicionesImportacion.Item(dcfields(Index).BoundText).Registro
            With oRs
               If .RecordCount > 0 Then
                  txtPosicion.Text = .Fields("CodigoPosicion").Value
                  With origen.Registro
                     .Fields("Derechos").Value = oRs.Fields("Derechos").Value
                     .Fields("GastosEstadisticas").Value = oRs.Fields("GastosEstadisticas").Value
                     .Fields("OtrosGastos1").Value = oRs.Fields("OtrosGastos1").Value
                     .Fields("OtrosGastos2").Value = oRs.Fields("OtrosGastos2").Value
                  End With
               End If
            End With
            oRs.Close
         End If
      Case 3
         If mvarId = -1 Then
            origen.Registro.Fields("Conversion1").Value = Cotizacion(DTFields(0).Value, dcfields(Index).BoundText)
            CalcularCosto
         End If
      Case 4
         If mvarId = -1 Then
            origen.Registro.Fields("Conversion2").Value = Cotizacion(DTFields(0).Value, dcfields(Index).BoundText)
            CalcularCosto
         End If
      Case 5
         If mvarId = -1 Then
            origen.Registro.Fields("Conversion3").Value = Cotizacion(DTFields(0).Value, dcfields(Index).BoundText)
            CalcularCosto
         End If
   End Select
   
   Set oRs = Nothing
   Set oAp = Nothing

End Sub

Private Sub dcfields_GotFocus(Index As Integer)
   
   If Index = 0 Then
      If Len(Trim(txtCodigoArticulo.Text)) <> 0 And Len(Trim(dcfields(0).BoundText)) = 0 Then
         Dim oRs As ADOR.Recordset
         Me.MousePointer = vbHourglass
         Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo.Text)
         If oRs.RecordCount < 1 Then
            MsgBox "Articulo inexistente en archivo", vbCritical
            txtCodigoArticulo.SetFocus
         Else
            dcfields(0).BoundText = oRs.Fields(0).Value
         End If
         oRs.Close
         Set oRs = Nothing
         Me.MousePointer = vbDefault
      End If
   End If
   
   SendKeys "%{DOWN}"

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaOC
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   For Each oI In Img16.ListImages
      With Estado.Panels.Add(, , oI.Key)
         .Picture = oI.Picture
      End With
   Next

   CalcularCosto
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long
   Dim i As Integer
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then ' si el dato es texto
      
      s = Data.GetData(ccCFText) ' tomo el dato
      
      Filas = Split(s, vbCrLf) ' armo un vector por filas
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      If mvarId <> -1 Then
         MsgBox "Esta operacion es valida solo para costos nuevos", vbCritical
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 1), "impor") <> 0 Then
      
         Set oAp = Aplicacion
         
         Columnas = Split(Filas(1), vbTab) ' armo un vector con las columnas
         
         Set oRs = oAp.CostosImportacion.Item(Columnas(0)).Registro
         
         With origen.Registro
            .Fields("CodigoArticulo").Value = oRs.Fields("CodigoArticulo").Value
            .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
            .Fields("FechaCostoImportacion").Value = oRs.Fields("FechaCostoImportacion").Value
            .Fields("IdProveedor").Value = oRs.Fields("IdProveedor").Value
            .Fields("PosicionNCE").Value = oRs.Fields("PosicionNCE").Value
            .Fields("IdPosicionImportacion").Value = oRs.Fields("IdPosicionImportacion").Value
            .Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
            .Fields("PrecioFOB").Value = oRs.Fields("PrecioFOB").Value
            .Fields("IdMoneda1").Value = oRs.Fields("IdMoneda1").Value
            .Fields("FleteMaritimo").Value = oRs.Fields("FleteMaritimo").Value
            .Fields("IdMoneda2").Value = oRs.Fields("IdMoneda2").Value
            .Fields("OtrosFletes").Value = oRs.Fields("OtrosFletes").Value
            .Fields("IdMoneda3").Value = oRs.Fields("IdMoneda3").Value
         End With
         
         oRs.Close
         Set oRs = Nothing
         Set oAp = Nothing
         
         Clipboard.Clear
      
      Else

         MsgBox "Objeto invalido!"
         Exit Sub

      End If

   End If

End Sub

Private Sub Form_OLEDragOver(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

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
         Effect = vbDropEffectCopy
      End If
   End If

End Sub

Private Sub Form_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub Form_Paint()

   Degradado Me
   
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

Private Sub Lista_Click()

   If Not Lista.SelectedItem Is Nothing Then
      Set ListaOC.DataSource = Aplicacion.AsignacionesCostos.TraerFiltrado("_PorIdCosto", Lista.SelectedItem.Tag)
   Else
      ListaOC.ListItems.Clear
   End If
   
End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaOC_DblClick()

   If ListaOC.ListItems.Count = 0 Then
      Editar -1
   Else
      Editar ListaOC.SelectedItem.Tag
   End If

End Sub

Private Sub ListaOC_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaOC_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetA_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetA_Click 0
'   ElseIf KeyCode = vbKeySpace Then
'      MnuDetA_Click 1
   End If

End Sub

Private Sub ListaOC_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If ListaOC.ListItems.Count = 0 Then
         MnuDetA(2).Enabled = False
         PopupMenu MnuDet, , , , MnuDetA(0)
      Else
         MnuDetA(2).Enabled = True
         PopupMenu MnuDet, , , , MnuDetA(2)
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
'      Case 1
'         If ListaOC.SelectedItem.SmallIcon = "Eliminado" Then
'            MsgBox "El item ya ha sido eliminado, ingrese uno nuevo", vbCritical
'            Exit Sub
'         End If
'         Editar ListaOC.SelectedItem.Tag
      Case 2
         With ListaOC.SelectedItem
            Dim oAp As ComPronto.Aplicacion
            Dim oAsig As AsignacionCostos
            Set oAp = Aplicacion
            oAp.Tarea "Pedidos_BorrarAsignacionCosto", .Tag
            Set oAsig = oAp.AsignacionesCostos.Item(.Tag)
            oAsig.Eliminar
            Set oAsig = Nothing
            Set oAp = Nothing
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Public Sub CalcularCosto()

   txtPrecioFOBDolares.Text = Val(txtPrecioFOB.Text) * Val(txtConversion1.Text)
   txtFleteMaritimoDolares.Text = Val(txtFleteMaritimo.Text) * Val(txtConversion2.Text)
   txtOtrosFletesDolares.Text = Val(txtOtrosFletes.Text) * Val(txtConversion3.Text)
   
   With origen.Registro
      .Fields("PrecioCF").Value = Val(txtPrecioFOBDolares.Text) + Val(txtFleteMaritimoDolares.Text) + Val(txtOtrosFletesDolares.Text)
      .Fields("PorcTotalGastos").Value = Val(txtDerechos.Text) + Val(txtGastosEstadisticas.Text) + Val(txtOtrosGastos1.Text) + Val(txtOtrosGastos2.Text)
      .Fields("TotalGastos").Value = Round(Val(txtPrecioCF.Text) * Val(txtPorcTotalGastos.Text) / 100, 2)
      .Fields("PrecioTotal").Value = Val(txtPrecioCF.Text) + Val(txtTotalGastosDespacho.Text) + Val(txtTotalGastos.Text)
      .Fields("TotalGastosDespacho").Value = Round(Val(txtPrecioCF.Text) * Val(txtPorcGastosDespacho.Text) / 100, 2)
   End With
   
   TotalGastosDespacho1.Text = txtTotalGastosDespacho.Text
   txtTotalGastos1.Text = txtTotalGastos.Text

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

   If Len(Trim(txtCodigoArticulo.Text)) <> 0 Then
   
      Dim oRs As ADOR.Recordset
      
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo.Text)
   
      If oRs.RecordCount = 0 Then
         MsgBox "Articulo inexistente en archivo", vbCritical
         Cancel = True
      Else
         dcfields(0).BoundText = oRs.Fields(0).Value
      End If
      
      oRs.Close
      Set oRs = Nothing

   End If
   
End Sub

Private Sub txtDerechos_Change()

   CalcularCosto
   
End Sub

Private Sub txtDerechos_GotFocus()

   With txtDerechos
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDerechos_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtFleteMaritimo_Change()

   CalcularCosto
   
End Sub

Private Sub txtFleteMaritimo_GotFocus()

   With txtFleteMaritimo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtFleteMaritimo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtGastosEstadisticas_Change()

   CalcularCosto
   
End Sub

Private Sub txtGastosEstadisticas_GotFocus()

   With txtGastosEstadisticas
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtGastosEstadisticas_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtOtrosFletes_Change()

   CalcularCosto
   
End Sub

Private Sub txtOtrosFletes_GotFocus()

   With txtOtrosFletes
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtOtrosFletes_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtOtrosGastos1_Change()

   CalcularCosto
   
End Sub

Private Sub txtOtrosGastos1_GotFocus()

   With txtOtrosGastos1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtOtrosGastos1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtOtrosGastos2_Change()

    CalcularCosto
   
End Sub

Private Sub txtOtrosGastos2_GotFocus()

   With txtOtrosGastos2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtOtrosGastos2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPorcGastosDespacho_Change()

   CalcularCosto
   
End Sub

Private Sub txtPorcGastosDespacho_GotFocus()

   With txtPorcGastosDespacho
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcGastosDespacho_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPosicionNCE_GotFocus()

   With txtPosicionNCE
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPosicionNCE_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPrecioFOB_Change()

   CalcularCosto
   
End Sub

Private Sub txtPrecioFOB_GotFocus()

   With txtPrecioFOB
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPrecioFOB_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
