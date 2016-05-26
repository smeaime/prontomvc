VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{126E538A-EE41-4B22-A045-F8D5538F5D2B}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmDetAcopios 
   Caption         =   "Item de lista de acopio"
   ClientHeight    =   7545
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10800
   Icon            =   "frmDetAcopios.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7545
   ScaleWidth      =   10800
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtImporteTotal 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
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
      Height          =   315
      Left            =   9225
      TabIndex        =   55
      Top             =   3330
      Width           =   1230
   End
   Begin VB.TextBox txtPrecio 
      Alignment       =   1  'Right Justify
      DataField       =   "Precio"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2250
      TabIndex        =   10
      Top             =   2970
      Width           =   1230
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Activar"
      Height          =   315
      Index           =   3
      Left            =   7065
      TabIndex        =   32
      Top             =   2970
      Width           =   765
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Activar"
      Height          =   315
      Index           =   2
      Left            =   7065
      TabIndex        =   31
      Top             =   2610
      Width           =   765
   End
   Begin VB.TextBox txtUnidad 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
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
      Height          =   315
      Left            =   7830
      TabIndex        =   14
      Top             =   1125
      Width           =   2670
   End
   Begin VB.TextBox txtCantidad2 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad2"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   6885
      TabIndex        =   4
      Top             =   1125
      Width           =   870
   End
   Begin VB.TextBox txtCantidad1 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad1"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   5580
      TabIndex        =   3
      Top             =   1125
      Width           =   870
   End
   Begin VB.TextBox txtItem 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroItem"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
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
      Height          =   360
      Left            =   2250
      TabIndex        =   16
      Top             =   135
      Width           =   645
   End
   Begin VB.TextBox txtCantidad 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2250
      TabIndex        =   1
      Top             =   1110
      Width           =   870
   End
   Begin VB.TextBox txtRevision 
      DataField       =   "Revision"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
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
      Height          =   360
      Left            =   4770
      TabIndex        =   17
      Top             =   120
      Width           =   1545
   End
   Begin VB.TextBox txtPeso 
      Alignment       =   1  'Right Justify
      DataField       =   "Peso"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2250
      TabIndex        =   6
      Top             =   1845
      Width           =   870
   End
   Begin VB.TextBox txtBusca 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
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
      Height          =   360
      Left            =   8550
      TabIndex        =   26
      Top             =   330
      Width           =   1950
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   360
      Index           =   0
      Left            =   270
      TabIndex        =   12
      Top             =   4185
      Width           =   1845
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   360
      Index           =   1
      Left            =   270
      TabIndex        =   13
      Top             =   4635
      Width           =   1845
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   2250
      TabIndex        =   0
      Tag             =   "Articulos"
      Top             =   735
      Width           =   8250
      _ExtentX        =   14552
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   0
      Left            =   3150
      TabIndex        =   2
      Tag             =   "Unidades"
      Top             =   1125
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUnidadPeso"
      Height          =   315
      Index           =   3
      Left            =   3150
      TabIndex        =   7
      Tag             =   "Unidades"
      Top             =   1845
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdControlCalidad"
      Height          =   315
      Index           =   4
      Left            =   2250
      TabIndex        =   9
      Tag             =   "ControlesCalidad"
      Top             =   2595
      Width           =   4740
      _ExtentX        =   8361
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdControlCalidad"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1320
      Left            =   2250
      TabIndex        =   30
      Top             =   3690
      Width           =   8205
      _ExtentX        =   14473
      _ExtentY        =   2328
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmDetAcopios.frx":076A
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaNecesidad"
      Height          =   360
      Index           =   0
      Left            =   5625
      TabIndex        =   15
      Top             =   2925
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   635
      _Version        =   393216
      Enabled         =   0   'False
      Format          =   59113473
      CurrentDate     =   36526
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "Adjunto"
      Height          =   315
      Index           =   5
      Left            =   2250
      TabIndex        =   11
      Tag             =   "SiNo"
      Top             =   3375
      Width           =   780
      _ExtentX        =   1376
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "SiNo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   2
      Left            =   2250
      TabIndex        =   8
      Tag             =   "Cuentas"
      Top             =   2205
      Width           =   8250
      _ExtentX        =   14552
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   1440
      TabIndex        =   34
      Top             =   5310
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
      Height          =   330
      Index           =   1
      Left            =   1440
      TabIndex        =   35
      Top             =   5715
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
      Height          =   330
      Index           =   2
      Left            =   1440
      TabIndex        =   36
      Top             =   6120
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
      Height          =   330
      Index           =   3
      Left            =   1440
      TabIndex        =   37
      Top             =   6525
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
      Height          =   330
      Index           =   4
      Left            =   1440
      TabIndex        =   38
      Top             =   6930
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
      Height          =   330
      Index           =   5
      Left            =   7020
      TabIndex        =   39
      Top             =   5310
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
      Height          =   330
      Index           =   6
      Left            =   7020
      TabIndex        =   40
      Top             =   5715
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
      Height          =   330
      Index           =   7
      Left            =   7020
      TabIndex        =   41
      Top             =   6120
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
      Height          =   330
      Index           =   8
      Left            =   7020
      TabIndex        =   42
      Top             =   6525
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
      Height          =   330
      Index           =   9
      Left            =   7020
      TabIndex        =   43
      Top             =   6930
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdEquipo"
      Height          =   315
      Index           =   6
      Left            =   2250
      TabIndex        =   5
      Tag             =   "Equipos"
      Top             =   1485
      Width           =   4695
      _ExtentX        =   8281
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEquipo"
      Text            =   ""
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Equipo :"
      Height          =   300
      Index           =   6
      Left            =   270
      TabIndex        =   57
      Top             =   1485
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe total del item :"
      Height          =   255
      Index           =   8
      Left            =   7470
      TabIndex        =   56
      Top             =   3360
      Width           =   1635
   End
   Begin VB.Label lblLabels 
      Caption         =   "Precio unitario :"
      Height          =   300
      Index           =   6
      Left            =   270
      TabIndex        =   54
      Top             =   3000
      Width           =   1815
   End
   Begin VB.Line Line1 
      BorderWidth     =   3
      X1              =   0
      X2              =   10755
      Y1              =   5130
      Y2              =   5130
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 1 :"
      Height          =   300
      Index           =   0
      Left            =   90
      TabIndex        =   53
      Top             =   5310
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 2 :"
      Height          =   300
      Index           =   1
      Left            =   90
      TabIndex        =   52
      Top             =   5715
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 3 :"
      Height          =   300
      Index           =   2
      Left            =   90
      TabIndex        =   51
      Top             =   6120
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 4 :"
      Height          =   300
      Index           =   3
      Left            =   90
      TabIndex        =   50
      Top             =   6525
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 5 :"
      Height          =   300
      Index           =   4
      Left            =   90
      TabIndex        =   49
      Top             =   6930
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 6 :"
      Height          =   300
      Index           =   5
      Left            =   5670
      TabIndex        =   48
      Top             =   5355
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 7 :"
      Height          =   300
      Index           =   6
      Left            =   5670
      TabIndex        =   47
      Top             =   5760
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 8 :"
      Height          =   300
      Index           =   7
      Left            =   5670
      TabIndex        =   46
      Top             =   6165
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 9 :"
      Height          =   300
      Index           =   8
      Left            =   5670
      TabIndex        =   45
      Top             =   6570
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 10 :"
      Height          =   300
      Index           =   9
      Left            =   5670
      TabIndex        =   44
      Top             =   6975
      Width           =   1230
   End
   Begin VB.Label lblData 
      Caption         =   "Cuenta contable :"
      Height          =   300
      Index           =   2
      Left            =   270
      TabIndex        =   33
      Top             =   2220
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   1
      Left            =   270
      TabIndex        =   29
      Top             =   3735
      Width           =   1815
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "X"
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
      Index           =   0
      Left            =   6525
      TabIndex        =   28
      Top             =   1170
      Width           =   285
   End
   Begin VB.Label lblLabels 
      Caption         =   "Buscar :"
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
      Index           =   14
      Left            =   8595
      TabIndex        =   27
      Top             =   45
      Width           =   870
   End
   Begin VB.Label lblData 
      Caption         =   "Adjunto ? :"
      Height          =   300
      Index           =   5
      Left            =   270
      TabIndex        =   25
      Top             =   3360
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de necesidad :"
      Height          =   300
      Index           =   0
      Left            =   3870
      TabIndex        =   24
      Top             =   2970
      Width           =   1635
   End
   Begin VB.Label lblData 
      Caption         =   "Control de calidad :"
      Height          =   300
      Index           =   4
      Left            =   270
      TabIndex        =   23
      Top             =   2610
      Width           =   1815
   End
   Begin VB.Label lblData 
      Caption         =   "Peso :"
      Height          =   300
      Index           =   3
      Left            =   270
      TabIndex        =   22
      Top             =   1845
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Revision :"
      Height          =   300
      Index           =   5
      Left            =   3690
      TabIndex        =   21
      Top             =   180
      Width           =   1005
   End
   Begin VB.Label lblData 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   1
      Left            =   270
      TabIndex        =   20
      Top             =   735
      Width           =   1815
   End
   Begin VB.Label lblData 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   0
      Left            =   270
      TabIndex        =   19
      Top             =   1112
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item :"
      Height          =   300
      Index           =   3
      Left            =   270
      TabIndex        =   18
      Top             =   180
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetAcopios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetAcopio
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oAcopio As ComPronto.Acopio
Dim mvarIdUnidadCU As Integer
Dim mvarPathAdjuntos As String
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long
Private pTipoAcceso As Integer

