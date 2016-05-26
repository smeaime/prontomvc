VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmPresupuestoObras 
   Caption         =   "Presupuesto Obra - Etapa"
   ClientHeight    =   6420
   ClientLeft      =   60
   ClientTop       =   630
   ClientWidth     =   15045
   DrawWidth       =   2
   Icon            =   "frmPresupuestoObras.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   321
   ScaleMode       =   2  'Point
   ScaleWidth      =   752.25
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check7 
      Alignment       =   1  'Right Justify
      Caption         =   "Ver detalles de presupuesto"
      Height          =   285
      Left            =   8370
      TabIndex        =   16
      Top             =   495
      Visible         =   0   'False
      Width           =   2400
   End
   Begin VB.PictureBox Split1 
      Height          =   50
      Left            =   0
      MousePointer    =   7  'Size N S
      ScaleHeight     =   2.25
      ScaleMode       =   2  'Point
      ScaleWidth      =   174.75
      TabIndex        =   13
      Top             =   2835
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
            Picture         =   "frmPresupuestoObras.frx":1CCA
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":1DDC
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":1EEE
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":2000
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":2112
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":2224
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":2336
            Key             =   "Excel"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":2788
            Key             =   "Project"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":2D22
            Key             =   "Importar"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":32BC
            Key             =   "Informe"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":3856
            Key             =   "ImportarHH"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   5175
      TabIndex        =   11
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
      TabIndex        =   10
      Top             =   855
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.CheckBox Check5 
      Alignment       =   1  'Right Justify
      Caption         =   "+ Consumos reales asignados"
      Enabled         =   0   'False
      Height          =   285
      Left            =   2655
      TabIndex        =   8
      Top             =   495
      Visible         =   0   'False
      Width           =   2400
   End
   Begin VB.CheckBox Check3 
      Alignment       =   1  'Right Justify
      Caption         =   "Comparativo Presupuesto - Consumos "
      Height          =   285
      Left            =   5175
      TabIndex        =   6
      Top             =   495
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Solo consumos pendientes"
      Enabled         =   0   'False
      Height          =   285
      Left            =   0
      TabIndex        =   5
      Top             =   855
      Visible         =   0   'False
      Width           =   2535
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Ver consumos reales a distribuir"
      Height          =   285
      Left            =   0
      TabIndex        =   3
      Top             =   495
      Visible         =   0   'False
      Width           =   2535
   End
   Begin VB.PictureBox Split 
      Height          =   3750
      Left            =   3510
      MousePointer    =   9  'Size W E
      ScaleHeight     =   187.5
      ScaleMode       =   2  'Point
      ScaleWidth      =   2.25
      TabIndex        =   2
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
         NumListImages   =   9
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":4130
            Key             =   "Abierto1"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":4582
            Key             =   "Cerrado1"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":49D4
            Key             =   "Cerrado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":4E26
            Key             =   "Abierto"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":5278
            Key             =   "Obras"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":5812
            Key             =   "Etapas"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":5DAC
            Key             =   "Rubros"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":6346
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPresupuestoObras.frx":68E0
            Key             =   "Opciones"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.TreeView Arbol 
      Height          =   3390
      Left            =   45
      TabIndex        =   0
      Top             =   2925
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   5980
      _Version        =   393217
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
      Left            =   3690
      TabIndex        =   1
      Top             =   1170
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
      MouseIcon       =   "frmPresupuestoObras.frx":6E7A
      MultiSelect     =   0   'False
      OLEDragMode     =   1
      PictureAlignment=   5
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   15045
      _ExtentX        =   26538
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   13
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
            Key             =   "ImportarHH"
            Object.ToolTipText     =   "Importar datos desde PRONTO SyJ"
            ImageKey        =   "ImportarHH"
         EndProperty
      EndProperty
      Begin VB.TextBox Text2 
         Alignment       =   2  'Center
         BackColor       =   &H80000000&
         BorderStyle     =   0  'None
         Height          =   240
         Left            =   13095
         Locked          =   -1  'True
         TabIndex        =   21
         Text            =   "al"
         Top             =   90
         Width           =   195
      End
      Begin MSComCtl2.DTPicker DTFields 
         Height          =   330
         Index           =   1
         Left            =   13320
         TabIndex        =   20
         Top             =   45
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
         Left            =   11610
         TabIndex        =   19
         Top             =   45
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
         Left            =   10620
         Locked          =   -1  'True
         TabIndex        =   18
         Text            =   "Periodo : del "
         Top             =   90
         Width           =   915
      End
      Begin VB.CheckBox Check4 
         Alignment       =   1  'Right Justify
         Caption         =   "Ver detalles"
         Height          =   285
         Left            =   3150
         TabIndex        =   15
         Top             =   45
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
         Left            =   4455
         TabIndex        =   14
         Top             =   45
         Width           =   6045
      End
   End
   Begin Controles1013.DbListView ListaDetalle 
      Height          =   1185
      Left            =   10440
      TabIndex        =   7
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
      MouseIcon       =   "frmPresupuestoObras.frx":6E96
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
      TabIndex        =   9
      Top             =   6030
      Width           =   15045
      _ExtentX        =   26538
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
            Picture         =   "frmPresupuestoObras.frx":6EB2
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
            TextSave        =   "14/11/2008"
            Key             =   "Fecha"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.TreeView ArbolOpciones 
      Height          =   1500
      Left            =   45
      TabIndex        =   12
      Top             =   1350
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   2646
      _Version        =   393217
      Indentation     =   18
      LabelEdit       =   1
      LineStyle       =   1
      Style           =   7
      ImageList       =   "img16"
      Appearance      =   1
      OLEDropMode     =   1
   End
   Begin Controles1013.DbListView ListaTeoricos 
      Height          =   1185
      Left            =   10440
      TabIndex        =   17
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
      MouseIcon       =   "frmPresupuestoObras.frx":71CC
      MultiSelect     =   0   'False
      OLEDragMode     =   1
      PictureAlignment=   5
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Menu MnuArch 
      Caption         =   "Archivo"
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
      Begin VB.Menu MnuConA 
         Caption         =   "Consumos reales"
         Index           =   0
      End
   End
   Begin VB.Menu MnuUti 
      Caption         =   "Utilidades"
      Begin VB.Menu MnuUtiA 
         Caption         =   "Importar presupuesto desde Excel"
         Index           =   0
      End
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar xxx"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar consumo directo"
         Index           =   1
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Modificar "
         Index           =   2
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   3
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
End
Attribute VB_Name = "frmPresupuestoObras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mvarIdObra As Long, mvarIdUnidadOperativa As Long
Private mvarFechaInicio As Date, mvarFechaFin As Date
Private mvarSubTituloExcel As String

