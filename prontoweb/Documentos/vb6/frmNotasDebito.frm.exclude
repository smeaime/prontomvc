VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.4#0"; "Controles1013.ocx"
Begin VB.Form frmNotasDebito 
   Caption         =   "Notas de debito"
   ClientHeight    =   7755
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11460
   Icon            =   "frmNotasDebito.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7755
   ScaleWidth      =   11460
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   2
      Left            =   7470
      TabIndex        =   84
      Top             =   2340
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
      Left            =   9765
      TabIndex        =   80
      Top             =   5850
      Width           =   1590
   End
   Begin VB.CheckBox Check3 
      Alignment       =   1  'Right Justify
      Caption         =   "No incluir esta nota de debito en cubos de venta :"
      Height          =   195
      Left            =   90
      TabIndex        =   79
      Top             =   2565
      Visible         =   0   'False
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
      Left            =   9765
      TabIndex        =   53
      Top             =   6705
      Visible         =   0   'False
      Width           =   1590
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   0
      Left            =   7470
      TabIndex        =   74
      Top             =   1620
      Width           =   195
   End
   Begin VB.CommandButton cmdProvinciasDestino 
      Caption         =   "Distribuir IIBB x provincias"
      Height          =   645
      Left            =   10170
      TabIndex        =   73
      Top             =   1935
      Width           =   1140
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Index           =   1
      Left            =   7470
      TabIndex        =   72
      Top             =   1980
      Width           =   195
   End
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Aplicar a cuenta corriente deudores :"
      Height          =   240
      Left            =   6210
      TabIndex        =   70
      Top             =   180
      Width           =   3120
   End
   Begin VB.TextBox txtNumeroCuota 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCuota"
      Enabled         =   0   'False
      Height          =   285
      Left            =   7110
      TabIndex        =   69
      Top             =   6795
      Width           =   585
   End
   Begin VB.TextBox txtNumeroCertificadoPercepcionIIBB 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCertificadoPercepcionIIBB"
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
      Left            =   5670
      TabIndex        =   64
      Top             =   5310
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Anular"
      Enabled         =   0   'False
      Height          =   465
      Index           =   2
      Left            =   3630
      TabIndex        =   61
      Top             =   6885
      Width           =   840
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
      Left            =   9765
      TabIndex        =   54
      Top             =   5565
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
      Left            =   9765
      TabIndex        =   51
      Top             =   6135
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
      Index           =   7
      Left            =   9765
      TabIndex        =   52
      Top             =   6420
      Visible         =   0   'False
      Width           =   1590
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
      Height          =   315
      Left            =   6840
      TabIndex        =   46
      Top             =   4950
      Width           =   645
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
      TabIndex        =   45
      Top             =   4950
      Width           =   690
   End
   Begin VB.Frame Frame2 
      Caption         =   "Tipo de nota de debito : "
      Height          =   600
      Left            =   90
      TabIndex        =   42
      Top             =   180
      Width           =   2175
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
         TabIndex        =   44
         Top             =   315
         Width           =   960
      End
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
         TabIndex        =   43
         Top             =   315
         Width           =   960
      End
   End
   Begin VB.TextBox txtPorcentajeIva1 
      Alignment       =   1  'Right Justify
      Height          =   270
      Left            =   9000
      TabIndex        =   40
      Top             =   5310
      Width           =   405
   End
   Begin VB.TextBox txtPorcentajeIva2 
      Alignment       =   1  'Right Justify
      Height          =   270
      Left            =   7560
      TabIndex        =   39
      Top             =   5175
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   465
      Index           =   1
      Left            =   2745
      Picture         =   "frmNotasDebito.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   38
      Top             =   6885
      Width           =   840
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
      Height          =   330
      Index           =   3
      Left            =   9765
      TabIndex        =   34
      Top             =   4950
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
      Left            =   9765
      TabIndex        =   33
      Top             =   5280
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
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   8
      Left            =   9765
      TabIndex        =   32
      Top             =   7020
      Width           =   1590
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   465
      Index           =   0
      Left            =   90
      TabIndex        =   5
      Top             =   6885
      Width           =   840
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   465
      Index           =   1
      Left            =   975
      TabIndex        =   6
      Top             =   6885
      Width           =   840
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   465
      Index           =   0
      Left            =   1860
      Picture         =   "frmNotasDebito.frx":0CF4
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   6885
      UseMaskColor    =   -1  'True
      Width           =   840
   End
   Begin VB.TextBox txtTelefono 
      Enabled         =   0   'False
      Height          =   285
      Left            =   7680
      TabIndex        =   17
      Top             =   810
      Width           =   1755
   End
   Begin VB.TextBox txtFax 
      Enabled         =   0   'False
      Height          =   285
      Left            =   10065
      TabIndex        =   16
      Top             =   810
      Width           =   1260
   End
   Begin VB.TextBox txtEmail 
      Enabled         =   0   'False
      Height          =   285
      Left            =   7680
      TabIndex        =   15
      Top             =   1155
      Width           =   3645
   End
   Begin VB.TextBox txtCuit 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      Height          =   285
      Left            =   10065
      TabIndex        =   14
      Top             =   495
      Width           =   1260
   End
   Begin VB.TextBox txtNumeroNotaDebito 
      Alignment       =   2  'Center
      DataField       =   "NumeroNotaDebito"
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
      Left            =   4275
      TabIndex        =   0
      Top             =   450
      Width           =   1290
   End
   Begin VB.TextBox txtDireccion 
      Enabled         =   0   'False
      Height          =   285
      Left            =   1575
      TabIndex        =   13
      Top             =   1185
      Width           =   4005
   End
   Begin VB.TextBox txtLocalidad 
      Enabled         =   0   'False
      Height          =   285
      Left            =   1575
      TabIndex        =   12
      Top             =   1515
      Width           =   4005
   End
   Begin VB.TextBox txtProvincia 
      Enabled         =   0   'False
      Height          =   285
      Left            =   1575
      TabIndex        =   11
      Top             =   1845
      Width           =   2160
   End
   Begin VB.TextBox txtCodigoPostal 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   4680
      TabIndex        =   10
      Top             =   1860
      Width           =   900
   End
   Begin VB.TextBox txtCondicionIva 
      Enabled         =   0   'False
      Height          =   285
      Left            =   7680
      TabIndex        =   9
      Top             =   495
      Width           =   1755
   End
   Begin VB.TextBox txtCodigoCliente 
      Alignment       =   2  'Center
      Height          =   315
      Left            =   1575
      TabIndex        =   8
      Top             =   825
      Width           =   660
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaNotaDebito"
      Height          =   330
      Index           =   0
      Left            =   3240
      TabIndex        =   1
      Top             =   90
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   57081857
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCliente"
      Height          =   315
      Index           =   0
      Left            =   2250
      TabIndex        =   2
      Tag             =   "Clientes"
      Top             =   825
      Width           =   3300
      _ExtentX        =   5821
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCliente"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1140
      Left            =   45
      TabIndex        =   4
      Top             =   5625
      Width           =   7665
      _ExtentX        =   13520
      _ExtentY        =   2011
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmNotasDebito.frx":135E
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   30
      Top             =   7470
      Width           =   11460
      _ExtentX        =   20214
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   7290
      Top             =   5895
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
            Picture         =   "frmNotasDebito.frx":13E0
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNotasDebito.frx":14F2
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNotasDebito.frx":1944
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNotasDebito.frx":1D96
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   1860
      Left            =   45
      TabIndex        =   37
      Top             =   3060
      Width           =   11355
      _ExtentX        =   20029
      _ExtentY        =   3281
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmNotasDebito.frx":21E8
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   3
      Left            =   945
      TabIndex        =   47
      Tag             =   "Monedas"
      Top             =   4950
      Width           =   1680
      _ExtentX        =   2963
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdPuntoVenta"
      Height          =   315
      Index           =   10
      Left            =   3240
      TabIndex        =   59
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
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   1
      Left            =   1575
      TabIndex        =   62
      Tag             =   "Obras"
      Top             =   2205
      Width           =   2160
      _ExtentX        =   3810
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdVentaEnCuotas"
      Height          =   315
      Index           =   2
      Left            =   4500
      TabIndex        =   66
      Tag             =   "VentasEnCuotas"
      Top             =   7110
      Width           =   3195
      _ExtentX        =   5636
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdVentaEnCuotas"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdIBCondicion"
      Height          =   315
      Index           =   4
      Left            =   7740
      TabIndex        =   75
      Tag             =   "IBCondiciones"
      Top             =   1575
      Width           =   3600
      _ExtentX        =   6350
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdIBCondicion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdIBCondicion2"
      Height          =   315
      Index           =   5
      Left            =   7740
      TabIndex        =   76
      Tag             =   "IBCondiciones"
      Top             =   1935
      Width           =   2430
      _ExtentX        =   4286
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
      Left            =   4245
      TabIndex        =   82
      Tag             =   "ListasPrecios"
      Top             =   2205
      Width           =   1320
      _ExtentX        =   2328
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
      Left            =   7740
      TabIndex        =   85
      Tag             =   "IBCondiciones"
      Top             =   2295
      Width           =   2430
      _ExtentX        =   4286
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
      Left            =   8550
      TabIndex        =   88
      Tag             =   "DescripcionIva"
      Top             =   2610
      Visible         =   0   'False
      Width           =   2970
      _ExtentX        =   5239
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCodigoIva"
      Text            =   ""
   End
   Begin VB.Label lblData 
      Caption         =   "Categoria IIBB 3"
      Height          =   285
      Index           =   5
      Left            =   6255
      TabIndex        =   87
      Top             =   2295
      Width           =   1170
   End
   Begin VB.Label lblData 
      Caption         =   "Categoria IIBB 2"
      Height          =   285
      Index           =   4
      Left            =   6255
      TabIndex        =   86
      Top             =   1935
      Width           =   1170
   End
   Begin VB.Label lblData 
      Caption         =   "Lista :"
      Height          =   285
      Index           =   3
      Left            =   3780
      TabIndex        =   83
      Top             =   2205
      Width           =   450
   End
   Begin VB.Label Label4 
      Caption         =   "Percepcion IVA : "
      Height          =   195
      Left            =   7920
      TabIndex        =   81
      Top             =   5940
      Width           =   1770
   End
   Begin VB.Label lblOtrasPercepciones3 
      Height          =   150
      Left            =   7920
      TabIndex        =   78
      Top             =   6750
      Visible         =   0   'False
      Width           =   1770
   End
   Begin VB.Label lblData 
      Caption         =   "Categoria IIBB 1"
      Height          =   285
      Index           =   10
      Left            =   6255
      TabIndex        =   77
      Top             =   1575
      Width           =   1170
   End
   Begin VB.Line Line9 
      BorderColor     =   &H00FFFFFF&
      Index           =   2
      X1              =   11385
      X2              =   6165
      Y1              =   1485
      Y2              =   1485
   End
   Begin VB.Line Line9 
      BorderColor     =   &H00FFFFFF&
      Index           =   0
      X1              =   11385
      X2              =   6165
      Y1              =   2700
      Y2              =   2700
   End
   Begin VB.Line Line9 
      BorderColor     =   &H00FFFFFF&
      Index           =   1
      X1              =   6165
      X2              =   6165
      Y1              =   2700
      Y2              =   1485
   End
   Begin VB.Line Line9 
      BorderColor     =   &H00FFFFFF&
      Index           =   3
      X1              =   11385
      X2              =   11385
      Y1              =   2700
      Y2              =   1485
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
      Left            =   90
      TabIndex        =   71
      Top             =   2835
      Width           =   2745
   End
   Begin VB.Label lblData 
      Caption         =   "Cuota :"
      Height          =   195
      Index           =   2
      Left            =   6435
      TabIndex        =   68
      Top             =   6840
      Width           =   630
   End
   Begin VB.Label lblData 
      Caption         =   "Ventas en cuotas :"
      Height          =   195
      Index           =   1
      Left            =   4545
      TabIndex        =   67
      Top             =   6885
      Width           =   1395
   End
   Begin VB.Label lblNumeroCertificadoPercepcionIIBB 
      Caption         =   "Numero de certificado percepcion IIBB :"
      Height          =   240
      Left            =   2790
      TabIndex        =   65
      Top             =   5355
      Visible         =   0   'False
      Width           =   2835
   End
   Begin VB.Label lblData 
      Caption         =   "Obra (opcional) :"
      Height          =   285
      Index           =   0
      Left            =   90
      TabIndex        =   63
      Top             =   2205
      Width           =   1440
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
      Left            =   9855
      TabIndex        =   60
      Top             =   135
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Line Line5 
      BorderWidth     =   2
      X1              =   5670
      X2              =   5670
      Y1              =   45
      Y2              =   405
   End
   Begin VB.Line Line6 
      BorderWidth     =   2
      X1              =   6120
      X2              =   6120
      Y1              =   45
      Y2              =   405
   End
   Begin VB.Line Line7 
      BorderWidth     =   2
      X1              =   5670
      X2              =   6120
      Y1              =   405
      Y2              =   405
   End
   Begin VB.Line Line8 
      BorderWidth     =   2
      X1              =   5670
      X2              =   6120
      Y1              =   45
      Y2              =   45
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
      Height          =   330
      Left            =   5715
      TabIndex        =   58
      Top             =   45
      Width           =   375
   End
   Begin VB.Label lblPercIBB 
      Caption         =   "Percepcion I. Brutos :"
      Height          =   240
      Left            =   7920
      TabIndex        =   57
      Top             =   5625
      Visible         =   0   'False
      Width           =   1770
   End
   Begin VB.Label lblOtrasPercepciones2 
      Height          =   195
      Left            =   7920
      TabIndex        =   56
      Top             =   6480
      Visible         =   0   'False
      Width           =   1770
   End
   Begin VB.Line Line2 
      BorderColor     =   &H80000005&
      BorderWidth     =   3
      X1              =   9765
      X2              =   11355
      Y1              =   6975
      Y2              =   6975
   End
   Begin VB.Label lblOtrasPercepciones1 
      Height          =   195
      Left            =   7920
      TabIndex        =   55
      Top             =   6210
      Visible         =   0   'False
      Width           =   1770
   End
   Begin VB.Label lblLabels 
      Caption         =   "Moneda :"
      Height          =   240
      Index           =   14
      Left            =   90
      TabIndex        =   50
      Top             =   4995
      Width           =   780
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cotizacion dolar :"
      Height          =   240
      Index           =   5
      Left            =   5220
      TabIndex        =   49
      Top             =   4995
      Width           =   1530
   End
   Begin VB.Label lblLabels 
      Caption         =   "Conversion a Pesos :"
      Height          =   240
      Index           =   15
      Left            =   2790
      TabIndex        =   48
      Top             =   4995
      Width           =   1530
   End
   Begin VB.Label Label7 
      Caption         =   " % "
      Height          =   195
      Left            =   9450
      TabIndex        =   41
      Top             =   5355
      Width           =   240
   End
   Begin VB.Label Label1 
      Caption         =   "Subtotal :"
      Height          =   285
      Left            =   7920
      TabIndex        =   3
      Top             =   4995
      Width           =   1770
   End
   Begin VB.Label lblIVA1 
      Caption         =   "IVA"
      Height          =   240
      Left            =   7920
      TabIndex        =   36
      Top             =   5325
      Width           =   1050
   End
   Begin VB.Label Label6 
      BackColor       =   &H00FFFFFF&
      Caption         =   "TOT.DEBITO :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000010&
      Height          =   375
      Left            =   7920
      TabIndex        =   35
      Top             =   7020
      Width           =   1770
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
      TabIndex        =   31
      Top             =   5400
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   2340
      TabIndex        =   29
      Top             =   135
      Width           =   810
   End
   Begin VB.Label lblLabels 
      Caption         =   "Telefono :"
      Height          =   285
      Index           =   0
      Left            =   6210
      TabIndex        =   28
      Top             =   840
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fax :"
      Height          =   240
      Index           =   3
      Left            =   9540
      TabIndex        =   27
      Top             =   855
      Width           =   450
   End
   Begin VB.Label lblLabels 
      Caption         =   "Email :"
      Height          =   240
      Index           =   7
      Left            =   6210
      TabIndex        =   26
      Top             =   1185
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "CUIT:"
      Height          =   195
      Index           =   6
      Left            =   9540
      TabIndex        =   25
      Top             =   540
      Width           =   450
   End
   Begin VB.Label lblLabels 
      Caption         =   "N. Debito :"
      Height          =   285
      Index           =   1
      Left            =   2340
      TabIndex        =   24
      Top             =   450
      Width           =   810
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cliente :"
      Height          =   285
      Index           =   2
      Left            =   90
      TabIndex        =   23
      Top             =   870
      Width           =   1440
   End
   Begin VB.Label lblLabels 
      Caption         =   "Dirección :"
      Height          =   285
      Index           =   10
      Left            =   90
      TabIndex        =   22
      Top             =   1200
      Width           =   1440
   End
   Begin VB.Label lblLabels 
      Caption         =   "Localidad :"
      Height          =   285
      Index           =   11
      Left            =   90
      TabIndex        =   21
      Top             =   1530
      Width           =   1440
   End
   Begin VB.Label lblLabels 
      Caption         =   "Provincia :"
      Height          =   285
      Index           =   12
      Left            =   90
      TabIndex        =   20
      Top             =   1860
      Width           =   1440
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cod.postal :"
      Height          =   285
      Index           =   13
      Left            =   3780
      TabIndex        =   19
      Top             =   1875
      Width           =   840
   End
   Begin VB.Label lblLabels 
      Caption         =   "Condicion IVA :"
      Height          =   240
      Index           =   8
      Left            =   6210
      TabIndex        =   18
      Top             =   510
      Width           =   1395
   End
   Begin VB.Label lblCAE 
      Alignment       =   2  'Center
      BackColor       =   &H00C0FFFF&
      Caption         =   "Label5"
      Height          =   195
      Left            =   0
      TabIndex        =   89
      Top             =   5310
      Visible         =   0   'False
      Width           =   2445
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
Attribute VB_Name = "frmNotasDebito"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.NotaDebito
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mvarIdCliente As Long
Dim actL2 As ControlForm
Private mvarGrabado As Boolean, mvarNumeracionUnica As Boolean
Private cALetra As New clsNum2Let
'Variables de calculo de totales de NotaDebito
Private mvarIBrutosC As String, mvarIBrutosB As String, mvarMultilateral As String, mvarConceptoVentasEnCuotas As String
Private mvarTipoABC As String, mvarAclaracionAlPie As String, mvarPercepcionIIBB As String, mvarAnulada As String
Private mvarOtrasPercepciones1 As String, mvarOtrasPercepciones1Desc As String, mvarOtrasPercepciones2 As String
Private mvarOtrasPercepciones2Desc As String, mvarOtrasPercepciones3 As String, mvarOtrasPercepciones3Desc As String
Private mvarEsAgenteRetencionIVA As String
Private mvarPorc_IBrutos_Cap As Double, mvarTope_IBrutos_Cap As Double, mvarP_IVA1_Tomado As Double
Private mvarPorc_IBrutos_BsAs As Double, mvarTope_IBrutos_BsAs As Double, mvarIBrutos As Double, mvarDecimales As Double
Private mvarTope_IBrutos_BsAsM As Double, mvarPorcentajeIBrutos As Double, mvarP_IVA1 As Double, mvarCotizacion As Double
Private mvarPorcentajeIBrutos2 As Double, mvarIBrutos2 As Double, mvarPorcentajeIBrutos3 As Double, mvarIBrutos3 As Double
Private mvarPorc_IBrutos_BsAsM As Double, mvar_IBrutos_Cap As Double, mvar_IBrutos_BsAs As Double, mvar_IBrutos_BsAsM As Double
Private mvarP_IVA2 As Double, mvarIVA1 As Double, mvarIVA2 As Double, mvarPorcentajeBonificacion As Double
Private mvarImporteBonificacion As Double, mvarNetoGravado As Double, mvarTotalNotaDebito As Double, mvarRecargoMora As Double
Private mvarCotizacionDolar As Double, mvarSubTotal As Double, mvarPorcentajeMaximoBonificacion As Double
Private mvarIVANoDiscriminado As Double, mvarPercepcionIVA As Double, mvarBaseMinimaParaPercepcionIVA As Double
Private mvarPorcentajePercepcionIVA As Single, mAlicuotaDirecta As Single, mAlicuotaDirectaCapital As Single
Private mvarTipoIVA As Integer, mvarPuntoVenta As Integer, mvarIdMonedaPesos As Integer, mvarIdMonedaDolar As Integer
Private mvarIBCondicion As Integer, mvarIdConceptoVentasEnCuotas As Integer
Private mFechaInicioVigenciaIBDirecto As Date, mFechaFinVigenciaIBDirecto As Date
Private mFechaInicioVigenciaIBDirectoCapital As Date, mFechaFinVigenciaIBDirectoCapital As Date
Private mvarModificacionHabilitada As Boolean
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
      MsgBox "No puede modificar una NotaDebito ya registrada!", vbExclamation
      Exit Sub
   End If
   
   Dim oF As frmDetNotasDebito
   Dim oL As ListItem
   
   Set oF = New frmDetNotasDebito
   
   With oF
      Set .NotaDebito = origen
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

   CalculaNotaDebito

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
   CalculaNotaDebito

End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         If DTFields(0).Value <= gblFechaUltimoCierre And _
               Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
            MsgBox "La fecha no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation
            Exit Sub
         End If

         Dim mIdObra As Integer, mIdProvinciaDestino As Integer, mIdPuntoVenta As Integer
         
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
            mIdPuntoVenta = 0
            If IsNumeric(dcfields(10).BoundText) Then mIdPuntoVenta = dcfields(10).BoundText
            Aplicacion.Tarea "NotasDebito_ActualizarCampos", _
                  Array(mvarId, mIdProvinciaDestino, mIdObra, origen.Registro.Fields("NoIncluirEnCubos").Value, _
                        rchObservaciones.Text, mIdPuntoVenta, DTFields(0).Value, Val(txtNumeroNotaDebito.Text))
            Unload Me
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim mvarImprime As Integer, mNumeroItem As Integer, mCantidadItem As Integer, mCodigoMoneda As Integer
         Dim mTipoComprobante As Integer
         Dim mvarNumero As Long, mIdentificador As Long
         Dim mResult As String, mFecha As String, mWS As String, mDescripcion As String, mNCM As String, mCAE As String
         Dim mModoTest As String, mCodigoMoneda1 As String, mPaisDestino As String, mCuitPais As String, mCliente As String
         Dim mDomicilio As String, mUnidadesCodigoAFIP As String, mCAEManual As String
         Dim mvarFechaVencimientoCAE As Date
         Dim mResul As Boolean
         Dim oRs As ADOR.Recordset
         Dim oRs1 As ADOR.Recordset
         Dim oF As frm_Aux
      
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar una nota de debito sin detalles"
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
            If origen.DetNotasDebito.Registros.RecordCount = 0 Then
               MsgBox "No determino ningun detalle en la nota de debito"
               Exit Sub
            End If
         End If
         
         If mvarId < 0 And IsNumeric(dcfields(10).BoundText) And Not BuscarClaveINI("Validar fecha de facturas nuevas") = "NO" Then
            Set oRs = Aplicacion.NotasDebito.TraerFiltrado("_UltimaPorIdPuntoVenta", dcfields(10).BoundText)
            If oRs.RecordCount > 0 Then
               If oRs.Fields("FechaNotaDebito").Value > DTFields(0).Value Then
                  MsgBox "La fecha de la ultima nota de credito es " & oRs.Fields("FechaNotaDebito").Value & ", modifiquela", vbExclamation
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
            
'         If mvarIBrutos <> 0 And txtNumeroCertificadoPercepcionIIBB.Visible And _
'               Len(txtNumeroCertificadoPercepcionIIBB.Text) = 0 Then
'            MsgBox "Debe ingresar el numero de certificado de percepcion IIBB", vbInformation
'            Exit Sub
'         End If
         
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
         
         If IsNumeric(dcfields(2).BoundText) And (Len(txtNumeroCuota.Text) = 0 Or Not IsNumeric(txtNumeroCuota.Text)) Then
            MsgBox "Debe ingresar el numero de cuota", vbInformation
            Exit Sub
         End If
         
         Dim mvarCAI As Double, mvarCAI_v As String
         Dim mvarFechaCAI As Date, mvarFechaCAI_v As String
         If IsNumeric(dcfields(10).BoundText) Then
            Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(10).BoundText)
            Select Case mvarTipoABC
               Case "A", "M"
                  mvarCAI_v = "NumeroCAI_D_A"
                  mvarFechaCAI_v = "FechaCAI_D_A"
               Case "B"
                  mvarCAI_v = "NumeroCAI_D_B"
                  mvarFechaCAI_v = "FechaCAI_D_B"
               Case "E"
                  mvarCAI_v = "NumeroCAI_D_E"
                  mvarFechaCAI_v = "FechaCAI_D_E"
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
            .Fields("ImporteTotal").Value = mvarTotalNotaDebito
            .Fields("ImporteIva1").Value = mvarIVA1
            .Fields("ImporteIva2").Value = mvarIVA2
            .Fields("IVANoDiscriminado").Value = mvarIVANoDiscriminado
            .Fields("RetencionIBrutos1").Value = mvarIBrutos
            .Fields("PorcentajeIBrutos1").Value = mvarPorcentajeIBrutos
            .Fields("RetencionIBrutos2").Value = mvarIBrutos2
            .Fields("PorcentajeIBrutos2").Value = mvarPorcentajeIBrutos2
            .Fields("RetencionIBrutos3").Value = mvarIBrutos3
            .Fields("PorcentajeIBrutos3").Value = mvarPorcentajeIBrutos3
            .Fields("ConvenioMultilateral").Value = mvarMultilateral
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
                  .FEDetalleImp_total = mvarTotalNotaDebito
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
                     mResul = .Registrar(dcfields(10).Text, 2, "" & mIdentificador)
                  Else
                     mResul = .Registrar(dcfields(10).Text, 7, "" & mIdentificador)
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
               mTipoComprobante = 2
            Else
               mTipoComprobante = 7
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
                  .bImp_total = mvarTotalNotaDebito
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

                  Set oRs = origen.DetNotasDebito.Registros
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

            mTipoComprobante = 20

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
               MsgBox "Para el registro electronico de la nota de debito, el pais del destinatario debe tener el codigo 2", vbExclamation
               Exit Sub
            End If
            If Len(mCuitPais) = 0 Then
               MsgBox "Para el registro electronico de la nota de debito, el pais del destinatario debe tener el cuit-pais", vbExclamation
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
                  .xImp_total = mvarTotalNotaDebito
                  .xForma_pago = "."
                  .xIncoTerms = "CIF"
                  .xIncoTerms_ds = ""
                  .xIdioma_cbte = 1

                  Set oRs = origen.DetNotasDebito.Registros
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
                  origen.Registro.Fields("NumeroNotaDebito").Value = mvarNumero
               End With
               oPto.Guardar
               Set oPto = Nothing
            Else
               Dim oPar As ComPronto.Parametro
               Set oPar = Aplicacion.Parametros.Item(1)
               With oPar
                  With .Registro
                     .Fields("ProximaNotaDebitoInterna").Value = .Fields("ProximaNotaDebitoInterna").Value + 1
                  End With
                  .Guardar
               End With
               Set oPar = Nothing
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
      
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
            mvarGrabado = True
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "NotasDebitoTodas, NotasDebitoAgrupadas, +SubND2"
            .AccionRegistro = est
            .Disparador = origen.Registro.Fields(0).Value
         End With
      
         Me.MousePointer = vbDefault
   
         mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de Nota de Debito")
         If mvarImprime = vbYes Then cmdImpre_Click 0
      
         Set oRs = Nothing
         Set oRs1 = Nothing
      
         Unload Me
      
      Case 1
         Unload Me

      Case 2
         AnularDebito
   End Select
   
   Set cALetra = Nothing
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oDet As ComPronto.DetNotaDebito
   Dim oRs As ADOR.Recordset
   Dim dc As DataCombo
   Dim dtf As DTPicker
   Dim ListaVacia As Boolean

   mvarId = vnewvalue
   ListaVacia = False
   mvarModificacionHabilitada = False
   
   If BuscarClaveINI("Consultar inclusion en cubos para comprobantes de venta") = "SI" Then Check3.Visible = True
   If BuscarClaveINI("Valor default inclusion en cubos de comprobantes de venta") = "SI" Then Check3.Value = 1
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
   Set origen = oAp.NotasDebito.Item(vnewvalue)
   
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
      mvarIdMonedaPesos = .Fields("IdMoneda").Value
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
      mvarIdConceptoVentasEnCuotas = IIf(IsNull(.Fields("IdConceptoVentasEnCuotas").Value), 0, .Fields("IdConceptoVentasEnCuotas").Value)
   End With
   oRs.Close
   mvarConceptoVentasEnCuotas = ""
   Set oRs = oAp.Conceptos.Item(mvarIdConceptoVentasEnCuotas).Registro
   If oRs.RecordCount > 0 Then
      mvarConceptoVentasEnCuotas = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
   End If
   oRs.Close

   If mvarId = -1 Then
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
            If oControl.Name = "Lista" Then
               If vnewvalue < 0 Then
                  Set oControl.DataSource = origen.DetNotasDebito.TraerMascara
               Else
                  Set oRs = origen.DetNotasDebito.TraerTodos
                  If oRs.RecordCount <> 0 Then
                     Set oControl.DataSource = oRs
                     oRs.MoveFirst
                     Do While Not oRs.EOF
                        Set oDet = origen.DetNotasDebito.Item(oRs.Fields(0).Value)
                        oDet.Modificado = True
                        Set oDet = Nothing
                        oRs.MoveNext
                     Loop
                     ListaVacia = False
                  Else
                     Set oControl.DataSource = origen.DetNotasDebito.TraerMascara
                     ListaVacia = True
                  End If
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
               ElseIf oControl.Tag = "VentasEnCuotas" Then
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
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      With origen.Registro
         .Fields("IdMoneda").Value = mvarIdMonedaPesos
      End With
      Lista.ListItems.Clear
      mvarGrabado = False
      txtPorcentajeIva1.Text = mvarP_IVA1
      txtPorcentajeIva2.Text = mvarP_IVA2
      Option5.Value = True
      Check2.Value = 1
      mvarCotizacion = Cotizacion(Date, glbIdMonedaDolar)
      txtCotizacionDolar.Text = mvarCotizacion
   Else
      With origen.Registro
         txtPorcentajeIva1.Text = .Fields("PorcentajeIva1").Value
         txtPorcentajeIva2.Text = .Fields("PorcentajeIva2").Value
         If (IsNull(.Fields("CtaCte").Value) Or .Fields("CtaCte").Value = "SI") And _
               IsNull(.Fields("IdNotaCreditoVenta_RecuperoGastos").Value) Then
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
         If IsNull(.Fields("AplicarEnCtaCte").Value) Or _
               .Fields("AplicarEnCtaCte").Value = "SI" Then
            Check2.Value = 1
         Else
            Check2.Value = 0
         End If
         If Not IsNull(.Fields("NoIncluirEnCubos").Value) And _
               .Fields("NoIncluirEnCubos").Value = "SI" Then
            Check3.Value = 1
         Else
            Check3.Value = 0
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      
         If mvarNumeracionUnica Then
            Set dcfields(10).RowSource = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, .Fields("TipoABC").Value))
         Else
            Set dcfields(10).RowSource = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(3, .Fields("TipoABC").Value))
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
         txtNumeroNotaDebito.Enabled = True
         DTFields(0).Enabled = True
      End If
      
      CalculaNotaDebito
   End If
   
   If mvarPercepcionIIBB = "SI" Or origen.Registro.Fields("RetencionIBrutos1").Value <> 0 Then
      lblPercIBB.Visible = True
      lblNumeroCertificadoPercepcionIIBB.Visible = True
      txtNumeroCertificadoPercepcionIIBB.Visible = True
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
   
   If ListaVacia Then Lista.ListItems.Clear
   
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
'   If mvarId > 0 Then cmd(0).Enabled = False
   
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
   
   Dim mPlantilla As String, mCampo As String, mvarConfirmarClausulaDolar As String
   Dim mvarClausula As Boolean, mOk As Boolean
   Dim oRs As ADOR.Recordset
   
   mPlantilla = "N/A"
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   If oRs.RecordCount > 0 Then
      mCampo = "Plantilla_NotasDebito_" & IIf(mvarTipoABC = "C" Or mvarTipoABC = "M", "A", mvarTipoABC)
      If Not IsNull(oRs.Fields(mCampo).Value) And _
            Len(oRs.Fields(mCampo).Value) > 0 Then
         mPlantilla = oRs.Fields(mCampo).Value
      End If
      mvarConfirmarClausulaDolar = IIf(IsNull(oRs.Fields("ConfirmarClausulaDolar").Value), "NO", oRs.Fields("ConfirmarClausulaDolar").Value)
   End If
   oRs.Close
   Set oRs = Nothing
   
   If Not IsNull(origen.Registro.Fields("CAE").Value) Then
      mPlantilla = mId(mPlantilla, 1, Len(mPlantilla) - 4) & "_NDE" & mId(mPlantilla, Len(mPlantilla) - 3, 4)
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
   Dim mPrinter, mPrinterAnt As String
   
   mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
   If Index = 0 Then
      mCopias = Val(BuscarClaveINI("CopiasNotasDebito", -1))
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
      If Not mOk Then
         Exit Sub
      End If
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

   Dim oF As frmDetNotasDebitoProvincias
   
   VerificarProvinciasDestino
   
   Set oF = New frmDetNotasDebitoProvincias
   With oF
      Set .NotaDebito = origen
      .Show vbModal, Me
   End With
   Unload oF
   Set oF = Nothing

