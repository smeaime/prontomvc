VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form frmCondicionesCompra 
   Caption         =   "Condiciones de compra / venta"
   ClientHeight    =   5205
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8490
   Icon            =   "frmCondicionesCompra.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5205
   ScaleWidth      =   8490
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtCodigo 
      Alignment       =   2  'Center
      DataField       =   "Codigo"
      Height          =   285
      Left            =   1890
      TabIndex        =   49
      Top             =   135
      Width           =   1260
   End
   Begin VB.TextBox txtCantidadDias 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadDias7"
      Height          =   285
      Index           =   6
      Left            =   6885
      TabIndex        =   13
      Top             =   2385
      Width           =   585
   End
   Begin VB.TextBox txtCantidadDias 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadDias8"
      Height          =   285
      Index           =   7
      Left            =   6885
      TabIndex        =   15
      Top             =   2745
      Width           =   585
   End
   Begin VB.TextBox txtCantidadDias 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadDias9"
      Height          =   285
      Index           =   8
      Left            =   6885
      TabIndex        =   17
      Top             =   3105
      Width           =   585
   End
   Begin VB.TextBox txtCantidadDias 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadDias10"
      Height          =   285
      Index           =   9
      Left            =   6885
      TabIndex        =   19
      Top             =   3465
      Width           =   585
   End
   Begin VB.TextBox txtCantidadDias 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadDias11"
      Height          =   285
      Index           =   10
      Left            =   6885
      TabIndex        =   21
      Top             =   3825
      Width           =   585
   End
   Begin VB.TextBox txtCantidadDias 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadDias12"
      Height          =   285
      Index           =   11
      Left            =   6885
      TabIndex        =   23
      Top             =   4185
      Width           =   585
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      DataField       =   "Porcentaje7"
      Height          =   285
      Index           =   6
      Left            =   7560
      TabIndex        =   14
      Top             =   2385
      Width           =   840
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      DataField       =   "Porcentaje8"
      Height          =   285
      Index           =   7
      Left            =   7560
      TabIndex        =   16
      Top             =   2745
      Width           =   840
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      DataField       =   "Porcentaje9"
      Height          =   285
      Index           =   8
      Left            =   7560
      TabIndex        =   18
      Top             =   3105
      Width           =   840
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      DataField       =   "Porcentaje10"
      Height          =   285
      Index           =   9
      Left            =   7560
      TabIndex        =   20
      Top             =   3465
      Width           =   840
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      DataField       =   "Porcentaje11"
      Height          =   285
      Index           =   10
      Left            =   7560
      TabIndex        =   22
      Top             =   3825
      Width           =   840
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      DataField       =   "Porcentaje12"
      Height          =   285
      Index           =   11
      Left            =   7560
      TabIndex        =   24
      Top             =   4185
      Width           =   840
   End
   Begin VB.TextBox txtTotalPorcentaje 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   420
      Left            =   5310
      TabIndex        =   25
      Top             =   4635
      Width           =   1200
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      DataField       =   "Porcentaje6"
      Height          =   285
      Index           =   5
      Left            =   4455
      TabIndex        =   12
      Top             =   4185
      Width           =   840
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      DataField       =   "Porcentaje5"
      Height          =   285
      Index           =   4
      Left            =   4455
      TabIndex        =   10
      Top             =   3825
      Width           =   840
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      DataField       =   "Porcentaje4"
      Height          =   285
      Index           =   3
      Left            =   4455
      TabIndex        =   8
      Top             =   3465
      Width           =   840
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      DataField       =   "Porcentaje3"
      Height          =   285
      Index           =   2
      Left            =   4455
      TabIndex        =   6
      Top             =   3105
      Width           =   840
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      DataField       =   "Porcentaje2"
      Height          =   285
      Index           =   1
      Left            =   4455
      TabIndex        =   4
      Top             =   2745
      Width           =   840
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      DataField       =   "Porcentaje1"
      Height          =   285
      Index           =   0
      Left            =   4455
      TabIndex        =   2
      Top             =   2385
      Width           =   840
   End
   Begin VB.TextBox txtCantidadDias 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadDias6"
      Height          =   285
      Index           =   5
      Left            =   3780
      TabIndex        =   11
      Top             =   4185
      Width           =   585
   End
   Begin VB.TextBox txtCantidadDias 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadDias5"
      Height          =   285
      Index           =   4
      Left            =   3780
      TabIndex        =   9
      Top             =   3825
      Width           =   585
   End
   Begin VB.TextBox txtCantidadDias 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadDias4"
      Height          =   285
      Index           =   3
      Left            =   3780
      TabIndex        =   7
      Top             =   3465
      Width           =   585
   End
   Begin VB.TextBox txtCantidadDias 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadDias3"
      Height          =   285
      Index           =   2
      Left            =   3780
      TabIndex        =   5
      Top             =   3105
      Width           =   585
   End
   Begin VB.TextBox txtCantidadDias 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadDias2"
      Height          =   285
      Index           =   1
      Left            =   3780
      TabIndex        =   3
      Top             =   2745
      Width           =   585
   End
   Begin VB.TextBox txtCantidadDias 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadDias1"
      Height          =   285
      Index           =   0
      Left            =   3780
      TabIndex        =   1
      Top             =   2385
      Width           =   585
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   180
      TabIndex        =   26
      Top             =   3510
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   180
      TabIndex        =   28
      Top             =   4500
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   180
      TabIndex        =   27
      Top             =   4005
      Width           =   1485
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   285
      Left            =   1890
      TabIndex        =   0
      Top             =   555
      Width           =   6525
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1005
      Left            =   1890
      TabIndex        =   47
      Top             =   945
      Width           =   6525
      _ExtentX        =   11509
      _ExtentY        =   1773
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmCondicionesCompra.frx":076A
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo :"
      Height          =   255
      Index           =   19
      Left            =   135
      TabIndex        =   50
      Top             =   150
      Width           =   1590
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripcion amplia :"
      Height          =   255
      Index           =   18
      Left            =   135
      TabIndex        =   48
      Top             =   990
      Width           =   1590
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   2  'Center
      Caption         =   "Dias"
      Height          =   255
      Index           =   17
      Left            =   6885
      TabIndex        =   46
      Top             =   2070
      Width           =   555
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   2  'Center
      Caption         =   "Porcentaje"
      Height          =   255
      Index           =   16
      Left            =   7560
      TabIndex        =   45
      Top             =   2070
      Width           =   825
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuota numero 7 :"
      Height          =   255
      Index           =   15
      Left            =   5445
      TabIndex        =   44
      Top             =   2385
      Width           =   1365
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuota numero 8 :"
      Height          =   255
      Index           =   14
      Left            =   5445
      TabIndex        =   43
      Top             =   2745
      Width           =   1365
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuota numero 9 :"
      Height          =   255
      Index           =   13
      Left            =   5445
      TabIndex        =   42
      Top             =   3105
      Width           =   1365
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuota numero 10 :"
      Height          =   255
      Index           =   12
      Left            =   5445
      TabIndex        =   41
      Top             =   3465
      Width           =   1365
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuota numero 11 :"
      Height          =   255
      Index           =   11
      Left            =   5445
      TabIndex        =   40
      Top             =   3825
      Width           =   1365
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuota numero 12 :"
      Height          =   255
      Index           =   10
      Left            =   5445
      TabIndex        =   39
      Top             =   4185
      Width           =   1365
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   2  'Center
      Caption         =   "Total suma porcentaje (control)"
      Height          =   435
      Index           =   9
      Left            =   3465
      TabIndex        =   38
      Top             =   4635
      Width           =   1770
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   2  'Center
      Caption         =   "Porcentaje"
      Height          =   255
      Index           =   8
      Left            =   4455
      TabIndex        =   37
      Top             =   2070
      Width           =   825
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   2  'Center
      Caption         =   "Dias"
      Height          =   255
      Index           =   7
      Left            =   3780
      TabIndex        =   36
      Top             =   2070
      Width           =   555
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuota numero 6 :"
      Height          =   255
      Index           =   6
      Left            =   2340
      TabIndex        =   35
      Top             =   4185
      Width           =   1365
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuota numero 5 :"
      Height          =   255
      Index           =   5
      Left            =   2340
      TabIndex        =   34
      Top             =   3825
      Width           =   1365
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuota numero 4 :"
      Height          =   255
      Index           =   4
      Left            =   2340
      TabIndex        =   33
      Top             =   3465
      Width           =   1365
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuota numero 3 :"
      Height          =   255
      Index           =   3
      Left            =   2340
      TabIndex        =   32
      Top             =   3105
      Width           =   1365
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuota numero 2 :"
      Height          =   255
      Index           =   0
      Left            =   2340
      TabIndex        =   31
      Top             =   2745
      Width           =   1365
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuota numero 1 :"
      Height          =   255
      Index           =   2
      Left            =   2340
      TabIndex        =   30
      Top             =   2385
      Width           =   1365
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripcion :"
      Height          =   255
      Index           =   1
      Left            =   135
      TabIndex        =   29
      Top             =   570
      Width           =   1590
   End
End
Attribute VB_Name = "frmCondicionesCompra"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.CondicionCompra
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
   
         With origen.Registro
            For Each oControl In Me.Controls
               If TypeOf oControl Is DataCombo Then
                  If Len(oControl.BoundText) <> 0 Then
                     .Fields(oControl.DataField).Value = oControl.BoundText
                  End If
               ElseIf TypeOf oControl Is DTPicker Then
                  .Fields(oControl.DataField).Value = oControl.Value
               End If
               .Fields("Observaciones").Value = rchObservaciones.Text
            Next
         End With
      
         If txtTotalPorcentaje.Text <> 100 Then
            MsgBox "El total de los porcentajes debe ser igual a 100.", vbExclamation
            Exit Sub
         End If
         
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
            .ListaEditada = "CondicionesCompra1"
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
            .ListaEditada = "CondicionesCompra1"
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
   Set origen = oAp.CondicionesCompra.Item(vnewvalue)
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
      With origen.Registro
         .Fields("CantidadDias1").Value = 0
         .Fields("CantidadDias2").Value = 0
         .Fields("CantidadDias3").Value = 0
         .Fields("CantidadDias4").Value = 0
         .Fields("CantidadDias5").Value = 0
         .Fields("CantidadDias6").Value = 0
         .Fields("CantidadDias7").Value = 0
         .Fields("CantidadDias8").Value = 0
         .Fields("CantidadDias9").Value = 0
         .Fields("CantidadDias10").Value = 0
         .Fields("CantidadDias11").Value = 0
         .Fields("CantidadDias12").Value = 0
         .Fields("Porcentaje1").Value = 100
         .Fields("Porcentaje2").Value = 0
         .Fields("Porcentaje3").Value = 0
         .Fields("Porcentaje4").Value = 0
         .Fields("Porcentaje5").Value = 0
         .Fields("Porcentaje6").Value = 0
         .Fields("Porcentaje7").Value = 0
         .Fields("Porcentaje8").Value = 0
         .Fields("Porcentaje9").Value = 0
         .Fields("Porcentaje10").Value = 0
         .Fields("Porcentaje11").Value = 0
         .Fields("Porcentaje12").Value = 0
      End With
   Else
      With origen.Registro
         rchObservaciones.TextRTF = .Fields("Observaciones").Value
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
   
   CalcularPorcentaje
   
