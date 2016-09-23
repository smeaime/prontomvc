VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmConsultaRMPendientes 
   Caption         =   "Requerimientos y listas de acopio pendientes sin nota de pedido"
   ClientHeight    =   6675
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11700
   Icon            =   "frmConsultaRMPendientes.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6675
   ScaleWidth      =   11700
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame2 
      Caption         =   "Tipo de seleccion : "
      Height          =   1185
      Left            =   2790
      TabIndex        =   11
      Top             =   5085
      Width           =   1860
      Begin VB.OptionButton Option3 
         Caption         =   "A la firma"
         Height          =   195
         Left            =   360
         TabIndex        =   14
         Top             =   945
         Width           =   1095
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Todos"
         Height          =   195
         Left            =   360
         TabIndex        =   13
         Top             =   630
         Width           =   780
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Pendientes"
         Height          =   195
         Left            =   360
         TabIndex        =   12
         Top             =   315
         Width           =   1140
      End
   End
   Begin RichTextLib.RichTextBox rchObservacionesCumplido 
      Height          =   240
      Left            =   4635
      TabIndex        =   10
      Top             =   5130
      Visible         =   0   'False
      Width           =   150
      _ExtentX        =   265
      _ExtentY        =   423
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmConsultaRMPendientes.frx":076A
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Detallado (LA)"
      Height          =   405
      Index           =   2
      Left            =   45
      TabIndex        =   7
      Top             =   5535
      Width           =   1305
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Resumido (LA)"
      Height          =   405
      Index           =   3
      Left            =   1395
      TabIndex        =   6
      Top             =   5535
      Width           =   1305
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   315
      Index           =   4
      Left            =   45
      TabIndex        =   5
      Top             =   5985
      Width           =   2655
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Resumido (RM)"
      Height          =   405
      Index           =   1
      Left            =   1395
      TabIndex        =   4
      Top             =   5085
      Width           =   1305
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Detallado (RM)"
      Height          =   405
      Index           =   0
      Left            =   45
      TabIndex        =   0
      Top             =   5085
      Width           =   1305
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   1
      Top             =   6285
      Width           =   11700
      _ExtentX        =   20638
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   4
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   16642
            Key             =   "Mensaje"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   1
            Alignment       =   1
            AutoSize        =   2
            Enabled         =   0   'False
            Object.Width           =   900
            MinWidth        =   18
            TextSave        =   "CAPS"
            Key             =   "Caps"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   2
            AutoSize        =   2
            Object.Width           =   820
            MinWidth        =   18
            TextSave        =   "NUM"
            Key             =   "Num"
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            Alignment       =   1
            AutoSize        =   2
            Object.Width           =   1693
            MinWidth        =   18
            TextSave        =   "23/10/2009"
            Key             =   "Fecha"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   4515
      Left            =   0
      TabIndex        =   2
      Top             =   495
      Width           =   11670
      _ExtentX        =   20585
      _ExtentY        =   7964
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaRMPendientes.frx":07EC
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   1035
      Top             =   6030
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaRMPendientes.frx":0808
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaRMPendientes.frx":091A
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaRMPendientes.frx":0A2C
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaRMPendientes.frx":0B3E
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaRMPendientes.frx":0C50
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaRMPendientes.frx":0D62
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaRMPendientes.frx":0E74
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   11700
      _ExtentX        =   20638
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel"
            Object.ToolTipText     =   "Exportar a Excel"
            ImageKey        =   "Excel"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageKey        =   "Print"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageKey        =   "Buscar"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   1620
      Top             =   6030
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
            Picture         =   "frmConsultaRMPendientes.frx":12C6
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaRMPendientes.frx":13D8
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaRMPendientes.frx":182A
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaRMPendientes.frx":1C7C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1050
      Left            =   6075
      TabIndex        =   8
      Top             =   5040
      Width           =   5550
      _ExtentX        =   9790
      _ExtentY        =   1852
      _Version        =   393217
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmConsultaRMPendientes.frx":20CE
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   5
      Left            =   4860
      TabIndex        =   9
      Top             =   5085
      Width           =   1185
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Asignar comprador"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Dar por cumplido"
         Index           =   1
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Generar vales de almacen"
         Index           =   2
         Visible         =   0   'False
      End
   End
End
Attribute VB_Name = "frmConsultaRMPendientes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim oRs As ADOR.Recordset
Private ModoConsulta As Integer
Private mOrigen As String

Public Property Let Id(ByVal vNewValue As String)

   mOrigen = vNewValue

End Property

Private Sub cmd_Click(Index As Integer)

   Dim mTiposComprobante As String

   If Option1.Value Then
      mTiposComprobante = "P"
   ElseIf Option2.Value Then
      mTiposComprobante = "T"
   Else
      mTiposComprobante = "F"
   End If
   
   Me.MousePointer = vbHourglass
   
   If mOrigen = "Compras" Then
      cmd(0).Enabled = False
      cmd(1).Enabled = False
      cmd(2).Enabled = False
      cmd(3).Enabled = False
      lblLabels(5).Visible = True
      rchObservaciones.Visible = True
   End If
   
   Lista.Sorted = False
   
   Select Case Index
      Case 0
         If mTiposComprobante = "F" Then
            Set oRs = Aplicacion.Requerimientos.TraerFiltrado("_PendientesDeFirma")
         ElseIf mOrigen = "Compras" Then
            Set oRs = Aplicacion.Requerimientos.TraerFiltrado("_Pendientes1", mTiposComprobante)
         Else
            Set oRs = Aplicacion.Requerimientos.TraerFiltrado("_PendientesPlaneamiento", mTiposComprobante)
         End If
         Set Lista.DataSource = oRs
      Case 1
         lblLabels(5).Visible = False
'         rchObservaciones.Visible = False
         Set oRs = Aplicacion.Requerimientos.TraerFiltrado("_PendientesPorRM1", mTiposComprobante)
         Set Lista.DataSource = oRs
      Case 2
         Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Acopios", "_Pendientes1", mTiposComprobante)
         Set Lista.DataSource = oRs
      Case 3
         lblLabels(5).Visible = False
         rchObservaciones.Visible = False
         Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Acopios", "_PendientesPorLA1", mTiposComprobante)
         Set Lista.DataSource = oRs
      Case 4
         Unload Me
         Exit Sub
   End Select
   
   ReemplazarEtiquetasListas Lista
   Lista.Refresh
   
   cmd(0).Enabled = True
   If Not Option3.Value Then
      cmd(1).Enabled = True
      cmd(2).Enabled = True
      cmd(3).Enabled = True
   End If
   
   ModoConsulta = Index
   
   Me.MousePointer = vbDefault
   
   StatusBar1.Panels(1).Text = " " & Lista.ListItems.Count & " elementos en la lista"

End Sub

Private Sub Form_Load()

   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   Option1.Value = True
   
   If Not mOrigen = "Compras" Then
      cmd(1).Visible = False
      cmd(2).Visible = False
      cmd(3).Visible = False
      Frame2.Visible = False
      lblLabels(5).Visible = False
      rchObservaciones.Visible = False
      rchObservacionesCumplido.Visible = False
      Lista.Height = 5010
      With cmd(0)
         .Left = 45
         .Top = 5625
         .Caption = "Buscar"
      End With
      With cmd(4)
         .Left = 1575
         .Top = 5625
         .Width = Me.cmd(0).Width
         .Height = Me.cmd(0).Height
      End With
   End If

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()
    
   Degradado Me

End Sub

Private Sub Form_Unload(Cancel As Integer)

   If Not oRs Is Nothing Then
      If oRs.State <> adStateOpen Then oRs.Close
   End If
   Set oRs = Nothing

End Sub

Private Sub Lista_DblClick()

   If mOrigen = "Compras" Then
      If Not Lista.SelectedItem Is Nothing Then
         Select Case ModoConsulta
            Case 0
               If Len(Trim(Lista.SelectedItem.SubItems(17))) <> 0 Then
                  Editar Lista.SelectedItem.SubItems(17)
               End If
            Case 1
               If Len(Trim(Lista.SelectedItem.Tag)) <> 0 Then
                  Editar Lista.SelectedItem.Tag
               End If
            Case 2
               If Len(Trim(Lista.SelectedItem.SubItems(14))) <> 0 Then
                  Editar Lista.SelectedItem.SubItems(14)
               End If
            Case 3
               If Len(Trim(Lista.SelectedItem.Tag)) <> 0 Then
                  Editar Lista.SelectedItem.Tag
               End If
         End Select
      End If
   End If
   
End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_ItemClick(ByVal Item As MSComctlLib.IListItem)

   If mOrigen = "Compras" Then
      If Not Lista.SelectedItem Is Nothing Then
         rchObservaciones.TextRTF = Lista.TextoLargo(Lista.SelectedItem.Tag)
      End If
   End If
   
End Sub

Private Sub Lista_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

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

Private Sub Lista_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If mOrigen = "Compras" Then
         If Lista.ListItems.Count > 0 Then
            MnuDetA(2).Visible = False
            'If ModoConsulta = 0 And glbActivarSolicitudMateriales <> "SI" Then MnuDetA(2).Visible = True
            PopupMenu MnuDet, , , , MnuDetA(0)
         End If
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         If Not Lista.SelectedItem Is Nothing And Not Option3.Value Then
            AsignaComprador
         End If
      Case 1
         If Not Lista.SelectedItem Is Nothing And Not Option3.Value Then
            DarPorCumplido
         End If
      Case 2
         If Not Lista.SelectedItem Is Nothing And Not Option3.Value And ModoConsulta = 0 Then
            GenerarValesAlmacen Lista.GetString
            cmd_Click 0
         End If
   End Select

End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      cmd(1).Enabled = True
      cmd(2).Enabled = True
      cmd(3).Enabled = True
   End If

End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      cmd(1).Enabled = True
      cmd(2).Enabled = True
      cmd(3).Enabled = True
   End If

End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      cmd(1).Enabled = False
      cmd(2).Enabled = False
      cmd(3).Enabled = False
   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   On Error GoTo Mal
   
   Select Case Button.Key
      Case "Imprimir"
         ImprimirConExcel Lista
      
      Case "Buscar"
         FiltradoLista Lista
         StatusBar1.Panels(1).Text = " " & Lista.ListItems.Count & " elementos en la lista"

      Case "Excel"
         ExportarAExcel Lista
   End Select

   GoTo Salida
   
Mal:
   If Err.Number = -2147217825 Then
      MsgBox "No puede utilizar la opcion BUSCAR en un campo numerico, use otro operador", vbExclamation
   Else
      MsgBox "Se ha producido un error al buscar ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical
   End If

Salida:

End Sub

Private Sub AsignaComprador()

   Dim mvarOK As Boolean
   
   Dim oF As frmAutorizacion2
   Set oF = New frmAutorizacion2
   With oF
      .Sector = "Compras"
      .Show vbModal, Me
   End With
   mvarOK = oF.Ok
   Unload oF
   Set oF = Nothing
   If Not mvarOK Then
'      MsgBox "Solo personal de COMPRAS puede asignar comprador", vbExclamation
      Exit Sub
   End If
   
   Dim of1 As frmAsignaComprador
   Dim oL As ListItem
   Dim oReq As ComPronto.Requerimiento
   Dim oDetR As ComPronto.DetRequerimiento
'   Dim oAco As ComPronto.Acopio
'   Dim oDetA As ComPronto.DetAcopio
   Dim oRs1 As ADOR.Recordset
   Dim mvarIdComprador As Long
   Dim mvarComprador As String
   
   Set of1 = New frmAsignaComprador
   
   With of1
      .Id = 1
      .Show vbModal, Me
      mvarOK = .Ok
      If IsNumeric(.DataCombo1(0).BoundText) Then
         mvarIdComprador = .DataCombo1(0).BoundText
         mvarComprador = .DataCombo1(0).Text
      End If
   End With
   
   Unload of1
   Set of1 = Nothing
   
   If Not mvarOK Then
      Exit Sub
   End If
   
   Me.MousePointer = vbHourglass
   
   For Each oL In Lista.ListItems
      With oL
         If .Selected Then
            Select Case ModoConsulta
               Case 0
                  If IsNumeric(.SubItems(17)) Then
                     '.SubItems(4) = "" & mvarComprador
                     If IsNumeric(.SubItems(16)) Then
                        Set oReq = Aplicacion.Requerimientos.Item(.SubItems(17))
                        Set oDetR = oReq.DetRequerimientos.Item(.SubItems(16))
                        oDetR.Registro.Fields("IdComprador").Value = mvarIdComprador
                        oDetR.Registro.Fields("FechaAsignacionComprador").Value = Now
                        oDetR.Modificado = True
                        .SmallIcon = "Modificado"
                        oReq.Guardar
                        Set oDetR = Nothing
                        Set oReq = Nothing
                     End If
                  End If
               Case 1
                  If IsNumeric(.SubItems(7)) Then
                     .SubItems(3) = "" & mvarComprador
                     Set oReq = Aplicacion.Requerimientos.Item(.SubItems(7))
                     oReq.Registro.Fields("IdComprador").Value = mvarIdComprador
                     Set oRs1 = oReq.DetRequerimientos.TraerTodos
                     With oRs1
                        If .RecordCount > 0 Then
                           .MoveFirst
                           Do While Not .EOF
                              Set oDetR = oReq.DetRequerimientos.Item(.Fields(0).Value)
                              oDetR.Registro.Fields("IdComprador").Value = mvarIdComprador
                              oDetR.Registro.Fields("FechaAsignacionComprador").Value = Now
                              oDetR.Modificado = True
                              Set oDetR = Nothing
                              .MoveNext
                           Loop
                        End If
                        .Close
                     End With
                     oReq.Guardar
                     oReq.GuardarNovedadUsuario 1, mvarIdComprador, "RM: " & oReq.Registro.Fields("NumeroRequerimiento").Value
                     Set oReq = Nothing
                  End If
               Case 2
'                  If IsNumeric(.SubItems(14)) Then
'                     .SubItems(3) = "" & mvarComprador
'                     If IsNumeric(.SubItems(13)) Then
'                        Set oAco = Aplicacion.Acopios.Item(.SubItems(14))
'                        Set oDetA = oAco.DetAcopios.Item(.SubItems(13))
'                        oDetA.Registro.Fields("IdComprador").Value = mvarIdComprador
'                        oDetA.Modificado = True
'                        .SmallIcon = "Modificado"
'                        oAco.Guardar
'                        Set oDetA = Nothing
'                        Set oAco = Nothing
'                     End If
'                  End If
               Case 3
'                  If IsNumeric(.Tag) Then
'                     .SubItems(2) = "" & mvarComprador
'                     Set oAco = Aplicacion.Acopios.Item(.Tag)
'                     oAco.Registro.Fields("IdComprador").Value = mvarIdComprador
'                     Set oRs1 = oAco.DetAcopios.TraerTodos
'                     With oRs1
'                        If .RecordCount > 0 Then
'                           .MoveFirst
'                           Do While Not .EOF
'                              Set oDetA = oAco.DetAcopios.Item(.Fields(0).Value)
'                              oDetA.Registro.Fields("IdComprador").Value = mvarIdComprador
'                              oDetA.Modificado = True
'                              Set oDetA = Nothing
'                              .MoveNext
'                           Loop
'                        End If
'                        .Close
'                     End With
'                     oAco.Guardar
'                     oAco.GuardarNovedadUsuario 1, mvarIdComprador, "ACO: " & oAco.Registro.Fields("NumeroAcopio").Value
'                     Set oAco = Nothing
'                  End If
            End Select
         End If
      End With
   Next

   Set oRs1 = Nothing
   
   Me.MousePointer = vbDefault
   
End Sub

Private Sub DarPorCumplido()

   Dim mvarOK As Boolean
   Dim mvarIdAutorizo As Long
   
   Dim oF As frmAutorizacion2
   Set oF = New frmAutorizacion2
   With oF
      .Sector = "Compras"
      .Show vbModal, Me
   End With
   mvarOK = oF.Ok
   mvarIdAutorizo = oF.IdAutorizo
   Unload oF
   Set oF = Nothing
'   If Not mvarOK Then
'      MsgBox "Solo personal de COMPRAS puede dar por cumplido", vbExclamation
'      Exit Sub
'   End If
   
   Dim of1 As frmAsignarComoCumplido
   Dim oL As ListItem
   Dim oReq As ComPronto.Requerimiento
   Dim oDetR As ComPronto.DetRequerimiento
'   Dim oAco As ComPronto.Acopio
'   Dim oDetA As ComPronto.DetAcopio
   Dim oRs1 As ADOR.Recordset
   Dim mvarIdDioPorCumplido As Long
   Dim i As Integer
   Dim mAux1 As String
   Dim Filas, Columnas
   
   Set of1 = New frmAsignarComoCumplido
   
   With of1
      .Show vbModal, Me
      mvarOK = .Ok
      If IsNumeric(.dcfields(1).BoundText) Then
         mvarIdDioPorCumplido = .dcfields(1).BoundText
      End If
   End With
   
   rchObservacionesCumplido.Text = of1.rchObservacionesCumplido.Text
   
   Unload of1
   Set of1 = Nothing
   
   If Not mvarOK Then Exit Sub
   
   Me.MousePointer = vbHourglass
   
   mAux1 = BuscarClaveINI("Avisar al solicitante de la RM que fue dada por cumplida")
   
   Filas = VBA.Split(Lista.GetString, vbCrLf)
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      Select Case ModoConsulta
         Case 0
            If IsNumeric(Columnas(18)) And Columnas(23) <> "SI" Then
               Columnas(23) = "SI"
               If IsNumeric(Columnas(18)) Then
                  Set oReq = Aplicacion.Requerimientos.Item(Columnas(18))
                  Set oDetR = oReq.DetRequerimientos.Item(Columnas(17))
                  oDetR.Registro.Fields("Cumplido").Value = "SI"
                  oDetR.Registro.Fields("IdAutorizoCumplido").Value = mvarIdAutorizo
                  oDetR.Registro.Fields("IdDioPorCumplido").Value = mvarIdDioPorCumplido
                  oDetR.Registro.Fields("FechaDadoPorCumplido").Value = Now
                  oDetR.Registro.Fields("ObservacionesCumplido").Value = rchObservacionesCumplido.Text
                  oDetR.Modificado = True
                  '.SmallIcon = "Modificado"
                  If mAux1 = "SI" Then oReq.GuardarNovedadUsuario 1, oReq.Registro.Fields("IdSolicito").Value, "RM dada por cumplida : " & mId(rchObservacionesCumplido.Text, 1, 175)
                  oReq.Guardar
                  Set oDetR = Nothing
                  Set oReq = Nothing
                  Aplicacion.Tarea "Requerimientos_ActualizarEstado", Array(Columnas(18), 0)
               End If
            End If
         Case 1
            If IsNumeric(Columnas(8)) And Columnas(7) <> "SI" Then
               Columnas(7) = "SI"
               Set oReq = Aplicacion.Requerimientos.Item(Columnas(8))
               oReq.Registro.Fields("Cumplido").Value = "SI"
               oReq.Registro.Fields("IdAutorizoCumplido").Value = mvarIdAutorizo
               oReq.Registro.Fields("IdDioPorCumplido").Value = mvarIdDioPorCumplido
               oReq.Registro.Fields("FechaDadoPorCumplido").Value = Now
               oReq.Registro.Fields("ObservacionesCumplido").Value = rchObservacionesCumplido.Text
               Set oRs1 = oReq.DetRequerimientos.TraerTodos
               With oRs1
                  If .RecordCount > 0 Then
                     .MoveFirst
                     Do While Not .EOF
                        Set oDetR = oReq.DetRequerimientos.Item(.Fields(0).Value)
                        oDetR.Registro.Fields("Cumplido").Value = "SI"
                        oDetR.Registro.Fields("IdAutorizoCumplido").Value = mvarIdAutorizo
                        oDetR.Registro.Fields("IdDioPorCumplido").Value = mvarIdDioPorCumplido
                        oDetR.Registro.Fields("FechaDadoPorCumplido").Value = Now
                        oDetR.Registro.Fields("ObservacionesCumplido").Value = rchObservacionesCumplido.Text
                        oDetR.Modificado = True
                        Set oDetR = Nothing
                        .MoveNext
                     Loop
                  End If
                  .Close
               End With
               If mAux1 = "SI" Then oReq.GuardarNovedadUsuario 1, oReq.Registro.Fields("IdSolicito").Value, "RM dada por cumplida : " & mId(rchObservacionesCumplido.Text, 1, 175)
               oReq.Guardar
               Set oReq = Nothing
               Aplicacion.Tarea "Requerimientos_ActualizarEstado", Array(Columnas(8), 0)
            End If
         Case 2
