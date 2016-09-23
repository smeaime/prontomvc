VERSION 5.00
Begin VB.Form frmCoeficientesImpositivos 
   Caption         =   "Coeficientes Impositivos"
   ClientHeight    =   2625
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4440
   Icon            =   "frmCoeficientesImpositivos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2625
   ScaleWidth      =   4440
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtAñoFiscal 
      DataField       =   "AñoFiscal"
      Height          =   285
      Left            =   2985
      TabIndex        =   0
      Top             =   180
      Width           =   945
   End
   Begin VB.TextBox txtCoeficienteActualizacion 
      Alignment       =   1  'Right Justify
      DataField       =   "CoeficienteActualizacion"
      Height          =   285
      Left            =   2985
      TabIndex        =   3
      Top             =   1485
      Width           =   1260
   End
   Begin VB.TextBox txtMes 
      DataField       =   "Mes"
      Height          =   285
      Left            =   2985
      TabIndex        =   2
      Top             =   1065
      Width           =   450
   End
   Begin VB.TextBox txtAño 
      DataField       =   "Año"
      Height          =   285
      Left            =   2985
      TabIndex        =   1
      Top             =   630
      Width           =   945
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   1635
      TabIndex        =   5
      Top             =   2055
      Width           =   1125
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   2925
      TabIndex        =   6
      Top             =   2055
      Width           =   1125
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   345
      TabIndex        =   4
      Top             =   2055
      Width           =   1125
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Año fiscal : "
      Height          =   255
      Index           =   3
      Left            =   225
      TabIndex        =   10
      Top             =   195
      Width           =   2670
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Coeficiente de actualizacion :"
      Height          =   255
      Index           =   0
      Left            =   225
      TabIndex        =   9
      Top             =   1500
      Width           =   2670
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Mes :"
      Height          =   255
      Index           =   2
      Left            =   225
      TabIndex        =   8
      Top             =   1080
      Width           =   2670
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Año : "
      Height          =   255
      Index           =   1
      Left            =   225
      TabIndex        =   7
      Top             =   645
      Width           =   2670
   End
End
Attribute VB_Name = "frmCoeficientesImpositivos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.CoeficienteImpositivo
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long
Private mNivelAcceso As Integer, mOpcionesAcceso As String

Public Property Let NivelAcceso(ByVal mNivelA As EnumAccesos)
   
   mNivelAcceso = mNivelA
   
End Property

Public Property Get NivelAcceso() As EnumAccesos

   NivelAcceso = mNivelAcceso
   
End Property

Public Property Let OpcionesAcceso(ByVal mOpcionesA As String)
   
   mOpcionesAcceso = mOpcionesA
   
End Property

Public Property Get OpcionesAcceso() As String

   OpcionesAcceso = mOpcionesAcceso
   
End Property

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
   
         If Len(txtAñoFiscal.Text) = 0 Or Not IsNumeric(txtAñoFiscal.Text) Then
            MsgBox "Debe ingresar un año fiscal valido", vbExclamation
            Exit Sub
         End If
         If Val(txtAñoFiscal.Text) < 1900 Or Val(txtAñoFiscal.Text) > 2100 Then
            MsgBox "Debe ingresar un año fiscal valido", vbExclamation
            Exit Sub
         End If
         
         If Len(txtAño.Text) = 0 Or Not IsNumeric(txtAño.Text) Then
            MsgBox "Debe ingresar un año valido", vbExclamation
            Exit Sub
         End If
         If Val(txtAño.Text) < 1900 Or Val(txtAño.Text) > 2100 Then
            MsgBox "Debe ingresar un año valido", vbExclamation
            Exit Sub
         End If
         
         If Len(txtMes.Text) = 0 Or Not IsNumeric(txtMes.Text) Then
            MsgBox "Debe ingresar un mes valido", vbExclamation
            Exit Sub
         End If
         If Val(txtMes.Text) < 1 Or Val(txtMes.Text) > 12 Then
            MsgBox "Debe ingresar un mes valido", vbExclamation
            Exit Sub
         End If
         
         If Len(txtCoeficienteActualizacion.Text) = 0 Or _
               Not IsNumeric(txtCoeficienteActualizacion.Text) Then
            MsgBox "Debe ingresar un coeficiente valido", vbExclamation
            Exit Sub
         End If
         
         Dim est As EnumAcciones
         Dim oControl As Control
   
         For Each oControl In Me.Controls
            If TypeOf oControl Is DataCombo Then
               If Len(oControl.BoundText) <> 0 Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
               End If
            ElseIf TypeOf oControl Is DTPicker Then
               origen.Registro.Fields(oControl.DataField).Value = oControl.Value
            End If
         Next
      
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
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "CoeficientesImpositivos"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
      Case 1
   
         Dim mBorra As Integer
         mBorra = MsgBox("Esta seguro de eliminar los datos definitivamente ?", vbYesNo, "Eliminar")
         If mBorra = vbNo Then
            Exit Sub
         End If
         
         origen.Eliminar
         
         est = baja
            
         With actL2
            .ListaEditada = "CoeficientesImpositivos"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
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

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oAp.CoeficientesImpositivos.Item(vnewvalue)
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
   
   cmd(1).Enabled = False
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      If mvarId > 0 Then cmd(1).Enabled = True
   End If
   
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Form_Load()

   If mvarId < 0 Then
      cmd(1).Enabled = False
   End If
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub txtAño_GotFocus()

   With txtAño
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAño_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtAñoFiscal_GotFocus()

   With txtAñoFiscal
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAñoFiscal_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCoeficienteActualizacion_GotFocus()

   With txtCoeficienteActualizacion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCoeficienteActualizacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtMes_GotFocus()

   With txtMes
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtMes_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub


