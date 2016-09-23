VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmListasPrecios 
   Caption         =   "Lista de precios"
   ClientHeight    =   3120
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5940
   Icon            =   "frmListasPrecios.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3120
   ScaleWidth      =   5940
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "Activa ? : "
      Height          =   465
      Left            =   180
      TabIndex        =   11
      Top             =   1755
      Width           =   2670
      Begin VB.OptionButton Option1 
         Caption         =   "SI"
         Height          =   195
         Left            =   1035
         TabIndex        =   13
         Top             =   180
         Width           =   645
      End
      Begin VB.OptionButton Option2 
         Caption         =   "NO"
         Height          =   195
         Left            =   1980
         TabIndex        =   12
         Top             =   180
         Width           =   600
      End
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   285
      Left            =   2295
      TabIndex        =   0
      Top             =   270
      Width           =   3375
   End
   Begin VB.TextBox txtNumeroLista 
      DataField       =   "NumeroLista"
      Height          =   285
      Left            =   2295
      TabIndex        =   1
      Top             =   630
      Width           =   1440
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   2025
      TabIndex        =   5
      Top             =   2475
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   405
      Index           =   2
      Left            =   3870
      TabIndex        =   6
      Top             =   2475
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   180
      TabIndex        =   4
      Top             =   2475
      Width           =   1485
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaVigencia"
      Height          =   285
      Index           =   0
      Left            =   2295
      TabIndex        =   2
      Top             =   990
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   63832065
      CurrentDate     =   36432
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   0
      Left            =   2295
      TabIndex        =   3
      Tag             =   "Monedas"
      Top             =   1350
      Width           =   2520
      _ExtentX        =   4445
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Descripcion : "
      Height          =   255
      Index           =   3
      Left            =   180
      TabIndex        =   10
      Top             =   300
      Width           =   1995
   End
   Begin VB.Label lblData 
      Alignment       =   1  'Right Justify
      Caption         =   "Moneda : "
      Height          =   255
      Index           =   0
      Left            =   180
      TabIndex        =   9
      Top             =   1395
      Width           =   1995
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Numero de lista de precio : "
      Height          =   255
      Index           =   4
      Left            =   180
      TabIndex        =   8
      Top             =   675
      Width           =   1995
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   1  'Right Justify
      Caption         =   "Fecha de vigencia : "
      Height          =   255
      Index           =   21
      Left            =   180
      TabIndex        =   7
      Top             =   1035
      Width           =   1995
   End
End
Attribute VB_Name = "frmListasPrecios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.ListaPrecios
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
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim mCodigo As String
   
         If Len(Trim(txtDescripcion.Text)) = 0 Then
            MsgBox "Falta completar el campo descripcion!", vbCritical
            Exit Sub
         End If
         
         If Len(Trim(txtNumeroLista.Text)) = 0 Then
            MsgBox "Falta completar el campo numero de lista!", vbCritical
            Exit Sub
         End If
         
         For Each dtp In DTPicker1
            origen.Registro.Fields(dtp.DataField).Value = dtp.Value
         Next
         
         For Each dc In DataCombo1
            If Not IsNumeric(dc.BoundText) And dc.Index <> 4 And dc.Index <> 5 Then
               MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
               Exit Sub
            End If
            If IsNumeric(dc.BoundText) Then
               origen.Registro.Fields(dc.DataField).Value = dc.BoundText
            End If
         Next
         
         With origen.Registro
            If Option1.Value Then
               .Fields("Activa").Value = "SI"
            Else
               .Fields("Activa").Value = "NO"
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
            .ListaEditada = "ListasPrecios"
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
            .ListaEditada = "ListasPrecios"
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
   Set origen = oAp.ListasPrecios.Item(vnewvalue)
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
   
   If mvarId < 0 Then
      DTPicker1(0).Value = Date
      Option1.Value = True
   Else
      With origen.Registro
         If IsNull(.Fields("Activa").Value) Then
            If .Fields("Activa").Value = "SI" Then
               Option1.Value = True
            Else
               Option2.Value = True
            End If
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

Private Sub DataCombo1_GotFocus(Index As Integer)
   
'   With DataCombo1(Index)
'      .SelStart = 0
'      .SelLength = Len(.Text)
'   End With
   
   SendKeys "%{DOWN}"
   
End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DTPicker1_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTPicker1(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

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

Private Sub txtNumeroLista_GotFocus()

   With txtNumeroLista
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroLista_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
