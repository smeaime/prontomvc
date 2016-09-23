VERSION 5.00
Begin VB.Form frmTraducciones 
   Caption         =   "Traducciones"
   ClientHeight    =   4485
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9315
   LinkTopic       =   "Form1"
   ScaleHeight     =   4485
   ScaleWidth      =   9315
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtDescripcion_por 
      DataField       =   "Descripcion_por"
      Height          =   600
      Left            =   2310
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   2
      Top             =   1980
      Width           =   6660
   End
   Begin VB.TextBox txtDescripcion_ing 
      DataField       =   "Descripcion_ing"
      Height          =   600
      Left            =   2310
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Top             =   1125
      Width           =   6660
   End
   Begin VB.TextBox txtDescripcion_esp 
      DataField       =   "Descripcion_esp"
      Height          =   600
      Left            =   2310
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   270
      Width           =   6660
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   2100
      TabIndex        =   3
      Top             =   3855
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   5535
      TabIndex        =   5
      Top             =   3855
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   3810
      TabIndex        =   4
      Top             =   3855
      Width           =   1485
   End
   Begin VB.TextBox txtFechaUltimaModificacion 
      Alignment       =   2  'Center
      DataField       =   "FechaUltimaModificacion"
      Enabled         =   0   'False
      Height          =   285
      Left            =   7245
      TabIndex        =   7
      Top             =   3285
      Width           =   1755
   End
   Begin VB.TextBox txtFechaAlta 
      Alignment       =   2  'Center
      DataField       =   "FechaAlta"
      Enabled         =   0   'False
      Height          =   285
      Left            =   7245
      TabIndex        =   6
      Top             =   2970
      Width           =   1755
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripción portugues :"
      Height          =   255
      Index           =   2
      Left            =   270
      TabIndex        =   12
      Top             =   1995
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripción ingles :"
      Height          =   255
      Index           =   0
      Left            =   270
      TabIndex        =   11
      Top             =   1140
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripción español :"
      Height          =   255
      Index           =   1
      Left            =   270
      TabIndex        =   10
      Top             =   285
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Fecha de alta :"
      Height          =   255
      Index           =   8
      Left            =   5985
      TabIndex        =   9
      Top             =   2970
      Width           =   1185
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Fecha ult.mod. :"
      Height          =   255
      Index           =   9
      Left            =   5985
      TabIndex        =   8
      Top             =   3330
      Width           =   1185
   End
End
Attribute VB_Name = "frmTraducciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Traduccion
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long
Private mNivelAcceso As Integer, mOpcionesAcceso As String
Private mConEmpresa As Boolean

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
      
'         For Each dc In DataCombo1
'            If dc.Visible Then
'               If Len(Trim(dc.BoundText)) = 0 Then
'                  MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
'                  Exit Sub
'               End If
'               If Len(Trim(dc.BoundText)) <> 0 Then
'                  origen.Registro.Fields(dc.DataField).Value = dc.BoundText
'               End If
'            End If
'         Next
         
         With origen.Registro
            .Fields("FechaUltimaModificacion").Value = Now
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
            
'         RegistroLog Me.Caption & " - " & glbAcciones(est)
         
         With actL2
            .ListaEditada = "Traducciones"
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
            
'         RegistroLog Me.Caption & " - " & glbAcciones(est) & _
'                     " - Registro : " & mvarId & "  " & origen.Registro.Fields(1).Value
         
         With actL2
            .ListaEditada = "Traducciones"
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
   Set origen = oAp.Traducciones.Item(vnewvalue)
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
   
   With origen.Registro
      If mvarId = -1 Then
         .Fields("FechaAlta").Value = Now
         .Fields("FechaUltimaModificacion").Value = Now
      Else
      End If
      txtFechaAlta.Text = .Fields("FechaAlta").Value
      txtFechaUltimaModificacion.Text = .Fields("FechaUltimaModificacion").Value
   End With
   
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Form_Load()

   If mvarId < 0 Or mNivelAcceso > 2 Then cmd(1).Enabled = False
   
   CambiarLenguaje Me, "esp", glbIdiomaActual
   
End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas, iColumnas As Long
   Dim i As Integer

   If Data.GetFormat(ccCFText) Then
      s = Data.GetData(ccCFText)
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      If InStr(1, Columnas(LBound(Columnas) + 1), "Traduccion") <> 0 Then
         Columnas = Split(Filas(1), vbTab)
         origen.Registro.Fields("Nombre").Value = Columnas(1)
         Clipboard.Clear
      Else
         MsgBox "Objeto invalido!"
         Exit Sub
      End If
   End If

End Sub

Private Sub Form_OLEDragOver(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long
   Dim iColumnas As Long
   Dim oL As ListItem

   If State = vbEnter Then
      If Data.GetFormat(ccCFText) Then
         s = Data.GetData(ccCFText)
         Filas = Split(s, vbCrLf)
         Columnas = Split(Filas(LBound(Filas)), vbTab)
         Effect = vbDropEffectCopy
      End If
   End If

End Sub

Private Sub Form_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   
End Sub

Private Sub txtDescripcion_esp_GotFocus()

'   With txtDescripcion_esp
'      .SelStart = 0
'      .SelLength = Len(.Text)
'   End With

End Sub

Private Sub txtDescripcion_esp_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}"
   Else
      With txtDescripcion_esp
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtDescripcion_ing_GotFocus()

'   With txtDescripcion_ing
'      .SelStart = 0
'      .SelLength = Len(.Text)
'   End With

End Sub

Private Sub txtDescripcion_ing_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}"
   Else
      With txtDescripcion_ing
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtDescripcion_por_GotFocus()

'   With txtDescripcion_por
'      .SelStart = 0
'      .SelLength = Len(.Text)
'   End With

End Sub

Private Sub txtDescripcion_por_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}"
   Else
      With txtDescripcion_por
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
