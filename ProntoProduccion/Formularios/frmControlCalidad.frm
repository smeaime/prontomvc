VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "msdatlst.ocx"
Begin VB.Form frmTipoControlCalidad 
   Caption         =   "Tipo de Control de Calidad"
   ClientHeight    =   3990
   ClientLeft      =   60
   ClientTop       =   420
   ClientWidth     =   9960
   LinkTopic       =   "Form2"
   ScaleHeight     =   3990
   ScaleWidth      =   9960
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtFrecuencia 
      Alignment       =   1  'Right Justify
      DataField       =   "P5Frecuencia"
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
      Left            =   7800
      TabIndex        =   51
      Top             =   2640
      Width           =   615
   End
   Begin VB.TextBox txtParamCod 
      Alignment       =   1  'Right Justify
      DataField       =   "P5Codigo"
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
      Left            =   1320
      TabIndex        =   50
      Top             =   2640
      Width           =   495
   End
   Begin VB.TextBox txtParametrDescripcion 
      Alignment       =   1  'Right Justify
      DataField       =   "P5Descripcion"
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
      Left            =   1920
      TabIndex        =   49
      Top             =   2640
      Width           =   3495
   End
   Begin VB.CheckBox chkObligatorio 
      Height          =   255
      Index           =   4
      Left            =   9360
      TabIndex        =   47
      Top             =   2700
      Width           =   495
   End
   Begin VB.TextBox txtMinimo 
      Alignment       =   1  'Right Justify
      DataField       =   "P5RangoMinimo"
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
      Left            =   5520
      TabIndex        =   46
      Top             =   2640
      Width           =   615
   End
   Begin VB.TextBox txtMaximo 
      Alignment       =   1  'Right Justify
      DataField       =   "P5RangoMaximo"
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
      Left            =   6240
      TabIndex        =   45
      Top             =   2640
      Width           =   615
   End
   Begin VB.TextBox txtFrecuencia 
      Alignment       =   1  'Right Justify
      DataField       =   "P4Frecuencia"
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
      Left            =   7800
      TabIndex        =   42
      Top             =   2280
      Width           =   615
   End
   Begin VB.TextBox txtParamCod 
      Alignment       =   1  'Right Justify
      DataField       =   "P4Codigo"
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
      Left            =   1320
      TabIndex        =   41
      Top             =   2280
      Width           =   495
   End
   Begin VB.TextBox txtParametrDescripcion 
      Alignment       =   1  'Right Justify
      DataField       =   "P4Descripcion"
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
      Left            =   1920
      TabIndex        =   40
      Top             =   2280
      Width           =   3495
   End
   Begin VB.CheckBox chkObligatorio 
      Height          =   255
      Index           =   3
      Left            =   9360
      TabIndex        =   38
      Top             =   2340
      Width           =   495
   End
   Begin VB.TextBox txtMinimo 
      Alignment       =   1  'Right Justify
      DataField       =   "P4RangoMinimo"
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
      Left            =   5520
      TabIndex        =   37
      Top             =   2280
      Width           =   615
   End
   Begin VB.TextBox txtMaximo 
      Alignment       =   1  'Right Justify
      DataField       =   "P4RangoMaximo"
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
      Left            =   6240
      TabIndex        =   36
      Top             =   2280
      Width           =   615
   End
   Begin VB.TextBox txtFrecuencia 
      Alignment       =   1  'Right Justify
      DataField       =   "P3Frecuencia"
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
      Left            =   7800
      TabIndex        =   33
      Top             =   1920
      Width           =   615
   End
   Begin VB.TextBox txtParamCod 
      Alignment       =   1  'Right Justify
      DataField       =   "P3Codigo"
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
      Left            =   1320
      TabIndex        =   32
      Top             =   1920
      Width           =   495
   End
   Begin VB.TextBox txtParametrDescripcion 
      Alignment       =   1  'Right Justify
      DataField       =   "P3Descripcion"
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
      Left            =   1920
      TabIndex        =   31
      Top             =   1920
      Width           =   3495
   End
   Begin VB.CheckBox chkObligatorio 
      Height          =   255
      Index           =   2
      Left            =   9360
      TabIndex        =   29
      Top             =   1980
      Width           =   495
   End
   Begin VB.TextBox txtMinimo 
      Alignment       =   1  'Right Justify
      DataField       =   "P3RangoMinimo"
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
      Left            =   5520
      TabIndex        =   28
      Top             =   1920
      Width           =   615
   End
   Begin VB.TextBox txtMaximo 
      Alignment       =   1  'Right Justify
      DataField       =   "P3RangoMaximo"
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
      Left            =   6240
      TabIndex        =   27
      Top             =   1920
      Width           =   615
   End
   Begin VB.TextBox txtFrecuencia 
      Alignment       =   1  'Right Justify
      DataField       =   "P2Frecuencia"
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
      Left            =   7800
      TabIndex        =   24
      Top             =   1560
      Width           =   615
   End
   Begin VB.TextBox txtParamCod 
      Alignment       =   1  'Right Justify
      DataField       =   "P2Codigo"
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
      Left            =   1320
      TabIndex        =   23
      Top             =   1560
      Width           =   495
   End
   Begin VB.TextBox txtParametrDescripcion 
      Alignment       =   1  'Right Justify
      DataField       =   "P2Descripcion"
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
      Left            =   1920
      TabIndex        =   22
      Top             =   1560
      Width           =   3495
   End
   Begin VB.CheckBox chkObligatorio 
      Height          =   255
      Index           =   1
      Left            =   9360
      TabIndex        =   20
      Top             =   1620
      Width           =   495
   End
   Begin VB.TextBox txtMinimo 
      Alignment       =   1  'Right Justify
      DataField       =   "P2RangoMinimo"
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
      Left            =   5520
      TabIndex        =   19
      Top             =   1560
      Width           =   615
   End
   Begin VB.TextBox txtMaximo 
      Alignment       =   1  'Right Justify
      DataField       =   "P2RangoMaximo"
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
      Left            =   6240
      TabIndex        =   18
      Top             =   1560
      Width           =   615
   End
   Begin VB.TextBox txtFrecuencia 
      Alignment       =   1  'Right Justify
      DataField       =   "P1Frecuencia"
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
      Left            =   7800
      TabIndex        =   15
      Top             =   1200
      Width           =   615
   End
   Begin VB.TextBox txtParamCod 
      Alignment       =   1  'Right Justify
      DataField       =   "P1Codigo"
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
      Left            =   1320
      TabIndex        =   13
      Top             =   1200
      Width           =   495
   End
   Begin VB.TextBox txtParametrDescripcion 
      Alignment       =   1  'Right Justify
      DataField       =   "P1Descripcion"
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
      Left            =   1920
      TabIndex        =   12
      Top             =   1200
      Width           =   3495
   End
   Begin VB.TextBox Text3 
      Alignment       =   1  'Right Justify
      DataField       =   "Codigo"
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
      Left            =   1320
      TabIndex        =   11
      Top             =   240
      Width           =   615
   End
   Begin VB.TextBox Text2 
      Alignment       =   1  'Right Justify
      DataField       =   "Descripcion"
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
      Left            =   3240
      TabIndex        =   10
      Top             =   240
      Width           =   2775
   End
   Begin VB.TextBox txtMaximo 
      Alignment       =   1  'Right Justify
      DataField       =   "P1RangoMaximo"
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
      Left            =   6240
      TabIndex        =   7
      Top             =   1200
      Width           =   615
   End
   Begin VB.TextBox txtMinimo 
      Alignment       =   1  'Right Justify
      DataField       =   "P1RangoMinimo"
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
      Left            =   5520
      TabIndex        =   6
      Top             =   1200
      Width           =   615
   End
   Begin VB.CheckBox chkObligatorio 
      Height          =   255
      Index           =   0
      Left            =   9360
      TabIndex        =   5
      Top             =   1260
      Width           =   495
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Cancelar"
      Height          =   495
      Index           =   2
      Left            =   8280
      TabIndex        =   4
      Top             =   3360
      Width           =   1335
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Eliminar"
      Height          =   495
      Index           =   1
      Left            =   6840
      TabIndex        =   3
      Top             =   3360
      Width           =   1335
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Aceptar"
      Height          =   495
      Index           =   0
      Left            =   5400
      TabIndex        =   2
      Top             =   3360
      Width           =   1335
   End
   Begin MSDataListLib.DataCombo txtRangoUnidad 
      DataField       =   "P1RangoIdUnidad"
      Height          =   315
      Index           =   10
      Left            =   6960
      TabIndex        =   8
      Tag             =   "Unidades"
      Top             =   1200
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo txtFrecuenciaUnidad 
      DataField       =   "P1FrecuenciaIdUnidad"
      Height          =   315
      Index           =   0
      Left            =   8520
      TabIndex        =   16
      Tag             =   "Unidades"
      Top             =   1200
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo txtRangoUnidad 
      DataField       =   "P2RangoIdUnidad"
      Height          =   315
      Index           =   0
      Left            =   6960
      TabIndex        =   21
      Tag             =   "Unidades"
      Top             =   1560
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo txtFrecuenciaUnidad 
      DataField       =   "P2FrecuenciaIdUnidad"
      Height          =   315
      Index           =   1
      Left            =   8520
      TabIndex        =   25
      Tag             =   "Unidades"
      Top             =   1560
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo txtRangoUnidad 
      DataField       =   "P3RangoIdUnidad"
      Height          =   315
      Index           =   1
      Left            =   6960
      TabIndex        =   30
      Tag             =   "Unidades"
      Top             =   1920
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo txtFrecuenciaUnidad 
      DataField       =   "P3FrecuenciaIdUnidad"
      Height          =   315
      Index           =   2
      Left            =   8520
      TabIndex        =   34
      Tag             =   "Unidades"
      Top             =   1920
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo txtRangoUnidad 
      DataField       =   "P4RangoIdUnidad"
      Height          =   315
      Index           =   2
      Left            =   6960
      TabIndex        =   39
      Tag             =   "Unidades"
      Top             =   2280
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo txtFrecuenciaUnidad 
      DataField       =   "P4FrecuenciaIdUnidad"
      Height          =   315
      Index           =   3
      Left            =   8520
      TabIndex        =   43
      Tag             =   "Unidades"
      Top             =   2280
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo txtRangoUnidad 
      DataField       =   "P5RangoIdUnidad"
      Height          =   315
      Index           =   3
      Left            =   6960
      TabIndex        =   48
      Tag             =   "Unidades"
      Top             =   2640
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo txtFrecuenciaUnidad 
      DataField       =   "P5FrecuenciaIdUnidad"
      Height          =   315
      Index           =   4
      Left            =   8520
      TabIndex        =   52
      Tag             =   "Unidades"
      Top             =   2640
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin VB.Label lblOblig 
      Caption         =   "Oblig."
      Height          =   225
      Index           =   2
      Left            =   9240
      TabIndex        =   57
      Top             =   960
      Width           =   495
   End
   Begin VB.Label Label4 
      Caption         =   "Código"
      Height          =   255
      Left            =   1320
      TabIndex        =   56
      Top             =   960
      Width           =   495
   End
   Begin VB.Label Label3 
      Caption         =   "Descripción"
      Height          =   255
      Left            =   1920
      TabIndex        =   55
      Top             =   960
      Width           =   975
   End
   Begin VB.Label lblMáxima 
      Caption         =   "Mín."
      Height          =   225
      Index           =   1
      Left            =   5520
      TabIndex        =   54
      Top             =   960
      Width           =   615
   End
   Begin VB.Label lblParámetro1 
      Caption         =   "Parámetro 5"
      Height          =   255
      Index           =   4
      Left            =   240
      TabIndex        =   53
      Top             =   2760
      Width           =   975
   End
   Begin VB.Label lblParámetro1 
      Caption         =   "Parámetro 4"
      Height          =   255
      Index           =   3
      Left            =   240
      TabIndex        =   44
      Top             =   2400
      Width           =   975
   End
   Begin VB.Label lblParámetro1 
      Caption         =   "Parámetro 3"
      Height          =   255
      Index           =   2
      Left            =   240
      TabIndex        =   35
      Top             =   2040
      Width           =   975
   End
   Begin VB.Label lblParámetro1 
      Caption         =   "Parámetro 2"
      Height          =   255
      Index           =   1
      Left            =   240
      TabIndex        =   26
      Top             =   1680
      Width           =   975
   End
   Begin VB.Label lblMáxima 
      Caption         =   "Frecuencia"
      Height          =   225
      Index           =   0
      Left            =   7800
      TabIndex        =   17
      Top             =   960
      Width           =   1335
   End
   Begin VB.Label lblParámetro1 
      Caption         =   "Parámetro 1"
      Height          =   255
      Index           =   0
      Left            =   240
      TabIndex        =   14
      Top             =   1320
      Width           =   975
   End
   Begin VB.Line Line1 
      X1              =   240
      X2              =   9600
      Y1              =   720
      Y2              =   720
   End
   Begin VB.Label lblMáxima 
      Caption         =   "Máx."
      Height          =   225
      Index           =   10
      Left            =   6240
      TabIndex        =   9
      Top             =   960
      Width           =   615
   End
   Begin VB.Label Label2 
      Caption         =   "Descripción"
      Height          =   255
      Left            =   2280
      TabIndex        =   1
      Top             =   360
      Width           =   975
   End
   Begin VB.Label Label1 
      Caption         =   "Código"
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   360
      Width           =   735
   End
