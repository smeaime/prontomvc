VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmProntoIni 
   Caption         =   "Configuracion de usuarios (Pronto Ini)"
   ClientHeight    =   5820
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10785
   LinkTopic       =   "Form1"
   ScaleHeight     =   5820
   ScaleWidth      =   10785
   StartUpPosition =   3  'Windows Default
   Begin MSComctlLib.TreeView Arbol 
      Height          =   3975
      Left            =   180
      TabIndex        =   4
      Top             =   720
      Width           =   3210
      _ExtentX        =   5662
      _ExtentY        =   7011
      _Version        =   393217
      Style           =   7
      ImageList       =   "img16"
      Appearance      =   1
      OLEDropMode     =   1
   End
   Begin VB.PictureBox Split 
      Height          =   3750
      Left            =   3465
      MousePointer    =   9  'Size W E
      ScaleHeight     =   187.5
      ScaleMode       =   2  'Point
      ScaleWidth      =   2.25
      TabIndex        =   0
      Top             =   765
      Width           =   50
   End
   Begin MSComctlLib.ImageList img16 
      Left            =   90
      Top             =   4815
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   9
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":0000
            Key             =   "Abierto1"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":0452
            Key             =   "Cerrado1"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":08A4
            Key             =   "Cerrado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":0CF6
            Key             =   "Abierto"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":1148
            Key             =   "Obras"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":16E2
            Key             =   "Etapas"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":1C7C
            Key             =   "Rubros"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":2216
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":27B0
            Key             =   "Opciones"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   4920
      Left            =   3645
      TabIndex        =   1
      Top             =   765
      Width           =   6720
      _ExtentX        =   11853
      _ExtentY        =   8678
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmProntoIni.frx":2D4A
      OLEDragMode     =   1
      PictureAlignment=   5
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   720
      Top             =   4815
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   11
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":2D66
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":2E78
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":2F8A
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":309C
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":31AE
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":32C0
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":33D2
            Key             =   "Excel"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":3824
            Key             =   "Project"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":3DBE
            Key             =   "Importar"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":4358
            Key             =   "Informe"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProntoIni.frx":48F2
            Key             =   "Guardar"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   10785
      _ExtentX        =   19024
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   1
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Guardar"
            Object.ToolTipText     =   "Imprimir"
            ImageKey        =   "Guardar"
         EndProperty
      EndProperty
      Begin VB.TextBox txtTexto 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0FF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   90
         TabIndex        =   3
         Top             =   45
         Width           =   8520
      End
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar valor"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   1
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Expandir todo"
         Index           =   2
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Contraer todo"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Copiar"
         Index           =   4
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Pegar"
         Index           =   5
      End
   End
   Begin VB.Menu MnuDetCla 
      Caption         =   "DetalleClaves"
      Visible         =   0   'False
      Begin VB.Menu MnuDetB 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Eliminar"
         Index           =   2
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Pegar"
         Index           =   3
      End
   End
