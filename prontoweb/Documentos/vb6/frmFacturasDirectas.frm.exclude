VERSION 5.00
Object = "{D9AF33E0-7C55-11D5-9151-0000E856BC17}#1.0#0"; "fiscal010724.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Object = "{B52C1CDE-38E9-11D5-98EC-00C0F01C6C81}#1.0#0"; "IFEpson.ocx"
Begin VB.Form frmFacturasDirectas 
   Caption         =   "Facturacion directa"
   ClientHeight    =   8415
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   Icon            =   "frmFacturasDirectas.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   8415
   ScaleWidth      =   11880
   StartUpPosition =   2  'CenterScreen
   Begin EPSON_Impresora_Fiscal.PrinterFiscal PrinterFiscal1 
      Left            =   5670
      Top             =   1800
      _ExtentX        =   847
      _ExtentY        =   847
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
      Index           =   0
      Left            =   6885
      Locked          =   -1  'True
      TabIndex        =   92
      Top             =   7245
      Width           =   1365
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
      Index           =   3
      Left            =   10440
      TabIndex        =   37
      Top             =   5535
      Width           =   1140
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   780
      Index           =   0
      Left            =   45
      TabIndex        =   36
      Top             =   7335
      Width           =   930
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   375
      Index           =   1
      Left            =   1530
      TabIndex        =   35
      Top             =   7740
      Width           =   930
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   375
      Index           =   0
      Left            =   1035
      Picture         =   "frmFacturasDirectas.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   34
      Top             =   7335
      UseMaskColor    =   -1  'True
      Width           =   435
   End
   Begin VB.TextBox txtTelefono 
      Enabled         =   0   'False
      Height          =   330
      Left            =   7830
      TabIndex        =   33
      Top             =   930
      Width           =   1980
   End
   Begin VB.TextBox txtFax 
      Enabled         =   0   'False
      Height          =   330
      Left            =   10395
      TabIndex        =   32
      Top             =   945
      Width           =   1440
   End
   Begin VB.TextBox txtEmail 
      Enabled         =   0   'False
      Height          =   330
      Left            =   7830
      TabIndex        =   31
      Top             =   1305
      Width           =   1980
   End
   Begin VB.TextBox txtNumeroFactura 
      Alignment       =   1  'Right Justify
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
      Left            =   2340
      TabIndex        =   30
      Top             =   180
      Width           =   1215
   End
   Begin VB.TextBox txtCuit 
      Enabled         =   0   'False
      Height          =   315
      Left            =   7830
      TabIndex        =   29
      Top             =   180
      Width           =   1440
   End
   Begin VB.TextBox txtDireccion 
      Enabled         =   0   'False
      Height          =   315
      Left            =   1485
      TabIndex        =   28
      Top             =   990
      Width           =   4095
   End
   Begin VB.TextBox txtLocalidad 
      Enabled         =   0   'False
      Height          =   315
      Left            =   2925
      TabIndex        =   27
      Top             =   1350
      Width           =   2655
   End
   Begin VB.TextBox txtProvincia 
      Enabled         =   0   'False
      Height          =   315
      Left            =   1485
      TabIndex        =   26
      Top             =   1710
      Width           =   4095
   End
   Begin VB.TextBox txtCodigoPostal 
      Enabled         =   0   'False
      Height          =   315
      Left            =   1485
      TabIndex        =   25
      Top             =   1350
      Width           =   1395
   End
   Begin VB.TextBox txtZona 
      Enabled         =   0   'False
      Height          =   330
      Left            =   10395
      TabIndex        =   24
      Top             =   1305
      Width           =   1440
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
      Height          =   240
      Index           =   4
      Left            =   10440
      TabIndex        =   23
      Top             =   6120
      Width           =   1140
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
      Height          =   240
      Index           =   5
      Left            =   10440
      TabIndex        =   22
      Top             =   6390
      Visible         =   0   'False
      Width           =   1140
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
      Height          =   240
      Index           =   6
      Left            =   10440
      TabIndex        =   21
      Top             =   6930
      Visible         =   0   'False
      Width           =   1140
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
      Height          =   240
      Index           =   7
      Left            =   10440
      TabIndex        =   20
      Top             =   7200
      Visible         =   0   'False
      Width           =   1140
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
      Index           =   8
      Left            =   10440
      TabIndex        =   19
      Top             =   7740
      Width           =   1140
   End
   Begin VB.TextBox txtCondicionIva 
      Enabled         =   0   'False
      Height          =   330
      Left            =   7830
      TabIndex        =   18
      Top             =   555
      Width           =   2970
   End
   Begin VB.TextBox txtCodigoCliente 
      Alignment       =   1  'Right Justify
      Height          =   315
      Left            =   1485
      TabIndex        =   17
      Top             =   630
      Width           =   795
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
      Left            =   10935
      TabIndex        =   16
      Top             =   495
      Width           =   900
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   375
      Index           =   1
      Left            =   1035
      Picture         =   "frmFacturasDirectas.frx":0DD4
      Style           =   1  'Graphical
      TabIndex        =   15
      Top             =   7740
      Width           =   435
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
      Height          =   240
      Index           =   9
      Left            =   10440
      TabIndex        =   14
      Top             =   5850
      Width           =   1140
   End
   Begin VB.TextBox txtPorcentajeBonificacion 
      Alignment       =   1  'Right Justify
      Height          =   240
      Left            =   9225
      TabIndex        =   13
      Top             =   5850
      Width           =   405
   End
   Begin VB.TextBox txtPorcentajeIva1 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   270
      Left            =   9225
      TabIndex        =   11
      Top             =   6120
      Width           =   405
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
      Left            =   4815
      TabIndex        =   9
      Top             =   2790
      Width           =   780
   End
   Begin VB.TextBox txtCotizacionMoneda 
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
      Left            =   3105
      TabIndex        =   8
      Top             =   2790
      Width           =   825
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   0
      Left            =   7830
      TabIndex        =   7
      Top             =   1755
      Width           =   195
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Anular"
      Enabled         =   0   'False
      Height          =   375
      Index           =   2
      Left            =   1530
      TabIndex        =   6
      Top             =   7335
      Width           =   930
   End
   Begin VB.TextBox txtNumeroCertificadoPercepcionIIBB 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCertificadoPercepcionIIBB"
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
      Height          =   300
      Left            =   9270
      TabIndex        =   5
      Top             =   2745
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.CommandButton cmdProvinciasDestino 
      Caption         =   "Distribuir IIBB x provincias"
      Height          =   960
      Left            =   10800
      TabIndex        =   4
      Top             =   2070
      Width           =   915
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   1
      Left            =   7830
      TabIndex        =   3
      Top             =   2115
      Width           =   195
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   2
      Left            =   7830
      TabIndex        =   2
      Top             =   2475
      Width           =   195
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
      Height          =   240
      Index           =   10
      Left            =   10440
      TabIndex        =   1
      Top             =   7470
      Visible         =   0   'False
      Width           =   1140
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
      Height          =   240
      Index           =   11
      Left            =   10440
      TabIndex        =   0
      Top             =   6660
      Width           =   1140
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   38
      Top             =   8130
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
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaFactura"
      Height          =   330
      Index           =   0
      Left            =   4350
      TabIndex        =   39
      Top             =   180
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   63832065
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCliente"
      Height          =   315
      Index           =   0
      Left            =   2340
      TabIndex        =   40
      Tag             =   "Clientes"
      Top             =   630
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCliente"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCondicionVenta"
      Height          =   315
      Index           =   1
      Left            =   1485
      TabIndex        =   41
      Tag             =   "CondicionesCompra"
      Top             =   2070
      Width           =   2355
      _ExtentX        =   4154
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCondicionCompra"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   555
      Left            =   2565
      TabIndex        =   42
      Top             =   7515
      Width           =   5730
      _ExtentX        =   10107
      _ExtentY        =   979
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmFacturasDirectas.frx":135E
   End
   Begin Controles1013.DbListView Lista 
      Height          =   2130
      Left            =   45
      TabIndex        =   43
      Top             =   3330
      Width           =   11805
      _ExtentX        =   20823
      _ExtentY        =   3757
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmFacturasDirectas.frx":13E0
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   5940
      Top             =   3150
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
            Picture         =   "frmFacturasDirectas.frx":13FC
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFacturasDirectas.frx":150E
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFacturasDirectas.frx":1960
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFacturasDirectas.frx":1DB2
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   3
      Left            =   945
      TabIndex        =   44
      Tag             =   "Monedas"
      Top             =   2790
      Width           =   1230
      _ExtentX        =   2170
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdIBCondicion"
      Height          =   315
      Index           =   4
      Left            =   8100
      TabIndex        =   45
      Tag             =   "IBCondiciones"
      Top             =   1710
      Width           =   3630
      _ExtentX        =   6403
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdIBCondicion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdPuntoVenta"
      Height          =   315
      Index           =   10
      Left            =   1485
      TabIndex        =   46
      Tag             =   "PuntosVenta"
      Top             =   180
      Width           =   825
      _ExtentX        =   1455
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPuntoVenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   2
      Left            =   1485
      TabIndex        =   47
      Tag             =   "Obras"
      Top             =   2430
      Width           =   4110
      _ExtentX        =   7250
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdIBCondicion2"
      Height          =   315
      Index           =   5
      Left            =   8100
      TabIndex        =   48
      Tag             =   "IBCondiciones"
      Top             =   2070
      Width           =   2640
      _ExtentX        =   4657
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdIBCondicion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdIBCondicion3"
      Height          =   315
      Index           =   6
      Left            =   8100
      TabIndex        =   49
      Tag             =   "IBCondiciones"
      Top             =   2430
      Width           =   2640
      _ExtentX        =   4657
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdIBCondicion"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaVencimiento"
      Height          =   330
      Index           =   1
      Left            =   4350
      TabIndex        =   50
      Top             =   2070
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   63832065
      CurrentDate     =   36377
   End
   Begin RichTextLib.RichTextBox rchObservacionesItem 
      Height          =   375
      Left            =   5760
      TabIndex        =   12
      Top             =   3150
      Visible         =   0   'False
      Width           =   150
      _ExtentX        =   265
      _ExtentY        =   661
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmFacturasDirectas.frx":2204
   End
   Begin VB.TextBox txtPorcentajeIva2 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   270
      Left            =   6525
      TabIndex        =   10
      Top             =   3150
      Visible         =   0   'False
      Width           =   405
   End
   Begin Controles1013.DbListView ListaVal 
      Height          =   1590
      Left            =   45
      TabIndex        =   89
      Top             =   5670
      Width           =   8250
      _ExtentX        =   14552
      _ExtentY        =   2805
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmFacturasDirectas.frx":228F
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin FiscalPrinterLibCtl.HASAR HASAR1 
      Left            =   5715
      OleObjectBlob   =   "frmFacturasDirectas.frx":22AB
      Top             =   1170
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
      Index           =   14
      Left            =   5220
      TabIndex        =   93
      Top             =   7245
      Width           =   1515
   End
   Begin VB.Label lblEstado 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "MODO CODIGO DE BARRA"
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
      Left            =   2520
      TabIndex        =   91
      Top             =   3150
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle cancelacion :"
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
      Left            =   90
      TabIndex        =   90
      Top             =   5490
      Width           =   1905
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000005&
      BorderWidth     =   3
      X1              =   8370
      X2              =   11565
      Y1              =   5490
      Y2              =   5490
   End
   Begin VB.Label lblLabels 
      Caption         =   "Telefono :"
      Height          =   330
      Index           =   0
      Left            =   6345
      TabIndex        =   88
      Top             =   930
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fax :"
      Height          =   285
      Index           =   3
      Left            =   9855
      TabIndex        =   87
      Top             =   945
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "Email :"
      Height          =   285
      Index           =   7
      Left            =   6345
      TabIndex        =   86
      Top             =   1305
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Factura :"
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
      Index           =   21
      Left            =   90
      TabIndex        =   85
      Top             =   180
      Width           =   1305
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   285
      Index           =   22
      Left            =   3645
      TabIndex        =   84
      Top             =   225
      Width           =   630
   End
   Begin VB.Label lblLabels 
      Caption         =   "C.U.I.T. :"
      Height          =   285
      Index           =   6
      Left            =   6345
      TabIndex        =   83
      Top             =   225
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cliente:"
      Height          =   285
      Index           =   2
      Left            =   90
      TabIndex        =   82
      Top             =   600
      Width           =   1305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Dirección :"
      Height          =   285
      Index           =   10
      Left            =   90
      TabIndex        =   81
      Top             =   975
      Width           =   1305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Localidad :"
      Height          =   285
      Index           =   11
      Left            =   90
      TabIndex        =   80
      Top             =   1350
      Width           =   1305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Provincia :"
      Height          =   285
      Index           =   12
      Left            =   90
      TabIndex        =   79
      Top             =   1710
      Width           =   1305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Zona :"
      Height          =   285
      Index           =   8
      Left            =   9855
      TabIndex        =   78
      Top             =   1305
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cond. de Venta :"
      Height          =   285
      Index           =   16
      Left            =   90
      TabIndex        =   77
      Top             =   2070
      Width           =   1305
   End
   Begin VB.Label Label1 
      Caption         =   "Subtotal :"
      Height          =   240
      Left            =   8370
      TabIndex        =   76
      Top             =   5580
      Width           =   1995
   End
   Begin VB.Label lblIVA1 
      Caption         =   "IVA"
      Height          =   195
      Left            =   8370
      TabIndex        =   75
      Top             =   6165
      Width           =   825
   End
   Begin VB.Label lblPercIBB 
      Caption         =   "Percepcion Ingresos Brutos :"
      Height          =   195
      Left            =   8370
      TabIndex        =   74
      Top             =   6435
      Visible         =   0   'False
      Width           =   1995
   End
   Begin VB.Label lblOtrasPercepciones2 
      Height          =   195
      Left            =   8370
      TabIndex        =   73
      Top             =   7245
      Visible         =   0   'False
      Width           =   1995
   End
   Begin VB.Label Label6 
      BackColor       =   &H00FFFFFF&
      Caption         =   "TOTAL FACTURA :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000010&
      Height          =   330
      Left            =   8370
      TabIndex        =   72
      Top             =   7740
      Width           =   1995
   End
   Begin VB.Line Line2 
      BorderColor     =   &H80000005&
      BorderWidth     =   3
      X1              =   10440
      X2              =   11580
      Y1              =   7695
      Y2              =   7695
   End
   Begin VB.Label lblLabels 
      Caption         =   "Condicion IVA :"
      Height          =   285
      Index           =   4
      Left            =   6345
      TabIndex        =   71
      Top             =   585
      Width           =   1395
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
      Index           =   17
      Left            =   2610
      TabIndex        =   70
      Top             =   7335
      Width           =   1395
   End
   Begin VB.Line Line3 
      BorderWidth     =   2
      X1              =   11880
      X2              =   10890
      Y1              =   855
      Y2              =   855
   End
   Begin VB.Label lblLabels 
      Alignment       =   2  'Center
      Caption         =   "Cotizacion u$s del dia"
      Height          =   420
      Index           =   23
      Left            =   10935
      TabIndex        =   69
      Top             =   45
      Width           =   915
   End
   Begin VB.Line Line4 
      BorderWidth     =   2
      X1              =   10890
      X2              =   10890
      Y1              =   0
      Y2              =   855
   End
   Begin VB.Label Label2 
      Caption         =   "Bonif. :"
      Height          =   195
      Left            =   8370
      TabIndex        =   68
      Top             =   5895
      Width           =   825
   End
   Begin VB.Label Label3 
      Caption         =   " % "
      Height          =   195
      Left            =   9675
      TabIndex        =   67
      Top             =   5895
      Width           =   690
   End
   Begin VB.Label Label7 
      Caption         =   " % "
      Height          =   195
      Left            =   9675
      TabIndex        =   66
      Top             =   6165
      Width           =   690
   End
   Begin VB.Label lblLabels 
      Caption         =   "Moneda :"
      Height          =   285
      Index           =   1
      Left            =   90
      TabIndex        =   65
      Top             =   2790
      Width           =   780
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cotiz.u$s :"
      Height          =   240
      Index           =   18
      Left            =   4005
      TabIndex        =   64
      Top             =   2835
      Width           =   765
   End
   Begin VB.Label lblLabels 
      Caption         =   "Conv. a $ :"
      Height          =   240
      Index           =   15
      Left            =   2250
      TabIndex        =   63
      Top             =   2835
      Width           =   795
   End
   Begin VB.Label lblOtrasPercepciones1 
      Height          =   195
      Left            =   8370
      TabIndex        =   62
      Top             =   6975
      Visible         =   0   'False
      Width           =   1995
   End
   Begin VB.Label lblData 
      Caption         =   "Categoria IIBB 1 :"
      Height          =   285
      Index           =   10
      Left            =   6390
      TabIndex        =   61
      Top             =   1710
      Width           =   1350
   End
   Begin VB.Label lblEstado1 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "Label1"
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
      Left            =   9360
      TabIndex        =   60
      Top             =   180
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Label lblLetra 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "A"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5715
      TabIndex        =   59
      Top             =   45
      Width           =   465
   End
   Begin VB.Line Line8 
      BorderWidth     =   2
      X1              =   5715
      X2              =   6165
      Y1              =   45
      Y2              =   45
   End
   Begin VB.Line Line7 
      BorderWidth     =   2
      X1              =   5715
      X2              =   6165
      Y1              =   405
      Y2              =   405
   End
   Begin VB.Line Line6 
      BorderWidth     =   2
      X1              =   6165
      X2              =   6165
      Y1              =   45
      Y2              =   405
   End
   Begin VB.Line Line5 
      BorderWidth     =   2
      X1              =   5715
      X2              =   5715
      Y1              =   45
      Y2              =   405
   End
   Begin VB.Label lblNumeroCertificadoPercepcionIIBB 
      Caption         =   "Numero de certificado percepcion IIBB :"
      Height          =   240
      Left            =   6390
      TabIndex        =   58
      Top             =   2790
      Visible         =   0   'False
      Width           =   2835
   End
   Begin VB.Label lblData 
      Caption         =   "Obra (opcional) :"
      Height          =   285
      Index           =   0
      Left            =   90
      TabIndex        =   57
      Top             =   2430
      Width           =   1305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle facturado :"
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
      Index           =   5
      Left            =   90
      TabIndex        =   56
      Top             =   3150
      Width           =   1635
   End
   Begin VB.Label lblData 
      Caption         =   "Categoria IIBB 2 :"
      Height          =   285
      Index           =   1
      Left            =   6390
      TabIndex        =   55
      Top             =   2070
      Width           =   1350
   End
   Begin VB.Label lblData 
      Caption         =   "Categoria IIBB 3 :"
      Height          =   285
      Index           =   2
      Left            =   6390
      TabIndex        =   54
      Top             =   2430
      Width           =   1350
   End
   Begin VB.Line Line9 
      BorderColor     =   &H00FFFFFF&
      Index           =   0
      X1              =   6300
      X2              =   6300
      Y1              =   1665
      Y2              =   3105
   End
   Begin VB.Line Line9 
      BorderColor     =   &H00FFFFFF&
      Index           =   2
      X1              =   11790
      X2              =   6300
      Y1              =   1665
      Y2              =   1665
   End
   Begin VB.Line Line9 
      BorderColor     =   &H00FFFFFF&
      Index           =   3
      X1              =   11790
      X2              =   6300
      Y1              =   3105
      Y2              =   3105
   End
   Begin VB.Label lblOtrasPercepciones3 
      Height          =   150
      Left            =   8370
      TabIndex        =   53
      Top             =   7515
      Visible         =   0   'False
      Width           =   1995
   End
   Begin VB.Label Label4 
      Caption         =   "Percepcion IVA : "
      Height          =   195
      Left            =   8370
      TabIndex        =   52
      Top             =   6705
      Width           =   1995
   End
   Begin VB.Label lblLabels 
      Caption         =   "Vto. :"
      Height          =   240
      Index           =   9
      Left            =   3915
      TabIndex        =   51
      Top             =   2115
      Width           =   375
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
   Begin VB.Menu MnuDetVal 
      Caption         =   "DetalleValores"
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
         Caption         =   "Agregar tarjeta"
         Index           =   2
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Modificar"
         Index           =   3
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Eliminar"
         Index           =   4
      End
   End
