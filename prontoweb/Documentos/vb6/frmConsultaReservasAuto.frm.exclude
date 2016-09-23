VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmConsultaReservasAuto 
   Caption         =   "Reservas de stock pendientes"
   ClientHeight    =   6990
   ClientLeft      =   60
   ClientTop       =   630
   ClientWidth     =   11190
   Icon            =   "frmConsultaReservasAuto.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6990
   ScaleWidth      =   11190
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   450
      Index           =   5
      Left            =   9765
      TabIndex        =   8
      Top             =   6120
      Width           =   1350
   End
   Begin VB.CommandButton cmd 
      Caption         =   "R&egistrar Datos"
      Height          =   450
      Index           =   4
      Left            =   8235
      TabIndex        =   6
      Top             =   6120
      Width           =   1350
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Solo &R.M."
      Height          =   450
      Index           =   0
      Left            =   2925
      TabIndex        =   5
      Top             =   6120
      Width           =   1350
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Solo &Acopios"
      Height          =   450
      Index           =   1
      Left            =   1485
      TabIndex        =   4
      Top             =   6120
      Visible         =   0   'False
      Width           =   1350
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Todos"
      Height          =   450
      Index           =   2
      Left            =   45
      TabIndex        =   3
      Top             =   6120
      Width           =   1350
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Por &Obra"
      Height          =   450
      Index           =   3
      Left            =   4590
      TabIndex        =   2
      Top             =   6120
      Width           =   1350
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   7515
      Top             =   6075
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
            Picture         =   "frmConsultaReservasAuto.frx":076A
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaReservasAuto.frx":087C
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaReservasAuto.frx":098E
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaReservasAuto.frx":0AA0
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaReservasAuto.frx":0BB2
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaReservasAuto.frx":0CC4
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaReservasAuto.frx":0DD6
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11190
      _ExtentX        =   19738
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
   Begin Controles1013.DbListView Lista 
      Height          =   5550
      Left            =   45
      TabIndex        =   1
      Top             =   495
      Width           =   11085
      _ExtentX        =   19553
      _ExtentY        =   9790
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaReservasAuto.frx":1228
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   6075
      TabIndex        =   7
      Tag             =   "Obras"
      Top             =   6165
      Visible         =   0   'False
      Width           =   1410
      _ExtentX        =   2487
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   9
      Top             =   6600
      Width           =   11190
      _ExtentX        =   19738
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   2
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   10398
            MinWidth        =   5292
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   8819
            MinWidth        =   8819
         EndProperty
      EndProperty
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Opciones de confirmacion"
      Begin VB.Menu MnuDetA 
         Caption         =   "Reservar todo (segun stock disponible)"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Reservar todo (aunque no tenga stock disponible)"
         Index           =   1
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Reservar manualmente"
         Index           =   2
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Quitar todas las reservas"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Marcar para procesar todo"
         Index           =   4
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Marcar para procesar solo lo reservado"
         Index           =   5
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Desmarcar todo para procesar"
         Index           =   6
      End
   End
End
Attribute VB_Name = "frmConsultaReservasAuto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmd_Click(Index As Integer)

   Dim oPar As ComPronto.Parametro
   
   Select Case Index
      
      Case 0, 1, 2
         
         With dcfields(0)
            .Visible = False
            .BoundText = ""
         End With

         Me.MousePointer = vbHourglass
         
         Lista.ListItems.Clear
         
         Aplicacion.Tarea ("Reservas_Generar")
         
         Lista.Sorted = False
         Lista.CheckBoxes = True
         
         Select Case Index
            Case 0
               Set Lista.DataSource = Aplicacion.Reservas.TraerFiltrado("_Reservar_RM")
            Case 1
               Set Lista.DataSource = Aplicacion.Reservas.TraerFiltrado("_Reservar_Acopios")
            Case 2
               Set Lista.DataSource = Aplicacion.Reservas.TraerFiltrado("_Reservar")
         End Select
         ReemplazarEtiquetasListas Lista
         
         MarcarArticulosIguales
         
         StatusBar1.Panels(1).Text = " " & Lista.ListItems.Count & " elementos en la lista"
   
         Me.MousePointer = vbDefault
      
      Case 3
      
         If Not dcfields(0).Visible Then
            dcfields(0).Visible = True
            cmd(3).Caption = "Buscar obra"
         Else
            If IsNumeric(dcfields(0).BoundText) Then
               Me.MousePointer = vbHourglass
               Lista.ListItems.Clear
               Aplicacion.Tarea ("Reservas_Generar")
               Lista.Sorted = False
               Lista.CheckBoxes = True
               Set Lista.DataSource = Aplicacion.Reservas.TraerFiltrado("_Reservar_PorObra", dcfields(0).BoundText)
               MarcarArticulosIguales
               StatusBar1.Panels(1).Text = " " & Lista.ListItems.Count & " elementos en la lista"
               Me.MousePointer = vbDefault
            Else
               MsgBox "No definio la obra", vbExclamation
            End If
         End If
         
      Case 4
      
         Dim oL As ListItem
         Dim mCheck, mvarOK, mReserva As Boolean
         Dim mAprobo, mNumeroReserva, mIdAlmacen As Long
         Dim mConfirma As Integer
         Dim oRs As ADOR.Recordset
         
         mConfirma = MsgBox("Esta seguro de procesar la informacion ?", vbYesNo, "Confirmacion y generacion de reservas")
         If mConfirma = vbNo Then
            Exit Sub
         End If
         
         mCheck = False
         mReserva = False
         
         If Lista.ListItems.Count > 0 Then
            For Each oL In Lista.ListItems
               If oL.Checked Then
                  mCheck = True
                  Exit For
               End If
            Next
         End If
         
         If Not mCheck Then
            MsgBox "No hay informacion a procesar!", vbExclamation
            Exit Sub
         End If
         
         Set oPar = Aplicacion.Parametros.Item(1)
         mIdAlmacen = oPar.Registro.Fields("IdSectorAlmacen").Value
         Set oPar = Nothing
         
         Dim oF As frmAutorizacion2
         Set oF = New frmAutorizacion2
         With oF
            .Sector = Aplicacion.Sectores.Item(mIdAlmacen).Registro.Fields("Descripcion").Value
            .Show vbModal, Me
         End With
         mvarOK = oF.Ok
         mAprobo = oF.IdAutorizo
         Unload oF
         Set oF = Nothing
         If Not mvarOK Then
            MsgBox "Proceso abortado", vbExclamation
            Exit Sub
         End If
   
         Me.MousePointer = vbHourglass
         DoEvents
         
         Dim oAp As ComPronto.Aplicacion
         Dim oReq As ComPronto.Requerimiento
         Dim oAco As ComPronto.Acopio
         Dim oRes As ComPronto.Reserva
         Dim mAco, mReq, mRes As Integer
         
         Set oAp = Aplicacion
         Set oRes = oAp.Reservas.Item(-1)
         
         mAco = 0
         mReq = 0
         mRes = 0
         
         If Lista.ListItems.Count > 0 Then
            For Each oL In Lista.ListItems
               If oL.Checked Or Val(oL.SubItems(12)) > 0 Then
                  If oL.Text = "Acopio" And Val(oL.SubItems(16)) > 0 Then
                     Set oAco = oAp.Acopios.Item(oL.SubItems(16))
                     With oAco.DetAcopios.Item(oL.Tag)
                        .Registro.Fields("IdAproboAlmacen").Value = mAprobo
                        .Modificado = True
                     End With
                     oAco.Guardar
'                     Set oAco = Nothing
                     mAco = mAco + 1
                  ElseIf oL.Text = "R.M." And Val(oL.SubItems(17)) > 0 Then
                     Set oReq = oAp.Requerimientos.Item(oL.SubItems(17))
                     With oReq.DetRequerimientos.Item(oL.Tag)
                        .Registro.Fields("IdAproboAlmacen").Value = mAprobo
                        .Modificado = True
                     End With
                     oReq.Guardar
'                     Set oReq = Nothing
                     mReq = mReq + 1
                  End If
               End If
               If Val(oL.SubItems(12)) > 0 Then
                  mReserva = True
                  With oRes.DetReservas.Item(-1)
                     With .Registro
                        .Fields("IdObra").Value = oL.SubItems(18)
                        .Fields("IdArticulo").Value = oL.SubItems(19)
                        .Fields("CantidadUnidades").Value = oL.SubItems(12)
                        .Fields("IdUnidad").Value = oL.SubItems(20)
                        If oL.Text = "Acopio" Then
                           .Fields("IdDetalleAcopios").Value = oL.Tag
                        ElseIf oL.Text = "R.M." Then
                           .Fields("IdDetalleRequerimiento").Value = oL.Tag
                        End If
                     End With
                     .Modificado = True
                     mRes = mRes + 1
                  End With
               End If
               StatusBar1.Panels(2).Text = " Procesado : " & mAco & " Acopios, " & mReq & " RM y " & mRes & " Reservas"
            Next
            If mReserva Then
               Set oPar = oAp.Parametros.Item(1)
               With oPar.Registro
                  mNumeroReserva = .Fields("ProximoNumeroReservaStock").Value
                  .Fields("ProximoNumeroReservaStock").Value = mNumeroReserva + 1
               End With
               oPar.Guardar
               Set oPar = Nothing
               With oRes.Registro
                  .Fields("NumeroReserva").Value = mNumeroReserva
                  .Fields("FechaReserva").Value = Now
                  .Fields("Tipo").Value = "A"
               End With
               oRes.Guardar
