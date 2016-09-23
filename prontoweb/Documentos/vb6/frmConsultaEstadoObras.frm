VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmConsultaEstadoObras 
   Caption         =   "Estado general de entregas por obra - equipo"
   ClientHeight    =   8280
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11955
   Icon            =   "frmConsultaEstadoObras.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8280
   ScaleWidth      =   11955
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Activar fechas :"
      Height          =   240
      Left            =   5580
      TabIndex        =   36
      Top             =   495
      Width           =   1410
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Seguimiento x equipo opcional :"
      Height          =   195
      Left            =   3645
      TabIndex        =   27
      Top             =   3060
      Width           =   2580
   End
   Begin VB.TextBox txtNumeroAcopio 
      Alignment       =   1  'Right Justify
      Height          =   330
      Left            =   4275
      TabIndex        =   26
      Top             =   7875
      Width           =   1230
   End
   Begin VB.TextBox txtNumeroRequerimiento 
      Alignment       =   1  'Right Justify
      Height          =   330
      Left            =   4275
      TabIndex        =   25
      Top             =   7425
      Width           =   1230
   End
   Begin VB.Frame Frame3 
      Caption         =   "LA : "
      Height          =   375
      Left            =   1350
      TabIndex        =   22
      Top             =   7830
      Visible         =   0   'False
      Width           =   2850
      Begin VB.OptionButton Option5 
         Caption         =   "Todas"
         Height          =   195
         Left            =   675
         TabIndex        =   24
         Top             =   135
         Width           =   825
      End
      Begin VB.OptionButton Option6 
         Caption         =   "Elegir una"
         Height          =   195
         Left            =   1575
         TabIndex        =   23
         Top             =   135
         Width           =   1140
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "RM : "
      Height          =   375
      Left            =   1350
      TabIndex        =   19
      Top             =   7380
      Width           =   2850
      Begin VB.OptionButton Option4 
         Caption         =   "Elegir una"
         Height          =   195
         Left            =   1575
         TabIndex        =   21
         Top             =   135
         Width           =   1140
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Todas"
         Height          =   195
         Left            =   675
         TabIndex        =   20
         Top             =   135
         Width           =   825
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Obras : "
      Height          =   375
      Left            =   1350
      TabIndex        =   16
      Top             =   6930
      Width           =   2850
      Begin VB.OptionButton Option1 
         Caption         =   "Todas"
         Height          =   195
         Left            =   675
         TabIndex        =   18
         Top             =   135
         Width           =   825
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Elegir una"
         Height          =   195
         Left            =   1575
         TabIndex        =   17
         Top             =   135
         Width           =   1140
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "LA + RM"
      Height          =   300
      Index           =   2
      Left            =   45
      TabIndex        =   10
      Top             =   7560
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Solo &Acopios"
      Height          =   300
      Index           =   1
      Left            =   45
      TabIndex        =   9
      Top             =   7245
      Visible         =   0   'False
      Width           =   1215
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1230
      Left            =   5580
      TabIndex        =   6
      Top             =   6975
      Width           =   6315
      _ExtentX        =   11139
      _ExtentY        =   2170
      _Version        =   393217
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmConsultaEstadoObras.frx":076A
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   390
      Index           =   4
      Left            =   45
      TabIndex        =   1
      Top             =   7830
      Width           =   1215
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   90
      Top             =   7605
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaEstadoObras.frx":07EC
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaEstadoObras.frx":08FE
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaEstadoObras.frx":0A10
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaEstadoObras.frx":0B22
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaEstadoObras.frx":0C34
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaEstadoObras.frx":0D46
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaEstadoObras.frx":0E58
            Key             =   "Excel"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaEstadoObras.frx":12AA
            Key             =   "Excel1"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   2220
      Left            =   45
      TabIndex        =   3
      Top             =   765
      Width           =   11850
      _ExtentX        =   20902
      _ExtentY        =   3916
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaEstadoObras.frx":1844
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaPedidos 
      Height          =   1050
      Left            =   45
      TabIndex        =   4
      Top             =   4590
      Width           =   11850
      _ExtentX        =   20902
      _ExtentY        =   1852
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaEstadoObras.frx":1860
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaRecepciones 
      Height          =   1050
      Left            =   45
      TabIndex        =   5
      Top             =   5850
      Width           =   5865
      _ExtentX        =   10345
      _ExtentY        =   1852
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaEstadoObras.frx":187C
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaFacturasAsignadas 
      Height          =   1050
      Left            =   45
      TabIndex        =   11
      Top             =   3285
      Width           =   11850
      _ExtentX        =   20902
      _ExtentY        =   1852
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaEstadoObras.frx":1898
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   4275
      TabIndex        =   13
      Tag             =   "Obras"
      Top             =   7020
      Visible         =   0   'False
      Width           =   1230
      _ExtentX        =   2170
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11955
      _ExtentX        =   21087
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel"
            Object.ToolTipText     =   "Exportar a Excel"
            ImageKey        =   "Excel"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel1"
            Object.ToolTipText     =   "Listado para obras"
            ImageKey        =   "Excel1"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageKey        =   "Print"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageKey        =   "Buscar"
         EndProperty
      EndProperty
   End
   Begin RichTextLib.RichTextBox rchAuxiliar 
      Height          =   195
      Left            =   3690
      TabIndex        =   14
      Top             =   5625
      Visible         =   0   'False
      Width           =   645
      _ExtentX        =   1138
      _ExtentY        =   344
      _Version        =   393217
      ReadOnly        =   -1  'True
      TextRTF         =   $"frmConsultaEstadoObras.frx":18B4
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   1
      Left            =   6300
      TabIndex        =   28
      Tag             =   "Articulos"
      Top             =   3015
      Width           =   5595
      _ExtentX        =   9869
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Traer &RM's"
      Height          =   840
      Index           =   0
      Left            =   45
      TabIndex        =   2
      Top             =   6930
      Width           =   1215
   End
   Begin Controles1013.DbListView ListaSalidas 
      Height          =   1050
      Left            =   5940
      TabIndex        =   30
      Top             =   5850
      Width           =   5955
      _ExtentX        =   10504
      _ExtentY        =   1852
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaEstadoObras.frx":1936
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   285
      Index           =   0
      Left            =   8190
      TabIndex        =   32
      Top             =   450
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   503
      _Version        =   393216
      Enabled         =   0   'False
      Format          =   64225281
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   285
      Index           =   1
      Left            =   10575
      TabIndex        =   33
      Top             =   450
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   503
      _Version        =   393216
      Enabled         =   0   'False
      Format          =   64225281
      CurrentDate     =   36377
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha inicial :"
      Height          =   195
      Index           =   0
      Left            =   7110
      TabIndex        =   35
      Top             =   495
      Width           =   1020
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha final :"
      Height          =   195
      Index           =   1
      Left            =   9585
      TabIndex        =   34
      Top             =   495
      Width           =   930
   End
   Begin VB.Label Label1 
      Caption         =   "Salidas de materiales por item de RM :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   4
      Left            =   5985
      TabIndex        =   31
      Top             =   5670
      Width           =   3345
   End
   Begin VB.Label Label1 
      Caption         =   "Datos de los requerimientos :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   3
      Left            =   90
      TabIndex        =   29
      Top             =   585
      Width           =   2535
   End
   Begin VB.Label lblItems 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   195
      Left            =   8595
      TabIndex        =   15
      Top             =   3060
      Width           =   3255
   End
   Begin VB.Label Label1 
      Caption         =   "Facturas asignadas :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   2
      Left            =   90
      TabIndex        =   12
      Top             =   3105
      Width           =   1860
   End
   Begin VB.Label Label1 
      Caption         =   "Recepciones por item de RM :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   1
      Left            =   90
      TabIndex        =   8
      Top             =   5670
      Width           =   2625
   End
   Begin VB.Label Label1 
      Caption         =   "Pedidos por item de RM :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   0
      Left            =   90
      TabIndex        =   7
      Top             =   4410
      Width           =   2220
   End
End
Attribute VB_Name = "frmConsultaEstadoObras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Check1_Click()

   If Check1.Value = 1 Then
      dcfields(1).Enabled = True
   Else
      dcfields(1).Enabled = False
   End If

End Sub

Private Sub Check2_Click()

   If Check2.Value = 1 Then
      DTFields(0).Enabled = True
      DTFields(1).Enabled = True
   Else
      DTFields(0).Enabled = False
      DTFields(1).Enabled = False
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0, 1, 2
         
         If Option2.Value And Not IsNumeric(dcfields(0).BoundText) Then
            MsgBox "Debe indicar una obra", vbExclamation
            Exit Sub
         End If
         
         If Option4.Value And Len(txtNumeroRequerimiento.Text) = 0 Then
            MsgBox "Debe indicar un numero de requerimiento", vbExclamation
            Exit Sub
         End If
         
         If Option6.Value And Len(txtNumeroAcopio.Text) = 0 Then
            MsgBox "Debe indicar un numero de acopio", vbExclamation
            Exit Sub
         End If
         
         If Check1.Value = 1 And Not IsNumeric(dcfields(1).BoundText) Then
            MsgBox "Debe ingresar un equipo para seguimiento", vbExclamation
            Exit Sub
         End If
         
         Me.MousePointer = vbHourglass
         
         Lista.ListItems.Clear
         ListaPedidos.ListItems.Clear
         ListaPedidos.ColumnHeaders.Clear
         ListaRecepciones.ListItems.Clear
         ListaRecepciones.ColumnHeaders.Clear
         ListaFacturasAsignadas.ListItems.Clear
         ListaFacturasAsignadas.ColumnHeaders.Clear
         rchObservaciones.Text = ""
         
         DoEvents
         
         Dim oAp As ComPronto.Aplicacion
         Dim mIdObra As Long, mReq As Long, mAco As Long, mArt As Long
         Dim mPorFecha As Integer
         
         If Option1.Value Then
            mIdObra = -1
         Else
            mIdObra = dcfields(0).BoundText
         End If
         
         If Option3.Value Then
            mReq = -1
         Else
            mReq = Val(txtNumeroRequerimiento.Text)
         End If
         
         If Option5.Value Then
            mAco = -1
         Else
            mAco = Val(txtNumeroAcopio.Text)
         End If
         
         If Check1.Value = 1 Then
            mArt = dcfields(1).BoundText
         Else
            mArt = -1
         End If
         
         mPorFecha = -1
         If Check2.Value = 1 Then mPorFecha = 0
         
         Set oAp = Aplicacion
         
         oAp.Tarea "Obras_GenerarEstado", mArt
         Lista.Sorted = False
         Select Case Index
            Case 0
               Set Lista.DataSource = oAp.Obras.TraerFiltrado("_EstadoObras_RM", _
                           Array(mIdObra, mReq, mAco, mPorFecha, DTFields(0).Value, DTFields(1).Value))
            Case 1
               Set Lista.DataSource = oAp.Obras.TraerFiltrado("_EstadoObras_Acopios", Array(mIdObra, mReq, mAco))
            Case 2
               Set Lista.DataSource = oAp.Obras.TraerFiltrado("_EstadoObras", Array(mIdObra, mReq, mAco))
         End Select
         ReemplazarEtiquetasListas Lista
         
'         Set Lista.DataSource = oAp.Obras.TraerFiltrado("_EstadoObrasPorObra", dcfields(0).BoundText)
         lblItems.Caption = "Cantidad de items : " & Lista.ListItems.Count
         
         Set oAp = Nothing
         
         Me.MousePointer = vbDefault
      
      Case 4
         
         Unload Me
         
   End Select
   
End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   SetDataComboDropdownListWidth 400

End Sub

Private Sub Form_Load()

   Set dcfields(0).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo")
   Set dcfields(1).RowSource = Aplicacion.Articulos.TraerLista
   Option1.Value = True
   Option3.Value = True
   Option5.Value = True
   DTFields(0).Value = DateSerial(Year(Date), Month(Date) - 1, 1)
   DTFields(1).Value = DateAdd("d", -1, DateAdd("m", 1, DTFields(0).Value))

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()
    
   Degradado Me

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_ItemClick(ByVal Item As MSComctlLib.IListItem)

   If Not Lista.SelectedItem Is Nothing Then
      Dim oRs As ADOR.Recordset
      rchObservaciones.TextRTF = Lista.TextoLargo(Lista.SelectedItem.Tag)
      If Lista.SelectedItem.SubItems(4) = "R.M." Then
         Set oRs = Aplicacion.Obras.TraerFiltrado("_EstadoObras_DetallePedidosDesdeRM", Lista.SelectedItem.Text)
         If oRs.RecordCount > 0 Then
            Set ListaPedidos.DataSource = oRs
            ReemplazarEtiquetasListas ListaPedidos
         Else
            ListaPedidos.ListItems.Clear
            ListaPedidos.ColumnHeaders.Clear
         End If
         oRs.Close
         Set oRs = Aplicacion.Obras.TraerFiltrado("_EstadoObras_DetalleRecepcionesDesdeRM", Lista.SelectedItem.Text)
         If oRs.RecordCount > 0 Then
            Set ListaRecepciones.DataSource = oRs
            ReemplazarEtiquetasListas ListaRecepciones
         Else
            ListaRecepciones.ListItems.Clear
            ListaRecepciones.ColumnHeaders.Clear
         End If
         oRs.Close
         Set oRs = Aplicacion.Obras.TraerFiltrado("_EstadoObras_DetalleComprobantesProveedoresAsignados", Lista.SelectedItem.Text)
         If oRs.RecordCount > 0 Then
            Set ListaFacturasAsignadas.DataSource = oRs
            ReemplazarEtiquetasListas ListaFacturasAsignadas
         Else
            ListaFacturasAsignadas.ListItems.Clear
            ListaFacturasAsignadas.ColumnHeaders.Clear
         End If
         oRs.Close
         Set oRs = Aplicacion.Obras.TraerFiltrado("_EstadoObras_DetalleSalidasDesdeRM", Lista.SelectedItem.Text)
         If oRs.RecordCount > 0 Then
            Set ListaSalidas.DataSource = oRs
            ReemplazarEtiquetasListas ListaSalidas
         Else
            ListaSalidas.ListItems.Clear
            ListaSalidas.ColumnHeaders.Clear
         End If
         oRs.Close
      Else
         Set oRs = Aplicacion.Obras.TraerFiltrado("_EstadoObras_DetallePedidosDesdeAcopio", Lista.SelectedItem.Text)
         If oRs.RecordCount > 0 Then
            Set ListaPedidos.DataSource = oRs
            ReemplazarEtiquetasListas ListaPedidos
         Else
            ListaPedidos.ListItems.Clear
            ListaPedidos.ColumnHeaders.Clear
         End If
         oRs.Close
         Set oRs = Aplicacion.Obras.TraerFiltrado("_EstadoObras_DetalleRecepcionesDesdeAcopio", Lista.SelectedItem.Text)
         If oRs.RecordCount > 0 Then
            Set ListaRecepciones.DataSource = oRs
            ReemplazarEtiquetasListas ListaRecepciones
         Else
            ListaRecepciones.ListItems.Clear
            ListaRecepciones.ColumnHeaders.Clear
         End If
         oRs.Close
         Set oRs = Aplicacion.Obras.TraerFiltrado("_EstadoObras_DetalleFacturasAsignadas", Array(EnumFormularios.ListaAcopio, Lista.SelectedItem.Text))
         If oRs.RecordCount > 0 Then
            Set ListaFacturasAsignadas.DataSource = oRs
            ReemplazarEtiquetasListas ListaFacturasAsignadas
         Else
            ListaFacturasAsignadas.ListItems.Clear
            ListaFacturasAsignadas.ColumnHeaders.Clear
         End If
         oRs.Close
      End If
      Set oRs = Nothing
      DoEvents
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

