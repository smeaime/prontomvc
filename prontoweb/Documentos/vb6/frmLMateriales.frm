VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmLMateriales 
   Caption         =   "Lista de materiales"
   ClientHeight    =   8070
   ClientLeft      =   60
   ClientTop       =   -4095
   ClientWidth     =   11880
   Icon            =   "frmLMateriales.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8070
   ScaleWidth      =   11880
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtEmbalo 
      DataField       =   "Embalo"
      Height          =   330
      Left            =   7650
      TabIndex        =   49
      Top             =   1530
      Width           =   4065
   End
   Begin VB.CommandButton cmdExcel 
      Height          =   690
      Left            =   3735
      Picture         =   "frmLMateriales.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   48
      ToolTipText     =   "Enviar la lista a Excel"
      Top             =   7020
      UseMaskColor    =   -1  'True
      Width           =   705
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
      Left            =   10665
      TabIndex        =   46
      Top             =   4995
      Width           =   1140
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
      Left            =   8370
      TabIndex        =   44
      Top             =   4995
      Width           =   1140
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   690
      Index           =   1
      Left            =   2970
      Picture         =   "frmLMateriales.frx":0CF4
      Style           =   1  'Graphical
      TabIndex        =   40
      Top             =   7020
      Width           =   705
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   0
      Left            =   4140
      TabIndex        =   38
      Top             =   1575
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   1
      Left            =   4365
      TabIndex        =   37
      Top             =   1575
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   2
      Left            =   4590
      TabIndex        =   36
      Top             =   1575
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   3
      Left            =   4815
      TabIndex        =   35
      Top             =   1575
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   4
      Left            =   5040
      TabIndex        =   34
      Top             =   1575
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   5
      Left            =   5265
      TabIndex        =   33
      Top             =   1575
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   6
      Left            =   5490
      TabIndex        =   32
      Top             =   1575
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.TextBox txtTotalPeso 
      Alignment       =   1  'Right Justify
      DataField       =   "MontoPrevisto"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0.00"
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
      Height          =   285
      Left            =   4500
      Locked          =   -1  'True
      TabIndex        =   30
      Top             =   5040
      Width           =   1455
   End
   Begin VB.CommandButton cmd 
      Caption         =   "C&opiar items"
      Height          =   330
      Index           =   2
      Left            =   1125
      TabIndex        =   15
      Top             =   7380
      Width           =   1020
   End
   Begin RichTextLib.RichTextBox rchObservacionGral 
      Height          =   690
      Left            =   5490
      TabIndex        =   11
      Top             =   7020
      Width           =   6315
      _ExtentX        =   11139
      _ExtentY        =   1217
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmLMateriales.frx":127E
   End
   Begin VB.TextBox txtNombre 
      DataField       =   "Nombre"
      Height          =   330
      Left            =   7650
      TabIndex        =   5
      Top             =   90
      Width           =   4065
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   330
      Index           =   0
      Left            =   45
      TabIndex        =   12
      Top             =   7020
      Width           =   1020
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   330
      Index           =   1
      Left            =   45
      TabIndex        =   13
      Top             =   7380
      Width           =   1020
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   690
      Index           =   0
      Left            =   2205
      Picture         =   "frmLMateriales.frx":1300
      Style           =   1  'Graphical
      TabIndex        =   16
      Top             =   7020
      UseMaskColor    =   -1  'True
      Width           =   705
   End
   Begin VB.TextBox txtNumeroLMateriales 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroLMateriales"
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
      Left            =   1755
      TabIndex        =   0
      Top             =   45
      Width           =   1050
   End
   Begin VB.CommandButton cmdPegar 
      Height          =   330
      Left            =   1125
      Picture         =   "frmLMateriales.frx":196A
      Style           =   1  'Graphical
      TabIndex        =   14
      Top             =   7020
      UseMaskColor    =   -1  'True
      Width           =   1020
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   330
      Index           =   0
      Left            =   4095
      TabIndex        =   1
      Top             =   45
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   582
      _Version        =   393216
      Format          =   64487425
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCliente"
      Height          =   315
      Index           =   1
      Left            =   1755
      TabIndex        =   3
      Tag             =   "Clientes"
      Top             =   810
      Width           =   3930
      _ExtentX        =   6932
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdCliente"
      Text            =   ""
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   17
      Top             =   7785
      Width           =   11880
      _ExtentX        =   20955
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   4590
      Top             =   7380
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLMateriales.frx":1DAC
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLMateriales.frx":1EBE
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLMateriales.frx":2310
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLMateriales.frx":2762
            Key             =   "Original"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLMateriales.frx":2BB4
            Key             =   "ItemManual"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLMateriales.frx":3006
            Key             =   "Avance"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   0
      Left            =   1755
      TabIndex        =   2
      Tag             =   "Obras"
      Top             =   450
      Width           =   3930
      _ExtentX        =   6932
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdEquipo"
      Height          =   315
      Index           =   2
      Left            =   1755
      TabIndex        =   4
      Tag             =   "DefExe2"
      Top             =   1170
      Width           =   3930
      _ExtentX        =   6932
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEquipo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Realizo"
      Height          =   315
      Index           =   4
      Left            =   7650
      TabIndex        =   7
      Tag             =   "Empleados"
      Top             =   810
      Width           =   4065
      _ExtentX        =   7170
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Aprobo"
      Height          =   315
      Index           =   5
      Left            =   7650
      TabIndex        =   8
      Tag             =   "Empleados"
      Top             =   1170
      Width           =   4065
      _ExtentX        =   7170
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdPlano"
      Height          =   315
      Index           =   3
      Left            =   7650
      TabIndex        =   6
      Tag             =   "DefExe1"
      Top             =   450
      Width           =   4065
      _ExtentX        =   7170
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPlano"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   330
      Left            =   4905
      TabIndex        =   28
      Top             =   7335
      Visible         =   0   'False
      Width           =   555
      _ExtentX        =   979
      _ExtentY        =   582
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmLMateriales.frx":3320
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3075
      Left            =   0
      TabIndex        =   9
      Top             =   1890
      Width           =   11805
      _ExtentX        =   20823
      _ExtentY        =   5424
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmLMateriales.frx":33A2
      OLEDragMode     =   1
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaRev 
      Height          =   1635
      Left            =   45
      TabIndex        =   10
      Top             =   5355
      Width           =   5910
      _ExtentX        =   10425
      _ExtentY        =   2884
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmLMateriales.frx":33BE
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaAva 
      Height          =   1635
      Left            =   5985
      TabIndex        =   42
      Top             =   5355
      Width           =   5820
      _ExtentX        =   10266
      _ExtentY        =   2884
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmLMateriales.frx":33DA
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Label lblLabels 
      Caption         =   "Embalo :"
      Height          =   285
      Index           =   1
      Left            =   5985
      TabIndex        =   50
      Top             =   1530
      Width           =   1575
   End
   Begin VB.Label Label2 
      Caption         =   "Total Rep. :"
      Height          =   195
      Left            =   9675
      TabIndex        =   47
      Top             =   5040
      Width           =   915
   End
   Begin VB.Label Label1 
      Caption         =   "Total PPP :"
      Height          =   195
      Left            =   7380
      TabIndex        =   45
      Top             =   5040
      Width           =   915
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Avances :"
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
      Index           =   0
      Left            =   6030
      TabIndex        =   43
      Top             =   5130
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle de items :"
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
      Index           =   16
      Left            =   45
      TabIndex        =   41
      Top             =   1665
      Width           =   1545
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Autorizaciones : "
      Height          =   195
      Index           =   13
      Left            =   2475
      TabIndex        =   39
      Top             =   1575
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Total peso de los materiales : "
      Height          =   195
      Index           =   12
      Left            =   2295
      TabIndex        =   31
      Top             =   5085
      Width           =   2100
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Obs. :"
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
      Index           =   10
      Left            =   4905
      TabIndex        =   29
      Top             =   7065
      Width           =   525
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Nombre de lista :"
      Height          =   285
      Index           =   9
      Left            =   5985
      TabIndex        =   27
      Top             =   90
      Width           =   1575
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Numero de plano :"
      Height          =   285
      Index           =   3
      Left            =   5985
      TabIndex        =   26
      Top             =   450
      Width           =   1575
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Equipo :"
      Height          =   285
      Index           =   2
      Left            =   135
      TabIndex        =   25
      Top             =   1170
      Width           =   1575
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Cliente :"
      Height          =   285
      Index           =   1
      Left            =   135
      TabIndex        =   24
      Top             =   810
      Width           =   1575
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Realizo :"
      Height          =   285
      Index           =   4
      Left            =   5985
      TabIndex        =   23
      Top             =   810
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   285
      Index           =   4
      Left            =   3060
      TabIndex        =   22
      Top             =   90
      Width           =   990
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Obra :"
      Height          =   285
      Index           =   0
      Left            =   135
      TabIndex        =   21
      Top             =   450
      Width           =   1575
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Liberado por :"
      Height          =   285
      Index           =   5
      Left            =   5985
      TabIndex        =   20
      Top             =   1170
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Revisiones :"
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
      Index           =   5
      Left            =   90
      TabIndex        =   19
      Top             =   5130
      Width           =   1065
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Numero de LISTA :"
      Height          =   285
      Index           =   6
      Left            =   135
      TabIndex        =   18
      Top             =   90
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
         Caption         =   "Agregar subtitulo"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Copiar item"
         Index           =   4
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar revision"
         Index           =   5
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar destinos de obra"
         Index           =   6
      End
   End
   Begin VB.Menu MnuDetRev 
      Caption         =   "DetalleRev"
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
   Begin VB.Menu MnuDetAva 
      Caption         =   "DetalleAva"
      Visible         =   0   'False
      Begin VB.Menu MnuDetC 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetC 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetC 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
End
Attribute VB_Name = "frmLMateriales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.LMaterial
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId, mIdAprobo As Long
Private AcopioIngresado As Boolean, mvarGrabado As Boolean, mHayRevisiones As Boolean
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

   Dim oF As frmDetLMateriales
   Dim oL As ListItem
   Dim espacios As Integer, mConjunto As Integer
   
   If Not IsNumeric(dcfields(0).BoundText) Then
      MsgBox "Debe definir la obra antes de ingresar un item."
      Exit Sub
   End If
   
'   If Not IsNumeric(dcfields(2).BoundText) Then
'      MsgBox "Debe definir el equipo antes de ingresar un item."
'      Exit Sub
'   End If
   
'   If Not IsNumeric(dcfields(3).BoundText) Then
'      MsgBox "Debe definir el numero de plano antes de ingresar un item."
'      Exit Sub
'   End If
   
   If Not IsNumeric(dcfields(4).BoundText) Then
      MsgBox "Debe definir quien realizo la lista antes de ingresar un item."
      Exit Sub
   End If
   
   If Len(Trim(txtNombre.Text)) = 0 Then
      MsgBox "Debe definir el nombre de la lista de materiales antes de ingresar un item."
      Exit Sub
   End If
   
   If Not Lista.SelectedItem Is Nothing Then
      With Lista.SelectedItem
         mConjunto = .Text
      End With
   Else
      mConjunto = 0
   End If
   
   Set oF = New frmDetLMateriales
   
   With oF
      Set .LMaterial = origen
      .ConjuntoApuntado = mConjunto
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
            If Len(oF.DataCombo1(1).BoundText) Then
               If Cual = -1 Then
                  .SmallIcon = "Nuevo"
               Else
                  .SmallIcon = "Modificado"
               End If
            Else
               .SmallIcon = "ItemManual"
            End If
            If IsNumeric(oF.txtNumeroOrden) And oF.txtNumeroOrden <> 0 Then
               espacios = 5
            Else
               espacios = 0
            End If
            .Text = oF.txtItem.Text
            .SubItems(1) = "" & oF.txtNumeroOrden.Text
            .SubItems(2) = "" & oF.txtRevision.Text
            .SubItems(3) = "" & oF.txtNumeroItemAcopio.Text
            .SubItems(4) = "" & Format(oF.txtCantidad.Text, "Fixed")
            .SubItems(5) = "" & IIf(Len(Trim(oF.txtCantidad1.Text)) <> 0, Format(oF.txtCantidad1.Text, "Fixed"), "")
            .SubItems(6) = "" & IIf(Len(Trim(oF.txtCantidad2.Text)) <> 0, Format(oF.txtCantidad2.Text, "Fixed"), "")
            .SubItems(7) = "" & oF.DataCombo1(0).Text
            .SubItems(8) = "" & oF.txtCodigoArticulo.Text
            If Len(oF.DataCombo1(1).BoundText) Then
               .SubItems(9) = "" & Space(espacios) & oF.DataCombo1(1).Text
            Else
               .SubItems(9) = "" & Space(espacios) & oF.txtDescripcionManual.Text
            End If
            .SubItems(10) = "" & oF.txtCostoPPP.Text
            .SubItems(11) = "" & Val(oF.txtCostoPPP.Text) * Val(oF.txtCantidad.Text)
            .SubItems(12) = "" & oF.txtCostoReposicion.Text
            .SubItems(13) = "" & Val(oF.txtCostoReposicion.Text) * Val(oF.txtCantidad.Text)
            .SubItems(14) = "" & oF.DataCombo1(7).Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
   CalculaLMaterial

End Sub

Sub EditarSubtitulo(ByVal Cual As Long)

   Dim oF As frmDetLMaterialesSubtitulos
   Dim oL As ListItem
   
   Set oF = New frmDetLMaterialesSubtitulos
   
   With oF
      Set .LMaterial = origen
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
            .SubItems(9) = "" & oF.txtDetalle.Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Sub EditarRev(ByVal Cual As Long)

   Dim oF As frmDetLMaterialesRevision
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim i As Integer
   
   Set oF = New frmDetLMaterialesRevision
   
   origen.Registro.Fields(DTFields(0).DataField).Value = DTFields(0).Value
   
   With oF
      Set .LMaterial = origen
      .TipoRevision = "R"
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaRev.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaRev.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = ""
            .SubItems(1) = "" & oF.Tipo
            .SubItems(2) = "" & oF.txtNumeroRevision.Text
            .SubItems(3) = "" & oF.DTFields(0).Value
            .SubItems(4) = "" & oF.txtDetalle.Text
            If IsNumeric(oF.dcfields(0).BoundText) Then
               .SubItems(5) = "" & Aplicacion.Empleados.Item(oF.dcfields(0).BoundText).Registro.Fields("Iniciales").Value
            End If
            .SubItems(6) = "" & oF.DTFields(1).Value
            If IsNumeric(oF.dcfields(1).BoundText) Then
               .SubItems(7) = "" & Aplicacion.Empleados.Item(oF.dcfields(1).BoundText).Registro.Fields("Iniciales").Value
            End If
            .SubItems(8) = "" & oF.DTFields(2).Value
         End With
         Set oAp = Aplicacion
         oAp.AutorizacionesPorComprobante.BorrarAutorizaciones Array(EnumFormularios.ListaMateriales, mvarId)
         Set oAp = Nothing
         For i = 1 To 6
            If Check1(i).Visible Then
               Check1(i).Value = 0
            End If
         Next
         mHayRevisiones = True
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Sub EditarAva(ByVal Cual As Long)

   If Cual = -1 Then
      MsgBox "Para agregar un avance arrastre un item de la lista de materiales al cuadro de avances", vbExclamation
      Exit Sub
   End If
   
   Dim oF As frmDetLMaterialesRevision
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim i As Integer
   
   Set oF = New frmDetLMaterialesRevision
   
   origen.Registro.Fields(DTFields(0).DataField).Value = DTFields(0).Value
   
   With oF
      Set .LMaterial = origen
      .TipoRevision = "A"
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaAva.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaAva.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtConjunto.Text
            .SubItems(1) = "" & oF.txtPosicion.Text
            .SubItems(2) = "" & oF.txtRevision.Text
            .SubItems(3) = "" & oF.txtNumeroRevision.Text
            .SubItems(4) = "" & oF.DTFields(0).Value
            .SubItems(5) = "" & oF.txtDetalle.Text
            If IsNumeric(oF.dcfields(0).BoundText) Then
               .SubItems(6) = "" & Aplicacion.Empleados.Item(oF.dcfields(0).BoundText).Registro.Fields("Iniciales").Value
            End If
            .SubItems(7) = "" & oF.DTFields(1).Value
            If IsNumeric(oF.dcfields(1).BoundText) Then
               .SubItems(8) = "" & Aplicacion.Empleados.Item(oF.dcfields(1).BoundText).Registro.Fields("Iniciales").Value
            End If
            .SubItems(9) = "" & oF.DTFields(2).Value
         End With
         For Each oL In Lista.ListItems
            If oL.Tag = oF.IdDetalleLMateriales Then
               oL.ForeColor = vbBlue
               oL.SmallIcon = "Avance"
               Exit For
            End If
         Next
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
      
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar una Lista de LMaterial sin detalles"
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim mvarImprime As Integer
         Dim mNum As Long
         Dim oPar As ComPronto.Parametro
         
         With origen.Registro
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
            For Each dc In dcfields
               If dc.Enabled Then
                  If Not IsNumeric(dc.BoundText) Then
                     If dc.Index <> 2 And dc.Index <> 3 And dc.Index <> 5 And Not ((dc.Index = 2 Or dc.Index = 3) And mvarId > 0) Then
                        MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
                        Exit Sub
                     End If
                  End If
                  If IsNumeric(dc.BoundText) Then
                     .Fields(dc.DataField).Value = dc.BoundText
                  End If
               End If
            Next
            .Fields("Observaciones").Value = rchObservacionGral.Text
         End With
         
         If Len(Trim(txtNombre.Text)) = 0 Then
            MsgBox "Falta completar el campo Nombre", vbCritical
            Exit Sub
         End If
      
         Me.MousePointer = vbHourglass
      
         If mvarId < 0 Then
            Set oPar = Aplicacion.Parametros.Item(1)
            mNum = oPar.Registro.Fields("ProximaListaMateriales").Value
            origen.Registro.Fields("NumeroLMateriales").Value = mNum
            oPar.Registro.Fields("ProximaListaMateriales").Value = mNum + 1
            oPar.Guardar
            Set oPar = Nothing
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
            .ListaEditada = "LMateriales"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
         Me.MousePointer = vbDefault
      
         mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de Lista de Materiales")
         If mvarImprime = vbYes Then
            cmdImpre_Click (0)
         End If
         
         Unload Me

      Case 1
      
         Unload Me

      Case 2
      
