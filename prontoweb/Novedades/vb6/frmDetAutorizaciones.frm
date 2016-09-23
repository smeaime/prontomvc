VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetAutorizaciones 
   Caption         =   "Item de autorizacion"
   ClientHeight    =   7110
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   Icon            =   "frmDetAutorizaciones.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7110
   ScaleWidth      =   11880
   StartUpPosition =   2  'CenterScreen
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   5
      ItemData        =   "frmDetAutorizaciones.frx":076A
      Left            =   8235
      List            =   "frmDetAutorizaciones.frx":0777
      TabIndex        =   116
      Top             =   5985
      Width           =   1275
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   4
      ItemData        =   "frmDetAutorizaciones.frx":07A9
      Left            =   8235
      List            =   "frmDetAutorizaciones.frx":07B6
      TabIndex        =   108
      Top             =   4995
      Width           =   1275
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   3
      ItemData        =   "frmDetAutorizaciones.frx":07E8
      Left            =   8235
      List            =   "frmDetAutorizaciones.frx":07F5
      TabIndex        =   100
      Top             =   4005
      Width           =   1275
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   2
      ItemData        =   "frmDetAutorizaciones.frx":0827
      Left            =   8235
      List            =   "frmDetAutorizaciones.frx":0834
      TabIndex        =   92
      Top             =   3015
      Width           =   1275
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   1
      ItemData        =   "frmDetAutorizaciones.frx":0866
      Left            =   8235
      List            =   "frmDetAutorizaciones.frx":0873
      TabIndex        =   84
      Top             =   2025
      Width           =   1275
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   0
      ItemData        =   "frmDetAutorizaciones.frx":08A5
      Left            =   8235
      List            =   "frmDetAutorizaciones.frx":08B2
      TabIndex        =   76
      Top             =   1035
      Width           =   1275
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteHasta6"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Index           =   11
      Left            =   10710
      TabIndex        =   75
      Top             =   5940
      Width           =   1050
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteDesde6"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Index           =   10
      Left            =   10710
      TabIndex        =   74
      Top             =   5535
      Width           =   1050
   End
   Begin VB.Frame Frame1 
      Height          =   375
      Index           =   5
      Left            =   2565
      TabIndex        =   66
      Top             =   5535
      Width           =   6945
      Begin VB.OptionButton Option2 
         Caption         =   "Asignar al sector emisor"
         Height          =   195
         Index           =   5
         Left            =   1440
         TabIndex        =   71
         Top             =   135
         Width           =   1995
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Definir sector"
         Height          =   195
         Index           =   5
         Left            =   90
         TabIndex        =   70
         Top             =   135
         Value           =   -1  'True
         Width           =   1275
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Pers.de obra"
         Height          =   195
         Index           =   5
         Left            =   3555
         TabIndex        =   69
         Top             =   135
         Width           =   1545
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Vacio"
         Height          =   195
         Index           =   5
         Left            =   6165
         TabIndex        =   68
         Top             =   135
         Width           =   735
      End
      Begin VB.OptionButton Option5 
         Caption         =   "Firmante"
         Height          =   195
         Index           =   5
         Left            =   5130
         TabIndex        =   67
         Top             =   135
         Width           =   1005
      End
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteHasta5"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Index           =   9
      Left            =   10710
      TabIndex        =   65
      Top             =   4950
      Width           =   1050
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteDesde5"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Index           =   8
      Left            =   10710
      TabIndex        =   64
      Top             =   4545
      Width           =   1050
   End
   Begin VB.Frame Frame1 
      Height          =   375
      Index           =   4
      Left            =   2565
      TabIndex        =   56
      Top             =   4545
      Width           =   6945
      Begin VB.OptionButton Option2 
         Caption         =   "Asignar al sector emisor"
         Height          =   195
         Index           =   4
         Left            =   1440
         TabIndex        =   61
         Top             =   135
         Width           =   1995
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Definir sector"
         Height          =   195
         Index           =   4
         Left            =   90
         TabIndex        =   60
         Top             =   135
         Value           =   -1  'True
         Width           =   1275
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Pers.de obra"
         Height          =   195
         Index           =   4
         Left            =   3555
         TabIndex        =   59
         Top             =   135
         Width           =   1545
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Vacio"
         Height          =   195
         Index           =   4
         Left            =   6165
         TabIndex        =   58
         Top             =   135
         Width           =   735
      End
      Begin VB.OptionButton Option5 
         Caption         =   "Firmante"
         Height          =   195
         Index           =   4
         Left            =   5130
         TabIndex        =   57
         Top             =   135
         Width           =   1005
      End
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteHasta4"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Index           =   7
      Left            =   10710
      TabIndex        =   55
      Top             =   3960
      Width           =   1050
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteDesde4"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Index           =   6
      Left            =   10710
      TabIndex        =   54
      Top             =   3555
      Width           =   1050
   End
   Begin VB.Frame Frame1 
      Height          =   375
      Index           =   3
      Left            =   2565
      TabIndex        =   46
      Top             =   3555
      Width           =   6945
      Begin VB.OptionButton Option2 
         Caption         =   "Asignar al sector emisor"
         Height          =   195
         Index           =   3
         Left            =   1440
         TabIndex        =   51
         Top             =   135
         Width           =   1995
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Definir sector"
         Height          =   195
         Index           =   3
         Left            =   90
         TabIndex        =   50
         Top             =   135
         Value           =   -1  'True
         Width           =   1275
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Pers.de obra"
         Height          =   195
         Index           =   3
         Left            =   3555
         TabIndex        =   49
         Top             =   135
         Width           =   1545
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Vacio"
         Height          =   195
         Index           =   3
         Left            =   6165
         TabIndex        =   48
         Top             =   135
         Width           =   735
      End
      Begin VB.OptionButton Option5 
         Caption         =   "Firmante"
         Height          =   195
         Index           =   3
         Left            =   5130
         TabIndex        =   47
         Top             =   135
         Width           =   1005
      End
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteHasta3"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Index           =   5
      Left            =   10710
      TabIndex        =   45
      Top             =   2970
      Width           =   1050
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteDesde3"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Index           =   4
      Left            =   10710
      TabIndex        =   44
      Top             =   2565
      Width           =   1050
   End
   Begin VB.Frame Frame1 
      Height          =   375
      Index           =   2
      Left            =   2565
      TabIndex        =   36
      Top             =   2565
      Width           =   6945
      Begin VB.OptionButton Option2 
         Caption         =   "Asignar al sector emisor"
         Height          =   195
         Index           =   2
         Left            =   1440
         TabIndex        =   41
         Top             =   135
         Width           =   1995
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Definir sector"
         Height          =   195
         Index           =   2
         Left            =   90
         TabIndex        =   40
         Top             =   135
         Value           =   -1  'True
         Width           =   1275
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Pers.de obra"
         Height          =   195
         Index           =   2
         Left            =   3555
         TabIndex        =   39
         Top             =   135
         Width           =   1545
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Vacio"
         Height          =   195
         Index           =   2
         Left            =   6165
         TabIndex        =   38
         Top             =   135
         Width           =   735
      End
      Begin VB.OptionButton Option5 
         Caption         =   "Firmante"
         Height          =   195
         Index           =   2
         Left            =   5130
         TabIndex        =   37
         Top             =   135
         Width           =   1005
      End
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteHasta2"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Index           =   3
      Left            =   10710
      TabIndex        =   35
      Top             =   1980
      Width           =   1050
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteDesde2"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Index           =   2
      Left            =   10710
      TabIndex        =   34
      Top             =   1575
      Width           =   1050
   End
   Begin VB.Frame Frame1 
      Height          =   375
      Index           =   1
      Left            =   2565
      TabIndex        =   26
      Top             =   1575
      Width           =   6945
      Begin VB.OptionButton Option2 
         Caption         =   "Asignar al sector emisor"
         Height          =   195
         Index           =   1
         Left            =   1440
         TabIndex        =   31
         Top             =   135
         Width           =   1995
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Definir sector"
         Height          =   195
         Index           =   1
         Left            =   90
         TabIndex        =   30
         Top             =   135
         Value           =   -1  'True
         Width           =   1275
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Pers.de obra"
         Height          =   195
         Index           =   1
         Left            =   3555
         TabIndex        =   29
         Top             =   135
         Width           =   1545
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Vacio"
         Height          =   195
         Index           =   1
         Left            =   6165
         TabIndex        =   28
         Top             =   135
         Width           =   735
      End
      Begin VB.OptionButton Option5 
         Caption         =   "Firmante"
         Height          =   195
         Index           =   1
         Left            =   5130
         TabIndex        =   27
         Top             =   135
         Width           =   1005
      End
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteHasta1"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Index           =   1
      Left            =   10710
      TabIndex        =   22
      Top             =   990
      Width           =   1050
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteDesde1"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Index           =   0
      Left            =   10710
      TabIndex        =   21
      Top             =   585
      Width           =   1050
   End
   Begin VB.Frame Frame1 
      Height          =   375
      Index           =   0
      Left            =   2565
      TabIndex        =   11
      Top             =   585
      Width           =   6945
      Begin VB.OptionButton Option5 
         Caption         =   "Firmante"
         Height          =   195
         Index           =   0
         Left            =   5130
         TabIndex        =   25
         Top             =   135
         Width           =   1005
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Vacio"
         Height          =   195
         Index           =   0
         Left            =   6165
         TabIndex        =   18
         Top             =   135
         Width           =   735
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Pers.de obra"
         Height          =   195
         Index           =   0
         Left            =   3555
         TabIndex        =   17
         Top             =   135
         Width           =   1545
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Definir sector"
         Height          =   195
         Index           =   0
         Left            =   90
         TabIndex        =   13
         Top             =   135
         Value           =   -1  'True
         Width           =   1275
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Asignar al sector emisor"
         Height          =   195
         Index           =   0
         Left            =   1440
         TabIndex        =   12
         Top             =   135
         Width           =   2040
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   4275
      TabIndex        =   2
      Top             =   6570
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   6075
      TabIndex        =   3
      Top             =   6570
      Width           =   1485
   End
   Begin VB.TextBox txtOrdenAutorizacion 
      Alignment       =   2  'Center
      DataField       =   "OrdenAutorizacion"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1980
      TabIndex        =   0
      Top             =   135
      Width           =   555
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSectorAutoriza1"
      Height          =   315
      Index           =   0
      Left            =   810
      TabIndex        =   1
      Tag             =   "Sectores"
      Top             =   1035
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdSector"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCargoAutoriza1"
      Height          =   315
      Index           =   1
      Left            =   3150
      TabIndex        =   8
      Tag             =   "Cargos"
      Top             =   1035
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCargo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      DataField       =   "IdFirmante1"
      Height          =   315
      Index           =   0
      Left            =   5670
      TabIndex        =   23
      Tag             =   "Empleados"
      Top             =   1035
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSectorAutoriza2"
      Height          =   315
      Index           =   2
      Left            =   810
      TabIndex        =   78
      Tag             =   "Sectores"
      Top             =   2025
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdSector"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCargoAutoriza2"
      Height          =   315
      Index           =   3
      Left            =   3150
      TabIndex        =   79
      Tag             =   "Cargos"
      Top             =   2025
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCargo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      DataField       =   "IdFirmante2"
      Height          =   315
      Index           =   1
      Left            =   5670
      TabIndex        =   80
      Tag             =   "Empleados"
      Top             =   2025
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSectorAutoriza3"
      Height          =   315
      Index           =   4
      Left            =   810
      TabIndex        =   86
      Tag             =   "Sectores"
      Top             =   3015
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdSector"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCargoAutoriza3"
      Height          =   315
      Index           =   5
      Left            =   3150
      TabIndex        =   87
      Tag             =   "Cargos"
      Top             =   3015
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCargo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      DataField       =   "IdFirmante3"
      Height          =   315
      Index           =   2
      Left            =   5670
      TabIndex        =   88
      Tag             =   "Empleados"
      Top             =   3015
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSectorAutoriza4"
      Height          =   315
      Index           =   6
      Left            =   810
      TabIndex        =   94
      Tag             =   "Sectores"
      Top             =   4005
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdSector"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCargoAutoriza4"
      Height          =   315
      Index           =   7
      Left            =   3150
      TabIndex        =   95
      Tag             =   "Cargos"
      Top             =   4005
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCargo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      DataField       =   "IdFirmante4"
      Height          =   315
      Index           =   3
      Left            =   5670
      TabIndex        =   96
      Tag             =   "Empleados"
      Top             =   4005
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSectorAutoriza5"
      Height          =   315
      Index           =   8
      Left            =   810
      TabIndex        =   102
      Tag             =   "Sectores"
      Top             =   4995
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdSector"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCargoAutoriza5"
      Height          =   315
      Index           =   9
      Left            =   3150
      TabIndex        =   103
      Tag             =   "Cargos"
      Top             =   4995
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCargo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      DataField       =   "IdFirmante5"
      Height          =   315
      Index           =   4
      Left            =   5670
      TabIndex        =   104
      Tag             =   "Empleados"
      Top             =   4995
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSectorAutoriza6"
      Height          =   315
      Index           =   10
      Left            =   810
      TabIndex        =   110
      Tag             =   "Sectores"
      Top             =   5985
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdSector"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCargoAutoriza6"
      Height          =   315
      Index           =   11
      Left            =   3150
      TabIndex        =   111
      Tag             =   "Cargos"
      Top             =   5985
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCargo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      DataField       =   "IdFirmante6"
      Height          =   315
      Index           =   5
      Left            =   5670
      TabIndex        =   112
      Tag             =   "Empleados"
      Top             =   5985
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Pers.obra :"
      Height          =   255
      Index           =   42
      Left            =   7380
      TabIndex        =   117
      Top             =   6030
      Width           =   780
   End
   Begin VB.Label lblLabels 
      Caption         =   "Sector :"
      Height          =   255
      Index           =   41
      Left            =   135
      TabIndex        =   115
      Top             =   6030
      Width           =   600
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cargo :"
      Height          =   255
      Index           =   40
      Left            =   2520
      TabIndex        =   114
      Top             =   6030
      Width           =   555
   End
   Begin VB.Label lblLabels 
      Caption         =   "Firmante :"
      Height          =   255
      Index           =   39
      Left            =   4905
      TabIndex        =   113
      Top             =   6030
      Width           =   690
   End
   Begin VB.Label lblLabels 
      Caption         =   "Pers.obra :"
      Height          =   255
      Index           =   38
      Left            =   7380
      TabIndex        =   109
      Top             =   5040
      Width           =   780
   End
   Begin VB.Label lblLabels 
      Caption         =   "Sector :"
      Height          =   255
      Index           =   36
      Left            =   135
      TabIndex        =   107
      Top             =   5040
      Width           =   600
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cargo :"
      Height          =   255
      Index           =   33
      Left            =   2520
      TabIndex        =   106
      Top             =   5040
      Width           =   555
   End
   Begin VB.Label lblLabels 
      Caption         =   "Firmante :"
      Height          =   255
      Index           =   32
      Left            =   4905
      TabIndex        =   105
      Top             =   5040
      Width           =   690
   End
   Begin VB.Label lblLabels 
      Caption         =   "Pers.obra :"
      Height          =   255
      Index           =   30
      Left            =   7380
      TabIndex        =   101
      Top             =   4050
      Width           =   780
   End
   Begin VB.Label lblLabels 
      Caption         =   "Sector :"
      Height          =   255
      Index           =   27
      Left            =   135
      TabIndex        =   99
      Top             =   4050
      Width           =   600
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cargo :"
      Height          =   255
      Index           =   26
      Left            =   2520
      TabIndex        =   98
      Top             =   4050
      Width           =   555
   End
   Begin VB.Label lblLabels 
      Caption         =   "Firmante :"
      Height          =   255
      Index           =   25
      Left            =   4905
      TabIndex        =   97
      Top             =   4050
      Width           =   690
   End
   Begin VB.Label lblLabels 
      Caption         =   "Pers.obra :"
      Height          =   255
      Index           =   22
      Left            =   7380
      TabIndex        =   93
      Top             =   3060
      Width           =   780
   End
   Begin VB.Label lblLabels 
      Caption         =   "Sector :"
      Height          =   255
      Index           =   21
      Left            =   135
      TabIndex        =   91
      Top             =   3060
      Width           =   600
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cargo :"
      Height          =   255
      Index           =   17
      Left            =   2520
      TabIndex        =   90
      Top             =   3060
      Width           =   555
   End
   Begin VB.Label lblLabels 
      Caption         =   "Firmante :"
      Height          =   255
      Index           =   13
      Left            =   4905
      TabIndex        =   89
      Top             =   3060
      Width           =   690
   End
   Begin VB.Label lblLabels 
      Caption         =   "Pers.obra :"
      Height          =   255
      Index           =   11
      Left            =   7380
      TabIndex        =   85
      Top             =   2070
      Width           =   780
   End
   Begin VB.Label lblLabels 
      Caption         =   "Sector :"
      Height          =   255
      Index           =   10
      Left            =   135
      TabIndex        =   83
      Top             =   2070
      Width           =   600
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cargo :"
      Height          =   255
      Index           =   6
      Left            =   2520
      TabIndex        =   82
      Top             =   2070
      Width           =   555
   End
   Begin VB.Label lblLabels 
      Caption         =   "Firmante :"
      Height          =   255
      Index           =   5
      Left            =   4905
      TabIndex        =   81
      Top             =   2070
      Width           =   690
   End
   Begin VB.Label lblLabels 
      Caption         =   "Pers.obra :"
      Height          =   255
      Index           =   37
      Left            =   7380
      TabIndex        =   77
      Top             =   1080
      Width           =   780
   End
   Begin VB.Label lblLabels 
      Caption         =   "Hasta Imp. $ :"
      Height          =   255
      Index           =   35
      Left            =   9630
      TabIndex        =   73
      Top             =   5985
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Desde Imp. $ :"
      Height          =   255
      Index           =   34
      Left            =   9630
      TabIndex        =   72
      Top             =   5580
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Hasta Imp. $ :"
      Height          =   255
      Index           =   29
      Left            =   9630
      TabIndex        =   63
      Top             =   4995
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Desde Imp. $ :"
      Height          =   255
      Index           =   28
      Left            =   9630
      TabIndex        =   62
      Top             =   4590
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Hasta Imp. $ :"
      Height          =   255
      Index           =   24
      Left            =   9630
      TabIndex        =   53
      Top             =   4005
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Desde Imp. $ :"
      Height          =   255
      Index           =   23
      Left            =   9630
      TabIndex        =   52
      Top             =   3600
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Hasta Imp. $ :"
      Height          =   255
      Index           =   16
      Left            =   9630
      TabIndex        =   43
      Top             =   3015
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Desde Imp. $ :"
      Height          =   255
      Index           =   14
      Left            =   9630
      TabIndex        =   42
      Top             =   2610
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Hasta Imp. $ :"
      Height          =   255
      Index           =   9
      Left            =   9630
      TabIndex        =   33
      Top             =   2025
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Desde Imp. $ :"
      Height          =   255
      Index           =   8
      Left            =   9630
      TabIndex        =   32
      Top             =   1620
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Firmante :"
      Height          =   255
      Index           =   31
      Left            =   4905
      TabIndex        =   24
      Top             =   1080
      Width           =   690
   End
   Begin VB.Label lblLabels 
      Caption         =   "Hasta Imp. $ :"
      Height          =   255
      Index           =   20
      Left            =   9630
      TabIndex        =   20
      Top             =   1035
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Desde Imp. $ :"
      Height          =   255
      Index           =   19
      Left            =   9630
      TabIndex        =   19
      Top             =   630
      Width           =   1095
   End
   Begin VB.Line Line1 
      BorderWidth     =   2
      Index           =   4
      X1              =   90
      X2              =   11790
      Y1              =   5490
      Y2              =   5490
   End
   Begin VB.Line Line1 
      BorderWidth     =   2
      Index           =   3
      X1              =   90
      X2              =   11790
      Y1              =   4500
      Y2              =   4500
   End
   Begin VB.Line Line1 
      BorderWidth     =   2
      Index           =   2
      X1              =   90
      X2              =   11790
      Y1              =   3510
      Y2              =   3510
   End
   Begin VB.Line Line1 
      BorderWidth     =   2
      Index           =   1
      X1              =   90
      X2              =   11790
      Y1              =   2520
      Y2              =   2520
   End
   Begin VB.Line Line1 
      BorderWidth     =   2
      Index           =   0
      X1              =   90
      X2              =   11790
      Y1              =   1530
      Y2              =   1530
   End
   Begin VB.Label lblLabels 
      Caption         =   "Autorizacion ( 5to. Suplente ) :"
      Height          =   300
      Index           =   18
      Left            =   135
      TabIndex        =   16
      Top             =   5580
      Width           =   2310
   End
   Begin VB.Label lblLabels 
      Caption         =   "Autorizacion ( 4to. Suplente ) :"
      Height          =   300
      Index           =   15
      Left            =   135
      TabIndex        =   15
      Top             =   4590
      Width           =   2310
   End
   Begin VB.Label lblLabels 
      Caption         =   "Autorizacion ( 3er. Suplente ) :"
      Height          =   300
      Index           =   12
      Left            =   135
      TabIndex        =   14
      Top             =   3600
      Width           =   2310
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cargo :"
      Height          =   255
      Index           =   7
      Left            =   2520
      TabIndex        =   10
      Top             =   1080
      Width           =   555
   End
   Begin VB.Label lblLabels 
      Caption         =   "Sector :"
      Height          =   255
      Index           =   4
      Left            =   135
      TabIndex        =   9
      Top             =   1080
      Width           =   600
   End
   Begin VB.Label lblLabels 
      Caption         =   "Autorizacion ( 2do. Suplente ) :"
      Height          =   300
      Index           =   3
      Left            =   135
      TabIndex        =   7
      Top             =   2610
      Width           =   2310
   End
   Begin VB.Label lblLabels 
      Caption         =   "Autorizacion ( 1er. Suplente ) :"
      Height          =   300
      Index           =   1
      Left            =   135
      TabIndex        =   6
      Top             =   1620
      Width           =   2310
   End
   Begin VB.Label lblLabels 
      Caption         =   "Autorizacion (Titular) :"
      Height          =   300
      Index           =   2
      Left            =   135
      TabIndex        =   5
      Top             =   630
      Width           =   2310
   End
   Begin VB.Label lblLabels 
      Caption         =   "Orden de autorizacion :"
      Height          =   300
      Index           =   0
      Left            =   135
      TabIndex        =   4
      Top             =   135
      Width           =   1725
   End
End
Attribute VB_Name = "frmDetAutorizaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetAutorizacion
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oAutorizacion As ComPronto.Autorizacion
Dim mFormulario As EnumFormularios
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Dim i As Integer
   
   Select Case Index
      
      Case 0
      
         If Len(Trim(txtOrdenAutorizacion.Text)) = 0 Then
            MsgBox "Debe ingresar un orden de autorizacion", vbExclamation
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim mOrden As String
         
         With origen.Registro
            For i = 1 To 6
               Select Case i
                  Case 1
                     mOrden = "Titular"
                  Case 2
                     mOrden = "1er.Suplente"
                  Case 3
                     mOrden = "2do.Suplente"
                  Case 4
                     mOrden = "3er.Suplente"
                  Case 5
                     mOrden = "4to.Suplente"
                  Case 6
                     mOrden = "5to.Suplente"
               End Select
               .Fields("PersonalObra" & i).Value = Null
               If .Fields("SectorEmisor" & CStr(i)).Value = "N" Then
                  If Not IsNumeric(DataCombo1((i - 1) * 2).BoundText) Or Not IsNumeric(DataCombo1((i - 1) * 2 + 1).BoundText) Then
                     MsgBox "Debe definir un sector y un cargo para el " & mOrden, vbExclamation
                     Exit Sub
                  End If
               ElseIf .Fields("SectorEmisor" & CStr(i)).Value = "S" Then
                  If Not IsNumeric(DataCombo1((i - 1) * 2 + 1).BoundText) Then
                     MsgBox "Debe definir un cargo para el " & mOrden, vbExclamation
                     Exit Sub
                  End If
               ElseIf .Fields("SectorEmisor" & CStr(i)).Value = "F" Then
                  If Not IsNumeric(DataCombo2(i - 1).BoundText) Then
                     MsgBox "Debe definir un firmante para el " & mOrden, vbExclamation
                     Exit Sub
                  End If
                  If Len(txtImporte((i - 1) * 2).Text) = 0 Or _
                        Not IsNumeric(txtImporte((i - 1) * 2).Text) Then
                     MsgBox "Debe definir el importe desde para el " & mOrden, vbExclamation
                     Exit Sub
                  End If
                  If Len(txtImporte((i - 1) * 2 + 1).Text) = 0 Or _
                        Not IsNumeric(txtImporte((i - 1) * 2 + 1).Text) Then
                     MsgBox "Debe definir el importe hasta para el " & mOrden, vbExclamation
                     Exit Sub
                  End If
                  If Val(txtImporte((i - 1) * 2).Text) > Val(txtImporte((i - 1) * 2 + 1).Text) Then
                     MsgBox "El importe desde no puede ser mayor al importe hasta para el " & mOrden, vbExclamation
                     Exit Sub
                  End If
               ElseIf .Fields("SectorEmisor" & CStr(i)).Value = "O" Then
                  .Fields("PersonalObra" & CStr(i)).Value = Combo1(i - 1).ListIndex
               End If
            Next
            For Each dc In DataCombo1
               If Len(Trim(dc.BoundText)) Then
                  .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
            For Each dc In DataCombo2
               If Len(Trim(dc.BoundText)) Then
                  .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
         End With
      
         origen.Modificado = True
         Aceptado = True
   
      Case 1
      
         If mvarId = -1 Then
            origen.Eliminado = True
         End If
   
   End Select
   
   Me.Hide

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim dtp As DTPicker
   Dim oAp As ComPronto.Aplicacion
   Dim i As Integer

   Set oAp = Aplicacion
   mvarId = vnewvalue
   Set origen = oAutorizacion.DetAutorizaciones.Item(vnewvalue)
   Me.IdNuevo = origen.Id
   Set oBind = New BindingCollection
   
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
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
   
   If mvarId = -1 Then
      With origen.Registro
         For i = 1 To 6
            .Fields("SectorEmisor" & CStr(i)).Value = "V"
            Option4(i - 1).Value = True
         Next
      End With
   Else
      With origen.Registro
         For i = 1 To 6
            If .Fields("SectorEmisor" & CStr(i)).Value = "N" Then
               Option1(i - 1).Value = True
               DataCombo1((i - 1) * 2).Enabled = True
               DataCombo1((i - 1) * 2 + 1).Enabled = True
            ElseIf .Fields("SectorEmisor" & CStr(i)).Value = "S" Then
               Option2(i - 1).Value = True
               DataCombo1((i - 1) * 2 + 1).Enabled = True
            ElseIf .Fields("SectorEmisor" & CStr(i)).Value = "O" Then
               Option3(i - 1).Value = True
               Combo1(i - 1).ListIndex = IIf(IsNull(.Fields("PersonalObra" & CStr(i))), 0, .Fields("PersonalObra" & CStr(i)))
            ElseIf .Fields("SectorEmisor" & CStr(i)).Value = "F" Then
               Option5(i - 1).Value = True
               DataCombo2(i - 1).Enabled = True
            ElseIf IsNull(.Fields("SectorEmisor" & CStr(i)).Value) Or .Fields("SectorEmisor" & CStr(i)).Value = "V" Then
               Option4(i - 1).Value = True
            End If
         Next
      End With
   End If
   
   If mFormulario <> EnumFormularios.RequerimientoMateriales Then
      For i = 1 To 6
         If mFormulario <> EnumFormularios.NotaPedido Then
            Option2(i - 1).Enabled = False
            Option3(i - 1).Enabled = False
         End If
      Next
   End If
   If mFormulario <> EnumFormularios.NotaPedido Then
      For i = 1 To 6
         Option5(i - 1).Enabled = False
      Next
   End If
   
   Set oAp = Nothing
   
End Property

Public Property Get Autorizacion() As ComPronto.Autorizacion

   Set Autorizacion = oAutorizacion

End Property

Public Property Set Autorizacion(ByVal vnewvalue As ComPronto.Autorizacion)

   Set oAutorizacion = vnewvalue

End Property

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vnewvalue As Variant)

   mvarIdNuevo = vnewvalue

End Property

Private Sub Form_Load()

   ReemplazarEtiquetas Me

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oBind = Nothing
   Set origen = Nothing
   Set oAutorizacion = Nothing

End Sub

Private Sub Option1_Click(Index As Integer)

   If Option1(Index).Value Then
      With origen.Registro
         .Fields("IdFirmante" & CStr(Index + 1)).Value = Null
         .Fields("ImporteDesde" & CStr(Index + 1)).Value = Null
         .Fields("ImporteHasta" & CStr(Index + 1)).Value = Null
         .Fields("SectorEmisor" & CStr(Index + 1)).Value = "N"
      End With
      DataCombo1(Index * 2).Enabled = True
      DataCombo1(Index * 2 + 1).Enabled = True
      DataCombo2(Index).Enabled = False
      Combo1(Index).Enabled = False
      Combo1(Index).ListIndex = -1
      txtImporte(Index * 2).Enabled = False
      txtImporte(Index * 2 + 1).Enabled = False
   End If
   
