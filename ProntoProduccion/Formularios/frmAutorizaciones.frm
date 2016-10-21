VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "msdatlst.ocx"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmAutorizaciones 
   Caption         =   "Definicion de autorizaciones"
   ClientHeight    =   4590
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   12390
   Icon            =   "frmAutorizaciones.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4590
   ScaleWidth      =   12390
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   4680
      TabIndex        =   1
      Top             =   3690
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   420
      Index           =   1
      Left            =   6210
      TabIndex        =   0
      Top             =   3690
      Width           =   1470
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdFormulario"
      Height          =   315
      Index           =   0
      Left            =   3555
      TabIndex        =   2
      Tag             =   "Formularios"
      Top             =   90
      Width           =   6135
      _ExtentX        =   10821
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdFormulario"
      Text            =   ""
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   3
      Top             =   4305
      Width           =   12390
      _ExtentX        =   21855
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   9180
      Top             =   3600
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizaciones.frx":076A
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizaciones.frx":087C
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizaciones.frx":0CCE
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizaciones.frx":1120
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   2895
      Left            =   45
      TabIndex        =   4
      Top             =   540
      Width           =   12300
      _ExtentX        =   21696
      _ExtentY        =   5106
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmAutorizaciones.frx":1572
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Formulario : "
      Height          =   240
      Index           =   7
      Left            =   2115
      TabIndex        =   5
      Top             =   135
      Width           =   1395
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
End
Attribute VB_Name = "frmAutorizaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Autorizacion
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long

Sub Editar(ByVal Cual As Long)

   Dim oF As frmDetAutorizaciones
   Dim oL As ListItem
   Dim i As Integer
   
   If Not IsNumeric(dcfields(0).BoundText) Then
      MsgBox "Debe definir el formulario", vbExclamation
      Exit Sub
   End If
   
   Set oF = New frmDetAutorizaciones
   
   With oF
      Set .Autorizacion = origen
      .Formulario = dcfields(0).BoundText
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = Lista.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = Lista.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtOrdenAutorizacion.Text
            For i = 1 To 6
               If oF.Option1(i - 1).Value Then
                  If Len(Trim(oF.DataCombo1((i - 1) * 2).Text)) <> 0 Then
                     .SubItems(i) = "" & oF.DataCombo1((i - 1) * 2).Text & " : [ " & oF.DataCombo1((i - 1) * 2 + 1).Text & " ]"
                  End If
               ElseIf oF.Option2(i - 1).Value Then
                  If Len(Trim(oF.DataCombo1((i - 1) * 2 + 1).Text)) <> 0 Then
                     .SubItems(i) = "Sector emisor : [ " & oF.DataCombo1((i - 1) * 2 + 1).Text & " ] de " & _
                                    Format(oF.txtImporte((i - 1) * 2).Text, "##0.00") & " a " & _
                                    Format(oF.txtImporte((i - 1) * 2 + 1).Text, "##0.00")
                  End If
               ElseIf oF.Option5(i - 1).Value Then
                  If Len(Trim(oF.DataCombo2(i - 1).Text)) <> 0 Then
                     .SubItems(i) = "Firmante : [ " & oF.DataCombo2(i - 1).Text & " ] de " & _
                                    Format(oF.txtImporte((i - 1) * 2).Text, "##0.00") & " a " & _
                                    Format(oF.txtImporte((i - 1) * 2 + 1).Text, "##0.00")
                  End If
               ElseIf oF.Option3(i - 1).Value Then
                  .SubItems(i) = "Sector emisor : [ Jefe de obra ] de " & _
                                    Format(oF.txtImporte((i - 1) * 2).Text, "##0.00") & " a " & _
                                    Format(oF.txtImporte((i - 1) * 2 + 1).Text, "##0.00")
               Else
                  .SubItems(i) = ""
               End If
            Next
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
      
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
      
         If Lista.ListItems.Count = 0 Then
            MsgBox "No hay detalles a registrar", vbExclamation
            Exit Sub
         End If
         
         For Each dc In dcfields
            If Len(Trim(dc.BoundText)) = 0 Then
               MsgBox "Falta completar el campo " & dc.Tag, vbCritical
               Exit Sub
            End If
            origen.Registro.Fields(dc.DataField).Value = dc.BoundText
         Next
      
         Select Case origen.Guardar
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
   End Select
   
   Unload Me

End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   If IsNumeric(dcfields(Index).BoundText) Then
   
      Dim oAp As ComPronto.Aplicacion
      Dim oRs As ADOR.Recordset
      
      Set origen = Nothing
      Set oBind = Nothing
      
      Set oAp = Aplicacion
      Set oRs = oAp.Autorizaciones.TraerFiltrado("_PorIdFormulario", dcfields(Index).BoundText)
      
      If oRs.RecordCount > 0 Then
         Set origen = oAp.Autorizaciones.Item(oRs.Fields(0).Value)
      Else
         Set origen = oAp.Autorizaciones.Item(-1)
      End If
      oRs.Close
      
      Set oBind = New BindingCollection
      Set oBind.DataSource = origen
      
      Lista.ListItems.Clear
      
      Set oRs = origen.DetAutorizaciones.TraerTodos
      
      If oRs.RecordCount > 0 Then
         Set Lista.DataSource = oRs
      Else
         Set Lista.DataSource = origen.DetAutorizaciones.TraerMascara
         Lista.ListItems.Clear
      End If
      oRs.Close
      
      Set oRs = Nothing
      Set oAp = Nothing

   End If

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   For Each oI In img16.ListImages
      With Estado.Panels.Add(, , oI.Key)
         .Picture = oI.Picture
      End With
   Next

   Set dcfields(0).RowSource = Aplicacion.Formularios.TraerLista
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()
    
   'Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set origen = Nothing
   Set oBind = Nothing

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
      MnuDetA_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetA_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetA_Click 1
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count = 0 Then
         MnuDetA(1).Enabled = False
         MnuDetA(2).Enabled = False
         PopupMenu MnuDet, , , , MnuDetA(0)
      Else
         MnuDetA(1).Enabled = True
         MnuDetA(2).Enabled = True
         PopupMenu MnuDet, , , , MnuDetA(1)
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         Editar Lista.SelectedItem.Tag
      Case 2
         With Lista.SelectedItem
            origen.DetAutorizaciones.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub


