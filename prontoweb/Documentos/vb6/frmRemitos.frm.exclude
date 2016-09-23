VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmRemitos 
   Caption         =   "Remito"
   ClientHeight    =   8055
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11895
   Icon            =   "frmRemitos.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   8055
   ScaleWidth      =   11895
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdImpre 
      Caption         =   "Rom."
      Height          =   375
      Index           =   2
      Left            =   1800
      Picture         =   "frmRemitos.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   71
      Top             =   5985
      Visible         =   0   'False
      Width           =   660
   End
   Begin VB.TextBox txtCodigoEquipo 
      Alignment       =   2  'Center
      Height          =   315
      Left            =   7785
      TabIndex        =   62
      Top             =   1620
      Visible         =   0   'False
      Width           =   1005
   End
   Begin VB.TextBox txtCOT 
      DataField       =   "COT"
      Height          =   285
      Left            =   10215
      TabIndex        =   60
      Top             =   1980
      Width           =   1575
   End
   Begin VB.TextBox txtOrdenCompra 
      DataField       =   "OrdenCompra"
      Height          =   285
      Left            =   10530
      TabIndex        =   58
      Top             =   2700
      Width           =   1275
   End
   Begin VB.TextBox txtOrdenCarga 
      DataField       =   "OrdenCarga"
      Height          =   285
      Left            =   7785
      TabIndex        =   56
      Top             =   2700
      Width           =   1275
   End
   Begin VB.TextBox txtNumeroDocumento 
      DataField       =   "NumeroDocumento"
      Height          =   285
      Left            =   9975
      TabIndex        =   54
      Top             =   2340
      Width           =   1815
   End
   Begin VB.TextBox txtChofer 
      DataField       =   "Chofer"
      Height          =   285
      Left            =   7785
      TabIndex        =   53
      Top             =   2340
      Width           =   2130
   End
   Begin VB.TextBox txtPatente 
      DataField       =   "Patente"
      Height          =   285
      Left            =   7785
      TabIndex        =   51
      Top             =   1980
      Width           =   1950
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Anular"
      Enabled         =   0   'False
      Height          =   375
      Index           =   2
      Left            =   90
      TabIndex        =   45
      Top             =   7335
      Width           =   1380
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      DataField       =   "ValorDeclarado"
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
      Left            =   8010
      TabIndex        =   40
      Top             =   5940
      Width           =   1365
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      DataField       =   "TotalBultos"
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
      Left            =   10665
      TabIndex        =   38
      Top             =   5940
      Width           =   1140
   End
   Begin VB.Frame Frame1 
      Caption         =   "Tipo de destino : "
      Height          =   735
      Left            =   6255
      TabIndex        =   31
      Top             =   45
      Width           =   5595
      Begin VB.OptionButton Option6 
         Caption         =   "Traslado"
         Height          =   240
         Left            =   3645
         TabIndex        =   48
         Top             =   450
         Width           =   1815
      End
      Begin VB.OptionButton Option5 
         Caption         =   "A prestamo"
         Height          =   240
         Left            =   1395
         TabIndex        =   42
         Top             =   450
         Width           =   1320
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Muestra"
         Height          =   195
         Left            =   90
         TabIndex        =   35
         Top             =   495
         Width           =   870
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Con cargo devolución"
         Height          =   195
         Left            =   3645
         TabIndex        =   34
         Top             =   225
         Width           =   1860
      End
      Begin VB.OptionButton Option2 
         Caption         =   "A proveedor para fabricar"
         Height          =   195
         Left            =   1395
         TabIndex        =   33
         Top             =   225
         Width           =   2130
      End
      Begin VB.OptionButton Option1 
         Caption         =   "A Facturar"
         Height          =   195
         Left            =   90
         TabIndex        =   32
         Top             =   225
         Width           =   1095
      End
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   375
      Index           =   1
      Left            =   810
      Picture         =   "frmRemitos.frx":0CF4
      Style           =   1  'Graphical
      TabIndex        =   14
      Top             =   6885
      Width           =   660
   End
   Begin VB.TextBox txtCodigo 
      Alignment       =   1  'Right Justify
      Height          =   315
      Left            =   1980
      TabIndex        =   13
      Top             =   495
      Width           =   795
   End
   Begin VB.TextBox txtCondicionIva 
      Enabled         =   0   'False
      Height          =   330
      Left            =   7785
      TabIndex        =   12
      Top             =   870
      Width           =   1575
   End
   Begin VB.TextBox txtCodigoPostal 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   315
      Left            =   1980
      TabIndex        =   11
      Top             =   1215
      Width           =   750
   End
   Begin VB.TextBox txtProvincia 
      Enabled         =   0   'False
      Height          =   315
      Left            =   4680
      TabIndex        =   10
      Top             =   1215
      Width           =   1395
   End
   Begin VB.TextBox txtLocalidad 
      Enabled         =   0   'False
      Height          =   315
      Left            =   2745
      TabIndex        =   9
      Top             =   1215
      Width           =   1920
   End
   Begin VB.TextBox txtDireccion 
      Enabled         =   0   'False
      Height          =   315
      Left            =   1980
      TabIndex        =   8
      Top             =   855
      Width           =   4095
   End
   Begin VB.TextBox txtCuit 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   315
      Left            =   10215
      TabIndex        =   7
      Top             =   900
      Width           =   1575
   End
   Begin VB.TextBox txtNumeroRemito 
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
      Height          =   330
      Left            =   2835
      TabIndex        =   6
      Top             =   45
      Width           =   855
   End
   Begin VB.TextBox txtEmail 
      Enabled         =   0   'False
      Height          =   330
      Left            =   9765
      TabIndex        =   5
      Top             =   1245
      Width           =   2025
   End
   Begin VB.TextBox txtFax 
      Enabled         =   0   'False
      Height          =   330
      Left            =   8955
      TabIndex        =   4
      Top             =   1245
      Width           =   810
   End
   Begin VB.TextBox txtTelefono 
      Enabled         =   0   'False
      Height          =   330
      Left            =   7785
      TabIndex        =   3
      Top             =   1245
      Width           =   1215
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   375
      Index           =   0
      Left            =   90
      Picture         =   "frmRemitos.frx":127E
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   6885
      UseMaskColor    =   -1  'True
      Width           =   660
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   375
      Index           =   1
      Left            =   90
      TabIndex        =   1
      Top             =   6435
      Width           =   1380
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   375
      Index           =   0
      Left            =   90
      TabIndex        =   0
      Top             =   5985
      Width           =   1380
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaRemito"
      Height          =   330
      Index           =   0
      Left            =   4770
      TabIndex        =   15
      Top             =   45
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Enabled         =   0   'False
      Format          =   57409537
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCliente"
      Height          =   315
      Index           =   0
      Left            =   2835
      TabIndex        =   16
      Tag             =   "Clientes"
      Top             =   495
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
      Left            =   1980
      TabIndex        =   17
      Tag             =   "CondicionesCompra"
      Top             =   1935
      Width           =   4110
      _ExtentX        =   7250
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdCondicionCompra"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1230
      Left            =   1575
      TabIndex        =   18
      Top             =   6480
      Width           =   5145
      _ExtentX        =   9075
      _ExtentY        =   2170
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmRemitos.frx":18E8
   End
   Begin Controles1013.DbListView Lista 
      Height          =   2850
      Left            =   45
      TabIndex        =   19
      Top             =   3060
      Width           =   11805
      _ExtentX        =   20823
      _ExtentY        =   5027
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmRemitos.frx":196A
      OLEDropMode     =   1
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   1035
      Top             =   7245
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
            Picture         =   "frmRemitos.frx":1986
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRemitos.frx":1A98
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRemitos.frx":1EEA
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRemitos.frx":233C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdTransportista"
      Height          =   315
      Index           =   2
      Left            =   1980
      TabIndex        =   36
      Tag             =   "Transportistas"
      Top             =   2295
      Width           =   4110
      _ExtentX        =   7250
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTransportista"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   3
      Left            =   2880
      TabIndex        =   43
      Tag             =   "Proveedores"
      Top             =   5940
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservacionesItem 
      Height          =   240
      Left            =   6255
      TabIndex        =   44
      Top             =   5985
      Visible         =   0   'False
      Width           =   150
      _ExtentX        =   265
      _ExtentY        =   423
      _Version        =   393217
      TextRTF         =   $"frmRemitos.frx":278E
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdPuntoVenta"
      Height          =   315
      Index           =   10
      Left            =   2025
      TabIndex        =   47
      Tag             =   "PuntosVenta"
      Top             =   45
      Width           =   780
      _ExtentX        =   1376
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPuntoVenta"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservacionesItemVisible 
      Height          =   1230
      Left            =   6795
      TabIndex        =   49
      Top             =   6480
      Width           =   5055
      _ExtentX        =   8916
      _ExtentY        =   2170
      _Version        =   393217
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmRemitos.frx":2819
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdEquipo"
      Height          =   315
      Index           =   5
      Left            =   8820
      TabIndex        =   63
      Tag             =   "ArticulosEquipos"
      Top             =   1620
      Visible         =   0   'False
      Width           =   2985
      _ExtentX        =   5265
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   4
      Left            =   1980
      TabIndex        =   65
      Tag             =   "Obras"
      Top             =   2655
      Width           =   2310
      _ExtentX        =   4075
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdListaPrecios"
      Height          =   315
      Index           =   7
      Left            =   4860
      TabIndex        =   67
      Tag             =   "ListasPrecios"
      Top             =   2655
      Width           =   1230
      _ExtentX        =   2170
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdListaPrecios"
      Text            =   ""
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   70
      Top             =   7770
      Width           =   11895
      _ExtentX        =   20981
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   4410
            MinWidth        =   4410
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdDetalleClienteLugarEntrega"
      Height          =   315
      Index           =   6
      Left            =   1980
      TabIndex        =   72
      Tag             =   "DetalleClientesLugaresEntrega"
      Top             =   1575
      Visible         =   0   'False
      Width           =   4110
      _ExtentX        =   7250
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdDetalleClienteLugarEntrega"
      Text            =   ""
   End
   Begin VB.Label lblEstado1 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
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
      Left            =   10215
      TabIndex        =   46
      Top             =   6255
      Visible         =   0   'False
      Width           =   1590
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
      Left            =   3600
      TabIndex        =   69
      Top             =   6300
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.Label lblData 
      Caption         =   "Lista :"
      Height          =   285
      Index           =   3
      Left            =   4365
      TabIndex        =   68
      Top             =   2655
      Width           =   450
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obra :"
      Height          =   240
      Index           =   3
      Left            =   135
      TabIndex        =   66
      Top             =   2700
      Width           =   1755
   End
   Begin VB.Label lblData 
      Caption         =   "Equipo :"
      Height          =   240
      Index           =   5
      Left            =   6300
      TabIndex        =   64
      Top             =   1665
      Visible         =   0   'False
      Width           =   1395
   End
   Begin VB.Label lblData 
      Caption         =   "COT :"
      Height          =   240
      Index           =   2
      Left            =   9810
      TabIndex        =   61
      Top             =   1980
      Width           =   360
   End
   Begin VB.Label lblData 
      Caption         =   "Orden de compra :"
      Height          =   240
      Index           =   1
      Left            =   9135
      TabIndex        =   59
      Top             =   2745
      Width           =   1305
   End
   Begin VB.Label lblData 
      Caption         =   "Orden de carga :"
      Height          =   285
      Index           =   0
      Left            =   6300
      TabIndex        =   57
      Top             =   2700
      Width           =   1395
   End
   Begin VB.Label lblData 
      Caption         =   "Chofer/Docum. :"
      Height          =   240
      Index           =   10
      Left            =   6300
      TabIndex        =   55
      Top             =   2340
      Width           =   1395
   End
   Begin VB.Label lblData 
      Caption         =   "Patente :"
      Height          =   240
      Index           =   8
      Left            =   6300
      TabIndex        =   52
      Top             =   1980
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones del item seleccionado :"
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
      Index           =   20
      Left            =   6795
      TabIndex        =   50
      Top             =   6255
      Width           =   3345
   End
   Begin VB.Label Label2 
      Caption         =   "Valor declarado :"
      Height          =   195
      Left            =   6705
      TabIndex        =   41
      Top             =   5985
      Width           =   1230
   End
   Begin VB.Label Label1 
      Caption         =   "Total bultos :"
      Height          =   195
      Left            =   9540
      TabIndex        =   39
      Top             =   5985
      Width           =   1050
   End
   Begin VB.Label lblLabels 
      Caption         =   "Transportistas :"
      Height          =   240
      Index           =   1
      Left            =   135
      TabIndex        =   37
      Top             =   2340
      Width           =   1755
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
      Left            =   1620
      TabIndex        =   30
      Top             =   6255
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Condicion IVA :"
      Height          =   240
      Index           =   4
      Left            =   6300
      TabIndex        =   29
      Top             =   900
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cond. de Compra :"
      Height          =   285
      Index           =   16
      Left            =   135
      TabIndex        =   28
      Top             =   1980
      Width           =   1755
   End
   Begin VB.Label lblLabels 
      Caption         =   "Direccion de entrega :"
      Height          =   285
      Index           =   13
      Left            =   135
      TabIndex        =   27
      Top             =   1620
      Visible         =   0   'False
      Width           =   1755
   End
   Begin VB.Label lblLabels 
      Caption         =   "Localidad / Provincia :"
      Height          =   285
      Index           =   11
      Left            =   135
      TabIndex        =   26
      Top             =   1260
      Width           =   1755
   End
   Begin VB.Label lblLabels 
      Caption         =   "Dirección :"
      Height          =   285
      Index           =   10
      Left            =   135
      TabIndex        =   25
      Top             =   885
      Width           =   1755
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cliente:"
      Height          =   285
      Index           =   2
      Left            =   135
      TabIndex        =   24
      Top             =   510
      Width           =   1755
   End
   Begin VB.Label lblLabels 
      Caption         =   "C.U.I.T. :"
      Height          =   240
      Index           =   6
      Left            =   9450
      TabIndex        =   23
      Top             =   900
      Width           =   720
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   22
      Left            =   3825
      TabIndex        =   22
      Top             =   90
      Width           =   900
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de Remito :"
      Height          =   240
      Index           =   21
      Left            =   135
      TabIndex        =   21
      Top             =   90
      Width           =   1755
   End
   Begin VB.Label lblLabels 
      Caption         =   "TE / Fax / Email :"
      Height          =   330
      Index           =   0
      Left            =   6300
      TabIndex        =   20
      Top             =   1245
      Width           =   1395
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
         Caption         =   "Renumerar items"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar item de orden de compra"
         Index           =   4
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Ingreso manual por cajas"
         Index           =   5
      End
   End
End
Attribute VB_Name = "frmRemitos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Remito
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private cALetra As New clsNum2Let
Private mvarId As Long, mvarIdCliente As Long
Private mvarTipoIVA As Integer, mvarFormatCodBar As Integer, mvarItemsMaximo As Integer
Private mvarP_IVA1 As Double, mvarP_IVA2 As Double, mvarDecimales As Double, mvarSubTotal As Double
Private mvarGrabado As Boolean, mvarTransportistaConEquipos As Boolean, mvarModoCodigoBarra As Boolean
Private mvarFijarDatos As Boolean
Private mvarTipoABC As String, mvarAnulado As String, mDescargaPorKit As String, mCadena As String
Private mNivelAcceso As Integer, mOpcionesAcceso As String, mActivarDireccionesEntrega As String

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

   If Not Option2.Value And Not IsNumeric(dcfields(0).BoundText) Then
      MsgBox "Debe definir el cliente antes de acceder a un item", vbExclamation
      Exit Sub
   End If
   
   If mvarItemsMaximo > 0 And mvarItemsMaximo <= origen.DetRemitos.CantidadRegistrosResumido Then
      MsgBox "La cantidad maxima de items por remito es de " & mvarItemsMaximo, vbExclamation
      Exit Sub
   End If
   
   Dim oF As frmDetRemitos
   Dim oL As ListItem
   
   Set oF = New frmDetRemitos
   
   With oF
      Set .Remito = origen
'      If Cual = -1 Then
'         .NumeroItem = Lista.ListItems.Count + 1
'      End If
      .FechaComprobante = DTFields(0).Value
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
            .Text = oF.txtItem.Text
            .SubItems(1) = "" & .Tag
            .SubItems(2) = "" & oF.txtCodigoArticulo.Text
            .SubItems(3) = "" & oF.DataCombo1(1).Text & " " & oF.lblColor.Caption
            .SubItems(4) = "" & Format(Val(oF.txtCantidad.Text), "Fixed")
            .SubItems(5) = "" & oF.DataCombo1(0).Text
            .SubItems(6) = "" & Format(Val(oF.txtPorcentajeCertificacion.Text), "Fixed")
            .SubItems(8) = "" & oF.rchObservaciones.Text
            If oF.Option1.Value Then
               .SubItems(9) = "Mat."
            ElseIf oF.Option2.Value Then
               .SubItems(9) = "Obs."
            ElseIf oF.Option3.Value Then
               .SubItems(9) = "Mat.+Obs."
            End If
            .SubItems(10) = "" & oF.DataCombo1(3).Text
            .SubItems(11) = "" & oF.DataCombo1(4).Text
            .SubItems(12) = "" & oF.txtPartida.Text
            .SubItems(13) = "" & oF.txtNumeroCaja.Text
         End With
         If mvarId < 0 And .IdCondicionVenta <> 0 Then
            origen.Registro.Fields("IdCondicionVenta").Value = .IdCondicionVenta
         End If
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing

   CalculaRemito
   MostrarTotales

