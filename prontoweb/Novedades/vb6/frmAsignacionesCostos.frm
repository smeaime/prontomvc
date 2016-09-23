VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmAsignacionesCostos 
   Caption         =   "Asignacion de costo de importacion a ordenes de compra"
   ClientHeight    =   2685
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7845
   Icon            =   "frmAsignacionesCostos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2685
   ScaleWidth      =   7845
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtDescripcion 
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
      Height          =   330
      Left            =   3240
      TabIndex        =   10
      Top             =   90
      Width           =   4350
   End
   Begin VB.TextBox txtFecha 
      Alignment       =   2  'Center
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Height          =   330
      Left            =   6300
      TabIndex        =   9
      Top             =   495
      Width           =   1290
   End
   Begin VB.TextBox txtPrecio 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
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
      Height          =   330
      Left            =   1800
      TabIndex        =   6
      Top             =   495
      Width           =   1110
   End
   Begin VB.TextBox txtCodigoArticulo 
      Alignment       =   2  'Center
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
      Height          =   330
      Left            =   1800
      TabIndex        =   4
      Top             =   90
      Width           =   1380
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   2340
      TabIndex        =   1
      Top             =   2070
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   4005
      TabIndex        =   0
      Top             =   2070
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdDetallePedido"
      Height          =   315
      Index           =   0
      Left            =   225
      TabIndex        =   2
      Tag             =   "Def1"
      Top             =   1440
      Width           =   7395
      _ExtentX        =   13044
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdDetallePedido"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   5400
      TabIndex        =   8
      Top             =   540
      Width           =   795
   End
   Begin VB.Label lblLabels 
      Caption         =   "Costo en pesos: "
      Height          =   240
      Index           =   1
      Left            =   225
      TabIndex        =   7
      Top             =   540
      Width           =   1515
   End
   Begin VB.Label lblLabels 
      Caption         =   "Producto :"
      Height          =   240
      Index           =   2
      Left            =   225
      TabIndex        =   5
      Top             =   135
      Width           =   1515
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Indique el item de pedido al que asignara el costo : "
      Height          =   255
      Index           =   2
      Left            =   225
      TabIndex        =   3
      Top             =   1050
      Width           =   3705
   End
End
Attribute VB_Name = "frmAsignacionesCostos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.AsignacionCostos
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Public Aceptado As Boolean
Private mvarId As Long, mIdArticulo As Long, mIdCostoImportacion As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
   
         Dim est As EnumAcciones
         Dim dc As DataCombo
         
         For Each dc In DataCombo1
            If Len(Trim(dc.BoundText)) = 0 Then
               MsgBox "Falta completar el campo costo", vbCritical
               Exit Sub
            End If
            origen.Registro.Fields(dc.DataField).Value = dc.BoundText
         Next
         
         With origen.Registro
            .Fields("FechaAsignacion").Value = Now
            .Fields("IdCostoImportacion").Value = mIdCostoImportacion
         End With
         
         Select Case origen.Guardar
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
         If mvarId < 0 Then
            
            est = alta
            mvarId = origen.Registro.Fields(0).Value
            
            Dim oRs As ADOR.Recordset
            Dim mCosto As Double
            Set oRs = Aplicacion.Pedidos.TraerFiltrado("_PorIdDetallePedido", Array(DataCombo1(0).BoundText, mIdCostoImportacion))
            mCosto = oRs.Fields("Costo").Value
            Aplicacion.Tarea "Pedidos_ActualizarCosto", Array(DataCombo1(0).BoundText, mvarId, mCosto)
            oRs.Close
            Set oRs = Nothing
         
         Else
            
            est = Modificacion
         
         End If
            
         Aceptado = True
   
   End Select
   
   Me.Hide

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oAp.AsignacionesCostos.Item(vnewvalue)
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Def1" Then
'                  Set oControl.RowSource = oAp.OrdenesCompra.TraerFiltrado("_PorIdArticuloSinEntregas", mIdArticulo)
                  Set oControl.RowSource = oAp.Pedidos.TraerFiltrado("_ParaComboAsignacionImportacion", mIdArticulo)
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
   
   If mIdCostoImportacion <> 0 Then
      Set oRs = oAp.CostosImportacion.TraerFiltrado("_PorId", mIdCostoImportacion)
      If oRs.RecordCount > 0 Then
         txtDescripcion.Text = oRs.Fields("Articulo").Value
         txtFecha.Text = oRs.Fields("Fecha").Value
         txtPrecio.Text = oRs.Fields("PrecioTotal").Value
      End If
      oRs.Close
      Set oRs = oAp.Articulos.TraerFiltrado("_PorId", mIdArticulo)
      If oRs.RecordCount > 0 Then
         txtCodigoArticulo.Text = oRs.Fields("Codigo").Value
      End If
      oRs.Close
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing

End Property

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Public Property Let IdArticulo(ByVal vnewvalue As Long)

   mIdArticulo = vnewvalue
   
End Property

Public Property Let IdCostoImportacion(ByVal vnewvalue As Long)

   mIdCostoImportacion = vnewvalue
   
End Property

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarId

End Property
