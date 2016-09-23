VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmPedidosAdicionales 
   Caption         =   "Datos adicionales de pedidos"
   ClientHeight    =   8070
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10560
   Icon            =   "frmPedidosAdicionales.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8070
   ScaleWidth      =   10560
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame9 
      Height          =   1140
      Left            =   8865
      TabIndex        =   50
      Top             =   6840
      Visible         =   0   'False
      Width           =   1620
      Begin VB.OptionButton Option17 
         Caption         =   "SI"
         Height          =   195
         Left            =   180
         TabIndex        =   52
         Top             =   855
         Width           =   510
      End
      Begin VB.OptionButton Option18 
         Caption         =   "NO"
         Height          =   195
         Left            =   810
         TabIndex        =   51
         Top             =   855
         Width           =   555
      End
      Begin VB.Label lblLabels 
         Caption         =   "Imprime las observaciones de la RM ?"
         Height          =   645
         Index           =   10
         Left            =   90
         TabIndex        =   53
         Top             =   180
         Width           =   1395
      End
   End
   Begin VB.CheckBox Check1 
      Height          =   285
      Index           =   1
      Left            =   3870
      TabIndex        =   46
      Top             =   1935
      Width           =   195
   End
   Begin VB.CheckBox Check1 
      Height          =   285
      Index           =   0
      Left            =   3870
      TabIndex        =   43
      Top             =   990
      Width           =   195
   End
   Begin VB.Frame Frame8 
      Caption         =   "Imprime item ? "
      Height          =   510
      Left            =   45
      TabIndex        =   39
      Top             =   7065
      Width           =   1800
      Begin VB.OptionButton Option16 
         Caption         =   "NO"
         Height          =   195
         Left            =   990
         TabIndex        =   41
         Top             =   270
         Width           =   555
      End
      Begin VB.OptionButton Option15 
         Caption         =   "SI"
         Height          =   195
         Left            =   225
         TabIndex        =   40
         Top             =   270
         Width           =   510
      End
   End
   Begin VB.Frame Frame7 
      Caption         =   "Imprime item ? "
      Height          =   510
      Left            =   45
      TabIndex        =   36
      Top             =   6120
      Width           =   1800
      Begin VB.OptionButton Option14 
         Caption         =   "NO"
         Height          =   195
         Left            =   990
         TabIndex        =   38
         Top             =   270
         Width           =   555
      End
      Begin VB.OptionButton Option13 
         Caption         =   "SI"
         Height          =   195
         Left            =   225
         TabIndex        =   37
         Top             =   270
         Width           =   510
      End
   End
   Begin VB.Frame Frame6 
      Caption         =   "Imprime item ? "
      Height          =   510
      Left            =   45
      TabIndex        =   33
      Top             =   5175
      Width           =   1800
      Begin VB.OptionButton Option12 
         Caption         =   "NO"
         Height          =   195
         Left            =   990
         TabIndex        =   35
         Top             =   270
         Width           =   555
      End
      Begin VB.OptionButton Option11 
         Caption         =   "SI"
         Height          =   195
         Left            =   225
         TabIndex        =   34
         Top             =   270
         Width           =   510
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Imprime item ? "
      Height          =   510
      Left            =   45
      TabIndex        =   30
      Top             =   4230
      Width           =   1800
      Begin VB.OptionButton Option10 
         Caption         =   "NO"
         Height          =   195
         Left            =   990
         TabIndex        =   32
         Top             =   270
         Width           =   555
      End
      Begin VB.OptionButton Option9 
         Caption         =   "SI"
         Height          =   195
         Left            =   225
         TabIndex        =   31
         Top             =   270
         Width           =   510
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "Imprime item ? "
      Height          =   510
      Left            =   45
      TabIndex        =   27
      Top             =   3285
      Width           =   1800
      Begin VB.OptionButton Option8 
         Caption         =   "NO"
         Height          =   195
         Left            =   990
         TabIndex        =   29
         Top             =   270
         Width           =   555
      End
      Begin VB.OptionButton Option7 
         Caption         =   "SI"
         Height          =   195
         Left            =   225
         TabIndex        =   28
         Top             =   270
         Width           =   510
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Imprime item ? "
      Height          =   510
      Left            =   45
      TabIndex        =   24
      Top             =   2340
      Width           =   1800
      Begin VB.OptionButton Option6 
         Caption         =   "NO"
         Height          =   195
         Left            =   990
         TabIndex        =   26
         Top             =   270
         Width           =   555
      End
      Begin VB.OptionButton Option5 
         Caption         =   "SI"
         Height          =   195
         Left            =   225
         TabIndex        =   25
         Top             =   270
         Width           =   510
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Imprime item ? "
      Height          =   510
      Left            =   45
      TabIndex        =   21
      Top             =   1395
      Width           =   1800
      Begin VB.OptionButton Option3 
         Caption         =   "SI"
         Height          =   195
         Left            =   225
         TabIndex        =   23
         Top             =   270
         Width           =   510
      End
      Begin VB.OptionButton Option4 
         Caption         =   "NO"
         Height          =   195
         Left            =   990
         TabIndex        =   22
         Top             =   270
         Width           =   555
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Imprime item ? "
      Height          =   510
      Left            =   45
      TabIndex        =   18
      Top             =   450
      Width           =   1800
      Begin VB.OptionButton Option2 
         Caption         =   "NO"
         Height          =   195
         Left            =   990
         TabIndex        =   20
         Top             =   270
         Width           =   555
      End
      Begin VB.OptionButton Option1 
         Caption         =   "SI"
         Height          =   195
         Left            =   225
         TabIndex        =   19
         Top             =   270
         Width           =   510
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   405
      Index           =   1
      Left            =   9000
      TabIndex        =   17
      Top             =   585
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   9000
      TabIndex        =   8
      Top             =   135
      Width           =   1485
   End
   Begin RichTextLib.RichTextBox rchLugarEntrega 
      Height          =   645
      Left            =   1890
      TabIndex        =   2
      Top             =   2250
      Width           =   6900
      _ExtentX        =   12171
      _ExtentY        =   1138
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmPedidosAdicionales.frx":076A
   End
   Begin RichTextLib.RichTextBox rchFormaPago 
      Height          =   915
      Left            =   1890
      TabIndex        =   3
      Top             =   2925
      Width           =   6900
      _ExtentX        =   12171
      _ExtentY        =   1614
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmPedidosAdicionales.frx":07EC
   End
   Begin RichTextLib.RichTextBox rchPlazoEntrega 
      Height          =   690
      Left            =   1890
      TabIndex        =   1
      Top             =   1260
      Width           =   6900
      _ExtentX        =   12171
      _ExtentY        =   1217
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmPedidosAdicionales.frx":086E
   End
   Begin RichTextLib.RichTextBox rchImputacion 
      Height          =   915
      Left            =   1890
      TabIndex        =   4
      Top             =   3870
      Width           =   6900
      _ExtentX        =   12171
      _ExtentY        =   1614
      _Version        =   393217
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmPedidosAdicionales.frx":08F0
   End
   Begin RichTextLib.RichTextBox rchInspecciones 
      Height          =   915
      Left            =   1890
      TabIndex        =   5
      Top             =   4815
      Width           =   6900
      _ExtentX        =   12171
      _ExtentY        =   1614
      _Version        =   393217
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmPedidosAdicionales.frx":0972
   End
   Begin RichTextLib.RichTextBox rchGarantia 
      Height          =   915
      Left            =   1890
      TabIndex        =   6
      Top             =   5760
      Width           =   6900
      _ExtentX        =   12171
      _ExtentY        =   1614
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmPedidosAdicionales.frx":09F4
   End
   Begin RichTextLib.RichTextBox rchDocumentacion 
      Height          =   915
      Left            =   1890
      TabIndex        =   7
      Top             =   6705
      Width           =   6900
      _ExtentX        =   12171
      _ExtentY        =   1614
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmPedidosAdicionales.frx":0A76
   End
   Begin RichTextLib.RichTextBox rchImportante 
      Height          =   915
      Left            =   1890
      TabIndex        =   0
      Top             =   90
      Width           =   6900
      _ExtentX        =   12171
      _ExtentY        =   1614
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmPedidosAdicionales.frx":0AF8
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   4140
      TabIndex        =   42
      Tag             =   "PlazosEntrega"
      Top             =   990
      Width           =   4650
      _ExtentX        =   8202
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPlazoEntrega"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   1
      Left            =   4140
      TabIndex        =   45
      Tag             =   "LugaresEntrega"
      Top             =   1935
      Width           =   4650
      _ExtentX        =   8202
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdLugarEntrega"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdClausula"
      Height          =   315
      Index           =   2
      Left            =   1890
      TabIndex        =   48
      Tag             =   "Clausulas"
      Top             =   7695
      Width           =   6900
      _ExtentX        =   12171
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdClausula"
      Text            =   ""
   End
   Begin VB.Label lblData 
      Caption         =   "08 - Clausula u$s :"
      Height          =   285
      Index           =   2
      Left            =   45
      TabIndex        =   49
      Top             =   7695
      Width           =   1800
   End
   Begin VB.Label lblLabels 
      Caption         =   "Activar busqueda x tabla :"
      Height          =   240
      Index           =   9
      Left            =   1935
      TabIndex        =   47
      Top             =   1980
      Width           =   1890
   End
   Begin VB.Label lblLabels 
      Caption         =   "Activar busqueda x tabla :"
      Height          =   240
      Index           =   8
      Left            =   1935
      TabIndex        =   44
      Top             =   1035
      Width           =   1890
   End
   Begin VB.Label lblLabels 
      Caption         =   "00 - Importante :"
      Height          =   285
      Index           =   7
      Left            =   45
      TabIndex        =   16
      Top             =   105
      Width           =   1800
   End
   Begin VB.Label lblLabels 
      Caption         =   "07 - Documentacion :"
      Height          =   285
      Index           =   5
      Left            =   45
      TabIndex        =   15
      Top             =   6705
      Width           =   1800
   End
   Begin VB.Label lblLabels 
      Caption         =   "06 - Garantia :"
      Height          =   285
      Index           =   4
      Left            =   45
      TabIndex        =   14
      Top             =   5775
      Width           =   1800
   End
   Begin VB.Label lblLabels 
      Caption         =   "05 - Inspecciones :"
      Height          =   285
      Index           =   2
      Left            =   45
      TabIndex        =   13
      Top             =   4830
      Width           =   1800
   End
   Begin VB.Label lblLabels 
      Caption         =   "04 - Imputacion contable :"
      Height          =   285
      Index           =   1
      Left            =   45
      TabIndex        =   12
      Top             =   3885
      Width           =   1800
   End
   Begin VB.Label lblLabels 
      Caption         =   "01 - Plazo de entrega :"
      Height          =   285
      Index           =   0
      Left            =   45
      TabIndex        =   11
      Top             =   1050
      Width           =   1800
   End
   Begin VB.Label lblLabels 
      Caption         =   "02 - Lugar de entrega :"
      Height          =   285
      Index           =   3
      Left            =   45
      TabIndex        =   10
      Top             =   1995
      Width           =   1800
   End
   Begin VB.Label lblLabels 
      Caption         =   "03 - Forma de pago :"
      Height          =   285
      Index           =   6
      Left            =   45
      TabIndex        =   9
      Top             =   2940
      Width           =   1800
   End