Private Sub ListaFacturasAsignadas_DblClick()

   If Not ListaFacturasAsignadas.SelectedItem Is Nothing Then
      If Len(Trim(ListaFacturasAsignadas.SelectedItem.SubItems(1))) <> 0 Then
         Editar ListaFacturasAsignadas.SelectedItem.SubItems(1), "ComprobanteProveedor"
      End If
   End If
   
End Sub

Private Sub ListaFacturasAsignadas_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaPedidos_DblClick()

   If Not ListaPedidos.SelectedItem Is Nothing Then
      If Len(Trim(ListaPedidos.SelectedItem.SubItems(1))) <> 0 Then
         Editar ListaPedidos.SelectedItem.SubItems(1), "Pedido"
      End If
   End If
   
End Sub

Private Sub ListaPedidos_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaRecepciones_DblClick()

   If Not ListaRecepciones.SelectedItem Is Nothing Then
      If Len(Trim(ListaRecepciones.SelectedItem.SubItems(8))) <> 0 Then
         Editar ListaRecepciones.SelectedItem.SubItems(8), "Recepcion"
      End If
   End If
   
End Sub

Private Sub ListaRecepciones_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaSalidas_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      dcfields(0).Visible = False
   End If

End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      dcfields(0).Visible = True
   End If

