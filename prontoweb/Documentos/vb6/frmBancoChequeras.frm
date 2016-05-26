VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmBancoChequeras 
   Caption         =   "Chequeras"
   ClientHeight    =   2925
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8100
   Icon            =   "frmBancoChequeras.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2925
   ScaleWidth      =   8100
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Chequera de pago diferido :"
      Height          =   240
      Left            =   1485
      TabIndex        =   18
      Top             =   1575
      Width           =   2265
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Activa :"
      Height          =   240
      Left            =   315
      TabIndex        =   17
      Top             =   1575
      Width           =   960
   End
   Begin VB.TextBox txtProximoNumeroCheque 
      Alignment       =   1  'Right Justify
      DataField       =   "ProximoNumeroCheque"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   360
      Left            =   6300
      TabIndex        =   5
      Top             =   2430
      Width           =   1455
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   450
      Index           =   2
      Left            =   2835
      TabIndex        =   8
      Top             =   2340
      Width           =   945
   End
   Begin VB.TextBox txtHastaCheque 
      Alignment       =   1  'Right Justify
      DataField       =   "HastaCheque"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   360
      Left            =   6300
      TabIndex        =   4
      Top             =   1980
      Width           =   1455
   End
   Begin VB.TextBox txtDesdeCheque 
      Alignment       =   1  'Right Justify
      DataField       =   "DesdeCheque"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   360
      Left            =   6300
      TabIndex        =   3
      Top             =   1530
      Width           =   1455
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   450
      Index           =   0
      Left            =   360
      TabIndex        =   6
      Top             =   2340
      Width           =   945
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   450
      Index           =   1
      Left            =   1575
      TabIndex        =   7
      Top             =   2340
      Width           =   945
   End
   Begin VB.TextBox txtNumeroChequera 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroChequera"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   360
      Left            =   2295
      TabIndex        =   1
      Top             =   1095
      Width           =   1455
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdBanco"
      Height          =   315
      Index           =   1
      Left            =   2295
      TabIndex        =   0
      Tag             =   "Bancos"
      Top             =   210
      Width           =   5460
      _ExtentX        =   9631
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdBanco"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   330
      Index           =   0
      Left            =   6300
      TabIndex        =   2
      Top             =   1080
      Width           =   1425
      _ExtentX        =   2514
      _ExtentY        =   582
      _Version        =   393216
      Format          =   64356353
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaBancaria"
      Height          =   315
      Index           =   0
      Left            =   2295
      TabIndex        =   16
      Top             =   675
      Width           =   5460
      _ExtentX        =   9631
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaBancaria"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Proximo cheque : "
      Height          =   300
      Index           =   5
      Left            =   4320
      TabIndex        =   15
      Top             =   2460
      Width           =   1905
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta banco :"
      Height          =   300
      Index           =   4
      Left            =   315
      TabIndex        =   14
      Top             =   660
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Hasta cheque (excluido ) :"
      Height          =   300
      Index           =   3
      Left            =   4320
      TabIndex        =   13
      Top             =   2010
      Width           =   1905
   End
   Begin VB.Label lblLabels 
      Caption         =   "Desde cheque numero :"
      Height          =   300
      Index           =   2
      Left            =   4320
      TabIndex        =   12
      Top             =   1560
      Width           =   1905
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de chequera :"
      Height          =   300
      Index           =   0
      Left            =   315
      TabIndex        =   11
      Top             =   1125
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Banco :"
      Height          =   300
      Index           =   1
      Left            =   315
      TabIndex        =   10
      Top             =   225
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha :"
      Height          =   300
      Index           =   22
      Left            =   4320
      TabIndex        =   9
      Top             =   1125
      Width           =   1905
   End
End
Attribute VB_Name = "frmBancoChequeras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.BancoChequera
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
   
         If Not IsNumeric(DataCombo1(1).BoundText) Then
            MsgBox "Debe indicar el banco", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe indicar la cuenta bancaria", vbExclamation
            Exit Sub
         End If
         
         If Len(txtDesdeCheque.Text) = 0 Then
            MsgBox "No ingreso el numero inicial de cheque", vbExclamation
            Exit Sub
         End If
         
         If Len(txtHastaCheque.Text) = 0 Then
            MsgBox "No ingreso el numero final de cheque", vbExclamation
            Exit Sub
         End If
         
         If Len(txtProximoNumeroCheque.Text) = 0 Then
            MsgBox "No ingreso el proximo numero de cheque", vbExclamation
            Exit Sub
         End If
         
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
            If Check1.Value = 1 Then
               .Fields("Activa").Value = "SI"
            Else
               .Fields("Activa").Value = "NO"
            End If
            If Check2.Value = 1 Then
               .Fields("ChequeraPagoDiferido").Value = "SI"
            Else
               .Fields("ChequeraPagoDiferido").Value = "NO"
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
            .ListaEditada = "BancoChequeras"
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
            .ListaEditada = "BancoChequeras"
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
   Set origen = oAp.BancoChequeras.Item(vnewvalue)
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
                  Set oControl.RowSource = oAp.Bancos.TraerFiltrado("_ConCuenta")
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   End With
   
   If mvarId = -1 Then
      DTFields(0).Value = Date
      Check1.Value = 1
   Else
      With origen.Registro
         If IsNull(.Fields("Activa").Value) Or .Fields("Activa").Value = "SI" Then
            Check1.Value = 1
         End If
         If Not IsNull(.Fields("ChequeraPagoDiferido").Value) And _
               .Fields("ChequeraPagoDiferido").Value = "SI" Then
            Check2.Value = 1
         End If
      End With
      Check2.Enabled = False
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

   If IsNumeric(DataCombo1(Index).BoundText) Then
      origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
      If Index = 1 Then
         Dim oRs As ADOR.Recordset
         Set oRs = Aplicacion.CuentasBancarias.TraerFiltrado("_PorIdBanco", DataCombo1(Index).BoundText)
         Set DataCombo1(0).RowSource = oRs
         If oRs.RecordCount > 0 Then
            If Not IsNull(origen.Registro.Fields("IdCuentaBancaria").Value) Then
               DataCombo1(0).BoundText = origen.Registro.Fields("IdCuentaBancaria").Value
            End If
         End If
         Set oRs = Nothing
      End If
   End If

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

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

Private Sub txtDesdeCheque_GotFocus()

   With txtDesdeCheque
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDesdeCheque_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtHastaCheque_GotFocus()

   With txtHastaCheque
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtHastaCheque_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroChequera_GotFocus()

   With txtNumeroChequera
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroChequera_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtProximoNumeroCheque_GotFocus()

   With txtProximoNumeroCheque
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximoNumeroCheque_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
