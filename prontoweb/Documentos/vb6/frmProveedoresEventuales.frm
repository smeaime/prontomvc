VERSION 5.00
Object = "{F09A78C8-7814-11D2-8355-4854E82A9183}#1.1#0"; "CUIT32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmProveedoresEventuales 
   Caption         =   "Proveedores eventuales"
   ClientHeight    =   2925
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8235
   Icon            =   "frmProveedoresEventuales.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2925
   ScaleWidth      =   8235
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtEmail 
      DataField       =   "Email"
      Height          =   285
      Left            =   2160
      TabIndex        =   4
      Top             =   1755
      Width           =   3465
   End
   Begin VB.TextBox txtTelefono 
      DataField       =   "Telefono1"
      Height          =   285
      Left            =   2160
      TabIndex        =   3
      Top             =   1350
      Width           =   3465
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1665
      TabIndex        =   5
      Top             =   2385
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   5085
      TabIndex        =   7
      Top             =   2385
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   3375
      TabIndex        =   6
      Top             =   2385
      Width           =   1485
   End
   Begin VB.TextBox txtRazonSocial 
      DataField       =   "RazonSocial"
      Height          =   285
      Left            =   2160
      TabIndex        =   0
      Top             =   225
      Width           =   5850
   End
   Begin Control_CUIT.CUIT CUIT1 
      Height          =   285
      Left            =   2160
      TabIndex        =   1
      Top             =   585
      Width           =   1545
      _ExtentX        =   2725
      _ExtentY        =   503
      Text            =   ""
      MensajeErr      =   "CUIT incorrecto"
      otrosP          =   -1  'True
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCodigoIva"
      Height          =   315
      Index           =   1
      Left            =   2160
      TabIndex        =   2
      Tag             =   "DescripcionIva"
      Top             =   945
      Width           =   3600
      _ExtentX        =   6350
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCodigoIva"
      Text            =   ""
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Email :"
      Height          =   210
      Index           =   11
      Left            =   225
      TabIndex        =   12
      Top             =   1800
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Telefono :"
      Height          =   255
      Index           =   9
      Left            =   225
      TabIndex        =   11
      Top             =   1380
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Razon social :"
      Height          =   255
      Index           =   2
      Left            =   225
      TabIndex        =   10
      Top             =   225
      Width           =   1815
   End
   Begin VB.Label lblData 
      Alignment       =   1  'Right Justify
      Caption         =   "Condicion de IVA :"
      Height          =   255
      Index           =   1
      Left            =   225
      TabIndex        =   9
      Top             =   990
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Cuit :"
      Height          =   210
      Index           =   12
      Left            =   225
      TabIndex        =   8
      Top             =   630
      Width           =   1815
   End
End
Attribute VB_Name = "frmProveedoresEventuales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Proveedor
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
   
         Dim est As EnumAcciones
         Dim oControl As Control
         Dim oRs As ADOR.Recordset
   
         If Len(Trim(txtRazonSocial.Text)) = 0 Then
            MsgBox "Falta completar el campo razon social", vbCritical
            Exit Sub
         End If
         
         For Each oControl In Me.Controls
            If TypeOf oControl Is DataCombo Then
               If Len(oControl.BoundText) <> 0 Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
               Else
                  MsgBox "Debe ingresar la condicion de IVA", vbCritical
                  Exit Sub
               End If
            ElseIf TypeOf oControl Is DTPicker Then
               origen.Registro.Fields(oControl.DataField).Value = oControl.Value
            End If
         Next
      
         With origen.Registro
            If Len(Trim(CUIT1.Text)) = 0 Then
               Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DescripcionIva", "_PorId", .Fields("IdCodigoIva").Value)
               If oRs.RecordCount > 0 Then
                  If Not IsNull(oRs.Fields("ExigirCUIT").Value) And _
                        oRs.Fields("ExigirCUIT").Value = "SI" Then
                     MsgBox "Debe ingresar el numero de CUIT para esta condicion", vbCritical
                     oRs.Close
                     Set oRs = Nothing
                     Exit Sub
                  End If
               End If
               oRs.Close
               Set oRs = Nothing
            End If
            .Fields("Cuit").Value = CUIT1.Text
            .Fields("Confirmado").Value = "SI"
            .Fields("Eventual").Value = "SI"
            .Fields("EnviarEmail").Value = 1
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
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "ProveedoresEventuales,ProveedoresAConfirmar"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
      Case 1
   
         Dim mBorra As Integer
         mBorra = MsgBox("Esta seguro de eliminar los datos definitivamente ?", vbYesNo, "Eliminar")
         If mBorra = vbNo Then
            Exit Sub
         End If
         
         Dim oRs1 As ADOR.Recordset
         Set oRs1 = Aplicacion.ComprobantesProveedores.TraerFiltrado("_VerificarProveedor", mvarId)
         If oRs1.RecordCount > 0 Then
            oRs1.Close
            Set oRs1 = Nothing
            MsgBox "Existen comprobantes asignados a este proveedor, eliminacion abortada", vbExclamation
            Exit Sub
         End If
         oRs1.Close
         Set oRs1 = Nothing
         
         origen.Eliminar
         
         est = baja
            
         With actL2
            .ListaEditada = "ProveedoresEventuales"
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
   Set origen = oAp.Proveedores.Item(vnewvalue)
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
   
   If mvarId = -1 Then
   Else
      With origen.Registro
         CUIT1.Text = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
      End With
   End If
   
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

Private Sub CUIT1_Validate(Cancel As Boolean)

   If Len(CUIT1.Text) > 0 Then
      Dim oRs As ADOR.Recordset
      Dim s As String
      Dim mvarSeguro As Integer
      Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ValidarPorCuit", Array(mvarId, CUIT1.Text))
      s = ""
      With oRs
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               s = s & .Fields("RazonSocial").Value & vbCrLf
               .MoveNext
            Loop
         End If
         .Close
      End With
      Set oRs = Nothing
      If Len(s) > 0 Then
         mvarSeguro = MsgBox("El CUIT lo tienen los siguientes proveedores :" & vbCrLf & s & "Desea continuar ?", vbYesNo, "CUIT")
         If mvarSeguro = vbNo Then
            Cancel = True
         End If
      End If
   End If
   
End Sub

Private Sub Form_Load()

   If mvarId < 0 Then cmd(1).Enabled = False
   
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

Private Sub txtEmail_GotFocus()

   With txtEmail
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtEmail_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtEmail
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtRazonSocial_GotFocus()

   With txtRazonSocial
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtRazonSocial_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtRazonSocial
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtTelefono_GotFocus()

   With txtTelefono
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTelefono_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtTelefono
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
