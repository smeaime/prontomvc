VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{126E538A-EE41-4B22-A045-F8D5538F5D2B}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmDetOtrosIngresosAlmacenSAT 
   Caption         =   "Item de otros ingresos a almacen en PRONTO SAT"
   ClientHeight    =   7260
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10770
   LinkTopic       =   "Form1"
   ScaleHeight     =   7260
   ScaleWidth      =   10770
   StartUpPosition =   3  'Windows Default
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
      Left            =   7650
      TabIndex        =   7
      Top             =   1590
      Width           =   2985
   End
   Begin VB.TextBox txtCantidad2 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad2"
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
      Left            =   6705
      TabIndex        =   6
      Top             =   1590
      Width           =   870
   End
   Begin VB.TextBox txtCantidad1 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad1"
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
      Left            =   5400
      TabIndex        =   5
      Top             =   1590
      Width           =   870
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   405
      Index           =   0
      Left            =   180
      TabIndex        =   4
      Top             =   4320
      Width           =   1485
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
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   2070
      TabIndex        =   3
      Top             =   1590
      Width           =   870
   End
   Begin VB.TextBox txtPartida 
      Alignment       =   1  'Right Justify
      DataField       =   "Partida"
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
      Left            =   2070
      TabIndex        =   2
      Top             =   1200
      Width           =   1185
   End
   Begin VB.TextBox txtCodigoArticulo 
      Alignment       =   2  'Center
      DataField       =   "CodigoArticulo"
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
      Height          =   315
      Left            =   2070
      TabIndex        =   1
      Top             =   390
      Width           =   1545
   End
   Begin VB.TextBox txtCostoUnitario 
      Alignment       =   1  'Right Justify
      DataField       =   "CostoUnitario"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   2070
      TabIndex        =   0
      Top             =   2415
      Visible         =   0   'False
      Width           =   870
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   2070
      TabIndex        =   8
      Tag             =   "Articulos"
      Top             =   795
      Width           =   8610
      _ExtentX        =   15187
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   0
      Left            =   2970
      TabIndex        =   9
      Tag             =   "Unidades"
      Top             =   1590
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   1395
      TabIndex        =   10
      Top             =   5175
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
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1365
      Left            =   2070
      TabIndex        =   11
      Top             =   2820
      Width           =   8565
      _ExtentX        =   15108
      _ExtentY        =   2408
      _Version        =   393217
      Enabled         =   0   'False
      ScrollBars      =   2
      TextRTF         =   $"frmDetOtrosIngresosAlmacenSAT.frx":0000
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   1
      Left            =   1395
      TabIndex        =   12
      Top             =   5580
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
      Left            =   1395
      TabIndex        =   13
      Top             =   5985
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
      Left            =   1395
      TabIndex        =   14
      Top             =   6390
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
      Left            =   1395
      TabIndex        =   15
      Top             =   6795
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
      Left            =   6975
      TabIndex        =   16
      Top             =   5175
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
      Left            =   6975
      TabIndex        =   17
      Top             =   5580
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
      Left            =   6975
      TabIndex        =   18
      Top             =   5985
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
      Left            =   6975
      TabIndex        =   19
      Top             =   6390
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
      Left            =   6975
      TabIndex        =   20
      Top             =   6795
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
      DataField       =   "Adjunto"
      Height          =   315
      Index           =   5
      Left            =   2070
      TabIndex        =   21
      Tag             =   "SiNo"
      Top             =   2010
      Width           =   780
      _ExtentX        =   1376
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "SiNo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUbicacion"
      Height          =   315
      Index           =   2
      Left            =   4365
      TabIndex        =   22
      Tag             =   "Ubicaciones"
      Top             =   1200
      Width           =   3885
      _ExtentX        =   6853
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdUbicacion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   3
      Left            =   8955
      TabIndex        =   23
      Tag             =   "Obras"
      Top             =   1200
      Width           =   1725
      _ExtentX        =   3043
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   3
      Left            =   3870
      TabIndex        =   24
      Tag             =   "Monedas"
      Top             =   2415
      Visible         =   0   'False
      Width           =   1365
      _ExtentX        =   2408
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdControlCalidad"
      Height          =   315
      Index           =   4
      Left            =   6165
      TabIndex        =   25
      Tag             =   "ControlesCalidad"
      Top             =   2010
      Visible         =   0   'False
      Width           =   4515
      _ExtentX        =   7964
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdControlCalidad"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Adjuntos ? :"
      Height          =   300
      Index           =   12
      Left            =   135
      TabIndex        =   47
      Top             =   2010
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   5
      Left            =   135
      TabIndex        =   46
      Top             =   2865
      Width           =   1815
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   3
      X1              =   0
      X2              =   10755
      Y1              =   4905
      Y2              =   4905
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 1 :"
      Height          =   300
      Index           =   0
      Left            =   45
      TabIndex        =   45
      Top             =   5175
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 2 :"
      Height          =   300
      Index           =   1
      Left            =   45
      TabIndex        =   44
      Top             =   5580
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 3 :"
      Height          =   300
      Index           =   2
      Left            =   45
      TabIndex        =   43
      Top             =   5985
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 4 :"
      Height          =   300
      Index           =   3
      Left            =   45
      TabIndex        =   42
      Top             =   6390
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 5 :"
      Height          =   300
      Index           =   4
      Left            =   45
      TabIndex        =   41
      Top             =   6795
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 6 :"
      Height          =   300
      Index           =   5
      Left            =   5625
      TabIndex        =   40
      Top             =   5220
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 7 :"
      Height          =   300
      Index           =   6
      Left            =   5625
      TabIndex        =   39
      Top             =   5625
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 8 :"
      Height          =   300
      Index           =   7
      Left            =   5625
      TabIndex        =   38
      Top             =   6030
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 9 :"
      Height          =   300
      Index           =   8
      Left            =   5625
      TabIndex        =   37
      Top             =   6435
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 10 :"
      Height          =   300
      Index           =   9
      Left            =   5625
      TabIndex        =   36
      Top             =   6840
      Width           =   1230
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
      Left            =   6345
      TabIndex        =   35
      Top             =   1635
      Width           =   285
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   2
      Left            =   135
      TabIndex        =   34
      Top             =   795
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   135
      TabIndex        =   33
      Top             =   1605
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Partida :"
      Height          =   300
      Index           =   0
      Left            =   135
      TabIndex        =   32
      Top             =   1200
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obra :"
      Height          =   255
      Index           =   15
      Left            =   8370
      TabIndex        =   31
      Top             =   1245
      Width           =   510
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ubicacion :"
      Height          =   255
      Index           =   16
      Left            =   3375
      TabIndex        =   30
      Top             =   1245
      Width           =   915
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de articulo :"
      Height          =   300
      Index           =   4
      Left            =   135
      TabIndex        =   29
      Top             =   390
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Moneda :"
      Height          =   240
      Index           =   19
      Left            =   3060
      TabIndex        =   28
      Top             =   2460
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Label lblLabels 
      Caption         =   "Costo unitario :"
      Height          =   300
      Index           =   18
      Left            =   135
      TabIndex        =   27
      Top             =   2430
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblData 
      Caption         =   "Control de calidad :"
      Height          =   255
      Index           =   4
      Left            =   4590
      TabIndex        =   26
      Top             =   2040
      Visible         =   0   'False
      Width           =   1455
   End
End
Attribute VB_Name = "frmDetOtrosIngresosAlmacenSAT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetOtroIngresoAlmacenSAT
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oOtroIngresoAlmacen As ComPronto.OtroIngresoAlmacenSAT
Private mvarIdUnidad As Integer, mTipoIngreso As Integer, mvarIdUnidadCU As Integer
Private mvarCantidadUnidades As Double
Public mvarCantidadAdicional As Double
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mvarIdControlCalidadStandar As Long
Private mClave As Long
Private mvarPathAdjuntos As String

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Me.Hide
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim dtp As DTPicker
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim i As Integer, mvarIdMonedaPesos As Integer
   Dim mLimitarUbicaciones As Boolean

   Set oAp = Aplicacion
   mvarId = vNewValue
   Set origen = oOtroIngresoAlmacen.DetOtrosIngresosAlmacenSAT.Item(vNewValue)
   Me.IdNuevo = origen.Id
   Set oBind = New BindingCollection
   
   Set oPar = oAp.Parametros.Item(1)
   With oPar.Registro
      mvarIdUnidadCU = .Fields("IdUnidadPorUnidad").Value
      mvarIdMonedaPesos = .Fields("IdMoneda").Value
      mvarPathAdjuntos = .Fields("PathAdjuntos").Value
      mvarIdControlCalidadStandar = IIf(IsNull(.Fields("IdControlCalidadStandar").Value), 0, .Fields("IdControlCalidadStandar").Value)
   End With
   Set oPar = Nothing
   
   mvarIdUnidad = mvarIdUnidadCU
   mvarCantidadAdicional = 0
   
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
               If oControl.Tag = "Ubicaciones" And mLimitarUbicaciones And _
                     glbIdObraAsignadaUsuario > 0 Then
                  Set oControl.RowSource = oAp.Ubicaciones.TraerFiltrado("_PorObra", glbIdObraAsignadaUsuario)
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            'Set oControl.DataSource = origen
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   If mvarId = -1 Then
   Else
      With origen.Registro
         For i = 0 To 9
            FileBrowser1(i).Text = .Fields("ArchivoAdjunto" & i + 1).Value
         Next
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
   End If

   Set oRs = Nothing
   Set oAp = Nothing
   
   MuestraAdjuntos
   
End Property

Public Property Get OtroIngresoAlmacenSAT() As ComPronto.OtroIngresoAlmacenSAT

   Set OtroIngresoAlmacenSAT = oOtroIngresoAlmacen

End Property

Public Property Set OtroIngresoAlmacenSAT(ByVal vNewValue As ComPronto.OtroIngresoAlmacenSAT)

   Set oOtroIngresoAlmacen = vNewValue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   Dim oRs As ADOR.Recordset
            
   Select Case Index
      
      Case 1
         If IsNumeric(DataCombo1(Index).BoundText) Then
            Set oRs = Aplicacion.Articulos.Item(DataCombo1(1).BoundText).Registro
            With origen.Registro
                If oRs.RecordCount > 0 Then
                  If IsNull(.Fields("IdUbicacion").Value) Then
                     .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacionStandar").Value
                  End If
                  If (IsNull(.Fields("IdArticulo").Value) Or _
                         .Fields("IdArticulo").Value <> DataCombo1(1).BoundText) Then
                     If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                        .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     Else
                        .Fields("IdUnidad").Value = mvarIdUnidadCU
                     End If
                  End If
                  If Not IsNull(oRs.Fields("IdCuantificacion").Value) Then
                     If Not IsNull(oRs.Fields("Unidad11").Value) Then
                        txtUnidad.Text = Aplicacion.Unidades.Item(oRs.Fields("Unidad11").Value).Registro.Fields("Descripcion").Value
                        mvarIdUnidad = oRs.Fields("Unidad11").Value
                     End If
                     Select Case oRs.Fields("IdCuantificacion").Value
                        Case 1
                           txtCantidad1.Visible = False
                           txtCantidad2.Visible = False
                           Label1(0).Visible = False
                           txtUnidad.Visible = False
                        Case 2
                           txtCantidad1.Visible = True
                           txtCantidad2.Visible = False
                           Label1(0).Visible = False
                           txtUnidad.Visible = True
                           If mvarId = -1 Then
                              .Fields("Cantidad1").Value = oRs.Fields("Largo").Value
                           End If
                        Case 3
                           If mvarId = -1 Then
                              txtCantidad1.Visible = True
                              txtCantidad2.Visible = True
                              Label1(0).Visible = True
                              txtUnidad.Visible = True
                              .Fields("Cantidad1").Value = oRs.Fields("Ancho").Value
                              .Fields("Cantidad2").Value = oRs.Fields("Largo").Value
                           End If
                     End Select
                  End If
                  txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
                  If Me.Visible Then
                     If Not IsNull(oRs.Fields("IdUbicacionStandar").Value) Then
                        .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacionStandar").Value
                     End If
                     If Not IsNull(oRs.Fields("IdControlCalidad").Value) Then
                        .Fields("IdControlCalidad").Value = oRs.Fields("IdControlCalidad").Value
                     Else
                        .Fields("IdControlCalidad").Value = mvarIdControlCalidadStandar
                     End If
                  End If
               End If
            End With
            oRs.Close
            origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
         End If
         
   Case 5
      origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
      MuestraAdjuntos
   
   End Select
      
   Set oRs = Nothing

End Sub

Private Sub FileBrowser1_Change(Index As Integer)

   If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
      FileBrowser1(Index).InitDir = FileBrowser1(Index).Text
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

   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oBind = Nothing
   Set origen = Nothing
   Set oOtroIngresoAlmacen = Nothing

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Public Property Let TipoIngreso(ByVal vNewValue As Integer)

   mTipoIngreso = vNewValue

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
