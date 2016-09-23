VERSION 5.00
Begin VB.Form frmMonedas 
   Caption         =   "Monedas"
   ClientHeight    =   2805
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5535
   Icon            =   "frmMonedas.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2805
   ScaleWidth      =   5535
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Height          =   465
      Left            =   180
      TabIndex        =   11
      Top             =   1530
      Width           =   5190
      Begin VB.OptionButton Option1 
         Caption         =   "SI"
         Height          =   195
         Left            =   3510
         TabIndex        =   13
         Top             =   180
         Width           =   825
      End
      Begin VB.OptionButton Option2 
         Caption         =   "NO"
         Height          =   195
         Left            =   4410
         TabIndex        =   12
         Top             =   180
         Width           =   690
      End
      Begin VB.Label lblFieldLabel 
         Caption         =   "La moneda genera retenciones impositivas ? :"
         Height          =   210
         Index           =   4
         Left            =   90
         TabIndex        =   14
         Top             =   180
         Width           =   3255
      End
   End
   Begin VB.TextBox txtCodigoAFIP 
      DataField       =   "CodigoAFIP"
      Height          =   285
      Left            =   2220
      TabIndex        =   3
      Top             =   1080
      Width           =   675
   End
   Begin VB.TextBox txtAbreviatura 
      DataField       =   "Abreviatura"
      Height          =   285
      Left            =   2220
      TabIndex        =   1
      Top             =   660
      Width           =   1215
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Nombre"
      Height          =   285
      Left            =   2220
      TabIndex        =   0
      Top             =   225
      Width           =   3150
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   2100
      TabIndex        =   5
      Top             =   2235
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   3810
      MaskColor       =   &H8000000F&
      TabIndex        =   6
      Top             =   2235
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   390
      TabIndex        =   4
      Top             =   2235
      Width           =   1485
   End
   Begin VB.TextBox txtEquivalenciaUS 
      Alignment       =   1  'Right Justify
      DataField       =   "EquivalenciaUS"
      Height          =   285
      Left            =   3930
      TabIndex        =   2
      Top             =   2475
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo AFIP : "
      Height          =   255
      Index           =   3
      Left            =   180
      TabIndex        =   10
      Top             =   1095
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Abreviatura :"
      Height          =   255
      Index           =   2
      Left            =   180
      TabIndex        =   8
      Top             =   675
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Nombre : "
      Height          =   255
      Index           =   1
      Left            =   180
      TabIndex        =   7
      Top             =   240
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Equivalencia de U$S :"
      Height          =   255
      Index           =   0
      Left            =   1890
      TabIndex        =   9
      Top             =   2490
      Visible         =   0   'False
      Width           =   1815
   End
End
Attribute VB_Name = "frmMonedas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Moneda
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
   
         If Len(txtAbreviatura.Text) = 0 Then
            MsgBox "Debe ingresar la abreviatura de la moneda", vbInformation
            Exit Sub
         End If
         
         Set oRs = Aplicacion.Monedas.TraerFiltrado("_VerificarAbreviatura", Array(txtAbreviatura.Text, mvarId))
         If oRs.RecordCount > 0 Then
            MsgBox "Ya existe esta abreviatura en otra moneda : [ " & _
                     oRs.Fields("Nombre").Value & " ]", vbInformation
            oRs.Close
            Set oRs = Nothing
            Exit Sub
         End If
         oRs.Close
         Set oRs = Nothing
         
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
               .Fields("GeneraImpuestos").Value = "SI"
            Else
               .Fields("GeneraImpuestos").Value = "NO"
            End If
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
            .ListaEditada = "Monedas"
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
            .ListaEditada = "Monedas"
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
   Set origen = oAp.Monedas.Item(vnewvalue)
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
      Option2.Value = True
   Else
      With origen.Registro
         If IsNull(.Fields("GeneraImpuestos").Value) Or _
               .Fields("GeneraImpuestos").Value = "NO" Then
            Option2.Value = True
         Else
            Option1.Value = True
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

Private Sub txtAbreviatura_GotFocus()

   With txtAbreviatura
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAbreviatura_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtAbreviatura
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtCodigoAFIP_GotFocus()

   With txtCodigoAFIP
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoAFIP_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCodigoAFIP
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

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

Private Sub txtEquivalenciaUS_GotFocus()

   With txtEquivalenciaUS
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtEquivalenciaUS_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
