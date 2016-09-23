VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmPresupuestoObrasArbol 
   Caption         =   "Presupuesto Obra - Etapa"
   ClientHeight    =   6420
   ClientLeft      =   60
   ClientTop       =   630
   ClientWidth     =   14955
   DrawWidth       =   2
   Icon            =   "frmPresupuestoObrasArbol.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   321
   ScaleMode       =   2  'Point
   ScaleWidth      =   747.75
   StartUpPosition =   2  'CenterScreen
   Begin MSHierarchicalFlexGridLib.MSHFlexGrid fGrid 
      Height          =   5055
      Left            =   3735
      TabIndex        =   17
      Top             =   810
      Width           =   5895
      _ExtentX        =   10398
      _ExtentY        =   8916
      _Version        =   393216
      Rows            =   3
      BackColorBkg    =   -2147483643
      _NumberOfBands  =   1
      _Band(0).Cols   =   2
   End
   Begin VB.PictureBox Picture1 
      Height          =   375
      Left            =   13275
      ScaleHeight     =   315
      ScaleWidth      =   405
      TabIndex        =   25
      Top             =   1125
      Visible         =   0   'False
      Width           =   465
   End
   Begin VB.CommandButton cmdLista 
      Caption         =   "X"
      Height          =   240
      Left            =   12690
      TabIndex        =   23
      Top             =   3060
      Visible         =   0   'False
      Width           =   195
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   14955
      _ExtentX        =   26379
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   15
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageKey        =   "Print"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel"
            Object.ToolTipText     =   "Salida a Excel"
            ImageKey        =   "Excel"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageKey        =   "Find"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Project"
            Object.ToolTipText     =   "Project"
            ImageKey        =   "Project"
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Importar"
            Object.ToolTipText     =   "Importar presupuesto desde Excel"
            ImageKey        =   "Importar"
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Informe"
            Object.ToolTipText     =   "Informe de consumos reales"
            ImageKey        =   "Informe"
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Comparativa"
            Object.ToolTipText     =   "Comparativa"
            ImageKey        =   "Comparativa"
         EndProperty
         BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button15 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel1"
            Object.ToolTipText     =   "Exportar grilla a Excel"
            ImageKey        =   "Excel"
         EndProperty
      EndProperty
      Begin VB.CheckBox Check1 
         Alignment       =   1  'Right Justify
         Caption         =   "Ver detalle de comprobantes"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   13410
         TabIndex        =   24
         Top             =   45
         Width           =   1275
      End
      Begin VB.CommandButton cmdPresupuestoNuevo 
         Caption         =   "Nuevo"
         Height          =   285
         Left            =   12105
         TabIndex        =   22
         Top             =   45
         Width           =   690
      End
      Begin VB.ComboBox Combo1 
         Height          =   315
         Left            =   11115
         TabIndex        =   21
         Text            =   "Combo1"
         Top             =   45
         Width           =   825
      End
      Begin VB.TextBox Text2 
         Alignment       =   2  'Center
         BackColor       =   &H80000000&
         BorderStyle     =   0  'None
         Height          =   240
         Left            =   13095
         Locked          =   -1  'True
         TabIndex        =   14
         Text            =   "al"
         Top             =   90
         Visible         =   0   'False
         Width           =   195
      End
      Begin MSComCtl2.DTPicker DTFields 
         Height          =   330
         Index           =   1
         Left            =   20000
         TabIndex        =   13
         Top             =   45
         Visible         =   0   'False
         Width           =   1470
         _ExtentX        =   2593
         _ExtentY        =   582
         _Version        =   393216
         CheckBox        =   -1  'True
         Format          =   59441153
         CurrentDate     =   36377
      End
      Begin MSComCtl2.DTPicker DTFields 
         Height          =   330
         Index           =   0
         Left            =   20000
         TabIndex        =   12
         Top             =   45
         Visible         =   0   'False
         Width           =   1470
         _ExtentX        =   2593
         _ExtentY        =   582
         _Version        =   393216
         CheckBox        =   -1  'True
         Format          =   59441153
         CurrentDate     =   36377
      End
      Begin VB.TextBox Text1 
         BackColor       =   &H80000000&
         BorderStyle     =   0  'None
         Height          =   240
         Left            =   10000
         Locked          =   -1  'True
         TabIndex        =   11
         Text            =   "Presupuesto :"
         Top             =   90
         Width           =   915
      End
      Begin VB.CheckBox Check4 
         Alignment       =   1  'Right Justify
         Caption         =   "Ver detalles"
         Height          =   285
         Left            =   20000
         TabIndex        =   9
         Top             =   45
         Visible         =   0   'False
         Width           =   1230
      End
      Begin VB.TextBox txtUltimaOpcion 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0FF&
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
         Left            =   3720
         TabIndex        =   8
         Top             =   45
         Width           =   5985
      End
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   1
      Left            =   4545
      TabIndex        =   18
      Tag             =   "PresupuestoObrasRubros"
      Top             =   5520
      Visible         =   0   'False
      Width           =   4380
      _ExtentX        =   7726
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdPresupuestoObraRubro"
      Text            =   ""
   End
   Begin VB.TextBox txtEdit 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   375
      Left            =   3480
      TabIndex        =   16
      Top             =   5280
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.PictureBox Split1 
      Height          =   50
      Left            =   0
      MousePointer    =   7  'Size N S
      ScaleHeight     =   2.25
      ScaleMode       =   2  'Point
      ScaleWidth      =   174.75
      TabIndex        =   7
      Top             =   2835
      Visible         =   0   'False
      Width           =   3500
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   4140
      Top             =   5805
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   11
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":1CCA
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":1DDC
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":1EEE
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":2000
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":2112
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":2224
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":2336
            Key             =   "Excel"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":2788
            Key             =   "Project"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":2D22
            Key             =   "Importar"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":32BC
            Key             =   "Informe"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":3856
            Key             =   "Comparativa"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   5175
      TabIndex        =   5
      Top             =   855
      Visible         =   0   'False
      Width           =   3075
      _ExtentX        =   5424
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin VB.CheckBox Check6 
      Alignment       =   1  'Right Justify
      Caption         =   "Una obra"
      Height          =   285
      Left            =   3960
      TabIndex        =   4
      Top             =   855
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.PictureBox Split 
      Height          =   3750
      Left            =   3510
      MousePointer    =   9  'Size W E
      ScaleHeight     =   187.5
      ScaleMode       =   2  'Point
      ScaleWidth      =   2.25
      TabIndex        =   0
      Top             =   1530
      Width           =   50
   End
   Begin MSComctlLib.ImageList img16 
      Left            =   3510
      Top             =   5805
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   12
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":4130
            Key             =   "Abierto1"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":4582
            Key             =   "Cerrado1"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":49D4
            Key             =   "Cerrado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":4E26
            Key             =   "Abierto"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":5278
            Key             =   "Obras"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":5812
            Key             =   "Etapas"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":5DAC
            Key             =   "Rubros"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":6346
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":68E0
            Key             =   "Opciones"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":6E7A
            Key             =   "Mano de obra"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":7754
            Key             =   "Equipos"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObrasArbol.frx":802E
            Key             =   "Materiales"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView ListaDetalle 
      Height          =   1185
      Left            =   10440
      TabIndex        =   2
      Top             =   5220
      Visible         =   0   'False
      Width           =   2085
      _ExtentX        =   3678
      _ExtentY        =   2090
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmPresupuestoObrasArbol.frx":85C8
      MultiSelect     =   0   'False
      OLEDragMode     =   1
      PictureAlignment=   5
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   3
      Top             =   6030
      Width           =   14955
      _ExtentX        =   26379
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   5
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   11245
            Key             =   "Mensaje"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   11245
            Picture         =   "frmPresupuestoObrasArbol.frx":85E4
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
            Object.Width           =   1535
            MinWidth        =   18
            TextSave        =   "4/11/2009"
            Key             =   "Fecha"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView ListaTeoricos 
      Height          =   1185
      Left            =   10440
      TabIndex        =   10
      Top             =   3915
      Visible         =   0   'False
      Width           =   2085
      _ExtentX        =   3678
      _ExtentY        =   2090
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmPresupuestoObrasArbol.frx":88FE
      MultiSelect     =   0   'False
      OLEDragMode     =   1
      PictureAlignment=   5
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.TreeView Arbol 
      Height          =   3390
      Left            =   0
      TabIndex        =   15
      Top             =   2790
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   5980
      _Version        =   393217
      HideSelection   =   0   'False
      Indentation     =   18
      LabelEdit       =   1
      LineStyle       =   1
      Style           =   7
      ImageList       =   "img16"
      Appearance      =   1
      OLEDropMode     =   1
   End
   Begin MSComctlLib.TreeView ArbolOpciones 
      Height          =   1500
      Left            =   120
      TabIndex        =   6
      Top             =   1080
      Visible         =   0   'False
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   2646
      _Version        =   393217
      HideSelection   =   0   'False
      Indentation     =   18
      LabelEdit       =   1
      LineStyle       =   1
      Style           =   7
      ImageList       =   "img16"
      Appearance      =   1
      OLEDropMode     =   1
   End
   Begin Controles1013.DbListView Lista 
      Height          =   4920
      Left            =   5400
      TabIndex        =   19
      Top             =   1080
      Visible         =   0   'False
      Width           =   6720
      _ExtentX        =   11853
      _ExtentY        =   8678
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmPresupuestoObrasArbol.frx":891A
      MultiSelect     =   0   'False
      OLEDragMode     =   1
      PictureAlignment=   5
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSHierarchicalFlexGridLib.MSHFlexGrid gridComparativa 
      Height          =   5055
      Left            =   0
      TabIndex        =   20
      Top             =   0
      Width           =   5895
      _ExtentX        =   10398
      _ExtentY        =   8916
      _Version        =   393216
      BackColorBkg    =   -2147483643
      _NumberOfBands  =   1
      _Band(0).Cols   =   2
   End
   Begin VB.Image Image1 
      Height          =   375
      Left            =   13320
      Top             =   1665
      Visible         =   0   'False
      Width           =   465
   End
   Begin VB.Menu MnuArch 
      Caption         =   "Archivo"
      Enabled         =   0   'False
      Index           =   0
      Begin VB.Menu MnuArchA 
         Caption         =   "Exportar a Excel"
         Index           =   0
      End
      Begin VB.Menu MnuArchA 
         Caption         =   "Exportar a MSProject"
         Index           =   1
      End
      Begin VB.Menu MnuArchA 
         Caption         =   "Imprimir"
         Index           =   2
      End
      Begin VB.Menu MnuArchA 
         Caption         =   "Buscar"
         Index           =   3
      End
   End
   Begin VB.Menu MnuCon 
      Caption         =   "Consultas"
      Enabled         =   0   'False
      Begin VB.Menu MnuConA 
         Caption         =   "Consumos reales"
         Index           =   0
      End
   End
   Begin VB.Menu MnuUti 
      Caption         =   "Utilidades"
      Enabled         =   0   'False
      Begin VB.Menu MnuUtiA 
         Caption         =   "Importar presupuesto desde Excel"
         Index           =   0
      End
   End
   Begin VB.Menu MnuDetT 
      Caption         =   "DetalleTeoricos"
      Visible         =   0   'False
      Begin VB.Menu MnuDetTA 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetTA 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetTA 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
   Begin VB.Menu MnuDetP 
      Caption         =   "Presupuestos"
      Enabled         =   0   'False
      Visible         =   0   'False
      Begin VB.Menu MnuDetPA 
         Caption         =   "Nueva base"
         Index           =   0
      End
      Begin VB.Menu MnuDetPA 
         Caption         =   "Eliminar"
         Index           =   1
      End
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Etapas"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar Etapa"
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
   Begin VB.Menu MnuDet1 
      Caption         =   "Consumos directos"
      Visible         =   0   'False
      Begin VB.Menu MnuDetB 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
