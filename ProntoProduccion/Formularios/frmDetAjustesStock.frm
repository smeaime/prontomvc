VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{BE38695A-739A-4A6C-BF54-931FC1415984}#1.0#0"; "VividThumbNails.ocx"
Begin VB.Form frmDetAjustesStock 
   Caption         =   "Item de ajuste de stock"
   ClientHeight    =   4515
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11085
   LinkTopic       =   "Form1"
   ScaleHeight     =   4515
   ScaleWidth      =   11085
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
      Left            =   10215
      TabIndex        =   31
      Top             =   1350
      Visible         =   0   'False
      Width           =   780
   End
   Begin VB.TextBox txtNumeroSalidaMateriales 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   3825
      TabIndex        =   26
      Top             =   3960
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.TextBox txtNumeroSalidaMateriales2 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   3285
      TabIndex        =   25
      Top             =   3960
      Visible         =   0   'False
      Width           =   510
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
      Left            =   5580
      TabIndex        =   23
      Top             =   135
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
      Left            =   2025
      TabIndex        =   0
      Top             =   135
      Width           =   1545
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
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2025
      TabIndex        =   2
      Top             =   945
      Width           =   1185
   End
   Begin VB.TextBox txtCantidad 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadUnidades"
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
      Left            =   2025
      TabIndex        =   3
      Top             =   1350
      Width           =   870
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   90
      TabIndex        =   9
      Top             =   3465
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   90
      TabIndex        =   8
      Top             =   2925
      Width           =   1485
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
      Left            =   9090
      TabIndex        =   10
      Top             =   90
      Width           =   1905
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
      Left            =   4545
      TabIndex        =   5
      Top             =   1350
      Width           =   870
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
      Left            =   5760
      TabIndex        =   6
      Top             =   1350
      Width           =   870
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
      Left            =   6705
      TabIndex        =   7
      Top             =   1350
      Width           =   1770
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   2025
      TabIndex        =   1
      Tag             =   "Articulos"
      Top             =   540
      Width           =   8970
      _ExtentX        =   15822
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
      Left            =   2925
      TabIndex        =   4
      Tag             =   "Unidades"
      Top             =   1350
      Width           =   1590
      _ExtentX        =   2805
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1770
      Left            =   2025
      TabIndex        =   16
      Top             =   2115
      Width           =   8970
      _ExtentX        =   15822
      _ExtentY        =   3122
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmDetAjustesStock.frx":0000
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUbicacion"
      Height          =   315
      Index           =   2
      Left            =   4320
      TabIndex        =   18
      Tag             =   "Ubicaciones"
      Top             =   945
      Width           =   4155
      _ExtentX        =   7329
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUbicacion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   3
      Left            =   9135
      TabIndex        =   20
      Tag             =   "Obras"
      Top             =   945
      Width           =   1860
      _ExtentX        =   3281
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdDetalleSalidaMateriales"
      Height          =   315
      Index           =   4
      Left            =   6300
      TabIndex        =   29
      Top             =   3960
      Visible         =   0   'False
      Width           =   4695
      _ExtentX        =   8281
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdDetalleSalidaMateriales"
      Text            =   ""
   End
   Begin VividThumbNails.VividThumbs VividThumbs1 
      Height          =   3435
      Left            =   11295
      TabIndex        =   30
      Top             =   90
      Width           =   1995
      _ExtentX        =   3519
      _ExtentY        =   6059
      tWidth          =   40
   End
   Begin VB.Label lblColor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   300
      Left            =   2025
      TabIndex        =   34
      Top             =   1755
      Visible         =   0   'False
      Width           =   5235
   End
   Begin VB.Label lblLabels 
      Caption         =   "Color :"
      Height          =   255
      Index           =   10
      Left            =   90
      TabIndex        =   33
      Top             =   1755
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro.Caja:"
      Height          =   300
      Index           =   9
      Left            =   9450
      TabIndex        =   32
      Top             =   1350
      Visible         =   0   'False
      Width           =   645
   End
   Begin VB.Label lblSalida 
      Caption         =   "Item de salida :"
      Height          =   285
      Index           =   1
      Left            =   5175
      TabIndex        =   28
      Top             =   4005
      Visible         =   0   'False
      Width           =   1065
   End
   Begin VB.Label lblSalida 
      Caption         =   "Nro. de salida :"
      Height          =   285
      Index           =   0
      Left            =   2070
      TabIndex        =   27
      Top             =   4005
      Visible         =   0   'False
      Width           =   1155
   End
   Begin VB.Label lblLabels 
      Caption         =   "Stock actual :"
      Height          =   300
      Index           =   6
      Left            =   4320
      TabIndex        =   24
      Top             =   135
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de articulo :"
      Height          =   300
      Index           =   5
      Left            =   90
      TabIndex        =   22
      Top             =   135
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obra :"
      Height          =   255
      Index           =   4
      Left            =   8550
      TabIndex        =   21
      Top             =   990
      Width           =   510
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ubicacion :"
      Height          =   255
      Index           =   3
      Left            =   3330
      TabIndex        =   19
      Top             =   990
      Width           =   915
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   1
      Left            =   90
      TabIndex        =   17
      Top             =   2160
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
      Height          =   300
      Index           =   14
      Left            =   8235
      TabIndex        =   15
      Top             =   135
      Width           =   825
   End
   Begin VB.Label lblLabels 
      Caption         =   "Partida :"
      Height          =   300
      Index           =   0
      Left            =   90
      TabIndex        =   14
      Top             =   945
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   90
      TabIndex        =   13
      Top             =   1350
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   2
      Left            =   90
      TabIndex        =   12
      Top             =   540
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
      Left            =   5490
      TabIndex        =   11
      Top             =   1395
      Width           =   195
   End