End
Attribute VB_Name = "frmFacturasDirectas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Factura
Attribute origen.VB_VarHelpID = -1
Dim WithEvents origen1 As ComPronto.Recibo
Attribute origen1.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mvarIdRecibo As Long
Private mvarIdCliente As Integer
Dim actL2 As ControlForm
Private cALetra As New clsNum2Let
Private mvarGrabado As Boolean, mvarNumeracionUnica As Boolean
Private mvarModoCodigoBarra As Boolean
'Variables de calculo de totales de factura
Private mvarIBrutosC As String, mvarIBrutosB As String, mvarMultilateral As String
Private mvarTipoABC As String, mvarAclaracionAlPie As String, mvarPercepcionIIBB As String
Private mvarOtrasPercepciones1 As String, mvarOtrasPercepciones1Desc As String
Private mvarOtrasPercepciones2 As String, mvarOtrasPercepciones2Desc As String
Private mvarOtrasPercepciones3 As String, mvarOtrasPercepciones3Desc As String
Private mvarAnulada As String, mvarConfirmarClausulaDolar As String
Private mvarEsAgenteRetencionIVA As String, mCadena As String, mFiscal As String
Private mvarPorc_IBrutos_Cap As Double, mvarTope_IBrutos_Cap As Double
Private mvarP_IVA1_Tomado As Double, mvarPorc_IBrutos_BsAs As Double
Private mvarTope_IBrutos_BsAs As Double, mvarIBrutos As Double
Private mvarIBrutos2 As Double, mvarIBrutos3 As Double, mvarPercepcionIVA As Double
Private mvarPorc_IBrutos_BsAsM As Double, mvarTope_IBrutos_BsAsM As Double
Private mvarPorcentajeIBrutos As Double, mvar_IBrutos_Cap As Double
Private mvarPorcentajeIBrutos2 As Double, mvarPorcentajeIBrutos3 As Double
Private mvar_IBrutos_BsAs As Double, mvar_IBrutos_BsAsM As Double, mvarP_IVA1 As Double
Private mvarP_IVA2 As Double, mvarIVA1 As Double, mvarIVA2 As Double, mvarDecimales As Double
Private mvarPorcentajeBonificacion As Double, mvarImporteBonificacion As Double
Private mvarNetoGravado As Double, mvarTotalFactura As Double, mvarRecargoMora As Double
Private mvarCotizacionDolar As Double, mvarSubTotal As Double, mvarCotizacion As Double
Private mvarParteDolares As Double, mvarPartePesos As Double, mvarTipoIVA As Integer
Private mvarIVANoDiscriminado As Double, mvarBaseMinimaParaPercepcionIVA As Double
Private mvarTotalValores As Double
Private mvarPorcentajeMaximoBonificacion As Single, mvarPorcentajePercepcionIVA As Single
Private mvarPuntoVenta As Integer, mvarIdMonedaPesos As Integer, mvarIdMonedaDolar As Integer
Private mvarIBCondicion As Integer
Const mvarPuntoVentaDefault As Integer = 1
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

'   If mvarId > 0 Then
'      MsgBox "No puede modificar una Factura ya registrada!", vbExclamation
'      Exit Sub
'   End If
   
   If mvarId > 0 And Cual < 0 Then
      MsgBox "No puede modificar una Factura ya registrada!", vbExclamation
      Exit Sub
   End If
   
   If Not IsNumeric(dcfields(0).BoundText) Then
      MsgBox "Debe ingresar el clientes antes de ingresar los items", vbExclamation
      Exit Sub
   End If
   
   Dim oF As frmDetFacturas
   Dim oL As ListItem
   
   Set oF = New frmDetFacturas
   
   With oF
      Set .Factura = origen
      .Id = Cual
      .Cotizacion = mvarCotizacion
      .TipoIVA = mvarTipoIVA
      .TipoABC = mvarTipoABC
      .AlicuotaIVA = mvarP_IVA1_Tomado
      .EsMuestra = "NO"
      .Show vbModal, Me
      If .Aceptado Then
         mvarP_IVA1_Tomado = IIf(.AlicuotaIVA < 0, 0, .AlicuotaIVA)
         txtPorcentajeIva1.Text = mvarP_IVA1_Tomado
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
            .Text = oF.txtCodigoArticulo.Text
            .SubItems(1) = "" & oF.DataCombo1(1).Text
            .SubItems(2) = "" & Format(Val(oF.txtCantidad.Text), "Fixed")
            .SubItems(3) = "" & oF.DataCombo1(0).Text
            .SubItems(4) = "" & Format(Val(oF.txtCosto.Text), "#,##0.00")
            .SubItems(5) = "" & Format(Val(oF.txtPrecioUnitario.Text), "#,##0.00")
            .SubItems(6) = "" & Format(Val(oF.txtBonificacion.Text) / 100, "Percent")
            .SubItems(7) = "" & Format(Val(oF.txtImporte.Text), "#,##0.00")
         End With
         If mvarId < 0 Then
            If .IdCondicionVenta <> 0 Then
               origen.Registro.Fields("IdCondicionVenta").Value = .IdCondicionVenta
            End If
            If .IdMoneda <> 0 Then
               origen.Registro.Fields("IdMoneda").Value = .IdMoneda
            End If
         End If
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing

   CalculaFactura

End Sub

Sub EditarVal(ByVal Cual As Long)

'   If mvarId > 0 Then
'      MsgBox "No puede modificar un recibo ya registrado!", vbCritical
'      Exit Sub
'   End If
   
   Dim oF As Form
   Dim oL As ListItem
   Dim oDet As DetReciboValores
   Dim mItem As String
   Dim mIdItem As Long
   
   mIdItem = Cual
   
   If Cual = -1 Then
      mItem = "Caja"
   ElseIf Cual = -2 Then
      mItem = "Valor"
      mIdItem = -1
   ElseIf Cual = -3 Then
      mItem = "Tarjeta"
      mIdItem = -1
   Else
      Set oDet = origen1.DetRecibosValores.Item(Cual)
      If Not IsNull(oDet.Registro.Fields("IdCaja").Value) Then
         mItem = "Caja"
      ElseIf Not IsNull(oDet.Registro.Fields("IdTarjetaCredito").Value) Then
         mItem = "Tarjeta"
      Else
         mItem = "Valor"
      End If
      Set oDet = Nothing
   End If
   
   If mItem = "Valor" Then
      Set oF = New frmDetRecibosValores
   ElseIf mItem = "Tarjeta" Then
      Set oF = New frmDetRecibosTarjetas
   Else
      Set oF = New frmDetRecibosCaja
   End If
   
   DoEvents
   
   With oF
      Set .Recibo = origen1
      .Id = mIdItem
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Or Cual = -2 Or Cual = -3 Then
            Set oL = ListaVal.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaVal.SelectedItem
         End If
         With oL
            If Cual = -1 Or Cual = -2 Or Cual = -3 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            If mItem = "Valor" Then
               .Text = oF.DataCombo1(0).Text
               .SubItems(1) = "" & oF.txtNumeroInterno.Text
               .SubItems(2) = "" & oF.txtNumeroValor.Text
               If oF.DTFields(0).Enabled Then
                  .SubItems(3) = "" & oF.DTFields(0).Value
               Else
                  .SubItems(3) = ""
               End If
               .SubItems(4) = "" & oF.DataCombo1(1).Text
            ElseIf mItem = "Caja" Then
               .Text = "Ca"
               .SubItems(4) = "" & oF.DataCombo1(1).Text
            ElseIf mItem = "Tarjeta" Then
               .Text = "Tj"
               .SubItems(2) = "" & oF.txtNumeroTarjetaCredito.Text
               .SubItems(3) = "" & oF.DTFields(0).Value
               .SubItems(4) = "" & oF.DataCombo1(1).Text
            End If
            If Val(oF.txtImporte.Text) = 0 Then
               .SubItems(5) = " "
            Else
               .SubItems(5) = "" & Format(oF.txtImporte.Text, "Fixed")
            End If
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
   CalculaFactura
   
End Sub

