VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "msdatlst.ocx"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmRequerimientos 
   Caption         =   "Requerimientos de materiales"
   ClientHeight    =   7770
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11535
   Icon            =   "frmRequerimientos.frx":0000
   LinkTopic       =   "Form1"
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   7770
   ScaleWidth      =   11535
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame6 
      Height          =   690
      Left            =   5985
      TabIndex        =   88
      Top             =   1440
      Visible         =   0   'False
      Width           =   645
      Begin VB.OptionButton Option12 
         Caption         =   "SI"
         Height          =   240
         Left            =   45
         TabIndex        =   90
         Top             =   135
         Width           =   465
      End
      Begin VB.OptionButton Option13 
         Caption         =   "NO"
         Height          =   240
         Left            =   45
         TabIndex        =   89
         Top             =   360
         Width           =   555
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Adjuntos ?"
      Height          =   600
      Left            =   6255
      TabIndex        =   85
      Top             =   6840
      Visible         =   0   'False
      Width           =   1140
      Begin VB.OptionButton Option9 
         Caption         =   "NO"
         Height          =   240
         Left            =   540
         TabIndex        =   87
         Top             =   270
         Width           =   555
      End
      Begin VB.OptionButton Option8 
         Caption         =   "SI"
         Height          =   240
         Left            =   45
         TabIndex        =   86
         Top             =   270
         Width           =   465
      End
   End
   Begin RichTextLib.RichTextBox rchRequisitosSeguridad 
      Height          =   285
      Left            =   6030
      TabIndex        =   83
      Top             =   450
      Visible         =   0   'False
      Width           =   195
      _ExtentX        =   344
      _ExtentY        =   503
      _Version        =   393217
      Enabled         =   0   'False
      ScrollBars      =   2
      TextRTF         =   $"frmRequerimientos.frx":076A
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Frame Frame4 
      Height          =   510
      Left            =   90
      TabIndex        =   72
      Top             =   5760
      Visible         =   0   'False
      Width           =   11355
      Begin VB.TextBox txtMontoPrevisto1 
         DataField       =   "MontoPrevisto"
         BeginProperty DataFormat 
            Type            =   0
            Format          =   """$""#.##0,00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   11274
            SubFormatType   =   0
         EndProperty
         Height          =   315
         Left            =   10125
         TabIndex        =   82
         Top             =   135
         Width           =   1140
      End
      Begin VB.TextBox txtMesPresupuesto 
         DataField       =   "MesPresupuesto"
         BeginProperty DataFormat 
            Type            =   0
            Format          =   """$""#.##0,00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   11274
            SubFormatType   =   0
         EndProperty
         Height          =   315
         Left            =   8370
         TabIndex        =   79
         Top             =   135
         Width           =   420
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
         Height          =   315
         Left            =   3330
         TabIndex        =   77
         Top             =   135
         Width           =   1095
      End
      Begin VB.OptionButton Option10 
         Caption         =   "NO"
         Height          =   195
         Left            =   1305
         TabIndex        =   74
         Top             =   180
         Width           =   555
      End
      Begin VB.OptionButton Option11 
         Caption         =   "SI"
         Height          =   195
         Left            =   2070
         TabIndex        =   73
         Top             =   180
         Width           =   555
      End
      Begin MSDataListLib.DataCombo dcfields 
         DataField       =   "IdCuentaPresupuesto"
         Height          =   315
         Index           =   10
         Left            =   4500
         TabIndex        =   78
         Tag             =   "Cuentas"
         Top             =   135
         Width           =   2730
         _ExtentX        =   4815
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdCuenta"
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
      Begin VB.Label lblLabels 
         Caption         =   "Monto presup.:"
         Height          =   195
         Index           =   11
         Left            =   8955
         TabIndex        =   81
         Top             =   180
         Width           =   1185
      End
      Begin VB.Label lblLabels 
         Caption         =   "Mes (Presup.):"
         Height          =   195
         Index           =   10
         Left            =   7290
         TabIndex        =   80
         Top             =   180
         Width           =   1050
      End
      Begin VB.Label Label2 
         Caption         =   "Presupuesto ?"
         Height          =   195
         Index           =   1
         Left            =   135
         TabIndex        =   76
         Top             =   180
         Width           =   1095
      End
      Begin VB.Label lblData 
         Caption         =   "Cuenta :"
         Height          =   195
         Index           =   10
         Left            =   2655
         TabIndex        =   75
         Top             =   180
         Width           =   600
      End
   End
   Begin VB.TextBox txtFechaAprobacion1 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      Height          =   315
      Left            =   9720
      TabIndex        =   67
      Top             =   2070
      Visible         =   0   'False
      Width           =   1815
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Aprobo2"
      Height          =   315
      Index           =   8
      Left            =   7425
      TabIndex        =   68
      Tag             =   "Empleados"
      Top             =   2070
      Visible         =   0   'False
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin VB.Frame Frame3 
      Height          =   465
      Left            =   90
      TabIndex        =   60
      Top             =   6255
      Visible         =   0   'False
      Width           =   11355
      Begin VB.OptionButton Option7 
         Caption         =   "Para Orden de trabajo permanente (OP)"
         Height          =   195
         Left            =   2295
         TabIndex        =   64
         Top             =   180
         Width           =   3165
      End
      Begin VB.OptionButton Option6 
         Caption         =   "Para Orden de trabajo (OT)"
         Height          =   195
         Left            =   5535
         TabIndex        =   62
         Top             =   180
         Width           =   2265
      End
      Begin VB.OptionButton Option5 
         Caption         =   "Para Stock"
         Height          =   195
         Left            =   1035
         TabIndex        =   61
         Top             =   180
         Width           =   1140
      End
      Begin MSDataListLib.DataCombo dcfields 
         DataField       =   "IdOrdenTrabajo"
         Height          =   315
         Index           =   7
         Left            =   8460
         TabIndex        =   66
         Tag             =   "OrdenesTrabajo"
         Top             =   135
         Width           =   2805
         _ExtentX        =   4948
         _ExtentY        =   556
         _Version        =   393216
         Enabled         =   0   'False
         ListField       =   "Titulo"
         BoundColumn     =   "IdOrdenTrabajo"
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
      Begin VB.Label lblData 
         Caption         =   "OT :"
         Height          =   195
         Index           =   7
         Left            =   8055
         TabIndex        =   65
         Top             =   180
         Width           =   375
      End
      Begin VB.Label Label2 
         Caption         =   "Tipo RM :"
         Height          =   195
         Index           =   0
         Left            =   135
         TabIndex        =   63
         Top             =   180
         Width           =   780
      End
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
      Left            =   1800
      TabIndex        =   56
      Top             =   2295
      Width           =   2445
   End
   Begin VB.Frame Frame2 
      Height          =   375
      Left            =   4230
      TabIndex        =   52
      Top             =   2790
      Visible         =   0   'False
      Width           =   5280
      Begin VB.OptionButton Option4 
         Caption         =   "Directo a compras"
         Height          =   195
         Left            =   3555
         TabIndex        =   54
         Top             =   135
         Width           =   1635
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Control almacen"
         Height          =   195
         Left            =   1935
         TabIndex        =   53
         Top             =   135
         Width           =   1500
      End
      Begin VB.Label Label1 
         Caption         =   "Circuito de la RM :"
         Height          =   195
         Left            =   270
         TabIndex        =   55
         Top             =   135
         Width           =   1545
      End
   End
   Begin VB.TextBox txtDetalle 
      DataField       =   "Detalle"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
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
      Left            =   7110
      TabIndex        =   51
      Top             =   1890
      Width           =   4380
   End
   Begin VB.CommandButton cmdPegar 
      Height          =   600
      Left            =   2745
      Picture         =   "frmRequerimientos.frx":07EE
      Style           =   1  'Graphical
      TabIndex        =   49
      Top             =   6840
      UseMaskColor    =   -1  'True
      Width           =   795
   End
   Begin VB.TextBox txtFechaAprobacion 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      Height          =   315
      Left            =   4200
      TabIndex        =   45
      Top             =   1530
      Width           =   1815
   End
   Begin RichTextLib.RichTextBox rchMotivoAnulacion 
      Height          =   285
      Left            =   6210
      TabIndex        =   44
      Top             =   0
      Visible         =   0   'False
      Width           =   195
      _ExtentX        =   344
      _ExtentY        =   503
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmRequerimientos.frx":0C30
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.TextBox txtCliente 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
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
      Left            =   3915
      TabIndex        =   43
      Top             =   450
      Width           =   2100
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Anular toda la RM"
      Height          =   600
      Index           =   3
      Left            =   5400
      TabIndex        =   41
      Top             =   6840
      Width           =   795
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   600
      Index           =   1
      Left            =   4515
      Picture         =   "frmRequerimientos.frx":0CB4
      Style           =   1  'Graphical
      TabIndex        =   40
      Top             =   6840
      Width           =   795
   End
   Begin VB.TextBox txtMontoParaCompra 
      Alignment       =   1  'Right Justify
      DataField       =   "MontoParaCompra"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
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
      Height          =   360
      Left            =   8415
      TabIndex        =   38
      Top             =   7065
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   6
      Left            =   4410
      TabIndex        =   36
      Top             =   2700
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   5
      Left            =   4185
      TabIndex        =   35
      Top             =   2700
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   4
      Left            =   3960
      TabIndex        =   34
      Top             =   2700
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   3
      Left            =   3735
      TabIndex        =   33
      Top             =   2700
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   2
      Left            =   3510
      TabIndex        =   32
      Top             =   2700
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   1
      Left            =   3285
      TabIndex        =   31
      Top             =   2700
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   0
      Left            =   3060
      TabIndex        =   30
      Top             =   2700
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CommandButton cmd 
      Caption         =   "C&opiar items"
      Height          =   600
      Index           =   2
      Left            =   1860
      TabIndex        =   13
      Top             =   6840
      Width           =   795
   End
   Begin VB.TextBox TxtMontoPrevisto 
      Alignment       =   1  'Right Justify
      DataField       =   "MontoPrevisto"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
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
      Height          =   360
      Left            =   9990
      TabIndex        =   9
      Top             =   7065
      Visible         =   0   'False
      Width           =   1455
   End
   Begin RichTextLib.RichTextBox rchObservacionesDetalle 
      Height          =   285
      Left            =   6615
      TabIndex        =   24
      Top             =   0
      Visible         =   0   'False
      Width           =   195
      _ExtentX        =   344
      _ExtentY        =   503
      _Version        =   393217
      TextRTF         =   $"frmRequerimientos.frx":123E
   End
   Begin RichTextLib.RichTextBox rchLugarEntrega 
      Height          =   330
      Left            =   1800
      TabIndex        =   7
      Top             =   1890
      Width           =   4200
      _ExtentX        =   7408
      _ExtentY        =   582
      _Version        =   393217
      TextRTF         =   $"frmRequerimientos.frx":12C0
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1545
      Left            =   6165
      TabIndex        =   8
      Top             =   315
      Width           =   5325
      _ExtentX        =   9393
      _ExtentY        =   2725
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmRequerimientos.frx":1342
   End
   Begin VB.TextBox txtNumeroRequerimiento 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroRequerimiento"
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
      Left            =   1800
      TabIndex        =   0
      Top             =   45
      Width           =   1095
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   600
      Index           =   0
      Left            =   90
      TabIndex        =   10
      Top             =   6840
      Width           =   795
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   600
      Index           =   1
      Left            =   975
      TabIndex        =   11
      Top             =   6840
      Width           =   795
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   600
      Index           =   0
      Left            =   3630
      Picture         =   "frmRequerimientos.frx":13C4
      Style           =   1  'Graphical
      TabIndex        =   12
      Top             =   6840
      UseMaskColor    =   -1  'True
      Width           =   795
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   14
      Top             =   7485
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   7065
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRequerimientos.frx":1A2E
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRequerimientos.frx":1B40
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRequerimientos.frx":1F92
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRequerimientos.frx":23E4
            Key             =   "Original"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRequerimientos.frx":2836
            Key             =   "ItemManual"
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaRequerimiento"
      Height          =   330
      Index           =   0
      Left            =   4725
      TabIndex        =   1
      Top             =   45
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   51249153
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   0
      Left            =   1800
      TabIndex        =   2
      Tag             =   "Obras"
      Top             =   450
      Width           =   2100
      _ExtentX        =   3704
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdSolicito"
      Height          =   315
      Index           =   2
      Left            =   1800
      TabIndex        =   4
      Tag             =   "Empleados"
      Top             =   810
      Width           =   4200
      _ExtentX        =   7408
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdSector"
      Height          =   315
      Index           =   3
      Left            =   1800
      TabIndex        =   5
      Tag             =   "Sectores"
      Top             =   1170
      Width           =   4200
      _ExtentX        =   7408
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdSector"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Aprobo"
      Height          =   315
      Index           =   4
      Left            =   1800
      TabIndex        =   6
      Tag             =   "Empleados"
      Top             =   1530
      Width           =   2400
      _ExtentX        =   4233
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3795
      Left            =   45
      TabIndex        =   37
      Top             =   2970
      Width           =   11445
      _ExtentX        =   20188
      _ExtentY        =   6694
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmRequerimientos.frx":2C88
      OLEDragMode     =   1
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda"
      Height          =   360
      Index           =   5
      Left            =   6930
      TabIndex        =   47
      Tag             =   "Monedas"
      Top             =   7065
      Visible         =   0   'False
      Width           =   1410
      _ExtentX        =   2487
      _ExtentY        =   635
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Frame Frame1 
      Caption         =   "Imputacion RM :"
      Height          =   780
      Left            =   9945
      TabIndex        =   21
      Top             =   45
      Visible         =   0   'False
      Width           =   1500
      Begin VB.OptionButton Option2 
         Caption         =   "Por c.costo"
         Height          =   195
         Left            =   180
         TabIndex        =   23
         Top             =   540
         Width           =   1140
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Por obra"
         Height          =   195
         Left            =   180
         TabIndex        =   22
         Top             =   270
         Width           =   1140
      End
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCentroCosto"
      Height          =   315
      Index           =   1
      Left            =   7470
      TabIndex        =   3
      Tag             =   "CentrosCosto"
      Top             =   180
      Visible         =   0   'False
      Width           =   4200
      _ExtentX        =   7408
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdCentroCosto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdEquipoDestino"
      Height          =   315
      Index           =   6
      Left            =   4275
      TabIndex        =   57
      Tag             =   "Articulos1"
      Top             =   2295
      Width           =   7215
      _ExtentX        =   12726
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   9
      Left            =   5940
      TabIndex        =   70
      Top             =   2655
      Visible         =   0   'False
      Width           =   2085
      _ExtentX        =   3678
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Requisitos de seguridad :"
      Height          =   195
      Index           =   8
      Left            =   8145
      TabIndex        =   84
      Top             =   0
      Visible         =   0   'False
      Width           =   1830
   End
   Begin VB.Label lblData 
      Height          =   240
      Index           =   9
      Left            =   4635
      TabIndex        =   71
      Top             =   2700
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.Label lblData 
      Caption         =   "Liberada por (2) :"
      Height          =   240
      Index           =   8
      Left            =   6165
      TabIndex        =   69
      Top             =   2115
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.Label lblTabIndex 
      BackColor       =   &H00C0C0FF&
      Height          =   150
      Left            =   0
      TabIndex        =   59
      Top             =   0
      Width           =   105
   End
   Begin VB.Label lblLabels 
      Caption         =   "Equipo destino (opc.) :"
      Height          =   300
      Index           =   7
      Left            =   180
      TabIndex        =   58
      Top             =   2295
      Width           =   1545
   End
   Begin VB.Label lblAnulada 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "REQUERIMIENTO ANULADO"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   8100
      TabIndex        =   42
      Top             =   2655
      Visible         =   0   'False
      Width           =   3375
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Detalle : "
      Height          =   240
      Index           =   6
      Left            =   6210
      TabIndex        =   50
      Top             =   1935
      Width           =   855
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Moneda :"
      Height          =   195
      Index           =   5
      Left            =   6975
      TabIndex        =   48
      Top             =   6840
      Visible         =   0   'False
      Width           =   1350
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle de items"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Index           =   5
      Left            =   90
      TabIndex        =   46
      Top             =   2745
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Monto para compra :"
      Height          =   210
      Index           =   1
      Left            =   8415
      TabIndex        =   39
      Top             =   6840
      Visible         =   0   'False
      Width           =   1470
      WordWrap        =   -1  'True
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Autorizaciones : "
      Height          =   240
      Index           =   13
      Left            =   1800
      TabIndex        =   29
      Top             =   2655
      Width           =   1170
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Liberada por :"
      Height          =   240
      Index           =   4
      Left            =   180
      TabIndex        =   28
      Top             =   1575
      Width           =   1575
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Sector :"
      Height          =   240
      Index           =   3
      Left            =   180
      TabIndex        =   27
      Top             =   1215
      Width           =   1575
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Solicito :"
      Height          =   240
      Index           =   2
      Left            =   180
      TabIndex        =   26
      Top             =   855
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Monto previsto :"
      Height          =   210
      Index           =   2
      Left            =   9990
      TabIndex        =   25
      Top             =   6840
      Visible         =   0   'False
      Width           =   1470
      WordWrap        =   -1  'True
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Obra :"
      Height          =   240
      Index           =   0
      Left            =   180
      TabIndex        =   19
      Top             =   495
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Requerimiento nro. :"
      Height          =   285
      Index           =   14
      Left            =   180
      TabIndex        =   18
      Top             =   90
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Lugar de entrega :"
      Height          =   240
      Index           =   3
      Left            =   180
      TabIndex        =   17
      Top             =   1935
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   3690
      TabIndex        =   16
      Top             =   90
      Width           =   990
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Observaciones generales :"
      Height          =   195
      Index           =   0
      Left            =   6210
      TabIndex        =   15
      Top             =   90
      Width           =   1935
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Centro de costo :"
      Height          =   240
      Index           =   1
      Left            =   5850
      TabIndex        =   20
      Top             =   225
      Visible         =   0   'False
      Width           =   1575
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
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar fecha de necesidad"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar control de calidad"
         Index           =   4
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar factura de proveedor"
         Index           =   5
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar proveedor"
         Index           =   6
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Duplicar item"
         Index           =   7
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Renumerar items"
         Index           =   8
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Anular Items"
         Index           =   9
      End
   End
   Begin VB.Menu MnuDetConsultas 
      Caption         =   "Consultas"
      Visible         =   0   'False
      Begin VB.Menu MnuDetCon 
         Caption         =   "Control de Acopio + Req. Materiales + Reservas de Stock contra Listas de Materiales"
         Index           =   0
      End
   End
