VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetOrdenesCompra 
   Caption         =   "Item de orden de compra"
   ClientHeight    =   5280
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10770
   Icon            =   "frmDetOrdenesCompra.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5280
   ScaleWidth      =   10770
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtPorcentajeBonificacion 
      Alignment       =   2  'Center
      DataField       =   "PorcentajeBonificacion"
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
      Left            =   4590
      TabIndex        =   5
      Top             =   1845
      Width           =   780
   End
   Begin VB.Frame Frame3 
      Caption         =   "Tipo de facturacion : "
      Height          =   1095
      Left            =   2340
      TabIndex        =   27
      Top             =   4140
      Visible         =   0   'False
      Width           =   8295
      Begin VB.CheckBox Check1 
         Alignment       =   1  'Right Justify
         Caption         =   "Facturar el total aunque el mes no este completo"
         Height          =   195
         Left            =   2295
         TabIndex        =   34
         Top             =   855
         Width           =   3975
      End
      Begin VB.TextBox txtCantidadMesesAFacturar 
         Alignment       =   1  'Right Justify
         DataField       =   "CantidadMesesAFacturar"
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "0.00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   11274
            SubFormatType   =   0
         EndProperty
         Height          =   270
         Left            =   7065
         TabIndex        =   33
         Top             =   540
         Width           =   510
      End
      Begin VB.OptionButton Option7 
         Caption         =   "Automatica por mes"
         Height          =   195
         Left            =   135
         TabIndex        =   29
         Top             =   720
         Width           =   1770
      End
      Begin VB.OptionButton Option6 
         Caption         =   "Manual"
         Height          =   195
         Left            =   135
         TabIndex        =   28
         Top             =   360
         Width           =   915
      End
      Begin MSComCtl2.DTPicker DTFields 
         DataField       =   "FechaComienzoFacturacion"
         Height          =   330
         Index           =   0
         Left            =   4635
         TabIndex        =   30
         Top             =   225
         Width           =   1470
         _ExtentX        =   2593
         _ExtentY        =   582
         _Version        =   393216
         CheckBox        =   -1  'True
         Format          =   59768833
         CurrentDate     =   36377
      End
      Begin VB.Label lblLabels 
         AutoSize        =   -1  'True
         Caption         =   "Cantidad de meses a facturar (indicar cero para facturar siempre) :"
         Height          =   195
         Index           =   3
         Left            =   2295
         TabIndex        =   32
         Top             =   585
         Width           =   4650
      End
      Begin VB.Label lblLabels 
         AutoSize        =   -1  'True
         Caption         =   "Fecha de inicio de facturacion :"
         Height          =   195
         Index           =   22
         Left            =   2295
         TabIndex        =   31
         Top             =   315
         Width           =   2235
      End
   End
   Begin VB.TextBox txtCodigoArticulo 
      Alignment       =   1  'Right Justify
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
      Left            =   2115
      TabIndex        =   0
      Top             =   585
      Width           =   1725
   End
   Begin VB.Frame Frame2 
      Caption         =   "Forma de cancelacion : "
      Height          =   465
      Left            =   3015
      TabIndex        =   23
      Top             =   45
      Width           =   2985
      Begin VB.OptionButton Option4 
         Caption         =   "Por cantidad"
         Height          =   195
         Left            =   45
         TabIndex        =   25
         Top             =   225
         Width           =   1320
      End
      Begin VB.OptionButton Option5 
         Caption         =   "Por certificacion"
         Height          =   195
         Left            =   1395
         TabIndex        =   24
         Top             =   225
         Width           =   1455
      End
   End
   Begin VB.TextBox txtItem 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroItem"
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
      Left            =   2115
      TabIndex        =   10
      Top             =   180
      Width           =   645
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   90
      TabIndex        =   8
      Top             =   4365
      Width           =   1890
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   90
      TabIndex        =   9
      Top             =   4815
      Width           =   1890
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
      Left            =   2115
      TabIndex        =   4
      Top             =   1845
      Width           =   1095
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
      Left            =   2115
      TabIndex        =   2
      Top             =   1410
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Caption         =   "Tomar la descripcion de : "
      Height          =   690
      Left            =   5670
      TabIndex        =   13
      Top             =   1395
      Width           =   5010
      Begin VB.OptionButton Option2 
         Caption         =   "Solo las observaciones"
         Height          =   420
         Left            =   1845
         TabIndex        =   16
         Top             =   225
         Width           =   1455
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Solo el material"
         Height          =   420
         Left            =   180
         TabIndex        =   15
         Top             =   225
         Width           =   1455
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Material mas observaciones"
         Height          =   420
         Left            =   3420
         TabIndex        =   14
         Top             =   225
         Width           =   1455
      End
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
      Left            =   4860
      TabIndex        =   12
      Top             =   585
      Width           =   2265
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   2115
      TabIndex        =   1
      Tag             =   "Articulos"
      Top             =   990
      Width           =   8565
      _ExtentX        =   15108
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
      Left            =   3240
      TabIndex        =   3
      Tag             =   "Unidades"
      Top             =   1425
      Width           =   2175
      _ExtentX        =   3836
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1545
      Left            =   90
      TabIndex        =   11
      Top             =   2520
      Width           =   10590
      _ExtentX        =   18680
      _ExtentY        =   2725
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmDetOrdenesCompra.frx":076A
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdDetalleObraDestino"
      Height          =   315
      Index           =   10
      Left            =   7860
      TabIndex        =   7
      Tag             =   "ObrasDestinos"
      Top             =   2160
      Visible         =   0   'False
      Width           =   2805
      _ExtentX        =   4948
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdDetalleObraDestino"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaNecesidad"
      Height          =   330
      Index           =   1
      Left            =   9135
      TabIndex        =   37
      Top             =   90
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   59768833
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaEntrega"
      Height          =   330
      Index           =   2
      Left            =   9135
      TabIndex        =   38
      Top             =   495
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   582
      _Version        =   393216
      Enabled         =   0   'False
      CheckBox        =   -1  'True
      Format          =   59768833
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdColor"
      Height          =   315
      Index           =   2
      Left            =   3330
      TabIndex        =   6
      Tag             =   "Colores"
      Top             =   2160
      Visible         =   0   'False
      Width           =   2805
      _ExtentX        =   4948
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdColor"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Color :"
      Height          =   255
      Index           =   8
      Left            =   2115
      TabIndex        =   41
      Top             =   2205
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblFecha 
      Caption         =   "Fecha estimada entrega :"
      Height          =   300
      Index           =   2
      Left            =   7245
      TabIndex        =   40
      Top             =   495
      Width           =   1815
   End
   Begin VB.Label lblFecha 
      Caption         =   "Fecha de necesidad :"
      Height          =   300
      Index           =   1
      Left            =   7245
      TabIndex        =   39
      Top             =   135
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Etapa de la obra : "
      Height          =   255
      Index           =   26
      Left            =   6345
      TabIndex        =   36
      Top             =   2205
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      Caption         =   "% Bonificacion :"
      Height          =   300
      Index           =   6
      Left            =   3375
      TabIndex        =   35
      Top             =   1845
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de articulo :"
      Height          =   300
      Index           =   0
      Left            =   135
      TabIndex        =   26
      Top             =   585
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de item :"
      Height          =   300
      Index           =   1
      Left            =   135
      TabIndex        =   22
      Top             =   180
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Precio unitario"
      Height          =   300
      Index           =   4
      Left            =   135
      TabIndex        =   21
      Top             =   1845
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   255
      Index           =   2
      Left            =   135
      TabIndex        =   20
      Top             =   1035
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   135
      TabIndex        =   19
      Top             =   1410
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   210
      Index           =   5
      Left            =   135
      TabIndex        =   18
      Top             =   2295
      Width           =   1230
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
      Left            =   3960
      TabIndex        =   17
      Top             =   630
      Width           =   825
   End
