VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.3#0"; "Controles1013.ocx"
Begin VB.Form frmConsulta2 
   ClientHeight    =   6375
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11670
   Icon            =   "frmConsulta2.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   6375
   ScaleWidth      =   11670
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdBuscarPorCuit 
      Appearance      =   0  'Flat
      BackColor       =   &H00E0E0E0&
      Caption         =   "Buscar x CUIT (F11)"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   10620
      MaskColor       =   &H00000000&
      Style           =   1  'Graphical
      TabIndex        =   57
      Top             =   5445
      Visible         =   0   'False
      Width           =   690
   End
   Begin VB.Frame Frame7 
      Height          =   645
      Left            =   90
      TabIndex        =   54
      Top             =   8325
      Visible         =   0   'False
      Width           =   1230
      Begin VB.OptionButton Option20 
         Height          =   195
         Left            =   45
         TabIndex        =   56
         Top             =   405
         Width           =   1095
      End
      Begin VB.OptionButton Option19 
         Height          =   195
         Left            =   45
         TabIndex        =   55
         Top             =   180
         Width           =   1050
      End
   End
   Begin VB.Frame Frame6 
      Height          =   645
      Left            =   90
      TabIndex        =   51
      Top             =   7605
      Visible         =   0   'False
      Width           =   1230
      Begin VB.OptionButton Option17 
         Height          =   195
         Left            =   45
         TabIndex        =   53
         Top             =   180
         Width           =   1050
      End
      Begin VB.OptionButton Option18 
         Height          =   195
         Left            =   45
         TabIndex        =   52
         Top             =   405
         Width           =   1095
      End
   End
   Begin VB.CheckBox Check5 
      Alignment       =   1  'Right Justify
      Caption         =   "Check5"
      Height          =   240
      Left            =   8685
      TabIndex        =   50
      Top             =   7245
      Visible         =   0   'False
      Width           =   1725
   End
   Begin VB.CheckBox Check4 
      Alignment       =   1  'Right Justify
      Caption         =   "Check4"
      Height          =   240
      Left            =   8685
      TabIndex        =   49
      Top             =   6930
      Visible         =   0   'False
      Width           =   1725
   End
   Begin VB.CheckBox Check3 
      Alignment       =   1  'Right Justify
      Caption         =   "Check3"
      Height          =   240
      Left            =   8685
      TabIndex        =   48
      Top             =   6615
      Visible         =   0   'False
      Width           =   1725
   End
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Check2"
      Height          =   240
      Left            =   8685
      TabIndex        =   45
      Top             =   6300
      Visible         =   0   'False
      Width           =   1725
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Check1"
      Height          =   240
      Left            =   8685
      TabIndex        =   44
      Top             =   5985
      Visible         =   0   'False
      Width           =   1725
   End
   Begin VB.TextBox Text2 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   5535
      TabIndex        =   43
      Top             =   6030
      Visible         =   0   'False
      Width           =   330
   End
   Begin VB.Frame Frame4 
      Height          =   465
      Left            =   90
      TabIndex        =   40
      Top             =   7065
      Visible         =   0   'False
      Width           =   3975
      Begin VB.OptionButton Option15 
         Height          =   195
         Left            =   360
         TabIndex        =   42
         Top             =   180
         Width           =   1635
      End
      Begin VB.OptionButton Option16 
         Height          =   195
         Left            =   2025
         TabIndex        =   41
         Top             =   180
         Width           =   1815
      End
   End
   Begin VB.Frame Frame1 
      Height          =   465
      Left            =   90
      TabIndex        =   10
      Top             =   5985
      Visible         =   0   'False
      Width           =   3975
      Begin VB.OptionButton Option2 
         Height          =   195
         Left            =   2025
         TabIndex        =   12
         Top             =   180
         Width           =   1815
      End
      Begin VB.OptionButton Option1 
         Height          =   195
         Left            =   360
         TabIndex        =   11
         Top             =   180
         Width           =   1635
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Tipo de consulta : "
      Height          =   510
      Left            =   5895
      TabIndex        =   13
      Top             =   5400
      Visible         =   0   'False
      Width           =   4110
      Begin VB.OptionButton Option6 
         Caption         =   "Por dia"
         Height          =   195
         Left            =   90
         TabIndex        =   17
         Top             =   225
         Width           =   870
      End
      Begin VB.OptionButton Option7 
         Caption         =   "Por semana"
         Height          =   195
         Left            =   990
         TabIndex        =   16
         Top             =   225
         Width           =   1185
      End
      Begin VB.OptionButton Option8 
         Caption         =   "Por mes"
         Height          =   195
         Left            =   2205
         TabIndex        =   15
         Top             =   225
         Width           =   915
      End
      Begin VB.OptionButton Option9 
         Caption         =   "Por año"
         Height          =   195
         Left            =   3150
         TabIndex        =   14
         Top             =   225
         Width           =   915
      End
   End
   Begin VB.Frame Frame2 
      Height          =   465
      Left            =   90
      TabIndex        =   24
      Top             =   6525
      Visible         =   0   'False
      Width           =   8340
      Begin VB.OptionButton Option11 
         Height          =   195
         Left            =   6660
         TabIndex        =   29
         Top             =   180
         Width           =   1635
      End
      Begin VB.OptionButton Option10 
         Height          =   195
         Left            =   5040
         TabIndex        =   28
         Top             =   180
         Width           =   1635
      End
      Begin VB.OptionButton Option5 
         Height          =   195
         Left            =   3405
         TabIndex        =   27
         Top             =   180
         Width           =   1635
      End
      Begin VB.OptionButton Option4 
         Height          =   195
         Left            =   1770
         TabIndex        =   26
         Top             =   180
         Width           =   1635
      End
      Begin VB.OptionButton Option3 
         Height          =   195
         Left            =   135
         TabIndex        =   25
         Top             =   180
         Width           =   1635
      End
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   5130
      TabIndex        =   36
      Top             =   6030
      Visible         =   0   'False
      Width           =   330
   End
   Begin VB.TextBox txtBuscar 
      Height          =   330
      Index           =   1
      Left            =   6705
      TabIndex        =   21
      Top             =   6030
      Visible         =   0   'False
      Width           =   645
   End
   Begin VB.TextBox txtBuscar 
      Height          =   330
      Index           =   0
      Left            =   5985
      TabIndex        =   20
      Top             =   6030
      Visible         =   0   'False
      Width           =   645
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   450
      Index           =   2
      Left            =   2880
      TabIndex        =   9
      Top             =   5445
      Width           =   1350
   End
   Begin VB.CommandButton cmd 
      Height          =   450
      Index           =   0
      Left            =   90
      TabIndex        =   8
      Top             =   5445
      Width           =   1350
   End
   Begin VB.CommandButton cmd 
      Height          =   450
      Index           =   1
      Left            =   1485
      TabIndex        =   7
      Top             =   5445
      Width           =   1350
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   5265
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
            Picture         =   "frmConsulta2.frx":076A
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsulta2.frx":087C
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsulta2.frx":098E
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsulta2.frx":0AA0
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsulta2.frx":0BB2
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsulta2.frx":0CC4
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsulta2.frx":0DD6
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   0
      Top             =   5985
      Width           =   11670
      _ExtentX        =   20585
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   5
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   8229
            Key             =   "Mensaje"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   8229
            Picture         =   "frmConsulta2.frx":1228
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
            TextSave        =   "17/01/2013"
            Key             =   "Fecha"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   4335
      Left            =   45
      TabIndex        =   1
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
      MouseIcon       =   "frmConsulta2.frx":1542
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   11670
      _ExtentX        =   20585
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
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   285
      Index           =   0
      Left            =   1350
      TabIndex        =   3
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
      Left            =   4095
      TabIndex        =   4
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
      TabIndex        =   18
      Top             =   7965
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
      TabIndex        =   19
      Top             =   8325
      Visible         =   0   'False
      Width           =   780
      _ExtentX        =   1376
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin VB.Frame Frame5 
      Height          =   420
      Left            =   6120
      TabIndex        =   30
      Top             =   495
      Visible         =   0   'False
      Width           =   5370
      Begin VB.OptionButton Option14 
         Height          =   195
         Left            =   3420
         TabIndex        =   33
         Top             =   180
         Width           =   1815
      End
      Begin VB.OptionButton Option12 
         Height          =   195
         Left            =   270
         TabIndex        =   32
         Top             =   180
         Width           =   1500
      End
      Begin VB.OptionButton Option13 
         Height          =   195
         Left            =   1845
         TabIndex        =   31
         Top             =   180
         Width           =   1500
      End
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   330
      Left            =   7650
      TabIndex        =   34
      Top             =   6030
      Visible         =   0   'False
      Width           =   420
      _ExtentX        =   741
      _ExtentY        =   582
      _Version        =   393217
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmConsulta2.frx":155E
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   2
      Left            =   9585
      TabIndex        =   46
      Top             =   7965
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
      TabIndex        =   47
      Top             =   8325
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
      Caption         =   " "
      Height          =   285
      Index           =   5
      Left            =   4950
      TabIndex        =   58
      Top             =   6075
      Visible         =   0   'False
      Width           =   135
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      Visible         =   0   'False
      X1              =   4365
      X2              =   5085
      Y1              =   5805
      Y2              =   5805
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
      Left            =   4365
      TabIndex        =   39
      Top             =   5400
      Visible         =   0   'False
      Width           =   420
   End
   Begin VB.Label lblLabels 
      Caption         =   " "
      Height          =   150
      Index           =   2
      Left            =   4680
      TabIndex        =   38
      Top             =   6075
      Visible         =   0   'False
      Width           =   165
   End
   Begin VB.Label lblLabels 
      Caption         =   " "
      Height          =   285
      Index           =   3
      Left            =   4230
      TabIndex        =   37
      Top             =   6075
      Visible         =   0   'False
      Width           =   135
   End
   Begin VB.Label lblLabels 
      Caption         =   " "
      Height          =   285
      Index           =   4
      Left            =   4455
      TabIndex        =   35
      Top             =   6075
      Visible         =   0   'False
      Width           =   135
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   285
      Index           =   1
      Left            =   9540
      TabIndex        =   23
      Top             =   540
      Visible         =   0   'False
      Width           =   690
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   285
      Index           =   0
      Left            =   8865
      TabIndex        =   22
      Top             =   540
      Visible         =   0   'False
      Width           =   600
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha final :"
      Height          =   240
      Index           =   1
      Left            =   2745
      TabIndex        =   6
      Top             =   585
      Visible         =   0   'False
      Width           =   1290
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha inicial :"
      Height          =   240
      Index           =   0
      Left            =   90
      TabIndex        =   5
      Top             =   585
      Visible         =   0   'False
      Width           =   1200
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Opciones"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar costo a item de pedido"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Registrar ingreso de bien de uso"
         Index           =   1
      End
   End
   Begin VB.Menu MnuDetReq 
      Caption         =   "Requerimientos pendientes de asignacion"
      Visible         =   0   'False
      Begin VB.Menu MnuDetReqA 
         Caption         =   "Generar vale de salida (Por Stock)"
         Index           =   0
      End
      Begin VB.Menu MnuDetReqA 
         Caption         =   "Liberar para compras"
         Index           =   1
      End
      Begin VB.Menu MnuDetReqA 
         Caption         =   "Dar por cumplido"
         Index           =   2
      End
   End
   Begin VB.Menu MnuDetCal 
      Caption         =   "Control de calidad - Remitos de rechazo"
      Visible         =   0   'False
      Begin VB.Menu MnuDetCalA 
         Caption         =   "Generar remito de rechazo x control de calidad"
         Index           =   0
      End
   End
End
Attribute VB_Name = "frmConsulta2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim WithEvents ActL3 As ControlForm
Attribute ActL3.VB_VarHelpID = -1
Private oF_BuscarPorCuit As frm_Aux
Private mvarId As Long, mIdComparativa As Long, mIdPresupuestoSeleccionado As Long
Private mvarIdProveedor As Long, mvarIdPedido As Long
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
   mvarFechaHasta = DateAdd("m", 1, mvarFechaDesde)
   mvarFechaHasta = DateAdd("d", -1, mvarFechaHasta)
   
   mvarParametrosExcel = ""
   mvarDesglosarNOGRAVADOS = False
   
     
         Toolbar1.Enabled = True
      
   Select Case mvarId
      Case 402
         
         Me.Caption = "Necesidad de Compras"
         Cmd(0).Caption = "Procesar"
         Cmd(1).Visible = False
         Cmd(2).Left = Cmd(1).Left
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         Me.MousePointer = vbHourglass
         DoEvents
         Set oAp = Aplicacion
         'Set oTab = oAp.ProduccionOrdenes.TraerFiltrado("_NecesidadDeCompras")
         'Lista.Sorted = False
         'Set Lista.DataSource = oTab
         'ReemplazarEtiquetasListas Lista
         Set oTab = Nothing
         Set oAp = Nothing
         mvarCual = 99
         Me.MousePointer = vbDefault
        
      Case 403
         Me.Caption = "Estado de la produccion en Semielaborado"
         Cmd(0).Caption = "Procesar"
         Cmd(1).Visible = False
         Cmd(2).Left = Cmd(1).Left
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
            .TOp = Cmd(0).TOp
            .Left = Cmd(1).Left + Cmd(1).Width + 50
            .Visible = True
         End With
         With Option1
            .Caption = "Todas"
            .Value = True
         End With
         Option2.Caption = "Elegir una"
         With lblLabels(4)
            .TOp = Frame1.TOp + 10
            .Left = Frame1.Left + Frame1.Width + 50
            .AutoSize = True
            .Caption = "Obra   : "
         End With
         With DataCombo1(1)
            .TOp = Frame1.TOp
            .Left = lblLabels(4).Left + lblLabels(4).Width + 20
            .Width = Frame3.Width * 0.75
            .BoundColumn = "IdObra"
            Set .RowSource = Aplicacion.ProduccionOrdenes.TraerFiltrado("_EstadoProduccionEnSemielaborado")
         End With
      
      Case 404
         Me.Caption = "Planificacion de la produccion"
         Cmd(0).Caption = "Procesar"
         Cmd(1).Visible = False
         Cmd(2).Left = Cmd(1).Left
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
            .TOp = Cmd(0).TOp
            .Left = Cmd(1).Left + Cmd(1).Width + 50
            .Visible = True
         End With
         With Option1
            .Caption = "Todas"
            .Value = True
         End With
         Option2.Caption = "Elegir una"
         With lblLabels(4)
            .TOp = Frame1.TOp + 10
            .Left = Frame1.Left + Frame1.Width + 50
            .AutoSize = True
            .Caption = "Obra   : "
         End With
         With DataCombo1(1)
            .TOp = Frame1.TOp
            .Left = lblLabels(4).Left + lblLabels(4).Width + 20
            .Width = Frame3.Width * 0.75
            .BoundColumn = "IdObra"
            Set .RowSource = Aplicacion.ProduccionOrdenes.TraerFiltrado("_ResumenDePlanificacion")
         End With
      
      Case 405
         Me.Caption = "Necesidades de Planificacion de la produccion"
         Cmd(0).Caption = "Procesar"
         Cmd(1).Visible = False
         Cmd(2).Left = Cmd(1).Left
         
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         Me.MousePointer = vbHourglass
         DoEvents
         Set oAp = Aplicacion
         Set oTab = oAp.ProduccionOrdenes.TraerFiltrado("_NecesidadDePlanificacionDeProduccion")
         Lista.Sorted = False
         'Set Lista.DataSource = oTab
         'ReemplazarEtiquetasListas Lista
         Set oTab = Nothing
         Set oAp = Nothing
         mvarCual = 99
         Me.MousePointer = vbDefault
      
      Case 407
         Me.Caption = "Rendimiento"
         Cmd(0).Caption = "Procesar"
         Cmd(1).Visible = False
         Cmd(2).Left = Cmd(1).Left
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
            .Caption = "Sector : "
            .TOp = Cmd(0).TOp
            .Left = Cmd(1).Left + Cmd(1).Width + 50
            .Visible = False
         End With
         With Option1
            .Caption = "Todas"
            .Value = True
         End With
         Option2.Caption = "Elegir una"
         With lblLabels(4)
         .Visible = True
            .TOp = Frame1.TOp + 10
            .Left = Frame1.Left + Frame1.Width + 50
            .AutoSize = True
            .Caption = "Sector   : "
         End With
         With DataCombo1(1)
            .Visible = True
            .Enabled = True
            .TOp = Frame1.TOp
            .Left = lblLabels(4).Left + lblLabels(4).Width + 20
            .Width = Frame3.Width * 0.75
            .BoundColumn = "IdProduccionSector"
            Set .RowSource = Aplicacion.TablasGenerales.TraerLista("ProduccionSectores")
         End With
         
         
         Me.Caption = "Rendimiento"
         Cmd(0).Caption = "Procesar"
         Cmd(1).Visible = False
         Cmd(2).Left = Cmd(1).Left
         
         Me.MousePointer = vbHourglass
         DoEvents
         Set oAp = Aplicacion
         'Set oTab = oAp.ProduccionOrdenes.TraerFiltrado("_Rendimiento")
         Lista.Sorted = False
         'Set Lista.DataSource = oTab
         'ReemplazarEtiquetasListas Lista
         Set oTab = Nothing
         Set oAp = Nothing
         mvarCual = 99
         Me.MousePointer = vbDefault


      
      
   End Select
   
   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Property

Public Property Get Id() As Integer

   Id = mvarId
   
End Property

Private Sub ActL3_ActLista(ByVal IdRegistro As Long, ByVal TipoAccion As EnumAcciones, ByVal NombreListaEditada As String, ByVal mvarIdRegistroOriginal As Long)

   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", IdRegistro)
   If oRs.RecordCount > 0 Then
      text1.Text = oRs.Fields("CodigoEmpresa").Value
      Text2.Text = oRs.Fields("CodigoEmpresa").Value
   End If
   oRs.Close
   Set oRs = Nothing

End Sub

Private Sub Check1_Click()

   If Me.Id = 65 Then
      If Check1.Value = 1 Then
         With lblLabels(1)
            .Caption = "Calcular saldos al :"
            .Left = DTFields(0).Left + DTFields(0).Width + 10
            .TOp = lblLabels(0).TOp
            .Width = DTFields(1).Width * 1.1
            .Visible = True
         End With
         With DTFields(1)
            .TOp = DTFields(0).TOp
            .Left = lblLabels(1).Left + lblLabels(1).Width + 1
            .Value = Date
            .Visible = True
         End With
      Else
         lblLabels(1).Visible = False
         DTFields(1).Visible = False
      End If
   ElseIf Me.Id = 34 Or Me.Id = 66 Then
      If Check1.Value = 1 Then
         DataCombo1(2).Enabled = True
      Else
         DataCombo1(2).Enabled = False
      End If
   ElseIf Me.Id = 104 Then
      Lista.ListItems.Clear
      cmd_Click 0
   End If

End Sub

Private Sub Check2_Click()

   If Me.Id = 34 Or Me.Id = 66 Then
      If Check2.Value = 1 Then
         DataCombo1(3).Enabled = True
      Else
         DataCombo1(3).Enabled = False
      End If
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   Dim oAp As ComPronto.Aplicacion
'   Dim dsoServer As DSO.Server
'   Dim dsoDatabase As DSO.Database
'   Dim oPackage As DTS.Package2
   Dim oTab As ADOR.Recordset
   Dim mvarCubo As String, mDesdeAlfa As String, mHastaAlfa As String, mOrden As String, mArchivoTxt As String
   Dim s As String, mProvincias As String, mResultado As String, mStringAux As String, mArchivoSalida As String
   Dim mPendiente As String, mConceptosAbono As String, mCreditos As String, mCampo As String, mCampo1 As String
   Dim mCampo2 As String, mIncluirCierre As String, mDesdeCodigo As String, mHastaCodigo As String
   Dim mActivaRango As Integer, mTipoBusqueda As Integer, mIdBusqueda As Integer, mPos As Integer, i As Integer
   Dim mSeñal As Integer, mSeñal1 As Integer, mDesde As Integer, mHasta As Integer, X As Integer
   Dim mvarIdAux As Long, mvarIdAux1 As Long, mvarIdAux2 As Long
   Dim mvarAcumulado As Double, mvarSaldo As Double
   Dim mVectorProvincias, mVectorAux
   
   mvarSubTituloExcel = ""
   
   Toolbar1.Enabled = True
   
   On Error GoTo Mal
   
   Set oAp = Aplicacion
   
   
   Select Case Index
      Case 0
         Select Case Me.Id
         
            Case 402
               
               With lblInfo
                  .AutoSize = True
                  .TOp = Cmd(0).TOp
                  .Left = DTFields(1).Left + DTFields(1).Width * 2
                  .Caption = "PROCESANDO INFORMACION, UN MOMENTO..."
                  .Visible = True
               End With
               DoEvents
               
               
               
               
               Set oTab = oAp.ProduccionOrdenes.TraerFiltrado("_NecesidadDeCompras")
               Lista.Sorted = False
               Set Lista.DataSource = oTab
               
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               
               
               oTab.Close
               Set oTab = Nothing
               
               'Unload Me
         
         
            Case 405
               
               With lblInfo
                  .AutoSize = True
                  .TOp = Cmd(0).TOp
                  .Left = DTFields(1).Left + DTFields(1).Width * 2
                  .Caption = "PROCESANDO INFORMACION, UN MOMENTO..."
                  .Visible = True
               End With
               DoEvents
               
               
               
               
               Set oTab = oAp.ProduccionOrdenes.TraerFiltrado("_NecesidadDePlanificacionDeProduccion")
               Lista.Sorted = False
               Set Lista.DataSource = oTab
               
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               'Unload Me
         
         
         
           Case 407
               
               With lblInfo
                  .AutoSize = True
                  .TOp = Cmd(0).TOp
                  .Left = DTFields(1).Left + DTFields(1).Width * 2
                  .Caption = "PROCESANDO INFORMACION, UN MOMENTO..."
                  .Visible = True
               End With
               DoEvents
               
            
                'DataCombo1(1).Text = DataCombo1(1).Text 'linea magica de bug clásico del combo
                If IsNumeric(DataCombo1(1).BoundText) Then
                    Set oTab = oAp.ProduccionOrdenes.TraerFiltrado("_Rendimiento", Array(DataCombo1(1).BoundText, DTFields(0), DTFields(1)))
                    
                Else
                    Set oTab = oAp.ProduccionOrdenes.TraerFiltrado("_Rendimiento", Array(-1, DTFields(0), DTFields(1)))
                    'MsgBox ("Elija un sector")
                    'Exit Sub
                End If
                
                
                
                
               
                
                
               Lista.Sorted = False
               Set Lista.DataSource = oTab
               
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  'oTab.Close
                  'Set oTab = Nothing
                  'Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               'Unload Me
         
         
         
         End Select
        
         lblInfo.Visible = False

         Lista.Sorted = False
         If Not oTab Is Nothing Then
            Set Lista.DataSource = oTab
            ReemplazarEtiquetasListas Lista
            If Me.Id = 26 Then
               ReemplazarColumnHeaderDeudaVencida
            ElseIf Me.Id = 86 Then
               ReemplazarColumnHeader
            End If
            Lista.Refresh
         Else
            'Lista.ListItems.Clear
         End If
         
         If Lista.ListItems.Count > 0 Then
            StatusBar1.Panels(2).Text = "" & Lista.ListItems.Count & " elementos en la lista"
         End If
   
         Set oTab = Nothing
         Set oAut = Nothing
         Set oAp = Nothing
         
         CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
         
         Me.MousePointer = vbDefault
         
         mvarCual = 99
         
      Case 1
         Dim oL As ListItem
         
         Select Case Me.Id
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

Private Sub cmdBuscarPorCuit_Click()

   If oF_BuscarPorCuit Is Nothing Then Set oF_BuscarPorCuit = New frm_Aux
   With oF_BuscarPorCuit
      .Id = 18
      '.Disparar = ActL3
      .Show , Me
   End With

End Sub

Private Sub DataCombo1_Change(Index As Integer)

   Dim oRs As ADOR.Recordset
   Select Case mvarId
      Case 57
         If Index = 1 And IsNumeric(DataCombo1(Index).BoundText) Then
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then
               text1.Text = IIf(IsNull(oRs.Fields("NumeroInventario").Value), "", oRs.Fields("NumeroInventario").Value)
            End If
            oRs.Close
         End If
   End Select
   Set oRs = Nothing

End Sub

Private Sub DataCombo1_Click(Index As Integer, Area As Integer)

   SetDataComboDropdownListWidth 300
   
End Sub

Private Sub Form_Activate()

   Select Case mvarId
      Case 3
         Me.Refresh
         Lista.Sorted = False
         Set Lista.DataSource = Aplicacion.Comparativas.TraerFiltrado("_ItemsSeleccionados", mIdComparativa)
         If Lista.ListItems.Count > 0 Then
            StatusBar1.Panels(2).Text = "" & Lista.ListItems.Count & " elementos en la lista"
         End If
      Case 35, 36
         cmd_Click 0
   End Select
   
   ReemplazarEtiquetas Me
   
End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)

   'F11 para llamar el formulario de busqueda de proveedores por cuit
   If Me.Id = 26 And Option2.Value Then
      If KeyCode = 122 Then
         cmdBuscarPorCuit_Click
      End If
   End If

End Sub

Private Sub Form_Load()

   Set ActL3 = New ControlForm
   
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

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   Set ActL3 = Nothing
   If Not oF_BuscarPorCuit Is Nothing Then
      Unload oF_BuscarPorCuit
      Set oF_BuscarPorCuit = Nothing
   End If

End Sub

