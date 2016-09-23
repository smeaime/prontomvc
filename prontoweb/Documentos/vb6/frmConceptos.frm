VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmConceptos 
   Caption         =   "Conceptos para notas de debito y credito"
   ClientHeight    =   2700
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8535
   Icon            =   "frmConceptos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2700
   ScaleWidth      =   8535
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtCodigoAFIP 
      DataField       =   "CodigoAFIP"
      Height          =   330
      Left            =   2265
      TabIndex        =   15
      Top             =   990
      Width           =   2205
   End
   Begin VB.Frame Frame2 
      Height          =   375
      Left            =   3240
      TabIndex        =   11
      Top             =   1395
      Width           =   5055
      Begin VB.OptionButton Option3 
         Caption         =   "Gravado"
         Height          =   195
         Left            =   2385
         TabIndex        =   13
         Top             =   135
         Width           =   960
      End
      Begin VB.OptionButton Option4 
         Caption         =   "No gravado"
         Height          =   195
         Left            =   3600
         TabIndex        =   12
         Top             =   135
         Width           =   1185
      End
      Begin VB.Label lblLabels 
         Caption         =   "Valor por defecto gravado :"
         Height          =   165
         Index           =   1
         Left            =   135
         TabIndex        =   14
         Top             =   135
         Width           =   2040
      End
   End
   Begin VB.Frame Frame1 
      Height          =   375
      Left            =   225
      TabIndex        =   7
      Top             =   1395
      Visible         =   0   'False
      Width           =   2850
      Begin VB.OptionButton Option2 
         Caption         =   "NO"
         Height          =   195
         Left            =   2070
         TabIndex        =   9
         Top             =   135
         Width           =   555
      End
      Begin VB.OptionButton Option1 
         Caption         =   "SI"
         Height          =   195
         Left            =   1395
         TabIndex        =   8
         Top             =   135
         Width           =   510
      End
      Begin VB.Label lblLabels 
         Caption         =   "Es un valor ? : "
         Height          =   165
         Index           =   0
         Left            =   135
         TabIndex        =   10
         Top             =   135
         Width           =   1365
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1875
      TabIndex        =   2
      Top             =   2025
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   5295
      TabIndex        =   4
      Top             =   2025
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   3585
      TabIndex        =   3
      Top             =   2025
      Width           =   1485
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   330
      Left            =   2265
      TabIndex        =   0
      Top             =   195
      Width           =   6030
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   1
      Left            =   2250
      TabIndex        =   1
      Tag             =   "Cuentas"
      Top             =   585
      Width           =   6045
      _ExtentX        =   10663
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo :"
      Height          =   240
      Index           =   0
      Left            =   270
      TabIndex        =   16
      Top             =   1035
      Width           =   1875
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de cuenta :"
      Height          =   240
      Index           =   3
      Left            =   270
      TabIndex        =   6
      Top             =   630
      Width           =   1875
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripcion :"
      Height          =   240
      Index           =   1
      Left            =   270
      TabIndex        =   5
      Top             =   225
      Width           =   1875
   End
End
Attribute VB_Name = "frmConceptos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Concepto
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
   
         Dim dc As DataCombo
         Dim est As EnumAcciones
         
         With origen.Registro
            For Each dc In DataCombo1
               If dc.Enabled Then
                  If Len(Trim(dc.BoundText)) = 0 Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  Else
                     .Fields(dc.DataField).Value = dc.BoundText
                  End If
               End If
            Next
            If Option1.Value Then
               .Fields("ValorRechazado").Value = "SI"
            Else
               .Fields("ValorRechazado").Value = "NO"
            End If
            If Option3.Value Then
               .Fields("GravadoDefault").Value = "SI"
            Else
               .Fields("GravadoDefault").Value = "NO"
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
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("ALTA", mvarId, 0, Now, 0, "Tabla : Conceptos", GetCompName(), glbNombreUsuario)
         Else
            est = Modificacion
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("MODIF", mvarId, 0, Now, 0, "Tabla : Conceptos", GetCompName(), glbNombreUsuario)
         End If
            
         With actL2
            .ListaEditada = "Conceptos"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
      Case 1
   
         origen.Eliminar
         
         est = baja
         Aplicacion.Tarea "Log_InsertarRegistro", _
               Array("ELIM", mvarId, 0, Now, 0, "Tabla : Conceptos", GetCompName(), glbNombreUsuario)
            
         With actL2
            .ListaEditada = "Conceptos"
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
   
   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oAp.Conceptos.Item(vNewValue)
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
   
   If mvarId = -1 Then
      Option2.Value = True
      Option3.Value = True
   Else
      With origen.Registro
         If IsNull(.Fields("ValorRechazado").Value) Or _
               .Fields("ValorRechazado").Value = "NO" Then
            Option2.Value = True
         Else
            Option1.Value = True
         End If
         If IsNull(.Fields("GravadoDefault").Value) Or _
               .Fields("GravadoDefault").Value = "SI" Then
            Option3.Value = True
         Else
            Option4.Value = True
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

Private Sub DataCombo1_Click(Index As Integer, Area As Integer)

   Select Case Index
      Case 1
         If IsNumeric(DataCombo1(Index).BoundText) Then
            origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
         End If
   End Select

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
