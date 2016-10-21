VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.3#0"; "Controles1013.ocx"
Object = "{BE38695A-739A-4A6C-BF54-931FC1415984}#1.0#0"; "VividThumbNails.ocx"
Begin VB.Form frmArticulos 
   Caption         =   "Articulos"
   ClientHeight    =   8355
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10935
   Icon            =   "frmArticulos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8355
   ScaleWidth      =   10935
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "Agregar documentos"
      Height          =   360
      Index           =   8
      Left            =   1800
      TabIndex        =   27
      Top             =   1485
      Width           =   1695
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Agregar imagenes"
      Height          =   360
      Index           =   7
      Left            =   45
      TabIndex        =   26
      Top             =   1485
      Width           =   1695
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Recargar combos"
      Height          =   360
      Index           =   6
      Left            =   90
      TabIndex        =   24
      Top             =   7875
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Borrar descripcion"
      Height          =   360
      Index           =   5
      Left            =   3555
      TabIndex        =   17
      Top             =   1485
      Width           =   1695
   End
   Begin VB.TextBox txtFechaAlta 
      Alignment       =   2  'Center
      DataField       =   "FechaAlta"
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
      Height          =   240
      Left            =   9585
      TabIndex        =   16
      Top             =   1620
      Width           =   1365
   End
   Begin VB.TextBox txtUsuarioAlta 
      DataField       =   "UsuarioAlta"
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
      Height          =   240
      Left            =   7155
      TabIndex        =   15
      Top             =   1620
      Width           =   2400
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Copiar A&rticulo"
      Height          =   360
      Index           =   4
      Left            =   90
      TabIndex        =   8
      Top             =   7470
      Width           =   1470
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   600
      Left            =   1935
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   12
      Top             =   90
      Width           =   9015
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "Cargar articulo"
      Height          =   360
      Index           =   3
      Left            =   5310
      TabIndex        =   4
      Top             =   1485
      Width           =   1695
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdRubro"
      Height          =   315
      Index           =   0
      Left            =   1935
      TabIndex        =   2
      Tag             =   "Rubros"
      Top             =   720
      Width           =   3345
      _ExtentX        =   5900
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdRubro"
      Text            =   "DataCombo1"
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   360
      Index           =   0
      Left            =   90
      TabIndex        =   5
      Top             =   6255
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   360
      Index           =   2
      Left            =   90
      TabIndex        =   7
      Top             =   7065
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   360
      Index           =   1
      Left            =   90
      TabIndex        =   6
      Top             =   6660
      Width           =   1470
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSubrubro"
      Height          =   315
      Index           =   1
      Left            =   1935
      TabIndex        =   3
      Tag             =   "Subrubros"
      Top             =   1080
      Width           =   3345
      _ExtentX        =   5900
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdSubrubro"
      Text            =   "DataCombo1"
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   3
      Left            =   5445
      TabIndex        =   0
      Tag             =   "DefinicionArticulos"
      Top             =   720
      Width           =   5505
      _ExtentX        =   9710
      _ExtentY        =   556
      _Version        =   393216
      MatchEntry      =   -1  'True
      ListField       =   "Titulo"
      BoundColumn     =   "Clave"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   4
      Left            =   5445
      TabIndex        =   1
      Tag             =   "Articulos"
      Top             =   1080
      Width           =   5505
      _ExtentX        =   9710
      _ExtentY        =   556
      _Version        =   393216
      MatchEntry      =   -1  'True
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   4200
      Left            =   45
      TabIndex        =   18
      Top             =   1980
      Width           =   10950
      _ExtentX        =   19315
      _ExtentY        =   7408
      _Version        =   393216
      Tabs            =   9
      TabsPerRow      =   9
      TabHeight       =   520
      BackColor       =   12632256
      TabCaption(0)   =   "Seccion 1"
      TabPicture(0)   =   "frmArticulos.frx":076A
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Label1(0)"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "DTFields(0)"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "DataCombo2(0)"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "Check1(0)"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "Check2(0)"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).Control(5)=   "Text1(0)"
      Tab(0).Control(5).Enabled=   0   'False
      Tab(0).Control(6)=   "RichTextBox1(0)"
      Tab(0).Control(6).Enabled=   0   'False
      Tab(0).ControlCount=   7
      TabCaption(1)   =   "Seccion 2"
      TabPicture(1)   =   "frmArticulos.frx":0786
      Tab(1).ControlEnabled=   0   'False
      Tab(1).ControlCount=   0
      TabCaption(2)   =   "Seccion 3"
      TabPicture(2)   =   "frmArticulos.frx":07A2
      Tab(2).ControlEnabled=   0   'False
      Tab(2).ControlCount=   0
      TabCaption(3)   =   "Seccion 4"
      TabPicture(3)   =   "frmArticulos.frx":07BE
      Tab(3).ControlEnabled=   0   'False
      Tab(3).ControlCount=   0
      TabCaption(4)   =   "Seccion 5"
      TabPicture(4)   =   "frmArticulos.frx":07DA
      Tab(4).ControlEnabled=   0   'False
      Tab(4).ControlCount=   0
      TabCaption(5)   =   "Seccion 6"
      TabPicture(5)   =   "frmArticulos.frx":07F6
      Tab(5).ControlEnabled=   0   'False
      Tab(5).ControlCount=   0
      TabCaption(6)   =   "Seccion 7"
      TabPicture(6)   =   "frmArticulos.frx":0812
      Tab(6).ControlEnabled=   0   'False
      Tab(6).ControlCount=   0
      TabCaption(7)   =   "Seccion 8"
      TabPicture(7)   =   "frmArticulos.frx":082E
      Tab(7).ControlEnabled=   0   'False
      Tab(7).ControlCount=   0
      TabCaption(8)   =   "Seccion 9"
      TabPicture(8)   =   "frmArticulos.frx":084A
      Tab(8).ControlEnabled=   0   'False
      Tab(8).Control(0)=   "Label3(0)"
      Tab(8).ControlCount=   1
      Begin RichTextLib.RichTextBox RichTextBox1 
         Height          =   330
         Index           =   0
         Left            =   7740
         TabIndex        =   30
         Top             =   2475
         Visible         =   0   'False
         Width           =   2310
         _ExtentX        =   4075
         _ExtentY        =   582
         _Version        =   393217
         Enabled         =   -1  'True
         ScrollBars      =   2
         TextRTF         =   $"frmArticulos.frx":0866
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Index           =   0
         Left            =   7740
         TabIndex        =   22
         Text            =   "Text1"
         Top             =   810
         Visible         =   0   'False
         Width           =   2265
      End
      Begin VB.CheckBox Check2 
         Caption         =   "SI"
         Height          =   285
         Index           =   0
         Left            =   9360
         TabIndex        =   20
         Top             =   1575
         Visible         =   0   'False
         Width           =   510
      End
      Begin VB.CheckBox Check1 
         Caption         =   "NO"
         Height          =   285
         Index           =   0
         Left            =   8595
         TabIndex        =   19
         Top             =   1575
         Visible         =   0   'False
         Width           =   600
      End
      Begin MSDataListLib.DataCombo DataCombo2 
         Height          =   315
         Index           =   0
         Left            =   7740
         TabIndex        =   21
         Top             =   1170
         Visible         =   0   'False
         Width           =   2265
         _ExtentX        =   3995
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   ""
         Text            =   "DataCombo2"
      End
      Begin MSComCtl2.DTPicker DTFields 
         Height          =   330
         Index           =   0
         Left            =   7740
         TabIndex        =   29
         Top             =   1890
         Visible         =   0   'False
         Width           =   1485
         _ExtentX        =   2619
         _ExtentY        =   582
         _Version        =   393216
         CheckBox        =   -1  'True
         Format          =   59703297
         CurrentDate     =   36526
      End
      Begin VB.Label Label3 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Label1"
         Height          =   240
         Index           =   0
         Left            =   -66495
         TabIndex        =   34
         Top             =   2070
         Visible         =   0   'False
         Width           =   2265
      End
      Begin VB.Label Label1 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Label1"
         Height          =   240
         Index           =   0
         Left            =   7740
         TabIndex        =   23
         Top             =   495
         Visible         =   0   'False
         Width           =   2265
      End
   End
   Begin VividThumbNails.VividThumbs VividThumbs1 
      Height          =   1995
      Left            =   1755
      TabIndex        =   25
      Top             =   6210
      Width           =   4305
      _ExtentX        =   7594
      _ExtentY        =   3519
      tWidth          =   80
      tHeight         =   80
   End
   Begin Controles1013.DbListView Lista 
      Height          =   1815
      Left            =   6120
      TabIndex        =   28
      Top             =   6390
      Width           =   3120
      _ExtentX        =   5503
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
      MouseIcon       =   "frmArticulos.frx":08F1
      MultiSelect     =   0   'False
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList imlDocumentosIcons 
      Left            =   585
      Top             =   1215
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   34
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":090D
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":0A1F
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":0B31
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":0C43
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":0D55
            Key             =   "Cut"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":0E67
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":0F79
            Key             =   "Paste"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":108B
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":119D
            Key             =   "Undo"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":12AF
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":13C1
            Key             =   "Sort Ascending"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":14D3
            Key             =   "Sort Descending"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":15E5
            Key             =   "Up One Level"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":16F7
            Key             =   "View Large Icons"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":1809
            Key             =   "View Small Icons"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":191B
            Key             =   "View List"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":1A2D
            Key             =   "View Details"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":1B3F
            Key             =   "Properties"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":1C51
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":1D63
            Key             =   "Help What's This"
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":1E75
            Key             =   "CopiarCampo"
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":22C7
            Key             =   "ActualizaMateriales"
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":25E1
            Key             =   "Excel"
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":2A33
            Key             =   "Refrescar"
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":2D4D
            Key             =   "Parametros"
         EndProperty
         BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":3067
            Key             =   "Empresa"
         EndProperty
         BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":3381
            Key             =   "RefrescarArbol"
         EndProperty
         BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":369B
            Key             =   "EnviarCorreo1"
         EndProperty
         BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":5E4D
            Key             =   "EnviarCorreo"
         EndProperty
         BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":6167
            Key             =   "LeerCorreo"
         EndProperty
         BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":6481
            Key             =   "EnviarMensaje"
         EndProperty
         BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":68D3
            Key             =   "EstadoObras"
         EndProperty
         BeginProperty ListImage33 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":6BED
            Key             =   "MenuPopUp"
         EndProperty
         BeginProperty ListImage34 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":6F07
            Key             =   "ImportarDATANET"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   1170
      Top             =   1215
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
            Picture         =   "frmArticulos.frx":7359
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":746B
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":78BD
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulos.frx":7D0F
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSComDlg.CommonDialog dlgImagenes 
      Left            =   45
      Top             =   1260
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin Controles1013.DbListView ListaUnidades 
      Height          =   1815
      Left            =   9225
      TabIndex        =   31
      Top             =   6390
      Width           =   1770
      _ExtentX        =   3122
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
      MouseIcon       =   "frmArticulos.frx":8161
      MultiSelect     =   0   'False
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Label Label2 
      Caption         =   "Unidades :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   165
      Index           =   6
      Left            =   9270
      TabIndex        =   33
      Top             =   6210
      Width           =   960
   End
   Begin VB.Label Label2 
      Caption         =   "Documentos :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   165
      Index           =   3
      Left            =   6165
      TabIndex        =   32
      Top             =   6210
      Width           =   1230
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Fecha alta :"
      Height          =   195
      Index           =   5
      Left            =   9585
      TabIndex        =   14
      Top             =   1440
      Width           =   900
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Usuario (Alta) :"
      Height          =   195
      Index           =   4
      Left            =   7200
      TabIndex        =   13
      Top             =   1440
      Width           =   1035
   End
   Begin VB.Line Line1 
      BorderWidth     =   2
      X1              =   0
      X2              =   11070
      Y1              =   1935
      Y2              =   1935
   End
   Begin VB.Label Label2 
      Caption         =   "Subrubro :"
      Height          =   255
      Index           =   2
      Left            =   45
      TabIndex        =   11
      Top             =   1125
      Width           =   1815
   End
   Begin VB.Label Label2 
      Caption         =   "Código - Descripcion :"
      Height          =   255
      Index           =   0
      Left            =   45
      TabIndex        =   10
      Top             =   135
      Width           =   1815
   End
   Begin VB.Label Label2 
      Caption         =   "Rubro :"
      Height          =   255
      Index           =   1
      Left            =   45
      TabIndex        =   9
      Top             =   750
      Width           =   1815
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
         Caption         =   "Editar documento"
         Index           =   3
      End
   End
   Begin VB.Menu MnuDetU 
      Caption         =   "DetalleU"
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
   Begin VB.Menu MnuDetImg 
      Caption         =   "DetalleImg"
      Visible         =   0   'False
      Begin VB.Menu MnuDetImgA 
         Caption         =   "Visualizar"
         Index           =   0
      End
      Begin VB.Menu MnuDetImgA 
         Caption         =   "Eliminar"
         Index           =   1
      End
   End
   Begin VB.Menu MnuDetOtros 
      Caption         =   "DetalleOtros"
      Visible         =   0   'False
      Begin VB.Menu MnuDetOtrosA 
         Caption         =   ""
         Index           =   0
      End
      Begin VB.Menu MnuDetOtrosA 
         Caption         =   ""
         Index           =   1
         Visible         =   0   'False
      End
      Begin VB.Menu MnuDetOtrosA 
         Caption         =   ""
         Index           =   2
         Visible         =   0   'False
      End
      Begin VB.Menu MnuDetOtrosA 
         Caption         =   ""
         Index           =   3
         Visible         =   0   'False
      End
      Begin VB.Menu MnuDetOtrosA 
         Caption         =   ""
         Index           =   4
         Visible         =   0   'False
      End
   End
End
Attribute VB_Name = "frmArticulos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Articulo
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Dim mRubro As String, mSubrubro As String, mvarInf As String, mvarImagen As String
Private mvarId As Long
Private def_art() As String
Private Campos_SiNo() As String
Private HayAgregados As Boolean, mEquipoTercero As Boolean
Private mPrimerControlIndex(9) As Integer, mUltimoControlIndex(9) As Integer
Private mItemsPorColumna As Integer, mColumnasPorSeccion As Integer
Private mPrimerControl(9) As String, mUltimoControl(9) As String
Const mCamposQueNoCopia = "IdArticulo Codigo Descripcion DescripcionVirtual"
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

Private Sub Check1_Click(Index As Integer)

   If Check1(Index).Value = 1 Then
      Check2(Index).Value = 0
   Else
      Check2(Index).Value = 1
   End If
   
End Sub

Private Sub Check2_Click(Index As Integer)

   If Check2(Index).Value = 1 Then
      Check1(Index).Value = 0
   Else
      Check1(Index).Value = 1
   End If
   
End Sub

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
   
         If Len(txtDescripcion.Text) = 0 Then
            MsgBox "No puede grabar un material sin descripcion", vbExclamation
            Exit Sub
         End If
         
         Dim est As EnumAcciones
         Dim oControl As Control
         Dim oRsAux As ADOR.Recordset
   
         With origen.Registro
            If IIf(IsNull(.Fields("IdRubro").Value), 0, .Fields("IdRubro").Value) = 0 Then
               MsgBox "Debe ingresar el rubro", vbExclamation
               Exit Sub
            End If
            
            If IIf(IsNull(.Fields("IdSubrubro").Value), 0, .Fields("IdSubrubro").Value) = 0 Then
               MsgBox "Debe ingresar el subrubro", vbExclamation
               Exit Sub
            End If
            
            For Each oControl In Me.Controls
               If TypeOf oControl Is DataCombo Then
                  If Len(Trim(oControl.BoundText)) <> 0 And _
                        IsNumeric(oControl.BoundText) And _
                        Len(Trim(oControl.DataField)) <> 0 Then
                     .Fields(oControl.DataField).Value = oControl.BoundText
                  End If
               ElseIf TypeOf oControl Is DTPicker Then
                  If Len(Trim(oControl.DataField)) <> 0 Then
                     .Fields(oControl.DataField).Value = oControl.Value
                  End If
               ElseIf TypeOf oControl Is RichTextBox Then
                  If Len(Trim(oControl.DataField)) <> 0 Then
                     .Fields(oControl.DataField).Value = oControl.Text
                  End If
               ElseIf TypeOf oControl Is TextBox Then