End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim mvarImprime As Integer
         Dim mvarNumero As Long
         Dim mvarErr As String, mvarAux1 As String, mvarAux2 As String, mvarAux3 As String, mvarAux4 As String
         Dim mvarAux5 As String, mvarArticulo1 As String, mvarArticulo As String
         Dim mvarCantidadUnidades As Double, mvarStock As Double, mvarStock1 As Double, mvarStock2 As Double
         Dim mvarCantConj As Double
         Dim mvarRegistrarStock As Boolean
         Dim oRs As ADOR.Recordset
         Dim oRsStk As ADOR.Recordset
         Dim oRsAux As ADOR.Recordset
     
         If Not IsNumeric(dcfields(0).BoundText) And Not IsNumeric(dcfields(3).BoundText) Then
            MsgBox "No definio el destino"
            Exit Sub
         End If
         
         If Len(txtTotal(0).Text) = 0 Then
            MsgBox "Debe indicar el valor declarado"
            Exit Sub
         End If
         
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar un Remito sin detalles"
            Exit Sub
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
               If dc.Enabled And dc.Visible And ExisteCampo(origen.Registro, dc.DataField) Then
                  If Len(Trim(dc.BoundText)) = 0 And dc.Index <> 4 And dc.Index <> 5 And dc.Index <> 7 Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
                  If IsNumeric(dc.BoundText) Then .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
         End With
         
         If Not IsNumeric(dcfields(5).BoundText) And dcfields(5).Visible And mvarTransportistaConEquipos Then
            MsgBox "Debe ingresar el equipo de transporte", vbExclamation
            Exit Sub
         End If

         If BuscarClaveINI("Controlar la imputacion de varios ordenes de compra en un mismo remito de venta") = "SI" Then
            mvarAux1 = origen.DetRemitos.OrdenesCompraImputadas
            If InStr(1, mvarAux1, ",") <> 0 Then
               MsgBox "El remito imputa a mas de una nota de venta : " & mvarAux1, vbInformation
            End If
         End If
         
         mvarAux1 = BuscarClaveINI("Inhabilitar ubicaciones en movimientos de stock")
         mvarAux2 = BuscarClaveINI("Inhabilitar stock negativo")
         mvarAux3 = BuscarClaveINI("Inhabilitar stock global negativo")
         mvarAux4 = BuscarClaveINI("Exigir orden de compra en remitos")
         mvarAux5 = BuscarClaveINI("No permitir items en cero en remitos de venta")
         mvarErr = ""
         With origen.DetRemitos.Registros
            If .Fields.Count > 0 Then
               If .RecordCount > 0 Then
                  .MoveFirst
                  Do While Not .EOF
                     If Not .Fields("Eliminado").Value Then
                        If IsNull(.Fields("IdObra").Value) Then
                           mvarErr = mvarErr + "Hay items que no tienen indicada la obra" & vbCrLf
                           Exit Do
                        End If
                        If IsNull(.Fields("IdUbicacion").Value) And mvarAux1 <> "SI" Then
                           mvarErr = mvarErr + "Hay items que no tienen indicada la ubicacion" & vbCrLf
                           Exit Do
                        End If
                     
                        mvarRegistrarStock = True
                        Set oRsStk = Aplicacion.Articulos.TraerFiltrado("_PorId", .Fields("IdArticulo").Value)
                        If oRsStk.RecordCount > 0 Then
                           If Not IsNull(oRsStk.Fields("RegistrarStock").Value) And oRsStk.Fields("RegistrarStock").Value = "NO" Then
                              mvarRegistrarStock = False
                           End If
                           mvarArticulo = IIf(IsNull(oRsStk.Fields("Descripcion").Value), "", oRsStk.Fields("Descripcion").Value)
                        End If
                        oRsStk.Close
                        
                        mvarCantidadUnidades = IIf(IsNull(.Fields("Cantidad").Value), 0, .Fields("Cantidad").Value)
                        If mvarAux5 = "SI" And mvarCantidadUnidades <= 0 Then
                           MsgBox "El articulo " & mvarArticulo & ", tiene ingresado un item en cero", vbExclamation
                           Exit Sub
                        End If
                        
                        If mvarRegistrarStock And (mvarAux2 = "SI" Or mvarAux3 = "SI") Then
                           mvarStock1 = 0
                           mvarStock2 = 0
                           If IIf(IsNull(.Fields("DescargaPorKit").Value), "NO", .Fields("DescargaPorKit").Value) = "NO" Then
                              Set oRsStk = Aplicacion.Articulos.TraerFiltrado("_StockPorArticuloPartidaUnidadUbicacionObra", _
                                           Array(.Fields("IdArticulo").Value, IIf(IsNull(.Fields("Partida").Value), "", .Fields("Partida").Value), _
                                                 .Fields("IdUnidad").Value, IIf(IsNull(.Fields("IdUbicacion").Value), 0, .Fields("IdUbicacion").Value), _
                                                 .Fields("IdObra").Value))
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
                                 If mvarAux3 <> "SI" And mvarStock1 < mvarCantidadUnidades Then
                                    MsgBox "El articulo " & mvarArticulo & ", tiene" & vbCrLf & _
                                             "stock insuficiente segun datos ingresados :" & vbCrLf & _
                                             "cantidad actual en stock para la partida, unidad, ubicacion y obra : " & mvarStock1 & vbCrLf & _
                                             "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
                                    Exit Sub
                                 End If
                                 If mvarStock2 < mvarCantidadUnidades Then
                                    MsgBox "El articulo " & mvarArticulo & ", tiene stock insuficiente" & vbCrLf & _
                                             "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
                                    Exit Sub
                                 End If
                              Else
                                 Set oRsStk = Aplicacion.TablasGenerales.TraerUno("DetRemitos", .Fields(0).Value)
                                 mvarStock = 0
                                 If oRsStk.RecordCount > 0 Then
                                    mvarStock = IIf(IsNull(oRsStk.Fields("Cantidad").Value), 0, oRsStk.Fields("Cantidad").Value)
                                 End If
                                 oRsStk.Close
                                 Set oRsStk = Nothing
                                 If mvarAux3 <> "SI" And mvarStock1 < mvarCantidadUnidades - mvarStock Then
                                    MsgBox "El articulo " & mvarArticulo & ", tiene" & vbCrLf & _
                                             "stock insuficiente segun datos ingresados :" & vbCrLf & _
                                             "cantidad actual en stock para la partida, unidad, ubicacion y obra : " & mvarStock1 & vbCrLf & _
                                             "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
                                    Exit Sub
                                 End If
                                 If mvarStock2 < mvarCantidadUnidades - mvarStock Then
                                    MsgBox "El articulo " & mvarArticulo & ", tiene stock insuficiente" & vbCrLf & _
                                             "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock"
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
                                          MsgBox "El articulo " & mvarArticulo1 & vbCrLf & _
                                                   "que es parte del kit " & mvarArticulo & vbCrLf & _
                                                   "dejaria el stock negativo, reingrese", vbExclamation
                                          Exit Sub
                                       End If
                                    Else
                                       Set oRsStk = Aplicacion.TablasGenerales.TraerUno("DetSalidasMateriales", .Fields(0).Value)
                                       mvarStock1 = 0
                                       If oRsStk.RecordCount > 0 Then
                                          mvarStock1 = IIf(IsNull(oRsStk.Fields("Cantidad").Value), 0, oRsStk.Fields("Cantidad").Value)
                                       End If
                                       oRsStk.Close
                                       If mvarStock < (mvarCantidadUnidades * mvarCantConj) - (mvarStock1 * mvarCantConj) Then
                                          Set oRsAux = Nothing
                                          Set oRsStk = Nothing
                                          MsgBox "El articulo " & mvarArticulo1 & vbCrLf & _
                                                   "que es parte del kit " & mvarArticulo & vbCrLf & _
                                                   "dejaria el stock negativo, reingrese", vbExclamation
                                          Exit Sub
                                       End If
                                    End If
                                    oRsAux.MoveNext
                                 Loop
                              End If
                              oRsAux.Close
                           End If
                           Set oRsAux = Nothing
                           Set oRsStk = Nothing
                        End If
                     
                        If mvarAux4 = "SI" Then
                           If IsNull(.Fields("IdDetalleOrdenCompra").Value) Then
                              MsgBox "El articulo " & mvarArticulo & ", no tiene asignado un item de orden de compra del cliente", vbExclamation, "Sin stock"
                              Exit Sub
                           End If
                        End If
                     End If
                     .MoveNext
                  Loop
               End If
            End If
         End With
         
         If Len(mvarErr) Then
            MsgBox "Errores encontrados :" & vbCrLf & mvarErr, vbExclamation
            Exit Sub
         End If
         
         Me.MousePointer = vbHourglass
      
         With origen.Registro
            If Option1.Value Then
               .Fields("Destino").Value = 1
            ElseIf Option2.Value Then
               .Fields("Destino").Value = 2
            ElseIf Option3.Value Then
               .Fields("Destino").Value = 3
            ElseIf Option4.Value Then
               .Fields("Destino").Value = 4
            ElseIf Option5.Value Then
               .Fields("Destino").Value = 5
            ElseIf Option6.Value Then
               .Fields("Destino").Value = 6
            End If
            .Fields("PuntoVenta").Value = Val(dcfields(10).Text)
            .Fields("Observaciones").Value = rchObservaciones.Text
         End With
         
         If mvarId < 0 Then
            Dim oPto As ComPronto.PuntoVenta
            Set oPto = Aplicacion.PuntosVenta.Item(dcfields(10).BoundText)
            With oPto.Registro
               mvarNumero = .Fields("ProximoNumero").Value
               .Fields("ProximoNumero").Value = mvarNumero + 1
               origen.Registro.Fields("NumeroRemito").Value = mvarNumero
            End With
            oPto.Guardar
            Set oPto = Nothing
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
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "RemitosTodos, RemitosAgrupados, +SubRM2"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
         Me.MousePointer = vbDefault
   
         mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion del Remito")
         If mvarImprime = vbYes Then
            cmdImpre_Click 0
         End If
      
         Unload Me

      Case 1
      
         Unload Me

      Case 2
   
         AnularRemito
         
   End Select
   
   Set cALetra = Nothing
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oDet As DetRemito
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   Dim ListaVacia As Boolean, NoWord As Boolean
   Dim mAuxS1 As String
   
   mvarId = vNewValue
   ListaVacia = False
   mvarTransportistaConEquipos = False
   mvarFijarDatos = False
   
   mDescargaPorKit = BuscarClaveINI("Mover stock por kit")
   If mDescargaPorKit = "" Then mDescargaPorKit = "NO"
         
   If BuscarClaveINI("Mostrar datos adicionales en recepcion") = "SI" Then
      lblData(5).Visible = True
      dcfields(5).Visible = True
      txtCodigoEquipo.Visible = True
   End If
   
   If BuscarClaveINI("Habilitar plantilla de romaneo en remito") = "SI" Then
      cmd(2).Width = cmdImpre(0).Width
      With cmdImpre(2)
         .Top = cmd(2).Top
         .Left = cmdImpre(1).Left
         .Visible = True
      End With
   End If
   
   mvarFormatCodBar = 1
   mAuxS1 = BuscarClaveINI("Modelo de registro de codigo de barras")
   If Len(mAuxS1) > 0 And IsNumeric(mAuxS1) Then mvarFormatCodBar = Val(mAuxS1)
   
   mvarItemsMaximo = Val(BuscarClaveINI("Maxima cantidad de items en remito de venta"))
   
   NoWord = False
   If BuscarClaveINI("Remito no permitir salida a Word") = "SI" Then NoWord = True
   
   mActivarDireccionesEntrega = BuscarClaveINI("Activar direccion de entrega en ordenes de compra")
   If mActivarDireccionesEntrega = "SI" Then
      lblLabels(13).Visible = True
      dcfields(6).Visible = True
   End If
   
   Set oAp = Aplicacion
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)
   End With
   oRs.Close
   
   Set origen = oAp.Remitos.Item(vNewValue)
   
   If vNewValue = -1 Then