End
Attribute VB_Name = "frmRequerimientos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Requerimiento
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mIdAprobo As Long, mIdAprobo1 As Long
Private mCantidadFirmas As Integer, mFirmasLiberacion As Integer
Private mvarGrabado As Boolean, mvarPorObra As Boolean, mvarModificado As Boolean
Private mFirmaActiva As Boolean, mvarAnulada As Boolean, mvarLiberada As Boolean
Private mvarImpresionHabilitada As Boolean
Private mPassword As String, mTipoObra As String, mCampoAprobo As String
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

Public Property Let Password(ByVal mPass As String)
   
   mPassword = mPass
   If Len(mPass) > 0 Then
      mFirmaActiva = True
   End If
   
End Property

Sub Editar(ByVal Cual As Long)

   If mvarId > 0 And Cual = -1 And Not AprobadoEdicion Then
      MsgBox "No puede modificar un requerimiento ya registrado!", vbCritical
      Exit Sub
   End If
   
   If IsNull(origen.Registro.Fields("IdObra").Value) And IsNull(origen.Registro.Fields("IdCentroCosto").Value) Then
      MsgBox "Debe definir una obra o centro de costos antes", vbCritical
      Exit Sub
   End If
   
   If mvarAnulada Then
      MsgBox "La RM ha sido anulada y no puede modificarse!", vbCritical
      Exit Sub
   End If

   Dim oF As frmDetRequerimientos
   Dim oL As ListItem
   
   Set oF = New frmDetRequerimientos
   
   With oF
      Set .Requerimiento = origen
      If Check1(0).Value = 1 And Check1(1).Value = 1 Then
         .HabilitadaParaModificar = False
      Else
         .HabilitadaParaModificar = True
      End If
      If Frame3.Visible Then
         If Option5.Value Then
            .TipoRequerimiento = "ST"
         ElseIf Option6.Value Then
            .TipoRequerimiento = "OT"
         ElseIf Option7.Value Then
            .TipoRequerimiento = "OP"
         End If
      Else
         .TipoRequerimiento = ""
      End If
      If IsNumeric(dcfields(6).BoundText) Then
         .IdEquipoDestino = dcfields(6).BoundText
      Else
         .IdEquipoDestino = 0
      End If
      .FechaRequerimiento = DTFields(0).Value
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         mvarModificado = True
         If Cual = -1 Then
            Set oL = Lista.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = Lista.SelectedItem
         End If
         With oL
            If Len(oF.DataCombo1(1).BoundText) Then
               If Cual = -1 Then
                  .SmallIcon = "Nuevo"
               Else
                  .SmallIcon = "Modificado"
               End If
            Else
               .SmallIcon = "ItemManual"
            End If
            .Text = oF.txtItem
            .SubItems(1) = "" & oF.txtNumeroLMateriales
            .SubItems(2) = "" & oF.txtNumeroItemLMateriales
            .SubItems(3) = "" & oF.txtCantidad
            .SubItems(4) = "" & oF.DataCombo1(0).Text
            .SubItems(5) = "" & oF.txtCantidad1
            .SubItems(6) = "" & oF.txtCantidad2
            .SubItems(7) = "" & oF.txtCodigoArticulo.Text
            If Len(oF.DataCombo1(1).BoundText) Then
               .SubItems(8) = "" & oF.DataCombo1(1).Text
            Else
               .SubItems(8) = "" & oF.txtDescripcionManual.Text
            End If
            .SubItems(9) = "" & oF.DTFields(0).Value
            If IsNumeric(oF.DataCombo1(4).BoundText) Then
               .SubItems(10) = "" & Aplicacion.ControlesCalidad.Item(oF.DataCombo1(4).BoundText).Registro.Fields("Abreviatura").Value
            End If
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Sub EditarConsulta(ByVal Item As Long)

   Select Case Item
      
      Case 0
         
         If Not Option1.Value Then
            MsgBox "La consulta solo es para requerimientos de obras.", vbCritical
            Exit Sub
         End If
         
         If IsNull(origen.Registro.Fields("IdObra").Value) Then
            MsgBox "Debe definir la obra primero"
            Exit Sub
         End If
         
         If origen.Registro.Fields("IdObra").Value = 0 Then
            MsgBox "Este requerimiento no tiene asignada obra!"
            Exit Sub
         End If
         
         Dim oF As frmArticulosRequerimientos
         
         Set oF = New frmArticulosRequerimientos
         
         With oF
            .Obra = origen.Registro.Fields("IdObra").Value
            .dcfields(0).Visible = False
            .CalcularFaltante
            .Show vbModal, Me
         End With
         
         Unload oF
         Set oF = Nothing
         
   End Select
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Dim mvarSale As Integer
   Dim mIdAutorizo As Long
   Dim oL As ListItem
   
   Select Case Index
   
      Case 0
      
         If mvarId < 0 And Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar una Lista de Requerimiento sin detalles"
            Exit Sub
         End If
         
         If Frame4.Visible Then
            If Not Option10.Value And Not Option11.Value Then
               MsgBox "Debe indicar si hay o no presupuesto para la RM", vbExclamation
               Exit Sub
            End If
            If Option11.Value Then
               If Val(txtMesPresupuesto.Text) < 1 Or Val(txtMesPresupuesto.Text) > 12 Then
                  MsgBox "Debe indicar un mes de asignacion presupuestaria valido", vbExclamation
                  Exit Sub
               End If
               If Len(txtMontoPrevisto1.Text) = 0 Or Not IsNumeric(txtMontoPrevisto1.Text) Then
                  MsgBox "Debe indicar un monto de asignacion presupuestaria", vbExclamation
                  Exit Sub
               End If
            End If
         End If

         If Frame5.Visible And Not Option8.Value And Not Option9.Value Then
            MsgBox "Debe indicar si hay o no adjuntos a la RM", vbExclamation
            Exit Sub
         End If

         If Frame6.Visible And Not Option12.Value And Not Option13.Value Then
            MsgBox "Debe indicar si hay o no requisitos de seguridad para la RM", vbExclamation
            Exit Sub
         End If

         If Option12.Value And Len(rchRequisitosSeguridad.Text) = 0 Then
            MsgBox "Debe ingresar los requisitos de seguridad para la RM", vbExclamation
            Exit Sub
         End If

'         If Len(Trim(txtMontoParaCompra.Text)) = 0 Or Not IsNumeric(txtMontoParaCompra.Text) Then
'            MsgBox "Debe ingresar un monto para compra", vbExclamation
'            Exit Sub
'         End If
         
'         If Not Val(txtMontoParaCompra.Text) > 0 Then
'            MsgBox "El monto para compra debe ser mayor a cero", vbExclamation
'            Exit Sub
'         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim mvarImprime As Integer, mResp As Integer, i As Integer
         Dim mCumplido As Boolean, mConfirmado As Boolean
         Dim mAuxS1 As String, mAuxS2 As String, mAuxS3 As String, mAuxS4 As String
         Dim oPar As ComPronto.Parametro
         Dim oRs As ADOR.Recordset
         Dim oRsAux As ADOR.Recordset
         Dim mNum As Long
         
         mConfirmado = True
         For Each oL In Lista.ListItems
            With origen.DetRequerimientos.Item(oL.Tag)
               If IsNull(.Registro.Fields("IdArticulo").Value) Then
                  mConfirmado = False
                  Exit For
               End If
            End With
         Next
         
         mAuxS1 = BuscarClaveINI("Controlar ubicacion estandar en RM")
         mAuxS3 = BuscarClaveINI("Exigir etapa de obra en circuito de compras para requerimientos")
         mAuxS4 = BuscarClaveINI("Exigir fecha necesidad mayor a fecha de RM")
         mAuxS2 = ""
         Set oRs = origen.DetRequerimientos.Registros
         With oRs
            If .Fields.Count > 0 Then
               If .RecordCount > 0 Then
                  .MoveFirst
                  Do While Not .EOF
                     If Not .Fields("Eliminado").Value Then
                        If IsNull(.Fields("IdArticulo").Value) Then
                           MsgBox "Hay items sin articulo", vbExclamation
                           Set oRs = Nothing
                           Exit Sub
                        End If
                        If IsNull(.Fields("IdUnidad").Value) Then
                           MsgBox "Hay items sin unidad de medida", vbExclamation
                           Set oRs = Nothing
                           Exit Sub
                        End If
                        If mAuxS1 = "SI" Then
                           Set oRsAux = Aplicacion.Articulos.TraerFiltrado("_PorId", .Fields("IdArticulo").Value)
                           If oRsAux.RecordCount > 0 Then
                              If IsNull(oRsAux.Fields("IdUbicacionStandar").Value) Then
                                 mAuxS2 = mAuxS2 & vbCrLf & oRsAux.Fields("Descripcion").Value
                              End If
                           End If
                           oRsAux.Close
                        End If
                        If mAuxS3 = "SI" Then
                           If IsNull(.Fields("IdDetalleObraDestino").Value) Then
                              MsgBox "Hay items sin etapa de obra", vbExclamation
                              Set oRs = Nothing
                              Exit Sub
                           End If
                           If IsNull(.Fields("IdPresupuestoObraRubro").Value) Then
                              MsgBox "Hay items sin el rubro para presupuesto de obra", vbExclamation
                              Set oRs = Nothing
                              Exit Sub
                           End If
                        End If
                        If mAuxS4 = "SI" Then
                           If .Fields("FechaEntrega").Value <= DTFields(0).Value Then
                              MsgBox "Hay items con fecha de necesidad anterior a la fecha del requerimiento", vbExclamation
                              Exit Sub
                           End If
                        End If
                     End If
                     .MoveNext
                  Loop
               End If
            End If
         End With
         Set oRs = Nothing
         Set oRsAux = Nothing
         If Len(mAuxS2) > 0 Then
            MsgBox "Los siguientes items no tienen ubicacion standar :" & mAuxS2, vbExclamation
            Exit Sub
         End If
         
         With origen.Registro
            For Each dc In dcfields
               If dc.Enabled And dc.Visible Then
                  If Not IsNumeric(dc.BoundText) And dc.Index <> 4 And dc.Index <> 6 And dc.Index <> 8 Then
                     MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
                     Exit Sub
                  End If
                  If IsNumeric(dc.BoundText) Then
                     .Fields(dc.DataField).Value = dc.BoundText
                  End If
               End If
            Next
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
            If Option3.Value Then
               .Fields("DirectoACompras").Value = "NO"
            Else
               .Fields("DirectoACompras").Value = "SI"
            End If
            If mConfirmado Then
               .Fields("Confirmado").Value = "SI"
            Else
               .Fields("Confirmado").Value = "NO"
            End If
            .Fields("Observaciones").Value = rchObservaciones.Text
            .Fields("LugarEntrega").Value = rchLugarEntrega.Text
            .Fields("RequisitosSeguridad").Value = rchRequisitosSeguridad.Text
            If Option5.Value Then
               .Fields("TipoRequerimiento").Value = "ST"
            ElseIf Option6.Value Then
               .Fields("TipoRequerimiento").Value = "OT"
            ElseIf Option7.Value Then
               .Fields("TipoRequerimiento").Value = "OP"
            End If
            If Option8.Value Then
               .Fields("Adjuntos").Value = "SI"
            Else
               .Fields("Adjuntos").Value = "NO"
            End If
         End With
         
         mCumplido = True
         For Each oL In Lista.ListItems
            With origen.DetRequerimientos.Item(oL.Tag)
               If IsNull(.Registro.Fields("Cumplido").Value) Or .Registro.Fields("Cumplido").Value <> "SI" Then
                  mCumplido = False
                  Exit For
               End If
            End With
         Next
         
         If mCumplido Then
            mResp = MsgBox("Todos los items de la RM han sido cumplidos!" & vbCrLf & "Desea pasar la RM al archivo historico ?", vbYesNo)
            If mResp = vbYes Then
               origen.Registro.Fields("Cumplido").Value = "SI"
            End If
         End If
         
         Me.MousePointer = vbHourglass
      
