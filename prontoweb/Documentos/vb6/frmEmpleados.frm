VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmEmpleados 
   Caption         =   "Personal "
   ClientHeight    =   7590
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11850
   Icon            =   "frmEmpleados.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7590
   ScaleWidth      =   11850
   StartUpPosition =   2  'CenterScreen
   Begin VB.ComboBox Combo1 
      Enabled         =   0   'False
      Height          =   315
      Index           =   0
      ItemData        =   "frmEmpleados.frx":076A
      Left            =   6345
      List            =   "frmEmpleados.frx":0777
      TabIndex        =   74
      Top             =   4635
      Width           =   2085
   End
   Begin VB.CheckBox Check9 
      Height          =   240
      Left            =   6120
      TabIndex        =   72
      Top             =   4680
      Width           =   195
   End
   Begin VB.Frame Frame2 
      Height          =   330
      Left            =   3870
      TabIndex        =   69
      Top             =   225
      Width           =   2220
      Begin VB.OptionButton Option5 
         Caption         =   "Activo"
         Height          =   150
         Left            =   135
         TabIndex        =   71
         Top             =   135
         Width           =   825
      End
      Begin VB.OptionButton Option6 
         Caption         =   "Inactivo"
         Height          =   150
         Left            =   1125
         TabIndex        =   70
         Top             =   135
         Width           =   960
      End
   End
   Begin VB.CheckBox Check8 
      Height          =   240
      Left            =   6120
      TabIndex        =   66
      Top             =   4290
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CheckBox Check7 
      Height          =   240
      Left            =   2250
      TabIndex        =   65
      Top             =   4275
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CheckBox Check6 
      Alignment       =   1  'Right Justify
      Caption         =   "Incluir en sistema productivo (PRONTO HH)  :"
      Height          =   285
      Left            =   4770
      TabIndex        =   59
      Top             =   3870
      Width           =   3615
   End
   Begin VB.TextBox txtHorasJornada 
      Alignment       =   1  'Right Justify
      DataField       =   "HorasJornada"
      Height          =   285
      Left            =   2265
      TabIndex        =   57
      Top             =   3870
      Width           =   495
   End
   Begin VB.TextBox txtInformacionAuxiliar 
      DataField       =   "InformacionAuxiliar"
      Height          =   285
      Left            =   6615
      TabIndex        =   55
      Top             =   3510
      Width           =   1800
   End
   Begin VB.TextBox txtCuentaBancaria 
      DataField       =   "CuentaBancaria"
      Height          =   285
      Left            =   6615
      TabIndex        =   53
      Top             =   3150
      Width           =   1800
   End
   Begin VB.CheckBox Check5 
      Alignment       =   1  'Right Justify
      Caption         =   "Activo / inactivo"
      Height          =   240
      Left            =   225
      TabIndex        =   50
      Top             =   6705
      Width           =   1950
   End
   Begin VB.CheckBox Check4 
      Alignment       =   1  'Right Justify
      Caption         =   "Activo / inactivo"
      Height          =   240
      Left            =   225
      TabIndex        =   49
      Top             =   6315
      Width           =   1950
   End
   Begin VB.CheckBox Check3 
      Alignment       =   1  'Right Justify
      Caption         =   "Activo / inactivo"
      Height          =   240
      Left            =   225
      TabIndex        =   48
      Top             =   5925
      Width           =   1950
   End
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Activo / inactivo"
      Height          =   240
      Left            =   225
      TabIndex        =   47
      Top             =   5535
      Width           =   1950
   End
   Begin VB.TextBox txtGrupoDeCarga 
      Alignment       =   1  'Right Justify
      DataField       =   "GrupoDeCarga"
      Height          =   285
      Left            =   4245
      TabIndex        =   45
      Top             =   3870
      Width           =   315
   End
   Begin VB.Frame Frame1 
      Caption         =   "Tipo de usuario :"
      Height          =   1365
      Left            =   6615
      TabIndex        =   39
      Top             =   1350
      Width           =   1815
      Begin VB.OptionButton Option4 
         Caption         =   "Obras propias"
         Height          =   195
         Left            =   135
         TabIndex        =   62
         Top             =   540
         Width           =   1590
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Tercerizado"
         Height          =   195
         Left            =   135
         TabIndex        =   42
         Top             =   1080
         Width           =   1590
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Obras externas"
         Height          =   195
         Left            =   135
         TabIndex        =   41
         Top             =   810
         Width           =   1590
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Propio"
         Height          =   195
         Left            =   135
         TabIndex        =   40
         Top             =   270
         Width           =   1590
      End
   End
   Begin VB.TextBox txtEdad 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   7920
      Locked          =   -1  'True
      TabIndex        =   37
      Top             =   990
      Width           =   495
   End
   Begin VB.TextBox txtDominio 
      DataField       =   "Dominio"
      Height          =   285
      Left            =   2265
      TabIndex        =   10
      Top             =   3510
      Width           =   2295
   End
   Begin VB.TextBox txtPass 
      Height          =   285
      IMEMode         =   3  'DISABLE
      Index           =   1
      Left            =   5010
      PasswordChar    =   "*"
      TabIndex        =   4
      Top             =   1350
      Visible         =   0   'False
      Width           =   1395
   End
   Begin VB.TextBox txtPass 
      DataField       =   "Password"
      Enabled         =   0   'False
      Height          =   285
      IMEMode         =   3  'DISABLE
      Index           =   0
      Left            =   2265
      PasswordChar    =   "*"
      TabIndex        =   3
      Top             =   1350
      Width           =   1440
   End
   Begin VB.TextBox txtIniciales 
      DataField       =   "Iniciales"
      Height          =   285
      Left            =   2265
      TabIndex        =   2
      Top             =   990
      Width           =   1440
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Usuario administrador :"
      Enabled         =   0   'False
      Height          =   285
      Left            =   6480
      TabIndex        =   11
      Top             =   270
      Width           =   1905
   End
   Begin VB.TextBox txtInterno 
      DataField       =   "Interno"
      Height          =   285
      Left            =   2265
      TabIndex        =   9
      Top             =   3150
      Width           =   2295
   End
   Begin VB.TextBox txtEmail 
      DataField       =   "Email"
      Height          =   285
      Left            =   2265
      TabIndex        =   8
      Top             =   2790
      Width           =   4140
   End
   Begin VB.TextBox txtLegajo 
      Alignment       =   2  'Center
      DataField       =   "Legajo"
      Height          =   285
      Left            =   2265
      TabIndex        =   0
      Top             =   270
      Width           =   1035
   End
   Begin VB.TextBox txtUsuarioNT 
      DataField       =   "UsuarioNT"
      Height          =   285
      Left            =   2265
      TabIndex        =   5
      Top             =   1710
      Width           =   4140
   End
   Begin VB.TextBox txtNombre 
      DataField       =   "Nombre"
      Height          =   285
      Left            =   2265
      TabIndex        =   1
      Top             =   630
      Width           =   6120
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   1875
      TabIndex        =   21
      Top             =   7065
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   3585
      TabIndex        =   22
      Top             =   7065
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   180
      TabIndex        =   20
      Top             =   7065
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSector"
      Height          =   315
      Index           =   0
      Left            =   2265
      TabIndex        =   6
      Tag             =   "Sectores"
      Top             =   2070
      Width           =   4155
      _ExtentX        =   7329
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdSector"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCargo"
      Height          =   315
      Index           =   1
      Left            =   2265
      TabIndex        =   7
      Tag             =   "Cargos"
      Top             =   2430
      Width           =   4155
      _ExtentX        =   7329
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCargo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSector1"
      Height          =   315
      Index           =   2
      Left            =   2250
      TabIndex        =   12
      Tag             =   "Sectores"
      Top             =   5490
      Width           =   2985
      _ExtentX        =   5265
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdSector"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCargo1"
      Height          =   315
      Index           =   3
      Left            =   5355
      TabIndex        =   13
      Tag             =   "Cargos"
      Top             =   5490
      Width           =   3030
      _ExtentX        =   5345
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCargo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSector2"
      Height          =   315
      Index           =   4
      Left            =   2250
      TabIndex        =   14
      Tag             =   "Sectores"
      Top             =   5880
      Width           =   2985
      _ExtentX        =   5265
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdSector"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCargo2"
      Height          =   315
      Index           =   5
      Left            =   5355
      TabIndex        =   15
      Tag             =   "Cargos"
      Top             =   5880
      Width           =   3030
      _ExtentX        =   5345
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCargo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSector3"
      Height          =   315
      Index           =   6
      Left            =   2250
      TabIndex        =   16
      Tag             =   "Sectores"
      Top             =   6270
      Width           =   2985
      _ExtentX        =   5265
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdSector"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCargo3"
      Height          =   315
      Index           =   7
      Left            =   5355
      TabIndex        =   17
      Tag             =   "Cargos"
      Top             =   6270
      Width           =   3030
      _ExtentX        =   5345
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCargo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSector4"
      Height          =   315
      Index           =   8
      Left            =   2250
      TabIndex        =   18
      Tag             =   "Sectores"
      Top             =   6660
      Width           =   2985
      _ExtentX        =   5265
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdSector"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCargo4"
      Height          =   315
      Index           =   9
      Left            =   5355
      TabIndex        =   19
      Tag             =   "Cargos"
      Top             =   6660
      Width           =   3030
      _ExtentX        =   5345
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCargo"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaNacimiento"
      Height          =   285
      Index           =   0
      Left            =   5670
      TabIndex        =   35
      Top             =   990
      Width           =   1275
      _ExtentX        =   2249
      _ExtentY        =   503
      _Version        =   393216
      Format          =   57671681
      CurrentDate     =   2
   End
   Begin Controles1013.DbListView Lista 
      Height          =   1950
      Left            =   8505
      TabIndex        =   43
      Top             =   315
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   3440
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmEmpleados.frx":0797
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   5490
      Top             =   6975
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
            Picture         =   "frmEmpleados.frx":07B3
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmEmpleados.frx":08C5
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmEmpleados.frx":0D17
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmEmpleados.frx":1169
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView ListaSec 
      Height          =   1950
      Left            =   8505
      TabIndex        =   51
      Top             =   2565
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   3440
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmEmpleados.frx":15BB
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaJor 
      Height          =   2265
      Left            =   8505
      TabIndex        =   60
      Top             =   4815
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   3995
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmEmpleados.frx":15D7
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaFondoFijo"
      Height          =   315
      Index           =   10
      Left            =   2490
      TabIndex        =   63
      Tag             =   "CuentasFF"
      Top             =   4230
      Visible         =   0   'False
      Width           =   2085
      _ExtentX        =   3678
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdObraAsignada"
      Height          =   315
      Index           =   11
      Left            =   6345
      TabIndex        =   67
      Tag             =   "Obras"
      Top             =   4245
      Visible         =   0   'False
      Width           =   2085
      _ExtentX        =   3678
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Idioma actual :"
      Height          =   255
      Index           =   22
      Left            =   4770
      TabIndex        =   73
      Top             =   4665
      Width           =   1275
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Obra asignada :"
      Height          =   255
      Index           =   20
      Left            =   4770
      TabIndex        =   68
      Top             =   4275
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Fondo fijo asignado (opc)"
      Height          =   255
      Index           =   19
      Left            =   225
      TabIndex        =   64
      Top             =   4215
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Fechas de cambio de horas jornada std. : "
      Height          =   195
      Index           =   18
      Left            =   8550
      TabIndex        =   61
      Top             =   4590
      Width           =   2970
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Horas jornada :"
      Height          =   255
      Index           =   17
      Left            =   225
      TabIndex        =   58
      Top             =   3870
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Informacion auxiliar :"
      Height          =   255
      Index           =   16
      Left            =   4770
      TabIndex        =   56
      Top             =   3510
      Width           =   1755
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuenta bancaria :"
      Height          =   240
      Index           =   15
      Left            =   4770
      TabIndex        =   54
      Top             =   3150
      Width           =   1755
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Fechas de cambio de secciones : "
      Height          =   195
      Index           =   14
      Left            =   8550
      TabIndex        =   52
      Top             =   2340
      Width           =   2430
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Grupo de carga :"
      Height          =   255
      Index           =   13
      Left            =   2880
      TabIndex        =   46
      Top             =   3915
      Width           =   1275
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Fechas de ingreso y egreso : "
      Height          =   195
      Index           =   12
      Left            =   8550
      TabIndex        =   44
      Top             =   90
      Width           =   2085
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Edad :"
      Height          =   195
      Index           =   11
      Left            =   7245
      TabIndex        =   38
      Top             =   1035
      Width           =   585
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Fecha de nacimiento :"
      Height          =   240
      Index           =   21
      Left            =   3870
      TabIndex        =   36
      Top             =   1005
      Width           =   1710
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Dominio (red) :"
      Height          =   255
      Index           =   10
      Left            =   225
      TabIndex        =   34
      Top             =   3510
      Width           =   1815
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      Index           =   0
      X1              =   90
      X2              =   8460
      Y1              =   5040
      Y2              =   5040
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Sectores y cargos adicionales :"
      Height          =   240
      Index           =   9
      Left            =   225
      TabIndex        =   33
      Top             =   5130
      Width           =   2520
   End
   Begin VB.Label lblPass 
      AutoSize        =   -1  'True
      Caption         =   "Confirmacion :"
      Height          =   300
      Left            =   3870
      TabIndex        =   32
      Top             =   1365
      Visible         =   0   'False
      Width           =   1050
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Password sistema :"
      Height          =   300
      Index           =   8
      Left            =   225
      TabIndex        =   31
      Top             =   1338
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Iniciales ( 6 digitos ) :"
      Height          =   300
      Index           =   7
      Left            =   225
      TabIndex        =   30
      Top             =   957
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Interno :"
      Height          =   255
      Index           =   6
      Left            =   225
      TabIndex        =   29
      Top             =   3150
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Email :"
      Height          =   255
      Index           =   5
      Left            =   225
      TabIndex        =   28
      Top             =   2775
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Legajo :"
      Height          =   255
      Index           =   0
      Left            =   225
      TabIndex        =   27
      Top             =   285
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cargo :"
      Height          =   255
      Index           =   4
      Left            =   225
      TabIndex        =   26
      Top             =   2430
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Sector :"
      Height          =   210
      Index           =   3
      Left            =   225
      TabIndex        =   25
      Top             =   2100
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Usuario de red :"
      Height          =   300
      Index           =   2
      Left            =   225
      TabIndex        =   24
      Top             =   1725
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Nombre : "
      Height          =   255
      Index           =   1
      Left            =   225
      TabIndex        =   23
      Top             =   621
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
   Begin VB.Menu MnuDetSec 
      Caption         =   "DetallesSectores"
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
   Begin VB.Menu MnuDetJor 
      Caption         =   "DetallesJornadas"
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
Attribute VB_Name = "frmEmpleados"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Empleado
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long
Private mvarPass As String
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

   Dim oF As frmDetEmpleados
   Dim oL As ListItem
   
   Set oF = New frmDetEmpleados
   
   With oF
      Set .Empleado = origen
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
            .Text = oF.DTPicker1(0).Value
            .SubItems(1) = IIf(oF.DTPicker1(1).Enabled, oF.DTPicker1(1).Value, "")
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Sub EditarCambioSector(ByVal Cual As Long)

   Dim oF As frmDetEmpleadosSectores
   Dim oL As ListItem
   
   Set oF = New frmDetEmpleadosSectores
   
   With oF
      Set .Empleado = origen
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaSec.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaSec.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.DTPicker1(0).Value
            .SubItems(1) = oF.DataCombo1(0).Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Sub EditarCambioJornada(ByVal Cual As Long)

   Dim oF As frmDetEmpleadosJornadas
   Dim oL As ListItem
   
   Set oF = New frmDetEmpleadosJornadas
   
   With oF
      Set .Empleado = origen
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaJor.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaJor.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.DTPicker1(0).Value
            .SubItems(1) = oF.txtHorasJornada.Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Private Sub Check2_Click()

   If Check2.Value = 0 Then
      With origen.Registro
         .Fields("IdSector1").Value = Null
         .Fields("IdCargo1").Value = Null
      End With
      DataCombo1(2).Enabled = False
      DataCombo1(3).Enabled = False
   Else
      DataCombo1(2).Enabled = True
      DataCombo1(3).Enabled = True
   End If

End Sub

Private Sub Check3_Click()

   If Check3.Value = 0 Then
      With origen.Registro
         .Fields("IdSector2").Value = Null
         .Fields("IdCargo2").Value = Null
      End With
      DataCombo1(4).Enabled = False
      DataCombo1(5).Enabled = False
   Else
      DataCombo1(4).Enabled = True
      DataCombo1(5).Enabled = True
   End If

End Sub

Private Sub Check4_Click()

   If Check4.Value = 0 Then
      With origen.Registro
         .Fields("IdSector3").Value = Null
         .Fields("IdCargo3").Value = Null
      End With
      DataCombo1(6).Enabled = False
      DataCombo1(7).Enabled = False
   Else
      DataCombo1(6).Enabled = True
      DataCombo1(7).Enabled = True
   End If

End Sub

Private Sub Check5_Click()

   If Check5.Value = 0 Then
      With origen.Registro
         .Fields("IdSector4").Value = Null
         .Fields("IdCargo4").Value = Null
      End With
      DataCombo1(8).Enabled = False
      DataCombo1(9).Enabled = False
   Else
      DataCombo1(8).Enabled = True
      DataCombo1(9).Enabled = True
   End If

End Sub

Private Sub Check7_Click()

   If Check7.Value = 0 Then
      With origen.Registro
         .Fields("IdCuentaFondoFijo").Value = Null
      End With
      DataCombo1(10).Enabled = False
   Else
      DataCombo1(10).Enabled = True
   End If

End Sub

Private Sub Check8_Click()

   If Check8.Value = 0 Then
      With origen.Registro
         .Fields("IdObraAsignada").Value = Null
      End With
      DataCombo1(11).Enabled = False
   Else
      DataCombo1(11).Enabled = True
   End If

End Sub

Private Sub Check9_Click()

   If Check9.Value = 0 Then
      With origen.Registro
         .Fields("Idioma").Value = Null
      End With
      Combo1(0).ListIndex = -1
      Combo1(0).Enabled = False
   Else
      Combo1(0).Enabled = True
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
   
         If Len(Trim(txtNombre.Text)) = 0 Then
            MsgBox "Falta completar el campo nombre", vbCritical
            Exit Sub
         End If
         
         Dim est As EnumAcciones
         Dim oControl As Control
         Dim dtp As DTPicker
         Dim mAux1 As String
   
         If Lista.ListItems.Count = 0 Then
            MsgBox "En la lista de fechas de ingreso y/o egreso debe haber por lo menos un registro"
            Exit Sub
         End If
         
         If ListaSec.ListItems.Count = 0 Then
            MsgBox "En la lista de cambios de sector debe haber por lo menos un registro"
            Exit Sub
         End If
         
'         If Len(Trim(txtLegajo.Text)) <> 6 Then
'            MsgBox "El legajo debe tener 6 digitos", vbCritical
'            Exit Sub
'         End If
         
         With origen.Registro
            For Each oControl In Me.Controls
               If TypeOf oControl Is DataCombo Then
                  If oControl.Enabled And Len(oControl.BoundText) <> 0 Then
                     .Fields(oControl.DataField).Value = oControl.BoundText
                  End If
               ElseIf TypeOf oControl Is DTPicker Then
                  .Fields(oControl.DataField).Value = oControl.Value
               End If
            Next
         
            If Option1.Value Then
               .Fields("TipoUsuario").Value = 1
            ElseIf Option2.Value Then
               .Fields("TipoUsuario").Value = 2
            ElseIf Option3.Value Then
               .Fields("TipoUsuario").Value = 3
            ElseIf Option4.Value Then
               .Fields("TipoUsuario").Value = 4
            End If
            
            If glbAdministrador Then
               If Check1.Value = 1 Then
                  .Fields("Administrador").Value = "SI"
               Else
                  .Fields("Administrador").Value = "NO"
               End If
            End If
         
            If Check6.Value = 1 Then
               .Fields("SisMan").Value = "SI"
            Else
               .Fields("SisMan").Value = "NO"
            End If
            
            .Fields("SisMat").Value = "SI"
         
            If Option5.Value Then
               .Fields("Activo").Value = "SI"
            Else
               .Fields("Activo").Value = "NO"
            End If
         
            mAux1 = "esp"
            If Combo1(0).ListIndex >= 0 Then
               Select Case Combo1(0).ListIndex
                  Case 1
                     mAux1 = "ing"
                  Case 2
                     mAux1 = "por"
               End Select
               .Fields("Idioma").Value = mAux1
            End If
            If mvarId = glbIdUsuario Then glbIdiomaActual = mAux1
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
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("ALTA", mvarId, 0, Now, 0, "Tabla : Empleados", GetCompName(), glbNombreUsuario)
         Else
            est = Modificacion
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("MODIF", mvarId, 0, Now, 0, "Tabla : Empleados", GetCompName(), glbNombreUsuario)
         End If
            
         With actL2
            .ListaEditada = "Empleados,Empleados1,Empleados2,Empleados3"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
      Case 1
   
         Dim mBorra As Integer
         mBorra = MsgBox("Esta seguro de eliminar los datos definitivamente ?", vbYesNo, "Eliminar")
         If mBorra = vbNo Then
            Exit Sub
         End If
         
         origen.Eliminar
         
         est = baja
         Aplicacion.Tarea "Log_InsertarRegistro", _
               Array("ELIM", mvarId, 0, Now, 0, "Tabla : Empleados", GetCompName(), glbNombreUsuario)
            
         With actL2
            .ListaEditada = "Empleados,Empleados1,Empleados2,Empleados3"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
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

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oControl As Control
   Dim ListaVacia1 As Boolean, ListaVacia2 As Boolean, ListaVacia3 As Boolean
   Dim mAux1 As String
   
   mvarId = vnewvalue
   ListaVacia1 = False
   ListaVacia2 = False
   ListaVacia3 = False
   
   Set oAp = Aplicacion
   Set origen = oAp.Empleados.Item(vnewvalue)
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetEmpleados.TraerFiltrado("Primero")
                     ListaVacia1 = True
                  Else
                     Set oRs = origen.DetEmpleados.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia1 = False
                     Else
                        Set oControl.DataSource = origen.DetEmpleados.TraerFiltrado("Primero")
                        ListaVacia1 = True
                     End If
                  End If
               Case "ListaSec"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetEmpleadosSectores.TraerFiltrado("Primero")
                     ListaVacia2 = True
                  Else
                     Set oRs = origen.DetEmpleadosSectores.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia2 = False
                     Else
                        Set oControl.DataSource = origen.DetEmpleadosSectores.TraerFiltrado("Primero")
                        ListaVacia2 = True
                     End If
                  End If
               Case "ListaJor"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetEmpleadosJornadas.TraerFiltrado("Primero")
                     ListaVacia2 = True
                  Else
                     Set oRs = origen.DetEmpleadosJornadas.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia3 = False
                     Else
                        Set oControl.DataSource = origen.DetEmpleadosJornadas.TraerFiltrado("Primero")
                        ListaVacia3 = True
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
               If oControl.Tag = "CuentasFF" Then
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
   
   If mvarId = -1 Then
      With origen.Registro
         .Fields("Administrador").Value = "NO"
         .Fields("SisMan").Value = "SI"
         .Fields("TipoUsuario").Value = 1
         .Fields("GrupoDeCarga").Value = 0
         If glbIdObraAsignadaUsuario > 0 Then
            .Fields("IdObraAsignada").Value = glbIdObraAsignadaUsuario
            Check8.Value = 1
            Check8.Enabled = False
            DataCombo1(11).Enabled = False
         Else
            Check8.Value = 0
         End If
      End With
      Check1.Value = 0
      Check6.Value = 0
      Option1.Value = True
      Option5.Value = True
   Else
      With origen.Registro
         If Not IsNull(.Fields("Administrador").Value) And _
               .Fields("Administrador").Value = "SI" Then
            Check1.Value = 1
         Else
            Check1.Value = 0
         End If
         Select Case .Fields("TipoUsuario").Value
            Case 1
               Option1.Value = True
            Case 2
               Option2.Value = True
            Case 3
               Option3.Value = True
            Case 4
               Option4.Value = True
            Case Else
               Option1.Value = True
         End Select
         If Not IsNull(.Fields("IdSector1").Value) Then
            Check2.Value = 1
         Else
            Check2.Value = 0
            DataCombo1(2).Enabled = False
            DataCombo1(3).Enabled = False
         End If
         If Not IsNull(.Fields("IdSector2").Value) Then
            Check3.Value = 1
         Else
            Check3.Value = 0
            DataCombo1(4).Enabled = False
            DataCombo1(5).Enabled = False
         End If
         If Not IsNull(.Fields("IdSector3").Value) Then
            Check4.Value = 1
         Else
            Check4.Value = 0
            DataCombo1(6).Enabled = False
            DataCombo1(7).Enabled = False
         End If
         If Not IsNull(.Fields("IdSector4").Value) Then
            Check5.Value = 1
         Else
            Check5.Value = 0
            DataCombo1(8).Enabled = False
            DataCombo1(9).Enabled = False
         End If
         If Not IsNull(.Fields("SisMan").Value) And _
               .Fields("SisMan").Value = "SI" Then
            Check6.Value = 1
         Else
            Check6.Value = 0
         End If
         If Not IsNull(.Fields("IdCuentaFondoFijo").Value) Then
            Check7.Value = 1
            DataCombo1(10).Enabled = True
         End If
         If Not IsNull(.Fields("IdObraAsignada").Value) Then
            Check8.Value = 1
            If glbIdObraAsignadaUsuario > 0 And Not glbAdministrador Then
               Check8.Enabled = False
               DataCombo1(11).Enabled = False
            Else
               DataCombo1(11).Enabled = True
            End If
         End If
         If IsNull(.Fields("Activo").Value) Or .Fields("Activo").Value = "SI" Then
            Option5.Value = True
         Else
            Option6.Value = True
         End If
         mAux1 = IIf(IsNull(.Fields("Idioma").Value), "", .Fields("Idioma").Value)
         If Len(mAux1) > 0 Then
            Check9.Value = 1
            Select Case mAux1
               Case "esp"
                  Combo1(0).ListIndex = 0
               Case "ing"
                  Combo1(0).ListIndex = 1
               Case "por"
                  Combo1(0).ListIndex = 2
            End Select
         End If
      End With
      txtEdad.Text = CalculaEdad(DTPicker1(0).Value, Now)
   End If
      
   If glbAdministrador Then
      Check1.Enabled = True
      txtPass(0).Enabled = True
   End If

   If Me.NivelAcceso <> EnumAccesos.Alto Then
      cmd(1).Enabled = False
   End If
      
   If ListaVacia1 Then
      Lista.ListItems.Clear
   End If
   
   If ListaVacia2 Then
      ListaSec.ListItems.Clear
   End If
   
   If ListaVacia3 Then
      ListaJor.ListItems.Clear
   End If
   
   If BuscarClaveINI("Activar campos para FF") = "SI" Then
      lblFieldLabel(19).Visible = True
      lblFieldLabel(20).Visible = True
      Check7.Visible = True
      Check8.Visible = True
      DataCombo1(10).Visible = True
      DataCombo1(11).Visible = True
   End If
   
   cmd(1).Enabled = False
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      If mvarId > 0 Then cmd(1).Enabled = True
   End If
   
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      Select Case Index
         Case 10
            Check7.Value = 1
      End Select
   End If

End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)
   
   SendKeys "%{DOWN}"

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DTPicker1_Change(Index As Integer)

   txtEdad.Text = CalculaEdad(DTPicker1(0).Value, Now)

End Sub

Private Sub DTPicker1_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTPicker1(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Load()

   If mvarId < 0 Then
      cmd(1).Enabled = False
   End If
   
   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   With ListaSec
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   With ListaJor
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

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

Private Sub ListaJor_DblClick()

   If ListaSec.ListItems.Count = 0 Then
      EditarCambioJornada -1
   Else
      EditarCambioJornada ListaJor.SelectedItem.Tag
   End If

End Sub

Private Sub ListaJor_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaJor_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetC_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetC_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetC_Click 1
   End If

End Sub

Private Sub ListaJor_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count = 0 Then
         MnuDetC(1).Enabled = False
         MnuDetC(2).Enabled = False
         PopupMenu MnuDetJor, , , , MnuDetC(0)
      Else
         MnuDetC(1).Enabled = True
         MnuDetC(2).Enabled = True
         PopupMenu MnuDetJor, , , , MnuDetC(1)
      End If
   End If

End Sub

Private Sub ListaSec_DblClick()

   If ListaSec.ListItems.Count = 0 Then
      EditarCambioSector -1
   Else
      EditarCambioSector ListaSec.SelectedItem.Tag
   End If

End Sub

Private Sub ListaSec_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaSec_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetB_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetB_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetB_Click 1
   End If

End Sub

Private Sub ListaSec_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If ListaSec.ListItems.Count = 0 Then
         MnuDetB(1).Enabled = False
         MnuDetB(2).Enabled = False
         PopupMenu MnuDetSec, , , , MnuDetB(0)
      Else
         MnuDetB(1).Enabled = True
         MnuDetB(2).Enabled = True
         PopupMenu MnuDetSec, , , , MnuDetB(1)
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
            origen.DetEmpleados.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub MnuDetB_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarCambioSector -1
      Case 1
         EditarCambioSector ListaSec.SelectedItem.Tag
      Case 2
         With ListaSec.SelectedItem
            origen.DetEmpleadosSectores.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub MnuDetC_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarCambioJornada -1
      Case 1
         EditarCambioJornada ListaJor.SelectedItem.Tag
      Case 2
         With ListaJor.SelectedItem
            origen.DetEmpleadosJornadas.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub txtDominio_GotFocus()

   With txtDominio
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDominio_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDominio
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtEmail_GotFocus()

   With txtEmail
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtEmail_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtEmail
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtGrupoDeCarga_GotFocus()

   With txtGrupoDeCarga
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtGrupoDeCarga_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtIniciales_GotFocus()

   With txtIniciales
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtIniciales_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtIniciales
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtInterno_GotFocus()

   With txtInterno
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtInterno_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtInterno
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtLegajo_GotFocus()

   With txtLegajo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtLegajo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   End If

End Sub

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

Private Sub txtPass_GotFocus(Index As Integer)

   With txtPass(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
      If Index = 0 Then mvarPass = .Text
   End With

End Sub

Private Sub txtPass_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtPass(Index)
         If Len(.DataField) Then
            If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
               KeyAscii = 0
            End If
         End If
      End With
   End If

End Sub

Private Sub txtPass_LostFocus(Index As Integer)

   If Index = 0 Then
      If Len(txtPass(0).Text) And txtPass(0).Text <> mvarPass Then
         lblPass.Visible = True
         With txtPass(1)
            .Visible = True
            .SetFocus
         End With
      End If
   Else
      If txtPass(1).Visible Then
         If txtPass(0).Text <> txtPass(1).Text Then
            MsgBox "Password incorrecto, intente nuevamente."
            With txtPass(0)
               .Text = ""
               .SetFocus
            End With
         End If
         lblPass.Visible = False
         txtPass(1).Visible = False
      End If
   End If

End Sub

Private Sub txtUsuarioNT_GotFocus()

   With txtUsuarioNT
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtUsuarioNT_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtUsuarioNT
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

