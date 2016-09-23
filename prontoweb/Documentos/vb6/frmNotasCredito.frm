VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.4#0"; "Controles1013.ocx"
Object = "{B52C1CDE-38E9-11D5-98EC-00C0F01C6C81}#1.0#0"; "IFEpson.ocx"
Begin VB.Form frmNotasCredito 
   Caption         =   "Notas de credito"
   ClientHeight    =   8715
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10260
   Icon            =   "frmNotasCredito.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8715
   ScaleWidth      =   10260
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   2
      Left            =   6975
      TabIndex        =   84
      Top             =   2295
      Width           =   195
   End
   Begin VB.CheckBox Check4 
      Alignment       =   1  'Right Justify
      Caption         =   "Activar recupero de gastos"
      Height          =   195
      Left            =   3240
      TabIndex        =   81
      Top             =   2610
      Visible         =   0   'False
      Width           =   2310
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
      Index           =   11
      Left            =   8505
      TabIndex        =   79
      Top             =   5310
      Width           =   1590
   End
   Begin VB.CheckBox Check3 
      Alignment       =   1  'Right Justify
      Caption         =   "No incluir esta NC en cubos de venta :"
      Height          =   195
      Left            =   90
      TabIndex        =   78
      Top             =   2610
      Visible         =   0   'False
      Width           =   3075
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
      Index           =   10
      Left            =   8505
      TabIndex        =   56
      Top             =   6255
      Visible         =   0   'False
      Width           =   1590
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   1
      Left            =   6975
      TabIndex        =   75
      Top             =   1935
      Width           =   195
   End
   Begin VB.CommandButton cmdProvinciasDestino 
      Caption         =   "Distribuir IIBB x provincias"
      Height          =   240
      Left            =   5715
      TabIndex        =   74
      Top             =   2610
      Width           =   2715
   End
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Aplicar cuenta corriente deudores :"
      Height          =   240
      Left            =   5760
      TabIndex        =   73
      Top             =   135
      Width           =   2805
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Anular"
      Enabled         =   0   'False
      Height          =   600
      Index           =   2
      Left            =   45
      TabIndex        =   70
      Top             =   8010
      Width           =   795
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   0
      Left            =   6975
      TabIndex        =   60
      Top             =   1575
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
      Height          =   285
      Index           =   7
      Left            =   8505
      TabIndex        =   55
      Top             =   5940
      Visible         =   0   'False
      Width           =   1590
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
      Index           =   6
      Left            =   8505
      TabIndex        =   54
      Top             =   5625
      Visible         =   0   'False
      Width           =   1590
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
      Index           =   5
      Left            =   8505
      TabIndex        =   53
      Top             =   4995
      Visible         =   0   'False
      Width           =   1590
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
      Left            =   4365
      TabIndex        =   49
      Top             =   4365
      Width           =   690
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
      Left            =   6525
      TabIndex        =   48
      Top             =   4365
      Width           =   645
   End
   Begin VB.Frame Frame2 
      Caption         =   "Tipo de nota de credito : "
      Height          =   645
      Left            =   45
      TabIndex        =   45
      Top             =   90
      Width           =   2220
      Begin VB.OptionButton Option5 
         Caption         =   "Normal"
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
         Left            =   135
         TabIndex        =   47
         Top             =   315
         Width           =   960
      End
      Begin VB.OptionButton Option6 
         Caption         =   "Interna"
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
         Left            =   1125
         TabIndex        =   46
         Top             =   315
         Width           =   960
      End
   End
   Begin VB.TextBox txtPorcentajeIva2 
      Alignment       =   1  'Right Justify
      Height          =   270
      Left            =   6570
      TabIndex        =   43
      Top             =   4725
      Visible         =   0   'False
      Width           =   405
   End
   Begin VB.TextBox txtPorcentajeIva1 
      Alignment       =   1  'Right Justify
      Height          =   270
      Left            =   7830
      TabIndex        =   42
      Top             =   4680
      Width           =   405
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   600
      Index           =   0
      Left            =   45
      Picture         =   "frmNotasCredito.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   39
      Top             =   6645
      UseMaskColor    =   -1  'True
      Width           =   795
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   600
      Index           =   1
      Left            =   45
      Picture         =   "frmNotasCredito.frx":0DD4
      Style           =   1  'Graphical
      TabIndex        =   38
      Top             =   7335
      Width           =   795
   End
   Begin VB.TextBox txtCodigoCliente 
      Alignment       =   2  'Center
      Height          =   315
      Left            =   1665
      TabIndex        =   6
      Top             =   810
      Width           =   660
   End
   Begin VB.TextBox txtCondicionIva 
      Enabled         =   0   'False
      Height          =   285
      Left            =   6975
      TabIndex        =   30
      Top             =   1080
      Width           =   1395
   End
   Begin VB.TextBox txtCuit 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   8955
      TabIndex        =   29
      Top             =   1080
      Width           =   1170
   End
   Begin VB.TextBox txtEmail 
      Enabled         =   0   'False
      Height          =   285
      Left            =   6975
      TabIndex        =   28
      Top             =   765
      Width           =   3150
   End
   Begin VB.TextBox txtFax 
      Enabled         =   0   'False
      Height          =   285
      Left            =   8685
      TabIndex        =   27
      Top             =   450
      Width           =   1440
   End
   Begin VB.TextBox txtTelefono 
      Enabled         =   0   'False
      Height          =   285
      Left            =   6975
      TabIndex        =   26
      Top             =   450
      Width           =   1260
   End
   Begin VB.TextBox txtCodigoPostal 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   4770
      TabIndex        =   21
      Top             =   1890
      Width           =   795
   End
   Begin VB.TextBox txtProvincia 
      Enabled         =   0   'False
      Height          =   315
      Left            =   1665
      TabIndex        =   20
      Top             =   1890
      Width           =   2130
   End
   Begin VB.TextBox txtLocalidad 
      Enabled         =   0   'False
      Height          =   315
      Left            =   1665
      TabIndex        =   19
      Top             =   1530
      Width           =   3885
   End
   Begin VB.TextBox txtDireccion 
      Enabled         =   0   'False
      Height          =   315
      Left            =   1665
      TabIndex        =   18
      Top             =   1170
      Width           =   3885
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
      Height          =   360
      Index           =   8
      Left            =   8505
      TabIndex        =   14
      Top             =   6660
      Width           =   1590
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
      Index           =   4
      Left            =   8505
      TabIndex        =   13
      Top             =   4680
      Width           =   1590
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
      Left            =   8505
      TabIndex        =   12
      Top             =   4365
      Width           =   1590
   End
   Begin VB.TextBox txtNumeroNotaCredito 
      Alignment       =   2  'Center
      DataField       =   "NumeroNotaCredito"
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
      Height          =   315
      Left            =   4275
      TabIndex        =   3
      Top             =   450
      Width           =   1245
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   600
      Index           =   1
      Left            =   45
      TabIndex        =   2
      Top             =   5955
      Width           =   795
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   600
      Index           =   0
      Left            =   45
      TabIndex        =   1
      Top             =   5265
      Width           =   795
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
      Left            =   5805
      TabIndex        =   0
      Top             =   6660
      Width           =   1410
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaNotaCredito"
      Height          =   330
      Index           =   0
      Left            =   3240
      TabIndex        =   5
      Top             =   90
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   57081857
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCliente"
      Height          =   315
      Index           =   0
      Left            =   2340
      TabIndex        =   7
      Tag             =   "Clientes"
      Top             =   810
      Width           =   3210
      _ExtentX        =   5662
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCliente"
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   1275
      Left            =   2745
      TabIndex        =   36
      Top             =   3060
      Width           =   7440
      _ExtentX        =   13123
      _ExtentY        =   2249
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmNotasCredito.frx":135E
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaImp 
      Height          =   1635
      Left            =   900
      TabIndex        =   37
      Top             =   4995
      Width           =   6450
      _ExtentX        =   11377
      _ExtentY        =   2884
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmNotasCredito.frx":137A
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   3285
      Top             =   4770
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
            Picture         =   "frmNotasCredito.frx":1396
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNotasCredito.frx":14A8
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNotasCredito.frx":18FA
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNotasCredito.frx":1D4C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   960
      Left            =   45
      TabIndex        =   40
      Top             =   3375
      Width           =   2670
      _ExtentX        =   4710
      _ExtentY        =   1693
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmNotasCredito.frx":219E
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   3
      Left            =   945
      TabIndex        =   68
      Tag             =   "Monedas"
      Top             =   4365
      Width           =   1680
      _ExtentX        =   2963
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
      Left            =   7245
      TabIndex        =   67
      Tag             =   "IBCondiciones"
      Top             =   1530
      Width           =   2880
      _ExtentX        =   5080
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
      Left            =   3240
      TabIndex        =   63
      Tag             =   "PuntosVenta"
      Top             =   450
      Width           =   1005
      _ExtentX        =   1773
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPuntoVenta"
      Text            =   ""
   End
   Begin Controles1013.DbListView ListaOC 
      Height          =   1545
      Left            =   900
      TabIndex        =   64
      Top             =   7065
      Width           =   9285
      _ExtentX        =   16378
      _ExtentY        =   2725
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
      MouseIcon       =   "frmNotasCredito.frx":2220
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   1
      Left            =   1665
      TabIndex        =   71
      Tag             =   "Obras"
      Top             =   2250
      Width           =   2160
      _ExtentX        =   3810
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
      Left            =   7245
      TabIndex        =   76
      Tag             =   "IBCondiciones"
      Top             =   1890
      Width           =   2880
      _ExtentX        =   5080
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdIBCondicion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdListaPrecios"
      Height          =   315
      Index           =   7
      Left            =   4290
      TabIndex        =   82
      Tag             =   "ListasPrecios"
      Top             =   2250
      Width           =   1275
      _ExtentX        =   2249
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdListaPrecios"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdIBCondicion3"
      Height          =   315
      Index           =   6
      Left            =   7245
      TabIndex        =   85
      Tag             =   "IBCondiciones"
      Top             =   2250
      Width           =   2880
      _ExtentX        =   5080
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdIBCondicion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCodigoIva"
      Height          =   315
      Index           =   11
      Left            =   7290
      TabIndex        =   88
      Tag             =   "DescripcionIva"
      Top             =   1260
      Visible         =   0   'False
      Width           =   2970
      _ExtentX        =   5239
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCodigoIva"
      Text            =   ""
   End
   Begin EPSON_Impresora_Fiscal.PrinterFiscal PrinterFiscal1 
      Left            =   4140
      Top             =   4680
      _ExtentX        =   847
      _ExtentY        =   847
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaRecepcionCliente"
      Height          =   330
      Index           =   1
      Left            =   1485
      TabIndex        =   90
      Top             =   2835
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   57081857
      CurrentDate     =   36377
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha rec.cliente :"
      Height          =   240
      Index           =   9
      Left            =   90
      TabIndex        =   91
      Top             =   2880
      Width           =   1350
   End
   Begin VB.Label lblCAE 
      Alignment       =   2  'Center
      BackColor       =   &H00C0FFFF&
      Caption         =   "Label5"
      Height          =   195
      Left            =   90
      TabIndex        =   89
      Top             =   4905
      Visible         =   0   'False
      Width           =   2445
   End
   Begin VB.Label lblData 
      Caption         =   "Categoria IIBB 3"
      Height          =   285
      Index           =   2
      Left            =   5760
      TabIndex        =   87
      Top             =   2250
      Width           =   1170
   End
   Begin VB.Label lblData 
      Caption         =   "Categoria IIBB 2"
      Height          =   285
      Index           =   1
      Left            =   5760
      TabIndex        =   86
      Top             =   1890
      Width           =   1170
   End
   Begin VB.Label lblData 
      Caption         =   "Lista :"
      Height          =   285
      Index           =   3
      Left            =   3825
      TabIndex        =   83
      Top             =   2250
      Width           =   450
   End
   Begin VB.Label Label4 
      Caption         =   "Percep. IVA : "
      Height          =   240
      Left            =   7425
      TabIndex        =   80
      Top             =   5355
      Width           =   1005
   End
   Begin VB.Label lblOtrasPercepciones3 
      Height          =   195
      Left            =   7425
      TabIndex        =   77
      Top             =   6300
      Visible         =   0   'False
      Width           =   1005
   End
   Begin VB.Line Line9 
      BorderColor     =   &H00FFFFFF&
      Index           =   3
      X1              =   10125
      X2              =   10125
      Y1              =   2880
      Y2              =   1440
   End
   Begin VB.Line Line9 
      BorderColor     =   &H00FFFFFF&
      Index           =   1
      X1              =   5670
      X2              =   5670
      Y1              =   2880
      Y2              =   1440
   End
   Begin VB.Line Line9 
      BorderColor     =   &H00FFFFFF&
      Index           =   0
      X1              =   10125
      X2              =   5670
      Y1              =   2880
      Y2              =   2880
   End
   Begin VB.Line Line9 
      BorderColor     =   &H00FFFFFF&
      Index           =   2
      X1              =   10125
      X2              =   5670
      Y1              =   1440
      Y2              =   1440
   End
   Begin VB.Label lblData 
      Caption         =   "Obra (opcional) :"
      Height          =   240
      Index           =   0
      Left            =   90
      TabIndex        =   72
      Top             =   2295
      Width           =   1530
   End
   Begin VB.Label lblEstado 
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
      Left            =   8640
      TabIndex        =   69
      Top             =   90
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Detalle de conceptos a aplicar :"
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
      Left            =   2790
      TabIndex        =   66
      Top             =   2880
      Width           =   2745
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Detalle de ordenes de compra :"
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
      Left            =   945
      TabIndex        =   65
      Top             =   6885
      Width           =   2685
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
      Height          =   285
      Left            =   4905
      TabIndex        =   62
      Top             =   90
      Width           =   375
   End
   Begin VB.Line Line8 
      BorderWidth     =   2
      X1              =   4860
      X2              =   5310
      Y1              =   45
      Y2              =   45
   End
   Begin VB.Line Line7 
      BorderWidth     =   2
      X1              =   4860
      X2              =   5310
      Y1              =   405
      Y2              =   405
   End
   Begin VB.Line Line6 
      BorderWidth     =   2
      X1              =   5310
      X2              =   5310
      Y1              =   45
      Y2              =   405
   End
   Begin VB.Line Line5 
      BorderWidth     =   2
      X1              =   4860
      X2              =   4860
      Y1              =   45
      Y2              =   405
   End
   Begin VB.Label lblData 
      Caption         =   "Categoria IIBB 1"
      Height          =   285
      Index           =   10
      Left            =   5760
      TabIndex        =   61
      Top             =   1530
      Width           =   1170
   End
   Begin VB.Label lblOtrasPercepciones1 
      Height          =   240
      Left            =   7425
      TabIndex        =   59
      Top             =   5670
      Visible         =   0   'False
      Width           =   1005
   End
   Begin VB.Label lblOtrasPercepciones2 
      Height          =   240
      Left            =   7425
      TabIndex        =   58
      Top             =   5985
      Visible         =   0   'False
      Width           =   1005
   End
   Begin VB.Label lblPercIBB 
      Caption         =   "Percep. IIBB :"
      Height          =   240
      Left            =   7425
      TabIndex        =   57
      Top             =   5040
      Visible         =   0   'False
      Width           =   1005
   End
   Begin VB.Label lblLabels 
      Caption         =   "Conversion a Pesos :"
      Height          =   240
      Index           =   16
      Left            =   2790
      TabIndex        =   52
      Top             =   4410
      Width           =   1530
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cotizacion dolar :"
      Height          =   240
      Index           =   15
      Left            =   5220
      TabIndex        =   51
      Top             =   4410
      Width           =   1260
   End
   Begin VB.Label lblLabels 
      Caption         =   "Moneda :"
      Height          =   240
      Index           =   14
      Left            =   90
      TabIndex        =   50
      Top             =   4410
      Width           =   780
   End
   Begin VB.Label Label7 
      Caption         =   " % "
      Height          =   240
      Left            =   8235
      TabIndex        =   44
      Top             =   4725
      Width           =   195
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
      Index           =   18
      Left            =   90
      TabIndex        =   41
      Top             =   3195
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cliente :"
      Height          =   285
      Index           =   5
      Left            =   90
      TabIndex        =   4
      Top             =   810
      Width           =   1530
   End
   Begin VB.Label lblLabels 
      Caption         =   "N.Credito :"
      Height          =   240
      Index           =   2
      Left            =   2340
      TabIndex        =   8
      Top             =   495
      Width           =   810
   End
   Begin VB.Label lblLabels 
      Caption         =   "Condicion IVA :"
      Height          =   270
      Index           =   8
      Left            =   5760
      TabIndex        =   35
      Top             =   1080
      Width           =   1125
   End
   Begin VB.Label lblLabels 
      Caption         =   "CUIT :"
      Height          =   240
      Index           =   4
      Left            =   8415
      TabIndex        =   34
      Top             =   1125
      Width           =   480
   End
   Begin VB.Label lblLabels 
      Caption         =   "Email :"
      Height          =   195
      Index           =   7
      Left            =   5760
      TabIndex        =   33
      Top             =   810
      Width           =   1125
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fax :"
      Height          =   195
      Index           =   3
      Left            =   8280
      TabIndex        =   32
      Top             =   495
      Width           =   360
   End
   Begin VB.Label lblLabels 
      Caption         =   "Telefono :"
      Height          =   240
      Index           =   0
      Left            =   5760
      TabIndex        =   31
      Top             =   495
      Width           =   1125
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cod.postal : "
      Height          =   285
      Index           =   13
      Left            =   3825
      TabIndex        =   25
      Top             =   1905
      Width           =   885
   End
   Begin VB.Label lblLabels 
      Caption         =   "Provincia :"
      Height          =   285
      Index           =   12
      Left            =   90
      TabIndex        =   24
      Top             =   1905
      Width           =   1530
   End
   Begin VB.Label lblLabels 
      Caption         =   "Localidad :"
      Height          =   285
      Index           =   11
      Left            =   90
      TabIndex        =   23
      Top             =   1560
      Width           =   1530
   End
   Begin VB.Label lblLabels 
      Caption         =   "Dirección :"
      Height          =   285
      Index           =   10
      Left            =   90
      TabIndex        =   22
      Top             =   1200
      Width           =   1530
   End
   Begin VB.Line Line2 
      BorderColor     =   &H80000005&
      BorderWidth     =   3
      X1              =   8505
      X2              =   10035
      Y1              =   6570
      Y2              =   6570
   End
   Begin VB.Label Label6 
      BackColor       =   &H00FFFFFF&
      Caption         =   "TOTAL :"
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
      Left            =   7425
      TabIndex        =   17
      Top             =   6660
      Width           =   1005
   End
   Begin VB.Label lblIVA1 
      Caption         =   "IVA"
      Height          =   285
      Left            =   7425
      TabIndex        =   16
      Top             =   4695
      Width           =   375
   End
   Begin VB.Label Label1 
      Caption         =   "Subtotal :"
      Height          =   285
      Left            =   7425
      TabIndex        =   15
      Top             =   4365
      Width           =   1005
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   22
      Left            =   2340
      TabIndex        =   11
      Top             =   135
      Width           =   810
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
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
      Left            =   945
      TabIndex        =   10
      Top             =   4770
      Width           =   2175
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
      Left            =   3645
      TabIndex        =   9
      Top             =   6660
      Width           =   2115
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
   Begin VB.Menu MnuDetImp 
      Caption         =   "DetalleImp"
      Visible         =   0   'False
      Begin VB.Menu MnuDetB 
         Caption         =   "Agregar imputacion"
         Index           =   0
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Modificar imputacion"
         Index           =   1
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Eliminar imputacion"
         Index           =   2
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Modificar importe"
         Index           =   3
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Sin aplicacion"
         Index           =   4
      End
   End
End
Attribute VB_Name = "frmNotasCredito"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.NotaCredito
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mvarIdCliente As Long, mIdDetalleOrdenCompra As Long
Private cALetra As New clsNum2Let
Dim actL2 As ControlForm
Private mvarGrabado As Boolean, mvarNumeracionUnica As Boolean, OC_Elegida As Boolean, mvarModificacionHabilitada As Boolean
Private mvarIBrutosC As String, mvarIBrutosB As String, mvarMultilateral As String, mvarAclaracionAlPie As String
Private mvarTipoABC As String, mvarPercepcionIIBB As String, mvarAnulada As String, mvarEsAgenteRetencionIVA As String
Private mvarOtrasPercepciones1 As String, mvarOtrasPercepciones1Desc As String, mvarOtrasPercepciones2 As String
Private mvarOtrasPercepciones2Desc As String, mvarOtrasPercepciones3 As String, mvarOtrasPercepciones3Desc As String
Private mFiscal As String
Private mvarPorc_IBrutos_Cap As Double, mvarTope_IBrutos_Cap As Double, mvarTotalImp As Double, mvarPercepcionIVA As Double
Private mvarIBrutos As Double, mvarIBrutos2 As Double, mvarIBrutos3 As Double, mvarPorc_IBrutos_BsAs As Double
Private mvarTope_IBrutos_BsAs As Double, mvarPorcentajeIBrutos As Double, mvarPorcentajeIBrutos2 As Double
Private mvarPorcentajeIBrutos3 As Double, mvarPorc_IBrutos_BsAsM As Double, mvarTope_IBrutos_BsAsM As Double
Private mvar_IBrutos_Cap As Double, mvar_IBrutos_BsAs As Double, mvar_IBrutos_BsAsM As Double, mvarP_IVA1 As Double
Private mvarP_IVA2 As Double, mvarIVA1 As Double, mvarIVA2 As Double, mvarDecimales As Double, mvarRecargoMora As Double
Private mvarTotalNotaCredito As Double, mvarCotizacionDolar As Double, mvarSubTotal As Double, mvarCotizacion As Double
Private mvarTotalImputaciones As Double, mvarIVANoDiscriminado As Double, mvarBaseMinimaParaPercepcionIVA As Double
Private mvarPorcentajePercepcionIVA As Single, mAlicuotaDirecta As Single, mAlicuotaDirectaCapital As Single
Private mvarTipoIVA As Integer, mvarPuntoVenta As Integer, mIdMonedaPesos As Integer, mvarIBCondicion As Integer
Private mvarIdMonedaDolar As Integer
Private mFechaInicioVigenciaIBDirecto As Date, mFechaFinVigenciaIBDirecto As Date
Private mFechaInicioVigenciaIBDirectoCapital As Date, mFechaFinVigenciaIBDirectoCapital As Date
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

   If mvarId > 0 Then
      MsgBox "No puede modificar una nota de credito ya registrada!", vbExclamation
      Exit Sub
   End If
   
   If Len(Trim(dcfields(0).BoundText)) = 0 Then
      MsgBox "Falta completar el campo cliente", vbCritical
      Exit Sub
   End If
   
   Dim oF As frmDetNotasCredito
   Dim oL As ListItem
   
   Set oF = New frmDetNotasCredito
   
   With oF
      Set .NotaCredito = origen
      .Interna = Option6.Value
      .IdCodigoIva = mvarTipoIVA
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
            .Text = oF.DataCombo1(0).Text
            If Len(oF.DataCombo1(4).Text) <> 0 Then
               .SubItems(1) = "" & oF.DataCombo1(4).Text
            Else
               .SubItems(1) = "" & oF.DataCombo1(5).Text
            End If
            .SubItems(2) = "" & IIf(oF.Option1.Value, "SI", "NO")
            .SubItems(3) = "" & Format(oF.txtImporte.Text, "#,##0.00")
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing

   CalculaNotaCredito

End Sub

Sub EditarImputacion(ByVal Cual As Long)

   If mvarId > 0 Then
      MsgBox "No puede modificar una nota de credito ya registrada!", vbCritical
      Exit Sub
   End If
   
   If Len(Trim(dcfields(0).BoundText)) = 0 Then
      MsgBox "Falta completar el campo cliente", vbCritical
      Exit Sub
   End If
   
   Dim oF As frmImputaciones
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim Esta As Boolean
   
   Set oF = New frmImputaciones
   
   With oF
      .TipoCuenta = "Deudores"
      If origen.Registro.Fields("IdMoneda").Value = 1 Then
         .Moneda = "Pesos"
      Else
         .Moneda = "Dolares"
      End If
      .Id = dcfields(0).BoundText
      .Show vbModal, Me
   End With
   
   For Each oL In oF.Lista.ListItems
      If oL.ListSubItems(7) = "*" Then
         Set oRs = origen.DetNotasCreditoImp.TodosLosRegistros
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
               oRs.Close
               Set oRs = Nothing
            End If
         End If
         If Not Esta Then
            With origen.DetNotasCreditoImp.Item(-1)
               .Registro.Fields("IdImputacion").Value = oL.Tag
               .Registro.Fields("Importe").Value = oL.ListSubItems(5)
               .Modificado = True
            End With
         End If
      End If
   Next
   
   Set oRs = origen.DetNotasCreditoImp.RegistrosConFormato
   Set ListaImp.DataSource = oRs
   If ListaImp.ListItems.Count > 0 Then
      dcfields(0).Enabled = False
      txtCodigoCliente.Enabled = False
   End If
   oRs.Close
   Set oRs = Nothing
   
   Unload oF
   Set oF = Nothing
   
   CalculaNotaCredito

End Sub

Sub EditarImporte(ByVal Cual As Long)

   If mvarId > 0 Then
      MsgBox "No puede modificar una nota de credito ya registrada!", vbCritical
      Exit Sub
   End If
   
   Dim oF As frmDetRecibos
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   
   Set oF = New frmDetRecibos
   
   With oF
      .ACancelar = ListaImp.SelectedItem.ListSubItems(5)
      If Len(ListaImp.SelectedItem.ListSubItems(4)) > 0 Then
         .Saldo = ListaImp.SelectedItem.ListSubItems(4)
      Else
         .Saldo = 0
      End If
      .Show vbModal, Me
   End With
   
   origen.DetNotasCreditoImp.Item(Cual).Registro.Fields("Importe").Value = Val(oF.txtACancelar.Text)
   ListaImp.SelectedItem.ListSubItems(5) = Format(Val(oF.txtACancelar.Text), "$ #,##0.00")
   
   Unload oF
   
   Set oF = Nothing
   
   CalculaNotaCredito

End Sub

Sub AgregarAnticipo()

   If mvarId > 0 Then
      MsgBox "No puede modificar una nota de credito ya registrada!", vbCritical
      Exit Sub
   End If
   
   If Len(Trim(dcfields(0).BoundText)) = 0 Then
      MsgBox "Falta completar el campo cliente", vbCritical
      Exit Sub
   End If
   
   If Len(Trim(txtNumeroNotaCredito.Text)) = 0 Then
      MsgBox "Falta completar el campo numero de nota de credito", vbCritical
      Exit Sub
   End If
   
   DoEvents
   
   Dim oRs As ADOR.Recordset
   Dim mvarDif As Double
   
   mvarDif = (mvarTotalNotaCredito - mvarTotalImputaciones)

   If mvarDif > 0 Then
      With origen.DetNotasCreditoImp.Item(-1)
         .Registro.Fields("IdImputacion").Value = -1
         .Registro.Fields("Importe").Value = mvarDif
         mvarDif = 0
         .Modificado = True
      End With
   End If

   Set oRs = origen.DetNotasCreditoImp.RegistrosConFormato
   Set ListaImp.DataSource = oRs
   
   oRs.Close
   Set oRs = Nothing
   
   CalculaNotaCredito

End Sub

Private Sub Check1_Click(Index As Integer)

   If Check1(Index).Value = 0 Then
      With origen.Registro
         If Index = 0 Then
            .Fields("IdIBCondicion").Value = Null
            dcfields(4).Enabled = False
         ElseIf Index = 1 Then
            .Fields("IdIBCondicion2").Value = Null
            dcfields(5).Enabled = False
         ElseIf Index = 2 Then
            .Fields("IdIBCondicion3").Value = Null
            dcfields(6).Enabled = False
         End If
      End With
   Else
      If Index = 0 Then
         dcfields(4).Enabled = True
      ElseIf Index = 1 Then
         dcfields(5).Enabled = True
      ElseIf Index = 2 Then
         dcfields(6).Enabled = True
      End If
   End If
   CalculaNotaCredito

End Sub

Private Sub Check4_Click()

   If Check4.Value = 1 Then
      If mvarId <= 0 Then
         If Len(txtCuit.Text) > 0 Then
            Dim mIdAutorizo As Long
            Dim mOk As Boolean
            Dim oF As frmAutorizacion
            Set oF = New frmAutorizacion
            With oF
               .Empleado = 0
               .Administradores = True
               .Show vbModal
               mOk = .Ok
               mIdAutorizo = .IdAutorizo
            End With
            Unload oF
            Set oF = Nothing
            If mOk Then
               Dim oRs As ADOR.Recordset
               Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorCuit", txtCuit.Text)
               If oRs.RecordCount = 0 Then
                  MsgBox "No existe un proveedor con el mismo cuit del cliente", vbExclamation
                  Check4.Value = 0
               Else
                  origen.Registro.Fields("IdAutorizoRecuperoGastos").Value = mIdAutorizo
               End If
               oRs.Close
               Set oRs = Nothing
            Else
               Check4.Value = 0
            End If
         Else
            Check4.Value = 0
            origen.Registro.Fields("IdAutorizoRecuperoGastos").Value = Null
         End If
         Option6.Value = True
      End If
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         If DTFields(0).Value <= gblFechaUltimoCierre And Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
            MsgBox "La fecha no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation
            Exit Sub
         End If

         Dim mIdObra As Integer, mIdProvinciaDestino As Integer
         If mvarId > 0 Then
            If Len(dcfields(1).Text) = 0 Or Not IsNumeric(dcfields(1).BoundText) Then
               mIdObra = -1
            Else
               mIdObra = dcfields(1).BoundText
            End If
'            If Len(dcfields(5).Text) = 0 Or Not IsNumeric(dcfields(5).BoundText) Then
               mIdProvinciaDestino = -1
'            Else
'               mIdProvinciaDestino = dcfields(5).BoundText
'            End If
            If Check3.Value = 1 Then
               origen.Registro.Fields("NoIncluirEnCubos").Value = "SI"
            Else
               origen.Registro.Fields("NoIncluirEnCubos").Value = Null
            End If
            Aplicacion.Tarea "NotasCredito_ActualizarCampos", _
                  Array(mvarId, mIdProvinciaDestino, mIdObra, origen.Registro.Fields("NoIncluirEnCubos").Value, _
                        rchObservaciones.Text, dcfields(10).BoundText, DTFields(0).Value, Val(txtNumeroNotaCredito.Text), _
                        DTFields(1).Value)
            Unload Me
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim oL As ListItem
         Dim est As EnumAcciones
         Dim mvarImprime As Integer, i As Integer, mNumeroItem As Integer, mCantidadItem As Integer, mCodigoMoneda As Integer
         Dim mTipoComprobante As Integer
         Dim mvarNumero As Long, mIdConceptoRecuperoGastos As Long, mCodigo As Long, mIdentificador As Long, mIdCuenta As Long
         Dim mIdProveedor As Long, mIdCuentaIvaCompras As Long
         Dim mResult As String, mFecha As String, mWS As String, mDescripcion As String, mNCM As String, mCAE As String
         Dim mModoTest As String, mCodigoMoneda1 As String, mPaisDestino As String, mCuitPais As String, mCliente As String
         Dim mDomicilio As String, mUnidadesCodigoAFIP As String, mCAEManual As String
         Dim mvarFechaVencimientoCAE As Date
         Dim mResul As Boolean
         Dim oRs As ADOR.Recordset
         Dim oRs1 As ADOR.Recordset
         Dim oF As frm_Aux
         
         If Round(mvarTotalNotaCredito, 2) <> Round(mvarTotalImputaciones, 2) Then
            MsgBox "La suma de las imputaciones no coinciden con el total de la nota de credito!"
            Exit Sub
         End If
         
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar una Nota de credito sin detalles"
            Exit Sub
         End If
         
         If Len(txtCotizacionMoneda.Text) = 0 Then
            MsgBox "No ingreso la cotizacion", vbInformation
            Exit Sub
         End If
         
         If Val(txtCotizacionMoneda.Text) < 0 Then
            MsgBox "La cotizacion debe ser mayor o igual a cero", vbInformation
            Exit Sub
         End If
         
         If Len(txtCotizacionDolar.Text) = 0 Then
            MsgBox "No ingreso la cotizacion", vbInformation
            Exit Sub
         End If
         
         If Val(txtCotizacionDolar.Text) < 0 Then
            MsgBox "La cotizacion debe ser mayor o igual a cero", vbInformation
            Exit Sub
         End If
         
         If mvarId < 0 Then
            If origen.DetNotasCredito.Registros.RecordCount = 0 Then
               MsgBox "No determino ningun item para grabar"
               Exit Sub
            End If
         End If
         
         If mvarId < 0 And IsNumeric(dcfields(10).BoundText) And Not BuscarClaveINI("Validar fecha de facturas nuevas") = "NO" Then
            Set oRs = Aplicacion.NotasCredito.TraerFiltrado("_UltimaPorIdPuntoVenta", dcfields(10).BoundText)
            If oRs.RecordCount > 0 Then
               If oRs.Fields("FechaNotaCredito").Value > DTFields(0).Value Then
                  MsgBox "La fecha de la ultima nota de credito es " & oRs.Fields("FechaNotaCredito").Value & ", modifiquela", vbExclamation
                  oRs.Close
                  Set oRs = Nothing
                  Exit Sub
               End If
            End If
            oRs.Close
            Set oRs = Nothing
         End If
         
         If EstadoEntidad("Clientes", mvarIdCliente) = "INACTIVO" Then
            MsgBox "Cliente inhabilitado", vbExclamation
            Exit Sub
         End If
            
         With origen.Registro
            For Each dtp In DTFields
               If ExisteCampo(origen.Registro, dtp.DataField) Then
                  .Fields(dtp.DataField).Value = dtp.Value
               End If
            Next
            For Each dc In dcfields
               If ExisteCampo(origen.Registro, dc.DataField) And dc.Enabled And dc.Visible Then
                  If Not IsNumeric(dc.BoundText) And dc.Index <> 1 And dc.Index <> 7 Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
                  If IsNumeric(dc.BoundText) Then .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
         End With
         
         Dim mvarCAI As Double, mvarCAI_v As String
         Dim mvarFechaCAI As Date, mvarFechaCAI_v As String
         If IsNumeric(dcfields(10).BoundText) Then
            Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(10).BoundText)
            Select Case mvarTipoABC
               Case "A", "M"
                  mvarCAI_v = "NumeroCAI_C_A"
                  mvarFechaCAI_v = "FechaCAI_C_A"
               Case "B"
                  mvarCAI_v = "NumeroCAI_C_B"
                  mvarFechaCAI_v = "FechaCAI_C_B"
               Case "E"
                  mvarCAI_v = "NumeroCAI_C_E"
                  mvarFechaCAI_v = "FechaCAI_C_E"
            End Select
            mvarCAI = 0
            mvarFechaCAI = DateSerial(2000, 1, 1)
            If Len(mvarCAI_v) > 0 Then
               If Not IsNull(oRs.Fields(mvarCAI_v).Value) Then mvarCAI = Val(oRs.Fields(mvarCAI_v).Value)
               If Not IsNull(oRs.Fields(mvarFechaCAI_v).Value) Then mvarFechaCAI = oRs.Fields(mvarFechaCAI_v).Value
            End If
            mWS = IIf(IsNull(oRs.Fields("WebService").Value), "", oRs.Fields("WebService").Value)
            mModoTest = IIf(IsNull(oRs.Fields("WebServiceModoTest").Value), "", oRs.Fields("WebServiceModoTest").Value)
            mCAEManual = IIf(IsNull(oRs.Fields("CAEManual").Value), "", oRs.Fields("CAEManual").Value)
            oRs.Close
            If (mvarTipoABC = "A" Or mvarTipoABC = "M") And mvarCAI = 0 And Len(mWS) = 0 Then
               MsgBox "No existe numero de CAI", vbExclamation
               Exit Sub
            End If
            If Len(mvarCAI_v) > 0 And DTFields(0).Value > mvarFechaCAI And Len(mWS) = 0 Then
               MsgBox "El CAI vencio el " & mvarFechaCAI & ", no puede grabar el comprobante", vbExclamation
               Exit Sub
            End If
         Else
            If Option5.Value Then
               MsgBox "No ingreso el punto de venta", vbExclamation
               Exit Sub
            Else
               mvarCAI = 0
               mvarFechaCAI = DateSerial(2000, 1, 1)
            End If
         End If
         
         Me.MousePointer = vbHourglass
         DoEvents
      
         VerificarProvinciasDestino
         
         With origen.Registro
            .Fields("TipoABC").Value = mvarTipoABC
            .Fields("PuntoVenta").Value = Val(dcfields(10).Text)
            .Fields("ImporteTotal").Value = mvarTotalNotaCredito
            .Fields("ImporteIva1").Value = mvarIVA1
            .Fields("ImporteIva2").Value = mvarIVA2
            .Fields("RetencionIBrutos1").Value = mvarIBrutos
            .Fields("PorcentajeIBrutos1").Value = mvarPorcentajeIBrutos