Private Sub cmd_Click(Index As Integer)

   Dim oF As frmAutorizacion2
   Dim mvarOK As Boolean
   Dim i As Integer
   
   Select Case Index
      
      Case 0
      
         Dim dc As DataCombo
         Dim dtp As DTPicker
      
         For Each dtp In DTFields
            If dtp.Enabled Then
               origen.Registro.Fields(dtp.DataField).Value = dtp.Value
            End If
         Next
         
         For Each dc In DataCombo1
            If dc.Enabled Or dc.Index = 0 Then
               If Len(Trim(dc.BoundText)) = 0 Then
                  If Not (dc.Index = 3 Or dc.Index = 4 Or dc.Index = 5 Or dc.Index = 6) Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
               Else
                  origen.Registro.Fields(dc.DataField).Value = dc.BoundText
               End If
            End If
         Next
      
         If IsNull(origen.Registro.Fields("Cantidad").Value) Or origen.Registro.Fields("Cantidad").Value = 0 Then
            MsgBox "Falta ingresar la cantidad (unidades)", vbCritical
            Exit Sub
         End If
         
         If txtCantidad1.Visible Then
            If IsNull(origen.Registro.Fields("Cantidad1").Value) Or origen.Registro.Fields("Cantidad1").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 1)", vbCritical
               Exit Sub
            End If
         End If
         
         If txtCantidad2.Visible Then
            If IsNull(origen.Registro.Fields("Cantidad2").Value) Or origen.Registro.Fields("Cantidad2").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 2)", vbCritical
               Exit Sub
            End If
         End If
         
'         If DTFields(0).Value < oAcopio.Registro.Fields("Fecha").Value Then
'            MsgBox "La fecha de necesidad no puede ser inferior a la fecha de la lista de acopio", vbExclamation
'            Exit Sub
'         End If
         
         With origen.Registro
            For i = 0 To 9
               .Fields("ArchivoAdjunto" & i + 1).Value = FileBrowser1(i).Text
            Next
            If Len(rchObservaciones.Text) > 1 Then
               Do While Asc(Right(rchObservaciones.Text, 1)) = 13 Or Asc(Right(rchObservaciones.Text, 1)) = 10
                  If Len(rchObservaciones.Text) = 1 Then
                     rchObservaciones.Text = ""
                     Exit Do
                  Else
                     rchObservaciones.Text = mId(rchObservaciones.Text, 1, Len(rchObservaciones.Text) - 1)
                  End If
               Loop
               .Fields("Observaciones").Value = rchObservaciones.Text
            End If
         End With
         
         origen.Modificado = True
         Aceptado = True
   
         Me.Hide

      Case 1
      
         If mvarId = -1 Then
            origen.Eliminado = True
         End If
   
         Me.Hide
         
      Case 2
      
         Set oF = New frmAutorizacion2
         With oF
            .Sector = "Control de Calidad"
            .Show vbModal, Me
         End With
         mvarOK = oF.Ok
         Unload oF
         Set oF = Nothing
         If Not mvarOK Then
            MsgBox "Solo personal de Control de Calidad puede asignar los controles", vbExclamation
            Exit Sub
         End If
         DataCombo1(4).Enabled = True
         
      Case 3
      
         Set oF = New frmAutorizacion2
         With oF
            .Sector = "Planeamiento"
            .Show vbModal, Me
         End With
         mvarOK = oF.Ok
         Unload oF
         Set oF = Nothing
         If Not mvarOK Then
            MsgBox "Solo personal de PLANEAMIENTO puede asignar fechas de necesidad", vbExclamation
            Exit Sub
         End If
         DTFields(0).Enabled = True
         
   End Select

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim dtp As DTPicker
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim i As Integer
   Dim mNum As Long
   Dim oPar As ComPronto.Parametro

   Set oAp = Aplicacion
   mvarId = vNewValue
   Set origen = oAcopio.DetAcopios.Item(vNewValue)
   Me.IdNuevo = origen.Id
   Set oBind = New BindingCollection
   
   Set oPar = oAp.Parametros.Item(1)
   With oPar.Registro
      mvarIdUnidadCU = .Fields("IdUnidadPorUnidad").Value
      mvarPathAdjuntos = .Fields("PathAdjuntos").Value
   End With
   Set oPar = Nothing
   
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
               If oControl.Tag = "Equipos" Then
                  Set oControl.RowSource = oAp.Obras.TraerFiltrado("Equipos", oAcopio.Registro.Fields("IdObra").Value)
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
         .Fields("Revision").Value = 0
         .Fields("Adjunto").Value = "NO"
         If mvarId = -1 Then
            .Fields("NumeroItem").Value = oAcopio.DetAcopios.UltimoItemDetalle
         End If
      End With
   Else
      With origen.Registro
         For i = 0 To 9
            FileBrowser1(i).Text = .Fields("ArchivoAdjunto" & i + 1).Value
         Next
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
   End If
   
   If pTipoAcceso = EnumAccesos.Alto Then
      DTFields(0).Enabled = True
   End If
   
   If mvarId = -1 Then
      For Each dtp In DTFields
         If dtp.Enabled Then
            dtp.Value = Date
         End If
      Next
      Set oPar = oAp.Parametros.Item(1)
      With oPar.Registro
         origen.Registro.Fields("IdUnidadPeso").Value = .Fields("IdUnidadPorKilo").Value
      End With
      Set oPar = Nothing
   Else
      CalculaTotalItem
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   MuestraAdjuntos
   
   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then
      DataCombo1(0).Enabled = False
   End If
   