End
Attribute VB_Name = "frmPresupuestoObrasArbol"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim WithEvents origen As PresupuestoObraNodo
Attribute origen.VB_VarHelpID = -1

Dim actL2 As ControlForm
Private mvarIdObra As Long, mvarCodigoPresupuesto As Long
Private Cant_Columnas As Integer, mvarCompara1 As Integer, mvarCompara2 As Integer
Private mFechaInicialObra As Date, mFechaFinalObra As Date
Private mvarSubTituloExcel As String, ultimaopcion As String, mObra As String, mvarCompara As String
Private mvarComparativaActiva As Boolean

Const COL_NODO = 0
Const COL_NODOPADRE = 1
Const COL_DESCRIPCION = 2
Const COL_ITEM = 3
Const COL_TIPO = 4
Const COL_CANTIDADAVAN = 14
Const COL_CANTIDAD = 6
Const COL_UNIMEDIDA = 7
Const COL_IMPORTE = 8
Const COL_ANO = 9
Const COL_DEPTH = 10
Const COL_LINEAGE = 11
Const COL_TOTAL = 12
Const COL_OBRA = 13
Const COL_IDARTICULO = 5

Const ANCHO_COL_ID = 0

Const TIPO_OBRA = 1
Const TIPO_PRESUPUESTO = 2
Const TIPO_ETAPA = 3
Const TIPO_ARTICULO = 4
Const TIPO_RUBRO = 5

Sub Editar(ByVal Cual As Long)

   If Not IsNumeric(fGrid.TextMatrix(fGrid.row, COL_NODO)) Then
      MsgBox "Posicione el cursor en la etapa correspondiente al consumo que va a ingresar", vbExclamation
      Exit Sub
   End If
   
   Dim oF As frmPresupuestoObrasNodosCons
   
   Set oF = New frmPresupuestoObrasNodosCons
   With oF
      .IdPresupuestoObrasNodo = fGrid.TextMatrix(fGrid.row, COL_NODO)
      .Id = Cual
      .Show vbModal, Me
   End With
   Unload oF
   
   Set oF = Nothing
   
End Sub

Private Sub Check1_Click()

   If Check1.Value = 1 Then
      ListaDetalle.Visible = True
   Else
      Split1.Visible = False
      ListaDetalle.Visible = False
      cmdLista.Visible = False
   End If
   Ajustar

End Sub

Private Sub cmdLista_Click()

   Check1.Value = 0

End Sub

Private Sub cmdPresupuestoNuevo_Click()

   If Me.IdObra <= 0 Then
      MsgBox "Posicione el cursor en una obra antes de dar de alta un nuevo presupuesto", vbExclamation
      Exit Sub
   End If
   
   Dim mvarSeguro As Integer
   mvarSeguro = MsgBox("Desea agregar un nuevo presupuesto ?", vbYesNo, "Presupuesto nuevo")
   If mvarSeguro = vbNo Then Exit Sub
   
   Dim oF As frm_Aux
   Dim oRs As ADOR.Recordset
   Dim mOk As Boolean
   Dim mNuevoPresupuesto As Long, mPresupuestoOrigen As Long
   Dim mFecha As Date
   Dim mDetalle As String
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Nuevo presupuesto"
      .Text1.Text = ""
      .Label1.Caption = "Numero :"
      With .Label2(1)
         .Caption = "Tomar desde :"
         .Visible = True
      End With
      With .Combo1(0)
         .Left = oF.DTFields(1).Left
         .Top = oF.DTFields(1).Top
         .Width = oF.Text1.Width / 2
         Set oRs = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_PorCodigoPresupuesto", Me.IdObra)
         If oRs.RecordCount > 0 Then
            Do While Not oRs.EOF
               .AddItem "" & oRs.Fields("CodigoPresupuesto").Value
               oRs.MoveNext
            Loop
         End If
         oRs.Close
         .Visible = True
      End With
      With .Label2(0)
         .Caption = "Fecha :"
         .Top = oF.Label2(1).Top + oF.Label2(1).Height + 100
         .Visible = True
      End With
      With .DTFields(0)
         .Top = oF.Label2(0).Top
         .Value = Date
         .Visible = True
      End With
      With .Label2(2)
         .Caption = "Obra :"
         .Top = oF.Label2(0).Top + oF.Label2(0).Height + 100
         .Left = oF.Label2(0).Left
         .Visible = True
      End With
      With .Text2
         .Top = oF.Label2(2).Top
         .Left = oF.Text1.Left
         .Text = Me.Obra
         .Width = .Width * 3
         .Enabled = False
         .Visible = True
      End With
      With .Label2(3)
         .Caption = "Detalle :"
         .Top = oF.Label2(2).Top + oF.Label2(2).Height + 100
         .Left = oF.Label2(0).Left
         .Visible = True
      End With
      With .rchObservaciones
         .Top = oF.Label2(3).Top
         .Left = oF.Text1.Left
         .TextRTF = ""
         .Visible = True
      End With
      .cmd(0).Top = .rchObservaciones.Top + .rchObservaciones.Height + 100
      .cmd(1).Top = .cmd(0).Top
      .Width = .Width * 2
      .Height = .Height * 1.7
      .Show vbModal, Me
      mOk = .Ok
      If IsNumeric(.Text1.Text) Then mNuevoPresupuesto = Val(.Text1.Text)
      mPresupuestoOrigen = -1
      If Len(.Combo1(0).Text) > 0 Then mPresupuestoOrigen = Val(.Combo1(0).Text)
      mFecha = .DTFields(0).Value
      mDetalle = mId(.rchObservaciones.Text, 1, 200)
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then Exit Sub
   
   Aplicacion.Tarea "PresupuestoObrasNodos_CrearPresupuesto", Array(Me.IdObra, mNuevoPresupuesto, mPresupuestoOrigen, mFecha, mDetalle)
   
   Set oRs = Nothing
   
   If Not Arbol.SelectedItem Is Nothing Then Arbol_NodeClick Arbol.SelectedItem

End Sub

Private Sub Combo1_Click()

   If IsNumeric(Combo1.Text) Then
      If Val(Combo1.Text) <> mvarCodigoPresupuesto Then
         mvarCodigoPresupuesto = Combo1.Text
         MostrarNodo (0)
      End If
   End If

End Sub

Private Sub Form_Paint()
   
   Degradado Me

End Sub

Private Sub Form_Resize()
   
   Ajustar

End Sub

Private Sub Ajustar()

   Dim Arriba As Long, Altura As Long, Ancho As Long
   
   Arriba = Toolbar1.Height
   Ancho = Me.ScaleWidth
   Altura = Me.ScaleHeight - Arriba - StatusBar1.Height
   
   On Error Resume Next
   
   With Split
      .Top = Arriba
      .Height = Altura
   End With
   
   With Arbol
      .Left = 0
      .Top = Arriba
      .Height = Altura
      If Split.Left >= 0 Then .Width = Split.Left
   End With
   
   With fGrid
      .Top = Arriba
      If ListaDetalle.Visible Then
         .Height = Altura * 0.7
      Else
         .Height = Altura
      End If
      .Left = Arbol.Left + Arbol.Width + Split.Width
      .Width = Ancho - .Left
   End With

   If ListaDetalle.Visible Then
      With Split1
         If Not .Visible Then
            .Top = fGrid.Top + fGrid.Height
            .Visible = True
         End If
         .Left = fGrid.Left
         .Width = fGrid.Width
      End With
      With ListaDetalle
         .Top = Split1.Top + Split1.Height
         .Height = (Altura * 0.3) - Split1.Height
         .Left = fGrid.Left
         .Width = fGrid.Width
      End With
      With cmdLista
         .Top = ListaDetalle.Top
         .Left = ListaDetalle.Left + ListaDetalle.Width - .Width
         .Visible = True
      End With
   End If

End Sub

Private Sub CargarArbol()

   Dim oRs As ADOR.Recordset
   Dim mvarIdObra As Long, mIdEtapa As Long
   Dim Imagen As String, mver As String
   Dim mTipoConsumo As Integer, mpresu As Integer
   Dim oNode As Node
   
   mver = ultimaopcion
   
   On Error Resume Next
   
   Set oRs = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_ParaArbol")
   
   Arbol.Nodes.Clear
   If Lista.ColumnHeaders.Count > 0 Then
      Lista.ListItems.Clear
      Lista.ColumnHeaders.Clear
   End If
   
   With Arbol.Nodes
      .Add , , "O/", "OBRAS", "Obras", "Obras"
      mvarIdObra = 0
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If oRs!TipoNodo <> TIPO_ARTICULO And oRs!TipoNodo <> TIPO_RUBRO Then ' And ors!TipoNodo <> TIPO_PRESUPUESTO Then
               Select Case oRs!TipoNodo
                  Case TIPO_OBRA
                      Imagen = "Obras"
                  Case Else
                      Imagen = "Etapas"
               End Select
               .Add "O" & oRs!Lineage, tvwChild, "O" & oRs!Lineage & oRs!IdPresupuestoObrasNodo & "/", iisnull(oRs.Fields("Descripcion").Value, ""), Imagen
            End If
            oRs.MoveNext
         Loop
      End If
      .Item("O/").Expanded = True
   End With
   
   oRs.Close
   Set oRs = Nothing

