VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.4#0"; "Controles1013.ocx"
Begin VB.Form frmOrdenesCompra 
   Caption         =   "Orden de compra"
   ClientHeight    =   7815
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11685
   Icon            =   "frmOrdenesCompra.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7815
   ScaleWidth      =   11685
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   0
      Left            =   7605
      TabIndex        =   68
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   1
      Left            =   7830
      TabIndex        =   67
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   2
      Left            =   8055
      TabIndex        =   66
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   3
      Left            =   8280
      TabIndex        =   65
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   4
      Left            =   8505
      TabIndex        =   64
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   5
      Left            =   8730
      TabIndex        =   63
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   6
      Left            =   8955
      TabIndex        =   62
      Top             =   2430
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.TextBox txtFechaAprobacion 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      Height          =   315
      Left            =   4230
      TabIndex        =   59
      Top             =   1575
      Width           =   1845
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
      Index           =   0
      Left            =   10080
      TabIndex        =   55
      Top             =   5985
      Width           =   1410
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
      Index           =   1
      Left            =   10080
      TabIndex        =   52
      Top             =   6277
      Width           =   1410
   End
   Begin VB.TextBox txtPorcentajeBonificacion 
      Alignment       =   1  'Right Justify
      DataField       =   "PorcentajeBonificacion"
      Height          =   240
      Left            =   9135
      TabIndex        =   51
      Top             =   6300
      Width           =   405
   End
   Begin VB.Frame Frame2 
      Caption         =   "Grupo : "
      Height          =   735
      Left            =   9225
      TabIndex        =   48
      Top             =   6975
      Visible         =   0   'False
      Width           =   2265
      Begin VB.OptionButton Option6 
         Height          =   195
         Left            =   1170
         TabIndex        =   72
         Top             =   450
         Width           =   1050
      End
      Begin VB.OptionButton Option4 
         Height          =   195
         Left            =   90
         TabIndex        =   50
         Top             =   225
         Width           =   2130
      End
      Begin VB.OptionButton Option5 
         Height          =   195
         Left            =   90
         TabIndex        =   49
         Top             =   450
         Width           =   1050
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Facturar por : "
      Height          =   420
      Left            =   9225
      TabIndex        =   44
      Top             =   2295
      Width           =   2400
      Begin VB.OptionButton Option3 
         Caption         =   "U.Op."
         Height          =   195
         Left            =   1575
         TabIndex        =   47
         Top             =   180
         Width           =   735
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Obra"
         Height          =   195
         Left            =   855
         TabIndex        =   46
         Top             =   180
         Width           =   735
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Cliente"
         Height          =   195
         Left            =   45
         TabIndex        =   45
         Top             =   180
         Width           =   825
      End
   End
   Begin RichTextLib.RichTextBox RichTextBox1 
      Height          =   285
      Left            =   1665
      TabIndex        =   43
      Top             =   5940
      Visible         =   0   'False
      Width           =   1050
      _ExtentX        =   1852
      _ExtentY        =   503
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmOrdenesCompra.frx":076A
   End
   Begin VB.CommandButton cmdImpreInst 
      Caption         =   "Parte instalacion"
      Height          =   510
      Index           =   1
      Left            =   2925
      Picture         =   "frmOrdenesCompra.frx":07F5
      Style           =   1  'Graphical
      TabIndex        =   42
      Top             =   5940
      Visible         =   0   'False
      Width           =   1380
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Anular"
      Enabled         =   0   'False
      Height          =   375
      Index           =   2
      Left            =   90
      TabIndex        =   41
      Top             =   7335
      Width           =   1380
   End
   Begin VB.TextBox txtNumeroOrdenCompraCliente 
      DataField       =   "NumeroOrdenCompraCliente"
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
      Left            =   8910
      TabIndex        =   34
      Top             =   45
      Width           =   2655
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   375
      Index           =   0
      Left            =   90
      TabIndex        =   15
      Top             =   5985
      Width           =   1380
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   375
      Index           =   1
      Left            =   90
      TabIndex        =   14
      Top             =   6435
      Width           =   1380
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   375
      Index           =   0
      Left            =   90
      Picture         =   "frmOrdenesCompra.frx":0D7F
      Style           =   1  'Graphical
      TabIndex        =   13
      Top             =   6885
      UseMaskColor    =   -1  'True
      Width           =   660
   End
   Begin VB.TextBox txtTelefono 
      Enabled         =   0   'False
      Height          =   330
      Left            =   7785
      TabIndex        =   12
      Top             =   1605
      Width           =   1965
   End
   Begin VB.TextBox txtFax 
      Enabled         =   0   'False
      Height          =   330
      Left            =   9780
      TabIndex        =   11
      Top             =   1605
      Width           =   1830
   End
   Begin VB.TextBox txtEmail 
      Enabled         =   0   'False
      Height          =   330
      Left            =   7785
      TabIndex        =   10
      Top             =   1230
      Width           =   3825
   End
   Begin VB.TextBox txtNumeroOrdenCompra 
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
      Left            =   1980
      TabIndex        =   9
      Top             =   45
      Width           =   1530
   End
   Begin VB.TextBox txtCuit 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   315
      Left            =   10215
      TabIndex        =   8
      Top             =   855
      Width           =   1395
   End
   Begin VB.TextBox txtDireccion 
      Enabled         =   0   'False
      Height          =   315
      Left            =   1980
      TabIndex        =   7
      Top             =   855
      Width           =   4095
   End
   Begin VB.TextBox txtLocalidad 
      Enabled         =   0   'False
      Height          =   315
      Left            =   1980
      TabIndex        =   6
      Top             =   1215
      Width           =   2205
   End
   Begin VB.TextBox txtProvincia 
      Enabled         =   0   'False
      Height          =   315
      Left            =   4230
      TabIndex        =   5
      Top             =   1215
      Width           =   1845
   End
   Begin VB.TextBox txtCodigoPostal 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   315
      Left            =   1980
      TabIndex        =   4
      Top             =   1935
      Width           =   1755
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
      Left            =   10080
      TabIndex        =   3
      Top             =   6570
      Width           =   1410
   End
   Begin VB.TextBox txtCondicionIva 
      Enabled         =   0   'False
      Height          =   330
      Left            =   7785
      TabIndex        =   2
      Top             =   825
      Width           =   1620
   End
   Begin VB.TextBox txtCodigoCliente 
      Alignment       =   1  'Right Justify
      Height          =   315
      Left            =   1980
      TabIndex        =   1
      Top             =   495
      Width           =   795
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   375
      Index           =   1
      Left            =   810
      Picture         =   "frmOrdenesCompra.frx":13E9
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   6885
      Width           =   660
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaOrdenCompra"
      Height          =   330
      Index           =   0
      Left            =   4770
      TabIndex        =   16
      Top             =   45
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   57540609
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCliente"
      Height          =   315
      Index           =   0
      Left            =   2835
      TabIndex        =   17
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
      TabIndex        =   18
      Tag             =   "CondicionesCompra"
      Top             =   2295
      Width           =   4110
      _ExtentX        =   7250
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCondicionCompra"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1230
      Left            =   1575
      TabIndex        =   19
      Top             =   6480
      Width           =   6450
      _ExtentX        =   11377
      _ExtentY        =   2170
      _Version        =   393217
      TextRTF         =   $"frmOrdenesCompra.frx":1973
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3165
      Left            =   90
      TabIndex        =   20
      Top             =   2745
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   5583
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmOrdenesCompra.frx":19F5
      OLEDropMode     =   1
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   2
      Left            =   7785
      TabIndex        =   36
      Tag             =   "Obras"
      Top             =   450
      Width           =   3825
      _ExtentX        =   6747
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   3
      Left            =   8100
      TabIndex        =   38
      Tag             =   "Monedas"
      Top             =   7335
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   4275
      Top             =   5940
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
            Picture         =   "frmOrdenesCompra.frx":1A11
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmOrdenesCompra.frx":1B23
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmOrdenesCompra.frx":1F75
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmOrdenesCompra.frx":23C7
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdListaPrecios"
      Height          =   315
      Index           =   7
      Left            =   4320
      TabIndex        =   57
      Tag             =   "ListasPrecios"
      Top             =   1935
      Width           =   1770
      _ExtentX        =   3122
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdListaPrecios"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Aprobo"
      Height          =   315
      Index           =   4
      Left            =   1980
      TabIndex        =   60
      Tag             =   "Empleados"
      Top             =   1575
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdDetalleClienteLugarEntrega"
      Height          =   315
      Index           =   5
      Left            =   7785
      TabIndex        =   70
      Tag             =   "DetalleClientesLugaresEntrega"
      Top             =   1980
      Visible         =   0   'False
      Width           =   3840
      _ExtentX        =   6773
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdDetalleClienteLugarEntrega"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Direccion entrega :"
      Height          =   240
      Index           =   5
      Left            =   6300
      TabIndex        =   71
      Top             =   2025
      Visible         =   0   'False
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Autorizaciones : "
      Height          =   240
      Index           =   3
      Left            =   6345
      TabIndex        =   69
      Top             =   2385
      Width           =   1170
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Liberada por :"
      Height          =   240
      Index           =   4
      Left            =   135
      TabIndex        =   61
      Top             =   1620
      Width           =   1755
   End
   Begin VB.Label lblData 
      Caption         =   "Lista :"
      Height          =   285
      Index           =   3
      Left            =   3825
      TabIndex        =   58
      Top             =   1980
      Width           =   450
   End
   Begin VB.Label Label1 
      Caption         =   "Subtotal :"
      Height          =   240
      Left            =   8055
      TabIndex        =   56
      Top             =   6030
      Width           =   1950
   End
   Begin VB.Label Label2 
      Caption         =   "Bonificacion :"
      Height          =   195
      Left            =   8055
      TabIndex        =   54
      Top             =   6345
      Width           =   1050
   End
   Begin VB.Label Label3 
      Caption         =   " % "
      Height          =   195
      Left            =   9585
      TabIndex        =   53
      Top             =   6345
      Width           =   420
   End
   Begin VB.Label lblEstado 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   4500
      TabIndex        =   40
      Top             =   6030
      Visible         =   0   'False
      Width           =   2670
   End
   Begin VB.Label lblLabels 
      Caption         =   "Moneda :"
      Height          =   195
      Index           =   23
      Left            =   8145
      TabIndex        =   39
      Top             =   7110
      Width           =   720
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Obra :"
      Height          =   285
      Index           =   0
      Left            =   6300
      TabIndex        =   37
      Top             =   495
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de O. Compra (Cliente) :"
      Height          =   240
      Index           =   1
      Left            =   6300
      TabIndex        =   35
      Top             =   90
      Width           =   2475
   End
   Begin VB.Label lblLabels 
      Caption         =   "Telefono / Fax :"
      Height          =   330
      Index           =   0
      Left            =   6300
      TabIndex        =   33
      Top             =   1605
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Email :"
      Height          =   330
      Index           =   7
      Left            =   6300
      TabIndex        =   32
      Top             =   1185
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de O. Compra :"
      Height          =   240
      Index           =   21
      Left            =   135
      TabIndex        =   31
      Top             =   90
      Width           =   1755
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   22
      Left            =   3825
      TabIndex        =   30
      Top             =   90
      Width           =   900
   End
   Begin VB.Label lblLabels 
      Caption         =   "C.U.I.T. :"
      Height          =   285
      Index           =   6
      Left            =   9450
      TabIndex        =   29
      Top             =   855
      Width           =   720
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cliente:"
      Height          =   285
      Index           =   2
      Left            =   135
      TabIndex        =   28
      Top             =   510
      Width           =   1755
   End
   Begin VB.Label lblLabels 
      Caption         =   "Direcci�n :"
      Height          =   285
      Index           =   10
      Left            =   135
      TabIndex        =   27
      Top             =   885
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
      Caption         =   "Codigo postal :"
      Height          =   285
      Index           =   13
      Left            =   135
      TabIndex        =   25
      Top             =   1980
      Width           =   1755
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cond. de Compra :"
      Height          =   240
      Index           =   16
      Left            =   135
      TabIndex        =   24
      Top             =   2340
      Width           =   1755
   End
   Begin VB.Label Label6 
      BackColor       =   &H00FFFFFF&
      Caption         =   "TOTAL O. COMPRA:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000010&
      Height          =   285
      Left            =   8055
      TabIndex        =   23
      Top             =   6615
      Width           =   1950
   End
   Begin VB.Line Line2 
      BorderColor     =   &H80000005&
      BorderWidth     =   3
      X1              =   10080
      X2              =   11490
      Y1              =   5940
      Y2              =   5940
   End
   Begin VB.Label lblLabels 
      Caption         =   "Condicion IVA ::"
      Height          =   285
      Index           =   4
      Left            =   6300
      TabIndex        =   22
      Top             =   855
      Width           =   1395
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Observaciones :"
      Height          =   195
      Index           =   17
      Left            =   1620
      TabIndex        =   21
      Top             =   6255
      Width           =   1155
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
         Caption         =   "Marcar como cumplido"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Desmarcar como cumplido"
         Index           =   4
         Visible         =   0   'False
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar fecha estimada de entrega"
         Index           =   5
      End
   End