End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

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

Private Sub txtCantidadDias_GotFocus(Index As Integer)

   With txtCantidadDias(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidadDias_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCantidadDias_LostFocus(Index As Integer)

   CalcularPorcentaje
   
End Sub

Private Sub txtCantidadDias_Validate(Index As Integer, Cancel As Boolean)

   If Len(txtCantidadDias(Index).Text) > 0 Then
      If Not IsNumeric(txtCantidadDias(Index).Text) Then
         MsgBox "Debe ingresar valores numericos", vbExclamation
         Cancel = True
      ElseIf Val(txtCantidadDias(Index).Text) < 0 Then
         MsgBox "Debe ingresar numeros mayores a cero", vbExclamation
         Cancel = True
      End If
   End If
   
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

Private Sub txtPorcentaje_GotFocus(Index As Integer)

   With txtPorcentaje(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcentaje_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPorcentaje_LostFocus(Index As Integer)

   CalcularPorcentaje
   
End Sub

Private Sub txtPorcentaje_Validate(Index As Integer, Cancel As Boolean)

   If Len(txtPorcentaje(Index).Text) > 0 Then
      If Not IsNumeric(txtPorcentaje(Index).Text) Then
         MsgBox "Debe ingresar valores numericos", vbExclamation
         Cancel = True
      ElseIf Val(txtPorcentaje(Index).Text) < 0 Then
         MsgBox "Debe ingresar numeros mayores a cero", vbExclamation
         Cancel = True
      End If
   End If

End Sub

Public Sub CalcularPorcentaje()

   Dim i As Integer
   Dim mTotal As Double
   
   mTotal = 0
   For i = 0 To 11
      mTotal = mTotal + Val(txtPorcentaje(i).Text)
   Next
   txtTotalPorcentaje.Text = mTotal
   
End Sub