'      origen.Registro.Fields(7).Value = 1
      mvarIdCliente = 0
   Else
      mvarIdCliente = IIf(IsNull(origen.Registro.Fields("IdCliente").Value), 0, origen.Registro.Fields("IdCliente").Value)
   End If
   
   If Not mvarId = -1 Then
      With origen.Registro
         If .Fields("Destino").Value = 1 Then
            Option1.Value = True
         ElseIf .Fields("Destino").Value = 2 Then
            Option2.Value = True
         ElseIf .Fields("Destino").Value = 3 Then
            Option3.Value = True
         ElseIf .Fields("Destino").Value = 4 Then
            Option4.Value = True
         ElseIf .Fields("Destino").Value = 5 Then
            Option5.Value = True
         ElseIf .Fields("Destino").Value = 6 Then
            Option6.Value = True
         End If
      End With
   End If
   
   mvarAnulado = "NO"
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            If oControl.Name = "Lista" Then
               If vNewValue < 0 Then
                  Set oControl.DataSource = origen.DetRemitos.TraerMascara
                  ListaVacia = True
               Else
                  Set oRs = origen.DetRemitos.TraerTodos
                  If oRs.RecordCount <> 0 Then
                     Set oControl.DataSource = oRs
                     oRs.MoveFirst
                     Do While Not oRs.EOF
                        Set oDet = origen.DetRemitos.Item(oRs.Fields(0).Value)
                        oDet.Modificado = True
                        Set oDet = Nothing
                        oRs.MoveNext
                     Loop
                     ListaVacia = False
                  Else
                     Set oControl.DataSource = origen.DetRemitos.TraerMascara
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
                  Set oControl.RowSource = oAp.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(41, "X"))
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
      txtTotal(1).Text = 1
      Option1.Value = True
      Lista.ListItems.Clear
      mvarGrabado = False
   Else
      With origen.Registro
         If Not IsNull(.Fields("Anulado").Value) And _
               .Fields("Anulado").Value = "SI" Then
            With lblEstado1
               .Caption = "ANULADO"
               .Visible = True
            End With
            mvarAnulado = "SI"
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
      mvarGrabado = True
   End If
   
   If ListaVacia Then Lista.ListItems.Clear
   
   Set oAp = Nothing

   CalculaRemito
   MostrarTotales
   
   cmd(0).Enabled = False
   cmd(2).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      cmd(2).Enabled = True
   End If
   If mvarId <= 0 Then
      cmd(2).Enabled = False
   Else
      cmd(0).Enabled = False
   End If
   
   If NoWord Then cmdImpre(1).Enabled = False
   
   If mvarAnulado = "SI" Then
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
   
   Dim mvarOK As Boolean
   Dim mCopias As Integer
   Dim mPrinter As String, mPrinterAnt As String, mPuntoVenta As String, mPlantilla As String, mFormulario As String
   
   mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
   If Index = 0 Then
      Dim oF As frmImpresion
      Set oF = New frmImpresion
      With oF
         .txtCopias.Text = 1
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
   
   Dim oW As Word.Application
      
   On Error GoTo Mal
   
   mPuntoVenta = Format(origen.Registro.Fields("PuntoVenta").Value, "0000")
   If Index = 2 Then
      mPlantilla = glbPathPlantillas & "\Romaneo_" & glbEmpresaSegunString & ".dot"
      If Len(Dir(mPlantilla)) = 0 Then
         MsgBox "Plantilla inexistente", vbExclamation
         Exit Sub
      End If
   Else
      mPlantilla = glbPathPlantillas & "\Remito_" & glbEmpresaSegunString & "_" & mPuntoVenta & ".dot"
      If Len(Dir(mPlantilla)) = 0 Then
         mPlantilla = glbPathPlantillas & "\Remito_" & glbEmpresaSegunString & ".dot"
         If Len(Dir(mPlantilla)) = 0 Then
            MsgBox "Plantilla inexistente", vbExclamation
            Exit Sub
         End If
      End If
   End If
   
   Set oW = CreateObject("Word.Application")
   With oW
      .Visible = True
      If BuscarClaveINI("Emitir documentos protegidos") = "SI" Then
'         oW.Documents.Open mPlantilla, , , , , "prontodots"
'         oW.ActiveDocument.Unprotect ("prontodots")
         .Documents.Add (mPlantilla)
         .Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId, varg3:=mPrinter, varg4:=mCopias, varg5:=""
         oW.ActiveDocument.Protect 3, , "prontodots"
      Else
         .Documents.Add (mPlantilla)
         .Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId, varg3:=mPrinter, varg4:=mCopias, varg5:=""
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

