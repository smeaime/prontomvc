VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmCCalidades 
   Caption         =   "Control de calidad de materiales"
   ClientHeight    =   7365
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10290
   Icon            =   "frmCCalidades.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7365
   ScaleWidth      =   10290
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdImpre 
      Height          =   405
      Index           =   1
      Left            =   1665
      Picture         =   "frmCCalidades.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   49
      Top             =   6525
      Width           =   1485
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   405
      Index           =   0
      Left            =   1665
      Picture         =   "frmCCalidades.frx":0CF4
      Style           =   1  'Graphical
      TabIndex        =   47
      Top             =   6075
      UseMaskColor    =   -1  'True
      Width           =   1485
   End
   Begin VB.TextBox txtNumeroRecepcionAlmacen 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
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
      Left            =   7425
      Locked          =   -1  'True
      TabIndex        =   44
      Top             =   90
      Width           =   1185
   End
   Begin VB.TextBox txtNumeroItemAcopio 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
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
      Left            =   7425
      Locked          =   -1  'True
      TabIndex        =   38
      Top             =   1290
      Width           =   690
   End
   Begin VB.TextBox txtNumeroAcopio 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
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
      Left            =   2070
      Locked          =   -1  'True
      TabIndex        =   37
      Top             =   1260
      Width           =   1500
   End
   Begin VB.TextBox txtNumeroItemRequerimiento 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
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
      Left            =   7425
      Locked          =   -1  'True
      TabIndex        =   32
      Top             =   885
      Width           =   690
   End
   Begin VB.TextBox txtNumeroRequerimiento 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
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
      Left            =   2070
      Locked          =   -1  'True
      TabIndex        =   31
      Top             =   855
      Width           =   1500
   End
   Begin VB.TextBox txtCantidadRechazadaCC 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadRechazadaCC"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   1
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
      Left            =   5760
      Locked          =   -1  'True
      TabIndex        =   6
      Top             =   2880
      Width           =   1635
   End
   Begin VB.TextBox txtCantidadCC 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadCC"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   1
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
      Left            =   2070
      Locked          =   -1  'True
      TabIndex        =   5
      Top             =   2880
      Width           =   1635
   End
   Begin VB.TextBox txtNumeroRecepcion 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
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
      Left            =   2070
      Locked          =   -1  'True
      TabIndex        =   22
      Top             =   105
      Width           =   1500
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   1
      Top             =   6075
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   135
      TabIndex        =   2
      Top             =   6525
      Width           =   1485
   End
   Begin VB.TextBox txtCantidad2 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad2"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   1
      EndProperty
      Height          =   315
      Left            =   6390
      TabIndex        =   12
      Top             =   2085
      Width           =   870
   End
   Begin VB.TextBox txtCantidad 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   1
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   2070
      TabIndex        =   11
      Top             =   2085
      Width           =   870
   End
   Begin VB.TextBox txtCantidad1 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad1"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   1
      EndProperty
      Height          =   315
      Left            =   5085
      TabIndex        =   10
      Top             =   2085
      Width           =   870
   End
   Begin VB.TextBox txtNumeroPedido 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
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
      Left            =   2070
      Locked          =   -1  'True
      TabIndex        =   9
      Top             =   465
      Width           =   1500
   End
   Begin VB.TextBox txtNumeroItemPedido 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
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
      Left            =   7425
      Locked          =   -1  'True
      TabIndex        =   8
      Top             =   495
      Width           =   690
   End
   Begin VB.TextBox txtUnidad 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
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
      Left            =   7290
      TabIndex        =   7
      Top             =   2085
      Width           =   2895
   End
   Begin VB.TextBox txtPartida 
      Alignment       =   1  'Right Justify
      DataField       =   "Partida"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   1
      EndProperty
      Height          =   315
      Left            =   2070
      TabIndex        =   3
      Top             =   2430
      Width           =   1635
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   2070
      TabIndex        =   13
      Tag             =   "Articulos"
      Top             =   1710
      Width           =   8160
      _ExtentX        =   14393
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   0
      Left            =   2970
      TabIndex        =   14
      Tag             =   "Unidades"
      Top             =   2085
      Width           =   2040
      _ExtentX        =   3598
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdControlCalidad"
      Height          =   315
      Index           =   4
      Left            =   5760
      TabIndex        =   4
      Tag             =   "ControlesCalidad"
      Top             =   2445
      Width           =   4470
      _ExtentX        =   7885
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdControlCalidad"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   375
      Index           =   0
      Left            =   4590
      TabIndex        =   24
      Top             =   90
      Width           =   1425
      _ExtentX        =   2514
      _ExtentY        =   661
      _Version        =   393216
      Enabled         =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   64225281
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   375
      Index           =   1
      Left            =   4590
      TabIndex        =   26
      Top             =   495
      Width           =   1425
      _ExtentX        =   2514
      _ExtentY        =   661
      _Version        =   393216
      Enabled         =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   64225281
      CurrentDate     =   36377
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   9630
      Top             =   720
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
            Picture         =   "frmCCalidades.frx":135E
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCCalidades.frx":1470
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCCalidades.frx":18C2
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCCalidades.frx":1D14
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   2265
      Left            =   90
      TabIndex        =   0
      Top             =   3285
      Width           =   10140
      _ExtentX        =   17886
      _ExtentY        =   3995
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmCCalidades.frx":2166
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   30
      Top             =   7080
      Width           =   10290
      _ExtentX        =   18150
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   375
      Index           =   2
      Left            =   4590
      TabIndex        =   33
      Top             =   885
      Width           =   1425
      _ExtentX        =   2514
      _ExtentY        =   661
      _Version        =   393216
      Enabled         =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   64225281
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   375
      Index           =   3
      Left            =   4590
      TabIndex        =   39
      Top             =   1290
      Width           =   1425
      _ExtentX        =   2514
      _ExtentY        =   661
      _Version        =   393216
      Enabled         =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   64225281
      CurrentDate     =   36377
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      DataField       =   "Observaciones"
      Height          =   1185
      Left            =   3195
      TabIndex        =   45
      Top             =   5805
      Width           =   7035
      _ExtentX        =   12409
      _ExtentY        =   2090
      _Version        =   393217
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmCCalidades.frx":2182
   End
   Begin RichTextLib.RichTextBox rchObservacionesItem 
      Height          =   285
      Left            =   9585
      TabIndex        =   48
      Top             =   2880
      Visible         =   0   'False
      Width           =   195
      _ExtentX        =   344
      _ExtentY        =   503
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmCCalidades.frx":2204
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   165
      Index           =   18
      Left            =   3285
      TabIndex        =   46
      Top             =   5625
      Width           =   1185
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro. almacen  :"
      Height          =   345
      Index           =   17
      Left            =   6210
      TabIndex        =   43
      Top             =   90
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item de aco. :"
      Height          =   345
      Index           =   16
      Left            =   6210
      TabIndex        =   42
      Top             =   1290
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de l. de acopio :"
      Height          =   300
      Index           =   15
      Left            =   90
      TabIndex        =   41
      Top             =   1260
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   285
      Index           =   14
      Left            =   3690
      TabIndex        =   40
      Top             =   1335
      Width           =   855
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item de RM :"
      Height          =   345
      Index           =   13
      Left            =   6210
      TabIndex        =   36
      Top             =   900
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de RM :"
      Height          =   300
      Index           =   10
      Left            =   90
      TabIndex        =   35
      Top             =   900
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   285
      Index           =   9
      Left            =   3690
      TabIndex        =   34
      Top             =   930
      Width           =   855
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad rechazada :"
      Height          =   300
      Index           =   12
      Left            =   4095
      TabIndex        =   29
      Top             =   2925
      Width           =   1545
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad aceptada :"
      Height          =   300
      Index           =   8
      Left            =   90
      TabIndex        =   28
      Top             =   2880
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   285
      Index           =   6
      Left            =   3690
      TabIndex        =   27
      Top             =   540
      Width           =   855
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   285
      Index           =   3
      Left            =   3690
      TabIndex        =   25
      Top             =   135
      Width           =   855
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de recepcion :"
      Height          =   300
      Index           =   5
      Left            =   90
      TabIndex        =   23
      Top             =   150
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Control de calidad :"
      Height          =   345
      Index           =   11
      Left            =   4095
      TabIndex        =   21
      Top             =   2445
      Width           =   1545
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   2
      Left            =   90
      TabIndex        =   20
      Top             =   1658
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   90
      TabIndex        =   19
      Top             =   2035
      Width           =   1815
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "X"
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
      Left            =   6030
      TabIndex        =   18
      Top             =   2130
      Width           =   285
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de pedido :"
      Height          =   300
      Index           =   0
      Left            =   90
      TabIndex        =   17
      Top             =   527
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item de ped. :"
      Height          =   345
      Index           =   4
      Left            =   6210
      TabIndex        =   16
      Top             =   495
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Partida :"
      Height          =   300
      Index           =   1
      Left            =   90
      TabIndex        =   15
      Top             =   2415
      Width           =   1815
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
Attribute VB_Name = "frmCCalidades"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.CCalidad
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim mvarIdUnidadCU As Integer
Private mvarIdNuevo As Long, mvarId As Long, mvarIdCabecera As Long, mvarIdUnidad As Long
Private mvarCantidadAdicionalCC As Double, mvarCantidadUnidadesCC As Double
Private mTipo As String
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

   Dim oF As frmDetControlesCalidad
   Dim oL As ListItem
   
   Set oF = New frmDetControlesCalidad
   
   With oF
      Set .CCalidad = origen
      .Id = Cual
      .IdEntidad = mvarId
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
            .Text = oF.DTFields(0).Value
            .SubItems(1) = "" & Format(oF.txtCantidad.Text, "Fixed")
            .SubItems(2) = "" & Format(oF.txtCantidadRechazada.Text, "Fixed")
            If IsNumeric(oF.DataCombo1(2).BoundText) Then
               .SubItems(3) = "" & Aplicacion.MotivosRechazo.Item(oF.DataCombo1(2).BoundText).Registro.Fields("Descripcion").Value
            End If
            .SubItems(4) = "" & oF.txtTrasabilidad.Text
         End With
      End If
   End With
   
   Unload oF
   Set oF = Nothing
   
   With origen.Registro
      .Fields("CantidadCC").Value = origen.DetControlesCalidad.CantidadAceptada
      .Fields("CantidadRechazadaCC").Value = origen.DetControlesCalidad.CantidadRechazada
   End With

End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         mvarCantidadUnidadesCC = IIf(IsNull(origen.Registro.Fields("CantidadCC").Value), 0, origen.Registro.Fields("CantidadCC").Value)
         mvarCantidadAdicionalCC = 0
         
         If Lista.ListItems.Count = 0 Then
            MsgBox "No hay detalles ingresados"
            Exit Sub
         End If
         
'         If Not IsNumeric(txtCantidadCC.Text) Then
'            MsgBox "La cantidad aprobada debe ser un numero mayor a 0", vbCritical
'            Exit Sub
'         End If
         
         If origen.Registro.Fields("CantidadCC").Value < 0 Then
            MsgBox "La cantidad aprobada debe ser un numero mayor a 0", vbCritical
            Exit Sub
         End If
         
         If origen.Registro.Fields("Cantidad").Value < origen.Registro.Fields("CantidadCC").Value + origen.Registro.Fields("CantidadRechazadaCC").Value Then
            MsgBox "La cantidad aprobada no puede ser superior a la ingresada mas la rechazada", vbCritical
            Exit Sub
         End If

         If txtCantidad1.Visible Then mvarCantidadAdicionalCC = Val(txtCantidad1.Text)

         If txtCantidad2.Visible Then mvarCantidadAdicionalCC = Val(txtCantidad1.Text) * Val(txtCantidad2.Text)

         Dim est As EnumAcciones
         Dim dc As DataCombo
         Dim oRs As ADOR.Recordset
   
         With origen.Registro
            For Each dc In DataCombo1
               If dc.Enabled Then
                  If Not IsNumeric(dc.BoundText) Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
                  .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