End
Attribute VB_Name = "frmPedidosAdicionales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oPedido As ComPronto.Pedido
Private mvarModificado As Boolean, mvarCargando As Boolean
Private mInspecciones As String, mImputaciones As String

Private Sub Check1_Click(Index As Integer)

   If Check1(Index).Value = 1 Then
      dcfields(Index).Enabled = True
   Else
      With dcfields(Index)
         .BoundText = 0
         .Enabled = False
      End With
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
         Dim dc As DataCombo
         With oPedido.Registro
            For Each dc In dcfields
               If dc.Enabled And dc.Visible And Len(dc.DataField) > 0 Then
                  If Not IsNumeric(dc.BoundText) And dc.Index <> 2 Then
                     MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
                     Exit Sub
                  End If
                  If IsNumeric(dc.BoundText) Then .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
         
            .Fields("Importante").Value = rchImportante.Text
            .Fields("PlazoEntrega").Value = rchPlazoEntrega.Text
            .Fields("LugarEntrega").Value = rchLugarEntrega.Text
            .Fields("FormaPago").Value = rchFormaPago.Text
            .Fields("Garantia").Value = rchGarantia.Text
            .Fields("Documentacion").Value = rchDocumentacion.Text
            If Option1.Value Then
               .Fields("ImprimeImportante").Value = "SI"
            Else
               .Fields("ImprimeImportante").Value = "NO"
            End If
            If Option3.Value Then
               .Fields("ImprimePlazoEntrega").Value = "SI"
            Else
               .Fields("ImprimePlazoEntrega").Value = "NO"
            End If
            If Option5.Value Then
               .Fields("ImprimeLugarEntrega").Value = "SI"
            Else
               .Fields("ImprimeLugarEntrega").Value = "NO"
            End If
            If Option7.Value Then
               .Fields("ImprimeFormaPago").Value = "SI"
            Else
               .Fields("ImprimeFormaPago").Value = "NO"
            End If
            If Option9.Value Then
               .Fields("ImprimeImputaciones").Value = "SI"
            Else
               .Fields("ImprimeImputaciones").Value = "NO"
            End If
            If Option11.Value Then
               .Fields("ImprimeInspecciones").Value = "SI"
            Else
               .Fields("ImprimeInspecciones").Value = "NO"
            End If
            If Option13.Value Then
               .Fields("ImprimeGarantia").Value = "SI"
            Else
               .Fields("ImprimeGarantia").Value = "NO"
            End If
            If Option15.Value Then
               .Fields("ImprimeDocumentacion").Value = "SI"
            Else
               .Fields("ImprimeDocumentacion").Value = "NO"
            End If
            If Option18.Value Then
               .Fields("IncluirObservacionesRM").Value = "NO"
            Else
               .Fields("IncluirObservacionesRM").Value = "SI"
            End If
         End With
      
      Case 1
         If mvarModificado Then
            Dim mvarSale As Integer
            mvarSale = MsgBox("Hay datos no grabados, desea salir igual ?", vbYesNo, "Salir")
            If mvarSale = vbNo Then
               Exit Sub
            End If
            mvarModificado = False
         End If
   End Select
   
   Me.Hide
   
End Sub

Public Property Get Pedido() As ComPronto.Pedido

   Set Pedido = oPedido

End Property

Public Property Set Pedido(ByVal vnewvalue As ComPronto.Pedido)

   Set oPedido = vnewvalue

End Property

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   If Index = 2 Then SetDataComboDropdownListWidth 800
   
   If IsNumeric(dcfields(Index).BoundText) Then
      Dim oRs As ADOR.Recordset
      If Index = 0 Then
         Set oRs = Aplicacion.PlazosEntrega.TraerFiltrado("_PorId", dcfields(Index).BoundText)
         If Not IsNull(oRs.Fields("Detalle").Value) And Len(oRs.Fields("Detalle").Value) > 0 Then
            rchPlazoEntrega.Text = oRs.Fields("Detalle").Value
         End If
         oRs.Close
      ElseIf Index = 1 Then
         Set oRs = Aplicacion.LugaresEntrega.TraerFiltrado("_PorId", dcfields(Index).BoundText)
         If Not IsNull(oRs.Fields("Detalle").Value) And Len(oRs.Fields("Detalle").Value) > 0 Then
            rchLugarEntrega.Text = oRs.Fields("Detalle").Value
         End If
         oRs.Close
      End If
      Set oRs = Nothing
   End If

End Sub

Private Sub Form_Activate()

   Dim oControl As Control
   Dim oRs As ADOR.Recordset
   Dim mCondicion As String

   mvarCargando = True
   
   If BuscarClaveINI("Preguntar por impresion de observaciones de RM en pedido") = "SI" Then Frame9.Visible = True
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = oPedido
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DTPicker Then
            If Len(oControl.DataField) Then .Add oControl, "value", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = oPedido
            If Len(oControl.Tag) Then Set oControl.RowSource = Aplicacion.CargarLista(oControl.Tag)
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   With oPedido.Registro
      rchImportante.TextRTF = .Fields("Importante").Value
      rchPlazoEntrega.TextRTF = .Fields("PlazoEntrega").Value
      rchLugarEntrega.TextRTF = .Fields("LugarEntrega").Value
      rchFormaPago.TextRTF = .Fields("FormaPago").Value
      rchGarantia.TextRTF = .Fields("Garantia").Value
      rchDocumentacion.TextRTF = .Fields("Documentacion").Value
      If oPedido.Id <= 0 Then
         '.Fields("ImprimeImportante").Value = "NO"
         .Fields("ImprimeImputaciones").Value = "NO"
         .Fields("ImprimeInspecciones").Value = "NO"
      End If
      If IsNull(.Fields("ImprimeImportante").Value) Or .Fields("ImprimeImportante").Value = "SI" Then
         Option1.Value = True
      Else
         Option2.Value = True
      End If
      If IsNull(.Fields("ImprimePlazoEntrega").Value) Or .Fields("ImprimePlazoEntrega").Value = "SI" Then
         Option3.Value = True
      Else
         Option4.Value = True
      End If
      If IsNull(.Fields("ImprimeLugarEntrega").Value) Or .Fields("ImprimeLugarEntrega").Value = "SI" Then
         Option5.Value = True
      Else
         Option6.Value = True
      End If
      If IsNull(.Fields("ImprimeFormaPago").Value) Or .Fields("ImprimeFormaPago").Value = "SI" Then
         Option7.Value = True
      Else
         Option8.Value = True
      End If
      If IsNull(.Fields("ImprimeImputaciones").Value) Or .Fields("ImprimeImputaciones").Value = "SI" Then
         Option9.Value = True
      Else
         Option10.Value = True
      End If
      If IsNull(.Fields("ImprimeInspecciones").Value) Or .Fields("ImprimeInspecciones").Value = "SI" Then
         Option11.Value = True
      Else
         Option12.Value = True
      End If
      If IsNull(.Fields("ImprimeGarantia").Value) Or .Fields("ImprimeGarantia").Value = "SI" Then
         Option13.Value = True
      Else
         Option14.Value = True
      End If
      If IsNull(.Fields("ImprimeDocumentacion").Value) Or .Fields("ImprimeDocumentacion").Value = "SI" Then
         Option15.Value = True
      Else
         Option16.Value = True
      End If
      If IsNull(.Fields("IdClausula").Value) Then
         Set oRs = Aplicacion.Clausulas.TraerTodos
         If oRs.RecordCount > 0 Then
            .Fields("IdClausula").Value = oRs.Fields(0).Value
         End If
         oRs.Close
      End If
      If IsNull(.Fields("IncluirObservacionesRM").Value) Or .Fields("IncluirObservacionesRM").Value = "NO" Then
         Option18.Value = True
      Else
         Option17.Value = True
      End If
         
   End With
   rchInspecciones.Text = mInspecciones
   rchImputacion.Text = mImputaciones
   
   mvarCargando = False
   mvarModificado = False
   
   Set oRs = Nothing
   