End
Attribute VB_Name = "frmOrdenesCompra"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.OrdenCompra
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private cALetra As New clsNum2Let
Private mvarId As Long, mIdAprobo As Long
Private mvarIdCliente As Integer, mvarTipoIVA As Integer, mCantidadFirmas As Integer
Private mvarP_IVA1 As Double, mvarP_IVA2 As Double, mvarDecimales As Double, mvarTotal As Double
Private mvarAnulada As String, mLimitarObrasPorCliente As String, mActivarDireccionesEntrega As String
Private mvarGrabado As Boolean, mvarLiberada As Boolean, mNumeroOCClienteAutomatico As Boolean
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

   If Not IsNumeric(dcfields(2).BoundText) Then
      MsgBox "Antes de acceder a un item debe definir la obra", vbExclamation
      Exit Sub
   End If
   
   Dim oF As frmDetOrdenesCompra
   Dim oL As ListItem
   Dim mCant As Double, mPrecio As Double, mPorcB As Double
   
   Set oF = New frmDetOrdenesCompra
   
   With oF
      Set .OrdenCompra = origen
      .IdObra = dcfields(2).BoundText
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = Lista.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = Lista.SelectedItem
         End If
         mCant = Val(oF.txtCantidad.Text)
         mPrecio = Val(oF.txtPrecio.Text)
         mPorcB = Val(oF.txtPorcentajeBonificacion.Text)
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtItem.Text
            .SubItems(1) = "" & oF.txtCodigoArticulo.Text
            .SubItems(2) = "" & oF.DataCombo1(1).Text
            .SubItems(3) = "" & oF.DataCombo1(2).Text
            .SubItems(4) = "" & Format(mCant, "Fixed")
            .SubItems(5) = "" & oF.DataCombo1(0).Text
            .SubItems(6) = "" & Format(mPrecio, "#,##0.00")
            .SubItems(7) = "" & Format(mPorcB / 100, "Percent")
            .SubItems(9) = "" & Format(mCant * mPrecio * mPorcB / 100, "#,##0.00")
            .SubItems(10) = "" & Format(mCant * mPrecio * (1 - mPorcB / 100), "#,##0.00")
            .SubItems(11) = "" & Aplicacion.StockPorIdArticulo(oF.DataCombo1(1).BoundText)
            .SubItems(12) = "" & oF.DTFields(1).Value
            .SubItems(13) = "" & oF.DTFields(2).Value
            .SubItems(14) = "" & oF.rchObservaciones.Text
         End With
      End If
   End With
   
   Unload oF
   Set oF = Nothing

   CalculaOrdenCompra

