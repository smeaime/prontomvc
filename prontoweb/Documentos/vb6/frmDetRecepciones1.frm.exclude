VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{BE38695A-739A-4A6C-BF54-931FC1415984}#1.0#0"; "VividThumbNails.ocx"
Begin VB.Form frmDetRecepciones1 
   Caption         =   "Item de recepcion de materiales"
   ClientHeight    =   5640
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9525
   LinkTopic       =   "Form1"
   ScaleHeight     =   5640
   ScaleWidth      =   9525
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   3060
      TabIndex        =   13
      Top             =   5145
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   4995
      TabIndex        =   12
      Top             =   5145
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
      Left            =   6795
      TabIndex        =   11
      Top             =   1410
      Width           =   2625
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
      Height          =   315
      Left            =   6435
      TabIndex        =   10
      Top             =   2175
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
      Height          =   315
      Left            =   2115
      TabIndex        =   9
      Top             =   2175
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
      Height          =   315
      Left            =   5130
      TabIndex        =   8
      Top             =   2175
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
      Left            =   2115
      Locked          =   -1  'True
      TabIndex        =   7
      Top             =   150
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
      Left            =   5265
      Locked          =   -1  'True
      TabIndex        =   6
      Top             =   135
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
      Left            =   7335
      TabIndex        =   5
      Top             =   2175
      Width           =   2085
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
      Left            =   5265
      Locked          =   -1  'True
      TabIndex        =   4
      Top             =   495
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
      Left            =   2115
      Locked          =   -1  'True
      TabIndex        =   3
      Top             =   510
      Width           =   1185
   End
   Begin VB.TextBox txtRecibido 
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
      Left            =   8235
      Locked          =   -1  'True
      TabIndex        =   2
      Top             =   495
      Width           =   1185
   End
   Begin VB.TextBox txtRequerido 
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
      Left            =   8235
      Locked          =   -1  'True
      TabIndex        =   1
      Top             =   135
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
      Height          =   315
      Left            =   2115
      TabIndex        =   0
      Top             =   1440
      Width           =   1545
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   2115
      TabIndex        =   14
      Tag             =   "Articulos"
      Top             =   1800
      Width           =   7305
      _ExtentX        =   12885
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
      Left            =   3015
      TabIndex        =   15
      Tag             =   "Unidades"
      Top             =   2175
      Width           =   2040
      _ExtentX        =   3598
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdControlCalidad"
      Height          =   315
      Index           =   4
      Left            =   2115
      TabIndex        =   16
      Tag             =   "ControlesCalidad"
      Top             =   2850
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
      Left            =   2115
      TabIndex        =   17
      Top             =   3915
      Width           =   7305
      _ExtentX        =   12885
      _ExtentY        =   2011
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmDetRecepciones1.frx":0000
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUbicacion"
      Height          =   315
      Index           =   2
      Left            =   2115
      TabIndex        =   18
      Tag             =   "Ubicaciones"
      Top             =   3195
      Width           =   4425
      _ExtentX        =   7805
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUbicacion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdDetalleObraDestino"
      Height          =   315
      Index           =   5
      Left            =   7560
      TabIndex        =   19
      Tag             =   "ObraDestinos"
      Top             =   3195
      Width           =   1860
      _ExtentX        =   3281
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdDetalleObraDestino"
      Text            =   ""
   End
   Begin VividThumbNails.VividThumbs VividThumbs1 
      Height          =   4875
      Left            =   9540
      TabIndex        =   35
      Top             =   135
      Width           =   1995
      _ExtentX        =   3519
      _ExtentY        =   8599
      tWidth          =   40
   End
   Begin VB.Label lblLabels 
      Caption         =   "Control de calidad :"
      Height          =   300
      Index           =   11
      Left            =   135
      TabIndex        =   34
      Top             =   2850
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   255
      Index           =   2
      Left            =   135
      TabIndex        =   33
      Top             =   1845
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   255
      Index           =   7
      Left            =   135
      TabIndex        =   32
      Top             =   2190
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
      Height          =   210
      Index           =   14
      Left            =   6795
      TabIndex        =   31
      Top             =   1215
      Width           =   735
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
      Left            =   6075
      TabIndex        =   30
      Top             =   2220
      Width           =   285
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de pedido :"
      Height          =   345
      Index           =   0
      Left            =   135
      TabIndex        =   29
      Top             =   150
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item de ped. :"
      Height          =   345
      Index           =   4
      Left            =   4050
      TabIndex        =   28
      Top             =   150
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item de RM :"
      Height          =   345
      Index           =   3
      Left            =   4050
      TabIndex        =   27
      Top             =   510
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de RM :"
      Height          =   345
      Index           =   5
      Left            =   135
      TabIndex        =   26
      Top             =   510
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   6
      Left            =   135
      TabIndex        =   25
      Top             =   3960
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ya recibido :"
      Height          =   300
      Index           =   12
      Left            =   6795
      TabIndex        =   24
      Top             =   540
      Width           =   1365
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cant. requerida :"
      Height          =   300
      Index           =   13
      Left            =   6795
      TabIndex        =   23
      Top             =   180
      Width           =   1365
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ubicacion :"
      Height          =   255
      Index           =   16
      Left            =   135
      TabIndex        =   22
      Top             =   3240
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de articulo :"
      Height          =   300
      Index           =   17
      Left            =   135
      TabIndex        =   21
      Top             =   1440
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Etapa/Item :"
      Height          =   255
      Index           =   22
      Left            =   6615
      TabIndex        =   20
      Top             =   3240
      Width           =   870
   End
