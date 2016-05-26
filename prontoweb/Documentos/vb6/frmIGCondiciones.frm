VERSION 5.00
Begin VB.Form frmIGCondiciones 
   Caption         =   "Condiciones ( Impuesto a las ganancias )"
   ClientHeight    =   2850
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5730
   Icon            =   "frmIGCondiciones.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2850
   ScaleWidth      =   5730
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "Tipo : "
      Height          =   1005
      Left            =   4095
      TabIndex        =   13
      Top             =   1080
      Width           =   1455
      Begin VB.OptionButton Option2 
         Caption         =   "Servicios"
         Height          =   195
         Left            =   90
         TabIndex        =   15
         Top             =   675
         Width           =   1050
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Bienes"
         Height          =   195
         Left            =   90
         TabIndex        =   14
         Top             =   315
         Width           =   1050
      End
   End
   Begin VB.TextBox txtProximoNumeroCertificadoRetencionGanancias 
      DataField       =   "ProximoNumeroCertificadoRetencionGanancias"
      Height          =   285
      Left            =   2880
      TabIndex        =   4
      Top             =   1800
      Visible         =   0   'False
      Width           =   1080
   End
   Begin VB.TextBox txtInformacionAuxiliar 
      DataField       =   "InformacionAuxiliar"
      Height          =   285
      Left            =   2385
      TabIndex        =   3
      Top             =   1395
      Width           =   1575
   End
   Begin VB.TextBox txtCodigoRegimenAFIP 
      DataField       =   "CodigoRegimenAFIP"
      Height          =   285
      Left            =   2385
      TabIndex        =   2
      Top             =   990
      Width           =   540
   End
   Begin VB.TextBox txtCodigoImpuestoAFIP 
      DataField       =   "CodigoImpuestoAFIP"
      Height          =   285
      Left            =   2385
      TabIndex        =   1
      Top             =   585
      Width           =   540
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   525
      TabIndex        =   5
      Top             =   2340
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   3945
      TabIndex        =   7
      Top             =   2340
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   2235
      TabIndex        =   6
      Top             =   2340
      Width           =   1485
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   285
      Left            =   2385
      TabIndex        =   0
      Top             =   195
      Width           =   3150
   End
   Begin VB.Label lblNumerador 
      Caption         =   "Proximo numero de certificado :"
      Height          =   255
      Left            =   360
      TabIndex        =   12
      Top             =   1815
      Visible         =   0   'False
      Width           =   2310
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Informacion auxiliar :"
      Height          =   255
      Index           =   3
      Left            =   360
      TabIndex        =   11
      Top             =   1410
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo Regimen :"
      Height          =   255
      Index           =   2
      Left            =   360
      TabIndex        =   10
      Top             =   1005
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo Impuesto :"
      Height          =   255
      Index           =   0
      Left            =   360
      TabIndex        =   9
      Top             =   600
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripcion :"
      Height          =   255
      Index           =   1
      Left            =   360
      TabIndex        =   8
      Top             =   210
      Width           =   1815
   End
End
Attribute VB_Name = "frmIGCondiciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.TipoRetencionGanancia
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
   
         If Len(txtDescripcion.Text) = 0 Then
            MsgBox "No ingreso la descripcion", vbExclamation
            Exit Sub
         End If
         
         Dim est As EnumAcciones
         Dim oControl As Control
   
         With origen.Registro
            For Each oControl In Me.Controls
               If TypeOf oControl Is DataCombo Then
                  If Len(oControl.BoundText) <> 0 Then
                     .Fields(oControl.DataField).Value = oControl.BoundText
                  End If
               ElseIf TypeOf oControl Is DTPicker Then
                  .Fields(oControl.DataField).Value = oControl.Value
               End If
            Next
            If Option1.Value Then
               .Fields("BienesOServicios").Value = "B"
            ElseIf Option2.Value Then
               .Fields("BienesOServicios").Value = "S"
            Else
               MsgBox "Debe indicar el tipo (Bien o Servicio)", vbExclamation
               Exit Sub
            End If
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
            .ListaEditada = "IGCondiciones1,IGCondiciones2"
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
            .ListaEditada = "IGCondiciones1,IGCondiciones2"
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
   
   If BuscarClaveINI("Numerar certificados de ganancias por categoria") = "SI" Then
      lblNumerador.Visible = True
      txtProximoNumeroCertificadoRetencionGanancias.Visible = True
   End If
   
   Set oAp = Aplicacion
   Set origen = oAp.TiposRetencionGanancia.Item(vnewvalue)
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
         If .Fields("BienesOServicios").Value = "B" Then
            Option1.Value = True
         ElseIf .Fields("BienesOServicios").Value = "S" Then
            Option2.Value = True
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

Private Sub txtCodigoImpuestoAFIP_GotFocus()

   With txtCodigoImpuestoAFIP
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoImpuestoAFIP_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCodigoRegimenAFIP_GotFocus()

   With txtCodigoRegimenAFIP
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoRegimenAFIP_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtDescripcion_GotFocus()

   With txtDescripcion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDescripcion
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

Private Sub txtProximoNumeroCertificadoRetencionGanancias_GotFocus()

   With txtProximoNumeroCertificadoRetencionGanancias
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximoNumeroCertificadoRetencionGanancias_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