End
Attribute VB_Name = "frmDetAjustesStock"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetAjusteStock
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oAjusteStock As ComPronto.AjusteStock
Private mvarIdUnidad As Integer, mvarIdUnidadCU As Integer
Private mvarImagenes As Boolean
Public mvarCantidadAdicional As Double
Private mvarCantidadUnidades As Double
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long, mObra As Long, mvarAnchoForm As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim dc As DataCombo
         
         For Each dc In DataCombo1
            If (dc.Enabled And dc.Visible) Or dc.Index = 0 Then
               If Not IsNumeric(dc.BoundText) Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
               origen.Registro.Fields(dc.DataField).Value = dc.BoundText
            End If
         Next
      
         If IsNull(origen.Registro.Fields("CantidadUnidades").Value) Or origen.Registro.Fields("CantidadUnidades").Value = 0 Then
            MsgBox "Falta ingresar la cantidad (unidades)", vbCritical
            Exit Sub
         End If
         
         mvarCantidadUnidades = origen.Registro.Fields("CantidadUnidades").Value
         mvarCantidadAdicional = 0
         
         If txtCantidad1.Visible Then
            If IsNull(txtCantidad1.Text) Or Val(txtCantidad1.Text) = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 1)", vbCritical
               Exit Sub
            End If
            mvarCantidadAdicional = Val(txtCantidad1.Text)
         End If
         
         If txtCantidad2.Visible Then
            If IsNull(txtCantidad2.Text) Or Val(txtCantidad2.Text) = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 2)", vbCritical
               Exit Sub
            End If
            mvarCantidadAdicional = Val(txtCantidad1.Text) * Val(txtCantidad2.Text)
         End If
         
         With origen.Registro
