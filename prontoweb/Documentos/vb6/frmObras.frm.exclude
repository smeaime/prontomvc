VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Object = "{F7D972E3-E925-4183-AB00-B6A253442139}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmObras 
   Caption         =   "Obras"
   ClientHeight    =   8535
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11325
   Icon            =   "frmObras.frx":0000
   LinkTopic       =   "Form1"
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   8535
   ScaleWidth      =   11325
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame2 
      Caption         =   "Refer.:"
      Height          =   330
      Left            =   135
      TabIndex        =   107
      Top             =   1800
      Width           =   7350
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdJefe"
         Height          =   315
         Index           =   1
         Left            =   3555
         TabIndex        =   109
         Tag             =   "Empleados"
         Top             =   0
         Width           =   1545
         _ExtentX        =   2725
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdEmpleado"
         Text            =   ""
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdSubjefe"
         Height          =   315
         Index           =   5
         Left            =   5805
         TabIndex        =   111
         Tag             =   "Empleados"
         Top             =   0
         Width           =   1545
         _ExtentX        =   2725
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdEmpleado"
         Text            =   ""
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdJefeRegional"
         Height          =   315
         Index           =   8
         Left            =   1485
         TabIndex        =   112
         Tag             =   "Empleados"
         Top             =   0
         Width           =   1545
         _ExtentX        =   2725
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdEmpleado"
         Text            =   ""
      End
      Begin VB.Label lblData 
         Caption         =   "Jefe reg.:"
         Height          =   195
         Index           =   5
         Left            =   720
         TabIndex        =   113
         Top             =   90
         Width           =   690
      End
      Begin VB.Label lblData 
         Caption         =   "Subjefe:"
         Height          =   195
         Index           =   0
         Left            =   5130
         TabIndex        =   110
         Top             =   90
         Width           =   645
      End
      Begin VB.Label lblData 
         Caption         =   "Jefe:"
         Height          =   195
         Index           =   2
         Left            =   3105
         TabIndex        =   108
         Top             =   90
         Width           =   420
      End
   End
   Begin VB.TextBox txtValorObra 
      Alignment       =   1  'Right Justify
      DataField       =   "ValorObra"
      Height          =   285
      Left            =   5670
      TabIndex        =   105
      Top             =   2520
      Width           =   900
   End
   Begin VB.TextBox txtZona 
      DataField       =   "Zona"
      Height          =   285
      Left            =   9225
      TabIndex        =   98
      Top             =   9765
      Visible         =   0   'False
      Width           =   360
   End
   Begin VB.TextBox txtOperarios 
      DataField       =   "Operarios"
      Height          =   285
      Left            =   8010
      TabIndex        =   96
      Top             =   9765
      Visible         =   0   'False
      Width           =   540
   End
   Begin VB.TextBox txtJurisdiccion 
      DataField       =   "Jurisdiccion"
      Height          =   285
      Left            =   10710
      TabIndex        =   94
      Top             =   9765
      Visible         =   0   'False
      Width           =   495
   End
   Begin VB.TextBox txtTurnos 
      DataField       =   "Turnos"
      Height          =   285
      Left            =   10485
      TabIndex        =   92
      Top             =   9405
      Visible         =   0   'False
      Width           =   720
   End
   Begin VB.TextBox txtHorario 
      DataField       =   "Horario"
      Height          =   285
      Left            =   8010
      TabIndex        =   90
      Top             =   9405
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.TextBox txtResponsable 
      DataField       =   "Responsable"
      Height          =   285
      Left            =   8010
      TabIndex        =   88
      Top             =   9045
      Visible         =   0   'False
      Width           =   3195
   End
   Begin VB.TextBox txtLugarPago 
      DataField       =   "LugarPago"
      Height          =   285
      Left            =   8010
      TabIndex        =   86
      Top             =   8685
      Visible         =   0   'False
      Width           =   3195
   End
   Begin VB.TextBox txtCodigoPostal 
      DataField       =   "CodigoPostal"
      Height          =   285
      Left            =   3330
      TabIndex        =   77
      Top             =   9360
      Visible         =   0   'False
      Width           =   2475
   End
   Begin VB.TextBox txtTelefono 
      DataField       =   "Telefono"
      Height          =   285
      Left            =   8010
      TabIndex        =   76
      Top             =   8325
      Visible         =   0   'False
      Width           =   3195
   End
   Begin VB.TextBox txtDireccion 
      DataField       =   "Direccion"
      Height          =   285
      Left            =   3330
      TabIndex        =   74
      Top             =   8325
      Visible         =   0   'False
      Width           =   3195
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Mas datos"
      Height          =   360
      Index           =   3
      Left            =   135
      TabIndex        =   73
      Top             =   8010
      Visible         =   0   'False
      Width           =   1785
   End
   Begin VB.CommandButton cmdImpreInst 
      Caption         =   "Parte instalacion"
      Height          =   465
      Index           =   1
      Left            =   135
      Picture         =   "frmObras.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   72
      Top             =   7515
      Visible         =   0   'False
      Width           =   1785
   End
   Begin VB.TextBox txtCodigoCliente 
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
      Left            =   6525
      TabIndex        =   71
      Top             =   1080
      Width           =   960
   End
   Begin VB.CheckBox Check3 
      Height          =   240
      Left            =   2115
      TabIndex        =   66
      Top             =   2205
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CommandButton cmdMateriales 
      Caption         =   "Ver mas datos"
      Height          =   330
      Left            =   6255
      TabIndex        =   63
      Top             =   2160
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.CheckBox Check2 
      Height          =   240
      Left            =   2115
      TabIndex        =   56
      Top             =   1125
      Width           =   195
   End
   Begin VB.CommandButton cmdPlantilla 
      Caption         =   "Editar formulario de obra"
      Height          =   285
      Left            =   5130
      TabIndex        =   54
      Top             =   3060
      Width           =   2400
   End
   Begin VB.TextBox txtJerarquia 
      Height          =   285
      Index           =   0
      Left            =   2880
      TabIndex        =   8
      Top             =   3060
      Width           =   315
   End
   Begin VB.TextBox txtJerarquia 
      Height          =   285
      Index           =   1
      Left            =   3240
      TabIndex        =   9
      Top             =   3060
      Width           =   315
   End
   Begin VB.TextBox txtJerarquia 
      Height          =   285
      Index           =   2
      Left            =   3600
      TabIndex        =   10
      Top             =   3060
      Width           =   435
   End
   Begin VB.TextBox txtJerarquia 
      Height          =   285
      Index           =   3
      Left            =   4095
      TabIndex        =   11
      Top             =   3060
      Width           =   435
   End
   Begin VB.TextBox txtJerarquia 
      Height          =   285
      Index           =   4
      Left            =   4590
      TabIndex        =   12
      Top             =   3060
      Width           =   435
   End
   Begin VB.Frame Frame1 
      Caption         =   "Estado obra : "
      Height          =   510
      Left            =   90
      TabIndex        =   27
      Top             =   2835
      Width           =   2670
      Begin VB.OptionButton Option2 
         Caption         =   "Inactiva"
         Height          =   195
         Left            =   1350
         TabIndex        =   29
         Top             =   270
         Width           =   960
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Activa"
         Height          =   195
         Left            =   360
         TabIndex        =   28
         Top             =   270
         Width           =   960
      End
   End
   Begin VB.TextBox txtHorasEstimadas 
      Alignment       =   1  'Right Justify
      DataField       =   "HorasEstimadas"
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
      Left            =   4680
      TabIndex        =   6
      Top             =   3375
      Width           =   765
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "frmObras.frx":0CF4
      Left            =   2085
      List            =   "frmObras.frx":0CF6
      TabIndex        =   1
      Top             =   390
      Width           =   1590
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   285
      Left            =   2085
      TabIndex        =   4
      Top             =   765
      Width           =   5400
   End
   Begin RichTextLib.RichTextBox RichTextBox1 
      Height          =   2895
      Left            =   7560
      TabIndex        =   16
      Top             =   315
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   5106
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmObras.frx":0CF8
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Enabled         =   0   'False
      Height          =   360
      Index           =   1
      Left            =   1065
      TabIndex        =   14
      Top             =   7110
      Width           =   855
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   360
      Index           =   2
      Left            =   135
      TabIndex        =   15
      Top             =   7110
      Width           =   885
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   390
      Index           =   0
      Left            =   135
      TabIndex        =   13
      Top             =   6660
      Width           =   1785
   End
   Begin VB.TextBox txtCodigoObra 
      DataField       =   "NumeroObra"
      Height          =   285
      Left            =   2085
      TabIndex        =   0
      Top             =   45
      Width           =   1545
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCliente"
      Height          =   315
      Index           =   0
      Left            =   2355
      TabIndex        =   5
      Tag             =   "Clientes"
      Top             =   1080
      Width           =   4140
      _ExtentX        =   7303
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCliente"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaInicio"
      Height          =   285
      Index           =   0
      Left            =   3690
      TabIndex        =   2
      Top             =   405
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   503
      _Version        =   393216
      Format          =   57212929
      CurrentDate     =   36432
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaFinalizacion"
      Height          =   285
      Index           =   1
      Left            =   6120
      TabIndex        =   17
      Top             =   405
      Width           =   1395
      _ExtentX        =   2461
      _ExtentY        =   503
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   57212929
      CurrentDate     =   36526
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaEntrega"
      Height          =   285
      Index           =   2
      Left            =   4905
      TabIndex        =   3
      Top             =   405
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   503
      _Version        =   393216
      Format          =   57212929
      CurrentDate     =   36432
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticuloAsociado"
      Height          =   315
      Index           =   2
      Left            =   2340
      TabIndex        =   7
      Tag             =   "Articulos"
      Top             =   2160
      Visible         =   0   'False
      Width           =   3885
      _ExtentX        =   6853
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   1365
      Left            =   90
      TabIndex        =   32
      Top             =   3645
      Width           =   11175
      _ExtentX        =   19711
      _ExtentY        =   2408
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmObras.frx":0D7A
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   285
      Index           =   0
      Left            =   3330
      TabIndex        =   34
      Top             =   6660
      Width           =   3210
      _ExtentX        =   5662
      _ExtentY        =   503
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   285
      Index           =   1
      Left            =   3330
      TabIndex        =   35
      Top             =   6975
      Width           =   3210
      _ExtentX        =   5662
      _ExtentY        =   503
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   285
      Index           =   2
      Left            =   3330
      TabIndex        =   36
      Top             =   7290
      Width           =   3210
      _ExtentX        =   5662
      _ExtentY        =   503
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   285
      Index           =   3
      Left            =   3330
      TabIndex        =   37
      Top             =   7605
      Width           =   3210
      _ExtentX        =   5662
      _ExtentY        =   503
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   285
      Index           =   4
      Left            =   3330
      TabIndex        =   38
      Top             =   7920
      Width           =   3210
      _ExtentX        =   5662
      _ExtentY        =   503
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   285
      Index           =   5
      Left            =   8010
      TabIndex        =   39
      Top             =   6660
      Width           =   3210
      _ExtentX        =   5662
      _ExtentY        =   503
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   285
      Index           =   6
      Left            =   8010
      TabIndex        =   40
      Top             =   6975
      Width           =   3210
      _ExtentX        =   5662
      _ExtentY        =   503
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   285
      Index           =   7
      Left            =   8010
      TabIndex        =   41
      Top             =   7290
      Width           =   3210
      _ExtentX        =   5662
      _ExtentY        =   503
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   285
      Index           =   8
      Left            =   8010
      TabIndex        =   42
      Top             =   7605
      Width           =   3210
      _ExtentX        =   5662
      _ExtentY        =   503
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   285
      Index           =   9
      Left            =   8010
      TabIndex        =   43
      Top             =   7920
      Width           =   3210
      _ExtentX        =   5662
      _ExtentY        =   503
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
   Begin MSComctlLib.ImageList Img16 
      Left            =   0
      Top             =   7740
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
            Picture         =   "frmObras.frx":0D96
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmObras.frx":0EA8
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmObras.frx":12FA
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmObras.frx":174C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdGrupoObra"
      Height          =   315
      Index           =   3
      Left            =   5535
      TabIndex        =   57
      Tag             =   "GruposObras"
      Top             =   1440
      Width           =   1950
      _ExtentX        =   3440
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdGrupoObra"
      Text            =   ""
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "La obra generara automaticamente reserva de stock al recepcionar materiales :"
      Height          =   240
      Left            =   1530
      TabIndex        =   55
      Top             =   2745
      Visible         =   0   'False
      Width           =   5955
   End
   Begin Controles1013.DbListView ListaRecepciones 
      Height          =   1365
      Left            =   90
      TabIndex        =   59
      Top             =   5265
      Width           =   11175
      _ExtentX        =   19711
      _ExtentY        =   2408
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmObras.frx":1B9E
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUnidadOperativa"
      Height          =   315
      Index           =   4
      Left            =   2070
      TabIndex        =   61
      Tag             =   "UnidadesOperativas"
      Top             =   1440
      Width           =   2220
      _ExtentX        =   3916
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidadOperativa"
      Text            =   ""
   End
   Begin Controles1013.DbListView ListaEquiposInstalados 
      Height          =   420
      Left            =   10080
      TabIndex        =   65
      Top             =   45
      Visible         =   0   'False
      Width           =   960
      _ExtentX        =   1693
      _ExtentY        =   741
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmObras.frx":1BBA
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin RichTextLib.RichTextBox RichTextBox2 
      Height          =   195
      Left            =   5985
      TabIndex        =   67
      Top             =   3420
      Visible         =   0   'False
      Width           =   420
      _ExtentX        =   741
      _ExtentY        =   344
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmObras.frx":1BD6
   End
   Begin RichTextLib.RichTextBox RichTextBox3 
      Height          =   195
      Left            =   6435
      TabIndex        =   68
      Top             =   3420
      Visible         =   0   'False
      Width           =   420
      _ExtentX        =   741
      _ExtentY        =   344
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmObras.frx":1C58
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      DataField       =   "IdLocalidad"
      Height          =   315
      Index           =   0
      Left            =   3330
      TabIndex        =   78
      Tag             =   "Localidades"
      Top             =   8640
      Visible         =   0   'False
      Width           =   3195
      _ExtentX        =   5636
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdLocalidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      DataField       =   "IdProvincia"
      Height          =   315
      Index           =   1
      Left            =   3330
      TabIndex        =   79
      Tag             =   "Provincias"
      Top             =   9000
      Visible         =   0   'False
      Width           =   3195
      _ExtentX        =   5636
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProvincia"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      DataField       =   "IdPais"
      Height          =   315
      Index           =   2
      Left            =   3330
      TabIndex        =   80
      Tag             =   "Paises"
      Top             =   9720
      Visible         =   0   'False
      Width           =   3195
      _ExtentX        =   5636
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPais"
      Text            =   ""
   End
   Begin Controles1013.DbListView ListaDestinos 
      Height          =   555
      Left            =   8730
      TabIndex        =   100
      Top             =   45
      Visible         =   0   'False
      Width           =   915
      _ExtentX        =   1614
      _ExtentY        =   979
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmObras.frx":1CDA
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaContableFF"
      Height          =   315
      Index           =   6
      Left            =   2070
      TabIndex        =   102
      Tag             =   "Cuentas"
      Top             =   2475
      Width           =   2490
      _ExtentX        =   4392
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdMonedaValorObra"
      Height          =   315
      Index           =   7
      Left            =   6615
      TabIndex        =   106
      Tag             =   "Monedas"
      Top             =   2520
      Width           =   915
      _ExtentX        =   1614
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin Controles1013.DbListView ListaSectores 
      Height          =   420
      Left            =   9360
      TabIndex        =   115
      Top             =   180
      Visible         =   0   'False
      Width           =   960
      _ExtentX        =   1693
      _ExtentY        =   741
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmObras.frx":1CF6
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Label lblTitulosListas 
      AutoSize        =   -1  'True
      Caption         =   "Detalle de sectores :"
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
      Index           =   4
      Left            =   9315
      TabIndex        =   114
      Top             =   3375
      Visible         =   0   'False
      Width           =   1785
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Valor obra :"
      Height          =   240
      Index           =   2
      Left            =   4635
      TabIndex        =   104
      Top             =   2520
      Width           =   960
   End
   Begin VB.Label lblData 
      Caption         =   "Cuenta cont. FF (opc.)"
      Height          =   240
      Index           =   4
      Left            =   135
      TabIndex        =   103
      Top             =   2520
      Width           =   1815
   End
   Begin VB.Label lblTitulosListas 
      AutoSize        =   -1  'True
      Caption         =   "Detalle de etapas :"
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
      Index           =   3
      Left            =   6615
      TabIndex        =   101
      Top             =   3465
      Visible         =   0   'False
      Width           =   1635
   End
   Begin VB.Label lblMasDatos 
      Caption         =   "Zona :"
      Height          =   240
      Index           =   12
      Left            =   8685
      TabIndex        =   99
      Top             =   9810
      Visible         =   0   'False
      Width           =   465
   End
   Begin VB.Label lblMasDatos 
      Caption         =   "Operarios :"
      Height          =   240
      Index           =   11
      Left            =   6660
      TabIndex        =   97
      Top             =   9810
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.Label lblMasDatos 
      Caption         =   "Jurisdiccion :"
      Height          =   240
      Index           =   10
      Left            =   9720
      TabIndex        =   95
      Top             =   9810
      Visible         =   0   'False
      Width           =   915
   End
   Begin VB.Label lblMasDatos 
      Caption         =   "Turnos :"
      Height          =   240
      Index           =   9
      Left            =   9720
      TabIndex        =   93
      Top             =   9450
      Visible         =   0   'False
      Width           =   690
   End
   Begin VB.Label lblMasDatos 
      Caption         =   "Horario :"
      Height          =   240
      Index           =   8
      Left            =   6660
      TabIndex        =   91
      Top             =   9450
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.Label lblMasDatos 
      Caption         =   "Responsable :"
      Height          =   240
      Index           =   7
      Left            =   6660
      TabIndex        =   89
      Top             =   9090
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.Label lblMasDatos 
      Caption         =   "Lugar de pago :"
      Height          =   240
      Index           =   6
      Left            =   6660
      TabIndex        =   87
      Top             =   8730
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.Label lblMasDatos 
      Caption         =   "Telefonos :"
      Height          =   240
      Index           =   5
      Left            =   6660
      TabIndex        =   85
      Top             =   8370
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.Label lblMasDatos 
      Caption         =   "Pais :"
      Height          =   240
      Index           =   4
      Left            =   1980
      TabIndex        =   84
      Top             =   9765
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.Label lblMasDatos 
      Caption         =   "Codigo postal : "
      Height          =   240
      Index           =   3
      Left            =   1980
      TabIndex        =   83
      Top             =   9405
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.Label lblMasDatos 
      Caption         =   "Provincia :"
      Height          =   240
      Index           =   2
      Left            =   1980
      TabIndex        =   82
      Top             =   9045
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.Label lblMasDatos 
      Caption         =   "Localidad :"
      Height          =   240
      Index           =   1
      Left            =   1980
      TabIndex        =   81
      Top             =   8685
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.Label lblMasDatos 
      Caption         =   "Direccion : "
      Height          =   240
      Index           =   0
      Left            =   1980
      TabIndex        =   75
      Top             =   8355
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.Label lblObservaciones 
      Caption         =   "Observaciones reinstalacion :"
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
      Index           =   2
      Left            =   7515
      TabIndex        =   70
      Top             =   3510
      Visible         =   0   'False
      Width           =   2715
   End
   Begin VB.Label lblObservaciones 
      Caption         =   "Observaciones desinstalacion :"
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
      Index           =   1
      Left            =   7515
      TabIndex        =   69
      Top             =   3285
      Visible         =   0   'False
      Width           =   2715
   End
   Begin VB.Label lblTitulosListas 
      AutoSize        =   -1  'True
      Caption         =   "Detalle de equipos instalados :"
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
      Index           =   2
      Left            =   6615
      TabIndex        =   64
      Top             =   5040
      Visible         =   0   'False
      Width           =   2640
   End
   Begin VB.Label lblData 
      Caption         =   "Unidad operativa :"
      Height          =   240
      Index           =   3
      Left            =   135
      TabIndex        =   62
      Top             =   1485
      Width           =   1815
   End
   Begin VB.Label lblTitulosListas 
      AutoSize        =   -1  'True
      Caption         =   "Detalle de recepciones provisorias : "
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
      Index           =   1
      Left            =   135
      TabIndex        =   60
      Top             =   5040
      Width           =   3135
   End
   Begin VB.Label lblData 
      Caption         =   "Grupo obra :"
      Height          =   240
      Index           =   1
      Left            =   4410
      TabIndex        =   58
      Top             =   1485
      Width           =   1005
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 1 :"
      Height          =   255
      Index           =   0
      Left            =   2025
      TabIndex        =   53
      Top             =   6705
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 2 :"
      Height          =   255
      Index           =   1
      Left            =   2025
      TabIndex        =   52
      Top             =   7020
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 3 :"
      Height          =   255
      Index           =   2
      Left            =   2025
      TabIndex        =   51
      Top             =   7335
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 4 :"
      Height          =   255
      Index           =   3
      Left            =   2025
      TabIndex        =   50
      Top             =   7650
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 5 :"
      Height          =   255
      Index           =   4
      Left            =   2025
      TabIndex        =   49
      Top             =   7965
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 6 :"
      Height          =   255
      Index           =   5
      Left            =   6705
      TabIndex        =   48
      Top             =   6660
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 7 :"
      Height          =   255
      Index           =   6
      Left            =   6705
      TabIndex        =   47
      Top             =   6975
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 8 :"
      Height          =   255
      Index           =   7
      Left            =   6705
      TabIndex        =   46
      Top             =   7290
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 9 :"
      Height          =   255
      Index           =   8
      Left            =   6705
      TabIndex        =   45
      Top             =   7650
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 10 :"
      Height          =   255
      Index           =   9
      Left            =   6705
      TabIndex        =   44
      Top             =   7965
      Width           =   1230
   End
   Begin VB.Label lblTitulosListas 
      AutoSize        =   -1  'True
      Caption         =   "Detalle de polizas para la obra : "
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
      Left            =   135
      TabIndex        =   33
      Top             =   3420
      Width           =   2790
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Jerarquia Contable :"
      Height          =   195
      Index           =   5
      Left            =   2925
      TabIndex        =   31
      Top             =   2790
      Width           =   1500
   End
   Begin VB.Label lblArticulo 
      Caption         =   "Articulo asociado (opc.) :"
      Height          =   240
      Left            =   135
      TabIndex        =   30
      Top             =   2205
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Horas estimadas :"
      Height          =   210
      Index           =   7
      Left            =   3330
      TabIndex        =   26
      Top             =   3420
      Width           =   1275
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Tipo de obra :"
      Height          =   285
      Index           =   6
      Left            =   135
      TabIndex        =   25
      Top             =   405
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripcion :"
      Height          =   240
      Index           =   0
      Left            =   135
      TabIndex        =   24
      Top             =   795
      Width           =   1815
   End
   Begin VB.Label lblFechas 
      Caption         =   "Entrega :"
      Height          =   210
      Index           =   1
      Left            =   4905
      TabIndex        =   23
      Top             =   180
      Width           =   1140
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Obra :"
      Height          =   240
      Index           =   1
      Left            =   135
      TabIndex        =   22
      Top             =   60
      Width           =   1815
   End
   Begin VB.Label lblObservaciones 
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
      Index           =   0
      Left            =   7605
      TabIndex        =   21
      Top             =   135
      Width           =   1320
   End
   Begin VB.Label lblFechas 
      Caption         =   "Alta :"
      Height          =   180
      Index           =   0
      Left            =   3690
      TabIndex        =   20
      Top             =   180
      Width           =   1140
   End
   Begin VB.Label lblFechas 
      Caption         =   "Finalizacion :"
      Height          =   210
      Index           =   2
      Left            =   6120
      TabIndex        =   19
      Top             =   180
      Width           =   1320
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cliente :"
      Height          =   240
      Index           =   4
      Left            =   135
      TabIndex        =   18
      Top             =   1125
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
   End
   Begin VB.Menu MnuDetRec 
      Caption         =   "DetalleRecepciones"
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
   Begin VB.Menu MnuDetEqu 
      Caption         =   "DetalleEquiposInstalados"
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
   Begin VB.Menu MnuDetDest 
      Caption         =   "DetalleDestinos"
      Visible         =   0   'False
      Begin VB.Menu MnuDetD 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetD 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetD 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
   Begin VB.Menu MnuDetSec 
      Caption         =   "DetalleSectores"
      Visible         =   0   'False
      Begin VB.Menu MnuDetE 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetE 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetE 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