End Sub

Private Sub Option2_Click(Index As Integer)

   If Option2(Index).Value Then
      With origen.Registro
         .Fields("IdSectorAutoriza" & CStr(Index + 1)).Value = Null
         .Fields("IdFirmante" & CStr(Index + 1)).Value = Null
'         .Fields("ImporteDesde" & CStr(Index + 1)).Value = Null
'         .Fields("ImporteHasta" & CStr(Index + 1)).Value = Null
         .Fields("SectorEmisor" & CStr(Index + 1)).Value = "S"
      End With
      DataCombo1(Index * 2).Enabled = False
      DataCombo1(Index * 2 + 1).Enabled = True
      DataCombo2(Index).Enabled = False
      Combo1(Index).Enabled = False
      Combo1(Index).ListIndex = -1
      txtImporte(Index * 2).Enabled = True
      txtImporte(Index * 2 + 1).Enabled = True
   End If
   
End Sub

Private Sub Option3_Click(Index As Integer)

   If Option3(Index).Value Then
      With origen.Registro
         .Fields("IdSectorAutoriza" & CStr(Index + 1)).Value = Null
         .Fields("IdCargoAutoriza" & CStr(Index + 1)).Value = Null
         .Fields("IdFirmante" & CStr(Index + 1)).Value = Null
'         .Fields("ImporteDesde" & CStr(Index + 1)).Value = Null
'         .Fields("ImporteHasta" & CStr(Index + 1)).Value = Null
         .Fields("SectorEmisor" & CStr(Index + 1)).Value = "O"
      End With
      DataCombo1(Index * 2).Enabled = False
      DataCombo1(Index * 2 + 1).Enabled = False
      DataCombo2(Index).Enabled = False
      Combo1(Index).Enabled = True
      Combo1(Index).ListIndex = 0
      txtImporte(Index * 2).Enabled = True
      txtImporte(Index * 2 + 1).Enabled = True
   End If

End Sub

Private Sub Option4_Click(Index As Integer)

   If Option4(Index).Value Then
      With origen.Registro
         .Fields("IdSectorAutoriza" & CStr(Index + 1)).Value = Null
         .Fields("IdCargoAutoriza" & CStr(Index + 1)).Value = Null
         .Fields("IdFirmante" & CStr(Index + 1)).Value = Null
         .Fields("ImporteDesde" & CStr(Index + 1)).Value = Null
         .Fields("ImporteHasta" & CStr(Index + 1)).Value = Null
         .Fields("SectorEmisor" & CStr(Index + 1)).Value = "V"
      End With
      DataCombo1(Index * 2).Enabled = False
      DataCombo1(Index * 2 + 1).Enabled = False
      DataCombo2(Index).Enabled = False
      Combo1(Index).Enabled = False
      Combo1(Index).ListIndex = -1
      txtImporte(Index * 2).Enabled = False
      txtImporte(Index * 2 + 1).Enabled = False
   End If

End Sub

Private Sub Option5_Click(Index As Integer)

   If Option5(Index).Value Then
      With origen.Registro
         .Fields("IdSectorAutoriza" & CStr(Index + 1)).Value = Null
         .Fields("IdCargoAutoriza" & CStr(Index + 1)).Value = Null
         .Fields("SectorEmisor" & CStr(Index + 1)).Value = "F"
      End With
      DataCombo1(Index * 2).Enabled = False
      DataCombo1(Index * 2 + 1).Enabled = False
      DataCombo2(Index).Enabled = True
      Combo1(Index).Enabled = False
      Combo1(Index).ListIndex = -1
      txtImporte(Index * 2).Enabled = True
      txtImporte(Index * 2 + 1).Enabled = True
   End If

End Sub

Private Sub txtImporte_GotFocus(Index As Integer)

   With txtImporte(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImporte_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtOrdenAutorizacion_GotFocus()

   With txtOrdenAutorizacion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtOrdenAutorizacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Let Formulario(ByVal vnewvalue As EnumFormularios)

   mFormulario = vnewvalue
   
End Property