Private Sub Check1_Click(Index As Integer)

   If Check1(Index).Value = 0 Then
      With origen.Registro
         If Index = 0 Then
            .Fields("IdIBCondicion").Value = Null
         Else
            .Fields("IdIBCondicion" & Index + 1).Value = Null
         End If
      End With
      CalculaFactura
   End If
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         If DTFields(0).Value <= gblFechaUltimoCierre And _
               Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
            MsgBox "La fecha no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation
            Exit Sub
         End If

         Dim mIdObra As Integer, mIdProvinciaDestino As Integer
         Dim mIdIBCondicion As Integer, mIdIBCondicion2 As Integer, mIdIBCondicion3 As Integer
         If mvarId > 0 Then
            mIdProvinciaDestino = -1
            If Len(dcfields(2).Text) = 0 Or Not IsNumeric(dcfields(2).BoundText) Then
               mIdObra = -1
            Else
               mIdObra = dcfields(2).BoundText
            End If
            If Len(dcfields(4).Text) = 0 Or Not IsNumeric(dcfields(4).BoundText) Then
               mIdIBCondicion = -1
            Else
               mIdIBCondicion = dcfields(4).BoundText
            End If
            If Len(dcfields(5).Text) = 0 Or Not IsNumeric(dcfields(5).BoundText) Then
               mIdIBCondicion2 = -1
            Else
               mIdIBCondicion2 = dcfields(5).BoundText
            End If
            If Len(dcfields(6).Text) = 0 Or Not IsNumeric(dcfields(6).BoundText) Then
               mIdIBCondicion3 = -1
            Else
               mIdIBCondicion3 = dcfields(6).BoundText
            End If
            With origen.Registro
               .Fields("NoIncluirEnCubos").Value = Null
               Aplicacion.Tarea "Facturas_ActualizarCampos", _
                     Array(mvarId, mIdProvinciaDestino, mIdObra, _
                           rchObservaciones.Text, .Fields("Exportacion_FOB").Value, _
                           .Fields("Exportacion_PosicionAduana").Value, _
                           .Fields("Exportacion_Despacho").Value, _
                           .Fields("Exportacion_Guia").Value, _
                           IIf(IsNull(.Fields("Exportacion_IdPaisDestino").Value), _
                                 0, .Fields("Exportacion_IdPaisDestino").Value), _
                           .Fields("Exportacion_FechaEmbarque").Value, _
                           .Fields("Exportacion_FechaOficializacion").Value, _
                           mIdIBCondicion, mIdIBCondicion2, mIdIBCondicion3, _
                           .Fields("NoIncluirEnCubos").Value)
            End With
            With origen.DetFacturas.Registros
               If .Fields.Count > 0 Then
                  If .RecordCount > 0 Then
                     .MoveFirst
                     Do While Not .EOF
                        If Not .Fields("Eliminado").Value Then
                           Aplicacion.Tarea "Facturas_ActualizarCamposDetalle", _
                                 Array(.Fields(0).Value, .Fields("OrigenDescripcion").Value, .Fields("Observaciones").Value)
                        End If
                        .MoveNext
                     Loop
                  End If
               End If
            End With
            With origen.DetFacturasProvincias.Registros
               If .Fields.Count > 0 Then
                  If .RecordCount > 0 Then
                     .MoveFirst
                     Do While Not .EOF
                        If Not .Fields("Eliminado").Value Then
                           If .Fields(0).Value > 0 Then
                              Aplicacion.Tarea "DetFacturasProvincias_M", _
                                 Array(.Fields(0).Value, mvarId, _
                                       .Fields("IdProvinciaDestino").Value, _
                                       .Fields("Porcentaje").Value)
                           Else
                              Aplicacion.Tarea "DetFacturasProvincias_A", _
                                 Array(.Fields(0).Value, mvarId, _
                                       .Fields("IdProvinciaDestino").Value, _
                                       .Fields("Porcentaje").Value)
                           End If
                        Else
                           Aplicacion.Tarea "DetFacturasProvincias_E", .Fields(0).Value
                        End If
                        .MoveNext
                     Loop
                  End If
               End If
            End With
            Unload Me
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim mvarImprime As Integer, i As Integer, mPuntoVenta As Integer
         Dim mCondicionIva As Integer
         Dim mvarNumero As Long, mNum As Long, mIdConceptoRecuperoGastos As Long
         Dim mIdCtaCte As Long, mIdCtaCteNC As Long, mIdProveedor As Long
         Dim mIdCuenta As Long, mCodigo As Long, mIdCuentaIvaCompras As Long
         Dim mIdPuntoVenta As Long, mNumeroRecibo As Long, mIdImputacion As Long
         Dim mIdRecibo As Long
         Dim mImporteTotalPesos As Double, mImporteTotalDolar As Double
         Dim mvarFechaVencimiento As Date
         Dim mCuit As String
         Dim oRs As ADOR.Recordset
     
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar una Factura sin detalles"
            Exit Sub
         End If
         
         If origen.DetFacturas.Registros.RecordCount = 0 Then
            MsgBox "No determino ningun producto a facturar"
            Exit Sub
         End If
         
         If Len(txtCotizacionMoneda.Text) = 0 Then
            MsgBox "No ingreso la cotizacion", vbInformation
            Exit Sub
         End If
         
         If Val(txtCotizacionMoneda.Text) <= 0 Then
            MsgBox "La cotizacion debe ser mayor a cero", vbInformation
            Exit Sub
         End If
         
         If Len(txtCotizacionDolar.Text) = 0 Then
            MsgBox "No ingreso la cotizacion", vbInformation
            Exit Sub
         End If
         
         If Val(txtCotizacionDolar.Text) <= 0 Then
            MsgBox "La cotizacion debe ser mayor a cero", vbInformation
            Exit Sub
         End If
         
         If mvarIBrutos <> 0 And txtNumeroCertificadoPercepcionIIBB.Visible And _
               Len(txtNumeroCertificadoPercepcionIIBB.Text) = 0 Then
            MsgBox "Debe ingresar el numero de certificado de percepcion IIBB", vbInformation
            Exit Sub
         End If
         
         If mvarId < 0 And IsNumeric(dcfields(10).BoundText) And _
               Not BuscarClaveINI("Validar fecha de facturas nuevas") = "NO" Then
            Set oRs = Aplicacion.Facturas.TraerFiltrado("_UltimaPorIdPuntoVenta", dcfields(10).BoundText)
            If oRs.RecordCount > 0 Then
               If oRs.Fields("FechaFactura").Value > DTFields(0).Value Then
                  MsgBox "La fecha de la ultima factura es " & oRs.Fields("FechaFactura").Value & _
                           ", modifiquela", vbExclamation
                  oRs.Close
                  Set oRs = Nothing
                  Exit Sub
               End If
            End If
            oRs.Close
            Set oRs = Nothing
         End If
         
         With origen.Registro
            For Each dtp In DTFields
               If ExisteCampo(origen.Registro, dtp.DataField) Then
                  .Fields(dtp.DataField).Value = dtp.Value
               End If
            Next
            For Each dc In dcfields
               If ExisteCampo(origen.Registro, dc.DataField) Then
                  If Not IsNumeric(dc.BoundText) And dc.Enabled And _
                        Not (dc.Index = 4 And Check1(0).Value = 0) And _
                        Not (dc.Index = 5 And Check1(1).Value = 0) And _
                        Not (dc.Index = 6 And Check1(2).Value = 0) And _
                        Not dc.Index = 2 Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
                  If IsNumeric(dc.BoundText) Then
                     .Fields(dc.DataField).Value = dc.BoundText
                  End If
               End If
            Next
         End With
         
         Dim mvarCAI As String, mvarCAI_v As String
         Dim mvarFechaCAI As Date, mvarFechaCAI_v As String
         Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(10).BoundText)
         Select Case mvarTipoABC
            Case "A"
               mvarCAI_v = "NumeroCAI_F_A"
               mvarFechaCAI_v = "FechaCAI_F_A"
            Case "B"
               mvarCAI_v = "NumeroCAI_F_B"
               mvarFechaCAI_v = "FechaCAI_F_B"
            Case "E"
               mvarCAI_v = "NumeroCAI_F_E"
               mvarFechaCAI_v = "FechaCAI_F_E"
         End Select
         If Not IsNull(oRs.Fields(mvarCAI_v).Value) Then
            mvarCAI = oRs.Fields(mvarCAI_v).Value
         Else
            mvarCAI = ""
         End If
         If Not IsNull(oRs.Fields(mvarFechaCAI_v).Value) Then
            mvarFechaCAI = oRs.Fields(mvarFechaCAI_v).Value
         Else
            mvarFechaCAI = DateSerial(2000, 1, 1)
         End If
         oRs.Close
         Set oRs = Nothing
         If DTFields(0).Value > mvarFechaCAI Then
            MsgBox "El CAI vencio el " & mvarFechaCAI & ", no puede grabar el comprobante", vbExclamation
            Exit Sub
         End If
         
         If mvarTotalValores <> mvarTotalFactura Then
            MsgBox "El total facturado debe ser igual al total valores", vbExclamation
            Exit Sub
         End If
         
         Me.MousePointer = vbHourglass
      
         VerificarProvinciasDestino
         
         With origen.Registro
            .Fields("TipoABC").Value = mvarTipoABC
            .Fields("PuntoVenta").Value = Val(dcfields(10).Text)
            .Fields("ImporteTotal").Value = mvarTotalFactura
            .Fields("ImporteIva1").Value = mvarIVA1
            .Fields("ImporteIva2").Value = mvarIVA2
            .Fields("RetencionIBrutos1").Value = mvarIBrutos
            .Fields("PorcentajeIBrutos1").Value = mvarPorcentajeIBrutos
            .Fields("RetencionIBrutos2").Value = mvarIBrutos2
            .Fields("PorcentajeIBrutos2").Value = mvarPorcentajeIBrutos2
            .Fields("ConvenioMultilateral").Value = mvarMultilateral
            .Fields("RetencionIBrutos3").Value = mvarIBrutos3
            .Fields("PorcentajeIBrutos3").Value = mvarPorcentajeIBrutos3
            .Fields("ImporteParteEnDolares").Value = mvarParteDolares
            .Fields("ImporteParteEnPesos").Value = mvarPartePesos
            .Fields("PorcentajeIva1").Value = mvarP_IVA1_Tomado
            .Fields("PorcentajeIva2").Value = Val(txtPorcentajeIva2.Text)
            .Fields("PorcentajeBonificacion").Value = mvarPorcentajeBonificacion
            .Fields("ImporteBonificacion").Value = mvarImporteBonificacion
            .Fields("IVANoDiscriminado").Value = mvarIVANoDiscriminado
            .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text
            .Fields("CotizacionDolar").Value = txtCotizacionDolar.Text
            .Fields("OtrasPercepciones1").Value = Val(txtTotal(6).Text)
            .Fields("OtrasPercepciones1Desc").Value = mvarOtrasPercepciones1Desc
            .Fields("OtrasPercepciones2").Value = Val(txtTotal(7).Text)
            .Fields("OtrasPercepciones2Desc").Value = mvarOtrasPercepciones2Desc
            .Fields("OtrasPercepciones3").Value = Val(txtTotal(10).Text)
            .Fields("OtrasPercepciones3Desc").Value = mvarOtrasPercepciones3Desc
            .Fields("PercepcionIVA").Value = mvarPercepcionIVA
            .Fields("PorcentajePercepcionIVA").Value = mvarPorcentajePercepcionIVA
            .Fields("NumeroCAI").Value = mvarCAI
            .Fields("FechaVencimientoCAI").Value = mvarFechaCAI
            .Fields("IdCodigoIva").Value = mvarTipoIVA
            .Fields("NoIncluirEnCubos").Value = Null
            If mvarId < 0 Then
               .Fields("IdUsuarioIngreso").Value = glbIdUsuario
               .Fields("FechaIngreso").Value = Now
            End If
            .Fields("Observaciones").Value = rchObservaciones.Text
            .Fields("ActivarRecuperoGastos").Value = Null
            .Fields("ContabilizarAFechaVencimiento").Value = Null
            .Fields("FacturaContado").Value = "SI"
         End With
         
         If mvarId < 0 Then
            Dim oPto As ComPronto.PuntoVenta
            Set oPto = Aplicacion.PuntosVenta.Item(dcfields(10).BoundText)
            With oPto.Registro
               mvarNumero = .Fields("ProximoNumero").Value
               .Fields("ProximoNumero").Value = mvarNumero + 1
               origen.Registro.Fields("NumeroFactura").Value = mvarNumero
            End With
            oPto.Guardar
            Set oPto = Nothing
         
            If dcfields(4).Enabled And Check1(0).Value = 1 Then
               Dim oPrv As ComPronto.Provincia
               Set oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", origen.Registro.Fields("IdIBCondicion").Value)
               If oRs.RecordCount > 0 Then
                  If Not IsNull(oRs.Fields("IdProvincia").Value) Then
                     Set oPrv = Aplicacion.Provincias.Item(oRs.Fields("IdProvincia").Value)
                     With oPrv.Registro
                        mNum = IIf(IsNull(.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value), 1, .Fields("ProximoNumeroCertificadoPercepcionIIBB").Value)
                        origen.Registro.Fields("NumeroCertificadoPercepcionIIBB").Value = mNum
                        .Fields("ProximoNumeroCertificadoPercepcionIIBB").Value = mNum + 1
                     End With
                     oPrv.Guardar
                     Set oPrv = Nothing
                  End If
               End If
               oRs.Close
               Set oRs = Nothing
            End If
         End If
         
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
            mvarGrabado = True
         
            mIdPuntoVenta = 0
            Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorIdTipoComprobante", 2)
            If oRs.RecordCount > 0 Then mIdPuntoVenta = oRs.Fields(0).Value
            oRs.Close
            
            mPuntoVenta = 0
            mNumeroRecibo = 0
            Set oPto = Aplicacion.PuntosVenta.Item(mIdPuntoVenta)
            With oPto
               With .Registro
                  mNumeroRecibo = .Fields("ProximoNumero").Value
                  mPuntoVenta = .Fields("PuntoVenta").Value
                  .Fields("ProximoNumero").Value = mNumeroRecibo + 1
               End With
               .Guardar
            End With
            Set oPto = Nothing
            
            mIdImputacion = 0
            Set oRs = Aplicacion.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(mvarId, 1))
            If oRs.RecordCount > 0 Then
               mIdImputacion = oRs.Fields(0).Value
            End If
            oRs.Close
            
            With origen1
               With .Registro
                  .Fields("NumeroRecibo").Value = mNumeroRecibo
                  .Fields("FechaRecibo").Value = DTFields(0).Value
                  .Fields("IdPuntoVenta").Value = mIdPuntoVenta
                  .Fields("PuntoVenta").Value = mPuntoVenta
                  .Fields("Tipo").Value = "CC"
                  .Fields("IdCliente").Value = dcfields(0).BoundText
                  .Fields("Efectivo").Value = 0
                  .Fields("Documentos").Value = 0
                  .Fields("Otros1").Value = 0
                  .Fields("Otros2").Value = 0
                  .Fields("Otros3").Value = 0
                  .Fields("Otros4").Value = 0
                  .Fields("Otros5").Value = 0
                  .Fields("Deudores").Value = mvarTotalFactura
                  .Fields("RetencionIVA").Value = 0
                  .Fields("RetencionGanancias").Value = 0
                  .Fields("RetencionIBrutos").Value = 0
                  .Fields("GastosGenerales").Value = 0
                  .Fields("Cotizacion").Value = txtCotizacionDolar.Text
                  .Fields("IdMoneda").Value = dcfields(3).BoundText
                  .Fields("Dolarizada").Value = "NO"
                  .Fields("AsientoManual").Value = "NO"
                  .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text
                  .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                  .Fields("FechaIngreso").Value = Now
               End With
               With .DetRecibos.Item(-1)
                  .Registro.Fields("IdImputacion").Value = mIdImputacion
                  .Registro.Fields("Importe").Value = mvarTotalFactura
                  .Modificado = True
               End With
               Set oRs = origen1.RegistroContableForm
               Set oRs = Nothing
               .Guardar
               mIdRecibo = .Registro.Fields(0).Value
            End With
            Aplicacion.Tarea "Facturas_ActualizarIdReciboContado", Array(mvarId, mIdRecibo)
            origen.Registro.Fields("IdReciboContado").Value = mIdRecibo
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "FacturasTodas, FacturasAgrupadas, +SubFA2"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
         Set oRs = Nothing
         
         Me.MousePointer = vbDefault
   
         If Len(mFiscal) > 0 Then
            If mId(mFiscal, 1, 2) = "EP" Then
               ImpresionEnControladorE
            Else
               ImpresionEnControladorH
            End If
         Else
            mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de la Factura")
            If mvarImprime = vbYes Then cmdImpre_Click 0
         End If
      
         Unload Me
         GoTo Salida:

      Case 1
      
         Unload Me

      Case 2
   
         AnularFactura
         
   End Select
   
Salida:
   Set cALetra = Nothing
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oDet As ComPronto.DetFactura
   Dim oDetPrv As ComPronto.DetFacturaProvincias
   Dim oDetVal As ComPronto.DetReciboValores
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   Dim ListaVacia1 As Boolean, ListaVacia2 As Boolean
   
   mvarId = vnewvalue
   
   mCadena = ""
   mvarModoCodigoBarra = False
   ListaVacia1 = False
   ListaVacia2 = False
   
   Set oAp = Aplicacion
   Set origen = oAp.Facturas.Item(vnewvalue)
   
   mvarIdRecibo = IIf(IsNull(origen.Registro.Fields("IdReciboContado").Value), -1, origen.Registro.Fields("IdReciboContado").Value)
   Set origen1 = oAp.Recibos.Item(mvarIdRecibo)
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      mvarP_IVA1 = .Fields("Iva1").Value
      mvarP_IVA2 = .Fields("Iva2").Value
      mvarPorc_IBrutos_Cap = .Fields("Porc_IBrutos_Cap").Value
      mvarTope_IBrutos_Cap = .Fields("Tope_IBrutos_Cap").Value
      mvarPorc_IBrutos_BsAs = .Fields("Porc_IBrutos_BsAs").Value
      mvarTope_IBrutos_BsAs = .Fields("Tope_IBrutos_BsAs").Value
      mvarPorc_IBrutos_BsAsM = .Fields("Porc_IBrutos_BsAsM").Value
      mvarTope_IBrutos_BsAsM = .Fields("Tope_IBrutos_BsAsM").Value
      mvarDecimales = .Fields("Decimales").Value
      mvarAclaracionAlPie = .Fields("AclaracionAlPieDeFactura").Value
      mvarIdMonedaPesos = .Fields("IdMoneda").Value
      mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
      mvarPercepcionIIBB = IIf(IsNull(.Fields("PercepcionIIBB").Value), "NO", .Fields("PercepcionIIBB").Value)
      mvarOtrasPercepciones1 = IIf(IsNull(.Fields("OtrasPercepciones1").Value), "NO", .Fields("OtrasPercepciones1").Value)
      mvarOtrasPercepciones1Desc = IIf(IsNull(.Fields("OtrasPercepciones1Desc").Value), "", .Fields("OtrasPercepciones1Desc").Value)
      mvarOtrasPercepciones2 = IIf(IsNull(.Fields("OtrasPercepciones2").Value), "NO", .Fields("OtrasPercepciones2").Value)
      mvarOtrasPercepciones2Desc = IIf(IsNull(.Fields("OtrasPercepciones2Desc").Value), "", .Fields("OtrasPercepciones2Desc").Value)
      mvarOtrasPercepciones3 = IIf(IsNull(.Fields("OtrasPercepciones3").Value), "NO", .Fields("OtrasPercepciones3").Value)
      mvarOtrasPercepciones3Desc = IIf(IsNull(.Fields("OtrasPercepciones3Desc").Value), "", .Fields("OtrasPercepciones3Desc").Value)
      mvarConfirmarClausulaDolar = IIf(IsNull(.Fields("ConfirmarClausulaDolar").Value), "NO", .Fields("ConfirmarClausulaDolar").Value)
      mvarNumeracionUnica = False
      If .Fields("NumeracionUnica").Value = "SI" Then mvarNumeracionUnica = True
      gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)
   End With
   oRs.Close

   If mvarId = -1 Then
      origen.Registro.Fields(7).Value = 1
      mvarIdCliente = 0
   Else
      If Not IsNull(origen.Registro.Fields("IdCliente").Value) Then
         mvarIdCliente = origen.Registro.Fields("IdCliente").Value
      End If
   End If
   
   mvarAnulada = "NO"
   
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            If oControl.Name = "Lista" Then
               If vnewvalue < 0 Then
                  Set oControl.DataSource = origen.DetFacturas.TraerMascara
               Else
                  Set oRs = origen.DetFacturas.TraerTodos
                  If oRs.RecordCount <> 0 Then
                     Set oControl.DataSource = oRs
                     oRs.MoveFirst
                     Do While Not oRs.EOF
                        Set oDet = origen.DetFacturas.Item(oRs.Fields(0).Value)
                        oDet.Modificado = True
                        Set oDet = Nothing
                        oRs.MoveNext
                     Loop
                     ListaVacia1 = False
                  Else
                     Set oControl.DataSource = origen.DetFacturas.TraerMascara
                     ListaVacia1 = True
                  End If
               End If
            ElseIf oControl.Name = "ListaVal" Then
               If vnewvalue < 0 Then
                  Set oControl.DataSource = origen1.DetRecibosValores.TraerMascara
                  ListaVacia2 = True
               Else
                  Set oRs = origen1.DetRecibosValores.TraerTodos
                  If oRs.Fields.Count > 0 Then
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                     Else
                        Set oControl.DataSource = origen1.DetRecibosValores.TraerMascara
                        ListaVacia2 = True
                     End If
                     While Not oRs.EOF
                        Set oDetVal = origen1.DetRecibosValores.Item(oRs.Fields(0).Value)
                        oDetVal.Modificado = True
                        Set oDetVal = Nothing
                        oRs.MoveNext
                     Wend
                  End If
                  oRs.Close
               End If
            End If
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "PuntosVenta" Then
                  Set oControl.RowSource = oAp.PuntosVenta.TraerFiltrado("_PuntosVentaTodos")
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
         .Fields("IdMoneda").Value = mvarIdMonedaPesos
      End With
      Lista.ListItems.Clear
      mvarGrabado = False
      mvarP_IVA1_Tomado = -1
      txtPorcentajeIva1.Text = 0
      txtPorcentajeIva2.Text = mvarP_IVA2
      mvarCotizacion = Cotizacion(Date, glbIdMonedaDolar)
      txtCotizacionDolar.Text = mvarCotizacion
   Else
      With origen.Registro
         txtPorcentajeBonificacion.Text = .Fields("PorcentajeBonificacion").Value
         mvarP_IVA1_Tomado = .Fields("PorcentajeIva1").Value
         txtPorcentajeIva1.Text = mvarP_IVA1_Tomado
         txtPorcentajeIva2.Text = .Fields("PorcentajeIva2").Value
         mvarCotizacion = IIf(IsNull(.Fields("CotizacionDolar").Value), 0, .Fields("CotizacionDolar").Value)
         txtCotizacionDolar.Text = mvarCotizacion
         txtCotizacionMoneda.Text = IIf(IsNull(.Fields("CotizacionMoneda").Value), 0, .Fields("CotizacionMoneda").Value)
         If Not IsNull(.Fields("OtrasPercepciones1Desc").Value) And _
               Len(.Fields("OtrasPercepciones1Desc").Value) > 0 Then
            mvarOtrasPercepciones1Desc = .Fields("OtrasPercepciones1Desc").Value
         End If
         If Not IsNull(.Fields("OtrasPercepciones2Desc").Value) And _
               Len(.Fields("OtrasPercepciones2Desc").Value) > 0 Then
            mvarOtrasPercepciones2Desc = .Fields("OtrasPercepciones2Desc").Value
         End If
         If Not IsNull(.Fields("OtrasPercepciones3Desc").Value) And _
               Len(.Fields("OtrasPercepciones3Desc").Value) > 0 Then
            mvarOtrasPercepciones3Desc = .Fields("OtrasPercepciones3Desc").Value
         End If
         If Not IsNull(.Fields("Anulada").Value) And .Fields("Anulada").Value = "SI" Then
            With lblEstado1
               .Caption = "ANULADA"
               .Visible = True
            End With
            mvarAnulada = "SI"
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With

      Set oRs = origen.DetFacturasProvincias.TraerTodos
      If oRs.Fields.Count > 0 Then
         If oRs.RecordCount <> 0 Then
            oRs.MoveFirst
            Do While Not oRs.EOF
               Set oDetPrv = origen.DetFacturasProvincias.Item(oRs.Fields(0).Value)
               oDetPrv.Modificado = True
               Set oDetPrv = Nothing
               oRs.MoveNext
            Loop
         End If
      End If
      Set oRs = Nothing
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Or TypeOf oControl Is DTPicker Or _
               TypeOf oControl Is DataCombo Or TypeOf oControl Is TextBox Or _
               TypeOf oControl Is OptionButton Or TypeOf oControl Is CheckBox Then
            oControl.Enabled = False
         End If
      Next
      cmd(1).Enabled = True
      dcfields(2).Enabled = True
      dcfields(4).Enabled = True
      dcfields(5).Enabled = True
      dcfields(6).Enabled = True
      Check1(0).Enabled = True
      Check1(1).Enabled = True
      Check1(2).Enabled = True
      cmdImpre(0).Enabled = True
      cmdImpre(1).Enabled = True
      cmdProvinciasDestino.Enabled = True
      mvarGrabado = True
   End If
   
   If mvarPercepcionIIBB = "SI" Or _
         origen.Registro.Fields("RetencionIBrutos1").Value <> 0 Then
      lblPercIBB.Visible = True
      lblNumeroCertificadoPercepcionIIBB.Visible = True
      txtNumeroCertificadoPercepcionIIBB.Visible = True
      With txtTotal(5)
         .Text = origen.Registro.Fields("RetencionIBrutos1").Value
         .Visible = True
      End With
   End If
   
   If mvarOtrasPercepciones1 = "SI" Or _
         origen.Registro.Fields("OtrasPercepciones1").Value <> 0 Then
      With lblOtrasPercepciones1
         .Caption = mvarOtrasPercepciones1Desc & " :"
         .Visible = True
      End With
      With txtTotal(6)
         .Text = origen.Registro.Fields("OtrasPercepciones1").Value
         .Visible = True
      End With
   End If
   
   If mvarOtrasPercepciones2 = "SI" Or _
         origen.Registro.Fields("OtrasPercepciones2").Value <> 0 Then
      With lblOtrasPercepciones2
         .Caption = mvarOtrasPercepciones2Desc & " :"
         .Visible = True
      End With
      With txtTotal(7)
         .Text = origen.Registro.Fields("OtrasPercepciones2").Value
         .Visible = True
      End With
   End If
   
   If mvarOtrasPercepciones3 = "SI" Or _
         origen.Registro.Fields("OtrasPercepciones3").Value <> 0 Then
      With lblOtrasPercepciones3
         .Caption = mvarOtrasPercepciones3Desc & " :"
         .Visible = True
      End With
      With txtTotal(10)
         .Text = origen.Registro.Fields("OtrasPercepciones3").Value
         .Visible = True
      End With
   End If
   
   txtCotizacion.Text = mvarCotizacion
   
   If ListaVacia1 Then
      Lista.ListItems.Clear
   End If
   If ListaVacia2 Then
      ListaVal.ListItems.Clear
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing

   cmd(0).Enabled = False
   cmd(2).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      cmd(2).Enabled = True
   End If
   If mvarId > 0 Then
'      cmd(0).Enabled = False
   Else
      cmd(2).Enabled = False
   End If
   
   If mvarAnulada = "SI" Then
      cmd(0).Enabled = False
      cmd(2).Enabled = False
   Else
      If DTFields(0).Value <= gblFechaUltimoCierre And _
            Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
         cmd(0).Enabled = False
         cmd(2).Enabled = False
      End If
   End If

End Property

Private Sub cmdImpre_Click(Index As Integer)

   If Not mvarGrabado Then
      MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
      Exit Sub
   End If
   
   If Len(mFiscal) > 0 Then
      If mId(mFiscal, 1, 2) = "EP" Then
         ImpresionEnControladorE
      Else
         ImpresionEnControladorH
      End If
      Exit Sub
   End If
   
   Dim mPlantilla As String, mCampo As String, mAgrupar As String, mArgL1 As String
   Dim oRs As ADOR.Recordset
   
   mPlantilla = "N/A"
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   If oRs.RecordCount > 0 Then
      mCampo = "Plantilla_Factura_" & mvarTipoABC
      If Not IsNull(oRs.Fields(mCampo).Value) And _
            Len(oRs.Fields(mCampo).Value) > 0 Then
         mPlantilla = oRs.Fields(mCampo).Value
      End If
   End If
   oRs.Close
   Set oRs = Nothing
   
   If Not Len(Trim(Dir(glbPathPlantillas & "\" & mPlantilla))) <> 0 Then
      MsgBox "No existe la plantilla de impresion, definala en la tabla de parametros.", vbExclamation
      Exit Sub
   End If
   
   Dim mvarClausula As Boolean, mOk As Boolean
   mvarClausula = False
   mAgrupar = BuscarClaveINI("Agrupar items en factura")
   If mvarConfirmarClausulaDolar = "SI" Or Len(mAgrupar) <> 0 Then
      Dim of1 As frm_Aux
      Set of1 = New frm_Aux
      With of1
         .Caption = "Emision de factura"
         .Label1.Visible = False
         .Text1.Visible = False
         With .Frame1
            .Caption = "Emite clausula dolar ? : "
            .Top = of1.Label1.Top
            .Visible = True
         End With
         .Option1.Caption = "SI"
         .Option1.Value = True
         .Option2.Caption = "NO"
         If Len(mAgrupar) <> 0 Then
            With .Check1
               .Top = of1.Frame1.Top + of1.Frame1.Height + 100
               .Left = of1.Frame1.Left
               .Width = of1.Frame1.Width / 2
               .Caption = "Agrupar items"
               If mAgrupar = "SI" Then
                  .Value = 1
               Else
                  .Value = 0
               End If
               .Visible = True
            End With
         End If
         .Show vbModal, Me
         mOk = .Ok
         mvarClausula = .Option1.Value
         If Len(mAgrupar) <> 0 Then
            If .Check1.Value = 1 Then
               mAgrupar = "SI"
            Else
               mAgrupar = "NO"
            End If
         End If
      End With
      Unload of1
      Set of1 = Nothing
      Me.Refresh
      If Not mOk Then Exit Sub
   End If
   
   Dim mCopias As Integer
   Dim mPrinter As String, mPrinterAnt As String
   
   mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
   If Index = 0 Then
      Dim oF As frmImpresion
      Set oF = New frmImpresion
      With oF
         .txtCopias.Text = 1
         .Show vbModal, Me
      End With
      mOk = oF.Ok
      mCopias = Val(oF.txtCopias.Text)
      mPrinter = oF.Combo1.Text
      Unload oF
      Set oF = Nothing
      If Not mOk Then Exit Sub
      Me.Refresh
   Else
      mCopias = 1
   End If
   
   mArgL1 = BuscarClaveINI("Conceptos para detallar dominios en factura")
   
   Dim oW As Word.Application
      
   On Error GoTo Mal
   
   Set oW = CreateObject("Word.Application")
   
   With oW
      .Visible = True
      .Documents.Add (glbPathPlantillas & "\" & mPlantilla)
      If Len(mAgrupar) <> 0 Then
         .Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId, _
               varg3:=mvarClausula, varg4:=mPrinter, varg5:=mCopias, varg6:=mAgrupar & "|" & mArgL1
      Else
         .Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId, _
               varg3:=mvarClausula, varg4:=mPrinter, varg5:=mCopias
      End If
      If Index = 0 Then
         oW.Documents(1).Close False
         oW.Quit
      End If
   End With
   
   GoTo Salida
   
Mal:
   Me.MousePointer = vbDefault
   MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical

Salida:
   Set oW = Nothing
   Me.MousePointer = vbDefault
   
End Sub

Private Sub cmdProvinciasDestino_Click()

   Dim oF As frmDetFacturasProvincias
   
   VerificarProvinciasDestino
   
   Set oF = New frmDetFacturasProvincias
   With oF
      Set .Factura = origen
      .Show vbModal, Me
   End With
   Unload oF
   Set oF = Nothing

End Sub

Private Sub dcfields_Change(Index As Integer)
      
   If Len(dcfields(Index).BoundText) = 0 Or _
         Not IsNumeric(dcfields(Index).BoundText) Then
      Exit Sub
   End If
   
   Dim oRs As ADOR.Recordset
   
   origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
   
   Select Case Index
      Case 0
         MostrarDatos (0)
      Case 1
         If mvarId <= 0 Then
            Set oRs = Aplicacion.CondicionesCompra.TraerFiltrado("_PorId", dcfields(Index).BoundText)
            DTFields(1).Value = DTFields(0).Value
            If oRs.RecordCount > 0 Then
               DTFields(1).Value = DTFields(0).Value + IIf(IsNull(oRs.Fields("CantidadDias1").Value), 0, oRs.Fields("CantidadDias1").Value)
            End If
            oRs.Close
         End If
      Case 3
         If dcfields(Index).BoundText = 1 Then
            txtCotizacionMoneda.Text = 1
         Else
            Set oRs = Aplicacion.Cotizaciones.TraerFiltrado("_PorFechaMoneda", Array(DTFields(0).Value, dcfields(Index).BoundText))
            If oRs.RecordCount > 0 Then
               txtCotizacionMoneda.Text = oRs.Fields("CotizacionLibre").Value
               If dcfields(Index).BoundText = mvarIdMonedaDolar Then
                  txtCotizacionDolar = oRs.Fields("CotizacionLibre").Value
               End If
            Else
               MsgBox "No hay cotizacion, ingresela manualmente"
               txtCotizacionMoneda.Text = ""
            End If
            oRs.Close
         End If
      Case 4
         Check1(0).Value = 1
         CalculaFactura
      Case 5
         Check1(1).Value = 1
         CalculaFactura
      Case 6
         Check1(2).Value = 1
         CalculaFactura
      Case 10
         If mvarId <= 0 Then
            Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(Index).BoundText)
            If oRs.RecordCount > 0 Then
               origen.Registro.Fields("NumeroFactura").Value = oRs.Fields("ProximoNumero").Value
               txtNumeroFactura.Text = oRs.Fields("ProximoNumero").Value
            End If
            oRs.Close
         End If
   End Select
   
   Set oRs = Nothing
   
End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Activate()
   
   If mvarId <= 0 And mvarCotizacion = 0 Then
      Me.Refresh
      MsgBox "No hay cotizacion, ingresela primero", vbExclamation
      Unload Me
   End If
   
   If Not origen Is Nothing Then CalculaFactura
   
'   lblIVA1.Caption = "IVA " & Format(mvarP_IVA1, "##0.00") & " %"
'   lblIVA2.Caption = "IVA " & Format(mvarP_IVA2, "##0.00") & " %"
   
'   mvarPuntoVenta = mvarPuntoVentaDefault

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   If KeyAscii <> 13 And mvarModoCodigoBarra Then
      mCadena = mCadena & Chr(KeyAscii)
      KeyAscii = 0
   ElseIf KeyAscii = 13 And mvarModoCodigoBarra Then
      Dim oRs As ADOR.Recordset
      If Len(mCadena) > 0 And Len(mCadena) <= 20 Then
         Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", mCadena)
         If oRs.RecordCount > 0 Then
            With origen.DetFacturas.Item(-1)
               With .Registro
                  .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                  .Fields("Cantidad").Value = 1
                  .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                  .Fields("CodigoArticulo").Value = oRs.Fields("CodigoArticulo").Value
                  .Fields("OrigenDescripcion").Value = 1
                  .Fields("TipoCancelacion").Value = 1
                  .Fields("PrecioUnitario").Value = 0
                  .Fields("PrecioUnitarioTotal").Value = 0
                  .Fields("Bonificacion").Value = 0
                  .Fields("Costo").Value = oRs.Fields("CostoPPP").Value
               End With
               .Modificado = True
            End With
            Set Lista.DataSource = origen.DetFacturas.RegistrosConFormato
         End If
         oRs.Close
      End If
      Set oRs = Nothing
      mCadena = ""
   ElseIf KeyAscii = 27 And mvarModoCodigoBarra Then
      mvarModoCodigoBarra = False
      lblEstado.Visible = False
      DoEvents
      mCadena = ""
   End If

End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)

   'F12 para inicializar el modo ingreso por codigo de barras
   If KeyCode = 123 Then
      mvarModoCodigoBarra = True
      lblEstado.Visible = True
      DoEvents
   ElseIf KeyCode = 27 And mvarModoCodigoBarra Then
      mCadena = ""
      mvarModoCodigoBarra = False
      lblEstado.Visible = False
      DoEvents
   End If

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   Dim mPuerto As String
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   With ListaVal
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   For Each oI In Img16.ListImages
      With Estado.Panels.Add(, , oI.Key)
         .Picture = oI.Picture
      End With
   Next
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

   '08 Hasar
   'EP Epson
   mFiscal = BuscarClaveINI("Impresora fiscal")
   If Len(mFiscal) > 0 Then
      On Error GoTo Impresora_apag
      mPuerto = BuscarClaveINI("Puerto impresora fiscal")
      If mId(mFiscal, 1, 2) = "EP" Then
         
         
         
         
      Else
         If Len(mPuerto) > 0 Then
            HASAR1.Puerto = Val(mPuerto)
         Else
            HASAR1.Puerto = 1
         End If
         HASAR1.Modelo = Val(mFiscal)
         HASAR1.Comenzar
         HASAR1.PrecioBase = False
ProcesarH:
         HASAR1.TratarDeCancelarTodo
      End If
   End If
   
   Exit Sub
   
Impresora_apag:
   If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
      If mId(mFiscal, 1, 2) = "EP" Then
      
      Else
         Resume ProcesarH
      End If
   End If

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   If Len(mFiscal) > 0 Then
      If mId(mFiscal, 1, 2) = "EP" Then
      Else
         HASAR1.Finalizar
      End If
   End If

End Sub

Private Sub HASAR1_EventoImpresora(ByVal Flags As Long)

   Select Case Flags
       Case P_JOURNAL_PAPER_LOW, P_RECEIPT_PAPER_LOW:
           MsgBox "Falta papel", , "Impresora fiscal"
       Case P_OFFLINE:
           MsgBox "Impresor fuera de línea", , "Impresora fiscal"
       Case P_PRINTER_ERROR:
           MsgBox "Error mecánico de impresor", , "Impresora fiscal"
       Case Else:
           MsgBox "Otro bit de impresora", , "Impresora fiscal"
   End Select

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
'   ElseIf KeyCode = vbKeyReturn Then
'      MnuDetA_Click 1
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

Private Sub Lista_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long, idDet As Long
   Dim mvarImporte As Double, mvarPrecio As Double
   Dim mError As Boolean, mItemsNoTomados As Boolean
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then ' si el dato es texto
      
      s = Data.GetData(ccCFText) ' tomo el dato
      
      Filas = Split(s, vbCrLf) ' armo un vector por filas
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      If UBound(Filas) > 1 Then
         MsgBox "No puede arrastrar mas de un item", vbCritical
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 1), "Orden de compra") <> 0 Then
      
         Set oAp = Aplicacion
         
         mItemsNoTomados = False
         
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            
            Columnas = Split(Filas(iFilas), vbTab)
            
            Set oRsDet = oAp.OrdenesCompra.TraerFiltrado("_ItemsPendientesDeFacturarPorIdOrdenCompra", Columnas(2))
            
            If oRsDet.RecordCount = 0 Then
               MsgBox "Esta orden de compra no tiene items pendientes de facturar", vbExclamation
               oRsDet.Close
               GoTo Salida
            End If
            
            If Not IsNull(oRsDet.Fields("Anulada").Value) And _
                  oRsDet.Fields("Anulada").Value = "SI" Then
               MsgBox "Esta orden de compra ha sido anulada", vbExclamation
               oRsDet.Close
               GoTo Salida
            End If
            
            With origen.Registro
               .Fields("IdCliente").Value = oRsDet.Fields("IdCliente").Value
               .Fields("IdCondicionVenta").Value = oRsDet.Fields("IdCondicionVenta").Value
               .Fields("IdMoneda").Value = oRsDet.Fields("IdMoneda").Value
            End With
            
            Do While Not oRsDet.EOF
               mError = False
               If Lista.ListItems.Count <> 0 And mvarP_IVA1_Tomado <> oRsDet.Fields("AlicuotaIVA").Value Then
                  mError = True
                  mItemsNoTomados = True
               End If
               If Not mError Then
                  mvarP_IVA1_Tomado = IIf(IsNull(oRsDet.Fields("AlicuotaIVA").Value), 0, oRsDet.Fields("AlicuotaIVA").Value)
                  txtPorcentajeIva1.Text = mvarP_IVA1_Tomado
                  mvarPrecio = IIf(IsNull(oRsDet.Fields("Precio").Value), 0, oRsDet.Fields("Precio").Value)
                  If mvarTipoABC = "B" And mvarTipoIVA <> 8 And _
                        BuscarClaveINI("Ordenes de compra iva incluido") <> "SI" Then
                     mvarPrecio = mvarPrecio + Round(mvarPrecio * mvarP_IVA1_Tomado / 100, 2)
                  End If
                  With origen.DetFacturas.Item(-1)
                     .Registro.Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                     .Registro.Fields("CodigoArticulo").Value = oRsDet.Fields("CodigoArticulo").Value
                     .Registro.Fields("Cantidad").Value = oRsDet.Fields("CantidadPendienteDeFacturar").Value
                     .Registro.Fields("PrecioUnitario").Value = mvarPrecio
                     .Registro.Fields("PorcentajeCertificacion").Value = oRsDet.Fields("PorcentajePendienteDeFacturar").Value
                     .Registro.Fields("OrigenDescripcion").Value = oRsDet.Fields("OrigenDescripcion").Value
                     .Registro.Fields("TipoCancelacion").Value = oRsDet.Fields("TipoCancelacion").Value
                     .Registro.Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                     .Registro.Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
                     .Registro.Fields("PrecioUnitarioTotal").Value = mvarPrecio
                     .Registro.Fields("Bonificacion").Value = 0
                     .Registro.Fields("Costo").Value = oRsDet.Fields("CostoPPP").Value
                     .Modificado = True
                     idDet = .Id
                     With .DetFacturasOrdenesCompra.Item(-1)
                        .Registro.Fields("IdDetalleFactura").Value = idDet
                        .Registro.Fields("IdDetalleOrdenCompra").Value = oRsDet.Fields("IdDetalleOrdenCompra").Value
                        .Modificado = True
                     End With
                  End With
                  Set oL = Lista.ListItems.Add
                  oL.Tag = idDet
                  With oL
                     .SmallIcon = "Nuevo"
                     .Text = IIf(IsNull(oRsDet.Fields("CodigoArticulo").Value), "", oRsDet.Fields("CodigoArticulo").Value)
                     .SubItems(1) = "" & IIf(IsNull(oRsDet.Fields("Articulo").Value), "", oRsDet.Fields("Articulo").Value)
                     .SubItems(2) = "" & Format(oRsDet.Fields("CantidadPendienteDeFacturar").Value, "Fixed")
                     .SubItems(3) = "" & oRsDet.Fields("Unidad").Value
                     .SubItems(4) = "" & Format(oRsDet.Fields("CostoPPP").Value, "#,##0.00")
                     .SubItems(5) = "" & Format(mvarPrecio, "#,##0.00")
                     .SubItems(6) = "" & Format(0 / 100, "Percent")
                     .SubItems(7) = "" & Format(mvarPrecio * oRsDet.Fields("CantidadPendienteDeFacturar").Value, "#,##0.00")
                  End With
               End If
               oRsDet.MoveNext
            Loop
            
            Set oRsDet = Nothing
            
            MostrarDatos (0)
            CalculaFactura
            
         Next
         
         If mItemsNoTomados Then
            MsgBox "Hay uno o mas items no tomados por tener alicuotas de iva distintas", vbExclamation
         End If
         
         Clipboard.Clear
      
      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "Remito") <> 0 Then
      
         Set oAp = Aplicacion
         
         mItemsNoTomados = False
         
         Columnas = Split(Filas(1), vbTab)
         
         Set oRs = oAp.Remitos.TraerFiltrado("_PorId", Columnas(2))
         
         If IsNull(oRs.Fields("IdCliente").Value) Then
            MsgBox "El remito debe ser a un cliente", vbExclamation
            GoTo Salida
         End If
         
         If Not IsNull(oRs.Fields("Anulado").Value) And _
              oRs.Fields("Anulado").Value = "SI" Then
            MsgBox "El remito ha sido anulado", vbExclamation
            GoTo Salida
         End If
         
         With origen.Registro
            .Fields("IdCliente").Value = oRs.Fields("IdCliente").Value
            .Fields("IdCondicionVenta").Value = oRs.Fields("IdCondicionVenta").Value