End
Attribute VB_Name = "frmObras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Obra
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long
Private mConJerarquia As Boolean
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

   Dim oF As frmDetObrasPolizas
   Dim oL As ListItem
   
   Set oF = New frmDetObrasPolizas
   
   With oF
      Set .Obra = origen
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
            .Text = oF.DataCombo1(1).Text
            .SubItems(1) = "" & oF.DataCombo1(0).Text
            .SubItems(2) = "" & oF.txtNumeroPoliza.Text
            .SubItems(3) = "" & oF.DTPicker1(0).Value
            .SubItems(4) = "" & oF.DTPicker1(1).Value
            .SubItems(5) = "" & oF.txtImporte.Text
            .SubItems(6) = "" & oF.DTPicker1(2).Value
            .SubItems(7) = "" & oF.DTPicker1(3).Value
            .SubItems(8) = "" & oF.txtCondicionRecupero.Text
            .SubItems(9) = "" & oF.txtMotivoDeContratacionSeguro.Text
            .SubItems(10) = "" & oF.rchObservaciones.Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Sub EditarRecepciones(ByVal Cual As Long)

   Dim oF As frmDetObrasRecepciones
   Dim oL As ListItem
   
   Set oF = New frmDetObrasRecepciones
   
   With oF
      Set .Obra = origen
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaRecepciones.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaRecepciones.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtNumeroRecepcion.Text
            .SubItems(1) = "" & oF.DTPicker1(0).Value
            If oF.Option1.Value Then
               .SubItems(2) = "Provisoria"
            Else
               .SubItems(2) = "Definitiva"
            End If
            .SubItems(3) = "" & oF.rchObservaciones.Text
            .SubItems(4) = "" & oF.DataCombo1(0).Text
            .SubItems(5) = "" & oF.txtFechaRealizo.Text
            .SubItems(6) = "" & oF.DataCombo1(1).Text
            .SubItems(7) = "" & oF.txtFechaAprobo.Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Sub EditarEquiposInstalados(ByVal Cual As Long)

   Dim oF As frmDetObrasEquiposInstalados
   Dim oL As ListItem
   
   Set oF = New frmDetObrasEquiposInstalados
   
   With oF
      Set .Obra = origen
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaEquiposInstalados.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaEquiposInstalados.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtCodigoArticulo.Text
            .SubItems(1) = "" & oF.DataCombo1(1).Text
            .SubItems(2) = "" & oF.txtCantidad.Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Sub EditarDestinos(ByVal Cual As Long)

   Dim oF As frmDetObrasDestinos
   Dim oL As ListItem
   
   Set oF = New frmDetObrasDestinos
   
   With oF
      Set .Obra = origen
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaDestinos.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaDestinos.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtDestino.Text
            .SubItems(1) = "" & oF.rchObservaciones.Text
            If oF.Check1 = 1 Then
               .SubItems(2) = "SI"
            Else
               .SubItems(2) = ""
            End If
            .SubItems(3) = "" & oF.txtInformacionAuxiliar.Text
            If oF.Option1 Then
               .SubItems(4) = "Directo"
            ElseIf oF.Option2 Then
               .SubItems(4) = "Indirecto"
            Else
               .SubItems(4) = "Ambos"
            End If
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Sub EditarSectores(ByVal Cual As Long)

   Dim oF As frmDetObrasSectores
   Dim oL As ListItem
   
   Set oF = New frmDetObrasSectores
   
   With oF
      Set .Obra = origen
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaSectores.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaSectores.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtDescripcion.Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Private Sub Check2_Click()

   If Check2.Value = 1 Then
      DataCombo1(0).Enabled = True
   Else
      origen.Registro.Fields("IdCLiente").Value = Null
      DataCombo1(0).Enabled = False
   End If
   
End Sub

Private Sub Check3_Click()

   If Check3.Value = 1 Then
   Else
      origen.Registro.Fields("IdArticuloAsociado").Value = Null
   End If
   
End Sub

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
      Case 0
         Dim est As EnumAcciones
         Dim oControl As Control
         Dim dtp As DTPicker
         Dim i As Integer, mvarSeguro As Integer
         Dim mNiveles(4) As Integer
         Dim mJerarquias As String
      
         If Len(Trim(txtCodigoObra.Text)) = 0 Then
            MsgBox "Falta completar el campo numero de obra", vbCritical
            Exit Sub
         End If
         
         If Len(Trim(txtDescripcion.Text)) = 0 Then
            MsgBox "Falta completar el campo descripcion de obra", vbCritical
            Exit Sub
         End If
         
         If DTPicker1(0).Value > DTPicker1(2).Value Then
            MsgBox "La fecha de alta no puede ser posterior a la de entrega", vbCritical
            Exit Sub
         End If
         
         For Each dtp In DTPicker1
            origen.Registro.Fields(dtp.DataField).Value = dtp.Value
         Next
         
         If mvarId < 0 Then
            origen.Registro.Fields("FechaFinalizacion").Value = Null
         Else
            If Not IsNull(origen.Registro.Fields("FechaFinalizacion").Value) Then
               mvarSeguro = MsgBox("Desea pasar la obra a historicos ahora ?", vbYesNo, "Obra finalizada")
               If mvarSeguro = vbYes Then
                  Option2.Value = True
                  Aplicacion.Tarea "Obras_EliminarCuentasNoUsadasPorIdObra", mvarId
               End If
            End If
         End If
         
         For Each oControl In Me.Controls
            If TypeOf oControl Is DataCombo Then
               If Len(oControl.BoundText) <> 0 And IsNumeric(oControl.BoundText) Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
               Else
                  If oControl.Enabled And oControl.Visible And _
                        oControl.Index <> 2 And oControl.Index <> 3 And _
                        oControl.Index <> 5 And oControl.Index <> 6 And _
                        oControl.Name <> "DataCombo2" Then
                     MsgBox "Falta completar el campo " & oControl.Tag, vbCritical
                     Exit Sub
                  End If
               End If
            ElseIf TypeOf oControl Is DTPicker Then
               origen.Registro.Fields(oControl.DataField).Value = oControl.Value
            End If
         Next
      
         For i = 0 To 4
            If Len(Trim(txtJerarquia(i).Text)) > 0 Then mNiveles(i) = txtJerarquia(i).Text
            'mJerarquias = mJerarquias & txtJerarquia(i).Text & "."
         Next
         mJerarquias = "" & mNiveles(0) & "." & mNiveles(1) & "." & Format(mNiveles(2), "00") & "." & _
                        Format(mNiveles(3), "00") & "." & Format(mNiveles(4), "000")
'         If Len(mJerarquias) > 0 Then mJerarquias = mId(mJerarquias, 1, Len(mJerarquias) - 1)
'         If Len(mJerarquias) <> 12 Then
'            MsgBox "Debe completar la jerarquia contable de la obra", vbExclamation
'            Exit Sub
'         End If

         With origen.Registro
            .Fields("TipoObra").Value = Combo1.ListIndex + 1
            .Fields("EnviarEmail").Value = 1
            If Option1.Value Then
               .Fields("Activa").Value = "SI"
            Else
               .Fields("Activa").Value = "NO"
            End If
            If Len(mJerarquias) = 13 And mJerarquias <> "0.0.00.00.000" Then
               .Fields("Jerarquia").Value = mJerarquias
            Else
               .Fields("Jerarquia").Value = Null
            End If
            For i = 0 To 9
               .Fields("ArchivoAdjunto" & i + 1).Value = FileBrowser1(i).Text
            Next
            If Check1.Value = 1 Then
               .Fields("GeneraReservaStock").Value = "SI"
            Else
               .Fields("GeneraReservaStock").Value = "NO"
            End If
            .Fields("Observaciones").Value = RichTextBox1.Text
            .Fields("Observaciones2").Value = RichTextBox2.Text
            .Fields("Observaciones3").Value = RichTextBox3.Text
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
         ElseIf Option2.Value Then
            est = baja
         Else
            est = Modificacion
         End If
            
         If Not mConJerarquia And Len(mJerarquias) = 13 And mJerarquias <> "0.0.00.00.000" Then
            Dim oAp As ComPronto.Aplicacion
            Dim oRs As ADOR.Recordset
            Dim oCuenta As ComPronto.Cuenta
            Dim oPar As ComPronto.Parametro
            Dim mNumeroCuenta As Long, mNumJer As Integer, mNumJer1 As Integer
         
            Set oAp = Aplicacion
            
            Set oPar = oAp.Parametros.Item(1)
            mNumeroCuenta = oPar.Registro.Fields("ProximoNumeroCuentaContable").Value
            
            Set oRs = oAp.CuentasGastos.TraerFiltrado("_TodasActivas")
            If oRs.RecordCount > 0 Then
               oRs.MoveFirst
               Set oCuenta = oAp.Cuentas.Item(-1)
               With oCuenta.Registro
                  .Fields("Codigo").Value = mNumeroCuenta
                  .Fields("Descripcion").Value = origen.Registro.Fields("NumeroObra").Value
                  .Fields("IdTipoCuenta").Value = 1
                  .Fields("IdRubroContable").Value = Null
                  .Fields("IdObra").Value = mvarId
                  .Fields("IdCuentaGasto").Value = Null
                  .Fields("Jerarquia").Value = mJerarquias
                  .Fields("DebeHaber").Value = "D"
                  mNumeroCuenta = mNumeroCuenta + 1
               End With
               oCuenta.Guardar
               Set oCuenta = Nothing
               mNumJer = 1
               mNumJer1 = mNiveles(3)
               Do While Not oRs.EOF
                  Set oCuenta = oAp.Cuentas.Item(-1)
                  With oCuenta.Registro
                     .Fields("Codigo").Value = mNumeroCuenta
                     .Fields("Descripcion").Value = oRs.Fields("Descripcion").Value
                     If IIf(IsNull(oRs.Fields("Titulo").Value), "", oRs.Fields("Titulo").Value) = "SI" Then
                        .Fields("IdTipoCuenta").Value = 1
                        mNumJer1 = mNumJer1 + 1
                        mNumJer = 0
                        mJerarquias = "" & mNiveles(0) & "." & mNiveles(1) & "." & Format(mNiveles(2), "00") & "." & _
                                       Format(mNumJer1, "00") & "." & Format(mNumJer, "000")
                     Else
                        .Fields("IdTipoCuenta").Value = 2
                        mJerarquias = "" & mNiveles(0) & "." & mNiveles(1) & "." & Format(mNiveles(2), "00") & "." & _
                                       Format(mNumJer1, "00") & "." & Format(mNumJer, "000")
                     End If
                     .Fields("IdRubroContable").Value = oRs.Fields("IdRubroContable").Value
                     .Fields("IdObra").Value = mvarId
                     .Fields("IdCuentaGasto").Value = oRs.Fields("IdCuentaGasto").Value
                     .Fields("Jerarquia").Value = mJerarquias
                     .Fields("DebeHaber").Value = "D"
                     mNumeroCuenta = mNumeroCuenta + 1
                     mNumJer = mNumJer + 1
                  End With
                  oCuenta.Guardar
                  Set oCuenta = Nothing
                  oRs.MoveNext
               Loop
            End If
            oRs.Close
            Set oRs = Nothing
            
            oPar.Registro.Fields("ProximoNumeroCuentaContable").Value = mNumeroCuenta
            oPar.Guardar
            Set oPar = Nothing
         End If
         
         With actL2
            .ListaEditada = "Obras,Obras1,AObras"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
      Case 1
         Dim oRs1 As ADOR.Recordset
         Set oRs1 = Aplicacion.Obras.TraerFiltrado("_ValidarParaBaja", mvarId)
         If oRs1.RecordCount > 0 Then
            MsgBox "La obra esta incluida en " & oRs1.Fields("Tipo").Value & " " & _
                  "y no puede eliminarse.", vbCritical
            oRs1.Close
            Set oRs1 = Nothing
            Exit Sub
         End If
         oRs1.Close
         Set oRs1 = Nothing
         
         Dim mBorra As Integer
         mBorra = MsgBox("Esta seguro de eliminar los datos definitivamente ?", vbYesNo, "Eliminar")
         If mBorra = vbNo Then
            Exit Sub
         End If
         
         origen.Eliminar
         
         est = baja
            
         With actL2
            .ListaEditada = "Obras,Obras1,AObras"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
      Case 3
         ActivarControlesAdicionales
         Exit Sub
   End Select
   
   Unload Me

   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case -2147217900
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
   Dim oControl As Control
   Dim dtp As DTPicker
   Dim i As Integer, mvarIdMonedaPesos As Integer
   Dim mIdFiltroDominios As Long
   Dim mJerarquias
   Dim ListaVacia1 As Boolean, ListaVacia2 As Boolean, ListaVacia3 As Boolean
   Dim ListaVacia4 As Boolean, ListaVacia5 As Boolean
   Dim oRs As ADOR.Recordset
   
   mvarId = vNewValue
   ListaVacia1 = False
   ListaVacia2 = False
   ListaVacia3 = False
   ListaVacia4 = False
   ListaVacia5 = False
   
   mIdFiltroDominios = Val(BuscarClaveINI("IdTipo para filtrar dominios"))
   
   Set oAp = Aplicacion
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      mvarIdMonedaPesos = IIf(IsNull(.Fields("IdMoneda").Value), 1, .Fields("IdMoneda").Value)
   End With
   oRs.Close
   
   Set origen = oAp.Obras.Item(vNewValue)
   
   If glbParametrizacionNivel1 Then
      lblFieldLabel(4).Visible = False
      Check2.Visible = False
      DataCombo1(0).Visible = False
      txtCodigoCliente.Visible = False
      lblData(1).Visible = False
      DataCombo1(3).Visible = False
      lblTitulosListas(0).Visible = False
      Lista.Visible = False
      lblTitulosListas(1).Visible = False
      ListaRecepciones.Visible = False
      cmdPlantilla.Visible = False
      'Acomodar controles
      cmd(0).Top = txtHorasEstimadas.Top + txtHorasEstimadas.Height + 100
      cmd(1).Top = cmd(0).Top + cmd(0).Height + 100
      cmd(2).Top = cmd(1).Top + cmd(1).Height + 100
      cmdImpreInst(1).Top = cmd(2).Top + cmd(2).Height + 100
      lblAdjuntos(0).Top = cmd(0).Top
      FileBrowser1(0).Top = cmd(0).Top
      lblAdjuntos(5).Top = cmd(0).Top
      FileBrowser1(5).Top = cmd(0).Top
      For i = 1 To 4
         lblAdjuntos(i).Top = lblAdjuntos(i - 1).Top + lblAdjuntos(i - 1).Height + 100
         FileBrowser1(i).Top = lblAdjuntos(i).Top
         lblAdjuntos(i + 5).Top = lblAdjuntos(i - 1).Top + lblAdjuntos(i - 1).Height + 100
         FileBrowser1(i + 5).Top = lblAdjuntos(i + 5).Top
      Next
      Me.Height = Me.Height * 0.7
   
   End If
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetObrasPolizas.TraerFiltrado("Primero")
                     ListaVacia1 = True
                  Else
                     Set oRs = origen.DetObrasPolizas.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia1 = False
                     Else
                        Set oControl.DataSource = origen.DetObrasPolizas.TraerFiltrado("Primero")
                        ListaVacia1 = True
                     End If
                  End If
               Case "ListaRecepciones"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetObrasRecepciones.TraerFiltrado("Primero")
                     ListaVacia2 = True
                  Else
                     Set oRs = origen.DetObrasRecepciones.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia2 = False
                     Else
                        Set oControl.DataSource = origen.DetObrasRecepciones.TraerFiltrado("Primero")
                        ListaVacia2 = True
                     End If
                  End If
               Case "ListaEquiposInstalados"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetObrasEquiposInstalados.TraerFiltrado("Primero")
                     ListaVacia3 = True
                  Else
                     Set oRs = origen.DetObrasEquiposInstalados.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia3 = False
                     Else
                        Set oControl.DataSource = origen.DetObrasEquiposInstalados.TraerFiltrado("Primero")
                        ListaVacia3 = True
                     End If
                  End If
               Case "ListaDestinos"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetObrasDestinos.TraerFiltrado("Primero")
                     ListaVacia4 = True
                  Else
                     Set oRs = origen.DetObrasDestinos.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia4 = False
                     Else
                        Set oControl.DataSource = origen.DetObrasDestinos.TraerFiltrado("Primero")
                        ListaVacia4 = True
                     End If
                  End If
               Case "ListaSectores"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetObrasSectores.TraerFiltrado("Primero")
                     ListaVacia5 = True
                  Else
                     Set oRs = origen.DetObrasSectores.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia5 = False
                     Else
                        Set oControl.DataSource = origen.DetObrasSectores.TraerFiltrado("Primero")
                        ListaVacia5 = True
                     End If
                  End If
            End Select
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Articulos" Then
                  If mIdFiltroDominios <> 0 Then
                     Set oControl.RowSource = oAp.Articulos.TraerFiltrado("_PorIdTipoParaCombo", mIdFiltroDominios)
                  Else
                     Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
                  End If
               ElseIf oControl.Tag = "Cuentas" Then
                  Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_FondosFijos")
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
   
   If mvarId < 0 Then
      For Each dtp In DTPicker1
         If dtp.Enabled Then
            dtp.Value = Date
         End If
      Next
      With origen.Registro
         .Fields("Consorcial").Value = "NO"
         .Fields("FechaFinalizacion").Value = Null
         .Fields("IdMonedaValorObra").Value = mvarIdMonedaPesos
      End With
      Combo1.ListIndex = 0
      Option1.Value = True
      With txtJerarquia(4)
         .Text = "000"
         .Locked = True
      End With
      mConJerarquia = False
      Check1.Value = 1
      Check2.Value = 1
      Check3.Value = 1
      DTPicker1(1).Enabled = False
   Else
      With origen.Registro
         Combo1.ListIndex = IIf(IsNull(.Fields("TipoObra").Value), 0, .Fields("TipoObra").Value - 1)
         If .Fields("Activa").Value = "SI" Then
            Option1.Value = True
         Else
            Option2.Value = True
         End If
         If Not IsNull(.Fields("Jerarquia").Value) Then
            mJerarquias = VBA.Split(.Fields("Jerarquia").Value, ".")
            For i = 0 To 4
               With txtJerarquia(i)
                  .Text = mJerarquias(i)
                  .Enabled = False
               End With
            Next
            mConJerarquia = True
         Else
            With txtJerarquia(4)
               .Text = "000"
               .Locked = True
            End With
            mConJerarquia = False
         End If
         For i = 0 To 9
            FileBrowser1(i).Text = .Fields("ArchivoAdjunto" & i + 1).Value
         Next
         If IsNull(.Fields("GeneraReservaStock").Value) Or _
               .Fields("GeneraReservaStock").Value = "SI" Then
            Check1.Value = 1
         Else
            Check1.Value = 0
         End If
         If Not IsNull(.Fields("IdCliente").Value) Then
            Check2.Value = 1
         Else
            Check2.Value = 0
            DataCombo1(0).Enabled = False
         End If
         If Not IsNull(.Fields("IdArticuloAsociado").Value) Then
            Check3.Value = 1
         Else
            Check3.Value = 0
         End If
         RichTextBox1.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
         RichTextBox2.TextRTF = IIf(IsNull(.Fields("Observaciones2").Value), "", .Fields("Observaciones2").Value)
         RichTextBox3.TextRTF = IIf(IsNull(.Fields("Observaciones3").Value), "", .Fields("Observaciones3").Value)
         If IsNull(.Fields("IdMonedaValorObra").Value) Then
            .Fields("IdMonedaValorObra").Value = mvarIdMonedaPesos
         End If
      End With
   End If
   
   If ListaVacia1 Then Lista.ListItems.Clear
   If ListaVacia2 Then ListaRecepciones.ListItems.Clear
   If ListaVacia3 Then ListaEquiposInstalados.ListItems.Clear
   If ListaVacia4 Then ListaDestinos.ListItems.Clear
   If ListaVacia5 Then ListaSectores.ListItems.Clear
   
   cmd(1).Enabled = False
   cmd(0).Enabled = False
   cmdMateriales.Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then
         cmd(0).Enabled = True
         cmdMateriales.Enabled = True
      End If
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      cmdMateriales.Enabled = True
      If mvarId > 0 Then cmd(1).Enabled = True
   End If
   
   If BuscarClaveINI("Obras_AccesoAMateriales") = "SI" Then
      cmdMateriales.Visible = True
      lblArticulo.Visible = True
      DataCombo1(2).Visible = True
      Check3.Visible = True
   End If
   
   If BuscarClaveINI("Obras_AccesoAEquiposInstalados") = "SI" Then
      lblTitulosListas(2).Visible = True
      With ListaRecepciones
         .Width = .Width / 2
      End With
      With ListaEquiposInstalados
         .Top = ListaRecepciones.Top
         .Left = ListaRecepciones.Left + ListaRecepciones.Width
         .Width = ListaRecepciones.Width
         .Height = ListaRecepciones.Height
         .Visible = True
      End With
      With lblTitulosListas(2)
         .Left = ListaEquiposInstalados.Left
         .Visible = True
      End With
   End If
   
   If BuscarClaveINI("Obras_AccesoADestinos") = "SI" Then
      If BuscarClaveINI("Presupuestador de obra nuevo") = "SI" Then
      Else
         lblTitulosListas(3).Visible = True
         With Lista
            .Width = .Width / 2
         End With
         With ListaDestinos
            .Top = Lista.Top
            .Left = Lista.Left + Lista.Width
            .Width = Lista.Width
            .Height = Lista.Height
            .Visible = True
         End With
         With lblTitulosListas(3)
            .Left = ListaDestinos.Left
            .Visible = True
         End With
      End If
      
      lblTitulosListas(4).Visible = True
      With ListaRecepciones
         .Width = .Width / 2
      End With
      With ListaSectores
         .Top = ListaRecepciones.Top
         .Left = ListaRecepciones.Left + ListaRecepciones.Width
         .Width = ListaRecepciones.Width
         .Height = ListaRecepciones.Height
         .Visible = True
      End With
      With lblTitulosListas(4)
         .Top = lblTitulosListas(2).Top
         .Left = ListaSectores.Left
         .Visible = True
      End With
   End If
   
   If BuscarClaveINI("Dominios en obra") = "SI" Then
      lblFechas(0).Caption = "Contrato:"
      lblFechas(1).Caption = "Instalacion:"
      lblFechas(2).Caption = "Desinstalacion:"
      With RichTextBox1
         .Height = .Height / 3
      End With
      With lblObservaciones(1)
         .Top = RichTextBox1.Top + RichTextBox1.Height
         .Left = lblObservaciones(0).Left
         .Visible = True
      End With
      With RichTextBox2
         .Top = lblObservaciones(1).Top + lblObservaciones(1).Height
         .Left = RichTextBox1.Left
         .Width = RichTextBox1.Width
         .Height = RichTextBox1.Height
         .Visible = True
      End With
      With lblObservaciones(2)
         .Top = RichTextBox2.Top + RichTextBox2.Height
         .Left = lblObservaciones(0).Left
         .Visible = True
      End With
      With RichTextBox3
         .Top = lblObservaciones(2).Top + lblObservaciones(2).Height
         .Left = RichTextBox1.Left
         .Width = RichTextBox1.Width
         .Height = RichTextBox1.Height
         .Visible = True
      End With
   End If
   
   If BuscarClaveINI("Mostrar parte de instalacion") = "SI" Then
      cmdImpreInst(1).Visible = True
      If mvarId < 0 Then cmdImpreInst(1).Enabled = False
   End If
   
   If BuscarClaveINI("Datos adicionales en obras") = "SI" Then
      cmd(3).Visible = True
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub cmdImpreInst_Click(Index As Integer)

   EmisionParteInstalacion mvarId, 0, DTPicker1(0).Value
   
End Sub

Private Sub cmdMateriales_Click()

   Dim mIdArticulo As Long
   If IsNumeric(DataCombo1(2).BoundText) Then
      mIdArticulo = DataCombo1(2).BoundText
   Else
      mIdArticulo = -1
   End If
   Dim oF As frmArticulos
   Set oF = New frmArticulos
   With oF
      .NivelAcceso = EnumAccesos.Alto
      .Id = mIdArticulo
      .Show vbModal, Me
      If .Id > 0 And mIdArticulo = -1 Then
         Set DataCombo1(2).RowSource = Aplicacion.Articulos.TraerLista
         origen.Registro.Fields("IdArticuloAsociado").Value = .Id
         Check3.Value = 1
      End If
   End With
   Unload oF
   Set oF = Nothing

End Sub

Private Sub cmdPlantilla_Click()

   Dim oEx As Excel.Application
   Dim oRs As ADOR.Recordset
   Dim mDireccion As String
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      With .Workbooks.Add(glbPathPlantillas & "\FormularioObra.xlt")
         With .ActiveSheet
            .Cells(3, 6) = txtCodigoObra.Text
            .Cells(3, 12) = DTPicker1(0).Value
            .Cells(4, 10) = glbNombreUsuario
            If IsNumeric(DataCombo1(0).BoundText) Then
               Set oRs = Aplicacion.Clientes.TraerFiltrado("_PorIdConDatos", DataCombo1(0).BoundText)
               If oRs.RecordCount > 0 Then
                  mDireccion = ""
                  If Not IsNull(oRs.Fields("Direccion").Value) Then
                     mDireccion = mDireccion & Trim(oRs.Fields("Direccion").Value)
                  End If
                  If Not IsNull(oRs.Fields("Localidad").Value) Then
                     If Len(Trim(mDireccion)) > 0 Then mDireccion = mDireccion & "  -  "
                     mDireccion = mDireccion & Trim(oRs.Fields("Localidad").Value)
                  End If
                  If Not IsNull(oRs.Fields("Provincia").Value) Then
                     If oRs.Fields("Provincia").Value <> "Capital Federal" Then
                        If Len(Trim(mDireccion)) > 0 Then mDireccion = mDireccion & "  -  "
                        mDireccion = mDireccion & Trim(oRs.Fields("Provincia").Value)
                     End If
                  End If
                  If Not IsNull(oRs.Fields("Pais").Value) Then
                     If Len(Trim(mDireccion)) > 0 Then mDireccion = mDireccion & "  -  "
                     mDireccion = mDireccion & Trim(oRs.Fields("Pais").Value)
                  End If
                  .Cells(7, 5) = oRs.Fields("RazonSocial").Value
                  .Cells(7, 12) = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
                  .Cells(9, 4) = mDireccion
                  .Cells(10, 4) = IIf(IsNull(oRs.Fields("CodigoPostal").Value), "", oRs.Fields("CodigoPostal").Value)
                  .Cells(10, 6) = IIf(IsNull(oRs.Fields("Telefono").Value), "", oRs.Fields("Telefono").Value)
                  .Cells(10, 10) = IIf(IsNull(oRs.Fields("Fax").Value), "", oRs.Fields("Fax").Value)
                  .Cells(10, 12) = IIf(IsNull(oRs.Fields("Email").Value), "", oRs.Fields("Email").Value)
               End If
               oRs.Close
            End If
         End With
      End With
   End With
   
   Set oRs = Nothing
   Set oEx = Nothing