'         dcfields(3).Enabled = False
'         cmd(2).Enabled = False
      
         Dim Cadena As String
         Cadena = Lista.GetString
         If Len(Trim(Cadena)) > 0 Then
            Cadena = Replace(Cadena, "Id" & vbTab, "LMateriales" & vbTab)
            With Clipboard
               .Clear
               .SetText Cadena
            End With
            MsgBox "Items copiados correctamente", vbInformation
         Else
            MsgBox "No hay informacion a copiar", vbExclamation
         End If

   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim oRsAut As ADOR.Recordset
   Dim dtf As DTPicker
   Dim ListaVacia1 As Boolean, ListaVacia2 As Boolean, ListaVacia3 As Boolean
   Dim mCantidadFirmas As Integer, i As Integer
   Dim oDet As ComPronto.DetLMaterial
   Dim oDetRev As ComPronto.DetLMaterialRevisiones
   Dim oL As ListItem
   
   mvarId = vnewvalue
   ListaVacia1 = False
   ListaVacia2 = False
   ListaVacia3 = False
   
   Set oAp = Aplicacion
   Set origen = oAp.LMateriales.Item(vnewvalue)
   
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetLMateriales.TraerMascara
                     ListaVacia1 = True
                  Else
                     Set oRs = origen.DetLMateriales.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                        ListaVacia1 = False
                     Else
                        Set oControl.DataSource = origen.DetLMateriales.TraerMascara
                        ListaVacia1 = True
                     End If
                     Set oRs = Nothing
                  End If
               Case "ListaRev"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetLMaterialesRevisiones.TraerMascara
                     ListaVacia2 = True
                     mHayRevisiones = False
                  Else
                     Set oRs = origen.DetLMaterialesRevisiones.TraerFiltrado("_Revisiones", mvarId)
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                        ListaVacia2 = False
                        mHayRevisiones = True
                     Else
                        Set oControl.DataSource = origen.DetLMaterialesRevisiones.TraerMascara
                        ListaVacia2 = True
                        mHayRevisiones = False
                     End If
'                     If oRs.RecordCount > 0 Then
'                        oRs.MoveFirst
'                        While Not oRs.EOF
'                           Set oDetRev = origen.DetLMaterialesRevisiones.Item(oRs.Fields("IdDetalleLMaterialesRevisiones").Value)
'                           Set oDetRev = Nothing
'                           oRs.MoveNext
'                        Wend
'                     End If
'                     oRs.Close
                     Set oRs = Nothing
                  End If
               Case "ListaAva"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetLMaterialesRevisiones.TraerMascaraAvances
                     ListaVacia3 = True
                     mHayRevisiones = False
                  Else
                     Set oRs = origen.DetLMaterialesRevisiones.TraerFiltrado("_Avances", mvarId)
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                        ListaVacia3 = False
                        mHayRevisiones = True
                     Else
                        Set oControl.DataSource = origen.DetLMaterialesRevisiones.TraerMascaraAvances
                        ListaVacia3 = True
                        mHayRevisiones = False
                     End If
'                     If oRs.RecordCount > 0 Then
'                        oRs.MoveFirst
'                        While Not oRs.EOF
'                           Set oDetRev = origen.DetLMaterialesRevisiones.Item(oRs.Fields("IdDetalleLMaterialesRevisiones").Value)
'                           Set oDetRev = Nothing
'                           oRs.MoveNext
'                        Wend
'                     End If
'                     oRs.Close
                     Set oRs = Nothing
                  End If
            End Select
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               Select Case oControl.Tag
                  Case "DefExe1"
                     If Not IsNull(origen.Registro.Fields("IdEquipo").Value) Then
                        Set oControl.RowSource = oAp.Equipos.TraerFiltrado("Planos", origen.Registro.Fields("IdEquipo").Value)
                        If Not IsNull(origen.Registro.Fields("IdPlano").Value) Then
                           oControl.BoundText = origen.Registro.Fields("IdPlano").Value
                        End If
                     End If
                  Case "DefExe2"
                     If Not IsNull(origen.Registro.Fields("IdEquipo").Value) Then
                        Set oControl.RowSource = oAp.Obras.TraerFiltrado("Equipos", origen.Registro.Fields("IdObra").Value)
                        oControl.BoundText = origen.Registro.Fields("IdEquipo").Value
                     End If
                  Case "Obras"
                     If mvarId > 0 Then
                        Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasParaCombo")
                     Else
                        Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
                     End If
                  Case Else
                     Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End Select
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
   
   Check1(0).Visible = True
   
   If mvarId = -1 Then
      Set oPar = Aplicacion.Parametros.Item(1)
      With origen.Registro
         .Fields("NumeroLMateriales").Value = oPar.Registro.Fields("ProximaListaMateriales").Value
         .Fields("Realizo").Value = glbIdUsuario
      End With
      Set oPar = Nothing
      txtNumeroLMateriales.Enabled = False
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      mvarGrabado = False
      mIdAprobo = 0
   Else
      With origen.Registro
         If Not IsNull(.Fields("Aprobo").Value) Then
            Check1(0).Value = 1
            mIdAprobo = .Fields("Aprobo").Value
         End If
         rchObservacionGral.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
      mCantidadFirmas = 0
      Set oRsAut = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(EnumFormularios.ListaMateriales, 0))
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
      Set oRsAut = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(EnumFormularios.ListaMateriales, mvarId))
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
      mvarGrabado = True
   End If
   
   With Lista
      If ListaVacia1 Then
         .ListItems.Clear
      Else
         For Each oL In Lista.ListItems
            If Not IsNull(origen.DetLMateriales.Item(oL.Tag).Registro.Fields("DescripcionManual").Value) And _
                   IsNull(origen.DetLMateriales.Item(oL.Tag).Registro.Fields("IdArticulo").Value) Then
               oL.SmallIcon = "ItemManual"
            End If
         Next
         Set oRs = origen.DetLMaterialesRevisiones.TraerFiltrado("_Avances", mvarId)
         If oRs.RecordCount > 0 Then
            oRs.MoveFirst
            Do While Not oRs.EOF
               For Each oL In Lista.ListItems
                  If oL.Tag = oRs.Fields("IdDetalleLMateriales").Value Then
                     oL.ForeColor = vbBlue
                     oL.SmallIcon = "Avance"
                     Exit For
                  End If
               Next
               oRs.MoveNext
            Loop
         End If
         oRs.Close
      End If
      .Sorted = False
      .Refresh
   End With
   
   With ListaRev
      If ListaVacia2 Then
         .ListItems.Clear
      End If
   End With
   
   With ListaAva
      If ListaVacia3 Then
         .ListItems.Clear
      End If
   End With
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
   End If
   
   txtTotalPeso.Text = origen.DetLMateriales.TotalPeso

   CalculaLMaterial
   
End Property

Private Sub cmdExcel_Click()

   If Lista.ListItems.Count > 0 Then
      Dim mvarSubTituloExcel As String
      mvarSubTituloExcel = "|Lista numero " & txtNumeroLMateriales.Text & " del " & DTFields(0).Value & ", nombre : " & txtNombre.Text & _
                           "|Obra : " & dcfields(0).Text & " - Equipo : " & dcfields(2).Text & " - Plano : " & dcfields(3).Text & _
                           "|Cliente : " & dcfields(1).Text & " - Realizo : " & dcfields(4).Text & " - Aprobo : " & dcfields(5).Text & _
                           "|Total a Costo PPP : " & txtTotal(0).Text & _
                           "|Total a Costo Reposicion : " & txtTotal(1).Text
      ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel
   Else
      MsgBox "Solo puede exportar a Excel si hay materiales ingresados.", vbExclamation
   End If
   
End Sub

Private Sub cmdImpre_Click(Index As Integer)

   If Not mvarGrabado Then
      MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
      Exit Sub
   End If
   
   Dim mResp As String
'   Do While True
'      mResp = InputBox("Indique [S] para emitir la lista de materiales con los " & _
'                        "avances incluidos o [N] si no lo desea", _
'                        "Emision de lista de materiales", "N")
'      mResp = UCase(mResp)
'      If mResp = "" Then
'         Exit Sub
'      ElseIf mResp = "S" Or mResp = "N" Then
'         Exit Do
'      End If
'   Loop
   
   Dim mvarOK As Boolean
   Dim mCopias As Integer
   Dim mPrinter As String, mPrinterAnt As String
   
   mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
   Dim oF As frmCopiasImpresion
   Set oF = New frmCopiasImpresion
   With oF
      .Option1.Caption = "C/avances"
      .Option2.Caption = "S/avances"
      If Index = 0 Then
         .txtCopias.Text = 1
      Else
         .txtCopias.Visible = False
         .lblCopias.Visible = False
         .lblImpresora.Visible = False
         .Combo1.Visible = False
         .Frame1.Left = 1500
         mCopias = 1
      End If
      .Show vbModal, Me
      If .Option1.Value Then
         mResp = "S"
      Else
         mResp = "N"
      End If
   End With
   mvarOK = oF.Ok
   mCopias = Val(oF.txtCopias.Text)
   mPrinter = oF.Combo1.Text
   Unload oF
   Set oF = Nothing
   If Not mvarOK Then
      Exit Sub
   End If

   Dim oW As Word.Application
   Dim oAp As Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRsCli As ADOR.Recordset
   Dim oRsRev As ADOR.Recordset
   Dim oRsArt As ADOR.Recordset
   Dim oRsAco As ADOR.Recordset
   Dim oRsPlano As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim i As Integer
   Dim mvarCantidad As String, espacios As String, mvarMedidas As String
   Dim mvarUnidad As String, mvarUnidadPeso As String, mvarDescripcion As String
   Dim mAdjuntos As String
   
   Me.MousePointer = vbHourglass
      
   On Error GoTo Mal
   
   mvarUnidadPeso = ""
   
   Set oW = CreateObject("Word.Application")
   Set oAp = Aplicacion
   
   With oW
      
      .Visible = True
      
      With .Documents.Add(glbPathPlantillas & "\LMateriales.dot")
   
         Set oRs = origen.Registro
         Set oRsDet = origen.DetLMateriales.TodosLosRegistros
         Set oRsRev = origen.DetLMaterialesRevisiones.RegistrosConFormato
         Set oRsCli = Aplicacion.Clientes.Item(IIf(IsNull(oRs.Fields("IdCliente").Value), 0, oRs.Fields("IdCliente").Value)).Registro
         