End
Attribute VB_Name = "frmProntoIni"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Sub Editar(ByVal Cual As Long)

   Dim oL As ListItem
   Dim oF As frm_Aux
   Dim oRs As ADOR.Recordset
   Dim mIdItem As Long
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Claves"
      With .Label2(0)
         .Caption = "Clave :"
         .Visible = True
      End With
      With .Text1
         .Top = oF.DTFields(0).Top
         If Not Lista.SelectedItem Is Nothing Then .Text = "" & IIf(Cual > 0, Lista.SelectedItem.Text, "")
         .Width = .Width * 7
      End With
      With .Label1
         .Caption = "Descripcion :"
         .Visible = True
      End With
      With .RichTextBox1
         .Top = oF.Label1.Top
         .Left = oF.Text1.Left
         .Width = oF.Text1.Width
         .Height = oF.Text1.Height * 3
         .Text = ""
         .Visible = True
      End With
      With .Label2(1)
         .Caption = "Valor p/def.:"
         .Top = oF.RichTextBox1.Top + oF.RichTextBox1.Height + 100
         .Visible = True
      End With
      With .RichTextBox2
         .Top = oF.Label2(1).Top
         .Left = oF.Text1.Left
         .Width = oF.Text1.Width
         .Height = oF.Text1.Height * 3
         .Text = ""
         .Visible = True
      End With
      .cmd(0).Top = .RichTextBox2.Top + .RichTextBox2.Height + 200
      .cmd(1).Top = .cmd(0).Top
      If Cual > 0 Then
         Set oRs = Aplicacion.TablasGenerales.TraerUno("ProntoIniClaves", Cual)
         If oRs.RecordCount > 0 Then
            .RichTextBox1.Text = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
            .RichTextBox2.Text = IIf(IsNull(oRs.Fields("ValorPorDefecto").Value), "", oRs.Fields("ValorPorDefecto").Value)
         End If
         oRs.Close
      End If
      .Width = .Width * 3
      .Height = .Height * 1.5
      .Show vbModal, Me
      If .Ok Then
         Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("ProntoIniClaves", "_PorClave", Array(.Text1.Text, Cual))
         If oRs.RecordCount > 0 Then
            MsgBox "Clave ya existente", vbExclamation
            GoTo Salida
         End If
         Aplicacion.Tarea "ProntoIniClaves_Actualizar", Array(Cual, .Text1.Text, .RichTextBox1.Text, .RichTextBox2.Text)
         If Cual <= 0 Then
            Set oL = Lista.ListItems.Add
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("ProntoIniClaves", "_PorClave", Array(.Text1.Text, Cual))
            oL.Tag = oRs.Fields(0).Value
            oRs.Close
         Else
            Set oL = Lista.SelectedItem
         End If
         oL.Text = .Text1.Text
         oL.SubItems(1) = .RichTextBox2.Text
         oL.SubItems(2) = .RichTextBox1.Text
      End If
   End With
Salida:
   Unload oF
   Set oF = Nothing
   Set oRs = Nothing

End Sub

Sub EditarValor(ByVal IdEmpleado As Long, ByVal IdProntoIniClave As Long)

   Dim oL As ListItem
   Dim oF As frm_Aux
   Dim oRs As ADOR.Recordset
   Dim mIdItem As Long
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Asignar valor"
      With .Label2(0)
         .Caption = "Clave :"
         .Visible = True
      End With
      With .Text1
         .Top = oF.DTFields(0).Top
         .Width = .Width * 7
         .Locked = True
         Set oRs = Aplicacion.TablasGenerales.TraerUno("ProntoIniClaves", IdProntoIniClave)
         If oRs.RecordCount > 0 Then
            .Text = IIf(IsNull(oRs.Fields("Clave").Value), "", oRs.Fields("Clave").Value)
         End If
         oRs.Close
      End With
      With .Label1
         .Caption = "Descripcion :"
         .Visible = True
      End With
      With .RichTextBox1
         .Top = oF.Label1.Top
         .Left = oF.Text1.Left
         .Width = oF.Text1.Width
         .Height = oF.Text1.Height * 3
         .Text = ""
         Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("ProntoIni", "_T", Array(IdEmpleado, IdProntoIniClave))
         If oRs.RecordCount > 0 Then
            .Text = IIf(IsNull(oRs.Fields("Valor").Value), "", oRs.Fields("Valor").Value)
         End If
         oRs.Close
         .Visible = True
      End With
      .Width = .Width * 3
      .Show vbModal, Me
      If .Ok Then
         Aplicacion.Tarea "ProntoIni_Actualizar", Array(0, IdEmpleado, IdProntoIniClave, .RichTextBox1.Text)
         Arbol.SelectedItem.Text = "" & .Text1.Text & "=" & .RichTextBox1.Text
      End If
   End With
Salida:
   Unload oF
   Set oF = Nothing
   Set oRs = Nothing

End Sub

Private Sub Arbol_DblClick()

   If InStr(1, Arbol.SelectedItem.Key, "|") <> 0 Then
      Dim mVector
      mVector = VBA.Split(Arbol.SelectedItem.Key, "|")
      EditarValor mVector(0), mVector(1)
   End If

End Sub