End Sub

Private Sub Combo1_Click()

'   If Combo1.ListIndex = 0 Then
'      DataCombo1(1).Enabled = False
'      origen.Registro.Fields("IdJefe").Value = Null
'   Else
'      DataCombo1(1).Enabled = True
'   End If
   
End Sub

Private Sub Combo1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DataCombo1_Change(Index As Integer)

   Dim oRs As ADOR.Recordset
   If Index = 0 Then
      txtCodigoCliente.Text = ""
      If IsNumeric(DataCombo1(Index).BoundText) Then
         Set oRs = Aplicacion.Clientes.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
         If oRs.RecordCount > 0 Then
            txtCodigoCliente.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
         End If
         oRs.Close
         Set oRs = Nothing
      End If
   ElseIf Index = 2 Then
      If DataCombo1(Index).Visible And IsNumeric(DataCombo1(Index).BoundText) Then
         Set oRs = Aplicacion.Obras.TraerFiltrado("_ControlDominioEnObra", Array(mvarId, DataCombo1(Index).BoundText))
         If oRs.RecordCount > 0 Then
            MsgBox "El dominio ya esta en la obra " & oRs.Fields("Descripcion").Value, vbExclamation
            origen.Registro.Fields("IdArticuloAsociado").Value = Null
         End If
         oRs.Close
         Set oRs = Nothing
      End If
   End If

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DTPicker1_Click(Index As Integer)

   If Index = 1 Then
      If IsNull(origen.Registro.Fields("FechaFinalizacion").Value) Then
         origen.Registro.Fields("FechaFinalizacion").Value = Date
      Else
         origen.Registro.Fields("FechaFinalizacion").Value = Null
      End If
   End If
   