Sub Editar(ByVal Cual As String)

   Dim oF As frmDetPresupuestoObras
   Dim oL As ListItem
   Dim mVector
   
   mVector = VBA.Split(Cual, "|")
   
   Set oF = New frmDetPresupuestoObras
   With oF
      .IdObra = mvarIdObra
      .IdDetalleObraDestino = mVector(1)
      .IdPresupuestoObraRubro = mVector(2)
      .Linea = Lista.GetString
      .FechaFin = mvarFechaFin
      .Show vbModal, Me
      If .Aceptado Then Arbol_NodeClick Arbol.SelectedItem
   End With
   Unload oF
   Set oF = Nothing
   
End Sub

Sub EditarConsumo(ByVal Cual As String)

   Dim oF As frmDetPresupuestoObrasConsumos
   Dim oL As ListItem
   Dim mVector
   
   mVector = VBA.Split(Cual, "|")
   
   Set oF = New frmDetPresupuestoObrasConsumos
   With oF
      .IdObra = mvarIdObra
      .IdArticulo = mVector(1)
      .IdPresupuestoObraConsumo = mVector(2)
      .IdDetalleObraDestino = mVector(3)
      .IdPresupuestoObraRubro = mVector(4)
      .Show vbModal, Me
      If .Aceptado Then Arbol_NodeClick Arbol.SelectedItem
   End With
   Unload oF
   Set oF = Nothing
   
End Sub

Sub EditarTeorico(ByVal Cual As String)

   Dim oF As frmDetPresupuestoObrasConsumosTeoricos
   Dim oL As ListItem
   Dim mVector
   
   mVector = VBA.Split(Cual, "|")
   
   Set oF = New frmDetPresupuestoObrasConsumosTeoricos
   With oF
      .IdPresupuestoObraConsumoTeorico = mVector(0)
      .IdDetalleObraDestino = mVector(1)
      .IdPresupuestoObraRubro = mVector(2)
      .CodigoPresupuesto = mVector(3)
      .Show vbModal, Me
   End With
   Unload oF
   Set oF = Nothing
   
   Lista_ItemClick Lista.SelectedItem
   
End Sub

Private Sub Arbol_NodeClick(ByVal Node As MSComctlLib.Node)

   Dim mver As String
   Dim mpresu As Integer
   
   txtUltimaOpcion.Text = ArbolPath
   
   mver = ""
   If Not ArbolOpciones.SelectedItem Is Nothing Then
      mver = ArbolOpciones.SelectedItem.Key
   End If
   
   If Lista.ColumnHeaders.Count > 0 Then
      Lista.ListItems.Clear
      Lista.ColumnHeaders.Clear
   End If
   
   Toolbar1.Buttons(7).Enabled = False
   
   If Len(Node.Key) > 0 Then
      Dim mAuxS1 As String, mAuxS2 As String
      Dim mVector
      mVector = VBA.Split(Node.Key, "|")
      If UBound(mVector) > 1 Then
         'Parametros :
         'IdObra
         'IdDetalleObraDestino
         'IdPresupuestoObraRubro
         Dim oRs As ADOR.Recordset
         
         If mId(mver, 1, 11) = "Presupuesto" Then
            mpresu = -1
            If Len(mver) > 11 Then
               mpresu = Val(mId(mver, 12, 2))
            ElseIf mVector(0) > 0 And mVector(1) = -1 Then
               mpresu = 0
            End If
            If mpresu >= 0 Then
               Toolbar1.Buttons(7).Enabled = True
               Set oRs = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObra", _
                           Array(mVector(0), mVector(1), mVector(2), mVector(4), mpresu))
            End If
         ElseIf mver = "ConsumosADistribuir" Then
            Set oRs = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObraConsumos", _
                        Array(mVector(1), mVector(2), mVector(4), "NO", "NO", mVector(3)))
         ElseIf mver = "ConsumosPendientes" Then
            Set oRs = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObraConsumos", _
                        Array(mVector(1), mVector(2), mVector(4), "SI", "NO", mVector(3)))
         ElseIf mver = "ConsumosTodos" Then
            Set oRs = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObraConsumos", _
                        Array(mVector(1), mVector(2), mVector(4), "NO", "SI", mVector(3)))
         ElseIf mver = "Pedidos" Then
            Set oRs = Aplicacion.PresupuestoObras.TraerFiltrado("_Pedidos", mVector(1))
         ElseIf mver = "Comparativo" Then
            Set oRs = Comparativo(mVector(1), mVector(2), mVector(4))
         End If
         
'         If Check1.Value = 0 Then
'            If Check3.Value = 0 Then
'               Toolbar1.Buttons(7).Enabled = True
'               Set oRs = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObra", _
'                           Array(mVector(0), mVector(1), mVector(2)))
'            Else
'               Set oRs = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObraComparativa", _
'                           Array(mVector(0), mVector(1), mVector(2)))
'            End If
'         Else
'            mAuxS1 = "SI"
'            If Check2.Value = 0 Then mAuxS1 = "NO"
'            mAuxS2 = "SI"
'            If Check5.Value = 0 Then mAuxS2 = "NO"
'            Set oRs = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObraConsumos", _
'                        Array(mVector(0), mVector(1), mVector(2), mAuxS1, mAuxS2))
'         End If
         If Not oRs Is Nothing Then Set Lista.DataSource = oRs
         Lista.Refresh
         Set oRs = Nothing
         If ListaDetalle.Visible Then ListaDetalle.ListItems.Clear
         If ListaTeoricos.Visible Then ListaTeoricos.ListItems.Clear
         
         If mvarIdUnidadOperativa <> mVector(0) Then mvarIdUnidadOperativa = mVector(0)
         If mvarIdObra <> mVector(1) Then
            mvarIdObra = mVector(1)
            CargarArbolOpciones
         Else
            mvarIdObra = mVector(1)
         End If
         ReemplazarColumnHeader
      Else
         If mId(mver, 1, 11) = "Presupuesto" Then
            Set oRs = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObra", Array(-1, -1, -1, -1, 0))
            If Not oRs Is Nothing Then Set Lista.DataSource = oRs
            Set oRs = Nothing
            ReemplazarColumnHeader
         End If
      End If
   End If

End Sub

