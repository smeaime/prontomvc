VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form frmDetCuentas 
   Caption         =   "Detalle cuentas contables"
   ClientHeight    =   2025
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8730
   LinkTopic       =   "Form1"
   ScaleHeight     =   2025
   ScaleWidth      =   8730
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtJerarquia 
      Height          =   285
      Index           =   0
      Left            =   5940
      TabIndex        =   1
      Top             =   180
      Width           =   360
   End
   Begin VB.TextBox txtJerarquia 
      Height          =   285
      Index           =   1
      Left            =   6390
      TabIndex        =   2
      Top             =   180
      Width           =   360
   End
   Begin VB.TextBox txtJerarquia 
      Height          =   285
      Index           =   2
      Left            =   6840
      TabIndex        =   3
      Top             =   180
      Width           =   495
   End
   Begin VB.TextBox txtJerarquia 
      Height          =   285
      Index           =   3
      Left            =   7425
      TabIndex        =   4
      Top             =   180
      Width           =   495
   End
   Begin VB.TextBox txtJerarquia 
      Height          =   285
      Index           =   4
      Left            =   8010
      TabIndex        =   5
      Top             =   180
      Width           =   495
   End
   Begin VB.TextBox txtCodigoAnterior 
      Alignment       =   2  'Center
      DataField       =   "CodigoAnterior"
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
      Left            =   2205
      TabIndex        =   0
      Top             =   180
      Width           =   1365
   End
   Begin VB.TextBox txtNombreAnterior 
      DataField       =   "NombreAnterior"
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
      Left            =   2205
      TabIndex        =   6
      Top             =   585
      Width           =   6315
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1980
      TabIndex        =   9
      Top             =   1530
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   225
      TabIndex        =   8
      Top             =   1530
      Width           =   1485
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaCambio"
      Height          =   330
      Index           =   0
      Left            =   2205
      TabIndex        =   7
      Top             =   990
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   59703297
      CurrentDate     =   36377
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Jerarquia :"
      Height          =   240
      Index           =   4
      Left            =   4950
      TabIndex        =   13
      Top             =   225
      Width           =   900
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo anterior :"
      Height          =   300
      Index           =   0
      Left            =   270
      TabIndex        =   12
      Top             =   180
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nombre anterior :"
      Height          =   300
      Index           =   7
      Left            =   270
      TabIndex        =   11
      Top             =   585
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha del cambio :"
      Height          =   285
      Index           =   4
      Left            =   270
      TabIndex        =   10
      Top             =   990
      Width           =   1845
   End
End
Attribute VB_Name = "frmDetCuentas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetCuenta
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oCuenta As ComPronto.Cuenta
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
'         If Len(txtNombreAnterior.Text) = 0 Then
'            MsgBox "Falta ingresar el nombre anterior", vbCritical
'            Exit Sub
'         End If
         
         If Len(txtCodigoAnterior.Text) = 0 Then
            MsgBox "Falta ingresar el codigo anterior", vbCritical
            Exit Sub
         End If
         
         If Not IsNumeric(txtCodigoAnterior.Text) Then
            MsgBox "El codigo anterior debe ser un numero", vbCritical
            Exit Sub
         End If
         
         Dim dtp As DTPicker
         Dim i As Integer
         Dim mJerarquias As String
         
         For i = 0 To 4
            mJerarquias = mJerarquias & txtJerarquia(i).Text & "."
         Next
         If Len(mJerarquias) > 0 Then mJerarquias = mId(mJerarquias, 1, Len(mJerarquias) - 1)
         
         With origen.Registro
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
            .Fields("JerarquiaAnterior").Value = mJerarquias
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
   Dim oRs As ADOR.Recordset
   Dim mJerarquias
   Dim i As Integer

   Set oAp = Aplicacion
   
   mvarId = vNewValue
   
   Set origen = oCuenta.DetCuentas.Item(vNewValue)
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
            Set oControl.DataSource = origen
         End If
      Next
   End With
   
   If mvarId = -1 Then
      DTFields(0).Value = Date
      With origen.Registro
         .Fields("CodigoAnterior").Value = oCuenta.Registro.Fields("Codigo").Value
         mJerarquias = VBA.Split(oCuenta.Registro.Fields("Jerarquia").Value, ".")
         For i = 0 To 4
            txtJerarquia(i).Text = mJerarquias(i)
         Next
      End With
   Else
      With origen.Registro
         If Not IsNull(.Fields("JerarquiaAnterior").Value) Then
            mJerarquias = VBA.Split(.Fields("JerarquiaAnterior").Value, ".")
            For i = 0 To 4
               txtJerarquia(i).Text = mJerarquias(i)
            Next
         End If
      End With
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
End Property

Public Property Get Cuenta() As ComPronto.Cuenta

   Set Cuenta = oCuenta

End Property

Public Property Set Cuenta(ByVal vNewValue As ComPronto.Cuenta)

   Set oCuenta = vNewValue

End Property

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Load()

   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oBind = Nothing
   Set origen = Nothing
   Set oCuenta = Nothing

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub txtCodigoAnterior_GotFocus()

   With txtCodigoAnterior
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoAnterior_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtJerarquia_GotFocus(Index As Integer)

   With txtJerarquia(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
End Sub

Private Sub txtJerarquia_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      If (KeyAscii < 48 Or KeyAscii > 57) And KeyAscii <> vbKeyBack Then
         KeyAscii = 0
      Else
         If (Index <= 1 And Len(txtJerarquia(Index)) >= 1) Or _
            (Index > 1 And Len(txtJerarquia(Index)) >= 2) Then
            txtJerarquia(Index) = ""
         End If
      End If
   End If

End Sub

Private Sub txtJerarquia_Validate(Index As Integer, Cancel As Boolean)

   Dim mDigitos As Integer
   If Index <= 1 Then mDigitos = 1 Else mDigitos = 2
   If (Index <= 1 And Len(txtJerarquia(Index)) <> 1) Or _
      (Index > 1 And Len(txtJerarquia(Index)) <> 2) Then
      MsgBox "El nivel debe tener " & mDigitos & " digitos"
      Cancel = True
   End If
   
End Sub

Private Sub txtNombreAnterior_GotFocus()

   With txtNombreAnterior
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNombreAnterior_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtNombreAnterior
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