'         oW.Selection.HomeKey Unit:=wdStory
'         oW.Selection.MoveDown Unit:=wdLine, Count:=2
'         oW.Selection.MoveLeft Unit:=wdCell, Count:=1
         oW.Selection.Goto What:=wdGoToBookmark, Name:="Detalle"
          
         With oRsDet
            If .RecordCount > 0 Then
               .MoveFirst
               Do Until .EOF
                  If .Fields("NumeroOrden").Value <> 0 Then
                     espacios = "     "
                  Else
                     espacios = ""
                  End If
                  If .AbsolutePosition > 1 Then oW.Selection.MoveRight Unit:=wdCell
                  oW.Selection.TypeText Text:="" & Format(.Fields("NumeroItem").Value, "General Number") & " - " & Format(.Fields("NumeroOrden").Value, "General Number")
                  If Len(Trim(.Fields("Detalle").Value)) <> 0 Then
                     oW.Selection.MoveRight Unit:=wdCell, Count:=8
                     oW.Selection.Font.Bold = True
                     oW.Selection.Font.Size = 12
                     oW.Selection.TypeText Text:="" & .Fields("Detalle").Value
                     oW.Selection.Font.Bold = False
                     oW.Selection.Font.Size = 10
                     oW.Selection.MoveRight Unit:=wdCell, Count:=4
                  Else
                     oW.Selection.MoveRight Unit:=wdCell
                     If IsNull(.Fields("Revision").Value) Then
                        oW.Selection.TypeText Text:=""
                     Else
                        oW.Selection.TypeText Text:="" & Format(.Fields("Revision").Value, "General Number")
                     End If
                     oW.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
                     oW.Selection.MoveRight Unit:=wdCell
                     
                     If Not IsNull(.Fields("IdDetalleAcopios").Value) Then
                        Set oRsAco = Aplicacion.Acopios.TraerFiltrado("_DatosAcopio", .Fields("IdDetalleAcopios").Value)
                        If oRsAco.RecordCount > 0 Then
                           oW.Selection.TypeText Text:="" & Format(oRsAco.Fields("NumeroAcopio").Value, "General Number")
                           oW.Selection.MoveRight Unit:=wdCell
                           oW.Selection.TypeText Text:="" & Format(oRsAco.Fields("NumeroItem").Value, "General Number")
                           oW.Selection.MoveRight Unit:=wdCell
                        Else
                           oW.Selection.MoveRight Unit:=wdCell
                           oW.Selection.MoveRight Unit:=wdCell
                        End If
                        oRsAco.Close
                     Else
                        oW.Selection.MoveRight Unit:=wdCell, Count:=2
                     End If
                     
                     oW.Selection.TypeText Text:="" & .Fields("Cantidad").Value
                     oW.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
                     oW.Selection.MoveRight Unit:=wdCell
                     If Not IsNull(.Fields("IdUnidad").Value) Then
                        Set oRsAux = oAp.Unidades.Item(.Fields("IdUnidad").Value).Registro
                        If oRsAux.RecordCount > 0 Then
                           If Not IsNull(oRsAux.Fields("Abreviatura").Value) Then
                              oW.Selection.TypeText Text:="" & oRsAux.Fields("Abreviatura").Value
                           End If
                        End If
                        oRsAux.Close
                     End If
                     oW.Selection.MoveRight Unit:=wdCell
                     
                     
                     mvarUnidad = ""
                     If Not IsNull(.Fields("IdUnidad").Value) Then
                        mvarUnidad = oAp.Unidades.Item(.Fields("IdUnidad").Value).Registro.Fields("Abreviatura").Value
                     End If
                     
                     mvarMedidas = ""
                     If Not IsNull(.Fields("IdArticulo").Value) Then
                        Set oRsArt = oAp.Articulos.Item(.Fields("IdArticulo").Value).Registro
                        If Not IsNull(oRsArt.Fields("IdCuantificacion").Value) Then
                           Select Case oRsArt.Fields("IdCuantificacion").Value
                              Case 3
                                 mvarMedidas = "" & .Fields("Cantidad1").Value & " x " & oRsDet.Fields("Cantidad2").Value & " " & mvarUnidad
                              Case 2
                                 mvarMedidas = "" & .Fields("Cantidad1").Value & " " & mvarUnidad
                           End Select
                        End If
                        oW.Selection.TypeText Text:="" & mvarMedidas
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & IIf(IsNull(oRsArt.Fields("Codigo").Value), "", oRsArt.Fields("Codigo").Value)
                        oW.Selection.MoveRight Unit:=wdCell
                        mvarDescripcion = espacios & oRsArt.Fields("Descripcion").Value
                        oRsArt.Close
                     Else
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.MoveRight Unit:=wdCell
                        mvarDescripcion = espacios & .Fields("DescripcionManual").Value & "(*)"
                     End If
                     oW.Selection.Font.Bold = False
                     oW.Selection.Font.Size = 10
                     If Len(Trim(.Fields("Observaciones").Value)) <> 0 Then
                       rchObservaciones.TextRTF = .Fields("Observaciones").Value
                       mvarDescripcion = mvarDescripcion & vbCrLf & rchObservaciones.Text
