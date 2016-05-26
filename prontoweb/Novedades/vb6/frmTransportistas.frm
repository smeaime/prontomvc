VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmTransportistas 
   Caption         =   "Transportistas"
   ClientHeight    =   8115
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5775
   Icon            =   "frmTransportistas.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8115
   ScaleWidth      =   5775
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check1 
      Height          =   330
      Left            =   2205
      TabIndex        =   35
      Top             =   6885
      Width           =   150
   End
   Begin VB.TextBox txtHorario 
      DataField       =   "Horario"
      Height          =   285
      Left            =   2175
      TabIndex        =   13
      Top             =   5195
      Width           =   3375
   End
   Begin VB.TextBox txtCelular 
      DataField       =   "Celular"
      Height          =   285
      Left            =   2175
      TabIndex        =   7
      Top             =   2835
      Width           =   3375
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1185
      Left            =   2175
      TabIndex        =   17
      Top             =   5580
      Width           =   3390
      _ExtentX        =   5980
      _ExtentY        =   2090
      _Version        =   393217
      TextRTF         =   $"frmTransportistas.frx":076A
   End
   Begin VB.TextBox txtContacto 
      DataField       =   "Contacto"
      Height          =   285
      Left            =   2175
      TabIndex        =   12
      Top             =   4815
      Width           =   3375
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   2130
      TabIndex        =   15
      Top             =   7515
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   3975
      TabIndex        =   16
      Top             =   7515
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   285
      TabIndex        =   14
      Top             =   7515
      Width           =   1485
   End
   Begin VB.TextBox txtCuit 
      DataField       =   "Cuit"
      Height          =   285
      Left            =   2175
      TabIndex        =   11
      Top             =   4410
      Width           =   2175
   End
   Begin VB.TextBox txtEmail 
      DataField       =   "Email"
      Height          =   285
      Left            =   2175
      TabIndex        =   9
      Top             =   3600
      Width           =   3375
   End
   Begin VB.TextBox txtFax 
      DataField       =   "Fax"
      Height          =   285
      Left            =   2175
      TabIndex        =   8
      Top             =   3240
      Width           =   3375
   End
   Begin VB.TextBox txtTelefono 
      DataField       =   "Telefono"
      Height          =   285
      Left            =   2175
      TabIndex        =   6
      Top             =   2475
      Width           =   3375
   End
   Begin VB.TextBox txtCodigoPostal 
      DataField       =   "CodigoPostal"
      Height          =   285
      Left            =   2175
      TabIndex        =   3
      Top             =   1305
      Width           =   3390
   End
   Begin VB.TextBox txtDireccion 
      DataField       =   "Direccion"
      Height          =   285
      Left            =   2175
      TabIndex        =   1
      Top             =   515
      Width           =   3375
   End
   Begin VB.TextBox txtRazonSocial 
      DataField       =   "RazonSocial"
      Height          =   285
      Left            =   2175
      TabIndex        =   0
      Top             =   135
      Width           =   3375
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdLocalidad"
      Height          =   315
      Index           =   0
      Left            =   2175
      TabIndex        =   2
      Tag             =   "Localidades"
      Top             =   900
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdLocalidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCodigoIva"
      Height          =   315
      Index           =   3
      Left            =   2175
      TabIndex        =   10
      Tag             =   "DescripcionIva"
      Top             =   4005
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCodigoIva"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProvincia"
      Height          =   315
      Index           =   1
      Left            =   2175
      TabIndex        =   4
      Tag             =   "Provincias"
      Top             =   1685
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProvincia"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdPais"
      Height          =   315
      Index           =   2
      Left            =   2175
      TabIndex        =   5
      Tag             =   "Paises"
      Top             =   2070
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPais"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   4
      Left            =   2475
      TabIndex        =   33
      Tag             =   "Proveedores"
      Top             =   6885
      Width           =   3105
      _ExtentX        =   5477
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin VB.Label lblData 
      Alignment       =   1  'Right Justify
      Caption         =   "Proveedor relacionado :"
      Height          =   255
      Index           =   4
      Left            =   225
      TabIndex        =   34
      Top             =   6930
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Horario :"
      Height          =   255
      Index           =   1
      Left            =   225
      TabIndex        =   32
      Top             =   5194
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Celular :"
      Height          =   255
      Index           =   0
      Left            =   225
      TabIndex        =   31
      Top             =   2866
      Width           =   1815
   End
   Begin VB.Label lblData 
      Alignment       =   1  'Right Justify
      Caption         =   "Codigo de IVA:"
      Height          =   255
      Index           =   3
      Left            =   225
      TabIndex        =   30
      Top             =   4030
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Cuit:"
      Height          =   255
      Index           =   12
      Left            =   225
      TabIndex        =   29
      Top             =   4418
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Email:"
      Height          =   255
      Index           =   11
      Left            =   225
      TabIndex        =   28
      Top             =   3642
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Fax:"
      Height          =   255
      Index           =   10
      Left            =   225
      TabIndex        =   27
      Top             =   3254
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Telefono:"
      Height          =   255
      Index           =   9
      Left            =   225
      TabIndex        =   26
      Top             =   2478
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Codigo postal:"
      Height          =   255
      Index           =   5
      Left            =   225
      TabIndex        =   25
      Top             =   1314
      Width           =   1815
   End
   Begin VB.Label lblData 
      Alignment       =   1  'Right Justify
      Caption         =   "Localidad:"
      Height          =   255
      Index           =   0
      Left            =   225
      TabIndex        =   24
      Top             =   926
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Direccion:"
      Height          =   255
      Index           =   3
      Left            =   225
      TabIndex        =   23
      Top             =   538
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Razon social:"
      Height          =   255
      Index           =   2
      Left            =   225
      TabIndex        =   22
      Top             =   150
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Contacto:"
      Height          =   255
      Index           =   24
      Left            =   225
      TabIndex        =   21
      Top             =   4806
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Observaciones :"
      Height          =   255
      Index           =   21
      Left            =   225
      TabIndex        =   20
      Top             =   5595
      Width           =   1815
   End
   Begin VB.Label lblData 
      Alignment       =   1  'Right Justify
      Caption         =   "Provincia:"
      Height          =   255
      Index           =   1
      Left            =   225
      TabIndex        =   19
      Top             =   1702
      Width           =   1815
   End
   Begin VB.Label lblData 
      Alignment       =   1  'Right Justify
      Caption         =   "Pais :"
      Height          =   255
      Index           =   2
      Left            =   225
      TabIndex        =   18
      Top             =   2090
      Width           =   1815
   End