'         If mvarId < 0 Then
'            Set oPar = Aplicacion.Parametros.Item(1)
'            mNum = oPar.Registro.Fields("ProximoNumeroRequerimiento").Value
'            For i = 1 To 1000
'               Set oRs = Aplicacion.Requerimientos.TraerFiltrado("_ValidarNumero", Array(origen.Registro.Fields("NumeroRequerimiento").Value, mvarId))
'               If oRs.RecordCount > 0 Then
'                  oRs.Close
'                  If i = 1 Then MsgBox "El numero de requerimiento ya fue utilizado," & vbCrLf & _
'                                       "el sistema buscara el siguiente numero disponible", vbExclamation, _
'                                       "Numero de requerimiento"
'                  origen.Registro.Fields("NumeroRequerimiento").Value = mNum
'                  mNum = mNum + 1
'               Else
'                  oRs.Close
'                  If i > 1 Or origen.Registro.Fields("NumeroRequerimiento").Value = mNum Then
'                     With oPar
'                        .Registro.Fields("ProximoNumeroRequerimiento").Value = IIf(i > 1, mNum, mNum + 1)
'                        .Guardar
'                     End With
'                  End If
'                  Exit For
'               End If
'            Next
'            Set oRs = Nothing
'            Set oPar = Nothing
'            If i > 1 Then MsgBox "El numero asignado a este requerimiento es el " & origen.Registro.Fields("NumeroRequerimiento").Value, vbInformation
'         End If
         
         Select Case origen.Guardar
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
         
         With origen.Registro
            If Not mvarLiberada And Not IsNull(.Fields(mCampoAprobo).Value) Then
               Set oRs = Aplicacion.AutorizacionesPorComprobante.TraerFiltrado("_PorIdRM", .Fields(0).Value)
               If oRs.RecordCount > 0 Then
                  oRs.MoveFirst
                  Do While Not oRs.EOF
                     If Not IsNull(oRs.Fields("Autoriza").Value) Then
                        origen.GuardarNovedadUsuario 2, oRs.Fields("Autoriza").Value, "Firmar RM: " & .Fields("NumeroRequerimiento").Value & " del " & .Fields("FechaRequerimiento").Value
                     End If
                     oRs.MoveNext
                  Loop
               End If
               oRs.Close
               Set oRs = Nothing
               origen.GuardarNovedadUsuario 3, -1, "Asignar stock a RM " & .Fields("NumeroRequerimiento").Value & " del " & .Fields("FechaRequerimiento").Value
            End If
         End With
         
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
            mvarGrabado = True
         
            Set oRs = Aplicacion.Requerimientos.TraerFiltrado("_PorId", mvarId)
            If oRs.RecordCount > 0 Then
               oRs.MoveFirst
               If oRs.Fields("NumeroRequerimiento").Value <> txtNumeroRequerimiento.Text Then
                  MsgBox "El numero de requerimiento a cambiado," & vbCrLf & _
                           "el nuevo numero asignado es el " & oRs.Fields("NumeroRequerimiento").Value & ".", vbInformation
               End If
            End If
            oRs.Close
            Set oRs = Nothing
         Else
            est = Modificacion
         End If
         
         mvarModificado = False
         
         If Not actL2 Is Nothing Then
            With actL2
               .ListaEditada = "RequerimientosTodos,RequerimientosObras," & _
                               "RequerimientosCC,+ObrXRM,HRequerimientos," & _
                               "+ObHXRM,+SubRq2,RequerimientosAConfirmar,+SubRo1," & _
                               "RequerimientosALiberar"
               .AccionRegistro = est
               .Disparador = mvarId
            End With
         End If
         
         Me.MousePointer = vbDefault
      
         If mvarImpresionHabilitada Then
            mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de Requerimiento de materiales")
            If mvarImprime = vbYes Then
               cmdImpre_Click (0)
            End If
         End If
      
         Unload Me

      Case 1
      
         If mvarModificado And Not mvarAnulada Then
            mvarSale = MsgBox("Hay datos no grabados, desea salir igual ?", vbYesNo, "Salir")
            If mvarSale = vbNo Then
               Exit Sub
            End If
            mvarModificado = False
         End If
   
         Unload Me

      Case 2
      
         Dim Cadena As String
         Cadena = Lista.GetString
         If Len(Trim(Cadena)) > 0 Then
            Cadena = Replace(Cadena, "Id" & vbTab, "Requerimiento" & vbTab)
            With Clipboard
               .Clear
               .SetText Cadena
            End With
            MsgBox "Items copiados correctamente", vbInformation
         Else
            MsgBox "No hay informacion a copiar", vbExclamation
         End If
   
      Case 3
      
         mvarSale = MsgBox("Esta seguro de anular la RM ?", vbYesNo, "Anulacion")
         If mvarSale = vbNo Then
            Exit Sub
         End If
         
         Dim oF As Form
         Set oF = New frmAutorizacion
         With oF
            .Empleado = 0
            .IdFormulario = EnumFormularios.RequerimientoMateriales
            .Show vbModal, Me
         End With
         If Not oF.Ok Then
            MsgBox "No puede anular la RM!", vbExclamation
            Unload oF
            Set oF = Nothing
            Exit Sub
         End If
         mIdAutorizo = oF.IdAutorizo
         Unload oF
         Set oF = Nothing

         Set oF = New frmAnulacion
         With oF
            .Caption = "Motivo de anulacion del requerimiento"
            .Text1.Text = "Usuario : " & Aplicacion.Empleados.Item(mIdAutorizo).Registro.Fields("Nombre").Value & " - [" & Now & "]"
            .Show vbModal, Me
         End With
         If Not oF.Ok Then
            MsgBox "Anulacion cancelada!", vbExclamation
            Unload oF
            Set oF = Nothing
            Exit Sub
         End If
         rchMotivoAnulacion.Text = oF.rchAnulacion.Text
         Unload oF
         Set oF = Nothing

         mvarModificado = False
   
         For Each oL In Lista.ListItems
            With origen.DetRequerimientos.Item(oL.Tag)
               .Registro.Fields("Cumplido").Value = "AN"
               .Registro.Fields("EnviarEmail").Value = 1
               .Modificado = True
            End With
         Next
         
         Dim oRsUsuario As ADOR.Recordset
         Dim mAnulo As String
         Set oRsUsuario = Aplicacion.Empleados.TraerFiltrado("_PorId", mIdAutorizo)
         mAnulo = IIf(IsNull(oRsUsuario.Fields("Nombre").Value), "", oRsUsuario.Fields("Nombre").Value)
         
         With origen.Registro
            .Fields("Cumplido").Value = "AN"
            .Fields("FechaAnulacion").Value = Now
            If Not IsNull(oRsUsuario.Fields("Iniciales").Value) Then
               .Fields("UsuarioAnulacion").Value = oRsUsuario.Fields("Iniciales").Value
            End If
            .Fields("MotivoAnulacion").Value = rchMotivoAnulacion.Text
         End With
   
         oRsUsuario.Close
         Set oRsUsuario = Nothing
         
         origen.Guardar
   
         Dim mEmail As String
         If Not IsNumeric(dcfields(2).BoundText) Then
            Unload Me
            Exit Sub
         End If
         Set oRsUsuario = Aplicacion.Empleados.TraerFiltrado("_PorId", dcfields(2).BoundText)
         mEmail = ""
         If oRsUsuario.RecordCount > 0 Then
            mEmail = IIf(IsNull(oRsUsuario.Fields("Email").Value), "", oRsUsuario.Fields("Email").Value)
         End If
         oRsUsuario.Close
         Set oRsUsuario = Nothing
         If Len(mEmail) = 0 Then Exit Sub
         
         mvarSale = MsgBox("Desea enviar un mail avisando al solicitante?", vbYesNo, "Anulacion")
         If mvarSale = vbNo Then
            Exit Sub
         End If
         
         Dim lStatus As Long
         Dim mLista As String, mSubject As String, mBody As String
         Dim goMailOL As CEmailOL
         
         Set goMailOL = New CEmailOL
         mLista = mEmail
         mSubject = "Aviso de anulacion de RM"
         mBody = "" & vbCrLf & "La RM " & txtNumeroRequerimiento.Text & " ha sido " & _
               "anulada por " & mAnulo & " el " & Now & "."
         lStatus = goMailOL.Send(mLista, True, mSubject, mBody, "")
         Set goMailOL = Nothing
         
         Unload Me

   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oDet As ComPronto.DetRequerimiento
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset, oRsAut As ADOR.Recordset
   Dim oL As ListItem
   Dim dtf As DTPicker
   Dim dc As DataCombo
   Dim ListaVacia As Boolean
   Dim i As Integer
   Dim mTextoAnulacion As String, mComboObrasConDescripcion As String, mCampo As String
   Dim mvarActivarSolicitudMateriales As String
   
   mvarId = vnewvalue
   
   ListaVacia = False
   mvarModificado = False
   mvarAnulada = False
   mFirmaActiva = False
   mPassword = ""
   mTextoAnulacion = ""
   mTipoObra = ""
   mvarImpresionHabilitada = True
   
   Lista.Sorted = False
   
   mComboObrasConDescripcion = BuscarClaveINI("Combo de obras con descripcion")
   If BuscarClaveINI("No permitir modificar fecha de RM") = "SI" Then
      DTFields(0).Enabled = False
   End If
   If BuscarClaveINI("Bloqueo de campos RM") = "SI" Then
      dcfields(2).Enabled = False
      dcfields(3).Enabled = False
   End If
   If BuscarClaveINI("Habilitar tipo de compra en RM") = "SI" Then
      With lblData(9)
         .Caption = "Tipo compra :"
         .Top = 2700
         .Left = 4600
         .Visible = True
      End With
      With dcfields(9)
         .Top = lblData(9).Top
         .Left = lblData(9).Left + lblData(9).Width + 100
         .BoundColumn = "IdTipoCompra"
         .DataField = "IdTipoCompra"
         Set .RowSource = Aplicacion.TablasGenerales.TraerFiltrado("TiposCompra", "_ParaCombo")
         .Visible = True
      End With
   End If
   If BuscarClaveINI("Inhabilitar impresion de RM") = "SI" Then
      mvarImpresionHabilitada = False
   End If
   
   Set oAp = Aplicacion
   Set origen = oAp.Requerimientos.Item(vnewvalue)
   
   If glbParametrizacionNivel1 Then
      origen.NivelParametrizacion = 1
      MnuDetA(4).Visible = False
      MnuDetA(5).Visible = False
      MnuDetA(6).Visible = False
      txtCliente.Visible = False
      lblLabels(7).Visible = False
      txtCodigoArticulo1.Visible = False
      dcfields(6).Visible = False
      dcfields(0).Width = dcfields(2).Width
   End If
   
   Set oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
   mvarActivarSolicitudMateriales = IIf(IsNull(oRs.Fields("ActivarSolicitudMateriales").Value), "NO", oRs.Fields("ActivarSolicitudMateriales").Value)
   oRs.Close
   If mvarActivarSolicitudMateriales = "SI" Then
      Lista.Height = Lista.Height * 0.85
      Frame3.Visible = True
   End If
   
   If BuscarClaveINI("Requerir asignacion presupuestaria en RM") = "SI" Then
      Lista.Height = Lista.Height * 0.85
      Frame4.Visible = True
      If mvarActivarSolicitudMateriales <> "SI" Then Frame4.Top = Frame3.Top
   End If
   
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_Parametros2BuscarClave", "AprobacionesRM")
   mFirmasLiberacion = 1
   If oRs.RecordCount > 0 Then
      If IIf(IsNull(oRs.Fields("Valor").Value), 1, Val(oRs.Fields("Valor").Value)) = 2 Then
         mFirmasLiberacion = 2
         rchObservaciones.Height = rchObservaciones.Height * 0.8
         With lblData(8)
            .Left = rchObservaciones.Left
            .Top = lblData(4).Top
            .Visible = True
         End With
         With dcfields(8)
            .Left = lblData(8).Left + lblData(8).Width + 10
            .Top = dcfields(4).Top
            .Visible = True
         End With
         With txtFechaAprobacion1
            .Left = dcfields(8).Left + dcfields(8).Width + 10
            .Top = txtFechaAprobacion.Top
            .Visible = True
         End With
      End If
   End If
   oRs.Close
   
   If BuscarClaveINI("Pedir requisitos de seguridad en RM") = "SI" Then
      rchObservaciones.Height = rchObservaciones.Height * 0.5
      With lblLabels(8)
         .Top = rchObservaciones.Top + rchObservaciones.Height
         .Left = rchObservaciones.Left
         .Visible = True
      End With
      With Frame6
         .Top = lblLabels(8).Top + lblLabels(8).Height
         .Left = rchObservaciones.Left
         .Height = rchObservaciones.Height * 0.8
         .Visible = True
      End With
      With rchRequisitosSeguridad
         .Top = Frame6.Top
         .Left = Frame6.Left + Frame6.Width + 10
         .Width = rchObservaciones.Width - Frame6.Width - 10
         .Height = Frame6.Height
         .Visible = True
      End With
   End If
   
   If BuscarClaveINI("Requerir existencia de adjuntos en RM") = "SI" Then
      Frame5.Visible = True
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
                     Set oControl.DataSource = origen.DetRequerimientos.TraerMascara
                     ListaVacia = True
                  Else
                     Set oRs = origen.DetRequerimientos.TraerTodos
                     If Not oRs Is Nothing Then
                        If oRs.RecordCount <> 0 Then
                           Set oControl.DataSource = oRs
                           oRs.MoveFirst
                           Do While Not oRs.EOF
                              Set oDet = origen.DetRequerimientos.Item(oRs.Fields(0).Value)
                              oDet.Modificado = True
                              Set oDet = Nothing
                              oRs.MoveNext
                           Loop
                           ListaVacia = False
                        Else
                           Set oControl.DataSource = origen.DetRequerimientos.TraerMascara
                           ListaVacia = True
                        End If
                        oRs.Close
                     End If
                  End If
            End Select
         ElseIf TypeOf oControl Is label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Obras" Then
                  If mComboObrasConDescripcion <> "SI" Then
                     If glbSe�al1 Then
                        Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", Date))
                     Else
                        Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo")
                     End If
                  Else
                     If glbSe�al1 Then
                        Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaComboConDescripcion", Array("SI", Date))
                     Else
                        Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaComboConDescripcion")
                     End If
                  End If
               ElseIf oControl.Tag = "OrdenesTrabajo" Then
                  If mvarId <= 0 Then
                     Set oControl.RowSource = oAp.OrdenesTrabajo.TraerFiltrado("_SegunFechaFinalizacion", Date)
                  Else
                     Set oControl.RowSource = oAp.OrdenesTrabajo.TraerFiltrado("_SegunFechaFinalizacion", origen.Registro.Fields("FechaRequerimiento").Value)
                  End If
               ElseIf oControl.Tag = "Articulos1" Then
                  Set oControl.RowSource = oAp.Articulos.TraerFiltrado("_ParaMantenimiento_ParaCombo")
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
   
   Check1(0).Visible = True
   Option1.Value = True
   
   If mvarId = -1 Then
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      Set oPar = oAp.Parametros.Item(1)
      With origen.Registro
         .Fields("NumeroRequerimiento").Value = oPar.Registro.Fields("ProximoNumeroRequerimiento").Value
         .Fields("IdSolicito").Value = glbIdUsuario
         .Fields("IdSector").Value = oAp.Empleados.Item(glbIdUsuario).Registro.Fields("IdSector").Value
         .Fields("LugarEntrega").Value = ""
         If glbIdObraAsignadaUsuario > 0 Then .Fields("IdObra").Value = glbIdObraAsignadaUsuario
      End With
      Set oPar = Nothing
      Option4.Value = True
      If mvarActivarSolicitudMateriales = "SI" Then Option5.Value = True
      mvarGrabado = False
      mvarLiberada = False
      mIdAprobo = 0
      mIdAprobo1 = 0
   Else
      With origen.Registro
         If Not IsNull(.Fields("IdObra").Value) Then
            Option1.Value = True
            dcfields(0).Enabled = True
            MostrarCliente .Fields("IdObra").Value
         Else
            Option2.Value = True
            dcfields(1).Enabled = True
         End If
         mvarLiberada = False
         If Not IsNull(.Fields("Aprobo").Value) Then
            mIdAprobo = .Fields("Aprobo").Value
            If mFirmasLiberacion = 1 Then
               mvarLiberada = True
               Check1(0).Value = 1
            End If
         End If
         If Not IsNull(.Fields("Aprobo2").Value) Then
            mIdAprobo1 = .Fields("Aprobo2").Value
            mvarLiberada = True
            Check1(0).Value = 1
         End If
         If .Fields("Cumplido").Value = "AN" Then
            If Not IsNull(.Fields("UsuarioAnulacion").Value) Then
               mTextoAnulacion = "Usuario : " & .Fields("UsuarioAnulacion").Value & vbCrLf
            End If
            If Not IsNull(.Fields("FechaAnulacion").Value) Then
               mTextoAnulacion = mTextoAnulacion & "Fecha anulacion : " & .Fields("FechaAnulacion").Value & vbCrLf
            End If
         End If
         If Not IsNull(.Fields("FechaAprobacion").Value) Then
            txtFechaAprobacion.Text = .Fields("FechaAprobacion").Value
         End If
         If Not IsNull(.Fields("FechaAprobacion2").Value) Then
            txtFechaAprobacion1.Text = .Fields("FechaAprobacion2").Value
         End If
         If IsNull(.Fields("DirectoACompras").Value) Or .Fields("DirectoACompras").Value = "SI" Then
            Option4.Value = True
         Else
            Option3.Value = True
         End If
         If Not IsNull(.Fields("IdEquipoDestino").Value) Then
            txtCodigoArticulo1.Text = TraerCodigoArticulo(.Fields("IdEquipoDestino").Value)
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
         rchLugarEntrega.TextRTF = IIf(IsNull(.Fields("LugarEntrega").Value), "", .Fields("LugarEntrega").Value)
         rchRequisitosSeguridad.TextRTF = IIf(IsNull(.Fields("RequisitosSeguridad").Value), "", .Fields("RequisitosSeguridad").Value)
         If Len(rchRequisitosSeguridad.Text) > 0 Then
            Option12.Value = True
            rchRequisitosSeguridad.Enabled = True
         Else
            Option13.Value = True
         End If
         If mvarActivarSolicitudMateriales = "SI" Then
            If IsNull(.Fields("TipoRequerimiento").Value) Then
               Option5.Value = True
            ElseIf .Fields("TipoRequerimiento").Value = "ST" Then
               Option5.Value = True
            ElseIf .Fields("TipoRequerimiento").Value = "OT" Then
               Option6.Value = True
            ElseIf .Fields("TipoRequerimiento").Value = "OP" Then
               Option7.Value = True
            End If
         End If
         If IsNull(.Fields("IdCuentaPresupuesto").Value) Then
            Option10.Value = True
         Else
            Option11.Value = True
         End If
         If Not IsNull(.Fields("Adjuntos").Value) Then
            If .Fields("Adjuntos").Value = "SI" Then
               Option8.Value = True
            Else
               Option9.Value = True
            End If
         End If
      End With
      
      mCantidadFirmas = 0
      Set oRsAut = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(EnumFormularios.RequerimientoMateriales, 0))
      If oRsAut.RecordCount > 0 Then
         oRsAut.MoveFirst
         Do While Not oRsAut.EOF
            mCantidadFirmas = mCantidadFirmas + 1
            Check1(mCantidadFirmas).Visible = True
            Check1(mCantidadFirmas).Tag = oRsAut.Fields(0).Value
            oRsAut.MoveNext
         Loop
      End If
      oRsAut.Close
      Set oRsAut = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(EnumFormularios.RequerimientoMateriales, mvarId))
      If oRsAut.RecordCount > 0 Then
         oRsAut.MoveFirst
         Do While Not oRsAut.EOF
            For i = 1 To mCantidadFirmas
               If Check1(i).Tag = oRsAut.Fields("OrdenAutorizacion").Value Then
                  Check1(i).Value = 1
                  Exit For
               End If
            Next
            oRsAut.MoveNext
         Loop
      End If
      oRsAut.Close
      Set oRsAut = Nothing
      If Check1(0).Value = 1 And Check1(1).Value = 1 Then
         For Each dc In dcfields
            If dc.Enabled Then
               dc.Enabled = False
            End If
         Next
         DTFields(0).Enabled = False
         rchLugarEntrega.Enabled = False
         TxtMontoPrevisto.Enabled = False
         txtMontoParaCompra.Enabled = False
         txtDetalle.Enabled = False
         rchObservaciones.Enabled = False
         Frame1.Enabled = False
      End If
      mvarGrabado = True
   End If
   
   EstadoFrame4
   
   With Lista
      If ListaVacia Then
         .ListItems.Clear
      Else
         For Each oL In Lista.ListItems
            If IsNull(origen.DetRequerimientos.Item(oL.Tag).Registro.Fields("IdArticulo").Value) Then
               oL.SmallIcon = "ItemManual"
            End If
         Next
      End If
      .Sorted = False
      .Refresh
   End With
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   If mFirmasLiberacion = 1 Then
      mCampoAprobo = "Aprobo"
   Else
      mCampoAprobo = "Aprobo2"
   End If
   
   If glbIdObraAsignadaUsuario > 0 Then dcfields(0).Enabled = False
   
   cmd(0).Enabled = False
   cmd(3).Enabled = False
   If Me.NivelAcceso <= Medio Then
      If mvarId <= 0 Then
         cmd(0).Enabled = True
      ElseIf mvarId > 0 Then
         If (IsNull(origen.Registro.Fields(mCampoAprobo).Value) Or _
               (Not IsNull(origen.Registro.Fields(mCampoAprobo).Value) And _
                BuscarClaveINI("Inmovilizar RM al liberar") <> "SI")) And _
                IIf(IsNull(origen.Registro.Fields("Cumplido").Value), "NO", origen.Registro.Fields("Cumplido").Value) <> "SI" Then
            cmd(0).Enabled = True
            cmd(3).Enabled = True
         End If
      End If
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      cmd(3).Enabled = True
   End If
   
   If origen.Registro.Fields("Cumplido").Value = "AN" Then
      mvarAnulada = True
      cmd(0).Enabled = False
      cmd(2).Enabled = False
      cmd(3).Enabled = False
      For i = 0 To MnuDetA.Count - 1
         MnuDetA.Item(i).Enabled = False
      Next
      lblAnulada.Visible = True
      rchObservaciones.Height = 750
      With rchMotivoAnulacion
         .Top = rchObservaciones.Top + rchObservaciones.Height + 50
         .Left = rchObservaciones.Left
         .Width = rchObservaciones.Width
         .Height = rchObservaciones.Height
         .Visible = True
         .TextRTF = origen.Registro.Fields("MotivoAnulacion").Value
         .Text = mTextoAnulacion & "Motivo de anulacion : " & vbCrLf & .Text
      End With
   End If
   
   If Not mvarImpresionHabilitada Then
      cmdImpre(0).Enabled = False
      cmdImpre(1).Enabled = False
   End If

End Property

Private Sub cmdImpre_Click(Index As Integer)

   If Not mvarGrabado Or mvarModificado Then
      MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
      Exit Sub
   End If

   Dim mvarOK As Boolean
   Dim mCopias As Integer
   Dim mFormulario As String, mPlantilla As String, mCC As String, mCodigo As String
   Dim oF As Form
   
   If Not IsNull(origen.Registro.Fields("Impresa").Value) And _
         origen.Registro.Fields("Impresa").Value = "SI" And _
         BuscarClaveINI("Pedir autorizacion para reimprimir RM") = "SI" Then
      Set oF = New frmAutorizacion
      With oF
         .Empleado = 0
         .Administradores = True
         .Show vbModal, Me
         mvarOK = .Ok
      End With
      Unload oF
      Set oF = Nothing
      If Not mvarOK Then Exit Sub
      Me.Refresh
   End If

'   Set oF = New frmCopiasImpresion
'   With oF
'      If Index <> 0 Then
'         .txtCopias.Visible = False
'         .lblCopias.Visible = False
'         .lblImpresora.Visible = False
'         .Combo1.Visible = False
'         .Frame1.Visible = False
'         '.Frame1.Left = 1500
'         '.Frame1.Top = 250
'      End If
'      .Show vbModal, Me
'   End With
'   mvarOK = oF.Ok
'   mCopias = Val(oF.txtCopias.Text)
'   mFormulario = oF.Formulario
'   Unload oF
'   Set oF = Nothing
'   If Not mvarOK Then
'      Exit Sub
'   End If
   mCopias = 1
   mFormulario = "A4"

   Me.MousePointer = vbHourglass

   On Error GoTo Mal

   Dim oW As Word.Application
   
   Set oW = CreateObject("Word.Application")
   
   oW.Visible = True
'   If mFormulario = "Legal" Then
      mPlantilla = "Requerimiento_" & glbEmpresaSegunString & ".dot"
