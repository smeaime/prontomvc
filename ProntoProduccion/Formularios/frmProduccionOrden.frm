VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.3#0"; "Controles1013.ocx"
Object = "{126E538A-EE41-4B22-A045-F8D5538F5D2B}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmProduccionOrden 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Orden de Producción"
   ClientHeight    =   8895
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   12885
   Icon            =   "frmProduccionOrden.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   8895
   ScaleWidth      =   12885
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdRefrescar 
      Caption         =   "&Refrescar"
      Height          =   465
      Left            =   4200
      TabIndex        =   64
      Top             =   8280
      Width           =   1110
   End
   Begin VB.CommandButton cmdBuscarFicha 
      Caption         =   "Buscar fichas activas"
      Height          =   315
      Left            =   6120
      TabIndex        =   63
      Top             =   480
      Width           =   1695
   End
   Begin VB.CommandButton cmdDuplicarOP 
      Caption         =   "Copiar OP 2"
      Height          =   465
      Left            =   3000
      TabIndex        =   62
      Top             =   8280
      Visible         =   0   'False
      Width           =   1110
   End
   Begin VB.CommandButton cmdVerFicha 
      Caption         =   "Ver Ficha"
      Height          =   315
      Left            =   8160
      TabIndex        =   61
      Top             =   480
      Visible         =   0   'False
      Width           =   975
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   11040
      TabIndex        =   20
      Top             =   1680
      Width           =   1665
      _ExtentX        =   2937
      _ExtentY        =   582
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   1
      Left            =   11040
      TabIndex        =   21
      Top             =   2040
      Width           =   1665
      _ExtentX        =   2937
      _ExtentY        =   582
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
   Begin VB.TextBox txtAvanceProducido 
      Alignment       =   1  'Right Justify
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
      Height          =   315
      Left            =   1920
      TabIndex        =   8
      Top             =   840
      Width           =   495
   End
   Begin VB.TextBox txtCantidadProducida 
      Alignment       =   1  'Right Justify
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
      Height          =   315
      Left            =   960
      TabIndex        =   7
      Top             =   840
      Width           =   855
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Copiar Orden de produccion"
      Height          =   465
      Index           =   4
      Left            =   1680
      TabIndex        =   32
      Top             =   8280
      Width           =   1215
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Ord. de Compra pendientes"
      Height          =   465
      Index           =   7
      Left            =   120
      TabIndex        =   31
      Top             =   8280
      Width           =   1455
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
      Left            =   4440
      TabIndex        =   1
      Top             =   120
      Width           =   1545
   End
   Begin VB.TextBox txtBusca 
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
      Left            =   10800
      TabIndex        =   6
      Top             =   480
      Visible         =   0   'False
      Width           =   1905
   End
   Begin VB.TextBox txtCodigoCliente 
      Alignment       =   1  'Right Justify
      Height          =   315
      Left            =   8280
      TabIndex        =   9
      Top             =   840
      Width           =   795
   End
   Begin VB.TextBox txtCantidad 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   960
      TabIndex        =   3
      Top             =   480
      Width           =   870
   End
   Begin Controles1013.DbListView ListaProcesos 
      Height          =   2055
      Left            =   120
      TabIndex        =   30
      Top             =   6120
      Width           =   12600
      _ExtentX        =   22225
      _ExtentY        =   3625
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   0
      MouseIcon       =   "frmProduccionOrden.frx":076A
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView Lista 
      Height          =   2895
      Left            =   120
      TabIndex        =   29
      Top             =   3000
      Width           =   12600
      _ExtentX        =   22225
      _ExtentY        =   5106
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   0
      MouseIcon       =   "frmProduccionOrden.frx":0786
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Anular"
      Height          =   465
      Index           =   3
      Left            =   11520
      TabIndex        =   37
      Top             =   8280
      Width           =   1095
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   465
      Index           =   1
      Left            =   10920
      Picture         =   "frmProduccionOrden.frx":07A2
      Style           =   1  'Graphical
      TabIndex        =   36
      Top             =   8280
      Width           =   525
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   0
      Left            =   11040
      TabIndex        =   22
      Top             =   1440
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   1
      Left            =   11280
      TabIndex        =   23
      Top             =   1440
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   2
      Left            =   11520
      TabIndex        =   24
      Top             =   1440
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   3
      Left            =   11760
      TabIndex        =   25
      Top             =   1440
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   4
      Left            =   12000
      TabIndex        =   26
      Top             =   1440
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   5
      Left            =   12240
      TabIndex        =   27
      Top             =   1440
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   6
      Left            =   12480
      TabIndex        =   28
      Top             =   1440
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.TextBox txtNumeroProduccionOrden 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroOrdenProduccion"
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
      Left            =   960
      TabIndex        =   0
      Top             =   120
      Width           =   1530
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   465
      Index           =   0
      Left            =   7920
      TabIndex        =   33
      Top             =   8280
      Width           =   1110
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   465
      Index           =   1
      Left            =   9120
      TabIndex        =   34
      Top             =   8280
      Width           =   1110
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   465
      Index           =   0
      Left            =   10320
      Picture         =   "frmProduccionOrden.frx":0D2C
      Style           =   1  'Graphical
      TabIndex        =   35
      Top             =   8280
      UseMaskColor    =   -1  'True
      Visible         =   0   'False
      Width           =   525
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   450
      Left            =   6840
      TabIndex        =   19
      Top             =   2400
      Width           =   5895
      _ExtentX        =   10398
      _ExtentY        =   794
      _Version        =   393217
      BorderStyle     =   0
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmProduccionOrden.frx":1396
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   38
      Top             =   8610
      Visible         =   0   'False
      Width           =   12885
      _ExtentX        =   22728
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaOrdenProduccion"
      Height          =   330
      Index           =   0
      Left            =   960
      TabIndex        =   11
      Top             =   1320
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   57540609
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Aprobo"
      Height          =   315
      Index           =   1
      Left            =   6840
      TabIndex        =   13
      Tag             =   "Empleados"
      Top             =   1680
      Width           =   2445
      _ExtentX        =   4313
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Emitio"
      Height          =   315
      Index           =   4
      Left            =   6840
      TabIndex        =   12
      Tag             =   "Empleados"
      Top             =   1320
      Width           =   2445
      _ExtentX        =   4313
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   7200
      Top             =   8640
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
            Picture         =   "frmProduccionOrden.frx":1418
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProduccionOrden.frx":152A
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProduccionOrden.frx":197C
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProduccionOrden.frx":1DCE
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   20
      Left            =   1920
      TabIndex        =   4
      Tag             =   "Unidades"
      Top             =   480
      Width           =   1545
      _ExtentX        =   2725
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaInicioReal"
      Height          =   330
      Index           =   1
      Left            =   2520
      TabIndex        =   16
      Top             =   1920
      Width           =   1485
      _ExtentX        =   2619
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      DateIsNull      =   -1  'True
      Format          =   57540609
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaInicioPrevista"
      Height          =   330
      Index           =   2
      Left            =   960
      TabIndex        =   15
      Top             =   1920
      Width           =   1485
      _ExtentX        =   2619
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   57540609
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaFinalPrevista"
      Height          =   330
      Index           =   3
      Left            =   960
      TabIndex        =   17
      Top             =   2280
      Width           =   1485
      _ExtentX        =   2619
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   57540609
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaFinalReal"
      Height          =   330
      Index           =   4
      Left            =   2520
      TabIndex        =   18
      Top             =   2280
      Width           =   1485
      _ExtentX        =   2619
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      DateIsNull      =   -1  'True
      Format          =   57540609
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Cliente"
      Height          =   315
      Index           =   9
      Left            =   9120
      TabIndex        =   10
      Tag             =   "Clientes"
      Top             =   840
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdArticuloGenerado"
      Height          =   315
      Index           =   11
      Left            =   6120
      TabIndex        =   2
      Tag             =   "Articulos"
      Top             =   120
      Width           =   6615
      _ExtentX        =   11668
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "idColor"
      Height          =   315
      Index           =   13
      Left            =   4440
      TabIndex        =   5
      Tag             =   "Colores"
      Top             =   480
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdColor"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Cerro"
      Height          =   315
      Index           =   15
      Left            =   6840
      TabIndex        =   14
      Tag             =   "Empleados"
      Top             =   2040
      Width           =   2445
      _ExtentX        =   4313
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjuntos:"
      Height          =   225
      Index           =   0
      Left            =   9840
      TabIndex        =   60
      Top             =   1800
      Width           =   615
   End
   Begin VB.Line Line1 
      X1              =   120
      X2              =   12720
      Y1              =   1200
      Y2              =   1200
   End
   Begin VB.Label lblLabels 
      Caption         =   "Producido"
      Height          =   255
      Index           =   2
      Left            =   120
      TabIndex        =   59
      Top             =   960
      Width           =   735
   End
   Begin VB.Label lblEstado 
      AutoSize        =   -1  'True
      Caption         =   "Estado :"
      Height          =   255
      Index           =   11
      Left            =   3720
      TabIndex        =   58
      Top             =   960
      Width           =   570
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   10
      Left            =   3720
      TabIndex        =   57
      Top             =   240
      Width           =   615
   End
   Begin VB.Label lblLabels 
      Caption         =   "Buscar :"
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
      Index           =   9
      Left            =   9720
      TabIndex        =   56
      Top             =   600
      Visible         =   0   'False
      Width           =   870
   End
   Begin VB.Label lblData 
      Caption         =   "Cerrado por :"
      Height          =   255
      Index           =   19
      Left            =   5640
      TabIndex        =   55
      Top             =   2160
      Width           =   1620
   End
   Begin VB.Label lblColor 
      Caption         =   "Color"
      Height          =   255
      Index           =   2
      Left            =   3720
      TabIndex        =   54
      Top             =   600
      Width           =   615
   End
   Begin VB.Label lblLabels 
      Caption         =   "Procesos:"
      Height          =   210
      Index           =   8
      Left            =   120
      TabIndex        =   53
      Top             =   5880
      Width           =   1545
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cliente:"
      Height          =   255
      Index           =   6
      Left            =   7560
      TabIndex        =   52
      Top             =   960
      Width           =   1755
   End
   Begin VB.Label lblPrevisto 
      AutoSize        =   -1  'True
      Caption         =   "Previsto"
      Height          =   255
      Index           =   1
      Left            =   960
      TabIndex        =   51
      Top             =   1680
      Width           =   1050
   End
   Begin VB.Label lblReal 
      AutoSize        =   -1  'True
      Caption         =   "Real"
      Height          =   255
      Index           =   0
      Left            =   2520
      TabIndex        =   50
      Top             =   1680
      Width           =   1050
   End
   Begin VB.Label lblFinalPrevisto 
      AutoSize        =   -1  'True
      Caption         =   "Final"
      Height          =   255
      Index           =   1
      Left            =   120
      TabIndex        =   49
      Top             =   2400
      Width           =   330
   End
   Begin VB.Label lblInicioPrevisto 
      AutoSize        =   -1  'True
      Caption         =   "Inicio"
      Height          =   255
      Index           =   6
      Left            =   120
      TabIndex        =   48
      Top             =   2040
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   255
      Index           =   7
      Left            =   120
      TabIndex        =   47
      Top             =   600
      Width           =   975
   End
   Begin VB.Label lblEstado1 
      Caption         =   "PROGRAMADA"
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
      Left            =   4440
      TabIndex        =   46
      Top             =   840
      Width           =   2415
   End
   Begin VB.Label lblLabels 
      Caption         =   "Materiales/Mano de Obra:"
      Height          =   210
      Index           =   16
      Left            =   120
      TabIndex        =   45
      Top             =   2760
      Width           =   1905
   End
   Begin VB.Label lblData 
      Caption         =   "Emitido por : "
      Height          =   255
      Index           =   4
      Left            =   5640
      TabIndex        =   44
      Top             =   1440
      Width           =   1620
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Autorizaciones : "
      Height          =   255
      Index           =   1
      Left            =   9840
      TabIndex        =   43
      Top             =   1440
      Width           =   1200
   End
   Begin VB.Label lblData 
      Caption         =   "Liberado por :"
      Height          =   255
      Index           =   1
      Left            =   5640
      TabIndex        =   42
      Top             =   1800
      Width           =   1620
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Nro. :"
      Height          =   240
      Index           =   14
      Left            =   120
      TabIndex        =   41
      Top             =   240
      Width           =   360
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   255
      Index           =   4
      Left            =   120
      TabIndex        =   40
      Top             =   1440
      Width           =   570
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   255
      Index           =   0
      Left            =   5640
      TabIndex        =   39
      Top             =   2520
      Width           =   1620
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
         Caption         =   "Duplicar"
         Index           =   3
         Visible         =   0   'False
      End
   End
   Begin VB.Menu MnuDetProc 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetProcA 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetProcA 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetProcA 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
End
Attribute VB_Name = "frmProduccionOrden"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public WithEvents origen As ComPronto.ProduccionOrden
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm

Private mTipoSalida As Integer, mOk As Integer, mvarIdMonedaPesos As Integer

Public mvarId As Long

Private mIdAprobo As Long, mvarIdUnidadCU As Long, mvarIdDepositoCentral As Long

Private mvarGrabado As Boolean, mvarModoCodigoBarra As Boolean, mvarSoloStockObra As Boolean

Private mvarImpresionHabilitada As Boolean, mvarNumerarPorPuntoVenta As Boolean

Private mvarTransportistaConEquipos As Boolean, mvarNoAnular As Boolean

Private mvarAnulada As String, mOpcionesAcceso As String, mCadena As String

Private mvarExigirEquipoDestino As String, mDescargaPorKit As String

Private mNivelAcceso As Integer

Private mvarPathAdjuntos As String

Private BoundText(40) As String 'para safar del clasico "Insufficent Memory"   http://support.microsoft.com/?scid=kb%3Ben-us%3B257947&x=7&y=17

Private ultimaCantidad As Currency

'combos
Const dcf_ARTICULOPRODUCIDO = 11
Const dcf_COLORPRODUCIDO = 13
Const dcf_UNIDAD = 20
Const dcf_CLIENTE = 9

'columnas de la grilla de articulos
Const ACOL_CODART = 1
Const ACOL_DESCART = 2
Const ACOL_PARTIDA = 4
Const ACOL_CANT = 5
Const ACOL_AVANCE = 6
Const ACOL_PORCENTAVANCE = 7
Const ACOL_UNI = 8
Const ACOL_UBIC = 9
Const ACOL_PROCESO = 10
Const ACOL_TOLERANCIA = 11
Const ACOL_COLOR = 3

'columnas de la grilla de proceso (TO DO)
Const PCOL_1 = 1
Const PCOL_2 = 2
Const PCOL_DESCPROCESO = 3
Const PCOL_HORAS = 4
Const PCOL_AVANCE = 5
Const PCOL_PORCENTAVANCE = 6
Const PCOL_7 = 7
Const PCOL_MAQUINA = 8
Const PCOL_9 = 9
Const PCOL_10 = 10
Const PCOL_11 = 11

'http://vbnet.mvps.org/index.html?code/comctl/lvcolumnautosize.htm
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Copyright ©1996-2009 VBnet, Randy Birch, All Rights Reserved.
' Some pages may also contain other copyrights by the author.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Distribution: You can freely use this code in your own
'               applications, but you may not reproduce
'               or publish this code on any web site,
'               online service, or distribute as source
'               on any media without express permission.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Private Const LVM_FIRST As Long = &H1000

Private Const LVM_SETCOLUMNWIDTH As Long = (LVM_FIRST + 30)

Private Const LVSCW_AUTOSIZE As Long = -1

Private Const LVSCW_AUTOSIZE_USEHEADER As Long = -2
    
Private Declare Function SendMessage _
                Lib "USER32" _
                Alias "SendMessageA" (ByVal hwnd As Long, _
                                      ByVal wMsg As Long, _
                                      ByVal wParam As Long, _
                                      lParam As Any) As Long

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

Sub Editar(ByVal Cual As Long, _
           Optional Modo As Integer = vbModal)

    '   If Cual = -1 And mTipoSalida = 0 Then
    '      MsgBox "Solo puede agregar items por arrastre desde los vales pendientes!", vbCritical
    '      Exit Sub
    '   End If
   
    '   If Cual > 0 Then
    '      MsgBox "No puede modificar una ProduccionOrden ya registrada, eliminela.", vbCritical
    '      Exit Sub
    '   End If
   
    'If IsNull(origen.Registro.Fields("IdObra").Value) And Combo1(0).ListIndex <> 2 Then
    '   MsgBox "Antes de ingresar los detalles debe definir la obra", vbCritical
    '   Exit Sub
    'End If
   
    Dim oF As frmDetProduccionOrden
   
    Set oF = New frmDetProduccionOrden
   
    With oF
        Set .ProduccionOrden = origen
        .Id = Cual
        .TipoSalida = mTipoSalida
        .Show Modo, Me
    End With

    PostmodalEditar oF, Cual
End Sub

Sub PostmodalEditar(oF As frmDetProduccionOrden, _
                    ByVal Cual As Long)
    Dim oL As ListItem

    With oF

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

                .SubItems(ACOL_CODART) = oF.txtCodigoArticulo.Text
                .SubItems(ACOL_DESCART) = oF.DataCombo1(1).Text
                .SubItems(ACOL_PARTIDA) = "" & oF.txtPartida.Text
                .SubItems(ACOL_CANT) = "" & oF.txtCantidad.Text

                'el 5 es el avance
                'el 6 es el porcentaje?
                If Val(.SubItems(ACOL_CANT)) <> 0 Then
                    .SubItems(ACOL_PORCENTAVANCE) = CInt(100 / .SubItems(ACOL_CANT) * Val(.SubItems(ACOL_AVANCE))) & "%"
                End If

                .SubItems(ACOL_UNI) = "" & oF.DataCombo1(0).Text
                .SubItems(ACOL_UBIC) = "" & oF.DataCombo1(2).Text
                .SubItems(ACOL_PROCESO) = "" & oF.DataCombo1(7).Text
                .SubItems(ACOL_COLOR) = "" & oF.DataCombo1(13).Text
                .SubItems(ACOL_TOLERANCIA) = "" & oF.txtTolerancia.Text
         
            End With

        End If

        Unload oF
        Set oF = Nothing
   
        mvarNoAnular = True

    End With

End Sub

Sub PostmodalEditarProceso(oF As frmDetProduccionOrdenProceso, _
                           ByVal Cual As Long)
    Dim oL As ListItem

    With oF

        If .Aceptado Then
            If Cual = -1 Then
                Set oL = ListaProcesos.ListItems.Add
                oL.Tag = .IdNuevo
            Else
                Set oL = ListaProcesos.SelectedItem
            End If

            With oL

                If Cual = -1 Then
                    '.SmallIcon = "Nuevo"
                Else
                    '.SmallIcon = "Modificado"
                End If

                .SubItems(PCOL_DESCPROCESO) = oF.DataCombo1(1).Text
                .SubItems(PCOL_HORAS) = "" & oF.txtCantidad.Text

                If Val(.SubItems(PCOL_HORAS)) <> 0 Then
                    .SubItems(PCOL_PORCENTAVANCE) = Int(100 / Val(.SubItems(PCOL_HORAS)) * Val(.SubItems(PCOL_AVANCE))) & "%"
                End If

                .SubItems(PCOL_MAQUINA) = oF.DataCombo1(0).Text
            End With

        End If

        Unload oF
        Set oF = Nothing
       
        mvarNoAnular = True
    End With

End Sub

Sub EditarProcesos(ByVal Cual As Long)

    '   If Cual = -1 And mTipoSalida = 0 Then
    '      MsgBox "Solo puede agregar items por arrastre desde los vales pendientes!", vbCritical
    '      Exit Sub
    '   End If
   
    '   If Cual > 0 Then
    '      MsgBox "No puede modificar una ProduccionOrden ya registrada, eliminela.", vbCritical
    '      Exit Sub
    '   End If
   
    'If IsNull(origen.Registro.Fields("IdObra").Value) And Combo1(0).ListIndex <> 2 Then
    '   MsgBox "Antes de ingresar los detalles debe definir la obra", vbCritical
    '   Exit Sub
    'End If
   
    Dim oF As frmDetProduccionOrdenProceso
    Dim oL As ListItem
   
    Set oF = New frmDetProduccionOrdenProceso
   
    With oF
        Set .ProduccionOrden = origen
        '      If dcfields(14).Visible And IsNumeric(dcfields(14).BoundText) Then
        '         .IdDepositoOrigen = dcfields(14).BoundText
        '      Else
        '         .IdDepositoOrigen = 0
        '      End If
        .Id = Cual
        '      .TipoSalida = mTipoSalida
        .Show vbModal, Me
    End With

    PostmodalEditarProceso oF, Cual
End Sub

Sub Acepta()

    If Not IsNumeric(dcfields(dcf_COLORPRODUCIDO).BoundText) Then
        MsgBox "Falta el color"
        Exit Sub
    End If
         
    If Lista.ListItems.Count = 0 Then
        MsgBox "No se puede almacenar una orden de producción sin detalles"
        Exit Sub
    End If
         
    Dim dc As DataCombo
    Dim dtp As DTPicker
    Dim est As EnumAcciones
    Dim oRsDet As ADOR.Recordset
    Dim oRsStk As ADOR.Recordset
    Dim oRsAux As ADOR.Recordset
    Dim mvarCantidad As Double, mvarCantidadAdicional As Double
    Dim mvarCantidadUnidades As Double, mvarStock As Double, mvarStock1 As Double, mvarStock2 As Double
    Dim mvarCantConj As Double
    Dim mvarIdStock As Long, mNum As Long, mvarIdEquipoDestino As Long, mvarIdTipoRosca As Long
    Dim mvarNumero As Long, mvarNumeroAnt As Long
    Dim mvarImprime As Integer
    Dim mvarAux1 As String, mvarAux2 As String, mvarAux3 As String, mvarAux4 As String, mvarAux5 As String
    Dim mvarParaMantenimiento As String, mvarBasePRONTOMantenimiento As String, mvarError As String
    Dim mvarArticulo1 As String, mvarArticulo As String, mvarDestino As String, mvarFamilia As String
    Dim mvarRegistrarStock As Boolean
    Dim oPar As ComPronto.Parametro
         
    mvarNumeroAnt = Val(txtNumeroProduccionOrden.Text)
         
    For Each dtp In DTFields
        origen.Registro.Fields(dtp.DataField).Value = dtp.Value
    Next
         
    RecalculaProporciones
         
    For Each dc In dcfields

        If dc.Tag <> "Clientes" And dc.Tag <> "Colores" And dc.Tag <> "Ficha" And dc.Tag <> "Compra" And dc.Index <> 12 And dc.Index <> 16 Then
            If dc.Enabled And dc.Visible Then
                If Not IsNumeric(dc.BoundText) And dc.Index <> 1 And dc.Index <> 2 And dc.Index <> 3 And dc.Index <> 7 And dc.Index <> 8 And dc.Index <> 4 And dc.Index <> 15 Then
                    MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                    Exit Sub
                End If

                If IsNumeric(dc.BoundText) Then
                    origen.Registro.Fields(dc.DataField).Value = dc.BoundText
                End If
            End If
        End If

    Next
         
    If Not IsNumeric(txtCantidad) Then
        MsgBox "Debe ingresar la cantidad", vbExclamation
        Exit Sub
    End If

    origen.Registro!IdColor = dcfields(dcf_COLORPRODUCIDO).BoundText
            
    origen.Registro!Cantidad = txtCantidad
         
    If (IsNumeric(dcfields(15).BoundText)) And (origen.Registro!Confirmado = "SI") And (Not origen.Registro!Cerro = "SI") Then
            
        '////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////
        Dim s As String
        s = ""
            
        Dim xrs As ADOR.Recordset
        Set xrs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_TienePartesAbiertosAsociados", origen.Registro!IdProduccionOrden)

        If xrs.RecordCount > 0 Then
            s = s & "La Orden no puede cerrarse porque tiene partes abiertos (parte n°" & xrs!idProduccionParte & ")" & vbCrLf
            'ProduccionWrapper.CerrarPartesDeLaOP
        End If
            
        '////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////
        Dim oOF As ComPronto.ProduccionOrden
        Set oOF = AplicacionProd.ProduccionOrdenes.Item(origen.Registro.Fields("IdProduccionOrden").Value)
        Dim rs As ADOR.Recordset
        Set rs = oOF.DetProduccionOrdenesProcesos.TraerTodos
             
        'ahora me fijo si los procesos anteriores estan cumplidos
        Do While Not rs.EOF
                              
            Dim oOFproceso As ComPronto.DetProdOrdenProceso
            Set oOFproceso = oOF.DetProduccionOrdenesProcesos.Item(rs!IdDetalleProduccionOrdenProceso)

            With oOFproceso.Registro

                If IsNull(!IdProduccionParteQueCerroEsteProceso) Then
                    s = s & "El proceso " & NombreProceso(!IdProduccionProceso) & " no está cerrado" & vbCrLf
                End If

            End With
                 
            rs.MoveNext
        Loop
               
        'Set yRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_TieneProcesosObligatoriosSinCumplir", origen.Registro!IdProduccionOrden)
        'If yRs.RecordCount > 0 Then
        '   MsgBox "La Orden no puede cerrarse porque tiene procesos obligatorios sin cumplir (" & yRs!descripcion & ")", vbExclamation
        '   Exit Sub
        'End If
        If s <> "" Then
            Dim mvar
            mvar = MsgBox(s & vbCrLf & "Desea forzar el cierre?", vbYesNo)

            If mvar = vbYes Then

                ForzarCierrePartesYProcesos AplicacionProd, origen
            Else
                Exit Sub
            End If
        End If
    End If
         
    mvarAux1 = BuscarClaveINI("Inhabilitar ubicaciones en movimientos de stock")
    mvarAux2 = BuscarClaveINI("Inhabilitar stock negativo")
    mvarAux3 = BuscarClaveINI("Controlar existencia de parte diario en salida de materiales")
    mvarAux4 = BuscarClaveINI("Controlar salidas contra lista de materiales")
    mvarAux5 = BuscarClaveINI("Inhabilitar stock global negativo")
    mvarError = ""
    '         If Not IsNull(origen.Registro.Fields("Aprobo").Value) Then
    Set oRsDet = origen.DetProduccionOrdenes.Registros

    If oRsDet.RecordCount > 0 Then

        With oRsDet
            .MoveFirst

            Do While Not .EOF

                If Not .Fields("Eliminado").Value Then
                    'If IsNull(.Fields("IdArticulo").Value) Then
                    '   Set oRsDet = Nothing
                    '   MsgBox "Articulo no definido!", vbExclamation
                    '   Exit Sub
                    'End If
                    'If IsNull(.Fields("IdUnidad").Value) Then
                    '   Set oRsDet = Nothing
                    '   MsgBox "Unidad de medida no definida!", vbExclamation
                    '   Exit Sub
                    'End If
                    'If IsNull(.Fields("IdUbicacion").Value) And mvarAux1 <> "SI" Then
                    '   Set oRsDet = Nothing
                    '   MsgBox "Ubicacion no definida en detalle!", vbExclamation
                    '   Exit Sub
                    'End If
                    'If IsNull(.Fields("Partida").Value) Then
                    '   Set oRsDet = Nothing
                    '   MsgBox "Partida no definida!", vbExclamation
                    '   Exit Sub
                    'End If
                        
                    mvarParaMantenimiento = "NO"
                    mvarArticulo = ""
                    mvarIdTipoRosca = 0
                    mvarRegistrarStock = True
                    Set oRsStk = Aplicacion.Articulos.TraerFiltrado("_PorId", .Fields("IdArticulo").Value)

                    If oRsStk.RecordCount > 0 Then
                        mvarParaMantenimiento = IIf(IsNull(oRsStk.Fields("ParaMantenimiento").Value), "NO", oRsStk.Fields("ParaMantenimiento").Value)
                        mvarArticulo = IIf(IsNull(oRsStk.Fields("Codigo").Value), "", oRsStk.Fields("Codigo").Value)
                        mvarIdTipoRosca = IIf(IsNull(oRsStk.Fields("IdTipoRosca").Value), 0, oRsStk.Fields("IdTipoRosca").Value)

                        If Not IsNull(oRsStk.Fields("RegistrarStock").Value) And oRsStk.Fields("RegistrarStock").Value = "NO" Then
                            mvarRegistrarStock = False
                        End If
                    End If

                    oRsStk.Close
                    Set oRsStk = Nothing

                    'If (mvarExigirEquipoDestino = "SI" Or mvarParaMantenimiento = "SI") Then
                    If Not IsNull(.Fields("IdEquipoDestino").Value) Then
                        mvarIdEquipoDestino = IIf(IsNull(.Fields("IdEquipoDestino").Value), 0, .Fields("IdEquipoDestino").Value)
                        Set oRsStk = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorId", Array(mvarIdEquipoDestino, origen.Registro.Fields("IdObra").Value))

                        If oRsStk.RecordCount = 0 Then
                            oRsStk.Close
                            Set oRsStk = Nothing
                            Set oRsDet = Nothing
                            MsgBox "Equipo destino inexistente en la obra " & dcfields(0).Text, vbExclamation
                            Exit Sub
                        End If

                        oRsStk.Close
                        Set oRsStk = Nothing
                    End If
                        
                    If Len(mvarBasePRONTOMantenimiento) > 0 And mvarIdTipoRosca = 0 And IIf(IsNull(.Fields("IdEquipoDestino").Value), 0, .Fields("IdEquipoDestino").Value) <> 0 Then
                        MsgBox "El articulo " & mvarArticulo & " tiene asignado un equipo destino y no tiene familia" & vbCrLf & "(La familia contiene los articulos equivalentes en Pronto Mantenimiento" & vbCrLf & " para que el sistema genere automaticamente un consumo directo)", vbExclamation
                        Exit Sub
                    End If
                        
                    If mvarRegistrarStock And (mvarAux2 = "SI" Or mvarAux5 = "SI") Then
                        mvarCantidadUnidades = IIf(IsNull(.Fields("Cantidad").Value), 0, .Fields("Cantidad").Value)
                        mvarStock1 = 0
                        mvarStock2 = 0

                        If IIf(IsNull(.Fields("DescargaPorKit").Value), "NO", .Fields("DescargaPorKit").Value) = "NO" Then
                            Set oRsStk = Aplicacion.Articulos.TraerFiltrado("_StockPorArticuloPartidaUnidadUbicacionObra", Array(.Fields("IdArticulo").Value, IIf(IsNull(.Fields("Partida").Value), "", .Fields("Partida").Value), .Fields("IdUnidad").Value, IIf(IsNull(.Fields("IdUbicacion").Value), 0, .Fields("IdUbicacion").Value), .Fields("IdObra").Value))

                            If oRsStk.RecordCount > 0 Then
                                mvarStock1 = IIf(IsNull(oRsStk.Fields("Stock").Value), 0, oRsStk.Fields("Stock").Value)
                                mvarArticulo = IIf(IsNull(oRsStk.Fields("Articulo").Value), "", oRsStk.Fields("Articulo").Value)
                            End If

                            oRsStk.Close
                            Set oRsStk = Aplicacion.Articulos.TraerFiltrado("_StockTotalPorArticulo", .Fields("IdArticulo").Value)

                            If oRsStk.RecordCount > 0 Then
                                mvarStock2 = IIf(IsNull(oRsStk.Fields("Stock").Value), 0, oRsStk.Fields("Stock").Value)
                            End If

                            oRsStk.Close
                            Set oRsStk = Nothing

                            If mvarId < 0 Then
                                If mvarAux5 <> "SI" And mvarStock1 < mvarCantidadUnidades Then
                                    Set oRsDet = Nothing
                                    MsgBox "El articulo " & mvarArticulo & ", tiene" & vbCrLf & "stock insuficiente segun datos ingresados :" & vbCrLf & "cantidad actual en stock para la partida, unidad, ubicacion y obra : " & mvarStock1 & vbCrLf & "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
                                    Exit Sub
                                End If

                                If mvarStock2 < mvarCantidadUnidades Then
                                    Set oRsDet = Nothing
                                    MsgBox "El articulo " & mvarArticulo & ", tiene stock insuficiente" & vbCrLf & "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
                                    Exit Sub
                                End If

                            Else
                                Set oRsStk = Aplicacion.TablasGenerales.TraerUno("DetProduccionOrdenes", .Fields(0).Value)
                                mvarStock = 0

                                If oRsStk.RecordCount > 0 Then
                                    mvarStock = IIf(IsNull(oRsStk.Fields("Cantidad").Value), 0, oRsStk.Fields("Cantidad").Value)
                                End If

                                oRsStk.Close
                                Set oRsStk = Nothing

                                If mvarAux5 <> "SI" And mvarStock1 < mvarCantidadUnidades - mvarStock Then
                                    Set oRsDet = Nothing
                                    MsgBox "El articulo " & mvarArticulo & ", tiene" & vbCrLf & "stock insuficiente segun datos ingresados :" & vbCrLf & "cantidad actual en stock para la partida, unidad, ubicacion y obra : " & mvarStock1 & vbCrLf & "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
                                    Exit Sub
                                End If

                                If mvarStock2 < mvarCantidadUnidades - mvarStock Then
                                    Set oRsDet = Nothing
                                    MsgBox "El articulo " & mvarArticulo & ", tiene stock insuficiente" & vbCrLf & "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
                                    Exit Sub
                                End If
                            End If

                        Else
                            Set oRsAux = Aplicacion.Conjuntos.TraerFiltrado("_DetallesPorIdArticulo", .Fields("IdArticulo").Value)

                            If oRsAux.RecordCount > 0 Then
                                oRsAux.MoveFirst

                                Do While Not oRsAux.EOF
                                    mvarCantConj = IIf(IsNull(oRsAux.Fields("Cantidad").Value), 0, oRsAux.Fields("Cantidad").Value)
                                    Set oRsStk = Aplicacion.Articulos.TraerFiltrado("_StockTotalPorArticulo", oRsAux.Fields("IdArticulo").Value)
                                    mvarStock = 0
                                    mvarArticulo1 = ""

                                    If oRsStk.RecordCount > 0 Then
                                        mvarStock = IIf(IsNull(oRsStk.Fields("Stock").Value), 0, oRsStk.Fields("Stock").Value)
                                        mvarArticulo1 = IIf(IsNull(oRsStk.Fields("Articulo").Value), "", oRsStk.Fields("Articulo").Value)
                                    End If

                                    oRsStk.Close

                                    If mvarId < 0 Then
                                        If mvarStock < mvarCantidadUnidades * mvarCantConj Then
                                            Set oRsAux = Nothing
                                            Set oRsStk = Nothing
                                            Set oRsDet = Nothing
                                            MsgBox "El articulo " & mvarArticulo1 & vbCrLf & "que es parte del kit " & mvarArticulo & vbCrLf & "dejaria el stock negativo, reingrese", vbExclamation
                                            Exit Sub
                                        End If

                                    Else
                                        Set oRsStk = Aplicacion.TablasGenerales.TraerUno("DetProduccionOrdenes", .Fields(0).Value)
                                        mvarStock1 = 0

                                        If oRsStk.RecordCount > 0 Then
                                            mvarStock1 = IIf(IsNull(oRsStk.Fields("Cantidad").Value), 0, oRsStk.Fields("Cantidad").Value)
                                        End If

                                        oRsStk.Close

                                        If mvarStock < (mvarCantidadUnidades * mvarCantConj) - (mvarStock1 * mvarCantConj) Then
                                            Set oRsAux = Nothing
                                            Set oRsStk = Nothing
                                            Set oRsDet = Nothing
                                            MsgBox "El articulo " & mvarArticulo1 & vbCrLf & "que es parte del kit " & mvarArticulo & vbCrLf & "dejaria el stock negativo, reingrese", vbExclamation
                                            Exit Sub
                                        End If
                                    End If

                                    oRsAux.MoveNext
                                Loop

                            End If

                            oRsAux.Close
                        End If
                    End If
                        
                    If mvarAux3 = "SI" And Not IsNull(.Fields("IdEquipoDestino").Value) Then
                        Set oRsStk = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_ControlarParteDiarioEquipoDestino", Array(.Fields("IdEquipoDestino").Value, DTFields(0).Value))

                        If oRsStk.RecordCount = 0 Then
                            oRsStk.Close
                            Set oRsStk = Nothing
                            Set oRsDet = Nothing
                            MsgBox "Hay equipo(s) destino que no tienen parte del dia " & DTFields(0).Value - 1 & vbCrLf & "en el Pronto Mantenimiento", vbExclamation
                            Exit Sub
                        End If

                        oRsStk.Close
                    End If
                     
                    If mvarAux4 = "SI" And mTipoSalida = 1 And Not IsNull(.Fields("IdDetalleObraDestino").Value) Then
                        mvarCantidadUnidades = IIf(IsNull(.Fields("Cantidad").Value), 0, .Fields("Cantidad").Value)
                        mvarStock1 = 0
                        mvarStock2 = 0
                        mvarDestino = ""
                        mvarFamilia = ""
                        Set oRsStk = Aplicacion.LMateriales.TraerFiltrado("_CantidadPorDestinoArticulo", Array(.Fields("IdDetalleObraDestino").Value, .Fields("IdArticulo").Value, .Fields(0).Value))

                        If oRsStk.RecordCount > 0 Then
                            mvarStock1 = IIf(IsNull(oRsStk.Fields("CantidadLM").Value), 0, oRsStk.Fields("CantidadLM").Value)
                            mvarStock2 = IIf(IsNull(oRsStk.Fields("CantidadSM").Value), 0, oRsStk.Fields("CantidadSM").Value)
                            mvarDestino = IIf(IsNull(oRsStk.Fields("Destino").Value), "", oRsStk.Fields("Destino").Value)
                            mvarFamilia = IIf(IsNull(oRsStk.Fields("Familia").Value), "", oRsStk.Fields("Familia").Value)
                        End If

                        oRsStk.Close
                        Set oRsStk = Nothing

                        If mvarCantidadUnidades + mvarStock2 > mvarStock1 And mvarStock1 <> 0 Then
                            mvarError = mvarError & vbCrLf & "Articulo " & mvarArticulo & " Destino " & mvarDestino & ", " & "Lista de materiales : " & mvarStock1 & ", " & "Salidas : " & mvarStock2 & ", " & "Disponible : " & mvarStock1 - mvarStock2

                            If Len(mvarFamilia) > 0 Then mvarError = mvarError & ", " & "Familia : " & mvarFamilia
                        End If
                    End If
                End If

                .MoveNext
            Loop

        End With

    End If

    Set oRsDet = Nothing
    Set oRsAux = Nothing
    Set oRsStk = Nothing
    '         End If
         
    If Len(mvarError) > 0 Then
        MsgBox "Se han detectado los siguientes errores : " & mvarError, vbExclamation
        Exit Sub
    End If
         
    With origen.Registro
            
        'If Not IsNull(.Fields("IdObra").Value) Then
        '   '.Fields("Cliente").Value = txtCliente.Text
        '   .Fields("Direccion").Value = txtDireccion.Text
        '   .Fields("Localidad").Value = txtLocalidad.Text
        '   .Fields("CodigoPostal").Value = txtCodigoPostal.Text
        '   .Fields("CondicionIva").Value = txtCondicionIva.Text
        '   .Fields("Cuit").Value = txtCuit.Text
        'ElseIf Not IsNull(.Fields("IdProveedor").Value) Then
        '  .Fields("Cliente").Value = Null
        '  .Fields("Direccion").Value = txtDireccion.Text
        '  .Fields("Localidad").Value = txtLocalidad.Text
        '  .Fields("CodigoPostal").Value = txtCodigoPostal.Text
        '  .Fields("CondicionIva").Value = txtCondicionIva.Text
        '  .Fields("Cuit").Value = txtCuit.Text
        'End If
        .Fields("Observaciones").Value = rchObservaciones.Text

        If mvarId < 0 Then
            .Fields("IdUsuarioIngreso").Value = glbIdUsuario
            .Fields("FechaIngreso").Value = Now
        Else
            .Fields("IdUsuarioModifico").Value = glbIdUsuario
            .Fields("FechaModifico").Value = Now
        End If

    End With
         
    If mvarId < 0 Then
        '            Set oPar = Aplicacion.Parametros.Item(1)
        '            With oPar.Registro
        '               Select Case Combo1(0).ListIndex
        '                  Case 0, 2
        '                     If .Fields("ProximoNumeroProduccionOrden").Value = origen.Registro.Fields("NumeroProduccionOrden").Value Then
        '                        .Fields("ProximoNumeroProduccionOrden").Value = origen.Registro.Fields("NumeroProduccionOrden").Value + 1
        '                     End If
        '                  Case 1
        '                     If .Fields("ProximoNumeroProduccionOrdenAObra").Value = origen.Registro.Fields("NumeroProduccionOrden").Value Then
        '                        .Fields("ProximoNumeroProduccionOrdenAObra").Value = origen.Registro.Fields("NumeroProduccionOrden").Value + 1
        '                     End If
        ''                  Case 2
        ''                     If .Fields("ProximoNumeroDevolucionDeFabrica").Value = origen.Registro.Fields("NumeroProduccionOrden").Value Then
        ''                        .Fields("ProximoNumeroDevolucionDeFabrica").Value = origen.Registro.Fields("NumeroProduccionOrden").Value + 1
        ''                     End If
        '               End Select
        '            End With
        '            oPar.Guardar
        '            Set oPar = Nothing
        mvarGrabado = True
    End If
         
    If mvarId < 0 Then
        Dim mNumero
        mNumero = TraerValorParametro2("ProximoNumeroProduccionOrden")
        origen.Registro!NumeroOrdenProduccion = mNumero
        GuardarValorParametro2 "ProximoNumeroProduccionOrden", "" & (mNumero + 1)
    End If
         
    Dim i As Integer

    For i = 0 To 1
        origen.Registro.Fields("ArchivoAdjunto" & i + 1).Value = FileBrowser1(i).Text
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
        mvarGrabado = True
            
        Set oRsAux = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_PorId", mvarId)

        If oRsAux.RecordCount > 0 Then
            oRsAux.MoveFirst
            'MARIANO
            'If oRsAux.Fields("NumeroProduccionOrden").Value <> mvarNumeroAnt Then
            '   MsgBox "El numero de salida a cambiado," & vbCrLf & _
                "el numero anterior es el " & Format(mvarNumeroAnt, "00000000") & vbCrLf & _
                "el nuevo numero asignado es el " & Format(oRsAux.Fields("NumeroProduccionOrden").Value, "00000000") & ".", vbInformation
            'End If
        End If

        oRsAux.Close
        Set oRsAux = Nothing
    Else
        est = Modificacion
    End If
         
    If Not actL2 Is Nothing Then

        With actL2
            .ListaEditada = "OrdendeProduccion"
            .AccionRegistro = est
            .Disparador = mvarId
        End With

    End If
         
    'If Combo1(0).ListIndex <> 0 Then
    If mvarImpresionHabilitada Then
        'mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de solicitud de cotizacion")
        'If mvarImprime = vbYes Then
        '   cmdImpre_Click (0)
        'End If
    End If

    'End If
         
    Unload Me

End Sub

Friend Sub cmd_Click(Index As Integer)
    On Error Resume Next
    '   On Error GoTo Mal

    Select Case Index
   
        Case 0
      
            Acepta

        Case 1
      
            Unload Me

        Case 2
         
            Dim oF 'As frmConsultaValesPendientes

            'Set oF = New frmConsultaValesPendientes
            With oF
                .Show vbModal, Me
            End With

            Unload oF
            Set oF = Nothing
      
        Case 3
      
            AnularOrden
            'Unload Me
      
        Case 4
         
            Dim oFOP As frmOPsPendientes
            Set oFOP = New frmOPsPendientes

            With oFOP
                .Id = "Compras"
                '.FiltroArticulo = dcfields(dcf_ARTICULOPRODUCIDO).BoundText
                .Show vbModal, Me
            End With

            PostmodalOPPendientes oFOP
      
        Case 7
            ImputarComprasPendientes
    
    End Select
   
Salida:
    Me.MousePointer = vbNormal
    'Set oRsDet = Nothing
    'Set oRsStk = Nothing
    'Set oPar = Nothing
   
    Exit Sub
   
Mal:

    MsgBox "Se ha producido un problema al tratar de registrar los datos" & vbCrLf & Err.Description, vbCritical
    Resume Salida
   
End Sub

Sub ImputarComprasPendientes()

    'qué hacer en los casos donde no hay ficha de lo que se eligió? -nada (por ahora)
    
    'If Not IsNumeric(dcfields(dcf_ARTICULOPRODUCIDO).BoundText) Then Exit Sub
    Dim rs As ADOR.Recordset
    'Set rs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_CompletoPorArticulo", dcfields(dcf_ARTICULO).BoundText)
    Me.MousePointer = vbHourglass
            
    'Set rs = Aplicacion.OrdenesCompra.TraerFiltrado("_ItemsPendientesDeProducirModuloProduccion", Array(Val(dcfields(dcf_ARTICULOPRODUCIDO).BoundText), 0))
    Set rs = Aplicacion.TablasGenerales.TraerFiltrado("OrdenesCompra", "_ItemsPendientesDeProducirModuloProduccion", Array(Val(dcfields(dcf_ARTICULOPRODUCIDO).BoundText), 0))
            
    If dcfields(dcf_COLORPRODUCIDO).Text <> "" Then
        rs.Filter = "Color='" & dcfields(dcf_COLORPRODUCIDO).Text & "'"
    End If
            
    If rs Is Nothing Then
        MsgBox ("No hay pedidos pendientes de este artículo")
        Exit Sub
    End If

    Dim oL As ListItem
    Dim IdStock
    IdStock = ConsultaSimpleConCheck(rs, oL)
    Me.MousePointer = vbNormal
            
    If IsEmpty(IdStock) Then Exit Sub
    ImputarItemsDePedidosDeClienteALaOrdenDeProduccion IdStock, origen
            
    dcfields(dcf_ARTICULOPRODUCIDO).BoundText = origen.Registro!idArticuloGenerado
    dcfields(dcf_COLORPRODUCIDO).BoundText = origen.Registro!IdColor
            
    'dcfields(dcf_CLIENTE).BoundText = ""
    dcfields(dcf_CLIENTE).Text = ""
    dcfields(dcf_CLIENTE).Text = dcfields(dcf_CLIENTE).Text
    'dcfields(dcf_CLIENTE).BoundText = Val(origen.Registro!Cliente)
    dcfields(dcf_CLIENTE).Text = NombreCliente(Val(origen.Registro!Cliente))
    dcfields(dcf_CLIENTE).Text = dcfields(dcf_CLIENTE).Text
    ' dcfields(dcf_CLIENTE).BoundText = dcfields(dcf_CLIENTE).BoundText
    'dcfields(dcf_CLIENTE).Text = NombreCliente(Val(origen.Registro!Cliente))
            
    'dcfields(dcf_CLIENTE).Text = NombreCliente(Val(origen.Registro!Cliente))
            
    Dim oRsTemp As ADOR.Recordset
    Set oRsTemp = Aplicacion.Clientes.Item(origen.Registro!Cliente).Registro
    txtCodigoCliente.Text = IIf(IsNull(oRsTemp.Fields("Codigo").Value), "", oRsTemp.Fields("Codigo").Value)

    'If oL Is Nothing Then Exit Sub
      
    'para no pedir la ficha 2 veces (despues de poner el articulo y el color)
    Set rs = AplicacionProd.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", Array(dcfields(dcf_ARTICULOPRODUCIDO).BoundText, Val(dcfields(dcf_COLORPRODUCIDO).BoundText)))
    
    If rs.RecordCount > 0 Then
        CargarFicha
    Else
        MsgBox "No hay ficha para esta combinacion de artículo y color"
    End If
            
    txtCantidad = origen.Registro!Cantidad
            
    RecalculaProporciones
            
    dcfields(dcf_CLIENTE).Text = NombreCliente(Val(origen.Registro!Cliente))
    dcfields(dcf_CLIENTE).Text = dcfields(dcf_CLIENTE).Text
    'dcfields(dcf_PARTIDA) = oL.SubItems(5) 'queda enlazado?
    'txtStockActual = oL.SubItems(6)
        
    '            Dim oFOC As frmOCsPendientes
    '            Set oFOC = New frmOCsPendientes
    '
    '            With oFOC
    '                .Id = "Compras"
    '                .FiltroArticulo = dcfields(dcf_ARTICULOPRODUCIDO).BoundText
    '                .Show vbModal, Me
    '            End With
    '
    '            PostmodalOCPendientes oFOC
End Sub

Public Sub PostmodalOPPendientes(oF As frmOPsPendientes)

    Dim oL As ListItem

    With oF
      If oF.IdProduccionOrdenElegida <> "" Then TraerOPyANular (oF.IdProduccionOrdenElegida)
        Set oF = Nothing
    End With

End Sub

Public Sub TraerOPyANular(IdProduccionOrdenElegida As Integer, Optional Cantidad As Double, Optional ClienteElegida)
                
                
            DuplicarOP (IdProduccionOrdenElegida)
                
            'Estudiar la posibilidad que al tomar una OP para abrir una
            'nueva OP, el sistema pregunte si desea Cerrar la OP que está tomando como origen
            
'            If MsgBox("Desea anular la OP original?", vbYesNo) = vbYes Then
'                Dim o As ComPronto.ProduccionOrden
'                Set o = AplicacionProd.ProduccionOrdenes.Item(IdProduccionOrdenElegida)
'
'                With o
'                    .Registro.Fields("Anulada").Value = "SI"
'                    .Guardar
'                End With
'
'                Set o = Nothing
'            End If
'
            
            If glbIdArticuloRet <> 0 Then
                dcfields(20) = glbUniRet
                'txtCantidad = oF.cantidad
                dcfields(dcf_ARTICULOPRODUCIDO) = glbIdArticuloRet
                'dcfields(dcf_COLORPRODUCIDO)= glbIdColorRet 'antes estaba así, probablemente porque me quedaba con el string y no con el ID
                dcfields(dcf_COLORPRODUCIDO).BoundText = glbIdColorRet

                'If Not IsNull(glbClienteRet) Then dcfields(9) = oF.ClienteElegida
        
                'op  o        Toma mal el “color” desde la OC (cli) y desde la OP. Ver, por ejemplo:
                'Pedido de Cliente 15794, tiene color 0003 Base Marrón, y en la OP puso el signo $.
                'Stop
                    
                DTFields(3) = iisEmpty(glbFechaEntrega, Date)
                DTFields(2) = DateAdd("h", -TotalHorasProceso, DTFields(3))

                If DTFields(2) < DTFields(0) Then DTFields(2) = DTFields(0)  'la fecha prevista de inicio no puede ser anterior a la de emision
            End If
         
End Sub


Sub PostmodalOCPendientes(oF As frmOCsPendientes)
    Dim oL As ListItem

    With oF

        If glbIdArticuloRet <> 0 Then
            dcfields(20) = glbUniRet
            txtCantidad = glbCantRet
            dcfields(dcf_ARTICULOPRODUCIDO) = glbIdArticuloRet
            dcfields(dcf_COLORPRODUCIDO).BoundText = glbIdColorRet

            If Not IsNull(glbClienteRet) Then dcfields(9) = glbClienteRet

            CargarFicha
            
            'op  o        Toma mal el “color” desde la OC (cli) y desde la OP. Ver, por ejemplo: Pedido de Cliente 15794, tiene color 0003 Base Marrón, y en la OP puso el signo $.
            
            '·         OPs: verificar funcionamiento “fecha prevista”. Se plantea la alternativa que se
            're-calcule la “Fecha Prevista de Inicio” con cada cambio manual que se haga a la
            '“Fecha Prevista de Entrega”. Ver qué Fecha se está tomando en la OP
            'desde la OC pues al modificarse la Fecha de Entrega en la OC y hacer
            'una OP nueva, la modificación no era tenida en cuenta (es como que la
            'fecha que se toma para la OP no es la de Entrega sino otra de la OC)
            
            DTFields(3) = iisEmpty(glbFechaEntrega, Date)
            DTFields(2) = DateAdd("h", -TotalHorasProceso, DTFields(3))

            If DTFields(2) < DTFields(0) Then DTFields(2) = DTFields(0) 'la fecha prevista de inicio no puede ser anterior a la de emision
        End If
         
        Set oF = Nothing
    End With

End Sub

Function TotalHorasProceso() As Long
    Dim i As Long

    For i = 1 To ListaProcesos.ListItems.Count
        TotalHorasProceso = TotalHorasProceso + CDbl(ListaProcesos.ListItems(i).SubItems(PCOL_HORAS))
    Next i

End Function



Function EstaElProcesoCerrado() As Boolean
'    Dim bFlagInsumoCerrado As Boolean
'    bFlagInsumoCerrado = False
'
'    If SSTab1.TabEnabled(1) Then
'
'        Set rs = oOF.DetProduccionOrdenes.TraerTodos
'
'        Do While Not rs.EOF
'
'            Dim oOFarticulo As ComPronto.DetProduccionOrden
'            Set oOFarticulo = oOF.DetProduccionOrdenes.Item(rs!idDetalleProduccionOrden)
'
'            With oOFarticulo.Registro
'
'                If !IdArticulo = origen.Registro.Fields("IdArticulo").Value And !IdColor = ProduccionModulo.BuscaIdColor(lblColorConsumido) Then
'
'                    !IdProduccionParteQueCerroEsteInsumo = origen.Registro.Fields("IdProduccionParte").Value
'                    oOFarticulo.Modificado = True
'                    bFlagInsumoCerrado = True
'                    Exit Do
'                End If
'
'            End With
'
'            rs.MoveNext
'        Loop
'
'    End If
End Function


Sub RecalcularAvances()
    Dim i As Long
    Dim oL As ListItem

    
    
    
    Dim rs As Recordset
    Set rs = Lista.DataSource
    'rs.Fields.Append "Id_Color", adInteger
    'rs.Open
    'rs.Fields("Id_Color").Value = 10
    'rs.MoveNext
    'rs.Fields("Id_Color").Value = 10
    'rs.MoveNext
    'rs.Fields("Id_Color").Value = 10
    'rs.MoveNext
    'Lista.Refresh






    With Lista

        For i = 1 To .ListItems.Count
            Set oL = .ListItems(i)

            If origen.DetProduccionOrdenes.Item(oL.Tag).Registro!IdProduccionParteQueCerroEsteInsumo > 0 Then
                'como el cierre quizas fue forzoso (antes de la cantidad esperada), indico en que Parte se produjo
                oL.SubItems(ACOL_PORCENTAVANCE) = "LISTO insumo cerrado en Parte n°" & origen.DetProduccionOrdenes.Item(oL.Tag).Registro!IdProduccionParteQueCerroEsteInsumo
                
            ElseIf origen.DetProduccionOrdenes.Item(oL.Tag).Registro!IdProduccionParteQueCerroEsteInsumo > 0 Then
                'como el cierre quizas fue forzoso (antes de la cantidad esperada), indico en que Parte se produjo
                Dim NombreProceso As String
                'NombreProceso=
                oL.SubItems(ACOL_PORCENTAVANCE) = "LISTO proceso " & NombreProceso & " cerrado en Parte n°" & origen.DetProduccionOrdenes.Item(oL.Tag).Registro!IdProduccionParteQueCerroEsteInsumo
            ElseIf Val(oL.SubItems(ACOL_CANT)) <> 0 Then
                oL.SubItems(ACOL_PORCENTAVANCE) = CInt(100 / oL.SubItems(ACOL_CANT) * oL.SubItems(ACOL_AVANCE)) & "%"
            End If

            oL.Checked = True
            oL.ForeColor = vbRed 'KC_VERDE
            oL.Bold = True
            oL.Ghosted = True
              
        Next i

    End With

    With ListaProcesos

        For i = 1 To .ListItems.Count
            Set oL = .ListItems(i)

            If origen.DetProduccionOrdenesProcesos.Item(oL.Tag).Registro!IdProduccionParteQueCerroEsteProceso > 0 Then
                oL.ForeColor = KC_VERDE
                oL.SubItems(PCOL_PORCENTAVANCE) = "LISTO en Parte n°" & origen.DetProduccionOrdenesProcesos.Item(oL.Tag).Registro!IdProduccionParteQueCerroEsteProceso
            ElseIf Val(oL.SubItems(PCOL_HORAS)) <> 0 Then
            
            
                oL.SubItems(PCOL_PORCENTAVANCE) = Int(100 / oL.SubItems(PCOL_HORAS) * oL.SubItems(PCOL_AVANCE)) & "%"
            End If

        Next i

    End With
    
    Lista.Refresh

End Sub

Sub ColorearAvance()
    Dim i As Long

    Dim oL As ListItem

    With Lista

        For i = 1 To .ListItems.Count
            Set oL = Lista.ListItems(i)
            
            If oL.SubItems(ACOL_CANT) > oL.SubItems(ACOL_AVANCE) Then
                oL.Bold = True
                oL.ForeColor = &HC0C0FF
            End If

        Next i

    End With

End Sub

Public Property Let Id(ByVal vNewValue As Long)

    Dim oControl As Control
    Dim oAp As ComPronto.Aplicacion
    Dim oApProd As ComPronto.Aplicacion
    Dim oDet As DetProduccionOrden
    Dim oDetproc As DetProdOrdenProceso
    Dim oRs As ADOR.Recordset
    Dim oRsAut As ADOR.Recordset
    Dim dtf As DTPicker
    Dim ListaVacia As Boolean
    Dim ListaProcVacia As Boolean
    Dim i As Integer, mCantidadFirmas As Integer
    Dim mAuxS1 As String
    Dim mAux1 As Variant
    Dim mVector
   
    mvarId = vNewValue
   
    ListaVacia = False
    mCadena = ""
    mvarModoCodigoBarra = False
    mvarAnulada = "NO"
    mvarImpresionHabilitada = True
    mvarSoloStockObra = False
    mvarTransportistaConEquipos = False
    mvarNoAnular = False
   
    Set oAp = Aplicacion
    Set oApProd = AplicacionProd
   
    Set origen = oApProd.ProduccionOrdenes.Item(vNewValue)
   
    Set oRs = oAp.Parametros.Item(1).Registro
    mvarIdMonedaPesos = oRs.Fields("IdMoneda").Value
    mvarIdUnidadCU = oRs.Fields("IdUnidadPorUnidad").Value
    oRs.Close
   
    mDescargaPorKit = BuscarClaveINI("Mover stock por kit")

    If mDescargaPorKit = "" Then mDescargaPorKit = "NO"
         
    mvarExigirEquipoDestino = BuscarClaveINI("Exigir equipo destino en salida de materiales")

    If mvarExigirEquipoDestino = "" Then mvarExigirEquipoDestino = "NO"
   
    If BuscarClaveINI("Requerir deposito origen en salida de materiales") = "SI" Then
        lblData(14).Visible = True
        dcfields(14).Visible = True
    End If
   
    If BuscarClaveINI("Inhabilitar impresion de SA") = "SI" Then mvarImpresionHabilitada = False
   
    If BuscarClaveINI("Mostrar solo stock de obra en salidas") = "SI" Then mvarSoloStockObra = True
   
    mvarIdDepositoCentral = 0
    mAux1 = TraerValorParametro2("IdDepositoCentral")

    If Not IsNull(mAux1) And IsNumeric(mAux1) Then mvarIdDepositoCentral = Val(mAux1)
   
    origen.MostrarSoloStockDeObra = mvarSoloStockObra
   
    Set oBind = New BindingCollection

    With oBind
        Set .DataSource = origen
      
        For Each oControl In Me.Controls

            If TypeOf oControl Is CommandButton Then
            ElseIf TypeOf oControl Is DbListView Then

                Select Case oControl.Name

                    Case "Lista"

                        If vNewValue < 0 Then
                            Set oControl.DataSource = origen.DetProduccionOrdenes.TraerMascara
                            ListaVacia = True
                        Else
                            Set oRs = origen.DetProduccionOrdenes.TraerTodos

                            If oRs.RecordCount <> 0 Then
                                Set oControl.DataSource = oRs
                                oRs.MoveFirst

                                Do While Not oRs.EOF
                                    Set oDet = origen.DetProduccionOrdenes.Item(oRs.Fields(0).Value)
                                    oDet.Modificado = True
                                    Set oDet = Nothing
                                    oRs.MoveNext
                                Loop

                                ListaVacia = False
                            Else
                                Set oControl.DataSource = origen.DetProduccionOrdenes.TraerMascara
                                ListaVacia = True
                            End If

                            oRs.Close
                        End If

                    Case "ListaProcesos"

                        If vNewValue < 0 Then
                            Set oControl.DataSource = origen.DetProduccionOrdenesProcesos.TraerMascara
                            ListaProcVacia = True
                        Else
                            'If mvarSoloStockObra And Not IsNull(origen.Registro.Fields("IdObra").Value) Then
                            '   Set oRs = oAp.TablasGenerales.TraerFiltrado("DetProduccionOrdenesProcesos", "Sal", Array(mvarId, origen.Registro.Fields("IdObra").Value))
                            'Else
                            Set oRs = origen.DetProduccionOrdenesProcesos.TraerTodos

                            'End If
                            If oRs.RecordCount <> 0 Then
                                Set oControl.DataSource = oRs
                                oRs.MoveFirst

                                Do While Not oRs.EOF
                                    Set oDetproc = origen.DetProduccionOrdenesProcesos.Item(oRs.Fields(0).Value)
                                    oDetproc.Modificado = True
                                    Set oDetproc = Nothing
                                    oRs.MoveNext
                                Loop

                                ListaProcVacia = False
                            Else
                                Set oControl.DataSource = origen.DetProduccionOrdenesProcesos.TraerMascara
                                ListaProcVacia = True
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

                    ElseIf oControl.Tag = "PuntosVenta" Then
                        Set oControl.RowSource = oAp.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(50, "X"))
                    Else
                        Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
                    End If
                End If

            Else
                On Error Resume Next
            
                Dim t As String
                t = TypeName(oControl)

                If t <> "Frame" And t <> "OptionButton" And t <> "Menu" And t <> "OptionButton" And t <> "Frame" And t <> "OptionButton" And t <> "Frame" And t <> "OptionButton" And t <> "Frame" And t <> "OptionButton" And t <> "StatusBar" And t <> "ImageList" Then
                    Set oControl.DataSource = origen
                End If
         
            End If

        Next

    End With
   
    Check1(0).Visible = True
   
    'op  o        No muestra el código del cliente.
    txtCodigoCliente = dcfields(9).BoundText
   
    MuestraAdjuntos

    For i = 0 To 1
        FileBrowser1(i).Text = origen.Registro.Fields("ArchivoAdjunto" & i + 1).Value
    Next
   
    If mvarId = -1 Then

        For Each dtf In DTFields
            dtf.Value = Date
        Next

        With origen.Registro
            .Fields("Emitio").Value = glbIdUsuario
        End With

        mvarGrabado = False
        mIdAprobo = 0
        cmd(3).Enabled = False
   
        With lblEstado1
            .Caption = "NUEVA"
            .Visible = True
        End With
     
        'MARIANO: harcodeo la obra
        dcfields(0).BoundText = 1
   
        txtNumeroProduccionOrden.Text = TraerValorParametro2("ProximoNumeroProduccionOrden")
        Set dcfields(dcf_ARTICULOPRODUCIDO).RowSource = Aplicacion.Articulos.TraerLista 'Por ahora saco el filtro de tipo hasta unir con la base pronto
        'Set dcfields(dcf_ARTICULOPRODUCIDO).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_ProduciblesParaCombo", Array(0))
        Set dcfields(12).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("OrdenesCompra", "_PorIdParaCombo")
   
        'op  o        Permitir ejecutar el “liberado” antes de dar el ACEPTAR por primera vez.
        dcfields(1).Enabled = True
   
    Else

        With origen.Registro
         
            'crear ops que tengan estos estados:
            '        Nueva (cuando la OP está cargada pero aún no Liberada –una OP en este estado no puede recibir Partes de Producción-).
            '        Abierta (cuando la OP está cargada y liberada, pero aún no está Programada –no entró en Programación de Recursos-; esta OP sí puede recibir Partes de Producción).
            '        Programada (cuando la OP ya está en un Programa de Recursos aceptado, esta OP sí recibe Partes de Producción).
            '        En Ejecución (cuando la OP recibe su primer “Parte de Producción”).
            '        Cerrada (cuando desde el formulario de la OP se cierra específicamente –a partir de este momento la OP no recibe más Partes de Prod.).-
         
            TraerAvanceTotal
            
            ultimaCantidad = .Fields("Cantidad").Value
         
            If Not IsNull(.Fields("Emitio").Value) Then
                Check1(0).Value = 1
                mIdAprobo = .Fields("Emitio").Value
            Else
                dcfields(4).Enabled = True
            End If

            If Not IsNull(.Fields("Aprobo").Value) Then
                Check1(0).Value = 1
                mIdAprobo = .Fields("Aprobo").Value
            Else
                dcfields(1).Enabled = True
            End If
         
            If Not IsNull(.Fields("Cerro").Value) Then
                Check1(0).Value = 1
                mIdAprobo = .Fields("Cerro").Value
            Else
                dcfields(15).Enabled = True
            End If

            lblEstado1.Caption = origen.GetEstado
        
            If lblEstado1.Caption = "CERRADA" Then

                For Each oControl In Me.Controls
                    oControl.Enabled = False
                Next

                cmd(1).Enabled = True  'cerrar
            
                cmd(0).Enabled = False 'aceptar
                cmd(3).Enabled = False 'anular
            
                cmdImpre(1).Enabled = True
            
            End If
        
            If lblEstado1.Caption = "ANULADA" Then

                For Each oControl In Me.Controls
                    oControl.Enabled = False
                Next

                cmd(1).Enabled = True
                
                Lista.Enabled = True
                ListaProcesos.Enabled = True
            End If

            'op  o        La fecha Inicio Previsto, Final Previsto, al ser modificada desde
            'el formulario de la OP no se guarda, sólo permite modificarla desde Programación de Recursos.
            'pone 1899
                       
            If MinimoFechaDeProceso <> 0 Then DTFields(2) = MinimoFechaDeProceso
            If MaximoFechaDeProceso <> 0 Then DTFields(3) = MaximoFechaDeProceso
            If DTFields(2) < DTFields(0) Then DTFields(2) = DTFields(0)  'la fecha prevista de inicio no puede ser anterior a la de emision

        End With

        mCantidadFirmas = 0
        mvarGrabado = True
    End If
   
    If ListaVacia Then
        Lista.ListItems.Clear
    End If
   
    If ListaProcVacia Then
        ListaProcesos.ListItems.Clear
    End If
   
    'PERMISOS
    cmd(0).Enabled = False

    If Me.NivelAcceso <= Medio Then
        If mvarId <= 0 Then
            cmd(0).Enabled = True
        ElseIf mvarId > 0 Then

            If IIf(IsNull(origen.Registro.Fields("Aprobo").Value), "NO", origen.Registro.Fields("Cumplido").Value) <> "SI" Then
                cmd(0).Enabled = True
                cmd(3).Enabled = True
            End If
        End If

    ElseIf Me.NivelAcceso = Alto Then
        cmd(0).Enabled = True
        cmd(3).Enabled = True
    End If
   
    If origen.Registro.Fields("Cerro").Value = "SI" Then
        cmd(0).Enabled = False
        cmd(2).Enabled = False
    End If
   
    If lblEstado1.Caption = "ANULADA" Then
        'cmd(1).Enabled = False  'cerrar
        cmd(0).Enabled = False 'aceptar
        cmd(3).Enabled = False 'anular
        cmdImpre(1).Enabled = True
        
        FileBrowser1(0).Enabled = False
        FileBrowser1(1).Enabled = False
        FileBrowser1(0).Visible = False 'no sé por qué, pero aun sacando el enabled puedo apretar el botoncito
        FileBrowser1(1).Visible = False
    End If
   
    If Not mvarImpresionHabilitada Then
        cmdImpre(0).Enabled = False
        cmdImpre(1).Enabled = False
    End If
   
    ColorearAvance
    RecalcularAvances
   
    'ancho automatico
    'ListaProcesos.ColumnHeaders(0).Width = -1
   
    dcfields(dcf_CLIENTE).Text = ""
    dcfields(dcf_CLIENTE).Text = dcfields(dcf_CLIENTE).Text
    dcfields(dcf_CLIENTE).Text = NombreCliente(Val(origen.Registro!Cliente))
    dcfields(dcf_CLIENTE).Text = dcfields(dcf_CLIENTE).Text
   
    ajustacolumnas
   
    If lblEstado1.Caption = "CERRADA" Then

        For Each oControl In Me.Controls
            oControl.Enabled = False
        Next

        cmd(1).Enabled = True  'cerrar
            
        cmd(0).Enabled = False 'aceptar
        cmd(3).Enabled = False 'anular
            
        cmdImpre(1).Enabled = True
                
        Lista.Enabled = True
        ListaProcesos.Enabled = True
    End If
   
    If mvarId = -1 Then
        MostrarFichasDisponibles
    End If
   
    Set oRs = Nothing
    Set oDet = Nothing
    Set oDetproc = Nothing
    Set oAp = Nothing
   
End Property

Function MinimoFechaDeProceso() As Date
       
    Dim rs As ADOR.Recordset
    Set rs = origen.DetProduccionOrdenesProcesos.TraerTodos

    With rs
        .MoveFirst
        MinimoFechaDeProceso = iisNull(!inicio, 0)

        Do While Not .EOF

            If !inicio < MinimoFechaDeProceso Or MinimoFechaDeProceso = 0 Then MinimoFechaDeProceso = iisNull(!inicio, 0)
            .MoveNext
        Loop

    End With

    Set rs = Nothing
    
End Function

Private Sub cmdDuplicarOP_Click()
    'werwer
End Sub

Private Sub cmdRefrescar_Click()

    Dim oControl As Control
    Dim oAp As ComPronto.Aplicacion
    Dim oApProd As ComPronto.Aplicacion
    Dim oDet As DetProduccionOrden
    Dim oDetproc As DetProdOrdenProceso
    Dim oRs As ADOR.Recordset
    Dim oRsAut As ADOR.Recordset
    
    
    
    If mvarId > 0 Then
    
        
        
        '////////////////////////////////////////////////////
        '////////////////////////////////////////////////////
        'articulos
        '////////////////////////////////////////////////////
        '////////////////////////////////////////////////////
        Set oRs = origen.DetProduccionOrdenes.TraerTodos

'    oRs.Fields.Append "Id_Color", adInteger

        If oRs.RecordCount <> 0 Then
            Set Lista.DataSource = oRs
            oRs.MoveFirst

            Do While Not oRs.EOF
                Set oDet = origen.DetProduccionOrdenes.Item(oRs.Fields(0).Value)
                oDet.Modificado = True
                Set oDet = Nothing
                oRs.MoveNext
            Loop

 '            oRs.Fields("Id_Color").Value = 10
            'ListaVacia = False
        Else
            Set Lista.DataSource = origen.DetProduccionOrdenes.TraerMascara
            'ListaVacia = True
        End If

        oRs.Close
        
        
                
        
        '////////////////////////////////////////////////////
        '////////////////////////////////////////////////////
        'procesos
        '////////////////////////////////////////////////////
        '////////////////////////////////////////////////////
        
        Set oRs = origen.DetProduccionOrdenesProcesos.TraerTodos

        'End If
        If oRs.RecordCount <> 0 Then
            Set ListaProcesos.DataSource = oRs
            oRs.MoveFirst

            Do While Not oRs.EOF
                Set oDetproc = origen.DetProduccionOrdenesProcesos.Item(oRs.Fields(0).Value)
                oDetproc.Modificado = True
                Set oDetproc = Nothing
                oRs.MoveNext
            Loop

            'ListaProcVacia = False
        Else
            Set ListaProcesos.DataSource = origen.DetProduccionOrdenesProcesos.TraerMascara
            'ListaProcVacia = True
        End If

        oRs.Close
    End If





RecalcularAvances
End Sub

Private Sub cmdVerFicha_Click()

    If Not IsNumeric(dcfields(dcf_ARTICULOPRODUCIDO).BoundText) And Not IsNumeric(dcfields(dcf_COLORPRODUCIDO).BoundText) Then Exit Sub
    
    Dim rs As ADOR.Recordset
  
    'para no pedir la ficha 2 veces (despues de poner el articulo y el color)
    Set rs = AplicacionProd.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", Array(Val(dcfields(dcf_ARTICULOPRODUCIDO).BoundText), Val(dcfields(dcf_COLORPRODUCIDO).BoundText)))
    
    If rs.RecordCount = 0 Then
        MsgBox ("No hay fichas para ese artículo y color")
        Exit Sub
    End If
    
    Dim oF As frmProduccionFicha
    Set oF = New frmProduccionFicha

    With oF
        .NivelAcceso = frmPrincipal.ControlAccesoNivel("ProduccionFichas")
        .OpcionesAcceso = frmPrincipal.ControlAccesoOpciones("ProduccionFichas")

        If IsNumeric(rs!idProduccionFicha) Then
            .Id = rs!idProduccionFicha
            
            'Muestro la OP del proceso sobre el que se hizo doble click
            '.Disparar = ActL
            ReemplazarEtiquetas oF
            Me.MousePointer = vbDefault
            .Show , Me

        End If

    End With
    
End Sub

Private Sub dcfields_LostFocus(Index As Integer)

    If Index = 11 Then
        CargarFicha
    End If

End Sub

Private Sub DTFields_Change(Index As Integer)

    If Index = 3 Then
        If DTFields(3) < DTFields(2) Then DTFields(3) = DTFields(2)  'la fecha prevista de inicio no puede ser anterior a la de emision
        
        DTFields(2) = DateAdd("h", -TotalHorasProceso, DTFields(3))

        If DTFields(2) < DTFields(0) Then DTFields(2) = DTFields(0)  'la fecha prevista de inicio no puede ser anterior a la de emision
    End If
    
    If Index = 2 Then
        If DTFields(2) < DTFields(0) Then DTFields(2) = DTFields(0)  'la fecha prevista de inicio no puede ser anterior a la de emision
        
        DTFields(3) = DateAdd("h", TotalHorasProceso, DTFields(2))

        If DTFields(3) < DTFields(2) Then DTFields(3) = DTFields(2)  'la fecha prevista de inicio no puede ser anterior a la de emision
    End If
    
End Sub

Private Sub FileBrowser1_Change(Index As Integer)

    If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
        If Len(Trim(FileBrowser1(Index).Text)) > gblMaximaLongitudAdjuntos Then
            MsgBox "La longitud maxima para un archivo adjunto es de " & gblMaximaLongitudAdjuntos & " caracteres", vbInformation
            FileBrowser1(Index).Text = ""
        Else
            FileBrowser1(Index).InitDir = FileBrowser1(Index).Text
        End If
    End If
   
End Sub

Private Sub FileBrowser1_DblClick(Index As Integer)

    If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
        If Not Len(Trim(Dir(FileBrowser1(Index).Text))) <> 0 Then
            MsgBox "El archivo indicado no existe!", vbExclamation
            Exit Sub
        End If

        Call ShellExecute(Me.hwnd, "open", FileBrowser1(Index).Text, vbNullString, vbNullString, SW_SHOWNORMAL)
    End If

End Sub

Function MaximoFechaDeProceso() As Date
       
    Dim rs As ADOR.Recordset
    Set rs = origen.DetProduccionOrdenesProcesos.TraerTodos

    With rs
        .MoveFirst
        MaximoFechaDeProceso = iisNull(!final, 0)

        Do While Not .EOF

            If !final > MaximoFechaDeProceso Or MaximoFechaDeProceso = 0 Then MaximoFechaDeProceso = iisNull(!final, 0)
            .MoveNext
        Loop

    End With

    Set rs = Nothing
    
End Function

Sub ajustacolumnas()

    Dim col2adjust As Long

    For col2adjust = 0 To Lista.ColumnHeaders.Count - 1
        'no funciona porque me parece que la listapronto no trae el hwnd del listview
        Call SendMessage(Lista.hwnd, LVM_SETCOLUMNWIDTH, col2adjust, ByVal LVSCW_AUTOSIZE_USEHEADER)
    Next

End Sub

Friend Sub cmdImpre_Click(Index As Integer)
    On Error Resume Next

    If Not mvarGrabado Then
        MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
        Exit Sub
    End If
   
    Dim mvarOK As Boolean
    Dim mCopias As Integer
   
    If Index = 0 Then
        Dim oF 'As frmCopiasImpresion

        'Set oF = New frmCopiasImpresion
        With oF

            If Index <> 0 Then
                .Frame1.Visible = False
            End If

            .Show vbModal, Me
            mvarOK = .Ok
            mCopias = Val(.txtCopias.Text)
        End With

        Unload oF
        Set oF = Nothing

        If Not mvarOK Then
            Exit Sub
        End If

    Else
        mCopias = 1
    End If

    Dim oW As Word.Application
    Dim mPlanilla As String
   
    If mTipoSalida = 1 Then
        mPlanilla = BuscarClaveINI("Plantilla para salida de materiales a obra")

        If Len(Trim(mPlanilla)) = 0 Then mPlanilla = "ProduccionOrden"
    Else
        mPlanilla = "ProduccionOrden"
    End If
   
    Set oW = CreateObject("Word.Application")
   
    oW.Visible = True
    'oW.Documents.Add (glbPathPlantillas & "\" & mPlanilla & "_" & glbEmpresaSegunString & ".dot")
    oW.Documents.Add (glbPathPlantillas & "\" & mPlanilla & ".dot")
    oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId
    oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
    oW.Application.Run MacroName:="DatosDelPie"

    If Index = 0 Then
        oW.ActiveDocument.PrintOut False, , , , , , , mCopias
        oW.ActiveDocument.Close False
    End If

    If Index = 0 Then oW.Quit

Salida:

    Set oW = Nothing
    Exit Sub

Mal:

    If Index = 0 Then oW.Quit
    Me.MousePointer = vbDefault
    MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical
    Resume Salida

End Sub

Friend Sub dcfields_Change(Index As Integer)

    If Not IsNumeric(dcfields(Index).BoundText) Then Exit Sub
   
    Dim oRs As ADOR.Recordset
   
    Select Case Index

        Case 0
            origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText

        Case 2
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorIdTransportista", dcfields(Index).BoundText)
            mvarTransportistaConEquipos = False

            If oRs.RecordCount > 0 Then mvarTransportistaConEquipos = True
            Set dcfields(8).RowSource = oRs

        Case 5
            '         Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", dcfields(Index).BoundText)
            '         If oRs.RecordCount > 0 Then
            '            If Not IsNull(oRs.Fields("IdTransportista").Value) Then
            '               origen.Registro.Fields("IdTransportista1").Value = oRs.Fields("IdTransportista").Value
            '               dcfields(2).Enabled = False
            '               Set dcfields(8).RowSource = Aplicacion.Articulos.TraerFiltrado("_PorIdTransportista", oRs.Fields("IdTransportista").Value)
            '            End If
            '         End If
            '         oRs.Close
      
        Case 11
            Dim oArt As ComPronto.Articulo

            If IsNumeric(dcfields(dcf_ARTICULOPRODUCIDO).BoundText) Then
                Set oArt = Aplicacion.Articulos.Item(dcfields(dcf_ARTICULOPRODUCIDO).BoundText)
                Set oRs = oArt.Registro
                txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
            End If
          
            'CargarFicha
        Case 8
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", dcfields(Index).BoundText)

            If oRs.RecordCount > 0 Then
                If Not IsNull(oRs.Fields("NumeroPatente").Value) Then
                    origen.Registro.Fields("Patente1").Value = oRs.Fields("NumeroPatente").Value
                End If
            End If

            oRs.Close

        Case 10

            If mvarId <= 0 And mvarNumerarPorPuntoVenta Then
                Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(Index).BoundText)

                If oRs.RecordCount > 0 Then
                    origen.Registro.Fields("NumeroProduccionOrden").Value = oRs.Fields("ProximoNumero").Value

                    Select Case mTipoSalida

                        Case 0, 2
                            txtNumeroProduccionOrden.Text = IIf(IsNull(oRs.Fields("ProximoNumero").Value), 1, oRs.Fields("ProximoNumero").Value)

                        Case 1
                            txtNumeroProduccionOrden.Text = IIf(IsNull(oRs.Fields("ProximoNumero1").Value), 1, oRs.Fields("ProximoNumero1").Value)

                        Case 3, 4, 5
                            txtNumeroProduccionOrden.Text = IIf(IsNull(oRs.Fields("ProximoNumero" & mTipoSalida - 1).Value), 1, oRs.Fields("ProximoNumero" & mTipoSalida - 1).Value)
                    End Select

                End If

                oRs.Close
            End If

    End Select

    Set oRs = Nothing

End Sub

Private Sub dcfields_GotFocus(Index As Integer)
   
    If Index <> 4 And Index <> 1 And Index <> 15 Then
        If dcfields(Index).Enabled Then
            SendKeys "%{DOWN}"
        Else
            SendKeys "{TAB}"
        End If
    End If

End Sub

Private Sub dcfields_KeyPress(Index As Integer, _
                              KeyAscii As Integer)
   
    If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub dcfields_Click(Index As Integer, _
                           Area As Integer)
    BoundText(Index) = dcfields(Index).BoundText
   
    If Index = 4 And Me.Visible And IsNumeric(dcfields(4).BoundText) Then
        If dcfields(4).BoundText <> mIdAprobo Then
            PideAutorizacionEmitio
        End If

    ElseIf Index = 1 And Me.Visible And IsNumeric(dcfields(1).BoundText) Then
        PideAutorizacionAprobo
    ElseIf Index = 15 And Me.Visible And IsNumeric(dcfields(15).BoundText) Then
        PideAutorizacionCerro
    End If
   
    If Index = 0 Then
        Dim mIdObra As Integer
        mIdObra = 0

        If mvarId <= 0 Then
            If IsNumeric(dcfields(2).BoundText) Then mIdObra = dcfields(2).BoundText
        Else
            mIdObra = IIf(IsNull(origen.Registro.Fields("IdObra").Value), 0, origen.Registro.Fields("IdObra").Value)
        End If

        Set dcfields(2).RowSource = Aplicacion.Obras.TraerFiltrado("_PorIdClienteParaCombo", dcfields(0).BoundText)
        dcfields(2).Refresh
        dcfields(2).BoundText = mIdObra
        'MostrarDatos (0)
         
    ElseIf Index = 11 Then
        'CargarFicha
    ElseIf Index = 12 Then
        CargarOrden
    End If

End Sub

Private Sub cmdBuscarFicha_Click()
    
    BuscarFicha
End Sub

Sub BuscarFicha()
    'If Not IsNumeric(dcfields(dcf_ARTICULO).BoundText) Then Exit Sub
    Dim rs As Recordset
    
    Set rs = AplicacionProd.ProduccionFichas.TraerTodos
    rs.Filter = "Activa='SI'"

    'Set rs = FichasActivas(Aplicacion)
    
    'Set rs = Aplicacion.Articulos.TraerFiltrado("_StockPorPartidaParaProduccion", Array(dcfields(dcf_ARTICULO).BoundText, dcfields(dcf_UBICACION).BoundText))
    
    Dim oL As ListItem
    Dim IdStock As Long
    IdStock = ConsultaSimple(rs, oL)
    
    If oL Is Nothing Then Exit Sub
    
    dcfields(dcf_ARTICULOPRODUCIDO) = oL.SubItems(2) 'queda enlazado?
    dcfields(dcf_ARTICULOPRODUCIDO).BoundText = dcfields(dcf_ARTICULOPRODUCIDO).BoundText
    dcfields(dcf_COLORPRODUCIDO) = oL.SubItems(3) 'queda enlazado?
    dcfields(dcf_COLORPRODUCIDO).BoundText = dcfields(dcf_COLORPRODUCIDO).BoundText
    CargarFicha
    'dcfields(dcf_ubicacion)=
     
    'ValidarPeso

End Sub

Sub CargarFicha()
    On Error Resume Next
    Dim o As ComPronto.ProduccionFicha
    Dim oControl As Control
    Dim oDet As DetProduccionOrden
    Dim oDetproc As DetProdOrdenProceso
    Dim oRs As ADOR.Recordset
    Dim rs As ADOR.Recordset
      
    'La búsqueda de Ficha Técnica desde la ORDEN DE PRODUCCION debe hacerse no sólo por el Artículo sino también por el Color.

    If Not IsNumeric(dcfields(dcf_ARTICULOPRODUCIDO).BoundText) And Not IsNumeric(dcfields(dcf_COLORPRODUCIDO).BoundText) Then Exit Sub
      
    'para no pedir la ficha 2 veces (despues de poner el articulo y el color)
    Set rs = AplicacionProd.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", Array(dcfields(dcf_ARTICULOPRODUCIDO).BoundText, Val(dcfields(dcf_COLORPRODUCIDO).BoundText)))
    
    If rs.RecordCount = 0 Then Exit Sub
    'If MsgBox("Traer Ficha?", vbYesNo) = vbNo Then Exit Sub
    
    Set o = AplicacionProd.ProduccionFichas.Item(rs!idProduccionFicha)
    
    If txtCantidad.Text = "" Then txtCantidad.Text = o.Registro!Cantidad
    ultimaCantidad = txtCantidad.Text
    dcfields(20).BoundText = o.Registro!IdUnidad
    dcfields(dcf_COLORPRODUCIDO).BoundText = o.Registro!IdColor
    
    Dim i As Long

    For i = 0 To 1
        FileBrowser1(i).Text = o.Registro.Fields("ArchivoAdjunto" & i + 1).Value
    Next
         
    '/////////////////////////////////////////////////////////////////////////////
    '///////////
    'borro todo los detalles
    '////////////
    Dim BorraRs As ADOR.Recordset
    
    'for i=1 to
    
    Set BorraRs = origen.DetProduccionOrdenes.Registros

    If BorraRs.State <> 0 Then
        BorraRs.MoveFirst

        Do While Not BorraRs.EOF
            'origen.DetProduccionOrdenes.Remove (BorraRs!idDetalleProduccionOrden)
            Set oDet = origen.DetProduccionOrdenes.Item(BorraRs!IdDetalleProduccionOrden)
            oDet.Eliminado = True
            BorraRs.MoveNext
        Loop

    End If
    
    Set BorraRs = origen.DetProduccionOrdenesProcesos.Registros

    If BorraRs.State <> 0 Then
        BorraRs.MoveFirst

        Do While Not BorraRs.EOF
            'origen.DetProduccionOrdenesProcesos.Remove (BorraRs!idDetalleProduccionOrdenProceso)
            Set oDetproc = origen.DetProduccionOrdenesProcesos.Item(BorraRs!IdDetalleProduccionOrdenProceso)
            oDetproc.Eliminado = True
            BorraRs.MoveNext
        Loop

    End If

    '/////////////////////////////////////////////////////////////////////////////

    Dim rsUnids As ADOR.Recordset
    Set rsUnids = Aplicacion.Unidades.TraerTodos
    Dim proceso As proceso

    Dim c As Currency

    For Each oControl In Me.Controls

        If TypeOf oControl Is CommandButton Then
        ElseIf TypeOf oControl Is DbListView Then

            Select Case oControl.Name

                Case "Lista"
                    i = 1
                    'Set oRs = o.DetProduccionFichas.TraerTodos
                    Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_DetalleDeFicha", (rs!idProduccionFicha))
                     
                    Set oControl.DataSource = oRs

                    If oRs.RecordCount <> 0 Then
                        oRs.MoveFirst

                        Do While Not oRs.EOF
                               
                            Set oDet = origen.DetProduccionOrdenes.Item(-1)

                            With oDet.Registro
                                !IdArticulo = oRs!IdArticulo
                                !IdUnidad = oRs!IdUnidad
                                !IdProduccionProceso = oRs!IdProduccionProceso
                                    
                                'copia la tolerancia de la ficha en la op?
                                !IdColor = oRs!IdColor
                                !Tolerancia = oRs!Tolerancia
                            End With

                            'actualizar cantidad en la lista y en el objeto
                                                             
                            c = txtCantidad.Text * oRs.Fields("Cant.").Value / o.Registro!Cantidad
                            oDet.Registro!Cantidad = c
                            Lista.ListItems(i).SubItems(ACOL_CANT) = "" & Format(c, "Fixed")
                            rsUnids.Filter = "idUnidad=" & oRs!IdUnidad
                            Lista.ListItems(i).SubItems(ACOL_UNI) = rsUnids!descripcion
                            'If Not IsNull(oRs!idproduccionproceso) Then
                            '     Set proceso = AplicacionProd.Procesos.Item(oRsidproduccionproceso)
                            Lista.ListItems(i).SubItems(ACOL_PROCESO) = oRs.Fields("Proceso Asociado")
                            'End If
                            Lista.ListItems(i).SubItems(ACOL_COLOR) = oRs!Color
                              
                            Lista.ListItems(i).Tag = oDet.Id 'oRs!IdArticulo
                            i = i + 1
                               
                            'Set oDet = o.DetProduccionfichas.Item(oRs.Fields(0).Value)
                               
                            oDet.Modificado = True
                            Set oDet = Nothing
                            oRs.MoveNext
                        Loop

                    End If

                    oRs.Close

                Case "ListaProcesos"
                    'Set oRs = o.DetProduccionFichasProcesos.TraerTodos
                                               
                    i = 1
                    Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_DetalleProcesosDeFicha", (rs!idProduccionFicha))
                        
                    Set oControl.DataSource = oRs

                    If oRs.RecordCount <> 0 Then
                        oRs.MoveFirst

                        Do While Not oRs.EOF
                            Set oDetproc = origen.DetProduccionOrdenesProcesos.Item(-1)
                            oDetproc.Registro!IdProduccionProceso = oRs!IdProduccionProceso
                            oDetproc.Registro!Horas = oRs!Horas

                            c = txtCantidad.Text * oRs!Horas / o.Registro!Cantidad
                            oDetproc.Registro!Horas = c
                            ListaProcesos.ListItems(i).SubItems(PCOL_HORAS) = "" & CInt(c)

                            ListaProcesos.ListItems(i).Tag = oDetproc.Id
                            i = i + 1
                               
                            oDetproc.Modificado = True
                            Set oDetproc = Nothing
                            oRs.MoveNext
                        Loop

                    End If

                    oRs.Close
            End Select
         
            'ElseIf TypeOf oControl Is Label Then
            '   If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
            'ElseIf TypeOf oControl Is RichTextBox Then
            '   If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
            'ElseIf TypeOf oControl Is DataCombo Then
            '   If Len(oControl.DataField) Then Set oControl.DataSource = o
            'Else
            '   On Error Resume Next
            '
            '
            '
            '  Dim t As String
            '   t = TypeName(oControl)
            '   If t <> "Frame" And t <> "OptionButton" And _
            '      t <> "Menu" And t <> "OptionButton" And _
            '      t <> "Frame" And t <> "OptionButton" And _
            '      t <> "Frame" And t <> "OptionButton" And _
            '      t <> "Frame" And t <> "OptionButton" And _
            '      t <> "StatusBar" And t <> "ImageList" Then
            '       Set oControl.DataSource = o
            '   End If
            '
         
        End If

    Next

    'End With
    
    RecalculaProporciones
End Sub


Sub DuplicarOP(idop As Long)
    Dim o As ComPronto.ProduccionOrden
    Dim oControl As Control
    Dim oDet As DetProduccionOrden
    Dim oDetproc As DetProdOrdenProceso
    Dim oRs As ADOR.Recordset
    Dim rs As ADOR.Recordset
      
    Set o = AplicacionProd.ProduccionOrdenes.Item(idop)
    
    If txtCantidad.Text = "" Then txtCantidad.Text = o.Registro!Cantidad
    '/////////////////////////////////////////////////////////////////////////////
    '///////////
    'borro todo los detalles
    '////////////
    Dim BorraRs As ADOR.Recordset
    
    'for i=1 to
    
    Set BorraRs = origen.DetProduccionOrdenes.Registros

    If BorraRs.State <> 0 Then
        BorraRs.MoveFirst

        Do While Not BorraRs.EOF
            'origen.DetProduccionOrdenes.Remove (BorraRs!idDetalleProduccionOrden)
            Set oDet = origen.DetProduccionOrdenes.Item(BorraRs!IdDetalleProduccionOrden)
            oDet.Eliminado = True
            BorraRs.MoveNext
        Loop

    End If
    
    Set BorraRs = origen.DetProduccionOrdenesProcesos.Registros

    If BorraRs.State <> 0 Then
        BorraRs.MoveFirst

        Do While Not BorraRs.EOF
            'origen.DetProduccionOrdenesProcesos.Remove (BorraRs!idDetalleProduccionOrdenProceso)
            Set oDetproc = origen.DetProduccionOrdenesProcesos.Item(BorraRs!IdDetalleProduccionOrdenProceso)
            oDetproc.Eliminado = True
            BorraRs.MoveNext
        Loop

    End If

    '/////////////////////////////////////////////////////////////////////////////
    
    dcfields(dcf_ARTICULOPRODUCIDO).BoundText = o.Registro!idArticuloGenerado
    Dim rsUnids As ADOR.Recordset
    Set rsUnids = Aplicacion.Unidades.TraerTodos

    Dim proceso As proceso
    
    Dim i As Long
    Dim c As Currency

    For Each oControl In Me.Controls

        If TypeOf oControl Is CommandButton Then
        ElseIf TypeOf oControl Is DbListView Then

            Select Case oControl.Name

                Case "Lista"
                    i = 1
                    Set oRs = o.DetProduccionOrdenes.TraerTodos
                    'Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_DetalleDeorden", (rs!idProduccionorden))
                     
                    Set oControl.DataSource = oRs

                    If oRs.RecordCount <> 0 Then
                        oRs.MoveFirst

                        Do While Not oRs.EOF
                               
                            Set oDet = origen.DetProduccionOrdenes.Item(-1)

                            With oDet.Registro
                                !IdArticulo = oRs!IdArticulo
                                !IdUnidad = oRs!IdUnidad
                                !IdProduccionProceso = oRs!IdProduccionProceso
                                !IdColor = BuscaIdColor(oRs!Color)
                            End With

                            'actualizar cantidad en la lista y en el objeto
                                                             
                            c = txtCantidad.Text * oRs.Fields("Cant.").Value / o.Registro!Cantidad
                            oDet.Registro!Cantidad = c
                            Lista.ListItems(i).SubItems(ACOL_CANT) = "" & Format(c, "Fixed")
                            rsUnids.Filter = "idUnidad=" & oRs!IdUnidad
                            Lista.ListItems(i).SubItems(ACOL_UNI) = rsUnids!descripcion
                            'If Not IsNull(oRs.Fields("Proceso Asociado")) Then
                            'Set proceso = AplicacionProd.Procesos.Item(oRs.Fields("Proceso Asociado"))
                            Lista.ListItems(i).SubItems(ACOL_PROCESO) = oRs.Fields("Proceso Asociado")
                            
                            'vacío la columna de partidas usadas en el original
                            Lista.ListItems(i).SubItems(ACOL_PARTIDA) = ""
                            Lista.ListItems(i).SubItems(ACOL_AVANCE) = ""
                            Lista.ListItems(i).SubItems(ACOL_PORCENTAVANCE) = ""
                            Lista.ListItems(i).SubItems(ACOL_UBIC) = ""
                            

                            
                            
                            'End If
                               
                            Lista.ListItems(i).SubItems(ACOL_COLOR) = oRs!Color

                            Lista.ListItems(i).Tag = oDet.Id 'oRs!IdArticulo
                            i = i + 1
                               
                            'Set oDet = o.DetProduccionfichas.Item(oRs.Fields(0).Value)
                               
                            oDet.Modificado = True
                            Set oDet = Nothing
                            oRs.MoveNext
                        Loop

                    End If

                    oRs.Close

                    cmdRefrescar.Enabled = False
                    
                Case "ListaProcesos"
                    Set oRs = o.DetProduccionOrdenesProcesos.TraerTodos
                                               
                    i = 1
                    'Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_DetalleProcesosDeFicha", (rs!idProduccionFicha))
                        
                    Set oControl.DataSource = oRs

                    If oRs.RecordCount <> 0 Then
                        oRs.MoveFirst

                        Do While Not oRs.EOF
                            Set oDetproc = origen.DetProduccionOrdenesProcesos.Item(-1)
                            oDetproc.Registro!IdProduccionProceso = oRs!IdProduccionProceso
                            oDetproc.Registro!Horas = oRs!Horas

                            c = txtCantidad.Text * oRs!Horas / o.Registro!Cantidad
                            oDetproc.Registro!Horas = c
                            ListaProcesos.ListItems(i).SubItems(PCOL_HORAS) = "" & CInt(c)

                            ListaProcesos.ListItems(i).SubItems(PCOL_AVANCE) = ""
                            
                            ListaProcesos.ListItems(i).Tag = oDetproc.Id
                            i = i + 1
                               
                            oDetproc.Modificado = True
                            Set oDetproc = Nothing
                            oRs.MoveNext
                        Loop

                    End If

                    oRs.Close
            End Select
         
            'ElseIf TypeOf oControl Is Label Then
            '   If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
            'ElseIf TypeOf oControl Is RichTextBox Then
            '   If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
            'ElseIf TypeOf oControl Is DataCombo Then
            '   If Len(oControl.DataField) Then Set oControl.DataSource = o
            'Else
            '   On Error Resume Next
            '
            '
            '
            '  Dim t As String
            '   t = TypeName(oControl)
            '   If t <> "Frame" And t <> "OptionButton" And _
            '      t <> "Menu" And t <> "OptionButton" And _
            '      t <> "Frame" And t <> "OptionButton" And _
            '      t <> "Frame" And t <> "OptionButton" And _
            '      t <> "Frame" And t <> "OptionButton" And _
            '      t <> "StatusBar" And t <> "ImageList" Then
            '       Set oControl.DataSource = o
            '   End If
            '
         
        End If

    Next

    'End With
    
    RecalculaProporciones
End Sub

Sub RecalculaProporciones()
    Dim c As Currency
    Dim oDet As DetProduccionOrden
    Dim oDetproc As DetProdOrdenProceso
    
    If txtCantidad.Text = "" Then Exit Sub
    'If txtCantidad.Text = "" Or mvarId <> -1 Then Exit Sub 'si la OP es nueva, no se recalcula -Por????
    
    
    If mvarId = -1 And ultimaCantidad = 0 Then
        ultimaCantidad = txtCantidad.Text
    End If
    
    
    If mvarId <> -1 And ultimaCantidad = 0 Then 'si está tocando la cantidad por primera vez, no recalculo, sino que traigo los valores de la ficha
        ultimaCantidad = txtCantidad.Text
        Exit Sub
    End If
    

    
    Dim i As Long
      
      
    For i = 1 To Lista.ListItems.Count
        Set oDet = origen.DetProduccionOrdenes.Item(Lista.ListItems(i).Tag)
            
        c = txtCantidad.Text * Lista.ListItems(i).SubItems(ACOL_CANT) / ultimaCantidad
            
        oDet.Registro!Cantidad = c
        Lista.ListItems(i).SubItems(ACOL_CANT) = "" & Format(c, "Fixed")
    Next

    For i = 1 To ListaProcesos.ListItems.Count
        Set oDetproc = origen.DetProduccionOrdenesProcesos.Item(ListaProcesos.ListItems(i).Tag)
            
        c = txtCantidad.Text * ListaProcesos.ListItems(i).SubItems(PCOL_HORAS) / ultimaCantidad
            
        oDetproc.Registro!Horas = c
        ListaProcesos.ListItems(i).SubItems(PCOL_HORAS) = "" & CInt(c)
    Next

    ultimaCantidad = txtCantidad
    
    If origen.GetEstado <> "PROGRAMADA" Then
        DTFields(3) = DateAdd("h", TotalHorasProceso, DTFields(2)) 'calculo a partir del inicio
    Else
        DTFields(2) = DateAdd("h", -TotalHorasProceso, DTFields(3)) 'calculo a partir del final

        If DTFields(2) < DTFields(0) Then DTFields(2) = DTFields(0)  'la fecha prevista de inicio no puede ser anterior a la de emision
    End If

End Sub

Sub CargarOrden()
    Dim o As ComPronto.OrdenCompra
    Dim oControl As Control
    Dim oDet As ComPronto.DetOrdenCompra
    Dim oDetproc As DetProdOrdenProceso
    Dim oRs As ADOR.Recordset
      
    If Not IsNumeric(dcfields(12).BoundText) Then Exit Sub
    Set o = Aplicacion.OrdenesCompra.Item(dcfields(12).BoundText)
      
    Set oRs = o.DetOrdenesCompra.TraerTodos 'esta llama a DetOrdenesCompra_TXOCompra, que no trae el idArticulo...
    
    If oRs.RecordCount <> 0 Then
        oRs.MoveFirst
        Set oDet = o.DetOrdenesCompra.Item(oRs!idDetalleOrdenCompra)
        dcfields(dcf_ARTICULOPRODUCIDO).BoundText = oDet.Registro!IdArticulo

        'dcfields(dcf_COLORPRODUCIDO).BoundColumn = o.Registro!IdColor
        If Not IsNull(o.Registro!IdCliente) Then dcfields(9).BoundText = o.Registro!IdCliente
    End If
   
    CargarFicha
    'End With
 
End Sub

Private Sub MuestraAdjuntos()

    Dim i As Integer
   
    Dim oAp As ComPronto.Aplicacion
    Dim oPar As ComPronto.Parametro
    Set oPar = oAp.Parametros.Item(1)

    With oPar.Registro
        mvarIdUnidadCU = IIf(IsNull(.Fields("IdUnidadPorUnidad").Value), 0, .Fields("IdUnidadPorUnidad").Value)
        mvarPathAdjuntos = IIf(IsNull(.Fields("PathAdjuntos").Value), "", .Fields("PathAdjuntos").Value)
    End With

    Set oPar = Nothing
   
    'If IsNull(origen.Registro.Fields("Adjunto").Value) Or origen.Registro.Fields("Adjunto").Value = "NO" Then
    '   For i = 0 To 9
    '      lblAdjuntos(i).Visible = False
    '      FileBrowser1(i).Visible = False
    '      FileBrowser1(i).Text = ""
    '   Next
    '   Line1.Visible = False
    '   Me.Height = 6500
    'Else
    For i = 0 To 1
        lblAdjuntos(i).Visible = True
        FileBrowser1(i).Visible = True

        If Len(Trim(FileBrowser1(i).Text)) = 0 Then
            FileBrowser1(i).Text = mvarPathAdjuntos
            FileBrowser1(i).InitDir = mvarPathAdjuntos
        End If

    Next

    '   Line1.Visible = True
    '   Me.Height = 8700
    'End If
      
End Sub

Private Sub Label1_Click()

End Sub

Private Sub txtBusca_GotFocus()

    With txtBusca
        .SelStart = 0
        .SelLength = Len(.Text)
    End With

End Sub

Private Sub txtBusca_KeyPress(KeyAscii As Integer)

    If KeyAscii = Asc(vbCr) Then
        If KeyAscii = 13 Then
            If Len(Trim(txtBusca.Text)) <> 0 Then
                Set dcfields(dcf_ARTICULOPRODUCIDO).RowSource = Aplicacion.Articulos.TraerFiltrado("_Busca", txtBusca.Text)
            Else
                Set dcfields(dcf_ARTICULOPRODUCIDO).RowSource = Aplicacion.Articulos.TraerLista
            End If
        End If

        dcfields(dcf_ARTICULOPRODUCIDO).SetFocus
        SendKeys "%{DOWN}"
    End If

End Sub

Private Sub txtCantidad_Validate(Cancel As Boolean)
    RecalculaProporciones
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

            With origen.Registro
                .Fields("IdArticuloGenerado").Value = oRs.Fields(0).Value

                If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                    .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                Else
                    '.Fields("IdUnidad").Value = mvarIdUnidadCU
                End If

            End With

            'MostrarStockActual
        Else
            MsgBox "Codigo de material incorrecto", vbExclamation
            Cancel = True
            txtCodigoArticulo.Text = ""
        End If

        oRs.Close
        Set oRs = Nothing
    End If
   
End Sub