'            .Fields("ConvenioMultilateral").Value = mvarMultilateral
            .Fields("RetencionIBrutos2").Value = mvarIBrutos2
            .Fields("PorcentajeIBrutos2").Value = mvarPorcentajeIBrutos2
            .Fields("RetencionIBrutos3").Value = mvarIBrutos3
            .Fields("PorcentajeIBrutos3").Value = mvarPorcentajeIBrutos3
            .Fields("CotizacionDolar").Value = mvarCotizacion
            .Fields("PorcentajeIva1").Value = Val(txtPorcentajeIva1.Text)
            .Fields("PorcentajeIva2").Value = Val(txtPorcentajeIva2.Text)
            .Fields("IdCodigoIva").Value = mvarTipoIVA
            If Option5.Value Then
               .Fields("CtaCte").Value = "SI"
            Else
               .Fields("CtaCte").Value = "NO"
            End If
            .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text
            .Fields("CotizacionDolar").Value = txtCotizacionDolar.Text
            .Fields("OtrasPercepciones1").Value = Val(txtTotal(6).Text)
            .Fields("OtrasPercepciones1Desc").Value = mvarOtrasPercepciones1Desc
            .Fields("OtrasPercepciones2").Value = Val(txtTotal(7).Text)
            .Fields("OtrasPercepciones2Desc").Value = mvarOtrasPercepciones2Desc
            .Fields("OtrasPercepciones3").Value = Val(txtTotal(10).Text)
            .Fields("OtrasPercepciones3Desc").Value = mvarOtrasPercepciones3Desc
            .Fields("NumeroCAI").Value = mvarCAI
            .Fields("FechaVencimientoCAI").Value = mvarFechaCAI
            .Fields("IVANoDiscriminado").Value = mvarIVANoDiscriminado
            If mvarId < 0 Then
               .Fields("IdUsuarioIngreso").Value = glbIdUsuario
               .Fields("FechaIngreso").Value = Now
            End If
            If Check2.Value = 1 Then
               .Fields("AplicarEnCtaCte").Value = "SI"
            Else
               .Fields("AplicarEnCtaCte").Value = "NO"
            End If
            If Check3.Value = 1 Then
               .Fields("NoIncluirEnCubos").Value = "SI"
            Else
               .Fields("NoIncluirEnCubos").Value = Null
            End If
            .Fields("Observaciones").Value = rchObservaciones.Text
            .Fields("PercepcionIVA").Value = mvarPercepcionIVA
            .Fields("PorcentajePercepcionIVA").Value = mvarPorcentajePercepcionIVA
            If Check4.Value = 1 Then
               .Fields("ActivarRecuperoGastos").Value = "SI"
            Else
               .Fields("ActivarRecuperoGastos").Value = Null
            End If
         End With
         
         Dim oDetOC As DetNotaCreditoOC
         If Not mvarId = -1 Then origen.DetNotasCreditoOC.BorrarTodosLosItems
         With origen.DetNotasCreditoOC
            For Each oL In ListaOC.ListItems
               If oL.Checked Then
                  Set oDetOC = .Item(-1)
                  With oDetOC
                     .Registro.Fields("IdDetalleOrdenCompra").Value = oL.SubItems(1)
                     If Val(oL.SubItems(13)) = 1 Then
                        .Registro.Fields("Cantidad").Value = CDbl(oL.SubItems(15))
                        .Registro.Fields("PorcentajeCertificacion").Value = 0
                     Else
                        .Registro.Fields("PorcentajeCertificacion").Value = CDbl(oL.SubItems(15))
                        .Registro.Fields("Cantidad").Value = 0
                     End If
                     .Modificado = True
                  End With
                  Set oDetOC = Nothing
               End If
            Next
         End With
      
         'Dim FE As SCFE9.Factura
         Dim FE As WSAFIPFE.Factura
         Dim FEx As WSAFIPFE.Factura

         If mWS = "WSFE" And (mvarTipoABC = "A" Or mvarTipoABC = "B") Then
            If Len(Trim(glbArchivoAFIP)) = 0 Then
               Me.MousePointer = vbDefault
               MsgBox "No ha definido el archivo con el certificado AFIP, ingrese a los datos de la empresa y registrelo", vbInformation
               Exit Sub
            End If

            mCodigoMoneda = 0
            Set oRs = Aplicacion.Monedas.TraerFiltrado("_PorId", dcfields(3).BoundText)
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("CodigoAFIP").Value) Then
                  If IsNumeric(oRs.Fields("CodigoAFIP").Value) Then
                     mCodigoMoneda = oRs.Fields("CodigoAFIP").Value
                  End If
               End If
            End If
            oRs.Close
            If mCodigoMoneda = 0 Then
               If dcfields(3).BoundText = glbIdMonedaPesos Then mCodigoMoneda = 1
               If dcfields(3).BoundText = glbIdMonedaDolar Then mCodigoMoneda = 2
               If dcfields(3).BoundText = glbIdMonedaEuro Then mCodigoMoneda = 60
            End If

            'Set FE = CreateObject("SCFE9.Factura")
            Set FE = CreateObject("WSAFIPFE.Factura")

            mResul = FE.ActivarLicenciaSiNoExiste(Replace(glbCuit, "-", ""), glbPathPlantillas & "\FE_" & Replace(glbCuit, "-", "") & ".lic", "pronto.wsfex@gmail.com", "bdlconsultores")
            If glbDebugFacturaElectronica Then
               MsgBox "ActivarLicencia : " & glbPathPlantillas & "\FE_" & Replace(glbCuit, "-", "") & ".lic" & " - UltimoMensajeError : " & FE.UltimoMensajeError
            End If
            
            mFecha = "" & Year(DTFields(0).Value) & Format(Month(DTFields(0).Value), "00") & Format(Day(DTFields(0).Value), "00")
            If mModoTest = "SI" Then
               mResul = FE.iniciar(0, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", "")
            Else
               'If Len(Dir(glbPathPlantillas & "\SCFE9.lic")) > 0 Then
                  'mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", glbPathPlantillas & "\SCFE9.lic")
                  mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", glbPathPlantillas & "\FE_" & Replace(glbCuit, "-", "") & ".lic")
               'Else
                  'mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", "")
               'End If
            End If
            If mResul Then mResul = FE.ObtenerTicketAcceso()
            With FE
               If glbDebugFacturaElectronica Then
                  MsgBox "ObtenerTicketAcceso : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError
                  mResul = .Dummy
                  MsgBox "Dummy : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError
               End If
               If mResul Then
                  .FECabeceraCantReg = 1
                  .FECabeceraPresta_serv = 1
                  .indice = 0
                  .FEDetalleFecha_vence_pago = mFecha
                  .FEDetalleFecha_serv_desde = mFecha
                  .FEDetalleFecha_serv_hasta = mFecha
                  .FEDetalleFecha_vence_pago = mFecha
                  .FEDetalleImp_neto = mvarSubTotal
                  .FEDetalleImp_total = mvarTotalNotaCredito
                  .FEDetalleFecha_cbte = mFecha
                  .FEDetalleNro_doc = Replace(txtCuit.Text, "-", "")
                  .FEDetalleTipo_doc = 80

                  If glbDebugFacturaElectronica Then
                     .ArchivoXMLEnviado = "C:\XMLEnviado.xml"
                     .ArchivoXMLRecibido = "C:\XMLRecibido.xml"
                  End If
                  
                  Randomize
                  mIdentificador = CLng(Rnd * 100000000)
                  If mvarTipoABC = "A" Then
                     mResul = .Registrar(dcfields(10).Text, 3, "" & mIdentificador)
                  Else
                     mResul = .Registrar(dcfields(10).Text, 8, "" & mIdentificador)
                  End If
                  If glbDebugFacturaElectronica Then
                     MsgBox "Registrar : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError & " - Motivo : " & .FERespuestaMotivo
                     'rchFacturaElectronica.Text = "Request : " & FE.XMLRequest & vbCrLf & vbCrLf & "Response : " & FE.XMLResponse
                  End If

                  If mResul Then
                     mCAE = .FERespuestaDetalleCae
                     mDescripcion = Chr(10) + "CAE: " + .FERespuestaDetalleCae + Chr(10) + "MOTIVO " + .FERespuestaDetalleMotivo + _
                                    Chr(10) + "PROCESO " + .FERespuestaReproceso + Chr(10) + "NUMERO: " + Str(.FERespuestaDetalleCbt_desde)
                     With origen.Registro
                        .Fields("CAE").Value = mCAE
                        .Fields("IdIdentificacionCAE").Value = mIdentificador
                        If IsDate(FE.FERespuestaDetalleFecha_vto) Then
                           .Fields("FechaVencimientoORechazoCAE").Value = FE.FERespuestaDetalleFecha_vto
                        End If
                        '.Fields("Observaciones").Value = .Fields("Observaciones").Value + Chr(10) + mDescripcion
                     End With
                  Else
                     Me.MousePointer = vbDefault
                     MsgBox "Error al obtener CAE : " + .UltimoMensajeError, vbExclamation
                     Exit Sub
                  End If
               Else
                  Me.MousePointer = vbDefault
                  MsgBox "Error al obtener CAE : " + .UltimoMensajeError, vbExclamation
                  Exit Sub
               End If
            End With
            Set FE = Nothing

         ElseIf mWS = "WSBFE" And (mvarTipoABC = "A" Or mvarTipoABC = "B") Then
            If Len(Trim(glbArchivoAFIP)) = 0 Then
               Me.MousePointer = vbDefault
               MsgBox "No ha definido el archivo con el certificado AFIP, ingrese a los datos de la empresa y registrelo", vbInformation
               Exit Sub
            End If

            If mvarTipoABC = "A" Then
               mTipoComprobante = 3
            Else
               mTipoComprobante = 8
            End If

            mCodigoMoneda = 0
            Set oRs = Aplicacion.Monedas.TraerFiltrado("_PorId", dcfields(3).BoundText)
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("CodigoAFIP").Value) Then
                  If IsNumeric(oRs.Fields("CodigoAFIP").Value) Then
                     mCodigoMoneda = oRs.Fields("CodigoAFIP").Value
                  End If
               End If
            End If
            oRs.Close
            If mCodigoMoneda = 0 Then
               If dcfields(3).BoundText = glbIdMonedaPesos Then mCodigoMoneda = 1
               If dcfields(3).BoundText = glbIdMonedaDolar Then mCodigoMoneda = 2
               If dcfields(3).BoundText = glbIdMonedaEuro Then mCodigoMoneda = 60
            End If

            'Set FE = CreateObject("SCFE9.Factura")
            Set FE = CreateObject("WSAFIPFE.Factura")

            mResul = FE.ActivarLicenciaSiNoExiste(Replace(glbCuit, "-", ""), glbPathPlantillas & "\FE_" & Replace(glbCuit, "-", "") & ".lic", "pronto.wsfex@gmail.com", "bdlconsultores")
            If glbDebugFacturaElectronica Then
               MsgBox "ActivarLicencia : " & glbPathPlantillas & "\FE_" & Replace(glbCuit, "-", "") & ".lic" & " - UltimoMensajeError : " & FE.UltimoMensajeError
            End If
            
            mFecha = "" & Year(DTFields(0).Value) & Format(Month(DTFields(0).Value), "00") & Format(Day(DTFields(0).Value), "00")
            If mModoTest = "SI" Then
               mResul = FE.iniciar(0, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", "")
            Else
               'If Len(Dir(glbPathPlantillas & "\SCFE9.lic")) > 0 Then
                  'mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", glbPathPlantillas & "\SCFE9.lic")
                  mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", glbPathPlantillas & "\FE_" & Replace(glbCuit, "-", "") & ".lic")
               'Else
                  'mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", "")
               'End If
            End If
            If mResul Then mResul = FE.bObtenerTicketAcceso()
            With FE
               If glbDebugFacturaElectronica Then
                  MsgBox "ObtenerTicketAcceso : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError
                  mResul = .Dummy
                  MsgBox "Dummy : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError
               End If
               If mResul Then
                  .bTipo_Doc = 80
                  .bNro_doc = Replace(txtCuit.Text, "-", "")
                  .bTipo_cbte = mTipoComprobante
                  .bPunto_vta = dcfields(10).Text
                  .bImp_total = mvarTotalNotaCredito
                  .bImp_neto = mvarSubTotal
                  .bimpto_liq = 0
                  .bimpto_liq_rni = 0
                  .bimp_op_ex = 0
                  .bImp_perc = Val(txtTotal(6).Text) + Val(txtTotal(7).Text) + Val(txtTotal(10).Text)
                  .bImp_iibb = mvarIBrutos + mvarIBrutos2 + mvarIBrutos3
                  .bImp_internos = 0
                  .bImp_moneda_id = mCodigoMoneda
                  .bImp_moneda_ctz = Val(txtCotizacionMoneda.Text)
                  .bFecha_cbte = mFecha
                  .bZona = 1

                  Set oRs = origen.DetNotasCredito.TodosLosRegistros
                  If oRs.Fields.Count > 0 Then
                     If oRs.RecordCount > 0 Then
                        mCantidadItem = 0
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           If oRs.Fields("Eliminado").Value <> "SI" Then mCantidadItem = mCantidadItem + 1
                           oRs.MoveNext
                        Loop
                        .bItemCantidad = mCantidadItem
                        mNumeroItem = 0
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           If oRs.Fields("Eliminado").Value <> "SI" Then
                              mDescripcion = ""
                              mNCM = ""
                              Set oRs1 = Aplicacion.Conceptos.TraerFiltrado("_PorIdConDatos", oRs.Fields("IdConcepto").Value)
                              If oRs1.RecordCount > 0 Then
                                 mDescripcion = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
                                 mNCM = IIf(IsNull(oRs1.Fields("CodigoAFIP").Value), "", oRs1.Fields("CodigoAFIP").Value)
                              End If
                              If Len(mNCM) = 0 Then mNCM = "99.99.99.99"
                              oRs1.Close
                              .bIndiceItem = mNumeroItem
                              .bITEMpro_codigo_sec = "0"
                              .bITEMpro_codigo_ncm = mNCM
                              .bITEMpro_ds = mDescripcion
                              .bITEMpro_precio_uni = oRs.Fields("Importe").Value
                              .bITEMpro_qty = 1
                              .bITEMpro_umed = 7
                              .bITEMIva_id = 1
                              .bITEMimp_total = oRs.Fields("Importe").Value
                              .bITEMimp_bonif = 0
                              mNumeroItem = mNumeroItem + 1
                           End If
                           oRs.MoveNext
                        Loop
                     End If
                  End If
                  Set oRs = Nothing

                  If glbDebugFacturaElectronica Then
                     .ArchivoXMLEnviado = "C:\XMLEnviado.xml"
                     .ArchivoXMLRecibido = "C:\XMLRecibido.xml"
                  End If
                  
                  Randomize
                  mIdentificador = CLng(Rnd * 100000000)
                  mResul = .bRegistrar(dcfields(10).Text, mTipoComprobante, "" & mIdentificador)
                  If glbDebugFacturaElectronica Then
                     MsgBox "Registrar : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError & " - Motivo : " & .FERespuestaMotivo
                     'rchFacturaElectronica.Text = "Request : " & FE.XMLRequest & vbCrLf & vbCrLf & "Response : " & FE.XMLResponse
                  End If

                  If mResul Then
                     mCAE = .bRespuestaCAE
                     mDescripcion = Chr(10) + "CAE: " + .bRespuestaCAE + Chr(10) + "REPROCESO " + .bRespuestaReproceso + _
                                    Chr(10) + "Evento " + .bEventMsg + Chr(10) + "Observacion: " + .bRespuestaOBS
                     With origen.Registro
                        .Fields("CAE").Value = mCAE
                        .Fields("IdIdentificacionCAE").Value = mIdentificador
                        If IsDate(FE.bRespuestaFch_venc_cae) Then
                           .Fields("FechaVencimientoORechazoCAE").Value = FE.bRespuestaFch_venc_cae
                        End If
                        '.Fields("Observaciones").Value = .Fields("Observaciones").Value + Chr(10) + mDescripcion
                     End With
                  Else
                     Me.MousePointer = vbDefault
                     MsgBox "Error al obtener CAE : " + .Permsg + "Detalle: " + .UltimoMensajeError, vbExclamation
                     Exit Sub
                  End If
               Else
                  Me.MousePointer = vbDefault
                  MsgBox "Error al obtener CAE : " + .Permsg + "Detalle: " + .UltimoMensajeError, vbExclamation
                  Exit Sub
               End If
            End With
            Set FE = Nothing
         
         ElseIf Len(mWS) > 0 And mvarTipoABC = "E" Then
            If Len(Trim(glbArchivoAFIP)) = 0 Then
               Me.MousePointer = vbDefault
               MsgBox "No ha definido el archivo con el certificado AFIP, ingrese a los datos de la empresa y registrelo", vbInformation
               Exit Sub
            End If

            mTipoComprobante = 21

            mCodigoMoneda1 = ""
            Set oRs = Aplicacion.Monedas.TraerFiltrado("_PorId", dcfields(3).BoundText)
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("CodigoAFIP").Value) Then
                  If IsNumeric(oRs.Fields("CodigoAFIP").Value) Then
                     mCodigoMoneda1 = oRs.Fields("CodigoAFIP").Value
                  End If
               End If
            End If
            oRs.Close
            If Len(mCodigoMoneda1) = 0 Then
               If dcfields(3).BoundText = glbIdMonedaPesos Then mCodigoMoneda1 = "PES"
               If dcfields(3).BoundText = glbIdMonedaDolar Then mCodigoMoneda1 = "DOL"
            End If

            Set oRs = Aplicacion.Clientes.TraerFiltrado("_PorIdConDatos", dcfields(0).BoundText)
            If oRs.RecordCount > 0 Then
               mPaisDestino = oRs.Fields("PaisCodigo2").Value
               mCuitPais = oRs.Fields("CuitPais").Value
               mCliente = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
               mDomicilio = IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value & " ") & _
                           IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value & " ") & _
                           IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value & " ") & _
                           IIf(IsNull(oRs.Fields("Pais").Value), "", oRs.Fields("Pais").Value)
            End If
            oRs.Close
            Set oRs = Nothing
            
            If Len(mPaisDestino) = 0 Then
               MsgBox "Para el registro electronico de la nota de credito, el pais del destinatario debe tener el codigo 2", vbExclamation
               Exit Sub
            End If
            If Len(mCuitPais) = 0 Then
               MsgBox "Para el registro electronico de la nota de credito, el pais del destinatario debe tener el cuit-pais", vbExclamation
               Exit Sub
            End If
            
            Set FEx = CreateObject("WSAFIPFE.Factura")

            mFecha = "" & Year(DTFields(0).Value) & Format(Month(DTFields(0).Value), "00") & Format(Day(DTFields(0).Value), "00")
            mResul = FEx.ActivarLicencia(Replace(glbCuit, "-", ""), glbPathPlantillas & "\FEX_" & Replace(glbCuit, "-", "") & ".lic", "pronto.wsfex@gmail.com", "bdlconsultores")
            If mModoTest = "SI" Then
               mResul = FEx.iniciar(0, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", "")
            Else
               If Len(Dir(glbPathPlantillas & "\SCFE9.lic")) > 0 Then
                  mResul = FEx.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", glbPathPlantillas & "\FEX_" & Replace(glbCuit, "-", "") & ".lic")
               Else
                  mResul = FEx.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", "")
               End If
            End If
            If mResul Then mResul = FEx.xObtenerTicketAcceso()
            With FEx
               If mResul Then
                  .xPunto_vta = dcfields(10).Text
                  .xFecha_cbte = mFecha
                  .xtipo_expo = 1
                  .xDst_cmp = mPaisDestino
                  '.xPermiso_existente = ""
                  .xPermiso_existente = ""
                  .xPermisoNoInformar = 1
                  .xCliente = mCliente
                  .xCuit_pais_clienteS = mCuitPais
                  .xDomicilio_cliente = mDomicilio
                  .xId_impositivo = ""
                  .xMoneda_id = mCodigoMoneda1
                  .xMoneda_ctz = Val(txtCotizacionMoneda.Text)
                  .xObs_comerciales = ""
                  .xImp_total = mvarTotalNotaCredito
                  .xForma_pago = "."
                  .xIncoTerms = "CIF"
                  .xIncoTerms_ds = ""
                  .xIdioma_cbte = 1

                  Set oRs = origen.DetNotasCredito.TodosLosRegistros
                  If oRs.Fields.Count > 0 Then
                     If oRs.RecordCount > 0 Then
                        mCantidadItem = 0
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           If oRs.Fields("Eliminado").Value <> "SI" Then mCantidadItem = mCantidadItem + 1
                           oRs.MoveNext
                        Loop
                        .xItemCantidad = mCantidadItem
                        mNumeroItem = 0
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           If oRs.Fields("Eliminado").Value <> "SI" Then
                              mDescripcion = ""
                              mNCM = ""
                              Set oRs1 = Aplicacion.Conceptos.TraerFiltrado("_PorIdConDatos", oRs.Fields("IdConcepto").Value)
                              If oRs1.RecordCount > 0 Then
                                 mDescripcion = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
                                 mNCM = IIf(IsNull(oRs1.Fields("CodigoAFIP").Value), "", oRs1.Fields("CodigoAFIP").Value)
                              End If
                              If Len(mNCM) = 0 Then mNCM = "99.99.99.99"
                              oRs1.Close
                              
                              mUnidadesCodigoAFIP = "7"
                              
                              .xIndiceItem = mNumeroItem
                              .xITEMPro_codigo = mNCM
                              .xITEMPro_ds = mDescripcion
                              .xITEMPro_qty = 1
                              .xITEMPro_umed = mUnidadesCodigoAFIP
                              .xITEMPro_precio_uni = oRs.Fields("Importe").Value
                              .xITEMPro_precio_item = oRs.Fields("Importe").Value
                              
                              mNumeroItem = mNumeroItem + 1
                           End If
                           oRs.MoveNext
                        Loop
                     End If
                  End If
                  Set oRs = Nothing

                  Randomize
                  mIdentificador = CLng(Rnd * 100000000)
                  mResul = .xRegistrar(dcfields(10).Text, mTipoComprobante, "" & mIdentificador)

                  If mResul Then
                     mCAE = .xRespuestaCAE
                     mDescripcion = Chr(10) + "CAE: " + .xRespuestaCAE + Chr(10) + "REPROCESO " + .xRespuestaReproceso + _
                                    Chr(10) + "Evento " + .xEventMsg + Chr(10) + "Observacion: " + .xRespuestaMotivos_obs
                     With origen.Registro
                        .Fields("CAE").Value = mCAE
                        .Fields("IdIdentificacionCAE").Value = mIdentificador
                        If IsDate(mId(FEx.xRespuestaFch_venc_cae, 7, 2) & "/" & mId(FEx.xRespuestaFch_venc_cae, 5, 2) & "/" & mId(FEx.xRespuestaFch_venc_cae, 1, 4)) Then
                           .Fields("FechaVencimientoORechazoCAE").Value = CDate(mId(FEx.xRespuestaFch_venc_cae, 7, 2) & "/" & mId(FEx.xRespuestaFch_venc_cae, 5, 2) & "/" & mId(FEx.xRespuestaFch_venc_cae, 1, 4))
                        End If
                     End With
                  Else
                     Me.MousePointer = vbDefault
                     MsgBox "Error al obtener CAE : " + .xerrmsg + "Detalle: " + .UltimoMensajeError, vbExclamation
                     Exit Sub
                  End If
               Else
                  Me.MousePointer = vbDefault
                  MsgBox "Error al obtener CAE : " + .xerrmsg + "Detalle: " + .UltimoMensajeError, vbExclamation
                  Exit Sub
               End If
            End With
            Set FEx = Nothing
         End If
         
         If mvarId < 0 Then
            If mCAEManual = "SI" Then
               mCAE = ""
               Set oF = New frm_Aux
               With oF
                  .Caption = "Ingresar numero de CAE"
                  With .Label2(0)
                     .Caption = "Numero de CAE :"
                     .Visible = True
                  End With
                  With .Text1
                     .Text = ""
                     .Top = oF.DTFields(0).Top
                     .Left = oF.DTFields(0).Left
                     .Width = .Width * 2
                  End With
                  With .Label1
                     .Caption = "Fecha vto. CAE :"
                     .Visible = True
                  End With
                  With .DTFields(0)
                     .Top = oF.Label1.Top
                     .Value = Date
                     .Visible = True
                  End With
                  .Width = .Width * 1.5
                  .Height = .Height * 0.7
                  .cmd(0).Top = .Label1.Top + .Label1.Height + 100
                  .cmd(0).Left = .Width / 2 - (.cmd(0).Width / 2)
                  .cmd(0).Height = .cmd(0).Height * 0.75
                  .cmd(1).Visible = False
                  .Show vbModal, Me
                  If .Ok Then
                     mCAE = Val(.Text1.Text)
                     mvarFechaVencimientoCAE = .DTFields(0).Value
                  End If
               End With
               Unload oF
               Set oF = Nothing
               If Len(mCAE) < 14 Then
                  Me.MousePointer = vbDefault
                  MsgBox "Debe ingresar el numero de CAE", vbExclamation
                  Exit Sub
               End If
               With origen.Registro
                  .Fields("CAE").Value = mCAE
                  .Fields("FechaVencimientoORechazoCAE").Value = mvarFechaVencimientoCAE
               End With
            End If
         
            If Option5.Value Then
               Dim oPto As ComPronto.PuntoVenta
               Set oPto = Aplicacion.PuntosVenta.Item(dcfields(10).BoundText)
               With oPto.Registro
                  mvarNumero = .Fields("ProximoNumero").Value
                  .Fields("ProximoNumero").Value = mvarNumero + 1
                  origen.Registro.Fields("NumeroNotaCredito").Value = mvarNumero
               End With
               oPto.Guardar
               Set oPto = Nothing
            Else
               Dim oPar1 As ComPronto.Parametro
               Set oPar1 = Aplicacion.Parametros.Item(1)
               With oPar1
                  With .Registro
                     .Fields("ProximaNotaCreditoInterna").Value = .Fields("ProximaNotaCreditoInterna").Value + 1
                  End With
                  .Guardar
               End With
               Set oPar1 = Nothing
            End If
         End If
         
         Select Case origen.Guardar
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El registro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
         'Recupero de gastos
         If mvarId < 0 And Check4.Value = 1 Then
            'ND Deudores
            Dim oPar As ComPronto.Parametro
            Set oPar = Aplicacion.Parametros.Item(1)
            With oPar
               With .Registro
                  mvarNumero = IIf(IsNull(.Fields("ProximaNotaDebitoInterna").Value), 1, .Fields("ProximaNotaDebitoInterna").Value)
                  .Fields("ProximaNotaDebitoInterna").Value = mvarNumero + 1
                  mIdCuentaIvaCompras = 0
                  For i = 1 To 10
                     If .Fields("IVAComprasPorcentaje" & i).Value = Val(txtPorcentajeIva1.Text) Then
                        mIdCuentaIvaCompras = .Fields("IdCuentaIvaCompras" & i).Value
                        Exit For
                     End If
                  Next
               End With
               .Guardar
            End With
            Set oPar = Nothing
            
            Dim oND As ComPronto.NotaDebito
            Set oND = Aplicacion.NotasDebito.Item(-1)
            With oND
               With .Registro
                  .Fields("NumeroNotaDebito").Value = mvarNumero
                  .Fields("IdCliente").Value = dcfields(0).BoundText
                  .Fields("FechaNotaDebito").Value = DTFields(0).Value
                  .Fields("TipoABC").Value = mvarTipoABC
                  .Fields("PuntoVenta").Value = 0
                  .Fields("ImporteTotal").Value = mvarTotalNotaCredito
                  .Fields("ImporteIva1").Value = mvarIVA1
                  .Fields("ImporteIva2").Value = mvarIVA2
                  .Fields("RetencionIBrutos1").Value = mvarIBrutos
                  .Fields("PorcentajeIBrutos1").Value = mvarPorcentajeIBrutos
                  .Fields("RetencionIBrutos2").Value = mvarIBrutos2
                  .Fields("PorcentajeIBrutos2").Value = mvarPorcentajeIBrutos2
                  .Fields("RetencionIBrutos3").Value = mvarIBrutos3
                  .Fields("PorcentajeIBrutos3").Value = mvarPorcentajeIBrutos3
                  .Fields("CotizacionDolar").Value = mvarCotizacion
                  .Fields("PorcentajeIva1").Value = Val(txtPorcentajeIva1.Text)
                  .Fields("PorcentajeIva2").Value = Val(txtPorcentajeIva2.Text)
                  .Fields("IdCodigoIva").Value = mvarTipoIVA
                  .Fields("CtaCte").Value = "SI"
                  .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text
                  .Fields("CotizacionDolar").Value = txtCotizacionDolar.Text
                  .Fields("OtrasPercepciones1").Value = Val(txtTotal(6).Text)
                  .Fields("OtrasPercepciones1Desc").Value = mvarOtrasPercepciones1Desc
                  .Fields("OtrasPercepciones2").Value = Val(txtTotal(7).Text)
                  .Fields("OtrasPercepciones2Desc").Value = mvarOtrasPercepciones2Desc
                  .Fields("OtrasPercepciones3").Value = Val(txtTotal(10).Text)
                  .Fields("OtrasPercepciones3Desc").Value = mvarOtrasPercepciones3Desc
                  .Fields("NumeroCAI").Value = 0
                  .Fields("IVANoDiscriminado").Value = mvarIVANoDiscriminado
                  .Fields("Observaciones").Value = "Recupero gastos"
                  .Fields("IdProvinciaDestino").Value = origen.Registro.Fields("IdProvinciaDestino").Value
                  .Fields("IdIBCondicion").Value = origen.Registro.Fields("IdIBCondicion").Value
                  If IsNumeric(dcfields(1).BoundText) Then
                     .Fields("IdObra").Value = dcfields(1).BoundText
                  End If
                  .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                  .Fields("FechaIngreso").Value = Now
                  .Fields("IdIBCondicion2").Value = origen.Registro.Fields("IdIBCondicion2").Value
                  .Fields("IdIBCondicion3").Value = origen.Registro.Fields("IdIBCondicion3").Value
                  .Fields("IdNotaCreditoVenta_RecuperoGastos").Value = origen.Registro.Fields(0).Value
               End With
               
               Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
               mIdConceptoRecuperoGastos = IIf(IsNull(oRs.Fields("IdConceptoRecuperoGastos").Value), 0, oRs.Fields("IdConceptoRecuperoGastos").Value)
               oRs.Close
               
               With .DetNotasDebito.Item(-1)
                  With .Registro
                     .Fields("IdConcepto").Value = mIdConceptoRecuperoGastos
                     .Fields("Importe").Value = mvarSubTotal
                     .Fields("IVANoDiscriminado").Value = mvarIVANoDiscriminado
                     If Val(txtPorcentajeIva1.Text) <> 0 Then
                        .Fields("Gravado").Value = "SI"
                     End If
                  End With
                  .Modificado = True
               End With
               
               .Guardar
            End With
            Set oND = Nothing
            
            'ND Proveedores
            Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorCuit", txtCuit.Text)
            mIdProveedor = 0
            mIdProvinciaDestino = 0
            If oRs.RecordCount > 0 Then
               mIdProveedor = oRs.Fields(0).Value
               mIdProvinciaDestino = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
            End If
            oRs.Close
            
            Set oRs = Aplicacion.Conceptos.TraerFiltrado("_PorIdConDatos", mIdConceptoRecuperoGastos)
            mIdCuenta = 0
            mCodigo = 0
            If oRs.RecordCount > 0 Then
               mIdCuenta = IIf(IsNull(oRs.Fields("IdCuenta").Value), 0, oRs.Fields("IdCuenta").Value)
               mCodigo = IIf(IsNull(oRs.Fields("Codigo").Value), 0, oRs.Fields("Codigo").Value)
            End If
            oRs.Close
            
            Dim oCP As ComPronto.ComprobanteProveedor
            Set oCP = Aplicacion.ComprobantesProveedores.Item(-1)
            With oCP
               With .Registro
                  .Fields("IdProveedor").Value = mIdProveedor
                  .Fields("IdTipoComprobante").Value = 19
                  .Fields("FechaComprobante").Value = DTFields(0).Value
                  .Fields("Letra").Value = mvarTipoABC
                  .Fields("NumeroComprobante1").Value = 0
                  .Fields("NumeroComprobante2").Value = mvarNumero
                  .Fields("FechaRecepcion").Value = DTFields(0).Value
                  .Fields("FechaVencimiento").Value = DTFields(0).Value
                  .Fields("TotalIva1").Value = mvarIVA1
                  .Fields("TotalIva2").Value = mvarIVA2
                  .Fields("TotalComprobante").Value = mvarTotalNotaCredito
                  .Fields("Observaciones").Value = "Recupero de gastos"
                  If IsNumeric(dcfields(1).BoundText) Then
                     .Fields("IdObra").Value = dcfields(1).BoundText
                  End If
                  .Fields("IdMoneda").Value = dcfields(3).BoundText
                  .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text
                  .Fields("CotizacionDolar").Value = txtCotizacionDolar.Text
                  .Fields("TotalIvaNoDiscriminado").Value = mvarIVANoDiscriminado
                  .Fields("AjusteIVA").Value = 0
                  .Fields("BienesOServicios").Value = "B"
                  .Fields("Confirmado").Value = "SI"
                  .Fields("NumeroCAI").Value = 0
                  .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                  .Fields("FechaIngreso").Value = Now
                  .Fields("IdCodigoIva").Value = mvarTipoIVA
                  .Fields("CotizacionEuro").Value = Cotizacion(DTFields(0).Value, glbIdMonedaEuro)
                  .Fields("IdNotaCreditoVenta_RecuperoGastos").Value = origen.Registro.Fields(0).Value
               End With
               With .DetComprobantesProveedores.Item(-1)
                  With .Registro
                     .Fields("IdCuenta").Value = mIdCuenta
                     .Fields("CodigoCuenta").Value = mCodigo
                     .Fields("Importe").Value = mvarTotalNotaCredito - (mvarIVA1 + mvarIVA2)
                     If (mvarIVA1 + mvarIVA2) <> 0 Then
                        .Fields("IdCuentaIvaCompras1").Value = mIdCuentaIvaCompras
                        .Fields("IVAComprasPorcentaje1").Value = Val(txtPorcentajeIva1.Text)
                        .Fields("ImporteIVA1").Value = (mvarIVA1 + mvarIVA2)
                        .Fields("AplicarIVA1").Value = "SI"
                     Else
                        .Fields("IVAComprasPorcentaje1").Value = 0
                        .Fields("ImporteIVA1").Value = 0
                        .Fields("AplicarIVA1").Value = "NO"
                     End If
                     .Fields("IVAComprasPorcentaje2").Value = 0
                     .Fields("ImporteIVA2").Value = 0
                     .Fields("AplicarIVA2").Value = "NO"
                     .Fields("IVAComprasPorcentaje3").Value = 0
                     .Fields("ImporteIVA3").Value = 0
                     .Fields("AplicarIVA3").Value = "NO"
                     .Fields("IVAComprasPorcentaje4").Value = 0
                     .Fields("ImporteIVA4").Value = 0
                     .Fields("AplicarIVA4").Value = "NO"
                     .Fields("IVAComprasPorcentaje5").Value = 0
                     .Fields("ImporteIVA5").Value = 0
                     .Fields("AplicarIVA5").Value = "NO"
                     .Fields("IVAComprasPorcentaje6").Value = 0
                     .Fields("ImporteIVA6").Value = 0
                     .Fields("AplicarIVA6").Value = "NO"
                     .Fields("IVAComprasPorcentaje7").Value = 0
                     .Fields("ImporteIVA7").Value = 0
                     .Fields("AplicarIVA7").Value = "NO"
                     .Fields("IVAComprasPorcentaje8").Value = 0
                     .Fields("ImporteIVA8").Value = 0
                     .Fields("AplicarIVA8").Value = "NO"
                     .Fields("IVAComprasPorcentaje9").Value = 0
                     .Fields("ImporteIVA9").Value = 0
                     .Fields("AplicarIVA9").Value = "NO"
                     .Fields("IVAComprasPorcentaje10").Value = 0
                     .Fields("ImporteIVA10").Value = 0
                     .Fields("AplicarIVA10").Value = "NO"
                     .Fields("IdProvinciaDestino1").Value = mIdProvinciaDestino
                     .Fields("PorcentajeProvinciaDestino1").Value = 100
                  End With
                  .Modificado = True
               End With
               .Guardar
            End With
            Set oCP = Nothing
         End If
         
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
            mvarGrabado = True
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "NotasCreditoTodas, NotasCreditoAgrupadas, +SubNC2"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
         Me.MousePointer = vbDefault
   
         mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de Nota de Credito")
         If mvarImprime = vbYes Then
            cmdImpre_Click 0
         End If
      
         Unload Me
      
      Case 1
         Unload Me

      Case 2
         AnularCredito
   End Select
   
   Set cALetra = Nothing
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim dtf As DTPicker
   Dim dc As DataCombo
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim oDet As ComPronto.DetNotaCredito
   Dim oDetImp As ComPronto.DetNotaCreditoImp
   Dim oDetOC As ComPronto.DetNotaCreditoOC
   Dim ListaVacia1 As Boolean, ListaVacia2 As Boolean, ListaVacia3 As Boolean
   
   mvarId = vnewvalue
   ListaVacia1 = False
   ListaVacia2 = False
   ListaVacia3 = False
   mvarModificacionHabilitada = False
   mIdDetalleOrdenCompra = 0
   
   If BuscarClaveINI("Consultar inclusion en cubos para comprobantes de venta") = "SI" Then Check3.Visible = True
   If BuscarClaveINI("Valor default inclusion en cubos de comprobantes de venta") = "SI" Then Check3.Value = 1
   If BuscarClaveINI("Activar recupero de gastos") = "SI" Then Check4.Visible = True
   mFiscal = BuscarClaveINI("Impresora fiscal")
   If BuscarClaveINI("Habilitar modificacion tipo de iva en comprobantes de venta") = "SI" Then
      Me.txtCondicionIva.Visible = False
      With dcfields(11)
         .Left = Me.txtCondicionIva.Left
         .Top = Me.txtCondicionIva.Top
         .Width = Me.txtCondicionIva.Width
         .Visible = True
      End With
   End If
   
   Set oAp = Aplicacion
   Set origen = oAp.NotasCredito.Item(vnewvalue)
   
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
      mIdMonedaPesos = .Fields("IdMoneda").Value
      mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
      mvarPercepcionIIBB = IIf(IsNull(.Fields("PercepcionIIBB").Value), "NO", .Fields("PercepcionIIBB").Value)
      mvarOtrasPercepciones1 = IIf(IsNull(.Fields("OtrasPercepciones1").Value), "NO", .Fields("OtrasPercepciones1").Value)
      mvarOtrasPercepciones1Desc = IIf(IsNull(.Fields("OtrasPercepciones1Desc").Value), "", .Fields("OtrasPercepciones1Desc").Value)
      mvarOtrasPercepciones2 = IIf(IsNull(.Fields("OtrasPercepciones2").Value), "NO", .Fields("OtrasPercepciones2").Value)
      mvarOtrasPercepciones2Desc = IIf(IsNull(.Fields("OtrasPercepciones2Desc").Value), "", .Fields("OtrasPercepciones2Desc").Value)
      mvarOtrasPercepciones3 = IIf(IsNull(.Fields("OtrasPercepciones3").Value), "NO", .Fields("OtrasPercepciones3").Value)
      mvarOtrasPercepciones3Desc = IIf(IsNull(.Fields("OtrasPercepciones3Desc").Value), "", .Fields("OtrasPercepciones3Desc").Value)
      mvarNumeracionUnica = False
      If .Fields("NumeracionUnica").Value = "SI" Then mvarNumeracionUnica = True
      gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)
   End With
   oRs.Close
   
   If mvarId < 0 Then
      origen.Registro.Fields("FechaNotaCredito").Value = 1
      mvarIdCliente = 0
      mvarTipoABC = "A"
   Else
      mvarIdCliente = origen.Registro.Fields("IdCliente").Value
   End If
   
   mvarAnulada = "NO"
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetNotasCredito.TraerMascara
                     ListaVacia1 = True
                  Else
                     Set oRs = origen.DetNotasCredito.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                     Else
                        Set oControl.DataSource = origen.DetNotasCredito.TraerMascara
                        ListaVacia1 = True
                     End If
                     While Not oRs.EOF
                        Set oDet = origen.DetNotasCredito.Item(oRs.Fields(0).Value)
                        oDet.Modificado = True
                        Set oDet = Nothing
                        oRs.MoveNext
                     Wend
                     oRs.Close
                  End If
               Case "ListaImp"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetNotasCreditoImp.TraerMascara
                     ListaVacia2 = True
                  Else
                     Set oRs = origen.DetNotasCreditoImp.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                     Else
                        Set oControl.DataSource = origen.DetNotasCreditoImp.TraerMascara
                        ListaVacia2 = True
                     End If
                     While Not oRs.EOF
                        Set oDetImp = origen.DetNotasCreditoImp.Item(oRs.Fields(0).Value)
                        Set oDetImp = Nothing
                        oRs.MoveNext
                     Wend
                     oRs.Close
                  End If
               Case "ListaOC"
                  If mvarId < 0 Then
                     Set oControl.DataSource = origen.DetNotasCreditoOC.TraerMascara
                     ListaVacia3 = True
                  ElseIf mvarId < -1 Then
                     Set oRs = origen.DetNotasCreditoOC.Registros
                     If oRs.RecordCount > 0 Then
                        oRs.MoveFirst
                        mIdDetalleOrdenCompra = oRs.Fields("IdDetalleOrdenCompra").Value
                     End If
                     Set oRs = Nothing
                     If mIdDetalleOrdenCompra <> 0 Then
                        Set oControl.DataSource = oAp.OrdenesCompra.TraerFiltrado("_DetallesPendientesDeFacturarPorIdDetalleOrdenCompra", mIdDetalleOrdenCompra)
                        For Each oL In ListaOC.ListItems
                           oL.Checked = True
                        Next
                     Else
                        Set oControl.DataSource = origen.DetNotasCreditoOC.TraerMascara
                        ListaVacia3 = True
                     End If
                  Else
                     Set oRs = origen.DetNotasCreditoOC.TraerTodos
                     If oRs.RecordCount > 0 Then
                        oRs.MoveFirst
                        OC_Elegida = True
                     End If
                     Set oControl.DataSource = oRs
                     If OC_Elegida Then
                        For Each oL In ListaOC.ListItems
                           oL.Checked = True
                        Next
                     End If
                     While Not oRs.EOF
                        Set oDetOC = origen.DetNotasCreditoOC.Item(oRs.Fields(0).Value)
                        oDetOC.Modificado = True
                        Set oDetOC = Nothing
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
               If oControl.Tag = "PuntosVenta" Then
                  Set oControl.RowSource = oAp.PuntosVenta.TraerFiltrado("_PuntosVentaTodos")
               ElseIf oControl.Tag = "Obras" Then
                  If glbSeñal1 Then
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", Date))
                  Else
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo")
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
   
   If mvarId < 0 Then
      mvarCotizacion = Cotizacion(Date, glbIdMonedaDolar)
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      With origen.Registro
         .Fields("IdMoneda").Value = mIdMonedaPesos
      End With
      Lista.ListItems.Clear
      ListaImp.ListItems.Clear
      mvarGrabado = False
      txtPorcentajeIva1.Text = mvarP_IVA1
      txtPorcentajeIva2.Text = mvarP_IVA2
      Option5.Value = True
      Check2.Value = 1
      mvarCotizacion = Cotizacion(Date, glbIdMonedaDolar)
      txtCotizacionDolar.Text = mvarCotizacion
   Else
      With origen.Registro
         If Not IsNull(.Fields("CotizacionDolar").Value) Then
            mvarCotizacion = .Fields("CotizacionDolar").Value
         Else
            mvarCotizacion = Cotizacion(Date, glbIdMonedaDolar)
         End If
         txtPorcentajeIva1.Text = .Fields("PorcentajeIva1").Value
         txtPorcentajeIva2.Text = .Fields("PorcentajeIva2").Value
         If (IsNull(.Fields("CtaCte").Value) Or .Fields("CtaCte").Value = "SI") And _
               IsNull(.Fields("IdFacturaVenta_RecuperoGastos").Value) Then
            Option5.Value = True
         Else
            Option6.Value = True
         End If
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
            With lblEstado
               .Caption = "ANULADA"
               .Visible = True
            End With
            mvarAnulada = "SI"
         End If
         If IsNull(.Fields("AplicarEnCtaCte").Value) Or .Fields("AplicarEnCtaCte").Value = "SI" Then
            Check2.Value = 1
         Else
            Check2.Value = 0
         End If
         If Not IsNull(.Fields("NoIncluirEnCubos").Value) And .Fields("NoIncluirEnCubos").Value = "SI" Then
            Check3.Value = 1
         Else
            Check3.Value = 0
         End If
         If Not IsNull(.Fields("ActivarRecuperoGastos").Value) And .Fields("ActivarRecuperoGastos").Value = "SI" Then
            Check4.Value = 1
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      
         If mvarNumeracionUnica Then
            Set dcfields(10).RowSource = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, .Fields("TipoABC").Value))
         Else
            Set dcfields(10).RowSource = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(4, .Fields("TipoABC").Value))
         End If
         dcfields(10).BoundText = .Fields("IdPuntoVenta").Value
         If Not IsNull(.Fields("CAE").Value) Then
            rchObservaciones.Height = rchObservaciones.Height - lblCAE.Height
            lblCAE.Caption = "CAE : " & .Fields("CAE").Value
            With lblCAE
               .Top = rchObservaciones.Top + rchObservaciones.Height
               .Left = rchObservaciones.Left
               .Width = rchObservaciones.Width
               .Visible = True
            End With
         End If
         If IsNull(.Fields("FechaRecepcionCliente").Value) Then
            .Fields("FechaRecepcionCliente").Value = .Fields("FechaNotaCredito").Value
            DTFields(1).Value = .Fields("FechaNotaCredito").Value
         End If
      End With
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is Label Then
         ElseIf TypeOf oControl Is RichTextBox Then
            oControl.Enabled = False
         ElseIf TypeOf oControl Is DataCombo Then
            oControl.Enabled = False
         ElseIf TypeOf oControl Is TextBox Then
            oControl.Enabled = False
         ElseIf TypeOf oControl Is OptionButton Then
            oControl.Enabled = False
         ElseIf TypeOf oControl Is CheckBox Then
            oControl.Enabled = False
         ElseIf TypeOf oControl Is DTPicker Then
            oControl.Enabled = False
         End If
      Next
      dcfields(1).Enabled = True
'      dcfields(5).Enabled = True
      Check3.Enabled = True
      rchObservaciones.Enabled = True
      mvarGrabado = True
      If InStr(1, BuscarClaveINI("Usuarios habilitados para modificacion de datos en comprobantes de venta"), "(" & glbIdUsuario & ")") > 0 Then
         mvarModificacionHabilitada = True
         dcfields(10).Enabled = True
         txtNumeroNotaCredito.Enabled = True
         DTFields(0).Enabled = True
         DTFields(1).Enabled = True
      End If
      
      CalculaNotaCredito
   End If
   
   If mvarPercepcionIIBB = "SI" Or origen.Registro.Fields("RetencionIBrutos1").Value <> 0 Then
      lblPercIBB.Visible = True
      With txtTotal(5)
         .Text = origen.Registro.Fields("RetencionIBrutos1").Value
         .Visible = True
      End With
   End If
   
   If mvarOtrasPercepciones1 = "SI" Or origen.Registro.Fields("OtrasPercepciones1").Value <> 0 Then
      With lblOtrasPercepciones1
         .Caption = mvarOtrasPercepciones1Desc & " :"
         .Visible = True
      End With
      With txtTotal(6)
         .Text = origen.Registro.Fields("OtrasPercepciones1").Value
         .Visible = True
      End With
   End If
   
   If mvarOtrasPercepciones2 = "SI" Or origen.Registro.Fields("OtrasPercepciones2").Value <> 0 Then
      With lblOtrasPercepciones2
         .Caption = mvarOtrasPercepciones2Desc & " :"
         .Visible = True
      End With
      With txtTotal(7)
         .Text = origen.Registro.Fields("OtrasPercepciones2").Value
         .Visible = True
      End With
   End If
   
   If mvarOtrasPercepciones3 = "SI" Or origen.Registro.Fields("OtrasPercepciones3").Value <> 0 Then
      With lblOtrasPercepciones3
         .Caption = mvarOtrasPercepciones3Desc & " :"
         .Visible = True
      End With
      With txtTotal(10)
         .Text = origen.Registro.Fields("OtrasPercepciones3").Value
         .Visible = True
      End With
   End If
   
   If ListaVacia1 Then Lista.ListItems.Clear
   If ListaVacia2 Then ListaImp.ListItems.Clear
   If ListaVacia3 Then ListaOC.ListItems.Clear
   
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
      If DTFields(0).Value <= gblFechaUltimoCierre And Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
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
   