Private Sub Lista_DblClick()
  On Error Resume Next
   If Not Lista.SelectedItem Is Nothing Then
      Select Case mvarId
         Case 402
            Dim frmPM As frmPlanificacionMateriales
            Set frmPM = New frmPlanificacionMateriales
            With frmPM
                 .NivelAcceso = 9
                 .OpcionesAcceso = 9
                 .Id = -1
                 '.Disparar = ActL
                 ReemplazarEtiquetas frmPM
                 .Show , Me
                 
                 
                 CambiaDcfields frmPM, 0, BuscaIdArticulo(Lista.SelectedItem)
                 .cmdCommand1_Click
             End With
         
         Case 405

            Set frmPM = New frmPlanificacionMateriales
            With frmPM
                 .NivelAcceso = 9
                 .OpcionesAcceso = 9
                 .Id = -1
                 '.Disparar = ActL
                 ReemplazarEtiquetas frmPM
                 .Show , Me
                 
                 
                 CambiaDcfields frmPM, 0, BuscaIdArticulo(mId$(Lista.SelectedItem, InStr(Lista.SelectedItem, " :: ") + 4))
                 .cmdCommand1_Click
             End With

         Case 29
            Dim oF As frmConsulta1
            Set oF = New frmConsulta1
            With oF
               .IdParametro = Lista.SelectedItem.SubItems(2)
               .Id = 9
               With .Label1
                  .Caption = Lista.SelectedItem.Text & " - " & Lista.SelectedItem.SubItems(1)
                  .Visible = True
               End With
               .Show vbModal, Me
            End With
            Unload oF
            Set oF = Nothing
         Case 1, 54
            If Len(Lista.SelectedItem.SubItems(1)) > 0 And Len(Lista.SelectedItem.SubItems(2)) > 0 Then
               EditarComprobante Lista.SelectedItem.SubItems(1), Lista.SelectedItem.SubItems(2)
            End If
      End Select
   End If

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_ItemClick(ByVal Item As MSComctlLib.IListItem)

   If mvarId = 54 Then
      rchObservaciones.Text = Item.SubItems(7)
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, y As Single)

   If Button = vbRightButton Then
         If mvarId = 33 Then
            'PopupMenu MnuFac, , , , MnuFacA(0)
         ElseIf mvarId = 70 Then
            MnuDetA(1).Visible = False
            PopupMenu MnuDet, , , , MnuDetA(0)
         ElseIf mvarId = 81 Then
            MnuDetA(0).Visible = False
            PopupMenu MnuDet, , , , MnuDetA(1)
         ElseIf mvarId = 89 Then
            PopupMenu MnuDetReq, , , , MnuDetReqA(0)
         ElseIf mvarId = 95 Then
            PopupMenu MnuDetCal, , , , MnuDetCalA(0)
         End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         If mvarId = 70 Then
            AsignarCostosImportacionAItemPedido
         End If
      Case 1
         If mvarId = 81 Then
            RegistrarBienesDeUso
         End If
      
   End Select

End Sub

Private Sub MnuDetCalA_Click(Index As Integer)

   GenerarRemitoRechazo

End Sub

Private Sub MnuDetReqA_Click(Index As Integer)

   Select Case Index
      Case 0
         If Not Lista.SelectedItem Is Nothing Then
            GenerarValesAlmacen Lista.GetString
            cmd_Click 0
         End If
      Case 1
         If Not Lista.SelectedItem Is Nothing Then
            LiberarRMParaCompras Lista.GetString
            cmd_Click 0
         End If
      Case 2
         If Not Lista.SelectedItem Is Nothing Then
            DarPorCumplido
            cmd_Click 0
         End If

   End Select

End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      Select Case mvarId
         Case 26
            lblLabels(1).Visible = False
            text1.Visible = False
            Text2.Visible = False
            cmdBuscarPorCuit.Visible = False
         Case 42, 51, 60, 91, 107
            lblLabels(4).Visible = False
            DataCombo1(1).Visible = False
         Case 57
            lblLabels(4).Visible = False
            DataCombo1(1).Visible = False
            text1.Visible = False
         Case 58
            lblLabels(0).Visible = False
            DTFields(0).Visible = False
         Case 90
         Case Else
            Lista.ListItems.Clear
            If Lista.ColumnHeaders.Count > 0 Then Lista.ColumnHeaders.Clear
            txtBuscar(0).Enabled = False
            txtBuscar(1).Enabled = False
            DataCombo1(0).Enabled = False
            DataCombo1(1).Enabled = False
      End Select
   End If
   
End Sub

Private Sub Option10_Click()

   If Option10.Value Then
      Lista.ListItems.Clear
      If Lista.ColumnHeaders.Count > 0 Then Lista.ColumnHeaders.Clear
      Select Case mvarId
         Case 28
            Frame3.Visible = False
            
      End Select
   End If

End Sub

Private Sub Option11_Click()

   If Option11.Value Then
      Lista.ListItems.Clear
      If Lista.ColumnHeaders.Count > 0 Then Lista.ColumnHeaders.Clear
      Select Case mvarId
         Case 28
            Frame3.Visible = False
            
      End Select
   End If

End Sub

Private Sub Option12_Click()

   If Option12.Value Then
      Select Case mvarId
         Case 42
            lblLabels(3).Visible = False
            With lblLabels(2)
               .Left = Cmd(1).Left + Cmd(1).Width + 10
               .TOp = Cmd(1).TOp - 2
               .AutoSize = True
               .Caption = "Rubros : "
               .Visible = True
            End With
            With DataCombo1(0)
               .Left = lblLabels(2).Left
               .TOp = lblLabels(2).TOp + lblLabels(2).Height + 1
               .Width = Cmd(1).Width * 2
               Set .RowSource = Aplicacion.Rubros.TraerLista
               .BoundColumn = "IdRubro"
               .Visible = True
            End With
            With text1
               .Left = DataCombo1(0).Left + DataCombo1(0).Width + 10
               .TOp = DataCombo1(0).TOp
               .Width = Cmd(1).Width * 3
               .Alignment = 0
               .Text = ""
               .Visible = True
            End With
      End Select
   End If

End Sub

Private Sub Option13_Click()

   If Option13.Value Then
      Select Case mvarId
         Case 42
            With lblLabels(2)
               .Left = Cmd(1).Left + Cmd(1).Width + 10
               .TOp = Cmd(1).TOp - 2
               .AutoSize = True
               .Caption = "Articulos : "
               .Visible = True
            End With
            With DataCombo1(0)
               .Left = lblLabels(2).Left
               .TOp = lblLabels(2).TOp + lblLabels(2).Height + 1
               .Width = Cmd(1).Width * 4
               Set .RowSource = Aplicacion.Articulos.TraerLista
               .BoundColumn = "IdArticulo"
               .Visible = True
            End With
            With lblLabels(3)
               .Left = DataCombo1(0).Left + DataCombo1(0).Width + 10
               .TOp = Cmd(1).TOp - 2
               .AutoSize = True
               .Caption = "Buscar : "
               .Visible = True
            End With
            With text1
               .Left = DataCombo1(0).Left + DataCombo1(0).Width + 10
               .TOp = DataCombo1(0).TOp
               .Width = Cmd(1).Width * 2
               .Alignment = 0
               .Text = ""
               .Visible = True
            End With
      End Select
   End If

End Sub

Private Sub Option14_Click()

   If Option14.Value Then
      Select Case mvarId
         Case 42
            lblLabels(3).Visible = False
            DataCombo1(0).Visible = False
            With lblLabels(2)
               .Left = Cmd(1).Left + Cmd(1).Width + 10
               .TOp = Cmd(1).TOp - 2
               .AutoSize = True
               .Caption = "Descripcion del articulo : "
               .Visible = True
            End With
            With text1
               .Left = lblLabels(2).Left
               .TOp = lblLabels(2).TOp + lblLabels(2).Height + 1
               .Width = Cmd(1).Width * 4
               .Alignment = 0
               .Visible = True
               .Text = ""
            End With
      End Select
   End If

End Sub

Private Sub Option15_Click()

   If Option15.Value Then
      If Me.Id = 22 Or Me.Id = 34 Then
         With lblLabels(0)
            .Visible = True
            .Caption = "Saldos al :"
         End With
         lblLabels(1).Visible = False
         DTFields(0).Visible = True
         DTFields(1).Visible = False
      ElseIf Me.Id = 57 Then
         lblLabels(5).Visible = False
         DataCombo1(2).Visible = False
      ElseIf Me.Id = 66 Then
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
      End If
   End If

End Sub

Private Sub Option16_Click()

   If Option16.Value Then
      If Me.Id = 22 Or Me.Id = 34 Then
         With lblLabels(0)
            .Visible = True
            .Caption = "Fecha inicial :"
         End With
         lblLabels(1).Visible = True
         DTFields(0).Visible = True
         DTFields(1).Visible = True
      ElseIf Me.Id = 57 Then
         lblLabels(5).Visible = True
         DataCombo1(2).Visible = True
      ElseIf Me.Id = 66 Then
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         DTFields(0).Visible = True
         DTFields(1).Visible = True
      End If
   End If

End Sub

Private Sub Option17_Click()

   If Option17.Value Then
      Select Case mvarId
         Case 61
            lblLabels(2).Visible = False
            DataCombo1(3).Visible = False
      End Select
   End If

End Sub

Private Sub Option18_Click()

   If Option18.Value Then
      Select Case mvarId
         Case 61
            With lblLabels(2)
               .Left = Frame6.Left + Frame6.Width + 10
               .TOp = Frame6.TOp
               .AutoSize = True
               .Caption = "Obras : "
               .Visible = True
            End With
            With DataCombo1(3)
               .Left = lblLabels(2).Left
               .TOp = lblLabels(2).TOp + lblLabels(2).Height + 1
               .Width = Cmd(1).Width * 2
               Set .RowSource = Aplicacion.Obras.TraerLista
               .BoundColumn = "IdObra"
               .Visible = True
            End With
      End Select
   End If

End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      Select Case mvarId
         Case 26
            lblLabels(1).Visible = True
            text1.Visible = True
            Text2.Visible = True
            cmdBuscarPorCuit.Visible = True
         Case 42, 51, 60, 91, 107
            lblLabels(4).Visible = True
            DataCombo1(1).Visible = True
         Case 57
            lblLabels(4).Visible = True
            DataCombo1(1).Visible = True
            text1.Visible = True
         Case 58
            lblLabels(0).Visible = True
            DTFields(0).Visible = True
         Case 90
         Case Else
            Lista.ListItems.Clear
            If Lista.ColumnHeaders.Count > 0 Then Lista.ColumnHeaders.Clear
            txtBuscar(0).Enabled = True
            txtBuscar(1).Enabled = True
            DataCombo1(0).Enabled = True
            DataCombo1(1).Enabled = True
      End Select
   End If
   
End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      Lista.ListItems.Clear
      If Lista.ColumnHeaders.Count > 0 Then Lista.ColumnHeaders.Clear
      Select Case mvarId
         Case 28
            Frame3.Visible = True
            
      End Select
   End If

End Sub

Private Sub Option4_Click()

   If Option4.Value Then
      Lista.ListItems.Clear
      If Lista.ColumnHeaders.Count > 0 Then Lista.ColumnHeaders.Clear
      Select Case mvarId
         Case 28
            Frame3.Visible = True
            
      End Select
   End If

End Sub

Private Sub Option5_Click()

   If Option5.Value Then
      Lista.ListItems.Clear
      If Lista.ColumnHeaders.Count > 0 Then Lista.ColumnHeaders.Clear
      Select Case mvarId
         Case 28
            Frame3.Visible = False
            
      End Select
   End If

End Sub

Private Sub Option6_Click()

   If Option6.Value Then
      Lista.ListItems.Clear
      If Lista.ColumnHeaders.Count > 0 Then Lista.ColumnHeaders.Clear
   End If
   
End Sub

Private Sub Option7_Click()

   If Option7.Value Then
      Lista.ListItems.Clear
      If Lista.ColumnHeaders.Count > 0 Then Lista.ColumnHeaders.Clear
   End If
   
End Sub

Private Sub Option8_Click()

   If Option8.Value Then
      Lista.ListItems.Clear
      If Lista.ColumnHeaders.Count > 0 Then Lista.ColumnHeaders.Clear
   End If
   
End Sub

Private Sub Option9_Click()

   If Option9.Value Then
      Lista.ListItems.Clear
      If Lista.ColumnHeaders.Count > 0 Then Lista.ColumnHeaders.Clear
   End If
   
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)

   Dim oRs As ADOR.Recordset
   Select Case mvarId
      Case 42
         If Option13.Value Then
            If KeyAscii = Asc(vbCr) Then
               If KeyAscii = 13 Then
                  If Len(Trim(text1.Text)) <> 0 Then
                     Set oRs = Aplicacion.Articulos.TraerFiltrado("_Busca", text1.Text)
                  Else
                     Set oRs = Aplicacion.Articulos.TraerLista
                  End If
                  Set DataCombo1(0).RowSource = oRs
                  If oRs.RecordCount > 0 Then
                     DataCombo1(0).BoundText = oRs.Fields(0).Value
                  End If
               End If
               DataCombo1(0).SetFocus
               SendKeys "%{DOWN}"
            End If
         End If
      Case 57
         If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   End Select
   Set oRs = Nothing

End Sub

