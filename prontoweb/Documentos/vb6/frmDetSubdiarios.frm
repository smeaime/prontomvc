VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetSubdiarios 
   Caption         =   "Item de subdiario contable"
   ClientHeight    =   3405
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7005
   Icon            =   "frmDetSubdiarios.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3405
   ScaleWidth      =   7005
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtTC 
      Height          =   285
      Left            =   3555
      TabIndex        =   18
      Top             =   2610
      Visible         =   0   'False
      Width           =   330
   End
   Begin VB.TextBox txtCT 
      Height          =   285
      Left            =   3555
      TabIndex        =   17
      Top             =   2970
      Visible         =   0   'False
      Width           =   330
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   405
      Index           =   1
      Left            =   2025
      TabIndex        =   7
      Top             =   2835
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   270
      TabIndex        =   6
      Top             =   2835
      Width           =   1485
   End
   Begin VB.TextBox txtCodigo 
      DataField       =   "Codigo"
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
      Left            =   2250
      TabIndex        =   0
      Top             =   180
      Width           =   1545
   End
   Begin VB.TextBox txtDebe 
      Alignment       =   1  'Right Justify
      DataField       =   "Debe"
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
      Left            =   900
      TabIndex        =   5
      Top             =   2250
      Width           =   1095
   End
   Begin VB.TextBox txtNumeroComprobante 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroComprobante"
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
      Left            =   2250
      TabIndex        =   4
      Top             =   1710
      Width           =   1320
   End
   Begin VB.TextBox txtHaber 
      Alignment       =   1  'Right Justify
      DataField       =   "Haber"
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
      Left            =   2790
      TabIndex        =   3
      Top             =   2250
      Width           =   1095
   End
   Begin VB.TextBox txtCodigoComprobante 
      Alignment       =   2  'Center
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
      Left            =   2250
      TabIndex        =   2
      Top             =   1035
      Width           =   555
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   0
      Left            =   2250
      TabIndex        =   1
      Tag             =   "Cuentas"
      Top             =   540
      Width           =   4515
      _ExtentX        =   7964
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdTipoComprobante"
      Height          =   2325
      Index           =   1
      Left            =   3960
      TabIndex        =   8
      Tag             =   "TiposComprobante"
      Top             =   945
      Width           =   2805
      _ExtentX        =   4948
      _ExtentY        =   4101
      _Version        =   393216
      Style           =   1
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoComprobante"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaComprobante"
      Height          =   330
      Index           =   0
      Left            =   2250
      TabIndex        =   9
      Top             =   1350
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   582
      _Version        =   393216
      Format          =   59113473
      CurrentDate     =   36377
   End
   Begin VB.Label lblLabels 
      Caption         =   "Descripcion :"
      Height          =   300
      Index           =   2
      Left            =   270
      TabIndex        =   16
      Top             =   540
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta :"
      Height          =   300
      Index           =   6
      Left            =   270
      TabIndex        =   15
      Top             =   195
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Debe :"
      Height          =   300
      Index           =   8
      Left            =   270
      TabIndex        =   14
      Top             =   2250
      Width           =   555
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tipo de comprobante :"
      Height          =   300
      Index           =   0
      Left            =   270
      TabIndex        =   13
      Top             =   1035
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de comprobante :"
      Height          =   300
      Index           =   3
      Left            =   270
      TabIndex        =   12
      Top             =   1395
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de comprobante :"
      Height          =   300
      Index           =   4
      Left            =   270
      TabIndex        =   11
      Top             =   1755
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Haber :"
      Height          =   300
      Index           =   10
      Left            =   2160
      TabIndex        =   10
      Top             =   2250
      Width           =   555
   End
