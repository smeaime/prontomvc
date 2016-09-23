VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetReservas 
   Caption         =   "Item de reserva de stock"
   ClientHeight    =   3720
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10125
   Icon            =   "frmDetReservas.frx":0000
   LinkTopic       =   "Form1"
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   3720
   ScaleWidth      =   10125
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "Reserva aplicable a : "
      Height          =   645
      Left            =   6435
      TabIndex        =   24
      Top             =   1575
      Visible         =   0   'False
      Width           =   3480
      Begin VB.OptionButton Option1 
         Caption         =   "Por obra"
         Height          =   195
         Left            =   180
         TabIndex        =   26
         Top             =   270
         Width           =   1140
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Por centro de costo"
         Height          =   195
         Left            =   1440
         TabIndex        =   25
         Top             =   270
         Width           =   1860
      End
   End
   Begin VB.TextBox txtCliente 
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
      Left            =   3555
      TabIndex        =   23
      Top             =   1545
      Width           =   2715
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
      TabIndex        =   18
      Top             =   135
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
      TabIndex        =   17
      Top             =   135
      Width           =   1185
   End
   Begin VB.TextBox txtNumeroAcopio 
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
      TabIndex        =   16
      Top             =   540
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.TextBox txtNumeroItemAcopio 
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
      TabIndex        =   15
      Top             =   540
      Visible         =   0   'False
      Width           =   690
   End
   Begin VB.TextBox txtRetirada 
      Alignment       =   1  'Right Justify
      DataField       =   "Retirada"
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
      Left            =   90
      TabIndex        =   13
      Top             =   2970
      Visible         =   0   'False
      Width           =   645
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "Ver stock"
      Height          =   405
      Index           =   2
      Left            =   6075
      TabIndex        =   9
      Top             =   3060
      Width           =   1485
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
      Left            =   7740
      TabIndex        =   6
      Top             =   2325
      Width           =   2175
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
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   6795
      TabIndex        =   5
      Top             =   2325
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
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   5490
      TabIndex        =   4
      Top             =   2325
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
      Height          =   315
      Left            =   8370
      TabIndex        =   1
      Top             =   765
      Width           =   1500
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   2655
      TabIndex        =   7
      Top             =   3060
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   4365
      TabIndex        =   8
      Top             =   3060
      Width           =   1485
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
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2115
      TabIndex        =   2
      Top             =   2340
      Width           =   870
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   2115
      TabIndex        =   0
      Tag             =   "Articulos"
      Top             =   1125
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
      Left            =   3060
      TabIndex        =   3
      Tag             =   "Unidades"
      Top             =   2325
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   2
      Left            =   2115
      TabIndex        =   27
      Tag             =   "Obras"
      Top             =   1530
      Width           =   1410
      _ExtentX        =   2487
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCentroCosto"
      Height          =   315
      Index           =   3
      Left            =   2115
      TabIndex        =   28
      Tag             =   "CentrosCosto"
      Top             =   1935
      Visible         =   0   'False
      Width           =   4200
      _ExtentX        =   7408
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdCentroCosto"
      Text            =   ""
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Obra :"
      Height          =   255
      Index           =   0
      Left            =   135
      TabIndex        =   30
      Top             =   1575
      Width           =   1815
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Centro de costo :"
      Height          =   300
      Index           =   1
      Left            =   135
      TabIndex        =   29
      Top             =   1935
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item de RM :"
      Height          =   345
      Index           =   3
      Left            =   4050
      TabIndex        =   22
      Top             =   150
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de RM :"
      Height          =   345
      Index           =   5
      Left            =   135
      TabIndex        =   21
      Top             =   150
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de l. de acopio :"
      Height          =   345
      Index           =   8
      Left            =   135
      TabIndex        =   20
      Top             =   555
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item de Aco.:"
      Height          =   345
      Index           =   9
      Left            =   4050
      TabIndex        =   19
      Top             =   555
      Visible         =   0   'False
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
      Height          =   255
      Index           =   14
      Left            =   7425
      TabIndex        =   14
      Top             =   810
      Width           =   870
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
      Left            =   6435
      TabIndex        =   12
      Top             =   2370
      Width           =   285
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   2
      Left            =   135
      TabIndex        =   11
      Top             =   1170
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   135
      TabIndex        =   10
      Top             =   2340
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetReservas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetReserva
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oReserva As ComPronto.Reserva
Private mvarIdUnidadCU As Integer
Private mvarCantidadUnidades As Double
Public mvarCantidadAdicional As Double, mvarIdUnidad As Integer
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim dc As DataCombo
         Dim oRs As ADOR.Recordset
         Dim mvarStock As Double, mvarCantidad As Double, mvarStockYaReservado As Double
         Dim mvarIdStock As Long
         
         For Each dc In DataCombo1
            If dc.Enabled Or dc.Index = 0 Then
               If Len(Trim(dc.BoundText)) = 0 Then
                  If Len(dc.Tag) Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Else
                     MsgBox "Es necesario indicar la lista de materiales", vbCritical
                  End If
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
         origen.Registro.Fields("IdUnidad").Value = mvarIdUnidad
         
         If txtCantidad1.Visible Then
            If IsNull(origen.Registro.Fields("Cantidad1").Value) Or origen.Registro.Fields("Cantidad1").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 1)", vbCritical
               Exit Sub
            End If
            mvarCantidadAdicional = origen.Registro.Fields("Cantidad1").Value
         Else
            origen.Registro.Fields("Cantidad1").Value = Null
         End If
         
         If txtCantidad2.Visible Then
            If IsNull(origen.Registro.Fields("Cantidad2").Value) Or origen.Registro.Fields("Cantidad2").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidad de medida 2)", vbCritical
               Exit Sub
            End If
            mvarCantidadAdicional = origen.Registro.Fields("Cantidad1").Value * origen.Registro.Fields("Cantidad2").Value
         Else
            origen.Registro.Fields("Cantidad2").Value = Null
         End If
         
'         If Not IsNull(origen.Registro.Fields("Partida").Value) Then
'            Set oRs = Aplicacion.Articulos.TraerFiltrado("_StockDet", Array(origen.Registro.Fields("IdArticulo").Value, origen.Registro.Fields("Partida").Value, origen.Registro.Fields("IdUnidad").Value))
'         Else
'            Set oRs = Aplicacion.Articulos.TraerFiltrado("_StockDetSinPartida", Array(origen.Registro.Fields("IdArticulo").Value, origen.Registro.Fields("IdUnidad").Value))
'         End If
'
'         If oRs.RecordCount > 0 Then
'
'            mvarStockYaReservado = 0
'
'            If Not IsNull(oRs.Fields("CantidadAdicional").Value) And oRs.Fields("CantidadAdicional").Value > 0 Then
'               mvarStock = oRs.Fields("CantidadUnidades").Value * oRs.Fields("CantidadAdicional").Value
'            Else
'               mvarStock = oRs.Fields("CantidadUnidades").Value
'            End If
'
'            If Not IsNull(oRs.Fields("Med.Reserv.").Value) And oRs.Fields("Med.Reserv.").Value > 0 Then
'               mvarStockYaReservado = oRs.Fields("Cant.Res.").Value * oRs.Fields("Med.Reserv.").Value
'            Else
'               If Not IsNull(oRs.Fields("Cant.Res.").Value) Then
'                  mvarStockYaReservado = oRs.Fields("Cant.Res.").Value
'               End If
'            End If
'
'            If mvarCantidadAdicional > 0 Then
'               mvarCantidad = mvarCantidadUnidades * mvarCantidadAdicional
'            Else
'               mvarCantidad = mvarCantidadUnidades
'            End If
'
'            mvarIdStock = oRs.Fields("IdStock").Value
'
'            oRs.Close
'            Set oRs = Nothing
'
'            If (mvarStock - mvarStockYaReservado) < mvarCantidad Then
'               MsgBox "Stock insuficiente para reservar."
'               Exit Sub
'            End If
'
'         Else
'
'            oRs.Close
'            Set oRs = Nothing
'            MsgBox "No se encontro stock en este articulo - partida.", vbCritical
'            Exit Sub
'
'         End If
'
'         With origen.Registro
'            .Fields("IdUnidad").Value = mvarIdUnidad
'            .Fields("CantidadAdicional").Value = mvarCantidadAdicional * mvarCantidadUnidades
'            .Fields("IdStock").Value = mvarIdStock
'         End With
         
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
            .Id = 1
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
   Set origen = oReserva.DetReservas.Item(vNewValue)
   Me.IdNuevo = origen.Id
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
      origen.Registro.Fields("Retirada").Value = "NO"
      Option1.Value = True
   Else
      With origen.Registro
         If Not IsNull(.Fields("IdDetalleRequerimiento").Value) Then
            Set oRs = oAp.Requerimientos.Item(0).DetRequerimientos.Item(.Fields("IdDetalleRequerimiento").Value).Registro
            If oRs.RecordCount > 0 Then
               txtNumeroRequerimiento.Text = oAp.Requerimientos.Item(oRs.Fields("IdRequerimiento").Value).Registro.Fields("NumeroRequerimiento").Value
               txtNumeroItemRequerimiento.Text = oRs.Fields("NumeroItem").Value
            End If
            oRs.Close
         End If
         If Not IsNull(.Fields("IdDetalleAcopio").Value) Then
            Set oRs = oAp.Acopios.Item(0).DetAcopios.Item(.Fields("IdDetalleAcopios").Value).Registro
            If oRs.RecordCount > 0 Then
               txtNumeroAcopio.Text = oAp.Acopios.Item(oRs.Fields("IdAcopio").Value).Registro.Fields("NumeroAcopio").Value
               txtNumeroItemAcopio.Text = oRs.Fields("NumeroItem").Value
            End If
            oRs.Close
         End If
         If Not IsNull(.Fields("IdCentroCosto").Value) Then
            Option2.Value = True
         Else
            Option1.Value = True
         End If
      End With
   End If
   
   If oReserva.Id > 0 Then
      cmd(0).Enabled = False
      cmd(2).Enabled = False
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then
      DataCombo1(0).Enabled = False
   End If
   
