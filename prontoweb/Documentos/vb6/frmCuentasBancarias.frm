VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmCuentasBancarias 
   Caption         =   "Cuentas bancarias"
   ClientHeight    =   5175
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4860
   Icon            =   "frmCuentasBancarias.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5175
   ScaleWidth      =   4860
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtCaracteresBeneficiario 
      Alignment       =   2  'Center
      DataField       =   "CaracteresBeneficiario"
      Height          =   285
      Left            =   4050
      TabIndex        =   7
      Top             =   3150
      Visible         =   0   'False
      Width           =   450
   End
   Begin VB.TextBox txtInformacionAuxiliar 
      DataField       =   "InformacionAuxiliar"
      Height          =   285
      Left            =   1935
      TabIndex        =   9
      Top             =   4005
      Width           =   1125
   End
   Begin VB.TextBox txtCBU 
      DataField       =   "CBU"
      Height          =   285
      Left            =   1935
      TabIndex        =   8
      Top             =   3555
      Width           =   2565
   End
   Begin VB.TextBox txtChequesPorPlancha 
      Alignment       =   1  'Right Justify
      DataField       =   "ChequesPorPlancha"
      Height          =   285
      Left            =   1935
      TabIndex        =   6
      Top             =   2745
      Width           =   450
   End
   Begin VB.TextBox txPlantillaChequera 
      DataField       =   "PlantillaChequera"
      Height          =   285
      Left            =   1935
      TabIndex        =   5
      Top             =   2340
      Width           =   2565
   End
   Begin VB.TextBox txtDetalle 
      DataField       =   "Detalle"
      Height          =   285
      Left            =   1935
      TabIndex        =   0
      Top             =   180
      Width           =   2565
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   495
      TabIndex        =   10
      Top             =   4635
      Width           =   1170
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   3195
      TabIndex        =   12
      Top             =   4635
      Width           =   1170
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   1845
      TabIndex        =   11
      Top             =   4635
      Width           =   1170
   End
   Begin VB.TextBox txtCuenta 
      DataField       =   "Cuenta"
      Height          =   285
      Left            =   1935
      TabIndex        =   1
      Top             =   585
      Width           =   2565
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdBanco"
      Height          =   315
      Index           =   0
      Left            =   1935
      TabIndex        =   2
      Tag             =   "Bancos"
      Top             =   990
      Width           =   2595
      _ExtentX        =   4577
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdBanco"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   1
      Left            =   1935
      TabIndex        =   3
      Tag             =   "Monedas"
      Top             =   1440
      Width           =   2595
      _ExtentX        =   4577
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProvincia"
      Height          =   315
      Index           =   2
      Left            =   1935
      TabIndex        =   4
      Tag             =   "Provincias"
      Top             =   1890
      Width           =   2595
      _ExtentX        =   4577
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProvincia"
      Text            =   ""
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cant. caracteres para beneficiario (0 = sin limite) :"
      Height          =   240
      Index           =   6
      Left            =   315
      TabIndex        =   22
      Top             =   3165
      Visible         =   0   'False
      Width           =   3570
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Informacion auxiliar :"
      Height          =   240
      Index           =   5
      Left            =   315
      TabIndex        =   21
      Top             =   4020
      Width           =   1455
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "C.B.U. :"
      Height          =   240
      Index           =   4
      Left            =   315
      TabIndex        =   20
      Top             =   3570
      Width           =   1455
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cheques p/plancha"
      Height          =   240
      Index           =   3
      Left            =   315
      TabIndex        =   19
      Top             =   2760
      Width           =   1455
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Plantilla chequera : "
      Height          =   240
      Index           =   2
      Left            =   315
      TabIndex        =   18
      Top             =   2355
      Width           =   1455
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Detalle : "
      Height          =   240
      Index           =   0
      Left            =   315
      TabIndex        =   17
      Top             =   195
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      Caption         =   "Provincia  :"
      Height          =   240
      Index           =   1
      Left            =   315
      TabIndex        =   16
      Top             =   1920
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      Caption         =   "Moneda : "
      Height          =   240
      Index           =   0
      Left            =   315
      TabIndex        =   15
      Top             =   1470
      Width           =   1455
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuenta :"
      Height          =   240
      Index           =   1
      Left            =   315
      TabIndex        =   14
      Top             =   600
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      Caption         =   "Banco :"
      Height          =   240
      Index           =   6
      Left            =   315
      TabIndex        =   13
      Top             =   1020
      Width           =   1455
   End
End
Attribute VB_Name = "frmCuentasBancarias"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.CuentaBancaria
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mvarIdMonedaPesos As Long, mvarIdMonedaDolar As Long
Dim actL2 As ControlForm
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
   
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe indicar el banco", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(DataCombo1(1).BoundText) Then
            MsgBox "Debe indicar la moneda", vbExclamation
            Exit Sub
         End If
         
         If Len(txtCuenta.Text) = 0 Then
            MsgBox "Debe indicar la cuenta", vbExclamation
            Exit Sub
         End If
         
         If Len(txtCBU.Text) > 0 And Not IsNumeric(txtCBU.Text) Then
            MsgBox "El CBU debe ser numerico", vbExclamation
            Exit Sub
         End If
         
         Dim est As EnumAcciones
         
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
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("ALTA", mvarId, 0, Now, 0, "Tabla : CuentasBancarias", GetCompName(), glbNombreUsuario)
         Else
            est = Modificacion
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("MODIF", mvarId, 0, Now, 0, "Tabla : CuentasBancarias", GetCompName(), glbNombreUsuario)
         End If
            
         With actL2
            .ListaEditada = "CuentasBancarias"
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
         Aplicacion.Tarea "Log_InsertarRegistro", _
               Array("ELIM", mvarId, 0, Now, 0, "Tabla : CuentasBancarias", GetCompName(), glbNombreUsuario)
            
         With actL2
            .ListaEditada = "CuentasBancarias"
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

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   mvarId = vnewvalue
   
   If BuscarClaveINI("Controlar caracteres beneficiarios en emision de cheques") = "SI" Then
      lblFieldLabel(6).Visible = True
      txtCaracteresBeneficiario.Visible = True
   End If
   
   Set oAp = Aplicacion
   Set origen = oAp.CuentasBancarias.Item(vnewvalue)
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      mvarIdMonedaPesos = .Fields("IdMoneda").Value
      mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
   End With
   oRs.Close
   
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
               If oControl.Tag = "Bancos" Then
                  Set oControl.RowSource = oAp.Bancos.TraerFiltrado("_ConCuenta1")
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
         .Fields("IdMoneda").Value = mvarIdMonedaPesos
         .Fields("CaracteresBeneficiario").Value = 0
      End With
   Else
   
   End If
   
   cmd(1).Enabled = False
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      If mvarId > 0 Then cmd(1).Enabled = True
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
   End If

End Sub

Private Sub Form_Load()

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

Private Sub txPlantillaChequera_GotFocus()

   With txPlantillaChequera
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txPlantillaChequera_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txPlantillaChequera
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtCaracteresBeneficiario_GotFocus()

   With txtCaracteresBeneficiario
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCaracteresBeneficiario_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCBU_GotFocus()

   With txtCBU
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCBU_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCBU
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtChequesPorPlancha_GotFocus()

   With txtChequesPorPlancha
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtChequesPorPlancha_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCuenta_GotFocus()

   With txtCuenta
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCuenta_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCuenta
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

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

Private Sub txtInformacionAuxiliar_GotFocus()

   With txtInformacionAuxiliar
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtInformacionAuxiliar_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtInformacionAuxiliar
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