'            .Fields("CantidadAdicionalCC").Value = mvarCantidadAdicionalCC * mvarCantidadUnidadesCC
            If .Fields("Cantidad").Value > .Fields("CantidadCC").Value + .Fields("CantidadRechazadaCC").Value Then
               .Fields("Controlado").Value = "PA"
               est = Modificacion
            Else
               .Fields("Controlado").Value = "CO"
               est = baja
            End If
         End With
         
         Select Case origen.Guardar
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
         With actL2
            .ListaEditada = "CCalidadesTodos,CCalidadesUltimos3Meses,CCalidadesPendientes"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
   End Select
   
   Unload Me
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oDet As ComPronto.DetControlCalidad
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   Dim ListaVacia As Boolean
   
   Set oAp = Aplicacion
   
   mvarId = vnewvalue
   
   mvarIdCabecera = 0
   If vnewvalue > 1000000 Then
      vnewvalue = vnewvalue - 1000000
      Me.Tipo = "OTR"
      Set oRs = oAp.TablasGenerales.TraerUno("DetOtrosIngresosAlmacen", vnewvalue)
      If oRs.RecordCount > 0 Then
         mvarIdCabecera = oRs.Fields("IdOtroIngresoAlmacen").Value
      End If
      oRs.Close
      Set oRs = oAp.OtrosIngresosAlmacen.TraerFiltrado("_PorId", mvarIdCabecera)
      If oRs.RecordCount > 0 Then
         txtNumeroRecepcion.Text = Format(oRs.Fields("NumeroOtroIngresoAlmacen").Value, "00000000")
         DTFields(0).Value = oRs.Fields("FechaOtroIngresoAlmacen").Value
      End If
      lblLabels(5).Caption = "Nro.Otros Ing.:"
      lblLabels(17).Visible = False
      txtNumeroRecepcionAlmacen.Visible = False
   Else
      Me.Tipo = "REC"
      Set oRs = oAp.TablasGenerales.TraerUno("DetRecepciones", vnewvalue)
      If oRs.RecordCount > 0 Then
         mvarIdCabecera = oRs.Fields("IdRecepcion").Value
      End If
      oRs.Close
      Set oRs = oAp.Recepciones.TraerFiltrado("_PorId", mvarIdCabecera)
      If oRs.RecordCount > 0 Then
         txtNumeroRecepcion.Text = Format(oRs.Fields("NumeroRecepcion1").Value, "0000") & "-" & Format(oRs.Fields("NumeroRecepcion2").Value, "00000000")
         txtNumeroRecepcionAlmacen.Text = IIf(IsNull(oRs.Fields("NumeroRecepcionAlmacen").Value), "", oRs.Fields("NumeroRecepcionAlmacen").Value)
         DTFields(0).Value = oRs.Fields("FechaRecepcion").Value
      End If
      lblLabels(5).Caption = "Numero de recepcion :"
   End If
   oRs.Close
   
   ListaVacia = False
   
   Set origen = oAp.CCalidades.Item(mvarId)
   Me.IdNuevo = origen.Id
   Set oBind = New BindingCollection
   
   Set oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
   mvarIdUnidadCU = 0
   If oRs.RecordCount > 0 Then
      mvarIdUnidadCU = IIf(IsNull(oRs.Fields("IdUnidadPorUnidad").Value), 0, oRs.Fields("IdUnidadPorUnidad").Value)
   End If
   oRs.Close
   
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetControlesCalidad.TraerMascara
                     ListaVacia = True
                  Else
                     Set oRs = origen.DetControlesCalidad.TraerTodos
                     If oRs.RecordCount > 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           Set oDet = origen.DetControlesCalidad.Item(oRs.Fields(0).Value)
                           Set oDet = Nothing
                           oRs.MoveNext
                        Loop
                        ListaVacia = False
                     Else
                        Set oControl.DataSource = origen.DetControlesCalidad.TraerMascara
                        ListaVacia = True
                     End If
                     oRs.Close
                  End If
            End Select
         ElseIf TypeOf oControl Is DTPicker Then
            If Len(oControl.DataField) Then .Add oControl, "Value", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   If Me.Tipo = "REC" Then
      If Not IsNull(origen.Registro("IdDetallePedido").Value) Then
         Set oRs = oAp.Pedidos.TraerFiltrado("_DatosPorIdDetalle", origen.Registro("IdDetallePedido").Value)
         If oRs.RecordCount > 0 Then
            If Not IsNull(oRs.Fields("NumeroPedido").Value) Then
               txtNumeroPedido.Text = oRs.Fields("NumeroPedido").Value
               DTFields(1).Value = oRs.Fields("FechaPedido").Value
               txtNumeroItemPedido.Text = oRs.Fields("IP").Value
            End If
            If Not IsNull(oRs.Fields("NumeroRequerimiento").Value) Then
               txtNumeroRequerimiento.Text = oRs.Fields("NumeroRequerimiento").Value
               DTFields(2).Value = oRs.Fields("FechaRequerimiento").Value
               txtNumeroItemRequerimiento.Text = oRs.Fields("IR").Value
            End If
            If Not IsNull(oRs.Fields("NumeroAcopio").Value) Then
               txtNumeroAcopio.Text = oRs.Fields("NumeroAcopio").Value
               DTFields(3).Value = oRs.Fields("FechaAcopio").Value
               txtNumeroItemAcopio.Text = oRs.Fields("IA").Value
            End If
         End If
         oRs.Close
      End If
      If Not IsNull(origen.Registro("IdDetalleRequerimiento").Value) Then
         Set oRs = oAp.Requerimientos.Item(0).DetRequerimientos.Item(origen.Registro("IdDetalleRequerimiento").Value).Registro
         If oRs.RecordCount > 0 Then
            txtNumeroRequerimiento.Text = oAp.Requerimientos.Item(oRs.Fields("IdRequerimiento").Value).Registro.Fields("NumeroRequerimiento").Value
            DTFields(2).Value = oAp.Requerimientos.Item(oRs.Fields("IdRequerimiento").Value).Registro.Fields("FechaRequerimiento").Value
            txtNumeroItemRequerimiento.Text = oRs.Fields("NumeroItem").Value
         End If
         oRs.Close
      End If
   End If
   
   Set oRs = oAp.Articulos.TraerFiltrado("_PorId", origen.Registro.Fields("IdArticulo").Value)
   If oRs.RecordCount > 0 Then
      If Not IsNull(oRs.Fields("IdCuantificacion").Value) Then
         If Not IsNull(oRs.Fields("Unidad11").Value) Then
            txtUnidad.Text = Aplicacion.Unidades.Item(oRs.Fields("Unidad11").Value).Registro.Fields("Descripcion").Value
'            txtUnidadCC.Text = Aplicacion.Unidades.Item(oRs.Fields("Unidad11").Value).Registro.Fields("Descripcion").Value
            mvarIdUnidad = oRs.Fields("Unidad11").Value
         End If
         Select Case oRs.Fields("IdCuantificacion").Value
            Case 1
               txtCantidad1.Visible = False
               txtCantidad2.Visible = False
               Label1(0).Visible = False
               txtUnidad.Visible = False
'               txtCantidad1CC.Visible = False
'               txtCantidad2CC.Visible = False
               Label1(1).Visible = False
'               txtUnidadCC.Visible = False
            Case 2
               txtCantidad2.Visible = False
               Label1(0).Visible = False
'               txtCantidad2CC.Visible = False
               Label1(1).Visible = False
            Case 3
         End Select
      End If
   End If
   oRs.Close
   
   If mvarId > 0 Then
      txtPartida.Enabled = False
   End If
   
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
   End If
   
   With origen.Registro
      If Not IsNull(.Fields("Controlado").Value) And .Fields("Controlado").Value <> "PA" Then
         cmd(0).Enabled = False
      End If
   End With
      
   If ListaVacia Then
      Lista.ListItems.Clear
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
End Property

Private Sub cmdImpre_Click(Index As Integer)

   Dim mvarOK As Boolean
   Dim mCopias As Integer
   
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
      Unload oF
      Set oF = Nothing
      If Not mvarOK Then
         Exit Sub
      End If
   Else
      mCopias = 1
   End If

   Dim oW As Word.Application, oW1 As Word.Application
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRsPrv As ADOR.Recordset
   Dim oRsArt As ADOR.Recordset
   Dim i As Integer, mPaginas As Integer, mNumeroRemito1 As Integer
   Dim mNumeroRemito2 As Integer
   Dim mvarUnidad As String, mvarMedidas As String, mvarLocalidad As String
   Dim mvarDescripcion As String, mvarAutorizo As String
   Dim mPlantilla As String, mNumero As String
   
   Me.MousePointer = vbHourglass
      
   On Error GoTo Mal
   
   Set oW = CreateObject("Word.Application")
   
   With oW
      
      .Visible = True
      
      With .Documents.Add(glbPathPlantillas & "\ControlCalidad.dot")
   
         Set oRs = Aplicacion.CCalidades.TraerFiltrado("_PorRemito", origen.Registro.Fields(0).Value)
         Set oRsPrv = Aplicacion.Proveedores.Item(oRs.Fields("IdProveedor").Value).Registro
         
         oW.Selection.HomeKey Unit:=wdStory
         oW.Selection.MoveDown Unit:=wdLine, Count:=8
         oW.Selection.MoveLeft Unit:=wdCell, Count:=1
          
         With oRs
            Do Until .EOF
               oW.Selection.MoveRight Unit:=wdCell
               If Not IsNull(.Fields("Pedido").Value) Then
                  If Not IsNull(.Fields("SubPedido").Value) Then
                     oW.Selection.TypeText Text:="" & .Fields("Pedido").Value & " / " & .Fields("SubPedido").Value
                  Else
                     oW.Selection.TypeText Text:="" & .Fields("Pedido").Value
                  End If
               End If
               oW.Selection.MoveRight Unit:=wdCell
               If Not IsNull(.Fields("It.Ped").Value) Then
                  oW.Selection.TypeText Text:="" & .Fields("It.Ped").Value
               End If
               oW.Selection.MoveRight Unit:=wdCell
               If Not IsNull(.Fields("RM").Value) Then
                  oW.Selection.TypeText Text:="" & .Fields("RM").Value
               End If
               oW.Selection.MoveRight Unit:=wdCell
               If Not IsNull(.Fields("It.RM").Value) Then
                  oW.Selection.TypeText Text:="" & .Fields("It.RM").Value
               End If
               oW.Selection.MoveRight Unit:=wdCell
               If Not IsNull(.Fields("LA").Value) Then
                  oW.Selection.TypeText Text:="" & .Fields("LA").Value
               End If
               oW.Selection.MoveRight Unit:=wdCell
               If Not IsNull(.Fields("It.LA").Value) Then
                  oW.Selection.TypeText Text:="" & .Fields("It.LA").Value
               End If
               
               Set oRsArt = Aplicacion.Articulos.Item(.Fields("IdArticulo").Value).Registro
               
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & oRsArt.Fields("Descripcion").Value
               oW.Selection.MoveRight Unit:=wdCell
               If Not IsNull(.Fields("Cant.").Value) Then
                  oW.Selection.TypeText Text:="" & .Fields("Cant.").Value
               End If
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & Aplicacion.Unidades.Item(.Fields("IdUnidad").Value).Registro.Fields("Abreviatura").Value
               mvarMedidas = ""
               If Not IsNull(oRsArt.Fields("IdCuantificacion").Value) Then
                  If Not IsNull(oRsArt.Fields("Unidad11").Value) Then
                     mvarUnidad = Aplicacion.Unidades.Item(oRsArt.Fields("Unidad11").Value).Registro.Fields("Abreviatura").Value
                  End If
                  Select Case oRsArt.Fields("IdCuantificacion").Value
                     Case 3
                        mvarMedidas = "" & .Fields("Med.1").Value & " x " & .Fields("Med.2").Value & " " & mvarUnidad
                     Case 2
                        mvarMedidas = "" & .Fields("Med.1").Value & " " & mvarUnidad
                  End Select
               End If
               oRsArt.Close
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & mvarMedidas
               
               Set oRsDet = origen.DetControlesCalidad.TraerFiltrado("Cal", .Fields("IdDetalleRecepcion").Value)
               
               If oRsDet.RecordCount > 0 Then
                  oRsDet.MoveFirst
                  Do While Not oRsDet.EOF
                     oW.Selection.MoveRight Unit:=wdCell
                     oW.Selection.MoveRight Unit:=wdCell, Count:=10
                     oW.Selection.MoveUp Unit:=wdLine, Count:=1
                     oW.Selection.MoveRight Unit:=wdCharacter, Count:=3, Extend:=wdExtend
                     oW.Selection.Cells.Merge
                     If Not IsNull(.Fields("Control de Calidad").Value) Then
                        oW.Selection.TypeText Text:="" & .Fields("Control de Calidad").Value
                     End If
                     oW.Selection.MoveRight Unit:=wdCell
                     oW.Selection.MoveRight Unit:=wdCharacter, Count:=4, Extend:=wdExtend
                     oW.Selection.Cells.Merge
                     If Not IsNull(oRsDet.Fields("Observaciones").Value) Then
                        If Len(Trim(oRsDet.Fields("Observaciones").Value)) > 2 Then
                           rchObservacionesItem.TextRTF = oRsDet.Fields("Observaciones").Value
                           oW.Selection.TypeText Text:="" & rchObservacionesItem.Text
                        End If
                     End If
                     oW.Selection.MoveRight Unit:=wdCell
                     If Not IsNull(oRsDet.Fields("Fecha").Value) Then
                        oW.Selection.TypeText Text:="" & oRsDet.Fields("Fecha").Value
                     End If
                     oW.Selection.MoveRight Unit:=wdCell
                     If Not IsNull(oRsDet.Fields("Cant.rech.").Value) Then
                        oW.Selection.TypeText Text:="" & oRsDet.Fields("Cant.rech.").Value
                     End If
                     oW.Selection.MoveRight Unit:=wdCell
                     If Not IsNull(oRsDet.Fields("Cantidad").Value) Then
                        oW.Selection.TypeText Text:="" & oRsDet.Fields("Cantidad").Value
                     End If
                     oRsDet.MoveNext
                  Loop
                  oRsDet.Close
               End If
               .MoveNext
            Loop
         End With
          
         oRs.MoveFirst
         
         If oW.ActiveWindow.View.SplitSpecial <> wdPaneNone Then
             oW.ActiveWindow.Panes(2).Close
         End If
         oW.ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageHeader
         oW.Selection.MoveRight Unit:=wdCell, Count:=3
         mNumero = Format(oRs.Fields("NumeroRecepcion1").Value, "0000") & " - " & _
                 Format(oRs.Fields("NumeroRecepcion2").Value, "00000000") & " / " & _
                 oRs.Fields("SubNumero").Value
         oW.Selection.TypeText Text:="" & mNumero
         oW.Selection.MoveRight Unit:=wdCell, Count:=2
         oW.Selection.TypeText Text:="" & oRs.Fields("Fecha recepcion").Value
         
         oW.ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageFooter
         oW.Selection.MoveRight Unit:=wdCell, Count:=1
         oW.Selection.TypeText Text:="" & rchObservaciones.Text
         
         oW.ActiveWindow.ActivePane.View.SeekView = wdSeekMainDocument
         
         oW.ActiveDocument.FormFields("Proveedor").Result = oRsPrv.Fields("RazonSocial").Value
         oW.ActiveDocument.FormFields("Direccion").Result = IIf(IsNull(oRsPrv.Fields("Direccion").Value), "", oRsPrv.Fields("Direccion").Value)
         mvarLocalidad = ""
         If Not IsNull(oRsPrv.Fields("CodigoPostal").Value) Then
            mvarLocalidad = "(" & oRsPrv.Fields("CodigoPostal").Value & ") "
         End If
         If Not IsNull(oRsPrv.Fields("IdLocalidad").Value) Then
            mvarLocalidad = mvarLocalidad & Aplicacion.Localidades.Item(oRsPrv.Fields("IdLocalidad").Value).Registro.Fields("Nombre").Value
         End If
         oW.ActiveDocument.FormFields("Localidad").Result = mvarLocalidad
         oW.ActiveDocument.FormFields("Telefono").Result = IIf(IsNull(oRsPrv.Fields("Telefono1").Value), "", "Tel.: " & oRsPrv.Fields("Telefono1").Value)
         oW.ActiveDocument.FormFields("Fax").Result = IIf(IsNull(oRsPrv.Fields("Fax").Value), "", "Fax : " & oRsPrv.Fields("Fax").Value)
         oW.ActiveDocument.FormFields("CuitProveedor").Result = "" & oRsPrv.Fields("Cuit").Value
         If Not IsNull(oRsPrv.Fields("IdCodigoIva").Value) Then
            oW.ActiveDocument.FormFields("CondicionIva").Result = Aplicacion.TablasGenerales.TraerFiltrado("DescripcionIva", "_TT", oRsPrv.Fields("IdCodigoIva").Value).Fields("Descripcion").Value
         End If
         If Not IsNull(oRsPrv.Fields("Email").Value) Then
            oW.ActiveDocument.FormFields("EmailProveedor").Result = oRsPrv.Fields("Email").Value
         End If
         If Not IsNull(oRs.Fields("IdTransportista").Value) Then
            oW.ActiveDocument.FormFields("Transportista").Result = Aplicacion.Transportistas.Item(oRs.Fields("IdTransportista").Value).Registro.Fields("RazonSocial").Value
         End If
         If Not IsNull(oRs.Fields("ACargo").Value) Then
            If oRs.Fields("ACargo").Value = "A" Then
               oW.ActiveDocument.FormFields("ACargo").Result = glbEmpresaSegunString
            Else
               oW.ActiveDocument.FormFields("ACargo").Result = "Proveedor"
            End If
         End If
         oW.ActiveDocument.FormFields("NumeroRemito").Result = "" & mNumero
         oW.ActiveDocument.FormFields("NumeroAlmacen").Result = "" & oRs.Fields("Nro.recep.alm.").Value
         If Not IsNull(oRs.Fields("Pedido").Value) Then
            If Not IsNull(oRs.Fields("SubPedido").Value) Then
               oW.ActiveDocument.FormFields("Pedido").Result = "" & oRs.Fields("Pedido").Value & " / " & oRs.Fields("SubPedido").Value
            Else
               oW.ActiveDocument.FormFields("Pedido").Result = "" & oRs.Fields("Pedido").Value
            End If
            oW.ActiveDocument.FormFields("FechaPedido").Result = "" & oRs.Fields("Fecha pedido").Value
         End If
         If Not IsNull(oRs.Fields("RM").Value) Then
            oW.ActiveDocument.FormFields("Requerimiento").Result = "" & oRs.Fields("RM").Value
            oW.ActiveDocument.FormFields("FechaRequerimiento").Result = "" & oRs.Fields("FechaRM").Value
         End If
         If Not IsNull(oRs.Fields("LA").Value) Then
            oW.ActiveDocument.FormFields("Acopio").Result = "" & oRs.Fields("LA").Value
            oW.ActiveDocument.FormFields("FechaAcopio").Result = "" & oRs.Fields("FechaLA").Value
         End If