'                       oW.Selection.MoveRight Unit:=wdCell, Count:=8
'                       oW.Selection.TypeText Text:="" & rchObservaciones.Text
'                       oW.Selection.MoveRight Unit:=wdCell, Count:=4
                     End If
                     oW.Selection.TypeText Text:="" & mvarDescripcion
                     oW.Selection.MoveRight Unit:=wdCell
                     
                     If Not IsNull(.Fields("Peso").Value) Then
                        If .Fields("Peso").Value <> 0 Then
                           If Not IsNull(.Fields("IdUnidadPeso").Value) Then
                              Set oRsAux = oAp.Unidades.Item(.Fields("IdUnidadPeso").Value).Registro
                              If oRsAux.RecordCount > 0 Then
                                 If Not IsNull(oRsAux.Fields("Abreviatura").Value) Then
                                    mvarUnidadPeso = "" & oRsAux.Fields("Abreviatura").Value
                                 End If
                              End If
                              oRsAux.Close
                           End If
                           oW.Selection.TypeText Text:="" & Int(.Fields("Peso").Value)
                           oW.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
                           oW.Selection.MoveRight Unit:=wdCell
                           oW.Selection.TypeText Text:="" & mvarUnidadPeso
                           oW.Selection.MoveRight Unit:=wdCell
                        Else
                           oW.Selection.MoveRight Unit:=wdCell
                           oW.Selection.MoveRight Unit:=wdCell
                        End If
                     Else
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.MoveRight Unit:=wdCell
                     End If
                        
                     If Not IsNull(.Fields("IdControlCalidad").Value) Then
                        oW.Selection.TypeText Text:="" & oAp.ControlesCalidad.Item(.Fields("IdControlCalidad").Value).Registro.Fields("Abreviatura").Value
                     End If
                     oW.Selection.MoveRight Unit:=wdCell
                     oW.Selection.TypeText Text:="" & .Fields("Adjunto").Value
                     
                     If .Fields("Adjunto").Value = "SI" Then
                        mAdjuntos = "Arch.Adjunto : "
                        For i = 1 To 10
                           If Not IsNull(.Fields("ArchivoAdjunto" & i).Value) Then
                              If Len(.Fields("ArchivoAdjunto" & i).Value) > 0 And mId(.Fields("ArchivoAdjunto" & i).Value, Len(.Fields("ArchivoAdjunto" & i).Value), 1) <> "\" Then
                                 mAdjuntos = mAdjuntos & Trim(.Fields("ArchivoAdjunto" & i).Value) & ", "
                              End If
                           End If
                        Next
                        mAdjuntos = mId(mAdjuntos, 1, Len(mAdjuntos) - 2)
                        oW.Selection.MoveRight Unit:=wdCell, Count:=9
                        oW.Selection.TypeText Text:="" & mAdjuntos
                        oW.Selection.MoveRight Unit:=wdCell, Count:=4
                     End If
                  
                  End If
                  .MoveNext
               Loop
            End If
         End With
          
         'Observaciones
         oW.Selection.Goto What:=wdGoToBookmark, Name:="Observaciones"
         oW.Selection.TypeText Text:="" & rchObservacionGral.Text
         
         'Avances
         oW.Selection.Goto What:=wdGoToBookmark, Name:="Avances"
         oW.Selection.MoveDown Unit:=wdLine
         oW.Selection.MoveLeft Unit:=wdCell
         If mResp = "S" Then
            With oRsRev
               If oRsRev.State <> adStateClosed Then
                  If .RecordCount > 0 Then
                     .MoveFirst
                     Do Until .EOF
                        If Not .Fields("Eliminado").Value And .Fields("Tipo").Value = "A" Then
                           Set oRsAux = origen.DetLMateriales.TraerFiltrado("_UnItem", .Fields("IdDetalleLMateriales").Value)
                           If oRsAux.RecordCount > 0 Then
                              oW.Selection.MoveRight Unit:=wdCell
                              oW.Selection.TypeText Text:="" & oRsAux.Fields("NumeroItem").Value
                              oW.Selection.MoveRight Unit:=wdCell
                              oW.Selection.TypeText Text:="" & oRsAux.Fields("NumeroOrden").Value
                              oW.Selection.MoveRight Unit:=wdCell
                              oW.Selection.TypeText Text:="" & oRsAux.Fields("Revision").Value
                           Else
                              oW.Selection.MoveRight Unit:=wdCell, Count:=3
                           End If
                           oRsAux.Close
                           oW.Selection.MoveRight Unit:=wdCell
                           oW.Selection.TypeText Text:="" & .Fields("Numero").Value
                           oW.Selection.MoveRight Unit:=wdCell
                           oW.Selection.TypeText Text:="" & .Fields("Fecha").Value
                           oW.Selection.MoveRight Unit:=wdCell
                           oW.Selection.TypeText Text:="" & .Fields("Detalle").Value
                        End If
                        .MoveNext
                     Loop
                  End If
               End If
            End With
         Else
            oW.Selection.Tables(1).Select
            oW.Selection.Tables(1).Delete
            oW.Selection.TypeBackspace
         End If
         
         'Revisiones
         oW.Selection.Goto What:=wdGoToBookmark, Name:="Revisiones"
         oW.Selection.MoveDown Unit:=wdLine
         oW.Selection.MoveLeft Unit:=wdCell
         With oRsRev
            If oRsRev.State <> adStateClosed Then
               If .RecordCount > 0 Then
                  .MoveFirst
                  Do Until .EOF
                     If Not .Fields("Eliminado").Value And Not .Fields("Tipo").Value = "A" Then
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Numero").Value
                        oW.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Fecha").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Detalle").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        If Not IsNull(.Fields("Realizo").Value) Then
                           oW.Selection.TypeText Text:="" & .Fields("Realizo").Value
                        End If
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Fecha realiz.").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        If Not IsNull(.Fields("Aprobo").Value) Then
                           oW.Selection.TypeText Text:="" & .Fields("Aprobo").Value
                        End If
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Fecha aprob.").Value
                     End If
                     .MoveNext
                  Loop
               End If
            End If
         End With
         
         'Registro de numero de paginas, fecha y hora y logo
         oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
         oW.Application.Run MacroName:="DatosDelPie"
          
         'Volcado de datos de cabecera de la lista de materiales
         oW.ActiveDocument.FormFields("NumeroInterno").Result = "(" & oRs.Fields("NumeroLMateriales").Value & ")"
         oW.ActiveDocument.FormFields("Numero").Result = oRs.Fields("Nombre").Value
         oW.ActiveDocument.FormFields("Fecha").Result = oRs.Fields("Fecha").Value
         oW.ActiveDocument.FormFields("Obra").Result = "" & oAp.Obras.Item(oRs.Fields("IdObra").Value).Registro.Fields("NumeroObra").Value
         If Not IsNull(oRs.Fields("IdEquipo").Value) Then
            oW.ActiveDocument.FormFields("Equipo").Result = "" & oAp.Equipos.Item(oRs.Fields("IdEquipo").Value).Registro.Fields("Descripcion").Value
            oW.ActiveDocument.FormFields("Tag").Result = "" & oAp.Equipos.Item(oRs.Fields("IdEquipo").Value).Registro.Fields("Tag").Value
         End If
         If Not IsNull(oRs.Fields("IdCliente").Value) Then
            oW.ActiveDocument.FormFields("Cliente").Result = oRsCli.Fields("RazonSocial").Value
         End If
         If Not IsNull(oRs.Fields("IdPlano").Value) Then
            Set oRsPlano = Aplicacion.Planos.Item(oRs.Fields("IdPlano").Value).Registro
            If oRsPlano.RecordCount > 0 Then
               oW.ActiveDocument.FormFields("Plano").Result = oRsPlano.Fields("NumeroPlano").Value & " - " & oRsPlano.Fields("Descripcion").Value
            End If
            oRsPlano.Close
         End If
         If Not IsNull(oRs.Fields("Realizo").Value) Then
            oW.ActiveDocument.FormFields("Realizo").Result = Aplicacion.Empleados.Item(oRs.Fields("Realizo").Value).Registro.Fields("Nombre").Value
         End If
         If Not IsNull(oRs.Fields("Aprobo").Value) Then
            oW.ActiveDocument.FormFields("Aprobo").Result = Aplicacion.Empleados.Item(oRs.Fields("Aprobo").Value).Registro.Fields("Nombre").Value
         End If
         If Len(txtTotalPeso.Text) Then
            oW.ActiveDocument.FormFields("TotalPeso").Result = Format(txtTotalPeso.Text, "Fixed") & " " & mvarUnidadPeso
         End If
          
         oRsDet.Close
         oRsCli.Close
          
         If Index = 0 Then
            If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
            oW.Documents(1).PrintOut False, , , , , , , mCopias
            If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
            oW.Documents(1).Close False
            oW.Quit
         End If
       
      End With
      
   End With
   
   GoTo Salida
   
Mal:

   If Index = 0 Then oW.Quit
   Me.MousePointer = vbDefault
   MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical

Salida:

   Me.MousePointer = vbDefault
   Set oRsDet = Nothing
   Set oRsCli = Nothing
   Set oRsRev = Nothing
   Set oRsArt = Nothing
   Set oRsAco = Nothing
   Set oRsPlano = Nothing
   Set oRsAux = Nothing
   Set oW = Nothing
   Set oAp = Nothing

End Sub

Private Sub cmdPegar_Click()

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long, NroItem As Long
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oAco As ComPronto.Acopio
   Dim oRsDetAco As ADOR.Recordset
   Dim oRs As ADOR.Recordset
   Dim oFld As ADOR.Field

   If Not Clipboard.GetFormat(vbCFText) Then
      MsgBox "No hay informacion en el portapapeles", vbCritical
      Exit Sub
   End If
   
   s = Clipboard.GetText(vbCFText)
   
   Filas = Split(s, vbCrLf) ' armo un vector por filas
   Columnas = Split(Filas(LBound(Filas)), vbTab)
   
   If UBound(Columnas) < 2 Then
      MsgBox "No hay informacion para copiar", vbCritical
      Exit Sub
   End If
   
   If UBound(Filas) < 1 Then
      MsgBox "No hay informacion para copiar", vbCritical
      Exit Sub
   End If
   
'   If UBound(Filas) > 1 Or AcopioIngresado Then
'      MsgBox "No puede copiar mas de una lista de acopio", vbCritical
'      Exit Sub
'   End If
   
   NroItem = 1
   
   If InStr(1, Columnas(LBound(Columnas) + 1), "Acopio") <> 0 Then
   
      Set oAp = Aplicacion
      
      For iFilas = LBound(Filas) + 1 To UBound(Filas) ' recorro las filas
         
         Columnas = Split(Filas(iFilas), vbTab) ' armo un vector con las columnas
         
         Set oAco = oAp.Acopios.Item(Columnas(0))
         Set oRsDetAco = oAco.DetAcopios.TraerTodosSinFormato
         
         Do While Not oRsDetAco.EOF
            With origen.DetLMateriales.Item(-1) ' le pido un Detalle NUEVO (-1)
               .Registro.Fields("IdDetalleAcopios").Value = oRsDetAco.Fields("IdDetalleAcopios").Value
               .Registro.Fields("NumeroItem").Value = 0
               .Registro.Fields("NumeroOrden").Value = origen.DetLMateriales.ProximoItemDetalle(0)
               .Registro.Fields("Cantidad").Value = oRsDetAco.Fields("Cantidad").Value
               .Registro.Fields("Cantidad1").Value = oRsDetAco.Fields("Cantidad1").Value
               .Registro.Fields("Cantidad2").Value = oRsDetAco.Fields("Cantidad2").Value
               .Registro.Fields("IdUnidad").Value = oRsDetAco.Fields("IdUnidad").Value
               .Registro.Fields("IdArticulo").Value = oRsDetAco.Fields("IdArticulo").Value
               .Registro.Fields("Peso").Value = oRsDetAco.Fields("Peso").Value
               .Registro.Fields("IdUnidadPeso").Value = oRsDetAco.Fields("IdUnidadPeso").Value
               .Registro.Fields("IdControlCalidad").Value = oRsDetAco.Fields("IdControlCalidad").Value
               .Registro.Fields("IdDetalleAcopios").Value = oRsDetAco.Fields(0).Value
               .Registro.Fields("Despacha").Value = "NO"
               .Registro.Fields("Adjunto").Value = oRsDetAco.Fields("Adjunto").Value
               For i = 1 To 10
                  .Registro.Fields("ArchivoAdjunto" & i).Value = oRsDetAco.Fields("ArchivoAdjunto" & i).Value
               Next
               origen.Registro.Fields("IdCliente").Value = oAco.Registro.Fields("IdCliente").Value
               origen.Registro.Fields("IdObra").Value = oAco.Registro.Fields("IdObra").Value
               origen.Registro.Fields("Realizo").Value = oAco.Registro.Fields("Realizo").Value
               origen.Registro.Fields("Aprobo").Value = oAco.Registro.Fields("Aprobo").Value
               .Modificado = True
            End With
            NroItem = NroItem + 1
            oRsDetAco.MoveNext
         Loop
         
         Set oRsDetAco = Nothing
         Set oAco = Nothing
         Set oAp = Nothing
         
         Set Lista.DataSource = origen.DetLMateriales.RegistrosConFormato
         
         AcopioIngresado = True
         dcfields(3).Enabled = False
         cmd(2).Enabled = False
         
      Next
      
      Clipboard.Clear
   
   ElseIf Columnas(0) = "LMateriales" And Columnas(1) = "Conj." Then
   
      Set oAp = Aplicacion
      
      For i = 1 To UBound(Filas)
         Columnas = Split(Filas(i), vbTab)
         Set oRs = oAp.LMateriales.Item(0).DetLMateriales.TraerFiltrado("_UnItem", Columnas(0))
         If oRs.RecordCount > 0 Then
            oRs.MoveFirst
            Do While Not oRs.EOF
               With origen.DetLMateriales.Item(-1)
                  For Each oFld In oRs.Fields
                     If oFld.Name <> "IdDetalleLMateriales" Then
                        .Registro.Fields(oFld.Name).Value = oFld.Value
                     End If
                  Next
                  .Modificado = True
               End With
               oRs.MoveNext
            Loop
         End If
         oRs.Close
      Next
         
      Set oRs = origen.DetLMateriales.RegistrosConFormato
      Set Lista.DataSource = oRs
         
      Set oRs = Nothing
      Set oAp = Nothing
         
      Clipboard.Clear
   
   ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "L.Materiales") <> 0 Then
   
      Columnas = Split(Filas(1), vbTab)
      
      Set oAp = Aplicacion
      
      Set oRs = oAp.LMateriales.Item(Columnas(0)).Registro
      With origen.Registro
         For Each oFld In oRs.Fields
            If oFld.Name <> "IdLMateriales" And oFld.Name <> "NumeroLMateriales" And oFld.Name <> "Nombre" Then
               .Fields(oFld.Name).Value = oFld.Value
            End If
         Next
      End With
      oRs.Close
      
      Set oRs = oAp.LMateriales.TraerFiltrado("_PorLMat", Columnas(0))
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            With origen.DetLMateriales.Item(-1)
               For Each oFld In oRs.Fields
                  If oFld.Name <> "IdDetalleLMateriales" Then
                     .Registro.Fields(oFld.Name).Value = oFld.Value
                  End If
               Next
               .Modificado = True
            End With
            oRs.MoveNext
         Loop
      End If
      oRs.Close
      
      Set oRs = origen.DetLMateriales.RegistrosConFormato
      Set Lista.DataSource = oRs
         
      Set oRs = Nothing
      AcopioIngresado = True