'            .Fields("IdUnidad").Value = mvarIdUnidad
            .Fields("CantidadAdicional").Value = mvarCantidadAdicional * mvarCantidadUnidades
            If IsNull(.Fields("Partida").Value) Then
               .Fields("Partida").Value = ""
            End If
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
   
      Case 1
      
         If mvarId = -1 Then
            origen.Eliminado = True
         End If
   
   End Select
   
   Me.Hide

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim dtp As DTPicker
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim mLimitarUbicaciones As Boolean

   If BuscarClaveINI("Inhabilitar ubicaciones en movimientos de stock") = "SI" Then
      lblLabels(3).Visible = False
      DataCombo1(2).Visible = False
   End If
   
   If BuscarClaveINI("Activar stock en transito PRONTOSAT") = "SI" Then
      lblSalida(0).Visible = True
      lblSalida(1).Visible = True
      txtNumeroSalidaMateriales2.Visible = True
      txtNumeroSalidaMateriales.Visible = True
      DataCombo1(4).Visible = True
   End If
   
   mLimitarUbicaciones = False
   If BuscarClaveINI("Limitar ubicaciones en movimientos de stock") = "SI" Then
      mLimitarUbicaciones = True
   End If
   
   mvarImagenes = False
   If BuscarClaveINI("Ver imagenes de articulos en salida de materiales") = "SI" Then
      mvarImagenes = True
      VividThumbs1.Visible = True
   End If
   
   If BuscarClaveINI("Tabla de colores ampliada") = "SI" Then
      lblLabels(10).Visible = True
      lblColor.Visible = True
   End If
   
   If glbUsarPartidasParaStock Then
      lblLabels(9).Visible = True
      txtNumeroCaja.Visible = True
   End If
   
   Set oAp = Aplicacion
   
   mvarId = vNewValue
   
   Set origen = oAjusteStock.DetAjustesStock.Item(vNewValue)
   Me.IdNuevo = origen.Id
   Set oBind = New BindingCollection
   
   Set oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
   If oRs.RecordCount > 0 Then
      mvarIdUnidadCU = IIf(IsNull(oRs.Fields("IdUnidadPorUnidad").Value), 0, oRs.Fields("IdUnidadPorUnidad").Value)
   End If
   oRs.Close
   
   mvarIdUnidad = mvarIdUnidadCU
   mvarCantidadAdicional = 0
   mvarAnchoForm = Me.Width
   
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Obras" Then
                  Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo")
               ElseIf oControl.Tag = "Ubicaciones" And mLimitarUbicaciones And _
                     glbIdObraAsignadaUsuario > 0 Then
                  Set oControl.RowSource = oAp.Ubicaciones.TraerFiltrado("_PorObra", glbIdObraAsignadaUsuario)
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
         .Fields("IdObra").Value = Me.Obra
      End With
   Else
      With origen.Registro
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
         If Not IsNull(.Fields("IdDetalleSalidaMateriales").Value) Then
            Set oRs = Aplicacion.SalidasMateriales.TraerFiltrado("_PorIdDetalle", .Fields("IdDetalleSalidaMateriales").Value)
            If oRs.RecordCount > 0 Then
               txtNumeroSalidaMateriales2.Text = oRs.Fields("NumeroSalidaMateriales2").Value
               txtNumeroSalidaMateriales.Text = oRs.Fields("NumeroSalidaMateriales").Value
            End If
            oRs.Close
            BuscarSalidas
         End If
         If IIf(IsNull(.Fields("NumeroCaja").Value), 0, .Fields("NumeroCaja").Value) <> 0 Then
            DataCombo1(0).Enabled = False
            DataCombo1(1).Enabled = False
            DataCombo1(2).Enabled = False
            txtPartida.Enabled = False
            txtCantidad.Enabled = False
            txtCodigoArticulo.Enabled = False
            txtNumeroCaja.Enabled = False
            MostrarColor
         End If
      End With
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   MostrarColor

   If glbIdObraAsignadaUsuario > 0 Or Me.Obra <> 0 Then DataCombo1(3).Enabled = False
   
   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then
      DataCombo1(0).Enabled = False
   End If
   
End Property

Public Property Get AjusteStock() As ComPronto.AjusteStock

   Set AjusteStock = oAjusteStock

End Property