'            .Fields("IdMoneda").Value = oRs.Fields("IdMoneda").Value
            .Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
         End With
         oRs.Close
         
         Set oRs = oAp.Remitos.TraerFiltrado("_DetallesPorIdRemito", Columnas(2))
         Do While Not oRs.EOF
            With origen.DetFacturas.Item(-1)
               If Not IsNull(oRs.Fields("IdMoneda").Value) Then
                  origen.Registro.Fields("IdMoneda").Value = oRs.Fields("IdMoneda").Value
               End If
               .Registro.Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
               .Registro.Fields("CodigoArticulo").Value = oRs.Fields("CodigoArticulo").Value
               .Registro.Fields("Cantidad").Value = oRs.Fields("Cantidad").Value
               .Registro.Fields("PrecioUnitario").Value = oRs.Fields("Precio").Value
               .Registro.Fields("PorcentajeCertificacion").Value = oRs.Fields("PorcentajeCertificacion").Value
               .Registro.Fields("OrigenDescripcion").Value = oRs.Fields("OrigenDescripcion").Value
               .Registro.Fields("TipoCancelacion").Value = oRs.Fields("TipoCancelacion").Value
               .Registro.Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
               .Registro.Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
               .Registro.Fields("PrecioUnitarioTotal").Value = oRs.Fields("Precio").Value
               .Registro.Fields("Bonificacion").Value = 0
               .Registro.Fields("Costo").Value = oRs.Fields("CostoPPP").Value
               .Modificado = True
               idDet = .Id
               mvarP_IVA1_Tomado = IIf(IsNull(oRs.Fields("AlicuotaIVA").Value), 0, oRs.Fields("AlicuotaIVA").Value)
               txtPorcentajeIva1.Text = IIf(IsNull(oRs.Fields("AlicuotaIVA").Value), 0, oRs.Fields("AlicuotaIVA").Value)
               With .DetFacturasOrdenesCompra.Item(-1)
                  .Registro.Fields("IdDetalleFactura").Value = idDet
                  .Registro.Fields("IdDetalleOrdenCompra").Value = oRs.Fields("IdDetalleOrdenCompra").Value
                  .Modificado = True
               End With
               With .DetFacturasRemitos.Item(-1)
                  .Registro.Fields("IdDetalleFactura").Value = idDet
                  .Registro.Fields("IdDetalleRemito").Value = oRs.Fields("IdDetalleRemito").Value
                  .Modificado = True
               End With
            End With
            Set oL = Lista.ListItems.Add
            oL.Tag = idDet
            With oL
               .SmallIcon = "Nuevo"
               .Text = IIf(IsNull(oRs.Fields("CodigoArticulo").Value), "", oRs.Fields("CodigoArticulo").Value)
               .SubItems(1) = "" & oRs.Fields("Articulo").Value
               .SubItems(2) = "" & Format(oRs.Fields("Cantidad").Value, "Fixed")
               .SubItems(3) = "" & oRs.Fields("Unidad").Value
               .SubItems(4) = "" & Format(oRs.Fields("CostoPPP").Value, "#,##0.00")
               .SubItems(5) = "" & Format(oRs.Fields("Precio").Value, "#,##0.00")
               .SubItems(6) = "" & Format(0 / 100, "Percent")
               .SubItems(7) = "" & Format(oRs.Fields("Cantidad").Value * oRs.Fields("Precio").Value, "#,##0.00")
            End With
            oRs.MoveNext
         Loop
         oRs.Close
         Set oRs = Nothing
         
         MostrarDatos (0)
         CalculaFactura
         
         Clipboard.Clear
      
      Else
         
         MsgBox "Objeto invalido!"
      
      End If

   End If
   
Salida:

   Set oRs = Nothing
   Set oRsDet = Nothing
   Set oAp = Nothing
            
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
         Effect = vbDropEffectCopy
      End If
   End If

End Sub

Private Sub Lista_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub ListaVal_DblClick()
   
   If IsNumeric(ListaVal.SelectedItem.Tag) Then
      If ListaVal.ListItems.Count = 0 Then
         EditarVal -1
      Else
         EditarVal ListaVal.SelectedItem.Tag
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

Private Sub ListaVal_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
   
   If Button = vbRightButton Then
      If ListaVal.ListItems.Count = 0 Then
         MnuDetB(4).Enabled = False
         PopupMenu MnuDetVal, , , , MnuDetB(0)
      Else
         MnuDetB(4).Enabled = True
         PopupMenu MnuDetVal, , , , MnuDetB(1)
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0 ' Agregar
         Editar -1
      Case 1
         Editar Lista.SelectedItem.Tag
      Case 2
         If mvarId > 0 Then
            MsgBox "No puede modificar una Factura ya registrada!", vbExclamation
            Exit Sub
         End If
'         MsgBox "No puede modificar en el esquema remito-factura!", vbExclamation
'         Exit Sub
         With Lista.SelectedItem
            origen.DetFacturas.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
            If origen.DetFacturas.CantidadRegistros = 0 Then
               mvarP_IVA1_Tomado = -1
            End If
         End With
         CalculaFactura
   End Select

End Sub

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Form_Unload(Cancel As Integer)

   Set cALetra = Nothing
   Set actL2 = Nothing
   Set origen = Nothing
   Set origen1 = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub MostrarDatos(Index As Integer)

   Dim mvarLocalidad As Integer, mvarZona As Integer, mvarVendedor As Integer
   Dim mvarTransportista As Integer, mvarProvincia As Integer, mvarTipoVentaC As Integer
   Dim mvarCondicionVenta As Integer, mvarIdIBCondicion As Integer
   Dim mvarIdIBCondicion2 As Integer, mvarIdIBCondicion3 As Integer
   Dim mSeguro As Integer
   Dim Cambio As Boolean
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   ' Cargo los datos del Cliente
   
   Me.MousePointer = vbHourglass
   
   If mvarIdCliente <> dcfields(0).BoundText Then
      Cambio = True
      mvarIdCliente = dcfields(0).BoundText
   Else
      Cambio = False
   End If
   
   Set oAp = Aplicacion
   Set oRs = oAp.Clientes.Item(dcfields(0).BoundText).Registro
   
   With oRs
      txtCodigoCliente.Text = IIf(IsNull(.Fields("Codigo").Value), "", .Fields("Codigo").Value)
      txtDireccion.Text = IIf(IsNull(.Fields("Direccion").Value), "", .Fields("Direccion").Value)
      txtCodigoPostal.Text = IIf(IsNull(.Fields("CodigoPostal").Value), "", .Fields("CodigoPostal").Value)
      txtCuit.Text = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
      txtTelefono.Text = IIf(IsNull(.Fields("Telefono").Value), "", .Fields("Telefono").Value)
      txtFax.Text = IIf(IsNull(.Fields("Fax").Value), "", .Fields("Fax").Value)
      txtEmail.Text = IIf(IsNull(.Fields("Email").Value), "", .Fields("Email").Value)
'      txtConsignatario.Text = IIf(IsNull(.Fields("Consignatario").Value), "", .Fields("Consignatario").Value)
      mvarLocalidad = IIf(IsNull(.Fields("IdLocalidad").Value), 0, .Fields("IdLocalidad").Value)
'      mvarZona = IIf(IsNull(oRs.Fields("IdZona").Value), 0, oRs.Fields("IdZona").Value)
      mvarZona = 0
      mvarProvincia = IIf(IsNull(.Fields("IdProvincia").Value), 0, .Fields("IdProvincia").Value)
'      mvarIBrutosC = .Fields("CodigoRetencionIBC").Value
'      mvarIBrutosB = .Fields("CodigoRetencionIBB").Value
'      mvarMultilateral = .Fields("EnConvenioMultilateral").Value
      mvarTipoIVA = IIf(IsNull(.Fields("IdCodigoIva").Value), 0, .Fields("IdCodigoIva").Value)
      mvarCondicionVenta = IIf(IsNull(.Fields("IdCondicionVenta").Value), 0, .Fields("IdCondicionVenta").Value)
      mvarIBCondicion = IIf(IsNull(.Fields("IBCondicion").Value), 1, .Fields("IBCondicion").Value)
      mvarIdIBCondicion = IIf(IsNull(.Fields("IdIBCondicionPorDefecto").Value), 0, .Fields("IdIBCondicionPorDefecto").Value)
      mvarIdIBCondicion2 = IIf(IsNull(.Fields("IdIBCondicionPorDefecto2").Value), 0, .Fields("IdIBCondicionPorDefecto2").Value)
      mvarIdIBCondicion3 = IIf(IsNull(.Fields("IdIBCondicionPorDefecto3").Value), 0, .Fields("IdIBCondicionPorDefecto3").Value)
      mvarEsAgenteRetencionIVA = IIf(IsNull(.Fields("EsAgenteRetencionIVA").Value), "NO", .Fields("EsAgenteRetencionIVA").Value)
      mvarPorcentajePercepcionIVA = IIf(IsNull(.Fields("PorcentajePercepcionIVA").Value), 0, .Fields("PorcentajePercepcionIVA").Value)
      mvarBaseMinimaParaPercepcionIVA = IIf(IsNull(.Fields("BaseMinimaParaPercepcionIVA").Value), 0, .Fields("BaseMinimaParaPercepcionIVA").Value)
   End With
   
   If Cambio Then
      mvarVendedor = IIf(IsNull(oRs.Fields("Vendedor1").Value), 0, oRs.Fields("Vendedor1").Value)
'      mvarTransportista = oRs.Fields("CodigoTransportista1").Value
'      mvarCondicionVenta = oRs.Fields("IdCondicionVenta").Value
   Else
      mvarVendedor = IIf(IsNull(origen.Registro.Fields("IdVendedor").Value), 0, origen.Registro.Fields("IdVendedor").Value)
      mvarTransportista = IIf(IsNull(origen.Registro.Fields("Idtransportista1").Value), 0, origen.Registro.Fields("Idtransportista1").Value)
   End If
   
   oRs.Close
   
   With origen.Registro
      If mvarId < 0 Then
         If Not IsNull(.Fields("IdCondicionVenta").Value) Then
            If .Fields("IdCondicionVenta").Value <> mvarCondicionVenta Then
               mSeguro = MsgBox("La condicion de venta del cliente es diferente a la actual," & vbCrLf & _
                                 "desea poner la del cliente?", vbYesNo, "Cambio de condicion de venta")
               If mSeguro = vbYes Then
                  .Fields("IdCondicionVenta").Value = mvarCondicionVenta
               End If
            End If
         Else
            .Fields("IdCondicionVenta").Value = mvarCondicionVenta
         End If
'         .Fields(dcfields(5).DataField).Value = mvarProvincia
         If mvarIBCondicion = 1 Or mvarIBCondicion = 4 Then
            dcfields(4).Enabled = False
            dcfields(5).Enabled = False
            dcfields(6).Enabled = False
            .Fields("IdIBCondicion").Value = Null
            .Fields("IdIBCondicion2").Value = Null
            .Fields("IdIBCondicion3").Value = Null
            With Check1(0)
               .Value = 0
               .Enabled = False
            End With
            With Check1(1)
               .Value = 0
               .Enabled = False
            End With
            With Check1(2)
               .Value = 0
               .Enabled = False
            End With
         Else
            dcfields(4).Enabled = True
            Check1(0).Enabled = True
            If IsNull(.Fields("IdIBCondicion").Value) Then
               .Fields("IdIBCondicion").Value = mvarIdIBCondicion
               If mvarIdIBCondicion <> 0 Then Check1(0).Value = 1
            End If
            dcfields(5).Enabled = True
            Check1(1).Enabled = True
            If IsNull(.Fields("IdIBCondicion2").Value) And mvarIdIBCondicion2 <> 0 Then
               .Fields("IdIBCondicion2").Value = mvarIdIBCondicion2
               If mvarIdIBCondicion2 <> 0 Then Check1(1).Value = 1
            End If
            dcfields(6).Enabled = True
            Check1(2).Enabled = True
            If IsNull(.Fields("IdIBCondicion3").Value) And mvarIdIBCondicion3 <> 0 Then
               .Fields("IdIBCondicion3").Value = mvarIdIBCondicion3
               If mvarIdIBCondicion3 <> 0 Then Check1(2).Value = 1
            End If
         End If
      End If
   End With

   oAp.TablasGenerales.Tabla = "Localidades"
   oAp.TablasGenerales.Id = mvarLocalidad
   Set oRs = oAp.TablasGenerales.Registro
   txtLocalidad.Text = IIf(IsNull(oRs.Fields("Nombre").Value), "", oRs.Fields("Nombre").Value)
   oRs.Close
   
   oAp.TablasGenerales.Tabla = "Provincias"
   oAp.TablasGenerales.Id = mvarProvincia
   Set oRs = oAp.TablasGenerales.Registro
   txtProvincia.Text = IIf(IsNull(oRs.Fields("Nombre").Value), "", oRs.Fields("Nombre").Value)
   oRs.Close
   
   oAp.TablasGenerales.Tabla = "DescripcionIva"
   oAp.TablasGenerales.Id = mvarTipoIVA
   Set oRs = oAp.TablasGenerales.Registro
   txtCondicionIva.Text = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
   oRs.Close
   