Private Sub ArbolOpciones_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If mId(ArbolOpciones.SelectedItem.Text, 1, 11) = "Presupuesto" And Len(ArbolOpciones.SelectedItem.Text) = 11 Then
         MnuDetPA(0).Visible = True
         MnuDetPA(1).Visible = False
         PopupMenu MnuDetP, , , , MnuDetPA(0)
      ElseIf mId(ArbolOpciones.SelectedItem.Text, 1, 11) = "Presupuesto" And Len(ArbolOpciones.SelectedItem.Text) > 11 Then
         MnuDetPA(1).Visible = True
         MnuDetPA(0).Visible = False
         PopupMenu MnuDetP, , , , MnuDetPA(1)
      End If
   End If

End Sub

Private Sub ArbolOpciones_NodeClick(ByVal Node As MSComctlLib.Node)

   If Not Arbol.SelectedItem Is Nothing Then
      Arbol_NodeClick Arbol.SelectedItem
      txtUltimaOpcion.Text = ArbolPath
      If mId(Node.Text, 1, 11) = "Presupuesto" Then
         Check1.Value = 0
         Check7.Value = 1
      Else
         Check1.Value = 1
         Check7.Value = 0
      End If
      If mId(Node.Text, 1, 11) = "Presupuesto" Or Node.Text = "Comparativo" Then
         Check4.Value = 0
         Check4.Enabled = False
      Else
         Check4.Enabled = True
      End If
      Ajustar
   End If

End Sub

Private Sub Check1_Click()

'   If Check1.Value = 1 Then
'      Check2.Enabled = True
'      Check4.Enabled = True
'      Check5.Enabled = True
'      If Not Arbol.SelectedItem Is Nothing Then Arbol_NodeClick Arbol.SelectedItem
'   Else
'      If Lista.ColumnHeaders.Count > 0 Then
'         Lista.ListItems.Clear
'         Lista.ColumnHeaders.Clear
'      End If
'      Check2.Enabled = False
'      Check4.Enabled = False
'      Check5.Enabled = False
'   End If

End Sub

Private Sub Check2_Click()

'   If Not Arbol.SelectedItem Is Nothing Then Arbol_NodeClick Arbol.SelectedItem

End Sub

Private Sub Check3_Click()

'   If Check3.Value = 1 Then
'      With Check1
'         .Value = 0
'         .Enabled = False
'      End With
'      With Check2
'         .Value = 0
'         .Enabled = False
'      End With
'      With Check5
'         .Value = 0
'         .Enabled = False
'      End With
'      If Not Arbol.SelectedItem Is Nothing Then Arbol_NodeClick Arbol.SelectedItem
'   Else
'      If Lista.ColumnHeaders.Count > 0 Then
'         Lista.ListItems.Clear
'         Lista.ColumnHeaders.Clear
'      End If
'      Check1.Enabled = True
'   End If

End Sub

Private Sub Check4_Click()

   Ajustar

End Sub

Private Sub Check5_Click()

   If Not Arbol.SelectedItem Is Nothing Then Arbol_NodeClick Arbol.SelectedItem

End Sub

Private Sub Check6_Click()

   If Check6.Value = 1 Then
      DataCombo1(0).Enabled = True
   Else
      With DataCombo1(0)
         .BoundText = 0
         .Enabled = False
      End With
      mvarIdObra = -1
      CargarArbol
   End If

End Sub

Private Sub Check7_Click()

   Ajustar

End Sub

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(0).BoundText) Then
      mvarIdObra = DataCombo1(0).BoundText
      CargarArbol
   End If

End Sub

Private Sub Form_Load()

   With DTFields(0)
      .Value = DateSerial(Year(Date), Month(Date) - 1, 1)
      .Value = Null
   End With
   With DTFields(1)
      .Value = DateAdd("d", -1, DateAdd("m", 1, DateSerial(Year(Date), Month(Date) - 1, 1)))
      .Value = Null
   End With
   
   mvarIdUnidadOperativa = -1
   mvarIdObra = -1
   Set DataCombo1(0).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasParaCombo")
   CargarArbol
   CargarArbolOpciones
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me

End Sub

Private Sub Form_Resize()

   Ajustar

End Sub

Private Sub Lista_DblClick()

   If Not Lista.SelectedItem Is Nothing Then
      If Not ArbolOpciones.SelectedItem Is Nothing Then
         If ArbolOpciones.SelectedItem.Key = "Pedidos" Then
            MostrarComprobante 4, Lista.SelectedItem.SubItems(1)
            Exit Sub
         End If
      End If
      If Check1.Value = 0 Then
         Editar "" & mvarIdObra & "|" & Lista.SelectedItem.SubItems(1) & "|" & Lista.SelectedItem.SubItems(2)
      Else
         If Not IsNumeric(Lista.SelectedItem.SubItems(9)) Or Val(Lista.SelectedItem.SubItems(9)) = 0 Then
            MsgBox "Solo puede modificar un consumo", vbExclamation
            Exit Sub
         End If
         EditarConsumo "" & mvarIdObra & "|" & Lista.SelectedItem.SubItems(2) & "|" & Lista.SelectedItem.SubItems(9) & "|" & _
                  Lista.SelectedItem.SubItems(7) & "|" & Lista.SelectedItem.SubItems(8)
      End If
   End If

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_ItemClick(ByVal Item As MSComctlLib.IListItem)

   If ListaDetalle.Visible Then
      If Not ArbolOpciones.SelectedItem Is Nothing Then
         If ArbolOpciones.SelectedItem.Key = "Pedidos" Then
            Exit Sub
         End If
      End If
      
      Dim mIdArticulo As Long, mIdPresupuestoObraConsumo As Long
      mIdArticulo = -3
      If Len(Item.SubItems(2)) > 0 Then mIdArticulo = Val(Item.SubItems(2))
      mIdPresupuestoObraConsumo = 0
      If Len(Item.SubItems(9)) > 0 Then mIdPresupuestoObraConsumo = Val(Item.SubItems(9))
      
      If Len(Item.SubItems(7)) > 0 And Len(Item.SubItems(8)) > 0 And mIdPresupuestoObraConsumo = 0 And Len(Item.SubItems(10)) > 0 Then
         Set ListaDetalle.DataSource = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObraConsumos_Detalles", _
                  Array(mvarIdObra, mIdArticulo, Item.SubItems(7), Item.SubItems(8), Item.SubItems(10)))
      Else
         ListaDetalle.ListItems.Clear
      End If
   ElseIf ListaTeoricos.Visible Then
      Set ListaTeoricos.DataSource = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObraConsumosTeoricos_Detalles", _
               Array(Item.SubItems(1), Item.SubItems(2), Item.SubItems(3)))
   End If

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
      If Check1.Value = 0 Then
         MnuDetA(0).Caption = "Agregar presupuesto"
         MnuDetA(1).Enabled = False
      Else
         MnuDetA(0).Caption = "Agregar consumo por distribucion"
         MnuDetA(1).Enabled = True
      End If
      If Lista.ListItems.Count = 0 Then
         MnuDetA(2).Enabled = False
         MnuDetA(3).Enabled = False
         PopupMenu MnuDet, , , , MnuDetA(0)
      Else
         MnuDetA(2).Enabled = True
         MnuDetA(3).Enabled = True
         PopupMenu MnuDet, , , , MnuDetA(1)
      End If
   End If

End Sub

Private Sub ListaDetalle_DblClick()

   If Not ListaDetalle.SelectedItem Is Nothing Then
      If Len(Trim(ListaDetalle.SelectedItem.SubItems(1))) <> 0 Then
         MostrarComprobante ListaDetalle.SelectedItem.SubItems(1), ListaDetalle.SelectedItem.SubItems(2)
      End If
   End If

End Sub

Private Sub ListaDetalle_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaTeoricos_DblClick()

   MnuDetTA_Click 1

End Sub

Private Sub ListaTeoricos_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaTeoricos_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetTA_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetTA_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetTA_Click 1
   End If

End Sub

Private Sub ListaTeoricos_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If ListaTeoricos.ListItems.Count = 0 Then
         MnuDetTA(1).Enabled = False
         MnuDetTA(2).Enabled = False
         PopupMenu MnuDetT, , , , MnuDetTA(0)
      Else
         MnuDetTA(1).Enabled = True
         MnuDetTA(2).Enabled = True
         PopupMenu MnuDetT, , , , MnuDetTA(1)
      End If
   End If

End Sub

Private Sub MnuArchA_Click(Index As Integer)

   Select Case Index
      Case 0
         DatosObra
         ExportarAExcel Lista, Me.Caption & "   " & mvarSubTituloExcel
      Case 1
         Project
      Case 2
         DatosObra
         ImprimirConExcel Lista, Me.Caption & "   " & mvarSubTituloExcel
      Case 3
         FiltradoLista Lista
   End Select

End Sub

Private Sub MnuConA_Click(Index As Integer)

   Select Case Index
      Case 0
         InformePresupuesto
   End Select

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         If Check1.Value = 0 Then
            Editar "" & mvarIdObra & "|-1|-1"
         Else
            If Not Lista.SelectedItem Is Nothing Then
               If Not IsNumeric(Lista.SelectedItem.SubItems(2)) Or Val(Lista.SelectedItem.SubItems(2)) = 0 Then
                  MsgBox "Para ingresar un consumo haga boton derecho sobre el item del comprobante", vbExclamation
                  Exit Sub
               End If
               EditarConsumo "" & mvarIdObra & "|" & Lista.SelectedItem.SubItems(2) & "|-1|-1|-1"
            End If
         End If
      Case 1
         If Not Lista.SelectedItem Is Nothing Then
            EditarConsumo "" & mvarIdObra & "|-3|-1|-1|-1"
         End If
      Case 2
         If Not Lista.SelectedItem Is Nothing Then
            If Check1.Value = 0 Then
               Editar "" & mvarIdObra & "|" & Lista.SelectedItem.SubItems(1) & "|" & Lista.SelectedItem.SubItems(2)
            Else
               If Not IsNumeric(Lista.SelectedItem.SubItems(9)) Or Val(Lista.SelectedItem.SubItems(9)) = 0 Then
                  MsgBox "Solo puede modificar un consumo", vbExclamation
                  Exit Sub
               End If
               EditarConsumo "" & mvarIdObra & "|" & Lista.SelectedItem.SubItems(2) & "|" & Lista.SelectedItem.SubItems(9) & "|" & _
                        Lista.SelectedItem.SubItems(7) & "|" & Lista.SelectedItem.SubItems(8)
            End If
         End If
      Case 3
         If Not Lista.SelectedItem Is Nothing Then
            If Check1.Value = 0 Then
            Else
               If Not IsNumeric(Lista.SelectedItem.SubItems(9)) Or Val(Lista.SelectedItem.SubItems(9)) = 0 Then
                  MsgBox "Solo puede eliminar un consumo", vbExclamation
                  Exit Sub
               End If
               Aplicacion.Tarea "PresupuestoObrasConsumos_E", Lista.SelectedItem.SubItems(9)
               Arbol_NodeClick Arbol.SelectedItem
            End If
         End If
   
   End Select

End Sub

Private Sub MnuDetPA_Click(Index As Integer)

   Select Case Index
      Case 0
         NuevaBase
      Case 1
         BorrarBase
   End Select
End Sub

Private Sub MnuDetTA_Click(Index As Integer)

   Select Case Index
      Case 0
         If Not Lista.SelectedItem Is Nothing Then
            EditarTeorico "-1|" & Lista.SelectedItem.SubItems(1) & "|" & _
                        Lista.SelectedItem.SubItems(2) & "|" & Lista.SelectedItem.SubItems(3)
         Else
            MsgBox "No selecciono un item de presupuesto", vbInformation
         End If
      Case 1
         If Not ListaTeoricos.SelectedItem Is Nothing And Not Lista.SelectedItem Is Nothing Then
            EditarTeorico ListaTeoricos.SelectedItem.SubItems(1) & "|" & Lista.SelectedItem.SubItems(1) & "|" & _
                        Lista.SelectedItem.SubItems(2) & "|" & Lista.SelectedItem.SubItems(3)
         End If
      Case 2
         If Not ListaTeoricos.SelectedItem Is Nothing Then
            Aplicacion.Tarea "PresupuestoObras_BorrarTeoricos", ListaTeoricos.SelectedItem.SubItems(1)
            ListaTeoricos.ListItems.Remove (ListaTeoricos.object.SelectedItem.Index)
         End If
   
   End Select

End Sub

Private Sub MnuUtiA_Click(Index As Integer)

   Select Case Index
      Case 0
         ImportacionPresupuesto
   End Select

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

   If Button = vbLeftButton Then
      With Split1
         .Move .Left, .Top + Y
      End With
   End If

End Sub

Private Sub Split1_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbLeftButton Then
      Ajustar
   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Dim mOpcion As Integer
   
   Select Case Button.Key
      Case "Imprimir"
         DatosObra
         ImprimirConExcel Lista, Me.Caption & "   " & mvarSubTituloExcel
      
      Case "Buscar"
         FiltradoLista Lista
         'StatusBar1.Panels(2).Text = " " & Lista.ListItems.Count & " elementos en la lista"

      Case "Excel"
         mOpcion = 0
         If Not Arbol.SelectedItem Is Nothing And Not ArbolOpciones.SelectedItem Is Nothing Then
            If mId(ArbolOpciones.SelectedItem.Key, 1, 11) = "Presupuesto" And Len(ArbolOpciones.SelectedItem.Key) > 11 Then mOpcion = 1
            If ArbolOpciones.SelectedItem.Key = "ConsumosTodos" Then mOpcion = 2
         End If
         Select Case mOpcion
            Case 0
               DatosObra
               ExportarAExcel Lista, Me.Caption & "   " & mvarSubTituloExcel
            Case 1
               InformePresupuestoDetallado
            Case 2
               InformeConsumosDetallado
         End Select
      
      Case "Project"
         Project
         
      Case "Importar"
         ImportacionPresupuesto
         
      Case "Informe"
         InformePresupuesto

      Case "ImportarHH"
         ImportarHH

   End Select

