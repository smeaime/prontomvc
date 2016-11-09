VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetProduccionOrden 
   Caption         =   "Item de orden de producción"
   ClientHeight    =   2745
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10905
   Icon            =   "frmDetProduccionOrden.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   2745
   ScaleWidth      =   10905
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtTolerancia 
      Alignment       =   1  'Right Justify
      DataField       =   "Tolerancia"
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
      Left            =   6720
      TabIndex        =   27
      Top             =   1800
      Width           =   870
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   6300
      TabIndex        =   22
      Top             =   8340
      Visible         =   0   'False
      Width           =   1005
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
      Height          =   315
      Left            =   2040
      TabIndex        =   21
      Top             =   1440
      Width           =   870
   End
   Begin VB.CheckBox Check1 
      Height          =   240
      Left            =   2070
      TabIndex        =   20
      Top             =   8295
      Width           =   195
   End
   Begin VB.TextBox txtBusca1 
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
      Height          =   315
      Left            =   8415
      TabIndex        =   16
      Top             =   8205
      Width           =   2220
   End
   Begin VB.TextBox txtStockActual 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
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
      Left            =   5520
      TabIndex        =   14
      Top             =   240
      Width           =   1005
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
      Height          =   315
      Left            =   2040
      TabIndex        =   0
      Top             =   240
      Width           =   1545
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
      Height          =   315
      Left            =   8400
      TabIndex        =   7
      Top             =   240
      Width           =   2265
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   7440
      TabIndex        =   5
      Top             =   2280
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   405
      Index           =   1
      Left            =   9120
      TabIndex        =   6
      Top             =   2280
      Width           =   1485
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
         LCID            =   11274
         SubFormatType   =   1
      EndProperty
      Height          =   315
      Left            =   2040
      TabIndex        =   2
      Top             =   1080
      Visible         =   0   'False
      Width           =   1185
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   2040
      TabIndex        =   1
      Tag             =   "Articulos"
      Top             =   720
      Width           =   8610
      _ExtentX        =   15187
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
      Left            =   3000
      TabIndex        =   4
      Tag             =   "Unidades"
      Top             =   1440
      Width           =   1545
      _ExtentX        =   2725
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUbicacion"
      Height          =   315
      Index           =   2
      Left            =   6720
      TabIndex        =   3
      Tag             =   "Ubicaciones"
      Top             =   1080
      Visible         =   0   'False
      Width           =   3885
      _ExtentX        =   6853
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUbicacion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdOrdenTrabajo"
      Height          =   315
      Index           =   7
      Left            =   2295
      TabIndex        =   18
      Tag             =   "OrdenesTrabajo"
      Top             =   8250
      Width           =   2535
      _ExtentX        =   4471
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdOrdenTrabajo"
      Text            =   ""
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
      DataField       =   "IdProduccionProceso"
      Height          =   315
      Index           =   7
      Left            =   2040
      TabIndex        =   23
      Tag             =   "ProduccionProcesos"
      Top             =   1800
      Width           =   3330
      _ExtentX        =   5874
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProduccionProceso"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "idColor"
      Height          =   315
      Index           =   13
      Left            =   6720
      TabIndex        =   25
      Tag             =   "Colores"
      Top             =   1440
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdColor"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tolerancia:"
      Height          =   225
      Index           =   1
      Left            =   5760
      TabIndex        =   28
      Top             =   1920
      Width           =   1815
   End
   Begin VB.Label lblColor 
      Caption         =   "Color"
      Height          =   255
      Index           =   2
      Left            =   5760
      TabIndex        =   26
      Top             =   1560
      Width           =   615
   End
   Begin VB.Label lblLabels 
      Caption         =   "Proceso Relacionado"
      Height          =   225
      Index           =   9
      Left            =   120
      TabIndex        =   24
      Top             =   1920
      Width           =   1560
   End
   Begin VB.Label lblLabels 
      Caption         =   "Orden de trabajo (opc.) :"
      Height          =   300
      Index           =   8
      Left            =   135
      TabIndex        =   19
      Top             =   8250
      Width           =   1815
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
      Height          =   255
      Index           =   3
      Left            =   7470
      TabIndex        =   17
      Top             =   8250
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Stock actual :"
      Height          =   300
      Index           =   6
      Left            =   4320
      TabIndex        =   15
      Top             =   360
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de articulo :"
      Height          =   300
      Index           =   4
      Left            =   120
      TabIndex        =   13
      Top             =   360
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ubicacion :"
      Height          =   255
      Index           =   16
      Left            =   5760
      TabIndex        =   12
      Top             =   1200
      Visible         =   0   'False
      Width           =   915
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
      Height          =   255
      Index           =   14
      Left            =   7440
      TabIndex        =   11
      Top             =   360
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   225
      Index           =   2
      Left            =   120
      TabIndex        =   10
      Top             =   840
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   180
      Index           =   7
      Left            =   120
      TabIndex        =   9
      Top             =   1560
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Partida :"
      Height          =   300
      Index           =   0
      Left            =   120
      TabIndex        =   8
      Top             =   1200
      Visible         =   0   'False
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetProduccionOrden"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public WithEvents origen As ComPronto.DetProduccionOrden
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oProduccionOrden As ComPronto.ProduccionOrden
Private mvarIdUnidad As Integer, mOk As Integer, mTipoSalida As Integer
Private mvarIdUnidadCU As Integer
Private mvarCantidadUnidades As Double
Public mvarCantidadAdicional As Double
Public Aceptado As Boolean, mOTsMantenimiento As Boolean, mExigirOT As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long, mvarIdMonedaPesos As Long
Private mvarIdMonedaDolar As Long, mvarIdControlCalidadStandar As Long, mvarIdObra As Long
Private mvarIdDepositoOrigen As Long, mvarIdDepositoOrigenParametro As Long
Private mvarAnchoForm As Long
Private mvarPathAdjuntos As String, mDescargaPorKit As String, mCostoATomar As String
Private mvarFechaImputacionActiva As String, mvarExigirEquipoDestino As String
Private mvarParaMantenimiento As String, mvarBasePRONTOMantenimiento As String
Private mvarImagenes As Boolean, mvarRegistrarStock As Boolean, mvarLimitarEquiposDestinoSegunEtapasDeObra As Boolean

Private Sub Check1_Click()

   If Check1.Value = 0 Then
      origen.Registro.Fields("IdOrdenTrabajo").Value = Null
   End If

End Sub

Friend Sub cmd_Click(Index As Integer)

   Dim oF As Form
   
   Select Case Index
      
      Case 0
      
         'If Len(txtCostoUnitario.Text) = 0 And txtCostoUnitario.Visible Then
         '   MsgBox "No ingreso el costo unitario", vbInformation
         '   Exit Sub
         'End If
         
         
         
         Dim dc As DataCombo
         Dim oRs As ADOR.Recordset
         Dim mvarStock As Double, mvarStock1 As Double, mvarStock2 As Double, mvarCantidad As Double
         Dim mvarIdStock As Long
         Dim i As Integer
         Dim mvarUnidad As String, mvarAux1 As String, mvarAux2 As String, mvarAux3 As String
         Dim mDescargaPorKit1 As Boolean
         
         mDescargaPorKit1 = False
         
         
         origen.Registro.Fields("Cantidad").Value = Val(txtCantidad)
         
         For Each dc In DataCombo1
            If (dc.Enabled And dc.Visible) Or dc.Index = 0 Then
               If Len(Trim(dc.BoundText)) = 0 And dc.Index <> 4 Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
               If dc.Enabled And dc.Visible And IsNumeric(dc.BoundText) Then
                  origen.Registro.Fields(dc.DataField).Value = dc.BoundText
               End If
            End If
         Next
      
         If IsNull(origen.Registro.Fields("Cantidad").Value) Or origen.Registro.Fields("Cantidad").Value = 0 Then
            MsgBox "Falta ingresar la cantidad (unidades)", vbCritical
            Exit Sub
         End If
         
         mvarCantidadUnidades = origen.Registro.Fields("Cantidad").Value
         mvarCantidadAdicional = 0
'         origen.Registro.Fields("IdUnidad").Value = mvarIdUnidad
         
                  If txtTolerancia.Text = "" Then origen.Registro.Fields("Tolerancia").Value = Null

         If IsNull(origen.Registro.Fields("Partida").Value) Then
            origen.Registro.Fields("Partida").Value = ""
         End If
         
         
         Dim Delta As Double
         Dim DeltaTolerable As Double
         'proporcion=
         'tolerancia=
         'Delta = Abs(oProduccionOrden!Cantidad * Proporcion - txtCantidad)
         'DeltaTolerable = (tolerancia * TotalOP * Proporcion)
         'If Delta > DeltaTolerable Then
         '   mOk = MsgBox("El delta es de " & Delta & " y el máximo tolerable es " & DeltaTolerable & vbCrLf & _
         '               "Desea continuar igual ?", vbYesNo, "Tolerancia")
         '   If mOk = vbNo Then Exit Sub
         'End If
                  
         
         
         mvarAux2 = BuscarClaveINI("Inhabilitar stock negativo")
         mvarAux3 = BuscarClaveINI("Inhabilitar stock global negativo")
         With origen.Registro
            'Set oRs = Aplicacion.Articulos.TraerFiltrado("_StockPorArticuloPartidaUnidadUbicacionObra", _
                     Array(.Fields("IdArticulo").Value, IIf(IsNull(.Fields("Partida").Value), "", .Fields("Partida").Value), _
                           .Fields("IdUnidad").Value, IIf(IsNull(.Fields("IdUbicacion").Value), 0, .Fields("IdUbicacion").Value), _
                           .Fields("IdObra").Value))
            'If oRs.RecordCount > 0 Then
            '   mvarStock1 = IIf(IsNull(oRs.Fields("Stock").Value), 0, oRs.Fields("Stock").Value)
            'End If
            'oRs.Close
            'Set oRs = Aplicacion.Articulos.TraerFiltrado("_StockTotalPorArticulo", .Fields("IdArticulo").Value)
            'If oRs.RecordCount > 0 Then
            '   mvarStock2 = IIf(IsNull(oRs.Fields("Stock").Value), 0, oRs.Fields("Stock").Value)
            'End If
            'oRs.Close
         End With
         mvarStock = 0
         If mvarId > 0 Then
            Set oRs = Aplicacion.TablasGenerales.TraerUno("DetProduccionOrdenes", mvarId)
            If oRs.RecordCount > 0 Then
               mvarStock = IIf(IsNull(oRs.Fields("Cantidad").Value), 0, oRs.Fields("Cantidad").Value)
            End If
            oRs.Close
         End If
         
         
         With origen.Registro
'            .Fields("IdUnidad").Value = mvarIdUnidad
            .Fields("CantidadAdicional").Value = mvarCantidadAdicional * mvarCantidadUnidades
            .Fields("IdStock").Value = mvarIdStock
         End With
         
         origen.Modificado = True
         Aceptado = True
         
         Set oRs = Nothing
   
         Me.Hide

      Case 1
      
         If mvarId = -1 Then
            origen.Eliminado = True
         End If
         Me.Hide

      Case 2
         
         Set oF = New frmConsulta1
         With oF
            .Id = 1
            .Show vbModal, Me
         End With
         Unload oF
         Set oF = Nothing
      
      Case 3
         
         If IsNull(origen.Registro.Fields("IdArticulo").Value) Then
            MsgBox "No ha definido el material", vbExclamation
            Exit Sub
         Else
            Dim of2 As frmConsultaStockPorPartidas
            Set of2 = New frmConsultaStockPorPartidas
            With of2
               .Articulo = origen.Registro.Fields("IdArticulo").Value
               .Show vbModal, Me
            End With
            Unload of2
            Set of2 = Nothing
         End If
      
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim dtp As DTPicker
   Dim oAp As ComPronto.Aplicacion
   Dim oApProd As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim i As Integer
   Dim mLimitarUbicaciones As Boolean
   Dim mAux1

   Set oAp = Aplicacion
   Set oApProd = AplicacionProd
   
   mvarId = vNewValue
   mExigirOT = False
   mvarAnchoForm = Me.Width
   mvarRegistrarStock = True
   
   Set origen = oProduccionOrden.DetProduccionOrdenes.Item(vNewValue)
   Me.IdNuevo = origen.Id
   
   
   
       
   
   Set oPar = oAp.Parametros.Item(1)
   With oPar.Registro
      mvarIdUnidadCU = IIf(IsNull(.Fields("IdUnidadPorUnidad").Value), 0, .Fields("IdUnidadPorUnidad").Value)
      mvarIdMonedaPesos = IIf(IsNull(.Fields("IdMoneda").Value), 1, .Fields("IdMoneda").Value)
      mvarIdMonedaDolar = IIf(IsNull(.Fields("IdMonedaDolar").Value), 2, .Fields("IdMonedaDolar").Value)
      mvarBasePRONTOMantenimiento = IIf(IsNull(.Fields("BasePRONTOMantenimiento").Value), "", .Fields("BasePRONTOMantenimiento").Value)
   End With
   Set oPar = Nothing
   
   mvarIdDepositoOrigenParametro = 0
   mAux1 = TraerValorParametro2("IdDepositoCentral")
   If Not IsNull(mAux1) And IsNumeric(mAux1) Then mvarIdDepositoOrigenParametro = Val(mAux1)
   
   mvarIdUnidad = mvarIdUnidadCU
   mvarCantidadAdicional = 0
   
   If glbIdObraAsignadaUsuario > 0 Then
      mvarIdObra = glbIdObraAsignadaUsuario
   ElseIf Not IsNull(oProduccionOrden.Registro.Fields("IdObra").Value) Then
      mvarIdObra = oProduccionOrden.Registro.Fields("IdObra").Value
   Else
      mvarIdObra = 0
   End If
   
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
               If oControl.Tag = "Ubicaciones" And mLimitarUbicaciones And glbIdObraAsignadaUsuario > 0 Then
                  Set oControl.RowSource = oAp.Ubicaciones.TraerFiltrado("_PorObra", glbIdObraAsignadaUsuario)
               ElseIf oControl.Tag = "Articulos1" Then
                  If mvarIdObra > 0 Then
                     Set oControl.RowSource = oAp.Articulos.TraerFiltrado("_BD_ProntoMantenimientoTodos", mvarIdObra)
                  Else
                     Set oControl.RowSource = oAp.Articulos.TraerFiltrado("_ParaMantenimiento_ParaCombo")
                  End If
               ElseIf oControl.Tag = "ObraDestinos" Then
               ElseIf oControl.Tag = "PresupuestoObrasRubros" Then
               ElseIf oControl.Tag = "ProduccionProcesos" Then
                    'Set oControl.RowSource = oAp.TablasGenerales.TraerLista("ProduccionProcesos", "_IncorporanMaterial")
                    Set oControl.RowSource = oApProd.Procesos.TraerFiltrado("_IncorporanMaterialParaCombo")
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
         
         If mvarId > 0 And Not glbAdministrador And _
               (TypeOf oControl Is DataCombo Or TypeOf oControl Is TextBox) Then
            oControl.Locked = True
         End If
      Next
   End With
   
   If Not IsNull(origen.Registro.Fields("IdDetalleValeSalida").Value) Then
      Cmd(2).Enabled = False
   End If
   
   If mvarId = -1 Then
      With origen.Registro
         .Fields("Adjunto").Value = "NO"
         .Fields("Observaciones").Value = " "
         .Fields("IdObra").Value = oProduccionOrden.Registro.Fields("IdObra").Value
         .Fields("IdMoneda").Value = mvarIdMonedaPesos
      End With
   Else
      If mvarId > 0 And Not glbAdministrador Then Cmd(0).Enabled = False
      With origen.Registro
         If IsNull(.Fields("IdObra").Value) Then
            .Fields("IdObra").Value = oProduccionOrden.Registro.Fields("IdObra").Value
         End If
         If Not IsNull(.Fields("IdUnidad").Value) Then
            DataCombo1(0).Locked = False
         End If
         If mvarIdObra > 0 And Not IsNull(.Fields("IdEquipoDestino").Value) And _
               Len(mvarBasePRONTOMantenimiento) > 0 Then
            Set oRs = oAp.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorId", .Fields("IdEquipoDestino").Value)
            If oRs.RecordCount > 0 Then
               With text1
                  .TOp = DataCombo1(4).TOp
                  .Left = DataCombo1(4).Left
                  .Width = DataCombo1(4).Width
                  .Text = oRs.Fields("Material").Value
                  .Enabled = False
                  .Visible = True
               End With
               DataCombo1(4).Visible = False
            End If
            oRs.Close
         End If
      End With
   End If

   Set oRs = Nothing
   Set oAp = Nothing
   Set oApProd = Nothing
   
        If IsNull(origen.Registro.Fields("Tolerancia").Value) Then txtTolerancia.Text = ""

   
   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then
      DataCombo1(0).Enabled = False
   End If
   
End Property

Public Property Get ProduccionOrden() As ComPronto.ProduccionOrden

   Set ProduccionOrden = oProduccionOrden

End Property

Public Property Set ProduccionOrden(ByVal vNewValue As ComPronto.ProduccionOrden)

   Set oProduccionOrden = vNewValue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   Dim oRs As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim mCosto As Double
   Dim mAuxI1 As Integer
            
   'If Index = 0 Then Stop
            
            
   Select Case Index
      
      Case 1
         If IsNumeric(DataCombo1(Index).BoundText) Then
            mvarParaMantenimiento = "NO"
            mExigirOT = False
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(1).BoundText)
            With origen.Registro
               If oRs.RecordCount > 0 And _
                     (IsNull(.Fields("IdArticulo").Value) Or _
                      .Fields("IdArticulo").Value <> DataCombo1(1).BoundText) Then
                  If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                     .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                  Else
                     .Fields("IdUnidad").Value = mvarIdUnidadCU
                  End If
                  mvarParaMantenimiento = IIf(IsNull(oRs.Fields("ParaMantenimiento").Value), "NO", oRs.Fields("ParaMantenimiento").Value)
                  If Not IsNull(oRs.Fields("ConsumirPorOT").Value) And _
                        oRs.Fields("ConsumirPorOT").Value = "SI" Then
                     mExigirOT = True
                  End If
                  mvarRegistrarStock = True
                  If Not IsNull(oRs.Fields("RegistrarStock").Value) And oRs.Fields("RegistrarStock").Value = "NO" Then
                     mvarRegistrarStock = False
                  End If
               End If
               .Fields("IdArticulo").Value = DataCombo1(1).BoundText
               If oRs.RecordCount > 0 Then
'                  DataCombo1(0).BoundText = mvarIdUnidadCU
                  If IsNull(.Fields("IdUbicacion").Value) Or mvarId = -1 Then
                     If Me.IdDepositoOrigen = 0 Or Me.IdDepositoOrigen = mvarIdDepositoOrigenParametro Then
                        .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacionStandar").Value
                     Else
                        Set oRsAux = Aplicacion.Ubicaciones.TraerFiltrado("_PorObra", Array(-1, Me.IdDepositoOrigen))
                        If oRsAux.RecordCount = 1 Then .Fields("IdUbicacion").Value = oRsAux.Fields(0).Value
                        oRsAux.Close
                     End If
                  End If
                  If mvarId = -1 Then
                     .Fields("IdMoneda").Value = mvarIdMonedaPesos
                     .Fields("CotizacionMoneda").Value = 1
                     .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                  End If
                  If Right(IIf(IsNull(oRs.Fields("Codigo").Value), "0000", oRs.Fields("Codigo").Value), 4) = "9999" And _
                        Not IsNull(.Fields("IdDetalleValeSalida").Value) Then
                     Set oRsAux = Aplicacion.TablasGenerales.TraerFiltrado("DetValesSalida", "_TodoMasPendientePorIdDetalle", .Fields("IdDetalleValeSalida").Value)
                     If oRsAux.RecordCount > 0 Then
                        mCosto = IIf(IsNull(oRsAux.Fields("CostoRecepcion").Value), 0, oRsAux.Fields("CostoRecepcion").Value)
                     End If
                     oRsAux.Close
                  Else
                     If mCostoATomar = "CostoReposicion" Then
                        mCosto = IIf(IsNull(oRs.Fields("CostoReposicion").Value), 0, oRs.Fields("CostoReposicion").Value)
                     Else
                        mCosto = IIf(IsNull(oRs.Fields("CostoPPP").Value), 0, oRs.Fields("CostoPPP").Value)
                     End If
                  End If
                  If mvarId <= 0 Then
                     .Fields("CostoUnitario").Value = mCosto
                  Else
                     If IIf(IsNull(.Fields("CostoUnitario").Value), 0, .Fields("CostoUnitario").Value) <> mCosto And Me.Visible Then
                        mAuxI1 = MsgBox("El costo unitario se ha modificado, desea actualizarlo?", vbYesNo, "Costo unitario")
                        If mAuxI1 = vbYes Then .Fields("CostoUnitario").Value = mCosto
                     End If
                  End If
                  txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
                  MostrarStockActual
               End If
            End With
            oRs.Close
            If mvarImagenes Then
               If CargarImagenesThumbs(DataCombo1(Index).BoundText, Me) = -1 Then
                  Me.Width = mvarAnchoForm * 1.2
               Else
                  Me.Width = mvarAnchoForm
               End If
            End If
            
            If mDescargaPorKit = "SI" Then
               Set oRs = Aplicacion.Conjuntos.TraerFiltrado("_DetallesPorIdArticulo", DataCombo1(1).BoundText)
               oRs.Close
            End If
         End If
         
      Case 3
         If IsNumeric(DataCombo1(Index).BoundText) Then
            Set oRs = Aplicacion.Obras.TraerFiltrado("_DestinosParaComboPorIdObra", _
                                                      DataCombo1(Index).BoundText)
            If oRs.RecordCount = 0 Then
               origen.Registro.Fields(DataCombo1(6).DataField).Value = Null
               DataCombo1(6).Enabled = False
               oRs.Close
            ElseIf oRs.RecordCount = 1 Then
               DataCombo1(6).Enabled = True
               Set DataCombo1(6).RowSource = oRs
               origen.Registro.Fields(DataCombo1(6).DataField).Value = oRs.Fields(0).Value
            Else
               DataCombo1(6).Enabled = True
               Set DataCombo1(6).RowSource = oRs
            End If
            MostrarStockActual
         End If
   
      Case 4
         If IsNumeric(DataCombo1(Index).BoundText) Then
            origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorId", _
                           Array(DataCombo1(Index).BoundText, mvarIdObra))
'            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then
            End If
            oRs.Close
            
            DataCombo1(7).Enabled = True
            If mOTsMantenimiento Then
               Set DataCombo1(7).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("ProntoMantenimiento", "_OTsPorEquipo", DataCombo1(Index).BoundText)
            End If
         Else
            DataCombo1(7).Enabled = False
         End If
   
      Case 5
         origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
   
      Case 6
         If IsNumeric(DataCombo1(Index).BoundText) Then
            origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
            If mvarLimitarEquiposDestinoSegunEtapasDeObra Then
               If Me.Visible Then origen.Registro.Fields(DataCombo1(4).DataField).Value = Null
               Set oRs = Aplicacion.Articulos.TraerFiltrado("_ParaMantenimiento_ParaCombo", DataCombo1(Index).BoundText)
               If oRs.RecordCount = 1 Then
                  If IsNull(origen.Registro.Fields(DataCombo1(4).DataField).Value) Then
                     origen.Registro.Fields(DataCombo1(4).DataField).Value = oRs.Fields(0).Value
                  End If
               End If
               Set DataCombo1(4).RowSource = oRs
               If Not IsNull(origen.Registro.Fields(DataCombo1(4).DataField).Value) Then
                  DataCombo1(4).BoundText = origen.Registro.Fields(DataCombo1(4).DataField).Value
               End If
               Set oRs = Nothing
            End If
         
            Dim mIdPresupuestoObraRubro As Long, mTipoConsumo As Integer
            If Not IsNull(origen.Registro.Fields(DataCombo1(11).DataField).Value) Then
               mIdPresupuestoObraRubro = origen.Registro.Fields(DataCombo1(11).DataField).Value
            Else
               mIdPresupuestoObraRubro = 0
            End If
            Set oRs = Aplicacion.TablasGenerales.TraerUno("DetObrasDestinos", DataCombo1(Index).BoundText)
            mTipoConsumo = 3
            If oRs.RecordCount > 0 Then
               mTipoConsumo = IIf(IsNull(oRs.Fields("TipoConsumo").Value), 3, oRs.Fields("TipoConsumo").Value)
            End If
            oRs.Close
            Set oRs = Aplicacion.PresupuestoObrasRubros.TraerFiltrado("_ParaComboPorTipoConsumo", mTipoConsumo)
            Set DataCombo1(11).RowSource = oRs
            Set oRs = Nothing
         End If
      
      Case Else
         If IsNumeric(DataCombo1(Index).BoundText) Then
            origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
         End If
   
   End Select
      
    
   Set oRs = Nothing
   Set oRsAux = Nothing

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub



Private Sub Form_Load()

   ReemplazarEtiquetas Me

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oBind = Nothing
   Set origen = Nothing
   Set oProduccionOrden = Nothing

End Sub

Private Sub Form_Activate()

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   If mvarId <> -1 Then
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", origen.Registro.Fields("IdArticulo").Value)
      If oRs.RecordCount > 0 Then
         If Not IsNull(oRs.Fields("IdCuantificacion").Value) Then
            Select Case oRs.Fields("IdCuantificacion").Value
               Case 1
               Case 2
            End Select
'            If Not IsNull(oRs.Fields("Unidad11").Value) Then
'               oRs.Close
'               Set oRs = Aplicacion.Unidades.TraerFiltrado("_PorId", oRs.Fields("Unidad11").Value)
'               If oRs.RecordCount > 0 Then
'                  txtUnidad.Text = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
'               End If
'            End If
         End If
      End If
      oRs.Close
   End If
   
   Set oRs = Nothing
   
End Sub

Private Sub Form_Paint()

   ''Degradado Me
   
End Sub

Private Sub Form_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, y As Single)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then ' si el dato es texto
      
      s = Data.GetData(ccCFText) ' tomo el dato
      
      Filas = Split(s, vbCrLf) ' armo un vector por filas
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      Columnas = Split(Filas(0), vbTab)
      
      If Columnas(1) = "Stock" Then
         Columnas = Split(Filas(1), vbTab) ' armo un vector con las columnas
         Set oAp = Aplicacion
         Set oRs = oAp.Articulos.TraerFiltrado("_Stock", Columnas(0))
         If oRs.RecordCount > 0 Then
            With origen.Registro
               .Fields("Cantidad").Value = 0
               .Fields("Cantidad1").Value = 0
               .Fields("Cantidad2").Value = 0
               .Fields("Partida").Value = oRs.Fields("Partida").Value
               .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
               .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
               .Fields("IdStock").Value = oRs.Fields("IdStock").Value
               .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacion").Value
            End With
            DataCombo1(0).BoundText = oRs.Fields("IdUnidad").Value
         End If
         oRs.Close
      ElseIf Columnas(1) = "StockPorPartida" Then
         Columnas = Split(Filas(1), vbTab) ' armo un vector con las columnas
         Set oAp = Aplicacion
         Set oRs = oAp.Articulos.TraerFiltrado("_Stock", Columnas(0))
         If oRs.RecordCount > 0 Then
            With origen.Registro
               .Fields("Partida").Value = oRs.Fields("Partida").Value
               .Fields("IdStock").Value = oRs.Fields("IdStock").Value
            End With
         End If
         oRs.Close
      Else
         MsgBox "Informacion invalida!", vbCritical
         Exit Sub
      End If
      
      Set oRs = Nothing
      Set oAp = Nothing
      
      Clipboard.Clear
      
   End If

End Sub

Private Sub Form_OLEDragOver(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, y As Single, State As Integer)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long
   Dim iColumnas As Long
   Dim oL As ListItem

   If State = vbEnter Then
      If Data.GetFormat(ccCFText) Then ' si el dato es texto
         s = Data.GetData(ccCFText) ' tomo el dato
         Filas = Split(s, vbCrLf) ' armo un vector por filas
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

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Public Property Let TipoSalida(ByVal vNewValue As Integer)

   mTipoSalida = vNewValue

End Property

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

Private Sub txtBusca1_GotFocus()

   With txtBusca1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBusca1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      If KeyAscii = 13 Then
         If Len(Trim(txtBusca1.Text)) <> 0 Then
            Set DataCombo1(4).RowSource = Aplicacion.Articulos.TraerFiltrado("_Busca", txtBusca1.Text)
         Else
            Set DataCombo1(4).RowSource = Aplicacion.Articulos.TraerLista
         End If
      End If
      DataCombo1(4).SetFocus
      SendKeys "%{DOWN}"
   End If

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


Private Sub txtCodigoArticulo_GotFocus()

   With txtCodigoArticulo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoArticulo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoArticulo_Validate(Cancel As Boolean)

   If Len(txtCodigoArticulo.Text) <> 0 Then
      mvarParaMantenimiento = "NO"
      mExigirOT = False
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo.Text)
      If oRs.RecordCount > 0 Then
         With origen.Registro
            .Fields("IdArticulo").Value = oRs.Fields(0).Value
            If Not IsNull(oRs.Fields("IdUnidad").Value) And IsNull(.Fields("IdUnidad").Value) Then
               .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
            Else
               '.Fields("IdUnidad").Value = mvarIdUnidadCU
            End If
         End With
         mvarParaMantenimiento = IIf(IsNull(oRs.Fields("ParaMantenimiento").Value), "NO", oRs.Fields("ParaMantenimiento").Value)
         If Not IsNull(oRs.Fields("ConsumirPorOT").Value) And _
               oRs.Fields("ConsumirPorOT").Value = "SI" Then
            mExigirOT = True
         End If
         MostrarStockActual
      Else
         MsgBox "Codigo de material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo.Text = ""
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

Private Sub txtCodigoArticulo1_GotFocus()


End Sub

Private Sub txtCodigoArticulo1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoArticulo1_Validate(Cancel As Boolean)

   
End Sub

Private Sub txtCotizacionDolar_GotFocus()


End Sub

Private Sub txtCotizacionDolar_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCotizacionDolar_Validate(Cancel As Boolean)


End Sub

Private Sub txtCotizacionMoneda_GotFocus()


End Sub

Private Sub txtCotizacionMoneda_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCotizacionMoneda_Validate(Cancel As Boolean)

   If origen.Registro.Fields("IdMoneda").Value = mvarIdMonedaDolar Then
   End If

End Sub

Private Sub txtPartida_GotFocus()

   With txtPartida
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPartida_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub


Public Sub MostrarStockActual()

   If IsNumeric(DataCombo1(1).BoundText) Then
      If BuscarClaveINI("Mostrar solo stock de obra en salidas") = "SI" Then
         txtStockActual.Text = Aplicacion.StockPorIdArticuloIdObra(DataCombo1(1).BoundText, DataCombo1(3).BoundText)
      Else
         txtStockActual.Text = Aplicacion.StockPorIdArticulo(DataCombo1(1).BoundText)
      End If
   End If

End Sub

Public Property Get IdDepositoOrigen() As Long

   IdDepositoOrigen = mvarIdDepositoOrigen

End Property

Public Property Let IdDepositoOrigen(ByVal vNewValue As Long)

   mvarIdDepositoOrigen = vNewValue

End Property

Private Sub VividThumbs1_ThumbClick(Filename As String, X As Single, y As Single)

   If Len(Filename) > 0 Then
      If Not Len(Trim(Dir(Filename))) <> 0 Then
         MsgBox "El archivo indicado no existe!", vbExclamation
         Exit Sub
      End If
      Call ShellExecute(Me.hwnd, "open", Filename, vbNullString, vbNullString, SW_SHOWNORMAL)
   End If

End Sub