End Property

Public Property Get Acopio() As ComPronto.Acopio

   Set Acopio = oAcopio

End Property

Public Property Set Acopio(ByVal vNewValue As ComPronto.Acopio)

   Set oAcopio = vNewValue

End Property

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

Private Sub DataCombo1_GotFocus(Index As Integer)

   If mvarId = -1 Then SendKeys "%{DOWN}"

End Sub

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
   End If
   
   Select Case Index
      
      Case 1
      
         If IsNumeric(DataCombo1(Index).BoundText) Then
         
            Dim oRs As ADOR.Recordset
            Dim oArt As ComPronto.Articulo
            
            Me.MousePointer = vbHourglass
            
            Set oArt = Aplicacion.Articulos.Item(DataCombo1(1).BoundText)
            Set oRs = oArt.Registro
         
            If oRs.RecordCount > 0 Then
               
               With origen.Registro
                  If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                     .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                  Else
                     .Fields("IdUnidad").Value = mvarIdUnidadCU
                  End If
                  If mvarId = -1 Then
                     If IsNull(.Fields("Observaciones").Value) Then
                        .Fields("Observaciones").Value = oArt.CadenaSubitems
                     Else
                        .Fields("Observaciones").Value = .Fields("Observaciones").Value & vbCrLf & oArt.CadenaSubitems
                     End If
                  End If
               End With
               
               If Not IsNull(oRs.Fields("IdCuantificacion").Value) Then
                  If Not IsNull(oRs.Fields("Unidad11").Value) Then
                     txtUnidad.Text = Aplicacion.Unidades.Item(oRs.Fields("Unidad11").Value).Registro.Fields("Descripcion").Value
                  End If
                  Select Case oRs.Fields("IdCuantificacion").Value
                     Case 1
                        txtCantidad1.Visible = False
                        txtCantidad2.Visible = False
                        Label1(0).Visible = False
                        txtUnidad.Visible = False
                        With origen.Registro
                           .Fields("Cantidad1").Value = Null
                           .Fields("Cantidad2").Value = Null
                        End With
                     Case 2
                        txtCantidad1.Visible = True
                        txtCantidad2.Visible = False
                        Label1(0).Visible = False
                        txtUnidad.Visible = True
                        With origen.Registro
                           .Fields("Cantidad2").Value = Null
                           If mvarId = -1 Then
                              .Fields("Cantidad1").Value = oRs.Fields("Largo").Value
                           End If
                        End With
                     Case 3
                        If mvarId = -1 Then
                           txtCantidad1.Visible = True
                           txtCantidad2.Visible = True
                           Label1(0).Visible = True
                           txtUnidad.Visible = True
                           With origen.Registro
                              .Fields("Cantidad1").Value = oRs.Fields("Ancho").Value
                              .Fields("Cantidad2").Value = oRs.Fields("Largo").Value
                           End With
                        End If
                  End Select
               End If
            
               If Not IsNull(oRs.Fields("IdCuenta").Value) And mvarId = -1 Then
                  origen.Registro.Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
               End If
               
               'Determinar si va y calcular el peso
               txtPeso.Enabled = True
               If Not IsNull(oRs.Fields("Peso").Value) Then
                  If Not IsNull(oRs.Fields("Unidad6").Value) Then
                     origen.Registro.Fields("IdUnidadPeso").Value = oRs.Fields("Unidad6").Value
                  End If
               Else
                  origen.Registro.Fields("Peso").Value = Null
'                     .Fields("IdUnidadPeso").Value = mvarIdUnidadCU
'                  If Not IsNull(oRs.Fields("Densidad").Value) Then
                     txtPeso.Enabled = False
'                  End If
               End If
            End If
            
            oRs.Close
            Set oRs = Nothing
            Set oArt = Nothing
            
            Me.MousePointer = vbDefault
            
         End If
            
      Case 5
   
         origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
         MuestraAdjuntos
      
   End Select
      
End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DataCombo1_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Index = 1 Then
      If Button = vbRightButton Then
         If glbMenuPopUpCargado Then
            Dim cursorpos As POINTAPI
            GetCursorPos cursorpos
            TrackPopupMenu POP_hMenu, TPM_HORNEGANIMATION, cursorpos.X, cursorpos.Y, 0, Me.hwnd, ByVal 0&
            DoEvents
            If POP_Key > 0 Then
               DataCombo1(1).BoundText = POP_Key
            End If
         Else
            MsgBox "No se ha cargado el menu de materiales", vbInformation
         End If
      End If
   End If

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub DTFields_Validate(Index As Integer, Cancel As Boolean)

   If Index = 0 Then
      If Not IsNull(oAcopio.Registro.Fields("Fecha").Value) Then
         If DTFields(Index).Value < oAcopio.Registro.Fields("Fecha").Value Then
            DoEvents
            MsgBox "La fecha de necesidad no puede ser anterior" & vbCrLf & "a la fecha de la lista de acopio", vbExclamation
            Cancel = True
            DTFields(Index).Enabled = False
         End If
      End If
   End If

End Sub

Private Sub Form_Activate()

   If mvarId < 0 And Not txtRevision.Enabled Then
      txtRevision.Enabled = False
   End If
   
   If mvarId <> -1 Then
      Dim oRs As ADOR.Recordset
      txtItem.Enabled = False
      Set oRs = Aplicacion.Articulos.Item(origen.Registro.Fields("IdArticulo").Value).Registro
      If oRs.RecordCount > 0 Then
         If Not IsNull(oRs.Fields("IdCuantificacion").Value) Then
            If Not IsNull(oRs.Fields("Unidad11").Value) Then
               txtUnidad.Text = Aplicacion.Unidades.Item(oRs.Fields("Unidad11").Value).Registro.Fields("Descripcion").Value
            End If
            Select Case oRs.Fields("IdCuantificacion").Value
               Case 1
                  txtCantidad1.Visible = False
                  txtCantidad2.Visible = False
                  Label1(0).Visible = False
                  txtUnidad.Visible = False
               Case 2
                  txtCantidad2.Visible = False
                  Label1(0).Visible = False
            End Select
         End If
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

Private Sub Form_Load()

   DisableCloseButton Me
   If glbMenuPopUpCargado Then ActivarPopUp Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oAcopio = Nothing
   Set oBind = Nothing
   Set origen = Nothing
   
   If glbMenuPopUpCargado Then DesactivarPopUp Me
   
End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub txtCantidad_LostFocus()

   If txtPeso.Enabled Then
'And Val(txtPeso.Text) = 0 Then
      If IsNumeric(DataCombo1(1).BoundText) Then
         If txtCantidad1.Visible And txtCantidad2.Visible Then
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text), Val(txtCantidad1.Text), Val(txtCantidad2.Text))
         ElseIf txtCantidad1.Visible Then
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text), Val(txtCantidad1.Text))
         Else
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text))
         End If
      End If
   End If

   CalculaTotalItem

End Sub

Private Sub txtCantidad_GotFocus()
   
   With txtCantidad
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCantidad1_GotFocus()

   With txtCantidad1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCantidad1_LostFocus()

   If txtPeso.Enabled Then
'And Val(txtPeso.Text) = 0 Then
      If IsNumeric(DataCombo1(1).BoundText) Then
         If txtCantidad1.Visible And txtCantidad2.Visible Then
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text), Val(txtCantidad1.Text), Val(txtCantidad2.Text))
         ElseIf txtCantidad1.Visible Then
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text), Val(txtCantidad1.Text))
         Else
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text))
         End If
      End If
   End If

End Sub

Private Sub txtCantidad2_GotFocus()

   With txtCantidad2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCantidad2_LostFocus()

   If txtPeso.Enabled Then
'And Val(txtPeso.Text) = 0 Then
      If IsNumeric(DataCombo1(1).BoundText) Then
         If txtCantidad1.Visible And txtCantidad2.Visible Then
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text), Val(txtCantidad1.Text), Val(txtCantidad2.Text))
         ElseIf txtCantidad1.Visible Then
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text), Val(txtCantidad1.Text))
         Else
            origen.Registro.Fields("Peso").Value = CalcularPeso(DataCombo1(1).BoundText, Val(txtCantidad.Text))
         End If
      End If
   End If

End Sub

Private Sub txtItem_GotFocus()
   
   With txtItem
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtItem_Validate(Cancel As Boolean)

   If Len(Trim(txtItem)) <> 0 And mvarId = -1 Then
      If oAcopio.DetAcopios.ItemExistente(txtItem.Text) Then
         MsgBox "El item ya existe en la lista de acopio, ingrese otro numero.", vbCritical
         Cancel = True
      End If
   End If

End Sub

Private Sub txtItem_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPeso_GotFocus()

   With txtPeso
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPeso_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPrecio_GotFocus()

   With txtPrecio
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPrecio_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPrecio_LostFocus()

   CalculaTotalItem

End Sub

Private Sub txtRevision_GotFocus()

   With txtRevision
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtRevision_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtBusca_GotFocus()

   With txtBusca
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBusca_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      If KeyAscii = 13 Then
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set DataCombo1(1).RowSource = Aplicacion.Articulos.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set DataCombo1(1).RowSource = Aplicacion.Articulos.TraerLista
         End If
      End If
      DataCombo1(1).SetFocus
      SendKeys "%{DOWN}"
   End If

End Sub

Public Property Let TipoAcceso(ByVal vNewValue As Variant)

   pTipoAcceso = vNewValue

End Property

Private Sub MuestraAdjuntos()

   Dim i As Integer
   
   If IsNull(origen.Registro.Fields("Adjunto").Value) Or origen.Registro.Fields("Adjunto").Value = "NO" Then
      For i = 0 To 9
         lblAdjuntos(i).Visible = False
         FileBrowser1(i).Visible = False
         FileBrowser1(i).Text = ""
      Next
      Line1.Visible = False
      Me.Height = 5500
   Else
      For i = 0 To 9
         lblAdjuntos(i).Visible = True
         FileBrowser1(i).Visible = True
         If Len(Trim(FileBrowser1(i).Text)) = 0 Then
            FileBrowser1(i).Text = mvarPathAdjuntos
            FileBrowser1(i).InitDir = mvarPathAdjuntos
         End If
      Next
      Line1.Visible = True
      Me.Height = 8000
   End If
      
End Sub

Private Sub CalculaTotalItem()

   With origen.Registro
      If Not IsNull(.Fields("Precio").Value) And Not IsNull(.Fields("Cantidad").Value) Then
         txtImporteTotal.Text = .Fields("Precio").Value * .Fields("Cantidad").Value
      Else
         txtImporteTotal.Text = 0
      End If
   End With
   
End Sub

'Public Sub miMSG(ByVal uMSG As Long, ByVal wParam As Long, ByVal lParam As Long)
'
'   If uMSG = WM_MENUSELECT Then
'      mClave = CLng(wParam And &HFFFF&)
'      If mClave <= 0 Then
'         Exit Sub
'      End If
'      DataCombo1(1).BoundText = mClave
'   End If
'
'End Sub

