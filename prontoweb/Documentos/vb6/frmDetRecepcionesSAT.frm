VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetRecepcionesSAT 
   Caption         =   "Item de recepcion de materiales PRONTO SAT"
   ClientHeight    =   4680
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9405
   LinkTopic       =   "Form1"
   ScaleHeight     =   4680
   ScaleWidth      =   9405
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtCotizacionDolar 
      Alignment       =   1  'Right Justify
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
      Height          =   300
      Left            =   8730
      TabIndex        =   41
      Top             =   3060
      Width           =   645
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   405
      Index           =   0
      Left            =   90
      TabIndex        =   13
      Top             =   4140
      Width           =   1845
   End
   Begin VB.TextBox txtCantidad2 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad2"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   1
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   6390
      TabIndex        =   12
      Top             =   1680
      Width           =   870
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
      TabIndex        =   11
      Top             =   1680
      Width           =   870
   End
   Begin VB.TextBox txtCantidad1 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad1"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   1
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   5085
      TabIndex        =   10
      Top             =   1680
      Width           =   870
   End
   Begin VB.TextBox txtNumeroPedido 
      Alignment       =   1  'Right Justify
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
      Left            =   2070
      Locked          =   -1  'True
      TabIndex        =   9
      Top             =   135
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.TextBox txtNumeroItemPedido 
      Alignment       =   1  'Right Justify
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
      Left            =   5220
      Locked          =   -1  'True
      TabIndex        =   8
      Top             =   135
      Visible         =   0   'False
      Width           =   690
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
      Left            =   7290
      TabIndex        =   7
      Top             =   1680
      Width           =   2085
   End
   Begin VB.TextBox txtPartida 
      Alignment       =   1  'Right Justify
      DataField       =   "Partida"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   1
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   2070
      TabIndex        =   6
      Top             =   2025
      Width           =   1635
   End
   Begin VB.TextBox txtNumeroItemRequerimiento 
      Alignment       =   1  'Right Justify
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
      Left            =   5220
      Locked          =   -1  'True
      TabIndex        =   5
      Top             =   495
      Visible         =   0   'False
      Width           =   690
   End
   Begin VB.TextBox txtNumeroRequerimiento 
      Alignment       =   1  'Right Justify
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
      Left            =   2070
      Locked          =   -1  'True
      TabIndex        =   4
      Top             =   510
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.TextBox txtTrasabilidad 
      DataField       =   "Trasabilidad"
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
      Height          =   270
      Left            =   7740
      TabIndex        =   3
      Top             =   2040
      Width           =   1635
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
      TabIndex        =   2
      Top             =   945
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
      TabIndex        =   1
      Top             =   3060
      Width           =   870
   End
   Begin VB.TextBox txtCotizacionMoneda 
      Alignment       =   1  'Right Justify
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
      Height          =   300
      Left            =   6615
      TabIndex        =   0
      Top             =   3060
      Width           =   690
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   2070
      TabIndex        =   14
      Tag             =   "Articulos"
      Top             =   1305
      Width           =   7305
      _ExtentX        =   12885
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
      TabIndex        =   15
      Tag             =   "Unidades"
      Top             =   1680
      Width           =   2040
      _ExtentX        =   3598
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdControlCalidad"
      Height          =   315
      Index           =   4
      Left            =   2070
      TabIndex        =   16
      Tag             =   "ControlesCalidad"
      Top             =   2355
      Width           =   4425
      _ExtentX        =   7805
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdControlCalidad"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1140
      Left            =   2070
      TabIndex        =   17
      Top             =   3420
      Width           =   7305
      _ExtentX        =   12885
      _ExtentY        =   2011
      _Version        =   393217
      Enabled         =   0   'False
      ScrollBars      =   2
      TextRTF         =   $"frmDetRecepcionesSAT.frx":0000
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUbicacion"
      Height          =   315
      Index           =   2
      Left            =   2070
      TabIndex        =   18
      Tag             =   "Ubicaciones"
      Top             =   2700
      Width           =   4425
      _ExtentX        =   7805
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
      Left            =   7515
      TabIndex        =   19
      Tag             =   "Obras"
      Top             =   2340
      Width           =   1860
      _ExtentX        =   3281
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
      TabIndex        =   20
      Tag             =   "Monedas"
      Top             =   3060
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdDetalleObraDestino"
      Height          =   315
      Index           =   5
      Left            =   7515
      TabIndex        =   21
      Tag             =   "ObraDestinos"
      Top             =   2700
      Width           =   1860
      _ExtentX        =   3281
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdDetalleObraDestino"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Control de calidad :"
      Height          =   300
      Index           =   11
      Left            =   90
      TabIndex        =   40
      Top             =   2355
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   255
      Index           =   2
      Left            =   90
      TabIndex        =   39
      Top             =   1350
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   255
      Index           =   7
      Left            =   90
      TabIndex        =   38
      Top             =   1695
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
      Left            =   6030
      TabIndex        =   37
      Top             =   1725
      Width           =   285
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de pedido :"
      Height          =   345
      Index           =   0
      Left            =   90
      TabIndex        =   36
      Top             =   150
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item de ped. :"
      Height          =   345
      Index           =   4
      Left            =   4005
      TabIndex        =   35
      Top             =   150
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Partida :"
      Height          =   255
      Index           =   1
      Left            =   90
      TabIndex        =   34
      Top             =   2055
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item de RM :"
      Height          =   345
      Index           =   3
      Left            =   4005
      TabIndex        =   33
      Top             =   510
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de RM :"
      Height          =   345
      Index           =   5
      Left            =   90
      TabIndex        =   32
      Top             =   510
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   6
      Left            =   90
      TabIndex        =   31
      Top             =   3465
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Trasabilidad :"
      Height          =   255
      Index           =   10
      Left            =   6435
      TabIndex        =   30
      Top             =   2070
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obra :"
      Height          =   255
      Index           =   15
      Left            =   6570
      TabIndex        =   29
      Top             =   2385
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ubicacion :"
      Height          =   255
      Index           =   16
      Left            =   90
      TabIndex        =   28
      Top             =   2745
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de articulo :"
      Height          =   300
      Index           =   17
      Left            =   90
      TabIndex        =   27
      Top             =   945
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Costo unitario :"
      Height          =   300
      Index           =   18
      Left            =   90
      TabIndex        =   26
      Top             =   3075
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Moneda :"
      Height          =   240
      Index           =   19
      Left            =   3060
      TabIndex        =   25
      Top             =   3105
      Width           =   735
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cotizacion dolar :"
      Height          =   240
      Index           =   20
      Left            =   7380
      TabIndex        =   24
      Top             =   3105
      Width           =   1260
   End
   Begin VB.Label lblLabels 
      Caption         =   "Conversion a Pesos :"
      Height          =   240
      Index           =   21
      Left            =   5040
      TabIndex        =   23
      Top             =   3105
      Width           =   1530
   End
   Begin VB.Label lblLabels 
      Caption         =   "Destino :"
      Height          =   255
      Index           =   22
      Left            =   6570
      TabIndex        =   22
      Top             =   2745
      Width           =   870
   End