'   If Len(mFiscal) > 0 Then
'      If mId(mFiscal, 1, 2) = "EP" Then
'         ImpresionNCControladorE
'      Else
'         'ImpresionNCControladorH
'      End If
'      Exit Sub
'   End If
   
   Dim mPlantilla As String, mCampo As String, mvarConfirmarClausulaDolar As String
   Dim mvarClausula As Boolean, mOk As Boolean
   Dim oRs As ADOR.Recordset
   
   mPlantilla = "N/A"
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   If oRs.RecordCount > 0 Then
      mCampo = "Plantilla_NotasCredito_" & IIf(mvarTipoABC = "C" Or mvarTipoABC = "M", "A", mvarTipoABC)
      If Not IsNull(oRs.Fields(mCampo).Value) And Len(oRs.Fields(mCampo).Value) > 0 Then mPlantilla = oRs.Fields(mCampo).Value
      mvarConfirmarClausulaDolar = IIf(IsNull(oRs.Fields("ConfirmarClausulaDolar").Value), "NO", oRs.Fields("ConfirmarClausulaDolar").Value)
   End If
   oRs.Close
   Set oRs = Nothing
   
   If Not IsNull(origen.Registro.Fields("CAE").Value) Then
      mPlantilla = mId(mPlantilla, 1, Len(mPlantilla) - 4) & "_NCE" & mId(mPlantilla, Len(mPlantilla) - 3, 4)
   End If
   
   If Not Len(Trim(Dir(glbPathPlantillas & "\" & mPlantilla))) <> 0 Then
      MsgBox "No existe la plantilla de impresion, definala en la tabla de parametros.", vbExclamation
      Exit Sub
   End If
   
   If mvarConfirmarClausulaDolar = "SI" Then
      Dim oF1 As frm_Aux
      Set oF1 = New frm_Aux
      With oF1
         .Caption = "Emision de nota de credito"
         .Label1.Visible = False
         .Text1.Visible = False
         With .Frame1
            .Caption = "Emite clausula dolar ? : "
            .Top = oF1.Label1.Top
            .Visible = True
         End With
         .Option1.Caption = "SI"
         .Option1.Value = True
         .Option2.Caption = "NO"
         .Show vbModal, Me
         mOk = .Ok
         mvarClausula = .Option1.Value
      End With
      Unload oF1
      Set oF1 = Nothing
      Me.Refresh
      If Not mOk Then Exit Sub
   End If
   
   Dim mCopias As Integer
   Dim mPrinter As String, mPrinterAnt As String
   
   mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
   If Index = 0 Then
      mCopias = Val(BuscarClaveINI("CopiasNotasCredito", -1))
      If mCopias = 0 Then mCopias = 1
      
      Dim oF As frmImpresion
      Set oF = New frmImpresion
      With oF
         .txtCopias.Text = mCopias
         .Show vbModal, Me
      End With
      mOk = oF.Ok
      mCopias = Val(oF.txtCopias.Text)
      mPrinter = oF.Combo1.Text
      Unload oF
      Set oF = Nothing
      If Not mOk Then Exit Sub
   Else
      mCopias = 1
   End If
   
   Dim oW As Word.Application
   Dim mPID As String
      
   On Error GoTo Mal
   
   If Index = 0 Then CargaProcesosEnEjecucion
   Set oW = CreateObject("Word.Application")
   If Index = 0 Then mPID = ObtenerPIDProcesosLanzados
   
   With oW
      .Visible = True
      .Documents.Add (glbPathPlantillas & "\" & mPlantilla)
      .Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId, _
            varg3:=mvarClausula, varg4:=mPrinter, varg5:=mCopias
      If Index = 0 Then
         oW.Documents(1).Close False
         If glbTerminarProcesosOffice Then
            TerminarProceso mPID
         Else
            oW.Quit
         End If
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

   Dim oF As frmDetNotasCreditoProvincias
   
   VerificarProvinciasDestino
   
   Set oF = New frmDetNotasCreditoProvincias
   With oF
      Set .NotaCredito = origen
      .Show vbModal, Me
   End With
   Unload oF
   Set oF = Nothing

End Sub

Private Sub dcfields_Change(Index As Integer)
      
   If IsNumeric(dcfields(Index).BoundText) Then
      If Len(dcfields(Index).DataField) > 0 Then origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
      Select Case Index
         Case 0
            MostrarDatos (0)
         Case 2
            If IsNumeric(dcfields(2).BoundText) Then
               origen.Registro.Fields("IdVendedor").Value = dcfields(2).BoundText
            End If
         Case 3
            If dcfields(Index).BoundText = 1 Then
               txtCotizacionMoneda.Text = 1
            Else
               Dim oRs As ADOR.Recordset
               Set oRs = Aplicacion.Cotizaciones.TraerFiltrado("_PorFechaMoneda", Array(DTFields(0).Value, dcfields(Index).BoundText))
               If oRs.RecordCount > 0 Then
                  txtCotizacionMoneda.Text = oRs.Fields("CotizacionLibre").Value
               Else
                  MsgBox "No hay cotizacion, ingresela manualmente"
                  txtCotizacionMoneda.Text = ""
               End If
               oRs.Close
               Set oRs = Nothing
            End If
         Case 10
            If mvarId <= 0 Then
               Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(Index).BoundText)
               If oRs.RecordCount > 0 Then
                  origen.Registro.Fields("NumeroNotaCredito").Value = oRs.Fields("ProximoNumero").Value
                  txtNumeroNotaCredito.Text = oRs.Fields("ProximoNumero").Value
               End If
               oRs.Close
            End If
         Case 11
            mvarTipoIVA = dcfields(Index).BoundText
            CalculaNotaCredito
      End Select
   End If
   
End Sub

Private Sub dcfields_GotFocus(Index As Integer)

   SendKeys "%{DOWN}"
   
End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub dcfields_LostFocus(Index As Integer)

   If Index = 0 Then
      If mvarId <= 0 And IsNumeric(dcfields(0).BoundText) And IsNumeric(dcfields(0).BoundText) And Not ListaOC Is Nothing And ListaOC.Visible Then
         ListaOC.Sorted = False
         Set ListaOC.DataSource = Aplicacion.OrdenesCompra.TraerFiltrado("_PorIdClienteTodosParaCredito", Array(dcfields(0).BoundText, mvarId))
         ListaOC.Refresh
         OC_Elegida = False
      End If
   End If

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub DTFields_Validate(Index As Integer, Cancel As Boolean)

   If glbSeñal1 And Index = 0 Then
      Dim mIdObra As Long
      mIdObra = 0
      If IsNumeric(dcfields(1).BoundText) Then mIdObra = dcfields(1).BoundText
      Set dcfields(1).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", DTFields(0).Value))
      dcfields(1).BoundText = mIdObra
   End If

End Sub

Private Sub Form_Activate()
   
'   If mvarCotizacion = 0 Then
'      Me.Refresh
'      MsgBox "No hay cotizacion, ingresela primero", vbExclamation
'      Unload Me
'   End If
   
   If Not origen Is Nothing Then CalculaNotaCredito
   
'   lblIVA1.Caption = "IVA " & Format(mvarP_IVA1, "##0.00") & " %"
'   lblIVA2.Caption = "IVA " & Format(mvarP_IVA2, "##0.00") & " %"
   
'   mvarPuntoVenta = mvarPuntoVentaDefault

End Sub

Private Sub Form_Load()

   Dim oRs As ADOR.Recordset
   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaImp
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaOC
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
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

Private Sub Lista_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single)

   Dim s, mvarConcepto, mvarConIVA As String
   Dim iFilas As Long, iColumnas As Long, i As Long, idDet As Long
   Dim mvarIdConceptoDiferenciaCambio As Long, mvarIdImputacion As Long
   Dim mvarTipoIVA1 As Integer
   Dim mvarImporte As Double, mvarImporteIVA As Double, mvarImporteTotal As Double
   Dim oL As ListItem
   Dim Filas
   Dim Columnas
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then ' si el dato es texto
      On Error GoTo Mal
      s = Data.GetData(ccCFText) ' tomo el dato
      Filas = Split(s, vbCrLf) ' armo un vector por filas
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 1), "Codigo") <> 0 Then
         If UBound(Filas) > 1 Then
            MsgBox "No puede arrastrar mas de una diferencia de cambio", vbCritical
            Exit Sub
         End If
         
         Set oAp = Aplicacion
         Set oRs = oAp.Parametros.Item(1).Registro
         mvarIdConceptoDiferenciaCambio = 0
         mvarConcepto = ""
         If Not IsNull(oRs.Fields("IdConceptoDiferenciaCambio").Value) Then
            mvarIdConceptoDiferenciaCambio = oRs.Fields("IdConceptoDiferenciaCambio").Value
            mvarConcepto = oAp.Conceptos.Item(mvarIdConceptoDiferenciaCambio).Registro.Fields("Descripcion").Value
         End If
         oRs.Close
         
         Columnas = Split(Filas(1), vbTab)
         
         mvarImporte = CDbl(Columnas(13))
         If mvarImporte > 0 Then
            MsgBox "La diferencia de cambio debe ser menor a cero," & vbCrLf & _
                  "para este caso debe hacer una nota de debito", vbExclamation
            GoTo Mal
         End If
         mvarImporte = mvarImporte * -1
         mvarImporteTotal = mvarImporte
         
         Set oRs = oAp.DiferenciasCambio.TraerFiltrado("_DatosDelComprobantePorCobranza", Columnas(0))
         If oRs.RecordCount > 0 Then
            mvarIdImputacion = IIf(IsNull(oRs.Fields("IdImputacion").Value), 0, oRs.Fields("IdImputacion").Value)
         End If
         oRs.Close
         
         If mvarIdImputacion = 0 Then
            MsgBox "Comprobante de diferencia de cambio no encontrado", vbExclamation
            GoTo Mal
         End If
         
         Set oRs = origen.DetNotasCreditoImp.TodosLosRegistros
         If oRs.Fields.Count > 0 Then
            If oRs.RecordCount > 0 Then
               oRs.MoveFirst
               Do While Not oRs.EOF
                  If oRs.Fields("IdImputacion").Value = mvarIdImputacion Then
                     MsgBox "Comprobante ya ingresado en esta nota de credito", vbExclamation
                     GoTo Mal
                  End If
                  oRs.MoveNext
               Loop
               Set oRs = Nothing
            End If
         End If

         Set oRs = oAp.Clientes.Item(Columnas(20)).Registro
         If oRs.RecordCount > 0 Then
            mvarTipoIVA1 = IIf(IsNull(oRs.Fields("IdCodigoIva").Value), 0, oRs.Fields("IdCodigoIva").Value)
            mvarConIVA = "NO"
            Select Case mvarTipoIVA1
               Case 1, 2
                  mvarConIVA = "SI"
               Case 3
            End Select
            If mvarConIVA = "SI" Then
               mvarImporte = Round(mvarImporte / (1 + (Val(txtPorcentajeIva1.Text) / 100)), 2)
               mvarImporteIVA = Round(mvarImporte * Val(txtPorcentajeIva1.Text) / 100, 2)
               mvarImporteTotal = mvarImporte + mvarImporteIVA
            End If
         End If
         oRs.Close
         
         With origen.Registro
            .Fields("IdCliente").Value = Columnas(20)
         End With
         
         With origen.DetNotasCredito.Item(-1)
            .Registro.Fields("IdConcepto").Value = mvarIdConceptoDiferenciaCambio
            .Registro.Fields("Importe").Value = mvarImporte
            .Registro.Fields("Gravado").Value = mvarConIVA
            .Registro.Fields("IdDiferenciaCambio").Value = Columnas(21)
            .Modificado = True
            idDet = .Id
         End With
         Set oL = Lista.ListItems.Add
         oL.Tag = idDet
         With oL
            .SmallIcon = "Nuevo"
            .Text = mvarConcepto
            .SubItems(2) = mvarConIVA
            .SubItems(3) = "" & Format(mvarImporte, "#,##0.00")
            .Selected = True
         End With
         
         With origen.DetNotasCreditoImp.Item(-1)
            .Registro.Fields("IdImputacion").Value = mvarIdImputacion
            .Registro.Fields("Importe").Value = mvarImporteTotal
            .Modificado = True
         End With
         
         Set oRs = origen.DetNotasCreditoImp.RegistrosConFormato
         Set ListaImp.DataSource = oRs
         
         Set oRs = Nothing
         
         txtCotizacionDolar.Text = 0
         CalculaNotaCredito
         DoEvents
         
         If mvarIBrutos <> 0 Or mvarIBrutos2 <> 0 Then
            mvarImporte = mvarImporte - Round((mvarIBrutos + mvarIBrutos2) / _
                              (1 + (Val(txtPorcentajeIva1.Text) / 100)), 2)
            With origen.DetNotasCredito.Item(idDet)
               .Registro.Fields("Importe").Value = mvarImporte
            End With
            Lista.SelectedItem.SubItems(3) = "" & Format(mvarImporte, "#,##0.00")
            CalculaNotaCredito
         End If
         Clipboard.Clear
      Else
         MsgBox "Objeto invalido!"
      End If
   End If
   
Mal:
   Set oRs = Nothing
   Set oAp = Nothing
            
End Sub

Private Sub Lista_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single, State As Integer)

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