End Sub

Private Sub Form_Load()

   With dcfields(0)
      Set .RowSource = Aplicacion.PlazosEntrega.TraerLista
      .Enabled = False
   End With
   With dcfields(1)
      Set .RowSource = Aplicacion.LugaresEntrega.TraerLista
      .Enabled = False
   End With

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Property Let Inspecciones(ByVal vnewvalue As String)

   mInspecciones = vnewvalue

End Property

Public Property Let Imputaciones(ByVal vnewvalue As String)

   mImputaciones = vnewvalue

End Property

Private Sub Form_Unload(Cancel As Integer)

   Set oPedido = Nothing
   Set oBind = Nothing

End Sub

Private Sub rchDocumentacion_Change()

   If Not mvarCargando Then
      mvarModificado = True
   End If
   
End Sub

Private Sub rchFormaPago_Change()

   If Not mvarCargando Then
      mvarModificado = True
   End If
   
End Sub

Private Sub rchGarantia_Change()

   If Not mvarCargando Then
      mvarModificado = True
   End If
   
End Sub

Private Sub rchImportante_Change()

   If Not mvarCargando Then
      mvarModificado = True
   End If
   
End Sub

Private Sub rchImputacion_Change()

   If Not mvarCargando Then
      mvarModificado = True
   End If
   
End Sub

Private Sub rchInspecciones_Change()

   If Not mvarCargando Then
      mvarModificado = True
   End If
   
End Sub

Private Sub rchLugarEntrega_Change()

   If Not mvarCargando Then
      mvarModificado = True
   End If
   
End Sub

Private Sub rchPlazoEntrega_Change()

   If Not mvarCargando Then
      mvarModificado = True
   End If
   
End Sub