End Sub

Public Sub InformePresupuesto()

   If Arbol.SelectedItem.Key = "Ppal" Then
      MsgBox "Haga click en una obra primero", vbInformation
      Exit Sub
   End If
   
   Dim oEx As Excel.Application
   Dim mFechaDesde As Date, mFechaHasta As Date
   
   mFechaDesde = 0
   If Not IsNull(DTFields(0).Value) Then mFechaDesde = DTFields(0).Value
   mFechaHasta = 0
   If Not IsNull(DTFields(1).Value) Then mFechaHasta = DTFields(1).Value
   
   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      With .Workbooks.Add(glbPathPlantillas & "\Planilla.xlt")
         oEx.Run "GenerarInformePresupuesto", glbStringConexion, "" & mvarIdObra & "|" & _
                  mFechaDesde & "|" & mFechaHasta
         oEx.Run "PresupuestoObra_Comparativo", glbStringConexion, Arbol.SelectedItem.Key & "|" & _
                  mFechaDesde & "|" & mFechaHasta
      End With
   End With
   Set oEx = Nothing
   
End Sub

Public Sub InformePresupuestoDetallado()

   If Arbol.SelectedItem Is Nothing And ArbolOpciones.SelectedItem Is Nothing Then Exit Sub
   
   Dim oEx As Excel.Application
   Dim mAux1 As String, mAux2 As String
   Dim mpresu As Integer
   Dim mVector
   
   mAux1 = ArbolOpciones.SelectedItem.Key
   mAux2 = Arbol.SelectedItem.Key
   If mAux2 = "Ppal" Then mAux2 = "-1|-1|-1|-1|-1"
   If Not (mId(mAux1, 1, 11) = "Presupuesto" And Len(mAux1) > 11) Then Exit Sub
      
   mpresu = Val(mId(mAux1, 12, 2))
      
   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      With .Workbooks.Add(glbPathPlantillas & "\Planilla.xlt")
         oEx.Run "GenerarInformePresupuestoDetallado", glbStringConexion, "" & mpresu & "|" & mAux2
      End With
   End With
   Set oEx = Nothing
   
End Sub

Public Sub InformeConsumosDetallado()

   If Arbol.SelectedItem Is Nothing And ArbolOpciones.SelectedItem Is Nothing Then Exit Sub
   
   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      With .Workbooks.Add(glbPathPlantillas & "\Planilla.xlt")
         oEx.Run "GenerarInformeConsumosDetallado", glbStringConexion, "" & mvarIdObra
      End With
   End With
   Set oEx = Nothing
   
End Sub

Public Sub DatosObra()

   Dim oRs As ADOR.Recordset
   
   Set oRs = Aplicacion.Obras.TraerFiltrado("_PorId", mvarIdObra)
   If oRs.RecordCount > 0 Then
      mvarSubTituloExcel = "Obra : " & IIf(IsNull(oRs.Fields("Descripcion").Value), oRs.Fields("NumeroObra").Value, oRs.Fields("Descripcion").Value)
   End If
   oRs.Close
   Set oRs = Nothing

End Sub

Public Sub Project()

   Dim oP As MSProject.Application
   Dim oL As ListItem
   Dim oS As ListSubItem
   Dim oRs As ADOR.Recordset
   Dim mFecha1 As Date, mFecha2 As Date
   Dim mEtapa As String
   Dim mPos As Integer
   
   mPos = 0
   
   Set oP = CreateObject("MSProject.Application")
   
   oP.Visible = True
   With oP.Projects.Add
      For Each oL In Lista.ListItems
         mEtapa = oL.Text & " - " & oL.SubItems(3)
         mFecha1 = 0
         mFecha2 = 0
         For Each oS In oL.ListSubItems
            If Lista.ColumnHeaders(oS.Index + 1).Width > 0 And IsNumeric(oS.Text) Then
               If Val(oS.Text) > 0 Then
                  If oS.Index > 4 And Val(oS.Text) > 0 Then
                     If mFecha1 = 0 Then
                        mFecha1 = DateSerial(Val(mId(Lista.ColumnHeaders(oS.Index + 1).Text, 5, 4)), _
                                             Val(NombreMesCortoRev(mId(Lista.ColumnHeaders(oS.Index + 1).Text, 1, 3))), 1)
                     End If
                     mFecha2 = DateSerial(Val(mId(Lista.ColumnHeaders(oS.Index + 1).Text, 5, 4)), _
                                          Val(NombreMesCortoRev(mId(Lista.ColumnHeaders(oS.Index + 1).Text, 1, 3))), 1)
                     mFecha2 = DateAdd("m", 1, mFecha2)
                     mFecha2 = DateAdd("d", -1, mFecha2)
                  End If
               End If
            End If
         Next
         If mFecha1 <> 0 Then
            With .Tasks.Add(mEtapa)
               .Start = "" & mFecha1
               .Finish = "" & mFecha2
            End With
         End If
      Next
   End With
   oP.ZoomTimescale Entire:=True
'   oP.Quit pjDoNotSave
   
   Set oP = Nothing
   Set oRs = Nothing

End Sub