Private Sub ListaImp_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaOC_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaOC_ItemCheck(ByVal Item As MSComctlLib.IListItem)

   If mvarId <= 0 Then
      If Item.Checked Then
         If IsNumeric(Item.ListSubItems(1)) Then
            
            Dim oRs As ADOR.Recordset
            Dim mAlicuotaIVA_Material As Double
            Dim oF As frmDetNotasCreditoOC
            
            mIdDetalleOrdenCompra = Item.ListSubItems(1)
            
            Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_DetallePorIdDetalle", mIdDetalleOrdenCompra)
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  .Fields("IdMoneda").Value = oRs.Fields("IdMoneda").Value
                  .Fields("IdObra").Value = oRs.Fields("IdObra").Value
               End With
               If Not IsNull(oRs.Fields("AlicuotaIVA").Value) Then
                  mvarP_IVA1 = oRs.Fields("AlicuotaIVA").Value
               End If
               If IsNumeric(Item.ListSubItems(12)) Then
                  Set oF = New frmDetNotasCreditoOC
                  With oF
                     If Val(Item.ListSubItems(13)) = 1 Then
                        .lblLabels(0).Caption = "Cantidad a acreditar :"
                     Else
                        .lblLabels(0).Caption = "Porcentaje a acreditar :"
                     End If
                     .txtValor.Text = Item.ListSubItems(15)
                     .Show vbModal, Me
                     If .Ok Then
                        Item.ListSubItems(15) = .txtValor.Text
                        Item.ListSubItems(17) = Val(Item.ListSubItems(12)) + .txtValor.Text
                        If Val(Item.ListSubItems(13)) = 1 Then
                           Item.ListSubItems(14) = "" & Format(.txtValor.Text, "#,##0.00")
                           Item.ListSubItems(16) = "" & Format(Item.ListSubItems(17), "#,##0.00")
                        Else
                           Item.ListSubItems(14) = "" & Format(.txtValor.Text, "#,##0.00") & " %"
                           Item.ListSubItems(16) = "" & Format(Item.ListSubItems(17), "#,##0.00") & " %"
                        End If
                     Else
                        If Val(Item.ListSubItems(13)) = 1 Then
                           Item.ListSubItems(14) = "0.00"
                        Else
                           Item.ListSubItems(14) = "0.00 %"
                        End If
                        Item.ListSubItems(15) = 0
                        Item.ListSubItems(16) = Item.ListSubItems(11)
                        Item.ListSubItems(17) = Item.ListSubItems(12)
                        Item.Checked = False
                     End If
                  End With
                  Unload oF
                  Set oF = Nothing
               End If
            End If
            oRs.Close
            Set oRs = Nothing
            CalculaNotaCredito
         End If
      Else
         If Val(Item.ListSubItems(13)) = 1 Then
            Item.ListSubItems(14) = "0.00"
         Else
            Item.ListSubItems(14) = "0.00 %"
         End If
         Item.ListSubItems(15) = 0
         Item.ListSubItems(16) = Item.ListSubItems(11)
         Item.ListSubItems(17) = Item.ListSubItems(12)
      End If
   Else
      MsgBox "No puede modificar una NC ya registrada", vbExclamation
      Item.Checked = True
   End If
   
End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         Editar Lista.SelectedItem.Tag
      Case 2
         If mvarId > 0 Then
            MsgBox "No puede modificar un NotaCredito ya registrado!", vbCritical
            Exit Sub
         End If
         With Lista.SelectedItem
            origen.DetNotasCredito.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         CalculaNotaCredito
   End Select

End Sub

Private Sub Listaimp_DblClick()

   If ListaImp.ListItems.Count = 0 Then
      EditarImputacion -1
   Else
      If Len(Trim(ListaImp.SelectedItem.Tag)) > 0 Then EditarImputacion ListaImp.SelectedItem.Tag
   End If

End Sub

Private Sub ListaImp_KeyUp(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyDelete Then
      MnuDetB_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetB_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetB_Click 1
   End If

End Sub

Private Sub ListaImp_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)

   If Button = vbRightButton Then
      If ListaImp.ListItems.Count = 0 Then
         MnuDetB(1).Enabled = False
         MnuDetB(2).Enabled = False
         PopupMenu MnuDetImp, , , , MnuDetB(0)
      Else
         MnuDetB(1).Enabled = True
         MnuDetB(2).Enabled = True
         PopupMenu MnuDetImp, , , , MnuDetB(1)
      End If
   End If

End Sub

Private Sub MnuDetB_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarImputacion -1
      Case 1
         EditarImputacion ListaImp.SelectedItem.Tag
      Case 2
         If mvarId > 0 Then
            MsgBox "No puede modificar una Nota de credito ya registrada!", vbCritical
            Exit Sub
         End If
         With ListaImp.SelectedItem
            origen.DetNotasCreditoImp.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         CalculaNotaCredito
      Case 3
         If Not ListaImp.SelectedItem Is Nothing Then
            EditarImporte ListaImp.SelectedItem.Tag
            CalculaNotaCredito
         End If
      Case 4
         AgregarAnticipo
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
   Set oBind = Nothing
   
End Sub

Private Sub CalculaNotaCredito()

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim oL As ListItem
   Dim i As Integer, mIdProvinciaIIBB As Integer, mIdProvinciaRealIIBB As Integer
   Dim TSumaGravado As Double, TSumaNoGravado As Double, mTopeIIBB As Double, mImporteItem As Double
   Dim mvarIVANoDiscriminadoItem As Double
   Dim mCodigoProvincia As String, mPuntoVentaActivo As String
   Dim mFecha1 As Date
   
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
   mvarIVA1 = 0
   mvarIVA2 = 0
   mvarTotalNotaCredito = 0
   mvarTotalImputaciones = 0
   mvarIVANoDiscriminado = 0
   mvarPercepcionIVA = 0
   mPuntoVentaActivo = ""
   
   Set oRs = origen.DetNotasCreditoImp.TodosLosRegistros
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If Not oRs.Fields("Eliminado").Value Then
               mvarTotalImputaciones = mvarTotalImputaciones + oRs.Fields("Importe").Value
            End If
            oRs.MoveNext
         Loop
      End If
      oRs.Close
   End If
   Set oRs = Nothing
   
   TSumaGravado = origen.DetNotasCredito.SumaImporteGravado
   TSumaNoGravado = origen.DetNotasCredito.SumaImporteNoGravado
   mvarSubTotal = TSumaGravado + TSumaNoGravado
   
'   If mvarIBrutosC = "S" And Option1.Value And mvarPorc_IBrutos_Cap <> 0 And mvarSubTotal > mvarTope_IBrutos_Cap Then
'      mvar_IBrutos_Cap = Round(mvarPorc_IBrutos_Cap * mvarSubTotal / 100, mvarDecimales)
'   End If
'
'   If mvarIBrutosB = "S" And Option2.Value Then
'      If mvarMultilateral = "S" Then
'         If mvarPorc_IBrutos_BsAs <> 0 And mvarSubTotal > mvarTope_IBrutos_BsAs Then
'            mvar_IBrutos_BsAs = Round(mvarPorc_IBrutos_BsAs * mvarSubTotal / 100, mvarDecimales)
'         End If
'      Else
'         If mvarPorc_IBrutos_BsAsM <> 0 And mvarSubTotal > mvarTope_IBrutos_BsAsM Then
'            mvar_IBrutos_BsAsM = Round(mvarPorc_IBrutos_BsAsM * mvarSubTotal / 100, mvarDecimales)
'         End If
'      End If
'   End If
      
   If glbIdCodigoIva = 1 Then
      Select Case mvarTipoIVA
         Case 1
            mvarTipoABC = "A"
            mvarIVA1 = Round(TSumaGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
         Case 2
            mvarTipoABC = "A"
            mvarIVA1 = Round(TSumaGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
            mvarIVA2 = Round(TSumaGravado * Val(txtPorcentajeIva2.Text) / 100, mvarDecimales)
         Case 3
            mvarTipoABC = "E"
         Case 8
            mvarTipoABC = "B"
         Case 9
            mvarTipoABC = "A"
         Case Else
            mvarTipoABC = "B"
      End Select
   Else
      mvarTipoABC = "C"
   End If
   If mvarTipoABC = "A" And glbModalidadFacturacionAPrueba Then mvarTipoABC = "M"
   
   Set oRs = origen.DetNotasCredito.Registros
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If Not oRs.Fields("Eliminado").Value Then
               With origen.DetNotasCredito.Item(oRs.Fields(0).Value).Registro
                  .Fields("IVANoDiscriminado").Value = 0
                  If Not IsNull(.Fields("Gravado").Value) Then
                     If .Fields("Gravado").Value = "SI" Then
                        If mvarTipoABC = "B" Then
                           mImporteItem = IIf(IsNull(.Fields("Importe").Value), 0, .Fields("Importe").Value)
                           mvarIVANoDiscriminadoItem = Round(mImporteItem - (mImporteItem / (1 + (Val(txtPorcentajeIva1.Text) / 100))), 2)
                           .Fields("IVANoDiscriminado").Value = mvarIVANoDiscriminadoItem
                           mvarIVANoDiscriminado = mvarIVANoDiscriminado + mvarIVANoDiscriminadoItem
                        End If
                     End If
                  End If
               End With
            End If
            oRs.MoveNext
         Loop
      End If
   End If
   Set oRs = Nothing
   
   If Option5.Value Then
      If mvarId < 0 Then
         If mvarEsAgenteRetencionIVA = "NO" And TSumaGravado >= mvarBaseMinimaParaPercepcionIVA Then
            mvarPercepcionIVA = Round(TSumaGravado * mvarPorcentajePercepcionIVA / 100, mvarDecimales)
         End If
      Else
         mvarPercepcionIVA = IIf(IsNull(origen.Registro.Fields("PercepcionIVA").Value), 0, origen.Registro.Fields("PercepcionIVA").Value)
      End If
   
      If dcfields(4).Enabled And IsNumeric(dcfields(4).BoundText) And Check1(0).Value = 1 Then
         If mvarId < 0 Then
            Set oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(4).BoundText)
            If oRs.RecordCount > 0 Then
               mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
               mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
               mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
               mFecha1 = IIf(IsNull(oRs.Fields("FechaVigencia").Value), Date, oRs.Fields("FechaVigencia").Value)
               mCodigoProvincia = ""
               Set oRs1 = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaRealIIBB)
               If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
               oRs1.Close
               If mCodigoProvincia = "902" And DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
                  mvarPorcentajeIBrutos = mAlicuotaDirecta
               ElseIf mCodigoProvincia = "901" And DTFields(0).Value >= mFechaInicioVigenciaIBDirectoCapital And DTFields(0).Value <= mFechaFinVigenciaIBDirectoCapital Then
                  mvarPorcentajeIBrutos = mAlicuotaDirectaCapital
               Else
                  If mvarSubTotal > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
                     If mvarIBCondicion = 2 Then
                        mvarPorcentajeIBrutos = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                        mvarMultilateral = "SI"
                     Else
                        mvarPorcentajeIBrutos = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
                     End If
                  End If
               End If
               mvarIBrutos = Round((mvarSubTotal - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos / 100, 2)
            End If
            oRs.Close
            Set oRs = Nothing
         Else
            mvarIBrutos = origen.Registro.Fields("RetencionIBrutos1").Value
            mvarPorcentajeIBrutos = origen.Registro.Fields("PorcentajeIBrutos1").Value
         End If
      Else
         If mvarId > 0 Then
            mvarIBrutos = origen.Registro.Fields("RetencionIBrutos1").Value
            mvarPorcentajeIBrutos = origen.Registro.Fields("PorcentajeIBrutos1").Value
         End If
      End If
         
      If dcfields(5).Enabled And IsNumeric(dcfields(5).BoundText) And Check1(1).Value = 1 Then
         If mvarId < 0 Then
            Set oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(5).BoundText)
            If oRs.RecordCount > 0 Then
               mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
               mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
               mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
               mFecha1 = IIf(IsNull(oRs.Fields("FechaVigencia").Value), Date, oRs.Fields("FechaVigencia").Value)
               mCodigoProvincia = ""
               Set oRs1 = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaRealIIBB)
               If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
               oRs1.Close
               If mCodigoProvincia = "902" And DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
                  mvarPorcentajeIBrutos = mAlicuotaDirecta
               ElseIf mCodigoProvincia = "901" And DTFields(0).Value >= mFechaInicioVigenciaIBDirectoCapital And DTFields(0).Value <= mFechaFinVigenciaIBDirectoCapital Then
                  mvarPorcentajeIBrutos = mAlicuotaDirectaCapital
               Else
                  If mvarSubTotal > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
                     If mvarIBCondicion = 2 Then
                        mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                        mvarMultilateral = "SI"
                     Else
                        mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
                     End If
                  End If
               End If
               mvarIBrutos2 = Round((mvarSubTotal - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos2 / 100, 2)
            End If
            oRs.Close
            Set oRs = Nothing
         Else
            mvarIBrutos2 = origen.Registro.Fields("RetencionIBrutos2").Value
            mvarPorcentajeIBrutos2 = origen.Registro.Fields("PorcentajeIBrutos2").Value
         End If
      Else
         If mvarId > 0 Then
            mvarIBrutos2 = origen.Registro.Fields("RetencionIBrutos2").Value
            mvarPorcentajeIBrutos2 = origen.Registro.Fields("PorcentajeIBrutos2").Value
         End If
      End If
   
      If dcfields(6).Enabled And IsNumeric(dcfields(6).BoundText) And Check1(2).Value = 1 Then
         If mvarId < 0 Then
            Set oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(6).BoundText)
            If oRs.RecordCount > 0 Then
               mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
               mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
               mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
               mFecha1 = IIf(IsNull(oRs.Fields("FechaVigencia").Value), Date, oRs.Fields("FechaVigencia").Value)
               mCodigoProvincia = ""
               Set oRs1 = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaRealIIBB)
               If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
               oRs1.Close
               If mCodigoProvincia = "902" And DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
                  mvarPorcentajeIBrutos = mAlicuotaDirecta
               ElseIf mCodigoProvincia = "901" And DTFields(0).Value >= mFechaInicioVigenciaIBDirectoCapital And DTFields(0).Value <= mFechaFinVigenciaIBDirectoCapital Then
                  mvarPorcentajeIBrutos = mAlicuotaDirectaCapital
               Else
                  If mvarSubTotal > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
                     If mvarIBCondicion = 2 Then
                        mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                        mvarMultilateral = "SI"
                     Else
                        mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
                     End If
                  End If
               End If
               mvarIBrutos3 = Round((mvarSubTotal - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos3 / 100, 2)
            End If
            oRs.Close
            Set oRs = Nothing
         Else
            With origen.Registro
               mvarIBrutos3 = IIf(IsNull(.Fields("RetencionIBrutos3").Value), 0, .Fields("RetencionIBrutos3").Value)
               mvarPorcentajeIBrutos3 = IIf(IsNull(.Fields("PorcentajeIBrutos3").Value), 0, .Fields("PorcentajeIBrutos3").Value)
            End With
         End If
      Else
         If mvarId > 0 Then
            With origen.Registro
               mvarIBrutos3 = IIf(IsNull(.Fields("RetencionIBrutos3").Value), 0, .Fields("RetencionIBrutos3").Value)
               mvarPorcentajeIBrutos3 = IIf(IsNull(.Fields("PorcentajeIBrutos3").Value), 0, .Fields("PorcentajeIBrutos3").Value)
            End With
         End If
      End If
   End If
      
   If mvarId < 0 Then
      mPuntoVentaActivo = "SI"
      If Option5.Value Then
         mvarPuntoVenta = 0
         If IsNumeric(dcfields(10).BoundText) Then mvarPuntoVenta = dcfields(10).BoundText
         If mvarNumeracionUnica Then
            Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, mvarTipoABC, mPuntoVentaActivo))
         Else
            Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(4, mvarTipoABC, mPuntoVentaActivo))
         End If
         If oRs.RecordCount = 1 Then
            oRs.MoveFirst
            mvarPuntoVenta = oRs.Fields(0).Value
            If mvarId <= 0 Then
               origen.Registro.Fields("NumeroNotaCredito").Value = oRs.Fields("ProximoNumero").Value
               txtNumeroNotaCredito.Text = oRs.Fields("ProximoNumero").Value
            End If
         End If
         dcfields(10).Enabled = True
         Set dcfields(10).RowSource = oRs
         dcfields(10).BoundText = mvarPuntoVenta
         Set oRs = Nothing
         If Len(dcfields(10).Text) = 0 Then
            origen.Registro.Fields("NumeroNotaCredito").Value = Null
            txtNumeroNotaCredito.Text = ""
         End If
      Else
         dcfields(10).Enabled = False
         origen.Registro.Fields("IdPuntoVenta").Value = 0
         Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
         If Not origen Is Nothing Then
            origen.Registro.Fields("NumeroNotaCredito").Value = oRs.Fields("ProximaNotaCreditoInterna").Value
         End If
         oRs.Close
         Set oRs = Nothing
      End If
   End If
   
   txtTotal(0).Text = Format(mvarTotalImputaciones, "#,##0.00")
   
   mvarTotalNotaCredito = mvarSubTotal + mvarIVA1 + mvarIVA2 + mvarIBrutos + mvarIBrutos2 + mvarIBrutos3 + _
               Val(txtTotal(6).Text) + Val(txtTotal(7).Text) + Val(txtTotal(10).Text) + mvarPercepcionIVA
   
   lblLetra.Caption = mvarTipoABC
   txtTotal(3).Text = Format(mvarSubTotal, "#,##0.00")
   txtTotal(4).Text = Format(mvarIVA1, "#,##0.00")
   txtTotal(5).Text = Format(mvarIBrutos + mvarIBrutos2 + mvarIBrutos3, "#,##0.00")
   txtTotal(11).Text = Format(mvarPercepcionIVA, "#,##0.00")
   txtTotal(8).Text = Format(mvarTotalNotaCredito, "#,##0.00")
   
   Set oRs = Nothing
   Set oRs1 = Nothing
   