Private Sub Arbol_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Arbol.SelectedItem Is Nothing Then Exit Sub
      If InStr(1, Arbol.SelectedItem.Key, "|") <> 0 Then
         MnuDetA(0).Visible = True
         MnuDetA(1).Visible = True
         PopupMenu MnuDet, , , , MnuDetA(0)
      Else
         MnuDetA(0).Visible = False
         MnuDetA(1).Visible = False
         PopupMenu MnuDet, , , , MnuDetA(2)
      End If
   End If

End Sub

Private Sub Arbol_OLEDragDrop(Data As MSComctlLib.DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim mNode As Node
   Dim s As String
   Dim i As Integer
   Dim mIdEmpleado As Long
   Dim Filas, Columnas

   Set mNode = Arbol.DropHighlight
   Set Arbol.DropHighlight = Nothing
   
   If Not mNode Is Nothing Then
      If Data.GetFormat(ccCFText) Then
         s = Data.GetData(ccCFText)
         Filas = VBA.Split(s, vbCrLf)
         For i = 1 To UBound(Filas)
            Columnas = VBA.Split(Filas(i), vbTab)
            If mId(mNode.Key, 1, 1) = "K" Then
               On Error Resume Next
               mIdEmpleado = Val(mId(mNode.Key, 2, Len(mNode.Key) - 1))
               Arbol.Nodes.Add mNode.Key, tvwChild, mIdEmpleado & "|" & Columnas(0), _
                              Columnas(1) & "=" & Columnas(2), "Etapas", "Etapas"
               Aplicacion.Tarea "ProntoIni_Actualizar", Array(0, mIdEmpleado, Columnas(0), Columnas(2))
            End If
         Next
      End If
   End If

'   Set Arbol.SelectedItem = Arbol.HitTest(x, y)
'   Set Arbol.DropHighlight = Arbol.HitTest(x, y)

End Sub

Private Sub Arbol_OLEDragOver(Data As MSComctlLib.DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

'   If State = vbLeave Then
'      Set Arbol.DropHighlight = Nothing
'   Else
'      Set Arbol.DropHighlight = Arbol.HitTest(x, y)
'   End If

'   Dim mArbol As TreeView
'
'   Arbol.SetFocus
'   Set Arbol.SelectedItem = Arbol.HitTest(x, y)
'   Set Arbol.DropHighlight = Arbol.HitTest(x, y)
'
   Dim mNode As Node
   Set mNode = Arbol.HitTest(X * 40, Y * 40)
   Set Arbol.DropHighlight = mNode
   If mNode Is Nothing Then
      Effect = vbDropEffectNone
      txtTexto.Text = "S/D"
   Else
      Effect = vbDropEffectCopy
      txtTexto.Text = mNode.Key & " - " & mNode.Text
   End If
   txtTexto.Text = txtTexto.Text & " [ X = " & X & " , Y = " & Y & " ]"

End Sub

Private Sub Arbol_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub Form_Load()

   CargarArbol
   Set Lista.DataSource = Aplicacion.TablasGenerales.TraerFiltrado("ProntoIniClaves", "_Todo")

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   'Degradado Me

End Sub

Private Sub Form_Resize()

   Ajustar

End Sub

Private Sub Ajustar()

   Dim Arriba As Long, Altura As Long, Ancho As Long
   
   Arriba = Toolbar1.Height
   Ancho = Me.ScaleWidth
   Altura = Me.ScaleHeight - Arriba
   
   On Error Resume Next
   
   With Split
      .Top = Arriba
      .Height = Altura
   End With
   
   With Arbol
      .Left = 0
      .Top = Arriba
      .Height = Altura
      If Split.Left >= 0 Then .Width = Split.Left
   End With
   
   With Lista
      .Top = Arriba
      .Height = Altura
      .Left = Arbol.Left + Arbol.Width + Split.Width
      .Width = Ancho - .Left
   End With

End Sub

Private Sub CargarArbol()

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim mIdEmpleado As Long
   Dim oNode As Node
   
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("ProntoIni", "_Todo")

   Arbol.Nodes.Clear
   If Lista.ColumnHeaders.Count > 0 Then
      Lista.ListItems.Clear
      Lista.ColumnHeaders.Clear
   End If
   
   With Arbol.Nodes
      .Add , , "Ppal", "USUARIOS", "Opciones", "Opciones"
      mIdEmpleado = 0
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If mIdEmpleado <> oRs.Fields("IdEmpleado").Value Then
               mIdEmpleado = oRs.Fields("IdEmpleado").Value
               .Add "Ppal", tvwChild, "K" & mIdEmpleado, "" & oRs.Fields("Usuario").Value, "Etapas", "Etapas"
            End If
            If oRs.Fields("IdProntoIniClave").Value <> 0 Then
               .Add "K" & mIdEmpleado, tvwChild, "" & mIdEmpleado & "|" & oRs.Fields("IdProntoIniClave").Value, _
                        oRs.Fields("Clave").Value & " = " & oRs.Fields("Valor").Value, "Etapas", "Etapas"
            End If
            oRs.MoveNext
         Loop
      End If
      .Item("Ppal").Expanded = True
   End With
   
   oRs.Close
   Set oRs = Nothing

End Sub

Private Sub Lista_DblClick()

   If Lista.ListItems.Count = 0 Then
      Editar -1
   Else
      Editar Lista.SelectedItem.Tag
   End If

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetB_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetB_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetB_Click 1
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count = 0 Then
         MnuDetB(1).Enabled = False
         MnuDetB(2).Enabled = False
         PopupMenu MnuDetCla, , , , MnuDetB(0)
      Else
         MnuDetB(1).Enabled = True
         MnuDetB(2).Enabled = True
         PopupMenu MnuDetCla, , , , MnuDetB(1)
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Dim mVector
   mVector = VBA.Split(Arbol.SelectedItem.Key, "|")
   
   Select Case Index
      Case 0
         EditarValor mVector(0), mVector(1)
      Case 1
         Aplicacion.Tarea "ProntoIni_Eliminar", Array(mVector(0), mVector(1))
         Arbol.Nodes.Remove (Arbol.SelectedItem.Key)
      Case 2
         Expandir True
      Case 3
         Expandir False
      Case 4
         CopiarNodo
      Case 5
         PegarNodo
   End Select

End Sub

Private Sub MnuDetB_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         Editar Lista.SelectedItem.Tag
      Case 2
         If Not Lista.SelectedItem Is Nothing Then EliminarIni
      Case 3
         PegarIni
   End Select

End Sub

Private Sub Split_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbLeftButton Then
      With Split
         .Move .Left + X
      End With
   End If

End Sub

Private Sub Split_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbLeftButton Then Ajustar

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Key
      Case "Guardar"
         GuardarProntoIni
   
   End Select

End Sub

Public Sub GuardarProntoIni()

   Dim oNode As Node
   Dim mVector
   
   For Each oNode In Arbol.Nodes
      If InStr(1, oNode.Key, "|") <> 0 Then
         mVector = VBA.Split(oNode.Key, "|")
         Aplicacion.Tarea "ProntoIni_Actualizar", Array(0, mVector(0), mVector(1), "")
      End If
   Next

End Sub

Public Sub PegarIni()

   Dim oRs As ADOR.Recordset
   Dim oL As ListItem
   Dim s As String, mError As String
   Dim Filas, Columnas
   
   s = Clipboard.GetText(vbCFText)
   
   If Len(s) = 0 Then
      MsgBox "No hay informacion para copiar", vbCritical
      Exit Sub
   End If

   Me.MousePointer = vbHourglass
   DoEvents
   
   mError = ""
   
   Filas = VBA.Split(s, vbCrLf)
   For i = 0 To UBound(Filas)
      If InStr(1, Filas(i), "=") <> 0 Then
         Columnas = VBA.Split(Filas(i), "=")
         Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("ProntoIniClaves", "_PorClave", Columnas(0))
         If oRs.RecordCount > 0 Then
            mError = mError & vbCrLf & "Clave existente : " & Columnas(0)
         Else
            Aplicacion.Tarea "ProntoIniClaves_Actualizar", Array(-1, Columnas(0), "", Columnas(1))
            Set oL = Lista.ListItems.Add
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("ProntoIniClaves", "_PorClave", Columnas(0))
            oL.Tag = oRs.Fields(0).Value
            oRs.Close
            oL.Text = Columnas(0)
         End If
      End If
   Next
   
   Set oRs = Nothing
   
   Set Lista.DataSource = Aplicacion.TablasGenerales.TraerFiltrado("ProntoIniClaves", "_Todo")
   
   Me.MousePointer = vbDefault
   
   If Len(mError) > 0 Then
      MsgBox "El proceso reporta los siguientes errores :" & mError, vbExclamation
   End If

End Sub

Public Sub EliminarIni()

   Dim oNode As Node
   Dim s As String, t As String
   Dim Filas, Columnas, mVector
   
   s = Lista.GetString
   
   If Len(s) = 0 Then
      MsgBox "No hay informacion para eliminar", vbCritical
      Exit Sub
   End If

   Me.MousePointer = vbHourglass
   DoEvents
   
   'On Error Resume Next
   t = ""
   Filas = VBA.Split(s, vbCrLf)
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      Aplicacion.Tarea "ProntoIniClaves_Eliminar", Columnas(0)
      For Each oNode In Arbol.Nodes
         If InStr(1, oNode.Key, "|") <> 0 Then
            mVector = VBA.Split(oNode.Key, "|")
            If mVector(1) = Columnas(0) Then t = t & oNode.Key & vbTab
         End If
      Next
   Next
   If Len(t) > 0 Then
      mVector = VBA.Split(t, vbTab)
      For i = 0 To UBound(mVector)
         If Len(mVector(i)) > 0 Then Arbol.Nodes.Remove (Arbol.Nodes(mVector(i)).Key)
      Next
   End If
   
   Set Lista.DataSource = Aplicacion.TablasGenerales.TraerFiltrado("ProntoIniClaves", "_Todo")

   Me.MousePointer = vbDefault
   
End Sub

Public Sub Expandir(ByVal Modo As Boolean)

   Dim oNode As Node
   For Each oNode In Arbol.Nodes
      oNode.Expanded = Modo
   Next

End Sub

Public Sub CopiarNodo()

   If Not Arbol.SelectedItem Is Nothing Then
      Dim s As String
      s = Arbol.SelectedItem.Key
      With Clipboard
         .Clear
         .SetText s
      End With
   End If

End Sub

Public Sub PegarNodo()

   If Arbol.SelectedItem Is Nothing Then Exit Sub
      
   Dim oRs As ADOR.Recordset
   Dim s As String, mError As String
   Dim mIdEmpleado As Long, mIdEmpleadoDest As Long
   Dim Filas, Columnas
   
   s = Clipboard.GetText(vbCFText)
   
   If Len(s) = 0 Then
      MsgBox "No hay informacion para copiar", vbCritical
      Exit Sub
   End If

   On Error Resume Next
   
   If mId(s, 1, 1) = "K" Then
'      On Error Resume Next
      mIdEmpleado = CLng(mId(s, 2, Len(s) - 1))
      mIdEmpleadoDest = CLng(mId(Arbol.SelectedItem.Key, 2, Len(Arbol.SelectedItem.Key) - 1))
      Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("ProntoIni", "_Todo", Array(mIdEmpleado, -1))
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If oRs.Fields("IdProntoIniClave").Value <> 0 Then
               Arbol.Nodes.Add Arbol.SelectedItem.Key, tvwChild, mIdEmpleadoDest & "|" & oRs.Fields("IdProntoIniClave").Value, _
                              oRs.Fields("Clave").Value & "=" & oRs.Fields("Valor").Value, "Etapas", "Etapas"
               Aplicacion.Tarea "ProntoIni_Actualizar", Array(0, mIdEmpleadoDest, _
                              oRs.Fields("IdProntoIniClave").Value, oRs.Fields("Valor").Value)
            End If
            oRs.MoveNext
         Loop
      End If
      oRs.Close
   End If

End Sub
