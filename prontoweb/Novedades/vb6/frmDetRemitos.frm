VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetRemitos 
   Caption         =   "Item de remito"
   ClientHeight    =   6975
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10740
   Icon            =   "frmDetRemitos.frx":0000
   LinkTopic       =   "Form1"
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   6975
   ScaleWidth      =   10740
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtNumeroCaja 
      DataField       =   "NumeroCaja"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   5760
      TabIndex        =   43
      Top             =   1890
      Visible         =   0   'False
      Width           =   780
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
      Left            =   6660
      TabIndex        =   40
      Top             =   135
      Width           =   690
   End
   Begin VB.Frame Frame3 
      Caption         =   "Forma de baja de stock : "
      Height          =   1410
      Left            =   8505
      TabIndex        =   37
      Top             =   3150
      Width           =   2130
      Begin VB.OptionButton Option7 
         Caption         =   "Descarga por componentes (Kit)"
         Height          =   510
         Left            =   180
         TabIndex        =   39
         Top             =   720
         Width           =   1635
      End
      Begin VB.OptionButton Option6 
         Caption         =   "Descarga por articulo"
         Height          =   195
         Left            =   180
         TabIndex        =   38
         Top             =   405
         Width           =   1815
      End
   End
   Begin VB.TextBox txtPartida 
      DataField       =   "Partida"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   3735
      TabIndex        =   35
      Top             =   1890
      Width           =   1095
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Ver stock"
      Height          =   405
      Index           =   3
      Left            =   45
      TabIndex        =   34
      Top             =   3645
      Width           =   945
   End
   Begin VB.CommandButton cmdBorrarObservaciones 
      Caption         =   "Borrar observaciones"
      Height          =   240
      Left            =   6435
      TabIndex        =   29
      Top             =   4635
      Width           =   1950
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
      Left            =   2070
      TabIndex        =   1
      Top             =   630
      Width           =   1545
   End
   Begin VB.TextBox txtOrdenCompra 
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
      Height          =   315
      Left            =   4140
      TabIndex        =   24
      Top             =   135
      Width           =   1275
   End
   Begin VB.Frame Frame2 
      Caption         =   "Forma de cancelacion : "
      Enabled         =   0   'False
      Height          =   465
      Left            =   7605
      TabIndex        =   21
      Top             =   90
      Width           =   2985
      Begin VB.OptionButton Option5 
         Caption         =   "Por certificacion"
         Height          =   195
         Left            =   1395
         TabIndex        =   23
         Top             =   225
         Width           =   1455
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Por cantidad"
         Height          =   195
         Left            =   45
         TabIndex        =   22
         Top             =   225
         Width           =   1320
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Buscar Orden de compra"
      Height          =   405
      Index           =   2
      Left            =   45
      TabIndex        =   9
      Top             =   4140
      Width           =   1980
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
      Left            =   8100
      TabIndex        =   14
      Top             =   630
      Width           =   2490
   End
   Begin VB.Frame Frame1 
      Caption         =   "Tomar la descripcion de : "
      Height          =   735
      Left            =   6660
      TabIndex        =   10
      Top             =   1440
      Width           =   3930
      Begin VB.OptionButton Option3 
         Caption         =   "Material mas observaciones"
         Height          =   420
         Left            =   2520
         TabIndex        =   13
         Top             =   225
         Width           =   1365
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Solo el material"
         Height          =   420
         Left            =   180
         TabIndex        =   12
         Top             =   225
         Width           =   915
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Solo las observaciones"
         Height          =   420
         Left            =   1170
         TabIndex        =   11
         Top             =   225
         Width           =   1365
      End
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
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2070
      TabIndex        =   3
      Top             =   1455
      Width           =   1095
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1080
      TabIndex        =   8
      Top             =   3645
      Width           =   945
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   45
      TabIndex        =   7
      Top             =   3150
      Width           =   1980
   End
   Begin VB.TextBox txtPorcentajeCertificacion 
      Alignment       =   1  'Right Justify
      DataField       =   "PorcentajeCertificacion"
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
      Left            =   2070
      TabIndex        =   5
      Top             =   1890
      Visible         =   0   'False
      Width           =   735
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
      Left            =   2070
      TabIndex        =   0
      Top             =   135
      Width           =   645
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   2070
      TabIndex        =   2
      Tag             =   "Articulos"
      Top             =   1035
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
      Left            =   3195
      TabIndex        =   4
      Tag             =   "Unidades"
      Top             =   1455
      Width           =   2310
      _ExtentX        =   4075
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1275
      Left            =   2070
      TabIndex        =   6
      Top             =   3330
      Width           =   6315
      _ExtentX        =   11139
      _ExtentY        =   2249
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmDetRemitos.frx":076A
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdDetalleOrdenCompra"
      Height          =   1935
      Index           =   2
      Left            =   45
      TabIndex        =   27
      Tag             =   "ItemsARemitir"
      Top             =   4905
      Width           =   10590
      _ExtentX        =   18680
      _ExtentY        =   3413
      _Version        =   393216
      Style           =   1
      ListField       =   "Titulo"
      BoundColumn     =   "IdDetalleOrdenCompra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUbicacion"
      Height          =   315
      Index           =   3
      Left            =   2070
      TabIndex        =   30
      Tag             =   "Ubicaciones"
      Top             =   2295
      Width           =   5235
      _ExtentX        =   9234
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUbicacion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   4
      Left            =   8190
      TabIndex        =   31
      Tag             =   "Obras"
      Top             =   2295
      Width           =   2445
      _ExtentX        =   4313
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   5
      Left            =   8730
      TabIndex        =   42
      Tag             =   "Partida"
      Top             =   4635
      Visible         =   0   'False
      Width           =   1140
      _ExtentX        =   2011
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "Partida"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Color :"
      Height          =   255
      Index           =   10
      Left            =   90
      TabIndex        =   46
      Top             =   2745
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblColor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   300
      Left            =   2070
      TabIndex        =   45
      Top             =   2700
      Visible         =   0   'False
      Width           =   5235
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro.Caja:"
      Height          =   300
      Index           =   9
      Left            =   4995
      TabIndex        =   44
      Top             =   1890
      Visible         =   0   'False
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "Stock actual :"
      Height          =   300
      Index           =   8
      Left            =   5580
      TabIndex        =   41
      Top             =   135
      Width           =   1005
   End
   Begin VB.Label lblLabels 
      Caption         =   "Partida :"
      Height          =   300
      Index           =   6
      Left            =   2970
      TabIndex        =   36
      Top             =   1890
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obra :"
      Height          =   255
      Index           =   15
      Left            =   7515
      TabIndex        =   33
      Top             =   2340
      Width           =   510
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ubicacion :"
      Height          =   255
      Index           =   16
      Left            =   90
      TabIndex        =   32
      Top             =   2340
      Width           =   1815
   End
   Begin VB.Label Label1 
      Caption         =   "Items de ordenes de compra pendientes :"
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
      Left            =   45
      TabIndex        =   28
      Top             =   4680
      Width           =   3615
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de articulo :"
      Height          =   300
      Index           =   4
      Left            =   90
      TabIndex        =   26
      Top             =   630
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Orden compra :"
      Height          =   300
      Index           =   3
      Left            =   2925
      TabIndex        =   25
      Top             =   135
      Width           =   1140
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
      Height          =   300
      Index           =   14
      Left            =   7200
      TabIndex        =   20
      Top             =   675
      Width           =   825
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   210
      Index           =   5
      Left            =   2115
      TabIndex        =   19
      Top             =   3150
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   90
      TabIndex        =   18
      Top             =   1455
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   255
      Index           =   2
      Left            =   90
      TabIndex        =   17
      Top             =   1080
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Porc. de certificacion :"
      Height          =   300
      Index           =   0
      Left            =   90
      TabIndex        =   16
      Top             =   1890
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de item :"
      Height          =   300
      Index           =   1
      Left            =   90
      TabIndex        =   15
      Top             =   135
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetRemitos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetRemito
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oRemito As ComPronto.Remito
Public Aceptado As Boolean
Private mvarIdUnidadCU As Integer, mTipoIva As Integer, mCondicionIva As Integer
Private mNumeroItem As Integer
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long, mIdCondicionVenta As Long, mIdObraDefault As Long
Private mvarCantidadAdicional As Double, mvarCantidadUnidades As Double
Private mPorcentajeIVA As Double, mvarP_IVA1 As Double, mvarP_IVA2 As Double
Private mvarPathAdjuntos As String, mDescargaPorKit As String
Private mFechaEntrega As Date, mvarFechaComprobante As Date
Private mvarRegistrarStock As Boolean, mvarMostrarStockObra As Boolean

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim dc As DataCombo
         Dim i As Integer, mOk As Integer
         Dim oRs As ADOR.Recordset
         Dim mvarStock As Double, mvarStock1 As Double, mvarStock2 As Double, mvarCantidad As Double
         Dim mObs As String, mvarAux1 As String, mvarAux2 As String, mvarAux3 As String
      
         For Each dc In DataCombo1
            If (dc.Enabled And dc.Visible) Or dc.Index = 0 Then
               If Len(dc.DataField) > 0 And Not IsNumeric(dc.BoundText) And dc.Index <> 2 Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
               If Len(dc.DataField) > 0 And IsNumeric(dc.BoundText) Then
                  origen.Registro.Fields(dc.DataField).Value = dc.BoundText
               End If
            End If
         Next
      
         If IsNull(origen.Registro.Fields("Cantidad").Value) Or origen.Registro.Fields("Cantidad").Value = 0 Then
            MsgBox "Falta ingresar la cantidad (unidades)", vbCritical
            Exit Sub
         End If
         
         If Len(txtItem.Text) = 0 Or Not IsNumeric(txtItem.Text) Then
            MsgBox "Debe ingresar numero de item", vbCritical
            Exit Sub
         End If
         
         If txtNumeroCaja.Visible And Len(txtNumeroCaja.Text) > 0 Then
            If Not oRemito.DetRemitos.ControlCajas(txtNumeroCaja.Text, origen.Id) Then
               MsgBox "Ya existe este numero de caja en el remito", vbExclamation
               Exit Sub
            End If
         End If
         
         mvarAux2 = BuscarClaveINI("Inhabilitar stock negativo")
         mvarAux3 = BuscarClaveINI("Inhabilitar stock global negativo")
         With origen.Registro
            If DataCombo1(5).Visible Then .Fields("Partida").Value = DataCombo1(5).BoundText
            If IsNull(.Fields("Partida").Value) Then .Fields("Partida").Value = ""
            mvarCantidad = .Fields("Cantidad").Value
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_StockPorArticuloPartidaUnidadUbicacionObra", _
                     Array(.Fields("IdArticulo").Value, IIf(IsNull(.Fields("Partida").Value), "", .Fields("Partida").Value), _
                           .Fields("IdUnidad").Value, IIf(IsNull(.Fields("IdUbicacion").Value), 0, .Fields("IdUbicacion").Value), _
                           .Fields("IdObra").Value))
            If oRs.RecordCount > 0 Then
               mvarStock1 = IIf(IsNull(oRs.Fields("Stock").Value), 0, oRs.Fields("Stock").Value)
            End If
            oRs.Close
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_StockTotalPorArticulo", .Fields("IdArticulo").Value)
            If oRs.RecordCount > 0 Then
               mvarStock2 = IIf(IsNull(oRs.Fields("Stock").Value), 0, oRs.Fields("Stock").Value)
            End If
            oRs.Close
         End With
         mvarStock = 0
         If mvarId > 0 Then
            Set oRs = Aplicacion.TablasGenerales.TraerUno("DetRemitos", mvarId)
            If oRs.RecordCount > 0 Then
               mvarStock = IIf(IsNull(oRs.Fields("Cantidad").Value), 0, oRs.Fields("Cantidad").Value)
            End If
            oRs.Close
         End If
         If mvarRegistrarStock And mvarAux3 <> "SI" And mvarStock1 < mvarCantidad - mvarStock Then
            mvarAux1 = "Stock insuficiente segun datos ingresados :" & vbCrLf & _
                         "cantidad actual en stock para la partida, unidad, ubicacion y obra : " & mvarStock1 & vbCrLf & _
                         "cantidad total actual en stock : " & mvarStock2
            If mvarAux2 = "SI" Then
               MsgBox mvarAux1, vbExclamation, "Sin stock"
               Exit Sub
            Else
               mOk = MsgBox(mvarAux1 & vbCrLf & "Desea continuar igual ?", vbYesNo, "Sin Stock")
               If mOk = vbNo Then Exit Sub
            End If
         End If
         If mvarRegistrarStock And mvarStock2 < mvarCantidad - mvarStock Then
            mvarAux1 = "Stock insuficiente :" & vbCrLf & "cantidad total actual en stock : " & mvarStock2
            If mvarAux2 = "SI" Or mvarAux3 = "SI" Then
               MsgBox mvarAux1, vbExclamation, "Sin stock"
               Exit Sub
            Else
               mOk = MsgBox(mvarAux1 & vbCrLf & "Desea continuar igual ?", vbYesNo, "Sin Stock")
               If mOk = vbNo Then Exit Sub
            End If
         End If
         
         With origen.Registro
            .Fields("Observaciones").Value = Replace(rchObservaciones.Text, Chr(13) + Chr(10) + Chr(13) + Chr(10), " ")
            .Fields("Observaciones").Value = Replace(rchObservaciones.Text, Chr(9), "   ")
            If Option4.Value Then
               .Fields("TipoCancelacion").Value = 1
            Else
               .Fields("TipoCancelacion").Value = 2
            End If
            If Frame3.Visible Then
               If Option6.Value Then
                  .Fields("DescargaPorKit").Value = "NO"
               Else
                  .Fields("DescargaPorKit").Value = "SI"
               End If
            Else
               .Fields("DescargaPorKit").Value = Null
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
      
         Dim oF As frmConsulta1
         Set oF = New frmConsulta1
         With oF
            .IdParametro = oRemito.Registro.Fields("IdCliente").Value
            .Id = 6
            .Show vbModal, Me
         End With

         Unload oF

         Set oF = Nothing
      
      Case 3
         
         Dim of1 As frmConsulta1
         Set of1 = New frmConsulta1
         With of1
            .Id = 1
            .Show vbModal, Me
         End With
         Unload of1
         Set of1 = Nothing
      
   End Select

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim i As Integer
   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim mAux1

   mvarId = vNewValue
   
   mDescargaPorKit = BuscarClaveINI("Mover stock por kit")
   If mDescargaPorKit = "" Then mDescargaPorKit = "NO"
   
   If BuscarClaveINI("Inhabilitar ubicaciones en movimientos de stock") = "SI" Then
      lblLabels(16).Visible = False
      DataCombo1(3).Visible = False
   End If
   
   If BuscarClaveINI("Tabla de colores ampliada") = "SI" Then
      lblLabels(10).Visible = True
      lblColor.Visible = True
   End If
   
   mvarMostrarStockObra = False
   If BuscarClaveINI("Mostrar solo stock de obra en salidas") = "SI" Then mvarMostrarStockObra = True
   
   Set oAp = Aplicacion
   
   Set origen = oRemito.DetRemitos.Item(vNewValue)
   Me.IdNuevo = origen.Id
   
   Set oPar = oAp.Parametros.Item(1)
   With oPar.Registro
      mvarIdUnidadCU = .Fields("IdUnidadPorUnidad").Value
      mvarPathAdjuntos = .Fields("PathAdjuntos").Value
      mvarP_IVA1 = .Fields("Iva1").Value
      mvarP_IVA2 = .Fields("Iva2").Value
   End With
   Set oPar = Nothing
   
   mAux1 = TraerValorParametro2("IdObraDefault")
   mIdObraDefault = IIf(IsNull(mAux1), 0, mAux1)
   
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
            If Len(oControl.DataField) Then .Add oControl, "value", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "ItemsARemitir" Then
                  If Not IsNull(oRemito.Registro.Fields("IdCliente").Value) Then
                     Set oControl.RowSource = oAp.OrdenesCompra.TraerFiltrado("_ItemsPendientesDeRemitirPorIdClienteParaCombo", Array(oRemito.Registro.Fields("IdCliente").Value, "R"))
                  End If
               ElseIf oControl.Tag = "Obras" Then
                  If glbSeñal1 Then
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", Me.FechaComprobante))
                  Else
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo")
                  End If
               ElseIf oControl.Tag = "Ubicaciones" Then
                  If glbUsarPartidasParaStock And mvarId <= 0 Then
                  Else
                     Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
                  End If
               ElseIf oControl.Tag = "Partida" Then
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
         .Fields("NumeroItem").Value = oRemito.DetRemitos.CantidadRegistros
         If mIdObraDefault > 0 Then
            .Fields("IdObra").Value = mIdObraDefault
            DataCombo1(4).Enabled = False
         End If
      End With
      Option1.Value = True
      If mDescargaPorKit = "SI" Then Option6.Value = True
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
         If mDescargaPorKit = "SI" Then
            If IIf(IsNull(.Fields("DescargaPorKit").Value), "NO", .Fields("DescargaPorKit").Value) = "NO" Then
               Option6.Value = True
            Else
               Option7.Value = True
            End If
         End If
         Set oRs = oAp.Articulos.TraerFiltrado("_PorId", .Fields("IdArticulo").Value)
         If oRs.RecordCount > 0 Then
            txtCodigoArticulo.Text = oRs.Fields("Codigo").Value
         End If
         oRs.Close
         MostrarOrdenCompra
         txtItem.Text = .Fields("NumeroItem").Value
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
         If mvarId < 0 And mIdObraDefault > 0 Then
            .Fields("IdObra").Value = mIdObraDefault
            DataCombo1(4).Enabled = False
         End If
         If IIf(IsNull(.Fields("NumeroCaja").Value), 0, .Fields("NumeroCaja").Value) <> 0 Then
            DataCombo1(0).Enabled = False
            DataCombo1(1).Enabled = False
            DataCombo1(3).Enabled = False
            txtPartida.Enabled = False
            txtCantidad.Enabled = False
            txtCodigoArticulo.Enabled = False
            txtNumeroCaja.Enabled = False
            MostrarColor
         End If
      End With
   End If
   
   If glbUsarPartidasParaStock Then
      lblLabels(9).Visible = True
      txtNumeroCaja.Visible = True
      If mvarId <= 0 Then
         With DataCombo1(5)
            .Left = txtPartida.Left
            .Top = txtPartida.Top
            .Visible = True
         End With
         txtPartida.Visible = False
      End If
   End If
   
   If IsNull(oRemito.Registro.Fields("IdCliente").Value) Then
      cmd(2).Enabled = False
      DataCombo1(2).Enabled = False
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   If mDescargaPorKit = "NO" Then Frame3.Visible = False

   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then
      DataCombo1(0).Enabled = False
   End If
   