'         oW.ActiveDocument.FormFields("Emitio").Result = dcfields(1).Text
         
         oRs.Close
         oRsPrv.Close
          
      End With
      
   End With
   
   'Registro de numero de paginas, fecha y hora   (, varg1:=mPaginas)
   oW.Application.Run MacroName:="DatosDelPie"
   oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
         
   If Index = 0 Then
      oW.Documents(1).PrintOut False, , , , , , , mCopias
      oW.Documents(1).Close False
      oW.Quit
   End If

Mal:

   Set oW = Nothing
   Set oRs = Nothing
   Set oRsDet = Nothing
   Set oRsPrv = Nothing
   Set oRsArt = Nothing

   Me.MousePointer = vbDefault

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vnewvalue As Variant)

   mvarIdNuevo = vnewvalue

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
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

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         Editar Lista.SelectedItem.Tag
      Case 2
         If mvarId > 0 Then
            MsgBox "No puede modificar un control ya grabado.", vbCritical
            Exit Sub
         End If
         With Lista.SelectedItem
            origen.DetControlesCalidad.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub txtCantidadCC_GotFocus()
   
   With txtCantidadCC
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidadCC_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCantidadRechazadaCC_GotFocus()

   With txtCantidadRechazadaCC
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidadRechazadaCC_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPartida_GotFocus()

   With txtPartida
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPartida_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Get Tipo() As String

   Tipo = mTipo

End Property

Public Property Let Tipo(ByVal vnewvalue As String)

   mTipo = vnewvalue

End Property
