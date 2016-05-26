VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.4#0"; "Controles1013.ocx"
Object = "{126E538A-EE41-4B22-A045-F8D5538F5D2B}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmConsulta2 
   ClientHeight    =   6315
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11670
   Icon            =   "frmConsulta2.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   6315
   ScaleWidth      =   11670
   StartUpPosition =   3  'Windows Default
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   4770
      Top             =   5400
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
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
      Width           =   7800
      Begin VB.OptionButton Option11 
         Height          =   195
         Left            =   6135
         TabIndex        =   29
         Top             =   180
         Width           =   1500
      End
      Begin VB.OptionButton Option10 
         Height          =   195
         Left            =   4635
         TabIndex        =   28
         Top             =   180
         Width           =   1500
      End
      Begin VB.OptionButton Option5 
         Height          =   195
         Left            =   3135
         TabIndex        =   27
         Top             =   180
         Width           =   1500
      End
      Begin VB.OptionButton Option4 
         Height          =   195
         Left            =   1635
         TabIndex        =   26
         Top             =   180
         Width           =   1500
      End
      Begin VB.OptionButton Option3 
         Height          =   195
         Left            =   135
         TabIndex        =   25
         Top             =   180
         Width           =   1500
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
      Top             =   5925
      Width           =   11670
      _ExtentX        =   20585
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   5
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   8255
            Key             =   "Mensaje"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   8255
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
            TextSave        =   "15/07/2011"
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
      Format          =   57081857
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
      Format          =   57081857
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   2835
      TabIndex        =   59
      Top             =   7740
      Visible         =   0   'False
      Width           =   3705
      _ExtentX        =   6535
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
   Begin VB.Menu MnuDetRub 
      Caption         =   "Rubros financieros"
      Visible         =   0   'False
      Begin VB.Menu MnuDetRubA 
         Caption         =   "Asignar rubro financiero"
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
Private mvarId As Long, mIdComparativa As Long, mIdPresupuestoSeleccionado As Long, mvarIdProveedor As Long
Private mvarIdPedido As Long
Private mvarLineasIvaCompras As Integer
Private mvarSubTituloExcel As String, mvarPathArchivosExportados As String, mvarDirectorioDTS As String
Private mvarParametrosExcel As String
Private mvarDesglosarNOGRAVADOS As Boolean

Public Property Let Id(ByVal vnewvalue As Integer)

   Dim mvarFechaDesde As Date, mvarFechaHasta As Date
   Dim mAux As String
   Dim mVector
   Dim oRs As ADOR.Recordset
   
   mvarId = vnewvalue
   
   mvarFechaDesde = DateSerial(Year(Date), Month(Date) - 1, 1)
   mvarFechaHasta = DateAdd("m", 1, mvarFechaDesde)
   mvarFechaHasta = DateAdd("d", -1, mvarFechaHasta)
   
   mvarParametrosExcel = ""
   mvarDesglosarNOGRAVADOS = False
   
   Select Case mvarId
      Case 1
         Me.Caption = "Control del circuito de firmas"
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
         With Frame5
            .Top = Toolbar1.Height + 100
            .Left = DTFields(1).Left + DTFields(1).Width + 100
            .Visible = True
         End With
         With Option12
            .Caption = "Pendientes"
            .Value = True
         End With
         Option13.Caption = "Firmados"
         Option14.Caption = "Todos"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
      
      Case 2
         Me.Caption = "Control de lotes transmitidos a obras/terceros"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
      
      Case 3
         Me.Caption = "Eleccion de presupuesto para pedido desde comparativa"
         cmd(0).Caption = "Seleccionar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
      
      Case 14
         Me.Caption = "CITI - Compras"
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
      
      Case 16
         Me.Caption = "Subdiario de IVA Ventas"
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
      
      Case 17
         Me.Caption = "Subdiario de IVA Compras"
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
      
      Case 18
         Me.Caption = "Gastos por obra (Cubo)"
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
         With Frame2
            .Left = cmd(2).Left + cmd(2).Width + 50
            .Top = cmd(2).Top
            .Visible = True
         End With
         With Option3
            .Caption = "Obra/Rubro"
            .Value = True
         End With
         Option4.Caption = "U.Ope./Rubro"
         Option5.Caption = "Prov.Dest/Rubro"
         Option10.Visible = False
         Option11.Visible = False
      
      Case 19
         Me.Caption = "Proyeccion de egresos (Cubo)"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         lblLabels(1).Visible = False
         Frame1.Visible = False
         With Frame3
            .Top = cmd(0).Top - 100
            .Left = cmd(0).Left + (cmd(0).Width * 4)
            .Visible = True
         End With
         Option7.Value = True
         With DTFields(0)
            .Visible = True
            .Value = Date
         End With
         DTFields(1).Visible = False
      
      Case 20
         Me.Caption = "Ranking de compras por proveedor"
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
      
      Case 21
         Me.Caption = "Comprobantes ingresados"
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
            .Caption = "Modelo 1"
            .Value = True
         End With
         Option13.Caption = "Modelo 2"
         Option14.Caption = "Modelo 3"
      
      Case 22
         Me.Caption = "Saldos de proveedores"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         With lblLabels(0)
            .Visible = True
            .Caption = "Saldos al :"
         End With
         lblLabels(1).Visible = False
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaHasta
         End With
         With DTFields(1)
            .Visible = False
            .Value = mvarFechaHasta
         End With
         ActivarProveedores
      
      Case 23
         Me.Caption = "Proveedores - Retenciones de impuesto a las ganancias"
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
      
      Case 24
         Me.Caption = "Comprobantes pendientes de imputacion"
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
      
      Case 25
         Me.Caption = "Detalle de saldos por tipo de proveedor"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
      
      Case 26
         Me.Caption = "Deuda vencida a fecha"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         With lblLabels(0)
            .Visible = True
            .Caption = "Deuda al :"
         End With
         With DTFields(0)
            .Visible = True
            .Value = Date
         End With
         DTFields(1).Visible = False
         With Frame1
            .Left = lblLabels(1).Left
            .Top = DTFields(1).Top - 50
            .Caption = "Proveedores :"
            .Visible = True
         End With
         With Option1
            .Caption = "Todos"
            .Value = True
         End With
         Option2.Caption = "Por codigo"
         With lblLabels(1)
            .Caption = "Desde/Hasta :"
            .Left = Frame1.Left + Frame1.Width + 100
            .Visible = False
         End With
         With Text1
            .Top = DTFields(0).Top
            .Left = lblLabels(1).Left + lblLabels(1).Width + 100
            .Width = DTFields(0).Width
            .Alignment = 0
            .Visible = False
         End With
         With Text2
            .Top = Text1.Top
            .Left = Text1.Left + Text1.Width + 100
            .Width = Text1.Width
            .Alignment = 0
            .Visible = False
         End With
         With cmdBuscarPorCuit
            .Left = Text2.Left + Text2.Width + 100
            .Top = Text2.Top
         End With
         'cmd(0).Height = cmd(0).Height / 1.5
         With cmd(2)
            .Height = cmd(0).Height
            .Top = cmd(0).Top + cmd(0).Height + 10
            .Left = cmd(0).Left
         End With
         With Check1
            .Left = cmd(0).Left + cmd(0).Width + 70
            .Top = cmd(0).Top
            .Height = .Height * 2
            .Width = cmd(1).Width
            .Caption = "Descartar saldos en cero"
            .Visible = True
         End With
         With Check2
            .Left = Check1.Left + Check1.Width + 70
            .Top = Check1.Top
            .Height = Check1.Height
            .Width = cmd(0).Width
            .Caption = "Incluir creditos no aplicados"
            .Visible = True
         End With
         With Check3
            .Left = Check2.Left + Check2.Width + 70
            .Top = Check1.Top
            .Height = Check1.Height
            .Width = cmd(0).Width * 1.1
            .Caption = "Incluir comprob. no vencidos"
            .Visible = True
         End With
         With Check4
            .Left = Check3.Left + Check3.Width + 70
            .Top = Check1.Top
            .Height = Check1.Height
            .Width = cmd(0).Width
            .Caption = "Tomar mes calendario"
            .Visible = True
         End With
         With Check5
            .Left = Check4.Left + Check4.Width + 70
            .Top = Check1.Top
            .Height = Check1.Height
            .Width = cmd(0).Width * 2
            .Caption = "Calcular fechas de vencimiento desde las condiciones de compra"
            .Visible = True
            .Value = 1
         End With
         With Frame6
            .Left = Check5.Left + Check5.Width + 70
            .Top = Check1.Top - 80
            .Width = DTFields(0).Width * 1.2
            .Visible = True
         End With
         With Option17
            .Caption = "x Fecha Vto."
            .Width = .Width * 1.3
            .Value = True
         End With
         With Option18
            .Caption = "x Fecha Comp."
            .Width = .Width * 1.3
         End With
         With lblInfo
            .AutoSize = False
            .FontSize = 8
            .Top = Check1.Top + Check1.Height + 100
            .Left = Check1.Left
            .Width = Me.Width / 1.2
            .Height = Me.Text1.Height
            .Caption = "Nota : el sistema calculara el estado de cuenta a la fecha " & _
                        "indicada y proyectara la deuda existente en esa fecha."
            .Visible = True
         End With
         Me.Height = Me.Height * 1.07
      
      Case 27
         Me.Caption = "Cash Flow (Cubo)"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         With Frame3
            .Visible = True
            .Left = cmd(0).Left + (cmd(0).Width * 4)
            .Top = cmd(0).Top
         End With
         Option7.Value = True
         DTFields(0).Visible = False
         DTFields(1).Visible = False
      
      Case 28
         Me.Caption = "Ventas (Cubo)"
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
         With Frame3
            .Visible = True
            .Left = DTFields(0).Left + (DTFields(0).Width * 4)
            .Top = Toolbar1.Top + Toolbar1.Height + 50
         End With
         Option7.Value = True
         With Frame2
            .Left = cmd(2).Left + cmd(2).Width + 50
            .Top = cmd(2).Top
            .Visible = True
         End With
         With Option3
            .Caption = "Cliente/Fecha"
            .Value = True
         End With
         Option4.Caption = "Obra/Fecha"
         Option5.Caption = "Cliente/U.Ope."
         Option10.Caption = "Cliente/Cuenta"
         Option11.Caption = "Prov.Dest/Cuenta"
      
      Case 29
         Me.Caption = "Costos promedios ponderados"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Left = cmd(0).Left
         With lblLabels(0)
            .AutoSize = True
            .Caption = "Buscar materiales :"
            .Visible = True
         End With
         With txtBuscar(0)
            .Left = lblLabels(0).Left + lblLabels(0).Width + 100
            .Width = Me.Width / 2
            .Top = lblLabels(0).Top
            .Visible = True
            .TabIndex = 0
         End With
         With Label1(1)
            .Top = cmd(0).Top
            .Left = cmd(0).Left + (cmd(0).Width * 2)
            .Width = cmd(0).Width * 4
            .Height = cmd(0).Height
            .Caption = "Presione ENTER para ver todos los materiales o " & _
                        "escriba una frase clave que contenga los materiales " & _
                        "buscados"
            .Visible = True
         End With
      
      Case 30
         Me.Caption = "Estado anticipos al personal"
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
         With Frame1
            .Visible = True
            .Left = DTFields(0).Left + (DTFields(0).Width * 4)
            .Top = DTFields(0).Top - 70
         End With
         With Option1
            .Caption = "Detallado"
            .Value = True
         End With
         Option2.Caption = "Resumido"
         With Frame4
            .Visible = True
            .Left = Me.Width / 1.7
            .Top = cmd(0).Top
         End With
         With Option15
            .Caption = "Por legajo"
            .Value = True
         End With
         Option16.Caption = "Alfabetico"
         With lblLabels(2)
            .Left = cmd(1).Left + cmd(1).Width + 300
            .Top = cmd(1).Top - 70
            .Height = Text1.Height
            .Width = cmd(1).Width
            .Caption = "Desde legajo :"
            .Visible = True
         End With
         With Text1
            .Left = lblLabels(2).Left + lblLabels(2).Width + 50
            .Top = lblLabels(2).Top
            .Width = cmd(1).Width / 2
            .Text = 0
            .Visible = True
         End With
         With lblLabels(3)
            .Left = lblLabels(2).Left
            .Top = lblLabels(2).Top + lblLabels(2).Height + 30
            .Height = Text1.Height
            .Width = lblLabels(2).Width
            .Caption = "Hasta legajo :"
            .Visible = True
         End With
         With Text2
            .Left = lblLabels(3).Left + lblLabels(3).Width + 50
            .Top = lblLabels(3).Top
            .Width = Text1.Width
            .Text = 999999
            .Visible = True
         End With
            
      
      Case 31
         Me.Caption = "Retencion ganancias proveedores - SICORE"
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
      
      Case 33
         Me.Caption = "Listado de comprobantes ingresados"
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
         With Frame4
            .Visible = True
            .Left = Me.Width / 1.7
            .Top = cmd(0).Top
         End With
         With Option15
            .Caption = "Modelo 1"
            .Value = True
         End With
         Option16.Caption = "Modelo 2"
      
      Case 34
         Me.Caption = "Saldos de clientes"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         With lblLabels(0)
            .Visible = True
            .Caption = "Saldos al :"
         End With
         lblLabels(1).Visible = False
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaHasta
         End With
         With DTFields(1)
            .Visible = False
            .Value = mvarFechaHasta
         End With
         ActivarClientes
         With Check1
            .Top = cmd(0).Top
            .Left = DataCombo1(0).Left
            .Width = cmd(0).Width
            .Caption = "Por vendedor :"
            .Value = 0
            .Visible = True
         End With
         With DataCombo1(2)
            .Left = Check1.Left + Check1.Width + 100
            .Top = Check1.Top
            .Width = cmd(0).Width * 1.45
            .BoundColumn = "IdVendedor"
            Set .RowSource = Aplicacion.Vendedores.TraerLista
            .Enabled = False
            .Visible = True
         End With
         With Check2
            .Top = cmd(0).Top
            .Left = DataCombo1(1).Left
            .Width = cmd(0).Width
            .Caption = "Por cobrador :"
            .Value = 0
            .Visible = True
         End With
         With DataCombo1(3)
            .Left = Check2.Left + Check2.Width + 100
            .Top = Check2.Top
            .Width = cmd(0).Width * 1.45
            .BoundColumn = "IdVendedor"
            Set .RowSource = Aplicacion.Vendedores.TraerLista
            .Enabled = False
            .Visible = True
         End With
         With Line1
            .x1 = Check1.Left
            .X2 = DataCombo1(3).Left + DataCombo1(3).Width
            .Y1 = cmd(0).Top - 50
            .Y2 = cmd(0).Top - 50
            .Visible = True
         End With
      
      Case 35
         Me.Caption = "Valores a depositar"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Left = cmd(0).Left
      
      Case 36
         Me.Caption = "OP's de fondo fijo pendientes de control (dif. cambio)"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Left = cmd(0).Left
      
      Case 37
         Me.Caption = "Clientes - Retenciones de impuesto a las ganancias"
         cmd(0).Caption = "Procesar"
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
         With Check1
            .Left = cmd(2).Left + cmd(2).Width + 70
            .Top = cmd(2).Top
            .Width = cmd(2).Width * 2
            .Caption = "Generar para personas juridicas"
            .Visible = True
         End With
         With Frame1
            .Left = Check1.Left + Check1.Width + 100
            .Top = cmd(0).Top - 50
            .Caption = "Ordenamiento :"
            .Visible = True
         End With
         With Option1
            .Caption = "x Cliente"
            .Value = True
         End With
         Option2.Caption = "x Fecha"
      
      Case 38
         Me.Caption = "Proveedores - Retenciones de IVA"
         cmd(0).Caption = "Procesar"
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
      
      Case 39
         Me.Caption = "Clientes - Retenciones de IVA"
         cmd(0).Caption = "Procesar"
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
         
      Case 40
         Me.Caption = "Proveedores - Percepciones de IVA"
         cmd(0).Caption = "Procesar"
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
         
      Case 41
         Me.Caption = "Proveedores - SUSS"
         cmd(0).Caption = "Procesar"
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
   
      Case 42
         Me.Caption = "Lista de Precios segun Notas de Pedido"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Value = DateSerial(Year(DateAdd("m", -3, Date)), Month(DateAdd("m", -3, Date)), 1)
            .Visible = True
         End With
         With DTFields(1)
            .Value = Date
            .Visible = True
         End With
         With Frame5
            .Caption = "Tipos de busqueda : "
            .Visible = True
         End With
         Option12.Caption = "Rubro + Texto"
         Option13.Caption = "Por articulo"
         Option14.Caption = "Por descripcion"
         Lista.Height = Lista.Height * 0.85
         With rchObservaciones
            .Left = Lista.Left
            .Top = Lista.Top + Lista.Height + 10
            .Width = Lista.Width * 0.65
            .Height = Lista.Height * 0.2
            .Visible = True
         End With
         With Frame1
            .Caption = "Obra : "
            .Top = rchObservaciones.Top + 10
            .Left = rchObservaciones.Left + rchObservaciones.Width + 50
            .Visible = True
         End With
         With Option1
            .Caption = "Todas"
            .Value = True
         End With
         Option2.Caption = "Elegir una"
         With lblLabels(4)
            .Top = Frame1.Top + Frame1.Height + 50
            .Left = Frame1.Left
            .AutoSize = True
            .Caption = "Obra : "
         End With
         With DataCombo1(1)
            .Top = Frame1.Top + Frame1.Height + 5
            .Left = lblLabels(4).Left + lblLabels(4).Width + 5
            .Width = Frame3.Width * 0.75
            .BoundColumn = "IdObra"
            Set .RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo")
         End With

      Case 43
         Me.Caption = "Resolucion 1361"
         cmd(0).Caption = "Procesar"
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
         With Frame1
            .Left = DTFields(1).Left + DTFields(1).Width + 100
            .Top = DTFields(1).Top
            .Visible = True
         End With
         With Option1
            .Caption = "RECE"
            .Value = True
         End With
         Option2.Caption = "SIRED"
         With Frame2
            .Left = cmd(2).Left + cmd(2).Width + 50
            .Top = cmd(2).Top
            .Visible = True
         End With
         With Option3
            .Caption = "Cabecera FA"
            .Value = True
         End With
         Option4.Caption = "Detalle FA"
         Option5.Caption = "Ventas"
         Option10.Caption = "Compras"
         Option11.Caption = "Otras percep."
      
      Case 44
         Me.Caption = "Proveedores - Retenciones IIBB"
         cmd(0).Caption = "Procesar"
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
   
      Case 45
         Me.Caption = "Clientes - Retenciones SUSS"
         cmd(0).Caption = "Procesar"
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
         
      Case 46
         Me.Caption = "Resolucion 1547"
         cmd(0).Caption = "Procesar"
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
         
      Case 47
         Me.Caption = "Clientes - Percepciones IIBB"
         cmd(0).Caption = "Procesar"
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
         
      Case 48
         Me.Caption = "Cierre de ejercicio"
         cmd(0).Caption = "Procesar"
         With cmd(1)
            .Caption = "Generar asiento de cierre"
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
         
      Case 49
         Me.Caption = "Apertura de ejercicio"
         cmd(0).Caption = "Procesar"
         With cmd(1)
            .Caption = "Generar asiento de apertura"
            .Enabled = False
         End With
         With lblLabels(0)
            .Caption = "Fecha apertura :"
            .Visible = True
         End With
         With lblLabels(1)
            .Caption = "Asiento cierre :"
            .Visible = True
         End With
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With Text1
            .Left = DTFields(1).Left
            .Top = DTFields(1).Top
            .Width = DTFields(1).Width
            .Visible = True
         End With
         
      Case 50
         Me.Caption = "Clientes - Retenciones IIBB (Cobranzas)"
         cmd(0).Caption = "Procesar"
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
         
      Case 51
         Me.Caption = "Cuadro de Ingresos - Egresos por Obra"
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
         Lista.Visible = False
         With Frame1
            .Caption = "Obra : "
            .Top = Lista.Top
            .Left = lblLabels(0).Left
            .Visible = True
         End With
         With Option1
            .Caption = "Todas"
            .Value = True
         End With
         Option2.Caption = "Elegir una"
         With lblLabels(4)
            .Top = Frame1.Top + 50
            .Left = Frame1.Left + Frame1.Width + 50
            .AutoSize = True
            .Caption = "Obra : "
         End With
         With DataCombo1(1)
            .Top = lblLabels(4).Top
            .Left = lblLabels(4).Left + lblLabels(4).Width + 5
            .Width = cmd(0).Width * 2
            .BoundColumn = "IdObra"
            Set .RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo")
         End With
         With cmd(0)
            .Top = Frame1.Top + Frame1.Height + 100
            .Caption = "Procesar"
         End With
         With cmd(2)
            .Top = cmd(0).Top
            .Left = cmd(1).Left
         End With
         Me.Height = Me.Height / 2.3
         Toolbar1.Enabled = False
         
      Case 52
         Me.Caption = "Desarrollo de items de ordenes de compra (Por facturacion)"
         cmd(0).Caption = "Procesar"
         cmd(2).Left = cmd(1).Left
         ActivarClientes
         Frame4.Visible = False
         With Check1
            .Top = cmd(0).Top
            .Width = cmd(0).Width * 2
            .Left = Lista.Left + Lista.Width - .Width
            .Caption = "Solo lo pendiente :"
            .Visible = True
         End With
         
      Case 53
         Me.Caption = "Listado de ordenes de pago"
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
   
      Case 54
         Me.Caption = "Detalle imputaciones por rubro p/presupuesto financiero"
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
         Lista.Height = Lista.Height * 0.85
         With rchObservaciones
            .Left = Lista.Left
            .Top = Lista.Top + Lista.Height + 10
            .Width = Lista.Width
            .Height = Lista.Height * 0.2
            .Visible = True
         End With
         With lblLabels(4)
            .Left = Me.Width * 0.75
            .Top = lblLabels(0).Top
            .Width = Me.Width * 0.23
            .Caption = "Con doble click edita el comprobante"
            .Visible = True
         End With

      Case 55
         Me.Caption = "Saldos de bancos a fecha"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         With lblLabels(0)
            .Caption = "Fecha : "
            .Visible = True
         End With
         With DTFields(0)
            .Visible = True
            .Value = Date
         End With
   
      Case 56
         Me.Caption = "Listado de proveedores - rubros provistos"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
   
      Case 57
         Me.Caption = "Costos de materiales por equipo"
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
            .Caption = "Equipo : "
            .Top = cmd(0).Top - 50
            .Left = cmd(2).Left + cmd(2).Width + 50
            .Visible = True
         End With
         With Option1
            .Caption = "Todos"
            .Value = True
         End With
         Option2.Caption = "Elegir uno"
         With lblLabels(4)
            .Top = Frame1.Top
            .Left = Frame1.Left + Frame1.Width + 50
            .AutoSize = True
            .Caption = "Equipo : "
         End With
         With DataCombo1(1)
            .Top = lblLabels(4).Top + lblLabels(4).Height + 5
            .Left = lblLabels(4).Left
            .Width = DTFields(0).Width * 2.5
            .BoundColumn = "IdArticulo"
            Set .RowSource = Aplicacion.Articulos.TraerLista
         End With
         With Text1
            .Top = lblLabels(4).Top - 80
            .Left = lblLabels(4).Left * 1.15
            .Width = DTFields(1).Width
            '.Visible = True
         End With
         With Frame4
            .Caption = "Transportistas : "
            .Top = DTFields(1).Top - 50
            .Left = DTFields(1).Left + DTFields(1).Width + 50
            .Visible = True
         End With
         With Option15
            .Caption = "Todos"
            .Value = True
         End With
         Option16.Caption = "Elegir uno"
         With lblLabels(5)
            .Top = Frame4.Top
            .Left = Frame4.Left + Frame4.Width + 50
            .AutoSize = True
            .Caption = "Transportista : "
         End With
         With DataCombo1(2)
            .Top = lblLabels(5).Top + lblLabels(5).Height + 5
            .Left = lblLabels(5).Left
            .Width = DTFields(0).Width * 1.5
            .BoundColumn = "IdTransportista"
            Set .RowSource = Aplicacion.Transportistas.TraerLista
         End With
         With Frame7
            .Caption = "Orden : "
            .Top = cmd(0).Top - 100
            .Left = Lista.Left + Lista.Width - .Width
            .Visible = True
         End With
         With Option19
            .Caption = "Equipo"
            .Value = True
         End With
         Option20.Caption = "Transp."
   
      Case 58
         Me.Caption = "Estado de polizas de obras"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         With Frame1
            .Top = Toolbar1.Top + Toolbar1.Height + 50
            .Left = lblLabels(0).Left
            .Visible = True
         End With
         With Option1
            .Caption = "Todas"
            .Value = True
         End With
         Option2.Caption = "Vencidas a fecha"
         With lblLabels(0)
            .Left = DTFields(1).Left
            .Caption = "Fecha limite :"
         End With
         With DTFields(0)
            .Left = lblLabels(0).Left + lblLabels(0).Width + 100
            .Value = Date
         End With
   
      Case 59
         Me.Caption = "Egresos proyectados detallados"
         With lblLabels(0)
            .Caption = "Fecha emision :"
            .Visible = True
         End With
         lblLabels(1).Visible = False
         With DTFields(0)
            .Visible = True
            .Value = Date
         End With
         DTFields(1).Visible = False
         Lista.Visible = False
         Me.Height = Me.Height / 3
         With cmd(0)
            .Top = Lista.Top
            .Caption = "Procesar"
         End With
         With cmd(2)
            .Top = Lista.Top
            .Left = cmd(1).Left
         End With
         Toolbar1.Enabled = False
         
      Case 60
         Me.Caption = "Presupuesto financiero"
         lblLabels(0).Visible = False
         DTFields(0).Visible = False
         lblLabels(1).Visible = False
         DTFields(1).Visible = False
         Lista.Visible = False
         With Frame1
            .Caption = "Ejercicios : "
            .Top = lblLabels(0).Top - 100
            .Left = lblLabels(0).Left
            .Visible = True
         End With
         With Option1
            .Caption = "Todos"
            .Value = True
         End With
         Option2.Caption = "Elegir uno"
         With lblLabels(4)
            .Top = Frame1.Top
            .Left = Frame1.Left + Frame1.Width + 50
            .AutoSize = True
            .Caption = "Ejercicio : "
         End With
         With DataCombo1(1)
            .Top = lblLabels(4).Top + lblLabels(4).Height + 5
            .Left = lblLabels(4).Left
            .Width = DTFields(0).Width * 3
            .BoundColumn = "IdEjercicioContable"
            Set .RowSource = Aplicacion.EjerciciosContables.TraerLista
         End With
         With Check1
            .Top = Frame1.Top + Frame1.Height + 100
            .Left = Frame1.Left
            .Width = cmd(2).Width * 2
            .Caption = "Procesar solo proximo trimestre"
            .Visible = True
         End With
         With cmd(0)
            .Top = Check1.Top + Check1.Height + 100
            .Caption = "Procesar"
         End With
         With cmd(2)
            .Top = cmd(0).Top
            .Left = cmd(1).Left
         End With
         Me.Height = Me.Height / 2.4
         Toolbar1.Enabled = False
   
      Case 61
         Me.Caption = "Saldos de proveedores entre fechas"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         With lblLabels(0)
            .Top = Toolbar1.Height + 10
            .Visible = True
            .Caption = "Desde el :"
         End With
         With DTFields(0)
            .Top = lblLabels(0).Top
            .Left = lblLabels(0).Left + lblLabels(0).Width + 10
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With lblLabels(1)
            .Top = lblLabels(0).Top + lblLabels(0).Height + 50
            .Left = lblLabels(0).Left
            .Width = lblLabels(0).Width
            .Visible = True
            .Caption = "Hasta el :"
         End With
         With DTFields(1)
            .Top = lblLabels(1).Top
            .Left = lblLabels(1).Left + lblLabels(1).Width + 10
            .Visible = True
            .Value = mvarFechaHasta
         End With
         ActivarProveedores
         With Option15
            .Caption = "Detallado"
            .Value = True
         End With
         Option16.Caption = "Resumido"
         With Frame4
            .Top = Toolbar1.Height + 20
            .Left = DTFields(1).Left + DTFields(1).Width + 200
            .Visible = True
         End With
         With Frame6
            .Top = Frame4.Top
            .Left = Frame4.Left + Frame4.Width + 200