Public Property Set AjusteStock(ByVal vNewValue As ComPronto.AjusteStock)

   Set oAjusteStock = vNewValue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
         
      Select Case Index
         Case 1
            Dim oRs As ADOR.Recordset
            Dim oRs1 As ADOR.Recordset
            
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(1).BoundText)
         
            If oRs.RecordCount > 0 Then
               Set DataCombo1(0).RowSource = UnidadesHabilitadas(DataCombo1(1).BoundText)
               With origen.Registro
                  If (IsNull(.Fields("IdArticulo").Value) Or _
                         .Fields("IdArticulo").Value <> DataCombo1(1).BoundText) Then
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
                     Set oRs1 = Aplicacion.Unidades.TraerFiltrado("_PorId", oRs.Fields("Unidad11").Value)
                     If oRs1.RecordCount > 0 Then
                        txtUnidad.Text = oRs1.Fields("Descripcion").Value
                     End If
                     oRs1.Close
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
                           origen.Registro.Fields("Cantidad1").Value = oRs.Fields("Largo").Value
                        End If
                     Case 3
                        If mvarId = -1 Then
                           txtCantidad1.Visible = True
                           txtCantidad2.Visible = True
                           Label1(0).Visible = True
                           txtUnidad.Visible = True
                           origen.Registro.Fields("Cantidad1").Value = oRs.Fields("Ancho").Value
                           origen.Registro.Fields("Cantidad2").Value = oRs.Fields("Largo").Value
                        End If
                  End Select
               End If
               txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
               txtStockActual.Text = Aplicacion.StockPorIdArticulo(DataCombo1(1).BoundText)
            End If
            oRs.Close
            Set oRs = Nothing
            Set oRs1 = Nothing
            
            If mvarImagenes Then
               If CargarImagenesThumbs(DataCombo1(Index).BoundText, Me) = -1 Then
                  Me.Width = mvarAnchoForm * 1.2
               Else
                  Me.Width = mvarAnchoForm
               End If
            End If
            
         Case 4
            If Not IsNumeric(DataCombo1(1).BoundText) Then
               Set oRs1 = Aplicacion.SalidasMateriales.TraerFiltrado("_PorIdDetalle", DataCombo1(Index).BoundText)
               If oRs1.RecordCount > 0 Then
                  DataCombo1(1).BoundText = oRs1.Fields("IdArticulo").Value
                  DataCombo1(3).BoundText = oRs1.Fields("IdObra").Value
                  Me.Obra = oRs1.Fields("IdObra").Value
               End If
               oRs1.Close
               Set oRs1 = Nothing
            End If
      End Select
      
   End If
      
End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Activate()

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   
   If mvarId <> -1 And Not IsNull(origen.Registro.Fields("IdArticulo").Value) Then
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", origen.Registro.Fields("IdArticulo").Value)
      If oRs.RecordCount > 0 Then
         If Not IsNull(oRs.Fields("IdCuantificacion").Value) Then
            If Not IsNull(oRs.Fields("Unidad11").Value) Then
               Set oRs1 = Aplicacion.Unidades.TraerFiltrado("_PorId", oRs.Fields("Unidad11").Value)
               If oRs1.RecordCount > 0 Then
                  txtUnidad.Text = oRs1.Fields("Descripcion").Value
               End If
               oRs1.Close
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
   End If
   
   Set oRs = Nothing
   Set oRs1 = Nothing
   
End Sub

Private Sub Form_Load()

 '  DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oBind = Nothing
   Set origen = Nothing
   Set oAjusteStock = Nothing

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

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

Private Sub txtCantidad1_GotFocus()

   With txtCantidad1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCantidad1_Validate(Cancel As Boolean)

   origen.Registro.Fields("Cantidad1").Value = Val(txtCantidad1.Text)

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