Private Sub txtCodigoCliente_Change()

    If Len(txtCodigoCliente.Text) > 0 Then
        Dim oRs As ADOR.Recordset
        Set oRs = Aplicacion.Clientes.TraerFiltrado("_PorCodigo", txtCodigoCliente.Text)

        If oRs.RecordCount > 0 Then
            origen.Registro.Fields("Cliente").Value = oRs.Fields(0).Value
        Else
            'origen.Registro.Fields("IdCliente").Value = Null
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

Public Sub dcfields_Validate(Index As Integer, _
                             Cancel As Boolean)

    Dim oRsObra As ADOR.Recordset
    Dim oRsCliente As ADOR.Recordset
    Dim oRsProv As ADOR.Recordset
   
    If Index = 13 Then 'Or index = 13
        CargarFicha
    End If

    If Index = 11 Or Index = 12 Then Exit Sub
   
    If IsNumeric(dcfields(Index).BoundText) And Index <> 11 And Index <> 12 Then
        origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText

        If Not IsNumeric(dcfields(Index).BoundText) Then Exit Sub

        Select Case Index

            Case 0
                Set oRsObra = Aplicacion.Obras.Item(dcfields(Index).BoundText).Registro

                If oRsObra.RecordCount > 0 Then
                    If Not IsNull(oRsObra.Fields("IdCliente").Value) Then
                        Set oRsCliente = Aplicacion.Clientes.TraerFiltrado("_TT", oRsObra.Fields("IdCliente").Value)

                        With oRsCliente

                            If .RecordCount > 0 Then

                                'lblcliente.Caption = "Cliente : "
                                If Not IsNull(.Fields("Razon Social").Value) Then
                                    'txtCliente.Text = .Fields("Razon Social").Value
                                Else
                                    'txtCliente.Text = ""
                                End If
                            End If

                            oRsCliente.Close
                        End With

                        With origen.Registro
                            .Fields("IdProveedor").Value = Null
                        End With

                    End If
                End If

                oRsObra.Close

            Case 5
                Set oRsProv = Aplicacion.Proveedores.TraerFiltrado("_TT", dcfields(Index).BoundText)

                With oRsProv

                    If oRsProv.RecordCount > 0 Then

                        'lblcliente.Caption = "Proveedor : "
                        If Not IsNull(.Fields("Razon social").Value) Then
                            'txtCliente.Text = .Fields("Razon social").Value
                        Else
                            'txtCliente.Text = ""
                        End If
                    End If

                    .Close
                End With

                '            With origen.Registro
                '               .Fields("IdObra").Value = Null
                '               Check2.Value = 0
                '            End With
            Case 6

                'txtCliente.Text = ""
            Case 14
                dcfields(Index).Enabled = False

            Case 9
        End Select

    Else

        If Index <> 9 Then
            dcfields(Index).Text = ""
        Else
            
            dcfields(dcf_CLIENTE).Text = dcfields(dcf_CLIENTE).Text
            'dcfields(dcf_CLIENTE).BoundText = BuscaIdCliente(dcfields(dcf_CLIENTE).Text)
                        
            Dim oRsTemp As ADOR.Recordset
            Set oRsTemp = Aplicacion.Clientes.Item(BuscaIdCliente(dcfields(dcf_CLIENTE).Text)).Registro
            'txtCodigoCliente.Text = IIf(IsNull(oRsTemp.Fields("Codigo").Value), "", oRsTemp.Fields("Codigo").Value)

        End If
        
    End If
   
    Set oRsObra = Nothing
    Set oRsCliente = Nothing
    Set oRsProv = Nothing

End Sub

Private Sub DTFields_KeyDown(Index As Integer, _
                             KeyCode As Integer, _
                             Shift As Integer)

    If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Sub TraerAvanceTotal()
    Dim oRs As ADOR.Recordset
    
    Dim art As ComPronto.Articulo
    Set art = Aplicacion.Articulos.Item(dcfields(dcf_ARTICULOPRODUCIDO).BoundText)
    
    Dim oRsTipo As ADOR.Recordset
    Set oRsTipo = Aplicacion.Tipos.TraerTodos
    oRsTipo.Filter = "Descripcion='Terminado'"
    
    If art.Registro!Idtipo = oRsTipo!Idtipo Then 'es un terminado
        Set oRs = Aplicacion.UnidadesEmpaque.TraerFiltrado("_NetoPorPartidaConsolidada", Array(txtNumeroProduccionOrden, dcfields(dcf_ARTICULOPRODUCIDO).BoundText))
        txtCantidadProducida = iisNull(oRs!PesoNetoTotal, 0)
    Else
        Set oRs = AplicacionProd.ProduccionPartes.TraerFiltrado("_TotalProducidoporOP", origen.Registro!IdProduccionOrden)
        txtCantidadProducida = iisNull(oRs!CantidadTotal, 0)
    End If
    
    txtAvanceProducido = Int(100 / txtCantidad * txtCantidadProducida) & "%"
    
    Set art = Nothing
    Set oRs = Nothing
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

                With origen.DetProduccionOrdenes.Item(-1)
                    With .Registro
                        .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                        .Fields("IdObra").Value = origen.Registro.Fields("IdObra").Value
                        .Fields("Partida").Value = ""
                        .Fields("Cantidad").Value = 1

                        If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                            .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                        Else
                            .Fields("IdUnidad").Value = mvarIdUnidadCU
                        End If

                        If IsNumeric(dcfields(0).BoundText) Then
                            .Fields("IdObra").Value = dcfields(0).BoundText
                        End If

                        .Fields("Adjunto").Value = "NO"
                        .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacionStandar").Value
                        .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                        .Fields("CotizacionMoneda").Value = 1
                        .Fields("IdMoneda").Value = mvarIdMonedaPesos
                        .Fields("CostoUnitario").Value = oRs.Fields("CostoPPP").Value
                    End With

                    .Modificado = True
                End With

                Set Lista.DataSource = origen.DetProduccionOrdenes.RegistrosConFormato
            End If

            oRs.Close
        End If

        Set oRs = Nothing
        mCadena = ""
    ElseIf KeyAscii = 27 And mvarModoCodigoBarra Then
        mvarModoCodigoBarra = False

        DoEvents
        mCadena = ""
    End If

End Sub

Private Sub Form_KeyUp(KeyCode As Integer, _
                       Shift As Integer)

    'F12 para inicializar el modo ingreso por codigo de barras
    If KeyCode = 123 Then
        mvarModoCodigoBarra = True

        DoEvents
    ElseIf KeyCode = 27 And mvarModoCodigoBarra Then
        mCadena = ""
        mvarModoCodigoBarra = False

        DoEvents
    End If

End Sub

Private Sub Form_Load()

    Dim oI As ListImage
   
    With Lista
        Set .SmallIcons = Img16
        .IconoPequeño = "Original"
    End With
      
    With ListaProcesos
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

Private Sub Form_OLEDragDrop(Data As DataObject, _
                             Effect As Long, _
                             Button As Integer, _
                             Shift As Integer, _
                             X As Single, _
                             y As Single)
    
    Exit Sub

    If mvarId > 0 Then
        MsgBox "No puede modificar una salida ya registrada!", vbCritical
        Exit Sub
    End If
      
    Dim s As String
    Dim Filas
    Dim Columnas
    Dim iFilas As Long, iColumnas As Long, i As Long, j As Long
    Dim mvarIdDeposito As Long, mvarIdUbicacion As Long
    Dim mCostoATomar As String, mNumeroInventario As String
    Dim oL As ListItem
    Dim oAp As ComPronto.Aplicacion
    Dim oVal As ComPronto.ValeSalida
    Dim oRsVal As ADOR.Recordset
    Dim oRsDet As ADOR.Recordset
    Dim oRsAux As ADOR.Recordset
    Dim oRsAux1 As ADOR.Recordset

    mvarIdDeposito = 0

    If dcfields(14).Visible Then
        If Not IsNumeric(dcfields(14).BoundText) Then
            MsgBox "Indique primero el origen!", vbCritical
            Exit Sub
        Else
            mvarIdDeposito = dcfields(14).BoundText
            mvarIdUbicacion = 0
            Set oRsAux = Aplicacion.Ubicaciones.TraerFiltrado("_PorObra", Array(-1, mvarIdDeposito))

            If oRsAux.RecordCount = 1 Then mvarIdUbicacion = oRsAux.Fields(0).Value
            oRsAux.Close
        End If
    End If
   
    If Data.GetFormat(ccCFText) Then
      
        s = Data.GetData(ccCFText)
        Filas = Split(s, vbCrLf)
      
        Columnas = Split(Filas(0), vbTab)
      
        If UBound(Columnas) < 2 Then
            MsgBox "No hay informacion para copiar", vbCritical
            Exit Sub
        End If
      
        mCostoATomar = BuscarClaveINI("Costo para salida de materiales")

        If mCostoATomar = "" Then mCostoATomar = "CostoReposicion"
      
        If Columnas(1) = "Vale" Then
      
            For iFilas = 1 To UBound(Filas)
                Columnas = Split(Filas(iFilas), vbTab)
         
                Set oRsAux = Aplicacion.ValesSalida.TraerFiltrado("_PorId", Columnas(4))
                Set oRsVal = Aplicacion.TablasGenerales.TraerFiltrado("DetValesSalida", "Res", Columnas(4))
                  
                With origen.Registro
                    .Fields("IdObra").Value = oRsAux.Fields("IdObra").Value
                    .Fields("ValePreimpreso").Value = oRsAux.Fields("NumeroValePreimpreso").Value
                End With
            
                If oRsVal.RecordCount > 0 Then
                    oRsVal.MoveFirst

                    Do While Not oRsVal.EOF

                        If (IsNull(oRsVal.Fields("Cumplido").Value) Or oRsVal.Fields("Cumplido").Value <> "SI") And (IsNull(oRsVal.Fields("Estado").Value) Or oRsVal.Fields("Estado").Value <> "AN") Then
                            Set oRsDet = Aplicacion.TablasGenerales.TraerFiltrado("DetValesSalida", "_TodoMasPendientePorIdDetalle", oRsVal.Fields(0).Value)
                              
                            With origen.DetProduccionOrdenes.Item(-1)

                                For i = 2 To oRsDet.Fields.Count - 1
                                    For j = 2 To .Registro.Fields.Count - 1

                                        If .Registro.Fields(j).Name = oRsDet.Fields(i).Name Then
                                            .Registro.Fields(j).Value = oRsDet.Fields(i).Value
                                            Exit For
                                        End If

                                    Next
                                Next

                                With .Registro
                                    .Fields("IdDetalleValeSalida").Value = oRsDet.Fields("IdDetalleValeSalida").Value
                                    .Fields("Partida").Value = ""
                                    .Fields("IdObra").Value = oRsAux.Fields("IdObra").Value
                                    .Fields("Cantidad").Value = oRsDet.Fields("Pendiente").Value
                                    .Fields("Adjunto").Value = "NO"

                                    If mvarIdDepositoCentral = mvarIdDeposito Or mvarIdDeposito = 0 Then
                                        .Fields("IdUbicacion").Value = oRsDet.Fields("IdUbicacionStandar").Value
                                    Else

                                        If mvarIdUbicacion <> 0 Then .Fields("IdUbicacion").Value = mvarIdUbicacion
                                    End If

                                    .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                                    .Fields("CotizacionMoneda").Value = 1
                                    .Fields("IdMoneda").Value = mvarIdMonedaPesos
                                    .Fields("Observaciones").Value = oRsDet.Fields("ObservacionesRequerimiento").Value
                                    Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdArticulo").Value)
                                    mNumeroInventario = ""

                                    If oRsAux1.RecordCount > 0 Then
                                        If Right(IIf(IsNull(oRsAux1.Fields("Codigo").Value), "0000", oRsAux1.Fields("Codigo").Value), 4) = "9999" Then
                                            .Fields("CostoUnitario").Value = oRsDet.Fields("CostoRecepcion").Value
                                            .Fields("IdMoneda").Value = oRsDet.Fields("IdMonedaRecepcion").Value
                                            .Fields("CotizacionMoneda").Value = Cotizacion(Date, oRsDet.Fields("IdMonedaRecepcion").Value)
                                        Else

                                            If mCostoATomar = "CostoReposicion" Then
                                                .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoReposicion").Value
                                            Else
                                                .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoPPP").Value
                                            End If
                                        End If

                                        If Not IsNull(oRsDet.Fields("IdEquipoDestino").Value) Then
                                            oRsAux1.Close
                                            Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdEquipoDestino").Value)

                                            If oRsAux1.RecordCount > 0 Then
                                                mNumeroInventario = IIf(IsNull(oRsAux1.Fields("NumeroInventario").Value), "", oRsAux1.Fields("NumeroInventario").Value)
                                            End If
                                        End If
                                    End If

                                    oRsAux1.Close

                                    If Len(mNumeroInventario) > 0 Then
                                        Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorNumeroInventario", mNumeroInventario)

                                        If oRsAux1.RecordCount > 0 Then
                                            .Fields("IdEquipoDestino").Value = oRsAux1.Fields(0).Value
                                        End If

                                        oRsAux1.Close
                                    End If

                                    .Fields("DescargaPorKit").Value = mDescargaPorKit
                                End With

                                .Modificado = True
                            End With

                            oRsDet.Close
                        End If

                        oRsVal.MoveNext
                    Loop

                End If

                oRsAux.Close
            Next

            Set Lista.DataSource = origen.DetProduccionOrdenes.RegistrosConFormato
         
        ElseIf Columnas(1) = "Vale (Det.)" Then
      
            For iFilas = 1 To UBound(Filas)
                Columnas = Split(Filas(iFilas), vbTab)
            
                Set oRsAux = Aplicacion.ValesSalida.TraerFiltrado("_PorId", Columnas(8))
                Set oRsVal = Aplicacion.TablasGenerales.TraerUno("DetValesSalida", CLng(Columnas(12)))
            
                With origen.Registro
                    .Fields("IdObra").Value = oRsAux.Fields("IdObra").Value
                    .Fields("ValePreimpreso").Value = oRsAux.Fields("NumeroValePreimpreso").Value
                End With
            
                Do While Not oRsVal.EOF
                    Set oRsDet = Aplicacion.TablasGenerales.TraerFiltrado("DetValesSalida", "_TodoMasPendientePorIdDetalle", oRsVal.Fields(0).Value)

                    With origen.DetProduccionOrdenes.Item(-1)

                        For i = 2 To oRsDet.Fields.Count - 1
                            For j = 2 To .Registro.Fields.Count - 1

                                If .Registro.Fields(j).Name = oRsDet.Fields(i).Name Then
                                    .Registro.Fields(j).Value = oRsDet.Fields(i).Value
                                    Exit For
                                End If

                            Next
                        Next

                        With .Registro
                            .Fields("IdDetalleValeSalida").Value = oRsDet.Fields("IdDetalleValeSalida").Value
                            .Fields("Partida").Value = ""
                            .Fields("IdObra").Value = oRsAux.Fields("IdObra").Value
                            .Fields("Cantidad").Value = oRsDet.Fields("Pendiente").Value
                            .Fields("Adjunto").Value = "NO"

                            If mvarIdDepositoCentral = mvarIdDeposito Or mvarIdDeposito = 0 Then
                                .Fields("IdUbicacion").Value = oRsDet.Fields("IdUbicacionStandar").Value
                            Else

                                If mvarIdUbicacion <> 0 Then .Fields("IdUbicacion").Value = mvarIdUbicacion
                            End If

                            .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                            .Fields("CotizacionMoneda").Value = 1
                            .Fields("IdMoneda").Value = mvarIdMonedaPesos
                            .Fields("Observaciones").Value = oRsDet.Fields("ObservacionesRequerimiento").Value
                            Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdArticulo").Value)
                            mNumeroInventario = ""

                            If oRsAux1.RecordCount > 0 Then
                                If Right(IIf(IsNull(oRsAux1.Fields("Codigo").Value), "0000", oRsAux1.Fields("Codigo").Value), 4) = "9999" Then
                                    .Fields("CostoUnitario").Value = oRsDet.Fields("CostoRecepcion").Value
                                    .Fields("IdMoneda").Value = oRsDet.Fields("IdMonedaRecepcion").Value
                                    .Fields("CotizacionMoneda").Value = Cotizacion(Date, oRsDet.Fields("IdMonedaRecepcion").Value)
                                Else

                                    If mCostoATomar = "CostoReposicion" Then
                                        .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoReposicion").Value
                                    Else
                                        .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoPPP").Value
                                    End If
                                End If

                                If Not IsNull(oRsDet.Fields("IdEquipoDestino").Value) Then
                                    oRsAux1.Close
                                    Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdEquipoDestino").Value)

                                    If oRsAux1.RecordCount > 0 Then
                                        mNumeroInventario = IIf(IsNull(oRsAux1.Fields("NumeroInventario").Value), "", oRsAux1.Fields("NumeroInventario").Value)
                                    End If
                                End If
                            End If

                            oRsAux1.Close

                            If Len(mNumeroInventario) > 0 Then
                                Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorNumeroInventario", mNumeroInventario)

                                If oRsAux1.RecordCount > 0 Then
                                    .Fields("IdEquipoDestino").Value = oRsAux1.Fields(0).Value
                                End If

                                oRsAux1.Close
                            End If

                            .Fields("DescargaPorKit").Value = mDescargaPorKit
                        End With

                        .Modificado = True
                    End With

                    oRsDet.Close
                    oRsVal.MoveNext
                Loop

                oRsAux.Close
            Next

            Set Lista.DataSource = origen.DetProduccionOrdenes.RegistrosConFormato
         
        ElseIf Columnas(1) = "Codigo material" Then
      
            For iFilas = LBound(Filas) + 1 To UBound(Filas)
                Columnas = VBA.Split(Filas(iFilas), vbTab)

                With origen.DetProduccionOrdenes.Item(-1)
                    With .Registro
                        .Fields("IdArticulo").Value = Columnas(3)
                        .Fields("IdUnidad").Value = mvarIdUnidadCU
                        .Fields("Partida").Value = ""
                        .Fields("IdObra").Value = origen.Registro.Fields("IdObra").Value
                        .Fields("Cantidad").Value = 1
                        .Fields("Adjunto").Value = "NO"
                        .Fields("IdUbicacion").Value = 1
                        .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                        .Fields("CotizacionMoneda").Value = 1
                        .Fields("IdMoneda").Value = mvarIdMonedaPesos
                        Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorId", Columnas(3))

                        If oRsAux1.RecordCount > 0 Then
                            If mCostoATomar = "CostoReposicion" Then
                                .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoReposicion").Value
                            Else
                                .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoPPP").Value
                            End If
                        End If

                        oRsAux1.Close
                        .Fields("DescargaPorKit").Value = mDescargaPorKit
                    End With

                    .Modificado = True
                End With

            Next
         
            Set Lista.DataSource = origen.DetProduccionOrdenes.RegistrosConFormato
         
        ElseIf Columnas(1) = "Nro.recep.alm." Then
      
            For iFilas = LBound(Filas) + 1 To UBound(Filas)
                Columnas = VBA.Split(Filas(iFilas), vbTab)
                Set oRsDet = Aplicacion.TablasGenerales.TraerFiltrado("Recepciones", "_DetallesPorIdRecepcion", Columnas(12))

                If oRsDet.RecordCount > 0 Then
                    oRsDet.MoveFirst

                    Do While Not oRsDet.EOF

                        With origen.DetProduccionOrdenes.Item(-1)
                            With .Registro
                                .Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                                .Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                                .Fields("Partida").Value = oRsDet.Fields("Partida").Value
                                .Fields("IdObra").Value = origen.Registro.Fields("IdObra").Value
                                .Fields("Cantidad").Value = oRsDet.Fields("Cantidad").Value
                                .Fields("Adjunto").Value = "NO"
                                .Fields("IdUbicacion").Value = oRsDet.Fields("IdUbicacion").Value
                                .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                                .Fields("CotizacionMoneda").Value = 1
                                .Fields("IdMoneda").Value = mvarIdMonedaPesos
                                Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdArticulo").Value)

                                If oRsAux1.RecordCount > 0 Then
                                    If Right(IIf(IsNull(oRsAux1.Fields("Codigo").Value), "0000", oRsAux1.Fields("Codigo").Value), 4) = "9999" Then
                                        .Fields("CostoUnitario").Value = oRsDet.Fields("CostoUnitario").Value
                                    Else

                                        If mCostoATomar = "CostoReposicion" Then
                                            .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoReposicion").Value
                                        Else
                                            .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoPPP").Value
                                        End If
                                    End If
                                End If

                                oRsAux1.Close

                                If Not IsNull(oRsDet.Fields("IdDetalleRequerimiento").Value) Then
                                    Set oRsAux1 = Aplicacion.Requerimientos.TraerFiltrado("_DatosRequerimiento", oRsDet.Fields("IdDetalleRequerimiento").Value)

                                    If oRsAux1.RecordCount > 0 Then
                                        .Fields("IdOrdenTrabajo").Value = oRsAux1.Fields("IdOrdenTrabajo").Value
                                    End If

                                    oRsAux1.Close
                                End If

                                .Fields("DescargaPorKit").Value = mDescargaPorKit
                            End With

                            .Modificado = True
                        End With

                        oRsDet.MoveNext
                    Loop

                End If

                oRsDet.Close
            Next
         
            Set Lista.DataSource = origen.DetProduccionOrdenes.RegistrosConFormato
         
        Else
         
            MsgBox "Informacion invalida!", vbCritical
      
        End If
      
        Set oRsDet = Nothing
        Set oRsVal = Nothing
        Set oRsAux = Nothing
        Set oRsAux1 = Nothing
        Set oVal = Nothing
        Set oAp = Nothing
            
    End If

End Sub

Private Sub Form_OLEDragOver(Data As DataObject, _
                             Effect As Long, _
                             Button As Integer, _
                             Shift As Integer, _
                             X As Single, _
                             y As Single, _
                             State As Integer)

    Dim s As String
    Dim Filas, Columnas
    Dim iFilas As Long, iColumnas As Long
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

Private Sub Form_OLEGiveFeedback(Effect As Long, _
                                 DefaultCursors As Boolean)

    If Effect = vbDropEffectNone Then
        DefaultCursors = False
    End If

End Sub

Private Sub Form_Paint()

    ''Degradado Me
   
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

Private Sub Lista_KeyUp(KeyCode As Integer, _
                        Shift As Integer)
   
    If KeyCode = vbKeyDelete Then
        MnuDetA_Click 2
    ElseIf KeyCode = vbKeyInsert Then
        MnuDetA_Click 0
    ElseIf KeyCode = vbKeySpace Then
        MnuDetA_Click 1
    End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, _
                          Shift As Integer, _
                          X As Single, _
                          y As Single)

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

Private Sub ListaProcesos_DblClick()

    If ListaProcesos.ListItems.Count = 0 Then
        EditarProcesos -1
    Else
        EditarProcesos ListaProcesos.SelectedItem.Tag
    End If

End Sub

Private Sub ListaProcesos_FinCarga()

    CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaProcesos_KeyUp(KeyCode As Integer, _
                                Shift As Integer)
   
    If KeyCode = vbKeyDelete Then
        MnuDetProcA_Click 2
    ElseIf KeyCode = vbKeyInsert Then
        MnuDetProcA_Click 0
    ElseIf KeyCode = vbKeySpace Then
        MnuDetProcA_Click 1
    End If

End Sub

Private Sub ListaProcesos_MouseUp(Button As Integer, _
                                  Shift As Integer, _
                                  X As Single, _
                                  y As Single)

    If Button = vbRightButton Then
        If ListaProcesos.ListItems.Count = 0 Then
            MnuDetProcA(1).Enabled = False
            MnuDetProcA(2).Enabled = False
            PopupMenu MnuDetProc, , , , MnuDetProcA(0)
        Else
            MnuDetProcA(1).Enabled = True
            MnuDetProcA(2).Enabled = True
            PopupMenu MnuDetProc, , , , MnuDetProcA(1)
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

            'If mvarId > 0 Then
            '   MsgBox "No puede modificar un vale ya registrado!", vbCritical
            '   Exit Sub
            'End If
            With Lista.SelectedItem
                origen.DetProduccionOrdenes.Item(.Tag).Eliminado = True
                .SmallIcon = "Eliminado"
                .ToolTipText = .SmallIcon
            End With

            mvarNoAnular = True

        Case 3
            AsignarDetalles
    End Select

End Sub

Private Sub MnuDetProcA_Click(Index As Integer)

    Select Case Index

        Case 0
            EditarProcesos -1

        Case 1
            EditarProcesos ListaProcesos.SelectedItem.Tag

        Case 2

            'If mvarId > 0 Then
            '   MsgBox "No puede modificar un vale ya registrado!", vbCritical
            '   Exit Sub
            'End If
            With ListaProcesos.SelectedItem
                origen.DetProduccionOrdenesProcesos.Item(.Tag).Eliminado = True
                .SmallIcon = "Eliminado"
                .ToolTipText = .SmallIcon
            End With

            mvarNoAnular = True
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

Private Sub txtChofer_KeyPress(KeyAscii As Integer)

    If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCliente_GotFocus()

    'With txtCliente
    '   .SelStart = 0
    '   .SelLength = Len(.Text)
    'End With

End Sub

Private Sub txtCliente_KeyPress(KeyAscii As Integer)

    If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCodigoEquipo_KeyPress(KeyAscii As Integer)

    If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtNumeroProduccionOrden_KeyPress(KeyAscii As Integer)

    If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub PideAutorizacionEmitio()

    Dim oF As frmAutorizacion1
    Set oF = New frmAutorizacion1

    With oF
        .IdUsuario = dcfields(4).BoundText
        .Show vbModal, Me
    End With

    If Not oF.Ok Then

        With origen.Registro
            .Fields(dcfields(4).DataField).Value = Null
            '         .Fields("FechaAprobacion").Value = Null
        End With

        Check1(0).Value = 0
        mIdAprobo = 0
    Else

        With origen.Registro
            '         .Fields("FechaAprobacion").Value = Now
            mIdAprobo = IIf(IsNull(.Fields("Emitio").Value), 0, .Fields("Emitio").Value)
            origen.Registro.Fields("Programada").Value = "SI"
      
        End With

        Check1(0).Value = 1
    End If

    Unload oF
    Set oF = Nothing

End Sub

Private Sub PideAutorizacionAprobo()

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

        Check1(0).Value = 0
        mIdAprobo = 0
    Else

        With origen.Registro
            '         .Fields("FechaAprobacion").Value = Now
            mIdAprobo = IIf(IsNull(.Fields("Aprobo").Value), 0, .Fields("Aprobo").Value)
            'origen.Registro.Fields("Confirmado").Value = "SI"
      
        End With

        Check1(0).Value = 1
    End If

    Unload oF
    Set oF = Nothing

End Sub

Private Sub PideAutorizacionCerro()

    Dim oF As frmAutorizacion1
    Set oF = New frmAutorizacion1

    With oF
        .IdUsuario = dcfields(15).BoundText
        .Show vbModal, Me
    End With

    If Not oF.Ok Then

        With origen.Registro
            .Fields(dcfields(15).DataField).Value = Null
            '         .Fields("FechaAprobacion").Value = Null
        End With

        Check1(0).Value = 0
        mIdAprobo = 0
    Else

        With origen.Registro
            '         .Fields("FechaAprobacion").Value = Now
            mIdAprobo = IIf(IsNull(.Fields("Cerro").Value), 0, .Fields("Cerro").Value)
            origen.Registro.Fields("Confirmado").Value = "SI"
      
        End With

        Check1(0).Value = 1
    End If

    Unload oF
    Set oF = Nothing

End Sub

Public Sub AnularOrden()
    Dim mvarSale As Integer
    Dim mIdAutorizo As Long
    
    'mvarSale = MsgBox("Esta seguro de anular la OP ?", vbYesNo, "Anulacion")
    'If mvarSale = vbNo Then
    '   Exit Sub
    'End If
    
    Dim oF As Form
    Set oF = New frmAutorizacion

    With oF
        .Empleado = 0
        .Administradores = True
        '.SuperAdministrador = True
        '.IdFormulario = 70
        .IdFormulario = 0 'EnumFormularios.Remitos '.OrdenesCompra

        .Show vbModal, Me
    End With

    If Not oF.Ok Then
        MsgBox "No puede anular la OP!", vbExclamation
        'Unload oF
        Set oF = Nothing
        Exit Sub
    End If

    mIdAutorizo = oF.IdAutorizo
    Unload oF
    Set oF = Nothing

    With origen
        .Registro.Fields("Anulada").Value = "SI"
        '.Registro.Fields("IdUsuarioAnulo").Value = mIdAutorizaAnulacion
        '.Registro.Fields("FechaAnulacion").Value = Now
        '.Registro.Fields("MotivoAnulacion").Value = mMotivoAnulacion
        .Guardar
    End With

    Unload Me

End Sub

Public Sub AnularSalida()

    If mvarNoAnular Then
        MsgBox "Para anular una salida, no debe realizar ninguna operacion con los items" & vbCrLf & "previamente a la anulacion, vuelva a llamar la salida y anule directamente", vbInformation
        Exit Sub
    End If
   
    Dim oF As frmAutorizacion
    Dim mOk As Boolean
    Dim mUsuario As String
    Dim mIdAutorizaAnulacion As Integer
    Set oF = New frmAutorizacion

    With oF
        .Empleado = 0
        '.IdFormulario = EnumFormularios.ProduccionOrden
        '.Administradores = True
        .Show vbModal, Me
        mOk = .Ok
        mIdAutorizaAnulacion = .IdAutorizo
        mUsuario = .Autorizo
    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then
        Exit Sub
    End If

    Me.Refresh
   
    Dim mSeguro As Integer
    mSeguro = MsgBox("Esta seguro de anular la salida?", vbYesNo, "Anulacion de salida")

    If mSeguro = vbNo Then
        Exit Sub
    End If

    Dim of1 As frmAnulacion
    Dim mMotivoAnulacion As String
    Set of1 = New frmAnulacion
    mMotivoAnulacion = of1.rchAnulacion.Text
    Unload of1
    Set of1 = Nothing

    If Not mOk Then
        MsgBox "Anulacion cancelada!", vbExclamation
        Exit Sub
    End If

    Me.Refresh
   
    With origen
        .Registro.Fields("Anulada").Value = "SI"
        .Registro.Fields("IdUsuarioAnulo").Value = mIdAutorizaAnulacion
        .Registro.Fields("FechaAnulacion").Value = Now
        .Registro.Fields("MotivoAnulacion").Value = mMotivoAnulacion
        .Guardar
    End With

    Aplicacion.Tarea "ProduccionOrdenes_AjustarStockProduccionOrdenAnulada", mvarId
   
    With actL2
        .ListaEditada = "OrdendeProduccion"
        .AccionRegistro = Modificacion
        .Disparador = origen.Registro.Fields(0).Value
    End With
   
    Unload Me

End Sub

Public Sub AsignarDetalles()

    Dim iFilas As Integer
    Dim mIdUbicacion As Long, mIdEquipoDestino As Long, mIdOrdenTrabajo As Long, mIdDetalleObraDestino As Long
    Dim mOk As Boolean
    Dim Filas, Columnas
    Dim oF As frm_Aux
    Dim oDet As DetProduccionOrden
    Dim oDetproc As DetProdOrdenProceso
    Dim oRs As ADOR.Recordset
   
    Set oF = New frm_Aux

    With oF
        .Caption = "Asignacion de EQ, OT y UB"

        With .Label2(0)
            .Caption = "Ubicacion :"
            .Visible = True
        End With

        With .dcfields(0)
            .TOp = oF.DTFields(0).TOp
            .Left = oF.DTFields(0).Left
            .Width = oF.DTFields(0).Width * 2
            .BoundColumn = "IdUbicacion"
            Set .RowSource = Aplicacion.Ubicaciones.TraerLista
            .Visible = True
        End With

        With .Label1
            .Caption = "Equipo destino :"
            .Visible = True
        End With

        With .dcfields(1)
            .Width = oF.DTFields(0).Width * 2
            .BoundColumn = "IdArticulo"

            If IsNumeric(dcfields(0).BoundText) Then
                Set oRs = Aplicacion.Articulos.TraerFiltrado("_ParaMantenimiento_ParaCombo", Array(0, dcfields(0).BoundText))

                If oRs.RecordCount = 0 Then
                    Set oRs = Aplicacion.Articulos.TraerFiltrado("_ParaMantenimiento_ParaCombo", Array(0, 0))
                End If
            End If

            Set .RowSource = oRs
            Set oRs = Nothing
            .Visible = True
        End With

        With .Label2(1)
            .Caption = "Ord.Trabajo :"
            .Visible = True
        End With

        With .dcfields(2)
            .TOp = oF.DTFields(1).TOp
            .Left = oF.DTFields(1).Left
            .Width = oF.DTFields(0).Width * 2
            .BoundColumn = "IdOrdenTrabajo"
            Set .RowSource = Aplicacion.OrdenesTrabajo.TraerLista
            .Visible = True
        End With

        .Width = .Width * 1.5
        .Show vbModal, Me
        mOk = .Ok
        mIdUbicacion = 0

        If IsNumeric(.dcfields(0).BoundText) Then mIdUbicacion = .dcfields(0).BoundText
        mIdEquipoDestino = 0

        If IsNumeric(.dcfields(1).BoundText) Then mIdEquipoDestino = .dcfields(1).BoundText
        mIdDetalleObraDestino = 0
        Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorIdConDatos", mIdEquipoDestino)

        If oRs.RecordCount > 0 Then
            mIdDetalleObraDestino = IIf(IsNull(oRs.Fields("IdDetalleObraDestino").Value), 0, oRs.Fields("IdDetalleObraDestino").Value)
        End If

        oRs.Close
        mIdOrdenTrabajo = 0

        If IsNumeric(.dcfields(2).BoundText) Then mIdOrdenTrabajo = .dcfields(2).BoundText
    End With

    Unload oF
    Set oF = Nothing
   
    If Not mOk Then Exit Sub
   
    Me.MousePointer = vbHourglass

    DoEvents
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
        Set oDet = origen.DetProduccionOrdenes.Item(Columnas(0))

        With oDet
            With .Registro

                If mIdUbicacion > 0 Then .Fields("IdUbicacion").Value = mIdUbicacion
                If mIdEquipoDestino > 0 Then .Fields("IdEquipoDestino").Value = mIdEquipoDestino
                If mIdOrdenTrabajo > 0 Then .Fields("IdOrdenTrabajo").Value = mIdOrdenTrabajo
                If mIdDetalleObraDestino > 0 Then .Fields("IdDetalleObraDestino").Value = mIdDetalleObraDestino
            End With

            .Modificado = True
        End With

        Set oDet = Nothing
    Next

    Set Lista.DataSource = origen.DetProduccionOrdenes.RegistrosConFormato

    Me.MousePointer = vbDefault

    DoEvents

End Sub