Public Sub ImportacionPresupuesto()

   Dim oRsAux1 As ADOR.Recordset
   Dim oEx As Excel.Application
   Dim oF As Form
   Dim mOk As Boolean
   Dim mArchivo As String, mError As String, mObra As String, mDestino As String, mCodigo As String
   Dim mRubro As String, mFecha As String
   Dim fl As Integer, i As Integer, mMes As Integer, mAño As Integer, mCodigoPresupuesto As Integer
   Dim mIdObra As Long, mIdDetalleObraDestino As Long, mIdPresupuestoObraRubro As Long, mIdArticulo As Long
   Dim mIdUnidad As Long
   Dim mImporte As Double, mCantidad As Double, mPorcentaje As Double, mTotal As Double
   Dim mVector

   On Error GoTo Mal

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
         oEx.Sheets("Economico").Select
         With .ActiveSheet
            fl = 4
            Do While True
               If Len(Trim(.Cells(fl, 1))) > 0 Then
                  mObra = .Cells(fl, 1)
                  oF.Label2 = "Obra : " & mObra
                  DoEvents
                  
                  Set oRsAux1 = Aplicacion.Obras.TraerFiltrado("_PorNumero", mObra)
                  mIdObra = 0
                  If oRsAux1.RecordCount > 0 Then
                     mIdObra = oRsAux1.Fields(0).Value
                  Else
                     mError = mError & vbCrLf & "La obra " & mObra & " tiene un codigo inexistente"
                  End If
                  oRsAux1.Close
                  
                  mDestino = .Cells(fl, 2)
                  If Len(mDestino) <= 13 And mIdObra > 0 Then
                     Set oRsAux1 = Aplicacion.TablasGenerales.TraerFiltrado("DetObrasDestinos", "_PorCodigo", _
                                       Array(mIdObra, mDestino))
                     mIdDetalleObraDestino = 0
                     If oRsAux1.RecordCount > 0 Then
                        mIdDetalleObraDestino = oRsAux1.Fields(0).Value
                     Else
                        Aplicacion.Tarea "DetObrasDestinos_A", Array(-1, mIdObra, mDestino, mDestino, "NO")
                        Set oRsAux1 = Aplicacion.TablasGenerales.TraerFiltrado("DetObrasDestinos", "_PorCodigo", _
                                          Array(mIdObra, mDestino))
                        If oRsAux1.RecordCount > 0 Then mIdDetalleObraDestino = oRsAux1.Fields(0).Value
                     End If
                     oRsAux1.Close
                  Else
                     mError = mError & vbCrLf & "El codigo de destino " & mDestino & " de la obra " & mObra & ", no puede tener mas de 13 digitos"
                  End If
                  
                  mRubro = .Cells(fl, 3)
                  Set oRsAux1 = Aplicacion.PresupuestoObrasRubros.TraerFiltrado("_PorDescripcion", mRubro)
                  mIdPresupuestoObraRubro = 0
                  If oRsAux1.RecordCount > 0 Then
                     mIdPresupuestoObraRubro = oRsAux1.Fields(0).Value
                  Else
                     mError = mError & vbCrLf & "El rubro " & mRubro & " del destino " & mDestino & _
                              " de la obra " & mObra & ", no existe"
                  End If
                  oRsAux1.Close
                  
                  If mIdObra <> 0 And mIdDetalleObraDestino <> 0 And mIdPresupuestoObraRubro <> 0 Then
                     mTotal = Val(.Cells(fl, 4))
                     For i = 5 To 1000
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
                                 Aplicacion.Tarea "PresupuestoObras_Actualizar", _
                                       Array(mIdDetalleObraDestino, mIdPresupuestoObraRubro, mAño, mMes, _
                                             0, mImporte, 0, mCodigoPresupuesto)
                              End If
                           Else
                              mError = mError & vbCrLf & "El periodo " & mFecha & " del rubro " & mRubro & _
                                       " del destino " & mDestino & " de la obra " & mObra & ", no tiene formato valido"
                           End If
                        Else
                           Exit For
                        End If
                     Next
                     Aplicacion.Tarea "PresupuestoObras_ActualizarTotalPresupuesto", mIdObra
                  End If
               Else
                  Exit Do
               End If
               fl = fl + 1
            Loop
         End With
         
         oEx.Sheets("Detalle").Select
         With .ActiveSheet
            fl = 4
            Do While True
               If Len(Trim(.Cells(fl, 1))) > 0 Then
                  mObra = .Cells(fl, 1)
                  oF.Label2 = "Detalle - Obra : " & mObra
                  DoEvents
                  
                  Set oRsAux1 = Aplicacion.Obras.TraerFiltrado("_PorNumero", mObra)
                  mIdObra = 0
                  If oRsAux1.RecordCount > 0 Then
                     mIdObra = oRsAux1.Fields(0).Value
                  Else
                     mError = mError & vbCrLf & "La obra " & mObra & " tiene un codigo inexistente"
                  End If
                  oRsAux1.Close
                  
                  mDestino = .Cells(fl, 2)
                  If Len(mDestino) <= 13 And mIdObra > 0 Then
                     Set oRsAux1 = Aplicacion.TablasGenerales.TraerFiltrado("DetObrasDestinos", "_PorCodigo", _
                                       Array(mIdObra, mDestino))
                     mIdDetalleObraDestino = 0
                     If oRsAux1.RecordCount > 0 Then
                        mIdDetalleObraDestino = oRsAux1.Fields(0).Value
                     Else
                        Aplicacion.Tarea "DetObrasDestinos_A", Array(-1, mIdObra, mDestino, mDestino, "NO")
                        Set oRsAux1 = Aplicacion.TablasGenerales.TraerFiltrado("DetObrasDestinos", "_PorCodigo", _
                                          Array(mIdObra, mDestino))
                        If oRsAux1.RecordCount > 0 Then mIdDetalleObraDestino = oRsAux1.Fields(0).Value
                     End If
                     oRsAux1.Close
                  Else
                     mError = mError & vbCrLf & "El codigo de destino " & mDestino & " de la obra " & mObra & ", no puede tener mas de 13 digitos"
                  End If
                  
                  mRubro = .Cells(fl, 3)
                  Set oRsAux1 = Aplicacion.PresupuestoObrasRubros.TraerFiltrado("_PorDescripcion", mRubro)
                  mIdPresupuestoObraRubro = 0
                  If oRsAux1.RecordCount > 0 Then
                     mIdPresupuestoObraRubro = oRsAux1.Fields(0).Value
                  Else
                     mError = mError & vbCrLf & "El rubro " & mRubro & " del destino " & mDestino & _
                              " de la obra " & mObra & ", no existe"
                  End If
                  oRsAux1.Close
                  
                  mCodigo = .Cells(fl, 4)
                  Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", mCodigo)
                  mIdArticulo = 0
                  mIdUnidad = 0
                  If oRsAux1.RecordCount > 0 Then
                     mIdArticulo = oRsAux1.Fields(0).Value
                     mIdUnidad = IIf(IsNull(oRsAux1.Fields("IdUnidad").Value), 0, oRsAux1.Fields("IdUnidad").Value)
                  Else
                     mError = mError & vbCrLf & "El articulo " & mCodigo & " del rubro " & mRubro & _
                              " del destino " & mDestino & " de la obra " & mObra & ", no existe"
                  End If
                  oRsAux1.Close
                  
                  If mIdObra <> 0 And mIdDetalleObraDestino <> 0 And mIdPresupuestoObraRubro <> 0 And mIdArticulo <> 0 Then
                     mCantidad = Val(.Cells(fl, 5))
                     mImporte = Val(.Cells(fl, 6))
                     If mImporte > 0 Then
                        Aplicacion.Tarea "PresupuestoObras_ActualizarTeoricos", _
                              Array(-2, mIdDetalleObraDestino, mIdPresupuestoObraRubro, mCodigoPresupuesto, _
                                    mIdArticulo, mCantidad, mImporte, mIdUnidad)
                     End If
                  End If
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