Private Sub Text1_Validate(Cancel As Boolean)

   Dim oRs As ADOR.Recordset
   Select Case mvarId
      Case 57
         If Len(Trim(text1.Text)) <> 0 Then
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorNumeroInventario", text1.Text)
            If oRs.RecordCount > 0 Then
               DataCombo1(1).BoundText = oRs.Fields(0).Value
            Else
               MsgBox "Equipo inexistente", vbExclamation
               Cancel = True
            End If
            oRs.Close
         End If
   End Select
   Set oRs = Nothing

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Dim mCampo1 As String, mAuxS1 As String
   Dim mvarIdAux1 As Long
   
   Select Case Button.Key
      Case "Imprimir"
         If BuscarClaveINI("Libros a TXT") = "SI" Then
            mCampo1 = "SD"
            mAuxS1 = ""
            If mvarId = 16 Then
               mCampo1 = "IvaVentas"
               mAuxS1 = BuscarClaveINI("Ancho columnas iva ventas")
            ElseIf mvarId = 17 Then
               mCampo1 = "IvaCompras"
               mAuxS1 = BuscarClaveINI("Ancho columnas iva compras")
            ElseIf mvarId = 86 Then
               mCampo1 = BuscarClaveINI("Macro para iva compras detallado")
               ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, mCampo1
            ElseIf mvarId >= 97 And mvarId <= 101 Then
'               If mvarId = 100 Then
                  ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, _
                        "FormatearTitulosGenericos|" & DTFields(1).Value & "|" & text1.Text & "|" & glbEmpresa
'               Else
'                  ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, _
'                        "FormatearTitulosGenericos|" & DTFields(1).Value
'               End If
            ElseIf mvarId = 102 Then
               ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, _
                     "FormatearTituloIvaVentas|" & DTFields(1).Value & "|" & text1.Text & "|" & glbEmpresa, mvarParametrosExcel
            ElseIf mvarId = 103 Then
               ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, _
                     "FormatearTituloIvaCompras1|" & DTFields(1).Value & "|" & text1.Text & "|" & glbEmpresa, mvarParametrosExcel
            End If
            If Len(mAuxS1) > 0 Then mAuxS1 = "Columnas:" & mAuxS1
            With lblInfo
               .TOp = Cmd(1).TOp
               .Left = Cmd(1).Left + Cmd(1).Width + 100
               .Width = Cmd(1).Width * 5
               .Height = Cmd(1).Height
               .Visible = True
            End With
            ArmarTXT Lista, mCampo1, Me.Caption & mvarSubTituloExcel, _
                     mAuxS1 & "|LineasPorPagina:72|" & mvarParametrosExcel, Me
            lblInfo.Visible = False
            Exit Sub
         End If
         If mvarId = 16 Then
            mCampo1 = BuscarClaveINI("Macro para iva ventas")
            If Len(Trim(mCampo1)) = 0 Then mCampo1 = "FormatearTituloIvaCompras"
            ImprimirConExcel Lista, Me.Caption & mvarSubTituloExcel, _
                  mCampo1, mvarParametrosExcel
         ElseIf mvarId = 17 Then
            mCampo1 = BuscarClaveINI("Macro para iva compras")
            If Len(Trim(mCampo1)) = 0 Then mCampo1 = "FormatearTituloIvaCompras"
            ImprimirConExcel Lista, Me.Caption & mvarSubTituloExcel, _
                  mCampo1, mvarParametrosExcel
         Else
            ImprimirConExcel Lista, Me.Caption & mvarSubTituloExcel
         End If
      
      Case "Buscar"
         FiltradoLista Lista
         StatusBar1.Panels(2).Text = " " & Lista.ListItems.Count & " elementos en la lista"

      Case "Excel"
         If mvarId = 16 Then
            mCampo1 = BuscarClaveINI("Macro para iva ventas")
            If Len(Trim(mCampo1)) = 0 Then mCampo1 = "FormatearTituloIvaCompras"
            ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, _
                  mCampo1, mvarParametrosExcel
         ElseIf mvarId = 17 Then
            mCampo1 = BuscarClaveINI("Macro para iva compras")
            If Len(Trim(mCampo1)) = 0 Then mCampo1 = "FormatearTituloIvaCompras"
            ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, _
                  mCampo1, mvarParametrosExcel
         ElseIf mvarId = 86 Then
            mCampo1 = BuscarClaveINI("Macro para iva compras detallado")
            ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, mCampo1
         ElseIf mvarId >= 97 And mvarId <= 101 Then
            ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, _
                  "FormatearTitulosGenericos|" & DTFields(1).Value & "|" & text1.Text & "|" & glbEmpresa
         ElseIf mvarId = 102 Then
            ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, _
                  "FormatearTituloIvaVentas|" & DTFields(1).Value & "|" & text1.Text & "|" & glbEmpresa, mvarParametrosExcel
         ElseIf mvarId = 103 Then
            ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, _
                  "FormatearTituloIvaCompras1|" & DTFields(1).Value & "|" & text1.Text & "|" & glbEmpresa, mvarParametrosExcel
         Else
            ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel
         End If
   End Select

End Sub

Public Property Get IdComparativa() As Long

   IdComparativa = mIdComparativa
   
End Property

Public Property Let IdComparativa(ByVal vNewValue As Long)

   mIdComparativa = vNewValue
   
End Property

Public Property Get IdPresupuestoSeleccionado() As Long

   IdPresupuestoSeleccionado = mIdPresupuestoSeleccionado
   
End Property

Public Property Let IdPresupuestoSeleccionado(ByVal vNewValue As Long)

   mIdPresupuestoSeleccionado = vNewValue

End Property

Public Function TraerCubo(ByVal Cubo As String, ByVal Lapso As String, ByVal ConTotalesH As Boolean, Optional FechaDesde As Date, Optional FechaHasta As Date) As ADOR.Recordset

   Dim oCOn As New ADODB.Connection
'   Dim dsoServer As DSO.Server
'   Dim dsoDatabase As DSO.Database
'   Dim oPackage As DTS.Package2
   Dim cat As New ADOMD.Catalog
   Dim cst As New ADOMD.Cellset
   Dim oRs As ADOR.Recordset
   Dim i As Integer, j As Integer, mvarIdAux As Integer
   Dim strSource As String, strColumnHeader As String, mVector_T As String
   Dim mVector_X As String, strRowText As String, mServidor As String, mVT As String
   Dim mTitulo As String, mvarDirectorioDTS As String, mvarTablaOrigen As String
   Dim mTotal As Double, mTotalG As Double
   
   On Error GoTo ProcesoMal:
   
   Set oRs = Aplicacion.Parametros.TraerTodos
   mvarDirectorioDTS = oRs.Fields("DirectorioDTS").Value
   oRs.Close
   
   mvarIdAux = -1
   If BuscarClaveINI("Incluir ingresos por asiento para cubos") <> "SI" Then
      mvarIdAux = 0
   End If
   
   'Con DSO
'   Set dsoServer = New DSO.Server
'   dsoServer.Connect gblHOST
'   Set dsoDatabase = dsoServer.MDStores.Item(glbEmpresaSegunString)
               
   'Con DTS Package
'   Set oPackage = New DTS.Package2
   
   'Procesar tabla para alimentar al cubo
   Select Case Cubo
      
      Case "Gastos_Obra"
         Aplicacion.Tarea "Cuentas_CuadroGastosPorObra", Array(FechaDesde, FechaHasta, _
            glbDtsExec & " /F " & mvarDirectorioDTS & "CuboGastos_" & glbEmpresaSegunString & "." & glbDtsExt)
         ' dsoDatabase.MDStores.Item("Gastos").Process processFull
         ' oPackage.LoadFromSQLServer gblHOST, "", "", DTSSQLStgFlag_UseTrustedConnection, , , , "CuboGastos_" & glbEmpresaSegunString
         mvarTablaOrigen = "_TempCuadroGastosParaCubo"
         mTitulo = "Obras / Rubros gasto"
         mVT = "8"
         strSource = strSource & "SELECT "
         strSource = strSource & "[Rubro].members ON COLUMNS,"
         strSource = strSource & "NON EMPTY [Obra].members ON ROWS"
         strSource = strSource & " FROM Gastos"
      
      Case "Gastos_Unidad"
         Aplicacion.Tarea "Cuentas_CuadroGastosPorObra", Array(FechaDesde, FechaHasta, _
            glbDtsExec & " /F " & mvarDirectorioDTS & "CuboGastos_" & glbEmpresaSegunString & "." & glbDtsExt)
         ' dsoDatabase.MDStores.Item("Gastos").Process processFull
         ' oPackage.LoadFromSQLServer gblHOST, "", "", DTSSQLStgFlag_UseTrustedConnection, , , , "CuboGastos_" & glbEmpresaSegunString
         mvarTablaOrigen = "_TempCuadroGastosParaCubo"
         mTitulo = "Unidad op. / Rubros gasto"
         mVT = "8"
         strSource = strSource & "SELECT "
         strSource = strSource & "[Rubro].members ON COLUMNS,"
         strSource = strSource & "NON EMPTY [UnidadOperativa].members ON ROWS"
         strSource = strSource & " FROM Gastos"
      
      Case "Gastos_Provincia_Rubro"
         Aplicacion.Tarea "Cuentas_CuadroGastosPorObra", Array(FechaDesde, FechaHasta, _
            glbDtsExec & " /F " & mvarDirectorioDTS & "CuboGastos_" & glbEmpresaSegunString & "." & glbDtsExt)
         ' dsoDatabase.MDStores.Item("Gastos").Process processFull
         ' oPackage.LoadFromSQLServer gblHOST, "", "", DTSSQLStgFlag_UseTrustedConnection, , , , "CuboGastos_" & glbEmpresaSegunString
         mvarTablaOrigen = "_TempCuadroGastosParaCubo"
         mTitulo = "Provincias destino / Rubros gasto"
         mVT = "8"
         strSource = strSource & "SELECT "
         strSource = strSource & "[Rubro].members ON COLUMNS,"
         strSource = strSource & "NON EMPTY [ProvinciaDestino].members ON ROWS"
         strSource = strSource & " FROM Gastos"
      
      Case "EgresosProyectados"
         Aplicacion.Tarea "CtasCtesA_ProyeccionEgresosParaCubo", Array(FechaDesde, _
            glbDtsExec & " /F " & mvarDirectorioDTS & "CuboEgresos_" & glbEmpresaSegunString & "." & glbDtsExt)
         ' dsoDatabase.MDStores.Item("EgresosProyectados").Process processFull
         ' oPackage.LoadFromSQLServer gblHOST, "", "", DTSSQLStgFlag_UseTrustedConnection, , , , "CuboEgresos_" & glbEmpresaSegunString
         mvarTablaOrigen = "_TempCuboProyeccionEgresos"
         mTitulo = "Proveedor / Vencimientos"
         If Lapso = "Semana" Then
            mVT = "8"
         Else
            mVT = "4"
         End If
         strSource = strSource & "SELECT "
         strSource = strSource & "[Periodo].[" & Lapso & "].members ON COLUMNS,"
         strSource = strSource & "NON EMPTY [Proveedor].members ON ROWS"
         strSource = strSource & " FROM EgresosProyectados"
      
      Case "CashFlow"
         Aplicacion.Tarea "CashFlow", Array(FechaDesde, _
            glbDtsExec & " /F " & mvarDirectorioDTS & "CuboCashFlow_" & glbEmpresaSegunString & "." & glbDtsExt)
         ' dsoDatabase.MDStores.Item("CashFlow").Process processFull
         ' oPackage.LoadFromSQLServer gblHOST, "", "", DTSSQLStgFlag_UseTrustedConnection, , , , "CuboCashFlow_" & glbEmpresaSegunString
         mvarTablaOrigen = "_TempCuboCashFlow"
         mTitulo = "Concepto / Vencimientos"
         If Lapso = "Semana" Then
            mVT = "8"
         Else
            mVT = "4"
         End If
         strSource = strSource & "SELECT "
         strSource = strSource & "[Periodo].[" & Lapso & "].members ON COLUMNS,"
         strSource = strSource & "NON EMPTY [Tipo].members ON ROWS"
         strSource = strSource & " FROM CashFlow"
      
      Case "Ventas_ClientesFecha"
         Aplicacion.Tarea "CuboDeVentas", Array(FechaDesde, FechaHasta, mvarIdAux, _
            glbDtsExec & " /F " & mvarDirectorioDTS & "CuboVentas_" & glbEmpresaSegunString & "." & glbDtsExt)
         ' dsoDatabase.MDStores.Item("Ventas").Process processFull
         ' oPackage.LoadFromSQLServer gblHOST, "", "", DTSSQLStgFlag_UseTrustedConnection, , , , "CuboVentas_" & glbEmpresaSegunString
         mvarTablaOrigen = "_TempVentasParaCubo"
         mTitulo = "Clientes / Fechas"
         If Lapso = "Semana" Then
            mVT = "8"
         Else
            mVT = "4"
         End If
         strSource = strSource & "SELECT "
         strSource = strSource & "[Periodo].[" & Lapso & "].members ON COLUMNS,"
         strSource = strSource & "NON EMPTY [Cliente].members ON ROWS"
         strSource = strSource & " FROM Ventas"
      
      Case "Ventas_ObrasFecha"
         Aplicacion.Tarea "CuboDeVentas", Array(FechaDesde, FechaHasta, mvarIdAux, _
            glbDtsExec & " /F " & mvarDirectorioDTS & "CuboVentas_" & glbEmpresaSegunString & "." & glbDtsExt)
         ' dsoDatabase.MDStores.Item("Ventas").Process processFull
         ' oPackage.LoadFromSQLServer gblHOST, "", "", DTSSQLStgFlag_UseTrustedConnection, , , , "CuboVentas_" & glbEmpresaSegunString
         mvarTablaOrigen = "_TempVentasParaCubo"
         mTitulo = "Obras / Fechas"
         If Lapso = "Semana" Then
            mVT = "8"
         Else
            mVT = "4"
         End If
         strSource = strSource & "SELECT "
         strSource = strSource & "[Periodo].[" & Lapso & "].members ON COLUMNS,"
         strSource = strSource & "NON EMPTY [Obra].members ON ROWS"
         strSource = strSource & " FROM Ventas"
      
      Case "Ventas_ClienteUnidadOperativa"
         Aplicacion.Tarea "CuboDeVentas", Array(FechaDesde, FechaHasta, mvarIdAux, _
            glbDtsExec & " /F " & mvarDirectorioDTS & "CuboVentas_" & glbEmpresaSegunString & "." & glbDtsExt)
         ' dsoDatabase.MDStores.Item("Ventas").Process processFull
         ' oPackage.LoadFromSQLServer gblHOST, "", "", DTSSQLStgFlag_UseTrustedConnection, , , , "CuboVentas_" & glbEmpresaSegunString
         mvarTablaOrigen = "_TempVentasParaCubo"
         mTitulo = "Clientes / Unidades Operativas"
         mVT = "4"
         strSource = strSource & "SELECT "
         strSource = strSource & "[UnidadOperativa].members ON COLUMNS,"
         strSource = strSource & "NON EMPTY [Cliente].members ON ROWS"
         strSource = strSource & " FROM Ventas"
      
      Case "Ventas_ClienteCuenta"
         Aplicacion.Tarea "CuboDeVentas", Array(FechaDesde, FechaHasta, mvarIdAux, _
            glbDtsExec & " /F " & mvarDirectorioDTS & "CuboVentas_" & glbEmpresaSegunString & "." & glbDtsExt)
         ' dsoDatabase.MDStores.Item("Ventas").Process processFull
         ' oPackage.LoadFromSQLServer gblHOST, "", "", DTSSQLStgFlag_UseTrustedConnection, , , , "CuboVentas_" & glbEmpresaSegunString
         mvarTablaOrigen = "_TempVentasParaCubo"
         mVT = "8"
         mTitulo = "Clientes / Cuentas"
         strSource = strSource & "SELECT "
         strSource = strSource & "[Cuenta].members ON COLUMNS,"
         strSource = strSource & "NON EMPTY [Cliente].members ON ROWS"
         strSource = strSource & " FROM Ventas"
      
      Case "Ventas_ProvinciaCuenta"
         Aplicacion.Tarea "CuboDeVentas", Array(FechaDesde, FechaHasta, mvarIdAux, _
            glbDtsExec & " /F " & mvarDirectorioDTS & "CuboVentas_" & glbEmpresaSegunString & "." & glbDtsExt)
         ' dsoDatabase.MDStores.Item("Ventas").Process processFull
         ' oPackage.LoadFromSQLServer gblHOST, "", "", DTSSQLStgFlag_UseTrustedConnection, , , , "CuboVentas_" & glbEmpresaSegunString
         mvarTablaOrigen = "_TempVentasParaCubo"
         mVT = "8"
         mTitulo = "Provincias destino / Cuentas"
         strSource = strSource & "SELECT "
         strSource = strSource & "[Cuenta].members ON COLUMNS,"
         strSource = strSource & "NON EMPTY [ProvinciaDestino].members ON ROWS"
         strSource = strSource & " FROM Ventas"

   End Select
   
   'Con DSO