'               Set oRes = Nothing
            End If
         End If
         
         Set oRs = Nothing
         Set oAco = Nothing
         Set oReq = Nothing
         Set oRes = Nothing
         Set oAp = Nothing
         
         Me.MousePointer = vbDefault
      
         Unload Me
         
      Case 5
         
         Unload Me
         
   End Select
   
End Sub

Private Sub Form_Load()

   Set dcfields(0).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo")
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count > 0 Then
         PopupMenu MnuDet, , , , MnuDetA(2)
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Dim oL As ListItem
   Dim oF As Form
   Dim mItems As String
   Dim mCant As Double
   Dim mOk As Boolean
   
   Select Case Index
      Case 0
         For Each oL In Lista.ListItems
            If Val(oL.SubItems(11)) >= Val(oL.SubItems(7)) Then
               oL.SubItems(12) = oL.SubItems(7)
               oL.Checked = True
            Else
               If Val(oL.SubItems(11)) > 0 Then
                  oL.SubItems(12) = oL.SubItems(11)
                  oL.Checked = True
               End If
            End If
         Next
      Case 1
         For Each oL In Lista.ListItems
            oL.SubItems(12) = oL.SubItems(7)
            oL.Checked = True
         Next
      Case 2
         mItems = ""
         For Each oL In Lista.ListItems
            With oL
               If .Selected Then
                  mItems = mItems & .Text & vbTab & " Numero : " & .SubItems(1) & vbTab & " Item : " & .SubItems(3) & vbCrLf
               End If
            End With
         Next
         Set oF = New frmReservasIngresoManual
         With oF
            .Items = mItems
            .Show vbModal, Me
            mOk = .Ok
            mCant = Val(.txtCantidadReservada.Text)
         End With
         Unload oF
         Set oF = Nothing
         If mOk Then
            For Each oL In Lista.ListItems
               With oL
                  If .Selected Then
                     .SubItems(12) = mCant
                     .Checked = True
                  End If
               End With
            Next
         End If
      Case 3
         For Each oL In Lista.ListItems
            oL.SubItems(12) = ""
            oL.Checked = False
         Next
      Case 4
         For Each oL In Lista.ListItems
            oL.Checked = True
         Next
      Case 5
         For Each oL In Lista.ListItems
            If Val(oL.SubItems(12)) > 0 Then
               oL.Checked = True
            End If
         Next
      Case 6
         For Each oL In Lista.ListItems
            If Val(oL.SubItems(12)) = 0 Then
               oL.Checked = False
            End If
         Next
   End Select

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   On Error GoTo Mal
   
   Select Case Button.Key
      
      Case "Imprimir"
         
         ImprimirConExcel Lista
      
      Case "Buscar"
         
         FiltradoLista Lista
'         StatusBar1.Panels(2).Text = " " & Lista.ListItems.Count & " elementos en la lista"

      Case "Excel"
         
         ExportarAExcel Lista
      
   End Select

   GoTo Salida
   
Mal:

   If Err.Number = -2147217825 Then
      MsgBox "No puede utilizar la opcion BUSCAR en un campo numerico, use otro operador", vbExclamation
   Else
'      MsgBox "Se ha producido un error al buscar ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical
   End If
   Resume

Salida:

End Sub

Public Sub MarcarArticulosIguales()

   If Lista.ListItems.Count > 0 Then
      Dim oL As ListItem
      Dim m As Integer
      Dim A As String
      m = 0
      For Each oL In Lista.ListItems
         If m = 0 Then
            A = oL.SubItems(6)
            m = 1
         End If
         If A <> oL.SubItems(6) Then
            If m = 1 Then
               m = 2
            Else
               m = 1
            End If
            A = oL.SubItems(6)
         End If
         If m = 1 Then
            oL.ForeColor = vbBlue
         Else
            oL.ForeColor = vbBlack
         End If
      Next
   End If
      
End Sub