End Sub

Private Sub dcfields_Change(Index As Integer)
      
   If Len(dcfields(Index).BoundText) = 0 Or Not IsNumeric(dcfields(Index).BoundText) Then Exit Sub
   origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
   Dim oRs As ADOR.Recordset
   Select Case Index
      Case 0
         MostrarDatos (0)
         CalculaNotaDebito
      Case 2
         If mvarId <= 0 Then
            Set oRs = Aplicacion.VentasEnCuotas.TraerFiltrado("_CuotasPorIdVentaEnCuotas", dcfields(Index).BoundText)
            If oRs.RecordCount > 0 Then
               origen.Registro.Fields("NumeroCuota").Value = IIf(IsNull(oRs.Fields("NumeroCuota").Value), 1, oRs.Fields("NumeroCuota").Value + 1)
               If Lista.ListItems.Count = 0 Then
                  With origen.DetNotasDebito.Item(-1)
                     With .Registro
                        .Fields("IdConcepto").Value = mvarIdConceptoVentasEnCuotas
                        .Fields("Gravado").Value = "SI"
                        .Fields("Importe").Value = IIf(IsNull(oRs.Fields("ImporteCuota").Value), 0, oRs.Fields("ImporteCuota").Value)
                     End With
                     .Modificado = True
                     Dim oL As ListItem
                     Set oL = Lista.ListItems.Add
                     oL.Tag = .Id
                     oL.SmallIcon = "Nuevo"
                     oL.Text = "" & mvarConceptoVentasEnCuotas
                     oL.SubItems(1) = "SI"
                     oL.SubItems(2) = "" & Format(.Registro.Fields("Importe").Value, "#,##0.00")
                     CalculaNotaDebito
                  End With
               End If
            Else
               origen.Registro.Fields("NumeroCuota").Value = 1
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
            Else
               If Me.Visible Then MsgBox "No hay cotizacion, ingresela manualmente"
               txtCotizacionMoneda.Text = ""
            End If
            oRs.Close
         End If
      Case 4
         Check1(0).Value = 1
         CalculaNotaDebito
      Case 5
         Check1(1).Value = 1
         CalculaNotaDebito
      Case 6
         Check1(2).Value = 1
         CalculaNotaDebito
      Case 10
         If mvarId <= 0 Then
            Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(Index).BoundText)
            If oRs.RecordCount > 0 Then
               origen.Registro.Fields("NumeroNotaDebito").Value = oRs.Fields("ProximoNumero").Value
               txtNumeroNotaDebito.Text = oRs.Fields("ProximoNumero").Value
            End If
            oRs.Close
         End If
      Case 11
         mvarTipoIVA = dcfields(Index).BoundText
         CalculaNotaDebito
   End Select
   Set oRs = Nothing
   