'   If Not IsNull(origen.Registro.Fields("IdPedido").Value) Then
'      Set oRs = oAp.Pedidos.Item(origen.Registro.Fields("IdPedido").Value).Registro
'      txtNumeroPedido.Text = "Nro. " & oRs.Fields("NumeroPedido").Value & " del " & oRs.Fields("FechaPedido").Value
'      oRs.Close
'   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   If mvarId > 0 Then
      txtNumeroFactura.Text = origen.Registro.Fields("NumeroFactura").Value
   End If
   
   Me.MousePointer = vbDefault
   
   CalculaFactura
   
End Sub

Private Sub MnuDetB_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarVal -1
      Case 1
         EditarVal -2
      Case 2
         EditarVal -3
      Case 3
         EditarVal ListaVal.SelectedItem.Tag
      Case 4
         With ListaVal.SelectedItem
            If mvarId > 0 Then
               If origen1.DetRecibosValores.Item(.Tag).Registro.Fields("IdTipoValor").Value = 6 Then
                  Dim oRs As ADOR.Recordset
                  Dim mError As String
                  mError = ""
                  Set oRs = Aplicacion.Valores.TraerFiltrado("_PorIdDetalleReciboValores", .Tag)
                  If oRs.RecordCount > 0 Then
                     If Not IsNull(oRs.Fields("Estado").Value) Then
                        mError = "No puede eliminar el valor porque fue "
                        If oRs.Fields("Estado").Value = "D" Then
                           mError = mError & "depositado"
                        ElseIf oRs.Fields("Estado").Value = "E" Then
                           mError = mError & "endosado"
                        Else
                           mError = mError & "utilizado"
                        End If
                     End If
                  End If
                  oRs.Close
                  Set oRs = Nothing
                  If Len(mError) > 0 Then
                     MsgBox mError, vbCritical
                     Exit Sub
                  End If
               End If
            End If
            origen1.DetRecibosValores.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         CalculaFactura
   End Select

End Sub

Private Sub txtCodigoCliente_Change()

   If Len(txtCodigoCliente.Text) > 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Clientes.TraerFiltrado("_PorCodigo", txtCodigoCliente.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdCliente").Value = oRs.Fields(0).Value
      Else
         origen.Registro.Fields("IdCliente").Value = Null
      End If
      oRs.Close
      Set oRs = Nothing
   End If

End Sub

Private Sub txtCodigoCliente_GotFocus()

   With txtCodigoCliente
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoCliente_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoCliente_Validate(Cancel As Boolean)

   If Len(txtCodigoCliente.Text) > 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Clientes.TraerFiltrado("_PorCodigo", txtCodigoCliente.Text)
      If oRs.RecordCount = 0 Then
         MsgBox "Cliente inexistente", vbExclamation
         Cancel = True
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
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

   If origen.Registro.Fields("IdMoneda").Value = mvarIdMonedaDolar Then
      txtCotizacionMoneda.Text = txtCotizacionDolar.Text
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

   If origen.Registro.Fields("IdMoneda").Value = mvarIdMonedaDolar Then
      txtCotizacionDolar.Text = txtCotizacionMoneda.Text
   End If

End Sub

Private Sub txtNumeroFactura_Change()
   
   If mvarId > 0 Then
      MostrarDatos (0)
   End If

End Sub

Private Sub txtNumeroFactura_Validate(Cancel As Boolean)
   
   If mvarId < 0 Then
   
      Dim oRs As ADOR.Recordset
      
      Me.MousePointer = vbHourglass
      
      Set oRs = Aplicacion.Facturas.TraerFiltrado("Cod", Val(txtNumeroFactura.Text))
   
      If oRs.RecordCount > 0 Then
         MsgBox "Factura ya ingresada el " & oRs.Fields("FechaFactura").Value & ". Reingrese.", vbCritical
         Cancel = True
      End If
      
      oRs.Close
      Set oRs = Nothing
      
      Me.MousePointer = vbDefault
      
   End If

End Sub

Private Sub txtPorcentajeBonificacion_Change()

   CalculaFactura
   
End Sub

Private Sub txtPorcentajeBonificacion_GotFocus()

   With txtPorcentajeBonificacion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcentajeBonificacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPorcentajeBonificacion_Validate(Cancel As Boolean)

'   If Val(txtPorcentajeBonificacion.Text) > mvarPorcentajeMaximoBonificacion Then
'      MsgBox "El porcentaje de bonificacion no puede superar el " & mvarPorcentajeMaximoBonificacion & " %", vbExclamation
'      Cancel = True
'   End If

End Sub

Private Sub CalculaFactura()

   Dim oRs As ADOR.Recordset
   Dim oL As ListItem
   Dim i As Integer, mIdProvinciaIIBB As Integer
   Dim mNumeroCertificadoPercepcionIIBB As Long
   Dim t0 As Double, t1 As Double, t2 As Double, t3 As Double, mParteDolar As Double
   Dim mPartePesos As Double, mBonificacion As Double, mKilos As Double
   Dim mPrecioUnitario As Double, mTopeIIBB As Double
   
   t0 = 0
   t1 = 0
   t2 = 0
   t3 = 0
   mvarSubTotal = 0
   mvarIBrutos = 0
   mvarIBrutos2 = 0
   mvarIBrutos3 = 0
   mvarPorcentajeIBrutos = 0
   mvarPorcentajeIBrutos2 = 0
   mvarPorcentajeIBrutos3 = 0
   mvar_IBrutos_Cap = 0
   mvar_IBrutos_BsAs = 0
   mvar_IBrutos_BsAsM = 0
   mvarMultilateral = "NO"
   mvarIVA1 = 0
   mvarIVA2 = 0
   mvarTotalFactura = 0
   mvarParteDolares = 0
   mvarPartePesos = 0
   mvarImporteBonificacion = 0
   mvarNetoGravado = 0
   mvarPorcentajeBonificacion = 0
   mvarIVANoDiscriminado = 0
   mIdProvinciaIIBB = 0
   mNumeroCertificadoPercepcionIIBB = 0
   mvarPercepcionIVA = 0
   mvarTotalValores = 0
   
   If IsNumeric(txtPorcentajeBonificacion.Text) Then
      mvarPorcentajeBonificacion = Val(txtPorcentajeBonificacion.Text)
   End If
   
   Set oRs = origen1.DetRecibosValores.TodosLosRegistros
   If oRs.State <> 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            mvarTotalValores = mvarTotalValores + IIf(IsNull(oRs.Fields("Importe").Value), 0, oRs.Fields("Importe").Value)
            oRs.MoveNext
         Loop
      End If
      oRs.Close
   End If
   Set oRs = Nothing
   
   For Each oL In Lista.ListItems
      With origen.DetFacturas.Item(oL.Tag)
         If Not .Eliminado Then
            mPrecioUnitario = 0
            If Not IsNull(.Registro.Fields("PrecioUnitario").Value) Then
               mPrecioUnitario = .Registro.Fields("PrecioUnitario").Value
            End If
            t0 = t0 + Val(oL.ListSubItems(2))
            t1 = t1 + Val(oL.ListSubItems(3))
            t2 = t2 + .Registro.Fields("Cantidad").Value
            t3 = t3 + Round(.Registro.Fields("Cantidad").Value * mPrecioUnitario * _
               (1 - IIf(IsNull(.Registro.Fields("Bonificacion").Value), 0, .Registro.Fields("Bonificacion").Value) / 100), 2)
            If Not IsNull(.Registro.Fields("ParteDolar").Value) Then
               mParteDolar = .Registro.Fields("ParteDolar").Value
            Else
               mParteDolar = 0
            End If
            If Not IsNull(.Registro.Fields("PartePesos").Value) Then
               mPartePesos = .Registro.Fields("PartePesos").Value
            Else
               mPartePesos = 0
            End If
            If Not IsNull(.Registro.Fields("Bonificacion").Value) Then
               mBonificacion = .Registro.Fields("Bonificacion").Value
            Else
               mBonificacion = 0
            End If
            mKilos = IIf(IsNull(.Registro.Fields("Cantidad").Value), 0, .Registro.Fields("Cantidad").Value)
            mvarParteDolares = mvarParteDolares + (mKilos * mParteDolar * (1 - mBonificacion / 100))
            mvarPartePesos = mvarPartePesos + (mKilos * mPartePesos * (1 - mBonificacion / 100))
         End If
      End With
   Next
   
   mvarSubTotal = t3
   
   If mvarId > 0 Then
      
      With origen.Registro
         mvarTipoABC = IIf(IsNull(.Fields("TipoABC").Value), "", .Fields("TipoABC").Value)
         mvarPuntoVenta = IIf(IsNull(.Fields("PuntoVenta").Value), mvarPuntoVentaDefault, .Fields("PuntoVenta").Value)
         mvarTotalFactura = .Fields("ImporteTotal").Value
         mvarIVA1 = IIf(IsNull(.Fields("ImporteIva1").Value), 0, .Fields("ImporteIva1").Value)
         mvarIVA2 = IIf(IsNull(.Fields("ImporteIva2").Value), 0, .Fields("ImporteIva2").Value)
         mvarIVANoDiscriminado = IIf(IsNull(.Fields("IVANoDiscriminado").Value), 0, .Fields("IVANoDiscriminado").Value)
         mvarIBrutos = IIf(IsNull(.Fields("RetencionIBrutos1").Value), 0, .Fields("RetencionIBrutos1").Value)
         mvarPorcentajeIBrutos = IIf(IsNull(.Fields("PorcentajeIBrutos1").Value), 0, .Fields("PorcentajeIBrutos1").Value)
         mvarIBrutos2 = IIf(IsNull(.Fields("RetencionIBrutos2").Value), 0, .Fields("RetencionIBrutos2").Value)
         mvarPorcentajeIBrutos2 = IIf(IsNull(.Fields("PorcentajeIBrutos2").Value), 0, .Fields("PorcentajeIBrutos2").Value)
         mvarMultilateral = IIf(IsNull(.Fields("ConvenioMultilateral").Value), 0, .Fields("ConvenioMultilateral").Value)
         mvarIBrutos3 = IIf(IsNull(.Fields("RetencionIBrutos3").Value), 0, .Fields("RetencionIBrutos3").Value)
         mvarPorcentajeIBrutos3 = IIf(IsNull(.Fields("PorcentajeIBrutos3").Value), 0, .Fields("PorcentajeIBrutos3").Value)
         mvarParteDolares = IIf(IsNull(.Fields("ImporteParteEnDolares").Value), 0, .Fields("ImporteParteEnDolares").Value)
         mvarPartePesos = IIf(IsNull(.Fields("ImporteParteEnPesos").Value), 0, .Fields("ImporteParteEnPesos").Value)
         mvarImporteBonificacion = IIf(IsNull(.Fields("ImporteBonificacion").Value), 0, .Fields("ImporteBonificacion").Value)
         mvarPorcentajeBonificacion = IIf(IsNull(.Fields("PorcentajeBonificacion").Value), 0, .Fields("PorcentajeBonificacion").Value)
         mvarPercepcionIVA = IIf(IsNull(.Fields("PercepcionIVA").Value), 0, .Fields("PercepcionIVA").Value)
      End With
   
   Else
   
      mvarImporteBonificacion = Round(mvarSubTotal * mvarPorcentajeBonificacion / 100, 2)
      mvarNetoGravado = mvarSubTotal - mvarImporteBonificacion
      
'      If mvarIBrutosC = "S" And mvarPorc_IBrutos_Cap <> 0 And mvarNetoGravado > mvarTope_IBrutos_Cap Then
'         mvar_IBrutos_Cap = Round(mvarPorc_IBrutos_Cap * mvarNetoGravado / 100, mvarDecimales)
'      End If
'
'      If mvarIBrutosB = "S" Then
'         If mvarMultilateral = "S" Then
'            If mvarPorc_IBrutos_BsAs <> 0 And mvarNetoGravado > mvarTope_IBrutos_BsAs Then
'               mvar_IBrutos_BsAs = Round(mvarPorc_IBrutos_BsAs * mvarNetoGravado / 100, mvarDecimales)
'            End If
'         Else
'            If mvarPorc_IBrutos_BsAsM <> 0 And mvarNetoGravado > mvarTope_IBrutos_BsAsM Then
'               mvar_IBrutos_BsAsM = Round(mvarPorc_IBrutos_BsAsM * mvarNetoGravado / 100, mvarDecimales)
'            End If
'         End If
'      End If
      
      origen.Registro.Fields("NumeroCertificadoPercepcionIIBB").Value = Null
      If dcfields(4).Enabled And Check1(0).Value = 1 Then
         Set oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(4).BoundText)
         If oRs.RecordCount > 0 Then
            mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
            mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
            If mvarNetoGravado > mTopeIIBB Then
               If mvarIBCondicion = 2 Then
                  mvarPorcentajeIBrutos = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                  mvarMultilateral = "SI"
               Else
                  mvarPorcentajeIBrutos = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
               End If
               mvarIBrutos = Round(mvarNetoGravado * mvarPorcentajeIBrutos / 100, 2)
            End If
         End If
         oRs.Close
         If mvarIBrutos <> 0 Then
            Set oRs = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaIIBB)
            If oRs.RecordCount > 0 Then
               mNumeroCertificadoPercepcionIIBB = _
                     IIf(IsNull(oRs.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value), 1, _
                         oRs.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value)
            End If
            oRs.Close
            origen.Registro.Fields("NumeroCertificadoPercepcionIIBB").Value = mNumeroCertificadoPercepcionIIBB
         End If
         Set oRs = Nothing
      End If
      
      If dcfields(5).Enabled And Check1(1).Value = 1 Then
         Set oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(5).BoundText)
         If oRs.RecordCount > 0 Then
            mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
            mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
            If mvarNetoGravado > mTopeIIBB Then
               If mvarIBCondicion = 2 Then
                  mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                  mvarMultilateral = "SI"
               Else
                  mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
               End If
               mvarIBrutos2 = Round(mvarNetoGravado * mvarPorcentajeIBrutos2 / 100, 2)
            End If
         End If
         oRs.Close
         Set oRs = Nothing
      End If
      
      If dcfields(6).Enabled And Check1(2).Value = 1 Then
         Set oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(6).BoundText)
         If oRs.RecordCount > 0 Then
            mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
            mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
            If mvarNetoGravado > mTopeIIBB Then
               If mvarIBCondicion = 2 Then
                  mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                  mvarMultilateral = "SI"
               Else
                  mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
               End If
               mvarIBrutos3 = Round(mvarNetoGravado * mvarPorcentajeIBrutos3 / 100, 2)
            End If
         End If
         oRs.Close
         Set oRs = Nothing
      End If
      
      Select Case mvarTipoIVA
         Case 1
            mvarIVA1 = Round(mvarNetoGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
            mvarPartePesos = mvarPartePesos + Round((mvarPartePesos + (mvarParteDolares * mvarCotizacion)) * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
            mvarTipoABC = "A"
         Case 2
            mvarIVA1 = Round(mvarNetoGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
            mvarIVA2 = Round(mvarNetoGravado * Val(txtPorcentajeIva2.Text) / 100, mvarDecimales)
            mvarPartePesos = mvarPartePesos + Round((mvarPartePesos + (mvarParteDolares * mvarCotizacion)) * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales) + _
                                              Round((mvarPartePesos + (mvarParteDolares * mvarCotizacion)) * Val(txtPorcentajeIva2.Text) / 100, mvarDecimales)
            mvarTipoABC = "A"
         Case 3
            mvarTipoABC = "E"
         Case 8
            mvarTipoABC = "B"
         Case 9
            mvarTipoABC = "A"
         Case Else
            mvarIVANoDiscriminado = Round(mvarNetoGravado - (mvarNetoGravado / (1 + (Val(txtPorcentajeIva1.Text) / 100))), mvarDecimales)
            mvarTipoABC = "B"
      End Select
   
      If mvarEsAgenteRetencionIVA = "NO" And _
            mvarNetoGravado >= mvarBaseMinimaParaPercepcionIVA Then
         mvarPercepcionIVA = Round(mvarNetoGravado * mvarPorcentajePercepcionIVA / 100, mvarDecimales)
      End If
      
      mvarPuntoVenta = 0
      If IsNumeric(dcfields(10).BoundText) Then
         mvarPuntoVenta = dcfields(10).BoundText
      End If
      If mvarNumeracionUnica And mvarTipoABC <> "E" Then
         Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, mvarTipoABC))
      Else
         Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, mvarTipoABC))
      End If
      If oRs.RecordCount = 1 Then
         oRs.MoveFirst
         mvarPuntoVenta = oRs.Fields(0).Value
         If mvarId <= 0 Then
            origen.Registro.Fields("NumeroFactura").Value = oRs.Fields("ProximoNumero").Value
            txtNumeroFactura.Text = oRs.Fields("ProximoNumero").Value
         End If
      End If
      Set dcfields(10).RowSource = oRs
      dcfields(10).BoundText = mvarPuntoVenta
      Set oRs = Nothing
      If Len(dcfields(10).Text) = 0 Then
         origen.Registro.Fields("NumeroFactura").Value = Null
         txtNumeroFactura.Text = ""
      End If
      
      mvarTotalFactura = mvarNetoGravado + mvarIVA1 + mvarIVA2 + mvarIBrutos + _
               mvarIBrutos2 + mvarIBrutos3 + mvarPercepcionIVA + _
               Val(txtTotal(6).Text) + Val(txtTotal(7).Text) + Val(txtTotal(10).Text)

   End If
   
   lblLetra.Caption = mvarTipoABC
   
   txtTotal(0).Text = Format(mvarTotalValores, "#,##0.00")