End
Attribute VB_Name = "frmTransportistas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Transportista
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

Private Sub Check1_Click()

   If Check1.Value = 1 Then
      DataCombo1(4).Enabled = True
   Else
      DataCombo1(4).Enabled = False
      origen.Registro.Fields("IdProveedor").Value = Null
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
   
         Dim est As EnumAcciones
         Dim oControl As Control
         Dim dc As DataCombo
   
         If Len(Trim(txtRazonSocial.Text)) = 0 Then
            MsgBox "Falta completar el campo razon social!", vbCritical
            Exit Sub
         End If
         
         With origen.Registro
            For Each dc In DataCombo1
               If dc.Visible And dc.Enabled Then
                  If Len(Trim(dc.BoundText)) = 0 Then
                     MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
                     Exit Sub
                  End If
                  .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
            For Each oControl In Me.Controls
               If TypeOf oControl Is DataCombo Then
                  If oControl.Visible And oControl.Enabled Then
                     origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
                  End If
               ElseIf TypeOf oControl Is DTPicker Then
                  .Fields(oControl.DataField).Value = oControl.Value
               End If
            Next
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
            .ListaEditada = "Transportistas"
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
            .ListaEditada = "Transportistas"
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
   Set origen = oAp.Transportistas.Item(vnewvalue)
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
   
   Else
      With origen.Registro
         If Not IsNull(.Fields("IdProveedor").Value) Then
            Check1.Value = 1
         End If
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

Private Sub DataCombo1_Change(Index As Integer)

   If Index = 0 Then
      If IsNumeric(DataCombo1(Index).BoundText) Then
         Dim oRs As ADOR.Recordset
         Set oRs = Aplicacion.Localidades.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
         If oRs.RecordCount > 0 Then
            With origen.Registro
               .Fields("IdProvincia").Value = oRs.Fields("IdProvincia").Value
               .Fields("IdPais").Value = oRs.Fields("IdPais").Value
            End With
         End If
         oRs.Close
         Set oRs = Nothing
      End If
   End If

End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)
   
   With DataCombo1(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
   SendKeys "%{DOWN}"
   
End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

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

Private Sub txtCelular_GotFocus()

   With txtCelular
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCelular_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCelular
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtCodigoPostal_GotFocus()

   With txtCodigoPostal
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoPostal_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCodigoPostal
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtContacto_GotFocus()
   
   With txtContacto
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtContacto_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtContacto
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtCuit_GotFocus()
   
   With txtCuit
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCuit_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCuit
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtDireccion_GotFocus()

   With txtDireccion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDireccion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDireccion
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

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

Private Sub txtFax_GotFocus()

   With txtFax
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtFax_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtFax
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtHorario_GotFocus()

   With txtHorario
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtHorario_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtHorario
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