End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      With txtNumeroRequerimiento
         .Text = ""
         .Visible = False
      End With
   End If

End Sub

Private Sub Option4_Click()

   If Option4.Value Then
      txtNumeroRequerimiento.Visible = True
   End If

End Sub

Private Sub Option5_Click()

   If Option5.Value Then
      With txtNumeroAcopio
         .Text = ""
         .Visible = False
      End With
   End If

End Sub

Private Sub Option6_Click()

   If Option6.Value Then
      txtNumeroAcopio.Visible = True
   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Key
      
      Case "Imprimir"
         
         GenerarInforme 2
         
      Case "Buscar"
         
         FiltradoLista Lista
         lblItems.Caption = "Cantidad de items : " & Lista.ListItems.Count

      Case "Excel"
         
         ExportarAExcel Lista
      
      Case "Excel1"
         
         GenerarInforme 1
      
   End Select

End Sub

Public Sub GenerarInforme(ByVal TipoSalida As Integer)

   Dim s As String, mTitulo As String, mPlantilla As String
   Dim i As Long
   Dim oEx As Excel.Application
   Dim oL As ListItem
   
   On Error Resume Next
   
   mPlantilla = glbPathPlantillas & "\EstadoObras_" & glbEmpresaSegunString & ".xlt"
   If Len(Dir(mPlantilla)) = 0 Then
      mPlantilla = glbPathPlantillas & "\EstadoObras.xlt"
      If Len(Dir(mPlantilla)) = 0 Then
         MsgBox "Plantilla inexistente", vbExclamation
         Exit Sub
      End If
   End If
   
   mTitulo = "ESTADO DE REQUERIMIENTOS"
   If Option2.Value Then
      mTitulo = mTitulo & " - Obra : " & dcfields(0).Text & "   "
   End If
   If Option4.Value Then
      mTitulo = mTitulo & " - RM Nro. : " & txtNumeroRequerimiento.Text & "   "
   End If
   If Option6.Value Then
      mTitulo = mTitulo & " - LA Nro. : " & txtNumeroAcopio.Text & "   "
   End If
   If Check1.Value = 1 Then
      mTitulo = mTitulo & "[ Seguimiento de equipo : " & dcfields(1).Text & " ]  "
   End If
   
   For Each oL In Lista.ListItems: oL.Selected = True: Next
   
   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      With .Workbooks.Add(mPlantilla)