End Sub

Private Sub Arbol_NodeClick(ByVal Node As MSComctlLib.Node)
    
   Dim oRs As ADOR.Recordset
   Dim mVector
   Dim mIdPresupuestoObrasNodo As Long
   mVector = VBA.Split(Node.Key, "/")

   If Len(Node.Key) > 0 Then
      If mVector(UBound(mVector) - 1) = "O" Then
         MostrarNodo (Null)
      Else
         mIdPresupuestoObrasNodo = mVector(UBound(mVector) - 1)
         Set oRs = Aplicacion.TablasGenerales.TraerUno("PresupuestoObrasNodos", mIdPresupuestoObrasNodo)
         If oRs.RecordCount > 0 Then
            Me.IdObra = IIf(IsNull(oRs.Fields("IdObra").Value), 0, oRs.Fields("IdObra").Value)
         End If
         oRs.Close
         MostrarNodo (mIdPresupuestoObrasNodo)
      End If
   End If
   
   If Not Node.Expanded Then Node.Expanded = True
   
   Set oRs = Nothing

End Sub

Private Sub CargarArbolOpciones()

   Dim oRs As ADOR.Recordset
   Dim n As Node
   Dim mCodigo As Integer
   
   ArbolOpciones.Nodes.Clear
   With ArbolOpciones.Nodes
      .Add , , "Ppal", "Opciones", "Opciones", "Opciones"
      .Add "Ppal", tvwChild, "Presupuesto", "Presupuesto", "Opciones", "Opciones"
      Set oRs = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_PorObraCodigoPresupuesto", mvarIdObra)
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            mCodigo = IIf(IsNull(oRs.Fields(0).Value), 0, oRs.Fields(0).Value)
            .Add "Presupuesto", tvwChild, "Presupuesto" & mCodigo, "Presupuesto " & mCodigo, "Opciones", "Opciones"
            oRs.MoveNext
         Loop
      End If
      oRs.Close
      .Add "Ppal", tvwChild, "ConsumosADistribuir", "Consumos a distribuir", "Opciones", "Opciones"
'      .Add "Ppal", tvwChild, "ConsumosPendientes", "Consumos pendientes", "Opciones", "Opciones"
      .Add "Ppal", tvwChild, "ConsumosTodos", "Consumos directos", "Opciones", "Opciones"
      .Add "Ppal", tvwChild, "Comparativo", "Comparativo", "Opciones", "Opciones"
      .Item("Ppal").Expanded = True
      .Item("Presupuesto").Expanded = True
   End With
   
   Set oRs = Nothing

End Sub

Private Sub mnuAgregarPresu_Click()
    
    Dim oRs As ADOR.Recordset
    Dim IdNododelaObra As Long
    
    Set oRs = Aplicacion.TablasGenerales.TraerTodos("PresupuestoObrasNodos")
    Do While Not oRs.EOF
        If mvarIdObra = oRs!IdObra Then Exit Do
        oRs.MoveNext
    Loop
    
    IdNododelaObra = oRs!IdPresupuestoObrasNodo
    
    Set oRs = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_PorObraCodigoPresupuesto", mvarIdObra)
    
    Dim X As PresupuestoObraNodo
    Set X = Aplicacion.PresupuestoObrasNodos.Item(IdNododelaObra)
    With X.Registro
        .Fields("Cantidad") = 0
        .Fields("Importe") = 0
        .Fields("CodigoPresupuesto") = oRs.RecordCount '+ 1
        .Fields("Mes") = 11
        .Fields("Año") = 2008
    
        X.Guardar
    End With

End Sub

Public Function ArbolPath() As String

   Dim s As String
   Dim i As Integer
   Dim n As Node
   Dim mVector
   
   s = ""
   If Not ArbolOpciones.SelectedItem Is Nothing Then
      s = ArbolOpciones.SelectedItem.Text
   End If
   
   If Len(s) > 0 Then
      mVector = VBA.Split(s, "|")
      s = mVector(0) & " / "
      For i = UBound(mVector) - 1 To 1 Step -1
         s = s & mVector(i) & " / "
      Next
      s = mId(s, 1, Len(s) - 3)
   End If
   ArbolPath = s

End Function

Private Sub Form_Load()

   With DTFields(0)
      .Value = DateSerial(Year(Date), Month(Date) - 1, 1)
      .Value = Null
   End With
   With DTFields(1)
      .Value = DateAdd("d", -1, DateAdd("m", 1, DateSerial(Year(Date), Month(Date) - 1, 1)))
      .Value = Null
   End With
   
   Cant_Columnas = 14
   mvarIdObra = -1
   mvarComparativaActiva = False
   
   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.PresupuestoObrasNodos.TraerTodos
   If oRs.RecordCount = 0 Then Aplicacion.Tarea "PresupuestoObrasNodos_Inicializar"
   oRs.Close
   
   Set DataCombo1(0).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasParaCombo")
   CargarArbol
   CargarArbolOpciones
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

   ConfiguraGrilla
   MostrarNodo (0)
   
   Set oRs = Nothing

End Sub

Sub MostrarNodo(Nodo As Variant)
    
    If IsNull(Nodo) Then Nodo = 0
    LlenarGrilla Nodo
    fGrid.ZOrder
    txtEdit.ZOrder

End Sub

Sub AgregarEtapa()
    
    EditarNodo -1, TIPO_ETAPA

End Sub

Sub AgregarItem()
    
    EditarNodo -1, TIPO_ARTICULO

End Sub

Sub EditarNodo(ByVal Cual As Long, Optional Tipo As Long)
   
   Dim oF As New frmPresupuestoObrasNodos
   Dim oL As ListItem
   Dim mVector
   
   With oF
      .IdPresupuestoObraNodo = Cual
      .IdObra = mvarIdObra
      .NodoPadre = IIf(fGrid.TextMatrix(2, COL_NODO) = "", 0, fGrid.TextMatrix(2, COL_NODO))
      .CodigoPresupuesto = mvarCodigoPresupuesto 'ArbolOpciones.SelectedItem.Key
      If Cual = -1 Then .Tipo = Tipo
      .Show vbModal, Me
   End With
   Unload oF
   Set oF = Nothing
   
   MostrarNodo (IIf(fGrid.TextMatrix(2, COL_NODO) = "", 0, fGrid.TextMatrix(2, COL_NODO)))
   CargarArbol

End Sub

Sub EliminarNodo()
    
    Dim oRs As ADOR.Recordset
    Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("PresupuestoObrasNodos", "_PorNodoPadre", Array(fGrid.TextMatrix(fGrid.row, COL_NODO)))
    If oRs.RecordCount > 1 Then
        MsgBox "La etapa no está vacía"
        Exit Sub
    End If
    
    Set origen = Aplicacion.PresupuestoObrasNodos.Item(fGrid.TextMatrix(fGrid.row, COL_NODO))
    origen.Eliminar
    
    MostrarNodo (IIf(fGrid.TextMatrix(2, COL_NODO) = "", 0, fGrid.TextMatrix(2, COL_NODO)))
    CargarArbol

End Sub

'////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////
'                       GRILLA
'http://msdn.microsoft.com/en-us/library/aa230201(VS.60).aspx
'Editing Cells in a Hierarchical FlexGrid Spreadsheet
'////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////

Function Fgi(r As Integer, c As Integer) As Integer
   
   Fgi = c + fGrid.Cols * r

End Function

Private Sub ListaDetalle_DblClick()

   If Len(ListaDetalle.SelectedItem.SubItems(1)) > 0 And Len(ListaDetalle.SelectedItem.SubItems(2)) > 0 Then
      EditarComprobante ListaDetalle.SelectedItem.SubItems(1), ListaDetalle.SelectedItem.SubItems(2)
   End If

End Sub

Private Sub ListaDetalle_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetB_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetB_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetB_Click 1
   End If

End Sub

Private Sub ListaDetalle_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If ListaDetalle.ListItems.Count = 0 Then
         MnuDetB(1).Enabled = False
         MnuDetB(2).Enabled = False
         PopupMenu MnuDet1, , , , MnuDetB(0)
      Else
         MnuDetB(1).Enabled = True
         MnuDetB(2).Enabled = True
         PopupMenu MnuDet1, , , , MnuDetB(1)
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         AgregarEtapa
      Case 1
         If fGrid.TextMatrix(fGrid.row, 2) = "[..]" Then
            MsgBox "Para modificar este item suba un nivel", vbInformation
         Else
            If fGrid.TextMatrix(fGrid.row, COL_DEPTH) > 0 Then
               EditarNodo (fGrid.TextMatrix(fGrid.row, COL_NODO))
            Else
               MsgBox "No puede modificar una obra, solo las etapas", vbInformation
            End If
         End If
      Case 2
         EliminarNodo
   End Select

End Sub

Private Sub MnuDetB_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         If Len(ListaDetalle.SelectedItem.SubItems(5)) > 0 Then
            MsgBox "Comprobante no editable, solo consumos directos", vbExclamation
            Exit Sub
         End If
         Editar ListaDetalle.SelectedItem.SubItems(1)
      Case 2
         If Val(ListaDetalle.SelectedItem.SubItems(1)) > 0 Then
            Aplicacion.PresupuestoObrasNodosCons.Item(ListaDetalle.SelectedItem.SubItems(1)).Eliminar
         End If
   End Select
   fGrid_Click

End Sub

Private Sub fGrid_KeyPress(KeyAscii As Integer)
    
   Dim i As Integer
   With fGrid
      If .col = COL_DESCRIPCION Then
         If KeyAscii = 13 Then fGrid_DblClick
      ElseIf KeyAscii = 6546 Then 'F7
         'AgregarNodo
      ElseIf (.col = COL_CANTIDAD Or .col = COL_IMPORTE) And .row >= 2 Then
         MSHFlexGridEdit fGrid, txtEdit, KeyAscii
      ElseIf .col > Cant_Columnas Then
         i = (.col - Cant_Columnas) Mod 4
         If i = 1 Then MSHFlexGridEdit fGrid, txtEdit, KeyAscii
      End If
   End With
    