'      dcfields(3).Enabled = False
      cmd(2).Enabled = False
         
      Clipboard.Clear
   
   Else
      
      MsgBox "Objeto invalido!"
   
   End If
   
   Set oAp = Nothing
         
   CalculaLMaterial
   
End Sub

Private Sub dcfields_Change(Index As Integer)

   Dim oRsObra, oRsEqu, oRsPln As ADOR.Recordset
   
   If IsNumeric(dcfields(Index).BoundText) Then
      If IsNull(origen.Registro.Fields(dcfields(Index).DataField).Value) Or origen.Registro.Fields(dcfields(Index).DataField).Value <> dcfields(Index).BoundText Then
         origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
      End If
      Select Case Index
         Case 0
            Set oRsObra = Aplicacion.Obras.Item(dcfields(Index).BoundText).Registro
            origen.Registro.Fields("IdCliente").Value = oRsObra.Fields("IdCliente").Value
            oRsObra.Close
'            Set oRsEqu = oAp.Obras.TraerFiltrado("Equipos", dcfields(Index).BoundText)
            Set dcfields(2).RowSource = Aplicacion.Obras.TraerFiltrado("Equipos", dcfields(Index).BoundText)
            origen.Registro.Fields("IdObra").Value = dcfields(Index).BoundText
         Case 2
'            Set oRsPln = oAp.Equipos.TraerFiltrado("Planos", dcfields(Index).BoundText)
            Set dcfields(3).RowSource = Aplicacion.Equipos.TraerFiltrado("Planos", dcfields(Index).BoundText)
            origen.Registro.Fields("IdEquipo").Value = dcfields(Index).BoundText
         Case 3
            origen.Registro.Fields("IdPlano").Value = dcfields(Index).BoundText
      End Select
   Else
      If Index = 4 Or Index = 5 Then
         If Len(Trim(dcfields(Index).Text)) = 0 Then
            origen.Registro.Fields(dcfields(Index).DataField).Value = Null
         End If
      End If
   End If
   
   Set oRsObra = Nothing
   Set oRsEqu = Nothing
   Set oRsPln = Nothing

End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   If Index = 5 And Me.Visible And IsNumeric(dcfields(Index).BoundText) Then
      If dcfields(Index).BoundText <> mIdAprobo Then
         Dim oL As ListItem
         Dim mManual As Boolean
         mManual = False
         For Each oL In Lista.ListItems
            If oL.SmallIcon = "ItemManual" Then
               mManual = True
               Exit For
            End If
         Next
         If mManual Then
            MsgBox "Existen materiales ingresados manualmente," & vbCrLf & "registre primero el alta de los mismos para liberar la LM.", vbCritical
            origen.Registro.Fields(dcfields(Index).DataField).Value = Null
         Else
            PideAutorizacion
         End If
         Set oL = Nothing
      End If
   End If
   
End Sub

Private Sub dcfields_GotFocus(Index As Integer)
   
   If Index <> 5 Then
      SendKeys "%{DOWN}"
   End If

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Activate()
   
'   CalculaLMaterial

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaRev
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaAva
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   For Each oI In Img16.ListImages
      With Estado.Panels.Add(, , oI.Key)
         .Picture = oI.Picture
      End With
   Next

   AcopioIngresado = False
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Lista_Click()

'   If Lista.ListItems.Count <> 0 Then
'      If Len(Trim(Lista.SelectedItem)) Then
'         Dim oRs As ADOR.Recordset
'         Dim NoHay As Boolean
'         NoHay = False
'         Set oRs = origen.DetLMateriales.Item(Lista.SelectedItem.Tag).DetLMaterialesRevisiones.RegistrosConFormato
'         If oRs.RecordCount <> 0 Then
'            Set ListaRev.DataSource = oRs
'         Else
'            Set ListaRev.DataSource = origen.DetLMateriales.Item(Lista.SelectedItem.Tag).DetLMaterialesRevisiones.TraerMascara
'            NoHay = True
'         End If
'         If Option1.Value Then
'            ListaRev.Filtrado = ""
'         ElseIf Option2.Value Then
'            ListaRev.Filtrado = "Tipo='R'"
'         ElseIf Option3.Value Then
'            ListaRev.Filtrado = "Tipo='A'"
'         End If
'         Set oRs = Nothing
'         If NoHay Then
'            ListaRev.ListItems.Clear
'         End If
'      End If
'   End If

End Sub

Private Sub Lista_DblClick()

   If Lista.ListItems.Count <> 0 Then
      If Len(Trim(Lista.SelectedItem.SubItems(4))) = 0 Then
         EditarSubtitulo Lista.SelectedItem.Tag
      Else
         Editar Lista.SelectedItem.Tag
      End If
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
         MnuDetA(4).Enabled = False
         PopupMenu MnuDet, , , , MnuDetA(0)
      Else
         MnuDetA(1).Enabled = True
         MnuDetA(2).Enabled = True
         MnuDetA(4).Enabled = True
         PopupMenu MnuDet, , , , MnuDetA(1)
      End If
   End If

End Sub

Private Sub Lista_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long, NroItem As Long
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oAco As ComPronto.Acopio
   Dim oRsDetAco As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then ' si el dato es texto
      
      s = Data.GetData(ccCFText) ' tomo el dato
      
      Filas = Split(s, vbCrLf) ' armo un vector por filas
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay listas de materiales para copiar", vbCritical
         Exit Sub
      End If
      
      If UBound(Filas) > 1 Or AcopioIngresado Then
         MsgBox "No puede arrastrar mas de una lista de acopio", vbCritical
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 1), "Acopio") <> 0 Then
      
         Set oAp = Aplicacion
         NroItem = 1
         
         For iFilas = LBound(Filas) + 1 To UBound(Filas) ' recorro las filas
            
            Columnas = Split(Filas(iFilas), vbTab) ' armo un vector con las columnas
            
            Set oAco = oAp.Acopios.Item(Columnas(0))
            Set oRsDetAco = oAco.DetAcopios.TraerTodosSinFormato
            
            Do While Not oRsDetAco.EOF
               With origen.DetLMateriales.Item(-1) ' le pido un Detalle NUEVO (-1)
                  .Registro.Fields("IdDetalleAcopios").Value = oRsDetAco.Fields("IdDetalleAcopios").Value
                  .Registro.Fields("NumeroItem").Value = 0
                  .Registro.Fields("NumeroOrden").Value = origen.DetLMateriales.ProximoItemDetalle(0)