'   Set dsoDatabase = Nothing
'   Set dsoServer = Nothing
   
   'Con DTS Package
'   oPackage.Execute
'   Set oPackage = Nothing
   
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Cubos", "_ControlarContenidoDeDatos", mvarTablaOrigen)
   If oRs.RecordCount = 0 Then
      MsgBox "No hay informacion para procesar", vbExclamation
      oRs.Close
      Set TraerCubo = Nothing
      GoTo Salida
   End If
   oRs.Close
   
   'Reprocesar el cubo
'   Dim m_dsoServer   As DSO.Server
'   Dim m_dsoDatabase As DSO.MDStore
'   Dim m_dsoCube     As DSO.MDStore
'   Set m_dsoServer = New DSO.Server
'   m_dsoServer.Connect "LocalHost"
'   Set m_dsoDatabase = m_dsoServer.MDStores.Item("Lorilleux")
'   Set m_dsoCube = m_dsoDatabase.MDStores.Item(Cubo)
'   m_dsoCube.Process processFull
'   If Not m_dsoServer Is Nothing Then
'      m_dsoServer.CloseServer
'   End If
'   Set m_dsoServer = Nothing
'   Set m_dsoDatabase = Nothing
'   Set m_dsoCube = Nothing
'   cat.ActiveConnection = "Datasource=LocalHost; Provider=msolap; Initial Catalog=Lorilleux;"
'   cst.Source = strSource
'   Set cst.ActiveConnection = cat.ActiveConnection

   mServidor = "LocalHost"
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("SISTEMA", "_1")
   If oRs.RecordCount > 0 Then mServidor = oRs.Fields("Servidor").Value
   oRs.Close
   Set oRs = Nothing
   
   oCOn.ConnectionString = "Provider=MSOLAP.2; Persist Security Info=False; User ID=sa; Data source=" & mServidor & "; Initial Catalog=" & glbEmpresaSegunString & ";"
   oCOn.Open
   Set cst.ActiveConnection = oCOn
   cst.Source = strSource
   cst.Open
   
   Dim Datos As ADOR.Recordset
   Dim mName As String
   Set Datos = CreateObject("ADOR.Recordset")
   
   With Datos
      
      .Fields.Append "Id", adInteger
      .Fields.Append mTitulo, adVarChar, 70, adFldIsNullable
      mVector_X = "01"
      mVector_T = "02"
      For i = 0 To cst.Axes(0).Positions.Count - 1
         mName = cst.Axes(0).Positions(i).Members(0).Caption & " (" & i + 1 & ")"
         .Fields.Append mName, adNumeric, 9, adFldIsNullable
         .Fields(mName).Precision = 18
         .Fields(mName).NumericScale = 2
         mVector_X = mVector_X & "6"
         mVector_T = mVector_T & mVT
      Next
      If ConTotalesH Then
         mName = "Total"
         .Fields.Append mName, adNumeric, 9, adFldIsNullable
         .Fields(mName).Precision = 18
         .Fields(mName).NumericScale = 2
         mVector_X = mVector_X & "6"
         mVector_T = mVector_T & mVT
      End If
      .Fields.Append "Vector_T", adVarChar, 500
      .Fields.Append "Vector_X", adVarChar, 500
      mVector_X = mVector_X & "33"
      mVector_T = mVector_T & "00"
      .Open
      
      mTotalG = 0
      For j = 1 To cst.Axes(1).Positions.Count - 1
         .AddNew
         .Fields(0).Value = j
         .Fields(1).Value = cst.Axes(1).Positions(j).Members(0).Caption
         mTotal = 0
         For k = 0 To cst.Axes(0).Positions.Count - 1
'            .Fields(k + 2).Value = IIf(cst(k, j).FormattedValue = "", Null, cst(k, j).FormattedValue)
            .Fields(k + 2).Value = cst(k, j).Value
            If IsNumeric(cst(k, j).Value) And ConTotalesH Then
               mTotal = mTotal + cst(k, j).Value
            End If
         Next
         If ConTotalesH Then
            .Fields("Total").Value = mTotal
            mTotalG = mTotalG + mTotal
         End If
         .Fields(.Fields.Count - 2).Value = mVector_T
         .Fields(.Fields.Count - 1).Value = mVector_X
         .Update
      Next
      'Totales de la ultima fila
      If cst.Axes(1).Positions.Count > 0 Then
         .AddNew
         .Fields(0).Value = 0
         .Fields(1).Value = cst.Axes(1).Positions(0).Members(0).Caption
         For k = 0 To cst.Axes(0).Positions.Count - 1
            .Fields(k + 2).Value = cst(k, 0).Value
         Next
         If ConTotalesH Then
            .Fields("Total").Value = mTotalG
         End If
         .Fields(.Fields.Count - 2).Value = mVector_T
         .Fields(.Fields.Count - 1).Value = mVector_X
         .Update
      End If
      
      If .RecordCount > 0 Then .MoveFirst
   
   End With
   
   Set TraerCubo = Datos

Salida:

   On Error GoTo 0
   
   Set oRs = Nothing
   Set Datos = Nothing
   Set cst = Nothing
   Set cat = Nothing
   Set oCOn = Nothing

'   Set m_dsoServer = Nothing
'   Set m_dsoDatabase = Nothing
'   Set m_dsoCube = Nothing
'
'   Set dsoServer = Nothing
'   Set dsoDatabase = Nothing
'
'   Set oPackage = Nothing
   
   Exit Function

ProcesoMal:
   
   MsgBox "Ha ocurrido el siguiente error:" & vbCrLf & Err.Description, vbCritical, " Error!"
   Set TraerCubo = Nothing
   Resume Salida

End Function

Public Sub ActivarProveedores()

   With Lista
      .Height = .Height - 700
   End With
   With Option1
      .Caption = "Todos"
      .Value = True
   End With
   Option2.Caption = "Elegir un rango"
   With Frame1
      .Left = Cmd(0).Left
      .TOp = Cmd(0).TOp - 600
      .Caption = "Proveedores : "
      .Visible = True
   End With
   With DataCombo1(0)
      .Width = 3400
      .Left = Cmd(0).Left + Frame1.Width + 300
      .TOp = Cmd(0).TOp - 400
      Set .RowSource = Aplicacion.Proveedores.TraerFiltrado("_TodosParaCombo", Array("N", "T"))
      .Visible = True
   End With
   With DataCombo1(1)
      .Width = DataCombo1(0).Width
      .Left = DataCombo1(0).Left + DataCombo1(0).Width + 300
      .TOp = Cmd(0).TOp - 400
      Set .RowSource = Aplicacion.Proveedores.TraerFiltrado("_TodosParaCombo", Array("N", "T"))
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
   With lblLabels(3)
      .Width = 1500
      .Left = DataCombo1(0).Left
      .TOp = DataCombo1(0).TOp + DataCombo1(0).Height + 100
      .Caption = "Desde codigo :"
      .Visible = True
   End With
   With text1
      .Width = 1500
      .Left = lblLabels(3).Left + lblLabels(3).Width + 100
      .TOp = DataCombo1(0).TOp + DataCombo1(0).Height + 100
      .Visible = True
   End With
   With lblLabels(4)
      .Width = 1500
      .Left = DataCombo1(1).Left
      .TOp = DataCombo1(1).TOp + DataCombo1(1).Height + 100
      .Caption = "Hasta codigo :"
      .Visible = True
   End With
   With Text2
      .Width = 1500
      .Left = lblLabels(4).Left + lblLabels(4).Width + 100
      .TOp = DataCombo1(1).TOp + DataCombo1(1).Height + 100
      .Visible = True
   End With

End Sub

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
      .Left = Cmd(0).Left
      .TOp = Cmd(0).TOp - 600
      .Caption = "Clientes : "
      .Visible = True
   End With
   With DataCombo1(0)
      .Width = 3400
      .Left = Cmd(0).Left + Frame1.Width + 300
      .TOp = Cmd(0).TOp - 400
      Set .RowSource = Aplicacion.Clientes.TraerLista
      .Visible = True
   End With
   With DataCombo1(1)
      .Width = DataCombo1(0).Width
      .Left = DataCombo1(0).Left + DataCombo1(0).Width + 300
      .TOp = Cmd(0).TOp - 400
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

Private Sub txtBuscar_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      If KeyAscii = 13 Then
         Dim oRs As ADOR.Recordset
         If mvarId = 29 Then
            If Len(Trim(txtBuscar(Index).Text)) <> 0 Then
               Set oRs = Aplicacion.Articulos.TraerFiltrado("_BuscaConFormato", txtBuscar(Index).Text)
            Else
               Set oRs = Aplicacion.Articulos.TraerFiltrado("_TodosParaCostos")
            End If
            Lista.Sorted = False
            Set Lista.DataSource = oRs
            Lista.Refresh
            If Lista.ListItems.Count > 0 Then
               StatusBar1.Panels(2).Text = "" & Lista.ListItems.Count & " elementos en la lista"
            End If
            Set oRs = Nothing
            Exit Sub
         ElseIf mvarId = 22 Then
            If Len(Trim(txtBuscar(Index).Text)) <> 0 Then
               Set oRs = Aplicacion.Proveedores.TraerFiltrado("_Busca", txtBuscar(Index).Text)
            Else
               Set oRs = Aplicacion.Proveedores.TraerLista
            End If
            Set DataCombo1(Index).RowSource = oRs
            If oRs.RecordCount > 0 Then
               DataCombo1(Index).BoundText = oRs.Fields(0).Value
            End If
            Set oRs = Nothing
         ElseIf mvarId = 34 Then
            If Len(Trim(txtBuscar(Index).Text)) <> 0 Then
               Set oRs = Aplicacion.Clientes.TraerFiltrado("_Busca", txtBuscar(Index).Text)
            Else
               Set oRs = Aplicacion.Clientes.TraerLista
            End If
            Set DataCombo1(Index).RowSource = oRs
            If oRs.RecordCount > 0 Then
               DataCombo1(Index).BoundText = oRs.Fields(0).Value
            End If
            Set oRs = Nothing
         End If
      End If
      DataCombo1(Index).SetFocus
      SendKeys "%{DOWN}"
   End If
   