End
Attribute VB_Name = "frmDetRecepcionesSAT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetRecepcionSAT
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oRecepcion As ComPronto.RecepcionSAT
Private mvarIdUnidadCU As Integer
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long, mvarIdMonedaPesos As Long
Private mvarIdMonedaDolar As Long, mvarIdControlCalidadStandar As Long
Private mvarCantidadAdicional As Double, mvarCantidadUnidades As Double
Private mvarMostrarCosto As String

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Me.Hide
   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   Dim mIdReq As Long, mIdPed As Long, mIdAco As Long
   Dim mLimitarUbicaciones As Boolean

   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   
   Set origen = oRecepcion.DetRecepcionesSAT.Item(vnewvalue)
   Me.IdNuevo = origen.Id
   
   Set oPar = oAp.Parametros.Item(1)
   With oPar.Registro
      mvarIdUnidadCU = .Fields("IdUnidadPorUnidad").Value
      mvarIdMonedaPesos = .Fields("IdMoneda").Value
      mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
      mvarIdControlCalidadStandar = IIf(IsNull(.Fields("IdControlCalidadStandar").Value), 0, .Fields("IdControlCalidadStandar").Value)
   End With
   Set oPar = Nothing
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DTPicker Then
            If Len(oControl.DataField) Then .Add oControl, "Value", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "DefExe1" Then
                  If Not IsNull(RecepcionSAT.Registro.Fields("IdEquipo").Value) Then
                     Set oControl.RowSource = oAp.Equipos.TraerFiltrado("Planos", RecepcionSAT.Registro.Fields("IdEquipo").Value)
                  End If
               ElseIf oControl.Tag = "Obras" Then
                  Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo")
               ElseIf oControl.Tag = "ObraDestinos" Then
'                  If Not IsNull(origen.Registro.Fields("IdObra").Value) Then
'                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_DestinosParaComboPorIdObra", _
'                                                origen.Registro.Fields("IdObra").Value)
'                  End If
               ElseIf oControl.Tag = "Ubicaciones" And mLimitarUbicaciones And _
                     glbIdObraAsignadaUsuario > 0 Then
                  Set oControl.RowSource = oAp.Ubicaciones.TraerFiltrado("_PorObra", glbIdObraAsignadaUsuario)
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      
         If mvarId > 0 And Not glbAdministrador And _
               (TypeOf oControl Is DataCombo Or TypeOf oControl Is TextBox) Then
            oControl.Locked = True
         End If
      Next
   End With
   
   mIdReq = -1
   mIdPed = -1
   mIdAco = -1
   
   If mvarId = -1 Then
   Else
      With origen.Registro
         txtCotizacionDolar.Text = IIf(IsNull(.Fields("CotizacionDolar").Value), 0, .Fields("CotizacionDolar").Value)
         txtCotizacionMoneda.Text = IIf(IsNull(.Fields("CotizacionMoneda").Value), 1, .Fields("CotizacionMoneda").Value)
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
   End If
   
   With origen.Registro
      If IsNull(.Fields("IdControlCalidad").Value) Then
         .Fields("IdControlCalidad").Value = mvarIdControlCalidadStandar
      End If
      If Not IsNull(.Fields("IdDetallePedido").Value) Then
         mIdPed = .Fields("IdDetallePedido").Value
'         Set oRs = oAp.PedidosSAT.TraerFiltrado("_DatosPorIdDetalle", .Fields("IdDetallePedido").Value)
'         If oRs.RecordCount > 0 Then
'            If Not IsNull(oRs.Fields("NumeroPedido").Value) Then
'               txtNumeroPedido.Text = oRs.Fields("NumeroPedido").Value
'               txtNumeroItemPedido.Text = oRs.Fields("IP").Value
'            End If
'            If Not IsNull(oRs.Fields("NumeroRequerimiento").Value) Then
'               txtNumeroRequerimiento.Text = oRs.Fields("NumeroRequerimiento").Value
'               txtNumeroItemRequerimiento.Text = oRs.Fields("IR").Value
'            End If
'         End If
'         oRs.Close
         If Not glbAdministrador Then
            txtCostoUnitario.Enabled = False
            dcfields(3).Enabled = False
            txtCotizacionMoneda.Enabled = False
            txtCotizacionDolar.Enabled = False
         End If
      End If
      If Not IsNull(.Fields("IdDetalleRequerimiento").Value) Then
         mIdReq = .Fields("IdDetalleRequerimiento").Value
         Set oRs = oAp.Requerimientos.Item(0).DetRequerimientos.Item(.Fields("IdDetalleRequerimiento").Value).Registro
         If oRs.RecordCount > 0 Then
            txtNumeroRequerimiento.Text = oAp.Requerimientos.Item(oRs.Fields("IdRequerimiento").Value).Registro.Fields("NumeroRequerimiento").Value
            txtNumeroItemRequerimiento.Text = oRs.Fields("NumeroItem").Value
         End If
         oRs.Close
      End If
   End With
   
   Set oRs = Nothing
   Set oAp = Nothing
   
End Property

Public Property Get RecepcionSAT() As ComPronto.RecepcionSAT

   Set RecepcionSAT = oRecepcion

End Property

Public Property Set RecepcionSAT(ByVal vnewvalue As ComPronto.RecepcionSAT)

   Set oRecepcion = vnewvalue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
   
      Dim oRs As ADOR.Recordset
               
      Select Case Index
         Case 1
            Set oRs = Aplicacion.Articulos.Item(DataCombo1(Index).BoundText).Registro
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  If IsNull(.Fields("IdUnidad").Value) Then
                     If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                        .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     Else
                        .Fields("IdUnidad").Value = mvarIdUnidadCU
                     End If
                  End If
                  If IsNull(.Fields("IdUbicacion").Value) Then
                     .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacionStandar").Value
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
                     Case 2
                        txtCantidad1.Visible = True
                        txtCantidad2.Visible = False
                        Label1(0).Visible = False
                        txtUnidad.Visible = True
                     Case 3
                        txtCantidad1.Visible = True
                        txtCantidad2.Visible = True
                        Label1(0).Visible = True
                        txtUnidad.Visible = True
                  End Select
               End If
               txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
            End If
            oRs.Close
      
         Case 3
'            If IsNumeric(DataCombo1(Index).BoundText) Then
'               Set oRs = Aplicacion.Obras.TraerFiltrado("_DestinosParaComboPorIdObra", _
'                                                         DataCombo1(Index).BoundText)
'               If oRs.RecordCount = 0 Then
'                  origen.Registro.Fields(DataCombo1(5).DataField).Value = Null
'                  DataCombo1(5).Enabled = False
'                  oRs.Close
'               ElseIf oRs.RecordCount = 1 Then
'                  Set DataCombo1(5).RowSource = oRs
'                  origen.Registro.Fields(DataCombo1(5).DataField).Value = oRs.Fields(0).Value
'               Else
'                  Set DataCombo1(5).RowSource = oRs
'               End If
'            End If
      End Select
         
      Set oRs = Nothing

   End If
      
End Sub

Private Sub dcfields_Change(Index As Integer)

   If Len(dcfields(Index).BoundText) = 0 Or Not IsNumeric(dcfields(Index).BoundText) Then Exit Sub
   origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
   Select Case Index
      Case 3
         If dcfields(Index).BoundText = mvarIdMonedaPesos Then
            txtCotizacionMoneda.Text = 1
         Else
            Dim oRs As ADOR.Recordset
            Set oRs = Aplicacion.Cotizaciones.TraerFiltrado("_PorFechaMoneda", Array(Date, dcfields(Index).BoundText))
            If oRs.RecordCount > 0 Then
               txtCotizacionMoneda.Text = oRs.Fields("CotizacionLibre").Value
            Else
               MsgBox "No hay cotizacion, ingresela manualmente"
               txtCotizacionMoneda.Text = ""
            End If
            oRs.Close
            Set oRs = Nothing
         End If
   End Select
   
End Sub

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
   Set oRecepcion = Nothing

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vnewvalue As Variant)

   mvarIdNuevo = vnewvalue

End Property