End Sub

Private Sub dcfields_GotFocus(Index As Integer)

   SendKeys "%{DOWN}"
   
End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

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
   
   If Not origen Is Nothing Then CalculaNotaDebito
   
'   lblIVA1.Caption = "IVA " & Format(mvarP_IVA1, "##0.00") & " %"
'   lblIVA2.Caption = "IVA " & Format(mvarP_IVA2, "##0.00") & " %"
   
'   mvarPuntoVenta = mvarPuntoVentaDefault

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16 ' Que imagelist utiliza
      .IconoPequeño = "Original" ' Nombre del icono que debe mostrar al cargar
   End With
   
   For Each oI In Img16.ListImages
      With Estado.Panels.Add(, , oI.Key)
         .Picture = oI.Picture
      End With
   Next

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

   Dim s As String, mvarConcepto As String, mvarConIVA As String
   Dim iFilas As Long, iColumnas As Long, i As Long, idDet As Long, mvarIdConceptoDiferenciaCambio As Long
   Dim mvarTipoIVA1 As Integer
   Dim mvarImporte As Double
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
         If mvarImporte < 0 Then
            MsgBox "La diferencia de cambio debe ser mayor a cero," & vbCrLf & _
                  "para este caso debe hacer una nota de credito", vbExclamation
            GoTo Mal
         End If
         
         With origen.Registro
            .Fields("IdCliente").Value = Columnas(20)
         End With
         
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
            End If
         End If
         oRs.Close
         
         With origen.DetNotasDebito.Item(-1)
            .Registro.Fields("IdConcepto").Value = mvarIdConceptoDiferenciaCambio
            .Registro.Fields("Gravado").Value = mvarConIVA
            .Registro.Fields("Importe").Value = mvarImporte
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
         
         Set oRs = Nothing
         
         txtCotizacionDolar.Text = 0
         CalculaNotaDebito
         DoEvents
         
         If mvarIBrutos <> 0 Or mvarIBrutos2 <> 0 Then
            mvarImporte = mvarImporte - Round((mvarIBrutos + mvarIBrutos2) / (1 + (Val(txtPorcentajeIva1.Text) / 100)), 2)
            With origen.DetNotasDebito.Item(idDet)
               .Registro.Fields("Importe").Value = mvarImporte
            End With
            Lista.SelectedItem.SubItems(3) = "" & Format(mvarImporte, "#,##0.00")
            CalculaNotaDebito
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

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0 ' Agregar
         Editar -1
      Case 1
         Editar Lista.SelectedItem.Tag
      Case 2
         If mvarId > 0 Then
            MsgBox "No puede modificar una Nota de debito ya registrada!", vbExclamation
            Exit Sub
         End If
         With Lista.SelectedItem
            origen.DetNotasDebito.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         CalculaNotaDebito
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

Private Sub MostrarDatos(Index As Integer)

   If Not IsNumeric(dcfields(0).BoundText) Then Exit Sub
   
   Dim mvarLocalidad As Integer, mvarZona As Integer, mvarVendedor As Integer
   Dim mvarTransportista As Integer, mvarProvincia As Integer, mvarCondicionVenta As Integer, mvarTipoVentaC As Integer
   Dim mvarIdIBCondicion As Integer, mvarIdIBCondicion2 As Integer, mvarIdIBCondicion3 As Integer
   Dim Cambio As Boolean
   Dim mvarNumero As Long
   
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   ' Cargo los datos del Cliente
   
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
      mvarLocalidad = IIf(IsNull(.Fields("IdLocalidad").Value), 0, .Fields("IdLocalidad").Value)
'      mvarZona = oRs.Fields("IdZona").Value
      mvarProvincia = IIf(IsNull(.Fields("IdProvincia").Value), 0, .Fields("IdProvincia").Value)
'      mvarIBrutosC = .Fields("CodigoRetencionIBC").Value
'      mvarIBrutosB = .Fields("CodigoRetencionIBB").Value
'      mvarMultilateral = .Fields("EnConvenioMultilateral").Value
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
      mvarVendedor = IIf(IsNull(oRs.Fields("Vendedor1").Value), 0, oRs.Fields("Vendedor1").Value)
   Else
      mvarVendedor = IIf(IsNull(origen.Registro.Fields("IdVendedor").Value), 0, origen.Registro.Fields("IdVendedor").Value)
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

   oAp.TablasGenerales.Tabla = "Localidades"
   oAp.TablasGenerales.Id = mvarLocalidad
   Set oRs = oAp.TablasGenerales.Registro
   txtLocalidad.Text = IIf(IsNull(oRs.Fields("Nombre").Value), "", oRs.Fields("Nombre").Value)
   oRs.Close
   
   If Not IsNull(mvarProvincia) Then
      oAp.TablasGenerales.Tabla = "Provincias"
      oAp.TablasGenerales.Id = mvarProvincia
      Set oRs = oAp.TablasGenerales.Registro
      txtProvincia.Text = IIf(IsNull(oRs.Fields("Nombre").Value), "", oRs.Fields("Nombre").Value)
      oRs.Close
   End If
   
   oAp.TablasGenerales.Tabla = "DescripcionIva"
   oAp.TablasGenerales.Id = mvarTipoIVA
   Set oRs = oAp.TablasGenerales.Registro
   txtCondicionIva.Text = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
   oRs.Close
   
   Set oRs = oAp.VentasEnCuotas.TraerFiltrado("_PorIdClienteParaCombo", mvarIdCliente)
   If oRs.RecordCount > 0 Then
      Set dcfields(2).RowSource = oRs
      dcfields(2).Enabled = True
      txtNumeroCuota.Enabled = True
      If Not IsNull(origen.Registro.Fields("IdVentaEnCuotas").Value) Then
         dcfields(2).BoundText = origen.Registro.Fields("IdVentaEnCuotas").Value
      End If
   Else
      dcfields(2).Enabled = False
      txtNumeroCuota.Enabled = False
      With origen.Registro
         .Fields("IdVentaEnCuotas").Value = Null
         .Fields("NumeroCuota").Value = Null
      End With
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   If Cambio Then origen.Registro.Fields("IdVendedor").Value = mvarVendedor
   If mvarId > 0 And Not mvarModificacionHabilitada Then txtNumeroNotaDebito.Text = origen.Registro.Fields("NumeroNotaDebito").Value
   
   CalculaNotaDebito
   
   If EstadoEntidad("Clientes", mvarIdCliente) = "INACTIVO" Then
      MsgBox "Cliente inhabilitado, no podra registrar este comprobante", vbExclamation
   End If
   
End Sub

Private Sub Option5_Click()

   If Option5.Value Then
      CalculaNotaDebito
   End If
   
End Sub

Private Sub Option6_Click()

   If Option6.Value Then
      CalculaNotaDebito
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

Private Sub CalculaNotaDebito()

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim oL As ListItem
   Dim i As Integer, mIdProvinciaIIBB As Integer, mIdProvinciaRealIIBB As Integer
   Dim TSumaGravado As Double, TSumaNoGravado As Double, mTopeIIBB As Double, mImporteItem As Double
   Dim mvarIVANoDiscriminadoItem As Double
   Dim mCodigoProvincia As String, mPuntoVentaActivo As String
   Dim mFecha1 As Date
  
   mvarSubTotal = 0
   mvarMultilateral = "NO"
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
   mvarTotalNotaDebito = 0
   mvarIVANoDiscriminado = 0
   mvarPercepcionIVA = 0
   mPuntoVentaActivo = ""
   
   TSumaGravado = origen.DetNotasDebito.SumaImporteGravado
   TSumaNoGravado = origen.DetNotasDebito.SumaImporteNoGravado
   mvarSubTotal = TSumaGravado + TSumaNoGravado
   
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
   
   Set oRs = origen.DetNotasDebito.Registros
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If Not oRs.Fields("Eliminado").Value Then
               With origen.DetNotasDebito.Item(oRs.Fields(0).Value).Registro
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
         If IsNumeric(dcfields(10).BoundText) Then
            mvarPuntoVenta = dcfields(10).BoundText
         End If
         If mvarNumeracionUnica Then
            Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, mvarTipoABC, mPuntoVentaActivo))
         Else
            Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(3, mvarTipoABC, mPuntoVentaActivo))
         End If
         If oRs.RecordCount = 1 Then
            oRs.MoveFirst
            mvarPuntoVenta = oRs.Fields(0).Value
            If mvarId <= 0 Then
               origen.Registro.Fields("NumeroNotaDebito").Value = oRs.Fields("ProximoNumero").Value
               txtNumeroNotaDebito.Text = oRs.Fields("ProximoNumero").Value
            End If
         End If
         dcfields(10).Enabled = True
         Set dcfields(10).RowSource = oRs
         dcfields(10).BoundText = mvarPuntoVenta
         If Len(dcfields(10).Text) = 0 Then
            origen.Registro.Fields("NumeroNotaDebito").Value = Null
            txtNumeroNotaDebito.Text = ""
         End If
         Set oRs = Nothing
      Else
         dcfields(10).Enabled = False
         origen.Registro.Fields("IdPuntoVenta").Value = 0
         Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
         If Not origen Is Nothing Then
            origen.Registro.Fields("NumeroNotaDebito").Value = oRs.Fields("ProximaNotaDebitoInterna").Value
         End If
         oRs.Close
         Set oRs = Nothing
      End If
   End If
   
   mvarTotalNotaDebito = mvarSubTotal + mvarIVA1 + mvarIVA2 + mvarIBrutos + mvarIBrutos2 + mvarIBrutos3 + _
               Val(txtTotal(6).Text) + Val(txtTotal(7).Text) + Val(txtTotal(10).Text) + mvarPercepcionIVA
   
   lblLetra.Caption = mvarTipoABC
   txtTotal(3).Text = Format(mvarSubTotal, "#,##0.00")
   txtTotal(4).Text = Format(mvarIVA1, "#,##0.00")
   txtTotal(5).Text = Format(mvarIBrutos + mvarIBrutos2 + mvarIBrutos3, "#,##0.00")
   txtTotal(11).Text = Format(mvarPercepcionIVA, "#,##0.00")
   txtTotal(8).Text = Format(mvarTotalNotaDebito, "#,##0.00")
   
   Set oRs = Nothing
   Set oRs1 = Nothing
   
