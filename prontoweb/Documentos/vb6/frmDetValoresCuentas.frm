VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetValoresCuentas 
   Caption         =   "Item de registro contable [ Gastos bancarios ]"
   ClientHeight    =   3690
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8700
   LinkTopic       =   "Form1"
   ScaleHeight     =   3690
   ScaleWidth      =   8700
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtHaber 
      Alignment       =   1  'Right Justify
      DataField       =   "Haber"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   360
      Left            =   4455
      TabIndex        =   6
      Top             =   2610
      Width           =   1455
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   90
      TabIndex        =   5
      Top             =   3195
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1755
      TabIndex        =   4
      Top             =   3195
      Width           =   1485
   End
   Begin VB.TextBox txtDebe 
      Alignment       =   1  'Right Justify
      DataField       =   "Debe"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   360
      Left            =   1350
      TabIndex        =   3
      Top             =   2610
      Width           =   1455
   End
   Begin VB.CheckBox Check2 
      Height          =   195
      Left            =   2190
      TabIndex        =   2
      Top             =   930
      Width           =   195
   End
   Begin VB.TextBox txtCodigoCuenta 
      DataField       =   "CodigoCuenta"
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
      Left            =   4215
      TabIndex        =   1
      Top             =   525
      Width           =   780
   End
   Begin VB.TextBox txtCotizacionMonedaDestino 
      Alignment       =   1  'Right Justify
      DataField       =   "CotizacionMonedaDestino"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   7200
      TabIndex        =   0
      Top             =   2115
      Width           =   1410
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   0
      Left            =   5040
      TabIndex        =   7
      Tag             =   "Cuentas"
      Top             =   525
      Width           =   3630
      _ExtentX        =   6403
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaGasto"
      Height          =   315
      Index           =   1
      Left            =   2430
      TabIndex        =   8
      Tag             =   "CuentasGastos"
      Top             =   885
      Width           =   6240
      _ExtentX        =   11007
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaGasto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   2
      Left            =   2205
      TabIndex        =   9
      Tag             =   "Obras"
      Top             =   135
      Width           =   6465
      _ExtentX        =   11404
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   3
      Left            =   2190
      TabIndex        =   10
      Tag             =   "TiposCuentaGrupos"
      Top             =   525
      Width           =   1995
      _ExtentX        =   3519
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoCuentaGrupo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaBancaria"
      Height          =   315
      Index           =   4
      Left            =   2205
      TabIndex        =   11
      Tag             =   "CuentasBancarias"
      Top             =   1395
      Width           =   6465
      _ExtentX        =   11404
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaBancaria"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCaja"
      Height          =   315
      Index           =   5
      Left            =   2205
      TabIndex        =   12
      Tag             =   "Cajas"
      Top             =   1755
      Width           =   6450
      _ExtentX        =   11377
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCaja"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   6
      Left            =   2190
      TabIndex        =   13
      Tag             =   "Monedas"
      Top             =   2115
      Width           =   2655
      _ExtentX        =   4683
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
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
   Begin VB.Label lblLabels 
      Caption         =   "Haber :"
      Height          =   300
      Index           =   0
      Left            =   3195
      TabIndex        =   22
      Top             =   2655
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Debe :"
      Height          =   300
      Index           =   5
      Left            =   90
      TabIndex        =   21
      Top             =   2655
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obra : "
      Height          =   300
      Index           =   1
      Left            =   90
      TabIndex        =   20
      Top             =   165
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta de gasto :"
      Height          =   300
      Index           =   4
      Left            =   90
      TabIndex        =   19
      Top             =   885
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Todas las cuentas :"
      Height          =   300
      Index           =   2
      Left            =   90
      TabIndex        =   18
      Top             =   510
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta banco :"
      Height          =   300
      Index           =   3
      Left            =   90
      TabIndex        =   17
      Top             =   1425
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Caja :"
      Height          =   300
      Index           =   6
      Left            =   90
      TabIndex        =   16
      Top             =   1770
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Moneda destino :"
      Height          =   270
      Index           =   23
      Left            =   90
      TabIndex        =   15
      Top             =   2160
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cotizacion moneda destino : "
      Height          =   255
      Index           =   7
      Left            =   4995
      TabIndex        =   14
      Top             =   2160
      Width           =   2085
   End
End
Attribute VB_Name = "frmDetValoresCuentas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetValorCuentas
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oValor As ComPronto.Valor
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mvarIdMoneda As Long
Private mvarCotizacionMonedaDestino As Double
Private mFechaComprobante As Date

Private Sub Check2_Click()

   If Check2.Value = 0 Then
      Dim mIdCuenta As Long
      origen.Registro.Fields(DataCombo1(1).DataField).Value = Null
      txtCodigoCuenta.Enabled = True
      mIdCuenta = 0
      With DataCombo1(0)
         If IsNumeric(.BoundText) Then mIdCuenta = .BoundText
         Set .RowSource = Aplicacion.Cuentas.TraerLista
         origen.Registro.Fields(.DataField).Value = mIdCuenta
         .Enabled = True
      End With
      With DataCombo1(3)
         .BoundText = 0
         .Enabled = True
      End With
   End If
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
      
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe indicar la cuenta", vbExclamation
            Exit Sub
         End If
         
         If DataCombo1(4).Enabled And Not IsNumeric(DataCombo1(4).BoundText) Then
            MsgBox "Debe indicar la cuenta banco", vbExclamation
            Exit Sub
         End If
         
         If DataCombo1(5).Enabled And Not IsNumeric(DataCombo1(5).BoundText) Then
            MsgBox "Debe indicar la cuenta caja", vbExclamation
            Exit Sub
         End If
         
         If (DataCombo1(4).Enabled Or DataCombo1(5).Enabled) And _
               Not IsNumeric(DataCombo1(6).BoundText) Then
            MsgBox "Debe indicar la moneda", vbExclamation
            Exit Sub
         End If
         
         If DataCombo1(6).Enabled And Val(txtCotizacionMonedaDestino.Text) = 0 Then
            MsgBox "No hay cotizacion de la moneda destino"
            Exit Sub
         End If
         
         If Len(txtDebe.Text) = 0 Or Not IsNumeric(txtDebe.Text) Then
            origen.Registro.Fields("Debe").Value = Null
         End If
         If Len(txtHaber.Text) = 0 Or Not IsNumeric(txtHaber.Text) Then
            origen.Registro.Fields("Haber").Value = Null
         End If
         
         If (Len(txtDebe.Text) = 0 Or Not IsNumeric(txtDebe.Text)) And _
               (Len(txtHaber.Text) = 0 Or Not IsNumeric(txtHaber.Text)) Then
            MsgBox "Debe indicar el importe (Debe o Haber)", vbExclamation
            Exit Sub
         End If
         
         If Val(txtDebe.Text) > 0 And Val(txtHaber.Text) > 0 Then
            MsgBox "No puede ingresar importes al debe y al haber simultaneamente", vbExclamation
            Exit Sub
         End If
         
         Dim dc As DataCombo
         With origen.Registro
            For Each dc In DataCombo1
               If IsNumeric(dc.BoundText) And Len(dc.DataField) > 0 Then
                  .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
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
   Dim oAp As ComPronto.Aplicacion

   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oValor.DetValoresCuentas.Item(vNewValue)
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
               If oControl.Tag = "CuentasBancarias" Then
'                  Set oControl.RowSource = oAp.CuentasBancarias.TraerFiltrado("_TodasParaCombo")
               ElseIf oControl.Tag = "Obras" Then
                  If glbSeñal1 Then
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", Me.FechaComprobante))
                  Else
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo")
                  End If
               ElseIf oControl.Tag = "Cuentas" Then
                  If glbSeñal1 Then
                     Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_PorFechaParaCombo", Me.FechaComprobante)
                  Else
                     Set oControl.RowSource = oAp.Cuentas.TraerLista
                  End If
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
   
   If mvarId <= 0 Then
      With origen.Registro
         If IsNull(.Fields("IdMoneda").Value) Then .Fields("IdMoneda").Value = Me.IdMoneda
      End With
   End If
   
   Set oAp = Nothing

End Property

Public Property Get Valor() As ComPronto.Valor

   Set Valor = oValor

End Property

Public Property Set Valor(ByVal vNewValue As ComPronto.Valor)

   Set oValor = vNewValue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      Dim oRs As ADOR.Recordset
      Dim oRs1 As ADOR.Recordset
      Dim i As Integer, mIdCuentaBancaria As Integer
      Dim mIdAux As Long
      Select Case Index
         Case 0
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorIdConDatos", _
                        Array(DataCombo1(Index).BoundText, Me.FechaComprobante))
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  .Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
                  .Fields("CodigoCuenta").Value = oRs.Fields("Codigo1").Value
               End With
               If Not IsNull(oRs.Fields("EsCajaBanco").Value) And _
                     oRs.Fields("EsCajaBanco").Value = "BA" Then
                  DataCombo1(4).Enabled = True
                  mIdCuentaBancaria = IIf(IsNull(origen.Registro.Fields("IdCuentaBancaria").Value), 0, origen.Registro.Fields("IdCuentaBancaria").Value)
                  Set oRs1 = Aplicacion.Bancos.TraerFiltrado("_PorCuentasBancariasIdCuentaIdMoneda", Array(oRs.Fields("IdCuenta").Value, Me.IdMoneda))
                  If oRs1.RecordCount = 1 Then
                     mIdCuentaBancaria = oRs1.Fields(0).Value
                  End If
                  Set DataCombo1(4).RowSource = oRs1
                  DataCombo1(4).BoundText = mIdCuentaBancaria
                  Set oRs1 = Nothing
               Else
                  origen.Registro.Fields("IdCuentaBancaria").Value = Null
                  DataCombo1(4).Enabled = False
               End If
               If Not IsNull(oRs.Fields("EsCajaBanco").Value) And _
                     oRs.Fields("EsCajaBanco").Value = "CA" Then
                  DataCombo1(5).Enabled = True
               Else
                  origen.Registro.Fields("IdCaja").Value = Null
                  DataCombo1(5).Enabled = False
               End If
            End If
            DataCombo1(6).Enabled = DataCombo1(4).Enabled Or DataCombo1(5).Enabled
            txtCotizacionMonedaDestino.Enabled = DataCombo1(6).Enabled
            oRs.Close
         Case 1
            If DataCombo1(Index).Enabled Then
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorObraCuentaGasto", _
                           Array(IIf(Len(DataCombo1(2).BoundText) = 0, 0, DataCombo1(2).BoundText), _
                                 DataCombo1(1).BoundText, Me.FechaComprobante))
               If oRs.RecordCount > 0 Then
                  If Len(DataCombo1(3).Text) > 0 Then
                     DataCombo1(3).BoundText = 0
                     If glbSeñal1 Then
                        Set DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorFechaParaCombo", Me.FechaComprobante)
                     Else
                        Set DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerLista
                     End If
                  End If
                  With origen.Registro
                     .Fields(DataCombo1(Index).DataField).Value = oRs.Fields("IdCuentaGasto").Value
                     .Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
                     .Fields("CodigoCuenta").Value = oRs.Fields("Codigo").Value
                  End With
               End If
               oRs.Close
            Else
               With origen.Registro
                  .Fields(DataCombo1(Index).DataField).Value = Null
               End With
            End If
            txtCodigoCuenta.Enabled = False
            DataCombo1(0).Enabled = False
            DataCombo1(3).Enabled = False
            Check2.Value = 1
         Case 2
            If Not DataCombo1(1).Enabled Then
               DataCombo1(1).Enabled = True
            End If
            With origen.Registro
               .Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
               
               mIdAux = 0
               If IsNumeric(DataCombo1(1).BoundText) Then mIdAux = DataCombo1(1).BoundText
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_CuentasGastoPorObraParaCombo", _
                           DataCombo1(Index).BoundText)
               Set DataCombo1(1).RowSource = oRs
               Set oRs = Nothing
               DataCombo1(1).BoundText = mIdAux
            
            End With
         Case 3
            If IsNumeric(DataCombo1(Index).BoundText) Then
               txtCodigoCuenta.Text = ""
               Dim mIdCuenta As Long
               If IsNumeric(DataCombo1(0).BoundText) Then
                  mIdCuenta = DataCombo1(0).BoundText
               Else
                  mIdCuenta = 0
               End If
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorGrupoParaCombo", _
                           Array(DataCombo1(Index).BoundText, Me.FechaComprobante))
               Set DataCombo1(0).RowSource = oRs
               origen.Registro.Fields(DataCombo1(0).DataField).Value = mIdCuenta
               Set oRs = Nothing
            End If
         Case 6
            If IsNull(origen.Registro.Fields("CotizacionMonedaDestino").Value) Or _
                  origen.Registro.Fields("CotizacionMonedaDestino").Value = 0 Then
               mvarCotizacionMonedaDestino = Cotizacion(Date, DataCombo1(6).BoundText)
               origen.Registro.Fields("CotizacionMonedaDestino").Value = mvarCotizacionMonedaDestino
            End If
'            If mvarCotizacionMonedaDestino = 0 And DataCombo1(6).Enabled Then
'               DataCombo1(6).BoundText = 0
'            End If
            If Not IsNull(origen.Registro.Fields("IdCuenta").Value) Then
               mIdCuentaBancaria = IIf(IsNull(origen.Registro.Fields("IdCuentaBancaria").Value), 0, origen.Registro.Fields("IdCuentaBancaria").Value)
               Set oRs1 = Aplicacion.Bancos.TraerFiltrado("_PorCuentasBancariasIdCuentaIdMoneda", Array(origen.Registro.Fields("IdCuenta").Value, DataCombo1(6).BoundText))
               If oRs1.RecordCount = 1 Then
                  mIdCuentaBancaria = oRs1.Fields(0).Value
               End If
               Set DataCombo1(4).RowSource = oRs1
               DataCombo1(4).BoundText = mIdCuentaBancaria
               Set oRs1 = Nothing
            End If
      End Select
      Set oRs = Nothing
   End If

End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)

'   SendKeys "%{DOWN}"

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub Form_Unload(Cancel As Integer)

   Set oValor = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub txtCodigoCuenta_GotFocus()

   With txtCodigoCuenta
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoCuenta_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoCuenta_Validate(Cancel As Boolean)

   If IsNumeric(txtCodigoCuenta.Text) Then
      On Error GoTo SalidaConError
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorCodigo", Array(txtCodigoCuenta.Text, Me.FechaComprobante))
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdCuenta").Value = oRs.Fields(0).Value
      Else
         origen.Registro.Fields("IdCuenta").Value = Null
      End If
      oRs.Close
      Set oRs = Nothing
      Exit Sub
SalidaConError:
      Set oRs = Nothing
      origen.Registro.Fields(DataCombo1(0).DataField).Value = Null
   End If

End Sub

Private Sub txtCotizacionMonedaDestino_GotFocus()

   With txtCotizacionMonedaDestino
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCotizacionMonedaDestino_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtDebe_GotFocus()

   With txtDebe
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDebe_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtDebe_Validate(Cancel As Boolean)

'   If Len(Trim(txtDebe.Text)) <> 0 Then
'      txtHaber.Text = ""
'   End If
   
End Sub

Private Sub txtHaber_GotFocus()

   With txtHaber
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtHaber_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtHaber_Validate(Cancel As Boolean)

'   If Len(Trim(txtHaber.Text)) <> 0 Then
'      txtDebe.Text = ""
'   End If
   
End Sub

Public Property Get IdMoneda() As Integer

   IdMoneda = mvarIdMoneda
   
End Property

Public Property Let IdMoneda(ByVal vNewValue As Integer)

   mvarIdMoneda = vNewValue
   
End Property

Public Property Get FechaComprobante() As Date

   FechaComprobante = mFechaComprobante
   
End Property

Public Property Let FechaComprobante(ByVal vNewValue As Date)

   mFechaComprobante = vNewValue
   
End Property