'            .Visible = True
         End With
         With Option17
            .Caption = "Todas"
            .Value = True
         End With
         Option18.Caption = "x Obra"
      
      Case 62
         Me.Caption = "Cuadro de gastos (Detallados)"
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
         Lista.Visible = False
         With Frame1
            .Caption = "Obra : "
            .Top = Lista.Top
            .Left = lblLabels(0).Left
            .Visible = True
         End With
         With Option1
            .Caption = "Todas"
            .Value = True
         End With
         Option2.Caption = "Elegir una"
         With lblLabels(4)
            .Top = Frame1.Top + 50
            .Left = Frame1.Left + Frame1.Width + 50
            .AutoSize = True
            .Caption = "Obra : "
         End With
         With DataCombo1(1)
            .Top = lblLabels(4).Top
            .Left = lblLabels(4).Left + lblLabels(4).Width + 5
            .Width = cmd(0).Width * 2
            .BoundColumn = "IdObra"
            Set .RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo")
         End With
         With cmd(0)
            .Top = Frame1.Top + Frame1.Height + 100
            .Caption = "Procesar"
         End With
         With cmd(2)
            .Top = cmd(0).Top
            .Left = cmd(1).Left
         End With
         Me.Height = Me.Height / 2.3
         With Check1
            .Width = DTFields(1).Width * 3
            .Left = Lista.Left + Lista.Width - .Width
            .Top = lblLabels(0).Top
            .Caption = "Tomar asientos de cierre de ejercicio :"
            .Value = 1
            .Visible = True
         End With
         Toolbar1.Enabled = False
         
      Case 63
         Me.Caption = "Cuadro de ventas (Detalladas)"
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
         Lista.Visible = False
         Me.Height = Me.Height / 2.8
         With cmd(0)
            .Top = Lista.Top
            .Caption = "Procesar"
         End With
         With cmd(2)
            .Top = Lista.Top
            .Left = cmd(1).Left
         End With
         Toolbar1.Enabled = False
         
      Case 64
         Me.Caption = "Stock de articulos a fecha"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaHasta
         End With
     
      Case 65
         Me.Caption = "Analisis de comprobantes para presupuesto financiero"
         With lblLabels(0)
            .Caption = "Tomar solo comprobante con vencimiento mayor al:"
            .Width = .Width * 3.2
            .Visible = True
         End With
         lblLabels(1).Visible = False
         With DTFields(0)
            .Left = lblLabels(0).Left + lblLabels(0).Width + 100
            .Value = Date
            .Visible = True
         End With
         DTFields(1).Visible = False
         With Check1
            .Top = lblLabels(0).Top + lblLabels(0).Height + 100
            .Left = lblLabels(0).Left
            .Width = DTFields(1).Width * 2.2
            .Caption = "Calcular segun saldo pendiente :"
            .Visible = True
         End With
         Lista.Visible = False
         With cmd(0)
            .Top = Check1.Top + Check1.Height + 100
            .Caption = "Procesar"
         End With
         With cmd(2)
            .Top = cmd(0).Top
            .Left = cmd(1).Left
         End With
         Me.Height = Me.Height / 2.5
         Toolbar1.Enabled = False
         
      Case 66
         Me.Caption = "Creditos vencidos a fecha"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         With lblLabels(0)
            .Visible = True
            .Caption = "Movimientos :"
         End With
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With lblLabels(1)
            .Width = cmd(0).Width / 4
            .Visible = True
            .Caption = " al :"
         End With
         With DTFields(1)
            .Left = lblLabels(1).Left + lblLabels(1).Width + 100
            .Visible = True
            .Value = mvarFechaHasta
         End With
         ActivarClientes
         With Frame4
            .Caption = "Alcance del informe (fechas)"
            .Left = DTFields(1).Left + DTFields(1).Width + 100
         End With
         Option15.Caption = "Todos los mov."
         With Option16
            .Caption = "Por periodo"
            .Value = True
         End With
         With Check1
            .Top = cmd(0).Top
            .Left = DataCombo1(0).Left
            .Width = cmd(0).Width
            .Caption = "Por vendedor :"
            .Value = 0
            .Visible = True
         End With
         With DataCombo1(2)
            .Left = Check1.Left + Check1.Width + 100
            .Top = Check1.Top
            .Width = cmd(0).Width * 1.45
            .BoundColumn = "IdVendedor"
            Set .RowSource = Aplicacion.Vendedores.TraerLista
            .Enabled = False
            .Visible = True
         End With
         With Check2
            .Top = cmd(0).Top
            .Left = DataCombo1(1).Left
            .Width = cmd(0).Width
            .Caption = "Por cobrador :"
            .Value = 0
            .Visible = True
         End With
         With DataCombo1(3)
            .Left = Check2.Left + Check2.Width + 100
            .Top = Check2.Top
            .Width = cmd(0).Width * 1.45
            .BoundColumn = "IdVendedor"
            Set .RowSource = Aplicacion.Vendedores.TraerLista
            .Enabled = False
            .Visible = True
         End With
         With Line1
            .x1 = Check1.Left
            .X2 = DataCombo1(3).Left + DataCombo1(3).Width
            .Y1 = cmd(0).Top - 50
            .Y2 = cmd(0).Top - 50
            .Visible = True
         End With
         With Check3
            .Top = Toolbar1.Height + 30
            .Width = DTFields(0).Width * 2
            .Left = Frame4.Left + Frame4.Width + 200
            .Caption = "Solo vtas.cuotas"
            .Visible = True
         End With
         With Check4
            .Top = Check3.Top + Check3.Height + 30
            .Width = Check3.Width
            .Left = Check3.Left
            .Caption = "Incluir creditos no aplicados"
            .Visible = True
         End With
         With Check5
            .Top = Check4.Top + Check4.Height + 30
            .Width = Check3.Width
            .Left = Check3.Left
            .Caption = "Descartar saldos en cero"
            .Visible = True
         End With
         With Lista
            .Top = .Top * 1.25
            .Height = .Height * 0.9
         End With
      
      Case 67
         Me.Caption = "Saldos de comprobantes por proveedor - obra"
         With lblLabels(0)
            .Caption = "Fecha limite :"
            .Visible = True
         End With
         With DTFields(0)
            .Value = Date
            .Visible = True
         End With
         lblLabels(1).Visible = False
         DTFields(1).Visible = False
         Lista.Visible = False
         With cmd(0)
            .Top = Lista.Top
            .Caption = "Procesar"
         End With
         With cmd(2)
            .Top = cmd(0).Top
            .Left = cmd(1).Left
         End With
         Me.Height = Me.Height / 2.8
         Toolbar1.Enabled = False
   
      Case 68
         Me.Caption = "IVA ventas - compras por obra"
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
         Lista.Visible = False
         Me.Height = Me.Height / 3
         With cmd(0)
            .Top = Lista.Top
            .Caption = "Procesar"
         End With
         cmd(1).Visible = False
         With cmd(2)
            .Top = Lista.Top
            .Left = cmd(1).Left
         End With
         Toolbar1.Enabled = False
   
      Case 69
         Me.Caption = "Costos de importacion"
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
         Lista.Visible = False
         Me.Height = Me.Height / 3
         With cmd(0)
            .Top = Lista.Top
            .Caption = "Procesar"
         End With
         cmd(1).Visible = False
         With cmd(2)
            .Top = Lista.Top
            .Left = cmd(1).Left
         End With
         Toolbar1.Enabled = False
   
      Case 70
         Me.Caption = "Asignacion de costos de importacion a pedidos"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
      
      Case 71
         Me.Caption = "Ventas en cuotas"
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
         Lista.Visible = False
         Me.Height = Me.Height / 3
         With cmd(0)
            .Top = Lista.Top
            .Caption = "Procesar"
         End With
         cmd(1).Visible = False
         With cmd(2)
            .Top = Lista.Top
            .Left = cmd(1).Left
         End With
         Toolbar1.Enabled = False
   
      Case 72
         Me.Caption = "Reserva presupuestaria"
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
         Lista.Visible = False
         Me.Height = Me.Height / 3
         With cmd(0)
            .Top = Lista.Top
            .Caption = "Procesar"
         End With
         cmd(1).Visible = False
         With cmd(2)
            .Top = Lista.Top
            .Left = cmd(1).Left
         End With
         Toolbar1.Enabled = False
   
      Case 73
         Me.Caption = "Cuadro de ingresos y egresos"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         With cmd(2)
            .Top = cmd(1).Top
            .Left = cmd(1).Left
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
      
      Case 74
         Me.Caption = "Prefacturacion (desde ordenes de compra automaticas)"
         lblLabels(1).Visible = False
         DTFields(1).Visible = False
         cmd(1).Visible = False
         cmd(0).Caption = "Procesar"
         With lblLabels(0)
            .Caption = "Prefacturacion al :"
            .Visible = True
         End With
         With DTFields(0)
            .Value = mvarFechaHasta
            .Visible = True
         End With
         mAux = BuscarClaveINI("Activar grupo para facturacion automatica")
         If Len(mAux) > 0 Then
            mVector = VBA.Split(mAux, ",")
            With Frame5
               .Left = lblLabels(1).Left
               .Top = DTFields(1).Top - 50
               .Caption = "Grupo de facturacion :"
               .Visible = True
            End With
            With Option12
               .Caption = mVector(0)
               .Value = True
            End With
            Option13.Caption = mVector(1)
            If UBound(mVector) > 1 Then Option14.Caption = mVector(2)
         End If
         With cmd(2)
            .Top = cmd(1).Top
            .Left = cmd(1).Left
         End With
      
      Case 75
         Me.Caption = "Stock de articulos a fecha (Cubo)"
         Lista.Visible = False
         cmd(1).Visible = False
         With lblLabels(0)
            .Caption = "Movimientos :"
            .Visible = True
         End With
         With DTFields(0)
            .Value = mvarFechaDesde
            .Visible = True
         End With
         With lblLabels(1)
            .Width = .Width / 4
            .Caption = "al :"
            .Visible = True
         End With
         With DTFields(1)
            .Left = lblLabels(1).Left + lblLabels(1).Width + 100
            .Value = mvarFechaHasta
            .Visible = True
         End With
         With Check1
            .Left = lblLabels(0).Left
            .Top = lblLabels(0).Top + lblLabels(0).Height + 100
            .Width = DTFields(1).Width * 2
            .Caption = "Incluir codigo de articulos"
            .Visible = True
         End With
         With cmd(0)
            .Top = Check1.Top + Check1.Height + 100
            .Caption = "Procesar"
         End With
         With cmd(2)
            .Top = cmd(0).Top
            .Left = cmd(1).Left
         End With
         Me.Height = Me.Height / 2.5
         Toolbar1.Enabled = False
   
      Case 76
         Me.Caption = "Historico de equipos instalados"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
      
      Case 77
         Me.Caption = "Comparativas (Cubo)"
         Lista.Visible = False
         cmd(1).Visible = False
         Me.Height = Me.Height / 3
         With lblLabels(0)
            .Caption = "Solicitudes del :"
            .Visible = True
         End With
         With DTFields(0)
            .Value = mvarFechaDesde
            .Visible = True
         End With
         With lblLabels(1)
            .Width = .Width / 4
            .Caption = "al :"
            .Visible = True
         End With
         With DTFields(1)
            .Left = lblLabels(1).Left + lblLabels(1).Width + 100
            .Value = mvarFechaHasta
            .Visible = True
         End With
         With cmd(0)
            .Top = Lista.Top
            .Caption = "Procesar"
         End With
         With cmd(2)
            .Top = Lista.Top
            .Left = cmd(1).Left
         End With
         Toolbar1.Enabled = False
   
      Case 78
         Me.Caption = "Requerimientos detallados pendientes de compra"
         With cmd(2)
            .Top = cmd(0).Top
            .Left = cmd(0).Left
         End With
         cmd(0).Visible = False
         cmd(1).Visible = False
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
         Set Lista.DataSource = Aplicacion.Requerimientos.TraerFiltrado("_PendientesPorSolicitud")
      
      Case 79
         Me.Caption = "Reintegros"
         lblLabels(1).Visible = False
         DTFields(1).Visible = False
         lblLabels(0).Visible = False
         DTFields(0).Visible = False
         cmd(0).Caption = "Detallado"
         cmd(1).Caption = "Resumido"
      
      Case 80
         Me.Caption = "Comprobantes comercio exterior"
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
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
   
      Case 81
         Me.Caption = "Registro de ingreso de bienes de uso"
         With cmd(0)
            .Caption = "Procesar"
            .Visible = True
         End With
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
         Lista.MultiSelect = False
   
      Case 82
         Me.Caption = "Analisis Pedidos - Entregas"
         Lista.Visible = False
         cmd(1).Visible = False
         Me.Height = Me.Height / 3
         With lblLabels(0)
            .Caption = "Movimientos :"
            .Visible = True
         End With
         With DTFields(0)
            .Value = mvarFechaDesde
            .Visible = True
         End With
         With lblLabels(1)
            .Width = .Width / 4
            .Caption = "al :"
            .Visible = True
         End With
         With DTFields(1)
            .Left = lblLabels(1).Left + lblLabels(1).Width + 100
            .Value = mvarFechaHasta
            .Visible = True
         End With
         With cmd(0)
            .Top = Lista.Top
            .Caption = "Procesar"
         End With
         With cmd(2)
            .Top = Lista.Top
            .Left = cmd(1).Left
         End With
         Toolbar1.Enabled = False
   
      Case 83
         Me.Caption = "Recepciones en SAT"
         With cmd(0)
            .Caption = "Procesar"
            .Visible = True
         End With
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
         Lista.MultiSelect = False
   
      Case 84
         Me.Caption = "Proveedores - Percepciones IIBB (Compras) - SIFERE"
         cmd(0).Caption = "Procesar"
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
   
      Case 85
         Me.Caption = "Resumen posicion financiera (Cubo)"
         Lista.Visible = False
         cmd(1).Visible = False
         With lblLabels(0)
            .Caption = "Posicion al:"
         End With
         With DTFields(0)
            .Value = Date
         End With
         With cmd(0)
            .Top = lblLabels(0).Top
            .Caption = "Procesar"
         End With
         With cmd(2)
            .Top = cmd(0).Top
            .Left = cmd(1).Left
         End With
         Me.Height = Me.Height / 3
         Me.Width = Me.Width / 3
         Toolbar1.Enabled = False
   
      Case 86
         Me.Caption = "IVA Compras detallado"
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
      
      Case 87
         Me.Caption = "Detalle de equipos instalados por fecha"
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
      
      Case 88
         Me.Caption = "Clientes - Percepcion de IVA"
         cmd(0).Caption = "Procesar"
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
      
      Case 89
         Me.Caption = "Requerimientos pendientes de asignacion"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
         cmd_Click 0
      
      Case 90
         Me.Caption = "Estadistica de ventas por rubro-articulo"
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
            .Left = cmd(2).Left + cmd(2).Width * 2
            .Top = cmd(2).Top
            .Caption = "Origen de datos:"
            .Visible = True
         End With
         With Option1
            .Caption = "S/Remitos"
            .Value = True
         End With
         Option2.Caption = "S/Facturas"
      
      Case 91
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
         With Frame1
            .Caption = "Obra : "
            .Top = cmd(0).Top
            .Left = cmd(1).Left + cmd(1).Width + 50
            .Visible = True
         End With
         With Option1
            .Caption = "Todas"
            .Value = True
         End With
         Option2.Caption = "Elegir una"
         With lblLabels(4)
            .Top = Frame1.Top + 10
            .Left = Frame1.Left + Frame1.Width + 50
            .AutoSize = True
            .Caption = "Obra   : "
         End With
         With DataCombo1(1)
            .Top = Frame1.Top
            .Left = lblLabels(4).Left + lblLabels(4).Width + 20
            .Width = Frame3.Width * 0.75
            .BoundColumn = "IdObra"
            Set .RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo")
         End With
      
      Case 92
         Me.Caption = "Ordenes de trabajo"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
         cmd_Click 0
      
      Case 95
         Me.Caption = "Materiales controlados - remitos de rechazo"
         With cmd(2)
            .Top = cmd(0).Top
            .Left = cmd(0).Left
         End With
         cmd(0).Visible = False
         cmd(1).Visible = False
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
         Set Lista.DataSource = Aplicacion.TablasGenerales.TraerFiltrado("DetControlesCalidad", "_Controlados")
      
      Case 97
         Me.Caption = "Subdiario de proveedores"
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
         With Label1(0)
            .Top = lblLabels(0).Top
            .Left = DTFields(1).Left + DTFields(1).Width + 500
            .Width = lblLabels(0).Width
            .Height = lblLabels(0).Height
            .Caption = "Pagina inicial :"
            .Visible = True
         End With
         With Text1
            .Top = DTFields(1).Top
            .Left = Label1(0).Left + Label1(0).Width + 100
            .Width = DTFields(0).Width
            .Text = 1
            .Visible = True
         End With
      
      Case 98
         Me.Caption = "Subdiario de pagos"
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
         With Label1(0)
            .Top = lblLabels(0).Top
            .Left = DTFields(1).Left + DTFields(1).Width + 500
            .Width = lblLabels(0).Width
            .Height = lblLabels(0).Height
            .Caption = "Pagina inicial :"
            .Visible = True
         End With
         With Text1
            .Top = DTFields(1).Top
            .Left = Label1(0).Left + Label1(0).Width + 100
            .Width = DTFields(0).Width
            .Text = 1
            .Visible = True
         End With
      
      Case 99
         Me.Caption = "Subdiario de clientes"
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
         With Label1(0)
            .Top = lblLabels(0).Top
            .Left = DTFields(1).Left + DTFields(1).Width + 500
            .Width = lblLabels(0).Width
            .Height = lblLabels(0).Height
            .Caption = "Pagina inicial :"
            .Visible = True
         End With
         With Text1
            .Top = DTFields(1).Top
            .Left = Label1(0).Left + Label1(0).Width + 100
            .Width = DTFields(0).Width
            .Text = 1
            .Visible = True
         End With
      
      Case 100
         Me.Caption = "Subdiario de caja y bancos"
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
         With Label1(0)
            .Top = lblLabels(0).Top
            .Left = DTFields(1).Left + DTFields(1).Width + 500
            .Width = lblLabels(0).Width
            .Height = lblLabels(0).Height
            .Caption = "Pagina inicial :"
            .Visible = True
         End With
         With Text1
            .Top = DTFields(1).Top
            .Left = Label1(0).Left + Label1(0).Width + 100
            .Width = DTFields(0).Width
            .Text = 1
            .Visible = True
         End With
      
      Case 101
         Me.Caption = "Subdiario de cobranzas"
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
         With Label1(0)
            .Top = lblLabels(0).Top
            .Left = DTFields(1).Left + DTFields(1).Width + 500
            .Width = lblLabels(0).Width
            .Height = lblLabels(0).Height
            .Caption = "Pagina inicial :"
            .Visible = True
         End With
         With Text1
            .Top = DTFields(1).Top
            .Left = Label1(0).Left + Label1(0).Width + 100
            .Width = DTFields(0).Width
            .Text = 1
            .Visible = True
         End With
      
      Case 102
         Me.Caption = "Subdiario de IVA Ventas (2)"
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
         With Label1(0)
            .Top = lblLabels(0).Top
            .Left = DTFields(1).Left + DTFields(1).Width + 500
            .Width = lblLabels(0).Width
            .Height = lblLabels(0).Height
            .Caption = "Pagina inicial :"
            .Visible = True
         End With
         With Text1
            .Top = DTFields(1).Top
            .Left = Label1(0).Left + Label1(0).Width + 100
            .Width = DTFields(0).Width
            .Text = 1
            .Visible = True
         End With
      
      Case 103
         Me.Caption = "Subdiario de IVA Compras (2)"
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
         With Label1(0)
            .Top = lblLabels(0).Top
            .Left = DTFields(1).Left + DTFields(1).Width + 500
            .Width = lblLabels(0).Width
            .Height = lblLabels(0).Height
            .Caption = "Pagina inicial :"
            .Visible = True
         End With
         With Text1
            .Top = DTFields(1).Top
            .Left = Label1(0).Left + Label1(0).Width + 100
            .Width = DTFields(0).Width
            .Text = 1
            .Visible = True
         End With
      
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
      Text1.Text = oRs.Fields("CodigoEmpresa").Value
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
            .Top = lblLabels(0).Top
            .Width = DTFields(1).Width * 1.1
            .Visible = True
         End With
         With DTFields(1)
            .Top = DTFields(0).Top
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
   Dim mCampo2 As String, mIncluirCierre As String, mDesdeCodigo As String, mHastaCodigo As String, mConfirmarArchivo As String
   Dim mActivaRango As Integer, mTipoBusqueda As Integer, mIdBusqueda As Integer, mPos As Integer, i As Integer
   Dim mSeñal As Integer, mSeñal1 As Integer, mDesde As Integer, mHasta As Integer, x As Integer
   Dim mvarIdAux As Long, mvarIdAux1 As Long, mvarIdAux2 As Long
   Dim mvarAcumulado As Double, mvarSaldo As Double
   Dim mVectorProvincias, mVectorAux
   
   mvarSubTituloExcel = ""
   mConfirmarArchivo = BuscarClaveINI("Confirmar directorio para grabacion de archivos impositivos")

   Toolbar1.Enabled = True
   
   On Error GoTo Mal
   
   Select Case Index
      Case 0
         Select Case Me.Id
            Case 1
               If Option12.Value Then mStringAux = "P"
               If Option13.Value Then mStringAux = "F"
               If Option14.Value Then mStringAux = "T"
               Me.MousePointer = vbHourglass
               Aplicacion.Tarea "AutorizacionesPorComprobante_GenerarFirmas", Array(DTFields(0).Value, DTFields(1).Value)
               Set oTab = Aplicacion.AutorizacionesPorComprobante.TraerFiltrado("_ComprobantesSinFirmar", Array(mStringAux, DTFields(0).Value, DTFields(1).Value))
            
            Case 2
               Set oAp = Aplicacion
               Set oTab = oAp.TablasGenerales.TraerFiltrado("ArchivosATransmitirLoteo", "_EstadoGeneral")
            
            Case 3
               If Not Lista.SelectedItem Is Nothing Then Me.IdPresupuestoSeleccionado = Lista.SelectedItem.Tag
               Me.Hide
               Exit Sub
            
            Case 14
               Set oTab = Aplicacion.Proveedores.TraerFiltrado("_CITI", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
                  
            Case 16
               mCampo = BuscarClaveINI("Modelo para libro de iva ventas")
               If Len(Trim(mCampo)) = 0 Then
                  Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", _
                              "_IVAVentas", Array(DTFields(0).Value, DTFields(1).Value))
               Else
                  Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", _
                              "_IVAVentas" & mCampo, Array(DTFields(0).Value, DTFields(1).Value))
               End If
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
            
               mCampo = BuscarClaveINI("IVAVENTAS_FilasPorHoja")
               If Len(mCampo) = 0 Or Not IsNumeric(mCampo) Then mCampo = CStr(mvarLineasIvaCompras)
               mvarParametrosExcel = "SaltoDePaginaCada:" & mCampo
               mCampo = BuscarClaveINI("IVAVENTAS_ColumnaConTransporte")
               If Len(mCampo) = 0 Or Not IsNumeric(mCampo) Then mCampo = "5"
               mvarParametrosExcel = mvarParametrosExcel & "|ColumnaTransporte:" & mCampo
               mCampo = BuscarClaveINI("IVAVENTAS_ColumnasSumaParaTransporte")
               If Len(mCampo) = 0 Or Not IsNumeric(mCampo) Then mCampo = "8,9,11,12,13"
               mVectorAux = VBA.Split(mCampo, ",")
               For i = 0 To UBound(mVectorAux)
                  mvarParametrosExcel = mvarParametrosExcel & "|SumadorPorHoja" & i + 1 & ":" & mVectorAux(i)
               Next
               mvarParametrosExcel = mvarParametrosExcel & "|Enc:SinFecha"
            
            Case 17
               Set oTab = GenerarRsIvaCompras("")
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
            
            Case 18
               mvarPeriodo = "Mes"
               If Option3.Value Then
                  mvarCubo = "Gastos_Obra"
               ElseIf Option4.Value Then
                  mvarCubo = "Gastos_Unidad"
               Else
                  mvarCubo = "Gastos_Provincia_Rubro"
               End If
               
               Set oTab = TraerCubo(mvarCubo, mvarPeriodo, False, DTFields(0).Value, DTFields(1).Value)
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 19
               If Option6.Value Then
                  mvarPeriodo = "Día"
               ElseIf Option7.Value Then
                  mvarPeriodo = "Semana"
               ElseIf Option8.Value Then
                  mvarPeriodo = "Mes"
               ElseIf Option9.Value Then
                  mvarPeriodo = "Año"
               End If
               mvarCubo = "EgresosProyectados"
               
               Set oTab = TraerCubo(mvarCubo, mvarPeriodo, False, DTFields(0).Value)
         
            Case 20
               Set oTab = Aplicacion.Proveedores.TraerFiltrado("_RankingCompras", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               
            Case 21
               mStringAux = ""
               If Option13.Value Then
                  mStringAux = "_Modelo2"
               ElseIf Option14.Value Then
                  mStringAux = "_Modelo3"
               End If
               
               Set oTab = Aplicacion.Proveedores.TraerFiltrado("_Comprobantes" & mStringAux, Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 22
               mvarSubTituloExcel = "|Saldos al " & DTFields(0).Value
               mDesdeAlfa = ""
               mHastaAlfa = ""
               mDesdeCodigo = ""
               mHastaCodigo = ""
               If Option1.Value Then
                  mActivaRango = -1
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Rango de seleccion : Todos"
               Else
                  If Len(Trim(DataCombo1(0).Text)) > 0 Then
                     mActivaRango = -2
                     mDesdeAlfa = Trim(DataCombo1(0).Text)
                     mHastaAlfa = Trim(DataCombo1(1).Text)
                     mvarSubTituloExcel = mvarSubTituloExcel & "|Rango de seleccion : desde " & mDesdeAlfa & ", hasta " & mHastaAlfa
                  Else
                     mActivaRango = -3
                     mDesdeCodigo = Trim(Text1.Text)
                     mHastaCodigo = Trim(Text2.Text)
                     mvarSubTituloExcel = mvarSubTituloExcel & "|Rango de seleccion : desde codigo " & mDesdeCodigo & ", hasta codigo " & mHastaCodigo
                  End If
               End If
               
               If Option15.Value Then
                  Set oTab = Aplicacion.CtasCtesA.TraerFiltrado("_SaldosAFecha", _
                              Array(DTFields(0).Value, mActivaRango, mDesdeAlfa, _
                                    mHastaAlfa, mDesdeCodigo, mHastaCodigo))
               Else
                  Set oTab = CopiarTodosLosRegistros(Aplicacion.CtasCtesA.TraerFiltrado( _
                              "_SaldosAFechaDetallado", _
                              Array(DTFields(0).Value, DTFields(1).Value, mActivaRango, _
                              mDesdeAlfa, mHastaAlfa, mDesdeCodigo, mHastaCodigo)))
                  With oTab
                     If .RecordCount > 0 Then
                        .MoveFirst
                        mvarIdAux = IIf(IsNull(.Fields("K_Id").Value), 0, .Fields("K_Id").Value)
                        mvarSaldo = .Fields("Saldo").Value
                        Do While Not .EOF
                           If mvarIdAux <> .Fields("K_Id").Value Then
                              mvarSaldo = IIf(IsNull(.Fields("Saldo").Value), 0, .Fields("Saldo").Value)
                              mvarIdAux = .Fields("K_Id").Value
                           End If
                           mvarSaldo = mvarSaldo + IIf(IsNull(.Fields("Importe").Value), 0, .Fields("Importe").Value)
                           If .Fields(0).Value <> 0 Then .Fields("Saldo").Value = mvarSaldo
                           .Update
                           .MoveNext
                        Loop
                        .MoveFirst
                     End If
                  End With
               End If
         
            Case 23
               Set oTab = Aplicacion.Proveedores.TraerFiltrado("_RetencionesGanancias", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 24
               
               Set oTab = Aplicacion.CtasCtesA.TraerFiltrado("_PendientesDeImputacion", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 25
               Set oTab = Aplicacion.CtasCtesA.TraerFiltrado("_DetallePorTipoDeProveedor")
         
            Case 26
               Set oTab = DeudaVencida()
               mvarSubTituloExcel = "|Deuda vencida al " & DTFields(0).Value
               If Check3.Value = 0 Then mvarSubTituloExcel = mvarSubTituloExcel & "|Solo lo vencido"
         
            Case 27
               If Option6.Value Then
                  mvarPeriodo = "Día"
               ElseIf Option7.Value Then
                  mvarPeriodo = "Semana"
               ElseIf Option8.Value Then
                  mvarPeriodo = "Mes"
               ElseIf Option9.Value Then
                  mvarPeriodo = "Año"
               End If
               
               Set oTab = TraerCubo("CashFlow", mvarPeriodo, True, Date)
         
            Case 28
               If Frame3.Visible Then
                  If Option6.Value Then
                     mvarPeriodo = "Día"
                  ElseIf Option7.Value Then
                     mvarPeriodo = "Semana"
                  ElseIf Option8.Value Then
                     mvarPeriodo = "Mes"
                  ElseIf Option9.Value Then
                     mvarPeriodo = "Año"
                  End If
               End If
               
               If Option3.Value Then
                  Set oTab = TraerCubo("Ventas_ClientesFecha", mvarPeriodo, True, DTFields(0).Value, DTFields(1).Value)
               ElseIf Option4.Value Then
                  Set oTab = TraerCubo("Ventas_ObrasFecha", mvarPeriodo, False, DTFields(0).Value, DTFields(1).Value)
               ElseIf Option5.Value Then
                  Set oTab = TraerCubo("Ventas_ClienteUnidadOperativa", "", False, DTFields(0).Value, DTFields(1).Value)
               ElseIf Option10.Value Then
                  Set oTab = TraerCubo("Ventas_ClienteCuenta", "", False, DTFields(0).Value, DTFields(1).Value)
               ElseIf Option11.Value Then
                  Set oTab = TraerCubo("Ventas_ProvinciaCuenta", "", False, DTFields(0).Value, DTFields(1).Value)
               End If
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 30
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               If Option1.Value Then
                  Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("AnticiposAlPersonal", "_Detallado", _
                              Array(DTFields(0).Value, DTFields(1).Value, Text1.Text, Text2.Text))
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Detallado por movimiento."
                  If Option15.Value Then
                     oTab.Sort = "IdAux4,IdAux1,IdAux3"
                     mvarSubTituloExcel = mvarSubTituloExcel & "|Ordenado por legajo."
                  Else
                     oTab.Sort = "IdAux2,IdAux1,IdAux3"
                     mvarSubTituloExcel = mvarSubTituloExcel & "|Ordenado alfabeticamente."
                  End If
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Desde el legajo " & Text1.Text & " al " & Text2.Text
               Else
                  Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("AnticiposAlPersonal", "_Resumido", _
                              Array(DTFields(0).Value, DTFields(1).Value, Text1.Text, Text2.Text))
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Resumido por beneficiario"
                  If Option15.Value Then
                     oTab.Sort = "Legajo,Nombre"
                     mvarSubTituloExcel = mvarSubTituloExcel & "|Ordenado por legajo."
                  Else
                     oTab.Sort = "Nombre,Legajo"
                     mvarSubTituloExcel = mvarSubTituloExcel & "|Ordenado alfabeticamente."
                  End If
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Desde el legajo " & Text1.Text & " al " & Text2.Text
               End If
         
            Case 31
               Set oTab = Aplicacion.Proveedores.TraerFiltrado("_SICORE", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
            
            Case 33
               If Option15.Value Then
                  mStringAux = ""
               Else
                  mStringAux = "_Modelo2"
               End If
               
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_Comprobantes" & mStringAux, Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 34
               mvarSubTituloExcel = "|Saldos al " & DTFields(0).Value
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
               
               mvarIdAux1 = -1
               If Check1.Value = 1 Then
                  If Not IsNumeric(DataCombo1(2).BoundText) Then
                     MsgBox "Debe ingresar el vendedor", vbExclamation
                     Exit Sub
                  End If
                  mvarIdAux1 = DataCombo1(2).BoundText
               End If
               
               mvarIdAux2 = -1
               If Check2.Value = 1 Then
                  If Not IsNumeric(DataCombo1(3).BoundText) Then
                     MsgBox "Debe ingresar el cobrador", vbExclamation
                     Exit Sub
                  End If
                  mvarIdAux2 = DataCombo1(3).BoundText
               End If
               
               GenerarCondicionesDeCompra
               If Option15.Value Then
                  Set oTab = Aplicacion.CtasCtesD.TraerFiltrado("_SaldosAFecha", Array(DTFields(0).Value, mActivaRango, mDesdeAlfa, mHastaAlfa, mvarIdAux1, mvarIdAux2))
               Else
                  Set oTab = CopiarTodosLosRegistros(Aplicacion.CtasCtesD.TraerFiltrado("_SaldosAFechaDetallado", Array(DTFields(0).Value, DTFields(1).Value, mActivaRango, mDesdeAlfa, mHastaAlfa, mvarIdAux1, mvarIdAux2)))
                  With oTab
                     If .RecordCount > 0 Then
                        .MoveFirst
                        mvarIdAux = .Fields("K_Id").Value
                        mvarSaldo = .Fields("Saldo").Value
                        Do While Not .EOF
                           If mvarIdAux <> .Fields("K_Id").Value Then
                              mvarSaldo = .Fields("Saldo").Value
                              mvarIdAux = .Fields("K_Id").Value
                           End If
                           mvarSaldo = mvarSaldo + IIf(IsNull(.Fields("Importe").Value), 0, .Fields("Importe").Value)
                           .Fields("Saldo").Value = mvarSaldo
                           .Update
                           .MoveNext
                        Loop
                        .MoveFirst
                     End If
                  End With
               End If
         
            Case 35
               Set oTab = Aplicacion.Valores.TraerFiltrado("_ADepositar")
         
            Case 36
               Set oTab = Aplicacion.OrdenesPago.TraerFiltrado("_FFPendientesControl")
         
            Case 37
               mOrden = "C"
               If Option2.Value Then mOrden = "F"
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_RetencionesGanancias", Array(DTFields(0).Value, DTFields(1).Value, mOrden))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
         
            Case 38
               Set oTab = Aplicacion.Proveedores.TraerFiltrado("_RetencionesIVA", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
         
            Case 39
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_RetencionesIVA", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
         
            Case 40
               Set oTab = Aplicacion.Proveedores.TraerFiltrado("_PercepcionesIVA", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
         
            Case 41
               Set oTab = Aplicacion.Proveedores.TraerFiltrado("_SUSS", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
         
            Case 42
               If Option2.Value And Not IsNumeric(DataCombo1(1).BoundText) Then
                  MsgBox "Debe indicar la obra", vbExclamation
                  Exit Sub
               End If
               If Option12.Value And Not IsNumeric(DataCombo1(0).BoundText) Then
                  MsgBox "Debe indicar el rubro", vbExclamation
                  Exit Sub
               End If
               If Option13.Value And Not IsNumeric(DataCombo1(0).BoundText) Then
                  MsgBox "Debe indicar el articulo", vbExclamation
                  Exit Sub
               End If
               rchObservaciones.Text = ""
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               mTipoBusqueda = -1
               If Option12.Value Then
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Solo rubro " & DataCombo1(0).Text
                  If Len(Text1.Text) > 0 Then
                     mvarSubTituloExcel = mvarSubTituloExcel & " que contengan la(s) palabra(s) : " & Text1.Text
                  End If
                  mIdBusqueda = DataCombo1(0).BoundText
                  mTipoBusqueda = 1
               ElseIf Option13.Value Then
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Solo articulo " & DataCombo1(0).Text
                  mIdBusqueda = DataCombo1(0).BoundText
                  mTipoBusqueda = 2
               ElseIf Option14.Value Then
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Por descripcion que contengan la(s) palabra(s) : " & Text1.Text
                  mIdBusqueda = 0
                  mTipoBusqueda = 3
               End If
               If Option1.Value Then
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Todas las obras."
                  mIdObra = -1
               Else
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Solo obra " & DataCombo1(1).Text
                  mIdObra = DataCombo1(1).BoundText
               End If
               Set oTab = Aplicacion.Pedidos.TraerFiltrado("_Precios", Array(DTFields(0).Value, DTFields(1).Value, mTipoBusqueda, mIdBusqueda, Text1.Text, mIdObra))
        
            Case 43
               mCampo2 = "RECE"
               If Option2.Value Then mCampo2 = "SIRED"
               If Option3.Value Then
                  Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_1361_CabeceraFacturas", Array(DTFields(0).Value, DTFields(1).Value))
               ElseIf Option4.Value Then
                  Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_1361_DetalleFacturas", Array(DTFields(0).Value, DTFields(1).Value))
               ElseIf Option5.Value Then
                  Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_1361_Ventas", Array(DTFields(0).Value, DTFields(1).Value, mCampo2))
               ElseIf Option10.Value Then
                  mCampo1 = BuscarClaveINI("IdCuentas adicionales para impuestos internos")
                  If Len(mCampo1) > 0 Then
                     mVectorAux = VBA.Split(mCampo1, ",")
                     mCampo1 = ""
                     For i = 0 To UBound(mVectorAux)
                        mCampo1 = mCampo1 & "(" & CLng(mVectorAux(i)) & ")"
                     Next
                  End If
                  Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_1361_Compras", Array(DTFields(0).Value, DTFields(1).Value, mCampo1))
               ElseIf Option11.Value Then
                  Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_1361_OtrasPercepciones", Array(DTFields(0).Value, DTFields(1).Value))
               End If
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
            
            Case 44
               mCampo = BuscarClaveINI("Formato IIBB")
               If Len(mCampo) = 0 Then mCampo = "01"
               Set oTab = Aplicacion.Proveedores.TraerFiltrado("_RetencionesIIBB", Array(DTFields(0).Value, DTFields(1).Value, mCampo))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
         
            Case 45
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_RetencionesSUSS", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
         
            Case 46
               Set oTab = Aplicacion.Valores.TraerFiltrado("_Resolucion1547", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
         
            Case 47
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_PercepcionesIIBB", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
         
            Case 48
               Set oTab = Aplicacion.Cuentas.TraerFiltrado("_AsientoCierreEjercicio", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
               Me.MousePointer = vbDefault
               DoEvents
         
            Case 49
               If Not IsNumeric(Text1.Text) Then
                  MsgBox "El asiento debe ser numerico", vbExclamation
                  Exit Sub
               End If
               
               Set oTab = Aplicacion.Asientos.TraerFiltrado("_PorNumero", Text1.Text)
               If oTab.RecordCount = 0 Then
                  oTab.Close
                  MsgBox "No existe el asiento de cierre", vbExclamation
                  Exit Sub
               End If
               oTab.Close
               
               Set oTab = Aplicacion.Cuentas.TraerFiltrado("_AsientoAperturaEjercicio", Text1.Text)
               mvarSubTituloExcel = "|Asiento de apertura con fecha " & DTFields(0).Value
               cmd(1).Enabled = True
         
            Case 50
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_RetencionesIIBB_Cobranzas", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
         
            Case 51
               If Not Option1.Value And Not IsNumeric(DataCombo1(1).BoundText) Then
                  MsgBox "Debe definir la obra", vbExclamation
                  Exit Sub
               End If
               
               With lblInfo
                  .AutoSize = True
                  .Top = cmd(0).Top
                  .Left = DTFields(1).Left + DTFields(1).Width * 2
                  .Caption = "PROCESANDO INFORMACION, UN MOMENTO..."
                  .Visible = True
               End With
               DoEvents
               
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               
               If Option1.Value Then
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Todas las obras."
                  mIdObra = -1
               Else
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Solo obra " & DataCombo1(1).Text
                  mIdObra = DataCombo1(1).BoundText
               End If
               
               mvarIdAux = -1
               If BuscarClaveINI("Incluir ingresos por asiento para cubos") <> "SI" Then mvarIdAux = 0
               
               mStringAux = BuscarClaveINI("Modelo informe cubo de ingresos y egresos por obra")
               
               If mStringAux = "02" Then
                  Aplicacion.Tarea "CuboIngresoEgresosPorObra1", _
                        Array(DTFields(0).Value, DTFields(1).Value, mIdObra, mvarIdAux, _
                        glbDtsExec & " /F " & mvarDirectorioDTS & "CuboIngresoEgresosPorCuentas_" & glbEmpresaSegunString & "." & glbDtsExt, "")
                  Aplicacion.Tarea "CuboIngresoEgresosPorObra2", _
                        Array(DTFields(0).Value, DTFields(1).Value, mIdObra, _
                        glbDtsExec & " /F " & mvarDirectorioDTS & "CuboIngresoEgresosPorCuentas2_" & glbEmpresaSegunString & "." & glbDtsExt)
               Else
                  Aplicacion.Tarea "CuboIngresoEgresosPorObra1", _
                        Array(DTFields(0).Value, DTFields(1).Value, mIdObra, mvarIdAux, _
                        glbDtsExec & " /F " & mvarDirectorioDTS & "CuboIngresoEgresosPorTipoObra_" & glbEmpresaSegunString & "." & glbDtsExt, _
                        glbDtsExec & " /F " & mvarDirectorioDTS & "CuboIngresoEgresosPorObraTipo_" & glbEmpresaSegunString & "." & glbDtsExt)
               
               End If
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("_TempCuboIngresoEgresosPorObra", "_VerificarSiHayRegistros")
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               If mStringAux = "02" Then
                  AbrirCuboIngresoEgresosPorObraEnExcel2
               Else
                  AbrirCuboIngresoEgresosPorObraEnExcel
               End If
               Unload Me
         
            Case 52
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
               Set oTab = Aplicacion.OrdenesCompra.TraerFiltrado("_DesarrolloPorItem", Array(mActivaRango, mDesdeAlfa, mHastaAlfa, mPendiente, "F"))
         
            Case 53
               Set oTab = GenerarInformeOP(DTFields(0).Value, DTFields(1).Value)
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 54
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("PresupuestoFinanciero", "_DetallePorRubroContable", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 55
               Set oTab = Aplicacion.Bancos.TraerFiltrado("_SaldosAFecha", DTFields(0).Value)
               mvarSubTituloExcel = "|Saldos al " & DTFields(0).Value
         
            Case 56
               Set oTab = Aplicacion.Proveedores.TraerFiltrado("_PorRubrosProvistos")
               mvarSubTituloExcel = ""
         
            Case 57
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               If Option1.Value Then
                  mvarIdAux1 = -1
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Equipos : Todos"
               Else
                  If Not IsNumeric(DataCombo1(1).BoundText) Then
                     MsgBox "Debe indicar el equipo", vbExclamation
                     Exit Sub
                  End If
                  mvarIdAux1 = DataCombo1(1).BoundText
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Equipo : " & DataCombo1(1).Text
               End If
               If Option15.Value Then
                  mvarIdAux2 = -1
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Transportistas : Todos"
               Else
                  If Not IsNumeric(DataCombo1(2).BoundText) Then
                     MsgBox "Debe indicar el transportista", vbExclamation
                     Exit Sub
                  End If
                  mvarIdAux2 = DataCombo1(2).BoundText
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Transportista : " & DataCombo1(2).Text
               End If
               mStringAux = BuscarClaveINI("Mostrar costos en consulta por equipos")
               mCampo = "E"
               If Option20.Value Then mCampo = "T"
               Set oTab = Aplicacion.Articulos.TraerFiltrado("_CostosPorEquipo", _
                                 Array(DTFields(0).Value, DTFields(1).Value, mvarIdAux1, mStringAux, mvarIdAux2, mCampo))
         
            Case 58
               mSeñal = -1
               If Option1.Value Then mSeñal = 0
               
               Set oTab = Aplicacion.Obras.TraerFiltrado("_ConPolizasVencidas", Array(DTFields(0).Value, mSeñal))
               mvarSubTituloExcel = "|Polizas vencidas al " & DTFields(0).Value
         
            Case 59
               With lblInfo
                  .AutoSize = True
                  .Top = cmd(0).Top
                  .Left = DTFields(1).Left + DTFields(1).Width * 2
                  .Caption = "PROCESANDO INFORMACION, UN MOMENTO..."
                  .Visible = True
               End With
               DoEvents
               
               GenerarCondicionesDeCompra
               Aplicacion.Tarea "CtasCtesA_ProyeccionEgresosParaCubo1", Array(DTFields(0).Value, _
                  glbDtsExec & " /F " & mvarDirectorioDTS & "CuboEgresos_" & glbEmpresaSegunString & "." & glbDtsExt)
                           
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("Cubos", "_ControlarContenidoDeDatos", "_TempCuboProyeccionEgresos")
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               'Con DSO
            '   Set dsoServer = New DSO.Server
            '   dsoServer.Connect gblHOST
            '   Set dsoDatabase = dsoServer.MDStores.Item(glbEmpresaSegunString)
            '   dsoDatabase.MDStores.Item("EgresosProyectados").Process processFull
            '   Set dsoDatabase = Nothing
            '   Set dsoServer = Nothing
               
               'Con DTS Package
            '   Set oPackage = New DTS.Package2
            '   oPackage.LoadFromSQLServer gblHOST, "", "", DTSSQLStgFlag_UseTrustedConnection, , , , "CuboEgresos_" & glbEmpresaSegunString
            '   oPackage.Execute
            '   Set oPackage = Nothing
                           
               mvarSubTituloExcel = "| al " & DTFields(0).Value
               AbrirCuboEgresosProyectados
               Unload Me
               
            Case 60
               With lblInfo
                  .AutoSize = True
                  .Top = cmd(0).Top
                  .Left = DTFields(1).Left + DTFields(1).Width * 2
                  .Caption = "PROCESANDO INFORMACION, UN MOMENTO..."
                  .Visible = True
               End With
               DoEvents
               
               If Check1.Value = 1 Then
                  Aplicacion.Tarea "CuboPresupuestoFinanciero3", _
                     Array(Date, glbDtsExec & " /F " & mvarDirectorioDTS & "CuboPresupuestoFinanciero2_" & glbEmpresaSegunString & "." & glbDtsExt)
                  Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("Cubos", "_ControlarContenidoDeDatos", "_TempCuboPresupuestoFinanciero2")
               Else
                  If Option1.Value Then
                     Aplicacion.Tarea "CuboPresupuestoFinanciero", _
                        Array(glbDtsExec & " /F " & mvarDirectorioDTS & "CuboPresupuestoFinanciero_" & glbEmpresaSegunString & "." & glbDtsExt)
                     Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("Cubos", "_ControlarContenidoDeDatos", "_TempCuboPresupuestoFinanciero")
                  Else
                     If Not IsNumeric(DataCombo1(1).BoundText) Then
                        MsgBox "No indico el ejercicio", vbExclamation
                        Exit Sub
                     End If
                     Aplicacion.Tarea "CuboPresupuestoFinanciero2", _
                        Array(DataCombo1(1).BoundText, glbDtsExec & " /F " & mvarDirectorioDTS & "CuboPresupuestoFinanciero2_" & glbEmpresaSegunString & "." & glbDtsExt)
                     Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("Cubos", "_ControlarContenidoDeDatos", "_TempCuboPresupuestoFinanciero2")
                  End If
               End If
               
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               mvarSubTituloExcel = ""
               AbrirCuboPresupuestoFinanciero
               Unload Me
         
            Case 61
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
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
'               If Option17.Value Then
'                  mvarIdAux1 = -1
'                  mvarSubTituloExcel = mvarSubTituloExcel & "|Obras : Todas"
'               Else
'                  If Not IsNumeric(DataCombo1(3).BoundText) Then
'                     MsgBox "No indico la obra", vbExclamation
'                     Exit Sub
'                  End If
'                  mvarIdAux1 = DataCombo1(3).BoundText
'                  mvarSubTituloExcel = mvarSubTituloExcel & "|Obra : " & DataCombo1(3).Text
'               End If
               
               If Option15.Value Then
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Resumido por proveedor"
                  Set oTab = CopiarTodosLosRegistros(Aplicacion.CtasCtesA.TraerFiltrado("_SaldosEntreFechas", _
                              Array(DTFields(0).Value, DTFields(1).Value, mActivaRango, mDesdeAlfa, mHastaAlfa)))
                  SaldosProveedoresEntreFechas oTab
               Else
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Detallado por comprobantes"
                  Set oTab = Aplicacion.CtasCtesA.TraerFiltrado("_SaldosEntreFechasResumido", _
                              Array(DTFields(0).Value, DTFields(1).Value, mActivaRango, mDesdeAlfa, mHastaAlfa, mvarIdAux1))
                  oTab.Sort = "K_RazonSocial,K_Codigo"
               End If
               
            Case 62
               If Option2.Value And Not IsNumeric(DataCombo1(1).BoundText) Then
                  MsgBox "Debe indicar la obra", vbExclamation
                  Exit Sub
               End If
               
               With lblInfo
                  .AutoSize = True
                  .Caption = "PROCESANDO ..."
                  .Top = cmd(0).Top
                  .Left = Check1.Left
                  .Visible = True
               End With
               DoEvents
               
               mIncluirCierre = "NO"
               If Check1.Value = 1 Then mIncluirCierre = "SI"
               mIdObra = -1
               If Option2.Value Then mIdObra = DataCombo1(1).BoundText
               
               Aplicacion.Tarea "Cuentas_CuadroGastosPorObraDetallado", _
                  Array(DTFields(0).Value, DTFields(1).Value, _
                        glbDtsExec & " /F " & mvarDirectorioDTS & "CuboGastosDetallado_" & glbEmpresaSegunString & "." & glbDtsExt, mIncluirCierre, mIdObra)
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("Cubos", "_ControlarContenidoDeDatos", "_TempCuadroGastosParaCubo")
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               mvarSubTituloExcel = ""
               AbrirCuboGastos
               Unload Me
         
            Case 63
               With lblInfo
                  .AutoSize = True
                  .Top = cmd(0).Top
                  .Left = DTFields(1).Left + DTFields(1).Width * 2
                  .Caption = "PROCESANDO INFORMACION, UN MOMENTO..."
                  .Visible = True
               End With
               DoEvents
               
               mvarIdAux = -1
               If BuscarClaveINI("Incluir ingresos por asiento para cubos") <> "SI" Then mvarIdAux = 0
               
               Aplicacion.Tarea "CuboDeVentasDetalladas", _
                  Array(DTFields(0).Value, DTFields(1).Value, mvarIdAux, _
                        glbDtsExec & " /F " & mvarDirectorioDTS & "CuboVentasDetalladas_" & glbEmpresaSegunString & "." & glbDtsExt)
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("Cubos", "_ControlarContenidoDeDatos", "_TempVentasParaCubo")
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               mvarSubTituloExcel = ""
               AbrirCuboVentas
               Unload Me
         
            Case 64
               Set oTab = Aplicacion.Articulos.TraerFiltrado("_SaldosDeStockAFecha", DTFields(0).Value)
               mvarSubTituloExcel = "|Al " & DTFields(0).Value
         
            Case 65
               With lblInfo
                  .AutoSize = True
                  .Top = cmd(0).Top
                  .Left = DTFields(1).Left + DTFields(1).Width * 2
                  .Caption = "PROCESANDO INFORMACION, UN MOMENTO..."
                  .Visible = True
               End With
               DoEvents
               
               mvarSubTituloExcel = "|Se toman los comprobantes con vencimiento posterior al " & DTFields(0).Value
               
               GenerarCondicionesDeCompra
               If Check1.Value = 1 Then
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Calculado sobre saldos de comprobantes al " & DTFields(1).Value
                  ArmarSaldosTransaccionAFecha DTFields(1).Value
                  Aplicacion.Tarea "CuboPresupuestoFinancieroTeoricoA", _
                     Array(DTFields(0).Value, _
                           glbDtsExec & " /F " & mvarDirectorioDTS & "CuboPresupuestoFinancieroTeorico_" & glbEmpresaSegunString & "." & glbDtsExt)
               Else
                  Aplicacion.Tarea "CuboPresupuestoFinancieroTeorico", _
                     Array(DTFields(0).Value, _
                           glbDtsExec & " /F " & mvarDirectorioDTS & "CuboPresupuestoFinancieroTeorico_" & glbEmpresaSegunString & "." & glbDtsExt)
               End If
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("Cubos", "_ControlarContenidoDeDatos", "_TempCuboPresupuestoFinancieroTeorico")
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               AbrirCuboPresupuestoFinancieroTeorico
               Unload Me
         
            Case 66
               mvarSubTituloExcel = "|Deuda vencida al " & DTFields(0).Value
               
               mVentasEnCuotas = "NO"
               If Check3.Value = 1 Then mVentasEnCuotas = "SI"
               
               mCreditos = "NO"
               If Check4.Value = 1 Then
                  mCreditos = "SI"
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Incluye creditos no aplicados"
               Else
                  mvarSubTituloExcel = mvarSubTituloExcel & "|No incluye creditos no aplicados"
               End If
               
               mCampo2 = "NO"
               If Check5.Value = 1 Then
                  mCampo2 = "SI"
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Descartados saldos en cero"
               Else
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Incluye saldos en cero"
               End If
               
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
               
               mvarIdAux1 = -1
               If Check1.Value = 1 Then
                  If Not IsNumeric(DataCombo1(2).BoundText) Then
                     MsgBox "Debe ingresar el vendedor", vbExclamation
                     Exit Sub
                  End If
                  mvarIdAux1 = DataCombo1(2).BoundText
               End If
               
               mvarIdAux2 = -1
               If Check2.Value = 1 Then
                  If Not IsNumeric(DataCombo1(3).BoundText) Then
                     MsgBox "Debe ingresar el cobrador", vbExclamation
                     Exit Sub
                  End If
                  mvarIdAux2 = DataCombo1(3).BoundText
               End If
               
               mSeñal = -1
               If Option16.Value Then mSeñal = 0
               
               Set oTab = Aplicacion.CtasCtesD.TraerFiltrado("_CreditosVencidos", _
                  Array(mSeñal, DTFields(0).Value, DTFields(1).Value, mVentasEnCuotas, mCreditos, _
                        mActivaRango, mDesdeAlfa, mHastaAlfa, mvarIdAux1, mvarIdAux2, mCampo2))
         
            Case 67
               With lblInfo
                  .AutoSize = True
                  .Top = cmd(0).Top
                  .Left = DTFields(1).Left + DTFields(1).Width * 2
                  .Caption = "PROCESANDO INFORMACION, UN MOMENTO..."
                  .Visible = True
               End With
               DoEvents
               
               If DTFields(0).Value = Date Then
                  Aplicacion.Tarea "CuboSaldosComprobantesPorObraProveedor", _
                     Array(DTFields(0).Value, glbDtsExec & " /F " & mvarDirectorioDTS & "CuboSaldosComprobantesPorObraProveedor_" & glbEmpresaSegunString & "." & glbDtsExt)
               Else
                  ArmarSaldosTransaccionAFecha DTFields(0).Value
                  Aplicacion.Tarea "CuboSaldosComprobantesPorObraProveedorA", _
                     Array(DTFields(0).Value, glbDtsExec & " /F " & mvarDirectorioDTS & "CuboSaldosComprobantesPorObraProveedor_" & glbEmpresaSegunString & "." & glbDtsExt)
               End If
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("Cubos", "_ControlarContenidoDeDatos", "_TempCuboSaldosComprobantesPorObraProveedor")
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               mvarSubTituloExcel = ""
               AbrirCuboSaldosComprobantesPorObraProveedor
               Unload Me
         
            Case 68
               With lblInfo
                  .AutoSize = True
                  .Top = cmd(0).Top
                  .Left = DTFields(1).Left + DTFields(1).Width * 2
                  .Caption = "PROCESANDO INFORMACION, UN MOMENTO..."
                  .Visible = True
               End With
               DoEvents
               
               Aplicacion.Tarea "CuboIVAPorObra", _
                  Array(DTFields(0).Value, DTFields(1).Value, glbDtsExec & " /F " & mvarDirectorioDTS & "CuboIVAPorObra_" & glbEmpresaSegunString & "." & glbDtsExt)
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("Cubos", "_ControlarContenidoDeDatos", "_TempCuboIVAPorObra")
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               mvarSubTituloExcel = ""
               AbrirCuboIVAPorObra
               Unload Me
         
            Case 69
               With lblInfo
                  .AutoSize = True
                  .Top = cmd(0).Top
                  .Left = DTFields(1).Left + DTFields(1).Width * 2
                  .Caption = "PROCESANDO INFORMACION, UN MOMENTO..."
                  .Visible = True
               End With
               DoEvents
               
               Aplicacion.Tarea "CuboCostosImportacion", _
                  Array(glbDtsExec & " /F " & mvarDirectorioDTS & "CuboCostosImportacion_" & glbEmpresaSegunString & "." & glbDtsExt)
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("_TempCuboCostosImportacion", "_VerificarSiHayRegistros")
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               mvarSubTituloExcel = ""
               AbrirCuboCostosImportacion
               Unload Me
         
            Case 70
               Set oTab = Aplicacion.Articulos.TraerFiltrado("_CostosImportacionAAsignar")
               mvarSubTituloExcel = ""
         
            Case 71
               With lblInfo
                  .AutoSize = True
                  .Top = cmd(0).Top
                  .Left = DTFields(1).Left + DTFields(1).Width * 2
                  .Caption = "PROCESANDO INFORMACION, UN MOMENTO..."
                  .Visible = True
               End With
               DoEvents
               
               Aplicacion.Tarea "CuboVentasEnCuotas", _
                  Array(DTFields(0).Value, DTFields(1).Value, _
                        glbDtsExec & " /F " & mvarDirectorioDTS & "CuboVentasEnCuotas_" & glbEmpresaSegunString & "." & glbDtsExt)
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("_TempCuboVentasEnCuotas", "_VerificarSiHayRegistros")
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               mvarSubTituloExcel = ""
               AbrirCuboVentasEnCuotas
               Unload Me
         
            Case 72
               With lblInfo
                  .AutoSize = True
                  .Top = cmd(0).Top
                  .Left = DTFields(1).Left + DTFields(1).Width * 2
                  .Caption = "PROCESANDO INFORMACION, UN MOMENTO..."
                  .Visible = True
               End With
               DoEvents
               
               Aplicacion.Tarea "CuboReservaPresupuestaria", _
                  Array(DTFields(0).Value, DTFields(1).Value, glbDtsExec & " /F " & mvarDirectorioDTS & "CuboReservaPresupuestaria_" & glbEmpresaSegunString & "." & glbDtsExt)
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("_TempCuboReservaPresupuestaria", "_VerificarSiHayRegistros")
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               mvarSubTituloExcel = ""
               AbrirCuboReservaPresupuestaria
               Unload Me
         
            Case 73
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("DefinicionesCuadrosContables", "_DetalladoEntreFechas", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
            
            Case 74
               mSeñal = -1
               If Frame1.Visible Then
                  If Option12.Value Then
                     mSeñal = 1
                  ElseIf Option13.Value Then
                     mSeñal = 2
                  ElseIf Option14.Value Then
                     mSeñal = 3
                  End If
                  mConceptosAbono = "*"
               Else
                  mConceptosAbono = BuscarClaveINI("Conceptos para facturar abonos")
               End If
               If Len(mConceptosAbono) = 0 Then mConceptosAbono = "*"
               Set oTab = Aplicacion.OrdenesCompra.TraerFiltrado("_OrdenesAutomaticasPrefacturacion", _
                              Array(DTFields(0).Value, mConceptosAbono, mSeñal))
               mvarSubTituloExcel = "|Prefacturacion al " & DTFields(0).Value
         
            Case 75
               With lblInfo
                  .AutoSize = True
                  .Top = cmd(0).Top
                  .Left = lblLabels(1).Left + lblLabels(1).Width * 15
                  .Caption = "PROCESANDO INFORMACION, UN MOMENTO..."
                  .Visible = True
               End With
               DoEvents
               
               mStringAux = "S"
               If Check1.Value = 1 Then mStringAux = "C"
               
               Aplicacion.Tarea "CuboStock", _
                  Array(DTFields(0).Value, DTFields(1).Value, mStringAux, glbDtsExec & " /F " & mvarDirectorioDTS & "CuboStock_" & glbEmpresaSegunString & "." & glbDtsExt)
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("Cubos", "_ControlarContenidoDeDatos", "_TempCuboStock")
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               mvarSubTituloExcel = ""
               AbrirCuboStock
               Unload Me
         
            Case 76
               Set oTab = Aplicacion.Articulos.TraerFiltrado("_HistoriaEquiposInstalados")
               mvarSubTituloExcel = ""
         
            Case 77
               With lblInfo
                  .AutoSize = True
                  .Top = cmd(0).Top
                  .Left = lblLabels(1).Left + lblLabels(1).Width * 15
                  .Caption = "PROCESANDO INFORMACION, UN MOMENTO..."
                  .Visible = True
               End With
               DoEvents
               
               Aplicacion.Tarea "CuboComparativas", _
                  Array(DTFields(0).Value, DTFields(1).Value, glbDtsExec & " /F " & mvarDirectorioDTS & "CuboComparativas_" & glbEmpresaSegunString & "." & glbDtsExt)
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("Cubos", "_ControlarContenidoDeDatos", "_TempCuboComparativa")
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               mvarSubTituloExcel = ""
               AbrirCuboComparativas
               Unload Me
         
            Case 79
               Set oTab = Aplicacion.ComprobantesProveedores.TraerFiltrado("_ReintegrosDetallados")
         
            Case 80
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_ComercioExterior", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
            
            Case 81
               Set oTab = Aplicacion.Recepciones.TraerFiltrado("_DetallesParaBienesDeUso", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
            
            Case 82
               GenerarCondicionesDeCompra
               Aplicacion.Tarea "CuboPedidos", _
                  Array(DTFields(0).Value, DTFields(1).Value, glbDtsExec & " /F " & mvarDirectorioDTS & "CuboPedidos_" & glbEmpresaSegunString & "." & glbDtsExt)
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("Cubos", "_ControlarContenidoDeDatos", "_TempCuboPedidos")
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               mvarSubTituloExcel = ""
               AbrirCuboPedidos
               Unload Me
         
            Case 83
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("RecepcionesSAT", "_EntreFechas", _
                                       Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
            
            Case 84
               Set oTab = Aplicacion.Proveedores.TraerFiltrado("_PercepcionesIIBBConvenio", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
         
            Case 85
               Aplicacion.Tarea "CuboPosicionFinanciera", _
                  Array(DTFields(0).Value, glbDtsExec & " /F " & mvarDirectorioDTS & "CuboPosicionFinanciera_" & glbEmpresaSegunString & "." & glbDtsExt)
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("Cubos", "_ControlarContenidoDeDatos", "_TempCuboPosicionFinanciera")
               If oTab.RecordCount = 0 Then
                  MsgBox "No hay informacion para procesar", vbExclamation
                  oTab.Close
                  Set oTab = Nothing
                  Unload Me
                  Exit Sub
               End If
               oTab.Close
               Set oTab = Nothing
               
               mvarSubTituloExcel = ""
               AbrirCuboPosicionFinanciera
               Unload Me
         
            Case 86
               mCampo = BuscarClaveINI("Tomar impuestos internos con cuentas hijas para iva compras")
               If mCampo <> "SI" Then mCampo = "NO"
               mCampo1 = BuscarClaveINI("IdCuentas adicionales para impuestos internos")
               If Len(mCampo1) > 0 Then
                  mVectorAux = VBA.Split(mCampo1, ",")
                  mCampo1 = ""
                  For i = 0 To UBound(mVectorAux)
                     mCampo1 = mCampo1 & "(" & CLng(mVectorAux(i)) & ")"
                  Next
               End If
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", _
                              "_IVAComprasDetallado", Array(DTFields(0).Value, DTFields(1).Value, _
                                                   mCampo, mCampo1))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 87
               Set oTab = Aplicacion.Obras.TraerFiltrado("_EquiposInstaladosPorFecha", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 88
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_PercepcionesIVA", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
         
            Case 89
               Set oTab = Aplicacion.Requerimientos.TraerFiltrado("_PendientesDeAsignacion", DepositosPorUsuario())
               mvarSubTituloExcel = ""
         
            Case 90
               If Option1.Value Then
                  Set oTab = Aplicacion.Articulos.TraerFiltrado("_ResumenRemitosPorRubro", _
                                    Array(DTFields(0).Value, DTFields(1).Value))
               Else
                  Set oTab = Aplicacion.Articulos.TraerFiltrado("_ResumenVentasPorRubro", _
                                    Array(DTFields(0).Value, DTFields(1).Value))
               End If
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
         
            Case 91
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               If Option1.Value Then
                  mvarIdAux1 = -1
                  mvarSubTituloExcel = mvarSubTituloExcel & "|Obras : Todas"
               Else
                  If Not IsNumeric(DataCombo1(1).BoundText) Then
                     MsgBox "Debe indicar la obra", vbExclamation
                     Exit Sub
                  End If
                  mvarIdAux1 = DataCombo1(1).BoundText
               End If
               Set oTab = Aplicacion.SalidasMateriales.TraerFiltrado("_EntreFechas", Array(DTFields(0).Value, DTFields(1).Value, mvarIdAux1))
         
            Case 92
               Set oTab = Aplicacion.OrdenesTrabajo.TraerTodos
               mvarSubTituloExcel = ""
         
            Case 97
               mCampo = "" & Day(DTFields(0).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo1 = mCampo & "  /  "
               mCampo = "" & Month(DTFields(0).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo1 = mCampo1 & mCampo & "  /  "
               mCampo = "" & Year(DTFields(0).Value)
               mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1) & " " & mId(mCampo, 3, 1) & " " & mId(mCampo, 4, 1)
               mCampo1 = mCampo1 & mCampo
               
               mCampo = "" & Day(DTFields(1).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo2 = mCampo & "  /  "
               mCampo = "" & Month(DTFields(1).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo2 = mCampo2 & mCampo & "  /  "
               mCampo = "" & Year(DTFields(1).Value)
               mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1) & " " & mId(mCampo, 3, 1) & " " & mId(mCampo, 4, 1)
               mCampo2 = mCampo2 & mCampo
               
               mvarSubTituloExcel = "|D  E  L     " & mCampo1 & "    A  L    " & mCampo2
               
               mCampo1 = BuscarClaveINI("IdCuentas adicionales para impuestos internos")
               If Len(mCampo1) > 0 Then
                  mVectorAux = VBA.Split(mCampo1, ",")
                  mCampo1 = ""
                  For i = 0 To UBound(mVectorAux)
                     mCampo1 = mCampo1 & "(" & CLng(mVectorAux(i)) & ")"
                  Next
               End If
         
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_SubdiarioProveedores", _
                           Array(DTFields(0).Value, DTFields(1).Value, mCampo1))
         
            Case 98
               mCampo = "" & Day(DTFields(0).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo1 = mCampo & "  /  "
               mCampo = "" & Month(DTFields(0).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo1 = mCampo1 & mCampo & "  /  "
               mCampo = "" & Year(DTFields(0).Value)
               mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1) & " " & mId(mCampo, 3, 1) & " " & mId(mCampo, 4, 1)
               mCampo1 = mCampo1 & mCampo
               
               mCampo = "" & Day(DTFields(1).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo2 = mCampo & "  /  "
               mCampo = "" & Month(DTFields(1).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo2 = mCampo2 & mCampo & "  /  "
               mCampo = "" & Year(DTFields(1).Value)
               mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1) & " " & mId(mCampo, 3, 1) & " " & mId(mCampo, 4, 1)
               mCampo2 = mCampo2 & mCampo
               
               mvarSubTituloExcel = "|D  E  L     " & mCampo1 & "    A  L    " & mCampo2
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_SubdiarioPagos", _
                           Array(DTFields(0).Value, DTFields(1).Value))
         
            Case 99
               mCampo = "" & Day(DTFields(0).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo1 = mCampo & "  /  "
               mCampo = "" & Month(DTFields(0).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo1 = mCampo1 & mCampo & "  /  "
               mCampo = "" & Year(DTFields(0).Value)
               mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1) & " " & mId(mCampo, 3, 1) & " " & mId(mCampo, 4, 1)
               mCampo1 = mCampo1 & mCampo
               
               mCampo = "" & Day(DTFields(1).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo2 = mCampo & "  /  "
               mCampo = "" & Month(DTFields(1).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo2 = mCampo2 & mCampo & "  /  "
               mCampo = "" & Year(DTFields(1).Value)
               mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1) & " " & mId(mCampo, 3, 1) & " " & mId(mCampo, 4, 1)
               mCampo2 = mCampo2 & mCampo
               
               mvarSubTituloExcel = "|D  E  L     " & mCampo1 & "    A  L    " & mCampo2
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_SubdiarioClientes", _
                           Array(DTFields(0).Value, DTFields(1).Value))
         
            Case 100
               mCampo = "" & Day(DTFields(0).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo1 = mCampo & "  /  "
               mCampo = "" & Month(DTFields(0).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo1 = mCampo1 & mCampo & "  /  "
               mCampo = "" & Year(DTFields(0).Value)
               mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1) & " " & mId(mCampo, 3, 1) & " " & mId(mCampo, 4, 1)
               mCampo1 = mCampo1 & mCampo
               
               mCampo = "" & Day(DTFields(1).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo2 = mCampo & "  /  "
               mCampo = "" & Month(DTFields(1).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo2 = mCampo2 & mCampo & "  /  "
               mCampo = "" & Year(DTFields(1).Value)
               mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1) & " " & mId(mCampo, 3, 1) & " " & mId(mCampo, 4, 1)
               mCampo2 = mCampo2 & mCampo
               
               mvarSubTituloExcel = "|D  E  L     " & mCampo1 & "    A  L    " & mCampo2
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_SubdiarioCajaYBancos", _
                           Array(DTFields(0).Value, DTFields(1).Value))
            
            Case 101
               mCampo = "" & Day(DTFields(0).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo1 = mCampo & "  /  "
               mCampo = "" & Month(DTFields(0).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo1 = mCampo1 & mCampo & "  /  "
               mCampo = "" & Year(DTFields(0).Value)
               mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1) & " " & mId(mCampo, 3, 1) & " " & mId(mCampo, 4, 1)
               mCampo1 = mCampo1 & mCampo
               
               mCampo = "" & Day(DTFields(1).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo2 = mCampo & "  /  "
               mCampo = "" & Month(DTFields(1).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo2 = mCampo2 & mCampo & "  /  "
               mCampo = "" & Year(DTFields(1).Value)
               mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1) & " " & mId(mCampo, 3, 1) & " " & mId(mCampo, 4, 1)
               mCampo2 = mCampo2 & mCampo
               
               mvarSubTituloExcel = "|D  E  L     " & mCampo1 & "    A  L    " & mCampo2
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_SubdiarioCobranzas", _
                           Array(DTFields(0).Value, DTFields(1).Value))
         
            Case 102
               mCampo = "" & Day(DTFields(0).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo1 = mCampo & "  /  "
               mCampo = "" & Month(DTFields(0).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo1 = mCampo1 & mCampo & "  /  "
               mCampo = "" & Year(DTFields(0).Value)
               mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1) & " " & mId(mCampo, 3, 1) & " " & mId(mCampo, 4, 1)
               mCampo1 = mCampo1 & mCampo
               
               mCampo = "" & Day(DTFields(1).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo2 = mCampo & "  /  "
               mCampo = "" & Month(DTFields(1).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo2 = mCampo2 & mCampo & "  /  "
               mCampo = "" & Year(DTFields(1).Value)
               mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1) & " " & mId(mCampo, 3, 1) & " " & mId(mCampo, 4, 1)
               mCampo2 = mCampo2 & mCampo
               
               mvarSubTituloExcel = "|D  E  L     " & mCampo1 & "    A  L    " & mCampo2
               
               Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", _
                           "_IVAVentas_Modelo3", Array(DTFields(0).Value, DTFields(1).Value))
            
               mCampo = BuscarClaveINI("IVAVENTAS_FilasPorHoja")
               If Len(mCampo) = 0 Or Not IsNumeric(mCampo) Then mCampo = CStr(mvarLineasIvaCompras)
               mvarParametrosExcel = "SaltoDePaginaCada:" & mCampo
               mCampo = BuscarClaveINI("IVAVENTAS_ColumnaConTransporte")
               If Len(mCampo) = 0 Or Not IsNumeric(mCampo) Then mCampo = "5"
               mvarParametrosExcel = mvarParametrosExcel & "|ColumnaTransporte:" & mCampo
               mCampo = BuscarClaveINI("IVAVENTAS_ColumnasSumaParaTransporte")
               If Len(mCampo) = 0 Or Not IsNumeric(mCampo) Then mCampo = "8,9,11,12,13"
               mVectorAux = VBA.Split(mCampo, ",")
               For i = 0 To UBound(mVectorAux)
                  mvarParametrosExcel = mvarParametrosExcel & "|SumadorPorHoja" & i + 1 & ":" & mVectorAux(i)
               Next
            
            Case 103
               mCampo = "" & Day(DTFields(0).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo1 = mCampo & "  /  "
               mCampo = "" & Month(DTFields(0).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo1 = mCampo1 & mCampo & "  /  "
               mCampo = "" & Year(DTFields(0).Value)
               mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1) & " " & mId(mCampo, 3, 1) & " " & mId(mCampo, 4, 1)
               mCampo1 = mCampo1 & mCampo
               
               mCampo = "" & Day(DTFields(1).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo2 = mCampo & "  /  "
               mCampo = "" & Month(DTFields(1).Value)
               If Len(mCampo) > 1 Then mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1)
               mCampo2 = mCampo2 & mCampo & "  /  "
               mCampo = "" & Year(DTFields(1).Value)
               mCampo = mId(mCampo, 1, 1) & " " & mId(mCampo, 2, 1) & " " & mId(mCampo, 3, 1) & " " & mId(mCampo, 4, 1)
               mCampo2 = mCampo2 & mCampo
               
               mvarSubTituloExcel = "|D  E  L     " & mCampo1 & "    A  L    " & mCampo2
               
               Set oTab = GenerarRsIvaCompras("_Modelo3")
            
         End Select
      
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
            Lista.ListItems.Clear
         End If
         
         If Lista.ListItems.Count > 0 Then StatusBar1.Panels(2).Text = "" & Lista.ListItems.Count & " elementos en la lista"
   
         Set oTab = Nothing
         Set oAut = Nothing
         Set oAp = Nothing
         
         CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
         
         Me.MousePointer = vbDefault
         
         mvarCual = 99
         
      Case 1
         Dim oL As ListItem
         
         Select Case Me.Id
            Case 14
               If ListaVacia Then Exit Sub
               s = ""
               For Each oL In Lista.ListItems
                  s = s & oL.SubItems(9) & vbCrLf
               Next
               If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
               mArchivoSalida = mvarPathArchivosExportados & "CITI.TXT"
               If mConfirmarArchivo = "SI" Then
                  With CommonDialog1
                     .InitDir = mvarPathArchivosExportados
                     .Filename = mArchivoSalida
                     .ShowSave
                     If .CancelError Then Exit Sub
                     mArchivoSalida = .Filename
                  End With
               End If
               GuardarArchivoSecuencial mArchivoSalida, s
               MsgBox "Se ha generado el archivo : " & mArchivoSalida, vbInformation
            
            Case 31
               If ListaVacia Then Exit Sub
               s = ""
               For Each oL In Lista.ListItems
                  s = s & oL.SubItems(20) & vbCrLf
               Next
               If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
               mArchivoSalida = mvarPathArchivosExportados & "SICORE.TXT"
               If mConfirmarArchivo = "SI" Then
                  With CommonDialog1
                     .InitDir = mvarPathArchivosExportados
                     .Filename = mArchivoSalida
                     .ShowSave
                     If .CancelError Then Exit Sub
                     mArchivoSalida = .Filename
                  End With
               End If
               GuardarArchivoSecuencial mArchivoSalida, s
               MsgBox "Se ha generado el archivo : " & mArchivoSalida, vbInformation
            
            Case 37
               If ListaVacia Then Exit Sub
               s = ""
               For Each oL In Lista.ListItems
                  If Check1.Value = 0 Then
                     If Len(oL.SubItems(8)) > 0 Then s = s & oL.SubItems(8) & vbCrLf
                  Else
                     If Len(oL.SubItems(9)) > 0 Then s = s & oL.SubItems(9) & vbCrLf
                  End If
               Next
               If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
               mArchivoSalida = mvarPathArchivosExportados & "RETGANCL.TXT"
               If mConfirmarArchivo = "SI" Then
                  With CommonDialog1
                     .InitDir = mvarPathArchivosExportados
                     .Filename = mArchivoSalida
                     .ShowSave
                     If .CancelError Then Exit Sub
                     mArchivoSalida = .Filename
                  End With
               End If
               GuardarArchivoSecuencial mArchivoSalida, s
               MsgBox "Se ha generado el archivo : " & mArchivoSalida, vbInformation
         
            Case 38
               If ListaVacia Then Exit Sub
               s = ""
               For Each oL In Lista.ListItems
                  If Len(oL.SubItems(8)) > 0 Then s = s & oL.SubItems(8) & vbCrLf
               Next
               If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
               mArchivoSalida = mvarPathArchivosExportados & "RETIVAPR.TXT"
               If mConfirmarArchivo = "SI" Then
                  With CommonDialog1
                     .InitDir = mvarPathArchivosExportados
                     .Filename = mArchivoSalida
                     .ShowSave
                     If .CancelError Then Exit Sub
                     mArchivoSalida = .Filename
                  End With
               End If
               GuardarArchivoSecuencial mArchivoSalida, s
               MsgBox "Se ha generado el archivo : " & mArchivoSalida, vbInformation
         
            Case 39
               If ListaVacia Then Exit Sub
               s = ""
               For Each oL In Lista.ListItems
                  If Len(oL.SubItems(7)) > 0 Then s = s & oL.SubItems(7) & vbCrLf
               Next
               If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
               mArchivoSalida = mvarPathArchivosExportados & "RETIVACL.TXT"
               If mConfirmarArchivo = "SI" Then
                  With CommonDialog1
                     .InitDir = mvarPathArchivosExportados
                     .Filename = mArchivoSalida
                     .ShowSave
                     If .CancelError Then Exit Sub
                     mArchivoSalida = .Filename
                  End With
               End If
               GuardarArchivoSecuencial mArchivoSalida, s
               MsgBox "Se ha generado el archivo : " & mArchivoSalida, vbInformation
         
            Case 40
               If ListaVacia Then Exit Sub
               s = ""
               For Each oL In Lista.ListItems
                  If Len(oL.SubItems(6)) > 0 Then s = s & oL.SubItems(6) & vbCrLf
               Next
               If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
               mArchivoSalida = mvarPathArchivosExportados & "PERIVAPR.TXT"
               If mConfirmarArchivo = "SI" Then
                  With CommonDialog1
                     .InitDir = mvarPathArchivosExportados
                     .Filename = mArchivoSalida
                     .ShowSave
                     If .CancelError Then Exit Sub
                     mArchivoSalida = .Filename
                  End With
               End If
               GuardarArchivoSecuencial mArchivoSalida, s
               MsgBox "Se ha generado el archivo : " & mArchivoSalida, vbInformation
         
            Case 41
               If ListaVacia Then Exit Sub
               s = ""
               For Each oL In Lista.ListItems
                  If Len(oL.SubItems(6)) > 0 Then s = s & oL.SubItems(6) & vbCrLf
               Next
               If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
               mArchivoSalida = mvarPathArchivosExportados & "SUSS.TXT"
               If mConfirmarArchivo = "SI" Then
                  With CommonDialog1
                     .InitDir = mvarPathArchivosExportados
                     .Filename = mArchivoSalida
                     .ShowSave
                     If .CancelError Then Exit Sub
                     mArchivoSalida = .Filename
                  End With
               End If
               GuardarArchivoSecuencial mArchivoSalida, s
               MsgBox "Se ha generado el archivo : " & mArchivoSalida, vbInformation
         
            Case 43
               If ListaVacia Then Exit Sub
               
               mArchivoTxt = "PRUEBA"
               If Option3.Value Then
                  mArchivoTxt = "CABECERA_" & Format(Year(DTFields(0).Value), "0000") & Format(Month(DTFields(0).Value), "00")
                  mPos = 30
               ElseIf Option4.Value Then
                  mArchivoTxt = "DETALLE_" & Format(Year(DTFields(0).Value), "0000") & Format(Month(DTFields(0).Value), "00")
                  mPos = 15
               ElseIf Option5.Value Then
                  mArchivoTxt = "VENTAS_" & Format(Year(DTFields(0).Value), "0000") & Format(Month(DTFields(0).Value), "00")
                  mPos = 28
               ElseIf Option10.Value Then
                  mArchivoTxt = "COMPRAS_" & Format(Year(DTFields(0).Value), "0000") & Format(Month(DTFields(0).Value), "00")
                  mPos = 34
               ElseIf Option11.Value Then
                  mArchivoTxt = "OTRASPERCEP_" & Format(Year(DTFields(0).Value), "0000") & Format(Month(DTFields(0).Value), "00")
                  mPos = 8
               End If
               
               s = ""
               For Each oL In Lista.ListItems
                  If Len(oL.SubItems(mPos)) > 0 Then s = s & oL.SubItems(mPos) & vbCrLf
               Next
               If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
               mArchivoSalida = mvarPathArchivosExportados & mArchivoTxt & ".TXT"
               If mConfirmarArchivo = "SI" Then
                  With CommonDialog1
                     .InitDir = mvarPathArchivosExportados
                     .Filename = mArchivoSalida
                     .ShowSave
                     If .CancelError Then Exit Sub
                     mArchivoSalida = .Filename
                  End With
               End If
               GuardarArchivoSecuencial mArchivoSalida, s
               MsgBox "Se ha generado el archivo : " & mArchivoSalida, vbInformation
         
            Case 44
               If ListaVacia Then Exit Sub
               mCampo = BuscarClaveINI("Formato IIBB")
               If Len(mCampo) = 0 Then mCampo = "01"
               If mCampo = "01" Then
                  mProvincias = ""
                  For Each oL In Lista.ListItems
                     If Len(oL.SubItems(14)) > 0 Then
                        If InStr(1, mProvincias, oL.SubItems(14) & "?" & oL.SubItems(17)) = 0 Then
                           mProvincias = mProvincias & oL.SubItems(14) & "?" & oL.SubItems(17) & "|"
                        End If
                     End If
                  Next
                  mResultado = ""
                  mVectorProvincias = VBA.Split(mProvincias, "|")
                  For i = 0 To UBound(mVectorProvincias) - 1
                     mVectorAux = VBA.Split(mVectorProvincias(i), "?")
                     mStringAux = ""
                     s = ""
                     For Each oL In Lista.ListItems
                        If Len(oL.SubItems(14)) > 0 And mVectorAux(0) = oL.SubItems(14) And mVectorAux(1) = oL.SubItems(17) Then
                           mStringAux = oL.SubItems(18)
                           If Len(oL.SubItems(19)) > 0 Then s = s & oL.SubItems(19) & vbCrLf
                        End If
                     Next
                     If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
                     If Len(mStringAux) > 0 Then
                        mArchivoSalida = mvarPathArchivosExportados & "IIBB_" & mVectorAux(0) & " [" & mStringAux & "].txt"
                     Else
                        mArchivoSalida = mvarPathArchivosExportados & "IIBB_" & mVectorAux(0) & ".txt"
                     End If
                     mArchivoSalida = Replace(mArchivoSalida, "/", " ")
                     
                     If mConfirmarArchivo = "SI" Then
                        With CommonDialog1
                           .InitDir = mvarPathArchivosExportados
                           .Filename = mArchivoSalida
                           .ShowSave
                           If .CancelError Then Exit Sub
                           mArchivoSalida = .Filename
                        End With
                     End If
                     
                     GuardarArchivoSecuencial mArchivoSalida, s
                     mResultado = mResultado & vbCrLf & mArchivoSalida
                  Next
               Else
                  mResultado = "Datos.txt y RetPer.txt"
                  s = ""
                  For Each oL In Lista.ListItems
                     If Len(oL.SubItems(19)) > 0 Then s = s & oL.SubItems(19) & vbCrLf
                  Next
                  If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
                  mArchivoSalida = mvarPathArchivosExportados & "Datos.txt"
                  mArchivoSalida = Replace(mArchivoSalida, "/", " ")
                  If mConfirmarArchivo = "SI" Then
                     With CommonDialog1
                        .InitDir = mvarPathArchivosExportados
                        .Filename = mArchivoSalida
                        .ShowSave
                        If .CancelError Then Exit Sub
                        mArchivoSalida = .Filename
                     End With
                  End If
                  GuardarArchivoSecuencial mArchivoSalida, s
                  
                  Set oTab = Aplicacion.Proveedores.TraerFiltrado("_RetencionesIIBB_DatosProveedores", _
                              Array(DTFields(0).Value, DTFields(1).Value, mCampo))
                  s = ""
                  If oTab.RecordCount > 0 Then
                     oTab.MoveFirst
                     Do While Not oTab.EOF
                        If Not IsNull(oTab.Fields("A_Registro").Value) Then
                           s = s & oTab.Fields("A_Registro").Value & vbCrLf
                        End If
                        oTab.MoveNext
                     Loop
                     oTab.Close
                     Set oTab = Nothing
                  End If
                  If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
                  mArchivoSalida = mvarPathArchivosExportados & "RetPer.txt"
                  mArchivoSalida = Replace(mArchivoSalida, "/", " ")
                  If mConfirmarArchivo = "SI" Then
                     With CommonDialog1
                        .InitDir = mvarPathArchivosExportados
                        .Filename = mArchivoSalida
                        .ShowSave
                        If .CancelError Then Exit Sub
                        mArchivoSalida = .Filename
                     End With
                  End If
                  GuardarArchivoSecuencial mArchivoSalida, s
               End If
               MsgBox "Se ha generado el/los archivo/s : " & mResultado
         
            Case 45
               If ListaVacia Then Exit Sub
               s = ""
               For Each oL In Lista.ListItems
                  If Len(oL.SubItems(7)) > 0 Then s = s & oL.SubItems(7) & vbCrLf
               Next
               If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
               mArchivoSalida = mvarPathArchivosExportados & "RETSUSSCL.TXT"
               If mConfirmarArchivo = "SI" Then
                  With CommonDialog1
                     .InitDir = mvarPathArchivosExportados
                     .Filename = mArchivoSalida
                     .ShowSave
                     If .CancelError Then Exit Sub
                     mArchivoSalida = .Filename
                  End With
               End If
               GuardarArchivoSecuencial mArchivoSalida, s
               MsgBox "Se ha generado el archivo : " & mArchivoSalida, vbInformation
         
            Case 46
               If ListaVacia Then Exit Sub
               s = ""
               For Each oL In Lista.ListItems
                  If Len(oL.SubItems(16)) > 0 Then s = s & oL.SubItems(16) & vbCrLf
               Next
               If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
               mArchivoSalida = mvarPathArchivosExportados & "RES_1547.TXT"
               If mConfirmarArchivo = "SI" Then
                  With CommonDialog1
                     .InitDir = mvarPathArchivosExportados
                     .Filename = mArchivoSalida
                     .ShowSave
                     If .CancelError Then Exit Sub
                     mArchivoSalida = .Filename
                  End With
               End If
               GuardarArchivoSecuencial mArchivoSalida, s
               MsgBox "Se ha generado el archivo : " & mArchivoSalida, vbInformation
         
            Case 47
               If ListaVacia Then Exit Sub
               mProvincias = ""
               For Each oL In Lista.ListItems
                  If Len(oL.SubItems(11)) > 0 Then
                     If InStr(1, mProvincias, oL.SubItems(11)) = 0 Then
                        mProvincias = mProvincias & oL.SubItems(11) & "|"
                     End If
                  End If
               Next
               mResultado = ""
               mVectorProvincias = VBA.Split(mProvincias, "|")
               For i = 0 To UBound(mVectorProvincias) - 1
                  s = ""
                  For Each oL In Lista.ListItems
                     If Len(oL.SubItems(11)) > 0 And mVectorProvincias(i) = oL.SubItems(11) Then
                        If Len(oL.SubItems(14)) > 0 Then s = s & oL.SubItems(14) & vbCrLf
                     End If
                  Next
                  If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
                  mArchivoSalida = mvarPathArchivosExportados & "PERCEPCION_IIBB_" & mVectorProvincias(i) & ".TXT"
                  If mConfirmarArchivo = "SI" Then
                     With CommonDialog1
                        .InitDir = mvarPathArchivosExportados
                        .Filename = mArchivoSalida
                        .ShowSave
                        If .CancelError Then Exit Sub
                        mArchivoSalida = .Filename
                     End With
                  End If
                  GuardarArchivoSecuencial mArchivoSalida, s
                  mResultado = mResultado & vbCrLf & mArchivoSalida
               Next
               MsgBox "Se ha generado el/los archivo/s : " & mResultado
         
            Case 48
               GenerarAsientoCierre
         
            Case 49
               GenerarAsientoApertura
         
            Case 50
               If ListaVacia Then Exit Sub
               mProvincias = ""
               For Each oL In Lista.ListItems
                  If Len(oL.SubItems(1)) > 0 Then
                     If InStr(1, mProvincias, oL.SubItems(1)) = 0 Then
                        mProvincias = mProvincias & oL.SubItems(1) & "|"
                     End If
                  End If
               Next
               mResultado = ""
               mVectorProvincias = VBA.Split(mProvincias, "|")
               For i = 0 To UBound(mVectorProvincias) - 1
                  s = ""
                  For Each oL In Lista.ListItems
                     If Len(oL.SubItems(1)) > 0 And mVectorProvincias(i) = oL.SubItems(1) Then
                        If Len(oL.SubItems(13)) > 0 Then s = s & oL.SubItems(13) & vbCrLf
                     End If
                  Next
                  If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
                  mArchivoSalida = mvarPathArchivosExportados & "RetencionesIIBB_" & mVectorProvincias(i) & "_SIFERE.TXT"
                  mArchivoSalida = Replace(mArchivoSalida, "/", " ")
                  If mConfirmarArchivo = "SI" Then
                     With CommonDialog1
                        .InitDir = mvarPathArchivosExportados
                        .Filename = mArchivoSalida
                        .ShowSave
                        If .CancelError Then Exit Sub
                        mArchivoSalida = .Filename
                     End With
                  End If
                  GuardarArchivoSecuencial mArchivoSalida, s
                  mResultado = mResultado & vbCrLf & mArchivoSalida
               Next
               MsgBox "Se ha generado el/los archivo/s : " & mResultado
         
            Case 84
               If ListaVacia Then Exit Sub
               mProvincias = ""
               For Each oL In Lista.ListItems
                  If Len(oL.SubItems(2)) > 0 Then
                     If InStr(1, mProvincias, oL.SubItems(1) & "-" & oL.SubItems(2)) = 0 Then
                        mProvincias = mProvincias & oL.SubItems(1) & "-" & oL.SubItems(2) & "|"
                     End If
                  End If
               Next
               mResultado = ""
               mVectorProvincias = VBA.Split(mProvincias, "|")
               For i = 0 To UBound(mVectorProvincias) - 1
                  mVectorAux = VBA.Split(mVectorProvincias(i), "-")
                  s = ""
                  For Each oL In Lista.ListItems
                     If mVectorAux(0) = oL.SubItems(1) And mVectorAux(1) = oL.SubItems(2) Then
                        If Len(oL.SubItems(14)) > 0 Then s = s & oL.SubItems(14) & vbCrLf
                     End If
                  Next
                  If Len(s) > 0 Then
                     s = mId(s, 1, Len(s) - 2)
                     mArchivoSalida = mvarPathArchivosExportados & "PercepcionesIIBB_Convenio_" & mVectorAux(0) & "_" & mVectorAux(1) & "_SIFERE.txt"
                     mArchivoSalida = Replace(mArchivoSalida, "/", " ")
                     If mConfirmarArchivo = "SI" Then
                        With CommonDialog1
                           .InitDir = mvarPathArchivosExportados
                           .Filename = mArchivoSalida
                           .ShowSave
                           If .CancelError Then Exit Sub
                           mArchivoSalida = .Filename
                        End With
                     End If
                     GuardarArchivoSecuencial mArchivoSalida, s
                     mResultado = mResultado & vbCrLf & mArchivoSalida
                  End If
               Next
               MsgBox "Se ha generado el/los archivo/s : " & mResultado
         
            Case 88
               If ListaVacia Then Exit Sub
               s = ""
               For Each oL In Lista.ListItems
                  If Len(oL.SubItems(13)) > 0 Then s = s & oL.SubItems(13) & vbCrLf
               Next
               If Len(s) > 0 Then s = mId(s, 1, Len(s) - 2)
               mArchivoSalida = mvarPathArchivosExportados & "PERC_IVA_CLI.TXT"
               If mConfirmarArchivo = "SI" Then
                  With CommonDialog1
                     .InitDir = mvarPathArchivosExportados
                     .Filename = mArchivoSalida
                     .ShowSave
                     If .CancelError Then Exit Sub
                     mArchivoSalida = .Filename
                  End With
               End If
               GuardarArchivoSecuencial mArchivoSalida, s
               MsgBox "Se ha generado el archivo : " & mArchivoSalida, vbInformation
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
      .Disparar = ActL3
      .Show , Me
   End With

End Sub

Private Sub DataCombo1_Change(Index As Integer)

   Dim oRs As ADOR.Recordset
   Select Case mvarId
      Case 51
         If Index = 1 And IsNumeric(DataCombo1(Index).BoundText) Then
            Set oRs = Aplicacion.Obras.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("FechaInicio").Value) And Not IsNull(oRs.Fields("FechaEntrega").Value) Then
                  DTFields(0).Value = oRs.Fields("FechaInicio").Value
                  DTFields(1).Value = oRs.Fields("FechaEntrega").Value
               End If
            End If
            oRs.Close
         End If
      Case 57
         If Index = 1 And IsNumeric(DataCombo1(Index).BoundText) Then
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then
               Text1.Text = IIf(IsNull(oRs.Fields("NumeroInventario").Value), "", oRs.Fields("NumeroInventario").Value)
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

   Degradado Me
   
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   Set ActL3 = Nothing
   If Not oF_BuscarPorCuit Is Nothing Then
      Unload oF_BuscarPorCuit
      Set oF_BuscarPorCuit = Nothing
   End If

End Sub

Private Sub Form_Resize()

   Ajustar

End Sub

Private Sub Lista_DblClick()

   If Not Lista.SelectedItem Is Nothing Then
      Select Case mvarId
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

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)

   If Button = vbRightButton Then
         If mvarId = 21 And Option14.Value Then
            PopupMenu MnuDetRub, , , , MnuDetRubA(0)
         ElseIf mvarId = 33 Then
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

Private Sub MnuDetRubA_Click(Index As Integer)

   Select Case Index
      Case 0
         If Not Lista.SelectedItem Is Nothing Then
            AsignarRubrosFinancieros
            cmd_Click 0
         End If
   End Select

End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      Select Case mvarId
         Case 26
            lblLabels(1).Visible = False
            Text1.Visible = False
            Text2.Visible = False
            cmdBuscarPorCuit.Visible = False
         Case 42, 51, 60, 91
            lblLabels(4).Visible = False
            DataCombo1(1).Visible = False
         Case 57, 62
            lblLabels(4).Visible = False
            DataCombo1(1).Visible = False
            Text1.Visible = False
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
         Case 43
            Frame1.Visible = False
            
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
               .Left = cmd(1).Left + cmd(1).Width + 10
               .Top = cmd(1).Top - 2
               .AutoSize = True
               .Caption = "Rubros : "
               .Visible = True
            End With
            With DataCombo1(0)
               .Left = lblLabels(2).Left
               .Top = lblLabels(2).Top + lblLabels(2).Height + 1
               .Width = cmd(1).Width * 2
               Set .RowSource = Aplicacion.Rubros.TraerLista
               .BoundColumn = "IdRubro"
               .Visible = True
            End With
            With Text1
               .Left = DataCombo1(0).Left + DataCombo1(0).Width + 10
               .Top = DataCombo1(0).Top
               .Width = cmd(1).Width * 3
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
               .Left = cmd(1).Left + cmd(1).Width + 10
               .Top = cmd(1).Top - 2
               .AutoSize = True
               .Caption = "Articulos : "
               .Visible = True
            End With
            With DataCombo1(0)
               .Left = lblLabels(2).Left
               .Top = lblLabels(2).Top + lblLabels(2).Height + 1
               .Width = cmd(1).Width * 4
               Set .RowSource = Aplicacion.Articulos.TraerLista
               .BoundColumn = "IdArticulo"
               .Visible = True
            End With
            With lblLabels(3)
               .Left = DataCombo1(0).Left + DataCombo1(0).Width + 10
               .Top = cmd(1).Top - 2
               .AutoSize = True
               .Caption = "Buscar : "
               .Visible = True
            End With
            With Text1
               .Left = DataCombo1(0).Left + DataCombo1(0).Width + 10
               .Top = DataCombo1(0).Top
               .Width = cmd(1).Width * 2
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
               .Left = cmd(1).Left + cmd(1).Width + 10
               .Top = cmd(1).Top - 2
               .AutoSize = True
               .Caption = "Descripcion del articulo : "
               .Visible = True
            End With
            With Text1
               .Left = lblLabels(2).Left
               .Top = lblLabels(2).Top + lblLabels(2).Height + 1
               .Width = cmd(1).Width * 4
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
               .Top = Frame6.Top
               .AutoSize = True
               .Caption = "Obras : "
               .Visible = True
            End With
            With DataCombo1(3)
               .Left = lblLabels(2).Left
               .Top = lblLabels(2).Top + lblLabels(2).Height + 1
               .Width = cmd(1).Width * 2
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
            Text1.Visible = True
            Text2.Visible = True
            cmdBuscarPorCuit.Visible = True
         Case 42, 51, 60, 91
            lblLabels(4).Visible = True
            DataCombo1(1).Visible = True
         Case 57, 62
            lblLabels(4).Visible = True
            DataCombo1(1).Visible = True
            Text1.Visible = True
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
         Case 43
            Frame1.Visible = False
            
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
         Case 43
            Frame1.Visible = False
            
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
         Case 43
            Frame1.Visible = True
            
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
                  If Len(Trim(Text1.Text)) <> 0 Then
                     Set oRs = Aplicacion.Articulos.TraerFiltrado("_Busca", Text1.Text)
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
         If Len(Trim(Text1.Text)) <> 0 Then
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorNumeroInventario", Text1.Text)
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
                        "FormatearTitulosGenericos|" & DTFields(1).Value & "|" & Text1.Text & "|" & glbEmpresa
'               Else
'                  ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, _
'                        "FormatearTitulosGenericos|" & DTFields(1).Value
'               End If
            ElseIf mvarId = 102 Then
               ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, _
                     "FormatearTituloIvaVentas|" & DTFields(1).Value & "|" & Text1.Text & "|" & glbEmpresa, mvarParametrosExcel
            ElseIf mvarId = 103 Then
               ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, _
                     "FormatearTituloIvaCompras1|" & DTFields(1).Value & "|" & Text1.Text & "|" & glbEmpresa, mvarParametrosExcel
            End If
            If Len(mAuxS1) > 0 Then mAuxS1 = "Columnas:" & mAuxS1
            With lblInfo
               .Top = cmd(1).Top
               .Left = cmd(1).Left + cmd(1).Width + 100
               .Width = cmd(1).Width * 5
               .Height = cmd(1).Height
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
                  "FormatearTitulosGenericos|" & DTFields(1).Value & "|" & Text1.Text & "|" & glbEmpresa
         ElseIf mvarId = 102 Then
            ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, _
                  "FormatearTituloIvaVentas|" & DTFields(1).Value & "|" & Text1.Text & "|" & glbEmpresa, mvarParametrosExcel
         ElseIf mvarId = 103 Then
            ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel, _
                  "FormatearTituloIvaCompras1|" & DTFields(1).Value & "|" & Text1.Text & "|" & glbEmpresa, mvarParametrosExcel
         Else
            ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel
         End If
   End Select

End Sub

Public Property Get IdComparativa() As Long

   IdComparativa = mIdComparativa
   
End Property

Public Property Let IdComparativa(ByVal vnewvalue As Long)

   mIdComparativa = vnewvalue
   
End Property

Public Property Get IdPresupuestoSeleccionado() As Long

   IdPresupuestoSeleccionado = mIdPresupuestoSeleccionado
   
End Property

Public Property Let IdPresupuestoSeleccionado(ByVal vnewvalue As Long)

   mIdPresupuestoSeleccionado = vnewvalue

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
      .Left = cmd(0).Left
      .Top = cmd(0).Top - 600
      .Caption = "Proveedores : "
      .Visible = True
   End With
   With DataCombo1(0)
      .Width = 3400
      .Left = cmd(0).Left + Frame1.Width + 300
      .Top = cmd(0).Top - 400
      Set .RowSource = Aplicacion.Proveedores.TraerFiltrado("_TodosParaCombo", Array("N", "T"))
      .Visible = True
   End With
   With DataCombo1(1)
      .Width = DataCombo1(0).Width
      .Left = DataCombo1(0).Left + DataCombo1(0).Width + 300
      .Top = cmd(0).Top - 400
      Set .RowSource = Aplicacion.Proveedores.TraerFiltrado("_TodosParaCombo", Array("N", "T"))
      .Visible = True
   End With
   With txtBuscar(0)
      .Width = 2000
      .Left = DataCombo1(0).Left + DataCombo1(0).Width - txtBuscar(0).Width
      .Top = DataCombo1(0).Top - DataCombo1(0).Height - 50
      .Visible = True
   End With
   With txtBuscar(1)
      .Width = txtBuscar(0).Width
      .Left = DataCombo1(1).Left + DataCombo1(1).Width - txtBuscar(1).Width
      .Top = DataCombo1(1).Top - DataCombo1(1).Height - 50
      .Visible = True
   End With
   With Label1(0)
      .Width = 600
      .Left = txtBuscar(0).Left - Label1(0).Width - 50
      .Top = DataCombo1(0).Top - DataCombo1(0).Height - 30
      .Caption = "Buscar:"
      .Visible = True
   End With
   With Label1(1)
      .Width = Label1(0).Width
      .Left = txtBuscar(1).Left - Label1(1).Width - 50
      .Top = DataCombo1(1).Top - DataCombo1(1).Height - 30
      .Caption = "Buscar:"
      .Visible = True
   End With
   With Frame4
      .Left = Me.Width / 2
      .Top = Toolbar1.Top + Toolbar1.Height + 50
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
      .Top = DataCombo1(0).Top + DataCombo1(0).Height + 100
      .Caption = "Desde codigo :"
      .Visible = True
   End With
   With Text1
      .Width = 1500
      .Left = lblLabels(3).Left + lblLabels(3).Width + 100
      .Top = DataCombo1(0).Top + DataCombo1(0).Height + 100
      .Visible = True
   End With
   With lblLabels(4)
      .Width = 1500
      .Left = DataCombo1(1).Left
      .Top = DataCombo1(1).Top + DataCombo1(1).Height + 100
      .Caption = "Hasta codigo :"
      .Visible = True
   End With
   With Text2
      .Width = 1500
      .Left = lblLabels(4).Left + lblLabels(4).Width + 100
      .Top = DataCombo1(1).Top + DataCombo1(1).Height + 100
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
      .Left = cmd(0).Left
      .Top = cmd(0).Top - 600
      .Caption = "Clientes : "
      .Visible = True
   End With
   With DataCombo1(0)
      .Width = 3400
      .Left = cmd(0).Left + Frame1.Width + 300
      .Top = cmd(0).Top - 400
      Set .RowSource = Aplicacion.Clientes.TraerLista
      .Visible = True
   End With
   With DataCombo1(1)
      .Width = DataCombo1(0).Width
      .Left = DataCombo1(0).Left + DataCombo1(0).Width + 300
      .Top = cmd(0).Top - 400
      Set .RowSource = Aplicacion.Clientes.TraerLista
      .Visible = True
   End With
   With txtBuscar(0)
      .Width = 2000
      .Left = DataCombo1(0).Left + DataCombo1(0).Width - txtBuscar(0).Width
      .Top = DataCombo1(0).Top - DataCombo1(0).Height - 50
      .Visible = True
   End With
   With txtBuscar(1)
      .Width = txtBuscar(0).Width
      .Left = DataCombo1(1).Left + DataCombo1(1).Width - txtBuscar(1).Width
      .Top = DataCombo1(1).Top - DataCombo1(1).Height - 50
      .Visible = True
   End With
   With Label1(0)
      .Width = 600
      .Left = txtBuscar(0).Left - Label1(0).Width - 50
      .Top = DataCombo1(0).Top - DataCombo1(0).Height - 30
      .Caption = "Buscar:"
      .Visible = True
   End With
   With Label1(1)
      .Width = Label1(0).Width
      .Left = txtBuscar(1).Left - Label1(1).Width - 50
      .Top = DataCombo1(1).Top - DataCombo1(1).Height - 30
      .Caption = "Buscar:"
      .Visible = True
   End With
   With Frame4
      .Left = Me.Width / 2
      .Top = Toolbar1.Top + Toolbar1.Height + 50
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
      .Top = cmd(2).Top
      .Left = cmd(2).Left + (cmd(2).Width * 1.5)
      .Width = cmd(2).Width * 4.5
      .Height = cmd(2).Height
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
      .Top = cmd(2).Top
      .Left = cmd(2).Left + (cmd(2).Width * 1.5)
      .Width = cmd(2).Width * 4.5
      .Height = cmd(2).Height
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
   
   Set oRs = Aplicacion.Cuentas.TraerFiltrado("_AsientoAperturaEjercicio", Text1.Text)
   
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
      
   Set oRs = Aplicacion.Cuentas.TraerFiltrado("_ResultadoCierreAnterior", Text1.Text)
   
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

Public Sub AbrirCuboIngresoEgresosPorObraEnExcel2()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      .Workbooks.Add (glbPathPlantillas & "\IngresoEgresosPorObra2_" & glbEmpresaSegunString & ".XLT")
      .Run "RefrescarEnlaceACubo", DTFields(0).Value, DTFields(1).Value
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
               oRs.Fields.Append mCampo, .Type, .DefinedSize, .Attributes
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
   Set oRsFinal = CopiarTodosLosRegistros(oRs)
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
         Set oF = New frmFacturas
      Case 2
         Set oF = New frmRecibos
      Case 3
         Set oF = New frmNotasDebito
      Case 4
         Set oF = New frmNotasCredito
      Case 5
         Set oF = New frmDevoluciones
      Case 10, 11, 13, 18, 19, 31, 34, 43
         Set oF = New frmComprobantesPrv
      Case 14
         Set oF = New frmDepositosBancarios
      Case 17
         Set oF = New frmOrdenesPago
      Case 28, 29
         Set oF = New frmValoresGastos
      Case 38
         Set oF = New frmAsientos
      Case 39
         Set oF = New FrmPlazosFijos
      Case 1001
         Set oF = New frmAcopios
      Case 1002
         Set oF = New frmLMateriales
      Case 1003
         Set oF = New frmRequerimientos
      Case 1004
         Set oF = New frmPedidos
      Case 1005
         Set oF = New frmComparativa
      Case 1006
         Set oF = New frmAjustesStock
      
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
         .Top = 100
         .Caption = "1er. nro. inv. :"
      End With
      With .Text1
         .Top = 100
         .Alignment = 1
         .Text = mCodigoInicial
         .Enabled = False
      End With
      .Width = .Width * 2.5
      .Height = .Height * 2.2
      With .Lista
         .Left = oF.Label1.Left
         .Top = 500
         .Width = 8500
         .Height = 3500
         .Visible = True
      End With
      With .cmd(0)
         .Top = 4100
         .Left = oF.Lista.Left
         .Caption = "Generar"
      End With
      .cmd(1).Top = 4100
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
      .Text1.Visible = False
      With .Label1
         .Caption = "Proveedor:"
         .Visible = True
      End With
      With .dcfields(0)
         .Left = oF.Text1.Left
         .Top = oF.Text1.Top
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
   Dim mDesdeAlfa As String, mHastaAlfa As String, mCampo As String, mCampo1 As String, mCampo2 As String, mCampo3 As String
   
   mActivaRango = -1
   If Option2.Value Then
      mActivaRango = 0
      mDesdeAlfa = Text1.Text
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
   mCampo2 = "NO"
   If BuscarClaveINI("Usar fecha de recepcion de comprobantes de proveedores para calcular fecha de vencimiento en deuda vencida") = "SI" Then mCampo2 = "SI"
   mCampo3 = "NO"
   If Option18.Value Then mCampo3 = "SI"
   
   GenerarCondicionesDeCompra
   
   If Check4.Value = 0 Then
      Set DeudaVencida = Aplicacion.CtasCtesA.TraerFiltrado("_DeudaVencida", _
                           Array(DTFields(0).Value, mActivaRango, mDesdeAlfa, mHastaAlfa, mSeñal, mSeñal1, mCampo, mCampo1, mCampo2, mCampo3))
   Else
      Set DeudaVencida = Aplicacion.CtasCtesA.TraerFiltrado("_DeudaVencidaPorMesCalendario", _
                           Array(DTFields(0).Value, mActivaRango, mDesdeAlfa, mHastaAlfa, mSeñal, mSeñal1, mCampo, mCampo1, mCampo2, mCampo3))
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

   Dim mvarOK As Boolean
   Dim mvarIdAutorizo As Long
   
   Dim oF As frmAutorizacion2
   Set oF = New frmAutorizacion2
   With oF
      .Sector = "Compras"
      .Show vbModal, Me
      mvarOK = .Ok
      mvarIdAutorizo = .IdAutorizo
   End With
   Unload oF
   Set oF = Nothing
   If Not mvarOK Then Exit Sub
   
   Dim oF1 As frmAsignarComoCumplido
   Dim oL As ListItem
   Dim oReq As ComPronto.Requerimiento
   Dim oDetR As ComPronto.DetRequerimiento
   Dim oRs1 As ADOR.Recordset
   Dim mvarIdDioPorCumplido As Long, mObservacion As String
   Dim i As Integer
   Dim Filas, Columnas
   
   Set oF1 = New frmAsignarComoCumplido
   With oF1
      .Show vbModal, Me
      mvarOK = .Ok
      If IsNumeric(.dcfields(1).BoundText) Then mvarIdDioPorCumplido = .dcfields(1).BoundText
      mObservacion = oF1.rchObservacionesCumplido.Text
   End With
   Unload oF1
   Set oF1 = Nothing
   If Not mvarOK Then Exit Sub
   
   Filas = VBA.Split(Lista.GetString, vbCrLf)
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      If IsNumeric(Columnas(3)) Then
         Set oReq = Aplicacion.Requerimientos.Item(Columnas(3))
         Set oDetR = oReq.DetRequerimientos.Item(Columnas(2))
         oDetR.Registro.Fields("Cumplido").Value = "SI"
         oDetR.Registro.Fields("IdAutorizoCumplido").Value = mvarIdAutorizo
         oDetR.Registro.Fields("IdDioPorCumplido").Value = mvarIdDioPorCumplido
         oDetR.Registro.Fields("FechaDadoPorCumplido").Value = Now
         oDetR.Registro.Fields("ObservacionesCumplido").Value = mObservacion
         oDetR.Registro.Fields("TipoDesignacion").Value = "CMP"
         oDetR.Modificado = True
         oReq.Guardar
         Set oDetR = Nothing
         Set oReq = Nothing
         Aplicacion.Tarea "Requerimientos_ActualizarEstado", Array(Columnas(3), 0)
      End If
   Next

   Set oRs1 = Nothing
   
End Sub

Public Property Get IdProveedor() As Integer

   IdProveedor = mvarIdProveedor

End Property

Public Property Let IdProveedor(ByVal vnewvalue As Integer)

   mvarIdProveedor = vnewvalue

End Property

Public Property Get IdPedido() As Integer

   IdPedido = mvarIdPedido

End Property

Public Property Let IdPedido(ByVal vnewvalue As Integer)

   mvarIdPedido = vnewvalue

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

Sub Ajustar()

   Dim Arriba As Long, Altura As Long, Ancho As Long
   
   Arriba = Toolbar1.Height
   Ancho = Me.ScaleWidth
   Altura = Me.ScaleHeight - Arriba - StatusBar1.Height
   
   On Error Resume Next
   
   With Lista
      .Width = Ancho - .Left
   End With

End Sub

Public Sub AsignarRubrosFinancieros()

   Dim oF As frm_Aux
   Dim mIdRubroContable As Integer
   Dim mOk As Boolean
   Dim iFilas As Integer
   Dim Filas, Columnas
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Asignacion de rubros financieros"
      .Text1.Visible = False
      .Label1.Caption = "Rubro :"
      With .dcfields(0)
         .Top = oF.Text1.Top
         .Left = oF.Text1.Left
         .Width = .Width * 2
         .BoundColumn = "IdRubroContable"
         Set .RowSource = Aplicacion.RubrosContables.TraerFiltrado("_ParaComboFinancierosTodos")
         .Visible = True
      End With
      .Width = .Width * 1.3
      .Show vbModal, Me
      mOk = .Ok
      mIdRubroContable = 0
      If IsNumeric(.dcfields(0).BoundText) Then mIdRubroContable = .dcfields(0).BoundText
   End With
   Unload oF
   Set oF = Nothing
   
   If Not mOk Then Exit Sub
   If mIdRubroContable = 0 Then
      MsgBox "No eligio el rubro a asignar", vbExclamation
      Exit Sub
   End If
   
   Filas = VBA.Split(Lista.GetString, vbCrLf)
   For iFilas = LBound(Filas) + 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(iFilas), vbTab)
      If IsNumeric(Columnas(2)) Then Aplicacion.Tarea "DetComprobantesProveedores_ActualizarDatos", Array(Columnas(2), mIdRubroContable)
   Next

End Sub
