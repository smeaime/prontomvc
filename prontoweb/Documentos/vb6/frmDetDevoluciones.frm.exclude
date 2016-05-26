VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetDevoluciones 
   Caption         =   "Item de devolucion"
   ClientHeight    =   3420
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8250
   Icon            =   "frmDetDevoluciones.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3420
   ScaleWidth      =   8250
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
      Left            =   4185
      TabIndex        =   22
      Top             =   1935
      Visible         =   0   'False
      Width           =   1095
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
      Left            =   4185
      TabIndex        =   20
      Top             =   1575
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
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2115
      TabIndex        =   1
      Top             =   855
      Width           =   870
   End
   Begin VB.TextBox txtCosto 
      Alignment       =   1  'Right Justify
      DataField       =   "Costo"
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
      Height          =   315
      Left            =   2115
      TabIndex        =   2
      Top             =   1215
      Width           =   870
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1755
      TabIndex        =   7
      Top             =   2835
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   90
      TabIndex        =   6
      Top             =   2835
      Width           =   1485
   End
   Begin VB.TextBox txtBonificacion 
      Alignment       =   1  'Right Justify
      DataField       =   "Bonificacion"
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
      Height          =   315
      Left            =   2115
      TabIndex        =   4
      Top             =   1935
      Width           =   870
   End
   Begin VB.TextBox txtPrecioUnitario 
      Alignment       =   1  'Right Justify
      DataField       =   "PrecioUnitario"
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
      Left            =   2115
      TabIndex        =   3
      Top             =   1575
      Width           =   870
   End
   Begin VB.TextBox txtImporte 
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
      Height          =   360
      Left            =   2115
      TabIndex        =   5
      Top             =   2295
      Width           =   870
   End
   Begin VB.TextBox txtCodigoArticulo 
      DataField       =   "CodigoArticulo"
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
      Left            =   2115
      TabIndex        =   0
      Top             =   180
      Width           =   1455
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   0
      Left            =   2115
      TabIndex        =   15
      Tag             =   "Articulos"
      Top             =   495
      Width           =   5955
      _ExtentX        =   10504
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUbicacion"
      Height          =   315
      Index           =   2
      Left            =   4185
      TabIndex        =   16
      Tag             =   "Ubicaciones"
      Top             =   855
      Width           =   3885
      _ExtentX        =   6853
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
      Left            =   4185
      TabIndex        =   17
      Tag             =   "Obras"
      Top             =   1215
      Width           =   1725
      _ExtentX        =   3043
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin VB.Label lblColor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   300
      Left            =   4185
      TabIndex        =   25
      Top             =   2340
      Visible         =   0   'False
      Width           =   3930
   End
   Begin VB.Label lblLabels 
      Caption         =   "Color :"
      Height          =   300
      Index           =   10
      Left            =   3195
      TabIndex        =   24
      Top             =   2340
      Visible         =   0   'False
      Width           =   915
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro.Caja:"
      Height          =   255
      Index           =   9
      Left            =   3195
      TabIndex        =   23
      Top             =   1980
      Visible         =   0   'False
      Width           =   915
   End
   Begin VB.Label lblLabels 
      Caption         =   "Partida :"
      Height          =   255
      Index           =   3
      Left            =   3195
      TabIndex        =   21
      Top             =   1620
      Width           =   915
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ubicacion :"
      Height          =   255
      Index           =   16
      Left            =   3195
      TabIndex        =   19
      Top             =   900
      Width           =   915
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obra :"
      Height          =   255
      Index           =   15
      Left            =   3195
      TabIndex        =   18
      Top             =   1260
      Width           =   915
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad devuelta :"
      Height          =   300
      Index           =   7
      Left            =   135
      TabIndex        =   14
      Top             =   909
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   2
      Left            =   135
      TabIndex        =   13
      Top             =   552
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Costo :"
      Height          =   300
      Index           =   4
      Left            =   135
      TabIndex        =   12
      Top             =   1260
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Bonificacion (%) :"
      Height          =   300
      Index           =   0
      Left            =   135
      TabIndex        =   11
      Top             =   1980
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Precio Unitario :"
      Height          =   300
      Index           =   1
      Left            =   135
      TabIndex        =   10
      Top             =   1620
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe :"
      Height          =   300
      Index           =   5
      Left            =   135
      TabIndex        =   9
      Top             =   2340
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de Articulo :"
      Height          =   300
      Index           =   6
      Left            =   135
      TabIndex        =   8
      Top             =   195
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetDevoluciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetDevolucion
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oDevolucion As ComPronto.Devolucion
Public Aceptado As Boolean
Private mvarIdNuevo As Long

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then
      
      If Len(txtCantidad.Text) = 0 Then
         MsgBox "Debe indicar la cantidad del item a facturar", vbExclamation
         Exit Sub
      End If
      
      If Len(txtPrecioUnitario.Text) = 0 Then
         MsgBox "Debe indicar el precio del item a facturar", vbExclamation
         Exit Sub
      End If
      
      Dim dc As DataCombo
      For Each dc In DataCombo1
         If dc.Enabled And dc.Visible Then
            If Len(Trim(dc.BoundText)) = 0 Then
               MsgBox "Falta completar el campo " & dc.Tag, vbCritical
               Exit Sub
            End If
            origen.Registro.Fields(dc.DataField).Value = dc.BoundText
         End If
      Next
      
      With origen.Registro
         .Fields("CodigoArticulo").Value = txtCodigoArticulo.Text
         If IsNull(.Fields("Bonificacion").Value) Then
            .Fields("Bonificacion").Value = 0
         End If
      End With
      origen.Modificado = True
      Aceptado = True
   
   End If
   
   Me.Hide

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion

   If BuscarClaveINI("Inhabilitar ubicaciones en movimientos de stock") = "SI" Then
      lblLabels(16).Visible = False
      DataCombo1(2).Visible = False
   End If
   
   If BuscarClaveINI("Tabla de colores ampliada") = "SI" Then
      lblLabels(10).Visible = True
      lblColor.Visible = True
   End If
   
   Set oAp = Aplicacion
   Set origen = oDevolucion.DetDevoluciones.Item(vNewValue)
   Me.IdNuevo = origen.Id
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
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   If vNewValue = -1 Then
      With origen.Registro
      End With
   Else
      With origen.Registro
         MostrarColor
      End With
   End If
   
   If glbUsarPartidasParaStock Then
      lblLabels(9).Visible = True
      txtNumeroCaja.Visible = True
   End If
   
   Set oAp = Nothing

End Property

Public Property Get Devolucion() As ComPronto.Devolucion

   Set Devolucion = oDevolucion

End Property

Public Property Set Devolucion(ByVal vNewValue As ComPronto.Devolucion)

   Set oDevolucion = vNewValue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      If Index = 1 Then
         Dim oRs As ADOR.Recordset
         Dim mIdRubro As Long
         With origen.Registro
            .Fields("IdArticulo").Value = DataCombo1(Index).BoundText
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
            If IsNull(oRs.Fields("IdRubro").Value) Then
               MsgBox "El producto no tiene asignado el rubro", vbExclamation
               .Fields("IdArticulo").Value = Null
               oRs.Close
               Set oRs = Nothing
               Exit Sub
            End If
            mIdRubro = oRs.Fields("IdRubro").Value
            txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
            oRs.Close
            Set oRs = Aplicacion.Rubros.TraerFiltrado("_PorId", mIdRubro)
            If IsNull(oRs.Fields("IdCuenta").Value) Then
               MsgBox "El rubro de este producto no tiene cuenta contable", vbExclamation
               .Fields("IdArticulo").Value = Null
               oRs.Close
               Set oRs = Nothing
               Exit Sub
            End If
            oRs.Close
         End With
         Set oRs = Nothing
      End If
   End If

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
               DataCombo1(Index).BoundText = POP_Key
            End If
         Else
            MsgBox "No se ha cargado el menu de materiales", vbInformation
         End If
      End If
   End If

End Sub

Private Sub Form_Activate()

   CalculaImporte

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

   Set oDevolucion = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
   If glbMenuPopUpCargado Then DesactivarPopUp Me
   
End Sub

Private Sub txtBonificacion_GotFocus()
   
   With txtBonificacion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBonificacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtBonificacion_LostFocus()

   CalculaImporte

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

Private Sub txtCantidad_LostFocus()

   CalculaImporte

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

Private Function CalculaImporte()

   txtImporte.Text = Format((Val(txtCantidad.Text) * Val(txtPrecioUnitario.Text)) * (1 - (Val(txtBonificacion.Text) / 100)), "Fixed")
   
End Function

Private Sub txtCosto_GotFocus()
   
   With txtCosto
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCosto_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPrecioUnitario_GotFocus()
   
   With txtPrecioUnitario
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPrecioUnitario_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPrecioUnitario_LostFocus()

   CalculaImporte

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Public Sub MostrarColor()

   Dim oRs As ADOR.Recordset
   
   If Len(txtNumeroCaja.Text) > 0 Then
      Set oRs = Aplicacion.UnidadesEmpaque.TraerFiltrado("_PorNumero", txtNumeroCaja.Text)
      If oRs.RecordCount > 0 Then
         lblColor.Caption = IIf(IsNull(oRs.Fields("Color").Value), "", oRs.Fields("Color").Value)
      End If
      oRs.Close
   ElseIf IIf(IsNull(origen.Registro.Fields("IdDetalleFactura").Value), 0, origen.Registro.Fields("IdDetalleFactura").Value) Then
      Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetFacturas", "_ConDatos", Array(-1, origen.Registro.Fields("IdDetalleFactura").Value))
      If oRs.RecordCount > 0 Then
         lblColor.Caption = IIf(IsNull(oRs.Fields("Color").Value), "", oRs.Fields("Color").Value)
      End If
      oRs.Close
   End If
      
   Set oRs = Nothing

End Sub
