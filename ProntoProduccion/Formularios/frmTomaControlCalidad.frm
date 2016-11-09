VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "msdatlst.ocx"
Begin VB.Form frmTomaControlCalidad 
   Caption         =   "Control de Calidad"
   ClientHeight    =   3960
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   6855
   LinkTopic       =   "Form1"
   ScaleHeight     =   3960
   ScaleWidth      =   6855
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   600
      Index           =   1
      Left            =   5805
      TabIndex        =   17
      Top             =   3120
      Width           =   795
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   600
      Index           =   0
      Left            =   4920
      TabIndex        =   16
      Top             =   3120
      Width           =   795
   End
   Begin VB.TextBox txtMaximo 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Index           =   0
      Left            =   4320
      TabIndex        =   9
      Top             =   960
      Width           =   615
   End
   Begin VB.TextBox txtMaximo 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Index           =   1
      Left            =   4320
      TabIndex        =   8
      Top             =   1320
      Width           =   615
   End
   Begin VB.TextBox txtMaximo 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Index           =   2
      Left            =   4320
      TabIndex        =   7
      Top             =   1680
      Width           =   615
   End
   Begin VB.TextBox txtMaximo 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Index           =   3
      Left            =   4320
      TabIndex        =   6
      Top             =   2040
      Width           =   615
   End
   Begin VB.TextBox txtMaximo 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Index           =   4
      Left            =   4320
      TabIndex        =   5
      Top             =   2400
      Width           =   615
   End
   Begin MSDataListLib.DataCombo txtRangoUnidad 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   10
      Left            =   5040
      TabIndex        =   10
      Tag             =   "Unidades"
      Top             =   960
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo txtRangoUnidad 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   0
      Left            =   5040
      TabIndex        =   11
      Tag             =   "Unidades"
      Top             =   1320
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo txtRangoUnidad 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   1
      Left            =   5040
      TabIndex        =   12
      Tag             =   "Unidades"
      Top             =   1680
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo txtRangoUnidad 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   2
      Left            =   5040
      TabIndex        =   13
      Tag             =   "Unidades"
      Top             =   2040
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo txtRangoUnidad 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   3
      Left            =   5040
      TabIndex        =   14
      Tag             =   "Unidades"
      Top             =   2400
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdArticuloGenerado"
      Height          =   315
      Index           =   11
      Left            =   1200
      TabIndex        =   15
      Tag             =   "Articulos"
      Top             =   360
      Width           =   4575
      _ExtentX        =   8070
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin VB.Label lblParámetro1 
      Caption         =   "Parámetro 1"
      Height          =   255
      Index           =   0
      Left            =   1080
      TabIndex        =   4
      Top             =   1080
      Width           =   975
   End
   Begin VB.Label lblParámetro1 
      Caption         =   "Parámetro 2"
      Height          =   255
      Index           =   1
      Left            =   1080
      TabIndex        =   3
      Top             =   1440
      Width           =   975
   End
   Begin VB.Label lblParámetro1 
      Caption         =   "Parámetro 3"
      Height          =   255
      Index           =   2
      Left            =   1080
      TabIndex        =   2
      Top             =   1800
      Width           =   975
   End
   Begin VB.Label lblParámetro1 
      Caption         =   "Parámetro 4"
      Height          =   255
      Index           =   3
      Left            =   1080
      TabIndex        =   1
      Top             =   2160
      Width           =   975
   End
   Begin VB.Label lblParámetro1 
      Caption         =   "Parámetro 5"
      Height          =   255
      Index           =   4
      Left            =   1080
      TabIndex        =   0
      Top             =   2520
      Width           =   975
   End
End
Attribute VB_Name = "frmTomaControlCalidad"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
