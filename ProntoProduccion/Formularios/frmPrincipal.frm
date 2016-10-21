VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.3#0"; "Controles1013.ocx"
Begin VB.Form frmPrincipal 
   Appearance      =   0  'Flat
   ClientHeight    =   11145
   ClientLeft      =   225
   ClientTop       =   555
   ClientWidth     =   12795
   Icon            =   "frmPrincipal.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   11145
   ScaleWidth      =   12795
   WindowState     =   2  'Maximized
   Begin VB.CommandButton Command9 
      Caption         =   "test"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   405
      Left            =   4440
      TabIndex        =   60
      Top             =   0
      Visible         =   0   'False
      Width           =   1695
   End
   Begin VB.CommandButton cmdParte 
      Appearance      =   0  'Flat
      Caption         =   "Parte nuevo"
      Height          =   370
      Left            =   3000
      MaskColor       =   &H8000000F&
      Style           =   1  'Graphical
      TabIndex        =   59
      Top             =   0
      Width           =   1215
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   4800
      Top             =   -120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   38
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":076A
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":087C
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":098E
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":0AA0
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":0BB2
            Key             =   "Cut"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":0CC4
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":0DD6
            Key             =   "Paste"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":0EE8
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":0FFA
            Key             =   "Undo"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":110C
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":121E
            Key             =   "Sort Ascending"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1330
            Key             =   "Sort Descending"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1442
            Key             =   "Up One Level"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1554
            Key             =   "View Large Icons"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1666
            Key             =   "View Small Icons"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1778
            Key             =   "View List"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":188A
            Key             =   "View Details"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":199C
            Key             =   "Properties"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1AAE
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1BC0
            Key             =   "Help What's This"
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1CD2
            Key             =   "CopiarCampo"
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2124
            Key             =   "ActualizaMateriales"
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":243E
            Key             =   "Excel"
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2890
            Key             =   "Refrescar"
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2BAA
            Key             =   "Parametros"
         EndProperty
         BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2EC4
            Key             =   "Empresa"
         EndProperty
         BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":31DE
            Key             =   "RefrescarArbol"
         EndProperty
         BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":34F8
            Key             =   "EnviarCorreo1"
         EndProperty
         BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5CAA
            Key             =   "EnviarCorreo"
         EndProperty
         BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5FC4
            Key             =   "LeerCorreo"
         EndProperty
         BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":62DE
            Key             =   "EnviarMensaje"
         EndProperty
         BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":6730
            Key             =   "EstadoObras"
         EndProperty
         BeginProperty ListImage33 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":6A4A
            Key             =   "MenuPopUp"
         EndProperty
         BeginProperty ListImage34 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":6D64
            Key             =   "ImportarDATANET"
         EndProperty
         BeginProperty ListImage35 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":71B6
            Key             =   "AccesoPorUsuarios"
         EndProperty
         BeginProperty ListImage36 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":74D0
            Key             =   "Calculadora"
         EndProperty
         BeginProperty ListImage37 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":77EA
            Key             =   "Sumar"
         EndProperty
         BeginProperty ListImage38 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":7D84
            Key             =   "Idioma"
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame3 
      Caption         =   "Panel de Operador (quien soy?) qué maquina ocupo?"
      Height          =   9975
      Left            =   3840
      TabIndex        =   35
      Top             =   3600
      Visible         =   0   'False
      Width           =   10575
      Begin VB.CommandButton Command7 
         Caption         =   "ocupar máquina"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   18
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1455
         Index           =   2
         Left            =   6000
         TabIndex        =   58
         Top             =   1560
         Width           =   3135
      End
      Begin VB.CommandButton cmdCrearOP 
         Caption         =   "crear OP desde fichas activas"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1335
         Index           =   2
         Left            =   3120
         TabIndex        =   52
         Top             =   360
         Width           =   2295
      End
      Begin VB.CommandButton Command7 
         Caption         =   "Pedidos pendientes"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1335
         Index           =   1
         Left            =   360
         TabIndex        =   51
         Top             =   360
         Width           =   2295
      End
      Begin VB.CommandButton Command8 
         Caption         =   "informar paro"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1455
         Left            =   6000
         TabIndex        =   41
         Top             =   6600
         Width           =   3135
      End
      Begin VB.CommandButton Command7 
         Caption         =   "informar consumo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   18
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1455
         Index           =   0
         Left            =   6000
         TabIndex        =   40
         Top             =   3240
         Width           =   3135
      End
      Begin VB.CommandButton Command6 
         Caption         =   "informar horas trabajadas"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   18
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1455
         Left            =   6000
         TabIndex        =   39
         Top             =   4920
         Width           =   3135
      End
      Begin VB.CommandButton Command5 
         Caption         =   "informar producto terminado"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   18
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1455
         Left            =   6000
         TabIndex        =   38
         Top             =   8280
         Width           =   3135
      End
      Begin VB.CommandButton Command4 
         Caption         =   "cerrar parte actual"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1455
         Left            =   1560
         TabIndex        =   37
         Top             =   6840
         Width           =   3255
      End
      Begin VB.CommandButton Command3 
         Caption         =   "Iniciar Parte (cerrando actual)"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   24
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   4695
         Left            =   1560
         TabIndex        =   36
         Top             =   1920
         Width           =   3255
      End
   End
   Begin VB.CommandButton cmdOcuparMaquina 
      Caption         =   "aviso q ocupo maquina>>>cual?>>>para qué proceso?"
      Height          =   615
      Left            =   1320
      TabIndex        =   57
      Top             =   8520
      Width           =   2055
   End
   Begin VB.ComboBox txtBuscador 
      Height          =   315
      Left            =   6600
      TabIndex        =   56
      Text            =   "Combo1"
      Top             =   120
      Width           =   3975
   End
   Begin VB.CommandButton cmdDuplicar 
      Caption         =   "duplicar"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   10920
      TabIndex        =   53
      Top             =   120
      Width           =   1215
   End
   Begin VB.CommandButton cmdMapa 
      Caption         =   "Ver Mapa"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   0
      TabIndex        =   50
      Top             =   6720
      Visible         =   0   'False
      Width           =   3495
   End
   Begin VB.CommandButton cmdNuevoParte 
      Caption         =   "Nuevo Parte (F5)"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   555
      Left            =   0
      TabIndex        =   49
      Top             =   7440
      Width           =   3495
   End
   Begin VB.CommandButton cmdCrearOP 
      Caption         =   "Nueva Orden (F9)"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Index           =   0
      Left            =   0
      TabIndex        =   48
      Top             =   7920
      Width           =   3495
   End
   Begin VB.CommandButton cmdCancelBusq 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      Caption         =   "x"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Left            =   10560
      MaskColor       =   &H00FFFFFF&
      Style           =   1  'Graphical
      TabIndex        =   47
      Top             =   120
      Width           =   255
   End
   Begin VB.Frame Frame2 
      Caption         =   "Frame2"
      Height          =   4575
      Left            =   20
      TabIndex        =   27
      Top             =   6120
      Width           =   3375
      Begin VB.CommandButton Command2 
         Caption         =   "Me voy. Cerrar parte actual"
         Height          =   615
         Left            =   0
         TabIndex        =   43
         Top             =   3960
         Width           =   1335
      End
      Begin VB.CommandButton Command1 
         Caption         =   "iniciar turno/parte del dia  (cerrando actual, max 24hs)"
         Height          =   1575
         Left            =   0
         TabIndex        =   42
         Top             =   2400
         Width           =   1335
      End
      Begin VB.CommandButton cmdGenerado 
         Caption         =   "produje"
         Height          =   495
         Left            =   1320
         TabIndex        =   31
         Top             =   4080
         Width           =   2055
      End
      Begin VB.CommandButton cmdHorasTrabajadas 
         Caption         =   "informar horas trabajadas >> cual de mis procesos?"
         Height          =   495
         Left            =   1320
         TabIndex        =   30
         Top             =   3600
         Width           =   2055
      End
      Begin VB.CommandButton cmdParteDe 
         Caption         =   "consumí >> q proceso/articulo>>> q peso?"
         Height          =   615
         Left            =   1320
         TabIndex        =   29
         Top             =   3000
         Width           =   2055
      End
      Begin VB.ListBox listboxFiltroPeriodo 
         Appearance      =   0  'Flat
         BackColor       =   &H8000000F&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1230
         ItemData        =   "frmPrincipal.frx":865E
         Left            =   0
         List            =   "frmPrincipal.frx":866B
         TabIndex        =   28
         Top             =   0
         Width           =   3495
      End
      Begin VB.Line Line9 
         X1              =   240
         X2              =   3120
         Y1              =   3360
         Y2              =   3360
      End
   End
   Begin VB.CommandButton cmdPP 
      Caption         =   "PP"
      Height          =   735
      Left            =   7680
      TabIndex        =   12
      TabStop         =   0   'False
      Top             =   3960
      Visible         =   0   'False
      Width           =   1695
   End
   Begin VB.CommandButton cmdOP 
      Caption         =   "OP"
      Height          =   735
      Left            =   7680
      TabIndex        =   11
      TabStop         =   0   'False
      Top             =   3000
      Visible         =   0   'False
      Width           =   1695
   End
   Begin VB.CommandButton cmdCommand3 
      Caption         =   "CPR"
      Height          =   855
      Left            =   4320
      TabIndex        =   10
      TabStop         =   0   'False
      Top             =   3480
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.CommandButton cmdCommand1 
      Caption         =   "MPS"
      Height          =   855
      Left            =   4320
      TabIndex        =   8
      TabStop         =   0   'False
      Top             =   960
      Visible         =   0   'False
      Width           =   1935
   End
   Begin MSComctlLib.ImageList img32 
      Left            =   5400
      Top             =   5670
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   174
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":86A1
            Key             =   "Abierto"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":8AF3
            Key             =   "Ppal"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":8E0D
            Key             =   "Abierto1"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":925F
            Key             =   "Cerrado"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":96B1
            Key             =   "Cerrado1"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":9B03
            Key             =   "TablasG"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":C2B5
            Key             =   "Rubros"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":C5CF
            Key             =   "Familias"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":C8E9
            Key             =   "Subrubros"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":CC03
            Key             =   "TTermicos"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":CF1D
            Key             =   "Depositos"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":D237
            Key             =   "Tipos"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":D551
            Key             =   "Unidades"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":D86B
            Key             =   "Acabados"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":DB85
            Key             =   "Calidades"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":DE9F
            Key             =   "Materiales"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":ED79
            Key             =   "LAcopio"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":F093
            Key             =   "LMateriales"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":F3AD
            Key             =   "InformesC"
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":FC87
            Key             =   "EstadosP"
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":FFA1
            Key             =   "MovStock"
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":103F3
            Key             =   "ProveedoresRubros"
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1070D
            Key             =   "Paises"
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":10A27
            Key             =   "Relaciones"
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":10D41
            Key             =   "CodigosUniversales"
         EndProperty
         BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1105B
            Key             =   "Series"
         EndProperty
         BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":11935
            Key             =   "Formas"
         EndProperty
         BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":11C4F
            Key             =   "Obras2"
         EndProperty
         BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":11F69
            Key             =   "DefinicionesArt"
         EndProperty
         BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":12283
            Key             =   "ControlesCalidad"
         EndProperty
         BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":13A15
            Key             =   "Obras1"
         EndProperty
         BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":13D2F
            Key             =   "Schedulers"
         EndProperty
         BeginProperty ListImage33 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":14049
            Key             =   "Grados"
         EndProperty
         BeginProperty ListImage34 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":14363
            Key             =   "Equipos"
         EndProperty
         BeginProperty ListImage35 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1467D
            Key             =   "AcoCalidades"
         EndProperty
         BeginProperty ListImage36 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":14997
            Key             =   "AcotarTablas"
         EndProperty
         BeginProperty ListImage37 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":14CB1
            Key             =   "AcoMateriales"
         EndProperty
         BeginProperty ListImage38 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":14FCB
            Key             =   "AcoGrados"
         EndProperty
         BeginProperty ListImage39 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":152E5
            Key             =   "AcoSeries"
         EndProperty
         BeginProperty ListImage40 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":155FF
            Key             =   "AcoTratamientos"
         EndProperty
         BeginProperty ListImage41 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":15919
            Key             =   "Colores"
         EndProperty
         BeginProperty ListImage42 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":15C33
            Key             =   "Normas"
         EndProperty
         BeginProperty ListImage43 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1650D
            Key             =   "AcoTipos"
         EndProperty
         BeginProperty ListImage44 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":16827
            Key             =   "Localidades"
         EndProperty
         BeginProperty ListImage45 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":16B41
            Key             =   "Provincias"
         EndProperty
         BeginProperty ListImage46 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":16E5B
            Key             =   "Rangos"
         EndProperty
         BeginProperty ListImage47 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":17175
            Key             =   "Modelos"
         EndProperty
         BeginProperty ListImage48 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":17A4F
            Key             =   "AlimentacionesElectricas"
         EndProperty
         BeginProperty ListImage49 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":17D69
            Key             =   "Marcas"
         EndProperty
         BeginProperty ListImage50 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":19A43
            Key             =   "AniosNorma"
         EndProperty
         BeginProperty ListImage51 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1A31D
            Key             =   "AcoFormas"
         EndProperty
         BeginProperty ListImage52 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1A637
            Key             =   "AcoMarcas"
         EndProperty
         BeginProperty ListImage53 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1A951
            Key             =   "AcoModelos"
         EndProperty
         BeginProperty ListImage54 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1AC6B
            Key             =   "AcoNormas"
         EndProperty
         BeginProperty ListImage55 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1AF85
            Key             =   "Planos"
         EndProperty
         BeginProperty ListImage56 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1B29F
            Key             =   "AcoCodigos"
         EndProperty
         BeginProperty ListImage57 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1B5B9
            Key             =   "AcoSchedulers"
         EndProperty
         BeginProperty ListImage58 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1B8D3
            Key             =   "Codigos"
         EndProperty
         BeginProperty ListImage59 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1BBED
            Key             =   "AcoAcabados"
         EndProperty
         BeginProperty ListImage60 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1BF07
            Key             =   "CentrosCosto"
         EndProperty
         BeginProperty ListImage61 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1C221
            Key             =   "AcoBiselados"
         EndProperty
         BeginProperty ListImage62 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1C53B
            Key             =   "AcoTiposRosca"
         EndProperty
         BeginProperty ListImage63 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1C855
            Key             =   "CalidadesClad"
         EndProperty
         BeginProperty ListImage64 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1CB6F
            Key             =   "Biselados"
         EndProperty
         BeginProperty ListImage65 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1D9C1
            Key             =   "TiposRosca"
         EndProperty
         BeginProperty ListImage66 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1DCE3
            Key             =   "Sectores"
         EndProperty
         BeginProperty ListImage67 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1DFFD
            Key             =   "Cargos"
         EndProperty
         BeginProperty ListImage68 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1E317
            Key             =   "Densidades"
         EndProperty
         BeginProperty ListImage69 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1E631
            Key             =   "Historicos"
         EndProperty
         BeginProperty ListImage70 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1EA83
            Key             =   "Transportistas"
         EndProperty
         BeginProperty ListImage71 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1F35D
            Key             =   "HistObras"
         EndProperty
         BeginProperty ListImage72 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":1FC37
            Key             =   "HLAcopios"
         EndProperty
         BeginProperty ListImage73 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":20511
            Key             =   "HLMateriales"
         EndProperty
         BeginProperty ListImage74 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":20DEB
            Key             =   "HRequerimientos"
         EndProperty
         BeginProperty ListImage75 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":216C5
            Key             =   "HPedidos"
         EndProperty
         BeginProperty ListImage76 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":21F9F
            Key             =   "Monedas"
         EndProperty
         BeginProperty ListImage77 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":222B9
            Key             =   "ArchivosATransmitirDestinos"
         EndProperty
         BeginProperty ListImage78 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":225D3
            Key             =   "AcoColores"
         EndProperty
         BeginProperty ListImage79 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":228ED
            Key             =   "ItemsPopUpMateriales"
         EndProperty
         BeginProperty ListImage80 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":22D3F
            Key             =   "Comercial"
         EndProperty
         BeginProperty ListImage81 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":23059
            Key             =   "LMaterialesPorObras"
         EndProperty
         BeginProperty ListImage82 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":23373
            Key             =   "Conceptos"
         EndProperty
         BeginProperty ListImage83 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2368D
            Key             =   "OrdenesCompra"
         EndProperty
         BeginProperty ListImage84 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":239A7
            Key             =   "Facturas"
         EndProperty
         BeginProperty ListImage85 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":23CC1
            Key             =   "Devoluciones"
         EndProperty
         BeginProperty ListImage86 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":23FDB
            Key             =   "NotasDebito"
         EndProperty
         BeginProperty ListImage87 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":242F5
            Key             =   "NotasCredito"
         EndProperty
         BeginProperty ListImage88 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2460F
            Key             =   "Recibos"
         EndProperty
         BeginProperty ListImage89 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":24EE9
            Key             =   "CtasCtesD"
         EndProperty
         BeginProperty ListImage90 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":257C3
            Key             =   "CtasCtesA"
         EndProperty
         BeginProperty ListImage91 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2609D
            Key             =   "Valores"
         EndProperty
         BeginProperty ListImage92 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":26977
            Key             =   "DepositosBancarios"
         EndProperty
         BeginProperty ListImage93 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":26C91
            Key             =   "ComprobantesPrv"
         EndProperty
         BeginProperty ListImage94 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":26FAB
            Key             =   "OPago"
         EndProperty
         BeginProperty ListImage95 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":272C5
            Key             =   "Contabilidad"
         EndProperty
         BeginProperty ListImage96 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2819F
            Key             =   "RubrosContables"
         EndProperty
         BeginProperty ListImage97 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":284B9
            Key             =   "Subdiarios"
         EndProperty
         BeginProperty ListImage98 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":287D3
            Key             =   "Asientos"
         EndProperty
         BeginProperty ListImage99 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":28AED
            Key             =   "Articulos"
         EndProperty
         BeginProperty ListImage100 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":28F3F
            Key             =   "Empleados"
         EndProperty
         BeginProperty ListImage101 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":29259
            Key             =   "Obras"
         EndProperty
         BeginProperty ListImage102 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":29573
            Key             =   "Compras"
         EndProperty
         BeginProperty ListImage103 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2988D
            Key             =   "AnexosEquipos"
         EndProperty
         BeginProperty ListImage104 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":29BA7
            Key             =   "Requerimientos"
         EndProperty
         BeginProperty ListImage105 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":29EC1
            Key             =   "Cotizaciones"
         EndProperty
         BeginProperty ListImage106 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2A1DB
            Key             =   "Vendedores"
         EndProperty
         BeginProperty ListImage107 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2A4F5
            Key             =   "Bancos"
         EndProperty
         BeginProperty ListImage108 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2A80F
            Key             =   "Cuentas"
         EndProperty
         BeginProperty ListImage109 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2AC61
            Key             =   "CuentasGastos"
         EndProperty
         BeginProperty ListImage110 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2B0B3
            Key             =   "UnidadesOperativas"
         EndProperty
         BeginProperty ListImage111 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2B20D
            Key             =   "Conciliaciones"
         EndProperty
         BeginProperty ListImage112 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2B527
            Key             =   "CuentasBancarias"
         EndProperty
         BeginProperty ListImage113 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2B841
            Key             =   "Ganancias"
         EndProperty
         BeginProperty ListImage114 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2BB5B
            Key             =   "DiferenciasCambio_P"
         EndProperty
         BeginProperty ListImage115 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2BE75
            Key             =   "Clientes"
         EndProperty
         BeginProperty ListImage116 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2C18F
            Key             =   "Remitos"
         EndProperty
         BeginProperty ListImage117 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2C4A9
            Key             =   "TiposCuentaGrupos"
         EndProperty
         BeginProperty ListImage118 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2C7C3
            Key             =   "Conjuntos"
         EndProperty
         BeginProperty ListImage119 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2CADD
            Key             =   "BancoChequeras"
         EndProperty
         BeginProperty ListImage120 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2CDF7
            Key             =   "Ubicaciones"
         EndProperty
         BeginProperty ListImage121 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2D111
            Key             =   "ListasPrecios"
         EndProperty
         BeginProperty ListImage122 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2D433
            Key             =   "DiferenciasCambio_C"
         EndProperty
         BeginProperty ListImage123 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2D74D
            Key             =   "Cajas"
         EndProperty
         BeginProperty ListImage124 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2E027
            Key             =   "ConciliacionesCajas"
         EndProperty
         BeginProperty ListImage125 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2E341
            Key             =   "AnticiposAlPersonal"
         EndProperty
         BeginProperty ListImage126 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2E793
            Key             =   "PlazosFijos"
         EndProperty
         BeginProperty ListImage127 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2EAAD
            Key             =   "PuntosVenta"
         EndProperty
         BeginProperty ListImage128 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2EDC7
            Key             =   "IBCondiciones"
         EndProperty
         BeginProperty ListImage129 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2F0E1
            Key             =   "CondicionesCompra"
         EndProperty
         BeginProperty ListImage130 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2F3FB
            Key             =   "Proveedores"
         EndProperty
         BeginProperty ListImage131 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2F715
            Key             =   "Comparativas"
         EndProperty
         BeginProperty ListImage132 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2FA2F
            Key             =   "Pedidos"
         EndProperty
         BeginProperty ListImage133 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":2FD49
            Key             =   "Presupuestos"
         EndProperty
         BeginProperty ListImage134 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":30063
            Key             =   "ResumenesParaConciliacion"
         EndProperty
         BeginProperty ListImage135 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3037D
            Key             =   "EmisionCheques"
         EndProperty
         BeginProperty ListImage136 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":30697
            Key             =   "VentasCuotas"
         EndProperty
         BeginProperty ListImage137 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":309B1
            Key             =   "VentasCuotasOperacion"
         EndProperty
         BeginProperty ListImage138 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":30CCB
            Key             =   "VentasCuotasCobranzas"
         EndProperty
         BeginProperty ListImage139 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":30FE5
            Key             =   "CoeficientesContables"
         EndProperty
         BeginProperty ListImage140 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":31307
            Key             =   "CoeficientesImpositivos"
         EndProperty
         BeginProperty ListImage141 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":31621
            Key             =   "ActivoFijo"
         EndProperty
         BeginProperty ListImage142 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3193B
            Key             =   "ModificacionActivoFijo"
         EndProperty
         BeginProperty ListImage143 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":31C55
            Key             =   "GruposActivosFijos"
         EndProperty
         BeginProperty ListImage144 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":31F6F
            Key             =   "IGCondiciones"
         EndProperty
         BeginProperty ListImage145 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":32289
            Key             =   "Revaluos"
         EndProperty
         BeginProperty ListImage146 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":325A3
            Key             =   "PresupuestoFinanciero"
         EndProperty
         BeginProperty ListImage147 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":328BD
            Key             =   "PresupuestoEconomico"
         EndProperty
         BeginProperty ListImage148 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":32BD7
            Key             =   "ImpuestosDirectos"
         EndProperty
         BeginProperty ListImage149 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":32EF1
            Key             =   "EjerciciosContables"
         EndProperty
         BeginProperty ListImage150 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3320B
            Key             =   "GastosBancarios"
         EndProperty
         BeginProperty ListImage151 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":33525
            Key             =   "GruposObras"
         EndProperty
         BeginProperty ListImage152 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3383F
            Key             =   "Recepciones"
         EndProperty
         BeginProperty ListImage153 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":33B59
            Key             =   "SalidaMateriales"
         EndProperty
         BeginProperty ListImage154 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":33E73
            Key             =   "AjustesStock"
         EndProperty
         BeginProperty ListImage155 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3418D
            Key             =   "Reservas"
         EndProperty
         BeginProperty ListImage156 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":344A7
            Key             =   "OtrosIngresosAlmacen"
         EndProperty
         BeginProperty ListImage157 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":34D81
            Key             =   "ValesSalida"
         EndProperty
         BeginProperty ListImage158 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3509B
            Key             =   "CCalidades"
         EndProperty
         BeginProperty ListImage159 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":353B5
            Key             =   "PosicionesImportacion"
         EndProperty
         BeginProperty ListImage160 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":356CF
            Key             =   "CostosImportacion"
         EndProperty
         BeginProperty ListImage161 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":35FA9
            Key             =   "ActividadesP"
         EndProperty
         BeginProperty ListImage162 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":362C3
            Key             =   "SolicitudesCompra"
         EndProperty
         BeginProperty ListImage163 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":365DD
            Key             =   "DistribucionesObras"
         EndProperty
         BeginProperty ListImage164 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":368F7
            Key             =   "CashFlow"
         EndProperty
         BeginProperty ListImage165 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":36C11
            Key             =   "HChequeras"
         EndProperty
         BeginProperty ListImage166 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":374EB
            Key             =   "TarjetasCredito"
         EndProperty
         BeginProperty ListImage167 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":37805
            Key             =   "OrdenesTrabajo"
         EndProperty
         BeginProperty ListImage168 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":37B1F
            Key             =   "ChequesPendientes"
         EndProperty
         BeginProperty ListImage169 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":37E39
            Key             =   "FondosFijos"
         EndProperty
         BeginProperty ListImage170 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":383D3
            Key             =   "TiposComprobante"
         EndProperty
         BeginProperty ListImage171 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3896D
            Key             =   "ProntoSAT"
         EndProperty
         BeginProperty ListImage172 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":38F07
            Key             =   "PresupuestoObras"
         EndProperty
         BeginProperty ListImage173 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":394A1
            Key             =   "PresupuestoObrasRubros"
         EndProperty
         BeginProperty ListImage174 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":39A3B
            Key             =   "Traducciones"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList img16 
      Left            =   4815
      Top             =   5670
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   174
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3A315
            Key             =   "Abierto1"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3A767
            Key             =   "Cerrado1"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3ABB9
            Key             =   "Cerrado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3B00B
            Key             =   "Abierto"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3B45D
            Key             =   "Ppal"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3B8AF
            Key             =   "TablasG"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3E061
            Key             =   "Rubros"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3E37B
            Key             =   "Familias"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3E695
            Key             =   "Subrubros"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3E9AF
            Key             =   "TTermicos"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3ECC9
            Key             =   "Depositos"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3EFE3
            Key             =   "Tipos"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3F2FD
            Key             =   "Unidades"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3F617
            Key             =   "Acabados"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3F931
            Key             =   "Calidades"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":3FC4B
            Key             =   "Materiales"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":40B25
            Key             =   "LAcopio"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":40E3F
            Key             =   "LMateriales"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":41159
            Key             =   "InformesC"
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":41A33
            Key             =   "EstadosP"
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":41D4D
            Key             =   "MovStock"
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4219F
            Key             =   "ProveedoresRubros"
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":424B9
            Key             =   "Paises"
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":427D3
            Key             =   "Relaciones"
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":42AED
            Key             =   "CodigosUniversales"
         EndProperty
         BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":42E07
            Key             =   "Series"
         EndProperty
         BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":436E1
            Key             =   "Formas"
         EndProperty
         BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":439FB
            Key             =   "Obras2"
         EndProperty
         BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":43D15
            Key             =   "DefinicionesArt"
         EndProperty
         BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4402F
            Key             =   "Obras1"
         EndProperty
         BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":44349
            Key             =   "Schedulers"
         EndProperty
         BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":44663
            Key             =   "Grados"
         EndProperty
         BeginProperty ListImage33 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4497D
            Key             =   "AcoCalidades"
         EndProperty
         BeginProperty ListImage34 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":44C97
            Key             =   "AcotarTablas"
         EndProperty
         BeginProperty ListImage35 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":44FB1
            Key             =   "AcoMateriales"
         EndProperty
         BeginProperty ListImage36 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":452CB
            Key             =   "AcoGrados"
         EndProperty
         BeginProperty ListImage37 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":455E5
            Key             =   "AcoSeries"
         EndProperty
         BeginProperty ListImage38 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":458FF
            Key             =   "AcoTratamientos"
         EndProperty
         BeginProperty ListImage39 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":45C19
            Key             =   "Colores"
         EndProperty
         BeginProperty ListImage40 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":45F33
            Key             =   "Normas"
         EndProperty
         BeginProperty ListImage41 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4680D
            Key             =   "AcoTipos"
         EndProperty
         BeginProperty ListImage42 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":46B27
            Key             =   "Equipos"
         EndProperty
         BeginProperty ListImage43 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":46E41
            Key             =   "Localidades"
         EndProperty
         BeginProperty ListImage44 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4715B
            Key             =   "Provincias"
         EndProperty
         BeginProperty ListImage45 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":47475
            Key             =   "Rangos"
         EndProperty
         BeginProperty ListImage46 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4778F
            Key             =   "Modelos"
         EndProperty
         BeginProperty ListImage47 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":48069
            Key             =   "AlimentacionesElectricas"
         EndProperty
         BeginProperty ListImage48 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":48383
            Key             =   "Marcas"
         EndProperty
         BeginProperty ListImage49 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4A05D
            Key             =   "AniosNorma"
         EndProperty
         BeginProperty ListImage50 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4A937
            Key             =   "AcoFormas"
         EndProperty
         BeginProperty ListImage51 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4AC51
            Key             =   "AcoMarcas"
         EndProperty
         BeginProperty ListImage52 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4AF6B
            Key             =   "AcoModelos"
         EndProperty
         BeginProperty ListImage53 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4B285
            Key             =   "AcoNormas"
         EndProperty
         BeginProperty ListImage54 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4B59F
            Key             =   "Planos"
         EndProperty
         BeginProperty ListImage55 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4B8B9
            Key             =   "AcoCodigos"
         EndProperty
         BeginProperty ListImage56 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4BBD3
            Key             =   "AcoSchedulers"
         EndProperty
         BeginProperty ListImage57 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4BEED
            Key             =   "Codigos"
         EndProperty
         BeginProperty ListImage58 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4C207
            Key             =   "AcoAcabados"
         EndProperty
         BeginProperty ListImage59 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4C521
            Key             =   "CentrosCosto"
         EndProperty
         BeginProperty ListImage60 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4C83B
            Key             =   "AcoBiselados"
         EndProperty
         BeginProperty ListImage61 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4CB55
            Key             =   "AcoTiposRosca"
         EndProperty
         BeginProperty ListImage62 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4CE6F
            Key             =   "CalidadesClad"
         EndProperty
         BeginProperty ListImage63 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4D189
            Key             =   "TiposRosca"
         EndProperty
         BeginProperty ListImage64 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4D4AB
            Key             =   "Biselados"
         EndProperty
         BeginProperty ListImage65 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4E2FD
            Key             =   "Sectores"
         EndProperty
         BeginProperty ListImage66 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4E617
            Key             =   "Cargos"
         EndProperty
         BeginProperty ListImage67 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4E931
            Key             =   "Densidades"
         EndProperty
         BeginProperty ListImage68 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4EC4B
            Key             =   "Historicos"
         EndProperty
         BeginProperty ListImage69 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4F09D
            Key             =   "Transportistas"
         EndProperty
         BeginProperty ListImage70 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":4F977
            Key             =   "HistObras"
         EndProperty
         BeginProperty ListImage71 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":50251
            Key             =   "HLAcopios"
         EndProperty
         BeginProperty ListImage72 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":50B2B
            Key             =   "HLMateriales"
         EndProperty
         BeginProperty ListImage73 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":51405
            Key             =   "HRequerimientos"
         EndProperty
         BeginProperty ListImage74 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":51CDF
            Key             =   "HPedidos"
         EndProperty
         BeginProperty ListImage75 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":525B9
            Key             =   "Monedas"
         EndProperty
         BeginProperty ListImage76 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":528D3
            Key             =   "ArchivosATransmitirDestinos"
         EndProperty
         BeginProperty ListImage77 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":52BED
            Key             =   "AcoColores"
         EndProperty
         BeginProperty ListImage78 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":52F07
            Key             =   "ItemsPopUpMateriales"
         EndProperty
         BeginProperty ListImage79 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":53359
            Key             =   "Comercial"
         EndProperty
         BeginProperty ListImage80 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":53673
            Key             =   "LMaterialesPorObras"
         EndProperty
         BeginProperty ListImage81 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5398D
            Key             =   "Conceptos"
         EndProperty
         BeginProperty ListImage82 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":53CA7
            Key             =   "OrdenesCompra"
         EndProperty
         BeginProperty ListImage83 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":53FC1
            Key             =   "Facturas"
         EndProperty
         BeginProperty ListImage84 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":542DB
            Key             =   "Devoluciones"
         EndProperty
         BeginProperty ListImage85 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":545F5
            Key             =   "NotasDebito"
         EndProperty
         BeginProperty ListImage86 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5490F
            Key             =   "NotasCredito"
         EndProperty
         BeginProperty ListImage87 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":54C29
            Key             =   "Recibos"
         EndProperty
         BeginProperty ListImage88 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":55503
            Key             =   "CtasCtesD"
         EndProperty
         BeginProperty ListImage89 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":55DDD
            Key             =   "CtasCtesA"
         EndProperty
         BeginProperty ListImage90 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":566B7
            Key             =   "Valores"
         EndProperty
         BeginProperty ListImage91 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":56F91
            Key             =   "DepositosBancarios"
         EndProperty
         BeginProperty ListImage92 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":572AB
            Key             =   "ComprobantesPrv"
         EndProperty
         BeginProperty ListImage93 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":575C5
            Key             =   "OPago"
         EndProperty
         BeginProperty ListImage94 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":578DF
            Key             =   "Contabilidad"
         EndProperty
         BeginProperty ListImage95 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":587B9
            Key             =   "RubrosContables"
         EndProperty
         BeginProperty ListImage96 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":58AD3
            Key             =   "Subdiarios"
         EndProperty
         BeginProperty ListImage97 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":58DED
            Key             =   "Asientos"
         EndProperty
         BeginProperty ListImage98 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":59107
            Key             =   "Articulos"
         EndProperty
         BeginProperty ListImage99 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":59559
            Key             =   "Empleados"
         EndProperty
         BeginProperty ListImage100 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":59873
            Key             =   "Obras"
         EndProperty
         BeginProperty ListImage101 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":59B8D
            Key             =   "Compras"
         EndProperty
         BeginProperty ListImage102 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":59EA7
            Key             =   "AnexosEquipos"
         EndProperty
         BeginProperty ListImage103 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5A1C1
            Key             =   "Requerimientos"
         EndProperty
         BeginProperty ListImage104 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5A4DB
            Key             =   "Cotizaciones"
         EndProperty
         BeginProperty ListImage105 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5A7F5
            Key             =   "Vendedores"
         EndProperty
         BeginProperty ListImage106 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5AB0F
            Key             =   "Bancos"
         EndProperty
         BeginProperty ListImage107 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5AE29
            Key             =   "Cuentas"
         EndProperty
         BeginProperty ListImage108 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5B27B
            Key             =   "CuentasGastos"
         EndProperty
         BeginProperty ListImage109 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5B6CD
            Key             =   "UnidadesOperativas"
         EndProperty
         BeginProperty ListImage110 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5B827
            Key             =   "Conciliaciones"
         EndProperty
         BeginProperty ListImage111 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5BB41
            Key             =   "CuentasBancarias"
         EndProperty
         BeginProperty ListImage112 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5BE5B
            Key             =   "Ganancias"
         EndProperty
         BeginProperty ListImage113 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5C175
            Key             =   "DiferenciasCambio_P"
         EndProperty
         BeginProperty ListImage114 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5C48F
            Key             =   "Clientes"
         EndProperty
         BeginProperty ListImage115 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5C7A9
            Key             =   "Remitos"
         EndProperty
         BeginProperty ListImage116 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5CAC3
            Key             =   "TiposCuentaGrupos"
         EndProperty
         BeginProperty ListImage117 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5CDDD
            Key             =   "Conjuntos"
         EndProperty
         BeginProperty ListImage118 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5D0F7
            Key             =   "ControlesCalidad"
         EndProperty
         BeginProperty ListImage119 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5E889
            Key             =   "BancoChequeras"
         EndProperty
         BeginProperty ListImage120 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5EBA3
            Key             =   "Ubicaciones"
         EndProperty
         BeginProperty ListImage121 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5EEBD
            Key             =   "ListasPrecios"
         EndProperty
         BeginProperty ListImage122 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5F1DF
            Key             =   "DiferenciasCambio_C"
         EndProperty
         BeginProperty ListImage123 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5F4F9
            Key             =   "Cajas"
         EndProperty
         BeginProperty ListImage124 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":5FDD3
            Key             =   "ConciliacionesCajas"
         EndProperty
         BeginProperty ListImage125 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":600ED
            Key             =   "AnticiposAlPersonal"
         EndProperty
         BeginProperty ListImage126 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":6053F
            Key             =   "PlazosFijos"
         EndProperty
         BeginProperty ListImage127 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":60859
            Key             =   "PuntosVenta"
         EndProperty
         BeginProperty ListImage128 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":60B73
            Key             =   "IBCondiciones"
         EndProperty
         BeginProperty ListImage129 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":60E8D
            Key             =   "CondicionesCompra"
         EndProperty
         BeginProperty ListImage130 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":611A7
            Key             =   "Proveedores"
         EndProperty
         BeginProperty ListImage131 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":614C1
            Key             =   "Comparativas"
         EndProperty
         BeginProperty ListImage132 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":617DB
            Key             =   "Pedidos"
         EndProperty
         BeginProperty ListImage133 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":61AF5
            Key             =   "Presupuestos"
         EndProperty
         BeginProperty ListImage134 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":61E0F
            Key             =   "ResumenesParaConciliacion"
         EndProperty
         BeginProperty ListImage135 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":62129
            Key             =   "EmisionCheques"
         EndProperty
         BeginProperty ListImage136 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":62443
            Key             =   "VentasCuotas"
         EndProperty
         BeginProperty ListImage137 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":6275D
            Key             =   "VentasCuotasOperacion"
         EndProperty
         BeginProperty ListImage138 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":62A77
            Key             =   "VentasCuotasCobranzas"
         EndProperty
         BeginProperty ListImage139 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":62D91
            Key             =   "CoeficientesContables"
         EndProperty
         BeginProperty ListImage140 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":630B3
            Key             =   "CoeficientesImpositivos"
         EndProperty
         BeginProperty ListImage141 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":633CD
            Key             =   "ActivoFijo"
         EndProperty
         BeginProperty ListImage142 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":636E7
            Key             =   "ModificacionActivoFijo"
         EndProperty
         BeginProperty ListImage143 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":63A01
            Key             =   "GruposActivosFijos"
         EndProperty
         BeginProperty ListImage144 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":63D1B
            Key             =   "IGCondiciones"
         EndProperty
         BeginProperty ListImage145 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":64035
            Key             =   "Revaluos"
         EndProperty
         BeginProperty ListImage146 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":6434F
            Key             =   "PresupuestoFinanciero"
         EndProperty
         BeginProperty ListImage147 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":64669
            Key             =   "PresupuestoEconomico"
         EndProperty
         BeginProperty ListImage148 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":64983
            Key             =   "ImpuestosDirectos"
         EndProperty
         BeginProperty ListImage149 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":64C9D
            Key             =   "EjerciciosContables"
         EndProperty
         BeginProperty ListImage150 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":64FB7
            Key             =   "GastosBancarios"
         EndProperty
         BeginProperty ListImage151 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":652D1
            Key             =   "GruposObras"
         EndProperty
         BeginProperty ListImage152 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":655EB
            Key             =   "Recepciones"
         EndProperty
         BeginProperty ListImage153 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":65905
            Key             =   "SalidaMateriales"
         EndProperty
         BeginProperty ListImage154 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":65C1F
            Key             =   "AjustesStock"
         EndProperty
         BeginProperty ListImage155 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":65F39
            Key             =   "Reservas"
         EndProperty
         BeginProperty ListImage156 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":66253
            Key             =   "OtrosIngresosAlmacen"
         EndProperty
         BeginProperty ListImage157 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":66B2D
            Key             =   "ValesSalida"
         EndProperty
         BeginProperty ListImage158 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":66E47
            Key             =   "CCalidades"
         EndProperty
         BeginProperty ListImage159 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":67161
            Key             =   "PosicionesImportacion"
         EndProperty
         BeginProperty ListImage160 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":6747B
            Key             =   "CostosImportacion"
         EndProperty
         BeginProperty ListImage161 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":67D55
            Key             =   "ActividadesP"
         EndProperty
         BeginProperty ListImage162 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":6806F
            Key             =   "SolicitudesCompra"
         EndProperty
         BeginProperty ListImage163 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":68389
            Key             =   "DistribucionesObras"
         EndProperty
         BeginProperty ListImage164 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":686A3
            Key             =   "CashFlow"
         EndProperty
         BeginProperty ListImage165 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":689BD
            Key             =   "HChequeras"
         EndProperty
         BeginProperty ListImage166 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":69297
            Key             =   "TarjetasCredito"
         EndProperty
         BeginProperty ListImage167 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":695B1
            Key             =   "OrdenesTrabajo"
         EndProperty
         BeginProperty ListImage168 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":698CB
            Key             =   "ChequesPendientes"
         EndProperty
         BeginProperty ListImage169 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":69BE5
            Key             =   "FondosFijos"
         EndProperty
         BeginProperty ListImage170 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":6A17F
            Key             =   "TiposComprobante"
         EndProperty
         BeginProperty ListImage171 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":6A719
            Key             =   "ProntoSAT"
         EndProperty
         BeginProperty ListImage172 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":6ACB3
            Key             =   "PresupuestoObras"
         EndProperty
         BeginProperty ListImage173 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":6B24D
            Key             =   "PresupuestoObrasRubros"
         EndProperty
         BeginProperty ListImage174 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":6B7E7
            Key             =   "Traducciones"
         EndProperty
      EndProperty
   End
   Begin RichTextLib.RichTextBox RichTextBox1 
      Height          =   195
      Left            =   6435
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   5940
      Visible         =   0   'False
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   344
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmPrincipal.frx":6C0C1
   End
   Begin VB.PictureBox Split 
      Height          =   4965
      Left            =   3465
      MousePointer    =   9  'Size W E
      ScaleHeight     =   4965
      ScaleWidth      =   30
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   405
      Width           =   35
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   13
      Top             =   10755
      Visible         =   0   'False
      Width           =   12795
      _ExtentX        =   22569
      _ExtentY        =   688
      ShowTips        =   0   'False
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   7
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   6615
            MinWidth        =   5292
            Picture         =   "frmPrincipal.frx":6C144
            Key             =   "Estado"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   6615
            MinWidth        =   5292
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   4322
            MinWidth        =   2999
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   1
            Alignment       =   1
            AutoSize        =   2
            Enabled         =   0   'False
            Object.Width           =   900
            MinWidth        =   18
            TextSave        =   "CAPS"
            Key             =   "Caps"
         EndProperty
         BeginProperty Panel5 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   2
            AutoSize        =   2
            Object.Width           =   820
            MinWidth        =   18
            TextSave        =   "NUM"
            Key             =   "Num"
         EndProperty
         BeginProperty Panel6 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            Alignment       =   1
            AutoSize        =   2
            Object.Width           =   1693
            MinWidth        =   18
            TextSave        =   "04/02/2014"
            Key             =   "Fecha"
         EndProperty
         BeginProperty Panel7 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   5
            AutoSize        =   2
            Object.Width           =   873
            MinWidth        =   19
            TextSave        =   "01:51"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.TreeView Arbol 
      Height          =   6345
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   11192
      _Version        =   393217
      HideSelection   =   0   'False
      Indentation     =   2
      LabelEdit       =   1
      Style           =   3
      ImageList       =   "img16"
      BorderStyle     =   1
      Appearance      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      OLEDropMode     =   1
   End
   Begin Controles1013.DbListView Lista 
      Height          =   5190
      Left            =   6720
      TabIndex        =   2
      Top             =   600
      Width           =   6720
      _ExtentX        =   11853
      _ExtentY        =   9155
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
      GridLines       =   -1  'True
      MouseIcon       =   "frmPrincipal.frx":6C45E
      OLEDragMode     =   1
      PictureAlignment=   5
      SortOrder       =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.TreeView ArbolDefault 
      Height          =   510
      Left            =   8820
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   5715
      Visible         =   0   'False
      Width           =   1035
      _ExtentX        =   1826
      _ExtentY        =   900
      _Version        =   393217
      Indentation     =   18
      LabelEdit       =   1
      LineStyle       =   1
      Style           =   7
      ImageList       =   "img16"
      Appearance      =   1
      OLEDropMode     =   1
   End
   Begin VB.PictureBox picBackground 
      AutoSize        =   -1  'True
      BorderStyle     =   0  'None
      Height          =   1500
      Left            =   6750
      Picture         =   "frmPrincipal.frx":6C47A
      ScaleHeight     =   1500
      ScaleWidth      =   3750
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   3330
      Visible         =   0   'False
      Width           =   3750
   End
   Begin VB.PictureBox picBackgroundArbol 
      AutoSize        =   -1  'True
      BorderStyle     =   0  'None
      Height          =   1500
      Left            =   6480
      Picture         =   "frmPrincipal.frx":72B2C
      ScaleHeight     =   1500
      ScaleWidth      =   3750
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   4920
      Visible         =   0   'False
      Width           =   3750
   End
   Begin VB.PictureBox HASAR1 
      Height          =   480
      Left            =   5985
      ScaleHeight     =   420
      ScaleWidth      =   1140
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   5715
      Width           =   1200
   End
   Begin VB.CommandButton cmdCommand2 
      Caption         =   "MPR"
      Height          =   855
      Left            =   4320
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   2280
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Frame Frame1 
      Caption         =   "Panel de Supervisor"
      Height          =   10215
      Left            =   6240
      TabIndex        =   14
      Top             =   120
      Width           =   10695
      Begin VB.CommandButton cmdVerStock 
         Caption         =   "asignar y ver stock para consummir"
         Height          =   615
         Left            =   3000
         TabIndex        =   46
         Top             =   2640
         Width           =   1935
      End
      Begin VB.CommandButton cmdCrearPlan 
         Caption         =   "crear plan"
         Height          =   735
         Left            =   480
         TabIndex        =   45
         Top             =   3600
         Width           =   2295
      End
      Begin VB.CommandButton cmdVerMapa 
         Caption         =   "nueva op"
         Height          =   1335
         Index           =   1
         Left            =   3720
         TabIndex        =   44
         Top             =   3480
         Width           =   2535
      End
      Begin VB.CommandButton cmdRehacer 
         Caption         =   "rehacer"
         Height          =   495
         Left            =   8040
         TabIndex        =   34
         Top             =   9000
         Width           =   975
      End
      Begin VB.CommandButton cmdDeshacer 
         Caption         =   "deshacer"
         Height          =   495
         Left            =   6360
         TabIndex        =   33
         Top             =   8880
         Width           =   1335
      End
      Begin VB.CommandButton cmdCerrarOP 
         Caption         =   "cerrar OP"
         Height          =   1095
         Left            =   7320
         TabIndex        =   32
         Top             =   3600
         Width           =   1695
      End
      Begin VB.CommandButton cmdActualizar 
         Caption         =   "actualizar"
         Height          =   495
         Left            =   10680
         TabIndex        =   15
         Top             =   8760
         Width           =   975
      End
      Begin Controles1013.DbListView listaOPs 
         Height          =   2655
         Left            =   7080
         TabIndex        =   16
         Top             =   4920
         Width           =   3120
         _ExtentX        =   5503
         _ExtentY        =   4683
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MouseIcon       =   "frmPrincipal.frx":74175
         OLEDragMode     =   1
         PictureAlignment=   5
         ColumnHeaderIcons=   "ImgColumnas"
      End
      Begin Controles1013.DbListView listaPartes 
         Height          =   1815
         Left            =   120
         TabIndex        =   17
         Top             =   8040
         Width           =   5355
         _ExtentX        =   9446
         _ExtentY        =   3201
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MouseIcon       =   "frmPrincipal.frx":74191
         OLEDragMode     =   1
         PictureAlignment=   5
         ColumnHeaderIcons=   "ImgColumnas"
      End
      Begin Controles1013.DbListView listaProcesosPendientes 
         Height          =   2055
         Left            =   0
         TabIndex        =   18
         Top             =   5520
         Width           =   4665
         _ExtentX        =   8229
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
         MouseIcon       =   "frmPrincipal.frx":741AD
         OLEDragMode     =   1
         PictureAlignment=   5
         ColumnHeaderIcons=   "ImgColumnas"
      End
      Begin Controles1013.DbListView listaOCsinOP 
         Height          =   1455
         Left            =   4680
         TabIndex        =   19
         Top             =   480
         Width           =   5265
         _ExtentX        =   9287
         _ExtentY        =   2566
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MouseIcon       =   "frmPrincipal.frx":741C9
         OLEDragMode     =   1
         PictureAlignment=   5
         ColumnHeaderIcons=   "ImgColumnas"
      End
      Begin Controles1013.DbListView listaFichas 
         Height          =   1455
         Left            =   240
         TabIndex        =   20
         Top             =   720
         Width           =   4515
         _ExtentX        =   7964
         _ExtentY        =   2566
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MouseIcon       =   "frmPrincipal.frx":741E5
         OLEDragMode     =   1
         PictureAlignment=   5
         ColumnHeaderIcons=   "ImgColumnas"
      End
      Begin VB.Label lblFichasFrecuentes 
         Caption         =   "Fichas frecuentes"
         Height          =   255
         Left            =   240
         TabIndex        =   26
         Top             =   480
         Width           =   1815
      End
      Begin VB.Label lblOrdenesDe 
         Caption         =   "Ordenes de compra pendientes"
         Height          =   495
         Left            =   4800
         TabIndex        =   25
         Top             =   240
         Width           =   3255
      End
      Begin VB.Label lblsss 
         Caption         =   "---------------------->"
         Height          =   495
         Left            =   2760
         TabIndex        =   24
         Top             =   6960
         Width           =   1935
      End
      Begin VB.Label lblProduccionesActivas 
         Caption         =   "Producciones activas"
         Height          =   255
         Left            =   7080
         TabIndex        =   23
         Top             =   4680
         Width           =   1815
      End
      Begin VB.Label lblPartesAbiertos 
         Caption         =   "Partes abiertos"
         Height          =   255
         Left            =   120
         TabIndex        =   22
         Top             =   7800
         Width           =   1815
      End
      Begin VB.Line Line8 
         X1              =   3000
         X2              =   3720
         Y1              =   720
         Y2              =   1080
      End
      Begin VB.Line Line7 
         X1              =   3360
         X2              =   3360
         Y1              =   2520
         Y2              =   2040
      End
      Begin VB.Label lblProcesosY 
         Caption         =   "Procesos y Consumos de articulos pendientes"
         Height          =   495
         Left            =   0
         TabIndex        =   21
         Top             =   5280
         Width           =   5055
      End
      Begin VB.Line Line6 
         X1              =   6720
         X2              =   6720
         Y1              =   2280
         Y2              =   2640
      End
      Begin VB.Line Line1 
         X1              =   4320
         X2              =   4320
         Y1              =   6000
         Y2              =   6840
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   390
      Left            =   0
      TabIndex        =   54
      Top             =   0
      Width           =   12795
      _ExtentX        =   22569
      _ExtentY        =   688
      ButtonWidth     =   609
      ButtonHeight    =   582
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   36
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "a"
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "New"
            Object.ToolTipText     =   "Nuevo"
            ImageKey        =   "New"
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Save"
            Object.ToolTipText     =   "Exportar a Excel"
            ImageKey        =   "Excel"
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Print"
            Object.ToolTipText     =   "Imprimir"
            ImageKey        =   "Print"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Copy"
            Object.ToolTipText     =   "Copiar"
            ImageKey        =   "Copy"
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Paste"
            Object.ToolTipText     =   "Pegar"
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Find"
            Object.ToolTipText     =   "Buscar"
            ImageKey        =   "Find"
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Sumar"
            Object.ToolTipText     =   "Totalizar campo"
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Calculadora"
            Object.ToolTipText     =   "Calculadora"
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "View Large Icons"
            Object.ToolTipText     =   "Iconos grandes"
            Style           =   2
         EndProperty
         BeginProperty Button15 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "View Small Icons"
            Object.ToolTipText     =   "Iconos pequeños"
            Style           =   2
         EndProperty
         BeginProperty Button16 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "View List"
            Object.ToolTipText     =   "Lista"
            Style           =   2
         EndProperty
         BeginProperty Button17 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "View Details"
            Object.ToolTipText     =   "Detalles"
            Style           =   2
         EndProperty
         BeginProperty Button18 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button19 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Help"
            Object.ToolTipText     =   "Ayuda"
         EndProperty
         BeginProperty Button20 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button21 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "CopiarCampo"
            Object.ToolTipText     =   "Copiar un campo a varias mascaras"
         EndProperty
         BeginProperty Button22 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Refrescar"
            Object.ToolTipText     =   "Refrescar el arbol de comprobantes"
            ImageKey        =   "RefrescarArbol"
         EndProperty
         BeginProperty Button23 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button24 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Parametros"
            Object.ToolTipText     =   "Parametros"
            ImageKey        =   "Parametros"
         EndProperty
         BeginProperty Button25 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Empresa"
            Object.ToolTipText     =   "Datos de la empresa"
         EndProperty
         BeginProperty Button26 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button27 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "EnviarMensaje"
            Object.ToolTipText     =   "Enviar un mensaje a uno o varios usuarios"
         EndProperty
         BeginProperty Button28 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button29 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "MenuPopUp"
            Object.ToolTipText     =   "Generar menu desplegable de materiales"
         EndProperty
         BeginProperty Button30 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button31 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "AccesoPorUsuarios"
            Object.ToolTipText     =   "Pasa a modo definicion de accesos por item - usuarios"
         EndProperty
         BeginProperty Button32 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button33 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Idioma"
            Object.ToolTipText     =   "Cambiar idioma"
         EndProperty
         BeginProperty Button34 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Nuevo Parte"
            Object.ToolTipText     =   "Crear Parte de Producción"
         EndProperty
         BeginProperty Button35 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button36 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Nueva Orden"
            Object.ToolTipText     =   "Crear Orden de Producción"
         EndProperty
      EndProperty
      Begin VB.CheckBox Check1 
         Alignment       =   1  'Right Justify
         Caption         =   "Consolidar"
         Height          =   240
         Left            =   12960
         TabIndex        =   55
         Top             =   240
         Visible         =   0   'False
         Width           =   1095
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   1200
      Top             =   2640
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
            Picture         =   "frmPrincipal.frx":74201
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":74313
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":74425
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":74537
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":74649
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":7475B
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPrincipal.frx":7486D
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin VB.Line Line5 
      BorderWidth     =   2
      X1              =   5280
      X2              =   5400
      Y1              =   2160
      Y2              =   2040
   End
   Begin VB.Line Line4 
      BorderWidth     =   2
      X1              =   5160
      X2              =   5280
      Y1              =   2040
      Y2              =   2160
   End
   Begin VB.Line Line3 
      BorderStyle     =   5  'Dash-Dot-Dot
      BorderWidth     =   2
      X1              =   5280
      X2              =   5280
      Y1              =   1800
      Y2              =   2160
   End
   Begin VB.Line Line2 
      BorderWidth     =   4
      X1              =   0
      X2              =   0
      Y1              =   0
      Y2              =   240
   End
   Begin VB.Menu mnuMaster 
      Caption         =   "&Consultas"
      Index           =   2
      NegotiatePosition=   3  'Right
      Begin VB.Menu MnuSub 
         Caption         =   "Almacenes"
         Enabled         =   0   'False
         Index           =   0
      End
      Begin VB.Menu MnuSub 
         Caption         =   "Cardex"
         Index           =   5
      End
      Begin VB.Menu MnuSub 
         Caption         =   "-"
         Index           =   6
      End
      Begin VB.Menu MnuSub 
         Caption         =   "Stock"
         Enabled         =   0   'False
         Index           =   7
      End
      Begin VB.Menu MnuSub 
         Caption         =   "Stock actual (General)"
         Index           =   8
      End
      Begin VB.Menu MnuSub 
         Caption         =   "Stock actual (Por articulo - partida)"
         Index           =   9
      End
      Begin VB.Menu MnuSub 
         Caption         =   "-"
         Index           =   99
      End
      Begin VB.Menu MnuSub 
         Caption         =   "Trazabilidad"
         Index           =   100
      End
      Begin VB.Menu MnuSub 
         Caption         =   "Costos"
         Index           =   101
      End
      Begin VB.Menu MnuSub 
         Caption         =   "Necesidades de Compras"
         Index           =   102
      End
      Begin VB.Menu MnuSub 
         Caption         =   "Necesidades de Planificacion"
         Index           =   105
      End
      Begin VB.Menu MnuSub 
         Caption         =   "Lista de Materiales (BOM)"
         Index           =   106
      End
      Begin VB.Menu MnuSub 
         Caption         =   "Rendimiento"
         Index           =   107
      End
   End
   Begin VB.Menu mnuMaster 
      Caption         =   "&Seguridad"
      Index           =   4
      Begin VB.Menu MnuSeg 
         Caption         =   "Definicion de accesos"
         Index           =   0
      End
      Begin VB.Menu mnuMapa 
         Caption         =   "Mapa de Supervisor"
      End
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Funciones varias"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Duplicar OP"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Crear material similar"
         Index           =   1
         Visible         =   0   'False
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Orden de pago entregada"
         Index           =   2
         Visible         =   0   'False
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Pasar a pendiente de firma"
         Index           =   3
         Visible         =   0   'False
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Pasar a caja"
         Index           =   4
         Visible         =   0   'False
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Generar pedidos en Word (con impresion)"
         Index           =   5
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Generar requerimientos en Word (con impresion)"
         Index           =   6
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar comprobante(s)"
         Index           =   7
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar RM's"
         Index           =   8
      End
   End
   Begin VB.Menu mnuTesting 
      Caption         =   "&Testing"
      Begin VB.Menu mnuPanelOperador 
         Caption         =   "Panel para Operador"
      End
      Begin VB.Menu mnuTestEtiquetador 
         Caption         =   "Etiquetador (para crear stock)"
      End
      Begin VB.Menu mnuAjusteStock 
         Caption         =   "AjusteStock"
      End
      Begin VB.Menu mnuSalidaMateriales 
         Caption         =   "SalidaMateriales"
      End
      Begin VB.Menu mnuScriptReset 
         Caption         =   "Script SQL+ BIZ"
      End
      Begin VB.Menu mnuScript 
         Caption         =   "Script BIZ Test"
      End
      Begin VB.Menu mnuScriptInicializador 
         Caption         =   "Inicializador"
      End
      Begin VB.Menu mnuScriptTestInofensivo 
         Caption         =   "Testeador Inofensivo"
      End
      Begin VB.Menu kk 
         Caption         =   "-"
      End
      Begin VB.Menu mnuScriptGUI 
         Caption         =   "UI"
      End
      Begin VB.Menu mnuScriptGUIsinPausa 
         Caption         =   "UI sin pausa"
      End
      Begin VB.Menu mnuScriptGUIPlanes 
         Caption         =   "UI - Planificadores"
         Shortcut        =   {F9}
      End
      Begin VB.Menu mnuScriptGUIPartes 
         Caption         =   "UI - Partes"
      End
      Begin VB.Menu mnuScriptGUIopsqueseenganchan 
         Caption         =   "UI - OPs que se enganchan"
         Shortcut        =   {F5}
      End
      Begin VB.Menu mnuScriptGUIMensajeTip 
         Caption         =   "(para sacar este menú, borrar debug.bat)"
      End
      Begin VB.Menu Importador 
         Caption         =   "Importador"
      End
      Begin VB.Menu Importador2 
         Caption         =   "Importador2"
      End
   End
End
Attribute VB_Name = "frmPrincipal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mnuVerP(3) As Menu
Dim Ultimo_Nodo As String
Dim Accesos(700, 3) As String
Dim VerNovedades As Boolean, VerPedidosHistoricos As Boolean
Dim UltimoNodoSeleccionado As Node

Private mLOCALE_SMONDECIMALSEP As String, mLOCALE_SMONTHOUSANDSEP As String

Private mLOCALE_SDECIMAL As String, mLOCALE_STHOUSAND As String, mIdiomaInicial As String

Const NAME_COLUMN = 0
Const TYPE_COLUMN = 1
Const SIZE_COLUMN = 2
Const DATE_COLUMN = 3
Const MargenBotones As Integer = 10

Private Declare Function OSWinHelp% _
                Lib "user32" _
                Alias "WinHelpA" (ByVal hwnd&, _
                                  ByVal HelpFile$, _
                                  ByVal wCommand%, _
                                  dwData As Any)

Dim WithEvents ActL As ControlForm
Attribute ActL.VB_VarHelpID = -1

'/////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////
'   Variables del Script
'/////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////
    
Dim KID_Cliente2 As Long
    
Dim KID_MaterialAlgodonManuar As Long, KID_MaterialRayonViscosa As Long, IDART3 As Long
Dim KID_SemiAlgodonManuar As Long, KID_SemiRayonViscosa As Long
Dim KID_TerminadoBaseCashmere As Long, KID_TerminadoLightSeason As Long
Dim KID_EnsimajeAgua As Long, KID_EnsimajeBio999Auxtex As Long
Dim KID_DeshechoBorra As Long, KID_DeshechoHilacha As Long

Dim KIDStock_SemiAlgodonManuar As Long
Dim KIDStock_SemiRayonViscosa As Long
Dim KIDStock_MaterialAlgodonManuar As Long
Dim KIDStock_MaterialRayonViscosa As Long

Dim KID_SemielaboradoLIG115A002V As Long
Dim KID_MatPrima_2083_FibraCorderoCruda As Long
Dim KID_MatPrima_2083_Pelo2daNacional As Long
Dim KID_MatPrima_2083_PeloFlandes As Long
Dim KID_MatPrima_2083_FibraPoliamida As Long
Dim KID_Ensimaje_Agua As Long
   
Dim KID_TerminadoPRUEBACashmereSeason815 As Long
'Dim KID_ As Long

Dim IDMAQ_CARDA As Long
Dim IDMAQ_MEZCLADORA As Long
Dim IDMAQ_ENCONADORA As Long
Dim IDMAQ_CONTINUA As Long
    
Dim IDFICHA1 As Long
    
Dim IDSTK1 As Long
    
Dim IDLINEA1 As Long
    
Dim ID_PROC_MEZCLADO As Long
Dim ID_PROC_RETORCIDO As Long
Dim ID_PROC_CONTINUA As Long
Dim ID_PROC_ENCARDADO As Long

Dim K_UN1 As Long
Dim K_UNIHORAS As Long
Dim K_UNISEMANA As Long
Dim K_UNILITROS As Long
    
Dim IDORDEN1 As Long
Dim IDORDEN2 As Long
Dim IDORDEN3 As Long
    
Dim ID_EMPLEADO1 As Long
Dim ID_EMPLEADO2 As Long
Dim ID_EMPLEADO3 As Long
    
Dim KID_ColorAluminio As Long
'/////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////

Sub EditarConsulta(ByVal Mnu As String, _
                   ByVal Item As Long, _
                   Optional ByVal mTitulo As String)
    
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
    
    Dim oF As Form
    Dim NoModal As Boolean
   
    NoModal = False
   
    Select Case Mnu

        Case ""
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()

            Select Case Item
                        
                Case 5
                    Set oF = New frmCardex

                    With oF
                        .Show , Me
                  
                    End With
               
                Case 8
                    Set oF = New frmConsulta1

                    With oF
                        .Id = 1
                        '.Show vbModal, Me
                        .Show , Me
                    End With

                Case 9
                    Set oF = New frmConsultaStockPorPartidas

                    With oF
                        .Articulo = 0
                        .Show vbModal, Me
                    End With
            
                Case 100
                    Set oF = New frmConsultaTrazabilidad

                    With oF
                        '.Id = 89
                        .Show , Me
                    End With

                Case 101
                    Set oF = New frmConsultaCostos

                    With oF
                        '.Id = 89
                        .Show vbModal, Me
                    End With
         
                Case 102 'Necesidad de Compras
                    Set oF = New frmConsulta2

                    With oF
                        .Id = 402
                        .Show , Me
                    End With

                Case 103 'Estado de la produccion en Semielaborado
                    Set oF = New frmConsulta2

                    With oF
                        .Id = 403
                        .Show , Me
                    End With

                Case 104 'Planificacion de la produccion
                    Set oF = New frmConsulta2

                    With oF
                        .Id = 404
                        .Show , Me
                    End With

                Case 105 'Necesidad de Planificacion de Produccion
                    Set oF = New frmConsulta2

                    With oF
                        .Id = 405
                        .Show , Me
                    End With

                Case 106 'Necesidad de Planificacion de Produccion
                    Set oF = New frmConsultaBOM

                    With oF
                        '.Id = 405
                        .Show , Me
                    End With
                
                Case 107 'Rendimiento
                    Set oF = New frmConsulta2

                    With oF
                        .Id = 407
                        .Show , Me
                    End With
         
            End Select
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
'los nuevos items del menú los tenés que agregar en el .app a traves del frmAccesos.ArmarArboles()
      
        Case "A"

            Select Case Item

                    '            Case 0
                    '               Set oF = New frmConsulta2
                    '               With oF
                    '                  .Id = 89
                    '                  .Show vbModal, Me
                    '               End With
                    '            Case 1
                    '               Set oF = New frmConsultaPedidos
                    '               With oF
                    '                  .Show vbModal, Me
                    '               End With
                    '            Case 2
                    '               Set oF = New frmConsultasGenerales
                    '               With oF
                    '                  .Id = 1
                    '                  .Show vbModal, Me
                    '               End With
                    '            Case 3
                    '               Set oF = New frmConsultaValesPendientes
                    '               With oF
                    '                  .Show vbModal, Me
                    '               End With
                    '            Case 4
                    '               Set oF = New frmConsultaValesFaltantes
                    '               With oF
                    '                  .Obra = 0
                    '                  .Show vbModal, Me
                    '               End With
                Case 5
                    Set oF = New frmCardex

                    With oF
                        .Show , Me
                  
                    End With

                    '            Case 6
                    '               Set oF = New frmConsultasGenerales
                    '               With oF
                    '                  .Id = 5
                    '                  .Show vbModal, Me
                    '               End With
                    '            Case 7
                    '               Set oF = New frmConsultaReservasAuto
                    '               With oF
                    '                  .Show vbModal, Me
                    '               End With
                    '            Case 8
                    '               Set oF = New frmExcel1
                    '               With oF
                    '                  .Codigo = "RemProv"
                    '                  .Planilla = "ComprasTerceros"
                    '                  .Titulo = mTitulo
                    '                  .Show vbModal, Me
                    '               End With
                    '            Case 9
                    '               Set oF = New frmExcel1
                    '               With oF
                    '                  .Codigo = "ValCons"
                    '                  .Planilla = "ComprasTerceros"
                    '                  .Titulo = mTitulo
                    '                  .Show vbModal, Me
                    '               End With
                    '            Case 10
                    '               Set oF = New frmExcel1
                    '               With oF
                    '                  .Codigo = "Salidas"
                    '                  .Planilla = "ComprasTerceros"
                    '                  .Titulo = mTitulo
                    '                  .Show vbModal, Me
                    '               End With
                    '            Case 11
                    '               Set oF = New frmConsulta2
                    '               With oF
                    '                  .Id = 90
                    '                  .Show vbModal, Me
                    '               End With
                    '            Case 12
                    '               Set oF = New frmConsulta2
                    '               With oF
                    '                  .Id = 92
                    '                  .Show vbModal, Me
                    '               End With
            End Select
      
        Case "S"

            Select Case Item

                    'Case 0
                    '   Set oF = New frmConsultaReservas
                    '   With oF
                    '      .Obra = 0
                    '      .Show vbModal, Me
                    '   End With
                Case 1
                    Set oF = New frmConsulta1

                    With oF
                        .Id = 1
                        .Show vbModal, Me
                    End With

                Case 2
                    Set oF = New frmConsultaStockPorPartidas

                    With oF
                        .Articulo = 0
                        .Show vbModal, Me
                    End With

            End Select
   
    End Select
   
    'If Not NoModal And Not oF Is Nothing Then Unload oF
    'Set oF = Nothing
      
End Sub

Public Sub CambiarVista(ByVal QueVista As ListViewConstants)

    Dim i As Integer
   
    Lista.View = QueVista
   
    For i = MargenBotones To MargenBotones + 3
        Toolbar1.Buttons(i).Value = tbrUnpressed
        mnuVerP(i - MargenBotones).Checked = False
    Next
   
    Toolbar1.Buttons(MargenBotones + QueVista).Value = tbrPressed
   
    DoEvents
    mnuVerP(QueVista).Checked = True
   
    'Toolbar1_ButtonClick Toolbar1.Buttons(6 + QueVista)

End Sub

Private Sub ActL_ActLista(ByVal IdRegistro As Long, _
                          ByVal TipoAccion As EnumAcciones, _
                          ByVal NombreListaEditada As String, _
                          ByVal IdRegistroOriginal As Long)

    ActualizarLista IdRegistro, TipoAccion, NombreListaEditada, IdRegistroOriginal

End Sub

Private Sub Arbol_MouseUp(Button As Integer, _
                          Shift As Integer, _
                          X As Single, _
                          Y As Single)

    If Button = vbRightButton And glbModoAccesosUsuarios Then
        'PopupMenu mnuFncAcc
    End If

End Sub

Private Sub Arbol_NodeClick(ByVal Node As MSComctlLib.Node)

    Dim oRs As ADOR.Recordset
    Dim oRs1 As ADOR.Recordset
    Dim oRs2 As ADOR.Recordset
    Dim oRs3 As ADOR.Recordset
    Dim k_node As String, sFecha As String, sInve As String, sDato As String
    Dim sKey As String, sKey1 As String, sKey2 As String, sKey3 As String
    Dim sKey4 As String, clave As String, mIcono As String, mArg1 As String
    Dim mAux1 As Integer
    Dim DatosFecha As Variant, DatosV As Variant
    Dim Desde As Date, Hasta As Date
    Dim mOrdena As Boolean, mNuevo As Boolean
    Dim nodo As Object
    Dim oF As Form
       
    On Error Resume Next
       
    Frame1.Visible = False
   
    If Not UltimoNodoSeleccionado Is Nothing Then
        If UltimoNodoSeleccionado.BackColor = &H8000000F Then
            UltimoNodoSeleccionado.BackColor = &H80000005
        End If
    End If

    Node.BackColor = &H8000000F
    Set UltimoNodoSeleccionado = Node
   
    If glbSonidoNavegacion And Not glbModoAccesosUsuarios Then Sonido "Start Navigation"
   
    Toolbar1.Buttons("Print").Enabled = (Node.Key <> "Ppal")
    Toolbar1.Buttons("CopiarCampo").Visible = False
    
    
    
   
    ' armar una función de carga de la lista
    Me.MousePointer = vbHourglass
   
    Lista.ListItems.Clear
    Lista.ColumnHeaders.Clear
   
    k_node = Node.Key


    If k_node = "BotoneraOperador" Then
            Frame3.ZOrder 0
            Frame3.Visible = True
           GoTo Fin
    End If
           
    If mId(k_node, 1, 1) = "-" Or mId(k_node, 1, 1) = "+" Then
        k_node = mId(k_node, 1, 7)
    End If
   
    Set nodo = Arbol.SelectedItem
    clave = nodo.Key

    Do Until Len(clave) And mId(clave, 1, 1) <> "-" And mId(clave, 1, 1) <> "+"
        Set nodo = nodo.Parent
        clave = nodo.Key
    Loop

    Set nodo = Nothing
   
    If clave <> Node.Key Then
        If ControlAccesoNivelExistente(Node.Key) Then clave = Node.Key
    End If
   
    If ControlAccesoNivel(clave) >= 9 Then
        Toolbar1.Buttons(1).Enabled = False

        If ControlAccesoNivel(clave) = 10 Then
            Me.MousePointer = vbDefault
            MsgBox "El usuario no tiene acceso a esta informacion", vbCritical
            Exit Sub
        End If

    Else

        If Not Toolbar1.Buttons(1).Enabled Then Toolbar1.Buttons(1).Enabled = True
    End If
   
    If mId(k_node, 1, 1) = "+" Then
        DatosFecha = VBA.Split(Node.Text, " ")
        DatosFecha(0) = NumeroMes(DatosFecha(0))
        Desde = DateSerial(DatosFecha(1), DatosFecha(0), 1)
        Hasta = DateAdd("m", 1, Desde)
        Hasta = DateAdd("d", -1, Hasta)
    End If
   
    mOrdena = False
    mNuevo = True
    mIcono = ""
   
    Ultimo_Nodo = k_node
   
    Debug.Print k_node

    Frame3.Visible = False
    
    Select Case k_node
        Case "BotoneraOperador"
            Frame3.ZOrder 0
            Frame3.Visible = True
           GoTo Fin
     
        Case "Ppal"
            mNuevo = False

            If txtBuscador.Text = "buscar" Then
                Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("sp", "_wBusquedaProduccion", "")
            Else
                Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("sp", "_wBusquedaProduccion", txtBuscador)
            End If
                 
            GoTo Fin
     
            '//////////////////////////////////////////////////////
            'PERSONAL        //////////////////////////////////////
            '//////////////////////////////////////////////////////
        Case "Personal"
            mNuevo = False
            Set oRs = Aplicacion.Empleados.TraerFiltrado("_PorObraAsignada", -1)
            mIcono = "Empleados"
            Node.Expanded = True
            GoTo Fin

        Case "Empleados"
            Set oRs = Aplicacion.Empleados.TraerFiltrado("_PorObraAsignada", -1)
            mIcono = "Empleados"
            Node.Expanded = True
            GoTo Fin

        Case "Empleados1"
            Set oRs = Aplicacion.Empleados.TraerFiltrado("_PorObraAsignada", glbIdObraAsignadaUsuario)
            mIcono = "Empleados"
            GoTo Fin

        Case "Empleados2"
            Set oRs = Aplicacion.Empleados.TraerFiltrado("_PorObraAsignada", -2)
            mIcono = "Empleados"
            GoTo Fin

        Case "Empleados3"
            Set oRs = Aplicacion.Empleados.TraerFiltrado("_PorObraAsignada", -1)
            mIcono = "Empleados"
            GoTo Fin

            '//////////////////////////////////////////////////////
            'ORDENES DE COMPRA//////////////////////////////////////
            '//////////////////////////////////////////////////////
      
        Case "OrdenesCompra"

            If Not Node.Expanded Then Node.Expanded = True
            GoTo Salida

        Case "OrdenesCompraTodas"
            'If Mensaje("Todas las ordenes de compra", "Visualizar") Then
            Set oRs = Aplicacion.OrdenesCompra.TraerTodos
            'Else
            '   GoTo Salida
            'End If
            mIcono = "OrdenesCompra"
            GoTo Fin

        Case "OrdenesCompraAgrupadas"
            AbrirSubarbol "OrdenesCompraAgrupadas", "+SubOC1", "+SubOC2", Arbol, Node
            GoTo Salida

        Case "+SubOC1"
            Desde = DateSerial(Node.Text, 1, 1)
            Hasta = DateSerial(Node.Text, 12, 31)
            'If Mensaje("Ordenes de compra del año " & Node.Text, "Visualizar") Then
            Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("Fecha", Array(Desde, Hasta))
            'Else
            '   GoTo Salida
            'End If
            mIcono = "OrdenesCompra"
            GoTo Fin

        Case "+SubOC2"
            Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("Fecha", Array(Desde, Hasta))
            mIcono = "OrdenesCompra"
            GoTo Fin
      
            '//////////////////////////////////////////////////
      
        Case "ArticulosTodosDetallados"
            Set oRs = Aplicacion.Articulos.TraerTodos
            mIcono = "Articulos"
            GoTo Fin
      
        Case "MateriaPrimaStock"
            Set oF = New frmConsulta1

            With oF
                .Id = 1
                .Show vbModal, Me
            End With

        Case "Insumos"
            'mNuevo = False
            'Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_MateriaPrima", 4)
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorIdTipoParaLista", Array(0, "Insumo"))
            mIcono = "AjustesStock"
            GoTo Fin

        Case "MateriaPrima"
            'mNuevo = False
            'Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_MateriaPrima", 4)
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorIdTipoParaLista", Array(0, "Materia Prima"))
            mIcono = "AjustesStock"
            GoTo Fin

        Case "Semielaborado"
            'mNuevo = False
            'Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_MateriaPrima", 6)
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorIdTipoParaLista", Array(0, "Semielaborado"))
            mIcono = "AjustesStock"
            GoTo Fin

        Case "Terminado"
            'mNuevo = False
            'Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_MateriaPrima", 7)
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorIdTipoParaLista", Array(0, "Terminado"))
            mIcono = "AjustesStock"
            GoTo Fin

        Case "Subproducto"
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorIdTipoParaLista", Array(0, "Subproducto"))
            mIcono = "AjustesStock"
            GoTo Fin
      
        Case "Maquinas"
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorIdTipoParaLista", Array(0, "Equipo"))
            mIcono = "SalidaMateriales"
            GoTo Fin
           
        Case "ManodeObra"
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorIdTipoParaLista", Array(0, "Mano de obra"))
            mIcono = "SalidaMateriales"
            GoTo Fin

        Case "Area"
            Set oRs = Aplicacion.TablasGenerales.TraerTodos("ProduccionAreas")
            mIcono = "SalidaMateriales"
            GoTo Fin

        Case "Sector"
            Set oRs = Aplicacion.TablasGenerales.TraerTodos("ProduccionSectores")
            mIcono = "SalidaMateriales"
            GoTo Fin

        Case "Linea"
            Set oRs = Aplicacion.TablasGenerales.TraerTodos("ProduccionLineas")
            mIcono = "SalidaMateriales"
            GoTo Fin

        Case "Procesos"
            Set oRs = Aplicacion.TablasGenerales.TraerTodos("ProduccionProcesos")
            mIcono = "SalidaMateriales"
            GoTo Fin
      
        Case "ControlCalidad"
            Set oRs = Aplicacion.TablasGenerales.TraerTodos("PROD_TiposControlCalidad")
            mIcono = "SalidaMateriales"
            GoTo Fin
      
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////
      
        Case "PartedeProduccion"
            Desde = Now - 30
            Hasta = Now
            Set oRs = AplicacionProd.ProduccionPartes.TraerFiltrado("Fecha", Array(Desde, Hasta))
            mIcono = "Empleados"
            GoTo Fin
      
        Case "PartesAgrupadas"
            AbrirSubarbol "PartesAgrupadas", "+SubPa1", "+SubPa2", Arbol, Node
            GoTo Salida

        Case "+SubPa1"
            Desde = DateSerial(Node.Text, 1, 1)
            Hasta = DateSerial(Node.Text, 12, 31)

            If Mensaje("Partes de Producción del año " & Node.Text, "Visualizar") Then
                Set oRs = AplicacionProd.ProduccionPartes.TraerFiltrado("Fecha", Array(Desde, Hasta))
            Else
                GoTo Salida
            End If

            mIcono = "Empleados"
            GoTo Fin

        Case "+SubPa2"
            Set oRs = AplicacionProd.ProduccionPartes.TraerFiltrado("Fecha", Array(Desde, Hasta))
            mIcono = "Empleados"
            GoTo Fin

        Case "PartedeProduccionPorProceso"
            AbrirSubarbol "PartedeProduccionPorProceso", "+SubPP1", "+SubPP2", Arbol, Node
            GoTo Salida

        Case "+SubPP1"
            Dim proceso As String
            proceso = mId(Node.Key, 8)
            'If Mensaje("Ordenes de compra del año " & Node.Text, "Visualizar") Then
            Set oRs = AplicacionProd.ProduccionPartes.TraerFiltrado("_FiltradoPorProceso", Array(Val(proceso)))
            'Else
            '   GoTo Salida
            'End If
            mIcono = "Empleados"
            GoTo Fin

        Case "PartedeProduccionCompra"

            If Not Node.Expanded Then Node.Expanded = True
            GoTo Salida

        Case "PartesTodas"

            If Mensaje("Todas los Partes de Producción?", "Visualizar") Then
                Set oRs = Aplicacion.TablasGenerales.TraerTodos("ProduccionPartes")
                mIcono = "Empleados"
                GoTo Fin
                'Set oRs = AplicacionProd.ProduccionPartes.TraerTodos
            Else
                GoTo Salida
            End If

            'Icono = "Empleados"
            GoTo Fin
      
            '////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////
            'Ordenes de Compra (para debug=
        Case "OrdenesCompraAgrupadas"
            AbrirSubarbol "OrdenesProduccionAgrupadas", "+SubOP1", "+SubOP2", Arbol, Node
            'aca poner la lista de procesos/puntos de control
         
            GoTo Salida

        Case "+SubOC1"
            Desde = DateSerial(Node.Text, 1, 1)
            Hasta = DateSerial(Node.Text, 12, 31)

            If Mensaje("Ordenes de compra del año " & Node.Text, "Visualizar") Then
                Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("Fecha", Array(Desde, Hasta))
            Else
                GoTo Salida
            End If

            mIcono = "OrdenesCompra"
            GoTo Fin

        Case "+SubOC2"
            Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("Fecha", Array(Desde, Hasta))
            mIcono = "OrdenesCompra"
            GoTo Fin
            '////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////
      
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////
      
        Case "PlanificaciondeMateriales"
            Set oRs = AplicacionProd.Planes.TraerTodos
            mIcono = "SalidaMateriales"
            GoTo Fin

        Case "ProgramaciondeRecursos"
            Set oRs = AplicacionProd.ProgRecursos.TraerTodos
            mIcono = "SalidaMateriales"
            GoTo Fin
      
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////
      
        Case "Ingenieria"
            Node.Expanded = True
            Set oRs = AplicacionProd.ProduccionFichas.TraerTodos '.TraerFiltrado("_Todas", Array(glbIdObraAsignadaUsuario, "NO"))
            mIcono = "Pedidos"
            GoTo Fin

        Case "FichaTecnica"
            Set oRs = AplicacionProd.ProduccionFichas.TraerTodos '.TraerFiltrado("_Todas", Array(glbIdObraAsignadaUsuario, "NO"))
            mIcono = "Pedidos"
            GoTo Fin

        Case "FichasActivas"
            Set oRs = AplicacionProd.ProduccionFichas.TraerTodos
            oRs.Filter = "Activa='SI'"
            'Set oRs = FichasActivas(Aplicacion)
            mIcono = "Pedidos"
            GoTo Fin

        Case "FichasInactivas"
            Set oRs = AplicacionProd.ProduccionFichas.TraerTodos
            oRs.Filter = "Activa='NO'"
            'Set oRs = FichasInactivas(Aplicacion)
            mIcono = "Pedidos"
            GoTo Fin
      
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////
      
        Case "OrdendeProduccion"
            Desde = Now - 30
            Hasta = Now
            Set oRs = AplicacionProd.ProduccionPartes.TraerFiltrado("Fecha", Array(Desde, Hasta))
           
            Set oRs = AplicacionProd.ProduccionOrdenes.TraerTodos '.TraerFiltrado("_Todas", Array(glbIdObraAsignadaUsuario, "NO"))
            mIcono = "UnidadesOperativas"
            GoTo Fin
           
        Case "OrdenesProduccionCompra"

            '         If Not Node.Expanded Then Node.Expanded = True
            '        GoTo Salida
        Case "OrdendeProduccionTodas"

            If Mensaje("Todas las Ordenes de Producción", "Visualizar") Then
                Set oRs = AplicacionProd.ProduccionOrdenes.TraerTodos
                mIcono = "UnidadesOperativas"
                GoTo Fin
            Else
                GoTo Salida
            End If

            'Icono = "OrdenesCompra"
            GoTo Fin

        Case "OrdendeProduccionAgrupadas"
            AbrirSubarbol "OrdendeProduccionAgrupadas", "+SubOP1", "+SubOP2", Arbol, Node
            GoTo Salida

        Case "+SubOP1"
            Desde = DateSerial(Node.Text, 1, 1)
            Hasta = DateSerial(Node.Text, 12, 31)

            If Mensaje("Ordenes de Producción del año " & Node.Text, "Visualizar") Then
                Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("Fecha", Array(Desde, Hasta))
            Else
                GoTo Salida
            End If

            mIcono = "UnidadesOperativas"
            GoTo Fin

        Case "+SubOP2"
            Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("Fecha", Array(Desde, Hasta))
            mIcono = "UnidadesOperativas"
            GoTo Fin
           
        Case "OrdendeProduccionPorProceso"
            AbrirSubarbol "OrdendeProduccionPorProceso", "+SubOX1", "+SubOX2", Arbol, Node
            GoTo Salida

        Case "+SubOX1"
            'Dim proceso As String
            proceso = mId(Node.Key, 8)
            'If Mensaje("Ordenes de compra del año " & Node.Text, "Visualizar") Then
            Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_FiltradoPorProceso", Array(Val(proceso)))
            'Else
            '   GoTo Salida
            'End If
            mIcono = "UnidadesOperativas"
            GoTo Fin
           
           
           
           
           
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////
           
           
           
                 Case "OtrosIngresosAlmacenAgrupados"
           
           
      Case "SalidaMateriales"
         Node.Expanded = True
         GoTo Salida
      Case "SalidaMaterialesTodas"
         If Mensaje("Todas las salidas", "Visualizar") Then
            If BuscarClaveINI("Mostrar costos en salida de materiales") = "NO" Then
               Set oRs = Aplicacion.SalidasMateriales.TraerFiltrado("_Todas", Array(glbIdObraAsignadaUsuario, "NO"))
            Else
               Set oRs = Aplicacion.SalidasMateriales.TraerFiltrado("_Todas", glbIdObraAsignadaUsuario)
            End If
         Else
            GoTo Salida
         End If
         mIcono = "SalidaMateriales"
         GoTo Fin
      Case "SalidaMaterialesAgrupadas"
         AbrirSubarbol "SalidaMaterialesAgrupadas", "+SubSA1", "+SubSA2", Arbol, Node
         GoTo Salida
      Case "+SubSA2"
         If BuscarClaveINI("Mostrar costos en salida de materiales") = "NO" Then
            Set oRs = Aplicacion.SalidasMateriales.TraerFiltrado("Fecha", Array(Desde, Hasta, glbIdObraAsignadaUsuario, "NO"))
         Else
            Set oRs = Aplicacion.SalidasMateriales.TraerFiltrado("Fecha", Array(Desde, Hasta, glbIdObraAsignadaUsuario))
         End If
         mIcono = "SalidaMateriales"
         GoTo Fin
      Case "SalidaMateriales1"
         Node.Expanded = True
         GoTo Salida
      Case "SalidaMaterialesTodas1"
         If Mensaje("Todas las salidas", "Visualizar") Then
            If BuscarClaveINI("Mostrar costos en salida de materiales") = "NO" Then
               Set oRs = Aplicacion.SalidasMateriales.TraerFiltrado("_Todas", Array(glbIdObraAsignadaUsuario, "NO"))
            Else
               Set oRs = Aplicacion.SalidasMateriales.TraerFiltrado("_Todas", glbIdObraAsignadaUsuario)
            End If
         Else
            GoTo Salida
         End If
         mIcono = "SalidaMateriales"
         GoTo Fin
      Case "SalidaMaterialesAgrupadas1"
         AbrirSubarbol "SalidaMaterialesAgrupadas1", "+SubS21", "+SubS22", Arbol, Node
         GoTo Salida
      Case "+SubS22"
         If BuscarClaveINI("Mostrar costos en salida de materiales") = "NO" Then
            Set oRs = Aplicacion.SalidasMateriales.TraerFiltrado("Fecha", Array(Desde, Hasta, glbIdObraAsignadaUsuario, "NO"))
         Else
            Set oRs = Aplicacion.SalidasMateriales.TraerFiltrado("Fecha", Array(Desde, Hasta, glbIdObraAsignadaUsuario))
         End If
         mIcono = "SalidaMateriales"
         GoTo Fin
      Case "SalidaMaterialesSAT"
         Node.Expanded = True
         GoTo Salida
      Case "SalidaMaterialesTodasSAT"
         mNuevo = False
         Set oRs = Aplicacion.SalidasMaterialesSAT.TraerFiltrado("_Todas")
         mIcono = "SalidaMateriales"
         GoTo Fin
      Case "SalidaMaterialesAgrupadasSAT"
         mNuevo = False
         AbrirSubarbol "SalidaMaterialesAgrupadasSAT", "+SubSA3", "+SubSA4", Arbol, Node
         GoTo Salida
      Case "+SubSA4"
         mNuevo = False
         Set oRs = Aplicacion.SalidasMaterialesSAT.TraerFiltrado("Fecha", Array(Desde, Hasta))
         mIcono = "SalidaMateriales"
         GoTo Fin
           
           
           
        Case Else
            GoTo Salida
    End Select
   
Fin:
   
    If glbModoAccesosUsuarios Then GoTo Salida
   
    If Len(mIcono) > 0 Then
        Lista.IconoGrande = mIcono
        Lista.IconoPequeño = mIcono
    Else
        Lista.IconoGrande = Node.Key
        Lista.IconoPequeño = Node.Key
    End If
   
    Lista.ListItems.Clear

    If Not mOrdena Then Lista.Sorted = False
    If Not IsEmpty(oRs) And Not oRs Is Nothing Then
        Set Lista.DataSource = oRs
        ReemplazarEtiquetasListas Lista
        Lista.Refresh
    End If

    Lista.FullRowSelect = True
   
    StatusBar1.Panels(3).Text = " " & Lista.ListItems.Count & " elementos en la lista"
   
Salida:

    Set oRs = Nothing
    Set oF = Nothing
   
    If Toolbar1.Buttons(1).Enabled And Not mNuevo Then Toolbar1.Buttons(1).Enabled = mNuevo
    'mnuFileA(0).Enabled = mNuevo
   
    If glbSonidoNavegacion Then Sonido "Complete Navigation"

    Me.MousePointer = vbDefault

End Sub

Public Sub AbrirSubarbol(ByVal mParent As String, _
                         ByVal mChildren As String, _
                         ByVal mSubChildren As String, _
                         ByRef mArbol As TreeView, _
                         ByRef mNode As Node)

    Dim sKey As String, sKey1 As String, sKey2 As String
    Dim oRs As ADOR.Recordset
    Dim oRs1 As ADOR.Recordset
         
    Select Case mParent
      
        Case "OrdendeProduccionAgrupadas"
            sKey1 = ""
            sKey2 = ""

            If mNode.children = 0 Then
                Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("Anio")

                With oRs

                    Do Until .EOF
                        mArbol.Nodes.Add "OrdendeProduccionAgrupadas", tvwChild, "+SubOP1 " & .Fields(0).Value, "" & .Fields(1).Value, "UnidadesOperativas", "UnidadesOperativas"
                        .MoveNext
                    Loop

                End With

                mNode.Expanded = True

                If oRs.RecordCount > 0 Then
                    oRs.MoveFirst

                    Do Until oRs.EOF
                        sKey = "+SubOP1 " & oRs.Fields(0).Value

                        If oRs.AbsolutePosition = 1 Then
                            sKey1 = sKey
                        End If

                        Set oRs1 = AplicacionProd.ProduccionOrdenes.TraerFiltrado("Mes", oRs.Fields(1).Value)

                        Do Until oRs1.EOF

                            If oRs1.AbsolutePosition = 1 And sKey2 = "" Then
                                sKey2 = "+SubOP2 " & oRs1.Fields(0).Value
                            End If

                            mArbol.Nodes.Add sKey, tvwChild, "+SubOP2 " & oRs1.Fields(0).Value, "" & oRs1.Fields(3).Value & " " & oRs1.Fields(1).Value, "UnidadesOperativas", "UnidadesOperativas"
                            oRs1.MoveNext
                        Loop

                        oRs1.Close
                        Set oRs1 = Nothing
                        oRs.MoveNext
                    Loop

                End If

                oRs.Close
            End If

            If sKey1 <> "" Then
                mArbol.Nodes.Item(sKey1).Expanded = True

                If sKey2 <> "" Then
                    mArbol.Nodes.Item(sKey2).Selected = True
                    Arbol_NodeClick mArbol.Nodes.Item(sKey2)
                End If
            End If
      
        Case "OrdendeProduccionPorProceso"
            sKey1 = ""
            sKey2 = ""

            If mNode.children = 0 Then
                Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_PorProceso")

                With oRs

                    Do Until .EOF
                        mArbol.Nodes.Add "OrdendeProduccionPorProceso", tvwChild, "+SubOX1 " & .Fields(1).Value, "" & .Fields(0).Value, "UnidadesOperativas", "UnidadesOperativas"
                        .MoveNext
                    Loop

                End With

                mNode.Expanded = True

                If oRs.RecordCount > 0 Then
                    oRs.MoveFirst

                    Do Until oRs.EOF
                        sKey = "+SubOX1 " & oRs.Fields(0).Value

                        If oRs.AbsolutePosition = 1 Then
                            sKey1 = sKey
                        End If

                        Set oRs1 = AplicacionProd.ProduccionOrdenes.TraerFiltrado("Mes", oRs.Fields(1).Value)

                        Do Until oRs1.EOF

                            If oRs1.AbsolutePosition = 1 And sKey2 = "" Then
                                sKey2 = "+SubOPp2 " & oRs1.Fields(0).Value
                            End If

                            mArbol.Nodes.Add sKey, tvwChild, "+SubOX2 " & oRs1.Fields(0).Value, "" & oRs1.Fields(3).Value & " " & oRs1.Fields(1).Value, "UnidadesOperativas", "UnidadesOperativas"
                            oRs1.MoveNext
                        Loop

                        oRs1.Close
                        Set oRs1 = Nothing
                        oRs.MoveNext
                    Loop

                End If

                oRs.Close
            End If

            If sKey1 <> "" Then
                mArbol.Nodes.Item(sKey1).Expanded = True

                If sKey2 <> "" Then
                    mArbol.Nodes.Item(sKey2).Selected = True
                    Arbol_NodeClick mArbol.Nodes.Item(sKey2)
                End If
            End If
      
        Case "PartesAgrupadas"
            sKey1 = ""
            sKey2 = ""

            If mNode.children = 0 Then
                Set oRs = AplicacionProd.ProduccionPartes.TraerFiltrado("Anio")

                With oRs

                    Do Until .EOF
                        mArbol.Nodes.Add "PartesAgrupadas", tvwChild, "+SubPa1 " & .Fields(0).Value, "" & .Fields(1).Value, "Empleados", "Empleados"
                        .MoveNext
                    Loop

                End With

                mNode.Expanded = True

                If oRs.RecordCount > 0 Then
                    oRs.MoveFirst

                    Do Until oRs.EOF
                        sKey = "+SubPa1 " & oRs.Fields(0).Value

                        If oRs.AbsolutePosition = 1 Then
                            sKey1 = sKey
                        End If

                        Set oRs1 = AplicacionProd.ProduccionPartes.TraerFiltrado("Mes", oRs.Fields(1).Value)

                        Do Until oRs1.EOF

                            If oRs1.AbsolutePosition = 1 And sKey2 = "" Then
                                sKey2 = "+SubPa2 " & oRs1.Fields(0).Value
                            End If

                            mArbol.Nodes.Add sKey, tvwChild, "+SubPa2 " & oRs1.Fields(0).Value, "" & oRs1.Fields(3).Value & " " & oRs1.Fields(1).Value, "Empleados", "Empleados"
                            oRs1.MoveNext
                        Loop

                        oRs1.Close
                        Set oRs1 = Nothing
                        oRs.MoveNext
                    Loop

                End If

                oRs.Close
            End If

            If sKey1 <> "" Then
                mArbol.Nodes.Item(sKey1).Expanded = True

                If sKey2 <> "" Then
                    mArbol.Nodes.Item(sKey2).Selected = True
                    Arbol_NodeClick mArbol.Nodes.Item(sKey2)
                End If
            End If
      
        Case "PartedeProduccionPorProceso"
            sKey1 = ""
            sKey2 = ""

            If mNode.children = 0 Then
                Set oRs = AplicacionProd.ProduccionPartes.TraerFiltrado("_PorProceso")

                With oRs

                    Do Until .EOF
                        mArbol.Nodes.Add "PartedeProduccionPorProceso", tvwChild, "+SubPP1 " & .Fields(1).Value, "" & .Fields(0).Value, "Empleados", "Empleados"
                        .MoveNext
                    Loop

                End With

                mNode.Expanded = True

                If oRs.RecordCount > 0 Then
                    oRs.MoveFirst

                    Do Until oRs.EOF
                        sKey = "+SubPP1 " & oRs.Fields(0).Value

                        If oRs.AbsolutePosition = 1 Then
                            sKey1 = sKey
                        End If

                        Set oRs1 = AplicacionProd.ProduccionPartes.TraerFiltrado("Mes", oRs.Fields(1).Value)

                        Do Until oRs1.EOF

                            If oRs1.AbsolutePosition = 1 And sKey2 = "" Then
                                sKey2 = "+SubOC2 " & oRs1.Fields(0).Value
                            End If

                            mArbol.Nodes.Add sKey, tvwChild, "+SubPP2 " & oRs1.Fields(0).Value, "" & oRs1.Fields(3).Value & " " & oRs1.Fields(1).Value, "OrdenesCompra", "OrdenesCompra"
                            oRs1.MoveNext
                        Loop

                        oRs1.Close
                        Set oRs1 = Nothing
                        oRs.MoveNext
                    Loop

                End If

                oRs.Close
            End If

            If sKey1 <> "" Then
                mArbol.Nodes.Item(sKey1).Expanded = True

                If sKey2 <> "" Then
                    mArbol.Nodes.Item(sKey2).Selected = True
                    Arbol_NodeClick mArbol.Nodes.Item(sKey2)
                End If
            End If

    End Select

    Set oRs = Nothing
    Set oRs1 = Nothing

End Sub

Private Sub cmdActualizar_Click()
    RefrescarConsultas
End Sub

Private Sub cmdDuplicar_Click()
    CrearCopiaDeOP (Trim(Lista.SelectedItem.Tag))
End Sub

Private Sub cmdMapa_Click()
    'Frame1.Visible = Not Frame1.Visible
    Frame3.Visible = Not Frame3.Visible
End Sub

Private Sub cmdNuevoParte_Click()
    NuevoParte
End Sub

Private Sub Command9_Click()
   Test_GenerarOtroIngreso
End Sub

Private Sub cmdParte_Click()
NuevoParte
End Sub

Private Sub Form_GotFocus()
    'Refrescar
End Sub

Private Sub Lista_DblClick()

    If Not Lista.SelectedItem Is Nothing Then
        If Len(Trim(Lista.SelectedItem.Tag)) <> 0 Then
            Editar Lista.SelectedItem.Tag
        End If
    End If
   
End Sub

Private Sub Lista_FinCarga()

    SetearIdioma "", "DbListView"

End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, _
                        Shift As Integer)

    If KeyCode = 32 Then
        If Not Lista.SelectedItem Is Nothing Then
            If Len(Trim(Lista.SelectedItem.Tag)) <> 0 Then
                Editar Lista.SelectedItem.Tag
            End If
        End If
    End If
   
End Sub

Private Sub Lista_MouseMove(Button As Integer, _
                            Shift As Integer, _
                            X As Single, _
                            Y As Single)

    If Button = vbLeftButton Then Lista.OleDrag

End Sub

Private Sub Lista_MouseUp(Button As Integer, _
                          Shift As Integer, _
                          X As Single, _
                          Y As Single)

    If Button = vbRightButton Then
        If Not Lista.SelectedItem Is Nothing Then
            If Lista.ListItems.Count > 0 Then
                Dim i As Integer
            
                If InStr(1, Lista.ColumnHeaders(1).Text, "Pedido") <> 0 Then
                    MnuDetA(5).Visible = True
                    MnuDetA(9).Visible = True
                    MnuDetA(12).Visible = True
                    MnuDetA(13).Visible = True
                    MnuDetA(15).Visible = True

                    If Not glbParametrizacionNivel1 Then
                        MnuDetA(0).Enabled = True
                        MnuDetA(0).Visible = True
                    Else
                        MnuDetA(0).Visible = False
                    End If

                    MnuDetA(1).Visible = False
                    MnuDetA(2).Visible = False
                    MnuDetA(3).Visible = False
                    MnuDetA(4).Visible = False
                    MnuDetA(6).Visible = False
                    MnuDetA(7).Visible = False
                    MnuDetA(8).Visible = False
                    MnuDetA(10).Visible = False
                    MnuDetA(11).Visible = False
                    MnuDetA(14).Visible = False
                    MnuDetA(16).Visible = False
                    PopupMenu MnuDet
                End If
            
                If InStr(1, Lista.ColumnHeaders(4).Text, "Art. Producido") <> 0 Then
                    If Not glbParametrizacionNivel1 Then
                        MnuDetA(0).Enabled = True
                        MnuDetA(0).Visible = True
                        MnuDetA(1).Visible = False
                        MnuDetA(2).Visible = False
                        MnuDetA(3).Visible = False
                        MnuDetA(4).Visible = False
                        MnuDetA(5).Visible = False
                        MnuDetA(6).Visible = False
                        MnuDetA(7).Visible = False
                        MnuDetA(8).Visible = False
               
                        PopupMenu MnuDet, , , , MnuDetA(0)
                    End If
                End If
            
                If Lista.ColumnHeaders.Count >= 12 Then
                    If InStr(1, Lista.ColumnHeaders(12).Text, "Dif.cambio u$s") <> 0 Then
                        'PopupMenu MnuDif
                    End If
                End If
            
                If Lista.ColumnHeaders.Count >= 1 Then
                    If InStr(1, Lista.ColumnHeaders(1).Text, "Codigo material") <> 0 Then
                        'PopupMenu MnuArt, , , , MnuArtA(0)
                    End If
                End If
         
            End If
        End If
    End If

End Sub

Private Sub Lista_OLEGiveFeedback(Effect As Long, _
                                  DefaultCursors As Boolean)
   
    DefaultCursors = True

End Sub

Private Sub Lista_OLEStartDrag(Data As MSComctlLib.IVBDataObject, _
                               AllowedEffects As Long)

    AllowedEffects = vbDropEffectCopy

End Sub

Private Sub MnuArtA_Click(Index As Integer)

    Dim oF As Form
    Dim Filas
    Dim Columnas
    Dim s As String, clave As String
    Dim iFilas As Integer
    Dim mOk As Boolean
    Dim mAlicuotaIVA As Double
         
    Select Case Index
      
        Case 0
         
            Set oF = New frm_Aux

            With oF
                .Caption = "Cambio alicuota IVA"
                .Label1.Caption = "Alicuota IVA :"
                .Show vbModal, Me
                mAlicuotaIVA = Val(.text1.Text)
                mOk = .Ok
            End With

            Unload oF
            Set oF = Nothing

            If mOk Then
                Filas = VBA.Split(Lista.GetString, vbCrLf)
                s = ""

                For iFilas = LBound(Filas) + 1 To UBound(Filas)
                    Columnas = VBA.Split(Filas(iFilas), vbTab)

                    If IsNumeric(Columnas(3)) Then
                        Aplicacion.Tarea "Articulos_RegistrarAlicuotaIVA", Array(Columnas(3), mAlicuotaIVA)
                    End If

                Next

                Set Lista.DataSource = Aplicacion.Articulos.TraerTodos
            End If
         
        Case 1
         
            Filas = VBA.Split(Lista.GetString, vbCrLf)
            s = ""

            For iFilas = LBound(Filas) + 1 To UBound(Filas)
                Columnas = VBA.Split(Filas(iFilas), vbTab)

                If IsNumeric(Columnas(3)) Then
                    Aplicacion.Tarea "Articulos_RecalcularCostoPPP_PorIdArticulo", Columnas(3)
                End If

            Next

            MsgBox "Proceso completado", vbInformation
         
        Case 2
      
            EmisionEtiquetasArticulos Lista.GetString
         
        Case 3
      
            EmisionEtiquetasArticulosZebra Lista.GetString
         
    End Select

End Sub

Private Sub MnuAsiA_Click(Index As Integer)

    Select Case Index

        Case 0
            RenumerarAsientos

        Case 1
            CopiarAsiento

        Case 2
            RevertirAsiento
      
    End Select

End Sub

Private Sub MnuAyuda_Click(Index As Integer)

    Select Case Index

        Case 0
            Dim oF As frmAbout
            Set oF = New frmAbout
            oF.Show vbModal, Me
            Unload oF
            Set oF = Nothing

        Case 1
            VerAyuda
    End Select

End Sub

Private Sub MnuConcA_Click(Index As Integer)

    If Index = 5 Then
        QuitarMarcaAprobacionConciliacion
        Exit Sub
    End If
   
    Dim oF As Form
    Dim s As String, clave As String, mFiltro As String, Clave1 As String
    Dim FechaDesde As Date, FechaHasta As Date
    Dim nodo As Object
    Dim Filas, Columnas, ColumnasTitulos
    Dim iFilas As Integer

    s = Arbol.SelectedItem.Key

    Do Until Len(s) And mId(s, 1, 1) <> "-"
        s = Arbol.SelectedItem.Parent.Key
    Loop

    If mId(s, 1, 1) = "+" Then
        s = mId(s, 1, 7)
    End If

    Set nodo = Arbol.SelectedItem
    clave = nodo.Key
    Clave1 = ""

    Do Until Len(clave) And mId(clave, 1, 1) <> "-" And mId(clave, 1, 1) <> "+"

        If InStr(1, clave, "SubCn2") <> 0 Then
            Clave1 = clave
        End If

        Set nodo = nodo.Parent
        clave = nodo.Key
    Loop

    Set nodo = Nothing

    If Not ControlAcceso(clave) Or ControlAccesoNivel(clave) >= 9 Then
        MsgBox "El usuario no tiene acceso a esta informacion", vbCritical
        Exit Sub
    End If
         
    Select Case Index
      
        Case 0

            If Len(Clave1) = 0 Then
                MsgBox "Debe posicionarse en el arbol del sistema debajo de la cuenta bancaria"
                Exit Sub
            End If
         
            If ControlAccesoNivel(clave) > EnumAccesos.Medio Then
                MsgBox "Permiso insuficiente para la operacion", vbExclamation
                Exit Sub
            End If
         
            Columnas = VBA.Split(Clave1, " ")
         
            'Set oF = New frmConciliacion
            With oF
                .NivelAcceso = EnumAccesos.Alto
                .IdCuentaBancaria = Columnas(1)
                .Id = -1
                .Show , Me
            End With
         
        Case 1

            If ControlAccesoNivel(clave) > EnumAccesos.Medio Then
                MsgBox "Permiso insuficiente para la operacion", vbExclamation
                Exit Sub
            End If
         
            Filas = VBA.Split(Lista.GetString, vbCrLf)
            ColumnasTitulos = VBA.Split(Filas(0), vbTab)
            s = "0"

            For iFilas = LBound(Filas) + 1 To UBound(Filas)
                Columnas = VBA.Split(Filas(iFilas), vbTab)

                If IsNumeric(Columnas(2)) Then
                    Aplicacion.Tarea "Valores_MarcarComoConciliado", Columnas(2)
                    s = Columnas(3)
                End If

            Next
         
            mFiltro = Lista.Filtrado
            Arbol_NodeClick Arbol.SelectedItem

            If Len(mFiltro) > 0 Then Lista.Filtrado = mFiltro
   
        Case 2

            If ControlAccesoNivel(clave) > EnumAccesos.Medio Then
                MsgBox "Permiso insuficiente para la operacion", vbExclamation
                Exit Sub
            End If
         
            Filas = VBA.Split(Lista.GetString, vbCrLf)
            ColumnasTitulos = VBA.Split(Filas(0), vbTab)
            s = "0"

            For iFilas = LBound(Filas) + 1 To UBound(Filas)
                Columnas = VBA.Split(Filas(iFilas), vbTab)

                If IsNumeric(Columnas(2)) Then
                    Aplicacion.Tarea "Valores_DesmarcarConciliacion", Columnas(2)
                    s = Columnas(3)
                End If

            Next
   
            mFiltro = Lista.Filtrado
            Arbol_NodeClick Arbol.SelectedItem

            If Len(mFiltro) > 0 Then Lista.Filtrado = mFiltro
   
        Case 3

            If ControlAccesoNivel(clave) > EnumAccesos.Medio Then
                MsgBox "Permiso insuficiente para la operacion", vbExclamation
                Exit Sub
            End If
         
            MarcarValoresComoConfirmados
         
            mFiltro = Lista.Filtrado
            Arbol_NodeClick Arbol.SelectedItem

            If Len(mFiltro) > 0 Then Lista.Filtrado = mFiltro
   
        Case 4

            If ControlAccesoNivel(clave) > EnumAccesos.Medio Then
                MsgBox "Permiso insuficiente para la operacion", vbExclamation
                Exit Sub
            End If
         
            Filas = VBA.Split(Lista.GetString, vbCrLf)
            ColumnasTitulos = VBA.Split(Filas(0), vbTab)
            s = "0"

            For iFilas = LBound(Filas) + 1 To UBound(Filas)
                Columnas = VBA.Split(Filas(iFilas), vbTab)

                If IsNumeric(Columnas(2)) Then
                    Aplicacion.Tarea "Valores_DesmarcarConfirmacion", Columnas(2)
                    s = Columnas(3)
                End If

            Next
   
            mFiltro = Lista.Filtrado
            Arbol_NodeClick Arbol.SelectedItem

            If Len(mFiltro) > 0 Then Lista.Filtrado = mFiltro
   
    End Select
   
    Set oF = Nothing

End Sub

Private Sub mnuAjusteStock_Click()

    Dim oF
    Set oF = New frmAjustesStock

    With oF
        .NivelAcceso = 1 ' ControlAccesoNivel(clave)
        .OpcionesAcceso = 1 ' ControlAccesoOpciones(clave)
        .Id = -1
        .Disparar = ActL
        Me.MousePointer = vbDefault
        .Show , Me
    End With
   
End Sub

Private Sub MnuDetA_Click(Index As Integer)

    Dim oF As Form
    Dim s As String, clave As String, mFiltro As String
    Dim nodo As Object
    Dim Filas
    Dim Columnas
    Dim ColumnasTitulos
    Dim iFilas As Integer

    s = Arbol.SelectedItem.Key

    Do Until Len(s) And mId(s, 1, 1) <> "-"
        s = Arbol.SelectedItem.Parent.Key
    Loop

    If mId(s, 1, 1) = "+" Then
        s = mId(s, 1, 7)
    End If

    Set nodo = Arbol.SelectedItem
    clave = nodo.Key

    Do Until Len(clave) And mId(clave, 1, 1) <> "-" And mId(clave, 1, 1) <> "+"
        Set nodo = nodo.Parent
        clave = nodo.Key
    Loop

    Set nodo = Nothing

    If Not ControlAcceso(clave) Or ControlAccesoNivel(clave) >= 9 Then
        MsgBox "El usuario no tiene acceso a esta informacion", vbCritical
        Exit Sub
    End If
         
    Select Case Index

        Case 0
            'EditarOP
            
            Dim oFOP As frmProduccionOrden
            Set oFOP = New frmProduccionOrden

            With oFOP
      
                .NivelAcceso = frmPrincipal.ControlAccesoNivel("OrdendeProduccion")
                .OpcionesAcceso = frmPrincipal.ControlAccesoOpciones("OrdendeProduccion")

                .Id = -1

                If Not glbPermitirModificacionTabulados Then
                    If ExisteControlEnFormulario(oFOP, "lblTabIndex") Then
                        '.lblTabIndex.Visible = False
                    End If
                End If
 
                'dcfields(dcf_ARTICULOPRODUCIDO).BoundText =
                'dcfields(dcf_COLORPRODUCIDO).BoundText =
                oFOP.CargarFicha
       
                '.Disparar = ActL
                'Me.MousePointer = vbDefault
                .Show
            End With


            Filas = VBA.Split(Lista.GetString, vbCrLf)
            s = ""

            For iFilas = LBound(Filas) + 1 To UBound(Filas)
                Columnas = VBA.Split(Filas(iFilas), vbTab)

                If IsNumeric(Columnas(2)) Then
                    'Aplicacion.Tarea "OrdenesPago_MarcarComoPendiente", Columnas(2)
                    Exit For
                End If

            Next


            oFOP.TraerOPyANular (Columnas(0))
            Set oFOP = Nothing
         
         
        Case 2

            If ControlAccesoNivel(clave) > EnumAccesos.Medio Then
                MsgBox "Permiso insuficiente para la operacion", vbExclamation
                Exit Sub
            End If
         
            Filas = VBA.Split(Lista.GetString, vbCrLf)
            s = ""

            For iFilas = LBound(Filas) + 1 To UBound(Filas)
                Columnas = VBA.Split(Filas(iFilas), vbTab)

                If IsNumeric(Columnas(2)) Then
                    Aplicacion.Tarea "OrdenesPago_MarcarComoEntregado", Columnas(2)
                End If

            Next

            Set Lista.DataSource = Aplicacion.OrdenesPago.TraerFiltrado("_EnCaja")
         
        Case 3

            If ControlAccesoNivel(clave) > EnumAccesos.Medio Then
                MsgBox "Permiso insuficiente para la operacion", vbExclamation
                Exit Sub
            End If
         
            Filas = VBA.Split(Lista.GetString, vbCrLf)
            s = ""

            For iFilas = LBound(Filas) + 1 To UBound(Filas)
                Columnas = VBA.Split(Filas(iFilas), vbTab)

                If IsNumeric(Columnas(2)) Then
                    Aplicacion.Tarea "OrdenesPago_MarcarComoPendiente", Columnas(2)
                End If

            Next

            Set Lista.DataSource = Aplicacion.OrdenesPago.TraerFiltrado("_EnCaja")
         
        Case 4

            If ControlAccesoNivel(clave) > EnumAccesos.Medio Then
                MsgBox "Permiso insuficiente para la operacion", vbExclamation
                Exit Sub
            End If
         
            Filas = VBA.Split(Lista.GetString, vbCrLf)
            s = ""

            For iFilas = LBound(Filas) + 1 To UBound(Filas)
                Columnas = VBA.Split(Filas(iFilas), vbTab)

                If IsNumeric(Columnas(2)) Then
                    Aplicacion.Tarea "OrdenesPago_MarcarComoEnCaja", Columnas(2)
                End If

            Next

            Set Lista.DataSource = Aplicacion.OrdenesPago.TraerFiltrado("_ALaFirma")
         
        Case 5
            RegistrosDocumentosAExportar "Pedidos", 17, "NO"
      
        Case 6
            RegistrosDocumentosAExportar "Requerimientos", 1
   
        Case 7
            Dim mSeguro As Integer
            mSeguro = MsgBox("Esta seguro de eliminar los comprobantes ?", vbYesNo, "Eliminacion de comprobantes a confirmar")

            If mSeguro = vbYes Then
                EliminarComprobantesAConfirmar
            End If
         
        Case 8
            Dim mSeguro1 As Integer
            mSeguro1 = MsgBox("Esta seguro de eliminar las RM's ?", vbYesNo, "Eliminacion de RM's a confirmar")

            If mSeguro1 = vbYes Then
                EliminarRMAConfirmar
            End If
         
        Case 9
            RegistrosDocumentosAExportar "Pedidos", 17, "SI"
      
        Case 10
            MarcaImpresion "Marcar", "RM"
   
        Case 11
            MarcaImpresion "Desmarcar", "RM"
   
        Case 12
            MarcaImpresion "Marcar", "PE"
   
        Case 13
            MarcaImpresion "Desmarcar", "PE"
   
        Case 14
            Envio_RM_Proveedores
   
        Case 15
            RegistrarFechaSalidaPedido
   
        Case 16
            EnvioFax_RM_Proveedores
   
    End Select
   
    Set oF = Nothing

End Sub

Private Sub MnuDetAF_Click(Index As Integer)

    '   EditarConsulta "AF", Index, MnuDetAF(Index).Caption

End Sub

Private Sub MnuDifA_Click(Index As Integer)

    If Not Lista.SelectedItem Is Nothing Then
      
        Dim oL As ListItem
        Dim mTipoEntidad As String
      
        mTipoEntidad = Lista.ColumnHeaders.Item(2).Text
      
        Select Case Index

            Case 0
                Dim oAp As ComPronto.Aplicacion
                Dim oDif As ComPronto.DiferenciaCambio
                Set oAp = Aplicacion
                Set oDif = oAp.DiferenciasCambio.Item(Lista.SelectedItem.Tag)
                oDif.Registro.Fields("Estado").Value = "AN"
                oDif.Guardar
                Set oDif = Nothing
                Lista.ListItems.Remove (Lista.SelectedItem.Index)
                Set oAp = Nothing

            Case 1

                '            GenerarDiferenciasCambio Lista
            Case 2

                '            Lista.ListItems.Clear
                '            Lista.ColumnHeaders.Clear
                '            If mTipoEntidad = "Cliente" Then
                '               Set Lista.DataSource = Aplicacion.DiferenciasCambio.TraerFiltrado("_PorCobranzasTodos")
                '            Else
                '               Set Lista.DataSource = Aplicacion.DiferenciasCambio.TraerFiltrado("_PorPagosTodos")
                '            End If
                '            StatusBar1.Panels(2).Text = "Diferencias de cambio " & Lista.ListItems.Count & " elementos en la lista"
            Case 3
                Lista.ListItems.Clear
                Lista.ColumnHeaders.Clear

                If mTipoEntidad = "Cliente" Then
                    Set Lista.DataSource = Aplicacion.DiferenciasCambio.TraerFiltrado("_PorCobranzasPendientes")
                Else
                    Set Lista.DataSource = Aplicacion.DiferenciasCambio.TraerFiltrado("_PorPagosPendientes")
                End If

                StatusBar1.Panels(2).Text = "Diferencias de cambio " & Lista.ListItems.Count & " elementos en la lista"

            Case 4

                For Each oL In Lista.ListItems

                    If oL.Selected Then
                        oL.SubItems(15) = "SI"
                    End If

                Next

            Case 5

                For Each oL In Lista.ListItems

                    If oL.Selected Then
                        oL.SubItems(15) = "NO"
                    End If

                Next

            Case 6
                ExportarDiferenciasDeCambioAExcel Lista
        End Select

    End If

End Sub

Private Sub MnuEmiChA_Click(Index As Integer)

    Dim s As String, clave As String
    Dim mFiltro As String
    Dim nodo As Object
    Dim Filas
    Dim Columnas
    Dim ColumnasTitulos
    Dim oL As ListItem
    Dim iFilas As Integer

    s = Arbol.SelectedItem.Key

    Do Until Len(s) And mId(s, 1, 1) <> "-"
        s = Arbol.SelectedItem.Parent.Key
    Loop

    If mId(s, 1, 1) = "+" Then
        s = mId(s, 1, 7)
    End If

    Set nodo = Arbol.SelectedItem
    clave = nodo.Key

    Do Until Len(clave) And mId(clave, 1, 1) <> "-" And mId(clave, 1, 1) <> "+"
        Set nodo = nodo.Parent
        clave = nodo.Key
    Loop

    Set nodo = Nothing

    If Not ControlAcceso(clave) Or ControlAccesoNivel(clave) >= 9 Then
        MsgBox "El usuario no tiene acceso a esta informacion", vbCritical
        Exit Sub
    End If
         
    Select Case Index
      
        Case 0

            If ControlAccesoNivel(clave) > EnumAccesos.Medio Then
                MsgBox "Permiso insuficiente para la operacion", vbExclamation
                Exit Sub
            End If
         
            EmisionDeCheques
         
        Case 1

            If ControlAccesoNivel(clave) > EnumAccesos.Medio Then
                MsgBox "Permiso insuficiente para la operacion", vbExclamation
                Exit Sub
            End If
         
            Filas = VBA.Split(Lista.GetString, vbCrLf)
            ColumnasTitulos = VBA.Split(Filas(0), vbTab)

            For iFilas = LBound(Filas) + 1 To UBound(Filas)
                Columnas = VBA.Split(Filas(iFilas), vbTab)

                If IsNumeric(Columnas(2)) Then
                    Aplicacion.Tarea "Valores_MarcarComoEmitido", Array(Columnas(2), glbIdUsuario)

                    For Each oL In Lista.ListItems

                        If oL.ListSubItems(1) = Columnas(2) Then
                            oL.ListSubItems(21) = "SI"
                            oL.ListSubItems(22) = "" & Date
                            oL.ListSubItems(23) = "" & glbNombreUsuario
                            Exit For
                        End If

                    Next

                End If

            Next
         
        Case 2

            If ControlAccesoNivel(clave) > EnumAccesos.Medio Then
                MsgBox "Permiso insuficiente para la operacion", vbExclamation
                Exit Sub
            End If
         
            Filas = VBA.Split(Lista.GetString, vbCrLf)
            ColumnasTitulos = VBA.Split(Filas(0), vbTab)

            For iFilas = LBound(Filas) + 1 To UBound(Filas)
                Columnas = VBA.Split(Filas(iFilas), vbTab)

                If IsNumeric(Columnas(2)) Then
                    Aplicacion.Tarea "Valores_DesmarcarComoEmitido", Columnas(2)

                    For Each oL In Lista.ListItems

                        If oL.ListSubItems(1) = Columnas(2) Then
                            oL.ListSubItems(21) = "NO"
                            oL.ListSubItems(22) = ""
                            oL.ListSubItems(23) = ""
                            Exit For
                        End If

                    Next

                End If

            Next
   
        Case 3

            If ControlAccesoNivel(clave) > EnumAccesos.Medio Then
                MsgBox "Permiso insuficiente para la operacion", vbExclamation
                Exit Sub
            End If
         
            Filas = VBA.Split(Lista.GetString, vbCrLf)

            If UBound(Filas) > 2 Then
                MsgBox "Solo puede cambiar un cheque a la vez", vbExclamation
                Exit Sub
            End If
         
            CambiarBeneficiarioCheques Filas
         
    End Select
   
End Sub

Private Sub MnuEmiOP1_Click(Index As Integer)

    Select Case Index

        Case 0
            EmitirOrdenesDePago 0

        Case 1
            EmitirOrdenesDePago 1

        Case 2
            EliminarOrdenesDePago

        Case 3
            MarcarOPEnCaja

        Case 4
            ConfirmarAcreditacionFF
    End Select

End Sub

Private Sub mnuFileA_Click(Index As Integer)

    Select Case Index

        Case 0
            Editar -1

        Case 1

            If Ultimo_Nodo = "Proveedores" Then
                ImprimeProveedores "E"
            Else
                ExportarAExcel Lista
            End If

        Case 2

            If Ultimo_Nodo = "Proveedores" Then
                ImprimeProveedores "I"
            Else
                ImprimirConExcel Lista
            End If

        Case 3
            CopiarAlClipboard

        Case 4
            FiltradoLista Lista

        Case 5
            Unload Me
    End Select

End Sub

Private Sub mnuFncAccA_Click(Index As Integer)

    Select Case Index

        Case 0
            DefinirAccesosItemUsuarios
    End Select

End Sub

Private Sub mnuFncAPSyJA_Click(Index As Integer)

    Select Case Index

        Case 0
            TransferirAnticiposAlPersonalSyJ
    End Select

End Sub

Private Sub mnuFncCGA_Click(Index As Integer)

    Select Case Index

        Case 0
            MarcarCuentasGastoComoActivas "SI"

        Case 1
            MarcarCuentasGastoComoActivas "NO"
    End Select

End Sub

Private Sub mnuFncCliA_Click(Index As Integer)

    Select Case Index

        Case 0
            MarcarOrdenesCompraComoCumplidas "SI"

        Case 1
            MarcarOrdenesCompraComoCumplidas "NO"

        Case 2
            MarcarOrdenesCompraParaFacturacionAutomatica "SI"

        Case 3
            MarcarOrdenesCompraParaFacturacionAutomatica "NO"
    End Select

End Sub

Private Sub mnuFncConjA_Click(Index As Integer)

    Select Case Index

        Case 0
            RecalcularCostoKits
    End Select

End Sub

Private Sub mnuFncCPA_Click(Index As Integer)

    Select Case Index

        Case 0
            RegrabarComprobantesProveedores

        Case 1
            RecalcularGrabarComprobantesProveedores

        Case 2
            DefinirDestinoPagoComprobantesProveedores

        Case 3
            SeleccionarComprobantesProveedores

        Case 4
            DefinirOPFondoReparoComprobantesProveedores
    End Select

End Sub

Private Sub mnuFncCuoA_Click(Index As Integer)

    Select Case Index

        Case 0
            EliminarVentaEnCuotas

        Case 1
            ModificarVencimientosVentaEnCuotas
    End Select

End Sub

Private Sub mnuFncFacA_Click(Index As Integer)

    Select Case Index

        Case 0
            EmitirFacturas 0

        Case 1
            EmitirFacturas 1

        Case 2
            EliminarFacturasAnuladas
    End Select

End Sub

Private Sub mnuFncFFA_Click(Index As Integer)

    Select Case Index

        Case 0
            CierreRendicionFF
   
    End Select

End Sub

Private Sub mnuFncNCA_Click(Index As Integer)

    Select Case Index

        Case 0
            EmitirNotasCredito 0

        Case 1
            EmitirNotasCredito 1
    End Select

End Sub

Private Sub mnuFncPEA_Click(Index As Integer)

    Select Case Index

        Case 0
            DistribuirTeoricosPorMatrices
    End Select

End Sub

Private Sub mnuFncProvA_Click(Index As Integer)

    Select Case Index

        Case 0
            PasarProveedorEventualADefinitivo
    End Select

End Sub

Private Sub MnuObrasA_Click(Index As Integer)

    Select Case Index

        Case 0
            EmitirDatosObra 0

        Case 1
            EmitirDatosObra 1

        Case 2
            EmitirCertificadoDeServicios Lista.GetString
    End Select

End Sub

Private Sub mnuMapa_Click()
    frmMapa.Show , Me
End Sub

Private Sub mnuSalidaMateriales_Click()
    
    Dim oF
    Set oF = New frmSalidasMateriales

    With oF
        .NivelAcceso = 1 'ControlAccesoNivel(clave)
        .OpcionesAcceso = 1 'ControlAccesoOpciones(clave)
        .Id = -1
        .Disparar = ActL
        Me.MousePointer = vbDefault
        .Show , Me
    End With

End Sub

Private Sub mnuScriptGUIopsqueseenganchan_Click()
    ScriptazoDeOPsQueSeEnganchan
End Sub

Private Sub MnuSeg_Click(Index As Integer)

    Dim oF As Form
    Dim oArbol As Object
    Dim mAcceder As Integer
    Dim mModal As Boolean
   
    Select Case Index

        Case 0

            If Not glbAdministrador Then
                mAcceder = MsgBox("Para ingresar a este modulo debe tener permiso de ADMINISTRADOR" & vbCrLf & "Desea login de supervisores ?", vbYesNo, "Acceso a supervisores")

                If mAcceder = vbNo Then
                    Exit Sub
                End If

                If Not DefinirAdministrador Then
                    MsgBox "Para ingresar a este modulo debe tener permiso de ADMINISTRADOR", vbCritical
                    Exit Sub
                End If
            End If

            Set oArbol = ArbolDefault
            Set oF = New frmAccesos

            With oF
                .Id = glbIdUsuario
                .ParentArbol = oArbol
                Set .ParentForm = Me
                .Show vbModal, Me
            End With

            mModal = True

        Case 1

            If Not glbAdministrador Then
                mAcceder = MsgBox("Para ingresar a este modulo debe tener permiso de ADMINISTRADOR" & vbCrLf & "Desea login de supervisores ?", vbYesNo, "Acceso a supervisores")

                If mAcceder = vbNo Then
                    Exit Sub
                End If

                If Not DefinirAdministrador Then
                    MsgBox "Para ingresar a este modulo debe tener permiso de ADMINISTRADOR", vbCritical
                    Exit Sub
                End If
            End If

            Set oArbol = Arbol
            Set oF = New frmAutorizaciones

            With oF
                .Show vbModal, Me
            End With

            mModal = True

        Case 2

            'Set oF = New frmAutorizacionesArbol
            With oF
                .Show , Me
            End With

            mModal = False

        Case 3

            'Set oF = New frmConsulta2
            With oF
                .Id = 1
                .Show , Me
            End With

            mModal = False

        Case 4

            'Set oF = New frmConsulta2
            With oF
                .Id = 2
                .Show , Me
            End With

            mModal = False

        Case 5

            'Set oF = New frmEventosDelSistema
            With oF
                .Show , Me
            End With

            mModal = False

        Case 6
            VerNovedades = True
            VerNovedadesEventos

        Case 7

            If Not glbAdministrador Then
                mAcceder = MsgBox("Para ingresar a este modulo debe tener permiso de ADMINISTRADOR" & vbCrLf & "Desea login de supervisores ?", vbYesNo, "Acceso a supervisores")

                If mAcceder = vbNo Then
                    Exit Sub
                End If

                If Not DefinirAdministrador Then
                    MsgBox "Para ingresar a este modulo debe tener permiso de ADMINISTRADOR", vbCritical
                    Exit Sub
                End If
            End If

            'Set oF = New frmDefinicionAnulaciones
            With oF
                .Show , Me
            End With

            mModal = False

        Case 8

            'Set oF = New frmConsulta2
            With oF
                .Id = 106
                .Show , Me
            End With

            mModal = False

        Case 9

            If Not glbAdministrador Then
                mAcceder = MsgBox("Para ingresar a este modulo debe tener permiso de ADMINISTRADOR" & vbCrLf & "Desea login de supervisores ?", vbYesNo, "Acceso a supervisores")

                If mAcceder = vbNo Then
                    Exit Sub
                End If

                If Not DefinirAdministrador Then
                    MsgBox "Para ingresar a este modulo debe tener permiso de ADMINISTRADOR", vbCritical
                    Exit Sub
                End If
            End If

            Set oF = New frmProntoIni

            With oF
                .Show , Me
            End With

            mModal = False
    End Select

    If mModal Then Unload oF
    Set oF = Nothing
    Set oArbol = Nothing
   
    If Index <= 1 Then
        CargarPermisos
        CargarArbol
        CargarPopUpMenu
    End If

End Sub

Private Sub MnuSub_Click(Index As Integer)
  
    EditarConsulta "", Index, MnuSub(Index).Caption

End Sub

Private Sub MnuSubA_Click(Index As Integer)

    'EditarConsulta "A", Index, MnuSubA(Index).Caption

End Sub

Private Sub MnuSubBco_Click(Index As Integer)

    EditarConsulta "Bco", Index

End Sub

Private Sub MnuSubC_Click(Index As Integer)

    'EditarConsulta "C", Index, MnuSubC(Index).Caption

End Sub

Private Sub MnuSubCli_Click(Index As Integer)

    EditarConsulta "Cli", Index

End Sub

Private Sub MnuSubCliRet_Click(Index As Integer)

    EditarConsulta "CliRet", Index

End Sub

Private Sub MnuSubCliRetSIC_Click(Index As Integer)

    EditarConsulta "CliRetSIC", Index

End Sub

Private Sub MnuSubCo_Click(Index As Integer)

    EditarConsulta "Co", Index

End Sub

Private Sub MnuSubCoA_Click(Index As Integer)

    Select Case Index

        Case 0
            Dim oF 'As frmDefinicionCuadroIngresosEgresos

            'Set oF = New frmDefinicionCuadroIngresosEgresos
            With oF
                .Show vbModal, Me
            End With

            Unload oF
            Set oF = Nothing

        Case 1
            EditarConsulta "SubCoA", Index
    End Select

End Sub

Private Sub MnuSubCoB_Click(Index As Integer)

    Select Case Index

        Case 0
            Dim oF 'As frmDefinicionFlujoCaja

            'Set oF = New frmDefinicionFlujoCaja
            With oF
                .Id = -1
                .Show vbModal, Me
            End With

            Unload oF
            Set oF = Nothing

        Case Else
            'EditarConsulta "SubCoB", Index, MnuSubCoB(Index).Caption
    End Select

End Sub

Private Sub MnuSubCoC_Click(Index As Integer)

    'EditarConsulta "SubCoC", Index, MnuSubCoC(Index).Caption

End Sub

Private Sub MnuSubCom_Click(Index As Integer)

    EditarConsulta "Com", Index

End Sub

Private Sub MnuSubF_Click(Index As Integer)

    'EditarConsulta "F", Index, MnuSubF(Index).Caption

End Sub

Private Sub MnuSubO_Click(Index As Integer)

    EditarConsulta "O", Index

End Sub

Private Sub MnuSubP_Click(Index As Integer)

    'EditarConsulta "P", Index, MnuSubP(Index).Caption

End Sub

Private Sub MnuSubPer_Click(Index As Integer)

    EditarConsulta "Per", Index

End Sub

Private Sub MnuSubPrv_Click(Index As Integer)

    EditarConsulta "Prv", Index

End Sub

Private Sub MnuSubPrvRet_Click(Index As Integer)

    EditarConsulta "PrvRet", Index

End Sub

Private Sub MnuSubPrvRetSIC_Click(Index As Integer)

    EditarConsulta "PrvRetSIC", Index

End Sub

Private Sub MnuSubPrvRetSIF_Click(Index As Integer)

    EditarConsulta "PrvRetSIF", Index

End Sub

Private Sub MnuSubS_Click(Index As Integer)

    EditarConsulta "S", Index

End Sub

Private Sub Form_Initialize()

    InitCommonControls

End Sub

Private Sub Form_Activate()

    If VerNovedades Then
        VerNovedadesEventos
    End If
   
End Sub

Private Sub Form_Load()

    On Error Resume Next

    Dim lReturn As Long
   
    Screen.MousePointer = vbHourglass

    '   Load Splash
    '   Splash.Show
    DoEvents

    mLOCALE_SMONDECIMALSEP = GetRegionalSetting(LOCALE_SMONDECIMALSEP)

    If mLOCALE_SMONDECIMALSEP <> "." Then
        lReturn = SetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SMONDECIMALSEP, ".")
    End If

    mLOCALE_SMONTHOUSANDSEP = GetRegionalSetting(LOCALE_SMONTHOUSANDSEP)

    If mLOCALE_SMONTHOUSANDSEP <> "," Then
        lReturn = SetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SMONTHOUSANDSEP, ",")
    End If

    mLOCALE_SDECIMAL = GetRegionalSetting(LOCALE_SDECIMAL)

    If mLOCALE_SDECIMAL <> "." Then
        lReturn = SetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SDECIMAL, ".")
    End If

    mLOCALE_STHOUSAND = GetRegionalSetting(LOCALE_STHOUSAND)

    If mLOCALE_STHOUSAND <> "," Then
        lReturn = SetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_STHOUSAND, ",")
    End If



    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    'PIDE CONEXION A LA BASE EN EL LISTBOX

    Screen.MousePointer = vbNormal
    AnalizarStringConnection
    Screen.MousePointer = vbHourglass
   
    
    
    If Err.Number <> 0 Then
        'If Err.Number = 429 Then
        MsgBox "Error. Verificar cadena de conexión"
        End
        'End If
    End If
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
   
    '   Dim mArchivoDefinicionConexion As String
    '   Dim mvarDefineConexion As Integer
    '   Dim mOK As Boolean
    '   mArchivoDefinicionConexion = Dir(GetWinDir & "\" & App.Title, vbArchive)
    '   If mArchivoDefinicionConexion = "" Then
    '      mvarDefineConexion = MsgBox("No existe definicion de acceso a la base de datos del sistema." & vbCrLf & _
    '                                    "Desea definirla ahora?", vbYesNo, "Conexion a la base de datos")
    '      If mvarDefineConexion = vbNo Then
    '         End
    '      End If
    '      Dim of As frmInicial
    '      Set of = New frmInicial
    '      With of
    '         .Show vbModal, Me
    '         mOK = .Ok
    '      End With
    '      Unload of
    '      Set of = Nothing
    '      If Not mOK Then
    '         End
    '      End If
    '   End If
   
    Dim success%
    Dim iStatusBarWidth As Integer
   
    '   On Error GoTo SplashLoadErr
   
    glbMenuPopUpCargado = False
    glbMenuPopUpCargado1 = False
    glbModoAccesosUsuarios = False
    VerNovedades = True
    iStatusBarWidth = 4575
    gblMaximaLongitudAdjuntos = 100

    Dim oAp As ComPronto.Aplicacion
    Dim oRs As ADOR.Recordset
    Dim i As Integer, SN As Integer
    Dim mAux1 As String
    Dim mAux
   
    Set Aplicacion = CreateObject("ComPronto.Aplicacion")

    If Err.Number <> 0 Then
        'If Err.Number = 429 Then
        MsgBox "Error. Verificar la instalación de las DLLs (no importa que en la ventana de Referencias figure. Confirmar el registro de la DLL desregistrandola y volviendola a registrar"
        End
        'End If
    End If

    Aplicacion.StringConexion = glbStringConexion
   
    'Set AplicacionProd = CreateObject("compronto.Aplicacion")
    'AplicacionProd.StringConexion = glbStringConexion
    
    Set AplicacionProd = Aplicacion



    Set oAp = Aplicacion
    Set ActL = New ControlForm
   
    Set oRs = oAp.Parametros.Item(1).Registro

    If Err.Number <> 0 Then
        MsgBox Err.Description
        
        If Err.Number = -2147221403 Then
            MsgBox "Timeout. Verificar la base de datos (Servicio SQL detenido?)"
            End
        End If

        If Err.Number = 429 Then
            MsgBox "Verificar la cadena de conexion"
            End
        End If
    End If
   
    glbArchivoAyuda = IIf(IsNull(oRs.Fields("ArchivoAyuda").Value), "", oRs.Fields("ArchivoAyuda").Value)

    If IsNull(oRs.Fields("PathPlantillas").Value) Or Len(oRs.Fields("PathPlantillas").Value) = 0 Then
        glbPathPlantillas = app.Path & "\Plantillas"
    Else
        glbPathPlantillas = oRs.Fields("PathPlantillas").Value
    End If

    glbActivarCircuitoChequesDiferidos = IIf(IsNull(oRs.Fields("ActivarCircuitoChequesDiferidos").Value), "NO", oRs.Fields("ActivarCircuitoChequesDiferidos").Value)
    glbBasePRONTOSyJAsociada = IIf(IsNull(oRs.Fields("BasePRONTOSyJAsociada").Value), "", oRs.Fields("BasePRONTOSyJAsociada").Value)
    glbActivarSolicitudMateriales = IIf(IsNull(oRs.Fields("ActivarSolicitudMateriales").Value), "NO", oRs.Fields("ActivarSolicitudMateriales").Value)
    oRs.Close
   
    Load Splash
    Splash.Show

    DoEvents
    ' Establece que la pantalla de impacto permanezca en primer plano.
    success% = SetWindowPos(Splash.hwnd, HWND_TOPMOST, 0, 0, 0, 0, flags)
   
    DoEvents
    Splash.rctStatusBar.Width = iStatusBarWidth * 0.125

    mAux = TraerValorParametro2("Lenguaje")
    glbIdiomaActual = IIf(IsNull(mAux), "esp", mAux)
   
    With Lista
        Set .Icons = img32
        Set .SmallIcons = img16
    End With
   
    If Not FileExists("Debug.bat") Then
        Me.mnuTesting.Visible = False
        
        cmdCrearOP(0).Visible = False
        cmdNuevoParte.Visible = False
         
        cmdOcuparMaquina.Visible = False
         
        'cmdBuscar.Visible = False
        cmdCancelBusq.Visible = False
        txtBuscador.Visible = False
        cmdDuplicar.Visible = False
        
        listboxFiltroPeriodo.Visible = False
        'cmdMapa.Visible = False
        
        Frame2.Visible = False
        
        Me.kk.Visible = False
        Me.mnuScriptReset.Visible = False
        Me.mnuScriptGUI.Visible = False
        Me.mnuScript.Visible = False
    End If
   
    'Set mnuVerP(0) = mnuViewA(0)
    'Set mnuVerP(1) = mnuViewA(1)
    'Set mnuVerP(2) = mnuViewA(2)
    'Set mnuVerP(3) = mnuViewA(3)
   
    DoEvents
    Splash.rctStatusBar.Width = iStatusBarWidth * 0.25

    '   Set oRs = oAp.Articulos.TraerFiltrado("_ParaMenu")
    '   GrabarMenu oRs
    '   oRs.Close
   
    Set oRs = oAp.TablasGenerales.TraerFiltrado("Empresa", "_Datos")

    With oRs

        If .RecordCount > 0 Then
            glbEmpresa = IIf(IsNull(.Fields("Nombre").Value), "", .Fields("Nombre").Value)
            glbDetalleNombre = IIf(IsNull(.Fields("DetalleNombre").Value), "", .Fields("DetalleNombre").Value)
            glbDireccion = IIf(IsNull(.Fields("Direccion").Value), "", .Fields("Direccion").Value)
            glbLocalidad = IIf(IsNull(.Fields("Localidad").Value), "", .Fields("Localidad").Value)
            glbCodigoPostal = IIf(IsNull(.Fields("CodigoPostal").Value), "", .Fields("CodigoPostal").Value)
            glbProvincia = IIf(IsNull(.Fields("Provincia").Value), "", .Fields("Provincia").Value)
            glbTelefono1 = IIf(IsNull(.Fields("Telefono1").Value), "", .Fields("Telefono1").Value)
            glbTelefono2 = IIf(IsNull(.Fields("Telefono2").Value), "", .Fields("Telefono2").Value)
            glbEmail = IIf(IsNull(.Fields("Email").Value), "", .Fields("Email").Value)
            glbCuit = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
            glbCondicionIva = IIf(IsNull(.Fields("CondicionIva").Value), "", .Fields("CondicionIva").Value)
            glbDatosAdicionales1 = IIf(IsNull(.Fields("DatosAdicionales1").Value), "", .Fields("DatosAdicionales1").Value)
            glbDatosAdicionales2 = IIf(IsNull(.Fields("DatosAdicionales2").Value), "", .Fields("DatosAdicionales2").Value)
            glbDatosAdicionales3 = IIf(IsNull(.Fields("DatosAdicionales3").Value), "", .Fields("DatosAdicionales3").Value)
            glbIdCodigoIva = IIf(IsNull(.Fields("IdCodigoIva").Value), 1, .Fields("IdCodigoIva").Value)
        End If

    End With

    oRs.Close
   
    Set oRs = oAp.TablasGenerales.TraerFiltrado("BD", "_Host")
    gblHOST = ""

    If oRs.RecordCount > 0 Then
        gblHOST = oRs.Fields(0).Value
    End If

    oRs.Close
   
    Set oRs = oAp.TablasGenerales.TraerFiltrado("BD", "_BaseDeDatos")
    gblBD = ""

    If oRs.RecordCount > 0 Then
        gblBD = oRs.Fields(0).Value
    End If

    oRs.Close
   
    StatusBar1.Panels.Item(2).Text = "Host : " & gblHOST & " - BD : " & gblBD
   
    With Me
        .WindowState = GetSetting(app.EXEName, "Ppal", "EstadoVentana", vbMaximized)

        If .WindowState = vbNormal Then
            .left = GetSetting(app.EXEName, "Ppal", "Izq", 0)
            .top = GetSetting(app.EXEName, "Ppal", "Arriba", 0)
            .Width = GetSetting(app.EXEName, "Ppal", "Ancho", Screen.Width)
            .Height = GetSetting(app.EXEName, "Ppal", "Alto", Screen.Height)
        End If

    End With
   
    DoEvents
    Splash.rctStatusBar.Width = iStatusBarWidth * 0.5

    CambiarVista lvwReport
   
    UsuarioSistema = GetCurrentUserName()
    UsuarioSistema = mId(UsuarioSistema, 1, Len(UsuarioSistema) - 1)
    glbAdministrador = False
    glbInicialesUsuario = ""
    glbIdSector = 0
    glbTipoUsuario = 1
    glbLegajo = 0
    glbIdUsuario = -1
    glbIdCuentaFFUsuario = -1
    glbIdObraAsignadaUsuario = -1
    Set oRs = oAp.Empleados.TraerFiltrado("_usuarioNT", UsuarioSistema)

    With oRs

        If .RecordCount > 0 Then
            UsuarioSistema = UsuarioSistema & " [ " & IIf(IsNull(.Fields("Nombre").Value), " ", .Fields("Nombre").Value) & " ]"
            glbNombreUsuario = .Fields("Nombre").Value
            glbIdUsuario = oRs.Fields(0).Value
            glbInicialesUsuario = IIf(IsNull(oRs.Fields("Iniciales").Value), "", oRs.Fields("Iniciales").Value)
            glbIdSector = IIf(IsNull(oRs.Fields("IdSector").Value), 0, oRs.Fields("IdSector").Value)
            glbLegajo = IIf(IsNull(oRs.Fields("Legajo").Value), 0, oRs.Fields("Legajo").Value)

            If Not IsNull(oRs.Fields("Administrador").Value) Then
                If oRs.Fields("Administrador").Value = "SI" Then
                    glbAdministrador = True
                End If
            End If

            glbTipoUsuario = IIf(IsNull(oRs.Fields("TipoUsuario").Value), 1, oRs.Fields("TipoUsuario").Value)
            glbIdCuentaFFUsuario = IIf(IsNull(oRs.Fields("IdCuentaFondoFijo").Value), -1, oRs.Fields("IdCuentaFondoFijo").Value)
            glbIdObraAsignadaUsuario = IIf(IsNull(oRs.Fields("IdObraAsignada").Value), -1, oRs.Fields("IdObraAsignada").Value)

            If Not IsNull(oRs.Fields("Idioma").Value) And Len(oRs.Fields("Idioma").Value) > 0 Then
                glbIdiomaActual = oRs.Fields("Idioma").Value
            End If
        End If

        .Close
    End With

    StatusBar1.Panels.Item(1).Text = "Usuario actual : " & UsuarioSistema
   
    DoEvents
    Splash.rctStatusBar.Width = iStatusBarWidth * 0.75

    'Establece niveles de menus descolgables
    Dim oCtrl As Control
    Dim mNiv As Integer

    For Each oCtrl In Me.Controls

        If TypeOf oCtrl Is Menu Then

            Select Case oCtrl.Name

                Case "mnuMaster"
                    mNiv = 1

                Case "mnuFileA", "mnuViewA", "MnuSub", "MnuInf", "MnuSeg", "MnuUti", "MnuAyuda"
                    mNiv = 2

                Case "MnuSubA", "MnuSubCompras", "MnuSubF", "MnuSubO", "MnuSubP", "MnuSubS", "MnuSubCo", "MnuSubCom", "MnuInfA", "MnuInfCC", "MnuInfC", "MnuSubPer", "MnuSubCli", "MnuSubBco", "MnuSubC", "MnuSubPrv", "MnuUtiImp", "MnuUtiPRONTO"
                    mNiv = 3

                Case "MnuSubPrvRet", "MnuSubCliRet", "MnuSubCoA", "MnuSubCoB", "MnuSubCoC"
                    mNiv = 4

                Case Else
                    mNiv = -1
            End Select

            If mNiv > 0 Then oCtrl.Tag = mNiv
        End If

    Next
   
    CargarPermisos
    CargarArbol
    CargarPopUpMenu
   
    Set oRs = oAp.Parametros.Item(1).Registro
    glbIdMonedaDolar = -1

    If Not IsNull(oRs.Fields("IdMonedaDolar").Value) Then
        glbIdMonedaDolar = IIf(IsNull(oRs.Fields("IdMonedaDolar").Value), 0, oRs.Fields("IdMonedaDolar").Value)
        glbIdMonedaEuro = IIf(IsNull(oRs.Fields("IdMonedaEuro").Value), 0, oRs.Fields("IdMonedaEuro").Value)

        If Not IsNull(oRs.Fields("FechaUltimoCierre").Value) Then
            gblFechaUltimoCierre = oRs.Fields("FechaUltimoCierre").Value
        Else
            gblFechaUltimoCierre = DateSerial(1980, 1, 1)
        End If
    End If

    oRs.Close
   
    mAux1 = BuscarClaveINI("Parametrizacion de Nivel 1")
    glbParametrizacionNivel1 = False

    If mAux1 = "SI" Then glbParametrizacionNivel1 = True
   
    mAux1 = BuscarClaveINI("Sonido de navegacion")
    glbSonidoNavegacion = False

    If mAux1 = "SI" Then glbSonidoNavegacion = True

    mAux1 = BuscarClaveINI("Ver pedidos historicos")
    VerPedidosHistoricos = False

    If mAux1 = "SI" Then VerPedidosHistoricos = True
   
    mAux1 = BuscarClaveINI("Señal global 1")
    glbSeñal1 = False

    If mAux1 = "SI" Then glbSeñal1 = True
   
    mAux1 = BuscarClaveINI("Ingreso de comprobantes en serie")
    glbCargaEnSerie = False

    If mAux1 = "SI" Then glbCargaEnSerie = True
   
    GenerarMensajesPorControlDeStock
   
    'Sonido App.Path & "\Inicio.wav"

    DoEvents
    Splash.rctStatusBar.Width = iStatusBarWidth

    ' Desactiva el indicador de primer plano de la ventana.
    success% = SetWindowPos(Splash.hwnd, HWND_NOTOPMOST, 0, 0, 0, 0, flags)
    Unload Splash
    Screen.MousePointer = vbDefault
  
    Me.Caption = "" & glbEmpresaSegunString & " PRODUCCION (Version " & app.Major & "." & app.Minor & ")"
   
    Lista.StringConexion = glbStringConexion
   
    Set oRs = Nothing
    Set oAp = Nothing

    If glbAdministrador And BuscarClaveINI("Activar control de acceso por item-usuario") = "SI" Then
        Toolbar1.Buttons("AccesoPorUsuarios").Visible = True
    Else
        Toolbar1.Buttons("AccesoPorUsuarios").Visible = False
    End If

    If BuscarClaveINI("SQL2005") = "SI" Then
        glbDtsExec = "Dtexec"
        glbDtsExt = "dtsx"
    Else
        glbDtsExec = "Dtsrun"
        glbDtsExt = "dts"
    End If
   
    glbPermitirModificacionTabulados = True
   
    ReemplazarEtiquetas Me
   
    glbUsarPartidasParaStock = False

    If IIf(IsNull(mAux), "NO", mAux) = "SI" Then glbUsarPartidasParaStock = True
   
    'Dim MyNode As TreeNode
    'MyNode = TreeView1.Nodes(3) 'First Level
    'MyNode = MyNode.Nodes(6)  ' Second Level
    'TreeView1.SelectedNode = MyNode
    Dim nodo As Node
    'nodo = Arbol.Nodes(3)
    Arbol.SelectedItem = Arbol.Nodes(1) ' elijo Nodo Principal para que el buscador busque en todo el sistema
    Arbol.SetFocus
    nodo.EnsureVisible
    nodo.Selected = True
    txtBuscador.SetFocus
   
    'frmMapa.Show
       
    RefrescarConsultas
    Ajustar
   
    CambiarLenguaje Me, "esp", glbIdiomaActual, ""
   
'    Aplicacion.Tarea "Log_InsertarRegistro", Array("ING", 0, 0, Now, 0, "Usuario (" & glbIdUsuario & ") " & glbNombreUsuario & ", Version " & app.Major & " " & app.Minor & " " & app.Revision, GetCompName(), glbNombreUsuario, "Pronto " & app.Major & " " & app.Minor & " " & app.Revision, Null, Null, Null, Null, Null, Null, Null, glbIdUsuario, Null, Null, Null, Null)

    '//////////////////////////////////////
    '//////////////////////////////////////
    '//////////////////////////////////////
    'Mariano
    'Dim oF As Form
    'Set oF = New frmProduccionOrden
    'With oF
    '  .NivelAcceso = 1 'ControlAccesoNivel(clave)
    '  .OpcionesAcceso = 1 ' ControlAccesoOpciones(clave)
    '  .Id = -1 'Identificador
    '  If Not glbPermitirModificacionTabulados Then
    '     If ExisteControlEnFormulario(oF, "lblTabIndex") Then
    '        .lblTabIndex.Visible = False
    '     End If
    '  End If
    '  .Disparar = ActL
    '  ReemplazarEtiquetas oF
    '  Me.MousePointer = vbDefault
    '  .Show , Me
    'End With
    '//////////////////////////////////////
    '//////////////////////////////////////
    '//////////////////////////////////////
    
    Me.MnuSub(0).Visible = True
    Me.MnuSub(0).Enabled = False
    Me.MnuSub(5).Visible = True
    Me.MnuSub(6).Visible = True
    Me.MnuSub(7).Visible = True
    Me.MnuSub(7).Enabled = False
    Me.MnuSub(8).Visible = True
    Me.MnuSub(9).Visible = True
    Me.MnuSub(99).Visible = True

    Exit Sub

SplashLoadErr:
    success% = SetWindowPos(Splash.hwnd, HWND_NOTOPMOST, 0, 0, 0, 0, flags)
    Unload Splash
    Screen.MousePointer = vbDefault
    MsgBox Error$ & " - " & Str$(Err), vbExclamation, "Error al cargar la aplicación"
    Exit Sub

End Sub

Private Sub Form_Resize()

    Ajustar
   
    If txtBuscador.Visible Then txtBuscador.SetFocus
End Sub

Private Sub Form_Unload(Cancel As Integer)

    With Me
        SaveSetting app.EXEName, "Ppal", "EstadoVentana", .WindowState

        If .WindowState = vbNormal Then
            SaveSetting app.EXEName, "Ppal", "Izq", .left
            SaveSetting app.EXEName, "Ppal", "Arriba", .top
            SaveSetting app.EXEName, "Ppal", "Ancho", .Width
            SaveSetting app.EXEName, "Ppal", "Alto", .Height
        End If

    End With
   
    SaveSetting app.EXEName, "Ppal", "Vista", Lista.View
   
    Set ActL = Nothing
    Set Aplicacion = Nothing
    Set UltimoNodoSeleccionado = Nothing
   
    Dim lReturn As Long

    If GetRegionalSetting(LOCALE_SMONDECIMALSEP) <> mLOCALE_SMONDECIMALSEP Then
        lReturn = SetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SMONDECIMALSEP, mLOCALE_SMONDECIMALSEP)
    End If

    If GetRegionalSetting(LOCALE_SMONTHOUSANDSEP) <> mLOCALE_SMONTHOUSANDSEP Then
        lReturn = SetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SMONTHOUSANDSEP, mLOCALE_SMONTHOUSANDSEP)
    End If

    If GetRegionalSetting(LOCALE_SDECIMAL) <> mLOCALE_SDECIMAL Then
        lReturn = SetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SDECIMAL, mLOCALE_SDECIMAL)
    End If

    If GetRegionalSetting(LOCALE_STHOUSAND) <> mLOCALE_STHOUSAND Then
        lReturn = SetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_STHOUSAND, mLOCALE_STHOUSAND)
    End If
   
    DestroyMenu POP_hMenu
    Set cPMenu = Nothing

End Sub

Private Sub MnuSubSAT_Click(Index As Integer)

    EditarConsulta "SAT", Index

End Sub

Private Sub MnuUti_Click(Index As Integer)
    '
    '   Dim oF As Form
    '   If Index > 1 Then
    '      Select Case Index
    '         Case 2
    '            GeneracionDeFacturasAnuladas
    '         Case 3
    '            GeneracionDeFacturasAnuladasExistentes
    '         Case 4
    '            Set oF = New frmConsulta2
    '            With oF
    '               .Id = 74
    '               .Show vbModal, Me
    '            End With
    '            Set oF = Nothing
    '         Case 5
    '            GeneracionDeFacturasDesdeOrdenesCompraAutomaticas
    '         Case 6
    '            EditarConsulta "Uti", 6, MnuUti(6).Caption
    '         Case 7
    '            ImportacionInformacionImpositiva
    '         Case 8
    '            DefinicionBasesParaConsolidacion
    '         Case 9
    '            ConsolidacionContable
    '         Case 10
    '            CierreZ
    '         Case 11
    '            DefinirGruposCuentasParaAjusteEnSubdiarios
    '      End Select
    '   End If

End Sub

Private Sub MnuUtiImp_Click(Index As Integer)
    '
    '   Dim oRs As ADOR.Recordset
    '
    '   Select Case Index
    '      Case 0
    '         Dim oF As Form
    '         Dim mSeguro As Integer
    '         mSeguro = MsgBox("ANTES DE COMENZAR EL PROCESO VERIFIQUE QUE PRESTO" & vbCrLf & _
    '                           "SOLO TENGA LA VENTANA DE PRECIOS ABIERTA, SI NO ESTA" & vbCrLf & _
    '                           "SEGURO LLAME AHORA A PRESTO, ABRA LA OBRA Y CIERRE" & vbCrLf & _
    '                           "TODAS LAS VENTANAS SALVO LA DE PRECIOS." & vbCrLf & _
    '                           "CONTINUA CON EL PROCEDIMIENTO ?", vbYesNo, "PRESTO")
    '         If mSeguro = vbYes Then
    '            'Set oRs = ImportarDatosDesdePresto
    '            Set oRs = LeerPresto
    '            If Not oRs Is Nothing Then
    '               If oRs.RecordCount > 0 Then
    '                  Set oF = New frmConsulta1
    '                  With oF
    '                     Set .RecordsetFuente = oRs
    '                     .Id = 10
    '                     .Show vbModal, Me
    '                  End With
    '               Else
    '                  MsgBox "Proceso completo", vbInformation
    '               End If
    '               Set oRs = Nothing
    '            End If
    '            Me.WindowState = vbMaximized
    '         End If
    '      Case 1
    '         Set oRs = ImportarDatosDesdePrestoAccess
    '         If Not oRs Is Nothing Then
    '            If oRs.RecordCount > 0 Then
    '               Set oF = New frmConsulta1
    '               With oF
    '                  Set .RecordsetFuente = oRs
    '                  .Id = 10
    '                  .Show vbModal, Me
    '               End With
    '            Else
    '               MsgBox "Proceso completo", vbInformation
    '            End If
    '            Set oRs = Nothing
    '         End If
    '         Me.WindowState = vbMaximized
    '      Case 2
    '         Set oF = New frmImportarDATANET
    '         With oF
    '            .Show vbModal, Me
    '         End With
    '      Case 3
    '         ImportacionConjuntos
    '      Case 4
    '         ImportacionValores
    '      Case 5
    '         If BuscarClaveINI("Modelo de importacion de efectivo") <> "02" Then
    '            ImportacionEfectivo
    '         Else
    '            ImportacionEfectivo1
    '         End If
    '      Case 6
    '         ImportacionCobranzas
    '      Case 7
    '         ImportacionCobranzasPagoFacil
    '      Case 8
    '         ImportacionComprobantesProveedores
    '      Case 9
    '         If BuscarClaveINI("Modelo de importacion de comprobantes de fondo fijo") <> "02" Then
    '            ImportacionComprobantesFondoFijo
    '         Else
    '            ImportacionComprobantesFondoFijo1
    '         End If
    '      Case 10
    '         ImportacionOrdenesPago
    '      Case 11
    '         ImportacionRequerimientos
    '      Case 12
    '         ImportacionArticulos
    '      Case 13
    '         ImportacionComprobantesProveedores1
    '      Case 14
    '         If BuscarClaveINI("Modelo de importacion de asientos") <> "03" Then
    '            ImportacionAsientos
    '         Else
    '            ImportacionAsientos1
    '         End If
    '      Case 15
    '         ImportacionNotasDebito
    '   End Select

End Sub

Private Sub MnuUtiPRONTO_Click(Index As Integer)

    '   Select Case Index
    '      Case 0
    '         EnviarNovedades_PRONTO_SAT
    '      Case 1
    '         Dim oF As Form
    '         Set oF = New frmEnviarASat
    '         oF.Show , Me
    '         Set oF = Nothing
    '      Case 2
    '         ImportarNovedades_PRONTO_SAT
    '      Case 3
    '         EnviarNovedades_PRONTO_MANTENIMIENTO
    '      Case 4
    '         ExportarComprobantesXML
    '      Case 5
    '         EnviarNovedades_PRONTO
    '      Case 6
    '         ImportarNovedades_PRONTO
    '      Case 7
    '         GenerarNovedades_Presto
    '   End Select

End Sub

Private Sub mnuViewA_Click(Index As Integer)

    Select Case Index

        Case 0
            CambiarVista lvwIcon

        Case 1
            CambiarVista lvwSmallIcon

        Case 2
            CambiarVista lvwList

        Case 3
            CambiarVista lvwReport
    End Select
   
End Sub

Private Sub mnuTestEtiquetador_Click()

    Dim oF As New frmEtiquetas
        
    oF.Init 0, 0, 0, 0, 0, 0, 0, 0
    oF.HabilitarTodosLosControles
    
    oF.Show vbModal
End Sub

Private Sub Split_MouseMove(Button As Integer, _
                            Shift As Integer, _
                            X As Single, _
                            Y As Single)

    If Button = vbLeftButton Then

        With Split
            .Move .left + X
        End With

    End If

End Sub

Private Sub Split_MouseUp(Button As Integer, _
                          Shift As Integer, _
                          X As Single, _
                          Y As Single)

    If Button = vbLeftButton Then
        Ajustar
    End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
 
    'On Error Resume Next
   
    Dim mHojasAncho As Integer
    Dim of1 As Form
   
    Select Case Button.Key
      
        Case "New"
        
            Editar -1
      
        Case "Save"
         
            ExportarAExcel Lista, "Listado de " & Ultimo_NodoTitulo
         
        Case "Print"
         
            ImprimirConExcel Lista, "Listado de " & Ultimo_NodoTitulo
      
        Case "Copy"
         
            CopiarAlClipboard

        Case "Find"
         
            FiltradoLista Lista
            StatusBar1.Panels(3).Text = " " & Lista.ListItems.Count & " elementos en la lista"
         
        Case "Sumar"
         
            StatusBar1.Panels(3).Text = " " & TotalizarCampo(Lista)
         
        Case "Calculadora"
   
            Call ShellExecute(Me.hwnd, "open", "Calc.exe", vbNullString, vbNullString, SW_SHOWNORMAL)
      
        Case "Nuevo Parte"
            
            NuevoParte
            
        Case "Nueva Orden"
            cmdCrearOP_Click (0)
        Case "View Large Icons"
         
            CambiarVista lvwIcon
      
        Case "View Small Icons"
         
            CambiarVista lvwSmallIcon
      
        Case "View List"
         
            CambiarVista lvwList
      
        Case "View Details"
         
            CambiarVista lvwReport
      
        Case "Help"
         
            VerAyuda
         
            'Case "CopiarCampo"
            '
            '         Set of1 = New frmCopiaDefArt
            '
            '         With of1
            '            .Grupo = Trim(Lista.SelectedItem.Text) & " " & Trim(Lista.SelectedItem.ListSubItems(1)) & " " & Trim(Lista.SelectedItem.ListSubItems(2))
            '            .NombreCampo = Lista.SelectedItem.ListSubItems(5)
            '            .Id = Lista.SelectedItem.Tag
            '            .Show vbModal, Me
            '         End With
            '
            '         Unload of1

            '        Set of1 = Nothing
   
        Case "ActMat"
         
            MsgBox "Modulo desactivado", vbExclamation
            Exit Sub
            '         Dim oRs As ADOR.Recordset
            '         Set oRs = Aplicacion.Articulos.TraerFiltrado("_ParaMenu")
            '         GrabarMenu oRs
            '         oRs.Close
            '         Set oRs = Nothing
            '
            '         Dim ofBusca As frmBuscarArticulo
            '         Set ofBusca = New frmBuscarArticulo
            '         ofBusca.Show vbModal, Me
            '         Unload ofBusca
            '         Set ofBusca = Nothing
   
        Case "Refrescar"
         
            Refrescar
   
        Case "Parametros"
         
            If Not glbAdministrador Then
                MsgBox "Solo el administrador del sistema puede acceder a los parametros!", vbExclamation
                Exit Sub
            End If
      
            mIdiomaInicial = glbIdiomaActual
      
            Set of1 = New frmParametros1

            With of1
                .Id = 1
                .Show vbModal, Me
            End With

            Unload of1
            Set of1 = Nothing
      
            SetearIdioma mIdiomaInicial
      
            'Case "Empresa"
            '
            '   If Not glbAdministrador Then
            '      MsgBox "Solo el administrador del sistema puede acceder a los datos de " & glbEmpresaSegunString & "!", vbExclamation
            '      Exit Sub
            '   End If
            '
            '   Set of1 = New frmEmpresa
            '   With of1
            '      .Caption = "Datos de " & glbEmpresa
            '      .Id = 1
            '      .Show vbModal, Me
            '   End With
            '   Unload of1
            '   Set of1 = Nothing
      
            'Case "EnviarMensaje"

            '   Set of1 = New frmMensajes
            '   With of1
            '      .Show , Me
            '   End With
            '   Set of1 = Nothing
      
            '      Case "EstadoObra"
            '
            '         If Not glbAdministrador Then
            '            MsgBox "Solo un administrador del sistema puede acceder a esta opcion!", vbExclamation
            '            Exit Sub
            '         End If
            '
            '         ProcesarPedidosEstadoObras
   
        Case "MenuPopUp"

            '         If Not glbMenuPopUpCargado Then
            '            Set of1 = New frmInformacion
            '            With of1
            '               .Label1.Caption = "CARGANDO DESPLEGABLE DE MATERIALES"
            '               .Label2.Caption = "Un momento por favor ..."
            '               .Show , Me
            '               DoEvents
            '               LoadMenuPopUp
            '            End With
            '            Unload of1
            '            Set of1 = Nothing
            '            glbMenuPopUpCargado = True
            '            Toolbar1.Buttons("MenuPopUp").Enabled = False
            '         End If
         
            'If Not glbMenuPopUpCargado1 Then
            '   Set of1 = New frmInformacion
            '   With of1
            '      .Label1.Caption = "CARGANDO DESPLEGABLE DE MATERIALES"
            '      .Label2.Caption = "Un momento por favor ..."
            '      .Show , Me
            '      DoEvents
            '      ActivarPopupMateriales
            '   End With
            '   Unload of1
            '   Set of1 = Nothing
            '   glbMenuPopUpCargado1 = True
            '   Toolbar1.Buttons("MenuPopUp").Enabled = False
            'End If
         
        Case "AccesoPorUsuarios"
         
            If glbAdministrador Then
                If Lista.Picture Is Nothing Then
                    Set Lista.Picture = picBackgroundArbol.Picture
                    glbModoAccesosUsuarios = True
                Else
                    Set Lista.Picture = Nothing
                    glbModoAccesosUsuarios = False
                End If
            End If
         
            'Case "Idioma"
            'ElegirIdioma

    End Select

End Sub

Private Sub Toolbar1_MouseDown(Button As Integer, _
                               Shift As Integer, _
                               X As Single, _
                               Y As Single)

    If Button = vbRightButton Then
        If glbMenuPopUpCargado1 Then
            Dim iIndex As Long
            cPMenu.Restore "Materiales"
            iIndex = cPMenu.ShowPopupMenu(Me.left, Me.top)
        End If
    End If

End Sub

Sub Ajustar()

    Dim Arriba As Long
    Dim Altura As Long
    Dim Ancho As Long
   
    Arriba = Toolbar1.Height
    Ancho = Me.ScaleWidth
    Altura = Me.ScaleHeight - Arriba - StatusBar1.Height
   
    On Error Resume Next
   
    With Split
        .top = Arriba
        .Height = Altura
    End With
      
    With Arbol
        .left = 0
        .top = Arriba
        .Height = Altura - IIf(cmdCrearOP(0).Visible, cmdCrearOP(0).Height, 0) - IIf(cmdNuevoParte.Visible, cmdNuevoParte.Height, 0)
        .Width = Split.left
    End With

    cmdCrearOP(0).top = Arbol.top + Arbol.Height
    cmdNuevoParte.top = cmdCrearOP(0).top + cmdCrearOP(0).Height
   
    With Lista
        .top = Arriba
        .Height = Altura
        .left = Split.left + Split.Width
        .Width = Ancho - .left
    End With

    With Frame1
        .top = Arriba
        .Height = Altura
        .left = Split.left + Split.Width
        .Width = Ancho - .left
      
        .Visible = False
    End With

End Sub

Private Sub Editar(ByVal Identificador As Long, _
                   Optional ByVal IdentificadorAnterior As Long)

    'On Error Resume Next
   
    Dim oF As Form
    Dim s As String, clave As String, Clave1 As String
    Dim mIdentificadorAnterior As Long
    Dim nodo As Object
    Dim mClaveNodo
    Dim Columnas, SubClave
    Dim oRs As ADOR.Recordset
      
    Me.MousePointer = vbHourglass
   
    mClaveNodo = VBA.Split(Arbol.SelectedItem.Key, " ")
   
    s = Arbol.SelectedItem.Key

    Do Until Len(s) And mId(s, 1, 1) <> "-" 'Mientras no empiece con -Sub (es un subarbol del nodo)
        s = Arbol.SelectedItem.Parent.Key
    Loop
   
    If mId(s, 1, 1) = "+" Then
        s = mId(s, 1, 7)
    End If
   
    Set nodo = Arbol.SelectedItem
    clave = nodo.Key
    Clave1 = ""

    Do Until Len(clave) And mId(clave, 1, 1) <> "-" And mId(clave, 1, 1) <> "+"

        If InStr(1, clave, "SubCn2") <> 0 Then
            Clave1 = clave
        End If

        Set nodo = nodo.Parent
        clave = nodo.Key
    Loop

    Set nodo = Nothing

    If clave = "PresupuestoEconomico" And glbAdministrador And BuscarClaveINI("Activar control de acceso por item-usuario") = "SI" Then
        clave = Arbol.SelectedItem.Key
    End If

    'MARIANO : OTRO CONTROL SALTADO
    'If Not ControlAcceso(clave) Or ControlAccesoNivel(clave) >= 9 Then
    '   MsgBox "El usuario no tiene acceso a esta informacion", vbCritical
    '   GoTo Salida:
    'End If
   
    Select Case s
      
        Case "ArticulosTodosDetallados"
            Set oF = New frmArticulosTipo
      
        Case "Maquinas"
            Set oF = New frmProduccionMaquina
      
        Case "Area"
            Set oF = New frmProduccionArea

        Case "Sector"
            Set oF = New frmProduccionSector

        Case "Linea"
            Set oF = New frmProduccionLinea

        Case "Procesos"
            Set oF = New frmProduccionProceso
      
        Case "ControlCalidad"
            Set oF = New frmTipoControlCalidad

        Case "Maquinas"
            'Set oF = New frmProduccionMaquina
      
        Case "Ingenieria"
            Set oF = New frmProduccionFicha
      
        Case "FichaTecnica", "FichasActivas", "FichasInactivas"
            Set oF = New frmProduccionFicha
      
        Case "OrdendeProduccion", "OrdendeProduccionAgrupadas", "OrdendeProduccionTodas", "OrdendeProduccionPorProceso", "+SubOP1", "+SubOP2", "+SubOX1"
            Set oF = New frmProduccionOrden
      
        Case "OrdenesCompraTodas"
            Set oF = New frmOrdenesCompra
      
        Case "SalidaMateriales", "SalidaMaterialesTodas", "SalidaMaterialesAgrupadas", "+SubSA1", "+SubSA2"
            'Set oF = New frmSalidasMateriales
         
        Case "PartedeProduccion", "PartesAgrupadas", "PartesTodas", "PartedeProduccionPorProceso", "+SubPa1", "+SubPa2", "+SubPP1"
            Set oF = New frmProduccionParte
      
        Case "PlanificaciondeMateriales"
            Set oF = New frmPlanificacionMateriales

            'With oF
            '   .Show , Me
            'End With
        Case "ProgramaciondeRecursos"
            Set oF = New frmProgRecursos
            'With oF
            '   .Show , Me
            'End With
      
        Case Else
            MsgBox "Item no editable"
            GoTo Salida:
    End Select
   
   
   
   
    With oF
        .NivelAcceso = ControlAccesoNivel(clave)
        .OpcionesAcceso = ControlAccesoOpciones(clave)
        .Id = Identificador

        If Not glbPermitirModificacionTabulados Then
            If ExisteControlEnFormulario(oF, "lblTabIndex") Then
                .lblTabIndex.Visible = False
            End If
        End If

        .Disparar = ActL
        ReemplazarEtiquetas oF
        Me.MousePointer = vbDefault

        If s = "Maquinas" And Identificador = -1 Then Exit Sub
        If (s = "PartedeProduccion" Or s = "PartesAgrupadas" Or s = "PartesTodas" Or s = "PartedeProduccionPorProceso" Or s = "+SubPa1" Or s = "+SubPa2" Or s = "+SubPP1") And Identificador = -1 Then
            If Not oF.mhabilitado Then
                Unload oF
                Set oF = Nothing
                Exit Sub
            End If
        End If

        .Show , Me
    End With

Salida:

    'Unload oF
    Set oF = Nothing
    Set oRs = Nothing
   
    Me.MousePointer = vbDefault

End Sub

Public Sub ActualizarLista(ByVal Identificador As Long, _
                           ByVal TipoAccion As EnumAcciones, _
                           ByVal NombreListaEditada As String, _
                           Optional ByVal IdentificadorOriginal As Long)

    Dim oRs As ADOR.Recordset, oRsAux As ADOR.Recordset
    Dim oFld As ADOR.Field
    Dim s As String, mIcono As String, sKey As String
    Dim Columnas
    Dim i As Integer, X As Integer
    Dim mUno As Boolean, mEdicionEnSerie As Boolean
    Dim mFecha As Date, mFechaDesde As Date, mFechaHasta As Date
   
    On Error Resume Next
   
    If TipoAccion = baja Then
        Lista.ListItems.Remove (Lista.object.SelectedItem.Index)
        Exit Sub
    End If
   
    '   s = NombreListaEditada
    '   Do Until Len(s) And Not mId(s, 1, 1) = "-"
    '      s = Arbol.SelectedItem.Parent.Key
    '   Loop
   
    s = Arbol.SelectedItem.Key

    If mId(s, 1, 1) = "+" Then
        s = mId(s, 1, 7)
    End If
   
    'If Not InStr(1, NombreListaEditada, s) <> 0 Then
    '   'Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index) $$$ modificar el truquito
    '   Exit Sub
    'End If
   
    mUno = True
    mEdicionEnSerie = False
   
    Select Case s
      
        Case "Area"
            Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index)

            'Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionAreas", Identificador)
        Case "Sector"
            Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index)

            'Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionSectores", Identificador)
        Case "Linea"
            Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index)

            'Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionLineas", Identificador)
        Case "Procesos"
            Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index)

            'Set oRs = AplicacionProd.procesos.TraerFiltrado("_TT", Identificador)
        Case "PartedeProduccion", "PartesAgrupadas", "+SubPa1", "+SubPa2", "PartedeProduccionPorProceso", "+SubPP1", "PartedeProduccionCompra", "PartesTodas"
            Set oRs = AplicacionProd.ProduccionPartes.TraerFiltrado("_TT", Identificador)

        Case "PlanificaciondeMateriales"
            'Set oRs = AplicacionProd.Planes.TraerFiltrado("_TT", Identificador)
            'Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionPlanes", Identificador)
            Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index)

        Case "ProgramaciondeRecursos"
            'Set oRs = AplicacionProd.ProgRecursos.TraerFiltrado("_TT", Identificador)
            'Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionProgRecursos", Identificador)
            Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index)

        Case "FichaTecnica", "Ingenieria"
            Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index) 'hay que actualizar la lista entera porque puede cambiar el estado de "ACTIVO" de varias al cambiar una sola

            'Set oRs = AplicacionProd.ProduccionFichas.TraerFiltrado("_TT", Identificador)
        Case "OrdendeProduccion", "OrdenesProduccionCompra", "OrdendeProduccionTodas", "OrdendeProduccionAgrupadas", "+SubOP1", "+SubOP2", "OrdendeProduccionPorProceso", "+SubOX1"
            Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_TT", Identificador)

        Case "Empleados", "Empleados1", "Empleados2", "Empleados3"

            '//////////////////////////////////////////////////////
        Case "MateriaPrimaStock"
            Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index)

        Case "MateriaPrima"
            Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index)

        Case "Semielaborado"
            Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index)

        Case "Terminado"
            Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index)

        Case "Subproducto"
            Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index)

        Case "Maquinas"
            Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index)

        Case "ManodeObra"
            Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index)

        Case "ControlCalidad"
            Arbol_NodeClick Arbol.Nodes(Arbol.SelectedItem.Index)
      
        Case Else
            '         MsgBox "No implementado en esta versión"
            Exit Sub
    End Select
   
    Lista.UltimaAccion = TipoAccion
   
    If Not oRs Is Nothing Then
        If oRs.RecordCount > 0 Then
            If mUno Then
                Set Lista.RecordSource = oRs
            Else
                Set Lista.DataSource = oRs
                Lista.IconoGrande = mIcono
                Lista.IconoPequeño = mIcono
            End If
        End If
    End If
   
    If Len(mIdiomaInicial) > 0 Then CambiarLenguaje Me, mIdiomaInicial, glbIdiomaActual, ""

Salida:

    Set oRs = Nothing
   
    If IdentificadorOriginal = -1 And glbCargaEnSerie And mEdicionEnSerie Then
        Editar -1, Identificador
    End If

End Sub

Public Sub ImprimeProveedores(ByVal TipoSalida As String)

    Dim oW As Word.Application
    Dim oRs As ADOR.Recordset
    Dim oL As ListItem
    Dim i As Integer
   
    Me.MousePointer = vbHourglass
      
    Set oW = CreateObject("Word.Application")
   
    With oW
      
        .Visible = True
      
        With .Documents.Add(glbPathPlantillas & "\Proveedores.dot")
   
            oW.Selection.HomeKey Unit:=wdStory
            oW.Selection.MoveDown Unit:=wdLine, Count:=5
            oW.Selection.MoveLeft Unit:=wdCell, Count:=1
          
            For Each oL In Lista.ListItems
                  
                Set oRs = Aplicacion.Proveedores.TraerFiltrado("_TT", oL.Tag)
         
                With oRs

                    Do Until .EOF
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Razon social").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Nombre de fantasia").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Direccion").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Localidad").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Cod.postal").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Provincia").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Pais").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Telefono").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Telef.adic.").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Fax").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Cuit").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Condicion IVA").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Email").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Contacto").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Actividad principal").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Cond. de compra").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Estado").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Fecha de alta").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields("Habitual").Value
                        .MoveNext
                    Loop

                End With
            
            Next
          
            'Registro de numero de paginas, fecha y hora
            oW.Application.Run MacroName:="DatosDelPie"
          
            oRs.Close
            Set oRs = Nothing
          
            If TipoSalida = "I" Then
                oW.ActiveDocument.PrintOut False
                .Close False
            End If
      
        End With
      
        If TipoSalida = "I" Then .Quit
      
    End With
   
    Set oW = Nothing

    Me.MousePointer = vbDefault
      
End Sub

Public Sub CargarPermisos()

    Dim oRs As ADOR.Recordset
    Dim i As Integer
   
    If glbIdUsuario > 0 Then
        Set oRs = Aplicacion.Empleados.TraerFiltrado("_PorEmpleado", glbIdUsuario)

        With oRs

            If .RecordCount > 0 Then
                i = 0
                .MoveFirst

                Do While Not .EOF
                    Accesos(i, 0) = .Fields("Nodo").Value

                    If .Fields("Acceso").Value Then
                        Accesos(i, 1) = "Ok"
                    Else
                        Accesos(i, 1) = ""
                    End If

                    If Not IsNull(.Fields("Nivel").Value) Then
                        Accesos(i, 2) = "" & .Fields("Nivel").Value
                    Else
                        Accesos(i, 2) = "0"
                    End If

If FileExists("Debug.bat") Then
 Accesos(i, 2) = "9"
End If

                    If Not IsNull(.Fields("FechaDesdeParaModificacion").Value) Then
                        Accesos(i, 3) = "" & .Fields("FechaInicialHabilitacion").Value & "|" & .Fields("FechaFinalHabilitacion").Value & "|" & .Fields("FechaDesdeParaModificacion").Value & "|"

                        If Not IsNull(.Fields("CantidadAccesos").Value) Then
                            Accesos(i, 3) = Accesos(i, 3) & .Fields("CantidadAccesos").Value
                        End If

                    Else
                        Accesos(i, 3) = ""
                    End If

                    i = i + 1
                    .MoveNext
                Loop

            End If

            .Close
        End With




        Set oRs = Nothing
    End If

End Sub

Public Function ControlAcceso(clave As String) As Boolean

    Dim i As Integer
   
    For i = 0 To UBound(Accesos)

        If Accesos(i, 0) = clave Then
            If Accesos(i, 1) = "Ok" Then
                ControlAcceso = True
            Else
                ControlAcceso = False
            End If

            Exit Function
        End If

    Next

    ControlAcceso = False

End Function

Public Function ControlAccesoNivel(clave As String) As Integer

    Dim i As Integer
   
    For i = 0 To UBound(Accesos)

        If Accesos(i, 0) = clave Then
            If Accesos(i, 1) = "Ok" Then
                ControlAccesoNivel = Accesos(i, 2)
                Exit Function
            Else
                Exit For
            End If
        End If

    Next

    ControlAccesoNivel = 10

End Function

Public Function ControlAccesoNivelExistente(clave As String) As Boolean

    Dim mExiste As Boolean
    Dim i As Integer
   
    mExiste = False

    For i = 0 To UBound(Accesos)

        If Accesos(i, 0) = clave Then
            mExiste = True
            Exit For
        End If

    Next

    ControlAccesoNivelExistente = mExiste

End Function

Public Function ControlAccesoOpciones(clave As String) As String

    Dim i As Integer
   
    For i = 0 To UBound(Accesos)

        If Accesos(i, 0) = clave Then
            If Accesos(i, 1) = "Ok" Then
                ControlAccesoOpciones = Accesos(i, 3)
                Exit Function
            Else
                Exit For
            End If
        End If

    Next

    ControlAccesoOpciones = ""

End Function

Public Sub ImprimirConExcelDesdeRs(ByVal oRs As ADOR.Recordset, _
                                   ByVal Titulo As String)

    Dim s As String
    Dim i As Integer, fl As Integer, cl As Integer
    Dim oEx As Excel.Application
   
    Set oEx = CreateObject("Excel.Application")
   
    With oEx
      
        .Visible = True
      
        With .Workbooks.Add(glbPathPlantillas & "\Planilla.xlt")
         
            With .ActiveSheet

                .Name = Titulo
            
                For i = 1 To oRs.Fields.Count - 1
                    .Cells(1, i) = oRs.Fields(i).Name
                Next

                If oRs.RecordCount > 0 Then
                    fl = 2
                    oRs.MoveFirst

                    Do While Not oRs.EOF

                        For i = 1 To oRs.Fields.Count - 1

                            If Not IsNull(oRs.Fields(i).Value) Then
                                If oRs.Fields(i).type = adLongVarChar Or oRs.Fields(i).type = adLongVarWChar Then
                                    RichTextBox1.TextRTF = oRs.Fields(i).Value
                                    .Cells(fl, i) = RichTextBox1.Text
                                Else
                                    .Cells(fl, i) = oRs.Fields(i).Value
                                End If

                            Else
                                .Cells(fl, i) = " "
                            End If

                        Next

                        fl = fl + 1
                        oRs.MoveNext
                    Loop

                End If
               
                .Range("A1").Select

            End With
         
            oEx.Run "ArmarFormato"
      
        End With
      
    End With
   
    Set oEx = Nothing

End Sub

Public Sub CopiarAlClipboard()

    Dim s1 As String
    s1 = Lista.GetString

    If Len(s1) Then

        With Clipboard
            .Clear
            .SetText s1
        End With

    End If

End Sub

Public Sub Refrescar()

    Dim nodo As Node
    Dim mvarBorrado As Boolean
    Dim oRs As ADOR.Recordset

    Arbol.Nodes(1).Selected = True
    Lista.ListItems.Clear
   
    Do While True
        mvarBorrado = False

        For Each nodo In Arbol.Nodes

            If mId(nodo.Key, 1, 1) = "+" Then
                Arbol.Nodes.Remove nodo.Key
                mvarBorrado = True
                Exit For
            End If

        Next

        If Not mvarBorrado Then
            Exit Do
        End If

    Loop
   
    Set oRs = Aplicacion.Articulos.TraerFiltrado("_ParaMenu")
    GrabarMenu oRs
    oRs.Close
    Set oRs = Nothing

End Sub

Public Sub VerNovedadesEventos()

    'If Aplicacion.Empleados.TieneNovedades(glbIdUsuario) Then
    '   Dim oF As frmNovedadesUsuario
    '   Set oF = New frmNovedadesUsuario
    '   oF.Show vbModal, Me
    '   VerNovedades = False
    'End If

End Sub

Public Sub VerAyuda()

    Call ShellExecute(Me.hwnd, "open", glbPathPlantillas & "\BDLProntoManual.htm", vbNullString, vbNullString, SW_SHOWNORMAL)

End Sub

Public Sub ProcesarPedidosEstadoObras()

    Dim goMailOL As CEmailOL
    Dim oF As frmInformacion
    Dim lStatus, i As Long
    Dim mLista As String, mSubject As String, mBody As String, mAttachment As String
    Dim mInforme As String, mCodigoObra As String
    Dim mDatos1() As String
    Dim mDatos2() As String
   
    On Error GoTo Salida
   
    Set oF = New frmInformacion
    oF.Label1.Caption = "PROCESAMIENTO DE PEDIDOS DE ESTADO DE OBRAS"
    oF.Show , Me
   
    mInforme = app.Path & "\EstadoObras.xls"
   
    Set goMailOL = New CEmailOL
    lStatus = goMailOL.LeerPedidosEstadoObras(oF)
   
    If Len(goMailOL.RespuestasOK) Then
        mDatos1 = VBA.Split(goMailOL.RespuestasOK, "|")

        For i = 0 To UBound(mDatos1)
            mDatos2 = VBA.Split(mDatos1(i), "*")
            mCodigoObra = Trim(mId(mDatos2(0), 15, 100))
            GenerarInformeEstadoObra mCodigoObra, 2

            If Len(Trim(Dir(mInforme))) <> 0 Then
                mAttachment = mInforme
                mLista = mDatos2(1)
                mSubject = "RE: " & mDatos2(0)
                mBody = "" & vbCrLf & vbCrLf & "     Informe estado de obra : " & mCodigoObra & vbCrLf
                lStatus = goMailOL.Send(mLista, True, mSubject, mBody, mAttachment)
                Kill mInforme

                If lStatus <> 0 Then
                    MsgBox "No se pudo generar el informe de la obra " & mCodigoObra & " pedido por " & mDatos2(1), vbCritical
                End If

            Else
                MsgBox "No se pudo generar el informe de la obra " & mCodigoObra & " pedido por " & mDatos2(1), vbCritical
            End If

        Next

    End If
   
Salida:
   
    Unload oF
    Set oF = Nothing
   
    Set goMailOL = Nothing
   
End Sub

Public Sub GenerarInformeEstadoObra(ByVal CodigoObra As String, _
                                    ByVal TipoSalida As Integer)

    Dim oAp As ComPronto.Aplicacion
    Dim s As String
    Dim fl As Integer, cl As Integer
    Dim mIdObra As Long, mReq As Long, mAco As Long, i As Long
    Dim oEx As Excel.Application
    Dim oRs As ADOR.Recordset
    Dim oRsPed As ADOR.Recordset
    Dim oRsRec As ADOR.Recordset
    Dim oRsFac As ADOR.Recordset
   
    On Error GoTo Salida
   
    Set oRs = Aplicacion.Obras.TraerFiltrado("_PorNumero", CodigoObra)
   
    If oRs.RecordCount = 0 Then
        GoTo Salida
    End If
   
    mReq = -1
    mAco = -1
    mIdObra = oRs.Fields(0).Value
    oRs.Close
         
    Set oAp = Aplicacion
    oAp.Tarea ("Obras_GenerarEstado")
    Set oRs = oAp.Obras.TraerFiltrado("_EstadoObras", Array(mIdObra, mReq, mAco))
         
    Set oEx = CreateObject("Excel.Application")
   
    With oEx
      
        .Visible = True
      
        With .Workbooks.Add(glbPathPlantillas & "\EstadoObras.xlt")
         
            With .ActiveSheet

                fl = 6
            
                If oRs.RecordCount > 0 Then
               
                    oRs.MoveFirst

                    Do While Not oRs.EOF
               
                        s = ""

                        If Not IsNull(oRs.Fields("Observaciones").Value) Then
                            RichTextBox1.TextRTF = oRs.Fields("Observaciones").Value
                            s = RichTextBox1.Text
                            s = Replace(s, Chr(13) + Chr(10) + Chr(13) + Chr(10), "")
                        End If
         
                        .Cells(fl, 1) = oRs.Fields("Comprobante").Value
                        .Cells(fl, 2) = oRs.Fields("Numero").Value
                        .Cells(fl, 3) = CDate(oRs.Fields("Fecha").Value)

                        If Not IsNull(oRs.Fields("Emisor").Value) Then .Cells(fl, 4) = oRs.Fields("Emisor").Value
                        If Not IsNull(oRs.Fields("Item").Value) Then .Cells(fl, 5) = oRs.Fields("Item").Value
                        If Not IsNull(oRs.Fields("Fecha nec.").Value) Then .Cells(fl, 6) = CDate(oRs.Fields("Fecha nec.").Value)
                        If Not IsNull(oRs.Fields("Fecha ult.firma").Value) Then .Cells(fl, 7) = CDate(oRs.Fields("Fecha ult.firma").Value)
                        If Not IsNull(oRs.Fields("Articulo").Value) Then .Cells(fl, 8) = oRs.Fields("Articulo").Value
                        .Cells(fl, 9) = s

                        If Not IsNull(oRs.Fields("Cantidad").Value) Then .Cells(fl, 10) = oRs.Fields("Cantidad").Value
                        If Not IsNull(oRs.Fields("Unidad en").Value) Then .Cells(fl, 11) = oRs.Fields("Unidad en").Value
                        If Not IsNull(oRs.Fields("Med.1").Value) Then .Cells(fl, 12) = oRs.Fields("Med.1").Value
                        If Not IsNull(oRs.Fields("Med.2").Value) Then .Cells(fl, 13) = oRs.Fields("Med.2").Value
                        If Not IsNull(oRs.Fields("Cant.Ped.").Value) Then .Cells(fl, 14) = oRs.Fields("Cant.Ped.").Value
                        If Not IsNull(oRs.Fields("Cant.Rec.").Value) Then .Cells(fl, 15) = oRs.Fields("Cant.Rec.").Value
                        If Not IsNull(oRs.Fields("Cant.Fac.").Value) Then .Cells(fl, 16) = oRs.Fields("Cant.Fac.").Value
                  
                        If oRs.Fields("Comprobante").Value = "R.M." Then
                            Set oRsPed = oAp.Obras.TraerFiltrado("_EstadoObras_DetallePedidosDesdeRM", oRs.Fields("Id").Value)
                            Set oRsRec = oAp.Obras.TraerFiltrado("_EstadoObras_DetalleRecepcionesDesdeRM", oRs.Fields("Id").Value)
                            Set oRsFac = oAp.Obras.TraerFiltrado("_EstadoObras_DetalleFacturasAsignadas", Array(EnumFormularios.RequerimientoMateriales, oRs.Fields("Id").Value))
                        Else
                            Set oRsPed = oAp.Obras.TraerFiltrado("_EstadoObras_DetallePedidosDesdeAcopio", oRs.Fields("Id").Value)
                            Set oRsRec = oAp.Obras.TraerFiltrado("_EstadoObras_DetalleRecepcionesDesdeAcopio", oRs.Fields("Id").Value)
                            Set oRsFac = oAp.Obras.TraerFiltrado("_EstadoObras_DetalleFacturasAsignadas", Array(EnumFormularios.ListaAcopio, oRs.Fields("Id").Value))
                        End If
                  
                        If Not (oRsPed.EOF And oRsRec.EOF And oRsFac.EOF) Then

                            Do While Not (oRsPed.EOF And oRsRec.EOF And oRsFac.EOF)

                                If Not oRsPed.EOF Then
                                    .Cells(fl, 18) = "Ped."
                                    .Cells(fl, 19) = oRsPed.Fields("Pedido").Value
                                    .Cells(fl, 20) = oRsPed.Fields("Fecha").Value
                                    .Cells(fl, 21) = oRsPed.Fields("Comprador").Value
                                    .Cells(fl, 22) = oRsPed.Fields("Proveedor").Value
                                    .Cells(fl, 23) = oRsPed.Fields("Importe s/iva").Value
                                    .Cells(fl, 24) = oRsPed.Fields("F.entrega").Value
                                    .Cells(fl, 25) = ""
                                    oRsPed.MoveNext
                                End If

                                If Not oRsRec.EOF Then
                                    .Cells(fl, 27) = "Rec."
                                    .Cells(fl, 28) = oRsRec.Fields("NumeroRecepcionAlmacen").Value
                                    .Cells(fl, 29) = oRsRec.Fields("Recepcion").Value
                                    .Cells(fl, 30) = oRsRec.Fields("Fecha").Value
                                    .Cells(fl, 31) = oRsRec.Fields("Cantidad").Value
                                    .Cells(fl, 32) = oRsRec.Fields("Unid.").Value
                                    oRsRec.MoveNext
                                ElseIf Not oRsFac.EOF Then
                                    .Cells(fl, 27) = "Fac."
                                    .Cells(fl, 28) = ""
                                    .Cells(fl, 29) = oRsFac.Fields("Nro.factura").Value
                                    .Cells(fl, 30) = oRsFac.Fields("Fecha fac.").Value
                                    .Cells(fl, 31) = ""
                                    .Cells(fl, 32) = ""
                                    oRsFac.MoveNext
                                End If

                                fl = fl + 1
                            Loop

                        Else
                            fl = fl + 1
                        End If
                  
                        oRsPed.Close
                        oRsRec.Close
                        oRsFac.Close
            
                        oRs.MoveNext
                  
                    Loop
               
                End If
                  
            End With
         
            '         oEx.Run "ArmarInforme", Lista
            If TipoSalida = 2 Then
                .SaveAs app.Path & "\EstadoObras.xls"
                .Close False
            End If
      
        End With
      
        If TipoSalida = 2 Then .Quit
   
    End With
   
Salida:

    Set oRs = Nothing
    Set oRsPed = Nothing
    Set oRsRec = Nothing
    Set oRsFac = Nothing
    Set oAp = Nothing
    Set oEx = Nothing

End Sub

Public Function ArmarPlanDeCuentas(ByVal mCodigo As Integer) As ADOR.Recordset

    Dim oRs As ADOR.Recordset
    Dim i As Integer, mMargen As Integer
    Dim mControl(5) As String
    Dim mVector

    If BuscarClaveINI("Permitir multiplan de cuentas") = "SI" Then
        Dim oF As frm_Aux
        Dim mOk As Boolean
        Dim mFecha As Date
        Set oF = New frm_Aux

        With oF
            .Label2(0).Caption = "Fecha consulta :"
            .Label2(0).Visible = True
            .DTFields(0).Value = Date
            .DTFields(0).Visible = True
            .Label1.Visible = False
            .text1.Visible = False
            .cmd(0).top = .DTFields(0).top + .DTFields(0).Height + 100
            .cmd(1).top = .cmd(0).top
            .Height = .Height * 0.6
            .Show vbModal, Me
            mOk = .Ok
            mFecha = .DTFields(0).Value
        End With

        Unload oF
        Set oF = Nothing

        If mOk Then
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorJerarquia", Array(mCodigo, mFecha))
        Else
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorJerarquia", mCodigo)
        End If

    Else
        Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorJerarquia", mCodigo)
    End If
   
    With oRs

        If .RecordCount > 0 Then
            .MoveFirst
            mVector = VBA.Split(IIf(IsNull(.Fields("Jerarquia").Value), "0.0.00.00.000", .Fields("Jerarquia").Value), ".")

            For i = 0 To 4: mControl(i) = mVector(i): Next
            mMargen = 0

            Do While Not .EOF
                mVector = VBA.Split(IIf(IsNull(.Fields("Jerarquia").Value), "0.0.00.00.000", .Fields("Jerarquia").Value), ".")

                For i = 0 To 4

                    If i <= UBound(mVector) Then
                        If mControl(i) <> mVector(i) Then
                            mControl(i) = mVector(i)

                            If Len(mVector(i)) = 0 Then
                                mMargen = 0
                            Else

                                If CInt(mVector(i)) <> 0 Then mMargen = i * 5
                            End If
                        End If

                    Else
                        mMargen = 0
                    End If

                Next

                .Fields("Descripcion").Value = VBA.mId(Space(mMargen) & .Fields("Descripcion").Value, 1, 100)
                .Update
                .MoveNext
            Loop

            .MoveFirst
        End If

    End With
   
    Set ArmarPlanDeCuentas = oRs
   
    Set oRs = Nothing
   
End Function

Public Sub GenerarDiferenciasCambio(ByRef Lista As DbListView)

    Dim oAp As ComPronto.Aplicacion
    Dim oDif As ComPronto.DiferenciaCambio
    Dim oPar As ComPronto.Parametro
    Dim oComp As ComPronto.ComprobanteProveedor
    Dim iFilas As Integer
    Dim mNum As Long
    Dim Filas
    Dim Columnas
         
    Set oAp = Aplicacion
            
    Filas = VBA.Split(Lista.GetString, vbCrLf)
   
    For iFilas = LBound(Filas) + 1 To UBound(Filas)
      
        Columnas = VBA.Split(Filas(iFilas), vbTab)
      
        '      Set oPar = oAp.Parametros.Item(1)
        '      With oPar.Registro
        '         mNum = .Fields("ProximoComprobanteProveedorReferencia").Value
        '
        '         .Fields("ProximoComprobanteProveedorReferencia").Value = mNum + 1
        '      End With
        '      oPar.Guardar
        '      Set oPar = Nothing
            
        Set oDif = oAp.DiferenciasCambio.Item(Columnas(0))

        With oDif.Registro
            .Fields("Estado").Value = "SI"
      
        End With

        oDif.Guardar
        Set oDif = Nothing
   
    Next

    Set oAp = Nothing

End Sub

Public Sub CargarArbol()

    Dim oRs As ADOR.Recordset
    Dim mExisteProntoMantenimiento As Boolean
   
    Set oRs = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoExiste")
    mExisteProntoMantenimiento = False

    If oRs.RecordCount > 0 Then
        mExisteProntoMantenimiento = True
    End If

    oRs.Close
    Set oRs = Nothing
   
    ArbolDefault.Nodes.Clear
    Arbol.Nodes.Clear

    If Lista.ColumnHeaders.Count > 0 Then
        Lista.ListItems.Clear
        Lista.ColumnHeaders.Clear
    End If
   
    With ArbolDefault.Nodes
      
        .Add , , "Ppal", glbEmpresaSegunString, "Ppal", "Ppal"
        '///////////////////////////////////////////////////////
    
        
        .Add "Ppal", tvwChild, "Personal", "Personal", "Empleados", "Empleados"
        .Add "Personal", tvwChild, "Empleados", "Personal", "Empleados", "Empleados"
        .Add "Empleados", tvwChild, "Empleados2", "Usuarios", "Empleados", "Empleados"
        .Add "Empleados", tvwChild, "Empleados3", "Todos", "Empleados", "Empleados"
    
        .Add "Ppal", tvwChild, "Ingenieria", "Ingeniería", "Pedidos", "Pedidos"
        
        .Add "Ingenieria", tvwChild, "FichaTecnica", "Ficha Técnica", "Pedidos", "Pedidos"
        .Add "FichaTecnica", tvwChild, "FichasActivas", "Activas", "Pedidos", "Pedidos"
        .Add "FichaTecnica", tvwChild, "FichasInactivas", "Inactivas", "Pedidos", "Pedidos"
        
        .Add "Ingenieria", tvwChild, "Materiales", "Materiales", "SalidaMateriales", "SalidaMateriales"
        .Add "Materiales", tvwChild, "Insumos", "Insumo", "SalidaMateriales", "SalidaMateriales"
        .Add "Materiales", tvwChild, "MateriaPrima", "Materia Prima", "SalidaMateriales", "SalidaMateriales"
        .Add "Materiales", tvwChild, "Semielaborado", "Semielaborado", "SalidaMateriales", "SalidaMateriales"
        .Add "Materiales", tvwChild, "Terminado", "Terminado", "SalidaMateriales", "SalidaMateriales"
        .Add "Materiales", tvwChild, "Subproducto", "Subproducto", "SalidaMateriales", "SalidaMateriales"
        .Add "Materiales", tvwChild, "ArticulosTodosDetallados", "Todos", "SalidaMateriales", "SalidaMateriales"

        .Add "Ingenieria", tvwChild, "Recursos", "Recursos", "Articulos", "Articulos"
        .Add "Recursos", tvwChild, "Maquinas", "Máquinas", "Articulos", "Articulos"
        .Add "Recursos", tvwChild, "ManodeObra", "Mano de Obra", "Articulos", "Articulos"
        .Add "Recursos", tvwChild, "Area", "Area", "Articulos", "Articulos"
        .Add "Recursos", tvwChild, "Sector", "Sector", "Articulos", "Articulos"
        .Add "Recursos", tvwChild, "Linea", "Linea", "Articulos", "Articulos"
        .Add "Recursos", tvwChild, "Procesos", "Procesos", "Articulos", "Articulos"
        '.Add "Ingenieria", tvwChild, "ControlCalidad", "Control de Calidad", "SalidaMateriales", "SalidaMateriales"
    
        .Add "Ppal", tvwChild, "OrdendeProduccion", "Ordenes", "UnidadesOperativas", "UnidadesOperativas"
        .Add "OrdendeProduccion", tvwChild, "OrdendeProduccionAgrupadas", "Por periodos", "UnidadesOperativas", "UnidadesOperativas"
        .Add "OrdendeProduccion", tvwChild, "OrdendeProduccionPorProceso", "Por proceso", "UnidadesOperativas", "UnidadesOperativas"
        .Add "OrdendeProduccion", tvwChild, "OrdendeProduccionTodas", "Todas", "UnidadesOperativas", "UnidadesOperativas"
    
        .Add "Ppal", tvwChild, "PartedeProduccion", "Partes", "Empleados", "Empleados"
        .Add "PartedeProduccion", tvwChild, "PartesAgrupadas", "Por periodos", "Empleados", "Empleados"
        .Add "PartedeProduccion", tvwChild, "PartedeProduccionPorProceso", "Por proceso", "Empleados", "Empleados"
        .Add "PartedeProduccion", tvwChild, "PartesTodas", "Todas", "Empleados", "Empleados"
    
        .Add "Ppal", tvwChild, "PlanificaciondeMateriales", "MPS Plan Materiales", "SalidaMateriales", "SalidaMateriales"
    
        .Add "Ppal", tvwChild, "ProgramaciondeRecursos", "CRP Plan Recursos ", "Articulos", "Articulos"
        
        '.Add "Ppal", tvwChild, "OrdenesCompra", "Ordenes de compra", "OrdenesCompra", "OrdenesCompra"
        '    .Add "OrdenesCompra", tvwChild, "OrdenesCompraAgrupadas", "Ordenes de compra (Por periodos)", "OrdenesCompra", "OrdenesCompra"
        '    .Add "OrdenesCompra", tvwChild, "OrdenesCompraTodas", "Ordenes de compra (Todas)", "OrdenesCompra", "OrdenesCompra"
      
      
      If FileExists("Debug.bat") Then
            .Add "Ppal", tvwChild, "MovStock", "Movimientos de stock", "MovStock", "MovStock"

      .Add "MovStock", tvwChild, "SalidaMateriales", "Salida de materiales de almacen", "SalidaMateriales", "SalidaMateriales"
      .Add "SalidaMateriales", tvwChild, "SalidaMaterialesAgrupadas", "Salidas (Por periodos)", "SalidaMateriales", "SalidaMateriales"
      .Add "SalidaMateriales", tvwChild, "SalidaMaterialesTodas", "Salidas (Todas)", "SalidaMateriales", "SalidaMateriales"
      .Add "MovStock", tvwChild, "SalidaMateriales1", "Salida de materiales de almacen", "SalidaMateriales", "SalidaMateriales"
      .Add "SalidaMateriales1", tvwChild, "SalidaMaterialesAgrupadas1", "Salidas (Por periodos)", "SalidaMateriales", "SalidaMateriales"
      .Add "SalidaMateriales1", tvwChild, "SalidaMaterialesTodas1", "Salidas (Todas)", "SalidaMateriales", "SalidaMateriales"
      .Add "MovStock", tvwChild, "OtrosIngresosAlmacen", "Otros ingresos a almacen", "OtrosIngresosAlmacen", "OtrosIngresosAlmacen"
      .Add "OtrosIngresosAlmacen", tvwChild, "OtrosIngresosAlmacenAgrupados", "Otros ingresos (Por periodos)", "OtrosIngresosAlmacen", "OtrosIngresosAlmacen"
      .Add "OtrosIngresosAlmacen", tvwChild, "OtrosIngresosAlmacenTodos", "Otros ingresos (Todos)", "OtrosIngresosAlmacen", "OtrosIngresosAlmacen"
      .Add "MovStock", tvwChild, "UnidadesEmpaque", "Unidades de empaque", "UnidadesEmpaque", "UnidadesEmpaque"
      .Add "UnidadesEmpaque", tvwChild, "UnidadesEmpaqueAgrupados", "Unidades de empaque (Por periodos)", "UnidadesEmpaque", "UnidadesEmpaque"
      .Add "UnidadesEmpaque", tvwChild, "UnidadesEmpaqueTodos", "Unidades de empaque (Todas)", "UnidadesEmpaque", "UnidadesEmpaque"

        
      End If
      
    End With
   
    On Error Resume Next
   
    Dim i As Integer
    Dim mNodo As Node
    
    Dim b As Boolean
    b = FileExists("Debug.bat")
   
    Arbol.Nodes.Add , , "Ppal", glbEmpresaSegunString, "Ppal", "Ppal"

    For i = 2 To ArbolDefault.Nodes.Count

        With Arbol.Nodes
           'MARIANO : REVISAR LOS ACCESOS DESPUES!!!!!
            If ControlAcceso(ArbolDefault.Nodes(i).Key) Or b Then
                .Add ArbolDefault.Nodes(i).Parent.Key, tvwChild, ArbolDefault.Nodes(i).Key, ArbolDefault.Nodes(i).Text, ArbolDefault.Nodes(i).Image, ArbolDefault.Nodes(i).SelectedImage
            End If

        End With

    Next

'/////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////
    'Arbol.Nodes.Add "Ppal", tvwChild, "BotoneraOperador", "Botonera", "Empleados", "Empleados"
    'Arbol.Nodes.Add "Ppal", tvwChild, "", "", "", ""
    'Arbol.Nodes.Add "PartedeProduccion", tvwChild, "PartesNuevo", "Nuevo Parte", "Empleados", "Empleados"
    'Arbol.Nodes.Add "OrdendeProduccion", tvwChild, "OrdendeProduccionNuevo", "Nueva Orden", "UnidadesOperativas", "UnidadesOperativas"
'/////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////


    Arbol.Nodes(1).Expanded = True
   
    For Each mNodo In Arbol.Nodes
        'If mNodo.Parent = glbEmpresaSegunString Then
        '   mNodo.Bold = True
        'End If
    Next

    Set mNodo = Nothing
   
End Sub

Public Sub AnalizarStringConnection()

    On Error GoTo 0
   
    Dim mArchivoDefinicionConexion As String
    mArchivoDefinicionConexion = Dir(app.Path & "\" & app.Title, vbArchive)

    If mArchivoDefinicionConexion = "" Then
        Exit Sub
    End If
   
    Dim MydsEncrypt As dsEncrypt
    Dim mArchivoConexion As String, mConexion As String, mEmpresa As String
    Dim mString As String
    Dim i As Integer, mPos As Integer
    Dim mVariosString As Boolean, mOk As Boolean
    Dim mVectorConexiones, mVectorConexion
   
    Set MydsEncrypt = New dsEncrypt
    MydsEncrypt.KeyString = ("EDS")
   
    mArchivoConexion = LeerArchivoSecuencial(app.Path & "\" & app.Title)

    Do While Len(mArchivoConexion) > 0 And (Asc(right(mArchivoConexion, 1)) = 10 Or Asc(right(mArchivoConexion, 1)) = 13)
        mArchivoConexion = mId(mArchivoConexion, 1, Len(mArchivoConexion) - 1)
    Loop

    mArchivoConexion = MydsEncrypt.Encrypt(mArchivoConexion)
    
    '///////////////////////////////////
    'MARIANO
   
    'conexion harcodeada para casa
    'mArchivoConexion = "Pronto|Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initial catalog=Pronto;Data Source=fondo;Connect Timeout=45"
   
    'conexion harcodeada para BDL maquina de Alejo
    'mArchivoConexion = "Pronto|Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa; Password=ok;Initial Catalog=Pronto;Data Source=Win2003;Connect Timeout=45"
    '///////////////////////////////////

    mVectorConexiones = VBA.Split(mArchivoConexion, vbCrLf)

    mVariosString = False
    mConexion = ""
    mEmpresa = ""

    For i = 0 To UBound(mVectorConexiones)

        If Len(mVectorConexiones(i)) > 0 Then
            mVectorConexion = VBA.Split(mVectorConexiones(i), "|")

            If Len(mVectorConexion(1)) > 0 Then
                If Len(mConexion) > 0 Then
                    mVariosString = True
                Else
                    mEmpresa = mVectorConexion(0)
                    mConexion = mVectorConexion(1)
                End If
            End If
        End If

    Next
   
    If Not mVariosString Then
      
        mString = MydsEncrypt.Encrypt(mConexion)
        '      GuardarArchivoSecuencial GetWinDir & "\" & App.Title, mString
   
    Else
      
        Dim oRs As ADOR.Recordset
        Set oRs = CreateObject("Ador.Recordset")

        With oRs
            .Fields.Append "IdAux", adInteger
            .Fields.Append "Titulo", adVarChar, 250
            .Open
        End With

        For i = 0 To UBound(mVectorConexiones)

            If Len(mVectorConexiones(i)) > 0 Then
                mVectorConexion = VBA.Split(mVectorConexiones(i), "|")

                If Len(mVectorConexion(1)) > 0 Then
                    oRs.AddNew
                    oRs.Fields("IdAux").Value = i
                    oRs.Fields("Titulo").Value = mVectorConexion(0)
                    oRs.Update
                End If
            End If

        Next
   
        Dim oF As frmStringConnection
        Set oF = New frmStringConnection

        With oF
            Set .RecordsetDeStrings = oRs
            .Show vbModal, Me
            mOk = .Ok

            If mOk Then
                If IsNumeric(.DataCombo1(0).BoundText) Then
                    mPos = .DataCombo1(0).BoundText
                Else
                    mPos = -1
                End If
            End If

        End With

        Unload oF
        Set oF = Nothing
        Set oRs = Nothing
   
        If Not mOk Then End
   
        If mPos <> -1 Then
            mVectorConexion = VBA.Split(mVectorConexiones(mPos), "|")
            mEmpresa = mVectorConexion(0)
            mString = mVectorConexion(1)
            mString = MydsEncrypt.Encrypt(mString)
            '         GuardarArchivoSecuencial GetWinDir & "\" & App.Title, mString
        Else
            End
        End If
   
    End If

    Set MydsEncrypt = Nothing
   
    glbStringConexion = mString
    glbEmpresaSegunString = mEmpresa
   
End Sub

Public Sub CargarPopUpMenu()

    Dim clave As String
    Dim oCtrl As Control
    Dim i As Integer
   
    On Error GoTo Mal
   
    For Each oCtrl In Me.Controls

        If TypeOf oCtrl Is Menu Then
            If oCtrl.Tag <> "" Then
                Debug.Print oCtrl.Tag, oCtrl.Name & oCtrl.Index
                clave = oCtrl.Name & oCtrl.Index

                If ControlAccesoNivel(clave) > 5 Then
                    oCtrl.Visible = False
                Else
                    oCtrl.Visible = True
                    oCtrl.Enabled = True
                End If
            End If
        End If

    Next

    For i = 1 To Toolbar1.Buttons.Count
        clave = Toolbar1.Buttons.Item(i).Key

        If Len(clave) > 0 Then
            If ControlAccesoNivel("btn_" & clave) = 1 Then
                Toolbar1.Buttons.Item(i).Enabled = True
            Else
                Toolbar1.Buttons.Item(i).Enabled = False
            End If
        End If

    Next
    
    
    Toolbar1.Buttons("Nuevo Parte").Enabled = True
    Toolbar1.Buttons("Nueva Orden").Enabled = True
    
   
    If BuscarClaveINI("Activar popup de materiales") <> "SI" Then
        Toolbar1.Buttons("MenuPopUp").Enabled = False
    End If
   
    If glbAdministrador Then
        'With mnuMaster(4)
        '.Enabled = True
        '.Visible = True
        'End With
        'With MnuSeg(0)
        '   .Enabled = True
        '   .Visible = True
        'End With
    End If
   
    Exit Sub
   
Mal:

    Select Case Err.Number

        Case 387
            oCtrl.Enabled = False
            Resume Next

        Case Else
            MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    End Select

End Sub

Public Sub RegistrosDocumentosAExportar(ByVal Documento As String, _
                                        ByVal Posicion As Integer, _
                                        Optional ByVal Borrador As String)

    Dim Filas
    Dim Columnas
    Dim iFilas As Integer, mvarAgrupar As Integer, i As Integer, mCopias As Integer
    Dim s As String, mCarpeta As String, mImprime As String, mInfo As String
    Dim mImprimeAdjuntos As String, mError As String
    Dim mOk As Boolean, mErr As Boolean
   
    If IsMissing(Borrador) Then Borrador = "SI"
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)
   
    s = ""

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)

        If Posicion > UBound(Columnas) Then Exit Sub
        mErr = False

        If Documento = "Pedidos" And Not Borrador = "SI" Then
            If Not CircuitoFirmasCompleto(NotaPedido, Columnas(Posicion), Columnas(12)) Then
                mError = mError & vbCrLf & " " & Columnas(1)
                mErr = True
            End If
        End If

        If Not mErr Then s = s & Columnas(Posicion) & "|"
    Next

    If Len(mError) > 0 Then MsgBox "Los siguientes pedidos no tienen el circuito de " & "firmas completo y no se emitiran :" & mError, vbExclamation

    If Len(s) = 0 Then
        MsgBox "No hay documentos para exportar!", vbExclamation
        Exit Sub
    Else
        s = mId(s, 1, Len(s) - 1)
    End If
   
    mCarpeta = BuscarClaveINI("Carpeta generacion pedidos")

    If Len(mCarpeta) = 0 Then mCarpeta = "C:\"
    mCopias = Val(BuscarClaveINI("CopiasPedidos"))

    If mCopias = 0 Then mCopias = 2
   
    Dim oF 'As frmExportarDocumentos

    'Set oF = New frmExportarDocumentos
    With oF
        With .Label1
            .Caption = "Cantidad de copias:"
            .Visible = True
        End With

        With .text1
            .Text = 1
            .Visible = True
        End With

        If Documento = "Pedidos" Then
            .Check2.Visible = True

            With .Check3
                .Caption = "Emitir documentos adjuntos :"
                .Value = 0
                .Visible = True
            End With

            .text1.Text = mCopias
        End If

        .txtCarpeta.Text = mCarpeta
        .Show vbModal, Me
        mOk = .Ok
        mCarpeta = Trim(.txtCarpeta.Text)

        If .Check1 = 0 Then
            mImprime = "NO"
        Else
            mImprime = "SI"
        End If

        If .Check3 = 0 Then
            mImprimeAdjuntos = "NO"
        Else
            mImprimeAdjuntos = "SI"
        End If

        mvarAgrupar = .Check2.Value
        mCopias = Val(.text1.Text)
    End With
   
    Unload oF
    Set oF = Nothing

    If mOk Then

        'Vector mInfo :
        '                0 Auxiliar
        '                1 S=Sin costos, C=Con costos (solo para pedidos)
        '                2 Index : 0=Impresion, 1=Word, 2=Grabar en app.path en Word, 3=Grabar en carpeta definida en Word
        '                3 Carpeta donde se guardaran los documentos
        '                4 SI=Con impresion, NO=Sin impresion
        '                5 Cantidad de copias a imprimir
        '                6 Tipo de formulario (solo para RM)
        '                7 S=Con avances, N=Sin avances (solo para listas de materiales
        If Len(mCarpeta) > 0 Then
            If mId(mCarpeta, Len(mCarpeta), 1) = "\" Then mCarpeta = mId(mCarpeta, 1, Len(mCarpeta) - 1)
        End If

        ExportarDocumentos Documento, s, "|C|3|" & mCarpeta & "|" & mImprime & "|" & mCopias & "|Legal|S|" & mvarAgrupar & "|" & Borrador & "|" & mImprimeAdjuntos & "|"
    End If

End Sub

Private Sub EmisionDeCheques()
   
    Dim mvarOK As Boolean
    Dim mPrinter As String, mPrinterAnt As String
   
    mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
    Dim oF 'As frmCopiasImpresion

    'Set oF = New frmCopiasImpresion
    With oF
        .txtCopias.Visible = False
        .lblCopias.Visible = False
        .Frame1.Visible = False
        .Show vbModal, Me
    End With

    mvarOK = oF.Ok
    mPrinter = oF.Combo1.Text
    Unload oF
    Set oF = Nothing

    If Not mvarOK Then
        Exit Sub
    End If

    On Error GoTo Mal
   
    Dim oW As Word.Application
    Dim cALetra As New clsNum2Let
    Dim oRs As ADOR.Recordset
    Dim oRs1 As ADOR.Recordset
    Dim mDiaYMesEmision As String, mBeneficiario As String, mImporteLetras1 As String
    Dim mImporteLetras2 As String, mIdCuentasBancarias As String, mError As String
    Dim mDelanteDelImporte As String, mFormatoCheque As String, mImporte As String
    Dim mFecha As Date, mFechaValor As Date
    Dim mItem As Integer, iFilas As Integer, mPos As Integer, i As Integer, X As Integer
    Dim mAviso As Integer
    Dim mEmiteDe As Boolean
    Dim oL As ListItem
    Dim Filas, Columnas, mVectorIdCuentasBancarias
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)
   
    mIdCuentasBancarias = ""

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)

        If IsNumeric(Columnas(3)) Then
            If InStr(1, mIdCuentasBancarias, Columnas(3) & "|") = 0 Then
                mIdCuentasBancarias = mIdCuentasBancarias & Columnas(3) & "|"
            End If
        End If

    Next

    If Len(mIdCuentasBancarias) > 0 Then
        mIdCuentasBancarias = mId(mIdCuentasBancarias, 1, Len(mIdCuentasBancarias) - 1)
    End If
   
    If BuscarClaveINI("Emite DE en plantilla de cheques") = "SI" Then mEmiteDe = True Else mEmiteDe = False
    mDelanteDelImporte = "" & BuscarClaveINI("Imprimir delante del importe en plantilla de cheques")
    mFormatoCheque = BuscarClaveINI("Formato condicional para plantilla de cheques")
   
    mVectorIdCuentasBancarias = VBA.Split(mIdCuentasBancarias, "|")
    mError = ""
   
    If BuscarClaveINI("Controlar caracteres beneficiarios en emision de cheques") = "SI" Then
        Filas = VBA.Split(Lista.GetString, vbCrLf)

        For iFilas = LBound(Filas) + 1 To UBound(Filas)
            Columnas = VBA.Split(Filas(iFilas), vbTab)

            If IsNumeric(Columnas(3)) Then
                Set oRs = Aplicacion.CuentasBancarias.TraerFiltrado("_PorId", Columnas(3))

                If oRs.RecordCount > 0 Then
                    X = IIf(IsNull(oRs.Fields("CaracteresBeneficiario").Value), 0, oRs.Fields("CaracteresBeneficiario").Value)

                    If X <> 0 Then
                        Set oRs1 = Aplicacion.Valores.TraerFiltrado("_DatosParaEmisionDeCheque", Columnas(2))

                        If Not IsNull(oRs1.Fields("ChequesALaOrdenDe").Value) Then
                            mBeneficiario = oRs1.Fields("ChequesALaOrdenDe").Value
                        ElseIf Not IsNull(oRs1.Fields("RazonSocial").Value) Then
                            mBeneficiario = oRs1.Fields("RazonSocial").Value
                        Else
                            mBeneficiario = ""
                        End If

                        If Not IsNull(oRs1.Fields("NoALaOrden").Value) And oRs1.Fields("NoALaOrden").Value = "SI" Then
                            mBeneficiario = mBeneficiario & " - NO A LA ORDEN"
                        End If

                        If Len(mBeneficiario) > X Then
                            mError = mError & "Cheque " & Columnas(1) & " beneficiario : " & mBeneficiario & vbCrLf
                        End If

                        oRs1.Close
                    End If
                End If

                oRs.Close
            End If

        Next

        If Len(mError) > 0 Then
            MsgBox "Los siguientes valores tienen el nombre del beneficiario muy largos : " & vbCrLf & mError, vbExclamation
            GoTo Salida
        End If
    End If
      
    Set oW = CreateObject("Word.Application")
    oW.Visible = True
   
    For i = LBound(mVectorIdCuentasBancarias) To UBound(mVectorIdCuentasBancarias)
      
        Set oRs = Aplicacion.CuentasBancarias.TraerFiltrado("_PorIdConCuenta", mVectorIdCuentasBancarias(i))
      
        If oRs.RecordCount > 0 Then
         
            If IsNull(oRs.Fields("PlantillaChequera").Value) Then
                mError = mError & "La cuenta del banco " & oRs.Fields("Banco").Value & " no tiene definida la plantilla de impresion." & vbCrLf
            ElseIf IsNull(oRs.Fields("ChequesPorPlancha").Value) Or oRs.Fields("ChequesPorPlancha").Value = 0 Then
                mError = mError & "La cuenta del banco " & oRs.Fields("Banco").Value & " no tiene definida los cheques por plancha." & vbCrLf
            Else
                mItem = 0
                oW.Documents.Add (glbPathPlantillas & "\" & oRs.Fields("PlantillaChequera").Value)
      
                mAviso = MsgBox("Se emitiran los cheques de la cuenta " & oRs.Fields("Banco").Value & vbCrLf & "Desea continuar ?", vbYesNo, "Impresion de cheques")

                If mAviso = vbNo Then
                    oRs.Close
                    GoTo Salida
                End If
            
                Filas = VBA.Split(Lista.GetString, vbCrLf)
            
                For iFilas = LBound(Filas) + 1 To UBound(Filas)
                  
                    Columnas = VBA.Split(Filas(iFilas), vbTab)
               
                    If IsNumeric(Columnas(3)) And CInt(Columnas(3)) = oRs.Fields("IdCuentaBancaria").Value Then
                  
                        If mItem = oRs.Fields("ChequesPorPlancha").Value Then
                            If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
                            oW.Documents(1).PrintOut False

                            If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
                            oW.Documents(1).Close False
                            oW.Documents.Add (glbPathPlantillas & "\" & oRs.Fields("PlantillaChequera").Value)
                            mItem = 0
                        End If
                     
                        mItem = mItem + 1
                  
                        Set oRs1 = Aplicacion.Valores.TraerFiltrado("_DatosParaEmisionDeCheque", Columnas(2))
                  
                        If Not IsNull(oRs1.Fields("ChequesALaOrdenDe").Value) Then
                            mBeneficiario = oRs1.Fields("ChequesALaOrdenDe").Value
                        ElseIf Not IsNull(oRs1.Fields("RazonSocial").Value) Then
                            mBeneficiario = oRs1.Fields("RazonSocial").Value
                        Else
                            mBeneficiario = ""
                        End If

                        If Not IsNull(oRs1.Fields("NoALaOrden").Value) And oRs1.Fields("NoALaOrden").Value = "SI" Then
                            mBeneficiario = mBeneficiario & " - NO A LA ORDEN"
                        End If

                        mFecha = oRs1.Fields("FechaComprobante").Value
                        mFechaValor = oRs1.Fields("FechaValor").Value
                        mDiaYMesEmision = "" & Day(mFecha) & " de " & NombreMes(Month(mFecha))
            
                        mImporte = Format(oRs1.Fields("Importe").Value, "#,##0.00")

                        If mFormatoCheque = "02" Then
                            mImporte = Replace(Replace(Replace(mImporte, ".", "|"), ",", "."), "|", ",")
                        End If

                        cALetra.Numero = oRs1.Fields("Importe").Value
                        mImporteLetras1 = cALetra.ALetra
                        mImporteLetras1 = Replace(mImporteLetras1, "pesos", "")
                        mImporteLetras1 = Replace(mImporteLetras1, "Cts.", "")

                        If Len(mImporteLetras1) > 55 Then
                            mPos = 0
                            mPos = InStrRev(mId(mImporteLetras1, 1, 55), " ")
                            mImporteLetras2 = mId(mImporteLetras1, mPos + 1, Len(mImporteLetras1) - mPos)
                            mImporteLetras1 = mId(mImporteLetras1, 1, mPos)
                        Else
                            mImporteLetras2 = ""
                        End If
            
                        oW.ActiveDocument.FormFields("Importe" & mItem).Result = mDelanteDelImporte & mImporte
                        oW.ActiveDocument.FormFields("DiaEmision" & mItem).Result = "" & Format(Day(mFecha), "00")
                        oW.ActiveDocument.FormFields("MesEmision" & mItem).Result = "" & NombreMes(Month(mFecha))
                        oW.ActiveDocument.FormFields("AñoEmision" & mItem).Result = "" & Year(mFecha)
                        oW.ActiveDocument.FormFields("DiaPago" & mItem).Result = "" & Format(Day(mFechaValor), "00")
                        oW.ActiveDocument.FormFields("MesPago" & mItem).Result = "" & NombreMes(Month(mFechaValor))
                        oW.ActiveDocument.FormFields("AñoPago" & mItem).Result = "" & Year(mFechaValor)
                        oW.ActiveDocument.FormFields("PagueseA" & mItem).Result = mBeneficiario
                        oW.ActiveDocument.FormFields("ImporteLetrasA" & mItem).Result = mImporteLetras1
                        oW.ActiveDocument.FormFields("ImporteLetrasB" & mItem).Result = mImporteLetras2
                  
                        If mEmiteDe Then
                            oW.ActiveDocument.FormFields("De" & mItem).Result = "DE"
                        End If
         
                        oRs1.Close
                  
                        Aplicacion.Tarea "Valores_MarcarComoEmitido", Array(Columnas(2), glbIdUsuario)

                        For Each oL In Lista.ListItems

                            If oL.ListSubItems(1) = Columnas(2) Then
                                oL.ListSubItems(19) = "SI"
                                oL.ListSubItems(20) = "" & Date
                                oL.ListSubItems(21) = "" & glbNombreUsuario
                                Exit For
                            End If

                        Next
                        
                    End If
               
                Next
                  
                If mItem > 0 Then
                    If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
                    oW.Documents(1).PrintOut False

                    If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
                    oW.Documents(1).Close False
                End If
            
            End If
        End If

        oRs.Close
    Next
   
    oW.Quit
   
Salida:

    Set oW = Nothing
    Set cALetra = Nothing
    Set oRs = Nothing
    Set oRs1 = Nothing
   
    Exit Sub
   
Mal:

    MsgBox "Se ha producido un error en la emision :" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Function ArmaConciliacionCaja(ByVal mIdCaja, _
                                     ByVal mIdCuentaBancaria, _
                                     ByVal mFechaDesde As Date, _
                                     ByVal mFechaHasta As Date, _
                                     ByVal mTodos As Integer) As ADOR.Recordset

    Dim oRs As ADOR.Recordset
    Dim mIdCuenta As Long
    Dim mSaldo As Double, mSaldoPesos As Double
    Dim mFechaArranqueCajaYBancos As Date, mFechaInicial As Date
   
    On Error GoTo Mal
   
    mIdCuenta = 0

    If mIdCaja > 0 Then
        Set oRs = Aplicacion.Cajas.TraerFiltrado("_PorId", mIdCaja)

        If oRs.RecordCount > 0 Then
            mIdCuenta = oRs.Fields("IdCuenta").Value
        End If

    Else
        Set oRs = Aplicacion.CuentasBancarias.TraerFiltrado("_PorIdConCuenta", mIdCuentaBancaria)

        If oRs.RecordCount > 0 Then
            mIdCuenta = oRs.Fields("IdCuenta").Value
        End If
    End If

    oRs.Close
   
    mFechaInicial = DateSerial(2000, 1, 1)
    Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)

    If Not IsNull(oRs.Fields("FechaArranqueCajaYBancos").Value) Then
        mFechaArranqueCajaYBancos = oRs.Fields("FechaArranqueCajaYBancos").Value
    Else
        mFechaArranqueCajaYBancos = DateSerial(2000, 1, 1)
    End If

    oRs.Close
   
    mSaldo = 0
    mSaldoPesos = 0
    Set oRs = Aplicacion.Cuentas.TraerFiltrado("_MayorPorIdCuentaEntreFechas", Array(mIdCuenta, mFechaInicial, DateAdd("d", -1, mFechaArranqueCajaYBancos)))

    If oRs.RecordCount > 0 Then
        mSaldo = IIf(IsNull(oRs.Fields("Saldo").Value), 0, oRs.Fields("Saldo").Value)
        mSaldoPesos = IIf(IsNull(oRs.Fields("Saldo").Value), 0, oRs.Fields("Saldo").Value)
    End If

    oRs.Close
   
    If mIdCaja > 0 Then
        'Set oRs = CopiarTodosLosRegistros(Aplicacion.Valores.TraerFiltrado("_MovimientosPorIdCaja", Array(mIdCaja, mFechaDesde, mFechaHasta, mTodos)))
    Else
        'Set oRs = CopiarTodosLosRegistros(Aplicacion.Bancos.TraerFiltrado("_MovimientosPorCuenta", Array(mIdCuentaBancaria, mFechaDesde, mFechaHasta, mTodos)))
    End If

    With oRs

        If .RecordCount > 0 Then
            .MoveFirst

            Do While Not .EOF

                If .Fields("Fec.Comp.").Value >= mFechaArranqueCajaYBancos Then
                    If Not IsNull(.Fields("Ingresos").Value) Then
                        mSaldo = mSaldo + .Fields("Ingresos").Value
                    End If

                    If Not IsNull(.Fields("Ingresos $").Value) Then
                        mSaldoPesos = mSaldoPesos + IIf(IsNull(.Fields("Ingresos $").Value), 0, .Fields("Ingresos $").Value)
                    End If

                    If Not IsNull(.Fields("Egresos").Value) Then
                        mSaldo = mSaldo - .Fields("Egresos").Value
                    End If

                    If Not IsNull(.Fields("Egresos $").Value) Then
                        mSaldoPesos = mSaldoPesos - IIf(IsNull(.Fields("Egresos $").Value), 0, .Fields("Egresos $").Value)
                    End If

                    .Fields("Saldo").Value = mSaldo
                    .Fields("Saldo $").Value = mSaldoPesos
                End If

                If mTodos = -1 And .Fields("Tipo").Value = "INI" Then
                    .Delete
                End If

                .MoveNext
            Loop

            .MoveFirst
        End If

    End With

    Set ArmaConciliacionCaja = oRs
   
    Set oRs = Nothing
   
    Exit Function

Mal:

    Set ArmaConciliacionCaja = Nothing
    Set oRs = Nothing

End Function

Public Sub CambiarBeneficiarioCheques(ByVal Filas As Variant)

    Dim mvarOK As Boolean
    Dim mvarNoALaOrden As String, mvarBeneficiario As String
    Dim oF As frm_Aux
    Dim oL As ListItem
    Dim Columnas
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)
    Columnas = VBA.Split(Filas(1), vbTab)
            
    mvarBeneficiario = Columnas(8)
    mvarNoALaOrden = Columnas(9)
   
    Set oF = New frm_Aux

    With oF
        .Width = .Width * 2
        .Caption = "Cambiar beneficiario de cheque"
        .Label1.Caption = "Beneficiario :"

        With .text1
            .Width = .Width * 4
            .Text = mvarBeneficiario
        End With

        With .Check1
            .left = oF.Label1.left
            .top = oF.DTFields(1).top
            .Width = oF.text1.Width / 3
            .Caption = "No a la Orden :"

            If mvarNoALaOrden = "SI" Then
                .Value = 1
            Else
                .Value = 0
            End If

            .Visible = True
        End With

        .Show vbModal, Me
        mvarBeneficiario = oF.text1.Text

        If .Check1.Value = 0 Then
            mvarNoALaOrden = "NO"
        Else
            mvarNoALaOrden = "SI"
        End If

        mvarOK = .Ok
    End With

    Unload oF
    Set oF = Nothing

    If Not mvarOK Then
        Exit Sub
    End If

    If IsNumeric(Columnas(2)) Then
        Aplicacion.Tarea "Valores_ModificarBeneficiario", Array(Columnas(2), mvarBeneficiario, mvarNoALaOrden)

        For Each oL In Lista.ListItems

            If oL.ListSubItems(1) = Columnas(2) Then
                oL.ListSubItems(7) = "" & mvarBeneficiario
                oL.ListSubItems(8) = "" & mvarNoALaOrden
                Exit For
            End If

        Next

    End If
         
End Sub

Public Sub EliminarComprobantesAConfirmar()

    Dim Filas
    Dim Columnas
    Dim iFilas As Integer
   
    Me.MousePointer = vbHourglass

    DoEvents

    Filas = VBA.Split(Lista.GetString, vbCrLf)
   
    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
        Aplicacion.Tarea "ComprobantesProveedores_EliminarComprobanteAConfirmar", Columnas(2)
    Next

    Set Lista.DataSource = Aplicacion.ComprobantesProveedores.TraerFiltrado("_AConfirmar")
   
    Me.MousePointer = vbDefault

End Sub

Public Sub EliminarRMAConfirmar()

    Dim Filas
    Dim Columnas
    Dim iFilas As Integer
   
    Me.MousePointer = vbHourglass

    DoEvents

    Filas = VBA.Split(Lista.GetString, vbCrLf)
   
    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
        Aplicacion.Tarea "Requerimientos_EliminarRequerimientosAConfirmar", Columnas(2)
    Next

    Set Lista.DataSource = Aplicacion.Requerimientos.TraerFiltrado("_AConfirmar")
   
    Me.MousePointer = vbDefault

End Sub

Public Sub GeneracionDeFacturasAnuladas()

    Dim oF As frmExcel1
    Set oF = New frmExcel1

    With oF
        .Codigo = "AnuFac"
        .Titulo = "Generacion automatica de facturas de venta anuladas"
        .Show vbModal, Me
    End With

    Unload oF
    Set oF = Nothing

End Sub

Public Sub GeneracionDeFacturasAnuladasExistentes()

    Dim oF As frmExcel1
    Set oF = New frmExcel1

    With oF
        .Codigo = "AnuFac1"
        .Titulo = "Anulacion masiva de facturas de venta existentes"
        .Show vbModal, Me
    End With

    Unload oF
    Set oF = Nothing

End Sub

Public Sub ImportacionConjuntos()

    Dim oAp As ComPronto.Aplicacion
    Dim oConj As ComPronto.Conjunto
    Dim oRsAux1 As ADOR.Recordset
    Dim oEx As Excel.Application
    Dim oF As Form
    Dim mOk As Boolean
    Dim mArchivo As String, mCodigo As String, mAbreviatura As String
    Dim mError As String, mConjunto As String
    Dim mIdUnidadPorUnidad As Integer, mIdUnidad As Integer, fl As Integer
    Dim mIdArticulo As Long
    Dim mCantidad As Double

    On Error GoTo Mal

    'Set oF = New frmPathPresto
    With oF
        .Id = 3
        .Show vbModal
        mOk = .Ok

        If mOk Then
            mArchivo = .FileBrowser1(0).Text
        End If

    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub

    Set oAp = Aplicacion

    Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
    mIdUnidadPorUnidad = oRsAux1.Fields("IdUnidadPorUnidad").Value
    oRsAux1.Close
   
    'Set oF = New frmAviso
    With oF
        .Label1 = "Iniciando EXCEL ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Procesando conjuntos ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    mError = ""
    mConjunto = ""
    fl = 2
   
    Set oEx = CreateObject("Excel.Application")

    With oEx
      
        .Visible = True
        .WindowState = xlMinimized
        Me.Refresh
      
        With .Workbooks.Open(mArchivo)
            With .ActiveSheet

                Do While True

                    If Len(Trim(.Cells(fl, 2))) > 0 Then
                        mConjunto = .Cells(fl, 2)
                  
                        If Not oConj Is Nothing Then
                            oConj.Guardar
                            Set oConj = Nothing
                        End If
                  
                        oF.Label2 = "Conjunto : " & mConjunto

                        DoEvents
                  
                        mCodigo = .Cells(fl, 1)
                        Set oRsAux1 = oAp.Articulos.TraerFiltrado("_PorCodigo", mCodigo)
                        mIdArticulo = 0

                        If oRsAux1.RecordCount > 0 Then
                            mIdArticulo = oRsAux1.Fields(0).Value
                        Else
                            mError = mError & vbCrLf & "El conjunto " & mConjunto & " tiene un codigo inexistente"
                        End If

                        oRsAux1.Close
                  
                        If mIdArticulo <> 0 Then
                            Set oRsAux1 = oAp.Conjuntos.TraerFiltrado("_PorIdArticulo", mIdArticulo)

                            If oRsAux1.RecordCount > 0 Then
                                mError = mError & vbCrLf & "El conjunto " & mConjunto & " ya existe"
                            Else
                                Set oConj = oAp.Conjuntos.Item(-1)

                                With oConj.Registro
                                    .Fields("IdArticulo").Value = mIdArticulo
                                    .Fields("IdRealizo").Value = glbIdUsuario
                                    .Fields("FechaRegistro").Value = Date
                                End With

                            End If

                            oRsAux1.Close
                        End If
                    End If
               
                    If Len(Trim(.Cells(fl, 4))) > 0 Then
                        If Not oConj Is Nothing Then
                            mCantidad = CDbl(.Cells(fl, 5))
                     
                            mCodigo = .Cells(fl, 3)
                            Set oRsAux1 = oAp.Articulos.TraerFiltrado("_PorCodigo", mCodigo)
                            mIdArticulo = 0

                            If oRsAux1.RecordCount > 0 Then
                                mIdArticulo = oRsAux1.Fields(0).Value
                            Else
                                mError = mError & vbCrLf & "El componente " & .Cells(fl, 4) & " del conjunto" & mConjunto & ", tiene un codigo inexistente"
                            End If

                            oRsAux1.Close
                     
                            mAbreviatura = .Cells(fl, 6)
                            Set oRsAux1 = oAp.Unidades.TraerFiltrado("_PorAbreviatura", mAbreviatura)
                            mIdUnidad = 0

                            If oRsAux1.RecordCount > 0 Then
                                mIdUnidad = oRsAux1.Fields(0).Value
                            Else
                                mError = mError & vbCrLf & "El componente " & .Cells(fl, 4) & " del conjunto" & mConjunto & ", tiene la unidad inexistente"
                                mIdUnidad = mIdUnidadPorUnidad
                            End If

                            oRsAux1.Close
                     
                            With oConj.DetConjuntos.Item(-1)
                                With .Registro
                                    .Fields("IdArticulo").Value = mIdArticulo
                                    .Fields("IdUnidad").Value = mIdUnidad
                                    .Fields("Cantidad").Value = mCantidad
                                End With

                                .Modificado = True
                            End With

                        End If
                    End If
               
                    If Len(Trim(.Cells(fl, 2))) = 0 And Len(Trim(.Cells(fl, 4))) = 0 Then
                        If Not oConj Is Nothing Then
                            oConj.Guardar
                            Set oConj = Nothing
                        End If

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
            .Id = 12
            oF.rchTexto.Text = mError
            .Show vbModal, Me
        End With

        Unload oF
        Set oF = Nothing
    End If

    Set oRsAux1 = Nothing
    Set oAp = Nothing
    Set oEx = Nothing

    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub ImportacionComprobantesProveedores()

    Dim oAp As ComPronto.Aplicacion
    Dim oCP As ComPronto.ComprobanteProveedor
    Dim oPr As ComPronto.Proveedor
    Dim oPar As ComPronto.Parametro
    Dim oRsAux1 As ADOR.Recordset
    Dim oRsAux2 As ADOR.Recordset
    Dim oF As Form
    Dim oEx As Excel.Application
    Dim mOk As Boolean, mConProblemas As Boolean
    Dim mArchivo As String, mComprobante As String, mCuit As String, mLetra As String
    Dim mBienesOServicios As String, mObservaciones As String, mRazonSocial As String
    Dim mIncrementarReferencia As String, mNumeroCAI As String
    Dim mFechaFactura As Date, mFechaVencimientoCAI As Date, mFechaRecepcion As Date
    Dim mIdMonedaPesos As Integer, mIdTipoComprobanteFacturaCompra As Integer
    Dim mIdUnidadPorUnidad As Integer, fl As Integer, mContador As Integer
    Dim mIdCuentaIvaCompras1 As Integer, mIdCuenta As Long, mIdObra As Integer
    Dim mIdCuentaGasto As Integer, i As Integer, mvarProvincia As Integer
    Dim mvarIBCondicion As Integer, mvarIdIBCondicion As Integer
    Dim mvarIGCondicion As Integer, mvarIdTipoRetencionGanancia As Integer
    Dim mIdTipoComprobante As Integer
    Dim mIdProveedor As Long, mNumeroComprobante1 As Long, mNumeroComprobante2 As Long
    Dim mCodigoCuenta As Long, mNumeroReferencia As Long
    Dim mvarCotizacionDolar As Single, mPorcentajeIVA As Single, mPorcentajeIVAInf As Single
    Dim mBruto As Double, mIva1 As Double, mTotalItem As Double, mPercepcion As Double
    Dim mTotalBruto As Double, mTotalIva1 As Double, mTotalComprobante As Double
    Dim mTotalPercepcion As Double, mAjusteIVA As Double, mTotalAjusteIVA As Double
    Dim mIdCuentaIvaCompras(10) As Long
    Dim mIVAComprasPorcentaje(10) As Single

    On Error GoTo Mal

    'Set oF = New frmPathPresto
    With oF
        .Id = 2
        .Show vbModal
        mOk = .Ok

        If mOk Then
            mArchivo = .FileBrowser1(0).Text
            mIdObra = .dcfields(0).BoundText
            mFechaRecepcion = .DTFields(0).Value
            mNumeroReferencia = Val(.text1.Text)
        End If

    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub

    Set oAp = Aplicacion

    mIncrementarReferencia = BuscarClaveINI("IncrementarReferenciaEnImportacionDeComprobantes")
   
    Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
    mIdMonedaPesos = oRsAux1.Fields("IdMoneda").Value
    mIdTipoComprobanteFacturaCompra = oRsAux1.Fields("IdTipoComprobanteFacturaCompra").Value
    mIdUnidadPorUnidad = oRsAux1.Fields("IdUnidadPorUnidad").Value

    For i = 1 To 10

        If Not IsNull(oRsAux1.Fields("IdCuentaIvaCompras" & i).Value) Then
            mIdCuentaIvaCompras(i) = oRsAux1.Fields("IdCuentaIvaCompras" & i).Value
            mIVAComprasPorcentaje(i) = oRsAux1.Fields("IVAComprasPorcentaje" & i).Value
        Else
            mIdCuentaIvaCompras(i) = 0
            mIVAComprasPorcentaje(i) = 0
        End If

    Next

    oRsAux1.Close
   
    'Set oF = New frmAviso
    With oF
        .Label1 = "Iniciando EXCEL ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Procesando comprobantes ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    fl = 7
    mContador = 0
   
    Set oEx = CreateObject("Excel.Application")

    With oEx
      
        .Visible = True
        .WindowState = xlMinimized
        Me.Refresh
      
        With .Workbooks.Open(mArchivo)
            .Sheets("PROVEEDORES").Select

            With .ActiveSheet

                Do While True
               
                    If Len(Trim(.Cells(fl, 2))) > 0 Then
                  
                        mConProblemas = False
                  
                        mContador = mContador + 1
                        oF.Label2 = "Comprobante : " & .Cells(fl, 5)
                        oF.Label3 = "" & mContador

                        DoEvents
               
                        If Len(.Cells(fl, 3)) > 0 Then
                            mIdTipoComprobante = .Cells(fl, 3)
                        Else
                            mIdTipoComprobante = mIdTipoComprobanteFacturaCompra
                        End If

                        mLetra = .Cells(fl, 4)
                        mComprobante = .Cells(fl, 5)
                        mNumeroComprobante1 = 0
                        mNumeroComprobante2 = 0

                        If InStr(1, mComprobante, "-") <> 0 Then
                            mNumeroComprobante1 = CLng(mId(mComprobante, 1, InStr(1, mComprobante, "-") - 1))

                            If mNumeroComprobante1 > 9999 Then
                                MsgBox "El punto de venta no puede tener mas de 4 digitos. (Fila " & fl & ")", vbExclamation
                                GoTo Salida
                            End If

                            mNumeroComprobante2 = CLng(mId(mComprobante, InStr(1, mComprobante, "-") + 1, 100))

                            If mNumeroComprobante2 > 99999999 Then
                                MsgBox "El numero de comprobante no puede tener mas de 8 digitos. (Fila " & fl & ")", vbExclamation
                                GoTo Salida
                            End If
                        End If

                        mRazonSocial = .Cells(fl, 6)
                        mCuit = .Cells(fl, 7)
                        mPorcentajeIVAInf = CSng(.Cells(fl, 8))
                        mFechaFactura = CDate(.Cells(fl, 2))
                        mNumeroCAI = .Cells(fl, 15)

                        If IsDate(.Cells(fl, 17)) Then
                            mFechaVencimientoCAI = CDate(.Cells(fl, 17))
                        Else
                            mFechaVencimientoCAI = 0
                        End If
                  
                        mIdProveedor = 0
                        Set oRsAux1 = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)

                        If oRsAux1.RecordCount > 0 Then
                            mIdProveedor = oRsAux1.Fields(0).Value
                            mvarProvincia = IIf(IsNull(oRsAux1.Fields("IdProvincia").Value), 0, oRsAux1.Fields("IdProvincia").Value)
                            mvarIBCondicion = IIf(IsNull(oRsAux1.Fields("IBCondicion").Value), 0, oRsAux1.Fields("IBCondicion").Value)
                            mvarIdIBCondicion = IIf(IsNull(oRsAux1.Fields("IdIBCondicionPorDefecto").Value), 0, oRsAux1.Fields("IdIBCondicionPorDefecto").Value)
                            mvarIGCondicion = IIf(IsNull(oRsAux1.Fields("IGCondicion").Value), 0, oRsAux1.Fields("IGCondicion").Value)
                            mvarIdTipoRetencionGanancia = IIf(IsNull(oRsAux1.Fields("IdTipoRetencionGanancia").Value), 0, oRsAux1.Fields("IdTipoRetencionGanancia").Value)
                            mBienesOServicios = IIf(IsNull(oRsAux1.Fields("BienesOServicios").Value), "B", oRsAux1.Fields("BienesOServicios").Value)
                        Else
                            Set oPr = oAp.Proveedores.Item(-1)

                            With oPr.Registro
                                .Fields("Confirmado").Value = "NO"
                                .Fields("RazonSocial").Value = mId(mRazonSocial, 1, 50)
                                .Fields("CUIT").Value = mCuit
                                .Fields("EnviarEmail").Value = 1
                            End With

                            oPr.Guardar
                            mIdProveedor = oPr.Registro.Fields(0).Value
                            Set oPr = Nothing
                            mvarProvincia = 0
                            mvarIBCondicion = 0
                            mvarIdIBCondicion = 0
                            mvarIGCondicion = 0
                            mvarIdTipoRetencionGanancia = 0
                            mBienesOServicios = "B"
                        End If

                        oRsAux1.Close
               
                        Set oRsAux1 = oAp.ComprobantesProveedores.TraerFiltrado("_PorNumeroComprobante", Array(mIdProveedor, mLetra, mNumeroComprobante1, mNumeroComprobante2, -1, -1))

                        If oRsAux1.RecordCount = 0 Then
                            mvarCotizacionDolar = Cotizacion(mFechaFactura, glbIdMonedaDolar)

                            If mvarCotizacionDolar = 0 Then
                                mConProblemas = True
                            End If

                            Set oCP = oAp.ComprobantesProveedores.Item(-1)

                            With oCP
                                With .Registro
                                    .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                                    .Fields("IdObra").Value = mIdObra
                                    .Fields("FechaComprobante").Value = mFechaFactura
                                    .Fields("FechaRecepcion").Value = mFechaRecepcion
                                    .Fields("FechaVencimiento").Value = mFechaFactura
                                    .Fields("IdMoneda").Value = mIdMonedaPesos
                                    .Fields("CotizacionMoneda").Value = 1
                                    .Fields("CotizacionDolar").Value = mvarCotizacionDolar
                                    .Fields("IdProveedor").Value = mIdProveedor
                                    .Fields("Letra").Value = mLetra
                                    .Fields("NumeroComprobante1").Value = mNumeroComprobante1
                                    .Fields("NumeroComprobante2").Value = mNumeroComprobante2

                                    If (mvarIBCondicion = 2 Or mvarIBCondicion = 3) And mvarIdIBCondicion <> 0 Then
                                        .Fields("IdIBCondicion").Value = mvarIdIBCondicion
                                    Else
                                        .Fields("IdIBCondicion").Value = Null
                                    End If

                                    If (mvarIGCondicion = 2 Or mvarIGCondicion = 3) And mvarIdTipoRetencionGanancia <> 0 Then
                                        .Fields("IdTipoRetencionGanancia").Value = mvarIdTipoRetencionGanancia
                                    Else
                                        .Fields("IdTipoRetencionGanancia").Value = Null
                                    End If

                                    .Fields("IdProvinciaDestino").Value = mvarProvincia
                                    .Fields("BienesOServicios").Value = mBienesOServicios
                                    .Fields("NumeroCAI").Value = mNumeroCAI

                                    If mFechaVencimientoCAI <> 0 Then
                                        .Fields("FechaVencimientoCAI").Value = mFechaVencimientoCAI
                                    Else
                                        .Fields("FechaVencimientoCAI").Value = Null
                                    End If

                                End With
                            End With
                     
                            mTotalBruto = 0
                            mTotalIva1 = 0
                            mTotalPercepcion = 0
                            mTotalComprobante = 0
                            mTotalAjusteIVA = 0
                            mObservaciones = ""

                            Do While Len(Trim(.Cells(fl, 2))) > 0 And mComprobante = .Cells(fl, 5) And mCuit = .Cells(fl, 7)

                                mCodigoCuenta = CLng(.Cells(fl, 9))
                                mBruto = Abs(CDbl(.Cells(fl, 10)))
                                mIva1 = Abs(CDbl(.Cells(fl, 11)))
                                mPercepcion = Abs(CDbl(.Cells(fl, 12)))
                                mTotalItem = Abs(CDbl(.Cells(fl, 13)))
                                mObservaciones = mObservaciones & .Cells(fl, 19) & vbCrLf
                        
                                mTotalBruto = mTotalBruto + mBruto
                                mTotalIva1 = mTotalIva1 + mIva1
                                mTotalPercepcion = mTotalPercepcion + mPercepcion
                                mTotalComprobante = mTotalComprobante + mTotalItem
                                mAjusteIVA = 0
                        
                                mPorcentajeIVA = 0

                                If mIva1 <> 0 And mBruto <> 0 Then
                                    mPorcentajeIVA = Round(mIva1 / mBruto * 100, 1)
                                End If
                        
                                mIdCuentaIvaCompras1 = 0

                                If mIva1 <> 0 Then
                                    If mPorcentajeIVAInf <> 0 Then

                                        For i = 1 To 10

                                            If mIVAComprasPorcentaje(i) = mPorcentajeIVAInf Then
                                                mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(i)
                                                mAjusteIVA = mIva1 - Round(mBruto * mPorcentajeIVAInf / 100, 2)
                                                mIva1 = Round(mBruto * mPorcentajeIVAInf / 100, 2)
                                                mPorcentajeIVA = mPorcentajeIVAInf
                                                Exit For
                                            End If

                                        Next

                                    End If

                                    If mIdCuentaIvaCompras1 = 0 Then
                                        If mPorcentajeIVA <> 0 Then

                                            For i = 1 To 10

                                                If mIVAComprasPorcentaje(i) = mPorcentajeIVA Then
                                                    mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(i)
                                                    Exit For
                                                End If

                                            Next

                                        End If
                                    End If

                                    If mIdCuentaIvaCompras1 = 0 Then
                                        mConProblemas = True
                                    End If
                                End If
                        
                                mTotalAjusteIVA = mTotalAjusteIVA + mAjusteIVA
                        
                                mIdCuenta = 0
                                mIdCuentaGasto = 0

                                If mCodigoCuenta > 1000 Then
                                    Set oRsAux2 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuenta)

                                    If oRsAux2.RecordCount > 0 Then
                                        mIdCuenta = oRsAux2.Fields(0).Value
                                    End If

                                Else
                                    Set oRsAux2 = oAp.CuentasGastos.TraerFiltrado("_PorId", mCodigoCuenta)

                                    If oRsAux2.RecordCount > 0 Then
                                        mIdCuentaGasto = oRsAux2.Fields(0).Value
                                    End If
                                End If

                                oRsAux2.Close

                                If mIdCuentaGasto = 0 And mIdCuenta = 0 Then
                                    mConProblemas = True
                                End If

                                If mIdCuenta = 0 Then
                                    Set oRsAux2 = oAp.Cuentas.TraerFiltrado("_PorObraCuentaGasto", Array(mIdObra, mIdCuentaGasto))

                                    If oRsAux2.RecordCount > 0 Then
                                        mIdCuenta = oRsAux2.Fields(0).Value
                                        mCodigoCuenta = oRsAux2.Fields("Codigo").Value
                                    End If

                                    oRsAux2.Close

                                    If mIdCuentaGasto = 0 Then
                                        mConProblemas = True
                                    End If
                                End If
                        
                                With oCP.DetComprobantesProveedores.Item(-1)
                                    With .Registro
                                        .Fields("IdObra").Value = mIdObra
                                        .Fields("IdCuentaGasto").Value = mIdCuentaGasto
                                        .Fields("IdCuenta").Value = mIdCuenta
                                        .Fields("CodigoCuenta").Value = mCodigoCuenta
                                        .Fields("Importe").Value = mBruto

                                        If mIdCuentaIvaCompras1 <> 0 Then
                                            .Fields("IdCuentaIvaCompras1").Value = mIdCuentaIvaCompras1
                                            .Fields("IVAComprasPorcentaje1").Value = mPorcentajeIVA
                                            .Fields("ImporteIVA1").Value = mIva1
                                            .Fields("AplicarIVA1").Value = "SI"
                                        Else
                                            .Fields("IdCuentaIvaCompras1").Value = Null
                                            .Fields("IVAComprasPorcentaje1").Value = 0
                                            .Fields("ImporteIVA1").Value = 0
                                            .Fields("AplicarIVA1").Value = "NO"
                                        End If

                                        .Fields("IdCuentaIvaCompras2").Value = Null
                                        .Fields("IVAComprasPorcentaje2").Value = 0
                                        .Fields("ImporteIVA2").Value = 0
                                        .Fields("AplicarIVA2").Value = "NO"
                                        .Fields("IdCuentaIvaCompras3").Value = Null
                                        .Fields("IVAComprasPorcentaje3").Value = 0
                                        .Fields("ImporteIVA3").Value = 0
                                        .Fields("AplicarIVA3").Value = "NO"
                                        .Fields("IdCuentaIvaCompras4").Value = Null
                                        .Fields("IVAComprasPorcentaje4").Value = 0
                                        .Fields("ImporteIVA4").Value = 0
                                        .Fields("AplicarIVA4").Value = "NO"
                                        .Fields("IdCuentaIvaCompras5").Value = Null
                                        .Fields("IVAComprasPorcentaje5").Value = 0
                                        .Fields("ImporteIVA5").Value = 0
                                        .Fields("AplicarIVA5").Value = "NO"
                                        .Fields("IdCuentaIvaCompras6").Value = Null
                                        .Fields("IVAComprasPorcentaje6").Value = 0
                                        .Fields("ImporteIVA6").Value = 0
                                        .Fields("AplicarIVA6").Value = "NO"
                                        .Fields("IdCuentaIvaCompras7").Value = Null
                                        .Fields("IVAComprasPorcentaje7").Value = 0
                                        .Fields("ImporteIVA7").Value = 0
                                        .Fields("AplicarIVA7").Value = "NO"
                                        .Fields("IdCuentaIvaCompras8").Value = Null
                                        .Fields("IVAComprasPorcentaje8").Value = 0
                                        .Fields("ImporteIVA8").Value = 0
                                        .Fields("AplicarIVA8").Value = "NO"
                                        .Fields("IdCuentaIvaCompras9").Value = Null
                                        .Fields("IVAComprasPorcentaje9").Value = 0
                                        .Fields("ImporteIVA9").Value = 0
                                        .Fields("AplicarIVA9").Value = "NO"
                                        .Fields("IdCuentaIvaCompras10").Value = Null
                                        .Fields("IVAComprasPorcentaje10").Value = 0
                                        .Fields("ImporteIVA10").Value = 0
                                        .Fields("AplicarIVA10").Value = "NO"
                                    End With

                                    .Modificado = True
                                End With
                     
                                fl = fl + 1
                            Loop
                     
                            With oCP
                                With .Registro
                                    .Fields("NumeroReferencia").Value = mNumeroReferencia
                                    '                           If mConProblemas Then
                                    .Fields("Confirmado").Value = "NO"
                                    '                           Else
                                    '                              .Fields("Confirmado").Value = "SI"
                                    '                           End If
                                    .Fields("TotalBruto").Value = mTotalBruto
                                    .Fields("TotalIva1").Value = mTotalIva1
                                    .Fields("TotalIva2").Value = 0
                                    .Fields("AjusteIVA").Value = mTotalAjusteIVA
                                    .Fields("TotalBonificacion").Value = 0
                                    .Fields("TotalComprobante").Value = mTotalComprobante
                                    .Fields("PorcentajeBonificacion").Value = 0
                                    .Fields("TotalIVANoDiscriminado").Value = 0

                                    If Len(mObservaciones) > 2 Then .Fields("Observaciones").Value = mObservaciones
                                    If mIncrementarReferencia <> "SI" Then
                                        .Fields("AutoincrementarNumeroReferencia").Value = "NO"
                                    End If

                                End With

                                .Guardar
                            End With

                            Set oCP = Nothing
                  
                            '                     If BuscarClaveINI("IncrementarReferenciaEnImportacionDeComprobantes") = "SI" Then
                            '                        Set oPar = oAp.Parametros.Item(1)
                            '                        oPar.Registro.Fields("ProximoComprobanteProveedorReferencia").Value = mNumeroReferencia + 1
                            '                        oPar.Guardar
                            '                        Set oPar = Nothing
                            '                     End If
                     
                            mNumeroReferencia = mNumeroReferencia + 1
                     
                        Else
                  
                            fl = fl + 1
                     
                        End If

                        oRsAux1.Close
                    Else
                        Exit Do
                    End If

                Loop

            End With

            .Close False
        End With

        .Quit
    End With
   
Salida:

    Unload oF
    Set oF = Nothing

    Set oRsAux1 = Nothing
    Set oRsAux2 = Nothing
    Set oAp = Nothing
    Set oEx = Nothing
    Set oCP = Nothing

    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub ImportacionComprobantesFondoFijo()

    Dim oAp As ComPronto.Aplicacion
    Dim oCP As ComPronto.ComprobanteProveedor
    Dim oPr As ComPronto.Proveedor
    Dim oPar As ComPronto.Parametro
    Dim oOP As ComPronto.OrdenPago
    Dim oRsAux1 As ADOR.Recordset
    Dim oRsAux2 As ADOR.Recordset
    Dim oF As Form
    Dim oEx As Excel.Application
    Dim mOk As Boolean, mConProblemas As Boolean
    Dim mArchivo As String, mComprobante As String, mCuit As String, mLetra As String
    Dim mBienesOServicios As String, mObservaciones As String, mRazonSocial As String
    Dim mIncrementarReferencia As String, mCondicionCompra As String
    Dim mNumeroCAI As String, mFecha1 As String, mError As String
    Dim mInformacionAuxiliar As String, mCuitDefault As String
    Dim mFechaFactura As Date, mFechaVencimientoCAI As Date, mFechaRecepcion As Date
    Dim mIdMonedaPesos As Integer, mIdTipoComprobanteFacturaCompra As Integer
    Dim mIdUnidadPorUnidad As Integer, fl As Integer, mContador As Integer
    Dim mIdCuentaIvaCompras1 As Integer, mIdCuenta As Long, mIdObra As Integer
    Dim mIdCuentaGasto As Integer, i As Integer, mvarProvincia As Integer
    Dim mvarIBCondicion As Integer, mvarIdIBCondicion As Integer, mIdEtapa As Integer
    Dim mvarIGCondicion As Integer, mvarIdTipoRetencionGanancia As Integer
    Dim mIdTipoComprobante As Integer, mIdCuentaFF As Integer, mIdUO As Integer
    Dim mIdCodigoIva As Integer
    Dim mIdProveedor As Long, mNumeroComprobante1 As Long, mNumeroComprobante2 As Long
    Dim mCodigoCuenta As Long, mNumeroReferencia As Long, mCodigoCuentaFF As Long
    Dim mNumeroOP As Long, mIdOrdenPago As Long, mAux1 As Long, mAux2 As Long
    Dim mNumeroRendicion As Long
    Dim mvarCotizacionDolar As Single, mPorcentajeIVA As Single
    Dim mBruto As Double, mIva1 As Double, mTotalItem As Double, mPercepcion As Double
    Dim mTotalBruto As Double, mTotalIva1 As Double, mTotalComprobante As Double
    Dim mTotalPercepcion As Double, mValores As Double, mAjusteIVA As Double
    Dim mTotalAjusteIVA As Double
    Dim mIdCuentaIvaCompras(10) As Long
    Dim mIVAComprasPorcentaje(10) As Single

    On Error GoTo Mal

    'Set oF = New frmPathPresto
    With oF
        .Id = 2
        .Show vbModal
        mOk = .Ok

        If mOk Then
            mArchivo = .FileBrowser1(0).Text
            mIdObra = .dcfields(0).BoundText
            mFechaRecepcion = .DTFields(0).Value
            mNumeroReferencia = Val(.text1.Text)
        End If

    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub

    Set oAp = Aplicacion

    mIncrementarReferencia = BuscarClaveINI("IncrementarReferenciaEnImportacionDeComprobantes")
    mCondicionCompra = BuscarClaveINI("Condicion de compra default para fondos fijos")
    mFecha1 = BuscarClaveINI("Fecha recepcion igual fecha comprobante en fondo fijo")
    mCuitDefault = BuscarClaveINI("Cuit por defecto en la importacion de fondos fijos")
   
    Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
    mIdMonedaPesos = oRsAux1.Fields("IdMoneda").Value
    mIdTipoComprobanteFacturaCompra = oRsAux1.Fields("IdTipoComprobanteFacturaCompra").Value
    mIdUnidadPorUnidad = IIf(IsNull(oRsAux1.Fields("IdUnidadPorUnidad").Value), 0, oRsAux1.Fields("IdUnidadPorUnidad").Value)
    gblFechaUltimoCierre = IIf(IsNull(oRsAux1.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), oRsAux1.Fields("FechaUltimoCierre").Value)

    For i = 1 To 10

        If Not IsNull(oRsAux1.Fields("IdCuentaIvaCompras" & i).Value) Then
            mIdCuentaIvaCompras(i) = oRsAux1.Fields("IdCuentaIvaCompras" & i).Value
            mIVAComprasPorcentaje(i) = oRsAux1.Fields("IVAComprasPorcentaje" & i).Value
        Else
            mIdCuentaIvaCompras(i) = 0
            mIVAComprasPorcentaje(i) = 0
        End If

    Next

    oRsAux1.Close
   
    mIdUO = 0
    Set oRsAux1 = oAp.Obras.TraerFiltrado("_PorId", mIdObra)

    If oRsAux1.RecordCount > 0 Then
        mIdUO = IIf(IsNull(oRsAux1.Fields("IdUnidadOperativa").Value), 0, oRsAux1.Fields("IdUnidadOperativa").Value)
    End If

    oRsAux1.Close
   
    'Set oF = New frmAviso
    With oF
        .Label1 = "Iniciando EXCEL ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Procesando fondo fijo ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    fl = 7
    mContador = 0
    mNumeroRendicion = 0
   
    Set oEx = CreateObject("Excel.Application")

    With oEx
      
        .Visible = True
        .WindowState = xlMinimized
        Me.Refresh
      
        With .Workbooks.Open(mArchivo)
            .Sheets("FF").Select

            With .ActiveSheet

                Do While True

                    If Len(Trim(.Cells(fl, 2))) > 0 Then
                        mConProblemas = False
                  
                        If mNumeroRendicion = 0 And IsNumeric(.Cells(2, 13)) Then
                            mNumeroRendicion = .Cells(2, 13)
                        End If
                  
                        mContador = mContador + 1
                        oF.Label2 = "Comprobante : " & .Cells(fl, 5)
                        oF.Label3 = "" & mContador

                        DoEvents
               
                        If Len(.Cells(fl, 3)) > 0 Then
                            mIdTipoComprobante = .Cells(fl, 3)
                        Else
                            mIdTipoComprobante = mIdTipoComprobanteFacturaCompra
                        End If

                        mLetra = Trim(.Cells(fl, 4))
                        mComprobante = .Cells(fl, 5)
                        mNumeroComprobante1 = 0
                        mNumeroComprobante2 = 0

                        If InStr(1, mComprobante, "-") <> 0 Then
                            mNumeroComprobante1 = CLng(mId(mComprobante, 1, InStr(1, mComprobante, "-") - 1))

                            If mNumeroComprobante1 > 9999 Then
                                MsgBox "El punto de venta no puede tener mas de 4 digitos. (Fila " & fl & ")", vbExclamation
                                GoTo Salida
                            End If

                            mNumeroComprobante2 = CLng(mId(mComprobante, InStr(1, mComprobante, "-") + 1, 100))

                            If mNumeroComprobante2 > 99999999 Then
                                MsgBox "El numero de comprobante no puede tener mas de 8 digitos. (Fila " & fl & ")", vbExclamation
                                GoTo Salida
                            End If
                        End If

                        mRazonSocial = .Cells(fl, 6)
                        mCuit = .Cells(fl, 7)
                        mFechaFactura = CDate(.Cells(fl, 2))
                        mNumeroCAI = .Cells(fl, 15)

                        If IsDate(.Cells(fl, 17)) Then
                            mFechaVencimientoCAI = CDate(.Cells(fl, 17))
                        Else
                            mFechaVencimientoCAI = 0
                        End If

                        mInformacionAuxiliar = .Cells(fl, 18)
                  
                        If mFecha1 = "SI" Then mFechaRecepcion = mFechaFactura
                  
                        If mFechaRecepcion > gblFechaUltimoCierre Then
                            If Len(mCuit) = 0 Then mCuit = mCuitDefault
                            If Len(mCuit) = 0 Then
                                mError = mError & vbCrLf & "Fila " & fl & "  - Cuit inexistente"
                                fl = fl + 1
                                GoTo FinLoop
                            Else

                                If Not VerificarCuit(mCuit) Then
                                    mError = mError & vbCrLf & "Fila " & fl & "  - Cuit invalido : " & mCuit
                                    fl = fl + 1
                                    GoTo FinLoop
                                End If
                            End If

                            mIdProveedor = 0
                            Set oRsAux1 = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)

                            If oRsAux1.RecordCount > 0 Then
                                mIdProveedor = oRsAux1.Fields(0).Value
                                mvarProvincia = IIf(IsNull(oRsAux1.Fields("IdProvincia").Value), 0, oRsAux1.Fields("IdProvincia").Value)
                                mvarIBCondicion = IIf(IsNull(oRsAux1.Fields("IBCondicion").Value), 0, oRsAux1.Fields("IBCondicion").Value)
                                mvarIdIBCondicion = IIf(IsNull(oRsAux1.Fields("IdIBCondicionPorDefecto").Value), 0, oRsAux1.Fields("IdIBCondicionPorDefecto").Value)
                                mvarIGCondicion = IIf(IsNull(oRsAux1.Fields("IGCondicion").Value), 0, oRsAux1.Fields("IGCondicion").Value)
                                mvarIdTipoRetencionGanancia = IIf(IsNull(oRsAux1.Fields("IdTipoRetencionGanancia").Value), 0, oRsAux1.Fields("IdTipoRetencionGanancia").Value)
                                mBienesOServicios = IIf(IsNull(oRsAux1.Fields("BienesOServicios").Value), "B", oRsAux1.Fields("BienesOServicios").Value)
                                mIdCodigoIva = IIf(IsNull(oRsAux1.Fields("IdCodigoIva").Value), 0, oRsAux1.Fields("IdCodigoIva").Value)
                            Else

                                If mLetra = "B" Or mLetra = "C" Then
                                    mIdCodigoIva = 0
                                Else
                                    mIdCodigoIva = 1
                                End If

                                Set oPr = oAp.Proveedores.Item(-1)

                                With oPr.Registro
                                    .Fields("Confirmado").Value = "NO"
                                    .Fields("RazonSocial").Value = mId(mRazonSocial, 1, 50)
                                    .Fields("CUIT").Value = mCuit
                                    .Fields("EnviarEmail").Value = 1

                                    If mIdCodigoIva <> 0 Then .Fields("IdCodigoIva").Value = mIdCodigoIva
                                    If IsNumeric(mCondicionCompra) Then
                                        .Fields("IdCondicionCompra").Value = CInt(mCondicionCompra)
                                    End If

                                End With

                                oPr.Guardar
                                mIdProveedor = oPr.Registro.Fields(0).Value
                                Set oPr = Nothing
                                mvarProvincia = 0
                                mvarIBCondicion = 0
                                mvarIdIBCondicion = 0
                                mvarIGCondicion = 0
                                mvarIdTipoRetencionGanancia = 0
                                mBienesOServicios = "B"
                            End If

                            oRsAux1.Close
                     
                            mCodigoCuentaFF = .Cells(fl, 20)
                            mIdCuentaFF = 0
                            Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuentaFF)

                            If oRsAux1.RecordCount > 0 Then
                                mIdCuentaFF = oRsAux1.Fields(0).Value
                            End If
                  
                            Set oRsAux1 = oAp.ComprobantesProveedores.TraerFiltrado("_PorNumeroComprobante", Array(mIdProveedor, mLetra, mNumeroComprobante1, mNumeroComprobante2, -1, mIdTipoComprobante))

                            If oRsAux1.RecordCount = 0 Then
                                mvarCotizacionDolar = Cotizacion(mFechaFactura, glbIdMonedaDolar)

                                If mvarCotizacionDolar = 0 Then
                                    mConProblemas = True
                                End If

                                Set oCP = oAp.ComprobantesProveedores.Item(-1)

                                With oCP
                                    With .Registro
                                        .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                                        .Fields("IdObra").Value = mIdObra
                                        .Fields("FechaComprobante").Value = mFechaFactura
                                        .Fields("FechaRecepcion").Value = mFechaRecepcion
                                        .Fields("FechaVencimiento").Value = mFechaFactura
                                        .Fields("IdMoneda").Value = mIdMonedaPesos
                                        .Fields("CotizacionMoneda").Value = 1
                                        .Fields("CotizacionDolar").Value = mvarCotizacionDolar
                                        .Fields("IdProveedorEventual").Value = mIdProveedor
                                        .Fields("IdProveedor").Value = Null
                                        .Fields("IdCuenta").Value = mIdCuentaFF
                                        .Fields("IdOrdenPago").Value = Null ' -9
                                        .Fields("Letra").Value = mLetra
                                        .Fields("NumeroComprobante1").Value = mNumeroComprobante1
                                        .Fields("NumeroComprobante2").Value = mNumeroComprobante2
                                        .Fields("NumeroRendicionFF").Value = mNumeroRendicion

                                        If (mvarIBCondicion = 2 Or mvarIBCondicion = 3) And mvarIdIBCondicion <> 0 Then
                                            .Fields("IdIBCondicion").Value = mvarIdIBCondicion
                                        Else
                                            .Fields("IdIBCondicion").Value = Null
                                        End If

                                        If (mvarIGCondicion = 2 Or mvarIGCondicion = 3) And mvarIdTipoRetencionGanancia <> 0 Then
                                            .Fields("IdTipoRetencionGanancia").Value = mvarIdTipoRetencionGanancia
                                        Else
                                            .Fields("IdTipoRetencionGanancia").Value = Null
                                        End If

                                        .Fields("IdProvinciaDestino").Value = mvarProvincia
                                        .Fields("BienesOServicios").Value = Null
                                        .Fields("NumeroCAI").Value = mNumeroCAI

                                        If mFechaVencimientoCAI <> 0 Then
                                            .Fields("FechaVencimientoCAI").Value = mFechaVencimientoCAI
                                        Else
                                            .Fields("FechaVencimientoCAI").Value = Null
                                        End If

                                        .Fields("DestinoPago").Value = "O"
                                        .Fields("InformacionAuxiliar").Value = mInformacionAuxiliar

                                        If mIdCodigoIva <> 0 Then .Fields("IdCodigoIva").Value = mIdCodigoIva
                                    End With
                                End With
                        
                                mTotalBruto = 0
                                mTotalIva1 = 0
                                mTotalPercepcion = 0
                                mTotalComprobante = 0
                                mTotalAjusteIVA = 0
                                mObservaciones = ""

                                Do While Len(Trim(.Cells(fl, 2))) > 0 And mComprobante = .Cells(fl, 5) And (mCuit = .Cells(fl, 7) Or mCuit = mCuitDefault)
   
                                    mCodigoCuenta = CLng(.Cells(fl, 9))
                                    mBruto = Abs(CDbl(.Cells(fl, 10)))
                                    mIva1 = Round(Abs(CDbl(.Cells(fl, 11))), 4)
                                    mPercepcion = Abs(CDbl(.Cells(fl, 12)))
                                    mTotalItem = Round(Abs(CDbl(.Cells(fl, 13))), 2)
                                    mObservaciones = mObservaciones & .Cells(fl, 19) & vbCrLf
                                    mAjusteIVA = 0

                                    If Len(.Cells(5, 24)) > 0 Then
                                        mAjusteIVA = CDbl(.Cells(fl, 24))
                                    End If

                                    mAux1 = 0

                                    If Len(.Cells(fl, 25)) > 0 And IsNumeric(.Cells(fl, 25)) Then
                                        mAux1 = CLng(.Cells(fl, 25))
                                    End If
                           
                                    mTotalBruto = mTotalBruto + mBruto
                                    mTotalIva1 = mTotalIva1 + mIva1
                                    mTotalPercepcion = mTotalPercepcion + mPercepcion
                                    mTotalComprobante = mTotalComprobante + mTotalItem
                                    mTotalAjusteIVA = mTotalAjusteIVA + mAjusteIVA
                           
                                    mPorcentajeIVA = 0

                                    If mIva1 <> 0 And mBruto <> 0 Then
                                        mPorcentajeIVA = Round(mIva1 / mBruto * 100, 1)
                                    End If
                           
                                    mIdCuentaIvaCompras1 = 0

                                    If mPorcentajeIVA <> 0 Then

                                        For i = 1 To 10

                                            If mIVAComprasPorcentaje(i) = mPorcentajeIVA Then
                                                mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(i)
                                                Exit For
                                            End If

                                        Next

                                    End If

                                    If mTotalIva1 <> 0 And mIdCuentaIvaCompras1 = 0 Then
                                        mConProblemas = True
                                    End If
                           
                                    mIdCuenta = 0
                                    mIdCuentaGasto = 0

                                    If mCodigoCuenta > 1000 Then
                                        Set oRsAux2 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuenta)

                                        If oRsAux2.RecordCount > 0 Then
                                            mIdCuenta = oRsAux2.Fields(0).Value

                                            If IsNumeric(.Cells(fl, 23)) And Not IsNull(oRsAux2.Fields("IdObra").Value) Then
                                                mIdObra = oRsAux2.Fields("IdObra").Value
                                            End If
                                        End If

                                    Else
                                        Set oRsAux2 = oAp.CuentasGastos.TraerFiltrado("_PorId", mCodigoCuenta)

                                        If oRsAux2.RecordCount > 0 Then
                                            mIdCuentaGasto = oRsAux2.Fields(0).Value
                                        End If
                                    End If

                                    oRsAux2.Close

                                    If mIdCuentaGasto = 0 And mIdCuenta = 0 Then
                                        mConProblemas = True
                                    End If

                                    If mIdCuenta = 0 Then
                                        Set oRsAux2 = oAp.Cuentas.TraerFiltrado("_PorObraCuentaGasto", Array(mIdObra, mIdCuentaGasto))

                                        If oRsAux2.RecordCount > 0 Then
                                            mIdCuenta = oRsAux2.Fields(0).Value
                                            mCodigoCuenta = oRsAux2.Fields("Codigo").Value
                                        End If

                                        oRsAux2.Close

                                        If mIdCuentaGasto = 0 Then
                                            mConProblemas = True
                                        End If
                                    End If
                           
                                    mAux2 = 0

                                    If mAux1 <> 0 Then
                                        Set oRsAux2 = oAp.RubrosContables.TraerFiltrado("_PorCodigo", mAux1)

                                        If oRsAux2.RecordCount > 0 Then
                                            mAux2 = oRsAux2.Fields(0).Value
                                        End If

                                        oRsAux2.Close
                                    End If
                           
                                    With oCP.DetComprobantesProveedores.Item(-1)
                                        With .Registro
                                            .Fields("IdObra").Value = mIdObra
                                            .Fields("IdCuentaGasto").Value = mIdCuentaGasto
                                            .Fields("IdCuenta").Value = mIdCuenta
                                            .Fields("CodigoCuenta").Value = mCodigoCuenta
                                            .Fields("Importe").Value = mBruto

                                            If mIdCuentaIvaCompras1 <> 0 Then
                                                .Fields("IdCuentaIvaCompras1").Value = mIdCuentaIvaCompras1
                                                .Fields("IVAComprasPorcentaje1").Value = mPorcentajeIVA
                                                .Fields("ImporteIVA1").Value = Round(mIva1, 2)
                                                .Fields("AplicarIVA1").Value = "SI"
                                            Else
                                                .Fields("IdCuentaIvaCompras1").Value = Null
                                                .Fields("IVAComprasPorcentaje1").Value = 0
                                                .Fields("ImporteIVA1").Value = 0
                                                .Fields("AplicarIVA1").Value = "NO"
                                            End If

                                            .Fields("IdCuentaIvaCompras2").Value = Null
                                            .Fields("IVAComprasPorcentaje2").Value = 0
                                            .Fields("ImporteIVA2").Value = 0
                                            .Fields("AplicarIVA2").Value = "NO"
                                            .Fields("IdCuentaIvaCompras3").Value = Null
                                            .Fields("IVAComprasPorcentaje3").Value = 0
                                            .Fields("ImporteIVA3").Value = 0
                                            .Fields("AplicarIVA3").Value = "NO"
                                            .Fields("IdCuentaIvaCompras4").Value = Null
                                            .Fields("IVAComprasPorcentaje4").Value = 0
                                            .Fields("ImporteIVA4").Value = 0
                                            .Fields("AplicarIVA4").Value = "NO"
                                            .Fields("IdCuentaIvaCompras5").Value = Null
                                            .Fields("IVAComprasPorcentaje5").Value = 0
                                            .Fields("ImporteIVA5").Value = 0
                                            .Fields("AplicarIVA5").Value = "NO"
                                            .Fields("IdCuentaIvaCompras6").Value = Null
                                            .Fields("IVAComprasPorcentaje6").Value = 0
                                            .Fields("ImporteIVA6").Value = 0
                                            .Fields("AplicarIVA6").Value = "NO"
                                            .Fields("IdCuentaIvaCompras7").Value = Null
                                            .Fields("IVAComprasPorcentaje7").Value = 0
                                            .Fields("ImporteIVA7").Value = 0
                                            .Fields("AplicarIVA7").Value = "NO"
                                            .Fields("IdCuentaIvaCompras8").Value = Null
                                            .Fields("IVAComprasPorcentaje8").Value = 0
                                            .Fields("ImporteIVA8").Value = 0
                                            .Fields("AplicarIVA8").Value = "NO"
                                            .Fields("IdCuentaIvaCompras9").Value = Null
                                            .Fields("IVAComprasPorcentaje9").Value = 0
                                            .Fields("ImporteIVA9").Value = 0
                                            .Fields("AplicarIVA9").Value = "NO"
                                            .Fields("IdCuentaIvaCompras10").Value = Null
                                            .Fields("IVAComprasPorcentaje10").Value = 0
                                            .Fields("ImporteIVA10").Value = 0
                                            .Fields("AplicarIVA10").Value = "NO"

                                            If mAux2 <> 0 Then
                                                .Fields("IdRubroContable").Value = mAux2
                                            End If

                                        End With

                                        .Modificado = True
                                    End With
                        
                                    fl = fl + 1
                                Loop
                        
                                With oCP
                                    With .Registro
                                        .Fields("NumeroReferencia").Value = mNumeroReferencia
                                        '                           If mConProblemas Then
                                        .Fields("Confirmado").Value = "NO"
                                        '                           Else
                                        '                              .Fields("Confirmado").Value = "SI"
                                        '                           End If
                                        .Fields("TotalBruto").Value = mTotalBruto
                                        .Fields("TotalIva1").Value = mTotalIva1
                                        .Fields("TotalIva2").Value = 0
                                        .Fields("TotalBonificacion").Value = 0
                                        .Fields("TotalComprobante").Value = mTotalComprobante
                                        .Fields("PorcentajeBonificacion").Value = 0
                                        .Fields("TotalIVANoDiscriminado").Value = 0
                                        .Fields("AjusteIVA").Value = mTotalAjusteIVA

                                        If Len(mObservaciones) > 2 Then .Fields("Observaciones").Value = mObservaciones
                                        If mIncrementarReferencia <> "SI" Then
                                            .Fields("AutoincrementarNumeroReferencia").Value = "NO"
                                        End If

                                    End With

                                    .Guardar
                                End With

                                Set oCP = Nothing
                     
                                '                     If BuscarClaveINI("IncrementarReferenciaEnImportacionDeComprobantes") = "SI" Then
                                '                        Set oPar = oAp.Parametros.Item(1)
                                '                        oPar.Registro.Fields("ProximoComprobanteProveedorReferencia").Value = mNumeroReferencia + 1
                                ''                        oPar.Registro.Fields("ProximaOrdenPago").Value = mNumeroOP + 1
                                '                        oPar.Guardar
                                '                        Set oPar = Nothing
                                '                     End If
                        
                                mNumeroReferencia = mNumeroReferencia + 1
                            Else
                                fl = fl + 1
                            End If

                            oRsAux1.Close
                        Else
                            mError = mError & vbCrLf & "Fila " & fl & "  - Fecha es anterior al ultimo cierre contable : " & mComprobante
                            fl = fl + 1
                        End If

                    Else
                        Exit Do
                    End If

FinLoop:
                Loop
         
                '            'REGISTRAR OP CONTRA COMPROBANTES DE FONDO FIJO
                '            Set oPar = oAp.Parametros.Item(1)
                '            mNumeroOP = oPar.Registro.Fields("ProximaOrdenPago").Value
                '
                '            Set oOP = oAp.OrdenesPago.Item(-1)
                '            With oOP
                '               With .Registro
                '                  .Fields("NumeroOrdenPago").Value = mNumeroOP
                '                  .Fields("FechaOrdenPago").Value = mFechaRecepcion
                '                  .Fields("IdProveedor").Value = Null
                '                  .Fields("IdCuenta").Value = mIdCuentaFF
                '                  .Fields("IdMoneda").Value = mIdMonedaPesos
                '                  .Fields("CotizacionMoneda").Value = 1
                '                  .Fields("CotizacionDolar").Value = mvarCotizacionDolar
                '                  .Fields("IdObraOrigen").Value = mIdObra
                '                  .Fields("Tipo").Value = "FF"
                '                  .Fields("Dolarizada").Value = "NO"
                '                  .Fields("Exterior").Value = "NO"
                '                  .Fields("AsientoManual").Value = "NO"
                '                  .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                '                  .Fields("FechaIngreso").Value = Now
                '                  .Fields("Observaciones").Value = mObservaciones
                '                  .Fields("BaseGanancias").Value = Null
                '                  .Fields("RetencionIVA").Value = Null
                '                  .Fields("RetencionGanancias").Value = Null
                '                  .Fields("RetencionIBrutos").Value = Null
                '                  .Fields("RetencionSUSS").Value = Null
                '               End With
                '            End With
                '
                '            mValores = 0
                '            Set oRsAux1 = oAp.ComprobantesProveedores.TraerFiltrado("_PorIdOrdenPago", -9)
                '            With oRsAux1
                '               If .RecordCount > 0 Then
                '                  Do While Not .EOF
                '                     mValores = mValores + .Fields("TotalComprobante").Value
                '                     .MoveNext
                '                  Loop
                '               End If
                '            End With
                '
                '            'VALORES
                '            With oOP.DetOrdenesPagoValores.Item(-1)
                '               With .Registro
                '                  .Fields("IdTipoValor").Value = 33
                '                  .Fields("Importe").Value = mValores
                '                  .Fields("IdCaja").Value = mIdCuentaFF
                '               End With
                '               .Modificado = True
                '            End With
                '
                '            With oOP
                '               With .Registro
                '                  .Fields("Confirmado").Value = "NO"
                '                  .Fields("Valores").Value = mValores
                '                  .Fields("Acreedores").Value = 0
                '               End With
                '               .Guardar
                '               mIdOrdenPago = .Registro.Fields(0).Value
                '            End With
                '            Set oOP = Nothing
                '
                '            With oPar.Registro
                '               .Fields("ProximaOrdenPago").Value = mNumeroOP + 1
                '            End With
                '            oPar.Guardar
                '            Set oPar = Nothing
                '
                '            With oRsAux1
                '               If .RecordCount > 0 Then
                '                  Do While Not .EOF
                '                     Set oCP = oAp.ComprobantesProveedores.Item(.Fields(0).Value)
                '                     oCP.Registro.Fields("IdOrdenPago").Value = mIdOrdenPago
                '                     oCP.Guardar
                '                     .MoveNext
                '                  Loop
                '               End If
                '               .Close
                '            End With
                '            Set oRsAux1 = Nothing
         
            End With

            .Close False
        End With

        .Quit
    End With
   
    If Len(mError) > 0 Then
        MsgBox "Los siguientes comprobantes no se importaron porque" & vbCrLf & mError, vbExclamation
    End If

Salida:

    Unload oF
    Set oF = Nothing

    Set oRsAux1 = Nothing
    Set oRsAux2 = Nothing
    Set oAp = Nothing
    Set oEx = Nothing
    Set oCP = Nothing
    Set oOP = Nothing

    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub ImportacionComprobantesFondoFijo1()

    Dim oAp As ComPronto.Aplicacion
    Dim oCP As ComPronto.ComprobanteProveedor
    Dim oPr As ComPronto.Proveedor
    Dim oPar As ComPronto.Parametro
    Dim oOP As ComPronto.OrdenPago
    Dim oRsAux1 As ADOR.Recordset
    Dim oRsAux2 As ADOR.Recordset
    Dim oF As Form
    Dim oEx As Excel.Application
    Dim mOk As Boolean, mConProblemas As Boolean
    Dim mArchivo As String, mComprobante As String, mCuit As String, mLetra As String
    Dim mBienesOServicios As String, mObservaciones As String, mRazonSocial As String
    Dim mIncrementarReferencia As String, mCondicionCompra As String, mCodProv As String
    Dim mNumeroCAI As String, mFecha1 As String, mError As String, mCodObra As String
    Dim mInformacionAuxiliar As String, mCuitDefault As String
    Dim mFechaFactura As Date, mFechaVencimientoCAI As Date, mFechaRecepcion As Date
    Dim mIdMonedaPesos As Integer, mIdTipoComprobanteFacturaCompra As Integer
    Dim mIdUnidadPorUnidad As Integer, fl As Integer, mContador As Integer
    Dim mIdCuentaIvaCompras1 As Integer, mIdCuentaGasto As Integer, i As Integer
    Dim mvarProvincia As Integer, mIdTipoComprobante As Integer, mIdCuentaFF As Integer
    Dim mIdUO As Integer, mIdCodigoIva As Integer
    Dim mIdProveedor As Long, mNumeroComprobante1 As Long, mNumeroComprobante2 As Long
    Dim mCodigoCuenta As Long, mNumeroReferencia As Long, mCodigoCuentaFF As Long
    Dim mNumeroOP As Long, mIdOrdenPago As Long, mAux1 As Long, mAux2 As Long
    Dim mNumeroRendicion As Long, mIdCuenta As Long, mIdCuenta1 As Long, mIdObra As Long
    Dim mCodigoCuenta1 As Long
    Dim mvarCotizacionDolar As Single, mPorcentajeIVA As Single
    Dim mTotalItem As Double, mIva1 As Double, mGravado As Double, mNoGravado As Double
    Dim mTotalBruto As Double, mTotalIva1 As Double, mTotalComprobante As Double
    Dim mIdCuentaIvaCompras(10) As Long
    Dim mIVAComprasPorcentaje(10) As Single

    On Error GoTo Mal

    'Set oF = New frmPathPresto
    With oF
        .Id = 14
        .Show vbModal
        mOk = .Ok

        If mOk Then
            mArchivo = .FileBrowser1(0).Text
            mFechaRecepcion = .DTFields(0).Value
            mNumeroReferencia = Val(.text1.Text)
        End If

    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub

    Set oAp = Aplicacion

    mIncrementarReferencia = BuscarClaveINI("IncrementarReferenciaEnImportacionDeComprobantes")
    mCondicionCompra = BuscarClaveINI("Condicion de compra default para fondos fijos")
    mFecha1 = BuscarClaveINI("Fecha recepcion igual fecha comprobante en fondo fijo")
    mCuitDefault = BuscarClaveINI("Cuit por defecto en la importacion de fondos fijos")
   
    Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
    mIdMonedaPesos = oRsAux1.Fields("IdMoneda").Value
    mIdTipoComprobanteFacturaCompra = oRsAux1.Fields("IdTipoComprobanteFacturaCompra").Value
    mIdUnidadPorUnidad = IIf(IsNull(oRsAux1.Fields("IdUnidadPorUnidad").Value), 0, oRsAux1.Fields("IdUnidadPorUnidad").Value)
    gblFechaUltimoCierre = IIf(IsNull(oRsAux1.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), oRsAux1.Fields("FechaUltimoCierre").Value)

    For i = 1 To 10

        If Not IsNull(oRsAux1.Fields("IdCuentaIvaCompras" & i).Value) Then
            mIdCuentaIvaCompras(i) = oRsAux1.Fields("IdCuentaIvaCompras" & i).Value
            mIVAComprasPorcentaje(i) = oRsAux1.Fields("IVAComprasPorcentaje" & i).Value
        Else
            mIdCuentaIvaCompras(i) = 0
            mIVAComprasPorcentaje(i) = 0
        End If

    Next

    oRsAux1.Close
   
    mIdUO = 0
    Set oRsAux1 = oAp.Obras.TraerFiltrado("_PorId", mIdObra)

    If oRsAux1.RecordCount > 0 Then
        mIdUO = IIf(IsNull(oRsAux1.Fields("IdUnidadOperativa").Value), 0, oRsAux1.Fields("IdUnidadOperativa").Value)
    End If

    oRsAux1.Close
   
    'Set oF = New frmAviso
    With oF
        .Label1 = "Iniciando EXCEL ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Procesando fondo fijo ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    fl = 11
    mContador = 0
    mNumeroRendicion = 0
    mTotalBruto = 0
    mTotalIva1 = 0
    mTotalComprobante = 0
   
    Set oEx = CreateObject("Excel.Application")

    With oEx
        .Visible = True
        .WindowState = xlMinimized
        Me.Refresh
      
        With .Workbooks.Open(mArchivo)

            '.Sheets("FF").Select
            With .ActiveSheet
                mFechaFactura = CDate(.Cells(2, 13))
                mObservaciones = .Cells(6, 12)
                mCodProv = .Cells(4, 10)
                mCodObra = .Cells(4, 14)
                mNumeroComprobante2 = CLng(Year(mFechaFactura) & Format(Month(mFechaFactura), "00") & Format(Day(mFechaFactura), "00"))
            
                mIdProveedor = 0
                Set oRsAux1 = oAp.Proveedores.TraerFiltrado("_PorCodigoEmpresa", mCodProv)

                If oRsAux1.RecordCount > 0 Then
                    mIdProveedor = IIf(IsNull(oRsAux1.Fields("IdProveedor").Value), 0, oRsAux1.Fields("IdProveedor").Value)
                    mIdCodigoIva = IIf(IsNull(oRsAux1.Fields("IdCodigoIva").Value), 0, oRsAux1.Fields("IdCodigoIva").Value)
                End If

                oRsAux1.Close

                If mIdProveedor = 0 Then
                    MsgBox "Proveedor inexistente (Codigo " & mCodProv & ")", vbExclamation
                    GoTo Salida
                End If
            
                mIdObra = 0
                mIdCuentaFF = 0
                Set oRsAux1 = oAp.Obras.TraerFiltrado("_PorNumero", mCodObra)

                If oRsAux1.RecordCount > 0 Then
                    mIdObra = IIf(IsNull(oRsAux1.Fields("IdObra").Value), 0, oRsAux1.Fields("IdObra").Value)
                    mIdCuentaFF = IIf(IsNull(oRsAux1.Fields("IdCuentaContableFF").Value), 0, oRsAux1.Fields("IdCuentaContableFF").Value)
                End If

                oRsAux1.Close

                If mIdObra = 0 Then
                    MsgBox "Obra inexistente (Codigo " & mCodObra & ")", vbExclamation
                    GoTo Salida
                End If

                If mIdCuentaFF = 0 Then
                    MsgBox "Cuenta de fondo fijo obra " & mCodObra & ", inexistente", vbExclamation
                    GoTo Salida
                End If
            
                If mFechaFactura <= gblFechaUltimoCierre Then
                    MsgBox "La fecha del fondo fijo es anterior a la fecha de cierre contable", vbExclamation
                    GoTo Salida
                End If
            
                Set oCP = oAp.ComprobantesProveedores.Item(-1)

                With oCP
                    With .Registro
                        .Fields("NumeroReferencia").Value = mNumeroReferencia
                        .Fields("Confirmado").Value = "NO"
                        .Fields("IdTipoComprobante").Value = mIdTipoComprobanteFacturaCompra
                        .Fields("IdObra").Value = mIdObra
                        .Fields("FechaComprobante").Value = mFechaFactura
                        .Fields("FechaRecepcion").Value = mFechaFactura
                        .Fields("FechaVencimiento").Value = mFechaFactura
                        .Fields("IdMoneda").Value = mIdMonedaPesos
                        .Fields("CotizacionMoneda").Value = 1
                        .Fields("CotizacionDolar").Value = mvarCotizacionDolar
                        .Fields("IdProveedorEventual").Value = mIdProveedor
                        .Fields("IdProveedor").Value = Null
                        .Fields("IdCuenta").Value = mIdCuentaFF
                        .Fields("IdOrdenPago").Value = Null
                        .Fields("Letra").Value = "A"
                        .Fields("NumeroComprobante1").Value = 1
                        .Fields("NumeroComprobante2").Value = mNumeroComprobante2
                        .Fields("NumeroRendicionFF").Value = mNumeroComprobante2
                        .Fields("IdIBCondicion").Value = Null
                        .Fields("IdTipoRetencionGanancia").Value = Null
                        .Fields("BienesOServicios").Value = Null
                        .Fields("NumeroCAI").Value = mNumeroComprobante2
                        .Fields("FechaVencimientoCAI").Value = mFechaFactura
                        .Fields("DestinoPago").Value = "O"

                        If mIdCodigoIva <> 0 Then .Fields("IdCodigoIva").Value = mIdCodigoIva
                    End With
                End With
            
                Do While True

                    If Len(Trim(.Cells(fl, 2))) > 0 Then
                        mConProblemas = False
                  
                        mContador = mContador + 1
                        oF.Label2 = "Comprobante : " & .Cells(fl, 5)
                        oF.Label3 = "" & mContador

                        DoEvents
               
                        mCodigoCuenta = CLng(.Cells(fl, 13))
                        mTotalItem = Round(CDbl(.Cells(fl, 6)), 2)
                        mIva1 = Round(CDbl(.Cells(fl, 8)), 2)
                        mGravado = Round(CDbl(.Cells(fl, 9)), 2)
                        mNoGravado = Round(CDbl(.Cells(fl, 10)), 2)
                        mTotalBruto = mTotalBruto + (mGravado + mNoGravado)
                        mTotalIva1 = mTotalIva1 + mIva1
                        mTotalComprobante = mTotalComprobante + mTotalItem
                  
                        If fl = 11 And mGravado <> 0 Then
                            mPorcentajeIVA = Round(mIva1 / mGravado * 100, 1)
                        Else
                            mPorcentajeIVA = Val(.Cells(fl, 7))
                        End If
                  
                        mIdCuentaIvaCompras1 = 0

                        If mPorcentajeIVA <> 0 Then

                            For i = 1 To 10

                                If mIVAComprasPorcentaje(i) = mPorcentajeIVA Then
                                    mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(i)
                                    Exit For
                                End If

                            Next

                        End If

                        If mIva1 <> 0 And mIdCuentaIvaCompras1 = 0 Then
                            MsgBox "No se encontro la cuenta de iva para el porcentaje " & mPorcentajeIVA, vbExclamation
                            GoTo Salida
                        End If
                     
                        mIdCuenta = 0
                        mIdCuenta1 = 0
                        mIdCuentaGasto = 0
                        mCodigoCuenta1 = 0
                        Set oRsAux2 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuenta)

                        If oRsAux2.RecordCount > 0 Then
                            mIdCuenta = oRsAux2.Fields(0).Value
                        End If

                        oRsAux2.Close
                        Set oRsAux2 = oAp.Cuentas.TraerFiltrado("_PorObraCuentaMadre", Array(mIdObra, mIdCuenta))

                        If oRsAux2.RecordCount > 0 Then
                            mIdCuenta1 = oRsAux2.Fields(0).Value
                            mIdCuentaGasto = IIf(IsNull(oRsAux2.Fields("IdCuentaGasto").Value), 0, oRsAux2.Fields("IdCuentaGasto").Value)
                            mCodigoCuenta1 = IIf(IsNull(oRsAux2.Fields("Codigo").Value), 0, oRsAux2.Fields("Codigo").Value)
                        End If

                        oRsAux2.Close

                        If mIdCuentaGasto = 0 And mIdCuenta1 = 0 Then
                            MsgBox "No se encontro la cuenta contable " & mCodigoCuenta, vbExclamation
                            GoTo Salida
                        End If
                  
                        If mGravado <> 0 Or mIva1 <> 0 Then

                            With oCP.DetComprobantesProveedores.Item(-1)
                                With .Registro
                                    .Fields("IdObra").Value = mIdObra
                                    .Fields("IdCuentaGasto").Value = mIdCuentaGasto
                                    .Fields("IdCuenta").Value = mIdCuenta1
                                    .Fields("CodigoCuenta").Value = mCodigoCuenta1
                                    .Fields("Importe").Value = mGravado

                                    If mIdCuentaIvaCompras1 <> 0 Then
                                        .Fields("IdCuentaIvaCompras1").Value = mIdCuentaIvaCompras1
                                        .Fields("IVAComprasPorcentaje1").Value = mPorcentajeIVA
                                        .Fields("ImporteIVA1").Value = mIva1
                                        .Fields("AplicarIVA1").Value = "SI"
                                    Else
                                        .Fields("IdCuentaIvaCompras1").Value = Null
                                        .Fields("IVAComprasPorcentaje1").Value = 0
                                        .Fields("ImporteIVA1").Value = 0
                                        .Fields("AplicarIVA1").Value = "NO"
                                    End If

                                    .Fields("IdCuentaIvaCompras2").Value = Null
                                    .Fields("IVAComprasPorcentaje2").Value = 0
                                    .Fields("ImporteIVA2").Value = 0
                                    .Fields("AplicarIVA2").Value = "NO"
                                    .Fields("IdCuentaIvaCompras3").Value = Null
                                    .Fields("IVAComprasPorcentaje3").Value = 0
                                    .Fields("ImporteIVA3").Value = 0
                                    .Fields("AplicarIVA3").Value = "NO"
                                    .Fields("IdCuentaIvaCompras4").Value = Null
                                    .Fields("IVAComprasPorcentaje4").Value = 0
                                    .Fields("ImporteIVA4").Value = 0
                                    .Fields("AplicarIVA4").Value = "NO"
                                    .Fields("IdCuentaIvaCompras5").Value = Null
                                    .Fields("IVAComprasPorcentaje5").Value = 0
                                    .Fields("ImporteIVA5").Value = 0
                                    .Fields("AplicarIVA5").Value = "NO"
                                    .Fields("IdCuentaIvaCompras6").Value = Null
                                    .Fields("IVAComprasPorcentaje6").Value = 0
                                    .Fields("ImporteIVA6").Value = 0
                                    .Fields("AplicarIVA6").Value = "NO"
                                    .Fields("IdCuentaIvaCompras7").Value = Null
                                    .Fields("IVAComprasPorcentaje7").Value = 0
                                    .Fields("ImporteIVA7").Value = 0
                                    .Fields("AplicarIVA7").Value = "NO"
                                    .Fields("IdCuentaIvaCompras8").Value = Null
                                    .Fields("IVAComprasPorcentaje8").Value = 0
                                    .Fields("ImporteIVA8").Value = 0
                                    .Fields("AplicarIVA8").Value = "NO"
                                    .Fields("IdCuentaIvaCompras9").Value = Null
                                    .Fields("IVAComprasPorcentaje9").Value = 0
                                    .Fields("ImporteIVA9").Value = 0
                                    .Fields("AplicarIVA9").Value = "NO"
                                    .Fields("IdCuentaIvaCompras10").Value = Null
                                    .Fields("IVAComprasPorcentaje10").Value = 0
                                    .Fields("ImporteIVA10").Value = 0
                                    .Fields("AplicarIVA10").Value = "NO"
                                End With

                                .Modificado = True
                            End With

                        End If

                        If mNoGravado <> 0 Then

                            With oCP.DetComprobantesProveedores.Item(-1)
                                With .Registro
                                    .Fields("IdObra").Value = mIdObra
                                    .Fields("IdCuentaGasto").Value = mIdCuentaGasto
                                    .Fields("IdCuenta").Value = mIdCuenta1
                                    .Fields("CodigoCuenta").Value = mCodigoCuenta1
                                    .Fields("Importe").Value = mNoGravado
                                    .Fields("IdCuentaIvaCompras1").Value = Null
                                    .Fields("IVAComprasPorcentaje1").Value = 0
                                    .Fields("ImporteIVA1").Value = 0
                                    .Fields("AplicarIVA1").Value = "NO"
                                    .Fields("IdCuentaIvaCompras2").Value = Null
                                    .Fields("IVAComprasPorcentaje2").Value = 0
                                    .Fields("ImporteIVA2").Value = 0
                                    .Fields("AplicarIVA2").Value = "NO"
                                    .Fields("IdCuentaIvaCompras3").Value = Null
                                    .Fields("IVAComprasPorcentaje3").Value = 0
                                    .Fields("ImporteIVA3").Value = 0
                                    .Fields("AplicarIVA3").Value = "NO"
                                    .Fields("IdCuentaIvaCompras4").Value = Null
                                    .Fields("IVAComprasPorcentaje4").Value = 0
                                    .Fields("ImporteIVA4").Value = 0
                                    .Fields("AplicarIVA4").Value = "NO"
                                    .Fields("IdCuentaIvaCompras5").Value = Null
                                    .Fields("IVAComprasPorcentaje5").Value = 0
                                    .Fields("ImporteIVA5").Value = 0
                                    .Fields("AplicarIVA5").Value = "NO"
                                    .Fields("IdCuentaIvaCompras6").Value = Null
                                    .Fields("IVAComprasPorcentaje6").Value = 0
                                    .Fields("ImporteIVA6").Value = 0
                                    .Fields("AplicarIVA6").Value = "NO"
                                    .Fields("IdCuentaIvaCompras7").Value = Null
                                    .Fields("IVAComprasPorcentaje7").Value = 0
                                    .Fields("ImporteIVA7").Value = 0
                                    .Fields("AplicarIVA7").Value = "NO"
                                    .Fields("IdCuentaIvaCompras8").Value = Null
                                    .Fields("IVAComprasPorcentaje8").Value = 0
                                    .Fields("ImporteIVA8").Value = 0
                                    .Fields("AplicarIVA8").Value = "NO"
                                    .Fields("IdCuentaIvaCompras9").Value = Null
                                    .Fields("IVAComprasPorcentaje9").Value = 0
                                    .Fields("ImporteIVA9").Value = 0
                                    .Fields("AplicarIVA9").Value = "NO"
                                    .Fields("IdCuentaIvaCompras10").Value = Null
                                    .Fields("IVAComprasPorcentaje10").Value = 0
                                    .Fields("ImporteIVA10").Value = 0
                                    .Fields("AplicarIVA10").Value = "NO"
                                End With

                                .Modificado = True
                            End With

                        End If

                        fl = fl + 1
                    Else
                        Exit Do
                    End If

                Loop

                With oCP
                    With .Registro
                        .Fields("TotalBruto").Value = mTotalBruto
                        .Fields("TotalIva1").Value = mTotalIva1
                        .Fields("TotalIva2").Value = 0
                        .Fields("TotalBonificacion").Value = 0
                        .Fields("TotalComprobante").Value = mTotalComprobante
                        .Fields("PorcentajeBonificacion").Value = 0
                        .Fields("TotalIVANoDiscriminado").Value = 0
                        .Fields("AjusteIVA").Value = 0

                        If Len(mObservaciones) > 2 Then .Fields("Observaciones").Value = mObservaciones
                    End With

                    .Guardar
                End With

                Set oCP = Nothing
            End With

            .Close False
        End With

        .Quit
    End With
   
Salida:

    Unload oF
    Set oF = Nothing

    Set oRsAux1 = Nothing
    Set oRsAux2 = Nothing
    Set oAp = Nothing
    Set oEx = Nothing
    Set oCP = Nothing
    Set oOP = Nothing

    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub ImportacionComprobantesProveedores1()

    Dim oAp As ComPronto.Aplicacion
    Dim oCP As ComPronto.ComprobanteProveedor
    Dim oPr As ComPronto.Proveedor
    Dim oPar As ComPronto.Parametro
    Dim oOP As ComPronto.OrdenPago
    Dim oRsAux1 As ADOR.Recordset
    Dim oRsAux2 As ADOR.Recordset
    Dim oF As Form
    Dim oEx As Excel.Application
    Dim mOk As Boolean, mConProblemas As Boolean
    Dim mArchivo As String, mComprobante As String, mCuit As String, mLetra As String
    Dim mBienesOServicios As String, mObservaciones As String, mRazonSocial As String
    Dim mIncrementarReferencia As String, mError As String, mPrestoDestino As String
    Dim mNumeroCAI As String
    Dim mFechaFactura As Date, mFechaVencimientoCAI As Date, mFechaRecepcion As Date
    Dim mIdMonedaPesos As Integer, mIdTipoComprobanteFacturaCompra As Integer
    Dim mIdUnidadPorUnidad As Integer, fl As Integer, mContador As Integer
    Dim mIdCuentaIvaCompras1 As Integer, mIdCuenta As Long, mIdObra As Integer
    Dim mIdCuentaGasto As Integer, i As Integer, mvarProvincia As Integer
    Dim mvarIBCondicion As Integer, mvarIdIBCondicion As Integer
    Dim mvarIGCondicion As Integer, mvarIdTipoRetencionGanancia As Integer
    Dim mIdTipoComprobante As Integer, mIdCuentaFF As Integer, mIdMoneda As Integer
    Dim mIdProveedor As Long, mNumeroComprobante1 As Long, mNumeroComprobante2 As Long
    Dim mCodigoCuenta As Long, mNumeroReferencia As Long, mCodigoCuentaFF As Long
    Dim mNumeroOP As Long, mIdOrdenPago As Long
    Dim mvarCotizacionDolar As Single, mPorcentajeIVA As Single
    Dim mBruto As Double, mIva1 As Double, mTotalItem As Double, mPercepcion As Double
    Dim mTotalBruto As Double, mTotalIva1 As Double, mTotalComprobante As Double
    Dim mTotalPercepcion As Double, mValores As Double
    Dim mIdCuentaIvaCompras(10) As Long
    Dim mIVAComprasPorcentaje(10) As Single

    On Error GoTo Mal

    'Set oF = New frmPathPresto
    With oF
        .Id = 10
        .Show vbModal
        mOk = .Ok

        If mOk Then
            mArchivo = .FileBrowser1(0).Text
            mNumeroReferencia = Val(.text1.Text)
        End If

    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub

    Set oAp = Aplicacion

    mIncrementarReferencia = BuscarClaveINI("IncrementarReferenciaEnImportacionDeComprobantes")
   
    Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
    mIdMonedaPesos = oRsAux1.Fields("IdMoneda").Value
    mIdTipoComprobanteFacturaCompra = oRsAux1.Fields("IdTipoComprobanteFacturaCompra").Value
    mIdUnidadPorUnidad = oRsAux1.Fields("IdUnidadPorUnidad").Value

    For i = 1 To 10

        If Not IsNull(oRsAux1.Fields("IdCuentaIvaCompras" & i).Value) Then
            mIdCuentaIvaCompras(i) = oRsAux1.Fields("IdCuentaIvaCompras" & i).Value
            mIVAComprasPorcentaje(i) = oRsAux1.Fields("IVAComprasPorcentaje" & i).Value
        Else
            mIdCuentaIvaCompras(i) = 0
            mIVAComprasPorcentaje(i) = 0
        End If

    Next

    oRsAux1.Close
   
    'Set oF = New frmAviso
    With oF
        .Label1 = "Iniciando EXCEL ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Procesando comprobantes ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    fl = 7
    mContador = 0
    mError = ""
   
    Set oEx = CreateObject("Excel.Application")

    With oEx
      
        .Visible = True
        .WindowState = xlMinimized
        Me.Refresh
      
        With .Workbooks.Open(mArchivo)
            .Sheets("PROVEEDORES").Select

            With .ActiveSheet

                Do While True
               
                    If Len(Trim(.Cells(fl, 2))) > 0 Then
                  
                        mConProblemas = False
                  
                        mContador = mContador + 1
                        oF.Label2 = "Comprobante : " & .Cells(fl, 5)
                        oF.Label3 = "" & mContador

                        DoEvents
               
                        mIdObra = 0
                        Set oRsAux1 = oAp.Obras.TraerFiltrado("_PorNumero", LTrim(.Cells(fl, 4)))

                        If oRsAux1.RecordCount > 0 Then
                            mIdObra = oRsAux1.Fields(0).Value
                        End If

                        oRsAux1.Close
                  
                        If Len(.Cells(fl, 5)) > 0 Then
                            mIdTipoComprobante = .Cells(fl, 5)
                        Else
                            mIdTipoComprobante = mIdTipoComprobanteFacturaCompra
                        End If

                        mLetra = .Cells(fl, 6)
                        mComprobante = .Cells(fl, 7)
                        mNumeroComprobante1 = 0
                        mNumeroComprobante2 = 0

                        If InStr(1, mComprobante, "-") <> 0 Then
                            mNumeroComprobante1 = CLng(mId(mComprobante, 1, InStr(1, mComprobante, "-") - 1))

                            If mNumeroComprobante1 > 9999 Then
                                MsgBox "El punto de venta no puede tener mas de 4 digitos. (Fila " & fl & ")", vbExclamation
                                GoTo Salida
                            End If

                            mNumeroComprobante2 = CLng(mId(mComprobante, InStr(1, mComprobante, "-") + 1, 100))

                            If mNumeroComprobante2 > 99999999 Then
                                MsgBox "El numero de comprobante no puede tener mas de 8 digitos. (Fila " & fl & ")", vbExclamation
                                GoTo Salida
                            End If
                        End If

                        mRazonSocial = .Cells(fl, 8)
                        mCuit = .Cells(fl, 9)
                        mFechaFactura = CDate(.Cells(fl, 2))
                        mNumeroCAI = .Cells(fl, 17)

                        If IsDate(.Cells(fl, 19)) Then
                            mFechaVencimientoCAI = CDate(.Cells(fl, 19))
                        Else
                            mFechaVencimientoCAI = 0
                        End If

                        If IsDate(.Cells(fl, 28)) Then
                            mFechaRecepcion = CDate(.Cells(fl, 28))
                        Else
                            mFechaRecepcion = 0
                        End If

                        If Len(.Cells(fl, 27)) = 0 Or Not IsNumeric(.Cells(fl, 27)) Then
                            mIdMoneda = mIdMonedaPesos
                        Else
                            mIdMoneda = CInt(.Cells(fl, 27))
                        End If

                        mPrestoDestino = .Cells(fl, 25)
                  
                        mIdProveedor = 0
                        Set oRsAux1 = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)

                        If oRsAux1.RecordCount > 0 Then
                            mIdProveedor = oRsAux1.Fields(0).Value
                            mvarProvincia = IIf(IsNull(oRsAux1.Fields("IdProvincia").Value), 0, oRsAux1.Fields("IdProvincia").Value)
                            mvarIBCondicion = IIf(IsNull(oRsAux1.Fields("IBCondicion").Value), 0, oRsAux1.Fields("IBCondicion").Value)
                            mvarIdIBCondicion = IIf(IsNull(oRsAux1.Fields("IdIBCondicionPorDefecto").Value), 0, oRsAux1.Fields("IdIBCondicionPorDefecto").Value)
                            mvarIGCondicion = IIf(IsNull(oRsAux1.Fields("IGCondicion").Value), 0, oRsAux1.Fields("IGCondicion").Value)
                            mvarIdTipoRetencionGanancia = IIf(IsNull(oRsAux1.Fields("IdTipoRetencionGanancia").Value), 0, oRsAux1.Fields("IdTipoRetencionGanancia").Value)
                            mBienesOServicios = IIf(IsNull(oRsAux1.Fields("BienesOServicios").Value), "B", oRsAux1.Fields("BienesOServicios").Value)
                        Else
                            mError = mError & vbCrLf & "El proveedor con cuit " & mCuit & ", comprobante " & mComprobante & " no existe."
                            fl = fl + 1
                            GoTo Seguir
                        End If

                        oRsAux1.Close
                  
                        Set oRsAux1 = oAp.ComprobantesProveedores.TraerFiltrado("_PorNumeroComprobante", Array(mIdProveedor, mLetra, mNumeroComprobante1, mNumeroComprobante2, -1, -1))

                        If oRsAux1.RecordCount = 0 Then
                            mvarCotizacionDolar = Cotizacion(mFechaFactura, glbIdMonedaDolar)

                            If mvarCotizacionDolar = 0 Then
                                mConProblemas = True
                            End If

                            Set oCP = oAp.ComprobantesProveedores.Item(-1)

                            With oCP
                                With .Registro
                                    .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                                    .Fields("IdObra").Value = mIdObra
                                    .Fields("FechaComprobante").Value = mFechaFactura
                                    .Fields("FechaRecepcion").Value = mFechaRecepcion
                                    .Fields("FechaVencimiento").Value = mFechaFactura
                                    .Fields("IdMoneda").Value = mIdMoneda
                                    .Fields("CotizacionMoneda").Value = 1
                                    .Fields("CotizacionDolar").Value = mvarCotizacionDolar
                                    .Fields("IdProveedorEventual").Value = Null
                                    .Fields("IdProveedor").Value = mIdProveedor
                                    .Fields("IdCuenta").Value = Null
                                    .Fields("IdOrdenPago").Value = Null ' -9
                                    .Fields("Letra").Value = mLetra
                                    .Fields("NumeroComprobante1").Value = mNumeroComprobante1
                                    .Fields("NumeroComprobante2").Value = mNumeroComprobante2

                                    If (mvarIBCondicion = 2 Or mvarIBCondicion = 3) And mvarIdIBCondicion <> 0 Then
                                        .Fields("IdIBCondicion").Value = mvarIdIBCondicion
                                    Else
                                        .Fields("IdIBCondicion").Value = Null
                                    End If

                                    If (mvarIGCondicion = 2 Or mvarIGCondicion = 3) And mvarIdTipoRetencionGanancia <> 0 Then
                                        .Fields("IdTipoRetencionGanancia").Value = mvarIdTipoRetencionGanancia
                                    Else
                                        .Fields("IdTipoRetencionGanancia").Value = Null
                                    End If

                                    .Fields("IdProvinciaDestino").Value = mvarProvincia
                                    .Fields("BienesOServicios").Value = Null
                                    .Fields("NumeroCAI").Value = mNumeroCAI

                                    If mFechaVencimientoCAI <> 0 Then
                                        .Fields("FechaVencimientoCAI").Value = mFechaVencimientoCAI
                                    Else
                                        .Fields("FechaVencimientoCAI").Value = Null
                                    End If

                                    .Fields("PrestoDestino").Value = mPrestoDestino
                                End With
                            End With
                     
                            mTotalBruto = 0
                            mTotalIva1 = 0
                            mTotalPercepcion = 0
                            mTotalComprobante = 0
                            mObservaciones = ""

                            Do While Len(Trim(.Cells(fl, 2))) > 0 And mComprobante = .Cells(fl, 7) And mCuit = .Cells(fl, 9)

                                mCodigoCuenta = CLng(.Cells(fl, 11))
                                mBruto = Abs(CDbl(.Cells(fl, 12)))
                                mIva1 = Abs(CDbl(.Cells(fl, 13)))
                                mPercepcion = Abs(CDbl(.Cells(fl, 14)))
                                mTotalItem = Abs(CDbl(.Cells(fl, 15)))
                                mObservaciones = mObservaciones & .Cells(fl, 26) & vbCrLf
                        
                                mTotalBruto = mTotalBruto + mBruto
                                mTotalIva1 = mTotalIva1 + mIva1
                                mTotalPercepcion = mTotalPercepcion + mPercepcion
                                mTotalComprobante = mTotalComprobante + mTotalItem
                        
                                mPorcentajeIVA = 0

                                If mIva1 <> 0 And mBruto <> 0 Then
                                    mPorcentajeIVA = Round(mIva1 / mBruto * 100, 1)
                                End If
                        
                                mIdCuentaIvaCompras1 = 0

                                If mPorcentajeIVA <> 0 Then

                                    For i = 1 To 10

                                        If mIVAComprasPorcentaje(i) = mPorcentajeIVA Then
                                            mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(i)
                                            Exit For
                                        End If

                                    Next

                                End If

                                If mTotalIva1 <> 0 And mIdCuentaIvaCompras1 = 0 Then
                                    mConProblemas = True
                                End If
                        
                                mIdCuenta = 0
                                mIdCuentaGasto = 0

                                If mCodigoCuenta > 1000 Then
                                    Set oRsAux2 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuenta)

                                    If oRsAux2.RecordCount > 0 Then
                                        mIdCuenta = oRsAux2.Fields(0).Value
                                    End If

                                Else
                                    Set oRsAux2 = oAp.CuentasGastos.TraerFiltrado("_PorId", mCodigoCuenta)

                                    If oRsAux2.RecordCount > 0 Then
                                        mIdCuentaGasto = oRsAux2.Fields(0).Value
                                    End If
                                End If

                                oRsAux2.Close

                                If mIdCuentaGasto = 0 And mIdCuenta = 0 Then
                                    mConProblemas = True
                                End If

                                If mIdCuenta = 0 Then
                                    Set oRsAux2 = oAp.Cuentas.TraerFiltrado("_PorObraCuentaGasto", Array(mIdObra, mIdCuentaGasto))

                                    If oRsAux2.RecordCount > 0 Then
                                        mIdCuenta = oRsAux2.Fields(0).Value
                                        mCodigoCuenta = oRsAux2.Fields("Codigo").Value
                                    End If

                                    oRsAux2.Close

                                    If mIdCuentaGasto = 0 Then
                                        mConProblemas = True
                                    End If
                                End If
                        
                                With oCP.DetComprobantesProveedores.Item(-1)
                                    With .Registro
                                        .Fields("IdObra").Value = mIdObra
                                        .Fields("IdCuentaGasto").Value = mIdCuentaGasto
                                        .Fields("IdCuenta").Value = mIdCuenta
                                        .Fields("CodigoCuenta").Value = mCodigoCuenta
                                        .Fields("Importe").Value = mBruto

                                        If mIdCuentaIvaCompras1 <> 0 Then
                                            .Fields("IdCuentaIvaCompras1").Value = mIdCuentaIvaCompras1
                                            .Fields("IVAComprasPorcentaje1").Value = mPorcentajeIVA
                                            .Fields("ImporteIVA1").Value = mIva1
                                            .Fields("AplicarIVA1").Value = "SI"
                                        Else
                                            .Fields("IdCuentaIvaCompras1").Value = Null
                                            .Fields("IVAComprasPorcentaje1").Value = 0
                                            .Fields("ImporteIVA1").Value = 0
                                            .Fields("AplicarIVA1").Value = "NO"
                                        End If

                                        .Fields("IdCuentaIvaCompras2").Value = Null
                                        .Fields("IVAComprasPorcentaje2").Value = 0
                                        .Fields("ImporteIVA2").Value = 0
                                        .Fields("AplicarIVA2").Value = "NO"
                                        .Fields("IdCuentaIvaCompras3").Value = Null
                                        .Fields("IVAComprasPorcentaje3").Value = 0
                                        .Fields("ImporteIVA3").Value = 0
                                        .Fields("AplicarIVA3").Value = "NO"
                                        .Fields("IdCuentaIvaCompras4").Value = Null
                                        .Fields("IVAComprasPorcentaje4").Value = 0
                                        .Fields("ImporteIVA4").Value = 0
                                        .Fields("AplicarIVA4").Value = "NO"
                                        .Fields("IdCuentaIvaCompras5").Value = Null
                                        .Fields("IVAComprasPorcentaje5").Value = 0
                                        .Fields("ImporteIVA5").Value = 0
                                        .Fields("AplicarIVA5").Value = "NO"
                                        .Fields("IdCuentaIvaCompras6").Value = Null
                                        .Fields("IVAComprasPorcentaje6").Value = 0
                                        .Fields("ImporteIVA6").Value = 0
                                        .Fields("AplicarIVA6").Value = "NO"
                                        .Fields("IdCuentaIvaCompras7").Value = Null
                                        .Fields("IVAComprasPorcentaje7").Value = 0
                                        .Fields("ImporteIVA7").Value = 0
                                        .Fields("AplicarIVA7").Value = "NO"
                                        .Fields("IdCuentaIvaCompras8").Value = Null
                                        .Fields("IVAComprasPorcentaje8").Value = 0
                                        .Fields("ImporteIVA8").Value = 0
                                        .Fields("AplicarIVA8").Value = "NO"
                                        .Fields("IdCuentaIvaCompras9").Value = Null
                                        .Fields("IVAComprasPorcentaje9").Value = 0
                                        .Fields("ImporteIVA9").Value = 0
                                        .Fields("AplicarIVA9").Value = "NO"
                                        .Fields("IdCuentaIvaCompras10").Value = Null
                                        .Fields("IVAComprasPorcentaje10").Value = 0
                                        .Fields("ImporteIVA10").Value = 0
                                        .Fields("AplicarIVA10").Value = "NO"
                                    End With

                                    .Modificado = True
                                End With
                     
                                fl = fl + 1
                            Loop
                     
                            With oCP
                                With .Registro
                                    .Fields("NumeroReferencia").Value = mNumeroReferencia
                                    .Fields("Confirmado").Value = "NO"
                                    .Fields("TotalBruto").Value = mTotalBruto
                                    .Fields("TotalIva1").Value = mTotalIva1
                                    .Fields("TotalIva2").Value = 0
                                    .Fields("TotalBonificacion").Value = 0
                                    .Fields("TotalComprobante").Value = mTotalComprobante
                                    .Fields("PorcentajeBonificacion").Value = 0
                                    .Fields("TotalIVANoDiscriminado").Value = 0
                                    .Fields("AjusteIVA").Value = 0

                                    If Len(mObservaciones) > 2 Then .Fields("Observaciones").Value = mObservaciones
                                    If mIncrementarReferencia <> "SI" Then
                                        .Fields("AutoincrementarNumeroReferencia").Value = "NO"
                                    End If

                                End With

                                .Guardar
                            End With

                            Set oCP = Nothing
                  
                            mNumeroReferencia = mNumeroReferencia + 1
                     
                        Else
                  
                            fl = fl + 1
                     
                        End If

                        oRsAux1.Close
               
                    Else
                        Exit Do
                    End If

Seguir:
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
        MsgBox "La importacion de comprobantes reporta los siguientes errores :" & mError, vbExclamation
    End If
   
    Set oRsAux1 = Nothing
    Set oRsAux2 = Nothing
    Set oAp = Nothing
    Set oEx = Nothing
    Set oCP = Nothing
    Set oOP = Nothing

    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub ImportacionOrdenesPago()

    Dim oAp As ComPronto.Aplicacion
    Dim oOP As ComPronto.OrdenPago
    Dim oRsAux1 As ADOR.Recordset
    Dim oRsAux2 As ADOR.Recordset
    Dim oF As Form
    Dim oEx As Excel.Application
    Dim mOk As Boolean, mConProblemas As Boolean
    Dim mIdMonedaPesos As Integer, fl As Integer, mContador As Integer
    Dim mIdProveedor As Integer, mIdObra As Integer, mIdMoneda As Integer
    Dim mIdTipoValor As Integer, mIdBanco As Integer, mIdCuentaBancaria As Integer
    Dim mIdCaja As Integer, mIdTipoComprobante As Integer
    Dim mNumeroOP As Long, mNumeroInterno As Long, mIdValor As Long, mIdCuenta As Long
    Dim mCodigoCuenta As Long, mNumeroComprobante1 As Long, mNumeroComprobante2 As Long
    Dim mIdImputacion As Long, mIdComprobanteProveedor As Long
    Dim mCotizacionDolar As Double, mNumeroCheque As Double, mImporte As Double
    Dim mImporteSinImpuestos As Double, mValores As Double, mAcreedores As Double
    Dim mDebe As Double, mHaber As Double, mCotizacionEuro As Double
    Dim mCodigoProveedor As String, mCuit As String, mTipoValor As String, mTipo As String
    Dim mCuentaBanco As String, mObservaciones As String, mArchivo As String
    Dim mComprobante As String, mLetra As String, mEsCajaBanco As String
    Dim mFecha As Date, mFechaVencimiento As Date
    Dim mVector

    On Error GoTo Mal

    'Set oF = New frmPathPresto
    With oF
        .Id = 4
        .Show vbModal
        mOk = .Ok

        If mOk Then
            mArchivo = .FileBrowser1(0).Text
            mIdObra = .dcfields(0).BoundText
        End If

    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub

    Set oAp = Aplicacion

    Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
    mIdMonedaPesos = oRsAux1.Fields("IdMoneda").Value
    oRsAux1.Close
   
    'Set oF = New frmAviso
    With oF
        .Label1 = "Iniciando EXCEL ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Procesando ordenes de pago ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    fl = 8
    mContador = 0
   
    Set oEx = CreateObject("Excel.Application")

    With oEx
      
        .Visible = True
        .WindowState = xlMinimized
        Me.Refresh
      
        With .Workbooks.Open(mArchivo)
            .Sheets("OP").Select

            With .ActiveSheet

                Do While True
               
                    If Len(Trim(.Cells(fl, 2))) = 0 And Len(Trim(.Cells(fl, 12))) = 0 And Len(Trim(.Cells(fl, 14))) = 0 And Len(Trim(.Cells(fl, 21))) = 0 Then
                        Exit Do
                    End If
               
                    mConProblemas = False
               
                    mContador = mContador + 1
                    oF.Label2 = "Comprobante : " & .Cells(fl, 2)
                    oF.Label3 = "" & mContador

                    DoEvents
            
                    mCodigoProveedor = .Cells(fl, 5)
                    mCuit = .Cells(fl, 6)
                    mFecha = CDate(.Cells(fl, 1))
                    mNumeroOP = CLng(.Cells(fl, 2))
                    mIdMoneda = CInt(.Cells(fl, 9))
                    mTipo = .Cells(fl, 3)

                    If mTipo <> "CC" And mTipo <> "FF" And mTipo <> "OT" Then mTipo = "CC"
                    mObservaciones = .Cells(fl, 25)
               
                    mIdProveedor = 0

                    If Len(mCodigoProveedor) > 0 Then
                        Set oRsAux1 = oAp.Proveedores.TraerFiltrado("_PorCodigoEmpresa", mCodigoProveedor)

                        If oRsAux1.RecordCount > 0 Then
                            mIdProveedor = oRsAux1.Fields(0).Value
                        End If

                        oRsAux1.Close
                    End If

                    If Len(mCuit) > 0 And mIdProveedor = 0 Then
                        Set oRsAux1 = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)

                        If oRsAux1.RecordCount > 0 Then
                            mIdProveedor = oRsAux1.Fields(0).Value
                        End If

                        oRsAux1.Close
                    End If

                    If mIdProveedor = 0 Then
                        mConProblemas = True
                    End If
               
                    mCodigoCuenta = 0

                    If Len(Trim(.Cells(fl, 8))) <> 0 Then
                        mCodigoCuenta = .Cells(fl, 8)
                        mIdCuenta = 0
                        Set oRsAux2 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuenta)

                        If oRsAux2.RecordCount > 0 Then
                            mIdCuenta = oRsAux2.Fields(0).Value
                        End If

                        oRsAux2.Close
                    End If
                        
                    Set oRsAux1 = oAp.OrdenesPago.TraerFiltrado("_PorNumeroIdObraOrigen", Array(mNumeroOP, mIdObra))

                    If oRsAux1.RecordCount = 0 Then
                        mCotizacionDolar = Cotizacion(mFecha, glbIdMonedaDolar)

                        If mCotizacionDolar = 0 Then
                            mConProblemas = True
                        End If

                        mCotizacionEuro = Cotizacion(mFecha, glbIdMonedaEuro)

                        If mCotizacionEuro = 0 Then
                            mConProblemas = True
                        End If

                        Set oOP = oAp.OrdenesPago.Item(-1)

                        With oOP
                            With .Registro
                                .Fields("NumeroOrdenPago").Value = mNumeroOP
                                .Fields("FechaOrdenPago").Value = mFecha

                                If mIdProveedor <> 0 Then
                                    .Fields("IdProveedor").Value = mIdProveedor
                                End If

                                If mCodigoCuenta <> 0 Then
                                    .Fields("IdCuenta").Value = mIdCuenta
                                End If

                                .Fields("IdMoneda").Value = mIdMoneda
                                .Fields("CotizacionMoneda").Value = 1
                                .Fields("CotizacionDolar").Value = mCotizacionDolar
                                .Fields("CotizacionEuro").Value = mCotizacionEuro
                                .Fields("IdObraOrigen").Value = mIdObra
                                .Fields("Tipo").Value = mTipo
                                .Fields("Dolarizada").Value = "NO"
                                .Fields("Exterior").Value = "NO"
                                .Fields("AsientoManual").Value = "NO"
                                .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                                .Fields("FechaIngreso").Value = Now
                                .Fields("Observaciones").Value = mObservaciones

                                If mTipo = "OT" Then .Fields("TipoOperacionOtros").Value = 1
                            End With
                        End With
                     
                        mAcreedores = 0
                        mValores = 0

                        Do While Len(Trim(.Cells(fl, 2))) = 0 Or mNumeroOP = .Cells(fl, 2)
                     
                            If Len(Trim(.Cells(fl, 2))) = 0 And Len(Trim(.Cells(fl, 12))) = 0 And Len(Trim(.Cells(fl, 14))) = 0 And Len(Trim(.Cells(fl, 21))) = 0 Then
                                Exit Do
                            End If
                     
                            'RETENCIONES
                            If Len(Trim(.Cells(fl, 12))) <> 0 Then
                                If CInt(.Cells(fl, 12)) = 1 Then
                                    oOP.Registro.Fields("RetencionIVA").Value = CDbl(.Cells(fl, 13))
                                ElseIf CInt(.Cells(fl, 12)) = 2 Then
                                    oOP.Registro.Fields("RetencionGanancias").Value = CDbl(.Cells(fl, 13))
                                ElseIf CInt(.Cells(fl, 12)) = 3 Then
                                    oOP.Registro.Fields("RetencionIBrutos").Value = CDbl(.Cells(fl, 13))
                                ElseIf CInt(.Cells(fl, 12)) = 4 Then
                                    oOP.Registro.Fields("RetencionSUSS").Value = CDbl(.Cells(fl, 13))
                                End If
                            End If
                     
                            'IMPUTACIONES A CUENTAS CORRIENTES
                            If Len(Trim(.Cells(fl, 10))) <> 0 Then
                                mIdImputacion = -1

                                If Len(Trim(.Cells(fl, 26))) <> 0 Then
                                    mComprobante = Trim(.Cells(fl, 26))

                                    If InStr(1, mComprobante, "-") <> 0 Then
                                        mVector = VBA.Split(mComprobante, "-")
                                        mLetra = mVector(0)
                                        mNumeroComprobante1 = CLng(mVector(1))
                                        mNumeroComprobante2 = CLng(mVector(2))
                                        Set oRsAux2 = oAp.ComprobantesProveedores.TraerFiltrado("_PorNumeroComprobante", Array(mIdProveedor, mLetra, mNumeroComprobante1, mNumeroComprobante2, 0, 0))

                                        If oRsAux2.RecordCount > 0 Then
                                            mIdTipoComprobante = oRsAux2.Fields("IdTipoComprobante").Value
                                            mIdComprobanteProveedor = oRsAux2.Fields("IdComprobanteProveedor").Value
                                            oRsAux2.Close
                                            Set oRsAux2 = oAp.CtasCtesA.TraerFiltrado("_BuscarComprobante", Array(mIdComprobanteProveedor, mIdTipoComprobante))

                                            If oRsAux2.RecordCount > 0 Then
                                                mIdImputacion = oRsAux2.Fields(0).Value
                                            End If
                                        End If

                                        oRsAux2.Close
                                    End If
                                End If

                                mImporte = CDbl(.Cells(fl, 10))
                                mImporteSinImpuestos = CDbl(.Cells(fl, 11))
                                mAcreedores = mAcreedores + mImporte

                                With oOP.DetOrdenesPago.Item(-1)
                                    With .Registro
                                        .Fields("IdImputacion").Value = mIdImputacion
                                        .Fields("Importe").Value = mImporte
                                        .Fields("ImportePagadoSinImpuestos").Value = mImporteSinImpuestos
                                    End With

                                    .Modificado = True
                                End With

                            End If
                     
                            'VALORES
                            If Len(Trim(.Cells(fl, 14))) <> 0 Then
                                mIdTipoValor = 6
                                mTipoValor = .Cells(fl, 14)

                                If mTipoValor = "CH" Or mTipoValor = "CHT" Then
                                    mIdTipoValor = 6
                                ElseIf mTipoValor = "TR" Then
                                    mIdTipoValor = 21
                                ElseIf mTipoValor = "EF" Then
                                    mIdTipoValor = 33
                                End If

                                mNumeroInterno = CLng(.Cells(fl, 17))
                                mNumeroCheque = CDbl(.Cells(fl, 18))
                                mImporte = CDbl(.Cells(fl, 20))
                                mValores = mValores + mImporte
                                mCuentaBanco = CStr(.Cells(fl, 15))

                                If Len(Trim(.Cells(fl, 19))) <> 0 Then
                                    mFechaVencimiento = CDate(.Cells(fl, 19))
                                Else
                                    mFechaVencimiento = 0
                                End If
                        
                                mIdValor = 0
                                Set oRsAux2 = oAp.Valores.TraerFiltrado("_PorNumeroInterno", mNumeroInterno)

                                If oRsAux2.RecordCount > 0 Then
                                    mIdValor = oRsAux2.Fields(0).Value
                                End If

                                oRsAux2.Close
                        
                                mIdBanco = 0
                                mIdCuentaBancaria = 0
                                Set oRsAux2 = oAp.CuentasBancarias.TraerFiltrado("_PorCuenta", mCuentaBanco)

                                If oRsAux2.RecordCount > 0 Then
                                    mIdBanco = oRsAux2.Fields("IdBanco").Value
                                    mIdCuentaBancaria = oRsAux2.Fields("IdCuentaBancaria").Value
                                End If

                                oRsAux2.Close
                        
                                mIdCaja = 0

                                If mTipoValor = "EF" Then
                                    mIdBanco = 0
                                    mIdCuentaBancaria = 0
                                    Set oRsAux2 = oAp.Cajas.TraerFiltrado("_PorCuentaContable", mCuentaBanco)

                                    If oRsAux2.RecordCount > 0 Then
                                        mIdCaja = oRsAux2.Fields(0).Value
                                    End If

                                    oRsAux2.Close
                                End If
                        
                                With oOP.DetOrdenesPagoValores.Item(-1)
                                    With .Registro
                                        .Fields("IdTipoValor").Value = mIdTipoValor
                                        .Fields("Importe").Value = mImporte

                                        If mTipoValor = "EF" Then
                                            .Fields("IdCaja").Value = mIdCaja
                                        Else
                                            .Fields("NumeroValor").Value = mNumeroCheque
                                            .Fields("NumeroInterno").Value = mNumeroInterno
                                            .Fields("IdBanco").Value = mIdBanco
                                            .Fields("IdCuentaBancaria").Value = mIdCuentaBancaria

                                            If mTipoValor = "CHT" Then
                                                .Fields("IdValor").Value = mIdValor
                                            End If

                                            If mFechaVencimiento <> 0 Then
                                                .Fields("FechaVencimiento").Value = mFechaVencimiento
                                            Else
                                                .Fields("FechaVencimiento").Value = Null
                                            End If
                                        End If

                                    End With

                                    .Modificado = True
                                End With

                            End If
                     
                            'ASIENTO MANUAL
                            If Len(Trim(.Cells(fl, 22))) <> 0 Then
                                mCodigoCuenta = .Cells(fl, 22)
                                mDebe = 0

                                If Len(Trim(.Cells(fl, 23))) <> 0 Then
                                    mDebe = CDbl(.Cells(fl, 23))
                                End If

                                mHaber = 0

                                If Len(Trim(.Cells(fl, 24))) <> 0 Then
                                    mHaber = CDbl(.Cells(fl, 24))
                                End If
                        
                                mIdCuenta = 0
                                mEsCajaBanco = ""
                                mIdCaja = 0
                                Set oRsAux2 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuenta)

                                If oRsAux2.RecordCount > 0 Then
                                    mIdCuenta = oRsAux2.Fields(0).Value
                                    oRsAux2.Close
                                    Set oRsAux2 = oAp.Cuentas.TraerFiltrado("_CuentaCajaBanco", mIdCuenta)

                                    If oRsAux2.RecordCount > 0 Then
                                        If Not IsNull(oRsAux2.Fields("EsCajaBanco").Value) And (oRsAux2.Fields("EsCajaBanco").Value = "BA" Or oRsAux2.Fields("EsCajaBanco").Value = "CA") Then
                                            mEsCajaBanco = oRsAux2.Fields("EsCajaBanco").Value
                                        End If

                                        mIdCaja = IIf(IsNull(oRsAux2.Fields("IdCaja").Value), 0, oRsAux2.Fields("IdCaja").Value)
                                    End If
                                End If

                                oRsAux2.Close
                        
                                mIdCuentaBancaria = 0

                                If mEsCajaBanco = "BA" Then
                                    Set oRsAux2 = oAp.Bancos.TraerFiltrado("_PorCuentasBancariasIdCuenta", mIdCuenta)

                                    If oRsAux2.RecordCount > 0 Then
                                        mIdCuentaBancaria = oRsAux2.Fields("IdCuentaBancaria").Value
                                    End If

                                    oRsAux2.Close
                                End If
                        
                                oOP.Registro.Fields("AsientoManual").Value = "SI"
                        
                                With oOP.DetOrdenesPagoCuentas.Item(-1)
                                    With .Registro
                                        .Fields("IdCuenta").Value = mIdCuenta
                                        .Fields("CodigoCuenta").Value = mCodigoCuenta
                                        .Fields("IdMoneda").Value = mIdMoneda

                                        If mDebe <> 0 Then .Fields("Debe").Value = mDebe
                                        If mHaber <> 0 Then .Fields("Haber").Value = mHaber
                                        If mIdCuentaBancaria <> 0 Then
                                            .Fields("IdCuentaBancaria").Value = mIdCuentaBancaria
                                        ElseIf mIdCaja <> 0 Then
                                            .Fields("IdCaja").Value = mIdCaja
                                        End If

                                    End With

                                    .Modificado = True
                                End With

                            End If
                     
                            fl = fl + 1
                        Loop
                     
                        With oOP
                            With .Registro
                                '                        If mConProblemas Then
                                .Fields("Confirmado").Value = "NO"
                                '                        Else
                                '                           .Fields("Confirmado").Value = "SI"
                                '                        End If
                                .Fields("Valores").Value = mValores
                                .Fields("Acreedores").Value = mAcreedores
                                .Fields("TipoGrabacion").Value = "I"
                            End With

                            .Guardar
                        End With

                        Set oOP = Nothing
                  
                    Else
                        fl = fl + 1
                    End If

                    oRsAux1.Close
                Loop

            End With

            .Close False
        End With

        .Quit
    End With
   
Salida:

    Unload oF
    Set oF = Nothing

    Set oRsAux1 = Nothing
    Set oRsAux2 = Nothing
    Set oOP = Nothing
    Set oAp = Nothing
    Set oEx = Nothing

    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub ImportacionValores()

    Dim oAp As ComPronto.Aplicacion
    Dim oVal As ComPronto.Valor
    Dim oRsAux1 As ADOR.Recordset
    Dim oF As Form
    Dim i As Integer, mIdBanco As Integer, mIdMonedaPesos As Integer
    Dim mNumeroValor As Double, mImporte As Double
    Dim mArchivo As String, mError As String
    Dim mOk As Boolean, mConProblemas As Boolean
    Dim mFechaValor As Date
    Dim Filas, Columnas

    On Error GoTo Mal

    'Set oF = New frmPathPresto
    With oF
        .Id = 5
        .Show vbModal
        mOk = .Ok

        If mOk Then
            mArchivo = .FileBrowser1(0).Text
        End If

    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub

    Set oAp = Aplicacion

    Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
    mIdMonedaPesos = oRsAux1.Fields("IdMoneda").Value
    oRsAux1.Close
   
    'Set oF = New frmAviso
    With oF
        .Label1 = "Iniciando importacion ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Procesando valores ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    mError = ""
    mConProblemas = False
   
    Filas = VBA.Split(LeerArchivoSecuencial(mArchivo), vbCrLf)

    If UBound(Filas) > 0 Then

        For i = 0 To UBound(Filas)
            Columnas = VBA.Split(Filas(i), ",")

            If UBound(Columnas) > 1 Then
                mNumeroValor = CDbl(Columnas(1))
                mIdBanco = CInt(Columnas(2))
                mFechaValor = CDate(Columnas(3))
                mImporte = CDbl(Columnas(4))
            
                Set oRsAux1 = oAp.Valores.TraerFiltrado("_PorNumeroValorIdBanco", Array(mNumeroValor, mIdBanco))

                If oRsAux1.RecordCount > 0 Then
                    mError = mError & vbCrLf & "El cheque " & mNumeroValor & " " & "del banco " & Columnas(6) & " ya existe"
                    mConProblemas = True
                End If

                oRsAux1.Close
            
                If Not mConProblemas Then
                    Set oVal = oAp.Valores.Item(-1)

                    With oVal
                        With .Registro
                            .Fields("IdTipoValor").Value = 6
                            .Fields("NumeroValor").Value = mNumeroValor
                            .Fields("FechaValor").Value = mFechaValor
                            .Fields("NumeroInterno").Value = 0
                            .Fields("IdBanco").Value = mIdBanco
                            .Fields("Importe").Value = mImporte
                            .Fields("IdCuentaBancaria").Value = 0
                            .Fields("IdMoneda").Value = mIdMonedaPesos
                            .Fields("CotizacionMoneda").Value = 1
                            .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                            .Fields("FechaIngreso").Value = Now
                            .Fields("Detalle").Value = Columnas(8) & " - " & Trim(Columnas(9)) & " del " & Columnas(10)
                        End With

                        .Guardar
                    End With

                End If
            End If

        Next

    End If

    If Len(mError) > 0 Then
        MsgBox "El proceso reporta los siguientes problemas :" & mError
    End If

Salida:

    Unload oF
    Set oF = Nothing

    Set oRsAux1 = Nothing
    Set oVal = Nothing
    Set oAp = Nothing

    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub ImportacionEfectivo()

    Dim oAp As ComPronto.Aplicacion
    Dim oRec As ComPronto.Recibo
    Dim oRsAux1 As ADOR.Recordset
    Dim oF As Form
    Dim i As Integer, mIdMonedaPesos As Integer, mIdMonedaDolar As Integer
    Dim mIdPuntoVenta As Integer, mPuntoVenta As Integer
    Dim mImporte As Double, mDebe As Double, mHaber As Double
    Dim mNumeroRecibo As Long, mCodigo As Long, mIdCuenta As Long, mIdCaja As Long
    Dim mArchivo As String, mError As String
    Dim mFecha As Date, mFechaCorte As Date
    Dim mOk As Boolean, mConProblemas As Boolean
    Dim Filas, Columnas

    On Error GoTo Mal

    'Set oF = New frmPathPresto
    With oF
        .Id = 6
        .Show vbModal
        mOk = .Ok

        If mOk Then
            mArchivo = .FileBrowser1(0).Text
        End If

    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub

    Set oAp = Aplicacion

    Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
    mIdMonedaPesos = oRsAux1.Fields("IdMoneda").Value
    mIdMonedaDolar = oRsAux1.Fields("IdMonedaDolar").Value
    oRsAux1.Close
   
    mIdCaja = 0
    Set oRsAux1 = oAp.Cajas.TraerTodos

    If oRsAux1.RecordCount > 0 Then
        mIdCaja = oRsAux1.Fields(0).Value
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
   
    'Set oF = New frmAviso
    With oF
        .Label1 = "Iniciando importacion ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Procesando ingresos en efectivo ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    mError = ""
    mFechaCorte = 0
   
    Filas = VBA.Split(LeerArchivoSecuencial(mArchivo), vbCrLf)

    If UBound(Filas) > 0 Then

        For i = 0 To UBound(Filas)
            Columnas = VBA.Split(Filas(i), ",")

            If UBound(Columnas) > 1 Then
                mFecha = CDate(Columnas(0))
                mImporte = CDbl(Columnas(1))
                mCodigo = CLng(Columnas(2))
                mDebe = CDbl(Columnas(3))
                mHaber = CDbl(Columnas(4))
                mNumeroRecibo = CLng(Format(Year(mFecha), "0000") & Format(Month(mFecha), "00") & Format(Day(mFecha), "00"))
            
                If mFecha <> mFechaCorte Then
                    If Not oRec Is Nothing Then
                        Set oRsAux1 = oAp.Recibos.TraerFiltrado("_PorIdPuntoVenta_Numero", Array(mIdPuntoVenta, mNumeroRecibo))

                        If oRsAux1.RecordCount = 0 Then
                            oRec.Guardar
                        End If

                        oRsAux1.Close
                        Set oRec = Nothing
                    End If

                    Set oRec = oAp.Recibos.Item(-1)

                    With oRec
                        With .Registro
                            .Fields("NumeroRecibo").Value = mNumeroRecibo
                            .Fields("FechaRecibo").Value = mFecha
                            .Fields("IdPuntoVenta").Value = mIdPuntoVenta
                            .Fields("PuntoVenta").Value = mPuntoVenta
                            .Fields("Tipo").Value = "OT"
                            .Fields("Efectivo").Value = 0
                            .Fields("Valores").Value = mImporte
                            .Fields("Documentos").Value = 0
                            .Fields("Otros1").Value = 0
                            .Fields("Otros2").Value = 0
                            .Fields("Otros3").Value = 0
                            .Fields("Otros4").Value = 0
                            .Fields("Otros5").Value = 0
                            .Fields("Deudores").Value = 0
                            .Fields("RetencionIVA").Value = 0
                            .Fields("RetencionGanancias").Value = 0
                            .Fields("RetencionIBrutos").Value = 0
                            .Fields("GastosGenerales").Value = 0
                            .Fields("Cotizacion").Value = Cotizacion(mFecha, mIdMonedaDolar)
                            .Fields("IdMoneda").Value = mIdMonedaPesos
                            .Fields("Dolarizada").Value = "NO"
                            .Fields("AsientoManual").Value = "SI"
                            .Fields("CotizacionMoneda").Value = 1
                            .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                            .Fields("FechaIngreso").Value = Now
                        End With

                        With .DetRecibosValores.Item(-1)
                            With .Registro
                                .Fields("IdTipoValor").Value = 32
                                .Fields("Importe").Value = mImporte
                                .Fields("IdCaja").Value = mIdCaja
                            End With

                            .Modificado = True
                        End With
                    End With

                    mFechaCorte = mFecha
                End If
            
                Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigo)

                If oRsAux1.RecordCount > 0 Then
                    mIdCuenta = oRsAux1.Fields(0).Value
                Else
                    mError = mError & vbCrLf & "El recibo " & mNumeroRecibo & " no tiene una de las cuentas"
                    mIdCuenta = 0
                End If

                oRsAux1.Close
            
                If IsNull(oRec.Registro.Fields("IdCuenta").Value) And mHaber <> 0 Then
                    oRec.Registro.Fields("IdCuenta").Value = mIdCuenta
                End If
            
                With oRec.DetRecibosCuentas.Item(-1)
                    With .Registro
                        .Fields("IdCuenta").Value = mIdCuenta
                        .Fields("CodigoCuenta").Value = mCodigo
                        .Fields("Debe").Value = mDebe
                        .Fields("Haber").Value = mHaber
                        .Fields("IdMoneda").Value = mIdMonedaPesos
                        .Fields("CotizacionMonedaDestino").Value = 1
                    End With

                    .Modificado = True
                End With
            
            End If

        Next

    End If

    If Not oRec Is Nothing Then
        Set oRsAux1 = oAp.Recibos.TraerFiltrado("_PorIdPuntoVenta_Numero", Array(mIdPuntoVenta, mNumeroRecibo))

        If oRsAux1.RecordCount = 0 Then
            oRec.Guardar
        End If

        oRsAux1.Close
        Set oRec = Nothing
    End If
   
    If Len(mError) > 0 Then
        MsgBox "El proceso reporta los siguientes problemas :" & mError
    End If

Salida:

    Unload oF
    Set oF = Nothing

    Set oRsAux1 = Nothing
    Set oRec = Nothing
    Set oAp = Nothing

    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub ImportacionEfectivo1()

    Dim oAp As ComPronto.Aplicacion
    Dim oRec As ComPronto.Recibo
    Dim oPto As ComPronto.PuntoVenta
    Dim oRsAux1 As ADOR.Recordset
    Dim oF As Form
    Dim i As Integer, j As Integer, mIdMonedaPesos As Integer, mIdMonedaDolar As Integer
    Dim mIdPuntoVenta As Integer, mPuntoVenta As Integer
    Dim mImporte As Double, mTotal As Double
    Dim mNumeroRecibo As Long, mCodigo As Long, mCodigoRecibo As Long, mIdCuenta As Long
    Dim mIdCuentaRecibo As Long, mIdCaja As Long, mIdObra As Long
    Dim mArchivo As String, mError As String, s As String, s1 As String, mClave As String
    Dim mClave1 As String, mJerarquia As String, mTipo As String, mCodigoObra As String
    Dim mFecha As Date, mFechaCorte As Date
    Dim mOk As Boolean, mConProblemas As Boolean
    Dim Filas, Columnas, Subcolumnas

    On Error GoTo Mal

    'Set oF = New frmPathPresto
    With oF
        .Id = 6
        .Show vbModal
        mOk = .Ok

        If mOk Then
            mArchivo = .FileBrowser1(0).Text
        End If

    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub

    Set oAp = Aplicacion

    Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
    mIdMonedaPesos = oRsAux1.Fields("IdMoneda").Value
    mIdMonedaDolar = oRsAux1.Fields("IdMonedaDolar").Value
    oRsAux1.Close
   
    mIdPuntoVenta = 0
    mPuntoVenta = 0
    mNumeroRecibo = 0
    Set oRsAux1 = oAp.PuntosVenta.TraerFiltrado("_PorIdTipoComprobante", 2)

    If oRsAux1.RecordCount > 0 Then
        mIdPuntoVenta = oRsAux1.Fields(0).Value
        mPuntoVenta = oRsAux1.Fields("PuntoVenta").Value
        mNumeroRecibo = oRsAux1.Fields("ProximoNumero").Value
    End If

    oRsAux1.Close
   
    'Set oF = New frmAviso
    With oF
        .Label1 = "Iniciando importacion ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Procesando ingresos en efectivo ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    mError = ""
    mFecha = Date
    mTotal = 0
    mIdObra = 0
   
    Set oRec = oAp.Recibos.Item(-1)

    With oRec
        With .Registro
            .Fields("FechaRecibo").Value = mFecha
            .Fields("IdPuntoVenta").Value = mIdPuntoVenta
            .Fields("PuntoVenta").Value = mPuntoVenta
            .Fields("Tipo").Value = "OT"
            .Fields("Efectivo").Value = 0
            .Fields("Documentos").Value = 0
            .Fields("Otros1").Value = 0
            .Fields("Otros2").Value = 0
            .Fields("Otros3").Value = 0
            .Fields("Otros4").Value = 0
            .Fields("Otros5").Value = 0
            .Fields("Deudores").Value = 0
            .Fields("RetencionIVA").Value = 0
            .Fields("RetencionGanancias").Value = 0
            .Fields("RetencionIBrutos").Value = 0
            .Fields("GastosGenerales").Value = 0
            .Fields("Cotizacion").Value = Cotizacion(mFecha, mIdMonedaDolar)
            .Fields("IdMoneda").Value = mIdMonedaPesos
            .Fields("Dolarizada").Value = "NO"
            .Fields("AsientoManual").Value = "SI"
            .Fields("CotizacionMoneda").Value = 1
            .Fields("IdUsuarioIngreso").Value = glbIdUsuario
            .Fields("FechaIngreso").Value = Now
        End With
    End With
   
    s = LeerArchivoSecuencial(mArchivo)
    s = Replace(s, ";", ",")
    Filas = VBA.Split(s, vbCrLf)

    If UBound(Filas) > 0 Then

        For i = 0 To UBound(Filas)

            If i = 0 Then
                s = QuitarPath(mArchivo)
                s1 = mId(s, 6, 2) + "/" + mId(s, 4, 2) + "/" + mId(s, 2, 2)

                If Not IsDate(s1) Then
                    MsgBox "El archivo no tiene una fecha valida" & vbCrLf & "Importacion cancelada", vbExclamation
                    GoTo Salida
                End If

                mFecha = CDate(s1)
                mClave = "Codigo de obra (" & mId(s, 1, 1) & ")"
                s = BuscarClaveINI(mClave)

                If Len(s) = 0 Then
                    MsgBox "No existe la clave del Pronto.ini : " & mClave & vbCrLf & "Importacion cancelada", vbExclamation
                    GoTo Salida
                End If

                Set oRsAux1 = oAp.Obras.TraerFiltrado("_PorNumero", s)

                If oRsAux1.RecordCount = 0 Then
                    MsgBox "No existe la obra con numero " & s & vbCrLf & "Importacion cancelada", vbExclamation
                    GoTo Salida
                End If

                mIdObra = oRsAux1.Fields(0).Value
                mClave = "" & s
                oRsAux1.Close
         
            ElseIf i = 1 Then
                Columnas = VBA.Split(Filas(i), ",")
                Subcolumnas = VBA.Split(Columnas(0), "=")
                mClave1 = mClave & "_" & Subcolumnas(1) & "_(1)"
                s = BuscarClaveINI(mClave1)
                Subcolumnas = VBA.Split(s, " ")
                mJerarquia = Subcolumnas(0)

                If Len(mJerarquia) = 0 Then
                    MsgBox "No existe la clave del Pronto.ini : " & mClave & vbCrLf & "Importacion cancelada", vbExclamation
                    GoTo Salida
                End If
         
                mIdCuentaRecibo = 0
                Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigoJerarquia", mJerarquia)

                If oRsAux1.RecordCount > 0 Then
                    mIdCuentaRecibo = oRsAux1.Fields(0).Value
                    mCodigoRecibo = oRsAux1.Fields("Codigo").Value
                End If

                oRsAux1.Close
            
                mIdCaja = 0
                Set oRsAux1 = oAp.Cajas.TraerFiltrado("_PorIdCuenta", mIdCuentaRecibo)

                If oRsAux1.RecordCount > 0 Then
                    mIdCaja = oRsAux1.Fields(0).Value
                End If

                oRsAux1.Close

            Else
                Columnas = VBA.Split(Filas(i), ",")

                If UBound(Columnas) > 1 Then
                    Subcolumnas = VBA.Split(Columnas(0), "=")

                    For j = 0 To 2

                        If j = 0 Then
                            mImporte = Val(Subcolumnas(1))
                        Else
                            mImporte = Val(Columnas(j))
                        End If

                        If mImporte <> 0 Then
                            mClave1 = mClave & "_" & Subcolumnas(0) & "_(" & j + 1 & ")"
                            s = BuscarClaveINI(mClave1)
                            Subcolumnas = VBA.Split(s, " ")
                            mJerarquia = Subcolumnas(0)
                            mTipo = Subcolumnas(1)

                            If Len(Subcolumnas(0)) = 0 Then
                                MsgBox "No existe la clave del Pronto.ini : " & mClave & vbCrLf & "Importacion cancelada", vbExclamation
                                GoTo Salida
                            End If
                     
                            mIdCuenta = 0
                            Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigoJerarquia", mJerarquia)

                            If oRsAux1.RecordCount > 0 Then
                                mIdCuenta = oRsAux1.Fields(0).Value
                                mCodigo = oRsAux1.Fields("Codigo").Value
                            End If

                            oRsAux1.Close
                     
                            With oRec.DetRecibosCuentas.Item(-1)
                                With .Registro
                                    .Fields("IdCuenta").Value = mIdCuenta
                                    .Fields("CodigoCuenta").Value = mCodigo

                                    If mTipo = "DEBE" Then
                                        .Fields("Debe").Value = mImporte
                                        mTotal = mTotal - mImporte
                                    Else
                                        .Fields("Haber").Value = mImporte
                                        mTotal = mTotal + mImporte
                                    End If

                                    .Fields("IdMoneda").Value = mIdMonedaPesos
                                    .Fields("CotizacionMonedaDestino").Value = 1
                                End With

                                .Modificado = True
                            End With

                        End If

                    Next

                End If
            End If

        Next

    End If
   
    Set oPto = Aplicacion.PuntosVenta.Item(mIdPuntoVenta)

    With oPto
        mNumeroRecibo = .Registro.Fields("ProximoNumero").Value
        .Registro.Fields("ProximoNumero").Value = mNumeroRecibo + 1
        .Guardar
    End With

    Set oPto = Nothing
   
    With oRec
        With .Registro
            .Fields("NumeroRecibo").Value = mNumeroRecibo
            .Fields("FechaRecibo").Value = mFecha
            .Fields("IdCuenta").Value = mIdCuentaRecibo
            .Fields("IdObra").Value = mIdObra
        End With

        With .DetRecibosValores.Item(-1)
            With .Registro
                .Fields("IdTipoValor").Value = 32
                .Fields("Importe").Value = mTotal
                .Fields("IdCaja").Value = mIdCaja
            End With

            .Modificado = True
        End With

        With .DetRecibosCuentas.Item(-1)
            With .Registro
                .Fields("IdCuenta").Value = mIdCuentaRecibo
                .Fields("CodigoCuenta").Value = mCodigoRecibo

                If mTotal > 0 Then
                    .Fields("Debe").Value = mTotal
                Else
                    .Fields("Haber").Value = Abs(mTotal)
                End If

                .Fields("IdMoneda").Value = mIdMonedaPesos
                .Fields("CotizacionMonedaDestino").Value = 1
            End With

            .Modificado = True
        End With

        .Guardar
    End With
   
Salida:

    Unload oF
    Set oF = Nothing

    Set oRsAux1 = Nothing
    Set oRec = Nothing
    Set oAp = Nothing

    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub RenumerarAsientos()

    Dim oF As Form
    Dim mOk As Boolean
         
    Dim mNumeroInicial As Long
    Dim mFechaInicial As Date, mFechaFinal As Date
   
    mNumeroInicial = 0
   
    Set oF = New frm_Aux

    With oF
        .Caption = "Renumeracion de asientos"

        With .Label2(0)
            .Caption = "Fecha inicial :"
            .top = 50
            .left = oF.cmd(0).left
            .Visible = True
        End With

        With .DTFields(0)
            .top = oF.Label2(0).top
            .left = oF.Label2(0).left + oF.Label2(0).Width + 10
            .Value = DateSerial(Year(Date), Month(Date), 1)
            .Visible = True
        End With

        With .Label2(1)
            .Caption = "Fecha final :"
            .top = oF.Label2(0).top + oF.Label2(0).Height * 2
            .left = oF.Label2(0).left
            .Visible = True
        End With

        With .DTFields(1)
            .top = oF.Label2(1).top
            .left = oF.Label2(1).left + oF.Label2(1).Width + 10
            .Value = Date
            .Visible = True
        End With

        With .Label1
            .Caption = "Numero inicial :"
            .top = oF.Label2(1).top + oF.Label2(1).Height * 2
            .left = oF.Label2(1).left
        End With

        With .text1
            .top = oF.Label1.top
            .left = oF.Label1.left + oF.Label1.Width + 10
        End With

        .Show vbModal, Me

        If IsNumeric(.text1.Text) Then mNumeroInicial = (.text1.Text)
        mFechaInicial = .DTFields(0).Value
        mFechaFinal = .DTFields(1).Value
        mOk = .Ok
    End With

    Unload oF
    Set oF = Nothing
   
    If mOk Then
        If mNumeroInicial = 0 Then
            MsgBox "No ingreso el numero inicial", vbExclamation
            Exit Sub
        End If
   
        Dim oRs As ADOR.Recordset
        Set oRs = Aplicacion.Asientos.TraerFiltrado("_EntreFechas", Array(mFechaInicial, mFechaFinal))

        If oRs.RecordCount > 0 Then
            oRs.MoveFirst

            Do While Not oRs.EOF
                Aplicacion.Tarea "Asientos_CambiarNumero", Array(oRs.Fields(0).Value, mNumeroInicial)
                mNumeroInicial = mNumeroInicial + 1
                oRs.MoveNext
            Loop

        End If

        oRs.Close
        Set oRs = Nothing
    End If

End Sub

Public Sub CopiarAsiento()

    Dim oAp As ComPronto.Aplicacion
    Dim oAsi As ComPronto.Asiento
    Dim oPar As ComPronto.Parametro
    Dim oRs As ADOR.Recordset
    Dim oRsDet As ADOR.Recordset
    Dim iFilas As Integer, i As Integer, mNum As Long
    Dim Filas
    Dim Columnas
   
    Set oAp = Aplicacion
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)
   
    For iFilas = LBound(Filas) + 1 To UBound(Filas)
      
        Columnas = VBA.Split(Filas(iFilas), vbTab)
      
        Set oPar = Aplicacion.Parametros.Item(1)
        mNum = oPar.Registro.Fields("ProximoAsiento").Value
      
        Set oRs = oAp.Asientos.Item(Columnas(2)).Registro
        Set oRsDet = oAp.Asientos.TraerFiltrado("_DetallesPorIdAsiento", Columnas(2))
      
        Set oAsi = oAp.Asientos.Item(-1)

        With oAsi
            With .Registro
                .Fields("NumeroAsiento").Value = mNum
                .Fields("FechaAsiento").Value = Date
                .Fields("IdIngreso").Value = glbIdUsuario
                .Fields("FechaIngreso").Value = Date
                .Fields("Concepto").Value = oRs.Fields("Concepto").Value
            End With

            If oRsDet.RecordCount > 0 Then
                oRsDet.MoveFirst

                Do While Not oRsDet.EOF

                    With .DetAsientos.Item(-1)
                        With .Registro

                            For i = 2 To oRsDet.Fields.Count - 1
                                .Fields(oRsDet.Fields(i).Name).Value = oRsDet.Fields(i).Value
                            Next

                        End With

                        .Modificado = True
                    End With

                    oRsDet.MoveNext
                Loop

            End If

            .Guardar
        End With

        Set oAsi = Nothing
      
        oRs.Close
        Set oRs = Nothing
      
        oRsDet.Close
        Set oRsDet = Nothing
      
        oPar.Registro.Fields("ProximoAsiento").Value = mNum + 1
        oPar.Guardar
        Set oPar = Nothing
   
    Next

    Set oAp = Nothing

End Sub

Public Sub RevertirAsiento()

    Dim oAp As ComPronto.Aplicacion
    Dim oAsi As ComPronto.Asiento
    Dim oPar As ComPronto.Parametro
    Dim oRs As ADOR.Recordset
    Dim oRsDet As ADOR.Recordset
    Dim iFilas As Integer, i As Integer, mNum As Long
    Dim Filas
    Dim Columnas
   
    Set oAp = Aplicacion
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)
   
    For iFilas = LBound(Filas) + 1 To UBound(Filas)
      
        Columnas = VBA.Split(Filas(iFilas), vbTab)
      
        Set oPar = Aplicacion.Parametros.Item(1)
        mNum = oPar.Registro.Fields("ProximoAsiento").Value
      
        Set oRs = oAp.Asientos.Item(Columnas(2)).Registro
        Set oRsDet = oAp.Asientos.TraerFiltrado("_DetallesPorIdAsiento", Columnas(2))
      
        Set oAsi = oAp.Asientos.Item(-1)

        With oAsi
            With .Registro
                .Fields("NumeroAsiento").Value = mNum
                .Fields("FechaAsiento").Value = Date
                .Fields("IdIngreso").Value = glbIdUsuario
                .Fields("FechaIngreso").Value = Date
                .Fields("Concepto").Value = oRs.Fields("Concepto").Value
            End With

            If oRsDet.RecordCount > 0 Then
                oRsDet.MoveFirst

                Do While Not oRsDet.EOF

                    With .DetAsientos.Item(-1)
                        With .Registro

                            For i = 2 To oRsDet.Fields.Count - 1
                                .Fields(oRsDet.Fields(i).Name).Value = oRsDet.Fields(i).Value
                            Next

                            .Fields("Debe").Value = oRsDet.Fields("Haber").Value
                            .Fields("Haber").Value = oRsDet.Fields("Debe").Value
                        End With

                        .Modificado = True
                    End With

                    oRsDet.MoveNext
                Loop

            End If

            .Guardar
        End With

        Set oAsi = Nothing
      
        oRs.Close
        Set oRs = Nothing
      
        oRsDet.Close
        Set oRsDet = Nothing
      
        oPar.Registro.Fields("ProximoAsiento").Value = mNum + 1
        oPar.Guardar
        Set oPar = Nothing
   
    Next

    Set oAp = Nothing

End Sub

Public Sub EmitirOrdenesDePago(ByVal Destino As Integer)

    Dim mvarConCotizacion As Boolean, mvarOK As Boolean
    mvarConCotizacion = False
    Dim of1 As frm_Aux
    Set of1 = New frm_Aux

    With of1
        .Caption = "Emision de Orden de Pago"
        .Label1.Visible = False
        .text1.Visible = False

        With .Frame1
            .Caption = "Emite cotizacion dolar ? : "
            .top = of1.Label1.top
            .Visible = True
        End With

        .Option1.Caption = "SI"
        .Option1.Value = True
        .Option2.Caption = "NO"
        .Show vbModal, Me
        mvarOK = .Ok
        mvarConCotizacion = .Option1.Value
    End With

    Unload of1
    Set of1 = Nothing
    Me.Refresh

    If Not mvarOK Then Exit Sub
   
    Dim mCopias As Integer
    Dim mPrinter As String, mPrinterAnt As String
   
    mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
    If Destino = 0 Then
        Dim oF 'As frmCopiasImpresion

        'Set oF = New frmCopiasImpresion
        With oF
            .txtCopias.Text = 2
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

    Dim mAuxS1 As String, mAuxS2 As String, mDestino As String
    Dim iFilas As Integer, mvarId As Long
    Dim oRs As ADOR.Recordset
    Dim Filas, Columnas
    Dim oW As Word.Application
   
    mAuxS2 = BuscarClaveINI("No mostrar imputaciones en OP fondo fijo")

    If Destino = 0 Then
        mDestino = "Printer"
    Else
        mDestino = "Word"
    End If

    mAuxS1 = "||" & Destino & "|||" & mCopias & "|||" & IIf(mvarConCotizacion, "SI", "NO") & "|" & mPrinterAnt & "|" & mPrinter & "|" & mAuxS2
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
        mvarId = Columnas(2)
      
        Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PorId", mvarId)

        If oRs.RecordCount > 0 Then
            Set oW = CreateObject("Word.Application")
            oW.Visible = True

            With oW.Documents.Add(glbPathPlantillas & "\OrdenPago_" & glbEmpresaSegunString & ".dot")
                oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId, varg3:=mAuxS1
                oW.Application.Run MacroName:="DatosDelPie"
                oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."

                If Destino = 0 Then
                    If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
                    oW.Documents(1).PrintOut False, , , , , , , mCopias

                    If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
                    oW.Documents(1).Close False
                    oW.Quit
                End If

            End With
         
            If Not IsNull(oRs.Fields("RetencionGanancias").Value) And oRs.Fields("RetencionGanancias").Value <> 0 Then
                EmisionCertificadoRetencionGanancias mvarId, mDestino, mPrinter
            End If
         
            If Not IsNull(oRs.Fields("RetencionIVA").Value) And oRs.Fields("RetencionIVA").Value <> 0 Then
                EmisionCertificadoRetencionIVA mvarId, mDestino, mPrinter
            End If
         
            If Not IsNull(oRs.Fields("RetencionIBrutos").Value) And oRs.Fields("RetencionIBrutos").Value <> 0 Then
                EmisionCertificadoRetencionIIBB mvarId, mDestino, mPrinter
            End If
         
            If Not IsNull(oRs.Fields("RetencionSUSS").Value) And oRs.Fields("RetencionSUSS").Value <> 0 Then
                EmisionCertificadoRetencionSUSS mvarId, mDestino, mPrinter
            End If
        End If

        oRs.Close
        Set oRs = Nothing
    Next

    Set oW = Nothing
   
    '   If Len(mIds) > 0 Then
    '      mIds = mId(mIds, 1, Len(mIds) - 1)
    '      EmisionOrdenPago "OrdenesPago", mIds, "||" & Destino & "|||" & mCopias & "|||" & _
    '                        IIf(mvarConCotizacion, "SI", "NO") & "|" & _
    '                        mPrinterAnt & "|" & mPrinter
    '   End If

End Sub

Public Sub EliminarOrdenesDePago()

    Dim Filas
    Dim Columnas
    Dim iFilas As Integer
   
    Me.MousePointer = vbHourglass

    DoEvents

    Filas = VBA.Split(Lista.GetString, vbCrLf)
   
    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
        Aplicacion.Tarea "OrdenesPago_EliminarOrdenesDePagoAConfirmar", Columnas(2)
    Next

    Set Lista.DataSource = Aplicacion.OrdenesPago.TraerFiltrado("_AConfirmar")
   
    Me.MousePointer = vbDefault

End Sub

Public Sub EmitirDatosObra(ByVal Destino As Integer)

    Dim mvarOK As Boolean
    Dim mCopias As Integer
    Dim mPrinter As String, mPrinterAnt As String
   
    mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
    If Destino = 0 Then
        Dim oF 'As frmCopiasImpresion

        'Set oF = New frmCopiasImpresion
        With oF
            .txtCopias.Text = 2
            .Frame1.Visible = False
            .Show vbModal, Me
        End With

        mvarOK = oF.Ok
        mCopias = Val(oF.txtCopias.Text)
        mPrinter = oF.Combo1.Text
        Unload oF
        Set oF = Nothing

        If Not mvarOK Then
            Exit Sub
        End If

    Else
        mCopias = 1
    End If

    Dim iFilas As Integer, mIds As String
    Dim Filas
    Dim Columnas
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)
    mIds = ""

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
        mIds = mIds & Columnas(2) & "|"
    Next
   
    If Len(mIds) > 0 Then
        mIds = mId(mIds, 1, Len(mIds) - 1)
        ListadoObras "Obras", mIds, "||" & Destino & "|||" & mCopias & "|||" & mPrinterAnt & "|" & mPrinter
    End If

End Sub

Public Sub ImportacionRequerimientos()
    '
    '   Dim oAp As ComPronto.Aplicacion
    '   Dim oEx As Excel.Application
    '   Dim oReq As ComPronto.Requerimiento
    '   Dim oRs As ADOR.Recordset
    '   Dim oRsAux As ADOR.Recordset
    '   Dim oRsErrores As ADOR.Recordset
    '   Dim oF As Form
    '   Dim mArchivo As String, mObra As String, mSectorSolicitante As String
    '   Dim mLugarEntrega As String, mDetalle As String, mCodigoMaterial As String
    '   Dim mMaterial As String, mUnidad As String, mAdjunto1 As String, mAdjunto2 As String
    '   Dim mObservaciones As String, mProveedor As String, mPathObra As String, mObs As String
    '   Dim fl As Integer, mContador As Integer, mItem As Integer, mIdSolicito As Integer
    '   Dim mIdObra As Integer, mIdSector As Integer, mIdUnidadPorUnidad As Integer
    '   Dim mIdMonedaPesos As Integer, mIdUnidad As Integer
    '   Dim mNumeroRM As Long, mLegajoSolicito As Long, mNumeroFactura As Long
    '   Dim mIdArticulo As Long
    '   Dim mCantidad As Double, mImporte As Double
    '   Dim mFecha As Date, mFechaFactura As Date, mFechaNecesidad As Date
    '   Dim mOk As Boolean, mConProblemas As Boolean
    '
    '   On Error GoTo Mal
    '
    '   'Set oF = New frmPathPresto
    '   With oF
    '      .Id = 7
    '      .Show vbModal
    '      mOk = .Ok
    '      If mOk Then
    '         mArchivo = .FileBrowser1(0).Text
    '      End If
    '   End With
    '   Unload oF
    '   Set oF = Nothing
    '
    '   If Not mOk Then Exit Sub
    '
    '    mObs = BuscarClaveINI("Inicializar origen de descripcion en item de RM")
    '
    '   Set oAp = Aplicacion
    '
    '   Set oRsErrores = CreateObject("ADOR.Recordset")
    '   With oRsErrores
    '      .Fields.Append "Id", adInteger
    '      .Fields.Append "Detalle", adVarChar, 200
    '   End With
    '   oRsErrores.Open
    '
    '   Set oRs = oAp.Parametros.Item(1).Registro
    '   mIdMonedaPesos = oRs.Fields("IdMoneda").Value
    '   mIdUnidadPorUnidad = oRs.Fields("IdUnidadPorUnidad").Value
    '   oRs.Close
    '
    '   'Set oF = New frmAviso
    '   With oF
    '      .Label1 = "Abriendo planilla Excel ..."
    '      .Show
    '      .Refresh
    '      DoEvents
    '   End With
    '
    '   oF.Label1 = oF.Label1 & vbCrLf & "Procesando requerimientos ..."
    '   oF.Label2 = ""
    '   oF.Label3 = ""
    '   DoEvents
    '
    '   fl = 6
    '
    '   Set oEx = CreateObject("Excel.Application")
    '   With oEx
    '
    '      .Visible = True
    '      .WindowState = xlMinimized
    '      Me.Refresh
    '
    '      With .Workbooks.Open(mArchivo)
    '         .Sheets("RM").Select
    '         With .ActiveSheet
    '            Do While True
    '
    '               If Len(Trim(.Cells(fl, 2))) = 0 Then
    '                  Exit Do
    '               End If
    '
    '               mConProblemas = False
    '
    '               mContador = mContador + 1
    '               oF.Label2 = "Comprobante : " & .Cells(fl, 2)
    '               oF.Label3 = "" & mContador
    '               DoEvents
    '
    '               mNumeroRM = CLng(.Cells(fl, 2))
    '               If IsDate(.Cells(fl, 3)) Then
    '                  mFecha = CDate(.Cells(fl, 3))
    '               Else
    '                  mFecha = Date
    '               End If
    '               mObra = .Cells(fl, 4)
    '               mLegajoSolicito = CLng(.Cells(fl, 5))
    '               mSectorSolicitante = .Cells(fl, 6)
    '               mLugarEntrega = .Cells(fl, 7)
    '               mDetalle = .Cells(fl, 8)
    '
    '               Set oRsAux = oAp.Requerimientos.TraerFiltrado("_PorNumero", mNumeroRM)
    '               If oRsAux.RecordCount > 0 Then
    '                  AgregarMensajeProcesoPresto oRsErrores, "El requerimiento " & mNumeroRM & _
    '                        " ya existe, toda la RM fue rechazada."
    '                  mConProblemas = True
    '               End If
    '               oRsAux.Close
    '
    '               mIdObra = 0
    '               Set oRsAux = oAp.Obras.TraerFiltrado("_PorNumero", mObra)
    '               If oRsAux.RecordCount > 0 Then
    '                  mIdObra = oRsAux.Fields(0).Value
    '               End If
    '               oRsAux.Close
    '
    '               mIdSolicito = 0
    '               Set oRsAux = oAp.Empleados.TraerFiltrado("_PorLegajo", mLegajoSolicito)
    '               If oRsAux.RecordCount > 0 Then
    '                  mIdSolicito = oRsAux.Fields(0).Value
    '               End If
    '               oRsAux.Close
    '
    '               mIdSector = 0
    '               Set oRsAux = oAp.Sectores.TraerFiltrado("_PorDescripcion", mSectorSolicitante)
    '               If oRsAux.RecordCount > 0 Then
    '                  mIdSector = oRsAux.Fields(0).Value
    '               End If
    '               oRsAux.Close
    '
    '               If Not mConProblemas Then
    '
    '                  Set oReq = oAp.Requerimientos.Item(-1)
    '                  With oReq
    '                     With .Registro
    '                        .Fields("Confirmado").Value = "NO"
    '                        .Fields("NumeroRequerimiento").Value = mNumeroRM
    '                        .Fields("FechaRequerimiento").Value = mFecha
    '                        If mIdObra <> 0 Then .Fields("IdObra").Value = mIdObra
    '                        .Fields("LugarEntrega").Value = mLugarEntrega
    '                        If mIdSolicito <> 0 Then .Fields("IdSolicito").Value = mIdSolicito
    '                        If mIdSector <> 0 Then .Fields("IdSector").Value = mIdSector
    '                        .Fields("IdMoneda").Value = mIdMonedaPesos
    '                        .Fields("Detalle").Value = mDetalle
    '                     End With
    '                  End With
    '
    '                  Do While Len(Trim(.Cells(fl, 2))) <> 0 And mNumeroRM = CLng(.Cells(fl, 2))
    '                     mItem = CInt(.Cells(fl, 9))
    '                     mCodigoMaterial = .Cells(fl, 10)
    '                     mMaterial = .Cells(fl, 11)
    '                     mCantidad = CDbl(.Cells(fl, 12))
    '                     mUnidad = .Cells(fl, 13)
    '                     If IsDate(.Cells(fl, 14)) Then
    '                        mFechaNecesidad = CDate(.Cells(fl, 14))
    '                     Else
    '                        mFechaNecesidad = mFecha
    '                     End If
    '                     mAdjunto1 = .Cells(fl, 15)
    '                     mAdjunto2 = .Cells(fl, 16)
    '                     mObservaciones = .Cells(fl, 17)
    '                     mNumeroFactura = CLng(.Cells(fl, 18))
    '                     mFechaFactura = CDate(.Cells(fl, 19))
    '                     mProveedor = .Cells(fl, 20)
    '                     mImporte = CDbl(.Cells(fl, 21))
    '
    '                     mIdArticulo = 0
    '                     Set oRsAux = oAp.Articulos.TraerFiltrado("_PorCodigo", mCodigoMaterial)
    '                     If oRsAux.RecordCount > 0 Then
    '                        mIdArticulo = oRsAux.Fields(0).Value
    '                     End If
    '                     oRsAux.Close
    '
    '                     mIdUnidad = 0
    '                     Set oRsAux = oAp.Unidades.TraerFiltrado("_PorAbreviatura", mUnidad)
    '                     If oRsAux.RecordCount > 0 Then
    '                        mIdUnidad = oRsAux.Fields(0).Value
    '                     End If
    '                     oRsAux.Close
    '
    '                     With oReq.DetRequerimientos.Item(-1)
    '                        With .Registro
    '                           .Fields("NumeroItem").Value = mItem
    '                           If mIdArticulo <> 0 Then
    '                              .Fields("IdArticulo").Value = mIdArticulo
    '                           Else
    '                              .Fields("Descripcionmanual").Value = mMaterial
    '                           End If
    '                           .Fields("Cantidad").Value = mCantidad
    '                           If mIdUnidad <> 0 Then .Fields("IdUnidad").Value = mIdUnidad
    '                           .Fields("FechaEntrega").Value = mFechaNecesidad
    '                           If Len(Trim(mAdjunto1)) > 0 Or Len(Trim(mAdjunto2)) > 0 Then
    '                              .Fields("Adjunto").Value = "SI"
    '                           Else
    '                              .Fields("Adjunto").Value = "NO"
    '                           End If
    '                           If Len(Trim(mAdjunto1)) > 0 Then .Fields("ArchivoAdjunto1").Value = mAdjunto1
    '                           If Len(Trim(mAdjunto2)) > 0 Then .Fields("ArchivoAdjunto2").Value = mAdjunto2
    '                           .Fields("EsBienDeUso").Value = "NO"
    '                           .Fields("Observaciones").Value = mObservaciones
    '                           .Fields("NumeroFacturaCompra1").Value = 0
    '                           .Fields("NumeroFacturaCompra2").Value = mNumeroFactura
    '                           .Fields("FechaFacturaCompra").Value = mFechaFactura
    '                           .Fields("ImporteFacturaCompra").Value = mImporte
    '                           .Fields("OrigenDescripcion").Value = 1
    '                           Select Case mObs
    '                              Case "01"
    '                                 .Fields("OrigenDescripcion").Value = 1
    '                              Case "02"
    '                                 .Fields("OrigenDescripcion").Value = 2
    '                              Case "03"
    '                                 .Fields("OrigenDescripcion").Value = 3
    '                           End Select
    '                        End With
    '                        .Modificado = True
    '                     End With
    '                     fl = fl + 1
    '                  Loop
    '
    '                  oReq.Guardar
    '                  Set oReq = Nothing
    '
    '               Else
    '
    '                  fl = fl + 1
    '
    '               End If
    '
    '            Loop
    '         End With
    '         .Close False
    '      End With
    '      .Quit
    '
    '   End With
    '
    '   Unload oF
    '   Set oF = Nothing
    '
    '   If Not oRsErrores Is Nothing Then
    '      If oRsErrores.RecordCount > 0 Then
    '         Set oF = New frmConsulta1
    '         With oF
    '            Set .RecordsetFuente = oRsErrores
    '            .Id = 13
    '            .Show vbModal, Me
    '         End With
    '      Else
    '         MsgBox "Proceso completo", vbInformation
    '      End If
    '      Set oRsErrores = Nothing
    '   End If
    '
    'Salida:
    '
    '   On Error Resume Next
    '
    '   Unload oF
    '   Set oF = Nothing
    '
    '   Set oRs = Nothing
    '   Set oRsErrores = Nothing
    '   Set oRsAux = Nothing
    '   Set oReq = Nothing
    '   Set oEx = Nothing
    '   Set oAp = Nothing
    '
    '   Exit Sub
    '
    'Mal:
    '
    '   MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    '   Resume Salida
    '
End Sub

Public Sub ImportacionCobranzas()

    Dim oAp As ComPronto.Aplicacion
    Dim oRec As ComPronto.Recibo
    Dim oRsAux1 As ADOR.Recordset
    Dim oF As Form
    Dim i As Integer, mIdMonedaPesos As Integer, mIdMonedaDolar As Integer
    Dim mIdPuntoVenta As Integer, mPuntoVenta As Integer, mIdMoneda As Integer
    Dim mCodigoDebeHaber As Integer
    Dim mImporte As Double, mDebe As Double, mHaber As Double, mTotalValores As Double
    Dim mNumeroValor As Double, mCotizacionMoneda As Double
    Dim mNumeroRecibo As Long, mCodigo As Long, mCodigoCuenta As Long, mIdCuenta As Long
    Dim mIdCaja As Long, mNumeroInterno As Long, mCodigoBanco As Long, mIdBanco As Long
    Dim mIdCuentaBancaria As Long, mIdCuentaValores As Long, mAuxL1 As Long
    Dim mArchivo As String, mError As String, mCuentaBanco As String
    Dim mFecha As Date, mFechaVencimiento As Date
    Dim mOk As Boolean, mConProblemas As Boolean
    Dim Filas, Columnas, mVector

    On Error GoTo Mal

    'Set oF = New frmPathPresto
    With oF
        .Id = 6
        .Show vbModal
        mOk = .Ok

        If mOk Then
            mArchivo = .FileBrowser1(0).Text
        End If

    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub

    Set oAp = Aplicacion

    Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
    mIdMonedaPesos = oRsAux1.Fields("IdMoneda").Value
    mIdMonedaDolar = oRsAux1.Fields("IdMonedaDolar").Value
    mIdCuentaValores = IIf(IsNull(oRsAux1.Fields("IdCuentaValores").Value), 0, oRsAux1.Fields("IdCuentaValores").Value)
    oRsAux1.Close
   
    mIdCaja = 0
    Set oRsAux1 = oAp.Cajas.TraerTodos

    If oRsAux1.RecordCount > 0 Then
        mIdCaja = oRsAux1.Fields(0).Value
    End If

    oRsAux1.Close
   
    'Set oF = New frmAviso
    With oF
        .Label1 = "Iniciando importacion ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Procesando ingresos en efectivo ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    mConProblemas = False
    mError = ""
    mTotalValores = 0
   
    Filas = VBA.Split(LeerArchivoSecuencial(mArchivo), vbCrLf)

    If UBound(Filas) > 0 Then
      
        For i = 0 To UBound(Filas)
         
            Columnas = VBA.Split(Filas(i), ",")

            If UBound(Columnas) > 1 Then
            
                Select Case Columnas(0)
               
                    Case "C"

                        If Not oRec Is Nothing Then
                            mError = mError & vbCrLf & "El recibo " & mNumeroRecibo & " no tiene el terminador y no fue tomado"
                            Set oRec = Nothing
                        End If
                  
                        mConProblemas = False
                        mTotalValores = 0
                  
                        mVector = VBA.Split(Columnas(1), "-")
                        mPuntoVenta = CInt(mVector(0))
                        mNumeroRecibo = CLng(mVector(1))
                        mFecha = CDate(Columnas(2))
                        mIdMoneda = CInt(Columnas(3))
                        mCodigoCuenta = CLng(Columnas(4))
                  
                        mIdPuntoVenta = 0
                        Set oRsAux1 = oAp.PuntosVenta.TraerFiltrado("_PorIdTipoComprobantePuntoVenta", Array(2, mPuntoVenta))

                        If oRsAux1.RecordCount > 0 Then
                            mIdPuntoVenta = oRsAux1.Fields(0).Value
                        Else
                            mError = mError & vbCrLf & "El recibo " & mNumeroRecibo & " no tiene punto de venta valido y no fue tomado"
                            mConProblemas = True
                        End If

                        oRsAux1.Close
                  
                        mIdCuenta = 0
                        Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuenta)

                        If oRsAux1.RecordCount > 0 Then
                            mIdCuenta = oRsAux1.Fields(0).Value
                        Else
                            mError = mError & vbCrLf & "El recibo " & mNumeroRecibo & " no tiene una cuenta contable valida y no fue tomado"
                            mConProblemas = True
                        End If

                        oRsAux1.Close
                  
                        Set oRsAux1 = oAp.Recibos.TraerFiltrado("_PorIdPuntoVenta_Numero", Array(mIdPuntoVenta, mNumeroRecibo))

                        If oRsAux1.RecordCount > 0 Then
                            mError = mError & vbCrLf & "El recibo " & mNumeroRecibo & " ya existe y no fue tomado"
                            mConProblemas = True
                        End If

                        oRsAux1.Close
                  
                        If mIdMonedaPesos = mIdMoneda Then
                            mCotizacionMoneda = 1
                        Else
                            mCotizacionMoneda = Cotizacion(mFecha, mIdMoneda)

                            If mCotizacionMoneda = 0 Then
                                mError = mError & vbCrLf & "El recibo " & mNumeroRecibo & " no tiene cotizacion para la moneda y no fue tomado"
                                mConProblemas = True
                            End If
                        End If
                  
                        Set oRec = oAp.Recibos.Item(-1)

                        With oRec
                            With .Registro
                                .Fields("NumeroRecibo").Value = mNumeroRecibo
                                .Fields("FechaRecibo").Value = mFecha
                                .Fields("IdPuntoVenta").Value = mIdPuntoVenta
                                .Fields("PuntoVenta").Value = mPuntoVenta
                                .Fields("Tipo").Value = "OT"
                                .Fields("IdCuenta").Value = mIdCuenta
                                .Fields("Efectivo").Value = 0
                                .Fields("Documentos").Value = 0
                                .Fields("Otros1").Value = 0
                                .Fields("Otros2").Value = 0
                                .Fields("Otros3").Value = 0
                                .Fields("Otros4").Value = 0
                                .Fields("Otros5").Value = 0
                                .Fields("Deudores").Value = 0
                                .Fields("RetencionIVA").Value = 0
                                .Fields("RetencionGanancias").Value = 0
                                .Fields("RetencionIBrutos").Value = 0
                                .Fields("GastosGenerales").Value = 0
                                .Fields("Cotizacion").Value = Cotizacion(mFecha, mIdMonedaDolar)
                                .Fields("IdMoneda").Value = mIdMoneda
                                .Fields("Dolarizada").Value = "NO"
                                .Fields("AsientoManual").Value = "SI"
                                .Fields("CotizacionMoneda").Value = mCotizacionMoneda
                                .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                            End With
                        End With
                  
                    Case "V"

                        If Not oRec Is Nothing Then
                     
                            If Columnas(1) = "EF" Then
                                mImporte = CDbl(Columnas(2))
                        
                                mIdCuenta = 0
                                mCodigoCuenta = 0
                        
                                mAuxL1 = mIdCaja

                                If UBound(Columnas) > 2 Then
                                    Set oRsAux1 = oAp.Cajas.TraerFiltrado("_PorCuentaContable", Columnas(3))

                                    If oRsAux1.RecordCount > 0 Then
                                        mAuxL1 = oRsAux1.Fields("IdCuenta").Value
                                        mIdCuenta = oRsAux1.Fields("IdCuenta").Value
                                        mCodigoCuenta = Columnas(3)
                                    End If

                                    oRsAux1.Close
                                End If

                                With oRec.DetRecibosValores.Item(-1)
                                    With .Registro
                                        .Fields("IdTipoValor").Value = 32
                                        .Fields("IdCaja").Value = mAuxL1
                                        .Fields("Importe").Value = mImporte
                                    End With

                                    .Modificado = True
                                End With

                                mTotalValores = mTotalValores + mImporte
                     
                                If mIdCuenta = 0 Then
                                    Set oRsAux1 = oAp.Cajas.TraerFiltrado("_TodosSF")

                                    If oRsAux1.RecordCount > 0 Then
                                        mIdCuenta = oRsAux1.Fields("IdCuenta").Value
                                        oRsAux1.Close
                                        Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorId", mIdCuenta)

                                        If oRsAux1.RecordCount > 0 Then
                                            mCodigoCuenta = oRsAux1.Fields("Codigo").Value
                                        End If

                                    Else
                                        mError = mError & vbCrLf & "En el recibo " & mNumeroRecibo & " vino un movimiento en efectivo y no hay cajas definidas"
                                        mConProblemas = True
                                    End If

                                    oRsAux1.Close
                                End If

                                With oRec.DetRecibosCuentas.Item(-1)
                                    With .Registro
                                        .Fields("IdCuenta").Value = mIdCuenta
                                        .Fields("CodigoCuenta").Value = mCodigoCuenta
                                        .Fields("Debe").Value = mImporte
                                        .Fields("IdMoneda").Value = mIdMoneda
                                        .Fields("CotizacionMonedaDestino").Value = mCotizacionMoneda
                                    End With

                                    .Modificado = True
                                End With
                     
                            ElseIf Columnas(1) = "CH" Then
                                mNumeroInterno = CLng(Columnas(2))
                                mCodigoBanco = CLng(Columnas(3))
                                mNumeroValor = CDbl(Columnas(4))
                                mFechaVencimiento = CDate(Columnas(5))
                                mImporte = CDbl(Columnas(6))
                        
                                mIdBanco = 0
                                Set oRsAux1 = oAp.Bancos.TraerFiltrado("_PorCodigoUnico", mCodigoBanco)

                                If oRsAux1.RecordCount > 0 Then
                                    mIdBanco = oRsAux1.Fields(0).Value
                                Else
                                    mError = mError & vbCrLf & "El recibo " & mNumeroRecibo & " tiene un valor de terceros de un banco invalido y no fue tomado (CH)"
                                    mConProblemas = True
                                End If

                                oRsAux1.Close
                        
                                With oRec.DetRecibosValores.Item(-1)
                                    With .Registro
                                        .Fields("IdTipoValor").Value = 6
                                        .Fields("NumeroValor").Value = mNumeroValor
                                        .Fields("NumeroInterno").Value = mNumeroInterno
                                        .Fields("FechaVencimiento").Value = mFechaVencimiento
                                        .Fields("IdBanco").Value = mIdBanco
                                        .Fields("Importe").Value = mImporte
                                    End With

                                    .Modificado = True
                                End With

                                mTotalValores = mTotalValores + mImporte
                        
                                mCodigoCuenta = 0
                                Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorId", mIdCuentaValores)

                                If oRsAux1.RecordCount > 0 Then
                                    mCodigoCuenta = oRsAux1.Fields("Codigo").Value
                                Else
                                    mError = mError & vbCrLf & "El recibo " & mNumeroRecibo & " tiene cheques de terceros y no esta definida la cuenta valores a depositar"
                                    mConProblemas = True
                                End If

                                oRsAux1.Close

                                With oRec.DetRecibosCuentas.Item(-1)
                                    With .Registro
                                        .Fields("IdCuenta").Value = mIdCuentaValores
                                        .Fields("CodigoCuenta").Value = mCodigoCuenta
                                        .Fields("Debe").Value = mImporte
                                        .Fields("IdMoneda").Value = mIdMoneda
                                        .Fields("CotizacionMonedaDestino").Value = mCotizacionMoneda
                                    End With

                                    .Modificado = True
                                End With
                     
                            ElseIf Columnas(1) = "TB" Then
                                mNumeroInterno = CLng(Columnas(2))
                                mCuentaBanco = CStr(Columnas(3))
                                mImporte = CDbl(Columnas(4))
                        
                                mIdBanco = 0
                                mIdCuentaBancaria = 0
                                Set oRsAux1 = oAp.CuentasBancarias.TraerFiltrado("_PorCuenta", mCuentaBanco)

                                If oRsAux1.RecordCount > 0 Then
                                    mIdBanco = oRsAux1.Fields("IdBanco").Value
                                    mIdCuentaBancaria = oRsAux1.Fields("IdCuentaBancaria").Value
                                Else
                                    mError = mError & vbCrLf & "El recibo " & mNumeroRecibo & " tiene una TB con una cuenta bancaria invalida y no fue tomado (TB)"
                                    mConProblemas = True
                                End If

                                oRsAux1.Close
                        
                                mIdCuenta = 0
                                Set oRsAux1 = oAp.Bancos.TraerFiltrado("_PorId", mIdBanco)

                                If oRsAux1.RecordCount > 0 Then
                                    mIdCuenta = IIf(IsNull(oRsAux1.Fields("IdCuenta").Value), 0, oRsAux1.Fields("IdCuenta").Value)
                                Else
                                    mError = mError & vbCrLf & "El recibo " & mNumeroRecibo & " tiene un banco invalido y no fue tomado (TB)"
                                    mConProblemas = True
                                End If

                                oRsAux1.Close
                        
                                With oRec.DetRecibosValores.Item(-1)
                                    With .Registro
                                        .Fields("IdTipoValor").Value = 21
                                        .Fields("NumeroTransferencia").Value = mNumeroInterno
                                        .Fields("IdCuentaBancariaTransferencia").Value = mIdCuentaBancaria
                                        .Fields("Importe").Value = mImporte
                                    End With

                                    .Modificado = True
                                End With

                                mTotalValores = mTotalValores + mImporte
                        
                                mCodigoCuenta = 0
                                Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorId", mIdCuenta)

                                If oRsAux1.RecordCount > 0 Then
                                    mCodigoCuenta = oRsAux1.Fields("Codigo").Value
                                Else
                                    mError = mError & vbCrLf & "El recibo " & mNumeroRecibo & " tiene una TB desde un banco sin cuenta contable (TB)"
                                    mConProblemas = True
                                End If

                                oRsAux1.Close

                                With oRec.DetRecibosCuentas.Item(-1)
                                    With .Registro
                                        .Fields("IdCuenta").Value = mIdCuenta
                                        .Fields("CodigoCuenta").Value = mCodigoCuenta
                                        .Fields("Debe").Value = mImporte
                                        .Fields("IdMoneda").Value = mIdMoneda
                                        .Fields("CotizacionMonedaDestino").Value = mCotizacionMoneda
                                    End With

                                    .Modificado = True
                                End With
                     
                            ElseIf Columnas(1) = "DB" Then
                                mCodigoCuenta = CLng(Columnas(2))
                                mImporte = CDbl(Columnas(3))
            
                                mIdCuenta = 0
                                Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuenta)

                                If oRsAux1.RecordCount > 0 Then
                                    mIdCuenta = oRsAux1.Fields(0).Value
                                Else
                                    mError = mError & vbCrLf & "El recibo " & mNumeroRecibo & " tiene un DB con una cuenta contable invalida y no fue tomado (DB)"
                                    mConProblemas = True
                                End If

                                oRsAux1.Close
                        
                                With oRec.DetRecibosValores.Item(-1)
                                    With .Registro
                                        .Fields("IdTipoValor").Value = 22
                                        .Fields("IdCuenta").Value = mIdCuenta
                                        .Fields("Importe").Value = mImporte
                                    End With

                                    .Modificado = True
                                End With

                                mTotalValores = mTotalValores + mImporte
                        
                                With oRec.DetRecibosCuentas.Item(-1)
                                    With .Registro
                                        .Fields("IdCuenta").Value = mIdCuenta
                                        .Fields("CodigoCuenta").Value = mCodigoCuenta
                                        .Fields("Debe").Value = mImporte
                                        .Fields("IdMoneda").Value = mIdMoneda
                                        .Fields("CotizacionMonedaDestino").Value = mCotizacionMoneda
                                    End With

                                    .Modificado = True
                                End With

                            End If
                        End If
               
                    Case "A"

                        If Not oRec Is Nothing Then
                            mCodigoCuenta = CLng(Columnas(1))
                            mImporte = CDbl(Columnas(2))
         
                            mIdCuenta = 0
                            Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuenta)

                            If oRsAux1.RecordCount > 0 Then
                                mIdCuenta = oRsAux1.Fields(0).Value
                            Else
                                mError = mError & vbCrLf & "El recibo " & mNumeroRecibo & " tiene una cuenta contable invalida en el asiento y no fue tomado"
                                mConProblemas = True
                            End If

                            oRsAux1.Close
                     
                            With oRec.DetRecibosCuentas.Item(-1)
                                With .Registro
                                    .Fields("IdCuenta").Value = mIdCuenta
                                    .Fields("CodigoCuenta").Value = mCodigoCuenta
                                    .Fields("Haber").Value = mImporte
                                    .Fields("IdMoneda").Value = mIdMoneda
                                    .Fields("CotizacionMonedaDestino").Value = mCotizacionMoneda
                                End With

                                .Modificado = True
                            End With

                        End If
            
                    Case "T"

                        If Not oRec Is Nothing Then
                            If Not mConProblemas Then

                                With oRec
                                    With .Registro
                                        .Fields("Valores").Value = mTotalValores
                                        .Fields("FechaIngreso").Value = Now
                                    End With

                                    .Guardar
                                End With

                            End If

                            Set oRec = Nothing
                        End If
            
                End Select
            
            End If
         
        Next
      
    End If
            
    If Len(mError) > 0 Then
        MsgBox "El proceso reporta los siguientes problemas :" & mError
    End If

Salida:

    Unload oF
    Set oF = Nothing

    Set oRsAux1 = Nothing
    Set oRec = Nothing
    Set oAp = Nothing

    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub EnviarNovedades_PRONTO_SAT()

    Dim oAp As ComPronto.Aplicacion
    Dim oPar As ComPronto.Parametro
    Dim oRs As ADOR.Recordset
    Dim oRsArch As ADOR.Recordset
    Dim oRsDest As ADOR.Recordset
    Dim oRsLote As ADOR.Recordset
    Dim goMailOL As CEmailOL
    Dim oTransmision As ComPronto.ArchivoATransmitirLoteo
    Dim oF As Form
    Dim sXML As String, mLista As String, mSubject As String, mBody As String
    Dim mAttachment As String, mPathSaliente As String, mLote As String, mSetear As String
    Dim mArchivo As String
    Dim lStatus As Long, mNumeroLote As Long
    Dim mOk As Boolean, mOutlook As Boolean, mProcesado As Boolean
    Dim mIdObra As Integer
    Dim oXML As MSXML.DOMDocument
   
    On Error GoTo Mal
   
    Set oF = New frm_Aux

    With oF
        .text1.Visible = False
        .Label1.Visible = False

        With .Check1
            .top = oF.Label1.top
            .left = oF.Label1.left
            .Width = oF.Label1.Width * 2
            .Caption = "Enviar por Outlook :"
            .Visible = True
        End With

        .Caption = "Novedades a PRONTO SAT"
        .Show vbModal, Me
        mOk = .Ok

        If .Check1.Value = 1 Then
            mOutlook = True
        Else
            mOutlook = False
        End If

    End With

    Unload oF

    If Not mOk Then Exit Sub
   
    Set oF = New frmInformacion

    With oF
        .Label1.Caption = "PROCESAMIENTO DE INFORMACION PARA TRANSMISION DE DATOS A PRONTO SAT"
        .Show , Me
    End With
   
    Set oAp = Aplicacion
   
    Set oPar = oAp.Parametros.Item(1)

    If Not IsNull(oPar.Registro.Fields("PathEnvioEmails").Value) Then
        mPathSaliente = oPar.Registro.Fields("PathEnvioEmails").Value
    Else
        mPathSaliente = "C:\"
    End If

    Set oPar = Nothing
   
    Set oRs = oAp.TablasGenerales.TraerFiltrado("ArchivosATransmitir", "_PorSistema", "SAT")
   
    If oRs.RecordCount > 0 Then
      
        If mOutlook Then Set goMailOL = New CEmailOL
         
        Do While Not oRs.EOF
      
            mArchivo = oRs.Fields("Tabla").Value
            oF.Label2.Caption = "Procesando archivo : " & mArchivo

            DoEvents
         
            sXML = ""
            mProcesado = True

            Select Case mArchivo

                Case "Articulos"
                    Set oRsArch = oAp.Articulos.TraerFiltrado("_ParaTransmitir")

                Case "Rubros"
                    Set oRsArch = oAp.Rubros.TraerFiltrado("_ParaTransmitir")

                Case "Subrubros"
                    Set oRsArch = oAp.Subrubros.TraerFiltrado("_ParaTransmitir")

                Case "Familias"
                    Set oRsArch = oAp.Familias.TraerFiltrado("_ParaTransmitir")

                Case "Obras"
                    Set oRsArch = oAp.Obras.TraerFiltrado("_ParaTransmitir")

                Case "Equipos"
                    Set oRsArch = oAp.Equipos.TraerFiltrado("_ParaTransmitir")

                Case "DetEquipos"
                    Set oRsArch = oAp.TablasGenerales.TraerFiltrado("DetEquipos", "_ParaTransmitir")

                Case "Planos"
                    Set oRsArch = oAp.Planos.TraerFiltrado("_ParaTransmitir")

                Case "ArchivosATransmitirDestinos"
                    Set oRsArch = oAp.ArchivosATransmitirDestinos.TraerFiltrado("_Todos")

                Case "Ubicaciones"
                    mProcesado = False

                Case "Depositos"
                    mProcesado = False

                Case "Proveedores"
                    Set oRsArch = oAp.Proveedores.TraerFiltrado("_ParaTransmitir")

                Case "Transportistas"
                    Set oRsArch = oAp.Transportistas.TraerFiltrado("_ParaTransmitir")

                Case "Pedidos"
                    mProcesado = False

                Case "DetPedidos"
                    mProcesado = False

                Case "Localidades"
                    Set oRsArch = oAp.Localidades.TraerFiltrado("_ParaTransmitir")

                Case "Provincias"
                    Set oRsArch = oAp.Provincias.TraerFiltrado("_ParaTransmitir")

                Case "Paises"
                    Set oRsArch = oAp.Paises.TraerFiltrado("_ParaTransmitir")

                Case "Monedas"
                    Set oRsArch = oAp.Monedas.TraerFiltrado("_ParaTransmitir")

                Case "Sectores"
                    Set oRsArch = oAp.Sectores.TraerFiltrado("_ParaTransmitir")

                Case "Cuentas"
                    Set oRsArch = oAp.Cuentas.TraerFiltrado("_ParaTransmitir")

                Case "UnidadesOperativas"
                    Set oRsArch = oAp.UnidadesOperativas.TraerFiltrado("_ParaTransmitir")

                Case "Unidades"
                    Set oRsArch = oAp.Unidades.TraerFiltrado("_ParaTransmitir_Todos")

                Case "Empleados"
                    Set oRsArch = oAp.Empleados.TraerFiltrado("_ParaTransmitir_Todos")

                Case "DescripcionIva"
                    Set oRsArch = oAp.TablasGenerales.TraerTodos("DescripcionIva")

                Case "Cotizaciones"
                    Set oRsArch = oAp.Cotizaciones.TraerFiltrado("_ParaTransmitir")

                Case Else
                    mProcesado = False
            End Select
      
            If mProcesado Then
                If oRsArch.RecordCount > 0 Then sXML = ArmarXML(oRsArch)
            End If
         
            Set oRsDest = oAp.ArchivosATransmitirDestinos.TraerFiltrado("_ActivosPorSistema", "SAT")
         
            If Not oRsDest.RecordCount > 0 Then
                oRsDest.Close
                MsgBox "No hay destinos definidos para transmitir!", vbExclamation
                GoTo Salida
            End If
         
            oRsDest.MoveFirst

            Do While Not oRsDest.EOF
                mIdObra = 0

                If Not IsNull(oRsDest.Fields("IdObra").Value) Then
                    mIdObra = oRsDest.Fields("IdObra").Value
                End If
                  
                Select Case mArchivo

                    Case "Ubicaciones"
                        Set oRsArch = oAp.Ubicaciones.TraerFiltrado("_ParaTransmitir", mIdObra)
                        sXML = ""

                        If oRsArch.RecordCount > 0 Then sXML = ArmarXML(oRsArch)

                    Case "Depositos"
                        Set oRsArch = oAp.Depositos.TraerFiltrado("_ParaTransmitir", mIdObra)
                        sXML = ""

                        If oRsArch.RecordCount > 0 Then sXML = ArmarXML(oRsArch)

                    Case "Pedidos"
                        Set oRsArch = oAp.Pedidos.TraerFiltrado("_ParaTransmitir", mIdObra)
                        sXML = ""

                        If oRsArch.RecordCount > 0 Then sXML = ArmarXML(oRsArch)

                    Case "DetPedidos"
                        Set oRsArch = oAp.TablasGenerales.TraerFiltrado("DetPedidos", "_ParaTransmitir", mIdObra)
                        sXML = ""

                        If oRsArch.RecordCount > 0 Then sXML = ArmarXML(oRsArch)

                    Case "SalidasMateriales"
                        Set oRsArch = oAp.SalidasMateriales.TraerFiltrado("_ParaTransmitir", mIdObra)
                        sXML = ""

                        If oRsArch.RecordCount > 0 Then sXML = ArmarXML(oRsArch)

                    Case "DetRequerimientos"
                        Set oRsArch = oAp.TablasGenerales.TraerFiltrado("DetRequerimientos", "_ParaTransmitir", mIdObra)
                        sXML = ""

                        If oRsArch.RecordCount > 0 Then sXML = ArmarXML(oRsArch)
                End Select

                Set oRsArch = Nothing
            
                If Len(sXML) > 0 Then
                    Set oRsLote = oAp.ArchivosATransmitirLoteo.TraerFiltrado("_UltimoLote", Array(oRsDest.Fields("IdArchivoATransmitirDestino").Value, oRs.Fields("IdArchivoATransmitir").Value))
                    mNumeroLote = 1

                    If oRsLote.RecordCount > 0 Then
                        If Not IsNull(oRsLote.Fields("Lote").Value) Then
                            mNumeroLote = oRsLote.Fields("Lote").Value + 1
                        End If
                    End If

                    oRsLote.Close
               
                    mLote = Format(mNumeroLote, "00000")
                    mLista = IIf(IsNull(oRsDest.Fields("Email").Value), "", oRsDest.Fields("Email").Value)
                    mSubject = glbEmpresaSegunString & "_" & IIf(IsNull(oRsDest.Fields("Email").Value), "", oRsDest.Fields("Email").Value) & "_" & mArchivo & "_L" & mLote
                    mBody = "" & vbCrLf & mArchivo & "."
                    mAttachment = mPathSaliente & mSubject & ".XML"
               
                    Set oXML = CreateObject("MSXML.DOMDocument")
                    oXML.loadXML sXML
                    oXML.Save mAttachment
                    Set oXML = Nothing
            
                    If mOutlook Then
                        lStatus = goMailOL.Send(mLista, True, mSubject, mBody, mAttachment)
                    End If
               
                    Set oTransmision = oAp.ArchivosATransmitirLoteo.Item(-1)

                    With oTransmision.Registro
                        .Fields("IdArchivoATransmitir").Value = oRs.Fields("IdArchivoATransmitir").Value
                        .Fields("FechaTransmision").Value = Now
                        .Fields("IdArchivoATransmitirDestino").Value = oRsDest.Fields("IdArchivoATransmitirDestino").Value
                        .Fields("NumeroLote").Value = mNumeroLote
                        .Fields("Confirmado").Value = "NO"
                    End With

                    oTransmision.Guardar
                    Set oTransmision = Nothing
                End If
            
                oRsDest.MoveNext
                  
            Loop

            oRsDest.Close
            Set oRsDest = Nothing
         
            oRs.MoveNext
        Loop
   
        oRs.MoveFirst

        Do While Not oRs.EOF
            mArchivo = oRs.Fields("Tabla").Value
         
            Select Case mArchivo

                Case "Articulos"
                    mSetear = "Articulos_TX_SetearComoTransmitido"

                Case "Rubros"
                    mSetear = "Rubros_TX_SetearComoTransmitido"

                Case "Subrubros"
                    mSetear = "Subrubros_TX_SetearComoTransmitido"

                Case "Familias"
                    mSetear = "Familias_TX_SetearComoTransmitido"

                Case "Obras"
                    mSetear = "Obras_TX_SetearComoTransmitido"

                Case "Equipos"
                    mSetear = "Equipos_TX_SetearComoTransmitido"

                Case "DetEquipos"
                    mSetear = "DetEquipos_TX_SetearComoTransmitido"

                Case "Planos"
                    mSetear = "Planos_TX_SetearComoTransmitido"

                Case "ArchivosATransmitirDestinos"

                Case "Ubicaciones"

                Case "Depositos"

                Case "Proveedores"
                    mSetear = "Proveedores_TX_SetearComoTransmitido"

                Case "Transportistas"
                    mSetear = "Transportistas_TX_SetearComoTransmitido"

                Case "Pedidos"
                    mSetear = "Pedidos_TX_SetearComoTransmitido"

                Case "DetPedidos"
                    oAp.Tarea "DetPedidos_TX_SetearComoTransmitido", mIdObra

                Case "Localidades"
                    mSetear = "Localidades_TX_SetearComoTransmitido"

                Case "Provincias"
                    mSetear = "Provincias_TX_SetearComoTransmitido"

                Case "Paises"
                    mSetear = "Paises_TX_SetearComoTransmitido"

                Case "Monedas"
                    mSetear = "Monedas_TX_SetearComoTransmitido"

                Case "Sectores"
                    mSetear = "Sectores_TX_SetearComoTransmitido"

                Case "Cuentas"
                    mSetear = "Cuentas_TX_SetearComoTransmitido"

                Case "UnidadesOperativas"
                    mSetear = "UnidadesOperativas_TX_SetearComoTransmitido"

                Case "Unidades"

                Case "SalidasMateriales"
                    oAp.Tarea "SalidasMateriales_TX_SetearComoTransmitido", mIdObra

                Case "DetRequerimientos"
                    oAp.Tarea "DetRequerimientos_TX_SetearComoTransmitido", mIdObra
            End Select
         
            If Len(mSetear) > 0 Then oAp.Tarea mSetear
         
            oRs.MoveNext
        Loop
   
    Else
   
        MsgBox "No hay archivos definidos para transmitir", vbExclamation
   
    End If

    oRs.Close
   
Salida:
    Unload oF
    Set oF = Nothing
    Set oRs = Nothing
    Set oRsArch = Nothing
    Set oRsDest = Nothing
    Set oRsLote = Nothing
    Set oAp = Nothing
    Set goMailOL = Nothing
   
    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub ImportarNovedades_PRONTO_SAT()

    Dim oAp As ComPronto.Aplicacion
    Dim oPar As ComPronto.Parametro
    Dim oRs As ADOR.Recordset
    Dim goMailOL As CEmailOL
    Dim oTransmision As ComPronto.ArchivoATransmitirLoteo
    Dim oF As Form
    Dim sXML As String, mLista As String, mSubject As String, mBody As String
    Dim mAttachment As String, mPathEntrante As String, mArchivos As String
    Dim mAuxS1 As String
    Dim mDatos1() As String
    Dim mDatos2() As String
    Dim mDatos3() As String
    Dim lStatus As Long, mLote As Long, mIdDestino As Long
    Dim i As Integer, j As Integer
    Dim mOk As Boolean, mOutlook As Boolean
    Dim est As EnumAcciones
    Dim oXML As MSXML.DOMDocument
   
    On Error GoTo Mal
   
    Set oF = New frm_Aux

    With oF
        .text1.Visible = False
        .Label1.Visible = False

        With .Check1
            .top = oF.Label1.top
            .left = oF.Label1.left
            .Width = oF.Label1.Width * 2
            .Caption = "Leer desde Outlook :"
            .Visible = True
        End With

        .Caption = "Novedades desde PRONTO SAT"
        .Show vbModal, Me
        mOk = .Ok

        If .Check1.Value = 1 Then
            mOutlook = True
        Else
            mOutlook = False
        End If

    End With

    Unload oF

    If Not mOk Then Exit Sub
   
    Set oAp = Aplicacion
   
    Set oPar = oAp.Parametros.Item(1)
    mPathEntrante = oPar.Registro.Fields("PathRecepcionEmails").Value
    Set oPar = Nothing
   
    Set oF = New frmInformacion
    oF.Label1.Caption = "INCORPORACION DE INFORMACION ENVIADA DESDE PRONTO SAT"
    oF.Show , Me
   
    If mOutlook Then
        Set goMailOL = New CEmailOL
        lStatus = goMailOL.Leer(mPathEntrante, oF)
    End If
   
    mArchivos = Dir(mPathEntrante & "*.XML", vbArchive)
   
    If Not mArchivos = "" Then

        Do While mArchivos <> ""
            mDatos3 = VBA.Split(mId$(mArchivos, 1, InStrRev(mArchivos, ".") - 1), "_")
            mAuxS1 = mDatos3(2)

            If UBound(mDatos3) > 3 Then
                mAuxS1 = mAuxS1 & "|" & mDatos3(4) & "|" & glbIdUsuario
            Else
                mAuxS1 = mAuxS1 & "|" & Year(Date) & Format(Month(Date), "00") & Format(Day(Date), "00") & "|" & glbIdUsuario
            End If
         
            oF.Label2.Caption = "Procesando archivo : " & mDatos3(2)

            DoEvents
         
            Set oXML = CreateObject("MSXML.DOMDocument")
            Set oRs = CreateObject("ADOR.Recordset")
            oXML.Load mPathEntrante & mArchivos
            oRs.Open oXML
            Set oXML = Nothing
         
            mIdDestino = 0

            If oRs.RecordCount > 0 Then
                oRs.MoveFirst
                mIdDestino = oRs.Fields("IdOrigenTransmision").Value

                Select Case mDatos3(2)

                    Case "Requerimientos"

                        Do While Not oRs.EOF
                            oRs.Fields("Aprobo").Value = Null
                            oRs.MoveNext
                        Loop

                        oRs.MoveFirst

                    Case "LMateriales"

                        Do While Not oRs.EOF
                            oRs.Fields("Aprobo").Value = Null
                            oRs.MoveNext
                        Loop

                        oRs.MoveFirst
                End Select

            End If

            est = oAp.TablasGenerales.ActualizacionEnLotes(mAuxS1, oRs, mIdDestino)
            oRs.Close
            Set oRs = Nothing
         
            Kill mPathEntrante & mArchivos
         
            If mIdDestino <> 0 And mOutlook Then
                mLista = oAp.ArchivosATransmitirDestinos.Item(mIdDestino).Registro.Fields("Email").Value
                mSubject = mId$(mArchivos, 1, InStrRev(mArchivos, ".") - 1) & "_Ok"
                mBody = "Ok." & vbCrLf
                mAttachment = ""
                lStatus = goMailOL.Send(mLista, True, mSubject, mBody, mAttachment)
            End If
         
            mArchivos = Dir
        Loop

    End If
   
    'Registro de confirmacion de recepciones
    If mOutlook Then
        If Len(goMailOL.RespuestasOK) Then
            mDatos1 = VBA.Split(goMailOL.RespuestasOK, "|")

            For i = 0 To UBound(mDatos1)
                mDatos2 = VBA.Split(mDatos1(i), "_")
                Set oRs = oAp.ArchivosATransmitirLoteo.TraerFiltrado("_PorArchivoLote", Array(mDatos2(2), mDatos2(1), Val(mId(mDatos2(3), 2, 5))))

                If oRs.RecordCount > 0 Then
                    Set oTransmision = oAp.ArchivosATransmitirLoteo.Item(oRs.Fields(0).Value)

                    With oTransmision.Registro
                        .Fields("Confirmado").Value = "SI"
                        .Fields("FechaRecepcionOK").Value = Now
                    End With

                    oTransmision.Guardar
                    Set oTransmision = Nothing
                End If

                oRs.Close
            Next

        End If
    End If
   
Salida:
    Unload oF
    Set oF = Nothing
    Set oRs = Nothing
    Set oAp = Nothing
    Set goMailOL = Nothing
   
    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub EnviarNovedades_PRONTO_MANTENIMIENTO()

    Dim oAp As ComPronto.Aplicacion
    Dim oPar As ComPronto.Parametro
    Dim oRs As ADOR.Recordset
    Dim oRsArch As ADOR.Recordset
    Dim oRsDest As ADOR.Recordset
    Dim oRsLote As ADOR.Recordset
    Dim goMailOL As CEmailOL
    Dim oTransmision As ComPronto.ArchivoATransmitirLoteo
    Dim oF As Form
    Dim sXML As String, mLista As String, mSubject As String, mBody As String
    Dim mAttachment As String, mPathSaliente As String, mArchivo As String
    Dim lStatus As Long
    Dim mOk As Boolean, mOutlook As Boolean
    Dim oXML As MSXML.DOMDocument
   
    On Error GoTo Mal
   
    Set oF = New frm_Aux

    With oF
        .text1.Visible = False
        .Label1.Visible = False

        With .Check1
            .top = oF.Label1.top
            .left = oF.Label1.left
            .Width = oF.Label1.Width * 2
            .Caption = "Enviar por Outlook :"
            .Visible = True
        End With

        .Caption = "Novedades a PRONTO MANTENIMIENTO"
        .Width = .Width * 1.3
        .Show vbModal, Me
        mOk = .Ok

        If .Check1.Value = 1 Then
            mOutlook = True
        Else
            mOutlook = False
        End If

    End With

    Unload oF

    If Not mOk Then Exit Sub
   
    Set oF = New frmInformacion

    With oF
        .Label1.Caption = "PROCESAMIENTO DE INFORMACION PARA TRANSMISION DE DATOS A PRONTO MANTENIMIENTO"
        .Show , Me
    End With
   
    Set oAp = Aplicacion
   
    Set oPar = oAp.Parametros.Item(1)

    If Not IsNull(oPar.Registro.Fields("PathEnvioEmailsMANTENIMIENTO").Value) Then
        mPathSaliente = oPar.Registro.Fields("PathEnvioEmailsMANTENIMIENTO").Value
    Else
        mPathSaliente = "C:\"
    End If

    Set oPar = Nothing
   
    Set oRs = oAp.TablasGenerales.TraerFiltrado("ArchivosATransmitir", "_PorSistema", "MANTENIMIENTO")
   
    If oRs.RecordCount > 0 Then
      
        Set goMailOL = New CEmailOL
         
        Do While Not oRs.EOF
      
            mArchivo = oRs.Fields("Tabla").Value
            oF.Label2.Caption = "Procesando archivo : " & mArchivo

            DoEvents
         
            Select Case mArchivo

                Case "Articulos"
                    Set oRsArch = oAp.Articulos.TraerFiltrado("_ParaTransmitirPRONTO_MANTENIMIENTO")

                Case "Obras"
                    Set oRsArch = oAp.Obras.TraerFiltrado("_ParaTransmitir_Todos")

                Case "DetObrasDestinos"
                    Set oRsArch = oAp.TablasGenerales.TraerFiltrado("DetObrasDestinos", "_ParaTransmitir_Todos")

                    '            Case Else
                    '               MsgBox "Archivo : " & mArchivo & ", no definido!", vbExclamation
                    '               GoTo Salida
            End Select
      
            If Not oRsArch Is Nothing Then
         
                If oRsArch.RecordCount > 0 Then
            
                    Set oRsDest = oAp.ArchivosATransmitirDestinos.TraerFiltrado("_ActivosPorSistema", "MANTENIMIENTO")
               
                    If Not oRsDest.RecordCount > 0 Then
                        oRsDest.Close
                        MsgBox "No hay destinos definidos para transmitir!", vbExclamation
                        GoTo Salida
                    End If
               
                    sXML = ArmarXML(oRsArch)
               
                    Do While Not oRsDest.EOF
               
                        mLista = IIf(IsNull(oRsDest.Fields("Email").Value), "SinMail", oRsDest.Fields("Email").Value)
                        mSubject = "PRONTO_" & glbEmpresaSegunString & "_" & mLista & "_" & mArchivo & "_" & Replace(CStr(Date), "/", "-")
                        mBody = "" & vbCrLf & mArchivo & "."
                        mAttachment = mPathSaliente & mSubject & ".XML"
                  
                        Set oXML = CreateObject("MSXML.DOMDocument")
                        oXML.loadXML sXML
                        oXML.Save mAttachment
                        Set oXML = Nothing
               
                        If mOutlook Then
                            lStatus = goMailOL.Send(mLista, True, mSubject, mBody, mAttachment)
                        End If
                  
                        oRsDest.MoveNext
                  
                    Loop

                    oRsDest.Close
            
                Else
            
                    oRsArch.Close
            
                End If
         
            End If
         
            Set oRsArch = Nothing
            oRs.MoveNext
      
        Loop
   
    Else
   
        MsgBox "No hay archivos definidos para transmitir", vbExclamation
   
    End If

    oRs.Close
   
Salida:
    Unload oF
    Set oF = Nothing
    Set oRs = Nothing
    Set oRsArch = Nothing
    Set oRsDest = Nothing
    Set oRsLote = Nothing
    Set oAp = Nothing
    Set goMailOL = Nothing
   
    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub EnviarNovedades_PRONTO()

    Dim oAp As ComPronto.Aplicacion
    Dim oPar As ComPronto.Parametro
    Dim oRs As ADOR.Recordset
    Dim oRsArch As ADOR.Recordset
    Dim oRsDest As ADOR.Recordset
    Dim oRsLote As ADOR.Recordset
    Dim goMailOL As CEmailOL
    Dim oTransmision As ComPronto.ArchivoATransmitirLoteo
    Dim oF As Form
    Dim sXML As String, mLista As String, mSubject As String, mBody As String
    Dim mAttachment As String, mPathSaliente As String, mLote As String
    Dim mSetear As String, mArchivo As String, mPuntoVenta As String
    Dim mEmail As String, mTipoPRONTO As String, mRubrosArticulos As String
    Dim lStatus As Long, mNumeroLote As Long
    Dim mOk As Boolean, mOutlook As Boolean, mProcesado As Boolean
    Dim mEsPuntoVenta As Boolean
    Dim mIdObra As Integer
    Dim oXML As MSXML.DOMDocument
   
    '   On Error GoTo Mal
   
    mPuntoVenta = BuscarClaveINI("Punto de venta")

    If Len(mPuntoVenta) > 0 Then
        mTipoPRONTO = "PUNTO DE VENTAS"
        mEsPuntoVenta = True
    Else
        mTipoPRONTO = "PRONTO CENTRAL"
        mEsPuntoVenta = False
    End If
   
    Set oF = New frm_Aux

    With oF
        .text1.Visible = False
        .Label1.Visible = False

        With .Check1
            .top = oF.Label1.top
            .left = oF.Label1.left
            .Width = oF.Label1.Width * 2
            .Caption = "Enviar por Outlook :"
            .Visible = True
        End With

        .Caption = "Novedades a " & mTipoPRONTO
        .Show vbModal, Me
        mOk = .Ok

        If .Check1.Value = 1 Then
            mOutlook = True
        Else
            mOutlook = False
        End If

    End With

    Unload oF

    If Not mOk Then Exit Sub
   
    If mOutlook Then
        If mEsPuntoVenta Then
            mEmail = BuscarClaveINI("Email del punto de venta")
        Else
            mEmail = BuscarClaveINI("Email del PRONTO")
        End If

        If Len(mEmail) = 0 Then
            MsgBox "No existe definicion del email del " & mTipoPRONTO & " (Pronto.ini)", vbExclamation
            Exit Sub
        End If
    End If
   
    Set oF = New frmInformacion

    With oF
        .Label1.Caption = "PROCESAMIENTO DE INFORMACION PARA TRANSMISION DE DATOS A PRONTO CENTRAL"
        .Show , Me
    End With
   
    Set oAp = Aplicacion
   
    Set oPar = oAp.Parametros.Item(1)

    If Not IsNull(oPar.Registro.Fields("PathEnvioEmails").Value) Then
        mPathSaliente = oPar.Registro.Fields("PathEnvioEmails").Value
    Else
        mPathSaliente = "C:\"
    End If

    Set oPar = Nothing
   
    Set oRs = oAp.TablasGenerales.TraerFiltrado("ArchivosATransmitir", "_PorSistema", "PRONTO")
   
    If oRs.RecordCount > 0 Then
      
        If mOutlook Then Set goMailOL = New CEmailOL
         
        Do While Not oRs.EOF
            mArchivo = oRs.Fields("Tabla").Value
            oF.Label2.Caption = "Procesando archivo : " & mArchivo

            DoEvents
         
            Select Case mArchivo

                Case "Articulos"
                    mRubrosArticulos = BuscarClaveINI("Rubros de articulos para transmision")

                    If Len(mRubrosArticulos) = 0 Then
                        Set oRsArch = oAp.Articulos.TraerFiltrado("_ParaTransmitir")
                    Else
                        Set oRsArch = oAp.Articulos.TraerFiltrado("_ParaTransmitirPorIdRubros", mRubrosArticulos)
                    End If

                Case "Clientes"
                    Set oRsArch = oAp.Clientes.TraerFiltrado("_ParaTransmitir")

                Case "Facturas"
                    Set oRsArch = oAp.Facturas.TraerFiltrado("_ParaTransmitir")

                Case "DetFacturas"
                    Set oRsArch = oAp.TablasGenerales.TraerFiltrado("DetFacturas", "_ParaTransmitir")

                Case "Recibos"
                    Set oRsArch = oAp.Recibos.TraerFiltrado("_ParaTransmitir")

                Case "DetRecibos"
                    Set oRsArch = oAp.TablasGenerales.TraerFiltrado("DetRecibos", "_ParaTransmitir")

                Case "DetRecibosCuentas"
                    Set oRsArch = oAp.TablasGenerales.TraerFiltrado("DetRecibosCuentas", "_ParaTransmitir")

                Case "DetRecibosRubrosContables"
                    Set oRsArch = oAp.TablasGenerales.TraerFiltrado("DetRecibosRubrosContables", "_ParaTransmitir")

                Case "DetRecibosValores"
                    Set oRsArch = oAp.TablasGenerales.TraerFiltrado("DetRecibosValores", "_ParaTransmitir")

                Case "Subdiarios"
                    Set oRsArch = oAp.Subdiarios.TraerFiltrado("_ParaTransmitir")

                Case "Valores"
                    Set oRsArch = oAp.Valores.TraerFiltrado("_ParaTransmitir")

                Case "CtasCtesD"
                    Set oRsArch = oAp.CtasCtesD.TraerFiltrado("_ParaTransmitir")
            End Select
      
            sXML = ""

            If Not oRsArch Is Nothing Then
                If oRsArch.RecordCount > 0 Then sXML = ArmarXML(oRsArch)
            End If

            Set oRsArch = Nothing
         
            If Len(sXML) > 0 Then
                mLista = mEmail
                mSubject = glbEmpresaSegunString & "_" & mEmail & "_" & mArchivo & "_" & mPuntoVenta
                mBody = "" & vbCrLf & mArchivo & "."
                mAttachment = mPathSaliente & mSubject & ".XML"
            
                Set oXML = CreateObject("MSXML.DOMDocument")
                oXML.loadXML sXML
                oXML.Save mAttachment
                Set oXML = Nothing
         
                If mOutlook Then
                    lStatus = goMailOL.Send(mLista, True, mSubject, mBody, mAttachment)
                End If
            End If
         
            oRs.MoveNext
        Loop
   
        oRs.MoveFirst

        Do While Not oRs.EOF
            mArchivo = oRs.Fields("Tabla").Value
            mSetear = ""

            Select Case mArchivo

                Case "Articulos"
                    mSetear = "Articulos_TX_SetearComoTransmitido"

                Case "Clientes"
                    mSetear = "Clientes_TX_SetearComoTransmitido"

                Case "Facturas"
                    mSetear = "Facturas_TX_SetearComoTransmitido"

                Case "DetFacturas"
                    mSetear = "DetFacturas_TX_SetearComoTransmitido"

                Case "Recibos"
                    mSetear = "Recibos_TX_SetearComoTransmitido"

                Case "DetRecibos"
                    mSetear = "DetRecibos_TX_SetearComoTransmitido"

                Case "DetRecibosCuentas"
                    mSetear = "DetRecibosCuentas_TX_SetearComoTransmitido"

                Case "DetRecibosRubrosContables"
                    mSetear = "DetRecibosRubrosContables_TX_SetearComoTransmitido"

                Case "DetRecibosValores"
                    mSetear = "DetRecibosValores_TX_SetearComoTransmitido"

                Case "Subdiarios"
                    mSetear = "Subdiarios_TX_SetearComoTransmitido"

                Case "Valores"
                    mSetear = "Valores_TX_SetearComoTransmitido"

                Case "CtasCtesD"
                    mSetear = "CtasCtesD_TX_SetearComoTransmitido"
            End Select

            If Len(mSetear) > 0 Then
                oAp.Tarea mSetear
            End If

            oRs.MoveNext
        Loop
   
    Else
   
        MsgBox "No hay archivos definidos para transmitir", vbExclamation
   
    End If

    oRs.Close
   
Salida:
    Unload oF
    Set oF = Nothing
    Set oRs = Nothing
    Set oRsArch = Nothing
    Set oRsDest = Nothing
    Set oRsLote = Nothing
    Set oTransmision = Nothing
    Set oAp = Nothing
    Set goMailOL = Nothing
   
    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub ImportarNovedades_PRONTO()

    Dim oAp As ComPronto.Aplicacion
    Dim oPar As ComPronto.Parametro
    Dim oRs As ADOR.Recordset
    Dim oRs1 As ADOR.Recordset
    Dim goMailOL As CEmailOL
    Dim oTransmision As ComPronto.ArchivoATransmitirLoteo
    Dim oF As Form
    Dim sXML As String, mLista As String, mSubject As String, mBody As String
    Dim mAttachment As String, mPathEntrante As String, mArchivos As String
    Dim mTipoPRONTO As String, mPuntoVenta As String, mArchivosAProcesar As String
    Dim mDatos1() As String
    Dim mDatos2() As String
    Dim mDatos3() As String
    Dim lStatus As Long, mLote As Long, mIdDestino As Long
    Dim i As Integer, j As Integer
    Dim mOk As Boolean, mOutlook As Boolean, mEsPuntoVenta As Boolean
    Dim est As EnumAcciones
    Dim oXML As MSXML.DOMDocument
   
    '   On Error GoTo Mal
   
    mPuntoVenta = BuscarClaveINI("Punto de venta")

    If Len(mPuntoVenta) > 0 Then
        mTipoPRONTO = "PUNTO DE VENTAS"
        mEsPuntoVenta = True
        mArchivosAProcesar = "(Articulos)"
    Else
        mTipoPRONTO = "PRONTO CENTRAL"
        mEsPuntoVenta = False
        mArchivosAProcesar = "(Clientes)(Facturas)(DetFacturas)(Recibos)(DetRecibos)" & "(DetRecibosCuentas)(DetRecibosRubrosContables)" & "(DetRecibosValores)(Subdiarios)(CtasCtesD)(Valores)"
    End If
   
    Set oF = New frm_Aux

    With oF
        .text1.Visible = False
        .Label1.Visible = False

        With .Check1
            .top = oF.Label1.top
            .left = oF.Label1.left
            .Width = oF.Label1.Width * 2
            .Caption = "Leer desde Outlook :"
            .Visible = True
        End With

        .Caption = "Novedades desde " & mTipoPRONTO
        .Show vbModal, Me
        mOk = .Ok

        If .Check1.Value = 1 Then
            mOutlook = True
        Else
            mOutlook = False
        End If

    End With

    Unload oF

    If Not mOk Then Exit Sub
   
    Set oAp = Aplicacion
   
    Set oPar = oAp.Parametros.Item(1)
    mPathEntrante = oPar.Registro.Fields("PathRecepcionEmails").Value
    Set oPar = Nothing
   
    Set oF = New frmInformacion
    oF.Label1.Caption = "INCORPORACION DE INFORMACION ENVIADA DESDE " & mTipoPRONTO
    oF.Show , Me
   
    If mOutlook Then
        Set goMailOL = New CEmailOL
        lStatus = goMailOL.Leer(mPathEntrante, oF)
    End If
   
    mArchivos = Dir(mPathEntrante & "*.XML", vbArchive)
   
    If Not mArchivos = "" Then

        Do While mArchivos <> ""
            mDatos3 = VBA.Split(mId$(mArchivos, 1, InStrRev(mArchivos, ".") - 1), "_")

            If InStr(1, mArchivosAProcesar, "(" & mDatos3(2) & ")") <> 0 Then
                oF.Label2.Caption = "Procesando archivo : " & mDatos3(2)

                DoEvents
            
                Set oXML = CreateObject("MSXML.DOMDocument")
                Set oRs = CreateObject("ADOR.Recordset")
                oXML.Load mPathEntrante & mArchivos
                oRs.Open oXML
                Set oXML = Nothing
            
                mIdDestino = 0

                If Len(mDatos3(3)) > 0 And IsNumeric(mDatos3(3)) Then
                    mIdDestino = CLng(mDatos3(3))
                End If
            
                'Set oRs1 = CopiarTodosLosRegistros(oRs)
                est = oAp.TablasGenerales.ActualizacionEnLotes(mDatos3(2), oRs1, mIdDestino)
                oRs.Close
                Set oRs = Nothing
                Set oRs1 = Nothing
            
                Kill mPathEntrante & mArchivos
            
                '            If mOutlook Then
                '               mLista = oAp.ArchivosATransmitirDestinos.Item(mIdDestino).Registro.Fields("Email").Value
                '               mSubject = mId$(mArchivos, 1, InStrRev(mArchivos, ".") - 1) & "_Ok"
                '               mBody = "Ok." & vbCrLf
                '               mAttachment = ""
                '               lStatus = goMailOL.Send(mLista, True, mSubject, mBody, mAttachment)
                '            End If
            End If

            mArchivos = Dir
        Loop

    End If
   
    'Registro de confirmacion de recepciones
    '   If mOutlook Then
    '      If Len(goMailOL.RespuestasOK) Then
    '         mDatos1 = VBA.Split(goMailOL.RespuestasOK, "|")
    '         For i = 0 To UBound(mDatos1)
    '            mDatos2 = VBA.Split(mDatos1(i), "_")
    '            Set oRs = oAp.ArchivosATransmitirLoteo.TraerFiltrado("_PorArchivoLote", Array(mDatos2(2), mDatos2(1), Val(mId(mDatos2(3), 2, 5))))
    '            If oRs.RecordCount > 0 Then
    '               Set oTransmision = oAp.ArchivosATransmitirLoteo.Item(oRs.Fields(0).Value)
    '               With oTransmision.Registro
    '                  .Fields("Confirmado").Value = "SI"
    '                  .Fields("FechaRecepcionOK").Value = Now
    '               End With
    '               oTransmision.Guardar
    '               Set oTransmision = Nothing
    '            End If
    '            oRs.Close
    '         Next
    '      End If
    '   End If
   
Salida:
    Unload oF
    Set oF = Nothing
    Set oRs = Nothing
    Set oRs1 = Nothing
    Set oAp = Nothing
    Set goMailOL = Nothing
   
    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub PasarProveedorEventualADefinitivo()

    Dim Filas, Columnas
    Dim oF 'As frmProveedores
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)
    Columnas = VBA.Split(Filas(1), vbTab)

    If IsNumeric(Columnas(2)) Then

        'Set oF = New frmProveedores
        With oF
            .NivelAcceso = ControlAccesoNivel(Arbol.SelectedItem.Key)
            .OpcionesAcceso = ControlAccesoOpciones(Arbol.SelectedItem.Key)
            .DTPicker1(0).Value = Now
            .DTPicker1(1).Enabled = False
            .DTPicker1(2).Value = CDate("1/1/1980")
            .Option1.Value = True
            .Option8.Value = True
            .Option6.Value = True
            .Option13.Value = True
            .Option14.Value = True
            .Id = Columnas(2)
            .Check1.Value = 1
            .Show vbModal, Me
        End With

        Unload oF
        Set oF = Nothing
    End If

End Sub

Public Function Ultimo_NodoTitulo() As String

    If Not Arbol.SelectedItem Is Nothing Then
        If Len(Arbol.SelectedItem.Tag) = 0 Then
            Ultimo_NodoTitulo = Arbol.SelectedItem.Text
        Else
            Ultimo_NodoTitulo = Arbol.SelectedItem.Tag
        End If
    End If

End Function

Public Sub MarcarOrdenesCompraComoCumplidas(ByVal Marca As String)

    Dim iFilas As Integer
    Dim Filas, Columnas
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)

        If IsNumeric(Columnas(2)) Then
            Aplicacion.Tarea "OrdenesCompra_MarcarComoCumplidas", Array(Columnas(2), Marca)
        End If

    Next

    Arbol_NodeClick Arbol.SelectedItem

End Sub

Public Sub EmisionEtiquetasArticulos(ByVal mGetString As String)

    Dim iFilas As Integer, mCopias As Integer
    Dim s As String
    Dim mImprimir As Boolean
    Dim Filas, Columnas
   
    Filas = VBA.Split(mGetString, vbCrLf)
    s = ""

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)

        If IsNumeric(Columnas(3)) Then
            s = s & Columnas(3) & ","
        End If

    Next

    If Len(s) > 0 Then s = mId(s, 1, Len(s) - 1)
   
    Dim mvarOK As Boolean
    Dim oF As frm_Aux
   
    Set oF = New frm_Aux

    With oF
        .Caption = "Emision de etiquetas"
        .Label1.Caption = "Copias x articulo:"

        With .Check1
            .left = oF.Label2(1).left
            .top = oF.Label2(1).top
            .Width = oF.Label2(1).Width * 2
            .Caption = "Enviar a impresora :"
            .Value = 1
            .Visible = True
        End With

        .Show vbModal, Me
        mvarOK = .Ok

        If .Check1.Value = 0 Then
            mImprimir = False
        Else
            mImprimir = True
        End If

        mCopias = Val(.text1.Text)

        If mCopias = 0 Then mCopias = 1
    End With

    Unload oF
    Set oF = Nothing
   
    Me.Refresh

    If Not mvarOK Then
        Exit Sub
    End If
   
    On Error GoTo Mal
   
    Dim oW As Word.Application
   
    Set oW = CreateObject("Word.Application")
   
    With oW
        .Visible = True

        With .Documents.Add(glbPathPlantillas & "\EtiquetasArticulos_" & glbEmpresaSegunString)
            oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=s, varg3:=mCopias

            If mImprimir Then
                oW.ActiveDocument.PrintOut False, , , , , , , mCopias
                .Close False
            End If

        End With

        If mImprimir Then .Quit
    End With

Salida:

    Me.MousePointer = vbDefault
    Set oW = Nothing
    Exit Sub

Mal:

    If mImprimir Then oW.Quit
    Me.MousePointer = vbDefault
    MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub EmisionEtiquetasArticulosZebra(ByVal mGetString As String)

    Dim iFilas As Integer, mCopias As Integer, i As Integer
    Dim mValRet As Long
    Dim s As String, mZebra As String, mImpresoraZebra As String, mLinea(1) As String
    Dim Filas, Columnas
   
    Dim mvarOK As Boolean
    Dim oF As frm_Aux
   
    Set oF = New frm_Aux

    With oF
        .Caption = "Emision de etiquetas"
        .Label1.Caption = "Copias x articulo:"

        With .Label2(1)
            .Caption = "Impresora :"
            .Visible = True
        End With

        With .Text2
            .top = oF.DTFields(1).top
            .left = oF.DTFields(1).left
            .Text = BuscarClaveINI("Direccion impresora Zebra")
            .Visible = True
        End With

        .Show vbModal, Me
        mvarOK = .Ok
        mCopias = Val(.text1.Text)
        mImpresoraZebra = .Text2.Text

        If mCopias = 0 Then mCopias = 1
    End With

    Unload oF
    Set oF = Nothing
   
    Me.Refresh

    If Not mvarOK Then Exit Sub
    If Len(mImpresoraZebra) = 0 Then mImpresoraZebra = "lpt1"
   
    '   On Error GoTo Mal
   
    Dim fso As New FileSystemObject
   
    Set fso = CreateObject("Scripting.FileSystemObject")

    mLinea(0) = BuscarClaveINI("Etiquetas Zebra Linea 1")
    mLinea(1) = BuscarClaveINI("Etiquetas Zebra Linea 2")
   
    Filas = VBA.Split(mGetString, vbCrLf)
    mZebra = "" & vbCrLf & "N" & vbCrLf

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)

        '      If iFilas Mod 2 = 0 Then i = 1 Else i = 0
        '      mZebra = mZebra & mLinea(i) & Chr(34) & Columnas(1) & Chr(34) & vbCrLf
        '      If iFilas Mod 2 = 0 Then
        '         mZebra = mZebra & "P" & mCopias & vbCrLf
        '         GuardarArchivoSecuencial "c:\Zebra.txt", mZebra
        '         fso.CopyFile "c:\Zebra.txt", mImpresoraZebra
        '         mZebra = "" & vbCrLf & "N" & vbCrLf
        '      End If
        If Len(mLinea(1)) = 0 Then
            mZebra = mZebra & mLinea(0) & Chr(34) & Columnas(1) & Chr(34) & vbCrLf & "P" & mCopias & vbCrLf
        Else
            mZebra = mZebra & mLinea(0) & Chr(34) & Columnas(1) & Chr(34) & vbCrLf & mLinea(1) & Chr(34) & Columnas(1) & Chr(34) & vbCrLf & "P" & mCopias & vbCrLf
        End If

        GuardarArchivoSecuencial "c:\Zebra.txt", mZebra

        'GuardarArchivoSecuencial "c:\Zebra" & iFilas & ".txt", mZebra
        'i = ShellExecute(0, "print", "c:\Zebra.txt", "", "", 0)
        'i = Shell("c:\Imprime.bat", vbHide)

        EsperarShell ("c:\Imprime.bat")

        '      fso.CopyFile "c:\Zebra.txt", mImpresoraZebra
        mZebra = "" & vbCrLf & "N" & vbCrLf
    Next

    '   If iFilas Mod 2 = 0 Then
    '      mZebra = mZebra & "P" & mCopias & vbCrLf
    '      GuardarArchivoSecuencial "c:\Zebra.txt", mZebra
    '      fso.CopyFile "c:\Zebra.txt", mImpresoraZebra
    '   End If
   
Salida:

    Set fso = Nothing
    Me.MousePointer = vbDefault
    Exit Sub

Mal:

    Me.MousePointer = vbDefault
    MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub GeneracionDeFacturasDesdeOrdenesCompraAutomaticas()

    Dim oF As frmExcel1
    Set oF = New frmExcel1

    With oF
        .Codigo = "GenFac"
        .Titulo = "Generacion de facturas (desde ordenes de compra automaticas)"
        .Show vbModal, Me
    End With

    Unload oF
    Set oF = Nothing

End Sub

Public Sub ModificarVencimientosVentaEnCuotas()

    Dim oF As frm_Aux
    Dim oL As ListItem
    Dim oRs As ADOR.Recordset
    Dim Filas, Columnas
    Dim mvarOK As Boolean
    Dim mFecha1 As Date, mFecha2 As Date, mFecha3 As Date
    Dim mFechaVto1 As Date, mFechaVto2 As Date, mFechaVto3 As Date
    Dim mIdArticulo As Long
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)
    Columnas = VBA.Split(Filas(1), vbTab)
            
    Set oF = New frm_Aux

    With oF
        .Caption = "Cambiar fechas de vto."
        .text1.Visible = False
        .Label1.Visible = False

        With .Label2(2)
            .top = oF.Label2(1).top
            .left = oF.Label2(1).left
        End With

        With .DTFields(2)
            .top = oF.DTFields(1).top
            .left = oF.DTFields(1).left
        End With

        With .Label2(1)
            .top = oF.Label1.top
            .left = oF.Label1.left
        End With

        With .DTFields(1)
            .top = oF.text1.top
            .left = oF.text1.left
        End With

        With .Label2(0)
            .Caption = "1er. vto. :"
            .Visible = True
        End With

        With .Label2(1)
            .Caption = "2do. vto. :"
            .Visible = True
        End With

        With .Label2(2)
            .Caption = "3er. vto. :"
            .Visible = True
        End With

        With .DTFields(0)

            If IsDate(Columnas(6)) Then .Value = CDate(Columnas(6))
            .Visible = True
        End With

        With .DTFields(1)

            If IsDate(Columnas(7)) Then .Value = CDate(Columnas(7))
            .Visible = True
        End With

        With .DTFields(2)

            If IsDate(Columnas(8)) Then .Value = CDate(Columnas(8))
            .Visible = True
        End With

        .Show vbModal, Me
        mvarOK = .Ok
        mFecha1 = oF.DTFields(0).Value
        mFecha2 = oF.DTFields(1).Value
        mFecha3 = oF.DTFields(2).Value
    End With

    Unload oF
    Set oF = Nothing

    If Not mvarOK Then
        Exit Sub
    End If

    If IsNumeric(Columnas(4)) Then
        Set oRs = Aplicacion.VentasEnCuotas.TraerFiltrado("_CuotasGeneradasParaModificarVencimientos", Columnas(4))

        With oRs

            If .RecordCount > 0 Then
                .MoveFirst
                mIdArticulo = .Fields("IdArticulo").Value
                mFechaVto1 = mFecha1
                mFechaVto2 = mFecha2
                mFechaVto3 = mFecha3

                Do While Not .EOF

                    If .Fields("IdArticulo").Value <> mIdArticulo Then
                        mFechaVto1 = mFecha1
                        mFechaVto2 = mFecha2
                        mFechaVto3 = mFecha3
                        mIdArticulo = .Fields("IdArticulo").Value
                    End If

                    Aplicacion.Tarea "VentasEnCuotas_ModificarVencimientos", Array(.Fields(0).Value, mFechaVto1, mFechaVto2, mFechaVto3)
                    mFechaVto1 = DateAdd("m", 1, mFechaVto1)
                    mFechaVto2 = DateAdd("m", 1, mFechaVto2)
                    mFechaVto3 = DateAdd("m", 1, mFechaVto3)
                    .MoveNext
                Loop

            End If

            .Close
        End With

        Set oRs = Nothing
        Lista.SelectedItem.ListSubItems(5) = "" & mFecha1
        Lista.SelectedItem.ListSubItems(6) = "" & mFecha2
        Lista.SelectedItem.ListSubItems(7) = "" & mFecha3
    End If
         
End Sub

Public Sub EliminarVentaEnCuotas()

    Dim oRs As ADOR.Recordset
    Dim mErrores As String
    Dim Filas, Columnas
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)
    Columnas = VBA.Split(Filas(1), vbTab)

    mErrores = ""
    Set oRs = Aplicacion.VentasEnCuotas.TraerFiltrado("_NotasDebitoGeneradasPorIdVentaEnCuotas", Columnas(2))

    With oRs

        If .RecordCount > 0 Then
            .MoveFirst

            Do While Not .EOF
                mErrores = mErrores & vbCrLf & Format(.Fields("NumeroNotaDebito").Value, "00000000") & " " & "del " & .Fields("FechaNotaDebito").Value
                .MoveNext
            Loop

        End If

        .Close
    End With

    Set oRs = Nothing
   
    If Len(mErrores) > 0 Then
        MsgBox "No se puede eliminar el registro hasta anular " & vbCrLf & "las siguientes notas de debito :" & mErrores
        Exit Sub
    End If
   
    Aplicacion.Tarea "VentasEnCuotas_Eliminar", Columnas(2)
   
    Set Lista.DataSource = Aplicacion.VentasEnCuotas.TraerTodos
   
    MsgBox "Venta en cuotas anulada"

End Sub

Public Sub EmitirFacturas(ByVal Destino As Integer)

    Dim mPlantilla As String, mCampo As String, mAgrupar As String
    Dim mvarConfirmarClausulaDolar As String, mArgL1 As String
    Dim oRs As ADOR.Recordset
   
    Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)

    If oRs.RecordCount > 0 Then
        mvarConfirmarClausulaDolar = IIf(IsNull(oRs.Fields("ConfirmarClausulaDolar").Value), "NO", oRs.Fields("ConfirmarClausulaDolar").Value)
    End If

    oRs.Close
   
    Dim mvarClausula As Boolean, mOk As Boolean
    mvarClausula = False
    mAgrupar = BuscarClaveINI("Agrupar items en factura")

    If mvarConfirmarClausulaDolar = "SI" Or Len(mAgrupar) <> 0 Then
        Dim of1 As frm_Aux
        Set of1 = New frm_Aux

        With of1
            .Caption = "Emision de factura"
            .Label1.Visible = False
            .text1.Visible = False

            With .Frame1
                .Caption = "Emite clausula dolar ? : "
                .top = of1.Label1.top
                .Visible = True
            End With

            .Option1.Caption = "SI"
            .Option1.Value = True
            .Option2.Caption = "NO"

            If Len(mAgrupar) <> 0 Then

                With .Check1
                    .top = of1.Frame1.top + of1.Frame1.Height + 100
                    .left = of1.Frame1.left
                    .Width = of1.Frame1.Width / 2
                    .Caption = "Agrupar items"

                    If mAgrupar = "SI" Then
                        .Value = 1
                    Else
                        .Value = 0
                    End If

                    .Visible = True
                End With

            End If

            .Show vbModal, Me
            mOk = .Ok
            mvarClausula = .Option1.Value

            If Len(mAgrupar) <> 0 Then
                If .Check1.Value = 1 Then
                    mAgrupar = "SI"
                Else
                    mAgrupar = "NO"
                End If
            End If

        End With

        Unload of1
        Set of1 = Nothing
        Me.Refresh
    End If

    If Not mOk Then Exit Sub
   
    Dim mCopias As Integer
    Dim mPrinter As String, mPrinterAnt As String
   
    mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
    If Destino = 0 Then
        Dim oF As frmImpresion
        Set oF = New frmImpresion

        With oF
            .txtCopias.Text = 1
            .Show vbModal, Me
        End With

        mOk = oF.Ok
        mCopias = Val(oF.txtCopias.Text)
        mPrinter = oF.Combo1.Text
        Unload oF
        Set oF = Nothing

        If Not mOk Then Exit Sub
        Me.Refresh
    Else
        mCopias = 1
    End If
   
    mArgL1 = BuscarClaveINI("Conceptos para detallar dominios en factura")
   
    Dim oW As Word.Application
    Dim iFilas As Integer, mIds As String
    Dim Filas
    Dim Columnas
   
    On Error GoTo Mal
   
    Me.MousePointer = vbHourglass

    DoEvents
   
    Set oW = CreateObject("Word.Application")
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
      
        mPlantilla = "N/A"
        Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)

        If oRs.RecordCount > 0 Then
            mCampo = "Plantilla_Factura_" & Columnas(1)

            If Not IsNull(oRs.Fields(mCampo).Value) And Len(oRs.Fields(mCampo).Value) > 0 Then
                mPlantilla = oRs.Fields(mCampo).Value
            End If
        End If

        oRs.Close

        If Not Len(Trim(Dir(glbPathPlantillas & "\" & mPlantilla))) <> 0 Then
            MsgBox "No existe la plantilla de impresion, definala en la tabla de parametros.", vbExclamation
            Exit Sub
        End If
   
        With oW
            .Visible = True
            .Documents.Add (glbPathPlantillas & "\" & mPlantilla)

            If Len(mAgrupar) <> 0 Then
                .Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=Columnas(2), varg3:=mvarClausula, varg4:=mPrinter, varg5:=mCopias, varg6:=mAgrupar & "|" & mArgL1
            Else
                .Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=Columnas(2), varg3:=mvarClausula, varg4:=mPrinter, varg5:=mCopias
            End If

            If Destino = 0 Then
                oW.Documents(1).Close False
                'oW.Quit
            End If

        End With

    Next
   
    If Destino = 0 Then
        oW.Quit
    End If
   
    GoTo Salida
   
Mal:
    Me.MousePointer = vbDefault
    MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical

Salida:
    Set oW = Nothing
    Set oRs = Nothing
    Me.MousePointer = vbDefault

End Sub

Public Sub EliminarFacturasAnuladas()

    Dim oL As ListItem
    Dim Filas, Columnas, mVector
    Dim iFilas As Integer
    Dim mCadena As String
    Dim mBorro As Boolean
   
    Me.MousePointer = vbHourglass

    DoEvents

    mBorro = False
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)
   
    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)

        If Columnas(5) = "SI" Then
            Aplicacion.Tarea "Facturas_EliminarFacturaAnulada", Columnas(2)
            mBorro = True
        End If

    Next
   
    If mBorro Then
        MsgBox "Proceso concluido, vuelva a seleccionar facturas para actualizar la lista"
    End If
   
    Me.MousePointer = vbDefault

End Sub

Public Sub EmitirNotasCredito(ByVal Destino As Integer)

    Dim mPlantilla As String, mCampo As String
    Dim mOk As Boolean
    Dim oRs As ADOR.Recordset
   
    Dim mCopias As Integer
    Dim mPrinter As String, mPrinterAnt As String
   
    mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
    If Destino = 0 Then
        Dim oF As frmImpresion
        Set oF = New frmImpresion

        With oF
            .txtCopias.Text = 1
            .Show vbModal, Me
        End With

        mOk = oF.Ok
        mCopias = Val(oF.txtCopias.Text)
        mPrinter = oF.Combo1.Text
        Unload oF
        Set oF = Nothing

        If Not mOk Then Exit Sub
        Me.Refresh
    Else
        mCopias = 1
    End If
   
    Dim oW As Word.Application
    Dim iFilas As Integer, mIds As String
    Dim Filas
    Dim Columnas
   
    On Error GoTo Mal
   
    Me.MousePointer = vbHourglass

    DoEvents
   
    Set oW = CreateObject("Word.Application")
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
      
        mPlantilla = "N/A"
        Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)

        If oRs.RecordCount > 0 Then
            mCampo = "Plantilla_NotasCredito_" & Columnas(3)

            If Not IsNull(oRs.Fields(mCampo).Value) And Len(oRs.Fields(mCampo).Value) > 0 Then
                mPlantilla = oRs.Fields(mCampo).Value
            End If
        End If

        oRs.Close

        If Not Len(Trim(Dir(glbPathPlantillas & "\" & mPlantilla))) <> 0 Then
            MsgBox "No existe la plantilla de impresion, definala en la tabla de parametros.", vbExclamation
            GoTo Salida
        End If
   
        With oW
            .Visible = True
            .Documents.Add (glbPathPlantillas & "\" & mPlantilla)
            .Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=Columnas(2), varg3:=False, varg4:=mPrinter, varg5:=mCopias

            If Destino = 0 Then
                oW.Documents(1).Close False
                'oW.Quit
            End If

        End With

    Next
   
    If Destino = 0 Then
        oW.Quit
    End If
   
    GoTo Salida
   
Mal:
    Me.MousePointer = vbDefault
    MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical

Salida:
    Set oW = Nothing
    Set oRs = Nothing
    Me.MousePointer = vbDefault

End Sub

Public Sub ImportacionCobranzasPagoFacil()

    Dim oAp As ComPronto.Aplicacion
    Dim oRec As ComPronto.Recibo
    Dim oPto As ComPronto.PuntoVenta
    Dim oRsAux1 As ADOR.Recordset
    Dim oF As Form
    Dim i As Integer, mIdMonedaPesos As Integer, mIdMonedaDolar As Integer
    Dim mIdPuntoVenta As Integer, mPuntoVenta As Integer, mIdMoneda As Integer
    Dim mCodigoDebeHaber As Integer, mIdTipoComprobante As Integer
    Dim mImporte As Double, mDebe As Double, mHaber As Double, mTotalValores As Double
    Dim mNumeroValor As Double, mCotizacionMoneda As Double, mCotizacion As Double
    Dim mNumeroRecibo As Long, mCodigo As Long, mCodigoCuenta As Long, mIdCuenta As Long
    Dim mIdCaja As Long, mNumeroInterno As Long, mCodigoBanco As Long, mIdBanco As Long
    Dim mIdCuentaBancaria As Long, mIdCuentaValores As Long, mLote As Long, mSublote As Long
    Dim mIdImputacion As Long, mIdCliente As Long, mIdComprobante As Long
    Dim mIdVendedor As Long, mIdCobrador As Long, mIdRubroContable As Long
    Dim mArchivo As String, mError As String, mCuentaBanco As String, mAuxStr1 As String
    Dim mFecha As Date, mFechaVencimiento As Date, mFechaLote As Date
    Dim mOk As Boolean, mConProblemas As Boolean
    Dim Filas, Columnas, mVector

    On Error GoTo Mal

    'Set oF = New frmPathPresto
    With oF
        .Id = 8
        .Show vbModal
        mOk = .Ok

        If mOk Then
            mArchivo = .FileBrowser1(0).Text
        End If

    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub

    If Len(mArchivo) = 0 Then
        MsgBox "No indico el archivo a procesar", vbExclamation
        Exit Sub
    End If
   
    Set oAp = Aplicacion

    Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
    mIdMonedaPesos = oRsAux1.Fields("IdMoneda").Value
    mIdMonedaDolar = oRsAux1.Fields("IdMonedaDolar").Value
    mIdCuentaValores = IIf(IsNull(oRsAux1.Fields("IdCuentaValores").Value), 0, oRsAux1.Fields("IdCuentaValores").Value)
    oRsAux1.Close
   
    mAuxStr1 = BuscarClaveINI("Punto de venta cobranza pago facil")
    mPuntoVenta = 0

    If IsNumeric(mAuxStr1) Then mPuntoVenta = CLng(mAuxStr1)
   
    mIdPuntoVenta = 0

    If mPuntoVenta = 0 Then
        Set oRsAux1 = oAp.PuntosVenta.TraerFiltrado("_PorIdTipoComprobante", 2)
    Else
        Set oRsAux1 = oAp.PuntosVenta.TraerFiltrado("_PorIdTipoComprobantePuntoVenta", Array(2, mPuntoVenta))
    End If

    If oRsAux1.RecordCount > 0 Then
        mIdPuntoVenta = oRsAux1.Fields(0).Value
        mPuntoVenta = oRsAux1.Fields("PuntoVenta").Value
    End If

    oRsAux1.Close

    If mIdPuntoVenta = 0 Then
        MsgBox "No tiene definido un punto de venta para los recibos", vbExclamation
        GoTo Salida
    End If
   
    mIdCaja = 0
    Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)

    If oRsAux1.RecordCount > 0 Then
        If Not IsNull(oRsAux1.Fields("IdCajaEnPesosDefault").Value) Then
            mIdCaja = oRsAux1.Fields("IdCajaEnPesosDefault").Value
        Else
            MsgBox "No tiene definido la caja default en los parametros", vbExclamation
            GoTo Salida
        End If
    End If

    oRsAux1.Close
   
    mAuxStr1 = BuscarClaveINI("IdRubroContable Importacion cobranzas")
    mIdRubroContable = 0

    If IsNumeric(mAuxStr1) Then mIdRubroContable = CLng(mAuxStr1)
   
    'Set oF = New frmAviso
    With oF
        .Label1 = "Iniciando importacion ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Procesando ingresos en efectivo ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    mConProblemas = False
    mError = ""
    mTotalValores = 0
   
    Filas = VBA.Split(LeerArchivoSecuencial(mArchivo), vbCrLf)

    If UBound(Filas) > 0 Then
      
        For i = 0 To UBound(Filas)
         
            If VBA.mId(Filas(i), 1, 1) = "5" Or VBA.mId(Filas(i), 1, 1) = "8" Or VBA.mId(Filas(i), 1, 1) = "9" Then

                If Not oRec Is Nothing Then
                    If Not mConProblemas Then
                        Set oPto = oAp.PuntosVenta.Item(mIdPuntoVenta)

                        With oPto
                            mNumeroRecibo = .Registro.Fields("ProximoNumero").Value
                            .Registro.Fields("ProximoNumero").Value = mNumeroRecibo + 1
                            .Guardar
                        End With

                        Set oPto = Nothing
                  
                        With oRec
                            With .Registro
                                .Fields("NumeroRecibo").Value = mNumeroRecibo
                                .Fields("Valores").Value = mTotalValores
                                .Fields("Deudores").Value = mTotalValores
                                .Fields("FechaIngreso").Value = Now
                            End With

                            With .DetRecibosRubrosContables.Item(-1)
                                With .Registro
                                    .Fields("IdRubroContable").Value = mIdRubroContable
                                    .Fields("Importe").Value = mTotalValores
                                End With

                                .Modificado = True
                            End With

                            .Guardar
                        End With

                    End If

                    Set oRec = Nothing
                End If
            End If
         
            Select Case VBA.mId(Filas(i), 1, 1)
            
                Case "3"
            
                    mFechaLote = CDate(mId(Filas(i), 8, 2) & "/" & mId(Filas(i), 6, 2) & "/" & mId(Filas(i), 2, 4))
                    mLote = CLng(mId(Filas(i), 10, 6))
            
                Case "5"
               
                    mConProblemas = False
                    mTotalValores = 0
               
                    mFecha = CDate(mId(Filas(i), 15, 2) & "/" & mId(Filas(i), 13, 2) & "/" & mId(Filas(i), 9, 4))
                    mSublote = CLng(mId(Filas(i), 2, 5))
                    mIdMoneda = mIdMonedaPesos
               
                    mIdComprobante = CLng(mId(Filas(i), 27, 12))
                    mIdTipoComprobante = CInt(mId(Filas(i), 25, 2))
                    mIdCliente = 0

                    Select Case mIdTipoComprobante

                        Case 1
                            Set oRsAux1 = oAp.Facturas.TraerFiltrado("_PorId", mIdComprobante)

                            If oRsAux1.RecordCount > 0 Then mIdCliente = oRsAux1.Fields("IdCliente").Value
                            oRsAux1.Close

                        Case 3, 4
                            Set oRsAux1 = oAp.NotasDebito.TraerFiltrado("_PorId", mIdComprobante)

                            If oRsAux1.RecordCount > 0 Then mIdCliente = oRsAux1.Fields("IdCliente").Value
                            oRsAux1.Close
                            '                  Case 4
                            '                     Set oRsAux1 = oAp.NotasCredito.TraerFiltrado("_PorId", mIdComprobante)
                            '                     If oRsAux1.RecordCount > 0 Then mIdCliente = oRsAux1.Fields("IdCliente").Value
                            '                     oRsAux1.Close
                    End Select

                    If mIdCliente = 0 Then
                        mError = mError & vbCrLf & "No se encontro el cliente/comprobante y no fue tomado"
                        mConProblemas = True
                    End If
               
                    mIdVendedor = 0
                    mIdCobrador = 0

                    If mIdCliente <> 0 Then
                        Set oRsAux1 = oAp.Clientes.TraerFiltrado("_PorId", mIdCliente)

                        If oRsAux1.RecordCount > 0 Then
                            mIdVendedor = IIf(IsNull(oRsAux1.Fields("Vendedor1").Value), 0, oRsAux1.Fields("Vendedor1").Value)
                            mIdCobrador = IIf(IsNull(oRsAux1.Fields("Cobrador").Value), 0, oRsAux1.Fields("Cobrador").Value)
                        End If

                        oRsAux1.Close
                    End If
               
                    Set oRsAux1 = oAp.Recibos.TraerFiltrado("_LoteSublote", Array(mLote, mSublote, mFechaLote))

                    If oRsAux1.RecordCount > 0 Then
                        mError = mError & vbCrLf & "Un recibo ya existe y no fue tomado"
                        mConProblemas = True
                    End If

                    oRsAux1.Close
               
                    mCotizacion = Cotizacion(mFecha, mIdMonedaDolar)

                    If mCotizacion = 0 Then
                        mError = mError & vbCrLf & "No hay cotizacion ingresada el " & mFecha & " y los recibos de esa fecha no fueron tomados"
                        mConProblemas = True
                    End If
               
                    If mIdMonedaPesos = mIdMoneda Then
                        mCotizacionMoneda = 1
                    Else
                        mCotizacionMoneda = Cotizacion(mFecha, mIdMoneda)

                        If mCotizacionMoneda = 0 Then
                            mError = mError & vbCrLf & "El recibo " & mNumeroRecibo & " no tiene cotizacion para la moneda y no fue tomado"
                            mConProblemas = True
                        End If
                    End If
               
                    Set oRec = oAp.Recibos.Item(-1)

                    With oRec
                        With .Registro
                            .Fields("FechaRecibo").Value = mFecha
                            .Fields("IdPuntoVenta").Value = mIdPuntoVenta
                            .Fields("PuntoVenta").Value = mPuntoVenta
                            .Fields("IdCliente").Value = mIdCliente
                            .Fields("Tipo").Value = "CC"
                            .Fields("Documentos").Value = 0
                            .Fields("Otros1").Value = 0
                            .Fields("Otros2").Value = 0
                            .Fields("Otros3").Value = 0
                            .Fields("Otros4").Value = 0
                            .Fields("Otros5").Value = 0
                            .Fields("RetencionIVA").Value = 0
                            .Fields("RetencionGanancias").Value = 0
                            .Fields("RetencionIBrutos").Value = 0
                            .Fields("GastosGenerales").Value = 0
                            .Fields("Cotizacion").Value = mCotizacion
                            .Fields("IdMoneda").Value = mIdMoneda
                            .Fields("Dolarizada").Value = "NO"
                            .Fields("AsientoManual").Value = "NO"
                            .Fields("CotizacionMoneda").Value = mCotizacionMoneda
                            .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                            .Fields("Lote").Value = mLote
                            .Fields("Sublote").Value = mSublote
                            .Fields("IdVendedor").Value = mIdVendedor
                            .Fields("IdCobrador").Value = mIdCobrador
                            .Fields("FechaLote").Value = mFechaLote
                        End With
                    End With
               
                Case "6"
               
                    If Not oRec Is Nothing Then
                        mIdTipoComprobante = CInt(mId(Filas(i), 19, 2))

                        If mIdTipoComprobante = 4 Then mIdTipoComprobante = 3
                        mIdComprobante = CLng(mId(Filas(i), 21, 12))
                        mIdImputacion = 0
                        Set oRsAux1 = oAp.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(mIdComprobante, mIdTipoComprobante))

                        If oRsAux1.RecordCount > 0 Then
                            mIdImputacion = oRsAux1.Fields(0).Value
                        End If

                        mImporte = CDbl(mId(Filas(i), 6, 8)) / 100

                        With oRec.DetRecibos.Item(-1)
                            With .Registro
                                .Fields("IdImputacion").Value = mIdImputacion
                                .Fields("Importe").Value = mImporte
                            End With

                            .Modificado = True
                        End With

                    End If
            
                Case "7"
               
                    If Not oRec Is Nothing Then
                        If mId(Filas(i), 5, 1) = "E" Then
                            mImporte = CDbl(mId(Filas(i), 86, 15)) / 100
                            oRec.Registro.Fields("Efectivo").Value = 0

                            With oRec.DetRecibosValores.Item(-1)
                                With .Registro
                                    .Fields("IdTipoValor").Value = 32
                                    .Fields("IdCaja").Value = mIdCaja
                                    .Fields("Importe").Value = mImporte
                                End With

                                .Modificado = True
                            End With

                            mTotalValores = mTotalValores + mImporte
                  
                        ElseIf mId(Filas(i), 5, 1) = "C" Then
                            mNumeroInterno = 0
                            mCodigoBanco = CLng(mId(Filas(i), 6, 3))
                            mNumeroValor = CDbl(mId(Filas(i), 16, 8))
                            mFechaVencimiento = mFecha
                            mImporte = CDbl(mId(Filas(i), 86, 15)) / 100
                     
                            mIdBanco = 0
                            Set oRsAux1 = oAp.Bancos.TraerFiltrado("_PorCodigoUnico", mCodigoBanco)

                            If oRsAux1.RecordCount > 0 Then
                                mIdBanco = oRsAux1.Fields(0).Value
                            Else
                                mError = mError & vbCrLf & "El recibo " & mNumeroRecibo & " tiene un valor de terceros de un banco invalido y no fue tomado (CH)"
                                mConProblemas = True
                            End If

                            oRsAux1.Close
                     
                            With oRec.DetRecibosValores.Item(-1)
                                With .Registro
                                    .Fields("IdTipoValor").Value = 6
                                    .Fields("NumeroValor").Value = mNumeroValor
                                    .Fields("NumeroInterno").Value = mNumeroInterno
                                    .Fields("FechaVencimiento").Value = mFechaVencimiento
                                    .Fields("IdBanco").Value = mIdBanco
                                    .Fields("Importe").Value = mImporte
                                End With

                                .Modificado = True
                            End With

                            mTotalValores = mTotalValores + mImporte
                        End If
                    End If
                     
            End Select
            
        Next
      
    End If
            
    If Len(mError) > 0 Then
        MsgBox "El proceso reporta los siguientes problemas :" & mError
    End If

Salida:

    On Error Resume Next
    Unload oF
    Set oF = Nothing

    Set oRsAux1 = Nothing
    Set oRec = Nothing
    Set oPto = Nothing
    Set oAp = Nothing

    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub ImportacionArticulos()

    Dim oAp As ComPronto.Aplicacion
    Dim oEx As Excel.Application
    Dim oArt As ComPronto.Articulo
    Dim oRs As ADOR.Recordset
    Dim oRsErrores As ADOR.Recordset
    Dim oRsAux As ADOR.Recordset
    Dim oF As Form
    Dim mArchivo As String, mAuxStr1 As String, mCodigo As String, mComentario As String
    Dim mDescripcion As String, mNumeroInventario As String, mUbicacion As String
    Dim mObservaciones As String
    Dim fl As Integer, mContador As Integer
    Dim mIdGrado As Long, mIdRubro As Long, mIdSubrubro As Long, mIdTipo As Long
    Dim mIdEstado As Long
    Dim mOk As Boolean, mConProblemas As Boolean
    Dim mLinea As Double
   
    On Error GoTo Mal

    'Set oF = New frmPathPresto
    With oF
        .Id = 9
        .Show vbModal
        mOk = .Ok

        If mOk Then
            mArchivo = .FileBrowser1(0).Text
        End If

    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub

    Set oAp = Aplicacion

    Set oRsErrores = CreateObject("ADOR.Recordset")

    With oRsErrores
        .Fields.Append "Id", adInteger
        .Fields.Append "Detalle", adVarChar, 200
    End With

    oRsErrores.Open
   
    'Set oF = New frmAviso
    With oF
        .Label1 = "Abriendo planilla Excel ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Procesando articulos ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    mAuxStr1 = BuscarClaveINI("IdRubro de equipos")
    mIdRubro = 0

    If IsNumeric(mAuxStr1) Then mIdRubro = CLng(mAuxStr1)
   
    mAuxStr1 = BuscarClaveINI("IdSubrubro de equipos")
    mIdSubrubro = 0

    If IsNumeric(mAuxStr1) Then mIdSubrubro = CLng(mAuxStr1)
   
    mAuxStr1 = BuscarClaveINI("IdTipo para filtrar equipos instalados")
    mIdTipo = 0

    If IsNumeric(mAuxStr1) Then mIdTipo = CLng(mAuxStr1)
   
    fl = 2
   
    Set oEx = CreateObject("Excel.Application")

    With oEx
      
        .Visible = True
        .WindowState = xlMinimized
        Me.Refresh
      
        With .Workbooks.Open(mArchivo)
            .Sheets("Hoja1").Select

            With .ActiveSheet

                Do While True
               
                    If Len(Trim(.Cells(fl, 2))) = 0 Then
                        Exit Do
                    End If
               
                    mConProblemas = False
               
                    mContador = mContador + 1
                    oF.Label2 = "Articulo : " & .Cells(fl, 2)
                    oF.Label3 = "" & mContador

                    DoEvents
               
                    mCodigo = .Cells(fl, 2)
                    mDescripcion = .Cells(fl, 3)
                    mNumeroInventario = .Cells(fl, 4)
                    mLinea = 0

                    If IsNumeric(.Cells(fl, 5)) Then mLinea = CDbl(.Cells(fl, 5))
                    mIdEstado = 0

                    If IsNumeric(.Cells(fl, 7)) Then mIdEstado = .Cells(fl, 7)
                    mUbicacion = .Cells(fl, 8)
                    mComentario = .Cells(fl, 9)
                    mObservaciones = .Cells(fl, 10)
               
                    Set oRsAux = oAp.Articulos.TraerFiltrado("_PorCodigo", mCodigo)

                    If oRsAux.RecordCount > 0 Then
                        'AgregarMensajeProcesoPresto oRsErrores, "El articulo " & mCodigo & _
                         " ya existe."
                        mConProblemas = True
                    End If

                    oRsAux.Close
   
                    If Not mConProblemas Then
                  
                        mIdGrado = 0
                        Set oRsAux = oAp.Grados.TraerFiltrado("_PorDescripcion", .Cells(fl, 6))

                        If oRsAux.RecordCount > 0 Then
                            mIdGrado = oRsAux.Fields(0).Value
                        End If

                        oRsAux.Close
                  
                        Set oArt = oAp.Articulos.Item(-1)

                        With oArt
                            With .Registro
                                .Fields("Codigo").Value = mCodigo
                                .Fields("Descripcion").Value = mDescripcion
                                .Fields("NumeroInventario").Value = mNumeroInventario
                                .Fields("Datos1").Value = mLinea
                                .Fields("IdGrado").Value = mIdGrado
                                .Fields("IdRubro").Value = mIdRubro
                                .Fields("IdSubrubro").Value = mIdSubrubro
                                .Fields("IdTipo").Value = mIdTipo
                                .Fields("IdCuantificacion").Value = 1
                                .Fields("Autorizacion").Value = "C"
                                .Fields("ModeloEspecifico").Value = "HAWK"
                                .Fields("FechaAlta").Value = Now
                                .Fields("IdAcabado").Value = mIdEstado
                                .Fields("TipoCoberturaSeguro").Value = mUbicacion
                                .Fields("Caracteristicas").Value = mComentario
                                .Fields("Observaciones").Value = mObservaciones
                            End With
                        End With

                        oArt.Guardar
                        Set oArt = Nothing
               
                    Else
               
                        fl = fl + 1
                  
                    End If
   
                Loop

            End With

            .Close False
        End With

        .Quit
   
    End With
   
    Unload oF
    Set oF = Nothing

    If Not oRsErrores Is Nothing Then
        If oRsErrores.RecordCount > 0 Then
            Set oF = New frmConsulta1

            With oF
                Set .RecordsetFuente = oRsErrores
                .Id = 13
                .Show vbModal, Me
            End With

        Else
            MsgBox "Proceso completo", vbInformation
        End If

        Set oRsErrores = Nothing
    End If

Salida:

    On Error Resume Next
   
    Unload oF
    Set oF = Nothing

    Set oRs = Nothing
    Set oRsErrores = Nothing
    Set oRsAux = Nothing
    Set oArt = Nothing
    Set oEx = Nothing
    Set oAp = Nothing

    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida
   
End Sub

Public Sub QuitarMarcaAprobacionConciliacion()

    Dim oL As ListItem
    Dim Filas, Columnas, mVector
    Dim iFilas As Integer, mAcceder As Integer
    Dim mCadena As String
   
    If Not glbAdministrador Then
        mAcceder = MsgBox("Para ingresar a este modulo debe tener permiso de ADMINISTRADOR" & vbCrLf & "Desea login de supervisores ?", vbYesNo, "Acceso a supervisores")

        If mAcceder = vbNo Then
            Exit Sub
        End If

        If Not DefinirAdministrador Then
            MsgBox "Para ingresar a este modulo debe tener permiso de ADMINISTRADOR", vbCritical
            Exit Sub
        End If
    End If
   
    Me.MousePointer = vbHourglass

    DoEvents

    Filas = VBA.Split(Lista.GetString, vbCrLf)
   
    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
        Aplicacion.Tarea "Conciliaciones_QuitarMarcaAprobacion", Columnas(2)
    Next

    Set Lista.DataSource = Aplicacion.Conciliaciones.TraerTodos

    Me.MousePointer = vbDefault

End Sub

Public Sub ActivarPopupMateriales()

    On Error Resume Next
   
    '   Me.MousePointer = vbHourglass
    '   DoEvents

    Dim oRs As ADOR.Recordset
    Dim mIdRubro As Long, mIdSubrubro As Long
    Dim mCantidadRubros As Integer, mCantidadSubrubros As Integer
    Dim mCantidadArticulos As Integer
    Dim Key1 As Long, Key2 As Long, Key3 As Long
    Dim mRubro As String, mSubrubro As String, mArticulo As String

    Set cPMenu = New cPopupMenu

    With cPMenu
        .ImageList = img16
        .hWndOwner = Me.hwnd
        .HeaderStyle = ecnmHeaderSeparator
        .MenuBackgroundColor = &HC0C0FF
        .InActiveMenuForeColor = &H333333
        .ActiveMenuBackgroundColor = &H336666
        .ActiveMenuForeColor = &HFFFFFF
        .ImageProcessHighlights = True
        .BackgroundPicture = picBackground.Picture
        .Clear
    End With
   
    POP_menuheight = GetSystemMetrics(SM_CYMENU)
    POP_breakpoint = ((GetSystemMetrics(SM_CYFULLSCREEN) - POP_menuheight) \ POP_menuheight) - 3
   
    Key1 = cPMenu.AddItem("Materiales", , 0, , , , , "Root")

    Set oRs = Aplicacion.Articulos.TraerFiltrado("_ParaMenu1")

    If oRs Is Nothing Then
        Set cPMenu = Nothing
        glbMenuPopUpCargado1 = False
        Exit Sub
    End If

    With oRs

        If .RecordCount > 0 Then
            .MoveFirst
            mIdRubro = -1
            mIdSubrubro = -1
            mCantidadRubros = 0
            mCantidadSubrubros = 0
            mCantidadArticulos = 0

            Do While Not .EOF

                If Len(Trim(.Fields("Rubro").Value)) <> 0 Then
                    mRubro = .Fields("Rubro").Value
                Else
                    mRubro = "S/D"
                End If

                If Len(Trim(.Fields("Subrubro").Value)) <> 0 Then
                    mSubrubro = .Fields("Subrubro").Value
                Else
                    mSubrubro = "S/D"
                End If

                If Len(Trim(.Fields("Descripcion").Value)) <> 0 Then
                    mArticulo = .Fields("Descripcion").Value
                Else
                    mArticulo = "S/D"
                End If
            
                If mIdRubro <> .Fields("IdRubro").Value Then
                    If mIdRubro = -1 Then cPMenu.AddItem "-Rubros", , , Key1
                    mCantidadRubros = mCantidadRubros + 1

                    If mCantidadRubros Mod POP_breakpoint = 0 Then
                        Key1 = cPMenu.AddItem("Mas rubros", , , Key1, , , , "R0")
                    End If

                    Key2 = cPMenu.AddItem(mRubro, , , Key1, img16.ListImages("Rubros").Index - 1, , , "R" & .Fields("IdRubro").Value)
                End If

                If mIdRubro <> .Fields("IdRubro").Value Or mIdSubrubro <> .Fields("IdSubrubro").Value Then

                    If mIdRubro <> .Fields("IdRubro").Value Then
                        cPMenu.AddItem "-Subrubros", , , Key2
                    End If

                    mCantidadSubrubros = mCantidadSubrubros + 1

                    If mCantidadSubrubros Mod POP_breakpoint = 0 Then
                        Key2 = cPMenu.AddItem("Mas subrubros", , , Key2, , , , "R0")
                        mCantidadSubrubros = 0
                    End If

                    Key3 = cPMenu.AddItem(mSubrubro, , , Key2, img16.ListImages("Subrubros").Index - 1, , , "S" & .Fields("IdSubrubro").Value)
                    mIdRubro = .Fields("IdRubro").Value
                    mIdSubrubro = .Fields("IdSubrubro").Value
                    mCantidadArticulos = 0
                End If
            
                mCantidadArticulos = mCantidadArticulos + 1

                If mCantidadArticulos Mod POP_breakpoint = 0 Then
                    Key3 = cPMenu.AddItem("Mas materiales", , , Key3, , , , "R0")
                End If

                cPMenu.AddItem mArticulo, , , Key3, img16.ListImages("Articulos").Index - 1, , , .Fields("IdArticulo").Value
            
                .MoveNext
            Loop

        End If

        .Close
    End With

    cPMenu.Store "Materiales"
    'cPMenu.StoreToFile , App.Path & "\PopUp.Dat"
   
    Set oRs = Nothing

    '   Me.MousePointer = vbDefault
    '   DoEvents

End Sub

Public Sub ExportarComprobantesXML()

    Dim oF As frm_Aux
   
    Set oF = New frm_Aux

    With oF
        .Caption = "Exportar comprobantes (XML)"

        With .Label1
            .top = 100
            .Caption = "Comprobante :"
        End With

        With .Combo1(0)
            .top = 100
            .left = oF.Label1.left + oF.Label1.Width + 100
            .Width = .Width * 1.5
            .AddItem "Pedidos", 0
            .AddItem "Ordenes de compra", 1
            .Visible = True
        End With

        .text1.Visible = False
        .Width = .Width * 3.5
        .Height = .Height * 3.1

        With .Lista
            .left = oF.Label1.left
            .top = 500
            .Width = 12000
            .Height = 5400
            .Checkboxes = True
            .Visible = True
        End With

        With .cmd(0)
            .top = 6000
            .left = oF.Lista.left
            .Caption = "Generar"
            .Enabled = False
        End With

        .cmd(1).top = .cmd(0).top
        .Id = 2
        .Show vbModal, Me
    End With

    Unload oF
    Set oF = Nothing

End Sub

Public Sub DefinirAccesosItemUsuarios()

    Dim oF As frm_Aux
    Dim mOk As Boolean
   
    Set oF = New frm_Aux

    With oF
        .Id = 3
        .ArbolItem = Arbol.SelectedItem.Key
        .MnuDet.Visible = True
        .Caption = "Definir accesos por item - usuario"
        .Label1.Visible = False
        .text1.Visible = False
        .Width = .Width * 2
        .Height = .Height * 3.2

        With .Lista
            .left = oF.Label1.left
            .top = 500
            .Width = 6500
            .Height = 5400
            .Checkboxes = True
            .MultiSelect = True
            .Visible = True
            Set .SmallIcons = oF.img16
            Set .DataSource = Aplicacion.Empleados.TraerFiltrado("_AccesosPorItemArbol", Arbol.SelectedItem.Key)
        End With

        With .cmd(0)
            .top = 6000
            .left = oF.Lista.left
            .Caption = "Guardar"
        End With

        With .cmd(1)
            .left = oF.cmd(0).left + oF.cmd(0).Width + 50
            .top = oF.cmd(0).top
        End With

        .Show vbModal, Me
        mOk = .Ok
    End With

    Unload oF
    Set oF = Nothing

    If mOk Then
        CargarPermisos
        CargarArbol
        CargarPopUpMenu
    End If

End Sub

Public Sub DistribuirTeoricosPorMatrices()

    On Error GoTo Mal
   
    Dim oF As frm_Aux
    Dim mIdDistribucionObra As Long
    Dim mOk As Boolean
   
    Set oF = New frm_Aux
    mIdDistribucionObra = 0

    With oF
        .Caption = "Matriz"
        .text1.Visible = False
        .Label1.Caption = "Elegir matriz:"

        With .dcfields(0)
            .top = oF.text1.top
            .left = oF.text1.left
            .Width = .Width * 2
            .BoundColumn = "IdDistribucionObra"
            Set .RowSource = Aplicacion.DistribucionesObras.TraerLista
            .Visible = True
        End With

        .Width = .Width * 1.3
        .Show vbModal, Me
        mOk = .Ok

        If IsNumeric(.dcfields(0).BoundText) Then
            mIdDistribucionObra = .dcfields(0).BoundText
        End If

    End With

    Unload oF
    Set oF = Nothing
   
    If Not mOk Then Exit Sub
    If mIdDistribucionObra = 0 Then
        MsgBox "No eligio una matriz para aplicar la distribucion", vbExclamation
        Exit Sub
    End If
   
    Dim Filas, Columnas, mVector
    Dim s As String
    Dim i As Integer
   
    mVector = VBA.Split(Arbol.SelectedItem.Key, " ")
   
    s = Lista.GetString
   
    Filas = VBA.Split(s, vbCrLf)

    For i = 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(i), vbTab)
        Aplicacion.Tarea "Cuentas_DistribuirPresupuestoEconomicoPorMatriz", Array(Columnas(2), mIdDistribucionObra, mVector(2))
    Next
   
    Arbol_NodeClick Arbol.SelectedItem
   
Salida:

    Exit Sub

Mal:
   
    Dim mvarResp As Integer

    Select Case Err.Number

        Case Else
            MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    End Select

    Resume Salida

End Sub

Public Sub RegrabarComprobantesProveedores()

    Dim iFilas As Integer, mAcceder As Integer
   
    If Not glbAdministrador Then
        mAcceder = MsgBox("Para ingresar a este modulo debe tener permiso de ADMINISTRADOR" & vbCrLf & "Desea login de supervisores ?", vbYesNo, "Acceso a supervisores")

        If mAcceder = vbNo Then
            Exit Sub
        End If

        If Not DefinirAdministrador Then
            MsgBox "Para ingresar a este modulo debe tener permiso de ADMINISTRADOR", vbCritical
            Exit Sub
        End If
    End If
   
    Me.MousePointer = vbHourglass

    DoEvents

    On Error GoTo Mal
   
    Dim oF As Form
    Dim oAp As ComPronto.Aplicacion
    Dim oCP As ComPronto.ComprobanteProveedor
    Dim oDet As ComPronto.DetComprobanteProveedor
    Dim oRs As ADOR.Recordset
    Dim Filas, Columnas
   
    Set oAp = Aplicacion
   
    'Set oF = New frmAviso
    With oF
        .Label1 = "Cargando comprobantes de proveedores ..." & vbCrLf & "Procesando comprobante :"
        .Show
        .Refresh

        DoEvents
    End With

    Filas = VBA.Split(Lista.GetString, vbCrLf)
   
    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
        Set oCP = oAp.ComprobantesProveedores.Item(Columnas(2))
        oF.Label1 = "Cargando comprobantes de proveedores ..." & vbCrLf & "Procesando comprobante :" & vbCrLf & "" & oCP.Registro.Fields("Letra").Value & "-" & Format(oCP.Registro.Fields("NumeroComprobante1").Value, "0000") & "-" & Format(oCP.Registro.Fields("NumeroComprobante2").Value, "0000000000") & vbCrLf & iFilas & " de " & UBound(Filas)

        DoEvents
        Set oRs = oCP.DetComprobantesProveedores.TraerTodos

        If oRs.RecordCount <> 0 Then
            While Not oRs.EOF
                Set oDet = oCP.DetComprobantesProveedores.Item(oRs.Fields(0).Value)
                oDet.Modificado = True
                Set oDet = Nothing
                oRs.MoveNext
            Wend
        End If

        oCP.Guardar
        Set oRs = Nothing
        Set oCP = Nothing
    Next

    Unload oF

Salida:

    Set oF = Nothing
    Set oRs = Nothing
    Set oDet = Nothing
    Set oCP = Nothing
    Set oAp = Nothing
   
    Me.MousePointer = vbDefault
    Exit Sub

Mal:
   
    Me.MousePointer = vbDefault
    Dim mvarResp As Integer

    Select Case Err.Number

        Case Else
            MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    End Select

    Resume Salida

End Sub

Public Sub RecalcularGrabarComprobantesProveedores()

    Dim iFilas As Integer, mAcceder As Integer
   
    If Not glbAdministrador Then
        mAcceder = MsgBox("Para ingresar a este modulo debe tener permiso de ADMINISTRADOR" & vbCrLf & "Desea login de supervisores ?", vbYesNo, "Acceso a supervisores")

        If mAcceder = vbNo Then
            Exit Sub
        End If

        If Not DefinirAdministrador Then
            MsgBox "Para ingresar a este modulo debe tener permiso de ADMINISTRADOR", vbCritical
            Exit Sub
        End If
    End If
   
    On Error GoTo Mal
   
    Dim oF 'As frmComprobantesPrv
    Dim Filas, Columnas
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)

        'Set oF = New frmComprobantesPrv
        With oF
            .NivelAcceso = ControlAccesoNivel("ComprobantesPrvTodos")
            .OpcionesAcceso = ControlAccesoOpciones("ComprobantesPrvTodos")
            .GrabacionAutomatica = True
            .Id = Columnas(2)
            .Show vbModal, Me
        End With

        Unload oF
        Me.Refresh

        DoEvents
    Next
   
Salida:

    Set oF = Nothing
    Exit Sub

Mal:
   
    Me.MousePointer = vbDefault
    Dim mvarResp As Integer

    Select Case Err.Number

        Case Else
            MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    End Select

    Resume Salida

End Sub

Public Sub DefinirDestinoPagoComprobantesProveedores()

    Dim iFilas As Integer, mAcceder As Integer
   
    If Not glbAdministrador Then
        mAcceder = MsgBox("Para ingresar a este modulo debe tener permiso de ADMINISTRADOR" & vbCrLf & "Desea login de supervisores ?", vbYesNo, "Acceso a supervisores")

        If mAcceder = vbNo Then
            Exit Sub
        End If

        If Not DefinirAdministrador Then
            MsgBox "Para ingresar a este modulo debe tener permiso de ADMINISTRADOR", vbCritical
            Exit Sub
        End If
    End If
   
    On Error GoTo Mal
   
    Dim oF As Form
    Dim mDestinoPago As String
    Dim mOk As Boolean
    Dim Filas, Columnas
   
    Set oF = New frm_Aux

    With oF
        .Caption = "Destino de pago"
        .text1.Visible = False
        .Label1.Caption = "Destino de pago :"
        .Frame1.Visible = True
        .Frame1.top = .Label1.top + .Label1.Height + 100
        .Option1.Value = True
        .Option1.Caption = "Administracion"
        .Option2.Caption = "Obra"
        .Show vbModal, Me
        mOk = .Ok

        If .Option1.Value Then
            mDestinoPago = "A"
        Else
            mDestinoPago = "O"
        End If

    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub
   
    'Set oF = New frmAviso
    With oF
        .Label1 = "Cargando comprobantes de proveedores ..." & vbCrLf & "Procesando comprobante :"
        .Show
        .Refresh

        DoEvents
    End With

    Filas = VBA.Split(Lista.GetString, vbCrLf)
   
    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
        Aplicacion.Tarea "ComprobantesProveedores_GrabarDestinoPago", Array(Columnas(2), mDestinoPago)
        oF.Label1 = "Cargando comprobantes de proveedores ..." & vbCrLf & "Procesando comprobante :" & vbCrLf & "" & Columnas(5) & vbCrLf & Columnas(4) & vbCrLf & iFilas & " de " & UBound(Filas)

        DoEvents
    Next

    Arbol_NodeClick Arbol.SelectedItem
    Unload oF

Salida:
    Set oF = Nothing
    Exit Sub

Mal:
    Dim mvarResp As Integer

    Select Case Err.Number

        Case Else
            MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    End Select

    Resume Salida

End Sub

Public Sub DefinirOPFondoReparoComprobantesProveedores()

    Dim iFilas As Integer, mAcceder As Integer
   
    If Not glbAdministrador Then
        mAcceder = MsgBox("Para ingresar a este modulo debe tener permiso de ADMINISTRADOR" & vbCrLf & "Desea login de supervisores ?", vbYesNo, "Acceso a supervisores")

        If mAcceder = vbNo Then
            Exit Sub
        End If

        If Not DefinirAdministrador Then
            MsgBox "Para ingresar a este modulo debe tener permiso de ADMINISTRADOR", vbCritical
            Exit Sub
        End If
    End If
   
    On Error GoTo Mal
   
    Dim oF As Form
    Dim mNumeroOP As Long
    Dim mOk As Boolean
    Dim Filas, Columnas
   
    Set oF = New frm_Aux

    With oF
        .Caption = "OP Fondo Reparo"
        .Label1.Caption = "Numero de OP :"
        .Show vbModal, Me
        mOk = .Ok
        mNumeroOP = Val(.text1.Text)
    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub
   
    'Set oF = New frmAviso
    With oF
        .Label1 = "Cargando comprobantes de proveedores ..." & vbCrLf & "Procesando comprobante :"
        .Show
        .Refresh

        DoEvents
    End With

    Filas = VBA.Split(Lista.GetString, vbCrLf)
   
    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
        Aplicacion.Tarea "ComprobantesProveedores_GrabarDestinoPago", Array(Columnas(2), "", mNumeroOP)
        oF.Label1 = "Cargando comprobantes de proveedores ..." & vbCrLf & "Procesando comprobante :" & vbCrLf & "" & Columnas(5) & vbCrLf & Columnas(4) & vbCrLf & iFilas & " de " & UBound(Filas)

        DoEvents
    Next

    Arbol_NodeClick Arbol.SelectedItem
    Unload oF

Salida:
    Set oF = Nothing
    Exit Sub

Mal:
    Dim mvarResp As Integer

    Select Case Err.Number

        Case Else
            MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    End Select

    Resume Salida

End Sub

Public Sub ImportacionInformacionImpositiva()

    Dim oAp As ComPronto.Aplicacion
    Dim oProv As ComPronto.Proveedor
    Dim oCli As ComPronto.Cliente
    Dim oRs As ADOR.Recordset
    Dim oRsAux1 As ADOR.Recordset
    Dim oRsAux2 As ADOR.Recordset
    Dim oF As frm_Aux
    Dim of1 'As frmAviso
    Dim mArchivo As String, s As String, mCuit As String, mArchivoSalida As String
    Dim mvarPathArchivosExportados As String, mAux1 As String, mAuxS1 As String, mAuxS2 As String
    Dim mAuxS3 As String, mAuxS4 As String
    Dim mCodigo As Integer, mvarSeguro As Integer
    Dim i As Long, j As Long, X As Long, mAuxL1 As Long, mAuxL2 As Long, mAuxL3 As Long
    Dim mFechaLog As Date, mAuxD1 As Date
    Dim mOk As Boolean, mConProblemas As Boolean, mPrimero As Boolean
    Dim mAux2 As Double
    Dim Filas, Columnas
   
    '   On Error GoTo Mal

    mPrimero = True
   
    Set oF = New frm_Aux

    With oF
        .Caption = "Importacion de informacion impositiva"
        .Id = 10
        .text1.Visible = False

        With .Label1
            .Caption = "Archivo a procesar:"
            .Width = .Width * 1.3
            .top = oF.Label2(0).top
        End With

        With .FileBrowser1(0)
            .left = oF.Label2(1).left
            .top = oF.Label1.top + oF.Label1.Height + 100
            .Visible = True
        End With

        .Frame1.top = .FileBrowser1(0).top + .FileBrowser1(0).Height + 100

        With .cmd(1)
            .top = oF.cmd(0).top + oF.cmd(0).Height + 100
            .left = oF.cmd(0).left
        End With

        With .Frame2
            .top = oF.cmd(0).top
            .left = oF.cmd(0).left + oF.cmd(0).Width + 400
            .Visible = True
        End With

        .Option3.Value = True
        .Width = .Width * 1.2
        .Height = .Height * 1.4
        .Show vbModal
        mOk = .Ok

        If .Option3.Value Then mCodigo = 1
        If .Option4.Value Then mCodigo = 2
        If .Option5.Value Then
            If .Option1.Value Then
                mCodigo = 3
            Else
                mCodigo = 4
            End If
        End If

        If .Option6.Value Then mCodigo = 5
        If .Option7.Value Then mCodigo = 6
        If .Option8.Value Then mCodigo = 7
        If .Option9.Value Then mCodigo = 8
        mArchivo = .FileBrowser1(0).Text
    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Or Len(mArchivo) = 0 And mCodigo <> 3 Then Exit Sub

    If mCodigo <> 6 Then
        mvarSeguro = MsgBox("Este proceso genera un archivo de log que registra el estado" & vbCrLf & "inicial y final de los datos a modificar del proveedor, estos" & vbCrLf & "cambios pueden consultarse en la opcion Seguridad-Log importacion" & vbCrLf & "archivos de retencion. Esta de acuerdo en continuar ?", vbYesNo, "Procesar informacion impositiva")

        If mvarSeguro = vbNo Then Exit Sub
    End If
   
    'Set of1 = New frmAviso
    With of1
        .Caption = "Importacion de informacion impositiva"
        .Label1 = "Abriendo archivo ..."
        .Show
        .Refresh

        DoEvents
    End With

    Set oAp = Aplicacion

    If mCodigo = 3 Then
        Set oRs = oAp.Parametros.TraerTodos
        mvarPathArchivosExportados = IIf(IsNull(oRs.Fields("PathArchivosExportados").Value), "C:\", oRs.Fields("PathArchivosExportados").Value)
        oRs.Close
        Set oRs = oAp.Proveedores.TraerFiltrado("_ParaTransmitir_Todos")

        If oRs.RecordCount > 0 Then
            s = "" & mId(glbCuit, 1, 2) & mId(glbCuit, 4, 8) & mId(glbCuit, 13, 1) & vbCrLf
            oRs.MoveFirst

            Do While Not oRs.EOF

                If Not IsNull(oRs.Fields("IdCodigoIva").Value) And oRs.Fields("IdCodigoIva").Value = 1 And Len(oRs.Fields("Cuit").Value) > 0 Then
                    s = s & "" & mId(oRs.Fields("Cuit").Value, 1, 2) & mId(oRs.Fields("Cuit").Value, 4, 8) & mId(oRs.Fields("Cuit").Value, 13, 1) & " " & mId(CStr(Date), 4, 7) & vbCrLf
                End If

                oRs.MoveNext
            Loop

        End If

        oRs.Close

        If Len(s) > 0 Then
            s = mId(s, 1, Len(s) - 2)
            mArchivoSalida = mvarPathArchivosExportados & "ReproWeb.txt"
            GuardarArchivoSecuencial mArchivoSalida, s
        End If

        MsgBox "Se ha generado el archivo : " & mArchivoSalida
        GoTo Salida
    End If
   
    If mCodigo = 6 Then
        oAp.Tarea "Proveedores_BorrarEmbargos"
    End If
   
    If mCodigo = 7 Then
        Set oRsAux1 = oAp.Proveedores.TraerFiltrado("_SoloCuit")
        Set oRsAux2 = oAp.Clientes.TraerFiltrado("_SoloCuit")
    End If
   
    s = LeerArchivoSecuencial1(mArchivo)

    If Len(s) = 0 Then GoTo Salida
    of1.Label1 = ""
   
    Filas = VBA.Split(s, Chr(10))

    For i = 0 To UBound(Filas) - 1
        of1.Label1 = vbCrLf & vbCrLf & vbCrLf & vbCrLf & "Procesando registros ..."
        of1.Label2 = "Registro : " & i & " de " & UBound(Filas)

        DoEvents
      
        If mCodigo = 1 Then
            Columnas = VBA.Split(Filas(i), vbTab)

            If UBound(Columnas) < 9 Then
                If mPrimero Then
                    MsgBox "Archivo invalido", vbExclamation
                    GoTo Salida
                End If
            End If

            If mPrimero Then
                mPrimero = False
                mFechaLog = Now
                oAp.Tarea "Proveedores_EstadoInicialImpositivo", Array(mFechaLog, "RG830")
            End If

            If i >= 1 And UBound(Columnas) >= 9 Then
                mCuit = mId(Columnas(1), 1, 2) & "-" & mId(Columnas(1), 3, 8) & "-" & mId(Columnas(1), 11, 1)
                Set oRs = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)

                If oRs.RecordCount > 0 Then
                    If IsNull(oRs.Fields("Eventual").Value) Or oRs.Fields("Eventual").Value <> "SI" Then
                        Set oProv = oAp.Proveedores.Item(oRs.Fields(0).Value)

                        If CInt(Columnas(3)) = 100 Then
                            oProv.Registro.Fields("IGCondicion").Value = 1
                            oProv.Registro.Fields("FechaLimiteExentoGanancias").Value = CDate(Columnas(9))
                        Else
                            oProv.Registro.Fields("IGCondicion").Value = 2
                            oProv.Registro.Fields("FechaLimiteExentoGanancias").Value = Null
                        End If

                        oAp.Tarea "LogImpuestos_A", Array(mFechaLog, "RG830", oRs.Fields(0).Value, oProv.Registro.Fields("IGCondicion").Value, oProv.Registro.Fields("FechaLimiteExentoGanancias").Value)
                        oProv.Guardar
                    End If
                End If

                oRs.Close
            End If
      
        ElseIf mCodigo = 2 Then

            If Len(Filas(i)) >= 200 Then
                If mId(Filas(i), 110, 4) = "RG17" Or mId(Filas(i), 110, 6) = "RG2226" Then
                    If mPrimero Then
                        mPrimero = False
                        mFechaLog = Now
                        oAp.Tarea "Proveedores_EstadoInicialImpositivo", Array(mFechaLog, mId(Filas(i), 110, 6))
                    End If

                    Columnas = VBA.Split(Filas(i), vbTab)
                    mCuit = mId(Filas(i), 2, 2) & "-" & mId(Filas(i), 4, 8) & "-" & mId(Filas(i), 12, 1)
                    Set oRs = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)

                    If oRs.RecordCount > 0 Then
                        If IsNull(oRs.Fields("Eventual").Value) Or oRs.Fields("Eventual").Value <> "SI" Then
                            Set oProv = oAp.Proveedores.Item(oRs.Fields(0).Value)
                            '                     If CSng(mId(Filas(i), 104, 5)) = 100 Then
                            '                        oProv.Registro.Fields("IvaExencionRetencion").Value = "SI"
                            '                        oProv.Registro.Fields("IvaPorcentajeExencion").Value = Null
                            '                        oProv.Registro.Fields("IvaFechaCaducidadExencion").Value = CDate(mId(Filas(i), 86, 10))
                            '                     Else
                            oProv.Registro.Fields("IvaExencionRetencion").Value = "NO"
                            oProv.Registro.Fields("IvaPorcentajeExencion").Value = CSng(mId(Filas(i), 104, 5))
                            oProv.Registro.Fields("IvaFechaInicioExencion").Value = CDate(mId(Filas(i), 75, 10))
                            oProv.Registro.Fields("IvaFechaCaducidadExencion").Value = CDate(mId(Filas(i), 86, 10))
                            '                     End If
                            oAp.Tarea "LogImpuestos_A", Array(mFechaLog, mId(Filas(i), 110, 6), oRs.Fields(0).Value, -1, Null, oProv.Registro.Fields("IvaExencionRetencion").Value, oProv.Registro.Fields("IvaPorcentajeExencion").Value, oProv.Registro.Fields("IvaFechaCaducidadExencion").Value)
                            oProv.Guardar
                        End If
                    End If

                    oRs.Close
                End If
            End If
      
        ElseIf mCodigo = 4 Then
            Columnas = VBA.Split(Filas(i), ",")

            If UBound(Columnas) < 6 Then
                MsgBox "Archivo invalido", vbExclamation
                GoTo Salida
            End If

            'If IsNumeric(mId(Filas(i), 95, 1)) Then
            If IsNumeric(Columnas(4)) Then
                If mPrimero Then
                    mPrimero = False
                    mFechaLog = Now
                    oAp.Tarea "Proveedores_EstadoInicialImpositivo", Array(mFechaLog, "ReproWeb")
                End If

                mCuit = mId(Trim(Columnas(1)), 1, 2) & "-" & mId(Trim(Columnas(1)), 3, 8) & "-" & mId(Trim(Columnas(1)), 11, 1)
                Set oRs = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)

                If oRs.RecordCount > 0 Then
                    Set oProv = oAp.Proveedores.Item(oRs.Fields(0).Value)
                    'oProv.Registro.Fields("CodigoSituacionRetencionIVA").Value = CLng(mId(Filas(i), 95, 1))
                    oProv.Registro.Fields("CodigoSituacionRetencionIVA").Value = CLng(Columnas(4))
                    oAp.Tarea "LogImpuestos_A", Array(mFechaLog, "ReproWeb", oRs.Fields(0).Value, -1, Null, Null, -1, Null, oProv.Registro.Fields("CodigoSituacionRetencionIVA").Value)
                    oProv.Guardar
                End If

                oRs.Close
            End If
   
        ElseIf mCodigo = 5 Then

            '         Columnas = VBA.Split(Filas(i), vbTab)
            ''         If UBound(Columnas) < 7 Then
            ''            MsgBox "Archivo invalido", vbExclamation
            ''            GoTo Salida
            ''         End If
            '         If i >= 1 And Len(Columnas(0)) >= 11 Then
            '            mCuit = mId(Columnas(0), 1, 2) & "-" & mId(Columnas(0), 3, 8) & "-" & mId(Columnas(0), 11, 1)
            '            Set oRs = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)
            '            If oRs.RecordCount > 0 Then
            '               Set oProv = oAp.Proveedores.Item(oRs.Fields(0).Value)
            '               Columnas = VBA.Split(Filas(i + 2), vbTab)
            '               If Len(Columnas(0)) > 50 Then
            '                  If CInt(mId(Columnas(0), 31, 4)) = 100 And IsDate(mId(Columnas(0), 63, 9)) Then
            '                     With oProv.Registro
            '                        .Fields("RetenerSUSS").Value = "EX"
            '                        .Fields("SUSSFechaCaducidadExencion").Value = CDate(mId(Columnas(0), 63, 9))
            '                        .Fields("IdImpuestoDirectoSUSS").Value = Null
            '                     End With
            '                  End If
            '                  oProv.Guardar
            '               End If
            '               i = i + 3
            '            End If
            '            oRs.Close
            If IsNumeric(mId(Filas(i), 1, 11)) Then
                mCuit = mId(Filas(i), 1, 2) & "-" & mId(Filas(i), 3, 8) & "-" & mId(Filas(i), 11, 1)
                Set oRs = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)

                If oRs.RecordCount > 0 Then
                    '               mOk = False
                    '               For j = i To i + 10
                    '                  If IsDate(mId(Filas(j), 63, 9)) Then
                    '                     mOk = True
                    '                     i = j
                    '                     Exit For
                    '                  End If
                    '               Next
                    '               If mOk Then
                    Set oProv = oAp.Proveedores.Item(oRs.Fields(0).Value)
                    Columnas = VBA.Split(Filas(i), ";")

                    If UBound(Columnas) <> 7 Then
                        If mPrimero Then
                            MsgBox "Archivo invalido", vbExclamation
                            GoTo Salida
                        End If
                    End If

                    If mPrimero Then
                        mPrimero = False
                        mFechaLog = Now
                        oAp.Tarea "Proveedores_EstadoInicialImpositivo", Array(mFechaLog, "SUSS")
                    End If

                    mAuxS1 = Columnas(7)
                    mAuxS1 = Replace(mAuxS1, "JAN", "01")
                    mAuxS1 = Replace(mAuxS1, "FEB", "02")
                    mAuxS1 = Replace(mAuxS1, "MAR", "03")
                    mAuxS1 = Replace(mAuxS1, "APR", "04")
                    mAuxS1 = Replace(mAuxS1, "MAY", "05")
                    mAuxS1 = Replace(mAuxS1, "JUN", "06")
                    mAuxS1 = Replace(mAuxS1, "JUL", "07")
                    mAuxS1 = Replace(mAuxS1, "AUG", "08")
                    mAuxS1 = Replace(mAuxS1, "SEP", "09")
                    mAuxS1 = Replace(mAuxS1, "OCT", "10")
                    mAuxS1 = Replace(mAuxS1, "NOV", "11")
                    mAuxS1 = Replace(mAuxS1, "DEC", "12")

                    If Val(Columnas(3)) = 100 And IsDate(mAuxS1) Then

                        With oProv.Registro
                            .Fields("RetenerSUSS").Value = "EX"
                            .Fields("SUSSFechaCaducidadExencion").Value = CDate(mAuxS1)
                            .Fields("IdImpuestoDirectoSUSS").Value = Null
                        End With

                        oAp.Tarea "LogImpuestos_A", Array(mFechaLog, "SUSS", oRs.Fields(0).Value, -1, Null, Null, -1, Null, -1, oProv.Registro.Fields("SUSSFechaCaducidadExencion").Value)
                        oProv.Guardar
                    End If

                    '               End If
                End If

                oRs.Close
            End If
      
        ElseIf mCodigo = 6 Then

            If Len(Filas(i)) < 30 Then
                MsgBox "Archivo invalido", vbExclamation
                GoTo Salida
            End If

            mAux1 = mId(Trim(Filas(i)), 7, 2) & "/" & mId(Trim(Filas(i)), 5, 2) & "/" & mId(Trim(Filas(i)), 1, 4) & " Rentas Bs.As."
            mAux2 = Val(mId(Trim(Filas(i)), 20, 13)) / 100
            mCuit = mId(Trim(Filas(i)), 9, 2) & "-" & mId(Trim(Filas(i)), 11, 8) & "-" & mId(Trim(Filas(i)), 19, 1)
            Set oRs = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)

            If oRs.RecordCount > 0 Then
                Set oProv = oAp.Proveedores.Item(oRs.Fields(0).Value)

                With oProv.Registro
                    .Fields("SujetoEmbargado").Value = "SI"
                    .Fields("SaldoEmbargo").Value = mAux2
                    .Fields("DetalleEmbargo").Value = mAux1
                End With

                oProv.Guardar
            End If

            oRs.Close
   
        ElseIf mCodigo = 7 Then
            Columnas = VBA.Split(Filas(i), ";")

            If UBound(Columnas) < 6 Then
                MsgBox "Archivo invalido", vbExclamation
                GoTo Salida
            End If
         
            mAuxS1 = mId(Trim(Columnas(1)), 1, 2) & "/" & mId(Trim(Columnas(1)), 3, 2) & "/" & mId(Trim(Columnas(1)), 5, 4)
            mAuxS2 = mId(Trim(Columnas(2)), 1, 2) & "/" & mId(Trim(Columnas(2)), 3, 2) & "/" & mId(Trim(Columnas(2)), 5, 4)
            mAuxS3 = Replace(Columnas(8), ",", ".")
            mAuxS4 = Replace(Columnas(7), ",", ".")
         
            If IsDate(mAuxS1) And IsDate(mAuxS2) And IsNumeric(mAuxS3) Then
                If mPrimero Then
                    mPrimero = False
                    mFechaLog = Now
                    oAp.Tarea "Proveedores_EstadoInicialImpositivo", Array(mFechaLog, "IIBB")
                End If

                mCuit = mId(Trim(Columnas(3)), 1, 2) & "-" & mId(Trim(Columnas(3)), 3, 8) & "-" & mId(Trim(Columnas(3)), 11, 1)

                If oRsAux1.RecordCount > 0 Then
                    oRsAux1.MoveFirst
                    oRsAux1.Find "Cuit = " & mCuit

                    If Not oRsAux1.EOF Then
                        oAp.Tarea "Proveedores_ActualizarDatosIIBB", Array(oRsAux1.Fields(0).Value, Val(mAuxS3), CDate(mAuxS1), CDate(mAuxS2), CInt(Columnas(10)))
                        oAp.Tarea "LogImpuestos_A", Array(mFechaLog, "IIBB", oRsAux1.Fields(0).Value, -1, Null, Null, -1, Null, -1, Null, Val(mAuxS3), CDate(mAuxS1), CDate(mAuxS2), CInt(Columnas(10)))
                        '                  Set oProv = oAp.Proveedores.Item(oRsAux1.Fields(0).Value)
                        '                  With oProv.Registro
                        '                     .Fields("PorcentajeIBDirecto").Value = Val(mAuxS3)
                        '                     .Fields("FechaInicioVigenciaIBDirecto").Value = CDate(mAuxS1)
                        '                     .Fields("FechaFinVigenciaIBDirecto").Value = CDate(mAuxS2)
                        '                     .Fields("GrupoIIBB").Value = CInt(Columnas(10))
                        '                     oAp.Tarea "LogImpuestos_A", Array(mFechaLog, "IIBB", oRsAux1.Fields(0).Value, _
                        '                                                      -1, Null, Null, -1, Null, -1, Null, _
                        '                                                      .Fields("PorcentajeIBDirecto").Value, _
                        '                                                      .Fields("FechaInicioVigenciaIBDirecto").Value, _
                        '                                                      .Fields("FechaFinVigenciaIBDirecto").Value, _
                        '                                                      .Fields("GrupoIIBB").Value)
                        '                  End With
                        '                  oProv.Guardar
                        '                  Set oProv = Nothing
                    End If
                End If
            
                If oRsAux2.RecordCount > 0 Then
                    oRsAux2.MoveFirst
                    oRsAux2.Find "Cuit = " & mCuit

                    If Not oRsAux2.EOF Then
                        oAp.Tarea "Clientes_ActualizarDatosIIBB", Array(oRsAux2.Fields(0).Value, Val(mAuxS4), CDate(mAuxS1), CDate(mAuxS2), CInt(Columnas(9)))
                        oAp.Tarea "LogImpuestos_A", Array(mFechaLog, "IIBB", -1, -1, Null, Null, -1, Null, -1, Null, Val(mAuxS4), CDate(mAuxS1), CDate(mAuxS2), CInt(Columnas(9)), oRsAux2.Fields(0).Value)
                        '                  Set oCli = oAp.Clientes.Item(oRsAux2.Fields(0).Value)
                        '                  With oCli.Registro
                        '                     .Fields("PorcentajeIBDirecto").Value = Val(mAuxS4)
                        '                     .Fields("FechaInicioVigenciaIBDirecto").Value = CDate(mAuxS1)
                        '                     .Fields("FechaFinVigenciaIBDirecto").Value = CDate(mAuxS2)
                        '                     .Fields("GrupoIIBB").Value = CInt(Columnas(9))
                        '                     oAp.Tarea "LogImpuestos_A", Array(mFechaLog, "IIBB", -1, _
                        '                                                      -1, Null, Null, -1, Null, -1, Null, _
                        '                                                      .Fields("PorcentajeIBDirecto").Value, _
                        '                                                      .Fields("FechaInicioVigenciaIBDirecto").Value, _
                        '                                                      .Fields("FechaFinVigenciaIBDirecto").Value, _
                        '                                                      .Fields("GrupoIIBB").Value, oRsAux2.Fields(0).Value)
                        '                  End With
                        '                  oCli.Guardar
                        '                  Set oCli = Nothing
                    End If
                End If
            End If
      
        ElseIf mCodigo = 8 Then

            If Len(Filas(i)) < 30 Then
                MsgBox "Archivo invalido", vbExclamation
                GoTo Salida
            End If

            If mId(Trim(Filas(i)), 1, 1) = "2" Then
                mAuxS1 = mId(Trim(Filas(i)), 10, 2)

                Select Case mAuxS1

                    Case "01"
                        mAuxS2 = "A"

                    Case "06"
                        mAuxS2 = "B"

                    Case "11"
                        mAuxS2 = "C"

                    Case "19"
                        mAuxS2 = "E"

                    Case Else
                        mAuxS2 = "A"
                End Select

                mAuxL1 = CLng(mId(Trim(Filas(i)), 12, 4))
                mAuxL2 = CLng(mId(Trim(Filas(i)), 16, 8))
                mAuxL3 = CLng(mId(Trim(Filas(i)), 24, 8))

                For X = mAuxL2 To mAuxL3
                    Set oRs = oAp.Facturas.TraerFiltrado("_PorNumeroComprobante", Array(mAuxS2, mAuxL1, X))

                    If oRs.RecordCount > 0 Then
                        If mId(Trim(Filas(i)), 1, 1) = "2" Then
                            mAuxS3 = mId(Trim(Filas(i)), 136, 14)
                            mAuxD1 = CDate(mId(Trim(Filas(i)), 156, 2) & "/" & mId(Trim(Filas(i)), 154, 2) & "/" & mId(Trim(Filas(i)), 150, 4))
                            oAp.Tarea "Facturas_ActualizarDatosCAE", Array(oRs.Fields(0).Value, mAuxS3, Null, mAuxD1)
                        ElseIf mId(Trim(Filas(i)), 1, 1) = "4" Then
                            mAuxS3 = mId(Trim(Filas(i)), 144, 11)
                            mAuxD1 = CDate(mId(Trim(Filas(i)), 142, 2) & "/" & mId(Trim(Filas(i)), 140, 2) & "/" & mId(Trim(Filas(i)), 136, 4))
                            oAp.Tarea "Facturas_ActualizarDatosCAE", Array(oRs.Fields(0).Value, Null, mAuxS3, mAuxD1)
                        End If
                    End If

                    oRs.Close
                Next

            End If
         
        End If

    Next

Salida:

    On Error Resume Next
   
    Unload oF
    Set oF = Nothing
    Unload of1
    Set of1 = Nothing

    If mCodigo = 7 Then
        oRsAux1.Close
        oRsAux2.Close
    End If
   
    Set oRs = Nothing
    Set oRsAux1 = Nothing
    Set oRsAux2 = Nothing
    Set oProv = Nothing
    Set oCli = Nothing
    Set oAp = Nothing

    If mPrimero Then MsgBox "Se ha completado el proceso sin ningun registro procesado.", vbInformation
   
    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub MarcaImpresion(ByVal Marca As String, _
                          ByVal tipo As String)

    Dim oF As frmAutorizacion
    Dim iFilas As Integer
    Dim mMarca As String, mFiltro As String
    Dim mOk As Boolean
    Dim Filas, Columnas
   
    Set oF = New frmAutorizacion

    With oF
        .Empleado = 0
        .Administradores = True
        .Show vbModal, Me
        mOk = .Ok
    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub
   
    Me.Refresh
   
    If Marca = "Marcar" Then mMarca = "SI" Else mMarca = "NO"
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)

        Select Case tipo

            Case "RM"
                Aplicacion.Tarea "Requerimientos_RegistrarImpresion", Array(Columnas(2), mMarca)

            Case "PE"
                Aplicacion.Tarea "Pedidos_RegistrarImpresion", Array(Columnas(17), mMarca)
        End Select

    Next

    mFiltro = Lista.Filtrado
    Arbol_NodeClick Arbol.SelectedItem

    If Len(mFiltro) > 0 Then Lista.Filtrado = mFiltro

End Sub

Public Sub MarcarCuentasGastoComoActivas(ByVal Marca As String)

    Dim oL As ListItem
    Dim iFilas As Integer, i As Integer
    Dim Filas, Columnas
   
    i = 0

    For Each oL In Lista.ListItems

        If oL.SubItems(2) = "SI" Then i = i + 1
    Next
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)

        If IsNumeric(Columnas(1)) Then
            If i = 100 And Marca = "SI" Then
                MsgBox "No puede marcar mas de 100 cuentas de gastos como activas", vbExclamation
                GoTo Salida
            End If

            Aplicacion.Tarea "CuentasGastos_MarcarComoActiva", Array(Columnas(1), Marca)

            If Marca = "SI" And Columnas(3) <> "SI" Then i = i + 1
        End If

    Next

Salida:
    Arbol_NodeClick Arbol.SelectedItem

End Sub

Public Sub MarcarValoresComoConfirmados()

    On Error GoTo Mal
   
    Dim oF As frm_Aux
    Dim mOk As Boolean
    Dim mFecha As Date
   
    Set oF = New frm_Aux

    With oF
        .Caption = "Confirmacion"
        .text1.Visible = False
        .Label1.Caption = "Fecha conf.:"

        With .DTFields(0)
            .top = oF.text1.top
            .left = oF.text1.left
            .Value = Date
            .Visible = True
        End With

        .Show vbModal, Me
        mOk = .Ok
        mFecha = .DTFields(0).Value
    End With

    Unload oF
    Set oF = Nothing
   
    If Not mOk Then Exit Sub
   
    Dim Filas, Columnas, mVector
    Dim iFilas As Integer
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)

        If IsNumeric(Columnas(2)) Then
            Aplicacion.Tarea "Valores_MarcarComoConfirmado", Array(Columnas(2), glbIdUsuario, mFecha)
        End If

    Next
         
Salida:

    Exit Sub

Mal:
   
    Dim mvarResp As Integer

    Select Case Err.Number

        Case Else
            MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    End Select

    Resume Salida

End Sub

Public Sub TransferirAnticiposAlPersonalSyJ()

    'On Error GoTo Mal
   
    Dim oF As frm_Aux
    Dim mIdParametroLiquidacion As Integer
    Dim mOk As Boolean
   
    Set oF = New frm_Aux

    With oF
        .Caption = "Transferencia de anticipos al SyJ"
        .text1.Visible = False
        .Label1.Caption = "Liquidacion :"

        With .dcfields(0)
            .top = oF.text1.top
            .left = oF.text1.left
            .Width = .Width * 2
            .BoundColumn = "IdParametroLiquidacion"
            Set .RowSource = Aplicacion.AnticiposAlPersonalSyJ.TraerFiltrado("_ParametrosLiquidaciones")
            .Visible = True
        End With

        .Width = .Width * 1.3
        .Show vbModal, Me
        mOk = .Ok

        If IsNumeric(.dcfields(0).BoundText) Then
            mIdParametroLiquidacion = .dcfields(0).BoundText
        End If

    End With

    Unload oF
    Set oF = Nothing
   
    If Not mOk Then Exit Sub
    If mIdParametroLiquidacion = 0 Then
        MsgBox "No eligio una liquidacion para la transferencia", vbExclamation
        Exit Sub
    End If
   
    Aplicacion.Tarea "AnticiposAlPersonalSyJ_TransferirAnticiposAlSyJ", mIdParametroLiquidacion
    Arbol_NodeClick Arbol.SelectedItem
    MsgBox "Proceso Concluido"
   
Salida:

    Exit Sub

Mal:
   
    Dim mvarResp As Integer

    Select Case Err.Number

        Case Else
            MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    End Select

    Resume Salida

End Sub

Public Sub MarcarOrdenesCompraParaFacturacionAutomatica(ByVal Marca As String)

    Dim iFilas As Integer
    Dim Filas, Columnas
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)

        If IsNumeric(Columnas(2)) Then
            Aplicacion.Tarea "OrdenesCompra_MarcarParaFacturacionAutomatica", Array(Columnas(2), Marca)
        End If

    Next

    Arbol_NodeClick Arbol.SelectedItem

End Sub

Public Sub ImportacionAsientos()

    Dim oAp As ComPronto.Aplicacion
    Dim oAsi As ComPronto.Asiento
    Dim oPar As ComPronto.Parametro
    Dim oRsAux1 As ADOR.Recordset
    Dim oF As Form
    Dim oEx As Excel.Application
    Dim mOk As Boolean, mConProblemas As Boolean, mProceso As Boolean
    Dim mArchivos As String, mArchivo As String, mArchivo1 As String, mDoc As String
    Dim mPathEntrante As String, mPathBackup As String, s As String, s1 As String
    Dim mDetalle As String, mModelo1 As String, mCodigoSecundario As String
    Dim s2 As String, mAuxS1 As String
    Dim fl As Integer, i As Integer, j As Integer, mModelo As Integer
    Dim mIdAsiento As Long, mIdCuenta As Long, mIdCuentaBancaria As Long
    Dim mIdCaja As Long, mNumeroAsiento As Long
    Dim mDebe As Double, mHaber As Double
    Dim mAuxD1 As Date
    Dim mVector, mVectorAux, Filas, Columnas

    '   On Error GoTo Mal

    Set oAp = Aplicacion

    'Set oF = New frmAviso
    With oF
        .Label1 = "Iniciando ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Procesando asientos ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    mModelo1 = BuscarClaveINI("Modelo de importacion de asientos")

    If Len(mModelo1) = 0 Then
        mModelo = 1
    Else
        mModelo = Val(mModelo1)
    End If
   
    If mModelo = 1 Then
        fl = 2
    ElseIf mModelo = 2 Then
        fl = 7
    End If
   
    mPathEntrante = "C:\"
    Set oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)

    If oRsAux1.RecordCount > 0 Then
        mPathEntrante = IIf(IsNull(oRsAux1.Fields("PathImportacionDatos").Value), "C:\", oRsAux1.Fields("PathImportacionDatos").Value)
    End If

    oRsAux1.Close
    mPathBackup = mPathEntrante & "Backup\"
   
    Set oEx = CreateObject("Excel.Application")
   
    mArchivos = ""
    mArchivo = Dir(mPathEntrante & "*.*", vbArchive)

    Do While mArchivo <> ""
        mArchivos = mArchivos & mArchivo & ", "
        mArchivo = Dir
    Loop
   
    s2 = ""

    If Len(mArchivos) > 0 Then
        mVector = VBA.Split(mArchivos, ",")

        For i = 0 To UBound(mVector)
            mArchivo = Trim(UCase(mVector(i)))

            If Len(Trim(mArchivo)) > 0 Then
            
                mConProblemas = False
                s = "Proceso archivo : " & mArchivo
            
                Set oRsAux1 = oAp.Asientos.TraerFiltrado("_PorArchivoImportacion", mId(mArchivo, 1, 50))
                mIdAsiento = -1

                If oRsAux1.RecordCount > 0 Then
                    mIdAsiento = oRsAux1.Fields(0).Value
                    mNumeroAsiento = oRsAux1.Fields("NumeroAsiento").Value
                    s = s & " - Modificacion" & vbCrLf
                Else
                    s = s & vbCrLf
                End If

                oRsAux1.Close
            
                Set oAsi = oAp.Asientos.Item(mIdAsiento)
            
                oF.Label1 = oF.Label1 & vbCrLf & mArchivo

                DoEvents
            
                s1 = ""
                mProceso = False

                If right(mArchivo, 3) = "XLS" Or InStr(1, mArchivo, ".") = 0 Then
                    mProceso = True

                    With oEx
                        .Visible = True
                        .WindowState = xlMinimized
                        Me.Refresh

                        With .Workbooks.Open(mPathEntrante & mArchivo)

                            '.Sheets("Asiento diario").Select
                            With .ActiveSheet

                                If mModelo = 2 Then

                                    For j = 1 To 100

                                        If UCase(.Cells(j, 1)) = "CUENTA" Then
                                            fl = j + 2
                                            Exit For
                                        End If

                                    Next

                                End If

                                Do While True

                                    If Len(Trim(.Cells(fl, 1))) > 0 Then
                                        mIdCuentaBancaria = 0
                                        mIdCaja = 0
                                        mDetalle = ""
                                        mDebe = 0
                                        mHaber = 0
                              
                                        If mModelo = 1 Then
                                            mCodigoSecundario = .Cells(fl, 1)
                                 
                                            If Len(Trim(.Cells(fl, 4))) > 0 Then
                                                Set oRsAux1 = oAp.CuentasBancarias.TraerFiltrado("_PorCuenta", .Cells(fl, 4))

                                                If oRsAux1.RecordCount > 0 Then
                                                    mIdCuentaBancaria = oRsAux1.Fields(0).Value
                                                Else
                                                    s1 = s1 & "Cuenta bancaria " & .Cells(fl, 4) & ", inexistente" & vbCrLf
                                                End If

                                                oRsAux1.Close
                                            End If
                                 
                                            If Len(Trim(.Cells(fl, 5))) > 0 Then
                                                Set oRsAux1 = oAp.Cajas.TraerFiltrado("_PorDescripcion", .Cells(fl, 5))

                                                If oRsAux1.RecordCount > 0 Then
                                                    mIdCaja = oRsAux1.Fields(0).Value
                                                Else
                                                    s1 = s1 & "Caja " & .Cells(fl, 5) & ", inexistente" & vbCrLf
                                                End If

                                                oRsAux1.Close
                                            End If
                                 
                                            mDetalle = mId(.Cells(fl, 3), 1, 50)

                                            If Len(Trim(.Cells(fl, 6))) > 0 Then mDebe = Val(.Cells(fl, 6))
                                            If Len(Trim(.Cells(fl, 7))) > 0 Then mHaber = Val(.Cells(fl, 7))
                                        ElseIf mModelo = 2 Then

                                            If InStr(1, .Cells(fl, 1), "-") <> 0 Then
                                                mVectorAux = VBA.Split(.Cells(fl, 1), "-")
                                                mCodigoSecundario = Trim(mVectorAux(0))

                                                If Len(Trim(.Cells(fl, 4))) > 0 Then mDebe = Val(.Cells(fl, 4))
                                                If Len(Trim(.Cells(fl, 5))) > 0 Then mHaber = Val(.Cells(fl, 5))
                                            Else
                                                GoTo Vuelta
                                            End If
                                        End If
                              
                                        Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigoSecundario", mCodigoSecundario)
                                        mIdCuenta = 0

                                        If oRsAux1.RecordCount > 0 Then
                                            mIdCuenta = oRsAux1.Fields(0).Value
                                        Else
                                            mConProblemas = True
                                            s1 = s1 & "Cuenta " & mCodigoSecundario & ", inexistente" & vbCrLf
                                            GoTo Vuelta
                                        End If

                                        oRsAux1.Close
                              
                                        If mDebe = 0 And mHaber = 0 Then GoTo Vuelta
                              
                                        With oAsi.DetAsientos.Item(-1)
                                            With .Registro
                                                .Fields("IdCuenta").Value = mIdCuenta
                                                .Fields("Detalle").Value = mDetalle
                                                .Fields("IdMoneda").Value = 1
                                                .Fields("CotizacionMoneda").Value = 1
                                                .Fields("IdCuentaBancaria").Value = mIdCuentaBancaria
                                                .Fields("IdCaja").Value = mIdCaja
                                                .Fields("Debe").Value = mDebe
                                                .Fields("Haber").Value = mHaber
                                            End With

                                            .Modificado = True
                                        End With
            
                                        oF.Label2 = "Linea : " & fl

                                        DoEvents
Vuelta:
                                        fl = fl + 1
               
                                    Else
                                        Exit Do
                                    End If

                                Loop
                        
                                If oAsi.DetAsientos.TotalDebe <> oAsi.DetAsientos.TotalHaber Then
                                    mConProblemas = True
                                    s1 = s1 & "El asiento del archivo " & mArchivo & ", no balancea y fue descartado." & vbCrLf
                                End If
                        
                                mAuxS1 = mId(mArchivo, 14, 2) & "/" & mId(mArchivo, 12, 2) & "/" & mId(mArchivo, 8, 4)

                                If IsDate(mAuxS1) Then
                                    mAuxD1 = CDate(mAuxS1)
                                Else
                                    mAuxD1 = Date
                                End If

                                If mAuxD1 <= gblFechaUltimoCierre Then
                                    mConProblemas = True
                                    s1 = s1 & "La fecha del asiento " & mArchivo & ", no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre & vbCrLf
                                End If
                        
                                If Len(s1) > 0 Then
                                    s = s & s1 & vbCrLf
                                Else
                                    s = s & "Procesado correctamente" & vbCrLf & vbCrLf
                                End If

                                If Not mConProblemas Then
                                    If mIdAsiento = -1 Then
                                        Set oPar = oAp.Parametros.Item(1)
                                        mNumeroAsiento = IIf(IsNull(oPar.Registro.Fields("ProximoAsiento").Value), 1, oPar.Registro.Fields("ProximoAsiento").Value)
                                        oPar.Registro.Fields("ProximoAsiento").Value = mNumeroAsiento + 1
                                        oPar.Guardar
                                        Set oPar = Nothing

                                        With oAsi.Registro
                                            .Fields("NumeroAsiento").Value = mNumeroAsiento
                                            .Fields("FechaAsiento").Value = mAuxD1
                                            .Fields("IdIngreso").Value = glbIdUsuario
                                            .Fields("FechaIngreso").Value = Now
                                        End With

                                    Else

                                        With oAsi.Registro
                                            .Fields("IdModifico").Value = glbIdUsuario
                                            .Fields("FechaUltimaModificacion").Value = Now
                                        End With

                                        oAp.Tarea "Asientos_EliminarDetalles", mIdAsiento
                                    End If

                                    oAsi.Registro.Fields("ArchivoImportacion").Value = mId(mArchivo, 1, 50)
                                    oAsi.Registro.Fields("Concepto").Value = mId(mArchivo, 1, 50)
                                    oAsi.Guardar
                                    Set oAsi = Nothing
                                End If

                            End With

                            .Close False
                        End With

                        .Quit
                    End With
            
                ElseIf right(mArchivo, 3) = "CSV" Then
                    mProceso = True
                    mDoc = LeerArchivoSecuencial1(mPathEntrante & mArchivo)
                    Filas = VBA.Split(mDoc, Chr(10))

                    For j = LBound(Filas) + 1 To UBound(Filas)

                        If InStr(1, Filas(j), ";") <> 0 Then
                            Columnas = VBA.Split(Filas(j), ";")
                  
                            mIdCuentaBancaria = 0
                            mIdCaja = 0
                            mDetalle = ""
                            mDebe = 0
                            mHaber = 0
                        
                            mCodigoSecundario = Columnas(0)

                            If Len(Trim(mCodigoSecundario)) > 0 Then
                                If Len(Trim(Columnas(3))) > 0 Then
                                    Set oRsAux1 = oAp.CuentasBancarias.TraerFiltrado("_PorCuenta", Columnas(3))

                                    If oRsAux1.RecordCount > 0 Then
                                        mIdCuentaBancaria = oRsAux1.Fields(0).Value
                                    Else
                                        s1 = s1 & "Cuenta bancaria " & Columnas(3) & ", inexistente" & vbCrLf
                                    End If

                                    oRsAux1.Close
                                End If
                        
                                mDetalle = mId(Columnas(2), 1, 50)

                                If Len(Trim(Columnas(4))) > 0 Then mDebe = Val(Replace(Columnas(4), ",", "."))
                                If Len(Trim(Columnas(5))) > 0 Then mHaber = Val(Replace(Columnas(5), ",", "."))
                        
                                Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigoSecundario", mCodigoSecundario)
                                mIdCuenta = 0

                                If oRsAux1.RecordCount > 0 Then
                                    mIdCuenta = oRsAux1.Fields(0).Value
                                Else
                                    mConProblemas = True
                                    s1 = s1 & "Cuenta " & mCodigoSecundario & ", inexistente" & vbCrLf
                                    GoTo Vuelta1
                                End If

                                oRsAux1.Close
                        
                                If Not (mDebe = 0 And mHaber = 0) Then

                                    With oAsi.DetAsientos.Item(-1)
                                        With .Registro
                                            .Fields("IdCuenta").Value = mIdCuenta
                                            .Fields("Detalle").Value = mDetalle
                                            .Fields("IdMoneda").Value = 1
                                            .Fields("CotizacionMoneda").Value = 1
                                            .Fields("IdCuentaBancaria").Value = mIdCuentaBancaria
                                            .Fields("IdCaja").Value = mIdCaja
                                            .Fields("Debe").Value = mDebe
                                            .Fields("Haber").Value = mHaber
                                        End With

                                        .Modificado = True
                                    End With
      
                                    oF.Label2 = "Linea : " & j

                                    DoEvents
                                End If
                            End If
                        End If

Vuelta1:
                    Next
               
                    If oAsi.DetAsientos.TotalDebe <> oAsi.DetAsientos.TotalHaber Then
                        mConProblemas = True
                        s1 = s1 & "El asiento del archivo " & mArchivo & ", no balancea y fue descartado." & vbCrLf
                    End If
                        
                    If Len(s1) > 0 Then
                        s = s & s1 & vbCrLf
                    Else
                        s = s & "Procesado correctamente" & vbCrLf & vbCrLf
                    End If
               
                    If Not mConProblemas Then
                        If mIdAsiento = -1 Then
                            Set oPar = oAp.Parametros.Item(1)
                            mNumeroAsiento = IIf(IsNull(oPar.Registro.Fields("ProximoAsiento").Value), 1, oPar.Registro.Fields("ProximoAsiento").Value)
                            oPar.Registro.Fields("ProximoAsiento").Value = mNumeroAsiento + 1
                            oPar.Guardar
                            Set oPar = Nothing
                            mAuxS1 = mId(mArchivo, 14, 2) & "/" & mId(mArchivo, 12, 2) & "/" & mId(mArchivo, 8, 4)

                            If IsDate(mAuxS1) Then
                                mAuxD1 = CDate(mAuxS1)
                            Else
                                mAuxD1 = Date
                            End If

                            With oAsi.Registro
                                .Fields("NumeroAsiento").Value = mNumeroAsiento
                                .Fields("FechaAsiento").Value = mAuxD1
                                .Fields("IdIngreso").Value = glbIdUsuario
                                .Fields("FechaIngreso").Value = Now
                            End With

                        Else

                            With oAsi.Registro
                                .Fields("IdModifico").Value = glbIdUsuario
                                .Fields("FechaUltimaModificacion").Value = Now
                            End With

                            oAp.Tarea "Asientos_EliminarDetalles", mIdAsiento
                        End If

                        oAsi.Registro.Fields("ArchivoImportacion").Value = mId(mArchivo, 1, 50)
                        oAsi.Registro.Fields("Concepto").Value = mId(mArchivo, 1, 50)
                        oAsi.Guardar
                        Set oAsi = Nothing
                    End If
            
                End If

                s2 = s2 & s
            
                If Not mConProblemas And mProceso Then
                    mArchivo1 = Dir(mPathBackup & mArchivo, vbArchive)

                    If mArchivo1 <> "" Then Kill mPathBackup & mArchivo1
                    s1 = "Copy " & mPathEntrante & mArchivo & " " & mPathBackup & mArchivo & " /Y"
                    GuardarArchivoSecuencial mPathEntrante & "Copiar.bat", s1
                    j = Shell(mPathEntrante & "Copiar.bat", vbHide)
                    Sleep 1000
                    Kill mPathEntrante & mArchivo
                End If
            End If

        Next
      
        Unload oF
        Set oF = New frm_Aux

        With oF
            .Caption = "Reporte de importacion de asientos contables"
            .Width = .Width * 2
            .Height = .Height * 2
            .cmd(0).Caption = "Salir"
            .cmd(0).top = oF.Height - 900

            With .RichTextBox1
                .top = 0
                .left = 0
                .Width = oF.Width
                .Height = oF.Height - 1000
                .Text = s2
                .Visible = True
            End With

            .Show vbModal, Me
        End With
      
    End If
   
Salida:

    Unload oF
    Set oF = Nothing

    Set oRsAux1 = Nothing
    Set oAp = Nothing
    Set oAsi = Nothing
    Set oPar = Nothing
    Set oEx = Nothing

    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub ImportacionAsientos1()

    Dim oAp As ComPronto.Aplicacion
    Dim oAsi As ComPronto.Asiento
    Dim oPar As ComPronto.Parametro
    Dim oRsAux1 As ADOR.Recordset
    Dim oF As Form
    Dim oEx As Excel.Application
    Dim mOk As Boolean, mConProblemas As Boolean, mProceso As Boolean
    Dim mCodigo As String, mArchivo As String, mArchivo1 As String
    Dim s As String, s1 As String, s2 As String, mAuxS1 As String
    Dim mDetalle As String
    Dim fl As Integer, i As Integer, j As Integer, mModelo As Integer
    Dim mIdAsiento As Long, mIdCuenta As Long, mNumeroAsiento As Long
    Dim mDebe As Double, mHaber As Double
    Dim mFecha As Date

    '   On Error GoTo Mal

    'Set oF = New frmPathPresto
    With oF
        .Id = 11
        .Show vbModal
        mOk = .Ok

        If mOk Then
            mArchivo = .FileBrowser1(0).Text
            mFecha = .DTFields(0).Value
        End If

    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub

    If mFecha <= gblFechaUltimoCierre Then
        MsgBox "La fecha del asiento no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbExclamation
        Exit Sub
    End If
   
    Set oAp = Aplicacion

    'Set oF = New frmAviso
    With oF
        .Label1 = "Iniciando ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Procesando asientos ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    Set oEx = CreateObject("Excel.Application")
   
    If Len(Trim(mArchivo)) > 0 Then
      
        mConProblemas = False
        s = "Proceso archivo : " & mArchivo
      
        Set oRsAux1 = oAp.Asientos.TraerFiltrado("_PorArchivoImportacion", mId(mArchivo, 1, 200))
        mIdAsiento = -1

        If oRsAux1.RecordCount > 0 Then
            mIdAsiento = oRsAux1.Fields(0).Value
            mNumeroAsiento = oRsAux1.Fields("NumeroAsiento").Value
            s = s & " - Modificacion" & vbCrLf
        Else
            s = s & vbCrLf
        End If

        oRsAux1.Close
      
        mDetalle = ""
        fl = 2
      
        Set oAsi = oAp.Asientos.Item(mIdAsiento)
      
        oF.Label1 = oF.Label1 & vbCrLf & mArchivo

        DoEvents
            
        With oEx
            .Visible = True
            .WindowState = xlMinimized
            Me.Refresh

            With .Workbooks.Open(mArchivo)
                With .ActiveSheet

                    Do While True

                        If Len(Trim(.Cells(fl, 2))) > 0 Then
                            mDebe = 0
                            mHaber = 0
                            mCodigo = LTrim(.Cells(fl, 2))

                            If InStr(1, mCodigo, " ") <> 0 Then
                                mCodigo = mId(mCodigo, 1, InStr(1, mCodigo, " ") - 1)
                            End If

                            If Trim(.Cells(fl, 4)) = "D" Then
                                If Len(Trim(.Cells(fl, 3))) > 0 Then mDebe = Val(.Cells(fl, 3))
                            Else

                                If Len(Trim(.Cells(fl, 3))) > 0 Then mHaber = Val(.Cells(fl, 3))
                            End If
                     
                            Set oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigo", IIf(IsNumeric(mCodigo), mCodigo, 0))
                            mIdCuenta = 0

                            If oRsAux1.RecordCount > 0 Then
                                mIdCuenta = oRsAux1.Fields(0).Value
                            Else
                                mConProblemas = True
                                s1 = s1 & "Cuenta " & mCodigo & ", inexistente" & vbCrLf
                                GoTo Vuelta
                            End If

                            oRsAux1.Close
                              
                            If mDebe = 0 And mHaber = 0 Then GoTo Vuelta
                              
                            With oAsi.DetAsientos.Item(-1)
                                With .Registro
                                    .Fields("IdCuenta").Value = mIdCuenta
                                    .Fields("Detalle").Value = mDetalle
                                    .Fields("IdMoneda").Value = 1
                                    .Fields("CotizacionMoneda").Value = 1
                                    '.Fields("IdCuentaBancaria").Value = mIdCuentaBancaria
                                    '.Fields("IdCaja").Value = mIdCaja
                                    .Fields("Debe").Value = mDebe
                                    .Fields("Haber").Value = mHaber
                                End With

                                .Modificado = True
                            End With
            
                            oF.Label2 = "Linea : " & fl

                            DoEvents
Vuelta:
                            fl = fl + 1
      
                        Else
                            Exit Do
                        End If

                    Loop
                        
                    If oAsi.DetAsientos.TotalDebe <> oAsi.DetAsientos.TotalHaber Then
                        mConProblemas = True
                        s1 = s1 & "El asiento del archivo " & mArchivo & ", no balancea y fue descartado." & vbCrLf
                    End If
                        
                    If Len(s1) > 0 Then
                        s = s & s1 & vbCrLf
                    Else
                        s = s & "Procesado correctamente" & vbCrLf & vbCrLf
                    End If

                    If Not mConProblemas Then
                        If mIdAsiento = -1 Then
                            Set oPar = oAp.Parametros.Item(1)
                            mNumeroAsiento = IIf(IsNull(oPar.Registro.Fields("ProximoAsiento").Value), 1, oPar.Registro.Fields("ProximoAsiento").Value)
                            oPar.Registro.Fields("ProximoAsiento").Value = mNumeroAsiento + 1
                            oPar.Guardar
                            Set oPar = Nothing

                            With oAsi.Registro
                                .Fields("NumeroAsiento").Value = mNumeroAsiento
                                .Fields("FechaAsiento").Value = mFecha
                                .Fields("IdIngreso").Value = glbIdUsuario
                                .Fields("FechaIngreso").Value = Now
                            End With

                        Else

                            With oAsi.Registro
                                .Fields("IdModifico").Value = glbIdUsuario
                                .Fields("FechaUltimaModificacion").Value = Now
                            End With

                            oAp.Tarea "Asientos_EliminarDetalles", mIdAsiento
                        End If

                        oAsi.Registro.Fields("ArchivoImportacion").Value = mId(mArchivo, 1, 50)
                        oAsi.Registro.Fields("Concepto").Value = mId(QuitarPath(mArchivo), 1, 50)
                        oAsi.Guardar
                        Set oAsi = Nothing
                    End If

                End With

                .Close False
            End With

            .Quit
        End With
            
        Unload oF
      
        If Len(s1) > 0 Then
            Set oF = New frm_Aux

            With oF
                .Caption = "Reporte de importacion de asientos contables"
                .Width = .Width * 2
                .Height = .Height * 2
                .cmd(0).Caption = "Salir"
                .cmd(0).top = oF.Height - 900

                With .RichTextBox1
                    .top = 0
                    .left = 0
                    .Width = oF.Width
                    .Height = oF.Height - 1000
                    .Text = s1
                    .Visible = True
                End With

                .Show vbModal, Me
            End With

        End If
      
    End If
   
Salida:

    Unload oF
    Set oF = Nothing

    Set oRsAux1 = Nothing
    Set oAp = Nothing
    Set oAsi = Nothing
    Set oPar = Nothing
    Set oEx = Nothing

    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub DefinicionBasesParaConsolidacion()

    Dim oRs As ADOR.Recordset
    Dim oF As frm_Aux
    Dim oL As ListItem
    Dim mOk As Boolean
    Dim s As String
    Dim i As Integer
    Dim Filas, Columnas
   
    Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("_TempBasesConciliacion", "_TraerTodo")
   
    Set oF = New frm_Aux

    With oF
        .Caption = "Definicion de bases para consolidacion"
        .text1.Visible = False
        .Width = .Width * 2.15
        .Height = .Height * 1.8

        With .Lista
            .left = oF.Label1.left
            .top = 400
            .Width = 7000
            .Height = 2500
            .MultiSelect = True
            Set .DataSource = oRs
            .Visible = True
        End With

        Set .dcfields(0).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("BD", "_BasesInstaladas")

        With .cmd(0)
            .top = 3000
            .left = oF.Lista.left
            .Caption = "Guardar"
        End With

        .cmd(1).top = .cmd(0).top
        .Id = 5
        .Show vbModal, Me
        mOk = .Ok

        For Each oL In .Lista.ListItems
            oL.Selected = True
        Next

        s = .Lista.GetString
    End With

    Unload oF
    Set oF = Nothing

    If mOk Then
        Aplicacion.Tarea "_TempBasesConciliacion_BorrarTabla"
        Filas = VBA.Split(s, vbCrLf)

        For i = LBound(Filas) + 1 To UBound(Filas)
            Columnas = VBA.Split(Filas(i), vbTab)
            Aplicacion.Tarea "_TempBasesConciliacion_InsertarRegistro", Array(Columnas(1), Columnas(2), Columnas(3))
        Next

    End If

    Set oRs = Nothing

End Sub

Public Sub ConsolidacionContable()

    Dim mvarSeguro As Integer
    mvarSeguro = MsgBox("Esta seguro de ejecutar la consolidacion contable ?", vbYesNo, "Consolidacion contable")

    If mvarSeguro = vbYes Then
        Aplicacion.Tarea "Cuentas_Consolidacion", Array(Date)
        MsgBox "Proceso concluido", vbInformation
    End If

End Sub

Public Sub CierreZ()

    Dim Respuesta As Boolean
    Dim mFiscal As String
   
    mFiscal = BuscarClaveINI("Impresora fiscal")
   
    If Len(mFiscal) > 0 Then
        Dim mvarSeguro As Integer
        mvarSeguro = MsgBox("Esta seguro de hacer el cierre Z?", vbYesNo, "Cierre Z")

        If mvarSeguro = vbYes Then
            On Error GoTo Impresora_apag

            If mId(mFiscal, 1, 2) = "EP" Then
                MsgBox "Para emitir el cierre Z, si facturo con el controlador previamente" & vbCrLf & "salga del programa y vuelva a entrar.", vbInformation
                'Respuesta = Me.PrinterFiscal1.CloseJournal("Z")
            Else

                If Len(BuscarClaveINI("Puerto impresora fiscal")) > 0 Then
                    'HASAR1.Puerto = Val(BuscarClaveINI("Puerto impresora fiscal"))
                Else
                    'HASAR1.Puerto = 1
                End If

                '            HASAR1.Modelo = Val(mFiscal)
                '            HASAR1.Comenzar
                '            HASAR1.PrecioBase = False
                '            HASAR1.TratarDeCancelarTodo
                '            HASAR1.ReporteZ
                '            HASAR1.Finalizar
            End If
        End If

    Else
        MsgBox "No hay definido un controlador fiscal!!", vbExclamation
    End If
   
    Exit Sub

Impresora_apag:
    MsgBox "Error Impresora:" & Err.Description, vbRetryCancel, "Errores"

End Sub

Public Sub Envio_RM_Proveedores()

    Dim Filas, Columnas
    Dim iFilas As Integer, i As Integer
    Dim s As String
   
    s = ""
    Filas = VBA.Split(Lista.GetString, vbCrLf)

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
        s = s & Columnas(2) & "|"
    Next

    If Len(s) = 0 Then
        MsgBox "No hay documentos para enviar", vbExclamation
        Exit Sub
    Else
        s = mId(s, 1, Len(s) - 1)
    End If
   
    Dim oF As frm_Aux
    Set oF = New frm_Aux

    With oF
        .Caption = "Enviar RM's a proveedores"
        .text1.Visible = False
        .Label1.Visible = False
        .Width = .Width * 3.5
        .Height = .Height * 3.1

        With .Lista
            .left = oF.Label1.left
            .top = 500
            .Width = 12000
            .Height = 5400
            .Checkboxes = True
            .Visible = True
        End With

        With .cmd(0)
            .top = 6000
            .left = oF.Lista.left
            .Caption = "Generar"
        End With

        .cmd(1).top = .cmd(0).top
        .Parametros = s
        .Id = 11
        .Show vbModal, Me
    End With

    Unload oF
    Set oF = Nothing

End Sub

Public Sub RegistrarFechaSalidaPedido()

    Dim iFilas As Integer
    Dim mFecha As Date
    Dim mOk As Boolean
    Dim Filas, Columnas
    Dim oF As frm_Aux
   
    Set oF = New frm_Aux

    With oF
        .Caption = "Fecha de salida de pedido"
        .text1.Visible = False
        .Label1.Caption = "Fecha de salida :"

        With .DTFields(0)
            .top = oF.text1.top
            .Value = Date
            .Visible = True
        End With

        .Show vbModal, Me
        mOk = .Ok
        mFecha = .DTFields(0).Value
    End With

    Unload oF
    Set oF = Nothing
   
    If Not mOk Then Exit Sub
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
        Aplicacion.Tarea "Pedidos_RegistrarFechaSalida", Array(Columnas(17), mFecha)
    Next

    Arbol_NodeClick Arbol.SelectedItem

End Sub

Public Sub EnvioFax_RM_Proveedores()

    Dim Filas, Columnas
    Dim iFilas As Integer, i As Integer
    Dim s As String
   
    s = ""
    Filas = VBA.Split(Lista.GetString, vbCrLf)

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
        s = s & Columnas(2) & "|"
    Next

    If Len(s) = 0 Then
        MsgBox "No hay documentos para enviar", vbExclamation
        Exit Sub
    Else
        s = mId(s, 1, Len(s) - 1)
    End If
   
    Dim oF As frm_Aux
    Set oF = New frm_Aux

    With oF
        .Caption = "Enviar RM's a proveedores por fax"
        .text1.Visible = False
        .Label1.Visible = False
        .Width = .Width * 3.5
        .Height = .Height * 3.1

        With .Lista
            .left = oF.Label1.left
            .top = 500
            .Width = 12000
            .Height = 5400
            .Checkboxes = True
            .Visible = True
        End With

        With .cmd(0)
            .top = 6000
            .left = oF.Lista.left
            .Caption = "Generar"
        End With

        .cmd(1).top = .cmd(0).top
        .Parametros = s
        .Id = 12
        .Show vbModal, Me
    End With

    Unload oF
    Set oF = Nothing

End Sub

Public Sub GenerarMensajesPorControlDeStock()

    Dim mAux1 As String, mAux2 As String
    Dim oRs As ADOR.Recordset
   
    mAux1 = BuscarClaveINI("Legajos para aviso de control de stock")

    If InStr(1, mAux1, "(" & glbLegajo & ")") <> 0 Then
        Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_Control_Reposicion_Minimo", "A")

        With oRs

            If .RecordCount > 0 Then
                .MoveFirst

                Do While Not .EOF
                    mAux2 = "" & IIf(IsNull(.Fields("Codigo").Value), "", .Fields("Codigo").Value & " - ") & IIf(IsNull(.Fields("Articulo").Value), "", .Fields("Articulo").Value)

                    If Not IsNull(.Fields("Faltante min.").Value) Then
                        mAux2 = mId(mAux2, 1, 150) & ", min.:" & .Fields("Stock min.").Value & " " & ", stk.:" & .Fields("Stock actual").Value & " " & ", fal.:" & .Fields("Faltante min.").Value
                        Aplicacion.Tarea "NovedadesUsuarios_GrabarNovedadNueva", Array(glbIdUsuario, 0, mAux2, .Fields("IdArticulo").Value, "STOCK MINIMO")
                    ElseIf Not IsNull(.Fields("Faltante rep.").Value) Then
                        mAux2 = mId(mAux2, 1, 150) & ", rep.:" & .Fields("Stock rep.").Value & " " & ", stk.:" & .Fields("Stock actual").Value & " " & ", fal.:" & .Fields("Faltante rep.").Value
                        Aplicacion.Tarea "NovedadesUsuarios_GrabarNovedadNueva", Array(glbIdUsuario, 0, mAux2, .Fields("IdArticulo").Value, "STOCK REPOSICION")
                    End If

                    .MoveNext
                Loop

            End If

            .Close
        End With

        Set oRs = Nothing
    End If

End Sub

Public Sub DefinirGruposCuentasParaAjusteEnSubdiarios()

    Dim oF As frm_Aux
    Dim mOk As Boolean
   
    Set oF = New frm_Aux

    With oF
        .Caption = "Definir grupos de cuentas para ajustar subdiarios"
        .Label1.Visible = False
        .text1.Visible = False
        .Width = .Width * 2
        .Height = .Height * 3.2

        With .Lista
            .left = oF.Label1.left
            .top = 500
            .Width = 6500
            .Height = 5400
            .Checkboxes = True
            .Visible = True
            Set .SmallIcons = oF.img16
            Set .DataSource = Aplicacion.TiposCuentaGrupos.TraerTodos
        End With

        .Id = 13

        With .cmd(0)
            .top = 6000
            .left = oF.Lista.left
            .Caption = "Guardar"
        End With

        With .cmd(1)
            .left = oF.cmd(0).left + oF.cmd(0).Width + 50
            .top = oF.cmd(0).top
        End With

        With .Label3
            .top = oF.cmd(0).top
            .left = oF.cmd(1).left + oF.cmd(1).Width + 100
            .Width = 3000
            .Height = 600
            .Caption = "Las cuentas con jerarquia mayor a 5 son tomadas automaticamente para ajustar"
            .Visible = True
        End With

        .Show vbModal, Me
        mOk = .Ok
    End With

    Unload oF
    Set oF = Nothing

End Sub

Public Sub SeleccionarComprobantesProveedores()

    Dim oEx As Excel.Application
    Dim oF As Form
    Dim oL As ListItem
    Dim mArchivo As String, mLiteral As String
    Dim mOk As Boolean
    Dim fl As Integer, mContador As Integer

    '   On Error GoTo Mal

    'Set oF = New frmPathPresto
    With oF
        .Id = 11
        .Show vbModal
        mOk = .Ok

        If mOk Then
            mArchivo = .FileBrowser1(0).Text
        End If

    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub

    'Set oF = New frmAviso
    With oF
        .Label1 = "Iniciando EXCEL ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Importando datos ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    fl = 1
    mLiteral = oF.Label1.Caption & vbCrLf
   
    Set oEx = CreateObject("Excel.Application")

    With oEx
        .Visible = True
        .WindowState = xlMinimized
        Me.Refresh
      
        With .Workbooks.Open(mArchivo)
            .Sheets("Hoja1").Select

            With .ActiveSheet

                Do While True

                    If Len(Trim(.Cells(fl, 1))) > 0 Then
                        mContador = mContador + 1
                        oF.Label1 = mLiteral & "Comprobante : " & .Cells(fl, 1)
                        oF.Label3 = "" & mContador

                        DoEvents

                        For Each oL In Lista.ListItems

                            If InStr(1, .Cells(fl, 1), oL.SubItems(3)) <> 0 Then
                                oL.Selected = True
                            End If

                        Next

                        fl = fl + 1
                    Else
                        Exit Do
                    End If

                Loop

            End With

            .Close False
        End With

        .Quit
    End With
   
Salida:

    Unload oF
    Set oF = Nothing

    Exit Sub

Mal:

    MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    Resume Salida

End Sub

Public Sub CierreRendicionFF()

    Dim oF As Form
    Dim Filas, Columnas
    Dim iFilas As Integer, i As Integer
    Dim mIdUsuario As Long, mProximaRendicion As Long
    Dim s As String, mUsuario As String
    Dim mOk As Boolean
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)

    If UBound(Filas) = 0 Then Exit Sub
    Columnas = VBA.Split(Filas(1), vbTab)
   
    '   Set oF = New frmAutorizacion
    '   With oF
    '      .Empleado = 0
    '      .Administradores = True
    '      .Show vbModal, Me
    '      mOk = .Ok
    '      mUsuario = .Autorizo
    '      mIdUsuario = .IdAutorizo
    '   End With
    '   Unload oF
    '   Set oF = Nothing
    '   If Not mOk Then Exit Sub
   
    mIdUsuario = glbIdUsuario
    mUsuario = glbInicialesUsuario
   
    Me.Refresh
   
    Set oF = New frm_Aux

    With oF
        .Caption = "Cerrar rendicion de FF"
        .Label1.Caption = "Prox.Rend. :"

        With .text1
            .Text = Val(Columnas(3)) + 1
            .Enabled = False
        End With

        .Id = 14
        .Show vbModal, Me
        mOk = .Ok
        mProximaRendicion = .text1.Text
    End With

    Unload oF
    Set oF = Nothing
   
    If mOk Then
        Aplicacion.Tarea "Cuentas_IncrementarRendicionFF", Array(Columnas(2), mProximaRendicion)
    End If

    Arbol_NodeClick Arbol.SelectedItem

End Sub

Public Sub MarcarOPEnCaja()

    Dim s As String, iFilas As Integer
    Dim Filas, Columnas
    Filas = VBA.Split(Lista.GetString, vbCrLf)
    s = ""

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)

        If IsNumeric(Columnas(0)) Then
            Aplicacion.Tarea "OrdenesPago_MarcarComoEnCaja", Columnas(2)
        End If

    Next

    Arbol_NodeClick Arbol.SelectedItem

End Sub

Public Sub ConfirmarAcreditacionFF()

    Dim oF As frmAutorizacion
    Dim s As String, iFilas As Integer
    Dim mOk As Boolean
    Dim Filas, Columnas
   
    Set oF = New frmAutorizacion

    With oF
        .Empleado = 0
        .Administradores = True
        .Show vbModal, Me
        mOk = .Ok
    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub
   
    Me.Refresh
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)
    s = ""

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)

        If IsNumeric(Columnas(2)) Then
            Aplicacion.Tarea "OrdenesPago_ConfirmarAcreditacionFF", Columnas(2)
        End If

    Next

    Arbol_NodeClick Arbol.SelectedItem

End Sub

Public Sub RecalcularCostoKits()

    Aplicacion.Tarea "Conjuntos_CalcularCostoConjunto_Todos"
    MsgBox "Proceso de recalculo terminado!"

End Sub

Public Sub ImportacionNotasDebito()

    Dim oAp As ComPronto.Aplicacion
    Dim oDeb As ComPronto.NotaDebito
    Dim oPto As ComPronto.PuntoVenta
    Dim oPar As ComPronto.Parametro
    Dim oRs As ADOR.Recordset
    Dim oRsAux As ADOR.Recordset
    Dim oF As Form
    Dim oEx As Excel.Application
    Dim mArchivo As String, mCodigoCliente As String, mError As String, mvarTipoABC As String
    Dim mOk As Boolean, mConProblemas As Boolean
    Dim fl As Integer, mContador As Integer, mIdConcepto As Integer, mvarIdPuntoVenta As Integer
    Dim mIdCodigoIva As Integer
    Dim mvarNumero As Long
    Dim mImporte As Double, mvarCotizacion As Double
    Dim mvarP_IVA1 As Single
   
    '   On Error GoTo Mal
   
    mvarCotizacion = Cotizacion(Date, glbIdMonedaDolar)

    If mvarCotizacion = 0 Then
        MsgBox "No hay registrada una cotizacion dolar de hoy", vbExclamation
        Exit Sub
    End If
   
    'Set oF = New frmPathPresto
    With oF
        .Id = 13
        .Show vbModal
        mOk = .Ok

        If mOk Then mArchivo = .FileBrowser1(0).Text
    End With

    Unload oF
    Set oF = Nothing

    If Not mOk Then Exit Sub

    'Set oF = New frmAviso
    With oF
        .Label1 = "Iniciando EXCEL ..."
        .Show
        .Refresh

        DoEvents
    End With

    oF.Label1 = oF.Label1 & vbCrLf & "Procesando notas de debito ..."
    oF.Label2 = ""
    oF.Label3 = ""

    DoEvents

    fl = 2
    mContador = 0
    mError = ""
   
    Set oAp = Aplicacion
   
    Set oRs = oAp.Parametros.Item(1).Registro
    mvarP_IVA1 = IIf(IsNull(oRs.Fields("Iva1").Value), 0, oRs.Fields("Iva1").Value)
    oRs.Close
   
    Set oEx = CreateObject("Excel.Application")

    With oEx
        .Visible = True
        .WindowState = xlMinimized
        Me.Refresh
      
        With .Workbooks.Open(mArchivo)
            With .ActiveSheet

                Do While True

                    If Len(Trim(.Cells(fl, 1))) = 0 Then Exit Do
               
                    mConProblemas = False
               
                    mCodigoCliente = .Cells(fl, 1)
                    mImporte = .Cells(fl, 3)
                    mIdConcepto = .Cells(fl, 4)
               
                    mContador = mContador + 1
                    oF.Label2 = "Cliente : " & mCodigoCliente
                    oF.Label3 = "" & mContador

                    DoEvents
            
                    Set oRs = oAp.Clientes.TraerFiltrado("_PorCodigoCliente", mCodigoCliente)

                    If oRs.RecordCount = 0 Then
                        mError = mError & vbCrLf & "El cliente " & mCodigoCliente & "no existe."
                    Else
                        mIdCodigoIva = IIf(IsNull(oRs.Fields("IdCodigoIva").Value), 1, oRs.Fields("IdCodigoIva").Value)

                        If mIdCodigoIva <= 2 Or mIdCodigoIva = 9 Then
                            mvarTipoABC = "A"
                        Else
                            mvarTipoABC = "B"
                        End If

                        '                  Set oRsAux = oAp.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(3, mvarTipoABC))
                        '                  Set oPto = oAp.PuntosVenta.Item(oRsAux.Fields(0).Value)
                        '                  mvarNumero = oPto.Registro.Fields("ProximoNumero").Value
                        '                  oRsAux.Close
               
                        Set oPar = oAp.Parametros.Item(1)
                        mvarNumero = IIf(IsNull(oPar.Registro.Fields("ProximaNotaDebitoInterna").Value), 1, oPar.Registro.Fields("ProximaNotaDebitoInterna").Value)
                        oPar.Registro.Fields("ProximaNotaDebitoInterna").Value = mvarNumero + 1
                        oPar.Guardar
                        Set oPar = Nothing
               
                        Set oDeb = oAp.NotasDebito.Item(-1)

                        With oDeb
                            With .Registro
                                .Fields("NumeroNotaDebito").Value = mvarNumero
                                .Fields("TipoABC").Value = mvarTipoABC
                                .Fields("PuntoVenta").Value = 0
                                .Fields("IdPuntoVenta").Value = 0
                                .Fields("IdCliente").Value = oRs.Fields(0).Value
                                .Fields("FechaNotaDebito").Value = Date
                                .Fields("IdVendedor").Value = oRs.Fields("Vendedor1").Value
                                .Fields("ImporteTotal").Value = mImporte
                                .Fields("ImporteIva1").Value = 0
                                .Fields("ImporteIva2").Value = 0
                                .Fields("IVANoDiscriminado").Value = 0
                                .Fields("RetencionIBrutos1").Value = 0
                                .Fields("PorcentajeIBrutos1").Value = 0
                                .Fields("RetencionIBrutos2").Value = 0
                                .Fields("PorcentajeIBrutos2").Value = 0
                                .Fields("ConvenioMultilateral").Value = 0
                                .Fields("PorcentajeIva1").Value = mvarP_IVA1
                                .Fields("PorcentajeIva2").Value = 0
                                .Fields("IdCodigoIva").Value = mIdCodigoIva
                                .Fields("CtaCte").Value = "NO"
                                .Fields("IdMoneda").Value = 1
                                .Fields("CotizacionMoneda").Value = 1
                                .Fields("CotizacionDolar").Value = mvarCotizacion
                                .Fields("OtrasPercepciones1").Value = 0
                                .Fields("OtrasPercepciones1Desc").Value = ""
                                .Fields("OtrasPercepciones2").Value = 0
                                .Fields("OtrasPercepciones2Desc").Value = ""
                                .Fields("OtrasPercepciones3").Value = 0
                                .Fields("OtrasPercepciones3Desc").Value = ""
                                .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                                .Fields("FechaIngreso").Value = Now
                                .Fields("AplicarEnCtaCte").Value = "SI"
                                .Fields("NoIncluirEnCubos").Value = Null
                                .Fields("Observaciones").Value = "Automatica"
                                .Fields("PercepcionIVA").Value = 0
                                .Fields("PorcentajePercepcionIVA").Value = 0
                                .Fields("NumeroCAI").Value = 0
                                .Fields("FechaVencimientoCAI").Value = DateSerial(2000, 1, 1)
                            End With

                            With .DetNotasDebito.Item(-1)
                                With .Registro
                                    .Fields("IdConcepto").Value = mIdConcepto
                                    .Fields("Importe").Value = mImporte
                                    .Fields("Gravado").Value = "NO"
                                    .Fields("IvaNoDiscriminado").Value = 0
                                End With

                                .Modificado = True
                            End With

                            .Guardar
                        End With

                        Set oDeb = Nothing
                        '                  With oPto
                        '                     .Registro.Fields("ProximoNumero").Value = mvarNumero + 1
                        '                     .Guardar
                        '                  End With
                        '                  Set oPto = Nothing
                    End If

                    oRs.Close
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

    Set oRs = Nothing
    Set oRsAux = Nothing
    Set oAp = Nothing
    Set oEx = Nothing

    If Len(mError) > 0 Then
        MsgBox "El proceso reporto los siguientes errores : " & mError, vbExclamation
    End If
   
    Exit Sub
   
Mal:

    Select Case Err.Number

        Case Else
            MsgBox "Se ha producido un error al procesar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
    End Select

    Resume Salida

End Sub

Public Sub SetearIdioma(Optional ByVal IdiomaInicial As String, _
                        Optional ByVal CodCtrl As String)

    Dim mAux

    If IdiomaInicial = "" Then IdiomaInicial = "esp"
    mAux = TraerValorParametro2("Lenguaje")
    glbIdiomaActual = IIf(IsNull(mAux), "esp", mAux)
    CambiarLenguaje Me, IdiomaInicial, glbIdiomaActual, CodCtrl

End Sub

Public Sub ElegirIdioma()

    Dim oF As frm_Aux
    Dim mOk As Boolean
    Dim oEmp As ComPronto.Empleado
    Dim mIndex As Integer
    Dim mAux1 As String
   
    Set oEmp = Aplicacion.Empleados.Item(glbIdUsuario)
    mAux1 = IIf(IsNull(oEmp.Registro.Fields("Idioma").Value), "", oEmp.Registro.Fields("Idioma").Value)

    Set oF = New frm_Aux

    With oF
        .Caption = "Idioma"
        .Label1.Caption = "Idioma :"
        .text1.Visible = False

        With .Combo1(1)
            .top = oF.text1.top
            .left = oF.text1.left
            .Width = oF.text1.Width
            .Visible = True

            Select Case mAux1

                Case "esp"
                    .ListIndex = 0

                Case "ing"
                    .ListIndex = 1

                Case "por"
                    .ListIndex = 2
            End Select

        End With

        .Show vbModal, Me
        mOk = .Ok
        mIndex = .Combo1(1).ListIndex
    End With

    Unload oF
    Set oF = Nothing
   
    If Not mOk Then GoTo Salida
   
    mAux1 = ""

    Select Case mIndex

        Case 0
            mAux1 = "esp"

        Case 1
            mAux1 = "ing"

        Case 2
            mAux1 = "por"
    End Select
   
    CambiarLenguaje Me, glbIdiomaActual, mAux1, ""
   
    glbIdiomaActual = mAux1
   
    oEmp.Registro.Fields("Idioma").Value = mAux1
    oEmp.Guardar
Salida:
    Set oEmp = Nothing

End Sub

'////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////
'Scripts

Private Sub mnuScriptReset_Click()

    If InputBox("Ingrese contraseña de confirmación:") = "CLAVE" Then
        'Shell "osql -U sa -P -d " & glbEmpresaSegunString & " -i scripts\EntidadesSimples.Sql"
        'Shell "osql -U sa -P -d " & glbEmpresaSegunString & " -i scripts\OPyFicha.Sql"
        'Shell "osql -U sa -P -d " & glbEmpresaSegunString & " -i scripts\reset.sql"
        Shell "makescript.cmd"
        'wait
        MsgBox "Script SQL generado"
        Shell "osql -U sa -P -d " & glbEmpresaSegunString & " -i scripts\todo.sql -S FONDO"
        'Eso funciona en mi laboratorio, pero en bdl:
        '   la empresa no tiene el nombre de la base (usan MARIANO)
        '   el servidor es WIN2003
        '   la pass es OK
        
        MsgBox "Script SQL Ejecutado"
        SuperScript
        MsgBox "Script Objetos Ejecutado"
    Else
        MsgBox "La contraseña es incorrecta"
    End If

End Sub

Private Sub mnuScript_Click()

    If InputBox("Ingrese contraseña de confirmación:") = "CLAVE" Then
        SuperScript
    Else
        MsgBox "La contraseña es incorrecta"
        Exit Sub
    End If

End Sub

Sub InicializaConstantesDeScripts()
    On Error Resume Next
    Dim rs As ADOR.Recordset
    
    Set rs = Aplicacion.Clientes.TraerFiltrado("_Busca", "Cliente 2")
    KID_Cliente2 = rs!IdCliente
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Algodon manuar 17mic G572 NEGRO 38mm (FTALGM)")
    KID_MaterialAlgodonManuar = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Rayon viscosa brillante 15mic G572 NEGRO 38mm")
    KID_MaterialRayonViscosa = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Semielaborado Algodon manuar")
    KID_SemiAlgodonManuar = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Semielaborado Rayon viscosa brillante")
    KID_SemiRayonViscosa = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Terminado Base Cashmere Season")
    KID_TerminadoBaseCashmere = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Terminado Light Season")
    KID_TerminadoLightSeason = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "SLIG115A002V")
    KID_SemiRayonViscosa = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Semielaborado Rayon viscosa brillante")
    KID_SemiRayonViscosa = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Semielaborado Rayon viscosa brillante")
    KID_SemiRayonViscosa = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Semielaborado Rayon viscosa brillante")
    KID_SemiRayonViscosa = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Semielaborado Rayon viscosa brillante")
    KID_SemiRayonViscosa = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Semielaborado Rayon viscosa brillante")
    KID_SemiRayonViscosa = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Semielaborado Rayon viscosa brillante")
    KID_SemiRayonViscosa = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Semielaborado Rayon viscosa brillante")
    KID_SemiRayonViscosa = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Semielaborado Rayon viscosa brillante")
    KID_SemiRayonViscosa = rs!IdArticulo
    
    Dim KID_SemielaboradoLIG115A002V As Long
    Dim KID_MatPrima_2083_FibraCorderoCruda As Long
    Dim KID_MatPrima_2083_Pelo2daNacional As Long
    Dim KID_MatPrima_2083_PeloFlandes As Long
    Dim KID_MatPrima_2083_FibraPoliamida As Long
   
    Dim KID_TerminadoPRUEBACashmereSeason815 As Long
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Ensimajes - Agua")
    KID_EnsimajeAgua = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Ensimajes - Bio 999 Autex para lanas")
    KID_EnsimajeBio999Auxtex = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Borra")
    KID_DeshechoBorra = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "Hilacha")
    KID_DeshechoHilacha = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "CARDA 1")
    IDMAQ_CARDA = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "MEZCLADORA 1")
    IDMAQ_MEZCLADORA = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "ENCONADORA 1")
    IDMAQ_ENCONADORA = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "CONTINUA 1")
    IDMAQ_CONTINUA = rs!IdArticulo

    '////////////////////////////////////////////////
    '////////////////////////////////////////////////
    Set rs = AplicacionProd.Procesos.TraerTodos
    rs.Filter = "DESCRIPCION='Mezclado'"
    ID_PROC_MEZCLADO = rs!IdProduccionProceso
    rs.Filter = "DESCRIPCION='Retorcido'"
    ID_PROC_RETORCIDO = rs!IdProduccionProceso
    rs.Filter = "DESCRIPCION='Continua'"
    ID_PROC_CONTINUA = rs!IdProduccionProceso
    rs.Filter = "DESCRIPCION='Cardado'"
    ID_PROC_ENCARDADO = rs!IdProduccionProceso
    '////////////////////////////////////////////////
    '////////////////////////////////////////////////
   
    '//////////////////////////////////////////////////////////////////
    'MAQUINAS
    '//////////////////////////////////////////////////////////////////
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "CARDA 1")
    IDMAQ_CARDA = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "MEZCLADORA 1")
    IDMAQ_MEZCLADORA = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "ENCONADORA 1")
    IDMAQ_ENCONADORA = rs!IdArticulo
    
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", "CONTINUA 1")
    IDMAQ_CONTINUA = rs!IdArticulo
    
    Set rs = AplicacionProd.Lineas.TraerTodos
    rs.Filter = ""
    rs.MoveFirst
    IDLINEA1 = rs!IdProduccionLinea
   
    Set rs = Aplicacion.Unidades.TraerTodos
    rs.Filter = "DESCRIPCION='Kilogramos'"
    K_UN1 = rs!IdUnidad
    rs.Filter = "DESCRIPCION='Horas'"
    K_UNIHORAS = rs!IdUnidad
    rs.Filter = "DESCRIPCION='Días'"
    K_UNISEMANA = rs!IdUnidad
    rs.Filter = "DESCRIPCION='Litros'"
    K_UNILITROS = rs!IdUnidad
   
    Set rs = Aplicacion.Empleados.TraerTodos
    ID_EMPLEADO1 = rs!IdEmpleado 'estoy agarrando el primero. sería bueno elegir uno con permisos
    rs.MoveNext
    ID_EMPLEADO2 = rs!IdEmpleado
    
    Set rs = Aplicacion.Colores.TraerTodos
    rs.Filter = "COLOR='ALUMINIO'"
    KID_ColorAluminio = rs!IdColor

    '/////////////////////////
    '    Set rs = Aplicacion.TablasGenerales.TraerFiltrado("ConsultaStockCompleto", "1") 'este pinta que tarda bocha
    '
    '    rs.Filter = "IdArticulo=" & KID_SemiAlgodonManuar
    '    KIDStock_SemiAlgodonManuar = rs!IdStock
    '    rs.Filter = "IdArticulo=" & KID_SemiRayonViscosa
    '    KIDStock_SemiRayonViscosa = rs!IdStock
    '    rs.Filter = "IdArticulo=" & KID_MaterialAlgodonManuar
    '    KIDStock_MaterialAlgodonManuar = rs!IdStock
    '    rs.Filter = "IdArticulo=" & KID_MaterialRayonViscosa
    '    KIDStock_MaterialRayonViscosa = rs!IdStock
    
    Set rs = Nothing

End Sub

Sub SuperScript()
    'Script para usar en el testing, que prueba directamente la capa de negocios
    Dim mN
    Dim oPar As ComPronto.Parametro
    
    Dim Orden As ComPronto.ProduccionOrden
    Dim DetProduccionOrden As DetProduccionOrden
    Dim DetProduccionOrdenProceso As DetProdOrdenProceso
    
    Dim ficha As ComPronto.ProduccionFicha
    Dim DetProduccionFicha As DetProduccionFicha
    Dim DetProduccionFichaProceso As DetProdFichaProceso

    Dim PP As ComPronto.ProduccionParte
    Dim TipoCC As ControlCalidadTipo
    
    Dim OC As ComPronto.OrdenCompra
    Dim DetOC As ComPronto.DetOrdenCompra

    Dim oI As ComPronto.OtroIngresoAlmacen
    Dim DetOI As ComPronto.DetOtroIngresoAlmacen
    
    Dim RM As ComPronto.Requerimiento
    Dim DetRM As ComPronto.DetRequerimiento
    
    Dim NP As ComPronto.Pedido
    Dim DetNP As ComPronto.DetPedido
    
    Dim rs As ADOR.Recordset
    
    'prefijar con _PRUEBA?
    
    'Const K_ART1 = 210
    'Const K_ART2 = 211
    
    Me.MousePointer = vbHourglass

    InicializaConstantesDeScripts
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'TO DO:
    '------
    
    'Tenés que hacer un caso complejo que funcione bien:
    'Por ejemplo, una OP de un hilo final, que necesite 2 OPs.
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'RESUMEN:
    '--------
    
    'Creo una FICHA (Ficha Tecnica) de 2 Semielaborado
    'Creo una FICHA (Ficha Tecnica) de un Terminado que incluya esos semielaborados y otras cosas
    
    'Creo una OP (Orden de Produccion) a partir de la ficha del terminado
    
    'Dependiendo del item, se crea:
    '        o un RM (requerimiento de materiales) a "CHURRUCA" (el deposito frente a la fabrica)
    '        o una OP del semielaborado en cuestion si es que no hay stock
    
    '(Opcional si no hay stock) Se hace una OC (orden de compra) y luego cuando
    '        se recibe se hace un REMITO. -Una OC o un NOTA DE PEDIDO?
    
    'Se crea un VALE para ir a deposito
    'Se crea una SALIDA DE MATERIALES de "CHURRUCA" a "FABRICA"
    
    'IMPORTANTE: Cuando se termina la OP, tengo que crear un
    '            comprobante OTROSINGRESOS para el producto creado. Verificar CARDEX
    '            -y cómo borro los materiales usados? -Lo que podés hacer es que
    '            cada proceso tenga su deposito, al que se mueven las cosas al
    '            hacer el PP (parte de prod).
    
    'Creo una OP a partir de una OC
    'Edito la FICHA
    'Edito la OP
    'Incluir una OP dentro de otra OP
    'Controlar el stock
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Dim tipo As ComPronto.tipo
    
    Set tipo = Aplicacion.Tipos.Item(-1)

    With tipo
        With .Registro
            !descripcion = "Insumo"
            !Abreviatura = "IN"
            !Codigo = "31"
            !Grupo = 2
        End With

        .Guardar
    End With

    Set tipo = Nothing
    
    Set tipo = Aplicacion.Tipos.Item(-1)

    With tipo
        With .Registro
            !descripcion = "Semielaborado"
            !Abreviatura = "SE"
            !Codigo = "32"
            !Grupo = 2
        End With

        .Guardar
    End With

    Set tipo = Nothing

    Set tipo = Aplicacion.Tipos.Item(-1)

    With tipo
        With .Registro
            !descripcion = "Terminado"
            !Abreviatura = "TE"
            !Codigo = "33"
            !Grupo = 2
        End With

        .Guardar
    End With

    Set tipo = Nothing
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    'MAQUINA
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    
    Dim Maquina As Maquina
    Dim IdMaquina As Integer
    '//////////////////////////////////////////////////////////////////////
    'alta
    
    Set rs = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorDescripcionTipoParaCombo", Array(0, "Equipo"))
    While Not rs.EOF
        
        Set Maquina = AplicacionProd.Maquinas.Item(-1)

        With Maquina
            With .Registro
                !IdArticulo = rs!IdArticulo
                
                !ParoFrecuencia = 2
                !ParoIdUnidad = K_UNISEMANA
                !ParoConcepto = "Enfriamiento"
                
                !FueraDeServicio = "SI"
                !FueraDeServicioConcepto = "Reparación"
                !FueraDeServicioFechaInicio = Date + 3
                !FueraDeServicioRetornoEstimado = Date + 20
                !FueraDeServicioRetornoEfectivo = Date + 30
                
                !TiempoArranque = 0.8
                !TiempoApagado = 0.5
                !IdUnidadTiempo = K_UNIHORAS
                
                !CapacidadMinima = 200
                !CapacidadNormal = 300
                !CapacidadMaxima = 450
                !IdUnidadCapacidad = K_UNILITROS
                
                Select Case rs!IdArticulo

                    Case IDMAQ_CARDA
                        !IdProduccionProceso = ID_PROC_ENCARDADO

                    Case IDMAQ_MEZCLADORA
                        !IdProduccionProceso = ID_PROC_MEZCLADO

                    Case IDMAQ_CONTINUA
                        !IdProduccionProceso = ID_PROC_CONTINUA

                    Case Else
                End Select
                
                !IdProduccionLinea = IDLINEA1
                !lineaorden = 3
           
            End With
        
            .Guardar
            IdMaquina = .Registro.Fields("IdPROD_Maquina")
        End With

        Set Maquina = Nothing
        
        rs.MoveNext
    Wend
    
    Set rs = Nothing
    
    '//////////////////////////////////////////////////////////////////
    'edicion
    Set Maquina = AplicacionProd.Maquinas.Item(IdMaquina)

    With Maquina
        With .Registro

        End With
    
        .Guardar
    End With

    Set Maquina = Nothing
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////

    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'Creacion de Ficha Tecnica
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set oPar = Aplicacion.Parametros.Item(1)

    With oPar.Registro
        'mN = .Fields("").Value
        '.Fields("").Value = mN + 1
    End With

    oPar.Guardar
    
    Set ficha = AplicacionProd.ProduccionFichas.Item(-1)

    With ficha.Registro
        !Codigo = "02OAS"
        !descripcion = "Base Cashmere Season 1/28 2472 NEGRO"
        !Cantidad = 500
        !IdArticuloAsociado = KID_SemiAlgodonManuar
        !IdUnidad = K_UN1
        !Minimo = 10
    End With
    
    Set DetProduccionFicha = ficha.DetProduccionFichas.Item(-1)

    With DetProduccionFicha.Registro
        !IdArticulo = KID_MaterialAlgodonManuar
        !Cantidad = 300
        !IdUnidad = K_UN1
        
    End With

    DetProduccionFicha.Modificado = True
    
    Set DetProduccionFicha = ficha.DetProduccionFichas.Item(-1)

    With DetProduccionFicha.Registro
        !IdArticulo = KID_SemiRayonViscosa
        !Cantidad = 240
        !IdUnidad = K_UN1
        
    End With

    DetProduccionFicha.Modificado = True
    
    Set DetProduccionFicha = ficha.DetProduccionFichas.Item(-1)

    With DetProduccionFicha.Registro
        !IdArticulo = KID_MaterialRayonViscosa
        !Cantidad = 410.5
        !IdUnidad = K_UN1
        !Tolerancia = 0.1
    End With

    DetProduccionFicha.Modificado = True
        
    Set DetProduccionFichaProceso = ficha.DetProduccionFichasProcesos.Item(-1)

    With DetProduccionFichaProceso.Registro
        !IdProduccionProceso = ID_PROC_MEZCLADO
        !Horas = 15
    End With

    DetProduccionFichaProceso.Modificado = True
    
    Set DetProduccionFichaProceso = ficha.DetProduccionFichasProcesos.Item(-1)

    With DetProduccionFichaProceso.Registro
        !IdProduccionProceso = ID_PROC_ENCARDADO
        !Horas = 9
    End With

    DetProduccionFichaProceso.Modificado = True
    
    ficha.Guardar
    IDFICHA1 = ficha.Registro.Fields("IdProduccionFicha")
    Set ficha = Nothing
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'Creacion de Ficha Tecnica 2
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set ficha = AplicacionProd.ProduccionFichas.Item(-1)

    With ficha.Registro
        !Cantidad = 300
        !IdArticuloAsociado = KID_TerminadoBaseCashmere
        !IdUnidad = K_UN1
        !Minimo = 10
    End With
    
    Set DetProduccionFicha = ficha.DetProduccionFichas.Item(-1)

    With DetProduccionFicha.Registro
        !IdArticulo = KID_MaterialAlgodonManuar
        !Cantidad = 250
        !IdUnidad = K_UN1
        
    End With

    DetProduccionFicha.Modificado = True
        
    Set DetProduccionFicha = ficha.DetProduccionFichas.Item(-1)

    With DetProduccionFicha.Registro
        !IdArticulo = KID_EnsimajeAgua
        !Cantidad = 59.9
        !IdUnidad = K_UN1
        !Tolerancia = 0.1
    End With

    DetProduccionFicha.Modificado = True
        
    Set DetProduccionFicha = ficha.DetProduccionFichas.Item(-1)

    With DetProduccionFicha.Registro
        !IdArticulo = KID_EnsimajeBio999Auxtex
        !Cantidad = 80
        !IdUnidad = K_UN1
        !Tolerancia = 0.1
    End With

    DetProduccionFicha.Modificado = True
        
    Set DetProduccionFicha = ficha.DetProduccionFichas.Item(-1)

    With DetProduccionFicha.Registro
        !IdArticulo = KID_SemiRayonViscosa
        !Cantidad = 303.48
        !IdUnidad = K_UN1
        !Tolerancia = 0.1
    End With

    DetProduccionFicha.Modificado = True
        
    Set DetProduccionFichaProceso = ficha.DetProduccionFichasProcesos.Item(-1)

    With DetProduccionFichaProceso.Registro
        !IdProduccionProceso = ID_PROC_MEZCLADO
        !Horas = 15
        '!IdMaquina = 5
    End With

    DetProduccionFichaProceso.Modificado = True
    
    Set DetProduccionFichaProceso = ficha.DetProduccionFichasProcesos.Item(-1)

    With DetProduccionFichaProceso.Registro
        !IdProduccionProceso = ID_PROC_ENCARDADO
        !Horas = 9
    End With

    DetProduccionFichaProceso.Modificado = True
    
    ficha.Guardar
    IDFICHA1 = ficha.Registro.Fields("IdProduccionFicha")
    Set ficha = Nothing
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////

    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '////////////          BUCLE                 //////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
 
    Dim n As Long

    For n = 1 To 1
    
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        'Creo algo de stock con OtrosIngresos
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        Set oPar = Aplicacion.Parametros.Item(1)

        With oPar.Registro
            mN = .Fields("ProximoNumeroOtroIngresoAlmacen").Value
            .Fields("ProximoNumeroOtroIngresoAlmacen").Value = mN + 1
        End With
    
        Set oI = Aplicacion.OtrosIngresosAlmacen.Item(-1)

        With oI.Registro
            !NumeroOtroIngresoAlmacen = mN
            '!Cliente = Registro!Cliente
            !FechaOtroIngresoAlmacen = Date
            '!IdColor = 33
            !TipoIngreso = 1
            !IdObra = 1
            !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        End With

        Set DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)

        With DetOI.Registro
            !IdArticulo = KID_MaterialAlgodonManuar
            !Cantidad = 100
            !IdUnidad = K_UN1
            !partida = "5646"
            !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        End With

        DetOI.Modificado = True

        Set DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)

        With DetOI.Registro
            !IdArticulo = KID_MaterialRayonViscosa
            !Cantidad = 200
            !IdUnidad = K_UN1
            !partida = "23GGG431"
            !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        End With

        DetOI.Modificado = True
    
        Set DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)

        With DetOI.Registro
            !IdArticulo = KID_SemiAlgodonManuar
            !Cantidad = 50
            !IdUnidad = K_UN1
            !partida = "AP59999"
            !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        End With

        DetOI.Modificado = True

        Set DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)

        With DetOI.Registro
            !IdArticulo = KID_SemiRayonViscosa
            !Cantidad = 80
            !IdUnidad = K_UN1
            !partida = "XRT4011"
            !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        End With

        DetOI.Modificado = True
    
        oI.Guardar
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Creacion de OC
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
    
        Set oPar = Aplicacion.Parametros.Item(1)

        With oPar.Registro
            mN = .Fields("ProximoNumeroOrdenCompra").Value
            .Fields("ProximoNumeroOrdenCompra").Value = mN + 1
        End With

        oPar.Guardar
    
        Set OC = Aplicacion.OrdenesCompra.Item(-1)

        With OC.Registro
            !NumeroOrdenCompra = mN
            !IdCliente = KID_Cliente2
            !FechaOrdenCompra = Date - 2
            !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
            '!IdColor = 33
        End With

        Set DetOC = OC.DetOrdenesCompra.Item(-1)

        With DetOC.Registro
            !FechaNecesidad = Date + 5
            !IdArticulo = KID_TerminadoBaseCashmere
            !Cantidad = 1500
            !IdUnidad = K_UN1
        End With

        DetOC.Modificado = True
    
        Set DetOC = OC.DetOrdenesCompra.Item(-1)

        With DetOC.Registro
            !FechaNecesidad = Date + 2
            !IdArticulo = KID_TerminadoLightSeason
            !Cantidad = 700
            !IdUnidad = K_UN1
        End With

        DetOC.Modificado = True
    
        Set DetOC = OC.DetOrdenesCompra.Item(-1)

        With DetOC.Registro
            !IdArticulo = KID_MaterialRayonViscosa
            !Cantidad = 900
            !IdUnidad = K_UN1
        End With

        DetOC.Modificado = True
    
        OC.Guardar
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Creacion de OP
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'crear ops que tengan estos estados:
        '        Nueva (cuando la OP está cargada pero aún no Liberada –una OP en este estado no puede recibir Partes de Producción-).
        '        Abierta (cuando la OP está cargada y liberada, pero aún no está Programada –no entró en Programación de Recursos-; esta OP sí puede recibir Partes de Producción).
        '        Programada (cuando la OP ya está en un Programa de Recursos aceptado, esta OP sí recibe Partes de Producción).
        '        En Ejecución (cuando la OP recibe su primer “Parte de Producción”).
        '        Cerrada (cuando desde el formulario de la OP se cierra específicamente –a partir de este momento la OP no recibe más Partes de Prod.).-
        '//////////////////////////////////////////////////////////////////
    
        mN = TraerValorParametro2("ProximoNumeroProduccionOrden")
        GuardarValorParametro2 "ProximoNumeroProduccionOrden", "" & (mN + 1)
    
        Set Orden = AplicacionProd.ProduccionOrdenes.Item(-1)

        With Orden.Registro
            '!Codigo = "02OAS"
            '!Descripcion = "Base Cashmere Season 1/28 2472 NEGRO"
            !NumeroOrdenProduccion = mN
        
            !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
            !idArticuloGenerado = KID_SemiAlgodonManuar
            '!IdStockGenerado = 2121
            !IdColor = 10
        
            !fechaOrdenProduccion = Date - 205
            !FechaIngreso = Date - 205
        
            !Cantidad = 810
            !IdUnidad = K_UN1
        
            !FechaInicioPrevista = Date + 2
            !FechaFinalPrevista = Date + 5
            '!FechaInicioReal = #1/1/2000#
            '!FechaFinalReal = #2/1/2000#
        
            !Emitio = ID_EMPLEADO1
            !Aprobo = ID_EMPLEADO2
            !Programada = "NO"
            !Confirmado = "SI"
            !Reserva = "SI"
            !EnEjecucion = "SI"
            !Cerro = ID_EMPLEADO2
            !Anulada = "SI"
        End With
    
        Set DetProduccionOrden = Orden.DetProduccionOrdenes.Item(-1)

        With DetProduccionOrden.Registro
            !IdArticulo = KID_MaterialAlgodonManuar
            '!IdStock =
            !partida = "np5440"
            !Cantidad = 300
            !Porcentaje = 30
            !IdUnidad = K_UN1
        End With

        DetProduccionOrden.Modificado = True
        
        Set DetProduccionOrden = Orden.DetProduccionOrdenes.Item(-1)

        With DetProduccionOrden.Registro
            !IdArticulo = KID_MaterialRayonViscosa
            '!IdStock =
            !IdProduccionProceso = ID_PROC_MEZCLADO
            !partida = "bb97"
            !Cantidad = 200
            !IdUnidad = K_UN1
        End With

        DetProduccionOrden.Modificado = True
        
        Set DetProduccionOrden = Orden.DetProduccionOrdenes.Item(-1)

        With DetProduccionOrden.Registro
            !IdArticulo = KID_EnsimajeAgua
            '!IdStock =
            !IdProduccionProceso = ID_PROC_CONTINUA
            !partida = "bb97"
            !Cantidad = 100
            !IdUnidad = K_UN1
        End With

        DetProduccionOrden.Modificado = True
        
        Set DetProduccionOrden = Orden.DetProduccionOrdenes.Item(-1)

        With DetProduccionOrden.Registro
            !IdArticulo = KID_DeshechoBorra
            '!IdStock =
            !IdProduccionProceso = ID_PROC_RETORCIDO
            !partida = "bb97"
            !Cantidad = 150
            !IdUnidad = K_UN1
        End With

        DetProduccionOrden.Modificado = True
        
        Set DetProduccionOrdenProceso = Orden.DetProduccionOrdenesProcesos.Item(-1)

        With DetProduccionOrdenProceso.Registro
            !IdProduccionProceso = ID_PROC_ENCARDADO
            !FechaInicio = Date + 1
            !fechafinal = Date + 3
            !Horas = 15
            !IdMaquina = IDMAQ_CARDA
        End With

        DetProduccionOrdenProceso.Modificado = True
    
        Set DetProduccionOrdenProceso = Orden.DetProduccionOrdenesProcesos.Item(-1)

        With DetProduccionOrdenProceso.Registro
            !FechaInicio = Date + 5
            !fechafinal = Date + 7
            !IdProduccionProceso = ID_PROC_MEZCLADO
            !Horas = 9
            !IdMaquina = IDMAQ_MEZCLADORA
        End With

        DetProduccionOrdenProceso.Modificado = True
        
        Orden.Guardar
    
        IDORDEN1 = Orden.Registro.Fields("IdProduccionOrden")
        'KID_SemiAlgodonManuar = Orden.Registro.Fields("IdArticuloGenerado")
    
        Set Orden = Nothing
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Creacion de OP
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'crear ops que tengan estos estados:
        '        Nueva (cuando la OP está cargada pero aún no Liberada –una OP en este estado no puede recibir Partes de Producción-).
        '        Abierta (cuando la OP está cargada y liberada, pero aún no está Programada –no entró en Programación de Recursos-; esta OP sí puede recibir Partes de Producción).
        '        Programada (cuando la OP ya está en un Programa de Recursos aceptado, esta OP sí recibe Partes de Producción).
        '        En Ejecución (cuando la OP recibe su primer “Parte de Producción”).
        '        Cerrada (cuando desde el formulario de la OP se cierra específicamente –a partir de este momento la OP no recibe más Partes de Prod.).-
        '//////////////////////////////////////////////////////////////////
    
        mN = TraerValorParametro2("ProximoNumeroProduccionOrden")
        GuardarValorParametro2 "ProximoNumeroProduccionOrden", "" & (mN + 1)
    
        Set Orden = AplicacionProd.ProduccionOrdenes.Item(-1)

        With Orden.Registro
            '!Codigo = "02OAS"
            '!Descripcion = "Base Cashmere Season 1/28 2472 NEGRO"
            !NumeroOrdenProduccion = mN
            !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        
            !idArticuloGenerado = KID_SemiAlgodonManuar
            '!IdStockGenerado = 2121
            !IdColor = 10
        
            !fechaOrdenProduccion = Date - 35
            !FechaIngreso = Date - 35
        
            !Cantidad = 1300
            !IdUnidad = K_UN1
        
            !FechaInicioPrevista = Date - 20
            !FechaFinalPrevista = Date - 22
            '!FechaInicioReal = #1/1/2000#
            '!FechaFinalReal = #2/1/2000#
        
            !Emitio = ID_EMPLEADO1
            !Aprobo = ID_EMPLEADO2
            !Programada = "SI"
            !Confirmado = "SI"
            !Reserva = "SI"
            !EnEjecucion = "SI"
            !Cerro = ID_EMPLEADO2
        
        End With
    
        Set DetProduccionOrden = Orden.DetProduccionOrdenes.Item(-1)

        With DetProduccionOrden.Registro
            !IdArticulo = KID_MaterialAlgodonManuar
            '!IdStock =
            !partida = "np5440"
            !Cantidad = 300
            !Porcentaje = 30
            !IdUnidad = K_UN1
        End With

        DetProduccionOrden.Modificado = True
        
        Set DetProduccionOrden = Orden.DetProduccionOrdenes.Item(-1)

        With DetProduccionOrden.Registro
            !IdArticulo = KID_MaterialRayonViscosa
            '!IdStock =
            !IdProduccionProceso = ID_PROC_MEZCLADO
            !partida = "bb97"
            !Cantidad = 200
            !IdUnidad = K_UN1
        End With

        DetProduccionOrden.Modificado = True
        
        Set DetProduccionOrden = Orden.DetProduccionOrdenes.Item(-1)

        With DetProduccionOrden.Registro
            !IdArticulo = KID_EnsimajeAgua
            '!IdStock =
            !IdProduccionProceso = ID_PROC_ENCARDADO
            !partida = "bb97"
            !Cantidad = 100
            !IdUnidad = K_UN1
        End With

        DetProduccionOrden.Modificado = True
        
        Set DetProduccionOrden = Orden.DetProduccionOrdenes.Item(-1)

        With DetProduccionOrden.Registro
            !IdArticulo = KID_DeshechoBorra
            '!IdStock =
            !IdProduccionProceso = ID_PROC_CONTINUA
            !partida = "bb97"
            !Cantidad = 150
            !IdUnidad = K_UN1
        End With

        DetProduccionOrden.Modificado = True
        
        Set DetProduccionOrdenProceso = Orden.DetProduccionOrdenesProcesos.Item(-1)

        With DetProduccionOrdenProceso.Registro
            !IdProduccionProceso = ID_PROC_MEZCLADO
            !FechaInicio = Date + 11
            !fechafinal = Date + 13
            !Horas = 30
            !IdMaquina = IDMAQ_MEZCLADORA
        End With

        DetProduccionOrdenProceso.Modificado = True
    
        Set DetProduccionOrdenProceso = Orden.DetProduccionOrdenesProcesos.Item(-1)

        With DetProduccionOrdenProceso.Registro
            !FechaInicio = Date + 5
            !fechafinal = Date + 7
            !IdProduccionProceso = ID_PROC_ENCARDADO
            !Horas = 4
            !IdMaquina = IDMAQ_CARDA
        End With

        DetProduccionOrdenProceso.Modificado = True
        
        Orden.Guardar
    
        IDORDEN1 = Orden.Registro.Fields("IdProduccionOrden")
        'KID_SemiAlgodonManuar = Orden.Registro.Fields("IdArticuloGenerado")
    
        Set Orden = Nothing
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Creacion de Orden que incluye la primera
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
    
        mN = TraerValorParametro2("ProximoNumeroProduccionOrden")
        GuardarValorParametro2 "ProximoNumeroProduccionOrden", "" & (mN + 1)
    
        Set Orden = AplicacionProd.ProduccionOrdenes.Item(-1)

        With Orden.Registro
            '!Codigo = "02OAS"
            !idArticuloGenerado = KID_TerminadoBaseCashmere
            '!Descripcion = "Base Cashmere Season 1/28 2472 NEGRO"
            !NumeroOrdenProduccion = mN
            !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        
            !IdColor = 2121
        
            !fechaOrdenProduccion = Date
            !FechaIngreso = Date
        
            !Cantidad = 500
            !IdUnidad = K_UN1
        
            !IdColor = 9
            !FechaInicioPrevista = Date + 5
            !FechaFinalPrevista = Date + 10
            !FechaInicioReal = Date + 2
            !FechaFinalReal = Date + 2
        
            !Emitio = ID_EMPLEADO1
            '!Aprobo=
            !Programada = "NO"
            !Confirmado = "NO"
            !Reserva = "NO"
            !EnEjecucion = "NO"
            '!Cerro1=
        
        End With
        
        Set DetProduccionOrden = Orden.DetProduccionOrdenes.Item(-1)

        With DetProduccionOrden.Registro
            !IdArticulo = KID_SemiAlgodonManuar
            '!IdStock =
            !partida = "np5440"
            !Cantidad = 380
            !Porcentaje = 30
            !IdUnidad = K_UN1
        End With

        DetProduccionOrden.Modificado = True
            
        Set DetProduccionOrden = Orden.DetProduccionOrdenes.Item(-1)

        With DetProduccionOrden.Registro
            !IdArticulo = KID_MaterialRayonViscosa
            '!IdStock =
            !partida = "bb97"
            !Cantidad = 170
            !IdUnidad = K_UN1
        End With

        DetProduccionOrden.Modificado = True
        
        Set DetProduccionOrdenProceso = Orden.DetProduccionOrdenesProcesos.Item(-1)

        With DetProduccionOrdenProceso.Registro
            !FechaInicio = Date + 8
            !fechafinal = Date + 9
            !IdProduccionProceso = ID_PROC_ENCARDADO
            !Horas = 15
            !IdMaquina = IDMAQ_CARDA
        End With

        DetProduccionOrdenProceso.Modificado = True
    
        Set DetProduccionOrdenProceso = Orden.DetProduccionOrdenesProcesos.Item(-1)

        With DetProduccionOrdenProceso.Registro
            !FechaInicio = Date + 8
            !fechafinal = Date + 13
            !IdProduccionProceso = ID_PROC_RETORCIDO
            !Horas = 9
            '!IdMaquina =
        End With

        DetProduccionOrdenProceso.Modificado = True
        
        Orden.Guardar
        IDORDEN2 = Orden.Registro.Fields("IdProduccionOrden")
        Set Orden = Nothing
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Creacion de Orden que incluye la primera
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
    
        mN = TraerValorParametro2("ProximoNumeroProduccionOrden")
        GuardarValorParametro2 "ProximoNumeroProduccionOrden", "" & (mN + 1)
    
        Set Orden = AplicacionProd.ProduccionOrdenes.Item(-1)

        With Orden.Registro
            '!Codigo = "02OAS"
            !idArticuloGenerado = KID_TerminadoBaseCashmere
            '!Descripcion = "Base Cashmere Season 1/28 2472 NEGRO"
            !NumeroOrdenProduccion = mN
            !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        
            !IdColor = 2121
        
            !fechaOrdenProduccion = Date
            !FechaIngreso = Date + 2
        
            !Cantidad = 500
            !IdUnidad = K_UN1
        
            !IdColor = 9
            !FechaInicioPrevista = Date + 2
            !FechaFinalPrevista = Date + 2
            !FechaInicioReal = Date + 2
            !FechaFinalReal = Date + 2
        
            '!Emitio=
            '!Aprobo=
            '!Observaciones=
            'IdDepositoOrigen
        End With
        
        Set DetProduccionOrden = Orden.DetProduccionOrdenes.Item(-1)

        With DetProduccionOrden.Registro
            !IdArticulo = KID_SemiAlgodonManuar
            '!IdStock =
            !partida = "np5440"
            !Cantidad = 3
            !Porcentaje = 90
            !IdUnidad = K_UN1
        End With

        DetProduccionOrden.Modificado = True
            
        Set DetProduccionOrden = Orden.DetProduccionOrdenes.Item(-1)

        With DetProduccionOrden.Registro
            !IdArticulo = KID_MaterialRayonViscosa
            '!IdStock =
            !partida = "bb97"
            !Cantidad = 230
            !IdUnidad = K_UN1
        End With

        DetProduccionOrden.Modificado = True
        
        Set DetProduccionOrdenProceso = Orden.DetProduccionOrdenesProcesos.Item(-1)

        With DetProduccionOrdenProceso.Registro
            !FechaInicio = Date + 1
            !fechafinal = Date + 2
            !IdProduccionProceso = ID_PROC_MEZCLADO
            !Horas = 15
            !IdMaquina = IDMAQ_MEZCLADORA
        End With

        DetProduccionOrdenProceso.Modificado = True
    
        Set DetProduccionOrdenProceso = Orden.DetProduccionOrdenesProcesos.Item(-1)

        With DetProduccionOrdenProceso.Registro
            !FechaInicio = Date + 11
            !fechafinal = Date + 12
            !IdProduccionProceso = ID_PROC_ENCARDADO
            !Horas = 9
            !IdMaquina = IDMAQ_CARDA
        End With

        DetProduccionOrdenProceso.Modificado = True
        
        Orden.Guardar
        IDORDEN1 = Orden.Registro.Fields("IdProduccionOrden")
        Set Orden = Nothing
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Edicion de Orden
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
    
        Set Orden = AplicacionProd.ProduccionOrdenes.Item(IDORDEN1)

        With Orden.Registro
            !FechaIngreso = Date
            !FechaInicioPrevista = Date + 2
            !FechaFinalPrevista = Date + 2
            !FechaInicioReal = Date + 2
            !FechaFinalReal = Date + 2

            !Cantidad = 520
            !IdUnidad = K_UN1
    
            !Emitio = ID_EMPLEADO1
            !Aprobo = ID_EMPLEADO2
            !Programada = "SI"
            !Confirmado = "SI"
            !Reserva = "SI"
            !EnEjecucion = "SI"
            '!Cerro1=
            !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        End With

        Set rs = Orden.DetProduccionOrdenes.TraerTodos 'ESTA ES LA PAPA DEL DETALLE.
        'ES LO QUE QUIERE DECIR EDU
        'CON ESO DE QUE "ESTAN VIVOS".
        'ES DECIR, QUE EL OBJETO EN LA BASE
        'PUEDE TENER DATOS QUE SOLO SE TRAEN
        'A LA CAPA DE NEGOCIOS SI ES
        'EXPLICITAMENTE.
    
        'edito el primer item
        rs.MoveFirst
        Set DetProduccionOrden = Orden.DetProduccionOrdenes.Item(rs!IdDetalleProduccionOrden)

        With DetProduccionOrden.Registro
            !IdArticulo = KID_MaterialAlgodonManuar
            !IdStock = 2
            !partida = "np5440"
            !Cantidad = 300
            !Porcentaje = 30
            !IdUnidad = K_UN1
        End With

        DetProduccionOrden.Modificado = True

        'edito el segundo item
        rs.MoveNext
        Set DetProduccionOrden = Orden.DetProduccionOrdenes.Item(rs!IdDetalleProduccionOrden)

        With DetProduccionOrden.Registro
            !IdArticulo = KID_MaterialRayonViscosa
            '!IdStock =
            !partida = "bb97"
            !Cantidad = 150
            !IdUnidad = K_UN1
        End With

        DetProduccionOrden.Modificado = True
    
        Set DetProduccionOrdenProceso = Orden.DetProduccionOrdenesProcesos.Item(-1)

        With DetProduccionOrdenProceso.Registro
            !FechaInicio = Date + 2
            !fechafinal = Date + 5
            !IdProduccionProceso = ID_PROC_CONTINUA
            !Horas = 7
            !IdMaquina = IDMAQ_CONTINUA
        End With

        DetProduccionOrdenProceso.Modificado = True

        Set DetProduccionOrdenProceso = Orden.DetProduccionOrdenesProcesos.Item(-1)

        With DetProduccionOrdenProceso.Registro
            !FechaInicio = Date + 2
            !fechafinal = Date + 2
            !IdProduccionProceso = ID_PROC_RETORCIDO
            !Horas = 10
            !HorasReales = 9
            '!IdMaquina = IDMAQ1
        End With

        DetProduccionOrdenProceso.Modificado = True

        Orden.Guardar

        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Creacion de OP partir de otra OP
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Creacion de Pedido
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        Set oPar = Aplicacion.Parametros.Item(1)

        With oPar.Registro
            mN = .Fields("ProximoNumeroPedido").Value
            .Fields("ProximoNumeroPedido").Value = mN + 1
        End With

        oPar.Guardar
    
        Set NP = Aplicacion.Pedidos.Item(-1)

        With NP.Registro
            !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
            !NumeroPedido = mN
            '!IdCliente = 22
        End With

        Set DetNP = NP.DetPedidos.Item(-1)

        With DetNP.Registro
            '!IdColor = 33
            !IdArticulo = KID_TerminadoBaseCashmere
            !Cantidad = 400
            !IdUnidad = K_UN1
            !FechaEntrega = Date + 3
        End With

        DetNP.Modificado = True
    
        Set DetNP = NP.DetPedidos.Item(-1)

        With DetNP.Registro
            '!IdColor = 33
            !IdArticulo = KID_SemiRayonViscosa
            !Cantidad = 250
            !IdUnidad = K_UN1
        End With

        DetNP.Modificado = True
    
        NP.Guardar
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Creacion de OC
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        Set oPar = Aplicacion.Parametros.Item(1)

        With oPar.Registro
            mN = .Fields("ProximoNumeroOrdenCompra").Value
            .Fields("ProximoNumeroOrdenCompra").Value = mN + 1
        End With

        oPar.Guardar

        Set OC = Aplicacion.OrdenesCompra.Item(-1)

        With OC.Registro
            !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
            !NumeroOrdenCompra = mN
            !IdCliente = 22
        End With

        Set DetOC = OC.DetOrdenesCompra.Item(-1)

        With DetOC.Registro
            '!IdColor = 33
            !IdArticulo = KID_SemiAlgodonManuar
            !Cantidad = 3
            !IdUnidad = K_UN1
        End With

        DetOC.Modificado = True
    
        Set DetOC = OC.DetOrdenesCompra.Item(-1)

        With DetOC.Registro
            '!IdColor = 33
            !IdArticulo = KID_SemiRayonViscosa
            !Cantidad = 3
            !IdUnidad = K_UN1
        End With

        DetOC.Modificado = True
    
        OC.Guardar
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Creacion de RM
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
    
        Set oPar = Aplicacion.Parametros.Item(1)

        With oPar.Registro
            mN = .Fields("ProximoNumeroRequerimiento").Value
            .Fields("ProximoNumeroRequerimiento").Value = mN + 1
        End With

        oPar.Guardar
    
        Set RM = Aplicacion.Requerimientos.Item(-1)

        With RM.Registro
            !NumeroRequerimiento = mN
            !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
            '!IdCliente = KID_Cliente2
            '!FechaOrdenCompra = #1/20/2008#
            '!IdColor = 33
        End With

        Set DetRM = RM.DetRequerimientos.Item(-1)

        With DetRM.Registro
            !IdArticulo = KID_TerminadoBaseCashmere
            !Cantidad = 1500
            !IdUnidad = K_UN1
        End With

        DetRM.Modificado = True
    
        Set DetRM = RM.DetRequerimientos.Item(-1)

        With DetRM.Registro
            !IdArticulo = KID_TerminadoLightSeason
            !Cantidad = 700
            !IdUnidad = K_UN1
        End With

        DetRM.Modificado = True

        RM.Guardar
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Creacion de OP partir de OC (no debería usar una NotaPedido?
        ' No es la OC la confirmacion de un RM que hago internamente?
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Edicion de Ficha
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
    
        Set ficha = AplicacionProd.ProduccionFichas.Item(IDFICHA1)

        With ficha.Registro
            !Codigo = "02OAS"
            '!idArticuloAsociado=
            !Cantidad = 520
            !IdUnidad = K_UN1
            !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        End With

        Set rs = ficha.DetProduccionFichas.TraerTodos
    
        'edito el primer item
        rs.MoveFirst
        Set DetProduccionFicha = ficha.DetProduccionFichas.Item(rs!IdDetalleProduccionFicha)

        With DetProduccionFicha.Registro
            !IdArticulo = KID_MaterialAlgodonManuar
            !Cantidad = 20
            !Porcentaje = 30
            !IdUnidad = K_UN1
        End With

        DetProduccionFicha.Modificado = True

        'edito el segundo item
        rs.MoveNext
        Set DetProduccionFicha = ficha.DetProduccionFichas.Item(rs!IdDetalleProduccionFicha)

        With DetProduccionFicha.Registro
            !IdArticulo = KID_MaterialRayonViscosa
            !Cantidad = 45
            !IdUnidad = K_UN1
            !Tolerancia = 10
        End With

        DetProduccionFicha.Modificado = True
    
        Set DetProduccionFichaProceso = ficha.DetProduccionFichasProcesos.Item(-1)

        With DetProduccionFichaProceso.Registro
            !IdProduccionProceso = ID_PROC_CONTINUA
            !Horas = 55
        End With

        DetProduccionFichaProceso.Modificado = True

        Set DetProduccionFichaProceso = ficha.DetProduccionFichasProcesos.Item(-1)

        With DetProduccionFichaProceso.Registro
            !IdProduccionProceso = ID_PROC_RETORCIDO
            !Horas = 45
        End With

        DetProduccionFichaProceso.Modificado = True
    
        ficha.Guardar
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Creacion de OP partir de Ficha
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
    
        '    Set Orden = AplicacionProd.ProduccionOrdenes.Item(-1)
        '    Set Ficha = AplicacionProd.ProduccionFichas.Item(IDFICHA1)
        '
        '    With Orden.Registro
        '        !Codigo = "02OAS"
        '        !Descripcion = "Base Cashmere Season 1/28 2472 NEGRO"
        '        !NumeroSalidaMateriales = "00000315"
        '
        '        !IdColor = 2121
        '
        '        !FechaIngreso = Date
        '
        '        !Cantidad = 500
        '        !IdUnidad = K_UN1
        '
        '
        '        !FechaInicioPrevista = #1/1/2000#
        '        !FechaFinalPrevista = #2/1/2000#
        '        !FechaInicioReal = #1/1/2000#
        '        !FechaFinalReal = #2/1/2000#
        '
        '        '!Emitio=
        '        '!Aprobo=
        '        '!Observaciones=
        '        'IdDepositoOrigen
        '    End With
        '
        '
        '    'For Each DetProduccionFichaProceso In Ficha.DetProduccionFichasProcesos
        '    Set rs = Ficha.DetProduccionfichas.TraerTodos
        '    Do While Not rs.EOF
        '        Set DetProduccionOrden = Orden.DetProduccionOrdenes.Item(-1)
        '        With DetProduccionOrden.Registro
        '            !IdArticulo = rs!IdArticulo
        '            '!IdStock =
        '            !Cantidad = rs.Fields("Cant.")
        '            !IdUnidad = rs!IdUnidad
        '        End With
        '        DetProduccionOrden.Modificado = True
        '        rs.MoveNext
        '    Loop
        '
        '
        '    'For Each DetProduccionFichaProceso In Ficha.DetProduccionFichasProcesos
        '    Set rs = Ficha.DetProduccionfichasprocesos.TraerTodos
        '    Do While Not rs.EOF
        '        Set DetProduccionOrdenProceso = Orden.DetProduccionOrdenesProcesos.Item(-1)
        '        With DetProduccionOrdenProceso.Registro
        '            !IdProduccionProceso = rs!IdProduccionProceso
        '            !Horas = rs!Horas
        '        End With
        '        DetProduccionOrdenProceso.Modificado = True
        '        rs.MoveNext
        '    Loop
        '
        '
        '    Orden.Guardar
        '
        '    IDORDEN1 = Orden.Registro.Fields("IdProduccionOrden")
        '
        '
        '    Set Orden = Nothing
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Creacion de Maquinas y Procesos?
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
    
        'sector,nombre,boolForzoso,boolAnterior
        'Aplicacion.Tarea "ProduccionProcesos_A", Array(IDORDEN1, #12/10/2000#)
    
        'proceso asociado
        'Aplicacion.Tarea "ProduccionMaquinas_A", Array(IDORDEN1, #12/10/2000#)
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Creacion de Parte de produccion
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
    
        '@IdEmpleado,'@FechaDia,'@FechaInicio,'@FechaFinal,'@IdProduccionOrden,
        '@IdProduccionProceso,'@Horas,'@HorasReales,'@idMaquina,'@IdArticulo,
        '@IdStock,'@Partida,'@Cantidad,'@IdUnidad
    
        Dim IDSTK1 As Long
        Set rs = Aplicacion.TablasGenerales.TraerFiltrado("ConsultaStockCompleto", "1")
        rs.Find "IdArticulo=" & KID_MaterialAlgodonManuar
        IDSTK1 = rs!IdStock
        Set rs = Nothing
    
        Set rs = Aplicacion.TablasGenerales.TraerFiltrado("ConsultaStockCompleto", "1")
        rs.Find "IdArticulo=" & KID_SemiAlgodonManuar
        KIDStock_SemiAlgodonManuar = rs!IdStock
        Set rs = Nothing
    
        Set PP = AplicacionProd.ProduccionPartes.Item(-1)

        With PP.Registro
            !IdEmpleado = glbIdUsuario
        
            !Fechadia = Date + 2
            !FechaInicio = #2:00:00 PM#
            !fechafinal = #4:31:00 PM#
            !Horas = !fechafinal - !FechaInicio
            !HorasReales = !fechafinal - !FechaInicio + 4
    
            !IdProduccionOrden = IDORDEN1
            !IdProduccionProceso = ID_PROC_MEZCLADO
            !IdMaquina = IDMAQ_MEZCLADORA
        
            !IdArticulo = KID_MaterialAlgodonManuar
            !IdStock = IDSTK1
            'Partida
            !Cantidad = 50
            !IdUnidad = K_UN1
        End With

        PP.Guardar
        Set PP = Nothing
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
    
        Set PP = AplicacionProd.ProduccionPartes.Item(-1)

        With PP.Registro
            !IdEmpleado = glbIdUsuario
        
            !Fechadia = Date + 2
            !FechaInicio = #2:00:00 AM#
            !fechafinal = #10:31:00 PM#
            !Horas = 20 '!FechaFinal - !FechaInicio
            !HorasReales = 20 '!FechaFinal - !FechaInicio + 4
    
            !IdProduccionOrden = IDORDEN1
            !IdProduccionProceso = ID_PROC_ENCARDADO
            !IdMaquina = IDMAQ_CARDA
        
            !IdArticulo = KID_MaterialAlgodonManuar
            !IdStock = IDSTK1
            'Partida
            !Cantidad = 80
            !IdUnidad = K_UN1
        End With

        PP.Guardar
        Set PP = Nothing
    
        '//////////////////////////////////////////////////////////////////
    
        '//////////////////
        'Usando SQL directo
        '//////////////////
        'Aplicacion.Tarea "ProduccionPartes_A", Array(0, _
         370, Date + 2, #2:00:00 PM#, #4:31:00 PM#, IDORDEN1, _
         ID_PROC_MEZCLADO, 2, 10, IDMAQ1, KID_MaterialAlgodonManuar, _
         1, "ss", 5.1, 10)
    
        'Aplicacion.Tarea "ProduccionPartes_A", Array(0, _
         370, Date + 2, #2:00:00 PM#, #4:31:00 PM#, IDORDEN1, _
         ID_PROC_MEZCLADO, 50, 10, IDMAQ2, KID_MaterialRayonViscosa, _
         1, "ss", 18, 10)
        
        'Aplicacion.Tarea "ProduccionPartes_A", Array(0, _
         370, #12/10/2000#, #2:00:00 PM#, #4:31:00 PM#, IDORDEN1, _
         2, 10, 10, 1, 1, _
         1, "ss", 5.1, 10)
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'SCRIPT PARA PROBAR EL PLANIFICADOR DE MATERIALES:
        'CREO 2 OCs QUE COMPRAN 2 TERMINADOS QUE USAN EL MISMO MATERIAL
        'EN EL PLANIFICADOR DEBERIAN VERSE AMBAS OCs
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Crecion de OC
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        Set oPar = Aplicacion.Parametros.Item(1)

        With oPar.Registro
            mN = .Fields("ProximoNumeroOrdenCompra").Value
            .Fields("ProximoNumeroOrdenCompra").Value = mN + 1
        End With

        oPar.Guardar

        Set OC = Aplicacion.OrdenesCompra.Item(-1)

        With OC.Registro
            !NumeroOrdenCompra = mN
            !IdCliente = 22
        End With

        Set DetOC = OC.DetOrdenesCompra.Item(-1)

        With DetOC.Registro
            '!IdColor = 33
            !IdArticulo = KID_TerminadoBaseCashmere
            !Cantidad = 3
            !IdUnidad = K_UN1
        End With

        DetOC.Modificado = True
    
        Set DetOC = OC.DetOrdenesCompra.Item(-1)

        With DetOC.Registro
            '!IdColor = 33
            !IdArticulo = KID_SemiRayonViscosa
            !Cantidad = 50
            !IdUnidad = K_UN1
        End With

        DetOC.Modificado = True
    
        OC.Guardar
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Crecion de OC
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        Set oPar = Aplicacion.Parametros.Item(1)

        With oPar.Registro
            mN = .Fields("ProximoNumeroOrdenCompra").Value
            .Fields("ProximoNumeroOrdenCompra").Value = mN + 1
        End With

        oPar.Guardar

        Set OC = Aplicacion.OrdenesCompra.Item(-1)

        With OC.Registro
            !NumeroOrdenCompra = mN
            !IdCliente = 22
        End With

        Set DetOC = OC.DetOrdenesCompra.Item(-1)

        With DetOC.Registro
            '!IdColor = 33
            !IdArticulo = KID_SemiAlgodonManuar
            !Cantidad = 3
            !IdUnidad = K_UN1
        End With

        DetOC.Modificado = True
    
        OC.Guardar
    
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        'TIPO DE CONTROL DE CALIDAD falta probar la edicion
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
    
        Dim IDTipoCC As Integer
        '//////////////////////////////////////////////////////////////////////
        'alta
        Set TipoCC = AplicacionProd.ControlCalidadTipos.Item(-1)

        With TipoCC
            With .Registro
        
                !Codigo = "01"
                !descripcion = "Tipo Control de Prueba"
            
                !P1Codigo = "TC1"
                !P1Descripcion = "Sabor"
                !P1RangoMinimo = 10
                !P1RangoMaximo = 130
                !P1RangoIdUnidad = K_UN1
                !P1Frecuencia = 5
                !P1FrecuenciaIdUnidad = K_UN1
                !P1EsObligatorio = "SI"
        
                !P2Codigo = "TC1"
                !P2Descripcion = "Resistencia"
                !P2RangoMinimo = 0.12
                !P2RangoMaximo = 1.55
                !P2RangoIdUnidad = K_UN1
                !P2Frecuencia = 20
                !P2FrecuenciaIdUnidad = K_UN1
                !P2EsObligatorio = "SI"
        
                !P3Codigo = "HUM"
                !P3Descripcion = "Humedad"
                !P3RangoMinimo = 870
                !P3RangoMaximo = 1300
                !P3RangoIdUnidad = K_UN1
                !P3Frecuencia = 5
                !P3FrecuenciaIdUnidad = K_UN1
                !P3EsObligatorio = "NO"
        
                !P4Codigo = "TC4"
                !P4Descripcion = ""
                !P4RangoMinimo = 500
                !P4RangoMaximo = 600
                !P4RangoIdUnidad = K_UN1
                !P4Frecuencia = 10
                !P4FrecuenciaIdUnidad = K_UN1
                !P4EsObligatorio = "NO"
        
                !P5Codigo = "TC1"
                !P5Descripcion = ""
                !P5RangoMinimo = 1
                !P5RangoMaximo = 3
                !P5RangoIdUnidad = K_UN1
                !P5Frecuencia = 0.01
                !P5FrecuenciaIdUnidad = K_UN1
                !P5EsObligatorio = "NO"
        
            End With
    
            .Guardar
            IDTipoCC = .Registro.Fields("IdPROD_TiposControlCalidad")
        End With

        Set TipoCC = Nothing
    
        '//////////////////////////////////////////////////////////////////
        'edicion
        Set TipoCC = AplicacionProd.ControlCalidadTipos.Item(IDTipoCC)

        With TipoCC
            With .Registro
        
                '!Codigo = "sfds"
                '!Descripcion = "AS"
            
                '!P1Codigo = "dsaf"
                '!P1Descripcion = "ff2"
                '!P1RangoMinimo = 1
                '!P1RangoMaximo = 1
                '!P1RangoIdUnidad = 1
                '!P1Frecuencia = 1
                '!P1FrecuenciaIdUnidad = 1
                '!P1EsObligatorio = "NO"
            End With
    
            .Guardar
        End With

        Set TipoCC = Nothing
    
        '//////////////////////////////////////////////////////////////////
    
        Dim IDSTK2 As Long
        Set rs = Aplicacion.TablasGenerales.TraerFiltrado("ConsultaStockCompleto", "1")
        rs.Find "IdArticulo=" & KID_MaterialRayonViscosa
        IDSTK2 = rs!IdStock
        Set rs = Nothing
    
        Set PP = AplicacionProd.ProduccionPartes.Item(-1)

        With PP.Registro
            !IdEmpleado = glbIdUsuario
        
            !Fechadia = Date + 2
            !FechaInicio = #2:00:00 AM#
            !fechafinal = #10:31:00 PM#
            !Horas = 20 '!FechaFinal - !FechaInicio
            !HorasReales = 20 '!FechaFinal - !FechaInicio + 4
    
            !IdProduccionOrden = IDORDEN2
            !IdProduccionProceso = ID_PROC_ENCARDADO
            !IdMaquina = IDMAQ_CARDA
        
            !IdArticulo = KID_MaterialRayonViscosa
            !IdStock = IDSTK2
            'Partida
            !Cantidad = 25
            !IdUnidad = K_UN1
    
            !idprod_tiposControlCalidad = IDTipoCC
            !Control1 = 54.019
            !Control2 = 1400
            !Control3 = 0
            !Control4 = 6.7
            '!Control5 = 1
        
            !paroObservacion = "Problema Mecánico"
            !ParoInicio = #5:00:00 AM#
            !ParoFinal = #7:00:00 AM#
            
        End With

        PP.Guardar
        Set PP = Nothing
    
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
   
    Next n
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '////////////          FIN  BUCLE                 /////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    Dim Plan As Plan
    Set Plan = AplicacionProd.Planes.Item(-1)

    With Plan
        With .Registro
            !Fecha = Date
            !Documento = ""
            !Cliente = ""
            !Cantidad = 120
            !StockInicial = 0
            !AConsumir = 50
            !IngresosPrevistos = 0
            !StockFinal = 0
            '!PedidosPrevistos = 0
            '!OPPrevista = 0
            
            !PlanMaestro = 1
            !IdArticuloProducido = KID_SemiAlgodonManuar
            !idArticuloMaterial = KID_MaterialAlgodonManuar
        End With
    
        .Guardar
    End With

    Set Plan = Nothing
    
    '//////////////////////////////////////////////////////////////////
    '    Set Plan = AplicacionProd.Planes.Item(-1)
    '    With Plan
    '        With .Registro
    '            !Fecha = Date - 3
    '            !Documento = ""
    '            !Cliente = ""
    '            !Cantidad = 120
    '            !StockInicial = 0
    '            !AConsumir = 50
    '            !IngresosPrevistos = 0
    '            !StockFinal = 0
    '            '!PedidosPrevistos = 0
    '            '!OPPrevista = 0
    '
    '            !PlanMaestro = 1
    '            !IdArticuloProducido = KID_TerminadoBaseCashmere
    '            !idArticuloMaterial = KID_SemiRayonViscosa
    '        End With
    '
    '        .Guardar
    '    End With
    '    Set Plan = Nothing
    '
    '//////////////////////////////////////////////////////////////////
    Dim ProgRecurso As ProgRecurso
    Set ProgRecurso = AplicacionProd.ProgRecursos.Item(-1)

    With ProgRecurso
        With .Registro
            !Fecha = Date - 1
            '!IdMaquina = IDMAQ2
            
            !Cantidad = 22
            !ProgRecurso = 2
            
            !FechaInicio = Date + 3
            !fechafinal = Date + 10
        End With
    
        .Guardar
    End With

    Set ProgRecurso = Nothing
    '//////////////////////////////////////////////////////////////////
    
    Me.MousePointer = vbDefault
    
    MsgBox "Fin Script. Resultado: TODAVIA FALTA HACER VALIDACION!!!! Generar valores aleatorios y correr el script 100 veces"
End Sub

Private Sub mnuScriptGUIsinPausa_Click()
    ScriptGUI 0.05
End Sub

Private Sub mnuScriptGUI_Click()
    ScriptGUI
End Sub

Private Sub mnuScriptGUIPlanes_Click()
    Const COL_ID1 = 0
    Const COL_ID2 = 1
    Const COL_FECHA = 2
    Const COL_DOCUMENTO = 3
    Const COL_CLIENTE = 4
    Const COL_CANTIDAD = 5
    Const COL_STOCKINICIAL = 6
    Const COL_ACONSUMIR = 7
    Const COL_INGRESOSPREVISTOS = 8
    Const COL_STOCKFINAL = 9
    Const COL_PEDIDOSPREVISTOS = 10
    Const COL_OPPREVISTA = 11
    Const COL_MAX = 11
    
    'Soft Lambswool  1/15 Vaporizado
    '
    '
    'Light 1/15 A002 Crudo B Vaporizado
    '    Fibra de lana carbonizada Cordero Cruda 21 Mic
    '    Pelo de Angora 2da nacional
    '    Pelo flandes crudo
    '    Fibra de poliamida 6,6  2.2 cruda
    '    Agua
    '
    '
    'Cashmere season 8/15 CS225 Rosa capullo Teñido
    
    Dim mN
    Dim oPar As ComPronto.Parametro
    
    Dim Orden As ComPronto.ProduccionOrden
    Dim DetProduccionOrden As DetProduccionOrden
    Dim DetProduccionOrdenProceso As DetProdOrdenProceso
    
    Dim ficha As ComPronto.ProduccionFicha
    Dim DetProduccionFicha As DetProduccionFicha
    Dim DetProduccionFichaProceso As DetProdFichaProceso

    Dim PP As ComPronto.ProduccionParte
    Dim TipoCC As ControlCalidadTipo
    
    Dim OC As ComPronto.OrdenCompra
    Dim DetOC As ComPronto.DetOrdenCompra

    Dim oI As ComPronto.OtroIngresoAlmacen
    Dim DetOI As ComPronto.DetOtroIngresoAlmacen
    
    Dim RM As ComPronto.Requerimiento
    Dim DetRM As ComPronto.DetRequerimiento
    
    Dim NP As ComPronto.Pedido
    Dim DetNP As ComPronto.DetPedido

    Dim frmPM As frmPlanificacionMateriales
    Dim oFOCPend As frmOCsPendientes
    Dim oFOPPend As frmOPsPendientes
    
    Dim AjusteStk As ComPronto.AjusteStock
    Dim DetAjusteStk As ComPronto.DetAjusteStock
   
    Dim frmOP As frmProduccionOrden
    Dim frmOPDet As frmDetProduccionOrden
    Dim frmOPDetProc As frmDetProduccionOrdenProceso
   
    Dim IDPLANMAT1 As Long
    Dim IDORDEN1 As Long
   
    Dim i As Long
    Dim pausa As Double
    pausa = 0.5
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'AJUSTE - Alta
    lbl ("Me aseguro de que al principio del script esté el stock como quiero")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
   
    'Set oPar = Aplicacion.Parametros.Item(1)
    'With oPar.Registro
    '    mN = .Fields("ProximoNumeroOrdenCompra").Value
    '    .Fields("ProximoNumeroOrdenCompra").Value = mN + 1
    'End With
    'oPar.Guardar
    
    Set AjusteStk = Aplicacion.AjustesStock.Item(-1)

    With AjusteStk.Registro
        '!NumeroOrdenCompra = mN
        '!IdCliente = KID_Cliente2
        '!FechaOrdenCompra = Date - 2
        '!FechaNecesidad = Date + 5
        !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        '!IdColor = 33
    End With

    Set DetAjusteStk = AjusteStk.DetAjustesStock.Item(-1)

    With DetAjusteStk.Registro
        !IdArticulo = BuscaIdArticulo("Cashmere season 8/15 CS225 Rosa capullo Teñido")
        !CantidadUnidades = Aplicacion.StockPorIdArticulo(BuscaIdArticulo("Cashmere season 8/15 CS225 Rosa capullo Teñido"))
        !IdUnidad = BuscaIdUnidad("Kilos")
    End With

    DetAjusteStk.Modificado = True
    
    Set DetAjusteStk = AjusteStk.DetAjustesStock.Item(-1)

    With DetAjusteStk.Registro
        !IdArticulo = BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado")
        !CantidadUnidades = Aplicacion.StockPorIdArticulo(BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado"))
        !IdUnidad = BuscaIdUnidad("Kilos")
    End With

    DetAjusteStk.Modificado = True
    
    AjusteStk.Guardar
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'OC - Alta
    lbl ("Dos clientes compra un Terminado, y otro un Semielaborado")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    
    Set oPar = Aplicacion.Parametros.Item(1)

    With oPar.Registro
        mN = .Fields("ProximoNumeroOrdenCompra").Value
        .Fields("ProximoNumeroOrdenCompra").Value = mN + 1
    End With

    oPar.Guardar
    
    Set OC = Aplicacion.OrdenesCompra.Item(-1)

    With OC.Registro
        !NumeroOrdenCompra = mN
        !IdCliente = KID_Cliente2
        !FechaOrdenCompra = Date - 2
        !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        '!IdColor = 33
    End With

    Set DetOC = OC.DetOrdenesCompra.Item(-1)

    With DetOC.Registro
        !FechaNecesidad = Date + 5
        !IdArticulo = BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado")
        !Cantidad = 1500
        !IdUnidad = BuscaIdUnidad("Kilos")
    End With

    DetOC.Modificado = True
    
    Set DetOC = OC.DetOrdenesCompra.Item(-1)

    With DetOC.Registro
        !FechaNecesidad = Date + 5
        !IdArticulo = BuscaIdArticulo("Cashmere season 8/15 CS225 Rosa capullo Teñido")
        !Cantidad = 700
        !IdUnidad = BuscaIdUnidad("Kilos")
    End With

    DetOC.Modificado = True
    
    'Set DetOC = OC.DetOrdenesCompra.Item(-1)
    'With DetOC.Registro
    '    !IdArticulo = BuscaIdArticulo("Cashmere season 8/15 CS225 Rosa capullo Teñido")
    '    !Cantidad = 900
    '    !IdUnidad = BuscaIdUnidad("Kilos")
    'End With
    'DetOC.Modificado = True
    
    OC.Guardar
    
    'Tambien hago rms vinculadas a
    
    'generá una op, y después que puedas ver esa misma op en otro plan
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'PLANMAT - Alta
    lbl ("Como me quedo corto, Planifico un Semielaborado usando como base un Terminado")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
   
    Set frmPM = New frmPlanificacionMateriales

    With frmPM
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPM
        .Show , Me
        
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPM, 11, BuscaIdArticulo("Cashmere season 8/15 CS225 Rosa capullo Teñido")
        Delay pausa
        CambiaDcfields frmPM, 0, BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado")
        Delay pausa
        
        Delay pausa
        .cmdCommand1_Click
       
        '/////////////////////////////////////
        'juego un toque con la fecha para ver cómo cambia el stock
        Delay pausa
        .DTFields(1) = Date + 4
        Delay pausa
        .cmdCommand1_Click
        Delay pausa * 2
        .DTFields(1) = Date + 1
        .cmdCommand1_Click
        Delay pausa * 2
        .DTFields(1) = Date
        .cmdCommand1_Click
        Delay pausa * 2
       
        '/////////////////////////////////////
       
        '////////////////////////////////////
        .fGrid.Row = 7 'elijo el renglon donde se inserta
        Set oFOCPend = New frmOCsPendientes 'en lugar de hacer un click para llamar al form,

        'lo creo desde acá
        With oFOCPend
            .Id = "Compras"
            .FiltroArticulo = frmPM.dcfields(11).BoundText
            .FiltroMaterial = frmPM.dcfields(0).BoundText
            .Show , Me
            
            '////////////////////////////////////////
            Dim oL As ListItem

            'Set oL = .Lista.SelectedItem
            'For i = 1 To oL.ListSubItems.Count
            For i = 1 To .Lista.ListItems.Count - 1

                If .Lista.ListItems(i).Tag = IDORDEN1 Then Exit For
                '.SubItems(i) = oL.SubItems(i)
                ' .Lista.ListItems(i).SubItems(10) = ors!Color
            Next

            .Lista.SelectedItem = i
            '///////////////////////////////////////
            
            Delay pausa * 2
            .Lista_DblClick
        End With

        .PostmodalOCPendientes oFOCPend
        '////////////////////////////////////
       
        ''////////////////////////////////////
        '.fGrid.row = 5 'elijo el renglon donde se inserta
        'Set oFOPPend = New frmOPsPendientes
        'With oFOPPend
        '   .Id = "Compras"
        '   .FiltroArticulo = frmPM.dcfields(11).BoundText
        '   .FiltroMaterial = frmPM.dcfields(0).BoundText
        '
        '   .Show , Me
        '
        '    Delay pausa
       
        '    .Lista.SelectedItem = 1
        '
        '    Delay pausa * 2
        '    .Lista_DblClick
        'End With
       
        '.PostmodalOPPendientes oFOPPend
        ''////////////////////////////////////
        
        Delay pausa
        
        .fGrid.Row = 8
        .fGrid.col = COL_CANTIDAD
        .fGrid = 15.1
        
        Delay pausa
        .fGrid.TextMatrix(5, COL_OPPREVISTA) = 1000
        Delay pausa
        .fGrid.TextMatrix(5, COL_PEDIDOSPREVISTOS) = 300
        Delay pausa
        .fGrid.TextMatrix(7, COL_PEDIDOSPREVISTOS) = 300
        Delay pausa
        
        Delay pausa
        .cmdGenerar_Click (2) 'generar
       
        Delay pausa * 5
       
        .SetFocus
        .ZOrder
        
        Delay pausa
        .cmd_Click (1) 'salir
        Delay pausa
        IDPLANMAT1 = .mvarId '.origen.Registro.Fields(0).Value
    End With

    Unload frmPM 'esto no sé por qué saca de la pantalla tambien los documentos generados
    Set frmPM = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'PLANMAT - Ver
    lbl ("Planifico una materia prima usando como base un semielaborado")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Set frmPM = New frmPlanificacionMateriales

    With frmPM
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = IDPLANMAT1
        .Disparar = ActL
        ReemplazarEtiquetas frmPM
        .Show , Me
        
        '/////////////////////////////////////
        Delay pausa * 5
        .cmd_Click (1) 'salir
    End With
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'PLANMAT - Alta
    lbl ("")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Set frmPM = New frmPlanificacionMateriales

    With frmPM
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPM
        .Show , Me
        
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPM, 11, BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado")
        Delay pausa
        CambiaDcfields frmPM, 0, BuscaIdArticulo("Pelo de Angora 2da nacional")
        Delay pausa
        
        Delay pausa
        .cmdCommand1_Click
        
        '////////////////////////////////////
        .fGrid.Row = 3 'elijo el renglon donde se inserta
        Set oFOCPend = New frmOCsPendientes

        With oFOCPend
            .Id = "Compras"
            '.FiltroArticulo = dcfields(11).BoundText
            .Show , Me
        
            .Lista.SelectedItem = 1
            Delay pausa
            .Lista_DblClick
        End With

        .PostmodalOCPendientes oFOCPend
        '////////////////////////////////////
       
        '////////////////////////////////////
        .fGrid.Row = 3 'elijo el renglon donde se inserta
        Set oFOPPend = New frmOPsPendientes

        With oFOPPend
            .Id = "Compras"
            '.FiltroArticulo = dcfields(11).BoundText
            .Show , Me
            
            'Set oL = .Lista.SelectedItem
            
            For i = 1 To .Lista.ListItems.Count

                If .Lista.ListItems(i).Tag = IDORDEN1 Then Exit For
                '.SubItems(i) = oL.SubItems(i)
                ' .Lista.ListItems(i).SubItems(10) = ors!Color
            Next

            .Lista.SelectedItem = i
            
            Delay pausa
            .Lista_DblClick
        End With
        
        .PostmodalOPPendientes oFOPPend
        '////////////////////////////////////
        
        Delay pausa
        .cmdGenerar_Click (2)
       
        '.cmd_Click (0)
       
        ' tendría que hacer publica el _click de cmd(0)... A menos que el script esté
        ' dentro del formulario
    End With

    Unload frmPM
    Set frmPM = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'PROGRECU - Alta
    lbl ("acá poner una op que usa el boton de OPsPendientes")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    
    Dim frmPRec As frmProgRecursos
    Set frmPRec = New frmProgRecursos

    With frmPRec
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPM
        .Show , Me
        
        '/////////////////////////////////////
        ' delay pausa
        '.dcfields(11).BoundText = KID_TerminadoBaseCashmere
        
        Delay pausa
        
        'como puedo arrastrar?
        
        .cmd_Click (0) 'guardo
       
        Delay pausa
        .cmd_Click (2) 'salgo
        Delay pausa
       
    End With

    Unload frmPRec
    Set frmPRec = Nothing

    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'OP - Alta
    lbl ("acá poner una op que usa el boton de OPsPendientes")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Set frmOP = New frmProduccionOrden

    With frmOP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmOP
        .Show , Me
        
        '/////////////////////////////////////
        Delay pausa
        
        .rchObservaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        
        '////////////////////////////////////
        Set oFOPPend = New frmOPsPendientes

        With oFOPPend
            .Id = "Compras"
            .FiltroArticulo = frmOP.dcfields(11).BoundText
            '.FiltroMaterial = frmOP.dcfields(0).BoundText
           
            .Show , Me
        
            Delay pausa
            .Lista.SelectedItem = 1
            Delay pausa * 2
            .Lista_DblClick
        End With
        
        .PostmodalOPPendientes oFOPPend
        '////////////////////////////////////
        
        '.dcfields(11).BoundText = BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado")
        ''.dcfields_Change (11)
        '.dcfields_Validate 11, True
        'Delay pausa
        '.dcfields(20).BoundText = BuscaIdUnidad("Kilos")
        'Delay pausa
        '.dcfields(13).BoundText = BuscaIdColor("11227 Brownie")
        'Delay pausa
        '.txtCantidad = 2050
       
        .cmd_Click (0)
   
        IDORDEN1 = .mvarId '.origen.Registro.Fields(0).Value
    End With

    Unload frmOP
    Set frmOP = Nothing

    '//////////////////////////////////////////////////////////////////

    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'OP - Alta
    lbl ("acá poner una op que usa el boton de OCsPendientes")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Set frmOP = New frmProduccionOrden

    With frmOP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmOP
        .Show , Me
        
        '/////////////////////////////////////
        Delay pausa
        
        .rchObservaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        
        '////////////////////////////////////
        Set oFOCPend = New frmOCsPendientes

        With oFOCPend
            .Id = "Compras"
            .FiltroArticulo = frmOP.dcfields(11).BoundText
            '.FiltroMaterial = frmOP.dcfields(0).BoundText
            .Show , Me
            
            Delay pausa
            .Lista.SelectedItem = 1
            Delay pausa * 2
            .Lista_DblClick
        End With

        .PostmodalOCPendientes oFOCPend
        '////////////////////////////////////
        
        '.dcfields(11).BoundText = BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado")
        ''.dcfields_Change (11)
        '.dcfields_Validate 11, True
        'Delay pausa
        '.dcfields(20).BoundText = BuscaIdUnidad("Kilos")
        'Delay pausa
        '.dcfields(13).BoundText = BuscaIdColor("11227 Brownie")
        'Delay pausa
        '.txtCantidad = 2050
       
        .cmd_Click (0)
   
        IDORDEN1 = .mvarId '.origen.Registro.Fields(0).Value
    End With

    Unload frmOP
    Set frmOP = Nothing

    '//////////////////////////////////////////////////////////////////
    
End Sub

Sub ScriptGUI(Optional pausa As Double = 1)
    
    'esto se podría usar incluso como presentación....
    '-Pero por qué no hacés esto conun soft de testing?
    '-Es que tenerlo en codigo te fuerza una interfaz, como con los scripts de Business
    '-Pero hombre!, hacerlo en un soft de testing, copiando y pegando, tambien te fuerza!
    
    InicializaConstantesDeScripts
    
    Dim rs As ADOR.Recordset
    
    'prefijar con _PRUEBA?
    
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'PROBLEMIN!!!!!!!!!!!!!!!!
    'El problema es que estoy obligado a llamar explicitamente al validate y al change de los
    'combos!!!!!!!!!!!!!!!!!!
    '///////////////////////////////////////////////////////////////////
    
    Dim IDORDEN1
    Set rs = AplicacionProd.ProduccionOrdenes.TraerTodos
    rs.Filter = ""
    rs.MoveLast
    IDORDEN1 = rs!IdProduccionOrden
   
    Set rs = Aplicacion.TablasGenerales.TraerFiltrado("ConsultaStockCompleto", "1")
    rs.Find "IdArticulo=" & KID_MaterialAlgodonManuar
    IDSTK1 = rs!IdStock
    Set rs = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'Creacion de Ficha
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Dim frmFicha As frmProduccionFicha
    Set frmFicha = New frmProduccionFicha

    With frmFicha
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmFicha
        .Show , Me
        
        '/////////////////////////////////////
        Delay pausa
        .dcfields(1).BoundText = KID_TerminadoBaseCashmere
        Delay pausa
        .dcfields(0).BoundText = K_UN1
        Delay pausa
        .dcfields(13).BoundText = KID_ColorAluminio
        .txtCantidad = 800
       
        '////////////////////////////////////
        Dim frmFichaDet As frmDetProduccionFicha
        Set frmFichaDet = New frmDetProduccionFicha

        With frmFichaDet
            Set .ProduccionFicha = frmFicha.origen
            .Id = -1
            .Show , Me
        
            .DataCombo1(1).BoundText = KID_DeshechoBorra
            Delay pausa
            .txtCantidad = 150
            .DataCombo1(0).BoundText = K_UN1
            Delay pausa
            .DataCombo1(13).BoundText = KID_ColorAluminio
            Delay pausa
            .DataCombo1(7).BoundText = ID_PROC_CONTINUA
            Delay pausa
            .cmd_Click (0)
        End With

        .PostmodalEditar frmFichaDet, -1
        '////////////////////////////////////
       
        '////////////////////////////////////
        Dim frmFichaDetProc As frmDetProduccionFichaProceso
        Set frmFichaDetProc = New frmDetProduccionFichaProceso

        With frmFichaDetProc
            Set .ProduccionFicha = frmFicha.origen
            .Id = -1
            .Show , Me
        
            .DataCombo1(1).BoundText = ID_PROC_CONTINUA
            Delay pausa
            .txtCantidad = 20
            Delay pausa
            .cmd_Click (0)
        End With

        .PostmodalEditarProceso frmFichaDetProc, -1
        '////////////////////////////////////
       
        'compruebo la plantilla

        .cmd_Click (0)
   
        IDFICHA1 = .mvarId '.origen.Registro.Fields(0).Value
    End With

    Unload frmFicha
    Set frmFicha = Nothing

    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'Edicion de Ficha
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    
    'Arbol_NodeClick Arbol.Nodes("FichaTecnica")
    'Editar IDFICHA1
    '.cmdImpre_Click (1)
   
    Set frmFicha = New frmProduccionFicha

    With frmFicha
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = IDFICHA1
        .Disparar = ActL
        ReemplazarEtiquetas frmFicha
        .Show , Me
    
        .cmdImpre_Click (1)
        .cmd_Click (1)
    End With

    Unload frmFicha
    Set frmFicha = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'Creacion de OP
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Dim frmOP As frmProduccionOrden
    Set frmOP = New frmProduccionOrden

    With frmOP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmOP
        .Show , Me
        
        '/////////////////////////////////////
        Delay pausa
        .dcfields(11).BoundText = KID_TerminadoBaseCashmere
        Delay pausa
        .dcfields(20).BoundText = K_UN1
        Delay pausa
        .dcfields(13).BoundText = KID_ColorAluminio
        Delay pausa
        .txtCantidad = 2050
       
        '////////////////////////////////////
        Dim frmOPDet As frmDetProduccionOrden
        Set frmOPDet = New frmDetProduccionOrden

        With frmOPDet
            Set .ProduccionOrden = frmOP.origen
            .Id = -1
            .Show , Me
        
            .DataCombo1(1).BoundText = KID_DeshechoBorra
            Delay pausa
            .txtPartida = "bb97"
            Delay pausa
            .txtCantidad = 150
            .DataCombo1(0).BoundText = K_UN1
            Delay pausa
            .DataCombo1(7).BoundText = ID_PROC_CONTINUA
            Delay pausa
            .cmd_Click (0)
        End With

        .PostmodalEditar frmOPDet, -1
        'Unload frmOPDet
        'Set frmOPDet = Nothing
        '////////////////////////////////////
       
        '////////////////////////////////////
        Dim frmOPDetProc As frmDetProduccionOrdenProceso
        Set frmOPDetProc = New frmDetProduccionOrdenProceso

        With frmOPDetProc
            Set .ProduccionOrden = frmOP.origen
            .Id = -1
            .Show , Me
        
            .DataCombo1(1).BoundText = ID_PROC_CONTINUA
            Delay pausa
            .txtCantidad = 20
            Delay pausa
            .DataCombo1(0).BoundText = IDMAQ_CONTINUA
            Delay pausa
            .cmd_Click (0)
        End With

        .PostmodalEditarProceso frmOPDetProc, -1
        'Unload frmOPDetProc
        'Set frmOPDetProc = Nothing
        '////////////////////////////////////
       
        .cmd_Click (0)
    End With

    Unload frmOP
    Set frmOP = Nothing

    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'Creacion de OP usando Ficha
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Set frmOP = New frmProduccionOrden

    With frmOP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmOP
        .Show , Me
        
        '/////////////////////////////////////
        Delay pausa
        .dcfields(11).BoundText = KID_TerminadoBaseCashmere
        .dcfields_Change (11)
        Delay pausa
        .dcfields(20).BoundText = K_UN1
        Delay pausa
        .dcfields(13).BoundText = KID_ColorAluminio
        Delay pausa
        .txtCantidad = 2050
       
        '////////////////////////////////////
        Set frmOPDet = New frmDetProduccionOrden

        With frmOPDet
            Set .ProduccionOrden = frmOP.origen
            .Id = -1
            .Show , Me
        
            .DataCombo1(1).BoundText = KID_DeshechoBorra
            Delay pausa
            .txtPartida = "bb97"
            Delay pausa
            .txtCantidad = 150
            .DataCombo1(0).BoundText = K_UN1
            Delay pausa
            .DataCombo1(7).BoundText = ID_PROC_CONTINUA
            Delay pausa
            .cmd_Click (0)
        End With

        .PostmodalEditar frmOPDet, -1
        'Unload frmOPDet
        'Set frmOPDet = Nothing
        '////////////////////////////////////
       
        '////////////////////////////////////
        Set frmOPDetProc = New frmDetProduccionOrdenProceso

        With frmOPDetProc
            Set .ProduccionOrden = frmOP.origen
            .Id = -1
            .Show , Me
        
            .DataCombo1(1).BoundText = ID_PROC_CONTINUA
            Delay pausa
            .txtCantidad = 20
            Delay pausa
            .DataCombo1(0).BoundText = IDMAQ_CONTINUA
            Delay pausa
            .cmd_Click (0)
        End With

        .PostmodalEditarProceso frmOPDetProc, -1
        'Unload frmOPDetProc
        'Set frmOPDetProc = Nothing
        '////////////////////////////////////
       
        .cmd_Click (0)
    End With

    Unload frmOP
    Set frmOP = Nothing
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'Creacion de Parte de produccion
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Dim frmPP As frmProduccionParte
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        .dcfields(2).BoundText = glbIdUsuario
        Delay pausa
        .dcfields(11).BoundText = IDORDEN1
        Delay pausa
        .dcfields(1).BoundText = ID_PROC_CONTINUA
        Delay pausa
        .dcfields(8).BoundText = IDMAQ_CONTINUA
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = #2:00:00 PM#
        Delay pausa
        .TurnoFinal = #4:31:00 PM#
        Delay pausa
        
        .SSTab1.Tab = 1
        .dcfields(0).BoundText = IDSTK1
        Delay pausa
        .txtPeso = 50
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'Creacion de Parte de produccion
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        .dcfields(2).BoundText = glbIdUsuario
        Delay pausa
        .dcfields(11).BoundText = IDORDEN1
        Delay pausa
        .dcfields(1).BoundText = ID_PROC_MEZCLADO
        Delay pausa
        .dcfields(8).BoundText = IDMAQ_MEZCLADORA
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = #2:00:00 PM#
        Delay pausa
        .TurnoFinal = #4:31:00 PM#
        Delay pausa
        
        .dcfields(0).BoundText = IDSTK1
        Delay pausa
        .txtPeso = 50
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'Creacion de Parte de produccion
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        .dcfields(2).BoundText = glbIdUsuario
        Delay pausa
        .dcfields(11).BoundText = IDORDEN1
        Delay pausa
        .dcfields(1).BoundText = ID_PROC_CONTINUA
        Delay pausa
        .dcfields(8).BoundText = IDMAQ_CONTINUA
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = #2:00:00 PM#
        Delay pausa
        .TurnoFinal = #4:31:00 PM#
        Delay pausa
        
        .SSTab1.Tab = 1
        .dcfields(0).BoundText = IDSTK1
        Delay pausa
        .txtPeso = 50
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
End Sub

'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////

Private Sub mnuScriptGUIPartes_Click()
    InicializaConstantesDeScripts
    Dim pausa As Double
    pausa = 0.05
   
    Dim frmOP As frmProduccionOrden
    Dim frmOPDet As frmDetProduccionOrden
    Dim frmOPDetProc As frmDetProduccionOrdenProceso

    Dim frmPP As frmProduccionParte
    
    Dim frmPr As frmProduccionProceso
   
    'prefijar con _PRUEBA?
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'OP - Alta
    'La creo usando una Ficha
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Set frmOP = New frmProduccionOrden

    With frmOP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmOP
        .Show , Me
        
        '/////////////////////////////////////
        .rchObservaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        
        Delay pausa
        .dcfields(11).BoundText = KID_TerminadoBaseCashmere
        '.dcfields_Change (11)
        .dcfields_Validate 11, True
        Delay pausa
        .dcfields(20).BoundText = K_UN1
        Delay pausa
        .dcfields(13).BoundText = KID_ColorAluminio
        Delay pausa
        .txtCantidad = 2050
       
        '        '////////////////////////////////////
        '        Set frmOPDet = New frmDetProduccionOrden
        '        With frmOPDet
        '           Set .ProduccionOrden = frmOP.origen
        '           .Id = -1
        '           .Show , Me
        '
        '            .DataCombo1(1).BoundText = KID_DeshechoBorra
        '            Delay pausa
        '            .txtPartida = "bb97"
        '            Delay pausa
        '            .txtCantidad = 150
        '            .DataCombo1(0).BoundText = K_UN1
        '            Delay pausa
        '            .DataCombo1(7).BoundText = ID_PROC_CONTINUA
        '            Delay pausa
        '            .cmd_Click (0)
        '        End With
        '        .PostmodalEditar frmOPDet, -1
        '        'Unload frmOPDet
        '        'Set frmOPDet = Nothing
        '        '////////////////////////////////////
        '
        '        '////////////////////////////////////
        '        Set frmOPDetProc = New frmDetProduccionOrdenProceso
        '        With frmOPDetProc
        '           Set .ProduccionOrden = frmOP.origen
        '           .Id = -1
        '           .Show , Me
        '
        '            .DataCombo1(1).BoundText = ID_PROC_CONTINUA
        '            Delay pausa
        '            .txtCantidad = 20
        '            Delay pausa
        '            .DataCombo1(0).BoundText = IDMAQ_CONTINUA
        '            Delay pausa
        '            .cmd_Click (0)
        '        End With
        '        .PostmodalEditarProceso frmOPDetProc, -1
        '        'Unload frmOPDetProc
        '        'Set frmOPDetProc = Nothing
        '        '////////////////////////////////////
       
        .cmd_Click (0)
   
        IDORDEN1 = .mvarId '.origen.Registro.Fields(0).Value
    End With

    Unload frmOP
    Set frmOP = Nothing

    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    Me.StatusBar1.Panels(3).Text = "Intento empezar un proceso (Continua) sin que el anterior haya empezado (Mezclado)"
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_CONTINUA
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_CONTINUA
        Delay pausa
        
        .SSTab1.Tab = 3
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    ' Mezclado
    Me.StatusBar1.Panels(3).Text = "Ahora empiezo bien 1/3"
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_MEZCLADO
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_MEZCLADORA
        Delay pausa
        
        .SSTab1.Tab = 3
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
        
        .SSTab1.Tab = 1
        CambiaDcfields frmPP, 0, KIDStock_MaterialAlgodonManuar
        Delay pausa
        .txtPeso = 134.1
        Delay pausa
        
        Delay pausa
        .cmd_Click (0)
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    ' Mezclado
    Me.StatusBar1.Panels(3).Text = "Ahora empiezo bien 2/3"
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_MEZCLADO
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_MEZCLADORA
        Delay pausa
        
        .SSTab1.Tab = 3
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
        
        .SSTab1.Tab = 1
        CambiaDcfields frmPP, 0, KIDStock_MaterialRayonViscosa
        Delay pausa
        .txtPeso = 35.1
        Delay pausa
        
        Delay pausa
        .cmd_Click (0)
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    ' Mezclado
    Me.StatusBar1.Panels(3).Text = "Ahora empiezo bien 3/3 Este queda abierto"
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_MEZCLADO
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_MEZCLADORA
        Delay pausa
        
        .SSTab1.Tab = 3
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        
        Delay pausa
        .cmd_Click (0)
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    Me.StatusBar1.Panels(3).Text = "Hago el siguiente (Cardado). Me rebota porque no cerró el mezclado"
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        '.dcfields(11).BoundText = IDORDEN1
        '.dcfields_Click 11, dbcAreaList
        '.dcfields_Validate 11, False
        '.dcfields_Change 11
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_ENCARDADO
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_CARDA
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Edicion
    Me.StatusBar1.Panels(3).Text = "Cierra el proceso Mezclado. Me tiene que saltar el mensaje de que estoy usando uno anterior"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_MEZCLADO
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_MEZCLADORA
        Delay pausa
        
        .SSTab1.Tab = 3
        .TurnoFinal = DateAdd("h", 2, Date)
        Delay pausa
        
        .SSTab1.Tab = 1
        CambiaDcfields frmPP, 0, KIDStock_SemiRayonViscosa
        Delay pausa
        .txtPeso = 50
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    Me.StatusBar1.Panels(3).Text = "Hago el siguiente (Cardado). Ahora no me debe rebotar"
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        '.dcfields(11).BoundText = IDORDEN1
        '.dcfields_Click 11, dbcAreaList
        '.dcfields_Validate 11, False
        '.dcfields_Change 11
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_ENCARDADO
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_CARDA
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing

    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    Me.StatusBar1.Panels(3).Text = "El empleado se va y toma el lugar otro, y sigue el Cardado"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, ID_EMPLEADO2
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_ENCARDADO
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_CARDA
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 4, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 7, Date)
        Delay pausa
        
        .SSTab1.Tab = 1
        CambiaDcfields frmPP, 0, KIDStock_SemiRayonViscosa
        Delay pausa
        .txtPeso = 50
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing

    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    Me.StatusBar1.Panels(3).Text = "Informa un Paro"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_CONTINUA
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_CONTINUA
        Delay pausa
        
        .SSTab1.Tab = 0
        .Fecha = Date + 2
        .txtCausaParo = "Problema Mecánico"
        .ParoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .ParoFinal = DateAdd("h", 2, Date)
        Delay pausa
        
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    Me.StatusBar1.Panels(3).Text = "Informa otro Paro. Pero todavia en esta version no se pueden repetir, así que se queja"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_CONTINUA
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_CONTINUA
        Delay pausa
        
        .SSTab1.Tab = 0
        .txtCausaParo = "Problema Mecánico"
        .ParoInicio = DateAdd("h", -2, Now)
        Delay pausa
        .ParoFinal = DateAdd("m", -20, Now)
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing

    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Edicion
    Me.StatusBar1.Panels(3).Text = "Informa un Control de Calidad"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_CONTINUA
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_CONTINUA
        Delay pausa
        
        .SSTab1.Tab = 2
        
        CambiaDcfields frmPP, 3, 1 'reemplazar por IDTIPOCONTROLCALIDAD
        Delay pausa
        
        .txtMaximo(0) = 2.4
        
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'OP - Edicion
    Me.StatusBar1.Panels(3).Text = "Nada más para ver los avances de los procesos"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Set frmOP = New frmProduccionOrden

    With frmOP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = IDORDEN1
        .Disparar = ActL
        ReemplazarEtiquetas frmOP
        .Show , Me
        
        '/////////////////////////////////////
        Delay 5
       
        .cmd_Click (0)
    End With

    Unload frmOP
    Set frmOP = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Edicion
    Me.StatusBar1.Panels(3).Text = "Intento hacer un nuevo parte, pero como ya existe me trae el existente"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_CONTINUA
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_CONTINUA
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
        
        .SSTab1.Tab = 1
        CambiaDcfields frmPP, 0, KIDStock_SemiRayonViscosa
        Delay pausa
        .txtPeso = 50
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PROCESOS - Edicion
    Me.StatusBar1.Panels(3).Text = "Cambia la validacion para causar problemas en el retorcido"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPr = New frmProduccionProceso

    With frmPr
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = ID_PROC_RETORCIDO
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
    
        Delay pausa
        
        .chkIncorpora = 1
        .chkObligatorio = 1
        .chkValida = 1
        .chkValidaFinal = 1
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPr
    Set frmPr = Nothing

    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    Me.StatusBar1.Panels(3).Text = "Abro el Retorcido"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
   
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_RETORCIDO
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_CONTINUA
        Delay pausa
        
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PROCESOS - Edicion
    Me.StatusBar1.Panels(3).Text = "Cambia la validacion para repetir el parte"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPr = New frmProduccionProceso

    With frmPr
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = ID_PROC_RETORCIDO
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
    
        .chkIncorpora = 1
        .chkObligatorio = 0
        .chkValida = 1
        .chkValidaFinal = 0
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPr
    Set frmPr = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    Me.StatusBar1.Panels(3).Text = "Intento por segunda vez abrir el Retorcido y tambien me rebota"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
   
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_RETORCIDO
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_CONTINUA
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PROCESOS - Edicion
    Me.StatusBar1.Panels(3).Text = "Cambia la validacion para repetir el parte"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPr = New frmProduccionProceso

    With frmPr
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = ID_PROC_RETORCIDO
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
    
        .chkIncorpora = 1
        .chkObligatorio = 0
        .chkValida = 0
        .chkValidaFinal = 0
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPr
    Set frmPr = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    Me.StatusBar1.Panels(3).Text = "Tercer intento, como incorpora no me deja cerrarlo al Retorcido y tambien me rebota"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
   
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_RETORCIDO
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_CONTINUA
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PROCESOS - Edicion
    Me.StatusBar1.Panels(3).Text = "Cambia la validacion para repetir el parte"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPr = New frmProduccionProceso

    With frmPr
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = ID_PROC_RETORCIDO
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
    
        .chkIncorpora = 0
        .chkObligatorio = 0
        .chkValida = 0
        .chkValidaFinal = 0
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPr
    Set frmPr = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    Me.StatusBar1.Panels(3).Text = "Cuarto y ultimo intento, y cierra el Retorcido con el pesaje"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, ID_PROC_RETORCIDO
        Delay pausa
        CambiaDcfields frmPP, 8, IDMAQ_CONTINUA
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'Edicion de OP
    'Se cierra la OP
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmOP = New frmProduccionOrden

    With frmOP
        .NivelAcceso = 1 'acceso alto
        .OpcionesAcceso = 1
        .Id = IDORDEN1
        .Disparar = ActL
        ReemplazarEtiquetas frmOP
        .Show , Me
        
        '/////////////////////////////////////
       
        Delay pausa
       
        'CambiaDcfields frmPP, 15, CLng(glbIdUsuario)  'Cierrra, no sé por qué no anda con CambiaDcfields
        .dcfields(15).BoundText = CLng(glbIdUsuario)
        Delay pausa
       
        .cmd_Click (0)
        Delay pausa
   
    End With

    Unload frmOP
    Set frmOP = Nothing

    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'OP - Anulacion
    Me.StatusBar1.Panels(3).Text = "Anula la op"
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    '   Set frmOP = New frmProduccionOrden
    '   With frmOP
    '        .NivelAcceso = 9
    '        .OpcionesAcceso = 9
    '        .Id = IDORDEN1
    '        .Disparar = ActL
    '        ReemplazarEtiquetas frmOP
    '        .Show , Me
    '
    '
    '        '/////////////////////////////////////
    '
    '        delay pausa
    '       .cmd_Click (3)
    '   End With
    '   Unload frmOP
    '   Set frmOP = Nothing

    MsgBox "Fin"
End Sub

'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'Super script de OP de SemiElaborado que se engancha
' con un OP de Terminado, usando Churruca - > Fabrica, y controlando
' el etiquetado de cajas al final del terminado
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////

Private Sub mnuScriptInicializador_Click()
    'Script para usar en el testing, que prueba directamente la capa de negocios
    Dim mN
    Dim oPar As ComPronto.Parametro
    
    Dim Orden As ComPronto.ProduccionOrden
    Dim DetProduccionOrden As DetProduccionOrden
    Dim DetProduccionOrdenProceso As DetProdOrdenProceso
    
    Dim ficha As ComPronto.ProduccionFicha
    Dim DetProduccionFicha As DetProduccionFicha
    Dim DetProduccionFichaProceso As DetProdFichaProceso

    Dim PP As ComPronto.ProduccionParte
    Dim TipoCC As ControlCalidadTipo
    
    Dim OC As ComPronto.OrdenCompra
    Dim DetOC As ComPronto.DetOrdenCompra

    Dim oI As ComPronto.OtroIngresoAlmacen
    Dim DetOI As ComPronto.DetOtroIngresoAlmacen
    
    Dim RM As ComPronto.Requerimiento
    Dim DetRM As ComPronto.DetRequerimiento
    
    Dim NP As ComPronto.Pedido
    Dim DetNP As ComPronto.DetPedido

    Dim oArt As ComPronto.Articulo
    Dim oPvdr As ComPronto.Proveedor
    Dim oRbr As ComPronto.Rubro
    Dim oSubRbr As ComPronto.Subrubro
    
    Dim oUni As ComPronto.Unidad
    
    Dim rs As ADOR.Recordset
    
    'Const K_ART1 = 210
    'Const K_ART2 = 211
    
    Me.MousePointer = vbHourglass

    'InicializaConstantesDeScripts
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Dim tipo As ComPronto.tipo
    
    Set rs = Aplicacion.Tipos.TraerTodos
    
    rs.Filter = "Descripcion='Insumo'"

    If rs.EOF Then
        Set tipo = Aplicacion.Tipos.Item(-1)

        With tipo
            With .Registro
                !descripcion = "Insumo"
                !Abreviatura = "IN"
                !Codigo = "31"
                !Grupo = 2
            End With

            .Guardar
        End With

        Set tipo = Nothing
    End If
    
    rs.Filter = "Descripcion='Semielaborado'"

    If rs.EOF Then
        Set tipo = Aplicacion.Tipos.Item(-1)

        With tipo
            With .Registro
                !descripcion = "Semielaborado"
                !Abreviatura = "SE"
                !Codigo = "32"
                !Grupo = 2
            End With

            .Guardar
        End With

        Set tipo = Nothing
    End If
    
    rs.Filter = "Descripcion='Terminado'"

    If rs.EOF Then
        Set tipo = Aplicacion.Tipos.Item(-1)

        With tipo
            With .Registro
                !descripcion = "Terminado"
                !Abreviatura = "TE"
                !Codigo = "33"
                !Grupo = 2
            End With

            .Guardar
        End With

        Set tipo = Nothing
    End If

    'prefijar con _PRUEBA?
    
    'tendría que agregar algunos articulos de ejemplo. unos pares. como en el script
    ' que está en sql... -Pero si está hecho, por qué lo seguís en vb en lugar de sql?
    ' -Porque justamente quiero dejar de hacer scripts en sql, y usar los objetos

    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'Agrego el rubro de terceros
    
    'If BuscaIdRubro("Camion Sarasa") = -1 Then
    If IsNull(TraerValorParametro2("IdRubroEquiposTerceros")) Then
        
        Set oRbr = Aplicacion.Rubros.Item(-1)

        With oRbr
            With .Registro
                !descripcion = "Rubro Camiones"
                '!Codigo = "RUBCAM"
            End With

            .Guardar
            GuardarValorParametro2 "IdRubroEquiposTerceros", .Registro.Fields(0)
        End With

        Set oRbr = Nothing
    End If

    '//////////////////////////////////////////////////////////////////
    'Agrego el subrubro de terceros
    
    '    'If BuscaIdRubro("Camion Sarasa") = -1 Then
    '    If IsNull(TraerValorParametro2("IdSubrubroEquiposTerceros")) Then
    '
    '        Set oSubRbr = Aplicacion.Subrubros.Item(-1)
    '        With oSubRbr
    '            With .Registro
    '                !Descripcion = "Subrubro Camiones"
    '                !Codigo = "SUBRUBCAM"
    '            End With
    '            .Guardar
    '            GuardarValorParametro2 "IdSubrubroEquiposTerceros", .Registro.Fields(0)
    '        End With
    '        Set oSubRbr = Nothing
    '    End If

    '
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'Agrego el artículo que necesito para el script
    '
    '    Debug.Print TraerValorParametro2("IdRubroEquiposTerceros"), TraerValorParametro2("IdSubrubroEquiposTerceros")
    '
    '    If BuscaIdCamion("Camion Sarasa") = -1 Then
    '        Set oArt = Aplicacion.Articulos.Item(-1)
    '        With oArt
    '            With .Registro
    '                !Descripcion = "Camion Sarasa"
    '                !Codigo = "BFS646"
    '
    '                !IdRubro = iisNull(TraerValorParametro2("IdRubroEquiposTerceros"), "115")
    '                !IdSubRubro = iisNull(TraerValorParametro2("IdSubrubroEquiposTerceros"), 105)
    '
    '            End With
    '            .Guardar
    '        End With
    '        Set oArt = Nothing
    '    End If
    '
    '
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'Agrego el proveedor que necesito para el script
    
    If BuscaIdProveedor("ACRON SRL") = -1 Then
        Set oPvdr = Aplicacion.Proveedores.Item(-1)

        With oPvdr
            With .Registro
                .Fields("RazonSocial") = "ACRON SRL"
            End With

            .Guardar
        End With

        Set oPvdr = Nothing
    End If

    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Dim oCol As ComPronto.Color
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
   
    If BuscaIdColor("11227 Brownie") = -1 Then
        Set oCol = Aplicacion.Colores.Item(-1)

        With oCol
            With .Registro
                !descripcion = "11227 Brownie"
                !Abreviatura = "11227"
            End With

            .Guardar
        End With

        Set oCol = Nothing
    End If
    
    '//////////////////////////////////////////////////////////////////
    
    If BuscaIdColor("LW419 Celeste") = -1 Then
        Set oCol = Aplicacion.Colores.Item(-1)

        With oCol
            With .Registro
                !descripcion = "LW419 Celeste"
                !Abreviatura = "LW419"
            End With

            .Guardar
        End With

        Set oCol = Nothing
    End If
    
    '//////////////////////////////////////////////////////////////////
    
    If BuscaIdColor("1001 LC13 Terra") = -1 Then
        Set oCol = Aplicacion.Colores.Item(-1)

        With oCol
            With .Registro
                !descripcion = "1001 LC13 Terra"
                !Abreviatura = "LC13"
            End With

            .Guardar
        End With

        Set oCol = Nothing
    End If
    
    '//////////////////////////////////////////////////////////////////
    
    If BuscaIdColor("-") = -1 Then
        Set oCol = Aplicacion.Colores.Item(-1)

        With oCol
            With .Registro
                !descripcion = "-"
                !Abreviatura = "-"
            End With

            .Guardar
        End With

        Set oCol = Nothing
    End If
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
   
    If BuscaIdUnidad("Kilos") = -1 Then
        Set oUni = Aplicacion.Unidades.Item(-1)

        With oUni
            With .Registro
                !descripcion = "Kilos"
                !Abreviatura = "Kg"
            End With

            .Guardar
        End With

        Set oUni = Nothing
    End If

    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Dim oDep As ComPronto.Deposito
    Dim oUbi As ComPronto.Ubicacion
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
   
    If BuscaIdDeposito("_PRUEBA Deposito de Produccion") = -1 Then
        Set oDep = Aplicacion.Depositos.Item(-1)

        With oDep
            With .Registro
                !descripcion = "_PRUEBA Deposito de Produccion"
                !Abreviatura = "PROD"
                !IdObra = 1
            End With

            .Guardar
        End With

        Set oDep = Nothing
    End If
    
    '//////////////////////////////////////////////////////////////////
   
    If BuscaIdUbicacion("Mezcla") = -1 Then
        Set oUbi = Aplicacion.Ubicaciones.Item(-1)

        With oUbi
            With .Registro
                !descripcion = "Mezcla"
                !IdDeposito = BuscaIdDeposito("_PRUEBA Deposito de Produccion")
                
                !Estanteria = "AA"
                !Modulo = "VDC"
                !Gabeta = 4
            End With

            .Guardar
        End With

        Set oUbi = Nothing
    End If

    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'ARTICULOS
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'Agrego el artículo que necesito para el script
    
    If BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado") = -1 Then
        Set oArt = Aplicacion.Articulos.Item(-1)

        With oArt
            With .Registro
                !descripcion = "Light 1/15 A002 Crudo B Vaporizado"
                !Codigo = "LA0021/15"
                !IdRubro = 1
                !IdSubRubro = 1
            End With

            .Guardar
        End With

        Set oArt = Nothing
    End If
    
    '//////////////////////////////////////////////////////////////////
    
    If BuscaIdArticulo("Fibra de lana carbonizada Cordero Cruda 21 Mic") = -1 Then
        Set oArt = Aplicacion.Articulos.Item(-1)

        With oArt
            With .Registro
                !descripcion = "Fibra de lana carbonizada Cordero Cruda 21 Mic"
                !Codigo = "FibCrCor21Mic"
                !IdRubro = 1
                !IdSubRubro = 1
            End With

            .Guardar
        End With

        Set oArt = Nothing
    End If
    
    '//////////////////////////////////////////////////////////////////
    
    If BuscaIdArticulo("Pelo de Angora 2da nacional") = -1 Then
        Set oArt = Aplicacion.Articulos.Item(-1)

        With oArt
            With .Registro
                !descripcion = "Pelo de Angora 2da nacional"
                !Codigo = "PAng2"
                !IdRubro = 1
                !IdSubRubro = 1
            End With

            .Guardar
        End With

        Set oArt = Nothing
    End If
 
    '//////////////////////////////////////////////////////////////////
    
    If BuscaIdArticulo("Fibra de poliamida 6,6  2.2 cruda") = -1 Then
        Set oArt = Aplicacion.Articulos.Item(-1)

        With oArt
            With .Registro
                !descripcion = "Fibra de poliamida 6,6  2.2 cruda"
                !Codigo = "F6622"
                !IdRubro = 1
                !IdSubRubro = 1
            End With

            .Guardar
        End With

        Set oArt = Nothing
    End If
    
    '//////////////////////////////////////////////////////////////////
    
    If BuscaIdArticulo("Angel 16/2 SM7500 Gris topo Teñido") = -1 Then
        Set oArt = Aplicacion.Articulos.Item(-1)

        With oArt
            With .Registro
                !descripcion = "Angel 16/2 SM7500 Gris topo Teñido"
                !Codigo = "SM7500"
                !IdRubro = 1
                !IdSubRubro = 1
            End With

            .Guardar
        End With

        Set oArt = Nothing
    End If
    
    '//////////////////////////////////////////////////////////////////
    
    If BuscaIdArticulo("Agua") = -1 Then
        Set oArt = Aplicacion.Articulos.Item(-1)

        With oArt
            With .Registro
                !descripcion = "Agua"
                !Codigo = "Agua"
                !IdRubro = 1
                !IdSubRubro = 1
            End With

            .Guardar
        End With

        Set oArt = Nothing
    End If
    
    '//////////////////////////////////////////////////////////////////
    
    If BuscaIdArticulo("Soft Lambswool  1/15 Vaporizado") = -1 Then
        Set oArt = Aplicacion.Articulos.Item(-1)

        With oArt
            With .Registro
                !descripcion = "Soft Lambswool  1/15 Vaporizado"
                !Codigo = "Lambswool"
                !IdRubro = 1
                !IdSubRubro = 1
            End With

            .Guardar
        End With

        Set oArt = Nothing
    End If
    
    '//////////////////////////////////////////////////////////////////
    
    If BuscaIdArticulo("Cashmere season 8/15 CS225 Rosa capullo Teñido") = -1 Then
        Set oArt = Aplicacion.Articulos.Item(-1)

        With oArt
            With .Registro
                !descripcion = "Cashmere season 8/15 CS225 Rosa capullo Teñido"
                !Codigo = "CS225"
                !IdRubro = 1
                !IdSubRubro = 1
            End With

            .Guardar
        End With

        Set oArt = Nothing
    End If
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////

End Sub

Private Sub mnuScriptTestInofensivo_Click()
    'que debe hacer un test inofensivo? si genera rms,
    'las tiene que anular. si hago ingresos de stock...
    
End Sub

Sub lbl(s As String)
    Me.StatusBar1.Panels(3).Text = s
End Sub

Private Sub ScriptazoDeOPsQueSeEnganchan()
    InicializaConstantesDeScripts
    Dim pausa As Double
    pausa = 0.05
   
    Dim frmOP As frmProduccionOrden
    Dim frmOPDet As frmDetProduccionOrden
    Dim frmOPDetProc As frmDetProduccionOrdenProceso

    Dim frmPP As frmProduccionParte
    
    Dim frmPr As frmProduccionProceso
    
    Dim oF As Form
    
    Dim oFOCPend As frmOCsPendientes
    Dim oFOPPend As frmOPsPendientes
    
    Dim mN
    Dim oPar As ComPronto.Parametro
    
    Dim Orden As ComPronto.ProduccionOrden
    Dim DetProduccionOrden As ComPronto.DetProduccionOrden
    Dim DetProduccionOrdenProceso As ComPronto.DetProdOrdenProceso
    
    Dim ficha As ComPronto.ProduccionFicha
    Dim DetProduccionFicha As ComPronto.DetProduccionFicha
    Dim DetProduccionFichaProceso As ComPronto.DetProdFichaProceso

    Dim PP As ComPronto.ProduccionParte
    Dim TipoCC As ComPronto.ControlCalidadTipo
    
    Dim OC As ComPronto.OrdenCompra
    Dim DetOC As ComPronto.DetOrdenCompra

    Dim oI As ComPronto.OtroIngresoAlmacen
    Dim DetOI As ComPronto.DetOtroIngresoAlmacen
    
    Dim RM As ComPronto.Requerimiento
    Dim DetRM As ComPronto.DetRequerimiento
    
    Dim NP As ComPronto.Pedido
    Dim DetNP As ComPronto.DetPedido
    
    Dim SM As ComPronto.SalidaMateriales
    Dim DetSM As ComPronto.DetSalidaMateriales
    
    Dim art As ComPronto.Articulo
    
    Dim i As Long
    Dim OC1 As Long
    
    Dim NumeroOP1
    Dim NumeroOP2
    Dim NumeroOP3
    
    'prefijar con _PRUEBA?
    
    '   ahora no me debe preocupar tanto los permisos de procesos como el manejo de los
    '     consumos en los depositos
    'hay un movimiento de churruca a fabrica
    'me hacen la op
    'el parte consume lo que está en su depósito. puede ser el de fabrica, o usar uno "mezcla"
    '2 hilos se van procesando en dos mezcladoras
    'en el medio vamos viendo los cardex para confirmar los movimientos
    '1 va pasando a la carda
    'uno aventaja al otro y termina una tanda de semielaborado
    'voy abriendo otra op para generar un "terminado"
    'cuando llego al final, me fijo en la parte de terminado. va a estar deshabilitado
    'comprobar el numero de partida generado
   
    'Soft Lambswool  1/15 Vaporizado
    '
    '
    'Light 1/15 A002 Crudo B Vaporizado
    '    Fibra de lana carbonizada Cordero Cruda 21 Mic
    '    Pelo de Angora 2da nacional
    '    Pelo flandes crudo
    '    Fibra de poliamida 6,6  2.2 cruda
    '    Agua
    '
    '
    'Cashmere season 8/15 CS225 Rosa capullo Teñido
        
    mnuScriptInicializador_Click
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'creo stock para hacer los movimientos
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
   
    '///////////////////////////////////////////////
    '///////////////////////////////////////////////
    'OI - Alta (por COMPronto)
    'Creo algo de stock con OtrosIngresos
    '///////////////////////////////////////////////
    '///////////////////////////////////////////////

    Set oPar = Aplicacion.Parametros.Item(1)

    With oPar.Registro
        mN = .Fields("ProximoNumeroOtroIngresoAlmacen").Value
        .Fields("ProximoNumeroOtroIngresoAlmacen").Value = mN + 1
    End With

    oPar.Guardar
    
    Set oI = Aplicacion.OtrosIngresosAlmacen.Item(-1)

    With oI.Registro
        !NumeroOtroIngresoAlmacen = mN
        '!Cliente = Registro!Cliente
        !FechaOtroIngresoAlmacen = Date
        '!IdColor = 33
        !TipoIngreso = 4
        !IdObra = 1
        !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
    End With

    Set DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)

    With DetOI.Registro
        !IdArticulo = BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado")
        !Cantidad = 1
        !IdUnidad = BuscaIdUnidad("Kilos")
        !partida = "5646"
        !idUbicacion = BuscaIdUbicacion("Mezcla")
        !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
    End With

    DetOI.Modificado = True

    Set DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)

    With DetOI.Registro
        !IdArticulo = BuscaIdArticulo("Fibra de lana carbonizada Cordero Cruda 21 Mic")
        !Cantidad = 200
        !IdUnidad = BuscaIdUnidad("Kilos")
        !partida = "23GGG431"
        !idUbicacion = BuscaIdUbicacion("Mezcla")
        !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
    End With

    DetOI.Modificado = True
    
    Set DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)

    With DetOI.Registro
        !IdArticulo = BuscaIdArticulo("Pelo de Angora 2da nacional")
        !Cantidad = 50
        !IdUnidad = BuscaIdUnidad("Kilos")
        !partida = "AP59999"
        !idUbicacion = BuscaIdUbicacion("Mezcla")
        !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
    End With

    DetOI.Modificado = True

    Set DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)

    With DetOI.Registro
        !IdArticulo = BuscaIdArticulo("Fibra de poliamida 6,6  2.2 cruda")
        !Cantidad = 80
        !IdUnidad = BuscaIdUnidad("Kilos")
        !partida = "XRT4011"
        !idUbicacion = BuscaIdUbicacion("Mezcla")
        !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
    End With

    DetOI.Modificado = True
    
    Set DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)

    With DetOI.Registro
        !IdArticulo = BuscaIdArticulo("Angel 16/2 SM7500 Gris topo Teñido")
        !Cantidad = 80
        !IdUnidad = BuscaIdUnidad("Kilos")
        !partida = "854"
        !idUbicacion = BuscaIdUbicacion("Mezcla")
        !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
    End With

    DetOI.Modificado = True
    
    Set DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)

    With DetOI.Registro
        !IdArticulo = BuscaIdArticulo("Agua")
        !Cantidad = 80
        !IdUnidad = BuscaIdUnidad("Kilos")
        !partida = ""
        '!IdUbicacion = BuscaIdUbicacion("Mezcla")
        !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
    End With

    DetOI.Modificado = True
    
    oI.Guardar
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'OC - Alta (por COMPronto)
    'La creo usando una OC (de la que hay una ficha)
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
   
    Set oPar = Aplicacion.Parametros.Item(1)

    With oPar.Registro
        mN = .Fields("ProximoNumeroOrdenCompra").Value
        .Fields("ProximoNumeroOrdenCompra").Value = mN + 1
    End With

    oPar.Guardar
   
    Set OC = Aplicacion.OrdenesCompra.Item(-1)

    With OC.Registro
        !NumeroOrdenCompra = mN
        !IdCliente = KID_Cliente2
        !FechaOrdenCompra = Date - 2
        !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
    End With

    Set DetOC = OC.DetOrdenesCompra.Item(-1)

    With DetOC.Registro
        !FechaNecesidad = Date + 5
        !IdArticulo = BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado")
        !Cantidad = 1500
        !IdUnidad = BuscaIdUnidad("Kilos")
    
        !IdColor = BuscaIdColor("11227 Brownie")
    
    End With

    DetOC.Modificado = True
    
    Set DetOC = OC.DetOrdenesCompra.Item(-1)

    With DetOC.Registro
        !FechaNecesidad = Date + 5
        !IdArticulo = BuscaIdArticulo("Cashmere season 8/15 CS225 Rosa capullo Teñido")
        !Cantidad = 700
        !IdUnidad = BuscaIdUnidad("Kilos")
    
        !IdColor = BuscaIdColor("LW419 Celeste")
    End With

    DetOC.Modificado = True
    
    OC.Guardar
    OC1 = OC.Registro.Fields("IdOrdenCompra")
    Set OC = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'OP - Alta
    'La creo usando una OC (de la que hay una ficha)
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Set frmOP = New frmProduccionOrden

    With frmOP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmOP
        .Show , Me
        
        '/////////////////////////////////////
        Delay pausa
        
        .rchObservaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        
        '////////////////////////////////////
        '////////////////////////////////////
        Set oFOCPend = New frmOCsPendientes 'en lugar de hacer un click para llamar al form,

        'lo creo desde acá
        With oFOCPend
            .Id = "Compras"
            .FiltroArticulo = frmOP.dcfields(11).BoundText
            .Show , Me
            
            '////////////////////////////////////////
            Dim oL As ListItem

            For i = 1 To .Lista.ListItems.Count - 1
                Debug.Print .Lista.ListItems(i).SubItems(18)

                If .Lista.ListItems(i).SubItems(18) = OC1 Then
                    Set oL = .Lista.ListItems(i)
                    Exit For
                End If

            Next

            Set .Lista.SelectedItem = oL
            '///////////////////////////////////////
            
            Delay pausa * 2
            .Lista_DblClick
        End With

        .PostmodalOCPendientes oFOCPend
        '////////////////////////////////////
        '////////////////////////////////////
        
        .dcfields(11).BoundText = BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado")
        '.dcfields_Change (11)
        .dcfields_Validate 11, True
        Delay pausa
        .dcfields(20).BoundText = BuscaIdUnidad("Kilos")
        'Delay pausa
        '.dcfields(13).BoundText = BuscaIdColor("11227 Brownie")
        Delay pausa
        .txtCantidad = 2050
        
        Delay pausa
        CambiaDcfields frmOP, 1, CLng(glbIdUsuario) 'la libera
        Delay pausa
       
        'CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
       
        NumeroOP1 = .txtNumeroProduccionOrden
        .cmd_Click (0)
   
        IDORDEN1 = .mvarId '.origen.Registro.Fields(0).Value
    End With

    Unload frmOP
    Set frmOP = Nothing

    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    lbl ("Intento empezar un proceso (Continua) sin que el anterior haya empezado (Mezclado)")
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Continua")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("CONTINUA 1")
        Delay pausa
        
        .SSTab1.Tab = 3
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    ' Mezclado
    lbl ("Ahora empiezo bien 1/3")
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Mezclado")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("MEZCLA CIRCULAR")
        Delay pausa
        
        .SSTab1.Tab = 3
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
        
        .SSTab1.Tab = 1
        'CambiaDcfields frmPP, 0, BuscaIdStock("Pelo de Angora 2da nacional", "Mezcla", "AP59999") '"Deposito Mezcla")
        CambiaDcfields frmPP, 5, BuscaIdArticulo("Pelo de Angora 2da nacional")
        Delay pausa
        CambiaDcfields frmPP, 20, -1, "AP59999"
        Delay pausa
        .txtPeso = 24.1
        Delay pausa
        
        Delay pausa
        .cmd_Click (0)
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'STOCK - Consulta
    lbl ("'abro el stock para ver cuanto hay de fibra de lana antes de usar 35.1 kilos")
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    Set oF = New frmCardex

    With oF
        .Show , Me
       
        CambiaDcfields oF, 0, BuscaIdArticulo("Fibra de lana carbonizada Cordero Cruda 21 Mic")
        .Option9 = True 'elijo ubicacion
        CambiaDatacombo oF, 2, BuscaIdUbicacion("Mezcla")
    
        Delay pausa
        .cmd_Click (0)
    End With

    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'STOCK - Consulta
    lbl ("'abro el stock para ver cuanto hay de fibra de lana antes de usar 35.1 kilos")
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    'Set oF = New frmConsulta1
    'With oF
    '   .Id = BuscaIdArticulo("Fibra de lana carbonizada Cordero Cruda 21 Mic")
    '   .Show vbModal, Me
    'End With
    
    '//////////////////////////////////////////////////////////////////
    Set oF = New frmConsultaStockPorPartidas

    With oF
        .Articulo = BuscaIdArticulo("Fibra de lana carbonizada Cordero Cruda 21 Mic")
        .Show vbModal, Me
    End With
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    ' Mezclado
    lbl ("Ahora empiezo bien 2/3")
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Mezclado")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("MEZCLA CIRCULAR")
        Delay pausa
        
        .SSTab1.Tab = 3
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
        
        .SSTab1.Tab = 1
        'CambiaDcfields frmPP, 0, BuscaIdStock("Fibra de lana carbonizada Cordero Cruda 21 Mic", "Mezcla", "23GGG431")
        CambiaDcfields frmPP, 5, BuscaIdArticulo("Fibra de lana carbonizada Cordero Cruda 21 Mic")
        Delay pausa
        CambiaDcfields frmPP, 20, -1, "23GGG431"
        
        Delay pausa
        .txtPeso = 35.1
        
        Delay pausa
        .cmd_Click (0)
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'STOCK - Consulta
    lbl ("vuelvo a abrir el stock para ver cuanto hay de fibra de lana antes de usar 35.1 kilos")
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    'Set oF = New frmConsulta1
    'With oF
    '   .Id = BuscaIdArticulo("Fibra de lana carbonizada Cordero Cruda 21 Mic")
    '   .Show vbModal, Me
    'End With
    
    Set oF = New frmConsultaStockPorPartidas

    With oF
        .Articulo = BuscaIdArticulo("Fibra de lana carbonizada Cordero Cruda 21 Mic")
        .Show vbModal, Me
    End With
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    ' Mezclado
    lbl ("Ahora empiezo bien 3/3 Este queda abierto")
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Mezclado")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("MEZCLA CIRCULAR")
        Delay pausa
        
        .SSTab1.Tab = 3
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        
        Delay pausa
        .cmd_Click (0)
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    lbl ("Hago el siguiente (Cardado). Me rebota porque no cerró el mezclado")
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        '.dcfields(11).BoundText = IDORDEN1
        '.dcfields_Click 11, dbcAreaList
        '.dcfields_Validate 11, False
        '.dcfields_Change 11
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Cardado")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("CARDA 1")
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Edicion
    lbl ("Cierra el proceso Mezclado. Me tiene que saltar el mensaje de que estoy usando uno anterior")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Mezclado")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("MEZCLA CIRCULAR")
        Delay pausa
        
        .SSTab1.Tab = 3
        .TurnoFinal = DateAdd("h", 2, Date)
        Delay pausa
        
        .SSTab1.Tab = 1
        'CambiaDcfields frmPP, 0, BuscaIdStock("Fibra de lana carbonizada Cordero Cruda 21 Mic", "Mezcla", "23GGG431")
        CambiaDcfields frmPP, 5, BuscaIdArticulo("Fibra de lana carbonizada Cordero Cruda 21 Mic")
        Delay pausa
        CambiaDcfields frmPP, 20, -1, "23GGG431"
        Delay pausa
        
        .txtPeso = 50
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    lbl ("Hago el siguiente (Cardado). Ahora no me debe rebotar")
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        '.dcfields(11).BoundText = IDORDEN1
        '.dcfields_Click 11, dbcAreaList
        '.dcfields_Validate 11, False
        '.dcfields_Change 11
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Cardado")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("CARDA 1")
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing

    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    lbl ("El empleado se va y toma el lugar otro, y sigue el Cardado")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, ID_EMPLEADO2
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Cardado") 'Como no estoy esperando Fibra de lana en el Cardado
                                                            
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("CARDA 1")
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 4, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 7, Date)
        Delay pausa
        
        .SSTab1.Tab = 1
        'CambiaDcfields frmPP, 0, BuscaIdStock("Fibra de lana carbonizada Cordero Cruda 21 Mic", "Carda Produccion", "23GGG431")
        'Como no estoy esperando Fibra de lana en el Cardado, no me deja llenarlo
        CambiaDcfields frmPP, 5, BuscaIdArticulo("Fibra de lana carbonizada Cordero Cruda 21 Mic")
        Delay pausa
        CambiaDcfields frmPP, 20, -1, "23GGG431"
        Delay pausa
        
        .txtPeso = 50
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'STOCK - Ver
    lbl ("Veo el stock del semielaborado antes hacer un parte con pesaje de produccion")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
   
    Set oF = New frmConsultaStockPorPartidas

    With oF
        .Articulo = BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado")
        .Show vbModal, Me
    End With
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'PARTE - Alta
    lbl ("Agrego un parte con produccion")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Vaporizado")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("VAPORIZADOR")
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
    
        .SSTab1.Tab = 4
        Delay pausa
        CambiaDcfields frmPP, 4, BuscaIdArticulo("Fibra Borra  color    ")
        Delay pausa
        .txtCantidadDeshecho = 100
        .txtCantidadProducida = 2000
        
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'STOCK - Ver
    lbl ("Veo el stock del semielaborado DESPUES de hacer un parte con pesaje de produccion")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
   
    Set oF = New frmConsultaStockPorPartidas

    With oF
        .Articulo = BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado")
        .Show vbModal, Me
    End With
   
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'Edicion de OP
    'Se cierra la OP
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmOP = New frmProduccionOrden

    With frmOP
        .NivelAcceso = 1 'acceso alto
        .OpcionesAcceso = 1
        .Id = IDORDEN1
        .Disparar = ActL
        ReemplazarEtiquetas frmOP
        .Show , Me
        
        '/////////////////////////////////////
       
        Delay pausa
       
        'CambiaDcfields frmPP, 15, CLng(glbIdUsuario)  'Cierrra, no sé por qué no anda con CambiaDcfields
        .dcfields(15).BoundText = CLng(glbIdUsuario)
        'Delay pausa
       
        MsgBox "Haga click en aceptar para continuar"
        .cmd_Click (0)
        Delay pausa
   
    End With

    Unload frmOP
    Set frmOP = Nothing

    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'OP - Anulacion
    lbl ("Anula la op")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    '   Set frmOP = New frmProduccionOrden
    '   With frmOP
    '        .NivelAcceso = 9
    '        .OpcionesAcceso = 9
    '        .Id = IDORDEN1
    '        .Disparar = ActL
    '        ReemplazarEtiquetas frmOP
    '        .Show , Me
    '
    '
    '        '/////////////////////////////////////
    '
    '        delay pausa
    '       .cmd_Click (3)
    '   End With
    '   Unload frmOP
    '   Set frmOP = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'OP - Alta
    lbl ("OP del 2do Semielaborado. La creo usando una Ficha")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Set frmOP = New frmProduccionOrden

    With frmOP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmOP
        .Show , Me
        
        '/////////////////////////////////////
        Delay pausa
        .dcfields(11).BoundText = BuscaIdArticulo("Soft Lambswool  1/15 Vaporizado")
        '.dcfields_Change (11)
        .dcfields_Validate 11, True
        Delay pausa
        .dcfields(20).BoundText = BuscaIdUnidad("Kilos")
        Delay pausa
        CambiaDcfields frmOP, 13, BuscaIdColor("-")
        Delay pausa
        .txtCantidad = 1300
       
        CambiaDcfields frmOP, 1, CLng(glbIdUsuario) 'la libera
        Delay pausa
       
        NumeroOP2 = .txtNumeroProduccionOrden
        .cmd_Click (0)
   
        IDORDEN2 = .mvarId '.origen.Registro.Fields(0).Value
    End With

    Unload frmOP
    Set frmOP = Nothing
   
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    ' Mezclado
    lbl ("Ahora empiezo bien 1/3")
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN2
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Mezclado")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("MEZCLA CIRCULAR")
        Delay pausa
        
        .SSTab1.Tab = 3
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
        
        .SSTab1.Tab = 1
        'CambiaDcfields frmPP, 0, BuscaIdStock("Pelo de Angora 2da nacional", "Mezcla", "AP59999") '"Deposito Mezcla")
        CambiaDcfields frmPP, 5, BuscaIdArticulo("Angel 16/2 SM7500 Gris topo Teñido")
        Delay pausa
        CambiaDcfields frmPP, 20, -1, "854"
        Delay pausa
        .txtPeso = 24.1
        Delay pausa
        
        Delay pausa
        .cmd_Click (0)
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'PARTE - Alta
    lbl ("Agrego un parte con produccion")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN2
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Mezclado")
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
    
        .SSTab1.Tab = 4
        Delay pausa
        CambiaDcfields frmPP, 4, BuscaIdArticulo("Fibra Borra  color    ")
        Delay pausa
        .txtCantidadDeshecho = 100
        .txtCantidadProducida = 900
        
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'SM - Alta (ComPronto)
    lbl ("SM a Fabrica de los dos Semielaborados (esto lo debe hacer el usuario manualmente)")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
         
    With oPar.Registro
        mN = .Fields("ProximoNumeroSalidaMateriales").Value
        .Fields("ProximoNumeroSalidaMateriales").Value = mN + 1
    End With

    oPar.Guardar
        
    Set SM = Aplicacion.SalidasMateriales.Item(-1)

    With SM.Registro
        !NumeroSalidaMateriales = mN
        !TipoSalida = 1 'Salida a Fabrica
        !Cliente = ""
        !FechaSalidaMateriales = Date
        !IdObra = TraerValorParametro2("IdObraDefault")
        !Observaciones = "MODULO PRODUCCION: Creado por Script"
        
        !Emitio = glbIdUsuario
        !Aprobo = glbIdUsuario
    End With
            
    Set DetSM = SM.DetSalidasMateriales.Item(-1)

    With DetSM
        .Registro!IdArticulo = BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado")
        .Registro!Cantidad = 1000
        .Registro!IdUnidad = BuscaIdUnidad("Kilos")
        .Registro!IdStock = BuscaIdStock("Light 1/15 A002 Crudo B Vaporizado", , Trim(Str(NumeroOP1)))
        .Registro!partida = NumeroOP1
        .Registro!idUbicacion = BuscaIdUbicacion("Mezcla")
        .Registro!Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
             
        .Registro!IdObra = TraerValorParametro2("IdObraDefault")
             
        Set art = Aplicacion.Articulos.Item(BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado"))
        .Registro!CostoUnitario = iisNull(art.Registro!CostoReposicion, 0)
        .Registro!Adjunto = "NO"
        '.Registro!CotizacionDolar = Cotizacion(Date, IdMonedaDolar)
        .Registro!IdMoneda = oPar.Registro!IdMoneda.Value
    End With

    DetSM.Modificado = True
            
    Set DetSM = SM.DetSalidasMateriales.Item(-1)

    With DetSM
        .Registro!IdArticulo = BuscaIdArticulo("Soft Lambswool  1/15 Vaporizado")
        .Registro!Cantidad = 800
        .Registro!IdUnidad = BuscaIdUnidad("Kilos")
        .Registro!IdStock = BuscaIdStock("Soft Lambswool  1/15 Vaporizado", , Trim(Str(NumeroOP2)))
        .Registro!partida = NumeroOP2
        .Registro!idUbicacion = BuscaIdUbicacion("Mezcla")
        .Registro!Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
             
        .Registro!IdObra = TraerValorParametro2("IdObraDefault")
             
        Set art = Aplicacion.Articulos.Item(BuscaIdArticulo("Soft Lambswool  1/15 Vaporizado"))
        .Registro!CostoUnitario = iisNull(art.Registro!CostoReposicion, 0)
        .Registro!Adjunto = "NO"
        '.Registro!CotizacionDolar = Cotizacion(Date, IdMonedaDolar)
        .Registro!IdMoneda = oPar.Registro!IdMoneda.Value
    End With

    DetSM.Modificado = True
        
    SM.Guardar
        
    '///////////////////////////////////////////////
    '///////////////////////////////////////////////
    'OI - Alta (por COMPronto)
    lbl ("OI de lo que saqué con las SM a Fabrica de los dos Semielaborados")
    '///////////////////////////////////////////////
    '///////////////////////////////////////////////
    
    Set oPar = Aplicacion.Parametros.Item(1)

    With oPar.Registro
        mN = .Fields("ProximoNumeroOtroIngresoAlmacen").Value
        .Fields("ProximoNumeroOtroIngresoAlmacen").Value = mN + 1
    End With

    oPar.Guardar
        
    Set oI = Aplicacion.OtrosIngresosAlmacen.Item(-1)

    With oI.Registro
        !NumeroOtroIngresoAlmacen = mN
        '!Cliente = Registro!Cliente
        !FechaOtroIngresoAlmacen = Date
        '!IdColor = 33
        !TipoIngreso = 4
        !IdObra = 1
        !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
    End With
        
    Set DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)

    With DetOI.Registro
        !IdArticulo = BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado")
        !Cantidad = 1000
        !IdUnidad = BuscaIdUnidad("Kilos")
        !partida = NumeroOP1
        !idUbicacion = BuscaIdUbicacion("Mezcla")
        !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
    End With

    DetOI.Modificado = True
        
    Set DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)

    With DetOI.Registro
        !IdArticulo = BuscaIdArticulo("Soft Lambswool  1/15 Vaporizado")
        !Cantidad = 800
        !IdUnidad = BuscaIdUnidad("Kilos")
        !partida = NumeroOP2
        !idUbicacion = BuscaIdUbicacion("Mezcla")
        !Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
    End With

    DetOI.Modificado = True
        
    oI.Guardar
        
    MsgBox "Haga click en aceptar para continuar"
       
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
       
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'OP - Alta
    lbl ("OP del Terminado. La creo usando una Ficha")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Set frmOP = New frmProduccionOrden

    With frmOP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmOP
        .Show , Me
        
        '/////////////////////////////////////
        Delay pausa
        .dcfields(11).BoundText = BuscaIdArticulo("Cashmere season 8/15 CS225 Rosa capullo Teñido")
        '.dcfields_Change (11)
        .dcfields_Validate 11, True
        Delay pausa
        .dcfields(20).BoundText = BuscaIdUnidad("Kilos")
        Delay pausa
        CambiaDcfields frmOP, 13, BuscaIdColor("1001 LC13 Terra")
        Delay pausa
        .txtCantidad = 1300
       
        CambiaDcfields frmOP, 1, CLng(glbIdUsuario) 'la libera
        Delay pausa
   
        NumeroOP3 = .txtNumeroProduccionOrden
       
        .cmd_Click (0)
       
        IDORDEN3 = .mvarId '.origen.Registro.Fields(0).Value
    End With

    Unload frmOP
    Set frmOP = Nothing
   
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    ' Mezclado
    lbl ("Ahora empiezo bien 1/3")
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN3
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Mezclado")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("MEZCLA CIRCULAR")
        Delay pausa
        
        .SSTab1.Tab = 3
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
        
        .SSTab1.Tab = 1
        'CambiaDcfields frmPP, 0, BuscaIdStock("Pelo de Angora 2da nacional", "Mezcla", "AP59999") '"Deposito Mezcla")
        CambiaDcfields frmPP, 5, BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado")
        Delay pausa
        CambiaDcfields frmPP, 20, -1, Trim(Str(NumeroOP1))
        Delay pausa
        .txtPeso = 500
        Delay pausa
        
        Delay pausa
        .cmd_Click (0)
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    ' Mezclado
    lbl ("Ahora empiezo bien 1/3")
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN3
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Mezclado")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("MEZCLA CIRCULAR")
        Delay pausa
        
        .SSTab1.Tab = 3
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
        
        .SSTab1.Tab = 1
        'CambiaDcfields frmPP, 0, BuscaIdStock("Pelo de Angora 2da nacional", "Mezcla", "AP59999") '"Deposito Mezcla")
        CambiaDcfields frmPP, 5, BuscaIdArticulo("Soft Lambswool  1/15 Vaporizado")
        Delay pausa
        CambiaDcfields frmPP, 20, -1, Trim(Str(NumeroOP2))
        Delay pausa
        .txtPeso = 300
        Delay pausa
        
        Delay pausa
        .cmd_Click (0)
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'UnidadesEmpaque - Alta (por COMPronto)
    lbl ("Caja.La creo a traves del Compronto")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Dim UnidadEmpaque As ComPronto.UnidadEmpaque
    
    'está haciendo el ajuste este objeto?
    
    Set UnidadEmpaque = Aplicacion.UnidadesEmpaque.Item(-1)

    With UnidadEmpaque

        'GuardarValorParametro2 "ProximoNumeroCajaStock", "" & (mNumeroCaja1 + 1)

        With .Registro

            '!NumeroUnidad?
            
            !partida = NumeroOP3
            !IdArticulo = BuscaIdArticulo("Cashmere season 8/15 CS225 Rosa capullo Teñido")
            !IdColor = BuscaIdColor("1001 LC13 Terra")
            '!IdUbicacion = BuscaId("")
            
            !PesoNeto = 100
            !Tara = 1
            !PesoBruto = !PesoNeto + !Tara
            
            '!Observaciones = "_PRUEBA Creado para Testing de Modulo de Produccion"
        End With

        .Guardar
    End With

    Set UnidadEmpaque = Nothing
    
    MsgBox "Acabo de emitir una caja. Ahora veré cuanto hay terminado en la op"
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'STOCK
    lbl ("Confirmo que no haya incrementado el stock de terminado")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
   
    Set oF = New frmConsultaStockPorPartidas

    With oF
        .Articulo = BuscaIdArticulo("Cashmere season 8/15 CS225 Rosa capullo Teñido")
        .Show vbModal, Me
    End With
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'OP - Edicion
    lbl ("Reviso cuanto terminado hay. La cierro")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    'STOCK
    lbl ("Confirmo que no haya incrementado el stock de terminado")
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
   
    Set oF = New frmConsultaStockPorPartidas

    With oF
        .Articulo = BuscaIdArticulo("Cashmere season 8/15 CS225 Rosa capullo Teñido")
        .Show vbModal, Me
    End With
   
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'Edicion de OP
    'Se cierra la OP
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmOP = New frmProduccionOrden

    With frmOP
        .NivelAcceso = 1 'acceso alto
        .OpcionesAcceso = 1
        .Id = IDORDEN2
        .Disparar = ActL
        ReemplazarEtiquetas frmOP
        .Show , Me
        
        '/////////////////////////////////////
       
        Delay pausa
       
        'CambiaDcfields frmPP, 15, CLng(glbIdUsuario)  'Cierrra, no sé por qué no anda con CambiaDcfields
        .dcfields(15).BoundText = CLng(glbIdUsuario)
        'Delay pausa
       
        MsgBox "Haga click en aceptar para continuar"
        .cmd_Click (0)
        Delay pausa
   
    End With

    Unload frmOP
    Set frmOP = Nothing
     
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'Edicion de OP
    'Se cierra la OP
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmOP = New frmProduccionOrden

    With frmOP
        .NivelAcceso = 1 'acceso alto
        .OpcionesAcceso = 1
        .Id = IDORDEN3
        .Disparar = ActL
        ReemplazarEtiquetas frmOP
        .Show , Me
        
        '/////////////////////////////////////
       
        Delay pausa
       
        'CambiaDcfields frmPP, 15, CLng(glbIdUsuario)  'Cierrra, no sé por qué no anda con CambiaDcfields
        .dcfields(15).BoundText = CLng(glbIdUsuario)
        'Delay pausa
       
        MsgBox "Haga click en aceptar para continuar"
        .cmd_Click (0)
        Delay pausa
   
    End With

    Unload frmOP
    Set frmOP = Nothing
 
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'TRAZA - Consulta
    lbl ("Me traigo la trazabilidad de la OP del Terminado, que debe incluir los dos semielaborados     ")
    '//////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    
    Dim oFTraza As frmConsultaTrazabilidad
    Set oFTraza = New frmConsultaTrazabilidad

    With oFTraza
        .partida = NumeroOP3
        .dcfields(11) = NumeroOP3
        .OptAscendencia(0) = True
        .OptAscendencia(1) = False
        .Form_Load
       
        .Show vbModal, Me
    End With

    Set oFTraza = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
   
    If MsgBox("Continuar con sector de Validaciones?", vbYesNo) = vbNo Then Exit Sub
   
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
   
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    lbl ("Informa un Paro")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Continua")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("CONTINUA 1")
        Delay pausa
        
        .SSTab1.Tab = 0
        .Fecha = Date + 2
        .txtCausaParo = "Problema Mecánico"
        .ParoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .ParoFinal = DateAdd("h", 2, Date)
        Delay pausa
        
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    lbl ("Informa otro Paro. Pero todavia en esta version no se pueden repetir, así que se queja")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Continua")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("CONTINUA 1")
        Delay pausa
        
        .SSTab1.Tab = 0
        .txtCausaParo = "Problema Mecánico"
        .ParoInicio = DateAdd("h", -2, Now)
        Delay pausa
        .ParoFinal = DateAdd("m", -20, Now)
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing

    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Edicion
    lbl ("Informa un Control de Calidad")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Continua")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("CONTINUA 1")
        Delay pausa
        
        .SSTab1.Tab = 2
        
        CambiaDcfields frmPP, 3, 1 'reemplazar por IDTIPOCONTROLCALIDAD
        Delay pausa
        
        .txtMaximo(0) = 2.4
        
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'OP - Edicion
    lbl ("Nada más para ver los avances de los procesos")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    Set frmOP = New frmProduccionOrden

    With frmOP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = IDORDEN1
        .Disparar = ActL
        ReemplazarEtiquetas frmOP
        .Show , Me
        
        '/////////////////////////////////////
        'Delay 5
        MsgBox "Haga click en aceptar para continuar"
        .cmd_Click (0)
    End With

    Unload frmOP
    Set frmOP = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Edicion
    lbl ("Intento hacer un nuevo parte, pero como ya existe me trae el existente")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Continua")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("CONTINUA 1")
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
        
        .SSTab1.Tab = 1
        'CambiaDcfields frmPP, 0, BuscaIdStock("Fibra de lana carbonizada Cordero Cruda 21 Mic", , "23GGG431")
        CambiaDcfields frmPP, 5, BuscaIdArticulo("Fibra de lana carbonizada Cordero Cruda 21 Mic")

        Delay pausa
        .txtPeso = 50
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PROCESOS - Edicion
    lbl ("Cambia la validacion para causar problemas en el retorcido")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPr = New frmProduccionProceso

    With frmPr
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = BuscaIdProceso("Vaporizado")
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
    
        Delay pausa
        
        .chkIncorpora = 1
        .chkObligatorio = 1
        .chkValida = 1
        .chkValidaFinal = 1
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPr
    Set frmPr = Nothing

    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    lbl ("Abro el Retorcido")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
   
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Vaporizado")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("VAPORIZADOR")
        Delay pausa
        
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PROCESOS - Edicion
    lbl ("Cambia la validacion para repetir el parte")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPr = New frmProduccionProceso

    With frmPr
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = BuscaIdProceso("Vaporizado")
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
    
        .chkIncorpora = 1
        .chkObligatorio = 0
        .chkValida = 1
        .chkValidaFinal = 0
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPr
    Set frmPr = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    lbl ("Intento por segunda vez abrir el Retorcido y tambien me rebota")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
   
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Vaporizado")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("VAPORIZADOR")
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PROCESOS - Edicion
    lbl ("Cambia la validacion para repetir el parte")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPr = New frmProduccionProceso

    With frmPr
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = BuscaIdProceso("Vaporizado")
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
    
        .chkIncorpora = 1
        .chkObligatorio = 0
        .chkValida = 0
        .chkValidaFinal = 0
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPr
    Set frmPr = Nothing
    
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    lbl ("Tercer intento, como incorpora no me deja cerrarlo al Retorcido y tambien me rebota")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
   
    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Vaporizado")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("VAPORIZADOR")
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PROCESOS - Edicion
    lbl ("Cambia la validacion para repetir el parte")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPr = New frmProduccionProceso

    With frmPr
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = BuscaIdProceso("Vaporizado")
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
    
        .chkIncorpora = 0
        .chkObligatorio = 0
        .chkValida = 0
        .chkValidaFinal = 0
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPr
    Set frmPr = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////
    'PARTE - Alta
    lbl ("Cuarto y ultimo intento, y cierra el Retorcido con el pesaje")
    '//////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////

    Set frmPP = New frmProduccionParte

    With frmPP
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = -1
        .Disparar = ActL
        ReemplazarEtiquetas frmPP
        .Show , Me
        '/////////////////////////////////////
        Delay pausa
        CambiaDcfields frmPP, 2, CLng(glbIdUsuario)
        Delay pausa
        
        CambiaDcfields frmPP, 11, IDORDEN1
        Delay pausa
        CambiaDcfields frmPP, 1, BuscaIdProceso("Vaporizado")
        'Delay pausa
        'CambiaDcfields frmPP, 8, BuscaIdMaquina("VAPORIZADOR")
        Delay pausa
        
        .SSTab1.Tab = 3
        .Fecha = Date + 2
        Delay pausa
        .TurnoInicio = DateAdd("h", 2, Date)
        Delay pausa
        .TurnoFinal = DateAdd("h", 4, Date)
        Delay pausa
    
        Delay pausa
        .cmd_Click (0)
        
    End With

    Unload frmPP
    Set frmPP = Nothing
   
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////
    MsgBox "Fin"
End Sub

Private Sub Importador_Click()
    Dim DOCPATH As String
    Dim INIRENGLON As Long
    Dim FINRENGLON As Long
    Dim CurrentRow As Long

    Dim appExcel As Excel.Application
    Dim wk As Excel.Workbook
    Dim wh As Excel.Worksheet
    
    Dim oArt As ComPronto.Articulo
    
    DOCPATH = "\doc\electrochance\gonza Maquinarias.xls"
    INIRENGLON = 4
    FINRENGLON = 2265
    
    K_UN1 = BuscaIdUnidad("Unidad")
    
    'Hacer funcion que descule cual es el campo que tira errores
    
    Set appExcel = New Excel.Application
    Set wk = appExcel.Workbooks.Open(app.Path & DOCPATH)
    'OpenCN cn, False, "", cConexionBASE             'Abrir conexion
    Set wh = wk.Worksheets(1)
    
    CurrentRow = INIRENGLON
    'While wh.Cells(CurrentRow, 1) <> "FIN"
    While CurrentRow < FINRENGLON
        
        Debug.Print CurrentRow, wh.Cells(CurrentRow, "F")

        If wh.Cells(CurrentRow, "F") <> "" Then
             
            '///////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////
            'Creacion de Articulo
            '///////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////
            If BuscaIdArticulo(wh.Cells(CurrentRow, "F")) = -1 Then
                Set oArt = Aplicacion.Articulos.Item(-1)

                With oArt
                    With .Registro

                        If wh.Cells(CurrentRow, "E") <> "" Then
                            !Codigo = wh.Cells(CurrentRow, "E")
                            !Idtipo = 13
                        ElseIf wh.Cells(CurrentRow, "D") <> "" Then
                            !Codigo = wh.Cells(CurrentRow, "D")
                            !Idtipo = 12
                        ElseIf wh.Cells(CurrentRow, "C") <> "" Then
                            !Codigo = wh.Cells(CurrentRow, "C")
                            !Idtipo = 11
                        ElseIf wh.Cells(CurrentRow, "B") <> "" Then
                            !Codigo = wh.Cells(CurrentRow, "B")
                            !Idtipo = 10
                        Else
                            Stop
                        End If
                        
                        !descripcion = wh.Cells(CurrentRow, "F")
                        !IdRubro = 2
                        !IdSubRubro = 1
                    End With

                    .Guardar
                End With

                Set oArt = Nothing
            Else
                'Stop
            End If

            '///////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////
        Else
            'Stop
        End If
        
        CurrentRow = CurrentRow + 1

        'txtROW = CurrentRow
        If CurrentRow Mod 1000 = 0 Then DoEvents
    Wend
    
    wk.Close
    MsgBox "fin"
   
End Sub

'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////

Private Sub Importador2_Click()
    
    ImportaFichaElectrochancePorMargen (46)
    ImportaFichaElectrochancePorMargen (35)
    ImportaFichaElectrochancePorMargen (24)
    ImportaFichaElectrochancePorMargen (14)
    ImportaFichaElectrochancePorMargen (5)

End Sub

Sub ImportaFichaElectrochancePorMargen(margen As Integer)
    Dim DOCPATH As String
    Dim INIRENGLON As Long
    Dim FINRENGLON As Long
    Dim CurrentRow As Long

    Dim ficha As ComPronto.ProduccionFicha
    Dim DetProduccionFicha As ComPronto.DetProduccionFicha
    Dim DetProduccionFichaProceso As ComPronto.DetProdFichaProceso
   
    Dim appExcel As Excel.Application
    Dim wk As Excel.Workbook
    Dim wh As Excel.Worksheet
   
    DOCPATH = "\doc\electrochance\original RM+12 PG6 PREMIUM.XLS"
    INIRENGLON = 5
    FINRENGLON = 2257
    
    'Hacer funcion que descule cual es el campo que tira errores
    
    K_UN1 = BuscaIdUnidad("Unidad")
    
    Set appExcel = New Excel.Application
    Set wk = appExcel.Workbooks.Open(app.Path & DOCPATH)
    Set wh = wk.Worksheets(1)
    
    CurrentRow = INIRENGLON
    While CurrentRow < FINRENGLON
        
        'Debug.Print CurrentRow, wh.Cells(CurrentRow, "B")
        'If CurrentRow = 1500 Then Stop
        If InStr(wh.Cells(CurrentRow, "B"), "Fórmula") <> 0 Then
            'Debug.Print InStr(wh.Cells(CurrentRow, "B"), "Fórmula")
            'Stop
        End If
        
        Dim descripcion As String
        descripcion = mId$(wh.Cells(CurrentRow - 1, "B"), InStr(wh.Cells(CurrentRow - 1, "B"), ")") + 1)
            
        If InStr(wh.Cells(CurrentRow, "B"), "Fórmula") = margen Then 'empieza una formula en la fila que viene
                
            If AplicacionProd.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", Array(BuscaIdArticulo(descripcion), 0)).RecordCount = 0 Then
                
                Set ficha = AplicacionProd.ProduccionFichas.Item(-1)

                With ficha.Registro
                        
                    !IdArticuloAsociado = BuscaIdArticulo(descripcion)
                        
                    If !IdArticuloAsociado = -1 Then
                        Debug.Print CurrentRow, descripcion
                        Debug.Print "descripcion=""" & descripcion & """"
                        Stop
                    End If
                        
                    !Codigo = ""
                    !descripcion = left(descripcion, 50)
                    !Cantidad = 1
                    !IdUnidad = K_UN1
                    !Minimo = 1
                    Debug.Print CurrentRow & " FICHA " & !descripcion
                    
                End With
                        
                CurrentRow = CurrentRow + 1
                Dim margen2 As Integer
                margen2 = InStr(wh.Cells(CurrentRow, "B"), "(")
                Dim margen3 As Integer
                margen3 = 0

                Do While InStr(wh.Cells(CurrentRow, "B"), "(") >= margen2 Or InStr(wh.Cells(CurrentRow, "B"), "Fórmula") > 0
                        
                    If InStr(wh.Cells(CurrentRow - 1, "B"), "Fórmula") Then
                        If margen3 = 0 Then
                            margen3 = InStr(wh.Cells(CurrentRow - 1, "B"), "Fórmula")
                        Else

                            If margen3 = InStr(wh.Cells(CurrentRow - 1, "B"), "Fórmula") Then Exit Do '2° formula
                        End If
                    End If
                        
                    If InStr(wh.Cells(CurrentRow, "B"), "(") = margen2 Then
                        Set DetProduccionFicha = ficha.DetProduccionFichas.Item(-1)

                        With DetProduccionFicha.Registro
                            !IdArticulo = BuscaIdArticulo(mId$(wh.Cells(CurrentRow, "B"), InStr(wh.Cells(CurrentRow, "B"), ") ") + 1))
                            !Cantidad = wh.Cells(CurrentRow, "C")
                            !IdUnidad = K_UN1
                            Debug.Print "   ", !IdArticulo, mId$(wh.Cells(CurrentRow, "B"), InStr(wh.Cells(CurrentRow, "B"), ") ") + 1)
                        
                        End With

                        If DetProduccionFicha.Registro!IdArticulo <> -1 Then DetProduccionFicha.Modificado = True
                    Else
                        'Stop
                    End If

                    CurrentRow = CurrentRow + 1
                Loop
                    
                Set DetProduccionFichaProceso = ficha.DetProduccionFichasProcesos.Item(-1)

                With DetProduccionFichaProceso.Registro
                    !IdProduccionProceso = BuscaIdProceso("Mezclado")
                    !Horas = 1
                End With

                DetProduccionFichaProceso.Modificado = True
                    
                Set DetProduccionFichaProceso = ficha.DetProduccionFichasProcesos.Item(-1)

                With DetProduccionFichaProceso.Registro
                    !IdProduccionProceso = BuscaIdProceso("Cardado")
                    !Horas = 1
                End With

                DetProduccionFichaProceso.Modificado = True
                    
                ficha.Guardar
                IDFICHA1 = ficha.Registro.Fields("IdProduccionFicha")
                Set ficha = Nothing
            
            Else
                Debug.Print CurrentRow, descripcion
                'Stop
            End If
        End If
             
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////

        CurrentRow = CurrentRow + 1

        'txtROW = CurrentRow
        If CurrentRow Mod 1000 = 0 Then DoEvents
    Wend

    wk.Close
    MsgBox "fin"
End Sub

Private Sub txtBuscador_KeyDown(KeyCode As Integer, _
                                Shift As Integer)

    If KeyCode = 13 Then
        BuscadorCambio
    End If

End Sub

Private Sub txtBuscador_KeyUp(KeyCode As Integer, _
                              Shift As Integer)
    BuscadorCambio
End Sub

Private Sub txtBuscador_Scroll()
    BuscadorCambio
End Sub

Private Sub txtBuscador_Change()
    BuscadorCambio
End Sub

Sub BuscadorCambio()

    If txtBuscador = "Nuevo Parte" Then
        NuevoParte
    End If

    Arbol_NodeClick Arbol.SelectedItem
End Sub

Private Sub txtBuscador_GotFocus()
    'txtBuscador.SetFocus
    txtBuscador.SelStart = 0
    txtBuscador.SelLength = Len(txtBuscador)
         
    'txtBuscador.s
    ' SendKeys "^{LEFT}+^{RIGHT}"
    ' DoEvents
End Sub

Private Sub cmdCrearOP_Click(Index As Integer)
    Dim oF As Form

    Set oF = New frmProduccionOrden

    With oF
        .NivelAcceso = frmPrincipal.ControlAccesoNivel("OrdendeProduccion")
        .OpcionesAcceso = frmPrincipal.ControlAccesoOpciones("OrdendeProduccion")

        .Id = -1

        If Not glbPermitirModificacionTabulados Then
            If ExisteControlEnFormulario(oF, "lblTabIndex") Then
                .lblTabIndex.Visible = False
            End If
        End If

        .Disparar = ActL
        Me.MousePointer = vbDefault
        .Show , Me
    End With

Salida:
    'Unload oF

    Set oF = Nothing

    Me.MousePointer = vbDefault
End Sub

Sub NuevoParte()
    EditarParte (-1)
End Sub

Sub EditarParte(Id)

    Dim oF As frmProduccionParte

    Set oF = New frmProduccionParte

    With oF
        .NivelAcceso = frmPrincipal.ControlAccesoNivel("PartedeProduccion")
        .OpcionesAcceso = frmPrincipal.ControlAccesoOpciones("PartedeProduccion")

        .Id = Id

        '      If Not glbPermitirModificacionTabulados Then
        '         If ExisteControlEnFormulario(oF, "lblTabIndex") Then
        '            .lblTabIndex.Visible = False
        '         End If
        '      End If
        If oF.habilitado Then
            .Disparar = ActL
            Me.MousePointer = vbDefault
            .Show , Me
        Else
            
            Unload oF
        
        End If

    End With

Salida:

    Set oF = Nothing

    Me.MousePointer = vbDefault
End Sub

Sub RefrescarConsultas()
    Dim Desde, Hasta

    Desde = Now - 30
    Hasta = Now

    Dim oRs As Recordset

    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////

    Set oRs = AplicacionProd.ProduccionPartes.TraerTodos

    oRs.Filter = "ESTADO='ABIERTO'"
    
    listaPartes.ListItems.Clear

    'If Not mOrdena Then Lista.Sorted = False
    If Not IsEmpty(oRs) And Not oRs Is Nothing Then
        Set listaPartes.DataSource = oRs
        listaPartes.Refresh
    End If

    listaPartes.FullRowSelect = True

    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////

    Set oRs = AplicacionProd.ProduccionOrdenes.TraerTodos

    oRs.Filter = "ESTADO='ABIERTA' OR ESTADO='EN EJECUCION'"

    listaOPs.ListItems.Clear

    'If Not mOrdena Then Lista.Sorted = False
    If Not IsEmpty(oRs) And Not oRs Is Nothing Then
        Set listaOPs.DataSource = oRs
        listaOPs.Refresh
    End If

    listaOPs.FullRowSelect = True

    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////

    'Filtrar:  que el botón OCs muestre las OCs que corresponden para el Material o Terminado a evaluar, idem para las OPs.
    'Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_ItemsPendientesDeProducirModuloProduccion", Array(Val(FiltroArticulo), Val(FiltroMaterial)))
    Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_ItemsPendientesDeProducirModuloProduccion", Array(-1, -1))

    listaOCsinOP.ListItems.Clear

    'If Not mOrdena Then Lista.Sorted = False
    If Not IsEmpty(oRs) And Not oRs Is Nothing Then
        Set listaOCsinOP.DataSource = oRs
        listaOCsinOP.Refresh
    End If

    listaOCsinOP.FullRowSelect = True

    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////

    Set oRs = TraerRecordsetConLosProcesosPendientes(AplicacionProd)

    listaProcesosPendientes.ListItems.Clear

    'If Not mOrdena Then Lista.Sorted = False
    If Not IsEmpty(oRs) And Not oRs Is Nothing Then
        Set listaProcesosPendientes.DataSource = oRs
        listaProcesosPendientes.Refresh
    End If

    listaProcesosPendientes.FullRowSelect = True

    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////

    Set oRs = AplicacionProd.ProduccionFichas.TraerTodos

    listaFichas.ListItems.Clear

    'If Not mOrdena Then Lista.Sorted = False
    If Not IsEmpty(oRs) And Not oRs Is Nothing Then
        Set listaFichas.DataSource = oRs
        listaFichas.Refresh
    End If

    listaFichas.FullRowSelect = True

End Sub

Private Sub listaOPs_DblClick()
    Dim oF As Form

    If listaOPs.SelectedItem Is Nothing Then Exit Sub
    If Len(Trim(listaOPs.SelectedItem.Tag)) = 0 Then Exit Sub

    Set oF = New frmProduccionOrden

    With oF
        .NivelAcceso = 9
        .OpcionesAcceso = 9
        .Id = listaOPs.SelectedItem.Tag

        If Not glbPermitirModificacionTabulados Then
            If ExisteControlEnFormulario(oF, "lblTabIndex") Then
                .lblTabIndex.Visible = False
            End If
        End If

        ReemplazarEtiquetas oF
        Me.MousePointer = vbDefault
        .Show , Me
    End With

End Sub

Private Sub listaPartes_DblClick()

    If Not listaPartes.SelectedItem Is Nothing Then
        If Len(Trim(listaPartes.SelectedItem.Tag)) <> 0 Then
            Dim oF As Form

            Set oF = New frmProduccionParte

            With oF
                .NivelAcceso = 9
                .OpcionesAcceso = 9
                .Id = listaPartes.SelectedItem.Tag

                If Not glbPermitirModificacionTabulados Then
                    If ExisteControlEnFormulario(oF, "lblTabIndex") Then
                        .lblTabIndex.Visible = False
                    End If
                End If

                Me.MousePointer = vbDefault

                If oF.habilitado Then
       
                    .Show , Me
                End If

            End With

Salida:

            Set oF = Nothing

            Me.MousePointer = vbDefault
        End If
    End If

End Sub