End Property

Public Property Get Reserva() As ComPronto.Reserva

   Set Reserva = oReserva

End Property

Public Property Set Reserva(ByVal vNewValue As ComPronto.Reserva)

   Set oReserva = vNewValue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
         
      Dim oRs As ADOR.Recordset
      
      Select Case Index
         
         Case 1
      
            Me.MousePointer = vbHourglass
            
            Set oRs = Aplicacion.Articulos.Item(DataCombo1(1).BoundText).Registro
         
            If oRs.RecordCount > 0 Then
               
               With origen.Registro
                  If IsNull(.Fields("IdUnidad").Value) Then
                     .Fields("IdUnidad").Value = mvarIdUnidadCU
                  End If
               End With
               
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
            
            End If
            
            oRs.Close
            Set oRs = Nothing
            
'            Set DataCombo1(2).RowSource = Aplicacion.LMateriales.TraerFiltrado("_DetallesAReservar", DataCombo1(1).BoundText)
            
            Me.MousePointer = vbDefault
            
         Case 2
         
            Set oRs = Aplicacion.Obras.TraerFiltrado("_DatosDeLaObra", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("Cliente").Value) Then
                  txtCliente.Text = oRs.Fields("Cliente").Value
               End If
            End If
            oRs.Close
            Set oRs = Nothing
      
      End Select
      
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
   Set oReserva = Nothing

End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      DataCombo1(2).Enabled = True
      DataCombo1(3).Enabled = False
      origen.Registro.Fields("IdCentroCosto").Value = Null
   End If
   
End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      DataCombo1(2).Enabled = False
      DataCombo1(3).Enabled = True
      origen.Registro.Fields("IdObra").Value = Null
      txtCliente.Text = ""
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
      
      Set oAp = Aplicacion
      
      Columnas = Split(Filas(1), vbTab) ' armo un vector con las columnas
      
      Set oRs = oAp.Articulos.TraerFiltrado("_Stock", Columnas(0))
      
      If oRs.RecordCount > 0 Then
         With origen.Registro
            .Fields("CantidadUnidades").Value = 0
            .Fields("Cantidad1").Value = 0
            .Fields("Cantidad2").Value = 0
'            .Fields("Partida").Value = oRs.Fields("Partida").Value
            .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
            .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
         End With
      End If
      
      oRs.Close
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

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

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