End
Attribute VB_Name = "frmDetOrdenesCompra"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetOrdenCompra
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oOrdenCompra As ComPronto.OrdenCompra
Public Aceptado As Boolean
Private mvarIdUnidadCU As Integer, mTipoIva As Integer, mCondicionIva As Integer
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long, mIdObra As Long
Private mvarCantidadAdicional As Double, mvarCantidadUnidades As Double
Private mPorcentajeIVA As Double, mvarP_IVA1 As Double, mvarP_IVA2 As Double
Private mvarPathAdjuntos As String
Private mFechaEntrega As Date

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         If Len(txtCantidad.Text) = 0 Or Not IsNumeric(txtCantidad.Text) Then
            MsgBox "Debe indicar la cantidad del item a facturar", vbExclamation
            Exit Sub
         End If
         
         If Len(txtPrecio.Text) = 0 Or Not IsNumeric(txtPrecio.Text) Then
            MsgBox "Debe indicar el precio del item a facturar", vbExclamation
            Exit Sub
         End If
         
         If Len(txtItem.Text) = 0 Then
            MsgBox "Debe indicar el numero de item a facturar", vbExclamation
            Exit Sub
         End If
      
         If IsNull(origen.Registro.Fields("Cantidad").Value) Or origen.Registro.Fields("Cantidad").Value = 0 Then
            MsgBox "Falta ingresar la cantidad (unidades)", vbCritical
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim i As Integer
         Dim mObs As String
      
         With origen.Registro
            For Each dtp In DTFields
               If dtp.Enabled Then
                  .Fields(dtp.DataField).Value = dtp.Value
               End If
            Next
            
            For Each dc In DataCombo1
               If dc.Visible And dc.Enabled Or dc.Index = 0 Then
                  If Not IsNumeric(dc.BoundText) And dc.Index <> 2 Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
                  If IsNumeric(dc.BoundText) Then .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
      
            .Fields("Observaciones").Value = Replace(rchObservaciones.Text, Chr(13) + Chr(10) + Chr(13) + Chr(10), " ")
            .Fields("Observaciones").Value = Replace(rchObservaciones.Text, Chr(9), "   ")
            If Option4.Value Then
               .Fields("TipoCancelacion").Value = 1
            Else
               .Fields("TipoCancelacion").Value = 2
            End If
            If Option6.Value Then
               .Fields("FacturacionAutomatica").Value = "NO"
               .Fields("FechaComienzoFacturacion").Value = Null
               .Fields("CantidadMesesAFacturar").Value = Null
               .Fields("FacturacionCompletaMensual").Value = Null
            Else
               .Fields("FacturacionAutomatica").Value = "SI"
               If Check1.Value = 0 Then
                  .Fields("FacturacionCompletaMensual").Value = Null
               Else
                  .Fields("FacturacionCompletaMensual").Value = "SI"
               End If
            End If
            .Fields("Observaciones").Value = rchObservaciones.Text
         End With
         
         origen.Modificado = True
         Aceptado = True
   
         Me.Hide

      Case 1
      
         If mvarId = -1 Then
            origen.Eliminado = True
         End If
   
         Me.Hide
         
   End Select

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim i As Integer
   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset

   mvarId = vNewValue
   
   Set oAp = Aplicacion
   
   Set origen = oOrdenCompra.DetOrdenesCompra.Item(vNewValue)
   Me.IdNuevo = origen.Id
   Set oBind = New BindingCollection
   
   Set oPar = oAp.Parametros.Item(1)
   With oPar.Registro
      mvarIdUnidadCU = .Fields("IdUnidadPorUnidad").Value
      mvarPathAdjuntos = .Fields("PathAdjuntos").Value
      mvarP_IVA1 = .Fields("Iva1").Value
      mvarP_IVA2 = .Fields("Iva2").Value
   End With
   Set oPar = Nothing
   
   If BuscarClaveINI("Ordenes de compra automaticas") = "SI" Then
      Frame3.Visible = True
   End If
   
'   If BuscarClaveINI("Exigir etapa de obra en circuito de compras para comprobante de proveedores") = "SI" Then
'      lblLabels(26).Visible = True
'      DataCombo1(10).Visible = True
'   End If
   
   If BuscarClaveINI("Tabla de colores ampliada") = "SI" Then
      lblLabels(8).Visible = True
      DataCombo1(2).Visible = True
   End If
   
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DTPicker Then
            If Len(oControl.DataField) Then .Add oControl, "value", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "ObrasDestinos" Then
                  Set oControl.RowSource = oAp.Obras.TraerFiltrado("_DestinosParaComboPorIdObra", Me.IdObra)
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   If mvarId = -1 Then
      With origen.Registro
         .Fields("OrigenDescripcion").Value = 1
         .Fields("NumeroItem").Value = oOrdenCompra.DetOrdenesCompra.CantidadRegistros + 1
      End With
      Option1.Value = True
      Option4.Value = True
      Option6.Value = True
      Check1.Value = 0
      DTFields(1).Value = Date
   Else
      With origen.Registro
         If Not IsNull(.Fields("OrigenDescripcion").Value) Then
            Select Case .Fields("OrigenDescripcion").Value
               Case 1
                  Option1.Value = True
               Case 2
                  Option2.Value = True
               Case 3
                  Option3.Value = True
            End Select
         Else
            Option1.Value = True
         End If
         If Not IsNull(.Fields("TipoCancelacion").Value) Then
            Select Case .Fields("TipoCancelacion").Value
               Case 1
                  Option4.Value = True
               Case 2
                  Option5.Value = True
            End Select
         Else
            Option4.Value = True
         End If
         If IsNull(.Fields("FacturacionAutomatica").Value) Or _
               .Fields("FacturacionAutomatica").Value = "NO" Then
            Option6.Value = True
         Else
            Option7.Value = True
         End If
         If IsNull(.Fields("FacturacionCompletaMensual").Value) Or _
               .Fields("FacturacionCompletaMensual").Value = "NO" Then
            Check1.Value = 0
         Else
            Check1.Value = 1
         End If
         Set oRs = oAp.Articulos.TraerFiltrado("_PorId", .Fields("IdArticulo").Value)
         If oRs.RecordCount > 0 Then
            txtCodigoArticulo.Text = oRs.Fields("Codigo").Value
         End If
         oRs.Close
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing

   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then
      DataCombo1(0).Enabled = False
   End If

End Property

Public Property Get OrdenCompra() As ComPronto.OrdenCompra

   Set OrdenCompra = oOrdenCompra

End Property

Public Property Set OrdenCompra(ByVal vNewValue As ComPronto.OrdenCompra)

   Set oOrdenCompra = vNewValue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   Select Case Index
      
      Case 1
      
         If IsNumeric(DataCombo1(Index).BoundText) Then
            
            Dim oArt As ComPronto.Articulo
            Dim oRs As ADOR.Recordset
            Dim oRsAux As ADOR.Recordset
            
            Set oArt = Aplicacion.Articulos.Item(DataCombo1(1).BoundText)
            Set oRs = oArt.Registro
         
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  If (IsNull(.Fields("IdArticulo").Value) Or .Fields("IdArticulo").Value <> DataCombo1(1).BoundText) Then
                     If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                        .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     Else
                        .Fields("IdUnidad").Value = mvarIdUnidadCU
                     End If
                     If Not IsNull(oRs.Fields("CostoReposicion").Value) Then
                        .Fields("Precio").Value = oRs.Fields("CostoReposicion").Value
                     End If
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
'                     txtUnidad.Text = Aplicacion.Unidades.Item(oRs.Fields("Unidad11").Value).Registro.Fields("Descripcion").Value
                  End If
               End If
               txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
            
               If Me.Visible And (IsNull(origen.Registro.Fields("Precio").Value) Or origen.Registro.Fields("Precio").Value = 0) Then
                  Set oRsAux = Aplicacion.ListasPrecios.TraerFiltrado("_UltimoPorIdArticulo", _
                        Array(oRs.Fields(0).Value, oOrdenCompra.Registro.Fields("IdMoneda").Value))
                  If oRsAux.RecordCount > 0 Then
                     origen.Registro.Fields("Precio").Value = IIf(IsNull(oRsAux.Fields("Precio").Value), 0, oRsAux.Fields("Precio").Value)
                  End If
                  oRsAux.Close
               End If
            End If
            oRs.Close
            
            Set oRs = Nothing
            Set oRsAux = Nothing
            Set oArt = Nothing
            
         End If

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