End
Attribute VB_Name = "frmDetRecepciones1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetRecepcion
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oRecepcion As ComPronto.Recepcion
Private mvarIdUnidadCU As Integer
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long, mvarIdMonedaPesos As Long
Private mvarIdMonedaDolar As Long, mvarIdControlCalidadStandar As Long, mvarAnchoForm As Long
Private mvarCantidadAdicional As Double, mvarCantidadUnidades As Double
Private mvarRecepcionDesdeSalida As Boolean, mvarImagenes As Boolean
Private mvarMostrarCosto As String

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Dim dc As DataCombo
      
         For Each dc In DataCombo1
            If (dc.Enabled And dc.Visible) Or dc.Index = 0 Then
               If Not IsNumeric(dc.BoundText) And dc.Index <> 2 Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
               If IsNumeric(dc.BoundText) Then
                  origen.Registro.Fields(dc.DataField).Value = dc.BoundText
               End If
            End If
         Next
         
         mvarCantidadAdicional = 0
         
         If IsNull(origen.Registro.Fields("Cantidad").Value) Or origen.Registro.Fields("Cantidad").Value = 0 Then
            MsgBox "Falta ingresar la cantidad (unidades)", vbCritical
            Exit Sub
         End If
         
         If txtCantidad1.Visible Then
            If IsNull(origen.Registro.Fields("Cantidad1").Value) Or origen.Registro.Fields("Cantidad1").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 1)", vbCritical
               Exit Sub
            End If
            mvarCantidadAdicional = Val(txtCantidad1.Text)
         End If
         
         If txtCantidad2.Visible Then
            If IsNull(origen.Registro.Fields("Cantidad2").Value) Or origen.Registro.Fields("Cantidad2").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 2)", vbCritical
               Exit Sub
            End If
            mvarCantidadAdicional = Val(txtCantidad1.Text) * Val(txtCantidad2.Text)
         End If
         
         mvarCantidadUnidades = origen.Registro.Fields("Cantidad").Value
         
         With origen.Registro
            If IsNull(.Fields("Partida").Value) Then .Fields("Partida").Value = ""
            .Fields("CantidadCC").Value = 0
            .Fields("Cantidad1CC").Value = 0
            .Fields("Cantidad2CC").Value = 0
            .Fields("CantidadAdicionalCC").Value = 0
            .Fields("CantidadRechazadaCC").Value = 0
            If Not IsNull(.Fields("IdControlCalidad").Value) Then
               If Aplicacion.ControlesCalidad.Item(.Fields("IdControlCalidad").Value).Registro.Fields("Inspeccion").Value <> "SI" Then
                  .Fields("Controlado").Value = "DI"
                  .Fields("CantidadCC").Value = .Fields("Cantidad").Value
                  .Fields("Cantidad1CC").Value = .Fields("Cantidad1").Value
                  .Fields("Cantidad2CC").Value = .Fields("Cantidad2").Value
                  .Fields("CantidadAdicionalCC").Value = .Fields("CantidadAdicional").Value
               End If
            Else
               .Fields("Controlado").Value = "DI"
               .Fields("CantidadCC").Value = .Fields("Cantidad").Value
               .Fields("Cantidad1CC").Value = .Fields("Cantidad1").Value
               .Fields("Cantidad2CC").Value = .Fields("Cantidad2").Value
               .Fields("CantidadAdicionalCC").Value = .Fields("CantidadAdicional").Value
            End If
            .Fields("CantidadAdicional").Value = mvarCantidadAdicional * mvarCantidadUnidades
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
            .Fields("Observaciones").Value = rchObservaciones.Text
         End With
         
         origen.Modificado = True
         Aceptado = True
         
         Me.Hide

      Case 1
         If mvarId = -1 Then origen.Eliminado = True
         Me.Hide
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   Dim mIdReq As Long, mIdPed As Long, mIdAco As Long, mIdObraDefault As Long
   Dim mLimitarUbicaciones As Boolean
   Dim mvarHabilitarCosto As String, mAsignarPartidasAutomaticamente As String
   Dim mAux1

   mvarId = vNewValue
   
   Set oAp = Aplicacion
   
   Set origen = oRecepcion.DetRecepciones.Item(vNewValue)
   Me.IdNuevo = origen.Id
   
   Set oPar = oAp.Parametros.Item(1)
   With oPar.Registro
      mvarIdUnidadCU = .Fields("IdUnidadPorUnidad").Value
      mvarIdMonedaPesos = .Fields("IdMoneda").Value
      mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
      mvarIdControlCalidadStandar = IIf(IsNull(.Fields("IdControlCalidadStandar").Value), 0, .Fields("IdControlCalidadStandar").Value)
   End With
   Set oPar = Nothing
   
   mAux1 = TraerValorParametro2("IdObraDefault")
   mIdObraDefault = IIf(IsNull(mAux1), 0, mAux1)
   
   mAux1 = TraerValorParametro2("AsignarPartidasAutomaticamente")
   mAsignarPartidasAutomaticamente = IIf(IsNull(mAux1), "NO", mAux1)
   
   mvarMostrarCosto = BuscarClaveINI("MostrarCostoEnRecepciones")
   If mvarMostrarCosto = "" Then mvarMostrarCosto = "SI"
   
   If BuscarClaveINI("Inhabilitar ubicaciones en movimientos de stock") = "SI" Then
      lblLabels(16).Visible = False
      DataCombo1(2).Visible = False
   End If
   
   mLimitarUbicaciones = False
   If BuscarClaveINI("Limitar ubicaciones en movimientos de stock") = "SI" Then
      mLimitarUbicaciones = True
   End If
   
   mvarHabilitarCosto = BuscarClaveINI("Habilitar acceso a costo en recepciones")
   
   mvarImagenes = False
   If BuscarClaveINI("Ver imagenes de articulos en salida de materiales") = "SI" Then
      mvarImagenes = True
      VividThumbs1.Visible = True
   End If
   
   mvarAnchoForm = Me.Width
   
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
               If oControl.Tag = "Ubicaciones" And mLimitarUbicaciones And glbIdObraAsignadaUsuario > 0 Then
                  Set oControl.RowSource = oAp.Ubicaciones.TraerFiltrado("_PorObra", glbIdObraAsignadaUsuario)
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      
         If mvarId > 0 And Not glbAdministrador And (TypeOf oControl Is DataCombo Or TypeOf oControl Is TextBox) Then
            oControl.Locked = True
         End If
      Next
   End With
   
   mIdReq = -1
   mIdPed = -1
   mIdAco = -1
   
   If mvarId = -1 Then
      With origen.Registro
         .Fields("IdMoneda").Value = mvarIdMonedaPesos
         .Fields("IdObra").Value = mIdObraDefault
         If mIdObraDefault <> 0 Then DataCombo1(3).Enabled = False
         If glbIdObraAsignadaUsuario > 0 Then .Fields("IdObra").Value = glbIdObraAsignadaUsuario
      End With
   Else
      If mvarId > 0 And Not glbAdministrador Then cmd(0).Enabled = False
      With origen.Registro
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
   End If
   
   If mvarId <= 0 Then
      With origen.Registro
         If mAsignarPartidasAutomaticamente = "SI" Then .Fields("Partida").Value = "S/A"
      End With
   End If
   
   With origen.Registro
      If IsNull(.Fields("IdControlCalidad").Value) Then .Fields("IdControlCalidad").Value = mvarIdControlCalidadStandar
      If Not IsNull(.Fields("IdDetallePedido").Value) Then
         mIdPed = .Fields("IdDetallePedido").Value
         Set oRs = oAp.Pedidos.TraerFiltrado("_DatosPorIdDetalle", .Fields("IdDetallePedido").Value)
         If oRs.RecordCount > 0 Then
            If Not IsNull(oRs.Fields("NumeroPedido").Value) Then
               txtNumeroPedido.Text = oRs.Fields("NumeroPedido").Value
               txtNumeroItemPedido.Text = oRs.Fields("IP").Value
            End If
            If Not IsNull(oRs.Fields("NumeroRequerimiento").Value) Then
               txtNumeroRequerimiento.Text = oRs.Fields("NumeroRequerimiento").Value
               txtNumeroItemRequerimiento.Text = oRs.Fields("IR").Value
            End If
         End If
         oRs.Close
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
   
   Set oRs = oAp.Recepciones.TraerFiltrado("_PendientesPorIdDetalle", Array(mvarId, mIdPed, mIdReq, mIdAco))
   If oRs.RecordCount > 0 Then
      oRs.MoveFirst
      If Not IsNull(oRs.Fields("Cant.Orig.").Value) Then
         txtRequerido.Text = oRs.Fields("Cant.Orig.").Value
      End If
      If Not IsNull(oRs.Fields("Recibido").Value) Then
         txtRecibido.Text = oRs.Fields("Recibido").Value
      End If
   End If
   oRs.Close
         
   Set oRs = Nothing
   Set oAp = Nothing
   
   If glbIdObraAsignadaUsuario > 0 Or mIdObraDefault <> 0 Then DataCombo1(3).Enabled = False
   
   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then DataCombo1(0).Enabled = False
   
End Property

Public Property Get Recepcion() As ComPronto.Recepcion

   Set Recepcion = oRecepcion

End Property

Public Property Set Recepcion(ByVal vNewValue As ComPronto.Recepcion)

   Set oRecepcion = vNewValue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      Dim oRs As ADOR.Recordset
      Select Case Index
         Case 1
            Set oRs = Aplicacion.Articulos.Item(DataCombo1(Index).BoundText).Registro
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  'If IsNull(.Fields("IdUnidad").Value) Then
                     If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                        .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     Else
                        .Fields("IdUnidad").Value = mvarIdUnidadCU
                     End If
                  'End If
                  If IsNull(.Fields("IdUbicacion").Value) And Not Me.RecepcionDesdeSalida Then
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
      
            If mvarImagenes Then
               If CargarImagenesThumbs(DataCombo1(Index).BoundText, Me) = -1 Then
                  Me.Width = mvarAnchoForm * 1.23
               Else
                  Me.Width = mvarAnchoForm
               End If
            End If
      End Select
      Set oRs = Nothing
   End If
      
End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Activate()

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   Set oAp = Aplicacion
   
   If mvarId <> -1 Then
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", origen.Registro.Fields("IdArticulo").Value)
      If oRs.RecordCount > 0 Then
         If Not IsNull(oRs.Fields("IdCuantificacion").Value) Then
            If Not IsNull(oRs.Fields("Unidad11").Value) Then
               txtUnidad.Text = oAp.Unidades.Item(oRs.Fields("Unidad11").Value).Registro.Fields("Descripcion").Value
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
   Set oAp = Nothing

End Sub

Private Sub Form_Load()

   If mvarId <> -1 Then SendKeys "{TAB}", True
   
   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, mvarNumero As Long
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      Set oAp = Aplicacion
      
      If InStr(1, Columnas(LBound(Columnas) + 1), "Pedido") <> 0 Then
'And InStr(1, Columnas(LBound(Columnas) + 1), "Item") <> 0
         Columnas = Split(Filas(1), vbTab)
         Set oRs = oAp.Pedidos.Item(0).DetPedidos.Item(Columnas(0)).Registro
         Set oRs1 = oAp.Pedidos.TraerFiltrado("_DatosPorIdDetalle", oRs.Fields(0).Value)
         mvarNumero = oRs1.Fields("NumeroPedido").Value
         With origen.Registro
            .Fields("Cantidad").Value = 0
            .Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
            .Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
            .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
            .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
            .Fields("IdControlCalidad").Value = oRs.Fields("IdControlCalidad").Value
            .Fields("IdDetallePedido").Value = oRs.Fields(0).Value
            .Fields("IdDetalleAcopios").Value = oRs.Fields("IdDetalleAcopios").Value
            .Fields("IdDetalleRequerimiento").Value = oRs.Fields("IdDetalleRequerimiento").Value
            DataCombo1(0).BoundText = oRs.Fields("IdUnidad").Value
            .Fields("IdObra").Value = oRs1.Fields("IdObra").Value
            .Fields("CostoUnitario").Value = oRs.Fields("Precio").Value
            .Fields("IdMoneda").Value = oRs1.Fields("IdMoneda").Value
            .Fields("CotizacionDolar").Value = oRs1.Fields("CotizacionDolar").Value
            .Fields("CotizacionMoneda").Value = oRs1.Fields("CotizacionMoneda").Value
            .Fields("IdUbicacion").Value = oRs1.Fields("IdUbicacionStandar").Value
         End With
         If oRs1.RecordCount > 0 Then
            If Not IsNull(oRs1.Fields("NumeroPedido").Value) Then
               txtNumeroPedido.Text = oRs1.Fields("NumeroPedido").Value
               txtNumeroItemPedido.Text = oRs1.Fields("IP").Value
            End If
            If Not IsNull(oRs1.Fields("NumeroRequerimiento").Value) Then
               txtNumeroRequerimiento.Text = oRs1.Fields("NumeroRequerimiento").Value
               txtNumeroItemRequerimiento.Text = oRs1.Fields("IR").Value
            End If
         End If
         oRs1.Close
         oRs.Close
      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "Req") <> 0 And InStr(1, Columnas(LBound(Columnas) + 2), "Item") <> 0 Then
         Columnas = Split(Filas(1), vbTab) ' armo un vector con las columnas
         Set oRs = oAp.Requerimientos.Item(0).DetRequerimientos.Item(Columnas(0)).Registro
         mvarNumero = oAp.Requerimientos.Item(oRs.Fields("IdRequerimiento").Value).Registro.Fields("NumeroRequerimiento").Value
         Do While Not oRs.EOF
            With origen.Registro
               .Fields("Cantidad").Value = 0
               .Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
               .Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
               .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
               .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
               .Fields("IdControlCalidad").Value = oRs.Fields("IdControlCalidad").Value
               .Fields("IdDetalleRequerimiento").Value = oRs.Fields(0).Value
               txtNumeroItemRequerimiento.Text = oRs.Fields("NumeroItem").Value
               txtNumeroRequerimiento.Text = mvarNumero
               DataCombo1(0).BoundText = oRs.Fields("IdUnidad").Value
            End With
            oRs.MoveNext
         Loop
         oRs.Close
      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "Aco") <> 0 And InStr(1, Columnas(LBound(Columnas) + 2), "Item") <> 0 Then
         Columnas = Split(Filas(1), vbTab)
         Set oRs = oAp.Acopios.Item(0).DetAcopios.Item(Columnas(0)).Registro
         mvarNumero = oAp.Acopios.Item(oRs.Fields("IdAcopio").Value).Registro.Fields("NumeroAcopio").Value
         Do While Not oRs.EOF
            With origen.Registro
               .Fields("Cantidad").Value = 0
               .Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
               .Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
               .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
               .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
               .Fields("IdControlCalidad").Value = oRs.Fields("IdControlCalidad").Value
               .Fields("IdDetalleAcopios").Value = oRs.Fields(0).Value
               txtNumeroItemRequerimiento.Text = oRs.Fields("NumeroItem").Value
               DataCombo1(0).BoundText = oRs.Fields("IdUnidad").Value
            End With
            oRs.MoveNext
         Loop
         oRs.Close
      Else
         MsgBox "Sólo puede arrastrar aqui detalles de LA, RM o Pedidos"
      End If
      
      Set oRs = Nothing
      Set oAp = Nothing
      
      Clipboard.Clear
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
         Dim oAp As ComPronto.Aplicacion
         Set oAp = Aplicacion
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set DataCombo1(1).RowSource = oAp.Articulos.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set DataCombo1(1).RowSource = oAp.Articulos.TraerLista
         End If
         Set oAp = Nothing
      End If
      DataCombo1(1).SetFocus
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

Private Sub txtCantidad1_GotFocus()

   With txtCantidad1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

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

Public Property Get RecepcionDesdeSalida() As Boolean

   RecepcionDesdeSalida = mvarRecepcionDesdeSalida

End Property

Public Property Let RecepcionDesdeSalida(ByVal vNewValue As Boolean)

   mvarRecepcionDesdeSalida = vNewValue

End Property

Private Sub VividThumbs1_ThumbClick(Filename As String, X As Single, Y As Single)

   If Len(Filename) > 0 Then
      If Not Len(Trim(Dir(Filename))) <> 0 Then
         MsgBox "El archivo indicado no existe!", vbExclamation
         Exit Sub
      End If
      Call ShellExecute(Me.hwnd, "open", Filename, vbNullString, vbNullString, SW_SHOWNORMAL)
   End If

End Sub