'                  If oControl.DataField = "Descripcion" Then
                  If Len(oControl.DataField) > 0 Then
                     If (Len(oControl.Text) = 0 Or Not IsNumeric(oControl.Text)) And _
                           (.Fields(oControl.DataField).type = adInteger Or _
                            .Fields(oControl.DataField).type = adNumeric) Then
                        .Fields(oControl.DataField).Value = 0
                     ElseIf (Len(oControl.Text) = 0 Or Not IsDate(oControl.Text)) And _
                           (.Fields(oControl.DataField).type = adDBTimeStamp Or _
                            .Fields(oControl.DataField).type = adDate Or _
                            .Fields(oControl.DataField).type = adDBDate) Then
                        .Fields(oControl.DataField).Value = Date
                     Else
                        .Fields(oControl.DataField).Value = oControl.Text
                     End If
                  End If
'                  End If
               ElseIf TypeOf oControl Is CheckBox Then
                  If oControl.Index > 0 Then
                     If oControl.Name = "Check1" Then
                        If Len(Campos_SiNo(oControl.Index)) > 0 Then
                           If oControl.Value = 1 Then
                              .Fields(Campos_SiNo(oControl.Index)).Value = "NO"
                           Else
                              .Fields(Campos_SiNo(oControl.Index)).Value = "SI"
                           End If
                        End If
                     End If
                  End If
               End If
            Next
            .Fields("FechaUltimaModificacion").Value = Date
            .Fields("EnviarEmail").Value = 1
            
            If Not IsNull(.Fields("Codigo").Value) Then
               Set oRsAux = Aplicacion.Articulos.TraerFiltrado("_ValidarCodigo", Array(.Fields("Codigo").Value, mvarId))
               If oRsAux.RecordCount > 0 Then
                  MsgBox "Ya existe un articulo con este codigo", vbExclamation
                  oRsAux.Close
                  Set oRsAux = Nothing
                  Exit Sub
               End If
               oRsAux.Close
               Set oRsAux = Nothing
            End If
         
            If Not IsNull(.Fields("NumeroInventario").Value) Then
               Set oRsAux = Aplicacion.Articulos.TraerFiltrado("_ValidarNumeroInventario", Array(.Fields("NumeroInventario").Value, mvarId))
               If oRsAux.RecordCount > 0 Then
                  MsgBox "Ya existe un articulo con este numero de inventario", vbExclamation
                  oRsAux.Close
                  Set oRsAux = Nothing
                  Exit Sub
               End If
               oRsAux.Close
               Set oRsAux = Nothing
            End If
         
            If Label3.Count > 1 Then
               .Fields("AuxiliarString10").Value = Label3(2).Caption
            End If
         End With
         
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
         Else
            est = Modificacion
         End If
            
         If Not actL2 Is Nothing Then
         With actL2
            .ListaEditada = "ArticulosTodos, +SubAR1, ArticulosEquiposTerceros, " & _
                              "ArticulosTodosDetallados, ArticulosTodosResumidos"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
         End If
   
      Case 1
   
         Dim mvarRespElim As Integer
         mvarRespElim = MsgBox("Esta seguro de borrar?", vbYesNo + vbCritical)
         If mvarRespElim = vbNo Then Exit Sub
         
         origen.Eliminar
         
         est = baja
            
         With actL2
            .ListaEditada = "Articulos,ArticulosTodos,ArticulosRubros,+SubAR1"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
      Case 3
   
         Dim i As Long, dcR As Long, dcS As Long, dcF As Long, ind_art As Long
         Dim PosIni As Long, iTop As Long, iLeft As Long, CtrlCount As Long
         Dim mColumna As Integer, mFicha As Integer, mPos As Integer, X As Integer
         Dim mvarErr As String, TipIni As String
         Dim mEsta As Boolean
         Dim oAp As ComPronto.Aplicacion
         Dim oRs As ADOR.Recordset
         Dim oRs1 As ADOR.Recordset
         
         ind_art = 0
         PosIni = 0
         mFicha = 0
         mColumna = 1
         mvarErr = ""
         TipIni = " "
         HayAgregados = False
         
         If Len(Trim(DataCombo1(0).BoundText)) = 0 Then
            mvarErr = mvarErr + "No ha definido el rubro." + vbCrLf
         End If
         
         If Len(Trim(DataCombo1(1).BoundText)) = 0 Then
            mvarErr = mvarErr + "No ha definido el subrubro." + vbCrLf
         End If
         
         If Len(Trim(mvarErr)) <> 0 Then
            MsgBox mvarErr, vbCritical
            Exit Sub
         End If
         
         dcR = DataCombo1(0).BoundText
         dcS = DataCombo1(1).BoundText
         
         iTop = Label1(0).TOp - 100
         iLeft = SSTab1.Left + 50
         
         Set oAp = Aplicacion
         Set oRs = oAp.Rubros.Item(dcR).Registro
         mRubro = IIf(IsNull(oRs.Fields("Abreviatura").Value), oRs.Fields("Descripcion").Value, oRs.Fields("Abreviatura").Value)
         oRs.Close
         Set oRs = oAp.Subrubros.Item(dcS).Registro
         mSubrubro = IIf(IsNull(oRs.Fields("Abreviatura").Value), oRs.Fields("Descripcion").Value, oRs.Fields("Abreviatura").Value)
         oRs.Close
         
         Set oRs = oAp.DefinicionesArt.TraerFiltrado("_Art", Array(dcR, dcS))
   
         Do Until oRs.EOF
            If oRs.Fields("AddNombre").Value = "SI" Then
               HayAgregados = True
               If Len(Trim(oRs.Fields("Antes").Value)) <> 0 Then
                  ind_art = ind_art + 1
                  ReDim Preserve def_art(ind_art)
                  def_art(ind_art) = "*|" & oRs.Fields("Antes").Value
               End If
               ind_art = ind_art + 1
               If oRs.Fields("AgregaUnidadADescripcion").Value = "SI" Then
                  ind_art = ind_art + 1
                  ReDim Preserve def_art(ind_art)
                  If oRs.Fields("UsaAbreviatura").Value = "SI" Then
                     def_art(ind_art - 1) = "-CA|" & oRs.Fields("Campo").Value
                  Else
                     def_art(ind_art - 1) = " |" & oRs.Fields("Campo").Value
                  End If
                  If oRs.Fields("UsaAbreviaturaUnidad").Value = "SI" Then
                     def_art(ind_art) = "-UA|" & oRs.Fields("CampoUnidad").Value
                  Else
                     def_art(ind_art) = "-Un|" & oRs.Fields("CampoUnidad").Value
                  End If
               Else
                  ReDim Preserve def_art(ind_art)
                  If oRs.Fields("UsaAbreviatura").Value = "SI" Then
                     def_art(ind_art) = "-CA|" & oRs.Fields("Campo").Value
                  Else
                     def_art(ind_art) = " |" & oRs.Fields("Campo").Value
                  End If
               End If
               If Len(Trim(oRs.Fields("Despues").Value)) <> 0 Then
                  ind_art = ind_art + 1
                  ReDim Preserve def_art(ind_art)
                  def_art(ind_art) = "*|" & oRs.Fields("Despues").Value
               End If
            End If
            
            i = Label1.Count
            If CtrlCount = mItemsPorColumna Then
               If mColumna = mColumnasPorSeccion Then
                  mFicha = mFicha + 1
                  SSTab1.TabVisible(mFicha) = True
                  SSTab1.Tab = mFicha
                  mColumna = 1
                  iLeft = SSTab1.Left + 10
               Else
                  mColumna = mColumna + 1
                  iLeft = iLeft + (Label1(0).Width + text1(0).Width + 600)
               End If
               iTop = Label1(0).TOp - 100
               CtrlCount = 0
            End If
            
            Load Label1(i)
            With Label1(i)
               .TOp = iTop + text1(0).Height + 45
               .Left = iLeft
               .Caption = IIf(IsNull(oRs.Fields("Etiqueta").Value), "????", oRs.Fields("Etiqueta").Value)
               .Visible = True
            End With
            
            If oRs.Fields("CampoSiNo").Value = "SI" Then
               i = Check1.Count
               If PosIni = 0 Then PosIni = i: TipIni = "C"
               Load Check1(i)
               With Check1(i)
                  .TOp = Label1(Label1.Count - 1).TOp
                  .Left = iLeft + Label1(0).Width + 80
                  .Visible = True
               End With
               i = Check2.Count
               Load Check2(i)
               With Check2(i)
                  .TOp = Label1(Label1.Count - 1).TOp
                  .Left = iLeft + Label1(0).Width + 700
                  .Visible = True
               End With
               
               ReDim Preserve Campos_SiNo(i)
               mEsta = False
               For X = 0 To UBound(Campos_SiNo)
                  If Campos_SiNo(X) = oRs.Fields("Campo").Value Then
                     mEsta = True
                     Exit For
                  End If
               Next
               If Not mEsta Then
                  Campos_SiNo(i) = oRs.Fields("Campo").Value
                  If origen.Registro.Fields(oRs.Fields("Campo").Value).Value = "SI" Then
                     Check2(i).Value = 1
                  Else
                     Check1(i).Value = 1
                  End If
               End If
            
            ElseIf origen.Registro.Fields(oRs.Fields("Campo").Value).type = adDBTimeStamp Or _
                  origen.Registro.Fields(oRs.Fields("Campo").Value).type = adDBTime Or _
                  origen.Registro.Fields(oRs.Fields("Campo").Value).type = adDBDate Then
               i = DTFields.Count
               If PosIni = 0 Then PosIni = i: TipIni = "D"
               Load DTFields(i)
               With DTFields(i)
                  .TOp = Label1(Label1.Count - 1).TOp
                  .Left = iLeft + Label1(0).Width + 80
