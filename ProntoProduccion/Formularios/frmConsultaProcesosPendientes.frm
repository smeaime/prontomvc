VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#3.0#0"; "Controles1013.ocx"
Begin VB.Form frmConsultaProcesosPendientes 
   Caption         =   "Procesos y consumos de art�culos pendientes"
   ClientHeight    =   6645
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   11670
   LinkTopic       =   "Form1"
   ScaleHeight     =   6645
   ScaleWidth      =   11670
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdCommand1 
      Caption         =   "Cancelar"
      Height          =   495
      Left            =   6960
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   6120
      Visible         =   0   'False
      Width           =   1695
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   435
      Index           =   4
      Left            =   9240
      TabIndex        =   4
      Top             =   6120
      Width           =   2295
   End
   Begin RichTextLib.RichTextBox rchObservacionesCumplido 
      Height          =   240
      Left            =   4635
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   5130
      Visible         =   0   'False
      Width           =   150
      _ExtentX        =   265
      _ExtentY        =   423
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmConsultaProcesosPendientes.frx":0000
   End
   Begin Controles1013.DbListView Lista 
      Height          =   5475
      Left            =   0
      TabIndex        =   0
      Top             =   495
      Width           =   11670
      _ExtentX        =   20585
      _ExtentY        =   9657
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaProcesosPendientes.frx":0082
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
            Picture         =   "frmConsultaProcesosPendientes.frx":009E
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaProcesosPendientes.frx":01B0
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaProcesosPendientes.frx":02C2
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaProcesosPendientes.frx":03D4
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaProcesosPendientes.frx":04E6
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaProcesosPendientes.frx":05F8
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaProcesosPendientes.frx":070A
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   11670
      _ExtentX        =   20585
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
            Picture         =   "frmConsultaProcesosPendientes.frx":0B5C
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaProcesosPendientes.frx":0C6E
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaProcesosPendientes.frx":10C0
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaProcesosPendientes.frx":1512
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   930
      Left            =   6075
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   5040
      Visible         =   0   'False
      Width           =   5550
      _ExtentX        =   9790
      _ExtentY        =   1640
      _Version        =   393217
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmConsultaProcesosPendientes.frx":1964
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   5
      Left            =   4860
      TabIndex        =   6
      Top             =   5085
      Visible         =   0   'False
      Width           =   1185
   End
End
Attribute VB_Name = "frmConsultaProcesosPendientes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim oRs As ADOR.Recordset
Private ModoConsulta As Integer
Private mOrigen As String

Public IdProduccionOrdenElegida
Public IdProcesoElegido
Public IdArticuloElegido
Public IdColor
Public IdDetalleProduccionOrden


Public Property Let Id(ByVal vNewValue As String)

   mOrigen = vNewValue

End Property

Private Sub cmd_Click(Index As Integer)

   Dim mTiposComprobante As String


   
   Me.MousePointer = vbHourglass
   
   'If mOrigen = "Compras" Then
   '   cmd(0).Enabled = False
   '   cmd(1).Enabled = False
   '   cmd(2).Enabled = False
   '   cmd(3).Enabled = False
   '   lblLabels(5).Visible = True
   '   rchObservaciones.Visible = True
   'End If
   
   Lista.Sorted = False
   
   
   'Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_ItemsPendientesDeProducir")
    'Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionOrdenes", "_SinCerrarParaLista")
    'Set Lista.DataSource = oRs
   
   Select Case Index
'      Case 0
'         If mTiposComprobante = "F" Then
'            Set oRs = Aplicacion.Requerimientos.TraerFiltrado("_PendientesDeFirma")
'         ElseIf mOrigen = "Compras" Then
'            Set oRs = Aplicacion.Requerimientos.TraerFiltrado("_Pendientes1", mTiposComprobante)
'         Else
'            Set oRs = Aplicacion.Requerimientos.TraerFiltrado("_PendientesPlaneamiento", mTiposComprobante)
'         End If
'         Set Lista.DataSource = oRs
'      Case 1
'         lblLabels(5).Visible = False
'         Set oRs = Aplicacion.Requerimientos.TraerFiltrado("_PendientesPorRM1", mTiposComprobante)
'         Set Lista.DataSource = oRs
'      Case 2
'         Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Acopios", "_Pendientes1", mTiposComprobante)
'         Set Lista.DataSource = oRs
'      Case 3
'         lblLabels(5).Visible = False
'         rchObservaciones.Visible = False
'         Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Acopios", "_PendientesPorLA1", mTiposComprobante)
'         Set Lista.DataSource = oRs
      Case 4
         glbIdArticuloRet = 0
        'glbCantRet = Lista.SelectedItem.SubItems(8)
        ' glbUniRet = Lista.SelectedItem.SubItems(9)
         'glbClienteRet = Lista.SelectedItem.SubItems(5)
         
         Unload Me
         Exit Sub
   End Select
   

   ReemplazarEtiquetasListas Lista
   Lista.Refresh
   
   
   ModoConsulta = Index
   
   Me.MousePointer = vbDefault
   

End Sub

Private Sub cmdCommand1_Click()
    'habilitado = False
   IdProduccionOrdenElegida = -1
         Unload Me
End Sub

Private Sub Form_Load()

   With Lista
      Set .SmallIcons = img16
      .IconoPeque�o = "Original"
   End With
   
   

   Dim oRs As ADOR.Recordset
    'TO DO 2/2/09
   'Filtrar:  que el bot�n OCs muestre las OCs que corresponden para el Material o Terminado a evaluar, idem para las OPs.
   Set oRs = TraerRecordsetConLosProcesosPendientes(Aplicacion)
   
   
   
   
   
   'Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_ItemsPendientesDeProducir")
   Set Lista.DataSource = oRs

   CambiarLenguaje Me, "esp", glbIdiomaActual


   
End Sub




Private Sub Form_Paint()
    
   'Degradado Me

End Sub

Private Sub Form_Unload(Cancel As Integer)

   If Not oRs Is Nothing Then
      If oRs.State <> adStateOpen Then
         oRs.Close
      End If
   End If
   Set oRs = Nothing

End Sub

Public Sub Lista_DblClick()
On Error Resume Next
   If mOrigen = "Compras" Then
      If Not Lista.SelectedItem Is Nothing Then
         Select Case ModoConsulta
            Case 0
            '   If Len(Trim(Lista.SelectedItem.SubItems(17))) <> 0 Then
            '      Editar Lista.SelectedItem.SubItems(17)
            '   End If
            Case 1
            '   If Len(Trim(Lista.SelectedItem.Tag)) <> 0 Then
            '      Editar Lista.SelectedItem.Tag
            '   End If
            Case 2
            '   If Len(Trim(Lista.SelectedItem.SubItems(14))) <> 0 Then
            '      Editar Lista.SelectedItem.SubItems(14)
            '   End If
            Case 3
            '   If Len(Trim(Lista.SelectedItem.Tag)) <> 0 Then
            '      Editar Lista.SelectedItem.Tag
            '   End If
         End Select
      End If
   End If
   

         
                 IdProduccionOrdenElegida = Lista.SelectedItem.Tag
        IdProcesoElegido = Lista.SelectedItem.SubItems(6)
        IdArticuloElegido = Lista.SelectedItem.SubItems(5)
        
        IdColor = Lista.SelectedItem.SubItems(10)
        IdDetalleProduccionOrden = Lista.SelectedItem.SubItems(8)
         'IdStock = Lista.SelectedItem.SubItems(10)

         
         Me.Hide

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

Private Sub Lista_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, y As Single, State As Integer)

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

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, y As Single)
'
'   If Button = vbRightButton Then
'      If mOrigen = "Compras" Then
'         If Lista.ListItems.Count > 0 Then
'            MnuDetA(2).Visible = False
'            If ModoConsulta = 0 And glbActivarSolicitudMateriales <> "SI" Then
'               MnuDetA(2).Visible = True
'            End If
'            PopupMenu MnuDet, , , , MnuDetA(0)
'         End If
'      End If
'   End If

End Sub



Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   On Error GoTo Mal
   
   Select Case Button.Key
      
      Case "Imprimir"
         
         ImprimirConExcel Lista
      
      Case "Buscar"
         
         FiltradoLista Lista
         'StatusBar1.Panels(1).Text = " " & Lista.ListItems.Count & " elementos en la lista"

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
   
   Dim of1 'As frmAsignaComprador
   Dim oL As ListItem
   Dim oReq As ComPronto.Requerimiento
   Dim oDetR As ComPronto.DetRequerimiento
'   Dim oAco As ComPronto.Acopio
'   Dim oDetA As ComPronto.DetAcopio
   Dim oRs1 As ADOR.Recordset
   Dim mvarIdComprador As Long
   Dim mvarComprador As String
   
   'Set of1 = New frmAsignaComprador
   
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
   
   Dim of1 'As frmAsignarComoCumplido
   Dim oL As ListItem
   Dim oReq As ComPronto.Requerimiento
   Dim oDetR As ComPronto.DetRequerimiento
'   Dim oAco As ComPronto.Acopio
'   Dim oDetA As ComPronto.DetAcopio
   Dim oRs1 As ADOR.Recordset
   Dim mvarIdDioPorCumplido As Long
   Dim i As Integer
   Dim Filas, Columnas
   
   'Set of1 = New frmAsignarComoCumplido
   
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
   
   If Not mvarOK Then
      Exit Sub
   End If
   
   Me.MousePointer = vbHourglass
   
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