'                  If IsNumeric(.SubItems(14)) And .SubItems(16) <> "SI" Then
'                     .SubItems(16) = "SI"
'                     If IsNumeric(.SubItems(13)) Then
'                        Set oAco = Aplicacion.Acopios.Item(.SubItems(14))
'                        Set oDetA = oAco.DetAcopios.Item(.SubItems(13))
'                        oDetA.Registro.Fields("Cumplido").Value = "SI"
'                        oDetA.Registro.Fields("IdAutorizoCumplido").Value = mvarIdAutorizo
'                        oDetA.Registro.Fields("IdDioPorCumplido").Value = mvarIdDioPorCumplido
'                        oDetA.Registro.Fields("FechaDadoPorCumplido").Value = Now
'                        oDetA.Registro.Fields("ObservacionesCumplido").Value = rchObservacionesCumplido.Text
'                        oDetA.Modificado = True
'                        .SmallIcon = "Modificado"
'                        oAco.Guardar
'                        Set oDetA = Nothing
'                        Set oAco = Nothing
'                     End If
'                  End If
         Case 3
'                  If IsNumeric(.Tag) And .SubItems(4) <> "SI" Then
'                     .SubItems(4) = "SI"
'                     Set oAco = Aplicacion.Acopios.Item(.Tag)
'                     oAco.Registro.Fields("Estado").Value = "SI"
'                     oAco.Registro.Fields("IdAutorizoCumplido").Value = mvarIdAutorizo
'                     oAco.Registro.Fields("IdDioPorCumplido").Value = mvarIdDioPorCumplido
'                     oAco.Registro.Fields("FechaDadoPorCumplido").Value = Now
'                     oAco.Registro.Fields("ObservacionesCumplido").Value = rchObservacionesCumplido.Text
'                     Set oRs1 = oAco.DetAcopios.TraerTodos
'                     With oRs1
'                        If .RecordCount > 0 Then
'                           .MoveFirst
'                           Do While Not .EOF
'                              Set oDetA = oAco.DetAcopios.Item(.Fields(0).Value)
'                              oDetA.Registro.Fields("Cumplido").Value = "SI"
'                              oDetA.Registro.Fields("IdAutorizoCumplido").Value = mvarIdAutorizo
'                              oDetA.Registro.Fields("IdDioPorCumplido").Value = mvarIdDioPorCumplido
'                              oDetA.Registro.Fields("FechaDadoPorCumplido").Value = Now
'                              oDetA.Registro.Fields("ObservacionesCumplido").Value = rchObservacionesCumplido.Text
'                              oDetA.Modificado = True
'                              Set oDetA = Nothing
'                              .MoveNext
'                           Loop
'                        End If
'                        .Close
'                     End With
'                     oAco.Guardar
'                     Set oAco = Nothing
'                  End If
      End Select
   Next

   Set oRs1 = Nothing
   
   Me.MousePointer = vbDefault
   
End Sub

Private Sub Editar(ByVal Identificador As Long)

   Dim oF As Form
      
'   If ModoConsulta <= 1 Then
'      Set of = New frmRequerimientos
'   Else
'      Set of = New frmAcopios
'   End If
'
'   With of
'      .Id = Identificador
'      .Disparar = ActL
'      .Show vbModal, Me
'   End With

Salida:

   Set oF = Nothing

End Sub