End Sub

Private Sub DTPicker1_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTPicker1(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub FileBrowser1_Change(Index As Integer)

   If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
      If Len(Trim(FileBrowser1(Index).Text)) > gblMaximaLongitudAdjuntos Then
         MsgBox "La longitud maxima para un archivo adjunto es de " & gblMaximaLongitudAdjuntos & " caracteres", vbInformation
         FileBrowser1(Index).Text = ""
      Else
         FileBrowser1(Index).InitDir = FileBrowser1(Index).Text
      End If
   End If
   
End Sub

Private Sub FileBrowser1_DblClick(Index As Integer)

   If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
      If Not Len(Trim(Dir(FileBrowser1(Index).Text))) <> 0 Then
         MsgBox "El archivo indicado no existe!", vbExclamation
         Exit Sub
      End If
      Call ShellExecute(Me.hwnd, "open", FileBrowser1(Index).Text, vbNullString, vbNullString, SW_SHOWNORMAL)
   End If

End Sub

Private Sub Form_Load()

   If mvarId < 0 Then
      cmd(1).Enabled = False
   End If
   
   With Combo1
      .AddItem "Taller"
      .AddItem "Montaje"
      .AddItem "Servicio"
   End With

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   With ListaRecepciones
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   With ListaEquiposInstalados
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   With ListaDestinos
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   With ListaSectores
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
'   For Each oI In Img16.ListImages
'      With Estado.Panels.Add(, , oI.Key)
'         .Picture = oI.Picture
'      End With
'   Next

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim Filas, Columnas, mJerarquias
   Dim iFilas As Long, iColumnas As Long, mIdObra As Long
   Dim i As Integer
   Dim oAp As ComPronto.Aplicacion
   Dim dtp As DTPicker
   Dim oRs As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then
      
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Filas) > 1 Then
         MsgBox "Solo puede copiar un elemento a la vez", vbCritical
         Exit Sub
      End If
      
      If mvarId > 0 Then
         MsgBox "Solo puede copiar un elemento en una obra nueva", vbCritical
         Exit Sub
      End If
      
      Set oAp = Aplicacion
      
      If InStr(1, Columnas(1), "Obra") <> 0 Then
         Columnas = Split(Filas(1), vbTab)
         mIdObra = Columnas(2)
         Set oRs = oAp.Obras.TraerFiltrado("_PorId", mIdObra)
         If oRs.RecordCount > 0 Then
            With origen.Registro
               For i = 1 To oRs.Fields.Count - 1
                  .Fields(i).Value = oRs.Fields(i).Value
               Next
            End With
         End If
         oRs.Close
         With origen.Registro
            For Each dtp In DTPicker1
               If Len(dtp.DataField) > 0 Then
                  dtp.Value = origen.Registro.Fields(dtp.DataField).Value
               End If
            Next
            Combo1.ListIndex = IIf(IsNull(.Fields("TipoObra").Value), 0, .Fields("TipoObra").Value - 1)
            If .Fields("Activa").Value = "SI" Then
               Option1.Value = True
            Else
               Option2.Value = True
            End If
            If Not IsNull(.Fields("Jerarquia").Value) Then
               mJerarquias = VBA.Split(.Fields("Jerarquia").Value, ".")
               For i = 0 To 4
                  With txtJerarquia(i)
                     .Text = mJerarquias(i)
                     .Enabled = False
                  End With
               Next
               mConJerarquia = True
            Else
               With txtJerarquia(4)
                  .Text = "000"
                  .Locked = True
               End With
               mConJerarquia = False
            End If
            For i = 0 To 9
               FileBrowser1(i).Text = .Fields("ArchivoAdjunto" & i + 1).Value
            Next
            If IsNull(.Fields("GeneraReservaStock").Value) Or _
                  .Fields("GeneraReservaStock").Value = "SI" Then
               Check1.Value = 1
            Else
               Check1.Value = 0
            End If
            If Not IsNull(.Fields("IdCliente").Value) Then
               Check2.Value = 1
            Else
               Check2.Value = 0
               DataCombo1(0).Enabled = False
            End If
            If Not IsNull(.Fields("IdArticuloAsociado").Value) Then
               Check3.Value = 1
            Else
               Check3.Value = 0
            End If
            RichTextBox1.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
            RichTextBox2.TextRTF = IIf(IsNull(.Fields("Observaciones2").Value), "", .Fields("Observaciones2").Value)
            RichTextBox3.TextRTF = IIf(IsNull(.Fields("Observaciones3").Value), "", .Fields("Observaciones3").Value)
         End With
         
         Set oRs = oAp.TablasGenerales.TraerFiltrado("DetObrasEquiposInstalados", "_PorIdObra", mIdObra)
         If oRs.RecordCount > 0 Then
            oRs.MoveFirst
            Do While Not oRs.EOF
               With origen.DetObrasEquiposInstalados.Item(-1)
                  For i = 2 To oRs.Fields.Count - 1
                     .Registro.Fields(i).Value = oRs.Fields(i).Value
                  Next
                  .Modificado = True
               End With
               oRs.MoveNext
            Loop
            Set ListaEquiposInstalados.DataSource = origen.DetObrasEquiposInstalados.RegistrosConFormato
         End If
         oRs.Close
         
         Set oRs = oAp.TablasGenerales.TraerFiltrado("DetObrasPolizas", "_PorIdObra", mIdObra)
         If oRs.RecordCount > 0 Then
            oRs.MoveFirst
            Do While Not oRs.EOF
               With origen.DetObrasPolizas.Item(-1)
                  For i = 2 To oRs.Fields.Count - 1
                     .Registro.Fields(i).Value = oRs.Fields(i).Value
                  Next
                  .Modificado = True
               End With
               oRs.MoveNext
            Loop
            Set Lista.DataSource = origen.DetObrasPolizas.RegistrosConFormato
         End If
         oRs.Close
         
         Set oRs = oAp.TablasGenerales.TraerFiltrado("DetObrasRecepciones", "_PorIdObra", mIdObra)
         If oRs.RecordCount > 0 Then
            oRs.MoveFirst
            Do While Not oRs.EOF
               With origen.DetObrasRecepciones.Item(-1)
                  For i = 2 To oRs.Fields.Count - 1
                     .Registro.Fields(i).Value = oRs.Fields(i).Value
                  Next
                  .Modificado = True
               End With
               oRs.MoveNext
            Loop
            Set ListaRecepciones.DataSource = origen.DetObrasRecepciones.RegistrosConFormato
         End If
         oRs.Close
      Else
      
         MsgBox "Objeto invalido!" & vbCrLf & "Solo puede copiar items de requermientos", vbCritical
         Exit Sub
   
      End If
      
Salida:
      Set oRs = Nothing
      Set oAp = Nothing
      
      Clipboard.Clear
      
   End If

End Sub

