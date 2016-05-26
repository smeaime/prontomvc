VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmTarjetasCredito 
   Caption         =   "Tarjetas de credito"
   ClientHeight    =   2085
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8655
   Icon            =   "frmTarjetasCredito.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2085
   ScaleWidth      =   8655
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1800
      TabIndex        =   6
      Top             =   1575
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   5220
      TabIndex        =   5
      Top             =   1575
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   3510
      TabIndex        =   4
      Top             =   1575
      Width           =   1485
   End
   Begin VB.TextBox txtNombre 
      DataField       =   "Nombre"
      Height          =   285
      Left            =   2700
      TabIndex        =   0
      Top             =   210
      Width           =   5715
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   0
      Left            =   2700
      TabIndex        =   1
      Tag             =   "Cuentas"
      Top             =   600
      Width           =   5715
      _ExtentX        =   10081
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   1
      Left            =   2700
      TabIndex        =   7
      Tag             =   "Monedas"
      Top             =   1035
      Width           =   2595
      _ExtentX        =   4577
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Alignment       =   1  'Right Justify
      Caption         =   "Moneda : "
      Height          =   285
      Index           =   0
      Left            =   225
      TabIndex        =   8
      Top             =   1035
      Width           =   2340
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      Caption         =   "Nombre : "
      Height          =   240
      Index           =   1
      Left            =   225
      TabIndex        =   3
      Top             =   225
      Width           =   2340
   End
   Begin VB.Label lblLabels 
      Alignment       =   1  'Right Justify
      Caption         =   "Cuenta :"
      Height          =   240
      Index           =   6
      Left            =   225
      TabIndex        =   2
      Top             =   645
      Width           =   2340
   End
End
Attribute VB_Name = "frmTarjetasCredito"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.TarjetaCredito
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
         Dim dc As DataCombo
         
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe indicar la cuenta contable", vbExclamation
            Exit Sub
         End If
         
         With origen.Registro
            For Each dc In DataCombo1
               If dc.Enabled And Len(dc.DataField) > 0 Then
                  If Len(Trim(dc.BoundText)) = 0 Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
                  If Len(Trim(dc.BoundText)) <> 0 Then .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
         
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
            .ListaEditada = "TarjetasCredito"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
      Case 1
   
         origen.Eliminar
         
         est = baja
            
         With actL2
            .ListaEditada = "TarjetasCredito"
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

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oAp.TarjetasCredito.Item(vNewValue)
   
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