End Property

Public Property Get Remito() As ComPronto.Remito

   Set Remito = oRemito

End Property

Public Property Set Remito(ByVal vNewValue As ComPronto.Remito)

   Set oRemito = vNewValue

End Property

Private Sub cmdBorrarObservaciones_Click()

   rchObservaciones.Text = ""
   
End Sub

Private Sub DataCombo1_Change(Index As Integer)

   Select Case Index
      Case 1
         If IsNumeric(DataCombo1(Index).BoundText) Then
            Dim oRs As ADOR.Recordset
            Dim mPartida As String
            
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(1).BoundText)
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                     .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                  Else
                     .Fields("IdUnidad").Value = mvarIdUnidadCU
                  End If
                  If IsNull(.Fields("IdUbicacion").Value) Then
                     .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacionStandar").Value
                  End If
                  If mvarId = -1 Then
                     If IsNull(.Fields("Observaciones").Value) Then
                        .Fields("Observaciones").Value = Aplicacion.Articulos.Item(DataCombo1(1).BoundText).CadenaSubitems
                     Else
                        .Fields("Observaciones").Value = .Fields("Observaciones").Value & vbCrLf & Aplicacion.Articulos.Item(DataCombo1(1).BoundText).CadenaSubitems
                     End If
                  End If
               End With
               
               If Not IsNull(oRs.Fields("IdCuantificacion").Value) Then
                  If Not IsNull(oRs.Fields("Unidad11").Value) Then
'                     txtUnidad.Text = Aplicacion.Unidades.Item(oRs.Fields("Unidad11").Value).Registro.Fields("Descripcion").Value
                  End If
               End If
               
               mvarRegistrarStock = True
               If Not IsNull(oRs.Fields("RegistrarStock").Value) And oRs.Fields("RegistrarStock").Value = "NO" Then
                  mvarRegistrarStock = False
               End If
               
               txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
               MostrarStockActual
            End If
            oRs.Close
            
            If mDescargaPorKit = "SI" Then
               Set oRs = Aplicacion.Conjuntos.TraerFiltrado("_DetallesPorIdArticulo", DataCombo1(1).BoundText)
               If oRs.RecordCount > 0 Then
                  Frame3.Enabled = True
               Else
                  Option6.Value = True
                  Frame3.Enabled = False
               End If
               oRs.Close
            End If
            
            If glbUsarPartidasParaStock And mvarId <= 0 Then
               Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PartidasDisponibles", DataCombo1(1).BoundText)
               Set DataCombo1(5).RowSource = oRs
               mPartida = ""
               If Not IsNull(origen.Registro.Fields("Partida").Value) Then
                  mPartida = origen.Registro.Fields("Partida").Value
               Else
                  If oRs.RecordCount = 1 Then mPartida = oRs.Fields("Partida").Value
               End If
               DataCombo1(5).BoundText = mPartida
               If oRs.RecordCount = 0 Then Set DataCombo1(3).RowSource = Aplicacion.Ubicaciones.TraerLista
            End If
            
            Set oRs = Nothing
         End If

      Case 2
         If IsNumeric(DataCombo1(Index).BoundText) Then
            origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
            CargarDatosDesdeItemOrdenCompra DataCombo1(Index).BoundText
         End If
            
      Case 4
         If IsNumeric(DataCombo1(Index).BoundText) Then
            MostrarStockActual
         End If
            
      Case 5
         If glbUsarPartidasParaStock And mvarId <= 0 And Len(DataCombo1(Index).BoundText) > 0 Then
            Dim mIdUbicacion As Long
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PartidasDisponibles", Array(DataCombo1(1).BoundText, DataCombo1(Index).BoundText))
            Set DataCombo1(3).RowSource = oRs
            mIdUbicacion = 0
            If Not IsNull(origen.Registro.Fields("IdUbicacion").Value) Then
               mIdUbicacion = origen.Registro.Fields("IdUbicacion").Value
            End If
            If oRs.RecordCount = 1 Then mIdUbicacion = oRs.Fields("IdUbicacion").Value
            DataCombo1(3).BoundText = mIdUbicacion
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