End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         If Len(txtNumeroOrdenCompraCliente.Text) = 0 And Not mNumeroOCClienteAutomatico Then
            MsgBox "Debe ingresar el numero de orden de compra del cliente"
            Exit Sub
         End If
         
         If Frame2.Visible And Not (Option4.Value Or Option5.Value Or Option6.Value) Then
            MsgBox "Debe ingresar el grupo para facturacion automatica"
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim mvarImprime As Integer
         Dim mvarNumero As Long
         Dim oRs As ADOR.Recordset
     
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar una OrdenCompra sin detalles"
            Exit Sub
         End If
         
         'Me.MousePointer = vbHourglass
      
         With origen.Registro
            For Each dtp In DTFields
               If ExisteCampo(origen.Registro, dtp.DataField) Then
                  .Fields(dtp.DataField).Value = dtp.Value
               End If
            Next
            
            For Each dc In dcfields
               If ExisteCampo(origen.Registro, dc.DataField) Then
                  If Not IsNumeric(dc.BoundText) And dc.Enabled And dc.Visible And dc.Index <> 4 And dc.Index <> 7 Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
                  If IsNumeric(dc.BoundText) Then .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
         
            .Fields("ImporteTotal").Value = mvarTotal
'            .Fields("ImporteIva1").Value = mvarIVA1
'            .Fields("PorcentajeIva1").Value = mvarP_IVA1
'            .Fields("PorcentajeIva2").Value = mvarP_IVA2
            If Option1.Value Then
               .Fields("AgrupacionFacturacion").Value = 1
            ElseIf Option2.Value Then
               .Fields("AgrupacionFacturacion").Value = 2
            Else
               .Fields("AgrupacionFacturacion").Value = 3
            End If
            If Option4.Value Then
               .Fields("Agrupacion2Facturacion").Value = 1
            ElseIf Option5.Value Then
               .Fields("Agrupacion2Facturacion").Value = 2
            ElseIf Option6.Value Then
               .Fields("Agrupacion2Facturacion").Value = 3
            End If
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
            Dim oPar As ComPronto.Parametro
            Set oPar = Aplicacion.Parametros.Item(1)
            With oPar.Registro
               mvarNumero = .Fields("ProximoNumeroOrdenCompra").Value
               .Fields("ProximoNumeroOrdenCompra").Value = mvarNumero + 1
               origen.Registro.Fields("NumeroOrdenCompra").Value = mvarNumero
               If mNumeroOCClienteAutomatico Then
                  origen.Registro.Fields("NumeroOrdenCompraCliente").Value = Format(mvarNumero, "00000000")
               End If
            End With
            oPar.Guardar
            Set oPar = Nothing
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
            .ListaEditada = "OrdenesCompraTodas, OrdenesCompraAgrupadas, +SubOC2"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
         Me.MousePointer = vbDefault
   