Private Sub MostrarComprobante(ByVal TipoComprobante As Long, ByVal Identificador As Long)

   Dim oF As Form
      
   Select Case TipoComprobante
      Case 4
         Set oF = New frmPedidos
      Case 9
         Set oF = New frmSalidasMateriales
      Case 11
         Set oF = New frmComprobantesPrv
      Case 42
         Set oF = New frmAsientos
      Case Else
         MsgBox "Comprobante no editable", vbInformation
         Exit Sub
   End Select
   
   With oF
      .Id = Identificador
      .Disparar = ActL
      .Show vbModal, Me
   End With

Salida:

   Set oF = Nothing

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
   
   With Split1
      .Left = 0
      .Width = Split.Left
   End With
   
   With ArbolOpciones
      .Left = 0
      .Top = Arriba
      .Height = Split1.Top - Arriba
      If Split.Left >= 0 Then .Width = Split.Left
   End With
   
   With Arbol
      .Left = 0
      .Top = Arriba + ArbolOpciones.Height
      .Height = Altura - ArbolOpciones.Height
      If Split.Left >= 0 Then .Width = Split.Left
   End With
   
   With Lista
      .Top = Arriba
      If Check4.Value = 1 Or Check7.Value = 1 Then
         .Height = Altura * 0.6
      Else
         .Height = Altura
      End If
      .Left = Arbol.Left + Arbol.Width + Split.Width
      .Width = Ancho - .Left
   End With
   
   If Check4.Value = 0 Then
      ListaDetalle.Visible = False
   Else
      With ListaDetalle
         .Top = Arriba + Lista.Height
         .Height = Altura * 0.4
         .Left = Lista.Left
         .Width = Ancho - .Left
         .Visible = True
      End With
   End If

   If Check7.Value = 0 Then
      ListaTeoricos.Visible = False
   Else
      With ListaTeoricos
         .Top = Arriba + Lista.Height
         .Height = Altura * 0.4
         .Left = Lista.Left
         .Width = Ancho - .Left
         .Visible = True
      End With
   End If

End Sub

Private Sub CargarArbol()

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim mIdObra As Long, mIdEtapa As Long, mIdUnidadOperativa As Long
   Dim mTipoConsumo As Integer
   Dim oNode As Node
   
   Set oRs = Aplicacion.Obras.TraerFiltrado("_DestinosParaPresupuesto", Array(-1, mvarIdObra))
   Set oRs1 = Aplicacion.TablasGenerales.TraerLista("PresupuestoObrasRubros")

   Arbol.Nodes.Clear
   If Lista.ColumnHeaders.Count > 0 Then
      Lista.ListItems.Clear
      Lista.ColumnHeaders.Clear
   End If
   
   With Arbol.Nodes
      .Add , , "Ppal", "OBRAS", "Obras", "Obras"
      mIdUnidadOperativa = 0
      mIdObra = 0
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If mIdUnidadOperativa <> oRs.Fields("IdUnidadOperativa").Value Then
               mIdUnidadOperativa = oRs.Fields("IdUnidadOperativa").Value
               .Add "Ppal", tvwChild, "" & mIdUnidadOperativa & "|-1|-1|-1|-1", oRs.Fields("UnidadOperativa").Value, "Obras", "Obras"
            End If
            If mIdObra <> oRs.Fields("IdObra").Value Then
               mIdObra = oRs.Fields("IdObra").Value
               .Add "" & mIdUnidadOperativa & "|-1|-1|-1|-1", tvwChild, "" & mIdUnidadOperativa & "|" & mIdObra & "|-1|-1|-1", oRs.Fields("NumeroObra").Value, "Obras", "Obras"
            End If
            mIdEtapa = oRs.Fields("IdDetalleObraDestino").Value
            .Add "" & mIdUnidadOperativa & "|" & mIdObra & "|-1|-1|-1", tvwChild, "" & mIdUnidadOperativa & "|" & mIdObra & "|" & mIdEtapa & "|-1|-1", _
                     oRs.Fields("Etapa").Value & " " & oRs.Fields("DetalleEtapa").Value, "Etapas", "Etapas"
            If oRs1.RecordCount > 0 Then
               oRs1.MoveFirst
               Do While Not oRs1.EOF
                  .Add "" & mIdUnidadOperativa & "|" & mIdObra & "|" & mIdEtapa & "|-1|-1", tvwChild, _
                           "" & mIdUnidadOperativa & "|" & mIdObra & "|" & mIdEtapa & "|1|" & oRs1.Fields(0).Value, _
                           oRs1.Fields(1).Value, "Rubros", "Rubros"
                  oRs1.MoveNext
               Loop
            End If
            oRs.MoveNext
         Loop
      End If
      .Item("Ppal").Expanded = True
   End With
   
   oRs.Close
   Set oRs = Nothing
   oRs1.Close
   Set oRs1 = Nothing
   
'   For Each oNode In Arbol.Nodes
'      If Not oNode.Expanded Then oNode.Expanded = True
'   Next

End Sub

Private Sub CargarArbolOpciones()

   Dim oRs As ADOR.Recordset
   Dim n As Node
   Dim mCodigo As Integer
   
   ArbolOpciones.Nodes.Clear
   With ArbolOpciones.Nodes
      .Add , , "Ppal", "Opciones", "Opciones", "Opciones"
      .Add "Ppal", tvwChild, "Presupuesto", "Presupuesto", "Opciones", "Opciones"
      Set oRs = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObraCodigoPresupuesto", mvarIdObra)
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
      .Add "Ppal", tvwChild, "Pedidos", "Pedidos", "Opciones", "Opciones"
      .Item("Ppal").Expanded = True
      .Item("Presupuesto").Expanded = True
   End With
   
   Set oRs = Nothing

End Sub

Private Sub ReemplazarColumnHeader()

   Dim oCH As ColumnHeader
   Dim oRs As ADOR.Recordset
   Dim mFecha As Date
   
   Set oRs = Aplicacion.Obras.TraerFiltrado("_PorId", Array(mvarIdObra, mvarIdUnidadOperativa))
   mvarFechaInicio = Date
   If oRs.RecordCount > 0 Then
      mvarFechaInicio = IIf(IsNull(oRs.Fields("FechaInicio").Value), Date, oRs.Fields("FechaInicio").Value)
      mvarFechaFin = IIf(IsNull(oRs.Fields("FechaEntrega").Value), Date, oRs.Fields("FechaEntrega").Value)
   End If
   oRs.Close
   
   For Each oCH In Lista.ColumnHeaders
      If mId(oCH.Text, 3, 1) = "-" Then
         mFecha = DateAdd("m", Val(mId(oCH.Text, 1, 2)), mvarFechaInicio)
         oCH.Text = "" & NombreMesCorto(Month(mFecha)) & "/" & Year(mFecha) & " " & mId(oCH.Text, 4, 1)
      End If
   Next
   
   Set oRs = Nothing

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
   
   Set Node = Arbol.SelectedItem
   Do While Not Node Is Nothing
      s = s & "|" & Node.Text
      Set Node = Node.Parent
   Loop
   
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

Public Sub NuevaBase()

   If mvarIdObra <= 0 Then
      MsgBox "Obra no definida", vbExclamation
      Exit Sub
   End If
   
   Dim oF As frm_Aux
   Dim oRs As ADOR.Recordset
   Dim mNuevo As Integer, mCopiarDe As Integer
   Dim mOk As Boolean
   
   Set oRs = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObraCodigoPresupuesto", mvarIdObra)
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Generar nueva base"
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            .Combo1(0).AddItem "" & oRs.Fields(0).Value
            oRs.MoveNext
         Loop
         .Combo1(0).ListIndex = 0
         mNuevo = oRs.RecordCount
      Else
         mNuevo = 0
         mCopiarDe = -1
      End If
      .Label1.Caption = "Copiar desde:"
      With .Combo1(0)
         .Top = oF.Text1.Top
         .Left = oF.Text1.Left
         .Width = oF.Text1.Width / 2
         .Visible = True
      End With
      With .Label2(1)
         .Caption = "A generar:"
         .Visible = True
      End With
      With .Text1
         .Top = oF.DTFields(1).Top
         .Width = .Width / 3
         .Alignment = 2
         .Text = mNuevo
         .Locked = True
      End With
      .Show vbModal
      mOk = .Ok
      If Len(.Combo1(0).Text) > 0 Then mCopiarDe = .Combo1(0).Text
   End With
   Unload oF
   Set oF = Nothing
   Set oRs = Nothing
   
   If Not mOk Then Exit Sub
   
   Aplicacion.Tarea "PresupuestoObras_NuevaBase", Array(mvarIdObra, mCopiarDe, mNuevo)
   
   CargarArbolOpciones

End Sub

Public Sub BorrarBase()

   If ArbolOpciones.SelectedItem Is Nothing Then
      MsgBox "Haga click en el presupuesto para eliminarlo", vbInformation
      Exit Sub
   End If
      
   Dim mBorra As Integer
   mBorra = MsgBox("Esta seguro de eliminar este presupuesto?", vbYesNo, "Eliminar")
   If mBorra = vbNo Then Exit Sub

   Aplicacion.Tarea "PresupuestoObras_BorrarBase", _
            Array(mvarIdObra, LTrim(mId(ArbolOpciones.SelectedItem.Text, 12, 5)))
   
   CargarArbolOpciones

End Sub

Public Function Comparativo(ByVal IdObra As Long, ByVal IdDetalleObraDestino As Long, ByVal IdPresupuestoObraRubro As Long) As ADOR.Recordset

   Dim oF As frm_Aux
   Dim oRs As ADOR.Recordset
   Dim mCodigo As Integer, mDesde As Integer, mHasta As Integer
   Dim mTipo As String
   Dim mOk As Boolean
   Dim mFechaDesde As Date, mFechaHasta As Date
   
   mDesde = -1
   mFechaDesde = 0
   If Not IsNull(DTFields(0).Value) Then
      mFechaDesde = DTFields(0).Value
      mDesde = 0
   End If
   mHasta = -1
   mFechaHasta = 0
   If Not IsNull(DTFields(1).Value) Then
      mFechaHasta = DTFields(1).Value
      mHasta = 0
   End If
   
   Set oRs = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObraCodigoPresupuesto", mvarIdObra)
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Comparativo"
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            .Combo1(0).AddItem "" & oRs.Fields(0).Value
            oRs.MoveNext
         Loop
         .Combo1(0).ListIndex = 0
      End If
      .Text1.Visible = False
      With .Label2(0)
         .Caption = "Comparar con :"
         .Visible = True
      End With
      With .Combo1(0)
         .Top = oF.DTFields(0).Top
         .Left = oF.DTFields(0).Left
         .Width = oF.DTFields(0).Width / 2
         .Visible = True
      End With
      With .Label1
         .Caption = "A generar:"
         .Visible = True
      End With
      With .Frame1
         .Top = oF.Label1.Top + oF.Label1.Height + 10
         .Left = oF.Label1.Left
         .Visible = True
      End With
      With .Option1
         .Caption = "Resumido"
         .Value = True
      End With
      .Option2.Caption = "Detallado"
      .Show vbModal
      mOk = .Ok
      mCodigo = 0
      If Len(.Combo1(0).Text) > 0 Then mCodigo = .Combo1(0).Text
      mTipo = "R"
      If .Option2.Value Then mTipo = "D"
   End With
   Unload oF
   Set oF = Nothing
   Set oRs = Nothing
   
   If Not mOk Then Exit Function
   
   If mTipo = "R" Then
      Set Comparativo = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObraComparativa", _
               Array(IdObra, IdDetalleObraDestino, IdPresupuestoObraRubro, mDesde, mFechaDesde, mHasta, mFechaHasta))
   Else
      Set Comparativo = Aplicacion.PresupuestoObras.TraerFiltrado("_PorObraComparativa_Detalles", _
               Array(IdObra, IdDetalleObraDestino, IdPresupuestoObraRubro, mCodigo, mDesde, mFechaDesde, mHasta, mFechaHasta))
      
   End If
   
End Function

Public Sub ImportarHH()

   Dim i As Integer
   i = MsgBox("Desea importar los datos desde PRONTO SyJ?", vbYesNo, "Importacion datos SyJ")
   If i = vbNo Then Exit Sub

   Dim oF As frmAviso
   Set oF = New frmAviso
   With oF
      .Label1 = "Iniciando conexion con SyJ ..."
      .Show
      .Refresh
   End With
   DoEvents

   oF.Label1 = oF.Label1 & vbCrLf & "Procesando novedades ..."
   DoEvents

   Aplicacion.Tarea ("PresupuestoObras_ImportarHH")
   
   Unload oF
   Set oF = Nothing

End Sub
