VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetValesSalida 
   Caption         =   "Item de vale de materiales"
   ClientHeight    =   3390
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9930
   Icon            =   "frmDetValesSalida.frx":0000
   LinkTopic       =   "Form1"
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   3390
   ScaleWidth      =   9930
   StartUpPosition =   2  'CenterScreen
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
      Left            =   7650
      TabIndex        =   26
      Top             =   2700
      Width           =   2220
   End
   Begin VB.TextBox txtCodigoArticulo1 
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
      Height          =   315
      Left            =   2025
      TabIndex        =   7
      Top             =   2340
      Width           =   1725
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
      Top             =   630
      Width           =   1545
   End
   Begin VB.TextBox txtNumeroReserva 
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
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   8595
      TabIndex        =   22
      Top             =   135
      Width           =   870
   End
   Begin VB.TextBox txtNumeroItem 
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
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   4815
      TabIndex        =   21
      Top             =   135
      Width           =   870
   End
   Begin VB.TextBox txtNumeroLMateriales 
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
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   2025
      TabIndex        =   20
      Top             =   135
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
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2025
      TabIndex        =   2
      Top             =   1470
      Width           =   870
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1800
      TabIndex        =   10
      Top             =   2880
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   90
      TabIndex        =   9
      Top             =   2880
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
      Height          =   315
      Left            =   7605
      TabIndex        =   13
      Top             =   675
      Width           =   2220
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
         LCID            =   11274
         SubFormatType   =   1
      EndProperty
      Height          =   315
      Left            =   5355
      TabIndex        =   4
      Top             =   1470
      Width           =   870
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
         LCID            =   11274
         SubFormatType   =   1
      EndProperty
      Height          =   315
      Left            =   6660
      TabIndex        =   5
      Top             =   1470
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
      Left            =   7605
      TabIndex        =   12
      Top             =   1470
      Width           =   2220
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "Ver vales faltantes"
      Height          =   405
      Index           =   2
      Left            =   3510
      TabIndex        =   11
      Top             =   2880
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   2025
      TabIndex        =   1
      Tag             =   "Articulos"
      Top             =   1035
      Width           =   7800
      _ExtentX        =   13758
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
      TabIndex        =   3
      Tag             =   "Unidades"
      Top             =   1470
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCentroCosto"
      Height          =   315
      Index           =   2
      Left            =   2025
      TabIndex        =   6
      Tag             =   "CentrosCosto"
      Top             =   1905
      Visible         =   0   'False
      Width           =   4515
      _ExtentX        =   7964
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCentroCosto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdEquipoDestino"
      Height          =   315
      Index           =   4
      Left            =   3825
      TabIndex        =   8
      Tag             =   "Articulos"
      Top             =   2340
      Width           =   6045
      _ExtentX        =   10663
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Equipo destino (opc.) :"
      Height          =   300
      Index           =   8
      Left            =   90
      TabIndex        =   28
      Top             =   2340
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
      Index           =   5
      Left            =   6705
      TabIndex        =   27
      Top             =   2745
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de articulo :"
      Height          =   300
      Index           =   4
      Left            =   90
      TabIndex        =   25
      Top             =   630
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
      Index           =   14
      Left            =   6660
      TabIndex        =   24
      Top             =   720
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Centro de costo :"
      Height          =   300
      Index           =   6
      Left            =   90
      TabIndex        =   23
      Top             =   1935
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de Reserva :"
      Height          =   300
      Index           =   3
      Left            =   6615
      TabIndex        =   19
      Top             =   150
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item de LM :"
      Height          =   300
      Index           =   1
      Left            =   3600
      TabIndex        =   18
      Top             =   150
      Width           =   1050
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de L.Materiales :"
      Height          =   300
      Index           =   0
      Left            =   90
      TabIndex        =   17
      Top             =   150
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   90
      TabIndex        =   16
      Top             =   1485
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   2
      Left            =   90
      TabIndex        =   15
      Top             =   1035
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
      Left            =   6300
      TabIndex        =   14
      Top             =   1515
      Width           =   285
   End
End
Attribute VB_Name = "frmDetValesSalida"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetValeSalida
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oValeSalida As ComPronto.ValeSalida
Private mvarIdUnidadCU As Integer
Private mvarCantidadUnidades As Double
Public mvarCantidadAdicional As Double, mvarIdUnidad As Integer
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long
Private mvarExigirEquipoDestino As String

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         If mvarExigirEquipoDestino = "SI" And Not IsNumeric(DataCombo1(4).BoundText) Then
            MsgBox "Debe indicar el equipo destino", vbInformation
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim oRs As ADOR.Recordset
         Dim mvarCantidad As Double
         
         For Each dc In DataCombo1
            If dc.Enabled Or dc.Index = 0 Then
               If Len(Trim(dc.BoundText)) = 0 And dc.Index <> 4 And dc.Visible Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
               If IsNumeric(dc.BoundText) Then
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
         
         If txtCantidad1.Visible Then
            If IsNull(origen.Registro.Fields("Cantidad1").Value) Or origen.Registro.Fields("Cantidad1").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 1)", vbCritical
               Exit Sub
            End If
            mvarCantidadAdicional = origen.Registro.Fields("Cantidad1").Value
         End If
         
         If txtCantidad2.Visible Then
            If IsNull(origen.Registro.Fields("Cantidad2").Value) Or origen.Registro.Fields("Cantidad2").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 2)", vbCritical
               Exit Sub
            End If
            mvarCantidadAdicional = origen.Registro.Fields("Cantidad1").Value * origen.Registro.Fields("Cantidad2").Value
         End If
         
         With origen.Registro
'            .Fields("IdUnidad").Value = mvarIdUnidad
            .Fields("CantidadAdicional").Value = mvarCantidadAdicional * mvarCantidadUnidades
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
         
         Dim oF As frmConsultaValesFaltantes
         Set oF = New frmConsultaValesFaltantes
         With oF
            .Obra = oValeSalida.Registro.Fields("IdObra").Value
            .Show vbModal, Me
         End With
         Unload oF
         Set oF = Nothing
      
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim dtp As DTPicker
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset

   Set oAp = Aplicacion
   
   mvarId = vNewValue
   
   Set origen = oValeSalida.DetValesSalida.Item(vNewValue)
   Me.IdNuevo = origen.Id
   
   If glbParametrizacionNivel1 Then
      lblLabels(0).Visible = False
      txtNumeroLMateriales.Visible = False
      lblLabels(1).Visible = False
      txtNumeroItem.Visible = False
      lblLabels(3).Visible = False
      txtNumeroReserva.Visible = False
      cmd(2).Visible = False
   End If
   
   mvarExigirEquipoDestino = BuscarClaveINI("Exigir equipo destino en salida de materiales")
   If mvarExigirEquipoDestino = "" Then mvarExigirEquipoDestino = "NO"
   
   Set oBind = New BindingCollection
   
   Set oPar = oAp.Parametros.Item(1)
   mvarIdUnidadCU = oPar.Registro.Fields("IdUnidadPorUnidad").Value
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
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   End With
   
   If mvarId = -1 Then
      With origen.Registro
         If Not IsNull(ValeSalida.Registro.Fields("IdCentroCosto").Value) Then
            .Fields("IdCentroCosto").Value = ValeSalida.Registro.Fields("IdCentroCosto").Value
         Else
            DataCombo1(2).Enabled = False
         End If
      End With
   Else
      With origen.Registro
         If Not IsNull(.Fields("IdDetalleLMateriales").Value) Then
            Set oRs = oAp.LMateriales.TraerFiltrado("_DesdeDetalle", .Fields("IdDetalleLMateriales").Value)
            txtNumeroLMateriales.Text = oRs.Fields("L.Materiales").Value
            txtNumeroItem.Text = oRs.Fields("Item").Value
            txtNumeroReserva.Text = ""
            oRs.Close
         Else
            If Not IsNull(.Fields("IdDetalleReserva").Value) Then
               Set oRs = Aplicacion.Reservas.TraerFiltrado("_DesdeDetalle", .Fields("IdDetalleReserva").Value)
               txtNumeroLMateriales.Text = ""
               txtNumeroItem.Text = ""
               txtNumeroReserva.Text = oRs.Fields("NumeroReserva").Value
               oRs.Close
            End If
         End If
      End With
   End If
   
   If mvarId > 0 Then
      cmd(0).Enabled = False
   End If
   
   If IsNull(ValeSalida.Registro.Fields("IdObra").Value) Then
      cmd(2).Enabled = False
   Else
      DataCombo1(2).Enabled = False
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then
      DataCombo1(0).Enabled = False
   End If
   
End Property

Public Property Get ValeSalida() As ComPronto.ValeSalida

   Set ValeSalida = oValeSalida

End Property

Public Property Set ValeSalida(ByVal vNewValue As ComPronto.ValeSalida)

   Set oValeSalida = vNewValue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(1).BoundText) Then
         
      Dim oRs As ADOR.Recordset
            
      Select Case Index
         
         Case 1
      
            Me.MousePointer = vbHourglass
            
            Set oRs = Aplicacion.Articulos.Item(DataCombo1(1).BoundText).Registro
         
            If oRs.RecordCount > 0 Then
'               If IsNull(origen.Registro.Fields("IdArticulo").Value) Or _
'                     origen.Registro.Fields("IdArticulo").Value <> DataCombo1(1).BoundText Then
                  If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                     origen.Registro.Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                  Else
                     origen.Registro.Fields("IdUnidad").Value = mvarIdUnidadCU
                  End If
'               End If
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
            End If
            
            oRs.Close
            Set oRs = Nothing
            
            Me.MousePointer = vbDefault
            
         Case 4
      
            If IsNumeric(DataCombo1(Index).BoundText) Then
               origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
               Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
               If oRs.RecordCount > 0 Then
                  txtCodigoArticulo1.Text = IIf(IsNull(oRs.Fields("NumeroInventario").Value), "", oRs.Fields("NumeroInventario").Value)
               End If
               oRs.Close
               Set oRs = Nothing
            End If
   
      End Select
      
   End If
      
End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)

   If Index = 1 And mvarId = -1 Then
      SendKeys "%{DOWN}"
   End If

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Unload(Cancel As Integer)
   
   Set oBind = Nothing
   Set origen = Nothing
   Set oValeSalida = Nothing

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

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long
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
      If Columnas(2) <> "LM" Then
         MsgBox "Informacion invalida!", vbCritical
         Exit Sub
      End If
      
      Columnas = Split(Filas(1), vbTab) ' armo un vector con las columnas
      
      With origen.Registro
         .Fields("Cantidad").Value = 0
         .Fields("Cantidad1").Value = 0
         .Fields("Cantidad2").Value = 0
         .Fields("IdArticulo").Value = Columnas(6)
         If Len(Trim(Columnas(0))) <> 0 Then
            .Fields("IdDetalleLMateriales").Value = Columnas(0)
            .Fields("IdDetalleReserva").Value = Null
            Set oRs = Aplicacion.LMateriales.TraerFiltrado("_DesdeDetalle", Columnas(0))
            txtNumeroLMateriales.Text = oRs.Fields("L.Materiales").Value
            txtNumeroItem.Text = oRs.Fields("Item").Value
            txtNumeroReserva.Text = ""
         Else
            .Fields("IdDetalleReserva").Value = Columnas(1)
            .Fields("IdDetalleLMateriales").Value = Null
            Set oRs = Aplicacion.Reservas.TraerFiltrado("_DesdeDetalle", Columnas(1))
            txtNumeroLMateriales.Text = ""
            txtNumeroItem.Text = ""
            txtNumeroReserva.Text = oRs.Fields("NumeroReserva").Value
         End If
         oRs.Close
      End With
      
      Clipboard.Clear
      
      Set oRs = Nothing
   
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

   origen.Registro.Fields("Cantidad1").Value = txtCantidad1.Text

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

   origen.Registro.Fields("Cantidad2").Value = txtCantidad2.Text

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

Private Sub txtCodigoArticulo1_GotFocus()

   With txtCodigoArticulo1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoArticulo1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoArticulo1_Validate(Cancel As Boolean)

   If Len(txtCodigoArticulo1.Text) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorNumeroInventario", txtCodigoArticulo1.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdEquipoDestino").Value = oRs.Fields(0).Value
      Else
         MsgBox "Numero de inventario del material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo1.Text = ""
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

