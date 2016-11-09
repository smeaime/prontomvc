VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmConsulta3 
   ClientHeight    =   6390
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11685
   LinkTopic       =   "Form1"
   ScaleHeight     =   6390
   ScaleWidth      =   11685
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
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
      Left            =   9945
      TabIndex        =   51
      Top             =   5355
      Visible         =   0   'False
      Width           =   1410
   End
   Begin VB.Frame Frame5 
      Height          =   420
      Left            =   6165
      TabIndex        =   36
      Top             =   495
      Visible         =   0   'False
      Width           =   5370
      Begin VB.OptionButton Option13 
         Height          =   195
         Left            =   1845
         TabIndex        =   39
         Top             =   180
         Width           =   1500
      End
      Begin VB.OptionButton Option12 
         Height          =   195
         Left            =   225
         TabIndex        =   38
         Top             =   180
         Width           =   1500
      End
      Begin VB.OptionButton Option14 
         Height          =   195
         Left            =   3420
         TabIndex        =   37
         Top             =   180
         Width           =   1815
      End
   End
   Begin VB.CommandButton cmd 
      Height          =   450
      Index           =   1
      Left            =   1530
      TabIndex        =   30
      Top             =   5445
      Width           =   1350
   End
   Begin VB.CommandButton cmd 
      Height          =   450
      Index           =   0
      Left            =   135
      TabIndex        =   29
      Top             =   5445
      Width           =   1350
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   450
      Index           =   2
      Left            =   2925
      TabIndex        =   28
      Top             =   5445
      Width           =   1350
   End
   Begin VB.TextBox txtBuscar 
      Height          =   330
      Index           =   0
      Left            =   6030
      TabIndex        =   27
      Top             =   6030
      Visible         =   0   'False
      Width           =   645
   End
   Begin VB.TextBox txtBuscar 
      Height          =   330
      Index           =   1
      Left            =   6750
      TabIndex        =   26
      Top             =   6030
      Visible         =   0   'False
      Width           =   645
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   5175
      TabIndex        =   25
      Top             =   6030
      Visible         =   0   'False
      Width           =   330
   End
   Begin VB.Frame Frame2 
      Height          =   465
      Left            =   135
      TabIndex        =   19
      Top             =   6525
      Visible         =   0   'False
      Width           =   8340
      Begin VB.OptionButton Option3 
         Height          =   195
         Left            =   135
         TabIndex        =   24
         Top             =   180
         Width           =   1635
      End
      Begin VB.OptionButton Option4 
         Height          =   195
         Left            =   1770
         TabIndex        =   23
         Top             =   180
         Width           =   1635
      End
      Begin VB.OptionButton Option5 
         Height          =   195
         Left            =   3405
         TabIndex        =   22
         Top             =   180
         Width           =   1635
      End
      Begin VB.OptionButton Option10 
         Height          =   195
         Left            =   5040
         TabIndex        =   21
         Top             =   180
         Width           =   1635
      End
      Begin VB.OptionButton Option11 
         Height          =   195
         Left            =   6660
         TabIndex        =   20
         Top             =   180
         Width           =   1635
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Tipo de consulta : "
      Height          =   510
      Left            =   5940
      TabIndex        =   14
      Top             =   5400
      Visible         =   0   'False
      Width           =   4110
      Begin VB.OptionButton Option9 
         Caption         =   "Por año"
         Height          =   195
         Left            =   3150
         TabIndex        =   18
         Top             =   225
         Width           =   915
      End
      Begin VB.OptionButton Option8 
         Caption         =   "Por mes"
         Height          =   195
         Left            =   2205
         TabIndex        =   17
         Top             =   225
         Width           =   915
      End
      Begin VB.OptionButton Option7 
         Caption         =   "Por semana"
         Height          =   195
         Left            =   990
         TabIndex        =   16
         Top             =   225
         Width           =   1185
      End
      Begin VB.OptionButton Option6 
         Caption         =   "Por dia"
         Height          =   195
         Left            =   90
         TabIndex        =   15
         Top             =   225
         Width           =   870
      End
   End
   Begin VB.Frame Frame1 
      Height          =   465
      Left            =   135
      TabIndex        =   11
      Top             =   5985
      Visible         =   0   'False
      Width           =   3975
      Begin VB.OptionButton Option1 
         Height          =   195
         Left            =   360
         TabIndex        =   13
         Top             =   180
         Width           =   1635
      End
      Begin VB.OptionButton Option2 
         Height          =   195
         Left            =   2025
         TabIndex        =   12
         Top             =   180
         Width           =   1815
      End
   End
   Begin VB.Frame Frame4 
      Height          =   465
      Left            =   135
      TabIndex        =   8
      Top             =   7065
      Visible         =   0   'False
      Width           =   3975
      Begin VB.OptionButton Option16 
         Height          =   195
         Left            =   2025
         TabIndex        =   10
         Top             =   180
         Width           =   1815
      End
      Begin VB.OptionButton Option15 
         Height          =   195
         Left            =   360
         TabIndex        =   9
         Top             =   180
         Width           =   1635
      End
   End
   Begin VB.TextBox Text2 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   5580
      TabIndex        =   7
      Top             =   6030
      Visible         =   0   'False
      Width           =   330
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Check1"
      Height          =   240
      Left            =   8730
      TabIndex        =   6
      Top             =   5985
      Visible         =   0   'False
      Width           =   1725
   End
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Check2"
      Height          =   240
      Left            =   8730
      TabIndex        =   5
      Top             =   6300
      Visible         =   0   'False
      Width           =   1725
   End
   Begin VB.CheckBox Check3 
      Alignment       =   1  'Right Justify
      Caption         =   "Check3"
      Height          =   240
      Left            =   8730
      TabIndex        =   4
      Top             =   6615
      Visible         =   0   'False
      Width           =   1725
   End
   Begin VB.CheckBox Check4 
      Alignment       =   1  'Right Justify
      Caption         =   "Check4"
      Height          =   240
      Left            =   8730
      TabIndex        =   3
      Top             =   6930
      Visible         =   0   'False
      Width           =   1725
   End
   Begin VB.CheckBox Check5 
      Alignment       =   1  'Right Justify
      Caption         =   "Check5"
      Height          =   240
      Left            =   9405
      TabIndex        =   2
      Top             =   5850
      Visible         =   0   'False
      Width           =   1725
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   5310
      Top             =   5355
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsulta3.frx":0000
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsulta3.frx":0112
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsulta3.frx":0224
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsulta3.frx":0336
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsulta3.frx":0448
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsulta3.frx":055A
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsulta3.frx":066C
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   0
      Top             =   6000
      Width           =   11685
      _ExtentX        =   20611
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   5
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   8281
            Key             =   "Mensaje"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   8281
            Picture         =   "frmConsulta3.frx":0ABE
            Key             =   "Estado"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   1
            Alignment       =   1
            AutoSize        =   2
            Enabled         =   0   'False
            Object.Width           =   900
            MinWidth        =   18
            TextSave        =   "CAPS"
            Key             =   "Caps"
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   2
            AutoSize        =   2
            Object.Width           =   820
            MinWidth        =   18
            TextSave        =   "NUM"
            Key             =   "Num"
         EndProperty
         BeginProperty Panel5 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            Alignment       =   1
            AutoSize        =   2
            Object.Width           =   1693
            MinWidth        =   18
            TextSave        =   "27/10/2009"
            Key             =   "Fecha"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   11685
      _ExtentX        =   20611
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageKey        =   "Print"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel"
            Object.ToolTipText     =   "Salida a Excel"
            ImageKey        =   "Excel"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageKey        =   "Find"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Ayuda"
            Object.ToolTipText     =   "Ayuda"
            ImageKey        =   "Help"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   4335
      Left            =   90
      TabIndex        =   31
      Top             =   990
      Width           =   11490
      _ExtentX        =   20267
      _ExtentY        =   7646
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsulta3.frx":0DD8
      OLEDragMode     =   1
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   285
      Index           =   0
      Left            =   1395
      TabIndex        =   32
      Top             =   540
      Visible         =   0   'False
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   503
      _Version        =   393216
      Format          =   16842753
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   285
      Index           =   1
      Left            =   4140
      TabIndex        =   33
      Top             =   540
      Visible         =   0   'False
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   503
      _Version        =   393216
      Format          =   16842753
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   8730
      TabIndex        =   34
      Top             =   7245
      Visible         =   0   'False
      Width           =   780
      _ExtentX        =   1376
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   1
      Left            =   8730
      TabIndex        =   35
      Top             =   7605
      Visible         =   0   'False
      Width           =   780
      _ExtentX        =   1376
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   330
      Left            =   7695
      TabIndex        =   40
      Top             =   6030
      Visible         =   0   'False
      Width           =   420
      _ExtentX        =   741
      _ExtentY        =   582
      _Version        =   393217
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmConsulta3.frx":0DF4
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   2
      Left            =   9585
      TabIndex        =   41
      Top             =   7245
      Visible         =   0   'False
      Width           =   780
      _ExtentX        =   1376
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   3
      Left            =   9585
      TabIndex        =   42
      Top             =   7605
      Visible         =   0   'False
      Width           =   780
      _ExtentX        =   1376
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha inicial :"
      Height          =   240
      Index           =   0
      Left            =   135
      TabIndex        =   50
      Top             =   585
      Visible         =   0   'False
      Width           =   1200
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha final :"
      Height          =   240
      Index           =   1
      Left            =   2790
      TabIndex        =   49
      Top             =   585
      Visible         =   0   'False
      Width           =   1290
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   285
      Index           =   0
      Left            =   8910
      TabIndex        =   48
      Top             =   540
      Visible         =   0   'False
      Width           =   600
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   285
      Index           =   1
      Left            =   9585
      TabIndex        =   47
      Top             =   540
      Visible         =   0   'False
      Width           =   690
   End
   Begin VB.Label lblLabels 
      Caption         =   " "
      Height          =   285
      Index           =   4
      Left            =   4590
      TabIndex        =   46
      Top             =   6075
      Visible         =   0   'False
      Width           =   135
   End
   Begin VB.Label lblLabels 
      Caption         =   " "
      Height          =   285
      Index           =   3
      Left            =   4365
      TabIndex        =   45
      Top             =   6075
      Visible         =   0   'False
      Width           =   135
   End
   Begin VB.Label lblLabels 
      Caption         =   " "
      Height          =   150
      Index           =   2
      Left            =   4815
      TabIndex        =   44
      Top             =   6075
      Visible         =   0   'False
      Width           =   165
   End
   Begin VB.Label lblInfo 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   4410
      TabIndex        =   43
      Top             =   5400
      Visible         =   0   'False
      Width           =   420
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      Visible         =   0   'False
      X1              =   4410
      X2              =   5130
      Y1              =   5805
      Y2              =   5805
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Marcar todo"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Desmarcar todo"
         Index           =   1
      End
   End
End
Attribute VB_Name = "frmConsulta3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mvarId As Long, mIdComparativa As Long, mIdPresupuestoSeleccionado As Long
Private mvarIdProveedor As Long, mvarIdPedido As Long, mvarIdArticulo As Long, mvarIdRubro As Long
Private mvarLineasIvaCompras As Integer
Private mvarSubTituloExcel As String, mvarPathArchivosExportados As String
Private mvarDirectorioDTS As String, mvarParametrosExcel As String
Private mvarDesglosarNOGRAVADOS As Boolean

Public Property Let Id(ByVal vNewValue As Integer)

   Dim mvarFechaDesde As Date, mvarFechaHasta As Date
   Dim mAux As String
   Dim mVector
   Dim oRs As ADOR.Recordset
         
   mvarId = vNewValue
   
   mvarFechaDesde = DateSerial(Year(Date), Month(Date) - 1, 1)
   mvarFechaHasta = DateAdd("d", -1, DateAdd("m", 1, mvarFechaDesde))
   
   mvarParametrosExcel = ""
   mvarDesglosarNOGRAVADOS = False
   
   Select Case mvarId
      Case 1
         Me.Caption = "Cheques rechazados"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
         With Frame1
            .Caption = "Bancos : "
            .TOp = cmd(0).TOp
            .Left = cmd(1).Left + cmd(1).Width + 50
            .Visible = True
         End With
         With Option1
            .Caption = "Todos"
            .Value = True
         End With
         Option2.Caption = "Elegir uno"
         With lblLabels(4)
            .TOp = Frame1.TOp + 10
            .Left = Frame1.Left + Frame1.Width + 50
            .AutoSize = True
            .Caption = "Banco : "
         End With
         With DataCombo1(1)
            .TOp = Frame1.TOp
            .Left = lblLabels(4).Left + lblLabels(4).Width + 20
            .Width = Frame3.Width * 0.75
            .BoundColumn = "IdBanco"
            Set .RowSource = Aplicacion.Bancos.TraerFiltrado("_ConCuenta")
         End With
   
      Case 2
         Me.Caption = "Listado de costos por Obra"
         With Frame1
            .Caption = "Obra : "
            .TOp = Toolbar1.TOp + Toolbar1.Height + 10
            .Left = lblLabels(0).Left
            .Visible = True
         End With
         With Option1
            .Caption = "Todas"
            .Value = True
         End With
         Option2.Caption = "Elegir una"
         With lblLabels(4)
            .TOp = Frame1.TOp + 100
            .Left = Frame1.Left + Frame1.Width + 100
            .AutoSize = True
            .Caption = "Obra : "
         End With
         With DataCombo1(1)
            .TOp = Frame1.TOp
            .Left = lblLabels(4).Left + lblLabels(4).Width + 5
            .Width = Frame3.Width * 0.75
            .BoundColumn = "IdObra"
            Set .RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo")
         End With
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         
      Case 3
         Me.Caption = "Control lista de materiales salidas por destino"
         With Frame1
            .Caption = "Destino : "
            .TOp = Toolbar1.TOp + Toolbar1.Height + 10
            .Left = lblLabels(0).Left
            .Visible = True
         End With
         With Option1
            .Caption = "Todos"
            .Value = True
         End With
         Option2.Caption = "Elegir uno"
         With lblLabels(4)
            .TOp = Frame1.TOp + 100
            .Left = Frame1.Left + Frame1.Width + 100
            .AutoSize = True
            .Caption = "Destino : "
         End With
         With DataCombo1(1)
            .TOp = Frame1.TOp
            .Left = lblLabels(4).Left + lblLabels(4).Width + 5
            .Width = Frame3.Width * 0.6
            .BoundColumn = "IdDetalleObraDestino"
            Set .RowSource = Aplicacion.Obras.TraerFiltrado("_DestinosParaComboPorIdObra", -1)
         End With
         With Frame4
            .Caption = "Tipo emision : "
            .TOp = Frame1.TOp
            .Left = Me.Width - Frame4.Width - 300
            .Visible = True
         End With
         Option15.Caption = "Detallado"
         Option16.Caption = "Resumido"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         
      Case 4
         Me.Caption = "Articulos comprados por proveedor"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         With cmd(2)
            .Left = cmd(0).Left
            .TOp = cmd(0).TOp + cmd(0).Height + 10
         End With
         Me.Height = Me.Height * 1.07
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         mvarFechaDesde = DateAdd("m", -6, DateSerial(Year(Date), Month(Date), 1))
         mvarFechaHasta = DateAdd("d", -1, DateAdd("m", 6, mvarFechaDesde))
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
         With Frame5
            .Caption = "Tipo de busqueda : "
            .TOp = cmd(0).TOp
            .Left = cmd(1).Left + cmd(1).Width + 50
            .Visible = True
         End With
         With Option12
            .Caption = "Todas"
            .Value = True
         End With
         Option13.Caption = "x Articulo"
         Option14.Caption = "x Rubro"
   
      Case 5
         Me.Caption = "Recepciones pendientes de ingreso de comprobante"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
      
      Case 6
         Me.Caption = "Estado de pedidos abiertos"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
      
      Case 7
         Me.Caption = "Desarrollo de items de ordenes de compra (Por remito)"
         ActivarClientes
         Frame4.Visible = False
         With Check1
            .TOp = cmd(0).TOp
            .Width = cmd(0).Width * 2
            .Left = Lista.Left + Lista.Width - .Width
            .Caption = "Solo lo pendiente :"
            .Visible = True
         End With
         With Check2
            .TOp = Check1.TOp + Check1.Height + 10
            .Width = Check1.Width
            .Left = Check1.Left
            .Caption = "Informe resumido :"
            .Visible = True
         End With
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         
      Case 8
         Me.Caption = "Caja ingresos"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
      
      Case 9
         Me.Caption = "Caja egresos"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
      
      Case 10
         Me.Caption = "Analisis de cobranzas"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
      
      Case 11
         Me.Caption = "Detalle de comprobantes por partida"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         With lblLabels(0)
            .Caption = "Partida :"
            .Visible = True
         End With
         With Text1
            .TOp = DTFields(0).TOp
            .Left = DTFields(0).Left
            .Width = DTFields(0).Width
            .Visible = True
         End With
      
      Case 12
         Me.Caption = "Generar archivo de debitos por facturacion para bancos"
         cmd(0).Caption = "Mostrar"
         With cmd(1)
            .Caption = "Generar"
            .Enabled = False
         End With
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
      
      Case 13
         Me.Caption = "Listado de pedidos"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
      
      Case 14
         Me.Caption = "Ranking de ventas por cliente"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         lblLabels(1).Visible = True
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
         With Check5
            .TOp = DTFields(1).TOp
            .Width = DTFields(1).Width * 1.5
            .Left = DTFields(1).Left + DTFields(1).Width + 200
            .Caption = "Solo cantidades :"
            .Visible = True
         End With
      
      Case 15
         Me.Caption = "Cobranzas por cobrador"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         lblLabels(1).Visible = True
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
      
      Case 16
         Me.Caption = "Ranking de ventas por vendedor"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         With Text1
            .TOp = DTFields(0).TOp
            .Left = DTFields(0).Left
            .Width = DTFields(0).Width * 0.5
            .Text = Year(Date)
            .Visible = True
         End With
      
      Case 17
         Me.Caption = "Entregas / Devoluciones"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
         Frame5.Visible = True
         With Option12
            .Caption = "Todo"
            .Value = True
         End With
         Option13.Caption = "Solo entregas"
         Option14.Caption = "Solo devoluciones"
      
      Case 18
         Me.Caption = "Desarrollo de items de RM's"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
         With Frame1
            .Caption = "Obra : "
            .TOp = cmd(2).TOp
            .Left = cmd(2).Left + cmd(2).Width + 100
            .Visible = True
         End With
         With Option1
            .Caption = "Todas"
            .Value = True
         End With
         Option2.Caption = "Elegir una"
         With lblLabels(4)
            .TOp = Frame1.TOp + 100
            .Left = Frame1.Left + Frame1.Width + 100
            .AutoSize = True
            .Caption = "Obra : "
         End With
         With DataCombo1(1)
            .TOp = Frame1.TOp
            .Left = lblLabels(4).Left + lblLabels(4).Width + 5
            .Width = Frame3.Width * 0.75
            .BoundColumn = "IdObra"
            Set .RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo")
         End With
      
      Case 19
         Me.Caption = "Generacion de pagos por lote de deuda"
         cmd(0).Caption = "Procesar"
         With cmd(1)
            .Caption = "Generar RE"
            .Enabled = False
         End With
         Lista.CheckBoxes = True
         With lblLabels(0)
            .Caption = "Cobrador : "
            .Visible = True
         End With
         With DataCombo1(0)
            .TOp = DTFields(0).TOp
            .Left = DTFields(0).Left
            .Width = DTFields(0).Width * 2
            .BoundColumn = "IdVendedor"
            Set .RowSource = Aplicacion.Vendedores.TraerLista
            .Visible = True
         End With
         Text3.Visible = True
         With lblLabels(2)
            .Caption = "Total pagos a generar :"
            .Width = DTFields(0).Width * 1.5
            .TOp = Text3.TOp
            .Left = Text3.Left - .Width - 50
            .Height = Text3.Height
            .Visible = True
         End With
      
      Case 20
         Me.Caption = "Pedidos pendientes por fecha de vencimiento"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Left = cmd(0).Left
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
         GenerarCondicionesDeCompra
         Set Lista.DataSource = Aplicacion.Pedidos.TraerFiltrado("_PorFechaVencimiento")
         ReemplazarColumnHeaderPedidos
         Toolbar1.Enabled = True
      
      Case 21
         Me.Caption = "Listado de saldos de fondos fijos (todos)"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Left = cmd(0).Left
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
         Set Lista.DataSource = Aplicacion.TablasGenerales.TraerFiltrado("FondosFijos", "_Resumen")
         Toolbar1.Enabled = True
      
      Case 22
         Me.Caption = "Analisis de cobranzas / facturacion"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
      
      Case 104
         Me.Caption = "Control de remitos SAT"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
         With Check1
            .TOp = cmd(1).TOp
            .Width = cmd(1).Width * 2
            .Left = Lista.Left + Lista.Width - .Width
            .Caption = "Mostrar movimientos detallados"
            .Visible = True
         End With
         cmd_Click 0
         
      Case 108
         Me.Caption = "Valores diferidos pendientes"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         With lblLabels(0)
            .Caption = "Fecha base :"
            .Visible = True
         End With
         lblLabels(1).Visible = False
         DTFields(1).Visible = False
         With DTFields(0)
            .Visible = True
            .Value = Date
         End With
         With Frame1
            .Caption = "Bancos : "
            .TOp = cmd(0).TOp
            .Left = cmd(1).Left + cmd(1).Width + 50
            .Visible = True
         End With
         With Option1
            .Caption = "Todos"
            .Value = True
         End With
         Option2.Caption = "Elegir uno"
         With lblLabels(4)
            .TOp = Frame1.TOp + 10
            .Left = Frame1.Left + Frame1.Width + 50
            .AutoSize = True
            .Caption = "Banco : "
         End With
         With DataCombo1(1)
            .TOp = Frame1.TOp
            .Left = lblLabels(4).Left + lblLabels(4).Width + 20
            .Width = Frame3.Width * 0.75
            .BoundColumn = "IdBanco"
            Set .RowSource = Aplicacion.Bancos.TraerFiltrado("_ConCuenta")
         End With
   
      Case 110
         Me.Caption = "Salidas de materiales"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
      
      Case 111
         Me.Caption = "Anticipos a proveedores"
         With cmd(2)
            .TOp = cmd(0).TOp
            .Left = cmd(0).Left
         End With
         cmd(0).Visible = False
         cmd(1).Visible = False
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
         With lblInfo
            .AutoSize = False
            .FontSize = 8
            .TOp = cmd(0).TOp
            .Left = cmd(0).Left + cmd(0).Width + 100
            .Width = Me.Width / 2.8
            .Caption = "Haga doble click sobre el pedido a imputar"
            .Visible = False
         End With
         Lista.Sorted = False
         Set oRs = Aplicacion.Pedidos.TraerFiltrado("_AnticipoAProveedores", Me.IdProveedor)
         Set Lista.DataSource = oRs
         Set oRs = Nothing
   
   End Select
   