End Sub

Private Sub MostrarDatos(Index As Integer)

   If Not IsNumeric(dcfields(0).BoundText) Then Exit Sub
   
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim mvarLocalidad As Integer, mvarZona As Integer, mvarVendedor As Integer, mvarTransportista As Integer
   Dim mvarProvincia As Integer, mvarCondicionVenta As Integer, mvarTipoVentaC As Integer
   Dim mvarIdIBCondicion As Integer, mvarIdIBCondicion2 As Integer, mvarIdIBCondicion3 As Integer
   Dim Cambio As Boolean
   Dim mvarNumero As Long
   
   If mvarIdCliente <> dcfields(0).BoundText Then
      Cambio = True
      mvarIdCliente = dcfields(0).BoundText
   Else
      Cambio = False
   End If
   
   Set oRs = Aplicacion.Clientes.Item(dcfields(0).BoundText).Registro
   
   With oRs
      txtCodigoCliente.Text = IIf(IsNull(.Fields("Codigo").Value), "", .Fields("Codigo").Value)
      txtDireccion.Text = IIf(IsNull(.Fields("Direccion").Value), "", .Fields("Direccion").Value)
      txtCodigoPostal.Text = IIf(IsNull(.Fields("CodigoPostal").Value), "", .Fields("CodigoPostal").Value)
      txtCuit.Text = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
      txtTelefono.Text = IIf(IsNull(.Fields("Telefono").Value), "", .Fields("Telefono").Value)
      txtFax.Text = IIf(IsNull(.Fields("Fax").Value), "", .Fields("Fax").Value)
      txtEmail.Text = IIf(IsNull(.Fields("Email").Value), "", .Fields("Email").Value)
      mvarLocalidad = IIf(IsNull(.Fields("IdLocalidad").Value), 0, .Fields("IdLocalidad").Value)
      mvarProvincia = IIf(IsNull(.Fields("IdProvincia").Value), 0, .Fields("IdProvincia").Value)
      mvarTipoIVA = IIf(IsNull(.Fields("IdCodigoIva").Value), 0, .Fields("IdCodigoIva").Value)
      mvarIBCondicion = IIf(IsNull(.Fields("IBCondicion").Value), 1, .Fields("IBCondicion").Value)
      mvarIdIBCondicion = IIf(IsNull(.Fields("IdIBCondicionPorDefecto").Value), 0, .Fields("IdIBCondicionPorDefecto").Value)
      mvarIdIBCondicion2 = IIf(IsNull(.Fields("IdIBCondicionPorDefecto2").Value), 0, .Fields("IdIBCondicionPorDefecto2").Value)
      mvarIdIBCondicion3 = IIf(IsNull(.Fields("IdIBCondicionPorDefecto3").Value), 0, .Fields("IdIBCondicionPorDefecto3").Value)
      mvarEsAgenteRetencionIVA = IIf(IsNull(.Fields("EsAgenteRetencionIVA").Value), "NO", .Fields("EsAgenteRetencionIVA").Value)
      mvarPorcentajePercepcionIVA = IIf(IsNull(.Fields("PorcentajePercepcionIVA").Value), 0, .Fields("PorcentajePercepcionIVA").Value)
      mvarBaseMinimaParaPercepcionIVA = IIf(IsNull(.Fields("BaseMinimaParaPercepcionIVA").Value), 0, .Fields("BaseMinimaParaPercepcionIVA").Value)
      mAlicuotaDirecta = IIf(IsNull(.Fields("PorcentajeIBDirecto").Value), 0, .Fields("PorcentajeIBDirecto").Value)
      mFechaInicioVigenciaIBDirecto = IIf(IsNull(.Fields("FechaInicioVigenciaIBDirecto").Value), 0, .Fields("FechaInicioVigenciaIBDirecto").Value)
      mFechaFinVigenciaIBDirecto = IIf(IsNull(.Fields("FechaFinVigenciaIBDirecto").Value), 0, .Fields("FechaFinVigenciaIBDirecto").Value)
      mAlicuotaDirectaCapital = IIf(IsNull(.Fields("PorcentajeIBDirectoCapital").Value), 0, .Fields("PorcentajeIBDirectoCapital").Value)
      mFechaInicioVigenciaIBDirectoCapital = IIf(IsNull(.Fields("FechaInicioVigenciaIBDirectoCapital").Value), 0, .Fields("FechaInicioVigenciaIBDirectoCapital").Value)
      mFechaFinVigenciaIBDirectoCapital = IIf(IsNull(.Fields("FechaFinVigenciaIBDirectoCapital").Value), 0, .Fields("FechaFinVigenciaIBDirectoCapital").Value)
      If Not IsNull(.Fields("IdListaPrecios").Value) And mvarId <= 0 Then
         dcfields(7).BoundText = .Fields("IdListaPrecios").Value
      End If
      If dcfields(11).Visible Then dcfields(11).BoundText = mvarTipoIVA
   End With
   
   If Cambio Then
      mvarVendedor = oRs.Fields("Vendedor1").Value
   Else
      mvarVendedor = origen.Registro.Fields("IdVendedor").Value
   End If
   oRs.Close
   
   With origen.Registro
      If mvarId < 0 Then
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
            Check1(0).Enabled = True
            If IsNull(.Fields("IdIBCondicion").Value) Then
               .Fields("IdIBCondicion").Value = mvarIdIBCondicion
               If mvarIdIBCondicion <> 0 Then Check1(0).Value = 1
            End If
            If Check1(0).Value = 1 Then dcfields(4).Enabled = True Else dcfields(4).Enabled = False
            Check1(1).Enabled = True
            If IsNull(.Fields("IdIBCondicion2").Value) And mvarIdIBCondicion2 <> 0 Then
               .Fields("IdIBCondicion2").Value = mvarIdIBCondicion2
               If mvarIdIBCondicion2 <> 0 Then Check1(1).Value = 1
            End If
            If Check1(1).Value = 1 Then dcfields(5).Enabled = True Else dcfields(5).Enabled = False
            Check1(2).Enabled = True
            If IsNull(.Fields("IdIBCondicion3").Value) And mvarIdIBCondicion3 <> 0 Then
               .Fields("IdIBCondicion3").Value = mvarIdIBCondicion3
               If mvarIdIBCondicion3 <> 0 Then Check1(2).Value = 1
            End If
            If Check1(2).Value = 1 Then dcfields(6).Enabled = True Else dcfields(6).Enabled = False
         End If
      Else
         If Not IsNull(.Fields("IdIBCondicion").Value) Then Check1(0).Value = 1
         If Not IsNull(.Fields("IdIBCondicion2").Value) Then Check1(1).Value = 1
         If Not IsNull(.Fields("IdIBCondicion3").Value) Then Check1(2).Value = 1
         If Not IsNull(.Fields("IdCodigoIva").Value) Then mvarTipoIVA = .Fields("IdCodigoIva").Value
      End If
   End With
   
'   dcfields(2).BoundText = mvarVendedor
   
   Set oAp = Aplicacion
   
   oAp.TablasGenerales.Tabla = "Localidades"
   oAp.TablasGenerales.Id = mvarLocalidad
   Set oRs = oAp.TablasGenerales.Registro
   txtLocalidad = oRs.Fields("Nombre").Value
   oRs.Close
   
   If Not IsNull(mvarProvincia) Then
      oAp.TablasGenerales.Tabla = "Provincias"
      oAp.TablasGenerales.Id = mvarProvincia
      Set oRs = oAp.TablasGenerales.Registro
      txtProvincia = oRs.Fields("Nombre").Value
      oRs.Close
   End If
   
   oAp.TablasGenerales.Tabla = "DescripcionIva"
   oAp.TablasGenerales.Id = mvarTipoIVA
   Set oRs = oAp.TablasGenerales.Registro
   txtCondicionIva = oRs.Fields("Descripcion").Value
   oRs.Close
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   If Cambio Then origen.Registro.Fields("IdVendedor").Value = mvarVendedor
   If mvarId > 0 And Not mvarModificacionHabilitada Then txtNumeroNotaCredito.Text = origen.Registro.Fields("NumeroNotaCredito").Value
   
   CalculaNotaCredito
   
   If EstadoEntidad("Clientes", mvarIdCliente) = "INACTIVO" Then
      MsgBox "Cliente inhabilitado, no podra registrar este comprobante", vbExclamation
   End If

End Sub

Private Sub Option5_Click()

   If Option5.Value Then
      CalculaNotaCredito
   End If
   
End Sub

Private Sub Option6_Click()

   If Option6.Value Then
      CalculaNotaCredito
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

   If Len(txtCodigoCliente.Text) Then
'      If Not IsNumeric(txtCodigoCliente.Text) Then
'         MsgBox "El codigo de cliente debe ser un numero", vbExclamation
'         Cancel = True
'         Exit Sub
'      End If
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Clientes.TraerFiltrado("_PorCodigo", txtCodigoCliente.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdCliente").Value = oRs.Fields(0).Value
      Else
         MsgBox "Codigo de cliente inexistente", vbExclamation
         Cancel = True
      End If
      oRs.Close
      Set oRs = Nothing
   End If

End Sub

Private Sub txtNumeroNotaCredito_Validate(Cancel As Boolean)

   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.NotasCredito.TraerFiltrado("_PorNumeroComprobante", Array(mvarTipoABC, Val(dcfields(10).Text), Val(txtNumeroNotaCredito.Text)))
   If oRs.RecordCount > 0 Then
      If oRs.Fields(0).Value <> mvarId Then
         MsgBox "Nota de credito ya ingresada el " & oRs.Fields("FechaNotaCredito").Value & ". Reingrese.", vbCritical
         Cancel = True
      End If
   End If
   oRs.Close
   Set oRs = Nothing

End Sub

Private Sub txtPorcentajeIva1_Change()

   CalculaNotaCredito

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

   CalculaNotaCredito

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

Public Sub AnularCredito()

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   
   If IsNumeric(dcfields(10).BoundText) Then
      Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(10).BoundText)
      If oRs.RecordCount > 0 Then
         If Len(IIf(IsNull(oRs.Fields("WebService").Value), "", oRs.Fields("WebService").Value)) > 0 Then
            Set oRs = Nothing
            MsgBox "No puede anular un comprobante electronico (CAE)", vbExclamation
            Exit Sub
         End If
      End If
      oRs.Close
   End If
   
   Dim oF As frmAutorizacion
   Dim mOk As Boolean
   Dim mIdAutorizaAnulacion As Integer
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.NotasCredito
      '.Administradores = True
      .Show vbModal, Me
      mOk = .Ok
      mIdAutorizaAnulacion = .IdAutorizo
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then Exit Sub
   
   Me.Refresh
   
   Dim mSeguro As Integer
   mSeguro = MsgBox("Esta seguro de anular la nota de credito?", vbYesNo, "Anulacion de nota de credito")
   If mSeguro = vbNo Then Exit Sub

   With origen
      .Registro.Fields("Anulada").Value = "OK"
      .Registro.Fields("IdUsuarioAnulacion").Value = mIdAutorizaAnulacion
      .Registro.Fields("FechaAnulacion").Value = Now
      .Guardar
   End With

   If Check4.Value = 1 Then
      Set oRs = Aplicacion.NotasCredito.TraerFiltrado("_NDs_RecuperoGastos", mvarId)
      If oRs.RecordCount > 0 Then
         If oRs.Fields("IdNotaDebito").Value <> 0 Then
            Dim oND As ComPronto.NotaDebito
            Set oND = Aplicacion.NotasDebito.Item(oRs.Fields("IdNotaDebito").Value)
            With oND
               With .Registro
                  .Fields("Anulada").Value = "SI"
                  .Fields("IdUsuarioAnulacion").Value = mIdAutorizaAnulacion
                  .Fields("FechaAnulacion").Value = Now
               End With
               .Guardar
            End With
            Set oND = Nothing
         End If
         If oRs.Fields("IdComprobanteProveedor").Value <> 0 Then
            Dim oCP As ComPronto.ComprobanteProveedor
            Set oCP = Aplicacion.ComprobantesProveedores.Item(oRs.Fields("IdComprobanteProveedor").Value)
            With oCP
               With .Registro
                  .Fields("TotalBruto").Value = 0
                  .Fields("TotalIva1").Value = 0
                  .Fields("TotalIva2").Value = 0
                  .Fields("TotalComprobante").Value = 0
               End With
               Set oRs1 = .DetComprobantesProveedores.TraerTodos
               If oRs1.RecordCount > 0 Then
                  oRs1.MoveFirst
                  Do While Not oRs1.EOF
                     With .DetComprobantesProveedores.Item(oRs1.Fields(0).Value)
                        With .Registro
                           .Fields("Importe").Value = 0
                           .Fields("IdCuentaIvaCompras1").Value = Null
                           .Fields("IVAComprasPorcentaje1").Value = 0
                           .Fields("ImporteIVA1").Value = 0
                           .Fields("AplicarIVA1").Value = "NO"
                        End With
                        .Modificado = True
                     End With
                     oRs1.MoveNext
                  Loop
               End If
               .Guardar
               Set oRs1 = Nothing
            End With
            Set oCP = Nothing
         End If
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
   With actL2
      .ListaEditada = "NotasCredito"
      .AccionRegistro = Modificacion
      .Disparador = origen.Registro.Fields(0).Value
   End With
   
   Unload Me

End Sub

Public Sub VerificarProvinciasDestino()

   Dim oRs As ADOR.Recordset
   Dim mVacio As Boolean
   Dim mIdCliente As Long
   Dim mIdProvincia As Integer
   
   Set oRs = origen.DetNotasCreditoProvincias.Registros
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
      
      With origen.DetNotasCreditoProvincias.Item(-1)
         With .Registro
            .Fields("IdProvinciaDestino").Value = mIdProvincia
            .Fields("Porcentaje").Value = 100
         End With
         .Modificado = True
      End With
   End If

   Set oRs = Nothing

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

   If txtTotal(Index).Enabled Then CalculaNotaCredito
   
End Sub

Public Sub ImpresionNCControladorE()

   On Error GoTo Impresora_apag

   Dim oRs As ADOR.Recordset
   Dim mCuit As String, mCondicionIva As String, mTipoDoc As String
   Dim mvarPIVA1 As Single
   Dim Respuesta As Boolean
            
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
   
   Respuesta = Me.PrinterFiscal1.OpenInvoice("N", "C", mvarTipoABC, "1", "P", "12", "I", mCondicionIva, _
            mId(dcfields(0).Text, 1, 30), "", "CUIT", mCuit, "N", _
            mId(txtDireccion.Text, 1, 30), mId(txtLocalidad.Text, 1, 30), "", "", "", "C")
         
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetNotasCredito", "Cre", mvarId)
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            mvarPIVA1 = 0
            If IIf(IsNull(.Fields("Gravado?").Value), "NO", .Fields("Gravado?").Value) = "SI" Then
               mvarPIVA1 = Val(txtPorcentajeIva1.Text)
            End If
            Respuesta = Me.PrinterFiscal1.SendInvoiceItem(mId(.Fields("Concepto").Value, 1, 30), _
                     "" & 1 * 1000, _
                     "" & .Fields("Importe").Value * 100, _
                     "" & mvarPIVA1 * 100, "M", "0", "0", "", "", "", "0", "0")
            .MoveNext
         Loop
      End If
      .Close
   End With
      
   Respuesta = Me.PrinterFiscal1.CloseInvoice("M", mvarTipoABC, "DEL")
   
Procesar:
   Exit Sub

Impresora_apag:
   If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
       Resume Procesar
   End If

End Sub