Private Sub dcfields_Change(Index As Integer)
      
   If Len(dcfields(Index).BoundText) = 0 Or Not IsNumeric(dcfields(Index).BoundText) Then Exit Sub
   
   Dim oRs As ADOR.Recordset
   Dim mCampoId As Long
   
   Select Case Index
      Case 0, 3
         If mActivarDireccionesEntrega = "SI" And Index = 0 Then
            mCampoId = IIf(IsNull(origen.Registro.Fields("IdDetalleClienteLugarEntrega").Value), 0, origen.Registro.Fields("IdDetalleClienteLugarEntrega").Value)
            Set oRs = Aplicacion.Clientes.TraerFiltrado("_LugaresEntrega", dcfields(0).BoundText)
            If oRs.RecordCount = 1 Then mCampoId = oRs.Fields(0).Value
            With dcfields(6)
               Set .RowSource = oRs
               .Refresh
               .BoundText = mCampoId
            End With
            Set oRs = Nothing
         End If
         
         MostrarDatos (0)
      Case 2
         Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorIdTransportista", dcfields(Index).BoundText)
         mvarTransportistaConEquipos = False
         If oRs.RecordCount > 0 Then mvarTransportistaConEquipos = True
         Set dcfields(5).RowSource = oRs
      Case 5
         Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", dcfields(Index).BoundText)
         If oRs.RecordCount > 0 Then
            If Not IsNull(oRs.Fields("NumeroPatente").Value) Then
               origen.Registro.Fields("Patente").Value = oRs.Fields("NumeroPatente").Value
               If Len(txtPatente.Text) > 0 Then txtPatente.Enabled = False
            End If
            txtCodigoEquipo.Text = IIf(IsNull(oRs.Fields("NumeroInventario").Value), "", oRs.Fields("NumeroInventario").Value)
         End If
         oRs.Close
      Case 10
         If mvarId <= 0 Then
            Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(Index).BoundText)
            If oRs.RecordCount > 0 Then
               origen.Registro.Fields("NumeroRemito").Value = oRs.Fields("ProximoNumero").Value
               txtNumeroRemito.Text = oRs.Fields("ProximoNumero").Value
            End If
            oRs.Close
            Set oRs = Nothing
         End If
   End Select
   
   Set oRs = Nothing
   
   If Len(dcfields(Index).DataField) <> 0 Then
      origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
   End If
   
End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   If Not mvarModoCodigoBarra Then Exit Sub
   
   If KeyAscii <> 13 Then
      mCadena = mCadena & Chr(KeyAscii)
      KeyAscii = 0
   ElseIf KeyAscii = 13 Then
      ProcesarCodigoBarras mCadena
      mCadena = ""
   ElseIf KeyAscii = 27 Then
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
      Set Lista.DataSource = origen.DetRemitos.RegistrosConFormato
      MostrarTotales
      DoEvents
   End If

End Sub

Private Sub Form_Load()

   Dim oRs As ADOR.Recordset
   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   For Each oI In img16.ListImages
      With Estado.Panels.Add(, , oI.Key)
         .Picture = oI.Picture
      End With
   Next

   Set oRs = Aplicacion.Parametros.Item(1).Registro
   
   With oRs
      mvarP_IVA1 = .Fields("Iva1").Value
      mvarP_IVA2 = .Fields("Iva2").Value
      mvarDecimales = .Fields("Decimales").Value
      If mvarId < 0 Then
         txtNumeroRemito.Text = .Fields("ProximoNumeroRemito").Value
      End If
   End With
   
   oRs.Close
   Set oRs = Nothing

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

Private Sub Lista_ItemClick(ByVal Item As MSComctlLib.IListItem)

   rchObservacionesItemVisible.TextRTF = ""
   If Not Item Is Nothing Then
      If IsNumeric(Item.SubItems(1)) Then
         If Not IsNull(origen.DetRemitos.Item(Item.SubItems(1)).Registro.Fields("Observaciones").Value) Then
           rchObservacionesItemVisible.TextRTF = origen.DetRemitos.Item(Item.SubItems(1)).Registro.Fields("Observaciones").Value
         End If
      End If
   End If

End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)
   
   If mvarModoCodigoBarra Then Exit Sub
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
   Dim iFilas As Long, iColumnas As Long, i As Long, mSubNumero As Long
   Dim Filas
   Dim Columnas
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oOC As ComPronto.OrdenCompra
   Dim oRsOC As ADOR.Recordset
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset

   If mvarId > 0 Then
      MsgBox "Solo puede copiar a un remito vacio!", vbCritical
      Exit Sub
   End If
   
   If Data.GetFormat(ccCFText) Then
      
      s = Data.GetData(ccCFText)
   
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay solicitud de cotizacion para copiar", vbCritical
         Exit Sub
      End If
      
      If UBound(Filas) > 1 Then
         MsgBox "No puede copiar mas de un remito!", vbCritical
         Exit Sub
      End If
      
      If mvarItemsMaximo > 0 And mvarItemsMaximo <= origen.DetRemitos.CantidadRegistrosResumido Then
         MsgBox "La cantidad maxima de items por remito es de " & mvarItemsMaximo, vbExclamation
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 3), "Nro. interno") <> 0 And InStr(1, Columnas(LBound(Columnas) + 4), "Fecha") <> 0 Then
      
         Set oAp = Aplicacion
         
         Columnas = Split(Filas(1), vbTab)
         
         Set oOC = oAp.OrdenesCompra.Item(Columnas(2))
         
         If oOC.Registro.Fields("Anulada").Value = "SI" Then
            MsgBox "La orden de compra fue anulada.", vbExclamation
            GoTo Salida
         End If
         
         Set oRsOC = oOC.DetOrdenesCompra.TraerTodos
         
         Set oRs = oOC.Registro
         With origen.Registro
            For i = 1 To oRs.Fields.Count - 1
               .Fields("IdCliente").Value = oRs.Fields("IdCliente").Value
               .Fields("IdCondicionVenta").Value = oRs.Fields("IdCondicionVenta").Value
               .Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
               .Fields("ArchivoAdjunto1").Value = oRs.Fields("ArchivoAdjunto1").Value
               .Fields("ArchivoAdjunto2").Value = oRs.Fields("ArchivoAdjunto2").Value
               .Fields("ArchivoAdjunto3").Value = oRs.Fields("ArchivoAdjunto3").Value
               .Fields("ArchivoAdjunto4").Value = oRs.Fields("ArchivoAdjunto4").Value
               .Fields("ArchivoAdjunto5").Value = oRs.Fields("ArchivoAdjunto5").Value
               .Fields("ArchivoAdjunto6").Value = oRs.Fields("ArchivoAdjunto6").Value
               .Fields("ArchivoAdjunto7").Value = oRs.Fields("ArchivoAdjunto7").Value
               .Fields("ArchivoAdjunto8").Value = oRs.Fields("ArchivoAdjunto8").Value
               .Fields("ArchivoAdjunto9").Value = oRs.Fields("ArchivoAdjunto9").Value
               .Fields("ArchivoAdjunto10").Value = oRs.Fields("ArchivoAdjunto10").Value
               If Not IsNull(oRs.Fields("IdListaPrecios").Value) Then mvarFijarDatos = True
               .Fields("IdListaPrecios").Value = oRs.Fields("IdListaPrecios").Value
               If Not IsNull(oRs.Fields("IdDetalleClienteLugarEntrega").Value) Then
                  .Fields("IdDetalleClienteLugarEntrega").Value = oRs.Fields("IdDetalleClienteLugarEntrega").Value
                  dcfields(6).BoundText = oRs.Fields("IdDetalleClienteLugarEntrega").Value
               End If
            Next
         End With
         
         Do While Not oRsOC.EOF
            Set oRsDet = oOC.DetOrdenesCompra.TraerFiltrado("_PorIdDetalleOrdenCompraConDatos", oRsOC.Fields(0).Value)
            If oRsDet.RecordCount > 0 Then
               If mvarItemsMaximo > 0 And mvarItemsMaximo <= origen.DetRemitos.CantidadRegistrosResumido Then
                  MsgBox "La cantidad maxima de items por remito es de " & mvarItemsMaximo, vbExclamation
                  GoTo Salida
               End If
               If IIf(IsNull(oRsDet.Fields("Pend.remitir").Value), 0, oRsDet.Fields("Pend.remitir").Value) > 0 And IIf(IsNull(oRsDet.Fields("Cumplido").Value), "NO", oRsDet.Fields("Cumplido").Value) = "NO" Then
                  With origen.DetRemitos.Item(-1)
                     .Registro.Fields("NumeroItem").Value = origen.DetRemitos.CantidadRegistrosResumido + 1
                     .Registro.Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                     .Registro.Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                     .Registro.Fields("Precio").Value = oRsDet.Fields("Precio").Value
                     .Registro.Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
                     .Registro.Fields("OrigenDescripcion").Value = oRsDet.Fields("OrigenDescripcion").Value
                     .Registro.Fields("IdDetalleOrdenCompra").Value = oRsDet.Fields("IdDetalleOrdenCompra").Value
                     .Registro.Fields("TipoCancelacion").Value = oRsDet.Fields("TipoCancelacion").Value
                     .Registro.Fields("IdObra").Value = oRs.Fields("IdObra").Value
                     .Registro.Fields("IdUbicacion").Value = oRsDet.Fields("IdUbicacionStandar").Value
                     If oRsDet.Fields("TipoCancelacion").Value = 1 Then
                        .Registro.Fields("Cantidad").Value = oRsDet.Fields("Pend.remitir").Value
                        .Registro.Fields("PorcentajeCertificacion").Value = 0
                     Else
                        .Registro.Fields("PorcentajeCertificacion").Value = oRsDet.Fields("Pend.remitir").Value
                        .Registro.Fields("Cantidad").Value = 0
                     End If
                     .Registro.Fields("DescargaPorKit").Value = mDescargaPorKit
                     .Modificado = True
                  End With
               End If
            End If
            oRsDet.Close
            Set oRsDet = Nothing
            oRsOC.MoveNext
         Loop
         oRsOC.Close
         Set oRsOC = Nothing
         
         oRs.Close