End Property

Public Property Get Id() As Integer

   Id = mvarId
   
End Property

Private Sub Check1_Click()

   If Me.Id = 104 Then
      Lista.ListItems.Clear
      cmd_Click 0
   End If

End Sub

Private Sub cmd_Click(index As Integer)

   Dim oAp As ComPronto.Aplicacion
'   Dim dsoServer As DSO.Server
'   Dim dsoDatabase As DSO.Database
'   Dim oPackage As DTS.Package2
   Dim oTab As ADOR.Recordset
   Dim mvarCubo As String, mDesdeAlfa As String, mHastaAlfa As String, mOrden As String
   Dim mArchivoTxt As String, s As String, mProvincias As String, mResultado As String
   Dim mStringAux As String, mArchivoSalida As String, mPendiente As String
   Dim mConceptosAbono As String, mCreditos As String, mCampo As String, mCampo1 As String
   Dim mCampo2 As String, mIncluirCierre As String, mDesdeCodigo As String
   Dim mHastaCodigo As String, mAuxS1 As String, mAuxS2 As String
   Dim mActivaRango As Integer, mTipoBusqueda As Integer, mIdBusqueda As Integer
   Dim mPos As Integer, i As Integer, mSeñal As Integer, mSeñal1 As Integer
   Dim mDesde As Integer, mHasta As Integer, x As Integer
   Dim mvarIdAux As Long, mvarIdAux1 As Long, mvarIdAux2 As Long
   Dim mvarAcumulado As Double, mvarSaldo As Double
   Dim mVectorProvincias, mVectorAux
   
   mvarSubTituloExcel = ""
   
   Toolbar1.Enabled = True
   
   On Error GoTo Mal
   
   Select Case index
      Case 0
         Select Case Me.Id
            Case 1
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               If Option1.Value Then
                  mvarIdAux1 = -1
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Bancos : Todos"
               Else
                  If Not IsNumeric(DataCombo1(1).BoundText) Then
                     MsgBox "Debe indicar el banco", vbExclamation
                     Exit Sub
                  End If
                  mvarIdAux1 = DataCombo1(1).BoundText
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Banco : " & DataCombo1(1).Text
               End If
               Set oTab = Aplicacion.Bancos.TraerFiltrado("_InformeChequesAnulados", Array(DTFields(0).Value, DTFields(1).Value, mvarIdAux1))
         
            Case 2
               If Not Option1.Value And Not IsNumeric(DataCombo1(1).BoundText) Then
                  MsgBox "Debe definir la obra", vbExclamation
                  Exit Sub
               End If
               
               If Option1.Value Then
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Todas las obras."
                  mIdObra = -1
               Else
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Solo obra " & DataCombo1(1).Text
                  mIdObra = DataCombo1(1).BoundText
               End If
               Set oTab = Aplicacion.Pedidos.TraerFiltrado("_DetallesPedidosRecepcionesLMaterialesPorObra", mIdObra)
               
            Case 3
               If Not Option1.Value And Not IsNumeric(DataCombo1(1).BoundText) Then
                  MsgBox "Debe definir el destino", vbExclamation
                  Exit Sub
               End If
               
               If Option1.Value Then
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Todos los destinos."
                  mvarIdAux1 = -1
               Else
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Solo destino " & DataCombo1(1).Text
                  mvarIdAux1 = DataCombo1(1).BoundText
               End If
               
               If Option15.Value Then
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Detallado"
                  mCampo1 = "D"
               Else
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Resumido"
                  mCampo1 = "R"
               End If
               
               mCampo2 = BuscarClaveINI("Mostrar costos consulta de saldos LM")
               
               Set oTab = Aplicacion.LMateriales.TraerFiltrado("_SaldosPorDestino", Array(mvarIdAux1, mCampo1, mCampo2))
               
            Case 4
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               mvarIdAux1 = -1
               mvarIdAux2 = -1
               If Option12.Value Then
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Articulos : Todos"
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Rubros : Todos"
               ElseIf Option13.Value Then
                  If Not IsNumeric(DataCombo1(0).BoundText) Then
                     MsgBox "Debe indicar el articulo", vbExclamation
                     Exit Sub
                  End If
                  mvarIdAux1 = DataCombo1(0).BoundText
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Articulo : " & DataCombo1(0).Text
               ElseIf Option14.Value Then
                  If Not IsNumeric(DataCombo1(0).BoundText) Then
                     MsgBox "Debe indicar el rubro", vbExclamation
                     Exit Sub
                  End If
                  mvarIdAux2 = DataCombo1(0).BoundText
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Rubro : " & DataCombo1(0).Text
               End If
               Set oTab = Aplicacion.Pedidos.TraerFiltrado("_PorArticuloRubro", Array(DTFields(0).Value, DTFields(1).Value, mvarIdAux1, mvarIdAux2))
         
            Case 5
               mvarSubTituloExcel = ""
               Set oTab = Aplicacion.Recepciones.TraerFiltrado("_PendientesDeComprobanteDetallado")
            
            Case 6
               mvarSubTituloExcel = ""
               Set oTab = Aplicacion.PedidosAbiertos.TraerFiltrado("_EstadoPedidos")
            
            Case 7
               mvarSubTituloExcel = ""
               If Option1.Value Then
                  mActivaRango = -1
                  mDesdeAlfa = ""
                  mHastaAlfa = ""
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Rango de seleccion : Todos"
               Else
                  mActivaRango = 0
                  mDesdeAlfa = Trim(DataCombo1(0).Text)
                  mHastaAlfa = Trim(DataCombo1(1).Text)
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Rango de seleccion : desde " & mDesdeAlfa & ", hasta " & mHastaAlfa
               End If
               mPendiente = "NO"
               If Check1.Value = 1 Then
                  mPendiente = "SI"
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Solo lo pendiente"
               End If
               mAuxS1 = "D"
               If Check2.Value = 1 Then
                  mAuxS1 = "R"
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Resumido"
               End If
               Set oTab = Aplicacion.OrdenesCompra.TraerFiltrado("_DesarrolloPorItem", Array(mActivaRango, mDesdeAlfa, mHastaAlfa, mPendiente, "R", mAuxS1))
         
            Case 8
               Set oTab = Aplicacion.Recibos.TraerFiltrado("_CajaIngresos", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 9
               Set oTab = Aplicacion.OrdenesPago.TraerFiltrado("_CajaEgresos", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 10
               Set oTab = Aplicacion.Recibos.TraerFiltrado("_AnalisisCobranzas", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 11
               If Len(Trim(Text1.Text)) = 0 Then
                  MsgBox "Debe definir la partida", vbExclamation
                  Exit Sub
               End If
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("Partidas", "_ComprobantesDetalladosPorPartida", Text1.Text)
               mvarSubTituloExcel = "|Partida " & Text1.Text
         
            Case 12
               Set oTab = Aplicacion.Facturas.TraerFiltrado("_ParaDebitoBancario", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
                  
            Case 13
               Set oTab = Aplicacion.OrdenesCompra.TraerFiltrado("_DetalladoEntreFechas", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
                  
            Case 14
               If Check5.Value = 0 Then
                  Set oTab = Aplicacion.Clientes.TraerFiltrado("_RankingVentas", Array(DTFields(0).Value, DTFields(1).Value))
               Else
                  Set oTab = Aplicacion.Clientes.TraerFiltrado("_RankingVentasCantidades", Array(DTFields(0).Value, DTFields(1).Value))
               End If
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
         
            Case 15
               Set oTab = Aplicacion.Recibos.TraerFiltrado("_PorCobrador", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 16
               If Len(Text1.Text) = 0 Or Not IsNumeric(Text1.Text) Then
                  MsgBox "Debe ingresar el año a listar", vbExclamation
                  Exit Sub
               End If
               
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_RankingVentasPorVendedor", Text1.Text)
               mvarSubTituloExcel = "|Año " & Text1.Text
         
            Case 17
               If Option12.Value Then
                  mAuxS1 = "T"
                  mAuxS2 = "Entregas y devoluciones"
               ElseIf Option13.Value Then
                  mAuxS1 = "R"
                  mAuxS2 = "Solo entregas"
               ElseIf Option14.Value Then
                  mAuxS1 = "D"
                  mAuxS2 = "Solo devoluciones"
               Else
                  MsgBox "Indique el ambito del informe!", vbExclamation
                  Exit Sub
               End If
            
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_Entregas", Array(DTFields(0).Value, DTFields(1).Value, mAuxS1))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value & "|" & mAuxS2
            
            Case 18
               If Not Option1.Value And Not IsNumeric(DataCombo1(1).BoundText) Then
                  MsgBox "Debe definir la obra", vbExclamation
                  Exit Sub
               End If
               
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               
               If Option1.Value Then
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Todas las obras."
                  mIdObra = -1
               Else
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Solo obra " & DataCombo1(1).Text
                  mIdObra = DataCombo1(1).BoundText
               End If
               
               Aplicacion.Tarea "Requerimientos_TX_DesarrolloItems1", Array(DTFields(0).Value, DTFields(1).Value, mIdObra)
               Set oTab = Aplicacion.Requerimientos.TraerFiltrado("_DesarrolloItems2")
         
            Case 19
               If Not IsNumeric(DataCombo1(0).BoundText) Then
                  MsgBox "Debe definir el cobrador", vbExclamation
                  Exit Sub
               End If
               
               mvarSubTituloExcel = "|Cobrador " & DataCombo1(0).Text
               
               Set oTab = Aplicacion.CtasCtesD.TraerFiltrado("_ParaGeneracionDePagos", DataCombo1(0).BoundText)
               
               cmd(1).Enabled = True
         
            Case 22
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_AnalisisCobranzaFacturacion", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 104
               mCampo = "R"
               If Check1.Value = 1 Then mCampo = "D"
               Set oTab = Aplicacion.SalidasMateriales.TraerFiltrado("_PendientesSAT", mCampo)
         
            Case 108
               mvarSubTituloExcel = "|Fecha base : " & DTFields(0).Value
               If Option1.Value Then
                  mvarIdAux1 = -1
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Bancos : Todos"
               Else
                  If Not IsNumeric(DataCombo1(1).BoundText) Then
                     MsgBox "Debe indicar el banco", vbExclamation
                     Exit Sub
                  End If
                  mvarIdAux1 = DataCombo1(1).BoundText
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Banco : " & DataCombo1(1).Text
               End If
               'Set oTab = Aplicacion.Bancos.TraerFiltrado("_InformeChequesDiferidos", Array(DTFields(0).Value, mvarIdAux1))
               Set oTab = Aplicacion.Bancos.TraerFiltrado("_InformeChequesDiferidos1", Array(DTFields(0).Value, mvarIdAux1))
            
            Case 110
               Set oTab = Aplicacion.SalidasMateriales.TraerFiltrado("Fecha", Array(DTFields(0).Value, DTFields(1).Value, -1, "SI", "SI"))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
         End Select
      
         Lista.Sorted = False
         If Not oTab Is Nothing Then
            Set Lista.DataSource = oTab
            ReemplazarEtiquetasListas Lista
            Lista.Refresh
         Else
            Lista.ListItems.Clear
         End If
         
         If Lista.ListItems.Count > 0 Then
            StatusBar1.Panels(2).Text = "" & Lista.ListItems.Count & " elementos en la lista"
         End If
   
         Set oTab = Nothing
         Set oAut = Nothing
         Set oAp = Nothing
         
         Me.MousePointer = vbDefault
         
         mvarCual = 99
         
      Case 1
         Select Case Me.Id
            Case 12
               If ListaVacia Then Exit Sub
               s = ""
               For Each oL In Lista.ListItems
                  s = s & oL.SubItems(9) & vbCrLf
               Next
               If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
               GuardarArchivoSecuencial mvarPathArchivosExportados & "DebitoBancario.txt", s
               MsgBox "Se ha generado el archivo : " & mvarPathArchivosExportados & "DebitoBancario.txt", vbInformation
            Case 19
               GeneracionRecibos
         End Select
      
      Case 2
         If Me.Id = 3 Then
            Me.Hide
         Else
            Unload Me
         End If
   End Select
   
Salida:

   Set oAp = Nothing
'   Set dsoServer = Nothing
'   Set dsoDatabase = Nothing
'   Set oPackage = Nothing
   Set oTab = Nothing
   
   Exit Sub
   
Mal:

   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error al procesar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select
   Resume Salida

End Sub

Private Sub Form_Activate()

   ReemplazarEtiquetas Me
   
End Sub

Private Sub Form_Load()

   Toolbar1.Enabled = False
   
   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.Parametros.TraerTodos
   mvarPathArchivosExportados = IIf(IsNull(oRs.Fields("PathArchivosExportados").Value), "C:\", oRs.Fields("PathArchivosExportados").Value)
   mvarDirectorioDTS = IIf(IsNull(oRs.Fields("DirectorioDTS").Value), "C:\GestionCubos\", oRs.Fields("DirectorioDTS").Value)
   mvarLineasIvaCompras = IIf(IsNull(oRs.Fields("LineasDiarioDetallado").Value), 60, oRs.Fields("LineasDiarioDetallado").Value)
   oRs.Close
   Set oRs = Nothing
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   'Degradado Me
   
End Sub

Private Sub Lista_Click()

   If mvarId = 19 Then CalcularTotal

End Sub

Private Sub Lista_DblClick()

   If Not Lista.SelectedItem Is Nothing Then
      Select Case mvarId
         Case 111
            Me.IdPedido = Lista.SelectedItem.SubItems(1)
            Me.IdProveedor = Lista.SelectedItem.SubItems(6)
            Me.Hide
      End Select
   End If

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count > 0 Then
         If mvarId = 19 Then
            PopupMenu MnuDet, , , , MnuDetA(0)
         End If
      End If
   End If

End Sub

Private Sub MnuDetA_Click(index As Integer)

   Select Case index
      Case 0
         If mvarId = 19 Then
            MarcarRegistros True
         End If
      Case 1
         If mvarId = 19 Then
            MarcarRegistros False
         End If
   End Select

End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      Select Case mvarId
         Case 1, 2, 3, 18, 108
            lblLabels(4).Visible = False
            DataCombo1(1).Visible = False
      End Select
   End If
   
End Sub

Private Sub Option12_Click()

   If Option12.Value Then
      Select Case mvarId
         Case 4
            lblLabels(4).Visible = False
            DataCombo1(0).Visible = False
      End Select
   End If
   
End Sub

Private Sub Option13_Click()

   If Option13.Value Then
      Select Case mvarId
         Case 4
            With lblLabels(4)
               .TOp = Frame5.TOp + Frame5.Height
               .Left = Frame5.Left
               .AutoSize = True
               .Caption = "Articulos : "
               .Visible = True
            End With
            With DataCombo1(0)
               .TOp = lblLabels(4).TOp + lblLabels(4).Height
               .Left = lblLabels(4).Left
               .Width = Frame5.Width
               Set .RowSource = Nothing
               .BoundColumn = "IdArticulo"
               Set .RowSource = Aplicacion.Articulos.TraerLista
               .BoundText = Me.IdArticulo
               .Visible = True
            End With
      End Select
   End If
   
End Sub

Private Sub Option14_Click()

   If Option14.Value Then
      Select Case mvarId
         Case 4
            With lblLabels(4)
               .TOp = Frame5.TOp + Frame5.Height
               .Left = Frame5.Left
               .AutoSize = True
               .Caption = "Rubros : "
               .Visible = True
            End With
            With DataCombo1(0)
               .TOp = lblLabels(4).TOp + lblLabels(4).Height
               .Left = lblLabels(4).Left
               .Width = Frame5.Width
               Set .RowSource = Nothing
               .BoundColumn = "IdRubro"
               Set .RowSource = Aplicacion.Rubros.TraerLista
               .BoundText = Me.IdRubro
               .Visible = True
            End With
      End Select
   End If
   
End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      Select Case mvarId
         Case 1, 2, 3, 18, 108
            lblLabels(4).Visible = True
            DataCombo1(1).Visible = True
      End Select
   End If
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Dim mCampo1 As String, mAuxS1 As String
   Dim mvarIdAux1 As Long
   
   Select Case Button.Key
      Case "Imprimir"
         Select Case Me.Id
            Case 2
               CostosPorObra
            Case 16
               VentasPorVendedor
            Case Else
               ImprimirConExcel Lista, Me.Caption & mvarSubTituloExcel
         End Select
      
      Case "Buscar"
         FiltradoLista Lista
         StatusBar1.Panels(2).Text = " " & Lista.ListItems.Count & " elementos en la lista"

      Case "Excel"
         Select Case Me.Id
            Case 2
               CostosPorObra
            Case 16
               VentasPorVendedor
            Case 108
               If Option1.Value Then
                  mvarIdAux1 = -1
               Else
                  mvarIdAux1 = DataCombo1(1).BoundText
               End If
               ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, "ValoresDiferidos|" & DTFields(0).Value & "|" & mvarIdAux1
            Case Else
               ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel
         End Select
   End Select

End Sub

Public Sub ReemplazarColumnHeader()

   Dim oRsAux1 As ADOR.Recordset
   Dim oRsAux2 As ADOR.Recordset
   Dim i As Integer
   Dim oCH As ColumnHeader
   
   Set oRsAux1 = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   
   For i = 1 To 5
      If Not IsNull(oRsAux1.Fields("IdCuentaAdicionalIVACompras" & i).Value) Then
         Set oRsAux2 = Aplicacion.Cuentas.TraerFiltrado("_PorId", oRsAux1.Fields("IdCuentaAdicionalIVACompras" & i).Value)
         If oRsAux2.RecordCount > 0 Then
            For Each oCH In Lista.ColumnHeaders
               If oCH.Text = "Col" & i Then
                  If Not IsNull(oRsAux2.Fields("Descripcion").Value) Then oCH.Text = oRsAux2.Fields("Descripcion").Value
                  Exit For
               End If
            Next
         End If
         oRsAux2.Close
      End If
   Next
   oRsAux1.Close
   
   Set oRsAux1 = Nothing
   Set oRsAux2 = Nothing

End Sub

Public Function ListaVacia() As Boolean

   ListaVacia = False
   If Lista.ListItems.Count = 0 Then
      MsgBox "No hay informacion para la generacion!", vbExclamation
      ListaVacia = True
   End If

End Function

Public Sub CostosPorObra()

   Dim mIdObra As Long
   Dim oEx As Excel.Application
   
   If Option1.Value Then
      mIdObra = -1
   Else
      mIdObra = DataCombo1(1).BoundText
   End If
   
   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      With .Workbooks.Add(glbPathPlantillas & "\ComprasTerceros.xlt")
         oEx.Run "CostosPorObra", glbStringConexion, mIdObra
         oEx.Run "InicializarEncabezados", glbEmpresa, glbDireccion & " " & glbLocalidad, glbTelefono1, glbDatosAdicionales1
      End With
   End With
   
   Set oEx = Nothing

End Sub

Public Sub VentasPorVendedor()

   If Len(Text1.Text) = 0 Or Not IsNumeric(Text1.Text) Then
      MsgBox "Debe ingresar el año a listar", vbExclamation
      Exit Sub
   End If
   
   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      With .Workbooks.Add(glbPathPlantillas & "\ComprasTerceros.xlt")
         oEx.Run "VentasPorVendedor", glbStringConexion, Text1.Text
         oEx.Run "InicializarEncabezados", glbEmpresa, glbDireccion & " " & glbLocalidad, glbTelefono1, glbDatosAdicionales1
      End With
   End With
   
   Set oEx = Nothing

End Sub

Public Property Get IdArticulo() As Long

   IdArticulo = mvarIdArticulo

End Property

Public Property Let IdArticulo(ByVal vNewValue As Long)

   mvarIdArticulo = vNewValue

End Property

Public Property Get IdRubro() As Long

   IdRubro = mvarIdRubro

End Property

Public Property Let IdRubro(ByVal vNewValue As Long)

   mvarIdRubro = vNewValue

End Property

Public Property Get IdProveedor() As Integer

   IdProveedor = mvarIdProveedor

End Property

Public Property Let IdProveedor(ByVal vNewValue As Integer)

   mvarIdProveedor = vNewValue

End Property

Public Property Get IdPedido() As Integer

   IdPedido = mvarIdPedido

End Property

Public Property Let IdPedido(ByVal vNewValue As Integer)

   mvarIdPedido = vNewValue

End Property

Public Sub ActivarClientes()

   With Lista
      .Height = .Height - 700
   End With
   With Option1
      .Caption = "Todos"
      .Value = True
   End With
   Option2.Caption = "Elegir un rango"
   With Frame1
      .Left = cmd(0).Left
      .TOp = cmd(0).TOp - 600
      .Caption = "Clientes : "
      .Visible = True
   End With
   With DataCombo1(0)
      .Width = 3400
      .Left = cmd(0).Left + Frame1.Width + 300
      .TOp = cmd(0).TOp - 400
      Set .RowSource = Aplicacion.Clientes.TraerLista
      .Visible = True
   End With
   With DataCombo1(1)
      .Width = DataCombo1(0).Width
      .Left = DataCombo1(0).Left + DataCombo1(0).Width + 300
      .TOp = cmd(0).TOp - 400
      Set .RowSource = Aplicacion.Clientes.TraerLista
      .Visible = True
   End With
   With txtBuscar(0)
      .Width = 2000
      .Left = DataCombo1(0).Left + DataCombo1(0).Width - txtBuscar(0).Width
      .TOp = DataCombo1(0).TOp - DataCombo1(0).Height - 50
      .Visible = True
   End With
   With txtBuscar(1)
      .Width = txtBuscar(0).Width
      .Left = DataCombo1(1).Left + DataCombo1(1).Width - txtBuscar(1).Width
      .TOp = DataCombo1(1).TOp - DataCombo1(1).Height - 50
      .Visible = True
   End With
   With Label1(0)
      .Width = 600
      .Left = txtBuscar(0).Left - Label1(0).Width - 50
      .TOp = DataCombo1(0).TOp - DataCombo1(0).Height - 30
      .Caption = "Buscar:"
      .Visible = True
   End With
   With Label1(1)
      .Width = Label1(0).Width
      .Left = txtBuscar(1).Left - Label1(1).Width - 50
      .TOp = DataCombo1(1).TOp - DataCombo1(1).Height - 30
      .Caption = "Buscar:"
      .Visible = True
   End With
   With Frame4
      .Left = Me.Width / 2
      .TOp = Toolbar1.TOp + Toolbar1.Height + 50
      .Caption = "Tipo informe : "
      .Visible = True
   End With
   With Option15
      .Caption = "Resumido"
      .Value = True
   End With
   Option16.Caption = "Detallado"

End Sub

Public Sub MarcarRegistros(ByVal Marcar As Boolean)

   Dim oL As ListItem
   
   For Each oL In Lista.ListItems
      oL.Checked = Marcar
   Next
   
   CalcularTotal

End Sub

Public Sub CalcularTotal()

   Dim oL As ListItem
   Dim mTotal As Double
   
   mTotal = 0
   For Each oL In Lista.ListItems
      If oL.Checked And IsNumeric(oL.SubItems(9)) Then mTotal = mTotal + oL.SubItems(9)
   Next
   Text3.Text = Format(mTotal, "#,##0.00")

End Sub

Public Sub GeneracionRecibos()

   Dim oAp As ComPronto.Aplicacion
   Dim oRec As ComPronto.Recibo
   Dim oPto As ComPronto.PuntoVenta
   Dim oRsAux1 As ADOR.Recordset
   Dim i As Integer, mIdMonedaPesos As Integer, mIdMonedaDolar As Integer, mIdPuntoVenta As Integer, mPuntoVenta As Integer
   Dim mImporte As Double, mDebe As Double, mHaber As Double, mCotizacion As Double, mSaldo As Double
   Dim mNumeroRecibo As Long, mCodigo1 As Long, mIdCuenta As Long, mCodigo2 As Long, mIdCuentaCaja As Long, mIdCaja As Long
   Dim mIdCliente As Long, mIdVendedor As Long, mIdImputacion As Long
   Dim mArchivo As String, mError As String
   Dim mFecha As Date, mFechaCorte As Date
   Dim mOk As Boolean, mConProblemas As Boolean
   Dim Filas, Columnas

   On Error GoTo Mal

   With lblInfo
      .TOp = DTFields(0).TOp
      .Left = DTFields(1).Left
      .Width = DTFields(0).Width * 4
      .Height = DTFields(0).Height
      .FontSize = 10
      .Visible = True
   End With
   DoEvents
   
   Set oAp = Aplicacion

   Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
   mIdMonedaPesos = oRsAux1.Fields("IdMoneda").Value
   mIdMonedaDolar = oRsAux1.Fields("IdMonedaDolar").Value
   oRsAux1.Close
   
   mIdCaja = 0
   mIdCuentaCaja = 0
   Set oRsAux1 = oAp.Cajas.TraerFiltrado("_PorIdMoneda", mIdMonedaPesos)
   If oRsAux1.RecordCount > 0 Then
      mIdCaja = oRsAux1.Fields(0).Value
      mIdCuentaCaja = IIf(IsNull(oRsAux1.Fields("IdCuenta").Value), 0, oRsAux1.Fields("IdCuenta").Value)
   End If
   oRsAux1.Close
   
   mIdPuntoVenta = 0
   mPuntoVenta = 0
   Set oRsAux1 = oAp.PuntosVenta.TraerFiltrado("_PorIdTipoComprobante", 2)
   If oRsAux1.RecordCount > 0 Then
      mIdPuntoVenta = oRsAux1.Fields(0).Value
      mPuntoVenta = oRsAux1.Fields("PuntoVenta").Value
   End If
   oRsAux1.Close
   
   mError = ""
   mFechaCorte = 0
   
   If mIdCaja = 0 Then
      MsgBox "No existe una caja en pesos para la generacion", vbExclamation
      GoTo Salida
   End If
   If mIdCuentaCaja = 0 Then
      MsgBox "No existe la cuenta contable de caja en pesos para la generacion", vbExclamation
      GoTo Salida
   End If
   
   mCotizacion = Cotizacion(Date, mIdMonedaDolar)
   If mCotizacion = 0 Then
      MsgBox "No existe cotizacion dolar del dia", vbExclamation
      GoTo Salida
   End If
   
   Filas = VBA.Split(Lista.GetStringCheck, vbCrLf)
   If UBound(Filas) > 0 Then
      For i = 1 To UBound(Filas)
         Columnas = VBA.Split(Filas(i), vbTab)
         If UBound(Columnas) > 1 Then
            lblInfo.Caption = "Procesando comprobante " & Columnas(7)
            DoEvents
            
            mIdImputacion = Val(Columnas(2))
            mIdCliente = Val(Columnas(3))
            mImporte = CDbl(Columnas(10))
            
            mSaldo = 0
            Set oRsAux1 = oAp.CtasCtesD.TraerFiltrado("_PorId", mIdImputacion)
            If oRsAux1.RecordCount > 0 Then
               mSaldo = IIf(IsNull(oRsAux1.Fields("Saldo").Value), 0, oRsAux1.Fields("Saldo").Value)
            End If
            oRsAux1.Close
            
            If mSaldo <> 0 Then
               mIdCuenta = 0
               Set oRsAux1 = oAp.Clientes.TraerFiltrado("_PorId", mIdCliente)
               If oRsAux1.RecordCount > 0 Then
                  mIdVendedor = IIf(IsNull(oRsAux1.Fields("Cobrador").Value), IIf(IsNull(oRsAux1.Fields("Vendedor1").Value), DataCombo1(0).BoundText, oRsAux1.Fields("Vendedor1").Value), oRsAux1.Fields("Cobrador").Value)
                  mIdCuenta = IIf(IsNull(oRsAux1.Fields("IdCuenta").Value), 0, oRsAux1.Fields("IdCuenta").Value)
               End If
               oRsAux1.Close
               
               Set oRec = oAp.Recibos.Item(-1)
               With oRec
                  With .Registro
                     .Fields("IdCliente").Value = mIdCliente
                     .Fields("FechaRecibo").Value = Date
                     .Fields("IdPuntoVenta").Value = mIdPuntoVenta
                     .Fields("PuntoVenta").Value = mPuntoVenta
                     .Fields("Tipo").Value = "CC"
                     .Fields("Efectivo").Value = 0
                     .Fields("Valores").Value = mImporte
                     .Fields("Documentos").Value = 0
                     .Fields("Otros1").Value = 0
                     .Fields("Otros2").Value = 0
                     .Fields("Otros3").Value = 0
                     .Fields("Otros4").Value = 0
                     .Fields("Otros5").Value = 0
                     .Fields("Deudores").Value = mImporte
                     .Fields("RetencionIVA").Value = 0
                     .Fields("RetencionGanancias").Value = 0
                     .Fields("RetencionIBrutos").Value = 0
                     .Fields("GastosGenerales").Value = 0
                     .Fields("Cotizacion").Value = mCotizacion
                     .Fields("IdMoneda").Value = mIdMonedaPesos
                     .Fields("Dolarizada").Value = "NO"
                     .Fields("AsientoManual").Value = "NO"
                     .Fields("CotizacionMoneda").Value = 1
                     .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                     .Fields("FechaIngreso").Value = Now
                     .Fields("IdVendedor").Value = mIdVendedor
                     .Fields("IdCobrador").Value = mIdVendedor
                     .Fields("Observaciones").Value = Columnas(1)
                  End With
                  With .DetRecibos.Item(-1)
                     With .Registro
                        .Fields("IdImputacion").Value = mIdImputacion
                        .Fields("Importe").Value = mImporte
                     End With
                     .Modificado = True
                  End With
                  With .DetRecibosValores.Item(-1)
                     With .Registro
                        .Fields("IdTipoValor").Value = 32
                        .Fields("Importe").Value = mImporte
                        .Fields("IdCaja").Value = mIdCaja
                     End With
                     .Modificado = True
                  End With
                  With .DetRecibosCuentas.Item(-1)
                     With .Registro
                        .Fields("IdCuenta").Value = mIdCuentaCaja
                        .Fields("CodigoCuenta").Value = mCodigo1
                        .Fields("Debe").Value = mImporte
                        .Fields("IdMoneda").Value = mIdMonedaPesos
                        .Fields("CotizacionMonedaDestino").Value = 1
                     End With
                     .Modificado = True
                  End With
                  With .DetRecibosCuentas.Item(-1)
                     With .Registro
                        .Fields("IdCuenta").Value = mIdCuenta
                        .Fields("CodigoCuenta").Value = mCodigo2
                        .Fields("Haber").Value = mImporte
                        .Fields("IdMoneda").Value = mIdMonedaPesos
                        .Fields("CotizacionMonedaDestino").Value = 1
                     End With
                     .Modificado = True
                  End With
               End With
               
               Set oPto = Aplicacion.PuntosVenta.Item(mIdPuntoVenta)
               mNumeroRecibo = oPto.Registro.Fields("ProximoNumero").Value
               oPto.Registro.Fields("ProximoNumero").Value = mNumeroRecibo + 1
               oPto.Guardar
               Set oPto = Nothing
               
               oRec.Registro.Fields("NumeroRecibo").Value = mNumeroRecibo
               oRec.Guardar
               Set oRec = Nothing
            End If
         End If
      Next
   End If

   If Len(mError) > 0 Then MsgBox "El proceso reporta los siguientes problemas :" & mError
   
   lblInfo.Visible = False
   cmd_Click 0
   CalcularTotal

Salida:
   Set oRsAux1 = Nothing
   Set oPto = Nothing
   Set oRec = Nothing
   Set oAp = Nothing

   Exit Sub

Mal:
   MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   Set oRsAux1 = Nothing
   Set oPto = Nothing
   Set oRec = Nothing
   Set oAp = Nothing
   Unload Me
   'Resume Salida

End Sub

Public Sub ReemplazarColumnHeaderPedidos()

   Dim oCH As ColumnHeader
   Dim mFecha As Date
   
   For Each oCH In Lista.ColumnHeaders
      If mId(oCH.Text, 1, 1) = "-" Or mId(oCH.Text, 1, 1) = "+" Or oCH.Text = "0" Then
         If oCH.Text = "-99" Then
            oCH.Text = "Ant."
         ElseIf oCH.Text = "+99" Then
            oCH.Text = "Post."
         Else
            mFecha = DateAdd("m", Val(oCH.Text), Date)
            oCH.Text = "" & NombreMesCorto(Month(mFecha)) & "/" & Year(mFecha)
         End If
      End If
   Next

End Sub