'         mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de la OrdenCompra")
'         If mvarImprime = vbYes Then
'            cmdImpre_Click 0
'         End If
      
         Unload Me

      Case 1
      
         Unload Me

      Case 2
   
         AnularOrdenDeCompra
         
   End Select
   
   Set cALetra = Nothing
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oDet As DetOrdenCompra
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   Dim ListaVacia As Boolean, mAsignarAprobo As Boolean
   Dim mAux As String
   Dim i As Integer
   Dim mVector
   
   mvarId = vnewvalue
   ListaVacia = False
   
   Set oAp = Aplicacion
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)
   End With
   oRs.Close
   
   Set origen = oAp.OrdenesCompra.Item(vnewvalue)
   
   If vnewvalue = -1 Then
      origen.Registro.Fields("IdMoneda").Value = 1
      mvarIdCliente = 0
   Else
      mvarIdCliente = IIf(IsNull(origen.Registro.Fields("IdCliente").Value), 0, origen.Registro.Fields("IdCliente").Value)
   End If
   
   mvarAnulada = "NO"
   
   mLimitarObrasPorCliente = BuscarClaveINI("Limitar obras por cliente")
   mAsignarAprobo = False
   If BuscarClaveINI("Asignar aprobo automaticamente en ordenes de compra") = "SI" Then mAsignarAprobo = True
   
   mNumeroOCClienteAutomatico = False
   If BuscarClaveINI("Asignar numero de orden de compra del cliente automaticamente") = "SI" Then mNumeroOCClienteAutomatico = True
   
   mActivarDireccionesEntrega = BuscarClaveINI("Activar direccion de entrega en ordenes de compra")
   If mActivarDireccionesEntrega = "SI" Then
      lblLabels(5).Visible = True
      dcfields(5).Visible = True
   End If
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            If oControl.Name = "Lista" Then
               If vnewvalue < 0 Then
                  Set oControl.DataSource = origen.DetOrdenesCompra.TraerMascara
                  ListaVacia = True
               Else
                  Set oRs = origen.DetOrdenesCompra.TraerTodos
                  If oRs.RecordCount <> 0 Then
                     Set oControl.DataSource = oRs
                     oRs.MoveFirst
                     Do While Not oRs.EOF
                        Set oDet = origen.DetOrdenesCompra.Item(oRs.Fields(0).Value)
                        oDet.Modificado = True
                        Set oDet = Nothing
                        oRs.MoveNext
                     Loop
                     ListaVacia = False
                  Else
                     Set oControl.DataSource = origen.DetOrdenesCompra.TraerMascara
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
               If oControl.Tag = "Obras" Then
                  If mLimitarObrasPorCliente <> "SI" Then
                     If glbSe�al1 Then
                        Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", Date))
                     Else
                        Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo")
                     End If
                  End If
               ElseIf oControl.Tag = "DetalleClientesLugaresEntrega" Then
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
   
   If mvarId = -1 Then
      For Each dtf In DTFields
         dtf.Value = Now
      Next
      With origen.Registro
         If mAsignarAprobo Then .Fields("Aprobo").Value = glbIdUsuario
      End With
      rchObservaciones.Text = ""
      Option1.Value = True
      Lista.ListItems.Clear
      mvarGrabado = False
      mvarLiberada = False
      mIdAprobo = 0
   Else
      With origen.Registro
         If Not IsNull(.Fields("Anulada").Value) And .Fields("Anulada").Value = "SI" Then
            With lblEstado
               .Caption = "ANULADA"
               .Visible = True
            End With
            mvarAnulada = "SI"
         End If
         If IsNull(.Fields("AgrupacionFacturacion").Value) Or .Fields("AgrupacionFacturacion").Value = 1 Then
            Option1.Value = True
         ElseIf Not IsNull(.Fields("AgrupacionFacturacion").Value) And .Fields("AgrupacionFacturacion").Value = 2 Then
            Option2.Value = True
         ElseIf Not IsNull(.Fields("AgrupacionFacturacion").Value) And .Fields("AgrupacionFacturacion").Value = 3 Then
            Option3.Value = True
         Else
            Option1.Value = True
         End If
         If IsNull(.Fields("Agrupacion2Facturacion").Value) Or .Fields("Agrupacion2Facturacion").Value = 1 Then
            Option4.Value = True
         ElseIf Not IsNull(.Fields("Agrupacion2Facturacion").Value) And .Fields("Agrupacion2Facturacion").Value = 2 Then
            Option5.Value = True
         ElseIf Not IsNull(.Fields("Agrupacion2Facturacion").Value) And .Fields("Agrupacion2Facturacion").Value = 3 Then
            Option6.Value = True
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
         If Not IsNull(.Fields("Aprobo").Value) Then
            mIdAprobo = .Fields("Aprobo").Value
            mvarLiberada = True
            Check1(0).Value = 1
            dcfields(4).Enabled = False
         End If
         If Not IsNull(.Fields("FechaAprobacion").Value) Then
            txtFechaAprobacion.Text = .Fields("FechaAprobacion").Value
         End If
      End With
      
      mCantidadFirmas = 0
      Set oRs = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(EnumFormularios.OrdenesCompra, 0))
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            mCantidadFirmas = mCantidadFirmas + 1
            Check1(mCantidadFirmas).Visible = True
            Check1(mCantidadFirmas).Tag = oRs.Fields(0).Value
            oRs.MoveNext
         Loop
      End If
      oRs.Close
      Set oRs = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(EnumFormularios.OrdenesCompra, mvarId))
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            For i = 1 To mCantidadFirmas
               If Check1(i).Tag = oRs.Fields("OrdenAutorizacion").Value Then
                  Check1(i).Value = 1
                  Exit For
               End If
            Next
            oRs.MoveNext
         Loop
      End If
      oRs.Close
   End If
   
   If ListaVacia Then Lista.ListItems.Clear
   
   Set oRs = Nothing
   Set oAp = Nothing

   CalculaOrdenCompra
   
   If BuscarClaveINI("Mostrar parte de instalacion") = "SI" Then cmdImpreInst(1).Visible = True
   
   mAux = BuscarClaveINI("Activar grupo para facturacion automatica")
   If Len(mAux) > 0 Then
      rchObservaciones.Width = rchObservaciones.Width * 0.8
      mVector = VBA.Split(mAux, ",")
      Option4.Caption = mVector(0)
      Option5.Caption = mVector(1)
      Option6.Caption = mVector(2)
      Frame2.Visible = True
   End If
   
   cmd(0).Enabled = False
   cmd(2).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      cmd(2).Enabled = True
   End If
   
   If mvarId <= 0 Then cmd(2).Enabled = False
   
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

'   If DTFields(0).Value <= gblFechaUltimoCierre Then
'      cmd(0).Enabled = False
'   End If

End Property

Private Sub cmdImpre_Click(Index As Integer)

   Dim mvarOK As Boolean
   Dim mCopias As Integer
   Dim mPrinter As String, mPrinterAnt As String
   
   mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
   If Index = 0 Then
      mCopias = Val(BuscarClaveINI("CopiasOrdenesCompra", -1))
      If mCopias = 0 Then mCopias = 2
      
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

   On Error GoTo Mal

   Dim oW As Word.Application
   Dim mPID As String
   
   If Index = 0 Then CargaProcesosEnEjecucion
   Set oW = CreateObject("Word.Application")
   If Index = 0 Then mPID = ObtenerPIDProcesosLanzados
   
   oW.Visible = True
   oW.Documents.Add (glbPathPlantillas & "\OrdenCompra_" & glbEmpresaSegunString & ".dot")
   oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId
   oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
   oW.Application.Run MacroName:="DatosDelPie"
   If Index = 0 Then
      If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
      oW.Documents(1).PrintOut False, , , , , , , mCopias
      If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
      oW.Documents(1).Close False
      If glbTerminarProcesosOffice Then
         TerminarProceso mPID
      Else
         oW.Quit
      End If
   End If

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

Private Sub cmdImpreInst_Click(Index As Integer)

   If Not IsNumeric(dcfields(2).BoundText) Then
      MsgBox "Debe definir la obra", vbExclamation
      Exit Sub
   End If
   
   EmisionParteInstalacion dcfields(2).BoundText, 0, DTFields(0).Value

End Sub

Private Sub dcfields_Change(Index As Integer)
      
   If Len(dcfields(Index).BoundText) = 0 Or Not IsNumeric(dcfields(Index).BoundText) Then
      Exit Sub
   End If
   Select Case Index
      Case 0
         Dim mCampoId As Long
         Dim oRs As ADOR.Recordset
         If mLimitarObrasPorCliente = "SI" Then
            mCampoId = 0
            If mvarId <= 0 Then
               If IsNumeric(dcfields(2).BoundText) Then mCampoId = dcfields(2).BoundText
            Else
               mCampoId = IIf(IsNull(origen.Registro.Fields("IdObra").Value), 0, origen.Registro.Fields("IdObra").Value)
            End If
            Set dcfields(2).RowSource = Aplicacion.Obras.TraerFiltrado("_PorIdClienteParaCombo", dcfields(0).BoundText)
            dcfields(2).Refresh
            dcfields(2).BoundText = mCampoId
         End If
         
         If mActivarDireccionesEntrega = "SI" Then
            mCampoId = IIf(IsNull(origen.Registro.Fields("IdDetalleClienteLugarEntrega").Value), 0, origen.Registro.Fields("IdDetalleClienteLugarEntrega").Value)
            Set oRs = Aplicacion.Clientes.TraerFiltrado("_LugaresEntrega", dcfields(0).BoundText)
            If oRs.RecordCount = 1 Then mCampoId = oRs.Fields(0).Value
            Set dcfields(5).RowSource = oRs
            dcfields(5).Refresh
            dcfields(5).BoundText = mCampoId
            Set oRs = Nothing
         End If
         
         MostrarDatos (0)
   End Select
   
End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   SetDataComboDropdownListWidth 400
   
   If IsNumeric(dcfields(Index).BoundText) Then
      Select Case Index
         Case 4
            If dcfields(Index).BoundText <> mIdAprobo Then
               PideAutorizacion
            End If
      End Select
   End If

End Sub

Private Sub dcfields_Validate(Index As Integer, Cancel As Boolean)

   If IsNumeric(dcfields(Index).BoundText) Then
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
   
End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Load()

   Dim oRs As ADOR.Recordset
   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16 ' Que imagelist utiliza
      .IconoPeque�o = "Original" ' Nombre del icono que debe mostrar al cargar
   End With
   
'   For Each oI In Img16.ListImages
'      With Estado.Panels.Add(, , oI.Key)
'         .Picture = oI.Picture
'      End With
'   Next

   Set oRs = Aplicacion.Parametros.Item(1).Registro
   
   With oRs
      mvarP_IVA1 = .Fields("Iva1").Value
      mvarP_IVA2 = .Fields("Iva2").Value
      mvarDecimales = .Fields("Decimales").Value
      If mvarId < 0 Then
         txtNumeroOrdenCompra.Text = .Fields("ProximoNumeroOrdenCompra").Value
         If mNumeroOCClienteAutomatico Then
            origen.Registro.Fields("NumeroOrdenCompraCliente").Value = Format(.Fields("ProximoNumeroOrdenCompra").Value, "00000000")
         End If
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

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyDelete Then
      MnuDetA_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetA_Click 0
'   ElseIf KeyCode = vbKeyReturn Then
'      MnuDetA_Click 1
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

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long, NroItem As Long, idDet As Long
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then
      
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      If mvarId > 0 Then
         MsgBox "Solo puede copiar datos a una orden de compra nueva", vbCritical
         Exit Sub
      End If
   
      If InStr(1, Columnas(LBound(Columnas) + 3), "Nro. interno") <> 0 And InStr(1, Columnas(LBound(Columnas) + 4), "Fecha") <> 0 Then
      
         Columnas = Split(Filas(1), vbTab)
         
         Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_PorId", Columnas(2))
         
         With origen.Registro
            For i = 1 To oRs.Fields.Count - 1
               If oRs.Fields(i).Name <> "NumeroOrdenCompra" And _
                     oRs.Fields(i).Name <> "Anulada" And _
                     oRs.Fields(i).Name <> "FechaAnulacion" And _
                     oRs.Fields(i).Name <> "IdUsuarioAnulacion" Then
                  .Fields(i).Value = oRs.Fields(i).Value
               End If
            Next
         End With
         oRs.Close
   
         Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_DetallePorId", Columnas(2))
         
         Do While Not oRs.EOF
            With origen.DetOrdenesCompra.Item(-1)
               For i = 2 To oRs.Fields.Count - 1
                  .Registro.Fields(i).Value = oRs.Fields(i).Value
               Next
               .Modificado = True
            End With
            oRs.MoveNext
         Loop
         oRs.Close
         
         Set oRs = Nothing
            
         Set Lista.DataSource = origen.DetOrdenesCompra.RegistrosConFormato
         
         MostrarDatos (0)
         CalculaOrdenCompra
         
      Else
         
         MsgBox "Objeto invalido!"
         Exit Sub
      
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
         Dim oRs As ADOR.Recordset
         Dim mErr As String
         With Lista.SelectedItem
            Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_RemitosFacturasPorIdDetalleOrdenCompra", .Tag)
            mErr = ""
            If oRs.RecordCount > 0 Then
               oRs.MoveFirst
               Do While Not oRs.EOF
                  mErr = mErr & vbCrLf & oRs.Fields("Numero").Value
                  oRs.MoveNext
               Loop
            End If
            oRs.Close
            Set oRs = Nothing
            If Len(mErr) > 0 Then
               MsgBox "No puede eliminar el item porque hacen referencia a el los comprobantes :" & mErr
               Exit Sub
            End If
            origen.DetOrdenesCompra.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
      
      Case 3
         If mNivelAcceso > 1 Then
            MsgBox "Nivel de acceso insuficiente!", vbCritical
            Exit Sub
         End If
         DarPorCumplido
         
'      Case 4
'         If mNivelAcceso > 1 Then
'            MsgBox "Nivel de acceso insuficiente!", vbCritical
'            Exit Sub
'         End If
'         If Not Lista.SelectedItem Is Nothing Then
'            With Lista.SelectedItem
'               origen.DetOrdenesCompra.Item(.Tag).Registro.Fields("Cumplido").Value = Null
'               origen.DetOrdenesCompra.Item(.Tag).Modificado = True
'               .SubItems(14) = ""
'            End With
'         End If
         
      Case 5
         AsignaFechaEntrega
   
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

   Dim mvarLocalidad, mvarZona, mvarVendedor, mvarTransportista, mvarProvincia, mvarCondicionVenta, mvarTipoVentaC As Integer
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
      mvarLocalidad = IIf(IsNull(.Fields("IdLocalidad").Value), 0, .Fields("IdLocalidad").Value)
      mvarZona = 0
      mvarProvincia = IIf(IsNull(.Fields("IdProvincia").Value), 0, .Fields("IdProvincia").Value)
      mvarTipoIVA = IIf(IsNull(.Fields("IdCodigoIva").Value), 0, .Fields("IdCodigoIva").Value)
      If Not IsNull(.Fields("IdMoneda").Value) Then
         If mvarId <= 0 Or Len(dcfields(3).Text) = 0 Then
            dcfields(3).BoundText = .Fields("IdMoneda").Value
         End If
      End If
      If Not IsNull(.Fields("IdCondicionVenta").Value) Then
         If mvarId <= 0 Or Len(dcfields(1).Text) = 0 Then
            dcfields(1).BoundText = .Fields("IdCondicionVenta").Value
         End If
      End If
      If Not IsNull(.Fields("IdListaPrecios").Value) And mvarId <= 0 Then 'Or Len(dcfields(7).Text) = 0 Then
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
      txtNumeroOrdenCompra.Text = origen.Registro.Fields("NumeroOrdenCompra").Value
   End If
   
   Me.MousePointer = vbDefault
   
End Sub

Private Sub txtCodigoCliente_Change()

'   If Len(txtCodigoCliente.Text) > 0 Then
'      Dim oRs As ADOR.Recordset
'      Set oRs = Aplicacion.Clientes.TraerFiltrado("_PorCodigo", txtCodigoCliente.Text)
'      If oRs.RecordCount > 0 Then
'         origen.Registro.Fields("IdCliente").Value = oRs.Fields(0).Value
'      Else
'         origen.Registro.Fields("IdCliente").Value = Null
'      End If
'      oRs.Close
'      Set oRs = Nothing
'   End If

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

Private Sub txtNumeroOrdenCompra_Change()
   
   If mvarId > 0 Then
      MostrarDatos (0)
   End If

End Sub

Private Sub txtNumeroOrdenCompra_Validate(Cancel As Boolean)
   
   If mvarId < 0 Then
   
      Dim oRs As ADOR.Recordset
      
      Me.MousePointer = vbHourglass
      
      Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("Cod", Val(txtNumeroOrdenCompra.Text))
   
      If oRs.RecordCount > 0 Then
         MsgBox "OrdenCompra ya ingresada el " & oRs.Fields("FechaOrdenCompra").Value & ". Reingrese.", vbCritical
         Cancel = True
      End If
      
      oRs.Close
      Set oRs = Nothing
      
      Me.MousePointer = vbDefault
      
   End If

End Sub

Private Sub CalculaOrdenCompra()

   Dim oRs As ADOR.Recordset
   Dim oL As ListItem
   Dim i As Integer
   Dim mCant As Double, mPrecio As Double, mPorcB As Double, mBonif As Double
   Dim mvarSubTotal As Double
   
   mvarSubTotal = 0
   
   For Each oL In Lista.ListItems
      With origen.DetOrdenesCompra.Item(oL.Tag)
         If Not .Eliminado Then
            With .Registro
               mCant = IIf(IsNull(.Fields("Cantidad").Value), 0, .Fields("Cantidad").Value)
               mPrecio = IIf(IsNull(.Fields("Precio").Value), 0, .Fields("Precio").Value)
               mPorcB = IIf(IsNull(.Fields("PorcentajeBonificacion").Value), 0, .Fields("PorcentajeBonificacion").Value)
            End With
            mvarSubTotal = mvarSubTotal + (mCant * mPrecio * (1 - mPorcB / 100))
         End If
      End With
   Next
   
   mPorcB = Val(txtPorcentajeBonificacion.Text)
   mBonif = mvarSubTotal * mPorcB / 100
   mvarTotal = mvarSubTotal - mBonif
   
   If mvarId > 0 Then
      With origen.Registro
      
      End With
   Else
   
   End If
   
   txtTotal(0).Text = Format(mvarSubTotal, "#,##0.00")
   txtTotal(1).Text = Format(mBonif, "#,##0.00")
   txtTotal(8).Text = Format(mvarTotal, "#,##0.00")
   
End Sub

Public Sub AnularOrdenDeCompra()

   Dim oRs As ADOR.Recordset
   Dim s As String
   s = ""
   Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_ItemsApuntadosPorIdOrdenCompra", mvarId)
   If oRs.RecordCount > 0 Then
      oRs.MoveFirst
      Do While Not oRs.EOF
         s = s & "Item de OC : " & oRs.Fields("NumeroItem").Value & ", " & _
                  "Comprob.: " & oRs.Fields("Tipo").Value & " " & _
                  Format(oRs.Fields("Numero").Value, "00000000") & " " & _
                  "del " & oRs.Fields("Fecha").Value & vbCrLf
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   Set oRs = Nothing
   
   If Len(s) > 0 Then
      MsgBox "Hay items de la orden de compra apuntados por los siguientes comprobantes :" & vbCrLf & _
             "" & vbCrLf & s, vbExclamation
      Exit Sub
   End If
   
   Dim oF As frmAutorizacion
   Dim mOk As Boolean
   Dim mIdAutorizaAnulacion As Integer
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.OrdenesCompra
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
   mSeguro = MsgBox("Esta seguro de anular la orden de compra?", vbYesNo, "Anulacion de orden de compra")
   If mSeguro = vbNo Then
      Exit Sub
   End If

   With origen
      .Registro.Fields("Anulada").Value = "SI"
      .Registro.Fields("IdUsuarioAnulacion").Value = mIdAutorizaAnulacion
      .Registro.Fields("FechaAnulacion").Value = Now
      .Guardar
   End With

   With actL2
      .ListaEditada = "OrdenesCompra"
      .AccionRegistro = Modificacion
      .Disparador = mvarId
   End With
   
   Unload Me