'   Else
'      mPlantilla = "Requerimiento1_" & glbEmpresaSegunString & ".dot"
'   End If
   oW.Documents.Add (glbPathPlantillas & "\" & mPlantilla)
   oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId
   oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
   oW.Application.Run MacroName:="DatosDelPie"
   If Index = 0 Then
      oW.ActiveDocument.PrintOut False, , , , , , , mCopias
      oW.ActiveDocument.Close False
   End If
   'End With
   If Index = 0 Then oW.Quit

   Aplicacion.Tarea "Requerimientos_RegistrarImpresion", Array(mvarId, "SI")

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

Private Sub cmdPegar_Click()

   Dim s As String
   Dim iFilas As Long, iColumnas As Long, i As Long, mItem As Long, mIdDet As Long
   Dim mItemsNuevos As Boolean
   Dim Filas
   Dim Columnas
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset

   If Not Clipboard.GetFormat(vbCFText) Then
      MsgBox "No hay informacion en el portapapeles", vbCritical
      Exit Sub
   End If
   
   On Error GoTo Mal
   
   s = Clipboard.GetText(vbCFText)
   
   Filas = Split(s, vbCrLf) ' armo un vector por filas
   Columnas = Split(Filas(LBound(Filas)), vbTab)
   
   If UBound(Columnas) < 2 Then
      MsgBox "No hay items de requerimientos para copiar", vbCritical
      Exit Sub
   End If
   
   If InStr(1, Columnas(0), "Requerimiento") <> 0 Then
   
      Set oAp = Aplicacion
      
      mItemsNuevos = False
      
      For iFilas = LBound(Filas) + 1 To UBound(Filas)
         
         Columnas = Split(Filas(iFilas), vbTab)
         If Columnas(0) < 0 Then
            mItemsNuevos = True
         End If
         
         Set oRs = oAp.TablasGenerales.TraerFiltrado("DetRequerimientos", "_UnItem", Columnas(0))
         
         If oRs.RecordCount > 0 Then
            
            If IsNull(oRs.Fields("IdArticulo").Value) Then
               MsgBox "No se puede pegar uno o mas items porque el articulo no ha sido " & vbCrLf & "procesado, ver al administrador del sistema", vbCritical
               GoTo Mal
            End If
            
            mItem = origen.DetRequerimientos.UltimoItemDetalle
            With origen.DetRequerimientos.Item(-1)
               .Registro.Fields("NumeroItem").Value = mItem
               For i = 2 To oRs.Fields.Count - 1
                  If oRs.Fields(i).Name <> "NumeroItem" Then
                     .Registro.Fields(i).Value = oRs.Fields(i).Value
                  End If
               Next
               .Registro.Fields("Cumplido").Value = Null
               mIdDet = .Id
               .Modificado = True
            End With
            oRs.Close
               
            Set oRs = oAp.TablasGenerales.TraerFiltrado("DetRequerimientos", "_UnItemConFormato", Columnas(0))
            Set oL = Lista.ListItems.Add()
            With oL
               .Tag = mIdDet
               .Text = "" & mItem
               .SubItems(1) = "" & oRs.Fields("NumeroLMateriales").Value
               .SubItems(2) = "" & oRs.Fields("NumeroItemLMateriales").Value
               .SubItems(3) = "" & oRs.Fields("Cantidad").Value
               .SubItems(4) = "" & oRs.Fields("Unidad en").Value
               .SubItems(5) = "" & oRs.Fields("Cantidad1").Value
               .SubItems(6) = "" & oRs.Fields("Cantidad2").Value
               .SubItems(7) = "" & oRs.Fields("Codigo").Value
               .SubItems(8) = "" & oRs.Fields("Articulo").Value
               .SubItems(9) = "" & oRs.Fields("FechaEntrega").Value
               .SubItems(10) = "" & oRs.Fields("ControlCalidad").Value
               .SmallIcon = "Nuevo"
            End With
            oRs.Close
            
         End If
      
      Next
      
      If mItemsNuevos Then
         MsgBox "Cuidado, hay items que no han sido grabados y no pueden copiarse", vbCritical
      End If
   
      Clipboard.Clear
   
      Set oRs = Nothing
      Set oAp = Nothing
   
   ElseIf InStr(1, Columnas(0), "ValeSalida") <> 0 Then
   
      Set oAp = Aplicacion
      
      mItemsNuevos = False
      
      For iFilas = LBound(Filas) + 1 To UBound(Filas)
         
         Columnas = Split(Filas(iFilas), vbTab)
         If Columnas(0) < 0 Then
            mItemsNuevos = True
         End If
         
         Set oRs = oAp.TablasGenerales.TraerFiltrado("DetValesSalida", "_UnItem", Columnas(0))
         
         If oRs.RecordCount > 0 Then
            
            If IsNull(oRs.Fields("IdArticulo").Value) Then
               MsgBox "No se puede pegar uno o mas items porque el articulo no ha sido " & vbCrLf & "procesado, ver al administrador del sistema", vbCritical
               GoTo Mal
            End If
            
            mItem = origen.DetRequerimientos.UltimoItemDetalle
            With origen.DetRequerimientos.Item(-1)
               With .Registro
                  .Fields("NumeroItem").Value = mItem
                  .Fields("Cantidad").Value = oRs.Fields("Cantidad").Value
                  .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                  .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                  .Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
                  .Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
                  .Fields("IdDetalleLMateriales").Value = oRs.Fields("IdDetalleLMateriales").Value
                  .Fields("FechaEntrega").Value = Date
                  .Fields("Adjunto").Value = "NO"
                  .Fields("Cumplido").Value = Null
                  .Fields("OrigenDescripcion").Value = 1
               End With
               mIdDet = .Id
               .Modificado = True
            End With
            oRs.Close
               
            Set oRs = oAp.TablasGenerales.TraerFiltrado("DetValesSalida", "_UnItemConFormato", Columnas(0))
            Set oL = Lista.ListItems.Add()
            With oL
               .Tag = mIdDet
               .Text = "" & mItem
               .SubItems(1) = "" & oRs.Fields("NumeroLMateriales").Value
               .SubItems(2) = "" & oRs.Fields("NumeroItemLMateriales").Value
               .SubItems(3) = "" & oRs.Fields("Cantidad").Value
               .SubItems(4) = "" & oRs.Fields("En :").Value
               .SubItems(5) = "" & oRs.Fields("Cantidad1").Value
               .SubItems(6) = "" & oRs.Fields("Cantidad2").Value
               .SubItems(7) = "" & oRs.Fields("Codigo").Value
               .SubItems(8) = "" & oRs.Fields("Articulo").Value
               .SubItems(9) = ""
               .SubItems(10) = ""
               .SmallIcon = "Nuevo"
            End With
            oRs.Close
            
         End If
      
      Next
      
      If mItemsNuevos Then
         MsgBox "Cuidado, hay items que no han sido grabados y no pueden copiarse", vbCritical
      End If
   
      Clipboard.Clear
   
      Set oRs = Nothing
      Set oAp = Nothing
   
   Else
      
      MsgBox "Objeto invalido!"
   
   End If
   
   Exit Sub

Mal:
   
   Clipboard.Clear
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

End Sub

Private Sub dcfields_Change(Index As Integer)

   If IsNumeric(dcfields(Index).BoundText) Then
      Dim oRs As ADOR.Recordset
      Select Case Index
         Case 10
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorIdConDatos", Array(dcfields(Index).BoundText, DTFields(0).Value))
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  .Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
                  txtCodigoCuenta.Text = oRs.Fields("Codigo1").Value
               End With
            End If
            oRs.Close
            Set oRs = Nothing
      End Select
   End If

End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   SetDataComboDropdownListWidth 400
   
   If IsNumeric(dcfields(Index).BoundText) Then
      Select Case Index
         Case 0
            MostrarCliente dcfields(Index).BoundText
         Case 4
            If dcfields(Index).BoundText <> mIdAprobo Then
               PideAutorizacion 1
            End If
         Case 6
            origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
            txtCodigoArticulo1.Text = TraerCodigoArticulo(dcfields(Index).BoundText)
         Case 8
            If dcfields(Index).BoundText <> mIdAprobo1 Then
               PideAutorizacion 2
            End If
      End Select
   End If
   
End Sub

Private Sub dcfields_GotFocus(Index As Integer)
   
   If Index <> 4 And Index <> 8 Then SendKeys "%{DOWN}"

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub dcfields_Validate(Index As Integer, Cancel As Boolean)

   Dim oRs As ADOR.Recordset
   
   If IsNumeric(dcfields(Index).BoundText) Then
      If IsNull(origen.Registro.Fields(dcfields(Index).DataField).Value) Or origen.Registro.Fields(dcfields(Index).DataField).Value <> dcfields(Index).BoundText Then
         mvarModificado = True
         origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
      End If
      Select Case Index
         Case 0
            mTipoObra = Aplicacion.Obras.Item(dcfields(Index).BoundText).TipoObra
         Case 2
            If mvarId < 0 Then
               Set oRs = Aplicacion.Empleados.Item(dcfields(Index).BoundText).Registro
               If oRs.RecordCount > 0 Then
                  If Not IsNull(oRs.Fields("IdSector").Value) Then
                     origen.Registro.Fields("IdSector").Value = oRs.Fields("IdSector").Value
                  End If
               End If
               oRs.Close
            End If
      End Select
   Else
      dcfields(Index).Text = ""
      If Index = 4 Then
         With origen.Registro
            If Not IsNull(.Fields(dcfields(Index).DataField).Value) Or Not IsNull(.Fields("FechaAprobacion").Value) Then
               .Fields(dcfields(Index).DataField).Value = Null
               .Fields("FechaAprobacion").Value = Null
            End If
         End With
      End If
   End If

   Set oRs = Nothing
   
End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub DTFields_Validate(Index As Integer, Cancel As Boolean)

   origen.Registro.Fields(DTFields(Index).DataField).Value = DTFields(Index).Value

   If glbSe�al1 And Index = 0 Then
      If BuscarClaveINI("Combo de obras con descripcion") <> "SI" Then
         Set dcfields(0).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", DTFields(Index).Value))
      Else
         Set dcfields(0).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaComboConDescripcion", Array("SI", DTFields(Index).Value))
      End If
      dcfields(0).BoundText = IIf(IsNull(origen.Registro.Fields(dcfields(0).BoundColumn).Value), 0, origen.Registro.Fields(dcfields(0).BoundColumn).Value)
   End If

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPeque�o = "Original"
   End With
   
   For Each oI In Img16.ListImages
      With Estado.Panels.Add(, , oI.Key)
         .Picture = oI.Picture
      End With
   Next
   
   CambiarEtiquetas Me
   AsignarTabulados Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   'Degradado Me
   
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   If mvarModificado And Not mvarAnulada Then
      Dim mvarSale As Integer
      mvarSale = MsgBox("Hay datos no grabados, desea salir igual ?", vbYesNo, "Salir")
      If mvarSale = vbNo Then
         Cancel = 1
      End If
   End If

End Sub

Private Sub lblTabIndex_Click()

   On Error Resume Next
   
   If lblTabIndex.BackColor = &HC0C0FF Then
      lblTabIndex.BackColor = &HC0FFC0
      ControlTabuladosInput Me
   Else
      ControlTabuladosOutput Me
      AsignarTabulados Me
      lblTabIndex.BackColor = &HC0C0FF
   End If
   
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

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If mvarId < 0 Then
         MnuDetA(3).Enabled = False
         MnuDetA(4).Enabled = False
         MnuDetA(5).Enabled = False
      End If
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
   Dim iFilas As Long, iColumnas As Long, i As Long, NroItem As Long, idDet As Long
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oRM As ComPronto.Requerimiento
   Dim oRs As ADOR.Recordset
   Dim oRsRM As ADOR.Recordset
   Dim oRsLMat As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRsArt As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then
      
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      If mvarId > 0 And Not IsNull(origen.Registro.Fields("Aprobo").Value) Then
         MsgBox "La RM ha sido cerrada, no puede modificarla", vbCritical
         Exit Sub
      End If
   
      If InStr(1, Columnas(LBound(Columnas) + 1), "LM") <> 0 Then
      
         Set oAp = Aplicacion
         
         NroItem = origen.DetRequerimientos.UltimoItemDetalle
         
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            
            Columnas = Split(Filas(iFilas), vbTab)
            
            Set oRsDet = oAp.LMateriales.Item(0).DetLMateriales.Item(Columnas(0)).Registro
            Set oRsLMat = oAp.LMateriales.Item(oRsDet.Fields("IdLMateriales").Value).Registro
            
            With origen.Registro
               .Fields("IdObra").Value = oRsLMat.Fields("IdObra").Value
            End With
            
            Do While Not oRsDet.EOF
               Set oRsArt = oAp.Articulos.Item(oRsDet.Fields("IdArticulo").Value).Registro
               With origen.DetRequerimientos.Item(-1)
                  .Registro.Fields("NumeroItem").Value = NroItem
'                  .Registro.Fields("Cantidad").Value = oRsDet.Fields("Cantidad").Value
                  If IsNumeric(Columnas(10)) Then
                     .Registro.Fields("Cantidad").Value = Columnas(10)
                  End If
                  .Registro.Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                  .Registro.Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                  .Registro.Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
                  .Registro.Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
                  If Not IsNull(oRsDet.Fields("IdControlCalidad").Value) Then
                     .Registro.Fields("IdControlCalidad").Value = oRsDet.Fields("IdControlCalidad").Value
                  ElseIf Not IsNull(oRsArt.Fields("IdControlCalidad").Value) Then
                     .Registro.Fields("IdControlCalidad").Value = oRsArt.Fields("IdControlCalidad").Value
                  End If
                  .Registro.Fields("Adjunto").Value = oRsDet.Fields("Adjunto").Value
                  For i = 1 To 10
                     .Registro.Fields("ArchivoAdjunto" & i).Value = oRsDet.Fields("ArchivoAdjunto" & i).Value
                  Next
                  .Registro.Fields("IdDetalleLMateriales").Value = oRsDet.Fields(0).Value
                  .Registro.Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
                  If Not IsNull(oRsArt.Fields("IdCuenta").Value) Then
                     .Registro.Fields("IdCuenta").Value = oRsArt.Fields("IdCuenta").Value
                  End If
                  .Registro.Fields("IdEquipo").Value = oRsLMat.Fields("IdEquipo").Value
                  .Registro.Fields("FechaEntrega").Value = DTFields(0).Value
                  .Registro.Fields("OrigenDescripcion").Value = 1
                  .Modificado = True
                  idDet = .Id
               End With
               Set oL = Lista.ListItems.Add
               oL.Tag = idDet
               With oL
                  .SmallIcon = "Nuevo"
                  .Text = "" & NroItem
                  .SubItems(1) = "" & Columnas(2)
                  .SubItems(2) = "" & oRsDet.Fields("NumeroItem").Value
'                  .SubItems(3) = "" & oRsDet.Fields("Cantidad").Value
                  If IsNumeric(Columnas(10)) Then
                     .SubItems(3) = "" & Columnas(10)
                  End If
                  If Not IsNull(oRsDet.Fields("IdUnidad").Value) Then
                     .SubItems(4) = "" & oAp.Unidades.Item(oRsDet.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
                  End If
                  .SubItems(5) = "" & oRsDet.Fields("Cantidad1").Value
                  .SubItems(6) = "" & oRsDet.Fields("Cantidad2").Value
                  .SubItems(7) = "" & oAp.Articulos.Item(oRsDet.Fields("IdArticulo").Value).Registro.Fields("Codigo").Value
                  .SubItems(8) = "" & oAp.Articulos.Item(oRsDet.Fields("IdArticulo").Value).Registro.Fields("Descripcion").Value
                  .SubItems(9) = "" & DTFields(0).Value
                  If Not IsNull(oRsDet.Fields("IdControlCalidad").Value) Then
                     .SubItems(10) = "" & oAp.ControlesCalidad.Item(oRsDet.Fields("IdControlCalidad").Value).Registro.Fields("Abreviatura").Value
                  ElseIf Not IsNull(oRsArt.Fields("IdControlCalidad").Value) Then
                     .SubItems(10) = "" & oAp.ControlesCalidad.Item(oRsArt.Fields("IdControlCalidad").Value).Registro.Fields("Abreviatura").Value
                  End If
               End With
               NroItem = NroItem + 1
               oRsArt.Close
               Set oRsArt = Nothing
               oRsLMat.Close
               Set oRsLMat = Nothing
               oRsDet.MoveNext
            Loop
            
            oRsDet.Close
            Set oRsDet = Nothing
            
            mvarModificado = True
            
         Next
         
         Clipboard.Clear
      
         Set oAp = Nothing
         
      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "Req.") <> 0 Then
      
         If mvarId > 0 Or Lista.ListItems.Count > 0 Then
            MsgBox "Para copiar una RM entera en otra, la que recibe debe ser nueva y no tener items ingresados", vbExclamation
            Exit Sub
         End If
      
         Filas = Split(s, vbCrLf)
         Columnas = Split(Filas(1), vbTab)
      
         If UBound(Columnas) < 2 Then
            MsgBox "No hay informacion para copiar", vbCritical
            Exit Sub
         End If
         
         If UBound(Filas) > 1 Then
            MsgBox "No puede arrastrar mas de un elemento a la vez", vbCritical
            Exit Sub
         End If
      
         Set oAp = Aplicacion
         
         Set oRM = oAp.Requerimientos.Item(Columnas(0))
         Set oRsRM = oRM.Registro
         Set oRsDet = oRM.DetRequerimientos.TraerFiltrado("_Todos", Columnas(0))
         
         With origen.Registro
            .Fields("LugarEntrega").Value = oRsRM.Fields("LugarEntrega").Value
            .Fields("Observaciones").Value = oRsRM.Fields("Observaciones").Value
            .Fields("IdObra").Value = oRsRM.Fields("IdObra").Value
            .Fields("IdCentroCosto").Value = oRsRM.Fields("IdCentroCosto").Value
            .Fields("IdSector").Value = oRsRM.Fields("IdSector").Value
            .Fields("MontoPrevisto").Value = oRsRM.Fields("MontoPrevisto").Value
            .Fields("MontoParaCompra").Value = oRsRM.Fields("MontoParaCompra").Value
            .Fields("Consorcial").Value = oRsRM.Fields("Consorcial").Value
            .Fields("IdMoneda").Value = oRsRM.Fields("IdMoneda").Value
            .Fields("Detalle").Value = oRsRM.Fields("Detalle").Value
         End With
   
         If Not IsNull(oRsRM.Fields("IdObra").Value) Then
            Option1.Value = True
         Else
            Option2.Value = True
         End If
         
         Do While Not oRsDet.EOF
            Set oRsArt = oAp.Articulos.Item(oRsDet.Fields("IdArticulo").Value).Registro
            With origen.DetRequerimientos.Item(-1)
               .Registro.Fields("NumeroItem").Value = oRsDet.Fields("NumeroItem").Value
               .Registro.Fields("Cantidad").Value = oRsDet.Fields("Cantidad").Value
               .Registro.Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
               .Registro.Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
               .Registro.Fields("FechaEntrega").Value = oRsDet.Fields("FechaEntrega").Value
               .Registro.Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
               .Registro.Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
               .Registro.Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
               .Registro.Fields("IdDetalleLMateriales").Value = oRsDet.Fields("IdDetalleLMateriales").Value
               If Not IsNull(oRsDet.Fields("IdControlCalidad").Value) Then
                  .Registro.Fields("IdControlCalidad").Value = oRsDet.Fields("IdControlCalidad").Value
               ElseIf Not IsNull(oRsArt.Fields("IdControlCalidad").Value) Then
                  .Registro.Fields("IdControlCalidad").Value = oRsArt.Fields("IdControlCalidad").Value
               End If
               .Registro.Fields("Adjunto").Value = oRsDet.Fields("Adjunto").Value
               .Registro.Fields("ArchivoAdjunto").Value = oRsDet.Fields("ArchivoAdjunto").Value
               .Registro.Fields("IdCentroCosto").Value = oRsDet.Fields("IdCentroCosto").Value
               .Registro.Fields("EsBienDeUso").Value = oRsDet.Fields("EsBienDeUso").Value
               .Registro.Fields("IdCuenta").Value = oRsDet.Fields("IdCuenta").Value
               .Registro.Fields("ArchivoAdjunto1").Value = oRsDet.Fields("ArchivoAdjunto1").Value
               .Registro.Fields("ArchivoAdjunto2").Value = oRsDet.Fields("ArchivoAdjunto2").Value
               .Registro.Fields("ArchivoAdjunto3").Value = oRsDet.Fields("ArchivoAdjunto3").Value
               .Registro.Fields("ArchivoAdjunto4").Value = oRsDet.Fields("ArchivoAdjunto4").Value
               .Registro.Fields("ArchivoAdjunto5").Value = oRsDet.Fields("ArchivoAdjunto5").Value
               .Registro.Fields("ArchivoAdjunto6").Value = oRsDet.Fields("ArchivoAdjunto6").Value
               .Registro.Fields("ArchivoAdjunto7").Value = oRsDet.Fields("ArchivoAdjunto7").Value
               .Registro.Fields("ArchivoAdjunto8").Value = oRsDet.Fields("ArchivoAdjunto8").Value
               .Registro.Fields("ArchivoAdjunto9").Value = oRsDet.Fields("ArchivoAdjunto9").Value
               .Registro.Fields("ArchivoAdjunto10").Value = oRsDet.Fields("ArchivoAdjunto10").Value
               .Registro.Fields("DescripcionManual").Value = oRsDet.Fields("DescripcionManual").Value
               .Registro.Fields("IdEquipo").Value = oRsDet.Fields("IdEquipo").Value
               .Registro.Fields("OrigenDescripcion").Value = IIf(IsNull(oRsDet.Fields("OrigenDescripcion").Value), 1, oRsDet.Fields("OrigenDescripcion").Value)
               .Modificado = True
               idDet = .Id
            End With
            
            If Not IsNull(oRsDet.Fields("IdDetalleLMateriales").Value) Then
               Set oRsLMat = oAp.LMateriales.TraerFiltrado("_DesdeDetalle", oRsDet.Fields("IdDetalleLMateriales").Value)
            End If
            
            Set oL = Lista.ListItems.Add
            oL.Tag = idDet
            With oL
               .SmallIcon = "Nuevo"
               .Text = "" & oRsDet.Fields("NumeroItem").Value
               If Not IsNull(oRsDet.Fields("IdDetalleLMateriales").Value) Then
                  .SubItems(1) = "" & oRsLMat.Fields("L.Materiales").Value
                  .SubItems(2) = "" & oRsLMat.Fields("Item").Value
               End If
               .SubItems(3) = "" & oRsDet.Fields("Cantidad").Value
               If Not IsNull(oRsDet.Fields("IdUnidad").Value) Then
                  .SubItems(4) = "" & oAp.Unidades.Item(oRsDet.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
               End If
               .SubItems(5) = "" & oRsDet.Fields("Cantidad1").Value
               .SubItems(6) = "" & oRsDet.Fields("Cantidad2").Value
               .SubItems(7) = "" & oAp.Articulos.Item(oRsDet.Fields("IdArticulo").Value).Registro.Fields("Codigo").Value
               .SubItems(8) = "" & oAp.Articulos.Item(oRsDet.Fields("IdArticulo").Value).Registro.Fields("Descripcion").Value
               .SubItems(9) = "" & oRsDet.Fields("FechaEntrega").Value
               If Not IsNull(oRsDet.Fields("IdControlCalidad").Value) Then
                  .SubItems(10) = "" & oAp.ControlesCalidad.Item(oRsDet.Fields("IdControlCalidad").Value).Registro.Fields("Abreviatura").Value
               ElseIf Not IsNull(oRsArt.Fields("IdControlCalidad").Value) Then
                  .SubItems(10) = "" & oAp.ControlesCalidad.Item(oRsArt.Fields("IdControlCalidad").Value).Registro.Fields("Abreviatura").Value
               End If
            End With
            
            If Not IsNull(oRsDet.Fields("IdDetalleLMateriales").Value) Then oRsLMat.Close
            
            oRsDet.MoveNext
         
         Loop
         oRsDet.Close
         oRsRM.Close
         oRsArt.Close
         
         Set oRsRM = Nothing
         Set oRsDet = Nothing
         Set oRsLMat = Nothing
         Set oRsArt = Nothing
         Set oRM = Nothing
         Set oAp = Nothing
            
         Clipboard.Clear
      
         mvarModificado = True
            
      ElseIf InStr(1, Columnas(LBound(Columnas) + 2), "conjunto") <> 0 Then
      
         Filas = Split(s, vbCrLf)
         Columnas = Split(Filas(1), vbTab)
      
         If UBound(Columnas) < 2 Then
            MsgBox "No hay informacion para copiar", vbCritical
            Exit Sub
         End If
         
         Dim oF As frm_Aux
         Dim mOk As Boolean
         Dim mCantidadConjuntos As Integer
         Dim mIdDet As Long
         
         Set oF = New frm_Aux
         With oF
            .Label1 = "Cant. conjuntos :"
            .Text1.Text = 1
            .Show vbModal, Me
            mOk = .Ok
            mCantidadConjuntos = Val(.Text1.Text)
         End With
         Unload oF
         Set oF = Nothing
         
         If Not mOk Then Exit Sub
         
         Set oAp = Aplicacion
         
         NroItem = origen.DetRequerimientos.UltimoItemDetalle
         
         For iFilas = LBound(Filas) + 1 To UBound(Filas) ' recorro las filas
            
            Columnas = Split(Filas(iFilas), vbTab) ' armo un vector con las columnas
            
            Set oRsDet = oAp.Conjuntos.TraerFiltrado("_DetallesPorId", Columnas(0))
         
            Do While Not oRsDet.EOF
               If Not IsNull(oRsDet.Fields("IdArticulo").Value) Then
                  mIdDet = 0
                  Set oRsAux = origen.DetRequerimientos.TodosLosRegistros
                  With oRsAux
                     If .Fields.Count > 0 Then
                        If .RecordCount > 0 Then
                           .MoveFirst
                           Do While Not .EOF
                              If .Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value Then
                                 mIdDet = .Fields(0).Value
                                 Exit Do
                              End If
                              .MoveNext
                           Loop
                        End If
                     End If
                  End With
                  Set oRsAux = Nothing
                  
                  If mIdDet <> 0 Then
                     With origen.DetRequerimientos.Item(mIdDet)
                        .Registro.Fields("Cantidad").Value = .Registro.Fields("Cantidad").Value + _
                              (oRsDet.Fields("Cantidad").Value * mCantidadConjuntos)
                        .Modificado = True
                     End With
                  Else
                     Set oRsArt = oAp.Articulos.Item(oRsDet.Fields("IdArticulo").Value).Registro
                     With origen.DetRequerimientos.Item(-1)
                        .Registro.Fields("NumeroItem").Value = NroItem
                        .Registro.Fields("Cantidad").Value = oRsDet.Fields("Cantidad").Value * mCantidadConjuntos
                        .Registro.Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                        .Registro.Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                        .Registro.Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
                        .Registro.Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
                        .Registro.Fields("FechaEntrega").Value = DTFields(0).Value
                        .Registro.Fields("Adjunto").Value = "NO"
                        .Registro.Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
                        .Registro.Fields("OrigenDescripcion").Value = 1
                        .Modificado = True
                        idDet = .Id
                     End With
'                     Set oL = Lista.ListItems.Add
'                     oL.Tag = idDet
'                     With oL
'                        .SmallIcon = "Nuevo"
'                        .Text = "" & NroItem
'                        .SubItems(3) = "" & oRsDet.Fields("Cantidad").Value * mCantidadConjuntos
'                        If Not IsNull(oRsDet.Fields("IdUnidad").Value) Then
'                           .SubItems(4) = "" & oAp.Unidades.Item(oRsDet.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
'                        End If
'                        .SubItems(5) = "" & oRsDet.Fields("Cantidad1").Value
'                        .SubItems(6) = "" & oRsDet.Fields("Cantidad2").Value
'                        .SubItems(7) = "" & oAp.Articulos.Item(oRsDet.Fields("IdArticulo").Value).Registro.Fields("Descripcion").Value
'                     End With
                     NroItem = NroItem + 1
                     oRsArt.Close
                     Set oRsArt = Nothing
                  End If
               End If
               oRsDet.MoveNext
            Loop
            
            oRsDet.Close
            Set oRsDet = Nothing
            
            mvarModificado = True
            
         Next
         
         Clipboard.Clear
      
         Set Lista.DataSource = origen.DetRequerimientos.RegistrosConFormato
         
         mvarModificado = True
            
      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "vale") <> 0 Then
      
         If mvarId > 0 Or Lista.ListItems.Count > 0 Then
            MsgBox "Para copiar una solicitud entera en una RM, la que recibe debe ser nueva y no tener items ingresados", vbExclamation
            Exit Sub
         End If
      
         Filas = Split(s, vbCrLf)
         Columnas = Split(Filas(1), vbTab)
      
         If UBound(Columnas) < 2 Then
            MsgBox "No hay informacion para copiar", vbCritical
            Exit Sub
         End If
         
         If UBound(Filas) > 1 Then
            MsgBox "No puede arrastrar mas de un elemento a la vez", vbCritical
            Exit Sub
         End If
      
         Set oAp = Aplicacion
         
         Set oRs = oAp.ValesSalida.TraerFiltrado("_PorId", Columnas(2))
         Set oRsDet = oAp.TablasGenerales.TraerFiltrado("DetValesSalida", "_TodosLosItemsConFormato", Columnas(2))
         
         With origen.Registro
            .Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
            .Fields("IdObra").Value = oRs.Fields("IdObra").Value
            .Fields("IdCentroCosto").Value = oRs.Fields("IdCentroCosto").Value
            .Fields("IdMoneda").Value = 1
         End With
   
         If Not IsNull(oRs.Fields("IdObra").Value) Then
            Option1.Value = True
         Else
            Option2.Value = True
         End If
         
         NroItem = origen.DetRequerimientos.UltimoItemDetalle
         
         Do While Not oRsDet.EOF
            With origen.DetRequerimientos.Item(-1)
               .Registro.Fields("NumeroItem").Value = NroItem
               .Registro.Fields("Cantidad").Value = oRsDet.Fields("Cantidad").Value
               .Registro.Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
               .Registro.Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
               .Registro.Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
               .Registro.Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
               .Registro.Fields("IdDetalleLMateriales").Value = oRsDet.Fields("IdDetalleLMateriales").Value
               .Registro.Fields("IdCentroCosto").Value = oRs.Fields("IdCentroCosto").Value
               .Registro.Fields("FechaEntrega").Value = Date
               .Registro.Fields("Adjunto").Value = "NO"
               .Registro.Fields("OrigenDescripcion").Value = 1
               .Modificado = True
               idDet = .Id
            End With
            
            If Not IsNull(oRsDet.Fields("IdDetalleLMateriales").Value) Then
               Set oRsLMat = oAp.LMateriales.TraerFiltrado("_DesdeDetalle", oRsDet.Fields("IdDetalleLMateriales").Value)
            End If
            
            Set oL = Lista.ListItems.Add
            oL.Tag = idDet
            With oL
               .SmallIcon = "Nuevo"
               .Text = "" & NroItem
               If Not IsNull(oRsDet.Fields("IdDetalleLMateriales").Value) Then
                  .SubItems(1) = "" & oRsLMat.Fields("L.Materiales").Value
                  .SubItems(2) = "" & oRsLMat.Fields("Item").Value
               End If
               .SubItems(3) = "" & oRsDet.Fields("Cantidad").Value
               If Not IsNull(oRsDet.Fields("IdUnidad").Value) Then
                  .SubItems(4) = "" & oAp.Unidades.Item(oRsDet.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
               End If
               .SubItems(5) = "" & oRsDet.Fields("Cantidad1").Value
               .SubItems(6) = "" & oRsDet.Fields("Cantidad2").Value
               .SubItems(7) = "" & oAp.Articulos.Item(oRsDet.Fields("IdArticulo").Value).Registro.Fields("Codigo").Value
               .SubItems(8) = "" & oAp.Articulos.Item(oRsDet.Fields("IdArticulo").Value).Registro.Fields("Descripcion").Value
               .SubItems(9) = ""
               .SubItems(10) = ""
            End With
            
            If Not IsNull(oRsDet.Fields("IdDetalleLMateriales").Value) Then oRsLMat.Close
            
            NroItem = NroItem + 1
            
            oRsDet.MoveNext
         
         Loop
         oRsDet.Close
         oRs.Close
         
         Set oRs = Nothing
         Set oRsDet = Nothing
         Set oRsLMat = Nothing
         Set oAp = Nothing
            
         Clipboard.Clear
      
         mvarModificado = True
            
      Else
         
         MsgBox "Objeto invalido!"
         Exit Sub
      
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
      Case 0
         Editar -1
      Case 1
         If Not Lista.SelectedItem Is Nothing Then
            Editar Lista.SelectedItem.Tag
         End If
      Case 2
         If mvarId > 0 And Not AprobadoEdicion Then
            MsgBox "El requermiento de materiales ha sido cerrado, no puede modificarlo", vbCritical
            Exit Sub
         End If
         If mvarAnulada Then
            MsgBox "La RM ha sido anulada y no puede modificarse!", vbCritical
            Exit Sub
         End If
         If Not Lista.SelectedItem Is Nothing Then
            With Lista.SelectedItem
               origen.DetRequerimientos.Item(.Tag).Eliminado = True
               .SmallIcon = "Eliminado"
               .ToolTipText = .SmallIcon
            End With
            mvarModificado = True
         End If
      Case 3
         If Not Lista.SelectedItem Is Nothing Then
            AsignaFechaNecesidad
         End If
      Case 4
         If Not Lista.SelectedItem Is Nothing Then
            AsignaCCalidad
         End If
      Case 5
         If Not Lista.SelectedItem Is Nothing Then
            AsignaFacturaCompra
         End If
      Case 6
         If Not Lista.SelectedItem Is Nothing Then
            AsignaProveedor
         End If
      Case 7
         If mvarId > 0 And Not AprobadoEdicion Then
            MsgBox "El requermiento de materiales ha sido cerrado, no puede modificarlo", vbCritical
            Exit Sub
         End If
         If mvarAnulada Then
            MsgBox "La RM ha sido anulada y no puede modificarse!", vbCritical
            Exit Sub
         End If
         If Not Lista.SelectedItem Is Nothing Then
            DuplicarItem
         End If
      Case 8
         RenumerarItems
      Case 9
         AnularItems
   End Select

End Sub

Private Sub MnuDetCon_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarConsulta Index
   End Select

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

Private Sub Option1_Click()

   If Option1.Value Then
      dcfields(0).Enabled = True
      dcfields(1).Enabled = False
      origen.Registro.Fields("IdCentroCosto").Value = Null
   End If
   
End Sub

Private Sub Option10_Click()

   EstadoFrame4

End Sub

Private Sub Option11_Click()

   EstadoFrame4

End Sub

Private Sub Option12_Click()

   If Option12.Value Then
      rchRequisitosSeguridad.Enabled = True
   End If

End Sub

Private Sub Option13_Click()

   If Option13.Value Then
      rchRequisitosSeguridad.Text = ""
      rchRequisitosSeguridad.Enabled = False
   End If

End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      dcfields(0).Enabled = False
      dcfields(1).Enabled = True
      txtCliente.Text = ""
      origen.Registro.Fields("IdObra").Value = Null
   End If
   
End Sub

Private Sub Option4_Click()

'   If Option4.Value And IsNull(origen.Registro.Fields("IdAutorizoDirectoACompras").Value) Then
'
'      Dim mvarOK As Boolean
'      Dim mIdAutorizo As Long
'
'      Dim of As frmAutorizacion
'      Set of = New frmAutorizacion
'      With of
'         .Administradores = True
'         .Show vbModal, Me
'      End With
'      mvarOK = of.OK
'      mIdAutorizo = of.IdAutorizo
'      Unload of
'      Set of = Nothing
'      If Not mvarOK Then
'         Me.Refresh
'         MsgBox "No puede realizar esta funcion", vbExclamation
'         Option3.Value = True
'         Exit Sub
'      End If
'      origen.Registro.Fields("IdAutorizoDirectoACompras").Value = mIdAutorizo
'
'   End If
   
End Sub

Private Sub Option5_Click()

   origen.Registro.Fields(dcfields(7).DataField).Value = Null
   dcfields(7).Enabled = False

End Sub

Private Sub Option6_Click()

   dcfields(7).Enabled = True

End Sub

Private Sub Option7_Click()

   origen.Registro.Fields(dcfields(7).DataField).Value = Null
   dcfields(7).Enabled = False

End Sub

Private Sub txtCodigoArticulo1_GotFocus()

   With txtCodigoArticulo1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoArticulo1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCodigoArticulo1
         If Len(Trim(.Text)) >= 20 And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtCodigoArticulo1_Validate(Cancel As Boolean)

   If Len(txtCodigoArticulo1.Text) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorNumeroInventario", txtCodigoArticulo1.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdEquipoDestino").Value = oRs.Fields(0).Value
      Else
         MsgBox "Numero de inventario del material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo1.Text = ""
         origen.Registro.Fields("IdEquipoDestino").Value = Null
      End If
      oRs.Close
      Set oRs = Nothing
   Else
      origen.Registro.Fields("IdEquipoDestino").Value = Null
   End If
   
End Sub

Private Sub txtCodigoCuenta_Change()

   If IsNumeric(txtCodigoCuenta.Text) Then
      On Error GoTo SalidaConError
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorCodigo", Array(txtCodigoCuenta.Text, DTFields(0).Value))
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdCuentaPresupuesto").Value = oRs.Fields(0).Value
      Else
         origen.Registro.Fields("IdCuentaPresupuesto").Value = Null
      End If
      oRs.Close
      Set oRs = Nothing
      Exit Sub
SalidaConError:
      Set oRs = Nothing
      origen.Registro.Fields("IdCuentaPresupuesto").Value = Null
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

Private Sub txtMontoParaCompra_Change()

   If IsNull(origen.Registro.Fields("MontoParaCompra").Value) Or Val(txtMontoParaCompra.Text) <> origen.Registro.Fields("MontoParaCompra").Value Then
      mvarModificado = True
   End If
   
End Sub

Private Sub txtMontoParaCompra_GotFocus()

   With txtMontoParaCompra
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtMontoParaCompra_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtMontoPrevisto_Change()

   If IsNull(origen.Registro.Fields("MontoPrevisto").Value) Or Val(TxtMontoPrevisto.Text) <> origen.Registro.Fields("MontoPrevisto").Value Then
      mvarModificado = True
   End If
   
End Sub

Private Sub TxtMontoPrevisto_GotFocus()

   With TxtMontoPrevisto
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub TxtMontoPrevisto_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtNumeroRequerimiento_Change()

   If IsNull(origen.Registro.Fields("NumeroRequerimiento").Value) Or Val(txtNumeroRequerimiento.Text) <> origen.Registro.Fields("NumeroRequerimiento").Value Then
      mvarModificado = True
   End If
   
End Sub

Private Sub txtNumeroRequerimiento_GotFocus()

   With txtNumeroRequerimiento
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroRequerimiento_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Public Sub AsignaFechaNecesidad()

   Dim mvarOK, mvarCancelo As Boolean
   
   Dim oF As frmAutorizacion2
   Set oF = New frmAutorizacion2
   With oF
      .Sector = "Planeamiento"
      .Show vbModal, Me
   End With
   mvarOK = oF.Ok
   mvarCancelo = oF.Cancelo
   Unload oF
   Set oF = Nothing
   If mvarCancelo Then
      Exit Sub
   End If
   If Not mvarOK Then
'      MsgBox "Solo personal de PLANEAMIENTO puede asignar fechas de necesidad", vbExclamation
      Exit Sub
   End If
   
   Dim of1 'As frmAsignaFechaNecesidad
   Dim oL As ListItem
   Dim oDet As ComPronto.DetRequerimiento
   Dim mvarFechaNecesidad As Date
   
   'Set of1 = New frmAsignaFechaNecesidad
   
   With of1
      .Show vbModal, Me
      mvarOK = .Ok
      mvarFechaNecesidad = .DTFields(0).Value
   End With
   
   Unload of1
   Set of1 = Nothing
   
   If Not mvarOK Then
      Exit Sub
   End If
   
   If (mTipoObra = "Montaje" Or mTipoObra = "Servicio") And Not IsNull(origen.Registro.Fields("FechaAprobacion").Value) Then
      If mvarFechaNecesidad < origen.Registro.Fields("FechaAprobacion").Value Then
         DoEvents
         MsgBox "La fecha de necesidad no puede ser anterior" & vbCrLf & "a la fecha de liberacion de la RM", vbExclamation
         Exit Sub
      End If
   End If
   
   For Each oL In Lista.ListItems
      With oL
         If .Selected Then
            .SubItems(8) = "" & mvarFechaNecesidad
            Set oDet = origen.DetRequerimientos.Item(.Tag)
            oDet.Registro.Fields("FechaEntrega").Value = mvarFechaNecesidad
            oDet.Modificado = True
            Set oDet = Nothing
            .SmallIcon = "Modificado"
         End If
      End With
   Next
   
   mvarModificado = True
   
End Sub

Public Sub AsignaCCalidad()

   If Not mFirmaActiva Then
   
      Dim mvarOK, mvarCancelo As Boolean
      Dim oF As frmAutorizacion2
      
      Set oF = New frmAutorizacion2
      With oF
         .Sector = "Control de Calidad"
         .Show vbModal, Me
      End With
      mvarOK = oF.Ok
      mvarCancelo = oF.Cancelo
      Unload oF
      Set oF = Nothing
      If mvarCancelo Then
         Exit Sub
      End If
      If Not mvarOK Then
         MsgBox "Solo personal de Control de Calidad puede asignar los controles", vbExclamation
         Exit Sub
      End If
   
   End If
   
   Dim of1 'As frmAsignaCCalidad
   Dim oL As ListItem
   Dim oDet As ComPronto.DetRequerimiento
   Dim mvarCCalidad As Long
   
   'Set of1 = New frmAsignaCCalidad
   
   With of1
      .Show vbModal, Me
      mvarOK = .Ok
      If .Ok Then mvarCCalidad = .DataCombo1(0).BoundText
   End With
   
   Unload of1
   Set of1 = Nothing
   
   If Not mvarOK Then
      Exit Sub
   End If
   
   For Each oL In Lista.ListItems
      With oL
         If .Selected Then
            .SubItems(9) = "" & Aplicacion.ControlesCalidad.Item(mvarCCalidad).Registro.Fields("Abreviatura").Value
            Set oDet = origen.DetRequerimientos.Item(.Tag)
            oDet.Registro.Fields("IdControlCalidad").Value = mvarCCalidad
            oDet.Modificado = True
            Set oDet = Nothing
            .SmallIcon = "Modificado"
         End If
      End With
   Next
   
   mvarModificado = True
   
End Sub

Public Sub AsignaFacturaCompra()

   Dim mvarOK As Boolean, mvarCancelo As Boolean
   Dim mIdAutorizo As Long
   
   Dim oF As frmAutorizacion2
   Set oF = New frmAutorizacion2
   With oF
      .Sector = "Compras"
      .Show vbModal, Me
   End With
   mvarOK = oF.Ok
   mvarCancelo = oF.Cancelo
   mIdAutorizo = oF.IdAutorizo
   Unload oF
   Set oF = Nothing
   If mvarCancelo Then
      Exit Sub
   End If
   If Not mvarOK Then
      MsgBox "Solo personal de COMPRAS puede asignar las facturas", vbExclamation
      Exit Sub
   End If
   
   Dim of1 'As frmAsignaFacturaCompra
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim mDet As String, mDetId As String
   
   'Set of1 = New frmAsignaFacturaCompra
   
   mDet = ""
   mDetId = ""
   
   For Each oL In Lista.ListItems
      With oL
         If .Selected Then
            mDetId = mDetId & .Tag & ", "
            mDet = mDet & .Text & ", "
         End If
      End With
   Next
   If Len(mDet) Then
      mDet = mId(mDet, 1, Len(mDet) - 2)
      mDetId = mId(mDetId, 1, Len(mDetId) - 2)
   End If
   
   With of1
      .TipoComprobante = EnumFormularios.RequerimientoMateriales
      .IdComprobante = mvarId
      .NumeroComprobante = txtNumeroRequerimiento.Text
      .FechaComprobante = DTFields(0).Value
      .ItemsSeleccionados = mDet
      .IdItemsSeleccionados = mDetId
      If IsNumeric(dcfields(5).BoundText) Then
         .dcfields(1).BoundText = dcfields(5).BoundText
      End If
      .Show vbModal, Me
   End With

   If of1.Cumplido = "SI" Then
      For Each oL In Lista.ListItems
         With oL
            If .Selected Then
               origen.DetRequerimientos.Item(.Tag).Registro.Fields("Cumplido").Value = "SI"
               origen.DetRequerimientos.Item(.Tag).Modificado = True
               .SubItems(12) = "SI"
               .SmallIcon = "Modificado"
            End If
         End With
      Next
   End If

   Unload of1
   Set of1 = Nothing
   
   Set oRs = Nothing

   mvarModificado = True
   
'            Set oDet = origen.DetRequerimientos.Item(.Tag)
'            With oDet.Registro
'               If Not IsNull(.Fields("NumeroFacturaCompra1").Value) Then
'                  of1.txtNumeroFactura1.Text = .Fields("NumeroFacturaCompra1").Value
'               End If
'               If Not IsNull(.Fields("NumeroFacturaCompra2").Value) Then
'                  of1.txtNumeroFactura2.Text = .Fields("NumeroFacturaCompra2").Value
'               End If
'               If Not IsNull(.Fields("FechaFacturaCompra").Value) Then
'                  of1.DTFields(0).Value = .Fields("FechaFacturaCompra").Value
'               Else
'                  of1.DTFields(0).Value = Date
'               End If
'               If Not IsNull(.Fields("ImporteFacturaCompra").Value) Then
'                  of1.txtImporteFactura.Text = .Fields("ImporteFacturaCompra").Value
'               End If
'               If Not IsNull(.Fields("IdProveedor").Value) Then
'                  of1.dcfields(0).BoundText = .Fields("IdProveedor").Value
'               Else
'                  Set oRs = Aplicacion.Pedidos.TraerFiltrado("_PorItemRequerimiento", .Fields(0).Value)
'                  If oRs.RecordCount > 0 Then
'                     oRs.MoveFirst
'                     of1.dcfields(0).BoundText = oRs.Fields("IdProveedor").Value
'                  End If
'                  oRs.Close
'               End If
'            End With
'            of1.IdDetReq = .Tag
'            of1.CantReq = .SubItems(3)
'            of1.ArtReq = .SubItems(7)
'            of1.CargarDatos
'            If Not IsNull(oDet.Registro.Fields("Cumplido").Value) Then
'               of1.Cumplido = oDet.Registro.Fields("Cumplido").Value
'            Else
'               of1.Cumplido = "NO"
'            End If
'            of1.Show vbModal, Me
'            If of1.OK Then
''               .SubItems(9) = "" & Aplicacion.ControlesCalidad.Item(mvarCCalidad).Registro.Fields("Abreviatura").Value
'               With oDet.Registro
'                  .Fields("NumeroFacturaCompra1").Value = Val(of1.txtNumeroFactura1.Text)
'                  .Fields("NumeroFacturaCompra2").Value = Val(of1.txtNumeroFactura2.Text)
'                  .Fields("FechaFacturaCompra").Value = of1.DTFields(0).Value
'                  .Fields("ImporteFacturaCompra").Value = Val(of1.txtImporteFactura.Text)
'                  .Fields("IdProveedor").Value = of1.dcfields(0).BoundText
'                  .Fields("Cumplido").Value = of1.Cumplido
'                  .Fields("Usuario1").Value = glbInicialesUsuario
'                  .Fields("FechaIngreso1").Value = Now
'               End With
'               oDet.Modificado = True
'               .SmallIcon = "Modificado"
'            End If
'            Set oDet = Nothing
   
End Sub

Private Function AprobadoEdicion() As Boolean

   Dim oChk As CheckBox
   Dim mAprob As Boolean
   
   If mvarId > 0 Then
      mAprob = True
      For Each oChk In Check1
         If oChk.Visible And oChk.Value = 1 And oChk.Index > 0 Then
            mAprob = False
            Exit For
         End If
      Next
   Else
      mAprob = True
   End If

   AprobadoEdicion = mAprob
   
End Function

Private Sub PideAutorizacion(ByVal Firma As Integer)

   Dim oF As frmAutorizacion1
   Set oF = New frmAutorizacion1
   With oF
      .IdUsuario = dcfields(4).BoundText
      .Show vbModal, Me
   End With
   If Not oF.Ok Then
      With origen.Registro
         If Firma = 1 Then
            .Fields("Aprobo").Value = Null
            .Fields("FechaAprobacion").Value = Null
            mIdAprobo = 0
            If mFirmasLiberacion = 1 Then Check1(0).Value = 0
         Else
            .Fields("Aprobo2").Value = Null
            .Fields("FechaAprobacion2").Value = Null
            mIdAprobo1 = 0
            Check1(0).Value = 0
         End If
      End With
   Else
      If (mTipoObra = "Montaje" Or mTipoObra = "Servicio") And Not origen.FechasNecesidad_Liberacion(Date) Then
         DoEvents
         MsgBox "Existen items en la RM que tiene fecha de necesidad anterior" & vbCrLf & "a la fecha de liberacion, modifique primero las fechas de necesidad", vbExclamation
         With origen.Registro
            .Fields(dcfields(4).DataField).Value = Null
            .Fields("FechaAprobacion").Value = Null
         End With
         Check1(0).Value = 0
         mIdAprobo = 0
      Else
         With origen.Registro
            If Firma = 1 Then
               .Fields("FechaAprobacion").Value = Now
               mIdAprobo = IIf(IsNull(.Fields("Aprobo").Value), 0, .Fields("Aprobo").Value)
               txtFechaAprobacion.Text = Now
               If mFirmasLiberacion = 1 Then Check1(0).Value = 1
            Else
               .Fields("FechaAprobacion2").Value = Now
               mIdAprobo1 = IIf(IsNull(.Fields("Aprobo2").Value), 0, .Fields("Aprobo2").Value)
               txtFechaAprobacion1.Text = Now
               Check1(0).Value = 1
            End If
         End With
      End If
   End If
   Unload oF
   Set oF = Nothing

End Sub

Public Sub AsignaProveedor()

   On Error Resume Next
   
   Dim mvarOK, mvarCancelo As Boolean
   Dim mIdAutorizo As Long
   
   Dim oF As frmAutorizacion2
   Set oF = New frmAutorizacion2
   With oF
      .Sector = "Compras"
      .Show vbModal, Me
   End With
   mvarOK = oF.Ok
   mvarCancelo = oF.Cancelo
   mIdAutorizo = oF.IdAutorizo
   Unload oF
   Set oF = Nothing
   If mvarCancelo Then
      Exit Sub
   End If
   If Not mvarOK Then
      MsgBox "Solo personal de COMPRAS puede asignar un proveedor", vbExclamation
      Exit Sub
   End If
   
   Dim of1 'As frmAsignaProveedor
   Dim oL As ListItem
   Dim mDet, mDetId As String
   Dim mIdProv, mIdLlamadoAProveedor, mIdLlamadoRegistradoPor As Long
   Dim mFechaLlamadoAProveedor, mFechaRegistracionLlamada, mFechaEntrega As Date
   
   'Set of1 = New frmAsignaProveedor
   
   mDet = ""
   mDetId = ""
   mIdProv = 0
   mIdLlamadoAProveedor = glbIdUsuario
   mIdLlamadoRegistradoPor = glbIdUsuario
   mFechaLlamadoAProveedor = Now
   mFechaRegistracionLlamada = Now
   mFechaEntrega = Now
   
   rchObservacionesDetalle.TextRTF = ""
   
   For Each oL In Lista.ListItems
      With oL
         If .Selected Then
            mDetId = mDetId & .Tag & ", "
            mDet = mDet & .Text & ", "
            If mIdProv = 0 Then
               With origen.DetRequerimientos.Item(.Tag).Registro
                  If Not IsNull(.Fields("IdProveedor").Value) Then
                     mIdProv = .Fields("IdProveedor").Value
                  End If
                  If Not IsNull(.Fields("IdLlamadoAProveedor").Value) Then
                     mIdLlamadoAProveedor = .Fields("IdLlamadoAProveedor").Value
                     mFechaLlamadoAProveedor = .Fields("FechaLlamadoAProveedor").Value
                     mIdLlamadoRegistradoPor = .Fields("IdLlamadoRegistradoPor").Value
                     mFechaRegistracionLlamada = .Fields("FechaRegistracionLlamada").Value
                     mFechaEntrega = .Fields("FechaEntrega_Tel").Value
                  End If
                  If Not IsNull(.Fields("ObservacionesLlamada").Value) Then
                     rchObservacionesDetalle.TextRTF = .Fields("ObservacionesLlamada").Value
                  End If
               End With
            End If
         End If
      End With
   Next
   If Len(mDet) Then
      mDet = mId(mDet, 1, Len(mDet) - 2)
      mDetId = mId(mDetId, 1, Len(mDetId) - 2)
   End If
   
   With of1
      .txtFechaRegistracion.Text = "" & mFechaRegistracionLlamada
      .txtRegistradoPor.Text = Aplicacion.Empleados.Item(mIdLlamadoRegistradoPor).Registro.Fields("Nombre").Value
      .rchObservacionesLlamada.TextRTF = rchObservacionesDetalle.Text
      .IdLlamadoAProveedor = mIdLlamadoAProveedor
      .FechaLlamadoAProveedor = mFechaLlamadoAProveedor
      .TipoComprobante = EnumFormularios.RequerimientoMateriales
      .IdComprobante = mvarId
      .NumeroComprobante = txtNumeroRequerimiento.Text
      .FechaComprobante = DTFields(0).Value
      .FechaEntrega = mFechaEntrega
      .IdProveedor = mIdProv
      .ItemsSeleccionados = mDet
      .IdItemsSeleccionados = mDetId
      .Show vbModal, Me
   End With

   If of1.Ok Then
      For Each oL In Lista.ListItems
         With oL
            If .Selected Then
               origen.DetRequerimientos.Item(.Tag).Registro.Fields("IdProveedor").Value = of1.dcfields(0).BoundText
               origen.DetRequerimientos.Item(.Tag).Registro.Fields("IdLlamadoAProveedor").Value = of1.dcfields(1).BoundText
               origen.DetRequerimientos.Item(.Tag).Registro.Fields("FechaLlamadoAProveedor").Value = of1.DTFields(0).Value
               origen.DetRequerimientos.Item(.Tag).Registro.Fields("IdLlamadoRegistradoPor").Value = mIdLlamadoRegistradoPor
               origen.DetRequerimientos.Item(.Tag).Registro.Fields("FechaRegistracionLlamada").Value = mFechaRegistracionLlamada
               origen.DetRequerimientos.Item(.Tag).Registro.Fields("FechaEntrega_Tel").Value = of1.DTFields(1).Value
               origen.DetRequerimientos.Item(.Tag).Registro.Fields("ObservacionesLlamada").Value = of1.rchObservacionesLlamada.Text
               origen.DetRequerimientos.Item(.Tag).Modificado = True
               .SubItems(13) = "" & of1.dcfields(0).Text
            End If
         End With
      Next
   End If

   Unload of1
   Set of1 = Nothing
   
   mvarModificado = True
   
End Sub

Public Sub DuplicarItem()

   Dim oRs As ADOR.Recordset
   Dim oL As ListItem, oL1 As ListItem
   Dim idDet As Long, i As Long, mItem As Long
   
   Set oRs = origen.DetRequerimientos.Item(Lista.SelectedItem.Tag).Registro
   
   mItem = origen.DetRequerimientos.UltimoItemDetalle
   
   With origen.DetRequerimientos.Item(-1)
      .Registro.Fields("NumeroItem").Value = mItem
      For i = 2 To oRs.Fields.Count - 1
         If oRs.Fields(i).Name <> "NumeroItem" Then
            .Registro.Fields(i).Value = oRs.Fields(i).Value
         End If
      Next
      .Modificado = True
      idDet = .Id
   End With
   Set oRs = Nothing
   
   Set oL = Lista.SelectedItem
   Set oL1 = Lista.ListItems.Add
   With oL1
      .Tag = idDet
      .SmallIcon = "Nuevo"
      .Text = "" & mItem
      For i = 1 To oL.ListSubItems.Count
         .SubItems(i) = oL.SubItems(i)
      Next
   End With
   Set oL = Nothing
   Set oL1 = Nothing

End Sub

Public Sub MostrarCliente(ByVal IdObra As Long)

   Dim oRs As ADOR.Recordset
   
   Set oRs = Aplicacion.Obras.TraerFiltrado("_DatosDeLaObra", IdObra)
   
   txtCliente.Text = ""
   If oRs.RecordCount > 0 Then
      If Not IsNull(oRs.Fields("Cliente").Value) Then
         txtCliente.Text = oRs.Fields("Cliente").Value
      End If
   End If
   oRs.Close
   Set oRs = Nothing

End Sub

Public Sub RenumerarItems()

   Dim oL As ListItem
   Dim i As Integer
   
   i = 1
   For Each oL In Lista.ListItems
      With origen.DetRequerimientos.Item(oL.Tag)
         If Not .Eliminado Then
            .Registro.Fields("NumeroItem").Value = i
            .Modificado = True
            oL.Text = i
            i = i + 1
         End If
      End With
   Next

End Sub

Public Sub AnularItems()

   Dim mIdAutorizo As Long
   Dim mvarSale As Integer, i As Integer
   Dim mOk As Boolean
   Dim s As String
   Dim Filas, Columnas
   Dim oRs As ADOR.Recordset
   
   mvarSale = MsgBox("Esta seguro de anular el item ?", vbYesNo, "Anulacion")
   If mvarSale = vbNo Then
      Exit Sub
   End If
   
   Dim oF As Form
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.RequerimientoMateriales
      .Show vbModal, Me
      mOk = .Ok
   End With
   mIdAutorizo = oF.IdAutorizo
   Unload oF
   Set oF = Nothing
   If Not mOk Then Exit Sub

   s = ""
   Filas = VBA.Split(Lista.GetString, vbCrLf)
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      Set oRs = Aplicacion.TablasGenerales.TraerUno("DetRequerimientos", CLng(Columnas(0)))
      If IIf(IsNull(oRs.Fields("Cumplido").Value), "NO", oRs.Fields("Cumplido").Value) <> "NO" Then
         s = s & vbCrLf & oRs.Fields("NumeroItem").Value
      Else
         Aplicacion.Tarea "Requerimientos_AnularItem", Columnas(0)
      End If
      oRs.Close
   Next
   Set oRs = Nothing
   Aplicacion.Tarea "Requerimientos_ActualizarEstado", Array(mvarId, 0)
   If Len(s) > 0 Then
      MsgBox "Los siguientes items no se anularon por tener un estado no anulable : " & s, vbExclamation
   End If
   Unload Me

End Sub

Public Sub EstadoFrame4()

   If Option10.Value Then
      With txtCodigoCuenta
         .Text = ""
         .Enabled = False
      End With
      dcfields(10).Enabled = False
      txtMesPresupuesto.Enabled = False
      txtMontoPrevisto1.Enabled = False
      With origen.Registro
         .Fields("IdCuentaPresupuesto").Value = Null
         .Fields("MesPresupuesto").Value = Null
         .Fields("MontoPrevisto").Value = Null
      End With
   Else
      txtCodigoCuenta.Enabled = True
      dcfields(10).Enabled = True
      txtMesPresupuesto.Enabled = True
      txtMontoPrevisto1.Enabled = True
   End If

End Sub