End Sub

Private Sub fGrid_Click()

   If IsNumeric(fGrid.TextMatrix(fGrid.row, COL_NODO)) Then
      Dim mNode As Node
      Dim mVector
      For Each mNode In Arbol.Nodes
         If Len(mNode.Key) > 0 Then
            mVector = VBA.Split(mNode.Key, "/")
            If IsNumeric(mVector(UBound(mVector) - 1)) Then
               If fGrid.TextMatrix(fGrid.row, COL_NODO) = mVector(UBound(mVector) - 1) Then
                  Arbol.Nodes.Item(mNode.Key).EnsureVisible
                  Arbol.Nodes.Item(mNode.Key).Selected = True
                  Exit For
               End If
            End If
         End If
      Next
      If ListaDetalle.Visible Then
         Set ListaDetalle.DataSource = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_Consumos", fGrid.TextMatrix(fGrid.row, COL_NODO))
      End If
   End If

End Sub

Sub fGrid_DblClick()
    
   Dim linaje As String
   Dim n As MSComctlLib.Node
   Dim vector
   Dim Nodo As Long, i As Long

   On Error Resume Next
   
   With fGrid
      If .row = 2 Then
         'Ir para atrás
         If .TextMatrix(.row, COL_NODOPADRE) <> "" Then
            Nodo = .TextMatrix(.row, COL_NODOPADRE)
            linaje = .TextMatrix(.row, COL_LINEAGE)
            MostrarNodo (Nodo)
         End If
      Else
         If .TextMatrix(.row, COL_TIPO) = "<DIR>" Or .TextMatrix(.row, COL_DEPTH) <= 1 Then
            Nodo = .TextMatrix(.row, COL_NODO)
            linaje = "O" & .TextMatrix(.row, COL_LINEAGE) & .TextMatrix(.row, COL_NODO) & "/"
            MostrarNodo (Nodo)
         Else
            EditarNodo (fGrid.TextMatrix(fGrid.row, COL_NODO))
         End If
      End If
   End With
    
End Sub

Private Sub fGrid_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      With fGrid
         If .MouseRow < .Rows And .MouseCol < .Cols Then
             .row = .MouseRow
             .col = .MouseCol
         End If
         PopupMenu MnuDet, , , , MnuDetA(0)
      End With
   End If

End Sub

Sub MSHFlexGridEdit(MSHFlexGrid As Control, Edt As Control, KeyAscii As Integer)

   Select Case KeyAscii
      Case 0 To 32
         Edt = MSHFlexGrid
         Edt.SelStart = 1000
      Case Else
         Edt = Chr(KeyAscii)
         Edt.SelStart = 1
   End Select

   With MSHFlexGrid
      Edt.Move .Left + ScaleX(.CellLeft, vbTwips, .Container.ScaleMode), _
         .Top + ScaleY(.CellTop, vbTwips, .Container.ScaleMode), _
          ScaleX(.CellWidth - 8, vbTwips, .Container.ScaleMode), _
         ScaleY(.CellHeight - 8, vbTwips, .Container.ScaleMode)
   End With

   Edt.Visible = True
   Edt.SetFocus

End Sub

Private Sub Split_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbLeftButton Then
      With Split
         .Move .Left + X
      End With
   End If

End Sub

Private Sub Split_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbLeftButton Then Ajustar

End Sub

Private Sub Split1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

'   If Button = vbLeftButton Then
'      With Split1
'         .Move .Left, .Top + Y
'      End With
'   End If

End Sub

Private Sub Split1_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbLeftButton Then Ajustar

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Key
      Case "Imprimir"
         'InformePresupuesto1
      
      Case "Buscar"
         'FiltradoLista Lista
         'StatusBar1.Panels(2).Text = " " & Lista.ListItems.Count & " elementos en la lista"

      Case "Excel"
         InformePresupuesto1
      
      Case "Project"
         'Project
         
      Case "Importar"
         ImportacionPresupuesto
         
      Case "Informe"
         InformePresupuesto
      
      Case "Comparativa"
         Comparativa
   
      Case "Excel1"
         GrillaAExcel
      
   End Select

End Sub

Sub txtEdit_KeyPress(KeyAscii As Integer)
   
   ' Delete returns to get rid of beep.
   If KeyAscii = Asc(vbCr) Then KeyAscii = 0

End Sub

Sub txtEdit_KeyDown(KeyCode As Integer, Shift As Integer)
   
   EditKeyCode fGrid, txtEdit, KeyCode, Shift

End Sub

Sub EditKeyCode(MSHFlexGrid As Control, Edt As Control, KeyCode As Integer, Shift As Integer)

   ' Standard edit control processing.
   Select Case KeyCode
      Case 27   ' ESC: hide, return focus to MSHFlexGrid.
         Edt.Visible = False
         MSHFlexGrid.SetFocus
   
      Case 13   ' ENTER return focus to MSHFlexGrid.
         MSHFlexGrid.SetFocus
   
      Case 38      ' Up.
         MSHFlexGrid.SetFocus
         DoEvents
         If MSHFlexGrid.row > MSHFlexGrid.FixedRows Then
            MSHFlexGrid.row = MSHFlexGrid.row - 1
         End If
   
      Case 40      ' Down.
         MSHFlexGrid.SetFocus
         DoEvents
         If MSHFlexGrid.row < MSHFlexGrid.Rows - 1 Then
            MSHFlexGrid.row = MSHFlexGrid.row + 1
         End If
   End Select

End Sub

Sub fGrid_GotFocus()
   
   If txtEdit.Visible = False Then Exit Sub
   fGrid = txtEdit
   txtEdit.Visible = False
   SaveCellChange

End Sub

Sub fGrid_LeaveCell()
   
   If txtEdit.Visible = False Then Exit Sub
   fGrid = txtEdit
   txtEdit.Visible = False
   SaveCellChange

End Sub

Sub SaveCellChange()
    
   If fGrid.col = COL_CANTIDAD Or fGrid.col = COL_IMPORTE Then
      Set origen = Aplicacion.PresupuestoObrasNodos.Item(fGrid.TextMatrix(fGrid.row, COL_NODO))
      Select Case fGrid.col
          Case COL_CANTIDAD
              origen.Registro.Fields("Cantidad").Value = Val(txtEdit.Text)
          Case COL_IMPORTE
              origen.Registro.Fields("Importe").Value = Val(txtEdit.Text)
      End Select
      origen.Guardar
      Aplicacion.Tarea "PresupuestoObrasNodos_Recalcular", Array(fGrid.TextMatrix(fGrid.row, COL_NODO), mvarCodigoPresupuesto)
   
   ElseIf fGrid.col > Cant_Columnas Then
      Dim Mes As Integer, Año As Integer, Pos As Integer, i As Integer, j As Integer
      Dim C1 As Double, C2 As Double, I1 As Double, I2 As Double, mPrecio As Double, mCant As Double
      Dim mAvance As String
      
      C1 = -1
      C2 = -1
      I1 = -1
      I2 = -1
      
      Mes = mId(fGrid.TextMatrix(0, fGrid.col), 1, InStr(1, fGrid.TextMatrix(0, fGrid.col), "/") - 1)
      Año = mId(fGrid.TextMatrix(0, fGrid.col), InStr(1, fGrid.TextMatrix(0, fGrid.col), "/") + 1, 4)
      mAvance = fGrid.TextMatrix(fGrid.row, COL_CANTIDADAVAN)
      mPrecio = Val(fGrid.TextMatrix(fGrid.row, COL_IMPORTE))
      Pos = (fGrid.col - 1 - Cant_Columnas) Mod 4
      Select Case Pos
         Case 0
            C1 = Val(txtEdit.Text)
            If mAvance = "%" Then
               mPrecio = Val(fGrid.TextMatrix(fGrid.row, COL_TOTAL))
               I1 = Round(C1 / 100 * mPrecio, 2)
            Else
               I1 = Round(C1 * mPrecio, 2)
            End If
         Case 1
            I1 = Val(txtEdit.Text)
      End Select
      
      Aplicacion.Tarea "PresupuestoObrasNodos_ActualizarDetalles", Array(fGrid.TextMatrix(fGrid.row, COL_NODO), Mes, Año, I1, C1, I2, C2, mvarCodigoPresupuesto)
   End If

Salida:
   MostrarNodo (IIf(fGrid.TextMatrix(2, COL_NODO) = "", 0, fGrid.TextMatrix(2, COL_NODO)))

End Sub

