VERSION 5.00
Object = "{F09A78C8-7814-11D2-8355-4854E82A9183}#1.1#0"; "CUIT32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmBancos 
   Caption         =   "Bancos"
   ClientHeight    =   3180
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8460
   Icon            =   "frmBancos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3180
   ScaleWidth      =   8460
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtCodigoUniversal 
      Alignment       =   1  'Right Justify
      DataField       =   "CodigoUniversal"
      Height          =   285
      Left            =   2625
      TabIndex        =   0
      Top             =   120
      Width           =   1080
   End
   Begin VB.TextBox txtCodigo 
      Alignment       =   1  'Right Justify
      DataField       =   "Codigo"
      Height          =   285
      Left            =   2625
      TabIndex        =   6
      Top             =   2115
      Width           =   720
   End
   Begin VB.TextBox txtNombre 
      DataField       =   "Nombre"
      Height          =   285
      Left            =   2625
      TabIndex        =   1
      Top             =   510
      Width           =   5715
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   3495
      TabIndex        =   8
      Top             =   2610
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   5205
      TabIndex        =   9
      Top             =   2610
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1785
      TabIndex        =   7
      Top             =   2610
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   0
      Left            =   2625
      TabIndex        =   2
      Tag             =   "Cuentas"
      Top             =   900
      Width           =   5715
      _ExtentX        =   10081
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin Control_CUIT.CUIT CUIT1 
      Height          =   285
      Left            =   2610
      TabIndex        =   4
      Top             =   1710
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
      Left            =   5445
      TabIndex        =   5
      Tag             =   "DescripcionIva"
      Top             =   1710
      Width           =   2880
      _ExtentX        =   5080
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCodigoIva"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaParaChequesDiferidos"
      Height          =   315
      Index           =   2
      Left            =   2625
      TabIndex        =   3
      Tag             =   "Cuentas"
      Top             =   1305
      Visible         =   0   'False
      Width           =   5715
      _ExtentX        =   10081
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Alignment       =   1  'Right Justify
      Caption         =   "Cuenta para cheques diferidos :"
      Height          =   240
      Index           =   0
      Left            =   135
      TabIndex        =   16
      Top             =   1350
      Visible         =   0   'False
      Width           =   2340
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Codigo unico : "
      Height          =   240
      Index           =   2
      Left            =   150
      TabIndex        =   15
      Top             =   135
      Width           =   2340
   End
   Begin VB.Label lblData 
      Alignment       =   1  'Right Justify
      Caption         =   "Condicion IVA :"
      Height          =   255
      Index           =   3
      Left            =   4275
      TabIndex        =   14
      Top             =   1755
      Width           =   1095
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Codigo (p/gestion de cobro) :"
      Height          =   240
      Index           =   0
      Left            =   150
      TabIndex        =   13
      Top             =   2085
      Width           =   2340
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Cuit : "
      Height          =   240
      Index           =   12
      Left            =   150
      TabIndex        =   12
      Top             =   1710
      Width           =   2340
   End
   Begin VB.Label lblLabels 
      Alignment       =   1  'Right Justify
      Caption         =   "Cuenta :"
      Height          =   240
      Index           =   6
      Left            =   150
      TabIndex        =   11
      Top             =   945
      Width           =   2340
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      Caption         =   "Nombre : "
      Height          =   240
      Index           =   1
      Left            =   150
      TabIndex        =   10
      Top             =   525
      Width           =   2340
   End
End
Attribute VB_Name = "frmBancos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Banco
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long
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
   
         Dim est As EnumAcciones
         
         With origen.Registro
            .Fields("Cuit").Value = CUIT1.Text
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
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("ALTA", mvarId, 0, Now, 0, "Tabla : Bancos", GetCompName(), glbNombreUsuario)
         Else
            est = Modificacion
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("MODIF", mvarId, 0, Now, 0, "Tabla : Bancos", GetCompName(), glbNombreUsuario)
         End If
            
         With actL2
            .ListaEditada = "Bancos"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
      Case 1
   
         origen.Eliminar
         
         est = baja
         Aplicacion.Tarea "Log_InsertarRegistro", _
               Array("ELIM", mvarId, 0, Now, 0, "Tabla : Bancos", GetCompName(), glbNombreUsuario)
            
         With actL2
            .ListaEditada = "Bancos"
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
   
   Set oAp = Aplicacion
   Set origen = oAp.Bancos.Item(vnewvalue)
   
   Set oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
   If Not IsNull(oRs.Fields("ActivarCircuitoChequesDiferidos").Value) And _
         oRs.Fields("ActivarCircuitoChequesDiferidos").Value = "SI" Then
      lblLabels(0).Visible = True
      DataCombo1(2).Visible = True
   End If
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
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
      
   End With
   
   If mvarId <= 0 Then
   
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
      Dim oRs As ADOR.Recordset
      Select Case Index
         Case 0
            Set oRs = Aplicacion.Cuentas.Item(DataCombo1(Index).BoundText).Registro
            With origen.Registro
               .Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
               .Fields("CodigoCuenta").Value = oRs.Fields("Codigo").Value
            End With
            oRs.Close
         Case 1
            With origen.Registro
               .Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
            End With
         Case 2
            Set oRs = Aplicacion.Cuentas.Item(DataCombo1(Index).BoundText).Registro
            With origen.Registro
               .Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
            End With
            oRs.Close
      End Select
      Set oRs = Nothing
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

Private Sub txtCodigo_GotFocus()

   With txtCodigo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCodigo
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtCodigoUniversal_GotFocus()

   With txtCodigoUniversal
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoUniversal_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNombre_GotFocus()

   With txtNombre
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtNombre
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