End Sub

Public Sub GenerarAsientoCierre()

   Dim oAp As ComPronto.Aplicacion
   Dim oAsi As ComPronto.Asiento
   Dim oRs As ADOR.Recordset
   Dim oPar As ComPronto.Parametro
   Dim mvarIdMonedaPesos As Integer, mvarNumeroAsiento As Integer
      
   Me.MousePointer = vbHourglass
   
   With lblInfo
      .TOp = Cmd(2).TOp
      .Left = Cmd(2).Left + (Cmd(2).Width * 1.5)
      .Width = Cmd(2).Width * 4.5
      .Height = Cmd(2).Height
      .Font.Size = 13
      .Caption = "Generando asiento de cierre, Un momento ..."
      .Visible = True
   End With
   DoEvents
   
   Set oAp = Aplicacion
   
   Set oRs = Aplicacion.Cuentas.TraerFiltrado("_AsientoCierreEjercicio", Array(DTFields(0).Value, DTFields(1).Value))
   
   If oRs.RecordCount > 0 Then
      Set oPar = oAp.Parametros.Item(1)
      With oPar.Registro
         mvarIdMonedaPesos = .Fields("IdMoneda").Value
         mvarNumeroAsiento = .Fields("ProximoAsiento").Value
         .Fields("ProximoAsiento").Value = .Fields("ProximoAsiento").Value + 1
      End With
      oPar.Guardar
      Set oPar = Nothing
   
      Set oAsi = oAp.Asientos.Item(-1)
      With oAsi
         With .Registro
            .Fields("NumeroAsiento").Value = mvarNumeroAsiento
            .Fields("FechaAsiento").Value = DTFields(1).Value
            .Fields("Concepto").Value = "REFUNDICIÓN DE PERDIDAS Y GANANCIAS"
            .Fields("Tipo").Value = "CIE01"
         End With
         oRs.MoveFirst
         Do While Not oRs.EOF
            With .DetAsientos.Item(-1)
               With .Registro
                  .Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
                  .Fields("IdMoneda").Value = mvarIdMonedaPesos
                  .Fields("CotizacionMoneda").Value = 1
                  .Fields("Debe").Value = oRs.Fields("Debe").Value
                  .Fields("Haber").Value = oRs.Fields("Haber").Value
               End With
               .Modificado = True
            End With
            oRs.MoveNext
         Loop
         .Guardar
      End With
   End If
   oRs.Close
      
   Set oRs = Aplicacion.Cuentas.TraerFiltrado("_AsientoCierreEjercicio1", Array(DTFields(0).Value, DTFields(1).Value))
   
   If oRs.RecordCount > 0 Then
      Set oPar = oAp.Parametros.Item(1)
      With oPar.Registro
         mvarNumeroAsiento = .Fields("ProximoAsiento").Value
         .Fields("ProximoAsiento").Value = .Fields("ProximoAsiento").Value + 1
      End With
      oPar.Guardar
      Set oPar = Nothing
   
      Set oAsi = oAp.Asientos.Item(-1)
      With oAsi
         With .Registro
            .Fields("NumeroAsiento").Value = mvarNumeroAsiento
            .Fields("FechaAsiento").Value = DTFields(1).Value
            .Fields("Concepto").Value = "CIERRE DE CUENTAS"
            .Fields("Tipo").Value = "CIE02"
         End With
         oRs.MoveFirst
         Do While Not oRs.EOF
            With .DetAsientos.Item(-1)
               With .Registro
                  .Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
                  .Fields("IdMoneda").Value = mvarIdMonedaPesos
                  .Fields("CotizacionMoneda").Value = 1
                  .Fields("Debe").Value = oRs.Fields("Debe").Value
                  .Fields("Haber").Value = oRs.Fields("Haber").Value
               End With
               .Modificado = True
            End With
            oRs.MoveNext
         Loop
         .Guardar
      End With
   End If
   oRs.Close
      
   Set oRs = Nothing
   Set oAsi = Nothing
   Set oAp = Nothing

   Me.MousePointer = vbDefault

   Unload Me
   
End Sub

Public Sub GenerarAsientoApertura()

   Dim oAp As ComPronto.Aplicacion
   Dim oAsi As ComPronto.Asiento
   Dim oRs As ADOR.Recordset
   Dim oPar As ComPronto.Parametro
   Dim mvarIdMonedaPesos As Integer, mvarNumeroAsiento As Integer
      
   Me.MousePointer = vbHourglass
   
   With lblInfo
      .TOp = Cmd(2).TOp
      .Left = Cmd(2).Left + (Cmd(2).Width * 1.5)
      .Width = Cmd(2).Width * 4.5
      .Height = Cmd(2).Height
      .Font.Size = 13
      .Caption = "Generando asiento de apertura, Un momento ..."
      .Visible = True
   End With
   DoEvents
   
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   If IsNull(oRs.Fields("IdCuentaResultadosAcumulados").Value) Then
      oRs.Close
      MsgBox "No esta definida en los parametros la cuenta de resultados acumulados", vbExclamation
      GoTo Salida
   End If
   oRs.Close
   
   Set oAp = Aplicacion
   
   Set oRs = Aplicacion.Cuentas.TraerFiltrado("_AsientoAperturaEjercicio", text1.Text)
   
   If oRs.RecordCount > 0 Then
      Set oPar = oAp.Parametros.Item(1)
      With oPar.Registro
         mvarIdMonedaPesos = .Fields("IdMoneda").Value
         mvarNumeroAsiento = .Fields("ProximoAsiento").Value
         .Fields("ProximoAsiento").Value = .Fields("ProximoAsiento").Value + 1
      End With
      oPar.Guardar
      Set oPar = Nothing
   
      Set oAsi = oAp.Asientos.Item(-1)
      With oAsi
         With .Registro
            .Fields("NumeroAsiento").Value = mvarNumeroAsiento
            .Fields("FechaAsiento").Value = DTFields(0).Value
            .Fields("Concepto").Value = "Asiento de apertura de ejercicio 1"
            .Fields("Tipo").Value = "APE01"
         End With
         oRs.MoveFirst
         Do While Not oRs.EOF
            With .DetAsientos.Item(-1)
               With .Registro
                  .Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
                  .Fields("IdMoneda").Value = mvarIdMonedaPesos
                  .Fields("CotizacionMoneda").Value = 1
                  .Fields("Debe").Value = oRs.Fields("Debe").Value
                  .Fields("Haber").Value = oRs.Fields("Haber").Value
                  If Not IsNull(oRs.Fields("IdMonedaCaja").Value) And _
                        oRs.Fields("IdMonedaCaja").Value > 1 Then
                     .Fields("IdMonedaDestino").Value = oRs.Fields("IdMonedaCaja").Value
                     .Fields("CotizacionMonedaDestino").Value = 0
                  End If
               End With
               .Modificado = True
            End With
            oRs.MoveNext
         Loop
         .Guardar
      End With
   End If
   oRs.Close
      
   Set oRs = Aplicacion.Cuentas.TraerFiltrado("_ResultadoCierreAnterior", text1.Text)
   
   If oRs.RecordCount > 0 Then
      oRs.MoveFirst
      
      Set oPar = oAp.Parametros.Item(1)
      With oPar.Registro
         mIdCuentaResultadosAcumulados = .Fields("IdCuentaResultadosAcumulados").Value
         mvarNumeroAsiento = .Fields("ProximoAsiento").Value
         .Fields("ProximoAsiento").Value = .Fields("ProximoAsiento").Value + 1
      End With
      oPar.Guardar
      Set oPar = Nothing
   
      Set oAsi = oAp.Asientos.Item(-1)
      With oAsi
         With .Registro
            .Fields("NumeroAsiento").Value = mvarNumeroAsiento
            .Fields("FechaAsiento").Value = DTFields(0).Value
            .Fields("Concepto").Value = "Asiento de apertura de ejercicio 2"
            .Fields("Tipo").Value = "APE02"
         End With
         With .DetAsientos.Item(-1)
            With .Registro
               .Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
               .Fields("IdMoneda").Value = mvarIdMonedaPesos
               .Fields("CotizacionMoneda").Value = 1
               .Fields("Debe").Value = oRs.Fields("Debe").Value
               .Fields("Haber").Value = oRs.Fields("Haber").Value
            End With
            .Modificado = True
         End With
         With .DetAsientos.Item(-1)
            With .Registro
               .Fields("IdCuenta").Value = mIdCuentaResultadosAcumulados
               .Fields("IdMoneda").Value = mvarIdMonedaPesos
               .Fields("CotizacionMoneda").Value = 1
               .Fields("Debe").Value = oRs.Fields("Haber").Value
               .Fields("Haber").Value = oRs.Fields("Debe").Value
            End With
            .Modificado = True
         End With
         .Guardar
      End With
   End If
   oRs.Close
      
Salida:

   Set oRs = Nothing
   Set oAsi = Nothing
   Set oAp = Nothing

   Me.MousePointer = vbDefault

   Unload Me
   
End Sub

Public Sub AbrirCuboIngresoEgresosPorObraEnExcel()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      .Workbooks.Add (glbPathPlantillas & "\IngresoEgresosPorObra_" & glbEmpresaSegunString & ".XLT")
      .Run "RefrescarEnlaceACubo", DTFields(0).Value, DTFields(1).Value
      .Run "DatosParaGraficos", glbStringConexion
   End With
   
   Set oEx = Nothing

End Sub

Public Function GenerarRsIvaCompras(ByVal mModelo As String) As ADOR.Recordset

   Dim oRs As ADOR.Recordset
   Dim oRsOri As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim i As Integer
   Dim mIdComprobante As Long
   Dim mTasa As Single, mImporteIva As Double
   Dim mVector_X As String, mVector_T As String, mVector_E As String, mCampo As String
   Dim mCampo1 As String, mCuentasAdic(5) As String, mCampo2 As String
   Dim mVector

   Me.MousePointer = vbHourglass
   DoEvents
   
   mCampo = BuscarClaveINI("Tomar impuestos internos con cuentas hijas para iva compras")
   If mCampo <> "SI" Then mCampo = "NO"
   mCampo1 = BuscarClaveINI("IdCuentas adicionales para impuestos internos")
   If Len(mCampo1) > 0 Then
      mVector = VBA.Split(mCampo1, ",")
      mCampo1 = ""
      For i = 0 To UBound(mVector)
         mCampo1 = mCampo1 & "(" & CLng(mVector(i)) & ")"
      Next
   End If
   
   mCampo2 = BuscarClaveINI("Modelo para libro de iva compras")
   If (Len(mCampo2) = 0 Or mCampo2 = "_Modelo5" Or mCampo2 = "_Modelo6") And Len(mModelo) = 0 Then
      Set oRsOri = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", _
                     "_IVACompras" & mCampo2, Array(DTFields(0).Value, DTFields(1).Value, mCampo, mCampo1))
   '   If oRsOri.RecordCount > 0 Then
   '      mVector_X = mId(oRsOri.Fields("Vector_X").Value, 1, 16)
   '      mVector_T = mId(oRsOri.Fields("Vector_T").Value, 1, 16)
   '      mVector_E = oRsOri.Fields("Vector_E").Value
   '   Else
         mVector_X = "0000011111111666616"
         mVector_T = "00000144935003"
         mVector_E = " ANC:35,FON:8 | ANC:10,FON:8,CEN | ANC:13,FON:8,CEN | ANC:17,FON:8,CEN |" & _
                     "ANC:16,FON:8,NUM:################### |ANC:16,FON:8 | ANC:15,FON:8,CEN | ANC:12,FON:8,NUM:#COMMA##0.00 "
   '   End If
      
      Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
      
      If Not IsNull(oRs.Fields("IvaCompras_DesglosarNOGRAVADOS").Value) And _
            oRs.Fields("IvaCompras_DesglosarNOGRAVADOS").Value = "SI" Then
         mVector_T = mVector_T & "33312"
         mVector_E = mVector_E & "| ANC:10,FON:8,NUM:#COMMA##0.00 " & _
               "| ANC:10,FON:8,NUM:#COMMA##0.00 | ANC:10,FON:8,NUM:#COMMA##0.00 " & _
               "| ANC:10,FON:8,NUM:#COMMA##0.00 | ANC:10,FON:8,NUM:#COMMA##0.00 "
         mvarDesglosarNOGRAVADOS = True
      Else
         mVector_T = mVector_T & "99312"
         mVector_E = mVector_E & "| ANC:12,FON:8,NUM:#COMMA##0.00 " & _
               "| ANC:8,FON:8,NUM:#COMMA##0.00 | ANC:10,FON:8,NUM:#COMMA##0.00 "
         mvarDesglosarNOGRAVADOS = False
      End If
      For i = 1 To 5
         If Not IsNull(oRs.Fields("IdCuentaAdicionalIVACompras" & i).Value) Then
            mVector_X = mVector_X & "6"
            mVector_T = mVector_T & "3"
            mVector_E = mVector_E & "| ANC:10,FON:8,NUM:#COMMA##0.00 "
            Set oRsAux = Aplicacion.Cuentas.TraerFiltrado("_PorId", oRs.Fields("IdCuentaAdicionalIVACompras" & i).Value)
            mCuentasAdic(i) = ""
            If oRsAux.RecordCount > 0 Then
               mCuentasAdic(i) = oRsAux.Fields("Descripcion").Value & " " & oRsAux.Fields("Codigo").Value
            End If
            oRsAux.Close
         Else
            mVector_X = mVector_X & "1"
            mVector_T = mVector_T & "9"
            mCuentasAdic(i) = ""
         End If
      Next
      mVector_X = mVector_X & "66133"
      mVector_T = mVector_T & "39900"
      mVector_E = mVector_E & "| ANC:10,FON:8,NUM:#COMMA##0.00 "
      oRs.Close
      Set oRs = Nothing
      Set oRsAux = Nothing
      
      With oRsOri
         Set oRs = CreateObject("ADOR.Recordset")
         For i = 0 To .Fields.Count - 1
            With .Fields(i)
               mCampo = .Name
               If mId(.Name, 1, 3) = "Col" Then
                  If Len(mCuentasAdic(mId(.Name, 4, 1))) > 0 Then
                     mCampo = mCuentasAdic(mId(.Name, 4, 1))
                  End If
               End If
               oRs.Fields.Append mCampo, .type, .DefinedSize, .Attributes
               oRs.Fields(mCampo).Precision = .Precision
               oRs.Fields(mCampo).NumericScale = .NumericScale
            End With
         Next
         oRs.Open
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               oRs.AddNew
               For i = 0 To .Fields.Count - 1
                  With .Fields(i)
                     If mId(.Name, 1, 3) = "Col" Then
                        If Len(mCuentasAdic(mId(.Name, 4, 1))) > 0 Then
                           oRs.Fields(mCuentasAdic(mId(.Name, 4, 1))).Value = .Value
                        Else
                           oRs.Fields(i).Value = .Value
                        End If
                     Else
                        oRs.Fields(i).Value = .Value
                     End If
                  End With
               Next
               oRs.Update
               .MoveNext
            Loop
         End If
         .Close
      End With
      Set oRsOri = Nothing
      
      With oRs
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               .Fields("Vector_T").Value = mVector_T
               .Fields("Vector_X").Value = mVector_X
               .Fields("Vector_E").Value = mVector_E
               If Not IsNull(.Fields("Orden").Value) And .Fields("Orden").Value = 3 Then
                  .Fields("Vector_E").Value = "FinTransporte,BDT," & .Fields("Vector_E").Value
               End If
               .Update
               mIdComprobante = .Fields(0).Value
               If mIdComprobante <> 0 And Not IsNull(.Fields("Fecha").Value) Then
                  .MoveNext
                  If Not .EOF Then
                     If .Fields(0).Value = mIdComprobante Then
                        mTasa = IIf(IsNull(.Fields("Tasa").Value), 0, .Fields("Tasa").Value)
                        mImporteIva = IIf(IsNull(.Fields("Iva").Value), 0, .Fields("Iva").Value)
                        .Delete
                        .MovePrevious
                        .Fields("Tasa").Value = mTasa
                        .Fields("Iva").Value = mImporteIva
                        .Update
                     Else
                        .MovePrevious
                     End If
                  Else
                     .MovePrevious
                  End If
               End If
               .MoveNext
            Loop
            .MoveFirst
         End If
      End With
   ElseIf Len(mCampo2) > 0 And Len(mModelo) = 0 Then
      Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", _
                     "_IVACompras" & mCampo2, _
                     Array(DTFields(0).Value, DTFields(1).Value, mCampo, mCampo1))
   Else
      Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", _
                     "_IVACompras" & mModelo, _
                     Array(DTFields(0).Value, DTFields(1).Value, mCampo, mCampo1))
   End If
   
   mCampo = BuscarClaveINI("IVACOMPRAS_FilasPorHoja")
   If Len(mCampo) = 0 Or Not IsNumeric(mCampo) Then mCampo = CStr(mvarLineasIvaCompras)
   mvarParametrosExcel = "SaltoDePaginaCada:" & mCampo
   mCampo = BuscarClaveINI("IVACOMPRAS_ColumnaConTransporte")
   If Len(mCampo) = 0 Or Not IsNumeric(mCampo) Then mCampo = "5"
   mvarParametrosExcel = mvarParametrosExcel & "|ColumnaTransporte:" & mCampo
   If mvarDesglosarNOGRAVADOS Then
      mCampo = BuscarClaveINI("IVACOMPRAS_ColumnasSumaParaTransporteConApertura")
   Else
      mCampo = BuscarClaveINI("IVACOMPRAS_ColumnasSumaParaTransporteSinApertura")
   End If
   If Len(mCampo) = 0 Or Not IsNumeric(mCampo) Then mCampo = "8,9,11,12"
   mVector = VBA.Split(mCampo, ",")
   For i = 0 To UBound(mVector)
      mvarParametrosExcel = mvarParametrosExcel & "|SumadorPorHoja" & i + 1 & ":" & mVector(i)
   Next
   mvarParametrosExcel = mvarParametrosExcel & "|Enc:SinFecha"
   
   Set GenerarRsIvaCompras = oRs
   Set oRs = Nothing

   Me.MousePointer = vbDefault
   DoEvents
   
End Function

Public Function GenerarInformeOP(ByVal FechaDesde As Date, _
                                 ByVal FechaHasta As Date) As ADOR.Recordset

   Dim oRs As ADOR.Recordset
   Dim oRsFinal As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim oRs2 As ADOR.Recordset
   Dim oRs3 As ADOR.Recordset
   Dim mIdOP As Long, mNumeroOP As Long
   Dim mNumeroItem As Integer
   Dim mFechaOP As Date

   Me.MousePointer = vbHourglass
   DoEvents
   
   Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_ParaListadoDetallado", Array(DTFields(0).Value, DTFields(1).Value))
   'Set oRsFinal = CopiarTodosLosRegistros(oRs)
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            mIdOP = oRs.Fields(0).Value
            mNumeroOP = oRs.Fields("Numero").Value
            FechaOP = oRs.Fields("Fecha Pago").Value
            oRsFinal.AbsolutePosition = .AbsolutePosition
            Set oRs1 = Aplicacion.TablasGenerales.TraerFiltrado("DetOrdenesPago", "OrdenPago", mIdOP)
            Set oRs2 = Aplicacion.TablasGenerales.TraerFiltrado("DetOrdenesPagoValores", "OrdenPago", mIdOP)
            Set oRs3 = Aplicacion.TablasGenerales.TraerFiltrado("DetOrdenesPagoCuentas", "OrdenPago", mIdOP)
            
            mNumeroItem = 1
            Do While Not (oRs1.EOF And oRs2.EOF And oRs3.EOF)
               If mNumeroItem > 1 Then
                  With oRsFinal
                     .AddNew
                     .Fields(0).Value = mIdOP
                     .Fields("Numero").Value = mNumeroOP
                     .Fields("FechaOP").Value = FechaOP
                     .Fields("NumeroOP").Value = mNumeroOP
                     .Fields("K_Orden").Value = mNumeroItem
                     .Update
                  End With
               End If
                  
               If Not oRs1.EOF Then
                  With oRsFinal
                     .Fields("Imputacion cta. cte.").Value = "" & _
                        IIf(IsNull(oRs1.Fields("Comp.").Value), "", oRs1.Fields("Comp.").Value) & " " & _
                        IIf(IsNull(oRs1.Fields("Numero").Value), "", oRs1.Fields("Numero").Value) & " " & _
                        IIf(IsNull(oRs1.Fields("Fecha").Value), "", oRs1.Fields("Fecha").Value)
                     .Fields("Importe").Value = oRs1.Fields("Importe").Value
                     .Fields("Imp.s/impuestos").Value = oRs1.Fields("s/impuesto").Value
                     oRs1.MoveNext
                  End With
               End If

               If Not oRs2.EOF Then
                  With oRsFinal
                     .Fields("Tipo").Value = oRs2.Fields("Tipo").Value
                     .Fields("Banco / Caja").Value = oRs2.Fields("Banco / Caja").Value
                     .Fields("Nro.interno").Value = oRs2.Fields("Nro.Int.").Value
                     .Fields("Nro.valor").Value = oRs2.Fields("Numero").Value
                     .Fields("Fecha vto.").Value = oRs2.Fields("Fec.Vto.").Value
                     .Fields("Importe valor").Value = oRs2.Fields("Importe").Value
                     oRs2.MoveNext
                  End With
               End If
               
               If Not oRs3.EOF Then
                  With oRsFinal
                     .Fields("Cuenta").Value = oRs3.Fields("Cuenta").Value
                     .Fields("Cod.").Value = oRs3.Fields("CodigoCuenta").Value
                     .Fields("Debe").Value = oRs3.Fields("Debe").Value
                     .Fields("Haber").Value = oRs3.Fields("Haber").Value
                     oRs3.MoveNext
                  End With
               End If
               
               mNumeroItem = mNumeroItem + 1
            Loop
            
            oRs1.Close
            oRs2.Close
            oRs3.Close
            
            .MoveNext
         Loop
         oRsFinal.Sort = "FechaOP,NumeroOP,K_Orden"
         oRsFinal.MoveFirst
      End If
   End With
   
   oRs.Close
   
   Set GenerarInformeOP = oRsFinal
   Set oRs = Nothing
   Set oRsFinal = Nothing
   Set oRs1 = Nothing
   Set oRs2 = Nothing
   Set oRs3 = Nothing

   Me.MousePointer = vbDefault
   DoEvents
   
End Function

Public Sub AbrirCuboEgresosProyectados()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      .Workbooks.Add (glbPathPlantillas & "\EgresosProyectados_" & glbEmpresaSegunString & ".XLT")
      .Run "RefrescarEnlaceACubo", DTFields(0).Value
   End With
   
   Set oEx = Nothing

End Sub

Public Sub AbrirCuboPresupuestoFinanciero()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      If Check1.Value = 1 Then
         .Workbooks.Add (glbPathPlantillas & "\PresupuestoFinanciero3_" & glbEmpresaSegunString & ".XLT")
         .Run "RefrescarEnlaceACubo"
      Else
         If Option1.Value Then
            .Workbooks.Add (glbPathPlantillas & "\PresupuestoFinanciero_" & glbEmpresaSegunString & ".XLT")
            .Run "RefrescarEnlaceACubo"
         Else
            .Workbooks.Add (glbPathPlantillas & "\PresupuestoFinanciero2_" & glbEmpresaSegunString & ".XLT")
            .Run "RefrescarEnlaceACubo", DataCombo1(1).BoundText
         End If
      End If
   End With
   
   Set oEx = Nothing

End Sub

Public Sub SaldosProveedoresEntreFechas(ByRef oTab As ADOR.Recordset)

   Dim mK_IdProveedor As Integer, mSaldo As Double
   
   mK_IdProveedor = -1
   With oTab
      If .RecordCount > 0 Then
         .Sort = "K_RazonSocial,K_Codigo,K_Orden,Fecha"
         .MoveFirst
         Do While Not .EOF
            If .Fields("K_IdProveedor").Value <> 0 Then
               If .Fields("K_IdProveedor").Value <> mK_IdProveedor Then
                  mK_IdProveedor = .Fields("K_IdProveedor").Value
                  mSaldo = 0
               End If
               If .Fields("K_Orden").Value <= 1 Then
                  mSaldo = mSaldo + IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value)
                  mSaldo = mSaldo - IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value)
                  .Fields("Sdo").Value = mSaldo
                  .Update
               End If
            End If
            .MoveNext
         Loop
         .MoveFirst
      End If
   End With

End Sub

Public Sub AbrirCuboGastos()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      .Workbooks.Add (glbPathPlantillas & "\Gastos_" & glbEmpresaSegunString & ".XLT")
      .Run "RefrescarEnlaceACubo", DTFields(0).Value, DTFields(1).Value
   End With
   
   Set oEx = Nothing

End Sub

Public Sub AbrirCuboVentas()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      .Workbooks.Add (glbPathPlantillas & "\Ventas_" & glbEmpresaSegunString & ".XLT")
      .Run "RefrescarEnlaceACubo", DTFields(0).Value, DTFields(1).Value
   End With
   
   Set oEx = Nothing

End Sub

Private Sub EditarComprobante(ByVal TipoComprobante As Long, ByVal Identificador As Long)

   Dim oF As Form
      
   Select Case TipoComprobante
      Case 1