Sub ConfiguraGrilla()
    
   Dim i As Integer, j As Integer, k As Integer, mCol As Integer
   Dim mFecha As Date
    
   With fGrid
      .FixedRows = 2
      .FixedCols = 0
      .Cols = Cant_Columnas + 1 + 144 + 1
      
      .MergeCells = flexMergeRestrictRows
      
      .ColWidth(COL_NODO) = ANCHO_COL_ID
      .ColWidth(COL_NODOPADRE) = ANCHO_COL_ID
      .ColWidth(COL_ANO) = ANCHO_COL_ID
      .ColWidth(COL_DEPTH) = ANCHO_COL_ID
      .ColWidth(COL_LINEAGE) = ANCHO_COL_ID
      .ColWidth(COL_OBRA) = ANCHO_COL_ID
      .ColWidth(COL_IDARTICULO) = 400
   
      .ColWidth(COL_ITEM) = 800
      .ColWidth(COL_DESCRIPCION) = 5000
      .ColWidth(COL_TIPO) = 800
      .ColWidth(COL_CANTIDADAVAN) = 400
      .ColWidth(COL_CANTIDAD) = 1200
      .ColWidth(COL_IMPORTE) = 1500
      .ColWidth(COL_UNIMEDIDA) = 400
      .ColWidth(COL_TOTAL) = 1500
      
      .TextMatrix(0, COL_NODO) = "Nodo"
      .TextMatrix(0, COL_NODOPADRE) = "Nodo padre"
      .TextMatrix(0, COL_ANO) = "Año"
      .TextMatrix(0, COL_DEPTH) = "Depth"
      .TextMatrix(0, COL_LINEAGE) = "Lineage"
      .TextMatrix(0, COL_DESCRIPCION) = "Descripción"
      .TextMatrix(0, COL_CANTIDADAVAN) = "Avance"
      .TextMatrix(0, COL_CANTIDAD) = "Cantidad"
      .TextMatrix(0, COL_IMPORTE) = "Precio"
      .TextMatrix(0, COL_UNIMEDIDA) = "Un."
      .TextMatrix(0, COL_TIPO) = "Tipo"
      .TextMatrix(0, COL_TOTAL) = "Total"
      .TextMatrix(0, COL_OBRA) = "IdObra"
      .TextMatrix(0, COL_ITEM) = "Item"
      .TextMatrix(0, COL_IDARTICULO) = "Rubro"
   
      .TextMatrix(0, .Cols - 1) = "Control 100%"
   
      .ColAlignment(COL_DESCRIPCION) = flexAlignLeftCenter
   
      For i = 1 To 36
         mFecha = DateAdd("m", i - 1, Me.FechaInicialObra)
         For j = 1 To 4
            mCol = (i - 1) * 4 + j
            Select Case j
               Case 1
                  .TextMatrix(0, mCol + Cant_Columnas) = "" & Month(mFecha) & "/" & Year(mFecha)
                  If mvarComparativaActiva Then
                     .TextMatrix(1, mCol + Cant_Columnas) = "Importe 1"
                     .ColWidth(mCol + Cant_Columnas) = 1400
                  Else
                     .TextMatrix(1, mCol + Cant_Columnas) = "% Distribucion"
                     For k = 2 To .Rows - 1
                        .row = k
                        .col = mCol + Cant_Columnas
                        .CellBackColor = &HFFFFC0
                     Next
                     .ColWidth(mCol + Cant_Columnas) = 700
                  End If
               Case 2
                  .TextMatrix(0, mCol + Cant_Columnas) = "" & Month(mFecha) & "/" & Year(mFecha)
                  If mvarComparativaActiva Then
                     .TextMatrix(1, mCol + Cant_Columnas) = "Importe 2"
                  Else
                     .TextMatrix(1, mCol + Cant_Columnas) = "Imp. Presupuesto"
                  End If
                  .ColWidth(mCol + Cant_Columnas) = 1400
               Case 3
                  .TextMatrix(0, mCol + Cant_Columnas) = "" & Month(mFecha) & "/" & Year(mFecha)
                  If mvarComparativaActiva Then
                     .TextMatrix(1, mCol + Cant_Columnas) = "Diferencia"
                     .ColWidth(mCol + Cant_Columnas) = 1400
                  Else
                     .TextMatrix(1, mCol + Cant_Columnas) = "Cant. Real"
                     For k = 2 To .Rows - 1
                        .row = k
                        .col = mCol + Cant_Columnas
                        .CellBackColor = &HC0FFC0
                     Next
                     .ColWidth(mCol + Cant_Columnas) = 700
                  End If
               Case 4
                  .TextMatrix(0, mCol + Cant_Columnas) = "" & Month(mFecha) & "/" & Year(mFecha)
                  If mvarComparativaActiva Then
                     .TextMatrix(1, mCol + Cant_Columnas) = "Desvio %"
                     .ColWidth(mCol + Cant_Columnas) = 700
                  Else
                     .TextMatrix(1, mCol + Cant_Columnas) = "Imp. Real"
                     For k = 2 To .Rows - 1
                        .row = k
                        .col = mCol + Cant_Columnas
                        .CellBackColor = &HE0E0E0
                     Next
                     .ColWidth(mCol + Cant_Columnas) = 1400
                  End If
            End Select
            If mFecha > Me.FechaFinalObra Then .ColWidth(mCol + Cant_Columnas) = 0
            .row = 0
            .col = mCol + Cant_Columnas
            .CellAlignment = flexAlignCenterCenter
         Next
      Next
      .MergeRow(0) = True
   End With

End Sub

Public Function LlenarGrilla(ByVal Nodo As Long) As Boolean

   On Error GoTo ErrorHandler

   Dim i As Integer, j As Integer, mCol As Integer, mIconoRubro As Integer
   Dim tempc As Long, tempr As Long, PosI_R As Long, PosI_C As Long, mPos As Long
   Dim mCant As Double, mCantidad1 As Double, mCantidad2 As Double, mImporte1 As Double, mImporte2 As Double
   Dim mDiferencia As Double, mDesvio As Double
   Dim EsRaiz As Boolean
   Dim mIcono As String
   Dim oRs As ADODB.Recordset
   Dim oRs1 As ADODB.Recordset

   Set oRs = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_PorCodigoPresupuesto", Me.IdObra)
   mPos = -1
   Combo1.Clear
   If oRs.RecordCount > 0 Then
      Do While Not oRs.EOF
         Combo1.AddItem "" & oRs.Fields("CodigoPresupuesto").Value
         If oRs.Fields("CodigoPresupuesto").Value = mvarCodigoPresupuesto Then mPos = oRs.AbsolutePosition - 1
         oRs.MoveNext
      Loop
   End If
   Combo1.ListIndex = mPos
   oRs.Close
   If mPos < 0 And Me.Visible Then
      MsgBox "Elija un codigo de presupuesto " & mvarCodigoPresupuesto & " para la obra " & Me.Obra, vbExclamation
      fGrid.Clear
   End If
   
   EsRaiz = False
   If Nodo = 0 Then EsRaiz = True

   Set oRs = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_PorNodo", Nodo)
   
   With fGrid
      PosI_R = .row
      PosI_C = .col
      
      .Redraw = False
      .Clear
   
      .Rows = 3
      If Not oRs.EOF Then
         If EsRaiz Then
            .Rows = oRs.RecordCount + 3
            i = 3
         Else
            .Rows = oRs.RecordCount + 2
            i = 2
         End If
         Do While Not oRs.EOF
            .TextMatrix(i, COL_NODO) = oRs.Fields("IdPresupuestoObrasNodo").Value
            .TextMatrix(i, COL_NODOPADRE) = iisnull(oRs.Fields("IdNodoPadre").Value, 0)
            .TextMatrix(i, COL_DEPTH) = oRs.Fields("Depth").Value
            .TextMatrix(i, COL_LINEAGE) = oRs.Fields("Lineage").Value
            .TextMatrix(i, COL_OBRA) = oRs.Fields("IdObra").Value
            .TextMatrix(i, COL_ITEM) = IIf(IsNull(oRs.Fields("Item").Value), "", oRs.Fields("Item").Value)
            .TextMatrix(i, COL_CANTIDAD) = iisnull(oRs.Fields("Cantidad").Value, 0)
            .TextMatrix(i, COL_UNIMEDIDA) = iisnull(oRs.Fields("Unidad").Value, "")
            .TextMatrix(i, COL_IMPORTE) = iisnull(oRs.Fields("Importe").Value, 0)
            .TextMatrix(i, COL_TOTAL) = iisnull(oRs.Fields("Cantidad").Value, 0) * iisnull(oRs.Fields("Importe").Value, 0)
            Select Case oRs.Fields("TipoNodo").Value
                Case TIPO_OBRA
                    .TextMatrix(i, COL_DESCRIPCION) = iisnull(oRs.Fields("DescripcionObra").Value, "")
                    .TextMatrix(i, COL_TIPO) = ""
                Case Else
                    .TextMatrix(i, COL_DESCRIPCION) = iisnull(oRs.Fields("Descripcion").Value, "")
                    .TextMatrix(i, COL_TIPO) = "<DIR>"
            End Select
            .TextMatrix(i, COL_CANTIDADAVAN) = iisnull(oRs.Fields("UnidadAvance1").Value, "")
            
            'mIconoRubro = BuscarImagenRubro(oRs.Fields("Rubro").Value)
            If Len(IIf(IsNull(oRs.Fields("Rubro").Value), "", oRs.Fields("Rubro").Value)) > 0 Then
               On Error Resume Next
               mIcono = glbPathPlantillas & "\..\Imagenes\" & oRs.Fields("Rubro").Value & ".ico"
               If Len(Trim(Dir(mIcono))) <> 0 Then
                  .row = i
                  .col = COL_IDARTICULO
                  Picture1.Width = .CellWidth
                  Picture1.Height = .CellHeight
                  Image1.Width = .CellWidth
                  Image1.Height = .CellHeight
                  Image1.Stretch = True
                  'Image1.Picture = img16.ListImages(mIconoRubro).Picture
                  Image1.Picture = LoadPicture(mIcono)
                  Picture1.AutoRedraw = True
                  Picture1.Cls
                  Picture1.PaintPicture Image1.Picture, 0, 0, Picture1.Width, Picture1.Height
                  Image1.Picture = LoadPicture("")
                  Picture1.AutoRedraw = False
                  Set .CellPicture = Picture1.Image
                  Picture1.Picture = LoadPicture("")
               End If
               On Error GoTo ErrorHandler
            End If
            
            If Me.IdObra > 0 Then
               mCant = 0
               If mvarComparativaActiva Then
                  Set oRs1 = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_DetallePxQ", _
                                 Array(oRs.Fields(0).Value, mvarCodigoPresupuesto, mvarCompara1, mvarCompara2))
               Else
                  Set oRs1 = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_DetallePxQ", Array(oRs.Fields(0).Value, mvarCodigoPresupuesto))
               End If
               If oRs1.RecordCount > 0 Then
                  Do While Not oRs1.EOF
                     j = DateDiff("m", Me.FechaInicialObra, DateSerial(oRs1.Fields("Año").Value, oRs1.Fields("Mes").Value, 1))
                     mCol = Cant_Columnas + (j * 4)
                     If mCol > .Cols Then
                        MsgBox "La obra tiene como fecha de inicio " & Me.FechaInicialObra & ", " & vbCrLf & _
                                 "y datos de presupuesto/consumo del mes " & oRs1.Fields("Mes").Value & "/" & oRs1.Fields("Año").Value & vbCrLf & _
                                 "que genera mas columnas de las soportadas por el sistema, revise los datos", vbExclamation
                        Exit Do
                     End If
                     If mCol >= 0 Then
                        mCant = mCant + IIf(IsNull(oRs1.Fields("Cantidad").Value), 0, oRs1.Fields("Cantidad").Value)
                        mCantidad1 = IIf(IsNull(oRs1.Fields("Cantidad").Value), 0, oRs1.Fields("Cantidad").Value)
                        mCantidad2 = IIf(IsNull(oRs1.Fields("CantidadReal").Value), 0, oRs1.Fields("CantidadReal").Value)
                        mImporte1 = IIf(IsNull(oRs1.Fields("Importe").Value), 0, oRs1.Fields("Importe").Value)
                        mImporte2 = IIf(IsNull(oRs1.Fields("ImporteReal").Value), 0, oRs1.Fields("ImporteReal").Value)
                        mDiferencia = mImporte1 - mImporte2
                        mDesvio = 0
                        If mImporte1 <> 0 Then mDesvio = Round(mDiferencia / mImporte1 * 100, 2)
                        If mvarComparativaActiva Then
                           .TextMatrix(i, mCol + 1) = IIf((mImporte1 = 0), "", mImporte1)
                           .TextMatrix(i, mCol + 2) = IIf((mImporte2 = 0), "", mImporte2)
                           .TextMatrix(i, mCol + 3) = IIf((mDiferencia = 0), "", mDiferencia)
                           .TextMatrix(i, mCol + 4) = IIf((mDesvio = 0), "", mDesvio)
                        Else
                           .TextMatrix(i, mCol + 1) = IIf((mCantidad1 = 0), "", mCantidad1)
                           .TextMatrix(i, mCol + 2) = IIf((mImporte1 = 0), "", mImporte1)
                           .TextMatrix(i, mCol + 3) = IIf((mCantidad2 = 0), "", mCantidad2)
                           .TextMatrix(i, mCol + 4) = IIf((mImporte2 = 0), "", mImporte2)
                        End If
                     End If
                     oRs1.MoveNext
                 Loop
               End If
               oRs1.Close
            End If
            
            If Not mvarComparativaActiva Then
               .TextMatrix(i, .Cols - 1) = mCant
               If mCant <> 100 And i > 2 Then
                  .row = i
                  .col = COL_TOTAL
                  .CellBackColor = &HC0C0FF
               End If
            End If
            
            i = i + 1
            oRs.MoveNext
         Loop
      End If
   
      ConfiguraGrilla
      .TextMatrix(2, COL_DESCRIPCION) = "[..]"
      .Redraw = True
      If PosI_R <= .Rows Then .row = PosI_R
      If PosI_C <= .Cols Then .col = PosI_C
      
      If mvarComparativaActiva Then
         txtUltimaOpcion.Text = "Comparativa : " & mvarCompara
      Else
         txtUltimaOpcion.Text = "Presupuesto " & mvarCodigoPresupuesto & "/" & Me.Obra
      End If
   End With
   oRs.Close