Private Sub Form_Activate()

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   Set oAp = Aplicacion
   
   If mvarId <> -1 Then
      Set oRs = oAp.Articulos.Item(origen.Registro.Fields("IdArticulo").Value).Registro
      If oRs.RecordCount > 0 Then
         If Not IsNull(oRs.Fields("IdCuantificacion").Value) Then
            If Not IsNull(oRs.Fields("Unidad11").Value) Then
'               txtUnidad.Text = oAp.Unidades.Item(oRs.Fields("Unidad11").Value).Registro.Fields("Descripcion").Value
            End If
         End If
      End If
      oRs.Close
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
End Sub

Private Sub Form_Load()

   If glbMenuPopUpCargado Then ActivarPopUp Me
   
   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oBind = Nothing
   Set origen = Nothing
   Set oOrdenCompra = Nothing

   If glbMenuPopUpCargado Then DesactivarPopUp Me
   
End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      origen.Registro.Fields("OrigenDescripcion").Value = 1
   End If
   
End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      origen.Registro.Fields("OrigenDescripcion").Value = 2
   End If
   
End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      origen.Registro.Fields("OrigenDescripcion").Value = 3
   End If
   
End Sub

Private Sub Option4_Click()

   If Option4.Value Then
      txtCantidad.Enabled = True
   End If
   
End Sub

Private Sub Option5_Click()

   If Option5.Value Then
      With txtCantidad
         .Text = 1
         .Enabled = False
      End With
      origen.Registro.Fields("Cantidad").Value = 1
   End If
   
End Sub

Private Sub Option6_Click()

   If Option6.Value Then
      DTFields(0).Enabled = False
      txtCantidadMesesAFacturar.Enabled = False
      Check1.Enabled = False
   End If

End Sub

Private Sub Option7_Click()

   If Option7.Value Then
      With DTFields(0)
         If IsNull(origen.Registro.Fields("FechaComienzoFacturacion").Value) Then
            .Value = Date
         End If
         .Enabled = True
      End With
      txtCantidadMesesAFacturar.Enabled = True
      Check1.Enabled = True
   End If

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
         Dim oAp As ComPronto.Aplicacion
         Dim oRs As ADOR.Recordset
         Set oAp = Aplicacion
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set oRs = oAp.Articulos.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set oRs = oAp.Articulos.TraerLista
         End If
         Set DataCombo1(1).RowSource = oRs
         If oRs.RecordCount > 0 Then
            DataCombo1(1).BoundText = oRs.Fields(0).Value
         End If
         Set oRs = Nothing
         Set oAp = Nothing
      End If
      DataCombo1(1).SetFocus
      SendKeys "%{DOWN}"
   End If

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

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
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdArticulo").Value = oRs.Fields(0).Value
      Else
         MsgBox "Codigo de material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo.Text = ""
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

Private Sub txtItem_Validate(Cancel As Boolean)

   If Len(Trim(txtItem.Text)) <> 0 And mvarId = -1 Then
'      If oOrdenCompra.DetOrdenesCompra.ItemExistente(txtItem.Text) Then
'         MsgBox "El item ya existe en el OrdenCompra, ingrese otro numero.", vbCritical
'         Cancel = True
'      End If
   End If

End Sub

Private Sub txtItem_GotFocus()
   
   With txtItem
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtItem_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPorcentajeBonificacion_GotFocus()

   With txtPorcentajeBonificacion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcentajeBonificacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPrecio_GotFocus()

   With txtPrecio
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPrecio_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
      KeyAscii = 0
   End If

End Sub

Public Property Get IdObra() As Long

   IdObra = mIdObra

End Property

Public Property Let IdObra(ByVal vNewValue As Long)

   mIdObra = vNewValue

End Property
