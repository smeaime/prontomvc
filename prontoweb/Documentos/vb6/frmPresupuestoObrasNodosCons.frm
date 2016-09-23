VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form frmPresupuestoObrasNodosCons 
   Caption         =   "Consumo directo"
   ClientHeight    =   2625
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7455
   LinkTopic       =   "Form1"
   ScaleHeight     =   2625
   ScaleWidth      =   7455
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtNumero 
      Alignment       =   2  'Center
      DataField       =   "Numero"
      Height          =   285
      Left            =   2220
      TabIndex        =   0
      Top             =   270
      Width           =   1320
   End
   Begin VB.TextBox txtDetalle 
      DataField       =   "Detalle"
      Height          =   285
      Left            =   2250
      TabIndex        =   2
      Top             =   1080
      Width           =   5085
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1380
      TabIndex        =   4
      Top             =   2070
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   4800
      TabIndex        =   6
      Top             =   2070
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   3090
      TabIndex        =   5
      Top             =   2070
      Width           =   1485
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "Importe"
      Height          =   285
      Left            =   2220
      TabIndex        =   3
      Top             =   1485
      Width           =   1350
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "Fecha"
      Height          =   285
      Index           =   0
      Left            =   2220
      TabIndex        =   1
      Top             =   675
      Width           =   1320
      _ExtentX        =   2328
      _ExtentY        =   503
      _Version        =   393216
      Format          =   56688641
      CurrentDate     =   29221
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Numero comprobante :"
      Height          =   255
      Index           =   3
      Left            =   180
      TabIndex        =   10
      Top             =   270
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Fecha :"
      Height          =   255
      Index           =   2
      Left            =   180
      TabIndex        =   9
      Top             =   675
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Detalle :"
      Height          =   255
      Index           =   1
      Left            =   180
      TabIndex        =   8
      Top             =   1095
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Importe :"
      Height          =   255
      Index           =   0
      Left            =   180
      TabIndex        =   7
      Top             =   1500
      Width           =   1815
   End
End
Attribute VB_Name = "frmPresupuestoObrasNodosCons"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.PresupuestoObraNodoCons
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mIdPresupuestoObrasNodo As Long

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
   
         Dim oControl As Control
   
         If Len(Trim(txtNumero.Text)) = 0 Then
            MsgBox "Falta completar el campo numero", vbCritical
            Exit Sub
         End If
         
         If Len(Trim(txtImporte.Text)) = 0 Then
            MsgBox "Falta completar el campo numero", vbCritical
            Exit Sub
         End If
         
         For Each oControl In Me.Controls
            If TypeOf oControl Is DataCombo Then
               If Len(oControl.BoundText) <> 0 Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
               End If
            ElseIf TypeOf oControl Is DTPicker Then
               origen.Registro.Fields(oControl.DataField).Value = oControl.Value
            End If
         Next
      
         With origen.Registro
            .Fields("IdPresupuestoObrasNodo").Value = Me.IdPresupuestoObrasNodo
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
      
         If mvarId < 0 Then mvarId = origen.Registro.Fields(0).Value
            
      Case 1
   
         Dim mBorra As Integer
         mBorra = MsgBox("Esta seguro de eliminar los datos definitivamente ?", vbYesNo, "Eliminar")
         If mBorra = vbNo Then
            Exit Sub
         End If
         
         origen.Eliminar
   End Select
   
   Unload Me

   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case -2147217900
         mvarResp = MsgBox("No puede borrar este registro porque se esta" & vbCrLf & "utilizando en otros archivos. Desea ver detalles?", vbYesNo + vbCritical)
         If mvarResp = vbYes Then
            MsgBox "Detalle del error : " & vbCrLf & Err.Number & " -> " & Err.Description
         End If
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   
   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oAp.PresupuestoObrasNodosCons.Item(vNewValue)
   
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
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   End With
   
   If mvarId <= 0 Then
      DTPicker1(0).Value = Date
   Else
   End If
   
   Set oAp = Nothing

End Property

Private Sub Form_Load()

   If mvarId < 0 Then cmd(1).Enabled = False
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub txtDetalle_GotFocus()

   With txtDetalle
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDetalle_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDetalle
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtImporte_GotFocus()

   With txtImporte
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImporte_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumero_GotFocus()

   With txtNumero
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumero_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Get IdPresupuestoObrasNodo() As Long

   IdPresupuestoObrasNodo = mIdPresupuestoObrasNodo

End Property

Public Property Let IdPresupuestoObrasNodo(ByVal vNewValue As Long)

   mIdPresupuestoObrasNodo = vNewValue

End Property