'         'Set oF = New frmFacturas
'      Case 2
'         'Set oF = New frmRecibos
'      Case 3
'         'Set oF = New frmNotasDebito
'      Case 4
'         Set oF = New frmNotasCredito
'      Case 5
'         Set oF = New frmDevoluciones
'      Case 10, 11, 13, 18, 19, 31, 34
'         Set oF = New frmComprobantesPrv
'      Case 14
'         Set oF = New frmDepositosBancarios
'      Case 17
'         Set oF = New frmOrdenesPago
'      Case 28, 29
'         Set oF = New frmValoresGastos
'      Case 38
'         Set oF = New frmAsientos
'      Case 39
'         Set oF = New FrmPlazosFijos
'      Case 1001
'         Set oF = New frmAcopios
'      Case 1002
'         Set oF = New frmLMateriales
'      Case 1003
'         Set oF = New frmRequerimientos
'      Case 1004
'         Set oF = New frmPedidos
'      Case 1005
'         Set oF = New frmComparativa
'      Case 1006
'         Set oF = New frmAjustesStock
      
      Case Else
         MsgBox "Comprobante no editable"
         GoTo Salida:
   End Select
   
   With oF
      .Id = Identificador
      .Disparar = ActL
      .Show vbModal, Me
   End With

Salida:

   Set oF = Nothing

End Sub

Public Sub AbrirCuboPresupuestoFinancieroTeorico()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      .Workbooks.Add (glbPathPlantillas & "\PresupuestoFinancieroTeorico_" & glbEmpresaSegunString & ".XLT")
      If Check1.Value = 1 Then
         .Run "RefrescarEnlaceACubo", DTFields(0).Value, DTFields(1).Value
      Else
         .Run "RefrescarEnlaceACubo", DTFields(0).Value, Date
      End If
   End With
   
   Set oEx = Nothing

End Sub

Public Sub AbrirCuboSaldosComprobantesPorObraProveedor()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      .Workbooks.Add (glbPathPlantillas & "\SaldosComprobantesPorObraProveedor_" & glbEmpresaSegunString & ".XLT")
      .Run "RefrescarEnlaceACubo", DTFields(0).Value
   End With
   
   Set oEx = Nothing

End Sub

Public Sub AbrirCuboIVAPorObra()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      .Workbooks.Add (glbPathPlantillas & "\IVAPorObra_" & glbEmpresaSegunString & ".XLT")
      .Run "RefrescarEnlaceACubo", DTFields(0).Value, DTFields(1).Value
   End With
   
   Set oEx = Nothing

End Sub

Public Sub AbrirCuboCostosImportacion()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      .Workbooks.Add (glbPathPlantillas & "\CostosImportacion_" & glbEmpresaSegunString & ".XLT")
      .Run "RefrescarEnlaceACubo"
   End With
   
   Set oEx = Nothing

End Sub

Public Sub AsignarCostosImportacionAItemPedido()

   Dim Filas, Columnas
   Dim iFilas As Integer
   
   Filas = VBA.Split(Lista.GetString, vbCrLf)
   For iFilas = LBound(Filas) + 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(iFilas), vbTab)
      If IsNumeric(Columnas(2)) Then
         Aplicacion.Tarea "Pedidos_AsignarCostoImportacion", Array(Columnas(2), Columnas(12), Columnas(16), glbIdUsuario)
         Aplicacion.Articulos.GenerarCostoPromedioPorIdArticulo Columnas(17)
      End If
   Next

End Sub

Public Sub AbrirCuboVentasEnCuotas()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      .Workbooks.Add (glbPathPlantillas & "\VentasEnCuotas_" & glbEmpresaSegunString & ".XLT")
      .Run "RefrescarEnlaceACubo", DTFields(0).Value, DTFields(1).Value
   End With
   
   Set oEx = Nothing

End Sub

Public Sub AbrirCuboReservaPresupuestaria()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      .Workbooks.Add (glbPathPlantillas & "\ReservaPresupuestaria_" & glbEmpresaSegunString & ".XLT")
      .Run "RefrescarEnlaceACubo", DTFields(0).Value, DTFields(1).Value
   End With
   
   Set oEx = Nothing

End Sub

Public Sub AbrirCuboStock()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      .Workbooks.Add (glbPathPlantillas & "\Stock_" & glbEmpresaSegunString & ".XLT")
      .Run "RefrescarEnlaceACubo", DTFields(0).Value, DTFields(1).Value
   End With
   
   Set oEx = Nothing

End Sub

Public Sub AbrirCuboComparativas()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      .Workbooks.Add (glbPathPlantillas & "\Comparativas_" & glbEmpresaSegunString & ".XLT")
      .Run "RefrescarEnlaceACubo", DTFields(0).Value, DTFields(1).Value
   End With
   
   Set oEx = Nothing

End Sub

Public Sub RegistrarBienesDeUso()

   If Lista.SelectedItem Is Nothing Then Exit Sub
   
   Dim oF As frm_Aux
   Dim oRs As ADOR.Recordset
   Dim mParametros As String
   Dim mCodigoInicial As Long
   
   mCodigoInicial = 1
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   If oRs.RecordCount > 0 Then
      mCodigoInicial = IIf(IsNull(oRs.Fields("ProximoCodigoArticulo").Value), 1, oRs.Fields("ProximoCodigoArticulo").Value)
   End If
   oRs.Close
   Set oRs = Nothing
   
   mParametros = "" & Lista.SelectedItem.SubItems(2) & "|" & _
                  Lista.SelectedItem.SubItems(11) & "|" & _
                  Lista.SelectedItem.SubItems(13) & "|" & _
                  "RE:" & Lista.SelectedItem.Text & "|" & _
                  Lista.SelectedItem.SubItems(5) & "|" & _
                  "PE:" & Lista.SelectedItem.SubItems(6)
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Generar bienes de uso recepcionados"
      With .Label1
         .TOp = 100
         .Caption = "1er. nro. inv. :"
      End With
      With .text1
         .TOp = 100
         .Alignment = 1
         .Text = mCodigoInicial
         .Enabled = False
      End With
      .Width = .Width * 2.5
      .Height = .Height * 2
      With .Lista
         .Left = oF.Label1.Left
         .TOp = 500
         .Width = 8500
         .Height = 3500
         .Visible = True
      End With
      With .Cmd(0)
         .TOp = 4100
         .Left = oF.Lista.Left
         .Caption = "Generar"
      End With
      .Cmd(1).TOp = 4100
      .Id = 1
      .Parametros = mParametros
      .Show vbModal, Me
   End With
   Unload oF
   Set oF = Nothing

End Sub

Public Sub AbrirCuboPedidos()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      .Workbooks.Add (glbPathPlantillas & "\Pedidos_" & glbEmpresaSegunString & ".XLT")
      .Run "RefrescarEnlaceACubo", DTFields(0).Value, DTFields(1).Value
   End With
   
   Set oEx = Nothing

End Sub

Public Sub AbrirCuboPosicionFinanciera()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      .Workbooks.Add (glbPathPlantillas & "\PosicionFinanciera_" & glbEmpresaSegunString & ".XLT")
      .Run "RefrescarEnlaceACubo", DTFields(0).Value
   End With
   
   Set oEx = Nothing

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

Public Sub GenerarRemitoRechazo()

   Dim Filas, Columnas, mAux1
   Dim iFilas As Integer, i As Integer
   Dim mNumeroRemito As Long, mIdProveedorRechazo As Long
   Dim s As String
   Dim mOk As Boolean
   Dim mFecha As Date
   
   s = ""
   Filas = VBA.Split(Lista.GetString, vbCrLf)
   For iFilas = LBound(Filas) + 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(iFilas), vbTab)
      If Len(Columnas(12)) <> 0 Then
         MsgBox "Hay registros que ya tienen generado un remito de rechazo", vbExclamation
         Exit Sub
      End If
      If Len(Columnas(9)) = 0 Then
         MsgBox "Hay registros que no tienen cantidad rechazada", vbExclamation
         Exit Sub
      End If
      s = s & Columnas(2) & "|"
   Next
   If Len(s) = 0 Then
      MsgBox "No hay documentos para generar", vbExclamation
      Exit Sub
   Else
      s = mId(s, 1, Len(s) - 1)
   End If
   
   Dim oF As frm_Aux
   Set oF = New frm_Aux
   With oF
      .Caption = "Generar remito de rechazo"
      .Width = .Width * 2
      .text1.Visible = False
      With .Label1
         .Caption = "Proveedor:"
         .Visible = True
      End With
      With .dcfields(0)
         .Left = oF.text1.Left
         .TOp = oF.text1.TOp
         .Width = oF.DTFields(0).Width * 3
         .BoundColumn = "IdProveedor"
         Set .RowSource = Aplicacion.Proveedores.TraerLista
         .Visible = True
      End With
      With .Label2(1)
         .Caption = "Fecha remito:"
         .Visible = True
      End With
      With .DTFields(1)
         .Value = Date
         .Visible = True
      End With
      .Show vbModal, Me
      mOk = .Ok
      mFecha = .DTFields(1).Value
      If IsNumeric(.dcfields(0).BoundText) Then
         mIdProveedorRechazo = .dcfields(0).BoundText
      Else
         mIdProveedorRechazo = 0
      End If
   End With
   Unload oF
   Set oF = Nothing
   
   If mIdProveedorRechazo = 0 Then
      MsgBox "No eligio un proveedor", vbExclamation
      Exit Sub
   End If
   
   If Not mOk Then Exit Sub
   
   mAux1 = TraerValorParametro2("ProximoNumeroRemitoRechazo")
   If Not IsNull(mAux1) Then
      mNumeroRemito = Val(mAux1)
   Else
      mNumeroRemito = 1
   End If
   
   Filas = VBA.Split(s, "|")
   For iFilas = LBound(Filas) To UBound(Filas)
      Aplicacion.Tarea "DetControlesCalidad_GrabarRemitoRechazo", _
                        Array(Filas(0), mNumeroRemito, mFecha, mIdProveedorRechazo)
   Next
   
   mNumeroRemito = mNumeroRemito + 1
   GuardarValorParametro2 "ProximoNumeroRemitoRechazo", "" & mNumeroRemito
   
   Dim oW As Word.Application
   Set oW = CreateObject("Word.Application")
   oW.Visible = True
   oW.Documents.Add (glbPathPlantillas & "\RemitoRechazo_" & glbEmpresaSegunString & ".dot")
   oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=s
   oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
   Set oW = Nothing

End Sub

Public Function ListaVacia() As Boolean

   ListaVacia = False
   If Lista.ListItems.Count = 0 Then
      MsgBox "No hay informacion para la generacion!", vbExclamation
      ListaVacia = True
   End If

End Function

Public Function DeudaVencida() As ADOR.Recordset

   Dim mActivaRango As Integer, mSeñal As Integer
   Dim mDesdeAlfa As String, mHastaAlfa As String, mCampo As String, mCampo1 As String
   
   mActivaRango = -1
   If Option2.Value Then
      mActivaRango = 0
      mDesdeAlfa = text1.Text
      mHastaAlfa = Text2.Text
   End If
   mSeñal = -1
   If Check1.Value = 0 Then mSeñal = 0
   mSeñal1 = -1
   If Check2.Value = 0 Then mSeñal1 = 0
   mCampo = "SI"
   If Check3.Value = 0 Then mCampo = "NO"
   mCampo1 = "NO"
   If Check5.Value = 0 Then mCampo1 = "SI"
   
   GenerarCondicionesDeCompra
   
   If Check4.Value = 0 Then
      Set DeudaVencida = Aplicacion.CtasCtesA.TraerFiltrado("_DeudaVencida", _
                           Array(DTFields(0).Value, mActivaRango, mDesdeAlfa, mHastaAlfa, mSeñal, mSeñal1, mCampo, mCampo1))
   Else
      Set DeudaVencida = Aplicacion.CtasCtesA.TraerFiltrado("_DeudaVencidaPorMesCalendario", _
                           Array(DTFields(0).Value, mActivaRango, mDesdeAlfa, mHastaAlfa, mSeñal, mSeñal1, mCampo, mCampo1))
   End If

End Function

Public Sub ReemplazarColumnHeaderDeudaVencida()

   Dim oCH As ColumnHeader
   Dim mFecha As Date
   
   For Each oCH In Lista.ColumnHeaders
      If mId(oCH.Text, 1, 1) = "-" Or mId(oCH.Text, 1, 1) = "+" Or oCH.Text = "0" Then
         If oCH.Text = "-99" Then
            oCH.Text = "Ant."
         ElseIf oCH.Text = "+99" Then
            oCH.Text = "Post."
         Else
            mFecha = DateAdd("m", Val(oCH.Text), DTFields(0).Value)
            oCH.Text = "" & NombreMesCorto(Month(mFecha)) & "/" & Year(mFecha)
         End If
      End If
   Next

End Sub

Private Sub DarPorCumplido()

   
End Sub

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

Public Function DepositosPorUsuario() As String

   Dim mAux As String, s As String
   Dim i As Integer, j As Integer
   Dim mVector1, mVector2
   
   mAux = BuscarClaveINI("Depositos por usuario para requerimientos pendientes de asignacion")

   s = ""
   If Len(mAux) > 0 Then
      If InStr(1, mAux, "|") > 0 Then
         mVector1 = VBA.Split(mAux, "|")
         For i = 0 To UBound(mVector1)
            mVector2 = VBA.Split(mVector1(i), ",")
            If "(" & glbIdUsuario & ")" = mVector2(0) Then
               s = mVector2(1)
               Exit For
            End If
         Next
      Else
         mVector2 = VBA.Split(mAux, ",")
         If "(" & glbIdUsuario & ")" = mVector2(0) Then s = mVector2(1)
      End If
   End If
   
   DepositosPorUsuario = s

End Function