Salida:
   Set oRs = Nothing
   Set oRs1 = Nothing

   Exit Function

ErrorHandler:
   fGrid.Clear
   fGrid.Redraw = True
   Resume Salida

End Function

Public Function LlenarGrillaComparativa(rs As ADODB.Recordset) As Boolean

   On Error GoTo ErrorHandler
       
   Const COL_NODO = 0
   Const COL_NODOPADRE = 1
   Const COL_DESCRIPCION = 2
   Const COL_IDARTICULO = 3
   Const COL_TIPO = 4
   Const COL_CANTIDAD = 5
   Const COL_IMPORTE = 6
   Const COL_UNIMEDIDA = 7
   Const COL_ANO = 8
   Const COL_DEPTH = 9
   Const COL_LINEAGE = 10
   Const COL_TOTAL = 11
   Const COL_CANTAVANCE = 12
   Const COL_CANTTEOR = 13
   Const COL_CANTREAL = 14
   Const COL_CANTDESVIO = 15
   Const COL_IMPTEOR = 16
   Const COL_IMPREAL = 17
   Const COL_IMPDESVIO = 18
    
   Dim i As Integer
   Dim j As Integer
    
   With gridComparativa
      .Redraw = False
      .Clear
      .Cols = COL_IMPDESVIO + 1
      .Rows = 2
      .Rows = rs.RecordCount + 2
      i = 1
      Dim tempc As Long
      Dim tempr As Long
        
      If Not rs.EOF Then
         Do While Not rs.EOF
            .TextMatrix(i, COL_NODO) = rs.Fields("IdAux1").Value
            '.TextMatrix(i, COL_NODOPADRE) = iisnull(rs.Fields("IdNodoPadre").Value, 0)
            .TextMatrix(i, COL_DEPTH) = rs.Fields("Depth").Value
            .TextMatrix(i, COL_LINEAGE) = rs.Fields("Titulo").Value
            .TextMatrix(i, COL_IDARTICULO) = iisnull(rs.Fields("Material").Value, 0)
            .TextMatrix(i, COL_UNIMEDIDA) = iisnull(rs.Fields("Un.").Value, 0)
            
            Select Case rs.Fields("TipoNodo").Value
                Case TIPO_OBRA
                    .TextMatrix(i, COL_DESCRIPCION) = Space((rs.Fields!Depth - 1) * 7) & iisnull(rs.Fields("DescripcionObra").Value, "")
                    .TextMatrix(i, COL_TIPO) = ""
                Case TIPO_ETAPA
                    .TextMatrix(i, COL_DESCRIPCION) = Space((rs.Fields!Depth - 1) * 7) & iisnull(rs.Fields("Descripcion").Value, "")
                    .TextMatrix(i, COL_TIPO) = "<DIR>"
                Case TIPO_ARTICULO
                    If Not IsNull(rs.Fields("DescripcionArticulo")) Then
                        .TextMatrix(i, COL_DESCRIPCION) = Space((rs.Fields!Depth - 1) * 7) & iisnull(rs.Fields("DescripcionArticulo").Value, "")
                        .TextMatrix(i, COL_TIPO) = ""
                    Else
                        .TextMatrix(i, COL_DESCRIPCION) = Space((rs.Fields!Depth - 1) * 7) & iisnull(rs.Fields("DescArt").Value, "")
                        .TextMatrix(i, COL_TIPO) = ""
                    End If
                Case TIPO_RUBRO
                    If Not IsNull(rs.Fields("DescripcionRubro")) Then
                        .TextMatrix(i, COL_DESCRIPCION) = Space((rs.Fields!Depth - 1) * 7) & rs.Fields("DescripcionRubro").Value
                        .TextMatrix(i, COL_TIPO) = ""
                    Else
                        .TextMatrix(i, COL_DESCRIPCION) = Space((rs.Fields!Depth - 1) * 7) & iisnull(rs.Fields("DescRub").Value, "")
                        .TextMatrix(i, COL_TIPO) = ""
                    End If
            End Select
            .TextMatrix(i, COL_CANTAVANCE) = iisnull(rs.Fields("CantidadAvanzada").Value, 0)
            .TextMatrix(i, COL_CANTTEOR) = iisnull(rs.Fields("Cant.Teor.").Value, 0)
            .TextMatrix(i, COL_CANTREAL) = iisnull(rs.Fields("Cant.Real").Value, 0)
            .TextMatrix(i, COL_CANTDESVIO) = iisnull(rs.Fields("DesvioC").Value, "")
            .TextMatrix(i, COL_IMPTEOR) = iisnull(rs.Fields("Imp.Teor.").Value, "")
            .TextMatrix(i, COL_IMPREAL) = iisnull(rs.Fields("Imp.Real").Value, "")
            .TextMatrix(i, COL_IMPDESVIO) = iisnull(rs.Fields("DesvioI").Value, "")
                               
            If iisnull(.TextMatrix(i, COL_IMPDESVIO), 0) < 0 Then
                '.TextMatrix(i, COL_IMPDESVIO) = 0
                tempc = .col
                tempr = .row
                
                .row = i
                .col = COL_IMPDESVIO
                .CellBackColor = &HFF&
                
                .col = tempc
                .row = tempr
            ElseIf iisnull(.TextMatrix(i, COL_IMPDESVIO), 0) > 10 Then
                '.TextMatrix(i, COL_IMPDESVIO) = 0
                tempc = .col
                tempr = .row
                
                .row = i
                .col = COL_IMPDESVIO
                .CellBackColor = &H80FF80
                
                .col = tempc
                .row = tempr
            Else
                '.TextMatrix(i, COL_IMPDESVIO) = 0
                tempc = .col
                tempr = .row
                
                .row = i
                .col = COL_IMPDESVIO
                .CellBackColor = &HFFFF&
                
                .col = tempc
                .row = tempr
            End If
                
            If iisnull(.TextMatrix(i, COL_CANTDESVIO), 0) < 0 Then
                '.TextMatrix(i, COL_CANTDESVIO) = 0
                tempc = .col
                tempr = .row
                
                .row = i
                .col = COL_CANTDESVIO
                .CellBackColor = &HFF&
                
                .col = tempc
                .row = tempr
            ElseIf iisnull(.TextMatrix(i, COL_CANTDESVIO), 0) > 10 Then
                '.TextMatrix(i, COL_CANTDESVIO) = 0
                tempc = .col
                tempr = .row
                
                .row = i
                .col = COL_CANTDESVIO
                .CellBackColor = &H80FF80
                
                .col = tempc
                .row = tempr
            Else
                '.TextMatrix(i, COL_CANTDESVIO) = 0
                tempc = .col
                tempr = .row
                
                .row = i
                .col = COL_CANTDESVIO
                .CellBackColor = &HFFFF&
                
                .col = tempc
                .row = tempr
            End If
              
            i = i + 1
            rs.MoveNext
         Loop
            
      End If
        
      With gridComparativa
         .FixedRows = 1
         .FixedCols = 0
        
         .TextMatrix(0, COL_DESCRIPCION) = "Descripción"
         .TextMatrix(0, COL_CANTIDAD) = "Cantidad"
         .TextMatrix(0, COL_IMPORTE) = "Importe"
         .TextMatrix(0, COL_UNIMEDIDA) = "Un."
         .TextMatrix(0, COL_TIPO) = "Tipo"
         .TextMatrix(0, COL_IDARTICULO) = "Artículo"
         .TextMatrix(0, COL_TOTAL) = "Total"
                 
         .ColAlignment(COL_DESCRIPCION) = flexAlignLeftCenter
         .ColWidth(COL_NODO) = 0 '500
         .ColWidth(COL_NODOPADRE) = 0
         .ColWidth(COL_ANO) = 0
         .ColWidth(COL_DEPTH) = 0
         .ColWidth(COL_IDARTICULO) = 400
      
         .ColWidth(COL_LINEAGE) = 0
         
         .ColWidth(COL_DESCRIPCION) = 4000 '5000
         .ColWidth(COL_TIPO) = 0
         .ColWidth(COL_CANTIDAD) = 0
         .ColWidth(COL_IMPORTE) = 0
         .ColWidth(COL_UNIMEDIDA) = 400
         .ColWidth(COL_TOTAL) = 0
         
         .TextMatrix(0, COL_DESCRIPCION) = "Descripción"
         .TextMatrix(0, COL_CANTIDAD) = "Cantidad"
         .TextMatrix(0, COL_IMPORTE) = "Importe"
         .TextMatrix(0, COL_UNIMEDIDA) = "Un."
         .TextMatrix(0, COL_TIPO) = "Tipo"
         .TextMatrix(0, COL_IDARTICULO) = "Artículo"
         .TextMatrix(0, COL_TOTAL) = "Total"
         .TextMatrix(0, COL_CANTAVANCE) = "Avanzado"
         .TextMatrix(0, COL_CANTTEOR) = "Cant.Teor."
         .TextMatrix(0, COL_CANTREAL) = "Cant.Real"
         .TextMatrix(0, COL_CANTDESVIO) = "Desvío"
         .TextMatrix(0, COL_IMPTEOR) = "Imp.Teor."
         .TextMatrix(0, COL_IMPREAL) = "Imp.Real"
         .TextMatrix(0, COL_IMPDESVIO) = "Desvío"
      End With
        
      .Redraw = True
   End With
    
   Exit Function
    
ErrorHandler:
    Exit Function

End Function

Public Property Get IdObra() As Long

   IdObra = mvarIdObra

End Property

Public Property Let IdObra(ByVal vNewValue As Long)

   mvarIdObra = vNewValue
   
   Dim oRs As ADOR.Recordset
   Dim mFechaInicial As Date, mFechaFinal As Date
   
   mFechaInicial = Date
   mFechaFinal = Date
   If mvarIdObra > 0 Then
      Set oRs = Aplicacion.Obras.TraerFiltrado("_PorId", mvarIdObra)
      If oRs.RecordCount > 0 Then
         If Not IsNull(oRs.Fields("FechaInicio").Value) Then mFechaInicial = oRs.Fields("FechaInicio").Value
         If Not IsNull(oRs.Fields("FechaEntrega").Value) Then mFechaFinal = oRs.Fields("FechaEntrega").Value
         Me.Obra = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
      End If
      oRs.Close
   End If
   Me.FechaInicialObra = DateSerial(Year(mFechaInicial), Month(mFechaInicial), 1)
   Me.FechaFinalObra = mFechaFinal
   
   Set oRs = Nothing

End Property

Public Property Get Obra() As String

   Obra = mObra

End Property

Public Property Let Obra(ByVal vNewValue As String)

   mObra = vNewValue

End Property

Public Property Get FechaInicialObra() As Date

   FechaInicialObra = mFechaInicialObra

End Property

Public Property Let FechaInicialObra(ByVal vNewValue As Date)

   mFechaInicialObra = vNewValue

End Property

Public Property Get FechaFinalObra() As Date

   FechaFinalObra = mFechaFinalObra

End Property

Public Property Let FechaFinalObra(ByVal vNewValue As Date)

   mFechaFinalObra = vNewValue

End Property

Public Sub InformePresupuesto()

   Dim oF As frm_Aux
   Dim mIdObraListado As Long
   Dim mFechaInicial As Date, mFechaFinal As Date
   Dim mOk As Boolean
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Informe presupuesto"
      .Text1.Visible = False
      With .Check1
         .Top = oF.Label2(0).Top
         .Left = oF.Label2(0).Left
         .Width = oF.DTFields(0).Width * 1.5
         .Caption = "Todas las obras"
         .Visible = True
      End With
      .Label1.Caption = "Fecha inicial :"
      With .DTFields(0)
         .Top = oF.Text1.Top
         .Value = Date
         .Visible = True
      End With
      With .Label2(1)
         .Caption = "Fecha final :"
         .Visible = True
      End With
      With .DTFields(1)
         .Value = Date
         .Visible = True
      End With
      .Show vbModal, Me
      mOk = .Ok
      mIdObraListado = -1
      
      mFechaInicial = .DTFields(0).Value
      mFechaFinal = .DTFields(1).Value
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then Exit Sub
   
   Dim oEx As Excel.Application

   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      With .Workbooks.Add(glbPathPlantillas & "\Planilla.xlt")
         oEx.Run "GenerarInformePresupuesto1", glbStringConexion, "" & mIdObraListado & "|" & mFechaInicial & "|" & mFechaFinal
'         oEx.Run "PresupuestoObra_Comparativo1", glbStringConexion, Arbol.SelectedItem.Key & "|" & _
'                  mFechaInicial & "|" & mFechaFinal
      End With
   End With
   Set oEx = Nothing
   
End Sub

Public Sub InformePresupuesto1()

   If Me.IdObra <= 0 Then
      MsgBox "Haga click en alguna obra para la emision del informe", vbExclamation
      Exit Sub
   End If
   
   Dim oEx As Excel.Application

   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      With .Workbooks.Add(glbPathPlantillas & "\ComprasTerceros.xlt")
         oEx.Run "PresupuestoObrasNodos", glbStringConexion, "" & Me.IdObra & "|" & mvarCodigoPresupuesto
      End With
   End With
   Set oEx = Nothing
   
End Sub

Public Function BuscarImagenRubro(ByVal NombreIcono As String) As Integer

   Dim i As Integer, X As Integer
   
   X = -1
   For i = 1 To img16.ListImages.Count
      If UCase(img16.ListImages(i).Key) = UCase(NombreIcono) Then
         X = i
         Exit For
      End If
   Next
   
   BuscarImagenRubro = X

End Function

Public Sub ImportacionPresupuesto()

   Dim oRsAux1 As ADOR.Recordset
   Dim oEx As Excel.Application
   Dim oPresu As ComPronto.PresupuestoObraNodo
   Dim oF As Form
   Dim mOk As Boolean
   Dim mArchivo As String, mError As String, mError1 As String, mObra As String, mPadre As String, mDescripcion As String
   Dim mLineage As String, mFecha As String, mItem As String, mUnidadAvance As String, mUnidad As String
   Dim mPresupuestoObraRubro As String
   Dim fl As Integer, i As Integer, mMes As Integer, mAño As Integer, mCodigoPresupuesto As Integer, mDepth As Integer
   Dim mTipoNodo As Integer, mIdPresupuestoObraRubro As Integer
   Dim mIdObra As Long, mIdNodoPadre As Long, mIdArticulo As Long, mIdUnidad As Long, mIdPresupuestoObrasNodo As Long
   Dim mImporte As Double, mCantidad As Double, mPorcentaje As Double, mTotal As Double
   Dim mVector