Private Sub txtCantidad_GotFocus()
   
   With txtCantidad
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCantidad2_Validate(Cancel As Boolean)

   origen.Registro.Fields("Cantidad2").Value = Val(txtCantidad2.Text)

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
         With origen.Registro
            .Fields("IdArticulo").Value = oRs.Fields(0).Value
            If Not IsNull(oRs.Fields("IdUnidad").Value) Then
               .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
            Else
               .Fields("IdUnidad").Value = mvarIdUnidadCU
            End If
         End With
         txtStockActual.Text = Aplicacion.StockPorIdArticulo(oRs.Fields(0).Value)
      Else
         MsgBox "Codigo de material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo.Text = ""
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
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
      DataCombo1(2).Enabled = True
      If DataCombo1(8).Visible Then DataCombo1(8).Enabled = True
      txtPartida.Enabled = True
      txtCantidad.Enabled = True
      txtCodigoArticulo.Enabled = True
   Else
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.UnidadesEmpaque.TraerFiltrado("_PorNumero", txtNumeroCaja.Text)
      If oRs.RecordCount > 0 Then
         With origen.Registro
            .Fields("IdArticulo").Value = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
            .Fields("IdUnidad").Value = IIf(IsNull(oRs.Fields("IdUnidad").Value), 0, oRs.Fields("IdUnidad").Value)
            .Fields("CantidadUnidades").Value = IIf(IsNull(oRs.Fields("PesoNeto").Value), 0, oRs.Fields("PesoNeto").Value)
            .Fields("IdUbicacion").Value = IIf(IsNull(oRs.Fields("IdUbicacion").Value), 0, oRs.Fields("IdUbicacion").Value)
            .Fields("Partida").Value = IIf(IsNull(oRs.Fields("Partida").Value), "", oRs.Fields("Partida").Value)
            lblColor.Caption = IIf(IsNull(oRs.Fields("Color").Value), "", oRs.Fields("Color").Value)
         End With
         DataCombo1(0).Enabled = False
         DataCombo1(1).Enabled = False
         DataCombo1(2).Enabled = False
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

Private Sub txtNumeroSalidaMateriales_GotFocus()

   With txtNumeroSalidaMateriales
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroSalidaMateriales_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroSalidaMateriales_Validate(Cancel As Boolean)

   If Len(txtNumeroSalidaMateriales2.Text) > 0 And Len(txtNumeroSalidaMateriales.Text) > 0 Then
      BuscarSalidas
   End If

End Sub

Private Sub txtNumeroSalidaMateriales2_GotFocus()

   With txtNumeroSalidaMateriales2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroSalidaMateriales2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroSalidaMateriales2_Validate(Cancel As Boolean)

   If Len(txtNumeroSalidaMateriales2.Text) > 0 And Len(txtNumeroSalidaMateriales.Text) > 0 Then
      BuscarSalidas
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

Public Property Get Obra() As Long

   Obra = mObra

End Property

Public Property Let Obra(ByVal vNewValue As Long)

   mObra = vNewValue

End Property

Public Sub BuscarSalidas()

   Dim mIdDetalleSalidaMateriales As Long
   Dim oRs As ADOR.Recordset
   mIdDetalleSalidaMateriales = 0
   If IsNumeric(DataCombo1(4).BoundText) Then mIdDetalleSalidaMateriales = DataCombo1(4).BoundText
   Set oRs = Aplicacion.SalidasMateriales.TraerFiltrado("_DetallesPorNumero", _
               Array(txtNumeroSalidaMateriales2.Text, txtNumeroSalidaMateriales.Text))
   Set DataCombo1(4).RowSource = oRs
   DataCombo1(4).BoundText = mIdDetalleSalidaMateriales
   If oRs.RecordCount = 0 Then
      MsgBox "Salida inexistente", vbExclamation
   End If
   Set oRs = Nothing

End Sub

Private Sub VividThumbs1_ThumbClick(Filename As String, X As Single, Y As Single)

   If Len(Filename) > 0 Then
      If Not Len(Trim(Dir(Filename))) <> 0 Then
         MsgBox "El archivo indicado no existe!", vbExclamation
         Exit Sub
      End If
      Call ShellExecute(Me.hwnd, "open", Filename, vbNullString, vbNullString, SW_SHOWNORMAL)
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
   End If
      
   Set oRs = Nothing

End Sub