'                  .Registro.Fields("Revision").Value = 0
                  .Registro.Fields("Cantidad").Value = oRsDetAco.Fields("Cantidad").Value
                  .Registro.Fields("Cantidad1").Value = oRsDetAco.Fields("Cantidad1").Value
                  .Registro.Fields("Cantidad2").Value = oRsDetAco.Fields("Cantidad2").Value
                  .Registro.Fields("IdUnidad").Value = oRsDetAco.Fields("IdUnidad").Value
                  .Registro.Fields("IdArticulo").Value = oRsDetAco.Fields("IdArticulo").Value
                  .Registro.Fields("Peso").Value = oRsDetAco.Fields("Peso").Value
                  .Registro.Fields("IdUnidadPeso").Value = oRsDetAco.Fields("IdUnidadPeso").Value
                  .Registro.Fields("IdControlCalidad").Value = oRsDetAco.Fields("IdControlCalidad").Value
                  .Registro.Fields("IdDetalleAcopios").Value = oRsDetAco.Fields(0).Value
                  .Registro.Fields("Despacha").Value = "NO"
                  .Registro.Fields("Adjunto").Value = oRsDetAco.Fields("Adjunto").Value
                  For i = 1 To 10
                     .Registro.Fields("ArchivoAdjunto" & i).Value = oRsDetAco.Fields("ArchivoAdjunto" & i).Value
                  Next
                  origen.Registro.Fields("IdCliente").Value = oAco.Registro.Fields("IdCliente").Value
                  origen.Registro.Fields("IdObra").Value = oAco.Registro.Fields("IdObra").Value
                  origen.Registro.Fields("Realizo").Value = oAco.Registro.Fields("Realizo").Value
                  origen.Registro.Fields("Aprobo").Value = oAco.Registro.Fields("Aprobo").Value
                  .Modificado = True
               End With
               NroItem = NroItem + 1
               oRsDetAco.MoveNext
            Loop
            
            Set oRsDetAco = Nothing
            Set oAco = Nothing
            
            Set Lista.DataSource = origen.DetLMateriales.RegistrosConFormato
            
            AcopioIngresado = True
            
         Next
         
         Clipboard.Clear
      
      ElseIf InStr(1, Columnas(LBound(Columnas) + 2), "conjunto") <> 0 Then
      
         If Not IsNumeric(dcfields(3).BoundText) Then
            MsgBox "Antes de agregar un conjunto defina el plano de la lista de materiales", vbCritical
            Exit Sub
         End If
      
         Filas = Split(s, vbCrLf)
         Columnas = Split(Filas(1), vbTab)
         NroItem = 1
      
         Dim oF As frm_Aux
         Dim mOk As Boolean
         Dim mCantidadConjuntos, mIdControlCalidadStandar, mConjunto As Integer
         Dim mConjuntoDetalle As String
         
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
         
         Me.Refresh
         Me.MousePointer = vbHourglass
         DoEvents

         Set oAp = Aplicacion
         
         Set oRsAux = oAp.Parametros.Item(1).Registro
         mIdControlCalidadStandar = IIf(IsNull(oRsAux.Fields("IdControlCalidadStandar").Value), 0, oRsAux.Fields("IdControlCalidadStandar").Value)
         oRsAux.Close
         Set oRsAux = Nothing
         
         For iFilas = LBound(Filas) + 1 To UBound(Filas) ' recorro las filas
            
            Columnas = Split(Filas(iFilas), vbTab) ' armo un vector con las columnas
            
            mConjunto = origen.DetLMateriales.ProximoConjunto
            
            Set oRsDet = oAp.Conjuntos.TraerFiltrado("_PorIdConDatos", Columnas(0))
            If oRsDet.RecordCount > 0 Then
               mConjuntoDetalle = "Conj. " & IIf(IsNull(oRsDet.Fields("Codigo conjunto").Value), "", oRsDet.Fields("Codigo conjunto").Value) & " - " & _
                        IIf(IsNull(oRsDet.Fields("Codigo").Value), "", oRsDet.Fields("Codigo").Value) & " " & _
                        IIf(IsNull(oRsDet.Fields("Articulo conjunto").Value), "", oRsDet.Fields("Articulo conjunto").Value)
               With origen.DetLMateriales.Item(-1)
                  With .Registro
                     .Fields("Despacha").Value = "NO"
                     .Fields("NumeroItem").Value = mConjunto
                     .Fields("Detalle").Value = mId(mConjuntoDetalle, 1, 50)
                  End With
                  .Modificado = True
               End With
            End If
            oRsDet.Close
            
            Set oRsDet = oAp.Conjuntos.TraerFiltrado("_DetallesPorId", Columnas(0))
         
            Do While Not oRsDet.EOF
               With origen.DetLMateriales.Item(-1)
                  With .Registro
                     .Fields("NumeroItem").Value = mConjunto
                     .Fields("NumeroOrden").Value = origen.DetLMateriales.ProximoItemDetalle(0)
                     .Fields("Cantidad").Value = oRsDet.Fields("Cantidad").Value * mCantidadConjuntos
                     .Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
                     .Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
                     .Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                     .Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                     .Fields("IdControlCalidad").Value = mIdControlCalidadStandar
                     .Fields("Despacha").Value = "NO"
                     .Fields("Adjunto").Value = "NO"
                     .Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
                     .Fields("IdPlano").Value = dcfields(3).BoundText
                  End With
                  .Modificado = True
               End With
               NroItem = NroItem + 1
               oRsDet.MoveNext
            Loop
            
            oRsDet.Close
            Set oRsDet = Nothing
            
            Set Lista.DataSource = origen.DetLMateriales.RegistrosConFormato
            
         Next
         
         Clipboard.Clear
         Me.MousePointer = vbDefault
      
      Else
         
         MsgBox "Objeto invalido!"
      
      End If

   End If
   
   Set oAp = Nothing
   
   CalculaLMaterial
            
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

Private Sub ListaAva_DblClick()

   If ListaAva.ListItems.Count <> 0 Then
      EditarAva ListaAva.SelectedItem.Tag
   End If

End Sub

Private Sub ListaAva_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaAva_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetC_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetC_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetC_Click 1
   End If

End Sub

Private Sub ListaAva_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If ListaAva.ListItems.Count = 0 Then
         MnuDetC(1).Enabled = False
         MnuDetC(2).Enabled = False
         PopupMenu MnuDetAva, , , , MnuDetC(0)
      Else
         MnuDetC(1).Enabled = True
         MnuDetC(2).Enabled = True
         PopupMenu MnuDetAva, , , , MnuDetC(1)
      End If
   End If

End Sub

Private Sub ListaAva_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long, NroItem As Long
   Dim oL As ListItem
   
   If Data.GetFormat(ccCFText) Then ' si el dato es texto
      
      s = Data.GetData(ccCFText) ' tomo el dato
      
      Filas = Split(s, vbCrLf) ' armo un vector por filas
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 1), "Conj.") <> 0 Then
         Columnas = Split(Filas(1), vbTab)
            
         Dim oF As frmDetLMaterialesRevision
         Dim oAp As ComPronto.Aplicacion
         
         Set oF = New frmDetLMaterialesRevision
         
         origen.Registro.Fields(DTFields(0).DataField).Value = DTFields(0).Value
         
         With oF
            Set .LMaterial = origen
            .TipoRevision = "A"
            .IdDetalleLMateriales = Columnas(0)
            .Id = -1
            .Show vbModal, Me
            If .Aceptado Then
               Set oL = ListaAva.ListItems.Add
               oL.Tag = .IdNuevo
               With oL
                  .SmallIcon = "Nuevo"
                  .Text = oF.txtConjunto.Text
                  .SubItems(1) = "" & oF.txtPosicion.Text
                  .SubItems(2) = "" & oF.txtRevision.Text
                  .SubItems(3) = "" & oF.txtNumeroRevision.Text
                  .SubItems(4) = "" & oF.DTFields(0).Value
                  .SubItems(5) = "" & oF.txtDetalle.Text
                  If IsNumeric(oF.dcfields(0).BoundText) Then
                     .SubItems(6) = "" & Aplicacion.Empleados.Item(oF.dcfields(0).BoundText).Registro.Fields("Iniciales").Value
                  End If
                  .SubItems(7) = "" & oF.DTFields(1).Value
                  If IsNumeric(oF.dcfields(1).BoundText) Then
                     .SubItems(8) = "" & Aplicacion.Empleados.Item(oF.dcfields(1).BoundText).Registro.Fields("Iniciales").Value
                  End If
                  .SubItems(9) = "" & oF.DTFields(2).Value
               End With
               Lista.SelectedItem.ForeColor = vbBlue
               Lista.SelectedItem.SmallIcon = "Avance"
            End If
         End With
         
         Unload oF
         
         Set oF = Nothing
   
         Clipboard.Clear
      
      Else
         
         MsgBox "Objeto invalido!"
      
      End If

   End If
   
End Sub

Private Sub ListaAva_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

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

Private Sub ListaAva_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub ListaRev_DblClick()
   
   If ListaRev.ListItems.Count <> 0 Then
      EditarRev ListaRev.SelectedItem.Tag
   End If

End Sub

Private Sub ListaRev_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaRev_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetB_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetB_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetB_Click 1
   End If

End Sub

Private Sub ListaRev_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
   
   If Button = vbRightButton Then
      If ListaRev.ListItems.Count = 0 Then
         MnuDetB(1).Enabled = False
         MnuDetB(2).Enabled = False
         PopupMenu MnuDetRev, , , , MnuDetB(0)
      Else
         MnuDetB(1).Enabled = True
         MnuDetB(2).Enabled = True
         PopupMenu MnuDetRev, , , , MnuDetB(1)
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         If Not Lista.SelectedItem Is Nothing Then
            If Len(Trim(Lista.SelectedItem.SubItems(4))) = 0 Then
               EditarSubtitulo Lista.SelectedItem.Tag
            Else
               Editar Lista.SelectedItem.Tag
            End If
         End If
      Case 2
         If Not Lista.SelectedItem Is Nothing Then
            With Lista.SelectedItem
               origen.DetLMateriales.Item(.Tag).Eliminado = True
               .SmallIcon = "Eliminado"
               .ToolTipText = .SmallIcon
            End With
            CalculaLMaterial
         End If
      Case 3
         EditarSubtitulo -1
      Case 4
         If Not Lista.SelectedItem Is Nothing Then
            CopiarItem Lista.SelectedItem.Tag
         End If
      Case 5
         If Not Lista.SelectedItem Is Nothing Then AsignaRevision
      Case 6
         If Not Lista.SelectedItem Is Nothing Then AsignarDestino
   End Select

End Sub

Private Sub MnuDetB_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarRev -1
      Case 1
         If Not ListaRev.SelectedItem Is Nothing Then
            EditarRev ListaRev.SelectedItem.Tag
         End If
      Case 2
         If Not ListaRev.SelectedItem Is Nothing And Not Lista.SelectedItem Is Nothing Then
            With ListaRev.SelectedItem
               origen.DetLMaterialesRevisiones.Item(.Tag).Eliminado = True
               .SmallIcon = "Eliminado"
               .ToolTipText = .SmallIcon
            End With
         End If
   End Select

End Sub

Private Sub MnuDetC_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarAva -1
      Case 1
         If Not ListaAva.SelectedItem Is Nothing Then
            EditarAva ListaAva.SelectedItem.Tag
         End If
      Case 2
         If Not ListaAva.SelectedItem Is Nothing And Not Lista.SelectedItem Is Nothing Then
            With ListaAva.SelectedItem
               origen.DetLMaterialesRevisiones.Item(.Tag).Eliminado = True
               .SmallIcon = "Eliminado"
               .ToolTipText = .SmallIcon
            End With
         End If
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

Private Sub CalculaLMaterial()

   Dim t0 As Double, t1 As Double, t2 As Double, t3 As Double, tLMaterial As Double
   Dim oRs As ADOR.Recordset
   Dim i As Integer
   
   t0 = 0
   t1 = 0
   t2 = 0
   t3 = 0
   tLMaterial = 0
   
   For i = 1 To Lista.ListItems.Count
      If Not origen.DetLMateriales.Item(Lista.ListItems(i).Tag).Eliminado Then
'         t0 = t0 + Val(Lista.object.ListItems(i).ListSubItems(2).Text)
'         t1 = t1 + Val(mId(Lista.object.ListItems(i).ListSubItems(9).Text, 2, 10))
'         t2 = t2 + Val(mId(Lista.object.ListItems(i).ListSubItems(6).Text, 2, 10))
'         t3 = t3 + Val(mId(Lista.object.ListItems(i).ListSubItems(8).Text, 2, 10))
         t2 = t2 + Val(Lista.ListItems(i).SubItems(11))
         t3 = t3 + Val(Lista.ListItems(i).SubItems(13))
      End If
   Next
   
   tLMaterial = Round(t1 * t0, 2)
'   txtTotal(0).Text = Format(tLMaterial, "$###,##0.00")
   txtTotalPeso.Text = origen.DetLMateriales.TotalPeso
   txtTotal(0).Text = Format(t2, "#,##0.00")
   txtTotal(1).Text = Format(t3, "#,##0.00")
   
End Sub

Private Sub txtEmbalo_GotFocus()

   With txtEmbalo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtEmbalo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtEmbalo
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

'Private Sub Option1_Click()
'
'   If Option1.Value And mHayRevisiones Then
'      ListaRev.Filtrado = ""
'   End If
'
'End Sub
'
'Private Sub Option2_Click()
'
'   If Option2.Value And mHayRevisiones Then
'      ListaRev.Filtrado = "Tipo='R'"
'   End If
'
'End Sub
'
'Private Sub Option3_Click()
'
'   If Option3.Value And mHayRevisiones Then
'      ListaRev.Filtrado = "Tipo='A'"
'   End If
'
'End Sub

Private Sub txtNombre_GotFocus()

   With txtNombre
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtNombre
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtNombre_Validate(Cancel As Boolean)

   If Len(Trim(txtNombre.Text)) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.LMateriales.TraerFiltrado("Nombre", Trim(txtNombre.Text))
      If oRs.RecordCount > 0 Then
         If oRs.Fields(0).Value <> mvarId Then
            MsgBox "Lista de materiales ya ingresada el " & oRs.Fields("Fecha").Value & ". Reingrese.", vbCritical
            Cancel = True
         End If
      End If
      oRs.Close
      Set oRs = Nothing
   End If

End Sub

Private Sub txtNumeroLMateriales_GotFocus()

   With txtNumeroLMateriales
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroLMateriales_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub CopiarItem(ByVal Cual As Long)

   Dim oRs As ADOR.Recordset
   Dim oL As ListItem, oL1 As ListItem
   Dim oDet As DetLMaterial
   Dim i As Integer
   
   Set oRs = origen.DetLMateriales.Item(Cual).Registro
   Set oDet = origen.DetLMateriales.Item(-1)
   
   With oDet
      For i = 2 To oRs.Fields.Count - 1
         .Registro.Fields(i).Value = oRs.Fields(i).Value
      Next
      .Registro.Fields("NumeroOrden").Value = origen.DetLMateriales.ProximoItemDetalle(oRs.Fields("NumeroItem").Value)
      .Modificado = True
   End With

'   oRs.Close
   Set oRs = Nothing

   Set oL = Lista.SelectedItem
   Set oL1 = Lista.ListItems.Add
   
   With oL1
      .Text = "" & oDet.Registro.Fields("NumeroItem").Value
      .SubItems(1) = "" & oDet.Registro.Fields("NumeroOrden").Value
      .SubItems(2) = oL.SubItems(2)
      .SubItems(3) = oL.SubItems(3)
      .SubItems(4) = oL.SubItems(4)
      .SubItems(5) = oL.SubItems(5)
      .SubItems(6) = oL.SubItems(6)
      .SubItems(7) = oL.SubItems(7)
      .SubItems(8) = oL.SubItems(8)
      .SubItems(9) = oL.SubItems(9)
      .SubItems(10) = oL.SubItems(10)
      .SubItems(11) = oL.SubItems(11)
      .SubItems(12) = oL.SubItems(12)
      .SubItems(13) = oL.SubItems(13)
      .Tag = oDet.Id
      .SmallIcon = "Nuevo"
   End With
   
   Set oL = Nothing
   Set oL1 = Nothing
   Set oDet = Nothing

End Sub

Public Sub AsignaRevision()

   Dim oF As frmAsignaRevision
   Dim oL As ListItem
   Dim oDet As ComPronto.DetLMaterial
   Dim mvarRevision As String
   Dim mvarOK As Boolean
   
   Set oF = New frmAsignaRevision
   
   With oF
      .Show vbModal, Me
      mvarOK = .Ok
      mvarRevision = .txtRevision.Text
   End With
   
   Unload oF
   Set oF = Nothing
   
   If Not mvarOK Then
      Exit Sub
   End If
   
   For Each oL In Lista.ListItems
      With oL
         Set oDet = origen.DetLMateriales.Item(.Tag)
         If Not IsNull(oDet.Registro.Fields("IdArticulo").Value) Then
            If IsNull(oDet.Registro.Fields("Revision").Value) Or _
               (Not IsNull(oDet.Registro.Fields("Revision").Value) And oDet.Registro.Fields("Revision").Value <> mvarRevision) Then
'Len(Trim(oDet.Registro.Fields("Revision").Value)) <> 0 Then
               .SubItems(2) = ""
               oDet.Registro.Fields("Revision").Value = ""
               oDet.Modificado = True
               .SmallIcon = "Modificado"
            End If
         End If
         Set oDet = Nothing
      End With
   Next
   
   For Each oL In Lista.ListItems
      With oL
         If .Selected Then
            Set oDet = origen.DetLMateriales.Item(.Tag)
            If Not IsNull(oDet.Registro.Fields("IdArticulo").Value) Then
               .SubItems(2) = "" & mvarRevision
               oDet.Registro.Fields("Revision").Value = mvarRevision
               oDet.Modificado = True
               .SmallIcon = "Modificado"
            End If
            Set oDet = Nothing
         End If
      End With
   Next
   
End Sub

Public Sub AsignarDestino()

   If Not IsNumeric(dcfields(0).BoundText) Then
      MsgBox "Indique primero la obra", vbExclamation
      Exit Sub
   End If
   
   Dim of1 As frmAsignaComprador
   Dim oL As ListItem
   Dim mIdDetalleObraDestino As Long
   Dim mOk As Boolean
   
   Set of1 = New frmAsignaComprador
   With of1
      .Id = 3
      With .DataCombo1(0)
         .BoundColumn = "IdDetalleObraDestino"
         Set .RowSource = Aplicacion.Obras.TraerFiltrado("_DestinosParaComboPorIdObra", dcfields(0).BoundText)
      End With
      .Show vbModal, Me
      mOk = .Ok
      If mOk Then mIdDetalleObraDestino = .DataCombo1(0).BoundText
   End With
   Unload of1
   Set of1 = Nothing
   
   If Not mOk Then Exit Sub
   
   For Each oL In Lista.ListItems
      With oL
         If .Selected Then
            With origen.DetLMateriales.Item(.Tag)
               .Registro.Fields("IdDetalleObraDestino").Value = mIdDetalleObraDestino
               .Modificado = True
            End With
            .SmallIcon = "Modificado"
         End If
      End With
   Next

End Sub

Private Sub PideAutorizacion()

   Dim oF As frmAutorizacion1
   Set oF = New frmAutorizacion1
   With oF
      .IdUsuario = dcfields(5).BoundText
      .Show vbModal, Me
   End With
   If Not oF.Ok Then
      With origen.Registro
         .Fields(dcfields(5).DataField).Value = Null
'         .Fields("FechaAprobacion").Value = Null
      End With
      Check1(0).Value = 0
      mIdAprobo = 0
   Else
      With origen.Registro
'         .Fields("FechaAprobacion").Value = Now
         mIdAprobo = IIf(IsNull(.Fields("Aprobo").Value), 0, .Fields("Aprobo").Value)
      End With
      Check1(0).Value = 1
   End If
   Unload oF
   Set oF = Nothing

End Sub