Salida:
         Set oRs = Nothing
         Set oOC = Nothing
         Set oAp = Nothing
            
         Set Lista.DataSource = origen.DetRemitos.RegistrosConFormato
         
         MostrarDatos 0
         CalculaRemito
         MostrarTotales
         
'         mvarModificado = True
         
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

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0 ' Agregar
         Editar -1
      Case 1
         Editar Lista.SelectedItem.Tag
      Case 2
         With Lista.SelectedItem
            origen.DetRemitos.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
      Case 3
         RenumerarItems
      Case 4
         AsignaOrdenCompra
      Case 5
         IngresoManualCajas
   End Select
   
   MostrarTotales

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

   Dim mvarLocalidad As Integer, mvarZona As Integer, mvarVendedor As Integer
   Dim mvarTransportista As Integer, mvarProvincia As Integer, mvarTipoVentaC As Integer
   Dim mvarCondicionVenta As Integer
   Dim Cambio As Boolean
   
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   mvarTipoABC = "X"
   
   If Not IsNumeric(dcfields(Index).BoundText) Then Exit Sub
   
   ' Cargo los datos del Cliente
   
   Me.MousePointer = vbHourglass
   
   Set oAp = Aplicacion
   
   If Option2.Value Then
      Set oRs = oAp.Proveedores.Item(dcfields(3).BoundText).Registro
   Else
      If mvarIdCliente <> dcfields(Index).BoundText Then
         Cambio = True
         mvarIdCliente = dcfields(Index).BoundText
      Else
         Cambio = False
      End If
      Set oRs = oAp.Clientes.Item(dcfields(0).BoundText).Registro
   End If
   
   With oRs
      If Option2.Value Then
         txtCodigo.Text = IIf(IsNull(.Fields("CodigoProveedor").Value), "", .Fields("CodigoProveedor").Value)
         txtTelefono.Text = IIf(IsNull(.Fields("Telefono1").Value), "", .Fields("Telefono1").Value)
      Else
         txtCodigo.Text = IIf(IsNull(.Fields("Codigo").Value), "", .Fields("Codigo").Value)
         txtTelefono.Text = IIf(IsNull(.Fields("Telefono").Value), "", .Fields("Telefono").Value)
         If Not IsNull(.Fields("IdCondicionVenta").Value) And Len(dcfields(1).Text) = 0 Then
            dcfields(1).BoundText = .Fields("IdCondicionVenta").Value
         End If
      End If
      txtDireccion.Text = IIf(IsNull(.Fields("Direccion").Value), "", .Fields("Direccion").Value)
      txtCodigoPostal.Text = IIf(IsNull(.Fields("CodigoPostal").Value), "", .Fields("CodigoPostal").Value)
      txtCuit.Text = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
      txtFax.Text = IIf(IsNull(.Fields("Fax").Value), "", .Fields("Fax").Value)
      txtEmail.Text = IIf(IsNull(.Fields("Email").Value), "", .Fields("Email").Value)
      mvarLocalidad = IIf(IsNull(.Fields("IdLocalidad").Value), 0, .Fields("IdLocalidad").Value)
      mvarZona = 0
      mvarProvincia = IIf(IsNull(.Fields("IdProvincia").Value), 0, .Fields("IdProvincia").Value)
      mvarTipoIVA = IIf(IsNull(.Fields("IdCodigoIva").Value), 0, .Fields("IdCodigoIva").Value)
      If Not IsNull(.Fields("IdListaPrecios").Value) And mvarId <= 0 And Not mvarFijarDatos Then 'Or Len(dcfields(7).Text) = 0 Then
         dcfields(7).BoundText = .Fields("IdListaPrecios").Value
      End If
      .Close
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
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   If mvarId > 0 Then
      txtNumeroRemito.Text = IIf(IsNull(origen.Registro.Fields("NumeroRemito").Value), 0, origen.Registro.Fields("NumeroRemito").Value)
   End If
   
   If EstadoEntidad("Clientes", mvarIdCliente) = "INACTIVO" Then
      MsgBox "Cliente inhabilitado, no podra registrar este comprobante", vbExclamation
   End If
   
   Me.MousePointer = vbDefault
   
End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      If Not dcfields(0).Visible Then
         lblLabels(2).Caption = "Cliente :"
         dcfields(3).Visible = False
         dcfields(0).Visible = True
'         dcfields(1).Enabled = True
         txtCodigo.Visible = True
         origen.Registro.Fields("IdProveedor").Value = Null
      End If
   End If
   
End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      If Not dcfields(3).Visible Then
         lblLabels(2).Caption = "Proveedor :"
         dcfields(0).Visible = False
         With dcfields(3)
            .Left = dcfields(0).Left
            .Top = dcfields(0).Top
            .Visible = True
         End With
'         dcfields(1).Enabled = False
         txtCodigo.Visible = False
         origen.Registro.Fields("IdCliente").Value = Null
      End If
   End If
   
End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      If Not dcfields(0).Visible Then
         lblLabels(2).Caption = "Cliente :"
         dcfields(3).Visible = False
         dcfields(0).Visible = True
'         dcfields(1).Enabled = True
         txtCodigo.Visible = True
         origen.Registro.Fields("IdProveedor").Value = Null
      End If
   End If
   
End Sub

Private Sub Option4_Click()

   If Option4.Value Then
      If Not dcfields(0).Visible Then
         lblLabels(2).Caption = "Cliente :"
         dcfields(3).Visible = False
         dcfields(0).Visible = True
'         dcfields(1).Enabled = True
         txtCodigo.Visible = True
         origen.Registro.Fields("IdProveedor").Value = Null
      End If
   End If
   
End Sub

Private Sub Option5_Click()

   If Option5.Value Then
      If Not dcfields(0).Visible Then
         lblLabels(2).Caption = "Cliente :"
         dcfields(3).Visible = False
         dcfields(0).Visible = True
'         dcfields(1).Enabled = True
         txtCodigo.Visible = True
         origen.Registro.Fields("IdProveedor").Value = Null
      End If
   End If
   
End Sub

Private Sub Option6_Click()

   If Option6.Value Then
      If Not dcfields(0).Visible Then
         lblLabels(2).Caption = "Cliente :"
         dcfields(3).Visible = False
         dcfields(0).Visible = True
'         dcfields(1).Enabled = True
         txtCodigo.Visible = True
         origen.Registro.Fields("IdProveedor").Value = Null
      End If
   End If
   
End Sub

Private Sub txtChofer_GotFocus()

   With txtChofer
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtChofer_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtChofer
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtCodigo_Change()

   If Len(txtCodigo.Text) > 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Clientes.TraerFiltrado("_PorCodigo", txtCodigo.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdCliente").Value = oRs.Fields(0).Value
      Else
         origen.Registro.Fields("IdCliente").Value = Null
      End If
      oRs.Close
      Set oRs = Nothing
   End If

End Sub

Private Sub txtCodigo_GotFocus()

   With txtCodigo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigo_Validate(Cancel As Boolean)

   If Len(txtCodigo.Text) > 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Clientes.TraerFiltrado("_PorCodigo", txtCodigo.Text)
      If oRs.RecordCount = 0 Then
         MsgBox "Cliente inexistente", vbExclamation
         Cancel = True
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

Private Sub txtCodigoEquipo_GotFocus()

   With txtCodigoEquipo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoEquipo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCodigoEquipo_Validate(Cancel As Boolean)

   If IsNumeric(dcfields(2).BoundText) Then
      If Len(txtCodigoEquipo.Text) <> 0 Then
         Dim oRs As ADOR.Recordset
         Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorNumeroInventarioIdTransportista", _
                     Array(txtCodigoEquipo.Text, dcfields(2).BoundText))
         If oRs.RecordCount > 0 Then
            origen.Registro.Fields("IdEquipo").Value = oRs.Fields(0).Value
         Else
            MsgBox "Codigo de equipo incorrecto", vbExclamation
            Cancel = True
            txtCodigoEquipo.Text = ""
         End If
         oRs.Close
         Set oRs = Nothing
      End If
   Else
      MsgBox "Debe ingresar el transportista", vbExclamation
      Cancel = True
      txtCodigoEquipo.Text = ""
   End If
   
End Sub

Private Sub txtCOT_GotFocus()

   With txtCOT
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCOT_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCOT
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtNumeroDocumento_GotFocus()

   With txtNumeroDocumento
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroDocumento_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtNumeroDocumento
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtNumeroRemito_Change()
   
   If mvarId > 0 Then
      MostrarDatos (0)
   End If

End Sub

Private Sub txtNumeroRemito_Validate(Cancel As Boolean)
   
   If mvarId < 0 Then
   
      Dim oRs As ADOR.Recordset
      
      Me.MousePointer = vbHourglass
      
      Set oRs = Aplicacion.Remitos.TraerFiltrado("Cod", Val(txtNumeroRemito.Text))
   
      If oRs.RecordCount > 0 Then
         MsgBox "Remito ya ingresada el " & oRs.Fields("FechaRemito").Value & ". Reingrese.", vbCritical
         Cancel = True
      End If
      
      oRs.Close
      Set oRs = Nothing
      
      Me.MousePointer = vbDefault
      
   End If

End Sub

Private Sub CalculaRemito()

'   Dim oRs As ADOR.Recordset
'   Dim oL As ListItem
'   Dim i As Integer
'
'   mvarSubTotal = 0
'
'   For Each oL In Lista.ListItems
'      With origen.DetRemitos.Item(oL.Tag)
'         If Not .Eliminado Then
'            mvarSubTotal = mvarSubTotal + .Registro.Fields("Cantidad").Value * IIf(IsNull(.Registro.Fields("Precio").Value), 0, .Registro.Fields("Precio").Value)
'         End If
'      End With
'   Next
'
'   If mvarId > 0 Then
'
'      With origen.Registro
'
'      End With
'
'   Else
'
'   End If
'
'   txtTotal(8).Text = Format(mvarSubTotal, "#,##0.00")
   
End Sub

Public Sub AnularRemito()

   Dim oRs As ADOR.Recordset
   Dim mFacturas As String
   mFacturas = ""
   Set oRs = Aplicacion.Remitos.TraerFiltrado("_FacturasPorIdRemito", mvarId)
   If oRs.RecordCount > 0 Then
      oRs.MoveFirst
      Do While Not oRs.EOF
         mFacturas = mFacturas & oRs.Fields("Factura").Value & vbCrLf
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   Set oRs = Nothing
   If Len(mFacturas) > 0 Then
      MsgBox "El remito que quiere anular ya ha sido facturado en los comprobantes" & vbCrLf & _
               mFacturas & "Anule primero las facturas y luego intente nuevamente", vbExclamation
      Exit Sub
   End If
   
   Dim oF As frmAutorizacion
   Dim mOk As Boolean
   Dim mIdAutorizaAnulacion As Integer
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.Remitos
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
   mSeguro = MsgBox("Esta seguro de anular el remito?", vbYesNo, "Anulacion de remito")
   If mSeguro = vbNo Then
      Exit Sub
   End If

   With origen
      .Registro.Fields("Anulado").Value = "SI"
      .Registro.Fields("IdAutorizaAnulacion").Value = mIdAutorizaAnulacion
      .Registro.Fields("FechaAnulacion").Value = Now
      .Guardar
   End With

   Aplicacion.Tarea "Remitos_AjustarStockRemitoAnulado", mvarId
   
   Set oRs = Aplicacion.Remitos.TraerFiltrado("_DetallesPorIdRemito", mvarId)
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If Not IsNull(.Fields("IdArticulo").Value) Then
               Aplicacion.Tarea "Articulos_RecalcularCostoPPP_PorIdArticulo", .Fields("IdArticulo").Value
            End If
            .MoveNext
         Loop
      End If
      .Close
   End With
   Set oRs = Nothing
   
   Unload Me

End Sub

Public Sub RenumerarItems()

   Dim oL As ListItem
   Dim i As Integer
   
   i = 1
   For Each oL In Lista.ListItems
      With origen.DetRemitos.Item(oL.Tag)
         .Registro.Fields("NumeroItem").Value = i
         .Modificado = True
      End With
      oL.Text = i
      i = i + 1
   Next

End Sub

Private Sub txtOrdenCarga_GotFocus()

   With txtOrdenCarga
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtOrdenCarga_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtOrdenCarga
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtOrdenCompra_GotFocus()

   With txtOrdenCompra
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtOrdenCompra_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtOrdenCompra
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtPatente_GotFocus()

   With txtPatente
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPatente_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtPatente
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Public Sub ProcesarCodigoBarras(ByVal mCodigoBarras As String)

   Dim oRs As ADOR.Recordset
   Dim mCodArt As String, mPartida As String, mColor As String, mError As String
   Dim mPeso As Double
   Dim mIdDetalle As Long, mNumeroCaja As Long, mIdUbicacion As Long, mIdArticulo As Long
   Dim oL As ListItem
   
   mError = ""
   
   Select Case mvarFormatCodBar
      Case 2
         If Len(mCodigoBarras) > 0 And Len(mCodigoBarras) <= 32 Then
            mCodArt = Trim(mId(mCodigoBarras, 1, 20))
            mPartida = Trim(mId(mCodigoBarras, 21, 6))
            mNumeroCaja = 0
            mIdUbicacion = 0
            mIdArticulo = 0
            mColor = ""
            If mId(mCodigoBarras, 27, 1) = "C" Then
               mNumeroCaja = mId(mCodigoBarras, 28, 5)
               Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorNumeroCaja", mNumeroCaja)
               If oRs.RecordCount > 0 Then
                  mPeso = IIf(IsNull(oRs.Fields("CantidadUnidades").Value), 0, oRs.Fields("CantidadUnidades").Value)
                  mIdUbicacion = IIf(IsNull(oRs.Fields("IdUbicacion").Value), 0, oRs.Fields("IdUbicacion").Value)
                  mColor = IIf(IsNull(oRs.Fields("Color").Value), "", oRs.Fields("Color").Value)
                  mIdArticulo = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
               End If
               oRs.Close
               If glbUsarPartidasParaStock Then
                  If Not origen.DetRemitos.ControlCajas(mNumeroCaja, -1) Then
                     mError = mError & mNumeroCaja & ","
                     GoTo Salida
                  End If
               End If
            Else
               mPeso = CDbl(mId(mCodigoBarras, 28, 5)) / 100
            End If
            If mIdArticulo > 0 Then
               Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", mIdArticulo)
            Else
               Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", mCodArt)
            End If
            If oRs.RecordCount > 0 Then
               With origen.DetRemitos.Item(-1)
                  With .Registro
                     .Fields("NumeroItem").Value = origen.DetRemitos.CantidadRegistrosResumido
                     .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                     .Fields("Partida").Value = mPartida
                     .Fields("Cantidad").Value = mPeso
                     .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     If IsNumeric(dcfields(4).BoundText) Then
                        .Fields("IdObra").Value = dcfields(4).BoundText
                     Else
                        .Fields("IdObra").Value = origen.Registro.Fields("IdObra").Value
                     End If
                     If mIdUbicacion > 0 Then
                        .Fields("IdUbicacion").Value = mIdUbicacion
                     Else
                        .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacionStandar").Value
                     End If
                     .Fields("OrigenDescripcion").Value = 1
                     .Fields("NumeroCaja").Value = mNumeroCaja
'                     .Registro.Fields("Precio").Value = oRsDet.Fields("Precio").Value
'                     .Registro.Fields("IdDetalleOrdenCompra").Value = oRsDet.Fields("IdDetalleOrdenCompra").Value
'                     .Registro.Fields("TipoCancelacion").Value = oRsDet.Fields("TipoCancelacion").Value
'                     If oRsDet.Fields("TipoCancelacion").Value = 1 Then
'                        .Registro.Fields("Cantidad").Value = oRsDet.Fields("Pend.remitir").Value
'                        .Registro.Fields("PorcentajeCertificacion").Value = 0
'                     Else
'                        .Registro.Fields("PorcentajeCertificacion").Value = oRsDet.Fields("Pend.remitir").Value
'                        .Registro.Fields("Cantidad").Value = 0
'                     End If
                  End With
                  .Modificado = True
                  mIdDetalle = .Id
               End With
            
               Set oL = Lista.ListItems.Add
               oL.Tag = mIdDetalle
               With oL
                  .SmallIcon = "Nuevo"
                  .Text = origen.DetRemitos.CantidadRegistrosResumido
                  .SubItems(1) = "" & .Tag
                  .SubItems(2) = "" & mCodArt
                  .SubItems(3) = "" & oRs.Fields("Descripcion").Value & " " & mColor
                  .SubItems(4) = "" & Format(mPeso, "Fixed")
                  '.SubItems(5) = "" & oF.DataCombo1(0).Text
                  '.SubItems(6) = "" & Format(Val(oF.txtPorcentajeCertificacion.Text), "Fixed")
                  '.SubItems(8) = "" & oF.rchObservaciones.Text
                  .SubItems(9) = "Mat."
                  '.SubItems(10) = "" & oF.DataCombo1(3).Text
                  '.SubItems(11) = "" & oF.DataCombo1(4).Text
                  .SubItems(12) = "" & mPartida
                  .SubItems(13) = "" & mNumeroCaja
               End With
            End If
            oRs.Close
         End If
   
   End Select

   MostrarTotales

Salida:
   Set oRs = Nothing

End Sub

Public Sub MostrarTotales()

   Estado.Panels(1).Text = " " & origen.DetRemitos.CantidadRegistros & " Items - " & origen.DetRemitos.TotalCantidad & " Unidades"

End Sub

Public Sub AsignaOrdenCompra()

   Dim oF As frm_Aux
   Dim oL As ListItem
   Dim oDet As ComPronto.DetRemito
   Dim oRs As ADOR.Recordset
   Dim mIdDetalleOrdenCompra As Long, mIdObraDefault As Long, mIdObra As Long
   Dim mModeloDatos As String
   Dim mOk As Boolean
   Dim mAux1
   
   mModeloDatos = BuscarClaveINI("Modelo de datos para combo de ordenes de compra")
   If Len(mModeloDatos) = 0 Then mModeloDatos = "01"
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Asignacion de item de orden de compra"
      .Text1.Visible = False
      .Label1.Caption = "Item O.Compra :"
      With .dcfields(0)
         .Left = oF.Text1.Left
         .Top = oF.Text1.Top
         .Width = oF.Text1.Width * 7
         .BoundColumn = "IdDetalleOrdenCompra"
         If Not IsNull(origen.Registro.Fields("IdCliente").Value) Then
            Set .RowSource = Aplicacion.OrdenesCompra.TraerFiltrado("_ItemsPendientesDeRemitirPorIdClienteParaCombo", _
                                 Array(origen.Registro.Fields("IdCliente").Value, "F", mModeloDatos))
         End If
         .Visible = True
      End With
      .Width = .Width * 3
      .Show vbModal, Me
      mOk = .Ok
      If .Ok Then mIdDetalleOrdenCompra = .dcfields(0).BoundText
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then Exit Sub
   
   mAux1 = TraerValorParametro2("IdObraDefault")
   mIdObraDefault = IIf(IsNull(mAux1), 0, mAux1)
   
   Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_DetallePorIdDetalle", mIdDetalleOrdenCompra)
   If oRs.RecordCount > 0 Then
      With origen.Registro
         If mIdObraDefault = 0 Then
            mIdObra = IIf(IsNull(oRs.Fields("IdObra").Value), mIdObraDefault, oRs.Fields("IdObra").Value)
         Else
            mIdObra = mIdObraDefault
         End If
         If Not IsNull(oRs.Fields("IdListaPrecios").Value) Then
            .Fields("IdListaPrecios").Value = oRs.Fields("IdListaPrecios").Value
         End If
         If Not IsNull(oRs.Fields("IdDetalleClienteLugarEntrega").Value) Then
            .Fields("IdDetalleClienteLugarEntrega").Value = oRs.Fields("IdDetalleClienteLugarEntrega").Value
            dcfields(6).BoundText = oRs.Fields("IdDetalleClienteLugarEntrega").Value
         End If
         If Not IsNull(oRs.Fields("IdCondicionVenta").Value) Then
            .Fields("IdCondicionVenta").Value = oRs.Fields("IdCondicionVenta").Value
         End If
      End With
   End If
   oRs.Close
   
   For Each oL In Lista.ListItems
      With oL
         If .Selected Then
            Set oDet = origen.DetRemitos.Item(.Tag)
            With oDet
               With .Registro
                  .Fields("IdDetalleOrdenCompra").Value = mIdDetalleOrdenCompra
                  .Fields("IdObra").Value = mIdObra
               End With
               .Modificado = True
            End With
            Set oDet = Nothing
            .SmallIcon = "Modificado"
         End If
      End With
   Next
   
   Set oRs = Nothing
   
End Sub

Public Sub IngresoManualCajas()

   Dim oF As frm_Aux
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim mOk As Boolean
   Dim mCajas As String, mCodArt As String, mPartida As String, mArticulo As String, mUnidad As String
   Dim mUbicacion As String, mObra As String, mColor As String, mError As String
   Dim i As Integer
   Dim mNumeroCaja As Long, mIdUbicacion As Long, mIdDetalle As Long, mIdArticulo As Long, mIdUnidad As Long
   Dim mIdObra As Long
   Dim mPeso As Double
   Dim mVector
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Ingreso manual de cajas"
      .Text1.Visible = False
      .Label1.Caption = "Lista de cajas :"
      With .RichTextBox1
         .Left = oF.Text1.Left
         .Top = oF.Text1.Top
         .Width = oF.Text1.Width
         .Height = oF.Text1.Height * 15
         .Text = ""
         .Visible = True
         .TabIndex = 0
      End With
      .Height = .Height * 2.5
      .Width = .Width * 1
      .cmd(0).Top = .cmd(0).Top * 3.5
      .cmd(1).Top = .cmd(1).Top * 3.5
      .Show vbModal, Me
      mOk = .Ok
      mCajas = .RichTextBox1.Text
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then Exit Sub
   
   mError = ""
   mVector = VBA.Split(mCajas, vbCrLf)
   For i = 0 To UBound(mVector)
      If Len(mVector(i)) > 0 And IsNumeric(mVector(i)) Then
         mNumeroCaja = Val(mVector(i))
         
         If glbUsarPartidasParaStock Then
            If Not origen.DetRemitos.ControlCajas(mNumeroCaja, -1) Then
               mError = mError & mNumeroCaja & ","
               GoTo Proximo
            End If
         End If
         
         If mvarItemsMaximo > 0 And mvarItemsMaximo <= origen.DetRemitos.CantidadRegistrosResumido Then
            MsgBox "La cantidad maxima de items por remito es de " & mvarItemsMaximo & ", no se tomo desde la caja " & mNumeroCaja, vbExclamation
            Exit Sub
         End If
   
         Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorNumeroCaja", mNumeroCaja)
         If oRs.RecordCount > 0 Then
            mPeso = IIf(IsNull(oRs.Fields("CantidadUnidades").Value), 0, oRs.Fields("CantidadUnidades").Value)
            mIdUbicacion = IIf(IsNull(oRs.Fields("IdUbicacion").Value), 0, oRs.Fields("IdUbicacion").Value)
            mCodArt = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
            mPartida = IIf(IsNull(oRs.Fields("Partida").Value), "", oRs.Fields("Partida").Value)
            mIdArticulo = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
            mIdUnidad = IIf(IsNull(oRs.Fields("IdUnidad").Value), 0, oRs.Fields("IdUnidad").Value)
            mIdObra = IIf(IsNull(oRs.Fields("IdObra").Value), 0, oRs.Fields("IdObra").Value)
            mArticulo = IIf(IsNull(oRs.Fields("Articulo").Value), "", oRs.Fields("Articulo").Value)
            mUnidad = IIf(IsNull(oRs.Fields("Un").Value), "", oRs.Fields("Un").Value)
            mUbicacion = IIf(IsNull(oRs.Fields("Ubicacion").Value), "", oRs.Fields("Ubicacion").Value)
            mObra = IIf(IsNull(oRs.Fields("Obra").Value), "", oRs.Fields("Obra").Value)
            mColor = IIf(IsNull(oRs.Fields("Color").Value), "", oRs.Fields("Color").Value)
            
            With origen.DetRemitos.Item(-1)
               With .Registro
                  .Fields("NumeroItem").Value = origen.DetRemitos.CantidadRegistrosResumido
                  .Fields("IdArticulo").Value = mIdArticulo
                  .Fields("Partida").Value = mPartida
                  .Fields("Cantidad").Value = mPeso
                  .Fields("IdUnidad").Value = mIdUnidad
                  .Fields("IdObra").Value = mIdObra
                  .Fields("IdUbicacion").Value = mIdUbicacion
                  .Fields("OrigenDescripcion").Value = 1
                  .Fields("NumeroCaja").Value = mNumeroCaja
               End With
               .Modificado = True
               mIdDetalle = .Id
            End With
   
            Set oL = Lista.ListItems.Add
            oL.Tag = mIdDetalle
            With oL
               .SmallIcon = "Nuevo"
               .Text = origen.DetRemitos.CantidadRegistrosResumido
               .SubItems(1) = "" & .Tag
               .SubItems(2) = "" & mCodArt
               .SubItems(3) = "" & mArticulo & "  " & mColor
               .SubItems(4) = "" & Format(mPeso, "Fixed")
               .SubItems(5) = "" & mUnidad
               .SubItems(9) = "Mat."
               .SubItems(10) = "" & mUbicacion
               .SubItems(11) = "" & mObra
               .SubItems(12) = "" & mPartida
               .SubItems(13) = "" & mNumeroCaja
            End With
         End If
         oRs.Close
      End If
Proximo:
   Next
   
   If Len(mError) > 0 Then
      mError = mId(mError, 1, Len(mError) - 1)
      MsgBox "Las siguientes cajas ya estaban ingresadas y no fueron tomadas : " & vbCrLf & mError, vbCritical
   End If

Salida:
   Set oRs = Nothing
   MostrarTotales
   
End Sub