Private Sub Form_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String, mExiste As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, mvarNumeroRequerimiento As Long
   Dim i As Integer
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
      
      If InStr(1, Filas(0), "Item") <> 0 Then
         Columnas = Split(Filas(1), vbTab)
         CargarDatosDesdeItemOrdenCompra Columnas(0)
      ElseIf Columnas(1) = "Stock" Then
         Columnas = Split(Filas(1), vbTab)
         Set oRs = Aplicacion.Articulos.TraerFiltrado("_Stock", Columnas(0))
         If oRs.RecordCount > 0 Then
            With origen.Registro
               .Fields("Cantidad").Value = 0
               .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
               .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
               .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacion").Value
            End With
            DataCombo1(0).BoundText = oRs.Fields("IdUnidad").Value
         End If
         oRs.Close
      Else
         MsgBox "Objeto invalido!" & vbCrLf & "Solo puede copiar items de ordenes de compra", vbCritical
         Exit Sub
      End If
      
      Clipboard.Clear
      
      MostrarColor
      
   End If

End Sub

Private Sub Form_OLEDragOver(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

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

Private Sub Form_Unload(Cancel As Integer)

   Set oBind = Nothing
   Set origen = Nothing
   Set oRemito = Nothing

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
'      txtCantidad.Enabled = True
   End If
   
End Sub

Private Sub Option5_Click()

   If Option5.Value Then
'      With txtCantidad
'         .Text = 1
'         .Enabled = False
'      End With
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
'      If oRemito.DetRemitos.ItemExistente(txtItem.Text) Then
'         MsgBox "El item ya existe en el Remito, ingrese otro numero.", vbCritical
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

Private Sub txtNumeroCaja_GotFocus()

   With txtNumeroCaja
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroCaja_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroCaja_Validate(Cancel As Boolean)

   If Len(txtNumeroCaja.Text) = 0 Then
      origen.Registro.Fields(txtNumeroCaja.DataField).Value = Null
      DataCombo1(1).Enabled = True
      DataCombo1(3).Enabled = True
      If DataCombo1(5).Visible Then DataCombo1(5).Enabled = True
      txtPartida.Enabled = True
      txtCantidad.Enabled = True
      txtCodigoArticulo.Enabled = True
   Else
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorNumeroCaja", txtNumeroCaja.Text)
      If oRs.RecordCount > 0 Then
         With origen.Registro
            .Fields("IdArticulo").Value = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
            .Fields("IdUnidad").Value = IIf(IsNull(oRs.Fields("IdUnidad").Value), 0, oRs.Fields("IdUnidad").Value)
            .Fields("Cantidad").Value = IIf(IsNull(oRs.Fields("CantidadUnidades").Value), 0, oRs.Fields("CantidadUnidades").Value)
            .Fields("IdUbicacion").Value = IIf(IsNull(oRs.Fields("IdUbicacion").Value), 0, oRs.Fields("IdUbicacion").Value)
            .Fields("Partida").Value = IIf(IsNull(oRs.Fields("Partida").Value), "", oRs.Fields("Partida").Value)
            If DataCombo1(5).Visible Then DataCombo1(5).BoundText = IIf(IsNull(oRs.Fields("Partida").Value), "", oRs.Fields("Partida").Value)
            lblColor.Caption = IIf(IsNull(oRs.Fields("Color").Value), "", oRs.Fields("Color").Value)
         End With
         DataCombo1(0).Enabled = False
         DataCombo1(1).Enabled = False
         DataCombo1(3).Enabled = False
         If DataCombo1(5).Visible Then DataCombo1(5).Enabled = False
         txtPartida.Enabled = False
         txtCantidad.Enabled = False
         txtCodigoArticulo.Enabled = False
      Else
         MsgBox "Caja inexistente en stock", vbCritical
         Cancel = True
      End If
      oRs.Close
      Set oRs = Nothing
   End If

End Sub

Public Sub MostrarOrdenCompra()

   Dim oRs As ADOR.Recordset
   If Not IsNull(origen.Registro.Fields("IdDetalleOrdenCompra").Value) Then
      Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_DetallePorIdDetalle", origen.Registro.Fields("IdDetalleOrdenCompra").Value)
      If oRs.RecordCount > 0 Then
         txtOrdenCompra.Text = oRs.Fields("NumeroOrdenCompra").Value
         Me.IdCondicionVenta = oRs.Fields("IdCondicionVenta").Value
      End If
      oRs.Close
      Set oRs = Nothing
      DataCombo1(2).BoundText = origen.Registro.Fields("IdDetalleOrdenCompra").Value
   End If

End Sub

Public Sub CargarDatosDesdeItemOrdenCompra(ByVal IdDetalleOrdenCompra As Long)

   Dim oRs As ADOR.Recordset
   
   'Set oRs = oRemito.DetRemitos.Registros
   Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_DetallePorIdDetalle", IdDetalleOrdenCompra)
   
   With origen.Registro
      If mvarId = -1 Then
         '.Fields("NumeroItem").Value = oRs.Fields("NumeroItem").Value
         .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
         .Fields("Cantidad").Value = IIf(IsNull(oRs.Fields("PendienteRemitir").Value), 0, oRs.Fields("PendienteRemitir").Value)
         .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
         .Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
         If mIdObraDefault = 0 Then .Fields("IdObra").Value = oRs.Fields("IdObra").Value
      End If
      .Fields("Precio").Value = oRs.Fields("Precio").Value
      .Fields("OrigenDescripcion").Value = oRs.Fields("OrigenDescripcion").Value
      .Fields("IdDetalleOrdenCompra").Value = oRs.Fields("IdDetalleOrdenCompra").Value
      .Fields("TipoCancelacion").Value = oRs.Fields("TipoCancelacion").Value
      txtItem.Text = 1
      If Not IsNull(oRs.Fields("OrigenDescripcion").Value) Then
         Select Case oRs.Fields("OrigenDescripcion").Value
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
      If oRs.Fields("TipoCancelacion").Value = 1 Then
         Option4.Value = True
      Else
         Option5.Value = True
      End If
      oRemito.Registro.Fields("IdListaPrecios").Value = oRs.Fields("IdListaPrecios").Value
      MostrarOrdenCompra
      MostrarColor
   End With
   
   oRs.Close
   Set oRs = Nothing
   
End Sub

Public Property Get IdCondicionVenta() As Long

   IdCondicionVenta = mIdCondicionVenta
   
End Property

Public Property Let IdCondicionVenta(ByVal vNewValue As Long)

   mIdCondicionVenta = vNewValue
   
End Property

Public Property Get NumeroItem() As Integer

   NumeroItem = mNumeroItem
   
End Property

Public Property Let NumeroItem(ByVal vNewValue As Integer)

   mNumeroItem = vNewValue
   
End Property

Public Property Get FechaComprobante() As Date

   FechaComprobante = mvarFechaComprobante

End Property

Public Property Let FechaComprobante(ByVal vNewValue As Date)

   mvarFechaComprobante = vNewValue
   
End Property

Public Sub MostrarStockActual()

   If IsNumeric(DataCombo1(1).BoundText) Then
      If mvarMostrarStockObra And IsNumeric(DataCombo1(4).BoundText) Then
         txtStockActual.Text = Aplicacion.StockPorIdArticuloIdObra(DataCombo1(1).BoundText, DataCombo1(4).BoundText)
      Else
         txtStockActual.Text = Aplicacion.StockPorIdArticulo(DataCombo1(1).BoundText)
      End If
   End If

End Sub

Public Sub MostrarColor()

   Dim oRs As ADOR.Recordset
   
   If Len(txtNumeroCaja.Text) > 0 Then
      Set oRs = Aplicacion.UnidadesEmpaque.TraerFiltrado("_PorNumero", txtNumeroCaja.Text)
      If oRs.RecordCount > 0 Then
         lblColor.Caption = IIf(IsNull(oRs.Fields("Color").Value), "", oRs.Fields("Color").Value)
      End If
      oRs.Close
   ElseIf Not IsNull(origen.Registro.Fields("IdDetalleOrdenCompra").Value) Then
      Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_DetallePorIdDetalle", origen.Registro.Fields("IdDetalleOrdenCompra").Value)
      If oRs.RecordCount > 0 Then
         lblColor.Caption = IIf(IsNull(oRs.Fields("Color").Value), "", oRs.Fields("Color").Value)
      End If
      oRs.Close
   End If
      
   Set oRs = Nothing

End Sub