'                  Set .DataSource = origen
                  .DataField = oRs.Fields("Campo").Value
                  .Value = origen.Registro.Fields(oRs.Fields("Campo").Value).Value
                  .Visible = True
                  .Enabled = True
               End With
            
            ElseIf origen.Registro.Fields(oRs.Fields("Campo").Value).type = adLongVarWChar Then
               i = RichTextBox1.Count
               If PosIni = 0 Then PosIni = i: TipIni = "R"
               Load RichTextBox1(i)
               With RichTextBox1(i)
                  .TOp = Label1(Label1.Count - 1).TOp
                  .Left = iLeft + Label1(0).Width + 80
                  .DataField = oRs.Fields("Campo").Value
                  .TextRTF = IIf(IsNull(origen.Registro.Fields(oRs.Fields("Campo").Value).Value), "", origen.Registro.Fields(oRs.Fields("Campo").Value).Value)
                  .Visible = True
                  .Enabled = True
               End With
            
            ElseIf Len(Trim(oRs.Fields("TablaCombo").Value)) = 0 Or _
                  IsNull(oRs.Fields("TablaCombo").Value) Then
               i = text1.Count
               If PosIni = 0 Then PosIni = i: TipIni = "T"
               Load text1(i)
               With text1(i)
                  .TOp = Label1(Label1.Count - 1).TOp
                  .Left = iLeft + Label1(0).Width + 80
                  Set .DataSource = origen
                  .DataField = oRs.Fields("Campo").Value
                  .Visible = True
                  .Enabled = True
               End With
               If CtrlCount = 0 And mColumna = 1 Then
                  mPrimerControl(mFicha) = "T"
                  mPrimerControlIndex(mFicha) = i
               End If
               If CtrlCount + 1 = mItemsPorColumna And mColumna = mColumnasPorSeccion Then
                  mUltimoControl(mFicha) = "T"
                  mUltimoControlIndex(mFicha) = i
               End If
               If Len(Trim(oRs.Fields("CampoUnidad").Value)) <> 0 Then
                  mPos = i
                  With text1(i)
                     .Width = text1(i).Width * 0.4
                     .Alignment = 1
                  End With
                  i = DataCombo2.Count
                  Load DataCombo2(i)
                  With DataCombo2(i)
                     .TOp = Label1(Label1.Count - 1).TOp
                     .Left = text1(mPos).Left + text1(mPos).Width + 50
                     .Width = .Width * 0.8
                     .BoundColumn = "IdUnidad"
                     .DataField = oRs.Fields("CampoUnidad").Value
                     .Tag = "Unidades"
                     Set .DataSource = origen
                     Set .RowSource = oAp.CargarLista("Unidades")
                     .Visible = True
                     If Not IsNull(oRs.Fields("UnidadDefault").Value) And _
                           (mvarId < 0 Or IsNull(origen.Registro.Fields(oRs.Fields("CampoUnidad").Value).Value)) Then
                        .BoundText = oRs.Fields("UnidadDefault").Value
                     End If
                     .Enabled = True
                  End With
               End If
            
            Else
               i = DataCombo2.Count
               If PosIni = 0 Then PosIni = i: TipIni = "D"
               Load DataCombo2(i)
               With DataCombo2(i)
                  .TOp = Label1(Label1.Count - 1).TOp
                  .Left = iLeft + Label1(0).Width + 80
                  .BoundColumn = oRs.Fields("CampoCombo").Value
                  .DataField = oRs.Fields("Campo").Value
                  .Tag = oRs.Fields("TablaCombo").Value
                  Set .DataSource = origen
                  If mId(oRs.Fields("TablaCombo").Value, 1, 3) = "Aco" Then
                     Set oRs1 = oAp.CargarListaConParametros(oRs.Fields("TablaCombo").Value, Array(dcR, dcS))
                  ElseIf oRs.Fields("TablaCombo").Value = "Ubicaciones" Then
                     Set oRs1 = oAp.Ubicaciones.TraerFiltrado("_AbreviadoParaCombo")
                  ElseIf oRs.Fields("Campo").Value = "IdTipoArticulo" Then
                     Set oRs1 = oAp.Tipos.TraerFiltrado("_PorGrupoParaCombo", 1)
                  Else
                     Set oRs1 = oAp.CargarLista(oRs.Fields("TablaCombo").Value)
                  End If
                  Set .RowSource = oRs1
                  Set oRs1 = Nothing
                  .Visible = True
                  .Enabled = True
               End With
            
            End If
            
            iTop = iTop + text1(0).Height + 50
            CtrlCount = CtrlCount + 1
            
            oRs.MoveNext
         Loop
         oRs.Close
         
         Set oAp = Nothing
         Set oRs = Nothing
         
         SSTab1.Tab = 0
         
         For i = 0 To 5
            Cmd(i).TabIndex = 1000 + i
         Next
         txtDescripcion.TabIndex = 1000 + i
         SSTab1.TabIndex = 1000 + i + 1
         
         If TipIni = "D" Then DataCombo2(PosIni).SetFocus
         If TipIni = "T" Then text1(PosIni).SetFocus
         If TipIni = "C" Then Check1(PosIni).SetFocus
         
         Cmd(3).Enabled = False
         Cmd(4).Enabled = True
         DataCombo1(3).Enabled = False
         
         Me.Refresh
         
         Exit Sub
      
      Case 4
      
         Cmd(4).Enabled = False
         With DataCombo1(4)
            .Enabled = True
            .SetFocus
         End With
         Exit Sub
   
      Case 5
      
         txtDescripcion.Text = ""
         Exit Sub
   
      Case 6
   
         RecargarCombos
         Exit Sub

      Case 7
   
         AgregarImagen
         Exit Sub

      Case 8
   
         AgregarDocumento -1
         Exit Sub

   End Select
   
   'Actualizar archivo para menu
'   Dim oRsMenu As ADOR.Recordset
'   Set oRsMenu = Aplicacion.Articulos.TraerFiltrado("_ParaMenu")
'   GrabarMenu oRsMenu
'   oRsMenu.Close
'   Set oRsMenu = Nothing
   
   Unload Me

   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case -2147217900, -2147217873
         mvarResp = MsgBox("No puede borrar este registro porque se esta" & vbCrLf & "utilizando en otros archivos. Desea ver detalles?", vbYesNo + vbCritical)
         If mvarResp = vbYes Then
            MsgBox "Detalle del error : " & vbCrLf & Err.Number & " -> " & Err.Description
         End If
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oDetImg As ComPronto.DetArticuloImagenes
   Dim oDetDoc As ComPronto.DetArticuloDocumentos
   Dim oRs As ADOR.Recordset
   Dim oControl As Control
   Dim ListaVacia1 As Boolean, ListaVacia2 As Boolean
   Dim mAuxS1 As String
   Dim mAuxI1 As Integer
   
   mvarId = vNewValue
   ListaVacia1 = False
   ListaVacia2 = False
   
   mAuxS1 = BuscarClaveINI("IdCuantificacion por default")
   mAuxI1 = 0
   If IsNumeric(mAuxS1) Then mAuxI1 = Val(mAuxS1)
   If mAuxI1 = 0 Then mAuxI1 = 1
   
   Set oAp = Aplicacion
   Set origen = oAp.Articulos.Item(vNewValue)
   Set oBind = New BindingCollection
   
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetArticulosDocumentos.TraerMascara
                     ListaVacia1 = True
                  Else
                     Set oRs = origen.DetArticulosDocumentos.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia1 = False
                     Else
                        Set oControl.DataSource = origen.DetArticulosDocumentos.TraerMascara
                        ListaVacia1 = True
                     End If
                     oRs.Close
                  End If
               Case "ListaUnidades"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetArticulosUnidades.TraerMascara
                     ListaVacia2 = True
                  Else
                     Set oRs = origen.DetArticulosUnidades.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia2 = False
                     Else
                        Set oControl.DataSource = origen.DetArticulosUnidades.TraerMascara
                        ListaVacia2 = True
                     End If
                     oRs.Close
                  End If
            End Select
         ElseIf TypeOf oControl Is DbListView Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   End With
   
   If mvarId < 0 Then
      With origen.Registro
         .Fields("UsuarioAlta").Value = UsuarioSistema
         .Fields("FechaAlta").Value = Date
         .Fields("IdCuantificacion").Value = mAuxI1
      End With
   Else
      Set oRs = origen.DetArticulosImagenes.TraerTodos
      With oRs
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               Set oDetImg = origen.DetArticulosImagenes.Item(.Fields(0).Value)
               oDetImg.Modificado = True
               Set oDetImg = Nothing
               .MoveNext
            Loop
         End If
      End With
      Set oRs = Nothing
      Set oRs = origen.DetArticulosDocumentos.TraerTodos
      With oRs
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               Set oDetDoc = origen.DetArticulosDocumentos.Item(.Fields(0).Value)
               oDetDoc.Modificado = True
               Set oDetDoc = Nothing
               .MoveNext
            Loop
         End If
      End With
      Set oRs = Nothing
   End If
   
   With VividThumbs1
      .Cls
      .ThumbHeight = 80
      .ThumbWidth = 80
      .Refresh
   End With
   CargarImagenes
   
   If ListaVacia1 Then Lista.ListItems.Clear
   If ListaVacia2 Then ListaUnidades.ListItems.Clear
   
   If Me.EquipoTercero Then
      Set oRs = Aplicacion.Parametros.TraerFiltrado("_Parametros2BuscarClave", "IdRubroEquiposTerceros")
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdRubro").Value = Val(oRs.Fields("Valor").Value)
         DataCombo1(0).Enabled = False
      End If
      oRs.Close
      Set oRs = Aplicacion.Parametros.TraerFiltrado("_Parametros2BuscarClave", "IdSubrubroEquiposTerceros")
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdSubrubro").Value = Val(oRs.Fields("Valor").Value)
         DataCombo1(1).Enabled = False
      End If
      oRs.Close
      Set oRs = Nothing
      If Not DataCombo1(0).Enabled And Not DataCombo1(1).Enabled Then cmd_Click 3
      txtDescripcion.SetFocus
   End If
   
   Cmd(1).Enabled = False
   Cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then Cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      Cmd(0).Enabled = True
      If mvarId > 0 Then Cmd(1).Enabled = True
   End If
   
   Set oAp = Nothing
   
End Property

Public Property Get Id() As Long

   Id = mvarId
   
End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub DataCombo1_Change(Index As Integer)

   Select Case Index
      
      Case 4
   
         If IsNumeric(DataCombo1(4).BoundText) Then
            Dim oAp As ComPronto.Aplicacion
            Dim oRs As ADOR.Recordset
            Dim oFld1 As Field, oFld2 As Field
            Dim CampoExistente As Boolean
            Dim i As Integer
            
            Set oAp = Aplicacion
            Set oRs = oAp.Articulos.Item(DataCombo1(4).BoundText).Registro
            
            If oRs.RecordCount > 0 Then
               For Each oFld1 In oRs.Fields
                  CampoExistente = False
                  If InStr(1, mCamposQueNoCopia, oFld1.Name) = 0 Then
                     For Each oFld2 In origen.Registro.Fields
                        If oFld1.Name = oFld2.Name Then
                           CampoExistente = True
                           Exit For
                        End If
                     Next
                     If CampoExistente Then
                        origen.Registro.Fields(oFld1.Name).Value = oFld1.Value
                        If oFld1.type = adLongVarWChar Then
                           For i = 0 To RichTextBox1.Count - 1
                              If RichTextBox1(i).DataField = oFld1.Name Then
                                 RichTextBox1(i).TextRTF = IIf(IsNull(oFld1.Value), "", oFld1.Value)
                                 Exit For
                              End If
                           Next
                        End If
                     End If
                  End If
               Next
            End If
         End If
         
   End Select
   
End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)
   
   With DataCombo1(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
   If DataCombo1(Index).Enabled And Not Me.EquipoTercero Then SendKeys "%{DOWN}"

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}"

End Sub

Private Sub DataCombo1_LostFocus(Index As Integer)
   
   Dim s As String
   Select Case Index
      Case 4
         DataCombo1(4).Enabled = False
         Cmd(4).Enabled = True
   End Select
   
End Sub

Private Sub DataCombo1_Validate(Index As Integer, Cancel As Boolean)
   
   On Error Resume Next
   
   Select Case Index
      
      Case 3
         
         Dim mClave
         
         mClave = Split(DataCombo1(3).BoundText, "|")
         
         If UBound(mClave) = 3 Then
            DataCombo1(0).BoundText = CInt(mClave(0))
            DataCombo1(1).BoundText = CInt(mClave(1))
            DataCombo1(2).BoundText = CInt(mClave(2))
         End If
      
   End Select
   
   If Len(Trim(DataCombo1(Index).BoundText)) <> 0 And Len(Trim(DataCombo1(Index).DataField)) <> 0 Then
      origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
   End If

End Sub

Private Sub DataCombo2_GotFocus(Index As Integer)

   With DataCombo2(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
   SendKeys "%{DOWN}"

End Sub

Private Sub DataCombo2_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}"

End Sub

Private Sub DataCombo2_LostFocus(Index As Integer)

   Dim s As String
   Select Case Index
      Case Is > 0
         GeneraDescripcion
         If InStr(mvarInf, DataCombo2(Index).DataField) <> 0 Then
'            If DataCombo2(Index).Text = "SI" Then
'               DatosAdicionales (DataCombo2(Index).DataField)
'            ElseIf DataCombo2(Index).Text = "NO" Then
'               origen.ArticulosInformacionAdicional.BorrarRegistrosCampo (DataCombo2(Index).DataField)
'            End If
         End If
   End Select
   
End Sub

Private Sub DataCombo2_Validate(Index As Integer, Cancel As Boolean)

   If Len(Trim(DataCombo2(Index).BoundText)) <> 0 And _
         IsNumeric(DataCombo2(Index).BoundText) And _
         Len(Trim(DataCombo2(Index).DataField)) <> 0 Then
      origen.Registro.Fields(DataCombo2(Index).DataField).Value = DataCombo2(Index).BoundText
   End If

End Sub

Private Sub DTFields_Click(Index As Integer)

   If IsNull(origen.Registro.Fields(DTFields(Index).DataField).Value) And _
         DTFields(Index).Value = CDate("01/01/2000") Then
      DTFields(Index).Value = Date
   End If

End Sub

Private Sub Form_Activate()

   If mvarId < 0 Then
      Cmd(1).Enabled = False
      If Me.EquipoTercero Then DataCombo1(3).Enabled = False
   Else
      DataCombo1(0).Enabled = False
      DataCombo1(1).Enabled = False
      DataCombo1(3).Enabled = False
      cmd_Click (3)
   End If
   
   DataCombo1(4).Enabled = False
   Cmd(4).Enabled = False

End Sub

Private Sub Form_Load()

   Dim i As Integer
   Dim s As String, s1 As String
   Dim mVector
   
   With SSTab1
      For i = 1 To .Tabs - 1
         .TabVisible(i) = False
      Next
      .Tab = 0
   End With
   
   If BuscarClaveINI("Habilitar seccion especial en formulario de articulos") = "SI" Then
      SSTab1.TabVisible(8) = True
      SSTab1.Tab = 8
      SSTab1.TabCaption(8) = "OTROS"
      i = Label3.Count
      Load Label3(i)
      With Label3(i)
         .TOp = 1000
         .Left = SSTab1.Left + 50
         .Caption = "PLATAFORMA :"
         .Visible = True
      End With
      i = Label3.Count
      Load Label3(i)
      With Label3(i)
         .TOp = Label3(1).TOp
         .Left = Label3(1).Left + Label3(1).Width + 50
         .BackColor = &HE0E0E0
         .Caption = IIf(IsNull(origen.Registro.Fields("AuxiliarString10").Value), "", origen.Registro.Fields("AuxiliarString10").Value)
         .Visible = True
      End With
      SSTab1.Tab = 0
      s = BuscarClaveINI("Opciones para seccion especial en formulario de articulos")
      If Len(s) > 0 Then
         mVector = VBA.Split(s, ",")
         For i = 0 To UBound(mVector)
            MnuDetOtrosA(i).Visible = True
            MnuDetOtrosA(i).Caption = "" & mVector(i)
         Next
      End If
   End If
   
   For i = 0 To 9
      mPrimerControl(i) = ""
      mPrimerControlIndex(i) = 0
      mUltimoControl(i) = ""
      mUltimoControlIndex(i) = 0
   Next
   
   mItemsPorColumna = 10
   mColumnasPorSeccion = 2
   mvarInf = ""
   
   With Lista
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   With ListaUnidades
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   'Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   
End Sub


Private Sub Label3_Click(Index As Integer)

   If Index = 2 And Len(Trim(Label3(Index).Caption)) = 0 Then
      Label3(Index).Caption = MnuDetOtrosA(0).Caption
   End If

End Sub

Private Sub Label3_MouseUp(Index As Integer, Button As Integer, Shift As Integer, X As Single, y As Single)

   If Button = vbRightButton And Index = 2 Then
      PopupMenu MnuDetOtros
   End If

End Sub

Private Sub Lista_DblClick()

   If Lista.ListItems.Count = 0 Then
      AgregarDocumento -1
   Else
      AgregarDocumento Lista.SelectedItem.Tag
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

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, y As Single)

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

Private Sub ListaUnidades_DblClick()

   If ListaUnidades.ListItems.Count = 0 Then
      AgregarUnidad -1
   Else
      AgregarUnidad ListaUnidades.SelectedItem.Tag
   End If

End Sub

Private Sub ListaUnidades_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaUnidades_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetB_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetB_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetB_Click 1
   End If

End Sub

Private Sub ListaUnidades_MouseUp(Button As Integer, Shift As Integer, X As Single, y As Single)

   If Button = vbRightButton Then
      If ListaUnidades.ListItems.Count = 0 Then
         MnuDetB(1).Enabled = False
         MnuDetB(2).Enabled = False
         PopupMenu MnuDetU, , , , MnuDetB(0)
      Else
         MnuDetB(1).Enabled = True
         MnuDetB(2).Enabled = True
         PopupMenu MnuDetU, , , , MnuDetB(1)
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         AgregarDocumento -1
      Case 1
         AgregarDocumento Lista.SelectedItem.Tag
      Case 2
         With Lista.SelectedItem
            origen.DetArticulosDocumentos.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
      Case 3
         If Not Lista.SelectedItem Is Nothing Then
            If Len(Lista.SelectedItem.Text) > 0 Then
               If Not Len(Trim(Dir(Lista.SelectedItem.Text))) <> 0 Then
                  MsgBox "El archivo indicado no existe!", vbExclamation
                  Exit Sub
               End If
               Call ShellExecute(Me.hwnd, "open", Lista.SelectedItem.Text, vbNullString, vbNullString, SW_SHOWNORMAL)
            End If
         End If
   End Select

End Sub

Private Sub MnuDetB_Click(Index As Integer)

   Select Case Index
      Case 0
         AgregarUnidad -1
      Case 1
         AgregarUnidad ListaUnidades.SelectedItem.Tag
      Case 2
         With ListaUnidades.SelectedItem
            origen.DetArticulosUnidades.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub MnuDetImgA_Click(Index As Integer)

   Select Case Index
      Case 0
         Call ShellExecute(Me.hwnd, "open", mvarImagen, vbNullString, vbNullString, SW_SHOWNORMAL)
      Case 1
         BorrarImagen mvarImagen
   End Select

End Sub

Private Sub MnuDetOtrosA_Click(Index As Integer)

   Label3(2).Caption = MnuDetOtrosA(Index).Caption

End Sub

Private Sub RichTextBox1_GotFocus(Index As Integer)

   With RichTextBox1(Index)
      .Width = .Width * 3.5
      .Height = .Height * 3
   End With

End Sub

Private Sub RichTextBox1_LostFocus(Index As Integer)

   With RichTextBox1(Index)
      .Width = RichTextBox1(0).Width
      .Height = RichTextBox1(0).Height
   End With

End Sub

Private Sub Text1_KeyPress(Index As Integer, KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then
      If Index < text1.Count - 1 Then
         If mUltimoControl(SSTab1.Tab) = "T" And Index = mUltimoControlIndex(SSTab1.Tab) Then
            SSTab1.Tab = SSTab1.Tab + 1
            If mPrimerControl(SSTab1.Tab) = "T" Then
               text1(mPrimerControlIndex(SSTab1.Tab)).SetFocus
            End If
         End If
         text1(Index + 1).SetFocus
      End If
   End If
   
End Sub

Private Sub Text1_LostFocus(Index As Integer)

   GeneraDescripcion

End Sub

Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}"
   Else
      With txtDescripcion
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Public Function GeneraDescripcion()

   On Error Resume Next
   
   Dim oAp As ComPronto.Aplicacion
   
   Set oAp = Aplicacion
   
   If mvarId < 0 Or Len(Trim(txtDescripcion.Text)) = 0 Then
      
      Dim oRs As ADOR.Recordset
      Dim i, i1 As Integer
      Dim s, mvarAbr As String
      Dim SubDef
      
      With txtDescripcion
         .Text = Trim(mRubro) + " " + Trim(mSubrubro) + " "
         If Len(Trim(.Text)) = 0 Then .Text = ""
         If HayAgregados Then
            For i = 1 To UBound(def_art)
               SubDef = VBA.Split(def_art(i), "|")
               If Len(SubDef(1)) > 0 Then
                  s = ""
                  Select Case SubDef(0)
                     Case "*"
                        s = Trim(SubDef(1)) & " "
                     Case "-UA"
                        If Not IsNull(origen.Registro.Fields(SubDef(1)).Value) Then
                           s = Trim(oAp.Unidades.Item(origen.Registro.Fields(SubDef(1)).Value).Registro.Fields("Abreviatura").Value)
                        End If
                     Case "-Un"
                        If Not IsNull(origen.Registro.Fields(SubDef(1)).Value) Then
                           s = Trim(oAp.Unidades.Item(origen.Registro.Fields(SubDef(1)).Value).Registro.Fields("Descripcion").Value)
                        End If
                     Case Else
                        For i1 = 0 To text1.Count - 1
                           If text1(i1).DataField = SubDef(1) And Len(Trim(text1(i1).Text)) <> 0 Then
                              s = Trim(text1(i1).Text) & " "
                           End If
                        Next
                        For i1 = 0 To DataCombo2.Count - 1
                           If DataCombo2(i1).DataField = SubDef(1) And Len(Trim(DataCombo2(i1).Text)) <> 0 Then
                              mvarAbr = ""
                              If SubDef(0) = "-CA" Then
                                 If Not IsNull(origen.Registro.Fields(SubDef(1)).Value) Then
                                    If mId(DataCombo2(i1).Tag, 1, 3) = "Aco" Then
                                       Set oRs = oAp.TablasGenerales.TraerUno(mId(DataCombo2(i1).Tag, 4, Len(DataCombo2(i1).Tag) - 3), DataCombo2(i1).BoundText)
                                    Else
                                       Set oRs = oAp.TablasGenerales.TraerUno(DataCombo2(i1).Tag, DataCombo2(i1).BoundText)
                                    End If
                                    'If ExisteCampo(oRs, "Abreviatura") Then
                                    '   If Not IsNull(oRs.Fields("Abreviatura").Value) Then
                                    '      mvarAbr = Trim(oRs.Fields("Abreviatura").Value)
                                    '   End If
                                    'End If
                                    oRs.Close
                                 End If
                              End If
                              If Len(Trim(mvarAbr)) <> 0 Then
                                 s = mvarAbr & " "
                              Else
                                 s = Trim(DataCombo2(i1).Text) & " "
                              End If
                           End If
                        Next
                  End Select
                  .Text = .Text & s
               End If
            Next
         End If
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize Then
            MsgBox "La descripcion del articulo tiene la longitud maxima permitida." & vbCrLf & "Verifique los datos y confirme", vbExclamation
            .Text = mId(.Text, 1, origen.Registro.Fields(.DataField).DefinedSize)
         End If
      End With
   End If

   Set oRs = Nothing
   Set oAp = Nothing

End Function

Public Sub RecargarCombos()

   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   Dim mVector
   
   On Error Resume Next
   
   Me.MousePointer = vbHourglass
   DoEvents
   
   Set oAp = Aplicacion
   Set oBind = Nothing
   Set oBind = New BindingCollection
   
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               mVector = VBA.Split(oControl.Tag, "|")
               If UBound(mVector) > 0 Then
                  Set oControl.RowSource = oAp.TablasGenerales.TraerFiltrado(mVector(0), "_PorGrupoParaCombo", mVector(1))
               Else
                  If mId(mVector(0), 1, 3) = "Aco" Then
                     Set oControl.RowSource = oAp.CargarListaConParametros(mVector(0), Array(DataCombo1(0).BoundText, DataCombo1(1).BoundText))
                  Else
                     Set oControl.RowSource = oAp.CargarLista(mVector(0))
                  End If
               End If
            End If
         End If
      Next
   End With

   Set oAp = Nothing

   Me.MousePointer = vbDefault
   
End Sub

Public Sub AgregarImagen()

   Dim mArchivo As String
   Dim mIdDetalle As Long
   
   With dlgImagenes
      .CancelError = True
      On Error GoTo filerr
      .DialogTitle = "Seleccione una imagen ..."
      .DefaultExt = "*.JPG"
      .Filter = "Imagenes JPG (*.JPG)|*.JPG|Imagenes BMP (*.BMP)|*.BMP|Imagenes GIF (*.GIF)|*.GIF"
      .FilterIndex = 1
      .MaxFileSize = 32767
      .ShowOpen
      mArchivo = .Filename
   End With
       
   If mArchivo <> "" Then
      If UCase$(Right(mArchivo, 3)) = "JPG" Or _
         UCase$(Right(mArchivo, 3)) = "BMP" Or _
         UCase$(Right(mArchivo, 3)) = "GIF" Then
         With origen.DetArticulosImagenes.Item(-1)
            .Registro.Fields("PathImagen").Value = mArchivo
            .Modificado = True
            mIdDetalle = .Id
         End With
         With VividThumbs1
            .AddThumb (mArchivo)
            .Tag = mIdDetalle
         End With
         DoEvents
      End If
   End If

filerr:

End Sub

Public Sub CargarImagenes()

   Dim oRs As ADOR.Recordset
   Dim mArchivo As String
   
   Set oRs = origen.DetArticulosImagenes.TodosLosRegistros
   With oRs
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               If Not .Fields("Eliminado").Value Then
                  mArchivo = IIf(IsNull(.Fields("PathImagen").Value), "", .Fields("PathImagen").Value)
                  If Len(Trim(Dir(mArchivo))) = 0 Then
                     mArchivo = ""
                  End If
                  If mArchivo <> "" Then
                     VividThumbs1.AddThumb (mArchivo)
                  End If
               End If
               .MoveNext
            Loop
         End If
      End If
   End With
   Set oRs = Nothing
      
End Sub

Public Sub AgregarDocumento(ByVal IdDocumento As Long)

   Dim mArchivo As String
   Dim mIdDocumento As Long
   Dim oL As ListItem
   
   mIdDocumento = IdDocumento
   
   mArchivo = ""
   If IdDocumento > 0 Then
      mArchivo = origen.DetArticulosDocumentos.Item(IdDocumento).Registro.Fields("PathDocumento").Value
   End If
   
   With dlgImagenes
      .CancelError = True
      On Error GoTo filerr
      .DialogTitle = "Seleccione un documento ..."
      .DefaultExt = "*.*"
      .Filter = "Todos los documentos (*.*)|*.*"
      .FilterIndex = 1
      .MaxFileSize = 32767
      .Filename = mArchivo
      .ShowOpen
      mArchivo = .Filename
   End With
       
   If mArchivo <> "" Then
      With origen.DetArticulosDocumentos.Item(IdDocumento)
         .Registro.Fields("PathDocumento").Value = mArchivo
         .Modificado = True
         If mIdDocumento = -1 Then
            Set oL = Lista.ListItems.Add
            oL.Tag = .Id
         Else
            Set oL = Lista.SelectedItem
         End If
         With oL
            If mIdDocumento = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = mArchivo
         End With
      End With
   End If

filerr:

End Sub

Private Sub VividThumbs1_ThumbClick(Filename As String, X As Single, y As Single)

   If Len(Filename) > 0 Then
      If Not Len(Trim(Dir(Filename))) <> 0 Then
         MsgBox "El archivo indicado no existe!", vbExclamation
         Exit Sub
      End If
      mvarImagen = Filename
      PopupMenu MnuDetImg, , , , MnuDetImgA(0)
   End If

End Sub

Public Sub AgregarUnidad(ByVal Cual As Long)

   Dim oF As frmDetArticulosUnidades
   Dim oL As ListItem
   
   If IsNull(origen.Registro.Fields("IdUnidad").Value) Then
      MsgBox "Primero debe definir la unidad standar de medida del material", vbExclamation
      Exit Sub
   End If
   
   Set oF = New frmDetArticulosUnidades
   With oF
      Set .Articulo = origen
      .IdUnidad = origen.Registro.Fields("IdUnidad").Value
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaUnidades.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaUnidades.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.DataCombo1(0).Text
            .SubItems(1) = "" & oF.txtEquivalencia.Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Public Property Get EquipoTercero() As Boolean

   EquipoTercero = mEquipoTercero

End Property

Public Property Let EquipoTercero(ByVal vNewValue As Boolean)

   mEquipoTercero = vNewValue

End Property

Public Sub BorrarImagen(ByVal Imagen As String)

   Dim oRs As ADOR.Recordset
   
   Set oRs = origen.DetArticulosImagenes.TodosLosRegistros
   With oRs
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               If Not .Fields("Eliminado").Value Then
                  If IIf(IsNull(.Fields("PathImagen").Value), "", .Fields("PathImagen").Value) = Imagen Then
                     origen.DetArticulosImagenes.Item(.Fields(0).Value).Eliminado = True
                     Exit Do
                  End If
               End If
               .MoveNext
            Loop
         End If
      End If
   End With
   Set oRs = Nothing

   VividThumbs1.Cls
   CargarImagenes

End Sub