End
Attribute VB_Name = "frmTipoControlCalidad"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.ControlCalidadTipo
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long
Private mNivelAcceso As Integer, mOpcionesAcceso As String
Dim WithEvents ActL As ControlForm
Attribute ActL.VB_VarHelpID = -1


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

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
   
         'If Len(txtRubro.Text) = 0 Then
         '   MsgBox "No puede grabar un rubro sin descripcion", vbExclamation
         '   Exit Sub
         'End If

        'If Not IsNumeric(txtFrecuenciaUnidad(0).BoundText) Then
        '    MsgBox "Debe indicar la cuenta contable", vbExclamation
        '    Exit Sub
        'End If
            
         Dim est As EnumAcciones
         Dim oControl As Control
   
         For Each oControl In Me.Controls
            If TypeOf oControl Is DataCombo Then
               If Len(oControl.BoundText) <> 0 Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
               End If
            ElseIf TypeOf oControl Is DTPicker Then
               origen.Registro.Fields(oControl.DataField).Value = oControl.Value
            End If
         Next
      
         
        With origen.Registro
            If chkObligatorio(0).Value Then
                .Fields("P1EsObligatorio").Value = "SI"
            Else
                .Fields("P1EsObligatorio").Value = "NO"
            End If
         
            If chkObligatorio(1).Value Then
                .Fields("P2EsObligatorio").Value = "SI"
            Else
                .Fields("P2EsObligatorio").Value = "NO"
            End If
         
            If chkObligatorio(2).Value Then
                .Fields("P3EsObligatorio").Value = "SI"
            Else
                .Fields("P3EsObligatorio").Value = "NO"
            End If
         
            If chkObligatorio(3).Value Then
                .Fields("P4EsObligatorio").Value = "SI"
            Else
                .Fields("P4EsObligatorio").Value = "NO"
            End If
         
            If chkObligatorio(4).Value Then
                .Fields("P5EsObligatorio").Value = "SI"
            Else
                .Fields("P5EsObligatorio").Value = "NO"
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
      
         
            
         With actL2
            .ListaEditada = "ControlCalidads"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
        'Aplicacion.Tarea "ProduccionControlCalidads_A", Array(0, DataCombo1(0).BoundText, txtCodigo, txtDescripcion)
   
      Case 1
   
         Dim mBorra As Integer
        mBorra = MsgBox("Esta seguro de eliminar los datos definitivamente ?", vbYesNo, "Eliminar")
         If mBorra = vbNo Then
            Exit Sub
         End If
        
        origen.Eliminar
        
        est = baja
        Aplicacion.Tarea "Log_InsertarRegistro", _
              Array("ELIM", mvarId, 0, Now, 0, "Tabla : Rubros", GetCompName(), glbNombreUsuario)
            
         With actL2
       
           .AccionRegistro = est
            .Disparador = mvarId
         End With
    Case 2
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



Private Sub Cmd1_Click()

End Sub

Private Sub Form_Paint()

   ''Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)


   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   

End Sub

Private Sub ActL_ActLista(ByVal IdRegistro As Long, _
                          ByVal TipoAccion As EnumAcciones, _
                          ByVal NombreListaEditada As String, _
                          ByVal IdRegistroOriginal As Long)

'   ActualizarLista IdRegistro, TipoAccion, NombreListaEditada, IdRegistroOriginal

End Sub
Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Public Property Let Id(ByVal vnewvalue As Long)



   Dim oAp As ComPronto.Aplicacion
   Dim oApProd As ComPronto.Aplicacion
   Dim oControl As Control
   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set oApProd = AplicacionProd
   Set origen = oApProd.ControlCalidadTipos.Item(vnewvalue)
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
   
         ElseIf TypeOf oControl Is DbListView Then
         ElseIf TypeOf oControl Is label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
     
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
  
   
   With origen.Registro
    
      If IsNull(!P1EsObligatorio.Value) Or !P1EsObligatorio.Value = "SI" Then
         chkObligatorio(0).Value = 1
      Else
         chkObligatorio(0).Value = 0
      End If

      If IsNull(!P2EsObligatorio.Value) Or !P2EsObligatorio.Value = "SI" Then
         chkObligatorio(1).Value = 1
      Else
         chkObligatorio(1).Value = 0
      End If

      If IsNull(!P3EsObligatorio.Value) Or !P3EsObligatorio.Value = "SI" Then
         chkObligatorio(2).Value = 1
      Else
         chkObligatorio(2).Value = 0
      End If

      If IsNull(!P4EsObligatorio.Value) Or !P4EsObligatorio.Value = "SI" Then
         chkObligatorio(3).Value = 1
      Else
         chkObligatorio(3).Value = 0
      End If

      If IsNull(!P5EsObligatorio.Value) Or !P5EsObligatorio.Value = "SI" Then
         chkObligatorio(4).Value = 1
      Else
         chkObligatorio(4).Value = 0
      End If
    
    End With
  
  
   'Set txtFrecuenciaUnidad(0).RowSource = Aplicacion.TablasGenerales.TraerLista("ProduccionSectores")
   
   
   cmd(1).Enabled = True
   cmd(0).Enabled = True
   
   Set oApProd = Nothing
   Set oAp = Nothing

End Property