'   On Error GoTo Mal

   Set oF = New frmPathPresto
   With oF
      .Id = 12
      .Show vbModal
      mOk = .Ok
      mArchivo = .FileBrowser1(0).Text
      mCodigoPresupuesto = Val(.Text1.Text)
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then Exit Sub

   Set oF = New frmAviso
   With oF
      .Label1 = "Iniciando EXCEL ..."
      .Show
      .Refresh
      DoEvents
   End With

   oF.Label1 = oF.Label1 & vbCrLf & "Importando presupuesto ..."
   oF.Label2 = ""
   oF.Label3 = ""
   DoEvents

   mError = ""
   
   Set oEx = CreateObject("Excel.Application")
   With oEx
      
      .Visible = True
      .WindowState = xlMinimized
      Me.Refresh
      
      With .Workbooks.Open(mArchivo)
         'oEx.Sheets("Hoja1").Select
         With .ActiveSheet
            fl = 4
            Do While True
               If Len(Trim(.Cells(fl, 1))) > 0 Then
                  mIdPresupuestoObrasNodo = -1
                  mObra = .Cells(fl, 1)
                  mItem = .Cells(fl, 2)
                  mDescripcion = .Cells(fl, 4)
                  mPresupuestoObraRubro = Trim(.Cells(fl, 5))
                  mUnidad = .Cells(fl, 6)
                  mCantidad = Val(.Cells(fl, 7))
                  If mCantidad = 0 Then mCantidad = 1
                  mTotal = Val(.Cells(fl, 8))
                  mImporte = mTotal / mCantidad
                  
                  oF.Label2 = "Obra : " & mObra
                  oF.Label3 = "Obra : " & mItem
                  DoEvents
                  
                  mError1 = ""
                  
                  Set oRsAux1 = Aplicacion.Obras.TraerFiltrado("_PorNumero", mObra)
                  mIdObra = 0
                  If oRsAux1.RecordCount > 0 Then
                     mIdObra = oRsAux1.Fields(0).Value
                     oRsAux1.Close
                     Set oRsAux1 = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_PorCodigoPresupuesto", mIdObra)
                     If oRsAux1.RecordCount = 0 Then
                        Aplicacion.Tarea "PresupuestoObrasNodos_CrearPresupuesto", Array(mIdObra, 0, -1, Date, "")
                     End If
                  Else
                     mError1 = mError1 & vbCrLf & "La obra " & mObra & " tiene un codigo inexistente"
                  End If
                  oRsAux1.Close
                  
                  mIdUnidad = 0
                  Set oRsAux1 = Aplicacion.Unidades.TraerFiltrado("_PorAbreviatura", mUnidad)
                  If oRsAux1.RecordCount > 0 Then mIdUnidad = oRsAux1.Fields(0).Value
                  oRsAux1.Close
                  
                  mIdPresupuestoObraRubro = 0
                  Set oRsAux1 = Aplicacion.PresupuestoObrasRubros.TraerFiltrado("_PorDescripcion", mPresupuestoObraRubro)
                  If oRsAux1.RecordCount > 0 Then mIdPresupuestoObraRubro = oRsAux1.Fields(0).Value
                  oRsAux1.Close
                  
                  If Len(mItem) = 0 Then
                     mError1 = mError1 & vbCrLf & "La fila " & fl & " tiene una etapa sin codigo de item"
                  Else
                     Set oRsAux1 = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_PorItem", Array(mItem, mIdObra))
                     If oRsAux1.RecordCount > 0 Then mIdPresupuestoObrasNodo = oRsAux1.Fields(0).Value
                     oRsAux1.Close
                  End If
                  
                  mPadre = .Cells(fl, 3)
                  mIdNodoPadre = 0
                  mDepth = 0
                  mLineage = "/"
                  mTipoNodo = 1
                  mUnidadAvance = "%"
                  If Len(mError1) = 0 Then
                     If Len(mPadre) > 10 Then
                        mError1 = mError1 & vbCrLf & "El item padre " & mPadre & " de la obra " & mObra & ", no puede tener mas de 10 digitos"
                     Else
                        If Len(mPadre) > 0 Then
                           Set oRsAux1 = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_PorItem", Array(mPadre, mIdObra))
                           If oRsAux1.RecordCount > 0 Then
                              mIdNodoPadre = oRsAux1.Fields(0).Value
                              mDepth = oRsAux1.Fields("Depth").Value + 1
                              mLineage = oRsAux1.Fields("Lineage").Value & mIdNodoPadre & "/"
                              mUnidadAvance = IIf(IsNull(oRsAux1.Fields("UnidadAvance").Value), "%", oRsAux1.Fields("UnidadAvance").Value)
                              mTipoNodo = 3
                           Else
                              mError1 = mError1 & vbCrLf & "El item padre " & mPadre & " de la obra " & mObra & ", no existe"
                           End If
                           oRsAux1.Close
                        Else
                           Set oRsAux1 = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_PorNodoPadre", Array(0, mIdObra))
                           If oRsAux1.RecordCount > 0 Then
                              mIdNodoPadre = oRsAux1.Fields(0).Value
                              mDepth = oRsAux1.Fields("Depth").Value + 1
                              mLineage = oRsAux1.Fields("Lineage").Value & mIdNodoPadre & "/"
                              mUnidadAvance = IIf(IsNull(oRsAux1.Fields("UnidadAvance").Value), "%", oRsAux1.Fields("UnidadAvance").Value)
                              mTipoNodo = 3
                           End If
                           oRsAux1.Close
                        End If
                     End If
                     
                     Set oPresu = Aplicacion.PresupuestoObrasNodos.Item(mIdPresupuestoObrasNodo)
                     With oPresu
                        With .Registro
                           If mIdNodoPadre > 0 Then .Fields("IdNodoPadre").Value = mIdNodoPadre
                           .Fields("Depth").Value = mDepth
                           .Fields("Lineage").Value = mLineage
                           .Fields("TipoNodo").Value = mTipoNodo
                           .Fields("IdObra").Value = mIdObra
                           .Fields("Descripcion").Value = mDescripcion
                           .Fields("Item").Value = mItem
                           .Fields("UnidadAvance").Value = mUnidadAvance
                           .Fields("Importe").Value = mImporte
                           .Fields("Cantidad").Value = mCantidad
                           .Fields("IdPresupuestoObraRubro").Value = mIdPresupuestoObraRubro
                           If mIdUnidad > 0 Then .Fields("IdUnidad").Value = mIdUnidad
                        End With
                        .Guardar
                        mIdPresupuestoObrasNodo = .Registro.Fields(0).Value
                     End With
                     Set oPresu = Nothing
                  
                     For i = 9 To 1000
                        mFecha = .Cells(3, i)
                        mMes = 0
                        mAño = 0
                        If Len(mFecha) > 0 Then
                           If InStr(1, mFecha, "/") > 0 Then
                              mVector = VBA.Split(mFecha, "/")
                              mMes = mVector(0)
                              mAño = mVector(1)
                           End If
                           mPorcentaje = Val(.Cells(fl, i))
                           If mMes >= 1 And mMes <= 12 And mAño > 2000 Then
                              mImporte = Round(mTotal * mPorcentaje / 100, 2)
                              If mImporte <> 0 Then
                                 Aplicacion.Tarea "PresupuestoObrasNodos_ActualizarDetalles", _
                                       Array(mIdPresupuestoObrasNodo, mMes, mAño, mImporte, mPorcentaje, 0, 0, mCodigoPresupuesto)
                              End If
                           Else
                              mError1 = mError1 & vbCrLf & "El periodo " & mFecha & " del item " & mItem & _
                                       " de la obra " & mObra & ", no tiene formato valido"
                           End If
                        Else
                           Exit For
                        End If
                     Next
                     
                     Aplicacion.Tarea "PresupuestoObrasNodos_Recalcular", Array(mIdPresupuestoObrasNodo, mCodigoPresupuesto)
                  End If
                  mError = mError & mError1
               Else
                  Exit Do
               End If
               fl = fl + 1
            Loop
         End With
         .Close False
      End With
      .Quit
   End With
   
Salida:
   Unload oF
   Set oF = Nothing

   If Len(mError) > 0 Then
      mError = "El proceso ha concluido con los siguientes errores :" & vbCrLf & mError
      Set oF = New frmConsulta1
      With oF
         .Id = 15
         oF.rchTexto.Text = mError
         .Show vbModal, Me
      End With
      Unload oF
      Set oF = Nothing
   End If

   Set oRsAux1 = Nothing
   Set oEx = Nothing

   Exit Sub

Mal:
   MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   Resume Salida

End Sub

Public Sub Comparativa()

   If mvarComparativaActiva Then
      mvarComparativaActiva = False
      MostrarNodo (IIf(fGrid.TextMatrix(2, COL_NODO) = "", 0, fGrid.TextMatrix(2, COL_NODO)))
      Toolbar1.Buttons("Comparativa").ToolTipText = "Comparativa"
      Exit Sub
   Else
      Toolbar1.Buttons("Comparativa").ToolTipText = "Cerrar comparativa"
   End If
   
   Dim oF As frm_Aux
   Dim oRs As ADOR.Recordset
   Dim m1 As Integer, m2 As Integer
   Dim mOk As Boolean
   
   Set oRs = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_PorCodigoPresupuesto", Me.IdObra)
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Comparativa presupuesto"
      .Text1.Visible = False
      .Label1.Caption = "Comparar :"
      With .Combo1(0)
         .Top = oF.Text1.Top
         .Left = oF.Text1.Left
         .Width = oF.DTFields(0).Width
         .Clear
         .AddItem "Real"
         If oRs.RecordCount > 0 Then
            oRs.MoveFirst
            Do While Not oRs.EOF
               .AddItem "Presupuesto " & oRs.Fields("CodigoPresupuesto").Value
               oRs.MoveNext
            Loop
         End If
         .Visible = True
      End With
      With .Label2(1)
         .Caption = "Con :"
         .Visible = True
      End With
      With .Combo1(1)
         .Top = oF.DTFields(1).Top
         .Left = oF.Combo1(0).Left
         .Width = oF.Combo1(0).Width
         .Clear
         .AddItem "Real"
         If oRs.RecordCount > 0 Then
            oRs.MoveFirst
            Do While Not oRs.EOF
               .AddItem "Presupuesto " & oRs.Fields("CodigoPresupuesto").Value
               oRs.MoveNext
            Loop
         End If
         .Visible = True
      End With
      .Show vbModal, Me
      mOk = .Ok
      m1 = .Combo1(0).ListIndex
      m2 = .Combo1(1).ListIndex
   End With
   Unload oF
   Set oF = Nothing
   
   mvarCompara = ""
   If m1 > 0 Then
      oRs.AbsolutePosition = m1
      m1 = oRs.Fields(0).Value
      mvarCompara1 = m1
      mvarCompara = "Presupuesto " & m1
   Else
      mvarCompara1 = -1
      mvarCompara = "Consumos reales"
   End If
   If m2 > 0 Then
      oRs.AbsolutePosition = m2
      m2 = oRs.Fields(0).Value
      mvarCompara2 = m2
      mvarCompara = mvarCompara & " con Presupuesto " & m2
   Else
      mvarCompara2 = -1
      mvarCompara = mvarCompara & " con Consumos reales"
   End If
   oRs.Close
   Set oRs = Nothing
   
   If Not mOk Then Exit Sub
   
   If m1 < 0 Or m2 < 0 Then
      MsgBox "Debe elegir los items a comparar!", vbExclamation
      Exit Sub
   End If
   
   mvarComparativaActiva = True
   
   MostrarNodo (IIf(fGrid.TextMatrix(2, COL_NODO) = "", 0, fGrid.TextMatrix(2, COL_NODO)))
   
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
      Case 9
         Set oF = New frmSalidasMateriales
      Case 10, 11, 13, 18, 19, 31, 34
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
      .Disparar = actL2
      .Show vbModal, Me
   End With

Salida:

   Set oF = Nothing

End Sub

Public Sub GrillaAExcel()

   Dim oEx As Excel.Application
   Dim i As Integer, X As Integer, x1 As Integer

   x1 = 0
   
   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      With .Workbooks.Add(glbPathPlantillas & "\Planilla.xlt")
         With .ActiveSheet
            For X = 1 To fGrid.Cols - 1
               If fGrid.ColWidth(X) > 0 Then
                  x1 = x1 + 1
                  .Cells(1, x1).Select
                  oEx.ActiveCell.ColumnWidth = fGrid.ColWidth(X) / 100
                  For i = 0 To fGrid.Rows - 1
                     .Cells(i + 1, x1) = fGrid.TextMatrix(i, X)
                  Next
               End If
            Next
         
            .Range(.Cells(1, 1), .Cells(fGrid.Rows, x1)).Select
            With oEx.Selection.Borders(xlEdgeLeft)
                .LineStyle = xlContinuous
                .Weight = xlThin
                .ColorIndex = xlAutomatic
            End With
            With oEx.Selection.Borders(xlEdgeTop)
                .LineStyle = xlContinuous
                .Weight = xlThin
                .ColorIndex = xlAutomatic
            End With
            With oEx.Selection.Borders(xlEdgeBottom)
                .LineStyle = xlContinuous
                .Weight = xlThin
                .ColorIndex = xlAutomatic
            End With
            With oEx.Selection.Borders(xlEdgeRight)
                .LineStyle = xlContinuous
                .Weight = xlThin
                .ColorIndex = xlAutomatic
            End With
            With oEx.Selection.Borders(xlInsideVertical)
                .LineStyle = xlContinuous
                .Weight = xlThin
                .ColorIndex = xlAutomatic
            End With
            With oEx.Selection.Borders(xlInsideHorizontal)
                .LineStyle = xlContinuous
                .Weight = xlThin
                .ColorIndex = xlAutomatic
            End With
            .Cells(1, 1).Select
         End With
      End With
   End With
   Set oEx = Nothing
   
End Sub