'         With .ActiveSheet
'            .Cells(2, 2) = mTitulo
'            fl = 6
'            For Each oL In Lista.ListItems
'
'               rchAuxiliar.TextRTF = Lista.TextoLargo(oL.Tag)
'               s = rchAuxiliar.Text
'               s = Replace(s, Chr(13) + Chr(10) + Chr(13) + Chr(10), "")
'
'               .Cells(fl, 1) = oL.SubItems(4)
'               .Cells(fl, 2) = oL.SubItems(5)
'               .Cells(fl, 3) = CDate(oL.SubItems(6))
'               .Cells(fl, 4) = oL.SubItems(1)
'               .Cells(fl, 5) = oL.SubItems(9)
'               .Cells(fl, 6) = oL.SubItems(8)
'
'               .Cells(fl, 7) = CDate(oL.SubItems(11))
'               .Cells(fl, 8) = CDate(oL.SubItems(14))
'               .Cells(fl, 9) = oL.SubItems(15)
'               oEx.Cells(fl, 9).Select
'               With oEx.Selection
'                   .VerticalAlignment = xlTop
'                   .HorizontalAlignment = xlLeft
'                   .WrapText = True
'                   .Orientation = 0
'                   .AddIndent = False
'                   .ShrinkToFit = False
'                   .MergeCells = False
'               End With
'               .Cells(fl, 10) = s
'               oEx.Cells(fl, 10).Select
'               With oEx.Selection
'                   .VerticalAlignment = xlTop
'                   .HorizontalAlignment = xlLeft
'                   .WrapText = True
'                   .Orientation = 0
'                   .AddIndent = False
'                   .ShrinkToFit = False
'                   .MergeCells = False
'               End With
'               .Cells(fl, 11) = oL.SubItems(16)
'               .Cells(fl, 12) = oL.SubItems(17)
'               .Cells(fl, 13) = oL.SubItems(18)
'               .Cells(fl, 14) = oL.SubItems(19)
'               .Cells(fl, 15) = oL.SubItems(20)
'               .Cells(fl, 16) = oL.SubItems(21)
'               .Cells(fl, 17) = oL.SubItems(22)
'               oEx.Cells(fl, 18).Select
'               oEx.Selection.HorizontalAlignment = xlCenter
'               .Cells(fl, 18) = "'" & oL.SubItems(27)
'
''               If oL.SubItems(4) = "R.M." Then
''                  Set oRsAux = Aplicacion.Requerimientos.TraerFiltrado("_PorNumero", oL.SubItems(5))
''                  If oRsAux.RecordCount > 0 Then
''                     If IsNull(oRsAux.Fields("Consorcial").Value) Or oRsAux.Fields("Consorcial").Value = "NO" Then
''                        .Cells(fl, 17) = "CAUTIVA"
''                     Else
''                        .Cells(fl, 17) = "CONSORCIAL"
''                     End If
''                  End If
''                  oRsAux.Close
''                  Set oRsAux = Nothing
''               End If
'
'               If oL.SubItems(4) = "R.M." Then
'                  Set oRsPed = Aplicacion.Obras.TraerFiltrado("_EstadoObras_DetallePedidosDesdeRM", oL.Text)
'                  Set oRsRec = Aplicacion.Obras.TraerFiltrado("_EstadoObras_DetalleRecepcionesDesdeRM", oL.Text)
'                  Set oRsFac = Aplicacion.Obras.TraerFiltrado("_EstadoObras_DetalleComprobantesProveedoresAsignados", oL.Text)
'                  Set oRsSal = Aplicacion.Obras.TraerFiltrado("_EstadoObras_DetalleSalidasDesdeRM", oL.Text)
'               Else
'                  Set oRsPed = Aplicacion.Obras.TraerFiltrado("_EstadoObras_DetallePedidosDesdeAcopio", oL.Text)
'                  Set oRsRec = Aplicacion.Obras.TraerFiltrado("_EstadoObras_DetalleRecepcionesDesdeAcopio", oL.Text)
'                  Set oRsFac = Aplicacion.Obras.TraerFiltrado("_EstadoObras_DetalleFacturasAsignadas", Array(EnumFormularios.ListaAcopio, oL.Text))
'               End If
'
'               If Not (oRsPed.EOF And oRsRec.EOF And oRsFac.EOF And oRsSal.EOF) Then
'                  Do While Not (oRsPed.EOF And oRsRec.EOF And oRsFac.EOF And oRsSal.EOF)
'                     .Cells(fl, 1) = oL.SubItems(4)
'                     .Cells(fl, 2) = oL.SubItems(5)
'                     .Cells(fl, 3) = CDate(oL.SubItems(6))
'                     .Cells(fl, 4) = oL.SubItems(1)
'                     .Cells(fl, 5) = oL.SubItems(9)
'                     .Cells(fl, 6) = oL.SubItems(8)
'                     If Not oRsPed.EOF Then
'                        .Cells(fl, 22) = "Ped."
'                        .Cells(fl, 23) = oRsPed.Fields("Pedido").Value
'                        .Cells(fl, 24) = oRsPed.Fields("Fecha").Value
'                        .Cells(fl, 25) = oRsPed.Fields("Comprador").Value
'                        .Cells(fl, 26) = oRsPed.Fields("Proveedor").Value
'                        .Cells(fl, 27) = oRsPed.Fields("Mon.").Value
'                        oEx.Cells(fl, 27).Select
'                        oEx.Selection.HorizontalAlignment = xlCenter
'                        .Cells(fl, 28) = oRsPed.Fields("Precio").Value
'                        .Cells(fl, 29) = oRsPed.Fields("ImporteItem").Value
'                        .Cells(fl, 30) = oRsPed.Fields("Importe s/iva").Value
'                        .Cells(fl, 31) = oRsPed.Fields("F.entrega").Value
'                        oRsPed.MoveNext
'                     End If
'                     If Not oRsRec.EOF Then
'                        .Cells(fl, 33) = "Rec."
'                        .Cells(fl, 34) = oRsRec.Fields("NumeroRecepcionAlmacen").Value
'                        .Cells(fl, 35) = oRsRec.Fields("Recepcion").Value
'                        .Cells(fl, 36) = oRsRec.Fields("Fecha").Value
'                        .Cells(fl, 37) = oRsRec.Fields("Cantidad").Value
'                        .Cells(fl, 38) = oRsRec.Fields("Unid.").Value
'                        oRsRec.MoveNext
'                     End If
'                     If Not oRsFac.EOF Then
'                        .Cells(fl, 40) = oRsFac.Fields("Tipo comp.").Value
'                        .Cells(fl, 41) = oRsFac.Fields("Numero").Value
'                        .Cells(fl, 42) = oRsFac.Fields("Fecha comp.").Value
'                        .Cells(fl, 43) = oRsFac.Fields("Mon.").Value
'                        oEx.Cells(fl, 43).Select
'                        oEx.Selection.HorizontalAlignment = xlCenter
'                        .Cells(fl, 44) = oRsFac.Fields("Importe s/iva").Value
'                        oRsFac.MoveNext
'                     End If
'                     If Not oRsSal.EOF Then
'                        .Cells(fl, 46) = oRsSal.Fields("Nro. de salida").Value
'                        .Cells(fl, 47) = oRsSal.Fields("Fecha").Value
'                        .Cells(fl, 48) = oRsSal.Fields("Cant.").Value
'                        .Cells(fl, 49) = oRsSal.Fields("Un.").Value
'                        .Cells(fl, 50) = Format(oRsSal.Fields("Costo Un.").Value, "#,##0.00")
'                        .Cells(fl, 51) = Format(oRsSal.Fields("Costo Total").Value, "#,##0.00")
'                        oRsSal.MoveNext
'                     End If
'                     fl = fl + 1
'                  Loop
'               Else
'                  fl = fl + 1
'               End If
'
'               oRsPed.Close
'               Set oRsPed = Nothing
'               oRsRec.Close
'               Set oRsRec = Nothing
'               oRsFac.Close
'               Set oRsFac = Nothing
'               oRsSal.Close
'               Set oRsSal = Nothing
'
'            Next
'
'            Set oL = Nothing
'
'            oEx.Cells(1, 1).Select
'         End With
         oEx.Run "GenerarInforme", glbStringConexion, mTitulo, Lista.GetString
         If TipoSalida = 2 Then .Close False
      End With
      If TipoSalida = 2 Then .Quit
   End With
   Set oEx = Nothing

   For Each oL In Lista.ListItems: oL.Selected = False: Next
   
End Sub

Private Sub Editar(ByVal Identificador As Long, ByVal TipoComprobante As String)

   Dim oF As Form
      
   Select Case TipoComprobante
      Case "Acopio"
         Set oF = New frmAcopios
      Case "Pedido"
         Set oF = New frmPedidos
      Case "L.Materiales"
         Set oF = New frmLMateriales
      Case "R.M."
         Set oF = New frmRequerimientos
      Case "Comparativa"
         Set oF = New frmComparativa
      Case "Recepcion"
         Set oF = New frmRecepciones
      Case "ComprobanteProveedor"
         Set oF = New frmComprobantesPrv
      Case Else
         MsgBox "Comprobante no editable"
         GoTo Salida:
   End Select
   
   With oF
      .Id = Identificador
      If TipoComprobante = "R.M." Then
         oF.Password = mPassword
      End If
      .Disparar = ActL
      .cmd(0).Enabled = False
      .Show vbModal, Me
   End With

Salida:

   Set oF = Nothing

End Sub