End Sub

Public Function HayInstalaciones() As Boolean

   Dim oRs As ADOR.Recordset
   
   Set oRs = origen.DetOrdenesCompra.Registros
   
   HayInstalaciones = False
   With oRs
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               If Not .Fields("Eliminado").Value Then
                  If InStr(1, BuscarClaveINI("Conceptos de instalacion"), .Fields("IdArticulo").Value) <> 0 Then
                     HayInstalaciones = True
                     Exit Do
                  End If
               End If
               .MoveNext
            Loop
            .MoveFirst
         End If
      End If
   End With
   
   Set oRs = Nothing

End Function

Private Sub txtPorcentajeBonificacion_Change()

   CalculaOrdenCompra

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

Public Sub AsignaFechaEntrega()

   Dim mvarOK As Boolean, mvarCancelo As Boolean
   
   Dim oF As frmAutorizacion2
   Set oF = New frmAutorizacion2
   With oF
      .Sector = "Produccion"
      .Cargo = "Jefe"
      .Show vbModal, Me
   End With
   mvarOK = oF.Ok
   mvarCancelo = oF.Cancelo
   Unload oF
   Set oF = Nothing
   If mvarCancelo Then Exit Sub
   If Not mvarOK Then Exit Sub
   
   Dim oF1 As frmAsignaFechaNecesidad
   Dim oL As ListItem
   Dim oDet As ComPronto.DetOrdenCompra
   Dim mvarFecha As Date
   
   Set oF1 = New frmAsignaFechaNecesidad
   With oF1
      .Show vbModal, Me
      mvarOK = .Ok
      mvarFecha = .DTFields(0).Value
   End With
   Unload oF1
   Set oF1 = Nothing
   If Not mvarOK Then Exit Sub
   
   For Each oL In Lista.ListItems
      With oL
         If .Selected Then
            .SubItems(13) = "" & mvarFecha
            Set oDet = origen.DetOrdenesCompra.Item(.Tag)
            oDet.Registro.Fields("FechaEntrega").Value = mvarFecha
            oDet.Modificado = True
            Set oDet = Nothing
            .SmallIcon = "Modificado"
         End If
      End With
   Next
   
End Sub

Private Sub PideAutorizacion()

   Dim oF As frmAutorizacion1
   Set oF = New frmAutorizacion1
   With oF
      .IdUsuario = dcfields(4).BoundText
      .Show vbModal, Me
   End With
   If Not oF.Ok Then
      With origen.Registro
         .Fields("Aprobo").Value = Null
         .Fields("FechaAprobacion").Value = Null
         mIdAprobo = 0
         Check1(0).Value = 0
      End With
   Else
      With origen.Registro
         .Fields("FechaAprobacion").Value = Now
         mIdAprobo = IIf(IsNull(.Fields("Aprobo").Value), 0, .Fields("Aprobo").Value)
         txtFechaAprobacion.Text = Now
         Check1(0).Value = 1
      End With
   End If
   Unload oF
   Set oF = Nothing

End Sub

Private Sub DarPorCumplido()

   Dim mvarOK As Boolean
   Dim mvarIdAutorizo As Long
   Dim oF As frmAutorizacion
   
   Set oF = New frmAutorizacion
   With oF
      .IdFormulario = EnumFormularios.OrdenesCompra
      .Show vbModal, Me
      mvarOK = .Ok
      mvarIdAutorizo = .IdAutorizo
   End With
   Unload oF
   Set oF = Nothing
   
   If Not mvarOK Then Exit Sub
   
   Dim oF1 As frmAsignarComoCumplido
   Dim oL As ListItem
   Dim oRs1 As ADOR.Recordset
   Dim mvarIdDioPorCumplido As Long
   Dim i As Integer
   Dim mAux1 As String, mvarObservacionesCumplido As String
   Dim Filas, Columnas
   
   Set oF1 = New frmAsignarComoCumplido
   With oF1
      .Show vbModal, Me
      mvarOK = .Ok
      If IsNumeric(.dcfields(1).BoundText) Then mvarIdDioPorCumplido = .dcfields(1).BoundText
      mvarObservacionesCumplido = .rchObservacionesCumplido.Text
   End With
   Unload oF1
   Set oF1 = Nothing
   
   If Not mvarOK Then Exit Sub
   
   Filas = VBA.Split(Lista.GetString, vbCrLf)
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      If Columnas(15) = "" Then
         With origen.DetOrdenesCompra.Item(Columnas(0))
            .Registro.Fields("Cumplido").Value = "SI"
            .Registro.Fields("IdDioPorCumplido").Value = mvarIdDioPorCumplido
            .Registro.Fields("FechaDadoPorCumplido").Value = Now
            .Registro.Fields("ObservacionesCumplido").Value = mvarObservacionesCumplido
            .Modificado = True
         End With
      End If
   Next
   For Each oL In Lista.ListItems
      If oL.Selected Then oL.SubItems(15) = "SI"
   Next
   
End Sub