End
Attribute VB_Name = "frmDetSubdiarios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Subdiario
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mIdCuentaSubdiario As Long

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then
      
      Dim dtp As DTPicker
      
      With origen.Registro
         For Each dtp In DTFields
            .Fields(dtp.DataField).Value = dtp.Value
         Next
         If IsNumeric(DataCombo1(0).BoundText) Then
            txtCT.Text = Aplicacion.Cuentas.Item(DataCombo1(0).BoundText).Registro.Fields("Descripcion").Value
         End If
         If IsNumeric(DataCombo1(1).BoundText) Then
            .Fields("IdTipoComprobante").Value = DataCombo1(1).BoundText
            txtTC.Text = Aplicacion.TiposComprobante.Item(DataCombo1(1).BoundText).Registro.Fields("DescripcionAb").Value
         End If
         .Fields("FechaComprobante").Value = DTFields(0).Value
         .Fields("IdCuentaSubdiario").Value = Me.IdCuentaSubdiario
      End With
      
      origen.Guardar
      Aceptado = True
   
   End If
   
   Me.Hide

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oAp.Subdiarios.Item(vNewValue)
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
   
   DTFields(0).Value = Date
   
   If mvarId <> -1 Then
      With origen.Registro
         DTFields(0).Value = .Fields("FechaComprobante").Value
         If IsNull(.Fields("IdTipoComprobante").Value) Then
         Else
            txtCodigoComprobante.Text = oAp.TiposComprobante.Item(.Fields("IdTipoComprobante").Value).Registro.Fields("DescripcionAB").Value
         End If
      End With
   End If
   
   Set oAp = Nothing
   
End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      Dim oRs As ADOR.Recordset
      Select Case Index
         Case 0
            Set oRs = Aplicacion.Cuentas.Item(DataCombo1(0).BoundText).Registro
            With origen.Registro
               .Fields(DataCombo1(0).DataField).Value = DataCombo1(0).BoundText
            End With
            txtCodigo.Text = oRs.Fields("Codigo").Value
            oRs.Close
            Set oRs = Nothing
         Case 1
            txtCodigoComprobante.Text = Aplicacion.TiposComprobante.Item(DataCombo1(1).BoundText).Registro.Fields("DescripcionAb").Value
      End Select
   End If

End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)

   SendKeys "%{DOWN}"

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Load()

   DisableCloseButton Me
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

   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub txtCodigo_Change()

   If Len(txtCodigo.Text) > 8 Then
      txtCodigo.Text = mId(txtCodigo.Text, 1, 10)
   End If
   
End Sub

Private Sub txtCodigo_GotFocus()

   With txtCodigo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCodigo_Validate(Cancel As Boolean)

   If Len(Trim(txtCodigo.Text)) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("Cod", txtCodigo.Text)
      If oRs.RecordCount < 1 Then
         MsgBox "Cuenta inexistente en archivo", vbCritical
         Cancel = True
      Else
         origen.Registro.Fields("IdCuenta").Value = oRs.Fields(0).Value
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

Private Sub txtCodigoComprobante_GotFocus()

   With txtCodigoComprobante
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoComprobante_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   ElseIf KeyAscii >= 97 And KeyAscii <= 122 Then
      KeyAscii = KeyAscii - 32
   End If
   
End Sub

Private Sub txtCodigoComprobante_Validate(Cancel As Boolean)

   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.TiposComprobante.TraerFiltrado("_PorAbreviatura", txtCodigoComprobante.Text)
   If oRs.RecordCount = 0 Then
      MsgBox "Comprobante inexistente", vbExclamation
      txtCodigoComprobante.Text = ""
      Cancel = True
   Else
      DataCombo1(1).BoundText = oRs.Fields(0).Value
   End If
   oRs.Close
   Set oRs = Nothing

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

Private Sub txtHaber_GotFocus()

   With txtHaber
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtHaber_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtNumeroComprobante_GotFocus()

   With txtNumeroComprobante
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroComprobante_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Public Property Get IdCuentaSubdiario() As Long

   IdCuentaSubdiario = mIdCuentaSubdiario
   
End Property

Public Property Let IdCuentaSubdiario(ByVal vNewValue As Long)

   mIdCuentaSubdiario = vNewValue
   
End Property