'   txtTotal(1).Text = Format(t1, "#,##0.00")
'   txtTotal(2).Text = Format(t2, "#,##0.00")
   txtTotal(3).Text = Format(mvarSubTotal, "#,##0.00")
   txtTotal(9).Text = Format(mvarImporteBonificacion, "#,##0.00")
   txtTotal(4).Text = Format(mvarIVA1, "#,##0.00")
   txtTotal(5).Text = Format(mvarIBrutos + mvarIBrutos2 + mvarIBrutos3, "#,##0.00")
   txtTotal(11).Text = Format(mvarPercepcionIVA, "#,##0.00")
   txtTotal(8).Text = Format(mvarTotalFactura, "#,##0.00")
   
End Sub

Private Sub txtPorcentajeIva1_Change()

   CalculaFactura
   
End Sub

Private Sub txtPorcentajeIva1_GotFocus()

   With txtPorcentajeIva1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcentajeIva1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPorcentajeIva2_Change()

   CalculaFactura
   
End Sub

Private Sub txtPorcentajeIva2_GotFocus()

   With txtPorcentajeIva2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcentajeIva2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtTotal_GotFocus(Index As Integer)

   If txtTotal(Index).Enabled Then
      With txtTotal(Index)
         .SelStart = 0
         .SelLength = Len(.Text)
      End With
   End If

End Sub

Private Sub txtTotal_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtTotal_LostFocus(Index As Integer)

   If txtTotal(Index).Enabled Then CalculaFactura
   
End Sub

Private Sub AnularFactura()

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   
   Set oRs = Aplicacion.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(mvarId, 1))
   If oRs.RecordCount > 0 Then
      If oRs.Fields("ImporteTotal").Value <> oRs.Fields("Saldo").Value Then
         oRs.Close
         Set oRs = Nothing
         MsgBox "La factura ha sido cancelada parcial o totalmente y no puede anularse", vbExclamation
         Exit Sub
      End If
   End If
   oRs.Close
   Set oRs = Nothing
   
   Dim oF As frmAutorizacion
   Dim mOk As Boolean
   Dim mIdAutorizaAnulacion As Integer
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.Facturas
      '.Administradores = True
      .Show vbModal, Me
      mOk = .Ok
      mIdAutorizaAnulacion = .IdAutorizo
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then
      Exit Sub
   End If
   
   Me.Refresh
   
   Dim mSeguro As Integer
   mSeguro = MsgBox("Esta seguro de anular la factura?", vbYesNo, "Anulacion de factura")
   If mSeguro = vbNo Then
      Exit Sub
   End If

   With origen
      .Registro.Fields("Anulada").Value = "SI"
      .Registro.Fields("FechaAnulacion").Value = Now
      .Registro.Fields("IdAutorizaAnulacion").Value = mIdAutorizaAnulacion
      .Guardar
   End With

   Unload Me

End Sub

Private Sub VerificarProvinciasDestino()

   Dim oRs As ADOR.Recordset
   Dim mVacio As Boolean
   Dim mIdCliente As Long
   Dim mIdProvincia As Integer
   
   Set oRs = origen.DetFacturasProvincias.Registros
   mVacio = True
   With oRs
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               If Not .Fields("Eliminado").Value Then
                  mVacio = False
                  Exit Do
               End If
               .MoveNext
            Loop
         End If
      End If
   End With
   Set oRs = Nothing
   
   If mVacio Then
      mIdCliente = 0
      mIdProvincia = 0
      If Not IsNull(origen.Registro.Fields("IdCliente").Value) Then
         mIdCliente = origen.Registro.Fields("IdCliente").Value
      End If
      Set oRs = Aplicacion.Clientes.TraerFiltrado("_PorId", mIdCliente)
      If oRs.RecordCount > 0 Then
         mIdProvincia = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
      End If
      oRs.Close
      
      With origen.DetFacturasProvincias.Item(-1)
         With .Registro
            .Fields("IdProvinciaDestino").Value = mIdProvincia
            .Fields("Porcentaje").Value = 100
         End With
         .Modificado = True
      End With
   End If

   Set oRs = Nothing

End Sub

Public Sub ImpresionEnControladorH()

   On Error GoTo Impresora_apag

Procesar:
   Dim oRs As ADOR.Recordset
   Dim mCuit As String
   Dim mIdRecibo As Long
            
   mIdRecibo = IIf(IsNull(origen.Registro.Fields("IdReciboContado").Value), 0, _
                  origen.Registro.Fields("IdReciboContado").Value)
      
   If mvarTipoABC = "A" Then
      mCuit = mId(txtCuit.Text, 1, 2) & mId(txtCuit.Text, 4, 8) & mId(txtCuit.Text, 13, 1)
'               Select Case mvarTipoIVA
'                  Case 1
'                     mCondicionIva = 73
'                  Case 2
'                     mCondicionIva = "RESPONSABLE_NO_INSCRIPTO"
'                  Case 3
'                     mCondicionIva = "RESPONSABLE_EXENTO"
'                  Case 4
'                     mCondicionIva = "CONSUMIDOR_FINAL"
'                  Case 6
'                     mCondicionIva = "MONOTRIBUTO"
'                  Case Else
'                     mCondicionIva = "RESPONSABLE_INSCRIPTO"
'               End Select
      HASAR1.DatosCliente mId(dcfields(0).Text, 1, 30), mCuit, _
            TIPO_CUIT, RESPONSABLE_INSCRIPTO, _
            mId(txtDireccion.Text & " " & txtLocalidad.Text, 1, 30)
      'HASAR1.InformacionRemito(1) = "1234-56789012"
      HASAR1.AbrirComprobanteFiscal FACTURA_A
      'HASAR1.ImprimirTextoFiscal "En oferta hasta 21-12-2000"
      
      Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetFacturas", "Fac", mvarId)
      With oRs
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               HASAR1.ImprimirItem mId(oRs.Fields("Articulo").Value, 1, 30), _
                           oRs.Fields("Cantidad").Value, _
                           oRs.Fields("Precio U.").Value + (oRs.Fields("Precio U.").Value * mvarP_IVA1_Tomado / 100), _
                           mvarP_IVA1_Tomado, 0
               'HASAR1.DescuentoUltimoItem "Oferta del Dia", 5 , True
               .MoveNext
            Loop
         End If
         .Close
      End With
      
      If mvarImporteBonificacion <> 0 Then
         HASAR1.DescuentoGeneral "Bonificacion", mvarImporteBonificacion, True
      End If
      If mvarPercepcionIVA <> 0 Then
         HASAR1.EspecificarPercepcionPorIVA "percep 21", mvarPercepcionIVA, mvarP_IVA1_Tomado
         'HASAR1.EspecificarPercepcionPorIVA "percep 10.5", 100, 10.5
         'HASAR1.EspecificarPercepcionPorIVA "percep 0", 100, 0
      End If
      If mvarIBrutos <> 0 Or mvarIBrutos2 <> 0 Or mvarIBrutos3 <> 0 Then
         HASAR1.EspecificarPercepcionGlobal "Percep. RG", _
                        mvarIBrutos + mvarIBrutos2 + mvarIBrutos3
      End If
      
      Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetRecibosValores", "Recibo", mIdRecibo)
      With oRs
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               HASAR1.ImprimirPago mId(oRs.Fields("Banco / Caja").Value, 1, 30), _
                        oRs.Fields("Importe").Value
               .MoveNext
            Loop
         End If
         .Close
      End With
      Set oRs = Nothing
      
      HASAR1.CerrarComprobanteFiscal
   Else
      HASAR1.AbrirComprobanteFiscal FACTURA_B
      
      Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetFacturas", "Fac", mvarId)
      With oRs
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               HASAR1.ImprimirItem mId(oRs.Fields("Articulo").Value, 1, 30), _
                           oRs.Fields("Cantidad").Value, _
                           oRs.Fields("Precio U.").Value, mvarP_IVA1_Tomado, 0
               'HASAR1.DescuentoUltimoItem "Oferta del Dia", 5, True
               .MoveNext
            Loop
         End If
         .Close
      End With
      
      If mvarImporteBonificacion <> 0 Then
         HASAR1.DescuentoGeneral "Bonificacion", mvarImporteBonificacion, True
      End If
      
      Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetRecibosValores", "Recibo", mIdRecibo)
      With oRs
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               HASAR1.ImprimirPago mId(oRs.Fields("Banco / Caja").Value, 1, 30), _
                        oRs.Fields("Importe").Value
               .MoveNext
            Loop
         End If
         .Close
      End With
      Set oRs = Nothing
      
      HASAR1.CerrarComprobanteFiscal
   End If
   Exit Sub

Impresora_apag:
   If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
       Resume Procesar
   End If

End Sub

Public Sub ImpresionEnControladorE()

   On Error GoTo Impresora_apag

   Dim oRs As ADOR.Recordset
   Dim mCuit As String, mCondicionIva As String, mTipoDoc As String
   Dim mIdRecibo As Long
   Dim Respuesta As Boolean
            
   mIdRecibo = IIf(IsNull(origen.Registro.Fields("IdReciboContado").Value), 0, _
                  origen.Registro.Fields("IdReciboContado").Value)
      
   If Len(Trim(txtCuit.Text)) > 0 Then
      mTipoDoc = "CUIT"
      mCuit = mId(txtCuit.Text, 1, 2) & mId(txtCuit.Text, 4, 8) & mId(txtCuit.Text, 13, 1)
   Else
      mTipoDoc = "DNI"
      mCuit = "00000000000"
   End If
   Select Case mvarTipoIVA
      Case 1
         mCondicionIva = "I"
      Case 4
         mCondicionIva = "F"
      Case 8, 9, 10
         mCondicionIva = "E"
      Case Else
         mCondicionIva = "M"
   End Select
   
   Respuesta = Me.PrinterFiscal1.OpenInvoice("F", "C", mvarTipoABC, "1", "P", "12", "I", mCondicionIva, _
            mId(dcfields(0).Text, 1, 30), "", mTipoDoc, mCuit, "N", _
            mId(txtDireccion.Text, 1, 30), mId(txtLocalidad.Text, 1, 30), "", "", "", "C")
         
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetFacturas", "Fac", mvarId)
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            Respuesta = Me.PrinterFiscal1.SendInvoiceItem(mId(oRs.Fields("Articulo").Value, 1, 30), _
                     "" & oRs.Fields("Cantidad").Value * 1000, _
                     "" & oRs.Fields("Precio U.").Value * 100, _
                     "" & mvarP_IVA1_Tomado * 100, "M", "0", "0", "", "", "", "0", "0")
            .MoveNext
         Loop
      End If
      .Close
   End With
      
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetRecibosValores", "Recibo", mIdRecibo)
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
'               Respuesta = Me.PrinterFiscal1.SendInvoicePayment(mId(oRs.Fields("Banco / Caja").Value, 1, 20), _
'                        "" & oRs.Fields("Importe").Value * 100, "T")
            .MoveNext
         Loop
      End If
      .Close
   End With
   Set oRs = Nothing
      
   Respuesta = Me.PrinterFiscal1.CloseInvoice("F", mvarTipoABC, "DEL")
   
Procesar:
   Exit Sub

Impresora_apag:
   If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
       Resume Procesar
   End If

End Sub