End Sub

Private Sub txtNumeroNotaDebito_Change()
   
   If mvarId > 0 Then MostrarDatos (0)

End Sub

Private Sub txtNumeroNotaDebito_Validate(Cancel As Boolean)

   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.NotasDebito.TraerFiltrado("_PorNumeroComprobante", Array(mvarTipoABC, Val(dcfields(10).Text), Val(txtNumeroNotaDebito.Text)))
   If oRs.RecordCount > 0 Then
      If oRs.Fields(0).Value <> mvarId Then
         MsgBox "Nota de debito ya ingresada el " & oRs.Fields("FechaNotaDebito").Value & ". Reingrese.", vbCritical
         Cancel = True
      End If
   End If
   oRs.Close
   Set oRs = Nothing

End Sub

Private Sub txtPorcentajeIva1_Change()

   CalculaNotaDebito

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

   CalculaNotaDebito

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

   If txtTotal(Index).Enabled Then CalculaNotaDebito
   
End Sub

Public Sub AnularDebito()

   Dim oRs As ADOR.Recordset
   
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
   
   Set oRs = Aplicacion.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(mvarId, 3))
   If oRs.RecordCount > 0 Then
      If oRs.Fields("ImporteTotal").Value <> oRs.Fields("Saldo").Value Then
         oRs.Close
         Set oRs = Nothing
         MsgBox "La nota de debito ha sido cancelada parcial o totalmente y no puede anularse", vbExclamation
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
      .IdFormulario = EnumFormularios.NotasDebito
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
   mSeguro = MsgBox("Esta seguro de anular la nota de debito?", vbYesNo, "Anulacion de nota de debito")
   If mSeguro = vbNo Then Exit Sub

   With origen
      .Registro.Fields("Anulada").Value = "SI"
      .Registro.Fields("IdUsuarioAnulacion").Value = mIdAutorizaAnulacion
      .Registro.Fields("FechaAnulacion").Value = Now
      .Guardar
   End With

   With actL2
      .ListaEditada = "NotasDebito"
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
   
   Set oRs = origen.DetNotasDebitoProvincias.Registros
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
      
      With origen.DetNotasDebitoProvincias.Item(-1)
         With .Registro
            .Fields("IdProvinciaDestino").Value = mIdProvincia
            .Fields("Porcentaje").Value = 100
         End With
         .Modificado = True
      End With
   End If

   Set oRs = Nothing

End Sub