Private Sub Form_OLEDragOver(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

   Dim s As String
   Dim Filas, Columnas
   Dim iFilas As Long
   Dim iColumnas As Long
   Dim oL As ListItem

   If State = vbEnter Then
      If Data.GetFormat(ccCFText) Then
         s = Data.GetData(ccCFText)
         Filas = Split(s, vbCrLf)
         Columnas = Split(Filas(LBound(Filas)), vbTab)
         Effect = vbDropEffectCopy
      End If
   End If

End Sub

Private Sub Form_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
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
   ElseIf KeyCode = vbKeySpace Then
      MnuDetA_Click 1
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

Private Sub ListaDestinos_DblClick()

   If ListaDestinos.ListItems.Count = 0 Then
      EditarDestinos -1
   Else
      EditarDestinos ListaDestinos.SelectedItem.Tag
   End If

End Sub

Private Sub ListaDestinos_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaDestinos_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetD_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetD_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetD_Click 1
   End If

End Sub

Private Sub ListaDestinos_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If ListaDestinos.ListItems.Count = 0 Then
         MnuDetD(1).Enabled = False
         MnuDetD(2).Enabled = False
         PopupMenu MnuDetDest, , , , MnuDetD(0)
      Else
         MnuDetD(1).Enabled = True
         MnuDetD(2).Enabled = True
         PopupMenu MnuDetDest, , , , MnuDetD(1)
      End If
   End If

End Sub

Private Sub ListaEquiposInstalados_DblClick()

   If ListaEquiposInstalados.ListItems.Count = 0 Then
      EditarEquiposInstalados -1
   Else
      EditarEquiposInstalados ListaEquiposInstalados.SelectedItem.Tag
   End If

End Sub

Private Sub ListaEquiposInstalados_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaEquiposInstalados_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetC_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetC_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetC_Click 1
   End If

End Sub

Private Sub ListaEquiposInstalados_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If ListaEquiposInstalados.ListItems.Count = 0 Then
         MnuDetC(1).Enabled = False
         MnuDetC(2).Enabled = False
         PopupMenu MnuDetEqu, , , , MnuDetC(0)
      Else
         MnuDetC(1).Enabled = True
         MnuDetC(2).Enabled = True
         PopupMenu MnuDetEqu, , , , MnuDetC(1)
      End If
   End If

End Sub

Private Sub ListaRecepciones_DblClick()

   If ListaRecepciones.ListItems.Count = 0 Then
      EditarRecepciones -1
   Else
      EditarRecepciones ListaRecepciones.SelectedItem.Tag
   End If

End Sub

Private Sub ListaRecepciones_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaRecepciones_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetB_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetB_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetB_Click 1
   End If

End Sub

Private Sub ListaRecepciones_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If ListaRecepciones.ListItems.Count = 0 Then
         MnuDetB(1).Enabled = False
         MnuDetB(2).Enabled = False
         PopupMenu MnuDetRec, , , , MnuDetB(0)
      Else
         MnuDetB(1).Enabled = True
         MnuDetB(2).Enabled = True
         PopupMenu MnuDetRec, , , , MnuDetB(1)
      End If
   End If

End Sub

Private Sub ListaSectores_DblClick()

   If ListaSectores.ListItems.Count = 0 Then
      EditarSectores -1
   Else
      EditarSectores ListaSectores.SelectedItem.Tag
   End If

End Sub

Private Sub ListaSectores_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaSectores_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetE_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetE_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetE_Click 1
   End If

End Sub

Private Sub ListaSectores_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If ListaSectores.ListItems.Count = 0 Then
         MnuDetE(1).Enabled = False
         MnuDetE(2).Enabled = False
         PopupMenu MnuDetSec, , , , MnuDetE(0)
      Else
         MnuDetE(1).Enabled = True
         MnuDetE(2).Enabled = True
         PopupMenu MnuDetSec, , , , MnuDetE(1)
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
         With Lista.SelectedItem
            origen.DetObrasPolizas.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub MnuDetB_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarRecepciones -1
      Case 1
         EditarRecepciones ListaRecepciones.SelectedItem.Tag
      Case 2
         With ListaRecepciones.SelectedItem
            origen.DetObrasPolizas.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub MnuDetC_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarEquiposInstalados -1
      Case 1
         EditarEquiposInstalados ListaEquiposInstalados.SelectedItem.Tag
      Case 2
         With ListaEquiposInstalados.SelectedItem
            origen.DetObrasEquiposInstalados.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub MnuDetD_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarDestinos -1
      Case 1
         EditarDestinos ListaDestinos.SelectedItem.Tag
      Case 2
         With ListaDestinos.SelectedItem
            origen.DetObrasDestinos.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub MnuDetE_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarSectores -1
      Case 1
         EditarSectores ListaSectores.SelectedItem.Tag
      Case 2
         With ListaSectores.SelectedItem
            origen.DetObrasSectores.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub txtCodigoObra_GotFocus()

   With txtCodigoObra
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoObra_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCodigoObra
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         Else
            If KeyAscii >= Asc("a") And KeyAscii <= Asc("z") Then
               KeyAscii = KeyAscii - 32
            End If
         End If
      End With
   End If

End Sub

Private Sub txtCodigoObra_Validate(Cancel As Boolean)

   If Len(txtCodigoObra.Text) Then
      
      Dim i As Integer
      Dim HayLetras, HayCaracteresInvalidos As Boolean
      Dim oRs As ADOR.Recordset
      
'      HayLetras = False
'      HayCaracteresInvalidos = False
'
'      For i = 1 To Len(txtCodigoObra.Text)
'         If Asc(mId(txtCodigoObra.Text, i, 1)) >= Asc("A") And Asc(mId(txtCodigoObra.Text, i, 1)) <= Asc("Z") Then
'            HayLetras = True
'         End If
'         If Not ((Asc(mId(txtCodigoObra.Text, i, 1)) >= Asc("A") And Asc(mId(txtCodigoObra.Text, i, 1)) <= Asc("Z")) Or (Asc(mId(txtCodigoObra.Text, i, 1)) >= Asc("0") And Asc(mId(txtCodigoObra.Text, i, 1)) <= Asc("9"))) Then
'            HayCaracteresInvalidos = True
'         End If
'      Next
'
'      If HayCaracteresInvalidos And mvarId < 0 Then
'         MsgBox "El numero de obra solo puede tener letras y numeros", vbExclamation
'         Cancel = True
'         Exit Sub
'      End If
'
'      If Not HayLetras And mvarId < 0 Then
'         MsgBox "El numero de obra debe tener letras", vbExclamation
'         Cancel = True
'         Exit Sub
'      End If
   
      Set oRs = Aplicacion.Obras.TraerFiltrado("_PorNumero", txtCodigoObra.Text)
      
      If mvarId < 0 Then
         If oRs.RecordCount > 0 Then
            MsgBox "El numero de obra ya existe", vbExclamation
            Cancel = True
            oRs.Close
            GoTo Salida
         End If
      Else
         If oRs.RecordCount > 0 Then
            If oRs.Fields(0).Value <> mvarId Then
               MsgBox "El numero de obra ya existe", vbExclamation
               Cancel = True
               oRs.Close
               GoTo Salida
            End If
         End If
      End If
      
      oRs.Close
      
   End If

Salida:

   Set oRs = Nothing
   
End Sub

Private Sub txtDescripcion_GotFocus()

   With txtDescripcion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDescripcion
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtHorasEstimadas_GotFocus()

   With txtHorasEstimadas
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtHorasEstimadas_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtJerarquia_GotFocus(Index As Integer)

   With txtJerarquia(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
End Sub

Private Sub txtJerarquia_KeyPress(Index As Integer, KeyAscii As Integer)

   If Not txtJerarquia(Index).Locked Then
      If KeyAscii = Asc(vbCr) Then
         SendKeys "{TAB}", True
      Else
         If (KeyAscii < 48 Or KeyAscii > 57) And KeyAscii <> vbKeyBack Then
            KeyAscii = 0
         Else
            If ((Index = 0 Or Index = 1) And Len(txtJerarquia(Index)) = 1) Or _
               ((Index = 2 Or Index = 3) And Len(txtJerarquia(Index)) = 2) Or _
               (Index = 4 And Len(txtJerarquia(Index)) = 3) Then
               txtJerarquia(Index) = ""
            End If
         End If
      End If
   End If
   
End Sub

Private Sub txtJerarquia_Validate(Index As Integer, Cancel As Boolean)

   If mNivelAcceso > 1 Then
      MsgBox "Nivel de acceso insuficiente para esta operacion"
      Cancel = True
   End If
      
   Dim mDigitos As Integer
   If Index = 0 Or Index = 1 Then
      mDigitos = 1
   ElseIf Index = 2 Or Index = 3 Then
      mDigitos = 2
   Else
      mDigitos = 3
   End If
   If ((Index = 0 Or Index = 1) And Len(txtJerarquia(Index)) <> 1) Or _
      ((Index = 2 Or Index = 3) And Len(txtJerarquia(Index)) <> 2) Or _
      (Index = 4 And Len(txtJerarquia(Index)) <> 3) Then
      MsgBox "El nivel debe tener " & mDigitos & " digitos"
      Cancel = True
      Exit Sub
   End If
   If Index = 0 Then
      If Val(txtJerarquia(0).Text) < 6 Then
         MsgBox "El nivel debe ser mayor o igual a 6"
         Cancel = True
         Exit Sub
      End If
   End If

End Sub

Public Sub ActivarControlesAdicionales()

   Dim i As Integer
   Dim X As Long
   Dim señal As Boolean
   
   X = lblMasDatos(0).Top - lblAdjuntos(0).Top
   
   If lblAdjuntos(0).Visible Then
      señal = True
   Else
      señal = False
   End If
   
   For i = 0 To 9
      lblAdjuntos(i).Visible = Not señal
      FileBrowser1(i).Visible = Not señal
   Next
   For i = 0 To 12
      lblMasDatos(i).Top = lblMasDatos(i).Top - X
      lblMasDatos(i).Visible = señal
   Next
   For i = 0 To 2
      DataCombo2(i).Top = DataCombo2(i).Top - X
      DataCombo2(i).Visible = señal
   Next
   With txtDireccion
      .Top = .Top - X
      .Visible = señal
   End With
   With txtCodigoPostal
      .Top = .Top - X
      .Visible = señal
   End With
   With txtTelefono
      .Top = .Top - X
      .Visible = señal
   End With
   With txtLugarPago
      .Top = .Top - X
      .Visible = señal
   End With
   With txtResponsable
      .Top = .Top - X
      .Visible = señal
   End With
   With txtHorario
      .Top = .Top - X
      .Visible = señal
   End With
   With txtTurnos
      .Top = .Top - X
      .Visible = señal
   End With
   With txtOperarios
      .Top = .Top - X
      .Visible = señal
   End With
   With txtZona
      .Top = .Top - X
      .Visible = señal
   End With
   With txtJurisdiccion
      .Top = .Top - X
      .Visible = señal
   End With

End Sub
